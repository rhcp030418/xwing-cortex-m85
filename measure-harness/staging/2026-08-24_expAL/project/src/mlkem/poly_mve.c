/* poly_mve.c — 실험 AJ: C9 bucket(packing/CBD/msg) MVE(Helium) 구현.
 *
 * 사전등록: A주제/measure-harness/2026-08-24_expAJ_c9_mve_prereg.md
 * 토글: mlkem_c9_mode (0=스칼라 C 현행, 1=MVE). 각 스칼라 함수 머리에서 분기.
 * 상수시간: 고정 루프/마스크/predication만 사용, 비밀 의존 분기·주소 없음.
 *
 * ponytail: packcompress/compress 계열은 양자화만 벡터, 바이트 끼워넣기는
 * 스칼라 v1 — 게이트 미달이면 끼워넣기도 scatter로 재작성.
 */

#include "poly.h"
#include "cbd.h"
#include "params.h"

#include <arm_mve.h>
#include <stdint.h>
#include <string.h>

/* 실험 AK2: 측정 경로 함수만 ITCM(.itcm_code_from_flash) 배치. 0이면 flash(기존). */
#define EXPAK_ITCM 0
#if EXPAK_ITCM
#define AJ_TEXT __attribute__((section(".itcm_code_from_flash")))
#else
#define AJ_TEXT
#endif

volatile uint32_t mlkem_c9_mode = 0;

extern void asm_barrett_reduce(int16_t *r);

/* ---- 공용 오프셋 테이블 (고정, 비밀 무관) ---- */
static const uint32_t off_3x4_0[4] = { 0, 3, 6, 9 };
static const uint32_t off_3x4_1[4] = { 1, 4, 7, 10 };
static const uint32_t off_3x4_2[4] = { 2, 5, 8, 11 };
static const uint32_t off_5x4_0[4] = { 0, 5, 10, 15 };
static const uint32_t off_5x4_1[4] = { 1, 6, 11, 16 };
static const uint32_t off_5x4_2[4] = { 2, 7, 12, 17 };
static const uint32_t off_5x4_3[4] = { 3, 8, 13, 18 };
static const uint32_t off_5x4_4[4] = { 4, 9, 14, 19 };
static const uint32_t off_h_even[4] = { 0, 4, 8, 12 };   /* 바이트 단위 */
static const uint32_t off_h_odd[4]  = { 2, 6, 10, 14 };
static const uint32_t off_h_4g[4]   = { 0, 8, 16, 24 };  /* 4계수 그룹 시작(hw*2) */
static const uint32_t off_seq4[4] = { 0, 1, 2, 3 };
static const uint32_t bit_w_lo[4] = { 1, 2, 4, 8 };
static const uint32_t bit_w_hi[4] = { 16, 32, 64, 128 };

/* ---- CBD eta2: 8바이트 → 16계수 ---- */
AJ_TEXT void mve_cbd(poly *r, const unsigned char *buf, int add)
{
    const uint16x8_t m55 = vdupq_n_u16(0x55u);
    for (int i = 0; i < KYBER_N / 16; i++) {         /* 16회 */
        uint16x8_t x = vldrbq_u16(buf + 8 * i);      /* 8바이트 widen */
        uint16x8_t d = vaddq_u16(vandq_u16(x, m55),
                                 vandq_u16(vshrq_n_u16(x, 1), m55));
        int16x8_t e = vsubq_s16(
            vreinterpretq_s16_u16(vandq_u16(d, vdupq_n_u16(3))),
            vreinterpretq_s16_u16(vandq_u16(vshrq_n_u16(d, 2), vdupq_n_u16(3))));
        int16x8_t o = vsubq_s16(
            vreinterpretq_s16_u16(vandq_u16(vshrq_n_u16(d, 4), vdupq_n_u16(3))),
            vreinterpretq_s16_u16(vandq_u16(vshrq_n_u16(d, 6), vdupq_n_u16(3))));
        int16x8x2_t out;
        if (add) {
            int16x8x2_t prev = vld2q_s16(&r->coeffs[16 * i]);
            out.val[0] = vaddq_s16(prev.val[0], e);
            out.val[1] = vaddq_s16(prev.val[1], o);
        } else {
            out.val[0] = e;
            out.val[1] = o;
        }
        vst2q_s16(&r->coeffs[16 * i], out);
    }
}

