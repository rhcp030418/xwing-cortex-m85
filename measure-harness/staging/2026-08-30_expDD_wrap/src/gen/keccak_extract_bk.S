/* 실험 BK (K32): fromBitInterleaving 두 반쪽을 1:1 교차 배치한 whole-lane 추출.
 *
 * 사전등록: 2026-08-26_expBK_k32_extract_prereg.md
 * 원본 __KeccakF1600_StateExtractLanes 는 x0/x1 두 독립 사슬이 임시 r3 하나를 공유해
 * 직렬화된다. x1 사슬에 r6 를 따로 주고 교차 배치한다. 명령 수 40 불변.
 *
 * void KeccakF1600_StateExtractLanes_bk(uint64_t *state, uint8_t *data, unsigned lanes)
 *   r0 = state, r1 = data, r2 = laneCount (>0)
 */
	.syntax unified
	.thumb
	.text
	.align 4
	.global	KeccakF1600_StateExtractLanes_bk
	.type	KeccakF1600_StateExtractLanes_bk, %function
KeccakF1600_StateExtractLanes_bk:
	push	{r4, r5, r6, lr}
1:
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
	subs	r2, r2, #1
	str	r5, [r1], #4
	bne	1b
	pop	{r4, r5, r6, pc}
	.size	KeccakF1600_StateExtractLanes_bk, .-KeccakF1600_StateExtractLanes_bk
