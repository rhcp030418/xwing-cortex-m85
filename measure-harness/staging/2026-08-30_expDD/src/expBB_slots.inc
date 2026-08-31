/* Experiment BB: fe25519_sqr 재스케줄본 정확성 + 단가 A/B.  Slots 548..553.
 * 사전등록: 2026-08-26_expBB_x02_reschedule_prereg.md
 *   548 A 원본 sqr   549 B 재스케줄본   550 B   551 A   (ABBA)
 *   552 null
 */
#define EXPBB_SLOT_BASE 548u
#define EXPBB_BATCH 64u

extern void fe25519_sqr_bb_lenn(uint32_t r[8], const uint32_t a[8]);
extern void fe25519_mul_bb_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);
extern void fe25519_mul_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);
volatile uint32_t expbd_mm = 9;
static uint32_t expbd_b[8] __attribute__((aligned(16), section(".dtcm")));

volatile uint32_t expbb_mm = 9;
volatile uint32_t expbb_checks = 0;

static uint32_t expbb_a[8] __attribute__((aligned(16), section(".dtcm")));
static uint32_t expbb_r0[8] __attribute__((aligned(16), section(".dtcm")));
static uint32_t expbb_r1[8] __attribute__((aligned(16), section(".dtcm")));

static uint32_t expbb_rng = 0xbb1234u;
static uint32_t expbb_next(void)
{
    expbb_rng ^= expbb_rng << 13; expbb_rng ^= expbb_rng >> 17;
    expbb_rng ^= expbb_rng << 5;  return expbb_rng;
}

static void expbb_correctness(void)
{
    static const uint32_t edge[7][8] = {
        {0,0,0,0,0,0,0,0},
        {1,0,0,0,0,0,0,0},
        {0xffffffecu,0xffffffffu,0xffffffffu,0xffffffffu,
         0xffffffffu,0xffffffffu,0xffffffffu,0x7fffffffu},   /* p-1 */
        {0xffffffedu,0xffffffffu,0xffffffffu,0xffffffffu,
         0xffffffffu,0xffffffffu,0xffffffffu,0x7fffffffu},   /* p   */
        {0xffffffffu,0xffffffffu,0xffffffffu,0xffffffffu,
         0xffffffffu,0xffffffffu,0xffffffffu,0x7fffffffu},   /* 2^255-1 */
        {0xffffffffu,0xffffffffu,0xffffffffu,0xffffffffu,
         0xffffffffu,0xffffffffu,0xffffffffu,0xffffffffu},   /* 2^256-1 */
        {0x5a5a5a5au,0xa5a5a5a5u,0x5a5a5a5au,0xa5a5a5a5u,
         0x5a5a5a5au,0xa5a5a5a5u,0x5a5a5a5au,0x25a5a5a5u},
    };
    uint32_t mm = 0, checks = 0, i, k;

    for (k = 0; k < 7u; k++) {
        for (i = 0; i < 8u; i++) expbb_a[i] = edge[k][i];
        fe25519_sqr_lenn(expbb_r0, expbb_a);
        fe25519_sqr_bb_lenn(expbb_r1, expbb_a);
        for (i = 0; i < 8u; i++) mm += (expbb_r0[i] != expbb_r1[i]);
        checks++;
    }
    expbb_rng = 0xbb1234u;
    for (k = 0; k < 1000u; k++) {
        for (i = 0; i < 8u; i++) expbb_a[i] = expbb_next();
        fe25519_sqr_lenn(expbb_r0, expbb_a);
        fe25519_sqr_bb_lenn(expbb_r1, expbb_a);
        for (i = 0; i < 8u; i++) mm += (expbb_r0[i] != expbb_r1[i]);
        checks++;
    }
    /* BD: fe25519_mul 재정렬본 */
    {
        uint32_t mmul = 0;
        expbb_rng = 0xdd4321u;
        for (k = 0; k < 7u; k++) {
            for (i = 0; i < 8u; i++) { expbb_a[i] = edge[k][i]; expbd_b[i] = edge[(k + 3u) % 7u][i]; }
            fe25519_mul_lenn(expbb_r0, expbb_a, expbd_b);
            fe25519_mul_bb_lenn(expbb_r1, expbb_a, expbd_b);
            for (i = 0; i < 8u; i++) mmul += (expbb_r0[i] != expbb_r1[i]);
            checks++;
        }
        for (k = 0; k < 1000u; k++) {
            for (i = 0; i < 8u; i++) expbb_a[i] = expbb_next();
            for (i = 0; i < 8u; i++) expbd_b[i] = expbb_next();
            fe25519_mul_lenn(expbb_r0, expbb_a, expbd_b);
            fe25519_mul_bb_lenn(expbb_r1, expbb_a, expbd_b);
            for (i = 0; i < 8u; i++) mmul += (expbb_r0[i] != expbb_r1[i]);
            checks++;
        }
        expbd_mm = mmul;
    }
    expbb_mm = mm;
    expbb_checks = checks;
}

static volatile uint32_t expbb_kind;
static volatile uint32_t expbb_slot;

static void expbb_bench_run(void)
{
    const uint32_t slot = expbb_slot;
    const uint32_t kind = expbb_kind;
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPBB_BATCH; i++) {
            if (kind == 0u) fe25519_sqr_lenn(expbb_r0, expbb_a);
            else if (kind == 1u) fe25519_sqr_bb_lenn(expbb_r1, expbb_a);
            else if (kind == 3u) fe25519_mul_lenn(expbb_r0, expbb_a, expbd_b);
            else if (kind == 4u) fe25519_mul_bb_lenn(expbb_r1, expbb_a, expbd_b);
        }
        rep_cyc[slot][r] = dwt_span_end();
    }
}

static void expbb_run_all(void)
{
    static const uint8_t ord[4] = {0, 1, 1, 0};
    uint32_t i;

    expaj_stack_prepare();
    run_on_stack(expbb_correctness, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expBB correctness: mm="); uart_put_u32(expbb_mm);
    uart_puts(" mul-mm="); uart_put_u32(expbd_mm);
    uart_puts(" checks="); uart_put_u32(expbb_checks);
    uart_puts("\n");
    harness_fails += expbb_mm + expbd_mm;

    for (i = 0; i < 8u; i++) expbb_a[i] = 0x9e3779b9u + i;
    for (i = 0; i < 4u; i++) {
        expbb_kind = ord[i];
        expbb_slot = EXPBB_SLOT_BASE + i;
        run_on_stack(expbb_bench_run, dtcm_stack + sizeof(dtcm_stack));
    }
    expbb_kind = 2u; expbb_slot = EXPBB_SLOT_BASE + 4u;
    run_on_stack(expbb_bench_run, dtcm_stack + sizeof(dtcm_stack));
    /* BD micro: 566..569 = A B B A */
    for (i = 0; i < 8u; i++) expbd_b[i] = 0x7f4a7c15u + i;
    {
        static const uint8_t ord2[4] = {3, 4, 4, 3};
        for (i = 0; i < 4u; i++) {
            expbb_kind = ord2[i];
            expbb_slot = 566u + i;
            run_on_stack(expbb_bench_run, dtcm_stack + sizeof(dtcm_stack));
        }
    }
    expaj_stack_check();
}
