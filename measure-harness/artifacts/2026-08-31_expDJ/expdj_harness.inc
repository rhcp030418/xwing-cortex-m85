/* expDJ: initial all-off A0 versus retained two-stage final B8 in one ELF. */

#define EXPDJ_DTCM __attribute__((aligned(16), section(".dtcm")))

static uint8_t expdj_ref_pk[D10_PKBYTES] EXPDJ_DTCM;
static uint8_t expdj_ref_sk[D10_SKBYTES] EXPDJ_DTCM;
static uint8_t expdj_ref_ct[D10_CTBYTES] EXPDJ_DTCM;
static uint8_t expdj_ref_enc[32] EXPDJ_DTCM;
static uint8_t expdj_ref_warm[32] EXPDJ_DTCM;
static uint8_t expdj_ref_cold[32] EXPDJ_DTCM;
static uint8_t expdj_ref_reject[32] EXPDJ_DTCM;
static uint32_t expdj_stack_used[2][4] EXPDJ_DTCM;
static uint32_t expdj_stack_guard[2][4] EXPDJ_DTCM;
static volatile uint32_t expdj_mode, expdj_slot, expdj_stack_op;
static uint32_t expdj_correct_mm, expdj_low_mm, expdj_timing_mm;

static int expdj_enc(uint8_t ct[D10_CTBYTES], uint8_t ss[32],
                     const uint8_t pk[D10_PKBYTES], uint32_t final_mode)
{
    return expdh_d10_enc(ct, ss, pk, final_mode ? 3u : 0u);
}

static void expdj_warm(uint8_t ss[32], const uint8_t ct[D10_CTBYTES],
                       uint32_t final_mode)
{
    expdh_d10_dec_expanded(ss, ct, &d10_cache, final_mode);
}

static void expdj_cold(uint8_t ss[32], const uint8_t ct[D10_CTBYTES],
                       const uint8_t sk[D10_SKBYTES], uint32_t final_mode)
{
    expdh_d10_dec_cold(ss, ct, sk, final_mode);
}

static void expdj_equivalence(void)
{
    uint32_t mm = 0u, smoke = 0u;
    uint8_t warm[32], cold[32], reject[32], reject_cold[32];
    for (uint32_t seed = 0u; seed < 8u; seed++) {
        const uint32_t rng = 0xd9001001u + seed * 0x9e37u;
        for (uint32_t mode = 0u; mode < 2u; mode++) {
            d10_set_optimizations(mode);
            PQCLEAN_randombytes_reset(rng);
            d10_keypair(d10_pk, d10_sk);
            d10_expand(&d10_cache, d10_sk);
            smoke += (uint32_t) (expdj_enc(d10_ct, d10_ss_e, d10_pk, mode) != 0);
            expdj_warm(warm, d10_ct, mode);
            expdj_cold(cold, d10_ct, d10_sk, mode);
            smoke += (uint32_t) (memcmp(d10_ss_e, warm, 32u) != 0);
            mm += byte_mismatches(warm, cold, 32u);
            d10_ct[0] ^= 0x5au;
            expdj_warm(reject, d10_ct, mode);
            expdj_cold(reject_cold, d10_ct, d10_sk, mode);
            mm += byte_mismatches(reject, reject_cold, 32u);
            smoke += (uint32_t) (memcmp(d10_ss_e, reject, 32u) == 0);
            d10_ct[0] ^= 0x5au;

            if (mode == 0u) {
                memcpy(expdj_ref_pk, d10_pk, D10_PKBYTES);
                memcpy(expdj_ref_sk, d10_sk, D10_SKBYTES);
                memcpy(expdj_ref_ct, d10_ct, D10_CTBYTES);
                memcpy(expdj_ref_enc, d10_ss_e, 32u);
                memcpy(expdj_ref_warm, warm, 32u);
                memcpy(expdj_ref_cold, cold, 32u);
                memcpy(expdj_ref_reject, reject, 32u);
            } else {
                mm += byte_mismatches(d10_pk, expdj_ref_pk, D10_PKBYTES);
                mm += byte_mismatches(d10_sk, expdj_ref_sk, D10_SKBYTES);
                mm += byte_mismatches(d10_ct, expdj_ref_ct, D10_CTBYTES);
                mm += byte_mismatches(d10_ss_e, expdj_ref_enc, 32u);
                mm += byte_mismatches(warm, expdj_ref_warm, 32u);
                mm += byte_mismatches(cold, expdj_ref_cold, 32u);
                mm += byte_mismatches(reject, expdj_ref_reject, 32u);
            }
        }
    }
    d10_set_optimizations(0u);
    expdj_correct_mm = mm + smoke;
}

static void expdj_bench_cell(void)
{
    uint8_t warm[32];
    const uint32_t mode = expdj_mode;
    const uint32_t slot = expdj_slot;
    d10_set_optimizations(mode);
    PQCLEAN_randombytes_reset(0xd9002001u);
    for (uint32_t r = 0u; r < REP_N; r++) {
        expdh_timer_start(); d10_keypair(d10_pk, d10_sk);
        rep_cyc[slot][r] = expdh_timer_stop();
    }
    d10_expand(&d10_cache, d10_sk);
    for (uint32_t r = 0u; r < REP_N; r++) {
        expdh_timer_start(); (void) expdj_enc(d10_ct, d10_ss_e, d10_pk, mode);
        rep_cyc[slot + 1u][r] = expdh_timer_stop();
    }
    for (uint32_t r = 0u; r < REP_N; r++) {
        expdh_timer_start(); expdj_warm(warm, d10_ct, mode);
        rep_cyc[slot + 2u][r] = expdh_timer_stop();
    }
    for (uint32_t r = 0u; r < REP_N; r++) {
        expdh_timer_start(); expdj_cold(d10_ss_d, d10_ct, d10_sk, mode);
        rep_cyc[slot + 3u][r] = expdh_timer_stop();
    }

    if (slot == 0u) {
        memcpy(expdj_ref_pk, d10_pk, D10_PKBYTES);
        memcpy(expdj_ref_sk, d10_sk, D10_SKBYTES);
        memcpy(expdj_ref_ct, d10_ct, D10_CTBYTES);
        memcpy(expdj_ref_enc, d10_ss_e, 32u);
        memcpy(expdj_ref_warm, warm, 32u);
        memcpy(expdj_ref_cold, d10_ss_d, 32u);
    } else {
        expdj_timing_mm += byte_mismatches(d10_pk, expdj_ref_pk, D10_PKBYTES);
        expdj_timing_mm += byte_mismatches(d10_sk, expdj_ref_sk, D10_SKBYTES);
        expdj_timing_mm += byte_mismatches(d10_ct, expdj_ref_ct, D10_CTBYTES);
        expdj_timing_mm += byte_mismatches(d10_ss_e, expdj_ref_enc, 32u);
        expdj_timing_mm += byte_mismatches(warm, expdj_ref_warm, 32u);
        expdj_timing_mm += byte_mismatches(d10_ss_d, expdj_ref_cold, 32u);
    }
    d10_set_optimizations(0u);
}

static void expdj_prepare_stack_inputs(void)
{
    d10_set_optimizations(1u);
    PQCLEAN_randombytes_reset(0xd9003001u);
    d10_keypair(d10_pk, d10_sk);
    d10_expand(&d10_cache, d10_sk);
    (void) expdj_enc(d10_ct, d10_ss_e, d10_pk, 1u);
    d10_set_optimizations(0u);
}

static void expdj_stack_call(void)
{
    uint8_t out[32];
    const uint32_t mode = expdj_mode;
    d10_set_optimizations(mode);
    if (expdj_stack_op == 0u) {
        PQCLEAN_randombytes_reset(0xd9004001u);
        d10_keypair(d10_pk, d10_sk);
    } else if (expdj_stack_op == 1u) {
        PQCLEAN_randombytes_reset(0xd9005001u);
        (void) expdj_enc(d10_ct, out, d10_pk, mode);
    } else if (expdj_stack_op == 2u) {
        expdj_warm(out, d10_ct, mode);
    } else {
        expdj_cold(out, d10_ct, d10_sk, mode);
    }
    d10_set_optimizations(0u);
}

