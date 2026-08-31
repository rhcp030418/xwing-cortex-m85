/* 실험 BV (W03/W04/W05 분모): M85 **스칼라 × MVE 동시 발행률** 직접 측정.
 *
 * 이 프로젝트의 본론(명령어 스티칭)의 상한은 "ML-KEM 의 MVE 작업을 X25519 의 스칼라
 * 시간 안에 얼마나 숨길 수 있는가"이다. slothy-2stream README 는 합성 proxy 로
 * 은닉률 61.7% 를 보고했으나 **M85 실측이 아니다.** 여기서 직접 잰다.
 *
 * 커널 6개, 각 128 명령.  void f(void *scratch)
 *   A umaal_only  : umaal 128            (스칼라 곱셈 기준선)
 *   B vmul_only   : vmul.i16 q 128       (MVE 정수 곱 기준선)
 *   C vadd_only   : vadd.i16 q 128       (MVE 정수 덧셈 기준선)
 *   D mix_mul     : umaal 64 + vmul 64 교대   (스칼라곱 x MVE곱 — 곱셈기 경합?)
 *   E mix_add     : umaal 64 + vadd 64 교대   (스칼라곱 x MVE덧셈 — 은닉 가능?)
 *   F mix_ldr     : umaal 64 + vldrw 64 교대  (스칼라곱 x MVE적재)
 *
 * 은닉률 = 1 - (mix - max(A/2, X/2)) / min(A/2, X/2)  형태로 해석한다(결과 문서에서).
 */

	.syntax unified
	.thumb
	.text	/* expCA 를 위해 ITCM 에서 내림 (측정 완료 커널) */
	.align 2

	.macro BV_PRO
	push	{r4-r11, lr}
	vldrw.u32	q0, [r0]
	vldrw.u32	q1, [r0]
	vldrw.u32	q2, [r0]
	vldrw.u32	q3, [r0]
	movs	r2, #3
	movs	r3, #5
	movs	r10, #29
	movs	r11, #31
	.endm

	.macro BV_EPI
	pop	{r4-r11, pc}
	.endm

	.balign 16
	.type	expbv_umaal_only, %function
	.global	expbv_umaal_only
expbv_umaal_only:
	BV_PRO
	.rept 128
	umaal	r2, r3, r10, r11
	.endr
	BV_EPI
	.size	expbv_umaal_only, .-expbv_umaal_only

	.balign 16
	.type	expbv_vmul_only, %function
	.global	expbv_vmul_only
expbv_vmul_only:
	BV_PRO
	.rept 128
	vmul.i16	q0, q1, q2
	.endr
	BV_EPI
	.size	expbv_vmul_only, .-expbv_vmul_only

	.balign 16
	.type	expbv_vadd_only, %function
	.global	expbv_vadd_only
expbv_vadd_only:
	BV_PRO
	.rept 128
	vadd.i16	q0, q1, q2
	.endr
	BV_EPI
	.size	expbv_vadd_only, .-expbv_vadd_only

	.balign 16
	.type	expbv_mix_mul, %function
	.global	expbv_mix_mul
expbv_mix_mul:
	BV_PRO
	.rept 64
	umaal	r2, r3, r10, r11
	vmul.i16	q0, q1, q2
	.endr
	BV_EPI
	.size	expbv_mix_mul, .-expbv_mix_mul

	.balign 16
	.type	expbv_mix_add, %function
	.global	expbv_mix_add
expbv_mix_add:
	BV_PRO
	.rept 64
	umaal	r2, r3, r10, r11
	vadd.i16	q0, q1, q2
	.endr
	BV_EPI
	.size	expbv_mix_add, .-expbv_mix_add

	.balign 16
	.type	expbv_mix_ldr, %function
	.global	expbv_mix_ldr
expbv_mix_ldr:
	BV_PRO
	.rept 64
	umaal	r2, r3, r10, r11
	vldrw.u32	q3, [r0]
	.endr
	BV_EPI
	.size	expbv_mix_ldr, .-expbv_mix_ldr

	.ltorg
