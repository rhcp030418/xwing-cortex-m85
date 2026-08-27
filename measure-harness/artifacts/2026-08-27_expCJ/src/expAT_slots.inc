/* Experiment AT-0: constant-time 표 조회 단가 실측.  Slots 459..472.
 *
 * 사전등록: A주제/measure-harness/2026-08-25_expAT_x06_fixedbase_prereg.md §7 AT-0.
 *
 * X06(fixed-base comb)의 최대 불확실성은 산술이 아니라 **비밀 인덱스로 표를 훑는
 * constant-time select** 비용이다. 사전등록 §5는 이를 scalar ~4 cyc/word 로 추정했지만
 * 추정일 뿐이다. 이 실험이 실측으로 바꾼다.
 *
 * 엔트리 = 96 B (Edwards extended affine: y-x, y+x, 2dxy 각 32 B) = 24 word = 6 q-reg.
 * 후보 수 N ∈ {2,4,8,16} 은 comb 폭 w ∈ {2,3,4,5} 에 대응한다(2^(w-1)).
 *
 * 두 방식을 잰다.
 *   S : scalar mask/or  — word 단위
 *   V : MVE vldrw/vand/vorr — 16 B 단위 (누산기 q0..q5 상주)
 *
 * AM1/AM1b 는 **field arithmetic** 에서 MVE 를 기각했다(4-lane 64-bit 누산 불일치,
 * 표현 변환 왕복 1,921 cyc). 표 조회는 64-bit 누산도 radix 변환도 carry chain 도 없는
 * 순수 load+select 다. 그 기각은 여기에 적용되지 않는다.
 *
 * 슬롯 배치
 *   459..462  scalar  N=2,4,8,16
 *   463..466  MVE     N=2,4,8,16
 *   467       scalar N=8, idx=0      | 468  scalar N=8, idx=7    (상수시간 확인)
 *   469       MVE    N=8, idx=0      | 470  MVE    N=8, idx=7
 *   471       null (배치 루프만)      | 472  예비
 */

#include <arm_mve.h>

#define EXPAT_SLOT_BASE 459u
#define EXPAT_BATCH 64u
#define EXPAT_WORDS 24u        /* 96 B */
#define EXPAT_MAXN 16u

/* 표는 flash 상주 (사전등록 §6: ITCM 에 넣지 않는다) */
static const uint32_t expat_tab[EXPAT_MAXN][EXPAT_WORDS] = {
#define R(x) { x+0u,x+1u,x+2u,x+3u,x+4u,x+5u,x+6u,x+7u,x+8u,x+9u,x+10u,x+11u, \
               x+12u,x+13u,x+14u,x+15u,x+16u,x+17u,x+18u,x+19u,x+20u,x+21u,x+22u,x+23u }
    R(0x10000000u), R(0x20000000u), R(0x30000000u), R(0x40000000u),
    R(0x50000000u), R(0x60000000u), R(0x70000000u), R(0x80000000u),
    R(0x90000000u), R(0xa0000000u), R(0xb0000000u), R(0xc0000000u),
    R(0xd0000000u), R(0xe0000000u), R(0xf0000000u), R(0x01000000u)
#undef R
};

static uint32_t expat_out[EXPAT_WORDS] __attribute__((aligned(16), section(".dtcm")));

/* RAM 상주 사본 — flash 상주와의 차이가 memory-latency 기여분이다 */
static uint32_t expat_tab_ram[EXPAT_MAXN][EXPAT_WORDS] __attribute__((aligned(16)));
static const uint32_t (*expat_src)[EXPAT_WORDS] = expat_tab;

volatile uint32_t expat_mm_scalar = 9;   /* scalar select 결과가 tab[idx] 와 같은가 */
volatile uint32_t expat_mm_mve = 9;      /* MVE select 결과가 tab[idx] 와 같은가 */
volatile uint32_t expat_checks = 0;
volatile uint32_t expat_ct_scalar = 9;   /* idx 별 cycle 차 */
volatile uint32_t expat_ct_mve = 9;

/* ---- S: scalar mask/or ---- */
__attribute__((noinline))
static void expat_select_scalar(uint32_t *out, uint32_t n, uint32_t idx)
{
    for (uint32_t k = 0; k < EXPAT_WORDS; k++) out[k] = 0u;
    for (uint32_t j = 0; j < n; j++) {
        const uint32_t mask = (uint32_t) (-(int32_t) (j == idx));
        const uint32_t *t = expat_src[j];
        for (uint32_t k = 0; k < EXPAT_WORDS; k++) out[k] |= mask & t[k];
    }
}

