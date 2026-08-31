/* expAM1b — X25519 field squaring, Armv8.1-M MVE (Helium)
 *
 * void fe25519_sqr_mve(uint32_t r[10], const uint32_t a[10]);
 *
 * 표현은 fe25519_mul_mve 와 동일한 radix 2^25.5 교대다.
 *
 * 대칭성: C_k = sum_{i+j=k} w_ij a_i a_j  (w_ij = 2 이면 i,j 둘 다 홀수, 아니면 1)
 *            = 2 * sum_{i<j, i+j=k} w_ij a_i a_j  +  [k 짝수] * w_mm * a_m^2  (m=k/2)
 * 따라서 부분곱이 100 -> 55 로 준다.
 *
 * 난점: 반쪽 범위 i = lo..h  (h = floor((k-1)/2)) 의 길이가 4의 배수가 아니라
 * 마지막 chunk 에 쓸데없는 lane 이 남는다. mul 커널처럼 상단 0 패딩으로는 못 지운다
 * (버리려는 항이 범위 '끝'이 아니라 대칭 짝이라 값이 0 이 아니다).
 *   -> **끝-정렬 chunk + 음수 인덱스 0 패딩**으로 해결한다.
 *      chunk 를 h 에서 아래로 4개씩 끊으면 남는 lane 은 항상 슬라이스 '앞'에 생기고,
 *      그 lane 의 BREV 짝은 인덱스가 음수로 내려가 0 패딩에 떨어진다.
 *      덕분에 VPT predication(열마다 vctp+vpst 2명령)이 전혀 필요 없다.
 *
 * 명령 회계 (정적): vmlaldav(a).u32 **18개** (mul 은 33개).
 *
 * MVE 에 64-bit lane 산술이 없으므로 접기·carry 는 mul 과 똑같이 전부 스칼라다.
 *
 * ABI: AAPCS. q0..q3 만 사용 -> q4..q7 저장 불필요. 분기 0개(상수시간).
 */

	.syntax unified
	.thumb

#ifdef AM_PLAIN_TEXT
	.section .text.fe25519_sqr_mve, "ax", %progbits
#else
	.section .itcm_code_from_flash, "ax", %progbits
#endif
	.align 4

	/* 프레임 (r3 기준 바이트 오프셋).  각 버퍼는 index -4 부터 잡아 두고
	 * F_* 는 **index 0 의 오프셋**을 가리킨다.  접근 index 범위는 -4..12.
	 *     0..79   : ABUF  물리 (index -4..15)
	 *    80..159  : A2BUF 물리
	 *   160..239  : BREV  물리
	 *   240..311  : COLHI (열 10..18, 9 * 8 B)
	 */
	.equ	F_ABUF,		16
	.equ	F_A2BUF,	96
	.equ	F_BREV,		176
	.equ	F_COLHI,	240
	.equ	F_SIZE,		312

