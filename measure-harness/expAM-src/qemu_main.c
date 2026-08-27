/* expAM1 QEMU 기능검증 진입점 (mps3-an547, Cortex-M55).
 * 사이클 값은 측정하지도 출력하지도 않는다 — 기능 전용. */
#include <stdint.h>
#include "uart.h"

void expAM_mul_test(void);

/* 공유 startup.s(asm-practice)는 CPACR 를 건드리지 않는다. MVE 명령은 CP10/CP11 이
 * 꺼져 있으면 UsageFault 로 트랩되어 Default_Handler 무한루프에 빠진다.
 * 공유 파일을 고치지 않고 여기서만 켠다. 보드(FSP) 경로는 BSP 가 이미 켠다. */
static void enable_mve(void)
{
    volatile uint32_t *cpacr = (volatile uint32_t *) 0xE000ED88u;
    *cpacr |= (0xFu << 20);                 /* CP10, CP11 = full access */
    __asm__ volatile ("dsb" ::: "memory");
    __asm__ volatile ("isb" ::: "memory");
}

int main(void)
{
    uart_init();
    enable_mve();
    uart_puts("expAM: MVE enabled (CPACR)\n");
    expAM_mul_test();
    uart_puts("EXPAM QEMU DONE\n");
    qemu_exit(0);
    return 0;
}
