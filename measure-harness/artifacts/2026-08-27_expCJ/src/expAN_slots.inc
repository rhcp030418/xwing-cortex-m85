/* Experiment AN: X-Wing 최상위 cycle 귀속 (E0-top).  Slots 362..375.
 *
 * 목적: expAL cell-11(= X/Y/C8+C9 현행 채택 경로)의 keygen/encaps/decaps 총
 * cycle이 ML-KEM / X25519 / combiner / glue 로 각각 얼마나 쪼개지는지를 실측한다.
 * 기존 Z2 는 ML-KEM 내부(matacc/basemul/CBD/packing)만 쟀고 X-Wing wrapper 최상위
 * 분해는 프로젝트에 존재한 적이 없다.
 *
 * 방법: dwt_span_begin() 이 CYCCNT 를 0으로 리셋하므로 span 중첩은 불가능하다.
 * 따라서 span 은 연산당 1회만 열고, 중간에서 DWT->CYCCNT 를 리셋 없이 읽는
 * 체크포인트 방식을 쓴다(실험 AI 와 같은 방식). 부분 구간은 회수기에서 인접
 * 체크포인트 차분으로 계산한다.
 *
 * 검증: RNG 시드와 루프 순서를 expAL bench(0xa1ab5a5au, keygen×N → encaps×N →
 * decaps×N)와 정확히 일치시킨다. 따라서 slot 362/365/370 의 중앙값은 expAL
 * cell-11(761,811~761,847 / 1,134,806~1,134,825 / 809,797~809,817)과 체크포인트
 * 오버헤드 범위 안에서 일치해야 한다. 일치하지 않으면 계측 자체가 틀린 것이다.
 *
 * 슬롯 배치
 *   362 keygen total
 *   363 keygen  c1 = crypto_kem_keypair 직후
 *   364 keygen  c2 = fixed-base curve25519_scalarmult 직후
 *   365 encaps total
 *   366 encaps  c1 = crypto_kem_enc 직후
 *   367 encaps  c2 = fixed-base scalarmult(ctX) 직후
 *   368 encaps  c3 = variable-base scalarmult(ssX) 직후
 *   369 encaps  c4 = xwing_combine 직후
 *   370 decaps total
 *   371 decaps  c1 = crypto_kem_dec 직후
 *   372 decaps  c2 = variable-base scalarmult 직후
 *   373 decaps  c3 = xwing_combine 직후
 *   374 calib   빈 span (begin/end 오버헤드)
 *   375 calib   체크포인트 4개만 있는 빈 span (per-checkpoint 오버헤드)
 */

#define EXPAN_CKPT(v) do { __DSB(); __ISB(); (v) = DWT->CYCCNT; } while (0)

#define EXPAN_SLOT_BASE 362u

volatile uint32_t expan_byte_mismatch = 9;   /* 계측본 대 원본 wrapper 출력 */
volatile uint32_t expan_smoke_fails   = 9;   /* ss_e == ss_d 실패 수 */
volatile uint32_t expan_checks        = 0;

/* 계측본 출력 보관 (원본 wrapper 결과 xw_ref_* 와 대조) */
static uint8_t expan_pk[XWING_PUBLICKEYBYTES]  __attribute__((section(".dtcm")));
static uint8_t expan_sk[XWING_SECRETKEYBYTES]  __attribute__((section(".dtcm")));
static uint8_t expan_ct[XWING_CIPHERTEXTBYTES] __attribute__((section(".dtcm")));
static uint8_t expan_ss_e[32] __attribute__((section(".dtcm")));
static uint8_t expan_ss_d[32] __attribute__((section(".dtcm")));

/* ---- 계측본 wrapper: 원본과 명령열이 같고 체크포인트만 삽입됐다 ---- */

static void expan_keypair(uint8_t pk[XWING_PUBLICKEYBYTES],
                          uint8_t sk[XWING_SECRETKEYBYTES],
                          uint32_t *c1, uint32_t *c2)
{
    crypto_kem_keypair(pk, sk);
    EXPAN_CKPT(*c1);
    (void) PQCLEAN_randombytes(sk + CRYPTO_SECRETKEYBYTES, 32);
    clamp(sk + CRYPTO_SECRETKEYBYTES);
    curve25519_scalarmult(pk + CRYPTO_PUBLICKEYBYTES,
                          sk + CRYPTO_SECRETKEYBYTES, basepoint);
    EXPAN_CKPT(*c2);
    memcpy(sk + CRYPTO_SECRETKEYBYTES + 32,
           pk + CRYPTO_PUBLICKEYBYTES, 32);
}

static void expan_enc(uint8_t ct[XWING_CIPHERTEXTBYTES], uint8_t ss[32],
                      const uint8_t pk[XWING_PUBLICKEYBYTES],
                      uint32_t *c1, uint32_t *c2, uint32_t *c3, uint32_t *c4)
{
    uint8_t ss_m[32], ss_x[32], ephemeral[32];
    crypto_kem_enc(ct, ss_m, pk);
    EXPAN_CKPT(*c1);
    (void) PQCLEAN_randombytes(ephemeral, sizeof(ephemeral));
    clamp(ephemeral);
    curve25519_scalarmult(ct + CRYPTO_CIPHERTEXTBYTES, ephemeral, basepoint);
    EXPAN_CKPT(*c2);
    curve25519_scalarmult(ss_x, ephemeral, pk + CRYPTO_PUBLICKEYBYTES);
    EXPAN_CKPT(*c3);
    xwing_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES,
                  pk + CRYPTO_PUBLICKEYBYTES);
    EXPAN_CKPT(*c4);
}

