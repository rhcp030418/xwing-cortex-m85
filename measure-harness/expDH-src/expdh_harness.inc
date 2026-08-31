/* expDH: current draft-10/expCJ full-path A/B for expDF winners. */

#define EXPDH_DTCM __attribute__((aligned(16), section(".dtcm")))

extern void expdg_curve25519_mvecswap(uint8_t out[32], const uint8_t scalar[32],
                                      const uint8_t point[32]);
extern void expdg_x25519_pair(uint8_t fixed_out[32], uint8_t variable_out[32],
                              const uint8_t scalar[32], const uint8_t point[32],
                              uint32_t use_mve_cswap);

static uint8_t expdh_ref_pk[D10_PKBYTES] EXPDH_DTCM;
static uint8_t expdh_ref_sk[D10_SKBYTES] EXPDH_DTCM;
static uint8_t expdh_ref_ct[D10_CTBYTES] EXPDH_DTCM;
static uint8_t expdh_ref_enc[32] EXPDH_DTCM;
static uint8_t expdh_ref_warm[32] EXPDH_DTCM;
static uint8_t expdh_ref_cold[32] EXPDH_DTCM;
static uint8_t expdh_ref_reject[32] EXPDH_DTCM;
static uint8_t expdh_low_ref[32] EXPDH_DTCM;
static uint8_t expdh_low_got[32] EXPDH_DTCM;
static uint8_t expdh_low_fixed[32] EXPDH_DTCM;

static void expdh_timer_start(void)
{
    __DSB(); __ISB(); DWT->CYCCNT = 0u; __DSB(); __ISB();
}

static uint32_t expdh_timer_stop(void)
{
    __DSB(); __ISB(); return DWT->CYCCNT;
}

static uint32_t expdh_median(const volatile uint32_t values[REP_N])
{
    uint32_t sorted[REP_N];
    for (uint32_t i = 0u; i < REP_N; i++) sorted[i] = values[i];
    for (uint32_t i = 1u; i < REP_N; i++) {
        uint32_t x = sorted[i], j = i;
        while (j != 0u && sorted[j - 1u] > x) {
            sorted[j] = sorted[j - 1u];
            j--;
        }
        sorted[j] = x;
    }
    return (sorted[REP_N / 2u - 1u] + sorted[REP_N / 2u]) / 2u;
}

/* mode: 0=current, 1=MVE cswap, 2=batch, 3=batch+MVE cswap. */
static int expdh_d10_enc(uint8_t ct[D10_CTBYTES], uint8_t ss[32],
                         const uint8_t pk[D10_PKBYTES], uint32_t mode)
{
    uint8_t eseed[64], ss_m[32], ss_x[32], ek_x[32];
    if (d10_ek_check(pk) != 0) return -1;
    (void) PQCLEAN_randombytes(eseed, sizeof(eseed));
    crypto_kem_enc_derand(ct, ss_m, pk, eseed);
    memcpy(ek_x, eseed + 32, 32);
    clamp(ek_x);
    if (mode == 0u) {
        d10_fixed_base(ct + CRYPTO_CIPHERTEXTBYTES, ek_x);
        curve25519_scalarmult(ss_x, ek_x, pk + CRYPTO_PUBLICKEYBYTES);
    } else if (mode == 1u) {
        d10_fixed_base(ct + CRYPTO_CIPHERTEXTBYTES, ek_x);
        expdg_curve25519_mvecswap(ss_x, ek_x, pk + CRYPTO_PUBLICKEYBYTES);
    } else {
        expdg_x25519_pair(ct + CRYPTO_CIPHERTEXTBYTES, ss_x, ek_x,
                         pk + CRYPTO_PUBLICKEYBYTES, mode & 1u);
    }
    d10_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES,
                pk + CRYPTO_PUBLICKEYBYTES);
    return 0;
}

