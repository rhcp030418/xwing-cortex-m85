/* ex1 하네스: C로 계산한 정답과 어셈블리 결과를 비교 */
#include <stdint.h>
#include "uart.h"

extern uint32_t asm_sum(const uint32_t *arr, uint32_t n);

#define N 100
static uint32_t arr[N];

int main(void)
{
    uart_init();
    uart_puts("=== ex1: array sum ===\n");

    for (uint32_t i = 0; i < N; i++) arr[i] = i + 1;   /* 1..100 */

    uint32_t ref = 0;
    for (uint32_t i = 0; i < N; i++) ref += arr[i];    /* C 정답: 5050 */

    uint32_t got = asm_sum(arr, N);

    uart_puts("C   ref = "); uart_put_u32(ref); uart_puts("\n");
    uart_puts("asm got = "); uart_put_u32(got); uart_puts("\n");

    if (got == ref && ref == 5050u) {
        uart_puts("EX1 PASS\n");
        qemu_exit(0);
    } else {
        uart_puts("EX1 FAIL\n");
        qemu_exit(1);
    }
}
