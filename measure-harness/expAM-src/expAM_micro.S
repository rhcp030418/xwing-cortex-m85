/* expAM1 — A 비교군 AAPCS 래퍼 + 명령 스루풋 마이크로 커널
 *
 * 전부 .itcm_code_from_flash 에 둔다 (A 비교군 x25519-cortex-m4-gcc.s 와 동일 배치).
 * 사전등록 2026-08-25_expAM1_mve_mul_prereg.md §2 "코드 배치 단일변수" 요구.
 *
 * 마이크로 커널은 전부 **직선 64 명령**이며 내부 루프가 없다. 호출 오버헤드는
 * expam_micro_empty 로 별도 측정해 차감한다.
 */

	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits
	.align 4

/* ------------------------------------------------------------------
 * A 비교군 래퍼.
 * Lenngren fe25519_mul 은 AAPCS 가 아니다:
 *   입력 *r1=a, *r2=b / 출력 r0-r7 / 그 외 전부 clobber / sp 는 복원됨.
 * B1(fe25519_mul_mve) 과 같은 서명으로 맞춰 공정 비교한다:
 *   void fe25519_mul_lenn(uint32_t r[8], const uint32_t a[8], const uint32_t b[8]);
 * 두 군 모두 "포인터로 읽고 메모리에 쓴다"가 되도록 stm 1개를 붙인다.
 * ------------------------------------------------------------------ */
	.type	fe25519_mul_lenn, %function
	.global	fe25519_mul_lenn
fe25519_mul_lenn:
	push	{r4-r11, lr}
	sub	sp, sp, #8
	str	r0, [sp]			/* 출력 포인터 보관 (callee 가 sp 복원함) */
	bl	fe25519_mul			/* r1=a, r2=b 는 이미 맞다 */
	ldr	r8, [sp]
	stm	r8, {r0-r7}
	add	sp, sp, #8
	pop	{r4-r11, pc}
	.size	fe25519_mul_lenn, .-fe25519_mul_lenn

/* ------------------------------------------------------------------
 * 마이크로 스루풋 커널.  모두 void f(void *scratch);  scratch 는 DTCM 512 B, 16 B 정렬.
 * ------------------------------------------------------------------ */

/* 호출·측정 오버헤드 기준선 */
	.type	expam_micro_empty, %function
	.global	expam_micro_empty
expam_micro_empty:
	bx	lr
	.size	expam_micro_empty, .-expam_micro_empty

/* vmlaldava.u32 x64 — 누산기 4쌍 순환 (연속 명령 간 의존 없음) */
	.type	expam_micro_mac_indep, %function
	.global	expam_micro_mac_indep
