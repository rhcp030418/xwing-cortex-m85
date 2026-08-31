/* 실험 CG: 게스트 재물질화 할당 — 실물 X25519 커널에 NTT 를 끼워 넣는다.
 *   764 P(프롤로그만)  765 A(NTT만)  766 B(sqr만)  767 C(병합)  768 D(호이스팅)
 *   769 E(ldr 풀)  770 E  771 D  772 C  773 B  774 A   <- ABBA
 * E(expCI): 재물질화를 movw 대신 스택 상수 풀의 ldr 로. movw 가 듀얼이슈
 *   안 된다는 expCG/CH 실측에 대한 처방.
 * D(expCH): 재물질화를 사용처에서 떼어 놓은 변형. expCG 의 두 가설을 가른다.
 * 사전등록: 2026-08-27_expCG_guest_alloc_design.md §7
 *
 * 호스트 fe25519_sqr_bb 는 명령 순서·레지스터 모두 원본 그대로다(재정렬조차 없다).
 * 게스트 intt layer67 x4 는 그 지점에서 죽은 호스트 레지스터를 빌리고,
 * 필요한 값(상수·베이스)은 movw/movt 로 재물질화한다.
 */

#define EXPCG_SLOT_BASE 764u
#define EXPCG_BATCH 16u
#define EXPCG_BUF 704u          /* data 0..303 | roots 320..703, 베이스는 +352 */
#define EXPCG_QINIT 128u        /* q0-q7 결정적 초기화 (expCD §2 의 교훈) */

extern void expcg_p_lenn(uint32_t r[8], const uint32_t a[8]);
extern void expcg_a_lenn(uint32_t r[8], const uint32_t a[8]);
extern void expcg_a0_lenn(uint32_t r[8], const uint32_t a[8]);
extern void expcg_b_lenn(uint32_t r[8], const uint32_t a[8]);
extern void expcg_c_lenn(uint32_t r[8], const uint32_t a[8]);
extern void expcg_d_lenn(uint32_t r[8], const uint32_t a[8]);
extern void expcg_e_lenn(uint32_t r[8], const uint32_t a[8]);
extern void fe25519_sqr_bb_lenn(uint32_t r[8], const uint32_t a[8]);

/* expBJ §1 규율: 게스트 버퍼는 실제 NTT 처럼 DTCM 에 둔다. */
uint8_t expcg_buf[EXPCG_BUF] __attribute__((aligned(16), section(".dtcm")));
uint8_t expcg_qinit[EXPCG_QINIT] __attribute__((aligned(16)));   /* 프롤로그 전용 — P/A/B/C 에서 완전히 동일하므로 차분에서 상쇄된다 */

static uint8_t expcg_init[EXPCG_BUF];       /* 원본 사본 — 타이밍 루프 밖 */
static uint8_t expcg_ref[EXPCG_BUF];        /* A 의 출력 — 타이밍 루프 밖 */

static uint32_t expcg_host_mm, expcg_guest_mm, expcg_shl_mm, expcg_checks;
static uint32_t expcg_dhost_mm, expcg_dguest_mm;
static uint32_t expcg_ehost_mm, expcg_eguest_mm;
static volatile uint32_t expcg_kind, expcg_slot;

static uint32_t expcg_rng_s = 0x13572468u;

static uint32_t expcg_rng(void)
{
    uint32_t x = expcg_rng_s;
    x ^= x << 13; x ^= x >> 17; x ^= x << 5;
    expcg_rng_s = x;
    return x;
}

static void expcg_fill(void)
{
    uint32_t x = 0x0badc0deu, i;
    for (i = 0; i < EXPCG_BUF; i++) {
        x ^= x << 13; x ^= x >> 17; x ^= x << 5;
        expcg_init[i] = (uint8_t) x;
    }
    for (i = 0; i < EXPCG_QINIT; i++) {
        x ^= x << 13; x ^= x >> 17; x ^= x << 5;
        expcg_qinit[i] = (uint8_t) x;
    }
}

static void expcg_reset(void)
{
    uint32_t i;
    for (i = 0; i < EXPCG_BUF; i++) expcg_buf[i] = expcg_init[i];
}

