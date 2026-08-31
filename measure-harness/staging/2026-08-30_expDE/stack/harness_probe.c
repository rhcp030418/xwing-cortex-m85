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
volatile uint32_t log_len;
char log_buf[4096];

static void log_char(char c)
{
    if (log_len < sizeof(log_buf) - 1u) {
        log_buf[log_len++] = c;
        log_buf[log_len] = '\0';
    }
}

static void log_text(const char *s)
{
    while (*s != '\0') log_char(*s++);
}

static void log_u32(uint32_t value)
{
    char digits[10];
    uint32_t count = 0u;
    do {
        digits[count++] = (char)('0' + value % 10u);
        value /= 10u;
    } while (value != 0u);
    while (count != 0u) log_char(digits[--count]);
}

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

/* Stack/KAT diagnostic state; this block is absent from the footprint ELFs. */
#define EXPDE_PROBE_STACK 24576u
static uint8_t probe_stack[EXPDE_PROBE_STACK]
    __attribute__((aligned(8), section(".dtcm")));
static expde_expanded probe_e __attribute__((section(".dtcm")));
static uint8_t probe_sk[EXPDE_SKBYTES] __attribute__((section(".dtcm")));
static uint8_t probe_pk[EXPDE_PKBYTES] __attribute__((section(".dtcm")));
static uint8_t probe_ct[EXPDE_CTBYTES] __attribute__((section(".dtcm")));
static uint8_t probe_ss_e[32] __attribute__((section(".dtcm")));
static uint8_t probe_ss_d[32] __attribute__((section(".dtcm")));
static uint8_t probe_ss_c[32] __attribute__((section(".dtcm")));
static volatile uint32_t probe_op;
static uint32_t probe_stack_used[4];
static uint32_t probe_guard_fail[4];
static uint32_t probe_kat_mm;
static uint32_t probe_smoke_fail;
static uint32_t probe_reject_mm;

static const uint8_t probe_kat_seed[32] = {
    0x7f,0x9c,0x2b,0xa4,0xe8,0x8f,0x82,0x7d,0x61,0x60,0x45,0x50,0x76,0x05,0x85,0x3e,
    0xd7,0x3b,0x80,0x93,0xf6,0xef,0xbc,0x88,0xeb,0x1a,0x6e,0xac,0xfa,0x66,0xef,0x26
};
static const uint8_t probe_kat_eseed[64] = {
    0x3c,0xb1,0xee,0xa9,0x88,0x00,0x4b,0x93,0x10,0x3c,0xfb,0x0a,0xee,0xfd,0x2a,0x68,
    0x6e,0x01,0xfa,0x4a,0x58,0xe8,0xa3,0x63,0x9c,0xa8,0xa1,0xe3,0xf9,0xae,0x57,0xe2,
    0x35,0xb8,0xcc,0x87,0x3c,0x23,0xdc,0x62,0xb8,0xd2,0x60,0x16,0x9a,0xfa,0x2f,0x75,
    0xab,0x91,0x6a,0x58,0xd9,0x74,0x91,0x88,0x35,0xd2,0x5e,0x6a,0x43,0x50,0x85,0xb2
};
static const uint8_t probe_kat_ss[32] = {
    0xd2,0xdf,0x05,0x22,0x12,0x8f,0x09,0xdd,0x8e,0x2c,0x92,0xb1,0xe9,0x05,0xc7,0x93,
    0xd8,0xf5,0x7a,0x54,0xc3,0xda,0x25,0x86,0x1f,0x10,0xbf,0x4c,0xa6,0x13,0xe3,0x84
};
static const uint8_t probe_kat_pk128[128] = {
    0xe2,0x23,0x6b,0x35,0xa8,0xc2,0x4b,0x39,0xb1,0x0a,0xa1,0x32,0x3a,0x96,0xa9,0x19,
    0xa2,0xce,0xd8,0x84,0x00,0x63,0x3a,0x7b,0x07,0x13,0x17,0x13,0xfc,0x14,0xb2,0xb5,
    0xb1,0x9c,0xfc,0x3d,0xa5,0xfa,0x1a,0x92,0xc4,0x9f,0x25,0x51,0x3e,0x0f,0xd3,0x0d,
    0x6b,0x16,0x11,0xc9,0xab,0x96,0x35,0xd7,0x08,0x67,0x27,0xa4,0xb7,0xd2,0x1d,0x34,
    0x24,0x4e,0x66,0x96,0x9c,0xf1,0x5b,0x3b,0x2a,0x78,0x53,0x29,0xf6,0x1b,0x09,0x6b,
    0x27,0x7e,0xa0,0x37,0x38,0x34,0x79,0xa6,0xb5,0x56,0xde,0x72,0x31,0xfe,0x4b,0x7f,
    0xa9,0xc9,0xac,0x24,0xc0,0x69,0x9a,0x00,0x18,0xa5,0x25,0x34,0x01,0xba,0xcf,0xa9,
    0x05,0xca,0x81,0x65,0x73,0xe5,0x6a,0x2d,0x2e,0x06,0x7e,0x9b,0x72,0x87,0x53,0x3b
};
static const uint8_t probe_kat_ct62[62] = {
    0xb8,0x3a,0xa8,0x28,0xd4,0xd6,0x2b,0x9a,0x83,0xce,0xff,0xe1,0xd3,0xd3,0xbb,0x1e,
    0xf3,0x12,0x64,0x64,0x3c,0x07,0x0c,0x57,0x98,0x92,0x7e,0x41,0xfb,0x07,0x91,0x4a,
    0x27,0x3f,0x8f,0x96,0xe7,0x82,0x6c,0xd5,0x37,0x5a,0x28,0x3d,0x7d,0xa8,0x85,0x30,
    0x4c,0x5d,0xe0,0x51,0x6a,0x0f,0x06,0x54,0x24,0x3d,0xc5,0xb9,0x7f,0x8b
};