/* ---- tobytes: 12비트 직렬화 (스칼라와 동일 전제: 이중 reduce 후 [0,q)) ---- */
AJ_TEXT void mve_poly_tobytes(unsigned char *r, poly *a)
{
    asm_barrett_reduce(a->coeffs);
    asm_barrett_reduce(a->coeffs);
    const uint32x4_t o0 = vldrwq_u32(off_3x4_0);
    const uint32x4_t o1 = vldrwq_u32(off_3x4_1);
    const uint32x4_t o2 = vldrwq_u32(off_3x4_2);
    for (int i = 0; i < KYBER_N / 8; i++) {          /* 32회, 8계수→12바이트 */
        uint32x4_t v = vldrwq_u32((const uint32_t *) (const void *) &a->coeffs[8 * i]);
        uint32x4_t w = vorrq_u32(vandq_u32(v, vdupq_n_u32(0x0fffu)),
                                 vandq_u32(vshrq_n_u32(v, 4), vdupq_n_u32(0x00fff000u)));
        uint8_t *dst = r + 12 * i;
        vstrbq_scatter_offset_u32(dst, o0, w);
        vstrbq_scatter_offset_u32(dst, o1, vshrq_n_u32(w, 8));
        vstrbq_scatter_offset_u32(dst, o2, vshrq_n_u32(w, 16));
    }
}

/* ---- frombytes: tobytes 역변환 ---- */
AJ_TEXT void mve_poly_frombytes(poly *r, const unsigned char *a)
{
    const uint32x4_t o0 = vldrwq_u32(off_3x4_0);
    const uint32x4_t o1 = vldrwq_u32(off_3x4_1);
    const uint32x4_t o2 = vldrwq_u32(off_3x4_2);
    for (int i = 0; i < KYBER_N / 8; i++) {
        const uint8_t *src = a + 12 * i;
        uint32x4_t b0 = vldrbq_gather_offset_u32(src, o0);
        uint32x4_t b1 = vldrbq_gather_offset_u32(src, o1);
        uint32x4_t b2 = vldrbq_gather_offset_u32(src, o2);
        uint32x4_t w  = vorrq_u32(b0, vorrq_u32(vshlq_n_u32(b1, 8), vshlq_n_u32(b2, 16)));
        uint32x4_t c0 = vandq_u32(w, vdupq_n_u32(0x0fffu));
        uint32x4_t c1 = vandq_u32(vshrq_n_u32(w, 12), vdupq_n_u32(0x0fffu));
        vstrwq_u32((uint32_t *) (void *) &r->coeffs[8 * i],
                   vorrq_u32(c0, vshlq_n_u32(c1, 16)));
    }
}

/* ---- 10비트 양자화 (du): t = ((csub(u)<<10)+1665)*1290167 >> 32 & 0x3ff ---- */
AJ_TEXT static void mve_quant10(uint16_t t[KYBER_N], const poly *a)
{
    for (int i = 0; i < KYBER_N / 4; i++) {          /* 64회, 4계수/회 */
        int32x4_t u = vldrhq_s32(&a->coeffs[4 * i]); /* widen s16→s32 */
        u = vaddq_s32(u, vandq_s32(vshrq_n_s32(u, 31), vdupq_n_s32(KYBER_Q)));
        uint32x4_t d = vaddq_u32(vshlq_n_u32(vreinterpretq_u32_s32(u), 10),
                                 vdupq_n_u32(1665u));
        uint32x4_t q = vandq_u32(vmulhq_u32(d, vdupq_n_u32(1290167u)),
                                 vdupq_n_u32(0x3ffu));
        vstrhq_u32(&t[4 * i], q);                    /* narrow u32→u16 */
    }
}

/* 실험 AK1: 10비트 양자화 한 벌 (gather된 s32 레인용) */
static inline uint32x4_t aj_q10(int32x4_t u)
{
    u = vaddq_s32(u, vandq_s32(vshrq_n_s32(u, 31), vdupq_n_s32(KYBER_Q)));
    uint32x4_t d = vaddq_u32(vshlq_n_u32(vreinterpretq_u32_s32(u), 10),
                             vdupq_n_u32(1665u));
    return vandq_u32(vmulhq_u32(d, vdupq_n_u32(1290167u)), vdupq_n_u32(0x3ffu));
}

