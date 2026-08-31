.text
.syntax unified
.thumb

// 실험 J-solo: A/B 단독 + 빈 루프 (gen_exp_j_solo.py 생성)
// expj_a
.global expj_a
.type expj_a, %function
.thumb_func
.balign 16
expj_a:
	push {r4-r11, lr}
	vpush {d8-d15}
	sub sp, sp, #156
	str r0, [sp, #148]
	movw r10, #:lower16:g_mve
	movt r10, #:upper16:g_mve
	add r10, r10, #508
	movw r11, #:lower16:g_mve
	movt r11, #:upper16:g_mve
	add r11, r11, #1524
.balign 16
1:
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	r3, r1
	mov	lr, r2
	ldr	r1, [r2, #36]
	ldr	r2, [r3, #36]
	mov	ip, #38
	mov	r6, r2
	str	r1, [sp, #44]
	ldr	r1, [lr, #12]
	ldr	r2, [r3, #32]
	add	r9, r1, r1, lsl #3
	add	r9, r1, r9, lsl #1
	ldr	r4, [lr, #8]
	umull	r9, r5, r9, r2
	str	r0, [sp, #40]
	add	r8, r4, r4, lsl #3
	mov	r0, r3
	ldr	r3, [lr, #4]
	add	r8, r4, r8, lsl #1
	str	r2, [sp, #16]
	umlal	r9, r5, r6, r8
	str	r4, [sp, #12]
	umull	r8, r2, r8, r2
	mul	r4, ip, r3
	umlal	r8, r2, r6, r4
	mul	r4, ip, r1
	str	r3, [sp, #52]
	ldr	r3, [lr, #16]
	str	r6, [sp, #8]
	add	r6, r3, r3, lsl #3
	add	r6, r3, r6, lsl #1
	str	r3, [sp, #32]
	mov	r3, r4
	ldr	r7, [lr, #20]
	ldr	r4, [r0, #28]
	str	r0, [sp, #4]
	umlal	r9, r5, r6, r4
	mov	r0, r4
	umlal	r8, r2, r3, r4
	add	r4, r7, r7, lsl #3
	add	r4, r7, r4, lsl #1
	str	r7, [sp, #76]
	mul	r7, ip, r7
	str	r1, [sp, #48]
	ldr	r1, [lr, #24]
	str	r7, [sp, #56]
	add	r7, r1, r1, lsl #3
	str	r1, [sp, #84]
	add	r7, r1, r7, lsl #1
	mov	r1, r5
	str	r3, [sp, #24]
	mov	r3, r7
	ldr	r7, [sp, #4]
	ldr	r5, [sp, #16]
	ldr	r7, [r7, #24]
	umlal	r9, r1, r4, r7
	str	r1, [sp, #36]
	ldr	r1, [sp, #16]
	umlal	r8, r2, r6, r7
	str	r7, [sp, #20]
	umull	r7, r4, r1, r4
	ldr	r1, [sp, #8]
	str	r8, [sp, #28]
	umlal	r7, r4, r1, r6
	umull	r8, r6, r6, r5
	mov	r5, r1
	ldr	r1, [sp, #24]
	umlal	r7, r4, r3, r0
	umlal	r8, r6, r5, r1
	ldr	r5, [sp, #56]
	mov	r1, r3
	umlal	r8, r6, r5, r0
	ldr	r5, [sp, #20]
	umlal	r8, r6, r3, r5
	ldr	r3, [lr, #28]
	str	r6, [sp, #88]
	mov	r6, r3
	str	r8, [sp, #72]
	mov	r8, r4
	ldr	r3, [lr, #32]
	str	r6, [sp, #68]
	str	r3, [sp, #64]
	ldr	r3, [lr]
	add	lr, r6, r6, lsl #3
	add	lr, r6, lr, lsl #1
	umlal	r7, r8, lr, r5
	str	r8, [sp, #92]
	mov	r8, r2
	str	r3, [sp, #60]
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #36]
	ldr	r3, [r3, #20]
	ldr	r6, [sp, #28]
	umlal	r9, r2, r1, r3
	ldr	r5, [sp, #56]
	str	r9, [sp, #80]
	umlal	r6, r8, r5, r3
	mov	r5, r2
	ldr	r2, [sp, #68]
	ldr	r4, [sp, #72]
	mul	r9, ip, r2
	str	r8, [sp, #24]
	ldr	r2, [sp, #44]
	mov	r8, r6
	ldr	r6, [sp, #88]
	mul	ip, ip, r2
	umlal	r4, r6, r9, r3
	str	ip, [sp, #28]
	mov	ip, r4
	ldr	r2, [sp, #64]
	str	r9, [sp, #72]
	add	r9, r2, r2, lsl #3
	add	r9, r2, r9, lsl #1
	ldr	r2, [sp, #92]
	str	r3, [sp, #36]
	umlal	r7, r2, r9, r3
	ldr	r3, [sp, #4]
	mov	r4, r2
	str	r7, [sp, #104]
	ldr	r2, [sp, #24]
	ldr	r7, [r3, #16]
	umlal	ip, r6, r9, r7
	umlal	r8, r2, r1, r7
	str	r8, [sp, #88]
	str	r6, [sp, #100]
	mov	r6, r1
	ldr	r3, [sp, #80]
	str	ip, [sp, #96]
	umlal	r3, r5, lr, r7
	str	r3, [sp, #92]
	ldr	r3, [sp, #16]
	str	r7, [sp, #24]
	umull	ip, lr, r3, lr
	ldr	r3, [sp, #8]
	str	r0, [sp, #80]
	umlal	ip, lr, r3, r1
	ldr	r1, [sp, #16]
	umlal	ip, lr, r9, r0
	umull	r7, r8, r6, r1
	ldr	r1, [sp, #56]
	ldr	r6, [sp, #72]
	umlal	r7, r8, r3, r1
	umlal	r7, r8, r6, r0
	ldr	r6, [sp, #20]
	ldr	r1, [sp, #28]
	umlal	r7, r8, r9, r6
	ldr	r3, [sp, #36]
	ldr	r0, [sp, #24]
	umlal	r7, r8, r1, r3
	mov	r1, r7
	ldr	r3, [sp, #60]
	ldr	r7, [sp, #24]
	umlal	r1, r8, r7, r3
	str	r8, [sp, #120]
	mov	r8, r4
	str	r1, [sp, #116]
	ldr	r1, [sp, #44]
	ldr	r3, [sp, #60]
	add	r7, r1, r1, lsl #3
	add	r7, r1, r7, lsl #1
	umlal	ip, lr, r7, r6
	ldr	r1, [sp, #104]
	ldr	r6, [sp, #36]
	umlal	r1, r8, r7, r0
	umlal	ip, lr, r6, r3
	str	r1, [sp, #56]
	ldr	r6, [sp, #4]
	ldr	r1, [sp, #52]
	ldr	r4, [sp, #72]
	umlal	ip, lr, r0, r1
	ldr	r1, [r6, #12]
	ldr	r0, [sp, #88]
	str	r8, [sp, #108]
	umlal	r0, r2, r4, r1
	ldr	r4, [sp, #92]
	str	r0, [sp, #60]
	umlal	r4, r5, r9, r1
	str	r5, [sp, #88]
	mov	r8, r4
	ldr	r5, [sp, #28]
	ldr	r4, [sp, #96]
	ldr	r6, [sp, #100]
	ldr	r0, [sp, #4]
	umlal	r4, r6, r5, r1
	ldr	r5, [sp, #56]
	str	r4, [sp, #104]
	ldr	r4, [sp, #108]
	str	r1, [sp, #56]
	umlal	r5, r4, r1, r3
	str	r5, [sp, #112]
	ldr	r5, [sp, #12]
	umlal	ip, lr, r1, r5
	ldr	r1, [r0, #8]
	mov	r0, r2
	mov	r2, r1
	ldr	r5, [sp, #60]
	str	r3, [sp, #60]
	umlal	r5, r0, r9, r1
	ldr	r1, [sp, #88]
	str	r0, [sp, #96]
	ldr	r0, [sp, #104]
	umlal	r8, r1, r7, r2
	umlal	r0, r6, r2, r3
	str	r5, [sp, #92]
	strd	r0, r6, [sp, #104]
	ldr	r5, [sp, #112]
	ldr	r6, [sp, #52]
	str	r1, [sp, #100]
	ldr	r1, [sp, #48]
	umlal	r5, r4, r2, r6
	umlal	ip, lr, r2, r1
	str	r2, [sp, #88]
	ldr	r2, [sp, #16]
	ldr	r0, [sp, #80]
	umull	r6, r7, r2, r7
	ldr	r2, [sp, #8]
	str	r5, [sp, #112]
	umlal	r6, r7, r2, r9
	umlal	r6, r7, r0, r3
	ldr	r5, [sp, #52]
	ldr	r3, [sp, #20]
	str	lr, [sp, #128]
	umlal	r6, r7, r3, r5
	str	ip, [sp, #124]
	ldr	r3, [sp, #36]
	ldr	r5, [sp, #12]
	umlal	r6, r7, r3, r5
	ldr	r3, [sp, #24]
	ldr	r5, [sp, #76]
	umlal	r6, r7, r3, r1
	ldr	r1, [sp, #56]
	ldr	r3, [sp, #32]
	umlal	r6, r7, r1, r3
	mov	ip, r6
	ldr	r6, [sp, #88]
	ldr	r3, [sp, #16]
	umlal	ip, r7, r6, r5
	str	ip, [sp, #136]
	umull	ip, r6, r9, r3
	ldr	r5, [sp, #72]
	ldr	r3, [sp, #20]
	umlal	ip, r6, r2, r5
	ldr	r5, [sp, #28]
	ldr	r2, [sp, #4]
	umlal	ip, r6, r5, r0
	ldr	r0, [sp, #60]
	umlal	ip, r6, r3, r0
	ldrd	r3, lr, [r2]
	str	r3, [sp, #4]
	ldrd	r3, r1, [sp, #92]
	umlal	r3, r1, r5, lr
	str	r1, [sp, #60]
	ldr	r1, [sp, #100]
	mov	r9, r3
	umlal	r8, r1, lr, r0
	mov	r3, r0
	mov	r5, r1
	str	r6, [sp, #132]
	ldr	r1, [sp, #12]
	ldr	r6, [sp, #112]
	umlal	r6, r4, lr, r1
	ldr	r1, [sp, #32]
	str	r6, [sp, #96]
	ldrd	r0, r6, [sp, #124]
	umlal	r0, r6, lr, r1
	mov	r2, r6
	mov	r1, r0
	ldr	r6, [sp, #60]
	ldr	r0, [sp, #4]
	umlal	r9, r6, r3, r0
	str	r9, [sp, #60]
	mov	r9, r5
	str	r6, [sp, #72]
	ldr	r0, [sp, #52]
	ldr	r6, [sp, #4]
	ldr	r5, [sp, #48]
	umlal	r8, r9, r0, r6
	str	r8, [sp, #52]
	mov	r8, r4
	ldr	r6, [sp, #96]
	ldr	r4, [sp, #4]
	str	r9, [sp, #92]
	umlal	r6, r8, r5, r4
	mov	r4, r2
	str	r8, [sp, #112]
	mov	r8, r1
	ldr	r2, [sp, #4]
	ldr	r5, [sp, #76]
	str	r6, [sp, #100]
	umlal	r8, r4, r5, r2
	ldr	r5, [sp, #136]
	str	r4, [sp, #128]
	ldr	r4, [sp, #84]
	str	r8, [sp, #124]
	umlal	r5, r7, lr, r4
	mov	r8, r5
	ldrd	r6, r5, [sp, #116]
	mov	r9, r7
	ldr	r4, [sp, #68]
	lsls	r7, r0, #1
	umlal	r8, r9, r4, r2
	ldr	r4, [sp, #36]
	ldr	r2, [sp, #132]
	str	r9, [sp, #140]
	umlal	ip, r2, r4, r7
	mov	r1, ip
	ldr	r4, [sp, #56]
	mov	r9, r1
	umlal	r6, r5, r4, r7
	mov	ip, r5
	mov	r5, r6
	ldrd	r4, r6, [sp, #104]
	umlal	r4, r6, lr, r7
	str	r8, [sp, #136]
	mov	r8, r6
	ldr	r1, [sp, #24]
	ldr	r6, [sp, #12]
	umlal	r9, r2, r1, r6
	ldr	r1, [sp, #12]
	str	r9, [sp, #104]
	mov	r9, r5
	ldr	r5, [sp, #4]
	str	r2, [sp, #108]
	umlal	r4, r8, r1, r5
	mov	r5, r0
	ldr	r2, [sp, #88]
	str	r8, [sp, #96]
	ldr	r0, [sp, #16]
	str	r4, [sp, #88]
	umull	r4, r5, r0, r5
	ldr	r6, [sp, #8]
	umlal	r9, ip, r2, r1
	umlal	r4, r5, r6, r3
	umull	r3, r1, r0, r3
	mov	r0, r6
	ldr	r6, [sp, #28]
	umlal	r3, r1, r0, r6
	ldr	r6, [sp, #12]
	ldr	r0, [sp, #80]
	umlal	r3, r1, r0, r7
	umlal	r4, r5, r0, r6
	ldr	r7, [sp, #20]
	ldr	r0, [sp, #48]
	umlal	r3, r1, r7, r6
	lsl	r8, r0, #1
	umlal	r4, r5, r7, r0
	ldr	r6, [sp, #108]
	ldr	r7, [sp, #56]
	ldr	r0, [sp, #104]
	umlal	r9, ip, lr, r8
	umlal	r0, r6, r7, r8
	mov	r7, r0
	ldr	r0, [sp, #36]
	umlal	r3, r1, r0, r8
	str	r3, [sp, #8]
	ldr	r3, [sp, #32]
	umlal	r4, r5, r0, r3
	ldr	r0, [sp, #24]
	str	r4, [sp, #16]
	ldr	r4, [sp, #8]
	umlal	r7, r6, r2, r3
	umlal	r4, r1, r0, r3
	strd	r4, r1, [sp, #8]
	ldr	r1, [sp, #76]
	ldr	r4, [sp, #16]
	lsl	r8, r1, #1
	umlal	r4, r5, r0, r1
	mov	r0, r3
	umlal	r7, r6, lr, r8
	ldr	r3, [sp, #4]
	umlal	r9, ip, r0, r3
	ldrd	r3, r1, [sp, #8]
	ldr	r0, [sp, #56]
	str	r6, [sp, #8]
	umlal	r3, r1, r0, r8
	ldr	r6, [sp, #84]
	mov	r8, r7
	umlal	r4, r5, r0, r6
	mov	r0, r2
	umlal	r3, r1, r2, r6
	ldrd	r7, r2, [sp, #4]
	umlal	r8, r2, r6, r7
	ldr	r7, [sp, #68]
	mov	r6, r2
	umlal	r4, r5, r0, r7
	ldr	r0, [sp, #64]
	lsls	r7, r7, #1
	umlal	r4, r5, lr, r0
	umlal	r3, r1, lr, r7
	mov	lr, r4
	str	r8, [sp, #8]
	ldr	r2, [sp, #4]
	ldr	r4, [sp, #60]
	umlal	r3, r1, r0, r2
	str	r3, [sp, #12]
	ldr	r3, [sp, #44]
	ldr	r7, [sp, #52]
	umlal	lr, r5, r2, r3
	ldr	r2, [sp, #72]
	lsrs	r3, r4, #26
	orr	r3, r3, r2, lsl #6
	adds	r3, r7, r3
	ldr	r7, [sp, #92]
	bic	r4, r4, #-67108864
	adc	r2, r7, r2, lsr #26
	str	r4, [sp, #4]
	ldr	r7, [sp, #88]
	mov	r0, lr
	lsrs	r4, r3, #25
	orr	r4, r4, r2, lsl #7
	adds	r4, r7, r4
	ldr	r7, [sp, #96]
	lsr	lr, r4, #26
	adc	r2, r7, r2, lsr #25
	ldr	r7, [sp, #100]
	orr	lr, lr, r2, lsl #6
	adds	lr, r7, lr
	ldr	r7, [sp, #112]
	lsr	r8, lr, #25
	adc	r2, r7, r2, lsr #26
	orr	r8, r8, r2, lsl #7
	ldr	r7, [sp, #40]
	adds	r8, r9, r8
	bic	lr, lr, #-33554432
	adc	r2, ip, r2, lsr #25
	str	lr, [r7, #12]
	lsr	ip, r8, #26
	ldr	r7, [sp, #124]
	orr	ip, ip, r2, lsl #6
	adds	ip, r7, ip
	ldr	r7, [sp, #128]
	bic	r8, r8, #-67108864
	adc	r2, r7, r2, lsr #26
	ldr	r7, [sp, #40]
	lsr	lr, ip, #25
	str	r8, [r7, #16]
	ldr	r7, [sp, #8]
	orr	lr, lr, r2, lsl #7
	adds	lr, r7, lr
	ldr	r7, [sp, #40]
	adc	r2, r6, r2, lsr #25
	bic	r6, ip, #-33554432
	str	r6, [r7, #20]
	ldr	r7, [sp, #136]
	lsr	r6, lr, #26
	orr	r6, r6, r2, lsl #6
	adds	r6, r7, r6
	ldr	r7, [sp, #140]
	bic	lr, lr, #-67108864
	adc	r2, r7, r2, lsr #26
	ldr	r7, [sp, #40]
	lsr	ip, r6, #25
	str	lr, [r7, #24]
	ldr	r7, [sp, #12]
	orr	ip, ip, r2, lsl #7
	adds	ip, r7, ip
	adc	r1, r1, r2, lsr #25
	lsr	r2, ip, #26
	ldr	r7, [sp, #40]
	orr	r2, r2, r1, lsl #6
	adds	r9, r0, r2
	bic	r6, r6, #-33554432
	adc	r5, r5, r1, lsr #26
	str	r6, [r7, #28]
	bic	r2, ip, #-67108864
	lsr	r6, r9, #25
	orr	r6, r6, r5, lsl #7
	str	r2, [r7, #32]
	lsrs	r5, r5, #25
	bic	r2, r9, #-33554432
	str	r2, [r7, #36]
	lsls	r1, r5, #3
	lsls	r2, r6, #3
	adds	r2, r2, r6
	orr	r1, r1, r6, lsr #29
	adc	r1, r5, r1
	adds	r2, r2, r2
	adcs	r1, r1, r1
	adds	r2, r2, r6
	adc	r5, r5, r1
	ldr	r1, [sp, #4]
	bic	r3, r3, #-33554432
	adds	r2, r2, r1
	adc	r5, r5, #0
	lsrs	r1, r2, #26
	orr	r1, r1, r5, lsl #6
	add	r3, r3, r1
	bic	r4, r4, #-67108864
	bic	r2, r2, #-67108864
	bic	r1, r3, #-33554432
	add	r4, r4, r3, lsr #25
	strd	r2, r1, [r7]
	str	r4, [r7, #8]
	ldr r0, [sp, #148]
	subs r0, r0, #1
	str r0, [sp, #148]
	bne 1b
	add sp, sp, #156
	vpop {d8-d15}
	pop {r4-r11, pc}

// expj_b
.global expj_b
.type expj_b, %function
.thumb_func
.balign 16
expj_b:
	push {r4-r11, lr}
	vpush {d8-d15}
	sub sp, sp, #156
	str r0, [sp, #148]
	movw r10, #:lower16:g_mve
	movt r10, #:upper16:g_mve
	add r10, r10, #508
	movw r11, #:lower16:g_mve
	movt r11, #:upper16:g_mve
	add r11, r11, #1524
.balign 16
1:
	vldrw.u32 q0, [r10, #-508]
	vldrw.u32 q1, [r10, #-428]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-348]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-268]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-188]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #188]
	vldrw.u32 q0, [r10, #-492]
	vldrw.u32 q1, [r10, #-412]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-332]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-252]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-172]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #204]
	vldrw.u32 q0, [r10, #-476]
	vldrw.u32 q1, [r10, #-396]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-316]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-236]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-156]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #220]
	vldrw.u32 q0, [r10, #-460]
	vldrw.u32 q1, [r10, #-380]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-300]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-220]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-140]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #236]
	vldrw.u32 q0, [r10, #-444]
	vldrw.u32 q1, [r10, #-364]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-284]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-204]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-124]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #252]
	vldrw.u32 q0, [r10, #4]
	vldrw.u32 q1, [r10, #84]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #164]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #244]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #324]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #268]
	vldrw.u32 q0, [r10, #20]
	vldrw.u32 q1, [r10, #100]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #180]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #260]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #340]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #284]
	vldrw.u32 q0, [r10, #36]
	vldrw.u32 q1, [r10, #116]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #196]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #276]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #356]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #300]
	vldrw.u32 q0, [r10, #52]
	vldrw.u32 q1, [r10, #132]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #212]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #292]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #372]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #316]
	vldrw.u32 q0, [r10, #68]
	vldrw.u32 q1, [r10, #148]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #228]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #308]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #388]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #332]
	vldrw.u32 q0, [r11, #284]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #252]
	veor q1, q1, q2
	vstrw.u32 q1, [r11, #348]
	vldrw.u32 q0, [r11, #204]
	vldrw.u32 q2, [r11, #332]
	veor q0, q0, q2
	vstrw.u32 q0, [r11, #428]
	vldrw.u32 q0, [r11, #300]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #188]
	veor q1, q1, q2
	vstrw.u32 q1, [r11, #364]
	vldrw.u32 q0, [r11, #220]
	vldrw.u32 q2, [r11, #268]
	veor q0, q0, q2
	vstrw.u32 q0, [r11, #444]
	vldrw.u32 q0, [r11, #316]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #204]
	veor q1, q1, q2
	vstrw.u32 q1, [r11, #380]
	vldrw.u32 q0, [r11, #236]
	vldrw.u32 q2, [r11, #284]
	veor q0, q0, q2
	vstrw.u32 q0, [r11, #460]
	vldrw.u32 q0, [r11, #332]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #220]
	veor q1, q1, q2
	vstrw.u32 q1, [r11, #396]
	vldrw.u32 q0, [r11, #252]
	vldrw.u32 q2, [r11, #300]
	veor q0, q0, q2
	vstrw.u32 q0, [r11, #476]
	vldrw.u32 q0, [r11, #268]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #236]
	veor q1, q1, q2
	vstrw.u32 q1, [r11, #412]
	vldrw.u32 q0, [r11, #188]
	vldrw.u32 q2, [r11, #316]
	veor q0, q0, q2
	vstrw.u32 q0, [r11, #492]
	vldrw.u32 q6, [r11, #348]
	vldrw.u32 q7, [r11, #428]
	vldrw.u32 q0, [r10, #-508]
	vldrw.u32 q1, [r10, #4]
	veor q0, q0, q6
	veor q1, q1, q7
	vorr q2, q0, q0
	vstrw.u32 q2, [r10, #404]
	vorr q3, q1, q1
	vstrw.u32 q3, [r11, #-212]
	vldrw.u32 q0, [r10, #-428]
	vldrw.u32 q1, [r10, #84]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #18
	vsri.32 q2, q0, #14
	vstrw.u32 q2, [r11, #-356]
	vshl.i32 q3, q1, #18
	vsri.32 q3, q1, #14
	vstrw.u32 q3, [r11, #44]
	vldrw.u32 q0, [r10, #-348]
	vldrw.u32 q1, [r10, #164]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #2
	vsri.32 q2, q1, #30
	vstrw.u32 q2, [r11, #-500]
	vshl.i32 q3, q0, #1
	vsri.32 q3, q0, #31
	vstrw.u32 q3, [r11, #-100]
	vldrw.u32 q0, [r10, #-268]
	vldrw.u32 q1, [r10, #244]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #21
	vsri.32 q2, q1, #11
	vstrw.u32 q2, [r11, #-244]
	vshl.i32 q3, q0, #20
	vsri.32 q3, q0, #12
	vstrw.u32 q3, [r11, #156]
	vldrw.u32 q0, [r10, #-188]
	vldrw.u32 q1, [r10, #324]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #9
	vsri.32 q2, q0, #23
	vstrw.u32 q2, [r11, #-388]
	vshl.i32 q3, q1, #9
	vsri.32 q3, q1, #23
	vstrw.u32 q3, [r11, #12]
	vldrw.u32 q6, [r11, #364]
	vldrw.u32 q7, [r11, #444]
	vldrw.u32 q0, [r10, #-492]
	vldrw.u32 q1, [r10, #20]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #1
	vsri.32 q2, q1, #31
	vstrw.u32 q2, [r11, #-452]
	vorr q3, q0, q0
	vstrw.u32 q3, [r11, #-52]
	vldrw.u32 q0, [r10, #-412]
	vldrw.u32 q1, [r10, #100]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #22
	vsri.32 q2, q0, #10
	vstrw.u32 q2, [r10, #420]
	vshl.i32 q3, q1, #22
	vsri.32 q3, q1, #10
	vstrw.u32 q3, [r11, #-196]
	vldrw.u32 q0, [r10, #-332]
	vldrw.u32 q1, [r10, #180]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #5
	vsri.32 q2, q0, #27
	vstrw.u32 q2, [r11, #-340]
	vshl.i32 q3, q1, #5
	vsri.32 q3, q1, #27
	vstrw.u32 q3, [r11, #60]
	vldrw.u32 q0, [r10, #-252]
	vldrw.u32 q1, [r10, #260]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #23
	vsri.32 q2, q1, #9
	vstrw.u32 q2, [r11, #-484]
	vshl.i32 q3, q0, #22
	vsri.32 q3, q0, #10
	vstrw.u32 q3, [r11, #-84]
	vldrw.u32 q0, [r10, #-172]
	vldrw.u32 q1, [r10, #340]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #1
	vsri.32 q2, q0, #31
	vstrw.u32 q2, [r11, #-228]
	vshl.i32 q3, q1, #1
	vsri.32 q3, q1, #31
	vstrw.u32 q3, [r11, #172]
	vldrw.u32 q6, [r11, #380]
	vldrw.u32 q7, [r11, #460]
	vldrw.u32 q0, [r10, #-476]
	vldrw.u32 q1, [r10, #36]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #31
	vsri.32 q2, q0, #1
	vstrw.u32 q2, [r11, #-292]
	vshl.i32 q3, q1, #31
	vsri.32 q3, q1, #1
	vstrw.u32 q3, [r11, #108]
	vldrw.u32 q0, [r10, #-396]
	vldrw.u32 q1, [r10, #116]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #3
	vsri.32 q2, q0, #29
	vstrw.u32 q2, [r11, #-436]
	vshl.i32 q3, q1, #3
	vsri.32 q3, q1, #29
	vstrw.u32 q3, [r11, #-36]
	vldrw.u32 q0, [r10, #-316]
	vldrw.u32 q1, [r10, #196]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #22
	vsri.32 q2, q1, #10
	vstrw.u32 q2, [r10, #436]
	vshl.i32 q3, q0, #21
	vsri.32 q3, q0, #11
	vstrw.u32 q3, [r11, #-180]
	vldrw.u32 q0, [r10, #-236]
	vldrw.u32 q1, [r10, #276]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #8
	vsri.32 q2, q1, #24
	vstrw.u32 q2, [r11, #-324]
	vshl.i32 q3, q0, #7
	vsri.32 q3, q0, #25
	vstrw.u32 q3, [r11, #76]
	vldrw.u32 q0, [r10, #-156]
	vldrw.u32 q1, [r10, #356]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #31
	vsri.32 q2, q1, #1
	vstrw.u32 q2, [r11, #-468]
	vshl.i32 q3, q0, #30
	vsri.32 q3, q0, #2
	vstrw.u32 q3, [r11, #-68]
	vldrw.u32 q6, [r11, #396]
	vldrw.u32 q7, [r11, #476]
	vldrw.u32 q0, [r10, #-460]
	vldrw.u32 q1, [r10, #52]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #14
	vsri.32 q2, q0, #18
	vstrw.u32 q2, [r10, #484]
	vshl.i32 q3, q1, #14
	vsri.32 q3, q1, #18
	vstrw.u32 q3, [r11, #-132]
	vldrw.u32 q0, [r10, #-380]
	vldrw.u32 q1, [r10, #132]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #28
	vsri.32 q2, q1, #4
	vstrw.u32 q2, [r11, #-276]
	vshl.i32 q3, q0, #27
	vsri.32 q3, q0, #5
	vstrw.u32 q3, [r11, #124]
	vldrw.u32 q0, [r10, #-300]
	vldrw.u32 q1, [r10, #212]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #13
	vsri.32 q2, q1, #19
	vstrw.u32 q2, [r11, #-420]
	vshl.i32 q3, q0, #12
	vsri.32 q3, q0, #20
	vstrw.u32 q3, [r11, #-20]
	vldrw.u32 q0, [r10, #-220]
	vldrw.u32 q1, [r10, #292]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #11
	vsri.32 q2, q1, #21
	vstrw.u32 q2, [r10, #452]
	vshl.i32 q3, q0, #10
	vsri.32 q3, q0, #22
	vstrw.u32 q3, [r11, #-164]
	vldrw.u32 q0, [r10, #-140]
	vldrw.u32 q1, [r10, #372]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #28
	vsri.32 q2, q0, #4
	vstrw.u32 q2, [r11, #-308]
	vshl.i32 q3, q1, #28
	vsri.32 q3, q1, #4
	vstrw.u32 q3, [r11, #92]
	vldrw.u32 q6, [r11, #412]
	vldrw.u32 q7, [r11, #492]
	vldrw.u32 q0, [r10, #-444]
	vldrw.u32 q1, [r10, #68]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #14
	vsri.32 q2, q1, #18
	vstrw.u32 q2, [r11, #-372]
	vshl.i32 q3, q0, #13
	vsri.32 q3, q0, #19
	vstrw.u32 q3, [r11, #28]
	vldrw.u32 q0, [r10, #-364]
	vldrw.u32 q1, [r10, #148]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #10
	vsri.32 q2, q0, #22
	vstrw.u32 q2, [r10, #500]
	vshl.i32 q3, q1, #10
	vsri.32 q3, q1, #22
	vstrw.u32 q3, [r11, #-116]
	vldrw.u32 q0, [r10, #-284]
	vldrw.u32 q1, [r10, #228]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #20
	vsri.32 q2, q1, #12
	vstrw.u32 q2, [r11, #-260]
	vshl.i32 q3, q0, #19
	vsri.32 q3, q0, #13
	vstrw.u32 q3, [r11, #140]
	vldrw.u32 q0, [r10, #-204]
	vldrw.u32 q1, [r10, #308]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #4
	vsri.32 q2, q0, #28
	vstrw.u32 q2, [r11, #-404]
	vshl.i32 q3, q1, #4
	vsri.32 q3, q1, #28
	vstrw.u32 q3, [r11, #-4]
	vldrw.u32 q0, [r10, #-124]
	vldrw.u32 q1, [r10, #388]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #7
	vsri.32 q2, q0, #25
	vstrw.u32 q2, [r10, #468]
	vshl.i32 q3, q1, #7
	vsri.32 q3, q1, #25
	vstrw.u32 q3, [r11, #-148]
	vldrw.u32 q0, [r10, #404]
	vldrw.u32 q1, [r10, #420]
	vldrw.u32 q2, [r10, #436]
	vldrw.u32 q3, [r10, #452]
	vldrw.u32 q4, [r10, #468]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #-508]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #-492]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #-476]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #-460]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #-444]
	vldrw.u32 q0, [r10, #484]
	vldrw.u32 q1, [r10, #500]
	vldrw.u32 q2, [r11, #-500]
	vldrw.u32 q3, [r11, #-484]
	vldrw.u32 q4, [r11, #-468]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #-428]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #-412]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #-396]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #-380]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #-364]
	vldrw.u32 q0, [r11, #-452]
	vldrw.u32 q1, [r11, #-436]
	vldrw.u32 q2, [r11, #-420]
	vldrw.u32 q3, [r11, #-404]
	vldrw.u32 q4, [r11, #-388]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #-348]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #-332]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #-316]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #-300]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #-284]
	vldrw.u32 q0, [r11, #-372]
	vldrw.u32 q1, [r11, #-356]
	vldrw.u32 q2, [r11, #-340]
	vldrw.u32 q3, [r11, #-324]
	vldrw.u32 q4, [r11, #-308]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #-268]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #-252]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #-236]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #-220]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #-204]
	vldrw.u32 q0, [r11, #-292]
	vldrw.u32 q1, [r11, #-276]
	vldrw.u32 q2, [r11, #-260]
	vldrw.u32 q3, [r11, #-244]
	vldrw.u32 q4, [r11, #-228]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #-188]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #-172]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #-156]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #-140]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #-124]
	vldrw.u32 q0, [r11, #-212]
	vldrw.u32 q1, [r11, #-196]
	vldrw.u32 q2, [r11, #-180]
	vldrw.u32 q3, [r11, #-164]
	vldrw.u32 q4, [r11, #-148]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #4]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #20]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #36]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #52]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #68]
	vldrw.u32 q0, [r11, #-132]
	vldrw.u32 q1, [r11, #-116]
	vldrw.u32 q2, [r11, #-100]
	vldrw.u32 q3, [r11, #-84]
	vldrw.u32 q4, [r11, #-68]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #84]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #100]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #116]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #132]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #148]
	vldrw.u32 q0, [r11, #-52]
	vldrw.u32 q1, [r11, #-36]
	vldrw.u32 q2, [r11, #-20]
	vldrw.u32 q3, [r11, #-4]
	vldrw.u32 q4, [r11, #12]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #164]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #180]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #196]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #212]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #228]
	vldrw.u32 q0, [r11, #28]
	vldrw.u32 q1, [r11, #44]
	vldrw.u32 q2, [r11, #60]
	vldrw.u32 q3, [r11, #76]
	vldrw.u32 q4, [r11, #92]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #244]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #260]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #276]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #292]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #308]
	vldrw.u32 q0, [r11, #108]
	vldrw.u32 q1, [r11, #124]
	vldrw.u32 q2, [r11, #140]
	vldrw.u32 q3, [r11, #156]
	vldrw.u32 q4, [r11, #172]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #324]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #340]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #356]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #372]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #388]
	vmov.i32 q0, #1
	vldrw.u32 q1, [r10, #-508]
	veor q1, q1, q0
	vstrw.u32 q1, [r10, #-508]
	ldr r0, [sp, #148]
	subs r0, r0, #1
	str r0, [sp, #148]
	bne 1b
	add sp, sp, #156
	vpop {d8-d15}
	pop {r4-r11, pc}

// expj_loop
.global expj_loop
.type expj_loop, %function
.thumb_func
.balign 16
expj_loop:
	push {r4-r11, lr}
	vpush {d8-d15}
	sub sp, sp, #156
	str r0, [sp, #148]
	movw r10, #:lower16:g_mve
	movt r10, #:upper16:g_mve
	add r10, r10, #508
	movw r11, #:lower16:g_mve
	movt r11, #:upper16:g_mve
	add r11, r11, #1524
.balign 16
1:
	ldr r0, [sp, #148]
	subs r0, r0, #1
	str r0, [sp, #148]
	bne 1b
	add sp, sp, #156
	vpop {d8-d15}
	pop {r4-r11, pc}

