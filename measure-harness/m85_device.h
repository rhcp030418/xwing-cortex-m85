/* EK-RA8M1(Cortex-M85)용 최소 디바이스 헤더 — CMSIS core_cm85.h를 띄우는 데 필요한 것만.
 * 실보드 FSP 프로젝트에서는 FSP의 디바이스 헤더(bsp)가 이 파일을 대체한다.
 * 여기 값들은 측정 하네스가 쓰는 DWT/PMU 레지스터 정의에만 영향. */
#ifndef M85_DEVICE_H
#define M85_DEVICE_H

typedef enum IRQn
{
    Reset_IRQn            = -15,
    NonMaskableInt_IRQn   = -14,
    HardFault_IRQn        = -13,
    MemoryManagement_IRQn = -12,
    BusFault_IRQn         = -11,
    UsageFault_IRQn       = -10,
    SecureFault_IRQn      = -9,
    SVCall_IRQn           = -5,
    DebugMonitor_IRQn     = -4,
    PendSV_IRQn           = -2,
    SysTick_IRQn          = -1,
    Device_IRQ0_IRQn      = 0
} IRQn_Type;

#define __CM85_REV             0x0001U
#define __NVIC_PRIO_BITS       4U
#define __FPU_PRESENT          1U
#define __FPU_DP               1U
#define __DSP_PRESENT          1U
#define __MVE_PRESENT          1U
#define __MVE_FP               1U
#define __MPU_PRESENT          1U
#define __ICACHE_PRESENT       1U
#define __DCACHE_PRESENT       1U
#define __PMU_PRESENT          1U
#define __PMU_NUM_EVENTCNT     8U      /* M85: 이벤트 카운터 8개 + CCNTR */
#define __SAUREGION_PRESENT    0U
#define __PACBTI_PRESENT       0U
#define __VTOR_PRESENT         1U
#define __Vendor_SysTickConfig 0U

#include "core_cm85.h"

#endif /* M85_DEVICE_H */
