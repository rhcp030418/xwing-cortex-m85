/* 실험 CB-② : MVE 와 스칼라의 **메모리 포트 경합** 측정.
 *
 * expBZ 는 메모리를 안 건드리는 vmul 로만 100% 겹침을 확인했다.
 * expCA 의 병합 커널은 MVE 가 vldrw/vstrw, 스칼라가 ldrd/str 을 쓴다 — 미측정이다.
 * 사전등록: 2026-08-26_expCB_prereg.md §3
 *
 * 커널 6종, 각 128 명령.  void f(void *dtcm_buf)   버퍼는 DTCM (expBJ 규율).
 *   G vldrw_only  H ldr_only   I mix_ld
 *   J vstrw_only  K str_only   L mix_st
 *
 * ITCM 예산 때문에 .text 에 둔다(사전등록 §4-3 의 가정).
 */

	.syntax unified
	.thumb
	.text
	.align 2

	.macro CB_PRO
	push	{r4-r11, lr}
	mov	r7, r0			/* DTCM 버퍼 */
	movs	r2, #0
	movs	r3, #0
	movs	r4, #0
	movs	r5, #0
	.endm

	.macro CB_EPI
	pop	{r4-r11, pc}
	.endm

/* G: MVE 적재 독립 4-way */
	.balign 16
	.type	expcb_vldr_only, %function
	.global	expcb_vldr_only
expcb_vldr_only:
	CB_PRO
	.rept 32
	vldrw.u32	q0, [r7]
	vldrw.u32	q1, [r7, #16]
	vldrw.u32	q2, [r7, #32]
	vldrw.u32	q3, [r7, #48]
	.endr
	CB_EPI
	.size	expcb_vldr_only, .-expcb_vldr_only

/* H: 스칼라 적재 독립 4-way */
	.balign 16
	.type	expcb_ldr_only, %function
	.global	expcb_ldr_only
expcb_ldr_only:
	CB_PRO
	.rept 32
	ldr	r2, [r7]
	ldr	r3, [r7, #16]
	ldr	r4, [r7, #32]
	ldr	r5, [r7, #48]
	.endr
	CB_EPI
	.size	expcb_ldr_only, .-expcb_ldr_only

/* I: 교대 — 적재끼리 겹치는가 */
	.balign 16
	.type	expcb_mix_ld, %function
	.global	expcb_mix_ld
expcb_mix_ld:
	CB_PRO
	.rept 32
	vldrw.u32	q0, [r7]
	ldr	r2, [r7, #64]
	vldrw.u32	q1, [r7, #16]
	ldr	r3, [r7, #80]
	.endr
	CB_EPI
	.size	expcb_mix_ld, .-expcb_mix_ld

/* J: MVE 저장 독립 4-way */
	.balign 16
	.type	expcb_vstr_only, %function
	.global	expcb_vstr_only
expcb_vstr_only:
	CB_PRO
	.rept 32
	vstrw.u32	q0, [r7]
	vstrw.u32	q1, [r7, #16]
	vstrw.u32	q2, [r7, #32]
	vstrw.u32	q3, [r7, #48]
	.endr
	CB_EPI
	.size	expcb_vstr_only, .-expcb_vstr_only

/* K: 스칼라 저장 독립 4-way */
	.balign 16
	.type	expcb_str_only, %function
	.global	expcb_str_only
expcb_str_only:
	CB_PRO
	.rept 32
	str	r2, [r7]
	str	r3, [r7, #16]
	str	r4, [r7, #32]
	str	r5, [r7, #48]
	.endr
	CB_EPI
	.size	expcb_str_only, .-expcb_str_only

/* L: 교대 — 저장끼리 겹치는가 */
	.balign 16
	.type	expcb_mix_st, %function
	.global	expcb_mix_st
expcb_mix_st:
	CB_PRO
	.rept 32
	vstrw.u32	q0, [r7]
	str	r2, [r7, #64]
	vstrw.u32	q1, [r7, #16]
	str	r3, [r7, #80]
	.endr
	CB_EPI
	.size	expcb_mix_st, .-expcb_mix_st

	.ltorg
