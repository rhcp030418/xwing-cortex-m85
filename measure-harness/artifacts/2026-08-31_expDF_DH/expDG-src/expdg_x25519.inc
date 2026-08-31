/* expDG only: real-path fixed/variable projective pairing for batch inversion. */

#define EXPDG_X_TEXT __attribute__((noinline, section(".itcm_code_from_flash")))

volatile uint32_t expdg_x25519_mode;

extern void curve25519_scalarmult(uint8_t out[32], const uint8_t scalar[32],
                                  const uint8_t point[32]);

/* Duplicate only the fixed-base projective producer; the registered baseline stays untouched. */
EXPDG_X_TEXT static void expdg_fixed_projective(uint32_t out[16],
                                                 const uint8_t scalar[32])
{
    int8_t digits[X25519_COMB_NWIN];
    ge_ctx ctx;
    uint32_t sel[24];
    uint8_t kb[32];

    for (uint32_t i = 0u; i < 32u; i++) kb[i] = scalar[i];
    kb[0] = (uint8_t) (kb[0] & 248u);
    kb[31] = (uint8_t) (kb[31] & 127u);
    kb[31] = (uint8_t) (kb[31] | 64u);
    comb_recode(digits, kb);

    fe_copy(ctx.X, fe_zero); fe_copy(ctx.Y, fe_one);
    fe_copy(ctx.Z, fe_one);  fe_copy(ctx.T, fe_zero);
    for (uint32_t i = 0u; i < (uint32_t) X25519_COMB_NWIN; i++) {
        const int32_t d = (int32_t) digits[i];
        const int32_t sg = d >> 31;
        const uint32_t sm = (uint32_t) sg;
        uintptr_t m, A, B;
        comb_select24(sel, i, (uint32_t) ((d ^ sg) - sg));
        ctx.sign = sm;
        m = (uintptr_t) (intptr_t) sg;
        A = (uintptr_t) (const void *) &sel[8];
        B = (uintptr_t) (const void *) &sel[0];
        ctx.pa = (const uint32_t *) (void *) ((A & ~m) | (B & m));
        ctx.pb = (const uint32_t *) (void *) ((B & ~m) | (A & m));
        ctx.pxy = &sel[16];
        ge_madd_native(&ctx);
    }

    fe25519_add_lenn(out, ctx.Z, ctx.Y);
    fe25519_sub_lenn(out + 8u, ctx.Z, ctx.Y);
    for (uint32_t i = 0u; i < 32u; i++) kb[i] = 0u;
    for (uint32_t i = 0u; i < (uint32_t) X25519_COMB_NWIN; i++) digits[i] = 0;
}

EXPDG_X_TEXT void expdg_curve25519_mvecswap(uint8_t out[32],
                                             const uint8_t scalar[32],
                                             const uint8_t point[32])
{
    expdg_x25519_mode = 1u;
    curve25519_scalarmult(out, scalar, point);
    expdg_x25519_mode = 0u;
}

EXPDG_X_TEXT void expdg_x25519_pair(uint8_t fixed_out[32],
                                    uint8_t variable_out[32],
                                    const uint8_t scalar[32],
                                    const uint8_t point[32],
                                    uint32_t use_mve_cswap)
{
    uint32_t projective[32];
    uint32_t affine[16];

    expdg_fixed_projective(projective, scalar);
    expdg_x25519_mode = 2u | (use_mve_cswap & 1u);
    curve25519_scalarmult((uint8_t *) (void *) (projective + 16u), scalar, point);
    expdg_x25519_mode = 0u;
    expdf_fe_pair_batch(affine, projective);
    fe_tobytes(fixed_out, affine);
    fe_tobytes(variable_out, affine + 8u);
}

#undef EXPDG_X_TEXT
