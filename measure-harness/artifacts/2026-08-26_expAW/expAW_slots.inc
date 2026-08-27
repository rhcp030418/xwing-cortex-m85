/* Experiment AW (= AT-3): X06 fixed-base 를 X-Wing wrapper 에 실제로 넣고 full A/B.
 *
 * 사전등록: A주제/measure-harness/2026-08-26_expAV_x06_native_prereg.md §9 (AT-3),
 * gate 는 2026-08-25_expAT_x06_fixedbase_prereg.md §8.1 AT-3 을 계승한다.
 *   - keygen·encaps 중 하나라도 회귀하면 채택 금지
 *   - decaps 는 적용 지점이 없으므로 ±0.3% 이내여야 한다(넘으면 배치 교란 의심)
 *
 * A = mlkem_x06_mode 0 (현행 ladder), B = 1 (comb).  ABBA, 각 셀 keygen/encaps/decaps.
 *
 * 슬롯 배치 (셀당 3, ABBA 4 셀 = 12)
 *   502..504  A(AB)   505..507  B(AB)   508..510  B(BA)   511..513  A(BA)
 */

#define EXPAW_SLOT_BASE 502u

extern volatile uint32_t mlkem_x06_mode;

volatile uint32_t expaw_byte_mismatch = 9;   /* B 출력이 A 와 바이트 동일한가 */
volatile uint32_t expaw_smoke_fails = 9;     /* ss_e == ss_d */
volatile uint32_t expaw_reject_mm = 9;       /* 암묵적 거부 경로 */
volatile uint32_t expaw_checks = 0;

static void expaw_equivalence(void)
{
    uint32_t mismatch = 0, fails = 0, rej = 0, checks = 0;

    expal_set_modes(1u, 1u);

    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xa1110000u + s * 0x00009e37u;

        mlkem_x06_mode = 0u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk);
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) != 0);
        memcpy(xw_ref_pk, xw_pk, sizeof(xw_ref_pk));
        memcpy(xw_ref_sk, xw_sk, sizeof(xw_ref_sk));
        memcpy(xw_ref_ct, xw_ct, sizeof(xw_ref_ct));
        memcpy(xw_ref_ss_e, xw_ss_e, sizeof(xw_ref_ss_e));
        memcpy(xw_ref_ss_d, xw_ss_d, sizeof(xw_ref_ss_d));
        xw_ct[0] ^= 0x5au;
        xwing_dec(xw_ref_reject, xw_ct, xw_sk);
        xw_ct[0] ^= 0x5au;

        mlkem_x06_mode = 1u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk);
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) != 0);

        mismatch += byte_mismatches(xw_pk, xw_ref_pk, sizeof(xw_ref_pk));
        mismatch += byte_mismatches(xw_sk, xw_ref_sk, sizeof(xw_ref_sk));
        mismatch += byte_mismatches(xw_ct, xw_ref_ct, sizeof(xw_ref_ct));
        mismatch += byte_mismatches(xw_ss_e, xw_ref_ss_e, sizeof(xw_ref_ss_e));
        mismatch += byte_mismatches(xw_ss_d, xw_ref_ss_d, sizeof(xw_ref_ss_d));
        checks += 5u;

        xw_ct[0] ^= 0x5au;
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        xw_ct[0] ^= 0x5au;
        rej += byte_mismatches(xw_ss_d, xw_ref_reject, sizeof(xw_ref_reject));
        checks += 1u;

        mlkem_x06_mode = 0u;
    }

    expaw_byte_mismatch = mismatch;
    expaw_smoke_fails = fails;
    expaw_reject_mm = rej;
    expaw_checks = checks;
}

static volatile uint32_t expaw_mode;
static volatile uint32_t expaw_slot;

static void expaw_bench_run(void)
{
    const uint32_t slot = expaw_slot;
    uint32_t r;

    expal_set_modes(1u, 1u);
    mlkem_x06_mode = expaw_mode;
    PQCLEAN_randombytes_reset(0xa1ab5a5au);

    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_keypair(xw_pk, xw_sk);
        rep_cyc[slot][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[slot + 1u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[slot + 2u][r] = dwt_span_end();
    }
    mlkem_x06_mode = 0u;
}

static void expaw_run_all(void)
{
    const uint32_t b = EXPAW_SLOT_BASE;
    static const uint8_t ord[4] = {0, 1, 1, 0};
    uint32_t i;

    expaj_stack_prepare();
    run_on_stack(expaw_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAW equiv: bytes-mm="); uart_put_u32(expaw_byte_mismatch);
    uart_puts(" smoke-fails="); uart_put_u32(expaw_smoke_fails);
    uart_puts(" reject-mm="); uart_put_u32(expaw_reject_mm);
    uart_puts(" checks="); uart_put_u32(expaw_checks);
    uart_puts("\n");
    harness_fails += expaw_byte_mismatch + expaw_smoke_fails + expaw_reject_mm;

    for (i = 0; i < 4u; i++) {
        expaw_mode = ord[i];
        expaw_slot = b + 3u * i;
        run_on_stack(expaw_bench_run, dtcm_stack + sizeof(dtcm_stack));
    }

    expaj_stack_check();
    uart_puts("expAW bench: stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_stack_canary_fails;

    expal_set_modes(0, 0);
}
