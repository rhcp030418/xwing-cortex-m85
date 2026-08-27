/* expAM1 후보 B1 정확성 검증 — fe25519_mul_mve
 *
 * 목적: 사전등록 2026-08-25_expAM1_mve_mul_prereg.md §5-1 (QEMU 선행 게이트).
 *   - 결정적 임의 피연산자 >= 1000 쌍에 대해 독립 oracle 과 정규화 결과 일치
 *   - 경계값 / alias / 정렬 offset
 *
 * oracle 은 커널과 **다른 방법**으로 계산한다: 커널은 radix 2^25.5 열-스캐닝이고,
 * oracle 은 32-byte 정규 표현을 8x32-bit 워드로 놓고 schoolbook 512-bit 곱을 한 뒤
 * 2^256 = 38 (mod p) 로 접는다. 같은 알고리즘을 두 번 쓰면 설계 오류를 못 잡는다.
 *
 * 이 파일은 기능 전용이다. QEMU(mps3-an547, Cortex-M55)에서 돌리며 사이클 값은
 * 어떤 문서에도 쓰지 않는다.
 */

#include <stdint.h>
#include <string.h>
#include "uart.h"

void fe25519_mul_mve(uint32_t r[10], const uint32_t a[10], const uint32_t b[10]);

/* limb i 폭: 짝수 26, 홀수 25.  off_i = ceil(25.5*i) */
static const uint8_t LW[10] = {26, 25, 26, 25, 26, 25, 26, 25, 26, 25};
static const uint8_t LOFF[10] = {0, 26, 51, 77, 102, 128, 153, 179, 204, 230};

/* ---------------- 32-byte <-> 10-limb ---------------- */

static void fe_frombytes(uint32_t h[10], const uint8_t s[32])
{
    for (int i = 0; i < 10; i++) {
        uint32_t off = LOFF[i];
        uint64_t w = 0;
        /* off..off+31 비트를 모아 하위 LW[i] 비트만 취한다 */
        for (int k = 0; k < 5; k++) {
            uint32_t byte_idx = (off >> 3) + (uint32_t) k;
            if (byte_idx < 32u) w |= (uint64_t) s[byte_idx] << (8 * k);
        }
        w >>= (off & 7u);
        h[i] = (uint32_t) (w & ((1u << LW[i]) - 1u));
    }
}

/* 완전 정규화 후 32 byte 로 pack. 입력 limb 이 공칭 상한을 조금 넘어도 받는다. */
static void fe_tobytes(uint8_t s[32], const uint32_t h_in[10])
{
    uint64_t t[10];
    for (int i = 0; i < 10; i++) t[i] = h_in[i];

    for (int pass = 0; pass < 3; pass++) {
        uint64_t c = 0;
        for (int i = 0; i < 10; i++) {
            t[i] += c;
            c = t[i] >> LW[i];
            t[i] &= ((uint64_t) 1 << LW[i]) - 1u;
        }
        t[0] += 19u * c;
    }

    /* 값 < 2^255 + eps.  8x32 워드로 pack */
    uint32_t w[8];
    memset(w, 0, sizeof(w));
    for (int i = 0; i < 10; i++) {
        uint32_t off = LOFF[i];
        uint64_t v = t[i] << (off & 31u);
        uint32_t wi = off >> 5;
        uint64_t carry = v;
        while (carry && wi < 8u) {
            uint64_t sum = (uint64_t) w[wi] + (carry & 0xffffffffu);
            w[wi] = (uint32_t) sum;
            carry = (carry >> 32) + (sum >> 32);
            wi++;
        }
    }

    /* canonical: v >= p 이면 p 를 뺀다.  v + 19 의 bit255 로 판정 */
    uint32_t q[8];
    uint64_t c = 19u;
    for (int i = 0; i < 8; i++) {
        c += w[i];
        q[i] = (uint32_t) c;
        c >>= 32;
    }
    uint32_t ge = (q[7] >> 31) & 1u;          /* v + 19 >= 2^255 이면 v >= p */
    uint32_t mask = 0u - ge;
    q[7] &= 0x7fffffffu;
    for (int i = 0; i < 8; i++) w[i] = (w[i] & ~mask) | (q[i] & mask);
    w[7] &= 0x7fffffffu;

    for (int i = 0; i < 8; i++) {
        s[4 * i + 0] = (uint8_t) (w[i]);
        s[4 * i + 1] = (uint8_t) (w[i] >> 8);
        s[4 * i + 2] = (uint8_t) (w[i] >> 16);
        s[4 * i + 3] = (uint8_t) (w[i] >> 24);
    }
}

