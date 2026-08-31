#include "keccakx4.h"

#include <string.h>

#include "keccak/keccakf1600.h"
#include "x25519/x25519-cortex-m4.h"

#define SHAKE128_RATE 168u
#define SHAKE256_RATE 136u
#define MVE_WORDS 508u

extern void keccak4_round_b2_rc(uint32_t block[MVE_WORDS]);
extern void curve25519_scalarmult_u(uint8_t out[32], const uint8_t scalar[32],
                                   const uint8_t point[32]);
extern volatile uint32_t g_keccak_perm_calls;

volatile uint32_t mlkem_keccakx4_mode;
volatile uint32_t g_u_active;
volatile uint32_t g_u_phase;
volatile uint32_t g_u_round;
uint32_t *g_u_mve_block;

const uint32_t g_u_rc_even[24] = {
    0x00000001, 0x00000000, 0x00000000, 0x00000000,
    0x00000001, 0x00000001, 0x00000001, 0x00000001,
    0x00000000, 0x00000000, 0x00000001, 0x00000000,
    0x00000001, 0x00000001, 0x00000001, 0x00000001,
    0x00000000, 0x00000000, 0x00000000, 0x00000000,
    0x00000001, 0x00000000, 0x00000001, 0x00000000,
};
const uint32_t g_u_rc_odd[24] = {
    0x00000000, 0x00000089, 0x8000008b, 0x80008080,
    0x0000008b, 0x00008000, 0x80008088, 0x80000082,
    0x0000000b, 0x0000000a, 0x00008082, 0x00008003,
    0x0000808b, 0x8000000b, 0x8000008a, 0x80000081,
    0x80000081, 0x80000008, 0x00000083, 0x80008003,
    0x80008088, 0x80000088, 0x00008000, 0x80008082,
};

typedef struct {
    uint8_t *out;
    const uint8_t *scalar;
    const uint8_t *point;
} x25519_job;

static x25519_job jobs[2];
static uint32_t job_head;
static uint32_t job_count;
static uint32_t job_failures;
static uint32_t mve_block[MVE_WORDS]
    __attribute__((aligned(16), section(".dtcm")));

static void stage_rc(uint32_t round)
{
    for (uint32_t lane = 0; lane < 4; lane++) {
        mve_block[100 + lane] = g_u_rc_even[round];
        mve_block[104 + lane] = g_u_rc_odd[round];
    }
}

static void pack4(uint64_t states[4][25])
{
    for (uint32_t s = 0; s < 4; s++) {
        const uint32_t *words = (const uint32_t *) states[s];
        for (uint32_t lane = 0; lane < 25; lane++) {
            mve_block[4 * lane + s] = words[2 * lane];
            mve_block[128 + 4 * lane + s] = words[2 * lane + 1];
        }
    }
}

static void unpack4(uint64_t states[4][25])
{
    for (uint32_t s = 0; s < 4; s++) {
        uint32_t *words = (uint32_t *) states[s];
        for (uint32_t lane = 0; lane < 25; lane++) {
            words[2 * lane] = mve_block[4 * lane + s];
            words[2 * lane + 1] = mve_block[128 + 4 * lane + s];
        }
    }
}

static void permute4(uint64_t states[4][25])
{
    pack4(states);
    g_keccak_perm_calls += 4;
    if (job_head < job_count) {
        const x25519_job *job = &jobs[job_head++];
        g_u_mve_block = mve_block;
        g_u_phase = 0;
        g_u_round = 0;
        g_u_active = 1;
        curve25519_scalarmult_u(job->out, job->scalar, job->point);
        job_failures += (g_u_active != 0u) | (g_u_round != 24u);
        g_u_active = 0;
    } else {
        for (uint32_t round = 0; round < 24; round++) {
            stage_rc(round);
            keccak4_round_b2_rc(mve_block);
        }
    }
    unpack4(states);
}

static void absorb4(uint64_t states[4][25], uint32_t rate,
                    const uint8_t *const input[4], size_t inlen)
{
    const uint8_t *cursor[4] = {input[0], input[1], input[2], input[3]};
    memset(states, 0, 4u * 25u * sizeof(uint64_t));
    while (inlen >= rate) {
        for (uint32_t s = 0; s < 4; s++)
            KeccakF1600_StateXORBytes(states[s], cursor[s], 0, rate);
        permute4(states);
        for (uint32_t s = 0; s < 4; s++) cursor[s] += rate;
        inlen -= rate;
    }
    for (uint32_t s = 0; s < 4; s++) {
        uint8_t domain = 0x1fu;
        uint8_t final = 0x80u;
        if (inlen != 0u)
            KeccakF1600_StateXORBytes(states[s], cursor[s], 0, (uint32_t) inlen);
        KeccakF1600_StateXORBytes(states[s], &domain, (uint32_t) inlen, 1);
        KeccakF1600_StateXORBytes(states[s], &final, rate - 1u, 1);
    }
}

static void squeezeblocks4(uint8_t *output[4], size_t nblocks,
                           uint64_t states[4][25], uint32_t rate)
{
    while (nblocks-- != 0u) {
        permute4(states);
        for (uint32_t s = 0; s < 4; s++) {
            KeccakF1600_StateExtractBytes(states[s], output[s], 0, rate);
            output[s] += rate;
        }
    }
}

void shake128x4_absorb(shake128x4ctx *state,
                       const uint8_t *in0, const uint8_t *in1,
                       const uint8_t *in2, const uint8_t *in3,
                       size_t inlen)
{
    const uint8_t *input[4] = {in0, in1, in2, in3};
    absorb4(state->ctx, SHAKE128_RATE, input, inlen);
}

void shake128x4_squeezeblocks(uint8_t *out0, uint8_t *out1,
                              uint8_t *out2, uint8_t *out3,
                              size_t nblocks, shake128x4ctx *state)
{
    uint8_t *output[4] = {out0, out1, out2, out3};
    squeezeblocks4(output, nblocks, state->ctx, SHAKE128_RATE);
}

static void shake_x4(uint8_t *output[4], size_t outlen,
                     const uint8_t *const input[4], size_t inlen,
                     uint32_t rate)
{
    uint64_t states[4][25];
    absorb4(states, rate, input, inlen);
    while (outlen >= rate) {
        squeezeblocks4(output, 1, states, rate);
        outlen -= rate;
    }
    if (outlen != 0u) {
        uint8_t block[4][SHAKE128_RATE];
        uint8_t *tmp[4] = {block[0], block[1], block[2], block[3]};
        squeezeblocks4(tmp, 1, states, rate);
        for (uint32_t s = 0; s < 4; s++) memcpy(output[s], block[s], outlen);
    }
}

void shake128x4(uint8_t *out0, uint8_t *out1, uint8_t *out2, uint8_t *out3,
                size_t outlen, const uint8_t *in0, const uint8_t *in1,
                const uint8_t *in2, const uint8_t *in3, size_t inlen)
{
    uint8_t *output[4] = {out0, out1, out2, out3};
    const uint8_t *input[4] = {in0, in1, in2, in3};
    shake_x4(output, outlen, input, inlen, SHAKE128_RATE);
}

void shake256x4(uint8_t *out0, uint8_t *out1, uint8_t *out2, uint8_t *out3,
                size_t outlen, const uint8_t *in0, const uint8_t *in1,
                const uint8_t *in2, const uint8_t *in3, size_t inlen)
{
    uint8_t *output[4] = {out0, out1, out2, out3};
    const uint8_t *input[4] = {in0, in1, in2, in3};
    shake_x4(output, outlen, input, inlen, SHAKE256_RATE);
}

void x25519_u_queue_reset(void)
{
    job_head = 0;
    job_count = 0;
    job_failures = 0;
    g_u_active = 0;
}

int x25519_u_enqueue(uint8_t out[32], const uint8_t scalar[32],
                     const uint8_t point[32])
{
    if (job_count == 2u) return -1;
    jobs[job_count++] = (x25519_job) {out, scalar, point};
    return 0;
}

uint32_t x25519_u_queue_pending(void)
{
    return job_count - job_head;
}

uint32_t x25519_u_failures(void)
{
    return job_failures;
}
