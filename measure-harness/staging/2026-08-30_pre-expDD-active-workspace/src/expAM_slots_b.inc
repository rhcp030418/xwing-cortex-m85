/* Experiment AM1b: AM1 이 미측정으로 남긴 항목 전부.  Slots 348..359.
 *
 *  ① Lenngren fe25519_sqr 의 M85 단가 (mul/sqr 비중을 추정 -> 실측으로)
 *  ② MVE sqr 전용 커널 (대칭성 활용, 부분곱 100 -> 55)
 *  ③ 로드 재사용 최적화 mul (vldrw 69 -> 45)
 *  ④ 표현 변환 8x32 <-> 10x25.5 비용 (AM0 위험 M4)
 *  ⑤ vmlaldava.u16 8-lane 경로 (AM0 §4 R4, 회계상 기각했으나 미측정이었음)
 *  ⑥ ABI 양보 세금 vpush{d8-d15} / push{r4-r11} (AM0 위험 M6)
 *  ⑦ probe 의 실보드 동작 일치 (AM0 위험 M5)
 */

#include "expAM_conv.h"

extern void fe25519_mul_mve_opt(uint32_t r[10], const uint32_t a[10], const uint32_t b[10]);
extern void fe25519_sqr_mve(uint32_t r[10], const uint32_t a[10]);
extern void fe25519_sqr_lenn(uint32_t r[8], const uint32_t a[8]);
extern void expam_micro_mac_u16(void *s);
extern void expam_micro_vpush(void *s);
extern void expam_micro_pushpop(void *s);
extern void expam_probe_semantics(uint32_t out[12]);
extern void fe25519_mul_null(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);
extern void fe25519_mve_null(uint32_t r[10], const uint32_t a[10], const uint32_t b[10]);

volatile uint32_t expamb_mm_opt   = 9;   /* opt 대 원본 (limb 완전 일치여야) */
volatile uint32_t expamb_mm_sqr   = 9;   /* sqr_mve 대 mul_mve(a,a) */
volatile uint32_t expamb_mm_sqrl  = 9;   /* sqr_mve 대 Lenngren fe25519_sqr */
volatile uint32_t expamb_mm_conv  = 9;   /* 변환 왕복 */
volatile uint32_t expamb_mm_sem   = 9;   /* 명령 의미 probe */
volatile uint32_t expamb_checks   = 0;
volatile uint32_t expamb_sem[12];

static uint32_t expamb_opa8[EXPAM_NPAIR][8] __attribute__((aligned(16), section(".dtcm")));
static uint32_t expamb_res8[8]  __attribute__((aligned(16), section(".dtcm")));
static uint32_t expamb_res10[10] __attribute__((aligned(16), section(".dtcm")));
static uint32_t expamb_chain[10] __attribute__((aligned(16), section(".dtcm")));

static void expamb_correctness(void)
{
    uint32_t mm_opt = 0, mm_sqr = 0, mm_sqrl = 0, mm_conv = 0, mm_sem = 0;
    uint8_t a[32], b[32];
    uint32_t n;

    /* ⑦ 명령 의미 — 실보드 확인 */
    expam_probe_semantics((uint32_t *) expamb_sem);
    {
        uint64_t d1  = ((uint64_t) expamb_sem[1] << 32) | expamb_sem[0];
        uint64_t d2  = ((uint64_t) expamb_sem[3] << 32) | expamb_sem[2];
        uint64_t mb0 = ((uint64_t) expamb_sem[5] << 32) | expamb_sem[4];
        uint64_t mb1 = ((uint64_t) expamb_sem[7] << 32) | expamb_sem[6];
        uint64_t mt0 = ((uint64_t) expamb_sem[9] << 32) | expamb_sem[8];
        uint64_t mt1 = ((uint64_t) expamb_sem[11] << 32) | expamb_sem[10];
        mm_sem += (d1  != 43210u);
        mm_sem += (d2  != 0xfffffff800000004ULL);
        mm_sem += (mb0 != 10u) + (mb1 != 3000u);
        mm_sem += (mt0 != 200u) + (mt1 != 40000u);
    }

    expam_rng = 0x2b1cc0deu;
    for (n = 0; n < 1000u; n++) {
        uint32_t fa[10], fb[10], r1[10], r2[10], w[8], h[10], w2[8];
        uint8_t s1[32], s2[32];

        expam_rand32(a);
        expam_rand32(b);

        /* ③ opt 는 원본과 limb 단위로 완전히 같아야 한다 */
        fe_bytes_tolimbs(fa, a);
        fe_bytes_tolimbs(fb, b);
        fe25519_mul_mve(r1, fa, fb);
        fe25519_mul_mve_opt(r2, fa, fb);
        mm_opt += (memcmp(r1, r2, sizeof(r1)) != 0);

        /* ② sqr(a) == mul(a,a) */
        fe25519_sqr_mve(r2, fa);
        fe25519_mul_mve(r1, fa, fa);
        fe_limbs_tobytes(s1, r2);
        fe_limbs_tobytes(s2, r1);
        mm_sqr += (memcmp(s1, s2, 32) != 0);

        /* ② sqr_mve 대 생산 코드 Lenngren fe25519_sqr */
        {
            uint32_t la[8], lr[8];
            uint32_t i;
            for (i = 0; i < 8u; i++)
                la[i] = (uint32_t)a[4*i] | ((uint32_t)a[4*i+1]<<8)
                      | ((uint32_t)a[4*i+2]<<16) | ((uint32_t)a[4*i+3]<<24);
            fe25519_sqr_lenn(lr, la);
            fe_words_tobytes(s2, lr);
            mm_sqrl += (memcmp(s1, s2, 32) != 0);
        }

        /* ④ 변환 왕복 */
        {
            uint32_t i;
            for (i = 0; i < 8u; i++)
                w[i] = (uint32_t)a[4*i] | ((uint32_t)a[4*i+1]<<8)
                     | ((uint32_t)a[4*i+2]<<16) | ((uint32_t)a[4*i+3]<<24);
            fe_8x32_to_1025(h, w);
            fe_1025_to_8x32(w2, h);
            fe_words_tobytes(s1, w);
            fe_words_tobytes(s2, w2);
            mm_conv += (memcmp(s1, s2, 32) != 0);
        }
        expamb_checks++;
    }

    expamb_mm_opt = mm_opt;
    expamb_mm_sqr = mm_sqr;
    expamb_mm_sqrl = mm_sqrl;
    expamb_mm_conv = mm_conv;
    expamb_mm_sem = mm_sem;
}

