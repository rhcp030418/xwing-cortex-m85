/* Experiment AO: X-Wing 내 Keccak permutation in-context 실측.  Slots 376..389.
 *
 * 목적: expAN §5 는 "perms 실측 × keccak-f1600 단독 5,504 cyc" 라는 투영으로
 * Keccak 이 ML-KEM 의 54.5~58.8% 라고 했다. 그 곱은 투영이지 실측이 아니다.
 * 이 실험은 permutation 이 실제 X-Wing 실행 문맥(cache/ITCM/주변 코드 상태)에서
 * 몇 cycle 을 쓰는지 직접 누산한다.
 *
 * 방법: fips202.c 의 기존 셈 shim `KeccakF1600_StatePermute_counted` 에 누산기를
 * 붙였다. g_keccak_prof_enable=0 이면 기존과 완전히 같은 경로다.
 *
 * probe 왜곡 통제: 같은 연산을 prof off / prof on 두 번 재고 total 차이를 보고한다.
 * 이 차이가 probe 가 실행 경로에 실제로 얹은 비용이며, 누산값에서 빼지 않고 함께
 * 보고한다(AM1b §2 의 "오버헤드는 추정하지 말고 직접 재라" 원칙).
 *
 * 슬롯 배치
 *   376 keygen total (prof off)     380 encaps total (prof off)   384 decaps total (prof off)
 *   377 keygen total (prof on)      381 encaps total (prof on)     385 decaps total (prof on)
 *   378 keygen keccak cyc           382 encaps keccak cyc          386 decaps keccak cyc
 *   379 keygen keccak calls         383 encaps keccak calls        387 decaps keccak calls
 *   388 combiner 단독 total (prof on)
 *   389 combiner 단독 keccak cyc
 */

#define EXPAO_SLOT_BASE 376u

extern volatile uint32_t g_keccak_perm_cyc;
extern volatile uint32_t g_keccak_prof_enable;

volatile uint32_t expao_byte_mismatch = 9;   /* prof on 출력 대 prof off 출력 */
volatile uint32_t expao_checks = 0;

static uint8_t expao_pk[XWING_PUBLICKEYBYTES]  __attribute__((section(".dtcm")));
static uint8_t expao_sk[XWING_SECRETKEYBYTES]  __attribute__((section(".dtcm")));
static uint8_t expao_ct[XWING_CIPHERTEXTBYTES] __attribute__((section(".dtcm")));
static uint8_t expao_ss_e[32] __attribute__((section(".dtcm")));
static uint8_t expao_ss_d[32] __attribute__((section(".dtcm")));

/* prof on 이 출력에 영향을 주지 않는가 (타이밍 전용이어야 한다) */
static void expao_equivalence(void)
{
    uint32_t mismatch = 0;
    uint32_t checks = 0;

    expal_set_modes(1u, 1u);

    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xa1110000u + s * 0x00009e37u;

        g_keccak_prof_enable = 0u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk);
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);

        g_keccak_prof_enable = 1u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(expao_pk, expao_sk);
        xwing_enc(expao_ct, expao_ss_e, expao_pk);
        xwing_dec(expao_ss_d, expao_ct, expao_sk);
        g_keccak_prof_enable = 0u;

        mismatch += byte_mismatches(expao_pk, xw_pk, sizeof(expao_pk));
        mismatch += byte_mismatches(expao_sk, xw_sk, sizeof(expao_sk));
        mismatch += byte_mismatches(expao_ct, xw_ct, sizeof(expao_ct));
        mismatch += byte_mismatches(expao_ss_e, xw_ss_e, sizeof(expao_ss_e));
        mismatch += byte_mismatches(expao_ss_d, xw_ss_d, sizeof(expao_ss_d));
        checks += 5u;
    }

    expao_byte_mismatch = mismatch;
    expao_checks = checks;
}

static void bench_expao_reps(void)
{
    const uint32_t b = EXPAO_SLOT_BASE;
    uint32_t r;

    expal_set_modes(1u, 1u);

    /* ---- prof off: expAN 과 같은 조건의 기준선 ---- */
    g_keccak_prof_enable = 0u;
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

    /* ---- prof on: 같은 시드 stream 을 처음부터 다시 ---- */
    g_keccak_prof_enable = 1u;
    PQCLEAN_randombytes_reset(0xa1ab5a5au);
    for (r = 0; r < REP_N; r++) {
        g_keccak_perm_cyc = 0u;
        g_keccak_perm_calls = 0u;
        dwt_span_begin();
        xwing_keypair(xw_pk, xw_sk);
        rep_cyc[b + 1u][r] = dwt_span_end();
        rep_cyc[b + 2u][r] = g_keccak_perm_cyc;
        rep_cyc[b + 3u][r] = g_keccak_perm_calls;
    }
    for (r = 0; r < REP_N; r++) {
        g_keccak_perm_cyc = 0u;
        g_keccak_perm_calls = 0u;
        dwt_span_begin();
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[b + 5u][r] = dwt_span_end();
        rep_cyc[b + 6u][r] = g_keccak_perm_cyc;
        rep_cyc[b + 7u][r] = g_keccak_perm_calls;
    }
    for (r = 0; r < REP_N; r++) {
        g_keccak_perm_cyc = 0u;
        g_keccak_perm_calls = 0u;
        dwt_span_begin();
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[b + 9u][r] = dwt_span_end();
        rep_cyc[b + 10u][r] = g_keccak_perm_cyc;
        rep_cyc[b + 11u][r] = g_keccak_perm_calls;
    }

    /* ---- combiner 단독: X-Wing 134B SHA3-256 한 번의 permutation 몫 ---- */
    for (r = 0; r < REP_N; r++) {
        g_keccak_perm_cyc = 0u;
        g_keccak_perm_calls = 0u;
        dwt_span_begin();
        xwing_combine(xw_ss_e, xw_ss_d, xw_ss_d,
                      xw_ct + CRYPTO_CIPHERTEXTBYTES,
                      xw_sk + CRYPTO_SECRETKEYBYTES + 32);
        rep_cyc[b + 12u][r] = dwt_span_end();
        rep_cyc[b + 13u][r] = g_keccak_perm_cyc;
    }

    g_keccak_prof_enable = 0u;
}

static void expao_run_all(void)
{
    expaj_stack_prepare();
    run_on_stack(expao_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAO equiv: bytes-mm="); uart_put_u32(expao_byte_mismatch);
    uart_puts(" checks="); uart_put_u32(expao_checks);
    uart_puts("\n");
    harness_fails += expao_byte_mismatch;

    run_on_stack(bench_expao_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_stack_check();
    uart_puts("expAO bench: stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_stack_canary_fails;

    expal_set_modes(0, 0);
}
