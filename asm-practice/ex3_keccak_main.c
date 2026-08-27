/* ex3: Keccak KAT — 스트림 B 재료 검증
 *
 * pqm4의 M4 최적화 스칼라 Keccak-f1600 어셈블리(keccak/keccakf1600.S)를
 * mupq의 스펀지 래퍼(keccak/fips202.c)로 감싸 SHA3-256 표준 벡터와 대조.
 * 이 순열이 2단계에서 X25519와 교차 배치할 스트림 B 후보다.
 *
 * 기대값 출처: python hashlib.sha3_256 (2026-08-10 생성)
 */
#include <stdint.h>
#include <string.h>
#include "uart.h"
#include "keccak/fips202.h"

static const uint8_t d_empty[32] = {
    0xa7, 0xff, 0xc6, 0xf8, 0xbf, 0x1e, 0xd7, 0x66,
    0x51, 0xc1, 0x47, 0x56, 0xa0, 0x61, 0xd6, 0x62,
    0xf5, 0x80, 0xff, 0x4d, 0xe4, 0x3b, 0x49, 0xfa,
    0x82, 0xd8, 0x0a, 0x4b, 0x80, 0xf8, 0x43, 0x4a,
};
static const uint8_t d_abc[32] = {
    0x3a, 0x98, 0x5d, 0xa7, 0x4f, 0xe2, 0x25, 0xb2,
    0x04, 0x5c, 0x17, 0x2d, 0x6b, 0xd3, 0x90, 0xbd,
    0x85, 0x5f, 0x08, 0x6e, 0x3e, 0x9d, 0x52, 0x5b,
    0x46, 0xbf, 0xe2, 0x45, 0x11, 0x43, 0x15, 0x32,
};

static int check(const char *name, const uint8_t got[32], const uint8_t want[32])
{
    uart_puts(name);
    if (memcmp(got, want, 32) == 0) { uart_puts(": OK\n"); return 0; }
    uart_puts(": FAIL\n  got  ");
    uart_put_hex_bytes(got, 32);
    uart_puts("\n");
    return 1;
}

int main(void)
{
    uint8_t h[32];
    int fails = 0;

    uart_init();
    uart_puts("=== ex3: SHA3-256 KAT via asm Keccak-f1600 ===\n");

    sha3_256(h, (const uint8_t *)"", 0);
    fails += check("sha3_256(\"\")   ", h, d_empty);

    sha3_256(h, (const uint8_t *)"abc", 3);
    fails += check("sha3_256(\"abc\")", h, d_abc);

    uart_puts(fails ? "EX3 FAIL\n" : "EX3 PASS -- stream B verified\n");
    qemu_exit(fails);
}