/* ---------------- 독립 oracle: 32-byte schoolbook mod 2^255-19 ------------- */

static void oracle_mul(uint8_t out[32], const uint8_t a[32], const uint8_t b[32])
{
    uint32_t x[8], y[8], prod[16];
    for (int i = 0; i < 8; i++) {
        x[i] = (uint32_t) a[4 * i] | ((uint32_t) a[4 * i + 1] << 8)
             | ((uint32_t) a[4 * i + 2] << 16) | ((uint32_t) a[4 * i + 3] << 24);
        y[i] = (uint32_t) b[4 * i] | ((uint32_t) b[4 * i + 1] << 8)
             | ((uint32_t) b[4 * i + 2] << 16) | ((uint32_t) b[4 * i + 3] << 24);
    }
    memset(prod, 0, sizeof(prod));
    for (int i = 0; i < 8; i++) {
        uint64_t carry = 0;
        for (int j = 0; j < 8; j++) {
            uint64_t v = (uint64_t) x[i] * y[j] + prod[i + j] + carry;
            prod[i + j] = (uint32_t) v;
            carry = v >> 32;
        }
        prod[i + 8] = (uint32_t) carry;
    }

    /* 2^256 = 38 (mod p).  hi(8 word) * 38 을 lo 에 더하기를 반복 */
    uint32_t lo[9];
    for (int i = 0; i < 8; i++) lo[i] = prod[i];
    lo[8] = 0;
    for (int round = 0; round < 3; round++) {
        uint64_t carry = 0;
        uint32_t hi[9];
        for (int i = 0; i < 8; i++) hi[i] = (round == 0) ? prod[i + 8] : 0u;
        if (round > 0) { hi[0] = lo[8]; lo[8] = 0; }
        for (int i = 0; i < 8; i++) {
            uint64_t v = (uint64_t) lo[i] + (uint64_t) hi[i] * 38u + carry;
            lo[i] = (uint32_t) v;
            carry = v >> 32;
        }
        lo[8] += (uint32_t) carry;
        if (lo[8] == 0u) break;
    }
    /* 남은 2^255 자리도 접는다: bit255 이상은 19 배로 내린다 */
    for (int round = 0; round < 3; round++) {
        uint32_t top = (lo[7] >> 31) & 1u;
        uint32_t extra = lo[8];
        if (!top && !extra) break;
        lo[7] &= 0x7fffffffu;
        lo[8] = 0;
        uint64_t add = (uint64_t) top * 19u + (uint64_t) extra * 38u;
        uint64_t carry = add;
        for (int i = 0; i < 8 && carry; i++) {
            uint64_t v = (uint64_t) lo[i] + (carry & 0xffffffffu);
            lo[i] = (uint32_t) v;
            carry = (carry >> 32) + (v >> 32);
        }
        lo[8] = (uint32_t) carry;
    }
    /* canonical */
    uint32_t q[8];
    uint64_t c = 19u;
    for (int i = 0; i < 8; i++) { c += lo[i]; q[i] = (uint32_t) c; c >>= 32; }
    uint32_t ge = (q[7] >> 31) & 1u;
    uint32_t mask = 0u - ge;
    q[7] &= 0x7fffffffu;
    for (int i = 0; i < 8; i++) lo[i] = (lo[i] & ~mask) | (q[i] & mask);
    lo[7] &= 0x7fffffffu;

    for (int i = 0; i < 8; i++) {
        out[4 * i + 0] = (uint8_t) (lo[i]);
        out[4 * i + 1] = (uint8_t) (lo[i] >> 8);
        out[4 * i + 2] = (uint8_t) (lo[i] >> 16);
        out[4 * i + 3] = (uint8_t) (lo[i] >> 24);
    }
}

/* ---------------- 결정적 PRNG (xorshift32) ---------------- */

