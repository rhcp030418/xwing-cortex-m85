#include "poly.h"
#include "polyvec.h"
#include "randombytes.h"
#include "symmetric.h"
#include "ntt.h"
#include "matacc.h"

extern volatile uint32_t g_keccak_perm_calls;
extern volatile uint32_t expz_prof_enable;
extern volatile uint32_t expz_prof_cyc[5];
extern volatile uint32_t expz_prof_calls[5];
extern volatile uint32_t expz_prof_keccak[5];

#define EXPZ_CYCCNT (*(volatile uint32_t *) 0xE0001004u)
#define EXPZ_PROFILE_MATACC(CALL) do {                                      \
    uint32_t _t = 0u, _k = 0u;                                             \
    if (expz_prof_enable) { _t = EXPZ_CYCCNT; _k = g_keccak_perm_calls; }  \
    CALL;                                                                   \
    if (expz_prof_enable) {                                                 \
        expz_prof_cyc[0] += EXPZ_CYCCNT - _t;                              \
        expz_prof_calls[0]++;                                               \
        expz_prof_keccak[0] += g_keccak_perm_calls - _k;                   \
    }                                                                       \
} while (0)


/*************************************************
* Name:        matacc_cache32
*
* Description: Multiplies a row of A or A^T, generated on-the-fly,
*              with a vector of polynomials and accumulates into the result.
*              Using asymmetric multiplication and better accumulation.
*
* Arguments:   - poly *r:                    pointer to output polynomial to accumulate in
*              - const polyvec *b:           pointer to input vector of polynomials to multiply with
*              - polyvec *b_prime:           pointer to output vector of polynomials to store b multiplied by zetas
*              - unsigned char i:            byte to indicate the index < KYBER_K of the row of A or A^T
*              - const unsigned char *seed:  pointer to the public seed used to generate A
*              - int transposed:             boolean indicatin whether A or A^T is generated
**************************************************/
void matacc_cache32(poly* r, const polyvec *b, polyvec *b_prime, unsigned char i, const unsigned char *seed, int transposed) {
  unsigned char buf[XOF_BLOCKBYTES+2];
  xof_state state;
  int16_t c[4];
  int32_t r_tmp[KYBER_N]; // stores intermediate accumulated values to save reductions
  int j = 0;

  // 16-32

  if (transposed)
    xof_absorb(&state, seed, i, j);
  else
    xof_absorb(&state, seed, j, i);

  xof_squeezeblocks(buf, 1, &state);

  EXPZ_PROFILE_MATACC(matacc_asm_cache_16_32(r_tmp, b->vec[j].coeffs, c, buf, zetas, &state, b_prime->vec[j].coeffs));

  // 32-32 KYBER_K - 2 times
  for(j=1;j<KYBER_K - 1;j++) {

    if (transposed)
      xof_absorb(&state, seed, i, j);
    else
      xof_absorb(&state, seed, j, i);

    xof_squeezeblocks(buf, 1, &state);

    EXPZ_PROFILE_MATACC(matacc_asm_cache_32_32(r_tmp, b->vec[j].coeffs, c, buf, zetas, &state, b_prime->vec[j].coeffs));
  }

  // 32-16

  if (transposed)
    xof_absorb(&state, seed, i, j);
  else
    xof_absorb(&state, seed, j, i);

  xof_squeezeblocks(buf, 1, &state);

  EXPZ_PROFILE_MATACC(matacc_asm_cache_32_16(r->coeffs, b->vec[j].coeffs, c, buf, zetas, &state, b_prime->vec[j].coeffs, r_tmp));
}

/*************************************************
* Name:        matacc_opt32
*
* Description: Multiplies a row of A or A^T, generated on-the-fly,
*              with a vector of polynomials and accumulates into the result.
*              Using asymmetric multiplication and better accumulation.
*
* Arguments:   - poly *r:                    pointer to output polynomial to accumulate in
*              - const polyvec *b:           pointer to input vector of polynomials to multiply with
*              - const polyvec *b_prime:     pointer to input vector of polynomials to store b multiplied by zetas
*              - unsigned char i:            byte to indicate the index < KYBER_K of the row of A or A^T
*              - const unsigned char *seed:  pointer to the public seed used to generate A
*              - int transposed:             boolean indicatin whether A or A^T is generated
**************************************************/
void matacc_opt32(poly* r, const polyvec *b, const polyvec *b_prime, unsigned char i, const unsigned char *seed, int transposed) {
  unsigned char buf[XOF_BLOCKBYTES+2];
  xof_state state;
  int16_t c[4];
  int32_t r_tmp[KYBER_N]; // stores intermediate accumulated values to save reductions
  int j = 0;

  // 16-32

  if (transposed)
    xof_absorb(&state, seed, i, j);
  else
    xof_absorb(&state, seed, j, i);

  xof_squeezeblocks(buf, 1, &state);

  EXPZ_PROFILE_MATACC(matacc_asm_opt_16_32(r_tmp, b->vec[j].coeffs, c, buf, &state, b_prime->vec[j].coeffs));
  
  // 32-32 KYBER_K - 2 times
  for(j=1;j<KYBER_K - 1;j++) {

    if (transposed)
      xof_absorb(&state, seed, i, j);
    else
      xof_absorb(&state, seed, j, i);

    xof_squeezeblocks(buf, 1, &state);

    EXPZ_PROFILE_MATACC(matacc_asm_opt_32_32(r_tmp, b->vec[j].coeffs, c, buf, &state, b_prime->vec[j].coeffs));
  }

  // 32-16

  if (transposed)
    xof_absorb(&state, seed, i, j);
  else
    xof_absorb(&state, seed, j, i);

  xof_squeezeblocks(buf, 1, &state);

  EXPZ_PROFILE_MATACC(matacc_asm_opt_32_16(r->coeffs, b->vec[j].coeffs, c, buf, &state, b_prime->vec[j].coeffs, r_tmp));
}
