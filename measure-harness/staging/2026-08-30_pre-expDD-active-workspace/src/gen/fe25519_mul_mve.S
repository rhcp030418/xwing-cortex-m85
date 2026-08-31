/* expAM1 후보 B1 — X25519 field multiplication, Armv8.1-M MVE (Helium)
 *
 * void fe25519_mul_mve(uint32_t r[10], const uint32_t a[10], const uint32_t b[10]);
 *
 * 표현: radix 2^25.5 교대 (limb i 폭 = 짝수 i면 26, 홀수 i면 25), off_i = ceil(25.5*i).
 *   입력 상한: a[i], b[i] < 2^26 (i 짝수) / < 2^25 (i 홀수)
 *   출력 상한: 동일 (마지막 wrap 후 최대 2^26 + 1 미만)
 *
 * 구조 (설계 근거는 2026-08-25_expAM_x25519_mve_design.md §7):
 *   열-스캐닝 schoolbook. 열 k = sum_{i+j=k} a[i]*b[j], k = 0..18.
 *   brev[j] = b[9-j] 를 만들면 열 k 의 항이 a[i] * brev[i + (9-k)] 로 두 연속 슬라이스가
 *   되어 vmlaldav(a).u32 의 lane 내적에 그대로 들어간다.
 *   off_{i+10} = off_i + 255 이므로 wrap 계수는 정확히 19다.
 *   홀수 i, 홀수 j 의 곱만 x2 보정이 필요하고 그런 항은 짝수 열에만 생기므로,
 *   홀수 limb 을 미리 2배한 A2 버퍼를 짝수 열에, 원본 A 를 홀수 열에 쓴다.
 *
 * 명령 회계 (정적): vmlaldav(a).u32 33개, lane 이용률 100/(33*4) = 75.8%.
 *
 * MVE 에는 64-bit lane 산술이 없다(vadd.i64 / vshr.u64 / vqmovnb.u64 전부 어셈블 거부).
 * 따라서 접기(fold)와 carry 전파는 전부 스칼라다. 이것이 이 커널의 구조적 비용이다.
 *
 * ABI: AAPCS. q0..q3 만 사용하므로 q4..q7(callee-saved) 저장이 필요 없다.
 *      r4..r11, lr 만 push. 비밀 의존 분기·주소 없음 (직선 코드, 루프 없음).
 */

	.syntax unified
	.thumb

	/* 측정 위생: A 비교군(x25519-cortex-m4-gcc.s)과 같은 배치여야 한다.
	 * 단일변수 조건이므로 A 와 동일 섹션에 둔다.
	 * QEMU 기능검증 빌드는 ITCM 섹션이 없으므로 -DAM_PLAIN_TEXT 로 .text 에 둔다.
	 * (기능만 확인하는 경로이며 사이클 값은 어떤 문서에도 쓰지 않는다.) */
#ifdef AM_PLAIN_TEXT
	.section .text.fe25519_mul_mve, "ax", %progbits
#else
	.section .itcm_code_from_flash, "ax", %progbits
#endif
	.align 4

	/* 프레임 (r3 기준 바이트 오프셋)
	 *     0 : ABUF   [0..15]  a, index 10..13 은 0 패딩
	 *    64 : A2BUF  [0..15]  홀수 limb 2배본, index 10..13 은 0 패딩
	 *   128 : BREV   [0..15]  b 역순, index 10..13 은 0 패딩
	 *   192 : COLHI  [0..8]   열 10..18 의 64-bit 값 (9 * 8 = 72 B)
	 *   합 264 B
	 * 접근하는 최대 word index 는 A/BREV 모두 12 → 10..12 만 0이면 충분하다.
	 */
	.equ	F_ABUF,		0
	.equ	F_A2BUF,	64
	.equ	F_BREV,		128
	.equ	F_COLHI,	192
	.equ	F_SIZE,		264

