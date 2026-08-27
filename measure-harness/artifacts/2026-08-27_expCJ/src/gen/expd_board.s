.text
.syntax unified
.thumb

// expd_seq: counter=[r12,#376]
.global expd_seq
.type expd_seq, %function
.thumb_func
.balign 16
expd_seq:
	push {r4-r11, lr}
	movw r8, #:lower16:g_theta_state
	movt r8, #:upper16:g_theta_state
	movw r12, #:lower16:g_spill
	movt r12, #:upper16:g_spill
	str r0, [r12, #376]
.balign 16
1:
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	ldr	r2, [r1, #36]
	mov	r6, r2
	ldr	r2, [lr, #8]
	mov	r9, #38
	str r2, [r12, #0]
	ldr	r2, [r1, #32]
	str r0, [r12, #4]
	mov	r0, r2
	ldr	r3, [lr, #12]
	ldr	r5, [lr, #4]
	add	r11, r3, r3, lsl #3
	add	r11, r3, r11, lsl #1
	ldr r2, [r12, #0]
	mul	r4, r9, r5
	str r5, [r12, #8]
	umull	r11, r5, r11, r0
	add	r10, r2, r2, lsl #3
	add	r10, r2, r10, lsl #1
	umlal	r11, r5, r6, r10
	umull	r10, r2, r10, r0
	str r1, [r12, #12]
	ldr	r1, [lr, #16]
	str r6, [r12, #16]
	umlal	r10, r2, r6, r4
	add	r6, r1, r1, lsl #3
	mul	r7, r9, r3
	add	r6, r1, r6, lsl #1
	str r1, [r12, #20]
	ldr r1, [r12, #12]
	ldr	r4, [lr, #20]
	str r3, [r12, #24]
	ldr	r3, [r1, #28]
	str r7, [r12, #28]
	umlal	r10, r2, r7, r3
	mov	r7, r4
	mul	r9, r9, r7
	ldr	r1, [lr, #24]
	add	r4, r4, r4, lsl #3
	add	r4, r7, r4, lsl #1
	str r7, [r12, #32]
	add	r7, r1, r1, lsl #3
	str r9, [r12, #36]
	umlal	r11, r5, r6, r3
	add	r9, r1, r7, lsl #1
	str r1, [r12, #40]
	ldr r1, [r12, #12]
	str r3, [r12, #44]
	ldr	r7, [r1, #24]
	ldr r1, [r12, #16]
	umlal	r10, r2, r6, r7
	umlal	r11, r5, r4, r7
	str r7, [r12, #48]
	umull	r7, r4, r0, r4
	umlal	r7, r4, r1, r6
	ldr r3, [r12, #44]
	str r10, [r12, #52]
	umlal	r7, r4, r9, r3
	mov	r3, r1
	umull	r10, r6, r6, r0
	ldr r1, [r12, #28]
	umlal	r10, r6, r3, r1
	ldr r1, [r12, #36]
	ldr r3, [r12, #44]
	umlal	r10, r6, r1, r3
	ldr r3, [r12, #48]
	umlal	r10, r6, r9, r3
	str r6, [r12, #56]
	str r10, [r12, #60]
	ldr r1, [lr, #28]
	ldr r6, [lr, #32]
	add	r10, r1, r1, lsl #3
	add	r10, r1, r10, lsl #1
	umlal	r7, r4, r10, r3
	str r10, [r12, #64]
	mov	r10, r11
	mov	r11, #38
	str r1, [r12, #68]
	ldr r1, [r12, #12]
	ldr r3, [r12, #52]
	ldr	r1, [r1, #20]
	str r6, [r12, #72]
	ldr r6, [r12, #36]
	str r4, [r12, #76]
	umlal	r3, r2, r6, r1
	ldr r4, [r12, #68]
	str r2, [r12, #80]
	mul	r11, r11, r4
	ldr r2, [r12, #56]
	ldr r4, [r12, #60]
	str r11, [r12, #84]
	umlal	r4, r2, r11, r1
	str r4, [r12, #88]
	ldr r4, [r12, #72]
	umlal	r10, r5, r9, r1
	add	r11, r4, r4, lsl #3
	add	r11, r4, r11, lsl #1
	ldr r4, [r12, #76]
	str r1, [r12, #92]
	umlal	r7, r4, r11, r1
	str r7, [r12, #96]
	ldr	r7, [lr, #36]
	mov	r6, r2
	mov	r1, r7
	ldr	r7, [lr, #0]
	mov	lr, #38
	str r1, [r12, #100]
	mul	lr, lr, r1
	ldr r1, [r12, #12]
	ldr r2, [r12, #80]
	str r7, [r12, #104]
	ldr	r7, [r1, #16]
	str lr, [r12, #108]
	umlal	r3, r2, r9, r7
	str r3, [r12, #112]
	ldr r3, [r12, #88]
	ldr r1, [r12, #64]
	umlal	r3, r6, r11, r7
	str r7, [r12, #116]
	umlal	r10, r5, r1, r7
	umull	r7, lr, r0, r1
	str r3, [r12, #120]
	ldr r3, [r12, #16]
	str r6, [r12, #124]
	umlal	r7, lr, r3, r9
	mov	r6, r7
	ldr r1, [r12, #44]
	umull	r7, r9, r9, r0
	umlal	r6, lr, r11, r1
	str r6, [r12, #128]
	ldr r6, [r12, #36]
	str lr, [r12, #132]
	umlal	r7, r9, r3, r6
	ldr r6, [r12, #84]
	ldr r3, [r12, #116]
	umlal	r7, r9, r6, r1
	ldr r1, [r12, #48]
	ldr r6, [r12, #108]
	umlal	r7, r9, r11, r1
	ldr r1, [r12, #92]
	umlal	r7, r9, r6, r1
	mov	lr, r7
	ldr r7, [r12, #104]
	ldr r6, [r12, #100]
	umlal	lr, r9, r3, r7
	add	r7, r6, r6, lsl #3
	ldr r1, [r12, #48]
	str r9, [r12, #136]
	add	r9, r6, r7, lsl #1
	ldr r6, [r12, #128]
	ldr r7, [r12, #132]
	str lr, [r12, #140]
	umlal	r6, r7, r9, r1
	mov	lr, r7
	mov	r7, r6
	ldr r6, [r12, #96]
	ldr r1, [r12, #92]
	umlal	r6, r4, r9, r3
	str r4, [r12, #144]
	ldr r4, [r12, #104]
	str r6, [r12, #148]
	umlal	r7, lr, r1, r4
	ldr r4, [r12, #116]
	ldr r1, [r12, #8]
	umlal	r7, lr, r4, r1
	ldr r1, [r12, #12]
	ldr	r4, [r1, #12]
	ldr r1, [r12, #112]
	ldr r6, [r12, #84]
	ldr r3, [r12, #124]
	umlal	r1, r2, r6, r4
	ldr r6, [r12, #108]
	str r1, [r12, #152]
	ldr r1, [r12, #120]
	umlal	r10, r5, r11, r4
	umlal	r1, r3, r6, r4
	ldr r6, [r12, #148]
	str r3, [r12, #156]
	str r1, [r12, #160]
	ldr r3, [r12, #144]
	ldr r1, [r12, #104]
	str r5, [r12, #164]
	umlal	r6, r3, r4, r1
	mov	r5, r4
	mov	r4, r3
	mov	r3, r7
	str r6, [r12, #168]
	ldr r6, [r12, #0]
	str r5, [r12, #172]
	umlal	r3, lr, r5, r6
	ldr r5, [r12, #12]
	ldr r6, [r12, #152]
	ldr	r5, [r5, #8]
	umlal	r6, r2, r11, r5
	str r6, [r12, #176]
	str r2, [r12, #180]
	mov	r2, r5
	ldr r6, [r12, #164]
	umlal	r10, r6, r9, r5
	ldr r5, [r12, #160]
	ldr r7, [r12, #156]
	umlal	r5, r7, r2, r1
	str r7, [r12, #184]
	str r5, [r12, #188]
	ldr r7, [r12, #168]
	ldr r5, [r12, #8]
	str r6, [r12, #192]
	umlal	r7, r4, r2, r5
	mov	r6, r2
	mov	r2, r3
	str r7, [r12, #196]
	ldr r7, [r12, #24]
	str r6, [r12, #200]
	umlal	r2, lr, r6, r7
	umull	r6, r7, r0, r9
	str r2, [r12, #204]
	ldr r2, [r12, #16]
	ldr r3, [r12, #44]
	umlal	r6, r7, r2, r11
	umlal	r6, r7, r3, r1
	str r1, [r12, #208]
	ldr r1, [r12, #48]
	str r0, [r12, #212]
	umlal	r6, r7, r1, r5
	ldr r1, [r12, #92]
	ldr r5, [r12, #0]
	umlal	r6, r7, r1, r5
	ldr r1, [r12, #116]
	ldr r5, [r12, #24]
	umlal	r6, r7, r1, r5
	ldr r1, [r12, #172]
	ldr r5, [r12, #20]
	umlal	r6, r7, r1, r5
	mov	r9, r6
	ldr r5, [r12, #32]
	ldr r6, [r12, #200]
	umlal	r9, r7, r6, r5
	str r9, [r12, #216]
	umull	r9, r6, r11, r0
	str r7, [r12, #220]
	ldr r7, [r12, #84]
	umlal	r9, r6, r2, r7
	ldr r7, [r12, #108]
	ldr r2, [r12, #12]
	umlal	r9, r6, r7, r3
	ldr r11, [r2, #4]
	ldr r2, [r2, #0]
	ldr r1, [r12, #48]
	ldr r3, [r12, #208]
	str r2, [r12, #224]
	ldr r5, [r12, #176]
	ldr r2, [r12, #180]
	umlal	r5, r2, r7, r11
	mov	r0, r5
	umlal	r9, r6, r1, r3
	ldr r7, [r12, #196]
	ldr r1, [r12, #0]
	str r9, [r12, #228]
	umlal	r7, r4, r11, r1
	ldr r1, [r12, #20]
	mov	r9, r7
	ldr r7, [r12, #204]
	ldr r5, [r12, #192]
	umlal	r7, lr, r11, r1
	mov	r1, r7
	mov	r7, r0
	ldr r0, [r12, #224]
	umlal	r10, r5, r11, r3
	umlal	r7, r2, r3, r0
	str r2, [r12, #232]
	str r7, [r12, #236]
	ldr r3, [r12, #8]
	mov	r2, r0
	umlal	r10, r5, r3, r0
	str r10, [r12, #240]
	mov	r10, r4
	ldr r0, [r12, #24]
	ldr r4, [r12, #32]
	umlal	r9, r10, r0, r2
	str r9, [r12, #244]
	mov	r9, r1
	ldr r7, [r12, #220]
	umlal	r9, lr, r4, r2
	str r5, [r12, #248]
	ldr r2, [r12, #40]
	ldr r5, [r12, #216]
	str lr, [r12, #252]
	umlal	r5, r7, r11, r2
	str r9, [r12, #256]
	mov	lr, r5
	mov	r9, r7
	ldr r5, [r12, #68]
	ldr r2, [r12, #224]
	ldr r4, [r12, #92]
	umlal	lr, r9, r5, r2
	ldr r5, [r12, #228]
	str r9, [r12, #260]
	lsl	r9, r3, #1
	umlal	r5, r6, r4, r9
	mov	r1, r5
	ldr r7, [r12, #140]
	ldr r5, [r12, #136]
	ldr r4, [r12, #172]
	str r10, [r12, #264]
	umlal	r7, r5, r4, r9
	mov	r10, r1
	str lr, [r12, #268]
	mov	lr, r5
	mov	r5, r7
	ldr r4, [r12, #188]
	ldr r7, [r12, #184]
	umlal	r4, r7, r11, r9
	ldr r1, [r12, #0]
	mov	r2, r7
	ldr r7, [r12, #116]
	umlal	r10, r6, r7, r1
	mov	r7, r10
	mov	r10, r5
	ldr r5, [r12, #200]
	str r6, [r12, #272]
	umlal	r10, lr, r5, r1
	mov	r6, r4
	mov	r5, r2
	ldr r2, [r12, #224]
	umlal	r6, r5, r1, r2
	ldr r1, [r12, #212]
	str r5, [r12, #276]
	umull	r4, r5, r1, r3
	ldr r2, [r12, #16]
	str r6, [r12, #280]
	ldr r6, [r12, #208]
	umlal	r4, r5, r2, r6
	umull	r3, r1, r1, r6
	mov	r6, r2
	ldr r2, [r12, #108]
	umlal	r3, r1, r6, r2
	ldr r2, [r12, #0]
	ldr r6, [r12, #44]
	umlal	r3, r1, r6, r9
	umlal	r4, r5, r6, r2
	ldr r6, [r12, #48]
	lsl	r9, r0, #1
	umlal	r3, r1, r6, r2
	umlal	r4, r5, r6, r0
	ldr r6, [r12, #172]
	ldr r0, [r12, #272]
	umlal	r10, lr, r11, r9
	umlal	r7, r0, r6, r9
	mov	r6, r0
	ldr r0, [r12, #92]
	umlal	r3, r1, r0, r9
	mov	r2, r1
	mov	r9, r2
	ldr r1, [r12, #20]
	ldr r2, [r12, #32]
	umlal	r4, r5, r0, r1
	ldr r0, [r12, #200]
	umlal	r7, r6, r0, r1
	ldr r0, [r12, #116]
	umlal	r3, r9, r0, r1
	mov	r1, r9
	umlal	r4, r5, r0, r2
	ldr r0, [r12, #20]
	ldr r2, [r12, #224]
	umlal	r10, lr, r0, r2
	ldr r2, [r12, #32]
	ldr r0, [r12, #172]
	lsl	r9, r2, #1
	umlal	r7, r6, r11, r9
	umlal	r3, r1, r0, r9
	mov	r9, r7
	ldr r2, [r12, #40]
	ldr r7, [r12, #224]
	umlal	r4, r5, r0, r2
	ldr r0, [r12, #200]
	umlal	r9, r6, r2, r7
	umlal	r3, r1, r0, r2
	ldr r2, [r12, #68]
	str r9, [r12, #284]
	lsls	r7, r2, #1
	umlal	r3, r1, r11, r7
	mov	r9, r3
	umlal	r4, r5, r0, r2
	ldr r7, [r12, #224]
	ldr r2, [r12, #72]
	ldr r3, [r12, #100]
	umlal	r4, r5, r11, r2
	umlal	r9, r1, r2, r7
	str r9, [r12, #288]
	mov	r9, r4
	ldr r4, [r12, #236]
	ldr r2, [r12, #232]
	umlal	r9, r5, r7, r3
	ldr r7, [r12, #240]
	lsrs	r3, r4, #26
	orr	r3, r3, r2, lsl #6
	adds	r3, r7, r3
	ldr r7, [r12, #248]
	ldr r0, [r12, #280]
	adc	r2, r7, r2, lsr #26
	bic	r7, r4, #0xFC000000
	lsrs	r4, r3, #25
	orr	r4, r4, r2, lsl #7
	adds	r4, r0, r4
	str r10, [r12, #292]
	str r9, [r12, #296]
	ldr r0, [r12, #276]
	lsr	r9, r4, #26
	adc	r2, r0, r2, lsr #25
	ldr r0, [r12, #244]
	orr	r9, r9, r2, lsl #6
	adds	r9, r0, r9
	ldr r0, [r12, #264]
	lsr	r10, r9, #25
	adc	r2, r0, r2, lsr #26
	ldr r0, [r12, #292]
	orr	r10, r10, r2, lsl #7
	adds	r10, r0, r10
	adc	r2, lr, r2, lsr #25
	bic	r11, r3, #0xFE000000
	lsr	lr, r10, #26
	ldr r3, [r12, #256]
	orr	lr, lr, r2, lsl #6
	ldr r0, [r12, #4]
	adds	lr, r3, lr
	ldr r3, [r12, #252]
	bic	r9, r9, #0xFE000000
	adc	r2, r3, r2, lsr #26
	str	r9, [r0, #12]
	ldr r3, [r12, #284]
	lsr	r9, lr, #25
	orr	r9, r9, r2, lsl #7
	adds	r9, r3, r9
	adc	r2, r6, r2, lsr #25
	bic	r6, lr, #0xFE000000
	ldr r3, [r12, #268]
	str	r6, [r0, #20]
	lsr	r6, r9, #26
	orr	r6, r6, r2, lsl #6
	adds	r6, r3, r6
	ldr r3, [r12, #260]
	lsr	lr, r6, #25
	adc	r2, r3, r2, lsr #26
	ldr r3, [r12, #288]
	orr	lr, lr, r2, lsl #7
	adds	lr, r3, lr
	adc	r1, r1, r2, lsr #25
	ldr r3, [r12, #296]
	lsr	r2, lr, #26
	orr	r2, r2, r1, lsl #6
	bic	r9, r9, #0xFC000000
	str	r9, [r0, #24]
	bic	r6, r6, #0xFE000000
	adds	r9, r3, r2
	adc	r5, r5, r1, lsr #26
	bic	r2, lr, #0xFC000000
	str	r6, [r0, #28]
	lsr	r6, r9, #25
	orr	r6, r6, r5, lsl #7
	str	r2, [r0, #32]
	lsrs	r5, r5, #25
	bic	r2, r9, #0xFE000000
	str	r2, [r0, #36]
	lsls	r1, r5, #3
	lsls	r2, r6, #3
	adds	r2, r2, r6
	orr	r1, r1, r6, lsr #29
	adc	r1, r5, r1
	adds	r2, r2, r2
	adcs	r1, r1, r1
	adds	r2, r2, r6
	adc	r5, r5, r1
	adds	r2, r2, r7
	adc	r5, r5, #0
	lsrs	r1, r2, #26
	orr	r1, r1, r5, lsl #6
	add	r3, r11, r1
	bic	r4, r4, #0xFC000000
	add	r4, r4, r3, lsr #25
	bic	r10, r10, #0xFC000000
	bic	r2, r2, #0xFC000000
	bic	r3, r3, #0xFE000000
	str r2, [r0, #0]
	str r3, [r0, #4]
	str	r10, [r0, #16]
	str	r4, [r0, #8]
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
	ldr	r9, [r8, #412]
	ldr	r10, [r8, #432]
	eor	r11, r10, r9, ror #31
	str	r11, [r8, #440]
	ldr	r9, [r8, #408]
	ldr	r10, [r8, #436]
	eor	r11, r10, r9
	str	r11, [r8, #444]
	ldr	r9, [r8, #420]
	ldr	r10, [r8, #400]
	eor	r11, r10, r9, ror #31
	str	r11, [r8, #448]
	ldr	r9, [r8, #416]
	ldr	r10, [r8, #404]
	eor	r11, r10, r9
	str	r11, [r8, #452]
	ldr	r9, [r8, #428]
	ldr	r10, [r8, #408]
	eor	r11, r10, r9, ror #31
	str	r11, [r8, #456]
	ldr	r9, [r8, #424]
	ldr	r10, [r8, #412]
	eor	r11, r10, r9
	str	r11, [r8, #460]
	ldr	r9, [r8, #436]
	ldr	r10, [r8, #416]
	eor	r11, r10, r9, ror #31
	str	r11, [r8, #464]
	ldr	r9, [r8, #432]
	ldr	r10, [r8, #420]
	eor	r11, r10, r9
	str	r11, [r8, #468]
	ldr	r9, [r8, #404]
	ldr	r10, [r8, #424]
	eor	r11, r10, r9, ror #31
	str	r11, [r8, #472]
	ldr	r9, [r8, #400]
	ldr	r10, [r8, #428]
	eor	r11, r10, r9
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
	ror	r11, r9, #14
	str	r11, [r8, #328]
	ror	r11, r10, #14
	str	r11, [r8, #332]
	ldr	r9, [r8, #80]
	ldr	r10, [r8, #84]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r10, #30
	str	r11, [r8, #256]
	ror	r11, r9, #31
	str	r11, [r8, #260]
	ldr	r9, [r8, #120]
	ldr	r10, [r8, #124]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r10, #11
	str	r11, [r8, #384]
	ror	r11, r9, #12
	str	r11, [r8, #388]
	ldr	r9, [r8, #160]
	ldr	r10, [r8, #164]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r9, #23
	str	r11, [r8, #312]
	ror	r11, r10, #23
	str	r11, [r8, #316]
	ldr	r6, [r8, #448]
	ldr	r7, [r8, #452]
	ldr	r9, [r8, #8]
	ldr	r10, [r8, #12]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r10, #31
	str	r11, [r8, #280]
	str	r9, [r8, #284]
	ldr	r9, [r8, #48]
	ldr	r10, [r8, #52]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r9, #10
	str	r11, [r8, #208]
	ror	r11, r10, #10
	str	r11, [r8, #212]
	ldr	r9, [r8, #88]
	ldr	r10, [r8, #92]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r9, #27
	str	r11, [r8, #336]
	ror	r11, r10, #27
	str	r11, [r8, #340]
	ldr	r9, [r8, #128]
	ldr	r10, [r8, #132]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r10, #9
	str	r11, [r8, #264]
	ror	r11, r9, #10
	str	r11, [r8, #268]
	ldr	r9, [r8, #168]
	ldr	r10, [r8, #172]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r9, #31
	str	r11, [r8, #392]
	ror	r11, r10, #31
	str	r11, [r8, #396]
	ldr	r6, [r8, #456]
	ldr	r7, [r8, #460]
	ldr	r9, [r8, #16]
	ldr	r10, [r8, #20]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r9, #1
	str	r11, [r8, #360]
	ror	r11, r10, #1
	str	r11, [r8, #364]
	ldr	r9, [r8, #56]
	ldr	r10, [r8, #60]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r9, #29
	str	r11, [r8, #288]
	ror	r11, r10, #29
	str	r11, [r8, #292]
	ldr	r9, [r8, #96]
	ldr	r10, [r8, #100]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r10, #10
	str	r11, [r8, #216]
	ror	r11, r9, #11
	str	r11, [r8, #220]
	ldr	r9, [r8, #136]
	ldr	r10, [r8, #140]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r10, #24
	str	r11, [r8, #344]
	ror	r11, r9, #25
	str	r11, [r8, #348]
	ldr	r9, [r8, #176]
	ldr	r10, [r8, #180]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r10, #1
	str	r11, [r8, #272]
	ror	r11, r9, #2
	str	r11, [r8, #276]
	ldr	r6, [r8, #464]
	ldr	r7, [r8, #468]
	ldr	r9, [r8, #24]
	ldr	r10, [r8, #28]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r9, #18
	str	r11, [r8, #240]
	ror	r11, r10, #18
	str	r11, [r8, #244]
	ldr	r9, [r8, #64]
	ldr	r10, [r8, #68]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r10, #4
	str	r11, [r8, #368]
	ror	r11, r9, #5
	str	r11, [r8, #372]
	ldr	r9, [r8, #104]
	ldr	r10, [r8, #108]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r10, #19
	str	r11, [r8, #296]
	ror	r11, r9, #20
	str	r11, [r8, #300]
	ldr	r9, [r8, #144]
	ldr	r10, [r8, #148]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r10, #21
	str	r11, [r8, #224]
	ror	r11, r9, #22
	str	r11, [r8, #228]
	ldr	r9, [r8, #184]
	ldr	r10, [r8, #188]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r9, #4
	str	r11, [r8, #352]
	ror	r11, r10, #4
	str	r11, [r8, #356]
	ldr	r6, [r8, #472]
	ldr	r7, [r8, #476]
	ldr	r9, [r8, #32]
	ldr	r10, [r8, #36]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r10, #18
	str	r11, [r8, #320]
	ror	r11, r9, #19
	str	r11, [r8, #324]
	ldr	r9, [r8, #72]
	ldr	r10, [r8, #76]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r9, #22
	str	r11, [r8, #248]
	ror	r11, r10, #22
	str	r11, [r8, #252]
	ldr	r9, [r8, #112]
	ldr	r10, [r8, #116]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r10, #12
	str	r11, [r8, #376]
	ror	r11, r9, #13
	str	r11, [r8, #380]
	ldr	r9, [r8, #152]
	ldr	r10, [r8, #156]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r9, #28
	str	r11, [r8, #304]
	ror	r11, r10, #28
	str	r11, [r8, #308]
	ldr	r9, [r8, #192]
	ldr	r10, [r8, #196]
	eor	r9, r9, r6
	eor	r10, r10, r7
	ror	r11, r9, #25
	str	r11, [r8, #232]
	ror	r11, r10, #25
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
	ldr r0, [r12, #376]
	subs r0, r0, #1
	str r0, [r12, #376]
	bne 1b
	pop {r4-r11, pc}

// expd_slothy: counter=[r12,#376]
.global expd_slothy
.type expd_slothy, %function
.thumb_func
.balign 16
expd_slothy:
	push {r4-r11, lr}
	movw r8, #:lower16:g_theta_state
	movt r8, #:upper16:g_theta_state
	movw r12, #:lower16:g_spill
	movt r12, #:upper16:g_spill
	str r0, [r12, #376]
.balign 16
1:
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov r14, r2
	ldr r7, [r12, #0]
	ldr r2, [r14, #12]
	str r0, [r12, #4]
	mov r9, #38
	str r2, [r12, #24]
	mul r10, r9, r2
	ldr r0, [r1, #32]
	str r1, [r12, #12]
	add r5, r2, r2, lsl     #3
	mov r0, r0
	add r11, r7, r7, lsl     #3
	ldr r3, [r1, #36]
	add r6, r2, r5, lsl     #1
	add r4, r7, r11, lsl     #1
	ldr r1, [r12, #12]
	umull r2, r5, r6, r0
	ldr r6, [r1, #28]
	mov r3, r3
	ldr r1, [r14, #4]
	mul r7, r9, r1
	str r3, [r12, #16]
	umlal r2, r5, r3, r4
	str r6, [r12, #44]
	umull r4, r11, r4, r0
	str r10, [r12, #28]
	str r1, [r12, #8]
	ldr r1, [r14, #8]
	umlal r4, r11, r3, r7
	ldr r3, [r14, #20]
	ldr r7, [r14, #16]
	str r1, [r12, #0]
	umlal r4, r11, r10, r6
	str r7, [r12, #20]
	mov r10, r3
	add r1, r7, r7, lsl     #3
	add r3, r3, r3, lsl     #3
	str r10, [r12, #32]
	add r1, r7, r1, lsl     #1
	ldr r7, [r12, #12]
	umlal r2, r5, r1, r6
	ldr r6, [r7, #24]
	umlal r4, r11, r1, r6
	ldr r7, [r14, #32]
	add r3, r10, r3, lsl     #1
	mul r10, r9, r10
	umlal r2, r5, r3, r6
	str r4, [r12, #52]
	str r6, [r12, #48]
	umull r4, r6, r1, r0
	str r7, [r12, #72]
	umull r7, r3, r0, r3
	ldr r9, [r12, #16]
	str r10, [r12, #36]
	umlal r7, r3, r9, r1
	ldr r1, [r12, #28]
	mov r10, r9
	ldr r9, [r12, #44]
	umlal r4, r6, r10, r1
	ldr r1, [r14, #24]
	mov r10, r2
	ldr r2, [r12, #36]
	umlal r4, r6, r2, r9
	add r9, r1, r1, lsl     #3
	ldr r2, [r14, #28]
	str r1, [r12, #40]
	add r9, r1, r9, lsl     #1
	ldr r1, [r12, #44]
	umlal r7, r3, r9, r1
	add r1, r2, r2, lsl     #3
	str r2, [r12, #68]
	add r2, r2, r1, lsl     #1
	ldr r1, [r12, #48]
	str r2, [r12, #64]
	umlal r7, r3, r2, r1
	ldr r2, [r12, #36]
	umlal r4, r6, r9, r1
	ldr r1, [r12, #12]
	str r3, [r12, #76]
	ldr r1, [r1, #20]
	str r6, [r12, #56]
	ldr r3, [r12, #52]
	umlal r3, r11, r2, r1
	str r4, [r12, #60]
	str r11, [r12, #80]
	ldr r6, [r14, #36]
	ldr r4, [r12, #68]
	mov r6, r6
	ldr r2, [r14, #0]
	mov r14, #38
	str r2, [r12, #104]
	mov r11, #38
	ldr r2, [r12, #72]
	mul r11, r11, r4
	ldr r4, [r12, #56]
	mul r14, r14, r6
	str r6, [r12, #100]
	ldr r6, [r12, #60]
	str r11, [r12, #84]
	umlal r6, r4, r11, r1
	add r11, r2, r2, lsl     #3
	umlal r10, r5, r9, r1
	str r6, [r12, #88]
	ldr r6, [r12, #12]
	add r11, r2, r11, lsl     #1
	mov r2, r4
	ldr r6, [r6, #16]
	str r1, [r12, #92]
	ldr r4, [r12, #76]
	umlal r7, r4, r11, r1
	ldr r1, [r12, #88]
	str r14, [r12, #108]
	umlal r1, r2, r11, r6
	str r7, [r12, #96]
	ldr r7, [r12, #64]
	umlal r10, r5, r7, r6
	str r2, [r12, #124]
	umull r7, r14, r0, r7
	ldr r2, [r12, #80]
	umlal r3, r2, r9, r6
	str r1, [r12, #120]
	str r6, [r12, #116]
	umull r1, r6, r9, r0
	str r3, [r12, #112]
	ldr r3, [r12, #16]
	umlal r7, r14, r3, r9
	ldr r9, [r12, #36]
	umlal r1, r6, r3, r9
	ldr r9, [r12, #44]
	mov r3, r7
	ldr r7, [r12, #84]
	umlal r1, r6, r7, r9
	ldr r7, [r12, #100]
	umlal r3, r14, r11, r9
	ldr r9, [r12, #48]
	umlal r1, r6, r11, r9
	ldr r9, [r12, #108]
	str r3, [r12, #128]
	ldr r3, [r12, #92]
	umlal r1, r6, r9, r3
	add r9, r7, r7, lsl     #3
	ldr r3, [r12, #96]
	add r9, r7, r9, lsl     #1
	str r14, [r12, #132]
	mov r14, r1
	ldr r1, [r12, #116]
	ldr r7, [r12, #104]
	umlal r3, r4, r9, r1
	umlal r14, r6, r1, r7
	ldr r1, [r12, #48]
	str r4, [r12, #144]
	ldr r4, [r12, #132]
	str r3, [r12, #148]
	ldr r3, [r12, #128]
	umlal r3, r4, r9, r1
	ldr r7, [r12, #84]
	str r14, [r12, #140]
	ldr r1, [r12, #112]
	mov r14, r4
	ldr r4, [r12, #12]
	str r6, [r12, #136]
	ldr r4, [r4, #12]
	umlal r1, r2, r7, r4
	ldr r6, [r12, #104]
	mov r7, r3
	ldr r3, [r12, #92]
	umlal r7, r14, r3, r6
	ldr r6, [r12, #116]
	ldr r3, [r12, #8]
	umlal r7, r14, r6, r3
	ldr r3, [r12, #108]
	umlal r10, r5, r11, r4
	ldr r6, [r12, #120]
	str r1, [r12, #152]
	ldr r1, [r12, #124]
	umlal r6, r1, r3, r4
	ldr r3, [r12, #148]
	str r5, [r12, #164]
	ldr r5, [r12, #144]
	str r6, [r12, #160]
	ldr r6, [r12, #104]
	umlal r3, r5, r4, r6
	mov r4, r4
	str r1, [r12, #156]
	ldr r1, [r12, #152]
	str r3, [r12, #168]
	mov r3, r7
	str r4, [r12, #172]
	ldr r7, [r12, #0]
	umlal r3, r14, r4, r7
	ldr r7, [r12, #12]
	ldr r7, [r7, #8]
	mov r4, r5
	ldr r5, [r12, #164]
	umlal r1, r2, r11, r7
	umlal r10, r5, r9, r7
	mov r3, r3
	str r1, [r12, #176]
	mov r1, r7
	str r2, [r12, #180]
	mov r7, r1
	str r7, [r12, #200]
	ldr r2, [r12, #24]
	umlal r3, r14, r7, r2
	ldr r7, [r12, #156]
	str r5, [r12, #192]
	ldr r2, [r12, #160]
	str r3, [r12, #204]
	umlal r2, r7, r1, r6
	ldr r5, [r12, #8]
	umull r9, r3, r0, r9
	str r2, [r12, #188]
	ldr r2, [r12, #168]
	umlal r2, r4, r1, r5
	ldr r1, [r12, #16]
	str r7, [r12, #184]
	umlal r9, r3, r1, r11
	ldr r7, [r12, #44]
	str r6, [r12, #208]
	umlal r9, r3, r7, r6
	ldr r6, [r12, #48]
	str r2, [r12, #196]
	ldr r2, [r12, #0]
	umlal r9, r3, r6, r5
	ldr r6, [r12, #92]
	str r0, [r12, #212]
	ldr r5, [r12, #24]
	umlal r9, r3, r6, r2
	ldr r6, [r12, #116]
	ldr r2, [r12, #20]
	umlal r9, r3, r6, r5
	ldr r5, [r12, #12]
	ldr r6, [r12, #172]
	umlal r9, r3, r6, r2
	ldr r6, [r5, #0]
	str r6, [r12, #224]
	ldr r6, [r12, #200]
	mov r2, r9
	ldr r9, [r12, #32]
	umlal r2, r3, r6, r9
	umull r9, r6, r11, r0
	ldr r0, [r12, #176]
	ldr r11, [r12, #84]
	umlal r9, r6, r1, r11
	ldr r11, [r5, #4]
	ldr r5, [r12, #48]
	str r3, [r12, #220]
	ldr r3, [r12, #108]
	str r2, [r12, #216]
	ldr r2, [r12, #180]
	umlal r9, r6, r3, r7
	umlal r0, r2, r3, r11
	ldr r3, [r12, #208]
	umlal r9, r6, r5, r3
	ldr r7, [r12, #0]
	mov r5, r0
	ldr r1, [r12, #196]
	umlal r1, r4, r11, r7
	str r9, [r12, #228]
	ldr r0, [r12, #20]
	mov r7, r5
	ldr r9, [r12, #204]
	mov r5, r1
	umlal r9, r14, r11, r0
	ldr r0, [r12, #224]
	ldr r1, [r12, #192]
	umlal r7, r2, r3, r0
	umlal r10, r1, r11, r3
	ldr r3, [r12, #8]
	str r2, [r12, #232]
	mov r2, r0
	umlal r10, r1, r3, r0
	str r7, [r12, #236]
	mov r4, r4
	ldr r0, [r12, #24]
	mov r9, r9
	ldr r7, [r12, #32]
	str r10, [r12, #240]
	mov r9, r9
	umlal r5, r4, r0, r2
	ldr r10, [r12, #220]
	umlal r9, r14, r7, r2
	ldr r7, [r12, #224]
	str r5, [r12, #244]
	ldr r5, [r12, #216]
	str r9, [r12, #256]
	ldr r9, [r12, #40]
	str r4, [r12, #264]
	umlal r5, r10, r11, r9
	lsl r9, r3, #1
	str r14, [r12, #252]
	mov r14, r5
	ldr r4, [r12, #228]
	mov r5, r10
	ldr r10, [r12, #92]
	ldr r2, [r12, #68]
	str r1, [r12, #248]
	umlal r14, r5, r2, r7
	ldr r2, [r12, #172]
	umlal r4, r6, r10, r9
	ldr r10, [r12, #140]
	str r5, [r12, #260]
	ldr r5, [r12, #0]
	mov r1, r4
	ldr r4, [r12, #136]
	umlal r10, r4, r2, r9
	ldr r2, [r12, #188]
	mov r7, r1
	ldr r1, [r12, #184]
	str r14, [r12, #268]
	umlal r2, r1, r11, r9
	mov r14, r4
	ldr r4, [r12, #116]
	mov r2, r2
	mov r10, r10
	umlal r7, r6, r4, r5
	mov r10, r10
	ldr r4, [r12, #200]
	mov r1, r1
	umlal r10, r14, r4, r5
	ldr r4, [r12, #224]
	str r6, [r12, #272]
	mov r6, r1
	umlal r2, r6, r5, r4
	ldr r1, [r12, #212]
	umull r4, r5, r1, r3
	ldr r3, [r12, #16]
	str r6, [r12, #276]
	ldr r6, [r12, #208]
	str r2, [r12, #280]
	umlal r4, r5, r3, r6
	mov r2, r3
	umull r3, r1, r1, r6
	mov r7, r7
	ldr r6, [r12, #108]
	umlal r3, r1, r2, r6
	ldr r6, [r12, #44]
	ldr r2, [r12, #0]
	umlal r3, r1, r6, r9
	ldr r9, [r12, #272]
	umlal r4, r5, r6, r2
	ldr r6, [r12, #48]
	umlal r3, r1, r6, r2
	lsl r2, r0, #1
	umlal r4, r5, r6, r0
	ldr r0, [r12, #172]
	ldr r6, [r12, #224]
	umlal r10, r14, r11, r2
	umlal r7, r9, r0, r2
	ldr r0, [r12, #20]
	umlal r10, r14, r0, r6
	ldr r0, [r12, #92]
	mov r6, r9
	ldr r9, [r12, #20]
	str r10, [r12, #292]
	umlal r3, r1, r0, r2
	umlal r4, r5, r0, r9
	ldr r0, [r12, #32]
	mov r1, r1
	ldr r2, [r12, #116]
	mov r1, r1
	umlal r4, r5, r2, r0
	umlal r3, r1, r2, r9
	ldr r2, [r12, #32]
	ldr r0, [r12, #200]
	lsl r2, r2, #1
	umlal r7, r6, r0, r9
	ldr r0, [r12, #172]
	ldr r10, [r12, #200]
	mov r1, r1
	umlal r7, r6, r11, r2
	ldr r9, [r12, #40]
	umlal r3, r1, r0, r2
	ldr r2, [r12, #224]
	umlal r4, r5, r0, r9
	mov r0, r7
	umlal r3, r1, r10, r9
	ldr r7, [r12, #68]
	umlal r0, r6, r9, r2
	lsls r2, r7, #1
	umlal r3, r1, r11, r2
	ldr r9, [r12, #232]
	umlal r4, r5, r10, r7
	ldr r2, [r12, #100]
	ldr r7, [r12, #72]
	mov r10, r3
	umlal r4, r5, r11, r7
	ldr r11, [r12, #224]
	umlal r10, r1, r7, r11
	ldr r7, [r12, #236]
	str r0, [r12, #284]
	lsrs r3, r7, #26
	orr r3, r3, r9, lsl     #6
	ldr r0, [r12, #240]
	adds r0, r0, r3
	ldr r3, [r12, #248]
	adc r9, r3, r9, lsr     #26
	mov r3, r4
	umlal r3, r5, r11, r2
	lsrs r4, r0, #25
	orr r11, r4, r9, lsl     #7
	ldr r4, [r12, #280]
	adds r4, r4, r11
	ldr r11, [r12, #276]
	adc r11, r11, r9, lsr     #25
	str r10, [r12, #288]
	lsr r2, r4, #26
	ldr r10, [r12, #244]
	orr r9, r2, r11, lsl     #6
	adds r9, r10, r9
	ldr r2, [r12, #264]
	str r3, [r12, #296]
	adc r2, r2, r11, lsr     #26
	lsr r10, r9, #25
	ldr r3, [r12, #292]
	orr r10, r10, r2, lsl     #7
	bic r11, r0, #0xFE000000
	adds r10, r3, r10
	adc r2, r14, r2, lsr     #25
	ldr r3, [r12, #252]
	ldr r0, [r12, #256]
	lsr r14, r10, #26
	bic r7, r7, #0xFC000000
	orr r14, r14, r2, lsl       #6
	adds r14, r0, r14
	ldr r0, [r12, #4]
	bic r9, r9, #0xFE000000
	adc r2, r3, r2, lsr     #26
	str r9, [r0, #12]
	ldr r3, [r12, #284]
	lsr r9, r14, #25
	bic r4, r4, #0xFC000000
	orr r9, r9, r2, lsl     #7
	bic r10, r10, #0xFC000000
	adds r9, r3, r9
	bic r3, r14, #0xFE000000
	adc r2, r6, r2, lsr     #25
	ldr r6, [r12, #268]
	str r3, [r0, #20]
	lsr r3, r9, #26
	orr r3, r3, r2, lsl     #6
	bic r9, r9, #0xFC000000
	adds r3, r6, r3
	ldr r6, [r12, #260]
	adc r6, r6, r2, lsr     #26
	lsr r14, r3, #25
	ldr r2, [r12, #288]
	str r9, [r0, #24]
	orr r14, r14, r6, lsl     #7
	ldr r9, [r12, #296]
	adds r14, r2, r14
	bic r2, r3, #0xFE000000
	adc r3, r1, r6, lsr     #25
	lsr r1, r14, #26
	bic r6, r14, #0xFC000000
	str r2, [r0, #28]
	orr r1, r1, r3, lsl     #6
	str r6, [r0, #32]
	adds r6, r9, r1
	str r10, [r0, #16]
	adc r5, r5, r3, lsr     #26
	lsr r3, r6, #25
	lsrs r9, r5, #25
	bic r10, r6, #0xFE000000
	orr r6, r3, r5, lsl     #7
	str r10, [r0, #36]
	lsls r3, r9, #3
	lsls r10, r6, #3
	adds r1, r10, r6
	orr r2, r3, r6, lsr     #29
	adc r2, r9, r2
	adds r3, r1, r1
	adcs r2, r2, r2
	adds r6, r3, r6
	adc r1, r9, r2
	adds r3, r6, r7
	adc r5, r1, #0
	lsrs r9, r3, #26
	bic r2, r3, #0xFC000000
	ldr r6, [r8, #0]
	orr r1, r9, r5, lsl     #6
	str r2, [r0, #0]
	add r11, r11, r1
	ldr r7, [r8, #40]
	bic r3, r11, #0xFE000000
	eor r6, r6, r7
	add r4, r4, r11, lsr     #25
	str r3, [r0, #4]
	str r4, [r0, #8]
	ldr r9, [r8, #80]
	eor r10, r6, r9
	ldr r6, [r8, #120]
	eor r10, r10, r6
	ldr r6, [r8, #160]
	eor r11, r10, r6
	ldr r7, [r8, #4]
	str r11, [r8, #400]
	ldr r10, [r8, #44]
	eor r7, r7, r10
	ldr r11, [r8, #84]
	eor r9, r7, r11
	ldr r6, [r8, #124]
	eor r7, r9, r6
	ldr r6, [r8, #164]
	eor r6, r7, r6
	ldr r11, [r8, #8]
	str r6, [r8, #404]
	ldr r7, [r8, #48]
	eor r7, r11, r7
	ldr r6, [r8, #88]
	eor r7, r7, r6
	ldr r9, [r8, #128]
	eor r7, r7, r9
	ldr r10, [r8, #168]
	eor r9, r7, r10
	ldr r6, [r8, #12]
	str r9, [r8, #408]
	ldr r9, [r8, #52]
	eor r10, r6, r9
	ldr r9, [r8, #92]
	eor r6, r10, r9
	ldr r9, [r8, #132]
	eor r11, r6, r9
	ldr r7, [r8, #172]
	eor r11, r11, r7
	ldr r10, [r8, #16]
	str r11, [r8, #412]
	ldr r6, [r8, #56]
	eor r7, r10, r6
	ldr r9, [r8, #96]
	eor r11, r7, r9
	ldr r7, [r8, #136]
	eor r7, r11, r7
	ldr r10, [r8, #176]
	eor r7, r7, r10
	ldr r6, [r8, #20]
	str r7, [r8, #416]
	ldr r11, [r8, #60]
	eor r7, r6, r11
	ldr r9, [r8, #100]
	eor r10, r7, r9
	ldr r6, [r8, #140]
	eor r7, r10, r6
	ldr r6, [r8, #180]
	eor r6, r7, r6
	ldr r10, [r8, #24]
	str r6, [r8, #420]
	ldr r6, [r8, #64]
	eor r7, r10, r6
	ldr r10, [r8, #104]
	eor r10, r7, r10
	ldr r11, [r8, #144]
	eor r10, r10, r11
	ldr r6, [r8, #184]
	eor r11, r10, r6
	ldr r6, [r8, #28]
	str r11, [r8, #424]
	ldr r9, [r8, #68]
	eor r6, r6, r9
	ldr r11, [r8, #108]
	eor r11, r6, r11
	ldr r9, [r8, #148]
	eor r7, r11, r9
	ldr r11, [r8, #188]
	eor r10, r7, r11
	ldr r6, [r8, #32]
	str r10, [r8, #428]
	ldr r7, [r8, #72]
	eor r10, r6, r7
	ldr r9, [r8, #112]
	eor r11, r10, r9
	ldr r6, [r8, #152]
	eor r11, r11, r6
	ldr r6, [r8, #192]
	eor r11, r11, r6
	ldr r9, [r8, #36]
	str r11, [r8, #432]
	ldr r7, [r8, #76]
	eor r9, r9, r7
	ldr r10, [r8, #116]
	eor r7, r9, r10
	ldr r10, [r8, #156]
	eor r11, r7, r10
	ldr r6, [r8, #196]
	eor r10, r11, r6
	ldr r9, [r8, #412]
	str r10, [r8, #436]
	ldr r10, [r8, #432]
	eor r10, r10, r9, ror     #31
	ldr r11, [r8, #408]
	str r10, [r8, #440]
	ldr r7, [r8, #436]
	eor r6, r7, r11
	ldr r10, [r8, #420]
	str r6, [r8, #444]
	ldr r7, [r8, #400]
	eor r7, r7, r10, ror     #31
	ldr r11, [r8, #416]
	str r7, [r8, #448]
	ldr r6, [r8, #404]
	eor r6, r6, r11
	ldr r11, [r8, #428]
	str r6, [r8, #452]
	ldr r7, [r8, #408]
	eor r9, r7, r11, ror     #31
	ldr r10, [r8, #424]
	str r9, [r8, #456]
	ldr r6, [r8, #412]
	eor r9, r6, r10
	ldr r6, [r8, #436]
	str r9, [r8, #460]
	ldr r10, [r8, #416]
	eor r7, r10, r6, ror     #31
	ldr r6, [r8, #432]
	str r7, [r8, #464]
	ldr r11, [r8, #420]
	eor r6, r11, r6
	ldr r9, [r8, #404]
	str r6, [r8, #468]
	ldr r7, [r8, #424]
	eor r6, r7, r9, ror     #31
	ldr r10, [r8, #400]
	str r6, [r8, #472]
	ldr r11, [r8, #428]
	eor r6, r11, r10
	ldr r9, [r8, #440]
	str r6, [r8, #476]
	ldr r6, [r8, #444]
	ldr r11, [r8, #0]
	ldr r7, [r8, #4]
	eor r10, r11, r9
	eor r11, r7, r6
	str r10, [r8, #200]
	str r11, [r8, #204]
	ldr r7, [r8, #40]
	ldr r10, [r8, #44]
	eor r11, r7, r9
	eor r7, r10, r6
	ror r10, r11, #14
	str r10, [r8, #328]
	ror r11, r7, #14
	str r11, [r8, #332]
	ldr r11, [r8, #80]
	ldr r10, [r8, #84]
	eor r7, r11, r9
	eor r10, r10, r6
	ror r7, r7, #31
	ror r11, r10, #30
	str r7, [r8, #260]
	str r11, [r8, #256]
	ldr r10, [r8, #120]
	ldr r7, [r8, #124]
	eor r11, r10, r9
	eor r7, r7, r6
	ror r10, r11, #12
	ror r11, r7, #11
	str r10, [r8, #388]
	str r11, [r8, #384]
	ldr r10, [r8, #160]
	ldr r7, [r8, #164]
	eor r10, r10, r9
	eor r9, r7, r6
	ror r6, r10, #23
	str r6, [r8, #312]
	ldr r6, [r8, #448]
	ror r10, r9, #23
	ldr r7, [r8, #452]
	str r10, [r8, #316]
	ldr r11, [r8, #8]
	ldr r10, [r8, #12]
	eor r11, r11, r6
	eor r9, r10, r7
	str r11, [r8, #284]
	ror r10, r9, #31
	ldr r9, [r8, #48]
	str r10, [r8, #280]
	ldr r11, [r8, #52]
	eor r9, r9, r6
	eor r11, r11, r7
	ror r9, r9, #10
	str r9, [r8, #208]
	ror r10, r11, #10
	str r10, [r8, #212]
	ldr r10, [r8, #88]
	ldr r11, [r8, #92]
	eor r9, r10, r6
	eor r10, r11, r7
	ror r9, r9, #27
	str r9, [r8, #336]
	ror r10, r10, #27
	str r10, [r8, #340]
	ldr r10, [r8, #128]
	ldr r9, [r8, #132]
	eor r11, r10, r6
	eor r9, r9, r7
	ror r11, r11, #10
	ror r9, r9, #9
	str r11, [r8, #268]
	str r9, [r8, #264]
	ldr r10, [r8, #168]
	ldr r9, [r8, #172]
	eor r6, r10, r6
	eor r7, r9, r7
	ror r11, r6, #31
	str r11, [r8, #392]
	ldr r6, [r8, #456]
	ror r11, r7, #31
	ldr r10, [r8, #460]
	str r11, [r8, #396]
	ldr r11, [r8, #16]
	ldr r9, [r8, #20]
	eor r11, r11, r6
	eor r7, r9, r10
	ror r11, r11, #1
	str r11, [r8, #360]
	ror r7, r7, #1
	str r7, [r8, #364]
	ldr r11, [r8, #56]
	ldr r9, [r8, #60]
	eor r11, r11, r6
	eor r9, r9, r10
	ror r11, r11, #29
	str r11, [r8, #288]
	ror r7, r9, #29
	str r7, [r8, #292]
	ldr r9, [r8, #96]
	ldr r7, [r8, #100]
	eor r9, r9, r6
	eor r7, r7, r10
	ror r9, r9, #11
	ror r11, r7, #10
	str r9, [r8, #220]
	str r11, [r8, #216]
	ldr r7, [r8, #136]
	ldr r11, [r8, #140]
	eor r9, r7, r6
	eor r7, r11, r10
	ror r11, r9, #25
	ror r9, r7, #24
	str r11, [r8, #348]
	str r9, [r8, #344]
	ldr r7, [r8, #176]
	ldr r9, [r8, #180]
	eor r11, r7, r6
	eor r7, r9, r10
	ror r11, r11, #2
	ror r7, r7, #1
	ldr r6, [r8, #464]
	str r7, [r8, #272]
	ldr r7, [r8, #468]
	str r11, [r8, #276]
	ldr r9, [r8, #24]
	ldr r10, [r8, #28]
	eor r11, r9, r6
	eor r10, r10, r7
	ror r11, r11, #18
	str r11, [r8, #240]
	ror r10, r10, #18
	str r10, [r8, #244]
	ldr r10, [r8, #68]
	ldr r9, [r8, #64]
	eor r10, r10, r7
	eor r9, r9, r6
	ror r10, r10, #4
	str r10, [r8, #368]
	ror r11, r9, #5
	str r11, [r8, #372]
	ldr r9, [r8, #104]
	ldr r11, [r8, #108]
	eor r10, r9, r6
	eor r11, r11, r7
	ror r9, r10, #20
	ror r10, r11, #19
	str r9, [r8, #300]
	str r10, [r8, #296]
	ldr r10, [r8, #144]
	ldr r11, [r8, #148]
	eor r9, r10, r6
	eor r10, r11, r7
	ror r11, r9, #22
	ror r9, r10, #21
	str r11, [r8, #228]
	str r9, [r8, #224]
	ldr r9, [r8, #184]
	ldr r11, [r8, #188]
	eor r9, r9, r6
	eor r10, r11, r7
	ror r6, r9, #4
	str r6, [r8, #352]
	ldr r9, [r8, #472]
	ror r10, r10, #4
	ldr r6, [r8, #476]
	str r10, [r8, #356]
	ldr r11, [r8, #32]
	ldr r7, [r8, #36]
	eor r10, r11, r9
	eor r7, r7, r6
	ror r10, r10, #19
	ror r11, r7, #18
	str r10, [r8, #324]
	str r11, [r8, #320]
	ldr r10, [r8, #72]
	ldr r7, [r8, #76]
	eor r10, r10, r9
	eor r11, r7, r6
	ror r10, r10, #22
	str r10, [r8, #248]
	ror r7, r11, #22
	str r7, [r8, #252]
	ldr r7, [r8, #112]
	ldr r10, [r8, #116]
	eor r7, r7, r9
	eor r10, r10, r6
	ror r11, r7, #13
	ror r10, r10, #12
	str r11, [r8, #380]
	str r10, [r8, #376]
	ldr r11, [r8, #152]
	ldr r10, [r8, #156]
	eor r7, r11, r9
	eor r10, r10, r6
	ror r11, r7, #28
	str r11, [r8, #304]
	ror r11, r10, #28
	str r11, [r8, #308]
	ldr r7, [r8, #192]
	ldr r11, [r8, #196]
	eor r9, r7, r9
	eor r10, r11, r6
	ror r6, r9, #25
	str r6, [r8, #232]
	ldr r11, [r8, #200]
	ror r9, r10, #25
	ldr r6, [r8, #208]
	str r9, [r8, #236]
	ldr r7, [r8, #216]
	bic r10, r7, r6
	ldr r9, [r8, #224]
	eor r10, r10, r11
	bic r11, r9, r7
	str r10, [r8, #0]
	ldr r10, [r8, #232]
	eor r11, r11, r6
	bic r6, r10, r9
	str r11, [r8, #8]
	eor r11, r6, r7
	ldr r7, [r8, #200]
	str r11, [r8, #16]
	bic r11, r7, r10
	eor r6, r11, r9
	ldr r9, [r8, #208]
	str r6, [r8, #24]
	bic r9, r9, r7
	eor r6, r9, r10
	ldr r11, [r8, #212]
	str r6, [r8, #32]
	ldr r9, [r8, #220]
	ldr r6, [r8, #204]
	bic r7, r9, r11
	eor r6, r7, r6
	ldr r10, [r8, #228]
	str r6, [r8, #4]
	bic r6, r10, r9
	eor r6, r6, r11
	ldr r11, [r8, #236]
	str r6, [r8, #12]
	bic r6, r11, r10
	eor r6, r6, r9
	ldr r7, [r8, #204]
	str r6, [r8, #20]
	bic r6, r7, r11
	eor r9, r6, r10
	ldr r6, [r8, #212]
	str r9, [r8, #28]
	bic r10, r6, r7
	eor r9, r10, r11
	ldr r7, [r8, #248]
	str r9, [r8, #36]
	ldr r6, [r8, #256]
	ldr r9, [r8, #240]
	bic r11, r6, r7
	eor r11, r11, r9
	ldr r10, [r8, #264]
	str r11, [r8, #40]
	bic r11, r10, r6
	eor r9, r11, r7
	ldr r7, [r8, #272]
	str r9, [r8, #48]
	bic r9, r7, r10
	eor r11, r9, r6
	ldr r9, [r8, #240]
	str r11, [r8, #56]
	bic r11, r9, r7
	eor r6, r11, r10
	ldr r11, [r8, #248]
	str r6, [r8, #64]
	bic r6, r11, r9
	eor r9, r6, r7
	ldr r11, [r8, #252]
	str r9, [r8, #72]
	ldr r6, [r8, #260]
	ldr r10, [r8, #244]
	bic r7, r6, r11
	eor r7, r7, r10
	ldr r9, [r8, #268]
	str r7, [r8, #44]
	bic r10, r9, r6
	eor r11, r10, r11
	ldr r10, [r8, #276]
	str r11, [r8, #52]
	bic r7, r10, r9
	eor r6, r7, r6
	ldr r7, [r8, #244]
	str r6, [r8, #60]
	bic r6, r7, r10
	eor r6, r6, r9
	ldr r9, [r8, #252]
	str r6, [r8, #68]
	bic r7, r9, r7
	eor r7, r7, r10
	ldr r6, [r8, #288]
	str r7, [r8, #76]
	ldr r11, [r8, #296]
	ldr r10, [r8, #280]
	bic r9, r11, r6
	eor r10, r9, r10
	ldr r9, [r8, #304]
	str r10, [r8, #80]
	bic r10, r9, r11
	eor r6, r10, r6
	ldr r10, [r8, #312]
	str r6, [r8, #88]
	bic r6, r10, r9
	eor r6, r6, r11
	ldr r11, [r8, #280]
	str r6, [r8, #96]
	bic r7, r11, r10
	eor r6, r7, r9
	ldr r9, [r8, #288]
	str r6, [r8, #104]
	bic r6, r9, r11
	eor r11, r6, r10
	ldr r9, [r8, #292]
	str r11, [r8, #112]
	ldr r7, [r8, #300]
	ldr r11, [r8, #284]
	bic r10, r7, r9
	eor r11, r10, r11
	ldr r6, [r8, #308]
	str r11, [r8, #84]
	bic r11, r6, r7
	eor r10, r11, r9
	ldr r9, [r8, #316]
	str r10, [r8, #92]
	bic r11, r9, r6
	eor r7, r11, r7
	ldr r10, [r8, #284]
	str r7, [r8, #100]
	bic r7, r10, r9
	eor r6, r7, r6
	ldr r7, [r8, #292]
	str r6, [r8, #108]
	bic r7, r7, r10
	eor r10, r7, r9
	ldr r11, [r8, #328]
	str r10, [r8, #116]
	ldr r10, [r8, #336]
	ldr r7, [r8, #320]
	bic r9, r10, r11
	eor r9, r9, r7
	ldr r7, [r8, #344]
	str r9, [r8, #120]
	bic r6, r7, r10
	eor r9, r6, r11
	ldr r6, [r8, #352]
	str r9, [r8, #128]
	bic r11, r6, r7
	eor r10, r11, r10
	ldr r9, [r8, #320]
	str r10, [r8, #136]
	bic r11, r9, r6
	eor r11, r11, r7
	ldr r10, [r8, #328]
	str r11, [r8, #144]
	bic r11, r10, r9
	eor r6, r11, r6
	ldr r9, [r8, #332]
	str r6, [r8, #152]
	ldr r6, [r8, #340]
	ldr r11, [r8, #324]
	bic r7, r6, r9
	eor r7, r7, r11
	ldr r11, [r8, #348]
	str r7, [r8, #124]
	bic r10, r11, r6
	eor r7, r10, r9
	ldr r10, [r8, #356]
	str r7, [r8, #132]
	bic r7, r10, r11
	eor r9, r7, r6
	ldr r6, [r8, #324]
	str r9, [r8, #140]
	bic r9, r6, r10
	eor r9, r9, r11
	ldr r7, [r8, #332]
	str r9, [r8, #148]
	bic r7, r7, r6
	eor r9, r7, r10
	ldr r10, [r8, #368]
	str r9, [r8, #156]
	ldr r11, [r8, #376]
	ldr r6, [r8, #360]
	bic r7, r11, r10
	eor r6, r7, r6
	ldr r9, [r8, #384]
	str r6, [r8, #160]
	bic r7, r9, r11
	ldr r6, [r8, #392]
	eor r7, r7, r10
	bic r10, r6, r9
	eor r10, r10, r11
	ldr r11, [r8, #360]
	str r10, [r8, #176]
	ldr r10, [r8, #368]
	str r7, [r8, #168]
	bic r7, r11, r6
	eor r7, r7, r9
	bic r10, r10, r11
	eor r6, r10, r6
	ldr r9, [r8, #364]
	str r6, [r8, #192]
	ldr r10, [r8, #372]
	str r7, [r8, #184]
	ldr r11, [r8, #380]
	bic r6, r11, r10
	eor r9, r6, r9
	ldr r7, [r8, #388]
	str r9, [r8, #164]
	bic r6, r7, r11
	eor r6, r6, r10
	ldr r10, [r8, #396]
	str r6, [r8, #172]
	bic r6, r10, r7
	eor r11, r6, r11
	ldr r9, [r8, #364]
	str r11, [r8, #180]
	ldr r11, [r8, #372]
	bic r6, r9, r10
	bic r11, r11, r9
	eor r7, r6, r7
	eor r6, r11, r10
	ldr r9, [r8, #0]
	str r6, [r8, #196]
	str r7, [r8, #188]
	eor r9, r9, #1
	str r9, [r8, #0]
	ldr r0, [r12, #376]
	subs r0, r0, #1
	str r0, [r12, #376]
	bne 1b
	pop {r4-r11, pc}

