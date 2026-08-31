#ifndef EXP_AE_FIAT_X25519_H
#define EXP_AE_FIAT_X25519_H

#include <stdint.h>

typedef void (*fiat_mul_fn)(uint32_t out[10], const uint32_t a[10],
                            const uint32_t b[10]);

void fiat_mul_y11_scalar(uint32_t out[10], const uint32_t a[10],
                         const uint32_t b[10]);

void fiat_mul_u4_p0(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u4s_p0(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u4t_p0(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u4_p1(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u4s_p1(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u4t_p1(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u4_p2(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u4s_p2(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u4t_p2(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u4_p3(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u4s_p3(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u4t_p3(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u4a_p0(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u4a_p1(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u4a_p2(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u4a_p3(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u8_p0(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u8_p1(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u8_p2(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u8_p3(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u8_p4(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u8_p5(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u8_p6(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);
void fiat_mul_u8_p7(uint32_t out[10], const uint32_t a[10], const uint32_t b[10]);

void fiat_u_qsave(uint32_t save[16]);
void fiat_u_qrestore(const uint32_t save[16]);
void expdb_qall_save(uint32_t save[32]);
void expdb_qall_restore(const uint32_t save[32]);

void curve25519_scalarmult_fiat(uint8_t out[32], const uint8_t scalar[32],
                               const uint8_t point[32]);
void fiat_x25519_queue_reset(void);
int fiat_x25519_enqueue(uint8_t out[32], const uint8_t scalar[32],
                        const uint8_t point[32]);
void fiat_x25519_step(fiat_mul_fn mul);
void fiat_x25519_finish_all(void);
uint32_t fiat_x25519_queue_pending(void);
uint32_t fiat_x25519_failures(void);

extern volatile uint32_t g_u_real_steps;
extern volatile uint32_t g_u_dummy_steps;
extern uint32_t *g_u_mve_block;

#endif
