/* 실험 BZ: MVE 독립 처리율 + 스칼라 겹침 판별.  Slots 703..709. */
#define EXPBZ_SLOT_BASE 703u

extern void expbz_umaal_dep(void *s);
extern void expbz_vmul_dep(void *s);
extern void expbz_vmul_indep(void *s);
extern void expbz_mix_dep(void *s);
extern void expbz_mix_indep(void *s);
extern void expbz_vadd_indep(void *s);

static void expbz_run_all(void)
{
    static const expbl_fn fns[7] = {
        expba_null, expbz_umaal_dep, expbz_vmul_dep, expbz_vmul_indep,
        expbz_mix_dep, expbz_mix_indep, expbz_vadd_indep,
    };
    static uint8_t scratch[64] __attribute__((aligned(16)));
    uint32_t k, r, i;
    for (k = 0; k < 7u; k++) {
        for (r = 0; r < REP_N; r++) {
            dwt_span_begin();
            for (i = 0; i < 64u; i++) fns[k](scratch);
            rep_cyc[EXPBZ_SLOT_BASE + k][r] = dwt_span_end();
        }
    }
    uart_puts("expBZ done\n");
}
