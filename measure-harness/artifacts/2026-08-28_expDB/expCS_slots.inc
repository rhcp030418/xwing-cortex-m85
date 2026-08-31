/* 실험 DB: 융합 조각 네 phase를 솔버로 재스케줄한 U_s 대 지퍼 U 대 순차 F.
 * 사전등록: 2026-08-28_expDB_full_solver_prereg.md
 *   862 F  863 U  864 Ut  865 Us  866 Us  867 Ut  868 U  869 F
 *   Ut = 같은 안전변환을 거쳤으나 명령 순서는 원본(변환 세금 대조군)
 * 정확성은 bench_expaf_path_reps 가 매 반복마다 검사한다(Keccak 상태 + X25519 출력).
 */
#define EXPCS_SLOT_BASE 862u

static uint32_t expdb_vec_scratch[512] __attribute__((aligned(16)));
static uint32_t expdb_vec_ref[512] __attribute__((aligned(16)));
static uint32_t expdb_qsave[16] __attribute__((aligned(16)));
static uint32_t expdb_qinit[32] __attribute__((aligned(16)));
static uint32_t expdb_qref[32] __attribute__((aligned(16)));
static uint32_t expdb_qgot[32] __attribute__((aligned(16)));
static uint32_t expdb_a[10];
static uint32_t expdb_b[10];
static uint32_t expdb_ref[10];
static uint32_t expdb_got[10];
static uint32_t expdb_wa[10];
static uint32_t expdb_wb[10];

