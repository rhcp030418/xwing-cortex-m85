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
	@ args = 0, pretend = 0, frame = 128
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
	sub	sp, sp, #132
	str	r7, [sp, #100]
	ldr	r7, [r1, #32]
	ldr	r6, [r2, #12]
	str	r7, [sp, #76]
	ldr	r7, [lr, #20]
	ldr	r3, [r2, #4]
	mul	r8, ip, r7
	ldr	r4, [r2, #8]
	str	r6, [sp, #36]
	mul	r2, ip, r6
	str	r7, [sp, #48]
	ldr	r6, [r1, #16]
	ldr	r7, [lr, #28]
	str	r6, [sp, #4]
	mov	r6, r7
	ldr	r5, [r1, #36]
	str	r0, [sp, #80]
	str	r5, [sp, #92]
	mov	r5, r4
	ldr	r0, [lr, #16]
	str	r2, [sp, #112]
	ldr	r2, [r1, #24]
	str	r8, [sp, #108]
	str	r2, [sp, #16]
	add	r2, r0, r0, lsl #3
	add	r10, r0, r2, lsl #1
	ldr	r2, [lr, #24]
	mul	r8, ip, r6
	add	r7, r2, r2, lsl #3
	add	fp, r2, r7, lsl #1
	ldr	r7, [r1, #12]
	add	r4, r4, r4, lsl #3
	str	r5, [sp, #40]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #52]
	mul	r5, ip, r3
	str	r0, [sp, #72]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #104]
	str	r6, [sp, #68]
	str	r8, [sp, #84]
	str	r7, [sp, #24]
	ldr	r2, [lr, #36]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #8]
	ldr	r7, [lr]
	str	r2, [sp, #96]
	ldr	r2, [r1, #4]
	str	r7, [sp, #12]
	ldr	r7, [sp, #100]
	str	r2, [sp]
	ldr	r2, [r1]
	ldr	r1, [sp, #36]
	str	ip, [sp, #64]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #76]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #32]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #92]
	mov	r6, r3
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	umlal	lr, ip, r10, r3
	ldr	r3, [sp, #92]
	ldr	r7, [sp, #8]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r4, [sp, #112]
	ldr	r5, [sp, #108]
	umlal	r8, r1, r4, r6
	ldr	r4, [sp, #16]
	mov	r3, r6
	umlal	r8, r1, r10, r4
	umlal	r8, r1, r5, r0
	ldr	r6, [sp, #4]
	ldr	r5, [sp, #84]
	umlal	r8, r1, fp, r6
	ldr	r6, [sp, #24]
	umlal	r8, r1, r5, r6
	ldr	r6, [sp, #32]
	ldr	r5, [sp]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #64]
	umlal	r8, r1, r6, r5
	ldr	r6, [sp, #12]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #48]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	umlal	lr, ip, r1, r4
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	umlal	lr, ip, fp, r0
	str	r8, [sp, #120]
	ldr	r4, [sp, #68]
	ldr	r6, [sp, #4]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r6
	ldr	r5, [sp, #32]
	ldr	r6, [sp, #24]
	str	r8, [sp, #116]
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	ldr	r5, [sp, #96]
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	add	r8, r5, r8, lsl #1
	mov	r6, r8
	ldr	r7, [sp, #8]
	ldr	r5, [sp, #12]
	umlal	lr, ip, r8, r7
	ldr	r4, [sp]
	str	r2, [sp, #44]
	umlal	lr, ip, r4, r5
	ldr	r4, [sp, #52]
	ldr	r7, [sp, #76]
	umlal	lr, ip, r4, r2
	lsls	r4, r4, #1
	str	r4, [sp, #88]
	ldr	r4, [sp, #56]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	adc	r9, ip, r2
	bic	ip, r4, #-33554432
	str	ip, [sp, #124]
	umull	r1, ip, r7, r1
	ldr	r5, [sp, #92]
	ldr	r2, [sp, #116]
	umlal	r1, ip, r5, r10
	umlal	r1, ip, fp, r3
	mov	r8, r4
	ldr	r4, [sp, #16]
	str	r6, [sp, #92]
	umlal	r1, ip, r2, r4
	ldr	r2, [sp, #32]
	lsrl	r8, r9, #25
	umlal	r1, ip, r2, r0
	mov	r2, r6
	ldr	r6, [sp, #4]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #12]
	umlal	r1, ip, r6, r2
	ldr	r6, [sp, #52]
	ldr	r2, [sp, #8]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #40]
	ldr	r2, [sp]
	umlal	r1, ip, r2, r6
	mov	lr, r1
	ldr	r6, [sp, #36]
	ldr	r1, [sp, #44]
	umlal	lr, ip, r6, r1
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	ldr	r6, [sp, #112]
	ldr	r2, [sp, #84]
	umlal	lr, r1, r5, r6
	ldr	r6, [sp, #108]
	umlal	lr, r1, r6, r3
	umlal	lr, r1, fp, r4
	umlal	lr, r1, r2, r0
	ldr	r6, [sp, #4]
	ldr	r2, [sp, #32]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #64]
	umlal	lr, r1, r2, r6
	ldrd	r7, r2, [sp, #8]
	umlal	lr, r1, r7, r2
	ldr	r2, [sp, #88]
	ldr	r7, [sp]
	umlal	lr, r1, r7, r2
	ldrd	r7, r2, [sp, #40]
	umlal	lr, r1, r7, r2
	adds	lr, lr, r8
	adc	r2, r1, r9
	str	lr, [sp, #16]
	str	r2, [sp, #20]
	ldrd	r8, [sp, #16]
	lsrl	r8, r9, #26
	ldr	r7, [sp, #76]
	ldr	r2, [sp, #116]
	bic	lr, lr, #-67108864
	str	lr, [sp, #112]
	umull	r10, lr, r7, r2
	umlal	r10, lr, r5, fp
	ldr	r2, [sp, #32]
	str	r4, [sp, #16]
	umlal	r10, lr, r2, r3
	ldr	r2, [sp, #92]
	str	r0, [sp, #76]
	umlal	r10, lr, r2, r4
	ldr	r2, [sp, #12]
	ldr	r4, [sp, #4]
	umlal	r10, lr, r0, r2
	ldr	r2, [sp, #52]
	ldr	r0, [sp, #56]
	umlal	r10, lr, r4, r2
	ldr	r4, [sp, #40]
	ldr	r1, [sp, #36]
	umlal	r10, lr, r6, r4
	ldr	r4, [sp, #36]
	ldr	r6, [sp, #8]
	ldr	r2, [sp]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	adds	r4, r0, r4
	adc	r0, ip, r9
	str	r0, [sp, #60]
	ldr	r0, [sp, #72]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r0
	ldrd	r8, [sp, #56]
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	str	r4, [r2, #12]
	umull	r4, ip, fp, r7
	ldrd	r2, r6, [sp, #44]
	ldr	r0, [sp, #108]
	lsrl	r8, r9, #25
	umlal	r4, ip, r5, r0
	ldr	r0, [sp, #84]
	umlal	r10, lr, r6, r2
	umlal	r4, ip, r0, r3
	ldr	r2, [sp, #32]
	ldr	r0, [sp, #16]
	ldr	r6, [sp, #64]
	umlal	r4, ip, r2, r0
	ldr	r0, [sp, #76]
	ldr	r2, [sp, #12]
	umlal	r4, ip, r6, r0
	ldr	r6, [sp, #4]
	lsls	r1, r1, #1
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #88]
	str	r10, [sp, #116]
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #8]
	ldr	r2, [sp, #40]
	umlal	r4, ip, r6, r2
	ldr	r2, [sp]
	ldr	r6, [sp, #72]
	umlal	r4, ip, r2, r1
	ldr	r2, [sp, #44]
	umlal	r4, ip, r6, r2
	adds	r8, r4, r8
	adc	ip, ip, r9
	str	r8, [sp, #56]
	str	ip, [sp, #60]
	ldrd	r10, [sp, #56]
	lsrl	r10, fp, #26
	ldr	r2, [sp, #80]
	bic	r8, r8, #-67108864
	strd	r10, [sp, #56]
	str	r8, [r2, #16]
	ldr	r4, [sp, #48]
	ldr	r2, [sp, #12]
	lsl	ip, r4, #1
	ldr	r4, [sp, #92]
	ldr	r6, [sp, #4]
	umull	fp, r10, r7, r4
	ldrd	r8, [sp, #56]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r5, r4
	umlal	fp, r10, r3, r2
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #52]
	umlal	fp, r10, r4, r2
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	fp, r10, r0, r4
	ldr	r4, [sp, #36]
	umlal	fp, r10, r6, r4
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #72]
	umlal	fp, r10, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #116]
	adds	r4, r6, r4
	ldr	r6, [sp, #48]
	str	r4, [sp, #56]
	umlal	fp, r10, r2, r6
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	ldr	r6, [sp, #104]
	str	r4, [r2, #20]
	ldr	r2, [sp]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r2, r6
	adc	lr, lr, r9
	ldr	r6, [sp, #68]
	ldr	r2, [sp, #44]
	str	lr, [sp, #60]
	umull	r4, lr, r4, r7
	ldrd	r8, [sp, #56]
	umlal	fp, r10, r6, r2
	ldr	r2, [sp, #84]
	lsrl	r8, r9, #25
	umlal	r4, lr, r5, r2
	ldr	r2, [sp, #64]
	str	r3, [sp, #32]
	umlal	r4, lr, r2, r3
	ldrd	r2, r3, [sp, #12]
	umlal	r4, lr, r3, r2
	str	fp, [sp, #76]
	ldr	r3, [sp, #88]
	ldr	r6, [sp, #4]
	umlal	r4, lr, r0, r3
	ldr	r3, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	r4, lr, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #72]
	umlal	r4, lr, r6, r1
	umlal	r4, lr, r2, r3
	ldr	r3, [sp]
	ldr	r2, [sp, #44]
	umlal	r4, lr, r3, ip
	ldr	r3, [sp, #104]
	strd	r8, [sp, #56]
	umlal	r4, lr, r3, r2
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, lr, r4
	str	r4, [sp, #28]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #80]
	ldr	r2, [sp, #52]
	bic	r8, r8, #-67108864
	str	r8, [r3, #24]
	ldr	r3, [sp, #68]
	umull	lr, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #12]
	ldr	r2, [sp, #64]
	umlal	lr, r8, r5, r3
	umull	r3, fp, r7, r3
	umlal	r3, fp, r5, r2
	ldr	r4, [sp, #32]
	ldr	r2, [sp, #88]
	ldr	r5, [sp, #40]
	umlal	r3, fp, r4, r2
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #8]
	umlal	r3, fp, r4, r5
	ldr	r5, [sp, #36]
	umlal	r3, fp, r0, r1
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #72]
	ldr	r1, [sp, #4]
	umlal	lr, r8, r0, r4
	umlal	r3, fp, r1, r4
	ldr	r4, [sp, #48]
	ldr	r0, [sp, #104]
	umlal	lr, r8, r1, r4
	umlal	r3, fp, r6, ip
	umlal	lr, r8, r6, r0
	umlal	r3, fp, r2, r0
	ldr	r6, [sp, #68]
	ldr	r0, [sp, #100]
	umlal	lr, r8, r2, r6
	ldr	r2, [sp]
	ldr	r6, [sp, #76]
	umlal	r3, fp, r2, r9
	mov	ip, r3
	umlal	lr, r8, r2, r0
	ldr	r2, [sp, #44]
	ldr	r5, [sp, #96]
	umlal	ip, fp, r0, r2
	ldrd	r0, [sp, #24]
	adds	r4, r6, r0
	umlal	lr, r8, r2, r5
	mov	r2, r4
	adc	r3, r10, r1
	lsrl	r2, r3, #25
	ldr	r7, [sp, #80]
	adds	ip, ip, r2
	bic	r4, r4, #-33554432
	str	r4, [r7, #28]
	mov	r4, ip
	adc	r5, fp, r3
	lsrl	r4, r5, #26
	adds	lr, lr, r4
	mov	r2, lr
	bic	r3, ip, #-67108864
	str	r3, [r7, #32]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r0, r2
	mov	r1, r3
	lsll	r0, r1, #3
	adds	r4, r0, r2
	adc	r5, r1, r3
	adds	r4, r4, r4
	adcs	r5, r5, r5
	adds	r4, r4, r2
	adc	r5, r5, r3
	ldr	r3, [sp, #120]
	ldr	r1, [sp, #112]
	adds	r4, r4, r3
	mov	r2, r4
	adc	r3, r5, #0
	lsrl	r2, r3, #26
	bic	r4, r4, #-67108864
	str	r4, [r7]
	ldr	r4, [sp, #124]
	bic	r6, lr, #-33554432
	adds	r3, r4, r2
	bic	r2, r3, #-33554432
	add	r1, r1, r3, lsr #25
	strd	r2, r1, [r7, #4]
	str	r6, [r7, #36]
	add	sp, sp, #132
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
	.size	fiat_mul_ref, .-fiat_mul_ref
	.ident	"GCC: (Arm GNU Toolchain 13.2.rel1 (Build arm-13.7)) 13.2.1 20231009"
