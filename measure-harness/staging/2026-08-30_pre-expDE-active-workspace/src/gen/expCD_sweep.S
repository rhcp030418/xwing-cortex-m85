/* 실험 CD: 은닉 용량 곡선 — lane 1..8.
 * 사전등록: 2026-08-27_expCD_prereg.md
 * 커널 17종이라 ITCM 예산을 넘어 **전부 .text** 에 둔다(사전등록 §4-1).
 * A/B/C 가 모두 같은 섹션이므로 비율 판정은 성립한다.
 */
	.syntax unified
	.thumb
	.text
	.align 2

	.macro CD_PRO
	push	{r4-r12, lr}
	mov	r7, r2
	mov	r11, r3
	movw	r8, #3329
	movw	r9, #20159
	movw	r12, #3329
	/* q0-q7 을 결정적으로 채운다. layer67 본문의 첫 vmla 가 이전 iteration 의
	 * q3/q4 를 쓰므로, 이것이 없으면 첫 64 B 출력이 호출 직전 상태에 좌우된다. */
	vldrw.u32	q0, [r3]
	vldrw.u32	q1, [r3, #16]
	vldrw.u32	q2, [r3, #32]
	vldrw.u32	q3, [r3, #48]
	vldrw.u32	q4, [r3, #64]
	vldrw.u32	q5, [r3, #80]
	vldrw.u32	q6, [r3, #96]
	vldrw.u32	q7, [r3, #112]
	.endm

	.macro CD_EPI
	pop	{r4-r12, pc}
	.endm

	.balign 16
	.type	expcd_a, %function
	.global	expcd_a
expcd_a:
	CD_PRO
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
	CD_EPI
	.size	expcd_a, .-expcd_a
	.balign 16
	.type	expcd_b1, %function
	.global	expcd_b1
expcd_b1:
	CD_PRO
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	CD_EPI
	.size	expcd_b1, .-expcd_b1
	.balign 16
	.type	expcd_c1, %function
	.global	expcd_c1
expcd_c1:
	CD_PRO
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	vldrw.U32 q1, [r7, #16]
	vqrdmulh.S16 q6, q7, r9
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q0, [r7]
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	movs	r3, r4
	vmul.S16 q7, q1, r8
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	vmul.S16 q3, q0, r8
	bfi	r4, r5, #16, #16
	vldrw.U32 q1, [r11, #32]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r11, #80]
	bfc	r5, #0, #16
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r11, #48]
	orr	r5, r5, r3, LSR #16
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	eor	r3, r4, r4, LSR #8
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	vqrdmulh.S16 q5, q1, q6
	eor	r6, r5, r5, LSR #8
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r11], #(3*32)
	vmul.S16 q2, q2, q3
	and	r3, r3, #0x0000FF00
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r7, #32]
	vmla.S16 q1, q5, r12
	and	r6, r6, #0x0000FF00
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	eors	r4, r4, r3
	vmul.S16 q4, q7, r8
	vldrw.U32 q1, [r7, #16]
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r7]
	eors	r5, r5, r6
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	vmul.S16 q7, q1, r8
	eor	r4, r4, r3, LSL #8
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	vmul.S16 q3, q0, r8
	vldrw.U32 q1, [r11, #32]
	eor	r5, r5, r6, LSL #8
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r11, #80]
	vmul.S16 q0, q5, q0
	eor	r3, r4, r4, LSR #4
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r11, #48]
	vmla.S16 q0, q5, r12
	eor	r6, r5, r5, LSR #4
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	and	r3, r3, #0x00F000F0
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	and	r6, r6, #0x00F000F0
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r11], #(3*32)
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eors	r4, r4, r3
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r7, #32]
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	eors	r5, r5, r6
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	eor	r4, r4, r3, LSL #4
	vldrw.U32 q1, [r7, #16]
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r7]
	vmla.S16 q4, q6, r12
	eor	r5, r5, r6, LSL #4
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	vmul.S16 q7, q1, r8
	vadd.U16 q4, q3, q4
	eor	r3, r4, r4, LSR #2
	vmla.S16 q7, q6, r12
	vmul.S16 q3, q0, r8
	vldrw.U32 q1, [r11, #32]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	eor	r6, r5, r5, LSR #2
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r11, #80]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	and	r3, r3, #0x0C0C0C0C
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r11, #48]
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	and	r6, r6, #0x0C0C0C0C
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	eors	r4, r4, r3
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	eors	r5, r5, r6
	vldrw.U32 q3, [r11], #(3*32)
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eor	r4, r4, r3, LSL #2
	vldrw.U32 q3, [r7, #32]
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	eor	r5, r5, r6, LSL #2
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	vldrw.U32 q1, [r7, #16]
	eor	r3, r4, r4, LSR #1
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r7]
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	eor	r6, r5, r5, LSR #1
	vsub.U16 q5, q3, q4
	vmul.S16 q7, q1, r8
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	and	r3, r3, #0x22222222
	vmul.S16 q3, q0, r8
	vldrw.U32 q1, [r11, #32]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	vmla.S16 q3, q2, r12
	and	r6, r6, #0x22222222
	vldrw.U32 q2, [r11, #80]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	eors	r4, r4, r3
	vldrw.U32 q2, [r11, #48]
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	eors	r5, r5, r6
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	eor	r4, r4, r3, LSL #1
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r11], #(3*32)
	eor	r5, r5, r6, LSL #1
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r7, #32]
	str	r4, [r1], #4
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r5, [r1], #4
	vstrw.U32 q5, [r7, #-48]
	CD_EPI
	.size	expcd_c1, .-expcd_c1
	.balign 16
	.type	expcd_b2, %function
	.global	expcd_b2
expcd_b2:
	CD_PRO
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	CD_EPI
	.size	expcd_b2, .-expcd_b2
	.balign 16
	.type	expcd_c2, %function
	.global	expcd_c2
expcd_c2:
	CD_PRO
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q1, [r7, #16]
	vqrdmulh.S16 q6, q7, r9
	movs	r3, r4
	vldrw.U32 q0, [r7]
	vmla.S16 q4, q6, r12
	bfi	r4, r5, #16, #16
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	bfc	r5, #0, #16
	vmul.S16 q7, q1, r8
	vadd.U16 q4, q3, q4
	orr	r5, r5, r3, LSR #16
	vmla.S16 q7, q6, r12
	vmul.S16 q3, q0, r8
	eor	r3, r4, r4, LSR #8
	vldrw.U32 q1, [r11, #32]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	eor	r6, r5, r5, LSR #8
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r11, #80]
	and	r3, r3, #0x0000FF00
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	and	r6, r6, #0x0000FF00
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r11, #48]
	eors	r4, r4, r3
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	eors	r5, r5, r6
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	eor	r4, r4, r3, LSL #8
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	eor	r5, r5, r6, LSL #8
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	vqrdmulh.S16 q5, q1, q6
	eor	r3, r4, r4, LSR #4
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	eor	r6, r5, r5, LSR #4
	vldrw.U32 q3, [r11], #(3*32)
	vmul.S16 q2, q2, q3
	and	r3, r3, #0x00F000F0
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	and	r6, r6, #0x00F000F0
	vldrw.U32 q3, [r7, #32]
	vmla.S16 q1, q5, r12
	eors	r4, r4, r3
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	eors	r5, r5, r6
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	eor	r4, r4, r3, LSL #4
	vmul.S16 q4, q7, r8
	vldrw.U32 q1, [r7, #16]
	eor	r5, r5, r6, LSL #4
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r7]
	eor	r3, r4, r4, LSR #2
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	eor	r6, r5, r5, LSR #2
	vsub.U16 q5, q3, q4
	vmul.S16 q7, q1, r8
	and	r3, r3, #0x0C0C0C0C
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	and	r6, r6, #0x0C0C0C0C
	vmul.S16 q3, q0, r8
	vldrw.U32 q1, [r11, #32]
	eors	r4, r4, r3
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	vmla.S16 q3, q2, r12
	eors	r5, r5, r6
	vldrw.U32 q2, [r11, #80]
	vmul.S16 q0, q5, q0
	eor	r4, r4, r3, LSL #2
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	eor	r5, r5, r6, LSL #2
	vldrw.U32 q2, [r11, #48]
	vmla.S16 q0, q5, r12
	eor	r3, r4, r4, LSR #1
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	eor	r6, r5, r5, LSR #1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	and	r3, r3, #0x22222222
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	and	r6, r6, #0x22222222
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	eors	r4, r4, r3
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r11], #(3*32)
	eors	r5, r5, r6
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eor	r4, r4, r3, LSL #1
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r7, #32]
	eor	r5, r5, r6, LSL #1
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	str	r4, [r1], #4
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r5, [r1], #4
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q1, [r7, #16]
	vqrdmulh.S16 q6, q7, r9
	movs	r3, r4
	vldrw.U32 q0, [r7]
	vmla.S16 q4, q6, r12
	bfi	r4, r5, #16, #16
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	bfc	r5, #0, #16
	vmul.S16 q7, q1, r8
	vadd.U16 q4, q3, q4
	orr	r5, r5, r3, LSR #16
	vmla.S16 q7, q6, r12
	vmul.S16 q3, q0, r8
	eor	r3, r4, r4, LSR #8
	vldrw.U32 q1, [r11, #32]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	eor	r6, r5, r5, LSR #8
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r11, #80]
	and	r3, r3, #0x0000FF00
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	and	r6, r6, #0x0000FF00
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r11, #48]
	eors	r4, r4, r3
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	eors	r5, r5, r6
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	eor	r4, r4, r3, LSL #8
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	eor	r5, r5, r6, LSL #8
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	vqrdmulh.S16 q5, q1, q6
	eor	r3, r4, r4, LSR #4
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	eor	r6, r5, r5, LSR #4
	vldrw.U32 q3, [r11], #(3*32)
	vmul.S16 q2, q2, q3
	and	r3, r3, #0x00F000F0
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	and	r6, r6, #0x00F000F0
	vldrw.U32 q3, [r7, #32]
	vmla.S16 q1, q5, r12
	eors	r4, r4, r3
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	eors	r5, r5, r6
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	eor	r4, r4, r3, LSL #4
	vmul.S16 q4, q7, r8
	vldrw.U32 q1, [r7, #16]
	eor	r5, r5, r6, LSL #4
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r7]
	eor	r3, r4, r4, LSR #2
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	eor	r6, r5, r5, LSR #2
	vsub.U16 q5, q3, q4
	vmul.S16 q7, q1, r8
	and	r3, r3, #0x0C0C0C0C
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	and	r6, r6, #0x0C0C0C0C
	vmul.S16 q3, q0, r8
	vldrw.U32 q1, [r11, #32]
	eors	r4, r4, r3
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	vmla.S16 q3, q2, r12
	eors	r5, r5, r6
	vldrw.U32 q2, [r11, #80]
	vmul.S16 q0, q5, q0
	eor	r4, r4, r3, LSL #2
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	eor	r5, r5, r6, LSL #2
	vldrw.U32 q2, [r11, #48]
	vmla.S16 q0, q5, r12
	eor	r3, r4, r4, LSR #1
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	eor	r6, r5, r5, LSR #1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	and	r3, r3, #0x22222222
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	and	r6, r6, #0x22222222
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	eors	r4, r4, r3
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r11], #(3*32)
	eors	r5, r5, r6
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eor	r4, r4, r3, LSL #1
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r7, #32]
	eor	r5, r5, r6, LSL #1
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	str	r4, [r1], #4
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r5, [r1], #4
	vstrw.U32 q5, [r7, #-48]
	CD_EPI
	.size	expcd_c2, .-expcd_c2
	.balign 16
	.type	expcd_b3, %function
	.global	expcd_b3
expcd_b3:
	CD_PRO
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	CD_EPI
	.size	expcd_b3, .-expcd_b3
	.balign 16
	.type	expcd_c3, %function
	.global	expcd_c3
expcd_c3:
	CD_PRO
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	vldrw.U32 q1, [r7, #16]
	vqrdmulh.S16 q6, q7, r9
	bfi	r4, r5, #16, #16
	vldrw.U32 q0, [r7]
	bfc	r5, #0, #16
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	orr	r5, r5, r3, LSR #16
	vsub.U16 q5, q3, q4
	eor	r3, r4, r4, LSR #8
	vmul.S16 q7, q1, r8
	vadd.U16 q4, q3, q4
	eor	r6, r5, r5, LSR #8
	vmla.S16 q7, q6, r12
	and	r3, r3, #0x0000FF00
	vmul.S16 q3, q0, r8
	and	r6, r6, #0x0000FF00
	vldrw.U32 q1, [r11, #32]
	vqrdmulh.S16 q2, q0, r9
	eors	r4, r4, r3
	vldrw.U32 q0, [r11, #64]
	eors	r5, r5, r6
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r11, #80]
	eor	r4, r4, r3, LSL #8
	vmul.S16 q0, q5, q0
	eor	r5, r5, r6, LSL #8
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	eor	r3, r4, r4, LSR #4
	vldrw.U32 q2, [r11, #48]
	eor	r6, r5, r5, LSR #4
	vmla.S16 q0, q5, r12
	and	r3, r3, #0x00F000F0
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	and	r6, r6, #0x00F000F0
	vsub.U16 q1, q6, q4
	eors	r4, r4, r3
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	eors	r5, r5, r6
	vmla.S16 q7, q2, r12
	eor	r4, r4, r3, LSL #4
	vldrw.U32 q6, [r11, #16]
	vqrdmulh.S16 q5, q1, q6
	eor	r5, r5, r6, LSL #4
	vsub.U16 q2, q7, q0
	eor	r3, r4, r4, LSR #2
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r11], #(3*32)
	eor	r6, r5, r5, LSR #2
	vmul.S16 q2, q2, q3
	and	r3, r3, #0x0C0C0C0C
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	and	r6, r6, #0x0C0C0C0C
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r7, #32]
	eors	r4, r4, r3
	vmla.S16 q1, q5, r12
	eors	r5, r5, r6
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	eor	r4, r4, r3, LSL #2
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	eor	r5, r5, r6, LSL #2
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	eor	r3, r4, r4, LSR #1
	vmul.S16 q4, q7, r8
	eor	r6, r5, r5, LSR #1
	vldrw.U32 q1, [r7, #16]
	and	r3, r3, #0x22222222
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r7]
	and	r6, r6, #0x22222222
	vmla.S16 q4, q6, r12
	eors	r4, r4, r3
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	eors	r5, r5, r6
	vmul.S16 q7, q1, r8
	eor	r4, r4, r3, LSL #1
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	eor	r5, r5, r6, LSL #1
	vmul.S16 q3, q0, r8
	str	r4, [r1], #4
	vldrw.U32 q1, [r11, #32]
	vqrdmulh.S16 q2, q0, r9
	str	r5, [r1], #4
	vldrw.U32 q0, [r11, #64]
	vmla.S16 q3, q2, r12
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	vldrw.U32 q2, [r11, #80]
	vmul.S16 q0, q5, q0
	bfi	r4, r5, #16, #16
	vadd.U16 q6, q3, q7
	bfc	r5, #0, #16
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r11, #48]
	orr	r5, r5, r3, LSR #16
	vmla.S16 q0, q5, r12
	eor	r3, r4, r4, LSR #8
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	eor	r6, r5, r5, LSR #8
	vsub.U16 q1, q6, q4
	and	r3, r3, #0x0000FF00
	vqrdmulh.S16 q2, q5, q2
	and	r6, r6, #0x0000FF00
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	eors	r4, r4, r3
	vldrw.U32 q6, [r11, #16]
	eors	r5, r5, r6
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	eor	r4, r4, r3, LSL #8
	vqrdmulh.S16 q6, q2, q6
	eor	r5, r5, r6, LSL #8
	vldrw.U32 q3, [r11], #(3*32)
	vmul.S16 q2, q2, q3
	eor	r3, r4, r4, LSR #4
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eor	r6, r5, r5, LSR #4
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	and	r3, r3, #0x00F000F0
	vldrw.U32 q3, [r7, #32]
	vmla.S16 q1, q5, r12
	and	r6, r6, #0x00F000F0
	vadd.U16 q5, q7, q0
	eors	r4, r4, r3
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	eors	r5, r5, r6
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	eor	r4, r4, r3, LSL #4
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	eor	r5, r5, r6, LSL #4
	vldrw.U32 q1, [r7, #16]
	eor	r3, r4, r4, LSR #2
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r7]
	eor	r6, r5, r5, LSR #2
	vmla.S16 q4, q6, r12
	and	r3, r3, #0x0C0C0C0C
	vqrdmulh.S16 q6, q1, r9
	and	r6, r6, #0x0C0C0C0C
	vsub.U16 q5, q3, q4
	vmul.S16 q7, q1, r8
	eors	r4, r4, r3
	vadd.U16 q4, q3, q4
	eors	r5, r5, r6
	vmla.S16 q7, q6, r12
	vmul.S16 q3, q0, r8
	eor	r4, r4, r3, LSL #2
	vldrw.U32 q1, [r11, #32]
	eor	r5, r5, r6, LSL #2
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	eor	r3, r4, r4, LSR #1
	vmla.S16 q3, q2, r12
	eor	r6, r5, r5, LSR #1
	vldrw.U32 q2, [r11, #80]
	and	r3, r3, #0x22222222
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	and	r6, r6, #0x22222222
	vqrdmulh.S16 q5, q5, q2
	eors	r4, r4, r3
	vldrw.U32 q2, [r11, #48]
	vmla.S16 q0, q5, r12
	eors	r5, r5, r6
	vsub.U16 q5, q3, q7
	eor	r4, r4, r3, LSL #1
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	eor	r5, r5, r6, LSL #1
	vqrdmulh.S16 q2, q5, q2
	str	r4, [r1], #4
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	str	r5, [r1], #4
	vldrw.U32 q6, [r11, #16]
	vqrdmulh.S16 q5, q1, q6
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	bfi	r4, r5, #16, #16
	vldrw.U32 q3, [r11], #(3*32)
	bfc	r5, #0, #16
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	orr	r5, r5, r3, LSR #16
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eor	r3, r4, r4, LSR #8
	vldrw.U32 q3, [r7, #32]
	vmla.S16 q1, q5, r12
	eor	r6, r5, r5, LSR #8
	vadd.U16 q5, q7, q0
	and	r3, r3, #0x0000FF00
	vqrdmulh.S16 q4, q3, r9
	and	r6, r6, #0x0000FF00
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	eors	r4, r4, r3
	vldrw.U32 q7, [r7, #48]
	eors	r5, r5, r6
	vmul.S16 q4, q7, r8
	vldrw.U32 q1, [r7, #16]
	eor	r4, r4, r3, LSL #8
	vqrdmulh.S16 q6, q7, r9
	eor	r5, r5, r6, LSL #8
	vldrw.U32 q0, [r7]
	vmla.S16 q4, q6, r12
	eor	r3, r4, r4, LSR #4
	vqrdmulh.S16 q6, q1, r9
	eor	r6, r5, r5, LSR #4
	vsub.U16 q5, q3, q4
	and	r3, r3, #0x00F000F0
	vmul.S16 q7, q1, r8
	vadd.U16 q4, q3, q4
	and	r6, r6, #0x00F000F0
	vmla.S16 q7, q6, r12
	eors	r4, r4, r3
	vmul.S16 q3, q0, r8
	vldrw.U32 q1, [r11, #32]
	eors	r5, r5, r6
	vqrdmulh.S16 q2, q0, r9
	eor	r4, r4, r3, LSL #4
	vldrw.U32 q0, [r11, #64]
	vmla.S16 q3, q2, r12
	eor	r5, r5, r6, LSL #4
	vldrw.U32 q2, [r11, #80]
	eor	r3, r4, r4, LSR #2
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	eor	r6, r5, r5, LSR #2
	vqrdmulh.S16 q5, q5, q2
	and	r3, r3, #0x0C0C0C0C
	vldrw.U32 q2, [r11, #48]
	and	r6, r6, #0x0C0C0C0C
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	eors	r4, r4, r3
	vmul.S16 q7, q5, q1
	eors	r5, r5, r6
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	eor	r4, r4, r3, LSL #2
	vadd.U16 q4, q6, q4
	eor	r5, r5, r6, LSL #2
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	eor	r3, r4, r4, LSR #1
	vqrdmulh.S16 q5, q1, q6
	eor	r6, r5, r5, LSR #1
	vsub.U16 q2, q7, q0
	and	r3, r3, #0x22222222
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r11], #(3*32)
	and	r6, r6, #0x22222222
	vmul.S16 q2, q2, q3
	eors	r4, r4, r3
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eors	r5, r5, r6
	vldrw.U32 q3, [r7, #32]
	eor	r4, r4, r3, LSL #1
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	eor	r5, r5, r6, LSL #1
	vqrdmulh.S16 q4, q3, r9
	str	r4, [r1], #4
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	vstrw.U32 q5, [r7, #-48]
	str	r5, [r1], #4
	CD_EPI
	.size	expcd_c3, .-expcd_c3
	.balign 16
	.type	expcd_b4, %function
	.global	expcd_b4
expcd_b4:
	CD_PRO
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	CD_EPI
	.size	expcd_b4, .-expcd_b4
	.balign 16
	.type	expcd_c4, %function
	.global	expcd_c4
expcd_c4:
	CD_PRO
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	vldrw.U32 q1, [r7, #16]
	bfi	r4, r5, #16, #16
	vqrdmulh.S16 q6, q7, r9
	bfc	r5, #0, #16
	vldrw.U32 q0, [r7]
	orr	r5, r5, r3, LSR #16
	vmla.S16 q4, q6, r12
	eor	r3, r4, r4, LSR #8
	vqrdmulh.S16 q6, q1, r9
	eor	r6, r5, r5, LSR #8
	vsub.U16 q5, q3, q4
	and	r3, r3, #0x0000FF00
	vmul.S16 q7, q1, r8
	and	r6, r6, #0x0000FF00
	vadd.U16 q4, q3, q4
	eors	r4, r4, r3
	vmla.S16 q7, q6, r12
	eors	r5, r5, r6
	vmul.S16 q3, q0, r8
	eor	r4, r4, r3, LSL #8
	vldrw.U32 q1, [r11, #32]
	eor	r5, r5, r6, LSL #8
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	eor	r3, r4, r4, LSR #4
	vmla.S16 q3, q2, r12
	eor	r6, r5, r5, LSR #4
	vldrw.U32 q2, [r11, #80]
	and	r3, r3, #0x00F000F0
	vmul.S16 q0, q5, q0
	and	r6, r6, #0x00F000F0
	vadd.U16 q6, q3, q7
	eors	r4, r4, r3
	vqrdmulh.S16 q5, q5, q2
	eors	r5, r5, r6
	vldrw.U32 q2, [r11, #48]
	eor	r4, r4, r3, LSL #4
	vmla.S16 q0, q5, r12
	eor	r5, r5, r6, LSL #4
	vsub.U16 q5, q3, q7
	eor	r3, r4, r4, LSR #2
	vmul.S16 q7, q5, q1
	eor	r6, r5, r5, LSR #2
	vsub.U16 q1, q6, q4
	and	r3, r3, #0x0C0C0C0C
	vqrdmulh.S16 q2, q5, q2
	and	r6, r6, #0x0C0C0C0C
	vadd.U16 q4, q6, q4
	eors	r4, r4, r3
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	eors	r5, r5, r6
	vqrdmulh.S16 q5, q1, q6
	eor	r4, r4, r3, LSL #2
	vsub.U16 q2, q7, q0
	eor	r5, r5, r6, LSL #2
	vqrdmulh.S16 q6, q2, q6
	eor	r3, r4, r4, LSR #1
	vldrw.U32 q3, [r11], #(3*32)
	eor	r6, r5, r5, LSR #1
	vmul.S16 q2, q2, q3
	and	r3, r3, #0x22222222
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	and	r6, r6, #0x22222222
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eors	r4, r4, r3
	vldrw.U32 q3, [r7, #32]
	eors	r5, r5, r6
	vmla.S16 q1, q5, r12
	eor	r4, r4, r3, LSL #1
	vadd.U16 q5, q7, q0
	eor	r5, r5, r6, LSL #1
	vqrdmulh.S16 q4, q3, r9
	str	r4, [r1], #4
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r5, [r1], #4
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	vldrw.U32 q1, [r7, #16]
	bfi	r4, r5, #16, #16
	vqrdmulh.S16 q6, q7, r9
	bfc	r5, #0, #16
	vldrw.U32 q0, [r7]
	orr	r5, r5, r3, LSR #16
	vmla.S16 q4, q6, r12
	eor	r3, r4, r4, LSR #8
	vqrdmulh.S16 q6, q1, r9
	eor	r6, r5, r5, LSR #8
	vsub.U16 q5, q3, q4
	and	r3, r3, #0x0000FF00
	vmul.S16 q7, q1, r8
	and	r6, r6, #0x0000FF00
	vadd.U16 q4, q3, q4
	eors	r4, r4, r3
	vmla.S16 q7, q6, r12
	eors	r5, r5, r6
	vmul.S16 q3, q0, r8
	eor	r4, r4, r3, LSL #8
	vldrw.U32 q1, [r11, #32]
	eor	r5, r5, r6, LSL #8
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	eor	r3, r4, r4, LSR #4
	vmla.S16 q3, q2, r12
	eor	r6, r5, r5, LSR #4
	vldrw.U32 q2, [r11, #80]
	and	r3, r3, #0x00F000F0
	vmul.S16 q0, q5, q0
	and	r6, r6, #0x00F000F0
	vadd.U16 q6, q3, q7
	eors	r4, r4, r3
	vqrdmulh.S16 q5, q5, q2
	eors	r5, r5, r6
	vldrw.U32 q2, [r11, #48]
	eor	r4, r4, r3, LSL #4
	vmla.S16 q0, q5, r12
	eor	r5, r5, r6, LSL #4
	vsub.U16 q5, q3, q7
	eor	r3, r4, r4, LSR #2
	vmul.S16 q7, q5, q1
	eor	r6, r5, r5, LSR #2
	vsub.U16 q1, q6, q4
	and	r3, r3, #0x0C0C0C0C
	vqrdmulh.S16 q2, q5, q2
	and	r6, r6, #0x0C0C0C0C
	vadd.U16 q4, q6, q4
	eors	r4, r4, r3
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	eors	r5, r5, r6
	vqrdmulh.S16 q5, q1, q6
	eor	r4, r4, r3, LSL #2
	vsub.U16 q2, q7, q0
	eor	r5, r5, r6, LSL #2
	vqrdmulh.S16 q6, q2, q6
	eor	r3, r4, r4, LSR #1
	vldrw.U32 q3, [r11], #(3*32)
	eor	r6, r5, r5, LSR #1
	vmul.S16 q2, q2, q3
	and	r3, r3, #0x22222222
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	and	r6, r6, #0x22222222
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eors	r4, r4, r3
	vldrw.U32 q3, [r7, #32]
	eors	r5, r5, r6
	vmla.S16 q1, q5, r12
	eor	r4, r4, r3, LSL #1
	vadd.U16 q5, q7, q0
	eor	r5, r5, r6, LSL #1
	vqrdmulh.S16 q4, q3, r9
	str	r4, [r1], #4
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r5, [r1], #4
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	vldrw.U32 q1, [r7, #16]
	bfi	r4, r5, #16, #16
	vqrdmulh.S16 q6, q7, r9
	bfc	r5, #0, #16
	vldrw.U32 q0, [r7]
	orr	r5, r5, r3, LSR #16
	vmla.S16 q4, q6, r12
	eor	r3, r4, r4, LSR #8
	vqrdmulh.S16 q6, q1, r9
	eor	r6, r5, r5, LSR #8
	vsub.U16 q5, q3, q4
	and	r3, r3, #0x0000FF00
	vmul.S16 q7, q1, r8
	and	r6, r6, #0x0000FF00
	vadd.U16 q4, q3, q4
	eors	r4, r4, r3
	vmla.S16 q7, q6, r12
	eors	r5, r5, r6
	vmul.S16 q3, q0, r8
	eor	r4, r4, r3, LSL #8
	vldrw.U32 q1, [r11, #32]
	eor	r5, r5, r6, LSL #8
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	eor	r3, r4, r4, LSR #4
	vmla.S16 q3, q2, r12
	eor	r6, r5, r5, LSR #4
	vldrw.U32 q2, [r11, #80]
	and	r3, r3, #0x00F000F0
	vmul.S16 q0, q5, q0
	and	r6, r6, #0x00F000F0
	vadd.U16 q6, q3, q7
	eors	r4, r4, r3
	vqrdmulh.S16 q5, q5, q2
	eors	r5, r5, r6
	vldrw.U32 q2, [r11, #48]
	eor	r4, r4, r3, LSL #4
	vmla.S16 q0, q5, r12
	eor	r5, r5, r6, LSL #4
	vsub.U16 q5, q3, q7
	eor	r3, r4, r4, LSR #2
	vmul.S16 q7, q5, q1
	eor	r6, r5, r5, LSR #2
	vsub.U16 q1, q6, q4
	and	r3, r3, #0x0C0C0C0C
	vqrdmulh.S16 q2, q5, q2
	and	r6, r6, #0x0C0C0C0C
	vadd.U16 q4, q6, q4
	eors	r4, r4, r3
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	eors	r5, r5, r6
	vqrdmulh.S16 q5, q1, q6
	eor	r4, r4, r3, LSL #2
	vsub.U16 q2, q7, q0
	eor	r5, r5, r6, LSL #2
	vqrdmulh.S16 q6, q2, q6
	eor	r3, r4, r4, LSR #1
	vldrw.U32 q3, [r11], #(3*32)
	eor	r6, r5, r5, LSR #1
	vmul.S16 q2, q2, q3
	and	r3, r3, #0x22222222
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	and	r6, r6, #0x22222222
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eors	r4, r4, r3
	vldrw.U32 q3, [r7, #32]
	eors	r5, r5, r6
	vmla.S16 q1, q5, r12
	eor	r4, r4, r3, LSL #1
	vadd.U16 q5, q7, q0
	eor	r5, r5, r6, LSL #1
	vqrdmulh.S16 q4, q3, r9
	str	r4, [r1], #4
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r5, [r1], #4
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r7, #48]
	vmul.S16 q4, q7, r8
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	vldrw.U32 q1, [r7, #16]
	bfi	r4, r5, #16, #16
	vqrdmulh.S16 q6, q7, r9
	bfc	r5, #0, #16
	vldrw.U32 q0, [r7]
	orr	r5, r5, r3, LSR #16
	vmla.S16 q4, q6, r12
	eor	r3, r4, r4, LSR #8
	vqrdmulh.S16 q6, q1, r9
	eor	r6, r5, r5, LSR #8
	vsub.U16 q5, q3, q4
	and	r3, r3, #0x0000FF00
	vmul.S16 q7, q1, r8
	and	r6, r6, #0x0000FF00
	vadd.U16 q4, q3, q4
	eors	r4, r4, r3
	vmla.S16 q7, q6, r12
	eors	r5, r5, r6
	vmul.S16 q3, q0, r8
	eor	r4, r4, r3, LSL #8
	vldrw.U32 q1, [r11, #32]
	eor	r5, r5, r6, LSL #8
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r11, #64]
	eor	r3, r4, r4, LSR #4
	vmla.S16 q3, q2, r12
	eor	r6, r5, r5, LSR #4
	vldrw.U32 q2, [r11, #80]
	and	r3, r3, #0x00F000F0
	vmul.S16 q0, q5, q0
	and	r6, r6, #0x00F000F0
	vadd.U16 q6, q3, q7
	eors	r4, r4, r3
	vqrdmulh.S16 q5, q5, q2
	eors	r5, r5, r6
	vldrw.U32 q2, [r11, #48]
	eor	r4, r4, r3, LSL #4
	vmla.S16 q0, q5, r12
	eor	r5, r5, r6, LSL #4
	vsub.U16 q5, q3, q7
	eor	r3, r4, r4, LSR #2
	vmul.S16 q7, q5, q1
	eor	r6, r5, r5, LSR #2
	vsub.U16 q1, q6, q4
	and	r3, r3, #0x0C0C0C0C
	vqrdmulh.S16 q2, q5, q2
	and	r6, r6, #0x0C0C0C0C
	vadd.U16 q4, q6, q4
	eors	r4, r4, r3
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r11, #16]
	eors	r5, r5, r6
	vqrdmulh.S16 q5, q1, q6
	eor	r4, r4, r3, LSL #2
	vsub.U16 q2, q7, q0
	eor	r5, r5, r6, LSL #2
	vqrdmulh.S16 q6, q2, q6
	eor	r3, r4, r4, LSR #1
	vldrw.U32 q3, [r11], #(3*32)
	eor	r6, r5, r5, LSR #1
	vmul.S16 q2, q2, q3
	and	r3, r3, #0x22222222
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	and	r6, r6, #0x22222222
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eors	r4, r4, r3
	vldrw.U32 q3, [r7, #32]
	eors	r5, r5, r6
	vmla.S16 q1, q5, r12
	eor	r4, r4, r3, LSL #1
	vadd.U16 q5, q7, q0
	eor	r5, r5, r6, LSL #1
	vqrdmulh.S16 q4, q3, r9
	str	r4, [r1], #4
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r5, [r1], #4
	vstrw.U32 q5, [r7, #-48]
	CD_EPI
	.size	expcd_c4, .-expcd_c4
	.balign 16
	.type	expcd_b5, %function
	.global	expcd_b5
expcd_b5:
	CD_PRO
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	CD_EPI
	.size	expcd_b5, .-expcd_b5
	.balign 16
	.type	expcd_c5, %function
	.global	expcd_c5
expcd_c5:
	CD_PRO
	vmla.S16 q3, q4, r12
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q7, [r7, #48]
	movs	r3, r4
	vmul.S16 q4, q7, r8
	bfi	r4, r5, #16, #16
	vldrw.U32 q1, [r7, #16]
	bfc	r5, #0, #16
	vqrdmulh.S16 q6, q7, r9
	orr	r5, r5, r3, LSR #16
	vldrw.U32 q0, [r7]
	eor	r3, r4, r4, LSR #8
	vmla.S16 q4, q6, r12
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vqrdmulh.S16 q6, q1, r9
	and	r6, r6, #0x0000FF00
	vsub.U16 q5, q3, q4
	eors	r4, r4, r3
	vmul.S16 q7, q1, r8
	eors	r5, r5, r6
	vadd.U16 q4, q3, q4
	eor	r4, r4, r3, LSL #8
	vmla.S16 q7, q6, r12
	eor	r5, r5, r6, LSL #8
	vmul.S16 q3, q0, r8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	vldrw.U32 q1, [r11, #32]
	and	r3, r3, #0x00F000F0
	vqrdmulh.S16 q2, q0, r9
	and	r6, r6, #0x00F000F0
	vldrw.U32 q0, [r11, #64]
	eors	r4, r4, r3
	vmla.S16 q3, q2, r12
	eors	r5, r5, r6
	vldrw.U32 q2, [r11, #80]
	eor	r4, r4, r3, LSL #4
	vmul.S16 q0, q5, q0
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vadd.U16 q6, q3, q7
	eor	r6, r5, r5, LSR #2
	vqrdmulh.S16 q5, q5, q2
	and	r3, r3, #0x0C0C0C0C
	vldrw.U32 q2, [r11, #48]
	and	r6, r6, #0x0C0C0C0C
	vmla.S16 q0, q5, r12
	eors	r4, r4, r3
	vsub.U16 q5, q3, q7
	eors	r5, r5, r6
	vmul.S16 q7, q5, q1
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vsub.U16 q1, q6, q4
	eor	r3, r4, r4, LSR #1
	vqrdmulh.S16 q2, q5, q2
	eor	r6, r5, r5, LSR #1
	vadd.U16 q4, q6, q4
	and	r3, r3, #0x22222222
	vmla.S16 q7, q2, r12
	and	r6, r6, #0x22222222
	vldrw.U32 q6, [r11, #16]
	eors	r4, r4, r3
	vqrdmulh.S16 q5, q1, q6
	eors	r5, r5, r6
	vsub.U16 q2, q7, q0
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vqrdmulh.S16 q6, q2, q6
	str	r4, [r1], #4
	vldrw.U32 q3, [r11], #(3*32)
	str	r5, [r1], #4
	vmul.S16 q2, q2, q3
	ldrd	r4, r5, [r0], #8
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	movs	r3, r4
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	bfi	r4, r5, #16, #16
	vldrw.U32 q3, [r7, #32]
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vmla.S16 q1, q5, r12
	eor	r3, r4, r4, LSR #8
	vadd.U16 q5, q7, q0
	eor	r6, r5, r5, LSR #8
	vqrdmulh.S16 q4, q3, r9
	and	r3, r3, #0x0000FF00
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	and	r6, r6, #0x0000FF00
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	eors	r4, r4, r3
	vldrw.U32 q7, [r7, #48]
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	vmul.S16 q4, q7, r8
	eor	r5, r5, r6, LSL #8
	vldrw.U32 q1, [r7, #16]
	eor	r3, r4, r4, LSR #4
	vqrdmulh.S16 q6, q7, r9
	eor	r6, r5, r5, LSR #4
	vldrw.U32 q0, [r7]
	and	r3, r3, #0x00F000F0
	vmla.S16 q4, q6, r12
	and	r6, r6, #0x00F000F0
	vqrdmulh.S16 q6, q1, r9
	eors	r4, r4, r3
	eors	r5, r5, r6
	vsub.U16 q5, q3, q4
	eor	r4, r4, r3, LSL #4
	vmul.S16 q7, q1, r8
	eor	r5, r5, r6, LSL #4
	vadd.U16 q4, q3, q4
	eor	r3, r4, r4, LSR #2
	vmla.S16 q7, q6, r12
	eor	r6, r5, r5, LSR #2
	vmul.S16 q3, q0, r8
	and	r3, r3, #0x0C0C0C0C
	vldrw.U32 q1, [r11, #32]
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vqrdmulh.S16 q2, q0, r9
	eors	r5, r5, r6
	vldrw.U32 q0, [r11, #64]
	eor	r4, r4, r3, LSL #2
	vmla.S16 q3, q2, r12
	eor	r5, r5, r6, LSL #2
	vldrw.U32 q2, [r11, #80]
	eor	r3, r4, r4, LSR #1
	vmul.S16 q0, q5, q0
	eor	r6, r5, r5, LSR #1
	vadd.U16 q6, q3, q7
	and	r3, r3, #0x22222222
	vqrdmulh.S16 q5, q5, q2
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	vldrw.U32 q2, [r11, #48]
	eors	r5, r5, r6
	vmla.S16 q0, q5, r12
	eor	r4, r4, r3, LSL #1
	vsub.U16 q5, q3, q7
	eor	r5, r5, r6, LSL #1
	vmul.S16 q7, q5, q1
	str	r4, [r1], #4
	vsub.U16 q1, q6, q4
	str	r5, [r1], #4
	vqrdmulh.S16 q2, q5, q2
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	vadd.U16 q4, q6, q4
	bfi	r4, r5, #16, #16
	vmla.S16 q7, q2, r12
	bfc	r5, #0, #16
	vldrw.U32 q6, [r11, #16]
	orr	r5, r5, r3, LSR #16
	vqrdmulh.S16 q5, q1, q6
	eor	r3, r4, r4, LSR #8
	vsub.U16 q2, q7, q0
	eor	r6, r5, r5, LSR #8
	vqrdmulh.S16 q6, q2, q6
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	vldrw.U32 q3, [r11], #(3*32)
	eors	r4, r4, r3
	vmul.S16 q2, q2, q3
	eors	r5, r5, r6
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eor	r4, r4, r3, LSL #8
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eor	r5, r5, r6, LSL #8
	vldrw.U32 q3, [r7, #32]
	eor	r3, r4, r4, LSR #4
	vmla.S16 q1, q5, r12
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vadd.U16 q5, q7, q0
	and	r6, r6, #0x00F000F0
	vqrdmulh.S16 q4, q3, r9
	eors	r4, r4, r3
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	eors	r5, r5, r6
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	eor	r4, r4, r3, LSL #4
	vldrw.U32 q7, [r7, #48]
	eor	r5, r5, r6, LSL #4
	vmul.S16 q4, q7, r8
	eor	r3, r4, r4, LSR #2
	vldrw.U32 q1, [r7, #16]
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vqrdmulh.S16 q6, q7, r9
	and	r6, r6, #0x0C0C0C0C
	vldrw.U32 q0, [r7]
	eors	r4, r4, r3
	vmla.S16 q4, q6, r12
	eors	r5, r5, r6
	vqrdmulh.S16 q6, q1, r9
	eor	r4, r4, r3, LSL #2
	vsub.U16 q5, q3, q4
	eor	r5, r5, r6, LSL #2
	vmul.S16 q7, q1, r8
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	vadd.U16 q4, q3, q4
	and	r3, r3, #0x22222222
	vmla.S16 q7, q6, r12
	and	r6, r6, #0x22222222
	vmul.S16 q3, q0, r8
	eors	r4, r4, r3
	vldrw.U32 q1, [r11, #32]
	eors	r5, r5, r6
	vqrdmulh.S16 q2, q0, r9
	eor	r4, r4, r3, LSL #1
	vldrw.U32 q0, [r11, #64]
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	vmla.S16 q3, q2, r12
	str	r5, [r1], #4
	vldrw.U32 q2, [r11, #80]
	vmul.S16 q0, q5, q0
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	vadd.U16 q6, q3, q7
	bfi	r4, r5, #16, #16
	vqrdmulh.S16 q5, q5, q2
	bfc	r5, #0, #16
	vldrw.U32 q2, [r11, #48]
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	vmla.S16 q0, q5, r12
	eor	r6, r5, r5, LSR #8
	vsub.U16 q5, q3, q7
	and	r3, r3, #0x0000FF00
	vmul.S16 q7, q5, q1
	and	r6, r6, #0x0000FF00
	vsub.U16 q1, q6, q4
	eors	r4, r4, r3
	vqrdmulh.S16 q2, q5, q2
	eors	r5, r5, r6
	vadd.U16 q4, q6, q4
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vmla.S16 q7, q2, r12
	eor	r3, r4, r4, LSR #4
	vldrw.U32 q6, [r11, #16]
	eor	r6, r5, r5, LSR #4
	vqrdmulh.S16 q5, q1, q6
	and	r3, r3, #0x00F000F0
	vsub.U16 q2, q7, q0
	and	r6, r6, #0x00F000F0
	vqrdmulh.S16 q6, q2, q6
	eors	r4, r4, r3
	vldrw.U32 q3, [r11], #(3*32)
	eors	r5, r5, r6
	vmul.S16 q2, q2, q3
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eor	r3, r4, r4, LSR #2
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eor	r6, r5, r5, LSR #2
	vldrw.U32 q3, [r7, #32]
	and	r3, r3, #0x0C0C0C0C
	vmla.S16 q1, q5, r12
	and	r6, r6, #0x0C0C0C0C
	vadd.U16 q5, q7, q0
	eors	r4, r4, r3
	vqrdmulh.S16 q4, q3, r9
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	eor	r5, r5, r6, LSL #2
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	eor	r3, r4, r4, LSR #1
	vldrw.U32 q7, [r7, #48]
	eor	r6, r5, r5, LSR #1
	vmul.S16 q4, q7, r8
	and	r3, r3, #0x22222222
	vldrw.U32 q1, [r7, #16]
	and	r6, r6, #0x22222222
	vqrdmulh.S16 q6, q7, r9
	eors	r4, r4, r3
	eors	r5, r5, r6
	vldrw.U32 q0, [r7]
	eor	r4, r4, r3, LSL #1
	vmla.S16 q4, q6, r12
	eor	r5, r5, r6, LSL #1
	vqrdmulh.S16 q6, q1, r9
	str	r4, [r1], #4
	vsub.U16 q5, q3, q4
	str	r5, [r1], #4
	vmul.S16 q7, q1, r8
	ldrd	r4, r5, [r0], #8
	vadd.U16 q4, q3, q4
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vmla.S16 q7, q6, r12
	bfc	r5, #0, #16
	vmul.S16 q3, q0, r8
	orr	r5, r5, r3, LSR #16
	vldrw.U32 q1, [r11, #32]
	eor	r3, r4, r4, LSR #8
	vqrdmulh.S16 q2, q0, r9
	eor	r6, r5, r5, LSR #8
	vldrw.U32 q0, [r11, #64]
	and	r3, r3, #0x0000FF00
	vmla.S16 q3, q2, r12
	and	r6, r6, #0x0000FF00
	vldrw.U32 q2, [r11, #80]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmul.S16 q0, q5, q0
	eor	r4, r4, r3, LSL #8
	vadd.U16 q6, q3, q7
	eor	r5, r5, r6, LSL #8
	vqrdmulh.S16 q5, q5, q2
	eor	r3, r4, r4, LSR #4
	vldrw.U32 q2, [r11, #48]
	eor	r6, r5, r5, LSR #4
	vmla.S16 q0, q5, r12
	and	r3, r3, #0x00F000F0
	vsub.U16 q5, q3, q7
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vmul.S16 q7, q5, q1
	eors	r5, r5, r6
	vsub.U16 q1, q6, q4
	eor	r4, r4, r3, LSL #4
	vqrdmulh.S16 q2, q5, q2
	eor	r5, r5, r6, LSL #4
	vadd.U16 q4, q6, q4
	eor	r3, r4, r4, LSR #2
	vmla.S16 q7, q2, r12
	eor	r6, r5, r5, LSR #2
	vldrw.U32 q6, [r11, #16]
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	vqrdmulh.S16 q5, q1, q6
	eors	r4, r4, r3
	vsub.U16 q2, q7, q0
	eors	r5, r5, r6
	vqrdmulh.S16 q6, q2, q6
	eor	r4, r4, r3, LSL #2
	vldrw.U32 q3, [r11], #(3*32)
	eor	r5, r5, r6, LSL #2
	vmul.S16 q2, q2, q3
	eor	r3, r4, r4, LSR #1
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	and	r6, r6, #0x22222222
	vldrw.U32 q3, [r7, #32]
	eors	r4, r4, r3
	vmla.S16 q1, q5, r12
	eors	r5, r5, r6
	vadd.U16 q5, q7, q0
	eor	r4, r4, r3, LSL #1
	vqrdmulh.S16 q4, q3, r9
	eor	r5, r5, r6, LSL #1
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r4, [r1], #4
	str	r5, [r1], #4
	vstrw.U32 q5, [r7, #-48]
	CD_EPI
	.size	expcd_c5, .-expcd_c5
	.balign 16
	.type	expcd_b6, %function
	.global	expcd_b6
expcd_b6:
	CD_PRO
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	CD_EPI
	.size	expcd_b6, .-expcd_b6
	.balign 16
	.type	expcd_c6, %function
	.global	expcd_c6
expcd_c6:
	CD_PRO
	vmla.S16 q3, q4, r12
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q7, [r7, #48]
	movs	r3, r4
	vmul.S16 q4, q7, r8
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	vldrw.U32 q1, [r7, #16]
	orr	r5, r5, r3, LSR #16
	vqrdmulh.S16 q6, q7, r9
	eor	r3, r4, r4, LSR #8
	vldrw.U32 q0, [r7]
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vmla.S16 q4, q6, r12
	and	r6, r6, #0x0000FF00
	vqrdmulh.S16 q6, q1, r9
	eors	r4, r4, r3
	eors	r5, r5, r6
	vsub.U16 q5, q3, q4
	eor	r4, r4, r3, LSL #8
	vmul.S16 q7, q1, r8
	eor	r5, r5, r6, LSL #8
	vadd.U16 q4, q3, q4
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	vmla.S16 q7, q6, r12
	and	r3, r3, #0x00F000F0
	vmul.S16 q3, q0, r8
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vldrw.U32 q1, [r11, #32]
	eors	r5, r5, r6
	vqrdmulh.S16 q2, q0, r9
	eor	r4, r4, r3, LSL #4
	vldrw.U32 q0, [r11, #64]
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vmla.S16 q3, q2, r12
	eor	r6, r5, r5, LSR #2
	vldrw.U32 q2, [r11, #80]
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	vmul.S16 q0, q5, q0
	eors	r4, r4, r3
	vadd.U16 q6, q3, q7
	eors	r5, r5, r6
	vqrdmulh.S16 q5, q5, q2
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vldrw.U32 q2, [r11, #48]
	eor	r3, r4, r4, LSR #1
	vmla.S16 q0, q5, r12
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vsub.U16 q5, q3, q7
	and	r6, r6, #0x22222222
	vmul.S16 q7, q5, q1
	eors	r4, r4, r3
	vsub.U16 q1, q6, q4
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	vqrdmulh.S16 q2, q5, q2
	eor	r5, r5, r6, LSL #1
	vadd.U16 q4, q6, q4
	str	r4, [r1], #4
	vmla.S16 q7, q2, r12
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q6, [r11, #16]
	movs	r3, r4
	vqrdmulh.S16 q5, q1, q6
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	vsub.U16 q2, q7, q0
	orr	r5, r5, r3, LSR #16
	vqrdmulh.S16 q6, q2, q6
	eor	r3, r4, r4, LSR #8
	vldrw.U32 q3, [r11], #(3*32)
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vmul.S16 q2, q2, q3
	and	r6, r6, #0x0000FF00
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eors	r4, r4, r3
	eors	r5, r5, r6
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eor	r4, r4, r3, LSL #8
	vldrw.U32 q3, [r7, #32]
	eor	r5, r5, r6, LSL #8
	vmla.S16 q1, q5, r12
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	vadd.U16 q5, q7, q0
	and	r3, r3, #0x00F000F0
	vqrdmulh.S16 q4, q3, r9
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	eors	r5, r5, r6
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	eor	r4, r4, r3, LSL #4
	vldrw.U32 q7, [r7, #48]
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vmul.S16 q4, q7, r8
	eor	r6, r5, r5, LSR #2
	vldrw.U32 q1, [r7, #16]
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	vqrdmulh.S16 q6, q7, r9
	eors	r4, r4, r3
	vldrw.U32 q0, [r7]
	eors	r5, r5, r6
	vmla.S16 q4, q6, r12
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vqrdmulh.S16 q6, q1, r9
	eor	r3, r4, r4, LSR #1
	vsub.U16 q5, q3, q4
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vmul.S16 q7, q1, r8
	and	r6, r6, #0x22222222
	vadd.U16 q4, q3, q4
	eors	r4, r4, r3
	vmla.S16 q7, q6, r12
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	vmul.S16 q3, q0, r8
	eor	r5, r5, r6, LSL #1
	vldrw.U32 q1, [r11, #32]
	str	r4, [r1], #4
	vqrdmulh.S16 q2, q0, r9
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q0, [r11, #64]
	movs	r3, r4
	vmla.S16 q3, q2, r12
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	vldrw.U32 q2, [r11, #80]
	orr	r5, r5, r3, LSR #16
	vmul.S16 q0, q5, q0
	eor	r3, r4, r4, LSR #8
	vadd.U16 q6, q3, q7
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vqrdmulh.S16 q5, q5, q2
	and	r6, r6, #0x0000FF00
	vldrw.U32 q2, [r11, #48]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmla.S16 q0, q5, r12
	eor	r4, r4, r3, LSL #8
	vsub.U16 q5, q3, q7
	eor	r5, r5, r6, LSL #8
	vmul.S16 q7, q5, q1
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	vsub.U16 q1, q6, q4
	and	r3, r3, #0x00F000F0
	vqrdmulh.S16 q2, q5, q2
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vadd.U16 q4, q6, q4
	eors	r5, r5, r6
	vmla.S16 q7, q2, r12
	eor	r4, r4, r3, LSL #4
	vldrw.U32 q6, [r11, #16]
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vqrdmulh.S16 q5, q1, q6
	eor	r6, r5, r5, LSR #2
	vsub.U16 q2, q7, q0
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	vqrdmulh.S16 q6, q2, q6
	eors	r4, r4, r3
	vldrw.U32 q3, [r11], #(3*32)
	eors	r5, r5, r6
	vmul.S16 q2, q2, q3
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eor	r3, r4, r4, LSR #1
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vldrw.U32 q3, [r7, #32]
	and	r6, r6, #0x22222222
	vmla.S16 q1, q5, r12
	eors	r4, r4, r3
	vadd.U16 q5, q7, q0
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	vqrdmulh.S16 q4, q3, r9
	eor	r5, r5, r6, LSL #1
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r4, [r1], #4
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q7, [r7, #48]
	movs	r3, r4
	vmul.S16 q4, q7, r8
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	vldrw.U32 q1, [r7, #16]
	orr	r5, r5, r3, LSR #16
	vqrdmulh.S16 q6, q7, r9
	eor	r3, r4, r4, LSR #8
	vldrw.U32 q0, [r7]
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vmla.S16 q4, q6, r12
	and	r6, r6, #0x0000FF00
	vqrdmulh.S16 q6, q1, r9
	eors	r4, r4, r3
	eors	r5, r5, r6
	vsub.U16 q5, q3, q4
	eor	r4, r4, r3, LSL #8
	vmul.S16 q7, q1, r8
	eor	r5, r5, r6, LSL #8
	vadd.U16 q4, q3, q4
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	vmla.S16 q7, q6, r12
	and	r3, r3, #0x00F000F0
	vmul.S16 q3, q0, r8
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vldrw.U32 q1, [r11, #32]
	eors	r5, r5, r6
	vqrdmulh.S16 q2, q0, r9
	eor	r4, r4, r3, LSL #4
	vldrw.U32 q0, [r11, #64]
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vmla.S16 q3, q2, r12
	eor	r6, r5, r5, LSR #2
	vldrw.U32 q2, [r11, #80]
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	vmul.S16 q0, q5, q0
	eors	r4, r4, r3
	vadd.U16 q6, q3, q7
	eors	r5, r5, r6
	vqrdmulh.S16 q5, q5, q2
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vldrw.U32 q2, [r11, #48]
	eor	r3, r4, r4, LSR #1
	vmla.S16 q0, q5, r12
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vsub.U16 q5, q3, q7
	and	r6, r6, #0x22222222
	vmul.S16 q7, q5, q1
	eors	r4, r4, r3
	vsub.U16 q1, q6, q4
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	vqrdmulh.S16 q2, q5, q2
	eor	r5, r5, r6, LSL #1
	vadd.U16 q4, q6, q4
	str	r4, [r1], #4
	vmla.S16 q7, q2, r12
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q6, [r11, #16]
	movs	r3, r4
	vqrdmulh.S16 q5, q1, q6
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	vsub.U16 q2, q7, q0
	orr	r5, r5, r3, LSR #16
	vqrdmulh.S16 q6, q2, q6
	eor	r3, r4, r4, LSR #8
	vldrw.U32 q3, [r11], #(3*32)
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vmul.S16 q2, q2, q3
	and	r6, r6, #0x0000FF00
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eors	r4, r4, r3
	eors	r5, r5, r6
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eor	r4, r4, r3, LSL #8
	vldrw.U32 q3, [r7, #32]
	eor	r5, r5, r6, LSL #8
	vmla.S16 q1, q5, r12
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	vadd.U16 q5, q7, q0
	and	r3, r3, #0x00F000F0
	vqrdmulh.S16 q4, q3, r9
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	eors	r5, r5, r6
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	eor	r4, r4, r3, LSL #4
	vldrw.U32 q7, [r7, #48]
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vmul.S16 q4, q7, r8
	eor	r6, r5, r5, LSR #2
	vldrw.U32 q1, [r7, #16]
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	vqrdmulh.S16 q6, q7, r9
	eors	r4, r4, r3
	vldrw.U32 q0, [r7]
	eors	r5, r5, r6
	vmla.S16 q4, q6, r12
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vqrdmulh.S16 q6, q1, r9
	eor	r3, r4, r4, LSR #1
	vsub.U16 q5, q3, q4
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vmul.S16 q7, q1, r8
	and	r6, r6, #0x22222222
	vadd.U16 q4, q3, q4
	eors	r4, r4, r3
	vmla.S16 q7, q6, r12
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	vmul.S16 q3, q0, r8
	eor	r5, r5, r6, LSL #1
	vldrw.U32 q1, [r11, #32]
	str	r4, [r1], #4
	vqrdmulh.S16 q2, q0, r9
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q0, [r11, #64]
	movs	r3, r4
	vmla.S16 q3, q2, r12
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	vldrw.U32 q2, [r11, #80]
	orr	r5, r5, r3, LSR #16
	vmul.S16 q0, q5, q0
	eor	r3, r4, r4, LSR #8
	vadd.U16 q6, q3, q7
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vqrdmulh.S16 q5, q5, q2
	and	r6, r6, #0x0000FF00
	vldrw.U32 q2, [r11, #48]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmla.S16 q0, q5, r12
	eor	r4, r4, r3, LSL #8
	vsub.U16 q5, q3, q7
	eor	r5, r5, r6, LSL #8
	vmul.S16 q7, q5, q1
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	vsub.U16 q1, q6, q4
	and	r3, r3, #0x00F000F0
	vqrdmulh.S16 q2, q5, q2
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vadd.U16 q4, q6, q4
	eors	r5, r5, r6
	vmla.S16 q7, q2, r12
	eor	r4, r4, r3, LSL #4
	vldrw.U32 q6, [r11, #16]
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vqrdmulh.S16 q5, q1, q6
	eor	r6, r5, r5, LSR #2
	vsub.U16 q2, q7, q0
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	vqrdmulh.S16 q6, q2, q6
	eors	r4, r4, r3
	vldrw.U32 q3, [r11], #(3*32)
	eors	r5, r5, r6
	vmul.S16 q2, q2, q3
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eor	r3, r4, r4, LSR #1
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vldrw.U32 q3, [r7, #32]
	and	r6, r6, #0x22222222
	vmla.S16 q1, q5, r12
	eors	r4, r4, r3
	vadd.U16 q5, q7, q0
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	vqrdmulh.S16 q4, q3, r9
	eor	r5, r5, r6, LSL #1
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r4, [r1], #4
	vstrw.U32 q5, [r7, #-48]
	str	r5, [r1], #4
	CD_EPI
	.size	expcd_c6, .-expcd_c6
	.balign 16
	.type	expcd_b7, %function
	.global	expcd_b7
expcd_b7:
	CD_PRO
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	CD_EPI
	.size	expcd_b7, .-expcd_b7
	.balign 16
	.type	expcd_c7, %function
	.global	expcd_c7
expcd_c7:
	CD_PRO
	vmla.S16 q3, q4, r12
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q7, [r7, #48]
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vmul.S16 q4, q7, r8
	bfc	r5, #0, #16
	vldrw.U32 q1, [r7, #16]
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	vqrdmulh.S16 q6, q7, r9
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vldrw.U32 q0, [r7]
	and	r6, r6, #0x0000FF00
	vmla.S16 q4, q6, r12
	eors	r4, r4, r3
	eors	r5, r5, r6
	vqrdmulh.S16 q6, q1, r9
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vsub.U16 q5, q3, q4
	eor	r3, r4, r4, LSR #4
	vmul.S16 q7, q1, r8
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vadd.U16 q4, q3, q4
	and	r6, r6, #0x00F000F0
	vmla.S16 q7, q6, r12
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmul.S16 q3, q0, r8
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	vldrw.U32 q1, [r11, #32]
	eor	r3, r4, r4, LSR #2
	vqrdmulh.S16 q2, q0, r9
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vldrw.U32 q0, [r11, #64]
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vmla.S16 q3, q2, r12
	eors	r5, r5, r6
	vldrw.U32 q2, [r11, #80]
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vmul.S16 q0, q5, q0
	eor	r3, r4, r4, LSR #1
	vadd.U16 q6, q3, q7
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vqrdmulh.S16 q5, q5, q2
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	vldrw.U32 q2, [r11, #48]
	eors	r5, r5, r6
	vmla.S16 q0, q5, r12
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vsub.U16 q5, q3, q7
	str	r4, [r1], #4
	str	r5, [r1], #4
	vmul.S16 q7, q5, q1
	ldrd	r4, r5, [r0], #8
	vsub.U16 q1, q6, q4
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vqrdmulh.S16 q2, q5, q2
	bfc	r5, #0, #16
	vadd.U16 q4, q6, q4
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	vmla.S16 q7, q2, r12
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vldrw.U32 q6, [r11, #16]
	and	r6, r6, #0x0000FF00
	vqrdmulh.S16 q5, q1, q6
	eors	r4, r4, r3
	eors	r5, r5, r6
	vsub.U16 q2, q7, q0
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vqrdmulh.S16 q6, q2, q6
	eor	r3, r4, r4, LSR #4
	vldrw.U32 q3, [r11], #(3*32)
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vmul.S16 q2, q2, q3
	and	r6, r6, #0x00F000F0
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eors	r4, r4, r3
	eors	r5, r5, r6
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	vldrw.U32 q3, [r7, #32]
	eor	r3, r4, r4, LSR #2
	vmla.S16 q1, q5, r12
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vadd.U16 q5, q7, q0
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vqrdmulh.S16 q4, q3, r9
	eors	r5, r5, r6
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	eor	r3, r4, r4, LSR #1
	vldrw.U32 q7, [r7, #48]
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vmul.S16 q4, q7, r8
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	vldrw.U32 q1, [r7, #16]
	eors	r5, r5, r6
	vqrdmulh.S16 q6, q7, r9
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vldrw.U32 q0, [r7]
	str	r4, [r1], #4
	str	r5, [r1], #4
	vmla.S16 q4, q6, r12
	ldrd	r4, r5, [r0], #8
	vqrdmulh.S16 q6, q1, r9
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vsub.U16 q5, q3, q4
	bfc	r5, #0, #16
	vmul.S16 q7, q1, r8
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	vadd.U16 q4, q3, q4
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vmla.S16 q7, q6, r12
	and	r6, r6, #0x0000FF00
	vmul.S16 q3, q0, r8
	eors	r4, r4, r3
	eors	r5, r5, r6
	vldrw.U32 q1, [r11, #32]
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vqrdmulh.S16 q2, q0, r9
	eor	r3, r4, r4, LSR #4
	vldrw.U32 q0, [r11, #64]
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vmla.S16 q3, q2, r12
	and	r6, r6, #0x00F000F0
	vldrw.U32 q2, [r11, #80]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmul.S16 q0, q5, q0
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	vadd.U16 q6, q3, q7
	eor	r3, r4, r4, LSR #2
	vqrdmulh.S16 q5, q5, q2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vldrw.U32 q2, [r11, #48]
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vmla.S16 q0, q5, r12
	eors	r5, r5, r6
	vsub.U16 q5, q3, q7
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vmul.S16 q7, q5, q1
	eor	r3, r4, r4, LSR #1
	vsub.U16 q1, q6, q4
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vqrdmulh.S16 q2, q5, q2
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	vadd.U16 q4, q6, q4
	eors	r5, r5, r6
	vmla.S16 q7, q2, r12
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vldrw.U32 q6, [r11, #16]
	str	r4, [r1], #4
	str	r5, [r1], #4
	vqrdmulh.S16 q5, q1, q6
	ldrd	r4, r5, [r0], #8
	vsub.U16 q2, q7, q0
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vqrdmulh.S16 q6, q2, q6
	bfc	r5, #0, #16
	vldrw.U32 q3, [r11], #(3*32)
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	vmul.S16 q2, q2, q3
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	and	r6, r6, #0x0000FF00
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eors	r4, r4, r3
	eors	r5, r5, r6
	vldrw.U32 q3, [r7, #32]
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vmla.S16 q1, q5, r12
	eor	r3, r4, r4, LSR #4
	vadd.U16 q5, q7, q0
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vqrdmulh.S16 q4, q3, r9
	and	r6, r6, #0x00F000F0
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	eors	r4, r4, r3
	eors	r5, r5, r6
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	vldrw.U32 q7, [r7, #48]
	eor	r3, r4, r4, LSR #2
	vmul.S16 q4, q7, r8
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vldrw.U32 q1, [r7, #16]
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vqrdmulh.S16 q6, q7, r9
	eors	r5, r5, r6
	vldrw.U32 q0, [r7]
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vmla.S16 q4, q6, r12
	eor	r3, r4, r4, LSR #1
	vqrdmulh.S16 q6, q1, r9
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vsub.U16 q5, q3, q4
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	vmul.S16 q7, q1, r8
	eors	r5, r5, r6
	vadd.U16 q4, q3, q4
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vmla.S16 q7, q6, r12
	str	r4, [r1], #4
	str	r5, [r1], #4
	vmul.S16 q3, q0, r8
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q1, [r11, #32]
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vqrdmulh.S16 q2, q0, r9
	bfc	r5, #0, #16
	vldrw.U32 q0, [r11, #64]
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	vmla.S16 q3, q2, r12
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vldrw.U32 q2, [r11, #80]
	and	r6, r6, #0x0000FF00
	vmul.S16 q0, q5, q0
	eors	r4, r4, r3
	eors	r5, r5, r6
	vadd.U16 q6, q3, q7
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vqrdmulh.S16 q5, q5, q2
	eor	r3, r4, r4, LSR #4
	vldrw.U32 q2, [r11, #48]
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vmla.S16 q0, q5, r12
	and	r6, r6, #0x00F000F0
	vsub.U16 q5, q3, q7
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmul.S16 q7, q5, q1
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	vsub.U16 q1, q6, q4
	eor	r3, r4, r4, LSR #2
	vqrdmulh.S16 q2, q5, q2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vadd.U16 q4, q6, q4
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vmla.S16 q7, q2, r12
	eors	r5, r5, r6
	vldrw.U32 q6, [r11, #16]
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vqrdmulh.S16 q5, q1, q6
	eor	r3, r4, r4, LSR #1
	vsub.U16 q2, q7, q0
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vqrdmulh.S16 q6, q2, q6
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	vldrw.U32 q3, [r11], #(3*32)
	eors	r5, r5, r6
	vmul.S16 q2, q2, q3
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	str	r4, [r1], #4
	str	r5, [r1], #4
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q3, [r7, #32]
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vmla.S16 q1, q5, r12
	bfc	r5, #0, #16
	vadd.U16 q5, q7, q0
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	vqrdmulh.S16 q4, q3, r9
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	and	r6, r6, #0x0000FF00
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	eors	r4, r4, r3
	eors	r5, r5, r6
	vldrw.U32 q7, [r7, #48]
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vmul.S16 q4, q7, r8
	eor	r3, r4, r4, LSR #4
	vldrw.U32 q1, [r7, #16]
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vqrdmulh.S16 q6, q7, r9
	and	r6, r6, #0x00F000F0
	vldrw.U32 q0, [r7]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmla.S16 q4, q6, r12
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	vqrdmulh.S16 q6, q1, r9
	eor	r3, r4, r4, LSR #2
	vsub.U16 q5, q3, q4
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vmul.S16 q7, q1, r8
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vadd.U16 q4, q3, q4
	eors	r5, r5, r6
	vmla.S16 q7, q6, r12
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vmul.S16 q3, q0, r8
	eor	r3, r4, r4, LSR #1
	vldrw.U32 q1, [r11, #32]
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vqrdmulh.S16 q2, q0, r9
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	vldrw.U32 q0, [r11, #64]
	eors	r5, r5, r6
	vmla.S16 q3, q2, r12
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vldrw.U32 q2, [r11, #80]
	str	r4, [r1], #4
	str	r5, [r1], #4
	vmul.S16 q0, q5, q0
	ldrd	r4, r5, [r0], #8
	vadd.U16 q6, q3, q7
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vqrdmulh.S16 q5, q5, q2
	bfc	r5, #0, #16
	vldrw.U32 q2, [r11, #48]
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	vmla.S16 q0, q5, r12
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vsub.U16 q5, q3, q7
	and	r6, r6, #0x0000FF00
	vmul.S16 q7, q5, q1
	eors	r4, r4, r3
	eors	r5, r5, r6
	vsub.U16 q1, q6, q4
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vqrdmulh.S16 q2, q5, q2
	eor	r3, r4, r4, LSR #4
	vadd.U16 q4, q6, q4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vmla.S16 q7, q2, r12
	and	r6, r6, #0x00F000F0
	vldrw.U32 q6, [r11, #16]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vqrdmulh.S16 q5, q1, q6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	vsub.U16 q2, q7, q0
	eor	r3, r4, r4, LSR #2
	vqrdmulh.S16 q6, q2, q6
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vldrw.U32 q3, [r11], #(3*32)
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vmul.S16 q2, q2, q3
	eors	r5, r5, r6
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eor	r3, r4, r4, LSR #1
	vldrw.U32 q3, [r7, #32]
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vmla.S16 q1, q5, r12
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	vadd.U16 q5, q7, q0
	eors	r5, r5, r6
	vqrdmulh.S16 q4, q3, r9
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r4, [r1], #4
	str	r5, [r1], #4
	vstrw.U32 q5, [r7, #-48]
	CD_EPI
	.size	expcd_c7, .-expcd_c7
	.balign 16
	.type	expcd_b8, %function
	.global	expcd_b8
expcd_b8:
	CD_PRO
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	eors	r4, r4, r3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	str	r4, [r1], #4
	str	r5, [r1], #4
	CD_EPI
	.size	expcd_b8, .-expcd_b8
	.balign 16
	.type	expcd_c8, %function
	.global	expcd_c8
expcd_c8:
	CD_PRO
	vmla.S16 q3, q4, r12
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q7, [r7, #48]
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vmul.S16 q4, q7, r8
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vldrw.U32 q1, [r7, #16]
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	vqrdmulh.S16 q6, q7, r9
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	vldrw.U32 q0, [r7]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmla.S16 q4, q6, r12
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vqrdmulh.S16 q6, q1, r9
	eor	r3, r4, r4, LSR #4
	vsub.U16 q5, q3, q4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vmul.S16 q7, q1, r8
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vadd.U16 q4, q3, q4
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vmla.S16 q7, q6, r12
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vmul.S16 q3, q0, r8
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vldrw.U32 q1, [r11, #32]
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vqrdmulh.S16 q2, q0, r9
	eors	r5, r5, r6
	vldrw.U32 q0, [r11, #64]
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vmla.S16 q3, q2, r12
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	vldrw.U32 q2, [r11, #80]
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	vmul.S16 q0, q5, q0
	eors	r4, r4, r3
	eors	r5, r5, r6
	vadd.U16 q6, q3, q7
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vqrdmulh.S16 q5, q5, q2
	str	r4, [r1], #4
	str	r5, [r1], #4
	vldrw.U32 q2, [r11, #48]
	vmla.S16 q0, q5, r12
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vsub.U16 q5, q3, q7
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vmul.S16 q7, q5, q1
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	vsub.U16 q1, q6, q4
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	vqrdmulh.S16 q2, q5, q2
	eors	r4, r4, r3
	eors	r5, r5, r6
	vadd.U16 q4, q6, q4
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vmla.S16 q7, q2, r12
	eor	r3, r4, r4, LSR #4
	vldrw.U32 q6, [r11, #16]
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vqrdmulh.S16 q5, q1, q6
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vsub.U16 q2, q7, q0
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vqrdmulh.S16 q6, q2, q6
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vldrw.U32 q3, [r11], #(3*32)
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vmul.S16 q2, q2, q3
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eors	r5, r5, r6
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vldrw.U32 q3, [r7, #32]
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	vmla.S16 q1, q5, r12
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	vadd.U16 q5, q7, q0
	eors	r4, r4, r3
	eors	r5, r5, r6
	vqrdmulh.S16 q4, q3, r9
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r4, [r1], #4
	str	r5, [r1], #4
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q7, [r7, #48]
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vmul.S16 q4, q7, r8
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vldrw.U32 q1, [r7, #16]
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	vqrdmulh.S16 q6, q7, r9
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	vldrw.U32 q0, [r7]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmla.S16 q4, q6, r12
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vqrdmulh.S16 q6, q1, r9
	eor	r3, r4, r4, LSR #4
	vsub.U16 q5, q3, q4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vmul.S16 q7, q1, r8
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vadd.U16 q4, q3, q4
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vmla.S16 q7, q6, r12
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vmul.S16 q3, q0, r8
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vldrw.U32 q1, [r11, #32]
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vqrdmulh.S16 q2, q0, r9
	eors	r5, r5, r6
	vldrw.U32 q0, [r11, #64]
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vmla.S16 q3, q2, r12
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	vldrw.U32 q2, [r11, #80]
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	vmul.S16 q0, q5, q0
	eors	r4, r4, r3
	eors	r5, r5, r6
	vadd.U16 q6, q3, q7
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vqrdmulh.S16 q5, q5, q2
	str	r4, [r1], #4
	str	r5, [r1], #4
	vldrw.U32 q2, [r11, #48]
	vmla.S16 q0, q5, r12
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vsub.U16 q5, q3, q7
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vmul.S16 q7, q5, q1
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	vsub.U16 q1, q6, q4
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	vqrdmulh.S16 q2, q5, q2
	eors	r4, r4, r3
	eors	r5, r5, r6
	vadd.U16 q4, q6, q4
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vmla.S16 q7, q2, r12
	eor	r3, r4, r4, LSR #4
	vldrw.U32 q6, [r11, #16]
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vqrdmulh.S16 q5, q1, q6
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vsub.U16 q2, q7, q0
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vqrdmulh.S16 q6, q2, q6
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vldrw.U32 q3, [r11], #(3*32)
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vmul.S16 q2, q2, q3
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eors	r5, r5, r6
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vldrw.U32 q3, [r7, #32]
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	vmla.S16 q1, q5, r12
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	vadd.U16 q5, q7, q0
	eors	r4, r4, r3
	eors	r5, r5, r6
	vqrdmulh.S16 q4, q3, r9
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r4, [r1], #4
	str	r5, [r1], #4
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q7, [r7, #48]
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vmul.S16 q4, q7, r8
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vldrw.U32 q1, [r7, #16]
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	vqrdmulh.S16 q6, q7, r9
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	vldrw.U32 q0, [r7]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmla.S16 q4, q6, r12
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vqrdmulh.S16 q6, q1, r9
	eor	r3, r4, r4, LSR #4
	vsub.U16 q5, q3, q4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vmul.S16 q7, q1, r8
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vadd.U16 q4, q3, q4
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vmla.S16 q7, q6, r12
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vmul.S16 q3, q0, r8
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vldrw.U32 q1, [r11, #32]
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vqrdmulh.S16 q2, q0, r9
	eors	r5, r5, r6
	vldrw.U32 q0, [r11, #64]
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vmla.S16 q3, q2, r12
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	vldrw.U32 q2, [r11, #80]
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	vmul.S16 q0, q5, q0
	eors	r4, r4, r3
	eors	r5, r5, r6
	vadd.U16 q6, q3, q7
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vqrdmulh.S16 q5, q5, q2
	str	r4, [r1], #4
	str	r5, [r1], #4
	vldrw.U32 q2, [r11, #48]
	vmla.S16 q0, q5, r12
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vsub.U16 q5, q3, q7
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vmul.S16 q7, q5, q1
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	vsub.U16 q1, q6, q4
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	vqrdmulh.S16 q2, q5, q2
	eors	r4, r4, r3
	eors	r5, r5, r6
	vadd.U16 q4, q6, q4
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vmla.S16 q7, q2, r12
	eor	r3, r4, r4, LSR #4
	vldrw.U32 q6, [r11, #16]
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vqrdmulh.S16 q5, q1, q6
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vsub.U16 q2, q7, q0
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vqrdmulh.S16 q6, q2, q6
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vldrw.U32 q3, [r11], #(3*32)
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vmul.S16 q2, q2, q3
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eors	r5, r5, r6
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vldrw.U32 q3, [r7, #32]
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	vmla.S16 q1, q5, r12
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	vadd.U16 q5, q7, q0
	eors	r4, r4, r3
	eors	r5, r5, r6
	vqrdmulh.S16 q4, q3, r9
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r4, [r1], #4
	str	r5, [r1], #4
	vstrw.U32 q5, [r7, #-48]
	vmla.S16 q3, q4, r12
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q7, [r7, #48]
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vmul.S16 q4, q7, r8
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vldrw.U32 q1, [r7, #16]
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	vqrdmulh.S16 q6, q7, r9
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	vldrw.U32 q0, [r7]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmla.S16 q4, q6, r12
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vqrdmulh.S16 q6, q1, r9
	eor	r3, r4, r4, LSR #4
	vsub.U16 q5, q3, q4
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vmul.S16 q7, q1, r8
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vadd.U16 q4, q3, q4
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vmla.S16 q7, q6, r12
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vmul.S16 q3, q0, r8
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vldrw.U32 q1, [r11, #32]
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vqrdmulh.S16 q2, q0, r9
	eors	r5, r5, r6
	vldrw.U32 q0, [r11, #64]
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vmla.S16 q3, q2, r12
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	vldrw.U32 q2, [r11, #80]
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	vmul.S16 q0, q5, q0
	eors	r4, r4, r3
	eors	r5, r5, r6
	vadd.U16 q6, q3, q7
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vqrdmulh.S16 q5, q5, q2
	str	r4, [r1], #4
	str	r5, [r1], #4
	vldrw.U32 q2, [r11, #48]
	vmla.S16 q0, q5, r12
	ldrd	r4, r5, [r0], #8
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vsub.U16 q5, q3, q7
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vmul.S16 q7, q5, q1
	eor	r3, r4, r4, LSR #8
	eor	r6, r5, r5, LSR #8
	vsub.U16 q1, q6, q4
	and	r3, r3, #0x0000FF00
	and	r6, r6, #0x0000FF00
	vqrdmulh.S16 q2, q5, q2
	eors	r4, r4, r3
	eors	r5, r5, r6
	vadd.U16 q4, q6, q4
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vmla.S16 q7, q2, r12
	eor	r3, r4, r4, LSR #4
	vldrw.U32 q6, [r11, #16]
	eor	r6, r5, r5, LSR #4
	and	r3, r3, #0x00F000F0
	vqrdmulh.S16 q5, q1, q6
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vsub.U16 q2, q7, q0
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vqrdmulh.S16 q6, q2, q6
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vldrw.U32 q3, [r11], #(3*32)
	eor	r6, r5, r5, LSR #2
	and	r3, r3, #0x0C0C0C0C
	vmul.S16 q2, q2, q3
	and	r6, r6, #0x0C0C0C0C
	eors	r4, r4, r3
	vstrw.U32 q4, [r7], #64
	vmla.S16 q2, q6, r12
	eors	r5, r5, r6
	vstrw.U32 q2, [r7, #-16]
	vmul.S16 q1, q1, q3
	eor	r4, r4, r3, LSL #2
	eor	r5, r5, r6, LSL #2
	vldrw.U32 q3, [r7, #32]
	eor	r3, r4, r4, LSR #1
	eor	r6, r5, r5, LSR #1
	vmla.S16 q1, q5, r12
	and	r3, r3, #0x22222222
	and	r6, r6, #0x22222222
	vadd.U16 q5, q7, q0
	eors	r4, r4, r3
	eors	r5, r5, r6
	vqrdmulh.S16 q4, q3, r9
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vstrw.U32 q1, [r7, #-32]
	vmul.S16 q3, q3, r8
	str	r4, [r1], #4
	str	r5, [r1], #4
	vstrw.U32 q5, [r7, #-48]
	CD_EPI
	.size	expcd_c8, .-expcd_c8
	.ltorg