AJ_TEXT static void mve_poly_packcompress_v1(unsigned char *r, poly *a, int i)
{
    uint16_t t[KYBER_N];
    mve_quant10(t, a);
    unsigned char *dst = r + 320 * i;
    for (int j = 0; j < KYBER_N / 4; j++) {          /* ponytail: 스칼라 끼워넣기 v1 */
        const uint16_t *g = &t[4 * j];
        dst[5 * j + 0] = (unsigned char) (g[0] & 0xff);
        dst[5 * j + 1] = (unsigned char) ((g[0] >> 8) | ((g[1] & 0x3f) << 2));
        dst[5 * j + 2] = (unsigned char) (((g[1] >> 6) | ((g[2] & 0x0f) << 4)) & 0xff);
        dst[5 * j + 3] = (unsigned char) (((g[2] >> 4) | ((g[3] & 0x03) << 6)) & 0xff);
        dst[5 * j + 4] = (unsigned char) ((g[3] >> 2) & 0xff);
    }
}

AJ_TEXT static int mve_cmp_poly_packcompress_v1(const unsigned char *r, poly *a, int i)
{
    uint16_t t[KYBER_N];
    unsigned char rc = 0;
    mve_quant10(t, a);
    const unsigned char *src = r + 320 * i;
    for (int j = 0; j < KYBER_N / 4; j++) {
        const uint16_t *g = &t[4 * j];
        rc |= src[5 * j + 0] ^ (unsigned char) (g[0] & 0xff);
        rc |= src[5 * j + 1] ^ (unsigned char) ((g[0] >> 8) | ((g[1] & 0x3f) << 2));
        rc |= src[5 * j + 2] ^ (unsigned char) (((g[1] >> 6) | ((g[2] & 0x0f) << 4)) & 0xff);
        rc |= src[5 * j + 3] ^ (unsigned char) (((g[2] >> 4) | ((g[3] & 0x03) << 6)) & 0xff);
        rc |= src[5 * j + 4] ^ (unsigned char) ((g[3] >> 2) & 0xff);
    }
    return rc;
}

AJ_TEXT void mve_poly_unpackdecompress(poly *r, const unsigned char *a, int i)
{
    const uint32x4_t o0 = vldrwq_u32(off_5x4_0);
    const uint32x4_t o1 = vldrwq_u32(off_5x4_1);
    const uint32x4_t o2 = vldrwq_u32(off_5x4_2);
    const uint32x4_t o3 = vldrwq_u32(off_5x4_3);
    const uint32x4_t o4 = vldrwq_u32(off_5x4_4);
    const uint32x4_t gof = vldrwq_u32(off_h_4g);
    for (int j = 0; j < KYBER_N / 16; j++) {         /* 16회, 그룹4개=16계수 */
        const uint8_t *src = a + 320 * i + 20 * j;
        uint32x4_t b0 = vldrbq_gather_offset_u32(src, o0);
        uint32x4_t b1 = vldrbq_gather_offset_u32(src, o1);
        uint32x4_t b2 = vldrbq_gather_offset_u32(src, o2);
        uint32x4_t b3 = vldrbq_gather_offset_u32(src, o3);
        uint32x4_t b4 = vldrbq_gather_offset_u32(src, o4);
        uint32x4_t c0 = vorrq_u32(b0, vshlq_n_u32(vandq_u32(b1, vdupq_n_u32(0x03u)), 8));
        uint32x4_t c1 = vorrq_u32(vshrq_n_u32(b1, 2),
                                  vshlq_n_u32(vandq_u32(b2, vdupq_n_u32(0x0fu)), 6));
        uint32x4_t c2 = vorrq_u32(vshrq_n_u32(b2, 4),
                                  vshlq_n_u32(vandq_u32(b3, vdupq_n_u32(0x3fu)), 4));
        uint32x4_t c3 = vorrq_u32(vshrq_n_u32(b3, 6), vshlq_n_u32(b4, 2));
        int16_t *dst = &r->coeffs[16 * j];
#define AJ_DEC10(C, K)                                                        \
        vstrhq_scatter_offset_u32((uint16_t *) (void *) dst,                  \
            vaddq_u32(gof, vdupq_n_u32((K) * 2u)),                            \
            vshrq_n_u32(vaddq_u32(vmulq_n_u32((C), (uint32_t) KYBER_Q),       \
                                  vdupq_n_u32(512u)), 10))
        AJ_DEC10(c0, 0);
        AJ_DEC10(c1, 1);
        AJ_DEC10(c2, 2);
        AJ_DEC10(c3, 3);
#undef AJ_DEC10
    }
}

