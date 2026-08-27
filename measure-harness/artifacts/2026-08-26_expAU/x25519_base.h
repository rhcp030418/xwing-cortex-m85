/* AT-2: X25519 fixed-base (basepoint 9) 전용 경로. */
#ifndef X25519_BASE_H
#define X25519_BASE_H

#include <stdint.h>

/* out = X25519(clamp(scalar), 9).  scalar 는 clamp 전 원본이어도 된다. */
void curve25519_scalarmult_base(uint8_t out[32], const uint8_t scalar[32]);

#endif
