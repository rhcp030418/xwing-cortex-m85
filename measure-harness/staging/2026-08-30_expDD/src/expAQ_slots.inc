/* Experiment AQ: matacc 내부 세분.  Slots 420..434.
 *
 * 목적: expAP 는 matacc 가 ML-KEM 비-Keccak 잔여의 46.7~56.4%(89~91 kcyc)임을 보였지만
 * 그 안이 XOF 배관인지 실제 산술인지는 미측정으로 남겼다. K14/K15(matrix-XOF ↔ rejection
 * ↔ matacc 융합) 설계에 그 세분이 필요하다.
 *
 * 구조: matacc 한 번은 K=3 이므로
 *     3 x { xof_absorb -> xof_squeezeblocks -> matacc_asm_* }
 * 이고, `matacc_asm_*` 는 `&state` 를 받아 rejection 도중 `shake128_squeezeblocks` 를
 * 되부른다(이미 융합돼 있다). 따라서 세 갈래로 나눈다.
 *
 *   absorb   = kyber_shake128_absorb          (matacc 전용 — noise 는 shake256_prf 를 쓴다)
 *   squeeze  = shake128_squeezeblocks         (C 호출 + asm 되부름 both)
 *   나머지   = matacc - absorb - squeeze      = rejection 판정 + MAC 누산 + asm 오버헤드
 *
 * 세 bucket 모두 Keccak-f1600 permutation cycle 은 차감돼 있다(AP_WRAP).
 * absorb/squeeze 는 matacc 창 안에 중첩되므로 matacc 값에도 포함돼 있다 — 분석에서 뺀다.
 *
 * 슬롯 배치 (연산당 5)
 *   +0 total (prof off)   +1 total (prof on)
 *   +2 matacc   +3 xof_absorb   +4 xof_squeeze
 *   keygen 420.. / encaps 425.. / decaps 430..
 */

#define EXPAQ_SLOT_BASE 420u

volatile uint32_t expaq_byte_mismatch = 9;
volatile uint32_t expaq_checks = 0;

static void expaq_store(uint32_t slot)
{
    rep_cyc[slot + 0u][0] += ap_cyc[AP_B_MATACC];
    rep_cyc[slot + 0u][1] += ap_calls[AP_B_MATACC];
    rep_cyc[slot + 1u][0] += ap_cyc[AP_B_XOF_ABSORB];
    rep_cyc[slot + 1u][1] += ap_calls[AP_B_XOF_ABSORB];
    rep_cyc[slot + 2u][0] += ap_cyc[AP_B_XOF_SQUEEZE];
    rep_cyc[slot + 2u][1] += ap_calls[AP_B_XOF_SQUEEZE];
}

static void expaq_equivalence(void)
{
    uint32_t mismatch = 0;
    uint32_t checks = 0;

    expal_set_modes(1u, 1u);

    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xa1110000u + s * 0x00009e37u;

        ap_enable = 0u; g_keccak_prof_enable = 0u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk);
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);

        ap_enable = 1u; g_keccak_prof_enable = 1u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(expao_pk, expao_sk);
        xwing_enc(expao_ct, expao_ss_e, expao_pk);
        xwing_dec(expao_ss_d, expao_ct, expao_sk);
        ap_enable = 0u; g_keccak_prof_enable = 0u;

        mismatch += byte_mismatches(expao_pk, xw_pk, sizeof(expao_pk));
        mismatch += byte_mismatches(expao_sk, xw_sk, sizeof(expao_sk));
        mismatch += byte_mismatches(expao_ct, xw_ct, sizeof(expao_ct));
        mismatch += byte_mismatches(expao_ss_e, xw_ss_e, sizeof(expao_ss_e));
        mismatch += byte_mismatches(expao_ss_d, xw_ss_d, sizeof(expao_ss_d));
        checks += 5u;
    }

    expaq_byte_mismatch = mismatch;
    expaq_checks = checks;
}

static void bench_expaq_reps(void)
{
    const uint32_t b = EXPAQ_SLOT_BASE;
    uint32_t r, i;

    expal_set_modes(1u, 1u);
    for (i = 0; i < 3u * 5u; i++) { rep_cyc[b + i][0] = 0u; rep_cyc[b + i][1] = 0u; }

    ap_enable = 0u; g_keccak_prof_enable = 0u;
    PQCLEAN_randombytes_reset(0xa1ab5a5au);
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_keypair(xw_pk, xw_sk);
        rep_cyc[b + 0u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[b + 5u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[b + 10u][r] = dwt_span_end();
    }

    ap_enable = 1u; g_keccak_prof_enable = 1u;
    PQCLEAN_randombytes_reset(0xa1ab5a5au);
    for (r = 0; r < REP_N; r++) {
        expap_reset();
        dwt_span_begin();
        xwing_keypair(xw_pk, xw_sk);
        rep_cyc[b + 1u][r] = dwt_span_end();
        expaq_store(b + 2u);
    }
    for (r = 0; r < REP_N; r++) {
        expap_reset();
        dwt_span_begin();
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[b + 6u][r] = dwt_span_end();
        expaq_store(b + 7u);
    }
    for (r = 0; r < REP_N; r++) {
        expap_reset();
        dwt_span_begin();
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[b + 11u][r] = dwt_span_end();
        expaq_store(b + 12u);
    }

    ap_enable = 0u; g_keccak_prof_enable = 0u;
}

static void expaq_run_all(void)
{
    expaj_stack_prepare();
    run_on_stack(expaq_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAQ equiv: bytes-mm="); uart_put_u32(expaq_byte_mismatch);
    uart_puts(" checks="); uart_put_u32(expaq_checks);
    uart_puts("\n");
    harness_fails += expaq_byte_mismatch;

    run_on_stack(bench_expaq_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_stack_check();
    uart_puts("expAQ bench: stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_stack_canary_fails;

    expal_set_modes(0, 0);
}
