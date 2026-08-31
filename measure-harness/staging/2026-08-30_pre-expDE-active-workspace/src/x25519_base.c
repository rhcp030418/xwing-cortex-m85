/* AT-2: X25519 fixed-base (basepoint 9) — Edwards signed comb, w=3, 86 윈도.
 *
 * 사전등록: A주제/measure-harness/2026-08-25_expAT_x06_fixedbase_prereg.md
 * 호스트 검증: 2026-08-25_expAT1_results.md (RFC 7748 KAT + 1,000 seed 차분 통과)
 *
 * 표: x25519_base_table.h — x25519_base_comb[86][4][24]
 *     엔트리 = (y-x, y+x, 2*d*x*y) 각 8 word little-endian, flash 상주.
 *
 * field 산술은 Lenngren asm 을 AAPCS 래퍼로 부른다 (실측 단가 mul 115.0 / add 30.0 /
 * sub 36.0 / sqr 100.0 cyc). 표 조회는 AT-0 에서 MVE 와 동률로 확인된 chunked scalar
 * 형태이며, MVE 를 쓰지 않으므로 +nomve 빌드에서도 그대로 동작한다.
 *
 * 상수시간: 스칼라 digit 은 비밀이다.
 *   - recode 는 분기 없이 (v+3)>>3 로 carry 를 만든다
 *   - 표 조회는 항상 4 엔트리를 전부 훑는다
 *   - 부호 처리는 select 루프 안의 마스크 + xy2d 1회 조건부 negate
 *   - digit 0 인 윈도도 madd 를 건너뛰지 않는다
 */

/* 사전등록 §2.2: 이 경로는 MVE 를 쓰지 않는다 (+nomve 이식성).  GCC 가 comb_select 의
 * word 루프를 MVE 로 자동 벡터화하면 설계 요건에 어긋나고, 실제로 정렬 UsageFault 를
 * 냈다(CFSR=0x01000000 UNALIGNED). 이 파일 전체에서 벡터화를 끈다. */
#pragma GCC optimize ("O2", "no-tree-vectorize")

#include "x25519_base.h"
#include "x25519_base_table.h"

#include <stdint.h>

extern void fe25519_mul_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);
extern void fe25519_sqr_lenn(uint32_t r[8], const uint32_t a[8]);
extern void fe25519_add_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);
extern void fe25519_sub_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);

typedef uint32_t fe[8];

/* AV: native ABI madd (gen/x25519_comb_asm.S).  오프셋이 asm 과 맞아야 한다. */
typedef struct {
    fe X, Y, Z, T;              /*   0,  32,  64,  96 */
    const uint32_t *pa;         /* 128 */
    const uint32_t *pb;         /* 132 */
    const uint32_t *pxy;        /* 136 */
    uint32_t sign;              /* 140: all-ones 면 z3/t3 를 맞바꾼다 (AX §1.1) */
} ge_ctx;
extern void ge_madd_native(ge_ctx *ctx);
/* AX §1.2: n 회 연속 squaring, 중간 store/load 없음 */
extern void fe25519_sqr_chain(uint32_t r[8], const uint32_t a[8], uint32_t n);

/* AT-2 후속 귀속: 단계별 누산 (prof=0 이면 분기 하나뿐) */
volatile uint32_t x25519b_prof;
volatile uint32_t x25519b_cyc_select;
volatile uint32_t x25519b_cyc_madd;
volatile uint32_t x25519b_cyc_recode;
volatile uint32_t x25519b_cyc_inv;
volatile uint32_t x25519b_cyc_total;
#define X25519B_CYCCNT (*(volatile uint32_t *) 0xE0001004u)
#define X25519B_T(v) do { if (x25519b_prof) { (v) = X25519B_CYCCNT; } } while (0)
#define X25519B_ACC(dst, t0) do { if (x25519b_prof) { (dst) += X25519B_CYCCNT - (t0); } } while (0)

static const fe fe_zero = {0, 0, 0, 0, 0, 0, 0, 0};
static const fe fe_one  = {1, 0, 0, 0, 0, 0, 0, 0};

/* a==b 이면 all-ones, 아니면 0.  분기 없음. */
static uint32_t ct_eq(uint32_t a, uint32_t b)
{
    uint32_t t = a ^ b;
    t = (t | (uint32_t) (0u - t)) >> 31;   /* 다르면 1, 같으면 0 */
    return t - 1u;
}

static void fe_copy(fe r, const fe a)
{
    for (uint32_t i = 0; i < 8u; i++) r[i] = a[i];
}

