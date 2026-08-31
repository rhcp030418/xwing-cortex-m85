/* expCP: ML-KEM 잡음 PRF(SHAKE256) 6스트림의 4-way 배칭.
 * 사전등록: 2026-08-28_expCP_wider_coverage_prereg.md
 *
 * 목적은 속도가 아니라 파트너 범위다. permute4 는 X25519 큐가 대기 중이면
 * 자동으로 fused_round4/8 을 쓰므로, PRF 를 x4 경로로 보내면 스티칭 배치가
 * 3 -> 5 로 는다. mode 0 이면 기존 scalar 경로와 바이트 단위로 동일해야 한다. */
#ifndef PRFX4_H
#define PRFX4_H

#include <stdint.h>

#define PRFX4_MAX 6u
#define PRFX4_OUTBYTES 128u

extern volatile uint32_t mlkem_prfx4_mode;

/* seed(32B)에 대해 nonce 0..count-1 의 PRF 출력을 미리 뽑는다. mode 0 이면 no-op. */
void mlkem_prfx4_fill(const uint8_t *seed, uint32_t count);

/* 캐시된 출력 포인터. 없으면 NULL — 호출자는 기존 scalar 경로로 돌아간다. */
const uint8_t *mlkem_prfx4_get(const uint8_t *seed, uint8_t nonce);

void mlkem_prfx4_reset(void);

#endif
