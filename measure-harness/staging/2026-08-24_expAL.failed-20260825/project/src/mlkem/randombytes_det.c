/* 결정적 randombytes — QEMU 기능 검증 전용.
 * ponytail: xorshift32 고정 시드. 실보드 측정에서는 로드맵 위생 규칙대로
 * "시드를 측정 구간 밖에서 사전 생성"하는 실제 TRNG 경로로 교체할 것.
 */
#include <stdint.h>
#include <stddef.h>

static uint32_t state = 0x42424242u;

void PQCLEAN_randombytes_reset(uint32_t seed)
{
    state = seed;
}

int PQCLEAN_randombytes(uint8_t *output, size_t n)
{
    for (size_t i = 0; i < n; i++) {
        state ^= state << 13;
        state ^= state >> 17;
        state ^= state << 5;
        output[i] = (uint8_t)state;
    }
    return 0;
}
