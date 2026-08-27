.section .itcm_code_from_flash, "ax", %progbits
.syntax unified
.thumb

// bfull_seq: counter=[r12,#240]
.global bfull_seq
.type bfull_seq, %function
.thumb_func
.balign 16
bfull_seq:
	push {r4-r11, lr}
	movw r8, #:lower16:g_theta_state
	movt r8, #:upper16:g_theta_state
	movw r12, #:lower16:g_spill
	movt r12, #:upper16:g_spill
	str r0, [r12, #240]
.balign 16
1:
	movw r0, #:lower16:g_bf_r
	movt r0, #:upper16:g_bf_r
	movw r1, #:lower16:g_bf_a
	movt r1, #:upper16:g_bf_a
	movw r2, #:lower16:g_bf_b
	movt r2, #:upper16:g_bf_b
	mov	r5, r0
	mov	r11, #0
	ldr	r0, [r1, #0]
	ldr	r3, [r2, #0]
	umull	r0, r3, r0, r3
	str	r0, [r5, #0]
	ldr	r0, [r1, #0]
	ldr	r6, [r2, #4]
	ldr	r4, [r1, #4]
	umull	r0, r6, r0, r6
	adds	r3, r3, r0
	ldr	r0, [r2, #0]
	adc	lr, r11, r11
	umull	r4, r0, r4, r0
	adds	r3, r3, r4
	str	r3, [r5, #4]
	ldr	r4, [r1, #0]
	ldr	r3, [r2, #8]
	str r5, [r12, #0]
	adc	lr, lr, #0
	ldr	r5, [r2, #4]
	adds	r6, r6, r0
	ldr	r0, [r1, #4]
	ldr	r7, [r1, #8]
	umull	r10, r9, r0, r5
	umull	r4, r3, r4, r3
	ldr	r5, [r2, #0]
	adc	r0, r11, r11
	umull	r7, r5, r7, r5
	adds	r4, r6, r4
	adc	r0, r0, #0
	adds	r4, r4, r10
	ldr r6, [r12, #0]
	adc	r0, r0, #0
	adds	r4, r4, r7
	adc	r0, r0, #0
	adds	r4, r4, lr
	str	r4, [r6, #8]
	ldr	r6, [r2, #12]
	ldr	r4, [r1, #0]
	adc	r0, r0, #0
	umull	r4, r7, r4, r6
	str r0, [r12, #4]
	ldr	r6, [r2, #8]
	ldr	r0, [r1, #4]
	adds	r3, r3, r9
	umull	r6, lr, r0, r6
	str r3, [r12, #8]
	ldr	r0, [r1, #8]
	ldr	r3, [r2, #4]
	umull	r9, r3, r0, r3
	ldr	r0, [r1, #12]
	str r3, [r12, #12]
	ldr	r3, [r2, #0]
	umull	r10, r0, r0, r3
	str r0, [r12, #16]
	mov	r0, r10
	ldr r3, [r12, #8]
	adc	r10, r11, r11
	adds	r3, r3, r5
	adc	r10, r10, #0
	adds	r3, r3, r4
	adc	r10, r10, #0
	adds	r3, r3, r6
	adc	r10, r10, #0
	adds	r3, r3, r9
	adc	r10, r10, #0
	adds	r3, r3, r0
	ldr r0, [r12, #4]
	ldr r5, [r12, #0]
	adc	r10, r10, #0
	adds	r3, r3, r0
	str	r3, [r5, #12]
	ldr	r3, [r2, #16]
	ldr	r0, [r1, #0]
	ldr	r4, [r2, #12]
	adc	r6, r10, #0
	umull	r0, r10, r0, r3
	ldr	r3, [r1, #4]
	adds	r7, r7, lr
	umull	r5, r9, r3, r4
	ldr	r3, [r2, #8]
	ldr	r4, [r1, #8]
	umull	lr, r4, r4, r3
	ldr	r3, [r1, #12]
	str r4, [r12, #20]
	ldr	r4, [r2, #4]
	umull	r3, r4, r3, r4
	str r3, [r12, #24]
	str r4, [r12, #28]
	ldr r3, [r12, #12]
	adc	r4, r11, r11
	adds	r7, r7, r3
	ldr r3, [r12, #16]
	adc	r4, r4, #0
	adds	r7, r7, r3
	adc	r4, r4, #0
	adds	r7, r7, r0
	ldr r3, [r12, #24]
	ldr	r0, [r1, #16]
	adc	r4, r4, #0
	adds	r7, r7, r5
	ldr	r5, [r2, #0]
	adc	r4, r4, #0
	adds	r7, r7, lr
	adc	r4, r4, #0
	adds	r7, r7, r3
	umull	r3, r5, r0, r5
	adc	r4, r4, #0
	adds	r3, r7, r3
	adc	r4, r4, #0
	adds	r3, r3, r6
	ldr r6, [r12, #0]
	adc	r7, r4, #0
	str	r3, [r6, #16]
	ldr	r3, [r2, #20]
	ldr	r0, [r1, #0]
	ldr	r4, [r2, #16]
	umull	r0, lr, r0, r3
	ldr	r3, [r1, #4]
	adds	r10, r10, r9
	umull	r6, r9, r3, r4
	ldr	r3, [r2, #12]
	ldr	r4, [r1, #8]
	str lr, [r12, #32]
	umull	lr, r4, r4, r3
	ldr	r3, [r2, #8]
	str r4, [r12, #36]
	ldr	r4, [r1, #12]
	umull	r4, r3, r4, r3
	str r4, [r12, #40]
	str r3, [r12, #44]
	ldr r3, [r12, #20]
	adc	r4, r11, r11
	adds	r10, r10, r3
	ldr r3, [r12, #28]
	adc	r4, r4, #0
	adds	r10, r10, r3
	adc	r4, r4, #0
	adds	r10, r10, r5
	adc	r4, r4, #0
	adds	r10, r10, r0
	ldr r3, [r12, #40]
	adc	r4, r4, #0
	adds	r10, r10, r6
	adc	r4, r4, #0
	adds	r10, r10, lr
	ldr	r5, [r2, #4]
	adc	r4, r4, #0
	adds	r0, r10, r3
	ldr	r3, [r1, #16]
	adc	r6, r4, #0
	umull	r3, r5, r3, r5
	ldr	r4, [r2, #0]
	adds	r0, r0, r3
	ldr	r3, [r1, #20]
	adc	r6, r6, #0
	umull	r3, r4, r3, r4
	adds	r3, r0, r3
	ldr r0, [r12, #0]
	adc	r6, r6, #0
	adds	r3, r3, r7
	str	r3, [r0, #20]
	ldr	r0, [r1, #0]
	adc	r7, r6, #0
	ldr	r6, [r2, #24]
	str r7, [r12, #48]
	umull	r7, lr, r0, r6
	ldr	r6, [r1, #4]
	ldr	r0, [r2, #20]
	ldr r3, [r12, #32]
	str lr, [r12, #52]
	umull	lr, r10, r6, r0
	ldr	r6, [r1, #8]
	ldr	r0, [r2, #16]
	adds	r3, r3, r9
	umull	r0, r9, r6, r0
	ldr r6, [r12, #36]
	str r9, [r12, #56]
	adc	r9, r11, r11
	adds	r3, r3, r6
	ldr r6, [r12, #44]
	adc	r9, r9, #0
	adds	r3, r3, r6
	adc	r9, r9, #0
	adds	r3, r3, r5
	adc	r9, r9, #0
	adds	r3, r3, r4
	adc	r9, r9, #0
	adds	r3, r3, r7
	adc	r9, r9, #0
	adds	r6, r3, lr
	ldr	r7, [r2, #12]
	adc	r9, r9, #0
	adds	r6, r6, r0
	ldr	r0, [r1, #12]
	ldr	r3, [r1, #16]
	ldr	r5, [r2, #8]
	umull	r0, r7, r0, r7
	umull	r3, r5, r3, r5
	adc	r9, r9, #0
	adds	r6, r6, r0
	ldr	r4, [r2, #4]
	adc	r9, r9, #0
	adds	r6, r6, r3
	ldr	r3, [r1, #20]
	ldr	r0, [r2, #0]
	umull	r3, r4, r3, r4
	adc	r9, r9, #0
	adds	r6, r6, r3
	ldr	r3, [r1, #24]
	adc	r9, r9, #0
	umull	r3, lr, r3, r0
	adds	r3, r6, r3
	ldr r6, [r12, #48]
	ldr r0, [r12, #0]
	adc	r9, r9, #0
	adds	r3, r3, r6
	str	r3, [r0, #24]
	adc	r3, r9, #0
	str r3, [r12, #60]
	ldr	r6, [r1, #0]
	ldr	r0, [r2, #28]
	ldr r3, [r12, #52]
	adds	r3, r3, r10
	umull	r9, r10, r6, r0
	ldr	r6, [r2, #24]
	ldr	r0, [r1, #4]
	str r10, [r12, #64]
	umull	r0, r10, r0, r6
	adc	r6, r11, r11
	str r6, [r12, #68]
	ldr r6, [r12, #56]
	adds	r3, r3, r6
	ldr r6, [r12, #68]
	adc	r6, r6, #0
	adds	r3, r3, r7
	adc	r6, r6, #0
	ldr	r7, [r2, #20]
	adds	r3, r3, r5
	ldr	r5, [r1, #8]
	adc	r6, r6, #0
	umull	r5, r7, r5, r7
	adds	r3, r3, r4
	adc	r6, r6, #0
	adds	r3, r3, lr
	adc	r6, r6, #0
	adds	r3, r3, r9
	adc	r4, r6, #0
	adds	r0, r3, r0
	adc	r4, r4, #0
	ldr	r3, [r1, #12]
	adds	r0, r0, r5
	ldr	r5, [r2, #16]
	adc	r4, r4, #0
	umull	r3, r5, r3, r5
	str r5, [r12, #72]
	adds	r0, r0, r3
	ldr	r5, [r2, #12]
	ldr	r3, [r1, #16]
	adc	r4, r4, #0
	umull	r3, r5, r3, r5
	str r5, [r12, #76]
	adds	r0, r0, r3
	ldr	r5, [r2, #8]
	ldr	r3, [r1, #20]
	ldr	r6, [r2, #4]
	umull	r3, r9, r3, r5
	adc	r4, r4, #0
	adds	r0, r0, r3
	ldr	r3, [r1, #24]
	ldr	r5, [r2, #0]
	umull	r3, r6, r3, r6
	adc	r4, r4, #0
	adds	r0, r0, r3
	ldr	r3, [r1, #28]
	adc	r4, r4, #0
	umull	r3, r5, r3, r5
	adds	r3, r0, r3
	ldr r0, [r12, #60]
	adc	r4, r4, #0
	adds	r3, r3, r0
	adc	lr, r4, #0
	ldr r0, [r12, #0]
	ldr r4, [r12, #64]
	str	r3, [r0, #28]
	adds	r3, r4, r10
	adc	r10, r11, r11
	adds	r3, r3, r7
	ldr r7, [r12, #72]
	ldr	r4, [r1, #4]
	ldr	r0, [r2, #28]
	adc	r10, r10, #0
	adds	r3, r3, r7
	ldr r7, [r12, #76]
	umull	r4, r0, r4, r0
	adc	r10, r10, #0
	adds	r3, r3, r7
	adc	r10, r10, #0
	adds	r9, r3, r9
	adc	r10, r10, #0
	adds	r9, r9, r6
	adc	r3, r10, #0
	adds	r9, r9, r5
	str r0, [r12, #80]
	adc	r3, r3, #0
	adds	r9, r9, r4
	ldr	r4, [r1, #8]
	ldr	r5, [r2, #24]
	ldr	r6, [r2, #20]
	umull	r4, r5, r4, r5
	adc	r3, r3, #0
	adds	r9, r9, r4
	ldr	r4, [r1, #12]
	adc	r3, r3, #0
	umull	r4, r6, r4, r6
	adds	r9, r9, r4
	adc	r7, r3, #0
	ldr	r4, [r2, #16]
	ldr	r3, [r1, #16]
	ldr r0, [r12, #0]
	umull	r3, r4, r3, r4
	adds	r9, r9, r3
	str r4, [r12, #84]
	adc	r3, r7, #0
	ldr	r4, [r1, #20]
	ldr	r7, [r2, #12]
	umull	r4, r7, r4, r7
	str r7, [r12, #88]
	adds	r9, r9, r4
	ldr	r7, [r2, #8]
	ldr	r4, [r1, #24]
	adc	r3, r3, #0
	umull	r4, r7, r4, r7
	str r7, [r12, #92]
	adds	r9, r9, r4
	ldr	r7, [r2, #4]
	ldr	r4, [r1, #28]
	adc	r3, r3, #0
	umull	r4, r7, r4, r7
	adds	r4, r9, r4
	adc	r3, r3, #0
	adds	r4, r4, lr
	str	r4, [r0, #32]
	ldr r0, [r12, #80]
	adc	r3, r3, #0
	adds	r0, r0, r5
	adc	r10, r11, r11
	adds	r0, r0, r6
	ldr r6, [r12, #84]
	ldr	r5, [r1, #8]
	ldr	r4, [r2, #28]
	adc	r10, r10, #0
	adds	r0, r0, r6
	ldr r6, [r12, #88]
	umull	r9, lr, r5, r4
	ldr	r4, [r1, #12]
	ldr	r5, [r2, #24]
	adc	r10, r10, #0
	adds	r0, r0, r6
	ldr r6, [r12, #92]
	umull	r4, r5, r4, r5
	adc	r10, r10, #0
	adds	r0, r0, r6
	adc	r6, r10, #0
	adds	r0, r0, r7
	adc	r6, r6, #0
	adds	r10, r0, r9
	adc	r0, r6, #0
	ldr	r6, [r1, #16]
	adds	r10, r10, r4
	ldr	r4, [r2, #20]
	adc	r0, r0, #0
	umull	r6, r4, r6, r4
	adds	r10, r10, r6
	adc	r7, r0, #0
	ldr	r6, [r1, #20]
	ldr	r0, [r2, #16]
	umull	r6, r9, r6, r0
	adds	r10, r10, r6
	adc	r0, r7, #0
	ldr	r6, [r1, #24]
	ldr	r7, [r2, #12]
	umull	r6, r7, r6, r7
	adds	r6, r10, r6
	str r7, [r12, #96]
	adc	r10, r0, #0
	ldr	r0, [r1, #28]
	ldr	r7, [r2, #8]
	umull	r0, r7, r0, r7
	adds	r0, r6, r0
	adc	r10, r10, #0
	adds	r0, r0, r3
	ldr r3, [r12, #0]
	adc	r10, r10, #0
	str	r0, [r3, #36]
	ldr	r0, [r1, #12]
	ldr	r3, [r2, #28]
	adds	lr, lr, r5
	umull	r6, r5, r0, r3
	ldr	r0, [r2, #24]
	ldr	r3, [r1, #16]
	str r5, [r12, #100]
	umull	r5, r3, r3, r0
	ldr	r0, [r1, #20]
	str r5, [r12, #104]
	ldr	r5, [r2, #20]
	umull	r0, r5, r0, r5
	str r5, [r12, #108]
	adc	r5, r11, r11
	adds	lr, lr, r4
	ldr r4, [r12, #96]
	adc	r5, r5, #0
	adds	lr, lr, r9
	adc	r5, r5, #0
	adds	lr, lr, r4
	adc	r5, r5, #0
	ldr r4, [r12, #104]
	adds	lr, lr, r7
	adc	r5, r5, #0
	adds	lr, lr, r6
	adc	r5, r5, #0
	adds	lr, lr, r4
	adc	r5, r5, #0
	adds	r6, lr, r0
	adc	r7, r5, #0
	ldr	r0, [r1, #24]
	ldr	r5, [r2, #16]
	ldr	r4, [r2, #12]
	umull	r0, r5, r0, r5
	adds	r6, r6, r0
	ldr	r0, [r1, #28]
	adc	r7, r7, #0
	umull	r0, r4, r0, r4
	adds	r0, r6, r0
	ldr r6, [r12, #0]
	adc	r7, r7, #0
	adds	r0, r0, r10
	str	r0, [r6, #40]
	ldr r0, [r12, #100]
	ldr	r6, [r1, #16]
	adc	r10, r7, #0
	adds	r3, r0, r3
	ldr	r0, [r2, #28]
	str r5, [r12, #112]
	umull	r7, r0, r6, r0
	ldr	r6, [r1, #20]
	str r0, [r12, #116]
	ldr	r0, [r2, #24]
	umull	lr, r0, r6, r0
	ldr	r6, [r1, #24]
	str r0, [r12, #120]
	ldr	r0, [r2, #20]
	umull	r9, r6, r6, r0
	str r6, [r12, #124]
	ldr	r0, [r1, #28]
	ldr	r6, [r2, #16]
	umull	r0, r5, r0, r6
	str r5, [r12, #128]
	ldr r5, [r12, #108]
	adc	r6, r11, r11
	adds	r3, r3, r5
	ldr r5, [r12, #112]
	adc	r6, r6, #0
	adds	r3, r3, r5
	adc	r6, r6, #0
	adds	r3, r3, r4
	adc	r6, r6, #0
	adds	r3, r3, r7
	adc	r6, r6, #0
	adds	r3, r3, lr
	adc	r6, r6, #0
	adds	r3, r3, r9
	ldr r5, [r12, #0]
	adc	r6, r6, #0
	adds	r3, r3, r0
	adc	r6, r6, #0
	adds	r3, r3, r10
	str	r3, [r5, #44]
	ldr	r7, [r1, #20]
	adc	r4, r6, #0
	ldr r3, [r12, #116]
	ldr r0, [r12, #120]
	adds	r3, r3, r0
	ldr	r0, [r2, #28]
	ldr	r5, [r2, #24]
	umull	lr, r7, r7, r0
	ldr	r0, [r1, #24]
	ldr	r6, [r2, #20]
	umull	r10, r0, r0, r5
	str r0, [r12, #132]
	ldr r0, [r12, #124]
	ldr	r5, [r1, #28]
	adc	r9, r11, r11
	adds	r3, r3, r0
	ldr r0, [r12, #128]
	umull	r6, r5, r5, r6
	adc	r9, r9, #0
	adds	r3, r3, r0
	adc	r9, r9, #0
	adds	r3, r3, lr
	adc	r9, r9, #0
	adds	r3, r3, r10
	adc	r9, r9, #0
	adds	r3, r3, r6
	ldr r6, [r12, #0]
	adc	r9, r9, #0
	adds	r3, r3, r4
	str	r3, [r6, #48]
	ldr r3, [r12, #132]
	ldr	r4, [r2, #28]
	adc	r9, r9, #0
	adds	r0, r7, r3
	ldr	r3, [r1, #24]
	ldr	r6, [r2, #24]
	umull	r7, r3, r3, r4
	ldr	r4, [r1, #28]
	adc	lr, r11, r11
	umull	r6, r4, r4, r6
	adds	r0, r0, r5
	adc	lr, lr, #0
	adds	r0, r0, r7
	ldr r5, [r12, #0]
	adc	lr, lr, #0
	adds	r0, r0, r6
	adc	lr, lr, #0
	adds	r0, r0, r9
	str	r0, [r5, #52]
	ldr	r0, [r1, #28]
	ldr	r1, [r2, #28]
	adc	lr, lr, #0
	umull	r0, r1, r0, r1
	adds	r2, r3, r4
	adc	r3, r11, r11
	adds	r2, r2, r0
	adc	r3, r3, #0
	adds	r2, r2, lr
	adc	r1, r1, r3
	str r2, [r5, #56]
	str r1, [r5, #60]
	ldr	r9, [r8, #0]
	ldr	r10, [r8, #40]
	eor	r9, r9, r10
	ldr	r10, [r8, #80]
	eor	r9, r9, r10
	ldr	r10, [r8, #120]
	eor	r9, r9, r10
	ldr	r10, [r8, #160]
	eor	r9, r9, r10
	str	r9, [r8, #400]
	ldr	r9, [r8, #4]
	ldr	r10, [r8, #44]
	eor	r9, r9, r10
	ldr	r10, [r8, #84]
	eor	r9, r9, r10
	ldr	r10, [r8, #124]
	eor	r9, r9, r10
	ldr	r10, [r8, #164]
	eor	r9, r9, r10
	str	r9, [r8, #404]
	ldr	r9, [r8, #8]
	ldr	r10, [r8, #48]
	eor	r9, r9, r10
	ldr	r10, [r8, #88]
	eor	r9, r9, r10
	ldr	r10, [r8, #128]
	eor	r9, r9, r10
	ldr	r10, [r8, #168]
	eor	r9, r9, r10
	str	r9, [r8, #408]
	ldr	r9, [r8, #12]
	ldr	r10, [r8, #52]
	eor	r9, r9, r10
	ldr	r10, [r8, #92]
	eor	r9, r9, r10
	ldr	r10, [r8, #132]
	eor	r9, r9, r10
	ldr	r10, [r8, #172]
	eor	r9, r9, r10
	str	r9, [r8, #412]
	ldr	r9, [r8, #16]
	ldr	r10, [r8, #56]
	eor	r9, r9, r10
	ldr	r10, [r8, #96]
	eor	r9, r9, r10
	ldr	r10, [r8, #136]
	eor	r9, r9, r10
	ldr	r10, [r8, #176]
	eor	r9, r9, r10
	str	r9, [r8, #416]
	ldr	r9, [r8, #20]
	ldr	r10, [r8, #60]
	eor	r9, r9, r10
	ldr	r10, [r8, #100]
	eor	r9, r9, r10
	ldr	r10, [r8, #140]
	eor	r9, r9, r10
	ldr	r10, [r8, #180]
	eor	r9, r9, r10
	str	r9, [r8, #420]
	ldr	r9, [r8, #24]
	ldr	r10, [r8, #64]
	eor	r9, r9, r10
	ldr	r10, [r8, #104]
	eor	r9, r9, r10
	ldr	r10, [r8, #144]
	eor	r9, r9, r10
	ldr	r10, [r8, #184]
	eor	r9, r9, r10
	str	r9, [r8, #424]
	ldr	r9, [r8, #28]
	ldr	r10, [r8, #68]
	eor	r9, r9, r10
	ldr	r10, [r8, #108]
	eor	r9, r9, r10
	ldr	r10, [r8, #148]
	eor	r9, r9, r10
	ldr	r10, [r8, #188]
	eor	r9, r9, r10
	str	r9, [r8, #428]
	ldr	r9, [r8, #32]
	ldr	r10, [r8, #72]
	eor	r9, r9, r10
	ldr	r10, [r8, #112]
	eor	r9, r9, r10
	ldr	r10, [r8, #152]
	eor	r9, r9, r10
	ldr	r10, [r8, #192]
	eor	r9, r9, r10
	str	r9, [r8, #432]
	ldr	r9, [r8, #36]
	ldr	r10, [r8, #76]
	eor	r9, r9, r10
	ldr	r10, [r8, #116]
	eor	r9, r9, r10
	ldr	r10, [r8, #156]
	eor	r9, r9, r10
	ldr	r10, [r8, #196]
	eor	r9, r9, r10
	str	r9, [r8, #436]
	ldr	r9, [r8, #408]
	ldr	r10, [r8, #412]
	lsl	r11, r9, #1
	orr	r11, r11, r10, lsr #31
	ldr	r9, [r8, #432]
	eor	r11, r11, r9
	str	r11, [r8, #440]
	ldr	r9, [r8, #408]
	lsl	r11, r10, #1
	orr	r11, r11, r9, lsr #31
	ldr	r10, [r8, #436]
	eor	r11, r11, r10
	str	r11, [r8, #444]
	ldr	r9, [r8, #416]
	ldr	r10, [r8, #420]
	lsl	r11, r9, #1
	orr	r11, r11, r10, lsr #31
	ldr	r9, [r8, #400]
	eor	r11, r11, r9
	str	r11, [r8, #448]
	ldr	r9, [r8, #416]
	lsl	r11, r10, #1
	orr	r11, r11, r9, lsr #31
	ldr	r10, [r8, #404]
	eor	r11, r11, r10
	str	r11, [r8, #452]
	ldr	r9, [r8, #424]
	ldr	r10, [r8, #428]
	lsl	r11, r9, #1
	orr	r11, r11, r10, lsr #31
	ldr	r9, [r8, #408]
	eor	r11, r11, r9
	str	r11, [r8, #456]
	ldr	r9, [r8, #424]
	lsl	r11, r10, #1
	orr	r11, r11, r9, lsr #31
	ldr	r10, [r8, #412]
	eor	r11, r11, r10
	str	r11, [r8, #460]
	ldr	r9, [r8, #432]
	ldr	r10, [r8, #436]
	lsl	r11, r9, #1
	orr	r11, r11, r10, lsr #31
	ldr	r9, [r8, #416]
	eor	r11, r11, r9
	str	r11, [r8, #464]
	ldr	r9, [r8, #432]
	lsl	r11, r10, #1
	orr	r11, r11, r9, lsr #31
	ldr	r10, [r8, #420]
	eor	r11, r11, r10
	str	r11, [r8, #468]
	ldr	r9, [r8, #400]
	ldr	r10, [r8, #404]
	lsl	r11, r9, #1
	orr	r11, r11, r10, lsr #31
	ldr	r9, [r8, #424]
	eor	r11, r11, r9
	str	r11, [r8, #472]
	ldr	r9, [r8, #400]
	lsl	r11, r10, #1
	orr	r11, r11, r9, lsr #31
	ldr	r10, [r8, #428]
	eor	r11, r11, r10
	str	r11, [r8, #476]
	ldr	r6, [r8, #440]
	ldr	r7, [r8, #444]
	ldr	r9, [r8, #0]
	ldr	r10, [r8, #4]
	eor	r9, r9, r6
	eor	r10, r10, r7
	str	r9, [r8, #200]
	str	r10, [r8, #204]
	ldr	r9, [r8, #40]
	ldr	r10, [r8, #44]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r10, #4
	orr	r11, r11, r9, lsr #28
	str	r11, [r8, #328]
	lsl	r11, r9, #4
	orr	r11, r11, r10, lsr #28
	str	r11, [r8, #332]
	ldr	r9, [r8, #80]
	ldr	r10, [r8, #84]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r9, #3
	orr	r11, r11, r10, lsr #29
	str	r11, [r8, #256]
	lsl	r11, r10, #3
	orr	r11, r11, r9, lsr #29
	str	r11, [r8, #260]
	ldr	r9, [r8, #120]
	ldr	r10, [r8, #124]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r10, #9
	orr	r11, r11, r9, lsr #23
	str	r11, [r8, #384]
	lsl	r11, r9, #9
	orr	r11, r11, r10, lsr #23
	str	r11, [r8, #388]
	ldr	r9, [r8, #160]
	ldr	r10, [r8, #164]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r9, #18
	orr	r11, r11, r10, lsr #14
	str	r11, [r8, #312]
	lsl	r11, r10, #18
	orr	r11, r11, r9, lsr #14
	str	r11, [r8, #316]
	ldr	r6, [r8, #448]
	ldr	r7, [r8, #452]
	ldr	r9, [r8, #8]
	ldr	r10, [r8, #12]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r9, #1
	orr	r11, r11, r10, lsr #31
	str	r11, [r8, #280]
	lsl	r11, r10, #1
	orr	r11, r11, r9, lsr #31
	str	r11, [r8, #284]
	ldr	r9, [r8, #48]
	ldr	r10, [r8, #52]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r10, #12
	orr	r11, r11, r9, lsr #20
	str	r11, [r8, #208]
	lsl	r11, r9, #12
	orr	r11, r11, r10, lsr #20
	str	r11, [r8, #212]
	ldr	r9, [r8, #88]
	ldr	r10, [r8, #92]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r9, #10
	orr	r11, r11, r10, lsr #22
	str	r11, [r8, #336]
	lsl	r11, r10, #10
	orr	r11, r11, r9, lsr #22
	str	r11, [r8, #340]
	ldr	r9, [r8, #128]
	ldr	r10, [r8, #132]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r10, #13
	orr	r11, r11, r9, lsr #19
	str	r11, [r8, #264]
	lsl	r11, r9, #13
	orr	r11, r11, r10, lsr #19
	str	r11, [r8, #268]
	ldr	r9, [r8, #168]
	ldr	r10, [r8, #172]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r9, #2
	orr	r11, r11, r10, lsr #30
	str	r11, [r8, #392]
	lsl	r11, r10, #2
	orr	r11, r11, r9, lsr #30
	str	r11, [r8, #396]
	ldr	r6, [r8, #456]
	ldr	r7, [r8, #460]
	ldr	r9, [r8, #16]
	ldr	r10, [r8, #20]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r10, #30
	orr	r11, r11, r9, lsr #2
	str	r11, [r8, #360]
	lsl	r11, r9, #30
	orr	r11, r11, r10, lsr #2
	str	r11, [r8, #364]
	ldr	r9, [r8, #56]
	ldr	r10, [r8, #60]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r9, #6
	orr	r11, r11, r10, lsr #26
	str	r11, [r8, #288]
	lsl	r11, r10, #6
	orr	r11, r11, r9, lsr #26
	str	r11, [r8, #292]
	ldr	r9, [r8, #96]
	ldr	r10, [r8, #100]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r10, #11
	orr	r11, r11, r9, lsr #21
	str	r11, [r8, #216]
	lsl	r11, r9, #11
	orr	r11, r11, r10, lsr #21
	str	r11, [r8, #220]
	ldr	r9, [r8, #136]
	ldr	r10, [r8, #140]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r9, #15
	orr	r11, r11, r10, lsr #17
	str	r11, [r8, #344]
	lsl	r11, r10, #15
	orr	r11, r11, r9, lsr #17
	str	r11, [r8, #348]
	ldr	r9, [r8, #176]
	ldr	r10, [r8, #180]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r10, #29
	orr	r11, r11, r9, lsr #3
	str	r11, [r8, #272]
	lsl	r11, r9, #29
	orr	r11, r11, r10, lsr #3
	str	r11, [r8, #276]
	ldr	r6, [r8, #464]
	ldr	r7, [r8, #468]
	ldr	r9, [r8, #24]
	ldr	r10, [r8, #28]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r9, #28
	orr	r11, r11, r10, lsr #4
	str	r11, [r8, #240]
	lsl	r11, r10, #28
	orr	r11, r11, r9, lsr #4
	str	r11, [r8, #244]
	ldr	r9, [r8, #64]
	ldr	r10, [r8, #68]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r10, #23
	orr	r11, r11, r9, lsr #9
	str	r11, [r8, #368]
	lsl	r11, r9, #23
	orr	r11, r11, r10, lsr #9
	str	r11, [r8, #372]
	ldr	r9, [r8, #104]
	ldr	r10, [r8, #108]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r9, #25
	orr	r11, r11, r10, lsr #7
	str	r11, [r8, #296]
	lsl	r11, r10, #25
	orr	r11, r11, r9, lsr #7
	str	r11, [r8, #300]
	ldr	r9, [r8, #144]
	ldr	r10, [r8, #148]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r9, #21
	orr	r11, r11, r10, lsr #11
	str	r11, [r8, #224]
	lsl	r11, r10, #21
	orr	r11, r11, r9, lsr #11
	str	r11, [r8, #228]
	ldr	r9, [r8, #184]
	ldr	r10, [r8, #188]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r10, #24
	orr	r11, r11, r9, lsr #8
	str	r11, [r8, #352]
	lsl	r11, r9, #24
	orr	r11, r11, r10, lsr #8
	str	r11, [r8, #356]
	ldr	r6, [r8, #472]
	ldr	r7, [r8, #476]
	ldr	r9, [r8, #32]
	ldr	r10, [r8, #36]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r9, #27
	orr	r11, r11, r10, lsr #5
	str	r11, [r8, #320]
	lsl	r11, r10, #27
	orr	r11, r11, r9, lsr #5
	str	r11, [r8, #324]
	ldr	r9, [r8, #72]
	ldr	r10, [r8, #76]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r9, #20
	orr	r11, r11, r10, lsr #12
	str	r11, [r8, #248]
	lsl	r11, r10, #20
	orr	r11, r11, r9, lsr #12
	str	r11, [r8, #252]
	ldr	r9, [r8, #112]
	ldr	r10, [r8, #116]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r10, #7
	orr	r11, r11, r9, lsr #25
	str	r11, [r8, #376]
	lsl	r11, r9, #7
	orr	r11, r11, r10, lsr #25
	str	r11, [r8, #380]
	ldr	r9, [r8, #152]
	ldr	r10, [r8, #156]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r9, #8
	orr	r11, r11, r10, lsr #24
	str	r11, [r8, #304]
	lsl	r11, r10, #8
	orr	r11, r11, r9, lsr #24
	str	r11, [r8, #308]
	ldr	r9, [r8, #192]
	ldr	r10, [r8, #196]
	eor	r9, r9, r6
	eor	r10, r10, r7
	lsl	r11, r9, #14
	orr	r11, r11, r10, lsr #18
	str	r11, [r8, #232]
	lsl	r11, r10, #14
	orr	r11, r11, r9, lsr #18
	str	r11, [r8, #236]
	ldr	r9, [r8, #200]
	ldr	r10, [r8, #208]
	ldr	r11, [r8, #216]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #0]
	ldr	r9, [r8, #224]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #8]
	ldr	r10, [r8, #232]
	bic	r6, r10, r9
	eor	r6, r6, r11
	str	r6, [r8, #16]
	ldr	r11, [r8, #200]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #24]
	ldr	r9, [r8, #208]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #32]
	ldr	r9, [r8, #204]
	ldr	r10, [r8, #212]
	ldr	r11, [r8, #220]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #4]
	ldr	r9, [r8, #228]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #12]
	ldr	r10, [r8, #236]
	bic	r6, r10, r9
	eor	r6, r6, r11
	str	r6, [r8, #20]
	ldr	r11, [r8, #204]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #28]
	ldr	r9, [r8, #212]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #36]
	ldr	r9, [r8, #240]
	ldr	r10, [r8, #248]
	ldr	r11, [r8, #256]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #40]
	ldr	r9, [r8, #264]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #48]
	ldr	r10, [r8, #272]
	bic	r6, r10, r9
	eor	r6, r6, r11
	str	r6, [r8, #56]
	ldr	r11, [r8, #240]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #64]
	ldr	r9, [r8, #248]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #72]
	ldr	r9, [r8, #244]
	ldr	r10, [r8, #252]
	ldr	r11, [r8, #260]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #44]
	ldr	r9, [r8, #268]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #52]
	ldr	r10, [r8, #276]
	bic	r6, r10, r9
	eor	r6, r6, r11
	str	r6, [r8, #60]
	ldr	r11, [r8, #244]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #68]
	ldr	r9, [r8, #252]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #76]
	ldr	r9, [r8, #280]
	ldr	r10, [r8, #288]
	ldr	r11, [r8, #296]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #80]
	ldr	r9, [r8, #304]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #88]
	ldr	r10, [r8, #312]
	bic	r6, r10, r9
	eor	r6, r6, r11
	str	r6, [r8, #96]
	ldr	r11, [r8, #280]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #104]
	ldr	r9, [r8, #288]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #112]
	ldr	r9, [r8, #284]
	ldr	r10, [r8, #292]
	ldr	r11, [r8, #300]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #84]
	ldr	r9, [r8, #308]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #92]
	ldr	r10, [r8, #316]
	bic	r6, r10, r9
	eor	r6, r6, r11
	str	r6, [r8, #100]
	ldr	r11, [r8, #284]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #108]
	ldr	r9, [r8, #292]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #116]
	ldr	r9, [r8, #320]
	ldr	r10, [r8, #328]
	ldr	r11, [r8, #336]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #120]
	ldr	r9, [r8, #344]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #128]
	ldr	r10, [r8, #352]
	bic	r6, r10, r9
	eor	r6, r6, r11
	str	r6, [r8, #136]
	ldr	r11, [r8, #320]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #144]
	ldr	r9, [r8, #328]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #152]
	ldr	r9, [r8, #324]
	ldr	r10, [r8, #332]
	ldr	r11, [r8, #340]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #124]
	ldr	r9, [r8, #348]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #132]
	ldr	r10, [r8, #356]
	bic	r6, r10, r9
	eor	r6, r6, r11
	str	r6, [r8, #140]
	ldr	r11, [r8, #324]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #148]
	ldr	r9, [r8, #332]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #156]
	ldr	r9, [r8, #360]
	ldr	r10, [r8, #368]
	ldr	r11, [r8, #376]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #160]
	ldr	r9, [r8, #384]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #168]
	ldr	r10, [r8, #392]
	bic	r6, r10, r9
	eor	r6, r6, r11
	str	r6, [r8, #176]
	ldr	r11, [r8, #360]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #184]
	ldr	r9, [r8, #368]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #192]
	ldr	r9, [r8, #364]
	ldr	r10, [r8, #372]
	ldr	r11, [r8, #380]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #164]
	ldr	r9, [r8, #388]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #172]
	ldr	r10, [r8, #396]
	bic	r6, r10, r9
	eor	r6, r6, r11
	str	r6, [r8, #180]
	ldr	r11, [r8, #364]
	bic	r6, r11, r10
	eor	r6, r6, r9
	str	r6, [r8, #188]
	ldr	r9, [r8, #372]
	bic	r6, r9, r11
	eor	r6, r6, r10
	str	r6, [r8, #196]
	ldr	r9, [r8, #0]
	eor	r9, r9, #1
	str	r9, [r8, #0]
	ldr r0, [r12, #240]
	subs r0, r0, #1
	str r0, [r12, #240]
	bne 1b
	pop {r4-r11, pc}

// bfull_slothy: counter=[r12,#240]
.global bfull_slothy
.type bfull_slothy, %function
.thumb_func
.balign 16
bfull_slothy:
	push {r4-r11, lr}
	movw r8, #:lower16:g_theta_state
	movt r8, #:upper16:g_theta_state
	movw r12, #:lower16:g_spill
	movt r12, #:upper16:g_spill
	str r0, [r12, #240]
.balign 16
1:
	movw r0, #:lower16:g_bf_r
	movt r0, #:upper16:g_bf_r
	movw r1, #:lower16:g_bf_a
	movt r1, #:upper16:g_bf_a
	movw r2, #:lower16:g_bf_b
	movt r2, #:upper16:g_bf_b
	mov r3, r0
	ldr r0, [r2, #0]
	mov r11, #0
	ldr r6, [r1, #0]
	ldr r7, [r1, #4]
	umull r7, r5, r7, r0
	ldr r4, [r2, #4]
	ldr r10, [r1, #0]
	str r3, [r12, #0]
	umull r4, r9, r6, r4
	ldr r0, [r2, #0]
	umull r10, r6, r10, r0
	ldr r0, [r2, #4]
	adds r9, r9, r5
	ldr r5, [r1, #4]
	str r10, [r3, #0]
	umull r5, r10, r5, r0
	adc r0, r11, r11
	adds r6, r6, r4
	adc r14, r11, r11
	ldr r4, [r1, #0]
	adds r6, r6, r7
	ldr r7, [r2, #8]
	str r6, [r3, #4]
	umull r4, r6, r4, r7
	adc r14, r14, #0
	ldr r3, [r1, #8]
	ldr r7, [r2, #12]
	adds r9, r9, r4
	adc r4, r0, #0
	adds r10, r6, r10
	str r10, [r12, #8]
	ldr r0, [r2, #0]
	adc r10, r11, r11
	umull r3, r6, r3, r0
	adds r9, r9, r5
	ldr r5, [r12, #8]
	adc r0, r4, #0
	adds r9, r9, r3
	adc r0, r0, #0
	adds r5, r5, r6
	adc r10, r10, #0
	ldr r4, [r1, #0]
	adds r3, r9, r14
	umull r6, r4, r4, r7
	ldr r9, [r1, #4]
	adc r7, r0, #0
	ldr r0, [r2, #8]
	adds r5, r5, r6
	adc r10, r10, #0
	str r7, [r12, #4]
	umull r6, r14, r9, r0
	ldr r7, [r12, #0]
	str r3, [r7, #8]
	ldr r3, [r2, #8]
	adds r4, r4, r14
	ldr r0, [r12, #12]
	adc r9, r11, r11
	adds r4, r4, r0
	ldr r0, [r12, #16]
	adc r9, r9, #0
	adds r7, r4, r0
	ldr r4, [r1, #8]
	ldr r0, [r2, #4]
	umull r14, r3, r4, r3
	adc r4, r9, #0
	adds r6, r5, r6
	str r3, [r12, #20]
	ldr r3, [r1, #12]
	ldr r5, [r2, #4]
	umull r0, r9, r3, r0
	ldr r3, [r1, #8]
	adc r10, r10, #0
	str r9, [r12, #28]
	umull r9, r5, r3, r5
	str r0, [r12, #24]
	ldr r0, [r2, #0]
	adds r3, r6, r9
	ldr r6, [r1, #12]
	str r5, [r12, #12]
	umull r0, r9, r6, r0
	adc r6, r10, #0
	ldr r10, [r12, #0]
	ldr r5, [r12, #4]
	str r9, [r12, #16]
	ldr r9, [r1, #4]
	mov r0, r0
	adds r3, r3, r0
	ldr r0, [r1, #0]
	adc r6, r6, #0
	adds r3, r3, r5
	ldr r5, [r2, #16]
	str r3, [r10, #12]
	ldr r3, [r12, #24]
	umull r0, r10, r0, r5
	adc r5, r6, #0
	ldr r6, [r2, #12]
	umull r6, r9, r9, r6
	adds r0, r7, r0
	adc r7, r4, #0
	ldr r4, [r1, #16]
	adds r0, r0, r6
	ldr r6, [r2, #0]
	adc r7, r7, #0
	adds r0, r0, r14
	umull r4, r6, r4, r6
	adc r7, r7, #0
	adds r3, r0, r3
	ldr r0, [r12, #20]
	adc r7, r7, #0
	adds r4, r3, r4
	adc r3, r7, #0
	adds r7, r4, r5
	ldr r5, [r1, #0]
	adc r4, r3, #0
	adds r10, r10, r9
	ldr r3, [r12, #28]
	adc r9, r11, r11
	adds r10, r10, r0
	adc r9, r9, #0
	adds r10, r10, r3
	ldr r3, [r12, #0]
	adc r0, r9, #0
	str r7, [r3, #16]
	ldr r3, [r2, #20]
	umull r3, r14, r5, r3
	ldr r5, [r2, #12]
	adds r9, r10, r6
	ldr r6, [r1, #8]
	adc r10, r0, #0
	str r14, [r12, #32]
	umull r14, r6, r6, r5
	ldr r7, [r1, #4]
	adds r5, r9, r3
	ldr r3, [r2, #16]
	umull r0, r9, r7, r3
	adc r7, r10, #0
	ldr r3, [r1, #16]
	str r6, [r12, #36]
	adds r5, r5, r0
	ldr r0, [r1, #20]
	adc r10, r7, #0
	adds r7, r5, r14
	adc r10, r10, #0
	ldr r5, [r12, #40]
	adds r7, r7, r5
	ldr r5, [r2, #4]
	umull r3, r6, r3, r5
	ldr r5, [r2, #0]
	umull r0, r5, r0, r5
	adc r10, r10, #0
	adds r3, r7, r3
	ldr r7, [r12, #36]
	adc r10, r10, #0
	adds r3, r3, r0
	adc r0, r10, #0
	adds r4, r3, r4
	adc r0, r0, #0
	ldr r10, [r12, #32]
	adds r9, r10, r9
	ldr r3, [r1, #8]
	str r0, [r12, #48]
	adc r10, r11, r11
	adds r7, r9, r7
	ldr r9, [r2, #16]
	umull r0, r9, r3, r9
	ldr r3, [r12, #0]
	str r4, [r3, #20]
	adc r3, r10, #0
	str r9, [r12, #56]
	ldr r10, [r12, #44]
	adds r9, r7, r10
	ldr r10, [r1, #0]
	adc r3, r3, #0
	ldr r7, [r2, #8]
	ldr r4, [r2, #24]
	adds r9, r9, r6
	umull r4, r14, r10, r4
	ldr r6, [r1, #12]
	umull r7, r10, r6, r7
	adc r6, r3, #0
	adds r9, r9, r5
	str r14, [r12, #52]
	str r10, [r12, #44]
	ldr r10, [r2, #20]
	ldr r3, [r1, #4]
	str r7, [r12, #40]
	umull r14, r10, r3, r10
	adc r3, r6, #0
	adds r7, r9, r4
	ldr r4, [r12, #52]
	adc r3, r3, #0
	adds r5, r7, r14
	adc r7, r3, #0
	adds r6, r5, r0
	adc r9, r7, #0
	ldr r0, [r1, #12]
	adds r3, r4, r10
	ldr r7, [r2, #12]
	ldr r4, [r1, #16]
	adc r10, r11, r11
	str r10, [r12, #68]
	umull r10, r0, r0, r7
	ldr r5, [r12, #56]
	ldr r7, [r2, #8]
	adds r6, r6, r10
	adc r10, r9, #0
	adds r9, r3, r5
	umull r5, r3, r4, r7
	ldr r7, [r12, #68]
	adc r4, r7, #0
	adds r7, r9, r0
	adc r9, r4, #0
	adds r6, r6, r5
	ldr r5, [r2, #4]
	adc r0, r10, #0
	ldr r10, [r1, #20]
	adds r3, r7, r3
	ldr r7, [r2, #0]
	umull r10, r4, r10, r5
	ldr r5, [r1, #24]
	adc r9, r9, #0
	adds r10, r6, r10
	umull r6, r14, r5, r7
	ldr r5, [r12, #0]
	adc r0, r0, #0
	ldr r7, [r2, #28]
	adds r6, r10, r6
	adc r0, r0, #0
	adds r10, r3, r4
	adc r4, r9, #0
	adds r3, r10, r14
	ldr r10, [r12, #48]
	adc r9, r4, #0
	adds r4, r6, r10
	ldr r6, [r1, #4]
	adc r10, r0, #0
	str r4, [r5, #24]
	str r10, [r12, #60]
	ldr r10, [r1, #0]
	umull r4, r0, r10, r7
	ldr r7, [r2, #24]
	umull r6, r10, r6, r7
	ldr r7, [r1, #8]
	ldr r5, [r2, #20]
	adds r3, r3, r4
	str r0, [r12, #64]
	ldr r4, [r1, #12]
	adc r0, r9, #0
	adds r9, r3, r6
	ldr r6, [r2, #16]
	umull r5, r7, r7, r5
	umull r6, r4, r4, r6
	adc r0, r0, #0
	ldr r3, [r2, #12]
	adds r9, r9, r5
	ldr r5, [r1, #16]
	adc r0, r0, #0
	str r4, [r12, #72]
	adds r6, r9, r6
	umull r5, r3, r5, r3
	ldr r4, [r1, #20]
	adc r0, r0, #0
	ldr r9, [r2, #8]
	str r3, [r12, #76]
	adds r6, r6, r5
	ldr r5, [r2, #4]
	umull r4, r9, r4, r9
	adc r3, r0, #0
	ldr r0, [r1, #24]
	adds r4, r6, r4
	umull r5, r6, r0, r5
	adc r0, r3, #0
	ldr r3, [r2, #0]
	adds r4, r4, r5
	ldr r5, [r1, #28]
	adc r0, r0, #0
	umull r3, r5, r5, r3
	adds r3, r4, r3
	ldr r4, [r12, #60]
	adc r0, r0, #0
	adds r4, r3, r4
	adc r14, r0, #0
	ldr r3, [r12, #64]
	adds r10, r3, r10
	ldr r0, [r12, #72]
	adc r3, r11, r11
	adds r10, r10, r7
	adc r3, r3, #0
	ldr r7, [r12, #0]
	str r4, [r7, #28]
	adds r7, r10, r0
	adc r4, r3, #0
	ldr r3, [r12, #76]
	adds r7, r7, r3
	ldr r0, [r1, #12]
	adc r4, r4, #0
	adds r7, r7, r9
	adc r9, r4, #0
	adds r7, r7, r6
	ldr r3, [r2, #24]
	adc r6, r9, #0
	adds r9, r7, r5
	ldr r4, [r1, #8]
	umull r3, r4, r4, r3
	ldr r10, [r2, #20]
	adc r7, r6, #0
	ldr r6, [r12, #80]
	umull r10, r0, r0, r10
	adds r5, r6, r4
	adc r4, r11, r11
	ldr r6, [r2, #28]
	adds r5, r5, r0
	ldr r0, [r1, #4]
	umull r0, r6, r0, r6
	adc r4, r4, #0
	adds r0, r9, r0
	str r6, [r12, #80]
	adc r7, r7, #0
	adds r3, r0, r3
	adc r7, r7, #0
	ldr r0, [r2, #12]
	adds r10, r3, r10
	ldr r3, [r1, #20]
	umull r3, r6, r3, r0
	ldr r0, [r12, #84]
	ldr r9, [r2, #16]
	adc r7, r7, #0
	str r6, [r12, #88]
	ldr r6, [r1, #16]
	adds r0, r5, r0
	umull r9, r5, r6, r9
	ldr r6, [r12, #88]
	adc r4, r4, #0
	adds r0, r0, r6
	str r5, [r12, #84]
	ldr r6, [r12, #92]
	adc r4, r4, #0
	adds r0, r0, r6
	adc r4, r4, #0
	adds r9, r10, r9
	ldr r6, [r1, #24]
	adc r7, r7, #0
	adds r3, r9, r3
	ldr r5, [r2, #8]
	umull r5, r6, r6, r5
	ldr r10, [r2, #4]
	adc r7, r7, #0
	ldr r9, [r1, #28]
	str r6, [r12, #92]
	adds r3, r3, r5
	umull r6, r10, r9, r10
	ldr r9, [r1, #8]
	adc r5, r7, #0
	ldr r7, [r2, #28]
	adds r10, r0, r10
	ldr r0, [r1, #12]
	adc r4, r4, #0
	adds r3, r3, r6
	adc r5, r5, #0
	adds r6, r3, r14
	adc r3, r5, #0
	ldr r5, [r2, #24]
	umull r9, r14, r9, r7
	ldr r7, [r12, #0]
	str r6, [r7, #32]
	umull r0, r5, r0, r5
	adds r7, r10, r9
	ldr r10, [r2, #20]
	adc r6, r4, #0
	ldr r4, [r1, #16]
	ldr r9, [r1, #20]
	umull r10, r4, r4, r10
	adds r7, r7, r0
	ldr r0, [r2, #16]
	umull r0, r9, r9, r0
	adc r6, r6, #0
	adds r10, r7, r10
	ldr r7, [r2, #12]
	adc r6, r6, #0
	adds r10, r10, r0
	adc r6, r6, #0
	adds r14, r14, r5
	adc r0, r11, r11
	adds r14, r14, r4
	adc r0, r0, #0
	adds r14, r14, r9
	ldr r4, [r12, #96]
	adc r0, r0, #0
	adds r14, r14, r4
	ldr r5, [r1, #24]
	umull r7, r5, r5, r7
	ldr r9, [r1, #28]
	adc r4, r0, #0
	ldr r0, [r2, #8]
	umull r0, r9, r9, r0
	adds r7, r10, r7
	adc r6, r6, #0
	str r5, [r12, #96]
	adds r5, r7, r0
	ldr r10, [r12, #0]
	adc r0, r6, #0
	adds r6, r5, r3
	str r6, [r10, #36]
	ldr r6, [r2, #28]
	adc r3, r0, #0
	ldr r10, [r1, #16]
	ldr r5, [r2, #24]
	adds r14, r14, r9
	umull r0, r9, r10, r5
	ldr r10, [r1, #12]
	ldr r7, [r12, #112]
	umull r6, r10, r10, r6
	str r0, [r12, #104]
	adc r0, r4, #0
	adds r14, r14, r6
	ldr r6, [r2, #20]
	adc r0, r0, #0
	ldr r4, [r1, #20]
	umull r4, r5, r4, r6
	ldr r6, [r12, #104]
	adds r14, r14, r6
	ldr r6, [r1, #24]
	str r10, [r12, #100]
	ldr r10, [r2, #16]
	str r5, [r12, #108]
	umull r5, r10, r6, r10
	adc r6, r0, #0
	adds r4, r14, r4
	ldr r0, [r12, #100]
	adc r6, r6, #0
	adds r0, r0, r9
	str r10, [r12, #112]
	ldr r10, [r12, #108]
	adc r9, r11, r11
	adds r10, r0, r10
	ldr r0, [r1, #28]
	adc r9, r9, #0
	adds r7, r10, r7
	ldr r10, [r2, #12]
	umull r10, r0, r0, r10
	adc r9, r9, #0
	adds r4, r4, r5
	ldr r5, [r12, #0]
	adc r6, r6, #0
	adds r10, r4, r10
	adc r6, r6, #0
	adds r4, r10, r3
	adc r3, r6, #0
	ldr r6, [r12, #0]
	str r4, [r6, #40]
	ldr r6, [r2, #28]
	ldr r10, [r1, #16]
	adds r7, r7, r0
	umull r0, r4, r10, r6
	ldr r10, [r2, #24]
	adc r9, r9, #0
	ldr r6, [r2, #20]
	str r4, [r12, #116]
	ldr r4, [r1, #20]
	adds r7, r7, r0
	umull r14, r10, r4, r10
	ldr r0, [r1, #28]
	adc r9, r9, #0
	str r10, [r12, #120]
	ldr r4, [r2, #16]
	ldr r10, [r1, #24]
	umull r0, r4, r0, r4
	umull r10, r6, r10, r6
	adds r7, r7, r14
	str r4, [r12, #128]
	adc r9, r9, #0
	adds r4, r7, r10
	str r6, [r12, #124]
	adc r10, r9, #0
	ldr r6, [r1, #24]
	adds r7, r4, r0
	ldr r4, [r2, #24]
	ldr r0, [r12, #116]
	adc r10, r10, #0
	adds r3, r7, r3
	ldr r9, [r2, #20]
	str r3, [r5, #44]
	ldr r3, [r12, #120]
	umull r6, r4, r6, r4
	ldr r7, [r2, #28]
	ldr r5, [r1, #20]
	adc r10, r10, #0
	umull r14, r7, r5, r7
	str r4, [r12, #132]
	adds r0, r0, r3
	ldr r4, [r1, #28]
	ldr r3, [r12, #124]
	adc r5, r11, r11
	adds r3, r0, r3
	ldr r0, [r12, #128]
	adc r5, r5, #0
	adds r0, r3, r0
	adc r5, r5, #0
	adds r0, r0, r14
	adc r5, r5, #0
	umull r4, r9, r4, r9
	adds r0, r0, r6
	ldr r3, [r12, #0]
	adc r5, r5, #0
	adds r0, r0, r4
	adc r6, r5, #0
	adds r5, r0, r10
	str r5, [r3, #48]
	ldr r4, [r12, #132]
	adc r3, r6, #0
	ldr r6, [r1, #24]
	adds r10, r7, r4
	ldr r5, [r2, #28]
	ldr r4, [r2, #24]
	umull r6, r7, r6, r5
	adc r14, r11, r11
	ldr r5, [r1, #28]
	umull r0, r4, r5, r4
	adds r10, r10, r9
	adc r14, r14, #0
	adds r9, r10, r6
	ldr r1, [r1, #28]
	adc r14, r14, #0
	adds r9, r9, r0
	ldr r5, [r12, #0]
	adc r14, r14, #0
	adds r6, r9, r3
	adc r14, r14, #0
	ldr r3, [r2, #28]
	ldr r9, [r8, #0]
	umull r0, r1, r1, r3
	adds r10, r7, r4
	str r6, [r5, #52]
	adc r6, r11, r11
	adds r10, r10, r0
	adc r3, r6, #0
	adds r2, r10, r14
	adc r1, r1, r3
	ldr r6, [r8, #40]
	ldr r10, [r8, #80]
	eor r11, r9, r6
	ldr r6, [r8, #120]
	eor r7, r11, r10
	eor r10, r7, r6
	ldr r11, [r8, #160]
	eor r11, r10, r11
	ldr r6, [r8, #4]
	str r11, [r8, #400]
	ldr r7, [r8, #44]
	eor r11, r6, r7
	ldr r6, [r8, #84]
	ldr r10, [r8, #124]
	eor r9, r11, r6
	str r1, [r5, #60]
	ldr r6, [r8, #88]
	eor r11, r9, r10
	ldr r7, [r8, #164]
	ldr r10, [r8, #48]
	str r2, [r5, #56]
	eor r9, r11, r7
	ldr r11, [r8, #8]
	eor r7, r11, r10
	str r9, [r8, #404]
	eor r11, r7, r6
	ldr r10, [r8, #128]
	eor r7, r11, r10
	ldr r11, [r8, #168]
	ldr r6, [r8, #52]
	eor r11, r7, r11
	ldr r10, [r8, #12]
	str r11, [r8, #408]
	eor r11, r10, r6
	ldr r10, [r8, #92]
	eor r11, r11, r10
	ldr r10, [r8, #132]
	eor r11, r11, r10
	ldr r10, [r8, #172]
	eor r10, r11, r10
	ldr r6, [r8, #16]
	str r10, [r8, #412]
	ldr r10, [r8, #56]
	eor r11, r6, r10
	ldr r10, [r8, #96]
	eor r11, r11, r10
	ldr r10, [r8, #136]
	eor r11, r11, r10
	ldr r10, [r8, #176]
	eor r10, r11, r10
	ldr r6, [r8, #20]
	str r10, [r8, #416]
	ldr r10, [r8, #60]
	eor r11, r6, r10
	ldr r10, [r8, #100]
	eor r11, r11, r10
	ldr r10, [r8, #140]
	eor r11, r11, r10
	ldr r10, [r8, #180]
	eor r10, r11, r10
	ldr r6, [r8, #24]
	str r10, [r8, #420]
	ldr r10, [r8, #64]
	eor r11, r6, r10
	ldr r10, [r8, #104]
	eor r11, r11, r10
	ldr r10, [r8, #144]
	eor r11, r11, r10
	ldr r10, [r8, #184]
	eor r10, r11, r10
	ldr r6, [r8, #28]
	str r10, [r8, #424]
	ldr r10, [r8, #68]
	eor r11, r6, r10
	ldr r10, [r8, #108]
	eor r11, r11, r10
	ldr r10, [r8, #148]
	eor r11, r11, r10
	ldr r10, [r8, #188]
	eor r10, r11, r10
	ldr r6, [r8, #32]
	str r10, [r8, #428]
	ldr r10, [r8, #72]
	eor r11, r6, r10
	ldr r10, [r8, #112]
	eor r11, r11, r10
	ldr r10, [r8, #152]
	eor r11, r11, r10
	ldr r10, [r8, #192]
	eor r10, r11, r10
	ldr r6, [r8, #36]
	str r10, [r8, #432]
	ldr r10, [r8, #76]
	eor r11, r6, r10
	ldr r10, [r8, #116]
	eor r11, r11, r10
	ldr r10, [r8, #156]
	eor r11, r11, r10
	ldr r10, [r8, #196]
	eor r11, r11, r10
	ldr r10, [r8, #408]
	str r11, [r8, #436]
	ldr r9, [r8, #412]
	lsl r11, r10, #1
	ldr r10, [r8, #432]
	orr r6, r11, r9, lsr     #31
	ldr r11, [r8, #408]
	eor r6, r6, r10
	lsl r10, r9, #1
	str r6, [r8, #440]
	orr r11, r10, r11, lsr     #31
	ldr r10, [r8, #436]
	eor r11, r11, r10
	ldr r10, [r8, #416]
	str r11, [r8, #444]
	ldr r9, [r8, #420]
	lsl r11, r10, #1
	ldr r10, [r8, #400]
	orr r6, r11, r9, lsr     #31
	ldr r11, [r8, #416]
	eor r6, r6, r10
	lsl r10, r9, #1
	orr r11, r10, r11, lsr     #31
	ldr r10, [r8, #404]
	str r6, [r8, #448]
	eor r11, r11, r10
	str r11, [r8, #452]
	ldr r6, [r8, #424]
	ldr r10, [r8, #428]
	lsl r6, r6, #1
	ldr r11, [r8, #408]
	lsl r7, r10, #1
	orr r6, r6, r10, lsr     #31
	ldr r10, [r8, #424]
	eor r11, r6, r11
	ldr r9, [r8, #412]
	str r11, [r8, #456]
	orr r11, r7, r10, lsr     #31
	ldr r10, [r8, #432]
	eor r11, r11, r9
	str r11, [r8, #460]
	ldr r6, [r8, #436]
	ldr r11, [r8, #416]
	lsl r10, r10, #1
	lsl r7, r6, #1
	orr r6, r10, r6, lsr     #31
	ldr r9, [r8, #432]
	eor r11, r6, r11
	str r11, [r8, #464]
	ldr r10, [r8, #420]
	orr r7, r7, r9, lsr     #31
	eor r6, r7, r10
	ldr r9, [r8, #400]
	str r6, [r8, #468]
	ldr r10, [r8, #404]
	lsl r9, r9, #1
	ldr r6, [r8, #424]
	orr r9, r9, r10, lsr     #31
	ldr r7, [r8, #400]
	eor r6, r9, r6
	lsl r11, r10, #1
	str r6, [r8, #472]
	ldr r9, [r8, #428]
	ldr r10, [r8, #444]
	orr r6, r11, r7, lsr     #31
	eor r6, r6, r9
	ldr r9, [r8, #0]
	str r6, [r8, #476]
	ldr r6, [r8, #440]
	ldr r7, [r8, #4]
	eor r11, r9, r6
	str r11, [r8, #200]
	ldr r11, [r8, #40]
	eor r7, r7, r10
	ldr r9, [r8, #44]
	eor r11, r11, r6
	eor r9, r9, r10
	str r7, [r8, #204]
	lsl r7, r11, #4
	orr r7, r7, r9, lsr     #28
	lsl r9, r9, #4
	str r7, [r8, #332]
	ldr r7, [r8, #80]
	orr r9, r9, r11, lsr     #28
	ldr r11, [r8, #84]
	eor r7, r7, r6
	eor r11, r11, r10
	str r9, [r8, #328]
	lsl r9, r11, #3
	orr r9, r9, r7, lsr     #29
	lsl r7, r7, #3
	orr r11, r7, r11, lsr     #29
	ldr r7, [r8, #164]
	str r11, [r8, #256]
	ldr r11, [r8, #120]
	str r9, [r8, #260]
	ldr r9, [r8, #124]
	eor r11, r11, r6
	eor r9, r9, r10
	eor r10, r7, r10
	lsl r7, r11, #9
	orr r7, r7, r9, lsr     #23
	lsl r9, r9, #9
	orr r9, r9, r11, lsr     #23
	lsl r11, r10, #18
	str r7, [r8, #388]
	ldr r7, [r8, #160]
	eor r7, r7, r6
	ldr r6, [r8, #448]
	str r9, [r8, #384]
	lsl r9, r7, #18
	orr r10, r9, r10, lsr     #14
	ldr r9, [r8, #8]
	str r10, [r8, #312]
	ldr r10, [r8, #12]
	orr r11, r11, r7, lsr     #14
	ldr r7, [r8, #452]
	eor r9, r9, r6
	eor r10, r10, r7
	str r11, [r8, #316]
	lsl r11, r9, #1
	orr r11, r11, r10, lsr       #31
	lsl r10, r10, #1
	str r11, [r8, #280]
	ldr r11, [r8, #52]
	orr r9, r10, r9, lsr     #31
	ldr r10, [r8, #48]
	eor r11, r11, r7
	eor r10, r10, r6
	str r9, [r8, #284]
	lsl r9, r10, #12
	orr r9, r9, r11, lsr     #20
	lsl r11, r11, #12
	orr r10, r11, r10, lsr     #20
	ldr r11, [r8, #88]
	str r9, [r8, #212]
	ldr r9, [r8, #92]
	eor r11, r11, r6
	eor r9, r9, r7
	str r10, [r8, #208]
	lsl r10, r11, #10
	orr r10, r10, r9, lsr     #22
	lsl r9, r9, #10
	orr r9, r9, r11, lsr     #22
	ldr r11, [r8, #132]
	str r10, [r8, #336]
	ldr r10, [r8, #128]
	eor r11, r11, r7
	eor r10, r10, r6
	str r9, [r8, #340]
	lsl r9, r10, #13
	orr r9, r9, r11, lsr     #19
	lsl r11, r11, #13
	str r9, [r8, #268]
	orr r9, r11, r10, lsr     #19
	str r9, [r8, #264]
	ldr r10, [r8, #168]
	eor r9, r10, r6
	ldr r10, [r8, #172]
	eor r6, r10, r7
	lsl r10, r9, #2
	lsl r7, r6, #2
	ldr r11, [r8, #20]
	orr r6, r10, r6, lsr     #30
	ldr r10, [r8, #460]
	orr r9, r7, r9, lsr     #30
	ldr r7, [r8, #456]
	str r6, [r8, #392]
	ldr r6, [r8, #16]
	eor r6, r6, r7
	eor r11, r11, r10
	str r9, [r8, #396]
	lsl r9, r6, #30
	orr r9, r9, r11, lsr     #2
	lsl r11, r11, #30
	str r9, [r8, #364]
	ldr r9, [r8, #56]
	orr r11, r11, r6, lsr     #2
	ldr r6, [r8, #60]
	eor r6, r6, r10
	eor r9, r9, r7
	str r11, [r8, #360]
	lsl r11, r9, #6
	orr r11, r11, r6, lsr     #26
	lsl r6, r6, #6
	orr r9, r6, r9, lsr     #26
	ldr r6, [r8, #100]
	str r9, [r8, #292]
	ldr r9, [r8, #96]
	eor r9, r9, r7
	eor r6, r6, r10
	str r11, [r8, #288]
	lsl r11, r9, #11
	orr r11, r11, r6, lsr     #21
	lsl r6, r6, #11
	str r11, [r8, #220]
	orr r9, r6, r9, lsr     #21
	str r9, [r8, #216]
	ldr r11, [r8, #136]
	ldr r9, [r8, #140]
	eor r6, r11, r7
	ldr r11, [r8, #176]
	eor r9, r9, r10
	eor r7, r11, r7
	lsl r11, r6, #15
	orr r11, r11, r9, lsr     #17
	lsl r9, r9, #15
	orr r9, r9, r6, lsr     #17
	ldr r6, [r8, #180]
	str r9, [r8, #348]
	eor r6, r6, r10
	str r11, [r8, #344]
	lsl r10, r6, #29
	lsl r11, r7, #29
	ldr r9, [r8, #464]
	orr r11, r11, r6, lsr       #3
	ldr r6, [r8, #28]
	orr r7, r10, r7, lsr       #3
	ldr r10, [r8, #468]
	str r11, [r8, #276]
	ldr r11, [r8, #24]
	eor r6, r6, r10
	eor r11, r11, r9
	str r7, [r8, #272]
	lsl r7, r11, #28
	orr r7, r7, r6, lsr     #4
	lsl r6, r6, #28
	str r7, [r8, #240]
	ldr r7, [r8, #64]
	orr r6, r6, r11, lsr     #4
	ldr r11, [r8, #68]
	eor r11, r11, r10
	eor r7, r7, r9
	str r6, [r8, #244]
	lsl r6, r7, #23
	orr r6, r6, r11, lsr     #9
	lsl r11, r11, #23
	orr r11, r11, r7, lsr     #9
	ldr r7, [r8, #108]
	str r6, [r8, #372]
	ldr r6, [r8, #104]
	eor r7, r7, r10
	eor r6, r6, r9
	str r11, [r8, #368]
	lsl r11, r6, #25
	orr r11, r11, r7, lsr     #7
	lsl r7, r7, #25
	orr r7, r7, r6, lsr     #7
	ldr r6, [r8, #148]
	str r11, [r8, #296]
	eor r11, r6, r10
	ldr r6, [r8, #144]
	str r7, [r8, #300]
	ldr r7, [r8, #188]
	eor r6, r6, r9
	eor r10, r7, r10
	lsl r7, r11, #21
	orr r7, r7, r6, lsr     #11
	lsl r6, r6, #21
	orr r11, r6, r11, lsr     #11
	ldr r6, [r8, #184]
	str r7, [r8, #228]
	eor r9, r6, r9
	str r11, [r8, #224]
	lsl r11, r10, #24
	ldr r6, [r8, #472]
	orr r7, r11, r9, lsr     #8
	ldr r11, [r8, #36]
	lsl r9, r9, #24
	orr r9, r9, r10, lsr     #8
	ldr r10, [r8, #32]
	str r7, [r8, #352]
	ldr r7, [r8, #476]
	eor r11, r11, r7
	eor r10, r10, r6
	str r9, [r8, #356]
	lsl r9, r10, #27
	orr r9, r9, r11, lsr     #5
	lsl r11, r11, #27
	str r9, [r8, #320]
	ldr r9, [r8, #72]
	orr r11, r11, r10, lsr     #5
	ldr r10, [r8, #76]
	eor r10, r10, r7
	eor r9, r9, r6
	str r11, [r8, #324]
	lsl r11, r9, #20
	orr r11, r11, r10, lsr     #12
	lsl r10, r10, #20
	str r11, [r8, #248]
	ldr r11, [r8, #112]
	orr r9, r10, r9, lsr     #12
	ldr r10, [r8, #116]
	eor r11, r11, r6
	eor r10, r10, r7
	str r9, [r8, #252]
	lsl r9, r10, #7
	orr r9, r9, r11, lsr     #25
	lsl r11, r11, #7
	orr r10, r11, r10, lsr     #25
	ldr r11, [r8, #156]
	str r10, [r8, #380]
	ldr r10, [r8, #152]
	eor r10, r10, r6
	eor r11, r11, r7
	str r9, [r8, #376]
	lsl r9, r10, #8
	orr r9, r9, r11, lsr     #24
	lsl r11, r11, #8
	str r9, [r8, #304]
	orr r11, r11, r10, lsr       #24
	ldr r9, [r8, #192]
	str r11, [r8, #308]
	ldr r10, [r8, #196]
	eor r11, r9, r6
	eor r7, r10, r7
	lsl r10, r11, #14
	ldr r9, [r8, #200]
	orr r10, r10, r7, lsr     #18
	lsl r7, r7, #14
	str r10, [r8, #232]
	orr r10, r7, r11, lsr     #18
	str r10, [r8, #236]
	ldr r11, [r8, #208]
	ldr r10, [r8, #216]
	bic r6, r10, r11
	ldr r7, [r8, #224]
	eor r9, r6, r9
	bic r6, r7, r10
	str r9, [r8, #0]
	eor r11, r6, r11
	str r11, [r8, #8]
	ldr r11, [r8, #232]
	bic r6, r11, r7
	ldr r9, [r8, #200]
	eor r6, r6, r10
	bic r10, r9, r11
	str r6, [r8, #16]
	eor r7, r10, r7
	str r7, [r8, #24]
	ldr r6, [r8, #208]
	bic r6, r6, r9
	ldr r10, [r8, #204]
	eor r9, r6, r11
	ldr r7, [r8, #212]
	str r9, [r8, #32]
	ldr r6, [r8, #220]
	bic r9, r6, r7
	ldr r11, [r8, #228]
	eor r10, r9, r10
	bic r9, r11, r6
	str r10, [r8, #4]
	eor r7, r9, r7
	str r7, [r8, #12]
	ldr r7, [r8, #236]
	bic r9, r7, r11
	ldr r10, [r8, #204]
	eor r6, r9, r6
	bic r9, r10, r7
	str r6, [r8, #20]
	eor r6, r9, r11
	str r6, [r8, #28]
	ldr r9, [r8, #212]
	bic r6, r9, r10
	ldr r11, [r8, #240]
	eor r9, r6, r7
	ldr r6, [r8, #248]
	str r9, [r8, #36]
	ldr r10, [r8, #256]
	bic r9, r10, r6
	ldr r7, [r8, #264]
	eor r9, r9, r11
	bic r11, r7, r10
	str r9, [r8, #40]
	eor r6, r11, r6
	str r6, [r8, #48]
	ldr r9, [r8, #272]
	bic r6, r9, r7
	ldr r11, [r8, #240]
	eor r10, r6, r10
	bic r6, r11, r9
	str r10, [r8, #56]
	eor r6, r6, r7
	str r6, [r8, #64]
	ldr r7, [r8, #248]
	bic r6, r7, r11
	ldr r10, [r8, #244]
	eor r9, r6, r9
	ldr r7, [r8, #252]
	str r9, [r8, #72]
	ldr r6, [r8, #260]
	bic r11, r6, r7
	ldr r9, [r8, #268]
	eor r10, r11, r10
	bic r11, r9, r6
	str r10, [r8, #44]
	eor r7, r11, r7
	str r7, [r8, #52]
	ldr r10, [r8, #276]
	bic r7, r10, r9
	ldr r11, [r8, #244]
	eor r6, r7, r6
	bic r7, r11, r10
	str r6, [r8, #60]
	eor r7, r7, r9
	str r7, [r8, #68]
	ldr r6, [r8, #252]
	bic r9, r6, r11
	ldr r11, [r8, #280]
	eor r7, r9, r10
	ldr r9, [r8, #288]
	str r7, [r8, #76]
	ldr r6, [r8, #296]
	bic r10, r6, r9
	ldr r7, [r8, #304]
	eor r11, r10, r11
	bic r10, r7, r6
	str r11, [r8, #80]
	eor r9, r10, r9
	str r9, [r8, #88]
	ldr r11, [r8, #312]
	bic r9, r11, r7
	ldr r10, [r8, #280]
	eor r6, r9, r6
	bic r9, r10, r11
	str r6, [r8, #96]
	eor r6, r9, r7
	str r6, [r8, #104]
	ldr r7, [r8, #288]
	bic r9, r7, r10
	ldr r6, [r8, #284]
	eor r11, r9, r11
	ldr r10, [r8, #292]
	str r11, [r8, #112]
	ldr r7, [r8, #300]
	bic r9, r7, r10
	ldr r11, [r8, #308]
	eor r9, r9, r6
	bic r6, r11, r7
	str r9, [r8, #84]
	eor r10, r6, r10
	str r10, [r8, #92]
	ldr r6, [r8, #316]
	bic r9, r6, r11
	ldr r10, [r8, #284]
	eor r9, r9, r7
	bic r7, r10, r6
	str r9, [r8, #100]
	eor r11, r7, r11
	str r11, [r8, #108]
	ldr r9, [r8, #292]
	bic r11, r9, r10
	ldr r9, [r8, #320]
	eor r6, r11, r6
	ldr r11, [r8, #328]
	str r6, [r8, #116]
	ldr r6, [r8, #336]
	bic r10, r6, r11
	ldr r7, [r8, #344]
	eor r9, r10, r9
	bic r10, r7, r6
	str r9, [r8, #120]
	eor r10, r10, r11
	str r10, [r8, #128]
	ldr r11, [r8, #352]
	bic r9, r11, r7
	ldr r10, [r8, #320]
	eor r6, r9, r6
	bic r9, r10, r11
	str r6, [r8, #136]
	eor r9, r9, r7
	str r9, [r8, #144]
	ldr r7, [r8, #328]
	bic r7, r7, r10
	ldr r9, [r8, #324]
	eor r6, r7, r11
	ldr r7, [r8, #332]
	str r6, [r8, #152]
	ldr r6, [r8, #340]
	bic r11, r6, r7
	ldr r10, [r8, #348]
	eor r11, r11, r9
	bic r9, r10, r6
	str r11, [r8, #124]
	eor r9, r9, r7
	str r9, [r8, #132]
	ldr r7, [r8, #356]
	bic r9, r7, r10
	ldr r11, [r8, #324]
	eor r9, r9, r6
	bic r6, r11, r7
	str r9, [r8, #140]
	eor r10, r6, r10
	str r10, [r8, #148]
	ldr r9, [r8, #332]
	bic r10, r9, r11
	ldr r9, [r8, #360]
	eor r6, r10, r7
	str r6, [r8, #156]
	ldr r11, [r8, #0]
	eor r6, r11, #1
	ldr r7, [r8, #376]
	str r6, [r8, #0]
	ldr r10, [r8, #368]
	bic r11, r7, r10
	ldr r6, [r8, #384]
	eor r9, r11, r9
	bic r11, r6, r7
	str r9, [r8, #160]
	ldr r9, [r8, #392]
	eor r10, r11, r10
	ldr r11, [r8, #360]
	str r10, [r8, #168]
	bic r10, r9, r6
	eor r7, r10, r7
	bic r10, r11, r9
	str r7, [r8, #176]
	eor r7, r10, r6
	str r7, [r8, #184]
	ldr r6, [r8, #368]
	bic r6, r6, r11
	ldr r10, [r8, #372]
	eor r7, r6, r9
	ldr r6, [r8, #388]
	ldr r11, [r8, #380]
	str r7, [r8, #192]
	ldr r9, [r8, #364]
	bic r7, r11, r10
	eor r9, r7, r9
	bic r7, r6, r11
	eor r7, r7, r10
	ldr r10, [r8, #364]
	str r7, [r8, #172]
	ldr r7, [r8, #396]
	str r9, [r8, #164]
	bic r9, r7, r6
	eor r9, r9, r11
	bic r11, r10, r7
	str r9, [r8, #180]
	ldr r9, [r8, #372]
	eor r11, r11, r6
	bic r6, r9, r10
	str r11, [r8, #188]
	eor r9, r6, r7
	str r9, [r8, #196]
	ldr r0, [r12, #240]
	subs r0, r0, #1
	str r0, [r12, #240]
	bne 1b
	pop {r4-r11, pc}

