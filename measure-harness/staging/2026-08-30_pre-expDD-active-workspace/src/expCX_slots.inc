/* expCX: 고정 대 무작위 ciphertext 타이밍 검정 (dudect류, P1-9).
 * 사전등록: 2026-08-28_expCU_CV_CW_CX_prereg.md
 * 비밀키 고정. 클래스 0 = 유효 ct 고정, 클래스 1 = 무작위 바이트 ct.
 * v3: 무작위 ct 는 측정 전에 풀(32개)로 미리 만들고, 두 클래스 모두 같은 버퍼에 memcpy 로
 *     넣는다 — 측정 직전의 연산이 클래스와 무관하도록. test 0/1 = B warm/cold,
 *     test 2 = A(pqm4 scalar) warm 대조군.
 * run 1·2(다른 버퍼)와 run 3·4(같은 버퍼, randombytes 직전 호출)는 폐기·진단용. */

#define EXPCX_N 3000u
#define EXPCX_POOL 32u
#define EXPCX_TESTS 3u

volatile uint32_t expcx_samples[EXPCX_TESTS][2][EXPCX_N];
volatile uint32_t expcx_count[EXPCX_TESTS][2];
static uint8_t expcx_fixed_ct[D10_CTBYTES];
static uint8_t expcx_pool[EXPCX_POOL][D10_CTBYTES];   /* RAM */
static uint8_t expcx_ct[D10_CTBYTES];                 /* 두 클래스 공용 버퍼 */
static uint8_t expcx_sk[D10_SKBYTES];
static d10_expanded expcx_cache;
static uint32_t expcx_fixed_ok, expcx_prep_fail;
static uint8_t expcx_expect[32];

static void expcx_prepare(void)
{
    uint8_t pk[D10_PKBYTES], ss[32];
    expcx_prep_fail = 0u;
    d10_set_optimizations(1u);
    PQCLEAN_randombytes_reset(0xcdcd0002u);
    d10_keypair(pk, expcx_sk);
    d10_expand(&expcx_cache, expcx_sk);
    if (d10_enc(expcx_fixed_ct, expcx_expect, pk) != 0) expcx_prep_fail++;
    d10_dec_expanded(ss, expcx_fixed_ct, &expcx_cache);
    expcx_prep_fail += byte_mismatches(ss, expcx_expect, 32);
    for (uint32_t i = 0; i < EXPCX_POOL; i++)
        (void) PQCLEAN_randombytes(expcx_pool[i], D10_CTBYTES);
    d10_set_optimizations(0u);
}

static void expcx_run_test(uint32_t test)
{
    uint8_t ss[32], cls;
    uint32_t pool_i = 0u;
    expcx_count[test][0] = 0u;
    expcx_count[test][1] = 0u;
    expcx_fixed_ok = 0u;
    d10_set_optimizations(test == 2u ? 0u : 1u);
    PQCLEAN_randombytes_reset(0xcdcd0100u + test);
    while (expcx_count[test][0] < EXPCX_N || expcx_count[test][1] < EXPCX_N) {
        (void) PQCLEAN_randombytes(&cls, 1);
        cls &= 1u;
        if (expcx_count[test][cls] >= EXPCX_N) cls ^= 1u;
        /* 두 클래스 모두 같은 연산(memcpy)으로 같은 버퍼를 채운다. */
        memcpy(expcx_ct, cls ? expcx_pool[pool_i] : expcx_fixed_ct, D10_CTBYTES);
        if (cls) pool_i = (pool_i + 1u) % EXPCX_POOL;
        uint32_t cyc;
        if (test == 1u) {
            dwt_span_begin(); d10_dec_cold(ss, expcx_ct, expcx_sk);
            cyc = dwt_span_end();
        } else {
            dwt_span_begin(); d10_dec_expanded(ss, expcx_ct, &expcx_cache);
            cyc = dwt_span_end();
        }
        expcx_samples[test][cls][expcx_count[test][cls]++] = cyc;
        if (!cls) expcx_fixed_ok += (memcmp(ss, expcx_expect, 32) == 0);
    }
    d10_set_optimizations(0u);
}

static void expcx_test_warm(void) { expcx_run_test(0u); }
static void expcx_test_cold(void) { expcx_run_test(1u); }
static void expcx_test_warm_a(void) { expcx_run_test(2u); }

static void expcx_run_all(void)
{
    expaj_stack_prepare();
    run_on_stack(expcx_prepare, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expCX prep-fail="); uart_put_u32(expcx_prep_fail); uart_puts("\n");
    harness_fails += expcx_prep_fail;

    run_on_stack(expcx_test_warm, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expCX B-warm fixed-ok="); uart_put_u32(expcx_fixed_ok); uart_puts("\n");
    harness_fails += (expcx_fixed_ok != EXPCX_N);
    run_on_stack(expcx_test_cold, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expCX B-cold fixed-ok="); uart_put_u32(expcx_fixed_ok); uart_puts("\n");
    harness_fails += (expcx_fixed_ok != EXPCX_N);
    run_on_stack(expcx_test_warm_a, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expCX A-warm fixed-ok="); uart_put_u32(expcx_fixed_ok); uart_puts("\n");
    harness_fails += (expcx_fixed_ok != EXPCX_N);

    expaj_stack_check();
    uart_puts("expCX stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_stack_canary_fails;
}
