/* 실험 BX: core <-> FP vmov 발행 비용.  Slots 697..702. */
#define EXPBX_SLOT_BASE 697u

extern void expbx_umaal_only(void *s);
extern void expbx_vmov_r2s(void *s);
extern void expbx_vmov_s2r(void *s);
extern void expbx_mix_r2s(void *s);
extern void expbx_mix_alu(void *s);

static void expbx_run_all(void)
{
    static const expbl_fn fns[6] = {
        expba_null, expbx_umaal_only, expbx_vmov_r2s,
        expbx_vmov_s2r, expbx_mix_r2s, expbx_mix_alu,
    };
    static uint8_t scratch[64] __attribute__((aligned(16)));
    uint32_t k, r, i;
    for (k = 0; k < 6u; k++) {
        for (r = 0; r < REP_N; r++) {
            dwt_span_begin();
            for (i = 0; i < 64u; i++) fns[k](scratch);
            rep_cyc[EXPBX_SLOT_BASE + k][r] = dwt_span_end();
        }
    }
    uart_puts("expBX done\n");
}
