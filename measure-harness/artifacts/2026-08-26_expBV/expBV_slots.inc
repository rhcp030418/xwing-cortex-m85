/* 실험 BV: 스칼라 x MVE 동시 발행률.  Slots 690..696.
 *   690 null  691..696 커널 A..F   (expBA/BL 과 같은 차분 방식) */

#define EXPBV_SLOT_BASE 690u
#define EXPBV_BATCH 64u

extern void expbv_umaal_only(void *s);
extern void expbv_vmul_only(void *s);
extern void expbv_vadd_only(void *s);
extern void expbv_mix_mul(void *s);
extern void expbv_mix_add(void *s);
extern void expbv_mix_ldr(void *s);

static void expbv_run_all(void)
{
    static const expbl_fn fns[7] = {
        expba_null,
        expbv_umaal_only, expbv_vmul_only, expbv_vadd_only,
        expbv_mix_mul, expbv_mix_add, expbv_mix_ldr,
    };
    static uint8_t scratch[64] __attribute__((aligned(16)));
    uint32_t k, r, i;

    for (k = 0; k < 7u; k++) {
        for (r = 0; r < REP_N; r++) {
            dwt_span_begin();
            for (i = 0; i < EXPBV_BATCH; i++) fns[k](scratch);
            rep_cyc[EXPBV_SLOT_BASE + k][r] = dwt_span_end();
        }
    }
    uart_puts("expBV done\n");
}
