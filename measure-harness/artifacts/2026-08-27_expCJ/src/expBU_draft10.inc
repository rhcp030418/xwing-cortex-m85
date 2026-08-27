/* 실험 BU (E0): X-Wing **draft-10 준거** 구현.  Slots 678..689.
 *
 * 장부 §4.1.1: 현행 wrapper 는 ePrint 2024/039 Figure 12 준거이며 draft-10 과 네 곳이
 * 다르다. 부분 이동은 어느 정의에도 맞지 않으므로 **네 항목을 한 번에 옮긴다.**
 *
 *   1. combiner 입력 순서 : label 선두  ->  ss_M||ss_X||ct_X||pk_X||label (label 후미)
 *   2. decapsulation key  : 확장 상태   ->  packed 32B seed + SHAKE256(sk,96) 확장
 *   3. encapsulation 난수 : 내부 난수   ->  eseed 64B = m || ek_X 분할 (derand)
 *   4. encapsulation-key check : 없음   ->  FIPS 203 §7.2 검사 (MUST)
 *
 * draft-10 은 확장 결과의 캐싱을 MAY 로 허용한다. 그래서 decaps 를 두 가지로 잰다:
 *   cold = 매 호출 seed 에서 확장 (사양 그대로)
 *   warm = 확장본 캐시 (구현 허용)
 * 이것이 장부 W14(packed cold / expanded warm API)의 실측이기도 하다.
 *
 * 슬롯: 678 keygen / 679 encaps / 680 decaps-warm / 681 decaps-cold  (x3 반복 배치)
 */

#define EXPBU_SLOT_BASE 678u

#include "mlkem/polyvec.h"

extern void shake256(uint8_t *output, size_t outlen, const uint8_t *input, size_t inlen);
extern int crypto_kem_keypair_derand(unsigned char *pk, unsigned char *sk,
                                     const unsigned char *coins);
extern int crypto_kem_enc_derand(uint8_t *ct, uint8_t *ss, const uint8_t *pk,
                                 const uint8_t *coins);

#define D10_SKBYTES 32u
#define D10_PKBYTES (CRYPTO_PUBLICKEYBYTES + 32u)
#define D10_CTBYTES (CRYPTO_CIPHERTEXTBYTES + 32u)

/* 확장 상태 (warm 경로가 캐시한다) */
typedef struct {
    uint8_t sk_m[CRYPTO_SECRETKEYBYTES];
    uint8_t sk_x[32];
    uint8_t pk_x[32];
    uint8_t pk_m[CRYPTO_PUBLICKEYBYTES];
} d10_expanded;

static d10_expanded d10_cache __attribute__((section(".dtcm")));
static uint8_t d10_sk[D10_SKBYTES] __attribute__((section(".dtcm")));
static uint8_t d10_pk[D10_PKBYTES] __attribute__((section(".dtcm")));
static uint8_t d10_ct[D10_CTBYTES] __attribute__((section(".dtcm")));
static uint8_t d10_ss_e[32] __attribute__((section(".dtcm")));
static uint8_t d10_ss_d[32] __attribute__((section(".dtcm")));
static uint8_t d10_comb_in[134] __attribute__((section(".dtcm")));

/* expCJ: 같은 ELF에서 기준형(0)과 최종 채택형(1)을 한 번에 전환한다. */
static void d10_set_optimizations(uint32_t mode)
{
    expal_set_modes(mode, mode);
    mlkem_x06_mode = mode;
    x01_mode = mode;
    x02_mode = mode;
    k31_mode = mode;
}

static void d10_fixed_base(uint8_t out[32], const uint8_t scalar[32])
{
    if (mlkem_x06_mode) curve25519_scalarmult_base(out, scalar);
    else curve25519_scalarmult(out, scalar, basepoint);
}

