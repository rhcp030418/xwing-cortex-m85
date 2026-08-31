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
	.file	"mul256_flat.c"
.text
	.align	1
	.p2align 2,,3
	.global	mul256_flat
	.syntax unified
	.thumb
	.thumb_func
	.type	mul256_flat, %function
mul256_flat:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, lr}
	movs	r5, #0
	ldr	r3, [r1]
	ldr	r7, [r2]
	mov	ip, r5
	umull	r3, r7, r3, r7
	str	r3, [r0]
	ldr	r4, [r1, #4]
	ldr	r3, [r2]
	ldr	r6, [r1]
	umull	lr, r3, r4, r3
	ldr	r4, [r2, #4]
	umlal	r7, r5, r6, r4
	adds	r7, lr, r7
	adcs	r3, r3, r5
	it	cs
	movcs	ip, #1
	str	r7, [r0, #4]
	ldr	r5, [r1]
	ldr	r4, [r2, #8]
	movs	r6, #0
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r5, [r1, #4]
	ldr	r4, [r2, #4]
	it	cs
	movcs	r6, #1
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	lr, #0
	it	cs
	movcs	lr, #1
	ldr	r5, [r1, #8]
	ldr	r4, [r2]
	add	r6, r6, lr
	umull	r4, r5, r5, r4
	adds	r4, r3, r4
	adcs	ip, ip, r5
	mov	lr, #0
	it	cs
	movcs	lr, #1
	str	r4, [r0, #8]
	ldr	r5, [r1]
	ldr	r4, [r2, #12]
	add	r3, r6, lr
	umull	r6, r4, r5, r4
	adds	ip, ip, r6
	adcs	r3, r3, r4
	ldr	r6, [r1, #4]
	ldr	r4, [r2, #8]
	mov	r5, #0
	umull	r6, r4, r6, r4
	it	cs
	movcs	r5, #1
	adds	ip, ip, r6
	adcs	r3, r3, r4
	mov	lr, #0
	it	cs
	movcs	lr, #1
	ldr	r6, [r1, #8]
	ldr	r4, [r2, #4]
	add	r5, r5, lr
	umull	r6, r4, r6, r4
	adds	ip, ip, r6
	adcs	r3, r3, r4
	mov	lr, #0
	it	cs
	movcs	lr, #1
	ldr	r6, [r1, #12]
	ldr	r4, [r2]
	add	r5, r5, lr
	umull	r4, r6, r6, r4
	adds	r4, ip, r4
	adcs	r3, r3, r6
	mov	lr, #0
	it	cs
	movcs	lr, #1
	str	r4, [r0, #12]
	ldr	r4, [r2, #16]
	add	ip, r5, lr
	ldr	r5, [r1]
	mov	lr, #0
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r5, [r1, #4]
	ldr	r4, [r2, #12]
	it	cs
	movcs	lr, #1
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #8]
	ldr	r4, [r2, #8]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #12]
	ldr	r4, [r2, #4]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #16]
	ldr	r4, [r2]
	add	lr, lr, r6
	umull	r4, r5, r5, r4
	adds	r4, r3, r4
	adcs	r3, ip, r5
	mov	r6, #0
	it	cs
	movcs	r6, #1
	str	r4, [r0, #16]
	ldr	r5, [r1]
	ldr	r4, [r2, #20]
	add	ip, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r5, [r1, #4]
	ldr	r4, [r2, #16]
	mov	lr, #0
	umull	r5, r4, r5, r4
	it	cs
	movcs	lr, #1
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #8]
	ldr	r4, [r2, #12]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #12]
	ldr	r4, [r2, #8]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #16]
	ldr	r4, [r2, #4]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #20]
	ldr	r4, [r2]
	add	lr, lr, r6
	umull	r4, r5, r5, r4
	adds	r4, r3, r4
	adcs	r3, ip, r5
	mov	r6, #0
	it	cs
	movcs	r6, #1
	str	r4, [r0, #20]
	ldr	r5, [r1]
	ldr	r4, [r2, #24]
	add	ip, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r5, [r1, #4]
	ldr	r4, [r2, #20]
	mov	lr, #0
	umull	r5, r4, r5, r4
	it	cs
	movcs	lr, #1
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #8]
	ldr	r4, [r2, #16]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #12]
	ldr	r4, [r2, #12]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #16]
	ldr	r4, [r2, #8]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #20]
	ldr	r4, [r2, #4]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #24]
	ldr	r4, [r2]
	add	lr, lr, r6
	umull	r4, r5, r5, r4
	adds	r4, r3, r4
	adcs	r3, ip, r5
	mov	r6, #0
	it	cs
	movcs	r6, #1
	str	r4, [r0, #24]
	ldr	r5, [r1]
	ldr	r4, [r2, #28]
	add	ip, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r5, [r1, #4]
	ldr	r4, [r2, #24]
	mov	lr, #0
	umull	r5, r4, r5, r4
	it	cs
	movcs	lr, #1
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #8]
	ldr	r4, [r2, #20]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #12]
	ldr	r4, [r2, #16]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #16]
	ldr	r4, [r2, #12]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #20]
	ldr	r4, [r2, #8]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #24]
	ldr	r4, [r2, #4]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #28]
	ldr	r4, [r2]
	add	lr, lr, r6
	umull	r4, r5, r5, r4
	adds	r4, r3, r4
	adcs	r3, ip, r5
	mov	r6, #0
	it	cs
	movcs	r6, #1
	str	r4, [r0, #28]
	ldr	r5, [r1, #4]
	ldr	r4, [r2, #28]
	add	ip, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r5, [r1, #8]
	ldr	r4, [r2, #24]
	mov	lr, #0
	umull	r5, r4, r5, r4
	it	cs
	movcs	lr, #1
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #12]
	ldr	r4, [r2, #20]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #16]
	ldr	r4, [r2, #16]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #20]
	ldr	r4, [r2, #12]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #24]
	ldr	r4, [r2, #8]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #28]
	ldr	r4, [r2, #4]
	add	lr, lr, r6
	umull	r4, r5, r5, r4
	adds	r4, r3, r4
	adcs	r3, ip, r5
	mov	r6, #0
	it	cs
	movcs	r6, #1
	str	r4, [r0, #32]
	ldr	r5, [r1, #8]
	ldr	r4, [r2, #28]
	add	ip, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r5, [r1, #12]
	ldr	r4, [r2, #24]
	mov	lr, #0
	umull	r5, r4, r5, r4
	it	cs
	movcs	lr, #1
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #16]
	ldr	r4, [r2, #20]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #20]
	ldr	r4, [r2, #16]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #24]
	ldr	r4, [r2, #12]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #28]
	ldr	r4, [r2, #8]
	add	lr, lr, r6
	umull	r4, r5, r5, r4
	adds	r4, r3, r4
	adcs	r3, ip, r5
	mov	r6, #0
	it	cs
	movcs	r6, #1
	str	r4, [r0, #36]
	ldr	r5, [r1, #12]
	ldr	r4, [r2, #28]
	add	ip, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r5, [r1, #16]
	ldr	r4, [r2, #24]
	mov	lr, #0
	umull	r5, r4, r5, r4
	it	cs
	movcs	lr, #1
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #20]
	ldr	r4, [r2, #20]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #24]
	ldr	r4, [r2, #16]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #28]
	ldr	r4, [r2, #12]
	add	lr, lr, r6
	umull	r4, r5, r5, r4
	adds	r4, r3, r4
	adcs	r3, ip, r5
	mov	r6, #0
	it	cs
	movcs	r6, #1
	str	r4, [r0, #40]
	ldr	r5, [r1, #16]
	ldr	r4, [r2, #28]
	add	ip, lr, r6
	umull	r6, r4, r5, r4
	adds	r3, r3, r6
	adcs	ip, ip, r4
	ldr	r6, [r1, #20]
	ldr	r4, [r2, #24]
	mov	r5, #0
	umull	r6, r4, r6, r4
	it	cs
	movcs	r5, #1
	adds	r3, r3, r6
	adcs	ip, ip, r4
	mov	lr, #0
	it	cs
	movcs	lr, #1
	ldr	r6, [r1, #24]
	ldr	r4, [r2, #20]
	add	r5, r5, lr
	umull	r6, r4, r6, r4
	adds	r3, r3, r6
	adcs	ip, ip, r4
	mov	lr, #0
	it	cs
	movcs	lr, #1
	ldr	r6, [r1, #28]
	ldr	r4, [r2, #16]
	add	r5, r5, lr
	umull	r4, r6, r6, r4
	adds	r4, r3, r4
	adcs	r3, ip, r6
	mov	lr, #0
	it	cs
	movcs	lr, #1
	str	r4, [r0, #44]
	add	ip, r5, lr
	ldr	r4, [r2, #28]
	ldr	r5, [r1, #20]
	mov	lr, #0
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r5, [r1, #24]
	ldr	r4, [r2, #24]
	it	cs
	movcs	lr, #1
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #28]
	ldr	r4, [r2, #20]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	str	r3, [r0, #48]
	ldr	r3, [r2, #28]
	ldr	r4, [r1, #24]
	add	lr, lr, r6
	umull	r5, r4, r4, r3
	adds	ip, ip, r5
	adcs	lr, lr, r4
	ldr	r5, [r1, #28]
	ldr	r4, [r2, #24]
	mov	r3, #0
	umull	r4, r6, r5, r4
	it	cs
	movcs	r3, #1
	adds	r4, ip, r4
	adcs	lr, lr, r6
	mov	r5, #0
	it	cs
	movcs	r5, #1
	str	r4, [r0, #52]
	ldr	r4, [r1, #28]
	ldr	r1, [r2, #28]
	add	r3, r3, r5
	umull	r2, r1, r4, r1
	adds	r2, lr, r2
	adcs	r3, r3, r1
	strd	r2, r3, [r0, #56]
	pop	{r4, r5, r6, r7, pc}
	.size	mul256_flat, .-mul256_flat
	.ident	"GCC: (Arm GNU Toolchain 13.2.rel1 (Build arm-13.7)) 13.2.1 20231009"
