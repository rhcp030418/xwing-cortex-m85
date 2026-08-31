/* 실험 CE: 누출률 법칙 k(메모리 비율).
 * 사전등록: 2026-08-27_expCE_prereg.md
 * MVE 고정 = intt layer67 x4.  스칼라는 길이 156 고정, 메모리 비율만 0~32%.
 * 레지스터: NTT r7 r8 r9 r11 r12 / 스칼라 r0 r2 r3 r4 r5  = 10 <= 14, 스필 없음.
 * ITCM 예산 때문에 .text.
 */
	.syntax unified
	.thumb
	.text
	.align 2

	.macro CE_PRO
	push	{r4-r12, lr}
	mov	r7, r2
	mov	r11, r3
	movw	r8, #3329
	movw	r9, #20159
	movw	r12, #3329
	/* q 초기화를 **먼저** 한다. r3(ntt_src)를 movs 로 깨기 전에. */
	vldrw.u32	q0, [r11]
	vldrw.u32	q1, [r11, #16]
	vldrw.u32	q2, [r11, #32]
	vldrw.u32	q3, [r11, #48]
	vldrw.u32	q4, [r11, #64]
	vldrw.u32	q5, [r11, #80]
	vldrw.u32	q6, [r11, #96]
	vldrw.u32	q7, [r11, #112]
	movs	r2, #3
	movs	r3, #5
	movs	r4, #7
	movs	r5, #11
	.endm

	.macro CE_EPI
	pop	{r4-r12, pc}
	.endm

	.balign 16
	.type	expce_a, %function
	.global	expce_a
expce_a:
	CE_PRO
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	vldrw.U32 q1, [r7, #16]
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r7]
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	vmul.S16 q7, q1, r8
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	vmul.S16 q3, q0, r8
	vldrw.U32 q1, [r11, #32]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r11, #80]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r11, #48]
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r11], #(3*32)
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r7, #32]
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	vldrw.U32 q1, [r7, #16]
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r7]
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	vmul.S16 q7, q1, r8
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	vmul.S16 q3, q0, r8
	vldrw.U32 q1, [r11, #32]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r11, #80]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r11, #48]
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r11], #(3*32)
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r7, #32]
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	vldrw.U32 q1, [r7, #16]
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r7]
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	vmul.S16 q7, q1, r8
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	vmul.S16 q3, q0, r8
	vldrw.U32 q1, [r11, #32]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r11, #80]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r11, #48]
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r11], #(3*32)
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r7, #32]
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	vldrw.U32 q1, [r7, #16]
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r7]
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	vmul.S16 q7, q1, r8
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	vmul.S16 q3, q0, r8
	vldrw.U32 q1, [r11, #32]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r11, #80]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r11, #48]
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r11], #(3*32)
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r7, #32]
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	vstrw.U32 q5, [r7, #-48]
	CE_EPI
	.size	expce_a, .-expce_a
	.balign 16
	.type	expce_b_r00, %function
	.global	expce_b_r00
expce_b_r00:
	CE_PRO
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	CE_EPI
	.size	expce_b_r00, .-expce_b_r00
	.balign 16
	.type	expce_c_r00, %function
	.global	expce_c_r00
expce_c_r00:
	CE_PRO
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	umaal	r2, r3, r4, r5
	vmul.S16 q4, q7, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	umaal	r2, r3, r4, r5
	vmla.S16 q3, q2, r12
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q1, q6
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	umaal	r2, r3, r4, r5
	vmul.S16 q4, q7, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	umaal	r2, r3, r4, r5
	vmla.S16 q3, q2, r12
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q1, q6
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	umaal	r2, r3, r4, r5
	vmul.S16 q4, q7, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	umaal	r2, r3, r4, r5
	vmla.S16 q3, q2, r12
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q1, q6
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	umaal	r2, r3, r4, r5
	vmul.S16 q4, q7, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	umaal	r2, r3, r4, r5
	vmla.S16 q3, q2, r12
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q1, q6
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	CE_EPI
	.size	expce_c_r00, .-expce_c_r00
	.balign 16
	.type	expce_b_r08, %function
	.global	expce_b_r08
expce_b_r08:
	CE_PRO
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #80]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	CE_EPI
	.size	expce_b_r08, .-expce_b_r08
	.balign 16
	.type	expce_c_r08, %function
	.global	expce_c_r08
expce_c_r08:
	CE_PRO
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	str	r5, [r0, #16]
	vmla.S16 q3, q2, r12
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	vqrdmulh.S16 q5, q1, q6
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	str	r5, [r0, #48]
	vmul.S16 q4, q7, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	vmla.S16 q3, q2, r12
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	str	r5, [r0, #80]
	vqrdmulh.S16 q5, q1, q6
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	str	r5, [r0, #16]
	vmla.S16 q3, q2, r12
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	vqrdmulh.S16 q5, q1, q6
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	str	r5, [r0, #16]
	vmul.S16 q4, q7, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	vmla.S16 q3, q2, r12
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	str	r5, [r0, #48]
	vqrdmulh.S16 q5, q1, q6
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	CE_EPI
	.size	expce_c_r08, .-expce_c_r08
	.balign 16
	.type	expce_b_r16, %function
	.global	expce_b_r16
expce_b_r16:
	CE_PRO
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #80]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #80]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #80]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	CE_EPI
	.size	expce_b_r16, .-expce_b_r16
	.balign 16
	.type	expce_c_r16, %function
	.global	expce_c_r16
expce_c_r16:
	CE_PRO
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	str	r5, [r0, #16]
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	vmla.S16 q3, q2, r12
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	str	r5, [r0, #48]
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	ldr	r4, [r0, #64]
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q1, q6
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	str	r5, [r0, #80]
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	ldr	r4, [r0, #0]
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	umaal	r2, r3, r4, r5
	vmul.S16 q4, q7, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	str	r5, [r0, #16]
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	ldr	r4, [r0, #0]
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	umaal	r2, r3, r4, r5
	vmla.S16 q3, q2, r12
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	str	r5, [r0, #16]
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	ldr	r4, [r0, #32]
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q1, q6
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	str	r5, [r0, #48]
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	ldr	r4, [r0, #64]
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	umaal	r2, r3, r4, r5
	vmul.S16 q4, q7, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	str	r5, [r0, #80]
	vmla.S16 q4, q6, r12
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	ldr	r4, [r0, #0]
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	umaal	r2, r3, r4, r5
	vmla.S16 q3, q2, r12
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	str	r5, [r0, #16]
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	ldr	r4, [r0, #0]
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q1, q6
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	str	r5, [r0, #16]
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	ldr	r4, [r0, #32]
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	umaal	r2, r3, r4, r5
	vmul.S16 q4, q7, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	str	r5, [r0, #48]
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	ldr	r4, [r0, #64]
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	umaal	r2, r3, r4, r5
	vmla.S16 q3, q2, r12
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	str	r5, [r0, #80]
	vmul.S16 q0, q5, q0
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	ldr	r4, [r0, #0]
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q1, q6
	str	r5, [r0, #16]
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	ldr	r4, [r0, #0]
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	CE_EPI
	.size	expce_c_r16, .-expce_c_r16
	.balign 16
	.type	expce_b_r24, %function
	.global	expce_b_r24
expce_b_r24:
	CE_PRO
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #80]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #80]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #80]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #80]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	CE_EPI
	.size	expce_b_r24, .-expce_b_r24
	.balign 16
	.type	expce_c_r24, %function
	.global	expce_c_r24
expce_c_r24:
	CE_PRO
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	str	r5, [r0, #16]
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	ldr	r4, [r0, #32]
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	str	r5, [r0, #48]
	vmla.S16 q3, q2, r12
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	ldr	r4, [r0, #64]
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	str	r5, [r0, #80]
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	vqrdmulh.S16 q5, q1, q6
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	str	r5, [r0, #16]
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	vmla.S16 q1, q5, r12
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r5, [r0, #16]
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	umaal	r2, r3, r4, r5
	vmul.S16 q4, q7, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	vmla.S16 q4, q6, r12
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	str	r5, [r0, #48]
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	vqrdmulh.S16 q2, q0, r9
	ldr	r4, [r0, #64]
	vldrw.U32 q0, [r11, #64]
	umaal	r2, r3, r4, r5
	vmla.S16 q3, q2, r12
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	str	r5, [r0, #80]
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	ldr	r4, [r0, #0]
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	str	r5, [r0, #16]
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q1, q6
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	ldr	r4, [r0, #0]
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	str	r5, [r0, #16]
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	ldr	r4, [r0, #32]
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	umaal	r2, r3, r4, r5
	vmul.S16 q4, q7, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	str	r5, [r0, #48]
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	ldr	r4, [r0, #64]
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	str	r5, [r0, #80]
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	umaal	r2, r3, r4, r5
	vmla.S16 q3, q2, r12
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	vmul.S16 q0, q5, q0
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	str	r5, [r0, #16]
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	ldr	r4, [r0, #0]
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q1, q6
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	str	r5, [r0, #16]
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	ldr	r4, [r0, #32]
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	str	r5, [r0, #48]
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	umaal	r2, r3, r4, r5
	vmul.S16 q4, q7, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	vqrdmulh.S16 q6, q7, r9
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	str	r5, [r0, #80]
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	ldr	r4, [r0, #0]
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	umaal	r2, r3, r4, r5
	vmla.S16 q3, q2, r12
	str	r5, [r0, #16]
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	ldr	r4, [r0, #0]
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	str	r5, [r0, #16]
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q1, q6
	ldr	r4, [r0, #32]
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	str	r5, [r0, #48]
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	ldr	r4, [r0, #64]
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	CE_EPI
	.size	expce_c_r24, .-expce_c_r24
	.balign 16
	.type	expce_b_r32, %function
	.global	expce_b_r32
expce_b_r32:
	CE_PRO
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #80]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #80]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #80]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #80]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #80]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #48]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #80]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	str	r5, [r0, #16]
	umaal	r2, r3, r4, r5
	umaal	r2, r3, r4, r5
	CE_EPI
	.size	expce_b_r32, .-expce_b_r32
	.balign 16
	.type	expce_c_r32, %function
	.global	expce_c_r32
expce_c_r32:
	CE_PRO
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	str	r5, [r0, #16]
	vmla.S16 q4, q6, r12
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	ldr	r4, [r0, #32]
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	str	r5, [r0, #48]
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	vmla.S16 q3, q2, r12
	ldr	r4, [r0, #64]
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	str	r5, [r0, #80]
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	vmla.S16 q0, q5, r12
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	str	r5, [r0, #16]
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	ldr	r4, [r0, #0]
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q1, q6
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	str	r5, [r0, #16]
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	ldr	r4, [r0, #32]
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	str	r5, [r0, #48]
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	ldr	r4, [r0, #64]
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	umaal	r2, r3, r4, r5
	vmul.S16 q4, q7, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	str	r5, [r0, #80]
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	ldr	r4, [r0, #0]
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	str	r5, [r0, #16]
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	ldr	r4, [r0, #0]
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	umaal	r2, r3, r4, r5
	vmla.S16 q3, q2, r12
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	str	r5, [r0, #16]
	vmul.S16 q0, q5, q0
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	ldr	r4, [r0, #32]
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	str	r5, [r0, #48]
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	ldr	r4, [r0, #64]
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q1, q6
	str	r5, [r0, #80]
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	vmul.S16 q2, q2, q3
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	str	r5, [r0, #16]
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	ldr	r4, [r0, #0]
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	str	r5, [r0, #16]
	vmul.S16 q4, q7, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q7, r9
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	vmla.S16 q4, q6, r12
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	str	r5, [r0, #48]
	vmul.S16 q7, q1, r8
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	ldr	r4, [r0, #64]
	vmul.S16 q3, q0, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	str	r5, [r0, #80]
	vmla.S16 q3, q2, r12
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	umaal	r2, r3, r4, r5
	vmul.S16 q0, q5, q0
	ldr	r4, [r0, #0]
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #48]
	str	r5, [r0, #16]
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q5, q1
	ldr	r4, [r0, #0]
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	umaal	r2, r3, r4, r5
	vadd.U16 q4, q6, q4
	str	r5, [r0, #16]
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q1, q6
	umaal	r2, r3, r4, r5
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	ldr	r4, [r0, #32]
	vldrw.U32 q3, [r11], #(3*32)
	umaal	r2, r3, r4, r5
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	str	r5, [r0, #48]
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	ldr	r4, [r0, #64]
	vadd.U16 q5, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r5, [r0, #80]
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	umaal	r2, r3, r4, r5
	vmul.S16 q4, q7, r8
	umaal	r2, r3, r4, r5
	vldrw.U32 q1, [r7, #16]
	vqrdmulh.S16 q6, q7, r9
	ldr	r4, [r0, #0]
	umaal	r2, r3, r4, r5
	vldrw.U32 q0, [r7]
	umaal	r2, r3, r4, r5
	vmla.S16 q4, q6, r12
	str	r5, [r0, #16]
	vqrdmulh.S16 q6, q1, r9
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q4
	umaal	r2, r3, r4, r5
	vmul.S16 q7, q1, r8
	ldr	r4, [r0, #0]
	vadd.U16 q4, q3, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q6, r12
	umaal	r2, r3, r4, r5
	vmul.S16 q3, q0, r8
	str	r5, [r0, #16]
	vldrw.U32 q1, [r11, #32]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	umaal	r2, r3, r4, r5
	vmla.S16 q3, q2, r12
	umaal	r2, r3, r4, r5
	vldrw.U32 q2, [r11, #80]
	vmul.S16 q0, q5, q0
	ldr	r4, [r0, #32]
	umaal	r2, r3, r4, r5
	vadd.U16 q6, q3, q7
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q5, q2
	str	r5, [r0, #48]
	vldrw.U32 q2, [r11, #48]
	umaal	r2, r3, r4, r5
	vmla.S16 q0, q5, r12
	umaal	r2, r3, r4, r5
	vsub.U16 q5, q3, q7
	ldr	r4, [r0, #64]
	vmul.S16 q7, q5, q1
	umaal	r2, r3, r4, r5
	vsub.U16 q1, q6, q4
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q2, q5, q2
	str	r5, [r0, #80]
	vadd.U16 q4, q6, q4
	umaal	r2, r3, r4, r5
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q5, q1, q6
	ldr	r4, [r0, #0]
	vsub.U16 q2, q7, q0
	umaal	r2, r3, r4, r5
	vqrdmulh.S16 q6, q2, q6
	umaal	r2, r3, r4, r5
	vldrw.U32 q3, [r11], #(3*32)
	str	r5, [r0, #16]
	vmul.S16 q2, q2, q3
	umaal	r2, r3, r4, r5
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	umaal	r2, r3, r4, r5
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	ldr	r4, [r0, #0]
	vldrw.U32 q3, [r7, #32]
	umaal	r2, r3, r4, r5
	vmla.S16 q1, q5, r12
	umaal	r2, r3, r4, r5
	vadd.U16 q5, q7, q0
	str	r5, [r0, #16]
	vqrdmulh.S16 q4, q3, r9
	umaal	r2, r3, r4, r5
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	umaal	r2, r3, r4, r5
	vstrw.U32 q5, [r7, #-48]
	CE_EPI
	.size	expce_c_r32, .-expce_c_r32
	.ltorg
