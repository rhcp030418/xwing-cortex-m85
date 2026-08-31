/* 실험 BJ (K24 분모): squeeze 배관의 내부 구성.  Slots 608..610.
 *   608 KeccakF1600_StatePermute              (순열만)
 *   609 KeccakF1600_StateExtractBytes(0,168)  (비트-인터리브 해제만)
 *   610 shake128_squeezeblocks(1 block)       (순열+해제+호출)
 * expAQ 의 993 cyc/회는 rename+wrapper 로 잰 값이라 wrapper 비용이 섞여 있다
 * (expBI §3: wrapper 는 호출당 45~84 cyc 까지 든다). 여기서는 직접 부른다. */

#define EXPBJ_SLOT_BASE 608u
/* 611 .bss 상태 순열, 612 DTCM 스택 상태 순열 — 배치 가설 A/B */
#define EXPBJ_BATCH 16u

extern void KeccakF1600_StatePermute(uint64_t *s);
extern void KeccakF1600_StateExtractBytes(uint64_t *s, unsigned char *d,
                                          unsigned int off, unsigned int len);

static shake128ctx expbj_st;
static uint8_t     expbj_buf[SHAKE128_RATE];
static volatile uint32_t expbj_kind;
static volatile uint32_t expbj_slot;

static void expbj_run(void)
{
    const uint32_t slot = expbj_slot;
    const uint32_t kind = expbj_kind;
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPBJ_BATCH; i++) {
            switch (kind) {
            case 0u: KeccakF1600_StatePermute(expbj_st.ctx); break;
            case 1u: KeccakF1600_StateExtractBytes(expbj_st.ctx, expbj_buf, 0u,
                                                   SHAKE128_RATE); break;
            default: shake128_squeezeblocks(expbj_buf, 1u, &expbj_st); break;
            }
        }
        rep_cyc[slot][r] = dwt_span_end();
    }
}

/* 배치 A/B: 같은 순열, 상태만 .bss vs DTCM 스택 */
static void expbj_place_bss(void)
{
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPBJ_BATCH; i++)
            KeccakF1600_StatePermute(expbj_st.ctx);
        rep_cyc[611][r] = dwt_span_end();
    }
}

static void expbj_place_stack(void)
{
    uint64_t local[25];
    for (uint32_t i = 0; i < 25u; i++) local[i] = expbj_st.ctx[i];
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPBJ_BATCH; i++)
            KeccakF1600_StatePermute(local);
        rep_cyc[612][r] = dwt_span_end();
    }
}

volatile uint32_t expbj_sink;

/* 613 extract168 (DTCM 상태), 614 squeezeblocks(1) (DTCM 상태) */
static void expbj_dtcm_parts(void)
{
    shake128ctx st;
    uint8_t buf[SHAKE128_RATE];
    for (uint32_t i = 0; i < 25u; i++) st.ctx[i] = expbj_st.ctx[i];
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPBJ_BATCH; i++)
            KeccakF1600_StateExtractBytes(st.ctx, buf, 0u, SHAKE128_RATE);
        rep_cyc[613][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPBJ_BATCH; i++)
            shake128_squeezeblocks(buf, 1u, &st);
        rep_cyc[614][r] = dwt_span_end();
    }
    expbj_sink = buf[0] + (uint32_t) st.ctx[0];
}

/* 615 libc memcpy 200B (DTCM), 616 워드 memcpy 200B (DTCM)
 * expBG 의 조각 측정은 .bss 버퍼였다. 실제 ML-KEM 경로는 스택(DTCM)이다. */
__attribute__((optimize("no-tree-loop-distribute-patterns")))
static void expbj_dtcm_libc(void)
{
    uint64_t a[25], b[25];
    unsigned k;
    for (k = 0; k < 25u; k++) { a[k] = k; b[k] = 0; }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPBJ_BATCH; i++) __real_memcpy(b, a, 200u);
        rep_cyc[615][r] = dwt_span_end();
    }
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPBJ_BATCH; i++) {
            const uint64_t *sp = a; uint64_t *dp = b;
            for (k = 0; k < 25u; k++) dp[k] = sp[k];
        }
        rep_cyc[616][r] = dwt_span_end();
    }
    expbj_sink += (uint32_t) b[3];
}

static void expbj_run_all(void)
{
    uint32_t i;
    uint8_t seed[32];
    for (i = 0; i < 32u; i++) seed[i] = (uint8_t) (0x40u + i);
    shake128_absorb(&expbj_st, seed, 32u);
    expaj_stack_prepare();
    for (i = 0; i < 3u; i++) {
        expbj_kind = i; expbj_slot = EXPBJ_SLOT_BASE + i;
        run_on_stack(expbj_run, dtcm_stack + sizeof(dtcm_stack));
    }
    run_on_stack(expbj_dtcm_parts, dtcm_stack + sizeof(dtcm_stack));
    run_on_stack(expbj_dtcm_libc, dtcm_stack + sizeof(dtcm_stack));
    run_on_stack(expbj_place_bss, dtcm_stack + sizeof(dtcm_stack));
    run_on_stack(expbj_place_stack, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expBJ done\n");
}
