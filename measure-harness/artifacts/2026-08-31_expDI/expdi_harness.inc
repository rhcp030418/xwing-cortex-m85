/* expDI: Cortex-M85 dual-beat scheduling experiment for X25519 cswap. */

#define EXPDI_DTCM __attribute__((aligned(16), section(".dtcm")))
#define EXPDI_BATCH 1024u

extern void expdi_cswap_xor(uint32_t a[16], uint32_t b[16], uint32_t mask);
extern void expdi_cswap_vpsel(uint32_t a[16], uint32_t b[16], uint32_t mask);
extern void expdi_cswap_sched(uint32_t a[16], uint32_t b[16], uint32_t mask);
extern void expdg_curve25519_mvecswap(uint8_t out[32], const uint8_t scalar[32],
                                      const uint8_t point[32]);
extern void expdg_x25519_pair(uint8_t fixed_out[32], uint8_t variable_out[32],
                              const uint8_t scalar[32], const uint8_t point[32],
                              uint32_t use_mve_cswap);

/* 0=current XOR mask, 1=VPSEL chunk order, 2=M85 overlap schedule. */
volatile uint32_t expdi_cswap_mode;

static uint32_t expdi_a[3][16] EXPDI_DTCM;
static uint32_t expdi_b[3][16] EXPDI_DTCM;
static uint32_t expdi_ref_a[16] EXPDI_DTCM;
static uint32_t expdi_ref_b[16] EXPDI_DTCM;
static uint8_t expdi_ref_pk[D10_PKBYTES] EXPDI_DTCM;
static uint8_t expdi_ref_sk[D10_SKBYTES] EXPDI_DTCM;
static uint8_t expdi_ref_ct[D10_CTBYTES] EXPDI_DTCM;
static uint8_t expdi_ref_enc[32] EXPDI_DTCM;
static uint8_t expdi_ref_warm[32] EXPDI_DTCM;
static uint8_t expdi_ref_cold[32] EXPDI_DTCM;
static uint8_t expdi_ref_reject[32] EXPDI_DTCM;
static uint8_t expdi_low_ref[32] EXPDI_DTCM;
static uint8_t expdi_low_got[32] EXPDI_DTCM;
static uint8_t expdi_low_fixed[32] EXPDI_DTCM;
static uint32_t expdi_pmu[3][EXPDD_METRICS];

static void expdi_timer_start(void)
{
    __DSB(); __ISB(); DWT->CYCCNT = 0u; __DSB(); __ISB();
}

static uint32_t expdi_timer_stop(void)
{
    __DSB(); __ISB(); return DWT->CYCCNT;
}

static uint32_t expdi_median(const volatile uint32_t values[REP_N])
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

static void expdi_cswap(uint32_t mode, uint32_t a[16], uint32_t b[16], uint32_t mask)
{
    if (mode == 0u) expdi_cswap_xor(a, b, mask);
    else if (mode == 1u) expdi_cswap_vpsel(a, b, mask);
    else expdi_cswap_sched(a, b, mask);
}

static void expdi_init_words(uint32_t mode)
{
    for (uint32_t i = 0u; i < 16u; i++) {
        expdi_a[mode][i] = 0x10203040u ^ (i * 0x9e3779b9u);
        expdi_b[mode][i] = 0xfedcba98u ^ (i * 0x7f4a7c15u);
    }
}

static void expdi_micro_batch(uint32_t mode)
{
    for (uint32_t i = 0u; i < EXPDI_BATCH; i++)
        expdi_cswap(mode, expdi_a[mode], expdi_b[mode], 0xffffffffu);
}

static uint32_t expdi_micro_correctness(void)
{
    uint32_t mm = 0u;
    for (uint32_t tc = 0u; tc < 16u; tc++) {
        for (uint32_t i = 0u; i < 16u; i++) {
            expdi_ref_a[i] = 0x31415926u ^ (tc * 0x9e3779b9u) ^ i;
            expdi_ref_b[i] = 0x27182818u ^ (tc * 0x7f4a7c15u) ^ (i << 16);
        }
        for (uint32_t sw = 0u; sw < 2u; sw++) {
            for (uint32_t mode = 0u; mode < 3u; mode++) {
                memcpy(expdi_a[mode], expdi_ref_a, sizeof(expdi_ref_a));
                memcpy(expdi_b[mode], expdi_ref_b, sizeof(expdi_ref_b));
                expdi_cswap(mode, expdi_a[mode], expdi_b[mode], 0u - sw);
                mm += (uint32_t) (memcmp(expdi_a[mode], sw ? expdi_ref_b : expdi_ref_a,
                                            sizeof(expdi_ref_a)) != 0);
                mm += (uint32_t) (memcmp(expdi_b[mode], sw ? expdi_ref_a : expdi_ref_b,
                                            sizeof(expdi_ref_b)) != 0);
            }
        }
    }
    return mm;
}

static void expdi_x25519(uint8_t out[32], const uint8_t scalar[32],
                         const uint8_t point[32], uint32_t mode)
{
    expdi_cswap_mode = mode;
    expdg_curve25519_mvecswap(out, scalar, point);
    expdi_cswap_mode = 0u;
}

