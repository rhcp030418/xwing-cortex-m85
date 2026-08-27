/* 실험 CA-1: **명령어 스티칭 실증** — intt layer67_loop x MVE 밑에 Keccak 숨기기.
 *
 * 사전등록: 2026-08-26_expCA_stitch_prereg.md
 *
 *   A  expca_ntt_only    : layer67 본문 x8 펼침 (368 MVE)
 *   B  expca_kec_only    : Keccak extract lane x16 (624 스칼라)
 *   C  expca_merged      : 둘을 엮음 (992)
 *
 * 레지스터: NTT 는 원본의 r0 을 **r7 로 재배치**했다(Keccak 이 r0 을 쓴다).
 *   NTT   : r7(저장) r11(적재) r8 r9 r12  + q0-q7
 *   Keccak: r0(state) r1(data) r3 r4 r5 r6
 *   합 11개 <= 14  -> **스필 없음**
 *
 * 진입: r0=keccak state, r1=keccak out, r7=ntt dst, r11=ntt src,
 *       r8,r9,r12 = NTT 스칼라 상수
 */
	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits
	.align 2

/* void expca_setup(void *kec_state, void *kec_out, void *ntt_dst, void *ntt_src)
 *   AAPCS r0..r3 -> 커널 규약으로 옮기고 상수를 채운다. */
	.macro CA_PRO
	push	{r4-r12, lr}
	mov	r7, r2			/* ntt dst */
	mov	r11, r3			/* ntt src */
	movw	r8, #3329
	movw	r9, #20159
	movw	r12, #3329
	.endm

	.macro CA_EPI
	pop	{r4-r12, pc}
	.endm

/* A: NTT 만 (184 MVE) */
	.balign 16
	.type	expca_ntt_only, %function
	.global	expca_ntt_only
expca_ntt_only:
	CA_PRO
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
	CA_EPI
	.size	expca_ntt_only, .-expca_ntt_only
/* B: Keccak 만 (312 스칼라) */
	.balign 16
	.type	expca_kec_only, %function
	.global	expca_kec_only
expca_kec_only:
	CA_PRO
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
	CA_EPI
	.size	expca_kec_only, .-expca_kec_only
/* C: 병합 (496) */
	.balign 16
	.type	expca_merged, %function
	.global	expca_merged
