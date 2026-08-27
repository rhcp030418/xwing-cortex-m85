/* CMSDK UART0 (mps2-an386) — 주소는 pqm4의 CMSDK_CM4.h에서 가져옴
 * -DSEMIHOST 빌드: UART MMIO 대신 세미호스팅 콘솔 사용.
 *   mps3-an547(M55) 등 UART 주소가 다른 머신에서 주소 수정 없이 돌리기 위함.
 *   QEMU를 -semihosting으로 띄워야 출력이 보인다. */
#include "uart.h"

#ifdef SEMIHOST

void uart_init(void) { }

void uart_putc(char c)
{
    register uint32_t r0 __asm__("r0") = 0x03;   /* SYS_WRITEC */
    register void    *r1 __asm__("r1") = &c;
    __asm__ volatile ("bkpt 0xAB" : "+r"(r0) : "r"(r1) : "memory");
}

#else

#define UART0_DATA  (*(volatile uint32_t *)0x40004000u)
#define UART0_STATE (*(volatile uint32_t *)0x40004004u)
#define UART0_CTRL  (*(volatile uint32_t *)0x40004008u)

void uart_init(void)
{
    UART0_CTRL = 1u;                    /* TX enable */
}

void uart_putc(char c)
{
    while (UART0_STATE & 1u) { }        /* TX 버퍼가 빌 때까지 대기 */
    UART0_DATA = (uint32_t)c & 0xFFu;
}

#endif /* SEMIHOST */

void uart_puts(const char *s)
{
    while (*s) {
        if (*s == '\n') uart_putc('\r');
        uart_putc(*s++);
    }
}

void uart_put_u32(uint32_t v)
{
    char buf[11];
    int i = 10;
    buf[i] = '\0';
    do { buf[--i] = '0' + (v % 10u); v /= 10u; } while (v);
    uart_puts(&buf[i]);
}

void uart_put_hex_bytes(const uint8_t *p, unsigned n)
{
    static const char hex[] = "0123456789abcdef";
    for (unsigned i = 0; i < n; i++) {
        uart_putc(hex[p[i] >> 4]);
        uart_putc(hex[p[i] & 0xF]);
    }
}

/* semihosting SYS_EXIT: QEMU를 -semihosting으로 띄우면 이 호출로 깔끔히 종료된다 */
void qemu_exit(int code)
{
    register uint32_t r0 __asm__("r0") = 0x18;            /* SYS_EXIT */
    register uint32_t r1 __asm__("r1") =
        (code == 0) ? 0x20026u : 0u;                      /* ADP_Stopped_ApplicationExit */
    __asm__ volatile ("bkpt 0xAB" :: "r"(r0), "r"(r1) : "memory");
    for (;;) { }
}