static void expan_dec(uint8_t ss[32], const uint8_t ct[XWING_CIPHERTEXTBYTES],
                      const uint8_t sk[XWING_SECRETKEYBYTES],
                      uint32_t *c1, uint32_t *c2, uint32_t *c3)
{
    uint8_t ss_m[32], ss_x[32];
    crypto_kem_dec(ss_m, ct, sk);
    EXPAN_CKPT(*c1);
    curve25519_scalarmult(ss_x, sk + CRYPTO_SECRETKEYBYTES,
                          ct + CRYPTO_CIPHERTEXTBYTES);
    EXPAN_CKPT(*c2);
    xwing_combine(ss, ss_m, ss_x, ct + CRYPTO_CIPHERTEXTBYTES,
                  sk + CRYPTO_SECRETKEYBYTES + 32);
    EXPAN_CKPT(*c3);
}

/* ---- 정확성 게이트: 계측본이 원본과 바이트 단위로 같은가 ---- */

static void expan_equivalence(void)
{
    uint32_t mismatch = 0;
    uint32_t fails = 0;
    uint32_t checks = 0;

    expal_set_modes(1u, 1u);

    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xa1110000u + s * 0x00009e37u;
        uint32_t c1, c2, c3, c4;

        /* 원본 wrapper */
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk);
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) != 0);

        /* 계측본 — 같은 시드, 같은 RNG stream */
        PQCLEAN_randombytes_reset(seed);
        expan_keypair(expan_pk, expan_sk, &c1, &c2);
        expan_enc(expan_ct, expan_ss_e, expan_pk, &c1, &c2, &c3, &c4);
        expan_dec(expan_ss_d, expan_ct, expan_sk, &c1, &c2, &c3);
        fails += (memcmp(expan_ss_e, expan_ss_d, 32) != 0);

        mismatch += byte_mismatches(expan_pk, xw_pk, sizeof(expan_pk));
        mismatch += byte_mismatches(expan_sk, xw_sk, sizeof(expan_sk));
        mismatch += byte_mismatches(expan_ct, xw_ct, sizeof(expan_ct));
        mismatch += byte_mismatches(expan_ss_e, xw_ss_e, sizeof(expan_ss_e));
        mismatch += byte_mismatches(expan_ss_d, xw_ss_d, sizeof(expan_ss_d));
        checks += 5u;

        /* 암묵적 거부 경로도 계측본에서 같은지 확인 */
        expan_ct[0] ^= 0x5au;
        xw_ct[0] ^= 0x5au;
        expan_dec(expan_ss_d, expan_ct, expan_sk, &c1, &c2, &c3);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        mismatch += byte_mismatches(expan_ss_d, xw_ss_d, sizeof(expan_ss_d));
        checks += 1u;
        expan_ct[0] ^= 0x5au;
        xw_ct[0] ^= 0x5au;
    }

    expan_byte_mismatch = mismatch;
    expan_smoke_fails = fails;
    expan_checks = checks;
}

/* ---- 측정 ---- */

static void bench_expan_reps(void)
{
    const uint32_t b = EXPAN_SLOT_BASE;
    uint32_t r;

    expal_set_modes(1u, 1u);
    PQCLEAN_randombytes_reset(0xa1ab5a5au);

    for (r = 0; r < REP_N; r++) {
        uint32_t c1, c2;
        dwt_span_begin();
        expan_keypair(xw_pk, xw_sk, &c1, &c2);
        rep_cyc[b + 0u][r] = dwt_span_end();
        rep_cyc[b + 1u][r] = c1;
        rep_cyc[b + 2u][r] = c2;
    }
    for (r = 0; r < REP_N; r++) {
        uint32_t c1, c2, c3, c4;
        dwt_span_begin();
        expan_enc(xw_ct, xw_ss_e, xw_pk, &c1, &c2, &c3, &c4);
        rep_cyc[b + 3u][r] = dwt_span_end();
        rep_cyc[b + 4u][r] = c1;
        rep_cyc[b + 5u][r] = c2;
        rep_cyc[b + 6u][r] = c3;
        rep_cyc[b + 7u][r] = c4;
    }
    for (r = 0; r < REP_N; r++) {
        uint32_t c1, c2, c3;
        dwt_span_begin();
        expan_dec(xw_ss_d, xw_ct, xw_sk, &c1, &c2, &c3);
        rep_cyc[b + 8u][r] = dwt_span_end();
        rep_cyc[b + 9u][r] = c1;
        rep_cyc[b + 10u][r] = c2;
        rep_cyc[b + 11u][r] = c3;
    }

    /* 오버헤드 기준선 — AM1b §2 의 교훈대로 추정하지 않고 직접 잰다 */
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        rep_cyc[b + 12u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        uint32_t c1, c2, c3, c4;
        dwt_span_begin();
        EXPAN_CKPT(c1);
        EXPAN_CKPT(c2);
        EXPAN_CKPT(c3);
        EXPAN_CKPT(c4);
        rep_cyc[b + 13u][r] = dwt_span_end();
        (void) c1; (void) c2; (void) c3; (void) c4;
    }
}

static void expan_run_all(void)
{
    expaj_stack_prepare();
    run_on_stack(expan_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAN equiv: bytes-mm="); uart_put_u32(expan_byte_mismatch);
    uart_puts(" smoke-fails="); uart_put_u32(expan_smoke_fails);
    uart_puts(" checks="); uart_put_u32(expan_checks);
    uart_puts("\n");
    harness_fails += expan_byte_mismatch + expan_smoke_fails;

    run_on_stack(bench_expan_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_stack_check();
    uart_puts("expAN bench: stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_stack_canary_fails;

    expal_set_modes(0, 0);
}
