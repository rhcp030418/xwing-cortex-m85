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
	push	{r4, r5, r6, r7, r8, r9, fp, lr}
	mov	lr, r2
	ldr	r3, [r1, #32]
	sub	sp, sp, #144
	str	r3, [sp]
	ldr	r3, [r2, #4]
	ldr	r4, [r2, #8]
	mul	r7, ip, r3
	str	r3, [sp, #72]
	ldr	r3, [r2, #12]
	add	r6, r4, r4, lsl #3
	add	r9, r4, r6, lsl #1
	str	r4, [sp, #44]
	mul	r4, ip, r3
	ldr	r5, [r1, #24]
	str	r0, [sp, #80]
	str	r4, [sp, #116]
	ldr	r0, [r2, #32]
	ldr	r4, [lr, #16]
	ldr	r2, [r1, #28]
	str	r5, [sp, #4]
	ldr	r5, [lr, #20]
	str	r2, [sp, #76]
	add	r2, r4, r4, lsl #3
	add	r6, r4, r2, lsl #1
	mul	r2, ip, r5
	str	r0, [sp, #104]
	str	r2, [sp, #112]
	ldr	r0, [r1, #36]
	ldr	r2, [lr, #24]
	str	r0, [sp, #32]
	mov	r0, r2
	ldr	r2, [r1, #16]
	str	r5, [sp, #56]
	str	r2, [sp, #8]
	ldr	r2, [lr, #28]
	add	r5, r0, r0, lsl #3
	mul	r8, ip, r2
	add	fp, r0, r5, lsl #1
	str	r4, [sp, #64]
	str	r6, [sp, #96]
	ldr	r4, [r1, #20]
	str	r0, [sp, #108]
	str	r2, [sp, #60]
	str	r8, [sp, #88]
	ldr	r5, [r1, #12]
	ldr	r0, [lr, #36]
	str	r5, [sp, #28]
	mul	ip, ip, r0
	ldr	r5, [r1, #8]
	str	r0, [sp, #100]
	str	r5, [sp, #12]
	ldr	r0, [sp, #104]
	ldr	r5, [lr]
	add	lr, r3, r3, lsl #3
	str	r5, [sp, #20]
	str	r3, [sp, #68]
	mov	r5, ip
	add	lr, r3, lr, lsl #1
	add	ip, r0, r0, lsl #3
	ldr	r3, [sp]
	add	ip, r0, ip, lsl #1
	str	ip, [sp, #40]
	umull	lr, ip, lr, r3
	ldr	r0, [sp, #32]
	ldr	r2, [r1, #4]
	umlal	lr, ip, r0, r9
	ldr	r6, [sp, #96]
	str	r2, [sp, #16]
	ldr	r1, [r1]
	ldr	r2, [sp, #76]
	str	r1, [sp, #24]
	umlal	lr, ip, r6, r2
	umull	r6, r1, r9, r3
	umlal	r6, r1, r0, r7
	mov	r8, r6
	ldr	r6, [sp, #116]
	ldr	r0, [sp, #96]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #4]
	mov	r7, r2
	umlal	r8, r1, r0, r6
	ldr	r2, [sp, #112]
	ldr	r0, [sp, #8]
	umlal	r8, r1, r2, r4
	umlal	r8, r1, fp, r0
	ldr	r3, [sp, #88]
	ldr	r2, [sp, #28]
	str	r5, [sp, #84]
	umlal	r8, r1, r3, r2
	ldr	r2, [sp, #40]
	ldr	r3, [sp, #12]
	umlal	r8, r1, r2, r3
	ldr	r3, [sp, #16]
	umlal	r8, r1, r5, r3
	ldrd	r2, r3, [sp, #20]
	umlal	r8, r1, r2, r3
	ldr	r5, [sp, #56]
	str	r1, [sp, #52]
	add	r1, r5, r5, lsl #3
	add	r1, r5, r1, lsl #1
	umlal	lr, ip, r1, r6
	ldr	r6, [sp, #60]
	umlal	lr, ip, fp, r4
	str	r8, [sp, #48]
	bic	r8, r8, #-67108864
	str	r8, [sp, #128]
	add	r8, r6, r6, lsl #3
	add	r8, r6, r8, lsl #1
	str	r8, [sp, #124]
	umlal	lr, ip, r8, r0
	ldrd	r8, [sp, #48]
	lsrl	r8, r9, #26
	ldr	r6, [sp, #40]
	ldr	r2, [sp, #28]
	strd	r8, [sp, #48]
	umlal	lr, ip, r6, r2
	ldr	r6, [sp, #100]
	ldr	r0, [sp, #72]
	add	r8, r6, r6, lsl #3
	add	r8, r6, r8, lsl #1
	ldr	r6, [sp, #12]
	mov	r5, r8
	umlal	lr, ip, r8, r6
	ldrd	r2, r6, [sp, #16]
	ldrd	r8, [sp, #48]
	umlal	lr, ip, r2, r6
	umlal	lr, ip, r0, r3
	adds	r6, lr, r8
	adc	ip, ip, r9
	str	r6, [sp, #48]
	str	ip, [sp, #52]
	bic	ip, r6, #-33554432
	ldr	r6, [sp]
	mov	r3, r0
	ldrd	r8, [sp, #48]
	umull	r6, r1, r6, r1
	lsls	r0, r0, #1
	ldr	r2, [sp, #96]
	str	r0, [sp, #92]
	ldr	r0, [sp, #32]
	str	r5, [sp, #120]
	umlal	r6, r1, r0, r2
	umlal	r6, r1, fp, r7
	ldr	r2, [sp, #124]
	ldr	r7, [sp, #4]
	str	ip, [sp, #132]
	umlal	r6, r1, r2, r7
	ldr	r7, [sp, #40]
	ldr	r2, [sp, #28]
	umlal	r6, r1, r7, r4
	mov	r7, r5
	ldr	r5, [sp, #8]
	str	r4, [sp, #48]
	umlal	r6, r1, r7, r5
	ldr	r4, [sp, #20]
	ldr	r7, [sp, #44]
	umlal	r6, r1, r2, r4
	ldr	r4, [sp, #12]
	ldr	r0, [sp, #32]
	umlal	r6, r1, r4, r3
	ldr	r3, [sp, #16]
	ldr	r4, [sp, #116]
	umlal	r6, r1, r3, r7
	mov	ip, r6
	ldr	r3, [sp, #24]
	ldr	r6, [sp, #68]
	ldr	r7, [sp, #96]
	umlal	ip, r1, r6, r3
	ldr	r6, [sp]
	lsrl	r8, r9, #25
	umull	r7, r6, r7, r6
	umlal	r7, r6, r0, r4
	ldr	r0, [sp, #76]
	ldr	r4, [sp, #112]
	ldr	r3, [sp, #88]
	umlal	r7, r6, r4, r0
	ldr	r4, [sp, #4]
	ldr	r2, [sp, #28]
	umlal	r7, r6, fp, r4
	ldr	r4, [sp, #48]
	str	ip, [sp, #140]
	umlal	r7, r6, r3, r4
	ldr	r3, [sp, #40]
	umlal	r7, r6, r3, r5
	ldr	r5, [sp, #84]
	ldr	r3, [sp, #16]
	umlal	r7, r6, r5, r2
	ldr	r2, [sp, #20]
	ldr	r5, [sp, #12]
	umlal	r7, r6, r5, r2
	ldr	r5, [sp, #92]
	umlal	r7, r6, r3, r5
	ldr	r3, [sp, #24]
	ldr	r5, [sp, #44]
	umlal	r7, r6, r5, r3
	mov	r5, r8
	adds	r7, r7, r5
	mov	r5, r9
	adc	r6, r6, r5
	ldr	r3, [sp, #68]
	str	r7, [sp, #48]
	str	r6, [sp, #52]
	ldrd	r8, [sp, #48]
	lsrl	r8, r9, #26
	bic	ip, r7, #-67108864
	lsls	r7, r3, #1
	str	ip, [sp, #136]
	str	r7, [sp, #96]
	ldr	r7, [sp, #124]
	ldr	r6, [sp]
	ldr	r5, [sp, #120]
	umull	ip, lr, r6, r7
	ldr	r7, [sp, #32]
	ldr	r6, [sp, #40]
	umlal	ip, lr, r7, fp
	umlal	ip, lr, r6, r0
	ldr	r6, [sp, #4]
	strd	r8, [sp, #48]
	umlal	ip, lr, r5, r6
	umlal	ip, lr, r4, r2
	ldr	r5, [sp, #72]
	ldr	r2, [sp, #8]
	umlal	ip, lr, r2, r5
	ldr	r2, [sp, #28]
	ldr	r5, [sp, #44]
	umlal	ip, lr, r2, r5
	ldr	r5, [sp, #12]
	ldr	r2, [sp, #52]
	umlal	ip, lr, r5, r3
	ldr	r3, [sp, #140]
	ldr	r5, [sp, #56]
	adds	r8, r3, r8
	adc	r1, r1, r2
	str	r8, [sp, #32]
	str	r1, [sp, #36]
	ldrd	r2, [sp, #32]
	lsrl	r2, r3, #25
	ldr	r1, [sp, #64]
	strd	r2, [sp, #32]
	ldr	r3, [sp, #16]
	ldr	r2, [sp, #80]
	umlal	ip, lr, r3, r1
	ldr	r3, [sp, #24]
	bic	r1, r8, #-33554432
	umlal	ip, lr, r5, r3
	str	r1, [r2, #12]
	ldr	r1, [sp]
	str	ip, [sp, #48]
	umull	ip, r1, fp, r1
	ldr	r3, [sp, #112]
	ldr	r2, [sp, #8]
	umlal	ip, r1, r7, r3
	ldr	r3, [sp, #88]
	lsls	r5, r5, #1
	umlal	ip, r1, r3, r0
	ldr	r3, [sp, #40]
	umlal	ip, r1, r3, r6
	ldr	r6, [sp, #84]
	umlal	ip, r1, r6, r4
	ldr	r6, [sp, #20]
	ldr	r3, [sp, #92]
	umlal	ip, r1, r2, r6
	ldrd	r8, [sp, #32]
	ldr	r6, [sp, #28]
	ldr	r2, [sp, #44]
	umlal	ip, r1, r6, r3
	ldr	r6, [sp, #12]
	ldr	r3, [sp, #16]
	umlal	ip, r1, r6, r2
	ldr	r2, [sp, #96]
	ldr	r6, [sp, #64]
	umlal	ip, r1, r3, r2
	ldr	r3, [sp, #24]
	ldr	r2, [sp, #80]
	umlal	ip, r1, r6, r3
	mov	r3, r9
	adds	r6, ip, r8
	str	r6, [sp, #32]
	bic	r6, r6, #-67108864
	str	r6, [r2, #16]
	mov	r6, r7
	adc	r1, r1, r3
	str	r1, [sp, #36]
	str	r5, [sp, #112]
	ldr	r1, [sp, #120]
	ldr	r5, [sp]
	ldr	r7, [sp, #40]
	umull	fp, ip, r5, r1
	ldrd	r8, [sp, #32]
	umlal	fp, ip, r6, r7
	mov	r7, r0
	lsrl	r8, r9, #26
	ldr	r0, [sp, #20]
	ldr	r5, [sp, #72]
	umlal	fp, ip, r7, r0
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #44]
	umlal	fp, ip, r0, r5
	umlal	fp, ip, r4, r1
	ldr	r2, [sp, #8]
	ldr	r1, [sp, #68]
	strd	r8, [sp, #32]
	umlal	fp, ip, r2, r1
	ldr	r1, [sp, #48]
	ldr	r3, [sp, #64]
	adds	r8, r1, r8
	ldr	r2, [sp, #28]
	str	r4, [sp, #116]
	str	r8, [sp, #48]
	ldr	r4, [sp, #36]
	umlal	fp, ip, r2, r3
	adc	r4, lr, r4
	str	r4, [sp, #52]
	ldrd	r4, [sp, #48]
	lsrl	r4, r5, #25
	ldr	r1, [sp, #12]
	strd	r4, [sp, #48]
	ldr	r5, [sp, #56]
	ldr	r2, [sp, #80]
	umlal	fp, ip, r1, r5
	bic	r8, r8, #-33554432
	ldr	r5, [sp, #108]
	str	r8, [r2, #20]
	ldr	r2, [sp, #16]
	ldr	r1, [sp, #24]
	umlal	fp, ip, r2, r5
	ldr	r2, [sp, #60]
	ldr	r4, [sp]
	umlal	fp, ip, r2, r1
	ldr	r2, [sp, #40]
	str	r6, [sp, #32]
	umull	r8, lr, r2, r4
	ldr	r2, [sp, #88]
	ldr	r4, [sp, #116]
	umlal	r8, lr, r6, r2
	ldr	r6, [sp, #84]
	ldr	r2, [sp, #8]
	umlal	r8, lr, r6, r7
	ldr	r7, [sp, #20]
	ldr	r6, [sp, #44]
	umlal	r8, lr, r0, r7
	ldr	r7, [sp, #92]
	ldr	r0, [sp, #80]
	umlal	r8, lr, r4, r7
	umlal	r8, lr, r2, r6
	ldr	r7, [sp, #96]
	ldr	r2, [sp, #28]
	ldr	r6, [sp, #12]
	umlal	r8, lr, r2, r7
	umlal	r8, lr, r6, r3
	ldr	r7, [sp, #112]
	ldr	r3, [sp, #16]
	str	fp, [sp, #120]
	umlal	r8, lr, r3, r7
	umlal	r8, lr, r5, r1
	ldr	r1, [sp, #48]
	adds	r6, r8, r1
	mov	r8, r6
	bic	r6, r6, #-67108864
	ldr	r1, [sp, #52]
	str	r6, [r0, #24]
	ldr	r6, [sp, #60]
	ldr	r3, [sp, #20]
	ldr	r5, [sp, #72]
	adc	r9, lr, r1
	ldr	r7, [sp]
	mov	r1, r3
	lsl	lr, r6, #1
	umull	r6, r7, r7, r5
	ldr	r5, [sp, #32]
	lsrl	r8, r9, #26
	mov	r0, r5
	umlal	r6, r7, r5, r3
	ldr	r3, [sp]
	ldr	r5, [sp, #84]
	umull	r3, fp, r3, r1
	umlal	r3, fp, r0, r5
	ldr	r1, [sp, #92]
	ldr	r0, [sp, #76]
	ldr	r5, [sp, #44]
	umlal	r3, fp, r0, r1
	umlal	r6, r7, r0, r5
	ldr	r0, [sp, #4]
	ldr	r1, [sp, #68]
	umlal	r3, fp, r0, r5
	umlal	r6, r7, r0, r1
	ldr	r1, [sp, #96]
	ldr	r0, [sp, #8]
	umlal	r3, fp, r4, r1
	ldr	r1, [sp, #64]
	ldr	r5, [sp, #56]
	umlal	r6, r7, r4, r1
	umlal	r3, fp, r0, r1
	umlal	r6, r7, r0, r5
	ldr	r5, [sp, #112]
	ldr	r4, [sp, #12]
	umlal	r3, fp, r2, r5
	ldr	r5, [sp, #108]
	ldr	r0, [sp, #60]
	umlal	r6, r7, r2, r5
	umlal	r3, fp, r4, r5
	ldr	r1, [sp, #16]
	umlal	r6, r7, r4, r0
	umlal	r3, fp, r1, lr
	ldr	r0, [sp, #104]
	ldr	r2, [sp, #24]
	umlal	r6, r7, r1, r0
	umlal	r3, fp, r0, r2
	ldr	r0, [sp, #100]
	mov	r1, r3
	umlal	r6, r7, r2, r0
	ldr	r2, [sp, #120]
	ldr	r0, [sp, #80]
	adds	r4, r2, r8
	mov	r2, r4
	adc	r3, ip, r9
	lsrl	r2, r3, #25
	bic	r4, r4, #-33554432
	adds	r1, r1, r2
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, fp, r3
	lsrl	r4, r5, #26
	adds	r6, r6, r4
	mov	r2, r6
	adc	r3, r7, r5
	lsrl	r2, r3, #25
	mov	r4, r2
	mov	r5, r3
	lsll	r4, r5, #3
	bic	r1, r1, #-67108864
	str	r1, [r0, #32]
	adds	r1, r4, r2
	adc	r4, r5, r3
	ldr	r5, [sp, #128]
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	adc	r4, r4, r3
	adds	r1, r1, r5
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	mov	r5, r0
	bic	r6, r6, #-33554432
	bic	r1, r1, #-67108864
	str	r6, [r0, #36]
	str	r1, [r0]
	ldr	r0, [sp, #132]
	ldr	r7, [sp, #136]
	adds	r3, r0, r2
	bic	r2, r3, #-33554432
	add	r3, r7, r3, lsr #25
	strd	r2, r3, [r5, #4]
	add	sp, sp, #144
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, fp, pc}
	.size	fiat_mul_ref, .-fiat_mul_ref
	.ident	"GCC: (Arm GNU Toolchain 13.2.rel1 (Build arm-13.7)) 13.2.1 20231009"
