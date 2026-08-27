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
	.global	fiat_mul_yield3
	.syntax unified
	.thumb
	.thumb_func
	.type	fiat_mul_yield3, %function
fiat_mul_yield3:
	@ args = 0, pretend = 0, frame = 144
	@ frame_needed = 0, uses_anonymous_args = 0
	push	{r4, r5, r6, r7, r8, r9, lr}
	mov	r3, r2
	mov	r4, r1
	sub	sp, sp, #148
	ldr	r7, [r4, #32]
	str	r4, [sp, #16]
	ldr	r4, [r3, #12]
	mov	lr, #38
	mov	r6, r4
	ldr	r2, [r1, #36]
	ldr	r1, [r3, #8]
	ldr	r5, [r3, #4]
	add	r4, r4, r4, lsl #3
	str	r0, [sp, #40]
	add	r4, r6, r4, lsl #1
	add	r0, r1, r1, lsl #3
	str	r7, [sp, #4]
	str	r1, [sp, #24]
	add	r0, r1, r0, lsl #1
	str	r5, [sp, #52]
	mul	r1, lr, r5
	umull	r4, r5, r4, r7
	mov	r7, r2
	umlal	r4, r5, r2, r0
	ldr	r2, [sp, #4]
	str	r3, [sp]
	umull	r0, r2, r0, r2
	ldr	r3, [r3, #16]
	umlal	r0, r2, r7, r1
	add	r1, r3, r3, lsl #3
	mul	r9, lr, r6
	add	r1, r3, r1, lsl #1
	str	r3, [sp, #20]
	str	r6, [sp, #48]
	ldr	r3, [sp]
	ldr	r6, [sp, #16]
	str	r7, [sp, #8]
	ldr	r7, [r3, #20]
	ldr	r3, [r6, #28]
	str	r7, [sp, #76]
	umlal	r4, r5, r1, r3
	mov	r6, r4
	add	r4, r7, r7, lsl #3
	add	r8, r7, r4, lsl #1
	ldr	r4, [sp]
	umlal	r0, r2, r9, r3
	ldr	r4, [r4, #24]
	str	r8, [sp, #28]
	str	r4, [sp, #44]
	mul	r4, lr, r7
	ldr	r7, [sp, #44]
	str	r4, [sp, #36]
	ldr	r4, [sp, #16]
	add	r8, r7, r7, lsl #3
	add	lr, r7, r8, lsl #1
	ldr	r7, [r4, #24]
	umlal	r0, r2, r1, r7
	str	r0, [sp, #32]
	mov	r0, r6
	str	r2, [sp, #56]
	str	r7, [sp, #12]
	ldr	r2, [sp, #28]
	umlal	r0, r5, r2, r7
	mov	r6, r0
	ldr	r0, [sp, #4]
	ldr	r7, [sp, #12]
	umull	r8, r4, r0, r2
	ldr	r2, [sp, #8]
	umlal	r8, r4, r2, r1
	umull	r1, r0, r1, r0
	umlal	r1, r0, r2, r9
	ldr	r2, [sp, #36]
	umlal	r8, r4, lr, r3
	umlal	r1, r0, r2, r3
	mov	r9, r1
	mov	r1, r0
	umlal	r9, r1, lr, r7
	ldr	r2, [sp]
	str	r1, [sp, #28]
	ldrd	r1, r2, [r2, #28]
	str	r2, [sp, #64]
	mov	r2, r1
	add	r1, r1, r1, lsl #3
	add	r1, r2, r1, lsl #1
	umlal	r8, r4, r1, r7
	ldr	r7, [sp, #16]
	ldr	r0, [sp, #36]
	ldr	r7, [r7, #20]
	str	r4, [sp, #84]
	umlal	r6, r5, lr, r7
	str	r5, [sp, #88]
	movs	r5, #38
	ldr	r4, [sp, #32]
	str	r8, [sp, #60]
	ldr	r8, [sp, #56]
	str	r2, [sp, #68]
	umlal	r4, r8, r0, r7
	str	r4, [sp, #56]
	ldr	r4, [sp, #68]
	str	r8, [sp, #80]
	mul	r8, r5, r4
	ldr	r0, [sp, #28]
	ldr	r4, [sp, #84]
	umlal	r9, r0, r8, r7
	str	r0, [sp, #100]
	ldr	r0, [sp, #64]
	str	r8, [sp, #72]
	add	r2, r0, r0, lsl #3
	add	r2, r0, r2, lsl #1
	ldr	r0, [sp, #60]
	str	r7, [sp, #32]
	umlal	r0, r4, r2, r7
	str	r4, [sp, #104]
	ldr	r4, [sp]
	mov	r8, r0
	ldr	r0, [r4, #36]
	ldr	r7, [r4]
	mul	r5, r5, r0
	ldr	r4, [sp, #16]
	str	r0, [sp, #60]
	ldr	r4, [r4, #16]
	ldr	r0, [sp, #56]
	str	r5, [sp, #28]
	ldr	r5, [sp, #80]
	str	r7, [sp]
	umlal	r0, r5, lr, r4
	str	r5, [sp, #84]
	ldr	r5, [sp, #88]
	str	r0, [sp, #56]
	umlal	r6, r5, r1, r4
	ldr	r0, [sp, #4]
	str	r5, [sp, #96]
	umull	r7, r1, r0, r1
	ldr	r5, [sp, #100]
	str	r6, [sp, #92]
	ldr	r6, [sp, #8]
	umlal	r9, r5, r2, r4
	umlal	r7, r1, r6, lr
	str	r5, [sp, #100]
	mov	r5, r7
	umlal	r5, r1, r2, r3
	str	r5, [sp, #88]
	mov	r5, r6
	umull	r7, lr, lr, r0
	ldr	r6, [sp, #36]
	str	r3, [sp, #80]
	umlal	r7, lr, r5, r6
	ldr	r6, [sp, #72]
	ldr	r5, [sp, #12]
	umlal	r7, lr, r6, r3
	ldrd	r6, r3, [sp, #28]
	umlal	r7, lr, r2, r5
	umlal	r7, lr, r6, r3
	mov	r0, r7
	ldr	r7, [sp]
	str	r4, [sp, #36]
	umlal	r0, lr, r4, r7
	str	r0, [sp, #112]
	ldr	r0, [sp, #60]
	str	lr, [sp, #116]
	add	r7, r0, r0, lsl #3
	add	lr, r0, r7, lsl #1
	ldr	r7, [sp, #88]
	ldr	r6, [sp, #36]
	umlal	r7, r1, lr, r5
	ldr	r5, [sp, #104]
	umlal	r8, r5, lr, r6
	mov	r4, r5
	ldr	r5, [sp]
	ldr	r0, [sp, #56]
	umlal	r7, r1, r3, r5
	mov	r5, r6
	ldr	r6, [sp, #52]
	ldr	r3, [sp, #16]
	umlal	r7, r1, r5, r6
	ldr	r6, [r3, #12]
	ldr	r5, [sp, #84]
	str	r1, [sp, #108]
	ldr	r1, [sp, #72]
	ldr	r3, [sp]
	umlal	r0, r5, r1, r6
	strd	r0, r5, [sp, #84]
	ldr	r0, [sp, #92]
	ldr	r5, [sp, #96]
	ldr	r1, [sp, #100]
	umlal	r0, r5, r2, r6
	str	r0, [sp, #92]
	ldr	r0, [sp, #28]
	umlal	r8, r4, r6, r3
	umlal	r9, r1, r0, r6
	mov	r0, r1
	ldr	r3, [sp, #24]
	ldr	r1, [sp, #108]
	str	r8, [sp, #104]
	umlal	r7, r1, r6, r3
	ldr	r3, [sp, #16]
	str	r6, [sp, #56]
	ldr	r8, [r3, #8]
	ldrd	r6, r3, [sp, #84]
	umlal	r6, r3, r2, r8
	strd	r6, r3, [sp, #84]
	ldr	r6, [sp, #92]
	ldr	r3, [sp]
	umlal	r6, r5, lr, r8
	str	r6, [sp, #92]
	mov	r6, r0
	umlal	r9, r6, r8, r3
	str	r9, [sp, #96]
	mov	r9, r7
	str	r6, [sp, #100]
	ldr	r6, [sp, #104]
	ldr	r0, [sp, #52]
	ldr	r7, [sp, #8]
	umlal	r6, r4, r8, r0
	str	r6, [sp, #104]
	ldr	r6, [sp, #48]
	umlal	r9, r1, r8, r6
	str	r1, [sp, #120]
	ldr	r1, [sp, #4]
	str	r9, [sp, #108]
	umull	r0, lr, r1, lr
	umlal	r0, lr, r7, r2
	ldr	r7, [sp, #80]
	umlal	r0, lr, r7, r3
	ldr	r7, [sp, #12]
	ldr	r3, [sp, #52]
	umlal	r0, lr, r7, r3
	ldr	r7, [sp, #32]
	ldr	r3, [sp, #24]
	umlal	r0, lr, r7, r3
	ldr	r7, [sp, #36]
	ldr	r3, [sp, #80]
	umlal	r0, lr, r7, r6
	ldr	r6, [sp, #56]
	ldr	r7, [sp, #20]
	umlal	r0, lr, r6, r7
	mov	r9, r0
	ldr	r0, [sp, #76]
	ldr	r6, [sp, #72]
	umlal	r9, lr, r8, r0
	umull	r7, r0, r2, r1
	ldr	r2, [sp, #8]
	str	r9, [sp, #136]
	umlal	r7, r0, r2, r6
	ldr	r6, [sp, #28]
	ldr	r2, [sp]
	umlal	r7, r0, r6, r3
	ldr	r3, [sp, #12]
	umlal	r7, r0, r3, r2
	ldr	r3, [sp, #16]
	strd	r7, r0, [sp, #128]
	ldr	r1, [r3, #4]
	ldr	r9, [r3]
	mov	r7, r1
	ldrd	r3, r0, [sp, #84]
	umlal	r3, r0, r6, r1
	mov	r1, r0
	mov	r0, r3
	ldr	r3, [sp, #92]
	umlal	r3, r5, r7, r2
	mov	r2, r7
	str	r3, [sp, #88]
	ldr	r6, [sp, #104]
	ldr	r3, [sp, #24]
	str	r2, [sp, #16]
	umlal	r6, r4, r7, r3
	ldr	r3, [sp, #20]
	str	r6, [sp, #104]
	ldr	r7, [sp, #120]
	ldr	r6, [sp, #108]
	umlal	r6, r7, r2, r3
	ldr	r3, [sp]
	ldr	r2, [sp, #16]
	umlal	r0, r1, r3, r9
	str	r1, [sp, #84]
	mov	r1, r5
	ldr	r3, [sp, #88]
	str	r0, [sp, #72]
	ldr	r0, [sp, #52]
	ldr	r5, [sp, #48]
	umlal	r3, r1, r0, r9
	str	r1, [sp, #92]
	ldr	r1, [sp, #104]
	str	r3, [sp, #88]
	umlal	r1, r4, r5, r9
	strd	r1, r4, [sp, #104]
	mov	r4, r6
	mov	r1, r7
	ldr	r5, [sp, #76]
	lsls	r3, r0, #1
	umlal	r4, r1, r5, r9
	str	r1, [sp, #124]
	str	r4, [sp, #120]
	ldr	r1, [sp, #136]
	ldr	r4, [sp, #44]
	ldr	r5, [sp, #68]
	umlal	r1, lr, r2, r4
	umlal	r1, lr, r5, r9
	ldr	r4, [sp, #32]
	strd	r1, lr, [sp, #136]
	mov	r6, r0
	ldr	r1, [sp, #128]
	ldr	r0, [sp, #132]
	umlal	r1, r0, r4, r3
	str	r0, [sp, #128]
	mov	r0, r3
	ldrd	r5, r7, [sp, #112]
	mov	lr, r1
	ldr	r4, [sp, #56]
	ldr	r1, [sp, #36]
	umlal	r5, r7, r4, r3
	ldrd	r3, r4, [sp, #96]
	str	r0, [sp, #52]
	umlal	r3, r4, r2, r0
	ldr	r2, [sp, #24]
	ldr	r0, [sp, #128]
	str	r4, [sp, #96]
	umlal	lr, r0, r1, r2
	str	lr, [sp, #116]
	mov	lr, r5
	umlal	lr, r7, r8, r2
	str	lr, [sp, #112]
	mov	lr, r3
	ldr	r5, [sp, #96]
	ldr	r3, [sp]
	umlal	lr, r5, r2, r9
	str	r5, [sp, #100]
	mov	r5, r6
	ldr	r6, [sp, #4]
	ldr	r2, [sp, #8]
	umull	r4, r5, r6, r5
	umlal	r4, r5, r2, r3
	umull	r3, r1, r6, r3
	ldr	r6, [sp, #28]
	str	lr, [sp, #96]
	umlal	r3, r1, r2, r6
	ldr	r6, [sp, #80]
	ldr	r2, [sp, #52]
	umlal	r3, r1, r6, r2
	ldr	r2, [sp, #24]
	umlal	r4, r5, r6, r2
	ldr	r6, [sp, #12]
	umlal	r3, r1, r6, r2
	ldr	r2, [sp, #48]
	lsl	lr, r2, #1
	umlal	r4, r5, r6, r2
	ldr	r6, [sp, #56]
	ldr	r2, [sp, #116]
	umlal	r2, r0, r6, lr
	mov	r6, r2
	ldr	r2, [sp, #32]
	umlal	r3, r1, r2, lr
	str	r3, [sp]
	ldr	r3, [sp, #20]
	umlal	r4, r5, r2, r3
	ldr	r2, [sp, #16]
	ldr	r3, [sp, #112]
	umlal	r3, r7, r2, lr
	mov	r2, r6
	mov	lr, r3
	ldr	r3, [sp, #20]
	umlal	r2, r0, r8, r3
	str	r2, [sp, #8]
	ldr	r2, [sp, #36]
	ldr	r6, [sp]
	umlal	r6, r1, r2, r3
	str	r1, [sp, #12]
	mov	r1, lr
	mov	r3, r6
	ldr	r6, [sp, #76]
	umlal	r4, r5, r2, r6
	ldr	r2, [sp, #20]
	lsl	lr, r6, #1
	umlal	r1, r7, r2, r9
	strd	r1, r7, [sp]
	mov	r7, r3
	ldr	r6, [sp, #8]
	ldr	r3, [sp, #16]
	ldr	r2, [sp, #56]
	umlal	r6, r0, r3, lr
	ldr	r1, [sp, #12]
	ldr	r3, [sp, #44]
	umlal	r7, r1, r2, lr
	umlal	r4, r5, r2, r3
	mov	lr, r6
	mov	r2, r3
	umlal	r7, r1, r8, r3
	umlal	lr, r0, r2, r9
	mov	r3, r7
	ldr	r2, [sp, #68]
	ldr	r7, [sp, #16]
	umlal	r4, r5, r8, r2
	lsls	r6, r2, #1
	ldr	r2, [sp, #64]
	str	lr, [sp, #8]
	umlal	r4, r5, r7, r2
	mov	lr, r4
	umlal	r3, r1, r7, r6
	umlal	r3, r1, r2, r9
	ldr	r4, [sp, #72]
	str	r3, [sp, #12]
	ldr	r3, [sp, #60]
	ldr	r6, [sp, #84]
	umlal	lr, r5, r9, r3
	ldr	r2, [sp, #88]
	lsrs	r3, r4, #26
	orr	r3, r3, r6, lsl #6
	adds	r3, r2, r3
	ldr	r2, [sp, #92]
	bic	r9, r4, #-67108864
	adc	r2, r2, r6, lsr #26
	lsrs	r4, r3, #25
	ldr	r6, [sp, #96]
	orr	r4, r4, r2, lsl #7
	adds	r4, r6, r4
	ldr	r6, [sp, #100]
	str	lr, [sp, #16]
	adc	r2, r6, r2, lsr #25
	lsr	lr, r4, #26
	ldr	r6, [sp, #104]
	orr	lr, lr, r2, lsl #6
	adds	lr, r6, lr
	ldr	r6, [sp, #108]
	lsr	r8, lr, #25
	adc	r2, r6, r2, lsr #26
	ldr	r6, [sp]
	orr	r8, r8, r2, lsl #7
	adds	r8, r6, r8
	ldr	r6, [sp, #4]
	bic	r7, lr, #-33554432
	adc	r2, r6, r2, lsr #25
	ldr	r6, [sp, #40]
	bic	r3, r3, #-33554432
	str	r7, [r6, #12]
	ldr	r6, [sp, #120]
	lsr	r7, r8, #26
	orr	r7, r7, r2, lsl #6
	adds	r7, r6, r7
	ldr	r6, [sp, #124]
	bic	r8, r8, #-67108864
	adc	r2, r6, r2, lsr #26
	ldr	r6, [sp, #40]
	lsr	lr, r7, #25
	str	r8, [r6, #16]
	ldr	r6, [sp, #8]
	orr	lr, lr, r2, lsl #7
	adds	lr, r6, lr
	ldr	r6, [sp, #40]
	bic	r7, r7, #-33554432
	adc	r2, r0, r2, lsr #25
	str	r7, [r6, #20]
	lsr	r0, lr, #26
	ldr	r7, [sp, #136]
	orr	r0, r0, r2, lsl #6
	adds	r0, r7, r0
	ldr	r7, [sp, #140]
	bic	r4, r4, #-67108864
	adc	r2, r7, r2, lsr #26
	bic	r7, lr, #-67108864
	str	r7, [r6, #24]
	ldr	r6, [sp, #12]
	lsrs	r7, r0, #25
	orr	r7, r7, r2, lsl #7
	adds	r7, r6, r7
	ldr	r6, [sp, #40]
	bic	r0, r0, #-33554432
	adc	r2, r1, r2, lsr #25
	str	r0, [r6, #28]
	lsrs	r1, r7, #26
	ldr	r0, [sp, #16]
	orr	r1, r1, r2, lsl #6
	adds	r1, r0, r1
	adc	r5, r5, r2, lsr #26
	lsrs	r0, r1, #25
	orr	r0, r0, r5, lsl #7
	bic	r1, r1, #-33554432
	lsrs	r5, r5, #25
	str	r1, [r6, #36]
	lsls	r2, r0, #3
	lsls	r1, r5, #3
	adds	r2, r2, r0
	orr	r1, r1, r0, lsr #29
	adc	r1, r5, r1
	adds	r2, r2, r2
	adcs	r1, r1, r1
	adds	r2, r2, r0
	adc	r5, r5, r1
	adds	r2, r2, r9
	adc	r5, r5, #0
	lsrs	r1, r2, #26
	orr	r1, r1, r5, lsl #6
	add	r3, r3, r1
	add	r4, r4, r3, lsr #25
	bic	r7, r7, #-67108864
	bic	r2, r2, #-67108864
	bic	r3, r3, #-33554432
	strd	r2, r3, [r6]
	str	r7, [r6, #32]
	str	r4, [r6, #8]
	add	sp, sp, #148
	@ sp needed
	pop	{r4, r5, r6, r7, r8, r9, pc}
	.size	fiat_mul_yield3, .-fiat_mul_yield3
	.ident	"GCC: (Arm GNU Toolchain 13.2.rel1 (Build arm-13.7)) 13.2.1 20231009"
