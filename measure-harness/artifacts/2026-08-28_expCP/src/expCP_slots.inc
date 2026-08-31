/* expCP: 파트너 범위를 넓힌 두 번째 U 후보 (배치 3 -> 5, 배칭 순열 9 -> 15).
 * 사전등록: 2026-08-28_expCP_wider_coverage_prereg.md
 * 슬롯 832..856. keygen 만 잰다 (PRF 배칭이 keygen 경로에 있다).
 *
 * 셀: F3, U3, U3, F3 / F5, U5, U5, F5  — 각 셀 (총, 융합, 잔여).
 * F5-F3 = PRF 배칭 자체의 효과(스티칭 무관). 이걸 뺀 뒤에야
 * (U5-F5) 대 (U3-F3) 가 스티칭 효과의 coverage 비교가 된다. */

#include "prfx4.h"

#define EXPCP_SLOT_BASE 832u

static uint32_t expcp_mismatch, expcp_timing_mm, expcp_equiv_mm;
static uint32_t expcp_perm_u3, expcp_perm_u5;
static volatile uint32_t expcp_mode;   /* 1=U 3=F */
static volatile uint32_t expcp_prfx4;  /* 0=scalar PRF 1=x4 PRF */
static volatile uint32_t expcp_slot;
static volatile uint32_t expcp_capture;

/* 게이트 1 (가장 중요): PRF 배칭이 pk/sk 를 바꾸지 않는가. */
static void expcp_equivalence(void)
{
    expcp_equiv_mm = 0u;
    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xcb000000u + s * 0x00009e37u;

        mlkem_prfx4_mode = 0u;
        PQCLEAN_randombytes_reset(seed);
        xwing_ac_keypair(xw_pk, xw_sk, 3u);
        memcpy(xw_ref_pk, xw_pk, sizeof(xw_ref_pk));
        memcpy(xw_ref_sk, xw_sk, sizeof(xw_ref_sk));

        mlkem_prfx4_mode = 1u;
        PQCLEAN_randombytes_reset(seed);
        xwing_ac_keypair(xw_pk, xw_sk, 3u);
        expcp_equiv_mm += byte_mismatches(xw_pk, xw_ref_pk, sizeof(xw_ref_pk));
        expcp_equiv_mm += byte_mismatches(xw_sk, xw_ref_sk, sizeof(xw_ref_sk));

        /* U 경로에서도 같은지 확인한다 (스티칭 + PRF 배칭 동시). */
        mlkem_prfx4_mode = 1u;
        PQCLEAN_randombytes_reset(seed);
        xwing_ac_keypair(xw_pk, xw_sk, 1u);
        expcp_equiv_mm += byte_mismatches(xw_pk, xw_ref_pk, sizeof(xw_ref_pk));
        expcp_equiv_mm += byte_mismatches(xw_sk, xw_ref_sk, sizeof(xw_ref_sk));
    }
    mlkem_prfx4_mode = 0u;
}

/* 게이트 2: permute4 호출 수(=배치 수)가 실제로 3 -> 5 로 늘었는가. */
static void expcp_count_batches(void)
{
    uint32_t before;

    PQCLEAN_randombytes_reset(0xcb5a5a5au);
    mlkem_prfx4_mode = 0u;
    before = g_permute4_calls;
    xwing_ac_keypair(xw_pk, xw_sk, 1u);
    expcp_perm_u3 = g_permute4_calls - before;

    PQCLEAN_randombytes_reset(0xcb5a5a5au);
    mlkem_prfx4_mode = 1u;
    before = g_permute4_calls;
    xwing_ac_keypair(xw_pk, xw_sk, 1u);
    expcp_perm_u5 = g_permute4_calls - before;

    mlkem_prfx4_mode = 0u;
}