/* ---- 4비트 양자화 (dv): t = ((csub(u)<<4)+1665)*80635 >> 28 & 0xf
 *      = mulh(((u<<8)+1665*16), 80635) & 0xf ---- */
AJ_TEXT static void mve_quant4(uint16_t t[KYBER_N], const poly *a)
{
    for (int i = 0; i < KYBER_N / 4; i++) {
        int32x4_t u = vldrhq_s32(&a->coeffs[4 * i]);
        u = vaddq_s32(u, vandq_s32(vshrq_n_s32(u, 31), vdupq_n_s32(KYBER_Q)));
        uint32x4_t d = vaddq_u32(vshlq_n_u32(vreinterpretq_u32_s32(u), 8),
                                 vdupq_n_u32(1665u << 4));
        uint32x4_t q = vandq_u32(vmulhq_u32(d, vdupq_n_u32(80635u)),
                                 vdupq_n_u32(0x0fu));
        vstrhq_u32(&t[4 * i], q);
    }
}

AJ_TEXT static void mve_poly_compress_v1(unsigned char *r, const poly *a)
{
    uint16_t t[KYBER_N];
    mve_quant4(t, (const poly *) a);
    for (int i = 0; i < KYBER_N / 2; i++) {
        r[i] = (unsigned char) (t[2 * i] | (t[2 * i + 1] << 4));
    }
}

AJ_TEXT static int mve_cmp_poly_compress_v1(const unsigned char *r, poly *a)
{
    uint16_t t[KYBER_N];
    unsigned char rc = 0;
    mve_quant4(t, a);
    for (int i = 0; i < KYBER_N / 2; i++) {
        rc |= r[i] ^ (unsigned char) (t[2 * i] | (t[2 * i + 1] << 4));
    }
    return rc;
}

/* ================= 실험 AK1: v2 — 팩킹까지 전 벡터화 ================= */

AJ_TEXT static void mve_poly_packcompress_v2(unsigned char *r, poly *a, int i)
{
    const uint32x4_t gof = vldrwq_u32(off_h_4g);   /* 그룹 시작 {0,8,16,24}B */
    const uint32x4_t sof = vldrwq_u32(off_5x4_0);  /* 출력 {0,5,10,15}B */
    unsigned char *dst = r + 320 * i;
    for (int j = 0; j < KYBER_N / 16; j++) {       /* 16회, 그룹 4개=16계수 */
        const int16_t *src = &a->coeffs[16 * j];
        uint32x4_t t0 = aj_q10(vldrhq_gather_offset_s32(src, gof));
        uint32x4_t t1 = aj_q10(vldrhq_gather_offset_s32(src, vaddq_u32(gof, vdupq_n_u32(2u))));
        uint32x4_t t2 = aj_q10(vldrhq_gather_offset_s32(src, vaddq_u32(gof, vdupq_n_u32(4u))));
        uint32x4_t t3 = aj_q10(vldrhq_gather_offset_s32(src, vaddq_u32(gof, vdupq_n_u32(6u))));
        uint8_t *o = dst + 20 * j;
        vstrbq_scatter_offset_u32(o, sof, t0);
        vstrbq_scatter_offset_u32(o, vaddq_u32(sof, vdupq_n_u32(1u)),
            vorrq_u32(vshrq_n_u32(t0, 8), vshlq_n_u32(vandq_u32(t1, vdupq_n_u32(0x3fu)), 2)));
        vstrbq_scatter_offset_u32(o, vaddq_u32(sof, vdupq_n_u32(2u)),
            vorrq_u32(vshrq_n_u32(t1, 6), vshlq_n_u32(vandq_u32(t2, vdupq_n_u32(0x0fu)), 4)));
        vstrbq_scatter_offset_u32(o, vaddq_u32(sof, vdupq_n_u32(3u)),
            vorrq_u32(vshrq_n_u32(t2, 4), vshlq_n_u32(vandq_u32(t3, vdupq_n_u32(0x03u)), 6)));
        vstrbq_scatter_offset_u32(o, vaddq_u32(sof, vdupq_n_u32(4u)), vshrq_n_u32(t3, 2));
    }
}

