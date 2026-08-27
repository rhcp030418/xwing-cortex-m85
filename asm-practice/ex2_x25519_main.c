/* ex2: X25519 KAT (Known-Answer Test)
 *
 * 스트림 A 재료 검증 — Lenngren의 Cortex-M4 X25519 어셈블리(2단계에서
 * 스티칭할 바로 그 코드)가 RFC 7748 §6.1 공식 테스트 벡터를 통과하는지 확인.
 *
 * 검증 내용:
 *   1) Alice 공개키 = X25519(alice_sk, 기저점 9) 가 RFC 값과 일치
 *   2) Bob 공개키도 일치
 *   3) 양쪽에서 계산한 공유 비밀이 서로 같고 RFC의 K와 일치
 */
#include <stdint.h>
#include <string.h>
#include "uart.h"

/* Lenngren 구현의 유일한 진입점 (x25519/x25519-cortex-m4.h) */
extern void curve25519_scalarmult(unsigned char result[32],
                                  const unsigned char scalar[32],
                                  const unsigned char point[32]);

/* RFC 7748 §6.1 벡터 (papers/rfc7748-x25519.txt 768~777행에서 추출) */
static const uint8_t alice_sk[32] = {
    0x77, 0x07, 0x6d, 0x0a, 0x73, 0x18, 0xa5, 0x7d,
    0x3c, 0x16, 0xc1, 0x72, 0x51, 0xb2, 0x66, 0x45,
    0xdf, 0x4c, 0x2f, 0x87, 0xeb, 0xc0, 0x99, 0x2a,
    0xb1, 0x77, 0xfb, 0xa5, 0x1d, 0xb9, 0x2c, 0x2a,
};
static const uint8_t alice_pk[32] = {
    0x85, 0x20, 0xf0, 0x09, 0x89, 0x30, 0xa7, 0x54,
    0x74, 0x8b, 0x7d, 0xdc, 0xb4, 0x3e, 0xf7, 0x5a,
    0x0d, 0xbf, 0x3a, 0x0d, 0x26, 0x38, 0x1a, 0xf4,
    0xeb, 0xa4, 0xa9, 0x8e, 0xaa, 0x9b, 0x4e, 0x6a,
};
static const uint8_t bob_sk[32] = {
    0x5d, 0xab, 0x08, 0x7e, 0x62, 0x4a, 0x8a, 0x4b,
    0x79, 0xe1, 0x7f, 0x8b, 0x83, 0x80, 0x0e, 0xe6,
    0x6f, 0x3b, 0xb1, 0x29, 0x26, 0x18, 0xb6, 0xfd,
    0x1c, 0x2f, 0x8b, 0x27, 0xff, 0x88, 0xe0, 0xeb,
};
static const uint8_t bob_pk[32] = {
    0xde, 0x9e, 0xdb, 0x7d, 0x7b, 0x7d, 0xc1, 0xb4,
    0xd3, 0x5b, 0x61, 0xc2, 0xec, 0xe4, 0x35, 0x37,
    0x3f, 0x83, 0x43, 0xc8, 0x5b, 0x78, 0x67, 0x4d,
    0xad, 0xfc, 0x7e, 0x14, 0x6f, 0x88, 0x2b, 0x4f,
};
static const uint8_t shared_k[32] = {
    0x4a, 0x5d, 0x9d, 0x5b, 0xa4, 0xce, 0x2d, 0xe1,
    0x72, 0x8e, 0x3b, 0xf4, 0x80, 0x35, 0x0f, 0x25,
    0xe0, 0x7e, 0x21, 0xc9, 0x47, 0xd1, 0x9e, 0x33,
    0x76, 0xf0, 0x9b, 0x3c, 0x1e, 0x16, 0x17, 0x42,
};

static const uint8_t basepoint[32] = { 9 };

/* RFC 7748 스칼라 클램핑 — 두 번 해도 결과가 같아서(멱등),
 * 어셈블리 내부에서 또 하더라도 무해하다 */
static void clamp(uint8_t k[32])
{
    k[0]  &= 248;
    k[31] &= 127;
    k[31] |= 64;
}

static int check(const char *name, const uint8_t got[32], const uint8_t want[32])
{
    uart_puts(name);
    if (memcmp(got, want, 32) == 0) {
        uart_puts(": OK\n");
        return 0;
    }
    uart_puts(": FAIL\n  got  ");
    uart_put_hex_bytes(got, 32);
    uart_puts("\n  want ");
    uart_put_hex_bytes(want, 32);
    uart_puts("\n");
    return 1;
}

int main(void)
{
    uint8_t sk[32], out_a[32], out_b[32], sh_a[32], sh_b[32];
    int fails = 0;

    uart_init();
    uart_puts("=== ex2: X25519 KAT (RFC 7748 sec 6.1) ===\n");

    memcpy(sk, alice_sk, 32); clamp(sk);
    curve25519_scalarmult(out_a, sk, basepoint);
    fails += check("alice_pk", out_a, alice_pk);

    memcpy(sk, bob_sk, 32); clamp(sk);
    curve25519_scalarmult(out_b, sk, basepoint);
    fails += check("bob_pk  ", out_b, bob_pk);

    memcpy(sk, alice_sk, 32); clamp(sk);
    curve25519_scalarmult(sh_a, sk, bob_pk);
    fails += check("K(a,B)  ", sh_a, shared_k);

    memcpy(sk, bob_sk, 32); clamp(sk);
    curve25519_scalarmult(sh_b, sk, alice_pk);
    fails += check("K(b,A)  ", sh_b, shared_k);

    uart_puts(fails ? "EX2 FAIL\n" : "EX2 PASS -- stream A verified\n");
    qemu_exit(fails);
}