/* ---- V: MVE, 누산기 6개 q-reg 상주 ---- */
__attribute__((noinline))
static void expat_select_mve(uint32_t *out, uint32_t n, uint32_t idx)
{
    uint32x4_t a0 = vdupq_n_u32(0), a1 = vdupq_n_u32(0), a2 = vdupq_n_u32(0);
    uint32x4_t a3 = vdupq_n_u32(0), a4 = vdupq_n_u32(0), a5 = vdupq_n_u32(0);

    for (uint32_t j = 0; j < n; j++) {
        const uint32_t mask = (uint32_t) (-(int32_t) (j == idx));
        const uint32x4_t m = vdupq_n_u32(mask);
        const uint32_t *t = expat_src[j];
        a0 = vorrq_u32(a0, vandq_u32(vldrwq_u32(t +  0), m));
        a1 = vorrq_u32(a1, vandq_u32(vldrwq_u32(t +  4), m));
        a2 = vorrq_u32(a2, vandq_u32(vldrwq_u32(t +  8), m));
        a3 = vorrq_u32(a3, vandq_u32(vldrwq_u32(t + 12), m));
        a4 = vorrq_u32(a4, vandq_u32(vldrwq_u32(t + 16), m));
        a5 = vorrq_u32(a5, vandq_u32(vldrwq_u32(t + 20), m));
    }
    vstrwq_u32(out +  0, a0); vstrwq_u32(out +  4, a1); vstrwq_u32(out +  8, a2);
    vstrwq_u32(out + 12, a3); vstrwq_u32(out + 16, a4); vstrwq_u32(out + 20, a5);
}

/* ---- V2: MVE + vpselq — mask 를 predicate 레지스터에 두어 q 하나를 아낀다 ---- */
__attribute__((noinline))
static void expat_select_mve2(uint32_t *out, uint32_t n, uint32_t idx)
{
    uint32x4_t a0 = vdupq_n_u32(0), a1 = vdupq_n_u32(0), a2 = vdupq_n_u32(0);
    uint32x4_t a3 = vdupq_n_u32(0), a4 = vdupq_n_u32(0), a5 = vdupq_n_u32(0);

    for (uint32_t j = 0; j < n; j++) {
        const mve_pred16_t p = (mve_pred16_t) ((j == idx) ? 0xFFFFu : 0x0000u);
        const uint32_t *t = expat_src[j];
        a0 = vpselq_u32(vldrwq_u32(t +  0), a0, p);
        a1 = vpselq_u32(vldrwq_u32(t +  4), a1, p);
        a2 = vpselq_u32(vldrwq_u32(t +  8), a2, p);
        a3 = vpselq_u32(vldrwq_u32(t + 12), a3, p);
        a4 = vpselq_u32(vldrwq_u32(t + 16), a4, p);
        a5 = vpselq_u32(vldrwq_u32(t + 20), a5, p);
    }
    vstrwq_u32(out +  0, a0); vstrwq_u32(out +  4, a1); vstrwq_u32(out +  8, a2);
    vstrwq_u32(out + 12, a3); vstrwq_u32(out + 16, a4); vstrwq_u32(out + 20, a5);
}

/* ---- S2: scalar, 4 word 씩 끊어 out 을 레지스터에 유지 ---- */
__attribute__((noinline))
static void expat_select_scalar2(uint32_t *out, uint32_t n, uint32_t idx)
{
    for (uint32_t c = 0; c < EXPAT_WORDS; c += 4u) {
        uint32_t r0 = 0u, r1 = 0u, r2 = 0u, r3 = 0u;
        for (uint32_t j = 0; j < n; j++) {
            const uint32_t mask = (uint32_t) (-(int32_t) (j == idx));
            const uint32_t *t = expat_src[j] + c;
            r0 |= mask & t[0]; r1 |= mask & t[1];
            r2 |= mask & t[2]; r3 |= mask & t[3];
        }
        out[c] = r0; out[c + 1u] = r1; out[c + 2u] = r2; out[c + 3u] = r3;
    }
}

static void expat_correctness(void)
{
    uint32_t mm_s = 0, mm_v = 0, checks = 0;

    for (uint32_t src = 0; src < 2u; src++) {
    expat_src = (src == 0u) ? expat_tab : (const uint32_t (*)[EXPAT_WORDS]) expat_tab_ram;
    for (uint32_t n = 2u; n <= EXPAT_MAXN; n <<= 1) {
        for (uint32_t idx = 0; idx < n; idx++) {
            expat_select_scalar(expat_out, n, idx);
            mm_s += byte_mismatches((const uint8_t *) expat_out,
                                    (const uint8_t *) expat_tab[idx], 96u);
            expat_select_mve(expat_out, n, idx);
            mm_v += byte_mismatches((const uint8_t *) expat_out,
                                    (const uint8_t *) expat_tab[idx], 96u);
            expat_select_mve2(expat_out, n, idx);
            mm_v += byte_mismatches((const uint8_t *) expat_out,
                                    (const uint8_t *) expat_tab[idx], 96u);
            expat_select_scalar2(expat_out, n, idx);
            mm_s += byte_mismatches((const uint8_t *) expat_out,
                                    (const uint8_t *) expat_tab[idx], 96u);
            checks += 4u;
        }
    }
    }
    expat_src = expat_tab;
    expat_mm_scalar = mm_s;
    expat_mm_mve = mm_v;
    expat_checks = checks;
}

