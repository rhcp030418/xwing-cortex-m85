/* AT-2: Lenngren fe25519_add / fe25519_sub 의 AAPCS 래퍼.
 *
 * 원본 ABI (x25519-cortex-m4-gcc.s 주석):
 *   fe25519_add/sub : in *r8=a, *r9=b ; out r0-r7 ; clobbers all other registers
 * 둘 다 sp 를 건드리지 않고 bx lr 로 돌아온다.
 *
 * expAM_micro.S 의 fe25519_mul_lenn / fe25519_sqr_lenn 과 같은 형태다.
 *   void fe25519_add_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);
 *   void fe25519_sub_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);
 */

	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits
	.align 2

	.extern fe25519_add
	.extern fe25519_sub

	.type	fe25519_add_lenn, %function
	.global	fe25519_add_lenn
fe25519_add_lenn:
	push	{r4-r11, lr}
	sub	sp, sp, #8
	str	r0, [sp]
	mov	r8, r1
	mov	r9, r2
	bl	fe25519_add
	ldr	r8, [sp]
	stm	r8, {r0-r7}
	add	sp, sp, #8
	pop	{r4-r11, pc}
	.size	fe25519_add_lenn, .-fe25519_add_lenn

	.type	fe25519_sub_lenn, %function
	.global	fe25519_sub_lenn
fe25519_sub_lenn:
	push	{r4-r11, lr}
	sub	sp, sp, #8
	str	r0, [sp]
	mov	r8, r1
	mov	r9, r2
	bl	fe25519_sub
	ldr	r8, [sp]
	stm	r8, {r0-r7}
	add	sp, sp, #8
	pop	{r4-r11, pc}
	.size	fe25519_sub_lenn, .-fe25519_sub_lenn

	.ltorg
