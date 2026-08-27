/* fiat-crypto curve25519 필드 곱 래퍼 — 실전 재료 스티칭 v1의 스트림 A.
 * fiat_25519_carry_mul: 10림브(25.5비트) 표현의 진짜 X25519 필드 곱 + 캐리 축약.
 * MULNAME을 바꿔 (일반 / -ffixed 파이프라인) 두 벌 컴파일. */
#include "curve25519_32.c"

void MULNAME(uint32_t out1[10], const uint32_t arg1[10], const uint32_t arg2[10])
{
    fiat_25519_carry_mul(out1, arg1, arg2);
}
