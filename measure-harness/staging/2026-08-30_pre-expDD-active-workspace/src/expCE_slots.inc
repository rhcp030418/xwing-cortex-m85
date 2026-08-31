/* 실험 CE: 누출률 법칙 k(메모리 비율).  Slots 753..763.
 *   753 A,  754+2i B(tag_i),  755+2i C(tag_i)   (i = 0..4)
 * 사전등록: 2026-08-27_expCE_prereg.md */
#define EXPCE_SLOT_BASE 753u

extern void expce_a(void*,void*,void*,void*);
extern void expce_b_r00(void*,void*,void*,void*);
extern void expce_c_r00(void*,void*,void*,void*);
extern void expce_b_r08(void*,void*,void*,void*);
extern void expce_c_r08(void*,void*,void*,void*);
extern void expce_b_r16(void*,void*,void*,void*);
extern void expce_c_r16(void*,void*,void*,void*);
extern void expce_b_r24(void*,void*,void*,void*);
extern void expce_c_r24(void*,void*,void*,void*);
extern void expce_b_r32(void*,void*,void*,void*);
extern void expce_c_r32(void*,void*,void*,void*);

static uint32_t expce_mm;
static volatile uint32_t expce_kind, expce_slot;

static const expca_fn expce_fns[11] = {
        expce_a,
        expce_b_r00, expce_c_r00,
        expce_b_r08, expce_c_r08,
        expce_b_r16, expce_c_r16,
        expce_b_r24, expce_c_r24,
        expce_b_r32, expce_c_r32,
};

static void expce_correct(void)
{
    static const expca_fn cs[5] = {
        expce_c_r00, expce_c_r08, expce_c_r16, expce_c_r24, expce_c_r32,
    };
    uint32_t n, i, mm = 0;
    expca_fill();
    for (n = 0; n < 5u; n++) {
        for (i = 0; i < EXPCA_NTT_DST; i++) expca_ntt_a[i] = expca_ntt_c[i] = 0;
        expce_a(expca_kec_state, expca_kec_a, expca_ntt_a, expca_ntt_src);
        cs[n](expca_kec_state, expca_kec_c, expca_ntt_c, expca_ntt_src);
        mm += byte_mismatches(expca_ntt_c, expca_ntt_a, EXPCA_NTT_DST);
    }
    expce_mm = mm;
}

static void expce_bench(void)
{
    const uint32_t slot = expce_slot, kind = expce_kind;
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPCA_BATCH; i++)
            expce_fns[kind](expca_kec_state, expca_kec_c, expca_ntt_c, expca_ntt_src);
        rep_cyc[slot][r] = dwt_span_end();
    }
}

static void expce_run_all(void)
{
    uint32_t k;
    expaj_stack_prepare();
    run_on_stack(expce_correct, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expCE correct: ntt-mm="); uart_put_u32(expce_mm); uart_puts("\n");
    harness_fails += expce_mm;
    for (k = 0; k < 11u; k++) {
        expce_kind = k; expce_slot = EXPCE_SLOT_BASE + k;
        run_on_stack(expce_bench, dtcm_stack + sizeof(dtcm_stack));
    }
    uart_puts("expCE bench done\n");
}
