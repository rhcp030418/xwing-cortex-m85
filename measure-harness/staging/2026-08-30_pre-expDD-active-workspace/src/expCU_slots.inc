/* expCU: draft-10 B 의 leave-one-out, 같은 ELF. 사전등록: 2026-08-28_expCU_CV_CW_CX_prereg.md
 * 여섯 독립 토글: bit0 xyc8(NTT/store) bit1 c9(packing/CBD/msg) bit2 x06(fixed-base)
 *                 bit3 x01(체 곱셈) bit4 x02(체 제곱) bit5 k31(memcpy/memset)
 * 축 i 마다 [B, B-i, B-i, B] ABBA, 셀당 keygen/encaps/warm/cold. 슬롯 870..965. */

#define EXPCU_SLOT_BASE 870u
#define EXPCU_B_MASK    0x3fu
#define EXPCU_AXES      6u

static uint32_t expcu_equiv_mm, expcu_timing_mm;
static volatile uint32_t expcu_mask, expcu_slot, expcu_capture;

static void expcu_set(uint32_t mask)
{
    expal_set_modes(mask & 1u, (mask >> 1) & 1u);
    mlkem_x06_mode = (mask >> 2) & 1u;
    x01_mode = (mask >> 3) & 1u;
    x02_mode = (mask >> 4) & 1u;
    k31_mode = (mask >> 5) & 1u;
}

/* 8-seed: 여섯 B-i 가 B 와 pk/sk/ct/ss/warm/cold/reject 바이트 일치하는가. */
static void expcu_equivalence(void)
{
    uint8_t warm[32], cold[32], rej[32];

    expcu_equiv_mm = 0u;
    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xcd000000u + s * 0x00009e37u;
        for (uint32_t cfg = 0; cfg <= EXPCU_AXES; cfg++) {
            const uint32_t mask = (cfg == 0u) ? EXPCU_B_MASK
                                              : (EXPCU_B_MASK & ~(1u << (cfg - 1u)));
            expcu_set(mask);
            PQCLEAN_randombytes_reset(seed);
            d10_keypair(d10_pk, d10_sk);
            d10_expand(&d10_cache, d10_sk);
            if (d10_enc(d10_ct, d10_ss_e, d10_pk) != 0) expcu_equiv_mm++;
            d10_dec_warm(warm, d10_ct);
            d10_dec_cold(cold, d10_ct, d10_sk);
            d10_ct[0] ^= 0x5au;
            d10_dec_warm(rej, d10_ct);
            d10_ct[0] ^= 0x5au;
            if (cfg == 0u) {
                memcpy(xw_ref_pk, d10_pk, D10_PKBYTES);
                memcpy(xw_ref_sk, d10_sk, D10_SKBYTES);
                memcpy(xw_ref_ct, d10_ct, D10_CTBYTES);
                memcpy(xw_ref_ss_e, d10_ss_e, 32);
                memcpy(xw_ref_ss_d, warm, 32);
                memcpy(xw_ref_reject, cold, 32);
                memcpy(expy_ref_reject, rej, 32);
            } else {
                expcu_equiv_mm += byte_mismatches(d10_pk, xw_ref_pk, D10_PKBYTES);
                expcu_equiv_mm += byte_mismatches(d10_sk, xw_ref_sk, D10_SKBYTES);
                expcu_equiv_mm += byte_mismatches(d10_ct, xw_ref_ct, D10_CTBYTES);
                expcu_equiv_mm += byte_mismatches(d10_ss_e, xw_ref_ss_e, 32);
                expcu_equiv_mm += byte_mismatches(warm, xw_ref_ss_d, 32);
                expcu_equiv_mm += byte_mismatches(cold, xw_ref_reject, 32);
                expcu_equiv_mm += byte_mismatches(rej, expy_ref_reject, 32);
            }
        }
    }
    expcu_set(0u);
}

static void expcu_bench_cell(void)
{
    uint8_t warm[32];
    const uint32_t slot = expcu_slot;

    expcu_set(expcu_mask);
    PQCLEAN_randombytes_reset(0xcdab5a5au);
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

    /* 모든 셀이 같은 seed 로 시작하므로 최종 출력은 구성과 무관하게 같아야 한다. */
    if (expcu_capture) {
        memcpy(xw_ref_pk, d10_pk, D10_PKBYTES);
        memcpy(xw_ref_sk, d10_sk, D10_SKBYTES);
        memcpy(xw_ref_ct, d10_ct, D10_CTBYTES);
        memcpy(xw_ref_ss_e, d10_ss_e, 32);
        memcpy(xw_ref_ss_d, warm, 32);
        memcpy(xw_ref_reject, d10_ss_d, 32);
    } else {
        expcu_timing_mm += byte_mismatches(d10_pk, xw_ref_pk, D10_PKBYTES);
        expcu_timing_mm += byte_mismatches(d10_sk, xw_ref_sk, D10_SKBYTES);
        expcu_timing_mm += byte_mismatches(d10_ct, xw_ref_ct, D10_CTBYTES);
        expcu_timing_mm += byte_mismatches(d10_ss_e, xw_ref_ss_e, 32);
        expcu_timing_mm += byte_mismatches(warm, xw_ref_ss_d, 32);
        expcu_timing_mm += byte_mismatches(d10_ss_d, xw_ref_reject, 32);
    }
    expcu_set(0u);
}

static void expcu_run_all(void)
{
    expcu_timing_mm = 0u;
    expaj_stack_prepare();
    run_on_stack(expcu_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expCU equiv-mm="); uart_put_u32(expcu_equiv_mm); uart_puts("\n");
    harness_fails += expcu_equiv_mm;

    for (uint32_t axis = 0; axis < EXPCU_AXES; axis++) {
        const uint32_t loo = EXPCU_B_MASK & ~(1u << axis);
        const uint32_t order[4] = {EXPCU_B_MASK, loo, loo, EXPCU_B_MASK};
        for (uint32_t i = 0; i < 4u; i++) {
            expcu_mask = order[i];
            expcu_slot = EXPCU_SLOT_BASE + 16u * axis + 4u * i;
            expcu_capture = (axis == 0u && i == 0u);
            run_on_stack(expcu_bench_cell, dtcm_stack + sizeof(dtcm_stack));
        }
    }
    expaj_stack_check();
    uart_puts("expCU timing-mm="); uart_put_u32(expcu_timing_mm);
    uart_puts(" stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expcu_timing_mm + expaj_stack_canary_fails;
}
