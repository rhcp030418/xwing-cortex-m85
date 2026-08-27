/* 실험 BZ: expBV 의 두 해석을 가른다 — MVE **독립** 처리율과 스칼라 겹침.
 *
 * expBV 는 `vmul.i16 q0, q1, q2` 를 128번 반복했다. **전부 q0 에 쓴다 = WAW 의존 사슬**이다.
 * 그래서 526.69(= 2.000 cyc/명령)는 **처리율이 아니라 의존 지연**일 수 있다.
 * expBA 는 umaal 에서 의존/독립을 나눠 쟀는데(둘 다 1.000) MVE 에서는 그러지 않았다.
 *
 * expBV 의 D 커널(umaal 64 + vmul 64, 작업량 128)은 두 해석과 모두 정합한다:
 *   (a) MVE 2 cyc/명령 + 스칼라와 100% 겹침  -> max(64,128) = 128
 *   (b) MVE 1 cyc/명령 + 겹침 0%             -> 64 + 64    = 128
 * (b)면 스티칭 자체가 성립하지 않는다. 이 실험이 가른다.
 *
 * 커널 (각 128 명령, void f(void*)):
 *   A umaal_dep      : 기준선
 *   B vmul_dep       : q0 에만 쓴다 (expBV B 재현)
 *   C vmul_indep     : q0-q3 에 번갈아 쓴다  <-- **MVE 처리율**
 *   D mix_dep        : umaal 64 + 의존 vmul 64 (expBV D 재현)
 *   E mix_indep      : umaal 64 + **독립** vmul 64  <-- **결정적 커널**
 *   F vadd_indep     : 독립 vadd 로 교차 확인
 *
 * 판정:
 *   C 작업량 = 128  -> MVE 처리율 1/cyc
 *   C 작업량 = 256  -> MVE 처리율 2 cyc/명령
 *   E 작업량 = max(스칼라, MVE)  -> 겹침 있음
 *   E 작업량 = 스칼라 + MVE      -> 겹침 없음
 */

	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits
	.align 2

	.macro BZ_PRO
	push	{r4-r11, lr}
	vldrw.u32	q0, [r0]
	vldrw.u32	q1, [r0]
	vldrw.u32	q2, [r0]
	vldrw.u32	q3, [r0]
	vldrw.u32	q4, [r0]
	vldrw.u32	q5, [r0]
	vldrw.u32	q6, [r0]
	vldrw.u32	q7, [r0]
	movs	r2, #3
	movs	r3, #5
	movs	r10, #29
	movs	r11, #31
	.endm

	.macro BZ_EPI
	pop	{r4-r11, pc}
	.endm

	.balign 16
	.type	expbz_umaal_dep, %function
	.global	expbz_umaal_dep
expbz_umaal_dep:
	BZ_PRO
	.rept 128
	umaal	r2, r3, r10, r11
	.endr
	BZ_EPI
	.size	expbz_umaal_dep, .-expbz_umaal_dep

/* B: expBV 재현 — 전부 q0 에 쓴다 (WAW 사슬) */
	.balign 16
	.type	expbz_vmul_dep, %function
	.global	expbz_vmul_dep
expbz_vmul_dep:
	BZ_PRO
	.rept 128
	vmul.i16	q0, q1, q2
	.endr
	BZ_EPI
	.size	expbz_vmul_dep, .-expbz_vmul_dep

/* C: 독립 4-way — 목적지 q0..q3, 소스는 q4..q7 (WAW·RAW 없음) */
	.balign 16
	.type	expbz_vmul_indep, %function
	.global	expbz_vmul_indep
expbz_vmul_indep:
	BZ_PRO
	.rept 32
	vmul.i16	q0, q4, q5
	vmul.i16	q1, q6, q7
	vmul.i16	q2, q4, q6
	vmul.i16	q3, q5, q7
	.endr
	BZ_EPI
	.size	expbz_vmul_indep, .-expbz_vmul_indep

/* D: expBV D 재현 — 의존 vmul */
	.balign 16
	.type	expbz_mix_dep, %function
	.global	expbz_mix_dep
expbz_mix_dep:
	BZ_PRO
	.rept 64
	umaal	r2, r3, r10, r11
	vmul.i16	q0, q1, q2
	.endr
	BZ_EPI
	.size	expbz_mix_dep, .-expbz_mix_dep

/* E: 결정적 커널 — umaal + **독립** vmul */
	.balign 16
	.type	expbz_mix_indep, %function
	.global	expbz_mix_indep
expbz_mix_indep:
	BZ_PRO
	.rept 16
	umaal	r2, r3, r10, r11
	vmul.i16	q0, q4, q5
	umaal	r2, r3, r10, r11
	vmul.i16	q1, q6, q7
	umaal	r2, r3, r10, r11
	vmul.i16	q2, q4, q6
	umaal	r2, r3, r10, r11
	vmul.i16	q3, q5, q7
	.endr
	BZ_EPI
	.size	expbz_mix_indep, .-expbz_mix_indep

/* F: 독립 vadd 로 교차 확인 */
	.balign 16
	.type	expbz_vadd_indep, %function
	.global	expbz_vadd_indep
expbz_vadd_indep:
	BZ_PRO
	.rept 32
	vadd.i16	q0, q4, q5
	vadd.i16	q1, q6, q7
	vadd.i16	q2, q4, q6
	vadd.i16	q3, q5, q7
	.endr
	BZ_EPI
	.size	expbz_vadd_indep, .-expbz_vadd_indep

	.ltorg