/* 정규형으로 접는다: 값은 mod p 로 합동이고 2^256 미만이라고 가정한다. */
static void fe_freeze(fe r)
{
    uint64_t acc;
    uint32_t i, mask;
    uint32_t t[8];

    /* 상위 비트를 19배로 두 번 접는다 */
    for (uint32_t pass = 0; pass < 2u; pass++) {
        uint32_t top = r[7] >> 31;
        r[7] &= 0x7fffffffu;
        acc = (uint64_t) r[0] + (uint64_t) (top * 19u);
        r[0] = (uint32_t) acc;
        acc >>= 32;
        for (i = 1; i < 8u; i++) {
            acc += r[i];
            r[i] = (uint32_t) acc;
            acc >>= 32;
        }
    }

    /* r 이 p 이상이면 p 를 뺀다 (상수시간, 두 번) */
    for (uint32_t pass = 0; pass < 2u; pass++) {
        int64_t borrow = 19;                 /* r - (2^255 - 19) = r + 19 - 2^255 */
        for (i = 0; i < 8u; i++) {
            borrow += (int64_t) r[i];
            t[i] = (uint32_t) borrow;
            borrow >>= 32;
        }
        /* t = r + 19.  bit255 가 서면 r >= p 이므로 t 의 bit255 를 지운 값이 답이다. */
        mask = (uint32_t) (0u - (t[7] >> 31));
        t[7] &= 0x7fffffffu;
        for (i = 0; i < 8u; i++) r[i] = (r[i] & ~mask) | (t[i] & mask);
    }
}

static void fe_tobytes(uint8_t out[32], const fe a)
{
    fe t;
    fe_copy(t, a);
    fe_freeze(t);
    for (uint32_t i = 0; i < 8u; i++) {
        out[4u * i + 0u] = (uint8_t) (t[i]);
        out[4u * i + 1u] = (uint8_t) (t[i] >> 8);
        out[4u * i + 2u] = (uint8_t) (t[i] >> 16);
        out[4u * i + 3u] = (uint8_t) (t[i] >> 24);
    }
}

/* z^(p-2) — ref10 계보 덧셈사슬 (254 sqr + 11 mul) */
static void fe_invert(fe out, const fe z)
{
    fe t0, t1, t2, t3;

    fe25519_sqr_lenn(t0, z);                              /* z^2 */
    fe25519_sqr_lenn(t1, t0);
    fe25519_sqr_lenn(t1, t1);                             /* z^8 */
    fe25519_mul_lenn(t1, z, t1);                          /* z^9 */
    fe25519_mul_lenn(t0, t0, t1);                         /* z^11 */
    fe25519_sqr_lenn(t2, t0);                             /* z^22 */
    fe25519_mul_lenn(t1, t1, t2);                         /* z^(2^5-1) */

    fe25519_sqr_chain(t2, t1, 5u);
    fe25519_mul_lenn(t1, t2, t1);                         /* z^(2^10-1) */

    fe25519_sqr_chain(t2, t1, 10u);
    fe25519_mul_lenn(t2, t2, t1);                         /* z^(2^20-1) */

    fe25519_sqr_chain(t3, t2, 20u);
    fe25519_mul_lenn(t2, t3, t2);                         /* z^(2^40-1) */

    fe25519_sqr_chain(t2, t2, 10u);
    fe25519_mul_lenn(t1, t2, t1);                         /* z^(2^50-1) */

    fe25519_sqr_chain(t2, t1, 50u);
    fe25519_mul_lenn(t2, t2, t1);                         /* z^(2^100-1) */

    fe25519_sqr_chain(t3, t2, 100u);
    fe25519_mul_lenn(t2, t3, t2);                         /* z^(2^200-1) */

    fe25519_sqr_chain(t2, t2, 50u);
    fe25519_mul_lenn(t1, t2, t1);                         /* z^(2^250-1) */

    fe25519_sqr_chain(t1, t1, 5u);
    fe25519_mul_lenn(out, t1, t0);                        /* z^(2^255-21) */
}

/* 스칼라 -> 86 개 signed radix-8 digit.  분기 없음. */
static void comb_recode(int8_t d[X25519_COMB_NWIN], const uint8_t k[32])
{
    uint32_t carry = 0u;
    for (uint32_t i = 0; i < (uint32_t) X25519_COMB_NWIN; i++) {
        const uint32_t bitpos = 3u * i;
        const uint32_t byte = bitpos >> 3;
        const uint32_t sh = bitpos & 7u;
        uint32_t v = (byte < 32u) ? (uint32_t) k[byte] : 0u;
        if (byte + 1u < 32u) v |= (uint32_t) k[byte + 1u] << 8;
        v = ((v >> sh) & 7u) + carry;
        carry = (v + 3u) >> 3;                 /* v > 4 이면 1 */
        d[i] = (int8_t) ((int32_t) v - (int32_t) (8u * carry));
    }
}

