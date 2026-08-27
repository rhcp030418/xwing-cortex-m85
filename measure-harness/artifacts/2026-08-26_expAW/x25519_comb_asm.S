/* 실험 AV: ge_madd 를 native ABI 로 sequencing 하는 asm 루프.
 *
 * 사전등록: A주제/measure-harness/2026-08-26_expAV_x06_native_prereg.md §2.1
 *
 * AT-2 는 fe25519_* 를 AAPCS 래퍼(*_lenn)로 불러 field op 당 49.4 cyc 를 물었다.
 * 여기서는 Lenngren 함수를 **원래 규약 그대로** 부른다.
 *   fe25519_mul : *r1=a, *r2=b -> r0-r7
 *   fe25519_add : *r8=a, *r9=b -> r0-r7
 *   fe25519_sub : *r8=a, *r9=b -> r0-r7
 * 셋 다 r0-r12/lr 을 clobber 하지만 sp 는 건드리지 않는다. 따라서 모든 상태를
 * 자기 프레임에 두고 sp 상대로만 접근한다.
 *
 *   void ge_madd_native(ge_ctx *ctx);
 *   ctx:  0 X, 32 Y, 64 Z, 96 T, 128 pa, 132 pb, 136 pxy   (fe = 32 B)
 *
 * 프레임 (sp 상대):
 *   0 a, 32 b, 64 c, 96 d, 128 x3, 160 y3, 192 z3, 224 t3, 256 ctx, 260 pad
 */

	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits
	.align 2

	.extern fe25519_mul
	.extern fe25519_add
	.extern fe25519_sub

	.equ	FA,   0
	.equ	FB,  32
	.equ	FC,  64
	.equ	FD,  96
	.equ	FX3,128
	.equ	FY3,160
	.equ	FZ3,192
	.equ	FT3,224
	.equ	FCTX,256
	.equ	FSZ, 268

	.type	ge_madd_native, %function
	.global	ge_madd_native
ge_madd_native:
	/* fe25519_* 는 r4-r11 을 전부 clobber 한다.  이 함수는 C 에서 불리므로
	 * AAPCS 대로 callee-saved 를 반드시 보존해야 한다 (madd 당 1회, ~17 cyc). */
	push	{r4-r11, lr}
	sub	sp, sp, #FSZ
	str	r0, [sp, #FCTX]

	/* a = Y + X */
	ldr	r12, [sp, #FCTX]
	add	r8, r12, #32
	mov	r9, r12
	bl	fe25519_add
	add	r12, sp, #FA
	stm	r12, {r0-r7}

	/* a = a * pa */
	ldr	r12, [sp, #FCTX]
	ldr	r2, [r12, #128]
	add	r1, sp, #FA
	bl	fe25519_mul
	add	r12, sp, #FA
	stm	r12, {r0-r7}

	/* b = Y - X */
	ldr	r12, [sp, #FCTX]
	add	r8, r12, #32
	mov	r9, r12
	bl	fe25519_sub
	add	r12, sp, #FB
	stm	r12, {r0-r7}

	/* b = b * pb */
	ldr	r12, [sp, #FCTX]
	ldr	r2, [r12, #132]
	add	r1, sp, #FB
	bl	fe25519_mul
	add	r12, sp, #FB
	stm	r12, {r0-r7}

	/* c = pxy * T */
	ldr	r12, [sp, #FCTX]
	ldr	r1, [r12, #136]
	add	r2, r12, #96
	bl	fe25519_mul
	add	r12, sp, #FC
	stm	r12, {r0-r7}

	/* d = Z + Z */
	ldr	r12, [sp, #FCTX]
	add	r8, r12, #64
	add	r9, r12, #64
	bl	fe25519_add
	add	r12, sp, #FD
	stm	r12, {r0-r7}

	/* x3 = a - b */
	add	r8, sp, #FA
	add	r9, sp, #FB
	bl	fe25519_sub
	add	r12, sp, #FX3
	stm	r12, {r0-r7}

	/* y3 = a + b */
	add	r8, sp, #FA
	add	r9, sp, #FB
	bl	fe25519_add
	add	r12, sp, #FY3
	stm	r12, {r0-r7}

	/* z3 = d + c */
	add	r8, sp, #FD
	add	r9, sp, #FC
	bl	fe25519_add
	add	r12, sp, #FZ3
	stm	r12, {r0-r7}

	/* t3 = d - c */
	add	r8, sp, #FD
	add	r9, sp, #FC
	bl	fe25519_sub
	add	r12, sp, #FT3
	stm	r12, {r0-r7}

	/* X = x3 * t3 */
	add	r1, sp, #FX3
	add	r2, sp, #FT3
	bl	fe25519_mul
	ldr	r12, [sp, #FCTX]
	stm	r12, {r0-r7}

	/* Y = y3 * z3 */
	add	r1, sp, #FY3
	add	r2, sp, #FZ3
	bl	fe25519_mul
	ldr	r12, [sp, #FCTX]
	add	r12, r12, #32
	stm	r12, {r0-r7}

	/* Z = z3 * t3 */
	add	r1, sp, #FZ3
	add	r2, sp, #FT3
	bl	fe25519_mul
	ldr	r12, [sp, #FCTX]
	add	r12, r12, #64
	stm	r12, {r0-r7}

	/* T = x3 * y3 */
	add	r1, sp, #FX3
	add	r2, sp, #FY3
	bl	fe25519_mul
	ldr	r12, [sp, #FCTX]
	add	r12, r12, #96
	stm	r12, {r0-r7}

	add	sp, sp, #FSZ
	pop	{r4-r11, pc}
	.size	ge_madd_native, .-ge_madd_native

	.ltorg
