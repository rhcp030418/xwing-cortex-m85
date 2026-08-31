/* expDE: dispatcher-free draft-10 deployment-footprint image. */
#include <stddef.h>
#include <stdint.h>
#include <string.h>

#include "hal_data.h"
#include "expDE_mode.h"
#include "keccak/fips202.h"
#include "mlkem/api.h"
#include "mlkem/poly.h"
#include "mlkem/polyvec.h"

extern void PQCLEAN_randombytes_reset(uint32_t seed);
extern int PQCLEAN_randombytes(uint8_t *output, size_t n);
extern void shake256(uint8_t *output, size_t outlen,
                     const uint8_t *input, size_t inlen);
extern int crypto_kem_keypair_derand(unsigned char *pk, unsigned char *sk,
                                     const unsigned char *coins);
extern int crypto_kem_enc_derand(uint8_t *ct, uint8_t *ss,
                                 const uint8_t *pk, const uint8_t *coins);
extern void curve25519_scalarmult(unsigned char result[32],
                                  const unsigned char scalar[32],
                                  const unsigned char point[32]);
extern void curve25519_scalarmult_base(uint8_t out[32],
                                       const uint8_t scalar[32]);

extern void *__real_memcpy(void *dst, const void *src, size_t n);
extern void *__real_memset(void *dst, int c, size_t n);

volatile uint32_t harness_done;
volatile uint32_t harness_fails;
volatile uint32_t k32_mode;

static const uint8_t basepoint[32] = {9};

__attribute__((optimize("no-tree-loop-distribute-patterns")))
void *__wrap_memcpy(void *dst, const void *src, size_t n)
{
#if EXPDE_MODE == 0
    return __real_memcpy(dst, src, n);
#else
    unsigned char *d = (unsigned char *)dst;
    const unsigned char *s = (const unsigned char *)src;
    if (((((uintptr_t)d) | ((uintptr_t)s)) & 3u) == 0u) {
        uint32_t *dw = (uint32_t *)(void *)d;
        const uint32_t *sw = (const uint32_t *)(const void *)s;
        size_t w = n >> 2;
        while (w-- != 0u) *dw++ = *sw++;
        d = (unsigned char *)dw;
        s = (const unsigned char *)sw;
        n &= 3u;
    }
    while (n-- != 0u) *d++ = *s++;
    return dst;
#endif
}

__attribute__((optimize("no-tree-loop-distribute-patterns")))
void *__wrap_memset(void *dst, int c, size_t n)
{
#if EXPDE_MODE == 0
    return __real_memset(dst, c, n);
#else
    unsigned char *d = (unsigned char *)dst;
    const uint32_t v = 0x01010101u * (uint32_t)(unsigned char)c;
    if ((((uintptr_t)d) & 3u) == 0u) {
        uint32_t *dw = (uint32_t *)(void *)d;
        size_t w = n >> 2;
        while (w-- != 0u) *dw++ = v;
        d = (unsigned char *)dw;
        n &= 3u;
    }
    while (n-- != 0u) *d++ = (unsigned char)c;
    return dst;
#endif
}

#define EXPDE_SKBYTES 32u
#define EXPDE_PKBYTES (CRYPTO_PUBLICKEYBYTES + 32u)
#define EXPDE_CTBYTES (CRYPTO_CIPHERTEXTBYTES + 32u)

typedef struct {
    uint8_t sk_m[CRYPTO_SECRETKEYBYTES];
    uint8_t sk_x[32];
    uint8_t pk_x[32];
    uint8_t pk_m[CRYPTO_PUBLICKEYBYTES];
} expde_expanded;

static void expde_clamp(uint8_t k[32])
{
    k[0] &= 248u;
    k[31] &= 127u;
    k[31] |= 64u;
}

static void expde_fixed_base(uint8_t out[32], const uint8_t scalar[32])
{
#if EXPDE_MODE == 0
    curve25519_scalarmult(out, scalar, basepoint);
#else
    curve25519_scalarmult_base(out, scalar);
#endif
}

static void expde_combine(uint8_t out[32], const uint8_t ss_m[32],
                          const uint8_t ss_x[32], const uint8_t ct_x[32],
                          const uint8_t pk_x[32])
{
    static const uint8_t label[6] = {'\\', '.', '/', '/', '^', '\\'};
    uint8_t in[134];
    memcpy(in + 0, ss_m, 32);
    memcpy(in + 32, ss_x, 32);
    memcpy(in + 64, ct_x, 32);
    memcpy(in + 96, pk_x, 32);
    memcpy(in + 128, label, sizeof(label));
    sha3_256(out, in, sizeof(in));
}

