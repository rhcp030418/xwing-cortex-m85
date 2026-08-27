/* 실험 BM: fe25519_mul_flat / fe25519_mul_sched 의 AAPCS 래퍼.
 * expBA 의 fe25519_mul_bb_lenn 과 완전히 같은 형태 — 양쪽이 같은 래퍼 비용을 문다. */
	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits
	.align 2

	.extern	fe25519_mul_flat
	.type	fe25519_mul_flat_lenn, %function
	.global	fe25519_mul_flat_lenn
fe25519_mul_flat_lenn:
	push	{r4-r11, lr}
	sub	sp, sp, #8
	str	r0, [sp]
	bl	fe25519_mul_flat
	ldr	r8, [sp]
	stm	r8, {r0-r7}
	add	sp, sp, #8
	pop	{r4-r11, pc}
	.size	fe25519_mul_flat_lenn, .-fe25519_mul_flat_lenn

	.extern	fe25519_mul_sched
	.type	fe25519_mul_sched_lenn, %function
	.global	fe25519_mul_sched_lenn
fe25519_mul_sched_lenn:
	push	{r4-r11, lr}
	sub	sp, sp, #8
	str	r0, [sp]
	bl	fe25519_mul_sched
	ldr	r8, [sp]
	stm	r8, {r0-r7}
	add	sp, sp, #8
	pop	{r4-r11, pc}
	.size	fe25519_mul_sched_lenn, .-fe25519_mul_sched_lenn