AJ_TEXT static int mve_cmp_poly_packcompress_v2(const unsigned char *r, poly *a, int i)
{
    const uint32x4_t gof = vldrwq_u32(off_h_4g);
    const uint32x4_t sof = vldrwq_u32(off_5x4_0);
    const unsigned char *src8 = r + 320 * i;
    uint32x4_t acc = vdupq_n_u32(0);
    for (int j = 0; j < KYBER_N / 16; j++) {
        const int16_t *src = &a->coeffs[16 * j];
        uint32x4_t t0 = aj_q10(vldrhq_gather_offset_s32(src, gof));
        uint32x4_t t1 = aj_q10(vldrhq_gather_offset_s32(src, vaddq_u32(gof, vdupq_n_u32(2u))));
        uint32x4_t t2 = aj_q10(vldrhq_gather_offset_s32(src, vaddq_u32(gof, vdupq_n_u32(4u))));
        uint32x4_t t3 = aj_q10(vldrhq_gather_offset_s32(src, vaddq_u32(gof, vdupq_n_u32(6u))));
        const uint8_t *o = src8 + 20 * j;
        uint32x4_t b0 = vldrbq_gather_offset_u32(o, sof);
        uint32x4_t b1 = vldrbq_gather_offset_u32(o, vaddq_u32(sof, vdupq_n_u32(1u)));
        uint32x4_t b2 = vldrbq_gather_offset_u32(o, vaddq_u32(sof, vdupq_n_u32(2u)));
        uint32x4_t b3 = vldrbq_gather_offset_u32(o, vaddq_u32(sof, vdupq_n_u32(3u)));
        uint32x4_t b4 = vldrbq_gather_offset_u32(o, vaddq_u32(sof, vdupq_n_u32(4u)));
        acc = vorrq_u32(acc, veorq_u32(b0, vandq_u32(t0, vdupq_n_u32(0xffu))));
        acc = vorrq_u32(acc, veorq_u32(b1,
            vorrq_u32(vshrq_n_u32(t0, 8), vshlq_n_u32(vandq_u32(t1, vdupq_n_u32(0x3fu)), 2))));
        acc = vorrq_u32(acc, veorq_u32(b2, vandq_u32(
            vorrq_u32(vshrq_n_u32(t1, 6), vshlq_n_u32(vandq_u32(t2, vdupq_n_u32(0x0fu)), 4)),
            vdupq_n_u32(0xffu))));
        acc = vorrq_u32(acc, veorq_u32(b3, vandq_u32(
            vorrq_u32(vshrq_n_u32(t2, 4), vshlq_n_u32(vandq_u32(t3, vdupq_n_u32(0x03u)), 6)),
            vdupq_n_u32(0xffu))));
        acc = vorrq_u32(acc, veorq_u32(b4, vshrq_n_u32(t3, 2)));
    }
    return (int) (vmaxvq_u32(0u, acc) != 0u);
}

AJ_TEXT static void mve_poly_compress_v2(unsigned char *r, const poly *a)
{
    uint16_t t[KYBER_N];
    mve_quant4(t, a);
    for (int i = 0; i < KYBER_N / 16; i++) {       /* 16회, 16계수→8바이트 */
        uint16x8x2_t p = vld2q_u16(&t[16 * i]);
        vstrbq_u16(r + 8 * i, vorrq_u16(p.val[0], vshlq_n_u16(p.val[1], 4)));
    }
}

AJ_TEXT static int mve_cmp_poly_compress_v2(const unsigned char *r, poly *a)
{
    uint16_t t[KYBER_N];
    mve_quant4(t, a);
    uint16x8_t acc = vdupq_n_u16(0);
    for (int i = 0; i < KYBER_N / 16; i++) {
        uint16x8x2_t p = vld2q_u16(&t[16 * i]);
        uint16x8_t calc = vorrq_u16(p.val[0], vshlq_n_u16(p.val[1], 4));
        uint16x8_t got  = vldrbq_u16(r + 8 * i);
        acc = vorrq_u16(acc, veorq_u16(calc, got));
    }
    return (int) (vmaxvq_u16(0u, acc) != 0u);
}

