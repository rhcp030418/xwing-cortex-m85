/* Experiment AM1: MVE field-mul feasibility gate.  Slots 333..347.
 * 사전등록: A주제/measure-harness/2026-08-25_expAM1_mve_mul_prereg.md
 * 설계:     A주제/measure-harness/2026-08-25_expAM_x25519_mve_design.md
 *
 * A  = fe25519_mul (Lenngren 8x32, ITCM) — 대표 경로가 실제 호출하는 것
 * B1 = fe25519_mul_mve (radix 2^25.5 열-스캐닝 MVE, ITCM)
 * 둘 다 ITCM 배치 = 코드 배치 단일변수.
 */

extern void fe25519_mul_mve(uint32_t r[10], const uint32_t a[10], const uint32_t b[10]);
extern void fe25519_mul_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);
extern void expam_micro_empty(void *s);
extern void expam_micro_mac_indep(void *s);
extern void expam_micro_mac_dep(void *s);
extern void expam_micro_vldrw(void *s);
extern void expam_micro_vmull(void *s);
extern void expam_micro_umaal(void *s);
extern void expam_micro_mixed(void *s);

#define EXPAM_BATCH 64u
#define EXPAM_NPAIR 8u

volatile uint32_t expam_mm_oracle   = 9;  /* B1 대 독립 oracle */
volatile uint32_t expam_mm_lenn     = 9;  /* B1 대 Lenngren(생산 코드) 차분 */
volatile uint32_t expam_mm_boundary = 9;
volatile uint32_t expam_mm_alias    = 9;
volatile uint32_t expam_mm_align    = 9;
volatile uint32_t expam_ct_delta    = 0;  /* 상수시간: 두 비밀 입력 cycle 차 */
volatile uint32_t expam_checks      = 0;

static uint8_t  expam_scratch[512] __attribute__((aligned(16), section(".dtcm")));
static uint32_t expam_opa[EXPAM_NPAIR][10] __attribute__((aligned(16), section(".dtcm")));
static uint32_t expam_opb[EXPAM_NPAIR][10] __attribute__((aligned(16), section(".dtcm")));
static uint32_t expam_res[10] __attribute__((aligned(16), section(".dtcm")));
static uint32_t expam_chain[10] __attribute__((aligned(16), section(".dtcm")));

static const uint8_t EXPAM_LW[10]   = {26,25,26,25,26,25,26,25,26,25};
static const uint8_t EXPAM_LOFF[10] = {0,26,51,77,102,128,153,179,204,230};

/* ---------------- 표현 변환 ---------------- */

static void expam_frombytes(uint32_t h[10], const uint8_t s[32])
{
    for (uint32_t i = 0; i < 10u; i++) {
        uint32_t off = EXPAM_LOFF[i];
        uint64_t w = 0;
        for (uint32_t k = 0; k < 5u; k++) {
            uint32_t bi = (off >> 3) + k;
            if (bi < 32u) w |= (uint64_t) s[bi] << (8u * k);
        }
        w >>= (off & 7u);
        h[i] = (uint32_t) (w & ((1u << EXPAM_LW[i]) - 1u));
    }
}

/* 8x32 워드값(< 2^256)을 mod 2^255-19 정규 32 byte 로 */
static void expam_words_tobytes(uint8_t s[32], const uint32_t win[8])
{
    uint32_t w[8];
    for (uint32_t i = 0; i < 8u; i++) w[i] = win[i];

    for (uint32_t round = 0; round < 4u; round++) {
        uint32_t top = (w[7] >> 31) & 1u;
        if (!top) break;
        w[7] &= 0x7fffffffu;
        uint64_t carry = 19u;
        for (uint32_t i = 0; i < 8u && carry; i++) {
            uint64_t v = (uint64_t) w[i] + (carry & 0xffffffffu);
            w[i] = (uint32_t) v;
            carry = (carry >> 32) + (v >> 32);
        }
    }
    uint32_t q[8];
    uint64_t c = 19u;
    for (uint32_t i = 0; i < 8u; i++) { c += w[i]; q[i] = (uint32_t) c; c >>= 32; }
    uint32_t mask = 0u - ((q[7] >> 31) & 1u);
    q[7] &= 0x7fffffffu;
    for (uint32_t i = 0; i < 8u; i++) w[i] = (w[i] & ~mask) | (q[i] & mask);
    w[7] &= 0x7fffffffu;
    for (uint32_t i = 0; i < 8u; i++) {
        s[4*i+0] = (uint8_t) w[i];        s[4*i+1] = (uint8_t)(w[i] >> 8);
        s[4*i+2] = (uint8_t)(w[i] >> 16); s[4*i+3] = (uint8_t)(w[i] >> 24);
    }
}