static void expcg_correct(void)
{
    /* expBM 과 같은 경계 벡터 7종 */
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
    uint32_t a[8], r0[8], r1[8];
    uint32_t hm = 0, checks = 0, i, k;

    expcg_fill();

    /* (1) 호스트: 병합 커널의 sqr 출력 == 단독 fe25519_sqr_bb, limb 단위 */
    for (i = 0; i < 7u; i++) {
        for (k = 0; k < 8u; k++) a[k] = edge[i][k];
        fe25519_sqr_bb_lenn(r0, a);
        expcg_reset();
        expcg_c_lenn(r1, a);
        for (k = 0; k < 8u; k++) hm += (r0[k] != r1[k]);
        checks++;
    }
    for (i = 0; i < 1000u; i++) {
        for (k = 0; k < 8u; k++) a[k] = expcg_rng();
        fe25519_sqr_bb_lenn(r0, a);
        expcg_reset();
        expcg_c_lenn(r1, a);
        for (k = 0; k < 8u; k++) hm += (r0[k] != r1[k]);
        checks++;
    }
    expcg_host_mm = hm; expcg_checks = checks;

    /* (2) 게스트: 병합 커널의 NTT 출력 == 단독 NTT, 바이트 단위 */
    for (k = 0; k < 8u; k++) a[k] = edge[6][k];
    expcg_reset();
    expcg_a_lenn(r0, a);
    for (i = 0; i < EXPCG_BUF; i++) expcg_ref[i] = expcg_buf[i];
    expcg_reset();
    expcg_c_lenn(r1, a);
    expcg_guest_mm = byte_mismatches(expcg_buf, expcg_ref, EXPCG_BUF);

    /* (3) vshl.i16 #9 == vmul.S16 x512 동치 확인 (논거가 아니라 측정으로) */
    expcg_reset();
    expcg_a0_lenn(r0, a);
    expcg_shl_mm = byte_mismatches(expcg_buf, expcg_ref, EXPCG_BUF);

    /* (4) D(호이스팅본)도 같은 검사를 통과해야 한다 */
    expcg_reset();
    expcg_d_lenn(r1, a);
    expcg_dguest_mm = byte_mismatches(expcg_buf, expcg_ref, EXPCG_BUF);
    {
        uint32_t hm2 = 0;
        for (i = 0; i < 200u; i++) {
            for (k = 0; k < 8u; k++) a[k] = expcg_rng();
            fe25519_sqr_bb_lenn(r0, a);
            expcg_reset();
            expcg_d_lenn(r1, a);
            for (k = 0; k < 8u; k++) hm2 += (r0[k] != r1[k]);
        }
        expcg_dhost_mm = hm2;
    }

    /* (5) E(스택 풀본)도 같은 검사 */
    expcg_reset();
    expcg_e_lenn(r1, a);
    expcg_eguest_mm = byte_mismatches(expcg_buf, expcg_ref, EXPCG_BUF);
    {
        uint32_t hm3 = 0;
        for (i = 0; i < 200u; i++) {
            for (k = 0; k < 8u; k++) a[k] = expcg_rng();
            fe25519_sqr_bb_lenn(r0, a);
            expcg_reset();
            expcg_e_lenn(r1, a);
            for (k = 0; k < 8u; k++) hm3 += (r0[k] != r1[k]);
        }
        expcg_ehost_mm = hm3;
    }
}

static void expcg_bench(void)
{
    const uint32_t slot = expcg_slot, kind = expcg_kind;
    uint32_t a[8], r[8];
    for (uint32_t i = 0; i < 8u; i++) { a[i] = expcg_rng(); r[i] = 0u; }
    for (uint32_t rep = 0; rep < REP_N; rep++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPCG_BATCH; i++) {
            if (kind == 0u)      expcg_p_lenn(r, a);
            else if (kind == 1u) expcg_a_lenn(r, a);
            else if (kind == 2u) expcg_b_lenn(r, a);
            else if (kind == 3u) expcg_c_lenn(r, a);
            else if (kind == 4u) expcg_d_lenn(r, a);
            else                 expcg_e_lenn(r, a);
        }
        rep_cyc[slot][rep] = dwt_span_end();
    }
}

static void expcg_run_all(void)
{
    static const uint8_t ord[11] = {0, 1, 2, 3, 4, 5, 5, 4, 3, 2, 1};
    uint32_t i;

    expaj_stack_prepare();
    run_on_stack(expcg_correct, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expCG host-mm="); uart_put_u32(expcg_host_mm);
    uart_puts(" guest-mm="); uart_put_u32(expcg_guest_mm);
    uart_puts(" shl-mm="); uart_put_u32(expcg_shl_mm);
    uart_puts(" checks="); uart_put_u32(expcg_checks); uart_puts("\n");
    harness_fails += expcg_host_mm + expcg_guest_mm + expcg_shl_mm;

    for (i = 0; i < 11u; i++) {
        expcg_kind = ord[i];
        expcg_slot = EXPCG_SLOT_BASE + i;
        run_on_stack(expcg_bench, dtcm_stack + sizeof(dtcm_stack));
    }
    uart_puts("expCG bench done\n");
}