static uint32_t probe_diff(const uint8_t *a, const uint8_t *b, uint32_t n)
{
    uint32_t difference = 0u;
    for (uint32_t i = 0u; i < n; i++) difference += (a[i] != b[i]);
    return difference;
}

__attribute__((naked)) static void probe_on_stack(void (*fn)(void), void *top)
{
    (void)fn;
    (void)top;
    __asm volatile ("push {r4, r5, lr}\n"
                    "mrs r4, msplim\n"
                    "movs r5, #0\n"
                    "msr msplim, r5\n"
                    "mov r5, sp\n"
                    "mov sp, r1\n"
                    "blx r0\n"
                    "mov sp, r5\n"
                    "msr msplim, r4\n"
                    "pop {r4, r5, pc}\n");
}

static void probe_setup(void)
{
    PQCLEAN_randombytes_reset(0xde000001u);
    expde_keypair(probe_pk, probe_sk);
    expde_expand(&probe_e, probe_sk);
    (void)expde_encaps(probe_ct, probe_ss_e, probe_pk);
}

static void probe_operation(void)
{
    if (probe_op == 0u) {
        PQCLEAN_randombytes_reset(0xde000002u);
        expde_keypair(probe_pk, probe_sk);
    } else if (probe_op == 1u) {
        PQCLEAN_randombytes_reset(0xde000003u);
        (void)expde_encaps(probe_ct, probe_ss_e, probe_pk);
    } else if (probe_op == 2u) {
        expde_decaps_warm(probe_ss_d, probe_ct, &probe_e);
    } else {
        expde_decaps_cold(probe_ss_d, probe_ct, probe_sk);
    }
}

static void probe_measure_one(uint32_t op)
{
    uint32_t first = EXPDE_PROBE_STACK;
    for (uint32_t i = 0u; i < EXPDE_PROBE_STACK; i++) probe_stack[i] = 0x7eu;
    probe_op = op;
    probe_on_stack(probe_operation, probe_stack + sizeof(probe_stack));
    for (uint32_t i = 0u; i < EXPDE_PROBE_STACK; i++) {
        if (probe_stack[i] != 0x7eu) { first = i; break; }
    }
    probe_stack_used[op] = EXPDE_PROBE_STACK - first;
    for (uint32_t i = 0u; i < 64u; i++)
        probe_guard_fail[op] += (probe_stack[i] != 0x7eu);
}

