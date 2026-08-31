/* expCW: decaps 8-seed 순환 (P1-6). 사전등록: 2026-08-28_expCU_CV_CW_CX_prereg.md
 * 8개 (sk, ct) 쌍을 반복마다 순환. 캐시·ct 는 DTCM 예산 때문에 RAM(.bss) —
 * 절대값을 tab:cumulative(DTCM) 와 섞지 말 것. [A,B,B,A] x {warm, cold}. 슬롯 966..973. */

#define EXPCW_SLOT_BASE 966u
#define EXPCW_KEYS 8u

static d10_expanded expcw_cache[EXPCW_KEYS];          /* RAM */
static uint8_t expcw_sk[EXPCW_KEYS][D10_SKBYTES];     /* RAM */
static uint8_t expcw_ct[EXPCW_KEYS][D10_CTBYTES];     /* RAM */
static uint8_t expcw_expect[EXPCW_KEYS][32];          /* A 로 계산한 기대 ss */
static uint32_t expcw_mismatch, expcw_prep_fail;
static volatile uint32_t expcw_mode, expcw_slot;

static void expcw_prepare(void)
{
    uint8_t ss_e[32], pk[D10_PKBYTES];
    expcw_prep_fail = 0u;
    d10_set_optimizations(0u);
    PQCLEAN_randombytes_reset(0xcdcd0001u);
    for (uint32_t k = 0; k < EXPCW_KEYS; k++) {
        d10_keypair(pk, expcw_sk[k]);
        d10_expand(&expcw_cache[k], expcw_sk[k]);
        if (d10_enc(expcw_ct[k], ss_e, pk) != 0) expcw_prep_fail++;
        memcpy(expcw_expect[k], ss_e, 32);
        /* 기대값이 A 의 decaps 와도 일치하는지 확인 */
        d10_dec_expanded(ss_e, expcw_ct[k], &expcw_cache[k]);
        expcw_prep_fail += byte_mismatches(ss_e, expcw_expect[k], 32);
    }
}

static void expcw_bench_cell(void)
{
    uint8_t ss[32];
    const uint32_t slot = expcw_slot;

    d10_set_optimizations(expcw_mode);
    for (uint32_t r = 0; r < REP_N; r++) {
        const uint32_t k = r % EXPCW_KEYS;
        dwt_span_begin(); d10_dec_expanded(ss, expcw_ct[k], &expcw_cache[k]);
        rep_cyc[slot][r] = dwt_span_end();
        expcw_mismatch += byte_mismatches(ss, expcw_expect[k], 32);
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        const uint32_t k = r % EXPCW_KEYS;
        dwt_span_begin(); d10_dec_cold(ss, expcw_ct[k], expcw_sk[k]);
        rep_cyc[slot + 1u][r] = dwt_span_end();
        expcw_mismatch += byte_mismatches(ss, expcw_expect[k], 32);
    }
    d10_set_optimizations(0u);
}

static void expcw_run_all(void)
{
    static const uint8_t order[4] = {0u, 1u, 1u, 0u};
    expcw_mismatch = 0u;
    expaj_stack_prepare();
    run_on_stack(expcw_prepare, dtcm_stack + sizeof(dtcm_stack));
    for (uint32_t i = 0; i < 4u; i++) {
        expcw_mode = order[i];
        expcw_slot = EXPCW_SLOT_BASE + 2u * i;
        run_on_stack(expcw_bench_cell, dtcm_stack + sizeof(dtcm_stack));
    }
    expaj_stack_check();
    uart_puts("expCW prep-fail="); uart_put_u32(expcw_prep_fail);
    uart_puts(" mismatch="); uart_put_u32(expcw_mismatch);
    uart_puts(" stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expcw_prep_fail + expcw_mismatch + expaj_stack_canary_fails;
}