/* 윈도 하나에서 24 word 를 상수시간으로 고른다.
 * AT-0 에서 실측한 **chunked** 커널 형태: 4 word 를 레지스터에 누산한 뒤 한 번 store.
 * 순진한 `out[k] |= m & e[k]` 는 out[] 을 word 마다 메모리 왕복해 2배 느리다
 * (AT-0: naive 18.8 vs chunked 9.4 cyc/word).
 * 레이아웃: sel[0..7]=y-x, sel[8..15]=y+x, sel[16..23]=2dxy.
 * 부호 swap 은 하지 않는다 — madd 인자 순서로 흡수한다. */
static void comb_select24(uint32_t sel[24], uint32_t win, uint32_t b)
{
    uint32_t c;
    for (c = 0; c < 24u; c += 4u) {
        uint32_t a0 = 0u, a1 = 0u, a2 = 0u, a3 = 0u;
        uint32_t j;
        for (j = 0; j < (uint32_t) X25519_COMB_NENTRY; j++) {
            const uint32_t m = ct_eq(b, j + 1u);
            const uint32_t *e = &x25519_base_comb[win][j][c];
            a0 |= m & e[0];
            a1 |= m & e[1];
            a2 |= m & e[2];
            a3 |= m & e[3];
        }
        sel[c] = a0; sel[c + 1u] = a1; sel[c + 2u] = a2; sel[c + 3u] = a3;
    }
    /* digit == 0 이면 항등원 (1, 1, 0) */
    {
        const uint32_t mz = ct_eq(b, 0u);
        sel[0] |= mz & 1u;
        sel[8] |= mz & 1u;
    }
}

void curve25519_scalarmult_base(uint8_t out[32], const uint8_t scalar[32])
{
    int8_t digits[X25519_COMB_NWIN];
    ge_ctx ctx;
    uint32_t sel[24];
    fe num, den, inv;
    uint8_t kb[32];
    uint32_t i;

    for (i = 0; i < 32u; i++) kb[i] = scalar[i];
    kb[0] = (uint8_t) (kb[0] & 248u);
    kb[31] = (uint8_t) (kb[31] & 127u);
    kb[31] = (uint8_t) (kb[31] | 64u);

    { uint32_t t0 = 0; X25519B_T(t0); comb_recode(digits, kb); X25519B_ACC(x25519b_cyc_recode, t0); }

    /* 항등원 (0, 1, 1, 0) */
    fe_copy(ctx.X, fe_zero); fe_copy(ctx.Y, fe_one);
    fe_copy(ctx.Z, fe_one);  fe_copy(ctx.T, fe_zero);

    for (i = 0; i < (uint32_t) X25519_COMB_NWIN; i++) {
        uint32_t t0 = 0;
        const int32_t d = (int32_t) digits[i];
        const int32_t sg = d >> 31;
        const uint32_t sm = (uint32_t) sg;
        uintptr_t m, A, B;
        X25519B_T(t0);
        comb_select24(sel, i, (uint32_t) ((d ^ sg) - sg));
        /* AX: 2dxy 부호 반전 대신 madd 안에서 z3/t3 를 맞바꾼다 (field 연산 0). */
        ctx.sign = sm;
        /* y-x / y+x swap 은 madd 인자 순서로 흡수 (상수시간 포인터 cmov) */
        m = (uintptr_t) (intptr_t) sg;
        A = (uintptr_t) (const void *) &sel[8];   /* y+x */
        B = (uintptr_t) (const void *) &sel[0];   /* y-x */
        ctx.pa = (const uint32_t *) (void *) ((A & ~m) | (B & m));
        ctx.pb = (const uint32_t *) (void *) ((B & ~m) | (A & m));
        ctx.pxy = &sel[16];
        X25519B_ACC(x25519b_cyc_select, t0);
        X25519B_T(t0);
        ge_madd_native(&ctx);
        X25519B_ACC(x25519b_cyc_madd, t0);
    }

    /* u = (Z + Y) / (Z - Y) */
    {
        uint32_t t0 = 0;
        X25519B_T(t0);
        fe25519_add_lenn(num, ctx.Z, ctx.Y);
        fe25519_sub_lenn(den, ctx.Z, ctx.Y);
        fe_invert(inv, den);
        fe25519_mul_lenn(num, num, inv);
        fe_tobytes(out, num);
        X25519B_ACC(x25519b_cyc_inv, t0);
    }

    /* 비밀 잔재 소거 */
    for (i = 0; i < 32u; i++) kb[i] = 0u;
    for (i = 0; i < (uint32_t) X25519_COMB_NWIN; i++) digits[i] = 0;
}
