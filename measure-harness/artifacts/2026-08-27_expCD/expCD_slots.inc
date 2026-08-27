/* 실험 CD: 은닉 용량 곡선.  Slots 736..753.
 *   736 A
 *   737+2k  B(k+1)   738+2k  C(k+1)   (k = 0..7)
 * 사전등록: 2026-08-27_expCD_prereg.md */
#define EXPCD_SLOT_BASE 736u

extern void expcd_a(void*, void*, void*, void*);
extern void expcd_b1(void*,void*,void*,void*);
extern void expcd_c1(void*,void*,void*,void*);
extern void expcd_b2(void*,void*,void*,void*);
extern void expcd_c2(void*,void*,void*,void*);
extern void expcd_b3(void*,void*,void*,void*);
extern void expcd_c3(void*,void*,void*,void*);
extern void expcd_b4(void*,void*,void*,void*);
extern void expcd_c4(void*,void*,void*,void*);
extern void expcd_b5(void*,void*,void*,void*);
extern void expcd_c5(void*,void*,void*,void*);
extern void expcd_b6(void*,void*,void*,void*);
extern void expcd_c6(void*,void*,void*,void*);
extern void expcd_b7(void*,void*,void*,void*);
extern void expcd_c7(void*,void*,void*,void*);
extern void expcd_b8(void*,void*,void*,void*);
extern void expcd_c8(void*,void*,void*,void*);

static uint32_t expcd_ntt_mm, expcd_kec_mm;
static volatile uint32_t expcd_kind, expcd_slot;

static void expcd_correct(void)
{
    static const expca_fn bs[8] = {
        expcd_b1,
        expcd_b2,
        expcd_b3,
        expcd_b4,
        expcd_b5,
        expcd_b6,
        expcd_b7,
        expcd_b8,
    };
    static const expca_fn cs[8] = {
        expcd_c1,
        expcd_c2,
        expcd_c3,
        expcd_c4,
        expcd_c5,
        expcd_c6,
        expcd_c7,
        expcd_c8,
    };
    uint32_t n, i, mmn = 0, mmk = 0;
    expca_fill();

    /* 자가검사: 같은 커널 A 를 두 버퍼에 돌려 비교한다.
     * 여기서 이미 어긋나면 원인은 병합이 아니라 **버퍼/환경**이다.
     *   S1 : ntt_a(SRAM)  대  ntt_c(DTCM)
     *   S2 : ntt_c(DTCM)  대  ntt_c(DTCM) 재실행 */
    {
        uint32_t s1, s2;
        for (i = 0; i < EXPCA_NTT_DST; i++) expca_ntt_a[i] = expca_ntt_c[i] = 0;
        expcd_a(expca_kec_state, expca_kec_a, expca_ntt_a, expca_ntt_src);
        expcd_a(expca_kec_state, expca_kec_a, expca_ntt_c, expca_ntt_src);
        s1 = byte_mismatches(expca_ntt_c, expca_ntt_a, EXPCA_NTT_DST);

        for (i = 0; i < EXPCA_NTT_DST; i++) expca_ntt_c[i] = 0;
        expcd_a(expca_kec_state, expca_kec_a, expca_ntt_c, expca_ntt_src);
        s2 = byte_mismatches(expca_ntt_c, expca_ntt_a, EXPCA_NTT_DST);

        uart_puts("expCD selftest: SRAMvsDTCM="); uart_put_u32(s1);
        uart_puts(" DTCMvsSRAM-again="); uart_put_u32(s2);
        uart_puts("\n");
    }
    for (n = 0; n < 8u; n++) {
        for (i = 0; i < EXPCA_NTT_DST; i++) expca_ntt_a[i] = expca_ntt_c[i] = 0;
        for (i = 0; i < EXPCA_KEC_BYTES; i++) expca_kec_a[i] = expca_kec_c[i] = 0;
        expcd_a(expca_kec_state, expca_kec_a, expca_ntt_a, expca_ntt_src);
        bs[n](expca_kec_state, expca_kec_a, expca_ntt_a, expca_ntt_src);
        cs[n](expca_kec_state, expca_kec_c, expca_ntt_c, expca_ntt_src);
        {
            uint32_t dn = byte_mismatches(expca_ntt_c, expca_ntt_a, EXPCA_NTT_DST);
            uint32_t dk = byte_mismatches(expca_kec_c, expca_kec_a, EXPCA_KEC_BYTES);
            mmn += dn; mmk += dk;
            uart_puts("  expCD n="); uart_put_u32(n + 1u);
            uart_puts(" ntt-mm="); uart_put_u32(dn);
            uart_puts(" kec-mm="); uart_put_u32(dk); uart_puts("\n");
        }
    }
    expcd_ntt_mm = mmn; expcd_kec_mm = mmk;
}

static void expcd_bench(void)
{
    static const expca_fn fns[17] = {
        expcd_a,
        expcd_b1, expcd_c1,
        expcd_b2, expcd_c2,
        expcd_b3, expcd_c3,
        expcd_b4, expcd_c4,
        expcd_b5, expcd_c5,
        expcd_b6, expcd_c6,
        expcd_b7, expcd_c7,
        expcd_b8, expcd_c8,
    };
    const uint32_t slot = expcd_slot, kind = expcd_kind;
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPCA_BATCH; i++)
            fns[kind](expca_kec_state, expca_kec_c, expca_ntt_c, expca_ntt_src);
        rep_cyc[slot][r] = dwt_span_end();
    }
}

static void expcd_run_all(void)
{
    uint32_t k;
    expaj_stack_prepare();
    run_on_stack(expcd_correct, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expCD correct: ntt-mm="); uart_put_u32(expcd_ntt_mm);
    uart_puts(" kec-mm="); uart_put_u32(expcd_kec_mm); uart_puts("\n");
    harness_fails += expcd_ntt_mm + expcd_kec_mm;
    for (k = 0; k < 17u; k++) {
        expcd_kind = k; expcd_slot = EXPCD_SLOT_BASE + k;
        run_on_stack(expcd_bench, dtcm_stack + sizeof(dtcm_stack));
    }
    uart_puts("expCD bench done\n");
}
