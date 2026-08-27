	.arch armv8.1-m.main
	.fpu fpv5-d16
	.arch_extension dsp
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
	.eabi_attribute 18, 4
	.file	"fiatref.c"
	.text
	.section	.text.fiat_mul_ref,"ax",%progbits
	.align	1
	.p2align 2,,3
	.global	fiat_mul_ref
	.syntax unified
	.thumb
	.thumb_func
	.type	fiat_mul_ref, %function
fiat_mul_ref:
	@ args = 0, pretend = 0, frame = 144
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	ip, #38
	push	{r4, r5, r6, r7, r8, r9, r10, lr}
	mov	lr, r2
	ldr	r3, [r2, #4]
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	sub	sp, sp, #144
	mul	r6, ip, r2
	str	r0, [sp, #84]
	str	r2, [sp, #40]
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str	r6, [sp, #120]
	str	r2, [sp, #8]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	add	r8, r0, r2, lsl #1
	str	r8, [sp, #96]
	ldr	r2, [lr, #28]
	mul	r8, ip, r6
	str	r6, [sp, #52]
	ldr	r6, [r1, #16]
	str	r7, [sp, #108]
	str	r6, [sp, #16]
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	str	r7, [sp, #80]
	ldr	r7, [lr, #24]
	str	r5, [sp, #100]
	mov	r2, r7
	mov	r5, r4
	str	r8, [sp, #116]
	mul	r8, ip, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	add	r10, r2, r7, lsl #1
	str	r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #64]
	mul	r5, ip, r3
	str	r0, [sp, #76]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #112]
	str	r6, [sp, #72]
	str	r8, [sp, #88]
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str	r7, [sp, #24]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #20]
	ldr	r7, [lr]
	str	r2, [sp, #104]
	ldr	r2, [r1, #4]
	str	r7, [sp, #32]
	ldr	r7, [sp, #108]
	str	r2, [sp, #4]
	ldr	r2, [r1]
	ldr	r1, [sp, #40]
	str	ip, [sp, #68]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #80]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #36]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #100]
	ldr	r6, [sp, #96]
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	str	r3, [sp, #96]
	umlal	lr, ip, r6, r3
	ldr	r3, [sp, #100]
	ldr	r7, [sp, #20]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r3, [sp, #96]
	ldr	r5, [sp, #120]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	ldr	r4, [sp, #116]
	ldr	r5, [sp, #16]
	umlal	r8, r1, r4, r0
	umlal	r8, r1, r10, r5
	ldr	r4, [sp, #88]
	str	r6, [sp, #96]
	ldr	r6, [sp, #24]
	umlal	r8, r1, r4, r6
	ldr	r6, [sp, #36]
	ldr	r4, [sp, #4]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #68]
	umlal	r8, r1, r6, r4
	ldr	r6, [sp, #32]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #52]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	umlal	lr, ip, r1, r4
	ldr	r4, [sp, #72]
	umlal	lr, ip, r10, r0
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	str	r8, [sp, #132]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r5
	ldr	r6, [sp, #24]
	ldr	r5, [sp, #36]
	str	r0, [sp, #124]
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr	r5, [sp, #104]
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	ldr	r7, [sp, #20]
	add	r8, r5, r8, lsl #1
	umlal	lr, ip, r8, r7
	ldr	r4, [sp, #32]
	ldr	r5, [sp, #4]
	str	r2, [sp, #48]
	umlal	lr, ip, r5, r4
	ldr	r5, [sp, #64]
	ldr	r4, [sp, #56]
	umlal	lr, ip, r5, r2
	lsls	r2, r5, #1
	ldr	r7, [sp, #80]
	str	r2, [sp, #92]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	mov	r6, r8
	adc	r9, ip, r2
	mov	r8, r4
	ldrd	r2, r5, [sp, #96]
	bic	ip, r4, #-33554432
	umull	r4, r1, r7, r1
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	str	r0, [sp, #128]
	ldr	r0, [sp, #8]
	str	ip, [sp, #136]
	umlal	r4, r1, r2, r0
	ldr	r0, [sp, #124]
	ldr	r2, [sp, #36]
	str	r6, [sp, #124]
	umlal	r4, r1, r2, r0
	mov	r2, r6
	ldr	r6, [sp, #16]
	lsrl	r8, r9, #25
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #32]
	umlal	r4, r1, r6, r2
	ldr	r6, [sp, #64]
	ldr	r2, [sp, #20]
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #44]
	ldr	r2, [sp, #4]
	umlal	r4, r1, r2, r6
	mov	ip, r4
	ldr	r2, [sp, #48]
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #16]
	umlal	ip, r1, r4, r2
	ldr	r4, [sp, #96]
	str	ip, [sp, #140]
	umull	lr, ip, r4, r7
	ldr	r4, [sp, #120]
	ldr	r2, [sp, #88]
	umlal	lr, ip, r5, r4
	ldr	r4, [sp, #116]
	ldr	r7, [sp, #20]
	umlal	lr, ip, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, ip, r10, r4
	umlal	lr, ip, r2, r0
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #68]
	umlal	lr, ip, r2, r6
	ldr	r2, [sp, #32]
	umlal	lr, ip, r7, r2
	ldr	r2, [sp, #92]
	ldr	r7, [sp, #4]
	umlal	lr, ip, r7, r2
	ldrd	r7, r2, [sp, #44]
	umlal	lr, ip, r7, r2
	adds	lr, lr, r8
	adc	r2, ip, r9
	str	lr, [sp, #56]
	str	r2, [sp, #60]
	ldr	r2, [sp, #40]
	ldrd	r8, [sp, #56]
	lsrl	r8, r9, #26
	bic	ip, lr, #-67108864
	lsls	r2, r2, #1
	str	ip, [sp, #120]
	str	r2, [sp, #100]
	ldr	r2, [sp, #128]
	ldr	r7, [sp, #80]
	strd	r8, [sp, #56]
	umull	lr, ip, r7, r2
	umlal	lr, ip, r5, r10
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r3
	ldr	r2, [sp, #124]
	umlal	lr, ip, r2, r4
	ldr	r2, [sp, #32]
	ldr	r4, [sp, #16]
	umlal	lr, ip, r0, r2
	ldr	r2, [sp, #64]
	umlal	lr, ip, r4, r2
	ldr	r4, [sp, #44]
	ldr	r2, [sp, #4]
	umlal	lr, ip, r6, r4
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #20]
	umlal	lr, ip, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #140]
	adds	r4, r6, r4
	mov	r8, r4
	ldr	r6, [sp, #60]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	ldr	r1, [sp, #76]
	lsrl	r8, r9, #25
	umlal	lr, ip, r2, r1
	ldrd	r1, r6, [sp, #48]
	umlal	lr, ip, r6, r1
	ldr	r2, [sp, #84]
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	ldr	r4, [sp, #116]
	ldr	r2, [sp, #36]
	umlal	lr, r1, r5, r4
	ldr	r4, [sp, #88]
	ldr	r6, [sp, #68]
	umlal	lr, r1, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, r1, r2, r4
	umlal	lr, r1, r6, r0
	ldr	r2, [sp, #32]
	ldr	r6, [sp, #16]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #92]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #20]
	ldr	r2, [sp, #44]
	umlal	lr, r1, r6, r2
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #100]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #76]
	ldr	r2, [sp, #48]
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	adc	r1, r1, r9
	str	lr, [sp, #8]
	str	r1, [sp, #12]
	ldrd	r8, [sp, #8]
	lsrl	r8, r9, #26
	ldr	r6, [sp, #124]
	ldr	r2, [sp, #84]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	str	r1, [r2, #16]
	ldr	r2, [sp, #36]
	ldr	r6, [sp, #64]
	umlal	r10, lr, r5, r2
	ldr	r2, [sp, #32]
	str	r4, [sp, #8]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	ldr	r4, [sp, #44]
	ldr	r6, [sp, #16]
	umlal	r10, lr, r0, r4
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #20]
	umlal	r10, lr, r6, r4
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #76]
	ldr	r1, [sp, #52]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #56]
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr	r6, [sp, #52]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r6
	ldr	r2, [sp, #84]
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr	r4, [sp, #112]
	ldr	r2, [sp, #4]
	adc	ip, ip, r9
	umlal	r10, lr, r2, r4
	ldr	r4, [sp, #72]
	ldr	r2, [sp, #48]
	str	ip, [sp, #60]
	umlal	r10, lr, r4, r2
	ldrd	r8, [sp, #56]
	str	r10, [sp, #80]
	ldr	r2, [sp, #36]
	lsrl	r8, r9, #25
	umull	r4, ip, r2, r7
	ldr	r2, [sp, #88]
	str	r3, [sp, #96]
	umlal	r4, ip, r5, r2
	ldr	r2, [sp, #68]
	ldr	r6, [sp, #16]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #8]
	ldr	r2, [sp, #32]
	strd	r8, [sp, #56]
	umlal	r4, ip, r3, r2
	ldr	r3, [sp, #92]
	ldr	r2, [sp, #20]
	umlal	r4, ip, r0, r3
	ldr	r3, [sp, #44]
	umlal	r4, ip, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #100]
	umlal	r4, ip, r6, r3
	ldr	r3, [sp, #76]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #48]
	umlal	r4, ip, r3, r1
	ldr	r3, [sp, #112]
	umlal	r4, ip, r3, r2
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, ip, r4
	str	r4, [sp, #28]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #84]
	ldr	r2, [sp, #64]
	bic	r8, r8, #-67108864
	str	r8, [r3, #24]
	ldr	r3, [sp, #72]
	umull	ip, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #32]
	ldr	r2, [sp, #68]
	umlal	ip, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	ldrd	r2, r4, [sp, #92]
	ldr	r5, [sp, #44]
	umlal	r3, r10, r4, r2
	umlal	ip, r8, r4, r5
	ldr	r4, [sp, #8]
	ldr	r2, [sp, #20]
	umlal	r3, r10, r4, r5
	ldr	r5, [sp, #40]
	umlal	ip, r8, r4, r5
	ldr	r5, [sp, #100]
	ldr	r4, [sp, #76]
	umlal	r3, r10, r0, r5
	umlal	ip, r8, r0, r4
	ldr	r0, [sp, #16]
	ldr	r5, [sp, #104]
	umlal	r3, r10, r0, r4
	ldr	r4, [sp, #52]
	umlal	r3, r10, r6, r1
	umlal	ip, r8, r0, r4
	ldr	r0, [sp, #112]
	ldr	r4, [sp, #72]
	umlal	ip, r8, r6, r0
	umlal	r3, r10, r2, r0
	umlal	ip, r8, r2, r4
	ldr	r0, [sp, #108]
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #80]
	umlal	r3, r10, r2, r9
	umlal	ip, r8, r2, r0
	ldr	r2, [sp, #48]
	umlal	r3, r10, r0, r2
	umlal	ip, r8, r2, r5
	ldr	r2, [sp, #24]
	ldr	r5, [sp, #28]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	ldr	r0, [sp, #84]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	lsrl	r4, r5, #26
	adds	ip, ip, r4
	mov	r2, ip
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r4, r2
	mov	r5, r3
	lsll	r4, r5, #3
	bic	r1, r1, #-67108864
	str	r1, [r0, #32]
	bic	r1, ip, #-33554432
	str	r1, [r0, #36]
	adds	r1, r4, r2
	adc	r4, r5, r3
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	adc	r4, r4, r3
	ldr	r3, [sp, #132]
	adds	r1, r1, r3
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	bic	r1, r1, #-67108864
	str	r1, [r0]
	ldr	r1, [sp, #136]
	adds	r3, r1, r2
	ldr	r1, [sp, #120]
	bic	r2, r3, #-33554432
	add	r3, r1, r3, lsr #25
	strd	r2, r3, [r0, #4]
	add	sp, sp, #144
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, pc}
	.size	fiat_mul_ref, .-fiat_mul_ref
	.ident	"GCC: (Arm GNU Toolchain 13.2.rel1 (Build arm-13.7)) 13.2.1 20231009"