/* ---- 모드 디스패치: 0/1 → v1, 2 → v2 (그 외 7함수는 공통) ---- */
AJ_TEXT void mve_poly_packcompress(unsigned char *r, poly *a, int i)
{
    if (mlkem_c9_mode == 2u) mve_poly_packcompress_v2(r, a, i);
    else                     mve_poly_packcompress_v1(r, a, i);
}
AJ_TEXT int mve_cmp_poly_packcompress(const unsigned char *r, poly *a, int i)
{
    if (mlkem_c9_mode == 2u) return mve_cmp_poly_packcompress_v2(r, a, i);
    return mve_cmp_poly_packcompress_v1(r, a, i);
}
AJ_TEXT void mve_poly_compress(unsigned char *r, const poly *a)
{
    if (mlkem_c9_mode == 2u) { mve_poly_compress_v2(r, a); return; }
    mve_poly_compress_v1(r, a);
}
AJ_TEXT int mve_cmp_poly_compress(const unsigned char *r, poly *a)
{
    if (mlkem_c9_mode == 2u) return mve_cmp_poly_compress_v2(r, a);
    return mve_cmp_poly_compress_v1(r, a);
}

AJ_TEXT void mve_poly_decompress(poly *r, const unsigned char *a)
{
    const uint32x4_t oe = vldrwq_u32(off_h_even);
    const uint32x4_t oo = vldrwq_u32(off_h_odd);
    const uint32x4_t seq = vldrwq_u32(off_seq4);
    for (int i = 0; i < KYBER_N / 8; i++) {          /* 32회, 4바이트=8계수 */
        uint32x4_t b  = vldrbq_gather_offset_u32(a + 4 * i, seq);
        uint32x4_t lo = vandq_u32(b, vdupq_n_u32(0x0fu));
        uint32x4_t hi = vshrq_n_u32(b, 4);
        uint16_t *dst = (uint16_t *) (void *) &r->coeffs[8 * i];
        vstrhq_scatter_offset_u32(dst, oe,
            vshrq_n_u32(vaddq_u32(vmulq_n_u32(lo, (uint32_t) KYBER_Q),
                                  vdupq_n_u32(8u)), 4));
        vstrhq_scatter_offset_u32(dst, oo,
            vshrq_n_u32(vaddq_u32(vmulq_n_u32(hi, (uint32_t) KYBER_Q),
                                  vdupq_n_u32(8u)), 4));
    }
}

/* ---- tomsg: bit = ((u<<1)+1665)*80635 >> 28 & 1 = mulh(((u<<5)+1665*16),80635)&1 ---- */
AJ_TEXT void mve_poly_tomsg(unsigned char msg[KYBER_SYMBYTES], poly *a)
{
    const uint32x4_t wlo = vldrwq_u32(bit_w_lo);
    const uint32x4_t whi = vldrwq_u32(bit_w_hi);
    for (int i = 0; i < KYBER_SYMBYTES; i++) {       /* 32회, 8계수→1바이트 */
        int32x4_t u0 = vldrhq_s32(&a->coeffs[8 * i]);
        int32x4_t u1 = vldrhq_s32(&a->coeffs[8 * i + 4]);
        u0 = vaddq_s32(u0, vandq_s32(vshrq_n_s32(u0, 31), vdupq_n_s32(KYBER_Q)));
        u1 = vaddq_s32(u1, vandq_s32(vshrq_n_s32(u1, 31), vdupq_n_s32(KYBER_Q)));
        uint32x4_t d0 = vaddq_u32(vshlq_n_u32(vreinterpretq_u32_s32(u0), 5),
                                  vdupq_n_u32(1665u << 4));
        uint32x4_t d1 = vaddq_u32(vshlq_n_u32(vreinterpretq_u32_s32(u1), 5),
                                  vdupq_n_u32(1665u << 4));
        uint32x4_t b0 = vandq_u32(vmulhq_u32(d0, vdupq_n_u32(80635u)), vdupq_n_u32(1u));
        uint32x4_t b1 = vandq_u32(vmulhq_u32(d1, vdupq_n_u32(80635u)), vdupq_n_u32(1u));
        msg[i] = (unsigned char) (vaddvq_u32(vmulq_u32(b0, wlo)) +
                                  vaddvq_u32(vmulq_u32(b1, whi)));
    }
}

/* ---- frommsg: bit ? 1665 : 0, predication으로 상수시간 ---- */
AJ_TEXT void mve_poly_frommsg(poly *r, const uint8_t msg[KYBER_INDCPA_MSGBYTES])
{
    const uint32x4_t wlo = vldrwq_u32(bit_w_lo);
    const uint32x4_t whi = vldrwq_u32(bit_w_hi);
    const uint32x4_t half = vdupq_n_u32((KYBER_Q + 1) / 2);
    const uint32x4_t zero = vdupq_n_u32(0);
    for (int i = 0; i < KYBER_N / 8; i++) {
        uint32x4_t m = vdupq_n_u32(msg[i]);
        mve_pred16_t p0 = vcmpneq_u32(vandq_u32(m, wlo), zero);
        mve_pred16_t p1 = vcmpneq_u32(vandq_u32(m, whi), zero);
        uint16_t *dst = (uint16_t *) (void *) &r->coeffs[8 * i];
        vstrhq_u32(dst,     vpselq_u32(half, zero, p0));
        vstrhq_u32(dst + 4, vpselq_u32(half, zero, p1));
    }
}

