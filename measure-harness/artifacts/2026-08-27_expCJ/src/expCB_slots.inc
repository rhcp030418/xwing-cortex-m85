/* 실험 CB-2: MVE x 스칼라 메모리 포트 경합.  Slots 717..723. */
#define EXPCB_SLOT_BASE 717u

extern void expcb_vldr_only(void *b);
extern void expcb_ldr_only(void *b);
extern void expcb_mix_ld(void *b);
extern void expcb_vstr_only(void *b);
extern void expcb_str_only(void *b);
extern void expcb_mix_st(void *b);

static void expcb_run_all(void)
{
    static const expbl_fn fns[7] = {
        expba_null, expcb_vldr_only, expcb_ldr_only, expcb_mix_ld,
        expcb_vstr_only, expcb_str_only, expcb_mix_st,
    };
    uint32_t k, r, i;
    /* 버퍼는 DTCM (expBJ 규율). expCA 의 src 를 빌려 쓴다 — 정확성 검사 이후다. */
    void *buf = (void *) expca_ntt_src;
    for (k = 0; k < 7u; k++) {
        for (r = 0; r < REP_N; r++) {
            dwt_span_begin();
            for (i = 0; i < 64u; i++) fns[k](buf);
            rep_cyc[EXPCB_SLOT_BASE + k][r] = dwt_span_end();
        }
    }
    uart_puts("expCB done\n");
}
