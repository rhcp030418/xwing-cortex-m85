#include "keccakx4.h"

#include <string.h>

#if defined(__arm__) && defined(__GNUC__)
#pragma GCC target("general-regs-only")
#endif

#include "fiat_x25519.h"
#include "keccak/keccakf1600.h"

#define SHAKE128_RATE 168u
#define SHAKE256_RATE 136u
#define MVE_WORDS 508u

extern void keccak4_round_b2_rc(uint32_t block[MVE_WORDS]);
extern volatile uint32_t g_keccak_perm_calls;
/* expCP: permute4 자체의 호출 수 (배치 수). scalar 순열은 세지 않는다. */
volatile uint32_t g_permute4_calls;

volatile uint32_t mlkem_keccakx4_mode;
uint32_t *g_u_mve_block;
volatile uint32_t g_u4_round_calls;
volatile uint32_t g_u8_round_calls;

static const uint32_t rc_even[24] = {
    0x00000001, 0x00000000, 0x00000000, 0x00000000,
    0x00000001, 0x00000001, 0x00000001, 0x00000001,
    0x00000000, 0x00000000, 0x00000001, 0x00000000,
    0x00000001, 0x00000001, 0x00000001, 0x00000001,
    0x00000000, 0x00000000, 0x00000000, 0x00000000,
    0x00000001, 0x00000000, 0x00000001, 0x00000000,
};
static const uint32_t rc_odd[24] = {
    0x00000000, 0x00000089, 0x8000008b, 0x80008080,
    0x0000008b, 0x00008000, 0x80008088, 0x80000082,
    0x0000000b, 0x0000000a, 0x00008082, 0x00008003,
    0x0000808b, 0x8000000b, 0x8000008a, 0x80000081,
    0x80000081, 0x80000008, 0x00000083, 0x80008003,
    0x80008088, 0x80000088, 0x00008000, 0x80008082,
};

static uint32_t mve_block[MVE_WORDS]
    __attribute__((aligned(16), section(".dtcm")));
static uint32_t qsave[16]
    __attribute__((aligned(16), section(".dtcm")));

static void stage_rc(uint32_t round)
{
    for (uint32_t lane = 0; lane < 4; lane++) {
        mve_block[100 + lane] = rc_even[round];
        mve_block[104 + lane] = rc_odd[round];
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

static void fused_round4(void)
{
    fiat_x25519_step(fiat_mul_u4_p0);
    fiat_x25519_step(fiat_mul_u4_p1);
    fiat_x25519_step(fiat_mul_u4_p2);
    fiat_x25519_step(fiat_mul_u4_p3);
}

/* expDB: 네 phase 모두 solver 재스케줄본으로 교체. */
static void fused_round4s(void)
{
    fiat_x25519_step(fiat_mul_u4a_p0);
    fiat_x25519_step(fiat_mul_u4a_p1);
    fiat_x25519_step(fiat_mul_u4a_p2);
    fiat_x25519_step(fiat_mul_u4a_p3);
}

/* expDB 대조군: 네 phase 모두 같은 안전변환, 원본 명령 순서. */
static void fused_round4t(void)
{
    fiat_x25519_step(fiat_mul_u4t_p0);
    fiat_x25519_step(fiat_mul_u4t_p1);
    fiat_x25519_step(fiat_mul_u4t_p2);
    fiat_x25519_step(fiat_mul_u4t_p3);
}

static void fused_round8(void)
{
    fiat_x25519_step(fiat_mul_u8_p0);
    fiat_x25519_step(fiat_mul_u8_p1);
    fiat_x25519_step(fiat_mul_u8_p2);
    fiat_x25519_step(fiat_mul_u8_p3);
    fiat_x25519_step(fiat_mul_u8_p4);
    fiat_x25519_step(fiat_mul_u8_p5);
    fiat_x25519_step(fiat_mul_u8_p6);
    fiat_x25519_step(fiat_mul_u8_p7);
}

static void permute4(uint64_t states[4][25])
{
    uint32_t pending;
    pack4(states);
    g_keccak_perm_calls += 4;
    g_permute4_calls++;
    pending = fiat_x25519_queue_pending();
    if (pending != 0u) {
        g_u_mve_block = mve_block;
        fiat_u_qsave(qsave);
        for (uint32_t round = 0; round < 24; round++) {
            stage_rc(round);
            if (pending >= 2u) fused_round8();
            else fused_round4();
        }
        fiat_u_qrestore(qsave);
    } else {
        for (uint32_t round = 0; round < 24; round++) {
            stage_rc(round);
            keccak4_round_b2_rc(mve_block);
        }
    }
    unpack4(states);
}

static void bench_seq(uint64_t states[4][25], uint32_t steps)
{
    pack4(states);
    for (uint32_t round = 0; round < 24; round++) {
        stage_rc(round);
        keccak4_round_b2_rc(mve_block);
    }
    unpack4(states);
    for (uint32_t i = 0; i < steps; i++)
        fiat_x25519_step(fiat_mul_y11_scalar);
}

static void bench_fused(uint64_t states[4][25], uint32_t use_u8)
{
    pack4(states);
    g_u_mve_block = mve_block;
    fiat_u_qsave(qsave);
    for (uint32_t round = 0; round < 24; round++) {
        stage_rc(round);
        if (use_u8) fused_round8();
        else fused_round4();
    }
    fiat_u_qrestore(qsave);
    unpack4(states);
}

void x25519_u_bench_seq4(uint64_t states[4][25])
{
    bench_seq(states, 24u * 4u);
}

void x25519_u_bench_fused4(uint64_t states[4][25])
{
    bench_fused(states, 0u);
}

void x25519_u_bench_fused4s(uint64_t states[4][25])
{
    pack4(states);
    g_u_mve_block = mve_block;
    fiat_u_qsave(qsave);
    for (uint32_t round = 0; round < 24; round++) {
        stage_rc(round);
        fused_round4s();
    }
    fiat_u_qrestore(qsave);
    unpack4(states);
}

void x25519_u_bench_fused4t(uint64_t states[4][25])
{
    pack4(states);
    g_u_mve_block = mve_block;
    fiat_u_qsave(qsave);
    for (uint32_t round = 0; round < 24; round++) {
        stage_rc(round);
        fused_round4t();
    }
    fiat_u_qrestore(qsave);
    unpack4(states);
}

void x25519_u_bench_seq8(uint64_t states[4][25])
{
    bench_seq(states, 24u * 8u);
}

void x25519_u_bench_fused8(uint64_t states[4][25])
{
    bench_fused(states, 1u);
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
    fiat_x25519_queue_reset();
}

int x25519_u_enqueue(uint8_t out[32], const uint8_t scalar[32],
                     const uint8_t point[32])
{
    return fiat_x25519_enqueue(out, scalar, point);
}

void x25519_u_finish_all(void)
{
    fiat_x25519_finish_all();
}

uint32_t x25519_u_queue_pending(void)
{
    return fiat_x25519_queue_pending();
}

uint32_t x25519_u_failures(void)
{
    return fiat_x25519_failures();
}