static void expam_tobytes(uint8_t s[32], const uint32_t h_in[10])
{
    uint64_t t[10];
    for (uint32_t i = 0; i < 10u; i++) t[i] = h_in[i];
    for (uint32_t pass = 0; pass < 3u; pass++) {
        uint64_t c = 0;
        for (uint32_t i = 0; i < 10u; i++) {
            t[i] += c; c = t[i] >> EXPAM_LW[i];
            t[i] &= ((uint64_t) 1 << EXPAM_LW[i]) - 1u;
        }
        t[0] += 19u * c;
    }
    uint32_t w[8];
    memset(w, 0, sizeof(w));
    for (uint32_t i = 0; i < 10u; i++) {
        uint32_t off = EXPAM_LOFF[i];
        uint64_t carry = t[i] << (off & 31u);
        uint32_t wi = off >> 5;
        while (carry && wi < 8u) {
            uint64_t sum = (uint64_t) w[wi] + (carry & 0xffffffffu);
            w[wi] = (uint32_t) sum;
            carry = (carry >> 32) + (sum >> 32);
            wi++;
        }
    }
    expam_words_tobytes(s, w);
}

/* ---------------- 독립 oracle (B1 과 다른 알고리즘) ---------------- */

static void expam_oracle_mul(uint8_t out[32], const uint8_t a[32], const uint8_t b[32])
{
    uint32_t x[8], y[8], prod[16];
    for (uint32_t i = 0; i < 8u; i++) {
        x[i] = (uint32_t)a[4*i] | ((uint32_t)a[4*i+1]<<8) | ((uint32_t)a[4*i+2]<<16) | ((uint32_t)a[4*i+3]<<24);
        y[i] = (uint32_t)b[4*i] | ((uint32_t)b[4*i+1]<<8) | ((uint32_t)b[4*i+2]<<16) | ((uint32_t)b[4*i+3]<<24);
    }
    memset(prod, 0, sizeof(prod));
    for (uint32_t i = 0; i < 8u; i++) {
        uint64_t carry = 0;
        for (uint32_t j = 0; j < 8u; j++) {
            uint64_t v = (uint64_t) x[i] * y[j] + prod[i+j] + carry;
            prod[i+j] = (uint32_t) v; carry = v >> 32;
        }
        prod[i+8] = (uint32_t) carry;
    }
    /* 2^256 = 38 (mod p) */
    uint32_t lo[8]; uint32_t hi[8];
    for (uint32_t i = 0; i < 8u; i++) { lo[i] = prod[i]; hi[i] = prod[i+8]; }
    for (uint32_t round = 0; round < 3u; round++) {
        uint64_t carry = 0;
        for (uint32_t i = 0; i < 8u; i++) {
            uint64_t v = (uint64_t) lo[i] + (uint64_t) hi[i] * 38u + carry;
            lo[i] = (uint32_t) v; carry = v >> 32;
        }
        memset(hi, 0, sizeof(hi));
        hi[0] = (uint32_t) carry;
        if (carry == 0) break;
    }
    expam_words_tobytes(out, lo);
}

/* ---------------- 결정적 PRNG ---------------- */

static uint32_t expam_rng;
static uint32_t expam_next(void)
{
    uint32_t x = expam_rng;
    x ^= x << 13; x ^= x >> 17; x ^= x << 5;
    expam_rng = x; return x;
}
static void expam_rand32(uint8_t s[32])
{
    for (uint32_t i = 0; i < 32u; i += 4u) {
        uint32_t v = expam_next();
        s[i] = (uint8_t)v; s[i+1] = (uint8_t)(v>>8);
        s[i+2] = (uint8_t)(v>>16); s[i+3] = (uint8_t)(v>>24);
    }
    s[31] &= 0x7fu;
}

