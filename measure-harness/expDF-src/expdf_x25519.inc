/* expDF only: pair-affine micro-gate wrappers.  Included by x25519_base.c. */

#define EXPDF_X_TEXT __attribute__((noinline, section(".itcm_code_from_flash")))

static uint32_t expdf_fe_nonzero_mask(fe a)
{
    uint32_t nz = 0u;
    fe_freeze(a);
    for (uint32_t i = 0u; i < 8u; i++) nz |= a[i];
    nz = (nz | (uint32_t) (0u - nz)) >> 31;
    return (uint32_t) (0u - nz);
}

static void expdf_fe_store(uint32_t *out, const fe a)
{
    fe t;
    fe_copy(t, a);
    fe_freeze(t);
    for (uint32_t i = 0u; i < 8u; i++) out[i] = t[i];
}

/* in = num1 || den1 || num2 || den2; out = affine1 || affine2. */
EXPDF_X_TEXT void expdf_fe_pair_independent(uint32_t out[16],
                                             const uint32_t in[32])
{
    fe inv1, inv2, r1, r2;
    fe_invert(inv1, in + 8u);
    fe25519_mul_lenn(r1, in, inv1);
    fe_invert(inv2, in + 24u);
    fe25519_mul_lenn(r2, in + 16u, inv2);
    expdf_fe_store(out, r1);
    expdf_fe_store(out + 8u, r2);
}

EXPDF_X_TEXT void expdf_fe_pair_batch(uint32_t out[16], const uint32_t in[32])
{
    fe d1, d2, d1_safe, d2_safe, product, product_inv;
    fe inv1, inv2, r1, r2;
    uint32_t m1, m2;

    fe_copy(d1, in + 8u);
    fe_copy(d2, in + 24u);
    m1 = expdf_fe_nonzero_mask(d1);
    m2 = expdf_fe_nonzero_mask(d2);

    for (uint32_t i = 0u; i < 8u; i++) {
        d1_safe[i] = (d1[i] & m1) | (fe_one[i] & ~m1);
        d2_safe[i] = (d2[i] & m2) | (fe_one[i] & ~m2);
    }

    fe25519_mul_lenn(product, d1_safe, d2_safe);
    fe_invert(product_inv, product);
    fe25519_mul_lenn(inv1, product_inv, d2_safe);
    fe25519_mul_lenn(inv2, product_inv, d1_safe);
    fe25519_mul_lenn(r1, in, inv1);
    fe25519_mul_lenn(r2, in + 16u, inv2);

    for (uint32_t i = 0u; i < 8u; i++) {
        r1[i] &= m1;
        r2[i] &= m2;
    }
    expdf_fe_store(out, r1);
    expdf_fe_store(out + 8u, r2);
}

#undef EXPDF_X_TEXT