static void __attribute__((target("general-regs-only"))) expdb_mul_diagnostic(void)
{
    static fiat_mul_fn const orig[4] = {
        fiat_mul_u4_p0, fiat_mul_u4_p1, fiat_mul_u4_p2, fiat_mul_u4_p3
    };
    static fiat_mul_fn const transformed[4] = {
        fiat_mul_u4t_p0, fiat_mul_u4t_p1, fiat_mul_u4t_p2, fiat_mul_u4t_p3
    };
    static fiat_mul_fn const solved[4] = {
        fiat_mul_u4a_p0, fiat_mul_u4a_p1, fiat_mul_u4a_p2, fiat_mul_u4a_p3
    };
    fiat_mul_fn const *variants[2] = { transformed, solved };
    uint32_t *saved_block = g_u_mve_block;
    uint32_t mm[2][4] = {{0u}};
    uint32_t vec_mm[2][4] = {{0u}};
    uint32_t alias_mm[2][4] = {{0u}};
    uint32_t seed = 0xdb5a17c3u;

    fiat_u_qsave(expdb_qsave);
    g_u_mve_block = expdb_vec_scratch;
    for (uint32_t trial = 0; trial < 16u; trial++) {
        for (uint32_t i = 0; i < 10u; i++) {
            seed ^= seed << 13; seed ^= seed >> 17; seed ^= seed << 5;
            expdb_a[i] = seed & ((i & 1u) ? 0x01ffffffu : 0x03ffffffu);
            seed ^= seed << 13; seed ^= seed >> 17; seed ^= seed << 5;
            expdb_b[i] = seed & ((i & 1u) ? 0x01ffffffu : 0x03ffffffu);
        }
        for (uint32_t phase = 0; phase < 4u; phase++) {
            for (uint32_t i = 0; i < 32u; i++)
                expdb_qinit[i] = 0x6a09e667u ^ (trial * 0x10001u) ^ (phase * 0x101u) ^ i;
            for (uint32_t i = 0; i < 512u; i++)
                expdb_vec_scratch[i] = 0xbb67ae85u ^ (trial * 0x100001u) ^ (phase * 0x1001u) ^ i;
            expdb_qall_restore(expdb_qinit);
            orig[phase](expdb_ref, expdb_a, expdb_b);
            expdb_qall_save(expdb_qref);
            for (uint32_t i = 0; i < 512u; i++) expdb_vec_ref[i] = expdb_vec_scratch[i];
            for (uint32_t kind = 0; kind < 2u; kind++) {
                for (uint32_t i = 0; i < 512u; i++)
                    expdb_vec_scratch[i] = 0xbb67ae85u ^ (trial * 0x100001u) ^ (phase * 0x1001u) ^ i;
                expdb_qall_restore(expdb_qinit);
                variants[kind][phase](expdb_got, expdb_a, expdb_b);
                expdb_qall_save(expdb_qgot);
                for (uint32_t i = 0; i < 10u; i++)
                    mm[kind][phase] += (expdb_got[i] != expdb_ref[i]);
                for (uint32_t i = 0; i < 32u; i++)
                    vec_mm[kind][phase] += (expdb_qgot[i] != expdb_qref[i]);
                for (uint32_t i = 0; i < 512u; i++)
                    vec_mm[kind][phase] += (expdb_vec_scratch[i] != expdb_vec_ref[i]);
                for (uint32_t alias = 0; alias < 2u; alias++) {
                    for (uint32_t i = 0; i < 10u; i++) {
                        expdb_wa[i] = expdb_a[i]; expdb_wb[i] = expdb_b[i];
                    }
                    expdb_qall_restore(expdb_qinit);
                    orig[phase](alias == 0u ? expdb_wa : expdb_wb,
                                expdb_wa, expdb_wb);
                    for (uint32_t i = 0; i < 10u; i++)
                        expdb_ref[i] = (alias == 0u ? expdb_wa[i] : expdb_wb[i]);
                    for (uint32_t i = 0; i < 10u; i++) {
                        expdb_wa[i] = expdb_a[i]; expdb_wb[i] = expdb_b[i];
                    }
                    expdb_qall_restore(expdb_qinit);
                    variants[kind][phase](alias == 0u ? expdb_wa : expdb_wb,
                                          expdb_wa, expdb_wb);
                    for (uint32_t i = 0; i < 10u; i++)
                        alias_mm[kind][phase] +=
                            ((alias == 0u ? expdb_wa[i] : expdb_wb[i]) != expdb_ref[i]);
                }
            }
        }
    }
    g_u_mve_block = saved_block;
    fiat_u_qrestore(expdb_qsave);
    uart_puts("expDB mul-mm t=");
    for (uint32_t i = 0; i < 4u; i++) { uart_put_u32(mm[0][i]); uart_putc(i == 3u ? ' ' : '/'); }
    uart_puts("s=");
    for (uint32_t i = 0; i < 4u; i++) { uart_put_u32(mm[1][i]); uart_putc(i == 3u ? '\n' : '/'); }
    uart_puts("expDB vec-mm t=");
    for (uint32_t i = 0; i < 4u; i++) { uart_put_u32(vec_mm[0][i]); uart_putc(i == 3u ? ' ' : '/'); }
    uart_puts("s=");
    for (uint32_t i = 0; i < 4u; i++) { uart_put_u32(vec_mm[1][i]); uart_putc(i == 3u ? '\n' : '/'); }
    uart_puts("expDB alias-mm t=");
    for (uint32_t i = 0; i < 4u; i++) { uart_put_u32(alias_mm[0][i]); uart_putc(i == 3u ? ' ' : '/'); }
    uart_puts("s=");
    for (uint32_t i = 0; i < 4u; i++) { uart_put_u32(alias_mm[1][i]); uart_putc(i == 3u ? '\n' : '/'); }
}

static void expcs_run_all(void)
{
    static const uint8_t ord[8] = {0u, 1u, 5u, 4u, 4u, 5u, 1u, 0u};
    uint32_t i;

    expaf_mismatch = 0;
    run_on_stack(expaf_prepare_refs, dtcm_stack + sizeof(dtcm_stack));
    for (i = 0; i < 8u; i++) {
        expaf_bench_mode = ord[i];
        expaf_bench_slot = EXPCS_SLOT_BASE + i;
        run_on_stack(bench_expaf_path_reps, dtcm_stack + sizeof(dtcm_stack));
    }
    uart_puts("expDB mismatch="); uart_put_u32(expaf_mismatch);
    uart_puts("\n");
    harness_fails += expaf_mismatch;
}
