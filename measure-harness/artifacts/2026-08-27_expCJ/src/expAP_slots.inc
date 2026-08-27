/* Experiment AP: ML-KEM 비-Keccak 내부 재귀속.  Slots 390..419.
 *
 * 목적: expAO 가 남긴 마지막 큰 미측정 블록 — ML-KEM 비-Keccak 잔여
 * (keygen 168k / encaps 160k / decaps 193k, X-Wing 의 14.0~23.7%) 의 내부 세분.
 * Z2(2026-08-21)는 C8/C9 채택 이전 코드의 값이라 그대로 쓸 수 없다.
 *
 * 방법: poly.c / matacc.c / verify.c 의 대상 함수를 `ap_inner_*` 로 rename 하고
 * 같은 이름의 얇은 wrapper 를 붙였다(호출 지점은 하나도 건드리지 않았다).
 * 모든 bucket 은 **Keccak 을 뺀 값**이다 — expAO 의 g_keccak_perm_cyc 누산기로
 * 창 안에서 실제로 든 permutation cycle 을 그대로 차감한다. Z2 가 했던
 * "perms x 5,526 을 빼는" 간접 보정이 필요 없다.
 *
 * bucket: 0 NTT · 1 invNTT · 2 matacc · 3 basemul/frombytes-mul · 4 noise(CBD)
 *         5 packing/compress · 6 arith(reduce/add/sub/fromplant) · 7 verify/cmov
 *
 * 슬롯 배치 (연산당 10)
 *   +0      total (prof off)
 *   +1      total (prof on)
 *   +2..+9  bucket 0..7 누산 cycle
 *   keygen 390.. / encaps 400.. / decaps 410..
 */

#define EXPAP_SLOT_BASE 390u

volatile uint32_t ap_enable;
volatile uint32_t ap_cyc[AP_NBUCKET];
volatile uint32_t ap_calls[AP_NBUCKET];

volatile uint32_t expap_byte_mismatch = 9;
volatile uint32_t expap_checks = 0;

/* 계측용 비교 버퍼는 expAO 것을 재사용한다 (DTCM 예산 절약, 값 비교 전용) */
#define expap_pk   expao_pk
#define expap_sk   expao_sk
#define expap_ct   expao_ct
#define expap_ss_e expao_ss_e
#define expap_ss_d expao_ss_d

static void expap_reset(void)
{
    for (uint32_t i = 0; i < AP_NBUCKET; i++) {
        ap_cyc[i] = 0u;
        ap_calls[i] = 0u;
    }
    g_keccak_perm_cyc = 0u;
    g_keccak_perm_calls = 0u;
}

static void expap_store(uint32_t slot)
{
    for (uint32_t i = 0; i < 8u; i++) {   /* expAP 는 bucket 0..7 만 (8,9 는 expAQ) */
        rep_cyc[slot + i][0] += ap_cyc[i];
        rep_cyc[slot + i][1] += ap_calls[i];
    }
}

/* probe on 이 출력에 영향을 주지 않는가 */
static void expap_equivalence(void)
{
    uint32_t mismatch = 0;
    uint32_t checks = 0;

    expal_set_modes(1u, 1u);

    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xa1110000u + s * 0x00009e37u;

        ap_enable = 0u; g_keccak_prof_enable = 0u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk);
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);

        ap_enable = 1u; g_keccak_prof_enable = 1u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(expap_pk, expap_sk);
        xwing_enc(expap_ct, expap_ss_e, expap_pk);
        xwing_dec(expap_ss_d, expap_ct, expap_sk);
        ap_enable = 0u; g_keccak_prof_enable = 0u;

        mismatch += byte_mismatches(expap_pk, xw_pk, sizeof(expap_pk));
        mismatch += byte_mismatches(expap_sk, xw_sk, sizeof(expap_sk));
        mismatch += byte_mismatches(expap_ct, xw_ct, sizeof(expap_ct));
        mismatch += byte_mismatches(expap_ss_e, xw_ss_e, sizeof(expap_ss_e));
        mismatch += byte_mismatches(expap_ss_d, xw_ss_d, sizeof(expap_ss_d));
        checks += 5u;
    }

    expap_byte_mismatch = mismatch;
    expap_checks = checks;
}

static void bench_expap_reps(void)
{
    const uint32_t b = EXPAP_SLOT_BASE;
    uint32_t r, i;

    expal_set_modes(1u, 1u);

    /* bucket 누산은 rep 마다 리셋하고 슬롯 [0]/[1] 에 합산한다.
     * (rep 별 분포가 아니라 REP_N 합계를 보므로 슬롯 2칸만 쓴다) */
    for (i = 0; i < 3u * 10u; i++) { rep_cyc[b + i][0] = 0u; rep_cyc[b + i][1] = 0u; }

    /* ---- prof off ---- */
    ap_enable = 0u; g_keccak_prof_enable = 0u;
    PQCLEAN_randombytes_reset(0xa1ab5a5au);
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_keypair(xw_pk, xw_sk);
        rep_cyc[b + 0u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[b + 10u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[b + 20u][r] = dwt_span_end();
    }

    /* ---- prof on: 같은 시드 stream 을 처음부터 ---- */
    ap_enable = 1u; g_keccak_prof_enable = 1u;
    PQCLEAN_randombytes_reset(0xa1ab5a5au);

    for (r = 0; r < REP_N; r++) {
        expap_reset();
        dwt_span_begin();
        xwing_keypair(xw_pk, xw_sk);
        rep_cyc[b + 1u][r] = dwt_span_end();
        expap_store(b + 2u);
    }
    for (r = 0; r < REP_N; r++) {
        expap_reset();
        dwt_span_begin();
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[b + 11u][r] = dwt_span_end();
        expap_store(b + 12u);
    }
    for (r = 0; r < REP_N; r++) {
        expap_reset();
        dwt_span_begin();
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[b + 21u][r] = dwt_span_end();
        expap_store(b + 22u);
    }

    ap_enable = 0u; g_keccak_prof_enable = 0u;
}

static void expap_run_all(void)
{
    expaj_stack_prepare();
    run_on_stack(expap_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAP equiv: bytes-mm="); uart_put_u32(expap_byte_mismatch);
    uart_puts(" checks="); uart_put_u32(expap_checks);
    uart_puts("\n");
    harness_fails += expap_byte_mismatch;

    run_on_stack(bench_expap_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_stack_check();
    uart_puts("expAP bench: stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_stack_canary_fails;

    expal_set_modes(0, 0);
}
