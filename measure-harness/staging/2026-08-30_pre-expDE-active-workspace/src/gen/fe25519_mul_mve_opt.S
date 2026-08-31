/* expAM1b — fe25519_mul_mve 의 슬라이스 로드 재사용 최적화본
 *
 * void fe25519_mul_mve_opt(uint32_t r[10], const uint32_t a[10], const uint32_t b[10]);
 *
 * 원본(fe25519_mul_mve)과 **수학·표현·결과가 완전히 동일**하고 스케줄만 다르다.
 * 설계문서 2026-08-25_expAM_x25519_mve_design.md §7-3 이 예고한
 * "정적 병목 1회 수정" 후보를 실제로 구현해 측정하기 위한 것이다.
 *
 * 관찰:
 *   - 고차 열(k=10..18)은 BREV 슬라이스 시작이 **항상 word 0** 이므로 서로 다른
 *     BREV 벡터가 3개(BREV[0..3], [4..7], [8..11])뿐인데 원본은 15번 재로드한다.
 *   - 저차 열(k=0..9)은 A 슬라이스 시작이 **항상 word 0** 이므로 서로 다른 A 벡터가
 *     6개(A2/A 각각 chunk0,1,2)뿐인데 원본은 18번 재로드한다.
 *   -> 이들을 q4..q7 에 상주시키면 vldrw 69 -> 44 (25개 감소).
 *      대가로 q4..q7 이 callee-saved 라 vpush/vpop {d8-d15} 가 붙는다.
 *
 * ABI: AAPCS.  q4..q7 사용 -> vpush {d8-d15} 필요.  분기 0개(상수시간).
 */

	.syntax unified
	.thumb

#ifdef AM_PLAIN_TEXT
	.section .text.fe25519_mul_mve_opt, "ax", %progbits
#else
	.section .itcm_code_from_flash, "ax", %progbits
#endif
	.align 4

	.equ	G_ABUF,		0
	.equ	G_A2BUF,	64
	.equ	G_BREV,		128
	.equ	G_COLHI,	192
	.equ	G_SIZE,		264