/* ---------------- 정확성 게이트 ---------------- */

static const uint8_t EXPAM_V0[32] = {0};
static const uint8_t EXPAM_V1[32] = {1};
static const uint8_t EXPAM_VPM1[32] = {
    0xec,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
    0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x7f};
static const uint8_t EXPAM_VP[32] = {
    0xed,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
    0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x7f};
static const uint8_t EXPAM_VMAX[32] = {
    0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
    0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x7f};

/* B1 을 oracle 및 Lenngren 과 동시에 대조한다. */
static void expam_check(const uint8_t a[32], const uint8_t b[32],
                        volatile uint32_t *slot_oracle, volatile uint32_t *slot_lenn)
{
    uint32_t fa[10], fb[10], fr[10];
    uint32_t la[8], lb[8], lr[8];
    uint8_t got[32], want[32], gotl[32];

    expam_frombytes(fa, a);
    expam_frombytes(fb, b);
    fe25519_mul_mve(fr, fa, fb);
    expam_tobytes(got, fr);

    expam_oracle_mul(want, a, b);
    if (memcmp(got, want, 32) != 0) (*slot_oracle)++;

    for (uint32_t i = 0; i < 8u; i++) {
        la[i] = (uint32_t)a[4*i] | ((uint32_t)a[4*i+1]<<8) | ((uint32_t)a[4*i+2]<<16) | ((uint32_t)a[4*i+3]<<24);
        lb[i] = (uint32_t)b[4*i] | ((uint32_t)b[4*i+1]<<8) | ((uint32_t)b[4*i+2]<<16) | ((uint32_t)b[4*i+3]<<24);
    }
    fe25519_mul_lenn(lr, la, lb);
    expam_words_tobytes(gotl, lr);
    if (memcmp(got, gotl, 32) != 0) (*slot_lenn)++;

    expam_checks++;
}

static void expam_correctness(void)
{
    const uint8_t *bnd[5] = {EXPAM_V0, EXPAM_V1, EXPAM_VPM1, EXPAM_VP, EXPAM_VMAX};
    uint32_t mm_o = 0, mm_l = 0, mm_b = 0, mm_a = 0, mm_g = 0;
    uint8_t a[32], b[32];

    expam_mm_oracle = 0; expam_mm_lenn = 0; expam_checks = 0;

    /* 경계값 전 조합 */
    for (uint32_t i = 0; i < 5u; i++)
        for (uint32_t j = 0; j < 5u; j++)
            expam_check(bnd[i], bnd[j], &expam_mm_oracle, &expam_mm_lenn);
    mm_b = expam_mm_oracle + expam_mm_lenn;

    /* 결정적 임의 1,000 seed */
    expam_rng = 0x5eed1234u;
    for (uint32_t n = 0; n < 1000u; n++) {
        expam_rand32(a); expam_rand32(b);
        expam_check(a, b, &expam_mm_oracle, &expam_mm_lenn);
    }
    mm_o = expam_mm_oracle; mm_l = expam_mm_lenn;

    /* alias: r==a, r==b, r==a==b */
    expam_rng = 0x13572468u;
    for (uint32_t n = 0; n < 25u; n++) {
        uint32_t fa[10], fb[10], ref[10], t[10];
        uint8_t want[32], got[32];
        expam_rand32(a); expam_rand32(b);
        expam_frombytes(fa, a); expam_frombytes(fb, b);
        fe25519_mul_mve(ref, fa, fb); expam_tobytes(want, ref);

        memcpy(t, fa, sizeof(t)); fe25519_mul_mve(t, t, fb);
        expam_tobytes(got, t); mm_a += (memcmp(got, want, 32) != 0);

        memcpy(t, fb, sizeof(t)); fe25519_mul_mve(t, fa, t);
        expam_tobytes(got, t); mm_a += (memcmp(got, want, 32) != 0);

        fe25519_mul_mve(ref, fa, fa); expam_tobytes(want, ref);
        memcpy(t, fa, sizeof(t)); fe25519_mul_mve(t, t, t);
        expam_tobytes(got, t); mm_a += (memcmp(got, want, 32) != 0);

        /* 정렬 offset 0/4/8/12/16 B */
        for (uint32_t off = 0; off <= 16u; off += 4u) {
            uint32_t *pa = (uint32_t *)(expam_scratch + off);
            uint32_t *pb = (uint32_t *)(expam_scratch + 64u + off);
            uint32_t *pr = (uint32_t *)(expam_scratch + 128u + off);
            fe25519_mul_mve(ref, fa, fb); expam_tobytes(want, ref);
            memcpy(pa, fa, 40); memcpy(pb, fb, 40);
            fe25519_mul_mve(pr, pa, pb);
            expam_tobytes(got, pr); mm_g += (memcmp(got, want, 32) != 0);
        }
    }
    expam_mm_boundary = mm_b;
    expam_mm_alias = mm_a;
    expam_mm_align = mm_g;
    (void) mm_o; (void) mm_l;
}

