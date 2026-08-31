/* 실험 BI: 채택 빌드 대표값.  Slots 602..607.
 *   602..604  1차 keygen/encaps/decaps
 *   605..607  2차 (같은 판 안 배치 안정성 확인)
 * 토글이 제거됐으므로 A/B 가 아니라 절대값 측정이다. */

#define EXPBI_SLOT_BASE 602u

static volatile uint32_t expbi_slot;

static void expbi_run(void)
{
    const uint32_t slot = expbi_slot;
    uint32_t r;
    expal_set_modes(1u, 1u);
    PQCLEAN_randombytes_reset(0xa1ab5a5au);
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin(); xwing_keypair(xw_pk, xw_sk);
        rep_cyc[slot][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin(); xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[slot + 1u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin(); xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[slot + 2u][r] = dwt_span_end();
    }
}

static uint32_t expbi_smoke;

static void expbi_correct(void)
{
    uint32_t fails = 0, rej = 0;
    expal_set_modes(1u, 1u);
    for (uint32_t s = 0; s < 8u; s++) {
        PQCLEAN_randombytes_reset(0xc3330000u + s * 0x00009e37u);
        xwing_keypair(xw_pk, xw_sk);
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) != 0);
        xw_ct[0] ^= 0x5au;
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        xw_ct[0] ^= 0x5au;
        rej += (memcmp(xw_ss_e, xw_ss_d, 32) == 0);   /* 거부인데 같으면 오류 */
    }
    expbi_smoke = fails + rej;
}

static void expbi_run_all(void)
{
    uint32_t i;
    expaj_stack_prepare();
    run_on_stack(expbi_correct, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expBI smoke="); uart_put_u32(expbi_smoke); uart_puts("\n");
    harness_fails += expbi_smoke;
    for (i = 0; i < 2u; i++) {
        expbi_slot = EXPBI_SLOT_BASE + 3u * i;
        run_on_stack(expbi_run, dtcm_stack + sizeof(dtcm_stack));
    }
    uart_puts("expBI bench done\n");
}
