/* 실험 BA: M85 **스칼라×스칼라** 듀얼이슈 능력 직접 측정.
 *
 * 배경: slothy-2stream/README 는 스칼라×MVE 페어링만 쟀다(veor 자유, vstrw 차단).
 * X01/X02(fe25519_mul·sqr 재스케줄)의 여지는 **스칼라끼리 짝지어 발행되는가**에
 * 달려 있는데 그것이 미측정이다. 네 커널로 분리한다.
 *
 *   A dep   : 의존 umaal 체인        (누산기 왕복 -> 의존성 한계)
 *   B indep : 독립 umaal 4-way       (의존성 제거 -> 곱셈기 처리율 한계)
 *   C mix   : umaal + adds 교대      (곱셈 x 비곱셈 페어링 가능?)
 *   D add   : 독립 adds 4-way        (비곱셈끼리 페어링 가능?)
 *
 * 각 커널 128 명령.  void f(void *scratch) — scratch 는 쓰지 않는다.
 */

	.syntax unified
	.thumb
	.text	/* expCA 를 위해 ITCM 에서 내림 (측정 완료 커널) */
	.align 2

	.macro BA_PROLOGUE
	push	{r4-r11, lr}
	movs	r2, #3
	movs	r3, #5
	movs	r4, #7
	movs	r5, #11
	movs	r6, #13
	movs	r7, #17
	movs	r8, #19
	movs	r9, #23
	movs	r10, #29
	movs	r11, #31
	.endm

	.macro BA_EPILOGUE
	pop	{r4-r11, pc}
	.endm

/* ---- A: 의존 umaal 체인 (r2,r3 를 계속 물고 간다) ---- */
	.type	expba_umaal_dep, %function
	.global	expba_umaal_dep
expba_umaal_dep:
	BA_PROLOGUE
	.rept 128
	umaal	r2, r3, r10, r11
	.endr
	BA_EPILOGUE
	.size	expba_umaal_dep, .-expba_umaal_dep

/* ---- B: 독립 umaal 4-way ---- */
	.type	expba_umaal_indep, %function
	.global	expba_umaal_indep
expba_umaal_indep:
	BA_PROLOGUE
	.rept 32
	umaal	r2, r3, r10, r11
	umaal	r4, r5, r10, r11
	umaal	r6, r7, r10, r11
	umaal	r8, r9, r10, r11
	.endr
	BA_EPILOGUE
	.size	expba_umaal_indep, .-expba_umaal_indep

/* ---- C: umaal x adds 교대 (독립) ---- */
	.type	expba_mix, %function
	.global	expba_mix
expba_mix:
	BA_PROLOGUE
	.rept 64
	umaal	r2, r3, r10, r11
	adds	r6, r6, r11
	.endr
	BA_EPILOGUE
	.size	expba_mix, .-expba_mix

/* ---- D: 독립 adds 4-way ---- */
	.type	expba_add_indep, %function
	.global	expba_add_indep
expba_add_indep:
	BA_PROLOGUE
	.rept 32
	adds	r2, r2, r11
	adds	r4, r4, r11
	adds	r6, r6, r11
	adds	r8, r8, r11
	.endr
	BA_EPILOGUE
	.size	expba_add_indep, .-expba_add_indep

/* ---- null: 프롤로그/에필로그만 ---- */
	.type	expba_null, %function
	.global	expba_null
expba_null:
	BA_PROLOGUE
	BA_EPILOGUE
	.size	expba_null, .-expba_null

/* ---- E: umaal x str 교대 (스토어가 스칼라 발행을 막는가) ---- */
	.type	expba_umaal_str, %function
	.global	expba_umaal_str
expba_umaal_str:
	BA_PROLOGUE
	.rept 16
	umaal	r2, r3, r10, r11
	str	r4, [r0, #0]
	umaal	r2, r3, r10, r11
	str	r5, [r0, #4]
	umaal	r2, r3, r10, r11
	str	r6, [r0, #8]
	umaal	r2, r3, r10, r11
	str	r7, [r0, #12]
	.endr
	BA_EPILOGUE
	.size	expba_umaal_str, .-expba_umaal_str

/* ---- F: umaal x ldr 교대 ---- */
	.type	expba_umaal_ldr, %function
	.global	expba_umaal_ldr
expba_umaal_ldr:
	BA_PROLOGUE
	.rept 16
	umaal	r2, r3, r10, r11
	ldr	r4, [r0, #0]
	umaal	r2, r3, r10, r11
	ldr	r5, [r0, #4]
	umaal	r2, r3, r10, r11
	ldr	r6, [r0, #8]
	umaal	r2, r3, r10, r11
	ldr	r7, [r0, #12]
	.endr
	BA_EPILOGUE
	.size	expba_umaal_ldr, .-expba_umaal_ldr

/* ---- G: str 단독 ---- */
	.type	expba_str_only, %function
	.global	expba_str_only
expba_str_only:
	BA_PROLOGUE
	.rept 32
	str	r4, [r0, #0]
	str	r5, [r0, #4]
	str	r6, [r0, #8]
	str	r7, [r0, #12]
	.endr
	BA_EPILOGUE
	.size	expba_str_only, .-expba_str_only

/* ---- H: ldr 단독 ---- */
	.type	expba_ldr_only, %function
	.global	expba_ldr_only
expba_ldr_only:
	BA_PROLOGUE
	.rept 32
	ldr	r4, [r0, #0]
	ldr	r5, [r0, #4]
	ldr	r6, [r0, #8]
	ldr	r7, [r0, #12]
	.endr
	BA_EPILOGUE
	.size	expba_ldr_only, .-expba_ldr_only

	.ltorg

/* ---- BB: fe25519_sqr_bb 의 AAPCS 래퍼 (원본 sqr_lenn 과 같은 형태) ---- */
	.extern	fe25519_sqr_bb
	.type	fe25519_sqr_bb_lenn, %function
	.global	fe25519_sqr_bb_lenn
fe25519_sqr_bb_lenn:
	push	{r4-r11, lr}
	sub	sp, sp, #8
	str	r0, [sp]
	mov	r12, r1
	ldm	r12, {r0-r7}
	bl	fe25519_sqr_bb
	ldr	r8, [sp]
	stm	r8, {r0-r7}
	add	sp, sp, #8
	pop	{r4-r11, pc}
	.size	fe25519_sqr_bb_lenn, .-fe25519_sqr_bb_lenn

/* ---- BD: fe25519_mul_bb 의 AAPCS 래퍼 ---- */
	.extern	fe25519_mul_bb
	.type	fe25519_mul_bb_lenn, %function
	.global	fe25519_mul_bb_lenn
fe25519_mul_bb_lenn:
	push	{r4-r11, lr}
	sub	sp, sp, #8
	str	r0, [sp]
	bl	fe25519_mul_bb
	ldr	r8, [sp]
	stm	r8, {r0-r7}
	add	sp, sp, #8
	pop	{r4-r11, pc}
	.size	fe25519_mul_bb_lenn, .-fe25519_mul_bb_lenn