/* ---------------- 벤치 ---------------- */

static volatile uint32_t expam_bench_slot;
static volatile uint32_t expam_bench_kind;   /* 0=A indep 1=B indep 2=A chain 3=B chain */

static void expam_bench_run(void)
{
    const uint32_t slot = expam_bench_slot;
    const uint32_t kind = expam_bench_kind;

    for (uint32_t r = 0; r < REP_N; r++) {
        if (kind == 0u) {
            dwt_span_begin();
            for (uint32_t i = 0; i < EXPAM_BATCH; i++)
                fe25519_mul_lenn(expam_res, expam_opa[i & (EXPAM_NPAIR-1u)],
                                            expam_opb[i & (EXPAM_NPAIR-1u)]);
            rep_cyc[slot][r] = dwt_span_end();
        } else if (kind == 1u) {
            dwt_span_begin();
            for (uint32_t i = 0; i < EXPAM_BATCH; i++)
                fe25519_mul_mve(expam_res, expam_opa[i & (EXPAM_NPAIR-1u)],
                                           expam_opb[i & (EXPAM_NPAIR-1u)]);
            rep_cyc[slot][r] = dwt_span_end();
        } else if (kind == 2u) {
            memcpy(expam_chain, expam_opa[0], 40);
            dwt_span_begin();
            for (uint32_t i = 0; i < EXPAM_BATCH; i++)
                fe25519_mul_lenn(expam_chain, expam_chain, expam_opb[i & (EXPAM_NPAIR-1u)]);
            rep_cyc[slot][r] = dwt_span_end();
        } else {
            memcpy(expam_chain, expam_opa[0], 40);
            dwt_span_begin();
            for (uint32_t i = 0; i < EXPAM_BATCH; i++)
                fe25519_mul_mve(expam_chain, expam_chain, expam_opb[i & (EXPAM_NPAIR-1u)]);
            rep_cyc[slot][r] = dwt_span_end();
        }
    }
}

static volatile uint32_t expam_micro_slot;
static volatile uint32_t expam_micro_kind;

static void expam_micro_run(void)
{
    const uint32_t slot = expam_micro_slot;
    const uint32_t kind = expam_micro_kind;
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        switch (kind) {
        case 0: expam_micro_mac_indep(expam_scratch); break;
        case 1: expam_micro_mac_dep(expam_scratch);   break;
        case 2: expam_micro_vldrw(expam_scratch);     break;
        case 3: expam_micro_vmull(expam_scratch);     break;
        case 4: expam_micro_umaal(expam_scratch);     break;
        case 5: expam_micro_mixed(expam_scratch);     break;
        default: expam_micro_empty(expam_scratch);    break;
        }
        rep_cyc[slot][r] = dwt_span_end();
    }
}

/* ---------------- 진입점 ---------------- */

