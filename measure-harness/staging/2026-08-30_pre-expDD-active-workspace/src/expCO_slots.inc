/* expCO: keygen/encaps/decaps in-context checkpoint (융합 / 잔여 / 총) + IRQ 마스킹 대조.
 * 사전등록: 2026-08-28_expCO_incontext_checkpoint_prereg.md
 * 슬롯 775..831. 이 ELF는 checkpoint 삽입으로 링크 배치가 동결 expCK와 다르므로
 * 절대 cycle 을 tab:final 과 섞지 않는다. 구간 차분 해석 전용.
 *
 * 모드: 3=F(Fiat+x4, 스티치 없음) · 1=U(두 스트림 융합) · 2=U1(job 0 만 융합, encaps 전용)
 * 융합 구간 = crypto_kem_* 호출. 잔여 구간 = finish_all 또는 직접 fiat ladder.
 * expCJ 가 끝난 뒤 실행되므로 xw_ref_* scratch 를 안전하게 재사용한다. */

#define EXPCO_SLOT_BASE 775u

static uint32_t expco_mismatch, expco_timing_mm;
static volatile uint32_t expco_op;    /* 0=keygen 1=encaps 2=decaps */
static volatile uint32_t expco_mode;  /* 3=F 1=U 2=U1 */
static volatile uint32_t expco_slot;
static volatile uint32_t expco_mask_irq;
static volatile uint32_t expco_capture;

/* 그룹 공통 입력: decaps/encaps 가 매 셀 같은 pk/sk/ct 를 쓰도록 F 경로로 한 번 만든다. */
static void expco_prepare(void)
{
    PQCLEAN_randombytes_reset(0xc0d0beefu);
    xwing_ac_keypair(xw_pk, xw_sk, 3u);
    xwing_ac_enc(xw_ct, xw_ss_e, xw_pk, 3u);
}

static void expco_bench_cell(void)
{
    const uint32_t op = expco_op;
    const uint32_t mode = expco_mode;
    const uint32_t slot = expco_slot;
    const uint32_t use_u = (mode != 3u);
    uint8_t ss_m[32], ss_x[32], ephemeral[32];

    PQCLEAN_randombytes_reset(0xc0a5a5a5u);
    if (expco_mask_irq) __disable_irq();

    for (uint32_t r = 0; r < REP_N; r++) {
        uint32_t fused_end, residual_end, total_end;

        x25519_u_queue_reset();

        if (op == 0u) {
            /* ---- keygen: X25519 job 1개 ---- */
            (void) PQCLEAN_randombytes(xw_sk + CRYPTO_SECRETKEYBYTES, 32);
            clamp(xw_sk + CRYPTO_SECRETKEYBYTES);
            if (use_u)
                expco_mismatch += (x25519_u_enqueue(xw_pk + CRYPTO_PUBLICKEYBYTES,
                                                    xw_sk + CRYPTO_SECRETKEYBYTES,
                                                    basepoint) != 0);
            mlkem_keccakx4_mode = 1u;
            dwt_span_begin();
            crypto_kem_keypair(xw_pk, xw_sk);
            fused_end = dwt_span_end();

            if (use_u)
                x25519_u_finish_all();
            else
                curve25519_scalarmult_fiat(xw_pk + CRYPTO_PUBLICKEYBYTES,
                                           xw_sk + CRYPTO_SECRETKEYBYTES, basepoint);
            residual_end = dwt_span_end();

            mlkem_keccakx4_mode = 0u;
            memcpy(xw_sk + CRYPTO_SECRETKEYBYTES + 32,
                   xw_pk + CRYPTO_PUBLICKEYBYTES, 32);
            total_end = dwt_span_end();

        } else if (op == 1u) {
            /* ---- encaps: X25519 job 2개. mode 2 = job 0 만 융합 ---- */
            (void) PQCLEAN_randombytes(ephemeral, sizeof(ephemeral));
            clamp(ephemeral);
            if (use_u) {
                expco_mismatch += (x25519_u_enqueue(xw_ct + CRYPTO_CIPHERTEXTBYTES,
                                                    ephemeral, basepoint) != 0);
                if (mode == 1u)
                    expco_mismatch += (x25519_u_enqueue(ss_x, ephemeral,
                                                        xw_pk + CRYPTO_PUBLICKEYBYTES) != 0);
            }
            mlkem_keccakx4_mode = 1u;
            dwt_span_begin();
            crypto_kem_enc(xw_ct, ss_m, xw_pk);
            fused_end = dwt_span_end();

            if (mode == 3u) {
                curve25519_scalarmult_fiat(xw_ct + CRYPTO_CIPHERTEXTBYTES,
                                           ephemeral, basepoint);
                curve25519_scalarmult_fiat(ss_x, ephemeral,
                                           xw_pk + CRYPTO_PUBLICKEYBYTES);
            } else if (mode == 1u) {
                x25519_u_finish_all();
            } else {
                x25519_u_finish_all();
                curve25519_scalarmult_fiat(ss_x, ephemeral,
                                           xw_pk + CRYPTO_PUBLICKEYBYTES);
            }
            residual_end = dwt_span_end();

            mlkem_keccakx4_mode = 0u;
            xwing_combine(xw_ss_e, ss_m, ss_x,
                          xw_ct + CRYPTO_CIPHERTEXTBYTES,
                          xw_pk + CRYPTO_PUBLICKEYBYTES);
            total_end = dwt_span_end();

        } else {
            /* ---- decaps: X25519 job 1개, 매 반복 같은 ct/sk ---- */
            if (use_u)
                expco_mismatch += (x25519_u_enqueue(ss_x, xw_sk + CRYPTO_SECRETKEYBYTES,
                                                    xw_ct + CRYPTO_CIPHERTEXTBYTES) != 0);
            mlkem_keccakx4_mode = 1u;
            dwt_span_begin();
            crypto_kem_dec(ss_m, xw_ct, xw_sk);
            fused_end = dwt_span_end();

            if (use_u)
                x25519_u_finish_all();
            else
                curve25519_scalarmult_fiat(ss_x, xw_sk + CRYPTO_SECRETKEYBYTES,
                                           xw_ct + CRYPTO_CIPHERTEXTBYTES);
            residual_end = dwt_span_end();

            mlkem_keccakx4_mode = 0u;
            xwing_combine(xw_ss_d, ss_m, ss_x,
                          xw_ct + CRYPTO_CIPHERTEXTBYTES,
                          xw_sk + CRYPTO_SECRETKEYBYTES + 32);
            total_end = dwt_span_end();
        }

        rep_cyc[slot][r] = total_end;
        rep_cyc[slot + 1u][r] = fused_end;
        rep_cyc[slot + 2u][r] = residual_end - fused_end;
        expco_mismatch += x25519_u_queue_pending() + x25519_u_failures();
    }

    if (expco_mask_irq) __enable_irq();
    mlkem_keccakx4_mode = 0u;
    x25519_u_queue_reset();

    /* 그룹 첫 셀의 최종 출력을 기준으로 나머지 셀을 바이트 대조한다. */
    if (expco_capture) {
        if (op == 0u) {
            memcpy(xw_ref_pk, xw_pk, sizeof(xw_ref_pk));
            memcpy(xw_ref_sk, xw_sk, sizeof(xw_ref_sk));
        } else if (op == 1u) {
            memcpy(xw_ref_ct, xw_ct, sizeof(xw_ref_ct));
            memcpy(xw_ref_ss_e, xw_ss_e, sizeof(xw_ref_ss_e));
        } else {
            memcpy(xw_ref_ss_d, xw_ss_d, sizeof(xw_ref_ss_d));
        }
    } else {
        if (op == 0u) {
            expco_timing_mm += byte_mismatches(xw_pk, xw_ref_pk, sizeof(xw_ref_pk));
            expco_timing_mm += byte_mismatches(xw_sk, xw_ref_sk, sizeof(xw_ref_sk));
        } else if (op == 1u) {
            expco_timing_mm += byte_mismatches(xw_ct, xw_ref_ct, sizeof(xw_ref_ct));
            expco_timing_mm += byte_mismatches(xw_ss_e, xw_ref_ss_e, sizeof(xw_ref_ss_e));
        } else {
            expco_timing_mm += byte_mismatches(xw_ss_d, xw_ref_ss_d, sizeof(xw_ref_ss_d));
        }
    }
}