/* 고차 열: A 슬라이스만 로드, BREV chunk 는 q5/q6/q7 상주 */
	.macro	COLHI	ab, aw, n
	vldrw.u32	q0, [r3, #(\ab + 4*(\aw))]
	vmlaldav.u32	r4, r5, q0, q5
	.if \n >= 2
	vldrw.u32	q1, [r3, #(\ab + 4*(\aw + 4))]
	vmlaldava.u32	r4, r5, q1, q6
	.endif
	.if \n >= 3
	vldrw.u32	q0, [r3, #(\ab + 4*(\aw + 8))]
	vmlaldava.u32	r4, r5, q0, q7
	.endif
	.endm

/* 저차 열: A chunk 는 상주 레지스터, BREV 슬라이스만 로드 */
	.macro	COLLO	bw, n, qa0, qa1, qa2
	vldrw.u32	q0, [r3, #(G_BREV + 4*(\bw))]
	vmlaldav.u32	r4, r5, \qa0, q0
	.if \n >= 2
	vldrw.u32	q1, [r3, #(G_BREV + 4*(\bw + 4))]
	vmlaldava.u32	r4, r5, \qa1, q1
	.endif
	.if \n >= 3
	vldrw.u32	q0, [r3, #(G_BREV + 4*(\bw + 8))]
	vmlaldava.u32	r4, r5, \qa2, q0
	.endif
	.endm

	.macro	GFIN	k, w, fold
	.if \fold
	ldrd	r6, r7, [r3, #(G_COLHI + 8*(\k))]
	umull	r10, r11, r6, r9
	mla	r11, r7, r9, r11
	adds	r4, r4, r10
	adcs	r5, r5, r11
	.endif
	adds	r4, r4, r1
	adcs	r5, r5, r2
	ubfx	r6, r4, #0, #\w
	str	r6, [r0, #(4*(\k))]
	lsrs	r1, r4, #\w
	orr	r1, r1, r5, lsl #(32 - \w)
	lsr	r2, r5, #\w
	.endm

	.type	fe25519_mul_mve_opt, %function
	.global	fe25519_mul_mve_opt
fe25519_mul_mve_opt:
	push	{r4-r11, lr}
	vpush	{d8-d15}			/* q4..q7 사용 대가 */
	sub	sp, sp, #G_SIZE

	adr	r3, .Lgmul2
	vldrw.u32	q3, [r3]
	mov	r3, sp

	vldrw.u32	q0, [r1]
	vldrw.u32	q1, [r1, #16]
	ldrd	r4, r5, [r1, #32]
	vstrw.32	q0, [r3, #(G_ABUF)]
	vstrw.32	q1, [r3, #(G_ABUF + 16)]
	strd	r4, r5, [r3, #(G_ABUF + 32)]

	vmul.i32	q0, q0, q3
	vmul.i32	q1, q1, q3
	vstrw.32	q0, [r3, #(G_A2BUF)]
	vstrw.32	q1, [r3, #(G_A2BUF + 16)]
	lsl	r6, r5, #1
	strd	r4, r6, [r3, #(G_A2BUF + 32)]

	ldrd	r4, r5, [r2, #32]
	strd	r5, r4, [r3, #(G_BREV)]
	ldrd	r4, r5, [r2, #24]
	strd	r5, r4, [r3, #(G_BREV + 8)]
	ldrd	r4, r5, [r2, #16]
	strd	r5, r4, [r3, #(G_BREV + 16)]
	ldrd	r4, r5, [r2, #8]
	strd	r5, r4, [r3, #(G_BREV + 24)]
	ldrd	r4, r5, [r2]
	strd	r5, r4, [r3, #(G_BREV + 32)]

	vmov.i32	q0, #0
	vstrw.32	q0, [r3, #(G_ABUF + 40)]
	vstrw.32	q0, [r3, #(G_A2BUF + 40)]
	vstrw.32	q0, [r3, #(G_BREV + 40)]

	/* ---- 고차 열: BREV chunk 3개를 q5/q6/q7 에 상주 ---------------- */
	vldrw.u32	q5, [r3, #(G_BREV)]
	vldrw.u32	q6, [r3, #(G_BREV + 16)]
	vldrw.u32	q7, [r3, #(G_BREV + 32)]

	COLHI	G_A2BUF, 9, 1			/* k=18 */
	strd	r4, r5, [r3, #(G_COLHI + 8*8)]
	COLHI	G_ABUF,  8, 1			/* k=17 */
	strd	r4, r5, [r3, #(G_COLHI + 8*7)]
	COLHI	G_A2BUF, 7, 1			/* k=16 */
	strd	r4, r5, [r3, #(G_COLHI + 8*6)]
	COLHI	G_ABUF,  6, 1			/* k=15 */
	strd	r4, r5, [r3, #(G_COLHI + 8*5)]
	COLHI	G_A2BUF, 5, 2			/* k=14 */
	strd	r4, r5, [r3, #(G_COLHI + 8*4)]
	COLHI	G_ABUF,  4, 2			/* k=13 */
	strd	r4, r5, [r3, #(G_COLHI + 8*3)]
	COLHI	G_A2BUF, 3, 2			/* k=12 */
	strd	r4, r5, [r3, #(G_COLHI + 8*2)]
	COLHI	G_ABUF,  2, 2			/* k=11 */
	strd	r4, r5, [r3, #(G_COLHI + 8*1)]
	COLHI	G_A2BUF, 1, 3			/* k=10 */
	strd	r4, r5, [r3, #(G_COLHI + 8*0)]

	/* ---- 저차 열: A chunk 6개를 q2..q7 에 상주 --------------------- */
	vldrw.u32	q2, [r3, #(G_A2BUF)]		/* A2 chunk0 */
	vldrw.u32	q3, [r3, #(G_A2BUF + 16)]	/* A2 chunk1 */
	vldrw.u32	q4, [r3, #(G_A2BUF + 32)]	/* A2 chunk2 */
	vldrw.u32	q5, [r3, #(G_ABUF)]		/* A  chunk0 */
	vldrw.u32	q6, [r3, #(G_ABUF + 16)]	/* A  chunk1 */
	vldrw.u32	q7, [r3, #(G_ABUF + 32)]	/* A  chunk2 */

	movs	r1, #0
	movs	r2, #0
	movs	r9, #19

	COLLO	9, 1, q2, q3, q4		/* k=0  (짝수 -> A2) */
	GFIN	0, 26, 1
	COLLO	8, 1, q5, q6, q7		/* k=1 */
	GFIN	1, 25, 1
	COLLO	7, 1, q2, q3, q4		/* k=2 */
	GFIN	2, 26, 1
	COLLO	6, 1, q5, q6, q7		/* k=3 */
	GFIN	3, 25, 1
	COLLO	5, 2, q2, q3, q4		/* k=4 */
	GFIN	4, 26, 1
	COLLO	4, 2, q5, q6, q7		/* k=5 */
	GFIN	5, 25, 1
	COLLO	3, 2, q2, q3, q4		/* k=6 */
	GFIN	6, 26, 1
	COLLO	2, 2, q5, q6, q7		/* k=7 */
	GFIN	7, 25, 1
	COLLO	1, 3, q2, q3, q4		/* k=8 */
	GFIN	8, 26, 1
	COLLO	0, 3, q5, q6, q7		/* k=9 */
	GFIN	9, 25, 0

	umull	r6, r7, r1, r9
	mla	r7, r2, r9, r7
	ldr	r8, [r0]
	adds	r6, r6, r8
	adc	r7, r7, #0
	ubfx	r8, r6, #0, #26
	str	r8, [r0]
	lsrs	r6, r6, #26
	orr	r6, r6, r7, lsl #6

	ldr	r8, [r0, #4]
	add	r8, r8, r6
	ubfx	r6, r8, #0, #25
	str	r6, [r0, #4]
	lsr	r8, r8, #25

	ldr	r6, [r0, #8]
	add	r6, r6, r8
	str	r6, [r0, #8]

	add	sp, sp, #G_SIZE
	vpop	{d8-d15}
	pop	{r4-r11, pc}
	.size	fe25519_mul_mve_opt, .-fe25519_mul_mve_opt

	.align 4
.Lgmul2:
	.word	1, 2, 1, 2