void expde_expand(expde_expanded *e, const uint8_t sk[EXPDE_SKBYTES])
{
    uint8_t expanded[96];
    uint8_t k[32];
    shake256(expanded, sizeof(expanded), sk, EXPDE_SKBYTES);
    (void)crypto_kem_keypair_derand(e->pk_m, e->sk_m, expanded);
    memcpy(e->sk_x, expanded + 64, 32);
    memcpy(k, e->sk_x, 32);
    expde_clamp(k);
    expde_fixed_base(e->pk_x, k);
}

static int expde_ek_check(const uint8_t *pk_m)
{
    polyvec t;
    uint8_t re[KYBER_POLYVECBYTES];
    polyvec_frombytes(&t, pk_m);
    polyvec_tobytes(re, &t);
    return memcmp(re, pk_m, KYBER_POLYVECBYTES) == 0 ? 0 : -1;
}

void expde_keypair(uint8_t pk[EXPDE_PKBYTES], uint8_t sk[EXPDE_SKBYTES])
{
    expde_expanded e;
    (void)PQCLEAN_randombytes(sk, EXPDE_SKBYTES);
    expde_expand(&e, sk);
    memcpy(pk, e.pk_m, CRYPTO_PUBLICKEYBYTES);
    memcpy(pk + CRYPTO_PUBLICKEYBYTES, e.pk_x, 32);
}

int expde_encaps(uint8_t ct[EXPDE_CTBYTES], uint8_t ss[32],
                 const uint8_t pk[EXPDE_PKBYTES])
{
    uint8_t eseed[64], ss_m[32], ss_x[32], ek_x[32];
    if (expde_ek_check(pk) != 0) return -1;
    (void)PQCLEAN_randombytes(eseed, sizeof(eseed));
    (void)crypto_kem_enc_derand(ct, ss_m, pk, eseed);
    memcpy(ek_x, eseed + 32, 32);
    expde_clamp(ek_x);
    expde_fixed_base(ct + CRYPTO_CIPHERTEXTBYTES, ek_x);
    curve25519_scalarmult(ss_x, ek_x, pk + CRYPTO_PUBLICKEYBYTES);
    expde_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES,
                  pk + CRYPTO_PUBLICKEYBYTES);
    return 0;
}

void expde_decaps_warm(uint8_t ss[32], const uint8_t ct[EXPDE_CTBYTES],
                       const expde_expanded *e)
{
    uint8_t ss_m[32], ss_x[32], k[32];
    (void)crypto_kem_dec(ss_m, ct, e->sk_m);
    memcpy(k, e->sk_x, 32);
    expde_clamp(k);
    curve25519_scalarmult(ss_x, k, ct + CRYPTO_CIPHERTEXTBYTES);
    expde_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES, e->pk_x);
}

void expde_decaps_cold(uint8_t ss[32], const uint8_t ct[EXPDE_CTBYTES],
                       const uint8_t sk[EXPDE_SKBYTES])
{
    expde_expanded e;
    expde_expand(&e, sk);
    expde_decaps_warm(ss, ct, &e);
}

typedef struct {
    void (*expand)(expde_expanded *, const uint8_t *);
    void (*keypair)(uint8_t *, uint8_t *);
    int (*encaps)(uint8_t *, uint8_t *, const uint8_t *);
    void (*warm)(uint8_t *, const uint8_t *, const expde_expanded *);
    void (*cold)(uint8_t *, const uint8_t *, const uint8_t *);
} expde_api_table;

const expde_api_table expde_api = {
    expde_expand, expde_keypair, expde_encaps,
    expde_decaps_warm, expde_decaps_cold
};
volatile const expde_api_table * volatile expde_api_anchor;

void harness_main(void)
{
    extern uint64_t __itcm_from_flash$$Base;
    extern uint64_t __itcm_from_flash$$Limit;
    extern uint64_t __itcm_from_flash$$Load;
    extern const uint8_t g_itcm_bad_granule_pad[256];
    uint64_t *dst = &__itcm_from_flash$$Base;
    uint64_t *end = &__itcm_from_flash$$Limit;
    const uint64_t *src = (const uint64_t *)&__itcm_from_flash$$Load;
    while (dst < end) *dst++ = *src++;
    __DSB();
    __ISB();
    (void)*(volatile const uint8_t *)g_itcm_bad_granule_pad;
    expde_api_anchor = &expde_api;
    harness_fails = 0u;
    harness_done = 1u;
}
