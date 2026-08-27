/* 실험 CA-1: 스티칭 실증.  Slots 710..716.
 *   710 null  711 A(NTT만)  712 B(Keccak만)  713 C(병합)
 *   ABBA 순서로 714 C  715 B  716 A
 * 사전등록: 2026-08-26_expCA_stitch_prereg.md */

#define EXPCA_SLOT_BASE 710u
#define EXPCA_BATCH 16u
#define EXPCA_NTT_SRC   512u    /* 4 iter x 96 B 전진 + lookahead */
#define EXPCA_NTT_DST   256u    /* 4 iter x 64 B */
#define EXPCA_KEC_BYTES  96u    /* 8 lane x 8 B + 여유 */

extern void expca_ntt_only(void *kec_state, void *kec_out, void *ntt_dst, void *ntt_src);
extern void expca_kec_only(void *kec_state, void *kec_out, void *ntt_dst, void *ntt_src);
extern void expca_merged(void *kec_state, void *kec_out, void *ntt_dst, void *ntt_src);

typedef void (*expca_fn)(void *, void *, void *, void *);

static uint8_t expca_kec_state[EXPCA_KEC_BYTES] __attribute__((aligned(16), section(".dtcm")));
static uint8_t expca_kec_a[EXPCA_KEC_BYTES] __attribute__((aligned(16)));   /* 참조본 — 타이밍 루프 밖 */
static uint8_t expca_kec_c[EXPCA_KEC_BYTES] __attribute__((aligned(16), section(".dtcm")));
static uint8_t expca_ntt_src[EXPCA_NTT_SRC] __attribute__((aligned(16), section(".dtcm")));
static uint8_t expca_ntt_a[EXPCA_NTT_DST] __attribute__((aligned(16)));   /* 참조본 — 타이밍 루프 밖 */
static uint8_t expca_ntt_c[EXPCA_NTT_DST] __attribute__((aligned(16), section(".dtcm")));

static uint32_t expca_ntt_mm = 9, expca_kec_mm = 9;
static volatile uint32_t expca_kind, expca_slot;

static void expca_fill(void)
{
    uint32_t x = 0x1a2b3c4du, i;
    for (i = 0; i < EXPCA_KEC_BYTES; i++) {
        x ^= x << 13; x ^= x >> 17; x ^= x << 5;
        expca_kec_state[i] = (uint8_t) x;
    }
    for (i = 0; i < EXPCA_NTT_SRC; i++) {
        x ^= x << 13; x ^= x >> 17; x ^= x << 5;
        expca_ntt_src[i] = (uint8_t) x;
    }
}

/* 정확성: C 의 두 출력이 A·B 의 출력과 각각 바이트 완전 일치해야 한다 */
static void expca_correct(void)
{
    uint32_t i;
    expca_fill();
    for (i = 0; i < EXPCA_NTT_DST; i++) expca_ntt_a[i] = expca_ntt_c[i] = 0;
    for (i = 0; i < EXPCA_KEC_BYTES; i++) expca_kec_a[i] = expca_kec_c[i] = 0;

    expca_ntt_only(expca_kec_state, expca_kec_a, expca_ntt_a, expca_ntt_src);
    expca_kec_only(expca_kec_state, expca_kec_a, expca_ntt_a, expca_ntt_src);
    /* A·B 를 각각 돌린 뒤의 두 출력을 기준으로 삼는다 */

    expca_merged(expca_kec_state, expca_kec_c, expca_ntt_c, expca_ntt_src);

    expca_ntt_mm = byte_mismatches(expca_ntt_c, expca_ntt_a, EXPCA_NTT_DST);
    expca_kec_mm = byte_mismatches(expca_kec_c, expca_kec_a, EXPCA_KEC_BYTES);
}

static void expca_bench(void)
{
    const uint32_t slot = expca_slot;
    const uint32_t kind = expca_kind;
    static const expca_fn fns[4] = {
        (expca_fn) 0, expca_ntt_only, expca_kec_only, expca_merged
    };
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPCA_BATCH; i++) {
            if (kind == 0u) expba_null(expca_kec_state);
            else fns[kind](expca_kec_state, expca_kec_c, expca_ntt_c, expca_ntt_src);
        }
        rep_cyc[slot][r] = dwt_span_end();
    }
}

static void expca_run_all(void)
{
    static const uint8_t ord[7] = {0, 1, 2, 3, 3, 2, 1};
    uint32_t i;

    expaj_stack_prepare();
    run_on_stack(expca_correct, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expCA correct: ntt-mm="); uart_put_u32(expca_ntt_mm);
    uart_puts(" kec-mm="); uart_put_u32(expca_kec_mm);
    uart_puts("\n");
    harness_fails += expca_ntt_mm + expca_kec_mm;

    for (i = 0; i < 7u; i++) {
        expca_kind = ord[i]; expca_slot = EXPCA_SLOT_BASE + i;
        run_on_stack(expca_bench, dtcm_stack + sizeof(dtcm_stack));
    }
    uart_puts("expCA bench done\n");
}
