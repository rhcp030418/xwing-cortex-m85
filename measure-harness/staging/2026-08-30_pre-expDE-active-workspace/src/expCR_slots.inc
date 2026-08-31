/* 실험 CR: Lenngren fe25519_mul 에 r11 수동 양보(y1) 단가 A/B.  Slots 857..861.
 * 사전등록: 2026-08-28_expCR_lenngren_yield1_prereg.md
 *   857 A 원본   858 B y1   859 B   860 A   (ABBA)   861 null
 */
#define EXPCR_SLOT_BASE 857u
#define EXPCR_BATCH 64u

extern void fe25519_mul_y1_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);

volatile uint32_t expcr_mm = 9;
volatile uint32_t expcr_checks = 0;

static uint32_t expcr_a[8] __attribute__((aligned(16), section(".dtcm")));
static uint32_t expcr_b[8] __attribute__((aligned(16), section(".dtcm")));
static uint32_t expcr_r0[8] __attribute__((aligned(16), section(".dtcm")));
static uint32_t expcr_r1[8] __attribute__((aligned(16), section(".dtcm")));

static uint32_t expcr_rng = 0xc12345u;
static uint32_t expcr_next(void)
{
    expcr_rng ^= expcr_rng << 13; expcr_rng ^= expcr_rng >> 17;
    expcr_rng ^= expcr_rng << 5;  return expcr_rng;
}

static void expcr_correctness(void)
{
    static const uint32_t edge[7][8] = {
        {0,0,0,0,0,0,0,0},
        {1,0,0,0,0,0,0,0},
        {0xffffffecu,0xffffffffu,0xffffffffu,0xffffffffu,
         0xffffffffu,0xffffffffu,0xffffffffu,0x7fffffffu},
        {0xffffffedu,0xffffffffu,0xffffffffu,0xffffffffu,
         0xffffffffu,0xffffffffu,0xffffffffu,0x7fffffffu},
        {0xffffffffu,0xffffffffu,0xffffffffu,0xffffffffu,
         0xffffffffu,0xffffffffu,0xffffffffu,0x7fffffffu},
        {0xffffffffu,0xffffffffu,0xffffffffu,0xffffffffu,
         0xffffffffu,0xffffffffu,0xffffffffu,0xffffffffu},
        {0x5a5a5a5au,0xa5a5a5a5u,0x5a5a5a5au,0xa5a5a5a5u,
         0x5a5a5a5au,0xa5a5a5a5u,0x5a5a5a5au,0x25a5a5a5u},
    };
    uint32_t mm = 0, checks = 0, i, j, k;

    for (k = 0; k < 7u; k++) for (j = 0; j < 7u; j++) {
        for (i = 0; i < 8u; i++) { expcr_a[i] = edge[k][i]; expcr_b[i] = edge[j][i]; }
        fe25519_mul_lenn(expcr_r0, expcr_a, expcr_b);
        fe25519_mul_y1_lenn(expcr_r1, expcr_a, expcr_b);
        for (i = 0; i < 8u; i++) mm += (expcr_r0[i] != expcr_r1[i]);
        checks++;
    }
    expcr_rng = 0xc12345u;
    for (k = 0; k < 1000u; k++) {
        for (i = 0; i < 8u; i++) expcr_a[i] = expcr_next();
        for (i = 0; i < 8u; i++) expcr_b[i] = expcr_next();
        fe25519_mul_lenn(expcr_r0, expcr_a, expcr_b);
        fe25519_mul_y1_lenn(expcr_r1, expcr_a, expcr_b);
        for (i = 0; i < 8u; i++) mm += (expcr_r0[i] != expcr_r1[i]);
        checks++;
    }
    expcr_mm = mm;
    expcr_checks = checks;
}

static volatile uint32_t expcr_kind;
static volatile uint32_t expcr_slot;

static void expcr_bench_run(void)
{
    const uint32_t slot = expcr_slot;
    const uint32_t kind = expcr_kind;
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPCR_BATCH; i++) {
            if (kind == 0u) fe25519_mul_lenn(expcr_r0, expcr_a, expcr_b);
            else if (kind == 1u) fe25519_mul_y1_lenn(expcr_r1, expcr_a, expcr_b);
        }
        rep_cyc[slot][r] = dwt_span_end();
    }
}

static void expcr_run_all(void)
{
    static const uint8_t ord[4] = {0, 1, 1, 0};
    uint32_t i;

    expaj_stack_prepare();
    run_on_stack(expcr_correctness, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expCR correctness: mm="); uart_put_u32(expcr_mm);
    uart_puts(" checks="); uart_put_u32(expcr_checks);
    uart_puts("\n");
    harness_fails += expcr_mm;

    for (i = 0; i < 8u; i++) { expcr_a[i] = 0x9e3779b9u + i; expcr_b[i] = 0x7f4a7c15u + i; }
    for (i = 0; i < 4u; i++) {
        expcr_kind = ord[i];
        expcr_slot = EXPCR_SLOT_BASE + i;
        run_on_stack(expcr_bench_run, dtcm_stack + sizeof(dtcm_stack));
    }
    expcr_kind = 2u; expcr_slot = EXPCR_SLOT_BASE + 4u;
    run_on_stack(expcr_bench_run, dtcm_stack + sizeof(dtcm_stack));
    expaj_stack_check();
    uart_puts("expCR done\n");
}
