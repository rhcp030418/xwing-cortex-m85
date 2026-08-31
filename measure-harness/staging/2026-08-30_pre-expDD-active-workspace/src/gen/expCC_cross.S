/* 실험 CC: 교차 종류별 겹침 — MVE 메모리 x 스칼라 연산이 겹치는가.
 *
 * expCB-2 는 메모리 x 메모리만 쟀다(겹침 0%). expBZ 는 연산 x 연산만 쟀다(100%).
 * 그 사이가 비어 있고, 거기서 "벽이냐 배치 문제냐"가 갈린다.
 * 사전등록: 2026-08-27_expCC_prereg.md
 *
 * 커널 5종, 각 128 명령.  void f(void *dtcm_buf)
 */

	.syntax unified
	.thumb
	.text
	.align 2

	.macro CC_PRO
	push	{r4-r11, lr}
	mov	r7, r0
	vldrw.u32	q0, [r7]
	vldrw.u32	q1, [r7, #16]
	vldrw.u32	q2, [r7, #32]
	vldrw.u32	q4, [r7]
	vldrw.u32	q5, [r7, #16]
	vldrw.u32	q6, [r7, #32]
	vldrw.u32	q7, [r7, #48]
	movs	r2, #3
	movs	r3, #5
	movs	r10, #29
	movs	r11, #31
	.endm

	.macro CC_EPI
	pop	{r4-r11, pc}
	.endm

/* M: MVE 적재 x 스칼라 연산 */
	.balign 16
	.type	expcc_vldr_umaal, %function
	.global	expcc_vldr_umaal
expcc_vldr_umaal:
	CC_PRO
	.rept 32
	vldrw.u32	q0, [r7]
	umaal	r2, r3, r10, r11
	vldrw.u32	q1, [r7, #16]
	umaal	r2, r3, r10, r11
	.endr
	CC_EPI
	.size	expcc_vldr_umaal, .-expcc_vldr_umaal

/* N: MVE 연산 x 스칼라 적재 */
	.balign 16
	.type	expcc_vmul_ldr, %function
	.global	expcc_vmul_ldr
expcc_vmul_ldr:
	CC_PRO
	.rept 32
	vmul.i16	q0, q4, q5
	ldr	r4, [r7, #64]
	vmul.i16	q1, q6, q7
	ldr	r5, [r7, #80]
	.endr
	CC_EPI
	.size	expcc_vmul_ldr, .-expcc_vmul_ldr

/* O: MVE 저장 x 스칼라 연산 */
	.balign 16
	.type	expcc_vstr_umaal, %function
	.global	expcc_vstr_umaal
expcc_vstr_umaal:
	CC_PRO
	.rept 32
	vstrw.u32	q0, [r7]
	umaal	r2, r3, r10, r11
	vstrw.u32	q1, [r7, #16]
	umaal	r2, r3, r10, r11
	.endr
	CC_EPI
	.size	expcc_vstr_umaal, .-expcc_vstr_umaal

/* P: MVE 연산 x 스칼라 저장 */
	.balign 16
	.type	expcc_vmul_str, %function
	.global	expcc_vmul_str
expcc_vmul_str:
	CC_PRO
	.rept 32
	vmul.i16	q0, q4, q5
	str	r2, [r7, #64]
	vmul.i16	q1, q6, q7
	str	r3, [r7, #80]
	.endr
	CC_EPI
	.size	expcc_vmul_str, .-expcc_vmul_str

/* Q: MVE 내부 — 적재와 연산이 서로 막는가 */
	.balign 16
	.type	expcc_vldr_vmul, %function
	.global	expcc_vldr_vmul
expcc_vldr_vmul:
	CC_PRO
	.rept 32
	vldrw.u32	q0, [r7]
	vmul.i16	q1, q4, q5
	vldrw.u32	q2, [r7, #16]
	vmul.i16	q3, q6, q7
	.endr
	CC_EPI
	.size	expcc_vldr_vmul, .-expcc_vldr_vmul

/* ---- 같은 CC_PRO 를 쓰는 기준선 6종 (오버헤드 X 를 소거하기 위해) ---- */

	.balign 16
	.type	expcc_b_vldr, %function
	.global	expcc_b_vldr
expcc_b_vldr:
	CC_PRO
	.rept 32
	vldrw.u32	q0, [r7]
	vldrw.u32	q1, [r7, #16]
	vldrw.u32	q2, [r7, #32]
	vldrw.u32	q3, [r7, #48]
	.endr
	CC_EPI
	.size	expcc_b_vldr, .-expcc_b_vldr

	.balign 16
	.type	expcc_b_vstr, %function
	.global	expcc_b_vstr
expcc_b_vstr:
	CC_PRO
	.rept 32
	vstrw.u32	q0, [r7]
	vstrw.u32	q1, [r7, #16]
	vstrw.u32	q2, [r7, #32]
	vstrw.u32	q3, [r7, #48]
	.endr
	CC_EPI
	.size	expcc_b_vstr, .-expcc_b_vstr

	.balign 16
	.type	expcc_b_vmul, %function
	.global	expcc_b_vmul
expcc_b_vmul:
	CC_PRO
	.rept 32
	vmul.i16	q0, q4, q5
	vmul.i16	q1, q6, q7
	vmul.i16	q2, q4, q6
	vmul.i16	q3, q5, q7
	.endr
	CC_EPI
	.size	expcc_b_vmul, .-expcc_b_vmul

	.balign 16
	.type	expcc_b_umaal, %function
	.global	expcc_b_umaal
expcc_b_umaal:
	CC_PRO
	.rept 128
	umaal	r2, r3, r10, r11
	.endr
	CC_EPI
	.size	expcc_b_umaal, .-expcc_b_umaal

	.balign 16
	.type	expcc_b_ldr, %function
	.global	expcc_b_ldr
expcc_b_ldr:
	CC_PRO
	.rept 32
	ldr	r4, [r7, #64]
	ldr	r5, [r7, #80]
	ldr	r6, [r7, #96]
	ldr	r8, [r7, #112]
	.endr
	CC_EPI
	.size	expcc_b_ldr, .-expcc_b_ldr

	.balign 16
	.type	expcc_b_str, %function
	.global	expcc_b_str
expcc_b_str:
	CC_PRO
	.rept 32
	str	r2, [r7, #64]
	str	r3, [r7, #80]
	str	r4, [r7, #96]
	str	r5, [r7, #112]
	.endr
	CC_EPI
	.size	expcc_b_str, .-expcc_b_str

	.ltorg
