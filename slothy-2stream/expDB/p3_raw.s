// expDB fiat_mul_u4_p3: original 593, safe 607, scalar 453, vector 154, frame 232
start:
	mov	r12, #38
	vbic q3, q0, q6
	mov	r14, r2
	ldr	r3, [r2, #4]
	veor q3, q3, q5
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	vstrw.u32 q3, [r11, #0xFFFFFED4]
	mul	r6, r12, r2
	str r0, [r13, #0]
	str r2, [r13, #4]
	vbic q3, q1, q0
	ldr	r0, [r14, #16]
	ldr	r2, [r1, #24]
	str r6, [r13, #8]
	veor q3, q3, q6
	str r2, [r13, #12]
	ldr	r6, [r14, #20]
	add	r2, r0, r0, lsl #3
	vstrw.u32 q3, [r11, #0xFFFFFEE4]
	add	r8, r0, r2, lsl #1
	str r8, [r13, #16]
	ldr	r2, [r14, #28]
	vldrw.u32 q0, [q7, #0xFFFFFE8C]
	mul	r8, r12, r6
	str r6, [r13, #20]
	vldrw.u32 q1, [q7, #0xFFFFFE9C]
	ldr	r6, [r1, #16]
	str r7, [r13, #24]
	str r6, [r13, #28]
	vldrw.u32 q2, [q7, #0xFFFFFEAC]
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	vldrw.u32 q5, [q7, #0xFFFFFEBC]
	str r7, [r13, #32]
	ldr	r7, [r14, #24]
	str r5, [r13, #36]
	vldrw.u32 q6, [q7, #0xFFFFFECC]
	mov	r2, r7
	mov	r5, r4
	str r8, [r13, #40]
	vbic q3, q2, q1
	mul	r8, r12, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	veor q3, q3, q0
	add	r10, r2, r7, lsl #1
	str r5, [r13, #44]
	add	r4, r5, r4, lsl #1
	vstrw.u32 q3, [r11, #0xFFFFFEF4]
	str r3, [r13, #48]
	mul	r5, r12, r3
	vbic q3, q5, q2
	str r0, [r13, #52]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	veor q3, q3, q1
	str r2, [r13, #56]
	str r6, [r13, #60]
	str r8, [r13, #64]
	vstrw.u32 q3, [r11, #0xFFFFFF04]
	ldr	r7, [r1, #12]
	ldr	r2, [r14, #36]
	str r7, [r13, #68]
	vbic q3, q6, q5
	ldr	r7, [r1, #8]
	mul	r12, r12, r2
	str r7, [r13, #72]
	veor q3, q3, q2
	ldr	r7, [r14, #0]
	str r2, [r13, #76]
	ldr	r2, [r1, #4]
	vstrw.u32 q3, [r11, #0xFFFFFF14]
	str r7, [r13, #80]
	ldr r7, [r13, #24]
	str r2, [r13, #84]
	vbic q3, q0, q6
	ldr	r2, [r1, #0]
	ldr r1, [r13, #4]
	veor q3, q3, q5
	str r12, [r13, #88]
	add	r12, r7, r7, lsl #3
	add	r12, r7, r12, lsl #1
	vstrw.u32 q3, [r11, #0xFFFFFF24]
	add	r14, r1, r1, lsl #3
	ldr r7, [r13, #32]
	add	r14, r1, r14, lsl #1
	vbic q3, q1, q0
	str r12, [r13, #92]
	umull	r14, r12, r14, r7
	ldr r1, [r13, #36]
	veor q3, q3, q6
	ldr r6, [r13, #16]
	umlal	r14, r12, r1, r4
	umull	r4, r1, r4, r7
	vstrw.u32 q3, [r11, #0xFFFFFF34]
	str r3, [r13, #96]
	umlal	r14, r12, r6, r3
	ldr r3, [r13, #36]
	vldrw.u32 q0, [q7, #0xFFFFFEDC]
	ldr r7, [r13, #72]
	umlal	r4, r1, r3, r5
	vldrw.u32 q1, [q7, #0xFFFFFEEC]
	mov	r8, r4
	ldr r3, [r13, #96]
	ldr r5, [r13, #8]
	vldrw.u32 q2, [q7, #0xFFFFFEFC]
	ldr r4, [r13, #12]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	vldrw.u32 q5, [q7, #0xFFFFFF0C]
	ldr r4, [r13, #40]
	ldr r5, [r13, #28]
	umlal	r8, r1, r4, r0
	vldrw.u32 q6, [q7, #0xFFFFFF1C]
	umlal	r8, r1, r10, r5
	ldr r4, [r13, #64]
	str r6, [r13, #100]
	vbic q3, q2, q1
	ldr r6, [r13, #68]
	umlal	r8, r1, r4, r6
	ldr r6, [r13, #92]
	veor q3, q3, q0
	ldr r4, [r13, #84]
	umlal	r8, r1, r6, r7
	ldr r6, [r13, #88]
	vstrw.u32 q3, [r11, #0xFFFFFF44]
	umlal	r8, r1, r6, r4
	ldr r6, [r13, #80]
	vbic q3, q5, q2
	ldr r4, [r13, #12]
	umlal	r8, r1, r6, r2
	ldr r6, [r13, #20]
	veor q3, q3, q1
	str r1, [r13, #104]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	vstrw.u32 q3, [r11, #0xFFFFFF54]
	umlal	r14, r12, r1, r4
	ldr r4, [r13, #60]
	umlal	r14, r12, r10, r0
	vbic q3, q6, q5
	str r8, [r13, #108]
	bic	r8, r8, #0xFC000000
	str r8, [r13, #112]
	veor q3, q3, q2
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	r14, r12, r8, r5
	vstrw.u32 q3, [r11, #0xFFFFFF64]
	ldr r6, [r13, #68]
	ldr r5, [r13, #92]
	str r0, [r13, #116]
	vbic q3, q0, q6
	umlal	r14, r12, r5, r6
	ldr r6, [r13, #108]
	ldr r7, [r13, #104]
	veor q3, q3, q5
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr r5, [r13, #76]
	vstrw.u32 q3, [r11, #0xFFFFFF74]
	str r6, [r13, #120]
	str r7, [r13, #124]
	add	r8, r5, r5, lsl #3
	ldr r7, [r13, #72]
	vbic q3, q1, q0
	add	r8, r5, r8, lsl #1
	umlal	r14, r12, r8, r7
	ldr r4, [r13, #80]
	veor q3, q3, q6
	ldr r5, [r13, #84]
	str r2, [r13, #128]
	umlal	r14, r12, r5, r4
	vstrw.u32 q3, [r11, #0xFFFFFF84]
	ldr r5, [r13, #48]
	ldr r4, [r13, #120]
	umlal	r14, r12, r5, r2
	vldrw.u32 q0, [q7, #0xFFFFFF2C]
	lsls	r2, r5, #1
	ldr r7, [r13, #32]
	vldrw.u32 q1, [q7, #0xFFFFFF3C]
	str r2, [r13, #132]
	ldr r2, [r13, #124]
	adds	r4, r14, r4
	vldrw.u32 q2, [q7, #0xFFFFFF4C]
	mov	r6, r8
	adc	r9, r12, r2
	mov	r8, r4
	vldrw.u32 q5, [q7, #0xFFFFFF5C]
	ldr r2, [r13, #100]
	ldr r5, [r13, #36]
	bic	r12, r4, #0xFE000000
	umull	r4, r1, r7, r1
	vldrw.u32 q6, [q7, #0xFFFFFF6C]
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	vbic q3, q2, q1
	str r0, [r13, #136]
	ldr r0, [r13, #12]
	str r12, [r13, #140]
	veor q3, q3, q0
	umlal	r4, r1, r2, r0
	ldr r0, [r13, #116]
	ldr r2, [r13, #92]
	vstrw.u32 q3, [r11, #4]
	str r6, [r13, #144]
	umlal	r4, r1, r2, r0
	vbic q3, q5, q2
	mov	r2, r6
	ldr r6, [r13, #28]
	lsrl	r8, r9, #25
	veor q3, q3, q1
	umlal	r4, r1, r2, r6
	ldr r6, [r13, #68]
	ldr r2, [r13, #80]
	vstrw.u32 q3, [r11, #20]
	umlal	r4, r1, r6, r2
	ldr r6, [r13, #48]
	ldr r2, [r13, #72]
	vbic q3, q6, q5
	umlal	r4, r1, r2, r6
	ldr r6, [r13, #44]
	ldr r2, [r13, #84]
	veor q3, q3, q2
	umlal	r4, r1, r2, r6
	mov	r12, r4
	ldr r2, [r13, #128]
	vstrw.u32 q3, [r11, #36]
	ldr r4, [r13, #4]
	ldr r6, [r13, #28]
	umlal	r12, r1, r4, r2
	vbic q3, q0, q6
	ldr r4, [r13, #100]
	str r12, [r13, #148]
	veor q3, q3, q5
	umull	r14, r12, r4, r7
	ldr r4, [r13, #8]
	ldr r2, [r13, #64]
	vstrw.u32 q3, [r11, #52]
	umlal	r14, r12, r5, r4
	ldr r4, [r13, #40]
	ldr r7, [r13, #72]
	vbic q3, q1, q0
	umlal	r14, r12, r4, r3
	ldr r4, [r13, #12]
	umlal	r14, r12, r10, r4
	veor q3, q3, q6
	umlal	r14, r12, r2, r0
	ldr r2, [r13, #92]
	umlal	r14, r12, r2, r6
	vstrw.u32 q3, [r11, #68]
	ldr r6, [r13, #68]
	ldr r2, [r13, #88]
	umlal	r14, r12, r2, r6
	vldrw.u32 q0, [q7, #0xFFFFFF7C]
	ldr r2, [r13, #80]
	umlal	r14, r12, r7, r2
	vldrw.u32 q1, [q7, #0xFFFFFF8C]
	ldr r2, [r13, #132]
	ldr r7, [r13, #84]
	umlal	r14, r12, r7, r2
	vldrw.u32 q2, [q7, #0xFFFFFF9C]
	ldr r7, [r13, #44]
	ldr r2, [r13, #128]
	umlal	r14, r12, r7, r2
	adds	r14, r14, r8
	vldrw.u32 q5, [q7, #0xFFFFFFAC]
	adc	r2, r12, r9
	str r14, [r13, #152]
	str r2, [r13, #156]
	vldrw.u32 q6, [q7, #0xFFFFFFBC]
	ldr r2, [r13, #4]
	ldr r8, [r13, #152]
	ldr r9, [r13, #156]
	lsrl	r8, r9, #26
	vbic q3, q2, q1
	bic	r12, r14, #0xFC000000
	lsls	r2, r2, #1
	str r12, [r13, #160]
	veor q3, q3, q0
	str r2, [r13, #164]
	ldr r2, [r13, #136]
	ldr r7, [r13, #32]
	vstrw.u32 q3, [r11, #84]
	str r8, [r13, #168]
	str r9, [r13, #172]
	umull	r14, r12, r7, r2
	vbic q3, q5, q2
	umlal	r14, r12, r5, r10
	ldr r2, [r13, #92]
	umlal	r14, r12, r2, r3
	veor q3, q3, q1
	ldr r2, [r13, #144]
	umlal	r14, r12, r2, r4
	ldr r2, [r13, #80]
	vstrw.u32 q3, [r11, #100]
	ldr r4, [r13, #28]
	umlal	r14, r12, r0, r2
	ldr r2, [r13, #48]
	vbic q3, q6, q5
	umlal	r14, r12, r4, r2
	ldr r4, [r13, #44]
	ldr r2, [r13, #84]
	veor q3, q3, q2
	umlal	r14, r12, r6, r4
	ldr r4, [r13, #4]
	ldr r6, [r13, #72]
	vstrw.u32 q3, [r11, #116]
	umlal	r14, r12, r6, r4
	mov	r4, r8
	ldr r6, [r13, #148]
	vbic q3, q0, q6
	adds	r4, r6, r4
	mov	r8, r4
	veor q3, q3, q5
	ldr r6, [r13, #172]
	bic	r4, r4, #0xFE000000
	adc	r9, r1, r6
	vstrw.u32 q3, [r11, #132]
	ldr r1, [r13, #52]
	lsrl	r8, r9, #25
	umlal	r14, r12, r2, r1
	vbic q3, q1, q0
	ldr r1, [r13, #128]
	ldr r6, [r13, #20]
	umlal	r14, r12, r6, r1
	ldr r2, [r13, #0]
	veor q3, q3, q6
	str r14, [r13, #176]
	umull	r14, r1, r10, r7
	str	r4, [r2, #12]
	vstrw.u32 q3, [r11, #148]
	ldr r4, [r13, #40]
	ldr r2, [r13, #92]
	umlal	r14, r1, r5, r4
	vldrw.u32 q0, [q7, #0xFFFFFFCC]
	ldr r4, [r13, #64]
	ldr r6, [r13, #88]
	umlal	r14, r1, r4, r3
	vldrw.u32 q1, [q7, #0xFFFFFFDC]
	ldr r4, [r13, #12]
	umlal	r14, r1, r2, r4
	vldrw.u32 q2, [q7, #0xFFFFFFEC]
	umlal	r14, r1, r6, r0
	ldr r2, [r13, #80]
	ldr r6, [r13, #28]
	vldrw.u32 q5, [q7, #0xFFFFFFFC]
	umlal	r14, r1, r6, r2
	ldr r6, [r13, #68]
	ldr r2, [r13, #132]
	vldrw.u32 q6, [q7, #12]
	umlal	r14, r1, r6, r2
	ldr r6, [r13, #72]
	ldr r2, [r13, #44]
	vbic q3, q2, q1
	umlal	r14, r1, r6, r2
	ldr r2, [r13, #84]
	ldr r6, [r13, #164]
	veor q3, q3, q0
	umlal	r14, r1, r2, r6
	ldr r6, [r13, #52]
	ldr r2, [r13, #128]
	vstrw.u32 q3, [r11, #164]
	umlal	r14, r1, r6, r2
	adds	r14, r14, r8
	vbic q3, q5, q2
	adc	r1, r1, r9
	str r14, [r13, #180]
	str r1, [r13, #184]
	veor q3, q3, q1
	ldr r8, [r13, #180]
	ldr r9, [r13, #184]
	lsrl	r8, r9, #26
	ldr r6, [r13, #144]
	vstrw.u32 q3, [r11, #180]
	ldr r2, [r13, #0]
	bic	r1, r14, #0xFC000000
	umull	r10, r14, r7, r6
	vbic q3, q6, q5
	str	r1, [r2, #16]
	ldr r2, [r13, #92]
	ldr r6, [r13, #48]
	veor q3, q3, q2
	umlal	r10, r14, r5, r2
	ldr r2, [r13, #80]
	str r4, [r13, #188]
	vstrw.u32 q3, [r11, #196]
	umlal	r10, r14, r3, r2
	umlal	r10, r14, r4, r6
	ldr r4, [r13, #44]
	vbic q3, q0, q6
	ldr r6, [r13, #28]
	umlal	r10, r14, r0, r4
	veor q3, q3, q5
	ldr r4, [r13, #4]
	ldr r2, [r13, #72]
	umlal	r10, r14, r6, r4
	vstrw.u32 q3, [r11, #212]
	ldr r6, [r13, #68]
	ldr r4, [r13, #52]
	ldr r1, [r13, #20]
	vbic q3, q1, q0
	umlal	r10, r14, r6, r4
	mov	r4, r8
	ldr r6, [r13, #176]
	veor q3, q3, q6
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr r6, [r13, #20]
	vstrw.u32 q3, [r11, #228]
	str r4, [r13, #192]
	umlal	r10, r14, r2, r6
	ldr r2, [r13, #0]
	vldrw.u32 q0, [q7, #28]
	bic	r4, r4, #0xFE000000
	str	r4, [r2, #20]
	ldr r4, [r13, #56]
	vldrw.u32 q1, [q7, #44]
	ldr r2, [r13, #84]
	adc	r12, r12, r9
	vldrw.u32 q2, [q7, #60]
	umlal	r10, r14, r2, r4
	ldr r4, [r13, #60]
	ldr r2, [r13, #128]
	vldrw.u32 q5, [q7, #76]
	str r12, [r13, #196]
	umlal	r10, r14, r4, r2
	ldr r8, [r13, #192]
	ldr r9, [r13, #196]
	vldrw.u32 q6, [q7, #92]
	str r10, [r13, #200]
	ldr r2, [r13, #92]
	lsrl	r8, r9, #25
	vbic q3, q2, q1
	umull	r4, r12, r2, r7
	ldr r2, [r13, #64]
	str r3, [r13, #204]
	veor q3, q3, q0
	umlal	r4, r12, r5, r2
	ldr r2, [r13, #88]
	ldr r6, [r13, #28]
	vstrw.u32 q3, [r11, #244]
	umlal	r4, r12, r2, r3
	ldr r3, [r13, #188]
	vbic q3, q5, q2
	ldr r2, [r13, #80]
	str r8, [r13, #208]
	str r9, [r13, #212]
	umlal	r4, r12, r3, r2
	veor q3, q3, q1
	ldr r3, [r13, #132]
	ldr r2, [r13, #72]
	umlal	r4, r12, r0, r3
	vstrw.u32 q3, [r11, #260]
	ldr r3, [r13, #44]
	umlal	r4, r12, r6, r3
	ldr r6, [r13, #68]
	vbic q3, q6, q5
	ldr r3, [r13, #164]
	umlal	r4, r12, r6, r3
	ldr r3, [r13, #52]
	veor q3, q3, q2
	umlal	r4, r12, r2, r3
	ldr r3, [r13, #84]
	ldr r2, [r13, #128]
	vstrw.u32 q3, [r11, #276]
	umlal	r4, r12, r3, r1
	ldr r3, [r13, #56]
	umlal	r4, r12, r3, r2
	vbic q3, q0, q6
	adds	r8, r4, r8
	ldr r4, [r13, #212]
	veor q3, q3, q5
	str r8, [r13, #216]
	adc	r4, r12, r4
	str r4, [r13, #220]
	vstrw.u32 q3, [r11, #292]
	ldr r2, [r13, #216]
	ldr r3, [r13, #220]
	lsrl	r2, r3, #26
	str r2, [r13, #224]
	str r3, [r13, #228]
	vbic q3, q1, q0
	ldr r3, [r13, #0]
	ldr r2, [r13, #48]
	bic	r8, r8, #0xFC000000
	veor q3, q3, q6
	str	r8, [r3, #24]
	ldr r3, [r13, #60]
	umull	r12, r8, r7, r2
	vstrw.u32 q3, [r11, #308]
	lsl	r9, r3, #1
	ldr r3, [r13, #80]
	ldr r2, [r13, #88]
	vldrw.u32 q0, [q7, #108]
	umlal	r12, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	vldrw.u32 q1, [q7, #124]
	ldr r2, [r13, #132]
	ldr r4, [r13, #204]
	ldr r5, [r13, #44]
	vldrw.u32 q2, [q7, #140]
	umlal	r3, r10, r4, r2
	umlal	r12, r8, r4, r5
	ldr r4, [r13, #188]
	vldrw.u32 q5, [q7, #156]
	ldr r2, [r13, #72]
	umlal	r3, r10, r4, r5
	ldr r5, [r13, #4]
	vldrw.u32 q6, [q7, #172]
	umlal	r12, r8, r4, r5
	ldr r5, [r13, #164]
	ldr r4, [r13, #52]
	vbic q3, q2, q1
	umlal	r3, r10, r0, r5
	umlal	r12, r8, r0, r4
	ldr r0, [r13, #28]
	veor q3, q3, q0
	ldr r5, [r13, #76]
	umlal	r3, r10, r0, r4
	ldr r4, [r13, #20]
	vstrw.u32 q3, [r11, #324]
	umlal	r3, r10, r6, r1
	umlal	r12, r8, r0, r4
	vbic q3, q5, q2
	ldr r0, [r13, #56]
	ldr r4, [r13, #60]
	umlal	r12, r8, r6, r0
	veor q3, q3, q1
	umlal	r3, r10, r2, r0
	umlal	r12, r8, r2, r4
	ldr r0, [r13, #24]
	vstrw.u32 q3, [r11, #340]
	ldr r2, [r13, #84]
	ldr r6, [r13, #200]
	umlal	r3, r10, r2, r9
	vbic q3, q6, q5
	umlal	r12, r8, r2, r0
	ldr r2, [r13, #128]
	umlal	r3, r10, r0, r2
	veor q3, q3, q2
	umlal	r12, r8, r2, r5
	ldr r2, [r13, #224]
	ldr r5, [r13, #228]
	vstrw.u32 q3, [r11, #356]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	vbic q3, q0, q6
	adc	r3, r14, r5
	lsrl	r2, r3, #25
	veor q3, q3, q5
	ldr r0, [r13, #0]
	adds	r1, r1, r2
	bic	r4, r4, #0xFE000000
	vstrw.u32 q3, [r11, #372]
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	vbic q3, q1, q0
	lsrl	r4, r5, #26
	adds	r12, r12, r4
	mov	r2, r12
	veor q3, q3, q6
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r4, r2
	vstrw.u32 q3, [r11, #388]
	mov	r5, r3
	lsll	r4, r5, #3
	bic	r1, r1, #0xFC000000
	vldrw.u32 q0, [r11, #0xFFFFFF94]
	str	r1, [r0, #32]
	bic	r1, r12, #0xFE000000
	str	r1, [r0, #36]
	vldrw.u32 q1, [r11, #0xFFFFFE04]
	adds	r1, r4, r2
	adc	r4, r5, r3
	veor q1, q1, q0
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	vstrw.u32 q1, [r11, #0xFFFFFE04]
	adc	r4, r4, r3
	ldr r3, [r13, #112]
	adds	r1, r1, r3
	vldrw.u32 q0, [r11, #0xFFFFFFA4]
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	vldrw.u32 q1, [r11, #4]
	bic	r1, r1, #0xFC000000
	str	r1, [r0, #0]
	ldr r1, [r13, #140]
	veor q1, q1, q0
	adds	r3, r1, r2
	ldr r1, [r13, #160]
	bic	r2, r3, #0xFE000000
	vstrw.u32 q1, [r11, #4]
	add	r3, r1, r3, lsr #25
	str r2, [r0, #4]
	str r3, [r0, #8]
end:
