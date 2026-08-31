/* expCJ: draft-10 기준형 A와 최종 채택형 B의 동일-ELF 누적 A/B.
 * 사전등록: 2026-08-27_expCJ_draft10_cumulative_prereg.md
 * 슬롯 570..585 재사용: A-B-B-A, 셀마다 keygen/encaps/warm/cold 4개.
 * expCJ는 마지막에 실행되므로 앞선 expBF 결과 회수 뒤 이 범위를 안전하게 덮는다. */

#define EXPCJ_SLOT_BASE 570u

/* 이전 실험이 끝난 뒤 기존 reference scratch를 재사용해 DTCM을 늘리지 않는다. */
#define expcj_ref_pk      xw_ref_pk
#define expcj_ref_sk      xw_ref_sk
#define expcj_ref_ct      xw_ref_ct
#define expcj_ref_enc     xw_ref_ss_e
#define expcj_ref_warm    xw_ref_ss_d
#define expcj_ref_cold    xw_ref_reject
#define expcj_ref_reject  expy_ref_reject

static uint32_t expcj_byte_mm, expcj_smoke, expcj_reject_mm, expcj_coldwarm_mm;
static uint32_t expcj_timing_mm;
static volatile uint32_t expcj_mode, expcj_slot;

static void expcj_equiv_cell(uint32_t mode, uint32_t seed, uint32_t capture)
{
    uint8_t warm[32], cold[32], reject_warm[32], reject_cold[32];

    d10_set_optimizations(mode);
    PQCLEAN_randombytes_reset(seed);
    d10_keypair(d10_pk, d10_sk);
    d10_expand(&d10_cache, d10_sk);
    if (d10_enc(d10_ct, d10_ss_e, d10_pk) != 0) expcj_smoke++;
    d10_dec_warm(warm, d10_ct);
    d10_dec_cold(cold, d10_ct, d10_sk);
    expcj_smoke += (memcmp(d10_ss_e, warm, 32) != 0);
    expcj_coldwarm_mm += byte_mismatches(warm, cold, 32);

    d10_ct[0] ^= 0x5au;
    d10_dec_warm(reject_warm, d10_ct);
    d10_dec_cold(reject_cold, d10_ct, d10_sk);
    d10_ct[0] ^= 0x5au;
    expcj_reject_mm += byte_mismatches(reject_warm, reject_cold, 32);
    expcj_smoke += (memcmp(d10_ss_e, reject_warm, 32) == 0);

    if (capture) {
        memcpy(expcj_ref_pk, d10_pk, D10_PKBYTES);
        memcpy(expcj_ref_sk, d10_sk, D10_SKBYTES);
        memcpy(expcj_ref_ct, d10_ct, D10_CTBYTES);
        memcpy(expcj_ref_enc, d10_ss_e, 32);
        memcpy(expcj_ref_warm, warm, 32);
        memcpy(expcj_ref_cold, cold, 32);
        memcpy(expcj_ref_reject, reject_warm, 32);
    } else {
        expcj_byte_mm += byte_mismatches(d10_pk, expcj_ref_pk, D10_PKBYTES);
        expcj_byte_mm += byte_mismatches(d10_sk, expcj_ref_sk, D10_SKBYTES);
        expcj_byte_mm += byte_mismatches(d10_ct, expcj_ref_ct, D10_CTBYTES);
        expcj_byte_mm += byte_mismatches(d10_ss_e, expcj_ref_enc, 32);
        expcj_byte_mm += byte_mismatches(warm, expcj_ref_warm, 32);
        expcj_byte_mm += byte_mismatches(cold, expcj_ref_cold, 32);
        expcj_reject_mm += byte_mismatches(reject_warm, expcj_ref_reject, 32);
    }
    d10_set_optimizations(0u);
}

static void expcj_equivalence(void)
{
    expcj_byte_mm = 0u;
    expcj_smoke = 0u;
    expcj_reject_mm = 0u;
    expcj_coldwarm_mm = 0u;
    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xc1000000u + s * 0x00009e37u;
        expcj_equiv_cell(0u, seed, 1u);
        expcj_equiv_cell(1u, seed, 0u);
    }
}

static void expcj_bench_cell(void)
{
    uint8_t warm[32];
    const uint32_t slot = expcj_slot;

    d10_set_optimizations(expcj_mode);
    PQCLEAN_randombytes_reset(0xc1ab5a5au);
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin(); d10_keypair(d10_pk, d10_sk);
        rep_cyc[slot][r] = dwt_span_end();
    }
    d10_expand(&d10_cache, d10_sk);
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin(); (void) d10_enc(d10_ct, d10_ss_e, d10_pk);
        rep_cyc[slot + 1u][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin(); d10_dec_warm(warm, d10_ct);
        rep_cyc[slot + 2u][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin(); d10_dec_cold(d10_ss_d, d10_ct, d10_sk);
        rep_cyc[slot + 3u][r] = dwt_span_end();
    }

    if (slot == EXPCJ_SLOT_BASE) {
        memcpy(expcj_ref_pk, d10_pk, D10_PKBYTES);
        memcpy(expcj_ref_sk, d10_sk, D10_SKBYTES);
        memcpy(expcj_ref_ct, d10_ct, D10_CTBYTES);
        memcpy(expcj_ref_enc, d10_ss_e, 32);
        memcpy(expcj_ref_warm, warm, 32);
        memcpy(expcj_ref_cold, d10_ss_d, 32);
    } else {
        expcj_timing_mm += byte_mismatches(d10_pk, expcj_ref_pk, D10_PKBYTES);
        expcj_timing_mm += byte_mismatches(d10_sk, expcj_ref_sk, D10_SKBYTES);
        expcj_timing_mm += byte_mismatches(d10_ct, expcj_ref_ct, D10_CTBYTES);
        expcj_timing_mm += byte_mismatches(d10_ss_e, expcj_ref_enc, 32);
        expcj_timing_mm += byte_mismatches(warm, expcj_ref_warm, 32);
        expcj_timing_mm += byte_mismatches(d10_ss_d, expcj_ref_cold, 32);
    }
    d10_set_optimizations(0u);
}

static void expcj_run_all(void)
{
    static const uint8_t order[4] = {0u, 1u, 1u, 0u};

    expaj_stack_prepare();
    run_on_stack(expcj_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expCJ equiv: bytes-mm="); uart_put_u32(expcj_byte_mm);
    uart_puts(" smoke="); uart_put_u32(expcj_smoke);
    uart_puts(" reject-mm="); uart_put_u32(expcj_reject_mm);
    uart_puts(" coldwarm-mm="); uart_put_u32(expcj_coldwarm_mm);
    uart_puts("\n");
    harness_fails += expcj_byte_mm + expcj_smoke + expcj_reject_mm + expcj_coldwarm_mm;

    expcj_timing_mm = 0u;
    for (uint32_t i = 0; i < 4u; i++) {
        expcj_mode = order[i];
        expcj_slot = EXPCJ_SLOT_BASE + 4u * i;
        run_on_stack(expcj_bench_cell, dtcm_stack + sizeof(dtcm_stack));
    }
    expaj_stack_check();
    uart_puts("expCJ timing-mm="); uart_put_u32(expcj_timing_mm);
    uart_puts(" stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expcj_timing_mm + expaj_stack_canary_fails;
    d10_set_optimizations(0u);
}