static void expdi_x25519_pair(uint8_t fixed_out[32], uint8_t variable_out[32],
                              const uint8_t scalar[32], const uint8_t point[32],
                              uint32_t mode)
{
    expdi_cswap_mode = mode;
    expdg_x25519_pair(fixed_out, variable_out, scalar, point, 1u);
    expdi_cswap_mode = 0u;
}

static int expdi_d10_enc(uint8_t ct[D10_CTBYTES], uint8_t ss[32],
                         const uint8_t pk[D10_PKBYTES], uint32_t mode)
{
    uint8_t eseed[64], ss_m[32], ss_x[32], ek_x[32];
    if (d10_ek_check(pk) != 0) return -1;
    (void) PQCLEAN_randombytes(eseed, sizeof(eseed));
    crypto_kem_enc_derand(ct, ss_m, pk, eseed);
    memcpy(ek_x, eseed + 32, 32);
    clamp(ek_x);
    expdi_x25519_pair(ct + CRYPTO_CIPHERTEXTBYTES, ss_x, ek_x,
                      pk + CRYPTO_PUBLICKEYBYTES, mode);
    d10_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES,
                pk + CRYPTO_PUBLICKEYBYTES);
    return 0;
}

static void expdi_d10_dec_expanded(uint8_t ss[32], const uint8_t ct[D10_CTBYTES],
                                    const d10_expanded *e, uint32_t mode)
{
    uint8_t ss_m[32], ss_x[32], k[32];
    crypto_kem_dec(ss_m, ct, e->sk_m);
    memcpy(k, e->sk_x, 32);
    clamp(k);
    expdi_x25519(ss_x, k, ct + CRYPTO_CIPHERTEXTBYTES, mode);
    d10_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES, e->pk_x);
}

static void expdi_d10_dec_cold(uint8_t ss[32], const uint8_t ct[D10_CTBYTES],
                               const uint8_t sk[D10_SKBYTES], uint32_t mode)
{
    d10_expanded e;
    d10_expand(&e, sk);
    expdi_d10_dec_expanded(ss, ct, &e, mode);
}

static uint32_t expdi_full_correctness(void)
{
    uint32_t mm = 0u, smoke = 0u;
    uint8_t warm[32], cold[32], reject[32];
    d10_set_optimizations(1u);
    for (uint32_t seed = 0u; seed < 8u; seed++) {
        const uint32_t rng = 0xd9001001u + seed * 0x9e37u;
        for (uint32_t mode = 0u; mode < 3u; mode++) {
            PQCLEAN_randombytes_reset(rng);
            d10_keypair(d10_pk, d10_sk);
            d10_expand(&d10_cache, d10_sk);
            smoke += (uint32_t) (expdi_d10_enc(d10_ct, d10_ss_e, d10_pk, mode) != 0);
            expdi_d10_dec_expanded(warm, d10_ct, &d10_cache, mode);
            expdi_d10_dec_cold(cold, d10_ct, d10_sk, mode);
            smoke += (uint32_t) (memcmp(d10_ss_e, warm, 32u) != 0);
            mm += (uint32_t) (memcmp(warm, cold, 32u) != 0);
            d10_ct[0] ^= 0x5au;
            expdi_d10_dec_expanded(reject, d10_ct, &d10_cache, mode);
            d10_ct[0] ^= 0x5au;
            if (mode == 0u) {
                memcpy(expdi_ref_pk, d10_pk, D10_PKBYTES);
                memcpy(expdi_ref_sk, d10_sk, D10_SKBYTES);
                memcpy(expdi_ref_ct, d10_ct, D10_CTBYTES);
                memcpy(expdi_ref_enc, d10_ss_e, 32u);
                memcpy(expdi_ref_warm, warm, 32u);
                memcpy(expdi_ref_cold, cold, 32u);
                memcpy(expdi_ref_reject, reject, 32u);
            } else {
                mm += (uint32_t) (memcmp(d10_pk, expdi_ref_pk, D10_PKBYTES) != 0);
                mm += (uint32_t) (memcmp(d10_sk, expdi_ref_sk, D10_SKBYTES) != 0);
                mm += (uint32_t) (memcmp(d10_ct, expdi_ref_ct, D10_CTBYTES) != 0);
                mm += (uint32_t) (memcmp(d10_ss_e, expdi_ref_enc, 32u) != 0);
                mm += (uint32_t) (memcmp(warm, expdi_ref_warm, 32u) != 0);
                mm += (uint32_t) (memcmp(cold, expdi_ref_cold, 32u) != 0);
                mm += (uint32_t) (memcmp(reject, expdi_ref_reject, 32u) != 0);
            }
        }
    }
    d10_set_optimizations(0u);
    return mm + smoke;
}