/* draft-10 Combiner: label 이 **후미**다. */
static void d10_combine(uint8_t out[32], const uint8_t ss_m[32],
                        const uint8_t ss_x[32], const uint8_t ct_x[32],
                        const uint8_t pk_x[32])
{
    static const uint8_t label[6] = {'\\', '.', '/', '/', '^', '\\'};
    memcpy(d10_comb_in + 0,   ss_m,  32);
    memcpy(d10_comb_in + 32,  ss_x,  32);
    memcpy(d10_comb_in + 64,  ct_x,  32);
    memcpy(d10_comb_in + 96,  pk_x,  32);
    memcpy(d10_comb_in + 128, label,  6);
    sha3_256(out, d10_comb_in, sizeof(d10_comb_in));
}

/* draft-10 expandDecapsulationKey(sk) */
static void d10_expand(d10_expanded *e, const uint8_t sk[D10_SKBYTES])
{
    uint8_t expanded[96];
    shake256(expanded, sizeof(expanded), sk, D10_SKBYTES);
    crypto_kem_keypair_derand(e->pk_m, e->sk_m, expanded);   /* d||z = expanded[0:64] */
    memcpy(e->sk_x, expanded + 64, 32);
    {   /* X25519(sk_X, basepoint) — RFC 7748 은 스칼라를 내부에서 clamp 한다 */
        uint8_t k[32];
        memcpy(k, e->sk_x, 32);
        clamp(k);
        d10_fixed_base(e->pk_x, k);
    }
}

/* FIPS 203 §7.2 encapsulation-key check: pk_M 을 디코드 후 재인코드해 바이트 일치 확인 */
static int d10_ek_check(const uint8_t *pk_m)
{
    polyvec t;
    uint8_t re[KYBER_POLYVECBYTES];
    polyvec_frombytes(&t, pk_m);
    polyvec_tobytes(re, &t);
    return memcmp(re, pk_m, KYBER_POLYVECBYTES) == 0 ? 0 : -1;
}

static void d10_keypair(uint8_t pk[D10_PKBYTES], uint8_t sk[D10_SKBYTES])
{
    d10_expanded e;
    (void) PQCLEAN_randombytes(sk, D10_SKBYTES);
    d10_expand(&e, sk);
    memcpy(pk, e.pk_m, CRYPTO_PUBLICKEYBYTES);
    memcpy(pk + CRYPTO_PUBLICKEYBYTES, e.pk_x, 32);
}

static int d10_enc(uint8_t ct[D10_CTBYTES], uint8_t ss[32],
                   const uint8_t pk[D10_PKBYTES])
{
    uint8_t eseed[64], ss_m[32], ss_x[32], ek_x[32];

    if (d10_ek_check(pk) != 0) return -1;          /* MUST (FIPS 203 §7.2) */

    (void) PQCLEAN_randombytes(eseed, sizeof(eseed));
    crypto_kem_enc_derand(ct, ss_m, pk, eseed);    /* m = eseed[0:32] */
    memcpy(ek_x, eseed + 32, 32);
    clamp(ek_x);
    d10_fixed_base(ct + CRYPTO_CIPHERTEXTBYTES, ek_x);
    curve25519_scalarmult(ss_x, ek_x, pk + CRYPTO_PUBLICKEYBYTES);
    d10_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES,
                pk + CRYPTO_PUBLICKEYBYTES);
    return 0;
}

static void d10_dec_expanded(uint8_t ss[32], const uint8_t ct[D10_CTBYTES],
                             const d10_expanded *e)
{
    uint8_t ss_m[32], ss_x[32];
    crypto_kem_dec(ss_m, ct, e->sk_m);
    {
        uint8_t k[32];
        memcpy(k, e->sk_x, 32);
        clamp(k);
        curve25519_scalarmult(ss_x, k, ct + CRYPTO_CIPHERTEXTBYTES);
    }
    d10_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES, e->pk_x);
}

/* cold: 사양 그대로 — 매 호출 seed 에서 확장 */
static void d10_dec_cold(uint8_t ss[32], const uint8_t ct[D10_CTBYTES],
                         const uint8_t sk[D10_SKBYTES])
{
    d10_expanded e;
    d10_expand(&e, sk);
    d10_dec_expanded(ss, ct, &e);
}

/* warm: draft-10 이 MAY 로 허용하는 캐시 경로 */
static void d10_dec_warm(uint8_t ss[32], const uint8_t ct[D10_CTBYTES])
{
    d10_dec_expanded(ss, ct, &d10_cache);
}

