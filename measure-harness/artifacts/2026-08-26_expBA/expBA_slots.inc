/* Experiment BA: 스칼라x스칼라 듀얼이슈 능력.  Slots 538..543.
 * 사전등록: 2026-08-26_expAZ_x01x02_prereg.md §2 의 "여지" 가정을 실측으로 검증한다.
 * 커널당 128 명령, BATCH 64회 배치, null 차감.
 */
#define EXPBA_SLOT_BASE 538u
#define EXPBA_BATCH 64u
#define EXPBA_INSTR 128u

extern void expba_umaal_dep(void *s);
extern void expba_umaal_indep(void *s);
extern void expba_mix(void *s);
extern void expba_add_indep(void *s);
extern void expba_null(void *s);
extern void expba_umaal_str(void *s);
extern void expba_umaal_ldr(void *s);
extern void expba_str_only(void *s);
extern void expba_ldr_only(void *s);

static uint32_t expba_scratch[8] __attribute__((aligned(16), section(".dtcm")));

static volatile uint32_t expba_kind;
static volatile uint32_t expba_slot;

static void expba_bench_run(void)
{
    const uint32_t slot = expba_slot;
    const uint32_t kind = expba_kind;
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPBA_BATCH; i++) {
            switch (kind) {
                case 0u: expba_umaal_dep(expba_scratch); break;
                case 1u: expba_umaal_indep(expba_scratch); break;
                case 2u: expba_mix(expba_scratch); break;
                case 3u: expba_add_indep(expba_scratch); break;
                case 5u: expba_umaal_str(expba_scratch); break;
                case 6u: expba_umaal_ldr(expba_scratch); break;
                case 7u: expba_str_only(expba_scratch); break;
                case 8u: expba_ldr_only(expba_scratch); break;
                default: expba_null(expba_scratch); break;
            }
        }
        rep_cyc[slot][r] = dwt_span_end();
    }
}

static void expba_run_all(void)
{
    for (uint32_t k = 0; k < 9u; k++) {
        expba_kind = k;
        expba_slot = EXPBA_SLOT_BASE + k;
        run_on_stack(expba_bench_run, dtcm_stack + sizeof(dtcm_stack));
    }
    uart_puts("expBA done (128 instr/kernel, batch 64)\n");
}