static void expcp_bench_cell(void)
{
    const uint32_t mode = expcp_mode;
    const uint32_t slot = expcp_slot;
    const uint32_t use_u = (mode == 1u);

    mlkem_prfx4_mode = expcp_prfx4;
    PQCLEAN_randombytes_reset(0xcba5a5a5u);

    for (uint32_t r = 0; r < REP_N; r++) {
        uint32_t fused_end, residual_end, total_end;

        x25519_u_queue_reset();
        (void) PQCLEAN_randombytes(xw_sk + CRYPTO_SECRETKEYBYTES, 32);
        clamp(xw_sk + CRYPTO_SECRETKEYBYTES);
        if (use_u)
            expcp_mismatch += (x25519_u_enqueue(xw_pk + CRYPTO_PUBLICKEYBYTES,
                                                xw_sk + CRYPTO_SECRETKEYBYTES,
                                                basepoint) != 0);
        mlkem_keccakx4_mode = 1u;
        dwt_span_begin();
        crypto_kem_keypair(xw_pk, xw_sk);
        fused_end = dwt_span_end();

        if (use_u)
            x25519_u_finish_all();
        else
            curve25519_scalarmult_fiat(xw_pk + CRYPTO_PUBLICKEYBYTES,
                                       xw_sk + CRYPTO_SECRETKEYBYTES, basepoint);
        residual_end = dwt_span_end();

        mlkem_keccakx4_mode = 0u;
        memcpy(xw_sk + CRYPTO_SECRETKEYBYTES + 32,
               xw_pk + CRYPTO_PUBLICKEYBYTES, 32);
        total_end = dwt_span_end();

        rep_cyc[slot][r] = total_end;
        rep_cyc[slot + 1u][r] = fused_end;
        rep_cyc[slot + 2u][r] = residual_end - fused_end;
        expcp_mismatch += x25519_u_queue_pending() + x25519_u_failures();
    }

    mlkem_keccakx4_mode = 0u;
    mlkem_prfx4_mode = 0u;
    x25519_u_queue_reset();

    /* 네 셀 전부 같은 seed 로 시작하므로 최종 pk/sk 는 모드와 무관하게 같아야 한다. */
    if (expcp_capture) {
        memcpy(xw_ref_pk, xw_pk, sizeof(xw_ref_pk));
        memcpy(xw_ref_sk, xw_sk, sizeof(xw_ref_sk));
    } else {
        expcp_timing_mm += byte_mismatches(xw_pk, xw_ref_pk, sizeof(xw_ref_pk));
        expcp_timing_mm += byte_mismatches(xw_sk, xw_ref_sk, sizeof(xw_ref_sk));
    }
}

static void expcp_run_all(void)
{
    static const uint8_t modes[4] = {3u, 1u, 1u, 3u};

    expcp_mismatch = 0u;
    expcp_timing_mm = 0u;
    expaj_stack_prepare();

    run_on_stack(expcp_equivalence, dtcm_stack + sizeof(dtcm_stack));
    run_on_stack(expcp_count_batches, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expCP equiv-mm="); uart_put_u32(expcp_equiv_mm);
    uart_puts(" batches U3="); uart_put_u32(expcp_perm_u3);
    uart_puts(" U5="); uart_put_u32(expcp_perm_u5);
    uart_puts("\n");
    harness_fails += expcp_equiv_mm;

    /* 첫 셀(F3)이 기준을 잡고 나머지 일곱 셀이 대조한다. */
    for (uint32_t g = 0; g < 2u; g++) {
        for (uint32_t i = 0; i < 4u; i++) {
            expcp_mode = modes[i];
            expcp_prfx4 = g;
            expcp_slot = EXPCP_SLOT_BASE + 12u * g + 3u * i;
            expcp_capture = (g == 0u && i == 0u);
            run_on_stack(expcp_bench_cell, dtcm_stack + sizeof(dtcm_stack));
        }
    }

    expaj_stack_check();
    uart_puts("expCP mismatch="); uart_put_u32(expcp_mismatch);
    uart_puts(" timing-mm="); uart_put_u32(expcp_timing_mm);
    uart_puts(" stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expcp_mismatch + expcp_timing_mm + expaj_stack_canary_fails;
    mlkem_prfx4_mode = 0u;
}
