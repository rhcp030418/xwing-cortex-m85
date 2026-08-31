/* 실험 CC: 교차 종류별 겹침.  Slots 724..735.
 *   724 null
 *   725 M vldrw x umaal   726 N vmul x ldr   727 O vstrw x umaal
 *   728 P vmul x str      729 Q vldrw x vmul
 *   730 b_vldr 731 b_vstr 732 b_vmul 733 b_umaal 734 b_ldr 735 b_str
 * 기준선은 **같은 CC_PRO** 를 쓰므로 오버헤드가 소거된다. */
#define EXPCC_SLOT_BASE 724u

extern void expcc_vldr_umaal(void *b);
extern void expcc_vmul_ldr(void *b);
extern void expcc_vstr_umaal(void *b);
extern void expcc_vmul_str(void *b);
extern void expcc_vldr_vmul(void *b);
extern void expcc_b_vldr(void *b);
extern void expcc_b_vstr(void *b);
extern void expcc_b_vmul(void *b);
extern void expcc_b_umaal(void *b);
extern void expcc_b_ldr(void *b);
extern void expcc_b_str(void *b);

static void expcc_run_all(void)
{
    static const expbl_fn fns[12] = {
        expba_null,
        expcc_vldr_umaal, expcc_vmul_ldr, expcc_vstr_umaal,
        expcc_vmul_str, expcc_vldr_vmul,
        expcc_b_vldr, expcc_b_vstr, expcc_b_vmul,
        expcc_b_umaal, expcc_b_ldr, expcc_b_str,
    };
    uint32_t k, r, i;
    void *buf = (void *) expca_ntt_src;
    for (k = 0; k < 12u; k++) {
        for (r = 0; r < REP_N; r++) {
            dwt_span_begin();
            for (i = 0; i < 64u; i++) fns[k](buf);
            rep_cyc[EXPCC_SLOT_BASE + k][r] = dwt_span_end();
        }
    }
    uart_puts("expCC done\n");
}
