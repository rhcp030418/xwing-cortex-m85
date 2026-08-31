/* expCR — Lenngren fe25519_mul 에 r11 을 수동 양보한 변형 (13 GP 레지스터).
 *
 * 원본 apx_real_fe25519_mul (x25519-cortex-m4-gcc.s, Emil Lenngren, MIT) 과 같은
 * 8x8 limb schoolbook + 38 환원. 차이:
 *   - r11 을 절대 읽거나 쓰지 않는다 (파트너 스트림이 r11 을 살려 둘 수 있게).
 *   - a-limb 는 한 개씩 ldr (원본은 ldm 3개/2개).
 *   - 열 4 부분합을 row 4 뒤에 [sp,#36](pre-push) 로 스필, 둘째 반 row 0 에서 재적재.
 *   - 열 10 부분합을 첫 반 끝에 [sp,#44](post-push) 로 스필, 둘째 반 row 3 에서 재적재.
 *   - 환원부 mov 2개 추가 (열 12 가 r0 에 있음).
 * 입력 *r1=a, *r2=b / 출력 r0-r7 / sp 복원. 사전등록 2026-08-28_expCR_lenngren_yield1_prereg.md
 */

	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits
	.align 4

	.type apx_real_fe25519_mul_y1, %function
	.global apx_real_fe25519_mul_y1
apx_real_fe25519_mul_y1:
	push {r2,lr}
	sub sp,#36
	ldm r2,{r2,r3,r4,r5}

	/* ---- first half: b0..b3 x a0..a7 ---- */
	ldr r0,[r1],#4
	ldr lr,[r1],#4
	umull r6,r10,r2,r0
	umull r7,r12,r3,r0
	umaal r7,r10,r2,lr
	push {r6,r7}
	umull r8,r6,r4,r0
	umaal r8,r10,r3,lr
	umull r9,r7,r5,r0
	ldr r0,[r1],#4
	umaal r9,r10,r4,lr
	umaal r10,r7,r5,lr
	umaal r8,r12,r2,r0
	umaal r9,r12,r3,r0
	umaal r10,r12,r4,r0
	umaal r12,r7,r5,r0

	ldr r0,[r1],#4
	ldr lr,[r1],#4
	umaal r9,r6,r2,r0
	umaal r10,r6,r3,r0
	umaal r12,r6,r4,r0
	umaal r6,r7,r5,r0
	strd r8,r9,[sp,#8]

	ldr r0,[r1],#4
	mov r9,#0
	umaal r10,r9,r2,lr
	umaal r12,r9,r3,lr
	umaal r6,r9,r4,lr
	umaal r7,r9,r5,lr
	str r10,[sp,#36]

	mov r10,#0
	umaal r12,r10,r2,r0
	umaal r6,r10,r3,r0
	umaal r7,r10,r4,r0
	umaal r9,r10,r5,r0

	ldr r8,[r1],#4
	mov lr,#0
	umaal lr,r6,r2,r8
	umaal r7,r6,r3,r8
	umaal r9,r6,r4,r8
	umaal r10,r6,r5,r8

	ldr r8,[r1],#-28
	mov r0,#0
	umaal r7,r0,r2,r8
	umaal r9,r0,r3,r8
	umaal r10,r0,r4,r8
	umaal r6,r0,r5,r8
	push {r0}
	str r6,[sp,#44]
	/* c4=[#40] c5=r12 c6=lr c7=r7 c8=r9 c9=r10 c10=[#44] c11=[#0] */

	/* ---- second half: b4..b7 x a0..a7 ---- */
	ldr r2,[sp,#48]
	adds r2,r2,#16
	ldm r2,{r2,r3,r4,r5}

	ldr r8,[r1],#4
	ldr r6,[sp,#40]
	mov r0,#0
	umaal r6,r0,r2,r8
	str r6,[sp,#20]
	umaal r12,r0,r3,r8
	umaal lr,r0,r4,r8
	umaal r0,r7,r5,r8

	ldr r8,[r1],#4
	mov r6,#0
	umaal r12,r6,r2,r8
	str r12,[sp,#24]
	umaal lr,r6,r3,r8
	umaal r0,r6,r4,r8
	umaal r6,r7,r5,r8

	ldr r8,[r1],#4
	mov r12,#0
	umaal lr,r12,r2,r8
	str lr,[sp,#28]
	umaal r0,r12,r3,r8
	umaal r6,r12,r4,r8
	umaal r10,r12,r5,r8

	ldr r8,[r1],#4
	mov lr,#0
	umaal r0,lr,r2,r8
	str r0,[sp,#32]
	ldr r0,[sp,#44]
	umaal r6,lr,r3,r8
	umaal r10,lr,r4,r8
	umaal r0,lr,r5,r8

	ldr r8,[r1],#4
	umaal r6,r9,r2,r8
	str r6,[sp,#36]
	umaal r9,r10,r3,r8
	umaal r10,r0,r4,r8
	pop {r6}
	umaal r6,r0,r5,r8

	ldr r8,[r1],#4
	umaal r9,r7,r2,r8
	umaal r10,r7,r3,r8
	umaal r6,r7,r4,r8
	umaal r0,r7,r5,r8

	ldr r8,[r1],#4
	umaal r10,r12,r2,r8
	umaal r6,r12,r3,r8
	umaal r0,r12,r4,r8
	umaal r7,r12,r5,r8

	ldr r8,[r1],#4
	umaal r6,lr,r2,r8
	umaal r0,lr,r3,r8
	umaal lr,r7,r4,r8
	umaal r7,r12,r5,r8
	/* c9=r9 c10=r10 c11=r6 c12=r0 c13=lr c14=r7 c15=r12 ; stack c0..c8 */

	/* ---- reduce mod 2^255-19 ---- */
	ldrd r4,r5,[sp,#28]
	movs r3,#38
	mov r8,#0
	umaal r4,r8,r3,r12
	lsl r8,r8,#1
	orr r8,r8,r4, lsr #31
	and r12,r4,#0x7fffffff
	movs r4,#19
	mul r8,r8,r4
	mov r4,r0

	pop {r0-r2}
	umaal r0,r8,r3,r5
	umaal r1,r8,r3,r9
	umaal r2,r8,r3,r10
	mov r9,#38
	mov r5,r4
	pop {r3,r4}
	umaal r3,r8,r9,r6
	umaal r4,r8,r9,r5
	pop {r5,r6}
	umaal r5,r8,r9,lr
	umaal r6,r8,r9,r7
	add r7,r8,r12

	add sp,#20
	pop {pc}
	.size apx_real_fe25519_mul_y1, .-apx_real_fe25519_mul_y1

/* AAPCS 래퍼 — expAM 의 fe25519_mul_lenn 과 동일 구조 */
	.type	fe25519_mul_y1_lenn, %function
	.global	fe25519_mul_y1_lenn
fe25519_mul_y1_lenn:
	push	{r4-r11, lr}
	sub	sp, sp, #8
	str	r0, [sp]
	bl	apx_real_fe25519_mul_y1
	ldr	r8, [sp]
	stm	r8, {r0-r7}
	add	sp, sp, #8
	pop	{r4-r11, pc}
	.size	fe25519_mul_y1_lenn, .-fe25519_mul_y1_lenn