expam_micro_mac_indep:
	push	{r4-r11, lr}
	vldrw.u32	q0, [r0]
	vldrw.u32	q1, [r0, #16]
	movs	r4, #0
	movs	r5, #0
	movs	r6, #0
	movs	r7, #0
	movs	r8, #0
	movs	r9, #0
	movs	r10, #0
	movs	r11, #0
	.rept 16
	vmlaldava.u32	r4, r5, q0, q1
	vmlaldava.u32	r6, r7, q0, q1
	vmlaldava.u32	r8, r9, q0, q1
	vmlaldava.u32	r10, r11, q0, q1
	.endr
	/* 결과를 소비해 최적화·제거 가능성을 없앤다 */
	add	r4, r4, r6
	add	r4, r4, r8
	add	r4, r4, r10
	str	r4, [r0, #32]
	pop	{r4-r11, pc}
	.size	expam_micro_mac_indep, .-expam_micro_mac_indep

/* vmlaldava.u32 x64 — 누산기 1쌍 체인 (연속 명령이 전부 의존) */
	.type	expam_micro_mac_dep, %function
	.global	expam_micro_mac_dep
expam_micro_mac_dep:
	push	{r4-r11, lr}
	vldrw.u32	q0, [r0]
	vldrw.u32	q1, [r0, #16]
	movs	r4, #0
	movs	r5, #0
	.rept 64
	vmlaldava.u32	r4, r5, q0, q1
	.endr
	str	r4, [r0, #32]
	pop	{r4-r11, pc}
	.size	expam_micro_mac_dep, .-expam_micro_mac_dep

/* vldrw.u32 x64 — 오프셋을 16 B 씩 돌려 같은 줄 반복 적중을 피한다 */
	.type	expam_micro_vldrw, %function
	.global	expam_micro_vldrw
expam_micro_vldrw:
	push	{r4-r11, lr}
	.set	AMOFF, 0
	.rept 16
	vldrw.u32	q0, [r0, #AMOFF]
	vldrw.u32	q1, [r0, #(AMOFF + 16)]
	vldrw.u32	q2, [r0, #(AMOFF + 32)]
	vldrw.u32	q3, [r0, #(AMOFF + 48)]
	.set	AMOFF, AMOFF + 64
	.if AMOFF >= 448
	.set	AMOFF, 0
	.endif
	.endr
	pop	{r4-r11, pc}
	.size	expam_micro_vldrw, .-expam_micro_vldrw

/* vmullb.u32 x64 — 목적 레지스터 2개 순환 */
	.type	expam_micro_vmull, %function
	.global	expam_micro_vmull
expam_micro_vmull:
	push	{r4-r11, lr}
	vldrw.u32	q0, [r0]
	vldrw.u32	q1, [r0, #16]
	.rept 32
	vmullb.u32	q2, q0, q1
	vmullb.u32	q3, q0, q1
	.endr
	vstrw.32	q2, [r0, #64]
	pop	{r4-r11, pc}
	.size	expam_micro_vmull, .-expam_micro_vmull

/* 스칼라 umaal x64 — A 의 코어 단가 */
	.type	expam_micro_umaal, %function
	.global	expam_micro_umaal
expam_micro_umaal:
	push	{r4-r11, lr}
	ldr	r2, [r0]
	ldr	r3, [r0, #4]
	movs	r4, #0
	movs	r5, #0
	movs	r6, #0
	movs	r7, #0
	movs	r8, #0
	movs	r9, #0
	movs	r10, #0
	movs	r11, #0
	.rept 16
	umaal	r4, r5, r2, r3
	umaal	r6, r7, r2, r3
	umaal	r8, r9, r2, r3
	umaal	r10, r11, r2, r3
	.endr
	add	r4, r4, r6
	add	r4, r4, r8
	add	r4, r4, r10
	str	r4, [r0, #32]
	pop	{r4-r11, pc}
	.size	expam_micro_umaal, .-expam_micro_umaal

/* vldrw x32 와 스칼라 ldr x32 교대 — 로드맵 40차 "스칼라 로드는 MVE 로드와
 * 듀얼이슈되지 않는다" 실측의 재현 여부 확인 */
	.type	expam_micro_mixed, %function
	.global	expam_micro_mixed
expam_micro_mixed:
	push	{r4-r11, lr}
	.set	AMOFF2, 0
	.rept 16
	vldrw.u32	q0, [r0, #AMOFF2]
	ldr	r4, [r0, #(AMOFF2 + 16)]
	vldrw.u32	q1, [r0, #(AMOFF2 + 32)]
	ldr	r5, [r0, #(AMOFF2 + 48)]
	.set	AMOFF2, AMOFF2 + 64
	.if AMOFF2 >= 448
	.set	AMOFF2, 0
	.endif
	.endr
	add	r4, r4, r5
	str	r4, [r0, #64]
	pop	{r4-r11, pc}
	.size	expam_micro_mixed, .-expam_micro_mixed

/* ==================================================================
 * expAM1b 추가분 — 2026-08-25
 * ================================================================== */

/* A 비교군 sqr 래퍼.
 * Lenngren fe25519_sqr 은 입력/출력이 모두 r0-r7 레지스터다(포인터 아님).
 *   void fe25519_sqr_lenn(uint32_t r[8], const uint32_t a[8]);
 * ldm 의 base 레지스터가 전송 목록에 들어가면 안 되므로 r12 로 옮겨 읽는다. */
	.type	fe25519_sqr_lenn, %function
	.global	fe25519_sqr_lenn
fe25519_sqr_lenn:
	push	{r4-r11, lr}
	sub	sp, sp, #8
	str	r0, [sp]
	mov	r12, r1
	ldm	r12, {r0-r7}
	bl	fe25519_sqr
	ldr	r8, [sp]
	stm	r8, {r0-r7}
	add	sp, sp, #8
	pop	{r4-r11, pc}
	.size	fe25519_sqr_lenn, .-fe25519_sqr_lenn

/* vmlaldava.u16 x64 — 8 lane 경로 (AM0 §4 R4 에서 회계상 기각했으나 미측정이었음) */
	.type	expam_micro_mac_u16, %function
	.global	expam_micro_mac_u16
expam_micro_mac_u16:
	push	{r4-r11, lr}
	vldrw.u32	q0, [r0]
	vldrw.u32	q1, [r0, #16]
	movs	r4, #0
	movs	r5, #0
	.rept 64
	vmlaldava.u16	r4, r5, q0, q1
	.endr
	str	r4, [r0, #32]
	pop	{r4-r11, pc}
	.size	expam_micro_mac_u16, .-expam_micro_mac_u16

/* ABI 양보 세금 1: vpush {d8-d15} + vpop x32 쌍 */
	.type	expam_micro_vpush, %function
	.global	expam_micro_vpush
expam_micro_vpush:
	push	{r4-r11, lr}
	.rept 32
	vpush	{d8-d15}
	vpop	{d8-d15}
	.endr
	pop	{r4-r11, pc}
	.size	expam_micro_vpush, .-expam_micro_vpush

/* ABI 양보 세금 2: push {r4-r11} + pop x32 쌍 */
	.type	expam_micro_pushpop, %function
	.global	expam_micro_pushpop
expam_micro_pushpop:
	push	{r4-r11, lr}
	.rept 32
	push	{r4-r11}
	pop	{r4-r11}
	.endr
	pop	{r4-r11, pc}
	.size	expam_micro_pushpop, .-expam_micro_pushpop

/* 실보드 명령 의미 확인 (AM0 위험 M5).
 * void expam_probe_semantics(uint32_t out[12]);
 *   out[0:1]  = vmlaldav.u32 {1,2,3,4} . {10,100,1000,10000}   기대 43210
 *   out[2:3]  = vmlaldav.u32 all-0xffffffff . all-0xffffffff   기대 0xFFFFFFF800000004
 *   out[4:7]  = vmullb.u32 (짝수 lane) -> 64-bit 2개, 기대 10 / 3000
 *   out[8:11] = vmullt.u32 (홀수 lane) -> 64-bit 2개, 기대 200 / 40000
 */
	.type	expam_probe_semantics, %function
	.global	expam_probe_semantics
expam_probe_semantics:
	push	{r4-r11, lr}
	adr	r3, .Lsem_a
	vldrw.u32	q0, [r3]		/* {1,2,3,4} */
	vldrw.u32	q1, [r3, #16]		/* {10,100,1000,10000} */
	vmlaldav.u32	r4, r5, q0, q1
	strd	r4, r5, [r0]

	vldrw.u32	q2, [r3, #32]		/* all 0xffffffff */
	vmlaldav.u32	r4, r5, q2, q2
	strd	r4, r5, [r0, #8]

	vmullb.u32	q3, q0, q1		/* lane0 = 1*10, lane1 = 3*1000 */
	vstrw.32	q3, [r0, #16]
	vmullt.u32	q3, q0, q1		/* lane0 = 2*100, lane1 = 4*10000 */
	vstrw.32	q3, [r0, #32]
	pop	{r4-r11, pc}
	.size	expam_probe_semantics, .-expam_probe_semantics

	.align 4
.Lsem_a:
	.word	1, 2, 3, 4
	.word	10, 100, 1000, 10000
	.word	0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff

/* ------------------------------------------------------------------
 * 호출·루프 오버헤드 기준선 (expAM1c).
 * 벤치 루프의 단가에는 ① 루프 제어·주소계산 ② AAPCS 래퍼 ③ 실제 함수 본문이
 * 모두 들어간다. ①+②를 빼내야 "래더 안에서의 실제 비용"을 말할 수 있다.
 *   fe25519_mul_null : A 와 **완전히 같은 래퍼 몸통**이되 bl 대상만 빈 스텁
 *   fe25519_mve_null : B 와 같은 AAPCS 서명의 빈 함수
 * 차분 = 실제 함수 본문 비용 (bl/ret 한 쌍만큼 과소).
 * ------------------------------------------------------------------ */
	.type	fe25519_mul_stub, %function
fe25519_mul_stub:
	bx	lr
	.size	fe25519_mul_stub, .-fe25519_mul_stub

	.type	fe25519_mul_null, %function
	.global	fe25519_mul_null
fe25519_mul_null:
	push	{r4-r11, lr}
	sub	sp, sp, #8
	str	r0, [sp]
	bl	fe25519_mul_stub
	ldr	r8, [sp]
	stm	r8, {r0-r7}
	add	sp, sp, #8
	pop	{r4-r11, pc}
	.size	fe25519_mul_null, .-fe25519_mul_null

	.type	fe25519_mve_null, %function
	.global	fe25519_mve_null
fe25519_mve_null:
	bx	lr
	.size	fe25519_mve_null, .-fe25519_mve_null