static void expdh_d10_dec_expanded(uint8_t ss[32], const uint8_t ct[D10_CTBYTES],
                                    const d10_expanded *e, uint32_t use_mve)
{
    uint8_t ss_m[32], ss_x[32], k[32];
    crypto_kem_dec(ss_m, ct, e->sk_m);
    memcpy(k, e->sk_x, 32);
    clamp(k);
    if (use_mve) expdg_curve25519_mvecswap(ss_x, k, ct + CRYPTO_CIPHERTEXTBYTES);
    else curve25519_scalarmult(ss_x, k, ct + CRYPTO_CIPHERTEXTBYTES);
    d10_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES, e->pk_x);
}

static void expdh_d10_dec_cold(uint8_t ss[32], const uint8_t ct[D10_CTBYTES],
                               const uint8_t sk[D10_SKBYTES], uint32_t use_mve)
{
    d10_expanded e;
    d10_expand(&e, sk);
    expdh_d10_dec_expanded(ss, ct, &e, use_mve);
}

static uint32_t expdh_equivalence(void)
{
    uint32_t mm = 0u, smoke = 0u;
    uint8_t warm[32], cold[32], reject[32];
    d10_set_optimizations(1u);
    for (uint32_t seed = 0u; seed < 8u; seed++) {
        const uint32_t rng = 0xd8001001u + seed * 0x9e37u;
        for (uint32_t mode = 0u; mode < 4u; mode++) {
            PQCLEAN_randombytes_reset(rng);
            d10_keypair(d10_pk, d10_sk);
            d10_expand(&d10_cache, d10_sk);
            smoke += (uint32_t) (expdh_d10_enc(d10_ct, d10_ss_e, d10_pk, mode) != 0);
            expdh_d10_dec_expanded(warm, d10_ct, &d10_cache, mode & 1u);
            expdh_d10_dec_cold(cold, d10_ct, d10_sk, mode & 1u);
            smoke += (uint32_t) (memcmp(d10_ss_e, warm, 32u) != 0);
            mm += (uint32_t) (memcmp(warm, cold, 32u) != 0);
            d10_ct[0] ^= 0x5au;
            expdh_d10_dec_expanded(reject, d10_ct, &d10_cache, mode & 1u);
            d10_ct[0] ^= 0x5au;

            if (mode == 0u) {
                memcpy(expdh_ref_pk, d10_pk, D10_PKBYTES);
                memcpy(expdh_ref_sk, d10_sk, D10_SKBYTES);
                memcpy(expdh_ref_ct, d10_ct, D10_CTBYTES);
                memcpy(expdh_ref_enc, d10_ss_e, 32u);
                memcpy(expdh_ref_warm, warm, 32u);
                memcpy(expdh_ref_cold, cold, 32u);
                memcpy(expdh_ref_reject, reject, 32u);
            } else {
                mm += (uint32_t) (memcmp(d10_pk, expdh_ref_pk, D10_PKBYTES) != 0);
                mm += (uint32_t) (memcmp(d10_sk, expdh_ref_sk, D10_SKBYTES) != 0);
                mm += (uint32_t) (memcmp(d10_ct, expdh_ref_ct, D10_CTBYTES) != 0);
                mm += (uint32_t) (memcmp(d10_ss_e, expdh_ref_enc, 32u) != 0);
                mm += (uint32_t) (memcmp(warm, expdh_ref_warm, 32u) != 0);
                mm += (uint32_t) (memcmp(cold, expdh_ref_cold, 32u) != 0);
                mm += (uint32_t) (memcmp(reject, expdh_ref_reject, 32u) != 0);
            }
        }
    }
    d10_set_optimizations(0u);
    return mm + smoke;
}

static uint32_t expdh_low_order(void)
{
    static const uint8_t low[3][32] = {{0}, {1}, {
        0xec, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x7f
    }};
    uint32_t mm = 0u;
    for (uint32_t i = 0u; i < 3u; i++) {
        curve25519_scalarmult(expdh_low_ref, bench_scalar, low[i]);
        expdg_x25519_pair(expdh_low_fixed, expdh_low_got, bench_scalar, low[i], 0u);
        mm += (uint32_t) (memcmp(expdh_low_ref, expdh_low_got, 32u) != 0);
        expdg_x25519_pair(expdh_low_fixed, expdh_low_got, bench_scalar, low[i], 1u);
        mm += (uint32_t) (memcmp(expdh_low_ref, expdh_low_got, 32u) != 0);
    }
    return mm;
}