/* ---- 정확성 ---- */
static uint32_t d10_smoke, d10_reject_fail, d10_ekchk_fail, d10_coldwarm_mm;

static void d10_correct(void)
{
    uint32_t smoke = 0, rej = 0, ekf = 0, cw = 0;
    uint8_t ss_cold[32];
    d10_set_optimizations(1u);
    for (uint32_t s = 0; s < 8u; s++) {
        PQCLEAN_randombytes_reset(0xd10a0000u + s * 0x00009e37u);
        d10_keypair(d10_pk, d10_sk);
        d10_expand(&d10_cache, d10_sk);
        if (d10_enc(d10_ct, d10_ss_e, d10_pk) != 0) { ekf++; continue; }
        d10_dec_warm(d10_ss_d, d10_ct);
        smoke += (memcmp(d10_ss_e, d10_ss_d, 32) != 0);
        d10_dec_cold(ss_cold, d10_ct, d10_sk);
        cw += byte_mismatches(ss_cold, d10_ss_d, 32);
        /* 암묵적 거부: ct 를 흔들면 warm/cold 가 같은 (그러나 다른) 값을 내야 한다 */
        d10_ct[0] ^= 0x5au;
        d10_dec_warm(d10_ss_d, d10_ct);
        d10_dec_cold(ss_cold, d10_ct, d10_sk);
        rej += byte_mismatches(ss_cold, d10_ss_d, 32);
        rej += (memcmp(d10_ss_e, d10_ss_d, 32) == 0);   /* 거부인데 같으면 오류 */
        d10_ct[0] ^= 0x5au;
    }
    /* §7.2 검사가 실제로 잡는지: pk_M 마지막 바이트를 범위 밖으로 흔든다 */
    {
        uint8_t bad[D10_PKBYTES];
        memcpy(bad, d10_pk, sizeof(bad));
        bad[KYBER_POLYVECBYTES - 1] |= 0xf0u;
        if (d10_enc(d10_ct, d10_ss_e, bad) == 0 && d10_ek_check(bad) != 0) ekf++;
    }
    d10_smoke = smoke; d10_reject_fail = rej; d10_ekchk_fail = ekf; d10_coldwarm_mm = cw;
    d10_set_optimizations(0u);
}

/* ---- 벤치 ---- */
static volatile uint32_t d10_slot;

static void d10_bench(void)
{
    const uint32_t slot = d10_slot;
    uint32_t r;
    d10_set_optimizations(1u);
    PQCLEAN_randombytes_reset(0xa1ab5a5au);
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin(); d10_keypair(d10_pk, d10_sk);
        rep_cyc[slot][r] = dwt_span_end();
    }
    d10_expand(&d10_cache, d10_sk);
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin(); (void) d10_enc(d10_ct, d10_ss_e, d10_pk);
        rep_cyc[slot + 1u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin(); d10_dec_warm(d10_ss_d, d10_ct);
        rep_cyc[slot + 2u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin(); d10_dec_cold(d10_ss_d, d10_ct, d10_sk);
        rep_cyc[slot + 3u][r] = dwt_span_end();
    }
    d10_set_optimizations(0u);
}

static void d10_run_all(void)
{
    uint32_t i;
    expaj_stack_prepare();
    run_on_stack(d10_correct, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expBU d10: smoke="); uart_put_u32(d10_smoke);
    uart_puts(" reject-fail="); uart_put_u32(d10_reject_fail);
    uart_puts(" ekchk-fail="); uart_put_u32(d10_ekchk_fail);
    uart_puts(" coldwarm-mm="); uart_put_u32(d10_coldwarm_mm);
    uart_puts("\n");
    harness_fails += d10_smoke + d10_reject_fail + d10_ekchk_fail + d10_coldwarm_mm;

    for (i = 0; i < 3u; i++) {
        d10_slot = EXPBU_SLOT_BASE + 4u * i;
        run_on_stack(d10_bench, dtcm_stack + sizeof(dtcm_stack));
    }
    uart_puts("expBU bench done\n");
}
