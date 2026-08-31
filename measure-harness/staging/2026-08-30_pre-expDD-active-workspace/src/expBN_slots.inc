/* 실험 BN: fe25519_mul_sched full X-Wing 통합.  Slots 650..661.
 *   650..652 A / 653..655 B / 656..658 B / 659..661 A   (ABBA)
 * 사전등록: 2026-08-26_expBN_mulsched_integration_prereg.md */

#define EXPBN_SLOT_BASE 650u

volatile uint32_t x01_mode = 0u;

static volatile uint32_t expbn_mode, expbn_slot;
static uint32_t expbn_xw_mm, expbn_xw_smoke, expbn_xw_rej;

static void expbn_equiv(void)
{
    uint32_t mm = 0, fails = 0, rej = 0;
    expal_set_modes(1u, 1u);
    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xe5550000u + s * 0x00009e37u;
        x01_mode = 0u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk); xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) != 0);
        memcpy(xw_ref_pk, xw_pk, sizeof(xw_ref_pk));
        memcpy(xw_ref_sk, xw_sk, sizeof(xw_ref_sk));
        memcpy(xw_ref_ct, xw_ct, sizeof(xw_ref_ct));
        memcpy(xw_ref_ss_e, xw_ss_e, sizeof(xw_ref_ss_e));
        memcpy(xw_ref_ss_d, xw_ss_d, sizeof(xw_ref_ss_d));
        xw_ct[0] ^= 0x5au; xwing_dec(xw_ref_reject, xw_ct, xw_sk); xw_ct[0] ^= 0x5au;

        x01_mode = 1u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk); xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) != 0);
        mm += byte_mismatches(xw_pk, xw_ref_pk, sizeof(xw_ref_pk));
        mm += byte_mismatches(xw_sk, xw_ref_sk, sizeof(xw_ref_sk));
        mm += byte_mismatches(xw_ct, xw_ref_ct, sizeof(xw_ref_ct));
        mm += byte_mismatches(xw_ss_e, xw_ref_ss_e, sizeof(xw_ref_ss_e));
        mm += byte_mismatches(xw_ss_d, xw_ref_ss_d, sizeof(xw_ref_ss_d));
        xw_ct[0] ^= 0x5au; xwing_dec(xw_ss_d, xw_ct, xw_sk); xw_ct[0] ^= 0x5au;
        rej += byte_mismatches(xw_ss_d, xw_ref_reject, sizeof(xw_ref_reject));
        x01_mode = 0u;
    }
    expbn_xw_mm = mm; expbn_xw_smoke = fails; expbn_xw_rej = rej;
}

static void expbn_full(void)
{
    const uint32_t slot = expbn_slot;
    uint32_t r;
    expal_set_modes(1u, 1u);
    x01_mode = expbn_mode;
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
    x01_mode = 0u;
}

static void expbn_run_all(void)
{
    static const uint8_t ord[4] = {0, 1, 1, 0};
    uint32_t i;

    expaj_stack_prepare();
    run_on_stack(expbn_equiv, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expBN xw: bytes-mm="); uart_put_u32(expbn_xw_mm);
    uart_puts(" smoke="); uart_put_u32(expbn_xw_smoke);
    uart_puts(" reject-mm="); uart_put_u32(expbn_xw_rej); uart_puts("\n");
    harness_fails += expbn_xw_mm + expbn_xw_smoke + expbn_xw_rej;

    for (i = 0; i < 4u; i++) {
        expbn_mode = ord[i]; expbn_slot = EXPBN_SLOT_BASE + 3u * i;
        run_on_stack(expbn_full, dtcm_stack + sizeof(dtcm_stack));
    }
    uart_puts("expBN bench done\n");
}