/* ================= 실험 AJ 셀프테스트 (측정 비대상, 정확성 오라클) =================
 * 스칼라 정본(모드 0) 대 MVE 출력을 8개 결정적 시드에서 전 바이트 비교.
 * RNG 의존을 피하려고 테스트 전용 LCG를 쓴다(비밀 무관, 게이트 전용). */

static uint32_t aj_lcg_state;
static uint32_t aj_lcg(void)
{
    aj_lcg_state = aj_lcg_state * 1664525u + 1013904223u;
    return aj_lcg_state;
}
static void aj_fill_bytes(uint8_t *p, uint32_t n)
{
    for (uint32_t i = 0; i < n; i++) p[i] = (uint8_t) (aj_lcg() >> 24);
}
static void aj_fill_poly(poly *p)
{
    /* csub 도메인 (-q, q) 안의 임의 계수 */
    for (int i = 0; i < KYBER_N; i++) {
        p->coeffs[i] = (int16_t) ((int32_t) (aj_lcg() % (2u * KYBER_Q - 1u)) - (KYBER_Q - 1));
    }
}
static uint32_t aj_diff(const void *a, const void *b, uint32_t n)
{
    const uint8_t *x = (const uint8_t *) a, *y = (const uint8_t *) b;
    uint32_t d = 0;
    for (uint32_t i = 0; i < n; i++) d += (x[i] != y[i]);
    return d;
}

