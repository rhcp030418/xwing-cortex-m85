// 실험 C: fiat carry_mul (실전 필드 곱) + Keccak round6 — 순차 연접
// A=486 instrs, B=644 instrs
start:
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
end:
