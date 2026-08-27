/* 실험 BC: fe25519_* 심볼을 소유하는 얇은 디스패처.
 *
 * x25519-cortex-m4-gcc.s 의 정의는 apx_real_* 로 rename 돼 있다.
 * mul/add/sub 는 그대로 tail-branch, sqr 만 x02_mode 로 갈라진다.
 * 양쪽 경로가 같은 진입 비용을 물므로 A/B 차분에 영향이 없다.
 */
	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits
	.align 2

	.extern	apx_real_fe25519_mul
	.extern	apx_real_fe25519_sqr
	.extern	apx_real_fe25519_add
	.extern	apx_real_fe25519_sub
	.extern	fe25519_sqr_bb
	.extern	x02_mode

	.type	fe25519_mul, %function
	.global	fe25519_mul
fe25519_mul:
	b	apx_real_fe25519_mul
	.size	fe25519_mul, .-fe25519_mul

	.type	fe25519_add, %function
	.global	fe25519_add
fe25519_add:
	b	apx_real_fe25519_add
	.size	fe25519_add, .-fe25519_add

	.type	fe25519_sub, %function
	.global	fe25519_sub
fe25519_sub:
	b	apx_real_fe25519_sub
	.size	fe25519_sub, .-fe25519_sub

/* sqr: 0 = 원본, 1 = BB 재스케줄본.  r12 만 쓴다(양쪽 다 clobber 허용). */
	.type	fe25519_sqr, %function
	.global	fe25519_sqr
fe25519_sqr:
	ldr	r12, =x02_mode
	ldr	r12, [r12]
	cmp	r12, #0
	bne	1f
	b	apx_real_fe25519_sqr
1:
	b	fe25519_sqr_bb
	.size	fe25519_sqr, .-fe25519_sqr

	.ltorg
