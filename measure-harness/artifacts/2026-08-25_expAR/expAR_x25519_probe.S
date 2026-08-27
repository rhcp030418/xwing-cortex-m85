/* Experiment AR: X25519 field-op in-context 계측 wrapper.
 *
 * x25519-cortex-m4-gcc.s 의 fe25519_mul / fe25519_sqr 정의를 apx_real_* 로 rename 했고,
 * 원래 이름을 이 파일이 갖는다. 래더 안의 `bl fe25519_mul` / `bl fe25519_sqr` (그리고
 * fe25519_sqr_many 의 내부 루프)가 전부 이 wrapper 를 탄다.
 *
 * ABI 계약 (원본 주석):
 *   fe25519_mul : in *r1=a, *r2=b ; out r0-r7 ; clobbers all other registers
 *   fe25519_sqr : in r0-r7        ; out r0-r7 ; clobbers all other registers
 * 따라서 wrapper 는 r10/r11/r12 만 scratch 로 쓴다. r0-r7 은 절대 건드리지 않는다.
 *
 * mul 과 sqr 은 서로 중첩 호출하지 않으므로(mul 안에 bl 없음, sqr 안에 bl 없음)
 * 시작 타임스탬프는 static 한 칸이면 충분하다.
 *
 * apx_enable=0 이면 곧바로 apx_real_* 로 tail-branch 한다 (lr 무손상).
 */

	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits

	.extern apx_enable
	.extern apx_start
	.extern apx_cyc_mul
	.extern apx_cnt_mul
	.extern apx_cyc_sqr
	.extern apx_cnt_sqr
	.extern apx_real_fe25519_mul
	.extern apx_real_fe25519_sqr

/* ---------------- fe25519_mul ---------------- */
	.type	fe25519_mul, %function
	.global	fe25519_mul
fe25519_mul:
	ldr	r12, =apx_enable
	ldr	r12, [r12]
	cmp	r12, #0
	beq	1f
	push	{r12, lr}			/* 2 word: 8-byte 정렬 유지 */
	ldr	r12, =0xE0001004		/* DWT CYCCNT */
	ldr	r12, [r12]
	ldr	r11, =apx_start
	str	r12, [r11]
	bl	apx_real_fe25519_mul
	ldr	r11, =0xE0001004
	ldr	r11, [r11]
	ldr	r12, =apx_start
	ldr	r12, [r12]
	sub	r11, r11, r12
	ldr	r12, =apx_cyc_mul
	ldr	r10, [r12]
	add	r10, r10, r11
	str	r10, [r12]
	ldr	r12, =apx_cnt_mul
	ldr	r10, [r12]
	add	r10, r10, #1
	str	r10, [r12]
	pop	{r12, pc}
1:
	b	apx_real_fe25519_mul
	.size	fe25519_mul, .-fe25519_mul

/* ---------------- fe25519_sqr ---------------- */
	.type	fe25519_sqr, %function
	.global	fe25519_sqr
fe25519_sqr:
	ldr	r12, =apx_enable
	ldr	r12, [r12]
	cmp	r12, #0
	beq	2f
	push	{r12, lr}
	ldr	r12, =0xE0001004
	ldr	r12, [r12]
	ldr	r11, =apx_start
	str	r12, [r11]
	bl	apx_real_fe25519_sqr
	ldr	r11, =0xE0001004
	ldr	r11, [r11]
	ldr	r12, =apx_start
	ldr	r12, [r12]
	sub	r11, r11, r12
	ldr	r12, =apx_cyc_sqr
	ldr	r10, [r12]
	add	r10, r10, r11
	str	r10, [r12]
	ldr	r12, =apx_cnt_sqr
	ldr	r10, [r12]
	add	r10, r10, #1
	str	r10, [r12]
	pop	{r12, pc}
2:
	b	apx_real_fe25519_sqr
	.size	fe25519_sqr, .-fe25519_sqr

	.ltorg
