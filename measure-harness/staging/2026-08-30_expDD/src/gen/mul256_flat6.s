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
.section .itcm_code_from_flash, "ax", %progbits
	.align	1
	.p2align 2,,3
	.global	mul256_flat6
	.syntax unified
	.thumb
	.thumb_func
	.type	mul256_flat6, %function
mul256_flat6:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	movs	r3, #0
	push	{r4, r5, lr}
	ldr	r5, [r2]
	ldr	r4, [r1]
	sub	sp, sp, #12
	umull	r4, lr, r4, r5
	str	r4, [r0]
	ldr	r4, [r2]
	ldr	r5, [r1, #4]
	str	r0, [sp]
	umull	r0, r5, r5, r4
	ldr	r4, [r2, #4]
	str	r0, [sp, #4]
	ldr	r0, [r1]
	mov	ip, r3
	umlal	lr, r3, r0, r4
	ldr	r0, [sp, #4]
	adds	r4, r0, lr
	adcs	r3, r3, r5
	it	cs
	movcs	ip, #1
	ldr	r0, [sp]
	mov	lr, #0
	str	r4, [r0, #4]
	ldr	r5, [r1]
	ldr	r4, [r2, #8]
	ldr	r0, [r1, #4]
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r4, [r2, #4]
	it	cs
	movcs	lr, #1
	umull	r4, r0, r0, r4
	adds	r4, r3, r4
	adcs	ip, ip, r0
	mov	r5, #0
	it	cs
	movcs	r5, #1
	ldr	r3, [r2]
	add	lr, lr, r5
	ldr	r5, [r1, #8]
	movs	r0, #0
	umull	r5, r3, r5, r3
	adds	r5, r4, r5
	adcs	r3, ip, r3
	it	cs
	movcs	r0, #1
	ldr	r4, [sp]
	mov	ip, #0
	str	r5, [r4, #8]
	mov	r5, r0
	ldr	r4, [r2, #12]
	ldr	r0, [r1]
	add	r5, r5, lr
	umull	lr, r4, r0, r4
	adds	r3, r3, lr
	adcs	r5, r5, r4
	ldr	r0, [r2, #8]
	ldr	r4, [r1, #4]
	it	cs
	movcs	ip, #1
	umull	r4, r0, r4, r0
	adds	r4, r3, r4
	adcs	r3, r5, r0
	mov	r0, r3
	ldr	r5, [r2, #4]
	ldr	r3, [r1, #8]
	mov	lr, #0
	umull	r3, r5, r3, r5
	it	cs
	movcs	lr, #1
	adds	r3, r4, r3
	mov	r4, r0
	adcs	r4, r4, r5
	mov	r0, r4
	ldr	r5, [r1, #12]
	ldr	r4, [r2]
	add	lr, lr, ip
	umull	r5, r4, r5, r4
	mov	ip, #0
	it	cs
	movcs	ip, #1
	adds	r5, r3, r5
	mov	r3, r0
	adcs	r3, r3, r4
	mov	r4, r3
	add	lr, lr, ip
	mov	ip, #0
	it	cs
	movcs	ip, #1
	ldr	r3, [sp]
	add	lr, lr, ip
	str	r5, [r3, #12]
	ldr	r5, [r1]
	ldr	r3, [r2, #16]
	mov	ip, #0
	umull	r5, r3, r5, r3
	adds	r4, r4, r5
	adcs	lr, lr, r3
	ldr	r5, [r2, #12]
	ldr	r3, [r1, #4]
	it	cs
	movcs	ip, #1
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	adcs	lr, lr, r5
	ldr	r4, [r1, #8]
	ldr	r5, [r2, #8]
	mov	r0, #0
	umull	r4, r5, r4, r5
	it	cs
	movcs	r0, #1
	adds	r4, r3, r4
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	mov	r0, #0
	it	cs
	movcs	r0, r3
	ldr	r5, [r2, #4]
	ldr	r3, [r1, #12]
	add	ip, ip, r0
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	adcs	lr, lr, r5
	ldr	r4, [r2]
	ldr	r5, [r1, #16]
	mov	r0, #0
	umull	r5, r4, r5, r4
	it	cs
	movcs	r0, #1
	adds	r5, r3, r5
	adcs	r4, lr, r4
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	mov	r0, #0
	it	cs
	movcs	r0, r3
	ldr	r3, [sp]
	str	r5, [r3, #16]
	mov	r5, r0
	ldr	r3, [r2, #20]
	ldr	r0, [r1]
	add	r5, r5, ip
	umull	lr, r3, r0, r3
	adds	r4, r4, lr
	adcs	r5, r5, r3
	ldr	r0, [r2, #16]
	ldr	r3, [r1, #4]
	mov	ip, #0
	umull	r3, r0, r3, r0
	it	cs
	movcs	ip, #1
	adds	r3, r4, r3
	adcs	r0, r5, r0
	ldr	r4, [r1, #8]
	ldr	r5, [r2, #12]
	mov	lr, #0
	umull	r4, r5, r4, r5
	it	cs
	movcs	lr, #1
	adds	r4, r3, r4
	mov	r3, r0
	adcs	r3, r3, r5
	mov	r0, r3
	ldr	r5, [r2, #8]
	ldr	r3, [r1, #12]
	add	lr, lr, ip
	umull	r3, r5, r3, r5
	mov	ip, #0
	it	cs
	movcs	ip, #1
	adds	r3, r4, r3
	mov	r4, r0
	adcs	r4, r4, r5
	mov	r0, r4
	ldr	r5, [r2, #4]
	ldr	r4, [r1, #16]
	add	lr, lr, ip
	umull	r4, r5, r4, r5
	mov	ip, #0
	it	cs
	movcs	ip, #1
	adds	r4, r3, r4
	mov	r3, r0
	adcs	r3, r3, r5
	mov	r0, r3
	ldr	r5, [r1, #20]
	ldr	r3, [r2]
	add	lr, lr, ip
	umull	r5, r3, r5, r3
	mov	ip, #0
	it	cs
	movcs	ip, #1
	adds	r5, r4, r5
	mov	r4, r0
	adcs	r4, r4, r3
	mov	r3, r4
	add	lr, lr, ip
	mov	ip, #0
	it	cs
	movcs	ip, #1
	ldr	r0, [sp]
	add	lr, lr, ip
	str	r5, [r0, #20]
	ldr	r5, [r1]
	ldr	r4, [r2, #24]
	mov	ip, #0
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	lr, lr, r4
	ldr	r5, [r2, #20]
	ldr	r4, [r1, #4]
	it	cs
	movcs	ip, #1
	umull	r4, r5, r4, r5
	adds	r4, r3, r4
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	mov	r0, #0
	it	cs
	movcs	r0, r3
	ldr	r5, [r2, #16]
	ldr	r3, [r1, #8]
	add	ip, ip, r0
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	adcs	lr, lr, r5
	ldr	r4, [r1, #12]
	ldr	r5, [r2, #12]
	mov	r0, #0
	umull	r4, r5, r4, r5
	it	cs
	movcs	r0, #1
	adds	r4, r3, r4
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	mov	r0, #0
	it	cs
	movcs	r0, r3
	ldr	r5, [r2, #8]
	ldr	r3, [r1, #16]
	add	ip, ip, r0
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	adcs	lr, lr, r5
	ldr	r4, [r1, #20]
	ldr	r5, [r2, #4]
	mov	r0, #0
	umull	r4, r5, r4, r5
	it	cs
	movcs	r0, #1
	adds	r4, r3, r4
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	mov	r0, #0
	it	cs
	movcs	r0, r3
	ldr	r5, [r1, #24]
	ldr	r3, [r2]
	add	ip, ip, r0
	umull	r5, r3, r5, r3
	adds	r5, r4, r5
	adcs	r3, lr, r3
	mov	r0, #0
	it	cs
	movcs	r0, #1
	ldr	r4, [sp]
	str	r5, [r4, #24]
	mov	r5, r0
	ldr	r4, [r2, #28]
	ldr	r0, [r1]
	add	r5, r5, ip
	umull	lr, r4, r0, r4
	adds	r3, r3, lr
	adcs	r5, r5, r4
	ldr	r0, [r2, #24]
	ldr	r4, [r1, #4]
	mov	ip, #0
	umull	r4, r0, r4, r0
	it	cs
	movcs	ip, #1
	adds	r4, r3, r4
	adcs	r3, r5, r0
	mov	r0, r3
	ldr	r5, [r2, #20]
	ldr	r3, [r1, #8]
	mov	lr, #0
	umull	r3, r5, r3, r5
	it	cs
	movcs	lr, #1
	adds	r3, r4, r3
	mov	r4, r0
	adcs	r4, r4, r5
	mov	r0, r4
	ldr	r5, [r2, #16]
	ldr	r4, [r1, #12]
	add	lr, lr, ip
	umull	r4, r5, r4, r5
	mov	ip, #0
	it	cs
	movcs	ip, #1
	adds	r4, r3, r4
	mov	r3, r0
	adcs	r3, r3, r5
	mov	r0, r3
	ldr	r5, [r2, #12]
	ldr	r3, [r1, #16]
	add	lr, lr, ip
	umull	r3, r5, r3, r5
	mov	ip, #0
	it	cs
	movcs	ip, #1
	adds	r3, r4, r3
	mov	r4, r0
	adcs	r4, r4, r5
	mov	r0, r4
	ldr	r5, [r2, #8]
	ldr	r4, [r1, #20]
	add	lr, lr, ip
	umull	r4, r5, r4, r5
	mov	ip, #0
	it	cs
	movcs	ip, #1
	adds	r4, r3, r4
	mov	r3, r0
	adcs	r3, r3, r5
	mov	r0, r3
	ldr	r5, [r2, #4]
	ldr	r3, [r1, #24]
	add	lr, lr, ip
	umull	r3, r5, r3, r5
	mov	ip, #0
	it	cs
	movcs	ip, #1
	adds	r3, r4, r3
	mov	r4, r0
	adcs	r4, r4, r5
	mov	r0, r4
	ldr	r5, [r1, #28]
	ldr	r4, [r2]
	add	lr, lr, ip
	umull	r5, r4, r5, r4
	mov	ip, #0
	it	cs
	movcs	ip, #1
	adds	r5, r3, r5
	mov	r3, r0
	adcs	r3, r3, r4
	mov	r4, r3
	add	lr, lr, ip
	mov	ip, #0
	it	cs
	movcs	ip, #1
	ldr	r3, [sp]
	add	lr, lr, ip
	str	r5, [r3, #28]
	ldr	r5, [r1, #4]
	ldr	r3, [r2, #28]
	mov	ip, #0
	umull	r5, r3, r5, r3
	adds	r4, r4, r5
	adcs	lr, lr, r3
	ldr	r5, [r2, #24]
	ldr	r3, [r1, #8]
	it	cs
	movcs	ip, #1
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	adcs	lr, lr, r5
	ldr	r4, [r1, #12]
	ldr	r5, [r2, #20]
	mov	r0, #0
	umull	r4, r5, r4, r5
	it	cs
	movcs	r0, #1
	adds	r4, r3, r4
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	mov	r0, #0
	it	cs
	movcs	r0, r3
	ldr	r5, [r2, #16]
	ldr	r3, [r1, #16]
	add	ip, ip, r0
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	adcs	lr, lr, r5
	ldr	r4, [r1, #20]
	ldr	r5, [r2, #12]
	mov	r0, #0
	umull	r4, r5, r4, r5
	it	cs
	movcs	r0, #1
	adds	r4, r3, r4
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	mov	r0, #0
	it	cs
	movcs	r0, r3
	ldr	r5, [r2, #8]
	ldr	r3, [r1, #24]
	add	ip, ip, r0
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	adcs	lr, lr, r5
	ldr	r4, [r2, #4]
	ldr	r5, [r1, #28]
	mov	r0, #0
	umull	r5, r4, r5, r4
	it	cs
	movcs	r0, #1
	adds	r5, r3, r5
	adcs	r4, lr, r4
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	mov	r0, #0
	it	cs
	movcs	r0, r3
	ldr	r3, [sp]
	str	r5, [r3, #32]
	mov	r5, r0
	ldr	r3, [r2, #28]
	ldr	r0, [r1, #8]
	add	r5, r5, ip
	umull	lr, r3, r0, r3
	adds	r4, r4, lr
	adcs	r5, r5, r3
	ldr	r0, [r2, #24]
	ldr	r3, [r1, #12]
	mov	ip, #0
	umull	r3, r0, r3, r0
	it	cs
	movcs	ip, #1
	adds	r3, r4, r3
	adcs	r0, r5, r0
	ldr	r4, [r1, #16]
	ldr	r5, [r2, #20]
	mov	lr, #0
	umull	r4, r5, r4, r5
	it	cs
	movcs	lr, #1
	adds	r4, r3, r4
	mov	r3, r0
	adcs	r3, r3, r5
	mov	r0, r3
	ldr	r5, [r2, #16]
	ldr	r3, [r1, #20]
	add	lr, lr, ip
	umull	r3, r5, r3, r5
	mov	ip, #0
	it	cs
	movcs	ip, #1
	adds	r3, r4, r3
	mov	r4, r0
	adcs	r4, r4, r5
	mov	r0, r4
	ldr	r5, [r2, #12]
	ldr	r4, [r1, #24]
	add	lr, lr, ip
	umull	r4, r5, r4, r5
	mov	ip, #0
	it	cs
	movcs	ip, #1
	adds	r4, r3, r4
	mov	r3, r0
	adcs	r3, r3, r5
	mov	r0, r3
	ldr	r5, [r1, #28]
	ldr	r3, [r2, #8]
	add	lr, lr, ip
	umull	r5, r3, r5, r3
	mov	ip, #0
	it	cs
	movcs	ip, #1
	adds	r5, r4, r5
	mov	r4, r0
	adcs	r4, r4, r3
	mov	r3, r4
	add	lr, lr, ip
	mov	ip, #0
	it	cs
	movcs	ip, #1
	ldr	r0, [sp]
	add	lr, lr, ip
	str	r5, [r0, #36]
	ldr	r5, [r1, #12]
	ldr	r4, [r2, #28]
	mov	ip, #0
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	lr, lr, r4
	ldr	r5, [r2, #24]
	ldr	r4, [r1, #16]
	it	cs
	movcs	ip, #1
	umull	r4, r5, r4, r5
	adds	r4, r3, r4
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	mov	r0, #0
	it	cs
	movcs	r0, r3
	ldr	r5, [r2, #20]
	ldr	r3, [r1, #20]
	add	ip, ip, r0
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	adcs	lr, lr, r5
	ldr	r4, [r1, #24]
	ldr	r5, [r2, #16]
	mov	r0, #0
	umull	r4, r5, r4, r5
	it	cs
	movcs	r0, #1
	adds	r4, r3, r4
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	mov	r0, #0
	it	cs
	movcs	r0, r3
	ldr	r5, [r1, #28]
	ldr	r3, [r2, #12]
	add	ip, ip, r0
	umull	r5, r3, r5, r3
	adds	r5, r4, r5
	adcs	r3, lr, r3
	mov	r0, #0
	it	cs
	movcs	r0, #1
	ldr	r4, [sp]
	str	r5, [r4, #40]
	mov	r5, r0
	ldr	r4, [r2, #28]
	ldr	r0, [r1, #16]
	add	r5, r5, ip
	umull	lr, r4, r0, r4
	adds	r3, r3, lr
	ldr	r0, [r2, #24]
	adcs	r5, r5, r4
	ldr	r4, [r1, #20]
	mov	ip, #0
	umull	r4, r0, r4, r0
	it	cs
	movcs	ip, #1
	adds	r4, r3, r4
	adcs	r3, r5, r0
	mov	r0, r3
	ldr	r5, [r2, #20]
	ldr	r3, [r1, #24]
	mov	lr, #0
	umull	r3, r5, r3, r5
	it	cs
	movcs	lr, #1
	adds	r3, r4, r3
	mov	r4, r0
	adcs	r4, r4, r5
	mov	r0, r4
	ldr	r5, [r1, #28]
	ldr	r4, [r2, #16]
	add	lr, lr, ip
	umull	r5, r4, r5, r4
	mov	ip, #0
	it	cs
	movcs	ip, #1
	adds	r5, r3, r5
	mov	r3, r0
	adcs	r3, r3, r4
	mov	r4, r3
	add	lr, lr, ip
	mov	ip, #0
	it	cs
	movcs	ip, #1
	ldr	r3, [sp]
	add	lr, lr, ip
	str	r5, [r3, #44]
	ldr	r5, [r1, #20]
	ldr	r3, [r2, #28]
	mov	ip, #0
	umull	r5, r3, r5, r3
	adds	r4, r4, r5
	adcs	lr, lr, r3
	ldr	r5, [r2, #24]
	ldr	r3, [r1, #24]
	it	cs
	movcs	ip, #1
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	adcs	lr, lr, r5
	ldr	r4, [r2, #20]
	ldr	r5, [r1, #28]
	mov	r0, #0
	umull	r5, r4, r5, r4
	it	cs
	movcs	r0, #1
	adds	r5, r3, r5
	adcs	r4, lr, r4
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	mov	r0, #0
	it	cs
	movcs	r0, r3
	ldr	r3, [sp]
	str	r5, [r3, #48]
	mov	r3, r0
	ldr	r5, [r2, #28]
	ldr	r0, [r1, #24]
	add	r3, r3, ip
	umull	lr, r5, r0, r5
	adds	r4, r4, lr
	ldr	r0, [r2, #24]
	adcs	r3, r3, r5
	ldr	r5, [r1, #28]
	mov	ip, #0
	umull	r5, r0, r5, r0
	it	cs
	movcs	ip, #1
	adds	r5, r4, r5
	adcs	r3, r3, r0
	mov	lr, #0
	it	cs
	movcs	lr, #1
	ldr	r0, [sp]
	add	ip, ip, lr
	str	r5, [r0, #52]
	ldr	r1, [r1, #28]
	ldr	r2, [r2, #28]
	umull	r1, r2, r1, r2
	adds	r3, r3, r1
	adcs	r2, ip, r2
	strd	r3, r2, [r0, #56]
	add	sp, sp, #12
	@ sp needed
	pop	{r4, r5, pc}
	.size	mul256_flat6, .-mul256_flat6
	.ident	"GCC: (Arm GNU Toolchain 13.2.rel1 (Build arm-13.7)) 13.2.1 20231009"