/* ---------------- 벤치 ---------------- */

static volatile uint32_t expamb_slot;
static volatile uint32_t expamb_kind;
/* 0=A sqr 1=B sqr 2=opt mul indep 3=opt mul chain 4=B mul(a,a)
 * 5=conv 8->10  6=conv 10->8 */

static void expamb_bench_run(void)
{
    const uint32_t slot = expamb_slot;
    const uint32_t kind = expamb_kind;
    uint32_t r;

    for (r = 0; r < REP_N; r++) {
        uint32_t i;
        switch (kind) {
        case 0:
            dwt_span_begin();
            for (i = 0; i < EXPAM_BATCH; i++)
                fe25519_sqr_lenn(expamb_res8, expamb_opa8[i & (EXPAM_NPAIR-1u)]);
            rep_cyc[slot][r] = dwt_span_end();
            break;
        case 1:
            dwt_span_begin();
            for (i = 0; i < EXPAM_BATCH; i++)
                fe25519_sqr_mve(expamb_res10, expam_opa[i & (EXPAM_NPAIR-1u)]);
            rep_cyc[slot][r] = dwt_span_end();
            break;
        case 2:
            dwt_span_begin();
            for (i = 0; i < EXPAM_BATCH; i++)
                fe25519_mul_mve_opt(expamb_res10, expam_opa[i & (EXPAM_NPAIR-1u)],
                                                  expam_opb[i & (EXPAM_NPAIR-1u)]);
            rep_cyc[slot][r] = dwt_span_end();
            break;
        case 3:
            memcpy(expamb_chain, expam_opa[0], 40);
            dwt_span_begin();
            for (i = 0; i < EXPAM_BATCH; i++)
                fe25519_mul_mve_opt(expamb_chain, expamb_chain,
                                    expam_opb[i & (EXPAM_NPAIR-1u)]);
            rep_cyc[slot][r] = dwt_span_end();
            break;
        case 4:
            dwt_span_begin();
            for (i = 0; i < EXPAM_BATCH; i++)
                fe25519_mul_mve(expamb_res10, expam_opa[i & (EXPAM_NPAIR-1u)],
                                              expam_opa[i & (EXPAM_NPAIR-1u)]);
            rep_cyc[slot][r] = dwt_span_end();
            break;
        case 7:
            dwt_span_begin();
            for (i = 0; i < EXPAM_BATCH; i++)
                fe25519_mul_null(expamb_res8, expamb_opa8[i & (EXPAM_NPAIR-1u)],
                                              expamb_opa8[i & (EXPAM_NPAIR-1u)]);
            rep_cyc[slot][r] = dwt_span_end();
            break;
        case 8:
            dwt_span_begin();
            for (i = 0; i < EXPAM_BATCH; i++)
                fe25519_mve_null(expamb_res10, expam_opa[i & (EXPAM_NPAIR-1u)],
                                               expam_opb[i & (EXPAM_NPAIR-1u)]);
            rep_cyc[slot][r] = dwt_span_end();
            break;
        case 5:
            dwt_span_begin();
            for (i = 0; i < EXPAM_BATCH; i++)
                fe_8x32_to_1025(expamb_res10, expamb_opa8[i & (EXPAM_NPAIR-1u)]);
            rep_cyc[slot][r] = dwt_span_end();
            break;
        default:
            dwt_span_begin();
            for (i = 0; i < EXPAM_BATCH; i++)
                fe_1025_to_8x32(expamb_res8, expam_opa[i & (EXPAM_NPAIR-1u)]);
            rep_cyc[slot][r] = dwt_span_end();
            break;
        }
    }
}