/* 열 하나를 누산기 r4:r5 에 계산한다.
 *   ab : A 쪽 버퍼 베이스 (F_ABUF 또는 F_A2BUF)
 *   aw : A 슬라이스 시작 word index
 *   bw : BREV 슬라이스 시작 word index
 *   n  : chunk 수 (1..3)
 * 첫 chunk 는 vmlaldav(누산 없음)라 누산기 사전 초기화가 필요 없다.
 */
	.macro	COLUMN	ab, aw, bw, n
	vldrw.u32	q0, [r3, #(\ab + 4*(\aw))]
	vldrw.u32	q1, [r3, #(F_BREV + 4*(\bw))]
	vmlaldav.u32	r4, r5, q0, q1
	.if \n >= 2
	vldrw.u32	q2, [r3, #(\ab + 4*(\aw + 4))]
	vldrw.u32	q3, [r3, #(F_BREV + 4*(\bw + 4))]
	vmlaldava.u32	r4, r5, q2, q3
	.endif
	.if \n >= 3
	vldrw.u32	q0, [r3, #(\ab + 4*(\aw + 8))]
	vldrw.u32	q1, [r3, #(F_BREV + 4*(\bw + 8))]
	vmlaldava.u32	r4, r5, q0, q1
	.endif
	.endm

/* 저차 열 k 를 마무리한다: 접기 + running carry + limb 추출.
 *   k    : 열 번호 (0..9)
 *   w    : limb 폭 (짝수 k 면 26, 홀수 k 면 25)
 *   fold : 1 이면 19*COLHI[k] 를 더한다 (k <= 8)
 * 입력  r4:r5 = 열 값, r1:r2 = running carry, r9 = 19
 * 출력  r[k] 저장, r1:r2 = 새 carry
 */
	.macro	FINISH	k, w, fold
	.if \fold
	ldrd	r6, r7, [r3, #(F_COLHI + 8*(\k))]
	umull	r10, r11, r6, r9		/* 19 * lo */
	mla	r11, r7, r9, r11		/* + (19 * hi) << 32 */
	adds	r4, r4, r10
	adcs	r5, r5, r11
	.endif
	adds	r4, r4, r1			/* + running carry */
	adcs	r5, r5, r2
	ubfx	r6, r4, #0, #\w
	str	r6, [r0, #(4*(\k))]
	lsrs	r1, r4, #\w			/* carry = (r5:r4) >> w */
	orr	r1, r1, r5, lsl #(32 - \w)
	lsr	r2, r5, #\w
	.endm

	.type	fe25519_mul_mve, %function
	.global	fe25519_mul_mve
fe25519_mul_mve:
	push	{r4-r11, lr}
	sub	sp, sp, #F_SIZE

	/* ---- 셋업: ABUF / A2BUF / BREV ---------------------------------- */
	adr	r3, .Lmul2
	vldrw.u32	q3, [r3]		/* {1, 2, 1, 2} */
	mov	r3, sp

	vldrw.u32	q0, [r1]		/* a0..a3 */
	vldrw.u32	q1, [r1, #16]		/* a4..a7 */
	ldrd	r4, r5, [r1, #32]		/* a8, a9 */
	vstrw.32	q0, [r3, #(F_ABUF)]
	vstrw.32	q1, [r3, #(F_ABUF + 16)]
	strd	r4, r5, [r3, #(F_ABUF + 32)]

	vmul.i32	q0, q0, q3		/* 홀수 lane 2배 */
	vmul.i32	q1, q1, q3
	vstrw.32	q0, [r3, #(F_A2BUF)]
	vstrw.32	q1, [r3, #(F_A2BUF + 16)]
	lsl	r6, r5, #1			/* a9 는 홀수 index */
	strd	r4, r6, [r3, #(F_A2BUF + 32)]

	/* brev[j] = b[9-j].  strd 는 Thumb-2 에서 임의 레지스터 쌍을 허용한다. */
	ldrd	r4, r5, [r2, #32]		/* b8, b9  */
	strd	r5, r4, [r3, #(F_BREV)]		/* -> b9, b8 */
	ldrd	r4, r5, [r2, #24]		/* b6, b7  */
	strd	r5, r4, [r3, #(F_BREV + 8)]
	ldrd	r4, r5, [r2, #16]		/* b4, b5  */
	strd	r5, r4, [r3, #(F_BREV + 16)]
	ldrd	r4, r5, [r2, #8]		/* b2, b3  */
	strd	r5, r4, [r3, #(F_BREV + 24)]
	ldrd	r4, r5, [r2]			/* b0, b1  */
	strd	r5, r4, [r3, #(F_BREV + 32)]

	/* index 10..13 을 0 으로. 범위 밖 항은 한쪽 인자가 0 이라 저절로 소거된다. */
	vmov.i32	q0, #0
	vstrw.32	q0, [r3, #(F_ABUF + 40)]
	vstrw.32	q0, [r3, #(F_A2BUF + 40)]
	vstrw.32	q0, [r3, #(F_BREV + 40)]

	/* ---- 고차 열 18..10 -> COLHI[8..0] ------------------------------ */
	/* 짝수 열은 A2BUF, 홀수 열은 ABUF. aw = k-9, bw = 0, n = ceil((19-k)/4) */
	COLUMN	F_A2BUF, 9, 0, 1		/* k=18 (L=1) — 짝수 열이므로 A2 */
	strd	r4, r5, [r3, #(F_COLHI + 8*8)]
	COLUMN	F_ABUF,  8, 0, 1		/* k=17 (L=2) */
	strd	r4, r5, [r3, #(F_COLHI + 8*7)]
	COLUMN	F_A2BUF, 7, 0, 1		/* k=16 (L=3) */
	strd	r4, r5, [r3, #(F_COLHI + 8*6)]
	COLUMN	F_ABUF,  6, 0, 1		/* k=15 (L=4) */
	strd	r4, r5, [r3, #(F_COLHI + 8*5)]
	COLUMN	F_A2BUF, 5, 0, 2		/* k=14 (L=5) */
	strd	r4, r5, [r3, #(F_COLHI + 8*4)]
	COLUMN	F_ABUF,  4, 0, 2		/* k=13 (L=6) */
	strd	r4, r5, [r3, #(F_COLHI + 8*3)]
	COLUMN	F_A2BUF, 3, 0, 2		/* k=12 (L=7) */
	strd	r4, r5, [r3, #(F_COLHI + 8*2)]
	COLUMN	F_ABUF,  2, 0, 2		/* k=11 (L=8) */
	strd	r4, r5, [r3, #(F_COLHI + 8*1)]
	COLUMN	F_A2BUF, 1, 0, 3		/* k=10 (L=9) */
	strd	r4, r5, [r3, #(F_COLHI + 8*0)]

	/* ---- 저차 열 0..9 + 접기 + carry -------------------------------- */
	movs	r1, #0				/* running carry lo */
	movs	r2, #0				/* running carry hi */
	movs	r9, #19

	COLUMN	F_A2BUF, 0, 9, 1		/* k=0 */
	FINISH	0, 26, 1
	COLUMN	F_ABUF,  0, 8, 1		/* k=1 */
	FINISH	1, 25, 1
	COLUMN	F_A2BUF, 0, 7, 1		/* k=2 */
	FINISH	2, 26, 1
	COLUMN	F_ABUF,  0, 6, 1		/* k=3 */
	FINISH	3, 25, 1
	COLUMN	F_A2BUF, 0, 5, 2		/* k=4 */
	FINISH	4, 26, 1
	COLUMN	F_ABUF,  0, 4, 2		/* k=5 */
	FINISH	5, 25, 1
	COLUMN	F_A2BUF, 0, 3, 2		/* k=6 */
	FINISH	6, 26, 1
	COLUMN	F_ABUF,  0, 2, 2		/* k=7 */
	FINISH	7, 25, 1
	COLUMN	F_A2BUF, 0, 1, 3		/* k=8 */
	FINISH	8, 26, 1
	COLUMN	F_ABUF,  0, 0, 3		/* k=9 */
	FINISH	9, 25, 0

	/* ---- 최상위 carry 를 19배해 limb0 로 되접고 두 번 리플 ---------- */
	/* acc9 < 2^55.3 이므로 r2 = 0 이지만 형식상 64-bit 로 처리한다. */
	umull	r6, r7, r1, r9
	mla	r7, r2, r9, r7
	ldr	r8, [r0]
	adds	r6, r6, r8
	adc	r7, r7, #0
	ubfx	r8, r6, #0, #26
	str	r8, [r0]
	lsrs	r6, r6, #26
	orr	r6, r6, r7, lsl #6		/* limb1 로 갈 carry (< 2^9) */

	ldr	r8, [r0, #4]
	add	r8, r8, r6
	ubfx	r6, r8, #0, #25
	str	r6, [r0, #4]
	lsr	r8, r8, #25			/* 0 또는 1 */

	ldr	r6, [r0, #8]
	add	r6, r6, r8
	str	r6, [r0, #8]

	add	sp, sp, #F_SIZE
	pop	{r4-r11, pc}
	.size	fe25519_mul_mve, .-fe25519_mul_mve

	.align 4
.Lmul2:
	.word	1, 2, 1, 2
