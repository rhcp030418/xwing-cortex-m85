#include "poly.h"
#include "ap_probe.h"
#include "polyvec.h"
#include "randombytes.h"
#include "symmetric.h"
#include "ntt.h"
#include "matacc.h"
#include "keccakx4.h"

#include <string.h>

#if KYBER_K != 3
#error "Experiment AC x4 batching is specialized for ML-KEM-768"
#endif

static void xof_batch3(xof_state states[4], unsigned char bufs[4][XOF_BLOCKBYTES + 2],
                       unsigned char row, const unsigned char *seed, int transposed)
{
  unsigned char extseed[4][KYBER_SYMBYTES + 2];
  shake128x4ctx batch;

  for (unsigned int j = 0; j < 4; j++) {
    memcpy(extseed[j], seed, KYBER_SYMBYTES);
    extseed[j][KYBER_SYMBYTES] = transposed ? row : (unsigned char) j;
    extseed[j][KYBER_SYMBYTES + 1] = transposed ? (unsigned char) j : row;
  }
  shake128x4_absorb(&batch, extseed[0], extseed[1], extseed[2], extseed[3],
                    KYBER_SYMBYTES + 2);
  shake128x4_squeezeblocks(bufs[0], bufs[1], bufs[2], bufs[3], 1, &batch);
  for (unsigned int j = 0; j < 4; j++) {
    memcpy(states[j].ctx, batch.ctx[j], sizeof(states[j].ctx));
    bufs[j][XOF_BLOCKBYTES] = 0;
    bufs[j][XOF_BLOCKBYTES + 1] = 0;
  }
}

static void matacc_cache32_x4(poly* r, const polyvec *b, polyvec *b_prime,
                              unsigned char i, const unsigned char *seed, int transposed)
{
  unsigned char bufs[4][XOF_BLOCKBYTES + 2];
  xof_state states[4];
  int16_t c[4];
  int32_t r_tmp[KYBER_N];

  xof_batch3(states, bufs, i, seed, transposed);
  matacc_asm_cache_16_32(r_tmp, b->vec[0].coeffs, c, bufs[0], zetas,
                         &states[0], b_prime->vec[0].coeffs);
  matacc_asm_cache_32_32(r_tmp, b->vec[1].coeffs, c, bufs[1], zetas,
                         &states[1], b_prime->vec[1].coeffs);
  matacc_asm_cache_32_16(r->coeffs, b->vec[2].coeffs, c, bufs[2], zetas,
                         &states[2], b_prime->vec[2].coeffs, r_tmp);
}

static void matacc_opt32_x4(poly* r, const polyvec *b, const polyvec *b_prime,
                            unsigned char i, const unsigned char *seed, int transposed)
{
  unsigned char bufs[4][XOF_BLOCKBYTES + 2];
  xof_state states[4];
  int16_t c[4];
  int32_t r_tmp[KYBER_N];

  xof_batch3(states, bufs, i, seed, transposed);
  matacc_asm_opt_16_32(r_tmp, b->vec[0].coeffs, c, bufs[0], &states[0],
                       b_prime->vec[0].coeffs);
  matacc_asm_opt_32_32(r_tmp, b->vec[1].coeffs, c, bufs[1], &states[1],
                       b_prime->vec[1].coeffs);
  matacc_asm_opt_32_16(r->coeffs, b->vec[2].coeffs, c, bufs[2], &states[2],
                       b_prime->vec[2].coeffs, r_tmp);
}


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
static void ap_inner_matacc_cache32(poly* r, const polyvec *b, polyvec *b_prime, unsigned char i, const unsigned char *seed, int transposed) {
  if (mlkem_keccakx4_mode != 0u) {
    matacc_cache32_x4(r, b, b_prime, i, seed, transposed);
    return;
  }
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

  matacc_asm_cache_16_32(r_tmp, b->vec[j].coeffs, c, buf, zetas, &state, b_prime->vec[j].coeffs);

  // 32-32 KYBER_K - 2 times
  for(j=1;j<KYBER_K - 1;j++) {

    if (transposed)
      xof_absorb(&state, seed, i, j);
    else
      xof_absorb(&state, seed, j, i);

    xof_squeezeblocks(buf, 1, &state);

    matacc_asm_cache_32_32(r_tmp, b->vec[j].coeffs, c, buf, zetas, &state, b_prime->vec[j].coeffs);
  }

  // 32-16

  if (transposed)
    xof_absorb(&state, seed, i, j);
  else
    xof_absorb(&state, seed, j, i);

  xof_squeezeblocks(buf, 1, &state);

  matacc_asm_cache_32_16(r->coeffs, b->vec[j].coeffs, c, buf, zetas, &state, b_prime->vec[j].coeffs, r_tmp);
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
static void ap_inner_matacc_opt32(poly* r, const polyvec *b, const polyvec *b_prime, unsigned char i, const unsigned char *seed, int transposed) {
  if (mlkem_keccakx4_mode != 0u) {
    matacc_opt32_x4(r, b, b_prime, i, seed, transposed);
    return;
  }
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

  matacc_asm_opt_16_32(r_tmp, b->vec[j].coeffs, c, buf, &state, b_prime->vec[j].coeffs);
  
  // 32-32 KYBER_K - 2 times
  for(j=1;j<KYBER_K - 1;j++) {

    if (transposed)
      xof_absorb(&state, seed, i, j);
    else
      xof_absorb(&state, seed, j, i);

    xof_squeezeblocks(buf, 1, &state);

    matacc_asm_opt_32_32(r_tmp, b->vec[j].coeffs, c, buf, &state, b_prime->vec[j].coeffs);
  }

  // 32-16

  if (transposed)
    xof_absorb(&state, seed, i, j);
  else
    xof_absorb(&state, seed, j, i);

  xof_squeezeblocks(buf, 1, &state);

  matacc_asm_opt_32_16(r->coeffs, b->vec[j].coeffs, c, buf, &state, b_prime->vec[j].coeffs, r_tmp);
}

/* ---- expAP 계측 wrapper (원본은 ap_inner_* 로 rename) ---- */

void matacc_cache32(poly* r, const polyvec *b, polyvec *b_prime, unsigned char i, const unsigned char *seed, int transposed)
{
    AP_WRAP(AP_B_MATACC, ap_inner_matacc_cache32(r, b, b_prime, i, seed, transposed));
}

void matacc_opt32(poly* r, const polyvec *b, const polyvec *b_prime, unsigned char i, const unsigned char *seed, int transposed)
{
    AP_WRAP(AP_B_MATACC, ap_inner_matacc_opt32(r, b, b_prime, i, seed, transposed));
}
