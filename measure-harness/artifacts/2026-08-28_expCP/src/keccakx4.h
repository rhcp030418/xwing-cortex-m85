#ifndef KECCAKX4_H
#define KECCAKX4_H

#include <stddef.h>
#include <stdint.h>

typedef struct {
    uint64_t ctx[4][25];
} shake128x4ctx;

extern volatile uint32_t mlkem_keccakx4_mode;

void shake128x4_absorb(shake128x4ctx *state,
                       const uint8_t *in0, const uint8_t *in1,
                       const uint8_t *in2, const uint8_t *in3,
                       size_t inlen);
void shake128x4_squeezeblocks(uint8_t *out0, uint8_t *out1,
                              uint8_t *out2, uint8_t *out3,
                              size_t nblocks, shake128x4ctx *state);
void shake128x4(uint8_t *out0, uint8_t *out1, uint8_t *out2, uint8_t *out3,
                size_t outlen, const uint8_t *in0, const uint8_t *in1,
                const uint8_t *in2, const uint8_t *in3, size_t inlen);
void shake256x4(uint8_t *out0, uint8_t *out1, uint8_t *out2, uint8_t *out3,
                size_t outlen, const uint8_t *in0, const uint8_t *in1,
                const uint8_t *in2, const uint8_t *in3, size_t inlen);

void x25519_u_queue_reset(void);
int x25519_u_enqueue(uint8_t out[32], const uint8_t scalar[32],
                     const uint8_t point[32]);
void x25519_u_finish_all(void);
uint32_t x25519_u_queue_pending(void);
uint32_t x25519_u_failures(void);

/* Experiment AF: one complete 24-round batch with identical Keccak/job work. */
void x25519_u_bench_seq4(uint64_t states[4][25]);
void x25519_u_bench_fused4(uint64_t states[4][25]);
void x25519_u_bench_seq8(uint64_t states[4][25]);
void x25519_u_bench_fused8(uint64_t states[4][25]);

extern volatile uint32_t g_permute4_calls;
extern volatile uint32_t g_u4_round_calls;
extern volatile uint32_t g_u8_round_calls;

#endif