uint32_t mve_c9_selftest(void)
{
    static poly pa, pb, pin;
    static uint8_t bufa[960], bufb[960];
    uint32_t mm = 0;
    const uint32_t saved_mode = mlkem_c9_mode;
    mlkem_c9_mode = 0;               /* 스칼라 정본 경로 보장 */

    for (uint32_t s = 0; s < 8u; s++) {
        aj_lcg_state = 0xa15c0000u + s * 0x9e3779b9u;

        /* cbd add=0/1 */
        aj_fill_bytes(bufa, 128);
        cbd(&pa, bufa, 0);
        mve_cbd(&pb, bufa, 0);
        mm += aj_diff(pa.coeffs, pb.coeffs, sizeof(pa.coeffs));
        aj_fill_poly(&pin);
        memcpy(pa.coeffs, pin.coeffs, sizeof(pin.coeffs));
        memcpy(pb.coeffs, pin.coeffs, sizeof(pin.coeffs));
        cbd(&pa, bufa, 1);
        mve_cbd(&pb, bufa, 1);
        mm += aj_diff(pa.coeffs, pb.coeffs, sizeof(pa.coeffs));

        /* tobytes: 입력 poly가 reduce로 변형되므로 사본 2개 비교 */
        aj_fill_poly(&pin);
        memcpy(pa.coeffs, pin.coeffs, sizeof(pin.coeffs));
        memcpy(pb.coeffs, pin.coeffs, sizeof(pin.coeffs));
        poly_tobytes(bufa, &pa);
        mve_poly_tobytes(bufb, &pb);
        mm += aj_diff(bufa, bufb, KYBER_POLYBYTES);
        mm += aj_diff(pa.coeffs, pb.coeffs, sizeof(pa.coeffs));

        /* frombytes */
        aj_fill_bytes(bufa, KYBER_POLYBYTES);
        poly_frombytes(&pa, bufa);
        mve_poly_frombytes(&pb, bufa);
        mm += aj_diff(pa.coeffs, pb.coeffs, sizeof(pa.coeffs));

        /* packcompress + cmp (idx 0..2) */
        for (int idx = 0; idx < 3; idx++) {
            aj_fill_poly(&pin);
            poly_packcompress(bufa, &pin, idx);
            mve_poly_packcompress(bufb, &pin, idx);
            mm += aj_diff(bufa + 320 * idx, bufb + 320 * idx, 320);
            int ra = cmp_poly_packcompress(bufa, &pin, idx);
            int rb = mve_cmp_poly_packcompress(bufa, &pin, idx);
            mm += (uint32_t) ((ra != 0) != (rb != 0));
            bufa[320 * idx + 7] ^= 0x40u;
            ra = cmp_poly_packcompress(bufa, &pin, idx);
            rb = mve_cmp_poly_packcompress(bufa, &pin, idx);
            mm += (uint32_t) ((ra != 0) != (rb != 0)) + (uint32_t) (ra == 0);
            bufa[320 * idx + 7] ^= 0x40u;

            /* unpackdecompress */
            aj_fill_bytes(bufa, 960);
            poly_unpackdecompress(&pa, bufa, idx);
            mve_poly_unpackdecompress(&pb, bufa, idx);
            mm += aj_diff(pa.coeffs, pb.coeffs, sizeof(pa.coeffs));
        }

        /* compress/decompress + cmp */
        aj_fill_poly(&pin);
        poly_compress(bufa, &pin);
        mve_poly_compress(bufb, &pin);
        mm += aj_diff(bufa, bufb, KYBER_POLYCOMPRESSEDBYTES);
        {
            int ra = cmp_poly_compress(bufa, &pin);
            int rb = mve_cmp_poly_compress(bufa, &pin);
            mm += (uint32_t) ((ra != 0) != (rb != 0));
            bufa[3] ^= 0x11u;
            ra = cmp_poly_compress(bufa, &pin);
            rb = mve_cmp_poly_compress(bufa, &pin);
            mm += (uint32_t) ((ra != 0) != (rb != 0)) + (uint32_t) (ra == 0);
            bufa[3] ^= 0x11u;
        }
        aj_fill_bytes(bufa, KYBER_POLYCOMPRESSEDBYTES);
        poly_decompress(&pa, bufa);
        mve_poly_decompress(&pb, bufa);
        mm += aj_diff(pa.coeffs, pb.coeffs, sizeof(pa.coeffs));

        /* tomsg / frommsg */
        aj_fill_poly(&pin);
        memcpy(pa.coeffs, pin.coeffs, sizeof(pin.coeffs));
        poly_tomsg(bufa, &pin);
        mve_poly_tomsg(bufb, &pa);
        mm += aj_diff(bufa, bufb, KYBER_SYMBYTES);
        aj_fill_bytes(bufa, KYBER_SYMBYTES);
        poly_frommsg(&pa, bufa);
        mve_poly_frommsg(&pb, bufa);
        mm += aj_diff(pa.coeffs, pb.coeffs, sizeof(pa.coeffs));

        /* ---- 실험 AK1: v2 4함수 대 스칼라 정본 ---- */
        for (int idx = 0; idx < 3; idx++) {
            aj_fill_poly(&pin);
            poly_packcompress(bufa, &pin, idx);
            mve_poly_packcompress_v2(bufb, &pin, idx);
            mm += aj_diff(bufa + 320 * idx, bufb + 320 * idx, 320);
            int ra = cmp_poly_packcompress(bufa, &pin, idx);
            int rb = mve_cmp_poly_packcompress_v2(bufa, &pin, idx);
            mm += (uint32_t) ((ra != 0) != (rb != 0));
            bufa[320 * idx + 13] ^= 0x08u;
            ra = cmp_poly_packcompress(bufa, &pin, idx);
            rb = mve_cmp_poly_packcompress_v2(bufa, &pin, idx);
            mm += (uint32_t) ((ra != 0) != (rb != 0)) + (uint32_t) (ra == 0);
            bufa[320 * idx + 13] ^= 0x08u;
        }
        aj_fill_poly(&pin);
        poly_compress(bufa, &pin);
        mve_poly_compress_v2(bufb, &pin);
        mm += aj_diff(bufa, bufb, KYBER_POLYCOMPRESSEDBYTES);
        {
            int ra = cmp_poly_compress(bufa, &pin);
            int rb = mve_cmp_poly_compress_v2(bufa, &pin);
            mm += (uint32_t) ((ra != 0) != (rb != 0));
            bufa[9] ^= 0x21u;
            ra = cmp_poly_compress(bufa, &pin);
            rb = mve_cmp_poly_compress_v2(bufa, &pin);
            mm += (uint32_t) ((ra != 0) != (rb != 0)) + (uint32_t) (ra == 0);
            bufa[9] ^= 0x21u;
        }
    }

    mlkem_c9_mode = saved_mode;
    return mm;
}
