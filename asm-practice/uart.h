#ifndef UART_H
#define UART_H
#include <stdint.h>

void uart_init(void);
void uart_putc(char c);
void uart_puts(const char *s);
void uart_put_u32(uint32_t v);              /* 10진수 */
void uart_put_hex_bytes(const uint8_t *p, unsigned n);
void qemu_exit(int code);                   /* QEMU 종료 (semihosting) */

#endif
