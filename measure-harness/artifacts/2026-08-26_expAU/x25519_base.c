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

#include "x25519_base.h"
#include "x25519_base_table.h"

#include <stdint.h>

extern void fe25519_mul_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);
extern void fe25519_sqr_lenn(uint32_t r[8], const uint32_t a[8]);
extern void fe25519_add_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);
extern void fe25519_sub_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);

typedef uint32_t fe[8];

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

static void fe_cmov(fe r, const fe a, uint32_t mask)
{
    for (uint32_t i = 0; i < 8u; i++) r[i] = (r[i] & ~mask) | (a[i] & mask);
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
    uint32_t i;

    fe25519_sqr_lenn(t0, z);                              /* z^2 */
    fe25519_sqr_lenn(t1, t0);
    fe25519_sqr_lenn(t1, t1);                             /* z^8 */
    fe25519_mul_lenn(t1, z, t1);                          /* z^9 */
    fe25519_mul_lenn(t0, t0, t1);                         /* z^11 */
    fe25519_sqr_lenn(t2, t0);                             /* z^22 */
    fe25519_mul_lenn(t1, t1, t2);                         /* z^(2^5-1) */

    fe25519_sqr_lenn(t2, t1);
    for (i = 1; i < 5u; i++) fe25519_sqr_lenn(t2, t2);
    fe25519_mul_lenn(t1, t2, t1);                         /* z^(2^10-1) */

    fe25519_sqr_lenn(t2, t1);
    for (i = 1; i < 10u; i++) fe25519_sqr_lenn(t2, t2);
    fe25519_mul_lenn(t2, t2, t1);                         /* z^(2^20-1) */

    fe25519_sqr_lenn(t3, t2);
    for (i = 1; i < 20u; i++) fe25519_sqr_lenn(t3, t3);
    fe25519_mul_lenn(t2, t3, t2);                         /* z^(2^40-1) */

    fe25519_sqr_lenn(t2, t2);
    for (i = 1; i < 10u; i++) fe25519_sqr_lenn(t2, t2);
    fe25519_mul_lenn(t1, t2, t1);                         /* z^(2^50-1) */

    fe25519_sqr_lenn(t2, t1);
    for (i = 1; i < 50u; i++) fe25519_sqr_lenn(t2, t2);
    fe25519_mul_lenn(t2, t2, t1);                         /* z^(2^100-1) */

    fe25519_sqr_lenn(t3, t2);
    for (i = 1; i < 100u; i++) fe25519_sqr_lenn(t3, t3);
    fe25519_mul_lenn(t2, t3, t2);                         /* z^(2^200-1) */

    fe25519_sqr_lenn(t2, t2);
    for (i = 1; i < 50u; i++) fe25519_sqr_lenn(t2, t2);
    fe25519_mul_lenn(t1, t2, t1);                         /* z^(2^250-1) */

    fe25519_sqr_lenn(t1, t1);
    for (i = 1; i < 5u; i++) fe25519_sqr_lenn(t1, t1);
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

/* 윈도 하나에서 precomp 를 상수시간으로 고른다.  부호 swap 은 루프 안에 접었다. */
static void comb_select(fe ymx, fe ypx, fe xy2d, uint32_t win, int32_t digit)
{
    const int32_t sign_i = digit >> 31;                       /* 음수면 -1 */
    const uint32_t s = (uint32_t) sign_i;                     /* 음수면 all-ones */
    const uint32_t b = (uint32_t) ((digit ^ sign_i) - sign_i); /* |digit| */
    fe neg;
    uint32_t j, k;

    for (k = 0; k < 8u; k++) { ymx[k] = 0u; ypx[k] = 0u; xy2d[k] = 0u; }

    for (j = 0; j < (uint32_t) X25519_COMB_NENTRY; j++) {
        const uint32_t m = ct_eq(b, j + 1u);
        const uint32_t *e = x25519_base_comb[win][j];
        for (k = 0; k < 8u; k++) {
            const uint32_t a0 = e[k];          /* y-x */
            const uint32_t a1 = e[8u + k];     /* y+x */
            ymx[k]  |= m & ((a0 & ~s) | (a1 & s));
            ypx[k]  |= m & ((a1 & ~s) | (a0 & s));
            xy2d[k] |= m & e[16u + k];
        }
    }

    /* digit == 0 이면 항등원 (1, 1, 0) */
    {
        const uint32_t mz = ct_eq(b, 0u);
        ymx[0] |= mz & 1u;
        ypx[0] |= mz & 1u;
    }

    /* 음수면 xy2d 를 부호 반전 */
    fe25519_sub_lenn(neg, fe_zero, xy2d);
    fe_cmov(xy2d, neg, s);
}

/* ref10 ge_madd + p1p1_to_p3 : 7 mul + 7 add/sub */
static void ge_madd(fe X, fe Y, fe Z, fe T,
                    const fe ymx, const fe ypx, const fe xy2d)
{
    fe a, b, c, d, x3, y3, z3, t3;

    fe25519_add_lenn(a, Y, X);
    fe25519_mul_lenn(a, a, ypx);
    fe25519_sub_lenn(b, Y, X);
    fe25519_mul_lenn(b, b, ymx);
    fe25519_mul_lenn(c, xy2d, T);
    fe25519_add_lenn(d, Z, Z);

    fe25519_sub_lenn(x3, a, b);
    fe25519_add_lenn(y3, a, b);
    fe25519_add_lenn(z3, d, c);
    fe25519_sub_lenn(t3, d, c);

    fe25519_mul_lenn(X, x3, t3);
    fe25519_mul_lenn(Y, y3, z3);
    fe25519_mul_lenn(Z, z3, t3);
    fe25519_mul_lenn(T, x3, y3);
}

void curve25519_scalarmult_base(uint8_t out[32], const uint8_t scalar[32])
{
    int8_t digits[X25519_COMB_NWIN];
    fe X, Y, Z, T, ymx, ypx, xy2d, num, den, inv;
    uint8_t k[32];
    uint32_t i;

    for (i = 0; i < 32u; i++) k[i] = scalar[i];
    k[0] = (uint8_t) (k[0] & 248u);
    k[31] = (uint8_t) (k[31] & 127u);
    k[31] = (uint8_t) (k[31] | 64u);

    { uint32_t t0 = 0; X25519B_T(t0); comb_recode(digits, k); X25519B_ACC(x25519b_cyc_recode, t0); }

    /* 항등원 (0, 1, 1, 0) */
    fe_copy(X, fe_zero); fe_copy(Y, fe_one);
    fe_copy(Z, fe_one);  fe_copy(T, fe_zero);

    for (i = 0; i < (uint32_t) X25519_COMB_NWIN; i++) {
        uint32_t t0 = 0;
        X25519B_T(t0);
        comb_select(ymx, ypx, xy2d, i, (int32_t) digits[i]);
        X25519B_ACC(x25519b_cyc_select, t0);
        X25519B_T(t0);
        ge_madd(X, Y, Z, T, ymx, ypx, xy2d);
        X25519B_ACC(x25519b_cyc_madd, t0);
    }

    /* u = (Z + Y) / (Z - Y) */
    {
        uint32_t t0 = 0;
        X25519B_T(t0);
        fe25519_add_lenn(num, Z, Y);
        fe25519_sub_lenn(den, Z, Y);
        fe_invert(inv, den);
        fe25519_mul_lenn(num, num, inv);
        fe_tobytes(out, num);
        X25519B_ACC(x25519b_cyc_inv, t0);
    }

    /* 비밀 잔재 소거 */
    for (i = 0; i < 32u; i++) k[i] = 0u;
    for (i = 0; i < (uint32_t) X25519_COMB_NWIN; i++) digits[i] = 0;
}
