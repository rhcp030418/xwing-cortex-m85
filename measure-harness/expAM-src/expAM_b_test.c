/* expAM1b 기능 게이트 — fe25519_sqr_mve, fe25519_mul_mve_opt, 표현 변환
 * QEMU(mps3-an547, Cortex-M55). 기능 전용, 사이클 값은 쓰지 않는다.
 */

#include <stdint.h>
#include <string.h>
#include "uart.h"
#include "expAM_conv.h"

void fe25519_mul_mve(uint32_t r[10], const uint32_t a[10], const uint32_t b[10]);
void fe25519_mul_mve_opt(uint32_t r[10], const uint32_t a[10], const uint32_t b[10]);
void fe25519_sqr_mve(uint32_t r[10], const uint32_t a[10]);
void expam_probe_semantics(uint32_t out[12]);

static uint32_t rng;
static uint32_t nxt(void) { uint32_t x = rng; x ^= x << 13; x ^= x >> 17; x ^= x << 5; rng = x; return x; }
static void rnd32(uint8_t s[32])
{
    for (int i = 0; i < 32; i += 4) {
        uint32_t v = nxt();
        s[i] = (uint8_t)v; s[i+1] = (uint8_t)(v>>8);
        s[i+2] = (uint8_t)(v>>16); s[i+3] = (uint8_t)(v>>24);
    }
    s[31] &= 0x7f;
}

static uint32_t f_opt, f_sqr, f_conv, f_sem;

static void put64(uint64_t v)
{
    uart_puts("0x");
    for (int i = 15; i >= 0; i--) {
        uint32_t d = (uint32_t)((v >> (4 * i)) & 0xf);
        uart_putc(d < 10 ? (char)('0' + d) : (char)('a' + d - 10));
    }
}

/* 1) opt 는 원본과 limb 단위로 완전히 같아야 한다 (수학이 동일) */
static void check_opt(const uint8_t a[32], const uint8_t b[32])
{
    uint32_t fa[10], fb[10], r1[10], r2[10];
    fe_bytes_tolimbs(fa, a); fe_bytes_tolimbs(fb, b);
    fe25519_mul_mve(r1, fa, fb);
    fe25519_mul_mve_opt(r2, fa, fb);
    if (memcmp(r1, r2, sizeof(r1)) != 0) f_opt++;
}

/* 2) sqr(a) 는 mul(a,a) 와 정규화 결과가 같아야 한다 */
static void check_sqr(const uint8_t a[32])
{
    uint32_t fa[10], rs[10], rm[10];
    uint8_t bs[32], bm[32];
    fe_bytes_tolimbs(fa, a);
    fe25519_sqr_mve(rs, fa);
    fe25519_mul_mve(rm, fa, fa);
    fe_limbs_tobytes(bs, rs);
    fe_limbs_tobytes(bm, rm);
    if (memcmp(bs, bm, 32) != 0) {
        f_sqr++;
        if (f_sqr <= 3u) {
            uart_puts("  SQR MISMATCH\n    sqr "); uart_put_hex_bytes(bs, 32);
            uart_puts("\n    mul "); uart_put_hex_bytes(bm, 32); uart_puts("\n");
        }
    }
}

/* 3) 변환 왕복: 8x32 -> 10x25.5 -> 8x32 가 값을 보존해야 한다 */
static void check_conv(const uint8_t a[32])
{
    uint32_t w[8], h[10], w2[8];
    uint8_t b1[32], b2[32];
    for (int i = 0; i < 8; i++)
        w[i] = (uint32_t)a[4*i] | ((uint32_t)a[4*i+1]<<8)
             | ((uint32_t)a[4*i+2]<<16) | ((uint32_t)a[4*i+3]<<24);
    fe_8x32_to_1025(h, w);
    fe_1025_to_8x32(w2, h);
    fe_words_tobytes(b1, w);
    fe_words_tobytes(b2, w2);
    if (memcmp(b1, b2, 32) != 0) f_conv++;
}

void expAM_b_test(void)
{
    uint8_t a[32], b[32];
    uint32_t sem[12];

    uart_puts("== expAM1b functional gate ==\n");

    /* 실보드/에뮬 명령 의미 확인 */
    memset(sem, 0, sizeof(sem));
    expam_probe_semantics(sem);
    {
        uint64_t d1 = ((uint64_t)sem[1] << 32) | sem[0];
        uint64_t d2 = ((uint64_t)sem[3] << 32) | sem[2];
        uint64_t mb0 = ((uint64_t)sem[5] << 32) | sem[4];
        uint64_t mb1 = ((uint64_t)sem[7] << 32) | sem[6];
        uint64_t mt0 = ((uint64_t)sem[9] << 32) | sem[8];
        uint64_t mt1 = ((uint64_t)sem[11] << 32) | sem[10];
        uart_puts("  vmlaldav.u32 dot   = "); put64(d1); uart_puts(" (expect 0x000000000000a8ca)\n");
        uart_puts("  vmlaldav.u32 ff^2  = "); put64(d2); uart_puts(" (expect 0xfffffff800000004)\n");
        uart_puts("  vmullb.u32 even    = "); put64(mb0); uart_puts(" / "); put64(mb1);
        uart_puts("  (expect 10 / 3000)\n");
        uart_puts("  vmullt.u32 odd     = "); put64(mt0); uart_puts(" / "); put64(mt1);
        uart_puts("  (expect 200 / 40000)\n");
        f_sem += (d1 != 43210u);
        f_sem += (d2 != 0xfffffff800000004ULL);
        f_sem += (mb0 != 10u) + (mb1 != 3000u);
        f_sem += (mt0 != 200u) + (mt1 != 40000u);
    }

    /* 경계값 */
    {
        static const uint8_t z[32] = {0};
        static const uint8_t one[32] = {1};
        static const uint8_t pm1[32] = {
            0xec,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
            0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x7f};
        static const uint8_t mx[32] = {
            0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,
            0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0xff,0x7f};
        const uint8_t *v[4] = {z, one, pm1, mx};
        for (int i = 0; i < 4; i++) {
            check_sqr(v[i]); check_conv(v[i]);
            for (int j = 0; j < 4; j++) check_opt(v[i], v[j]);
        }
    }
    uart_puts("  boundary done: opt="); uart_put_u32(f_opt);
    uart_puts(" sqr="); uart_put_u32(f_sqr);
    uart_puts(" conv="); uart_put_u32(f_conv); uart_puts("\n");

    /* 임의 1,200 */
    rng = 0x77aa33ccu;
    for (int n = 0; n < 1200; n++) {
        rnd32(a); rnd32(b);
        check_opt(a, b);
        check_sqr(a);
        check_conv(a);
    }

    uart_puts("== expAM1b opt-mm="); uart_put_u32(f_opt);
    uart_puts(" sqr-mm="); uart_put_u32(f_sqr);
    uart_puts(" conv-mm="); uart_put_u32(f_conv);
    uart_puts(" sem-mm="); uart_put_u32(f_sem);
    uart_puts((f_opt || f_sqr || f_conv || f_sem) ? "  RESULT: FAIL ==\n" : "  RESULT: PASS ==\n");
}
