/* 실험 BS (K21): matrix-XOF x4 배칭 재판정.  Slots 666..677.
 *   666..668 A(x4 off) / 669..671 B(x4 on) / 672..674 B / 675..677 A   (ABBA)
 * 사전등록: 2026-08-26_expBS_k21_keccakx4_prereg.md */

#define EXPBS_SLOT_BASE 666u

static volatile uint32_t expbs_mode, expbs_slot;
static uint32_t expbs_xw_mm, expbs_xw_smoke, expbs_xw_rej;

static void expbs_equiv(void)
{
    uint32_t mm = 0, fails = 0, rej = 0;
    expal_set_modes(1u, 1u);
    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xf6660000u + s * 0x00009e37u;
        mlkem_keccakx4_mode = 0u;
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

        mlkem_keccakx4_mode = 1u;
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
        mlkem_keccakx4_mode = 0u;
    }
    expbs_xw_mm = mm; expbs_xw_smoke = fails; expbs_xw_rej = rej;
}

static void expbs_full(void)
{
    const uint32_t slot = expbs_slot;
    uint32_t r;
    expal_set_modes(1u, 1u);
    mlkem_keccakx4_mode = expbs_mode;
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
    mlkem_keccakx4_mode = 0u;
}

static void expbs_run_all(void)
{
    static const uint8_t ord[4] = {0, 1, 1, 0};
    uint32_t i;

    expaj_stack_prepare();
    run_on_stack(expbs_equiv, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expBS xw: bytes-mm="); uart_put_u32(expbs_xw_mm);
    uart_puts(" smoke="); uart_put_u32(expbs_xw_smoke);
    uart_puts(" reject-mm="); uart_put_u32(expbs_xw_rej); uart_puts("\n");
    harness_fails += expbs_xw_mm + expbs_xw_smoke + expbs_xw_rej;

    for (i = 0; i < 4u; i++) {
        expbs_mode = ord[i]; expbs_slot = EXPBS_SLOT_BASE + 3u * i;
        run_on_stack(expbs_full, dtcm_stack + sizeof(dtcm_stack));
    }
    uart_puts("expBS bench done\n");
}
