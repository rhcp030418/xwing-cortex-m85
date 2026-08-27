/* Experiment AR: X25519 field-op in-context 귀속.  Slots 435..446.
 *
 * 목적: X-Wing 의 62.8%(encaps)가 X25519 인데, 그 내부 mul/sqr 비중 76.0% 는 expAM1b 의
 * **투영**이다 — 호출 수는 소스에서 손으로 센 정적 값(mul 1,287 / sqr 1,274)이고 단가는
 * 별도 벤치 루프 값이며, 둘의 곱은 실측이 아니다. expAO 가 Keccak 투영을 실측으로 확인한
 * 것과 같은 검증을 X25519 는 아직 못 받았다.
 *
 * 방법: `fe25519_mul` / `fe25519_sqr` 정의를 `apx_real_*` 로 rename 하고 같은 이름의 asm
 * wrapper(`gen/expAR_x25519_probe.S`)를 두었다. 래더의 모든 `bl` 과 `fe25519_sqr_many`
 * 내부 루프가 wrapper 를 탄다. wrapper 는 r10/r11/r12 만 쓰고 r0-r7 은 건드리지 않는다.
 *
 * 슬롯 배치 (연산당 4)
 *   +0 total (prof off)   +1 total (prof on)
 *   +2 mul  ([0]=cycle 합, [1]=call 합)
 *   +3 sqr  ([0]=cycle 합, [1]=call 합)
 *   keygen 435.. / encaps 439.. / decaps 443..
 */

#define EXPAR_SLOT_BASE 435u

volatile uint32_t apx_enable;
volatile uint32_t apx_start;
volatile uint32_t apx_cyc_mul;
volatile uint32_t apx_cnt_mul;
volatile uint32_t apx_cyc_sqr;
volatile uint32_t apx_cnt_sqr;

volatile uint32_t expar_byte_mismatch = 9;
volatile uint32_t expar_checks = 0;

static void expar_reset(void)
{
    apx_cyc_mul = 0u; apx_cnt_mul = 0u;
    apx_cyc_sqr = 0u; apx_cnt_sqr = 0u;
}

static void expar_store(uint32_t slot)
{
    rep_cyc[slot + 0u][0] += apx_cyc_mul;
    rep_cyc[slot + 0u][1] += apx_cnt_mul;
    rep_cyc[slot + 1u][0] += apx_cyc_sqr;
    rep_cyc[slot + 1u][1] += apx_cnt_sqr;
}

static void expar_equivalence(void)
{
    uint32_t mismatch = 0;
    uint32_t checks = 0;

    expal_set_modes(1u, 1u);

    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xa1110000u + s * 0x00009e37u;

        apx_enable = 0u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk);
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);

        apx_enable = 1u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(expao_pk, expao_sk);
        xwing_enc(expao_ct, expao_ss_e, expao_pk);
        xwing_dec(expao_ss_d, expao_ct, expao_sk);
        apx_enable = 0u;

        mismatch += byte_mismatches(expao_pk, xw_pk, sizeof(expao_pk));
        mismatch += byte_mismatches(expao_sk, xw_sk, sizeof(expao_sk));
        mismatch += byte_mismatches(expao_ct, xw_ct, sizeof(expao_ct));
        mismatch += byte_mismatches(expao_ss_e, xw_ss_e, sizeof(expao_ss_e));
        mismatch += byte_mismatches(expao_ss_d, xw_ss_d, sizeof(expao_ss_d));
        checks += 5u;
    }

    expar_byte_mismatch = mismatch;
    expar_checks = checks;
}

static void bench_expar_reps(void)
{
    const uint32_t b = EXPAR_SLOT_BASE;
    uint32_t r, i;

    expal_set_modes(1u, 1u);
    for (i = 0; i < 3u * 4u; i++) { rep_cyc[b + i][0] = 0u; rep_cyc[b + i][1] = 0u; }

    apx_enable = 0u;
    PQCLEAN_randombytes_reset(0xa1ab5a5au);
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_keypair(xw_pk, xw_sk);
        rep_cyc[b + 0u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[b + 4u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[b + 8u][r] = dwt_span_end();
    }

    apx_enable = 1u;
    PQCLEAN_randombytes_reset(0xa1ab5a5au);
    for (r = 0; r < REP_N; r++) {
        expar_reset();
        dwt_span_begin();
        xwing_keypair(xw_pk, xw_sk);
        rep_cyc[b + 1u][r] = dwt_span_end();
        expar_store(b + 2u);
    }
    for (r = 0; r < REP_N; r++) {
        expar_reset();
        dwt_span_begin();
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[b + 5u][r] = dwt_span_end();
        expar_store(b + 6u);
    }
    for (r = 0; r < REP_N; r++) {
        expar_reset();
        dwt_span_begin();
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[b + 9u][r] = dwt_span_end();
        expar_store(b + 10u);
    }

    apx_enable = 0u;
}

static void expar_run_all(void)
{
    expaj_stack_prepare();
    run_on_stack(expar_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAR equiv: bytes-mm="); uart_put_u32(expar_byte_mismatch);
    uart_puts(" checks="); uart_put_u32(expar_checks);
    uart_puts("\n");
    harness_fails += expar_byte_mismatch;

    run_on_stack(bench_expar_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_stack_check();
    uart_puts("expAR bench: stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_stack_canary_fails;

    expal_set_modes(0, 0);
}