static void expam_run_all(void)
{
    uint8_t s[32];

    /* 피연산자 준비: 결정적 임의값, 두 표현 모두에서 유효 */
    expam_rng = 0xa11ce5eeu;
    for (uint32_t i = 0; i < EXPAM_NPAIR; i++) {
        expam_rand32(s); expam_frombytes(expam_opa[i], s);
        expam_rand32(s); expam_frombytes(expam_opb[i], s);
    }
    for (uint32_t i = 0; i < 512u; i++) expam_scratch[i] = (uint8_t)(i * 7u + 1u);

    /* 정확성 먼저 */
    expaj_stack_prepare();
    run_on_stack(expam_correctness, dtcm_stack + sizeof(dtcm_stack));
    expaj_stack_check();
    uart_puts("expAM correctness: oracle-mm="); uart_put_u32(expam_mm_oracle);
    uart_puts(" lenn-mm="); uart_put_u32(expam_mm_lenn);
    uart_puts(" boundary-mm="); uart_put_u32(expam_mm_boundary);
    uart_puts(" alias-mm="); uart_put_u32(expam_mm_alias);
    uart_puts(" align-mm="); uart_put_u32(expam_mm_align);
    uart_puts(" checks="); uart_put_u32(expam_checks);
    uart_puts(" stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expam_mm_oracle + expam_mm_lenn + expam_mm_boundary
                   + expam_mm_alias + expam_mm_align + expaj_stack_canary_fails;

    /* 성능: ABBA.  독립 피연산자 333..336, 의존 체인 337..340 */
    static const uint8_t ord_kind_i[4] = {0, 1, 1, 0};
    static const uint8_t ord_kind_c[4] = {2, 3, 3, 2};
    expaj_stack_prepare();
    for (uint32_t i = 0; i < 4u; i++) {
        expam_bench_kind = ord_kind_i[i];
        expam_bench_slot = 333u + i;
        run_on_stack(expam_bench_run, dtcm_stack + sizeof(dtcm_stack));
    }
    for (uint32_t i = 0; i < 4u; i++) {
        expam_bench_kind = ord_kind_c[i];
        expam_bench_slot = 337u + i;
        run_on_stack(expam_bench_run, dtcm_stack + sizeof(dtcm_stack));
    }
    /* 마이크로 스루풋 341..347 */
    for (uint32_t i = 0; i < 7u; i++) {
        expam_micro_kind = i;
        expam_micro_slot = 341u + i;
        run_on_stack(expam_micro_run, dtcm_stack + sizeof(dtcm_stack));
    }
    expaj_stack_check();

    /* 상수시간: 서로 다른 두 비밀 피연산자로 같은 배치를 재고 차이를 본다 */
    {
        uint32_t c1, c2;
        expam_bench_kind = 1u; expam_bench_slot = 334u;
        run_on_stack(expam_bench_run, dtcm_stack + sizeof(dtcm_stack));
        c1 = rep_cyc[334][REP_N/2u];
        expam_rng = 0xdeadbeefu;
        for (uint32_t i = 0; i < EXPAM_NPAIR; i++) {
            expam_rand32(s); expam_frombytes(expam_opa[i], s);
            expam_rand32(s); expam_frombytes(expam_opb[i], s);
        }
        run_on_stack(expam_bench_run, dtcm_stack + sizeof(dtcm_stack));
        c2 = rep_cyc[334][REP_N/2u];
        expam_ct_delta = (c1 > c2) ? (c1 - c2) : (c2 - c1);
    }
    uart_puts("expAM ct-delta: "); uart_put_u32(expam_ct_delta);
    uart_puts(" batch="); uart_put_u32(EXPAM_BATCH);
    uart_puts(" stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_stack_canary_fails;

    /* 상수시간 검사가 slot 334 를 덮었으므로 원래 피연산자로 복원해 재측정 */
    expam_rng = 0xa11ce5eeu;
    for (uint32_t i = 0; i < EXPAM_NPAIR; i++) {
        expam_rand32(s); expam_frombytes(expam_opa[i], s);
        expam_rand32(s); expam_frombytes(expam_opb[i], s);
    }
    expam_bench_kind = 1u; expam_bench_slot = 334u;
    run_on_stack(expam_bench_run, dtcm_stack + sizeof(dtcm_stack));
}