/* op 마다 A-B-B-A 네 셀. modes[] 는 그 순서의 모드다. */
static void expco_group(uint32_t op, const uint8_t *modes, uint32_t base)
{
    for (uint32_t i = 0; i < 4u; i++) {
        expco_op = op;
        expco_mode = modes[i];
        expco_slot = base + 3u * i;
        expco_mask_irq = 0u;
        expco_capture = (i == 0u);
        run_on_stack(expco_bench_cell, dtcm_stack + sizeof(dtcm_stack));
    }
}

static void expco_run_all(void)
{
    static const uint8_t fu[4]  = {3u, 1u, 1u, 3u};
    static const uint8_t fu1[4] = {3u, 2u, 2u, 3u};

    expco_mismatch = 0u;
    expco_timing_mm = 0u;
    expaj_stack_prepare();

    /* keygen 은 매 반복 새 키를 만들므로 prepare 없이도 자기완결이다.
     * encaps/decaps 는 고정 pk/sk/ct 가 필요하므로 그룹 직전에 다시 만든다. */
    expco_group(0u, fu, EXPCO_SLOT_BASE + 0u);

    run_on_stack(expco_prepare, dtcm_stack + sizeof(dtcm_stack));
    expco_group(2u, fu, EXPCO_SLOT_BASE + 12u);

    run_on_stack(expco_prepare, dtcm_stack + sizeof(dtcm_stack));
    expco_group(1u, fu, EXPCO_SLOT_BASE + 24u);

    run_on_stack(expco_prepare, dtcm_stack + sizeof(dtcm_stack));
    expco_group(1u, fu1, EXPCO_SLOT_BASE + 36u);

    /* IRQ 마스킹 대조: 같은 F 모드를 interrupt 마스킹 상태로 다시 잰다. */
    run_on_stack(expco_prepare, dtcm_stack + sizeof(dtcm_stack));
    {
        /* 순서가 곧 정확성이다. encaps 는 xw_ct 를, keygen 은 xw_pk/xw_sk 를 덮는다.
         * decaps(prepare 의 ct 필요) → encaps → keygen 순이어야 세 셀 모두
         * 각 그룹 기준과 바이트로 일치한다. */
        static const uint8_t ops[3]    = {2u, 1u, 0u};
        static const uint32_t bases[3] = {EXPCO_SLOT_BASE + 54u,
                                          EXPCO_SLOT_BASE + 51u,
                                          EXPCO_SLOT_BASE + 48u};
        for (uint32_t i = 0; i < 3u; i++) {
            expco_op = ops[i];
            expco_mode = 3u;
            expco_slot = bases[i];
            expco_mask_irq = 1u;
            expco_capture = 0u;
            run_on_stack(expco_bench_cell, dtcm_stack + sizeof(dtcm_stack));
        }
    }

    expaj_stack_check();
    uart_puts("expCO mismatch="); uart_put_u32(expco_mismatch);
    uart_puts(" timing-mm="); uart_put_u32(expco_timing_mm);
    uart_puts(" stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expco_mismatch + expco_timing_mm + expaj_stack_canary_fails;
}
