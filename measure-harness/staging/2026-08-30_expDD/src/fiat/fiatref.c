/* fiat-crypto curve25519 필드 곱 — C 레퍼런스 (실험 C 정답 대조용).
 * 같은 소스를 일반 컴파일: 파이프라인(asm) 버전과 출력이 일치해야 함. */
#include <stdint.h>
#include "curve25519_32.c.inc"

void fiat_mul_ref(uint32_t out1[10], const uint32_t arg1[10], const uint32_t arg2[10])
{
    fiat_25519_carry_mul(out1, arg1, arg2);
}
