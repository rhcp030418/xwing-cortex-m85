/* Experiment AS: X25519 ladder 나머지의 내부 세분.  Slots 447..458.
 *
 * 목적: expAR 이 X25519 를 mul 41.4% / sqr 35.6% / **나머지 23.0%** 로 쪼갰다.
 * 그 나머지(82~92 kcyc/scalarmult = X-Wing 의 10~15%)가 matacc 보다 큰데 내용이
 * 미측정이었다. 가설: 대부분이 field add/sub 다.
 *
 * 방법: expAR 과 같은 방식으로 `fe25519_add`/`fe25519_sub` 정의를 `apx_real_*` 로
 * rename 하고 원래 이름의 asm wrapper 를 둔다.
 *   fe25519_add/sub : in *r8=a, *r9=b ; out r0-r7 ; clobbers all other
 * 따라서 wrapper 는 r10/r11/r12 만 쓰고 **r8/r9(입력)와 r0-r7(출력)을 건드리지 않는다**.
 *
 * `fe25519_sqr_many` 는 "결과를 스택 top 에도 남긴다"는 계약이라 감싸면 caller 의
 * 스택 기대가 깨진다 — 제외한다. `loadm` 은 22 cyc x 2 회라 무시한다.
 *
 * 슬롯 배치 (연산당 4)
 *   +0 total (prof off)  +1 total (prof on)
 *   +2 add ([0]=cyc,[1]=cnt)   +3 sub ([0]=cyc,[1]=cnt)
 *   keygen 447.. / encaps 451.. / decaps 455..
 */

#define EXPAS_SLOT_BASE 447u

volatile uint32_t apx_cyc_add;
volatile uint32_t apx_cnt_add;
volatile uint32_t apx_cyc_sub;
volatile uint32_t apx_cnt_sub;

volatile uint32_t expas_byte_mismatch = 9;
volatile uint32_t expas_checks = 0;

static void expas_reset(void)
{
    apx_cyc_add = 0u; apx_cnt_add = 0u;
    apx_cyc_sub = 0u; apx_cnt_sub = 0u;
    apx_cyc_mul = 0u; apx_cnt_mul = 0u;
    apx_cyc_sqr = 0u; apx_cnt_sqr = 0u;
}

static void expas_store(uint32_t slot)
{
    rep_cyc[slot + 0u][0] += apx_cyc_add;
    rep_cyc[slot + 0u][1] += apx_cnt_add;
    rep_cyc[slot + 1u][0] += apx_cyc_sub;
    rep_cyc[slot + 1u][1] += apx_cnt_sub;
}

static void expas_equivalence(void)
{
    uint32_t mismatch = 0;
    uint32_t checks = 0;

    expal_set_modes(1u, 1u);

    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xa1110000u + s * 0x00009e37u;

        apx_enable = 0u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk);
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);

        apx_enable = 1u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(expao_pk, expao_sk);
        xwing_enc(expao_ct, expao_ss_e, expao_pk);
        xwing_dec(expao_ss_d, expao_ct, expao_sk);
        apx_enable = 0u;

        mismatch += byte_mismatches(expao_pk, xw_pk, sizeof(expao_pk));
        mismatch += byte_mismatches(expao_sk, xw_sk, sizeof(expao_sk));
        mismatch += byte_mismatches(expao_ct, xw_ct, sizeof(expao_ct));
        mismatch += byte_mismatches(expao_ss_e, xw_ss_e, sizeof(expao_ss_e));
        mismatch += byte_mismatches(expao_ss_d, xw_ss_d, sizeof(expao_ss_d));
        checks += 5u;
    }

    expas_byte_mismatch = mismatch;
    expas_checks = checks;
}

static void bench_expas_reps(void)
{
    const uint32_t b = EXPAS_SLOT_BASE;
    uint32_t r, i;

    expal_set_modes(1u, 1u);
    for (i = 0; i < 3u * 4u; i++) { rep_cyc[b + i][0] = 0u; rep_cyc[b + i][1] = 0u; }

    apx_enable = 0u;
    PQCLEAN_randombytes_reset(0xa1ab5a5au);
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_keypair(xw_pk, xw_sk);
        rep_cyc[b + 0u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[b + 4u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin();
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[b + 8u][r] = dwt_span_end();
    }

    apx_enable = 1u;
    PQCLEAN_randombytes_reset(0xa1ab5a5au);
    for (r = 0; r < REP_N; r++) {
        expas_reset();
        dwt_span_begin();
        xwing_keypair(xw_pk, xw_sk);
        rep_cyc[b + 1u][r] = dwt_span_end();
        expas_store(b + 2u);
    }
    for (r = 0; r < REP_N; r++) {
        expas_reset();
        dwt_span_begin();
        xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[b + 5u][r] = dwt_span_end();
        expas_store(b + 6u);
    }
    for (r = 0; r < REP_N; r++) {
        expas_reset();
        dwt_span_begin();
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[b + 9u][r] = dwt_span_end();
        expas_store(b + 10u);
    }

    apx_enable = 0u;
}

static void expas_run_all(void)
{
    expaj_stack_prepare();
    run_on_stack(expas_equivalence, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expAS equiv: bytes-mm="); uart_put_u32(expas_byte_mismatch);
    uart_puts(" checks="); uart_put_u32(expas_checks);
    uart_puts("\n");
    harness_fails += expas_byte_mismatch;

    run_on_stack(bench_expas_reps, dtcm_stack + sizeof(dtcm_stack));
    expaj_stack_check();
    uart_puts("expAS bench: stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_stack_canary_fails;

    expal_set_modes(0, 0);
}
