	.arch armv8.1-m.main
	.fpu fpv5-d16
	.arch_extension dsp
	.arch_extension pacbti
	.arch_extension fp
	.arch_extension fp.dp
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
	.file	"fiatmul.c"
	.text
	.align	1
	.p2align 2,,3
	.global	fiat_mul_yield2
	.syntax unified
	.thumb
	.thumb_func
	.type	fiat_mul_yield2, %function
fiat_mul_yield2:
	@ args = 0, pretend = 0, frame = 144
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r3, r1
	push	{r4, r5, r6, r7, r8, r9, lr}
	mov	lr, r2
	ldr	r1, [r2, #36]
	ldr	r2, [r3, #36]
	mov	ip, #38
	mov	r6, r2
	sub	sp, sp, #148
	str	r1, [sp, #44]
	ldr	r1, [lr, #12]
	ldr	r2, [r3, #32]
	add	r9, r1, r1, lsl #3
	add	r9, r1, r9, lsl #1
	ldr	r4, [lr, #8]
	umull	r9, r5, r9, r2
	str	r0, [sp, #40]
	add	r8, r4, r4, lsl #3
	mov	r0, r3
	ldr	r3, [lr, #4]
	add	r8, r4, r8, lsl #1
	str	r2, [sp, #16]
	umlal	r9, r5, r6, r8
	str	r4, [sp, #12]
	umull	r8, r2, r8, r2
	mul	r4, ip, r3
	umlal	r8, r2, r6, r4
	mul	r4, ip, r1
	str	r3, [sp, #52]
	ldr	r3, [lr, #16]
	str	r6, [sp, #8]
	add	r6, r3, r3, lsl #3
	add	r6, r3, r6, lsl #1
	str	r3, [sp, #32]
	mov	r3, r4
	ldr	r7, [lr, #20]
	ldr	r4, [r0, #28]
	str	r0, [sp, #4]
	umlal	r9, r5, r6, r4
	mov	r0, r4
	umlal	r8, r2, r3, r4
	add	r4, r7, r7, lsl #3
	add	r4, r7, r4, lsl #1
	str	r7, [sp, #76]
	mul	r7, ip, r7
	str	r1, [sp, #48]
	ldr	r1, [lr, #24]
	str	r7, [sp, #56]
	add	r7, r1, r1, lsl #3
	str	r1, [sp, #84]
	add	r7, r1, r7, lsl #1
	mov	r1, r5
	str	r3, [sp, #24]
	mov	r3, r7
	ldr	r7, [sp, #4]
	ldr	r5, [sp, #16]
	ldr	r7, [r7, #24]
	umlal	r9, r1, r4, r7
	str	r1, [sp, #36]
	ldr	r1, [sp, #16]
	umlal	r8, r2, r6, r7
	str	r7, [sp, #20]
	umull	r7, r4, r1, r4
	ldr	r1, [sp, #8]
	str	r8, [sp, #28]
	umlal	r7, r4, r1, r6
	umull	r8, r6, r6, r5
	mov	r5, r1
	ldr	r1, [sp, #24]
	umlal	r7, r4, r3, r0
	umlal	r8, r6, r5, r1
	ldr	r5, [sp, #56]
	mov	r1, r3
	umlal	r8, r6, r5, r0
	ldr	r5, [sp, #20]
	umlal	r8, r6, r3, r5
	ldr	r3, [lr, #28]
	str	r6, [sp, #88]
	mov	r6, r3
	str	r8, [sp, #72]
	mov	r8, r4
	ldr	r3, [lr, #32]
	str	r6, [sp, #68]
	str	r3, [sp, #64]
	ldr	r3, [lr]
	add	lr, r6, r6, lsl #3
	add	lr, r6, lr, lsl #1
	umlal	r7, r8, lr, r5
	str	r8, [sp, #92]
	mov	r8, r2
	str	r3, [sp, #60]
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #36]
	ldr	r3, [r3, #20]
	ldr	r6, [sp, #28]
	umlal	r9, r2, r1, r3
	ldr	r5, [sp, #56]
	str	r9, [sp, #80]
	umlal	r6, r8, r5, r3
	mov	r5, r2
	ldr	r2, [sp, #68]
	ldr	r4, [sp, #72]
	mul	r9, ip, r2
	str	r8, [sp, #24]
	ldr	r2, [sp, #44]
	mov	r8, r6
	ldr	r6, [sp, #88]
	mul	ip, ip, r2
	umlal	r4, r6, r9, r3
	str	ip, [sp, #28]
	mov	ip, r4
	ldr	r2, [sp, #64]
	str	r9, [sp, #72]
	add	r9, r2, r2, lsl #3
	add	r9, r2, r9, lsl #1
	ldr	r2, [sp, #92]
	str	r3, [sp, #36]
	umlal	r7, r2, r9, r3
	ldr	r3, [sp, #4]
	mov	r4, r2
	str	r7, [sp, #104]
	ldr	r2, [sp, #24]
	ldr	r7, [r3, #16]
	umlal	ip, r6, r9, r7
	umlal	r8, r2, r1, r7
	str	r8, [sp, #88]
	str	r6, [sp, #100]
	mov	r6, r1
	ldr	r3, [sp, #80]
	str	ip, [sp, #96]
	umlal	r3, r5, lr, r7
	str	r3, [sp, #92]
	ldr	r3, [sp, #16]
	str	r7, [sp, #24]
	umull	ip, lr, r3, lr
	ldr	r3, [sp, #8]
	str	r0, [sp, #80]
	umlal	ip, lr, r3, r1
	ldr	r1, [sp, #16]
	umlal	ip, lr, r9, r0
	umull	r7, r8, r6, r1
	ldr	r1, [sp, #56]
	ldr	r6, [sp, #72]
	umlal	r7, r8, r3, r1
	umlal	r7, r8, r6, r0
	ldr	r6, [sp, #20]
	ldr	r1, [sp, #28]
	umlal	r7, r8, r9, r6
	ldr	r3, [sp, #36]
	ldr	r0, [sp, #24]
	umlal	r7, r8, r1, r3
	mov	r1, r7
	ldr	r3, [sp, #60]
	ldr	r7, [sp, #24]
	umlal	r1, r8, r7, r3
	str	r8, [sp, #120]
	mov	r8, r4
	str	r1, [sp, #116]
	ldr	r1, [sp, #44]
	ldr	r3, [sp, #60]
	add	r7, r1, r1, lsl #3
	add	r7, r1, r7, lsl #1
	umlal	ip, lr, r7, r6
	ldr	r1, [sp, #104]
	ldr	r6, [sp, #36]
	umlal	r1, r8, r7, r0
	umlal	ip, lr, r6, r3
	str	r1, [sp, #56]
	ldr	r6, [sp, #4]
	ldr	r1, [sp, #52]
	ldr	r4, [sp, #72]
	umlal	ip, lr, r0, r1
	ldr	r1, [r6, #12]
	ldr	r0, [sp, #88]
	str	r8, [sp, #108]
	umlal	r0, r2, r4, r1
	ldr	r4, [sp, #92]
	str	r0, [sp, #60]
	umlal	r4, r5, r9, r1
	str	r5, [sp, #88]
	mov	r8, r4
	ldr	r5, [sp, #28]
	ldr	r4, [sp, #96]
	ldr	r6, [sp, #100]
	ldr	r0, [sp, #4]
	umlal	r4, r6, r5, r1
	ldr	r5, [sp, #56]
	str	r4, [sp, #104]
	ldr	r4, [sp, #108]
	str	r1, [sp, #56]
	umlal	r5, r4, r1, r3
	str	r5, [sp, #112]
	ldr	r5, [sp, #12]
	umlal	ip, lr, r1, r5
	ldr	r1, [r0, #8]
	mov	r0, r2
	mov	r2, r1
	ldr	r5, [sp, #60]
	str	r3, [sp, #60]
	umlal	r5, r0, r9, r1
	ldr	r1, [sp, #88]
	str	r0, [sp, #96]
	ldr	r0, [sp, #104]
	umlal	r8, r1, r7, r2
	umlal	r0, r6, r2, r3
	str	r5, [sp, #92]
	strd	r0, r6, [sp, #104]
	ldr	r5, [sp, #112]
	ldr	r6, [sp, #52]
	str	r1, [sp, #100]
	ldr	r1, [sp, #48]
	umlal	r5, r4, r2, r6
	umlal	ip, lr, r2, r1
	str	r2, [sp, #88]
	ldr	r2, [sp, #16]
	ldr	r0, [sp, #80]
	umull	r6, r7, r2, r7
	ldr	r2, [sp, #8]
	str	r5, [sp, #112]
	umlal	r6, r7, r2, r9
	umlal	r6, r7, r0, r3
	ldr	r5, [sp, #52]
	ldr	r3, [sp, #20]
	str	lr, [sp, #128]
	umlal	r6, r7, r3, r5
	str	ip, [sp, #124]
	ldr	r3, [sp, #36]
	ldr	r5, [sp, #12]
	umlal	r6, r7, r3, r5
	ldr	r3, [sp, #24]
	ldr	r5, [sp, #76]
	umlal	r6, r7, r3, r1
	ldr	r1, [sp, #56]
	ldr	r3, [sp, #32]
	umlal	r6, r7, r1, r3
	mov	ip, r6
	ldr	r6, [sp, #88]
	ldr	r3, [sp, #16]
	umlal	ip, r7, r6, r5
	str	ip, [sp, #136]
	umull	ip, r6, r9, r3
	ldr	r5, [sp, #72]
	ldr	r3, [sp, #20]
	umlal	ip, r6, r2, r5
	ldr	r5, [sp, #28]
	ldr	r2, [sp, #4]
	umlal	ip, r6, r5, r0
	ldr	r0, [sp, #60]
	umlal	ip, r6, r3, r0
	ldrd	r3, lr, [r2]
	str	r3, [sp, #4]
	ldrd	r3, r1, [sp, #92]
	umlal	r3, r1, r5, lr
	str	r1, [sp, #60]
	ldr	r1, [sp, #100]
	mov	r9, r3
	umlal	r8, r1, lr, r0
	mov	r3, r0
	mov	r5, r1
	str	r6, [sp, #132]
	ldr	r1, [sp, #12]
	ldr	r6, [sp, #112]
	umlal	r6, r4, lr, r1
	ldr	r1, [sp, #32]
	str	r6, [sp, #96]
	ldrd	r0, r6, [sp, #124]
	umlal	r0, r6, lr, r1
	mov	r2, r6
	mov	r1, r0
	ldr	r6, [sp, #60]
	ldr	r0, [sp, #4]
	umlal	r9, r6, r3, r0
	str	r9, [sp, #60]
	mov	r9, r5
	str	r6, [sp, #72]
	ldr	r0, [sp, #52]
	ldr	r6, [sp, #4]
	ldr	r5, [sp, #48]
	umlal	r8, r9, r0, r6
	str	r8, [sp, #52]
	mov	r8, r4
	ldr	r6, [sp, #96]
	ldr	r4, [sp, #4]
	str	r9, [sp, #92]
	umlal	r6, r8, r5, r4
	mov	r4, r2
	str	r8, [sp, #112]
	mov	r8, r1
	ldr	r2, [sp, #4]
	ldr	r5, [sp, #76]
	str	r6, [sp, #100]
	umlal	r8, r4, r5, r2
	ldr	r5, [sp, #136]
	str	r4, [sp, #128]
	ldr	r4, [sp, #84]
	str	r8, [sp, #124]
	umlal	r5, r7, lr, r4
	mov	r8, r5
	ldrd	r6, r5, [sp, #116]
	mov	r9, r7
	ldr	r4, [sp, #68]
	lsls	r7, r0, #1
	umlal	r8, r9, r4, r2
	ldr	r4, [sp, #36]
	ldr	r2, [sp, #132]
	str	r9, [sp, #140]
	umlal	ip, r2, r4, r7
	mov	r1, ip
	ldr	r4, [sp, #56]
	mov	r9, r1
	umlal	r6, r5, r4, r7
	mov	ip, r5
	mov	r5, r6
	ldrd	r4, r6, [sp, #104]
	umlal	r4, r6, lr, r7
	str	r8, [sp, #136]
	mov	r8, r6
	ldr	r1, [sp, #24]
	ldr	r6, [sp, #12]
	umlal	r9, r2, r1, r6
	ldr	r1, [sp, #12]
	str	r9, [sp, #104]
	mov	r9, r5
	ldr	r5, [sp, #4]
	str	r2, [sp, #108]
	umlal	r4, r8, r1, r5
	mov	r5, r0
	ldr	r2, [sp, #88]
	str	r8, [sp, #96]
	ldr	r0, [sp, #16]
	str	r4, [sp, #88]
	umull	r4, r5, r0, r5
	ldr	r6, [sp, #8]
	umlal	r9, ip, r2, r1
	umlal	r4, r5, r6, r3
	umull	r3, r1, r0, r3
	mov	r0, r6
	ldr	r6, [sp, #28]
	umlal	r3, r1, r0, r6
	ldr	r6, [sp, #12]
	ldr	r0, [sp, #80]
	umlal	r3, r1, r0, r7
	umlal	r4, r5, r0, r6
	ldr	r7, [sp, #20]
	ldr	r0, [sp, #48]
	umlal	r3, r1, r7, r6
	lsl	r8, r0, #1
	umlal	r4, r5, r7, r0
	ldr	r6, [sp, #108]
	ldr	r7, [sp, #56]
	ldr	r0, [sp, #104]
	umlal	r9, ip, lr, r8
	umlal	r0, r6, r7, r8
	mov	r7, r0
	ldr	r0, [sp, #36]
	umlal	r3, r1, r0, r8
	str	r3, [sp, #8]
	ldr	r3, [sp, #32]
	umlal	r4, r5, r0, r3
	ldr	r0, [sp, #24]
	str	r4, [sp, #16]
	ldr	r4, [sp, #8]
	umlal	r7, r6, r2, r3
	umlal	r4, r1, r0, r3
	strd	r4, r1, [sp, #8]
	ldr	r1, [sp, #76]
	ldr	r4, [sp, #16]
	lsl	r8, r1, #1
	umlal	r4, r5, r0, r1
	mov	r0, r3
	umlal	r7, r6, lr, r8
	ldr	r3, [sp, #4]
	umlal	r9, ip, r0, r3
	ldrd	r3, r1, [sp, #8]
	ldr	r0, [sp, #56]
	str	r6, [sp, #8]
	umlal	r3, r1, r0, r8
	ldr	r6, [sp, #84]
	mov	r8, r7
	umlal	r4, r5, r0, r6
	mov	r0, r2
	umlal	r3, r1, r2, r6
	ldrd	r7, r2, [sp, #4]
	umlal	r8, r2, r6, r7
	ldr	r7, [sp, #68]
	mov	r6, r2
	umlal	r4, r5, r0, r7
	ldr	r0, [sp, #64]
	lsls	r7, r7, #1
	umlal	r4, r5, lr, r0
	umlal	r3, r1, lr, r7
	mov	lr, r4
	str	r8, [sp, #8]
	ldr	r2, [sp, #4]
	ldr	r4, [sp, #60]
	umlal	r3, r1, r0, r2
	str	r3, [sp, #12]
	ldr	r3, [sp, #44]
	ldr	r7, [sp, #52]
	umlal	lr, r5, r2, r3
	ldr	r2, [sp, #72]
	lsrs	r3, r4, #26
	orr	r3, r3, r2, lsl #6
	adds	r3, r7, r3
	ldr	r7, [sp, #92]
	bic	r4, r4, #-67108864
	adc	r2, r7, r2, lsr #26
	str	r4, [sp, #4]
	ldr	r7, [sp, #88]
	mov	r0, lr
	lsrs	r4, r3, #25
	orr	r4, r4, r2, lsl #7
	adds	r4, r7, r4
	ldr	r7, [sp, #96]
	lsr	lr, r4, #26
	adc	r2, r7, r2, lsr #25
	ldr	r7, [sp, #100]
	orr	lr, lr, r2, lsl #6
	adds	lr, r7, lr
	ldr	r7, [sp, #112]
	lsr	r8, lr, #25
	adc	r2, r7, r2, lsr #26
	orr	r8, r8, r2, lsl #7
	ldr	r7, [sp, #40]
	adds	r8, r9, r8
	bic	lr, lr, #-33554432
	adc	r2, ip, r2, lsr #25
	str	lr, [r7, #12]
	lsr	ip, r8, #26
	ldr	r7, [sp, #124]
	orr	ip, ip, r2, lsl #6
	adds	ip, r7, ip
	ldr	r7, [sp, #128]
	bic	r8, r8, #-67108864
	adc	r2, r7, r2, lsr #26
	ldr	r7, [sp, #40]
	lsr	lr, ip, #25
	str	r8, [r7, #16]
	ldr	r7, [sp, #8]
	orr	lr, lr, r2, lsl #7
	adds	lr, r7, lr
	ldr	r7, [sp, #40]
	adc	r2, r6, r2, lsr #25
	bic	r6, ip, #-33554432
	str	r6, [r7, #20]
	ldr	r7, [sp, #136]
	lsr	r6, lr, #26
	orr	r6, r6, r2, lsl #6
	adds	r6, r7, r6
	ldr	r7, [sp, #140]
	bic	lr, lr, #-67108864
	adc	r2, r7, r2, lsr #26
	ldr	r7, [sp, #40]
	lsr	ip, r6, #25
	str	lr, [r7, #24]
	ldr	r7, [sp, #12]
	orr	ip, ip, r2, lsl #7
	adds	ip, r7, ip
	adc	r1, r1, r2, lsr #25
	lsr	r2, ip, #26
	ldr	r7, [sp, #40]
	orr	r2, r2, r1, lsl #6
	adds	r9, r0, r2
	bic	r6, r6, #-33554432
	adc	r5, r5, r1, lsr #26
	str	r6, [r7, #28]
	bic	r2, ip, #-67108864
	lsr	r6, r9, #25
	orr	r6, r6, r5, lsl #7
	str	r2, [r7, #32]
	lsrs	r5, r5, #25
	bic	r2, r9, #-33554432
	str	r2, [r7, #36]
	lsls	r1, r5, #3
	lsls	r2, r6, #3
	adds	r2, r2, r6
	orr	r1, r1, r6, lsr #29
	adc	r1, r5, r1
	adds	r2, r2, r2
	adcs	r1, r1, r1
	adds	r2, r2, r6
	adc	r5, r5, r1
	ldr	r1, [sp, #4]
	bic	r3, r3, #-33554432
	adds	r2, r2, r1
	adc	r5, r5, #0
	lsrs	r1, r2, #26
	orr	r1, r1, r5, lsl #6
	add	r3, r3, r1
	bic	r4, r4, #-67108864
	bic	r2, r2, #-67108864
	bic	r1, r3, #-33554432
	add	r4, r4, r3, lsr #25
	strd	r2, r1, [r7]
	str	r4, [r7, #8]
	add	sp, sp, #148
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
	.size	fiat_mul_yield2, .-fiat_mul_yield2
	.ident	"GCC: (Arm GNU Toolchain 13.2.rel1 (Build arm-13.7)) 13.2.1 20231009"
