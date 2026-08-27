#include <stdint.h>
#include "uart.h"
void expAM_b_test(void);
static void enable_mve(void){ volatile uint32_t*c=(volatile uint32_t*)0xE000ED88u; *c|=(0xFu<<20);
    __asm__ volatile("dsb":::"memory"); __asm__ volatile("isb":::"memory"); }
int main(void){ uart_init(); enable_mve(); expAM_b_test();
    uart_puts("EXPAMB QEMU DONE\n"); qemu_exit(0); return 0; }
