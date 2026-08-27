/* 1단계 킬 게이트 측정 하네스 (골격) — DWT CYCCNT + PMU 스톨 분해
 *
 * 측정 대상: X25519 구간 / Keccak 구간 각각의
 *   사이클(DWT·PMU 교차검증), 명령 수, IPC, 유휴 슬롯(STALL_OP) 프런트/백엔드 분해
 * → "이득 상한 = 낭비 슬롯" 산수의 우변 (게이트_측정_계획서.md 참조)
 *
 * 주의:
 *  - QEMU(mps3-an547)는 DWT·PMU를 에뮬레이트하지 않아 카운터가 0으로 읽힌다.
 *    QEMU 실행은 구조(부팅→설정→호출→출력) 검증용. 실수치는 EK-RA8M1에서만.
 *  - M-profile PMU 이벤트 카운터는 16비트 → 짝수/홀수 카운터를 CHAIN(0x1E)으로
 *    묶어 32비트 4쌍으로 사용 (X25519 전체 스칼라곱은 수십만 명령이라 필수).
 *  - 보드 포팅: 이 파일을 FSP 프로젝트에 넣고 uart_*만 교체(RTT/SCI). FSP BSP가
 *    캐시·클록을 켠 뒤 main에 들어오므로 여기서는 카운터만 만진다. 코드·데이터의
 *    ITCM/DTCM 배치는 게이트_측정_계획서를 따를 것.
 */
#include <stdint.h>
#include "m85_device.h"
#include "uart.h"

#ifndef ARM_PMU_CHAIN
#define ARM_PMU_CHAIN 0x001EU
#endif

extern void KeccakF1600_StatePermute(uint64_t *state);
extern void curve25519_scalarmult(unsigned char result[32],
                                  const unsigned char scalar[32],
                                  const unsigned char point[32]);

/* ---- PMU: 체인 쌍 4개 = 32비트 논리 카운터 4개 ---- */
static const struct { uint32_t id; const char *name; } PAIR[4] = {
    { ARM_PMU_INST_RETIRED,      "insts        " },
    { ARM_PMU_STALL_OP,          "stall_op     " },   /* 빈 발행 슬롯 (핵심 지표) */
    { ARM_PMU_STALL_OP_FRONTEND, "stall_op_fe  " },
    { ARM_PMU_STALL_OP_BACKEND,  "stall_op_be  " },
};

static void pmu_setup(void)
{
#ifndef NO_PMU
    ARM_PMU_Enable();
    for (uint32_t p = 0; p < 4; p++) {
        ARM_PMU_Set_EVTYPER(2u * p,      PAIR[p].id);
        ARM_PMU_Set_EVTYPER(2u * p + 1u, ARM_PMU_CHAIN);
    }
#endif
}

static void dwt_setup(void)
{
    CoreDebug->DEMCR |= CoreDebug_DEMCR_TRCENA_Msk;
    DWT->CTRL |= DWT_CTRL_CYCCNTENA_Msk;
}

static void perf_start(void)
{
#ifndef NO_PMU
    ARM_PMU_CNTR_Disable(0xFFFFFFFFu);
    ARM_PMU_EVCNTR_ALL_Reset();
    ARM_PMU_CYCCNT_Reset();
#endif
    DWT->CYCCNT = 0;
    __DSB(); __ISB();
#ifndef NO_PMU
    ARM_PMU_CNTR_Enable((1UL << 31) | 0xFFu);   /* CCNTR + 이벤트 0~7 */
#endif
}

static uint32_t pair_read(uint32_t p)
{
#ifndef NO_PMU
    return (ARM_PMU_Get_EVCNTR(2u * p + 1u) << 16) | ARM_PMU_Get_EVCNTR(2u * p);
#else
    (void)p; return 0;
#endif
}

/* 측정 결과 한 구간 출력. reps로 나눈 per-op 값 + 파생 지표(IPC, 슬롯 낭비율) */
static void perf_stop_report(const char *label, uint32_t reps)
{
    uint32_t dwt_cyc;
    __DSB(); __ISB();
    dwt_cyc = DWT->CYCCNT;
#ifndef NO_PMU
    ARM_PMU_CNTR_Disable(0xFFFFFFFFu);
    uint32_t pmu_cyc = ARM_PMU_Get_CCNTR();
#else
    uint32_t pmu_cyc = 0;
#endif

    uart_puts("["); uart_puts(label); uart_puts("] x"); uart_put_u32(reps); uart_puts("\n");
    uart_puts("  dwt_cyc/op   : "); uart_put_u32(dwt_cyc / reps); uart_puts("\n");
    uart_puts("  pmu_cyc/op   : "); uart_put_u32(pmu_cyc / reps); uart_puts("\n");
    for (uint32_t p = 0; p < 4; p++) {
        uart_puts("  "); uart_puts(PAIR[p].name); uart_puts(": ");
        uart_put_u32(pair_read(p) / reps); uart_puts("\n");
    }
    if (pmu_cyc != 0) {
        uint64_t insts = pair_read(0), stall_op = pair_read(1);
        /* M85 듀얼이슈: 슬롯 총량 = 2*cyc. IPC·낭비율은 x100 정수 표기 */
        uart_puts("  IPC x100     : "); uart_put_u32((uint32_t)(insts * 100u / pmu_cyc)); uart_puts("\n");
        uart_puts("  slot-waste %  : "); uart_put_u32((uint32_t)(stall_op * 100u / (2ull * pmu_cyc))); uart_puts("\n");
    } else {
        uart_puts("  (카운터 0 -- QEMU면 정상: DWT/PMU 미에뮬. 실수치는 보드에서)\n");
    }
    uart_puts("\n");
}

int main(void)
{
    static uint64_t st[25];
    static unsigned char out[32];
    static const unsigned char scalar[32] = { 0xa5, 0x46, 0xe3, 0x6b, 0xf0, 0x52, 0x7c, 0x9d,
                                              0x3b, 0x16, 0x15, 0x4b, 0x82, 0x46, 0x5e, 0xdd,
                                              0x62, 0x14, 0x4c, 0x0a, 0xc1, 0xfc, 0x5a, 0x18,
                                              0x50, 0x6a, 0x22, 0x44, 0xba, 0x44, 0x9a, 0xc4 };
    static const unsigned char basepoint[32] = { 9 };

    uart_init();
    uart_puts("=== measure-harness: DWT+PMU 1단계 골격 ===\n\n");

    dwt_setup();
    pmu_setup();

    /* 캘리브레이션: 빈 구간의 시작/정지 오버헤드 (per-op 해석 시 차감용) */
    perf_start();
    perf_stop_report("calib-empty", 1);

    perf_start();
    for (uint32_t i = 0; i < 1000; i++) KeccakF1600_StatePermute(st);
    perf_stop_report("keccak-f1600", 1000);

    perf_start();
    for (uint32_t i = 0; i < 10; i++) curve25519_scalarmult(out, scalar, basepoint);
    perf_stop_report("x25519-scalarmult", 10);

    uart_puts("HARNESS DONE\n");
    qemu_exit(0);
}
