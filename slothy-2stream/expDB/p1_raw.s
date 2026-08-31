// expDB fiat_mul_u4_p1: original 593, safe 607, scalar 453, vector 154, frame 232
start:
	mov	r12, #38
	vldrw.u32 q1, [r11, #4]
	mov	r14, r2
	ldr	r3, [r2, #4]
	veor q0, q0, q3
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	veor q1, q1, q4
	mul	r6, r12, r2
	str r0, [r13, #0]
	str r2, [r13, #4]
	vorr.i32 q2, q0, q0
	ldr	r0, [r14, #16]
	ldr	r2, [r1, #24]
	str r6, [r13, #8]
	vstrw.u32 q2, [r11, #404]
	str r2, [r13, #12]
	ldr	r6, [r14, #20]
	add	r2, r0, r0, lsl #3
	vorr.i32 q5, q1, q1
	add	r8, r0, r2, lsl #1
	str r8, [r13, #16]
	ldr	r2, [r14, #28]
	vstrw.u32 q5, [q7, #0xFFFFFF2C]
	mul	r8, r12, r6
	str r6, [r13, #20]
	vldrw.u32 q0, [r11, #0xFFFFFE54]
	ldr	r6, [r1, #16]
	str r7, [r13, #24]
	str r6, [r13, #28]
	vldrw.u32 q1, [r11, #84]
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	veor q0, q0, q3
	str r7, [r13, #32]
	ldr	r7, [r14, #24]
	str r5, [r13, #36]
	veor q1, q1, q4
	mov	r2, r7
	mov	r5, r4
	str r8, [r13, #40]
	vshl.i32 q2, q0, #18
	mul	r8, r12, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	vsri.32 q2, q0, #14
	add	r10, r2, r7, lsl #1
	str r5, [r13, #44]
	add	r4, r5, r4, lsl #1
	vstrw.u32 q2, [q7, #0xFFFFFE9C]
	str r3, [r13, #48]
	mul	r5, r12, r3
	vshl.i32 q5, q1, #18
	str r0, [r13, #52]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	vsri.32 q5, q1, #14
	str r2, [r13, #56]
	str r6, [r13, #60]
	str r8, [r13, #64]
	vstrw.u32 q5, [q7, #44]
	ldr	r7, [r1, #12]
	ldr	r2, [r14, #36]
	str r7, [r13, #68]
	vldrw.u32 q0, [r11, #0xFFFFFEA4]
	ldr	r7, [r1, #8]
	mul	r12, r12, r2
	str r7, [r13, #72]
	vldrw.u32 q1, [r11, #164]
	ldr	r7, [r14, #0]
	str r2, [r13, #76]
	ldr	r2, [r1, #4]
	veor q0, q0, q3
	str r7, [r13, #80]
	ldr r7, [r13, #24]
	str r2, [r13, #84]
	veor q1, q1, q4
	ldr	r2, [r1, #0]
	ldr r1, [r13, #4]
	vshl.i32 q2, q1, #2
	str r12, [r13, #88]
	add	r12, r7, r7, lsl #3
	add	r12, r7, r12, lsl #1
	vsri.32 q2, q1, #30
	add	r14, r1, r1, lsl #3
	ldr r7, [r13, #32]
	add	r14, r1, r14, lsl #1
	vstrw.u32 q2, [q7, #0xFFFFFE0C]
	str r12, [r13, #92]
	umull	r14, r12, r14, r7
	ldr r1, [r13, #36]
	vshl.i32 q5, q0, #1
	ldr r6, [r13, #16]
	umlal	r14, r12, r1, r4
	umull	r4, r1, r4, r7
	vsri.32 q5, q0, #31
	str r3, [r13, #96]
	umlal	r14, r12, r6, r3
	ldr r3, [r13, #36]
	vstrw.u32 q5, [q7, #0xFFFFFF9C]
	ldr r7, [r13, #72]
	umlal	r4, r1, r3, r5
	vldrw.u32 q0, [r11, #0xFFFFFEF4]
	mov	r8, r4
	ldr r3, [r13, #96]
	ldr r5, [r13, #8]
	vldrw.u32 q1, [r11, #244]
	ldr r4, [r13, #12]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	veor q0, q0, q3
	ldr r4, [r13, #40]
	ldr r5, [r13, #28]
	umlal	r8, r1, r4, r0
	veor q1, q1, q4
	umlal	r8, r1, r10, r5
	ldr r4, [r13, #64]
	str r6, [r13, #100]
	vshl.i32 q2, q1, #21
	ldr r6, [r13, #68]
	umlal	r8, r1, r4, r6
	ldr r6, [r13, #92]
	vsri.32 q2, q1, #11
	ldr r4, [r13, #84]
	umlal	r8, r1, r6, r7
	ldr r6, [r13, #88]
	vstrw.u32 q2, [q7, #0xFFFFFF0C]
	umlal	r8, r1, r6, r4
	ldr r6, [r13, #80]
	vshl.i32 q5, q0, #20
	ldr r4, [r13, #12]
	umlal	r8, r1, r6, r2
	ldr r6, [r13, #20]
	vsri.32 q5, q0, #12
	str r1, [r13, #104]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	vstrw.u32 q5, [q7, #156]
	umlal	r14, r12, r1, r4
	ldr r4, [r13, #60]
	umlal	r14, r12, r10, r0
	vldrw.u32 q0, [r11, #0xFFFFFF44]
	str r8, [r13, #108]
	bic	r8, r8, #0xFC000000
	str r8, [r13, #112]
	vldrw.u32 q1, [r11, #324]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	r14, r12, r8, r5
	veor q0, q0, q3
	ldr r6, [r13, #68]
	ldr r5, [r13, #92]
	str r0, [r13, #116]
	veor q1, q1, q4
	umlal	r14, r12, r5, r6
	ldr r6, [r13, #108]
	ldr r7, [r13, #104]
	vshl.i32 q2, q0, #9
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr r5, [r13, #76]
	vsri.32 q2, q0, #23
	str r6, [r13, #120]
	str r7, [r13, #124]
	add	r8, r5, r5, lsl #3
	ldr r7, [r13, #72]
	vstrw.u32 q2, [q7, #0xFFFFFE7C]
	add	r8, r5, r8, lsl #1
	umlal	r14, r12, r8, r7
	ldr r4, [r13, #80]
	vshl.i32 q5, q1, #9
	ldr r5, [r13, #84]
	str r2, [r13, #128]
	umlal	r14, r12, r5, r4
	vsri.32 q5, q1, #23
	ldr r5, [r13, #48]
	ldr r4, [r13, #120]
	umlal	r14, r12, r5, r2
	vstrw.u32 q5, [q7, #12]
	lsls	r2, r5, #1
	ldr r7, [r13, #32]
	vldrw.u32 q3, [q7, #364]
	str r2, [r13, #132]
	ldr r2, [r13, #124]
	adds	r4, r14, r4
	vldrw.u32 q4, [q7, #444]
	mov	r6, r8
	adc	r9, r12, r2
	mov	r8, r4
	vldrw.u32 q0, [r11, #0xFFFFFE14]
	ldr r2, [r13, #100]
	ldr r5, [r13, #36]
	bic	r12, r4, #0xFE000000
	umull	r4, r1, r7, r1
	vldrw.u32 q1, [r11, #20]
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	veor q0, q0, q3
	str r0, [r13, #136]
	ldr r0, [r13, #12]
	str r12, [r13, #140]
	veor q1, q1, q4
	umlal	r4, r1, r2, r0
	ldr r0, [r13, #116]
	ldr r2, [r13, #92]
	vshl.i32 q2, q1, #1
	str r6, [r13, #144]
	umlal	r4, r1, r2, r0
	vsri.32 q2, q1, #31
	mov	r2, r6
	ldr r6, [r13, #28]
	lsrl	r8, r9, #25
	vstrw.u32 q2, [q7, #0xFFFFFE3C]
	umlal	r4, r1, r2, r6
	ldr r6, [r13, #68]
	ldr r2, [r13, #80]
	vorr.i32 q5, q0, q0
	umlal	r4, r1, r6, r2
	ldr r6, [r13, #48]
	ldr r2, [r13, #72]
	vstrw.u32 q5, [q7, #0xFFFFFFCC]
	umlal	r4, r1, r2, r6
	ldr r6, [r13, #44]
	ldr r2, [r13, #84]
	vldrw.u32 q0, [r11, #0xFFFFFE64]
	umlal	r4, r1, r2, r6
	mov	r12, r4
	ldr r2, [r13, #128]
	vldrw.u32 q1, [r11, #100]
	ldr r4, [r13, #4]
	ldr r6, [r13, #28]
	umlal	r12, r1, r4, r2
	veor q0, q0, q3
	ldr r4, [r13, #100]
	str r12, [r13, #148]
	veor q1, q1, q4
	umull	r14, r12, r4, r7
	ldr r4, [r13, #8]
	ldr r2, [r13, #64]
	vshl.i32 q2, q0, #22
	umlal	r14, r12, r5, r4
	ldr r4, [r13, #40]
	ldr r7, [r13, #72]
	vsri.32 q2, q0, #10
	umlal	r14, r12, r4, r3
	ldr r4, [r13, #12]
	umlal	r14, r12, r10, r4
	vstrw.u32 q2, [r11, #420]
	umlal	r14, r12, r2, r0
	ldr r2, [r13, #92]
	umlal	r14, r12, r2, r6
	vshl.i32 q5, q1, #22
	ldr r6, [r13, #68]
	ldr r2, [r13, #88]
	umlal	r14, r12, r2, r6
	vsri.32 q5, q1, #10
	ldr r2, [r13, #80]
	umlal	r14, r12, r7, r2
	vstrw.u32 q5, [q7, #0xFFFFFF3C]
	ldr r2, [r13, #132]
	ldr r7, [r13, #84]
	umlal	r14, r12, r7, r2
	vldrw.u32 q0, [r11, #0xFFFFFEB4]
	ldr r7, [r13, #44]
	ldr r2, [r13, #128]
	umlal	r14, r12, r7, r2
	adds	r14, r14, r8
	vldrw.u32 q1, [r11, #180]
	adc	r2, r12, r9
	str r14, [r13, #152]
	str r2, [r13, #156]
	veor q0, q0, q3
	ldr r2, [r13, #4]
	ldr r8, [r13, #152]
	ldr r9, [r13, #156]
	lsrl	r8, r9, #26
	veor q1, q1, q4
	bic	r12, r14, #0xFC000000
	lsls	r2, r2, #1
	str r12, [r13, #160]
	vshl.i32 q2, q0, #5
	str r2, [r13, #164]
	ldr r2, [r13, #136]
	ldr r7, [r13, #32]
	vsri.32 q2, q0, #27
	str r8, [r13, #168]
	str r9, [r13, #172]
	umull	r14, r12, r7, r2
	vstrw.u32 q2, [q7, #0xFFFFFEAC]
	umlal	r14, r12, r5, r10
	ldr r2, [r13, #92]
	umlal	r14, r12, r2, r3
	vshl.i32 q5, q1, #5
	ldr r2, [r13, #144]
	umlal	r14, r12, r2, r4
	ldr r2, [r13, #80]
	vsri.32 q5, q1, #27
	ldr r4, [r13, #28]
	umlal	r14, r12, r0, r2
	ldr r2, [r13, #48]
	vstrw.u32 q5, [q7, #60]
	umlal	r14, r12, r4, r2
	ldr r4, [r13, #44]
	ldr r2, [r13, #84]
	vldrw.u32 q0, [r11, #0xFFFFFF04]
	umlal	r14, r12, r6, r4
	ldr r4, [r13, #4]
	ldr r6, [r13, #72]
	vldrw.u32 q1, [r11, #260]
	umlal	r14, r12, r6, r4
	mov	r4, r8
	ldr r6, [r13, #148]
	veor q0, q0, q3
	adds	r4, r6, r4
	mov	r8, r4
	veor q1, q1, q4
	ldr r6, [r13, #172]
	bic	r4, r4, #0xFE000000
	adc	r9, r1, r6
	vshl.i32 q2, q1, #23
	ldr r1, [r13, #52]
	lsrl	r8, r9, #25
	umlal	r14, r12, r2, r1
	vsri.32 q2, q1, #9
	ldr r1, [r13, #128]
	ldr r6, [r13, #20]
	umlal	r14, r12, r6, r1
	ldr r2, [r13, #0]
	vstrw.u32 q2, [q7, #0xFFFFFE1C]
	str r14, [r13, #176]
	umull	r14, r1, r10, r7
	str	r4, [r2, #12]
	vshl.i32 q5, q0, #22
	ldr r4, [r13, #40]
	ldr r2, [r13, #92]
	umlal	r14, r1, r5, r4
	vsri.32 q5, q0, #10
	ldr r4, [r13, #64]
	ldr r6, [r13, #88]
	umlal	r14, r1, r4, r3
	vstrw.u32 q5, [q7, #0xFFFFFFAC]
	ldr r4, [r13, #12]
	umlal	r14, r1, r2, r4
	vldrw.u32 q0, [r11, #0xFFFFFF54]
	umlal	r14, r1, r6, r0
	ldr r2, [r13, #80]
	ldr r6, [r13, #28]
	vldrw.u32 q1, [r11, #340]
	umlal	r14, r1, r6, r2
	ldr r6, [r13, #68]
	ldr r2, [r13, #132]
	veor q0, q0, q3
	umlal	r14, r1, r6, r2
	ldr r6, [r13, #72]
	ldr r2, [r13, #44]
	veor q1, q1, q4
	umlal	r14, r1, r6, r2
	ldr r2, [r13, #84]
	ldr r6, [r13, #164]
	vshl.i32 q2, q0, #1
	umlal	r14, r1, r2, r6
	ldr r6, [r13, #52]
	ldr r2, [r13, #128]
	vsri.32 q2, q0, #31
	umlal	r14, r1, r6, r2
	adds	r14, r14, r8
	vstrw.u32 q2, [q7, #0xFFFFFF1C]
	adc	r1, r1, r9
	str r14, [r13, #180]
	str r1, [r13, #184]
	vshl.i32 q5, q1, #1
	ldr r8, [r13, #180]
	ldr r9, [r13, #184]
	lsrl	r8, r9, #26
	ldr r6, [r13, #144]
	vsri.32 q5, q1, #31
	ldr r2, [r13, #0]
	bic	r1, r14, #0xFC000000
	umull	r10, r14, r7, r6
	vstrw.u32 q5, [q7, #172]
	str	r1, [r2, #16]
	ldr r2, [r13, #92]
	ldr r6, [r13, #48]
	vldrw.u32 q3, [q7, #380]
	umlal	r10, r14, r5, r2
	ldr r2, [r13, #80]
	str r4, [r13, #188]
	vldrw.u32 q4, [q7, #460]
	umlal	r10, r14, r3, r2
	umlal	r10, r14, r4, r6
	ldr r4, [r13, #44]
	vldrw.u32 q0, [r11, #0xFFFFFE24]
	ldr r6, [r13, #28]
	umlal	r10, r14, r0, r4
	vldrw.u32 q1, [r11, #36]
	ldr r4, [r13, #4]
	ldr r2, [r13, #72]
	umlal	r10, r14, r6, r4
	veor q0, q0, q3
	ldr r6, [r13, #68]
	ldr r4, [r13, #52]
	ldr r1, [r13, #20]
	veor q1, q1, q4
	umlal	r10, r14, r6, r4
	mov	r4, r8
	ldr r6, [r13, #176]
	vshl.i32 q2, q0, #31
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr r6, [r13, #20]
	vsri.32 q2, q0, #1
	str r4, [r13, #192]
	umlal	r10, r14, r2, r6
	ldr r2, [r13, #0]
	vstrw.u32 q2, [q7, #0xFFFFFEDC]
	bic	r4, r4, #0xFE000000
	str	r4, [r2, #20]
	ldr r4, [r13, #56]
	vshl.i32 q5, q1, #31
	ldr r2, [r13, #84]
	adc	r12, r12, r9
	vsri.32 q5, q1, #1
	umlal	r10, r14, r2, r4
	ldr r4, [r13, #60]
	ldr r2, [r13, #128]
	vstrw.u32 q5, [q7, #108]
	str r12, [r13, #196]
	umlal	r10, r14, r4, r2
	ldr r8, [r13, #192]
	ldr r9, [r13, #196]
	vldrw.u32 q0, [r11, #0xFFFFFE74]
	str r10, [r13, #200]
	ldr r2, [r13, #92]
	lsrl	r8, r9, #25
	vldrw.u32 q1, [r11, #116]
	umull	r4, r12, r2, r7
	ldr r2, [r13, #64]
	str r3, [r13, #204]
	veor q0, q0, q3
	umlal	r4, r12, r5, r2
	ldr r2, [r13, #88]
	ldr r6, [r13, #28]
	veor q1, q1, q4
	umlal	r4, r12, r2, r3
	ldr r3, [r13, #188]
	vshl.i32 q2, q0, #3
	ldr r2, [r13, #80]
	str r8, [r13, #208]
	str r9, [r13, #212]
	umlal	r4, r12, r3, r2
	vsri.32 q2, q0, #29
	ldr r3, [r13, #132]
	ldr r2, [r13, #72]
	umlal	r4, r12, r0, r3
	vstrw.u32 q2, [q7, #0xFFFFFE4C]
	ldr r3, [r13, #44]
	umlal	r4, r12, r6, r3
	ldr r6, [r13, #68]
	vshl.i32 q5, q1, #3
	ldr r3, [r13, #164]
	umlal	r4, r12, r6, r3
	ldr r3, [r13, #52]
	vsri.32 q5, q1, #29
	umlal	r4, r12, r2, r3
	ldr r3, [r13, #84]
	ldr r2, [r13, #128]
	vstrw.u32 q5, [q7, #0xFFFFFFDC]
	umlal	r4, r12, r3, r1
	ldr r3, [r13, #56]
	umlal	r4, r12, r3, r2
	vldrw.u32 q0, [r11, #0xFFFFFEC4]
	adds	r8, r4, r8
	ldr r4, [r13, #212]
	vldrw.u32 q1, [r11, #196]
	str r8, [r13, #216]
	adc	r4, r12, r4
	str r4, [r13, #220]
	veor q0, q0, q3
	ldr r2, [r13, #216]
	ldr r3, [r13, #220]
	lsrl	r2, r3, #26
	str r2, [r13, #224]
	str r3, [r13, #228]
	veor q1, q1, q4
	ldr r3, [r13, #0]
	ldr r2, [r13, #48]
	bic	r8, r8, #0xFC000000
	vshl.i32 q2, q1, #22
	str	r8, [r3, #24]
	ldr r3, [r13, #60]
	umull	r12, r8, r7, r2
	vsri.32 q2, q1, #10
	lsl	r9, r3, #1
	ldr r3, [r13, #80]
	ldr r2, [r13, #88]
	vstrw.u32 q2, [r11, #436]
	umlal	r12, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	vshl.i32 q5, q0, #21
	ldr r2, [r13, #132]
	ldr r4, [r13, #204]
	ldr r5, [r13, #44]
	vsri.32 q5, q0, #11
	umlal	r3, r10, r4, r2
	umlal	r12, r8, r4, r5
	ldr r4, [r13, #188]
	vstrw.u32 q5, [q7, #0xFFFFFF4C]
	ldr r2, [r13, #72]
	umlal	r3, r10, r4, r5
	ldr r5, [r13, #4]
	vldrw.u32 q0, [r11, #0xFFFFFF14]
	umlal	r12, r8, r4, r5
	ldr r5, [r13, #164]
	ldr r4, [r13, #52]
	vldrw.u32 q1, [r11, #276]
	umlal	r3, r10, r0, r5
	umlal	r12, r8, r0, r4
	ldr r0, [r13, #28]
	veor q0, q0, q3
	ldr r5, [r13, #76]
	umlal	r3, r10, r0, r4
	ldr r4, [r13, #20]
	veor q1, q1, q4
	umlal	r3, r10, r6, r1
	umlal	r12, r8, r0, r4
	vshl.i32 q2, q1, #8
	ldr r0, [r13, #56]
	ldr r4, [r13, #60]
	umlal	r12, r8, r6, r0
	vsri.32 q2, q1, #24
	umlal	r3, r10, r2, r0
	umlal	r12, r8, r2, r4
	ldr r0, [r13, #24]
	vstrw.u32 q2, [q7, #0xFFFFFEBC]
	ldr r2, [r13, #84]
	ldr r6, [r13, #200]
	umlal	r3, r10, r2, r9
	vshl.i32 q5, q0, #7
	umlal	r12, r8, r2, r0
	ldr r2, [r13, #128]
	umlal	r3, r10, r0, r2
	vsri.32 q5, q0, #25
	umlal	r12, r8, r2, r5
	ldr r2, [r13, #224]
	ldr r5, [r13, #228]
	vstrw.u32 q5, [q7, #76]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	vldrw.u32 q0, [r11, #0xFFFFFF64]
	adc	r3, r14, r5
	lsrl	r2, r3, #25
	vldrw.u32 q1, [r11, #356]
	ldr r0, [r13, #0]
	adds	r1, r1, r2
	bic	r4, r4, #0xFE000000
	veor q0, q0, q3
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	veor q1, q1, q4
	lsrl	r4, r5, #26
	adds	r12, r12, r4
	mov	r2, r12
	vshl.i32 q2, q1, #31
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r4, r2
	vsri.32 q2, q1, #1
	mov	r5, r3
	lsll	r4, r5, #3
	bic	r1, r1, #0xFC000000
	vstrw.u32 q2, [q7, #0xFFFFFE2C]
	str	r1, [r0, #32]
	bic	r1, r12, #0xFE000000
	str	r1, [r0, #36]
	vshl.i32 q5, q0, #30
	adds	r1, r4, r2
	adc	r4, r5, r3
	vsri.32 q5, q0, #2
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	vstrw.u32 q5, [q7, #0xFFFFFFBC]
	adc	r4, r4, r3
	ldr r3, [r13, #112]
	adds	r1, r1, r3
	vldrw.u32 q3, [q7, #396]
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	vldrw.u32 q4, [q7, #476]
	bic	r1, r1, #0xFC000000
	str	r1, [r0, #0]
	ldr r1, [r13, #140]
	vldrw.u32 q0, [r11, #0xFFFFFE34]
	adds	r3, r1, r2
	ldr r1, [r13, #160]
	bic	r2, r3, #0xFE000000
	vldrw.u32 q1, [r11, #52]
	add	r3, r1, r3, lsr #25
	str r2, [r0, #4]
	str r3, [r0, #8]
end:
