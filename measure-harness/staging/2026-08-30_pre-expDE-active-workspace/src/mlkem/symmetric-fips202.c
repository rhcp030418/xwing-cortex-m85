#include "fips202.h"
#include "params.h"
#include "symmetric.h"
#include <stddef.h>
#include <stdint.h>
#include <string.h>
#include "../keccak/keccakf1600.h"

/*************************************************
* Name:        kyber_shake128_absorb
*
* Description: Absorb step of the SHAKE128 specialized for the Kyber context.
*
* Arguments:   - xof_state *state: pointer to (uninitialized) output Keccak state
*              - const uint8_t *seed: pointer to KYBER_SYMBYTES input to be absorbed into state
*              - uint8_t i: additional byte of input
*              - uint8_t j: additional byte of input
**************************************************/
/* 실험 BF (K22): matrix-XOF absorb 상태 캐시.
 * 사전등록: A주제/measure-harness/2026-08-26_expBF_k22_absorb_prereg.md
 *
 * 한 연산 안에서 matacc 는 같은 공개 seed rho 로 9번 absorb 하고 바이트 32,33 만
 * 달라진다. `seed || 0 || 0` + padding 을 흡수한 200 B 상태를 캐시해 두면 매 호출이
 * memcpy 200 B + 1 B XOR 두 번으로 끝난다 (비트-인터리브 변환 34 B -> 2 B).
 *
 * seed(rho) 는 encapsulation key 로 전송되는 **공개값**이므로 캐시 적중 여부가
 * 만드는 타이밍 차는 비밀 누출이 아니다. 비밀 경로(kyber_shake256_prf)는 건드리지 않는다.
 */
volatile uint32_t mlkem_k22_mode = 0;      /* 0 = 원본, 1 = 캐시 */

static xof_state k22_cache;
static uint8_t   k22_cache_seed[KYBER_SYMBYTES];
static uint32_t  k22_cache_valid = 0u;

static void kyber_shake128_absorb_orig(xof_state *state,
        const uint8_t seed[KYBER_SYMBYTES], uint8_t x, uint8_t y) {
    uint8_t extseed[KYBER_SYMBYTES + 2];
    memcpy(extseed, seed, KYBER_SYMBYTES);
    extseed[KYBER_SYMBYTES + 0] = x;
    extseed[KYBER_SYMBYTES + 1] = y;
    shake128_absorb(state, extseed, sizeof(extseed));
}

__attribute__((optimize("no-tree-loop-distribute-patterns")))
void kyber_shake128_absorb(xof_state *state, const uint8_t seed[KYBER_SYMBYTES],
                           uint8_t x, uint8_t y) {
    if (!mlkem_k22_mode) { kyber_shake128_absorb_orig(state, seed, x, y); return; }

    /* expBF 실측: libc memcpy 200 B = 2,522.75 cyc (12.61 cyc/byte, 바이트 루프).
     * expBG: 복사·비교를 워드 단위 루프로 바꾼다. 위 attribute 가 없으면
     * -ftree-loop-distribute-patterns 가 이 루프들을 다시 memcpy/memcmp 로 되돌린다. */
    {
        const uint32_t *sw = (const uint32_t *) (const void *) seed;
        uint32_t *cw = (uint32_t *) (void *) k22_cache_seed;
        uint32_t diff = k22_cache_valid ? 0u : 1u;
        unsigned i;
        for (i = 0; i < KYBER_SYMBYTES / 4u; i++) diff |= sw[i] ^ cw[i];
        if (diff) {
            kyber_shake128_absorb_orig(&k22_cache, seed, 0u, 0u);
            for (i = 0; i < KYBER_SYMBYTES / 4u; i++) cw[i] = sw[i];
            k22_cache_valid = 1u;
        }
    }
    {
        const uint64_t *src = k22_cache.ctx;
        uint64_t *dst = state->ctx;
        unsigned i;
        for (i = 0; i < 25u; i++) dst[i] = src[i];
    }
    {
        uint8_t xy[2];
        xy[0] = x;
        xy[1] = y;
        KeccakF1600_StateXORBytes(state->ctx, xy, KYBER_SYMBYTES, 2);
    }
}

/*************************************************
* Name:        kyber_shake256_prf
*
* Description: Usage of SHAKE256 as a PRF, concatenates secret and public input
*              and then generates outlen bytes of SHAKE256 output
*
* Arguments:   - uint8_t *out: pointer to output
*              - size_t outlen: number of requested output bytes
*              - const uint8_t *key: pointer to the key (of length KYBER_SYMBYTES)
*              - uint8_t nonce: single-byte nonce (public PRF input)
**************************************************/
void kyber_shake256_prf(uint8_t *out, size_t outlen, const uint8_t key[KYBER_SYMBYTES], uint8_t nonce) {
    uint8_t extkey[KYBER_SYMBYTES + 1];

    memcpy(extkey, key, KYBER_SYMBYTES);
    extkey[KYBER_SYMBYTES] = nonce;

    shake256(out, outlen, extkey, sizeof(extkey));
}

/*************************************************
* Name:        kyber_shake256_prf
*
* Description: Usage of SHAKE256 as a PRF, concatenates secret and public input
*              and then generates outlen bytes of SHAKE256 output
*
* Arguments:   - uint8_t *out: pointer to output
*              - size_t outlen: number of requested output bytes
*              - const uint8_t *key: pointer to the key (of length KYBER_SYMBYTES)
*              - uint8_t nonce: single-byte nonce (public PRF input)
**************************************************/
void kyber_shake256_rkprf(uint8_t out[KYBER_SSBYTES], const uint8_t key[KYBER_SYMBYTES], const uint8_t input[KYBER_CIPHERTEXTBYTES]) {
    shake256incctx s;

    shake256_inc_init(&s);
    shake256_inc_absorb(&s, key, KYBER_SYMBYTES);
    shake256_inc_absorb(&s, input, KYBER_CIPHERTEXTBYTES);
    shake256_inc_finalize(&s);
    shake256_inc_squeeze(out, KYBER_SSBYTES, &s);
    shake256_inc_ctx_release(&s);
}