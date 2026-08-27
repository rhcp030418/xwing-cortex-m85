/* 실험 BM (X01-v2): fe25519_mul 프레임 평탄화.  Slots 642..649.
 *   642..645  micro  A(원본) B(평탄화) B A     — BM-A
 *   646..649  micro  A(평탄화) B(재스케줄) B A — BM-B (모델 검증 통과 시에만 인용)
 * 사전등록: 2026-08-26_expBM_x01v2_flatframe_prereg.md */

#define EXPBM_SLOT_BASE 642u
#define EXPBM_BATCH 64u

extern void fe25519_mul_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);
extern void fe25519_mul_flat_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);
extern void fe25519_mul_sched_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);

/* expBJ §1 규율: 이 버퍼들은 실제 ladder 처럼 DTCM 스택에 둔다.
 * .bss 에 두면 적재가 약 6배 비싸 분모가 2.5배로 부풀어 gate 가 무의미해진다. */
static uint32_t expbm_seed_a[8], expbm_seed_b[8];
static uint32_t expbm_flat_mm, expbm_sched_mm, expbm_checks;
static volatile uint32_t expbm_kind, expbm_slot;

static uint32_t expbm_rng_s = 0x2468aceu;

static uint32_t expbm_rng(void)
{
    uint32_t x = expbm_rng_s;
    x ^= x << 13; x ^= x >> 17; x ^= x << 5;
    expbm_rng_s = x;
    return x;
}

static void expbm_correct(void)
{
    static const uint32_t edge[7][8] = {
        {0, 0, 0, 0, 0, 0, 0, 0},
        {1, 0, 0, 0, 0, 0, 0, 0},
        {0xffffffffu, 0xffffffffu, 0xffffffffu, 0xffffffffu,
         0xffffffffu, 0xffffffffu, 0xffffffffu, 0xffffffffu},
        {0xffffffedu, 0xffffffffu, 0xffffffffu, 0xffffffffu,
         0xffffffffu, 0xffffffffu, 0xffffffffu, 0x7fffffffu},
        {0xffffffecu, 0xffffffffu, 0xffffffffu, 0xffffffffu,
         0xffffffffu, 0xffffffffu, 0xffffffffu, 0x7fffffffu},
        {0, 0, 0, 0, 0, 0, 0, 0x80000000u},
        {0x5a5a5a5au, 0xa5a5a5a5u, 0x12345678u, 0x9abcdef0u,
         0x0f0f0f0fu, 0xf0f0f0f0u, 0xdeadbeefu, 0x13572468u},
    };
    uint32_t expbm_a[8], expbm_b[8], expbm_r0[8], expbm_r1[8], expbm_r2[8];
    uint32_t fm = 0, sm = 0, checks = 0, t, i, j;

    for (i = 0; i < 7u; i++) {
        for (j = 0; j < 7u; j++) {
            uint32_t k;
            for (k = 0; k < 8u; k++) { expbm_a[k] = edge[i][k]; expbm_b[k] = edge[j][k]; }
            fe25519_mul_lenn(expbm_r0, expbm_a, expbm_b);
            fe25519_mul_flat_lenn(expbm_r1, expbm_a, expbm_b);
            fe25519_mul_sched_lenn(expbm_r2, expbm_a, expbm_b);
            for (k = 0; k < 8u; k++) {
                fm += (expbm_r0[k] != expbm_r1[k]);
                sm += (expbm_r0[k] != expbm_r2[k]);
            }
            checks++;
        }
    }
    for (t = 0; t < 1000u; t++) {
        uint32_t k;
        for (k = 0; k < 8u; k++) { expbm_a[k] = expbm_rng(); expbm_b[k] = expbm_rng(); }
        fe25519_mul_lenn(expbm_r0, expbm_a, expbm_b);
        fe25519_mul_flat_lenn(expbm_r1, expbm_a, expbm_b);
        fe25519_mul_sched_lenn(expbm_r2, expbm_a, expbm_b);
        for (k = 0; k < 8u; k++) {
            fm += (expbm_r0[k] != expbm_r1[k]);
            sm += (expbm_r0[k] != expbm_r2[k]);
        }
        checks++;
    }
    expbm_flat_mm = fm; expbm_sched_mm = sm; expbm_checks = checks;
}

static void expbm_micro(void)
{
    const uint32_t slot = expbm_slot;
    const uint32_t kind = expbm_kind;
    uint32_t expbm_a[8], expbm_b[8], expbm_r0[8], expbm_r1[8], expbm_r2[8];
    for (uint32_t i = 0; i < 8u; i++) {
        expbm_a[i] = expbm_seed_a[i];
        expbm_b[i] = expbm_seed_b[i];
        expbm_r0[i] = expbm_r1[i] = expbm_r2[i] = 0u;
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPBM_BATCH; i++) {
            if (kind == 0u)      fe25519_mul_lenn(expbm_r0, expbm_a, expbm_b);
            else if (kind == 1u) fe25519_mul_flat_lenn(expbm_r1, expbm_a, expbm_b);
            else                 fe25519_mul_sched_lenn(expbm_r2, expbm_a, expbm_b);
        }
        rep_cyc[slot][r] = dwt_span_end();
    }
}

static void expbm_run_all(void)
{
    static const uint8_t ordA[4] = {0, 1, 1, 0};
    static const uint8_t ordB[4] = {1, 2, 2, 1};
    uint32_t i;

    expaj_stack_prepare();
    run_on_stack(expbm_correct, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expBM flat-mm="); uart_put_u32(expbm_flat_mm);
    uart_puts(" sched-mm="); uart_put_u32(expbm_sched_mm);
    uart_puts(" checks="); uart_put_u32(expbm_checks); uart_puts("\n");
    harness_fails += expbm_flat_mm + expbm_sched_mm;

    for (i = 0; i < 8u; i++) expbm_seed_a[i] = expbm_rng(), expbm_seed_b[i] = expbm_rng();
    for (i = 0; i < 4u; i++) {
        expbm_kind = ordA[i]; expbm_slot = EXPBM_SLOT_BASE + i;
        run_on_stack(expbm_micro, dtcm_stack + sizeof(dtcm_stack));
    }
    for (i = 0; i < 4u; i++) {
        expbm_kind = ordB[i]; expbm_slot = EXPBM_SLOT_BASE + 4u + i;
        run_on_stack(expbm_micro, dtcm_stack + sizeof(dtcm_stack));
    }
    uart_puts("expBM bench done\n");
}