/* 반쪽 열 내적 -> r4:r5, 그리고 2배.
 *   ab : A 쪽 버퍼 (F_ABUF / F_A2BUF),  as : A chunk0 시작 index (= h-3)
 *   bs : BREV chunk0 시작 index (= as + 9 - k),  n : chunk 수 */
	.macro	SQCOL	ab, as, bs, n
	vldrw.u32	q0, [r3, #(\ab + 4*(\as))]
	vldrw.u32	q1, [r3, #(F_BREV + 4*(\bs))]
	vmlaldav.u32	r4, r5, q0, q1
	.if \n >= 2
	vldrw.u32	q2, [r3, #(\ab + 4*(\as - 4))]
	vldrw.u32	q3, [r3, #(F_BREV + 4*(\bs - 4))]
	vmlaldava.u32	r4, r5, q2, q3
	.endif
	adds	r4, r4, r4
	adcs	r5, r5, r5
	.endm

/* 대각항 a_m^2 (m 홀수면 2배) 을 r4:r5 에 더한다 */
	.macro	SQDIAG	m, odd
	ldr	r6, [r3, #(F_ABUF + 4*(\m))]
	umull	r6, r7, r6, r6
	.if \odd
	adds	r6, r6, r6
	adcs	r7, r7, r7
	.endif
	adds	r4, r4, r6
	adcs	r5, r5, r7
	.endm

/* 저차 열 마무리: 접기 + running carry + limb 추출 (mul 커널과 동일) */
	.macro	SQFIN	k, w, fold
	.if \fold
	ldrd	r6, r7, [r3, #(F_COLHI + 8*(\k))]
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

	.type	fe25519_sqr_mve, %function
	.global	fe25519_sqr_mve
fe25519_sqr_mve:
	push	{r4-r11, lr}
	sub	sp, sp, #F_SIZE

	adr	r3, .Lsqmul2
	vldrw.u32	q3, [r3]		/* {1, 2, 1, 2} */
	mov	r3, sp

	/* ABUF */
	vldrw.u32	q0, [r1]		/* a0..a3 */
	vldrw.u32	q1, [r1, #16]		/* a4..a7 */
	ldrd	r4, r5, [r1, #32]		/* a8, a9 */
	vstrw.32	q0, [r3, #(F_ABUF)]
	vstrw.32	q1, [r3, #(F_ABUF + 16)]
	strd	r4, r5, [r3, #(F_ABUF + 32)]

	/* A2BUF : 홀수 lane 2배 */
	vmul.i32	q0, q0, q3
	vmul.i32	q1, q1, q3
	vstrw.32	q0, [r3, #(F_A2BUF)]
	vstrw.32	q1, [r3, #(F_A2BUF + 16)]
	lsl	r6, r5, #1
	strd	r4, r6, [r3, #(F_A2BUF + 32)]

	/* BREV[j] = a[9-j] */
	ldrd	r4, r5, [r1, #32]
	strd	r5, r4, [r3, #(F_BREV)]
	ldrd	r4, r5, [r1, #24]
	strd	r5, r4, [r3, #(F_BREV + 8)]
	ldrd	r4, r5, [r1, #16]
	strd	r5, r4, [r3, #(F_BREV + 16)]
	ldrd	r4, r5, [r1, #8]
	strd	r5, r4, [r3, #(F_BREV + 24)]
	ldrd	r4, r5, [r1]
	strd	r5, r4, [r3, #(F_BREV + 32)]

	/* 0 패딩: index -4..-1 과 10..13, 세 버퍼 모두 */
	vmov.i32	q0, #0
	vstrw.32	q0, [r3, #(F_ABUF  - 16)]
	vstrw.32	q0, [r3, #(F_ABUF  + 40)]
	vstrw.32	q0, [r3, #(F_A2BUF - 16)]
	vstrw.32	q0, [r3, #(F_A2BUF + 40)]
	vstrw.32	q0, [r3, #(F_BREV  - 16)]
	vstrw.32	q0, [r3, #(F_BREV  + 40)]

	/* ---- 고차 열 18..10 -> COLHI[8..0] ---------------------------- */
	/* k=18: 반쪽 없음, 대각 a9^2 (m=9 홀수) */
	movs	r4, #0
	movs	r5, #0
	SQDIAG	9, 1
	strd	r4, r5, [r3, #(F_COLHI + 8*8)]

	SQCOL	F_ABUF,  5, -3, 1		/* k=17 */
	strd	r4, r5, [r3, #(F_COLHI + 8*7)]

	SQCOL	F_A2BUF, 4, -3, 1		/* k=16 */
	SQDIAG	8, 0
	strd	r4, r5, [r3, #(F_COLHI + 8*6)]

	SQCOL	F_ABUF,  4, -2, 1		/* k=15 */
	strd	r4, r5, [r3, #(F_COLHI + 8*5)]

	SQCOL	F_A2BUF, 3, -2, 1		/* k=14 */
	SQDIAG	7, 1
	strd	r4, r5, [r3, #(F_COLHI + 8*4)]

	SQCOL	F_ABUF,  3, -1, 1		/* k=13 */
	strd	r4, r5, [r3, #(F_COLHI + 8*3)]

	SQCOL	F_A2BUF, 2, -1, 1		/* k=12 */
	SQDIAG	6, 0
	strd	r4, r5, [r3, #(F_COLHI + 8*2)]

	SQCOL	F_ABUF,  2, 0, 1		/* k=11 */
	strd	r4, r5, [r3, #(F_COLHI + 8*1)]

	SQCOL	F_A2BUF, 1, 0, 1		/* k=10 */
	SQDIAG	5, 1
	strd	r4, r5, [r3, #(F_COLHI + 8*0)]

	/* ---- 저차 열 0..9 + 접기 + carry ----------------------------- */
	movs	r1, #0
	movs	r2, #0
	movs	r9, #19

	movs	r4, #0				/* k=0: 반쪽 없음 */
	movs	r5, #0
	SQDIAG	0, 0
	SQFIN	0, 26, 1

	SQCOL	F_ABUF,  -3, 5, 1		/* k=1 */
	SQFIN	1, 25, 1

	SQCOL	F_A2BUF, -3, 4, 1		/* k=2 */
	SQDIAG	1, 1
	SQFIN	2, 26, 1

	SQCOL	F_ABUF,  -2, 4, 1		/* k=3 */
	SQFIN	3, 25, 1

	SQCOL	F_A2BUF, -2, 3, 1		/* k=4 */
	SQDIAG	2, 0
	SQFIN	4, 26, 1

	SQCOL	F_ABUF,  -1, 3, 1		/* k=5 */
	SQFIN	5, 25, 1

	SQCOL	F_A2BUF, -1, 2, 1		/* k=6 */
	SQDIAG	3, 1
	SQFIN	6, 26, 1

	SQCOL	F_ABUF,   0, 2, 1		/* k=7 */
	SQFIN	7, 25, 1

	SQCOL	F_A2BUF,  0, 1, 1		/* k=8 */
	SQDIAG	4, 0
	SQFIN	8, 26, 1

	SQCOL	F_ABUF,   1, 1, 2		/* k=9 (반쪽 5항 -> chunk 2개) */
	SQFIN	9, 25, 0

	/* ---- 최상위 carry 되접기 + 리플 2회 -------------------------- */
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

	add	sp, sp, #F_SIZE
	pop	{r4-r11, pc}
	.size	fe25519_sqr_mve, .-fe25519_sqr_mve

	.align 4
.Lsqmul2:
	.word	1, 2, 1, 2