static void expdh_measure(void)
{
    uint8_t warm[32];
    d10_set_optimizations(1u);
    PQCLEAN_randombytes_reset(0xd8002001u);
    d10_keypair(d10_pk, d10_sk);
    d10_expand(&d10_cache, d10_sk);
    PQCLEAN_randombytes_reset(0xd8003001u);
    (void) expdh_d10_enc(d10_ct, d10_ss_e, d10_pk, 3u);

    for (uint32_t r = 0u; r < REP_N; r++) {
        for (uint32_t k = 0u; k < 4u; k++) {
            uint32_t mode = (k + r) & 3u;
            PQCLEAN_randombytes_reset(0xd8004001u + r);
            expdh_timer_start();
            (void) expdh_d10_enc(d10_ct, d10_ss_e, d10_pk, mode);
            rep_cyc[mode][r] = expdh_timer_stop();
        }
        if ((r & 1u) == 0u) {
            expdh_timer_start(); expdh_d10_dec_expanded(warm, d10_ct, &d10_cache, 0u); rep_cyc[4][r] = expdh_timer_stop();
            expdh_timer_start(); expdh_d10_dec_expanded(warm, d10_ct, &d10_cache, 1u); rep_cyc[5][r] = expdh_timer_stop();
            expdh_timer_start(); expdh_d10_dec_cold(warm, d10_ct, d10_sk, 0u);       rep_cyc[6][r] = expdh_timer_stop();
            expdh_timer_start(); expdh_d10_dec_cold(warm, d10_ct, d10_sk, 1u);       rep_cyc[7][r] = expdh_timer_stop();
        } else {
            expdh_timer_start(); expdh_d10_dec_expanded(warm, d10_ct, &d10_cache, 1u); rep_cyc[5][r] = expdh_timer_stop();
            expdh_timer_start(); expdh_d10_dec_expanded(warm, d10_ct, &d10_cache, 0u); rep_cyc[4][r] = expdh_timer_stop();
            expdh_timer_start(); expdh_d10_dec_cold(warm, d10_ct, d10_sk, 1u);       rep_cyc[7][r] = expdh_timer_stop();
            expdh_timer_start(); expdh_d10_dec_cold(warm, d10_ct, d10_sk, 0u);       rep_cyc[6][r] = expdh_timer_stop();
        }
    }
    d10_set_optimizations(0u);
}

static void expdh_run_all(void)
{
    uint32_t mm, low;
    dwt_setup();
    mm = expdh_equivalence();
    low = expdh_low_order();
    uart_puts("expDH correctness full-mm="); uart_put_u32(mm);
    uart_puts(" low-mm="); uart_put_u32(low); uart_puts("\n");
    harness_fails += mm + low;
    expdh_measure();
    uart_puts("expDH encaps A="); uart_put_u32(expdh_median(rep_cyc[0]));
    uart_puts(" cswap="); uart_put_u32(expdh_median(rep_cyc[1]));
    uart_puts(" batch="); uart_put_u32(expdh_median(rep_cyc[2]));
    uart_puts(" both="); uart_put_u32(expdh_median(rep_cyc[3])); uart_puts("\n");
    uart_puts("expDH warm A="); uart_put_u32(expdh_median(rep_cyc[4]));
    uart_puts(" mve="); uart_put_u32(expdh_median(rep_cyc[5]));
    uart_puts(" cold A="); uart_put_u32(expdh_median(rep_cyc[6]));
    uart_puts(" mve="); uart_put_u32(expdh_median(rep_cyc[7])); uart_puts("\n");
    uart_puts((mm + low) == 0u ? "expDH CORRECTNESS GATE PASS\n"
                               : "expDH CORRECTNESS GATE FAIL\n");
}

#undef EXPDH_DTCM