static void expdj_measure_stacks(void)
{
    expaj_stack_prepare();
    run_on_stack(expdj_prepare_stack_inputs, dtcm_stack + sizeof(dtcm_stack));
    for (uint32_t mode = 0u; mode < 2u; mode++) {
        for (uint32_t op = 0u; op < 4u; op++) {
            expdj_mode = mode;
            expdj_stack_op = op;
            expaj_stack_prepare();
            run_on_stack(expdj_stack_call, dtcm_stack + sizeof(dtcm_stack));
            expaj_stack_check();
            expdj_stack_used[mode][op] = expaj_stack_highwater;
            expdj_stack_guard[mode][op] = expaj_stack_canary_fails;
            harness_fails += expaj_stack_canary_fails;
        }
    }
}

static void expdj_low_order_call(void)
{
    expdj_low_mm = expdh_low_order();
}

static void expdj_print_cells(void)
{
    for (uint32_t i = 0u; i < 4u; i++) {
        const uint32_t slot = 4u * i;
        uart_puts("expDJ cell="); uart_put_u32(i);
        uart_puts(" mode="); uart_puts(i == 1u || i == 2u ? "B8" : "A0");
        uart_puts(" key="); uart_put_u32(expdh_median(rep_cyc[slot]));
        uart_puts(" encaps="); uart_put_u32(expdh_median(rep_cyc[slot + 1u]));
        uart_puts(" warm="); uart_put_u32(expdh_median(rep_cyc[slot + 2u]));
        uart_puts(" cold="); uart_put_u32(expdh_median(rep_cyc[slot + 3u]));
        uart_puts("\n");
    }
}

static void expdj_run_all(void)
{
    static const uint8_t order[4] = {0u, 1u, 1u, 0u};
    dwt_setup();
    expaj_stack_prepare();
    run_on_stack(expdj_equivalence, dtcm_stack + sizeof(dtcm_stack));
    expaj_stack_check();
    run_on_stack(expdj_low_order_call, dtcm_stack + sizeof(dtcm_stack));
    harness_fails += expdj_correct_mm + expdj_low_mm + expaj_stack_canary_fails;
    uart_puts("expDJ correctness full-mm="); uart_put_u32(expdj_correct_mm);
    uart_puts(" low-mm="); uart_put_u32(expdj_low_mm);
    uart_puts(" eq-stack="); uart_put_u32(expaj_stack_highwater);
    uart_puts(" guard="); uart_put_u32(expaj_stack_canary_fails); uart_puts("\n");

    expdj_timing_mm = 0u;
    for (uint32_t i = 0u; i < 4u; i++) {
        expdj_mode = order[i];
        expdj_slot = 4u * i;
        run_on_stack(expdj_bench_cell, dtcm_stack + sizeof(dtcm_stack));
    }
    harness_fails += expdj_timing_mm;
    run_on_stack(expdj_print_cells, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expDJ timing-mm="); uart_put_u32(expdj_timing_mm); uart_puts("\n");

    expdj_measure_stacks();
    for (uint32_t mode = 0u; mode < 2u; mode++) {
        uart_puts("expDJ stack mode="); uart_puts(mode ? "B8" : "A0");
        uart_puts(" key="); uart_put_u32(expdj_stack_used[mode][0]);
        uart_puts(" encaps="); uart_put_u32(expdj_stack_used[mode][1]);
        uart_puts(" warm="); uart_put_u32(expdj_stack_used[mode][2]);
        uart_puts(" cold="); uart_put_u32(expdj_stack_used[mode][3]);
        uart_puts(" guard=");
        uart_put_u32(expdj_stack_guard[mode][0] + expdj_stack_guard[mode][1] +
                     expdj_stack_guard[mode][2] + expdj_stack_guard[mode][3]);
        uart_puts("\n");
    }
    uart_puts((expdj_correct_mm + expdj_low_mm + expdj_timing_mm) == 0u
              ? "expDJ CORRECTNESS GATE PASS\n" : "expDJ CORRECTNESS GATE FAIL\n");
    d10_set_optimizations(0u);
}

#undef EXPDJ_DTCM