static uint32_t rng_state;
static uint32_t rng_next(void)
{
    uint32_t x = rng_state;
    x ^= x << 13; x ^= x >> 17; x ^= x << 5;
    rng_state = x;
    return x;
}

/* ---------------- 테스트 ---------------- */

static uint32_t fails;
static uint32_t checks;

static void check_pair(const uint8_t a[32], const uint8_t b[32], const char *tag)
{
    uint32_t fa[10], fb[10], fr[10];
    uint8_t got[32], want[32];

    fe_frombytes(fa, a);
    fe_frombytes(fb, b);
    fe25519_mul_mve(fr, fa, fb);
    fe_tobytes(got, fr);
    oracle_mul(want, a, b);

    checks++;
    if (memcmp(got, want, 32) != 0) {
        fails++;
        if (fails <= 4u) {
            uart_puts("  MISMATCH ["); uart_puts(tag); uart_puts("]\n    got  ");
            uart_put_hex_bytes(got, 32);
            uart_puts("\n    want ");
            uart_put_hex_bytes(want, 32);
            uart_puts("\n    fa  ");
            for (int i = 0; i < 10; i++) { uart_puts(" "); uart_put_u32(fa[i]); }
            uart_puts("\n    fb  ");
            for (int i = 0; i < 10; i++) { uart_puts(" "); uart_put_u32(fb[i]); }
            uart_puts("\n    fr  ");
            for (int i = 0; i < 10; i++) { uart_puts(" "); uart_put_u32(fr[i]); }
            uart_puts("\n");
        }
    }
}

/* alias 검사: r == a, r == b, r == a == b */
static void check_alias(const uint8_t a[32], const uint8_t b[32])
{
    uint32_t fa[10], fb[10], ref[10];
    uint8_t want[32], got[32];

    fe_frombytes(fa, a);
    fe_frombytes(fb, b);
    fe25519_mul_mve(ref, fa, fb);
    fe_tobytes(want, ref);

    /* r == a */
    uint32_t t1[10];
    memcpy(t1, fa, sizeof(t1));
    fe25519_mul_mve(t1, t1, fb);
    fe_tobytes(got, t1);
    checks++;
    if (memcmp(got, want, 32) != 0) { fails++; uart_puts("  ALIAS r==a FAIL\n"); }

    /* r == b */
    uint32_t t2[10];
    memcpy(t2, fb, sizeof(t2));
    fe25519_mul_mve(t2, fa, t2);
    fe_tobytes(got, t2);
    checks++;
    if (memcmp(got, want, 32) != 0) { fails++; uart_puts("  ALIAS r==b FAIL\n"); }

    /* r == a == b (제곱) */
    uint32_t t3[10], sq[10];
    fe25519_mul_mve(sq, fa, fa);
    fe_tobytes(want, sq);
    memcpy(t3, fa, sizeof(t3));
    fe25519_mul_mve(t3, t3, t3);
    fe_tobytes(got, t3);
    checks++;
    if (memcmp(got, want, 32) != 0) { fails++; uart_puts("  ALIAS r==a==b FAIL\n"); }
}

/* 정렬 offset: 입력·출력 버퍼를 4/8/16 B 경계에 각각 놓고 결과가 같은지 */
static uint8_t align_pool[256] __attribute__((aligned(16)));

static void check_alignment(const uint8_t a[32], const uint8_t b[32])
{
    uint32_t fa[10], fb[10], ref[10];
    uint8_t want[32], got[32];

    fe_frombytes(fa, a);
    fe_frombytes(fb, b);
    fe25519_mul_mve(ref, fa, fb);
    fe_tobytes(want, ref);

    for (int off = 0; off <= 16; off += 4) {
        uint32_t *pa = (uint32_t *) (align_pool + off);
        uint32_t *pb = (uint32_t *) (align_pool + 64 + off);
        uint32_t *pr = (uint32_t *) (align_pool + 128 + off);
        memcpy(pa, fa, 40);
        memcpy(pb, fb, 40);
        fe25519_mul_mve(pr, pa, pb);
        fe_tobytes(got, pr);
        checks++;
        if (memcmp(got, want, 32) != 0) {
            fails++;
            uart_puts("  ALIGN FAIL off="); uart_put_u32((uint32_t) off); uart_puts("\n");
        }
    }
}

