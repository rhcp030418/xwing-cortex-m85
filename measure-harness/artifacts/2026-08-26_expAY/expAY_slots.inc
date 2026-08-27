/* Experiment AY: X06 채택 뒤 field-op 분모 재측정.  Slots 514..537.
 *
 * X06 이 채택되면서 fixed-base 두 지점의 field op 구성이 완전히 바뀌었다.
 *   ladder 1회 : mul 1,287 / sqr 1,274 / add 765 / sub 1,020   (expAR·expAS 실측)
 *   comb   1회 : mul 602+11 / sqr 254 / add 344 / sub 258       (AT-1 계수)
 * 따라서 X01/X02(mul·sqr 재스케줄)와 X03/X05(add/sub)의 **분모가 달라졌다.**
 * expAR/expAS 의 probe 를 되살려 X06 off/on 두 경로를 같은 ELF 에서 나란히 잰다.
 *
 * probe 는 expAR/AS 와 동일하다(fe25519_* 정의를 apx_real_* 로 rename, 원래 이름의
 * asm wrapper 가 r10-r12 만 쓰며 비활성 시 tail-branch). comb 의 ge_madd_native 와
 * fe25519_sqr_chain 의 `bl` 도 같은 wrapper 를 탄다.
 *
 * 슬롯 배치 (X06 mode 당 12, mode 0 = 514.., mode 1 = 526..)
 *   +0..+2   total (prof off) keygen/encaps/decaps
 *   +3..+5   total (prof on)
 *   +6..+11  keygen mul,sqr / encaps mul,sqr / decaps mul,sqr   ([0]=cyc, [1]=cnt)
 * add/sub 는 별도 슬롯 없이 [1] 칸을 나눠 쓰지 않고, 아래 acc 배열로 로그에 출력한다.
 */

#define EXPAY_SLOT_BASE 514u

/* probe 전역 (expAR/AS 에서 쓰던 것과 같은 심볼) */
volatile uint32_t apx_enable;
volatile uint32_t apx_start;
volatile uint32_t apx_cyc_mul, apx_cnt_mul, apx_cyc_sqr, apx_cnt_sqr;
volatile uint32_t apx_cyc_add, apx_cnt_add, apx_cyc_sub, apx_cnt_sub;

/* 로그로 뽑는 add/sub 합계 (mode x op) */
volatile uint32_t expay_add_cyc[2][3];
volatile uint32_t expay_add_cnt[2][3];
volatile uint32_t expay_sub_cyc[2][3];
volatile uint32_t expay_sub_cnt[2][3];

static volatile uint32_t expay_mode;
static volatile uint32_t expay_slot;

static void expay_zero(void)
{
    apx_cyc_mul = 0u; apx_cnt_mul = 0u;
    apx_cyc_sqr = 0u; apx_cnt_sqr = 0u;
    apx_cyc_add = 0u; apx_cnt_add = 0u;
    apx_cyc_sub = 0u; apx_cnt_sub = 0u;
}

static void bench_expay_reps(void)
{
    const uint32_t b = expay_slot;
    const uint32_t m = expay_mode;
    uint32_t r, i;

    expal_set_modes(1u, 1u);
    mlkem_x06_mode = m;

    for (i = 0; i < 12u; i++) { rep_cyc[b + i][0] = 0u; rep_cyc[b + i][1] = 0u; }
    for (i = 0; i < 3u; i++) {
        expay_add_cyc[m][i] = 0u; expay_add_cnt[m][i] = 0u;
        expay_sub_cyc[m][i] = 0u; expay_sub_cnt[m][i] = 0u;
    }

    /* prof off */
    apx_enable = 0u;
    PQCLEAN_randombytes_reset(0xa1ab5a5au);
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin(); xwing_keypair(xw_pk, xw_sk);
        rep_cyc[b + 0u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin(); xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[b + 1u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin(); xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[b + 2u][r] = dwt_span_end();
    }

    /* prof on */
    apx_enable = 1u;
    PQCLEAN_randombytes_reset(0xa1ab5a5au);
    for (r = 0; r < REP_N; r++) {
        expay_zero();
        dwt_span_begin(); xwing_keypair(xw_pk, xw_sk);
        rep_cyc[b + 3u][r] = dwt_span_end();
        rep_cyc[b + 6u][0] += apx_cyc_mul; rep_cyc[b + 6u][1] += apx_cnt_mul;
        rep_cyc[b + 7u][0] += apx_cyc_sqr; rep_cyc[b + 7u][1] += apx_cnt_sqr;
        expay_add_cyc[m][0] += apx_cyc_add; expay_add_cnt[m][0] += apx_cnt_add;
        expay_sub_cyc[m][0] += apx_cyc_sub; expay_sub_cnt[m][0] += apx_cnt_sub;
    }
    for (r = 0; r < REP_N; r++) {
        expay_zero();
        dwt_span_begin(); xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[b + 4u][r] = dwt_span_end();
        rep_cyc[b + 8u][0] += apx_cyc_mul; rep_cyc[b + 8u][1] += apx_cnt_mul;
        rep_cyc[b + 9u][0] += apx_cyc_sqr; rep_cyc[b + 9u][1] += apx_cnt_sqr;
        expay_add_cyc[m][1] += apx_cyc_add; expay_add_cnt[m][1] += apx_cnt_add;
        expay_sub_cyc[m][1] += apx_cyc_sub; expay_sub_cnt[m][1] += apx_cnt_sub;
    }
    for (r = 0; r < REP_N; r++) {
        expay_zero();
        dwt_span_begin(); xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[b + 5u][r] = dwt_span_end();
        rep_cyc[b + 10u][0] += apx_cyc_mul; rep_cyc[b + 10u][1] += apx_cnt_mul;
        rep_cyc[b + 11u][0] += apx_cyc_sqr; rep_cyc[b + 11u][1] += apx_cnt_sqr;
        expay_add_cyc[m][2] += apx_cyc_add; expay_add_cnt[m][2] += apx_cnt_add;
        expay_sub_cyc[m][2] += apx_cyc_sub; expay_sub_cnt[m][2] += apx_cnt_sub;
    }

    apx_enable = 0u;
    mlkem_x06_mode = 0u;
}

static void expay_run_all(void)
{
    static const char *const opname[3] = {"keygen", "encaps", "decaps"};
    uint32_t m, i;

    expaj_stack_prepare();
    for (m = 0; m < 2u; m++) {
        expay_mode = m;
        expay_slot = EXPAY_SLOT_BASE + 12u * m;
        run_on_stack(bench_expay_reps, dtcm_stack + sizeof(dtcm_stack));
    }
    expaj_stack_check();

    for (m = 0; m < 2u; m++) {
        for (i = 0; i < 3u; i++) {
            uart_puts("expAY x06="); uart_put_u32(m);
            uart_puts(" "); uart_puts(opname[i]);
            uart_puts(" add-cyc="); uart_put_u32(expay_add_cyc[m][i] / REP_N);
            uart_puts(" add-cnt="); uart_put_u32(expay_add_cnt[m][i] / REP_N);
            uart_puts(" sub-cyc="); uart_put_u32(expay_sub_cyc[m][i] / REP_N);
            uart_puts(" sub-cnt="); uart_put_u32(expay_sub_cnt[m][i] / REP_N);
            uart_puts("\n");
        }
    }
    uart_puts("expAY bench: stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts(" stack-used="); uart_put_u32(expaj_stack_highwater);
    uart_puts("\n");
    harness_fails += expaj_stack_canary_fails;

    expal_set_modes(0, 0);
}
