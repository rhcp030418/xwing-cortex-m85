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
 *   ctx:  0 X, 32 Y, 64 Z, 96 T, 128 pa, 132 pb, 136 pxy, 140 sign  (fe = 32 B)
 *
 * AX §1.1: digit 이 음수면 c 를 부호 반전하는 대신 z3/t3 를 맞바꾼다.
 *   c' = -c  =>  z3' = d-c = t3,  t3' = d+c = z3
 * Z = z3*t3 는 대칭, T = x3*y3 은 무관이므로 X 와 Y 가 쓰는 포인터만 바꾸면 된다.
 * sign(all-ones/0) 으로 상수시간 선택하며 field 연산이 하나도 늘지 않는다.
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

	/* AX: sign 에 따라 z3/t3 를 맞바꾼 포인터를 만든다 (상수시간).
	 *   pz = sign ? &t3 : &z3   (Y 가 쓴다)
	 *   pt = sign ? &z3 : &t3   (X 가 쓴다)
	 * 프레임 FA(=0)/FB(=32) 는 이미 소비됐으므로 재사용해 보관한다. */
	ldr	r12, [sp, #FCTX]
	ldr	r12, [r12, #140]	/* sign: all-ones or 0 */
	add	r10, sp, #FZ3
	add	r11, sp, #FT3
	eor	r9, r10, r11
	and	r9, r9, r12
	eor	r10, r10, r9		/* pz */
	eor	r11, r11, r9		/* pt */
	str	r10, [sp, #FA]
	str	r11, [sp, #FB]

	/* X = x3 * pt */
	add	r1, sp, #FX3
	ldr	r2, [sp, #FB]
	bl	fe25519_mul
	ldr	r12, [sp, #FCTX]
	stm	r12, {r0-r7}

	/* Y = y3 * pz */
	add	r1, sp, #FY3
	ldr	r2, [sp, #FA]
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


/* AX §1.2: n 회 연속 squaring.  fe25519_sqr 은 in/out 이 r0-r7 이므로
 * 루프 안에서 값을 레지스터에 둔 채 돌린다 — 중간 store/load 가 전혀 없다.
 *   void fe25519_sqr_chain(uint32_t r[8], const uint32_t a[8], uint32_t n);
 * fe25519_sqr 은 r8-r12 를 clobber 하므로 dst 와 n 은 스택에 둔다. */
	.extern	fe25519_sqr
	.type	fe25519_sqr_chain, %function
	.global	fe25519_sqr_chain
fe25519_sqr_chain:
	push	{r4-r11, lr}
	sub	sp, sp, #8
	str	r0, [sp, #0]		/* dst */
	str	r2, [sp, #4]		/* n */
	mov	r12, r1
	ldm	r12, {r0-r7}
1:
	bl	fe25519_sqr
	ldr	r12, [sp, #4]
	subs	r12, r12, #1
	str	r12, [sp, #4]
	bne	1b
	ldr	r12, [sp, #0]
	stm	r12, {r0-r7}
	add	sp, sp, #8
	pop	{r4-r11, pc}
	.size	fe25519_sqr_chain, .-fe25519_sqr_chain

	.ltorg