static const uint8_t V_ZERO[32] = {0};
static const uint8_t V_ONE[32] = {1};
/* p - 1 = 2^255 - 20 */
static const uint8_t V_PM1[32] = {
    0xec,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
    0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x7f};
/* p = 2^255 - 19  (비정규 입력) */
static const uint8_t V_P[32] = {
    0xed,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
    0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x7f};
/* 2^255 - 1 (비정규 입력, 전 limb 최대) */
static const uint8_t V_MAX[32] = {
    0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
    0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x7f};

void expAM_mul_test(void)
{
    const uint8_t *bnd[5] = {V_ZERO, V_ONE, V_PM1, V_P, V_MAX};
    const char *bnd_name = "boundary";

    uart_puts("== expAM1 B1 fe25519_mul_mve functional gate ==\n");

    /* 1) 경계값 전 조합 (5 x 5 = 25) */
    for (int i = 0; i < 5; i++)
        for (int j = 0; j < 5; j++)
            check_pair(bnd[i], bnd[j], bnd_name);
    uart_puts("  boundary 25 done, fails="); uart_put_u32(fails); uart_puts("\n");

    /* 2) 결정적 임의 피연산자 1200 쌍 */
    rng_state = 0x5eed1234u;
    for (int n = 0; n < 1200; n++) {
        uint8_t a[32], b[32];
        for (int i = 0; i < 32; i += 4) {
            uint32_t v = rng_next();
            a[i] = (uint8_t) v; a[i+1] = (uint8_t)(v>>8);
            a[i+2] = (uint8_t)(v>>16); a[i+3] = (uint8_t)(v>>24);
        }
        for (int i = 0; i < 32; i += 4) {
            uint32_t v = rng_next();
            b[i] = (uint8_t) v; b[i+1] = (uint8_t)(v>>8);
            b[i+2] = (uint8_t)(v>>16); b[i+3] = (uint8_t)(v>>24);
        }
        a[31] &= 0x7f; b[31] &= 0x7f;      /* 255-bit 로 자름 */
        check_pair(a, b, "random");
    }
    uart_puts("  random 1200 done, fails="); uart_put_u32(fails); uart_puts("\n");

    /* 3) 임의값 x 경계값 교차 */
    rng_state = 0xa5a5c3c3u;
    for (int n = 0; n < 100; n++) {
        uint8_t a[32];
        for (int i = 0; i < 32; i += 4) {
            uint32_t v = rng_next();
            a[i] = (uint8_t) v; a[i+1] = (uint8_t)(v>>8);
            a[i+2] = (uint8_t)(v>>16); a[i+3] = (uint8_t)(v>>24);
        }
        a[31] &= 0x7f;
        for (int j = 0; j < 5; j++) { check_pair(a, bnd[j], "mixed"); check_pair(bnd[j], a, "mixed"); }
    }
    uart_puts("  mixed 1000 done, fails="); uart_put_u32(fails); uart_puts("\n");

    /* 4) alias + 정렬 */
    rng_state = 0x13572468u;
    for (int n = 0; n < 25; n++) {
        uint8_t a[32], b[32];
        for (int i = 0; i < 32; i += 4) {
            uint32_t v = rng_next();
            a[i] = (uint8_t) v; a[i+1] = (uint8_t)(v>>8);
            a[i+2] = (uint8_t)(v>>16); a[i+3] = (uint8_t)(v>>24);
        }
        for (int i = 0; i < 32; i += 4) {
            uint32_t v = rng_next();
            b[i] = (uint8_t) v; b[i+1] = (uint8_t)(v>>8);
            b[i+2] = (uint8_t)(v>>16); b[i+3] = (uint8_t)(v>>24);
        }
        a[31] &= 0x7f; b[31] &= 0x7f;
        check_alias(a, b);
        check_alignment(a, b);
    }
    uart_puts("  alias+align done, fails="); uart_put_u32(fails); uart_puts("\n");

    uart_puts("== expAM1 checks="); uart_put_u32(checks);
    uart_puts(" fails="); uart_put_u32(fails);
    uart_puts(fails ? "  RESULT: FAIL ==\n" : "  RESULT: PASS ==\n");
}