static volatile uint32_t expat_kind;   /* 0=scalar 1=MVE 2=null */
static volatile uint32_t expat_n;
static volatile uint32_t expat_idx;
static volatile uint32_t expat_slot;

static void expat_bench_run(void)
{
    const uint32_t slot = expat_slot;
    const uint32_t kind = expat_kind;
    const uint32_t n = expat_n;
    const uint32_t idx = expat_idx;

    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPAT_BATCH; i++) {
            if (kind == 0u)      expat_select_scalar(expat_out, n, idx);
            else if (kind == 1u) expat_select_mve(expat_out, n, idx);
            else if (kind == 3u) expat_select_mve2(expat_out, n, idx);
            else if (kind == 4u) expat_select_scalar2(expat_out, n, idx);
        }
        rep_cyc[slot][r] = dwt_span_end();
    }
}

static void expat_run_all(void)
{
    const uint32_t b = EXPAT_SLOT_BASE;
    uint32_t i;

    for (i = 0; i < EXPAT_MAXN * EXPAT_WORDS; i++) {
        ((uint32_t *) expat_tab_ram)[i] = ((const uint32_t *) expat_tab)[i];
    }

    expaj_stack_prepare();
    run_on_stack(expat_correctness, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAT correctness: scalar-mm="); uart_put_u32(expat_mm_scalar);
    uart_puts(" mve-mm="); uart_put_u32(expat_mm_mve);
    uart_puts(" checks="); uart_put_u32(expat_checks);
    uart_puts("\n");
    harness_fails += expat_mm_scalar + expat_mm_mve;

    /* 459..462 scalar N=2,4,8,16 / 463..466 MVE — idx 는 중간값 고정 */
    for (i = 0; i < 4u; i++) {
        const uint32_t n = 2u << i;
        expat_kind = 0u; expat_n = n; expat_idx = n / 2u; expat_slot = b + i;
        run_on_stack(expat_bench_run, dtcm_stack + sizeof(dtcm_stack));
        expat_kind = 1u; expat_slot = b + 4u + i;
        run_on_stack(expat_bench_run, dtcm_stack + sizeof(dtcm_stack));
    }

    /* 467/468 scalar N=8 idx 0/7, 469/470 MVE N=8 idx 0/7 — 상수시간 확인 */
    expat_n = 8u;
    expat_kind = 0u; expat_idx = 0u; expat_slot = b + 8u;
    run_on_stack(expat_bench_run, dtcm_stack + sizeof(dtcm_stack));
    expat_kind = 0u; expat_idx = 7u; expat_slot = b + 9u;
    run_on_stack(expat_bench_run, dtcm_stack + sizeof(dtcm_stack));
    expat_kind = 1u; expat_idx = 0u; expat_slot = b + 10u;
    run_on_stack(expat_bench_run, dtcm_stack + sizeof(dtcm_stack));
    expat_kind = 1u; expat_idx = 7u; expat_slot = b + 11u;
    run_on_stack(expat_bench_run, dtcm_stack + sizeof(dtcm_stack));

    /* 471 null: 배치 루프 오버헤드 */
    expat_kind = 2u; expat_slot = b + 12u;
    run_on_stack(expat_bench_run, dtcm_stack + sizeof(dtcm_stack));

    /* 473..480 : 같은 실험을 RAM 상주 표로 (473..476 scalar, 477..480 MVE) */
    expat_src = (const uint32_t (*)[EXPAT_WORDS]) expat_tab_ram;
    for (i = 0; i < 4u; i++) {
        const uint32_t n = 2u << i;
        expat_kind = 0u; expat_n = n; expat_idx = n / 2u; expat_slot = b + 14u + i;
        run_on_stack(expat_bench_run, dtcm_stack + sizeof(dtcm_stack));
        expat_kind = 1u; expat_slot = b + 18u + i;
        run_on_stack(expat_bench_run, dtcm_stack + sizeof(dtcm_stack));
    }
    expat_src = expat_tab;

    /* 481..488 : 개선 커널 (481..484 MVE+vpsel, 485..488 scalar chunked), flash 상주 */
    for (i = 0; i < 4u; i++) {
        const uint32_t n = 2u << i;
        expat_kind = 3u; expat_n = n; expat_idx = n / 2u; expat_slot = b + 22u + i;
        run_on_stack(expat_bench_run, dtcm_stack + sizeof(dtcm_stack));
        expat_kind = 4u; expat_slot = b + 26u + i;
        run_on_stack(expat_bench_run, dtcm_stack + sizeof(dtcm_stack));
    }

    expaj_stack_check();
    uart_puts("expAT bench: stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_stack_canary_fails;
}
