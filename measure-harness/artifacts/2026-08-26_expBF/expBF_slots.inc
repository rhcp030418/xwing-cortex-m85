/* Experiment BF (K22): matrix-XOF absorb 캐시.  Slots 570..583.
 * 사전등록: 2026-08-26_expBF_k22_absorb_prereg.md
 *   570 absorb 단가 A(원본)  571 B(캐시)  572 B  573 A   (ABBA, BATCH)
 *   574..576 A full  577..579 B full  580..582 B full  583..585 A full  -> 12칸
 */
#include "mlkem/symmetric.h"

#define EXPBF_SLOT_BASE 570u
#define EXPBF_BATCH 64u

extern volatile uint32_t mlkem_k22_mode;
extern void kyber_shake128_absorb(xof_state *s, const uint8_t seed[32], uint8_t x, uint8_t y);

volatile uint32_t expbf_state_mm = 9;
volatile uint32_t expbf_checks = 0;
volatile uint32_t expbf_xw_mm = 9;
volatile uint32_t expbf_xw_smoke = 9;
volatile uint32_t expbf_xw_reject = 9;

static xof_state expbf_s0 __attribute__((section(".dtcm")));
static xof_state expbf_s1 __attribute__((section(".dtcm")));
static uint8_t expbf_seed[32] __attribute__((section(".dtcm")));

static uint32_t expbf_rng = 0xbf5eedu;
static uint32_t expbf_next(void)
{
    expbf_rng ^= expbf_rng << 13; expbf_rng ^= expbf_rng >> 17;
    expbf_rng ^= expbf_rng << 5;  return expbf_rng;
}

static void expbf_correctness(void)
{
    uint32_t mm = 0, checks = 0, t, i;
    /* seed 를 바꿔가며(캐시 무효화 경로) x,y 전 조합 일부를 비교 */
    expbf_rng = 0xbf5eedu;
    for (t = 0; t < 200u; t++) {
        for (i = 0; i < 32u; i++) expbf_seed[i] = (uint8_t) expbf_next();
        for (i = 0; i < 16u; i++) {
            const uint8_t x = (uint8_t) (i * 17u);
            const uint8_t y = (uint8_t) (i * 31u + 5u);
            mlkem_k22_mode = 0u;
            kyber_shake128_absorb(&expbf_s0, expbf_seed, x, y);
            mlkem_k22_mode = 1u;
            kyber_shake128_absorb(&expbf_s1, expbf_seed, x, y);
            mm += byte_mismatches((const uint8_t *) &expbf_s0,
                                  (const uint8_t *) &expbf_s1, sizeof(xof_state));
            checks++;
        }
    }
    /* x=0,y=0 경계 */
    mlkem_k22_mode = 0u; kyber_shake128_absorb(&expbf_s0, expbf_seed, 0u, 0u);
    mlkem_k22_mode = 1u; kyber_shake128_absorb(&expbf_s1, expbf_seed, 0u, 0u);
    mm += byte_mismatches((const uint8_t *) &expbf_s0, (const uint8_t *) &expbf_s1,
                          sizeof(xof_state));
    checks++;
    mlkem_k22_mode = 0u;
    expbf_state_mm = mm;
    expbf_checks = checks;
}

static void expbf_xwing_equiv(void)
{
    uint32_t mm = 0, fails = 0, rej = 0;
    expal_set_modes(1u, 1u);
    mlkem_x06_mode = 1u;
    for (uint32_t s = 0; s < 8u; s++) {
        const uint32_t seed = 0xa1110000u + s * 0x00009e37u;
        mlkem_k22_mode = 0u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk); xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) != 0);
        memcpy(xw_ref_pk, xw_pk, sizeof(xw_ref_pk));
        memcpy(xw_ref_sk, xw_sk, sizeof(xw_ref_sk));
        memcpy(xw_ref_ct, xw_ct, sizeof(xw_ref_ct));
        memcpy(xw_ref_ss_e, xw_ss_e, sizeof(xw_ref_ss_e));
        memcpy(xw_ref_ss_d, xw_ss_d, sizeof(xw_ref_ss_d));
        xw_ct[0] ^= 0x5au; xwing_dec(xw_ref_reject, xw_ct, xw_sk); xw_ct[0] ^= 0x5au;

        mlkem_k22_mode = 1u;
        PQCLEAN_randombytes_reset(seed);
        xwing_keypair(xw_pk, xw_sk); xwing_enc(xw_ct, xw_ss_e, xw_pk);
        xwing_dec(xw_ss_d, xw_ct, xw_sk);
        fails += (memcmp(xw_ss_e, xw_ss_d, 32) != 0);
        mm += byte_mismatches(xw_pk, xw_ref_pk, sizeof(xw_ref_pk));
        mm += byte_mismatches(xw_sk, xw_ref_sk, sizeof(xw_ref_sk));
        mm += byte_mismatches(xw_ct, xw_ref_ct, sizeof(xw_ref_ct));
        mm += byte_mismatches(xw_ss_e, xw_ref_ss_e, sizeof(xw_ref_ss_e));
        mm += byte_mismatches(xw_ss_d, xw_ref_ss_d, sizeof(xw_ref_ss_d));
        xw_ct[0] ^= 0x5au; xwing_dec(xw_ss_d, xw_ct, xw_sk); xw_ct[0] ^= 0x5au;
        rej += byte_mismatches(xw_ss_d, xw_ref_reject, sizeof(xw_ref_reject));
        mlkem_k22_mode = 0u;
    }
    mlkem_x06_mode = 0u;
    expbf_xw_mm = mm; expbf_xw_smoke = fails; expbf_xw_reject = rej;
}

