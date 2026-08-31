/* expDG: complete X-Wing encaps A/B for the two expDF micro winners. */

#define EXPDG_DTCM __attribute__((aligned(16), section(".dtcm")))

extern void expdg_curve25519_mvecswap(uint8_t out[32], const uint8_t scalar[32],
                                      const uint8_t point[32]);
extern void expdg_x25519_pair(uint8_t fixed_out[32], uint8_t variable_out[32],
                              const uint8_t scalar[32], const uint8_t point[32],
                              uint32_t use_mve_cswap);

static uint8_t expdg_ref_ct[XWING_CIPHERTEXTBYTES] EXPDG_DTCM;
static uint8_t expdg_ref_ss[32] EXPDG_DTCM;
static uint8_t expdg_low_ref[32] EXPDG_DTCM;
static uint8_t expdg_low_got[32] EXPDG_DTCM;
static uint8_t expdg_low_fixed[32] EXPDG_DTCM;

static void expdg_timer_start(void)
{
    __DSB(); __ISB(); DWT->CYCCNT = 0u; __DSB(); __ISB();
}

static uint32_t expdg_timer_stop(void)
{
    __DSB(); __ISB(); return DWT->CYCCNT;
}

static uint32_t expdg_median(const volatile uint32_t values[REP_N])
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
static void expdg_xwing_enc(uint8_t ct[XWING_CIPHERTEXTBYTES], uint8_t ss[32],
                            const uint8_t pk[XWING_PUBLICKEYBYTES], uint32_t mode)
{
    uint8_t ss_m[32], ss_x[32], ephemeral[32];
    crypto_kem_enc(ct, ss_m, pk);
    PQCLEAN_randombytes(ephemeral, sizeof(ephemeral));
    clamp(ephemeral);
    if (mode == 0u) {
        curve25519_scalarmult_base(ct + CRYPTO_CIPHERTEXTBYTES, ephemeral);
        curve25519_scalarmult(ss_x, ephemeral, pk + CRYPTO_PUBLICKEYBYTES);
    } else if (mode == 1u) {
        curve25519_scalarmult_base(ct + CRYPTO_CIPHERTEXTBYTES, ephemeral);
        expdg_curve25519_mvecswap(ss_x, ephemeral, pk + CRYPTO_PUBLICKEYBYTES);
    } else {
        expdg_x25519_pair(ct + CRYPTO_CIPHERTEXTBYTES, ss_x, ephemeral,
                         pk + CRYPTO_PUBLICKEYBYTES, mode & 1u);
    }
    xwing_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES,
                  pk + CRYPTO_PUBLICKEYBYTES);
    memset(ephemeral, 0, sizeof(ephemeral));
}

static uint32_t expdg_equivalence(void)
{
    uint32_t mm = 0u;
    PQCLEAN_randombytes_reset(0xd6001001u);
    xwing_keypair(xw_pk, xw_sk);
    for (uint32_t seed = 0u; seed < 8u; seed++) {
        const uint32_t rng = 0xd6002001u + 0x101u * seed;
        PQCLEAN_randombytes_reset(rng);
        expdg_xwing_enc(expdg_ref_ct, expdg_ref_ss, xw_pk, 0u);
        for (uint32_t mode = 1u; mode < 4u; mode++) {
            PQCLEAN_randombytes_reset(rng);
            expdg_xwing_enc(xw_ct, xw_ss_e, xw_pk, mode);
            mm += (uint32_t) (memcmp(xw_ct, expdg_ref_ct, sizeof(expdg_ref_ct)) != 0);
            mm += (uint32_t) (memcmp(xw_ss_e, expdg_ref_ss, 32u) != 0);
            xwing_dec(xw_ss_d, xw_ct, xw_sk);
            mm += (uint32_t) (memcmp(xw_ss_d, expdg_ref_ss, 32u) != 0);
        }
    }
    return mm;
}

static uint32_t expdg_low_order(void)
{
    static const uint8_t low[3][32] = {{0}, {1}, {
        0xec, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x7f
    }};
    uint32_t mm = 0u;
    for (uint32_t i = 0u; i < 3u; i++) {
        curve25519_scalarmult(expdg_low_ref, bench_scalar, low[i]);
        expdg_x25519_pair(expdg_low_fixed, expdg_low_got, bench_scalar, low[i], 0u);
        mm += (uint32_t) (memcmp(expdg_low_ref, expdg_low_got, 32u) != 0);
        expdg_x25519_pair(expdg_low_fixed, expdg_low_got, bench_scalar, low[i], 1u);
        mm += (uint32_t) (memcmp(expdg_low_ref, expdg_low_got, 32u) != 0);
    }
    return mm;
}

static void expdg_measure(void)
{
    PQCLEAN_randombytes_reset(0xd6003001u);
    xwing_keypair(xw_pk, xw_sk);
    for (uint32_t r = 0u; r < REP_N; r++) {
        for (uint32_t k = 0u; k < 4u; k++) {
            uint32_t mode = (k + r) & 3u;
            PQCLEAN_randombytes_reset(0xd6004001u + r);
            expdg_timer_start();
            expdg_xwing_enc(xw_ct, xw_ss_e, xw_pk, mode);
            rep_cyc[mode][r] = expdg_timer_stop();
        }
    }
}

static void expdg_run_all(void)
{
    uint32_t mm, low;
    dwt_setup();
    mm = expdg_equivalence();
    low = expdg_low_order();
    uart_puts("expDG correctness full-mm="); uart_put_u32(mm);
    uart_puts(" low-mm="); uart_put_u32(low); uart_puts("\n");
    harness_fails += mm + low;
    expdg_measure();
    uart_puts("expDG encaps A="); uart_put_u32(expdg_median(rep_cyc[0]));
    uart_puts(" cswap="); uart_put_u32(expdg_median(rep_cyc[1]));
    uart_puts(" batch="); uart_put_u32(expdg_median(rep_cyc[2]));
    uart_puts(" both="); uart_put_u32(expdg_median(rep_cyc[3]));
    uart_puts("\n");
    uart_puts((mm + low) == 0u ? "expDG CORRECTNESS GATE PASS\n"
                               : "expDG CORRECTNESS GATE FAIL\n");
}

#undef EXPDG_DTCM
