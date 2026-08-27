.text
.syntax unified
.thumb

// Experiment T: b0 (zero loop GP bases) + no-fixed-GP fiat.
// fiat is scalar-only because q0-q7 belong to b0; no -ffixed-r* options are used.
// expt_fiat
.global expt_fiat
.type expt_fiat, %function
.thumb_func
.balign 16
expt_fiat:
	push {r4-r11, lr}
	vpush {d8-d15}
	sub sp, sp, #140
	str r0, [sp, #132]
.balign 16
1:
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
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
	ldr r0, [sp, #132]
	subs r0, r0, #1
	str r0, [sp, #132]
	bne 1b
	add sp, sp, #140
	vpop {d8-d15}
	pop {r4-r11, pc}

// expt_b0
.global expt_b0
.type expt_b0, %function
.thumb_func
.balign 16
expt_b0:
	push {r4-r11, lr}
	vpush {d8-d15}
	sub sp, sp, #140
	str r0, [sp, #132]
	movw r1, #:lower16:g_mve
	movt r1, #:upper16:g_mve
	adr r2, 2f
	b 3f
	.balign 16
2:	.word 0, 4, 8, 12
3:
	vldrw.u32 q6, [r2]
	add r3, r1, #1524
	vadd.i32 q7, q6, r3
	add r3, r1, #508
	vadd.i32 q6, q6, r3
.balign 16
1:
	vldrw.u32 q0, [q6, #-508]
	vldrw.u32 q1, [q6, #-428]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-348]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-268]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-188]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #188]
	vldrw.u32 q0, [q6, #-492]
	vldrw.u32 q1, [q6, #-412]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-332]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-252]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-172]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #204]
	vldrw.u32 q0, [q6, #-476]
	vldrw.u32 q1, [q6, #-396]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-316]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-236]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-156]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #220]
	vldrw.u32 q0, [q6, #-460]
	vldrw.u32 q1, [q6, #-380]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-300]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-220]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-140]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #236]
	vldrw.u32 q0, [q6, #-444]
	vldrw.u32 q1, [q6, #-364]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-284]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-204]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-124]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #252]
	vldrw.u32 q0, [q6, #4]
	vldrw.u32 q1, [q6, #84]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #164]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #244]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #324]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #268]
	vldrw.u32 q0, [q6, #20]
	vldrw.u32 q1, [q6, #100]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #180]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #260]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #340]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #284]
	vldrw.u32 q0, [q6, #36]
	vldrw.u32 q1, [q6, #116]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #196]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #276]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #356]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #300]
	vldrw.u32 q0, [q6, #52]
	vldrw.u32 q1, [q6, #132]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #212]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #292]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #372]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #316]
	vldrw.u32 q0, [q6, #68]
	vldrw.u32 q1, [q6, #148]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #228]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #308]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #388]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #332]
	vldrw.u32 q0, [q7, #284]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #252]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #348]
	vldrw.u32 q0, [q7, #204]
	vldrw.u32 q2, [q7, #332]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #428]
	vldrw.u32 q0, [q7, #300]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #188]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #364]
	vldrw.u32 q0, [q7, #220]
	vldrw.u32 q2, [q7, #268]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #444]
	vldrw.u32 q0, [q7, #316]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #204]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #380]
	vldrw.u32 q0, [q7, #236]
	vldrw.u32 q2, [q7, #284]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #460]
	vldrw.u32 q0, [q7, #332]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #220]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #396]
	vldrw.u32 q0, [q7, #252]
	vldrw.u32 q2, [q7, #300]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #476]
	vldrw.u32 q0, [q7, #268]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #236]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #412]
	vldrw.u32 q0, [q7, #188]
	vldrw.u32 q2, [q7, #316]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #492]
	vldrw.u32 q3, [q7, #348]
	vldrw.u32 q4, [q7, #428]
	vldrw.u32 q0, [q6, #-508]
	vldrw.u32 q1, [q6, #4]
	veor q0, q0, q3
	veor q1, q1, q4
	vorr q2, q0, q0
	vstrw.u32 q2, [q6, #404]
	vorr q5, q1, q1
	vstrw.u32 q5, [q7, #-212]
	vldrw.u32 q0, [q6, #-428]
	vldrw.u32 q1, [q6, #84]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #18
	vsri.32 q2, q0, #14
	vstrw.u32 q2, [q7, #-356]
	vshl.i32 q5, q1, #18
	vsri.32 q5, q1, #14
	vstrw.u32 q5, [q7, #44]
	vldrw.u32 q0, [q6, #-348]
	vldrw.u32 q1, [q6, #164]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #2
	vsri.32 q2, q1, #30
	vstrw.u32 q2, [q7, #-500]
	vshl.i32 q5, q0, #1
	vsri.32 q5, q0, #31
	vstrw.u32 q5, [q7, #-100]
	vldrw.u32 q0, [q6, #-268]
	vldrw.u32 q1, [q6, #244]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #21
	vsri.32 q2, q1, #11
	vstrw.u32 q2, [q7, #-244]
	vshl.i32 q5, q0, #20
	vsri.32 q5, q0, #12
	vstrw.u32 q5, [q7, #156]
	vldrw.u32 q0, [q6, #-188]
	vldrw.u32 q1, [q6, #324]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #9
	vsri.32 q2, q0, #23
	vstrw.u32 q2, [q7, #-388]
	vshl.i32 q5, q1, #9
	vsri.32 q5, q1, #23
	vstrw.u32 q5, [q7, #12]
	vldrw.u32 q3, [q7, #364]
	vldrw.u32 q4, [q7, #444]
	vldrw.u32 q0, [q6, #-492]
	vldrw.u32 q1, [q6, #20]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #1
	vsri.32 q2, q1, #31
	vstrw.u32 q2, [q7, #-452]
	vorr q5, q0, q0
	vstrw.u32 q5, [q7, #-52]
	vldrw.u32 q0, [q6, #-412]
	vldrw.u32 q1, [q6, #100]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #22
	vsri.32 q2, q0, #10
	vstrw.u32 q2, [q6, #420]
	vshl.i32 q5, q1, #22
	vsri.32 q5, q1, #10
	vstrw.u32 q5, [q7, #-196]
	vldrw.u32 q0, [q6, #-332]
	vldrw.u32 q1, [q6, #180]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #5
	vsri.32 q2, q0, #27
	vstrw.u32 q2, [q7, #-340]
	vshl.i32 q5, q1, #5
	vsri.32 q5, q1, #27
	vstrw.u32 q5, [q7, #60]
	vldrw.u32 q0, [q6, #-252]
	vldrw.u32 q1, [q6, #260]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #23
	vsri.32 q2, q1, #9
	vstrw.u32 q2, [q7, #-484]
	vshl.i32 q5, q0, #22
	vsri.32 q5, q0, #10
	vstrw.u32 q5, [q7, #-84]
	vldrw.u32 q0, [q6, #-172]
	vldrw.u32 q1, [q6, #340]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #1
	vsri.32 q2, q0, #31
	vstrw.u32 q2, [q7, #-228]
	vshl.i32 q5, q1, #1
	vsri.32 q5, q1, #31
	vstrw.u32 q5, [q7, #172]
	vldrw.u32 q3, [q7, #380]
	vldrw.u32 q4, [q7, #460]
	vldrw.u32 q0, [q6, #-476]
	vldrw.u32 q1, [q6, #36]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #31
	vsri.32 q2, q0, #1
	vstrw.u32 q2, [q7, #-292]
	vshl.i32 q5, q1, #31
	vsri.32 q5, q1, #1
	vstrw.u32 q5, [q7, #108]
	vldrw.u32 q0, [q6, #-396]
	vldrw.u32 q1, [q6, #116]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #3
	vsri.32 q2, q0, #29
	vstrw.u32 q2, [q7, #-436]
	vshl.i32 q5, q1, #3
	vsri.32 q5, q1, #29
	vstrw.u32 q5, [q7, #-36]
	vldrw.u32 q0, [q6, #-316]
	vldrw.u32 q1, [q6, #196]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #22
	vsri.32 q2, q1, #10
	vstrw.u32 q2, [q6, #436]
	vshl.i32 q5, q0, #21
	vsri.32 q5, q0, #11
	vstrw.u32 q5, [q7, #-180]
	vldrw.u32 q0, [q6, #-236]
	vldrw.u32 q1, [q6, #276]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #8
	vsri.32 q2, q1, #24
	vstrw.u32 q2, [q7, #-324]
	vshl.i32 q5, q0, #7
	vsri.32 q5, q0, #25
	vstrw.u32 q5, [q7, #76]
	vldrw.u32 q0, [q6, #-156]
	vldrw.u32 q1, [q6, #356]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #31
	vsri.32 q2, q1, #1
	vstrw.u32 q2, [q7, #-468]
	vshl.i32 q5, q0, #30
	vsri.32 q5, q0, #2
	vstrw.u32 q5, [q7, #-68]
	vldrw.u32 q3, [q7, #396]
	vldrw.u32 q4, [q7, #476]
	vldrw.u32 q0, [q6, #-460]
	vldrw.u32 q1, [q6, #52]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #14
	vsri.32 q2, q0, #18
	vstrw.u32 q2, [q6, #484]
	vshl.i32 q5, q1, #14
	vsri.32 q5, q1, #18
	vstrw.u32 q5, [q7, #-132]
	vldrw.u32 q0, [q6, #-380]
	vldrw.u32 q1, [q6, #132]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #28
	vsri.32 q2, q1, #4
	vstrw.u32 q2, [q7, #-276]
	vshl.i32 q5, q0, #27
	vsri.32 q5, q0, #5
	vstrw.u32 q5, [q7, #124]
	vldrw.u32 q0, [q6, #-300]
	vldrw.u32 q1, [q6, #212]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #13
	vsri.32 q2, q1, #19
	vstrw.u32 q2, [q7, #-420]
	vshl.i32 q5, q0, #12
	vsri.32 q5, q0, #20
	vstrw.u32 q5, [q7, #-20]
	vldrw.u32 q0, [q6, #-220]
	vldrw.u32 q1, [q6, #292]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #11
	vsri.32 q2, q1, #21
	vstrw.u32 q2, [q6, #452]
	vshl.i32 q5, q0, #10
	vsri.32 q5, q0, #22
	vstrw.u32 q5, [q7, #-164]
	vldrw.u32 q0, [q6, #-140]
	vldrw.u32 q1, [q6, #372]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #28
	vsri.32 q2, q0, #4
	vstrw.u32 q2, [q7, #-308]
	vshl.i32 q5, q1, #28
	vsri.32 q5, q1, #4
	vstrw.u32 q5, [q7, #92]
	vldrw.u32 q3, [q7, #412]
	vldrw.u32 q4, [q7, #492]
	vldrw.u32 q0, [q6, #-444]
	vldrw.u32 q1, [q6, #68]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #14
	vsri.32 q2, q1, #18
	vstrw.u32 q2, [q7, #-372]
	vshl.i32 q5, q0, #13
	vsri.32 q5, q0, #19
	vstrw.u32 q5, [q7, #28]
	vldrw.u32 q0, [q6, #-364]
	vldrw.u32 q1, [q6, #148]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #10
	vsri.32 q2, q0, #22
	vstrw.u32 q2, [q6, #500]
	vshl.i32 q5, q1, #10
	vsri.32 q5, q1, #22
	vstrw.u32 q5, [q7, #-116]
	vldrw.u32 q0, [q6, #-284]
	vldrw.u32 q1, [q6, #228]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #20
	vsri.32 q2, q1, #12
	vstrw.u32 q2, [q7, #-260]
	vshl.i32 q5, q0, #19
	vsri.32 q5, q0, #13
	vstrw.u32 q5, [q7, #140]
	vldrw.u32 q0, [q6, #-204]
	vldrw.u32 q1, [q6, #308]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #4
	vsri.32 q2, q0, #28
	vstrw.u32 q2, [q7, #-404]
	vshl.i32 q5, q1, #4
	vsri.32 q5, q1, #28
	vstrw.u32 q5, [q7, #-4]
	vldrw.u32 q0, [q6, #-124]
	vldrw.u32 q1, [q6, #388]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #7
	vsri.32 q2, q0, #25
	vstrw.u32 q2, [q6, #468]
	vshl.i32 q5, q1, #7
	vsri.32 q5, q1, #25
	vstrw.u32 q5, [q7, #-148]
	vldrw.u32 q0, [q6, #404]
	vldrw.u32 q1, [q6, #420]
	vldrw.u32 q2, [q6, #436]
	vldrw.u32 q5, [q6, #452]
	vldrw.u32 q3, [q6, #468]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-508]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-492]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-476]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-460]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-444]
	vldrw.u32 q0, [q6, #484]
	vldrw.u32 q1, [q6, #500]
	vldrw.u32 q2, [q7, #-500]
	vldrw.u32 q5, [q7, #-484]
	vldrw.u32 q3, [q7, #-468]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-428]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-412]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-396]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-380]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-364]
	vldrw.u32 q0, [q7, #-452]
	vldrw.u32 q1, [q7, #-436]
	vldrw.u32 q2, [q7, #-420]
	vldrw.u32 q5, [q7, #-404]
	vldrw.u32 q3, [q7, #-388]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-348]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-332]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-316]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-300]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-284]
	vldrw.u32 q0, [q7, #-372]
	vldrw.u32 q1, [q7, #-356]
	vldrw.u32 q2, [q7, #-340]
	vldrw.u32 q5, [q7, #-324]
	vldrw.u32 q3, [q7, #-308]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-268]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-252]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-236]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-220]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-204]
	vldrw.u32 q0, [q7, #-292]
	vldrw.u32 q1, [q7, #-276]
	vldrw.u32 q2, [q7, #-260]
	vldrw.u32 q5, [q7, #-244]
	vldrw.u32 q3, [q7, #-228]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-188]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-172]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-156]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-140]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-124]
	vldrw.u32 q0, [q7, #-212]
	vldrw.u32 q1, [q7, #-196]
	vldrw.u32 q2, [q7, #-180]
	vldrw.u32 q5, [q7, #-164]
	vldrw.u32 q3, [q7, #-148]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #4]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #20]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #36]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #52]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #68]
	vldrw.u32 q0, [q7, #-132]
	vldrw.u32 q1, [q7, #-116]
	vldrw.u32 q2, [q7, #-100]
	vldrw.u32 q5, [q7, #-84]
	vldrw.u32 q3, [q7, #-68]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #84]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #100]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #116]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #132]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #148]
	vldrw.u32 q0, [q7, #-52]
	vldrw.u32 q1, [q7, #-36]
	vldrw.u32 q2, [q7, #-20]
	vldrw.u32 q5, [q7, #-4]
	vldrw.u32 q3, [q7, #12]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #164]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #180]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #196]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #212]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #228]
	vldrw.u32 q0, [q7, #28]
	vldrw.u32 q1, [q7, #44]
	vldrw.u32 q2, [q7, #60]
	vldrw.u32 q5, [q7, #76]
	vldrw.u32 q3, [q7, #92]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #244]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #260]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #276]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #292]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #308]
	vldrw.u32 q0, [q7, #108]
	vldrw.u32 q1, [q7, #124]
	vldrw.u32 q2, [q7, #140]
	vldrw.u32 q5, [q7, #156]
	vldrw.u32 q3, [q7, #172]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #324]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #340]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #356]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #372]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #388]
	vmov.i32 q0, #1
	vldrw.u32 q1, [q6, #-508]
	veor q1, q1, q0
	vstrw.u32 q1, [q6, #-508]
	ldr r0, [sp, #132]
	subs r0, r0, #1
	str r0, [sp, #132]
	bne 1b
	add sp, sp, #140
	vpop {d8-d15}
	pop {r4-r11, pc}

// expt_seq
.global expt_seq
.type expt_seq, %function
.thumb_func
.balign 16
expt_seq:
	push {r4-r11, lr}
	vpush {d8-d15}
	sub sp, sp, #140
	str r0, [sp, #132]
	movw r1, #:lower16:g_mve
	movt r1, #:upper16:g_mve
	adr r2, 2f
	b 3f
	.balign 16
2:	.word 0, 4, 8, 12
3:
	vldrw.u32 q6, [r2]
	add r3, r1, #1524
	vadd.i32 q7, q6, r3
	add r3, r1, #508
	vadd.i32 q6, q6, r3
.balign 16
1:
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
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
	vldrw.u32 q0, [q6, #-508]
	vldrw.u32 q1, [q6, #-428]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-348]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-268]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-188]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #188]
	vldrw.u32 q0, [q6, #-492]
	vldrw.u32 q1, [q6, #-412]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-332]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-252]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-172]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #204]
	vldrw.u32 q0, [q6, #-476]
	vldrw.u32 q1, [q6, #-396]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-316]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-236]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-156]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #220]
	vldrw.u32 q0, [q6, #-460]
	vldrw.u32 q1, [q6, #-380]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-300]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-220]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-140]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #236]
	vldrw.u32 q0, [q6, #-444]
	vldrw.u32 q1, [q6, #-364]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-284]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-204]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-124]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #252]
	vldrw.u32 q0, [q6, #4]
	vldrw.u32 q1, [q6, #84]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #164]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #244]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #324]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #268]
	vldrw.u32 q0, [q6, #20]
	vldrw.u32 q1, [q6, #100]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #180]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #260]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #340]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #284]
	vldrw.u32 q0, [q6, #36]
	vldrw.u32 q1, [q6, #116]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #196]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #276]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #356]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #300]
	vldrw.u32 q0, [q6, #52]
	vldrw.u32 q1, [q6, #132]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #212]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #292]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #372]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #316]
	vldrw.u32 q0, [q6, #68]
	vldrw.u32 q1, [q6, #148]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #228]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #308]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #388]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #332]
	vldrw.u32 q0, [q7, #284]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #252]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #348]
	vldrw.u32 q0, [q7, #204]
	vldrw.u32 q2, [q7, #332]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #428]
	vldrw.u32 q0, [q7, #300]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #188]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #364]
	vldrw.u32 q0, [q7, #220]
	vldrw.u32 q2, [q7, #268]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #444]
	vldrw.u32 q0, [q7, #316]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #204]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #380]
	vldrw.u32 q0, [q7, #236]
	vldrw.u32 q2, [q7, #284]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #460]
	vldrw.u32 q0, [q7, #332]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #220]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #396]
	vldrw.u32 q0, [q7, #252]
	vldrw.u32 q2, [q7, #300]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #476]
	vldrw.u32 q0, [q7, #268]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #236]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #412]
	vldrw.u32 q0, [q7, #188]
	vldrw.u32 q2, [q7, #316]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #492]
	vldrw.u32 q3, [q7, #348]
	vldrw.u32 q4, [q7, #428]
	vldrw.u32 q0, [q6, #-508]
	vldrw.u32 q1, [q6, #4]
	veor q0, q0, q3
	veor q1, q1, q4
	vorr q2, q0, q0
	vstrw.u32 q2, [q6, #404]
	vorr q5, q1, q1
	vstrw.u32 q5, [q7, #-212]
	vldrw.u32 q0, [q6, #-428]
	vldrw.u32 q1, [q6, #84]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #18
	vsri.32 q2, q0, #14
	vstrw.u32 q2, [q7, #-356]
	vshl.i32 q5, q1, #18
	vsri.32 q5, q1, #14
	vstrw.u32 q5, [q7, #44]
	vldrw.u32 q0, [q6, #-348]
	vldrw.u32 q1, [q6, #164]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #2
	vsri.32 q2, q1, #30
	vstrw.u32 q2, [q7, #-500]
	vshl.i32 q5, q0, #1
	vsri.32 q5, q0, #31
	vstrw.u32 q5, [q7, #-100]
	vldrw.u32 q0, [q6, #-268]
	vldrw.u32 q1, [q6, #244]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #21
	vsri.32 q2, q1, #11
	vstrw.u32 q2, [q7, #-244]
	vshl.i32 q5, q0, #20
	vsri.32 q5, q0, #12
	vstrw.u32 q5, [q7, #156]
	vldrw.u32 q0, [q6, #-188]
	vldrw.u32 q1, [q6, #324]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #9
	vsri.32 q2, q0, #23
	vstrw.u32 q2, [q7, #-388]
	vshl.i32 q5, q1, #9
	vsri.32 q5, q1, #23
	vstrw.u32 q5, [q7, #12]
	vldrw.u32 q3, [q7, #364]
	vldrw.u32 q4, [q7, #444]
	vldrw.u32 q0, [q6, #-492]
	vldrw.u32 q1, [q6, #20]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #1
	vsri.32 q2, q1, #31
	vstrw.u32 q2, [q7, #-452]
	vorr q5, q0, q0
	vstrw.u32 q5, [q7, #-52]
	vldrw.u32 q0, [q6, #-412]
	vldrw.u32 q1, [q6, #100]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #22
	vsri.32 q2, q0, #10
	vstrw.u32 q2, [q6, #420]
	vshl.i32 q5, q1, #22
	vsri.32 q5, q1, #10
	vstrw.u32 q5, [q7, #-196]
	vldrw.u32 q0, [q6, #-332]
	vldrw.u32 q1, [q6, #180]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #5
	vsri.32 q2, q0, #27
	vstrw.u32 q2, [q7, #-340]
	vshl.i32 q5, q1, #5
	vsri.32 q5, q1, #27
	vstrw.u32 q5, [q7, #60]
	vldrw.u32 q0, [q6, #-252]
	vldrw.u32 q1, [q6, #260]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #23
	vsri.32 q2, q1, #9
	vstrw.u32 q2, [q7, #-484]
	vshl.i32 q5, q0, #22
	vsri.32 q5, q0, #10
	vstrw.u32 q5, [q7, #-84]
	vldrw.u32 q0, [q6, #-172]
	vldrw.u32 q1, [q6, #340]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #1
	vsri.32 q2, q0, #31
	vstrw.u32 q2, [q7, #-228]
	vshl.i32 q5, q1, #1
	vsri.32 q5, q1, #31
	vstrw.u32 q5, [q7, #172]
	vldrw.u32 q3, [q7, #380]
	vldrw.u32 q4, [q7, #460]
	vldrw.u32 q0, [q6, #-476]
	vldrw.u32 q1, [q6, #36]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #31
	vsri.32 q2, q0, #1
	vstrw.u32 q2, [q7, #-292]
	vshl.i32 q5, q1, #31
	vsri.32 q5, q1, #1
	vstrw.u32 q5, [q7, #108]
	vldrw.u32 q0, [q6, #-396]
	vldrw.u32 q1, [q6, #116]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #3
	vsri.32 q2, q0, #29
	vstrw.u32 q2, [q7, #-436]
	vshl.i32 q5, q1, #3
	vsri.32 q5, q1, #29
	vstrw.u32 q5, [q7, #-36]
	vldrw.u32 q0, [q6, #-316]
	vldrw.u32 q1, [q6, #196]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #22
	vsri.32 q2, q1, #10
	vstrw.u32 q2, [q6, #436]
	vshl.i32 q5, q0, #21
	vsri.32 q5, q0, #11
	vstrw.u32 q5, [q7, #-180]
	vldrw.u32 q0, [q6, #-236]
	vldrw.u32 q1, [q6, #276]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #8
	vsri.32 q2, q1, #24
	vstrw.u32 q2, [q7, #-324]
	vshl.i32 q5, q0, #7
	vsri.32 q5, q0, #25
	vstrw.u32 q5, [q7, #76]
	vldrw.u32 q0, [q6, #-156]
	vldrw.u32 q1, [q6, #356]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #31
	vsri.32 q2, q1, #1
	vstrw.u32 q2, [q7, #-468]
	vshl.i32 q5, q0, #30
	vsri.32 q5, q0, #2
	vstrw.u32 q5, [q7, #-68]
	vldrw.u32 q3, [q7, #396]
	vldrw.u32 q4, [q7, #476]
	vldrw.u32 q0, [q6, #-460]
	vldrw.u32 q1, [q6, #52]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #14
	vsri.32 q2, q0, #18
	vstrw.u32 q2, [q6, #484]
	vshl.i32 q5, q1, #14
	vsri.32 q5, q1, #18
	vstrw.u32 q5, [q7, #-132]
	vldrw.u32 q0, [q6, #-380]
	vldrw.u32 q1, [q6, #132]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #28
	vsri.32 q2, q1, #4
	vstrw.u32 q2, [q7, #-276]
	vshl.i32 q5, q0, #27
	vsri.32 q5, q0, #5
	vstrw.u32 q5, [q7, #124]
	vldrw.u32 q0, [q6, #-300]
	vldrw.u32 q1, [q6, #212]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #13
	vsri.32 q2, q1, #19
	vstrw.u32 q2, [q7, #-420]
	vshl.i32 q5, q0, #12
	vsri.32 q5, q0, #20
	vstrw.u32 q5, [q7, #-20]
	vldrw.u32 q0, [q6, #-220]
	vldrw.u32 q1, [q6, #292]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #11
	vsri.32 q2, q1, #21
	vstrw.u32 q2, [q6, #452]
	vshl.i32 q5, q0, #10
	vsri.32 q5, q0, #22
	vstrw.u32 q5, [q7, #-164]
	vldrw.u32 q0, [q6, #-140]
	vldrw.u32 q1, [q6, #372]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #28
	vsri.32 q2, q0, #4
	vstrw.u32 q2, [q7, #-308]
	vshl.i32 q5, q1, #28
	vsri.32 q5, q1, #4
	vstrw.u32 q5, [q7, #92]
	vldrw.u32 q3, [q7, #412]
	vldrw.u32 q4, [q7, #492]
	vldrw.u32 q0, [q6, #-444]
	vldrw.u32 q1, [q6, #68]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #14
	vsri.32 q2, q1, #18
	vstrw.u32 q2, [q7, #-372]
	vshl.i32 q5, q0, #13
	vsri.32 q5, q0, #19
	vstrw.u32 q5, [q7, #28]
	vldrw.u32 q0, [q6, #-364]
	vldrw.u32 q1, [q6, #148]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #10
	vsri.32 q2, q0, #22
	vstrw.u32 q2, [q6, #500]
	vshl.i32 q5, q1, #10
	vsri.32 q5, q1, #22
	vstrw.u32 q5, [q7, #-116]
	vldrw.u32 q0, [q6, #-284]
	vldrw.u32 q1, [q6, #228]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #20
	vsri.32 q2, q1, #12
	vstrw.u32 q2, [q7, #-260]
	vshl.i32 q5, q0, #19
	vsri.32 q5, q0, #13
	vstrw.u32 q5, [q7, #140]
	vldrw.u32 q0, [q6, #-204]
	vldrw.u32 q1, [q6, #308]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #4
	vsri.32 q2, q0, #28
	vstrw.u32 q2, [q7, #-404]
	vshl.i32 q5, q1, #4
	vsri.32 q5, q1, #28
	vstrw.u32 q5, [q7, #-4]
	vldrw.u32 q0, [q6, #-124]
	vldrw.u32 q1, [q6, #388]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #7
	vsri.32 q2, q0, #25
	vstrw.u32 q2, [q6, #468]
	vshl.i32 q5, q1, #7
	vsri.32 q5, q1, #25
	vstrw.u32 q5, [q7, #-148]
	vldrw.u32 q0, [q6, #404]
	vldrw.u32 q1, [q6, #420]
	vldrw.u32 q2, [q6, #436]
	vldrw.u32 q5, [q6, #452]
	vldrw.u32 q3, [q6, #468]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-508]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-492]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-476]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-460]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-444]
	vldrw.u32 q0, [q6, #484]
	vldrw.u32 q1, [q6, #500]
	vldrw.u32 q2, [q7, #-500]
	vldrw.u32 q5, [q7, #-484]
	vldrw.u32 q3, [q7, #-468]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-428]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-412]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-396]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-380]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-364]
	vldrw.u32 q0, [q7, #-452]
	vldrw.u32 q1, [q7, #-436]
	vldrw.u32 q2, [q7, #-420]
	vldrw.u32 q5, [q7, #-404]
	vldrw.u32 q3, [q7, #-388]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-348]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-332]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-316]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-300]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-284]
	vldrw.u32 q0, [q7, #-372]
	vldrw.u32 q1, [q7, #-356]
	vldrw.u32 q2, [q7, #-340]
	vldrw.u32 q5, [q7, #-324]
	vldrw.u32 q3, [q7, #-308]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-268]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-252]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-236]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-220]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-204]
	vldrw.u32 q0, [q7, #-292]
	vldrw.u32 q1, [q7, #-276]
	vldrw.u32 q2, [q7, #-260]
	vldrw.u32 q5, [q7, #-244]
	vldrw.u32 q3, [q7, #-228]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-188]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-172]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-156]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-140]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-124]
	vldrw.u32 q0, [q7, #-212]
	vldrw.u32 q1, [q7, #-196]
	vldrw.u32 q2, [q7, #-180]
	vldrw.u32 q5, [q7, #-164]
	vldrw.u32 q3, [q7, #-148]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #4]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #20]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #36]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #52]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #68]
	vldrw.u32 q0, [q7, #-132]
	vldrw.u32 q1, [q7, #-116]
	vldrw.u32 q2, [q7, #-100]
	vldrw.u32 q5, [q7, #-84]
	vldrw.u32 q3, [q7, #-68]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #84]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #100]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #116]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #132]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #148]
	vldrw.u32 q0, [q7, #-52]
	vldrw.u32 q1, [q7, #-36]
	vldrw.u32 q2, [q7, #-20]
	vldrw.u32 q5, [q7, #-4]
	vldrw.u32 q3, [q7, #12]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #164]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #180]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #196]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #212]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #228]
	vldrw.u32 q0, [q7, #28]
	vldrw.u32 q1, [q7, #44]
	vldrw.u32 q2, [q7, #60]
	vldrw.u32 q5, [q7, #76]
	vldrw.u32 q3, [q7, #92]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #244]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #260]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #276]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #292]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #308]
	vldrw.u32 q0, [q7, #108]
	vldrw.u32 q1, [q7, #124]
	vldrw.u32 q2, [q7, #140]
	vldrw.u32 q5, [q7, #156]
	vldrw.u32 q3, [q7, #172]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #324]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #340]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #356]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #372]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #388]
	vmov.i32 q0, #1
	vldrw.u32 q1, [q6, #-508]
	veor q1, q1, q0
	vstrw.u32 q1, [q6, #-508]
	ldr r0, [sp, #132]
	subs r0, r0, #1
	str r0, [sp, #132]
	bne 1b
	add sp, sp, #140
	vpop {d8-d15}
	pop {r4-r11, pc}

// expt_stitch
.global expt_stitch
.type expt_stitch, %function
.thumb_func
.balign 16
expt_stitch:
	push {r4-r11, lr}
	vpush {d8-d15}
	sub sp, sp, #140
	str r0, [sp, #132]
	movw r1, #:lower16:g_mve
	movt r1, #:upper16:g_mve
	adr r2, 2f
	b 3f
	.balign 16
2:	.word 0, 4, 8, 12
3:
	vldrw.u32 q6, [r2]
	add r3, r1, #1524
	vadd.i32 q7, q6, r3
	add r3, r1, #508
	vadd.i32 q6, q6, r3
.balign 16
1:
	movw r0, #:lower16:g_fc_out
	vldrw.u32 q0, [q6, #-508]
	movt r0, #:upper16:g_fc_out
	vldrw.u32 q1, [q6, #-428]
	movw r1, #:lower16:g_fc_a
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-348]
	movt r1, #:upper16:g_fc_a
	veor q0, q0, q1
	movw r2, #:lower16:g_fc_b
	vldrw.u32 q1, [q6, #-268]
	veor q0, q0, q1
	movt r2, #:upper16:g_fc_b
	vldrw.u32 q1, [q6, #-188]
	mov	lr, r2
	veor q0, q0, q1
	mov	ip, #38
	vstrw.u32 q0, [q7, #188]
	vldrw.u32 q0, [q6, #-492]
	ldr	r7, [r2, #32]
	vldrw.u32 q1, [q6, #-412]
	str	r7, [sp, #100]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-332]
	ldr	r7, [r1, #32]
	veor q0, q0, q1
	ldr	r6, [r2, #12]
	vldrw.u32 q1, [q6, #-252]
	str	r7, [sp, #76]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-172]
	ldr	r7, [lr, #20]
	veor q0, q0, q1
	ldr	r3, [r2, #4]
	vstrw.u32 q0, [q7, #204]
	vldrw.u32 q0, [q6, #-476]
	mul	r8, ip, r7
	vldrw.u32 q1, [q6, #-396]
	ldr	r4, [r2, #8]
	veor q0, q0, q1
	str	r6, [sp, #36]
	vldrw.u32 q1, [q6, #-316]
	veor q0, q0, q1
	mul	r2, ip, r6
	vldrw.u32 q1, [q6, #-236]
	str	r7, [sp, #48]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-156]
	ldr	r6, [r1, #16]
	veor q0, q0, q1
	ldr	r7, [lr, #28]
	vstrw.u32 q0, [q7, #220]
	str	r6, [sp, #4]
	vldrw.u32 q0, [q6, #-460]
	vldrw.u32 q1, [q6, #-380]
	mov	r6, r7
	veor q0, q0, q1
	ldr	r5, [r1, #36]
	vldrw.u32 q1, [q6, #-300]
	veor q0, q0, q1
	str	r0, [sp, #80]
	vldrw.u32 q1, [q6, #-220]
	str	r5, [sp, #92]
	veor q0, q0, q1
	mov	r5, r4
	vldrw.u32 q1, [q6, #-140]
	veor q0, q0, q1
	ldr	r0, [lr, #16]
	vstrw.u32 q0, [q7, #236]
	str	r2, [sp, #112]
	vldrw.u32 q0, [q6, #-444]
	vldrw.u32 q1, [q6, #-364]
	ldr	r2, [r1, #24]
	veor q0, q0, q1
	str	r8, [sp, #108]
	vldrw.u32 q1, [q6, #-284]
	str	r2, [sp, #16]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-204]
	add	r2, r0, r0, lsl #3
	veor q0, q0, q1
	add	r10, r0, r2, lsl #1
	vldrw.u32 q1, [q6, #-124]
	veor q0, q0, q1
	ldr	r2, [lr, #24]
	vstrw.u32 q0, [q7, #252]
	mul	r8, ip, r6
	vldrw.u32 q0, [q6, #4]
	add	r7, r2, r2, lsl #3
	vldrw.u32 q1, [q6, #84]
	veor q0, q0, q1
	add	fp, r2, r7, lsl #1
	vldrw.u32 q1, [q6, #164]
	ldr	r7, [r1, #12]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #244]
	add	r4, r4, r4, lsl #3
	veor q0, q0, q1
	str	r5, [sp, #40]
	vldrw.u32 q1, [q6, #324]
	add	r4, r5, r4, lsl #1
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #268]
	str	r3, [sp, #52]
	vldrw.u32 q0, [q6, #20]
	mul	r5, ip, r3
	vldrw.u32 q1, [q6, #100]
	veor q0, q0, q1
	str	r0, [sp, #72]
	vldrw.u32 q1, [q6, #180]
	ldr	r3, [r1, #28]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #260]
	ldr	r0, [r1, #20]
	veor q0, q0, q1
	str	r2, [sp, #104]
	vldrw.u32 q1, [q6, #340]
	str	r6, [sp, #68]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #284]
	str	r8, [sp, #84]
	vldrw.u32 q0, [q6, #36]
	str	r7, [sp, #24]
	vldrw.u32 q1, [q6, #116]
	veor q0, q0, q1
	ldr	r2, [lr, #36]
	vldrw.u32 q1, [q6, #196]
	ldr	r7, [r1, #8]
	veor q0, q0, q1
	mul	ip, ip, r2
	vldrw.u32 q1, [q6, #276]
	veor q0, q0, q1
	str	r7, [sp, #8]
	vldrw.u32 q1, [q6, #356]
	ldr	r7, [lr]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #300]
	str	r2, [sp, #96]
	vldrw.u32 q0, [q6, #52]
	ldr	r2, [r1, #4]
	vldrw.u32 q1, [q6, #132]
	str	r7, [sp, #12]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #212]
	ldr	r7, [sp, #100]
	veor q0, q0, q1
	str	r2, [sp]
	vldrw.u32 q1, [q6, #292]
	veor q0, q0, q1
	ldr	r2, [r1]
	vldrw.u32 q1, [q6, #372]
	ldr	r1, [sp, #36]
	veor q0, q0, q1
	str	ip, [sp, #64]
	vstrw.u32 q0, [q7, #316]
	vldrw.u32 q0, [q6, #68]
	add	ip, r7, r7, lsl #3
	vldrw.u32 q1, [q6, #148]
	add	ip, r7, ip, lsl #1
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #228]
	add	lr, r1, r1, lsl #3
	veor q0, q0, q1
	ldr	r7, [sp, #76]
	vldrw.u32 q1, [q6, #308]
	add	lr, r1, lr, lsl #1
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #388]
	str	ip, [sp, #32]
	veor q0, q0, q1
	umull	lr, ip, lr, r7
	vstrw.u32 q0, [q7, #332]
	vldrw.u32 q0, [q7, #284]
	ldr	r1, [sp, #92]
	vshl.i32 q1, q0, #1
	mov	r6, r3
	vsri.32 q1, q0, #31
	umlal	lr, ip, r1, r4
	vldrw.u32 q2, [q7, #252]
	veor q1, q1, q2
	umull	r4, r1, r4, r7
	vstrw.u32 q1, [q7, #348]
	umlal	lr, ip, r10, r3
	vldrw.u32 q0, [q7, #204]
	vldrw.u32 q2, [q7, #332]
	ldr	r3, [sp, #92]
	veor q0, q0, q2
	ldr	r7, [sp, #8]
	vstrw.u32 q0, [q7, #428]
	umlal	r4, r1, r3, r5
	vldrw.u32 q0, [q7, #300]
	vshl.i32 q1, q0, #1
	mov	r8, r4
	vsri.32 q1, q0, #31
	ldr	r4, [sp, #112]
	vldrw.u32 q2, [q7, #188]
	veor q1, q1, q2
	ldr	r5, [sp, #108]
	vstrw.u32 q1, [q7, #364]
	umlal	r8, r1, r4, r6
	vldrw.u32 q0, [q7, #220]
	ldr	r4, [sp, #16]
	vldrw.u32 q2, [q7, #268]
	veor q0, q0, q2
	mov	r3, r6
	vstrw.u32 q0, [q7, #444]
	umlal	r8, r1, r10, r4
	vldrw.u32 q0, [q7, #316]
	vshl.i32 q1, q0, #1
	umlal	r8, r1, r5, r0
	vsri.32 q1, q0, #31
	ldr	r6, [sp, #4]
	vldrw.u32 q2, [q7, #204]
	veor q1, q1, q2
	ldr	r5, [sp, #84]
	vstrw.u32 q1, [q7, #380]
	umlal	r8, r1, fp, r6
	vldrw.u32 q0, [q7, #236]
	ldr	r6, [sp, #24]
	vldrw.u32 q2, [q7, #284]
	veor q0, q0, q2
	umlal	r8, r1, r5, r6
	vstrw.u32 q0, [q7, #460]
	ldr	r6, [sp, #32]
	vldrw.u32 q0, [q7, #332]
	vshl.i32 q1, q0, #1
	ldr	r5, [sp]
	vsri.32 q1, q0, #31
	umlal	r8, r1, r6, r7
	vldrw.u32 q2, [q7, #220]
	ldr	r6, [sp, #64]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #396]
	umlal	r8, r1, r6, r5
	vldrw.u32 q0, [q7, #252]
	ldr	r6, [sp, #12]
	vldrw.u32 q2, [q7, #300]
	veor q0, q0, q2
	umlal	r8, r1, r6, r2
	vstrw.u32 q0, [q7, #476]
	ldr	r6, [sp, #48]
	vldrw.u32 q0, [q7, #268]
	str	r1, [sp, #60]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	add	r1, r6, r6, lsl #3
	vldrw.u32 q2, [q7, #236]
	add	r1, r6, r1, lsl #1
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #412]
	umlal	lr, ip, r1, r4
	vldrw.u32 q0, [q7, #188]
	str	r8, [sp, #56]
	vldrw.u32 q2, [q7, #316]
	bic	r8, r8, #-67108864
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #492]
	umlal	lr, ip, fp, r0
	vldrw.u32 q3, [q7, #348]
	str	r8, [sp, #120]
	vldrw.u32 q4, [q7, #428]
	vldrw.u32 q0, [q6, #-508]
	ldr	r4, [sp, #68]
	vldrw.u32 q1, [q6, #4]
	ldr	r6, [sp, #4]
	veor q0, q0, q3
	add	r8, r4, r4, lsl #3
	veor q1, q1, q4
	vorr q2, q0, q0
	add	r8, r4, r8, lsl #1
	vstrw.u32 q2, [q6, #404]
	umlal	lr, ip, r8, r6
	vorr q5, q1, q1
	vstrw.u32 q5, [q7, #-212]
	ldr	r5, [sp, #32]
	vldrw.u32 q0, [q6, #-428]
	ldr	r6, [sp, #24]
	vldrw.u32 q1, [q6, #84]
	str	r8, [sp, #116]
	veor q0, q0, q3
	veor q1, q1, q4
	umlal	lr, ip, r5, r6
	vshl.i32 q2, q0, #18
	ldrd	r6, [sp, #56]
	vsri.32 q2, q0, #14
	vstrw.u32 q2, [q7, #-356]
	lsrl	r6, r7, #26
	vshl.i32 q5, q1, #18
	ldr	r5, [sp, #96]
	vsri.32 q5, q1, #14
	strd	r6, [sp, #56]
	vstrw.u32 q5, [q7, #44]
	vldrw.u32 q0, [q6, #-348]
	add	r8, r5, r5, lsl #3
	vldrw.u32 q1, [q6, #164]
	add	r8, r5, r8, lsl #1
	veor q0, q0, q3
	veor q1, q1, q4
	mov	r6, r8
	vshl.i32 q2, q1, #2
	ldr	r7, [sp, #8]
	vsri.32 q2, q1, #30
	ldr	r5, [sp, #12]
	vstrw.u32 q2, [q7, #-500]
	vshl.i32 q5, q0, #1
	umlal	lr, ip, r8, r7
	vsri.32 q5, q0, #31
	ldr	r4, [sp]
	vstrw.u32 q5, [q7, #-100]
	vldrw.u32 q0, [q6, #-268]
	str	r2, [sp, #44]
	vldrw.u32 q1, [q6, #244]
	umlal	lr, ip, r4, r5
	veor q0, q0, q3
	veor q1, q1, q4
	ldr	r4, [sp, #52]
	vshl.i32 q2, q1, #21
	ldr	r7, [sp, #76]
	vsri.32 q2, q1, #11
	umlal	lr, ip, r4, r2
	vstrw.u32 q2, [q7, #-244]
	vshl.i32 q5, q0, #20
	lsls	r4, r4, #1
	vsri.32 q5, q0, #12
	str	r4, [sp, #88]
	vstrw.u32 q5, [q7, #156]
	vldrw.u32 q0, [q6, #-188]
	ldr	r4, [sp, #56]
	vldrw.u32 q1, [q6, #324]
	ldr	r2, [sp, #60]
	veor q0, q0, q3
	adds	r4, lr, r4
	veor q1, q1, q4
	vshl.i32 q2, q0, #9
	adc	r9, ip, r2
	vsri.32 q2, q0, #23
	bic	ip, r4, #-33554432
	vstrw.u32 q2, [q7, #-388]
	vshl.i32 q5, q1, #9
	str	ip, [sp, #124]
	vsri.32 q5, q1, #23
	umull	r1, ip, r7, r1
	vstrw.u32 q5, [q7, #12]
	ldr	r5, [sp, #92]
	vldrw.u32 q3, [q7, #364]
	vldrw.u32 q4, [q7, #444]
	ldr	r2, [sp, #116]
	vldrw.u32 q0, [q6, #-492]
	umlal	r1, ip, r5, r10
	vldrw.u32 q1, [q6, #20]
	veor q0, q0, q3
	umlal	r1, ip, fp, r3
	veor q1, q1, q4
	mov	r8, r4
	vshl.i32 q2, q1, #1
	ldr	r4, [sp, #16]
	vsri.32 q2, q1, #31
	vstrw.u32 q2, [q7, #-452]
	str	r6, [sp, #92]
	vorr q5, q0, q0
	umlal	r1, ip, r2, r4
	vstrw.u32 q5, [q7, #-52]
	vldrw.u32 q0, [q6, #-412]
	ldr	r2, [sp, #32]
	vldrw.u32 q1, [q6, #100]
	lsrl	r8, r9, #25
	veor q0, q0, q3
	umlal	r1, ip, r2, r0
	veor q1, q1, q4
	vshl.i32 q2, q0, #22
	mov	r2, r6
	vsri.32 q2, q0, #10
	ldr	r6, [sp, #4]
	vstrw.u32 q2, [q6, #420]
	vshl.i32 q5, q1, #22
	umlal	r1, ip, r2, r6
	vsri.32 q5, q1, #10
	ldr	r6, [sp, #24]
	vstrw.u32 q5, [q7, #-196]
	ldr	r2, [sp, #12]
	vldrw.u32 q0, [q6, #-332]
	vldrw.u32 q1, [q6, #180]
	umlal	r1, ip, r6, r2
	veor q0, q0, q3
	ldr	r6, [sp, #52]
	veor q1, q1, q4
	vshl.i32 q2, q0, #5
	ldr	r2, [sp, #8]
	vsri.32 q2, q0, #27
	umlal	r1, ip, r2, r6
	vstrw.u32 q2, [q7, #-340]
	ldr	r6, [sp, #40]
	vshl.i32 q5, q1, #5
	vsri.32 q5, q1, #27
	ldr	r2, [sp]
	vstrw.u32 q5, [q7, #60]
	umlal	r1, ip, r2, r6
	vldrw.u32 q0, [q6, #-252]
	vldrw.u32 q1, [q6, #260]
	mov	lr, r1
	veor q0, q0, q3
	ldr	r6, [sp, #36]
	veor q1, q1, q4
	ldr	r1, [sp, #44]
	vshl.i32 q2, q1, #23
	vsri.32 q2, q1, #9
	umlal	lr, ip, r6, r1
	vstrw.u32 q2, [q7, #-484]
	str	lr, [sp, #56]
	vshl.i32 q5, q0, #22
	vsri.32 q5, q0, #10
	umull	lr, r1, r10, r7
	vstrw.u32 q5, [q7, #-84]
	ldr	r6, [sp, #112]
	vldrw.u32 q0, [q6, #-172]
	ldr	r2, [sp, #84]
	vldrw.u32 q1, [q6, #340]
	veor q0, q0, q3
	umlal	lr, r1, r5, r6
	veor q1, q1, q4
	ldr	r6, [sp, #108]
	vshl.i32 q2, q0, #1
	vsri.32 q2, q0, #31
	umlal	lr, r1, r6, r3
	vstrw.u32 q2, [q7, #-228]
	umlal	lr, r1, fp, r4
	vshl.i32 q5, q1, #1
	vsri.32 q5, q1, #31
	umlal	lr, r1, r2, r0
	vstrw.u32 q5, [q7, #172]
	ldr	r6, [sp, #4]
	vldrw.u32 q3, [q7, #380]
	ldr	r2, [sp, #32]
	vldrw.u32 q4, [q7, #460]
	vldrw.u32 q0, [q6, #-476]
	umlal	lr, r1, r2, r6
	vldrw.u32 q1, [q6, #36]
	ldr	r6, [sp, #24]
	veor q0, q0, q3
	veor q1, q1, q4
	ldr	r2, [sp, #64]
	vshl.i32 q2, q0, #31
	umlal	lr, r1, r2, r6
	vsri.32 q2, q0, #1
	ldrd	r7, r2, [sp, #8]
	vstrw.u32 q2, [q7, #-292]
	vshl.i32 q5, q1, #31
	umlal	lr, r1, r7, r2
	vsri.32 q5, q1, #1
	ldr	r2, [sp, #88]
	vstrw.u32 q5, [q7, #108]
	vldrw.u32 q0, [q6, #-396]
	ldr	r7, [sp]
	vldrw.u32 q1, [q6, #116]
	umlal	lr, r1, r7, r2
	veor q0, q0, q3
	ldrd	r7, r2, [sp, #40]
	veor q1, q1, q4
	vshl.i32 q2, q0, #3
	umlal	lr, r1, r7, r2
	vsri.32 q2, q0, #29
	adds	lr, lr, r8
	vstrw.u32 q2, [q7, #-436]
	vshl.i32 q5, q1, #3
	adc	r2, r1, r9
	vsri.32 q5, q1, #29
	str	lr, [sp, #16]
	vstrw.u32 q5, [q7, #-36]
	str	r2, [sp, #20]
	vldrw.u32 q0, [q6, #-316]
	vldrw.u32 q1, [q6, #196]
	ldrd	r8, [sp, #16]
	veor q0, q0, q3
	lsrl	r8, r9, #26
	veor q1, q1, q4
	vshl.i32 q2, q1, #22
	ldr	r7, [sp, #76]
	vsri.32 q2, q1, #10
	ldr	r2, [sp, #116]
	vstrw.u32 q2, [q6, #436]
	bic	lr, lr, #-67108864
	vshl.i32 q5, q0, #21
	vsri.32 q5, q0, #11
	str	lr, [sp, #112]
	vstrw.u32 q5, [q7, #-180]
	umull	r10, lr, r7, r2
	vldrw.u32 q0, [q6, #-236]
	vldrw.u32 q1, [q6, #276]
	umlal	r10, lr, r5, fp
	veor q0, q0, q3
	ldr	r2, [sp, #32]
	veor q1, q1, q4
	str	r4, [sp, #16]
	vshl.i32 q2, q1, #8
	vsri.32 q2, q1, #24
	umlal	r10, lr, r2, r3
	vstrw.u32 q2, [q7, #-324]
	ldr	r2, [sp, #92]
	vshl.i32 q5, q0, #7
	vsri.32 q5, q0, #25
	str	r0, [sp, #76]
	vstrw.u32 q5, [q7, #76]
	umlal	r10, lr, r2, r4
	vldrw.u32 q0, [q6, #-156]
	ldr	r2, [sp, #12]
	vldrw.u32 q1, [q6, #356]
	veor q0, q0, q3
	ldr	r4, [sp, #4]
	veor q1, q1, q4
	umlal	r10, lr, r0, r2
	vshl.i32 q2, q1, #31
	vsri.32 q2, q1, #1
	ldr	r2, [sp, #52]
	vstrw.u32 q2, [q7, #-468]
	ldr	r0, [sp, #56]
	vshl.i32 q5, q0, #30
	umlal	r10, lr, r4, r2
	vsri.32 q5, q0, #2
	vstrw.u32 q5, [q7, #-68]
	ldr	r4, [sp, #40]
	vldrw.u32 q3, [q7, #396]
	ldr	r1, [sp, #36]
	vldrw.u32 q4, [q7, #476]
	vldrw.u32 q0, [q6, #-460]
	umlal	r10, lr, r6, r4
	vldrw.u32 q1, [q6, #52]
	ldr	r4, [sp, #36]
	veor q0, q0, q3
	veor q1, q1, q4
	ldr	r6, [sp, #8]
	vshl.i32 q2, q0, #14
	ldr	r2, [sp]
	vsri.32 q2, q0, #18
	umlal	r10, lr, r6, r4
	vstrw.u32 q2, [q6, #484]
	vshl.i32 q5, q1, #14
	mov	r4, r8
	vsri.32 q5, q1, #18
	adds	r4, r0, r4
	vstrw.u32 q5, [q7, #-132]
	vldrw.u32 q0, [q6, #-380]
	adc	r0, ip, r9
	vldrw.u32 q1, [q6, #132]
	str	r0, [sp, #60]
	veor q0, q0, q3
	ldr	r0, [sp, #72]
	veor q1, q1, q4
	vshl.i32 q2, q1, #28
	str	r4, [sp, #56]
	vsri.32 q2, q1, #4
	umlal	r10, lr, r2, r0
	vstrw.u32 q2, [q7, #-276]
	vshl.i32 q5, q0, #27
	ldrd	r8, [sp, #56]
	vsri.32 q5, q0, #5
	ldr	r2, [sp, #80]
	vstrw.u32 q5, [q7, #124]
	bic	r4, r4, #-33554432
	vldrw.u32 q0, [q6, #-300]
	vldrw.u32 q1, [q6, #212]
	str	r4, [r2, #12]
	veor q0, q0, q3
	umull	r4, ip, fp, r7
	veor q1, q1, q4
	vshl.i32 q2, q1, #13
	ldrd	r2, r6, [sp, #44]
	vsri.32 q2, q1, #19
	ldr	r0, [sp, #108]
	vstrw.u32 q2, [q7, #-420]
	lsrl	r8, r9, #25
	vshl.i32 q5, q0, #12
	vsri.32 q5, q0, #20
	umlal	r4, ip, r5, r0
	vstrw.u32 q5, [q7, #-20]
	ldr	r0, [sp, #84]
	vldrw.u32 q0, [q6, #-220]
	vldrw.u32 q1, [q6, #292]
	umlal	r10, lr, r6, r2
	veor q0, q0, q3
	umlal	r4, ip, r0, r3
	veor q1, q1, q4
	ldr	r2, [sp, #32]
	vshl.i32 q2, q1, #11
	vsri.32 q2, q1, #21
	ldr	r0, [sp, #16]
	vstrw.u32 q2, [q6, #452]
	ldr	r6, [sp, #64]
	vshl.i32 q5, q0, #10
	vsri.32 q5, q0, #22
	umlal	r4, ip, r2, r0
	vstrw.u32 q5, [q7, #-164]
	ldr	r0, [sp, #76]
	vldrw.u32 q0, [q6, #-140]
	ldr	r2, [sp, #12]
	vldrw.u32 q1, [q6, #372]
	veor q0, q0, q3
	umlal	r4, ip, r6, r0
	veor q1, q1, q4
	ldr	r6, [sp, #4]
	vshl.i32 q2, q0, #28
	vsri.32 q2, q0, #4
	lsls	r1, r1, #1
	vstrw.u32 q2, [q7, #-308]
	umlal	r4, ip, r6, r2
	vshl.i32 q5, q1, #28
	ldr	r6, [sp, #24]
	vsri.32 q5, q1, #4
	vstrw.u32 q5, [q7, #92]
	ldr	r2, [sp, #88]
	vldrw.u32 q3, [q7, #412]
	str	r10, [sp, #116]
	vldrw.u32 q4, [q7, #492]
	vldrw.u32 q0, [q6, #-444]
	umlal	r4, ip, r6, r2
	vldrw.u32 q1, [q6, #68]
	ldr	r6, [sp, #8]
	veor q0, q0, q3
	ldr	r2, [sp, #40]
	veor q1, q1, q4
	vshl.i32 q2, q1, #14
	umlal	r4, ip, r6, r2
	vsri.32 q2, q1, #18
	ldr	r2, [sp]
	vstrw.u32 q2, [q7, #-372]
	vshl.i32 q5, q0, #13
	ldr	r6, [sp, #72]
	vsri.32 q5, q0, #19
	umlal	r4, ip, r2, r1
	vstrw.u32 q5, [q7, #28]
	vldrw.u32 q0, [q6, #-364]
	ldr	r2, [sp, #44]
	vldrw.u32 q1, [q6, #148]
	umlal	r4, ip, r6, r2
	veor q0, q0, q3
	adds	r8, r4, r8
	veor q1, q1, q4
	vshl.i32 q2, q0, #10
	adc	ip, ip, r9
	vsri.32 q2, q0, #22
	str	r8, [sp, #56]
	vstrw.u32 q2, [q6, #500]
	vshl.i32 q5, q1, #10
	str	ip, [sp, #60]
	vsri.32 q5, q1, #22
	ldrd	r10, [sp, #56]
	vstrw.u32 q5, [q7, #-116]
	lsrl	r10, fp, #26
	vldrw.u32 q0, [q6, #-284]
	vldrw.u32 q1, [q6, #228]
	ldr	r2, [sp, #80]
	veor q0, q0, q3
	bic	r8, r8, #-67108864
	veor q1, q1, q4
	vshl.i32 q2, q1, #20
	strd	r10, [sp, #56]
	vsri.32 q2, q1, #12
	str	r8, [r2, #16]
	vstrw.u32 q2, [q7, #-260]
	ldr	r4, [sp, #48]
	vshl.i32 q5, q0, #19
	vsri.32 q5, q0, #13
	ldr	r2, [sp, #12]
	vstrw.u32 q5, [q7, #140]
	lsl	ip, r4, #1
	vldrw.u32 q0, [q6, #-204]
	vldrw.u32 q1, [q6, #308]
	ldr	r4, [sp, #92]
	veor q0, q0, q3
	ldr	r6, [sp, #4]
	veor q1, q1, q4
	umull	fp, r10, r7, r4
	vshl.i32 q2, q0, #4
	vsri.32 q2, q0, #28
	ldrd	r8, [sp, #56]
	vstrw.u32 q2, [q7, #-404]
	ldr	r4, [sp, #32]
	vshl.i32 q5, q1, #4
	vsri.32 q5, q1, #28
	umlal	fp, r10, r5, r4
	vstrw.u32 q5, [q7, #-4]
	umlal	fp, r10, r3, r2
	vldrw.u32 q0, [q6, #-124]
	ldr	r4, [sp, #16]
	vldrw.u32 q1, [q6, #388]
	veor q0, q0, q3
	ldr	r2, [sp, #52]
	veor q1, q1, q4
	umlal	fp, r10, r4, r2
	vshl.i32 q2, q0, #7
	vsri.32 q2, q0, #25
	ldr	r4, [sp, #40]
	vstrw.u32 q2, [q6, #468]
	ldr	r2, [sp, #8]
	vshl.i32 q5, q1, #7
	umlal	fp, r10, r0, r4
	vsri.32 q5, q1, #25
	vstrw.u32 q5, [q7, #-148]
	ldr	r4, [sp, #36]
	vldrw.u32 q0, [q6, #404]
	umlal	fp, r10, r6, r4
	vldrw.u32 q1, [q6, #420]
	vldrw.u32 q2, [q6, #436]
	ldr	r6, [sp, #24]
	vldrw.u32 q5, [q6, #452]
	ldr	r4, [sp, #72]
	vldrw.u32 q3, [q6, #468]
	umlal	fp, r10, r6, r4
	vbic q4, q2, q1
	veor q4, q4, q0
	mov	r4, r8
	vstrw.u32 q4, [q6, #-508]
	ldr	r6, [sp, #116]
	vbic q4, q5, q2
	veor q4, q4, q1
	adds	r4, r6, r4
	vstrw.u32 q4, [q6, #-492]
	ldr	r6, [sp, #48]
	vbic q4, q3, q5
	str	r4, [sp, #56]
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-476]
	umlal	fp, r10, r2, r6
	vbic q4, q0, q3
	ldr	r2, [sp, #80]
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-460]
	bic	r4, r4, #-33554432
	vbic q4, q1, q0
	ldr	r6, [sp, #104]
	veor q4, q4, q3
	str	r4, [r2, #20]
	vstrw.u32 q4, [q6, #-444]
	vldrw.u32 q0, [q6, #484]
	ldr	r2, [sp]
	vldrw.u32 q1, [q6, #500]
	ldr	r4, [sp, #32]
	vldrw.u32 q2, [q7, #-500]
	vldrw.u32 q5, [q7, #-484]
	umlal	fp, r10, r2, r6
	vldrw.u32 q3, [q7, #-468]
	adc	lr, lr, r9
	vbic q4, q2, q1
	veor q4, q4, q0
	ldr	r6, [sp, #68]
	vstrw.u32 q4, [q6, #-428]
	ldr	r2, [sp, #44]
	vbic q4, q5, q2
	str	lr, [sp, #60]
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-412]
	umull	r4, lr, r4, r7
	vbic q4, q3, q5
	ldrd	r8, [sp, #56]
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-396]
	umlal	fp, r10, r6, r2
	vbic q4, q0, q3
	ldr	r2, [sp, #84]
	veor q4, q4, q5
	lsrl	r8, r9, #25
	vstrw.u32 q4, [q6, #-380]
	vbic q4, q1, q0
	umlal	r4, lr, r5, r2
	veor q4, q4, q3
	ldr	r2, [sp, #64]
	vstrw.u32 q4, [q6, #-364]
	vldrw.u32 q0, [q7, #-452]
	str	r3, [sp, #32]
	vldrw.u32 q1, [q7, #-436]
	umlal	r4, lr, r2, r3
	vldrw.u32 q2, [q7, #-420]
	ldrd	r2, r3, [sp, #12]
	vldrw.u32 q5, [q7, #-404]
	vldrw.u32 q3, [q7, #-388]
	umlal	r4, lr, r3, r2
	vbic q4, q2, q1
	str	fp, [sp, #76]
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-348]
	ldr	r3, [sp, #88]
	vbic q4, q5, q2
	ldr	r6, [sp, #4]
	veor q4, q4, q1
	umlal	r4, lr, r0, r3
	vstrw.u32 q4, [q6, #-332]
	vbic q4, q3, q5
	ldr	r3, [sp, #40]
	veor q4, q4, q2
	ldr	r2, [sp, #8]
	vstrw.u32 q4, [q6, #-316]
	vbic q4, q0, q3
	umlal	r4, lr, r6, r3
	veor q4, q4, q5
	ldr	r6, [sp, #24]
	vstrw.u32 q4, [q6, #-300]
	ldr	r3, [sp, #72]
	vbic q4, q1, q0
	veor q4, q4, q3
	umlal	r4, lr, r6, r1
	vstrw.u32 q4, [q6, #-284]
	umlal	r4, lr, r2, r3
	vldrw.u32 q0, [q7, #-372]
	vldrw.u32 q1, [q7, #-356]
	ldr	r3, [sp]
	vldrw.u32 q2, [q7, #-340]
	ldr	r2, [sp, #44]
	vldrw.u32 q5, [q7, #-324]
	umlal	r4, lr, r3, ip
	vldrw.u32 q3, [q7, #-308]
	vbic q4, q2, q1
	ldr	r3, [sp, #104]
	veor q4, q4, q0
	strd	r8, [sp, #56]
	vstrw.u32 q4, [q6, #-268]
	vbic q4, q5, q2
	umlal	r4, lr, r3, r2
	veor q4, q4, q1
	adds	r8, r4, r8
	vstrw.u32 q4, [q6, #-252]
	ldr	r4, [sp, #60]
	vbic q4, q3, q5
	veor q4, q4, q2
	str	r8, [sp, #24]
	vstrw.u32 q4, [q6, #-236]
	adc	r4, lr, r4
	vbic q4, q0, q3
	veor q4, q4, q5
	str	r4, [sp, #28]
	vstrw.u32 q4, [q6, #-220]
	ldrd	r2, [sp, #24]
	vbic q4, q1, q0
	lsrl	r2, r3, #26
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-204]
	strd	r2, [sp, #24]
	vldrw.u32 q0, [q7, #-292]
	ldr	r3, [sp, #80]
	vldrw.u32 q1, [q7, #-276]
	vldrw.u32 q2, [q7, #-260]
	ldr	r2, [sp, #52]
	vldrw.u32 q5, [q7, #-244]
	bic	r8, r8, #-67108864
	vldrw.u32 q3, [q7, #-228]
	vbic q4, q2, q1
	str	r8, [r3, #24]
	veor q4, q4, q0
	ldr	r3, [sp, #68]
	vstrw.u32 q4, [q6, #-188]
	umull	lr, r8, r7, r2
	vbic q4, q5, q2
	veor q4, q4, q1
	lsl	r9, r3, #1
	vstrw.u32 q4, [q6, #-172]
	ldr	r3, [sp, #12]
	vbic q4, q3, q5
	veor q4, q4, q2
	ldr	r2, [sp, #64]
	vstrw.u32 q4, [q6, #-156]
	umlal	lr, r8, r5, r3
	vbic q4, q0, q3
	umull	r3, fp, r7, r3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-140]
	umlal	r3, fp, r5, r2
	vbic q4, q1, q0
	ldr	r4, [sp, #32]
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-124]
	ldr	r2, [sp, #88]
	vldrw.u32 q0, [q7, #-212]
	ldr	r5, [sp, #40]
	vldrw.u32 q1, [q7, #-196]
	umlal	r3, fp, r4, r2
	vldrw.u32 q2, [q7, #-180]
	vldrw.u32 q5, [q7, #-164]
	umlal	lr, r8, r4, r5
	vldrw.u32 q3, [q7, #-148]
	ldr	r4, [sp, #16]
	vbic q4, q2, q1
	veor q4, q4, q0
	ldr	r2, [sp, #8]
	vstrw.u32 q4, [q6, #4]
	umlal	r3, fp, r4, r5
	vbic q4, q5, q2
	ldr	r5, [sp, #36]
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #20]
	umlal	r3, fp, r0, r1
	vbic q4, q3, q5
	umlal	lr, r8, r4, r5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #36]
	ldr	r4, [sp, #72]
	vbic q4, q0, q3
	ldr	r1, [sp, #4]
	veor q4, q4, q5
	umlal	lr, r8, r0, r4
	vstrw.u32 q4, [q6, #52]
	vbic q4, q1, q0
	umlal	r3, fp, r1, r4
	veor q4, q4, q3
	ldr	r4, [sp, #48]
	vstrw.u32 q4, [q6, #68]
	vldrw.u32 q0, [q7, #-132]
	ldr	r0, [sp, #104]
	vldrw.u32 q1, [q7, #-116]
	umlal	lr, r8, r1, r4
	vldrw.u32 q2, [q7, #-100]
	umlal	r3, fp, r6, ip
	vldrw.u32 q5, [q7, #-84]
	vldrw.u32 q3, [q7, #-68]
	umlal	lr, r8, r6, r0
	vbic q4, q2, q1
	umlal	r3, fp, r2, r0
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #84]
	ldr	r6, [sp, #68]
	vbic q4, q5, q2
	ldr	r0, [sp, #100]
	veor q4, q4, q1
	umlal	lr, r8, r2, r6
	vstrw.u32 q4, [q6, #100]
	vbic q4, q3, q5
	ldr	r2, [sp]
	veor q4, q4, q2
	ldr	r6, [sp, #76]
	vstrw.u32 q4, [q6, #116]
	vbic q4, q0, q3
	umlal	r3, fp, r2, r9
	veor q4, q4, q5
	mov	ip, r3
	vstrw.u32 q4, [q6, #132]
	umlal	lr, r8, r2, r0
	vbic q4, q1, q0
	veor q4, q4, q3
	ldr	r2, [sp, #44]
	vstrw.u32 q4, [q6, #148]
	ldr	r5, [sp, #96]
	vldrw.u32 q0, [q7, #-52]
	vldrw.u32 q1, [q7, #-36]
	umlal	ip, fp, r0, r2
	vldrw.u32 q2, [q7, #-20]
	ldrd	r0, [sp, #24]
	vldrw.u32 q5, [q7, #-4]
	vldrw.u32 q3, [q7, #12]
	adds	r4, r6, r0
	vbic q4, q2, q1
	umlal	lr, r8, r2, r5
	veor q4, q4, q0
	mov	r2, r4
	vstrw.u32 q4, [q6, #164]
	vbic q4, q5, q2
	adc	r3, r10, r1
	veor q4, q4, q1
	lsrl	r2, r3, #25
	vstrw.u32 q4, [q6, #180]
	vbic q4, q3, q5
	ldr	r7, [sp, #80]
	veor q4, q4, q2
	adds	ip, ip, r2
	vstrw.u32 q4, [q6, #196]
	bic	r4, r4, #-33554432
	vbic q4, q0, q3
	veor q4, q4, q5
	str	r4, [r7, #28]
	vstrw.u32 q4, [q6, #212]
	mov	r4, ip
	vbic q4, q1, q0
	veor q4, q4, q3
	adc	r5, fp, r3
	vstrw.u32 q4, [q6, #228]
	lsrl	r4, r5, #26
	vldrw.u32 q0, [q7, #28]
	adds	lr, lr, r4
	vldrw.u32 q1, [q7, #44]
	vldrw.u32 q2, [q7, #60]
	mov	r2, lr
	vldrw.u32 q5, [q7, #76]
	bic	r3, ip, #-67108864
	vldrw.u32 q3, [q7, #92]
	vbic q4, q2, q1
	str	r3, [r7, #32]
	veor q4, q4, q0
	adc	r3, r8, r5
	vstrw.u32 q4, [q6, #244]
	lsrl	r2, r3, #25
	vbic q4, q5, q2
	veor q4, q4, q1
	mov	r0, r2
	vstrw.u32 q4, [q6, #260]
	mov	r1, r3
	vbic q4, q3, q5
	veor q4, q4, q2
	lsll	r0, r1, #3
	vstrw.u32 q4, [q6, #276]
	adds	r4, r0, r2
	vbic q4, q0, q3
	adc	r5, r1, r3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #292]
	adds	r4, r4, r4
	vbic q4, q1, q0
	adcs	r5, r5, r5
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #308]
	adds	r4, r4, r2
	vldrw.u32 q0, [q7, #108]
	adc	r5, r5, r3
	vldrw.u32 q1, [q7, #124]
	ldr	r3, [sp, #120]
	vldrw.u32 q2, [q7, #140]
	vldrw.u32 q5, [q7, #156]
	ldr	r1, [sp, #112]
	vldrw.u32 q3, [q7, #172]
	adds	r4, r4, r3
	vbic q4, q2, q1
	veor q4, q4, q0
	mov	r2, r4
	vstrw.u32 q4, [q6, #324]
	adc	r3, r5, #0
	vbic q4, q5, q2
	lsrl	r2, r3, #26
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #340]
	bic	r4, r4, #-67108864
	vbic q4, q3, q5
	str	r4, [r7]
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #356]
	ldr	r4, [sp, #124]
	vbic q4, q0, q3
	bic	r6, lr, #-33554432
	veor q4, q4, q5
	adds	r3, r4, r2
	vstrw.u32 q4, [q6, #372]
	vbic q4, q1, q0
	bic	r2, r3, #-33554432
	veor q4, q4, q3
	add	r1, r1, r3, lsr #25
	vstrw.u32 q4, [q6, #388]
	vmov.i32 q0, #1
	strd	r2, r1, [r7, #4]
	vldrw.u32 q1, [q6, #-508]
	str	r6, [r7, #36]
	veor q1, q1, q0
	vstrw.u32 q1, [q6, #-508]
	ldr r0, [sp, #132]
	subs r0, r0, #1
	str r0, [sp, #132]
	bne 1b
	add sp, sp, #140
	vpop {d8-d15}
	pop {r4-r11, pc}

// expt_m8_seq
.global expt_m8_seq
.type expt_m8_seq, %function
.thumb_func
.balign 16
expt_m8_seq:
	push {r4-r11, lr}
	vpush {d8-d15}
	sub sp, sp, #140
	str r0, [sp, #132]
	movw r1, #:lower16:g_mve
	movt r1, #:upper16:g_mve
	adr r2, 2f
	b 3f
	.balign 16
2:	.word 0, 4, 8, 12
3:
	vldrw.u32 q6, [r2]
	add r3, r1, #1524
	vadd.i32 q7, q6, r3
	add r3, r1, #508
	vadd.i32 q6, q6, r3
.balign 16
1:
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
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
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
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
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
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
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
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
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
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
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
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
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
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
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
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
	vldrw.u32 q0, [q6, #-508]
	vldrw.u32 q1, [q6, #-428]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-348]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-268]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-188]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #188]
	vldrw.u32 q0, [q6, #-492]
	vldrw.u32 q1, [q6, #-412]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-332]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-252]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-172]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #204]
	vldrw.u32 q0, [q6, #-476]
	vldrw.u32 q1, [q6, #-396]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-316]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-236]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-156]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #220]
	vldrw.u32 q0, [q6, #-460]
	vldrw.u32 q1, [q6, #-380]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-300]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-220]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-140]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #236]
	vldrw.u32 q0, [q6, #-444]
	vldrw.u32 q1, [q6, #-364]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-284]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-204]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-124]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #252]
	vldrw.u32 q0, [q6, #4]
	vldrw.u32 q1, [q6, #84]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #164]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #244]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #324]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #268]
	vldrw.u32 q0, [q6, #20]
	vldrw.u32 q1, [q6, #100]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #180]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #260]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #340]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #284]
	vldrw.u32 q0, [q6, #36]
	vldrw.u32 q1, [q6, #116]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #196]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #276]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #356]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #300]
	vldrw.u32 q0, [q6, #52]
	vldrw.u32 q1, [q6, #132]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #212]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #292]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #372]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #316]
	vldrw.u32 q0, [q6, #68]
	vldrw.u32 q1, [q6, #148]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #228]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #308]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #388]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #332]
	vldrw.u32 q0, [q7, #284]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #252]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #348]
	vldrw.u32 q0, [q7, #204]
	vldrw.u32 q2, [q7, #332]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #428]
	vldrw.u32 q0, [q7, #300]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #188]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #364]
	vldrw.u32 q0, [q7, #220]
	vldrw.u32 q2, [q7, #268]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #444]
	vldrw.u32 q0, [q7, #316]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #204]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #380]
	vldrw.u32 q0, [q7, #236]
	vldrw.u32 q2, [q7, #284]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #460]
	vldrw.u32 q0, [q7, #332]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #220]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #396]
	vldrw.u32 q0, [q7, #252]
	vldrw.u32 q2, [q7, #300]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #476]
	vldrw.u32 q0, [q7, #268]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #236]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #412]
	vldrw.u32 q0, [q7, #188]
	vldrw.u32 q2, [q7, #316]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #492]
	vldrw.u32 q3, [q7, #348]
	vldrw.u32 q4, [q7, #428]
	vldrw.u32 q0, [q6, #-508]
	vldrw.u32 q1, [q6, #4]
	veor q0, q0, q3
	veor q1, q1, q4
	vorr q2, q0, q0
	vstrw.u32 q2, [q6, #404]
	vorr q5, q1, q1
	vstrw.u32 q5, [q7, #-212]
	vldrw.u32 q0, [q6, #-428]
	vldrw.u32 q1, [q6, #84]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #18
	vsri.32 q2, q0, #14
	vstrw.u32 q2, [q7, #-356]
	vshl.i32 q5, q1, #18
	vsri.32 q5, q1, #14
	vstrw.u32 q5, [q7, #44]
	vldrw.u32 q0, [q6, #-348]
	vldrw.u32 q1, [q6, #164]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #2
	vsri.32 q2, q1, #30
	vstrw.u32 q2, [q7, #-500]
	vshl.i32 q5, q0, #1
	vsri.32 q5, q0, #31
	vstrw.u32 q5, [q7, #-100]
	vldrw.u32 q0, [q6, #-268]
	vldrw.u32 q1, [q6, #244]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #21
	vsri.32 q2, q1, #11
	vstrw.u32 q2, [q7, #-244]
	vshl.i32 q5, q0, #20
	vsri.32 q5, q0, #12
	vstrw.u32 q5, [q7, #156]
	vldrw.u32 q0, [q6, #-188]
	vldrw.u32 q1, [q6, #324]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #9
	vsri.32 q2, q0, #23
	vstrw.u32 q2, [q7, #-388]
	vshl.i32 q5, q1, #9
	vsri.32 q5, q1, #23
	vstrw.u32 q5, [q7, #12]
	vldrw.u32 q3, [q7, #364]
	vldrw.u32 q4, [q7, #444]
	vldrw.u32 q0, [q6, #-492]
	vldrw.u32 q1, [q6, #20]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #1
	vsri.32 q2, q1, #31
	vstrw.u32 q2, [q7, #-452]
	vorr q5, q0, q0
	vstrw.u32 q5, [q7, #-52]
	vldrw.u32 q0, [q6, #-412]
	vldrw.u32 q1, [q6, #100]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #22
	vsri.32 q2, q0, #10
	vstrw.u32 q2, [q6, #420]
	vshl.i32 q5, q1, #22
	vsri.32 q5, q1, #10
	vstrw.u32 q5, [q7, #-196]
	vldrw.u32 q0, [q6, #-332]
	vldrw.u32 q1, [q6, #180]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #5
	vsri.32 q2, q0, #27
	vstrw.u32 q2, [q7, #-340]
	vshl.i32 q5, q1, #5
	vsri.32 q5, q1, #27
	vstrw.u32 q5, [q7, #60]
	vldrw.u32 q0, [q6, #-252]
	vldrw.u32 q1, [q6, #260]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #23
	vsri.32 q2, q1, #9
	vstrw.u32 q2, [q7, #-484]
	vshl.i32 q5, q0, #22
	vsri.32 q5, q0, #10
	vstrw.u32 q5, [q7, #-84]
	vldrw.u32 q0, [q6, #-172]
	vldrw.u32 q1, [q6, #340]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #1
	vsri.32 q2, q0, #31
	vstrw.u32 q2, [q7, #-228]
	vshl.i32 q5, q1, #1
	vsri.32 q5, q1, #31
	vstrw.u32 q5, [q7, #172]
	vldrw.u32 q3, [q7, #380]
	vldrw.u32 q4, [q7, #460]
	vldrw.u32 q0, [q6, #-476]
	vldrw.u32 q1, [q6, #36]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #31
	vsri.32 q2, q0, #1
	vstrw.u32 q2, [q7, #-292]
	vshl.i32 q5, q1, #31
	vsri.32 q5, q1, #1
	vstrw.u32 q5, [q7, #108]
	vldrw.u32 q0, [q6, #-396]
	vldrw.u32 q1, [q6, #116]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #3
	vsri.32 q2, q0, #29
	vstrw.u32 q2, [q7, #-436]
	vshl.i32 q5, q1, #3
	vsri.32 q5, q1, #29
	vstrw.u32 q5, [q7, #-36]
	vldrw.u32 q0, [q6, #-316]
	vldrw.u32 q1, [q6, #196]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #22
	vsri.32 q2, q1, #10
	vstrw.u32 q2, [q6, #436]
	vshl.i32 q5, q0, #21
	vsri.32 q5, q0, #11
	vstrw.u32 q5, [q7, #-180]
	vldrw.u32 q0, [q6, #-236]
	vldrw.u32 q1, [q6, #276]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #8
	vsri.32 q2, q1, #24
	vstrw.u32 q2, [q7, #-324]
	vshl.i32 q5, q0, #7
	vsri.32 q5, q0, #25
	vstrw.u32 q5, [q7, #76]
	vldrw.u32 q0, [q6, #-156]
	vldrw.u32 q1, [q6, #356]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #31
	vsri.32 q2, q1, #1
	vstrw.u32 q2, [q7, #-468]
	vshl.i32 q5, q0, #30
	vsri.32 q5, q0, #2
	vstrw.u32 q5, [q7, #-68]
	vldrw.u32 q3, [q7, #396]
	vldrw.u32 q4, [q7, #476]
	vldrw.u32 q0, [q6, #-460]
	vldrw.u32 q1, [q6, #52]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #14
	vsri.32 q2, q0, #18
	vstrw.u32 q2, [q6, #484]
	vshl.i32 q5, q1, #14
	vsri.32 q5, q1, #18
	vstrw.u32 q5, [q7, #-132]
	vldrw.u32 q0, [q6, #-380]
	vldrw.u32 q1, [q6, #132]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #28
	vsri.32 q2, q1, #4
	vstrw.u32 q2, [q7, #-276]
	vshl.i32 q5, q0, #27
	vsri.32 q5, q0, #5
	vstrw.u32 q5, [q7, #124]
	vldrw.u32 q0, [q6, #-300]
	vldrw.u32 q1, [q6, #212]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #13
	vsri.32 q2, q1, #19
	vstrw.u32 q2, [q7, #-420]
	vshl.i32 q5, q0, #12
	vsri.32 q5, q0, #20
	vstrw.u32 q5, [q7, #-20]
	vldrw.u32 q0, [q6, #-220]
	vldrw.u32 q1, [q6, #292]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #11
	vsri.32 q2, q1, #21
	vstrw.u32 q2, [q6, #452]
	vshl.i32 q5, q0, #10
	vsri.32 q5, q0, #22
	vstrw.u32 q5, [q7, #-164]
	vldrw.u32 q0, [q6, #-140]
	vldrw.u32 q1, [q6, #372]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #28
	vsri.32 q2, q0, #4
	vstrw.u32 q2, [q7, #-308]
	vshl.i32 q5, q1, #28
	vsri.32 q5, q1, #4
	vstrw.u32 q5, [q7, #92]
	vldrw.u32 q3, [q7, #412]
	vldrw.u32 q4, [q7, #492]
	vldrw.u32 q0, [q6, #-444]
	vldrw.u32 q1, [q6, #68]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #14
	vsri.32 q2, q1, #18
	vstrw.u32 q2, [q7, #-372]
	vshl.i32 q5, q0, #13
	vsri.32 q5, q0, #19
	vstrw.u32 q5, [q7, #28]
	vldrw.u32 q0, [q6, #-364]
	vldrw.u32 q1, [q6, #148]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #10
	vsri.32 q2, q0, #22
	vstrw.u32 q2, [q6, #500]
	vshl.i32 q5, q1, #10
	vsri.32 q5, q1, #22
	vstrw.u32 q5, [q7, #-116]
	vldrw.u32 q0, [q6, #-284]
	vldrw.u32 q1, [q6, #228]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #20
	vsri.32 q2, q1, #12
	vstrw.u32 q2, [q7, #-260]
	vshl.i32 q5, q0, #19
	vsri.32 q5, q0, #13
	vstrw.u32 q5, [q7, #140]
	vldrw.u32 q0, [q6, #-204]
	vldrw.u32 q1, [q6, #308]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #4
	vsri.32 q2, q0, #28
	vstrw.u32 q2, [q7, #-404]
	vshl.i32 q5, q1, #4
	vsri.32 q5, q1, #28
	vstrw.u32 q5, [q7, #-4]
	vldrw.u32 q0, [q6, #-124]
	vldrw.u32 q1, [q6, #388]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #7
	vsri.32 q2, q0, #25
	vstrw.u32 q2, [q6, #468]
	vshl.i32 q5, q1, #7
	vsri.32 q5, q1, #25
	vstrw.u32 q5, [q7, #-148]
	vldrw.u32 q0, [q6, #404]
	vldrw.u32 q1, [q6, #420]
	vldrw.u32 q2, [q6, #436]
	vldrw.u32 q5, [q6, #452]
	vldrw.u32 q3, [q6, #468]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-508]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-492]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-476]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-460]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-444]
	vldrw.u32 q0, [q6, #484]
	vldrw.u32 q1, [q6, #500]
	vldrw.u32 q2, [q7, #-500]
	vldrw.u32 q5, [q7, #-484]
	vldrw.u32 q3, [q7, #-468]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-428]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-412]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-396]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-380]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-364]
	vldrw.u32 q0, [q7, #-452]
	vldrw.u32 q1, [q7, #-436]
	vldrw.u32 q2, [q7, #-420]
	vldrw.u32 q5, [q7, #-404]
	vldrw.u32 q3, [q7, #-388]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-348]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-332]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-316]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-300]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-284]
	vldrw.u32 q0, [q7, #-372]
	vldrw.u32 q1, [q7, #-356]
	vldrw.u32 q2, [q7, #-340]
	vldrw.u32 q5, [q7, #-324]
	vldrw.u32 q3, [q7, #-308]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-268]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-252]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-236]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-220]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-204]
	vldrw.u32 q0, [q7, #-292]
	vldrw.u32 q1, [q7, #-276]
	vldrw.u32 q2, [q7, #-260]
	vldrw.u32 q5, [q7, #-244]
	vldrw.u32 q3, [q7, #-228]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-188]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-172]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-156]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-140]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-124]
	vldrw.u32 q0, [q7, #-212]
	vldrw.u32 q1, [q7, #-196]
	vldrw.u32 q2, [q7, #-180]
	vldrw.u32 q5, [q7, #-164]
	vldrw.u32 q3, [q7, #-148]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #4]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #20]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #36]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #52]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #68]
	vldrw.u32 q0, [q7, #-132]
	vldrw.u32 q1, [q7, #-116]
	vldrw.u32 q2, [q7, #-100]
	vldrw.u32 q5, [q7, #-84]
	vldrw.u32 q3, [q7, #-68]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #84]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #100]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #116]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #132]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #148]
	vldrw.u32 q0, [q7, #-52]
	vldrw.u32 q1, [q7, #-36]
	vldrw.u32 q2, [q7, #-20]
	vldrw.u32 q5, [q7, #-4]
	vldrw.u32 q3, [q7, #12]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #164]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #180]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #196]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #212]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #228]
	vldrw.u32 q0, [q7, #28]
	vldrw.u32 q1, [q7, #44]
	vldrw.u32 q2, [q7, #60]
	vldrw.u32 q5, [q7, #76]
	vldrw.u32 q3, [q7, #92]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #244]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #260]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #276]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #292]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #308]
	vldrw.u32 q0, [q7, #108]
	vldrw.u32 q1, [q7, #124]
	vldrw.u32 q2, [q7, #140]
	vldrw.u32 q5, [q7, #156]
	vldrw.u32 q3, [q7, #172]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #324]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #340]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #356]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #372]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #388]
	vmov.i32 q0, #1
	vldrw.u32 q1, [q6, #-508]
	veor q1, q1, q0
	vstrw.u32 q1, [q6, #-508]
	ldr r0, [sp, #132]
	subs r0, r0, #1
	str r0, [sp, #132]
	bne 1b
	add sp, sp, #140
	vpop {d8-d15}
	pop {r4-r11, pc}

// expt_m8_stitch
.global expt_m8_stitch
.type expt_m8_stitch, %function
.thumb_func
.balign 16
expt_m8_stitch:
	push {r4-r11, lr}
	vpush {d8-d15}
	sub sp, sp, #140
	str r0, [sp, #132]
	movw r1, #:lower16:g_mve
	movt r1, #:upper16:g_mve
	adr r2, 2f
	b 3f
	.balign 16
2:	.word 0, 4, 8, 12
3:
	vldrw.u32 q6, [r2]
	add r3, r1, #1524
	vadd.i32 q7, q6, r3
	add r3, r1, #508
	vadd.i32 q6, q6, r3
.balign 16
1:
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	vldrw.u32 q0, [q6, #-508]
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
	str	r7, [sp, #100]
	ldr	r7, [r1, #32]
	ldr	r6, [r2, #12]
	vldrw.u32 q1, [q6, #-428]
	str	r7, [sp, #76]
	ldr	r7, [lr, #20]
	ldr	r3, [r2, #4]
	mul	r8, ip, r7
	ldr	r4, [r2, #8]
	str	r6, [sp, #36]
	veor q0, q0, q1
	mul	r2, ip, r6
	str	r7, [sp, #48]
	ldr	r6, [r1, #16]
	ldr	r7, [lr, #28]
	str	r6, [sp, #4]
	vldrw.u32 q1, [q6, #-348]
	mov	r6, r7
	ldr	r5, [r1, #36]
	str	r0, [sp, #80]
	str	r5, [sp, #92]
	mov	r5, r4
	ldr	r0, [lr, #16]
	veor q0, q0, q1
	str	r2, [sp, #112]
	ldr	r2, [r1, #24]
	str	r8, [sp, #108]
	str	r2, [sp, #16]
	add	r2, r0, r0, lsl #3
	add	r10, r0, r2, lsl #1
	vldrw.u32 q1, [q6, #-268]
	ldr	r2, [lr, #24]
	mul	r8, ip, r6
	add	r7, r2, r2, lsl #3
	add	fp, r2, r7, lsl #1
	ldr	r7, [r1, #12]
	veor q0, q0, q1
	add	r4, r4, r4, lsl #3
	str	r5, [sp, #40]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #52]
	mul	r5, ip, r3
	str	r0, [sp, #72]
	vldrw.u32 q1, [q6, #-188]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #104]
	str	r6, [sp, #68]
	str	r8, [sp, #84]
	str	r7, [sp, #24]
	veor q0, q0, q1
	ldr	r2, [lr, #36]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #8]
	ldr	r7, [lr]
	vstrw.u32 q0, [q7, #188]
	str	r2, [sp, #96]
	ldr	r2, [r1, #4]
	str	r7, [sp, #12]
	ldr	r7, [sp, #100]
	str	r2, [sp]
	ldr	r2, [r1]
	vldrw.u32 q0, [q6, #-492]
	ldr	r1, [sp, #36]
	str	ip, [sp, #64]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #76]
	vldrw.u32 q1, [q6, #-412]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #32]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #92]
	mov	r6, r3
	umlal	lr, ip, r1, r4
	veor q0, q0, q1
	umull	r4, r1, r4, r7
	umlal	lr, ip, r10, r3
	ldr	r3, [sp, #92]
	ldr	r7, [sp, #8]
	umlal	r4, r1, r3, r5
	vldrw.u32 q1, [q6, #-332]
	mov	r8, r4
	ldr	r4, [sp, #112]
	ldr	r5, [sp, #108]
	umlal	r8, r1, r4, r6
	ldr	r4, [sp, #16]
	mov	r3, r6
	veor q0, q0, q1
	umlal	r8, r1, r10, r4
	umlal	r8, r1, r5, r0
	ldr	r6, [sp, #4]
	ldr	r5, [sp, #84]
	umlal	r8, r1, fp, r6
	ldr	r6, [sp, #24]
	vldrw.u32 q1, [q6, #-252]
	umlal	r8, r1, r5, r6
	ldr	r6, [sp, #32]
	ldr	r5, [sp]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #64]
	veor q0, q0, q1
	umlal	r8, r1, r6, r5
	ldr	r6, [sp, #12]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #48]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	vldrw.u32 q1, [q6, #-172]
	add	r1, r6, r1, lsl #1
	umlal	lr, ip, r1, r4
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	umlal	lr, ip, fp, r0
	str	r8, [sp, #120]
	veor q0, q0, q1
	ldr	r4, [sp, #68]
	ldr	r6, [sp, #4]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r6
	vstrw.u32 q0, [q7, #204]
	ldr	r5, [sp, #32]
	ldr	r6, [sp, #24]
	str	r8, [sp, #116]
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	vldrw.u32 q0, [q6, #-476]
	ldr	r5, [sp, #96]
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	add	r8, r5, r8, lsl #1
	mov	r6, r8
	ldr	r7, [sp, #8]
	vldrw.u32 q1, [q6, #-396]
	ldr	r5, [sp, #12]
	umlal	lr, ip, r8, r7
	ldr	r4, [sp]
	str	r2, [sp, #44]
	umlal	lr, ip, r4, r5
	veor q0, q0, q1
	ldr	r4, [sp, #52]
	ldr	r7, [sp, #76]
	umlal	lr, ip, r4, r2
	lsls	r4, r4, #1
	str	r4, [sp, #88]
	ldr	r4, [sp, #56]
	vldrw.u32 q1, [q6, #-316]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	adc	r9, ip, r2
	bic	ip, r4, #-33554432
	str	ip, [sp, #124]
	umull	r1, ip, r7, r1
	veor q0, q0, q1
	ldr	r5, [sp, #92]
	ldr	r2, [sp, #116]
	umlal	r1, ip, r5, r10
	umlal	r1, ip, fp, r3
	mov	r8, r4
	ldr	r4, [sp, #16]
	vldrw.u32 q1, [q6, #-236]
	str	r6, [sp, #92]
	umlal	r1, ip, r2, r4
	ldr	r2, [sp, #32]
	lsrl	r8, r9, #25
	umlal	r1, ip, r2, r0
	veor q0, q0, q1
	mov	r2, r6
	ldr	r6, [sp, #4]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #12]
	umlal	r1, ip, r6, r2
	vldrw.u32 q1, [q6, #-156]
	ldr	r6, [sp, #52]
	ldr	r2, [sp, #8]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #40]
	ldr	r2, [sp]
	umlal	r1, ip, r2, r6
	veor q0, q0, q1
	mov	lr, r1
	ldr	r6, [sp, #36]
	ldr	r1, [sp, #44]
	umlal	lr, ip, r6, r1
	str	lr, [sp, #56]
	vstrw.u32 q0, [q7, #220]
	umull	lr, r1, r10, r7
	ldr	r6, [sp, #112]
	ldr	r2, [sp, #84]
	umlal	lr, r1, r5, r6
	ldr	r6, [sp, #108]
	umlal	lr, r1, r6, r3
	vldrw.u32 q0, [q6, #-460]
	umlal	lr, r1, fp, r4
	umlal	lr, r1, r2, r0
	ldr	r6, [sp, #4]
	ldr	r2, [sp, #32]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #24]
	vldrw.u32 q1, [q6, #-380]
	ldr	r2, [sp, #64]
	umlal	lr, r1, r2, r6
	ldrd	r7, r2, [sp, #8]
	umlal	lr, r1, r7, r2
	ldr	r2, [sp, #88]
	veor q0, q0, q1
	ldr	r7, [sp]
	umlal	lr, r1, r7, r2
	ldrd	r7, r2, [sp, #40]
	umlal	lr, r1, r7, r2
	adds	lr, lr, r8
	adc	r2, r1, r9
	vldrw.u32 q1, [q6, #-300]
	str	lr, [sp, #16]
	str	r2, [sp, #20]
	ldrd	r8, [sp, #16]
	lsrl	r8, r9, #26
	ldr	r7, [sp, #76]
	ldr	r2, [sp, #116]
	veor q0, q0, q1
	bic	lr, lr, #-67108864
	str	lr, [sp, #112]
	umull	r10, lr, r7, r2
	umlal	r10, lr, r5, fp
	ldr	r2, [sp, #32]
	str	r4, [sp, #16]
	vldrw.u32 q1, [q6, #-220]
	umlal	r10, lr, r2, r3
	ldr	r2, [sp, #92]
	str	r0, [sp, #76]
	umlal	r10, lr, r2, r4
	ldr	r2, [sp, #12]
	veor q0, q0, q1
	ldr	r4, [sp, #4]
	umlal	r10, lr, r0, r2
	ldr	r2, [sp, #52]
	ldr	r0, [sp, #56]
	umlal	r10, lr, r4, r2
	ldr	r4, [sp, #40]
	vldrw.u32 q1, [q6, #-140]
	ldr	r1, [sp, #36]
	umlal	r10, lr, r6, r4
	ldr	r4, [sp, #36]
	ldr	r6, [sp, #8]
	ldr	r2, [sp]
	umlal	r10, lr, r6, r4
	veor q0, q0, q1
	mov	r4, r8
	adds	r4, r0, r4
	adc	r0, ip, r9
	str	r0, [sp, #60]
	ldr	r0, [sp, #72]
	vstrw.u32 q0, [q7, #236]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r0
	ldrd	r8, [sp, #56]
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	str	r4, [r2, #12]
	vldrw.u32 q0, [q6, #-444]
	umull	r4, ip, fp, r7
	ldrd	r2, r6, [sp, #44]
	ldr	r0, [sp, #108]
	lsrl	r8, r9, #25
	umlal	r4, ip, r5, r0
	ldr	r0, [sp, #84]
	vldrw.u32 q1, [q6, #-364]
	umlal	r10, lr, r6, r2
	umlal	r4, ip, r0, r3
	ldr	r2, [sp, #32]
	ldr	r0, [sp, #16]
	ldr	r6, [sp, #64]
	veor q0, q0, q1
	umlal	r4, ip, r2, r0
	ldr	r0, [sp, #76]
	ldr	r2, [sp, #12]
	umlal	r4, ip, r6, r0
	ldr	r6, [sp, #4]
	lsls	r1, r1, #1
	vldrw.u32 q1, [q6, #-284]
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #88]
	str	r10, [sp, #116]
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #8]
	veor q0, q0, q1
	ldr	r2, [sp, #40]
	umlal	r4, ip, r6, r2
	ldr	r2, [sp]
	ldr	r6, [sp, #72]
	umlal	r4, ip, r2, r1
	vldrw.u32 q1, [q6, #-204]
	ldr	r2, [sp, #44]
	umlal	r4, ip, r6, r2
	adds	r8, r4, r8
	adc	ip, ip, r9
	str	r8, [sp, #56]
	str	ip, [sp, #60]
	veor q0, q0, q1
	ldrd	r10, [sp, #56]
	lsrl	r10, fp, #26
	ldr	r2, [sp, #80]
	bic	r8, r8, #-67108864
	strd	r10, [sp, #56]
	str	r8, [r2, #16]
	vldrw.u32 q1, [q6, #-124]
	ldr	r4, [sp, #48]
	ldr	r2, [sp, #12]
	lsl	ip, r4, #1
	ldr	r4, [sp, #92]
	ldr	r6, [sp, #4]
	umull	fp, r10, r7, r4
	veor q0, q0, q1
	ldrd	r8, [sp, #56]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r5, r4
	umlal	fp, r10, r3, r2
	ldr	r4, [sp, #16]
	vstrw.u32 q0, [q7, #252]
	ldr	r2, [sp, #52]
	umlal	fp, r10, r4, r2
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	fp, r10, r0, r4
	ldr	r4, [sp, #36]
	vldrw.u32 q0, [q6, #4]
	umlal	fp, r10, r6, r4
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #72]
	umlal	fp, r10, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #116]
	vldrw.u32 q1, [q6, #84]
	adds	r4, r6, r4
	ldr	r6, [sp, #48]
	str	r4, [sp, #56]
	umlal	fp, r10, r2, r6
	ldr	r2, [sp, #80]
	veor q0, q0, q1
	bic	r4, r4, #-33554432
	ldr	r6, [sp, #104]
	str	r4, [r2, #20]
	ldr	r2, [sp]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r2, r6
	vldrw.u32 q1, [q6, #164]
	adc	lr, lr, r9
	ldr	r6, [sp, #68]
	ldr	r2, [sp, #44]
	str	lr, [sp, #60]
	umull	r4, lr, r4, r7
	ldrd	r8, [sp, #56]
	veor q0, q0, q1
	umlal	fp, r10, r6, r2
	ldr	r2, [sp, #84]
	lsrl	r8, r9, #25
	umlal	r4, lr, r5, r2
	ldr	r2, [sp, #64]
	vldrw.u32 q1, [q6, #244]
	str	r3, [sp, #32]
	umlal	r4, lr, r2, r3
	ldrd	r2, r3, [sp, #12]
	umlal	r4, lr, r3, r2
	str	fp, [sp, #76]
	ldr	r3, [sp, #88]
	veor q0, q0, q1
	ldr	r6, [sp, #4]
	umlal	r4, lr, r0, r3
	ldr	r3, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	r4, lr, r6, r3
	ldr	r6, [sp, #24]
	vldrw.u32 q1, [q6, #324]
	ldr	r3, [sp, #72]
	umlal	r4, lr, r6, r1
	umlal	r4, lr, r2, r3
	ldr	r3, [sp]
	ldr	r2, [sp, #44]
	umlal	r4, lr, r3, ip
	veor q0, q0, q1
	ldr	r3, [sp, #104]
	strd	r8, [sp, #56]
	umlal	r4, lr, r3, r2
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	vstrw.u32 q0, [q7, #268]
	str	r8, [sp, #24]
	adc	r4, lr, r4
	str	r4, [sp, #28]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	vldrw.u32 q0, [q6, #20]
	ldr	r3, [sp, #80]
	ldr	r2, [sp, #52]
	bic	r8, r8, #-67108864
	str	r8, [r3, #24]
	ldr	r3, [sp, #68]
	umull	lr, r8, r7, r2
	vldrw.u32 q1, [q6, #100]
	lsl	r9, r3, #1
	ldr	r3, [sp, #12]
	ldr	r2, [sp, #64]
	umlal	lr, r8, r5, r3
	umull	r3, fp, r7, r3
	veor q0, q0, q1
	umlal	r3, fp, r5, r2
	ldr	r4, [sp, #32]
	ldr	r2, [sp, #88]
	ldr	r5, [sp, #40]
	umlal	r3, fp, r4, r2
	umlal	lr, r8, r4, r5
	vldrw.u32 q1, [q6, #180]
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #8]
	umlal	r3, fp, r4, r5
	ldr	r5, [sp, #36]
	umlal	r3, fp, r0, r1
	umlal	lr, r8, r4, r5
	veor q0, q0, q1
	ldr	r4, [sp, #72]
	ldr	r1, [sp, #4]
	umlal	lr, r8, r0, r4
	umlal	r3, fp, r1, r4
	ldr	r4, [sp, #48]
	vldrw.u32 q1, [q6, #260]
	ldr	r0, [sp, #104]
	umlal	lr, r8, r1, r4
	umlal	r3, fp, r6, ip
	umlal	lr, r8, r6, r0
	umlal	r3, fp, r2, r0
	ldr	r6, [sp, #68]
	veor q0, q0, q1
	ldr	r0, [sp, #100]
	umlal	lr, r8, r2, r6
	ldr	r2, [sp]
	ldr	r6, [sp, #76]
	umlal	r3, fp, r2, r9
	mov	ip, r3
	vldrw.u32 q1, [q6, #340]
	umlal	lr, r8, r2, r0
	ldr	r2, [sp, #44]
	ldr	r5, [sp, #96]
	umlal	ip, fp, r0, r2
	ldrd	r0, [sp, #24]
	veor q0, q0, q1
	adds	r4, r6, r0
	umlal	lr, r8, r2, r5
	mov	r2, r4
	adc	r3, r10, r1
	lsrl	r2, r3, #25
	ldr	r7, [sp, #80]
	vstrw.u32 q0, [q7, #284]
	adds	ip, ip, r2
	bic	r4, r4, #-33554432
	str	r4, [r7, #28]
	mov	r4, ip
	adc	r5, fp, r3
	lsrl	r4, r5, #26
	vldrw.u32 q0, [q6, #36]
	adds	lr, lr, r4
	mov	r2, lr
	bic	r3, ip, #-67108864
	str	r3, [r7, #32]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	vldrw.u32 q1, [q6, #116]
	mov	r0, r2
	mov	r1, r3
	lsll	r0, r1, #3
	adds	r4, r0, r2
	adc	r5, r1, r3
	veor q0, q0, q1
	adds	r4, r4, r4
	adcs	r5, r5, r5
	adds	r4, r4, r2
	adc	r5, r5, r3
	ldr	r3, [sp, #120]
	ldr	r1, [sp, #112]
	vldrw.u32 q1, [q6, #196]
	adds	r4, r4, r3
	mov	r2, r4
	adc	r3, r5, #0
	lsrl	r2, r3, #26
	bic	r4, r4, #-67108864
	str	r4, [r7]
	veor q0, q0, q1
	ldr	r4, [sp, #124]
	bic	r6, lr, #-33554432
	adds	r3, r4, r2
	bic	r2, r3, #-33554432
	add	r1, r1, r3, lsr #25
	vldrw.u32 q1, [q6, #276]
	strd	r2, r1, [r7, #4]
	str	r6, [r7, #36]
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	veor q0, q0, q1
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
	str	r7, [sp, #100]
	vldrw.u32 q1, [q6, #356]
	ldr	r7, [r1, #32]
	ldr	r6, [r2, #12]
	str	r7, [sp, #76]
	ldr	r7, [lr, #20]
	ldr	r3, [r2, #4]
	veor q0, q0, q1
	mul	r8, ip, r7
	ldr	r4, [r2, #8]
	str	r6, [sp, #36]
	mul	r2, ip, r6
	str	r7, [sp, #48]
	ldr	r6, [r1, #16]
	vstrw.u32 q0, [q7, #300]
	ldr	r7, [lr, #28]
	str	r6, [sp, #4]
	mov	r6, r7
	ldr	r5, [r1, #36]
	str	r0, [sp, #80]
	str	r5, [sp, #92]
	vldrw.u32 q0, [q6, #52]
	mov	r5, r4
	ldr	r0, [lr, #16]
	str	r2, [sp, #112]
	ldr	r2, [r1, #24]
	str	r8, [sp, #108]
	str	r2, [sp, #16]
	vldrw.u32 q1, [q6, #132]
	add	r2, r0, r0, lsl #3
	add	r10, r0, r2, lsl #1
	ldr	r2, [lr, #24]
	mul	r8, ip, r6
	add	r7, r2, r2, lsl #3
	veor q0, q0, q1
	add	fp, r2, r7, lsl #1
	ldr	r7, [r1, #12]
	add	r4, r4, r4, lsl #3
	str	r5, [sp, #40]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #52]
	vldrw.u32 q1, [q6, #212]
	mul	r5, ip, r3
	str	r0, [sp, #72]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #104]
	str	r6, [sp, #68]
	veor q0, q0, q1
	str	r8, [sp, #84]
	str	r7, [sp, #24]
	ldr	r2, [lr, #36]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	vldrw.u32 q1, [q6, #292]
	str	r7, [sp, #8]
	ldr	r7, [lr]
	str	r2, [sp, #96]
	ldr	r2, [r1, #4]
	str	r7, [sp, #12]
	ldr	r7, [sp, #100]
	veor q0, q0, q1
	str	r2, [sp]
	ldr	r2, [r1]
	ldr	r1, [sp, #36]
	str	ip, [sp, #64]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	vldrw.u32 q1, [q6, #372]
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #76]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #32]
	umull	lr, ip, lr, r7
	veor q0, q0, q1
	ldr	r1, [sp, #92]
	mov	r6, r3
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	umlal	lr, ip, r10, r3
	ldr	r3, [sp, #92]
	vstrw.u32 q0, [q7, #316]
	ldr	r7, [sp, #8]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r4, [sp, #112]
	ldr	r5, [sp, #108]
	umlal	r8, r1, r4, r6
	vldrw.u32 q0, [q6, #68]
	ldr	r4, [sp, #16]
	mov	r3, r6
	umlal	r8, r1, r10, r4
	umlal	r8, r1, r5, r0
	ldr	r6, [sp, #4]
	vldrw.u32 q1, [q6, #148]
	ldr	r5, [sp, #84]
	umlal	r8, r1, fp, r6
	ldr	r6, [sp, #24]
	umlal	r8, r1, r5, r6
	ldr	r6, [sp, #32]
	ldr	r5, [sp]
	veor q0, q0, q1
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #64]
	umlal	r8, r1, r6, r5
	ldr	r6, [sp, #12]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #48]
	vldrw.u32 q1, [q6, #228]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	umlal	lr, ip, r1, r4
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	veor q0, q0, q1
	umlal	lr, ip, fp, r0
	str	r8, [sp, #120]
	ldr	r4, [sp, #68]
	ldr	r6, [sp, #4]
	add	r8, r4, r4, lsl #3
	vldrw.u32 q1, [q6, #308]
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r6
	ldr	r5, [sp, #32]
	ldr	r6, [sp, #24]
	str	r8, [sp, #116]
	umlal	lr, ip, r5, r6
	veor q0, q0, q1
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	ldr	r5, [sp, #96]
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	add	r8, r5, r8, lsl #1
	vldrw.u32 q1, [q6, #388]
	mov	r6, r8
	ldr	r7, [sp, #8]
	ldr	r5, [sp, #12]
	umlal	lr, ip, r8, r7
	ldr	r4, [sp]
	veor q0, q0, q1
	str	r2, [sp, #44]
	umlal	lr, ip, r4, r5
	ldr	r4, [sp, #52]
	ldr	r7, [sp, #76]
	umlal	lr, ip, r4, r2
	lsls	r4, r4, #1
	vstrw.u32 q0, [q7, #332]
	str	r4, [sp, #88]
	ldr	r4, [sp, #56]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	adc	r9, ip, r2
	bic	ip, r4, #-33554432
	vldrw.u32 q0, [q7, #284]
	str	ip, [sp, #124]
	umull	r1, ip, r7, r1
	ldr	r5, [sp, #92]
	ldr	r2, [sp, #116]
	umlal	r1, ip, r5, r10
	vshl.i32 q1, q0, #1
	umlal	r1, ip, fp, r3
	mov	r8, r4
	ldr	r4, [sp, #16]
	str	r6, [sp, #92]
	umlal	r1, ip, r2, r4
	ldr	r2, [sp, #32]
	vsri.32 q1, q0, #31
	lsrl	r8, r9, #25
	umlal	r1, ip, r2, r0
	mov	r2, r6
	ldr	r6, [sp, #4]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #24]
	vldrw.u32 q2, [q7, #252]
	ldr	r2, [sp, #12]
	umlal	r1, ip, r6, r2
	ldr	r6, [sp, #52]
	ldr	r2, [sp, #8]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #40]
	veor q1, q1, q2
	ldr	r2, [sp]
	umlal	r1, ip, r2, r6
	mov	lr, r1
	ldr	r6, [sp, #36]
	ldr	r1, [sp, #44]
	vstrw.u32 q1, [q7, #348]
	umlal	lr, ip, r6, r1
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	ldr	r6, [sp, #112]
	ldr	r2, [sp, #84]
	umlal	lr, r1, r5, r6
	vldrw.u32 q0, [q7, #204]
	ldr	r6, [sp, #108]
	umlal	lr, r1, r6, r3
	umlal	lr, r1, fp, r4
	umlal	lr, r1, r2, r0
	ldr	r6, [sp, #4]
	ldr	r2, [sp, #32]
	vldrw.u32 q2, [q7, #332]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #64]
	umlal	lr, r1, r2, r6
	ldrd	r7, r2, [sp, #8]
	veor q0, q0, q2
	umlal	lr, r1, r7, r2
	ldr	r2, [sp, #88]
	ldr	r7, [sp]
	umlal	lr, r1, r7, r2
	ldrd	r7, r2, [sp, #40]
	umlal	lr, r1, r7, r2
	vstrw.u32 q0, [q7, #428]
	adds	lr, lr, r8
	adc	r2, r1, r9
	str	lr, [sp, #16]
	str	r2, [sp, #20]
	ldrd	r8, [sp, #16]
	lsrl	r8, r9, #26
	vldrw.u32 q0, [q7, #300]
	ldr	r7, [sp, #76]
	ldr	r2, [sp, #116]
	bic	lr, lr, #-67108864
	str	lr, [sp, #112]
	umull	r10, lr, r7, r2
	vshl.i32 q1, q0, #1
	umlal	r10, lr, r5, fp
	ldr	r2, [sp, #32]
	str	r4, [sp, #16]
	umlal	r10, lr, r2, r3
	ldr	r2, [sp, #92]
	str	r0, [sp, #76]
	vsri.32 q1, q0, #31
	umlal	r10, lr, r2, r4
	ldr	r2, [sp, #12]
	ldr	r4, [sp, #4]
	umlal	r10, lr, r0, r2
	ldr	r2, [sp, #52]
	ldr	r0, [sp, #56]
	vldrw.u32 q2, [q7, #188]
	umlal	r10, lr, r4, r2
	ldr	r4, [sp, #40]
	ldr	r1, [sp, #36]
	umlal	r10, lr, r6, r4
	ldr	r4, [sp, #36]
	veor q1, q1, q2
	ldr	r6, [sp, #8]
	ldr	r2, [sp]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	adds	r4, r0, r4
	adc	r0, ip, r9
	vstrw.u32 q1, [q7, #364]
	str	r0, [sp, #60]
	ldr	r0, [sp, #72]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r0
	ldrd	r8, [sp, #56]
	ldr	r2, [sp, #80]
	vldrw.u32 q0, [q7, #220]
	bic	r4, r4, #-33554432
	str	r4, [r2, #12]
	umull	r4, ip, fp, r7
	ldrd	r2, r6, [sp, #44]
	ldr	r0, [sp, #108]
	lsrl	r8, r9, #25
	vldrw.u32 q2, [q7, #268]
	umlal	r4, ip, r5, r0
	ldr	r0, [sp, #84]
	umlal	r10, lr, r6, r2
	umlal	r4, ip, r0, r3
	ldr	r2, [sp, #32]
	veor q0, q0, q2
	ldr	r0, [sp, #16]
	ldr	r6, [sp, #64]
	umlal	r4, ip, r2, r0
	ldr	r0, [sp, #76]
	ldr	r2, [sp, #12]
	umlal	r4, ip, r6, r0
	vstrw.u32 q0, [q7, #444]
	ldr	r6, [sp, #4]
	lsls	r1, r1, #1
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #88]
	str	r10, [sp, #116]
	vldrw.u32 q0, [q7, #316]
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #8]
	ldr	r2, [sp, #40]
	umlal	r4, ip, r6, r2
	ldr	r2, [sp]
	vshl.i32 q1, q0, #1
	ldr	r6, [sp, #72]
	umlal	r4, ip, r2, r1
	ldr	r2, [sp, #44]
	umlal	r4, ip, r6, r2
	adds	r8, r4, r8
	adc	ip, ip, r9
	vsri.32 q1, q0, #31
	str	r8, [sp, #56]
	str	ip, [sp, #60]
	ldrd	r10, [sp, #56]
	lsrl	r10, fp, #26
	ldr	r2, [sp, #80]
	bic	r8, r8, #-67108864
	vldrw.u32 q2, [q7, #204]
	strd	r10, [sp, #56]
	str	r8, [r2, #16]
	ldr	r4, [sp, #48]
	ldr	r2, [sp, #12]
	lsl	ip, r4, #1
	veor q1, q1, q2
	ldr	r4, [sp, #92]
	ldr	r6, [sp, #4]
	umull	fp, r10, r7, r4
	ldrd	r8, [sp, #56]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r5, r4
	vstrw.u32 q1, [q7, #380]
	umlal	fp, r10, r3, r2
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #52]
	umlal	fp, r10, r4, r2
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #8]
	vldrw.u32 q0, [q7, #236]
	umlal	fp, r10, r0, r4
	ldr	r4, [sp, #36]
	umlal	fp, r10, r6, r4
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #72]
	umlal	fp, r10, r6, r4
	vldrw.u32 q2, [q7, #284]
	mov	r4, r8
	ldr	r6, [sp, #116]
	adds	r4, r6, r4
	ldr	r6, [sp, #48]
	str	r4, [sp, #56]
	veor q0, q0, q2
	umlal	fp, r10, r2, r6
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	ldr	r6, [sp, #104]
	str	r4, [r2, #20]
	ldr	r2, [sp]
	vstrw.u32 q0, [q7, #460]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r2, r6
	adc	lr, lr, r9
	ldr	r6, [sp, #68]
	ldr	r2, [sp, #44]
	str	lr, [sp, #60]
	vldrw.u32 q0, [q7, #332]
	umull	r4, lr, r4, r7
	ldrd	r8, [sp, #56]
	umlal	fp, r10, r6, r2
	ldr	r2, [sp, #84]
	lsrl	r8, r9, #25
	vshl.i32 q1, q0, #1
	umlal	r4, lr, r5, r2
	ldr	r2, [sp, #64]
	str	r3, [sp, #32]
	umlal	r4, lr, r2, r3
	ldrd	r2, r3, [sp, #12]
	umlal	r4, lr, r3, r2
	vsri.32 q1, q0, #31
	str	fp, [sp, #76]
	ldr	r3, [sp, #88]
	ldr	r6, [sp, #4]
	umlal	r4, lr, r0, r3
	ldr	r3, [sp, #40]
	ldr	r2, [sp, #8]
	vldrw.u32 q2, [q7, #220]
	umlal	r4, lr, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #72]
	umlal	r4, lr, r6, r1
	umlal	r4, lr, r2, r3
	veor q1, q1, q2
	ldr	r3, [sp]
	ldr	r2, [sp, #44]
	umlal	r4, lr, r3, ip
	ldr	r3, [sp, #104]
	strd	r8, [sp, #56]
	umlal	r4, lr, r3, r2
	vstrw.u32 q1, [q7, #396]
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, lr, r4
	str	r4, [sp, #28]
	ldrd	r2, [sp, #24]
	vldrw.u32 q0, [q7, #252]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #80]
	ldr	r2, [sp, #52]
	bic	r8, r8, #-67108864
	vldrw.u32 q2, [q7, #300]
	str	r8, [r3, #24]
	ldr	r3, [sp, #68]
	umull	lr, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #12]
	ldr	r2, [sp, #64]
	veor q0, q0, q2
	umlal	lr, r8, r5, r3
	umull	r3, fp, r7, r3
	umlal	r3, fp, r5, r2
	ldr	r4, [sp, #32]
	ldr	r2, [sp, #88]
	ldr	r5, [sp, #40]
	vstrw.u32 q0, [q7, #476]
	umlal	r3, fp, r4, r2
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #8]
	umlal	r3, fp, r4, r5
	ldr	r5, [sp, #36]
	vldrw.u32 q0, [q7, #268]
	umlal	r3, fp, r0, r1
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #72]
	ldr	r1, [sp, #4]
	umlal	lr, r8, r0, r4
	vshl.i32 q1, q0, #1
	umlal	r3, fp, r1, r4
	ldr	r4, [sp, #48]
	ldr	r0, [sp, #104]
	umlal	lr, r8, r1, r4
	umlal	r3, fp, r6, ip
	umlal	lr, r8, r6, r0
	vsri.32 q1, q0, #31
	umlal	r3, fp, r2, r0
	ldr	r6, [sp, #68]
	ldr	r0, [sp, #100]
	umlal	lr, r8, r2, r6
	ldr	r2, [sp]
	ldr	r6, [sp, #76]
	vldrw.u32 q2, [q7, #236]
	umlal	r3, fp, r2, r9
	mov	ip, r3
	umlal	lr, r8, r2, r0
	ldr	r2, [sp, #44]
	ldr	r5, [sp, #96]
	veor q1, q1, q2
	umlal	ip, fp, r0, r2
	ldrd	r0, [sp, #24]
	adds	r4, r6, r0
	umlal	lr, r8, r2, r5
	mov	r2, r4
	adc	r3, r10, r1
	vstrw.u32 q1, [q7, #412]
	lsrl	r2, r3, #25
	ldr	r7, [sp, #80]
	adds	ip, ip, r2
	bic	r4, r4, #-33554432
	str	r4, [r7, #28]
	mov	r4, ip
	vldrw.u32 q0, [q7, #188]
	adc	r5, fp, r3
	lsrl	r4, r5, #26
	adds	lr, lr, r4
	mov	r2, lr
	bic	r3, ip, #-67108864
	vldrw.u32 q2, [q7, #316]
	str	r3, [r7, #32]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r0, r2
	mov	r1, r3
	lsll	r0, r1, #3
	veor q0, q0, q2
	adds	r4, r0, r2
	adc	r5, r1, r3
	adds	r4, r4, r4
	adcs	r5, r5, r5
	adds	r4, r4, r2
	adc	r5, r5, r3
	vstrw.u32 q0, [q7, #492]
	ldr	r3, [sp, #120]
	ldr	r1, [sp, #112]
	adds	r4, r4, r3
	mov	r2, r4
	adc	r3, r5, #0
	lsrl	r2, r3, #26
	vldrw.u32 q3, [q7, #348]
	bic	r4, r4, #-67108864
	str	r4, [r7]
	ldr	r4, [sp, #124]
	bic	r6, lr, #-33554432
	adds	r3, r4, r2
	vldrw.u32 q4, [q7, #428]
	bic	r2, r3, #-33554432
	add	r1, r1, r3, lsr #25
	strd	r2, r1, [r7, #4]
	str	r6, [r7, #36]
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	vldrw.u32 q0, [q6, #-508]
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	vldrw.u32 q1, [q6, #4]
	ldr	r7, [r2, #32]
	str	r7, [sp, #100]
	ldr	r7, [r1, #32]
	ldr	r6, [r2, #12]
	str	r7, [sp, #76]
	veor q0, q0, q3
	ldr	r7, [lr, #20]
	ldr	r3, [r2, #4]
	mul	r8, ip, r7
	ldr	r4, [r2, #8]
	str	r6, [sp, #36]
	mul	r2, ip, r6
	veor q1, q1, q4
	str	r7, [sp, #48]
	ldr	r6, [r1, #16]
	ldr	r7, [lr, #28]
	str	r6, [sp, #4]
	mov	r6, r7
	ldr	r5, [r1, #36]
	vorr q2, q0, q0
	str	r0, [sp, #80]
	str	r5, [sp, #92]
	mov	r5, r4
	ldr	r0, [lr, #16]
	str	r2, [sp, #112]
	vstrw.u32 q2, [q6, #404]
	ldr	r2, [r1, #24]
	str	r8, [sp, #108]
	str	r2, [sp, #16]
	add	r2, r0, r0, lsl #3
	add	r10, r0, r2, lsl #1
	ldr	r2, [lr, #24]
	vorr q5, q1, q1
	mul	r8, ip, r6
	add	r7, r2, r2, lsl #3
	add	fp, r2, r7, lsl #1
	ldr	r7, [r1, #12]
	add	r4, r4, r4, lsl #3
	str	r5, [sp, #40]
	vstrw.u32 q5, [q7, #-212]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #52]
	mul	r5, ip, r3
	str	r0, [sp, #72]
	ldr	r3, [r1, #28]
	vldrw.u32 q0, [q6, #-428]
	ldr	r0, [r1, #20]
	str	r2, [sp, #104]
	str	r6, [sp, #68]
	str	r8, [sp, #84]
	str	r7, [sp, #24]
	ldr	r2, [lr, #36]
	vldrw.u32 q1, [q6, #84]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #8]
	ldr	r7, [lr]
	str	r2, [sp, #96]
	ldr	r2, [r1, #4]
	veor q0, q0, q3
	str	r7, [sp, #12]
	ldr	r7, [sp, #100]
	str	r2, [sp]
	ldr	r2, [r1]
	ldr	r1, [sp, #36]
	str	ip, [sp, #64]
	veor q1, q1, q4
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #76]
	add	lr, r1, lr, lsl #1
	vshl.i32 q2, q0, #18
	str	ip, [sp, #32]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #92]
	mov	r6, r3
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	vsri.32 q2, q0, #14
	umlal	lr, ip, r10, r3
	ldr	r3, [sp, #92]
	ldr	r7, [sp, #8]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r4, [sp, #112]
	vstrw.u32 q2, [q7, #-356]
	ldr	r5, [sp, #108]
	umlal	r8, r1, r4, r6
	ldr	r4, [sp, #16]
	mov	r3, r6
	umlal	r8, r1, r10, r4
	vshl.i32 q5, q1, #18
	umlal	r8, r1, r5, r0
	ldr	r6, [sp, #4]
	ldr	r5, [sp, #84]
	umlal	r8, r1, fp, r6
	ldr	r6, [sp, #24]
	umlal	r8, r1, r5, r6
	vsri.32 q5, q1, #14
	ldr	r6, [sp, #32]
	ldr	r5, [sp]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #64]
	umlal	r8, r1, r6, r5
	ldr	r6, [sp, #12]
	vstrw.u32 q5, [q7, #44]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #48]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	vldrw.u32 q0, [q6, #-348]
	umlal	lr, ip, r1, r4
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	umlal	lr, ip, fp, r0
	str	r8, [sp, #120]
	ldr	r4, [sp, #68]
	vldrw.u32 q1, [q6, #164]
	ldr	r6, [sp, #4]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r6
	ldr	r5, [sp, #32]
	ldr	r6, [sp, #24]
	veor q0, q0, q3
	str	r8, [sp, #116]
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	ldr	r5, [sp, #96]
	strd	r6, [sp, #56]
	veor q1, q1, q4
	add	r8, r5, r5, lsl #3
	add	r8, r5, r8, lsl #1
	mov	r6, r8
	ldr	r7, [sp, #8]
	ldr	r5, [sp, #12]
	vshl.i32 q2, q1, #2
	umlal	lr, ip, r8, r7
	ldr	r4, [sp]
	str	r2, [sp, #44]
	umlal	lr, ip, r4, r5
	ldr	r4, [sp, #52]
	ldr	r7, [sp, #76]
	vsri.32 q2, q1, #30
	umlal	lr, ip, r4, r2
	lsls	r4, r4, #1
	str	r4, [sp, #88]
	ldr	r4, [sp, #56]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	vstrw.u32 q2, [q7, #-500]
	adc	r9, ip, r2
	bic	ip, r4, #-33554432
	str	ip, [sp, #124]
	umull	r1, ip, r7, r1
	ldr	r5, [sp, #92]
	vshl.i32 q5, q0, #1
	ldr	r2, [sp, #116]
	umlal	r1, ip, r5, r10
	umlal	r1, ip, fp, r3
	mov	r8, r4
	ldr	r4, [sp, #16]
	str	r6, [sp, #92]
	vsri.32 q5, q0, #31
	umlal	r1, ip, r2, r4
	ldr	r2, [sp, #32]
	lsrl	r8, r9, #25
	umlal	r1, ip, r2, r0
	mov	r2, r6
	ldr	r6, [sp, #4]
	vstrw.u32 q5, [q7, #-100]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #12]
	umlal	r1, ip, r6, r2
	ldr	r6, [sp, #52]
	vldrw.u32 q0, [q6, #-268]
	ldr	r2, [sp, #8]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #40]
	ldr	r2, [sp]
	umlal	r1, ip, r2, r6
	mov	lr, r1
	vldrw.u32 q1, [q6, #244]
	ldr	r6, [sp, #36]
	ldr	r1, [sp, #44]
	umlal	lr, ip, r6, r1
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	ldr	r6, [sp, #112]
	veor q0, q0, q3
	ldr	r2, [sp, #84]
	umlal	lr, r1, r5, r6
	ldr	r6, [sp, #108]
	umlal	lr, r1, r6, r3
	umlal	lr, r1, fp, r4
	veor q1, q1, q4
	umlal	lr, r1, r2, r0
	ldr	r6, [sp, #4]
	ldr	r2, [sp, #32]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #64]
	vshl.i32 q2, q1, #21
	umlal	lr, r1, r2, r6
	ldrd	r7, r2, [sp, #8]
	umlal	lr, r1, r7, r2
	ldr	r2, [sp, #88]
	ldr	r7, [sp]
	umlal	lr, r1, r7, r2
	vsri.32 q2, q1, #11
	ldrd	r7, r2, [sp, #40]
	umlal	lr, r1, r7, r2
	adds	lr, lr, r8
	adc	r2, r1, r9
	str	lr, [sp, #16]
	str	r2, [sp, #20]
	vstrw.u32 q2, [q7, #-244]
	ldrd	r8, [sp, #16]
	lsrl	r8, r9, #26
	ldr	r7, [sp, #76]
	ldr	r2, [sp, #116]
	bic	lr, lr, #-67108864
	vshl.i32 q5, q0, #20
	str	lr, [sp, #112]
	umull	r10, lr, r7, r2
	umlal	r10, lr, r5, fp
	ldr	r2, [sp, #32]
	str	r4, [sp, #16]
	umlal	r10, lr, r2, r3
	vsri.32 q5, q0, #12
	ldr	r2, [sp, #92]
	str	r0, [sp, #76]
	umlal	r10, lr, r2, r4
	ldr	r2, [sp, #12]
	ldr	r4, [sp, #4]
	umlal	r10, lr, r0, r2
	vstrw.u32 q5, [q7, #156]
	ldr	r2, [sp, #52]
	ldr	r0, [sp, #56]
	umlal	r10, lr, r4, r2
	ldr	r4, [sp, #40]
	ldr	r1, [sp, #36]
	vldrw.u32 q0, [q6, #-188]
	umlal	r10, lr, r6, r4
	ldr	r4, [sp, #36]
	ldr	r6, [sp, #8]
	ldr	r2, [sp]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	vldrw.u32 q1, [q6, #324]
	adds	r4, r0, r4
	adc	r0, ip, r9
	str	r0, [sp, #60]
	ldr	r0, [sp, #72]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r0
	veor q0, q0, q3
	ldrd	r8, [sp, #56]
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	str	r4, [r2, #12]
	umull	r4, ip, fp, r7
	veor q1, q1, q4
	ldrd	r2, r6, [sp, #44]
	ldr	r0, [sp, #108]
	lsrl	r8, r9, #25
	umlal	r4, ip, r5, r0
	ldr	r0, [sp, #84]
	umlal	r10, lr, r6, r2
	vshl.i32 q2, q0, #9
	umlal	r4, ip, r0, r3
	ldr	r2, [sp, #32]
	ldr	r0, [sp, #16]
	ldr	r6, [sp, #64]
	umlal	r4, ip, r2, r0
	ldr	r0, [sp, #76]
	vsri.32 q2, q0, #23
	ldr	r2, [sp, #12]
	umlal	r4, ip, r6, r0
	ldr	r6, [sp, #4]
	lsls	r1, r1, #1
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #24]
	vstrw.u32 q2, [q7, #-388]
	ldr	r2, [sp, #88]
	str	r10, [sp, #116]
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #8]
	ldr	r2, [sp, #40]
	vshl.i32 q5, q1, #9
	umlal	r4, ip, r6, r2
	ldr	r2, [sp]
	ldr	r6, [sp, #72]
	umlal	r4, ip, r2, r1
	ldr	r2, [sp, #44]
	umlal	r4, ip, r6, r2
	vsri.32 q5, q1, #23
	adds	r8, r4, r8
	adc	ip, ip, r9
	str	r8, [sp, #56]
	str	ip, [sp, #60]
	ldrd	r10, [sp, #56]
	lsrl	r10, fp, #26
	vstrw.u32 q5, [q7, #12]
	ldr	r2, [sp, #80]
	bic	r8, r8, #-67108864
	strd	r10, [sp, #56]
	str	r8, [r2, #16]
	ldr	r4, [sp, #48]
	vldrw.u32 q3, [q7, #364]
	ldr	r2, [sp, #12]
	lsl	ip, r4, #1
	ldr	r4, [sp, #92]
	ldr	r6, [sp, #4]
	umull	fp, r10, r7, r4
	ldrd	r8, [sp, #56]
	vldrw.u32 q4, [q7, #444]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r5, r4
	umlal	fp, r10, r3, r2
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #52]
	umlal	fp, r10, r4, r2
	vldrw.u32 q0, [q6, #-492]
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	fp, r10, r0, r4
	ldr	r4, [sp, #36]
	umlal	fp, r10, r6, r4
	vldrw.u32 q1, [q6, #20]
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #72]
	umlal	fp, r10, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #116]
	adds	r4, r6, r4
	veor q0, q0, q3
	ldr	r6, [sp, #48]
	str	r4, [sp, #56]
	umlal	fp, r10, r2, r6
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	ldr	r6, [sp, #104]
	veor q1, q1, q4
	str	r4, [r2, #20]
	ldr	r2, [sp]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r2, r6
	adc	lr, lr, r9
	vshl.i32 q2, q1, #1
	ldr	r6, [sp, #68]
	ldr	r2, [sp, #44]
	str	lr, [sp, #60]
	umull	r4, lr, r4, r7
	ldrd	r8, [sp, #56]
	umlal	fp, r10, r6, r2
	vsri.32 q2, q1, #31
	ldr	r2, [sp, #84]
	lsrl	r8, r9, #25
	umlal	r4, lr, r5, r2
	ldr	r2, [sp, #64]
	str	r3, [sp, #32]
	umlal	r4, lr, r2, r3
	vstrw.u32 q2, [q7, #-452]
	ldrd	r2, r3, [sp, #12]
	umlal	r4, lr, r3, r2
	str	fp, [sp, #76]
	ldr	r3, [sp, #88]
	ldr	r6, [sp, #4]
	umlal	r4, lr, r0, r3
	vorr q5, q0, q0
	ldr	r3, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	r4, lr, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #72]
	vstrw.u32 q5, [q7, #-52]
	umlal	r4, lr, r6, r1
	umlal	r4, lr, r2, r3
	ldr	r3, [sp]
	ldr	r2, [sp, #44]
	umlal	r4, lr, r3, ip
	ldr	r3, [sp, #104]
	vldrw.u32 q0, [q6, #-412]
	strd	r8, [sp, #56]
	umlal	r4, lr, r3, r2
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, lr, r4
	vldrw.u32 q1, [q6, #100]
	str	r4, [sp, #28]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #80]
	veor q0, q0, q3
	ldr	r2, [sp, #52]
	bic	r8, r8, #-67108864
	str	r8, [r3, #24]
	ldr	r3, [sp, #68]
	umull	lr, r8, r7, r2
	lsl	r9, r3, #1
	veor q1, q1, q4
	ldr	r3, [sp, #12]
	ldr	r2, [sp, #64]
	umlal	lr, r8, r5, r3
	umull	r3, fp, r7, r3
	umlal	r3, fp, r5, r2
	ldr	r4, [sp, #32]
	vshl.i32 q2, q0, #22
	ldr	r2, [sp, #88]
	ldr	r5, [sp, #40]
	umlal	r3, fp, r4, r2
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #16]
	vsri.32 q2, q0, #10
	ldr	r2, [sp, #8]
	umlal	r3, fp, r4, r5
	ldr	r5, [sp, #36]
	umlal	r3, fp, r0, r1
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #72]
	vstrw.u32 q2, [q6, #420]
	ldr	r1, [sp, #4]
	umlal	lr, r8, r0, r4
	umlal	r3, fp, r1, r4
	ldr	r4, [sp, #48]
	ldr	r0, [sp, #104]
	umlal	lr, r8, r1, r4
	vshl.i32 q5, q1, #22
	umlal	r3, fp, r6, ip
	umlal	lr, r8, r6, r0
	umlal	r3, fp, r2, r0
	ldr	r6, [sp, #68]
	ldr	r0, [sp, #100]
	umlal	lr, r8, r2, r6
	vsri.32 q5, q1, #10
	ldr	r2, [sp]
	ldr	r6, [sp, #76]
	umlal	r3, fp, r2, r9
	mov	ip, r3
	umlal	lr, r8, r2, r0
	vstrw.u32 q5, [q7, #-196]
	ldr	r2, [sp, #44]
	ldr	r5, [sp, #96]
	umlal	ip, fp, r0, r2
	ldrd	r0, [sp, #24]
	adds	r4, r6, r0
	umlal	lr, r8, r2, r5
	vldrw.u32 q0, [q6, #-332]
	mov	r2, r4
	adc	r3, r10, r1
	lsrl	r2, r3, #25
	ldr	r7, [sp, #80]
	adds	ip, ip, r2
	bic	r4, r4, #-33554432
	vldrw.u32 q1, [q6, #180]
	str	r4, [r7, #28]
	mov	r4, ip
	adc	r5, fp, r3
	lsrl	r4, r5, #26
	adds	lr, lr, r4
	veor q0, q0, q3
	mov	r2, lr
	bic	r3, ip, #-67108864
	str	r3, [r7, #32]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r0, r2
	veor q1, q1, q4
	mov	r1, r3
	lsll	r0, r1, #3
	adds	r4, r0, r2
	adc	r5, r1, r3
	adds	r4, r4, r4
	adcs	r5, r5, r5
	vshl.i32 q2, q0, #5
	adds	r4, r4, r2
	adc	r5, r5, r3
	ldr	r3, [sp, #120]
	ldr	r1, [sp, #112]
	adds	r4, r4, r3
	vsri.32 q2, q0, #27
	mov	r2, r4
	adc	r3, r5, #0
	lsrl	r2, r3, #26
	bic	r4, r4, #-67108864
	str	r4, [r7]
	ldr	r4, [sp, #124]
	vstrw.u32 q2, [q7, #-340]
	bic	r6, lr, #-33554432
	adds	r3, r4, r2
	bic	r2, r3, #-33554432
	add	r1, r1, r3, lsr #25
	strd	r2, r1, [r7, #4]
	str	r6, [r7, #36]
	vshl.i32 q5, q1, #5
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	vsri.32 q5, q1, #27
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
	str	r7, [sp, #100]
	ldr	r7, [r1, #32]
	vstrw.u32 q5, [q7, #60]
	ldr	r6, [r2, #12]
	str	r7, [sp, #76]
	ldr	r7, [lr, #20]
	ldr	r3, [r2, #4]
	mul	r8, ip, r7
	ldr	r4, [r2, #8]
	vldrw.u32 q0, [q6, #-252]
	str	r6, [sp, #36]
	mul	r2, ip, r6
	str	r7, [sp, #48]
	ldr	r6, [r1, #16]
	ldr	r7, [lr, #28]
	str	r6, [sp, #4]
	vldrw.u32 q1, [q6, #260]
	mov	r6, r7
	ldr	r5, [r1, #36]
	str	r0, [sp, #80]
	str	r5, [sp, #92]
	mov	r5, r4
	veor q0, q0, q3
	ldr	r0, [lr, #16]
	str	r2, [sp, #112]
	ldr	r2, [r1, #24]
	str	r8, [sp, #108]
	str	r2, [sp, #16]
	add	r2, r0, r0, lsl #3
	veor q1, q1, q4
	add	r10, r0, r2, lsl #1
	ldr	r2, [lr, #24]
	mul	r8, ip, r6
	add	r7, r2, r2, lsl #3
	add	fp, r2, r7, lsl #1
	ldr	r7, [r1, #12]
	vshl.i32 q2, q1, #23
	add	r4, r4, r4, lsl #3
	str	r5, [sp, #40]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #52]
	mul	r5, ip, r3
	vsri.32 q2, q1, #9
	str	r0, [sp, #72]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #104]
	str	r6, [sp, #68]
	str	r8, [sp, #84]
	vstrw.u32 q2, [q7, #-484]
	str	r7, [sp, #24]
	ldr	r2, [lr, #36]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #8]
	ldr	r7, [lr]
	vshl.i32 q5, q0, #22
	str	r2, [sp, #96]
	ldr	r2, [r1, #4]
	str	r7, [sp, #12]
	ldr	r7, [sp, #100]
	str	r2, [sp]
	vsri.32 q5, q0, #10
	ldr	r2, [r1]
	ldr	r1, [sp, #36]
	str	ip, [sp, #64]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	add	lr, r1, r1, lsl #3
	vstrw.u32 q5, [q7, #-84]
	ldr	r7, [sp, #76]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #32]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #92]
	mov	r6, r3
	vldrw.u32 q0, [q6, #-172]
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	umlal	lr, ip, r10, r3
	ldr	r3, [sp, #92]
	ldr	r7, [sp, #8]
	umlal	r4, r1, r3, r5
	vldrw.u32 q1, [q6, #340]
	mov	r8, r4
	ldr	r4, [sp, #112]
	ldr	r5, [sp, #108]
	umlal	r8, r1, r4, r6
	ldr	r4, [sp, #16]
	veor q0, q0, q3
	mov	r3, r6
	umlal	r8, r1, r10, r4
	umlal	r8, r1, r5, r0
	ldr	r6, [sp, #4]
	ldr	r5, [sp, #84]
	umlal	r8, r1, fp, r6
	veor q1, q1, q4
	ldr	r6, [sp, #24]
	umlal	r8, r1, r5, r6
	ldr	r6, [sp, #32]
	ldr	r5, [sp]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #64]
	vshl.i32 q2, q0, #1
	umlal	r8, r1, r6, r5
	ldr	r6, [sp, #12]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #48]
	str	r1, [sp, #60]
	vsri.32 q2, q0, #31
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	umlal	lr, ip, r1, r4
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	umlal	lr, ip, fp, r0
	vstrw.u32 q2, [q7, #-228]
	str	r8, [sp, #120]
	ldr	r4, [sp, #68]
	ldr	r6, [sp, #4]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r6
	vshl.i32 q5, q1, #1
	ldr	r5, [sp, #32]
	ldr	r6, [sp, #24]
	str	r8, [sp, #116]
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	vsri.32 q5, q1, #31
	lsrl	r6, r7, #26
	ldr	r5, [sp, #96]
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	add	r8, r5, r8, lsl #1
	mov	r6, r8
	vstrw.u32 q5, [q7, #172]
	ldr	r7, [sp, #8]
	ldr	r5, [sp, #12]
	umlal	lr, ip, r8, r7
	ldr	r4, [sp]
	str	r2, [sp, #44]
	umlal	lr, ip, r4, r5
	vldrw.u32 q3, [q7, #380]
	ldr	r4, [sp, #52]
	ldr	r7, [sp, #76]
	umlal	lr, ip, r4, r2
	lsls	r4, r4, #1
	str	r4, [sp, #88]
	vldrw.u32 q4, [q7, #460]
	ldr	r4, [sp, #56]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	adc	r9, ip, r2
	bic	ip, r4, #-33554432
	str	ip, [sp, #124]
	vldrw.u32 q0, [q6, #-476]
	umull	r1, ip, r7, r1
	ldr	r5, [sp, #92]
	ldr	r2, [sp, #116]
	umlal	r1, ip, r5, r10
	umlal	r1, ip, fp, r3
	mov	r8, r4
	vldrw.u32 q1, [q6, #36]
	ldr	r4, [sp, #16]
	str	r6, [sp, #92]
	umlal	r1, ip, r2, r4
	ldr	r2, [sp, #32]
	lsrl	r8, r9, #25
	umlal	r1, ip, r2, r0
	veor q0, q0, q3
	mov	r2, r6
	ldr	r6, [sp, #4]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #12]
	veor q1, q1, q4
	umlal	r1, ip, r6, r2
	ldr	r6, [sp, #52]
	ldr	r2, [sp, #8]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #40]
	ldr	r2, [sp]
	vshl.i32 q2, q0, #31
	umlal	r1, ip, r2, r6
	mov	lr, r1
	ldr	r6, [sp, #36]
	ldr	r1, [sp, #44]
	umlal	lr, ip, r6, r1
	str	lr, [sp, #56]
	vsri.32 q2, q0, #1
	umull	lr, r1, r10, r7
	ldr	r6, [sp, #112]
	ldr	r2, [sp, #84]
	umlal	lr, r1, r5, r6
	ldr	r6, [sp, #108]
	vstrw.u32 q2, [q7, #-292]
	umlal	lr, r1, r6, r3
	umlal	lr, r1, fp, r4
	umlal	lr, r1, r2, r0
	ldr	r6, [sp, #4]
	ldr	r2, [sp, #32]
	umlal	lr, r1, r2, r6
	vshl.i32 q5, q1, #31
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #64]
	umlal	lr, r1, r2, r6
	ldrd	r7, r2, [sp, #8]
	umlal	lr, r1, r7, r2
	ldr	r2, [sp, #88]
	vsri.32 q5, q1, #1
	ldr	r7, [sp]
	umlal	lr, r1, r7, r2
	ldrd	r7, r2, [sp, #40]
	umlal	lr, r1, r7, r2
	adds	lr, lr, r8
	vstrw.u32 q5, [q7, #108]
	adc	r2, r1, r9
	str	lr, [sp, #16]
	str	r2, [sp, #20]
	ldrd	r8, [sp, #16]
	lsrl	r8, r9, #26
	ldr	r7, [sp, #76]
	vldrw.u32 q0, [q6, #-396]
	ldr	r2, [sp, #116]
	bic	lr, lr, #-67108864
	str	lr, [sp, #112]
	umull	r10, lr, r7, r2
	umlal	r10, lr, r5, fp
	ldr	r2, [sp, #32]
	vldrw.u32 q1, [q6, #116]
	str	r4, [sp, #16]
	umlal	r10, lr, r2, r3
	ldr	r2, [sp, #92]
	str	r0, [sp, #76]
	umlal	r10, lr, r2, r4
	ldr	r2, [sp, #12]
	veor q0, q0, q3
	ldr	r4, [sp, #4]
	umlal	r10, lr, r0, r2
	ldr	r2, [sp, #52]
	ldr	r0, [sp, #56]
	umlal	r10, lr, r4, r2
	veor q1, q1, q4
	ldr	r4, [sp, #40]
	ldr	r1, [sp, #36]
	umlal	r10, lr, r6, r4
	ldr	r4, [sp, #36]
	ldr	r6, [sp, #8]
	ldr	r2, [sp]
	vshl.i32 q2, q0, #3
	umlal	r10, lr, r6, r4
	mov	r4, r8
	adds	r4, r0, r4
	adc	r0, ip, r9
	str	r0, [sp, #60]
	ldr	r0, [sp, #72]
	vsri.32 q2, q0, #29
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r0
	ldrd	r8, [sp, #56]
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	vstrw.u32 q2, [q7, #-436]
	str	r4, [r2, #12]
	umull	r4, ip, fp, r7
	ldrd	r2, r6, [sp, #44]
	ldr	r0, [sp, #108]
	lsrl	r8, r9, #25
	umlal	r4, ip, r5, r0
	vshl.i32 q5, q1, #3
	ldr	r0, [sp, #84]
	umlal	r10, lr, r6, r2
	umlal	r4, ip, r0, r3
	ldr	r2, [sp, #32]
	ldr	r0, [sp, #16]
	ldr	r6, [sp, #64]
	vsri.32 q5, q1, #29
	umlal	r4, ip, r2, r0
	ldr	r0, [sp, #76]
	ldr	r2, [sp, #12]
	umlal	r4, ip, r6, r0
	ldr	r6, [sp, #4]
	vstrw.u32 q5, [q7, #-36]
	lsls	r1, r1, #1
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #88]
	str	r10, [sp, #116]
	umlal	r4, ip, r6, r2
	vldrw.u32 q0, [q6, #-316]
	ldr	r6, [sp, #8]
	ldr	r2, [sp, #40]
	umlal	r4, ip, r6, r2
	ldr	r2, [sp]
	ldr	r6, [sp, #72]
	umlal	r4, ip, r2, r1
	vldrw.u32 q1, [q6, #196]
	ldr	r2, [sp, #44]
	umlal	r4, ip, r6, r2
	adds	r8, r4, r8
	adc	ip, ip, r9
	str	r8, [sp, #56]
	veor q0, q0, q3
	str	ip, [sp, #60]
	ldrd	r10, [sp, #56]
	lsrl	r10, fp, #26
	ldr	r2, [sp, #80]
	bic	r8, r8, #-67108864
	strd	r10, [sp, #56]
	veor q1, q1, q4
	str	r8, [r2, #16]
	ldr	r4, [sp, #48]
	ldr	r2, [sp, #12]
	lsl	ip, r4, #1
	ldr	r4, [sp, #92]
	ldr	r6, [sp, #4]
	vshl.i32 q2, q1, #22
	umull	fp, r10, r7, r4
	ldrd	r8, [sp, #56]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r5, r4
	umlal	fp, r10, r3, r2
	ldr	r4, [sp, #16]
	vsri.32 q2, q1, #10
	ldr	r2, [sp, #52]
	umlal	fp, r10, r4, r2
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	fp, r10, r0, r4
	vstrw.u32 q2, [q6, #436]
	ldr	r4, [sp, #36]
	umlal	fp, r10, r6, r4
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #72]
	umlal	fp, r10, r6, r4
	mov	r4, r8
	vshl.i32 q5, q0, #21
	ldr	r6, [sp, #116]
	adds	r4, r6, r4
	ldr	r6, [sp, #48]
	str	r4, [sp, #56]
	umlal	fp, r10, r2, r6
	ldr	r2, [sp, #80]
	vsri.32 q5, q0, #11
	bic	r4, r4, #-33554432
	ldr	r6, [sp, #104]
	str	r4, [r2, #20]
	ldr	r2, [sp]
	ldr	r4, [sp, #32]
	vstrw.u32 q5, [q7, #-180]
	umlal	fp, r10, r2, r6
	adc	lr, lr, r9
	ldr	r6, [sp, #68]
	ldr	r2, [sp, #44]
	str	lr, [sp, #60]
	umull	r4, lr, r4, r7
	vldrw.u32 q0, [q6, #-236]
	ldrd	r8, [sp, #56]
	umlal	fp, r10, r6, r2
	ldr	r2, [sp, #84]
	lsrl	r8, r9, #25
	umlal	r4, lr, r5, r2
	ldr	r2, [sp, #64]
	vldrw.u32 q1, [q6, #276]
	str	r3, [sp, #32]
	umlal	r4, lr, r2, r3
	ldrd	r2, r3, [sp, #12]
	umlal	r4, lr, r3, r2
	str	fp, [sp, #76]
	veor q0, q0, q3
	ldr	r3, [sp, #88]
	ldr	r6, [sp, #4]
	umlal	r4, lr, r0, r3
	ldr	r3, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	r4, lr, r6, r3
	veor q1, q1, q4
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #72]
	umlal	r4, lr, r6, r1
	umlal	r4, lr, r2, r3
	ldr	r3, [sp]
	ldr	r2, [sp, #44]
	vshl.i32 q2, q1, #8
	umlal	r4, lr, r3, ip
	ldr	r3, [sp, #104]
	strd	r8, [sp, #56]
	umlal	r4, lr, r3, r2
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	vsri.32 q2, q1, #24
	str	r8, [sp, #24]
	adc	r4, lr, r4
	str	r4, [sp, #28]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	vstrw.u32 q2, [q7, #-324]
	strd	r2, [sp, #24]
	ldr	r3, [sp, #80]
	ldr	r2, [sp, #52]
	bic	r8, r8, #-67108864
	str	r8, [r3, #24]
	ldr	r3, [sp, #68]
	vshl.i32 q5, q0, #7
	umull	lr, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #12]
	ldr	r2, [sp, #64]
	umlal	lr, r8, r5, r3
	umull	r3, fp, r7, r3
	vsri.32 q5, q0, #25
	umlal	r3, fp, r5, r2
	ldr	r4, [sp, #32]
	ldr	r2, [sp, #88]
	ldr	r5, [sp, #40]
	umlal	r3, fp, r4, r2
	vstrw.u32 q5, [q7, #76]
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #8]
	umlal	r3, fp, r4, r5
	ldr	r5, [sp, #36]
	umlal	r3, fp, r0, r1
	vldrw.u32 q0, [q6, #-156]
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #72]
	ldr	r1, [sp, #4]
	umlal	lr, r8, r0, r4
	umlal	r3, fp, r1, r4
	ldr	r4, [sp, #48]
	vldrw.u32 q1, [q6, #356]
	ldr	r0, [sp, #104]
	umlal	lr, r8, r1, r4
	umlal	r3, fp, r6, ip
	umlal	lr, r8, r6, r0
	umlal	r3, fp, r2, r0
	veor q0, q0, q3
	ldr	r6, [sp, #68]
	ldr	r0, [sp, #100]
	umlal	lr, r8, r2, r6
	ldr	r2, [sp]
	ldr	r6, [sp, #76]
	umlal	r3, fp, r2, r9
	veor q1, q1, q4
	mov	ip, r3
	umlal	lr, r8, r2, r0
	ldr	r2, [sp, #44]
	ldr	r5, [sp, #96]
	umlal	ip, fp, r0, r2
	ldrd	r0, [sp, #24]
	vshl.i32 q2, q1, #31
	adds	r4, r6, r0
	umlal	lr, r8, r2, r5
	mov	r2, r4
	adc	r3, r10, r1
	lsrl	r2, r3, #25
	vsri.32 q2, q1, #1
	ldr	r7, [sp, #80]
	adds	ip, ip, r2
	bic	r4, r4, #-33554432
	str	r4, [r7, #28]
	mov	r4, ip
	adc	r5, fp, r3
	vstrw.u32 q2, [q7, #-468]
	lsrl	r4, r5, #26
	adds	lr, lr, r4
	mov	r2, lr
	bic	r3, ip, #-67108864
	str	r3, [r7, #32]
	adc	r3, r8, r5
	vshl.i32 q5, q0, #30
	lsrl	r2, r3, #25
	mov	r0, r2
	mov	r1, r3
	lsll	r0, r1, #3
	adds	r4, r0, r2
	adc	r5, r1, r3
	vsri.32 q5, q0, #2
	adds	r4, r4, r4
	adcs	r5, r5, r5
	adds	r4, r4, r2
	adc	r5, r5, r3
	ldr	r3, [sp, #120]
	vstrw.u32 q5, [q7, #-68]
	ldr	r1, [sp, #112]
	adds	r4, r4, r3
	mov	r2, r4
	adc	r3, r5, #0
	lsrl	r2, r3, #26
	bic	r4, r4, #-67108864
	vldrw.u32 q3, [q7, #396]
	str	r4, [r7]
	ldr	r4, [sp, #124]
	bic	r6, lr, #-33554432
	adds	r3, r4, r2
	bic	r2, r3, #-33554432
	add	r1, r1, r3, lsr #25
	vldrw.u32 q4, [q7, #476]
	strd	r2, r1, [r7, #4]
	str	r6, [r7, #36]
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	vldrw.u32 q0, [q6, #-460]
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
	vldrw.u32 q1, [q6, #52]
	str	r7, [sp, #100]
	ldr	r7, [r1, #32]
	ldr	r6, [r2, #12]
	str	r7, [sp, #76]
	ldr	r7, [lr, #20]
	ldr	r3, [r2, #4]
	veor q0, q0, q3
	mul	r8, ip, r7
	ldr	r4, [r2, #8]
	str	r6, [sp, #36]
	mul	r2, ip, r6
	str	r7, [sp, #48]
	veor q1, q1, q4
	ldr	r6, [r1, #16]
	ldr	r7, [lr, #28]
	str	r6, [sp, #4]
	mov	r6, r7
	ldr	r5, [r1, #36]
	str	r0, [sp, #80]
	vshl.i32 q2, q0, #14
	str	r5, [sp, #92]
	mov	r5, r4
	ldr	r0, [lr, #16]
	str	r2, [sp, #112]
	ldr	r2, [r1, #24]
	str	r8, [sp, #108]
	vsri.32 q2, q0, #18
	str	r2, [sp, #16]
	add	r2, r0, r0, lsl #3
	add	r10, r0, r2, lsl #1
	ldr	r2, [lr, #24]
	mul	r8, ip, r6
	add	r7, r2, r2, lsl #3
	vstrw.u32 q2, [q6, #484]
	add	fp, r2, r7, lsl #1
	ldr	r7, [r1, #12]
	add	r4, r4, r4, lsl #3
	str	r5, [sp, #40]
	add	r4, r5, r4, lsl #1
	vshl.i32 q5, q1, #14
	str	r3, [sp, #52]
	mul	r5, ip, r3
	str	r0, [sp, #72]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #104]
	vsri.32 q5, q1, #18
	str	r6, [sp, #68]
	str	r8, [sp, #84]
	str	r7, [sp, #24]
	ldr	r2, [lr, #36]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	vstrw.u32 q5, [q7, #-132]
	str	r7, [sp, #8]
	ldr	r7, [lr]
	str	r2, [sp, #96]
	ldr	r2, [r1, #4]
	str	r7, [sp, #12]
	vldrw.u32 q0, [q6, #-380]
	ldr	r7, [sp, #100]
	str	r2, [sp]
	ldr	r2, [r1]
	ldr	r1, [sp, #36]
	str	ip, [sp, #64]
	add	ip, r7, r7, lsl #3
	vldrw.u32 q1, [q6, #132]
	add	ip, r7, ip, lsl #1
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #76]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #32]
	umull	lr, ip, lr, r7
	veor q0, q0, q3
	ldr	r1, [sp, #92]
	mov	r6, r3
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	umlal	lr, ip, r10, r3
	veor q1, q1, q4
	ldr	r3, [sp, #92]
	ldr	r7, [sp, #8]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r4, [sp, #112]
	ldr	r5, [sp, #108]
	vshl.i32 q2, q1, #28
	umlal	r8, r1, r4, r6
	ldr	r4, [sp, #16]
	mov	r3, r6
	umlal	r8, r1, r10, r4
	umlal	r8, r1, r5, r0
	ldr	r6, [sp, #4]
	vsri.32 q2, q1, #4
	ldr	r5, [sp, #84]
	umlal	r8, r1, fp, r6
	ldr	r6, [sp, #24]
	umlal	r8, r1, r5, r6
	ldr	r6, [sp, #32]
	vstrw.u32 q2, [q7, #-276]
	ldr	r5, [sp]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #64]
	umlal	r8, r1, r6, r5
	ldr	r6, [sp, #12]
	umlal	r8, r1, r6, r2
	vshl.i32 q5, q0, #27
	ldr	r6, [sp, #48]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	umlal	lr, ip, r1, r4
	str	r8, [sp, #56]
	vsri.32 q5, q0, #5
	bic	r8, r8, #-67108864
	umlal	lr, ip, fp, r0
	str	r8, [sp, #120]
	ldr	r4, [sp, #68]
	ldr	r6, [sp, #4]
	add	r8, r4, r4, lsl #3
	vstrw.u32 q5, [q7, #124]
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r6
	ldr	r5, [sp, #32]
	ldr	r6, [sp, #24]
	str	r8, [sp, #116]
	vldrw.u32 q0, [q6, #-300]
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	ldr	r5, [sp, #96]
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	vldrw.u32 q1, [q6, #212]
	add	r8, r5, r8, lsl #1
	mov	r6, r8
	ldr	r7, [sp, #8]
	ldr	r5, [sp, #12]
	umlal	lr, ip, r8, r7
	ldr	r4, [sp]
	veor q0, q0, q3
	str	r2, [sp, #44]
	umlal	lr, ip, r4, r5
	ldr	r4, [sp, #52]
	ldr	r7, [sp, #76]
	umlal	lr, ip, r4, r2
	veor q1, q1, q4
	lsls	r4, r4, #1
	str	r4, [sp, #88]
	ldr	r4, [sp, #56]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	adc	r9, ip, r2
	vshl.i32 q2, q1, #13
	bic	ip, r4, #-33554432
	str	ip, [sp, #124]
	umull	r1, ip, r7, r1
	ldr	r5, [sp, #92]
	ldr	r2, [sp, #116]
	umlal	r1, ip, r5, r10
	vsri.32 q2, q1, #19
	umlal	r1, ip, fp, r3
	mov	r8, r4
	ldr	r4, [sp, #16]
	str	r6, [sp, #92]
	umlal	r1, ip, r2, r4
	vstrw.u32 q2, [q7, #-420]
	ldr	r2, [sp, #32]
	lsrl	r8, r9, #25
	umlal	r1, ip, r2, r0
	mov	r2, r6
	ldr	r6, [sp, #4]
	umlal	r1, ip, r2, r6
	vshl.i32 q5, q0, #12
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #12]
	umlal	r1, ip, r6, r2
	ldr	r6, [sp, #52]
	ldr	r2, [sp, #8]
	umlal	r1, ip, r2, r6
	vsri.32 q5, q0, #20
	ldr	r6, [sp, #40]
	ldr	r2, [sp]
	umlal	r1, ip, r2, r6
	mov	lr, r1
	ldr	r6, [sp, #36]
	ldr	r1, [sp, #44]
	vstrw.u32 q5, [q7, #-20]
	umlal	lr, ip, r6, r1
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	ldr	r6, [sp, #112]
	ldr	r2, [sp, #84]
	vldrw.u32 q0, [q6, #-220]
	umlal	lr, r1, r5, r6
	ldr	r6, [sp, #108]
	umlal	lr, r1, r6, r3
	umlal	lr, r1, fp, r4
	umlal	lr, r1, r2, r0
	ldr	r6, [sp, #4]
	vldrw.u32 q1, [q6, #292]
	ldr	r2, [sp, #32]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #64]
	umlal	lr, r1, r2, r6
	ldrd	r7, r2, [sp, #8]
	veor q0, q0, q3
	umlal	lr, r1, r7, r2
	ldr	r2, [sp, #88]
	ldr	r7, [sp]
	umlal	lr, r1, r7, r2
	ldrd	r7, r2, [sp, #40]
	veor q1, q1, q4
	umlal	lr, r1, r7, r2
	adds	lr, lr, r8
	adc	r2, r1, r9
	str	lr, [sp, #16]
	str	r2, [sp, #20]
	ldrd	r8, [sp, #16]
	vshl.i32 q2, q1, #11
	lsrl	r8, r9, #26
	ldr	r7, [sp, #76]
	ldr	r2, [sp, #116]
	bic	lr, lr, #-67108864
	str	lr, [sp, #112]
	umull	r10, lr, r7, r2
	vsri.32 q2, q1, #21
	umlal	r10, lr, r5, fp
	ldr	r2, [sp, #32]
	str	r4, [sp, #16]
	umlal	r10, lr, r2, r3
	ldr	r2, [sp, #92]
	vstrw.u32 q2, [q6, #452]
	str	r0, [sp, #76]
	umlal	r10, lr, r2, r4
	ldr	r2, [sp, #12]
	ldr	r4, [sp, #4]
	umlal	r10, lr, r0, r2
	ldr	r2, [sp, #52]
	vshl.i32 q5, q0, #10
	ldr	r0, [sp, #56]
	umlal	r10, lr, r4, r2
	ldr	r4, [sp, #40]
	ldr	r1, [sp, #36]
	umlal	r10, lr, r6, r4
	ldr	r4, [sp, #36]
	vsri.32 q5, q0, #22
	ldr	r6, [sp, #8]
	ldr	r2, [sp]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	adds	r4, r0, r4
	vstrw.u32 q5, [q7, #-164]
	adc	r0, ip, r9
	str	r0, [sp, #60]
	ldr	r0, [sp, #72]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r0
	ldrd	r8, [sp, #56]
	vldrw.u32 q0, [q6, #-140]
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	str	r4, [r2, #12]
	umull	r4, ip, fp, r7
	ldrd	r2, r6, [sp, #44]
	ldr	r0, [sp, #108]
	vldrw.u32 q1, [q6, #372]
	lsrl	r8, r9, #25
	umlal	r4, ip, r5, r0
	ldr	r0, [sp, #84]
	umlal	r10, lr, r6, r2
	umlal	r4, ip, r0, r3
	ldr	r2, [sp, #32]
	veor q0, q0, q3
	ldr	r0, [sp, #16]
	ldr	r6, [sp, #64]
	umlal	r4, ip, r2, r0
	ldr	r0, [sp, #76]
	ldr	r2, [sp, #12]
	veor q1, q1, q4
	umlal	r4, ip, r6, r0
	ldr	r6, [sp, #4]
	lsls	r1, r1, #1
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #88]
	vshl.i32 q2, q0, #28
	str	r10, [sp, #116]
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #8]
	ldr	r2, [sp, #40]
	umlal	r4, ip, r6, r2
	ldr	r2, [sp]
	vsri.32 q2, q0, #4
	ldr	r6, [sp, #72]
	umlal	r4, ip, r2, r1
	ldr	r2, [sp, #44]
	umlal	r4, ip, r6, r2
	adds	r8, r4, r8
	vstrw.u32 q2, [q7, #-308]
	adc	ip, ip, r9
	str	r8, [sp, #56]
	str	ip, [sp, #60]
	ldrd	r10, [sp, #56]
	lsrl	r10, fp, #26
	ldr	r2, [sp, #80]
	vshl.i32 q5, q1, #28
	bic	r8, r8, #-67108864
	strd	r10, [sp, #56]
	str	r8, [r2, #16]
	ldr	r4, [sp, #48]
	ldr	r2, [sp, #12]
	lsl	ip, r4, #1
	vsri.32 q5, q1, #4
	ldr	r4, [sp, #92]
	ldr	r6, [sp, #4]
	umull	fp, r10, r7, r4
	ldrd	r8, [sp, #56]
	ldr	r4, [sp, #32]
	vstrw.u32 q5, [q7, #92]
	umlal	fp, r10, r5, r4
	umlal	fp, r10, r3, r2
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #52]
	umlal	fp, r10, r4, r2
	ldr	r4, [sp, #40]
	vldrw.u32 q3, [q7, #412]
	ldr	r2, [sp, #8]
	umlal	fp, r10, r0, r4
	ldr	r4, [sp, #36]
	umlal	fp, r10, r6, r4
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #72]
	vldrw.u32 q4, [q7, #492]
	umlal	fp, r10, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #116]
	adds	r4, r6, r4
	ldr	r6, [sp, #48]
	str	r4, [sp, #56]
	vldrw.u32 q0, [q6, #-444]
	umlal	fp, r10, r2, r6
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	ldr	r6, [sp, #104]
	str	r4, [r2, #20]
	vldrw.u32 q1, [q6, #68]
	ldr	r2, [sp]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r2, r6
	adc	lr, lr, r9
	ldr	r6, [sp, #68]
	ldr	r2, [sp, #44]
	veor q0, q0, q3
	str	lr, [sp, #60]
	umull	r4, lr, r4, r7
	ldrd	r8, [sp, #56]
	umlal	fp, r10, r6, r2
	ldr	r2, [sp, #84]
	lsrl	r8, r9, #25
	veor q1, q1, q4
	umlal	r4, lr, r5, r2
	ldr	r2, [sp, #64]
	str	r3, [sp, #32]
	umlal	r4, lr, r2, r3
	ldrd	r2, r3, [sp, #12]
	vshl.i32 q2, q1, #14
	umlal	r4, lr, r3, r2
	str	fp, [sp, #76]
	ldr	r3, [sp, #88]
	ldr	r6, [sp, #4]
	umlal	r4, lr, r0, r3
	ldr	r3, [sp, #40]
	vsri.32 q2, q1, #18
	ldr	r2, [sp, #8]
	umlal	r4, lr, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #72]
	umlal	r4, lr, r6, r1
	umlal	r4, lr, r2, r3
	vstrw.u32 q2, [q7, #-372]
	ldr	r3, [sp]
	ldr	r2, [sp, #44]
	umlal	r4, lr, r3, ip
	ldr	r3, [sp, #104]
	strd	r8, [sp, #56]
	vshl.i32 q5, q0, #13
	umlal	r4, lr, r3, r2
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, lr, r4
	str	r4, [sp, #28]
	vsri.32 q5, q0, #19
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #80]
	ldr	r2, [sp, #52]
	bic	r8, r8, #-67108864
	vstrw.u32 q5, [q7, #28]
	str	r8, [r3, #24]
	ldr	r3, [sp, #68]
	umull	lr, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #12]
	vldrw.u32 q0, [q6, #-364]
	ldr	r2, [sp, #64]
	umlal	lr, r8, r5, r3
	umull	r3, fp, r7, r3
	umlal	r3, fp, r5, r2
	ldr	r4, [sp, #32]
	ldr	r2, [sp, #88]
	vldrw.u32 q1, [q6, #148]
	ldr	r5, [sp, #40]
	umlal	r3, fp, r4, r2
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #8]
	umlal	r3, fp, r4, r5
	veor q0, q0, q3
	ldr	r5, [sp, #36]
	umlal	r3, fp, r0, r1
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #72]
	ldr	r1, [sp, #4]
	umlal	lr, r8, r0, r4
	veor q1, q1, q4
	umlal	r3, fp, r1, r4
	ldr	r4, [sp, #48]
	ldr	r0, [sp, #104]
	umlal	lr, r8, r1, r4
	umlal	r3, fp, r6, ip
	vshl.i32 q2, q0, #10
	umlal	lr, r8, r6, r0
	umlal	r3, fp, r2, r0
	ldr	r6, [sp, #68]
	ldr	r0, [sp, #100]
	umlal	lr, r8, r2, r6
	ldr	r2, [sp]
	vsri.32 q2, q0, #22
	ldr	r6, [sp, #76]
	umlal	r3, fp, r2, r9
	mov	ip, r3
	umlal	lr, r8, r2, r0
	ldr	r2, [sp, #44]
	ldr	r5, [sp, #96]
	vstrw.u32 q2, [q6, #500]
	umlal	ip, fp, r0, r2
	ldrd	r0, [sp, #24]
	adds	r4, r6, r0
	umlal	lr, r8, r2, r5
	mov	r2, r4
	vshl.i32 q5, q1, #10
	adc	r3, r10, r1
	lsrl	r2, r3, #25
	ldr	r7, [sp, #80]
	adds	ip, ip, r2
	bic	r4, r4, #-33554432
	str	r4, [r7, #28]
	vsri.32 q5, q1, #22
	mov	r4, ip
	adc	r5, fp, r3
	lsrl	r4, r5, #26
	adds	lr, lr, r4
	mov	r2, lr
	bic	r3, ip, #-67108864
	vstrw.u32 q5, [q7, #-116]
	str	r3, [r7, #32]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r0, r2
	mov	r1, r3
	vldrw.u32 q0, [q6, #-284]
	lsll	r0, r1, #3
	adds	r4, r0, r2
	adc	r5, r1, r3
	adds	r4, r4, r4
	adcs	r5, r5, r5
	adds	r4, r4, r2
	vldrw.u32 q1, [q6, #228]
	adc	r5, r5, r3
	ldr	r3, [sp, #120]
	ldr	r1, [sp, #112]
	adds	r4, r4, r3
	mov	r2, r4
	adc	r3, r5, #0
	veor q0, q0, q3
	lsrl	r2, r3, #26
	bic	r4, r4, #-67108864
	str	r4, [r7]
	ldr	r4, [sp, #124]
	bic	r6, lr, #-33554432
	adds	r3, r4, r2
	veor q1, q1, q4
	bic	r2, r3, #-33554432
	add	r1, r1, r3, lsr #25
	strd	r2, r1, [r7, #4]
	str	r6, [r7, #36]
	movw r0, #:lower16:g_fc_out
	vshl.i32 q2, q1, #20
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	vsri.32 q2, q1, #12
	mov	ip, #38
	ldr	r7, [r2, #32]
	str	r7, [sp, #100]
	ldr	r7, [r1, #32]
	ldr	r6, [r2, #12]
	str	r7, [sp, #76]
	vstrw.u32 q2, [q7, #-260]
	ldr	r7, [lr, #20]
	ldr	r3, [r2, #4]
	mul	r8, ip, r7
	ldr	r4, [r2, #8]
	str	r6, [sp, #36]
	vshl.i32 q5, q0, #19
	mul	r2, ip, r6
	str	r7, [sp, #48]
	ldr	r6, [r1, #16]
	ldr	r7, [lr, #28]
	str	r6, [sp, #4]
	mov	r6, r7
	vsri.32 q5, q0, #13
	ldr	r5, [r1, #36]
	str	r0, [sp, #80]
	str	r5, [sp, #92]
	mov	r5, r4
	ldr	r0, [lr, #16]
	str	r2, [sp, #112]
	vstrw.u32 q5, [q7, #140]
	ldr	r2, [r1, #24]
	str	r8, [sp, #108]
	str	r2, [sp, #16]
	add	r2, r0, r0, lsl #3
	add	r10, r0, r2, lsl #1
	vldrw.u32 q0, [q6, #-204]
	ldr	r2, [lr, #24]
	mul	r8, ip, r6
	add	r7, r2, r2, lsl #3
	add	fp, r2, r7, lsl #1
	ldr	r7, [r1, #12]
	add	r4, r4, r4, lsl #3
	vldrw.u32 q1, [q6, #308]
	str	r5, [sp, #40]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #52]
	mul	r5, ip, r3
	str	r0, [sp, #72]
	ldr	r3, [r1, #28]
	veor q0, q0, q3
	ldr	r0, [r1, #20]
	str	r2, [sp, #104]
	str	r6, [sp, #68]
	str	r8, [sp, #84]
	str	r7, [sp, #24]
	veor q1, q1, q4
	ldr	r2, [lr, #36]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #8]
	ldr	r7, [lr]
	str	r2, [sp, #96]
	vshl.i32 q2, q0, #4
	ldr	r2, [r1, #4]
	str	r7, [sp, #12]
	ldr	r7, [sp, #100]
	str	r2, [sp]
	ldr	r2, [r1]
	ldr	r1, [sp, #36]
	vsri.32 q2, q0, #28
	str	ip, [sp, #64]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #76]
	add	lr, r1, lr, lsl #1
	vstrw.u32 q2, [q7, #-404]
	str	ip, [sp, #32]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #92]
	mov	r6, r3
	umlal	lr, ip, r1, r4
	vshl.i32 q5, q1, #4
	umull	r4, r1, r4, r7
	umlal	lr, ip, r10, r3
	ldr	r3, [sp, #92]
	ldr	r7, [sp, #8]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	vsri.32 q5, q1, #28
	ldr	r4, [sp, #112]
	ldr	r5, [sp, #108]
	umlal	r8, r1, r4, r6
	ldr	r4, [sp, #16]
	mov	r3, r6
	umlal	r8, r1, r10, r4
	vstrw.u32 q5, [q7, #-4]
	umlal	r8, r1, r5, r0
	ldr	r6, [sp, #4]
	ldr	r5, [sp, #84]
	umlal	r8, r1, fp, r6
	ldr	r6, [sp, #24]
	vldrw.u32 q0, [q6, #-124]
	umlal	r8, r1, r5, r6
	ldr	r6, [sp, #32]
	ldr	r5, [sp]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #64]
	umlal	r8, r1, r6, r5
	vldrw.u32 q1, [q6, #388]
	ldr	r6, [sp, #12]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #48]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	veor q0, q0, q3
	umlal	lr, ip, r1, r4
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	umlal	lr, ip, fp, r0
	str	r8, [sp, #120]
	veor q1, q1, q4
	ldr	r4, [sp, #68]
	ldr	r6, [sp, #4]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r6
	ldr	r5, [sp, #32]
	vshl.i32 q2, q0, #7
	ldr	r6, [sp, #24]
	str	r8, [sp, #116]
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	ldr	r5, [sp, #96]
	vsri.32 q2, q0, #25
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	add	r8, r5, r8, lsl #1
	mov	r6, r8
	ldr	r7, [sp, #8]
	ldr	r5, [sp, #12]
	vstrw.u32 q2, [q6, #468]
	umlal	lr, ip, r8, r7
	ldr	r4, [sp]
	str	r2, [sp, #44]
	umlal	lr, ip, r4, r5
	ldr	r4, [sp, #52]
	vshl.i32 q5, q1, #7
	ldr	r7, [sp, #76]
	umlal	lr, ip, r4, r2
	lsls	r4, r4, #1
	str	r4, [sp, #88]
	ldr	r4, [sp, #56]
	ldr	r2, [sp, #60]
	vsri.32 q5, q1, #25
	adds	r4, lr, r4
	adc	r9, ip, r2
	bic	ip, r4, #-33554432
	str	ip, [sp, #124]
	umull	r1, ip, r7, r1
	ldr	r5, [sp, #92]
	vstrw.u32 q5, [q7, #-148]
	ldr	r2, [sp, #116]
	umlal	r1, ip, r5, r10
	umlal	r1, ip, fp, r3
	mov	r8, r4
	ldr	r4, [sp, #16]
	vldrw.u32 q0, [q6, #404]
	str	r6, [sp, #92]
	umlal	r1, ip, r2, r4
	ldr	r2, [sp, #32]
	lsrl	r8, r9, #25
	umlal	r1, ip, r2, r0
	mov	r2, r6
	vldrw.u32 q1, [q6, #420]
	ldr	r6, [sp, #4]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #12]
	umlal	r1, ip, r6, r2
	ldr	r6, [sp, #52]
	vldrw.u32 q2, [q6, #436]
	ldr	r2, [sp, #8]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #40]
	ldr	r2, [sp]
	umlal	r1, ip, r2, r6
	vldrw.u32 q5, [q6, #452]
	mov	lr, r1
	ldr	r6, [sp, #36]
	ldr	r1, [sp, #44]
	umlal	lr, ip, r6, r1
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	vldrw.u32 q3, [q6, #468]
	ldr	r6, [sp, #112]
	ldr	r2, [sp, #84]
	umlal	lr, r1, r5, r6
	ldr	r6, [sp, #108]
	umlal	lr, r1, r6, r3
	umlal	lr, r1, fp, r4
	vbic q4, q2, q1
	umlal	lr, r1, r2, r0
	ldr	r6, [sp, #4]
	ldr	r2, [sp, #32]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #24]
	veor q4, q4, q0
	ldr	r2, [sp, #64]
	umlal	lr, r1, r2, r6
	ldrd	r7, r2, [sp, #8]
	umlal	lr, r1, r7, r2
	ldr	r2, [sp, #88]
	ldr	r7, [sp]
	vstrw.u32 q4, [q6, #-508]
	umlal	lr, r1, r7, r2
	ldrd	r7, r2, [sp, #40]
	umlal	lr, r1, r7, r2
	adds	lr, lr, r8
	adc	r2, r1, r9
	str	lr, [sp, #16]
	vbic q4, q5, q2
	str	r2, [sp, #20]
	ldrd	r8, [sp, #16]
	lsrl	r8, r9, #26
	ldr	r7, [sp, #76]
	ldr	r2, [sp, #116]
	bic	lr, lr, #-67108864
	veor q4, q4, q1
	str	lr, [sp, #112]
	umull	r10, lr, r7, r2
	umlal	r10, lr, r5, fp
	ldr	r2, [sp, #32]
	str	r4, [sp, #16]
	vstrw.u32 q4, [q6, #-492]
	umlal	r10, lr, r2, r3
	ldr	r2, [sp, #92]
	str	r0, [sp, #76]
	umlal	r10, lr, r2, r4
	ldr	r2, [sp, #12]
	ldr	r4, [sp, #4]
	vbic q4, q3, q5
	umlal	r10, lr, r0, r2
	ldr	r2, [sp, #52]
	ldr	r0, [sp, #56]
	umlal	r10, lr, r4, r2
	ldr	r4, [sp, #40]
	ldr	r1, [sp, #36]
	veor q4, q4, q2
	umlal	r10, lr, r6, r4
	ldr	r4, [sp, #36]
	ldr	r6, [sp, #8]
	ldr	r2, [sp]
	umlal	r10, lr, r6, r4
	vstrw.u32 q4, [q6, #-476]
	mov	r4, r8
	adds	r4, r0, r4
	adc	r0, ip, r9
	str	r0, [sp, #60]
	ldr	r0, [sp, #72]
	str	r4, [sp, #56]
	vbic q4, q0, q3
	umlal	r10, lr, r2, r0
	ldrd	r8, [sp, #56]
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	str	r4, [r2, #12]
	umull	r4, ip, fp, r7
	veor q4, q4, q5
	ldrd	r2, r6, [sp, #44]
	ldr	r0, [sp, #108]
	lsrl	r8, r9, #25
	umlal	r4, ip, r5, r0
	ldr	r0, [sp, #84]
	vstrw.u32 q4, [q6, #-460]
	umlal	r10, lr, r6, r2
	umlal	r4, ip, r0, r3
	ldr	r2, [sp, #32]
	ldr	r0, [sp, #16]
	ldr	r6, [sp, #64]
	umlal	r4, ip, r2, r0
	vbic q4, q1, q0
	ldr	r0, [sp, #76]
	ldr	r2, [sp, #12]
	umlal	r4, ip, r6, r0
	ldr	r6, [sp, #4]
	lsls	r1, r1, #1
	umlal	r4, ip, r6, r2
	veor q4, q4, q3
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #88]
	str	r10, [sp, #116]
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #8]
	ldr	r2, [sp, #40]
	vstrw.u32 q4, [q6, #-444]
	umlal	r4, ip, r6, r2
	ldr	r2, [sp]
	ldr	r6, [sp, #72]
	umlal	r4, ip, r2, r1
	ldr	r2, [sp, #44]
	vldrw.u32 q0, [q6, #484]
	umlal	r4, ip, r6, r2
	adds	r8, r4, r8
	adc	ip, ip, r9
	str	r8, [sp, #56]
	str	ip, [sp, #60]
	ldrd	r10, [sp, #56]
	vldrw.u32 q1, [q6, #500]
	lsrl	r10, fp, #26
	ldr	r2, [sp, #80]
	bic	r8, r8, #-67108864
	strd	r10, [sp, #56]
	str	r8, [r2, #16]
	ldr	r4, [sp, #48]
	vldrw.u32 q2, [q7, #-500]
	ldr	r2, [sp, #12]
	lsl	ip, r4, #1
	ldr	r4, [sp, #92]
	ldr	r6, [sp, #4]
	umull	fp, r10, r7, r4
	vldrw.u32 q5, [q7, #-484]
	ldrd	r8, [sp, #56]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r5, r4
	umlal	fp, r10, r3, r2
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #52]
	vldrw.u32 q3, [q7, #-468]
	umlal	fp, r10, r4, r2
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	fp, r10, r0, r4
	ldr	r4, [sp, #36]
	umlal	fp, r10, r6, r4
	vbic q4, q2, q1
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #72]
	umlal	fp, r10, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #116]
	veor q4, q4, q0
	adds	r4, r6, r4
	ldr	r6, [sp, #48]
	str	r4, [sp, #56]
	umlal	fp, r10, r2, r6
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	vstrw.u32 q4, [q6, #-428]
	ldr	r6, [sp, #104]
	str	r4, [r2, #20]
	ldr	r2, [sp]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r2, r6
	adc	lr, lr, r9
	vbic q4, q5, q2
	ldr	r6, [sp, #68]
	ldr	r2, [sp, #44]
	str	lr, [sp, #60]
	umull	r4, lr, r4, r7
	ldrd	r8, [sp, #56]
	veor q4, q4, q1
	umlal	fp, r10, r6, r2
	ldr	r2, [sp, #84]
	lsrl	r8, r9, #25
	umlal	r4, lr, r5, r2
	ldr	r2, [sp, #64]
	str	r3, [sp, #32]
	vstrw.u32 q4, [q6, #-412]
	umlal	r4, lr, r2, r3
	ldrd	r2, r3, [sp, #12]
	umlal	r4, lr, r3, r2
	str	fp, [sp, #76]
	ldr	r3, [sp, #88]
	ldr	r6, [sp, #4]
	vbic q4, q3, q5
	umlal	r4, lr, r0, r3
	ldr	r3, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	r4, lr, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #72]
	veor q4, q4, q2
	umlal	r4, lr, r6, r1
	umlal	r4, lr, r2, r3
	ldr	r3, [sp]
	ldr	r2, [sp, #44]
	umlal	r4, lr, r3, ip
	vstrw.u32 q4, [q6, #-396]
	ldr	r3, [sp, #104]
	strd	r8, [sp, #56]
	umlal	r4, lr, r3, r2
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	vbic q4, q0, q3
	adc	r4, lr, r4
	str	r4, [sp, #28]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #80]
	veor q4, q4, q5
	ldr	r2, [sp, #52]
	bic	r8, r8, #-67108864
	str	r8, [r3, #24]
	ldr	r3, [sp, #68]
	umull	lr, r8, r7, r2
	vstrw.u32 q4, [q6, #-380]
	lsl	r9, r3, #1
	ldr	r3, [sp, #12]
	ldr	r2, [sp, #64]
	umlal	lr, r8, r5, r3
	umull	r3, fp, r7, r3
	umlal	r3, fp, r5, r2
	vbic q4, q1, q0
	ldr	r4, [sp, #32]
	ldr	r2, [sp, #88]
	ldr	r5, [sp, #40]
	umlal	r3, fp, r4, r2
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #16]
	veor q4, q4, q3
	ldr	r2, [sp, #8]
	umlal	r3, fp, r4, r5
	ldr	r5, [sp, #36]
	umlal	r3, fp, r0, r1
	umlal	lr, r8, r4, r5
	vstrw.u32 q4, [q6, #-364]
	ldr	r4, [sp, #72]
	ldr	r1, [sp, #4]
	umlal	lr, r8, r0, r4
	umlal	r3, fp, r1, r4
	ldr	r4, [sp, #48]
	ldr	r0, [sp, #104]
	vldrw.u32 q0, [q7, #-452]
	umlal	lr, r8, r1, r4
	umlal	r3, fp, r6, ip
	umlal	lr, r8, r6, r0
	umlal	r3, fp, r2, r0
	ldr	r6, [sp, #68]
	ldr	r0, [sp, #100]
	vldrw.u32 q1, [q7, #-436]
	umlal	lr, r8, r2, r6
	ldr	r2, [sp]
	ldr	r6, [sp, #76]
	umlal	r3, fp, r2, r9
	mov	ip, r3
	umlal	lr, r8, r2, r0
	vldrw.u32 q2, [q7, #-420]
	ldr	r2, [sp, #44]
	ldr	r5, [sp, #96]
	umlal	ip, fp, r0, r2
	ldrd	r0, [sp, #24]
	adds	r4, r6, r0
	vldrw.u32 q5, [q7, #-404]
	umlal	lr, r8, r2, r5
	mov	r2, r4
	adc	r3, r10, r1
	lsrl	r2, r3, #25
	ldr	r7, [sp, #80]
	adds	ip, ip, r2
	vldrw.u32 q3, [q7, #-388]
	bic	r4, r4, #-33554432
	str	r4, [r7, #28]
	mov	r4, ip
	adc	r5, fp, r3
	lsrl	r4, r5, #26
	adds	lr, lr, r4
	vbic q4, q2, q1
	mov	r2, lr
	bic	r3, ip, #-67108864
	str	r3, [r7, #32]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	veor q4, q4, q0
	mov	r0, r2
	mov	r1, r3
	lsll	r0, r1, #3
	adds	r4, r0, r2
	adc	r5, r1, r3
	adds	r4, r4, r4
	vstrw.u32 q4, [q6, #-348]
	adcs	r5, r5, r5
	adds	r4, r4, r2
	adc	r5, r5, r3
	ldr	r3, [sp, #120]
	ldr	r1, [sp, #112]
	adds	r4, r4, r3
	vbic q4, q5, q2
	mov	r2, r4
	adc	r3, r5, #0
	lsrl	r2, r3, #26
	bic	r4, r4, #-67108864
	str	r4, [r7]
	veor q4, q4, q1
	ldr	r4, [sp, #124]
	bic	r6, lr, #-33554432
	adds	r3, r4, r2
	bic	r2, r3, #-33554432
	add	r1, r1, r3, lsr #25
	strd	r2, r1, [r7, #4]
	vstrw.u32 q4, [q6, #-332]
	str	r6, [r7, #36]
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	vbic q4, q3, q5
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
	str	r7, [sp, #100]
	veor q4, q4, q2
	ldr	r7, [r1, #32]
	ldr	r6, [r2, #12]
	str	r7, [sp, #76]
	ldr	r7, [lr, #20]
	ldr	r3, [r2, #4]
	mul	r8, ip, r7
	vstrw.u32 q4, [q6, #-316]
	ldr	r4, [r2, #8]
	str	r6, [sp, #36]
	mul	r2, ip, r6
	str	r7, [sp, #48]
	ldr	r6, [r1, #16]
	ldr	r7, [lr, #28]
	vbic q4, q0, q3
	str	r6, [sp, #4]
	mov	r6, r7
	ldr	r5, [r1, #36]
	str	r0, [sp, #80]
	str	r5, [sp, #92]
	mov	r5, r4
	veor q4, q4, q5
	ldr	r0, [lr, #16]
	str	r2, [sp, #112]
	ldr	r2, [r1, #24]
	str	r8, [sp, #108]
	str	r2, [sp, #16]
	vstrw.u32 q4, [q6, #-300]
	add	r2, r0, r0, lsl #3
	add	r10, r0, r2, lsl #1
	ldr	r2, [lr, #24]
	mul	r8, ip, r6
	add	r7, r2, r2, lsl #3
	add	fp, r2, r7, lsl #1
	vbic q4, q1, q0
	ldr	r7, [r1, #12]
	add	r4, r4, r4, lsl #3
	str	r5, [sp, #40]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #52]
	mul	r5, ip, r3
	veor q4, q4, q3
	str	r0, [sp, #72]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #104]
	str	r6, [sp, #68]
	vstrw.u32 q4, [q6, #-284]
	str	r8, [sp, #84]
	str	r7, [sp, #24]
	ldr	r2, [lr, #36]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #8]
	vldrw.u32 q0, [q7, #-372]
	ldr	r7, [lr]
	str	r2, [sp, #96]
	ldr	r2, [r1, #4]
	str	r7, [sp, #12]
	ldr	r7, [sp, #100]
	str	r2, [sp]
	vldrw.u32 q1, [q7, #-356]
	ldr	r2, [r1]
	ldr	r1, [sp, #36]
	str	ip, [sp, #64]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	vldrw.u32 q2, [q7, #-340]
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #76]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #32]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #92]
	vldrw.u32 q5, [q7, #-324]
	mov	r6, r3
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	umlal	lr, ip, r10, r3
	ldr	r3, [sp, #92]
	ldr	r7, [sp, #8]
	vldrw.u32 q3, [q7, #-308]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r4, [sp, #112]
	ldr	r5, [sp, #108]
	umlal	r8, r1, r4, r6
	ldr	r4, [sp, #16]
	vbic q4, q2, q1
	mov	r3, r6
	umlal	r8, r1, r10, r4
	umlal	r8, r1, r5, r0
	ldr	r6, [sp, #4]
	ldr	r5, [sp, #84]
	veor q4, q4, q0
	umlal	r8, r1, fp, r6
	ldr	r6, [sp, #24]
	umlal	r8, r1, r5, r6
	ldr	r6, [sp, #32]
	ldr	r5, [sp]
	umlal	r8, r1, r6, r7
	vstrw.u32 q4, [q6, #-268]
	ldr	r6, [sp, #64]
	umlal	r8, r1, r6, r5
	ldr	r6, [sp, #12]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #48]
	str	r1, [sp, #60]
	vbic q4, q5, q2
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	umlal	lr, ip, r1, r4
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	veor q4, q4, q1
	umlal	lr, ip, fp, r0
	str	r8, [sp, #120]
	ldr	r4, [sp, #68]
	ldr	r6, [sp, #4]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	vstrw.u32 q4, [q6, #-252]
	umlal	lr, ip, r8, r6
	ldr	r5, [sp, #32]
	ldr	r6, [sp, #24]
	str	r8, [sp, #116]
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	vbic q4, q3, q5
	lsrl	r6, r7, #26
	ldr	r5, [sp, #96]
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	add	r8, r5, r8, lsl #1
	veor q4, q4, q2
	mov	r6, r8
	ldr	r7, [sp, #8]
	ldr	r5, [sp, #12]
	umlal	lr, ip, r8, r7
	ldr	r4, [sp]
	str	r2, [sp, #44]
	vstrw.u32 q4, [q6, #-236]
	umlal	lr, ip, r4, r5
	ldr	r4, [sp, #52]
	ldr	r7, [sp, #76]
	umlal	lr, ip, r4, r2
	lsls	r4, r4, #1
	str	r4, [sp, #88]
	vbic q4, q0, q3
	ldr	r4, [sp, #56]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	adc	r9, ip, r2
	bic	ip, r4, #-33554432
	veor q4, q4, q5
	str	ip, [sp, #124]
	umull	r1, ip, r7, r1
	ldr	r5, [sp, #92]
	ldr	r2, [sp, #116]
	umlal	r1, ip, r5, r10
	umlal	r1, ip, fp, r3
	vstrw.u32 q4, [q6, #-220]
	mov	r8, r4
	ldr	r4, [sp, #16]
	str	r6, [sp, #92]
	umlal	r1, ip, r2, r4
	ldr	r2, [sp, #32]
	lsrl	r8, r9, #25
	vbic q4, q1, q0
	umlal	r1, ip, r2, r0
	mov	r2, r6
	ldr	r6, [sp, #4]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #12]
	veor q4, q4, q3
	umlal	r1, ip, r6, r2
	ldr	r6, [sp, #52]
	ldr	r2, [sp, #8]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #40]
	vstrw.u32 q4, [q6, #-204]
	ldr	r2, [sp]
	umlal	r1, ip, r2, r6
	mov	lr, r1
	ldr	r6, [sp, #36]
	ldr	r1, [sp, #44]
	umlal	lr, ip, r6, r1
	vldrw.u32 q0, [q7, #-292]
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	ldr	r6, [sp, #112]
	ldr	r2, [sp, #84]
	umlal	lr, r1, r5, r6
	ldr	r6, [sp, #108]
	vldrw.u32 q1, [q7, #-276]
	umlal	lr, r1, r6, r3
	umlal	lr, r1, fp, r4
	umlal	lr, r1, r2, r0
	ldr	r6, [sp, #4]
	ldr	r2, [sp, #32]
	vldrw.u32 q2, [q7, #-260]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #64]
	umlal	lr, r1, r2, r6
	ldrd	r7, r2, [sp, #8]
	umlal	lr, r1, r7, r2
	vldrw.u32 q5, [q7, #-244]
	ldr	r2, [sp, #88]
	ldr	r7, [sp]
	umlal	lr, r1, r7, r2
	ldrd	r7, r2, [sp, #40]
	umlal	lr, r1, r7, r2
	adds	lr, lr, r8
	vldrw.u32 q3, [q7, #-228]
	adc	r2, r1, r9
	str	lr, [sp, #16]
	str	r2, [sp, #20]
	ldrd	r8, [sp, #16]
	lsrl	r8, r9, #26
	vbic q4, q2, q1
	ldr	r7, [sp, #76]
	ldr	r2, [sp, #116]
	bic	lr, lr, #-67108864
	str	lr, [sp, #112]
	umull	r10, lr, r7, r2
	umlal	r10, lr, r5, fp
	veor q4, q4, q0
	ldr	r2, [sp, #32]
	str	r4, [sp, #16]
	umlal	r10, lr, r2, r3
	ldr	r2, [sp, #92]
	str	r0, [sp, #76]
	umlal	r10, lr, r2, r4
	vstrw.u32 q4, [q6, #-188]
	ldr	r2, [sp, #12]
	ldr	r4, [sp, #4]
	umlal	r10, lr, r0, r2
	ldr	r2, [sp, #52]
	ldr	r0, [sp, #56]
	umlal	r10, lr, r4, r2
	vbic q4, q5, q2
	ldr	r4, [sp, #40]
	ldr	r1, [sp, #36]
	umlal	r10, lr, r6, r4
	ldr	r4, [sp, #36]
	ldr	r6, [sp, #8]
	veor q4, q4, q1
	ldr	r2, [sp]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	adds	r4, r0, r4
	adc	r0, ip, r9
	str	r0, [sp, #60]
	vstrw.u32 q4, [q6, #-172]
	ldr	r0, [sp, #72]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r0
	ldrd	r8, [sp, #56]
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	vbic q4, q3, q5
	str	r4, [r2, #12]
	umull	r4, ip, fp, r7
	ldrd	r2, r6, [sp, #44]
	ldr	r0, [sp, #108]
	lsrl	r8, r9, #25
	veor q4, q4, q2
	umlal	r4, ip, r5, r0
	ldr	r0, [sp, #84]
	umlal	r10, lr, r6, r2
	umlal	r4, ip, r0, r3
	ldr	r2, [sp, #32]
	ldr	r0, [sp, #16]
	vstrw.u32 q4, [q6, #-156]
	ldr	r6, [sp, #64]
	umlal	r4, ip, r2, r0
	ldr	r0, [sp, #76]
	ldr	r2, [sp, #12]
	umlal	r4, ip, r6, r0
	ldr	r6, [sp, #4]
	vbic q4, q0, q3
	lsls	r1, r1, #1
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #88]
	str	r10, [sp, #116]
	veor q4, q4, q5
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #8]
	ldr	r2, [sp, #40]
	umlal	r4, ip, r6, r2
	ldr	r2, [sp]
	ldr	r6, [sp, #72]
	vstrw.u32 q4, [q6, #-140]
	umlal	r4, ip, r2, r1
	ldr	r2, [sp, #44]
	umlal	r4, ip, r6, r2
	adds	r8, r4, r8
	adc	ip, ip, r9
	str	r8, [sp, #56]
	vbic q4, q1, q0
	str	ip, [sp, #60]
	ldrd	r10, [sp, #56]
	lsrl	r10, fp, #26
	ldr	r2, [sp, #80]
	bic	r8, r8, #-67108864
	veor q4, q4, q3
	strd	r10, [sp, #56]
	str	r8, [r2, #16]
	ldr	r4, [sp, #48]
	ldr	r2, [sp, #12]
	lsl	ip, r4, #1
	ldr	r4, [sp, #92]
	vstrw.u32 q4, [q6, #-124]
	ldr	r6, [sp, #4]
	umull	fp, r10, r7, r4
	ldrd	r8, [sp, #56]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r5, r4
	umlal	fp, r10, r3, r2
	vldrw.u32 q0, [q7, #-212]
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #52]
	umlal	fp, r10, r4, r2
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	fp, r10, r0, r4
	vldrw.u32 q1, [q7, #-196]
	ldr	r4, [sp, #36]
	umlal	fp, r10, r6, r4
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #72]
	umlal	fp, r10, r6, r4
	vldrw.u32 q2, [q7, #-180]
	mov	r4, r8
	ldr	r6, [sp, #116]
	adds	r4, r6, r4
	ldr	r6, [sp, #48]
	str	r4, [sp, #56]
	umlal	fp, r10, r2, r6
	vldrw.u32 q5, [q7, #-164]
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	ldr	r6, [sp, #104]
	str	r4, [r2, #20]
	ldr	r2, [sp]
	ldr	r4, [sp, #32]
	vldrw.u32 q3, [q7, #-148]
	umlal	fp, r10, r2, r6
	adc	lr, lr, r9
	ldr	r6, [sp, #68]
	ldr	r2, [sp, #44]
	str	lr, [sp, #60]
	vbic q4, q2, q1
	umull	r4, lr, r4, r7
	ldrd	r8, [sp, #56]
	umlal	fp, r10, r6, r2
	ldr	r2, [sp, #84]
	lsrl	r8, r9, #25
	umlal	r4, lr, r5, r2
	veor q4, q4, q0
	ldr	r2, [sp, #64]
	str	r3, [sp, #32]
	umlal	r4, lr, r2, r3
	ldrd	r2, r3, [sp, #12]
	umlal	r4, lr, r3, r2
	str	fp, [sp, #76]
	vstrw.u32 q4, [q6, #4]
	ldr	r3, [sp, #88]
	ldr	r6, [sp, #4]
	umlal	r4, lr, r0, r3
	ldr	r3, [sp, #40]
	ldr	r2, [sp, #8]
	vbic q4, q5, q2
	umlal	r4, lr, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #72]
	umlal	r4, lr, r6, r1
	umlal	r4, lr, r2, r3
	ldr	r3, [sp]
	veor q4, q4, q1
	ldr	r2, [sp, #44]
	umlal	r4, lr, r3, ip
	ldr	r3, [sp, #104]
	strd	r8, [sp, #56]
	umlal	r4, lr, r3, r2
	adds	r8, r4, r8
	vstrw.u32 q4, [q6, #20]
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, lr, r4
	str	r4, [sp, #28]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	vbic q4, q3, q5
	strd	r2, [sp, #24]
	ldr	r3, [sp, #80]
	ldr	r2, [sp, #52]
	bic	r8, r8, #-67108864
	str	r8, [r3, #24]
	veor q4, q4, q2
	ldr	r3, [sp, #68]
	umull	lr, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #12]
	ldr	r2, [sp, #64]
	umlal	lr, r8, r5, r3
	vstrw.u32 q4, [q6, #36]
	umull	r3, fp, r7, r3
	umlal	r3, fp, r5, r2
	ldr	r4, [sp, #32]
	ldr	r2, [sp, #88]
	ldr	r5, [sp, #40]
	umlal	r3, fp, r4, r2
	vbic q4, q0, q3
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #8]
	umlal	r3, fp, r4, r5
	ldr	r5, [sp, #36]
	veor q4, q4, q5
	umlal	r3, fp, r0, r1
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #72]
	ldr	r1, [sp, #4]
	umlal	lr, r8, r0, r4
	umlal	r3, fp, r1, r4
	vstrw.u32 q4, [q6, #52]
	ldr	r4, [sp, #48]
	ldr	r0, [sp, #104]
	umlal	lr, r8, r1, r4
	umlal	r3, fp, r6, ip
	umlal	lr, r8, r6, r0
	umlal	r3, fp, r2, r0
	vbic q4, q1, q0
	ldr	r6, [sp, #68]
	ldr	r0, [sp, #100]
	umlal	lr, r8, r2, r6
	ldr	r2, [sp]
	ldr	r6, [sp, #76]
	veor q4, q4, q3
	umlal	r3, fp, r2, r9
	mov	ip, r3
	umlal	lr, r8, r2, r0
	ldr	r2, [sp, #44]
	ldr	r5, [sp, #96]
	umlal	ip, fp, r0, r2
	vstrw.u32 q4, [q6, #68]
	ldrd	r0, [sp, #24]
	adds	r4, r6, r0
	umlal	lr, r8, r2, r5
	mov	r2, r4
	adc	r3, r10, r1
	lsrl	r2, r3, #25
	vldrw.u32 q0, [q7, #-132]
	ldr	r7, [sp, #80]
	adds	ip, ip, r2
	bic	r4, r4, #-33554432
	str	r4, [r7, #28]
	mov	r4, ip
	vldrw.u32 q1, [q7, #-116]
	adc	r5, fp, r3
	lsrl	r4, r5, #26
	adds	lr, lr, r4
	mov	r2, lr
	bic	r3, ip, #-67108864
	str	r3, [r7, #32]
	vldrw.u32 q2, [q7, #-100]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r0, r2
	mov	r1, r3
	lsll	r0, r1, #3
	adds	r4, r0, r2
	vldrw.u32 q5, [q7, #-84]
	adc	r5, r1, r3
	adds	r4, r4, r4
	adcs	r5, r5, r5
	adds	r4, r4, r2
	adc	r5, r5, r3
	ldr	r3, [sp, #120]
	vldrw.u32 q3, [q7, #-68]
	ldr	r1, [sp, #112]
	adds	r4, r4, r3
	mov	r2, r4
	adc	r3, r5, #0
	lsrl	r2, r3, #26
	vbic q4, q2, q1
	bic	r4, r4, #-67108864
	str	r4, [r7]
	ldr	r4, [sp, #124]
	bic	r6, lr, #-33554432
	adds	r3, r4, r2
	bic	r2, r3, #-33554432
	veor q4, q4, q0
	add	r1, r1, r3, lsr #25
	strd	r2, r1, [r7, #4]
	str	r6, [r7, #36]
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	vstrw.u32 q4, [q6, #84]
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	vbic q4, q5, q2
	ldr	r7, [r2, #32]
	str	r7, [sp, #100]
	ldr	r7, [r1, #32]
	ldr	r6, [r2, #12]
	str	r7, [sp, #76]
	ldr	r7, [lr, #20]
	veor q4, q4, q1
	ldr	r3, [r2, #4]
	mul	r8, ip, r7
	ldr	r4, [r2, #8]
	str	r6, [sp, #36]
	mul	r2, ip, r6
	str	r7, [sp, #48]
	vstrw.u32 q4, [q6, #100]
	ldr	r6, [r1, #16]
	ldr	r7, [lr, #28]
	str	r6, [sp, #4]
	mov	r6, r7
	ldr	r5, [r1, #36]
	vbic q4, q3, q5
	str	r0, [sp, #80]
	str	r5, [sp, #92]
	mov	r5, r4
	ldr	r0, [lr, #16]
	str	r2, [sp, #112]
	ldr	r2, [r1, #24]
	veor q4, q4, q2
	str	r8, [sp, #108]
	str	r2, [sp, #16]
	add	r2, r0, r0, lsl #3
	add	r10, r0, r2, lsl #1
	ldr	r2, [lr, #24]
	mul	r8, ip, r6
	vstrw.u32 q4, [q6, #116]
	add	r7, r2, r2, lsl #3
	add	fp, r2, r7, lsl #1
	ldr	r7, [r1, #12]
	add	r4, r4, r4, lsl #3
	str	r5, [sp, #40]
	add	r4, r5, r4, lsl #1
	vbic q4, q0, q3
	str	r3, [sp, #52]
	mul	r5, ip, r3
	str	r0, [sp, #72]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	veor q4, q4, q5
	str	r2, [sp, #104]
	str	r6, [sp, #68]
	str	r8, [sp, #84]
	str	r7, [sp, #24]
	ldr	r2, [lr, #36]
	ldr	r7, [r1, #8]
	vstrw.u32 q4, [q6, #132]
	mul	ip, ip, r2
	str	r7, [sp, #8]
	ldr	r7, [lr]
	str	r2, [sp, #96]
	ldr	r2, [r1, #4]
	str	r7, [sp, #12]
	vbic q4, q1, q0
	ldr	r7, [sp, #100]
	str	r2, [sp]
	ldr	r2, [r1]
	ldr	r1, [sp, #36]
	str	ip, [sp, #64]
	veor q4, q4, q3
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #76]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #32]
	vstrw.u32 q4, [q6, #148]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #92]
	mov	r6, r3
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	umlal	lr, ip, r10, r3
	vldrw.u32 q0, [q7, #-52]
	ldr	r3, [sp, #92]
	ldr	r7, [sp, #8]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r4, [sp, #112]
	vldrw.u32 q1, [q7, #-36]
	ldr	r5, [sp, #108]
	umlal	r8, r1, r4, r6
	ldr	r4, [sp, #16]
	mov	r3, r6
	umlal	r8, r1, r10, r4
	umlal	r8, r1, r5, r0
	vldrw.u32 q2, [q7, #-20]
	ldr	r6, [sp, #4]
	ldr	r5, [sp, #84]
	umlal	r8, r1, fp, r6
	ldr	r6, [sp, #24]
	umlal	r8, r1, r5, r6
	ldr	r6, [sp, #32]
	vldrw.u32 q5, [q7, #-4]
	ldr	r5, [sp]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #64]
	umlal	r8, r1, r6, r5
	ldr	r6, [sp, #12]
	vldrw.u32 q3, [q7, #12]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #48]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	umlal	lr, ip, r1, r4
	vbic q4, q2, q1
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	umlal	lr, ip, fp, r0
	str	r8, [sp, #120]
	ldr	r4, [sp, #68]
	ldr	r6, [sp, #4]
	veor q4, q4, q0
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r6
	ldr	r5, [sp, #32]
	ldr	r6, [sp, #24]
	str	r8, [sp, #116]
	vstrw.u32 q4, [q6, #164]
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	ldr	r5, [sp, #96]
	strd	r6, [sp, #56]
	vbic q4, q5, q2
	add	r8, r5, r5, lsl #3
	add	r8, r5, r8, lsl #1
	mov	r6, r8
	ldr	r7, [sp, #8]
	ldr	r5, [sp, #12]
	umlal	lr, ip, r8, r7
	veor q4, q4, q1
	ldr	r4, [sp]
	str	r2, [sp, #44]
	umlal	lr, ip, r4, r5
	ldr	r4, [sp, #52]
	ldr	r7, [sp, #76]
	umlal	lr, ip, r4, r2
	vstrw.u32 q4, [q6, #180]
	lsls	r4, r4, #1
	str	r4, [sp, #88]
	ldr	r4, [sp, #56]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	vbic q4, q3, q5
	adc	r9, ip, r2
	bic	ip, r4, #-33554432
	str	ip, [sp, #124]
	umull	r1, ip, r7, r1
	ldr	r5, [sp, #92]
	ldr	r2, [sp, #116]
	veor q4, q4, q2
	umlal	r1, ip, r5, r10
	umlal	r1, ip, fp, r3
	mov	r8, r4
	ldr	r4, [sp, #16]
	str	r6, [sp, #92]
	umlal	r1, ip, r2, r4
	vstrw.u32 q4, [q6, #196]
	ldr	r2, [sp, #32]
	lsrl	r8, r9, #25
	umlal	r1, ip, r2, r0
	mov	r2, r6
	ldr	r6, [sp, #4]
	vbic q4, q0, q3
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #12]
	umlal	r1, ip, r6, r2
	ldr	r6, [sp, #52]
	ldr	r2, [sp, #8]
	veor q4, q4, q5
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #40]
	ldr	r2, [sp]
	umlal	r1, ip, r2, r6
	mov	lr, r1
	ldr	r6, [sp, #36]
	vstrw.u32 q4, [q6, #212]
	ldr	r1, [sp, #44]
	umlal	lr, ip, r6, r1
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	ldr	r6, [sp, #112]
	ldr	r2, [sp, #84]
	vbic q4, q1, q0
	umlal	lr, r1, r5, r6
	ldr	r6, [sp, #108]
	umlal	lr, r1, r6, r3
	umlal	lr, r1, fp, r4
	umlal	lr, r1, r2, r0
	veor q4, q4, q3
	ldr	r6, [sp, #4]
	ldr	r2, [sp, #32]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #64]
	umlal	lr, r1, r2, r6
	vstrw.u32 q4, [q6, #228]
	ldrd	r7, r2, [sp, #8]
	umlal	lr, r1, r7, r2
	ldr	r2, [sp, #88]
	ldr	r7, [sp]
	umlal	lr, r1, r7, r2
	ldrd	r7, r2, [sp, #40]
	vldrw.u32 q0, [q7, #28]
	umlal	lr, r1, r7, r2
	adds	lr, lr, r8
	adc	r2, r1, r9
	str	lr, [sp, #16]
	str	r2, [sp, #20]
	vldrw.u32 q1, [q7, #44]
	ldrd	r8, [sp, #16]
	lsrl	r8, r9, #26
	ldr	r7, [sp, #76]
	ldr	r2, [sp, #116]
	bic	lr, lr, #-67108864
	str	lr, [sp, #112]
	vldrw.u32 q2, [q7, #60]
	umull	r10, lr, r7, r2
	umlal	r10, lr, r5, fp
	ldr	r2, [sp, #32]
	str	r4, [sp, #16]
	umlal	r10, lr, r2, r3
	ldr	r2, [sp, #92]
	vldrw.u32 q5, [q7, #76]
	str	r0, [sp, #76]
	umlal	r10, lr, r2, r4
	ldr	r2, [sp, #12]
	ldr	r4, [sp, #4]
	umlal	r10, lr, r0, r2
	vldrw.u32 q3, [q7, #92]
	ldr	r2, [sp, #52]
	ldr	r0, [sp, #56]
	umlal	r10, lr, r4, r2
	ldr	r4, [sp, #40]
	ldr	r1, [sp, #36]
	umlal	r10, lr, r6, r4
	vbic q4, q2, q1
	ldr	r4, [sp, #36]
	ldr	r6, [sp, #8]
	ldr	r2, [sp]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	adds	r4, r0, r4
	veor q4, q4, q0
	adc	r0, ip, r9
	str	r0, [sp, #60]
	ldr	r0, [sp, #72]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r0
	vstrw.u32 q4, [q6, #244]
	ldrd	r8, [sp, #56]
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	str	r4, [r2, #12]
	umull	r4, ip, fp, r7
	ldrd	r2, r6, [sp, #44]
	vbic q4, q5, q2
	ldr	r0, [sp, #108]
	lsrl	r8, r9, #25
	umlal	r4, ip, r5, r0
	ldr	r0, [sp, #84]
	umlal	r10, lr, r6, r2
	umlal	r4, ip, r0, r3
	veor q4, q4, q1
	ldr	r2, [sp, #32]
	ldr	r0, [sp, #16]
	ldr	r6, [sp, #64]
	umlal	r4, ip, r2, r0
	ldr	r0, [sp, #76]
	ldr	r2, [sp, #12]
	vstrw.u32 q4, [q6, #260]
	umlal	r4, ip, r6, r0
	ldr	r6, [sp, #4]
	lsls	r1, r1, #1
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #24]
	vbic q4, q3, q5
	ldr	r2, [sp, #88]
	str	r10, [sp, #116]
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #8]
	ldr	r2, [sp, #40]
	umlal	r4, ip, r6, r2
	veor q4, q4, q2
	ldr	r2, [sp]
	ldr	r6, [sp, #72]
	umlal	r4, ip, r2, r1
	ldr	r2, [sp, #44]
	umlal	r4, ip, r6, r2
	adds	r8, r4, r8
	vstrw.u32 q4, [q6, #276]
	adc	ip, ip, r9
	str	r8, [sp, #56]
	str	ip, [sp, #60]
	ldrd	r10, [sp, #56]
	lsrl	r10, fp, #26
	vbic q4, q0, q3
	ldr	r2, [sp, #80]
	bic	r8, r8, #-67108864
	strd	r10, [sp, #56]
	str	r8, [r2, #16]
	ldr	r4, [sp, #48]
	ldr	r2, [sp, #12]
	veor q4, q4, q5
	lsl	ip, r4, #1
	ldr	r4, [sp, #92]
	ldr	r6, [sp, #4]
	umull	fp, r10, r7, r4
	ldrd	r8, [sp, #56]
	ldr	r4, [sp, #32]
	vstrw.u32 q4, [q6, #292]
	umlal	fp, r10, r5, r4
	umlal	fp, r10, r3, r2
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #52]
	umlal	fp, r10, r4, r2
	vbic q4, q1, q0
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	fp, r10, r0, r4
	ldr	r4, [sp, #36]
	umlal	fp, r10, r6, r4
	ldr	r6, [sp, #24]
	veor q4, q4, q3
	ldr	r4, [sp, #72]
	umlal	fp, r10, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #116]
	adds	r4, r6, r4
	ldr	r6, [sp, #48]
	vstrw.u32 q4, [q6, #308]
	str	r4, [sp, #56]
	umlal	fp, r10, r2, r6
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	ldr	r6, [sp, #104]
	str	r4, [r2, #20]
	vldrw.u32 q0, [q7, #108]
	ldr	r2, [sp]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r2, r6
	adc	lr, lr, r9
	ldr	r6, [sp, #68]
	vldrw.u32 q1, [q7, #124]
	ldr	r2, [sp, #44]
	str	lr, [sp, #60]
	umull	r4, lr, r4, r7
	ldrd	r8, [sp, #56]
	umlal	fp, r10, r6, r2
	ldr	r2, [sp, #84]
	vldrw.u32 q2, [q7, #140]
	lsrl	r8, r9, #25
	umlal	r4, lr, r5, r2
	ldr	r2, [sp, #64]
	str	r3, [sp, #32]
	umlal	r4, lr, r2, r3
	ldrd	r2, r3, [sp, #12]
	vldrw.u32 q5, [q7, #156]
	umlal	r4, lr, r3, r2
	str	fp, [sp, #76]
	ldr	r3, [sp, #88]
	ldr	r6, [sp, #4]
	umlal	r4, lr, r0, r3
	vldrw.u32 q3, [q7, #172]
	ldr	r3, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	r4, lr, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #72]
	umlal	r4, lr, r6, r1
	vbic q4, q2, q1
	umlal	r4, lr, r2, r3
	ldr	r3, [sp]
	ldr	r2, [sp, #44]
	umlal	r4, lr, r3, ip
	ldr	r3, [sp, #104]
	strd	r8, [sp, #56]
	veor q4, q4, q0
	umlal	r4, lr, r3, r2
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, lr, r4
	vstrw.u32 q4, [q6, #324]
	str	r4, [sp, #28]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #80]
	ldr	r2, [sp, #52]
	vbic q4, q5, q2
	bic	r8, r8, #-67108864
	str	r8, [r3, #24]
	ldr	r3, [sp, #68]
	umull	lr, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #12]
	veor q4, q4, q1
	ldr	r2, [sp, #64]
	umlal	lr, r8, r5, r3
	umull	r3, fp, r7, r3
	umlal	r3, fp, r5, r2
	ldr	r4, [sp, #32]
	vstrw.u32 q4, [q6, #340]
	ldr	r2, [sp, #88]
	ldr	r5, [sp, #40]
	umlal	r3, fp, r4, r2
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #8]
	vbic q4, q3, q5
	umlal	r3, fp, r4, r5
	ldr	r5, [sp, #36]
	umlal	r3, fp, r0, r1
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #72]
	ldr	r1, [sp, #4]
	veor q4, q4, q2
	umlal	lr, r8, r0, r4
	umlal	r3, fp, r1, r4
	ldr	r4, [sp, #48]
	ldr	r0, [sp, #104]
	umlal	lr, r8, r1, r4
	umlal	r3, fp, r6, ip
	vstrw.u32 q4, [q6, #356]
	umlal	lr, r8, r6, r0
	umlal	r3, fp, r2, r0
	ldr	r6, [sp, #68]
	ldr	r0, [sp, #100]
	umlal	lr, r8, r2, r6
	vbic q4, q0, q3
	ldr	r2, [sp]
	ldr	r6, [sp, #76]
	umlal	r3, fp, r2, r9
	mov	ip, r3
	umlal	lr, r8, r2, r0
	ldr	r2, [sp, #44]
	veor q4, q4, q5
	ldr	r5, [sp, #96]
	umlal	ip, fp, r0, r2
	ldrd	r0, [sp, #24]
	adds	r4, r6, r0
	umlal	lr, r8, r2, r5
	mov	r2, r4
	vstrw.u32 q4, [q6, #372]
	adc	r3, r10, r1
	lsrl	r2, r3, #25
	ldr	r7, [sp, #80]
	adds	ip, ip, r2
	bic	r4, r4, #-33554432
	vbic q4, q1, q0
	str	r4, [r7, #28]
	mov	r4, ip
	adc	r5, fp, r3
	lsrl	r4, r5, #26
	adds	lr, lr, r4
	mov	r2, lr
	veor q4, q4, q3
	bic	r3, ip, #-67108864
	str	r3, [r7, #32]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r0, r2
	mov	r1, r3
	vstrw.u32 q4, [q6, #388]
	lsll	r0, r1, #3
	adds	r4, r0, r2
	adc	r5, r1, r3
	adds	r4, r4, r4
	adcs	r5, r5, r5
	vmov.i32 q0, #1
	adds	r4, r4, r2
	adc	r5, r5, r3
	ldr	r3, [sp, #120]
	ldr	r1, [sp, #112]
	adds	r4, r4, r3
	mov	r2, r4
	vldrw.u32 q1, [q6, #-508]
	adc	r3, r5, #0
	lsrl	r2, r3, #26
	bic	r4, r4, #-67108864
	str	r4, [r7]
	ldr	r4, [sp, #124]
	bic	r6, lr, #-33554432
	veor q1, q1, q0
	adds	r3, r4, r2
	bic	r2, r3, #-33554432
	add	r1, r1, r3, lsr #25
	strd	r2, r1, [r7, #4]
	str	r6, [r7, #36]
	vstrw.u32 q1, [q6, #-508]
	ldr r0, [sp, #132]
	subs r0, r0, #1
	str r0, [sp, #132]
	bne 1b
	add sp, sp, #140
	vpop {d8-d15}
	pop {r4-r11, pc}

// expt_m4_seq
.global expt_m4_seq
.type expt_m4_seq, %function
.thumb_func
.balign 16
expt_m4_seq:
	push {r4-r11, lr}
	vpush {d8-d15}
	sub sp, sp, #140
	str r0, [sp, #132]
	movw r1, #:lower16:g_mve
	movt r1, #:upper16:g_mve
	adr r2, 2f
	b 3f
	.balign 16
2:	.word 0, 4, 8, 12
3:
	vldrw.u32 q6, [r2]
	add r3, r1, #1524
	vadd.i32 q7, q6, r3
	add r3, r1, #508
	vadd.i32 q6, q6, r3
.balign 16
1:
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
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
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
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
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
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
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
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
	vldrw.u32 q0, [q6, #-508]
	vldrw.u32 q1, [q6, #-428]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-348]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-268]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-188]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #188]
	vldrw.u32 q0, [q6, #-492]
	vldrw.u32 q1, [q6, #-412]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-332]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-252]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-172]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #204]
	vldrw.u32 q0, [q6, #-476]
	vldrw.u32 q1, [q6, #-396]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-316]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-236]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-156]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #220]
	vldrw.u32 q0, [q6, #-460]
	vldrw.u32 q1, [q6, #-380]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-300]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-220]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-140]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #236]
	vldrw.u32 q0, [q6, #-444]
	vldrw.u32 q1, [q6, #-364]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-284]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-204]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #-124]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #252]
	vldrw.u32 q0, [q6, #4]
	vldrw.u32 q1, [q6, #84]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #164]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #244]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #324]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #268]
	vldrw.u32 q0, [q6, #20]
	vldrw.u32 q1, [q6, #100]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #180]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #260]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #340]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #284]
	vldrw.u32 q0, [q6, #36]
	vldrw.u32 q1, [q6, #116]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #196]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #276]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #356]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #300]
	vldrw.u32 q0, [q6, #52]
	vldrw.u32 q1, [q6, #132]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #212]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #292]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #372]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #316]
	vldrw.u32 q0, [q6, #68]
	vldrw.u32 q1, [q6, #148]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #228]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #308]
	veor q0, q0, q1
	vldrw.u32 q1, [q6, #388]
	veor q0, q0, q1
	vstrw.u32 q0, [q7, #332]
	vldrw.u32 q0, [q7, #284]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #252]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #348]
	vldrw.u32 q0, [q7, #204]
	vldrw.u32 q2, [q7, #332]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #428]
	vldrw.u32 q0, [q7, #300]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #188]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #364]
	vldrw.u32 q0, [q7, #220]
	vldrw.u32 q2, [q7, #268]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #444]
	vldrw.u32 q0, [q7, #316]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #204]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #380]
	vldrw.u32 q0, [q7, #236]
	vldrw.u32 q2, [q7, #284]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #460]
	vldrw.u32 q0, [q7, #332]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #220]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #396]
	vldrw.u32 q0, [q7, #252]
	vldrw.u32 q2, [q7, #300]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #476]
	vldrw.u32 q0, [q7, #268]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [q7, #236]
	veor q1, q1, q2
	vstrw.u32 q1, [q7, #412]
	vldrw.u32 q0, [q7, #188]
	vldrw.u32 q2, [q7, #316]
	veor q0, q0, q2
	vstrw.u32 q0, [q7, #492]
	vldrw.u32 q3, [q7, #348]
	vldrw.u32 q4, [q7, #428]
	vldrw.u32 q0, [q6, #-508]
	vldrw.u32 q1, [q6, #4]
	veor q0, q0, q3
	veor q1, q1, q4
	vorr q2, q0, q0
	vstrw.u32 q2, [q6, #404]
	vorr q5, q1, q1
	vstrw.u32 q5, [q7, #-212]
	vldrw.u32 q0, [q6, #-428]
	vldrw.u32 q1, [q6, #84]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #18
	vsri.32 q2, q0, #14
	vstrw.u32 q2, [q7, #-356]
	vshl.i32 q5, q1, #18
	vsri.32 q5, q1, #14
	vstrw.u32 q5, [q7, #44]
	vldrw.u32 q0, [q6, #-348]
	vldrw.u32 q1, [q6, #164]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #2
	vsri.32 q2, q1, #30
	vstrw.u32 q2, [q7, #-500]
	vshl.i32 q5, q0, #1
	vsri.32 q5, q0, #31
	vstrw.u32 q5, [q7, #-100]
	vldrw.u32 q0, [q6, #-268]
	vldrw.u32 q1, [q6, #244]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #21
	vsri.32 q2, q1, #11
	vstrw.u32 q2, [q7, #-244]
	vshl.i32 q5, q0, #20
	vsri.32 q5, q0, #12
	vstrw.u32 q5, [q7, #156]
	vldrw.u32 q0, [q6, #-188]
	vldrw.u32 q1, [q6, #324]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #9
	vsri.32 q2, q0, #23
	vstrw.u32 q2, [q7, #-388]
	vshl.i32 q5, q1, #9
	vsri.32 q5, q1, #23
	vstrw.u32 q5, [q7, #12]
	vldrw.u32 q3, [q7, #364]
	vldrw.u32 q4, [q7, #444]
	vldrw.u32 q0, [q6, #-492]
	vldrw.u32 q1, [q6, #20]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #1
	vsri.32 q2, q1, #31
	vstrw.u32 q2, [q7, #-452]
	vorr q5, q0, q0
	vstrw.u32 q5, [q7, #-52]
	vldrw.u32 q0, [q6, #-412]
	vldrw.u32 q1, [q6, #100]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #22
	vsri.32 q2, q0, #10
	vstrw.u32 q2, [q6, #420]
	vshl.i32 q5, q1, #22
	vsri.32 q5, q1, #10
	vstrw.u32 q5, [q7, #-196]
	vldrw.u32 q0, [q6, #-332]
	vldrw.u32 q1, [q6, #180]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #5
	vsri.32 q2, q0, #27
	vstrw.u32 q2, [q7, #-340]
	vshl.i32 q5, q1, #5
	vsri.32 q5, q1, #27
	vstrw.u32 q5, [q7, #60]
	vldrw.u32 q0, [q6, #-252]
	vldrw.u32 q1, [q6, #260]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #23
	vsri.32 q2, q1, #9
	vstrw.u32 q2, [q7, #-484]
	vshl.i32 q5, q0, #22
	vsri.32 q5, q0, #10
	vstrw.u32 q5, [q7, #-84]
	vldrw.u32 q0, [q6, #-172]
	vldrw.u32 q1, [q6, #340]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #1
	vsri.32 q2, q0, #31
	vstrw.u32 q2, [q7, #-228]
	vshl.i32 q5, q1, #1
	vsri.32 q5, q1, #31
	vstrw.u32 q5, [q7, #172]
	vldrw.u32 q3, [q7, #380]
	vldrw.u32 q4, [q7, #460]
	vldrw.u32 q0, [q6, #-476]
	vldrw.u32 q1, [q6, #36]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #31
	vsri.32 q2, q0, #1
	vstrw.u32 q2, [q7, #-292]
	vshl.i32 q5, q1, #31
	vsri.32 q5, q1, #1
	vstrw.u32 q5, [q7, #108]
	vldrw.u32 q0, [q6, #-396]
	vldrw.u32 q1, [q6, #116]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #3
	vsri.32 q2, q0, #29
	vstrw.u32 q2, [q7, #-436]
	vshl.i32 q5, q1, #3
	vsri.32 q5, q1, #29
	vstrw.u32 q5, [q7, #-36]
	vldrw.u32 q0, [q6, #-316]
	vldrw.u32 q1, [q6, #196]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #22
	vsri.32 q2, q1, #10
	vstrw.u32 q2, [q6, #436]
	vshl.i32 q5, q0, #21
	vsri.32 q5, q0, #11
	vstrw.u32 q5, [q7, #-180]
	vldrw.u32 q0, [q6, #-236]
	vldrw.u32 q1, [q6, #276]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #8
	vsri.32 q2, q1, #24
	vstrw.u32 q2, [q7, #-324]
	vshl.i32 q5, q0, #7
	vsri.32 q5, q0, #25
	vstrw.u32 q5, [q7, #76]
	vldrw.u32 q0, [q6, #-156]
	vldrw.u32 q1, [q6, #356]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #31
	vsri.32 q2, q1, #1
	vstrw.u32 q2, [q7, #-468]
	vshl.i32 q5, q0, #30
	vsri.32 q5, q0, #2
	vstrw.u32 q5, [q7, #-68]
	vldrw.u32 q3, [q7, #396]
	vldrw.u32 q4, [q7, #476]
	vldrw.u32 q0, [q6, #-460]
	vldrw.u32 q1, [q6, #52]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #14
	vsri.32 q2, q0, #18
	vstrw.u32 q2, [q6, #484]
	vshl.i32 q5, q1, #14
	vsri.32 q5, q1, #18
	vstrw.u32 q5, [q7, #-132]
	vldrw.u32 q0, [q6, #-380]
	vldrw.u32 q1, [q6, #132]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #28
	vsri.32 q2, q1, #4
	vstrw.u32 q2, [q7, #-276]
	vshl.i32 q5, q0, #27
	vsri.32 q5, q0, #5
	vstrw.u32 q5, [q7, #124]
	vldrw.u32 q0, [q6, #-300]
	vldrw.u32 q1, [q6, #212]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #13
	vsri.32 q2, q1, #19
	vstrw.u32 q2, [q7, #-420]
	vshl.i32 q5, q0, #12
	vsri.32 q5, q0, #20
	vstrw.u32 q5, [q7, #-20]
	vldrw.u32 q0, [q6, #-220]
	vldrw.u32 q1, [q6, #292]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #11
	vsri.32 q2, q1, #21
	vstrw.u32 q2, [q6, #452]
	vshl.i32 q5, q0, #10
	vsri.32 q5, q0, #22
	vstrw.u32 q5, [q7, #-164]
	vldrw.u32 q0, [q6, #-140]
	vldrw.u32 q1, [q6, #372]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #28
	vsri.32 q2, q0, #4
	vstrw.u32 q2, [q7, #-308]
	vshl.i32 q5, q1, #28
	vsri.32 q5, q1, #4
	vstrw.u32 q5, [q7, #92]
	vldrw.u32 q3, [q7, #412]
	vldrw.u32 q4, [q7, #492]
	vldrw.u32 q0, [q6, #-444]
	vldrw.u32 q1, [q6, #68]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #14
	vsri.32 q2, q1, #18
	vstrw.u32 q2, [q7, #-372]
	vshl.i32 q5, q0, #13
	vsri.32 q5, q0, #19
	vstrw.u32 q5, [q7, #28]
	vldrw.u32 q0, [q6, #-364]
	vldrw.u32 q1, [q6, #148]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #10
	vsri.32 q2, q0, #22
	vstrw.u32 q2, [q6, #500]
	vshl.i32 q5, q1, #10
	vsri.32 q5, q1, #22
	vstrw.u32 q5, [q7, #-116]
	vldrw.u32 q0, [q6, #-284]
	vldrw.u32 q1, [q6, #228]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q1, #20
	vsri.32 q2, q1, #12
	vstrw.u32 q2, [q7, #-260]
	vshl.i32 q5, q0, #19
	vsri.32 q5, q0, #13
	vstrw.u32 q5, [q7, #140]
	vldrw.u32 q0, [q6, #-204]
	vldrw.u32 q1, [q6, #308]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #4
	vsri.32 q2, q0, #28
	vstrw.u32 q2, [q7, #-404]
	vshl.i32 q5, q1, #4
	vsri.32 q5, q1, #28
	vstrw.u32 q5, [q7, #-4]
	vldrw.u32 q0, [q6, #-124]
	vldrw.u32 q1, [q6, #388]
	veor q0, q0, q3
	veor q1, q1, q4
	vshl.i32 q2, q0, #7
	vsri.32 q2, q0, #25
	vstrw.u32 q2, [q6, #468]
	vshl.i32 q5, q1, #7
	vsri.32 q5, q1, #25
	vstrw.u32 q5, [q7, #-148]
	vldrw.u32 q0, [q6, #404]
	vldrw.u32 q1, [q6, #420]
	vldrw.u32 q2, [q6, #436]
	vldrw.u32 q5, [q6, #452]
	vldrw.u32 q3, [q6, #468]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-508]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-492]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-476]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-460]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-444]
	vldrw.u32 q0, [q6, #484]
	vldrw.u32 q1, [q6, #500]
	vldrw.u32 q2, [q7, #-500]
	vldrw.u32 q5, [q7, #-484]
	vldrw.u32 q3, [q7, #-468]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-428]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-412]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-396]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-380]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-364]
	vldrw.u32 q0, [q7, #-452]
	vldrw.u32 q1, [q7, #-436]
	vldrw.u32 q2, [q7, #-420]
	vldrw.u32 q5, [q7, #-404]
	vldrw.u32 q3, [q7, #-388]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-348]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-332]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-316]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-300]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-284]
	vldrw.u32 q0, [q7, #-372]
	vldrw.u32 q1, [q7, #-356]
	vldrw.u32 q2, [q7, #-340]
	vldrw.u32 q5, [q7, #-324]
	vldrw.u32 q3, [q7, #-308]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-268]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-252]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-236]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-220]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-204]
	vldrw.u32 q0, [q7, #-292]
	vldrw.u32 q1, [q7, #-276]
	vldrw.u32 q2, [q7, #-260]
	vldrw.u32 q5, [q7, #-244]
	vldrw.u32 q3, [q7, #-228]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #-188]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #-172]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #-156]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #-140]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #-124]
	vldrw.u32 q0, [q7, #-212]
	vldrw.u32 q1, [q7, #-196]
	vldrw.u32 q2, [q7, #-180]
	vldrw.u32 q5, [q7, #-164]
	vldrw.u32 q3, [q7, #-148]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #4]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #20]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #36]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #52]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #68]
	vldrw.u32 q0, [q7, #-132]
	vldrw.u32 q1, [q7, #-116]
	vldrw.u32 q2, [q7, #-100]
	vldrw.u32 q5, [q7, #-84]
	vldrw.u32 q3, [q7, #-68]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #84]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #100]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #116]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #132]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #148]
	vldrw.u32 q0, [q7, #-52]
	vldrw.u32 q1, [q7, #-36]
	vldrw.u32 q2, [q7, #-20]
	vldrw.u32 q5, [q7, #-4]
	vldrw.u32 q3, [q7, #12]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #164]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #180]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #196]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #212]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #228]
	vldrw.u32 q0, [q7, #28]
	vldrw.u32 q1, [q7, #44]
	vldrw.u32 q2, [q7, #60]
	vldrw.u32 q5, [q7, #76]
	vldrw.u32 q3, [q7, #92]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #244]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #260]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #276]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #292]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #308]
	vldrw.u32 q0, [q7, #108]
	vldrw.u32 q1, [q7, #124]
	vldrw.u32 q2, [q7, #140]
	vldrw.u32 q5, [q7, #156]
	vldrw.u32 q3, [q7, #172]
	vbic q4, q2, q1
	veor q4, q4, q0
	vstrw.u32 q4, [q6, #324]
	vbic q4, q5, q2
	veor q4, q4, q1
	vstrw.u32 q4, [q6, #340]
	vbic q4, q3, q5
	veor q4, q4, q2
	vstrw.u32 q4, [q6, #356]
	vbic q4, q0, q3
	veor q4, q4, q5
	vstrw.u32 q4, [q6, #372]
	vbic q4, q1, q0
	veor q4, q4, q3
	vstrw.u32 q4, [q6, #388]
	vmov.i32 q0, #1
	vldrw.u32 q1, [q6, #-508]
	veor q1, q1, q0
	vstrw.u32 q1, [q6, #-508]
	ldr r0, [sp, #132]
	subs r0, r0, #1
	str r0, [sp, #132]
	bne 1b
	add sp, sp, #140
	vpop {d8-d15}
	pop {r4-r11, pc}

// expt_m4_stitch
.global expt_m4_stitch
.type expt_m4_stitch, %function
.thumb_func
.balign 16
expt_m4_stitch:
	push {r4-r11, lr}
	vpush {d8-d15}
	sub sp, sp, #140
	str r0, [sp, #132]
	movw r1, #:lower16:g_mve
	movt r1, #:upper16:g_mve
	adr r2, 2f
	b 3f
	.balign 16
2:	.word 0, 4, 8, 12
3:
	vldrw.u32 q6, [r2]
	add r3, r1, #1524
	vadd.i32 q7, q6, r3
	add r3, r1, #508
	vadd.i32 q6, q6, r3
.balign 16
1:
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	vldrw.u32 q0, [q6, #-508]
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	vldrw.u32 q1, [q6, #-428]
	mov	lr, r2
	mov	ip, #38
	ldr	r7, [r2, #32]
	veor q0, q0, q1
	str	r7, [sp, #100]
	ldr	r7, [r1, #32]
	ldr	r6, [r2, #12]
	vldrw.u32 q1, [q6, #-348]
	str	r7, [sp, #76]
	ldr	r7, [lr, #20]
	ldr	r3, [r2, #4]
	veor q0, q0, q1
	mul	r8, ip, r7
	ldr	r4, [r2, #8]
	str	r6, [sp, #36]
	vldrw.u32 q1, [q6, #-268]
	mul	r2, ip, r6
	str	r7, [sp, #48]
	veor q0, q0, q1
	ldr	r6, [r1, #16]
	ldr	r7, [lr, #28]
	str	r6, [sp, #4]
	vldrw.u32 q1, [q6, #-188]
	mov	r6, r7
	ldr	r5, [r1, #36]
	str	r0, [sp, #80]
	veor q0, q0, q1
	str	r5, [sp, #92]
	mov	r5, r4
	ldr	r0, [lr, #16]
	vstrw.u32 q0, [q7, #188]
	str	r2, [sp, #112]
	ldr	r2, [r1, #24]
	str	r8, [sp, #108]
	vldrw.u32 q0, [q6, #-492]
	str	r2, [sp, #16]
	add	r2, r0, r0, lsl #3
	add	r10, r0, r2, lsl #1
	vldrw.u32 q1, [q6, #-412]
	ldr	r2, [lr, #24]
	mul	r8, ip, r6
	add	r7, r2, r2, lsl #3
	veor q0, q0, q1
	add	fp, r2, r7, lsl #1
	ldr	r7, [r1, #12]
	vldrw.u32 q1, [q6, #-332]
	add	r4, r4, r4, lsl #3
	str	r5, [sp, #40]
	add	r4, r5, r4, lsl #1
	veor q0, q0, q1
	str	r3, [sp, #52]
	mul	r5, ip, r3
	str	r0, [sp, #72]
	vldrw.u32 q1, [q6, #-252]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #104]
	veor q0, q0, q1
	str	r6, [sp, #68]
	str	r8, [sp, #84]
	str	r7, [sp, #24]
	vldrw.u32 q1, [q6, #-172]
	ldr	r2, [lr, #36]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	veor q0, q0, q1
	str	r7, [sp, #8]
	ldr	r7, [lr]
	vstrw.u32 q0, [q7, #204]
	str	r2, [sp, #96]
	ldr	r2, [r1, #4]
	str	r7, [sp, #12]
	vldrw.u32 q0, [q6, #-476]
	ldr	r7, [sp, #100]
	str	r2, [sp]
	ldr	r2, [r1]
	vldrw.u32 q1, [q6, #-396]
	ldr	r1, [sp, #36]
	str	ip, [sp, #64]
	add	ip, r7, r7, lsl #3
	veor q0, q0, q1
	add	ip, r7, ip, lsl #1
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #76]
	vldrw.u32 q1, [q6, #-316]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #32]
	umull	lr, ip, lr, r7
	veor q0, q0, q1
	ldr	r1, [sp, #92]
	mov	r6, r3
	umlal	lr, ip, r1, r4
	vldrw.u32 q1, [q6, #-236]
	umull	r4, r1, r4, r7
	umlal	lr, ip, r10, r3
	veor q0, q0, q1
	ldr	r3, [sp, #92]
	ldr	r7, [sp, #8]
	umlal	r4, r1, r3, r5
	vldrw.u32 q1, [q6, #-156]
	mov	r8, r4
	ldr	r4, [sp, #112]
	ldr	r5, [sp, #108]
	veor q0, q0, q1
	umlal	r8, r1, r4, r6
	ldr	r4, [sp, #16]
	mov	r3, r6
	vstrw.u32 q0, [q7, #220]
	umlal	r8, r1, r10, r4
	umlal	r8, r1, r5, r0
	ldr	r6, [sp, #4]
	vldrw.u32 q0, [q6, #-460]
	ldr	r5, [sp, #84]
	umlal	r8, r1, fp, r6
	ldr	r6, [sp, #24]
	vldrw.u32 q1, [q6, #-380]
	umlal	r8, r1, r5, r6
	ldr	r6, [sp, #32]
	veor q0, q0, q1
	ldr	r5, [sp]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #64]
	vldrw.u32 q1, [q6, #-300]
	umlal	r8, r1, r6, r5
	ldr	r6, [sp, #12]
	umlal	r8, r1, r6, r2
	veor q0, q0, q1
	ldr	r6, [sp, #48]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	vldrw.u32 q1, [q6, #-220]
	add	r1, r6, r1, lsl #1
	umlal	lr, ip, r1, r4
	str	r8, [sp, #56]
	veor q0, q0, q1
	bic	r8, r8, #-67108864
	umlal	lr, ip, fp, r0
	str	r8, [sp, #120]
	vldrw.u32 q1, [q6, #-140]
	ldr	r4, [sp, #68]
	ldr	r6, [sp, #4]
	add	r8, r4, r4, lsl #3
	veor q0, q0, q1
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r6
	vstrw.u32 q0, [q7, #236]
	ldr	r5, [sp, #32]
	ldr	r6, [sp, #24]
	str	r8, [sp, #116]
	vldrw.u32 q0, [q6, #-444]
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	vldrw.u32 q1, [q6, #-364]
	ldr	r5, [sp, #96]
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	veor q0, q0, q1
	add	r8, r5, r8, lsl #1
	mov	r6, r8
	ldr	r7, [sp, #8]
	vldrw.u32 q1, [q6, #-284]
	ldr	r5, [sp, #12]
	umlal	lr, ip, r8, r7
	ldr	r4, [sp]
	veor q0, q0, q1
	str	r2, [sp, #44]
	umlal	lr, ip, r4, r5
	vldrw.u32 q1, [q6, #-204]
	ldr	r4, [sp, #52]
	ldr	r7, [sp, #76]
	umlal	lr, ip, r4, r2
	veor q0, q0, q1
	lsls	r4, r4, #1
	str	r4, [sp, #88]
	ldr	r4, [sp, #56]
	vldrw.u32 q1, [q6, #-124]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	adc	r9, ip, r2
	veor q0, q0, q1
	bic	ip, r4, #-33554432
	str	ip, [sp, #124]
	umull	r1, ip, r7, r1
	vstrw.u32 q0, [q7, #252]
	ldr	r5, [sp, #92]
	ldr	r2, [sp, #116]
	umlal	r1, ip, r5, r10
	vldrw.u32 q0, [q6, #4]
	umlal	r1, ip, fp, r3
	mov	r8, r4
	ldr	r4, [sp, #16]
	vldrw.u32 q1, [q6, #84]
	str	r6, [sp, #92]
	umlal	r1, ip, r2, r4
	veor q0, q0, q1
	ldr	r2, [sp, #32]
	lsrl	r8, r9, #25
	umlal	r1, ip, r2, r0
	vldrw.u32 q1, [q6, #164]
	mov	r2, r6
	ldr	r6, [sp, #4]
	umlal	r1, ip, r2, r6
	veor q0, q0, q1
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #12]
	umlal	r1, ip, r6, r2
	vldrw.u32 q1, [q6, #244]
	ldr	r6, [sp, #52]
	ldr	r2, [sp, #8]
	umlal	r1, ip, r2, r6
	veor q0, q0, q1
	ldr	r6, [sp, #40]
	ldr	r2, [sp]
	umlal	r1, ip, r2, r6
	vldrw.u32 q1, [q6, #324]
	mov	lr, r1
	ldr	r6, [sp, #36]
	ldr	r1, [sp, #44]
	veor q0, q0, q1
	umlal	lr, ip, r6, r1
	str	lr, [sp, #56]
	vstrw.u32 q0, [q7, #268]
	umull	lr, r1, r10, r7
	ldr	r6, [sp, #112]
	ldr	r2, [sp, #84]
	vldrw.u32 q0, [q6, #20]
	umlal	lr, r1, r5, r6
	ldr	r6, [sp, #108]
	umlal	lr, r1, r6, r3
	vldrw.u32 q1, [q6, #100]
	umlal	lr, r1, fp, r4
	umlal	lr, r1, r2, r0
	ldr	r6, [sp, #4]
	veor q0, q0, q1
	ldr	r2, [sp, #32]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #24]
	vldrw.u32 q1, [q6, #180]
	ldr	r2, [sp, #64]
	umlal	lr, r1, r2, r6
	ldrd	r7, r2, [sp, #8]
	veor q0, q0, q1
	umlal	lr, r1, r7, r2
	ldr	r2, [sp, #88]
	vldrw.u32 q1, [q6, #260]
	ldr	r7, [sp]
	umlal	lr, r1, r7, r2
	ldrd	r7, r2, [sp, #40]
	veor q0, q0, q1
	umlal	lr, r1, r7, r2
	adds	lr, lr, r8
	adc	r2, r1, r9
	vldrw.u32 q1, [q6, #340]
	str	lr, [sp, #16]
	str	r2, [sp, #20]
	ldrd	r8, [sp, #16]
	veor q0, q0, q1
	lsrl	r8, r9, #26
	ldr	r7, [sp, #76]
	ldr	r2, [sp, #116]
	vstrw.u32 q0, [q7, #284]
	bic	lr, lr, #-67108864
	str	lr, [sp, #112]
	umull	r10, lr, r7, r2
	vldrw.u32 q0, [q6, #36]
	umlal	r10, lr, r5, fp
	ldr	r2, [sp, #32]
	str	r4, [sp, #16]
	vldrw.u32 q1, [q6, #116]
	umlal	r10, lr, r2, r3
	ldr	r2, [sp, #92]
	veor q0, q0, q1
	str	r0, [sp, #76]
	umlal	r10, lr, r2, r4
	ldr	r2, [sp, #12]
	vldrw.u32 q1, [q6, #196]
	ldr	r4, [sp, #4]
	umlal	r10, lr, r0, r2
	ldr	r2, [sp, #52]
	veor q0, q0, q1
	ldr	r0, [sp, #56]
	umlal	r10, lr, r4, r2
	ldr	r4, [sp, #40]
	vldrw.u32 q1, [q6, #276]
	ldr	r1, [sp, #36]
	umlal	r10, lr, r6, r4
	ldr	r4, [sp, #36]
	veor q0, q0, q1
	ldr	r6, [sp, #8]
	ldr	r2, [sp]
	umlal	r10, lr, r6, r4
	vldrw.u32 q1, [q6, #356]
	mov	r4, r8
	adds	r4, r0, r4
	veor q0, q0, q1
	adc	r0, ip, r9
	str	r0, [sp, #60]
	ldr	r0, [sp, #72]
	vstrw.u32 q0, [q7, #300]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r0
	ldrd	r8, [sp, #56]
	vldrw.u32 q0, [q6, #52]
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	str	r4, [r2, #12]
	vldrw.u32 q1, [q6, #132]
	umull	r4, ip, fp, r7
	ldrd	r2, r6, [sp, #44]
	ldr	r0, [sp, #108]
	veor q0, q0, q1
	lsrl	r8, r9, #25
	umlal	r4, ip, r5, r0
	ldr	r0, [sp, #84]
	vldrw.u32 q1, [q6, #212]
	umlal	r10, lr, r6, r2
	umlal	r4, ip, r0, r3
	ldr	r2, [sp, #32]
	veor q0, q0, q1
	ldr	r0, [sp, #16]
	ldr	r6, [sp, #64]
	vldrw.u32 q1, [q6, #292]
	umlal	r4, ip, r2, r0
	ldr	r0, [sp, #76]
	ldr	r2, [sp, #12]
	veor q0, q0, q1
	umlal	r4, ip, r6, r0
	ldr	r6, [sp, #4]
	lsls	r1, r1, #1
	vldrw.u32 q1, [q6, #372]
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #88]
	veor q0, q0, q1
	str	r10, [sp, #116]
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #8]
	vstrw.u32 q0, [q7, #316]
	ldr	r2, [sp, #40]
	umlal	r4, ip, r6, r2
	ldr	r2, [sp]
	vldrw.u32 q0, [q6, #68]
	ldr	r6, [sp, #72]
	umlal	r4, ip, r2, r1
	vldrw.u32 q1, [q6, #148]
	ldr	r2, [sp, #44]
	umlal	r4, ip, r6, r2
	adds	r8, r4, r8
	veor q0, q0, q1
	adc	ip, ip, r9
	str	r8, [sp, #56]
	str	ip, [sp, #60]
	vldrw.u32 q1, [q6, #228]
	ldrd	r10, [sp, #56]
	lsrl	r10, fp, #26
	ldr	r2, [sp, #80]
	veor q0, q0, q1
	bic	r8, r8, #-67108864
	strd	r10, [sp, #56]
	str	r8, [r2, #16]
	vldrw.u32 q1, [q6, #308]
	ldr	r4, [sp, #48]
	ldr	r2, [sp, #12]
	lsl	ip, r4, #1
	veor q0, q0, q1
	ldr	r4, [sp, #92]
	ldr	r6, [sp, #4]
	umull	fp, r10, r7, r4
	vldrw.u32 q1, [q6, #388]
	ldrd	r8, [sp, #56]
	ldr	r4, [sp, #32]
	veor q0, q0, q1
	umlal	fp, r10, r5, r4
	umlal	fp, r10, r3, r2
	ldr	r4, [sp, #16]
	vstrw.u32 q0, [q7, #332]
	ldr	r2, [sp, #52]
	umlal	fp, r10, r4, r2
	ldr	r4, [sp, #40]
	vldrw.u32 q0, [q7, #284]
	ldr	r2, [sp, #8]
	umlal	fp, r10, r0, r4
	ldr	r4, [sp, #36]
	vshl.i32 q1, q0, #1
	umlal	fp, r10, r6, r4
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #72]
	vsri.32 q1, q0, #31
	umlal	fp, r10, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #116]
	vldrw.u32 q2, [q7, #252]
	adds	r4, r6, r4
	ldr	r6, [sp, #48]
	str	r4, [sp, #56]
	veor q1, q1, q2
	umlal	fp, r10, r2, r6
	ldr	r2, [sp, #80]
	vstrw.u32 q1, [q7, #348]
	bic	r4, r4, #-33554432
	ldr	r6, [sp, #104]
	str	r4, [r2, #20]
	vldrw.u32 q0, [q7, #204]
	ldr	r2, [sp]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r2, r6
	vldrw.u32 q2, [q7, #332]
	adc	lr, lr, r9
	ldr	r6, [sp, #68]
	ldr	r2, [sp, #44]
	veor q0, q0, q2
	str	lr, [sp, #60]
	umull	r4, lr, r4, r7
	ldrd	r8, [sp, #56]
	vstrw.u32 q0, [q7, #428]
	umlal	fp, r10, r6, r2
	ldr	r2, [sp, #84]
	lsrl	r8, r9, #25
	vldrw.u32 q0, [q7, #300]
	umlal	r4, lr, r5, r2
	ldr	r2, [sp, #64]
	vshl.i32 q1, q0, #1
	str	r3, [sp, #32]
	umlal	r4, lr, r2, r3
	ldrd	r2, r3, [sp, #12]
	vsri.32 q1, q0, #31
	umlal	r4, lr, r3, r2
	str	fp, [sp, #76]
	ldr	r3, [sp, #88]
	vldrw.u32 q2, [q7, #188]
	ldr	r6, [sp, #4]
	umlal	r4, lr, r0, r3
	ldr	r3, [sp, #40]
	veor q1, q1, q2
	ldr	r2, [sp, #8]
	umlal	r4, lr, r6, r3
	ldr	r6, [sp, #24]
	vstrw.u32 q1, [q7, #364]
	ldr	r3, [sp, #72]
	umlal	r4, lr, r6, r1
	umlal	r4, lr, r2, r3
	vldrw.u32 q0, [q7, #220]
	ldr	r3, [sp]
	ldr	r2, [sp, #44]
	umlal	r4, lr, r3, ip
	vldrw.u32 q2, [q7, #268]
	ldr	r3, [sp, #104]
	strd	r8, [sp, #56]
	veor q0, q0, q2
	umlal	r4, lr, r3, r2
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	vstrw.u32 q0, [q7, #444]
	str	r8, [sp, #24]
	adc	r4, lr, r4
	str	r4, [sp, #28]
	vldrw.u32 q0, [q7, #316]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	vshl.i32 q1, q0, #1
	ldr	r3, [sp, #80]
	ldr	r2, [sp, #52]
	bic	r8, r8, #-67108864
	vsri.32 q1, q0, #31
	str	r8, [r3, #24]
	ldr	r3, [sp, #68]
	umull	lr, r8, r7, r2
	vldrw.u32 q2, [q7, #204]
	lsl	r9, r3, #1
	ldr	r3, [sp, #12]
	veor q1, q1, q2
	ldr	r2, [sp, #64]
	umlal	lr, r8, r5, r3
	umull	r3, fp, r7, r3
	vstrw.u32 q1, [q7, #380]
	umlal	r3, fp, r5, r2
	ldr	r4, [sp, #32]
	ldr	r2, [sp, #88]
	vldrw.u32 q0, [q7, #236]
	ldr	r5, [sp, #40]
	umlal	r3, fp, r4, r2
	umlal	lr, r8, r4, r5
	vldrw.u32 q2, [q7, #284]
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #8]
	umlal	r3, fp, r4, r5
	veor q0, q0, q2
	ldr	r5, [sp, #36]
	umlal	r3, fp, r0, r1
	umlal	lr, r8, r4, r5
	vstrw.u32 q0, [q7, #460]
	ldr	r4, [sp, #72]
	ldr	r1, [sp, #4]
	umlal	lr, r8, r0, r4
	vldrw.u32 q0, [q7, #332]
	umlal	r3, fp, r1, r4
	ldr	r4, [sp, #48]
	vshl.i32 q1, q0, #1
	ldr	r0, [sp, #104]
	umlal	lr, r8, r1, r4
	umlal	r3, fp, r6, ip
	vsri.32 q1, q0, #31
	umlal	lr, r8, r6, r0
	umlal	r3, fp, r2, r0
	ldr	r6, [sp, #68]
	vldrw.u32 q2, [q7, #220]
	ldr	r0, [sp, #100]
	umlal	lr, r8, r2, r6
	ldr	r2, [sp]
	veor q1, q1, q2
	ldr	r6, [sp, #76]
	umlal	r3, fp, r2, r9
	mov	ip, r3
	vstrw.u32 q1, [q7, #396]
	umlal	lr, r8, r2, r0
	ldr	r2, [sp, #44]
	ldr	r5, [sp, #96]
	vldrw.u32 q0, [q7, #252]
	umlal	ip, fp, r0, r2
	ldrd	r0, [sp, #24]
	vldrw.u32 q2, [q7, #300]
	adds	r4, r6, r0
	umlal	lr, r8, r2, r5
	mov	r2, r4
	veor q0, q0, q2
	adc	r3, r10, r1
	lsrl	r2, r3, #25
	ldr	r7, [sp, #80]
	vstrw.u32 q0, [q7, #476]
	adds	ip, ip, r2
	bic	r4, r4, #-33554432
	str	r4, [r7, #28]
	vldrw.u32 q0, [q7, #268]
	mov	r4, ip
	adc	r5, fp, r3
	lsrl	r4, r5, #26
	vshl.i32 q1, q0, #1
	adds	lr, lr, r4
	mov	r2, lr
	bic	r3, ip, #-67108864
	vsri.32 q1, q0, #31
	str	r3, [r7, #32]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	vldrw.u32 q2, [q7, #236]
	mov	r0, r2
	mov	r1, r3
	veor q1, q1, q2
	lsll	r0, r1, #3
	adds	r4, r0, r2
	adc	r5, r1, r3
	vstrw.u32 q1, [q7, #412]
	adds	r4, r4, r4
	adcs	r5, r5, r5
	adds	r4, r4, r2
	vldrw.u32 q0, [q7, #188]
	adc	r5, r5, r3
	ldr	r3, [sp, #120]
	ldr	r1, [sp, #112]
	vldrw.u32 q2, [q7, #316]
	adds	r4, r4, r3
	mov	r2, r4
	adc	r3, r5, #0
	veor q0, q0, q2
	lsrl	r2, r3, #26
	bic	r4, r4, #-67108864
	str	r4, [r7]
	vstrw.u32 q0, [q7, #492]
	ldr	r4, [sp, #124]
	bic	r6, lr, #-33554432
	adds	r3, r4, r2
	vldrw.u32 q3, [q7, #348]
	bic	r2, r3, #-33554432
	add	r1, r1, r3, lsr #25
	vldrw.u32 q4, [q7, #428]
	strd	r2, r1, [r7, #4]
	str	r6, [r7, #36]
	movw r0, #:lower16:g_fc_out
	vldrw.u32 q0, [q6, #-508]
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	vldrw.u32 q1, [q6, #4]
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	veor q0, q0, q3
	mov	ip, #38
	ldr	r7, [r2, #32]
	str	r7, [sp, #100]
	veor q1, q1, q4
	ldr	r7, [r1, #32]
	ldr	r6, [r2, #12]
	str	r7, [sp, #76]
	vorr q2, q0, q0
	ldr	r7, [lr, #20]
	ldr	r3, [r2, #4]
	vstrw.u32 q2, [q6, #404]
	mul	r8, ip, r7
	ldr	r4, [r2, #8]
	str	r6, [sp, #36]
	vorr q5, q1, q1
	mul	r2, ip, r6
	str	r7, [sp, #48]
	ldr	r6, [r1, #16]
	vstrw.u32 q5, [q7, #-212]
	ldr	r7, [lr, #28]
	str	r6, [sp, #4]
	mov	r6, r7
	vldrw.u32 q0, [q6, #-428]
	ldr	r5, [r1, #36]
	str	r0, [sp, #80]
	str	r5, [sp, #92]
	vldrw.u32 q1, [q6, #84]
	mov	r5, r4
	ldr	r0, [lr, #16]
	str	r2, [sp, #112]
	veor q0, q0, q3
	ldr	r2, [r1, #24]
	str	r8, [sp, #108]
	str	r2, [sp, #16]
	veor q1, q1, q4
	add	r2, r0, r0, lsl #3
	add	r10, r0, r2, lsl #1
	vshl.i32 q2, q0, #18
	ldr	r2, [lr, #24]
	mul	r8, ip, r6
	add	r7, r2, r2, lsl #3
	vsri.32 q2, q0, #14
	add	fp, r2, r7, lsl #1
	ldr	r7, [r1, #12]
	add	r4, r4, r4, lsl #3
	vstrw.u32 q2, [q7, #-356]
	str	r5, [sp, #40]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #52]
	vshl.i32 q5, q1, #18
	mul	r5, ip, r3
	str	r0, [sp, #72]
	ldr	r3, [r1, #28]
	vsri.32 q5, q1, #14
	ldr	r0, [r1, #20]
	str	r2, [sp, #104]
	str	r6, [sp, #68]
	vstrw.u32 q5, [q7, #44]
	str	r8, [sp, #84]
	str	r7, [sp, #24]
	vldrw.u32 q0, [q6, #-348]
	ldr	r2, [lr, #36]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	vldrw.u32 q1, [q6, #164]
	str	r7, [sp, #8]
	ldr	r7, [lr]
	str	r2, [sp, #96]
	veor q0, q0, q3
	ldr	r2, [r1, #4]
	str	r7, [sp, #12]
	ldr	r7, [sp, #100]
	veor q1, q1, q4
	str	r2, [sp]
	ldr	r2, [r1]
	ldr	r1, [sp, #36]
	vshl.i32 q2, q1, #2
	str	ip, [sp, #64]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	vsri.32 q2, q1, #30
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #76]
	add	lr, r1, lr, lsl #1
	vstrw.u32 q2, [q7, #-500]
	str	ip, [sp, #32]
	umull	lr, ip, lr, r7
	vshl.i32 q5, q0, #1
	ldr	r1, [sp, #92]
	mov	r6, r3
	umlal	lr, ip, r1, r4
	vsri.32 q5, q0, #31
	umull	r4, r1, r4, r7
	umlal	lr, ip, r10, r3
	ldr	r3, [sp, #92]
	vstrw.u32 q5, [q7, #-100]
	ldr	r7, [sp, #8]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	vldrw.u32 q0, [q6, #-268]
	ldr	r4, [sp, #112]
	ldr	r5, [sp, #108]
	umlal	r8, r1, r4, r6
	vldrw.u32 q1, [q6, #244]
	ldr	r4, [sp, #16]
	mov	r3, r6
	umlal	r8, r1, r10, r4
	veor q0, q0, q3
	umlal	r8, r1, r5, r0
	ldr	r6, [sp, #4]
	veor q1, q1, q4
	ldr	r5, [sp, #84]
	umlal	r8, r1, fp, r6
	ldr	r6, [sp, #24]
	vshl.i32 q2, q1, #21
	umlal	r8, r1, r5, r6
	ldr	r6, [sp, #32]
	ldr	r5, [sp]
	vsri.32 q2, q1, #11
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #64]
	umlal	r8, r1, r6, r5
	vstrw.u32 q2, [q7, #-244]
	ldr	r6, [sp, #12]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #48]
	vshl.i32 q5, q0, #20
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	vsri.32 q5, q0, #12
	umlal	lr, ip, r1, r4
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	vstrw.u32 q5, [q7, #156]
	umlal	lr, ip, fp, r0
	str	r8, [sp, #120]
	vldrw.u32 q0, [q6, #-188]
	ldr	r4, [sp, #68]
	ldr	r6, [sp, #4]
	add	r8, r4, r4, lsl #3
	vldrw.u32 q1, [q6, #324]
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r6
	ldr	r5, [sp, #32]
	veor q0, q0, q3
	ldr	r6, [sp, #24]
	str	r8, [sp, #116]
	umlal	lr, ip, r5, r6
	veor q1, q1, q4
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	ldr	r5, [sp, #96]
	vshl.i32 q2, q0, #9
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	add	r8, r5, r8, lsl #1
	vsri.32 q2, q0, #23
	mov	r6, r8
	ldr	r7, [sp, #8]
	ldr	r5, [sp, #12]
	vstrw.u32 q2, [q7, #-388]
	umlal	lr, ip, r8, r7
	ldr	r4, [sp]
	vshl.i32 q5, q1, #9
	str	r2, [sp, #44]
	umlal	lr, ip, r4, r5
	ldr	r4, [sp, #52]
	vsri.32 q5, q1, #23
	ldr	r7, [sp, #76]
	umlal	lr, ip, r4, r2
	lsls	r4, r4, #1
	vstrw.u32 q5, [q7, #12]
	str	r4, [sp, #88]
	ldr	r4, [sp, #56]
	ldr	r2, [sp, #60]
	vldrw.u32 q3, [q7, #364]
	adds	r4, lr, r4
	adc	r9, ip, r2
	bic	ip, r4, #-33554432
	vldrw.u32 q4, [q7, #444]
	str	ip, [sp, #124]
	umull	r1, ip, r7, r1
	ldr	r5, [sp, #92]
	vldrw.u32 q0, [q6, #-492]
	ldr	r2, [sp, #116]
	umlal	r1, ip, r5, r10
	vldrw.u32 q1, [q6, #20]
	umlal	r1, ip, fp, r3
	mov	r8, r4
	ldr	r4, [sp, #16]
	veor q0, q0, q3
	str	r6, [sp, #92]
	umlal	r1, ip, r2, r4
	ldr	r2, [sp, #32]
	veor q1, q1, q4
	lsrl	r8, r9, #25
	umlal	r1, ip, r2, r0
	mov	r2, r6
	vshl.i32 q2, q1, #1
	ldr	r6, [sp, #4]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #24]
	vsri.32 q2, q1, #31
	ldr	r2, [sp, #12]
	umlal	r1, ip, r6, r2
	ldr	r6, [sp, #52]
	vstrw.u32 q2, [q7, #-452]
	ldr	r2, [sp, #8]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #40]
	vorr q5, q0, q0
	ldr	r2, [sp]
	umlal	r1, ip, r2, r6
	vstrw.u32 q5, [q7, #-52]
	mov	lr, r1
	ldr	r6, [sp, #36]
	ldr	r1, [sp, #44]
	vldrw.u32 q0, [q6, #-412]
	umlal	lr, ip, r6, r1
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	vldrw.u32 q1, [q6, #100]
	ldr	r6, [sp, #112]
	ldr	r2, [sp, #84]
	umlal	lr, r1, r5, r6
	veor q0, q0, q3
	ldr	r6, [sp, #108]
	umlal	lr, r1, r6, r3
	umlal	lr, r1, fp, r4
	veor q1, q1, q4
	umlal	lr, r1, r2, r0
	ldr	r6, [sp, #4]
	ldr	r2, [sp, #32]
	vshl.i32 q2, q0, #22
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #24]
	vsri.32 q2, q0, #10
	ldr	r2, [sp, #64]
	umlal	lr, r1, r2, r6
	ldrd	r7, r2, [sp, #8]
	vstrw.u32 q2, [q6, #420]
	umlal	lr, r1, r7, r2
	ldr	r2, [sp, #88]
	ldr	r7, [sp]
	vshl.i32 q5, q1, #22
	umlal	lr, r1, r7, r2
	ldrd	r7, r2, [sp, #40]
	umlal	lr, r1, r7, r2
	vsri.32 q5, q1, #10
	adds	lr, lr, r8
	adc	r2, r1, r9
	str	lr, [sp, #16]
	vstrw.u32 q5, [q7, #-196]
	str	r2, [sp, #20]
	ldrd	r8, [sp, #16]
	lsrl	r8, r9, #26
	vldrw.u32 q0, [q6, #-332]
	ldr	r7, [sp, #76]
	ldr	r2, [sp, #116]
	bic	lr, lr, #-67108864
	vldrw.u32 q1, [q6, #180]
	str	lr, [sp, #112]
	umull	r10, lr, r7, r2
	veor q0, q0, q3
	umlal	r10, lr, r5, fp
	ldr	r2, [sp, #32]
	str	r4, [sp, #16]
	veor q1, q1, q4
	umlal	r10, lr, r2, r3
	ldr	r2, [sp, #92]
	str	r0, [sp, #76]
	vshl.i32 q2, q0, #5
	umlal	r10, lr, r2, r4
	ldr	r2, [sp, #12]
	ldr	r4, [sp, #4]
	vsri.32 q2, q0, #27
	umlal	r10, lr, r0, r2
	ldr	r2, [sp, #52]
	ldr	r0, [sp, #56]
	vstrw.u32 q2, [q7, #-340]
	umlal	r10, lr, r4, r2
	ldr	r4, [sp, #40]
	ldr	r1, [sp, #36]
	vshl.i32 q5, q1, #5
	umlal	r10, lr, r6, r4
	ldr	r4, [sp, #36]
	vsri.32 q5, q1, #27
	ldr	r6, [sp, #8]
	ldr	r2, [sp]
	umlal	r10, lr, r6, r4
	vstrw.u32 q5, [q7, #60]
	mov	r4, r8
	adds	r4, r0, r4
	adc	r0, ip, r9
	vldrw.u32 q0, [q6, #-252]
	str	r0, [sp, #60]
	ldr	r0, [sp, #72]
	str	r4, [sp, #56]
	vldrw.u32 q1, [q6, #260]
	umlal	r10, lr, r2, r0
	ldrd	r8, [sp, #56]
	ldr	r2, [sp, #80]
	veor q0, q0, q3
	bic	r4, r4, #-33554432
	str	r4, [r2, #12]
	umull	r4, ip, fp, r7
	veor q1, q1, q4
	ldrd	r2, r6, [sp, #44]
	ldr	r0, [sp, #108]
	lsrl	r8, r9, #25
	vshl.i32 q2, q1, #23
	umlal	r4, ip, r5, r0
	ldr	r0, [sp, #84]
	vsri.32 q2, q1, #9
	umlal	r10, lr, r6, r2
	umlal	r4, ip, r0, r3
	ldr	r2, [sp, #32]
	vstrw.u32 q2, [q7, #-484]
	ldr	r0, [sp, #16]
	ldr	r6, [sp, #64]
	umlal	r4, ip, r2, r0
	vshl.i32 q5, q0, #22
	ldr	r0, [sp, #76]
	ldr	r2, [sp, #12]
	umlal	r4, ip, r6, r0
	vsri.32 q5, q0, #10
	ldr	r6, [sp, #4]
	lsls	r1, r1, #1
	umlal	r4, ip, r6, r2
	vstrw.u32 q5, [q7, #-84]
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #88]
	str	r10, [sp, #116]
	vldrw.u32 q0, [q6, #-172]
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #8]
	ldr	r2, [sp, #40]
	vldrw.u32 q1, [q6, #340]
	umlal	r4, ip, r6, r2
	ldr	r2, [sp]
	veor q0, q0, q3
	ldr	r6, [sp, #72]
	umlal	r4, ip, r2, r1
	ldr	r2, [sp, #44]
	veor q1, q1, q4
	umlal	r4, ip, r6, r2
	adds	r8, r4, r8
	adc	ip, ip, r9
	vshl.i32 q2, q0, #1
	str	r8, [sp, #56]
	str	ip, [sp, #60]
	ldrd	r10, [sp, #56]
	vsri.32 q2, q0, #31
	lsrl	r10, fp, #26
	ldr	r2, [sp, #80]
	bic	r8, r8, #-67108864
	vstrw.u32 q2, [q7, #-228]
	strd	r10, [sp, #56]
	str	r8, [r2, #16]
	ldr	r4, [sp, #48]
	vshl.i32 q5, q1, #1
	ldr	r2, [sp, #12]
	lsl	ip, r4, #1
	vsri.32 q5, q1, #31
	ldr	r4, [sp, #92]
	ldr	r6, [sp, #4]
	umull	fp, r10, r7, r4
	vstrw.u32 q5, [q7, #172]
	ldrd	r8, [sp, #56]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r5, r4
	vldrw.u32 q3, [q7, #380]
	umlal	fp, r10, r3, r2
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #52]
	vldrw.u32 q4, [q7, #460]
	umlal	fp, r10, r4, r2
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #8]
	vldrw.u32 q0, [q6, #-476]
	umlal	fp, r10, r0, r4
	ldr	r4, [sp, #36]
	umlal	fp, r10, r6, r4
	vldrw.u32 q1, [q6, #36]
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #72]
	umlal	fp, r10, r6, r4
	veor q0, q0, q3
	mov	r4, r8
	ldr	r6, [sp, #116]
	veor q1, q1, q4
	adds	r4, r6, r4
	ldr	r6, [sp, #48]
	str	r4, [sp, #56]
	vshl.i32 q2, q0, #31
	umlal	fp, r10, r2, r6
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	vsri.32 q2, q0, #1
	ldr	r6, [sp, #104]
	str	r4, [r2, #20]
	ldr	r2, [sp]
	vstrw.u32 q2, [q7, #-292]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r2, r6
	adc	lr, lr, r9
	vshl.i32 q5, q1, #31
	ldr	r6, [sp, #68]
	ldr	r2, [sp, #44]
	str	lr, [sp, #60]
	vsri.32 q5, q1, #1
	umull	r4, lr, r4, r7
	ldrd	r8, [sp, #56]
	vstrw.u32 q5, [q7, #108]
	umlal	fp, r10, r6, r2
	ldr	r2, [sp, #84]
	lsrl	r8, r9, #25
	vldrw.u32 q0, [q6, #-396]
	umlal	r4, lr, r5, r2
	ldr	r2, [sp, #64]
	str	r3, [sp, #32]
	vldrw.u32 q1, [q6, #116]
	umlal	r4, lr, r2, r3
	ldrd	r2, r3, [sp, #12]
	umlal	r4, lr, r3, r2
	veor q0, q0, q3
	str	fp, [sp, #76]
	ldr	r3, [sp, #88]
	ldr	r6, [sp, #4]
	veor q1, q1, q4
	umlal	r4, lr, r0, r3
	ldr	r3, [sp, #40]
	ldr	r2, [sp, #8]
	vshl.i32 q2, q0, #3
	umlal	r4, lr, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #72]
	vsri.32 q2, q0, #29
	umlal	r4, lr, r6, r1
	umlal	r4, lr, r2, r3
	vstrw.u32 q2, [q7, #-436]
	ldr	r3, [sp]
	ldr	r2, [sp, #44]
	umlal	r4, lr, r3, ip
	vshl.i32 q5, q1, #3
	ldr	r3, [sp, #104]
	strd	r8, [sp, #56]
	umlal	r4, lr, r3, r2
	vsri.32 q5, q1, #29
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	vstrw.u32 q5, [q7, #-36]
	adc	r4, lr, r4
	str	r4, [sp, #28]
	ldrd	r2, [sp, #24]
	vldrw.u32 q0, [q6, #-316]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #80]
	vldrw.u32 q1, [q6, #196]
	ldr	r2, [sp, #52]
	bic	r8, r8, #-67108864
	veor q0, q0, q3
	str	r8, [r3, #24]
	ldr	r3, [sp, #68]
	umull	lr, r8, r7, r2
	veor q1, q1, q4
	lsl	r9, r3, #1
	ldr	r3, [sp, #12]
	ldr	r2, [sp, #64]
	vshl.i32 q2, q1, #22
	umlal	lr, r8, r5, r3
	umull	r3, fp, r7, r3
	umlal	r3, fp, r5, r2
	vsri.32 q2, q1, #10
	ldr	r4, [sp, #32]
	ldr	r2, [sp, #88]
	ldr	r5, [sp, #40]
	vstrw.u32 q2, [q6, #436]
	umlal	r3, fp, r4, r2
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #16]
	vshl.i32 q5, q0, #21
	ldr	r2, [sp, #8]
	umlal	r3, fp, r4, r5
	ldr	r5, [sp, #36]
	vsri.32 q5, q0, #11
	umlal	r3, fp, r0, r1
	umlal	lr, r8, r4, r5
	vstrw.u32 q5, [q7, #-180]
	ldr	r4, [sp, #72]
	ldr	r1, [sp, #4]
	umlal	lr, r8, r0, r4
	vldrw.u32 q0, [q6, #-236]
	umlal	r3, fp, r1, r4
	ldr	r4, [sp, #48]
	ldr	r0, [sp, #104]
	vldrw.u32 q1, [q6, #276]
	umlal	lr, r8, r1, r4
	umlal	r3, fp, r6, ip
	umlal	lr, r8, r6, r0
	veor q0, q0, q3
	umlal	r3, fp, r2, r0
	ldr	r6, [sp, #68]
	ldr	r0, [sp, #100]
	veor q1, q1, q4
	umlal	lr, r8, r2, r6
	ldr	r2, [sp]
	ldr	r6, [sp, #76]
	vshl.i32 q2, q1, #8
	umlal	r3, fp, r2, r9
	mov	ip, r3
	umlal	lr, r8, r2, r0
	vsri.32 q2, q1, #24
	ldr	r2, [sp, #44]
	ldr	r5, [sp, #96]
	vstrw.u32 q2, [q7, #-324]
	umlal	ip, fp, r0, r2
	ldrd	r0, [sp, #24]
	adds	r4, r6, r0
	vshl.i32 q5, q0, #7
	umlal	lr, r8, r2, r5
	mov	r2, r4
	adc	r3, r10, r1
	vsri.32 q5, q0, #25
	lsrl	r2, r3, #25
	ldr	r7, [sp, #80]
	adds	ip, ip, r2
	vstrw.u32 q5, [q7, #76]
	bic	r4, r4, #-33554432
	str	r4, [r7, #28]
	mov	r4, ip
	vldrw.u32 q0, [q6, #-156]
	adc	r5, fp, r3
	lsrl	r4, r5, #26
	adds	lr, lr, r4
	vldrw.u32 q1, [q6, #356]
	mov	r2, lr
	bic	r3, ip, #-67108864
	veor q0, q0, q3
	str	r3, [r7, #32]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	veor q1, q1, q4
	mov	r0, r2
	mov	r1, r3
	lsll	r0, r1, #3
	vshl.i32 q2, q1, #31
	adds	r4, r0, r2
	adc	r5, r1, r3
	adds	r4, r4, r4
	vsri.32 q2, q1, #1
	adcs	r5, r5, r5
	adds	r4, r4, r2
	adc	r5, r5, r3
	vstrw.u32 q2, [q7, #-468]
	ldr	r3, [sp, #120]
	ldr	r1, [sp, #112]
	adds	r4, r4, r3
	vshl.i32 q5, q0, #30
	mov	r2, r4
	adc	r3, r5, #0
	lsrl	r2, r3, #26
	vsri.32 q5, q0, #2
	bic	r4, r4, #-67108864
	str	r4, [r7]
	vstrw.u32 q5, [q7, #-68]
	ldr	r4, [sp, #124]
	bic	r6, lr, #-33554432
	adds	r3, r4, r2
	vldrw.u32 q3, [q7, #396]
	bic	r2, r3, #-33554432
	add	r1, r1, r3, lsr #25
	strd	r2, r1, [r7, #4]
	vldrw.u32 q4, [q7, #476]
	str	r6, [r7, #36]
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	vldrw.u32 q0, [q6, #-460]
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	vldrw.u32 q1, [q6, #52]
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	veor q0, q0, q3
	ldr	r7, [r2, #32]
	str	r7, [sp, #100]
	veor q1, q1, q4
	ldr	r7, [r1, #32]
	ldr	r6, [r2, #12]
	str	r7, [sp, #76]
	vshl.i32 q2, q0, #14
	ldr	r7, [lr, #20]
	ldr	r3, [r2, #4]
	mul	r8, ip, r7
	vsri.32 q2, q0, #18
	ldr	r4, [r2, #8]
	str	r6, [sp, #36]
	mul	r2, ip, r6
	vstrw.u32 q2, [q6, #484]
	str	r7, [sp, #48]
	ldr	r6, [r1, #16]
	ldr	r7, [lr, #28]
	vshl.i32 q5, q1, #14
	str	r6, [sp, #4]
	mov	r6, r7
	ldr	r5, [r1, #36]
	vsri.32 q5, q1, #18
	str	r0, [sp, #80]
	str	r5, [sp, #92]
	mov	r5, r4
	vstrw.u32 q5, [q7, #-132]
	ldr	r0, [lr, #16]
	str	r2, [sp, #112]
	vldrw.u32 q0, [q6, #-380]
	ldr	r2, [r1, #24]
	str	r8, [sp, #108]
	str	r2, [sp, #16]
	vldrw.u32 q1, [q6, #132]
	add	r2, r0, r0, lsl #3
	add	r10, r0, r2, lsl #1
	ldr	r2, [lr, #24]
	veor q0, q0, q3
	mul	r8, ip, r6
	add	r7, r2, r2, lsl #3
	add	fp, r2, r7, lsl #1
	veor q1, q1, q4
	ldr	r7, [r1, #12]
	add	r4, r4, r4, lsl #3
	str	r5, [sp, #40]
	vshl.i32 q2, q1, #28
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #52]
	mul	r5, ip, r3
	vsri.32 q2, q1, #4
	str	r0, [sp, #72]
	ldr	r3, [r1, #28]
	vstrw.u32 q2, [q7, #-276]
	ldr	r0, [r1, #20]
	str	r2, [sp, #104]
	str	r6, [sp, #68]
	vshl.i32 q5, q0, #27
	str	r8, [sp, #84]
	str	r7, [sp, #24]
	ldr	r2, [lr, #36]
	vsri.32 q5, q0, #5
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #8]
	vstrw.u32 q5, [q7, #124]
	ldr	r7, [lr]
	str	r2, [sp, #96]
	ldr	r2, [r1, #4]
	vldrw.u32 q0, [q6, #-300]
	str	r7, [sp, #12]
	ldr	r7, [sp, #100]
	str	r2, [sp]
	vldrw.u32 q1, [q6, #212]
	ldr	r2, [r1]
	ldr	r1, [sp, #36]
	str	ip, [sp, #64]
	veor q0, q0, q3
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	veor q1, q1, q4
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #76]
	add	lr, r1, lr, lsl #1
	vshl.i32 q2, q1, #13
	str	ip, [sp, #32]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #92]
	vsri.32 q2, q1, #19
	mov	r6, r3
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	vstrw.u32 q2, [q7, #-420]
	umlal	lr, ip, r10, r3
	ldr	r3, [sp, #92]
	ldr	r7, [sp, #8]
	vshl.i32 q5, q0, #12
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r4, [sp, #112]
	vsri.32 q5, q0, #20
	ldr	r5, [sp, #108]
	umlal	r8, r1, r4, r6
	ldr	r4, [sp, #16]
	vstrw.u32 q5, [q7, #-20]
	mov	r3, r6
	umlal	r8, r1, r10, r4
	vldrw.u32 q0, [q6, #-220]
	umlal	r8, r1, r5, r0
	ldr	r6, [sp, #4]
	ldr	r5, [sp, #84]
	vldrw.u32 q1, [q6, #292]
	umlal	r8, r1, fp, r6
	ldr	r6, [sp, #24]
	umlal	r8, r1, r5, r6
	veor q0, q0, q3
	ldr	r6, [sp, #32]
	ldr	r5, [sp]
	umlal	r8, r1, r6, r7
	veor q1, q1, q4
	ldr	r6, [sp, #64]
	umlal	r8, r1, r6, r5
	ldr	r6, [sp, #12]
	vshl.i32 q2, q1, #11
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #48]
	str	r1, [sp, #60]
	vsri.32 q2, q1, #21
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	vstrw.u32 q2, [q6, #452]
	umlal	lr, ip, r1, r4
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	vshl.i32 q5, q0, #10
	umlal	lr, ip, fp, r0
	str	r8, [sp, #120]
	ldr	r4, [sp, #68]
	vsri.32 q5, q0, #22
	ldr	r6, [sp, #4]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	vstrw.u32 q5, [q7, #-164]
	umlal	lr, ip, r8, r6
	ldr	r5, [sp, #32]
	ldr	r6, [sp, #24]
	vldrw.u32 q0, [q6, #-140]
	str	r8, [sp, #116]
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	vldrw.u32 q1, [q6, #372]
	lsrl	r6, r7, #26
	ldr	r5, [sp, #96]
	strd	r6, [sp, #56]
	veor q0, q0, q3
	add	r8, r5, r5, lsl #3
	add	r8, r5, r8, lsl #1
	veor q1, q1, q4
	mov	r6, r8
	ldr	r7, [sp, #8]
	ldr	r5, [sp, #12]
	vshl.i32 q2, q0, #28
	umlal	lr, ip, r8, r7
	ldr	r4, [sp]
	str	r2, [sp, #44]
	vsri.32 q2, q0, #4
	umlal	lr, ip, r4, r5
	ldr	r4, [sp, #52]
	ldr	r7, [sp, #76]
	vstrw.u32 q2, [q7, #-308]
	umlal	lr, ip, r4, r2
	lsls	r4, r4, #1
	str	r4, [sp, #88]
	vshl.i32 q5, q1, #28
	ldr	r4, [sp, #56]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	vsri.32 q5, q1, #4
	adc	r9, ip, r2
	bic	ip, r4, #-33554432
	vstrw.u32 q5, [q7, #92]
	str	ip, [sp, #124]
	umull	r1, ip, r7, r1
	ldr	r5, [sp, #92]
	vldrw.u32 q3, [q7, #412]
	ldr	r2, [sp, #116]
	umlal	r1, ip, r5, r10
	umlal	r1, ip, fp, r3
	vldrw.u32 q4, [q7, #492]
	mov	r8, r4
	ldr	r4, [sp, #16]
	str	r6, [sp, #92]
	vldrw.u32 q0, [q6, #-444]
	umlal	r1, ip, r2, r4
	ldr	r2, [sp, #32]
	lsrl	r8, r9, #25
	vldrw.u32 q1, [q6, #68]
	umlal	r1, ip, r2, r0
	mov	r2, r6
	ldr	r6, [sp, #4]
	veor q0, q0, q3
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #12]
	veor q1, q1, q4
	umlal	r1, ip, r6, r2
	ldr	r6, [sp, #52]
	vshl.i32 q2, q1, #14
	ldr	r2, [sp, #8]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #40]
	vsri.32 q2, q1, #18
	ldr	r2, [sp]
	umlal	r1, ip, r2, r6
	mov	lr, r1
	vstrw.u32 q2, [q7, #-372]
	ldr	r6, [sp, #36]
	ldr	r1, [sp, #44]
	umlal	lr, ip, r6, r1
	vshl.i32 q5, q0, #13
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	ldr	r6, [sp, #112]
	vsri.32 q5, q0, #19
	ldr	r2, [sp, #84]
	umlal	lr, r1, r5, r6
	ldr	r6, [sp, #108]
	vstrw.u32 q5, [q7, #28]
	umlal	lr, r1, r6, r3
	umlal	lr, r1, fp, r4
	vldrw.u32 q0, [q6, #-364]
	umlal	lr, r1, r2, r0
	ldr	r6, [sp, #4]
	ldr	r2, [sp, #32]
	vldrw.u32 q1, [q6, #148]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #64]
	veor q0, q0, q3
	umlal	lr, r1, r2, r6
	ldrd	r7, r2, [sp, #8]
	umlal	lr, r1, r7, r2
	veor q1, q1, q4
	ldr	r2, [sp, #88]
	ldr	r7, [sp]
	umlal	lr, r1, r7, r2
	vshl.i32 q2, q0, #10
	ldrd	r7, r2, [sp, #40]
	umlal	lr, r1, r7, r2
	adds	lr, lr, r8
	vsri.32 q2, q0, #22
	adc	r2, r1, r9
	str	lr, [sp, #16]
	str	r2, [sp, #20]
	vstrw.u32 q2, [q6, #500]
	ldrd	r8, [sp, #16]
	lsrl	r8, r9, #26
	vshl.i32 q5, q1, #10
	ldr	r7, [sp, #76]
	ldr	r2, [sp, #116]
	bic	lr, lr, #-67108864
	vsri.32 q5, q1, #22
	str	lr, [sp, #112]
	umull	r10, lr, r7, r2
	umlal	r10, lr, r5, fp
	vstrw.u32 q5, [q7, #-116]
	ldr	r2, [sp, #32]
	str	r4, [sp, #16]
	umlal	r10, lr, r2, r3
	vldrw.u32 q0, [q6, #-284]
	ldr	r2, [sp, #92]
	str	r0, [sp, #76]
	umlal	r10, lr, r2, r4
	vldrw.u32 q1, [q6, #228]
	ldr	r2, [sp, #12]
	ldr	r4, [sp, #4]
	umlal	r10, lr, r0, r2
	veor q0, q0, q3
	ldr	r2, [sp, #52]
	ldr	r0, [sp, #56]
	umlal	r10, lr, r4, r2
	veor q1, q1, q4
	ldr	r4, [sp, #40]
	ldr	r1, [sp, #36]
	vshl.i32 q2, q1, #20
	umlal	r10, lr, r6, r4
	ldr	r4, [sp, #36]
	ldr	r6, [sp, #8]
	vsri.32 q2, q1, #12
	ldr	r2, [sp]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	vstrw.u32 q2, [q7, #-260]
	adds	r4, r0, r4
	adc	r0, ip, r9
	str	r0, [sp, #60]
	vshl.i32 q5, q0, #19
	ldr	r0, [sp, #72]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r0
	vsri.32 q5, q0, #13
	ldrd	r8, [sp, #56]
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	vstrw.u32 q5, [q7, #140]
	str	r4, [r2, #12]
	umull	r4, ip, fp, r7
	vldrw.u32 q0, [q6, #-204]
	ldrd	r2, r6, [sp, #44]
	ldr	r0, [sp, #108]
	lsrl	r8, r9, #25
	vldrw.u32 q1, [q6, #308]
	umlal	r4, ip, r5, r0
	ldr	r0, [sp, #84]
	umlal	r10, lr, r6, r2
	veor q0, q0, q3
	umlal	r4, ip, r0, r3
	ldr	r2, [sp, #32]
	ldr	r0, [sp, #16]
	veor q1, q1, q4
	ldr	r6, [sp, #64]
	umlal	r4, ip, r2, r0
	ldr	r0, [sp, #76]
	vshl.i32 q2, q0, #4
	ldr	r2, [sp, #12]
	umlal	r4, ip, r6, r0
	ldr	r6, [sp, #4]
	vsri.32 q2, q0, #28
	lsls	r1, r1, #1
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #24]
	vstrw.u32 q2, [q7, #-404]
	ldr	r2, [sp, #88]
	str	r10, [sp, #116]
	vshl.i32 q5, q1, #4
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #8]
	ldr	r2, [sp, #40]
	vsri.32 q5, q1, #28
	umlal	r4, ip, r6, r2
	ldr	r2, [sp]
	ldr	r6, [sp, #72]
	vstrw.u32 q5, [q7, #-4]
	umlal	r4, ip, r2, r1
	ldr	r2, [sp, #44]
	umlal	r4, ip, r6, r2
	vldrw.u32 q0, [q6, #-124]
	adds	r8, r4, r8
	adc	ip, ip, r9
	str	r8, [sp, #56]
	vldrw.u32 q1, [q6, #388]
	str	ip, [sp, #60]
	ldrd	r10, [sp, #56]
	lsrl	r10, fp, #26
	veor q0, q0, q3
	ldr	r2, [sp, #80]
	bic	r8, r8, #-67108864
	veor q1, q1, q4
	strd	r10, [sp, #56]
	str	r8, [r2, #16]
	ldr	r4, [sp, #48]
	vshl.i32 q2, q0, #7
	ldr	r2, [sp, #12]
	lsl	ip, r4, #1
	ldr	r4, [sp, #92]
	vsri.32 q2, q0, #25
	ldr	r6, [sp, #4]
	umull	fp, r10, r7, r4
	ldrd	r8, [sp, #56]
	vstrw.u32 q2, [q6, #468]
	ldr	r4, [sp, #32]
	umlal	fp, r10, r5, r4
	umlal	fp, r10, r3, r2
	vshl.i32 q5, q1, #7
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #52]
	umlal	fp, r10, r4, r2
	vsri.32 q5, q1, #25
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	fp, r10, r0, r4
	vstrw.u32 q5, [q7, #-148]
	ldr	r4, [sp, #36]
	umlal	fp, r10, r6, r4
	vldrw.u32 q0, [q6, #404]
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #72]
	umlal	fp, r10, r6, r4
	vldrw.u32 q1, [q6, #420]
	mov	r4, r8
	ldr	r6, [sp, #116]
	adds	r4, r6, r4
	vldrw.u32 q2, [q6, #436]
	ldr	r6, [sp, #48]
	str	r4, [sp, #56]
	umlal	fp, r10, r2, r6
	vldrw.u32 q5, [q6, #452]
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	ldr	r6, [sp, #104]
	vldrw.u32 q3, [q6, #468]
	str	r4, [r2, #20]
	ldr	r2, [sp]
	ldr	r4, [sp, #32]
	vbic q4, q2, q1
	umlal	fp, r10, r2, r6
	adc	lr, lr, r9
	veor q4, q4, q0
	ldr	r6, [sp, #68]
	ldr	r2, [sp, #44]
	str	lr, [sp, #60]
	vstrw.u32 q4, [q6, #-508]
	umull	r4, lr, r4, r7
	ldrd	r8, [sp, #56]
	umlal	fp, r10, r6, r2
	vbic q4, q5, q2
	ldr	r2, [sp, #84]
	lsrl	r8, r9, #25
	umlal	r4, lr, r5, r2
	veor q4, q4, q1
	ldr	r2, [sp, #64]
	str	r3, [sp, #32]
	umlal	r4, lr, r2, r3
	vstrw.u32 q4, [q6, #-492]
	ldrd	r2, r3, [sp, #12]
	umlal	r4, lr, r3, r2
	str	fp, [sp, #76]
	vbic q4, q3, q5
	ldr	r3, [sp, #88]
	ldr	r6, [sp, #4]
	umlal	r4, lr, r0, r3
	veor q4, q4, q2
	ldr	r3, [sp, #40]
	ldr	r2, [sp, #8]
	vstrw.u32 q4, [q6, #-476]
	umlal	r4, lr, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #72]
	vbic q4, q0, q3
	umlal	r4, lr, r6, r1
	umlal	r4, lr, r2, r3
	ldr	r3, [sp]
	veor q4, q4, q5
	ldr	r2, [sp, #44]
	umlal	r4, lr, r3, ip
	ldr	r3, [sp, #104]
	vstrw.u32 q4, [q6, #-460]
	strd	r8, [sp, #56]
	umlal	r4, lr, r3, r2
	adds	r8, r4, r8
	vbic q4, q1, q0
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, lr, r4
	veor q4, q4, q3
	str	r4, [sp, #28]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	vstrw.u32 q4, [q6, #-444]
	strd	r2, [sp, #24]
	ldr	r3, [sp, #80]
	vldrw.u32 q0, [q6, #484]
	ldr	r2, [sp, #52]
	bic	r8, r8, #-67108864
	str	r8, [r3, #24]
	vldrw.u32 q1, [q6, #500]
	ldr	r3, [sp, #68]
	umull	lr, r8, r7, r2
	lsl	r9, r3, #1
	vldrw.u32 q2, [q7, #-500]
	ldr	r3, [sp, #12]
	ldr	r2, [sp, #64]
	umlal	lr, r8, r5, r3
	vldrw.u32 q5, [q7, #-484]
	umull	r3, fp, r7, r3
	umlal	r3, fp, r5, r2
	ldr	r4, [sp, #32]
	vldrw.u32 q3, [q7, #-468]
	ldr	r2, [sp, #88]
	ldr	r5, [sp, #40]
	umlal	r3, fp, r4, r2
	vbic q4, q2, q1
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #16]
	veor q4, q4, q0
	ldr	r2, [sp, #8]
	umlal	r3, fp, r4, r5
	ldr	r5, [sp, #36]
	vstrw.u32 q4, [q6, #-428]
	umlal	r3, fp, r0, r1
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #72]
	vbic q4, q5, q2
	ldr	r1, [sp, #4]
	umlal	lr, r8, r0, r4
	umlal	r3, fp, r1, r4
	veor q4, q4, q1
	ldr	r4, [sp, #48]
	ldr	r0, [sp, #104]
	umlal	lr, r8, r1, r4
	vstrw.u32 q4, [q6, #-412]
	umlal	r3, fp, r6, ip
	umlal	lr, r8, r6, r0
	umlal	r3, fp, r2, r0
	vbic q4, q3, q5
	ldr	r6, [sp, #68]
	ldr	r0, [sp, #100]
	umlal	lr, r8, r2, r6
	veor q4, q4, q2
	ldr	r2, [sp]
	ldr	r6, [sp, #76]
	vstrw.u32 q4, [q6, #-396]
	umlal	r3, fp, r2, r9
	mov	ip, r3
	umlal	lr, r8, r2, r0
	vbic q4, q0, q3
	ldr	r2, [sp, #44]
	ldr	r5, [sp, #96]
	umlal	ip, fp, r0, r2
	veor q4, q4, q5
	ldrd	r0, [sp, #24]
	adds	r4, r6, r0
	umlal	lr, r8, r2, r5
	vstrw.u32 q4, [q6, #-380]
	mov	r2, r4
	adc	r3, r10, r1
	lsrl	r2, r3, #25
	vbic q4, q1, q0
	ldr	r7, [sp, #80]
	adds	ip, ip, r2
	bic	r4, r4, #-33554432
	veor q4, q4, q3
	str	r4, [r7, #28]
	mov	r4, ip
	vstrw.u32 q4, [q6, #-364]
	adc	r5, fp, r3
	lsrl	r4, r5, #26
	adds	lr, lr, r4
	vldrw.u32 q0, [q7, #-452]
	mov	r2, lr
	bic	r3, ip, #-67108864
	str	r3, [r7, #32]
	vldrw.u32 q1, [q7, #-436]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r0, r2
	vldrw.u32 q2, [q7, #-420]
	mov	r1, r3
	lsll	r0, r1, #3
	adds	r4, r0, r2
	vldrw.u32 q5, [q7, #-404]
	adc	r5, r1, r3
	adds	r4, r4, r4
	adcs	r5, r5, r5
	vldrw.u32 q3, [q7, #-388]
	adds	r4, r4, r2
	adc	r5, r5, r3
	ldr	r3, [sp, #120]
	vbic q4, q2, q1
	ldr	r1, [sp, #112]
	adds	r4, r4, r3
	veor q4, q4, q0
	mov	r2, r4
	adc	r3, r5, #0
	lsrl	r2, r3, #26
	vstrw.u32 q4, [q6, #-348]
	bic	r4, r4, #-67108864
	str	r4, [r7]
	ldr	r4, [sp, #124]
	vbic q4, q5, q2
	bic	r6, lr, #-33554432
	adds	r3, r4, r2
	bic	r2, r3, #-33554432
	veor q4, q4, q1
	add	r1, r1, r3, lsr #25
	strd	r2, r1, [r7, #4]
	str	r6, [r7, #36]
	vstrw.u32 q4, [q6, #-332]
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	vbic q4, q3, q5
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	veor q4, q4, q2
	movt r2, #:upper16:g_fc_b
	mov	lr, r2
	mov	ip, #38
	vstrw.u32 q4, [q6, #-316]
	ldr	r7, [r2, #32]
	str	r7, [sp, #100]
	ldr	r7, [r1, #32]
	vbic q4, q0, q3
	ldr	r6, [r2, #12]
	str	r7, [sp, #76]
	ldr	r7, [lr, #20]
	veor q4, q4, q5
	ldr	r3, [r2, #4]
	mul	r8, ip, r7
	ldr	r4, [r2, #8]
	vstrw.u32 q4, [q6, #-300]
	str	r6, [sp, #36]
	mul	r2, ip, r6
	str	r7, [sp, #48]
	vbic q4, q1, q0
	ldr	r6, [r1, #16]
	ldr	r7, [lr, #28]
	str	r6, [sp, #4]
	veor q4, q4, q3
	mov	r6, r7
	ldr	r5, [r1, #36]
	vstrw.u32 q4, [q6, #-284]
	str	r0, [sp, #80]
	str	r5, [sp, #92]
	mov	r5, r4
	vldrw.u32 q0, [q7, #-372]
	ldr	r0, [lr, #16]
	str	r2, [sp, #112]
	ldr	r2, [r1, #24]
	vldrw.u32 q1, [q7, #-356]
	str	r8, [sp, #108]
	str	r2, [sp, #16]
	add	r2, r0, r0, lsl #3
	vldrw.u32 q2, [q7, #-340]
	add	r10, r0, r2, lsl #1
	ldr	r2, [lr, #24]
	mul	r8, ip, r6
	vldrw.u32 q5, [q7, #-324]
	add	r7, r2, r2, lsl #3
	add	fp, r2, r7, lsl #1
	ldr	r7, [r1, #12]
	vldrw.u32 q3, [q7, #-308]
	add	r4, r4, r4, lsl #3
	str	r5, [sp, #40]
	add	r4, r5, r4, lsl #1
	vbic q4, q2, q1
	str	r3, [sp, #52]
	mul	r5, ip, r3
	veor q4, q4, q0
	str	r0, [sp, #72]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	vstrw.u32 q4, [q6, #-268]
	str	r2, [sp, #104]
	str	r6, [sp, #68]
	str	r8, [sp, #84]
	vbic q4, q5, q2
	str	r7, [sp, #24]
	ldr	r2, [lr, #36]
	ldr	r7, [r1, #8]
	veor q4, q4, q1
	mul	ip, ip, r2
	str	r7, [sp, #8]
	ldr	r7, [lr]
	vstrw.u32 q4, [q6, #-252]
	str	r2, [sp, #96]
	ldr	r2, [r1, #4]
	str	r7, [sp, #12]
	vbic q4, q3, q5
	ldr	r7, [sp, #100]
	str	r2, [sp]
	veor q4, q4, q2
	ldr	r2, [r1]
	ldr	r1, [sp, #36]
	str	ip, [sp, #64]
	vstrw.u32 q4, [q6, #-236]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	add	lr, r1, r1, lsl #3
	vbic q4, q0, q3
	ldr	r7, [sp, #76]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #32]
	veor q4, q4, q5
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #92]
	mov	r6, r3
	vstrw.u32 q4, [q6, #-220]
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	umlal	lr, ip, r10, r3
	vbic q4, q1, q0
	ldr	r3, [sp, #92]
	ldr	r7, [sp, #8]
	umlal	r4, r1, r3, r5
	veor q4, q4, q3
	mov	r8, r4
	ldr	r4, [sp, #112]
	vstrw.u32 q4, [q6, #-204]
	ldr	r5, [sp, #108]
	umlal	r8, r1, r4, r6
	ldr	r4, [sp, #16]
	vldrw.u32 q0, [q7, #-292]
	mov	r3, r6
	umlal	r8, r1, r10, r4
	umlal	r8, r1, r5, r0
	vldrw.u32 q1, [q7, #-276]
	ldr	r6, [sp, #4]
	ldr	r5, [sp, #84]
	umlal	r8, r1, fp, r6
	vldrw.u32 q2, [q7, #-260]
	ldr	r6, [sp, #24]
	umlal	r8, r1, r5, r6
	ldr	r6, [sp, #32]
	vldrw.u32 q5, [q7, #-244]
	ldr	r5, [sp]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #64]
	vldrw.u32 q3, [q7, #-228]
	umlal	r8, r1, r6, r5
	ldr	r6, [sp, #12]
	vbic q4, q2, q1
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #48]
	str	r1, [sp, #60]
	veor q4, q4, q0
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	umlal	lr, ip, r1, r4
	vstrw.u32 q4, [q6, #-188]
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	umlal	lr, ip, fp, r0
	vbic q4, q5, q2
	str	r8, [sp, #120]
	ldr	r4, [sp, #68]
	ldr	r6, [sp, #4]
	veor q4, q4, q1
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r6
	vstrw.u32 q4, [q6, #-172]
	ldr	r5, [sp, #32]
	ldr	r6, [sp, #24]
	str	r8, [sp, #116]
	vbic q4, q3, q5
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	veor q4, q4, q2
	lsrl	r6, r7, #26
	ldr	r5, [sp, #96]
	strd	r6, [sp, #56]
	vstrw.u32 q4, [q6, #-156]
	add	r8, r5, r5, lsl #3
	add	r8, r5, r8, lsl #1
	mov	r6, r8
	vbic q4, q0, q3
	ldr	r7, [sp, #8]
	ldr	r5, [sp, #12]
	umlal	lr, ip, r8, r7
	veor q4, q4, q5
	ldr	r4, [sp]
	str	r2, [sp, #44]
	umlal	lr, ip, r4, r5
	vstrw.u32 q4, [q6, #-140]
	ldr	r4, [sp, #52]
	ldr	r7, [sp, #76]
	umlal	lr, ip, r4, r2
	vbic q4, q1, q0
	lsls	r4, r4, #1
	str	r4, [sp, #88]
	veor q4, q4, q3
	ldr	r4, [sp, #56]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	vstrw.u32 q4, [q6, #-124]
	adc	r9, ip, r2
	bic	ip, r4, #-33554432
	str	ip, [sp, #124]
	vldrw.u32 q0, [q7, #-212]
	umull	r1, ip, r7, r1
	ldr	r5, [sp, #92]
	ldr	r2, [sp, #116]
	vldrw.u32 q1, [q7, #-196]
	umlal	r1, ip, r5, r10
	umlal	r1, ip, fp, r3
	mov	r8, r4
	vldrw.u32 q2, [q7, #-180]
	ldr	r4, [sp, #16]
	str	r6, [sp, #92]
	umlal	r1, ip, r2, r4
	vldrw.u32 q5, [q7, #-164]
	ldr	r2, [sp, #32]
	lsrl	r8, r9, #25
	umlal	r1, ip, r2, r0
	vldrw.u32 q3, [q7, #-148]
	mov	r2, r6
	ldr	r6, [sp, #4]
	vbic q4, q2, q1
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #12]
	veor q4, q4, q0
	umlal	r1, ip, r6, r2
	ldr	r6, [sp, #52]
	ldr	r2, [sp, #8]
	vstrw.u32 q4, [q6, #4]
	umlal	r1, ip, r2, r6
	ldr	r6, [sp, #40]
	ldr	r2, [sp]
	vbic q4, q5, q2
	umlal	r1, ip, r2, r6
	mov	lr, r1
	ldr	r6, [sp, #36]
	veor q4, q4, q1
	ldr	r1, [sp, #44]
	umlal	lr, ip, r6, r1
	str	lr, [sp, #56]
	vstrw.u32 q4, [q6, #20]
	umull	lr, r1, r10, r7
	ldr	r6, [sp, #112]
	ldr	r2, [sp, #84]
	vbic q4, q3, q5
	umlal	lr, r1, r5, r6
	ldr	r6, [sp, #108]
	veor q4, q4, q2
	umlal	lr, r1, r6, r3
	umlal	lr, r1, fp, r4
	umlal	lr, r1, r2, r0
	vstrw.u32 q4, [q6, #36]
	ldr	r6, [sp, #4]
	ldr	r2, [sp, #32]
	umlal	lr, r1, r2, r6
	vbic q4, q0, q3
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #64]
	umlal	lr, r1, r2, r6
	veor q4, q4, q5
	ldrd	r7, r2, [sp, #8]
	umlal	lr, r1, r7, r2
	ldr	r2, [sp, #88]
	vstrw.u32 q4, [q6, #52]
	ldr	r7, [sp]
	umlal	lr, r1, r7, r2
	ldrd	r7, r2, [sp, #40]
	vbic q4, q1, q0
	umlal	lr, r1, r7, r2
	adds	lr, lr, r8
	veor q4, q4, q3
	adc	r2, r1, r9
	str	lr, [sp, #16]
	str	r2, [sp, #20]
	vstrw.u32 q4, [q6, #68]
	ldrd	r8, [sp, #16]
	lsrl	r8, r9, #26
	ldr	r7, [sp, #76]
	vldrw.u32 q0, [q7, #-132]
	ldr	r2, [sp, #116]
	bic	lr, lr, #-67108864
	str	lr, [sp, #112]
	vldrw.u32 q1, [q7, #-116]
	umull	r10, lr, r7, r2
	umlal	r10, lr, r5, fp
	ldr	r2, [sp, #32]
	vldrw.u32 q2, [q7, #-100]
	str	r4, [sp, #16]
	umlal	r10, lr, r2, r3
	ldr	r2, [sp, #92]
	vldrw.u32 q5, [q7, #-84]
	str	r0, [sp, #76]
	umlal	r10, lr, r2, r4
	ldr	r2, [sp, #12]
	vldrw.u32 q3, [q7, #-68]
	ldr	r4, [sp, #4]
	umlal	r10, lr, r0, r2
	vbic q4, q2, q1
	ldr	r2, [sp, #52]
	ldr	r0, [sp, #56]
	umlal	r10, lr, r4, r2
	veor q4, q4, q0
	ldr	r4, [sp, #40]
	ldr	r1, [sp, #36]
	umlal	r10, lr, r6, r4
	vstrw.u32 q4, [q6, #84]
	ldr	r4, [sp, #36]
	ldr	r6, [sp, #8]
	ldr	r2, [sp]
	vbic q4, q5, q2
	umlal	r10, lr, r6, r4
	mov	r4, r8
	adds	r4, r0, r4
	veor q4, q4, q1
	adc	r0, ip, r9
	str	r0, [sp, #60]
	ldr	r0, [sp, #72]
	vstrw.u32 q4, [q6, #100]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r0
	vbic q4, q3, q5
	ldrd	r8, [sp, #56]
	ldr	r2, [sp, #80]
	bic	r4, r4, #-33554432
	veor q4, q4, q2
	str	r4, [r2, #12]
	umull	r4, ip, fp, r7
	ldrd	r2, r6, [sp, #44]
	vstrw.u32 q4, [q6, #116]
	ldr	r0, [sp, #108]
	lsrl	r8, r9, #25
	umlal	r4, ip, r5, r0
	vbic q4, q0, q3
	ldr	r0, [sp, #84]
	umlal	r10, lr, r6, r2
	umlal	r4, ip, r0, r3
	veor q4, q4, q5
	ldr	r2, [sp, #32]
	ldr	r0, [sp, #16]
	ldr	r6, [sp, #64]
	vstrw.u32 q4, [q6, #132]
	umlal	r4, ip, r2, r0
	ldr	r0, [sp, #76]
	ldr	r2, [sp, #12]
	vbic q4, q1, q0
	umlal	r4, ip, r6, r0
	ldr	r6, [sp, #4]
	veor q4, q4, q3
	lsls	r1, r1, #1
	umlal	r4, ip, r6, r2
	ldr	r6, [sp, #24]
	vstrw.u32 q4, [q6, #148]
	ldr	r2, [sp, #88]
	str	r10, [sp, #116]
	umlal	r4, ip, r6, r2
	vldrw.u32 q0, [q7, #-52]
	ldr	r6, [sp, #8]
	ldr	r2, [sp, #40]
	umlal	r4, ip, r6, r2
	vldrw.u32 q1, [q7, #-36]
	ldr	r2, [sp]
	ldr	r6, [sp, #72]
	umlal	r4, ip, r2, r1
	vldrw.u32 q2, [q7, #-20]
	ldr	r2, [sp, #44]
	umlal	r4, ip, r6, r2
	adds	r8, r4, r8
	vldrw.u32 q5, [q7, #-4]
	adc	ip, ip, r9
	str	r8, [sp, #56]
	vldrw.u32 q3, [q7, #12]
	str	ip, [sp, #60]
	ldrd	r10, [sp, #56]
	lsrl	r10, fp, #26
	vbic q4, q2, q1
	ldr	r2, [sp, #80]
	bic	r8, r8, #-67108864
	strd	r10, [sp, #56]
	veor q4, q4, q0
	str	r8, [r2, #16]
	ldr	r4, [sp, #48]
	ldr	r2, [sp, #12]
	vstrw.u32 q4, [q6, #164]
	lsl	ip, r4, #1
	ldr	r4, [sp, #92]
	ldr	r6, [sp, #4]
	vbic q4, q5, q2
	umull	fp, r10, r7, r4
	ldrd	r8, [sp, #56]
	ldr	r4, [sp, #32]
	veor q4, q4, q1
	umlal	fp, r10, r5, r4
	umlal	fp, r10, r3, r2
	ldr	r4, [sp, #16]
	vstrw.u32 q4, [q6, #180]
	ldr	r2, [sp, #52]
	umlal	fp, r10, r4, r2
	vbic q4, q3, q5
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	fp, r10, r0, r4
	veor q4, q4, q2
	ldr	r4, [sp, #36]
	umlal	fp, r10, r6, r4
	ldr	r6, [sp, #24]
	vstrw.u32 q4, [q6, #196]
	ldr	r4, [sp, #72]
	umlal	fp, r10, r6, r4
	mov	r4, r8
	vbic q4, q0, q3
	ldr	r6, [sp, #116]
	adds	r4, r6, r4
	ldr	r6, [sp, #48]
	veor q4, q4, q5
	str	r4, [sp, #56]
	umlal	fp, r10, r2, r6
	ldr	r2, [sp, #80]
	vstrw.u32 q4, [q6, #212]
	bic	r4, r4, #-33554432
	ldr	r6, [sp, #104]
	str	r4, [r2, #20]
	vbic q4, q1, q0
	ldr	r2, [sp]
	ldr	r4, [sp, #32]
	veor q4, q4, q3
	umlal	fp, r10, r2, r6
	adc	lr, lr, r9
	ldr	r6, [sp, #68]
	vstrw.u32 q4, [q6, #228]
	ldr	r2, [sp, #44]
	str	lr, [sp, #60]
	umull	r4, lr, r4, r7
	vldrw.u32 q0, [q7, #28]
	ldrd	r8, [sp, #56]
	umlal	fp, r10, r6, r2
	ldr	r2, [sp, #84]
	vldrw.u32 q1, [q7, #44]
	lsrl	r8, r9, #25
	umlal	r4, lr, r5, r2
	ldr	r2, [sp, #64]
	vldrw.u32 q2, [q7, #60]
	str	r3, [sp, #32]
	umlal	r4, lr, r2, r3
	ldrd	r2, r3, [sp, #12]
	vldrw.u32 q5, [q7, #76]
	umlal	r4, lr, r3, r2
	str	fp, [sp, #76]
	vldrw.u32 q3, [q7, #92]
	ldr	r3, [sp, #88]
	ldr	r6, [sp, #4]
	umlal	r4, lr, r0, r3
	vbic q4, q2, q1
	ldr	r3, [sp, #40]
	ldr	r2, [sp, #8]
	umlal	r4, lr, r6, r3
	veor q4, q4, q0
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #72]
	umlal	r4, lr, r6, r1
	vstrw.u32 q4, [q6, #244]
	umlal	r4, lr, r2, r3
	ldr	r3, [sp]
	ldr	r2, [sp, #44]
	vbic q4, q5, q2
	umlal	r4, lr, r3, ip
	ldr	r3, [sp, #104]
	strd	r8, [sp, #56]
	veor q4, q4, q1
	umlal	r4, lr, r3, r2
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	vstrw.u32 q4, [q6, #260]
	str	r8, [sp, #24]
	adc	r4, lr, r4
	vbic q4, q3, q5
	str	r4, [sp, #28]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	veor q4, q4, q2
	strd	r2, [sp, #24]
	ldr	r3, [sp, #80]
	ldr	r2, [sp, #52]
	vstrw.u32 q4, [q6, #276]
	bic	r8, r8, #-67108864
	str	r8, [r3, #24]
	ldr	r3, [sp, #68]
	vbic q4, q0, q3
	umull	lr, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #12]
	veor q4, q4, q5
	ldr	r2, [sp, #64]
	umlal	lr, r8, r5, r3
	umull	r3, fp, r7, r3
	vstrw.u32 q4, [q6, #292]
	umlal	r3, fp, r5, r2
	ldr	r4, [sp, #32]
	vbic q4, q1, q0
	ldr	r2, [sp, #88]
	ldr	r5, [sp, #40]
	umlal	r3, fp, r4, r2
	veor q4, q4, q3
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #16]
	ldr	r2, [sp, #8]
	vstrw.u32 q4, [q6, #308]
	umlal	r3, fp, r4, r5
	ldr	r5, [sp, #36]
	umlal	r3, fp, r0, r1
	vldrw.u32 q0, [q7, #108]
	umlal	lr, r8, r4, r5
	ldr	r4, [sp, #72]
	ldr	r1, [sp, #4]
	vldrw.u32 q1, [q7, #124]
	umlal	lr, r8, r0, r4
	umlal	r3, fp, r1, r4
	ldr	r4, [sp, #48]
	vldrw.u32 q2, [q7, #140]
	ldr	r0, [sp, #104]
	umlal	lr, r8, r1, r4
	umlal	r3, fp, r6, ip
	vldrw.u32 q5, [q7, #156]
	umlal	lr, r8, r6, r0
	umlal	r3, fp, r2, r0
	vldrw.u32 q3, [q7, #172]
	ldr	r6, [sp, #68]
	ldr	r0, [sp, #100]
	umlal	lr, r8, r2, r6
	vbic q4, q2, q1
	ldr	r2, [sp]
	ldr	r6, [sp, #76]
	umlal	r3, fp, r2, r9
	veor q4, q4, q0
	mov	ip, r3
	umlal	lr, r8, r2, r0
	ldr	r2, [sp, #44]
	vstrw.u32 q4, [q6, #324]
	ldr	r5, [sp, #96]
	umlal	ip, fp, r0, r2
	ldrd	r0, [sp, #24]
	vbic q4, q5, q2
	adds	r4, r6, r0
	umlal	lr, r8, r2, r5
	mov	r2, r4
	veor q4, q4, q1
	adc	r3, r10, r1
	lsrl	r2, r3, #25
	vstrw.u32 q4, [q6, #340]
	ldr	r7, [sp, #80]
	adds	ip, ip, r2
	bic	r4, r4, #-33554432
	vbic q4, q3, q5
	str	r4, [r7, #28]
	mov	r4, ip
	adc	r5, fp, r3
	veor q4, q4, q2
	lsrl	r4, r5, #26
	adds	lr, lr, r4
	mov	r2, lr
	vstrw.u32 q4, [q6, #356]
	bic	r3, ip, #-67108864
	str	r3, [r7, #32]
	adc	r3, r8, r5
	vbic q4, q0, q3
	lsrl	r2, r3, #25
	mov	r0, r2
	mov	r1, r3
	veor q4, q4, q5
	lsll	r0, r1, #3
	adds	r4, r0, r2
	adc	r5, r1, r3
	vstrw.u32 q4, [q6, #372]
	adds	r4, r4, r4
	adcs	r5, r5, r5
	vbic q4, q1, q0
	adds	r4, r4, r2
	adc	r5, r5, r3
	ldr	r3, [sp, #120]
	veor q4, q4, q3
	ldr	r1, [sp, #112]
	adds	r4, r4, r3
	mov	r2, r4
	vstrw.u32 q4, [q6, #388]
	adc	r3, r5, #0
	lsrl	r2, r3, #26
	bic	r4, r4, #-67108864
	vmov.i32 q0, #1
	str	r4, [r7]
	ldr	r4, [sp, #124]
	bic	r6, lr, #-33554432
	vldrw.u32 q1, [q6, #-508]
	adds	r3, r4, r2
	bic	r2, r3, #-33554432
	add	r1, r1, r3, lsr #25
	veor q1, q1, q0
	strd	r2, r1, [r7, #4]
	str	r6, [r7, #36]
	vstrw.u32 q1, [q6, #-508]
	ldr r0, [sp, #132]
	subs r0, r0, #1
	str r0, [sp, #132]
	bne 1b
	add sp, sp, #140
	vpop {d8-d15}
	pop {r4-r11, pc}