static void probe_correctness(void)
{
    expde_expanded e;
    uint8_t pk[EXPDE_PKBYTES], ct[EXPDE_CTBYTES], ss[32], ss_d[32];
    uint8_t ss_m[32], ss_x[32], ek_x[32];

    expde_expand(&e, probe_kat_seed);
    memcpy(pk, e.pk_m, CRYPTO_PUBLICKEYBYTES);
    memcpy(pk + CRYPTO_PUBLICKEYBYTES, e.pk_x, 32);
    probe_kat_mm += probe_diff(pk, probe_kat_pk128, sizeof(probe_kat_pk128));
    (void)crypto_kem_enc_derand(ct, ss_m, pk, probe_kat_eseed);
    memcpy(ek_x, probe_kat_eseed + 32, 32);
    expde_clamp(ek_x);
    expde_fixed_base(ct + CRYPTO_CIPHERTEXTBYTES, ek_x);
    curve25519_scalarmult(ss_x, ek_x, pk + CRYPTO_PUBLICKEYBYTES);
    expde_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES,
                  pk + CRYPTO_PUBLICKEYBYTES);
    probe_kat_mm += probe_diff(ct, probe_kat_ct62, sizeof(probe_kat_ct62));
    probe_kat_mm += probe_diff(ss, probe_kat_ss, sizeof(probe_kat_ss));
    expde_decaps_warm(ss_d, ct, &e);
    probe_kat_mm += probe_diff(ss_d, probe_kat_ss, sizeof(probe_kat_ss));

    for (uint32_t seed = 0u; seed < 8u; seed++) {
        PQCLEAN_randombytes_reset(0xde100000u + seed * 0x9e37u);
        expde_keypair(probe_pk, probe_sk);
        expde_expand(&probe_e, probe_sk);
        (void)expde_encaps(probe_ct, probe_ss_e, probe_pk);
        expde_decaps_warm(probe_ss_d, probe_ct, &probe_e);
        expde_decaps_cold(probe_ss_c, probe_ct, probe_sk);
        probe_smoke_fail += (memcmp(probe_ss_e, probe_ss_d, 32) != 0);
        probe_smoke_fail += (memcmp(probe_ss_e, probe_ss_c, 32) != 0);
        probe_ct[0] ^= 0x5au;
        expde_decaps_warm(probe_ss_d, probe_ct, &probe_e);
        expde_decaps_cold(probe_ss_c, probe_ct, probe_sk);
        probe_reject_mm += probe_diff(probe_ss_d, probe_ss_c, 32);
        probe_reject_mm += (memcmp(probe_ss_e, probe_ss_d, 32) == 0);
        probe_ct[0] ^= 0x5au;
    }
}

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

    for (uint32_t op = 0u; op < 4u; op++) {
        probe_on_stack(probe_setup, probe_stack + sizeof(probe_stack));
        probe_measure_one(op);
    }
    for (uint32_t i = 0u; i < EXPDE_PROBE_STACK; i++) probe_stack[i] = 0x7eu;
    probe_on_stack(probe_correctness, probe_stack + sizeof(probe_stack));

    log_text("expDE mode=");
#if EXPDE_MODE == 0
    log_text("A\n");
#else
    log_text("B\n");
#endif
    log_text("expDE KAT mm="); log_u32(probe_kat_mm);
    log_text(" smoke="); log_u32(probe_smoke_fail);
    log_text(" reject-mm="); log_u32(probe_reject_mm); log_char('\n');
    for (uint32_t op = 0u; op < 4u; op++) {
        static const char * const names[4] = {"keygen", "encaps", "warm", "cold"};
        log_text("expDE stack op="); log_text(names[op]);
        log_text(" highwater="); log_u32(probe_stack_used[op]);
        log_text(" guard-fail="); log_u32(probe_guard_fail[op]); log_char('\n');
        harness_fails += probe_guard_fail[op];
        harness_fails += (probe_stack_used[op] == 0u);
    }
    harness_fails += probe_kat_mm + probe_smoke_fail + probe_reject_mm;
    log_text(harness_fails == 0u ? "expDE GATE PASS\n" : "expDE GATE FAIL\n");
    harness_done = 1u;
}
