/* expAM1b — 표현 변환 8x32 <-> 10x25.5, 그리고 정규화 유틸
 *
 * AM0 위험 M4("8x32 <-> 10x25/26 변환 비용 미측정")를 닫기 위한 것.
 * 대표 경로는 Lenngren 8x32 이고 MVE 후보는 10x25.5 이므로, MVE 커널을 실제
 * ladder 에 넣으려면 호출마다(또는 phase 경계마다) 이 변환이 필요하다.
 *
 * QEMU 테스트와 보드 하네스가 **같은 파일**을 쓴다(구현 분기 방지).
 */

#ifndef EXPAM_CONV_H
#define EXPAM_CONV_H

#include <stdint.h>
#include <string.h>

static const uint8_t EXPAM_CLW[10]   = {26, 25, 26, 25, 26, 25, 26, 25, 26, 25};
static const uint8_t EXPAM_CLOFF[10] = {0, 26, 51, 77, 102, 128, 153, 179, 204, 230};

/* 8x32 (값 < 2^256, mod 2^256-38 표현) -> 10x25.5 */
static void fe_8x32_to_1025(uint32_t h[10], const uint32_t w_in[8])
{
    uint32_t w[8];
    uint32_t i;

    for (i = 0; i < 8u; i++) w[i] = w_in[i];

    /* 2^255 = 19 (mod p): bit255 를 19 로 내린다. 최대 2회면 충분하다. */
    for (i = 0; i < 2u; i++) {
        uint32_t top = (w[7] >> 31) & 1u;
        uint64_t carry;
        uint32_t j;
        if (!top) break;
        w[7] &= 0x7fffffffu;
        carry = 19u;
        for (j = 0; j < 8u && carry; j++) {
            uint64_t v = (uint64_t) w[j] + (carry & 0xffffffffu);
            w[j] = (uint32_t) v;
            carry = (carry >> 32) + (v >> 32);
        }
    }

    for (i = 0; i < 10u; i++) {
        uint32_t off = EXPAM_CLOFF[i];
        uint32_t wi = off >> 5;
        uint32_t sh = off & 31u;
        uint64_t v = (uint64_t) w[wi] >> sh;
        if (sh != 0u && (wi + 1u) < 8u) {
            v |= (uint64_t) w[wi + 1u] << (32u - sh);
        }
        h[i] = (uint32_t) (v & ((1u << EXPAM_CLW[i]) - 1u));
    }
}

/* 10x25.5 -> 8x32 (완전 carry 전파 후 pack) */
static void fe_1025_to_8x32(uint32_t w[8], const uint32_t h_in[10])
{
    uint64_t t[10];
    uint32_t i, pass;

    for (i = 0; i < 10u; i++) t[i] = h_in[i];
    for (pass = 0; pass < 3u; pass++) {
        uint64_t c = 0;
        for (i = 0; i < 10u; i++) {
            t[i] += c;
            c = t[i] >> EXPAM_CLW[i];
            t[i] &= ((uint64_t) 1 << EXPAM_CLW[i]) - 1u;
        }
        t[0] += 19u * c;
    }

    memset(w, 0, 8u * sizeof(uint32_t));
    for (i = 0; i < 10u; i++) {
        uint32_t off = EXPAM_CLOFF[i];
        uint32_t wi = off >> 5;
        uint64_t carry = t[i] << (off & 31u);
        while (carry && wi < 8u) {
            uint64_t sum = (uint64_t) w[wi] + (carry & 0xffffffffu);
            w[wi] = (uint32_t) sum;
            carry = (carry >> 32) + (sum >> 32);
            wi++;
        }
    }
}

/* 8x32 워드값을 mod 2^255-19 정규 32 byte 로 (대조용) */
static void fe_words_tobytes(uint8_t s[32], const uint32_t win[8])
{
    uint32_t w[8];
    uint32_t i, q[8], mask;
    uint64_t c;

    for (i = 0; i < 8u; i++) w[i] = win[i];
    for (i = 0; i < 4u; i++) {
        uint32_t top = (w[7] >> 31) & 1u;
        uint64_t carry;
        uint32_t j;
        if (!top) break;
        w[7] &= 0x7fffffffu;
        carry = 19u;
        for (j = 0; j < 8u && carry; j++) {
            uint64_t v = (uint64_t) w[j] + (carry & 0xffffffffu);
            w[j] = (uint32_t) v;
            carry = (carry >> 32) + (v >> 32);
        }
    }
    c = 19u;
    for (i = 0; i < 8u; i++) { c += w[i]; q[i] = (uint32_t) c; c >>= 32; }
    mask = 0u - ((q[7] >> 31) & 1u);
    q[7] &= 0x7fffffffu;
    for (i = 0; i < 8u; i++) w[i] = (w[i] & ~mask) | (q[i] & mask);
    w[7] &= 0x7fffffffu;
    for (i = 0; i < 8u; i++) {
        s[4*i+0] = (uint8_t) w[i];         s[4*i+1] = (uint8_t)(w[i] >> 8);
        s[4*i+2] = (uint8_t)(w[i] >> 16);  s[4*i+3] = (uint8_t)(w[i] >> 24);
    }
}

/* 10x25.5 -> 정규 32 byte */
static void fe_limbs_tobytes(uint8_t s[32], const uint32_t h[10])
{
    uint32_t w[8];
    fe_1025_to_8x32(w, h);
    fe_words_tobytes(s, w);
}

/* 32 byte -> 10x25.5 */
static void fe_bytes_tolimbs(uint32_t h[10], const uint8_t s[32])
{
    uint32_t i;
    for (i = 0; i < 10u; i++) {
        uint32_t off = EXPAM_CLOFF[i];
        uint64_t v = 0;
        uint32_t k;
        for (k = 0; k < 5u; k++) {
            uint32_t bi = (off >> 3) + k;
            if (bi < 32u) v |= (uint64_t) s[bi] << (8u * k);
        }
        v >>= (off & 7u);
        h[i] = (uint32_t) (v & ((1u << EXPAM_CLW[i]) - 1u));
    }
}

#endif /* EXPAM_CONV_H */
