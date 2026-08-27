/* Experiment AU (= AT-2): fixed-base X25519 보드 정확성 + A/B.  Slots 489..500.
 *
 * 사전등록: A주제/measure-harness/2026-08-25_expAT_x06_fixedbase_prereg.md §7 AT-2.
 * 호스트 선행: 2026-08-25_expAT1_results.md (RFC 7748 KAT + 1,000 seed 차분 통과).
 *
 * 적용 지점은 keygen `pkX` 와 encaps `ctX` **둘뿐**이다. variable-base 두 곳
 * (encaps `ssX`, decaps `ssX`) 에는 적용하지 않는다.
 *
 * 슬롯 배치
 *   489 A: 현행 curve25519_scalarmult(·, k, basepoint)   단독
 *   490 B: 신규 curve25519_scalarmult_base(·, k)         단독
 *   491 B  (ABBA 두 번째)   492 A  (ABBA 두 번째)
 *   493 ct-delta 확인용 A(스칼라 all-low)  494 A(스칼라 all-high)
 *   495 ct-delta 확인용 B(스칼라 all-low)  496 B(스칼라 all-high)
 */

#include "x25519_base.h"

#define EXPAU_SLOT_BASE 489u

volatile uint32_t expau_kat_fails = 9;    /* RFC 7748 4종 */
volatile uint32_t expau_diff_mm = 9;      /* base 대 일반 ladder, 여러 seed */
volatile uint32_t expau_checks = 0;

static uint8_t expau_sk[32] __attribute__((section(".dtcm")));
static uint8_t expau_a[32]  __attribute__((section(".dtcm")));
static uint8_t expau_b[32]  __attribute__((section(".dtcm")));

static void expau_correctness(void)
{
    /* RFC 7748 §6.1 */
    static const uint8_t a_sk[32] = {
        0x77,0x07,0x6d,0x0a,0x73,0x18,0xa5,0x7d,0x3c,0x16,0xc1,0x72,0x51,0xb2,0x66,0x45,
        0xdf,0x4c,0x2f,0x87,0xeb,0xc0,0x99,0x2a,0xb1,0x77,0xfb,0xa5,0x1d,0xb9,0x2c,0x2a};
    static const uint8_t a_pk[32] = {
        0x85,0x20,0xf0,0x09,0x89,0x30,0xa7,0x54,0x74,0x8b,0x7d,0xdc,0xb4,0x3e,0xf7,0x5a,
        0x0d,0xbf,0x3a,0x0d,0x26,0x38,0x1a,0xf4,0xeb,0xa4,0xa9,0x8e,0xaa,0x9b,0x4e,0x6a};
    static const uint8_t b_sk[32] = {
        0x5d,0xab,0x08,0x7e,0x62,0x4a,0x8a,0x4b,0x79,0xe1,0x7f,0x8b,0x83,0x80,0x0e,0xe6,
        0x6f,0x3b,0xb1,0x29,0x26,0x18,0xb6,0xfd,0x1c,0x2f,0x8b,0x27,0xff,0x88,0xe0,0xeb};
    static const uint8_t b_pk[32] = {
        0xde,0x9e,0xdb,0x7d,0x7b,0x7d,0xc1,0xb4,0xd3,0x5b,0x61,0xc2,0xec,0xe4,0x35,0x37,
        0x3f,0x83,0x43,0xc8,0x5b,0x78,0x67,0x4d,0xad,0xfc,0x7e,0x14,0x6f,0x88,0x2b,0x4f};

    uint32_t fails = 0, mm = 0, checks = 0;
    uint32_t i, s;

    curve25519_scalarmult_base(expau_b, a_sk);
    fails += (byte_mismatches(expau_b, a_pk, 32u) != 0u);
    curve25519_scalarmult_base(expau_b, b_sk);
    fails += (byte_mismatches(expau_b, b_pk, 32u) != 0u);
    checks += 2u;

    /* clamp 경계 4종 + 무작위 seed: 신규 base 경로 대 현행 ladder */
    for (s = 0; s < 68u; s++) {
        if (s == 0u)      { for (i = 0; i < 32u; i++) expau_sk[i] = 0x00u; }
        else if (s == 1u) { for (i = 0; i < 32u; i++) expau_sk[i] = 0xffu; }
        else if (s == 2u) { for (i = 0; i < 32u; i++) expau_sk[i] = 0u; expau_sk[31] = 0x40u; }
        else if (s == 3u) { for (i = 0; i < 32u; i++) expau_sk[i] = 0u; expau_sk[0] = 0x07u; }
        else              { (void) PQCLEAN_randombytes(expau_sk, 32u); }

        {
            uint8_t clamped[32];
            for (i = 0; i < 32u; i++) clamped[i] = expau_sk[i];
            clamp(clamped);
            curve25519_scalarmult(expau_a, clamped, basepoint);
        }
        curve25519_scalarmult_base(expau_b, expau_sk);
        mm += byte_mismatches(expau_a, expau_b, 32u);
        checks += 1u;
    }

    expau_kat_fails = fails;
    expau_diff_mm = mm;
    expau_checks = checks;
}