expca_merged:
	CA_PRO
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
	vqrdmulh.S16 q6, q7, r9
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vldrw.U32 q0, [r7]
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	vmla.S16 q4, q6, r12
	eors	r5, r5, r6
	vqrdmulh.S16 q6, q1, r9
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vsub.U16 q5, q3, q4
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	vmul.S16 q7, q1, r8
	and	r3, r3, #0x00F000F0
	vadd.U16 q4, q3, q4
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vmla.S16 q7, q6, r12
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vmul.S16 q3, q0, r8
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vldrw.U32 q1, [r11, #32]
	eor	r6, r5, r5, LSR #2
	vqrdmulh.S16 q2, q0, r9
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	vldrw.U32 q0, [r11, #64]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmla.S16 q3, q2, r12
	eor	r4, r4, r3, LSL #2
	vldrw.U32 q2, [r11, #80]
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	vmul.S16 q0, q5, q0
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vadd.U16 q6, q3, q7
	and	r6, r6, #0x22222222
	vqrdmulh.S16 q5, q5, q2
	eors	r4, r4, r3
	eors	r5, r5, r6
	vldrw.U32 q2, [r11, #48]
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vmla.S16 q0, q5, r12
	str	r4, [r1], #4
	vsub.U16 q5, q3, q7
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	vmul.S16 q7, q5, q1
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vsub.U16 q1, q6, q4
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vqrdmulh.S16 q2, q5, q2
	eor	r3, r4, r4, LSR #8
	vadd.U16 q4, q6, q4
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vmla.S16 q7, q2, r12
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	vldrw.U32 q6, [r11, #16]
	eors	r5, r5, r6
	vqrdmulh.S16 q5, q1, q6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vsub.U16 q2, q7, q0
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	vqrdmulh.S16 q6, q2, q6
	and	r3, r3, #0x00F000F0
	vldrw.U32 q3, [r11], #(3*32)
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vmul.S16 q2, q2, q3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vstrw.U32 q4, [r7], #64
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vmla.S16 q2, q6, r12
	eor	r6, r5, r5, LSR #2
	vstrw.U32 q2, [r7, #-16]
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	vmul.S16 q1, q1, q3
	eors	r4, r4, r3
	eors	r5, r5, r6
	vldrw.U32 q3, [r7, #32]
	eor	r4, r4, r3, LSL #2
	vmla.S16 q1, q5, r12
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	vadd.U16 q5, q7, q0
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vqrdmulh.S16 q4, q3, r9
	and	r6, r6, #0x22222222
	vstrw.U32 q1, [r7, #-32]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmul.S16 q3, q3, r8
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vstrw.U32 q5, [r7, #-48]
	str	r4, [r1], #4
	vmla.S16 q3, q4, r12
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q7, [r7, #48]
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vmul.S16 q4, q7, r8
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vldrw.U32 q1, [r7, #16]
	eor	r3, r4, r4, LSR #8
	vqrdmulh.S16 q6, q7, r9
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vldrw.U32 q0, [r7]
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	vmla.S16 q4, q6, r12
	eors	r5, r5, r6
	vqrdmulh.S16 q6, q1, r9
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vsub.U16 q5, q3, q4
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	vmul.S16 q7, q1, r8
	and	r3, r3, #0x00F000F0
	vadd.U16 q4, q3, q4
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vmla.S16 q7, q6, r12
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vmul.S16 q3, q0, r8
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vldrw.U32 q1, [r11, #32]
	eor	r6, r5, r5, LSR #2
	vqrdmulh.S16 q2, q0, r9
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	vldrw.U32 q0, [r11, #64]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmla.S16 q3, q2, r12
	eor	r4, r4, r3, LSL #2
	vldrw.U32 q2, [r11, #80]
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	vmul.S16 q0, q5, q0
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vadd.U16 q6, q3, q7
	and	r6, r6, #0x22222222
	vqrdmulh.S16 q5, q5, q2
	eors	r4, r4, r3
	eors	r5, r5, r6
	vldrw.U32 q2, [r11, #48]
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vmla.S16 q0, q5, r12
	str	r4, [r1], #4
	vsub.U16 q5, q3, q7
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	vmul.S16 q7, q5, q1
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vsub.U16 q1, q6, q4
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vqrdmulh.S16 q2, q5, q2
	eor	r3, r4, r4, LSR #8
	vadd.U16 q4, q6, q4
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vmla.S16 q7, q2, r12
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	vldrw.U32 q6, [r11, #16]
	eors	r5, r5, r6
	vqrdmulh.S16 q5, q1, q6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vsub.U16 q2, q7, q0
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	vqrdmulh.S16 q6, q2, q6
	and	r3, r3, #0x00F000F0
	vldrw.U32 q3, [r11], #(3*32)
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vmul.S16 q2, q2, q3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vstrw.U32 q4, [r7], #64
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vmla.S16 q2, q6, r12
	eor	r6, r5, r5, LSR #2
	vstrw.U32 q2, [r7, #-16]
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	vmul.S16 q1, q1, q3
	eors	r4, r4, r3
	eors	r5, r5, r6
	vldrw.U32 q3, [r7, #32]
	eor	r4, r4, r3, LSL #2
	vmla.S16 q1, q5, r12
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	vadd.U16 q5, q7, q0
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vqrdmulh.S16 q4, q3, r9
	and	r6, r6, #0x22222222
	vstrw.U32 q1, [r7, #-32]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmul.S16 q3, q3, r8
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vstrw.U32 q5, [r7, #-48]
	str	r4, [r1], #4
	vmla.S16 q3, q4, r12
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q7, [r7, #48]
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vmul.S16 q4, q7, r8
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vldrw.U32 q1, [r7, #16]
	eor	r3, r4, r4, LSR #8
	vqrdmulh.S16 q6, q7, r9
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vldrw.U32 q0, [r7]
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	vmla.S16 q4, q6, r12
	eors	r5, r5, r6
	vqrdmulh.S16 q6, q1, r9
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vsub.U16 q5, q3, q4
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	vmul.S16 q7, q1, r8
	and	r3, r3, #0x00F000F0
	vadd.U16 q4, q3, q4
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vmla.S16 q7, q6, r12
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vmul.S16 q3, q0, r8
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vldrw.U32 q1, [r11, #32]
	eor	r6, r5, r5, LSR #2
	vqrdmulh.S16 q2, q0, r9
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	vldrw.U32 q0, [r11, #64]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmla.S16 q3, q2, r12
	eor	r4, r4, r3, LSL #2
	vldrw.U32 q2, [r11, #80]
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	vmul.S16 q0, q5, q0
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vadd.U16 q6, q3, q7
	and	r6, r6, #0x22222222
	vqrdmulh.S16 q5, q5, q2
	eors	r4, r4, r3
	eors	r5, r5, r6
	vldrw.U32 q2, [r11, #48]
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vmla.S16 q0, q5, r12
	str	r4, [r1], #4
	vsub.U16 q5, q3, q7
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	vmul.S16 q7, q5, q1
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vsub.U16 q1, q6, q4
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vqrdmulh.S16 q2, q5, q2
	eor	r3, r4, r4, LSR #8
	vadd.U16 q4, q6, q4
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vmla.S16 q7, q2, r12
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	vldrw.U32 q6, [r11, #16]
	eors	r5, r5, r6
	vqrdmulh.S16 q5, q1, q6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vsub.U16 q2, q7, q0
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	vqrdmulh.S16 q6, q2, q6
	and	r3, r3, #0x00F000F0
	vldrw.U32 q3, [r11], #(3*32)
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vmul.S16 q2, q2, q3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vstrw.U32 q4, [r7], #64
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vmla.S16 q2, q6, r12
	eor	r6, r5, r5, LSR #2
	vstrw.U32 q2, [r7, #-16]
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	vmul.S16 q1, q1, q3
	eors	r4, r4, r3
	eors	r5, r5, r6
	vldrw.U32 q3, [r7, #32]
	eor	r4, r4, r3, LSL #2
	vmla.S16 q1, q5, r12
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	vadd.U16 q5, q7, q0
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vqrdmulh.S16 q4, q3, r9
	and	r6, r6, #0x22222222
	vstrw.U32 q1, [r7, #-32]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmul.S16 q3, q3, r8
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vstrw.U32 q5, [r7, #-48]
	str	r4, [r1], #4
	vmla.S16 q3, q4, r12
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	vldrw.U32 q7, [r7, #48]
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vmul.S16 q4, q7, r8
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vldrw.U32 q1, [r7, #16]
	eor	r3, r4, r4, LSR #8
	vqrdmulh.S16 q6, q7, r9
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vldrw.U32 q0, [r7]
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	vmla.S16 q4, q6, r12
	eors	r5, r5, r6
	vqrdmulh.S16 q6, q1, r9
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vsub.U16 q5, q3, q4
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	vmul.S16 q7, q1, r8
	and	r3, r3, #0x00F000F0
	vadd.U16 q4, q3, q4
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vmla.S16 q7, q6, r12
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vmul.S16 q3, q0, r8
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vldrw.U32 q1, [r11, #32]
	eor	r6, r5, r5, LSR #2
	vqrdmulh.S16 q2, q0, r9
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	vldrw.U32 q0, [r11, #64]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmla.S16 q3, q2, r12
	eor	r4, r4, r3, LSL #2
	vldrw.U32 q2, [r11, #80]
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	vmul.S16 q0, q5, q0
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vadd.U16 q6, q3, q7
	and	r6, r6, #0x22222222
	vqrdmulh.S16 q5, q5, q2
	eors	r4, r4, r3
	eors	r5, r5, r6
	vldrw.U32 q2, [r11, #48]
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vmla.S16 q0, q5, r12
	str	r4, [r1], #4
	vsub.U16 q5, q3, q7
	str	r5, [r1], #4
	ldrd	r4, r5, [r0], #8
	vmul.S16 q7, q5, q1
	movs	r3, r4
	bfi	r4, r5, #16, #16
	vsub.U16 q1, q6, q4
	bfc	r5, #0, #16
	orr	r5, r5, r3, LSR #16
	vqrdmulh.S16 q2, q5, q2
	eor	r3, r4, r4, LSR #8
	vadd.U16 q4, q6, q4
	eor	r6, r5, r5, LSR #8
	and	r3, r3, #0x0000FF00
	vmla.S16 q7, q2, r12
	and	r6, r6, #0x0000FF00
	eors	r4, r4, r3
	vldrw.U32 q6, [r11, #16]
	eors	r5, r5, r6
	vqrdmulh.S16 q5, q1, q6
	eor	r4, r4, r3, LSL #8
	eor	r5, r5, r6, LSL #8
	vsub.U16 q2, q7, q0
	eor	r3, r4, r4, LSR #4
	eor	r6, r5, r5, LSR #4
	vqrdmulh.S16 q6, q2, q6
	and	r3, r3, #0x00F000F0
	vldrw.U32 q3, [r11], #(3*32)
	and	r6, r6, #0x00F000F0
	eors	r4, r4, r3
	vmul.S16 q2, q2, q3
	eors	r5, r5, r6
	eor	r4, r4, r3, LSL #4
	vstrw.U32 q4, [r7], #64
	eor	r5, r5, r6, LSL #4
	eor	r3, r4, r4, LSR #2
	vmla.S16 q2, q6, r12
	eor	r6, r5, r5, LSR #2
	vstrw.U32 q2, [r7, #-16]
	and	r3, r3, #0x0C0C0C0C
	and	r6, r6, #0x0C0C0C0C
	vmul.S16 q1, q1, q3
	eors	r4, r4, r3
	eors	r5, r5, r6
	vldrw.U32 q3, [r7, #32]
	eor	r4, r4, r3, LSL #2
	vmla.S16 q1, q5, r12
	eor	r5, r5, r6, LSL #2
	eor	r3, r4, r4, LSR #1
	vadd.U16 q5, q7, q0
	eor	r6, r5, r5, LSR #1
	and	r3, r3, #0x22222222
	vqrdmulh.S16 q4, q3, r9
	and	r6, r6, #0x22222222
	vstrw.U32 q1, [r7, #-32]
	eors	r4, r4, r3
	eors	r5, r5, r6
	vmul.S16 q3, q3, r8
	eor	r4, r4, r3, LSL #1
	eor	r5, r5, r6, LSL #1
	vstrw.U32 q5, [r7, #-48]
	str	r4, [r1], #4
	str	r5, [r1], #4
	CA_EPI
	.size	expca_merged, .-expca_merged
	.ltorg
