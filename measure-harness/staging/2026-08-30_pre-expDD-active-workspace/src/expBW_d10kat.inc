/* 실험 BW (E0 마무리): X-Wing **draft-10 공식 test vector** 대조.
 *
 * 출처: draft-connolly-cfrg-xwing-kem-10 부록 test vector 1.
 * seed(32) · eseed(64) · ss(32) · pk(1,216) · ct(1,120)를 전량 대조한다.
 *
 * ss 는 expand -> ML-KEM keygen_internal -> X25519 -> ML-KEM encaps_internal -> combiner
 * 전 사슬에 의존하므로, ss 일치는 네 항목 이동 전체의 준거 확인이다.
 */

#include "expBW_d10kat_vectors.inc"

static uint32_t d10kat_ss_mm = 9, d10kat_pk_mm = 9, d10kat_ct_mm = 9, d10kat_dec_mm = 9;

/* derandomized 형태 — test vector 대조 전용 */
static void d10kat_run(void)
{
    d10_expanded e;
    uint8_t pk[D10_PKBYTES], ct[D10_CTBYTES], ss[32], ss_d[32];
    uint8_t ss_m[32], ss_x[32], ek_x[32];

    d10_set_optimizations(1u);

    d10_expand(&e, d10kat_seed);
    memcpy(pk, e.pk_m, CRYPTO_PUBLICKEYBYTES);
    memcpy(pk + CRYPTO_PUBLICKEYBYTES, e.pk_x, 32);
    d10kat_pk_mm = byte_mismatches(pk, d10kat_pk, sizeof(d10kat_pk));

    crypto_kem_enc_derand(ct, ss_m, pk, d10kat_eseed);   /* m = eseed[0:32] */
    memcpy(ek_x, d10kat_eseed + 32, 32);
    clamp(ek_x);
    d10_fixed_base(ct + CRYPTO_CIPHERTEXTBYTES, ek_x);
    curve25519_scalarmult(ss_x, ek_x, pk + CRYPTO_PUBLICKEYBYTES);
    d10_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES, pk + CRYPTO_PUBLICKEYBYTES);

    d10kat_ct_mm = byte_mismatches(ct, d10kat_ct, sizeof(d10kat_ct));
    d10kat_ss_mm = byte_mismatches(ss, d10kat_ss, sizeof(d10kat_ss));

    d10_dec_expanded(ss_d, ct, &e);
    d10kat_dec_mm = byte_mismatches(ss_d, d10kat_ss, sizeof(d10kat_ss));
    d10_set_optimizations(0u);
}

static void d10kat_all(void)
{
    expaj_stack_prepare();
    run_on_stack(d10kat_run, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expBW d10kat: ss-mm="); uart_put_u32(d10kat_ss_mm);
    uart_puts(" dec-mm="); uart_put_u32(d10kat_dec_mm);
    uart_puts(" pk1216-mm="); uart_put_u32(d10kat_pk_mm);
    uart_puts(" ct1120-mm="); uart_put_u32(d10kat_ct_mm);
    uart_puts("\n");
    harness_fails += d10kat_ss_mm + d10kat_dec_mm + d10kat_pk_mm + d10kat_ct_mm;
}
