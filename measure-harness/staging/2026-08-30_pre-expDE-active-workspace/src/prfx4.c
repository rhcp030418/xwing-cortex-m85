/* expCP: 잡음 PRF 6스트림 4-way 배칭. 자세한 근거는 prfx4.h 와 사전등록 문서. */

#include "prfx4.h"
#include "keccakx4.h"

#include <string.h>

#define PRFX4_SEEDBYTES 32u

volatile uint32_t mlkem_prfx4_mode;

static uint8_t prfx4_buf[PRFX4_MAX][PRFX4_OUTBYTES]
    __attribute__((aligned(4), section(".dtcm")));
static uint8_t prfx4_seed[PRFX4_SEEDBYTES] __attribute__((section(".dtcm")));
static uint8_t prfx4_sink[PRFX4_OUTBYTES] __attribute__((section(".dtcm")));
static uint32_t prfx4_valid;   /* nonce 비트마스크 */

void mlkem_prfx4_reset(void)
{
    prfx4_valid = 0u;
}

void mlkem_prfx4_fill(const uint8_t *seed, uint32_t count)
{
    uint8_t ext[4][PRFX4_SEEDBYTES + 1u];
    uint8_t *out[4];

    prfx4_valid = 0u;
    if (!mlkem_prfx4_mode) return;
    if (count > PRFX4_MAX) count = PRFX4_MAX;
    if (count == 0u) return;

    for (uint32_t base = 0u; base < count; base += 4u) {
        for (uint32_t j = 0u; j < 4u; j++) {
            const uint32_t n = base + j;
            const uint32_t real = (n < count);
            memcpy(ext[j], seed, PRFX4_SEEDBYTES);
            /* 남는 lane 은 마지막 실제 nonce 를 반복한다. 결과는 버린다.
             * 이 dummy lane 이 실제 낭비이며 결과 문서에 그대로 보고한다. */
            ext[j][PRFX4_SEEDBYTES] = (uint8_t) (real ? n : (count - 1u));
            out[j] = real ? prfx4_buf[n] : prfx4_sink;
        }
        shake256x4(out[0], out[1], out[2], out[3], PRFX4_OUTBYTES,
                   ext[0], ext[1], ext[2], ext[3], PRFX4_SEEDBYTES + 1u);
    }

    memcpy(prfx4_seed, seed, PRFX4_SEEDBYTES);
    prfx4_valid = (1u << count) - 1u;
}

const uint8_t *mlkem_prfx4_get(const uint8_t *seed, uint8_t nonce)
{
    if (!mlkem_prfx4_mode) return 0;
    if (nonce >= PRFX4_MAX) return 0;
    if (((prfx4_valid >> nonce) & 1u) == 0u) return 0;
    /* seed 가 다르면 다른 연산의 잡음이다. 조용히 scalar 경로로 돌아간다. */
    if (memcmp(seed, prfx4_seed, PRFX4_SEEDBYTES) != 0) return 0;
    return prfx4_buf[nonce];
}
