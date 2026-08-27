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
	@ args = 0, pretend = 0, frame = 176
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, r10, fp, lr}
	mov	lr, #38
	ldr	r6, [r2, #12]
	sub	sp, sp, #180
	str	r0, [sp, #120]
	mul	r0, lr, r6
	ldr	r7, [r2, #32]
	str	r0, [sp, #104]
	str	r7, [sp, #92]
	ldr	r0, [r2, #16]
	ldr	r7, [r1, #24]
	ldr	r5, [r1, #36]
	str	r7, [sp, #28]
	mov	r7, r0
	ldr	r4, [r2, #8]
	str	r5, [sp, #84]
	mov	r5, r4
	str	r6, [sp, #40]
	ldr	r6, [r2, #20]
	ldr	r3, [r1, #32]
	mul	ip, lr, r6
	str	r6, [sp, #48]
	ldr	r6, [r1, #16]
	str	ip, [sp, #100]
	str	r6, [sp, #8]
	ldr	r6, [r2, #28]
	add	r0, r0, r0, lsl #3
	mul	ip, lr, r6
	add	r10, r7, r0, lsl #1
	str	r7, [sp, #72]
	ldr	r0, [r2, #24]
	ldr	r7, [r1, #20]
	str	r3, [sp, #4]
	ldr	r3, [r2, #4]
	str	r7, [sp, #56]
	add	r4, r4, r4, lsl #3
	add	r7, r0, r0, lsl #3
	add	fp, r0, r7, lsl #1
	str	r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #52]
	mul	r5, lr, r3
	str	ip, [sp, #76]
	ldr	r3, [r1, #28]
	str	r0, [sp, #96]
	str	r6, [sp, #68]
	ldrd	r6, r0, [r1, #8]
	ldr	r7, [r2, #36]
	ldr	r2, [r2]
	mul	ip, lr, r7
	str	r7, [sp, #88]
	ldr	r7, [sp, #92]
	str	r2, [sp, #16]
	add	r2, r7, r7, lsl #3
	str	ip, [sp, #64]
	add	ip, r7, r2, lsl #1
	str	ip, [sp, #32]
	ldr	r2, [r1, #4]
	ldr	ip, [r1]
	ldr	r1, [sp, #40]
	str	r2, [sp, #24]
	add	lr, r1, r1, lsl #3
	ldr	r2, [sp, #4]
	add	lr, r1, lr, lsl #1
	umull	lr, r1, lr, r2
	ldr	r7, [sp, #84]
	ldr	r2, [sp, #4]
	umlal	lr, r1, r7, r4
	umull	r4, r2, r4, r2
	umlal	r4, r2, r7, r5
	mov	r8, r4
	ldr	r5, [sp, #104]
	mov	r9, r1
	umlal	r8, r2, r5, r3
	ldr	r4, [sp, #28]
	ldr	r7, [sp, #56]
	umlal	r8, r2, r10, r4
	ldr	r1, [sp, #100]
	ldr	r5, [sp, #8]
	umlal	r8, r2, r1, r7
	umlal	r8, r2, fp, r5
	ldr	r1, [sp, #76]
	str	r6, [sp, #12]
	umlal	r8, r2, r1, r0
	ldr	r6, [sp, #32]
	ldr	r1, [sp, #12]
	umlal	lr, r9, r10, r3
	umlal	r8, r2, r6, r1
	ldr	r1, [sp, #64]
	ldr	r6, [sp, #24]
	umlal	r8, r2, r1, r6
	ldr	r6, [sp, #16]
	umlal	r8, r2, r6, ip
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	str	r8, [sp, #124]
	str	r2, [sp, #60]
	ldr	r6, [sp, #48]
	add	r2, r6, r6, lsl #3
	add	r2, r6, r2, lsl #1
	umlal	lr, r9, r2, r4
	mov	r1, r9
	ldr	r4, [sp, #68]
	umlal	lr, r1, fp, r7
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	str	r8, [sp, #116]
	umlal	lr, r1, r8, r5
	ldrd	r8, [sp, #56]
	lsrl	r8, r9, #26
	ldr	r5, [sp, #32]
	strd	r8, [sp, #56]
	umlal	lr, r1, r5, r0
	ldr	r5, [sp, #88]
	ldr	r6, [sp, #12]
	add	r8, r5, r5, lsl #3
	add	r8, r5, r8, lsl #1
	umlal	lr, r1, r8, r6
	ldr	r5, [sp, #24]
	ldr	r6, [sp, #16]
	ldr	r4, [sp, #52]
	umlal	lr, r1, r5, r6
	umlal	lr, r1, r4, ip
	lsls	r5, r4, #1
	ldr	r4, [sp, #56]
	ldr	r6, [sp, #60]
	adds	r4, lr, r4
	adc	r9, r1, r6
	ldr	r1, [sp, #4]
	str	r5, [sp, #80]
	umull	r2, r1, r1, r2
	ldr	r5, [sp, #84]
	str	r8, [sp, #112]
	umlal	r2, r1, r5, r10
	umlal	r2, r1, fp, r3
	bic	lr, r4, #-33554432
	str	r3, [sp, #56]
	mov	r8, r4
	ldr	r3, [sp, #116]
	ldr	r4, [sp, #28]
	ldr	r6, [sp, #32]
	umlal	r2, r1, r3, r4
	umlal	r2, r1, r6, r7
	ldr	r3, [sp, #112]
	ldr	r6, [sp, #8]
	str	lr, [sp, #128]
	umlal	r2, r1, r3, r6
	ldr	r6, [sp, #16]
	ldr	r3, [sp, #12]
	umlal	r2, r1, r0, r6
	ldr	r6, [sp, #52]
	lsrl	r8, r9, #25
	umlal	r2, r1, r3, r6
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #44]
	umlal	r2, r1, r6, r3
	mov	lr, r2
	ldr	r2, [sp, #40]
	umlal	lr, r1, r2, ip
	str	lr, [sp, #136]
	str	r1, [sp, #140]
	ldr	r1, [sp, #4]
	ldr	r3, [sp, #104]
	umull	lr, r2, r10, r1
	umlal	lr, r2, r5, r3
	ldr	r1, [sp, #100]
	ldr	r3, [sp, #56]
	ldr	r6, [sp, #8]
	umlal	lr, r2, r1, r3
	umlal	lr, r2, fp, r4
	ldr	r1, [sp, #76]
	umlal	lr, r2, r1, r7
	ldr	r1, [sp, #32]
	umlal	lr, r2, r1, r6
	ldrd	r3, r6, [sp, #12]
	ldr	r1, [sp, #64]
	umlal	lr, r2, r1, r0
	umlal	lr, r2, r3, r6
	ldr	r1, [sp, #24]
	ldr	r3, [sp, #80]
	umlal	lr, r2, r1, r3
	ldr	r3, [sp, #44]
	umlal	lr, r2, r3, ip
	adds	lr, lr, r8
	adc	r2, r2, r9
	str	lr, [sp, #16]
	str	r2, [sp, #20]
	ldrd	r8, [sp, #16]
	lsrl	r8, r9, #26
	ldr	r2, [sp, #40]
	ldr	r3, [sp, #116]
	lsls	r1, r2, #1
	str	r1, [sp, #84]
	ldr	r1, [sp, #4]
	bic	lr, lr, #-67108864
	str	lr, [sp, #132]
	umull	r10, lr, r1, r3
	umlal	r10, lr, r5, fp
	ldr	r3, [sp, #56]
	ldr	r1, [sp, #32]
	str	r7, [sp, #56]
	umlal	r10, lr, r1, r3
	ldr	r1, [sp, #112]
	str	r6, [sp, #16]
	umlal	r10, lr, r1, r4
	umlal	r10, lr, r7, r6
	ldr	r4, [sp, #8]
	ldr	r1, [sp, #52]
	ldr	r7, [sp, #44]
	umlal	r10, lr, r4, r1
	mov	r4, r8
	umlal	r10, lr, r0, r7
	ldr	r6, [sp, #12]
	umlal	r10, lr, r6, r2
	ldr	r2, [sp, #136]
	ldr	r7, [sp, #140]
	adds	r4, r2, r4
	mov	r2, r9
	adc	r2, r7, r2
	ldr	r1, [sp, #24]
	str	r2, [sp, #108]
	ldr	r2, [sp, #72]
	str	r4, [sp, #104]
	umlal	r10, lr, r1, r2
	ldrd	r8, [sp, #104]
	bic	r4, r4, #-33554432
	ldr	r1, [sp, #48]
	str	r4, [sp, #172]
	ldr	r4, [sp, #4]
	umlal	r10, lr, r1, ip
	lsrl	r8, r9, #25
	umull	r4, r1, fp, r4
	ldr	r2, [sp, #100]
	ldr	r6, [sp, #76]
	umlal	r4, r1, r5, r2
	umlal	r4, r1, r6, r3
	ldrd	r7, r6, [sp, #28]
	umlal	r4, r1, r6, r7
	ldr	r2, [sp, #64]
	ldr	r7, [sp, #56]
	ldr	r6, [sp, #8]
	umlal	r4, r1, r2, r7
	ldr	r2, [sp, #16]
	str	r10, [sp, #104]
	umlal	r4, r1, r6, r2
	ldr	r6, [sp, #80]
	ldr	r2, [sp, #12]
	umlal	r4, r1, r0, r6
	ldr	r6, [sp, #44]
	umlal	r4, r1, r2, r6
	ldr	r2, [sp, #24]
	ldr	r6, [sp, #84]
	umlal	r4, r1, r2, r6
	mov	r2, r9
	ldr	r6, [sp, #72]
	umlal	r4, r1, r6, ip
	adds	r8, r4, r8
	adc	r1, r1, r2
	str	r8, [sp, #56]
	str	r1, [sp, #60]
	ldrd	r10, [sp, #56]
	lsrl	r10, fp, #26
	bic	r1, r8, #-67108864
	ldr	r4, [sp, #112]
	strd	r10, [sp, #56]
	str	r1, [sp, #144]
	ldr	r1, [sp, #48]
	ldr	r6, [sp, #4]
	ldr	r2, [sp, #16]
	umull	fp, r10, r6, r4
	ldrd	r8, [sp, #56]
	ldr	r4, [sp, #32]
	ldr	r6, [sp, #52]
	umlal	fp, r10, r5, r4
	umlal	fp, r10, r3, r2
	ldr	r4, [sp, #28]
	ldr	r2, [sp, #44]
	umlal	fp, r10, r4, r6
	umlal	fp, r10, r7, r2
	mov	r2, r8
	ldr	r6, [sp, #8]
	ldr	r4, [sp, #40]
	lsls	r1, r1, #1
	umlal	fp, r10, r6, r4
	ldr	r6, [sp, #72]
	ldr	r4, [sp, #104]
	umlal	fp, r10, r0, r6
	adds	r4, r4, r2
	ldr	r6, [sp, #12]
	ldr	r2, [sp, #48]
	str	r4, [sp, #56]
	umlal	fp, r10, r6, r2
	bic	r4, r4, #-33554432
	ldr	r6, [sp, #96]
	str	r4, [sp, #148]
	ldr	r4, [sp, #24]
	ldr	r2, [sp, #32]
	umlal	fp, r10, r4, r6
	ldr	r4, [sp, #68]
	adc	lr, lr, r9
	umlal	fp, r10, r4, ip
	ldr	r4, [sp, #4]
	str	lr, [sp, #60]
	umull	r4, lr, r2, r4
	ldrd	r8, [sp, #56]
	ldr	r6, [sp, #76]
	ldr	r2, [sp, #64]
	umlal	r4, lr, r5, r6
	lsrl	r8, r9, #25
	umlal	r4, lr, r2, r3
	str	r3, [sp, #56]
	ldr	r2, [sp, #16]
	ldr	r3, [sp, #28]
	ldr	r6, [sp, #8]
	umlal	r4, lr, r3, r2
	ldr	r3, [sp, #80]
	str	fp, [sp, #100]
	umlal	r4, lr, r7, r3
	ldr	r3, [sp, #44]
	umlal	r4, lr, r6, r3
	ldr	r3, [sp, #84]
	ldr	r6, [sp, #72]
	umlal	r4, lr, r0, r3
	ldr	r2, [sp, #12]
	ldr	r3, [sp, #96]
	umlal	r4, lr, r2, r6
	ldr	r2, [sp, #24]
	ldr	r6, [sp, #16]
	umlal	r4, lr, r2, r1
	umlal	r4, lr, r3, ip
	adds	r8, r4, r8
	adc	lr, lr, r9
	str	r8, [sp, #32]
	str	lr, [sp, #36]
	ldrd	r2, [sp, #32]
	lsrl	r2, r3, #26
	strd	r2, [sp, #32]
	ldr	r3, [sp, #68]
	ldr	r4, [sp, #4]
	lsl	r9, r3, #1
	ldr	r3, [sp, #52]
	bic	r8, r8, #-67108864
	str	r8, [sp, #152]
	umull	lr, r8, r4, r3
	umull	r3, fp, r4, r6
	ldr	r2, [sp, #64]
	ldr	r4, [sp, #56]
	umlal	r3, fp, r5, r2
	umlal	lr, r8, r5, r6
	ldr	r6, [sp, #80]
	ldr	r5, [sp, #44]
	umlal	r3, fp, r4, r6
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #28]
	ldr	r2, [sp, #8]
	umlal	r3, fp, r4, r5
	ldr	r5, [sp, #40]
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #84]
	ldr	r5, [sp, #72]
	umlal	r3, fp, r7, r4
	umlal	lr, r8, r7, r5
	umlal	r3, fp, r2, r5
	ldr	r5, [sp, #48]
	umlal	r3, fp, r0, r1
	umlal	lr, r8, r2, r5
	ldr	r1, [sp, #96]
	ldr	r2, [sp, #12]
	umlal	lr, r8, r0, r1
	umlal	r3, fp, r2, r1
	ldr	r1, [sp, #68]
	ldr	r4, [sp, #24]
	umlal	lr, r8, r2, r1
	ldr	r2, [sp, #92]
	ldr	r5, [sp, #88]
	umlal	lr, r8, r4, r2
	umlal	lr, r8, ip, r5
	ldr	r5, [sp, #100]
	umlal	r3, fp, r4, r9
	ldrd	r6, [sp, #32]
	adds	r4, r5, r6
	mov	r0, r4
	adc	r1, r10, r7
	lsrl	r0, r1, #25
	umlal	r3, fp, r2, ip
	bic	r4, r4, #-33554432
	adds	r3, r3, r0
	str	r4, [sp, #156]
	mov	r4, r3
	adc	r5, fp, r1
	lsrl	r4, r5, #26
	adds	lr, lr, r4
	mov	r0, lr
	adc	r1, r8, r5
	lsrl	r0, r1, #25
	mov	r8, r0
	mov	r9, r1
	lsll	r8, r9, #3
	adds	r4, r8, r0
	adc	r5, r9, r1
	adds	r4, r4, r4
	adcs	r5, r5, r5
	adds	r4, r4, r0
	adc	r5, r5, r1
	ldr	r1, [sp, #124]
	ldr	ip, [sp, #120]
	adds	r4, r4, r1
	mov	r0, r4
	adc	r1, r5, #0
	lsrl	r0, r1, #26
	bic	r4, r4, #-67108864
	str	r4, [sp, #160]
	ldr	r4, [sp, #128]
	mov	r6, ip
	adds	r1, r4, r0
	ldr	r0, [sp, #132]
	vldrw.32	q3, [sp, #144]
	add	r2, r0, r1, lsr #25
	bic	r1, r1, #-33554432
	str	r2, [sp, #168]
	str	r1, [sp, #164]
	vldrw.32	q2, [sp, #160]
	vstrw.32	q2, [r6], #16
	bic	r3, r3, #-67108864
	bic	r7, lr, #-33554432
	vstrw.32	q3, [r6]
	strd	r3, r7, [ip, #32]
	add	sp, sp, #180
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, r10, fp, pc}
	.size	fiat_mul_ref, .-fiat_mul_ref
	.ident	"GCC: (Arm GNU Toolchain 13.2.rel1 (Build arm-13.7)) 13.2.1 20231009"