static volatile uint32_t expbf_mode;
static volatile uint32_t expbf_slot;

static void expbf_micro_run(void)
{
    const uint32_t slot = expbf_slot;
    mlkem_k22_mode = expbf_mode;
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPBF_BATCH; i++)
            kyber_shake128_absorb(&expbf_s0, expbf_seed, (uint8_t) i, (uint8_t) (i + 1u));
        rep_cyc[slot][r] = dwt_span_end();
    }
    mlkem_k22_mode = 0u;
}

static void expbf_full_run(void)
{
    const uint32_t slot = expbf_slot;
    uint32_t r;
    expal_set_modes(1u, 1u);
    mlkem_x06_mode = 1u;
    mlkem_k22_mode = expbf_mode;
    PQCLEAN_randombytes_reset(0xa1ab5a5au);
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin(); xwing_keypair(xw_pk, xw_sk);
        rep_cyc[slot][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin(); xwing_enc(xw_ct, xw_ss_e, xw_pk);
        rep_cyc[slot + 1u][r] = dwt_span_end();
    }
    for (r = 0; r < REP_N; r++) {
        dwt_span_begin(); xwing_dec(xw_ss_d, xw_ct, xw_sk);
        rep_cyc[slot + 2u][r] = dwt_span_end();
    }
    mlkem_k22_mode = 0u; mlkem_x06_mode = 0u;
}

/* ---- BF 진단 (slots 586..589): absorb 원가 분해 ---------------------------
 * 586 zero200   : state->ctx[0..24] = 0        (A 경로의 영점화)
 * 587 xor34     : StateXORBytes(ctx, buf, 0, 34)  (A 경로의 본체 XOR)
 * 588 memcpy200 : memcpy(state, cache, 200)    (B 경로의 복사)
 * 589 xor2      : StateXORBytes(ctx, xy, 32, 2)   (B 경로의 XOR)
 */
extern void KeccakF1600_StateXORBytes(uint64_t *s, const uint8_t *d, unsigned o, unsigned n);
static xof_state expbf_diag_cache;
static uint8_t   expbf_diag_buf[34];
static volatile uint32_t expbf_diag_kind;

static void expbf_diag_run(void)
{
    const uint32_t slot = expbf_slot;
    const uint32_t kind = expbf_diag_kind;
    uint8_t xy[2]; xy[0] = 1u; xy[1] = 2u;
    for (uint32_t r = 0; r < REP_N; r++) {
        dwt_span_begin();
        for (uint32_t i = 0; i < EXPBF_BATCH; i++) {
            switch (kind) {
            case 0u: { int k; for (k = 0; k < 25; k++) expbf_s0.ctx[k] = 0; } break;
            case 1u: KeccakF1600_StateXORBytes(expbf_s0.ctx, expbf_diag_buf, 0u, 34u); break;
            case 2u: memcpy(&expbf_s0, &expbf_diag_cache, sizeof(expbf_diag_cache)); break;
            default: KeccakF1600_StateXORBytes(expbf_s0.ctx, xy, 32u, 2u); break;
            }
        }
        rep_cyc[slot][r] = dwt_span_end();
    }
}

static void expbf_run_all(void)
{
    static const uint8_t ord[4] = {0, 1, 1, 0};
    uint32_t i;

    expaj_stack_prepare();
    run_on_stack(expbf_correctness, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expBF state-mm="); uart_put_u32(expbf_state_mm);
    uart_puts(" checks="); uart_put_u32(expbf_checks);
    uart_puts("\n");
    harness_fails += expbf_state_mm;

    run_on_stack(expbf_xwing_equiv, dtcm_stack + sizeof(dtcm_stack));
    uart_puts("expBF xw: bytes-mm="); uart_put_u32(expbf_xw_mm);
    uart_puts(" smoke="); uart_put_u32(expbf_xw_smoke);
    uart_puts(" reject-mm="); uart_put_u32(expbf_xw_reject);
    uart_puts("\n");
    harness_fails += expbf_xw_mm + expbf_xw_smoke + expbf_xw_reject;

    for (i = 0; i < 32u; i++) expbf_seed[i] = (uint8_t) (0x30u + i);
    for (i = 0; i < 4u; i++) {
        expbf_mode = ord[i]; expbf_slot = EXPBF_SLOT_BASE + i;
        run_on_stack(expbf_micro_run, dtcm_stack + sizeof(dtcm_stack));
    }
    for (i = 0; i < 4u; i++) {
        expbf_diag_kind = i; expbf_slot = 586u + i;
        run_on_stack(expbf_diag_run, dtcm_stack + sizeof(dtcm_stack));
    }
    for (i = 0; i < 4u; i++) {
        expbf_mode = ord[i]; expbf_slot = EXPBF_SLOT_BASE + 4u + 3u * i;
        run_on_stack(expbf_full_run, dtcm_stack + sizeof(dtcm_stack));
    }
    expaj_stack_check();
    uart_puts("expBF bench: stack-fails="); uart_put_u32(expaj_stack_canary_fails);
    uart_puts("\n");
    harness_fails += expaj_stack_canary_fails;
    expal_set_modes(0, 0);
}
