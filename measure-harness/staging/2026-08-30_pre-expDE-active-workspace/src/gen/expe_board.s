.text
.syntax unified
.thumb

// expe_seq: counter=[r12,#1272]
.global expe_seq
.type expe_seq, %function
.thumb_func
.balign 16
expe_seq:
	push {r4-r11, lr}
	movw r8, #:lower16:g_theta_state
	movt r8, #:upper16:g_theta_state
	movw r12, #:lower16:g_spill
	movt r12, #:upper16:g_spill
	str r0, [r12, #1272]
.balign 16
1:
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	str r0, [r12, #0]
	str r1, [r12, #4]
	str r2, [r12, #8]
	mov	lr, r2
	ldr	r2, [r1, #36]
	mov	r6, r2
	ldr	r2, [lr, #8]
	mov	r9, #38
	str r2, [r12, #12]
	ldr	r2, [r1, #32]
	str r0, [r12, #16]
	mov	r0, r2
	ldr	r3, [lr, #12]
	ldr	r5, [lr, #4]
	add	r11, r3, r3, lsl #3
	add	r11, r3, r11, lsl #1
	ldr r2, [r12, #12]
	mul	r4, r9, r5
	str r5, [r12, #20]
	umull	r11, r5, r11, r0
	add	r10, r2, r2, lsl #3
	add	r10, r2, r10, lsl #1
	umlal	r11, r5, r6, r10
	umull	r10, r2, r10, r0
	str r1, [r12, #24]
	ldr	r1, [lr, #16]
	str r6, [r12, #28]
	umlal	r10, r2, r6, r4
	add	r6, r1, r1, lsl #3
	mul	r7, r9, r3
	add	r6, r1, r6, lsl #1
	str r1, [r12, #32]
	ldr r1, [r12, #24]
	ldr	r4, [lr, #20]
	str r3, [r12, #36]
	ldr	r3, [r1, #28]
	str r7, [r12, #40]
	umlal	r10, r2, r7, r3
	mov	r7, r4
	mul	r9, r9, r7
	ldr	r1, [lr, #24]
	add	r4, r4, r4, lsl #3
	add	r4, r7, r4, lsl #1
	str r7, [r12, #44]
	add	r7, r1, r1, lsl #3
	str r9, [r12, #48]
	umlal	r11, r5, r6, r3
	add	r9, r1, r7, lsl #1
	str r1, [r12, #52]
	ldr r1, [r12, #24]
	str r3, [r12, #56]
	ldr	r7, [r1, #24]
	ldr r1, [r12, #28]
	umlal	r10, r2, r6, r7
	umlal	r11, r5, r4, r7
	str r7, [r12, #60]
	umull	r7, r4, r0, r4
	umlal	r7, r4, r1, r6
	ldr r3, [r12, #56]
	str r10, [r12, #64]
	umlal	r7, r4, r9, r3
	mov	r3, r1
	umull	r10, r6, r6, r0
	ldr r1, [r12, #40]
	umlal	r10, r6, r3, r1
	ldr r1, [r12, #48]
	ldr r3, [r12, #56]
	umlal	r10, r6, r1, r3
	ldr r3, [r12, #60]
	umlal	r10, r6, r9, r3
	str r6, [r12, #68]
	str r10, [r12, #72]
	ldr r1, [lr, #28]
	ldr r6, [lr, #32]
	add	r10, r1, r1, lsl #3
	add	r10, r1, r10, lsl #1
	umlal	r7, r4, r10, r3
	str r10, [r12, #76]
	mov	r10, r11
	mov	r11, #38
	str r1, [r12, #80]
	ldr r1, [r12, #24]
	ldr r3, [r12, #64]
	ldr	r1, [r1, #20]
	str r6, [r12, #84]
	ldr r6, [r12, #48]
	str r4, [r12, #88]
	umlal	r3, r2, r6, r1
	ldr r4, [r12, #80]
	str r2, [r12, #92]
	mul	r11, r11, r4
	ldr r2, [r12, #68]
	ldr r4, [r12, #72]
	str r11, [r12, #96]
	umlal	r4, r2, r11, r1
	str r4, [r12, #100]
	ldr r4, [r12, #84]
	umlal	r10, r5, r9, r1
	add	r11, r4, r4, lsl #3
	add	r11, r4, r11, lsl #1
	ldr r4, [r12, #88]
	str r1, [r12, #104]
	umlal	r7, r4, r11, r1
	str r7, [r12, #108]
	ldr	r7, [lr, #36]
	mov	r6, r2
	mov	r1, r7
	ldr	r7, [lr, #0]
	mov	lr, #38
	str r1, [r12, #112]
	mul	lr, lr, r1
	ldr r1, [r12, #24]
	ldr r2, [r12, #92]
	str r7, [r12, #116]
	ldr	r7, [r1, #16]
	str lr, [r12, #120]
	umlal	r3, r2, r9, r7
	str r3, [r12, #124]
	ldr r3, [r12, #100]
	ldr r1, [r12, #76]
	umlal	r3, r6, r11, r7
	str r7, [r12, #128]
	umlal	r10, r5, r1, r7
	umull	r7, lr, r0, r1
	str r3, [r12, #132]
	ldr r3, [r12, #28]
	str r6, [r12, #136]
	umlal	r7, lr, r3, r9
	mov	r6, r7
	ldr r1, [r12, #56]
	umull	r7, r9, r9, r0
	umlal	r6, lr, r11, r1
	str r6, [r12, #140]
	ldr r6, [r12, #48]
	str lr, [r12, #144]
	umlal	r7, r9, r3, r6
	ldr r6, [r12, #96]
	ldr r3, [r12, #128]
	umlal	r7, r9, r6, r1
	ldr r1, [r12, #60]
	ldr r6, [r12, #120]
	umlal	r7, r9, r11, r1
	ldr r1, [r12, #104]
	umlal	r7, r9, r6, r1
	mov	lr, r7
	ldr r7, [r12, #116]
	ldr r6, [r12, #112]
	umlal	lr, r9, r3, r7
	add	r7, r6, r6, lsl #3
	ldr r1, [r12, #60]
	str r9, [r12, #148]
	add	r9, r6, r7, lsl #1
	ldr r6, [r12, #140]
	ldr r7, [r12, #144]
	str lr, [r12, #152]
	umlal	r6, r7, r9, r1
	mov	lr, r7
	mov	r7, r6
	ldr r6, [r12, #108]
	ldr r1, [r12, #104]
	umlal	r6, r4, r9, r3
	str r4, [r12, #156]
	ldr r4, [r12, #116]
	str r6, [r12, #160]
	umlal	r7, lr, r1, r4
	ldr r4, [r12, #128]
	ldr r1, [r12, #20]
	umlal	r7, lr, r4, r1
	ldr r1, [r12, #24]
	ldr	r4, [r1, #12]
	ldr r1, [r12, #124]
	ldr r6, [r12, #96]
	ldr r3, [r12, #136]
	umlal	r1, r2, r6, r4
	ldr r6, [r12, #120]
	str r1, [r12, #164]
	ldr r1, [r12, #132]
	umlal	r10, r5, r11, r4
	umlal	r1, r3, r6, r4
	ldr r6, [r12, #160]
	str r3, [r12, #168]
	str r1, [r12, #172]
	ldr r3, [r12, #156]
	ldr r1, [r12, #116]
	str r5, [r12, #176]
	umlal	r6, r3, r4, r1
	mov	r5, r4
	mov	r4, r3
	mov	r3, r7
	str r6, [r12, #180]
	ldr r6, [r12, #12]
	str r5, [r12, #184]
	umlal	r3, lr, r5, r6
	ldr r5, [r12, #24]
	ldr r6, [r12, #164]
	ldr	r5, [r5, #8]
	umlal	r6, r2, r11, r5
	str r6, [r12, #188]
	str r2, [r12, #192]
	mov	r2, r5
	ldr r6, [r12, #176]
	umlal	r10, r6, r9, r5
	ldr r5, [r12, #172]
	ldr r7, [r12, #168]
	umlal	r5, r7, r2, r1
	str r7, [r12, #196]
	str r5, [r12, #200]
	ldr r7, [r12, #180]
	ldr r5, [r12, #20]
	str r6, [r12, #204]
	umlal	r7, r4, r2, r5
	mov	r6, r2
	mov	r2, r3
	str r7, [r12, #208]
	ldr r7, [r12, #36]
	str r6, [r12, #212]
	umlal	r2, lr, r6, r7
	umull	r6, r7, r0, r9
	str r2, [r12, #216]
	ldr r2, [r12, #28]
	ldr r3, [r12, #56]
	umlal	r6, r7, r2, r11
	umlal	r6, r7, r3, r1
	str r1, [r12, #220]
	ldr r1, [r12, #60]
	str r0, [r12, #224]
	umlal	r6, r7, r1, r5
	ldr r1, [r12, #104]
	ldr r5, [r12, #12]
	umlal	r6, r7, r1, r5
	ldr r1, [r12, #128]
	ldr r5, [r12, #36]
	umlal	r6, r7, r1, r5
	ldr r1, [r12, #184]
	ldr r5, [r12, #32]
	umlal	r6, r7, r1, r5
	mov	r9, r6
	ldr r5, [r12, #44]
	ldr r6, [r12, #212]
	umlal	r9, r7, r6, r5
	str r9, [r12, #228]
	umull	r9, r6, r11, r0
	str r7, [r12, #232]
	ldr r7, [r12, #96]
	umlal	r9, r6, r2, r7
	ldr r7, [r12, #120]
	ldr r2, [r12, #24]
	umlal	r9, r6, r7, r3
	ldr r11, [r2, #4]
	ldr r2, [r2, #0]
	ldr r1, [r12, #60]
	ldr r3, [r12, #220]
	str r2, [r12, #236]
	ldr r5, [r12, #188]
	ldr r2, [r12, #192]
	umlal	r5, r2, r7, r11
	mov	r0, r5
	umlal	r9, r6, r1, r3
	ldr r7, [r12, #208]
	ldr r1, [r12, #12]
	str r9, [r12, #240]
	umlal	r7, r4, r11, r1
	ldr r1, [r12, #32]
	mov	r9, r7
	ldr r7, [r12, #216]
	ldr r5, [r12, #204]
	umlal	r7, lr, r11, r1
	mov	r1, r7
	mov	r7, r0
	ldr r0, [r12, #236]
	umlal	r10, r5, r11, r3
	umlal	r7, r2, r3, r0
	str r2, [r12, #244]
	str r7, [r12, #248]
	ldr r3, [r12, #20]
	mov	r2, r0
	umlal	r10, r5, r3, r0
	str r10, [r12, #252]
	mov	r10, r4
	ldr r0, [r12, #36]
	ldr r4, [r12, #44]
	umlal	r9, r10, r0, r2
	str r9, [r12, #256]
	mov	r9, r1
	ldr r7, [r12, #232]
	umlal	r9, lr, r4, r2
	str r5, [r12, #260]
	ldr r2, [r12, #52]
	ldr r5, [r12, #228]
	str lr, [r12, #264]
	umlal	r5, r7, r11, r2
	str r9, [r12, #268]
	mov	lr, r5
	mov	r9, r7
	ldr r5, [r12, #80]
	ldr r2, [r12, #236]
	ldr r4, [r12, #104]
	umlal	lr, r9, r5, r2
	ldr r5, [r12, #240]
	str r9, [r12, #272]
	lsl	r9, r3, #1
	umlal	r5, r6, r4, r9
	mov	r1, r5
	ldr r7, [r12, #152]
	ldr r5, [r12, #148]
	ldr r4, [r12, #184]
	str r10, [r12, #276]
	umlal	r7, r5, r4, r9
	mov	r10, r1
	str lr, [r12, #280]
	mov	lr, r5
	mov	r5, r7
	ldr r4, [r12, #200]
	ldr r7, [r12, #196]
	umlal	r4, r7, r11, r9
	ldr r1, [r12, #12]
	mov	r2, r7
	ldr r7, [r12, #128]
	umlal	r10, r6, r7, r1
	mov	r7, r10
	mov	r10, r5
	ldr r5, [r12, #212]
	str r6, [r12, #284]
	umlal	r10, lr, r5, r1
	mov	r6, r4
	mov	r5, r2
	ldr r2, [r12, #236]
	umlal	r6, r5, r1, r2
	ldr r1, [r12, #224]
	str r5, [r12, #288]
	umull	r4, r5, r1, r3
	ldr r2, [r12, #28]
	str r6, [r12, #292]
	ldr r6, [r12, #220]
	umlal	r4, r5, r2, r6
	umull	r3, r1, r1, r6
	mov	r6, r2
	ldr r2, [r12, #120]
	umlal	r3, r1, r6, r2
	ldr r2, [r12, #12]
	ldr r6, [r12, #56]
	umlal	r3, r1, r6, r9
	umlal	r4, r5, r6, r2
	ldr r6, [r12, #60]
	lsl	r9, r0, #1
	umlal	r3, r1, r6, r2
	umlal	r4, r5, r6, r0
	ldr r6, [r12, #184]
	ldr r0, [r12, #284]
	umlal	r10, lr, r11, r9
	umlal	r7, r0, r6, r9
	mov	r6, r0
	ldr r0, [r12, #104]
	umlal	r3, r1, r0, r9
	mov	r2, r1
	mov	r9, r2
	ldr r1, [r12, #32]
	ldr r2, [r12, #44]
	umlal	r4, r5, r0, r1
	ldr r0, [r12, #212]
	umlal	r7, r6, r0, r1
	ldr r0, [r12, #128]
	umlal	r3, r9, r0, r1
	mov	r1, r9
	umlal	r4, r5, r0, r2
	ldr r0, [r12, #32]
	ldr r2, [r12, #236]
	umlal	r10, lr, r0, r2
	ldr r2, [r12, #44]
	ldr r0, [r12, #184]
	lsl	r9, r2, #1
	umlal	r7, r6, r11, r9
	umlal	r3, r1, r0, r9
	mov	r9, r7
	ldr r2, [r12, #52]
	ldr r7, [r12, #236]
	umlal	r4, r5, r0, r2
	ldr r0, [r12, #212]
	umlal	r9, r6, r2, r7
	umlal	r3, r1, r0, r2
	ldr r2, [r12, #80]
	str r9, [r12, #296]
	lsls	r7, r2, #1
	umlal	r3, r1, r11, r7
	mov	r9, r3
	umlal	r4, r5, r0, r2
	ldr r7, [r12, #236]
	ldr r2, [r12, #84]
	ldr r3, [r12, #112]
	umlal	r4, r5, r11, r2
	umlal	r9, r1, r2, r7
	str r9, [r12, #300]
	mov	r9, r4
	ldr r4, [r12, #248]
	ldr r2, [r12, #244]
	umlal	r9, r5, r7, r3
	ldr r7, [r12, #252]
	lsrs	r3, r4, #26
	orr	r3, r3, r2, lsl #6
	adds	r3, r7, r3
	ldr r7, [r12, #260]
	ldr r0, [r12, #292]
	adc	r2, r7, r2, lsr #26
	bic	r7, r4, #0xFC000000
	lsrs	r4, r3, #25
	orr	r4, r4, r2, lsl #7
	adds	r4, r0, r4
	str r10, [r12, #304]
	str r9, [r12, #308]
	ldr r0, [r12, #288]
	lsr	r9, r4, #26
	adc	r2, r0, r2, lsr #25
	ldr r0, [r12, #256]
	orr	r9, r9, r2, lsl #6
	adds	r9, r0, r9
	ldr r0, [r12, #276]
	lsr	r10, r9, #25
	adc	r2, r0, r2, lsr #26
	ldr r0, [r12, #304]
	orr	r10, r10, r2, lsl #7
	adds	r10, r0, r10
	adc	r2, lr, r2, lsr #25
	bic	r11, r3, #0xFE000000
	lsr	lr, r10, #26
	ldr r3, [r12, #268]
	orr	lr, lr, r2, lsl #6
	ldr r0, [r12, #16]
	adds	lr, r3, lr
	ldr r3, [r12, #264]
	bic	r9, r9, #0xFE000000
	adc	r2, r3, r2, lsr #26
	str	r9, [r0, #12]
	ldr r3, [r12, #296]
	lsr	r9, lr, #25
	orr	r9, r9, r2, lsl #7
	adds	r9, r3, r9
	adc	r2, r6, r2, lsr #25
	bic	r6, lr, #0xFE000000
	ldr r3, [r12, #280]
	str	r6, [r0, #20]
	lsr	r6, r9, #26
	orr	r6, r6, r2, lsl #6
	adds	r6, r3, r6
	ldr r3, [r12, #272]
	lsr	lr, r6, #25
	adc	r2, r3, r2, lsr #26
	ldr r3, [r12, #300]
	orr	lr, lr, r2, lsl #7
	adds	lr, r3, lr
	adc	r1, r1, r2, lsr #25
	ldr r3, [r12, #308]
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
	ldr r0, [r12, #0]
	ldr r1, [r12, #4]
	ldr r2, [r12, #8]
	mov	lr, r2
	ldr	r2, [r1, #36]
	mov	r6, r2
	ldr	r2, [lr, #8]
	mov	r9, #38
	str r2, [r12, #312]
	ldr	r2, [r1, #32]
	str r0, [r12, #316]
	mov	r0, r2
	ldr	r3, [lr, #12]
	ldr	r5, [lr, #4]
	add	r11, r3, r3, lsl #3
	add	r11, r3, r11, lsl #1
	ldr r2, [r12, #312]
	mul	r4, r9, r5
	str r5, [r12, #320]
	umull	r11, r5, r11, r0
	add	r10, r2, r2, lsl #3
	add	r10, r2, r10, lsl #1
	umlal	r11, r5, r6, r10
	umull	r10, r2, r10, r0
	str r1, [r12, #324]
	ldr	r1, [lr, #16]
	str r6, [r12, #328]
	umlal	r10, r2, r6, r4
	add	r6, r1, r1, lsl #3
	mul	r7, r9, r3
	add	r6, r1, r6, lsl #1
	str r1, [r12, #332]
	ldr r1, [r12, #324]
	ldr	r4, [lr, #20]
	str r3, [r12, #336]
	ldr	r3, [r1, #28]
	str r7, [r12, #340]
	umlal	r10, r2, r7, r3
	mov	r7, r4
	mul	r9, r9, r7
	ldr	r1, [lr, #24]
	add	r4, r4, r4, lsl #3
	add	r4, r7, r4, lsl #1
	str r7, [r12, #344]
	add	r7, r1, r1, lsl #3
	str r9, [r12, #348]
	umlal	r11, r5, r6, r3
	add	r9, r1, r7, lsl #1
	str r1, [r12, #352]
	ldr r1, [r12, #324]
	str r3, [r12, #356]
	ldr	r7, [r1, #24]
	ldr r1, [r12, #328]
	umlal	r10, r2, r6, r7
	umlal	r11, r5, r4, r7
	str r7, [r12, #360]
	umull	r7, r4, r0, r4
	umlal	r7, r4, r1, r6
	ldr r3, [r12, #356]
	str r10, [r12, #364]
	umlal	r7, r4, r9, r3
	mov	r3, r1
	umull	r10, r6, r6, r0
	ldr r1, [r12, #340]
	umlal	r10, r6, r3, r1
	ldr r1, [r12, #348]
	ldr r3, [r12, #356]
	umlal	r10, r6, r1, r3
	ldr r3, [r12, #360]
	umlal	r10, r6, r9, r3
	str r6, [r12, #368]
	str r10, [r12, #372]
	ldr r1, [lr, #28]
	ldr r6, [lr, #32]
	add	r10, r1, r1, lsl #3
	add	r10, r1, r10, lsl #1
	umlal	r7, r4, r10, r3
	str r10, [r12, #376]
	mov	r10, r11
	mov	r11, #38
	str r1, [r12, #380]
	ldr r1, [r12, #324]
	ldr r3, [r12, #364]
	ldr	r1, [r1, #20]
	str r6, [r12, #384]
	ldr r6, [r12, #348]
	str r4, [r12, #388]
	umlal	r3, r2, r6, r1
	ldr r4, [r12, #380]
	str r2, [r12, #392]
	mul	r11, r11, r4
	ldr r2, [r12, #368]
	ldr r4, [r12, #372]
	str r11, [r12, #396]
	umlal	r4, r2, r11, r1
	str r4, [r12, #400]
	ldr r4, [r12, #384]
	umlal	r10, r5, r9, r1
	add	r11, r4, r4, lsl #3
	add	r11, r4, r11, lsl #1
	ldr r4, [r12, #388]
	str r1, [r12, #404]
	umlal	r7, r4, r11, r1
	str r7, [r12, #408]
	ldr	r7, [lr, #36]
	mov	r6, r2
	mov	r1, r7
	ldr	r7, [lr, #0]
	mov	lr, #38
	str r1, [r12, #412]
	mul	lr, lr, r1
	ldr r1, [r12, #324]
	ldr r2, [r12, #392]
	str r7, [r12, #416]
	ldr	r7, [r1, #16]
	str lr, [r12, #420]
	umlal	r3, r2, r9, r7
	str r3, [r12, #424]
	ldr r3, [r12, #400]
	ldr r1, [r12, #376]
	umlal	r3, r6, r11, r7
	str r7, [r12, #428]
	umlal	r10, r5, r1, r7
	umull	r7, lr, r0, r1
	str r3, [r12, #432]
	ldr r3, [r12, #328]
	str r6, [r12, #436]
	umlal	r7, lr, r3, r9
	mov	r6, r7
	ldr r1, [r12, #356]
	umull	r7, r9, r9, r0
	umlal	r6, lr, r11, r1
	str r6, [r12, #440]
	ldr r6, [r12, #348]
	str lr, [r12, #444]
	umlal	r7, r9, r3, r6
	ldr r6, [r12, #396]
	ldr r3, [r12, #428]
	umlal	r7, r9, r6, r1
	ldr r1, [r12, #360]
	ldr r6, [r12, #420]
	umlal	r7, r9, r11, r1
	ldr r1, [r12, #404]
	umlal	r7, r9, r6, r1
	mov	lr, r7
	ldr r7, [r12, #416]
	ldr r6, [r12, #412]
	umlal	lr, r9, r3, r7
	add	r7, r6, r6, lsl #3
	ldr r1, [r12, #360]
	str r9, [r12, #448]
	add	r9, r6, r7, lsl #1
	ldr r6, [r12, #440]
	ldr r7, [r12, #444]
	str lr, [r12, #452]
	umlal	r6, r7, r9, r1
	mov	lr, r7
	mov	r7, r6
	ldr r6, [r12, #408]
	ldr r1, [r12, #404]
	umlal	r6, r4, r9, r3
	str r4, [r12, #456]
	ldr r4, [r12, #416]
	str r6, [r12, #460]
	umlal	r7, lr, r1, r4
	ldr r4, [r12, #428]
	ldr r1, [r12, #320]
	umlal	r7, lr, r4, r1
	ldr r1, [r12, #324]
	ldr	r4, [r1, #12]
	ldr r1, [r12, #424]
	ldr r6, [r12, #396]
	ldr r3, [r12, #436]
	umlal	r1, r2, r6, r4
	ldr r6, [r12, #420]
	str r1, [r12, #464]
	ldr r1, [r12, #432]
	umlal	r10, r5, r11, r4
	umlal	r1, r3, r6, r4
	ldr r6, [r12, #460]
	str r3, [r12, #468]
	str r1, [r12, #472]
	ldr r3, [r12, #456]
	ldr r1, [r12, #416]
	str r5, [r12, #476]
	umlal	r6, r3, r4, r1
	mov	r5, r4
	mov	r4, r3
	mov	r3, r7
	str r6, [r12, #480]
	ldr r6, [r12, #312]
	str r5, [r12, #484]
	umlal	r3, lr, r5, r6
	ldr r5, [r12, #324]
	ldr r6, [r12, #464]
	ldr	r5, [r5, #8]
	umlal	r6, r2, r11, r5
	str r6, [r12, #488]
	str r2, [r12, #492]
	mov	r2, r5
	ldr r6, [r12, #476]
	umlal	r10, r6, r9, r5
	ldr r5, [r12, #472]
	ldr r7, [r12, #468]
	umlal	r5, r7, r2, r1
	str r7, [r12, #496]
	str r5, [r12, #500]
	ldr r7, [r12, #480]
	ldr r5, [r12, #320]
	str r6, [r12, #504]
	umlal	r7, r4, r2, r5
	mov	r6, r2
	mov	r2, r3
	str r7, [r12, #508]
	ldr r7, [r12, #336]
	str r6, [r12, #512]
	umlal	r2, lr, r6, r7
	umull	r6, r7, r0, r9
	str r2, [r12, #516]
	ldr r2, [r12, #328]
	ldr r3, [r12, #356]
	umlal	r6, r7, r2, r11
	umlal	r6, r7, r3, r1
	str r1, [r12, #520]
	ldr r1, [r12, #360]
	str r0, [r12, #524]
	umlal	r6, r7, r1, r5
	ldr r1, [r12, #404]
	ldr r5, [r12, #312]
	umlal	r6, r7, r1, r5
	ldr r1, [r12, #428]
	ldr r5, [r12, #336]
	umlal	r6, r7, r1, r5
	ldr r1, [r12, #484]
	ldr r5, [r12, #332]
	umlal	r6, r7, r1, r5
	mov	r9, r6
	ldr r5, [r12, #344]
	ldr r6, [r12, #512]
	umlal	r9, r7, r6, r5
	str r9, [r12, #528]
	umull	r9, r6, r11, r0
	str r7, [r12, #532]
	ldr r7, [r12, #396]
	umlal	r9, r6, r2, r7
	ldr r7, [r12, #420]
	ldr r2, [r12, #324]
	umlal	r9, r6, r7, r3
	ldr r11, [r2, #4]
	ldr r2, [r2, #0]
	ldr r1, [r12, #360]
	ldr r3, [r12, #520]
	str r2, [r12, #536]
	ldr r5, [r12, #488]
	ldr r2, [r12, #492]
	umlal	r5, r2, r7, r11
	mov	r0, r5
	umlal	r9, r6, r1, r3
	ldr r7, [r12, #508]
	ldr r1, [r12, #312]
	str r9, [r12, #540]
	umlal	r7, r4, r11, r1
	ldr r1, [r12, #332]
	mov	r9, r7
	ldr r7, [r12, #516]
	ldr r5, [r12, #504]
	umlal	r7, lr, r11, r1
	mov	r1, r7
	mov	r7, r0
	ldr r0, [r12, #536]
	umlal	r10, r5, r11, r3
	umlal	r7, r2, r3, r0
	str r2, [r12, #544]
	str r7, [r12, #548]
	ldr r3, [r12, #320]
	mov	r2, r0
	umlal	r10, r5, r3, r0
	str r10, [r12, #552]
	mov	r10, r4
	ldr r0, [r12, #336]
	ldr r4, [r12, #344]
	umlal	r9, r10, r0, r2
	str r9, [r12, #556]
	mov	r9, r1
	ldr r7, [r12, #532]
	umlal	r9, lr, r4, r2
	str r5, [r12, #560]
	ldr r2, [r12, #352]
	ldr r5, [r12, #528]
	str lr, [r12, #564]
	umlal	r5, r7, r11, r2
	str r9, [r12, #568]
	mov	lr, r5
	mov	r9, r7
	ldr r5, [r12, #380]
	ldr r2, [r12, #536]
	ldr r4, [r12, #404]
	umlal	lr, r9, r5, r2
	ldr r5, [r12, #540]
	str r9, [r12, #572]
	lsl	r9, r3, #1
	umlal	r5, r6, r4, r9
	mov	r1, r5
	ldr r7, [r12, #452]
	ldr r5, [r12, #448]
	ldr r4, [r12, #484]
	str r10, [r12, #576]
	umlal	r7, r5, r4, r9
	mov	r10, r1
	str lr, [r12, #580]
	mov	lr, r5
	mov	r5, r7
	ldr r4, [r12, #500]
	ldr r7, [r12, #496]
	umlal	r4, r7, r11, r9
	ldr r1, [r12, #312]
	mov	r2, r7
	ldr r7, [r12, #428]
	umlal	r10, r6, r7, r1
	mov	r7, r10
	mov	r10, r5
	ldr r5, [r12, #512]
	str r6, [r12, #584]
	umlal	r10, lr, r5, r1
	mov	r6, r4
	mov	r5, r2
	ldr r2, [r12, #536]
	umlal	r6, r5, r1, r2
	ldr r1, [r12, #524]
	str r5, [r12, #588]
	umull	r4, r5, r1, r3
	ldr r2, [r12, #328]
	str r6, [r12, #592]
	ldr r6, [r12, #520]
	umlal	r4, r5, r2, r6
	umull	r3, r1, r1, r6
	mov	r6, r2
	ldr r2, [r12, #420]
	umlal	r3, r1, r6, r2
	ldr r2, [r12, #312]
	ldr r6, [r12, #356]
	umlal	r3, r1, r6, r9
	umlal	r4, r5, r6, r2
	ldr r6, [r12, #360]
	lsl	r9, r0, #1
	umlal	r3, r1, r6, r2
	umlal	r4, r5, r6, r0
	ldr r6, [r12, #484]
	ldr r0, [r12, #584]
	umlal	r10, lr, r11, r9
	umlal	r7, r0, r6, r9
	mov	r6, r0
	ldr r0, [r12, #404]
	umlal	r3, r1, r0, r9
	mov	r2, r1
	mov	r9, r2
	ldr r1, [r12, #332]
	ldr r2, [r12, #344]
	umlal	r4, r5, r0, r1
	ldr r0, [r12, #512]
	umlal	r7, r6, r0, r1
	ldr r0, [r12, #428]
	umlal	r3, r9, r0, r1
	mov	r1, r9
	umlal	r4, r5, r0, r2
	ldr r0, [r12, #332]
	ldr r2, [r12, #536]
	umlal	r10, lr, r0, r2
	ldr r2, [r12, #344]
	ldr r0, [r12, #484]
	lsl	r9, r2, #1
	umlal	r7, r6, r11, r9
	umlal	r3, r1, r0, r9
	mov	r9, r7
	ldr r2, [r12, #352]
	ldr r7, [r12, #536]
	umlal	r4, r5, r0, r2
	ldr r0, [r12, #512]
	umlal	r9, r6, r2, r7
	umlal	r3, r1, r0, r2
	ldr r2, [r12, #380]
	str r9, [r12, #596]
	lsls	r7, r2, #1
	umlal	r3, r1, r11, r7
	mov	r9, r3
	umlal	r4, r5, r0, r2
	ldr r7, [r12, #536]
	ldr r2, [r12, #384]
	ldr r3, [r12, #412]
	umlal	r4, r5, r11, r2
	umlal	r9, r1, r2, r7
	str r9, [r12, #600]
	mov	r9, r4
	ldr r4, [r12, #548]
	ldr r2, [r12, #544]
	umlal	r9, r5, r7, r3
	ldr r7, [r12, #552]
	lsrs	r3, r4, #26
	orr	r3, r3, r2, lsl #6
	adds	r3, r7, r3
	ldr r7, [r12, #560]
	ldr r0, [r12, #592]
	adc	r2, r7, r2, lsr #26
	bic	r7, r4, #0xFC000000
	lsrs	r4, r3, #25
	orr	r4, r4, r2, lsl #7
	adds	r4, r0, r4
	str r10, [r12, #604]
	str r9, [r12, #608]
	ldr r0, [r12, #588]
	lsr	r9, r4, #26
	adc	r2, r0, r2, lsr #25
	ldr r0, [r12, #556]
	orr	r9, r9, r2, lsl #6
	adds	r9, r0, r9
	ldr r0, [r12, #576]
	lsr	r10, r9, #25
	adc	r2, r0, r2, lsr #26
	ldr r0, [r12, #604]
	orr	r10, r10, r2, lsl #7
	adds	r10, r0, r10
	adc	r2, lr, r2, lsr #25
	bic	r11, r3, #0xFE000000
	lsr	lr, r10, #26
	ldr r3, [r12, #568]
	orr	lr, lr, r2, lsl #6
	ldr r0, [r12, #316]
	adds	lr, r3, lr
	ldr r3, [r12, #564]
	bic	r9, r9, #0xFE000000
	adc	r2, r3, r2, lsr #26
	str	r9, [r0, #12]
	ldr r3, [r12, #596]
	lsr	r9, lr, #25
	orr	r9, r9, r2, lsl #7
	adds	r9, r3, r9
	adc	r2, r6, r2, lsr #25
	bic	r6, lr, #0xFE000000
	ldr r3, [r12, #580]
	str	r6, [r0, #20]
	lsr	r6, r9, #26
	orr	r6, r6, r2, lsl #6
	adds	r6, r3, r6
	ldr r3, [r12, #572]
	lsr	lr, r6, #25
	adc	r2, r3, r2, lsr #26
	ldr r3, [r12, #600]
	orr	lr, lr, r2, lsl #7
	adds	lr, r3, lr
	adc	r1, r1, r2, lsr #25
	ldr r3, [r12, #608]
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
	ldr r0, [r12, #0]
	ldr r1, [r12, #4]
	ldr r2, [r12, #8]
	mov	lr, r2
	ldr	r2, [r1, #36]
	mov	r6, r2
	ldr	r2, [lr, #8]
	mov	r9, #38
	str r2, [r12, #612]
	ldr	r2, [r1, #32]
	str r0, [r12, #616]
	mov	r0, r2
	ldr	r3, [lr, #12]
	ldr	r5, [lr, #4]
	add	r11, r3, r3, lsl #3
	add	r11, r3, r11, lsl #1
	ldr r2, [r12, #612]
	mul	r4, r9, r5
	str r5, [r12, #620]
	umull	r11, r5, r11, r0
	add	r10, r2, r2, lsl #3
	add	r10, r2, r10, lsl #1
	umlal	r11, r5, r6, r10
	umull	r10, r2, r10, r0
	str r1, [r12, #624]
	ldr	r1, [lr, #16]
	str r6, [r12, #628]
	umlal	r10, r2, r6, r4
	add	r6, r1, r1, lsl #3
	mul	r7, r9, r3
	add	r6, r1, r6, lsl #1
	str r1, [r12, #632]
	ldr r1, [r12, #624]
	ldr	r4, [lr, #20]
	str r3, [r12, #636]
	ldr	r3, [r1, #28]
	str r7, [r12, #640]
	umlal	r10, r2, r7, r3
	mov	r7, r4
	mul	r9, r9, r7
	ldr	r1, [lr, #24]
	add	r4, r4, r4, lsl #3
	add	r4, r7, r4, lsl #1
	str r7, [r12, #644]
	add	r7, r1, r1, lsl #3
	str r9, [r12, #648]
	umlal	r11, r5, r6, r3
	add	r9, r1, r7, lsl #1
	str r1, [r12, #652]
	ldr r1, [r12, #624]
	str r3, [r12, #656]
	ldr	r7, [r1, #24]
	ldr r1, [r12, #628]
	umlal	r10, r2, r6, r7
	umlal	r11, r5, r4, r7
	str r7, [r12, #660]
	umull	r7, r4, r0, r4
	umlal	r7, r4, r1, r6
	ldr r3, [r12, #656]
	str r10, [r12, #664]
	umlal	r7, r4, r9, r3
	mov	r3, r1
	umull	r10, r6, r6, r0
	ldr r1, [r12, #640]
	umlal	r10, r6, r3, r1
	ldr r1, [r12, #648]
	ldr r3, [r12, #656]
	umlal	r10, r6, r1, r3
	ldr r3, [r12, #660]
	umlal	r10, r6, r9, r3
	str r6, [r12, #668]
	str r10, [r12, #672]
	ldr r1, [lr, #28]
	ldr r6, [lr, #32]
	add	r10, r1, r1, lsl #3
	add	r10, r1, r10, lsl #1
	umlal	r7, r4, r10, r3
	str r10, [r12, #676]
	mov	r10, r11
	mov	r11, #38
	str r1, [r12, #680]
	ldr r1, [r12, #624]
	ldr r3, [r12, #664]
	ldr	r1, [r1, #20]
	str r6, [r12, #684]
	ldr r6, [r12, #648]
	str r4, [r12, #688]
	umlal	r3, r2, r6, r1
	ldr r4, [r12, #680]
	str r2, [r12, #692]
	mul	r11, r11, r4
	ldr r2, [r12, #668]
	ldr r4, [r12, #672]
	str r11, [r12, #696]
	umlal	r4, r2, r11, r1
	str r4, [r12, #700]
	ldr r4, [r12, #684]
	umlal	r10, r5, r9, r1
	add	r11, r4, r4, lsl #3
	add	r11, r4, r11, lsl #1
	ldr r4, [r12, #688]
	str r1, [r12, #704]
	umlal	r7, r4, r11, r1
	str r7, [r12, #708]
	ldr	r7, [lr, #36]
	mov	r6, r2
	mov	r1, r7
	ldr	r7, [lr, #0]
	mov	lr, #38
	str r1, [r12, #712]
	mul	lr, lr, r1
	ldr r1, [r12, #624]
	ldr r2, [r12, #692]
	str r7, [r12, #716]
	ldr	r7, [r1, #16]
	str lr, [r12, #720]
	umlal	r3, r2, r9, r7
	str r3, [r12, #724]
	ldr r3, [r12, #700]
	ldr r1, [r12, #676]
	umlal	r3, r6, r11, r7
	str r7, [r12, #728]
	umlal	r10, r5, r1, r7
	umull	r7, lr, r0, r1
	str r3, [r12, #732]
	ldr r3, [r12, #628]
	str r6, [r12, #736]
	umlal	r7, lr, r3, r9
	mov	r6, r7
	ldr r1, [r12, #656]
	umull	r7, r9, r9, r0
	umlal	r6, lr, r11, r1
	str r6, [r12, #740]
	ldr r6, [r12, #648]
	str lr, [r12, #744]
	umlal	r7, r9, r3, r6
	ldr r6, [r12, #696]
	ldr r3, [r12, #728]
	umlal	r7, r9, r6, r1
	ldr r1, [r12, #660]
	ldr r6, [r12, #720]
	umlal	r7, r9, r11, r1
	ldr r1, [r12, #704]
	umlal	r7, r9, r6, r1
	mov	lr, r7
	ldr r7, [r12, #716]
	ldr r6, [r12, #712]
	umlal	lr, r9, r3, r7
	add	r7, r6, r6, lsl #3
	ldr r1, [r12, #660]
	str r9, [r12, #748]
	add	r9, r6, r7, lsl #1
	ldr r6, [r12, #740]
	ldr r7, [r12, #744]
	str lr, [r12, #752]
	umlal	r6, r7, r9, r1
	mov	lr, r7
	mov	r7, r6
	ldr r6, [r12, #708]
	ldr r1, [r12, #704]
	umlal	r6, r4, r9, r3
	str r4, [r12, #756]
	ldr r4, [r12, #716]
	str r6, [r12, #760]
	umlal	r7, lr, r1, r4
	ldr r4, [r12, #728]
	ldr r1, [r12, #620]
	umlal	r7, lr, r4, r1
	ldr r1, [r12, #624]
	ldr	r4, [r1, #12]
	ldr r1, [r12, #724]
	ldr r6, [r12, #696]
	ldr r3, [r12, #736]
	umlal	r1, r2, r6, r4
	ldr r6, [r12, #720]
	str r1, [r12, #764]
	ldr r1, [r12, #732]
	umlal	r10, r5, r11, r4
	umlal	r1, r3, r6, r4
	ldr r6, [r12, #760]
	str r3, [r12, #768]
	str r1, [r12, #772]
	ldr r3, [r12, #756]
	ldr r1, [r12, #716]
	str r5, [r12, #776]
	umlal	r6, r3, r4, r1
	mov	r5, r4
	mov	r4, r3
	mov	r3, r7
	str r6, [r12, #780]
	ldr r6, [r12, #612]
	str r5, [r12, #784]
	umlal	r3, lr, r5, r6
	ldr r5, [r12, #624]
	ldr r6, [r12, #764]
	ldr	r5, [r5, #8]
	umlal	r6, r2, r11, r5
	str r6, [r12, #788]
	str r2, [r12, #792]
	mov	r2, r5
	ldr r6, [r12, #776]
	umlal	r10, r6, r9, r5
	ldr r5, [r12, #772]
	ldr r7, [r12, #768]
	umlal	r5, r7, r2, r1
	str r7, [r12, #796]
	str r5, [r12, #800]
	ldr r7, [r12, #780]
	ldr r5, [r12, #620]
	str r6, [r12, #804]
	umlal	r7, r4, r2, r5
	mov	r6, r2
	mov	r2, r3
	str r7, [r12, #808]
	ldr r7, [r12, #636]
	str r6, [r12, #812]
	umlal	r2, lr, r6, r7
	umull	r6, r7, r0, r9
	str r2, [r12, #816]
	ldr r2, [r12, #628]
	ldr r3, [r12, #656]
	umlal	r6, r7, r2, r11
	umlal	r6, r7, r3, r1
	str r1, [r12, #820]
	ldr r1, [r12, #660]
	str r0, [r12, #824]
	umlal	r6, r7, r1, r5
	ldr r1, [r12, #704]
	ldr r5, [r12, #612]
	umlal	r6, r7, r1, r5
	ldr r1, [r12, #728]
	ldr r5, [r12, #636]
	umlal	r6, r7, r1, r5
	ldr r1, [r12, #784]
	ldr r5, [r12, #632]
	umlal	r6, r7, r1, r5
	mov	r9, r6
	ldr r5, [r12, #644]
	ldr r6, [r12, #812]
	umlal	r9, r7, r6, r5
	str r9, [r12, #828]
	umull	r9, r6, r11, r0
	str r7, [r12, #832]
	ldr r7, [r12, #696]
	umlal	r9, r6, r2, r7
	ldr r7, [r12, #720]
	ldr r2, [r12, #624]
	umlal	r9, r6, r7, r3
	ldr r11, [r2, #4]
	ldr r2, [r2, #0]
	ldr r1, [r12, #660]
	ldr r3, [r12, #820]
	str r2, [r12, #836]
	ldr r5, [r12, #788]
	ldr r2, [r12, #792]
	umlal	r5, r2, r7, r11
	mov	r0, r5
	umlal	r9, r6, r1, r3
	ldr r7, [r12, #808]
	ldr r1, [r12, #612]
	str r9, [r12, #840]
	umlal	r7, r4, r11, r1
	ldr r1, [r12, #632]
	mov	r9, r7
	ldr r7, [r12, #816]
	ldr r5, [r12, #804]
	umlal	r7, lr, r11, r1
	mov	r1, r7
	mov	r7, r0
	ldr r0, [r12, #836]
	umlal	r10, r5, r11, r3
	umlal	r7, r2, r3, r0
	str r2, [r12, #844]
	str r7, [r12, #848]
	ldr r3, [r12, #620]
	mov	r2, r0
	umlal	r10, r5, r3, r0
	str r10, [r12, #852]
	mov	r10, r4
	ldr r0, [r12, #636]
	ldr r4, [r12, #644]
	umlal	r9, r10, r0, r2
	str r9, [r12, #856]
	mov	r9, r1
	ldr r7, [r12, #832]
	umlal	r9, lr, r4, r2
	str r5, [r12, #860]
	ldr r2, [r12, #652]
	ldr r5, [r12, #828]
	str lr, [r12, #864]
	umlal	r5, r7, r11, r2
	str r9, [r12, #868]
	mov	lr, r5
	mov	r9, r7
	ldr r5, [r12, #680]
	ldr r2, [r12, #836]
	ldr r4, [r12, #704]
	umlal	lr, r9, r5, r2
	ldr r5, [r12, #840]
	str r9, [r12, #872]
	lsl	r9, r3, #1
	umlal	r5, r6, r4, r9
	mov	r1, r5
	ldr r7, [r12, #752]
	ldr r5, [r12, #748]
	ldr r4, [r12, #784]
	str r10, [r12, #876]
	umlal	r7, r5, r4, r9
	mov	r10, r1
	str lr, [r12, #880]
	mov	lr, r5
	mov	r5, r7
	ldr r4, [r12, #800]
	ldr r7, [r12, #796]
	umlal	r4, r7, r11, r9
	ldr r1, [r12, #612]
	mov	r2, r7
	ldr r7, [r12, #728]
	umlal	r10, r6, r7, r1
	mov	r7, r10
	mov	r10, r5
	ldr r5, [r12, #812]
	str r6, [r12, #884]
	umlal	r10, lr, r5, r1
	mov	r6, r4
	mov	r5, r2
	ldr r2, [r12, #836]
	umlal	r6, r5, r1, r2
	ldr r1, [r12, #824]
	str r5, [r12, #888]
	umull	r4, r5, r1, r3
	ldr r2, [r12, #628]
	str r6, [r12, #892]
	ldr r6, [r12, #820]
	umlal	r4, r5, r2, r6
	umull	r3, r1, r1, r6
	mov	r6, r2
	ldr r2, [r12, #720]
	umlal	r3, r1, r6, r2
	ldr r2, [r12, #612]
	ldr r6, [r12, #656]
	umlal	r3, r1, r6, r9
	umlal	r4, r5, r6, r2
	ldr r6, [r12, #660]
	lsl	r9, r0, #1
	umlal	r3, r1, r6, r2
	umlal	r4, r5, r6, r0
	ldr r6, [r12, #784]
	ldr r0, [r12, #884]
	umlal	r10, lr, r11, r9
	umlal	r7, r0, r6, r9
	mov	r6, r0
	ldr r0, [r12, #704]
	umlal	r3, r1, r0, r9
	mov	r2, r1
	mov	r9, r2
	ldr r1, [r12, #632]
	ldr r2, [r12, #644]
	umlal	r4, r5, r0, r1
	ldr r0, [r12, #812]
	umlal	r7, r6, r0, r1
	ldr r0, [r12, #728]
	umlal	r3, r9, r0, r1
	mov	r1, r9
	umlal	r4, r5, r0, r2
	ldr r0, [r12, #632]
	ldr r2, [r12, #836]
	umlal	r10, lr, r0, r2
	ldr r2, [r12, #644]
	ldr r0, [r12, #784]
	lsl	r9, r2, #1
	umlal	r7, r6, r11, r9
	umlal	r3, r1, r0, r9
	mov	r9, r7
	ldr r2, [r12, #652]
	ldr r7, [r12, #836]
	umlal	r4, r5, r0, r2
	ldr r0, [r12, #812]
	umlal	r9, r6, r2, r7
	umlal	r3, r1, r0, r2
	ldr r2, [r12, #680]
	str r9, [r12, #896]
	lsls	r7, r2, #1
	umlal	r3, r1, r11, r7
	mov	r9, r3
	umlal	r4, r5, r0, r2
	ldr r7, [r12, #836]
	ldr r2, [r12, #684]
	ldr r3, [r12, #712]
	umlal	r4, r5, r11, r2
	umlal	r9, r1, r2, r7
	str r9, [r12, #900]
	mov	r9, r4
	ldr r4, [r12, #848]
	ldr r2, [r12, #844]
	umlal	r9, r5, r7, r3
	ldr r7, [r12, #852]
	lsrs	r3, r4, #26
	orr	r3, r3, r2, lsl #6
	adds	r3, r7, r3
	ldr r7, [r12, #860]
	ldr r0, [r12, #892]
	adc	r2, r7, r2, lsr #26
	bic	r7, r4, #0xFC000000
	lsrs	r4, r3, #25
	orr	r4, r4, r2, lsl #7
	adds	r4, r0, r4
	str r10, [r12, #904]
	str r9, [r12, #908]
	ldr r0, [r12, #888]
	lsr	r9, r4, #26
	adc	r2, r0, r2, lsr #25
	ldr r0, [r12, #856]
	orr	r9, r9, r2, lsl #6
	adds	r9, r0, r9
	ldr r0, [r12, #876]
	lsr	r10, r9, #25
	adc	r2, r0, r2, lsr #26
	ldr r0, [r12, #904]
	orr	r10, r10, r2, lsl #7
	adds	r10, r0, r10
	adc	r2, lr, r2, lsr #25
	bic	r11, r3, #0xFE000000
	lsr	lr, r10, #26
	ldr r3, [r12, #868]
	orr	lr, lr, r2, lsl #6
	ldr r0, [r12, #616]
	adds	lr, r3, lr
	ldr r3, [r12, #864]
	bic	r9, r9, #0xFE000000
	adc	r2, r3, r2, lsr #26
	str	r9, [r0, #12]
	ldr r3, [r12, #896]
	lsr	r9, lr, #25
	orr	r9, r9, r2, lsl #7
	adds	r9, r3, r9
	adc	r2, r6, r2, lsr #25
	bic	r6, lr, #0xFE000000
	ldr r3, [r12, #880]
	str	r6, [r0, #20]
	lsr	r6, r9, #26
	orr	r6, r6, r2, lsl #6
	adds	r6, r3, r6
	ldr r3, [r12, #872]
	lsr	lr, r6, #25
	adc	r2, r3, r2, lsr #26
	ldr r3, [r12, #900]
	orr	lr, lr, r2, lsl #7
	adds	lr, r3, lr
	adc	r1, r1, r2, lsr #25
	ldr r3, [r12, #908]
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
	ldr r0, [r12, #0]
	ldr r1, [r12, #4]
	ldr r2, [r12, #8]
	mov	lr, r2
	ldr	r2, [r1, #36]
	mov	r6, r2
	ldr	r2, [lr, #8]
	mov	r9, #38
	str r2, [r12, #912]
	ldr	r2, [r1, #32]
	str r0, [r12, #916]
	mov	r0, r2
	ldr	r3, [lr, #12]
	ldr	r5, [lr, #4]
	add	r11, r3, r3, lsl #3
	add	r11, r3, r11, lsl #1
	ldr r2, [r12, #912]
	mul	r4, r9, r5
	str r5, [r12, #920]
	umull	r11, r5, r11, r0
	add	r10, r2, r2, lsl #3
	add	r10, r2, r10, lsl #1
	umlal	r11, r5, r6, r10
	umull	r10, r2, r10, r0
	str r1, [r12, #924]
	ldr	r1, [lr, #16]
	str r6, [r12, #928]
	umlal	r10, r2, r6, r4
	add	r6, r1, r1, lsl #3
	mul	r7, r9, r3
	add	r6, r1, r6, lsl #1
	str r1, [r12, #932]
	ldr r1, [r12, #924]
	ldr	r4, [lr, #20]
	str r3, [r12, #936]
	ldr	r3, [r1, #28]
	str r7, [r12, #940]
	umlal	r10, r2, r7, r3
	mov	r7, r4
	mul	r9, r9, r7
	ldr	r1, [lr, #24]
	add	r4, r4, r4, lsl #3
	add	r4, r7, r4, lsl #1
	str r7, [r12, #944]
	add	r7, r1, r1, lsl #3
	str r9, [r12, #948]
	umlal	r11, r5, r6, r3
	add	r9, r1, r7, lsl #1
	str r1, [r12, #952]
	ldr r1, [r12, #924]
	str r3, [r12, #956]
	ldr	r7, [r1, #24]
	ldr r1, [r12, #928]
	umlal	r10, r2, r6, r7
	umlal	r11, r5, r4, r7
	str r7, [r12, #960]
	umull	r7, r4, r0, r4
	umlal	r7, r4, r1, r6
	ldr r3, [r12, #956]
	str r10, [r12, #964]
	umlal	r7, r4, r9, r3
	mov	r3, r1
	umull	r10, r6, r6, r0
	ldr r1, [r12, #940]
	umlal	r10, r6, r3, r1
	ldr r1, [r12, #948]
	ldr r3, [r12, #956]
	umlal	r10, r6, r1, r3
	ldr r3, [r12, #960]
	umlal	r10, r6, r9, r3
	str r6, [r12, #968]
	str r10, [r12, #972]
	ldr r1, [lr, #28]
	ldr r6, [lr, #32]
	add	r10, r1, r1, lsl #3
	add	r10, r1, r10, lsl #1
	umlal	r7, r4, r10, r3
	str r10, [r12, #976]
	mov	r10, r11
	mov	r11, #38
	str r1, [r12, #980]
	ldr r1, [r12, #924]
	ldr r3, [r12, #964]
	ldr	r1, [r1, #20]
	str r6, [r12, #984]
	ldr r6, [r12, #948]
	str r4, [r12, #988]
	umlal	r3, r2, r6, r1
	ldr r4, [r12, #980]
	str r2, [r12, #992]
	mul	r11, r11, r4
	ldr r2, [r12, #968]
	ldr r4, [r12, #972]
	str r11, [r12, #996]
	umlal	r4, r2, r11, r1
	str r4, [r12, #1000]
	ldr r4, [r12, #984]
	umlal	r10, r5, r9, r1
	add	r11, r4, r4, lsl #3
	add	r11, r4, r11, lsl #1
	ldr r4, [r12, #988]
	str r1, [r12, #1004]
	umlal	r7, r4, r11, r1
	str r7, [r12, #1008]
	ldr	r7, [lr, #36]
	mov	r6, r2
	mov	r1, r7
	ldr	r7, [lr, #0]
	mov	lr, #38
	str r1, [r12, #1012]
	mul	lr, lr, r1
	ldr r1, [r12, #924]
	ldr r2, [r12, #992]
	str r7, [r12, #1016]
	ldr	r7, [r1, #16]
	str lr, [r12, #1020]
	umlal	r3, r2, r9, r7
	str r3, [r12, #1024]
	ldr r3, [r12, #1000]
	ldr r1, [r12, #976]
	umlal	r3, r6, r11, r7
	str r7, [r12, #1028]
	umlal	r10, r5, r1, r7
	umull	r7, lr, r0, r1
	str r3, [r12, #1032]
	ldr r3, [r12, #928]
	str r6, [r12, #1036]
	umlal	r7, lr, r3, r9
	mov	r6, r7
	ldr r1, [r12, #956]
	umull	r7, r9, r9, r0
	umlal	r6, lr, r11, r1
	str r6, [r12, #1040]
	ldr r6, [r12, #948]
	str lr, [r12, #1044]
	umlal	r7, r9, r3, r6
	ldr r6, [r12, #996]
	ldr r3, [r12, #1028]
	umlal	r7, r9, r6, r1
	ldr r1, [r12, #960]
	ldr r6, [r12, #1020]
	umlal	r7, r9, r11, r1
	ldr r1, [r12, #1004]
	umlal	r7, r9, r6, r1
	mov	lr, r7
	ldr r7, [r12, #1016]
	ldr r6, [r12, #1012]
	umlal	lr, r9, r3, r7
	add	r7, r6, r6, lsl #3
	ldr r1, [r12, #960]
	str r9, [r12, #1048]
	add	r9, r6, r7, lsl #1
	ldr r6, [r12, #1040]
	ldr r7, [r12, #1044]
	str lr, [r12, #1052]
	umlal	r6, r7, r9, r1
	mov	lr, r7
	mov	r7, r6
	ldr r6, [r12, #1008]
	ldr r1, [r12, #1004]
	umlal	r6, r4, r9, r3
	str r4, [r12, #1056]
	ldr r4, [r12, #1016]
	str r6, [r12, #1060]
	umlal	r7, lr, r1, r4
	ldr r4, [r12, #1028]
	ldr r1, [r12, #920]
	umlal	r7, lr, r4, r1
	ldr r1, [r12, #924]
	ldr	r4, [r1, #12]
	ldr r1, [r12, #1024]
	ldr r6, [r12, #996]
	ldr r3, [r12, #1036]
	umlal	r1, r2, r6, r4
	ldr r6, [r12, #1020]
	str r1, [r12, #1064]
	ldr r1, [r12, #1032]
	umlal	r10, r5, r11, r4
	umlal	r1, r3, r6, r4
	ldr r6, [r12, #1060]
	str r3, [r12, #1068]
	str r1, [r12, #1072]
	ldr r3, [r12, #1056]
	ldr r1, [r12, #1016]
	str r5, [r12, #1076]
	umlal	r6, r3, r4, r1
	mov	r5, r4
	mov	r4, r3
	mov	r3, r7
	str r6, [r12, #1080]
	ldr r6, [r12, #912]
	str r5, [r12, #1084]
	umlal	r3, lr, r5, r6
	ldr r5, [r12, #924]
	ldr r6, [r12, #1064]
	ldr	r5, [r5, #8]
	umlal	r6, r2, r11, r5
	str r6, [r12, #1088]
	str r2, [r12, #1092]
	mov	r2, r5
	ldr r6, [r12, #1076]
	umlal	r10, r6, r9, r5
	ldr r5, [r12, #1072]
	ldr r7, [r12, #1068]
	umlal	r5, r7, r2, r1
	str r7, [r12, #1096]
	str r5, [r12, #1100]
	ldr r7, [r12, #1080]
	ldr r5, [r12, #920]
	str r6, [r12, #1104]
	umlal	r7, r4, r2, r5
	mov	r6, r2
	mov	r2, r3
	str r7, [r12, #1108]
	ldr r7, [r12, #936]
	str r6, [r12, #1112]
	umlal	r2, lr, r6, r7
	umull	r6, r7, r0, r9
	str r2, [r12, #1116]
	ldr r2, [r12, #928]
	ldr r3, [r12, #956]
	umlal	r6, r7, r2, r11
	umlal	r6, r7, r3, r1
	str r1, [r12, #1120]
	ldr r1, [r12, #960]
	str r0, [r12, #1124]
	umlal	r6, r7, r1, r5
	ldr r1, [r12, #1004]
	ldr r5, [r12, #912]
	umlal	r6, r7, r1, r5
	ldr r1, [r12, #1028]
	ldr r5, [r12, #936]
	umlal	r6, r7, r1, r5
	ldr r1, [r12, #1084]
	ldr r5, [r12, #932]
	umlal	r6, r7, r1, r5
	mov	r9, r6
	ldr r5, [r12, #944]
	ldr r6, [r12, #1112]
	umlal	r9, r7, r6, r5
	str r9, [r12, #1128]
	umull	r9, r6, r11, r0
	str r7, [r12, #1132]
	ldr r7, [r12, #996]
	umlal	r9, r6, r2, r7
	ldr r7, [r12, #1020]
	ldr r2, [r12, #924]
	umlal	r9, r6, r7, r3
	ldr r11, [r2, #4]
	ldr r2, [r2, #0]
	ldr r1, [r12, #960]
	ldr r3, [r12, #1120]
	str r2, [r12, #1136]
	ldr r5, [r12, #1088]
	ldr r2, [r12, #1092]
	umlal	r5, r2, r7, r11
	mov	r0, r5
	umlal	r9, r6, r1, r3
	ldr r7, [r12, #1108]
	ldr r1, [r12, #912]
	str r9, [r12, #1140]
	umlal	r7, r4, r11, r1
	ldr r1, [r12, #932]
	mov	r9, r7
	ldr r7, [r12, #1116]
	ldr r5, [r12, #1104]
	umlal	r7, lr, r11, r1
	mov	r1, r7
	mov	r7, r0
	ldr r0, [r12, #1136]
	umlal	r10, r5, r11, r3
	umlal	r7, r2, r3, r0
	str r2, [r12, #1144]
	str r7, [r12, #1148]
	ldr r3, [r12, #920]
	mov	r2, r0
	umlal	r10, r5, r3, r0
	str r10, [r12, #1152]
	mov	r10, r4
	ldr r0, [r12, #936]
	ldr r4, [r12, #944]
	umlal	r9, r10, r0, r2
	str r9, [r12, #1156]
	mov	r9, r1
	ldr r7, [r12, #1132]
	umlal	r9, lr, r4, r2
	str r5, [r12, #1160]
	ldr r2, [r12, #952]
	ldr r5, [r12, #1128]
	str lr, [r12, #1164]
	umlal	r5, r7, r11, r2
	str r9, [r12, #1168]
	mov	lr, r5
	mov	r9, r7
	ldr r5, [r12, #980]
	ldr r2, [r12, #1136]
	ldr r4, [r12, #1004]
	umlal	lr, r9, r5, r2
	ldr r5, [r12, #1140]
	str r9, [r12, #1172]
	lsl	r9, r3, #1
	umlal	r5, r6, r4, r9
	mov	r1, r5
	ldr r7, [r12, #1052]
	ldr r5, [r12, #1048]
	ldr r4, [r12, #1084]
	str r10, [r12, #1176]
	umlal	r7, r5, r4, r9
	mov	r10, r1
	str lr, [r12, #1180]
	mov	lr, r5
	mov	r5, r7
	ldr r4, [r12, #1100]
	ldr r7, [r12, #1096]
	umlal	r4, r7, r11, r9
	ldr r1, [r12, #912]
	mov	r2, r7
	ldr r7, [r12, #1028]
	umlal	r10, r6, r7, r1
	mov	r7, r10
	mov	r10, r5
	ldr r5, [r12, #1112]
	str r6, [r12, #1184]
	umlal	r10, lr, r5, r1
	mov	r6, r4
	mov	r5, r2
	ldr r2, [r12, #1136]
	umlal	r6, r5, r1, r2
	ldr r1, [r12, #1124]
	str r5, [r12, #1188]
	umull	r4, r5, r1, r3
	ldr r2, [r12, #928]
	str r6, [r12, #1192]
	ldr r6, [r12, #1120]
	umlal	r4, r5, r2, r6
	umull	r3, r1, r1, r6
	mov	r6, r2
	ldr r2, [r12, #1020]
	umlal	r3, r1, r6, r2
	ldr r2, [r12, #912]
	ldr r6, [r12, #956]
	umlal	r3, r1, r6, r9
	umlal	r4, r5, r6, r2
	ldr r6, [r12, #960]
	lsl	r9, r0, #1
	umlal	r3, r1, r6, r2
	umlal	r4, r5, r6, r0
	ldr r6, [r12, #1084]
	ldr r0, [r12, #1184]
	umlal	r10, lr, r11, r9
	umlal	r7, r0, r6, r9
	mov	r6, r0
	ldr r0, [r12, #1004]
	umlal	r3, r1, r0, r9
	mov	r2, r1
	mov	r9, r2
	ldr r1, [r12, #932]
	ldr r2, [r12, #944]
	umlal	r4, r5, r0, r1
	ldr r0, [r12, #1112]
	umlal	r7, r6, r0, r1
	ldr r0, [r12, #1028]
	umlal	r3, r9, r0, r1
	mov	r1, r9
	umlal	r4, r5, r0, r2
	ldr r0, [r12, #932]
	ldr r2, [r12, #1136]
	umlal	r10, lr, r0, r2
	ldr r2, [r12, #944]
	ldr r0, [r12, #1084]
	lsl	r9, r2, #1
	umlal	r7, r6, r11, r9
	umlal	r3, r1, r0, r9
	mov	r9, r7
	ldr r2, [r12, #952]
	ldr r7, [r12, #1136]
	umlal	r4, r5, r0, r2
	ldr r0, [r12, #1112]
	umlal	r9, r6, r2, r7
	umlal	r3, r1, r0, r2
	ldr r2, [r12, #980]
	str r9, [r12, #1196]
	lsls	r7, r2, #1
	umlal	r3, r1, r11, r7
	mov	r9, r3
	umlal	r4, r5, r0, r2
	ldr r7, [r12, #1136]
	ldr r2, [r12, #984]
	ldr r3, [r12, #1012]
	umlal	r4, r5, r11, r2
	umlal	r9, r1, r2, r7
	str r9, [r12, #1200]
	mov	r9, r4
	ldr r4, [r12, #1148]
	ldr r2, [r12, #1144]
	umlal	r9, r5, r7, r3
	ldr r7, [r12, #1152]
	lsrs	r3, r4, #26
	orr	r3, r3, r2, lsl #6
	adds	r3, r7, r3
	ldr r7, [r12, #1160]
	ldr r0, [r12, #1192]
	adc	r2, r7, r2, lsr #26
	bic	r7, r4, #0xFC000000
	lsrs	r4, r3, #25
	orr	r4, r4, r2, lsl #7
	adds	r4, r0, r4
	str r10, [r12, #1204]
	str r9, [r12, #1208]
	ldr r0, [r12, #1188]
	lsr	r9, r4, #26
	adc	r2, r0, r2, lsr #25
	ldr r0, [r12, #1156]
	orr	r9, r9, r2, lsl #6
	adds	r9, r0, r9
	ldr r0, [r12, #1176]
	lsr	r10, r9, #25
	adc	r2, r0, r2, lsr #26
	ldr r0, [r12, #1204]
	orr	r10, r10, r2, lsl #7
	adds	r10, r0, r10
	adc	r2, lr, r2, lsr #25
	bic	r11, r3, #0xFE000000
	lsr	lr, r10, #26
	ldr r3, [r12, #1168]
	orr	lr, lr, r2, lsl #6
	ldr r0, [r12, #916]
	adds	lr, r3, lr
	ldr r3, [r12, #1164]
	bic	r9, r9, #0xFE000000
	adc	r2, r3, r2, lsr #26
	str	r9, [r0, #12]
	ldr r3, [r12, #1196]
	lsr	r9, lr, #25
	orr	r9, r9, r2, lsl #7
	adds	r9, r3, r9
	adc	r2, r6, r2, lsr #25
	bic	r6, lr, #0xFE000000
	ldr r3, [r12, #1180]
	str	r6, [r0, #20]
	lsr	r6, r9, #26
	orr	r6, r6, r2, lsl #6
	adds	r6, r3, r6
	ldr r3, [r12, #1172]
	lsr	lr, r6, #25
	adc	r2, r3, r2, lsr #26
	ldr r3, [r12, #1200]
	orr	lr, lr, r2, lsl #7
	adds	lr, r3, lr
	adc	r1, r1, r2, lsr #25
	ldr r3, [r12, #1208]
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
	ldr r0, [r12, #1272]
	subs r0, r0, #1
	str r0, [r12, #1272]
	bne 1b
	pop {r4-r11, pc}

// expe_slothy: counter=[r12,#1272]
.global expe_slothy
.type expe_slothy, %function
.thumb_func
.balign 16
expe_slothy:
	push {r4-r11, lr}
	movw r8, #:lower16:g_theta_state
	movt r8, #:upper16:g_theta_state
	movw r12, #:lower16:g_spill
	movt r12, #:upper16:g_spill
	str r0, [r12, #1272]
.balign 16
1:
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov r14, r2
	str r1, [r12, #4]
	str r0, [r12, #0]
	ldr r3, [r14, #20]
	mov r10, #38
	str r0, [r12, #16]
	str r1, [r12, #24]
	ldr r11, [r14, #12]
	mul r4, r10, r11
	str r2, [r12, #8]
	mov r9, r3
	ldr r6, [r1, #32]
	str r4, [r12, #40]
	ldr r7, [r14, #4]
	ldr r5, [r1, #36]
	mul r1, r10, r7
	mul r2, r10, r9
	add r10, r3, r3, lsl     #3
	mov r0, r6
	mov r6, r5
	add r3, r9, r10, lsl     #1
	ldr r10, [r12, #12]
	str r2, [r12, #48]
	add r5, r11, r11, lsl     #3
	add r2, r10, r10, lsl     #3
	str r9, [r12, #44]
	add r5, r11, r5, lsl     #1
	str r6, [r12, #28]
	umull r9, r5, r5, r0
	add r10, r10, r2, lsl     #1
	str r11, [r12, #36]
	umull r11, r2, r10, r0
	str r7, [r12, #20]
	umlal r9, r5, r6, r10
	umlal r11, r2, r6, r1
	ldr r6, [r14, #16]
	str r6, [r12, #32]
	ldr r10, [r12, #28]
	ldr r1, [r12, #24]
	add r7, r6, r6, lsl     #3
	ldr r1, [r1, #28]
	add r6, r6, r7, lsl     #1
	umlal r11, r2, r4, r1
	umull r7, r4, r0, r3
	str r1, [r12, #56]
	umlal r9, r5, r6, r1
	ldr r1, [r12, #24]
	umlal r7, r4, r10, r6
	ldr r1, [r1, #24]
	str r1, [r12, #60]
	umlal r9, r5, r3, r1
	umlal r11, r2, r6, r1
	mov r1, r10
	ldr r10, [r12, #40]
	umull r3, r6, r6, r0
	str r11, [r12, #64]
	ldr r11, [r12, #48]
	umlal r3, r6, r1, r10
	ldr r1, [r14, #24]
	mov r10, r9
	ldr r9, [r12, #56]
	umlal r3, r6, r11, r9
	add r9, r1, r1, lsl     #3
	str r1, [r12, #52]
	ldr r11, [r12, #60]
	add r9, r1, r9, lsl     #1
	ldr r1, [r12, #56]
	umlal r3, r6, r9, r11
	umlal r7, r4, r9, r1
	ldr r1, [r14, #28]
	str r3, [r12, #72]
	ldr r3, [r14, #8]
	str r3, [r12, #12]
	add r3, r1, r1, lsl     #3
	str r6, [r12, #68]
	ldr r6, [r14, #32]
	add r3, r1, r3, lsl     #1
	str r3, [r12, #76]
	umlal r7, r4, r3, r11
	mov r11, #38
	str r1, [r12, #80]
	ldr r1, [r12, #24]
	ldr r3, [r12, #64]
	ldr r1, [r1, #20]
	str r6, [r12, #84]
	ldr r6, [r12, #48]
	str r4, [r12, #88]
	umlal r3, r2, r6, r1
	ldr r4, [r12, #80]
	str r2, [r12, #92]
	mul r11, r11, r4
	ldr r2, [r12, #68]
	ldr r4, [r12, #72]
	str r11, [r12, #96]
	umlal r4, r2, r11, r1
	str r4, [r12, #100]
	ldr r4, [r12, #84]
	umlal r10, r5, r9, r1
	add r11, r4, r4, lsl   #3
	add r11, r4, r11, lsl   #1
	ldr r4, [r12, #88]
	str r1, [r12, #104]
	umlal r7, r4, r11, r1
	str r7, [r12, #108]
	ldr r7, [r14, #36]
	mov r6, r2
	mov r1, r7
	ldr r7, [r14, #0]
	mov r14, #38
	str r1, [r12, #112]
	mul r14, r14, r1
	ldr r1, [r12, #24]
	ldr r2, [r12, #92]
	str r7, [r12, #116]
	ldr r7, [r1, #16]
	str r14, [r12, #120]
	umlal r3, r2, r9, r7
	str r3, [r12, #124]
	ldr r3, [r12, #100]
	ldr r1, [r12, #76]
	umlal r3, r6, r11, r7
	str r7, [r12, #128]
	umlal r10, r5, r1, r7
	umull r7, r14, r0, r1
	str r3, [r12, #132]
	ldr r3, [r12, #28]
	str r6, [r12, #136]
	umlal r7, r14, r3, r9
	mov r6, r7
	ldr r1, [r12, #56]
	umull r7, r9, r9, r0
	umlal r6, r14, r11, r1
	str r6, [r12, #140]
	ldr r6, [r12, #48]
	str r14, [r12, #144]
	umlal r7, r9, r3, r6
	ldr r6, [r12, #96]
	ldr r3, [r12, #128]
	umlal r7, r9, r6, r1
	ldr r1, [r12, #60]
	ldr r6, [r12, #120]
	umlal r7, r9, r11, r1
	ldr r1, [r12, #104]
	umlal r7, r9, r6, r1
	mov r14, r7
	ldr r7, [r12, #116]
	ldr r6, [r12, #112]
	umlal r14, r9, r3, r7
	add r7, r6, r6, lsl   #3
	ldr r1, [r12, #60]
	str r9, [r12, #148]
	add r9, r6, r7, lsl   #1
	ldr r6, [r12, #140]
	ldr r7, [r12, #144]
	str r14, [r12, #152]
	umlal r6, r7, r9, r1
	mov r14, r7
	mov r7, r6
	ldr r6, [r12, #108]
	ldr r1, [r12, #104]
	umlal r6, r4, r9, r3
	str r4, [r12, #156]
	ldr r4, [r12, #116]
	str r6, [r12, #160]
	umlal r7, r14, r1, r4
	ldr r4, [r12, #128]
	ldr r1, [r12, #20]
	umlal r7, r14, r4, r1
	ldr r1, [r12, #24]
	ldr r4, [r1, #12]
	ldr r1, [r12, #124]
	ldr r6, [r12, #96]
	ldr r3, [r12, #136]
	umlal r1, r2, r6, r4
	ldr r6, [r12, #120]
	str r1, [r12, #164]
	ldr r1, [r12, #132]
	umlal r10, r5, r11, r4
	umlal r1, r3, r6, r4
	ldr r6, [r12, #160]
	str r3, [r12, #168]
	str r1, [r12, #172]
	ldr r3, [r12, #156]
	ldr r1, [r12, #116]
	str r5, [r12, #176]
	umlal r6, r3, r4, r1
	mov r5, r4
	mov r4, r3
	mov r3, r7
	str r6, [r12, #180]
	ldr r6, [r12, #12]
	str r5, [r12, #184]
	umlal r3, r14, r5, r6
	ldr r5, [r12, #24]
	ldr r6, [r12, #164]
	ldr r5, [r5, #8]
	umlal r6, r2, r11, r5
	str r6, [r12, #188]
	str r2, [r12, #192]
	mov r2, r5
	ldr r6, [r12, #176]
	umlal r10, r6, r9, r5
	ldr r5, [r12, #172]
	str r6, [r12, #204]
	ldr r6, [r12, #168]
	str r1, [r12, #220]
	umlal r5, r6, r2, r1
	ldr r7, [r12, #20]
	str r0, [r12, #224]
	mov r3, r3
	str r6, [r12, #196]
	ldr r6, [r12, #180]
	str r5, [r12, #200]
	umlal r6, r4, r2, r7
	mov r5, r2
	ldr r2, [r12, #36]
	umlal r3, r14, r5, r2
	str r6, [r12, #208]
	umull r9, r2, r0, r9
	str r5, [r12, #212]
	str r3, [r12, #216]
	ldr r3, [r12, #28]
	ldr r5, [r12, #56]
	umlal r9, r2, r3, r11
	umull r0, r6, r11, r0
	ldr r11, [r12, #96]
	umlal r9, r2, r5, r1
	ldr r1, [r12, #120]
	umlal r0, r6, r3, r11
	ldr r3, [r12, #60]
	umlal r9, r2, r3, r7
	ldr r3, [r12, #104]
	ldr r11, [r12, #12]
	umlal r9, r2, r3, r11
	ldr r3, [r12, #36]
	ldr r11, [r12, #128]
	umlal r9, r2, r11, r3
	ldr r11, [r12, #184]
	umlal r0, r6, r1, r5
	ldr r5, [r12, #32]
	umlal r9, r2, r11, r5
	ldr r3, [r12, #220]
	ldr r11, [r12, #44]
	mov r5, r9
	ldr r9, [r12, #212]
	umlal r5, r2, r9, r11
	ldr r7, [r12, #60]
	umlal r0, r6, r7, r3
	ldr r7, [r12, #24]
	str r5, [r12, #228]
	ldr r5, [r12, #188]
	ldr r11, [r7, #4]
	str r2, [r12, #232]
	ldr r2, [r12, #192]
	str r0, [r12, #240]
	ldr r9, [r7, #0]
	umlal r5, r2, r1, r11
	str r9, [r12, #236]
	ldr r9, [r12, #208]
	mov r7, r5
	ldr r0, [r12, #32]
	ldr r1, [r12, #216]
	mov r7, r7
	umlal r1, r14, r11, r0
	ldr r0, [r12, #236]
	ldr r5, [r12, #204]
	umlal r7, r2, r3, r0
	umlal r10, r5, r11, r3
	ldr r3, [r12, #20]
	str r2, [r12, #244]
	mov r2, r0
	umlal r10, r5, r3, r0
	ldr r0, [r12, #12]
	mov r1, r1
	umlal r9, r4, r11, r0
	ldr r0, [r12, #36]
	str r10, [r12, #252]
	str r7, [r12, #248]
	mov r9, r9
	mov r10, r4
	ldr r4, [r12, #44]
	umlal r9, r10, r0, r2
	str r9, [r12, #256]
	mov r9, r1
	ldr r7, [r12, #232]
	umlal r9, r14, r4, r2
	str r5, [r12, #260]
	ldr r2, [r12, #52]
	ldr r5, [r12, #228]
	str r14, [r12, #264]
	umlal r5, r7, r11, r2
	str r9, [r12, #268]
	mov r14, r5
	mov r9, r7
	ldr r5, [r12, #80]
	ldr r2, [r12, #236]
	ldr r4, [r12, #104]
	umlal r14, r9, r5, r2
	ldr r5, [r12, #240]
	str r9, [r12, #272]
	lsl r9, r3, #1
	umlal r5, r6, r4, r9
	mov r1, r5
	ldr r7, [r12, #152]
	ldr r5, [r12, #148]
	ldr r4, [r12, #184]
	str r10, [r12, #276]
	umlal r7, r5, r4, r9
	mov r10, r1
	str r14, [r12, #280]
	mov r14, r5
	mov r5, r7
	ldr r4, [r12, #200]
	ldr r7, [r12, #196]
	umlal r4, r7, r11, r9
	ldr r1, [r12, #12]
	mov r2, r7
	ldr r7, [r12, #128]
	umlal r10, r6, r7, r1
	mov r7, r10
	mov r10, r5
	ldr r5, [r12, #212]
	str r6, [r12, #284]
	umlal r10, r14, r5, r1
	mov r6, r4
	mov r5, r2
	ldr r2, [r12, #236]
	umlal r6, r5, r1, r2
	ldr r1, [r12, #224]
	str r5, [r12, #288]
	umull r4, r5, r1, r3
	ldr r2, [r12, #28]
	str r6, [r12, #292]
	ldr r6, [r12, #220]
	umlal r4, r5, r2, r6
	umull r3, r1, r1, r6
	mov r6, r2
	ldr r2, [r12, #120]
	umlal r3, r1, r6, r2
	ldr r2, [r12, #12]
	ldr r6, [r12, #56]
	umlal r3, r1, r6, r9
	umlal r4, r5, r6, r2
	ldr r6, [r12, #60]
	lsl r9, r0, #1
	umlal r3, r1, r6, r2
	umlal r4, r5, r6, r0
	ldr r6, [r12, #184]
	ldr r0, [r12, #284]
	umlal r10, r14, r11, r9
	umlal r7, r0, r6, r9
	mov r6, r0
	ldr r0, [r12, #104]
	umlal r3, r1, r0, r9
	mov r2, r1
	mov r9, r2
	ldr r1, [r12, #32]
	ldr r2, [r12, #44]
	umlal r4, r5, r0, r1
	ldr r0, [r12, #212]
	umlal r7, r6, r0, r1
	ldr r0, [r12, #128]
	umlal r3, r9, r0, r1
	mov r1, r9
	umlal r4, r5, r0, r2
	ldr r0, [r12, #32]
	ldr r2, [r12, #236]
	umlal r10, r14, r0, r2
	ldr r2, [r12, #44]
	ldr r0, [r12, #184]
	lsl r9, r2, #1
	umlal r7, r6, r11, r9
	umlal r3, r1, r0, r9
	mov r9, r7
	ldr r2, [r12, #52]
	ldr r7, [r12, #236]
	umlal r4, r5, r0, r2
	ldr r0, [r12, #212]
	umlal r9, r6, r2, r7
	umlal r3, r1, r0, r2
	ldr r2, [r12, #80]
	str r9, [r12, #296]
	lsls r7, r2, #1
	umlal r3, r1, r11, r7
	mov r9, r3
	umlal r4, r5, r0, r2
	ldr r7, [r12, #236]
	ldr r2, [r12, #84]
	ldr r3, [r12, #112]
	umlal r4, r5, r11, r2
	umlal r9, r1, r2, r7
	str r9, [r12, #300]
	mov r9, r4
	ldr r4, [r12, #248]
	ldr r2, [r12, #244]
	umlal r9, r5, r7, r3
	ldr r7, [r12, #252]
	lsrs r3, r4, #26
	orr r3, r3, r2, lsl   #6
	adds r3, r7, r3
	ldr r7, [r12, #260]
	ldr r0, [r12, #292]
	adc r2, r7, r2, lsr   #26
	bic r7, r4, #0xFC000000
	str r9, [r12, #308]
	lsrs r4, r3, #25
	str r10, [r12, #304]
	orr r4, r4, r2, lsl     #7
	adds r4, r0, r4
	ldr r10, [r12, #288]
	adc r0, r10, r2, lsr     #25
	bic r3, r3, #0xFE000000
	lsr r2, r4, #26
	bic r4, r4, #0xFC000000
	orr r11, r2, r0, lsl     #6
	ldr r2, [r12, #256]
	adds r10, r2, r11
	ldr r11, [r12, #276]
	adc r9, r11, r0, lsr     #26
	lsr r0, r10, #25
	bic r2, r10, #0xFE000000
	ldr r11, [r12, #304]
	orr r10, r0, r9, lsl     #7
	ldr r0, [r12, #16]
	str r2, [r0, #12]
	adds r2, r11, r10
	adc r9, r14, r9, lsr     #25
	lsr r14, r2, #26
	bic r10, r2, #0xFC000000
	ldr r11, [r12, #268]
	orr r14, r14, r9, lsl     #6
	ldr r2, [r12, #264]
	adds r14, r11, r14
	adc r2, r2, r9, lsr     #26
	bic r9, r14, #0xFE000000
	lsr r11, r14, #25
	str r9, [r0, #20]
	orr r9, r11, r2, lsl     #7
	ldr r11, [r12, #296]
	adds r11, r11, r9
	adc r2, r6, r2, lsr     #25
	lsr r9, r11, #26
	ldr r6, [r12, #280]
	bic r11, r11, #0xFC000000
	orr r9, r9, r2, lsl     #6
	str r11, [r0, #24]
	adds r6, r6, r9
	ldr r9, [r12, #272]
	adc r2, r9, r2, lsr     #26
	lsr r14, r6, #25
	ldr r11, [r12, #300]
	bic r9, r6, #0xFE000000
	orr r14, r14, r2, lsl     #7
	str r9, [r0, #28]
	adds r14, r11, r14
	adc r6, r1, r2, lsr     #25
	bic r11, r14, #0xFC000000
	ldr r1, [r12, #308]
	lsr r9, r14, #26
	str r11, [r0, #32]
	orr r9, r9, r6, lsl     #6
	adds r11, r1, r9
	adc r9, r5, r6, lsr     #26
	lsr r2, r11, #25
	bic r5, r11, #0xFE000000
	lsrs r11, r9, #25
	orr r9, r2, r9, lsl     #7
	lsls r6, r11, #3
	str r5, [r0, #36]
	lsls r2, r9, #3
	orr r6, r6, r9, lsr     #29
	adds r1, r2, r9
	adc r2, r11, r6
	adds r5, r1, r1
	adcs r1, r2, r2
	adds r5, r5, r9
	adc r6, r11, r1
	adds r2, r5, r7
	adc r11, r6, #0
	lsrs r9, r2, #26
	orr r9, r9, r11, lsl     #6
	add r3, r3, r9
	add r4, r4, r3, lsr     #25
	bic r2, r2, #0xFC000000
	bic r3, r3, #0xFE000000
	str r2, [r0, #0]
	str r3, [r0, #4]
	str r10, [r0, #16]
	str r4, [r0, #8]
	ldr r0, [r12, #0]
	ldr r1, [r12, #4]
	ldr r2, [r12, #8]
	mov r14, r2
	ldr r2, [r1, #36]
	mov r6, r2
	ldr r2, [r14, #8]
	mov r9, #38
	str r2, [r12, #312]
	ldr r2, [r1, #32]
	str r0, [r12, #316]
	mov r0, r2
	ldr r3, [r14, #12]
	ldr r5, [r14, #4]
	add r11, r3, r3, lsl   #3
	add r11, r3, r11, lsl   #1
	ldr r2, [r12, #312]
	mul r4, r9, r5
	str r5, [r12, #320]
	umull r11, r5, r11, r0
	add r10, r2, r2, lsl   #3
	add r10, r2, r10, lsl   #1
	umlal r11, r5, r6, r10
	umull r10, r2, r10, r0
	str r1, [r12, #324]
	ldr r1, [r14, #16]
	str r6, [r12, #328]
	umlal r10, r2, r6, r4
	add r6, r1, r1, lsl   #3
	mul r7, r9, r3
	add r6, r1, r6, lsl   #1
	str r1, [r12, #332]
	ldr r1, [r12, #324]
	ldr r4, [r14, #20]
	str r3, [r12, #336]
	ldr r3, [r1, #28]
	str r7, [r12, #340]
	umlal r10, r2, r7, r3
	mov r7, r4
	mul r9, r9, r7
	ldr r1, [r14, #24]
	add r4, r4, r4, lsl   #3
	add r4, r7, r4, lsl   #1
	str r7, [r12, #344]
	add r7, r1, r1, lsl   #3
	str r9, [r12, #348]
	umlal r11, r5, r6, r3
	add r9, r1, r7, lsl   #1
	str r1, [r12, #352]
	ldr r1, [r12, #324]
	str r3, [r12, #356]
	ldr r7, [r1, #24]
	ldr r1, [r12, #328]
	umlal r10, r2, r6, r7
	umlal r11, r5, r4, r7
	str r7, [r12, #360]
	umull r7, r4, r0, r4
	umlal r7, r4, r1, r6
	ldr r3, [r12, #356]
	str r10, [r12, #364]
	umlal r7, r4, r9, r3
	mov r3, r1
	umull r10, r6, r6, r0
	ldr r1, [r12, #340]
	umlal r10, r6, r3, r1
	ldr r1, [r12, #348]
	ldr r3, [r12, #356]
	umlal r10, r6, r1, r3
	ldr r3, [r12, #360]
	umlal r10, r6, r9, r3
	str r6, [r12, #368]
	str r10, [r12, #372]
	ldr r1, [r14, #28]
	ldr r6, [r14, #32]
	add r10, r1, r1, lsl   #3
	add r10, r1, r10, lsl   #1
	umlal r7, r4, r10, r3
	str r10, [r12, #376]
	mov r10, r11
	mov r11, #38
	str r1, [r12, #380]
	ldr r1, [r12, #324]
	ldr r3, [r12, #364]
	ldr r1, [r1, #20]
	str r6, [r12, #384]
	ldr r6, [r12, #348]
	str r4, [r12, #388]
	umlal r3, r2, r6, r1
	ldr r4, [r12, #380]
	str r2, [r12, #392]
	mul r11, r11, r4
	ldr r2, [r12, #368]
	ldr r4, [r12, #372]
	str r11, [r12, #396]
	umlal r4, r2, r11, r1
	str r4, [r12, #400]
	ldr r4, [r12, #384]
	umlal r10, r5, r9, r1
	add r11, r4, r4, lsl   #3
	add r11, r4, r11, lsl   #1
	ldr r4, [r12, #388]
	str r1, [r12, #404]
	umlal r7, r4, r11, r1
	str r7, [r12, #408]
	ldr r7, [r14, #36]
	mov r6, r2
	mov r1, r7
	ldr r7, [r14, #0]
	mov r14, #38
	str r1, [r12, #412]
	mul r14, r14, r1
	ldr r1, [r12, #324]
	ldr r2, [r12, #392]
	str r7, [r12, #416]
	ldr r7, [r1, #16]
	str r14, [r12, #420]
	umlal r3, r2, r9, r7
	str r3, [r12, #424]
	ldr r1, [r12, #400]
	umlal r1, r6, r11, r7
	ldr r3, [r12, #376]
	umlal r10, r5, r3, r7
	str r7, [r12, #428]
	str r6, [r12, #436]
	ldr r6, [r12, #324]
	umull r3, r14, r0, r3
	ldr r6, [r6, #12]
	str r1, [r12, #432]
	umlal r10, r5, r11, r6
	umull r1, r7, r9, r0
	str r5, [r12, #476]
	ldr r5, [r12, #328]
	umlal r3, r14, r5, r9
	ldr r9, [r12, #348]
	umlal r1, r7, r5, r9
	ldr r9, [r12, #396]
	mov r5, r3
	ldr r3, [r12, #356]
	umlal r1, r7, r9, r3
	ldr r9, [r12, #436]
	umlal r5, r14, r11, r3
	ldr r3, [r12, #360]
	umlal r1, r7, r11, r3
	ldr r3, [r12, #420]
	str r5, [r12, #440]
	ldr r5, [r12, #404]
	umlal r1, r7, r3, r5
	ldr r3, [r12, #420]
	str r14, [r12, #444]
	ldr r5, [r12, #432]
	umlal r5, r9, r3, r6
	ldr r3, [r12, #416]
	mov r14, r1
	ldr r1, [r12, #412]
	str r5, [r12, #472]
	ldr r5, [r12, #428]
	str r9, [r12, #468]
	umlal r14, r7, r5, r3
	add r9, r1, r1, lsl     #3
	ldr r3, [r12, #360]
	str r7, [r12, #448]
	ldr r7, [r12, #396]
	add r9, r1, r9, lsl     #1
	ldr r1, [r12, #424]
	umlal r1, r2, r7, r6
	ldr r7, [r12, #408]
	str r14, [r12, #452]
	umlal r7, r4, r9, r5
	str r1, [r12, #464]
	ldr r1, [r12, #444]
	str r7, [r12, #460]
	ldr r7, [r12, #440]
	umlal r7, r1, r9, r3
	ldr r5, [r12, #460]
	str r4, [r12, #456]
	ldr r3, [r12, #456]
	mov r7, r7
	ldr r4, [r12, #416]
	mov r14, r1
	ldr r1, [r12, #404]
	umlal r7, r14, r1, r4
	ldr r1, [r12, #416]
	umlal r5, r3, r6, r1
	mov r6, r6
	str r6, [r12, #484]
	ldr r4, [r12, #320]
	str r5, [r12, #480]
	ldr r5, [r12, #428]
	umlal r7, r14, r5, r4
	ldr r5, [r12, #324]
	mov r4, r3
	ldr r5, [r5, #8]
	mov r3, r7
	ldr r7, [r12, #312]
	umlal r3, r14, r6, r7
	ldr r6, [r12, #464]
	umlal r6, r2, r11, r5
	str r6, [r12, #488]
	str r2, [r12, #492]
	mov r2, r5
	ldr r6, [r12, #476]
	umlal r10, r6, r9, r5
	ldr r5, [r12, #472]
	ldr r7, [r12, #468]
	umlal r5, r7, r2, r1
	str r7, [r12, #496]
	str r5, [r12, #500]
	ldr r7, [r12, #480]
	ldr r5, [r12, #320]
	str r6, [r12, #504]
	umlal r7, r4, r2, r5
	mov r6, r2
	mov r2, r3
	str r7, [r12, #508]
	ldr r7, [r12, #336]
	str r6, [r12, #512]
	umlal r2, r14, r6, r7
	umull r6, r7, r0, r9
	str r2, [r12, #516]
	ldr r2, [r12, #328]
	ldr r3, [r12, #356]
	umlal r6, r7, r2, r11
	umlal r6, r7, r3, r1
	str r1, [r12, #520]
	ldr r1, [r12, #360]
	str r0, [r12, #524]
	umlal r6, r7, r1, r5
	ldr r1, [r12, #404]
	ldr r5, [r12, #312]
	umlal r6, r7, r1, r5
	ldr r1, [r12, #428]
	ldr r5, [r12, #336]
	umlal r6, r7, r1, r5
	ldr r1, [r12, #484]
	ldr r5, [r12, #332]
	umlal r6, r7, r1, r5
	mov r9, r6
	ldr r5, [r12, #344]
	ldr r6, [r12, #512]
	umlal r9, r7, r6, r5
	str r9, [r12, #528]
	umull r9, r6, r11, r0
	str r7, [r12, #532]
	ldr r7, [r12, #396]
	umlal r9, r6, r2, r7
	ldr r7, [r12, #420]
	ldr r2, [r12, #324]
	umlal r9, r6, r7, r3
	ldr r11, [r2, #4]
	ldr r2, [r2, #0]
	ldr r1, [r12, #360]
	ldr r3, [r12, #520]
	str r2, [r12, #536]
	ldr r5, [r12, #488]
	ldr r2, [r12, #492]
	umlal r5, r2, r7, r11
	mov r0, r5
	umlal r9, r6, r1, r3
	ldr r7, [r12, #508]
	ldr r1, [r12, #312]
	str r9, [r12, #540]
	umlal r7, r4, r11, r1
	ldr r1, [r12, #332]
	mov r9, r7
	ldr r7, [r12, #516]
	ldr r5, [r12, #504]
	umlal r7, r14, r11, r1
	mov r1, r7
	mov r7, r0
	ldr r0, [r12, #536]
	umlal r10, r5, r11, r3
	umlal r7, r2, r3, r0
	str r2, [r12, #544]
	str r7, [r12, #548]
	ldr r3, [r12, #320]
	mov r2, r0
	umlal r10, r5, r3, r0
	str r10, [r12, #552]
	mov r10, r4
	ldr r0, [r12, #336]
	ldr r4, [r12, #344]
	umlal r9, r10, r0, r2
	str r9, [r12, #556]
	mov r9, r1
	ldr r7, [r12, #532]
	umlal r9, r14, r4, r2
	str r5, [r12, #560]
	ldr r2, [r12, #352]
	ldr r5, [r12, #528]
	str r14, [r12, #564]
	umlal r5, r7, r11, r2
	str r9, [r12, #568]
	mov r14, r5
	mov r9, r7
	ldr r5, [r12, #380]
	ldr r2, [r12, #536]
	ldr r4, [r12, #404]
	umlal r14, r9, r5, r2
	ldr r5, [r12, #540]
	str r9, [r12, #572]
	lsl r9, r3, #1
	umlal r5, r6, r4, r9
	mov r1, r5
	ldr r7, [r12, #452]
	ldr r5, [r12, #448]
	ldr r4, [r12, #484]
	str r10, [r12, #576]
	umlal r7, r5, r4, r9
	mov r10, r1
	str r14, [r12, #580]
	mov r14, r5
	mov r5, r7
	ldr r4, [r12, #500]
	ldr r7, [r12, #496]
	umlal r4, r7, r11, r9
	ldr r1, [r12, #312]
	mov r2, r7
	ldr r7, [r12, #428]
	umlal r10, r6, r7, r1
	str r6, [r12, #584]
	mov r6, r2
	ldr r7, [r12, #536]
	mov r2, r10
	mov r4, r4
	mov r10, r5
	umlal r4, r6, r1, r7
	ldr r7, [r12, #512]
	umlal r10, r14, r7, r1
	ldr r1, [r12, #520]
	str r4, [r12, #592]
	ldr r4, [r12, #524]
	umull r7, r5, r4, r3
	str r6, [r12, #588]
	umull r3, r6, r4, r1
	ldr r4, [r12, #328]
	umlal r7, r5, r4, r1
	mov r4, r4
	ldr r1, [r12, #420]
	umlal r3, r6, r4, r1
	ldr r1, [r12, #356]
	ldr r4, [r12, #312]
	umlal r7, r5, r1, r4
	umlal r3, r6, r1, r9
	ldr r1, [r12, #360]
	umlal r7, r5, r1, r0
	ldr r9, [r12, #584]
	umlal r3, r6, r1, r4
	lsl r4, r0, #1
	ldr r0, [r12, #404]
	umlal r3, r6, r0, r4
	ldr r1, [r12, #484]
	umlal r2, r9, r1, r4
	umlal r10, r14, r11, r4
	mov r6, r6
	mov r1, r6
	ldr r4, [r12, #428]
	mov r6, r9
	ldr r9, [r12, #332]
	umlal r7, r5, r0, r9
	ldr r0, [r12, #512]
	umlal r2, r6, r0, r9
	ldr r0, [r12, #344]
	umlal r7, r5, r4, r0
	ldr r0, [r12, #536]
	umlal r3, r1, r4, r9
	ldr r4, [r12, #344]
	lsl r4, r4, #1
	ldr r9, [r12, #332]
	mov r1, r1
	umlal r2, r6, r11, r4
	umlal r10, r14, r9, r0
	ldr r9, [r12, #484]
	mov r2, r2
	ldr r0, [r12, #536]
	umlal r3, r1, r9, r4
	ldr r4, [r12, #352]
	umlal r2, r6, r4, r0
	ldr r0, [r12, #380]
	umlal r7, r5, r9, r4
	ldr r9, [r12, #512]
	str r2, [r12, #596]
	umlal r3, r1, r9, r4
	lsls r2, r0, #1
	umlal r7, r5, r9, r0
	ldr r4, [r12, #384]
	umlal r3, r1, r11, r2
	umlal r7, r5, r11, r4
	ldr r11, [r12, #536]
	mov r0, r3
	ldr r2, [r12, #412]
	umlal r0, r1, r4, r11
	mov r9, r7
	ldr r4, [r12, #548]
	umlal r9, r5, r11, r2
	str r0, [r12, #600]
	ldr r7, [r12, #552]
	lsrs r3, r4, #26
	ldr r2, [r12, #544]
	orr r3, r3, r2, lsl   #6
	adds r3, r7, r3
	ldr r7, [r12, #560]
	ldr r0, [r12, #592]
	adc r2, r7, r2, lsr   #26
	bic r7, r4, #0xFC000000
	lsrs r4, r3, #25
	orr r4, r4, r2, lsl   #7
	adds r4, r0, r4
	str r10, [r12, #604]
	str r9, [r12, #608]
	ldr r0, [r12, #588]
	lsr r9, r4, #26
	adc r2, r0, r2, lsr   #25
	ldr r0, [r12, #556]
	orr r9, r9, r2, lsl   #6
	adds r9, r0, r9
	ldr r0, [r12, #576]
	lsr r10, r9, #25
	adc r2, r0, r2, lsr   #26
	ldr r0, [r12, #604]
	orr r10, r10, r2, lsl   #7
	adds r10, r0, r10
	adc r2, r14, r2, lsr   #25
	bic r11, r3, #0xFE000000
	lsr r14, r10, #26
	ldr r3, [r12, #568]
	orr r14, r14, r2, lsl   #6
	ldr r0, [r12, #316]
	adds r14, r3, r14
	ldr r3, [r12, #564]
	bic r9, r9, #0xFE000000
	adc r2, r3, r2, lsr   #26
	str r9, [r0, #12]
	ldr r3, [r12, #596]
	lsr r9, r14, #25
	orr r9, r9, r2, lsl   #7
	adds r9, r3, r9
	adc r2, r6, r2, lsr   #25
	bic r6, r14, #0xFE000000
	ldr r3, [r12, #580]
	str r6, [r0, #20]
	lsr r6, r9, #26
	orr r6, r6, r2, lsl   #6
	adds r6, r3, r6
	ldr r3, [r12, #572]
	lsr r14, r6, #25
	adc r2, r3, r2, lsr   #26
	ldr r3, [r12, #600]
	orr r14, r14, r2, lsl   #7
	adds r14, r3, r14
	adc r1, r1, r2, lsr   #25
	ldr r3, [r12, #608]
	lsr r2, r14, #26
	orr r2, r2, r1, lsl   #6
	bic r9, r9, #0xFC000000
	str r9, [r0, #24]
	bic r6, r6, #0xFE000000
	adds r9, r3, r2
	adc r5, r5, r1, lsr   #26
	bic r2, r14, #0xFC000000
	str r6, [r0, #28]
	lsr r6, r9, #25
	orr r6, r6, r5, lsl   #7
	str r2, [r0, #32]
	lsrs r5, r5, #25
	bic r2, r9, #0xFE000000
	str r2, [r0, #36]
	lsls r1, r5, #3
	lsls r2, r6, #3
	adds r2, r2, r6
	orr r1, r1, r6, lsr   #29
	adc r1, r5, r1
	adds r2, r2, r2
	adcs r1, r1, r1
	adds r2, r2, r6
	adc r5, r5, r1
	adds r2, r2, r7
	adc r5, r5, #0
	lsrs r1, r2, #26
	orr r1, r1, r5, lsl   #6
	add r3, r11, r1
	bic r4, r4, #0xFC000000
	add r4, r4, r3, lsr   #25
	bic r10, r10, #0xFC000000
	bic r2, r2, #0xFC000000
	bic r3, r3, #0xFE000000
	str r2, [r0, #0]
	str r3, [r0, #4]
	str r10, [r0, #16]
	str r4, [r0, #8]
	ldr r0, [r12, #0]
	ldr r1, [r12, #4]
	ldr r2, [r12, #8]
	mov r14, r2
	ldr r2, [r1, #36]
	mov r6, r2
	ldr r2, [r14, #8]
	mov r9, #38
	str r2, [r12, #612]
	ldr r2, [r1, #32]
	str r0, [r12, #616]
	mov r0, r2
	ldr r3, [r14, #12]
	ldr r5, [r14, #4]
	add r11, r3, r3, lsl   #3
	add r11, r3, r11, lsl   #1
	ldr r2, [r12, #612]
	mul r4, r9, r5
	str r5, [r12, #620]
	umull r11, r5, r11, r0
	add r10, r2, r2, lsl   #3
	add r10, r2, r10, lsl   #1
	umlal r11, r5, r6, r10
	umull r10, r2, r10, r0
	str r1, [r12, #624]
	ldr r1, [r14, #16]
	str r6, [r12, #628]
	umlal r10, r2, r6, r4
	add r6, r1, r1, lsl   #3
	mul r7, r9, r3
	add r6, r1, r6, lsl   #1
	str r1, [r12, #632]
	str r3, [r12, #636]
	ldr r4, [r14, #20]
	ldr r1, [r12, #624]
	str r7, [r12, #640]
	ldr r3, [r1, #28]
	mov r1, r4
	add r4, r4, r4, lsl     #3
	umlal r11, r5, r6, r3
	str r1, [r12, #644]
	umlal r10, r2, r7, r3
	mul r7, r9, r1
	ldr r9, [r12, #624]
	add r4, r1, r4, lsl     #1
	ldr r1, [r9, #24]
	str r1, [r12, #660]
	umlal r11, r5, r4, r1
	ldr r9, [r14, #24]
	umlal r10, r2, r6, r1
	ldr r1, [r14, #28]
	str r9, [r12, #652]
	str r10, [r12, #664]
	add r10, r9, r9, lsl     #3
	str r3, [r12, #656]
	umull r3, r4, r0, r4
	add r9, r9, r10, lsl     #1
	add r10, r1, r1, lsl     #3
	str r7, [r12, #648]
	ldr r7, [r12, #628]
	str r1, [r12, #680]
	umlal r3, r4, r7, r6
	add r1, r1, r10, lsl     #1
	ldr r10, [r12, #656]
	umlal r3, r4, r9, r10
	mov r10, r7
	str r1, [r12, #676]
	ldr r7, [r12, #660]
	umlal r3, r4, r1, r7
	ldr r1, [r14, #32]
	str r1, [r12, #684]
	umull r6, r1, r6, r0
	str r4, [r12, #688]
	ldr r4, [r12, #640]
	umlal r6, r1, r10, r4
	ldr r4, [r12, #656]
	mov r10, r11
	ldr r11, [r12, #648]
	umlal r6, r1, r11, r4
	ldr r11, [r12, #624]
	ldr r4, [r12, #684]
	umlal r6, r1, r9, r7
	ldr r7, [r11, #20]
	str r7, [r12, #704]
	add r11, r4, r4, lsl     #3
	str r6, [r12, #672]
	ldr r6, [r12, #680]
	add r11, r4, r11, lsl     #1
	ldr r4, [r12, #688]
	str r1, [r12, #668]
	umlal r3, r4, r11, r7
	umlal r10, r5, r9, r7
	ldr r1, [r12, #648]
	str r3, [r12, #708]
	ldr r3, [r12, #664]
	umlal r3, r2, r1, r7
	mov r1, #38
	mul r1, r1, r6
	ldr r6, [r12, #672]
	str r2, [r12, #692]
	ldr r2, [r12, #668]
	umlal r6, r2, r1, r7
	ldr r7, [r14, #0]
	str r1, [r12, #696]
	ldr r1, [r14, #36]
	mov r1, r1
	str r6, [r12, #700]
	mov r6, r2
	mov r14, #38
	str r1, [r12, #712]
	mul r14, r14, r1
	ldr r1, [r12, #624]
	ldr r2, [r12, #692]
	str r7, [r12, #716]
	ldr r7, [r1, #16]
	str r14, [r12, #720]
	umlal r3, r2, r9, r7
	str r3, [r12, #724]
	ldr r3, [r12, #700]
	ldr r1, [r12, #676]
	umlal r3, r6, r11, r7
	str r7, [r12, #728]
	umlal r10, r5, r1, r7
	umull r7, r14, r0, r1
	str r3, [r12, #732]
	ldr r3, [r12, #628]
	str r6, [r12, #736]
	umlal r7, r14, r3, r9
	mov r6, r7
	ldr r1, [r12, #656]
	umull r7, r9, r9, r0
	umlal r6, r14, r11, r1
	str r6, [r12, #740]
	ldr r6, [r12, #648]
	str r14, [r12, #744]
	umlal r7, r9, r3, r6
	ldr r6, [r12, #696]
	ldr r3, [r12, #728]
	umlal r7, r9, r6, r1
	ldr r1, [r12, #660]
	ldr r6, [r12, #720]
	umlal r7, r9, r11, r1
	ldr r1, [r12, #704]
	umlal r7, r9, r6, r1
	mov r14, r7
	ldr r7, [r12, #716]
	ldr r6, [r12, #712]
	umlal r14, r9, r3, r7
	add r7, r6, r6, lsl   #3
	ldr r1, [r12, #660]
	str r9, [r12, #748]
	add r9, r6, r7, lsl   #1
	ldr r6, [r12, #740]
	ldr r7, [r12, #744]
	str r14, [r12, #752]
	umlal r6, r7, r9, r1
	mov r14, r7
	mov r7, r6
	ldr r6, [r12, #708]
	ldr r1, [r12, #704]
	umlal r6, r4, r9, r3
	str r4, [r12, #756]
	ldr r4, [r12, #716]
	str r6, [r12, #760]
	umlal r7, r14, r1, r4
	ldr r4, [r12, #728]
	ldr r1, [r12, #620]
	umlal r7, r14, r4, r1
	ldr r1, [r12, #624]
	ldr r4, [r1, #12]
	ldr r1, [r12, #724]
	ldr r6, [r12, #696]
	ldr r3, [r12, #736]
	umlal r1, r2, r6, r4
	ldr r6, [r12, #720]
	str r1, [r12, #764]
	ldr r1, [r12, #732]
	umlal r10, r5, r11, r4
	umlal r1, r3, r6, r4
	ldr r6, [r12, #760]
	str r3, [r12, #768]
	str r1, [r12, #772]
	ldr r3, [r12, #756]
	ldr r1, [r12, #716]
	str r5, [r12, #776]
	umlal r6, r3, r4, r1
	mov r5, r4
	mov r4, r3
	mov r3, r7
	str r6, [r12, #780]
	ldr r6, [r12, #612]
	str r5, [r12, #784]
	umlal r3, r14, r5, r6
	ldr r5, [r12, #624]
	ldr r6, [r12, #764]
	ldr r5, [r5, #8]
	umlal r6, r2, r11, r5
	str r6, [r12, #788]
	str r2, [r12, #792]
	mov r2, r5
	ldr r6, [r12, #776]
	umlal r10, r6, r9, r5
	ldr r5, [r12, #772]
	ldr r7, [r12, #768]
	umlal r5, r7, r2, r1
	str r7, [r12, #796]
	str r5, [r12, #800]
	ldr r7, [r12, #780]
	ldr r5, [r12, #620]
	str r6, [r12, #804]
	umlal r7, r4, r2, r5
	mov r6, r2
	mov r2, r3
	str r7, [r12, #808]
	ldr r7, [r12, #636]
	str r6, [r12, #812]
	umlal r2, r14, r6, r7
	umull r6, r7, r0, r9
	str r2, [r12, #816]
	ldr r2, [r12, #628]
	ldr r3, [r12, #656]
	umlal r6, r7, r2, r11
	umlal r6, r7, r3, r1
	str r1, [r12, #820]
	ldr r1, [r12, #660]
	str r0, [r12, #824]
	umlal r6, r7, r1, r5
	ldr r1, [r12, #704]
	ldr r5, [r12, #612]
	umlal r6, r7, r1, r5
	ldr r1, [r12, #728]
	ldr r5, [r12, #636]
	umlal r6, r7, r1, r5
	ldr r1, [r12, #784]
	ldr r5, [r12, #632]
	umlal r6, r7, r1, r5
	ldr r1, [r12, #812]
	ldr r5, [r12, #644]
	mov r9, r6
	umull r11, r6, r11, r0
	ldr r0, [r12, #696]
	umlal r9, r7, r1, r5
	umlal r11, r6, r2, r0
	ldr r2, [r12, #820]
	ldr r1, [r12, #720]
	umlal r11, r6, r1, r3
	ldr r3, [r12, #792]
	str r7, [r12, #832]
	ldr r7, [r12, #660]
	umlal r11, r6, r7, r2
	ldr r7, [r12, #624]
	ldr r0, [r12, #788]
	str r9, [r12, #828]
	str r11, [r12, #840]
	ldr r11, [r7, #4]
	ldr r5, [r12, #804]
	umlal r0, r3, r1, r11
	umlal r10, r5, r11, r2
	ldr r9, [r12, #808]
	mov r0, r0
	ldr r1, [r12, #612]
	umlal r9, r4, r11, r1
	ldr r1, [r7, #0]
	mov r7, r0
	ldr r0, [r12, #836]
	umlal r7, r3, r2, r0
	mov r2, r9
	str r1, [r12, #836]
	mov r9, r0
	str r3, [r12, #844]
	ldr r3, [r12, #620]
	str r7, [r12, #848]
	mov r7, r4
	umlal r10, r5, r3, r0
	ldr r0, [r12, #636]
	umlal r2, r7, r0, r9
	ldr r1, [r12, #632]
	str r5, [r12, #860]
	ldr r5, [r12, #816]
	umlal r5, r14, r11, r1
	ldr r1, [r12, #652]
	ldr r4, [r12, #644]
	str r7, [r12, #876]
	mov r7, r5
	ldr r5, [r12, #828]
	str r2, [r12, #856]
	ldr r2, [r12, #832]
	umlal r5, r2, r11, r1
	mov r1, r7
	umlal r1, r14, r4, r9
	ldr r4, [r12, #680]
	ldr r7, [r12, #704]
	lsl r9, r3, #1
	str r1, [r12, #868]
	ldr r1, [r12, #836]
	str r10, [r12, #852]
	ldr r10, [r12, #840]
	str r14, [r12, #864]
	umlal r10, r6, r7, r9
	mov r14, r5
	mov r2, r2
	ldr r7, [r12, #752]
	umlal r14, r2, r4, r1
	mov r5, r10
	ldr r1, [r12, #784]
	str r2, [r12, #872]
	ldr r2, [r12, #748]
	str r14, [r12, #880]
	umlal r7, r2, r1, r9
	ldr r4, [r12, #800]
	mov r10, r5
	mov r14, r2
	mov r5, r7
	ldr r7, [r12, #796]
	umlal r4, r7, r11, r9
	ldr r1, [r12, #612]
	mov r2, r7
	ldr r7, [r12, #728]
	umlal r10, r6, r7, r1
	mov r7, r10
	mov r10, r5
	ldr r5, [r12, #812]
	str r6, [r12, #884]
	umlal r10, r14, r5, r1
	mov r6, r4
	mov r5, r2
	ldr r2, [r12, #836]
	umlal r6, r5, r1, r2
	ldr r1, [r12, #824]
	str r5, [r12, #888]
	umull r4, r5, r1, r3
	ldr r2, [r12, #628]
	str r6, [r12, #892]
	ldr r6, [r12, #820]
	umlal r4, r5, r2, r6
	umull r3, r1, r1, r6
	mov r6, r2
	ldr r2, [r12, #720]
	umlal r3, r1, r6, r2
	ldr r2, [r12, #612]
	ldr r6, [r12, #656]
	umlal r3, r1, r6, r9
	umlal r4, r5, r6, r2
	ldr r6, [r12, #660]
	lsl r9, r0, #1
	umlal r3, r1, r6, r2
	umlal r4, r5, r6, r0
	ldr r6, [r12, #784]
	ldr r0, [r12, #884]
	umlal r10, r14, r11, r9
	umlal r7, r0, r6, r9
	mov r6, r0
	ldr r0, [r12, #704]
	umlal r3, r1, r0, r9
	mov r2, r1
	mov r9, r2
	ldr r1, [r12, #632]
	ldr r2, [r12, #644]
	umlal r4, r5, r0, r1
	ldr r0, [r12, #812]
	umlal r7, r6, r0, r1
	ldr r0, [r12, #728]
	umlal r3, r9, r0, r1
	mov r1, r9
	umlal r4, r5, r0, r2
	ldr r0, [r12, #632]
	ldr r2, [r12, #836]
	umlal r10, r14, r0, r2
	ldr r2, [r12, #644]
	ldr r0, [r12, #784]
	lsl r9, r2, #1
	umlal r7, r6, r11, r9
	umlal r3, r1, r0, r9
	mov r9, r7
	ldr r2, [r12, #652]
	ldr r7, [r12, #836]
	umlal r4, r5, r0, r2
	ldr r0, [r12, #812]
	umlal r9, r6, r2, r7
	umlal r3, r1, r0, r2
	ldr r2, [r12, #680]
	str r9, [r12, #896]
	lsls r7, r2, #1
	umlal r3, r1, r11, r7
	mov r9, r3
	umlal r4, r5, r0, r2
	ldr r7, [r12, #836]
	ldr r2, [r12, #684]
	ldr r3, [r12, #712]
	umlal r4, r5, r11, r2
	umlal r9, r1, r2, r7
	str r9, [r12, #900]
	mov r9, r4
	ldr r4, [r12, #848]
	ldr r2, [r12, #844]
	umlal r9, r5, r7, r3
	ldr r7, [r12, #852]
	lsrs r3, r4, #26
	orr r3, r3, r2, lsl   #6
	adds r3, r7, r3
	ldr r7, [r12, #860]
	ldr r0, [r12, #892]
	adc r2, r7, r2, lsr   #26
	bic r7, r4, #0xFC000000
	lsrs r4, r3, #25
	orr r4, r4, r2, lsl   #7
	adds r4, r0, r4
	str r10, [r12, #904]
	str r9, [r12, #908]
	ldr r0, [r12, #888]
	lsr r9, r4, #26
	adc r2, r0, r2, lsr   #25
	ldr r0, [r12, #856]
	orr r9, r9, r2, lsl   #6
	adds r9, r0, r9
	ldr r0, [r12, #876]
	lsr r10, r9, #25
	adc r2, r0, r2, lsr   #26
	ldr r0, [r12, #904]
	orr r10, r10, r2, lsl   #7
	adds r10, r0, r10
	adc r2, r14, r2, lsr   #25
	bic r11, r3, #0xFE000000
	lsr r14, r10, #26
	ldr r3, [r12, #868]
	orr r14, r14, r2, lsl   #6
	ldr r0, [r12, #616]
	adds r14, r3, r14
	ldr r3, [r12, #864]
	bic r9, r9, #0xFE000000
	adc r2, r3, r2, lsr   #26
	str r9, [r0, #12]
	ldr r3, [r12, #896]
	lsr r9, r14, #25
	orr r9, r9, r2, lsl   #7
	adds r9, r3, r9
	adc r2, r6, r2, lsr   #25
	bic r3, r14, #0xFE000000
	ldr r6, [r12, #880]
	str r3, [r0, #20]
	lsr r3, r9, #26
	orr r3, r3, r2, lsl     #6
	bic r9, r9, #0xFC000000
	adds r3, r6, r3
	ldr r6, [r12, #872]
	lsr r14, r3, #25
	adc r6, r6, r2, lsr     #26
	ldr r2, [r12, #900]
	str r9, [r0, #24]
	orr r14, r14, r6, lsl     #7
	ldr r9, [r12, #908]
	adds r14, r2, r14
	bic r2, r3, #0xFE000000
	adc r3, r1, r6, lsr     #25
	lsr r1, r14, #26
	bic r6, r14, #0xFC000000
	str r2, [r0, #28]
	orr r1, r1, r3, lsl     #6
	str r6, [r0, #32]
	adds r9, r9, r1
	bic r1, r4, #0xFC000000
	adc r5, r5, r3, lsr     #26
	lsr r4, r9, #25
	lsrs r6, r5, #25
	bic r2, r9, #0xFE000000
	orr r5, r4, r5, lsl     #7
	str r2, [r0, #36]
	lsls r4, r6, #3
	lsls r2, r5, #3
	adds r3, r2, r5
	orr r2, r4, r5, lsr     #29
	adc r9, r6, r2
	adds r3, r3, r3
	adcs r9, r9, r9
	adds r2, r3, r5
	adc r5, r6, r9
	adds r6, r2, r7
	adc r5, r5, #0
	lsrs r9, r6, #26
	bic r3, r10, #0xFC000000
	bic r10, r6, #0xFC000000
	orr r5, r9, r5, lsl     #6
	str r10, [r0, #0]
	add r10, r11, r5
	str r3, [r0, #16]
	bic r2, r10, #0xFE000000
	ldr r4, [r12, #0]
	add r1, r1, r10, lsr     #25
	str r2, [r0, #4]
	str r1, [r0, #8]
	ldr r1, [r12, #4]
	ldr r7, [r12, #8]
	mov r9, #38
	mov r14, r7
	ldr r7, [r1, #36]
	mov r6, r7
	ldr r10, [r14, #8]
	str r10, [r12, #912]
	ldr r11, [r1, #32]
	str r4, [r12, #916]
	ldr r3, [r14, #12]
	mov r0, r11
	ldr r10, [r12, #912]
	ldr r5, [r14, #4]
	add r2, r3, r3, lsl     #3
	mul r4, r9, r5
	add r7, r10, r10, lsl     #3
	add r2, r3, r2, lsl     #1
	str r5, [r12, #920]
	umull r11, r5, r2, r0
	add r7, r10, r7, lsl     #1
	umull r10, r2, r7, r0
	str r1, [r12, #924]
	umlal r11, r5, r6, r7
	ldr r1, [r14, #16]
	str r6, [r12, #928]
	umlal r10, r2, r6, r4
	add r6, r1, r1, lsl   #3
	mul r7, r9, r3
	add r6, r1, r6, lsl   #1
	str r1, [r12, #932]
	ldr r1, [r12, #924]
	ldr r4, [r14, #20]
	str r3, [r12, #936]
	ldr r3, [r1, #28]
	str r7, [r12, #940]
	umlal r10, r2, r7, r3
	mov r7, r4
	mul r9, r9, r7
	ldr r1, [r14, #24]
	add r4, r4, r4, lsl   #3
	add r4, r7, r4, lsl   #1
	str r7, [r12, #944]
	add r7, r1, r1, lsl   #3
	str r9, [r12, #948]
	umlal r11, r5, r6, r3
	add r9, r1, r7, lsl   #1
	str r1, [r12, #952]
	ldr r1, [r12, #924]
	str r3, [r12, #956]
	ldr r7, [r1, #24]
	ldr r1, [r12, #928]
	umlal r10, r2, r6, r7
	umlal r11, r5, r4, r7
	str r7, [r12, #960]
	umull r7, r4, r0, r4
	umlal r7, r4, r1, r6
	ldr r3, [r12, #956]
	str r10, [r12, #964]
	umlal r7, r4, r9, r3
	mov r3, r1
	umull r10, r6, r6, r0
	ldr r1, [r12, #940]
	umlal r10, r6, r3, r1
	ldr r1, [r12, #948]
	ldr r3, [r12, #956]
	umlal r10, r6, r1, r3
	ldr r3, [r12, #960]
	umlal r10, r6, r9, r3
	str r6, [r12, #968]
	str r10, [r12, #972]
	ldr r1, [r14, #28]
	ldr r6, [r14, #32]
	add r10, r1, r1, lsl   #3
	add r10, r1, r10, lsl   #1
	umlal r7, r4, r10, r3
	str r10, [r12, #976]
	mov r10, r11
	mov r11, #38
	str r1, [r12, #980]
	ldr r1, [r12, #924]
	ldr r3, [r12, #964]
	ldr r1, [r1, #20]
	str r6, [r12, #984]
	ldr r6, [r12, #948]
	str r4, [r12, #988]
	umlal r3, r2, r6, r1
	ldr r4, [r12, #980]
	str r2, [r12, #992]
	mul r11, r11, r4
	ldr r2, [r12, #968]
	ldr r4, [r12, #972]
	str r11, [r12, #996]
	umlal r4, r2, r11, r1
	str r4, [r12, #1000]
	ldr r4, [r12, #984]
	umlal r10, r5, r9, r1
	add r11, r4, r4, lsl   #3
	add r11, r4, r11, lsl   #1
	ldr r4, [r12, #988]
	str r1, [r12, #1004]
	umlal r7, r4, r11, r1
	str r7, [r12, #1008]
	ldr r7, [r14, #36]
	mov r6, r2
	mov r1, r7
	ldr r7, [r14, #0]
	mov r14, #38
	str r1, [r12, #1012]
	mul r14, r14, r1
	ldr r1, [r12, #924]
	ldr r2, [r12, #992]
	str r7, [r12, #1016]
	ldr r7, [r1, #16]
	str r14, [r12, #1020]
	umlal r3, r2, r9, r7
	str r3, [r12, #1024]
	ldr r3, [r12, #1000]
	ldr r1, [r12, #976]
	umlal r3, r6, r11, r7
	str r7, [r12, #1028]
	umlal r10, r5, r1, r7
	umull r7, r14, r0, r1
	str r3, [r12, #1032]
	ldr r3, [r12, #928]
	str r6, [r12, #1036]
	umlal r7, r14, r3, r9
	mov r6, r7
	ldr r1, [r12, #956]
	umull r7, r9, r9, r0
	umlal r6, r14, r11, r1
	str r6, [r12, #1040]
	ldr r6, [r12, #948]
	str r14, [r12, #1044]
	umlal r7, r9, r3, r6
	ldr r6, [r12, #996]
	ldr r3, [r12, #1028]
	umlal r7, r9, r6, r1
	ldr r1, [r12, #960]
	ldr r6, [r12, #1020]
	umlal r7, r9, r11, r1
	ldr r1, [r12, #1004]
	umlal r7, r9, r6, r1
	mov r14, r7
	ldr r7, [r12, #1016]
	ldr r6, [r12, #1012]
	umlal r14, r9, r3, r7
	add r7, r6, r6, lsl   #3
	ldr r1, [r12, #960]
	add r6, r6, r7, lsl     #1
	ldr r7, [r12, #1044]
	str r9, [r12, #1048]
	ldr r9, [r12, #1040]
	umlal r9, r7, r6, r1
	ldr r1, [r12, #1008]
	str r14, [r12, #1052]
	umlal r1, r4, r6, r3
	mov r14, r7
	ldr r3, [r12, #924]
	str r4, [r12, #1056]
	ldr r4, [r3, #12]
	ldr r7, [r12, #996]
	umlal r10, r5, r11, r4
	mov r9, r9
	ldr r3, [r12, #1024]
	umlal r3, r2, r7, r4
	ldr r7, [r12, #1064]
	str r5, [r12, #1076]
	ldr r5, [r12, #1016]
	str r1, [r12, #1060]
	ldr r1, [r12, #924]
	str r3, [r12, #1064]
	ldr r3, [r12, #1004]
	umlal r9, r14, r3, r5
	ldr r1, [r1, #8]
	mov r3, r4
	umlal r7, r2, r11, r1
	ldr r5, [r12, #1076]
	str r3, [r12, #1084]
	str r2, [r12, #1092]
	umlal r10, r5, r6, r1
	str r7, [r12, #1088]
	ldr r2, [r12, #1028]
	ldr r7, [r12, #920]
	umlal r9, r14, r2, r7
	ldr r7, [r12, #1068]
	str r5, [r12, #1104]
	ldr r5, [r12, #1016]
	mov r2, r9
	ldr r9, [r12, #912]
	umlal r2, r14, r3, r9
	mov r9, r1
	ldr r3, [r12, #936]
	mov r1, r9
	mov r2, r2
	str r1, [r12, #1112]
	umlal r2, r14, r1, r3
	ldr r3, [r12, #1072]
	umlal r3, r7, r9, r5
	ldr r1, [r12, #1032]
	str r2, [r12, #1116]
	ldr r2, [r12, #1020]
	str r7, [r12, #1096]
	ldr r7, [r12, #1036]
	umlal r1, r7, r2, r4
	ldr r2, [r12, #1056]
	str r3, [r12, #1100]
	ldr r3, [r12, #1060]
	str r1, [r12, #1072]
	umlal r3, r2, r4, r5
	str r7, [r12, #1068]
	umull r6, r7, r0, r6
	mov r4, r2
	ldr r1, [r12, #920]
	str r3, [r12, #1080]
	ldr r3, [r12, #1080]
	umlal r3, r4, r9, r1
	ldr r2, [r12, #928]
	str r5, [r12, #1120]
	umlal r6, r7, r2, r11
	str r3, [r12, #1108]
	ldr r3, [r12, #956]
	umlal r6, r7, r3, r5
	ldr r5, [r12, #912]
	str r0, [r12, #1124]
	ldr r9, [r12, #960]
	umlal r6, r7, r9, r1
	ldr r1, [r12, #1004]
	umlal r6, r7, r1, r5
	ldr r1, [r12, #1028]
	ldr r5, [r12, #936]
	umlal r6, r7, r1, r5
	ldr r1, [r12, #1084]
	ldr r5, [r12, #932]
	umlal r6, r7, r1, r5
	mov r9, r6
	ldr r5, [r12, #944]
	ldr r6, [r12, #1112]
	umlal r9, r7, r6, r5
	str r9, [r12, #1128]
	umull r9, r6, r11, r0
	str r7, [r12, #1132]
	ldr r7, [r12, #996]
	umlal r9, r6, r2, r7
	ldr r7, [r12, #1020]
	ldr r2, [r12, #924]
	umlal r9, r6, r7, r3
	ldr r11, [r2, #4]
	ldr r2, [r2, #0]
	ldr r1, [r12, #960]
	ldr r3, [r12, #1120]
	str r2, [r12, #1136]
	ldr r5, [r12, #1088]
	ldr r2, [r12, #1092]
	umlal r5, r2, r7, r11
	mov r0, r5
	umlal r9, r6, r1, r3
	ldr r7, [r12, #1108]
	ldr r1, [r12, #912]
	str r9, [r12, #1140]
	umlal r7, r4, r11, r1
	ldr r1, [r12, #932]
	mov r9, r7
	ldr r7, [r12, #1116]
	ldr r5, [r12, #1104]
	umlal r7, r14, r11, r1
	mov r1, r7
	mov r7, r0
	ldr r0, [r12, #1136]
	umlal r10, r5, r11, r3
	umlal r7, r2, r3, r0
	str r2, [r12, #1144]
	str r7, [r12, #1148]
	ldr r3, [r12, #920]
	mov r2, r0
	umlal r10, r5, r3, r0
	str r10, [r12, #1152]
	mov r10, r4
	ldr r0, [r12, #936]
	ldr r4, [r12, #944]
	umlal r9, r10, r0, r2
	str r9, [r12, #1156]
	mov r9, r1
	ldr r7, [r12, #1132]
	umlal r9, r14, r4, r2
	str r5, [r12, #1160]
	ldr r2, [r12, #952]
	ldr r5, [r12, #1128]
	str r14, [r12, #1164]
	umlal r5, r7, r11, r2
	str r9, [r12, #1168]
	mov r14, r5
	mov r9, r7
	ldr r5, [r12, #980]
	ldr r2, [r12, #1136]
	ldr r4, [r12, #1004]
	umlal r14, r9, r5, r2
	ldr r5, [r12, #1140]
	str r9, [r12, #1172]
	lsl r9, r3, #1
	umlal r5, r6, r4, r9
	mov r1, r5
	ldr r7, [r12, #1052]
	ldr r5, [r12, #1048]
	ldr r4, [r12, #1084]
	str r10, [r12, #1176]
	umlal r7, r5, r4, r9
	mov r10, r1
	str r14, [r12, #1180]
	mov r14, r5
	mov r5, r7
	ldr r4, [r12, #1100]
	ldr r7, [r12, #1096]
	umlal r4, r7, r11, r9
	ldr r1, [r12, #912]
	mov r2, r7
	ldr r7, [r12, #1028]
	umlal r10, r6, r7, r1
	mov r7, r10
	mov r10, r5
	ldr r5, [r12, #1112]
	str r6, [r12, #1184]
	umlal r10, r14, r5, r1
	mov r6, r4
	mov r5, r2
	ldr r2, [r12, #1136]
	umlal r6, r5, r1, r2
	ldr r1, [r12, #1124]
	str r5, [r12, #1188]
	umull r4, r5, r1, r3
	ldr r2, [r12, #928]
	str r6, [r12, #1192]
	ldr r6, [r12, #1120]
	umlal r4, r5, r2, r6
	umull r3, r1, r1, r6
	mov r6, r2
	ldr r2, [r12, #1020]
	umlal r3, r1, r6, r2
	ldr r2, [r12, #912]
	ldr r6, [r12, #956]
	umlal r3, r1, r6, r9
	umlal r4, r5, r6, r2
	ldr r6, [r12, #960]
	lsl r9, r0, #1
	umlal r3, r1, r6, r2
	umlal r4, r5, r6, r0
	ldr r6, [r12, #1084]
	ldr r0, [r12, #1184]
	umlal r10, r14, r11, r9
	umlal r7, r0, r6, r9
	mov r6, r0
	ldr r2, [r12, #1004]
	umlal r3, r1, r2, r9
	ldr r0, [r12, #932]
	umlal r4, r5, r2, r0
	ldr r2, [r12, #1112]
	mov r1, r1
	umlal r7, r6, r2, r0
	ldr r2, [r12, #1028]
	mov r1, r1
	umlal r3, r1, r2, r0
	ldr r9, [r12, #944]
	umlal r4, r5, r2, r9
	ldr r0, [r12, #944]
	lsl r2, r0, #1
	ldr r0, [r12, #1084]
	mov r1, r1
	umlal r7, r6, r11, r2
	umlal r3, r1, r0, r2
	ldr r9, [r12, #952]
	ldr r2, [r12, #1112]
	umlal r4, r5, r0, r9
	umlal r3, r1, r2, r9
	ldr r0, [r12, #980]
	umlal r4, r5, r2, r0
	lsls r2, r0, #1
	mov r0, r7
	ldr r7, [r12, #1136]
	umlal r3, r1, r11, r2
	ldr r2, [r12, #1136]
	umlal r0, r6, r9, r7
	ldr r7, [r12, #932]
	umlal r10, r14, r7, r2
	ldr r7, [r12, #1144]
	ldr r9, [r12, #984]
	mov r3, r3
	ldr r2, [r12, #1148]
	umlal r4, r5, r11, r9
	lsrs r11, r2, #26
	str r0, [r12, #1196]
	str r10, [r12, #1204]
	orr r10, r11, r7, lsl     #6
	mov r11, r4
	ldr r4, [r12, #1152]
	adds r10, r4, r10
	ldr r4, [r12, #1160]
	adc r0, r4, r7, lsr     #26
	ldr r7, [r12, #1136]
	umlal r3, r1, r9, r7
	lsrs r4, r10, #25
	ldr r9, [r12, #1188]
	orr r4, r4, r0, lsl     #7
	str r3, [r12, #1200]
	ldr r3, [r12, #1192]
	adds r4, r3, r4
	ldr r3, [r12, #1012]
	umlal r11, r5, r7, r3
	adc r0, r9, r0, lsr     #25
	lsr r9, r4, #26
	bic r7, r2, #0xFC000000
	ldr r2, [r12, #1156]
	orr r9, r9, r0, lsl     #6
	adds r9, r2, r9
	ldr r3, [r12, #1176]
	adc r0, r3, r0, lsr     #26
	str r11, [r12, #1208]
	bic r11, r10, #0xFE000000
	lsr r10, r9, #25
	ldr r3, [r12, #1204]
	orr r10, r10, r0, lsl     #7
	ldr r2, [r12, #1168]
	adds r10, r3, r10
	adc r0, r14, r0, lsr     #25
	ldr r3, [r12, #1164]
	lsr r14, r10, #26
	orr r14, r14, r0, lsl     #6
	bic r9, r9, #0xFE000000
	adds r14, r2, r14
	adc r2, r3, r0, lsr     #26
	ldr r0, [r12, #916]
	str r9, [r0, #12]
	ldr r3, [r12, #1196]
	lsr r9, r14, #25
	orr r9, r9, r2, lsl   #7
	adds r9, r3, r9
	adc r2, r6, r2, lsr   #25
	bic r6, r14, #0xFE000000
	ldr r3, [r12, #1180]
	str r6, [r0, #20]
	lsr r6, r9, #26
	orr r6, r6, r2, lsl   #6
	adds r6, r3, r6
	ldr r3, [r12, #1172]
	lsr r14, r6, #25
	adc r2, r3, r2, lsr   #26
	ldr r3, [r12, #1200]
	orr r14, r14, r2, lsl   #7
	adds r14, r3, r14
	adc r1, r1, r2, lsr   #25
	ldr r3, [r12, #1208]
	lsr r2, r14, #26
	orr r2, r2, r1, lsl   #6
	bic r9, r9, #0xFC000000
	str r9, [r0, #24]
	bic r6, r6, #0xFE000000
	adds r9, r3, r2
	adc r5, r5, r1, lsr   #26
	bic r2, r14, #0xFC000000
	str r6, [r0, #28]
	lsr r6, r9, #25
	orr r6, r6, r5, lsl   #7
	str r2, [r0, #32]
	lsrs r5, r5, #25
	bic r2, r9, #0xFE000000
	str r2, [r0, #36]
	lsls r1, r5, #3
	lsls r2, r6, #3
	adds r2, r2, r6
	orr r1, r1, r6, lsr   #29
	adc r1, r5, r1
	adds r2, r2, r2
	adcs r1, r1, r1
	adds r2, r2, r6
	adc r5, r5, r1
	adds r2, r2, r7
	adc r5, r5, #0
	lsrs r1, r2, #26
	orr r1, r1, r5, lsl   #6
	add r3, r11, r1
	bic r4, r4, #0xFC000000
	add r4, r4, r3, lsr   #25
	bic r10, r10, #0xFC000000
	bic r2, r2, #0xFC000000
	bic r3, r3, #0xFE000000
	str r2, [r0, #0]
	str r3, [r0, #4]
	str r10, [r0, #16]
	str r4, [r0, #8]
	ldr r9, [r8, #0]
	ldr r10, [r8, #40]
	eor r9, r9, r10
	ldr r10, [r8, #80]
	eor r9, r9, r10
	ldr r10, [r8, #120]
	eor r9, r9, r10
	ldr r10, [r8, #160]
	eor r9, r9, r10
	str r9, [r8, #400]
	ldr r9, [r8, #4]
	ldr r10, [r8, #44]
	eor r9, r9, r10
	ldr r10, [r8, #84]
	eor r9, r9, r10
	ldr r10, [r8, #124]
	eor r9, r9, r10
	ldr r10, [r8, #164]
	eor r9, r9, r10
	str r9, [r8, #404]
	ldr r9, [r8, #8]
	ldr r10, [r8, #48]
	eor r9, r9, r10
	ldr r10, [r8, #88]
	eor r9, r9, r10
	ldr r10, [r8, #128]
	eor r9, r9, r10
	ldr r10, [r8, #168]
	eor r9, r9, r10
	str r9, [r8, #408]
	ldr r9, [r8, #12]
	ldr r10, [r8, #52]
	eor r9, r9, r10
	ldr r10, [r8, #92]
	eor r9, r9, r10
	ldr r10, [r8, #132]
	eor r9, r9, r10
	ldr r10, [r8, #172]
	eor r9, r9, r10
	str r9, [r8, #412]
	ldr r9, [r8, #16]
	ldr r10, [r8, #56]
	eor r9, r9, r10
	ldr r10, [r8, #96]
	eor r9, r9, r10
	ldr r10, [r8, #136]
	eor r9, r9, r10
	ldr r10, [r8, #176]
	eor r9, r9, r10
	str r9, [r8, #416]
	ldr r9, [r8, #20]
	ldr r10, [r8, #60]
	eor r9, r9, r10
	ldr r10, [r8, #100]
	eor r9, r9, r10
	ldr r10, [r8, #140]
	eor r9, r9, r10
	ldr r10, [r8, #180]
	eor r9, r9, r10
	str r9, [r8, #420]
	ldr r9, [r8, #24]
	ldr r10, [r8, #64]
	eor r9, r9, r10
	ldr r10, [r8, #104]
	eor r9, r9, r10
	ldr r11, [r8, #144]
	eor r11, r9, r11
	ldr r7, [r8, #184]
	eor r11, r11, r7
	ldr r7, [r8, #28]
	str r11, [r8, #424]
	ldr r9, [r8, #68]
	eor r6, r7, r9
	ldr r9, [r8, #108]
	eor r11, r6, r9
	ldr r10, [r8, #148]
	eor r10, r11, r10
	ldr r11, [r8, #188]
	eor r10, r10, r11
	ldr r7, [r8, #32]
	str r10, [r8, #428]
	ldr r11, [r8, #72]
	eor r11, r7, r11
	ldr r10, [r8, #112]
	eor r6, r11, r10
	ldr r11, [r8, #152]
	eor r7, r6, r11
	ldr r11, [r8, #192]
	eor r6, r7, r11
	ldr r10, [r8, #36]
	str r6, [r8, #432]
	ldr r7, [r8, #76]
	eor r11, r10, r7
	ldr r9, [r8, #116]
	eor r6, r11, r9
	ldr r10, [r8, #156]
	eor r10, r6, r10
	ldr r9, [r8, #196]
	eor r6, r10, r9
	ldr r11, [r8, #412]
	str r6, [r8, #436]
	ldr r9, [r8, #432]
	eor r9, r9, r11, ror     #31
	ldr r11, [r8, #408]
	str r9, [r8, #440]
	ldr r6, [r8, #436]
	eor r11, r6, r11
	ldr r7, [r8, #420]
	str r11, [r8, #444]
	ldr r9, [r8, #400]
	eor r10, r9, r7, ror     #31
	ldr r7, [r8, #416]
	str r10, [r8, #448]
	ldr r10, [r8, #404]
	eor r10, r10, r7
	ldr r9, [r8, #428]
	str r10, [r8, #452]
	ldr r10, [r8, #408]
	eor r6, r10, r9, ror     #31
	ldr r7, [r8, #424]
	str r6, [r8, #456]
	ldr r11, [r8, #412]
	eor r6, r11, r7
	ldr r7, [r8, #436]
	str r6, [r8, #460]
	ldr r9, [r8, #416]
	eor r7, r9, r7, ror     #31
	ldr r9, [r8, #432]
	str r7, [r8, #464]
	ldr r7, [r8, #420]
	eor r7, r7, r9
	ldr r6, [r8, #404]
	str r7, [r8, #468]
	ldr r9, [r8, #424]
	eor r9, r9, r6, ror     #31
	ldr r7, [r8, #400]
	str r9, [r8, #472]
	ldr r11, [r8, #428]
	eor r11, r11, r7
	ldr r6, [r8, #440]
	str r11, [r8, #476]
	ldr r7, [r8, #444]
	ldr r9, [r8, #0]
	ldr r10, [r8, #4]
	eor r9, r9, r6
	eor r10, r10, r7
	str r9, [r8, #200]
	str r10, [r8, #204]
	ldr r9, [r8, #40]
	ldr r10, [r8, #44]
	eor r9, r9, r6
	eor r10, r10, r7
	ror r11, r9, #14
	str r11, [r8, #328]
	ror r11, r10, #14
	str r11, [r8, #332]
	ldr r9, [r8, #80]
	ldr r10, [r8, #84]
	eor r9, r9, r6
	eor r10, r10, r7
	ror r11, r10, #30
	str r11, [r8, #256]
	ror r11, r9, #31
	str r11, [r8, #260]
	ldr r9, [r8, #120]
	ldr r10, [r8, #124]
	eor r9, r9, r6
	eor r10, r10, r7
	ror r11, r10, #11
	str r11, [r8, #384]
	ror r11, r9, #12
	str r11, [r8, #388]
	ldr r9, [r8, #160]
	ldr r10, [r8, #164]
	eor r9, r9, r6
	eor r10, r10, r7
	ror r11, r9, #23
	str r11, [r8, #312]
	ror r11, r10, #23
	str r11, [r8, #316]
	ldr r6, [r8, #448]
	ldr r7, [r8, #452]
	ldr r9, [r8, #8]
	ldr r10, [r8, #12]
	eor r9, r9, r6
	eor r10, r10, r7
	ror r11, r10, #31
	str r11, [r8, #280]
	str r9, [r8, #284]
	ldr r9, [r8, #48]
	ldr r10, [r8, #52]
	eor r9, r9, r6
	eor r10, r10, r7
	ror r11, r9, #10
	str r11, [r8, #208]
	ror r11, r10, #10
	str r11, [r8, #212]
	ldr r9, [r8, #88]
	ldr r10, [r8, #92]
	eor r9, r9, r6
	eor r10, r10, r7
	ror r11, r9, #27
	str r11, [r8, #336]
	ror r11, r10, #27
	str r11, [r8, #340]
	ldr r9, [r8, #128]
	ldr r10, [r8, #132]
	eor r9, r9, r6
	eor r10, r10, r7
	ror r11, r10, #9
	str r11, [r8, #264]
	ror r11, r9, #10
	str r11, [r8, #268]
	ldr r9, [r8, #168]
	ldr r10, [r8, #172]
	eor r9, r9, r6
	eor r10, r10, r7
	ror r11, r9, #31
	str r11, [r8, #392]
	ror r11, r10, #31
	str r11, [r8, #396]
	ldr r6, [r8, #456]
	ldr r7, [r8, #460]
	ldr r9, [r8, #16]
	ldr r10, [r8, #20]
	eor r9, r9, r6
	eor r10, r10, r7
	ror r11, r9, #1
	str r11, [r8, #360]
	ror r11, r10, #1
	str r11, [r8, #364]
	ldr r9, [r8, #56]
	ldr r10, [r8, #60]
	eor r9, r9, r6
	eor r10, r10, r7
	ror r11, r9, #29
	str r11, [r8, #288]
	ror r11, r10, #29
	str r11, [r8, #292]
	ldr r9, [r8, #96]
	ldr r10, [r8, #100]
	eor r9, r9, r6
	eor r10, r10, r7
	ror r11, r10, #10
	str r11, [r8, #216]
	ror r11, r9, #11
	str r11, [r8, #220]
	ldr r9, [r8, #136]
	ldr r10, [r8, #140]
	eor r9, r9, r6
	eor r10, r10, r7
	ror r11, r10, #24
	str r11, [r8, #344]
	ror r11, r9, #25
	str r11, [r8, #348]
	ldr r9, [r8, #176]
	ldr r10, [r8, #180]
	eor r9, r9, r6
	eor r10, r10, r7
	ror r11, r10, #1
	str r11, [r8, #272]
	ror r11, r9, #2
	str r11, [r8, #276]
	ldr r6, [r8, #464]
	ldr r7, [r8, #468]
	ldr r9, [r8, #24]
	ldr r10, [r8, #28]
	eor r11, r9, r6
	eor r10, r10, r7
	ror r9, r11, #18
	ror r10, r10, #18
	str r9, [r8, #240]
	ldr r11, [r8, #64]
	str r10, [r8, #244]
	ldr r10, [r8, #68]
	eor r9, r11, r6
	eor r11, r10, r7
	ror r11, r11, #4
	ror r9, r9, #5
	str r11, [r8, #368]
	ldr r10, [r8, #104]
	str r9, [r8, #372]
	ldr r11, [r8, #108]
	eor r10, r10, r6
	eor r11, r11, r7
	ror r11, r11, #19
	ror r10, r10, #20
	str r11, [r8, #296]
	ldr r9, [r8, #144]
	str r10, [r8, #300]
	ldr r10, [r8, #148]
	eor r11, r9, r6
	eor r9, r10, r7
	ror r10, r9, #21
	ror r11, r11, #22
	str r10, [r8, #224]
	ldr r9, [r8, #184]
	str r11, [r8, #228]
	ldr r10, [r8, #188]
	eor r6, r9, r6
	eor r7, r10, r7
	ror r9, r6, #4
	ror r7, r7, #4
	str r9, [r8, #352]
	ldr r6, [r8, #472]
	str r7, [r8, #356]
	ldr r7, [r8, #476]
	ldr r10, [r8, #32]
	ldr r11, [r8, #36]
	eor r9, r10, r6
	eor r11, r11, r7
	ror r10, r9, #19
	ror r9, r11, #18
	str r10, [r8, #324]
	str r9, [r8, #320]
	ldr r9, [r8, #72]
	ldr r10, [r8, #76]
	eor r11, r9, r6
	eor r9, r10, r7
	ror r11, r11, #22
	str r11, [r8, #248]
	ror r10, r9, #22
	str r10, [r8, #252]
	ldr r9, [r8, #112]
	ldr r11, [r8, #116]
	eor r10, r9, r6
	eor r9, r11, r7
	ror r11, r10, #13
	ror r9, r9, #12
	str r11, [r8, #380]
	str r9, [r8, #376]
	ldr r10, [r8, #152]
	ldr r9, [r8, #156]
	eor r10, r10, r6
	eor r11, r9, r7
	ror r10, r10, #28
	str r10, [r8, #304]
	ror r10, r11, #28
	str r10, [r8, #308]
	ldr r9, [r8, #192]
	ldr r11, [r8, #196]
	eor r6, r9, r6
	eor r9, r11, r7
	ror r7, r6, #25
	str r7, [r8, #232]
	ror r11, r9, #25
	str r11, [r8, #236]
	ldr r9, [r8, #200]
	ldr r10, [r8, #208]
	ldr r11, [r8, #216]
	bic r6, r11, r10
	eor r6, r6, r9
	str r6, [r8, #0]
	ldr r9, [r8, #224]
	bic r6, r9, r11
	eor r6, r6, r10
	str r6, [r8, #8]
	ldr r10, [r8, #232]
	bic r6, r10, r9
	eor r6, r6, r11
	str r6, [r8, #16]
	ldr r11, [r8, #200]
	bic r6, r11, r10
	eor r6, r6, r9
	str r6, [r8, #24]
	ldr r9, [r8, #208]
	bic r6, r9, r11
	eor r6, r6, r10
	str r6, [r8, #32]
	ldr r9, [r8, #204]
	ldr r10, [r8, #212]
	ldr r11, [r8, #220]
	bic r6, r11, r10
	eor r6, r6, r9
	str r6, [r8, #4]
	ldr r9, [r8, #228]
	bic r6, r9, r11
	eor r6, r6, r10
	str r6, [r8, #12]
	ldr r10, [r8, #236]
	bic r6, r10, r9
	eor r6, r6, r11
	str r6, [r8, #20]
	ldr r11, [r8, #204]
	bic r6, r11, r10
	eor r6, r6, r9
	str r6, [r8, #28]
	ldr r9, [r8, #212]
	bic r6, r9, r11
	eor r6, r6, r10
	str r6, [r8, #36]
	ldr r9, [r8, #240]
	ldr r10, [r8, #248]
	ldr r11, [r8, #256]
	bic r6, r11, r10
	eor r6, r6, r9
	str r6, [r8, #40]
	ldr r9, [r8, #264]
	bic r6, r9, r11
	eor r6, r6, r10
	str r6, [r8, #48]
	ldr r10, [r8, #272]
	bic r6, r10, r9
	eor r6, r6, r11
	str r6, [r8, #56]
	ldr r11, [r8, #240]
	bic r6, r11, r10
	eor r6, r6, r9
	str r6, [r8, #64]
	ldr r9, [r8, #248]
	bic r6, r9, r11
	eor r6, r6, r10
	str r6, [r8, #72]
	ldr r9, [r8, #244]
	ldr r10, [r8, #252]
	ldr r11, [r8, #260]
	bic r6, r11, r10
	eor r6, r6, r9
	str r6, [r8, #44]
	ldr r9, [r8, #268]
	bic r6, r9, r11
	eor r6, r6, r10
	str r6, [r8, #52]
	ldr r10, [r8, #276]
	bic r6, r10, r9
	eor r6, r6, r11
	str r6, [r8, #60]
	ldr r11, [r8, #244]
	bic r6, r11, r10
	eor r6, r6, r9
	str r6, [r8, #68]
	ldr r9, [r8, #252]
	bic r6, r9, r11
	eor r6, r6, r10
	str r6, [r8, #76]
	ldr r9, [r8, #280]
	ldr r10, [r8, #288]
	ldr r11, [r8, #296]
	bic r6, r11, r10
	eor r6, r6, r9
	str r6, [r8, #80]
	ldr r9, [r8, #304]
	bic r6, r9, r11
	eor r6, r6, r10
	str r6, [r8, #88]
	ldr r10, [r8, #312]
	bic r6, r10, r9
	eor r6, r6, r11
	str r6, [r8, #96]
	ldr r11, [r8, #280]
	bic r6, r11, r10
	eor r6, r6, r9
	str r6, [r8, #104]
	ldr r9, [r8, #288]
	bic r6, r9, r11
	eor r6, r6, r10
	str r6, [r8, #112]
	ldr r9, [r8, #284]
	ldr r10, [r8, #292]
	ldr r11, [r8, #300]
	bic r6, r11, r10
	eor r6, r6, r9
	str r6, [r8, #84]
	ldr r9, [r8, #308]
	bic r6, r9, r11
	eor r6, r6, r10
	str r6, [r8, #92]
	ldr r10, [r8, #316]
	bic r6, r10, r9
	eor r11, r6, r11
	ldr r7, [r8, #284]
	str r11, [r8, #100]
	bic r11, r7, r10
	eor r9, r11, r9
	ldr r6, [r8, #292]
	str r9, [r8, #108]
	bic r9, r6, r7
	eor r10, r9, r10
	ldr r6, [r8, #320]
	str r10, [r8, #116]
	ldr r9, [r8, #328]
	ldr r11, [r8, #336]
	bic r10, r11, r9
	ldr r7, [r8, #344]
	eor r6, r10, r6
	bic r10, r7, r11
	str r6, [r8, #120]
	eor r10, r10, r9
	str r10, [r8, #128]
	ldr r9, [r8, #352]
	bic r10, r9, r7
	ldr r6, [r8, #320]
	eor r11, r10, r11
	bic r10, r6, r9
	str r11, [r8, #136]
	eor r10, r10, r7
	str r10, [r8, #144]
	ldr r11, [r8, #328]
	bic r6, r11, r6
	ldr r7, [r8, #324]
	eor r11, r6, r9
	ldr r9, [r8, #332]
	str r11, [r8, #152]
	ldr r10, [r8, #340]
	bic r11, r10, r9
	ldr r6, [r8, #348]
	eor r11, r11, r7
	bic r7, r6, r10
	str r11, [r8, #124]
	eor r9, r7, r9
	str r9, [r8, #132]
	ldr r9, [r8, #356]
	bic r11, r9, r6
	ldr r7, [r8, #324]
	eor r11, r11, r10
	bic r10, r7, r9
	str r11, [r8, #140]
	eor r10, r10, r6
	str r10, [r8, #148]
	ldr r11, [r8, #332]
	bic r7, r11, r7
	ldr r11, [r8, #360]
	eor r7, r7, r9
	ldr r9, [r8, #368]
	str r7, [r8, #156]
	ldr r10, [r8, #376]
	bic r7, r10, r9
	ldr r6, [r8, #384]
	eor r11, r7, r11
	bic r7, r6, r10
	str r11, [r8, #160]
	eor r11, r7, r9
	str r11, [r8, #168]
	ldr r7, [r8, #392]
	bic r11, r7, r6
	ldr r9, [r8, #360]
	eor r10, r11, r10
	bic r11, r9, r7
	str r10, [r8, #176]
	eor r6, r11, r6
	str r6, [r8, #184]
	ldr r10, [r8, #368]
	bic r11, r10, r9
	ldr r9, [r8, #364]
	eor r6, r11, r7
	ldr r10, [r8, #372]
	str r6, [r8, #192]
	ldr r11, [r8, #380]
	bic r6, r11, r10
	eor r6, r6, r9
	str r6, [r8, #164]
	ldr r9, [r8, #388]
	bic r6, r9, r11
	eor r6, r6, r10
	str r6, [r8, #172]
	ldr r10, [r8, #396]
	bic r6, r10, r9
	eor r6, r6, r11
	str r6, [r8, #180]
	ldr r11, [r8, #364]
	bic r6, r11, r10
	eor r6, r6, r9
	str r6, [r8, #188]
	ldr r9, [r8, #372]
	bic r6, r9, r11
	eor r6, r6, r10
	str r6, [r8, #196]
	ldr r9, [r8, #0]
	eor r9, r9, #1
	str r9, [r8, #0]
	ldr r0, [r12, #1272]
	subs r0, r0, #1
	str r0, [r12, #1272]
	bne 1b
	pop {r4-r11, pc}

