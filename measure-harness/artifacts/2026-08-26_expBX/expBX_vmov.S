/* 실험 BX (K14/K15 결정 변수): core <-> FP 레지스터 `vmov` 발행 비용.
 *
 * matacc_asm_* 의 루프 몸통에는 `vmov s18, bufptr` 형태가 28~38개 들어 있다.
 * 이것은 **MVE 벡터 연산이 아니라 FP 레지스터를 스크래치로 쓰는 것**이다.
 * 이 명령이 ALU 처럼 페어링되면 matacc 여지가 약 16%, 단독 점유면 **0%** 다.
 * expBR 의 상한 판정이 통째로 여기에 달려 있다.
 *
 * 커널 5개, 각 128 명령.  void f(void *scratch)
 *   A umaal_only   : 기준선 (expBV A 와 동일)
 *   B vmov_r2s     : vmov s, r   독립 4-way
 *   C vmov_s2r     : vmov r, s   독립 4-way
 *   D mix_r2s      : umaal 64 + vmov s,r 64 교대
 *   E mix_alu      : adds 64 + vmov s,r 64 교대
 */

	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits
	.align 2

	.macro BX_PRO
	push	{r4-r11, lr}
	movs	r2, #3
	movs	r3, #5
	movs	r4, #7
	movs	r5, #11
	movs	r10, #29
	movs	r11, #31
	vmov	s0, r2
	vmov	s1, r3
	vmov	s2, r4
	vmov	s3, r5
	.endm

	.macro BX_EPI
	pop	{r4-r11, pc}
	.endm

	.balign 16
	.type	expbx_umaal_only, %function
	.global	expbx_umaal_only
expbx_umaal_only:
	BX_PRO
	.rept 128
	umaal	r2, r3, r10, r11
	.endr
	BX_EPI
	.size	expbx_umaal_only, .-expbx_umaal_only

	.balign 16
	.type	expbx_vmov_r2s, %function
	.global	expbx_vmov_r2s
expbx_vmov_r2s:
	BX_PRO
	.rept 32
	vmov	s0, r10
	vmov	s1, r10
	vmov	s2, r10
	vmov	s3, r10
	.endr
	BX_EPI
	.size	expbx_vmov_r2s, .-expbx_vmov_r2s

	.balign 16
	.type	expbx_vmov_s2r, %function
	.global	expbx_vmov_s2r
expbx_vmov_s2r:
	BX_PRO
	.rept 32
	vmov	r4, s0
	vmov	r5, s1
	vmov	r6, s2
	vmov	r7, s3
	.endr
	BX_EPI
	.size	expbx_vmov_s2r, .-expbx_vmov_s2r

	.balign 16
	.type	expbx_mix_r2s, %function
	.global	expbx_mix_r2s
expbx_mix_r2s:
	BX_PRO
	.rept 64
	umaal	r2, r3, r10, r11
	vmov	s0, r10
	.endr
	BX_EPI
	.size	expbx_mix_r2s, .-expbx_mix_r2s

	.balign 16
	.type	expbx_mix_alu, %function
	.global	expbx_mix_alu
expbx_mix_alu:
	BX_PRO
	.rept 64
	eor	r4, r10, r11
	vmov	s0, r10
	.endr
	BX_EPI
	.size	expbx_mix_alu, .-expbx_mix_alu

	.ltorg
