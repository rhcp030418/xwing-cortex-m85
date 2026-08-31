/* 실험 BK (K32): StateExtractBytes 교차 배치.  Slots 617..630.
 *   617..620  micro extract168  A B B A
 *   621..623 A / 624..626 B / 627..629 B / 630..632 A  full X-Wing (ABBA)
 * 사전등록: 2026-08-26_expBK_k32_extract_prereg.md */

#define EXPBK_SLOT_BASE 617u
#define EXPBK_BATCH 16u

volatile uint32_t k32_mode = 0u;
extern void KeccakF1600_StateExtractLanes_bk(uint64_t *s, uint8_t *d, unsigned lanes);

static uint32_t expbk_mm, expbk_checks;
static volatile uint32_t expbk_mode, expbk_slot;

/* §4.2 정확성: 무작위 200 상태 x (rate 168 / 136) 바이트 완전 일치 */
static void expbk_correct(void)
{
    uint64_t st[25];
    uint8_t a[SHAKE128_RATE], b[SHAKE128_RATE];
    uint32_t mm = 0, checks = 0, t, i;
    uint32_t x = 0x13579bdfu;
    for (t = 0; t < 200u; t++) {
        for (i = 0; i < 25u; i++) {
            x ^= x << 13; x ^= x >> 17; x ^= x << 5;
            st[i] = ((uint64_t) x << 32);
            x ^= x << 13; x ^= x >> 17; x ^= x << 5;
            st[i] |= x;
        }
        for (i = 0; i < 2u; i++) {
            const unsigned len = i ? 136u : 168u;
            KeccakF1600_StateExtractBytes(st, a, 0u, len);
            KeccakF1600_StateExtractLanes_bk(st, b, len >> 3);
            mm += byte_mismatches(a, b, len);
            checks++;
        }
    }
    expbk_mm = mm; expbk_checks = checks;
}

static shake128ctx expbk_st_seed;

static void expbk_micro(void)
{
    const uint32_t slot = expbk_slot;
    shake128ctx st;
    uint8_t buf[SHAKE128_RATE];
    for (uint32_t i = 0; i < 25u; i++) st.ctx[i] = expbk_st_seed.ctx[i];
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPBK_BATCH; i++) {
            if (expbk_mode) KeccakF1600_StateExtractLanes_bk(st.ctx, buf, SHAKE128_RATE >> 3);
            else            KeccakF1600_StateExtractBytes(st.ctx, buf, 0u, SHAKE128_RATE);
        }
        rep_cyc[slot][r] = dwt_span_end();
    }
    expbj_sink += buf[0];
}

static void expbk_full(void)
{
    const uint32_t slot = expbk_slot;
    uint32_t r;
    expal_set_modes(1u, 1u);
    k32_mode = expbk_mode;
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
    k32_mode = 0u;
}

static uint32_t expbk_xw_mm, expbk_xw_smoke, expbk_xw_rej;

static void expbk_equiv(void)
{
    uint32_t mm = 0, fails = 0, rej = 0;
    expal_set_modes(1u, 1u);
    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xd4440000u + s * 0x00009e37u;
        k32_mode = 0u;
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

        k32_mode = 1u;
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
        k32_mode = 0u;
    }
    expbk_xw_mm = mm; expbk_xw_smoke = fails; expbk_xw_rej = rej;
}

static void expbk_run_all(void)
{
    static const uint8_t ord[4] = {0, 1, 1, 0};
    uint32_t i;
    uint8_t seed[32];
    for (i = 0; i < 32u; i++) seed[i] = (uint8_t) (0x50u + i);
    shake128_absorb(&expbk_st_seed, seed, 32u);

    expaj_stack_prepare();
    run_on_stack(expbk_correct, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expBK extract-mm="); uart_put_u32(expbk_mm);
    uart_puts(" checks="); uart_put_u32(expbk_checks); uart_puts("\n");
    harness_fails += expbk_mm;

    run_on_stack(expbk_equiv, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expBK xw: bytes-mm="); uart_put_u32(expbk_xw_mm);
    uart_puts(" smoke="); uart_put_u32(expbk_xw_smoke);
    uart_puts(" reject-mm="); uart_put_u32(expbk_xw_rej); uart_puts("\n");
    harness_fails += expbk_xw_mm + expbk_xw_smoke + expbk_xw_rej;

    for (i = 0; i < 4u; i++) {
        expbk_mode = ord[i]; expbk_slot = EXPBK_SLOT_BASE + i;
        run_on_stack(expbk_micro, dtcm_stack + sizeof(dtcm_stack));
    }
    for (i = 0; i < 4u; i++) {
        expbk_mode = ord[i]; expbk_slot = EXPBK_SLOT_BASE + 4u + 3u * i;
        run_on_stack(expbk_full, dtcm_stack + sizeof(dtcm_stack));
    }
    uart_puts("expBK bench done\n");
}
