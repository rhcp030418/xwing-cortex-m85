	.arch armv8.1-m.main
	.fpu fpv5-d16
	.arch_extension dsp
	.arch_extension pacbti
	.arch_extension fp
	.arch_extension fp.dp
	.arch_extension mve
	.arch_extension mve.fp
	.eabi_attribute 5, "cortex-m85"
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 2
	.eabi_attribute 34, 1
	.eabi_attribute 38, 1
	.eabi_attribute 50, 2
	.eabi_attribute 52, 2
	.eabi_attribute 18, 4
	.file	"mul256.c"
.text
	.align	1
	.p2align 2,,3
	.global	mul256_budget
	.syntax unified
	.thumb
	.thumb_func
	.type	mul256_budget, %function
mul256_budget:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	movs	r6, #0
	mov	r4, r0
	mov	r7, r2
	mov	r0, r6
	mov	r2, r6
	mov	ip, r6
	sub	sp, sp, #28
	strd	r7, r4, [sp, #16]
	subs	r3, r4, #4
.L7:
	mov	r6, ip
	mov	r5, ip
	cmp	r6, #7
	it	lt
	movlt	r6, #7
	cmp	r5, #7
	it	ge
	movge	r5, #7
	subs	r7, r6, #7
	cmp	r7, r5
	bgt	.L8
	ldr	r4, [sp, #16]
	sub	r7, ip, r7
	add	r7, r4, r7, lsl #2
	movs	r4, #0
	add	r6, r6, #1073741824
	subs	r6, r6, #8
	add	r6, r1, r6, lsl #2
	add	r5, r1, r5, lsl #2
	subs	r5, r5, r6
	subs	r5, r5, #4
	strd	r3, ip, [sp, #4]
	lsrs	r5, r5, #2
	adds	r5, r5, #1
	str	r1, [sp, #12]
.L6:
	ldr	r3, [r7], #-4
	ldr	r1, [r6, #4]!
	mov	ip, #0
	umull	r1, r3, r3, r1
	adds	r0, r1, r0
	adcs	r3, r3, r2
	it	cs
	movcs	ip, #1
	add	lr, r4, #1
	cmp	ip, #0
	it	ne
	movne	r4, lr
	subs	r5, r5, #1
	mov	r2, r3
	bne	.L6
	ldrd	r3, ip, [sp, #4]
	ldr	r1, [sp, #12]
.L2:
	add	ip, ip, #1
	cmp	ip, #15
	str	r0, [r3, #4]!
	mov	r0, r2
	mov	r2, r4
	bne	.L7
	ldr	r4, [sp, #20]
	str	r0, [r4, #60]
	add	sp, sp, #28
	@ sp needed
	pop	{r4, r5, r6, r7, pc}
.L8:
	movs	r4, #0
	b	.L2
	.size	mul256_budget, .-mul256_budget
	.ident	"GCC: (Arm GNU Toolchain 13.2.rel1 (Build arm-13.7)) 13.2.1 20231009"
