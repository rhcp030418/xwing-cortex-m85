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
	.global	mul256_full
	.syntax unified
	.thumb
	.thumb_func
	.type	mul256_full, %function
mul256_full:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	r8, #0
	mov	fp, r2
	mov	r4, r8
	mov	r10, r1
	mov	r2, r8
	sub	sp, sp, #12
	str	r0, [sp, #4]
	sub	r9, r0, #4
.L7:
	mov	r1, r8
	mov	r3, r8
	cmp	r1, #7
	it	lt
	movlt	r1, #7
	cmp	r3, #7
	it	ge
	movge	r3, #7
	subs	r5, r1, #7
	cmp	r5, r3
	mov	ip, #0
	bgt	.L2
	add	r1, r1, #1073741824
	subs	r1, r1, #8
	add	r1, r10, r1, lsl #2
	add	lr, r10, r3, lsl #2
	sub	lr, lr, r1
	sub	lr, lr, #4
	sub	r5, r8, r5
	lsr	lr, lr, #2
	add	r5, fp, r5, lsl #2
	add	lr, lr, #1
.L6:
	ldr	r3, [r5], #-4
	ldr	r0, [r1, #4]!
	movs	r6, #0
	umull	r0, r3, r3, r0
	adds	r4, r0, r4
	adcs	r3, r3, r2
	it	cs
	movcs	r6, #1
	add	r7, ip, #1
	cmp	r6, #0
	it	ne
	movne	ip, r7
	subs	lr, lr, #1
	mov	r2, r3
	bne	.L6
.L2:
	add	r8, r8, #1
	cmp	r8, #15
	str	r4, [r9, #4]!
	mov	r4, r2
	mov	r2, ip
	bne	.L7
	ldr	r3, [sp, #4]
	str	r4, [r3, #60]
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
	.size	mul256_full, .-mul256_full
	.ident	"GCC: (Arm GNU Toolchain 13.2.rel1 (Build arm-13.7)) 13.2.1 20231009"
