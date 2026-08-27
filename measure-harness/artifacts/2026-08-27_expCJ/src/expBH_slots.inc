/* 실험 BH (K31): libc memcpy/memset 워드 교체.  Slots 590..601.
 * 사전등록: 2026-08-26_expBH_k31_libc_prereg.md
 *   590..592  A keygen/encaps/decaps   593..595  B
 *   596..598  B                        599..601  A     (ABBA)
 * 별도로 k31_count_on 으로 호출 수·바이트 수(분모)를 센다. */

#define EXPBH_SLOT_BASE 590u

static volatile uint32_t expbh_mode;
static volatile uint32_t expbh_slot;
static uint32_t expbh_xw_mm, expbh_xw_smoke, expbh_xw_reject;
static uint32_t expbh_cnt[3][4];   /* [op][memcpy_calls, memcpy_bytes, memset_calls, memset_bytes] */

/* --- 분모: X-Wing 각 연산이 memcpy/memset 을 얼마나 부르는가 (probe) --- */
static void expbh_count(void)
{
    uint32_t op;
    expal_set_modes(1u, 1u);
    mlkem_x06_mode = 1u;
    k31_mode = 0u;
    PQCLEAN_randombytes_reset(0xa1ab5a5au);
    xwing_keypair(xw_pk, xw_sk);          /* 워밍업: 카운트 밖 */
    xwing_enc(xw_ct, xw_ss_e, xw_pk);
    for (op = 0; op < 3u; op++) {
        k31_memcpy_calls = 0u; k31_memcpy_bytes = 0u;
        k31_memset_calls = 0u; k31_memset_bytes = 0u;
        k31_count_on = 1u;
        if (op == 0u)      xwing_keypair(xw_pk, xw_sk);
        else if (op == 1u) xwing_enc(xw_ct, xw_ss_e, xw_pk);
        else               xwing_dec(xw_ss_d, xw_ct, xw_sk);
        k31_count_on = 0u;
        expbh_cnt[op][0] = k31_memcpy_calls; expbh_cnt[op][1] = k31_memcpy_bytes;
        expbh_cnt[op][2] = k31_memset_calls; expbh_cnt[op][3] = k31_memset_bytes;
    }
    mlkem_x06_mode = 0u;
}

/* --- 정확성: k31_mode 1 에서 full X-Wing 바이트 동일 + 암묵적 거부 동일 --- */
static void expbh_xwing_equiv(void)
{
    uint32_t mm = 0, fails = 0, rej = 0;
    expal_set_modes(1u, 1u);
    mlkem_x06_mode = 1u;
    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xb2220000u + s * 0x00009e37u;
        k31_mode = 0u;
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

        k31_mode = 1u;
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
        k31_mode = 0u;
    }
    mlkem_x06_mode = 0u;
    expbh_xw_mm = mm; expbh_xw_smoke = fails; expbh_xw_reject = rej;
}

static void expbh_full_run(void)
{
    const uint32_t slot = expbh_slot;
    uint32_t r;
    expal_set_modes(1u, 1u);
    mlkem_x06_mode = 1u;
    k31_mode = expbh_mode;
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
    k31_mode = 0u; mlkem_x06_mode = 0u;
}

static void expbh_run_all(void)
{
    static const uint8_t ord[4] = {0, 1, 1, 0};
    static const char *opn[3] = {"keygen", "encaps", "decaps"};
    uint32_t i;

    expaj_stack_prepare();
    run_on_stack(expbh_count, dtcm_stack + sizeof(dtcm_stack));
    for (i = 0; i < 3u; i++) {
        uart_puts("expBH cnt "); uart_puts(opn[i]);
        uart_puts(" memcpy-calls="); uart_put_u32(expbh_cnt[i][0]);
        uart_puts(" memcpy-bytes="); uart_put_u32(expbh_cnt[i][1]);
        uart_puts(" memset-calls="); uart_put_u32(expbh_cnt[i][2]);
        uart_puts(" memset-bytes="); uart_put_u32(expbh_cnt[i][3]);
        uart_puts("\n");
    }

    run_on_stack(expbh_xwing_equiv, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expBH xw: bytes-mm="); uart_put_u32(expbh_xw_mm);
    uart_puts(" smoke="); uart_put_u32(expbh_xw_smoke);
    uart_puts(" reject-mm="); uart_put_u32(expbh_xw_reject);
    uart_puts("\n");
    harness_fails += expbh_xw_mm + expbh_xw_smoke + expbh_xw_reject;

    for (i = 0; i < 4u; i++) {
        expbh_mode = ord[i]; expbh_slot = EXPBH_SLOT_BASE + 3u * i;
        run_on_stack(expbh_full_run, dtcm_stack + sizeof(dtcm_stack));
    }
    uart_puts("expBH bench done\n");
}
