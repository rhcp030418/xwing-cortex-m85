/* 실험 CS: 융합 조각 phase-0 을 솔버로 재스케줄한 U_s 대 지퍼 U 대 순차 F.
 * 사전등록: 2026-08-28_expCS_solver_phase0_prereg.md
 *   862 F  863 U  864 Ut  865 Us  866 Us  867 Ut  868 U  869 F
 *   Ut = 같은 안전변환을 거쳤으나 명령 순서는 원본(변환 세금 대조군)
 * 정확성은 bench_expaf_path_reps 가 매 반복마다 검사한다(Keccak 상태 + X25519 출력).
 */
#define EXPCS_SLOT_BASE 862u

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
    uart_puts("expCS mismatch="); uart_put_u32(expaf_mismatch);
    uart_puts("\n");
    harness_fails += expaf_mismatch;
}
