/* 실험 BL: M85 **shifted-operand ALU** 발행 규칙 직접 측정.
 *
 * 배경: expBA 는 umaal / adds / ldr / str 만 쟀다. 그 결과에서 나온 회계
 *   "ALU = 0.5 cyc, 100% 페어링" 을 expBE(K19 종료) · expBB(X02) · expBK(K32) 가
 *   **shifted-operand ALU 에도 그대로 적용**하고 있는데, 그것은 미측정이다.
 *   expBK 는 실현율 0.37 로 모델과 크게 어긋났다(사전등록 문서 §2.1).
 *
 * 커널 8개, 각 128 명령.  void f(void *scratch) — scratch 는 쓰지 않는다.
 *
 *   A plain_indep : eor rD, rN, rM              독립 4-way   (평 ALU 처리율)
 *   B plain_dep   : eor rD, rD, rM              의존 체인    (평 ALU 지연)
 *   C shift_indep : eor rD, rN, rM, LSR #8      독립 4-way   (shifted 처리율)
 *   D shift_dep   : eor rD, rD, rM, LSR #8      의존 체인    (shifted 지연)
 *   E mix_indep   : shifted 와 평 ALU 교대, 독립 (서로 페어링되는가)
 *   F andimm_indep: and rD, rN, #0x0C0C0C0C     독립 4-way   (마스크 상수 ALU)
 *   G bfi_indep   : bfi rD, rN, #16, #16        독립        (비트필드 삽입)
 *   H fbi_chain   : fromBitInterleaving 실제 4단 블록      (커널 그대로)
 */

	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits
	.align 2

	.macro BL_PROLOGUE
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

	.macro BL_EPILOGUE
	pop	{r4-r11, pc}
	.endm

/* ---- A: 평 ALU 독립 4-way ---- */
	.balign 16
	.type	expbl_plain_indep, %function
	.global	expbl_plain_indep
expbl_plain_indep:
	BL_PROLOGUE
	.rept 32
	eor	r2, r10, r11
	eor	r4, r10, r11
	eor	r6, r10, r11
	eor	r8, r10, r11
	.endr
	BL_EPILOGUE
	.size	expbl_plain_indep, .-expbl_plain_indep

/* ---- B: 평 ALU 의존 체인 ---- */
	.balign 16
	.type	expbl_plain_dep, %function
	.global	expbl_plain_dep
expbl_plain_dep:
	BL_PROLOGUE
	.rept 128
	eor	r2, r2, r11
	.endr
	BL_EPILOGUE
	.size	expbl_plain_dep, .-expbl_plain_dep

/* ---- C: shifted-operand 독립 4-way ---- */
	.balign 16
	.type	expbl_shift_indep, %function
	.global	expbl_shift_indep
expbl_shift_indep:
	BL_PROLOGUE
	.rept 32
	eor	r2, r10, r11, LSR #8
	eor	r4, r10, r11, LSR #8
	eor	r6, r10, r11, LSR #8
	eor	r8, r10, r11, LSR #8
	.endr
	BL_EPILOGUE
	.size	expbl_shift_indep, .-expbl_shift_indep

/* ---- D: shifted-operand 의존 체인 ---- */
	.balign 16
	.type	expbl_shift_dep, %function
	.global	expbl_shift_dep
expbl_shift_dep:
	BL_PROLOGUE
	.rept 128
	eor	r2, r2, r11, LSR #8
	.endr
	BL_EPILOGUE
	.size	expbl_shift_dep, .-expbl_shift_dep

/* ---- E: shifted 와 평 ALU 교대, 전부 독립 ---- */
	.balign 16
	.type	expbl_mix_indep, %function
	.global	expbl_mix_indep
expbl_mix_indep:
	BL_PROLOGUE
	.rept 32
	eor	r2, r10, r11, LSR #8
	eor	r4, r10, r11
	eor	r6, r10, r11, LSR #8
	eor	r8, r10, r11
	.endr
	BL_EPILOGUE
	.size	expbl_mix_indep, .-expbl_mix_indep

/* ---- F: and 상수 마스크, 독립 4-way ---- */
	.balign 16
	.type	expbl_andimm_indep, %function
	.global	expbl_andimm_indep
expbl_andimm_indep:
	BL_PROLOGUE
	.rept 32
	and	r2, r10, #0x0C0C0C0C
	and	r4, r10, #0x0C0C0C0C
	and	r6, r10, #0x0C0C0C0C
	and	r8, r10, #0x0C0C0C0C
	.endr
	BL_EPILOGUE
	.size	expbl_andimm_indep, .-expbl_andimm_indep

/* ---- G: bfi 독립 ---- */
	.balign 16
	.type	expbl_bfi_indep, %function
	.global	expbl_bfi_indep
expbl_bfi_indep:
	BL_PROLOGUE
	.rept 32
	bfi	r2, r10, #16, #16
	bfi	r4, r10, #16, #16
	bfi	r6, r10, #16, #16
	bfi	r8, r10, #16, #16
	.endr
	BL_EPILOGUE
	.size	expbl_bfi_indep, .-expbl_bfi_indep

/* ---- H: fromBitInterleaving 의 4단 블록을 그대로 (한 사슬) ---- */
	.balign 16
	.type	expbl_fbi_chain, %function
	.global	expbl_fbi_chain
expbl_fbi_chain:
	BL_PROLOGUE
	.rept 32
	eor	r3, r4, r4, LSR #8
	and	r3, r3, #0x0000FF00
	eors	r4, r4, r3
	eor	r4, r4, r3, LSL #8
	.endr
	BL_EPILOGUE
	.size	expbl_fbi_chain, .-expbl_fbi_chain

	.ltorg
