/* Experiment BC (= BB-2): X02 재스케줄 sqr 을 full X-Wing 에 넣고 A/B.  Slots 554..565.
 * X06 은 켠 상태(현행 채택 경로)에서 x02_mode 만 토글한다.
 *   554..556 A(AB)  557..559 B(AB)  560..562 B(BA)  563..565 A(BA)
 */
#define EXPBC_SLOT_BASE 554u

volatile uint32_t x02_mode;

volatile uint32_t expbc_byte_mismatch = 9;
volatile uint32_t expbc_smoke_fails = 9;
volatile uint32_t expbc_reject_mm = 9;
volatile uint32_t expbc_checks = 0;

static void expbc_equivalence(void)
{
    uint32_t mismatch = 0, fails = 0, rej = 0, checks = 0;
    expal_set_modes(1u, 1u);
    mlkem_x06_mode = 1u;

    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xa1110000u + s * 0x00009e37u;
        x02_mode = 0u;
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

        x02_mode = 1u;
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
        x02_mode = 0u;
    }
    mlkem_x06_mode = 0u;
    expbc_byte_mismatch = mismatch;
    expbc_smoke_fails = fails;
    expbc_reject_mm = rej;
    expbc_checks = checks;
}

static volatile uint32_t expbc_mode;
static volatile uint32_t expbc_slot;

static void expbc_bench_run(void)
{
    const uint32_t slot = expbc_slot;
    uint32_t r;
    expal_set_modes(1u, 1u);
    mlkem_x06_mode = 1u;
    x02_mode = expbc_mode;
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
    x02_mode = 0u;
    mlkem_x06_mode = 0u;
}

static void expbc_run_all(void)
{
    static const uint8_t ord[4] = {0, 1, 1, 0};
    uint32_t i;

    expaj_stack_prepare();
    run_on_stack(expbc_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expBC equiv: bytes-mm="); uart_put_u32(expbc_byte_mismatch);
    uart_puts(" smoke-fails="); uart_put_u32(expbc_smoke_fails);
    uart_puts(" reject-mm="); uart_put_u32(expbc_reject_mm);
    uart_puts(" checks="); uart_put_u32(expbc_checks);
    uart_puts("\n");
    harness_fails += expbc_byte_mismatch + expbc_smoke_fails + expbc_reject_mm;

    for (i = 0; i < 4u; i++) {
        expbc_mode = ord[i];
        expbc_slot = EXPBC_SLOT_BASE + 3u * i;
        run_on_stack(expbc_bench_run, dtcm_stack + sizeof(dtcm_stack));
    }
    expaj_stack_check();
    uart_puts("expBC bench: stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_stack_canary_fails;
    expal_set_modes(0, 0);
}