static uint32_t expdi_low_order(void)
{
    static const uint8_t low[3][32] = {{0}, {1}, {
        0xec, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
        0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x7f
    }};
    uint32_t mm = 0u;
    for (uint32_t i = 0u; i < 3u; i++) {
        curve25519_scalarmult(expdi_low_ref, bench_scalar, low[i]);
        for (uint32_t mode = 0u; mode < 3u; mode++) {
            expdi_x25519_pair(expdi_low_fixed, expdi_low_got, bench_scalar, low[i], mode);
            mm += (uint32_t) (memcmp(expdi_low_ref, expdi_low_got, 32u) != 0);
        }
    }
    return mm;
}

static void expdi_measure(void)
{
    uint8_t warm[32];
    d10_set_optimizations(1u);
    dwt_setup();
    for (uint32_t r = 0u; r < REP_N; r++) {
        for (uint32_t k = 0u; k < 3u; k++) {
            const uint32_t mode = (k + r) % 3u;
            expdi_init_words(mode);
            expdi_timer_start(); expdi_micro_batch(mode);
            rep_cyc[mode][r] = expdi_timer_stop();
        }
    }

    PQCLEAN_randombytes_reset(0xd9002001u);
    d10_keypair(d10_pk, d10_sk);
    d10_expand(&d10_cache, d10_sk);
    PQCLEAN_randombytes_reset(0xd9003001u);
    (void) expdi_d10_enc(d10_ct, d10_ss_e, d10_pk, 2u);
    for (uint32_t r = 0u; r < REP_N; r++) {
        for (uint32_t k = 0u; k < 3u; k++) {
            const uint32_t mode = (k + r) % 3u;
            PQCLEAN_randombytes_reset(0xd9004001u + r);
            expdi_timer_start();
            (void) expdi_d10_enc(d10_ct, d10_ss_e, d10_pk, mode);
            rep_cyc[3u + mode][r] = expdi_timer_stop();
            expdi_timer_start();
            expdi_d10_dec_expanded(warm, d10_ct, &d10_cache, mode);
            rep_cyc[6u + mode][r] = expdi_timer_stop();
            expdi_timer_start();
            expdi_d10_dec_cold(warm, d10_ct, d10_sk, mode);
            rep_cyc[9u + mode][r] = expdi_timer_stop();
        }
    }
    d10_set_optimizations(0u);
}

static void expdi_measure_pmu(void)
{
    const uint32_t saved = DWT->CTRL;
    CoreDebug->DEMCR |= CoreDebug_DEMCR_TRCENA_Msk;
    DWT->CTRL &= ~DWT_CTRL_CYCCNTENA_Msk;
    DCB->DAUTHCTRL |= 0x0fu;
    expdd_config_pairs();
    for (uint32_t mode = 0u; mode < 3u; mode++) {
        expdi_init_words(mode);
        expdd_start();
        expdi_micro_batch(mode);
        expdd_stop(expdi_pmu[mode]);
    }
    ARM_PMU_CNTR_Disable(0xffffffffu);
    DWT->CTRL = saved;
    __DSB(); __ISB();
}

static void expdi_print_triplet(const char *label, uint32_t base)
{
    uart_puts(label);
    uart_puts(" xor="); uart_put_u32(expdi_median(rep_cyc[base]));
    uart_puts(" vpsel="); uart_put_u32(expdi_median(rep_cyc[base + 1u]));
    uart_puts(" sched="); uart_put_u32(expdi_median(rep_cyc[base + 2u]));
    uart_puts("\n");
}

static void expdi_run_all(void)
{
    const uint32_t micro_mm = expdi_micro_correctness();
    const uint32_t full_mm = expdi_full_correctness();
    const uint32_t low_mm = expdi_low_order();
    harness_fails += micro_mm + full_mm + low_mm;
    uart_puts("expDI correctness micro-mm="); uart_put_u32(micro_mm);
    uart_puts(" full-mm="); uart_put_u32(full_mm);
    uart_puts(" low-mm="); uart_put_u32(low_mm); uart_puts("\n");
    expdi_measure();
    expdi_print_triplet("expDI micro1024", 0u);
    expdi_print_triplet("expDI encaps", 3u);
    expdi_print_triplet("expDI warm", 6u);
    expdi_print_triplet("expDI cold", 9u);
    expdi_measure_pmu();
    for (uint32_t mode = 0u; mode < 3u; mode++) {
        uart_puts("expDI pmu mode="); uart_put_u32(mode);
        uart_puts(" cyc="); uart_put_u32(expdi_pmu[mode][EXPDD_CYC] / EXPDI_BATCH);
        uart_puts(" inst="); uart_put_u32(expdi_pmu[mode][EXPDD_INST] / EXPDI_BATCH);
        uart_puts(" stall="); uart_put_u32(expdi_pmu[mode][EXPDD_STALL] / EXPDI_BATCH);
        uart_puts(" fe="); uart_put_u32(expdi_pmu[mode][EXPDD_FE] / EXPDI_BATCH);
        uart_puts(" be="); uart_put_u32(expdi_pmu[mode][EXPDD_BE] / EXPDI_BATCH);
        uart_puts("\n");
    }
    uart_puts((micro_mm + full_mm + low_mm) == 0u
              ? "expDI CORRECTNESS GATE PASS\n" : "expDI CORRECTNESS GATE FAIL\n");
}

#undef EXPDI_BATCH
#undef EXPDI_DTCM
