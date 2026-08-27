/* 실험 BL: shifted-operand ALU 발행 규칙.  Slots 633..641.
 *   633 null(빈 호출)  634..641 커널 A..H
 * expBA 와 같은 차분 방식: 커널 - null 로 128 명령의 순비용을 얻는다.
 */

#define EXPBL_SLOT_BASE 633u
#define EXPBL_BATCH 64u
#define EXPBL_INSTR 128u

extern void expbl_plain_indep(void *s);
extern void expbl_plain_dep(void *s);
extern void expbl_shift_indep(void *s);
extern void expbl_shift_dep(void *s);
extern void expbl_mix_indep(void *s);
extern void expbl_andimm_indep(void *s);
extern void expbl_bfi_indep(void *s);
extern void expbl_fbi_chain(void *s);
extern void expba_null(void *s);

typedef void (*expbl_fn)(void *);

static void expbl_run_all(void)
{
    static const expbl_fn fns[9] = {
        expba_null,
        expbl_plain_indep, expbl_plain_dep,
        expbl_shift_indep, expbl_shift_dep,
        expbl_mix_indep, expbl_andimm_indep,
        expbl_bfi_indep, expbl_fbi_chain,
    };
    static uint8_t scratch[64];
    uint32_t k, r, i;

    for (k = 0; k < 9u; k++) {
        for (r = 0; r < REP_N; r++) {
            dwt_span_begin();
            for (i = 0; i < EXPBL_BATCH; i++) fns[k](scratch);
            rep_cyc[EXPBL_SLOT_BASE + k][r] = dwt_span_end();
        }
    }
    uart_puts("expBL done\n");
}