static volatile uint32_t expamb_micro_slot;
static volatile uint32_t expamb_micro_kind;

static void expamb_micro_run(void)
{
    const uint32_t slot = expamb_micro_slot;
    const uint32_t kind = expamb_micro_kind;
    uint32_t r;
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        switch (kind) {
        case 0: expam_micro_mac_u16(expam_scratch); break;
        case 1: expam_micro_vpush(expam_scratch);   break;
        default: expam_micro_pushpop(expam_scratch); break;
        }
        rep_cyc[slot][r] = dwt_span_end();
    }
}

/* ---------------- 진입점 ---------------- */

static void expamb_run_all(void)
{
    static const uint8_t ord_sqr[4] = {0, 1, 1, 0};
    uint32_t i;

    /* expam_opa[] 의 8x32 대응본 준비 (같은 값) */
    for (i = 0; i < EXPAM_NPAIR; i++) {
        fe_1025_to_8x32(expamb_opa8[i], expam_opa[i]);
    }

    expaj_stack_prepare();
    run_on_stack(expamb_correctness, dtcm_stack + sizeof(dtcm_stack));
    expaj_stack_check();
    uart_puts("expAMb correctness: opt-mm="); uart_put_u32(expamb_mm_opt);
    uart_puts(" sqr-mm="); uart_put_u32(expamb_mm_sqr);
    uart_puts(" sqrlenn-mm="); uart_put_u32(expamb_mm_sqrl);
    uart_puts(" conv-mm="); uart_put_u32(expamb_mm_conv);
    uart_puts(" sem-mm="); uart_put_u32(expamb_mm_sem);
    uart_puts(" checks="); uart_put_u32(expamb_checks);
    uart_puts(" stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expamb_mm_opt + expamb_mm_sqr + expamb_mm_sqrl
                   + expamb_mm_conv + expamb_mm_sem + expaj_stack_canary_fails;

    expaj_stack_prepare();
    /* sqr ABBA: 348 A / 349 B / 350 B / 351 A */
    for (i = 0; i < 4u; i++) {
        expamb_kind = ord_sqr[i];
        expamb_slot = 348u + i;
        run_on_stack(expamb_bench_run, dtcm_stack + sizeof(dtcm_stack));
    }
    /* 352 opt indep, 353 opt chain, 354 B mul(a,a), 355/356 변환 */
    expamb_kind = 2u; expamb_slot = 352u;
    run_on_stack(expamb_bench_run, dtcm_stack + sizeof(dtcm_stack));
    expamb_kind = 3u; expamb_slot = 353u;
    run_on_stack(expamb_bench_run, dtcm_stack + sizeof(dtcm_stack));
    expamb_kind = 4u; expamb_slot = 354u;
    run_on_stack(expamb_bench_run, dtcm_stack + sizeof(dtcm_stack));
    expamb_kind = 5u; expamb_slot = 355u;
    run_on_stack(expamb_bench_run, dtcm_stack + sizeof(dtcm_stack));
    expamb_kind = 6u; expamb_slot = 356u;
    run_on_stack(expamb_bench_run, dtcm_stack + sizeof(dtcm_stack));
    /* 360 A-스타일 null, 361 B-스타일 null (루프+래퍼 오버헤드 기준선) */
    expamb_kind = 7u; expamb_slot = 360u;
    run_on_stack(expamb_bench_run, dtcm_stack + sizeof(dtcm_stack));
    expamb_kind = 8u; expamb_slot = 361u;
    run_on_stack(expamb_bench_run, dtcm_stack + sizeof(dtcm_stack));
    /* 357 u16 MAC, 358 vpush 세금, 359 push 세금 */
    for (i = 0; i < 3u; i++) {
        expamb_micro_kind = i;
        expamb_micro_slot = 357u + i;
        run_on_stack(expamb_micro_run, dtcm_stack + sizeof(dtcm_stack));
    }
    expaj_stack_check();
    uart_puts("expAMb bench done stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_stack_canary_fails;
}