static volatile uint32_t expau_kind;   /* 0=A 현행, 1=B 신규 */
static volatile uint32_t expau_slot;

static void expau_bench_run(void)
{
    const uint32_t slot = expau_slot;
    const uint32_t kind = expau_kind;
    uint8_t clamped[32];
    uint32_t i, r;

    PQCLEAN_randombytes_reset(0xba5e0000u);
    for (r = 0; r < REP_N; r++) {
        (void) PQCLEAN_randombytes(expau_sk, 32u);
        for (i = 0; i < 32u; i++) clamped[i] = expau_sk[i];
        clamp(clamped);
        dwt_span_begin();
        if (kind == 0u) curve25519_scalarmult(expau_a, clamped, basepoint);
        else            curve25519_scalarmult_base(expau_b, expau_sk);
        rep_cyc[slot][r] = dwt_span_end();
    }
}

extern volatile uint32_t x25519b_prof, x25519b_cyc_select, x25519b_cyc_madd;
extern volatile uint32_t x25519b_cyc_recode, x25519b_cyc_inv;

/* 497..501 : B 의 단계별 귀속 (합계는 슬롯 [0], 호출 수 아님) */
static void expau_attrib_run(void)
{
    const uint32_t b = EXPAU_SLOT_BASE + 8u;
    uint32_t r, i;
    for (i = 0; i < 5u; i++) { rep_cyc[b + i][0] = 0u; }
    PQCLEAN_randombytes_reset(0xba5e0000u);
    x25519b_prof = 1u;
    for (r = 0; r < REP_N; r++) {
        (void) PQCLEAN_randombytes(expau_sk, 32u);
        x25519b_cyc_select = 0u; x25519b_cyc_madd = 0u;
        x25519b_cyc_recode = 0u; x25519b_cyc_inv = 0u;
        dwt_span_begin();
        curve25519_scalarmult_base(expau_b, expau_sk);
        rep_cyc[b + 4u][r] = dwt_span_end();
        rep_cyc[b + 0u][0] += x25519b_cyc_recode;
        rep_cyc[b + 1u][0] += x25519b_cyc_select;
        rep_cyc[b + 2u][0] += x25519b_cyc_madd;
        rep_cyc[b + 3u][0] += x25519b_cyc_inv;
    }
    x25519b_prof = 0u;
}

static volatile uint32_t expau_ct_kind;
static volatile uint32_t expau_ct_high;
static volatile uint32_t expau_ct_slot;

static void expau_ct_run(void)
{
    const uint32_t slot = expau_ct_slot;
    uint8_t clamped[32];
    uint32_t i, r;

    for (i = 0; i < 32u; i++) expau_sk[i] = expau_ct_high ? 0xffu : 0x00u;
    for (i = 0; i < 32u; i++) clamped[i] = expau_sk[i];
    clamp(clamped);

    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        if (expau_ct_kind == 0u) curve25519_scalarmult(expau_a, clamped, basepoint);
        else                     curve25519_scalarmult_base(expau_b, expau_sk);
        rep_cyc[slot][r] = dwt_span_end();
    }
}

static void expau_run_all(void)
{
    const uint32_t b = EXPAU_SLOT_BASE;
    static const uint8_t ord[4] = {0, 1, 1, 0};
    uint32_t i;

    expaj_stack_prepare();
    run_on_stack(expau_correctness, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAU correctness: kat-fails="); uart_put_u32(expau_kat_fails);
    uart_puts(" diff-mm="); uart_put_u32(expau_diff_mm);
    uart_puts(" checks="); uart_put_u32(expau_checks);
    uart_puts("\n");
    harness_fails += expau_kat_fails + expau_diff_mm;

    /* 489/490/491/492 = A B B A */
    for (i = 0; i < 4u; i++) {
        expau_kind = ord[i];
        expau_slot = b + i;
        run_on_stack(expau_bench_run, dtcm_stack + sizeof(dtcm_stack));
    }

    /* 493..496 상수시간 확인 */
    expau_ct_kind = 0u; expau_ct_high = 0u; expau_ct_slot = b + 4u;
    run_on_stack(expau_ct_run, dtcm_stack + sizeof(dtcm_stack));
    expau_ct_kind = 0u; expau_ct_high = 1u; expau_ct_slot = b + 5u;
    run_on_stack(expau_ct_run, dtcm_stack + sizeof(dtcm_stack));
    expau_ct_kind = 1u; expau_ct_high = 0u; expau_ct_slot = b + 6u;
    run_on_stack(expau_ct_run, dtcm_stack + sizeof(dtcm_stack));
    expau_ct_kind = 1u; expau_ct_high = 1u; expau_ct_slot = b + 7u;
    run_on_stack(expau_ct_run, dtcm_stack + sizeof(dtcm_stack));

    run_on_stack(expau_attrib_run, dtcm_stack + sizeof(dtcm_stack));

    expaj_stack_check();
    uart_puts("expAU bench: stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_stack_canary_fails;
}
