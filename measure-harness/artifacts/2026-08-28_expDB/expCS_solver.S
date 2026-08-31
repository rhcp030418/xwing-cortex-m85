/* expDB: all four transformed controls and unrestricted solver kernels. */
.syntax unified
.thumb
.arch armv8.1-m.main
.arch_extension mve
.section .text.fiat_u_stitch_cs, "ax", %progbits

.global fiat_mul_u4t_p0
.type fiat_mul_u4t_p0, %function
.thumb_func
.balign 16
fiat_mul_u4t_p0:
	push {r3-r11, lr}
	sub sp, sp, #232
	push {r0-r2}
	movw r11, #:lower16:g_u_mve_block
	movt r11, #:upper16:g_u_mve_block
	ldr r11, [r11]
	add r11, r11, #508
	adr r3, 1f
	b 2f
.balign 16
1:	.word 0, 4, 8, 12
2:
	vldrw.u32 q7, [r3]
	movw r3, #:lower16:g_u_mve_block
	movt r3, #:upper16:g_u_mve_block
	ldr r3, [r3]
	add r3, r3, #1524
	vadd.i32 q7, q7, r3
	pop {r0-r2}
	mov	r12, #38
	vldrw.u32 q0, [r11, #-508]
	mov	lr, r2
	ldr	r3, [r2, #4]
	vldrw.u32 q1, [r11, #-428]
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	veor q0, q0, q1
	mul	r6, r12, r2
	str r0, [sp, #0]
	str r2, [sp, #4]
	vldrw.u32 q1, [r11, #-348]
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str r6, [sp, #8]
	veor q0, q0, q1
	str r2, [sp, #12]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	vldrw.u32 q1, [r11, #-268]
	add	r8, r0, r2, lsl #1
	str r8, [sp, #16]
	ldr	r2, [lr, #28]
	veor q0, q0, q1
	mul	r8, r12, r6
	str r6, [sp, #20]
	ldr	r6, [r1, #16]
	vldrw.u32 q1, [r11, #-188]
	str r7, [sp, #24]
	str r6, [sp, #28]
	veor q0, q0, q1
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	vstrw.u32 q0, [q7, #188]
	str r7, [sp, #32]
	ldr	r7, [lr, #24]
	str r5, [sp, #36]
	vldrw.u32 q0, [r11, #-492]
	mov	r2, r7
	mov	r5, r4
	str r8, [sp, #40]
	vldrw.u32 q1, [r11, #-412]
	mul	r8, r12, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	veor q0, q0, q1
	add	r10, r2, r7, lsl #1
	str r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	vldrw.u32 q1, [r11, #-332]
	str r3, [sp, #48]
	mul	r5, r12, r3
	str r0, [sp, #52]
	veor q0, q0, q1
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str r2, [sp, #56]
	vldrw.u32 q1, [r11, #-252]
	str r6, [sp, #60]
	str r8, [sp, #64]
	veor q0, q0, q1
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str r7, [sp, #68]
	vldrw.u32 q1, [r11, #-172]
	ldr	r7, [r1, #8]
	mul	r12, r12, r2
	str r7, [sp, #72]
	veor q0, q0, q1
	ldr	r7, [lr, #0]
	str r2, [sp, #76]
	ldr	r2, [r1, #4]
	vstrw.u32 q0, [q7, #204]
	str r7, [sp, #80]
	ldr r7, [sp, #24]
	str r2, [sp, #84]
	vldrw.u32 q0, [r11, #-476]
	ldr	r2, [r1, #0]
	ldr r1, [sp, #4]
	str r12, [sp, #88]
	vldrw.u32 q1, [r11, #-396]
	add	r12, r7, r7, lsl #3
	add	r12, r7, r12, lsl #1
	add	lr, r1, r1, lsl #3
	veor q0, q0, q1
	ldr r7, [sp, #32]
	add	lr, r1, lr, lsl #1
	vldrw.u32 q1, [r11, #-316]
	str r12, [sp, #92]
	umull	lr, r12, lr, r7
	ldr r1, [sp, #36]
	veor q0, q0, q1
	ldr r6, [sp, #16]
	umlal	lr, r12, r1, r4
	umull	r4, r1, r4, r7
	vldrw.u32 q1, [r11, #-236]
	str r3, [sp, #96]
	umlal	lr, r12, r6, r3
	ldr r3, [sp, #36]
	veor q0, q0, q1
	ldr r7, [sp, #72]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	vldrw.u32 q1, [r11, #-156]
	ldr r3, [sp, #96]
	ldr r5, [sp, #8]
	ldr r4, [sp, #12]
	veor q0, q0, q1
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	ldr r4, [sp, #40]
	vstrw.u32 q0, [q7, #220]
	ldr r5, [sp, #28]
	umlal	r8, r1, r4, r0
	umlal	r8, r1, r10, r5
	vldrw.u32 q0, [r11, #-460]
	ldr r4, [sp, #64]
	str r6, [sp, #100]
	vldrw.u32 q1, [r11, #-380]
	ldr r6, [sp, #68]
	umlal	r8, r1, r4, r6
	ldr r6, [sp, #92]
	veor q0, q0, q1
	ldr r4, [sp, #84]
	umlal	r8, r1, r6, r7
	ldr r6, [sp, #88]
	vldrw.u32 q1, [r11, #-300]
	umlal	r8, r1, r6, r4
	ldr r6, [sp, #80]
	ldr r4, [sp, #12]
	veor q0, q0, q1
	umlal	r8, r1, r6, r2
	ldr r6, [sp, #20]
	str r1, [sp, #104]
	vldrw.u32 q1, [r11, #-220]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	umlal	lr, r12, r1, r4
	veor q0, q0, q1
	ldr r4, [sp, #60]
	umlal	lr, r12, r10, r0
	str r8, [sp, #108]
	vldrw.u32 q1, [r11, #-140]
	bic	r8, r8, #-67108864
	str r8, [sp, #112]
	add	r8, r4, r4, lsl #3
	veor q0, q0, q1
	add	r8, r4, r8, lsl #1
	umlal	lr, r12, r8, r5
	vstrw.u32 q0, [q7, #236]
	ldr r6, [sp, #68]
	ldr r5, [sp, #92]
	str r0, [sp, #116]
	vldrw.u32 q0, [r11, #-444]
	umlal	lr, r12, r5, r6
	ldr r6, [sp, #108]
	ldr r7, [sp, #104]
	lsrl	r6, r7, #26
	vldrw.u32 q1, [r11, #-364]
	mov	r0, r8
	ldr r5, [sp, #76]
	str r6, [sp, #120]
	str r7, [sp, #124]
	veor q0, q0, q1
	add	r8, r5, r5, lsl #3
	ldr r7, [sp, #72]
	add	r8, r5, r8, lsl #1
	vldrw.u32 q1, [r11, #-284]
	umlal	lr, r12, r8, r7
	ldr r4, [sp, #80]
	ldr r5, [sp, #84]
	veor q0, q0, q1
	str r2, [sp, #128]
	umlal	lr, r12, r5, r4
	ldr r5, [sp, #48]
	vldrw.u32 q1, [r11, #-204]
	ldr r4, [sp, #120]
	umlal	lr, r12, r5, r2
	veor q0, q0, q1
	lsls	r2, r5, #1
	ldr r7, [sp, #32]
	str r2, [sp, #132]
	vldrw.u32 q1, [r11, #-124]
	ldr r2, [sp, #124]
	adds	r4, lr, r4
	mov	r6, r8
	veor q0, q0, q1
	adc	r9, r12, r2
	mov	r8, r4
	ldr r2, [sp, #100]
	ldr r5, [sp, #36]
	vstrw.u32 q0, [q7, #252]
	bic	r12, r4, #-33554432
	umull	r4, r1, r7, r1
	umlal	r4, r1, r5, r2
	vldrw.u32 q0, [r11, #4]
	mov	r2, r0
	umlal	r4, r1, r10, r3
	str r0, [sp, #136]
	vldrw.u32 q1, [r11, #84]
	ldr r0, [sp, #12]
	str r12, [sp, #140]
	umlal	r4, r1, r2, r0
	veor q0, q0, q1
	ldr r0, [sp, #116]
	ldr r2, [sp, #92]
	str r6, [sp, #144]
	vldrw.u32 q1, [r11, #164]
	umlal	r4, r1, r2, r0
	mov	r2, r6
	veor q0, q0, q1
	ldr r6, [sp, #28]
	lsrl	r8, r9, #25
	umlal	r4, r1, r2, r6
	vldrw.u32 q1, [r11, #244]
	ldr r6, [sp, #68]
	ldr r2, [sp, #80]
	umlal	r4, r1, r6, r2
	veor q0, q0, q1
	ldr r6, [sp, #48]
	ldr r2, [sp, #72]
	umlal	r4, r1, r2, r6
	vldrw.u32 q1, [r11, #324]
	ldr r6, [sp, #44]
	ldr r2, [sp, #84]
	umlal	r4, r1, r2, r6
	veor q0, q0, q1
	mov	r12, r4
	ldr r2, [sp, #128]
	ldr r4, [sp, #4]
	vstrw.u32 q0, [q7, #268]
	ldr r6, [sp, #28]
	umlal	r12, r1, r4, r2
	ldr r4, [sp, #100]
	vldrw.u32 q0, [r11, #20]
	str r12, [sp, #148]
	umull	lr, r12, r4, r7
	ldr r4, [sp, #8]
	vldrw.u32 q1, [r11, #100]
	ldr r2, [sp, #64]
	umlal	lr, r12, r5, r4
	veor q0, q0, q1
	ldr r4, [sp, #40]
	ldr r7, [sp, #72]
	umlal	lr, r12, r4, r3
	vldrw.u32 q1, [r11, #180]
	ldr r4, [sp, #12]
	umlal	lr, r12, r10, r4
	umlal	lr, r12, r2, r0
	veor q0, q0, q1
	ldr r2, [sp, #92]
	umlal	lr, r12, r2, r6
	ldr r6, [sp, #68]
	vldrw.u32 q1, [r11, #260]
	ldr r2, [sp, #88]
	umlal	lr, r12, r2, r6
	ldr r2, [sp, #80]
	veor q0, q0, q1
	umlal	lr, r12, r7, r2
	ldr r2, [sp, #132]
	ldr r7, [sp, #84]
	vldrw.u32 q1, [r11, #340]
	umlal	lr, r12, r7, r2
	ldr r7, [sp, #44]
	ldr r2, [sp, #128]
	umlal	lr, r12, r7, r2
	veor q0, q0, q1
	adds	lr, lr, r8
	adc	r2, r12, r9
	vstrw.u32 q0, [q7, #284]
	str lr, [sp, #152]
	str r2, [sp, #156]
	ldr r2, [sp, #4]
	vldrw.u32 q0, [r11, #36]
	ldr r8, [sp, #152]
	ldr r9, [sp, #156]
	lsrl	r8, r9, #26
	bic	r12, lr, #-67108864
	vldrw.u32 q1, [r11, #116]
	lsls	r2, r2, #1
	str r12, [sp, #160]
	str r2, [sp, #164]
	veor q0, q0, q1
	ldr r2, [sp, #136]
	ldr r7, [sp, #32]
	str r8, [sp, #168]
	str r9, [sp, #172]
	vldrw.u32 q1, [r11, #196]
	umull	lr, r12, r7, r2
	umlal	lr, r12, r5, r10
	ldr r2, [sp, #92]
	veor q0, q0, q1
	umlal	lr, r12, r2, r3
	ldr r2, [sp, #144]
	umlal	lr, r12, r2, r4
	vldrw.u32 q1, [r11, #276]
	ldr r2, [sp, #80]
	ldr r4, [sp, #28]
	umlal	lr, r12, r0, r2
	veor q0, q0, q1
	ldr r2, [sp, #48]
	umlal	lr, r12, r4, r2
	vldrw.u32 q1, [r11, #356]
	ldr r4, [sp, #44]
	ldr r2, [sp, #84]
	umlal	lr, r12, r6, r4
	veor q0, q0, q1
	ldr r4, [sp, #4]
	ldr r6, [sp, #72]
	umlal	lr, r12, r6, r4
	vstrw.u32 q0, [q7, #300]
	mov	r4, r8
	ldr r6, [sp, #148]
	adds	r4, r6, r4
	vldrw.u32 q0, [r11, #52]
	mov	r8, r4
	ldr r6, [sp, #172]
	bic	r4, r4, #-33554432
	vldrw.u32 q1, [r11, #132]
	adc	r9, r1, r6
	ldr r1, [sp, #52]
	lsrl	r8, r9, #25
	veor q0, q0, q1
	umlal	lr, r12, r2, r1
	ldr r1, [sp, #128]
	ldr r6, [sp, #20]
	umlal	lr, r12, r6, r1
	vldrw.u32 q1, [r11, #212]
	ldr r2, [sp, #0]
	str lr, [sp, #176]
	umull	lr, r1, r10, r7
	veor q0, q0, q1
	str	r4, [r2, #12]
	ldr r4, [sp, #40]
	vldrw.u32 q1, [r11, #292]
	ldr r2, [sp, #92]
	umlal	lr, r1, r5, r4
	ldr r4, [sp, #64]
	veor q0, q0, q1
	ldr r6, [sp, #88]
	umlal	lr, r1, r4, r3
	ldr r4, [sp, #12]
	vldrw.u32 q1, [r11, #372]
	umlal	lr, r1, r2, r4
	umlal	lr, r1, r6, r0
	ldr r2, [sp, #80]
	veor q0, q0, q1
	ldr r6, [sp, #28]
	umlal	lr, r1, r6, r2
	ldr r6, [sp, #68]
	vstrw.u32 q0, [q7, #316]
	ldr r2, [sp, #132]
	umlal	lr, r1, r6, r2
	ldr r6, [sp, #72]
	vldrw.u32 q0, [r11, #68]
	ldr r2, [sp, #44]
	umlal	lr, r1, r6, r2
	ldr r2, [sp, #84]
	vldrw.u32 q1, [r11, #148]
	ldr r6, [sp, #164]
	umlal	lr, r1, r2, r6
	veor q0, q0, q1
	ldr r6, [sp, #52]
	ldr r2, [sp, #128]
	umlal	lr, r1, r6, r2
	vldrw.u32 q1, [r11, #228]
	adds	lr, lr, r8
	adc	r1, r1, r9
	str lr, [sp, #180]
	veor q0, q0, q1
	str r1, [sp, #184]
	ldr r8, [sp, #180]
	ldr r9, [sp, #184]
	lsrl	r8, r9, #26
	vldrw.u32 q1, [r11, #308]
	ldr r6, [sp, #144]
	ldr r2, [sp, #0]
	bic	r1, lr, #-67108864
	veor q0, q0, q1
	umull	r10, lr, r7, r6
	str	r1, [r2, #16]
	ldr r2, [sp, #92]
	vldrw.u32 q1, [r11, #388]
	ldr r6, [sp, #48]
	umlal	r10, lr, r5, r2
	ldr r2, [sp, #80]
	veor q0, q0, q1
	str r4, [sp, #188]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	vstrw.u32 q0, [q7, #332]
	ldr r4, [sp, #44]
	ldr r6, [sp, #28]
	vldrw.u32 q0, [q7, #284]
	umlal	r10, lr, r0, r4
	ldr r4, [sp, #4]
	ldr r2, [sp, #72]
	vshl.i32 q1, q0, #1
	umlal	r10, lr, r6, r4
	ldr r6, [sp, #68]
	ldr r4, [sp, #52]
	vsri.32 q1, q0, #31
	ldr r1, [sp, #20]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	vldrw.u32 q2, [q7, #252]
	ldr r6, [sp, #176]
	lsls	r1, r1, #1
	adds	r4, r6, r4
	veor q1, q1, q2
	ldr r6, [sp, #20]
	str r4, [sp, #192]
	umlal	r10, lr, r2, r6
	vstrw.u32 q1, [q7, #348]
	ldr r2, [sp, #0]
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	vldrw.u32 q0, [q7, #204]
	ldr r4, [sp, #56]
	ldr r2, [sp, #84]
	adc	r12, r12, r9
	vldrw.u32 q2, [q7, #332]
	umlal	r10, lr, r2, r4
	ldr r4, [sp, #60]
	veor q0, q0, q2
	ldr r2, [sp, #128]
	str r12, [sp, #196]
	umlal	r10, lr, r4, r2
	vstrw.u32 q0, [q7, #428]
	ldr r8, [sp, #192]
	ldr r9, [sp, #196]
	str r10, [sp, #200]
	ldr r2, [sp, #92]
	vldrw.u32 q0, [q7, #300]
	lsrl	r8, r9, #25
	umull	r4, r12, r2, r7
	ldr r2, [sp, #64]
	vshl.i32 q1, q0, #1
	str r3, [sp, #204]
	umlal	r4, r12, r5, r2
	ldr r2, [sp, #88]
	vsri.32 q1, q0, #31
	ldr r6, [sp, #28]
	umlal	r4, r12, r2, r3
	ldr r3, [sp, #188]
	vldrw.u32 q2, [q7, #188]
	ldr r2, [sp, #80]
	str r8, [sp, #208]
	str r9, [sp, #212]
	umlal	r4, r12, r3, r2
	veor q1, q1, q2
	ldr r3, [sp, #132]
	ldr r2, [sp, #72]
	vstrw.u32 q1, [q7, #364]
	umlal	r4, r12, r0, r3
	ldr r3, [sp, #44]
	umlal	r4, r12, r6, r3
	vldrw.u32 q0, [q7, #220]
	ldr r6, [sp, #68]
	ldr r3, [sp, #164]
	umlal	r4, r12, r6, r3
	vldrw.u32 q2, [q7, #268]
	ldr r3, [sp, #52]
	umlal	r4, r12, r2, r3
	ldr r3, [sp, #84]
	veor q0, q0, q2
	ldr r2, [sp, #128]
	umlal	r4, r12, r3, r1
	ldr r3, [sp, #56]
	vstrw.u32 q0, [q7, #444]
	umlal	r4, r12, r3, r2
	adds	r8, r4, r8
	ldr r4, [sp, #212]
	vldrw.u32 q0, [q7, #316]
	str r8, [sp, #216]
	adc	r4, r12, r4
	str r4, [sp, #220]
	vshl.i32 q1, q0, #1
	ldr r2, [sp, #216]
	ldr r3, [sp, #220]
	lsrl	r2, r3, #26
	str r2, [sp, #224]
	str r3, [sp, #228]
	vsri.32 q1, q0, #31
	ldr r3, [sp, #0]
	ldr r2, [sp, #48]
	vldrw.u32 q2, [q7, #204]
	bic	r8, r8, #-67108864
	str	r8, [r3, #24]
	ldr r3, [sp, #60]
	veor q1, q1, q2
	umull	r12, r8, r7, r2
	lsl	r9, r3, #1
	ldr r3, [sp, #80]
	vstrw.u32 q1, [q7, #380]
	ldr r2, [sp, #88]
	umlal	r12, r8, r5, r3
	umull	r3, r10, r7, r3
	vldrw.u32 q0, [q7, #236]
	umlal	r3, r10, r5, r2
	ldr r2, [sp, #132]
	ldr r4, [sp, #204]
	ldr r5, [sp, #44]
	vldrw.u32 q2, [q7, #284]
	umlal	r3, r10, r4, r2
	umlal	r12, r8, r4, r5
	ldr r4, [sp, #188]
	veor q0, q0, q2
	ldr r2, [sp, #72]
	umlal	r3, r10, r4, r5
	ldr r5, [sp, #4]
	vstrw.u32 q0, [q7, #460]
	umlal	r12, r8, r4, r5
	ldr r5, [sp, #164]
	ldr r4, [sp, #52]
	vldrw.u32 q0, [q7, #332]
	umlal	r3, r10, r0, r5
	umlal	r12, r8, r0, r4
	vshl.i32 q1, q0, #1
	ldr r0, [sp, #28]
	ldr r5, [sp, #76]
	umlal	r3, r10, r0, r4
	vsri.32 q1, q0, #31
	ldr r4, [sp, #20]
	umlal	r3, r10, r6, r1
	umlal	r12, r8, r0, r4
	vldrw.u32 q2, [q7, #220]
	ldr r0, [sp, #56]
	ldr r4, [sp, #60]
	umlal	r12, r8, r6, r0
	veor q1, q1, q2
	umlal	r3, r10, r2, r0
	umlal	r12, r8, r2, r4
	ldr r0, [sp, #24]
	vstrw.u32 q1, [q7, #396]
	ldr r2, [sp, #84]
	ldr r6, [sp, #200]
	umlal	r3, r10, r2, r9
	vldrw.u32 q0, [q7, #252]
	umlal	r12, r8, r2, r0
	ldr r2, [sp, #128]
	umlal	r3, r10, r0, r2
	vldrw.u32 q2, [q7, #300]
	umlal	r12, r8, r2, r5
	ldr r2, [sp, #224]
	veor q0, q0, q2
	ldr r5, [sp, #228]
	adds	r4, r6, r2
	mov	r2, r4
	vstrw.u32 q0, [q7, #476]
	mov	r1, r3
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	vldrw.u32 q0, [q7, #268]
	ldr r0, [sp, #0]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	vshl.i32 q1, q0, #1
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	vsri.32 q1, q0, #31
	lsrl	r4, r5, #26
	adds	r12, r12, r4
	mov	r2, r12
	vldrw.u32 q2, [q7, #236]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r4, r2
	veor q1, q1, q2
	mov	r5, r3
	lsll	r4, r5, #3
	bic	r1, r1, #-67108864
	vstrw.u32 q1, [q7, #412]
	str	r1, [r0, #32]
	bic	r1, r12, #-33554432
	vldrw.u32 q0, [q7, #188]
	str	r1, [r0, #36]
	adds	r1, r4, r2
	adc	r4, r5, r3
	vldrw.u32 q2, [q7, #316]
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	veor q0, q0, q2
	adc	r4, r4, r3
	ldr r3, [sp, #112]
	adds	r1, r1, r3
	vstrw.u32 q0, [q7, #492]
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	vldrw.u32 q3, [q7, #348]
	bic	r1, r1, #-67108864
	str	r1, [r0, #0]
	ldr r1, [sp, #140]
	vldrw.u32 q4, [q7, #428]
	adds	r3, r1, r2
	ldr r1, [sp, #160]
	bic	r2, r3, #-33554432
	vldrw.u32 q0, [r11, #-508]
	add	r3, r1, r3, lsr #25
	str r2, [r0, #4]
	str r3, [r0, #8]
	add sp, sp, #232
	pop {r3-r11, pc}
.size fiat_mul_u4t_p0, .-fiat_mul_u4t_p0

.global fiat_mul_u4s_p0
.type fiat_mul_u4s_p0, %function
.thumb_func
.balign 16
fiat_mul_u4s_p0:
	push {r3-r11, lr}
	sub sp, sp, #232
	push {r0-r2}
	movw r11, #:lower16:g_u_mve_block
	movt r11, #:upper16:g_u_mve_block
	ldr r11, [r11]
	add r11, r11, #508
	adr r3, 1f
	b 2f
.balign 16
1:	.word 0, 4, 8, 12
2:
	vldrw.u32 q7, [r3]
	movw r3, #:lower16:g_u_mve_block
	movt r3, #:upper16:g_u_mve_block
	ldr r3, [r3]
	add r3, r3, #1524
	vadd.i32 q7, q7, r3
	pop {r0-r2}
	mov r12, #38
	vldrw.u32 q4, [r11, #4294966788]
	mov lr, r2
	str r0, [sp, #0]
	ldr r3, [r2, #4]
	vldrw.u32 q1, [r11, #4294966868]
	veor q4, q4, q1
	ldr r0, [r2, #32]
	ldr r4, [r2, #8]
	str r0, [sp, #24]
	ldr r0, [r2, #12]
	mul r6, r12, r0
	vldrw.u32 q0, [r11, #4294966948]
	str r0, [sp, #4]
	veor q1, q4, q0
	ldr r0, [lr, #16]
	str r6, [sp, #8]
	ldr r8, [r1, #24]
	str r8, [sp, #12]
	ldr r2, [lr, #20]
	add r6, r0, r0, lsl       #3
	vldrw.u32 q3, [r11, #4294967028]
	veor q4, q1, q3
	mul r8, r12, r2
	add r10, r0, r6, lsl       #1
	ldr r6, [lr, #28]
	str r10, [sp, #16]
	ldr r5, [r1, #16]
	str r2, [sp, #20]
	vldrw.u32 q2, [r11, #4294967108]
	str r5, [sp, #28]
	veor q3, q4, q2
	ldr r7, [r1, #32]
	mov r6, r6
	ldr r5, [r1, #36]
	str r7, [sp, #32]
	vstrw.u32 q3, [q7, #188]
	ldr r7, [lr, #24]
	str r5, [sp, #36]
	vldrw.u32 q0, [r11, #4294966804]
	mov r2, r7
	mov r5, r4
	str r8, [sp, #40]
	vldrw.u32 q1, [r11, #4294966884]
	mul r8, r12, r6
	add r7, r7, r7, lsl   #3
	add r4, r4, r4, lsl   #3
	veor q0, q0, q1
	add r10, r2, r7, lsl   #1
	str r5, [sp, #44]
	add r4, r5, r4, lsl   #1
	vldrw.u32 q1, [r11, #4294966964]
	str r3, [sp, #48]
	mul r5, r12, r3
	str r0, [sp, #52]
	veor q0, q0, q1
	ldr r3, [r1, #28]
	ldr r0, [r1, #20]
	str r2, [sp, #56]
	vldrw.u32 q1, [r11, #4294967044]
	str r6, [sp, #60]
	str r8, [sp, #64]
	ldr r8, [r1, #12]
	veor q1, q0, q1
	ldr r9, [lr, #36]
	str r8, [sp, #68]
	vldrw.u32 q3, [r11, #4294967124]
	mul r7, r12, r9
	veor q3, q1, q3
	ldr r8, [r1, #8]
	str r9, [sp, #76]
	str r8, [sp, #72]
	ldr r8, [lr, #0]
	ldr r6, [r1, #4]
	vstrw.u32 q3, [q7, #204]
	ldr r9, [sp, #24]
	str r8, [sp, #80]
	vldrw.u32 q0, [r11, #4294966820]
	str r6, [sp, #84]
	add r12, r9, r9, lsl       #3
	ldr r2, [r1, #0]
	str r7, [sp, #88]
	ldr r7, [sp, #4]
	add r9, r9, r12, lsl       #1
	vldrw.u32 q2, [r11, #4294966900]
	str r9, [sp, #92]
	add lr, r7, r7, lsl       #3
	veor q0, q0, q2
	ldr r9, [sp, #32]
	add lr, r7, lr, lsl       #1
	vldrw.u32 q3, [r11, #4294966980]
	umull lr, r12, lr, r9
	veor q0, q0, q3
	ldr r1, [sp, #36]
	ldr r6, [sp, #16]
	umlal lr, r12, r1, r4
	umull r4, r1, r4, r9
	vldrw.u32 q1, [r11, #4294967060]
	str r3, [sp, #96]
	umlal lr, r12, r6, r3
	ldr r3, [sp, #36]
	veor q0, q0, q1
	ldr r7, [sp, #72]
	umlal r4, r1, r3, r5
	mov r8, r4
	vldrw.u32 q1, [r11, #4294967140]
	ldr r3, [sp, #96]
	ldr r5, [sp, #8]
	ldr r4, [sp, #12]
	veor q0, q0, q1
	umlal r8, r1, r5, r3
	umlal r8, r1, r6, r4
	ldr r4, [sp, #40]
	vstrw.u32 q0, [q7, #220]
	ldr r5, [sp, #28]
	umlal r8, r1, r4, r0
	umlal r8, r1, r10, r5
	vldrw.u32 q0, [r11, #4294966836]
	ldr r4, [sp, #64]
	str r6, [sp, #100]
	vldrw.u32 q1, [r11, #4294966916]
	ldr r9, [sp, #68]
	veor q4, q0, q1
	umlal r8, r1, r4, r9
	ldr r4, [sp, #92]
	ldr r9, [sp, #84]
	umlal r8, r1, r4, r7
	ldr r7, [sp, #88]
	str r0, [sp, #116]
	umlal r8, r1, r7, r9
	ldr r7, [sp, #80]
	vldrw.u32 q3, [r11, #4294966996]
	umlal r8, r1, r7, r2
	veor q4, q4, q3
	ldr r7, [sp, #12]
	str r1, [sp, #104]
	ldr r9, [sp, #20]
	str r8, [sp, #108]
	vldrw.u32 q1, [r11, #4294967076]
	bic r4, r8, #-67108864
	add r8, r9, r9, lsl       #3
	veor q1, q4, q1
	ldr r6, [sp, #60]
	str r4, [sp, #112]
	add r1, r9, r8, lsl       #1
	vldrw.u32 q0, [r11, #4294967156]
	umlal lr, r12, r1, r7
	add r4, r6, r6, lsl       #3
	umlal lr, r12, r10, r0
	veor q0, q1, q0
	add r8, r6, r4, lsl       #1
	ldr r0, [sp, #68]
	umlal lr, r12, r8, r5
	ldr r5, [sp, #92]
	vstrw.u32 q0, [q7, #236]
	ldr r6, [sp, #108]
	ldr r7, [sp, #104]
	vldrw.u32 q0, [r11, #4294966852]
	umlal lr, r12, r5, r0
	lsrl r6, r7, #26
	vldrw.u32 q1, [r11, #4294966932]
	mov r0, r8
	ldr r5, [sp, #76]
	str r6, [sp, #120]
	str r7, [sp, #124]
	veor q0, q0, q1
	add r8, r5, r5, lsl   #3
	ldr r7, [sp, #72]
	add r8, r5, r8, lsl   #1
	vldrw.u32 q1, [r11, #4294967012]
	umlal lr, r12, r8, r7
	ldr r4, [sp, #80]
	ldr r5, [sp, #84]
	veor q0, q0, q1
	str r2, [sp, #128]
	umlal lr, r12, r5, r4
	ldr r5, [sp, #48]
	vldrw.u32 q1, [r11, #4294967092]
	ldr r4, [sp, #120]
	umlal lr, r12, r5, r2
	veor q0, q0, q1
	lsls r2, r5, #1
	ldr r7, [sp, #32]
	str r2, [sp, #132]
	vldrw.u32 q1, [r11, #4294967172]
	adds r2, lr, r4
	mov r6, r8
	veor q0, q0, q1
	ldr r5, [sp, #124]
	mov r8, r2
	adc r9, r12, r5
	ldr r12, [sp, #100]
	ldr r5, [sp, #36]
	vstrw.u32 q0, [q7, #252]
	bic r2, r2, #-33554432
	vldrw.u32 q2, [r11, #4]
	umull r4, r1, r7, r1
	str r0, [sp, #136]
	umlal r4, r1, r5, r12
	vldrw.u32 q4, [r11, #84]
	mov r0, r0
	umlal r4, r1, r10, r3
	ldr r12, [sp, #12]
	str r2, [sp, #140]
	umlal r4, r1, r0, r12
	ldr r0, [sp, #116]
	veor q1, q2, q4
	ldr r2, [sp, #92]
	str r6, [sp, #144]
	vldrw.u32 q4, [r11, #164]
	umlal r4, r1, r2, r0
	mov r6, r6
	veor q0, q1, q4
	ldr r2, [sp, #28]
	lsrl r8, r9, #25
	ldr r12, [sp, #68]
	umlal r4, r1, r6, r2
	ldr r6, [sp, #80]
	vldrw.u32 q1, [r11, #244]
	umlal r4, r1, r12, r6
	veor q0, q0, q1
	ldr r6, [sp, #48]
	ldr r2, [sp, #72]
	umlal r4, r1, r2, r6
	vldrw.u32 q1, [r11, #324]
	ldr r6, [sp, #44]
	ldr r2, [sp, #84]
	umlal r4, r1, r2, r6
	veor q0, q0, q1
	mov r12, r4
	ldr r2, [sp, #128]
	ldr r4, [sp, #4]
	vstrw.u32 q0, [q7, #268]
	ldr r6, [sp, #28]
	umlal r12, r1, r4, r2
	ldr r4, [sp, #100]
	vldrw.u32 q0, [r11, #20]
	str r12, [sp, #148]
	umull lr, r12, r4, r7
	ldr r4, [sp, #8]
	vldrw.u32 q1, [r11, #100]
	ldr r2, [sp, #64]
	umlal lr, r12, r5, r4
	ldr r7, [sp, #40]
	umlal lr, r12, r7, r3
	ldr r4, [sp, #12]
	umlal lr, r12, r10, r4
	ldr r7, [sp, #72]
	umlal lr, r12, r2, r0
	ldr r2, [sp, #92]
	umlal lr, r12, r2, r6
	ldr r6, [sp, #68]
	veor q2, q0, q1
	ldr r2, [sp, #88]
	umlal lr, r12, r2, r6
	ldr r2, [sp, #80]
	umlal lr, r12, r7, r2
	ldr r2, [sp, #132]
	ldr r7, [sp, #84]
	umlal lr, r12, r7, r2
	ldr r2, [sp, #44]
	ldr r7, [sp, #128]
	umlal lr, r12, r2, r7
	vldrw.u32 q1, [r11, #340]
	vldrw.u32 q4, [r11, #180]
	adds lr, lr, r8
	veor q4, q2, q4
	adc r7, r12, r9
	vldrw.u32 q3, [r11, #260]
	str lr, [sp, #152]
	veor q0, q4, q3
	str r7, [sp, #156]
	ldr r8, [sp, #152]
	bic r12, lr, #-67108864
	veor q4, q0, q1
	ldr r9, [sp, #156]
	ldr r2, [sp, #4]
	lsrl r8, r9, #26
	vstrw.u32 q4, [q7, #284]
	vldrw.u32 q0, [r11, #36]
	vldrw.u32 q1, [r11, #116]
	lsls r2, r2, #1
	str r12, [sp, #160]
	str r2, [sp, #164]
	veor q0, q0, q1
	ldr r2, [sp, #136]
	ldr r7, [sp, #32]
	str r8, [sp, #168]
	str r9, [sp, #172]
	vldrw.u32 q1, [r11, #196]
	umull lr, r12, r7, r2
	umlal lr, r12, r5, r10
	ldr r2, [sp, #92]
	veor q0, q0, q1
	umlal lr, r12, r2, r3
	ldr r2, [sp, #144]
	umlal lr, r12, r2, r4
	vldrw.u32 q1, [r11, #276]
	ldr r2, [sp, #80]
	ldr r4, [sp, #28]
	umlal lr, r12, r0, r2
	veor q0, q0, q1
	ldr r2, [sp, #48]
	umlal lr, r12, r4, r2
	vldrw.u32 q4, [r11, #356]
	veor q0, q0, q4
	mov r9, r8
	ldr r4, [sp, #44]
	vstrw.u32 q0, [q7, #300]
	ldr r2, [sp, #84]
	umlal lr, r12, r6, r4
	ldr r4, [sp, #4]
	ldr r6, [sp, #72]
	umlal lr, r12, r6, r4
	ldr r8, [sp, #148]
	adds r6, r8, r9
	vldrw.u32 q3, [r11, #52]
	mov r8, r6
	bic r4, r6, #-33554432
	ldr r9, [sp, #172]
	vldrw.u32 q4, [r11, #132]
	adc r9, r1, r9
	lsrl r8, r9, #25
	veor q4, q3, q4
	ldr r6, [sp, #52]
	umlal lr, r12, r2, r6
	ldr r2, [sp, #128]
	ldr r1, [sp, #20]
	umlal lr, r12, r1, r2
	vldrw.u32 q2, [r11, #212]
	veor q4, q4, q2
	ldr r6, [sp, #0]
	str lr, [sp, #176]
	umull lr, r1, r10, r7
	ldr r10, [sp, #40]
	str r4, [r6, #12]
	vldrw.u32 q2, [r11, #292]
	umlal lr, r1, r5, r10
	veor q0, q4, q2
	ldr r2, [sp, #92]
	ldr r4, [sp, #64]
	ldr r6, [sp, #88]
	umlal lr, r1, r4, r3
	ldr r4, [sp, #12]
	vldrw.u32 q1, [r11, #372]
	umlal lr, r1, r2, r4
	umlal lr, r1, r6, r0
	ldr r2, [sp, #80]
	veor q0, q0, q1
	ldr r6, [sp, #28]
	umlal lr, r1, r6, r2
	ldr r6, [sp, #68]
	vstrw.u32 q0, [q7, #316]
	ldr r2, [sp, #132]
	umlal lr, r1, r6, r2
	ldr r6, [sp, #72]
	vldrw.u32 q0, [r11, #68]
	ldr r2, [sp, #44]
	umlal lr, r1, r6, r2
	ldr r2, [sp, #84]
	vldrw.u32 q1, [r11, #148]
	ldr r6, [sp, #164]
	umlal lr, r1, r2, r6
	veor q0, q0, q1
	ldr r10, [sp, #52]
	str r4, [sp, #188]
	ldr r2, [sp, #128]
	umlal lr, r1, r10, r2
	vldrw.u32 q1, [r11, #228]
	veor q3, q0, q1
	adds lr, lr, r8
	ldr r8, [sp, #180]
	adc r2, r1, r9
	ldr r9, [sp, #184]
	str lr, [sp, #180]
	vldrw.u32 q1, [r11, #308]
	str r2, [sp, #184]
	lsrl r8, r9, #26
	ldr r1, [sp, #144]
	bic r2, lr, #-67108864
	ldr r6, [sp, #0]
	veor q4, q3, q1
	umull r10, lr, r7, r1
	ldr r1, [sp, #92]
	str r2, [r6, #16]
	vldrw.u32 q3, [r11, #388]
	umlal r10, lr, r5, r1
	veor q3, q4, q3
	ldr r2, [sp, #48]
	vstrw.u32 q3, [q7, #332]
	ldr r1, [sp, #80]
	umlal r10, lr, r3, r1
	ldr r6, [sp, #44]
	umlal r10, lr, r4, r2
	vldrw.u32 q0, [q7, #284]
	umlal r10, lr, r0, r6
	ldr r4, [sp, #28]
	ldr r6, [sp, #4]
	vshl.i32 q1, q0, #1
	ldr r2, [sp, #72]
	umlal r10, lr, r4, r6
	ldr r6, [sp, #68]
	ldr r4, [sp, #52]
	vsri.32 q1, q0, #31
	ldr r1, [sp, #20]
	umlal r10, lr, r6, r4
	mov r4, r8
	vldrw.u32 q2, [q7, #252]
	ldr r6, [sp, #176]
	lsls r1, r1, #1
	adds r4, r6, r4
	veor q1, q1, q2
	ldr r6, [sp, #20]
	str r4, [sp, #192]
	umlal r10, lr, r2, r6
	vstrw.u32 q1, [q7, #348]
	ldr r2, [sp, #0]
	bic r4, r4, #-33554432
	str r4, [r2, #20]
	vldrw.u32 q0, [q7, #204]
	ldr r4, [sp, #56]
	ldr r2, [sp, #84]
	adc r12, r12, r9
	vldrw.u32 q2, [q7, #332]
	umlal r10, lr, r2, r4
	ldr r9, [sp, #60]
	veor q3, q0, q2
	ldr r4, [sp, #128]
	str r12, [sp, #196]
	ldr r8, [sp, #192]
	umlal r10, lr, r9, r4
	ldr r9, [sp, #196]
	vldrw.u32 q2, [q7, #300]
	str r3, [sp, #204]
	str r10, [sp, #200]
	lsrl r8, r9, #25
	str r8, [sp, #208]
	ldr r2, [sp, #132]
	vstrw.u32 q3, [q7, #428]
	ldr r10, [sp, #44]
	vshl.i32 q3, q2, #1
	ldr r6, [sp, #68]
	str r9, [sp, #212]
	ldr r12, [sp, #92]
	umull r4, r12, r12, r7
	ldr r9, [sp, #64]
	umlal r4, r12, r5, r9
	ldr r9, [sp, #88]
	vsri.32 q3, q2, #31
	vldrw.u32 q0, [q7, #188]
	umlal r4, r12, r9, r3
	ldr r9, [sp, #188]
	ldr r3, [sp, #80]
	veor q1, q3, q0
	umlal r4, r12, r9, r3
	ldr r9, [sp, #28]
	umlal r4, r12, r0, r2
	ldr r3, [sp, #164]
	umlal r4, r12, r9, r10
	ldr r2, [sp, #72]
	vstrw.u32 q1, [q7, #364]
	vldrw.u32 q0, [q7, #220]
	umlal r4, r12, r6, r3
	vldrw.u32 q2, [q7, #268]
	ldr r3, [sp, #52]
	umlal r4, r12, r2, r3
	ldr r3, [sp, #84]
	veor q0, q0, q2
	ldr r2, [sp, #128]
	umlal r4, r12, r3, r1
	ldr r3, [sp, #56]
	vstrw.u32 q0, [q7, #444]
	umlal r4, r12, r3, r2
	adds r8, r4, r8
	ldr r4, [sp, #212]
	vldrw.u32 q0, [q7, #316]
	str r8, [sp, #216]
	adc r4, r12, r4
	str r4, [sp, #220]
	vshl.i32 q1, q0, #1
	ldr r2, [sp, #216]
	ldr r3, [sp, #220]
	lsrl r2, r3, #26
	str r2, [sp, #224]
	str r3, [sp, #228]
	vsri.32 q1, q0, #31
	ldr r4, [sp, #0]
	ldr r12, [sp, #48]
	bic r10, r8, #-67108864
	vldrw.u32 q0, [q7, #204]
	str r10, [r4, #24]
	umull r12, r8, r7, r12
	ldr r9, [sp, #60]
	veor q3, q1, q0
	ldr r3, [sp, #80]
	lsl r9, r9, #1
	ldr r2, [sp, #88]
	vstrw.u32 q3, [q7, #380]
	vldrw.u32 q0, [q7, #236]
	umlal r12, r8, r5, r3
	ldr r4, [sp, #132]
	umull r3, r10, r7, r3
	ldr r7, [sp, #204]
	umlal r3, r10, r5, r2
	ldr r5, [sp, #44]
	vldrw.u32 q4, [q7, #284]
	umlal r3, r10, r7, r4
	umlal r12, r8, r7, r5
	ldr r7, [sp, #188]
	veor q0, q0, q4
	ldr r2, [sp, #72]
	umlal r3, r10, r7, r5
	ldr r4, [sp, #4]
	vstrw.u32 q0, [q7, #460]
	ldr r5, [sp, #164]
	vldrw.u32 q0, [q7, #332]
	umlal r12, r8, r7, r4
	ldr r4, [sp, #52]
	umlal r3, r10, r0, r5
	umlal r12, r8, r0, r4
	ldr r0, [sp, #28]
	vshl.i32 q1, q0, #1
	ldr r5, [sp, #76]
	umlal r3, r10, r0, r4
	vsri.32 q1, q0, #31
	ldr r4, [sp, #20]
	umlal r3, r10, r6, r1
	umlal r12, r8, r0, r4
	vldrw.u32 q2, [q7, #220]
	ldr r0, [sp, #56]
	ldr r4, [sp, #60]
	umlal r12, r8, r6, r0
	veor q1, q1, q2
	umlal r3, r10, r2, r0
	umlal r12, r8, r2, r4
	ldr r0, [sp, #24]
	vstrw.u32 q1, [q7, #396]
	ldr r2, [sp, #84]
	ldr r6, [sp, #200]
	umlal r3, r10, r2, r9
	vldrw.u32 q0, [q7, #252]
	umlal r12, r8, r2, r0
	ldr r2, [sp, #128]
	umlal r3, r10, r0, r2
	vldrw.u32 q2, [q7, #300]
	umlal r12, r8, r2, r5
	ldr r1, [sp, #224]
	veor q1, q0, q2
	ldr r9, [sp, #228]
	adds r5, r6, r1
	vstrw.u32 q1, [q7, #476]
	mov r6, r5
	vldrw.u32 q2, [q7, #268]
	mov r3, r3
	adc r7, lr, r9
	lsrl r6, r7, #25
	ldr r0, [sp, #0]
	adds r6, r3, r6
	bic r1, r5, #-33554432
	vshl.i32 q4, q2, #1
	str r1, [r0, #28]
	mov r4, r6
	adc r5, r10, r7
	vsri.32 q4, q2, #31
	lsrl r4, r5, #26
	adds r12, r12, r4
	vldrw.u32 q1, [q7, #236]
	mov r2, r12
	adc r3, r8, r5
	lsrl r2, r3, #25
	bic r10, r6, #-67108864
	mov r8, r2
	veor q1, q4, q1
	mov r9, r3
	vstrw.u32 q1, [q7, #412]
	bic r12, r12, #-33554432
	vldrw.u32 q0, [q7, #188]
	lsll r8, r9, #3
	str r10, [r0, #32]
	str r12, [r0, #36]
	adds r1, r8, r2
	adc r4, r9, r3
	vldrw.u32 q2, [q7, #316]
	adds r1, r1, r1
	adcs r4, r4, r4
	adds r1, r1, r2
	veor q0, q0, q2
	adc r4, r4, r3
	ldr r3, [sp, #112]
	adds r1, r1, r3
	vstrw.u32 q0, [q7, #492]
	mov r2, r1
	adc r3, r4, #0
	lsrl r2, r3, #26
	vldrw.u32 q3, [q7, #348]
	bic r1, r1, #-67108864
	str r1, [r0, #0]
	ldr r1, [sp, #140]
	vldrw.u32 q4, [q7, #428]
	adds r3, r1, r2
	ldr r1, [sp, #160]
	bic r2, r3, #-33554432
	vldrw.u32 q0, [r11, #4294966788]
	add r3, r1, r3, lsr   #25
	str r2, [r0, #4]
	str r3, [r0, #8]
	add sp, sp, #232
	pop {r3-r11, pc}
.size fiat_mul_u4s_p0, .-fiat_mul_u4s_p0

.global fiat_mul_u4t_p1
.type fiat_mul_u4t_p1, %function
.thumb_func
.balign 16
fiat_mul_u4t_p1:
	push {r3-r11, lr}
	sub sp, sp, #232
	push {r0-r2}
	movw r11, #:lower16:g_u_mve_block
	movt r11, #:upper16:g_u_mve_block
	ldr r11, [r11]
	add r11, r11, #508
	adr r3, 1f
	b 2f
.balign 16
1:	.word 0, 4, 8, 12
2:
	vldrw.u32 q7, [r3]
	movw r3, #:lower16:g_u_mve_block
	movt r3, #:upper16:g_u_mve_block
	ldr r3, [r3]
	add r3, r3, #1524
	vadd.i32 q7, q7, r3
	pop {r0-r2}
	mov	r12, #38
	vldrw.u32 q1, [r11, #4]
	mov	lr, r2
	ldr	r3, [r2, #4]
	veor q0, q0, q3
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	veor q1, q1, q4
	mul	r6, r12, r2
	str r0, [sp, #0]
	str r2, [sp, #4]
	vorr.i32 q2, q0, q0
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str r6, [sp, #8]
	vstrw.u32 q2, [r11, #404]
	str r2, [sp, #12]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	vorr.i32 q5, q1, q1
	add	r8, r0, r2, lsl #1
	str r8, [sp, #16]
	ldr	r2, [lr, #28]
	vstrw.u32 q5, [q7, #-212]
	mul	r8, r12, r6
	str r6, [sp, #20]
	vldrw.u32 q0, [r11, #-428]
	ldr	r6, [r1, #16]
	str r7, [sp, #24]
	str r6, [sp, #28]
	vldrw.u32 q1, [r11, #84]
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	veor q0, q0, q3
	str r7, [sp, #32]
	ldr	r7, [lr, #24]
	str r5, [sp, #36]
	veor q1, q1, q4
	mov	r2, r7
	mov	r5, r4
	str r8, [sp, #40]
	vshl.i32 q2, q0, #18
	mul	r8, r12, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	vsri.32 q2, q0, #14
	add	r10, r2, r7, lsl #1
	str r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	vstrw.u32 q2, [q7, #-356]
	str r3, [sp, #48]
	mul	r5, r12, r3
	vshl.i32 q5, q1, #18
	str r0, [sp, #52]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	vsri.32 q5, q1, #14
	str r2, [sp, #56]
	str r6, [sp, #60]
	str r8, [sp, #64]
	vstrw.u32 q5, [q7, #44]
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str r7, [sp, #68]
	vldrw.u32 q0, [r11, #-348]
	ldr	r7, [r1, #8]
	mul	r12, r12, r2
	str r7, [sp, #72]
	vldrw.u32 q1, [r11, #164]
	ldr	r7, [lr, #0]
	str r2, [sp, #76]
	ldr	r2, [r1, #4]
	veor q0, q0, q3
	str r7, [sp, #80]
	ldr r7, [sp, #24]
	str r2, [sp, #84]
	veor q1, q1, q4
	ldr	r2, [r1, #0]
	ldr r1, [sp, #4]
	vshl.i32 q2, q1, #2
	str r12, [sp, #88]
	add	r12, r7, r7, lsl #3
	add	r12, r7, r12, lsl #1
	vsri.32 q2, q1, #30
	add	lr, r1, r1, lsl #3
	ldr r7, [sp, #32]
	add	lr, r1, lr, lsl #1
	vstrw.u32 q2, [q7, #-500]
	str r12, [sp, #92]
	umull	lr, r12, lr, r7
	ldr r1, [sp, #36]
	vshl.i32 q5, q0, #1
	ldr r6, [sp, #16]
	umlal	lr, r12, r1, r4
	umull	r4, r1, r4, r7
	vsri.32 q5, q0, #31
	str r3, [sp, #96]
	umlal	lr, r12, r6, r3
	ldr r3, [sp, #36]
	vstrw.u32 q5, [q7, #-100]
	ldr r7, [sp, #72]
	umlal	r4, r1, r3, r5
	vldrw.u32 q0, [r11, #-268]
	mov	r8, r4
	ldr r3, [sp, #96]
	ldr r5, [sp, #8]
	vldrw.u32 q1, [r11, #244]
	ldr r4, [sp, #12]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	veor q0, q0, q3
	ldr r4, [sp, #40]
	ldr r5, [sp, #28]
	umlal	r8, r1, r4, r0
	veor q1, q1, q4
	umlal	r8, r1, r10, r5
	ldr r4, [sp, #64]
	str r6, [sp, #100]
	vshl.i32 q2, q1, #21
	ldr r6, [sp, #68]
	umlal	r8, r1, r4, r6
	ldr r6, [sp, #92]
	vsri.32 q2, q1, #11
	ldr r4, [sp, #84]
	umlal	r8, r1, r6, r7
	ldr r6, [sp, #88]
	vstrw.u32 q2, [q7, #-244]
	umlal	r8, r1, r6, r4
	ldr r6, [sp, #80]
	vshl.i32 q5, q0, #20
	ldr r4, [sp, #12]
	umlal	r8, r1, r6, r2
	ldr r6, [sp, #20]
	vsri.32 q5, q0, #12
	str r1, [sp, #104]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	vstrw.u32 q5, [q7, #156]
	umlal	lr, r12, r1, r4
	ldr r4, [sp, #60]
	umlal	lr, r12, r10, r0
	vldrw.u32 q0, [r11, #-188]
	str r8, [sp, #108]
	bic	r8, r8, #-67108864
	str r8, [sp, #112]
	vldrw.u32 q1, [r11, #324]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, r12, r8, r5
	veor q0, q0, q3
	ldr r6, [sp, #68]
	ldr r5, [sp, #92]
	str r0, [sp, #116]
	veor q1, q1, q4
	umlal	lr, r12, r5, r6
	ldr r6, [sp, #108]
	ldr r7, [sp, #104]
	vshl.i32 q2, q0, #9
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr r5, [sp, #76]
	vsri.32 q2, q0, #23
	str r6, [sp, #120]
	str r7, [sp, #124]
	add	r8, r5, r5, lsl #3
	ldr r7, [sp, #72]
	vstrw.u32 q2, [q7, #-388]
	add	r8, r5, r8, lsl #1
	umlal	lr, r12, r8, r7
	ldr r4, [sp, #80]
	vshl.i32 q5, q1, #9
	ldr r5, [sp, #84]
	str r2, [sp, #128]
	umlal	lr, r12, r5, r4
	vsri.32 q5, q1, #23
	ldr r5, [sp, #48]
	ldr r4, [sp, #120]
	umlal	lr, r12, r5, r2
	vstrw.u32 q5, [q7, #12]
	lsls	r2, r5, #1
	ldr r7, [sp, #32]
	vldrw.u32 q3, [q7, #364]
	str r2, [sp, #132]
	ldr r2, [sp, #124]
	adds	r4, lr, r4
	vldrw.u32 q4, [q7, #444]
	mov	r6, r8
	adc	r9, r12, r2
	mov	r8, r4
	vldrw.u32 q0, [r11, #-492]
	ldr r2, [sp, #100]
	ldr r5, [sp, #36]
	bic	r12, r4, #-33554432
	umull	r4, r1, r7, r1
	vldrw.u32 q1, [r11, #20]
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	veor q0, q0, q3
	str r0, [sp, #136]
	ldr r0, [sp, #12]
	str r12, [sp, #140]
	veor q1, q1, q4
	umlal	r4, r1, r2, r0
	ldr r0, [sp, #116]
	ldr r2, [sp, #92]
	vshl.i32 q2, q1, #1
	str r6, [sp, #144]
	umlal	r4, r1, r2, r0
	vsri.32 q2, q1, #31
	mov	r2, r6
	ldr r6, [sp, #28]
	lsrl	r8, r9, #25
	vstrw.u32 q2, [q7, #-452]
	umlal	r4, r1, r2, r6
	ldr r6, [sp, #68]
	ldr r2, [sp, #80]
	vorr.i32 q5, q0, q0
	umlal	r4, r1, r6, r2
	ldr r6, [sp, #48]
	ldr r2, [sp, #72]
	vstrw.u32 q5, [q7, #-52]
	umlal	r4, r1, r2, r6
	ldr r6, [sp, #44]
	ldr r2, [sp, #84]
	vldrw.u32 q0, [r11, #-412]
	umlal	r4, r1, r2, r6
	mov	r12, r4
	ldr r2, [sp, #128]
	vldrw.u32 q1, [r11, #100]
	ldr r4, [sp, #4]
	ldr r6, [sp, #28]
	umlal	r12, r1, r4, r2
	veor q0, q0, q3
	ldr r4, [sp, #100]
	str r12, [sp, #148]
	veor q1, q1, q4
	umull	lr, r12, r4, r7
	ldr r4, [sp, #8]
	ldr r2, [sp, #64]
	vshl.i32 q2, q0, #22
	umlal	lr, r12, r5, r4
	ldr r4, [sp, #40]
	ldr r7, [sp, #72]
	vsri.32 q2, q0, #10
	umlal	lr, r12, r4, r3
	ldr r4, [sp, #12]
	umlal	lr, r12, r10, r4
	vstrw.u32 q2, [r11, #420]
	umlal	lr, r12, r2, r0
	ldr r2, [sp, #92]
	umlal	lr, r12, r2, r6
	vshl.i32 q5, q1, #22
	ldr r6, [sp, #68]
	ldr r2, [sp, #88]
	umlal	lr, r12, r2, r6
	vsri.32 q5, q1, #10
	ldr r2, [sp, #80]
	umlal	lr, r12, r7, r2
	vstrw.u32 q5, [q7, #-196]
	ldr r2, [sp, #132]
	ldr r7, [sp, #84]
	umlal	lr, r12, r7, r2
	vldrw.u32 q0, [r11, #-332]
	ldr r7, [sp, #44]
	ldr r2, [sp, #128]
	umlal	lr, r12, r7, r2
	adds	lr, lr, r8
	vldrw.u32 q1, [r11, #180]
	adc	r2, r12, r9
	str lr, [sp, #152]
	str r2, [sp, #156]
	veor q0, q0, q3
	ldr r2, [sp, #4]
	ldr r8, [sp, #152]
	ldr r9, [sp, #156]
	lsrl	r8, r9, #26
	veor q1, q1, q4
	bic	r12, lr, #-67108864
	lsls	r2, r2, #1
	str r12, [sp, #160]
	vshl.i32 q2, q0, #5
	str r2, [sp, #164]
	ldr r2, [sp, #136]
	ldr r7, [sp, #32]
	vsri.32 q2, q0, #27
	str r8, [sp, #168]
	str r9, [sp, #172]
	umull	lr, r12, r7, r2
	vstrw.u32 q2, [q7, #-340]
	umlal	lr, r12, r5, r10
	ldr r2, [sp, #92]
	umlal	lr, r12, r2, r3
	vshl.i32 q5, q1, #5
	ldr r2, [sp, #144]
	umlal	lr, r12, r2, r4
	ldr r2, [sp, #80]
	vsri.32 q5, q1, #27
	ldr r4, [sp, #28]
	umlal	lr, r12, r0, r2
	ldr r2, [sp, #48]
	vstrw.u32 q5, [q7, #60]
	umlal	lr, r12, r4, r2
	ldr r4, [sp, #44]
	ldr r2, [sp, #84]
	vldrw.u32 q0, [r11, #-252]
	umlal	lr, r12, r6, r4
	ldr r4, [sp, #4]
	ldr r6, [sp, #72]
	vldrw.u32 q1, [r11, #260]
	umlal	lr, r12, r6, r4
	mov	r4, r8
	ldr r6, [sp, #148]
	veor q0, q0, q3
	adds	r4, r6, r4
	mov	r8, r4
	veor q1, q1, q4
	ldr r6, [sp, #172]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	vshl.i32 q2, q1, #23
	ldr r1, [sp, #52]
	lsrl	r8, r9, #25
	umlal	lr, r12, r2, r1
	vsri.32 q2, q1, #9
	ldr r1, [sp, #128]
	ldr r6, [sp, #20]
	umlal	lr, r12, r6, r1
	ldr r2, [sp, #0]
	vstrw.u32 q2, [q7, #-484]
	str lr, [sp, #176]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	vshl.i32 q5, q0, #22
	ldr r4, [sp, #40]
	ldr r2, [sp, #92]
	umlal	lr, r1, r5, r4
	vsri.32 q5, q0, #10
	ldr r4, [sp, #64]
	ldr r6, [sp, #88]
	umlal	lr, r1, r4, r3
	vstrw.u32 q5, [q7, #-84]
	ldr r4, [sp, #12]
	umlal	lr, r1, r2, r4
	vldrw.u32 q0, [r11, #-172]
	umlal	lr, r1, r6, r0
	ldr r2, [sp, #80]
	ldr r6, [sp, #28]
	vldrw.u32 q1, [r11, #340]
	umlal	lr, r1, r6, r2
	ldr r6, [sp, #68]
	ldr r2, [sp, #132]
	veor q0, q0, q3
	umlal	lr, r1, r6, r2
	ldr r6, [sp, #72]
	ldr r2, [sp, #44]
	veor q1, q1, q4
	umlal	lr, r1, r6, r2
	ldr r2, [sp, #84]
	ldr r6, [sp, #164]
	vshl.i32 q2, q0, #1
	umlal	lr, r1, r2, r6
	ldr r6, [sp, #52]
	ldr r2, [sp, #128]
	vsri.32 q2, q0, #31
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	vstrw.u32 q2, [q7, #-228]
	adc	r1, r1, r9
	str lr, [sp, #180]
	str r1, [sp, #184]
	vshl.i32 q5, q1, #1
	ldr r8, [sp, #180]
	ldr r9, [sp, #184]
	lsrl	r8, r9, #26
	ldr r6, [sp, #144]
	vsri.32 q5, q1, #31
	ldr r2, [sp, #0]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	vstrw.u32 q5, [q7, #172]
	str	r1, [r2, #16]
	ldr r2, [sp, #92]
	ldr r6, [sp, #48]
	vldrw.u32 q3, [q7, #380]
	umlal	r10, lr, r5, r2
	ldr r2, [sp, #80]
	str r4, [sp, #188]
	vldrw.u32 q4, [q7, #460]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	ldr r4, [sp, #44]
	vldrw.u32 q0, [r11, #-476]
	ldr r6, [sp, #28]
	umlal	r10, lr, r0, r4
	vldrw.u32 q1, [r11, #36]
	ldr r4, [sp, #4]
	ldr r2, [sp, #72]
	umlal	r10, lr, r6, r4
	veor q0, q0, q3
	ldr r6, [sp, #68]
	ldr r4, [sp, #52]
	ldr r1, [sp, #20]
	veor q1, q1, q4
	umlal	r10, lr, r6, r4
	mov	r4, r8
	ldr r6, [sp, #176]
	vshl.i32 q2, q0, #31
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr r6, [sp, #20]
	vsri.32 q2, q0, #1
	str r4, [sp, #192]
	umlal	r10, lr, r2, r6
	ldr r2, [sp, #0]
	vstrw.u32 q2, [q7, #-292]
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr r4, [sp, #56]
	vshl.i32 q5, q1, #31
	ldr r2, [sp, #84]
	adc	r12, r12, r9
	vsri.32 q5, q1, #1
	umlal	r10, lr, r2, r4
	ldr r4, [sp, #60]
	ldr r2, [sp, #128]
	vstrw.u32 q5, [q7, #108]
	str r12, [sp, #196]
	umlal	r10, lr, r4, r2
	ldr r8, [sp, #192]
	ldr r9, [sp, #196]
	vldrw.u32 q0, [r11, #-396]
	str r10, [sp, #200]
	ldr r2, [sp, #92]
	lsrl	r8, r9, #25
	vldrw.u32 q1, [r11, #116]
	umull	r4, r12, r2, r7
	ldr r2, [sp, #64]
	str r3, [sp, #204]
	veor q0, q0, q3
	umlal	r4, r12, r5, r2
	ldr r2, [sp, #88]
	ldr r6, [sp, #28]
	veor q1, q1, q4
	umlal	r4, r12, r2, r3
	ldr r3, [sp, #188]
	vshl.i32 q2, q0, #3
	ldr r2, [sp, #80]
	str r8, [sp, #208]
	str r9, [sp, #212]
	umlal	r4, r12, r3, r2
	vsri.32 q2, q0, #29
	ldr r3, [sp, #132]
	ldr r2, [sp, #72]
	umlal	r4, r12, r0, r3
	vstrw.u32 q2, [q7, #-436]
	ldr r3, [sp, #44]
	umlal	r4, r12, r6, r3
	ldr r6, [sp, #68]
	vshl.i32 q5, q1, #3
	ldr r3, [sp, #164]
	umlal	r4, r12, r6, r3
	ldr r3, [sp, #52]
	vsri.32 q5, q1, #29
	umlal	r4, r12, r2, r3
	ldr r3, [sp, #84]
	ldr r2, [sp, #128]
	vstrw.u32 q5, [q7, #-36]
	umlal	r4, r12, r3, r1
	ldr r3, [sp, #56]
	umlal	r4, r12, r3, r2
	vldrw.u32 q0, [r11, #-316]
	adds	r8, r4, r8
	ldr r4, [sp, #212]
	vldrw.u32 q1, [r11, #196]
	str r8, [sp, #216]
	adc	r4, r12, r4
	str r4, [sp, #220]
	veor q0, q0, q3
	ldr r2, [sp, #216]
	ldr r3, [sp, #220]
	lsrl	r2, r3, #26
	str r2, [sp, #224]
	str r3, [sp, #228]
	veor q1, q1, q4
	ldr r3, [sp, #0]
	ldr r2, [sp, #48]
	bic	r8, r8, #-67108864
	vshl.i32 q2, q1, #22
	str	r8, [r3, #24]
	ldr r3, [sp, #60]
	umull	r12, r8, r7, r2
	vsri.32 q2, q1, #10
	lsl	r9, r3, #1
	ldr r3, [sp, #80]
	ldr r2, [sp, #88]
	vstrw.u32 q2, [r11, #436]
	umlal	r12, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	vshl.i32 q5, q0, #21
	ldr r2, [sp, #132]
	ldr r4, [sp, #204]
	ldr r5, [sp, #44]
	vsri.32 q5, q0, #11
	umlal	r3, r10, r4, r2
	umlal	r12, r8, r4, r5
	ldr r4, [sp, #188]
	vstrw.u32 q5, [q7, #-180]
	ldr r2, [sp, #72]
	umlal	r3, r10, r4, r5
	ldr r5, [sp, #4]
	vldrw.u32 q0, [r11, #-236]
	umlal	r12, r8, r4, r5
	ldr r5, [sp, #164]
	ldr r4, [sp, #52]
	vldrw.u32 q1, [r11, #276]
	umlal	r3, r10, r0, r5
	umlal	r12, r8, r0, r4
	ldr r0, [sp, #28]
	veor q0, q0, q3
	ldr r5, [sp, #76]
	umlal	r3, r10, r0, r4
	ldr r4, [sp, #20]
	veor q1, q1, q4
	umlal	r3, r10, r6, r1
	umlal	r12, r8, r0, r4
	vshl.i32 q2, q1, #8
	ldr r0, [sp, #56]
	ldr r4, [sp, #60]
	umlal	r12, r8, r6, r0
	vsri.32 q2, q1, #24
	umlal	r3, r10, r2, r0
	umlal	r12, r8, r2, r4
	ldr r0, [sp, #24]
	vstrw.u32 q2, [q7, #-324]
	ldr r2, [sp, #84]
	ldr r6, [sp, #200]
	umlal	r3, r10, r2, r9
	vshl.i32 q5, q0, #7
	umlal	r12, r8, r2, r0
	ldr r2, [sp, #128]
	umlal	r3, r10, r0, r2
	vsri.32 q5, q0, #25
	umlal	r12, r8, r2, r5
	ldr r2, [sp, #224]
	ldr r5, [sp, #228]
	vstrw.u32 q5, [q7, #76]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	vldrw.u32 q0, [r11, #-156]
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	vldrw.u32 q1, [r11, #356]
	ldr r0, [sp, #0]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
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
	bic	r1, r1, #-67108864
	vstrw.u32 q2, [q7, #-468]
	str	r1, [r0, #32]
	bic	r1, r12, #-33554432
	str	r1, [r0, #36]
	vshl.i32 q5, q0, #30
	adds	r1, r4, r2
	adc	r4, r5, r3
	vsri.32 q5, q0, #2
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	vstrw.u32 q5, [q7, #-68]
	adc	r4, r4, r3
	ldr r3, [sp, #112]
	adds	r1, r1, r3
	vldrw.u32 q3, [q7, #396]
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	vldrw.u32 q4, [q7, #476]
	bic	r1, r1, #-67108864
	str	r1, [r0, #0]
	ldr r1, [sp, #140]
	vldrw.u32 q0, [r11, #-460]
	adds	r3, r1, r2
	ldr r1, [sp, #160]
	bic	r2, r3, #-33554432
	vldrw.u32 q1, [r11, #52]
	add	r3, r1, r3, lsr #25
	str r2, [r0, #4]
	str r3, [r0, #8]
	add sp, sp, #232
	pop {r3-r11, pc}
.size fiat_mul_u4t_p1, .-fiat_mul_u4t_p1

.global fiat_mul_u4s_p1
.type fiat_mul_u4s_p1, %function
.thumb_func
.balign 16
fiat_mul_u4s_p1:
	push {r3-r11, lr}
	sub sp, sp, #232
	push {r0-r2}
	movw r11, #:lower16:g_u_mve_block
	movt r11, #:upper16:g_u_mve_block
	ldr r11, [r11]
	add r11, r11, #508
	adr r3, 1f
	b 2f
.balign 16
1:	.word 0, 4, 8, 12
2:
	vldrw.u32 q7, [r3]
	movw r3, #:lower16:g_u_mve_block
	movt r3, #:upper16:g_u_mve_block
	ldr r3, [r3]
	add r3, r3, #1524
	vadd.i32 q7, q7, r3
	pop {r0-r2}
	mov r12, #38
	vldrw.u32 q1, [r11, #4]
	mov lr, r2
	veor q5, q0, q3
	ldr r3, [r2, #4]
	veor q2, q1, q4
	ldr r10, [r2, #32]
	str r0, [sp, #0]
	ldr r4, [r2, #8]
	vorr.i32 q0, q5, q5
	ldr r5, [r2, #12]
	vstrw.u32 q0, [r11, #404]
	ldr r0, [lr, #16]
	vorr.i32 q2, q2, q2
	mul r8, r12, r5
	str r5, [sp, #4]
	ldr r5, [r1, #24]
	add r7, r0, r0, lsl       #3
	str r8, [sp, #8]
	ldr r2, [lr, #20]
	str r5, [sp, #12]
	add r9, r0, r7, lsl       #1
	str r9, [sp, #16]
	ldr r5, [lr, #28]
	vstrw.u32 q2, [q7, #-212]
	vldrw.u32 q2, [r11, #4294966868]
	mov r6, r5
	veor q0, q2, q3
	mul r8, r12, r2
	ldr r9, [r1, #16]
	str r2, [sp, #20]
	ldr r2, [r1, #32]
	str r10, [sp, #24]
	ldr r5, [r1, #36]
	str r9, [sp, #28]
	ldr r7, [lr, #24]
	vldrw.u32 q1, [r11, #84]
	str r2, [sp, #32]
	str r5, [sp, #36]
	veor q1, q1, q4
	mov r2, r7
	mov r5, r4
	str r8, [sp, #40]
	vshl.i32 q2, q0, #18
	mul r8, r12, r6
	add r7, r7, r7, lsl   #3
	add r4, r4, r4, lsl   #3
	vsri.32 q2, q0, #14
	add r10, r2, r7, lsl   #1
	str r5, [sp, #44]
	add r4, r5, r4, lsl   #1
	vstrw.u32 q2, [q7, #-356]
	str r3, [sp, #48]
	mul r5, r12, r3
	vshl.i32 q5, q1, #18
	str r0, [sp, #52]
	ldr r3, [r1, #28]
	ldr r0, [r1, #20]
	vsri.32 q5, q1, #14
	str r2, [sp, #56]
	str r6, [sp, #60]
	str r8, [sp, #64]
	ldr r9, [r1, #12]
	ldr r7, [lr, #36]
	str r9, [sp, #68]
	vldrw.u32 q0, [r11, #4294966948]
	mul r12, r12, r7
	vstrw.u32 q5, [q7, #44]
	veor q1, q0, q3
	ldr r8, [r1, #8]
	vshl.i32 q5, q1, #1
	str r8, [sp, #72]
	vldrw.u32 q0, [r11, #164]
	str r7, [sp, #76]
	veor q2, q0, q4
	ldr r8, [lr, #0]
	vshl.i32 q0, q2, #2
	ldr r2, [r1, #4]
	str r8, [sp, #80]
	ldr r7, [sp, #24]
	str r2, [sp, #84]
	ldr r2, [r1, #0]
	str r12, [sp, #88]
	ldr r8, [sp, #4]
	add r12, r7, r7, lsl       #3
	vsri.32 q0, q2, #30
	ldr r1, [sp, #32]
	add r12, r7, r12, lsl       #1
	add lr, r8, r8, lsl       #3
	vstrw.u32 q0, [q7, #-500]
	ldr r7, [sp, #36]
	add lr, r8, lr, lsl       #1
	ldr r6, [sp, #16]
	str r12, [sp, #92]
	umull lr, r12, lr, r1
	umlal lr, r12, r7, r4
	vsri.32 q5, q1, #31
	umull r4, r1, r4, r1
	str r3, [sp, #96]
	umlal lr, r12, r6, r3
	ldr r3, [sp, #36]
	vstrw.u32 q5, [q7, #-100]
	ldr r7, [sp, #72]
	umlal r4, r1, r3, r5
	vldrw.u32 q0, [r11, #4294967028]
	mov r8, r4
	ldr r3, [sp, #96]
	ldr r5, [sp, #8]
	vldrw.u32 q1, [r11, #244]
	ldr r4, [sp, #12]
	umlal r8, r1, r5, r3
	umlal r8, r1, r6, r4
	veor q0, q0, q3
	ldr r4, [sp, #40]
	ldr r5, [sp, #28]
	umlal r8, r1, r4, r0
	veor q1, q1, q4
	umlal r8, r1, r10, r5
	ldr r4, [sp, #64]
	str r6, [sp, #100]
	vshl.i32 q2, q1, #21
	ldr r9, [sp, #68]
	vsri.32 q2, q1, #11
	umlal r8, r1, r4, r9
	ldr r9, [sp, #92]
	ldr r4, [sp, #84]
	umlal r8, r1, r9, r7
	ldr r7, [sp, #88]
	vstrw.u32 q2, [q7, #-244]
	ldr r6, [sp, #80]
	vshl.i32 q2, q0, #20
	umlal r8, r1, r7, r4
	ldr r4, [sp, #12]
	umlal r8, r1, r6, r2
	ldr r9, [sp, #20]
	vsri.32 q2, q0, #12
	ldr r6, [sp, #60]
	str r1, [sp, #104]
	add r7, r9, r9, lsl       #3
	vstrw.u32 q2, [q7, #156]
	vldrw.u32 q0, [r11, #4294967108]
	add r1, r9, r7, lsl       #1
	veor q0, q0, q3
	umlal lr, r12, r1, r4
	str r8, [sp, #108]
	umlal lr, r12, r10, r0
	bic r9, r8, #-67108864
	str r9, [sp, #112]
	vldrw.u32 q5, [r11, #324]
	add r4, r6, r6, lsl       #3
	str r0, [sp, #116]
	ldr r0, [sp, #68]
	veor q1, q5, q4
	add r8, r6, r4, lsl       #1
	ldr r9, [sp, #92]
	umlal lr, r12, r8, r5
	ldr r6, [sp, #108]
	umlal lr, r12, r9, r0
	ldr r7, [sp, #104]
	vshl.i32 q2, q0, #9
	lsrl r6, r7, #26
	mov r0, r8
	ldr r5, [sp, #76]
	vsri.32 q2, q0, #23
	str r6, [sp, #120]
	str r7, [sp, #124]
	add r8, r5, r5, lsl   #3
	ldr r7, [sp, #72]
	vstrw.u32 q2, [q7, #-388]
	add r8, r5, r8, lsl   #1
	umlal lr, r12, r8, r7
	ldr r4, [sp, #80]
	vshl.i32 q5, q1, #9
	ldr r5, [sp, #84]
	str r2, [sp, #128]
	umlal lr, r12, r5, r4
	vsri.32 q5, q1, #23
	ldr r5, [sp, #48]
	ldr r4, [sp, #120]
	umlal lr, r12, r5, r2
	vstrw.u32 q5, [q7, #12]
	lsls r2, r5, #1
	ldr r7, [sp, #32]
	str r2, [sp, #132]
	vldrw.u32 q3, [q7, #364]
	adds r4, lr, r4
	mov r2, r8
	mov r8, r4
	ldr r5, [sp, #124]
	bic r6, r4, #-33554432
	vldrw.u32 q4, [q7, #444]
	adc r9, r12, r5
	umull r4, r1, r7, r1
	mov r12, r0
	vldrw.u32 q1, [r11, #4294966804]
	str r0, [sp, #136]
	veor q0, q1, q3
	str r6, [sp, #140]
	ldr r0, [sp, #100]
	str r2, [sp, #144]
	ldr r5, [sp, #36]
	mov r2, r2
	vldrw.u32 q2, [r11, #20]
	umlal r4, r1, r5, r0
	umlal r4, r1, r10, r3
	veor q2, q2, q4
	ldr r6, [sp, #12]
	vshl.i32 q5, q2, #1
	umlal r4, r1, r12, r6
	ldr r0, [sp, #116]
	ldr r6, [sp, #92]
	vsri.32 q5, q2, #31
	umlal r4, r1, r6, r0
	ldr r12, [sp, #28]
	lsrl r8, r9, #25
	ldr r6, [sp, #68]
	umlal r4, r1, r2, r12
	ldr r2, [sp, #80]
	vstrw.u32 q5, [q7, #-452]
	vorr.i32 q5, q0, q0
	umlal r4, r1, r6, r2
	ldr r6, [sp, #48]
	ldr r2, [sp, #72]
	vstrw.u32 q5, [q7, #-52]
	umlal r4, r1, r2, r6
	ldr r6, [sp, #44]
	ldr r2, [sp, #84]
	vldrw.u32 q0, [r11, #4294966884]
	umlal r4, r1, r2, r6
	mov r12, r4
	ldr r2, [sp, #128]
	vldrw.u32 q1, [r11, #100]
	ldr r4, [sp, #4]
	ldr r6, [sp, #28]
	umlal r12, r1, r4, r2
	veor q0, q0, q3
	ldr r4, [sp, #100]
	str r12, [sp, #148]
	veor q1, q1, q4
	umull lr, r12, r4, r7
	ldr r4, [sp, #8]
	ldr r2, [sp, #64]
	vshl.i32 q2, q0, #22
	umlal lr, r12, r5, r4
	ldr r7, [sp, #40]
	umlal lr, r12, r7, r3
	ldr r4, [sp, #12]
	umlal lr, r12, r10, r4
	ldr r7, [sp, #92]
	umlal lr, r12, r2, r0
	ldr r2, [sp, #80]
	umlal lr, r12, r7, r6
	ldr r6, [sp, #68]
	vsri.32 q2, q0, #10
	ldr r7, [sp, #88]
	umlal lr, r12, r7, r6
	ldr r7, [sp, #72]
	umlal lr, r12, r7, r2
	ldr r2, [sp, #132]
	vshl.i32 q5, q1, #22
	ldr r7, [sp, #84]
	umlal lr, r12, r7, r2
	ldr r7, [sp, #128]
	vstrw.u32 q2, [r11, #420]
	ldr r2, [sp, #44]
	vsri.32 q5, q1, #10
	vldrw.u32 q0, [r11, #4294966964]
	umlal lr, r12, r2, r7
	veor q0, q0, q3
	vldrw.u32 q1, [r11, #180]
	vstrw.u32 q5, [q7, #-196]
	adds lr, lr, r8
	veor q1, q1, q4
	adc r12, r12, r9
	ldr r9, [sp, #156]
	str r12, [sp, #156]
	ldr r8, [sp, #152]
	str lr, [sp, #152]
	lsrl r8, r9, #26
	ldr r2, [sp, #4]
	bic r12, lr, #-67108864
	lsls r2, r2, #1
	str r12, [sp, #160]
	vshl.i32 q2, q0, #5
	str r2, [sp, #164]
	ldr r2, [sp, #136]
	ldr r7, [sp, #32]
	vsri.32 q2, q0, #27
	str r8, [sp, #168]
	str r9, [sp, #172]
	umull lr, r12, r7, r2
	vstrw.u32 q2, [q7, #-340]
	umlal lr, r12, r5, r10
	ldr r2, [sp, #92]
	umlal lr, r12, r2, r3
	vshl.i32 q5, q1, #5
	ldr r2, [sp, #144]
	umlal lr, r12, r2, r4
	ldr r2, [sp, #80]
	vsri.32 q5, q1, #27
	ldr r4, [sp, #28]
	umlal lr, r12, r0, r2
	ldr r2, [sp, #48]
	vstrw.u32 q5, [q7, #60]
	umlal lr, r12, r4, r2
	ldr r9, [sp, #44]
	ldr r2, [sp, #84]
	umlal lr, r12, r6, r9
	vldrw.u32 q5, [r11, #4294967044]
	mov r9, r8
	veor q2, q5, q3
	ldr r6, [sp, #148]
	vshl.i32 q5, q2, #22
	ldr r4, [sp, #4]
	adds r6, r6, r9
	ldr r9, [sp, #72]
	mov r8, r6
	vldrw.u32 q1, [r11, #260]
	umlal lr, r12, r9, r4
	veor q1, q1, q4
	bic r6, r6, #-33554432
	ldr r9, [sp, #172]
	vshl.i32 q0, q1, #23
	adc r9, r1, r9
	ldr r4, [sp, #52]
	lsrl r8, r9, #25
	vsri.32 q0, q1, #9
	umlal lr, r12, r2, r4
	ldr r2, [sp, #128]
	ldr r4, [sp, #20]
	vstrw.u32 q0, [q7, #-484]
	ldr r1, [sp, #0]
	vsri.32 q5, q2, #10
	umlal lr, r12, r4, r2
	ldr r4, [sp, #40]
	str r6, [r1, #12]
	ldr r2, [sp, #92]
	str lr, [sp, #176]
	umull lr, r1, r10, r7
	umlal lr, r1, r5, r4
	ldr r4, [sp, #64]
	ldr r6, [sp, #88]
	umlal lr, r1, r4, r3
	vstrw.u32 q5, [q7, #-84]
	ldr r4, [sp, #12]
	umlal lr, r1, r2, r4
	vldrw.u32 q0, [r11, #4294967124]
	umlal lr, r1, r6, r0
	ldr r2, [sp, #80]
	ldr r6, [sp, #28]
	vldrw.u32 q1, [r11, #340]
	umlal lr, r1, r6, r2
	ldr r6, [sp, #68]
	ldr r2, [sp, #132]
	veor q0, q0, q3
	umlal lr, r1, r6, r2
	ldr r6, [sp, #72]
	ldr r2, [sp, #44]
	veor q1, q1, q4
	umlal lr, r1, r6, r2
	ldr r2, [sp, #84]
	ldr r6, [sp, #164]
	vshl.i32 q2, q0, #1
	umlal lr, r1, r2, r6
	ldr r10, [sp, #128]
	str r4, [sp, #188]
	ldr r2, [sp, #52]
	vshl.i32 q4, q1, #1
	ldr r6, [sp, #92]
	umlal lr, r1, r2, r10
	ldr r10, [sp, #0]
	vsri.32 q4, q1, #31
	adds lr, lr, r8
	ldr r8, [sp, #180]
	adc r9, r1, r9
	vldrw.u32 q3, [q7, #380]
	bic r2, lr, #-67108864
	str lr, [sp, #180]
	str r9, [sp, #184]
	ldr r9, [sp, #144]
	vldrw.u32 q1, [r11, #36]
	vsri.32 q2, q0, #31
	str r2, [r10, #16]
	umull r10, lr, r7, r9
	umlal r10, lr, r5, r6
	ldr r9, [sp, #184]
	lsrl r8, r9, #26
	ldr r2, [sp, #80]
	umlal r10, lr, r3, r2
	ldr r2, [sp, #48]
	ldr r1, [sp, #44]
	umlal r10, lr, r4, r2
	umlal r10, lr, r0, r1
	ldr r2, [sp, #28]
	vstrw.u32 q4, [q7, #172]
	ldr r4, [sp, #4]
	vldrw.u32 q0, [r11, #4294966820]
	veor q0, q0, q3
	umlal r10, lr, r2, r4
	vstrw.u32 q2, [q7, #-228]
	ldr r2, [sp, #72]
	vldrw.u32 q4, [q7, #460]
	ldr r6, [sp, #68]
	ldr r4, [sp, #52]
	ldr r1, [sp, #20]
	veor q1, q1, q4
	umlal r10, lr, r6, r4
	mov r4, r8
	ldr r6, [sp, #176]
	vshl.i32 q2, q0, #31
	lsls r1, r1, #1
	adds r4, r6, r4
	ldr r6, [sp, #20]
	vsri.32 q2, q0, #1
	str r4, [sp, #192]
	umlal r10, lr, r2, r6
	ldr r2, [sp, #0]
	vstrw.u32 q2, [q7, #-292]
	bic r4, r4, #-33554432
	str r4, [r2, #20]
	ldr r4, [sp, #56]
	vshl.i32 q5, q1, #31
	ldr r2, [sp, #84]
	adc r12, r12, r9
	vsri.32 q5, q1, #1
	umlal r10, lr, r2, r4
	ldr r9, [sp, #128]
	ldr r6, [sp, #60]
	str r3, [sp, #204]
	vldrw.u32 q0, [r11, #4294966900]
	umlal r10, lr, r6, r9
	vstrw.u32 q5, [q7, #108]
	veor q0, q0, q3
	ldr r2, [sp, #92]
	vshl.i32 q2, q0, #3
	vldrw.u32 q5, [r11, #116]
	str r12, [sp, #196]
	umull r4, r12, r2, r7
	vsri.32 q2, q0, #29
	ldr r9, [sp, #196]
	str r10, [sp, #200]
	veor q1, q5, q4
	ldr r8, [sp, #192]
	ldr r10, [sp, #80]
	lsrl r8, r9, #25
	ldr r6, [sp, #88]
	str r8, [sp, #208]
	ldr r2, [sp, #28]
	str r9, [sp, #212]
	ldr r9, [sp, #64]
	vshl.i32 q5, q1, #3
	umlal r4, r12, r5, r9
	ldr r9, [sp, #44]
	umlal r4, r12, r6, r3
	ldr r6, [sp, #188]
	umlal r4, r12, r6, r10
	ldr r3, [sp, #132]
	umlal r4, r12, r0, r3
	ldr r6, [sp, #68]
	umlal r4, r12, r2, r9
	ldr r3, [sp, #164]
	vstrw.u32 q2, [q7, #-436]
	ldr r2, [sp, #72]
	umlal r4, r12, r6, r3
	ldr r3, [sp, #52]
	vsri.32 q5, q1, #29
	umlal r4, r12, r2, r3
	ldr r3, [sp, #84]
	ldr r2, [sp, #128]
	vstrw.u32 q5, [q7, #-36]
	umlal r4, r12, r3, r1
	ldr r3, [sp, #56]
	umlal r4, r12, r3, r2
	vldrw.u32 q0, [r11, #4294966980]
	adds r8, r4, r8
	ldr r4, [sp, #212]
	vldrw.u32 q1, [r11, #196]
	str r8, [sp, #216]
	adc r4, r12, r4
	str r4, [sp, #220]
	veor q0, q0, q3
	ldr r2, [sp, #216]
	ldr r3, [sp, #220]
	lsrl r2, r3, #26
	str r2, [sp, #224]
	str r3, [sp, #228]
	ldr r2, [sp, #88]
	veor q5, q1, q4
	ldr r9, [sp, #0]
	bic r4, r8, #-67108864
	ldr r3, [sp, #48]
	vshl.i32 q2, q0, #21
	umull r12, r8, r7, r3
	ldr r3, [sp, #60]
	vsri.32 q2, q0, #11
	vldrw.u32 q0, [r11, #4294967060]
	str r4, [r9, #24]
	lsl r9, r3, #1
	ldr r10, [sp, #80]
	vstrw.u32 q2, [q7, #-180]
	vshl.i32 q2, q5, #22
	vldrw.u32 q1, [r11, #276]
	umlal r12, r8, r5, r10
	veor q0, q0, q3
	umull r3, r10, r7, r10
	ldr r7, [sp, #204]
	umlal r3, r10, r5, r2
	ldr r4, [sp, #132]
	umlal r3, r10, r7, r4
	ldr r4, [sp, #188]
	vsri.32 q2, q5, #10
	ldr r5, [sp, #44]
	umlal r12, r8, r7, r5
	ldr r2, [sp, #4]
	umlal r12, r8, r4, r2
	ldr r2, [sp, #72]
	umlal r3, r10, r4, r5
	ldr r4, [sp, #52]
	umlal r12, r8, r0, r4
	ldr r7, [sp, #164]
	umlal r3, r10, r0, r7
	ldr r5, [sp, #76]
	vstrw.u32 q2, [r11, #436]
	ldr r0, [sp, #28]
	umlal r3, r10, r0, r4
	ldr r4, [sp, #20]
	veor q1, q1, q4
	umlal r3, r10, r6, r1
	umlal r12, r8, r0, r4
	vshl.i32 q2, q1, #8
	ldr r0, [sp, #56]
	ldr r4, [sp, #60]
	umlal r12, r8, r6, r0
	vsri.32 q2, q1, #24
	umlal r3, r10, r2, r0
	umlal r12, r8, r2, r4
	ldr r0, [sp, #24]
	vstrw.u32 q2, [q7, #-324]
	ldr r2, [sp, #84]
	ldr r6, [sp, #200]
	umlal r3, r10, r2, r9
	vshl.i32 q5, q0, #7
	umlal r12, r8, r2, r0
	ldr r2, [sp, #128]
	umlal r3, r10, r0, r2
	vsri.32 q5, q0, #25
	umlal r12, r8, r2, r5
	ldr r0, [sp, #224]
	ldr r1, [sp, #228]
	vstrw.u32 q5, [q7, #76]
	adds r2, r6, r0
	vldrw.u32 q1, [r11, #4294967140]
	mov r4, r2
	mov r6, r3
	adc r5, lr, r1
	vldrw.u32 q0, [r11, #356]
	lsrl r4, r5, #25
	bic r7, r2, #-33554432
	ldr r0, [sp, #0]
	adds r4, r6, r4
	veor q3, q1, q3
	str r7, [r0, #28]
	mov r2, r4
	adc r3, r10, r5
	veor q1, q0, q4
	lsrl r2, r3, #26
	adds r7, r12, r2
	vshl.i32 q2, q1, #31
	mov r2, r7
	adc r3, r8, r3
	lsrl r2, r3, #25
	vsri.32 q2, q1, #1
	mov r8, r2
	mov r9, r3
	lsll r8, r9, #3
	bic r5, r4, #-67108864
	vstrw.u32 q2, [q7, #-468]
	bic r7, r7, #-33554432
	vshl.i32 q5, q3, #30
	adds r1, r8, r2
	str r5, [r0, #32]
	adc r4, r9, r3
	str r7, [r0, #36]
	vsri.32 q5, q3, #2
	adds r1, r1, r1
	adcs r4, r4, r4
	adds r1, r1, r2
	vstrw.u32 q5, [q7, #-68]
	adc r4, r4, r3
	ldr r3, [sp, #112]
	adds r1, r1, r3
	vldrw.u32 q3, [q7, #396]
	mov r2, r1
	adc r3, r4, #0
	lsrl r2, r3, #26
	vldrw.u32 q4, [q7, #476]
	bic r1, r1, #-67108864
	str r1, [r0, #0]
	ldr r1, [sp, #140]
	vldrw.u32 q0, [r11, #4294966836]
	adds r3, r1, r2
	ldr r1, [sp, #160]
	bic r2, r3, #-33554432
	vldrw.u32 q1, [r11, #52]
	add r3, r1, r3, lsr   #25
	str r2, [r0, #4]
	str r3, [r0, #8]
	add sp, sp, #232
	pop {r3-r11, pc}
.size fiat_mul_u4s_p1, .-fiat_mul_u4s_p1

.global fiat_mul_u4t_p2
.type fiat_mul_u4t_p2, %function
.thumb_func
.balign 16
fiat_mul_u4t_p2:
	push {r3-r11, lr}
	sub sp, sp, #232
	push {r0-r2}
	movw r11, #:lower16:g_u_mve_block
	movt r11, #:upper16:g_u_mve_block
	ldr r11, [r11]
	add r11, r11, #508
	adr r3, 1f
	b 2f
.balign 16
1:	.word 0, 4, 8, 12
2:
	vldrw.u32 q7, [r3]
	movw r3, #:lower16:g_u_mve_block
	movt r3, #:upper16:g_u_mve_block
	ldr r3, [r3]
	add r3, r3, #1524
	vadd.i32 q7, q7, r3
	pop {r0-r2}
	mov	r12, #38
	veor q0, q0, q3
	mov	lr, r2
	ldr	r3, [r2, #4]
	veor q1, q1, q4
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	vshl.i32 q2, q0, #14
	mul	r6, r12, r2
	str r0, [sp, #0]
	str r2, [sp, #4]
	vsri.32 q2, q0, #18
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str r6, [sp, #8]
	vstrw.u32 q2, [r11, #484]
	str r2, [sp, #12]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	vshl.i32 q5, q1, #14
	add	r8, r0, r2, lsl #1
	str r8, [sp, #16]
	ldr	r2, [lr, #28]
	vsri.32 q5, q1, #18
	mul	r8, r12, r6
	str r6, [sp, #20]
	vstrw.u32 q5, [q7, #-132]
	ldr	r6, [r1, #16]
	str r7, [sp, #24]
	str r6, [sp, #28]
	vldrw.u32 q0, [r11, #-380]
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	vldrw.u32 q1, [r11, #132]
	str r7, [sp, #32]
	ldr	r7, [lr, #24]
	str r5, [sp, #36]
	veor q0, q0, q3
	mov	r2, r7
	mov	r5, r4
	str r8, [sp, #40]
	veor q1, q1, q4
	mul	r8, r12, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	vshl.i32 q2, q1, #28
	add	r10, r2, r7, lsl #1
	str r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	vsri.32 q2, q1, #4
	str r3, [sp, #48]
	mul	r5, r12, r3
	vstrw.u32 q2, [q7, #-276]
	str r0, [sp, #52]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	vshl.i32 q5, q0, #27
	str r2, [sp, #56]
	str r6, [sp, #60]
	str r8, [sp, #64]
	vsri.32 q5, q0, #5
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str r7, [sp, #68]
	vstrw.u32 q5, [q7, #124]
	ldr	r7, [r1, #8]
	mul	r12, r12, r2
	str r7, [sp, #72]
	vldrw.u32 q0, [r11, #-300]
	ldr	r7, [lr, #0]
	str r2, [sp, #76]
	ldr	r2, [r1, #4]
	vldrw.u32 q1, [r11, #212]
	str r7, [sp, #80]
	ldr r7, [sp, #24]
	str r2, [sp, #84]
	veor q0, q0, q3
	ldr	r2, [r1, #0]
	ldr r1, [sp, #4]
	veor q1, q1, q4
	str r12, [sp, #88]
	add	r12, r7, r7, lsl #3
	add	r12, r7, r12, lsl #1
	vshl.i32 q2, q1, #13
	add	lr, r1, r1, lsl #3
	ldr r7, [sp, #32]
	add	lr, r1, lr, lsl #1
	vsri.32 q2, q1, #19
	str r12, [sp, #92]
	umull	lr, r12, lr, r7
	ldr r1, [sp, #36]
	vstrw.u32 q2, [q7, #-420]
	ldr r6, [sp, #16]
	umlal	lr, r12, r1, r4
	umull	r4, r1, r4, r7
	vshl.i32 q5, q0, #12
	str r3, [sp, #96]
	umlal	lr, r12, r6, r3
	ldr r3, [sp, #36]
	vsri.32 q5, q0, #20
	ldr r7, [sp, #72]
	umlal	r4, r1, r3, r5
	vstrw.u32 q5, [q7, #-20]
	mov	r8, r4
	ldr r3, [sp, #96]
	ldr r5, [sp, #8]
	vldrw.u32 q0, [r11, #-220]
	ldr r4, [sp, #12]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	vldrw.u32 q1, [r11, #292]
	ldr r4, [sp, #40]
	ldr r5, [sp, #28]
	umlal	r8, r1, r4, r0
	veor q0, q0, q3
	umlal	r8, r1, r10, r5
	ldr r4, [sp, #64]
	str r6, [sp, #100]
	veor q1, q1, q4
	ldr r6, [sp, #68]
	umlal	r8, r1, r4, r6
	ldr r6, [sp, #92]
	vshl.i32 q2, q1, #11
	ldr r4, [sp, #84]
	umlal	r8, r1, r6, r7
	ldr r6, [sp, #88]
	vsri.32 q2, q1, #21
	umlal	r8, r1, r6, r4
	ldr r6, [sp, #80]
	vstrw.u32 q2, [r11, #452]
	ldr r4, [sp, #12]
	umlal	r8, r1, r6, r2
	ldr r6, [sp, #20]
	vshl.i32 q5, q0, #10
	str r1, [sp, #104]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	vsri.32 q5, q0, #22
	umlal	lr, r12, r1, r4
	ldr r4, [sp, #60]
	umlal	lr, r12, r10, r0
	vstrw.u32 q5, [q7, #-164]
	str r8, [sp, #108]
	bic	r8, r8, #-67108864
	str r8, [sp, #112]
	vldrw.u32 q0, [r11, #-140]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, r12, r8, r5
	vldrw.u32 q1, [r11, #372]
	ldr r6, [sp, #68]
	ldr r5, [sp, #92]
	str r0, [sp, #116]
	veor q0, q0, q3
	umlal	lr, r12, r5, r6
	ldr r6, [sp, #108]
	ldr r7, [sp, #104]
	veor q1, q1, q4
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr r5, [sp, #76]
	vshl.i32 q2, q0, #28
	str r6, [sp, #120]
	str r7, [sp, #124]
	add	r8, r5, r5, lsl #3
	ldr r7, [sp, #72]
	vsri.32 q2, q0, #4
	add	r8, r5, r8, lsl #1
	umlal	lr, r12, r8, r7
	ldr r4, [sp, #80]
	vstrw.u32 q2, [q7, #-308]
	ldr r5, [sp, #84]
	str r2, [sp, #128]
	umlal	lr, r12, r5, r4
	vshl.i32 q5, q1, #28
	ldr r5, [sp, #48]
	ldr r4, [sp, #120]
	umlal	lr, r12, r5, r2
	vsri.32 q5, q1, #4
	lsls	r2, r5, #1
	ldr r7, [sp, #32]
	vstrw.u32 q5, [q7, #92]
	str r2, [sp, #132]
	ldr r2, [sp, #124]
	adds	r4, lr, r4
	vldrw.u32 q3, [q7, #412]
	mov	r6, r8
	adc	r9, r12, r2
	mov	r8, r4
	vldrw.u32 q4, [q7, #492]
	ldr r2, [sp, #100]
	ldr r5, [sp, #36]
	bic	r12, r4, #-33554432
	umull	r4, r1, r7, r1
	vldrw.u32 q0, [r11, #-444]
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	vldrw.u32 q1, [r11, #68]
	str r0, [sp, #136]
	ldr r0, [sp, #12]
	str r12, [sp, #140]
	veor q0, q0, q3
	umlal	r4, r1, r2, r0
	ldr r0, [sp, #116]
	ldr r2, [sp, #92]
	veor q1, q1, q4
	str r6, [sp, #144]
	umlal	r4, r1, r2, r0
	vshl.i32 q2, q1, #14
	mov	r2, r6
	ldr r6, [sp, #28]
	lsrl	r8, r9, #25
	vsri.32 q2, q1, #18
	umlal	r4, r1, r2, r6
	ldr r6, [sp, #68]
	ldr r2, [sp, #80]
	vstrw.u32 q2, [q7, #-372]
	umlal	r4, r1, r6, r2
	ldr r6, [sp, #48]
	ldr r2, [sp, #72]
	vshl.i32 q5, q0, #13
	umlal	r4, r1, r2, r6
	ldr r6, [sp, #44]
	ldr r2, [sp, #84]
	vsri.32 q5, q0, #19
	umlal	r4, r1, r2, r6
	mov	r12, r4
	ldr r2, [sp, #128]
	vstrw.u32 q5, [q7, #28]
	ldr r4, [sp, #4]
	ldr r6, [sp, #28]
	umlal	r12, r1, r4, r2
	vldrw.u32 q0, [r11, #-364]
	ldr r4, [sp, #100]
	str r12, [sp, #148]
	vldrw.u32 q1, [r11, #148]
	umull	lr, r12, r4, r7
	ldr r4, [sp, #8]
	ldr r2, [sp, #64]
	veor q0, q0, q3
	umlal	lr, r12, r5, r4
	ldr r4, [sp, #40]
	ldr r7, [sp, #72]
	veor q1, q1, q4
	umlal	lr, r12, r4, r3
	ldr r4, [sp, #12]
	umlal	lr, r12, r10, r4
	vshl.i32 q2, q0, #10
	umlal	lr, r12, r2, r0
	ldr r2, [sp, #92]
	umlal	lr, r12, r2, r6
	vsri.32 q2, q0, #22
	ldr r6, [sp, #68]
	ldr r2, [sp, #88]
	umlal	lr, r12, r2, r6
	vstrw.u32 q2, [r11, #500]
	ldr r2, [sp, #80]
	umlal	lr, r12, r7, r2
	vshl.i32 q5, q1, #10
	ldr r2, [sp, #132]
	ldr r7, [sp, #84]
	umlal	lr, r12, r7, r2
	vsri.32 q5, q1, #22
	ldr r7, [sp, #44]
	ldr r2, [sp, #128]
	umlal	lr, r12, r7, r2
	adds	lr, lr, r8
	vstrw.u32 q5, [q7, #-116]
	adc	r2, r12, r9
	str lr, [sp, #152]
	str r2, [sp, #156]
	vldrw.u32 q0, [r11, #-284]
	ldr r2, [sp, #4]
	ldr r8, [sp, #152]
	ldr r9, [sp, #156]
	lsrl	r8, r9, #26
	vldrw.u32 q1, [r11, #228]
	bic	r12, lr, #-67108864
	lsls	r2, r2, #1
	str r12, [sp, #160]
	veor q0, q0, q3
	str r2, [sp, #164]
	ldr r2, [sp, #136]
	ldr r7, [sp, #32]
	veor q1, q1, q4
	str r8, [sp, #168]
	str r9, [sp, #172]
	umull	lr, r12, r7, r2
	vshl.i32 q2, q1, #20
	umlal	lr, r12, r5, r10
	ldr r2, [sp, #92]
	umlal	lr, r12, r2, r3
	vsri.32 q2, q1, #12
	ldr r2, [sp, #144]
	umlal	lr, r12, r2, r4
	ldr r2, [sp, #80]
	vstrw.u32 q2, [q7, #-260]
	ldr r4, [sp, #28]
	umlal	lr, r12, r0, r2
	ldr r2, [sp, #48]
	vshl.i32 q5, q0, #19
	umlal	lr, r12, r4, r2
	ldr r4, [sp, #44]
	ldr r2, [sp, #84]
	vsri.32 q5, q0, #13
	umlal	lr, r12, r6, r4
	ldr r4, [sp, #4]
	ldr r6, [sp, #72]
	vstrw.u32 q5, [q7, #140]
	umlal	lr, r12, r6, r4
	mov	r4, r8
	ldr r6, [sp, #148]
	vldrw.u32 q0, [r11, #-204]
	adds	r4, r6, r4
	mov	r8, r4
	vldrw.u32 q1, [r11, #308]
	ldr r6, [sp, #172]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	veor q0, q0, q3
	ldr r1, [sp, #52]
	lsrl	r8, r9, #25
	umlal	lr, r12, r2, r1
	veor q1, q1, q4
	ldr r1, [sp, #128]
	ldr r6, [sp, #20]
	umlal	lr, r12, r6, r1
	ldr r2, [sp, #0]
	vshl.i32 q2, q0, #4
	str lr, [sp, #176]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	vsri.32 q2, q0, #28
	ldr r4, [sp, #40]
	ldr r2, [sp, #92]
	umlal	lr, r1, r5, r4
	vstrw.u32 q2, [q7, #-404]
	ldr r4, [sp, #64]
	ldr r6, [sp, #88]
	umlal	lr, r1, r4, r3
	vshl.i32 q5, q1, #4
	ldr r4, [sp, #12]
	umlal	lr, r1, r2, r4
	vsri.32 q5, q1, #28
	umlal	lr, r1, r6, r0
	ldr r2, [sp, #80]
	ldr r6, [sp, #28]
	vstrw.u32 q5, [q7, #-4]
	umlal	lr, r1, r6, r2
	ldr r6, [sp, #68]
	ldr r2, [sp, #132]
	vldrw.u32 q0, [r11, #-124]
	umlal	lr, r1, r6, r2
	ldr r6, [sp, #72]
	ldr r2, [sp, #44]
	vldrw.u32 q1, [r11, #388]
	umlal	lr, r1, r6, r2
	ldr r2, [sp, #84]
	ldr r6, [sp, #164]
	veor q0, q0, q3
	umlal	lr, r1, r2, r6
	ldr r6, [sp, #52]
	ldr r2, [sp, #128]
	veor q1, q1, q4
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	vshl.i32 q2, q0, #7
	adc	r1, r1, r9
	str lr, [sp, #180]
	str r1, [sp, #184]
	vsri.32 q2, q0, #25
	ldr r8, [sp, #180]
	ldr r9, [sp, #184]
	lsrl	r8, r9, #26
	ldr r6, [sp, #144]
	vstrw.u32 q2, [r11, #468]
	ldr r2, [sp, #0]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	vshl.i32 q5, q1, #7
	str	r1, [r2, #16]
	ldr r2, [sp, #92]
	ldr r6, [sp, #48]
	vsri.32 q5, q1, #25
	umlal	r10, lr, r5, r2
	ldr r2, [sp, #80]
	str r4, [sp, #188]
	vstrw.u32 q5, [q7, #-148]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	ldr r4, [sp, #44]
	vldrw.u32 q0, [r11, #404]
	ldr r6, [sp, #28]
	umlal	r10, lr, r0, r4
	vldrw.u32 q1, [r11, #420]
	ldr r4, [sp, #4]
	ldr r2, [sp, #72]
	umlal	r10, lr, r6, r4
	vldrw.u32 q2, [r11, #436]
	ldr r6, [sp, #68]
	ldr r4, [sp, #52]
	ldr r1, [sp, #20]
	vldrw.u32 q5, [r11, #452]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	ldr r6, [sp, #176]
	vldrw.u32 q6, [r11, #468]
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr r6, [sp, #20]
	vbic q3, q2, q1
	str r4, [sp, #192]
	umlal	r10, lr, r2, r6
	ldr r2, [sp, #0]
	veor q3, q3, q0
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr r4, [sp, #56]
	vstrw.u32 q3, [r11, #-508]
	ldr r2, [sp, #84]
	adc	r12, r12, r9
	vbic q3, q5, q2
	umlal	r10, lr, r2, r4
	ldr r4, [sp, #60]
	ldr r2, [sp, #128]
	veor q3, q3, q1
	str r12, [sp, #196]
	umlal	r10, lr, r4, r2
	ldr r8, [sp, #192]
	ldr r9, [sp, #196]
	vstrw.u32 q3, [r11, #-492]
	str r10, [sp, #200]
	ldr r2, [sp, #92]
	lsrl	r8, r9, #25
	vbic q3, q6, q5
	umull	r4, r12, r2, r7
	ldr r2, [sp, #64]
	str r3, [sp, #204]
	veor q3, q3, q2
	umlal	r4, r12, r5, r2
	ldr r2, [sp, #88]
	ldr r6, [sp, #28]
	vstrw.u32 q3, [r11, #-476]
	umlal	r4, r12, r2, r3
	ldr r3, [sp, #188]
	vbic q3, q0, q6
	ldr r2, [sp, #80]
	str r8, [sp, #208]
	str r9, [sp, #212]
	umlal	r4, r12, r3, r2
	veor q3, q3, q5
	ldr r3, [sp, #132]
	ldr r2, [sp, #72]
	umlal	r4, r12, r0, r3
	vstrw.u32 q3, [r11, #-460]
	ldr r3, [sp, #44]
	umlal	r4, r12, r6, r3
	ldr r6, [sp, #68]
	vbic q3, q1, q0
	ldr r3, [sp, #164]
	umlal	r4, r12, r6, r3
	ldr r3, [sp, #52]
	veor q3, q3, q6
	umlal	r4, r12, r2, r3
	ldr r3, [sp, #84]
	ldr r2, [sp, #128]
	vstrw.u32 q3, [r11, #-444]
	umlal	r4, r12, r3, r1
	ldr r3, [sp, #56]
	umlal	r4, r12, r3, r2
	vldrw.u32 q0, [r11, #484]
	adds	r8, r4, r8
	ldr r4, [sp, #212]
	vldrw.u32 q1, [r11, #500]
	str r8, [sp, #216]
	adc	r4, r12, r4
	str r4, [sp, #220]
	vldrw.u32 q2, [q7, #-500]
	ldr r2, [sp, #216]
	ldr r3, [sp, #220]
	lsrl	r2, r3, #26
	str r2, [sp, #224]
	str r3, [sp, #228]
	vldrw.u32 q5, [q7, #-484]
	ldr r3, [sp, #0]
	ldr r2, [sp, #48]
	bic	r8, r8, #-67108864
	vldrw.u32 q6, [q7, #-468]
	str	r8, [r3, #24]
	ldr r3, [sp, #60]
	umull	r12, r8, r7, r2
	vbic q3, q2, q1
	lsl	r9, r3, #1
	ldr r3, [sp, #80]
	ldr r2, [sp, #88]
	veor q3, q3, q0
	umlal	r12, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	vstrw.u32 q3, [r11, #-428]
	ldr r2, [sp, #132]
	ldr r4, [sp, #204]
	ldr r5, [sp, #44]
	vbic q3, q5, q2
	umlal	r3, r10, r4, r2
	umlal	r12, r8, r4, r5
	ldr r4, [sp, #188]
	veor q3, q3, q1
	ldr r2, [sp, #72]
	umlal	r3, r10, r4, r5
	ldr r5, [sp, #4]
	vstrw.u32 q3, [r11, #-412]
	umlal	r12, r8, r4, r5
	ldr r5, [sp, #164]
	ldr r4, [sp, #52]
	vbic q3, q6, q5
	umlal	r3, r10, r0, r5
	umlal	r12, r8, r0, r4
	ldr r0, [sp, #28]
	veor q3, q3, q2
	ldr r5, [sp, #76]
	umlal	r3, r10, r0, r4
	ldr r4, [sp, #20]
	vstrw.u32 q3, [r11, #-396]
	umlal	r3, r10, r6, r1
	umlal	r12, r8, r0, r4
	vbic q3, q0, q6
	ldr r0, [sp, #56]
	ldr r4, [sp, #60]
	umlal	r12, r8, r6, r0
	veor q3, q3, q5
	umlal	r3, r10, r2, r0
	umlal	r12, r8, r2, r4
	ldr r0, [sp, #24]
	vstrw.u32 q3, [r11, #-380]
	ldr r2, [sp, #84]
	ldr r6, [sp, #200]
	umlal	r3, r10, r2, r9
	vbic q3, q1, q0
	umlal	r12, r8, r2, r0
	ldr r2, [sp, #128]
	umlal	r3, r10, r0, r2
	veor q3, q3, q6
	umlal	r12, r8, r2, r5
	ldr r2, [sp, #224]
	ldr r5, [sp, #228]
	vstrw.u32 q3, [r11, #-364]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	vldrw.u32 q0, [q7, #-452]
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	vldrw.u32 q1, [q7, #-436]
	ldr r0, [sp, #0]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	vldrw.u32 q2, [q7, #-420]
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	vldrw.u32 q5, [q7, #-404]
	lsrl	r4, r5, #26
	adds	r12, r12, r4
	mov	r2, r12
	vldrw.u32 q6, [q7, #-388]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r4, r2
	vbic q3, q2, q1
	mov	r5, r3
	lsll	r4, r5, #3
	bic	r1, r1, #-67108864
	veor q3, q3, q0
	str	r1, [r0, #32]
	bic	r1, r12, #-33554432
	str	r1, [r0, #36]
	vstrw.u32 q3, [r11, #-348]
	adds	r1, r4, r2
	adc	r4, r5, r3
	vbic q3, q5, q2
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	veor q3, q3, q1
	adc	r4, r4, r3
	ldr r3, [sp, #112]
	adds	r1, r1, r3
	vstrw.u32 q3, [r11, #-332]
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	vbic q3, q6, q5
	bic	r1, r1, #-67108864
	str	r1, [r0, #0]
	ldr r1, [sp, #140]
	veor q3, q3, q2
	adds	r3, r1, r2
	ldr r1, [sp, #160]
	bic	r2, r3, #-33554432
	vstrw.u32 q3, [r11, #-316]
	add	r3, r1, r3, lsr #25
	str r2, [r0, #4]
	str r3, [r0, #8]
	add sp, sp, #232
	pop {r3-r11, pc}
.size fiat_mul_u4t_p2, .-fiat_mul_u4t_p2

.global fiat_mul_u4s_p2
.type fiat_mul_u4s_p2, %function
.thumb_func
.balign 16
fiat_mul_u4s_p2:
	push {r3-r11, lr}
	sub sp, sp, #232
	push {r0-r2}
	movw r11, #:lower16:g_u_mve_block
	movt r11, #:upper16:g_u_mve_block
	ldr r11, [r11]
	add r11, r11, #508
	adr r3, 1f
	b 2f
.balign 16
1:	.word 0, 4, 8, 12
2:
	vldrw.u32 q7, [r3]
	movw r3, #:lower16:g_u_mve_block
	movt r3, #:upper16:g_u_mve_block
	ldr r3, [r3]
	add r3, r3, #1524
	vadd.i32 q7, q7, r3
	pop {r0-r2}
	mov r12, #38
	veor q5, q0, q3
	mov lr, r2
	ldr r3, [r2, #4]
	veor q0, q1, q4
	ldr r7, [r2, #32]
	ldr r4, [r2, #8]
	vshl.i32 q6, q5, #14
	ldr r9, [r2, #12]
	str r0, [sp, #0]
	mul r8, r12, r9
	str r9, [sp, #4]
	vsri.32 q6, q5, #18
	ldr r0, [lr, #16]
	ldr r10, [r1, #24]
	str r8, [sp, #8]
	vstrw.u32 q6, [r11, #484]
	ldr r2, [lr, #20]
	add r9, r0, r0, lsl       #3
	vshl.i32 q6, q0, #14
	str r10, [sp, #12]
	ldr r10, [lr, #28]
	add r5, r0, r9, lsl       #1
	vsri.32 q6, q0, #18
	str r5, [sp, #16]
	ldr r9, [r1, #16]
	mul r8, r12, r2
	vldrw.u32 q0, [r11, #4294966916]
	str r2, [sp, #20]
	mov r6, r10
	str r7, [sp, #24]
	ldr r2, [r1, #32]
	str r9, [sp, #28]
	ldr r5, [r1, #36]
	str r2, [sp, #32]
	ldr r7, [lr, #24]
	vstrw.u32 q6, [q7, #-132]
	vldrw.u32 q1, [r11, #132]
	str r5, [sp, #36]
	veor q0, q0, q3
	mov r2, r7
	mov r5, r4
	str r8, [sp, #40]
	veor q1, q1, q4
	mul r8, r12, r6
	add r7, r7, r7, lsl   #3
	add r4, r4, r4, lsl   #3
	vshl.i32 q2, q1, #28
	add r10, r2, r7, lsl   #1
	str r5, [sp, #44]
	add r4, r5, r4, lsl   #1
	vsri.32 q2, q1, #4
	str r3, [sp, #48]
	mul r5, r12, r3
	vstrw.u32 q2, [q7, #-276]
	str r0, [sp, #52]
	ldr r3, [r1, #28]
	ldr r0, [r1, #20]
	vshl.i32 q5, q0, #27
	str r2, [sp, #56]
	str r6, [sp, #60]
	str r8, [sp, #64]
	vsri.32 q5, q0, #5
	ldr r8, [r1, #12]
	str r3, [sp, #96]
	ldr r2, [lr, #36]
	str r8, [sp, #68]
	ldr r6, [r1, #8]
	mul r9, r12, r2
	str r6, [sp, #72]
	vldrw.u32 q1, [r11, #4294966996]
	vstrw.u32 q5, [q7, #124]
	veor q0, q1, q3
	ldr r7, [lr, #0]
	vshl.i32 q5, q0, #12
	str r2, [sp, #76]
	ldr r6, [r1, #4]
	vldrw.u32 q1, [r11, #212]
	str r7, [sp, #80]
	str r6, [sp, #84]
	veor q2, q1, q4
	ldr r12, [sp, #24]
	vshl.i32 q6, q2, #13
	ldr r7, [sp, #4]
	str r9, [sp, #88]
	ldr r2, [r1, #0]
	vsri.32 q6, q2, #19
	add r8, r12, r12, lsl       #3
	add lr, r7, r7, lsl       #3
	ldr r1, [sp, #32]
	vstrw.u32 q6, [q7, #-420]
	add lr, r7, lr, lsl       #1
	ldr r7, [sp, #36]
	add r6, r12, r8, lsl       #1
	umull lr, r12, lr, r1
	str r6, [sp, #92]
	umlal lr, r12, r7, r4
	ldr r6, [sp, #16]
	umull r4, r1, r4, r1
	umlal lr, r12, r6, r3
	ldr r3, [sp, #36]
	vsri.32 q5, q0, #20
	ldr r7, [sp, #72]
	umlal r4, r1, r3, r5
	vstrw.u32 q5, [q7, #-20]
	mov r8, r4
	ldr r3, [sp, #96]
	ldr r5, [sp, #8]
	vldrw.u32 q0, [r11, #4294967076]
	ldr r4, [sp, #12]
	umlal r8, r1, r5, r3
	umlal r8, r1, r6, r4
	vldrw.u32 q1, [r11, #292]
	ldr r4, [sp, #40]
	ldr r5, [sp, #28]
	umlal r8, r1, r4, r0
	veor q0, q0, q3
	umlal r8, r1, r10, r5
	ldr r4, [sp, #64]
	str r6, [sp, #100]
	veor q1, q1, q4
	ldr r6, [sp, #68]
	vshl.i32 q6, q1, #11
	umlal r8, r1, r4, r6
	ldr r4, [sp, #88]
	ldr r6, [sp, #92]
	vsri.32 q6, q1, #21
	umlal r8, r1, r6, r7
	ldr r7, [sp, #84]
	umlal r8, r1, r4, r7
	ldr r4, [sp, #80]
	vstrw.u32 q6, [r11, #452]
	ldr r7, [sp, #104]
	vldrw.u32 q6, [r11, #4294967156]
	vshl.i32 q5, q0, #10
	umlal r8, r1, r4, r2
	str r0, [sp, #116]
	ldr r4, [sp, #20]
	vsri.32 q5, q0, #22
	str r1, [sp, #104]
	ldr r9, [sp, #60]
	add r6, r4, r4, lsl       #3
	vstrw.u32 q5, [q7, #-164]
	vldrw.u32 q1, [r11, #372]
	veor q0, q6, q3
	add r1, r4, r6, lsl       #1
	str r8, [sp, #108]
	ldr r6, [sp, #12]
	add r4, r9, r9, lsl       #3
	umlal lr, r12, r1, r6
	bic r8, r8, #-67108864
	str r8, [sp, #112]
	umlal lr, r12, r10, r0
	add r8, r9, r4, lsl       #1
	ldr r4, [sp, #68]
	umlal lr, r12, r8, r5
	ldr r0, [sp, #92]
	umlal lr, r12, r0, r4
	ldr r6, [sp, #108]
	veor q1, q1, q4
	lsrl r6, r7, #26
	mov r0, r8
	ldr r5, [sp, #76]
	vshl.i32 q2, q0, #28
	str r6, [sp, #120]
	str r7, [sp, #124]
	add r8, r5, r5, lsl   #3
	ldr r7, [sp, #72]
	vsri.32 q2, q0, #4
	add r8, r5, r8, lsl   #1
	umlal lr, r12, r8, r7
	ldr r4, [sp, #80]
	vstrw.u32 q2, [q7, #-308]
	ldr r5, [sp, #84]
	str r2, [sp, #128]
	umlal lr, r12, r5, r4
	vshl.i32 q5, q1, #28
	ldr r5, [sp, #48]
	ldr r4, [sp, #120]
	umlal lr, r12, r5, r2
	vsri.32 q5, q1, #4
	lsls r2, r5, #1
	ldr r7, [sp, #32]
	vstrw.u32 q5, [q7, #92]
	ldr r9, [sp, #124]
	adds r4, lr, r4
	str r2, [sp, #132]
	vldrw.u32 q3, [q7, #412]
	mov r6, r8
	adc r9, r12, r9
	mov r8, r4
	vldrw.u32 q4, [q7, #492]
	bic r5, r4, #-33554432
	umull r4, r1, r7, r1
	ldr r2, [sp, #100]
	mov r12, r0
	vldrw.u32 q1, [r11, #4294966852]
	str r0, [sp, #136]
	str r5, [sp, #140]
	veor q0, q1, q3
	vldrw.u32 q5, [r11, #68]
	str r6, [sp, #144]
	veor q5, q5, q4
	mov r6, r6
	ldr r5, [sp, #36]
	vshl.i32 q6, q5, #14
	umlal r4, r1, r5, r2
	ldr r2, [sp, #12]
	umlal r4, r1, r10, r3
	ldr r0, [sp, #116]
	umlal r4, r1, r12, r2
	ldr r12, [sp, #92]
	umlal r4, r1, r12, r0
	ldr r12, [sp, #28]
	lsrl r8, r9, #25
	vsri.32 q6, q5, #18
	umlal r4, r1, r6, r12
	ldr r6, [sp, #68]
	ldr r2, [sp, #80]
	vstrw.u32 q6, [q7, #-372]
	umlal r4, r1, r6, r2
	ldr r6, [sp, #48]
	ldr r2, [sp, #72]
	vshl.i32 q5, q0, #13
	umlal r4, r1, r2, r6
	ldr r6, [sp, #44]
	ldr r2, [sp, #84]
	vsri.32 q5, q0, #19
	umlal r4, r1, r2, r6
	mov r12, r4
	ldr r2, [sp, #128]
	vstrw.u32 q5, [q7, #28]
	ldr r4, [sp, #4]
	ldr r6, [sp, #28]
	umlal r12, r1, r4, r2
	vldrw.u32 q0, [r11, #4294966932]
	ldr r4, [sp, #100]
	str r12, [sp, #148]
	vldrw.u32 q1, [r11, #148]
	umull lr, r12, r4, r7
	ldr r4, [sp, #8]
	ldr r2, [sp, #64]
	veor q0, q0, q3
	umlal lr, r12, r5, r4
	ldr r7, [sp, #40]
	ldr r4, [sp, #12]
	umlal lr, r12, r7, r3
	umlal lr, r12, r10, r4
	ldr r7, [sp, #88]
	umlal lr, r12, r2, r0
	ldr r2, [sp, #92]
	umlal lr, r12, r2, r6
	ldr r6, [sp, #68]
	umlal lr, r12, r7, r6
	ldr r2, [sp, #72]
	veor q1, q1, q4
	ldr r7, [sp, #80]
	umlal lr, r12, r2, r7
	ldr r7, [sp, #84]
	vshl.i32 q6, q1, #10
	ldr r2, [sp, #132]
	umlal lr, r12, r7, r2
	ldr r7, [sp, #44]
	ldr r2, [sp, #128]
	vsri.32 q6, q1, #22
	umlal lr, r12, r7, r2
	ldr r2, [sp, #4]
	vstrw.u32 q6, [q7, #-116]
	vshl.i32 q6, q0, #10
	adds lr, lr, r8
	vldrw.u32 q1, [r11, #228]
	adc r7, r12, r9
	str lr, [sp, #152]
	str r7, [sp, #156]
	ldr r8, [sp, #152]
	vsri.32 q6, q0, #22
	ldr r9, [sp, #156]
	bic r12, lr, #-67108864
	lsrl r8, r9, #26
	vstrw.u32 q6, [r11, #500]
	vldrw.u32 q0, [r11, #4294967012]
	lsls r2, r2, #1
	str r12, [sp, #160]
	veor q0, q0, q3
	str r2, [sp, #164]
	ldr r2, [sp, #136]
	ldr r7, [sp, #32]
	veor q1, q1, q4
	str r8, [sp, #168]
	str r9, [sp, #172]
	umull lr, r12, r7, r2
	vshl.i32 q2, q1, #20
	umlal lr, r12, r5, r10
	ldr r2, [sp, #92]
	umlal lr, r12, r2, r3
	vsri.32 q2, q1, #12
	ldr r2, [sp, #144]
	umlal lr, r12, r2, r4
	ldr r2, [sp, #80]
	vstrw.u32 q2, [q7, #-260]
	ldr r4, [sp, #28]
	umlal lr, r12, r0, r2
	ldr r2, [sp, #48]
	vshl.i32 q5, q0, #19
	umlal lr, r12, r4, r2
	ldr r2, [sp, #44]
	ldr r4, [sp, #84]
	vsri.32 q5, q0, #13
	umlal lr, r12, r6, r2
	ldr r2, [sp, #4]
	ldr r6, [sp, #72]
	vstrw.u32 q5, [q7, #140]
	mov r8, r8
	ldr r9, [sp, #148]
	umlal lr, r12, r6, r2
	vldrw.u32 q6, [r11, #4294967092]
	adds r9, r9, r8
	veor q0, q6, q3
	mov r8, r9
	vldrw.u32 q1, [r11, #308]
	bic r6, r9, #-33554432
	veor q1, q1, q4
	ldr r9, [sp, #172]
	vshl.i32 q5, q0, #4
	adc r9, r1, r9
	ldr r2, [sp, #52]
	lsrl r8, r9, #25
	ldr r1, [sp, #128]
	umlal lr, r12, r4, r2
	ldr r2, [sp, #20]
	umlal lr, r12, r2, r1
	ldr r2, [sp, #0]
	str r6, [r2, #12]
	vsri.32 q5, q0, #28
	str lr, [sp, #176]
	umull lr, r1, r10, r7
	ldr r6, [sp, #40]
	vstrw.u32 q5, [q7, #-404]
	ldr r2, [sp, #92]
	umlal lr, r1, r5, r6
	ldr r4, [sp, #64]
	ldr r6, [sp, #88]
	umlal lr, r1, r4, r3
	vshl.i32 q5, q1, #4
	ldr r4, [sp, #12]
	umlal lr, r1, r2, r4
	vsri.32 q5, q1, #28
	umlal lr, r1, r6, r0
	ldr r2, [sp, #80]
	ldr r6, [sp, #28]
	vstrw.u32 q5, [q7, #-4]
	umlal lr, r1, r6, r2
	ldr r6, [sp, #68]
	ldr r2, [sp, #132]
	vldrw.u32 q0, [r11, #4294967172]
	umlal lr, r1, r6, r2
	ldr r6, [sp, #72]
	ldr r2, [sp, #44]
	vldrw.u32 q1, [r11, #388]
	umlal lr, r1, r6, r2
	ldr r2, [sp, #84]
	ldr r6, [sp, #164]
	veor q0, q0, q3
	umlal lr, r1, r2, r6
	ldr r10, [sp, #52]
	veor q5, q1, q4
	ldr r6, [sp, #128]
	vshl.i32 q2, q0, #7
	umlal lr, r1, r10, r6
	ldr r10, [sp, #144]
	vsri.32 q2, q0, #25
	ldr r2, [sp, #0]
	adds lr, lr, r8
	ldr r8, [sp, #180]
	adc r6, r1, r9
	vldrw.u32 q1, [r11, #420]
	str r6, [sp, #184]
	bic r9, lr, #-67108864
	str lr, [sp, #180]
	ldr r1, [sp, #48]
	vstrw.u32 q2, [r11, #468]
	ldr r6, [sp, #92]
	vshl.i32 q6, q5, #7
	vldrw.u32 q0, [r11, #404]
	str r9, [r2, #16]
	umull r10, lr, r7, r10
	ldr r2, [sp, #4]
	vsri.32 q6, q5, #25
	umlal r10, lr, r5, r6
	ldr r9, [sp, #80]
	umlal r10, lr, r3, r9
	ldr r9, [sp, #44]
	umlal r10, lr, r4, r1
	ldr r6, [sp, #28]
	umlal r10, lr, r0, r9
	ldr r9, [sp, #184]
	lsrl r8, r9, #26
	vldrw.u32 q2, [r11, #436]
	str r4, [sp, #188]
	umlal r10, lr, r6, r2
	vstrw.u32 q6, [q7, #-148]
	ldr r2, [sp, #72]
	ldr r6, [sp, #68]
	ldr r4, [sp, #52]
	ldr r1, [sp, #20]
	vldrw.u32 q5, [r11, #452]
	umlal r10, lr, r6, r4
	mov r4, r8
	ldr r6, [sp, #176]
	vldrw.u32 q6, [r11, #468]
	lsls r1, r1, #1
	adds r4, r6, r4
	ldr r6, [sp, #20]
	vbic q3, q2, q1
	str r4, [sp, #192]
	umlal r10, lr, r2, r6
	ldr r2, [sp, #0]
	veor q3, q3, q0
	bic r4, r4, #-33554432
	str r4, [r2, #20]
	ldr r4, [sp, #56]
	vstrw.u32 q3, [r11, #4294966788]
	ldr r2, [sp, #84]
	adc r12, r12, r9
	vbic q3, q5, q2
	umlal r10, lr, r2, r4
	ldr r2, [sp, #60]
	ldr r6, [sp, #128]
	veor q3, q3, q1
	str r12, [sp, #196]
	umlal r10, lr, r2, r6
	ldr r8, [sp, #192]
	vstrw.u32 q3, [r11, #4294966804]
	ldr r9, [sp, #196]
	vbic q3, q6, q5
	str r10, [sp, #200]
	ldr r4, [sp, #92]
	lsrl r8, r9, #25
	ldr r2, [sp, #64]
	umull r4, r12, r4, r7
	str r3, [sp, #204]
	veor q3, q3, q2
	umlal r4, r12, r5, r2
	ldr r2, [sp, #88]
	vstrw.u32 q3, [r11, #4294966820]
	ldr r10, [sp, #28]
	vbic q2, q0, q6
	umlal r4, r12, r2, r3
	ldr r6, [sp, #188]
	ldr r3, [sp, #80]
	str r8, [sp, #208]
	str r9, [sp, #212]
	umlal r4, r12, r6, r3
	veor q2, q2, q5
	ldr r3, [sp, #132]
	ldr r2, [sp, #72]
	umlal r4, r12, r0, r3
	vstrw.u32 q2, [r11, #4294966836]
	ldr r3, [sp, #44]
	ldr r6, [sp, #68]
	vbic q3, q1, q0
	umlal r4, r12, r10, r3
	ldr r3, [sp, #164]
	umlal r4, r12, r6, r3
	ldr r3, [sp, #52]
	veor q3, q3, q6
	umlal r4, r12, r2, r3
	ldr r3, [sp, #84]
	ldr r2, [sp, #128]
	vstrw.u32 q3, [r11, #4294966852]
	umlal r4, r12, r3, r1
	ldr r3, [sp, #56]
	umlal r4, r12, r3, r2
	vldrw.u32 q0, [r11, #484]
	adds r8, r4, r8
	ldr r4, [sp, #212]
	vldrw.u32 q1, [r11, #500]
	str r8, [sp, #216]
	adc r4, r12, r4
	str r4, [sp, #220]
	vldrw.u32 q2, [q7, #-500]
	ldr r2, [sp, #216]
	ldr r3, [sp, #220]
	lsrl r2, r3, #26
	str r2, [sp, #224]
	str r3, [sp, #228]
	vldrw.u32 q5, [q7, #-484]
	vbic q3, q2, q1
	bic r8, r8, #-67108864
	veor q6, q3, q0
	ldr r9, [sp, #0]
	vstrw.u32 q6, [r11, #4294966868]
	ldr r12, [sp, #48]
	vbic q3, q5, q2
	vldrw.u32 q6, [q7, #-468]
	str r8, [r9, #24]
	umull r12, r8, r7, r12
	veor q3, q3, q1
	ldr r9, [sp, #60]
	vstrw.u32 q3, [r11, #4294966884]
	ldr r3, [sp, #80]
	vbic q3, q6, q5
	lsl r9, r9, #1
	ldr r4, [sp, #88]
	umlal r12, r8, r5, r3
	ldr r2, [sp, #132]
	umull r3, r10, r7, r3
	ldr r7, [sp, #204]
	umlal r3, r10, r5, r4
	ldr r4, [sp, #44]
	umlal r3, r10, r7, r2
	ldr r5, [sp, #188]
	umlal r12, r8, r7, r4
	ldr r2, [sp, #72]
	umlal r3, r10, r5, r4
	ldr r7, [sp, #4]
	umlal r12, r8, r5, r7
	ldr r5, [sp, #164]
	ldr r4, [sp, #52]
	umlal r3, r10, r0, r5
	umlal r12, r8, r0, r4
	ldr r0, [sp, #28]
	veor q3, q3, q2
	ldr r5, [sp, #76]
	umlal r3, r10, r0, r4
	ldr r4, [sp, #20]
	vstrw.u32 q3, [r11, #4294966900]
	umlal r3, r10, r6, r1
	umlal r12, r8, r0, r4
	vbic q3, q0, q6
	ldr r0, [sp, #56]
	ldr r4, [sp, #60]
	umlal r12, r8, r6, r0
	veor q3, q3, q5
	umlal r3, r10, r2, r0
	umlal r12, r8, r2, r4
	ldr r0, [sp, #24]
	vstrw.u32 q3, [r11, #4294966916]
	ldr r2, [sp, #84]
	ldr r6, [sp, #200]
	umlal r3, r10, r2, r9
	vbic q3, q1, q0
	umlal r12, r8, r2, r0
	ldr r2, [sp, #128]
	umlal r3, r10, r0, r2
	veor q3, q3, q6
	umlal r12, r8, r2, r5
	ldr r9, [sp, #224]
	ldr r1, [sp, #228]
	vstrw.u32 q3, [r11, #4294966932]
	adds r6, r6, r9
	vldrw.u32 q0, [q7, #-452]
	mov r2, r6
	mov r9, r3
	adc r3, lr, r1
	vldrw.u32 q1, [q7, #-436]
	lsrl r2, r3, #25
	bic r6, r6, #-33554432
	ldr r0, [sp, #0]
	adds r9, r9, r2
	vldrw.u32 q2, [q7, #-420]
	str r6, [r0, #28]
	mov r6, r9
	adc r7, r10, r3
	vldrw.u32 q5, [q7, #-404]
	lsrl r6, r7, #26
	adds r6, r12, r6
	vbic q3, q2, q1
	mov r2, r6
	vldrw.u32 q6, [q7, #-388]
	adc r3, r8, r7
	bic r9, r9, #-67108864
	lsrl r2, r3, #25
	veor q3, q3, q0
	mov r4, r2
	mov r5, r3
	lsll r4, r5, #3
	str r9, [r0, #32]
	bic r6, r6, #-33554432
	vstrw.u32 q3, [r11, #4294966948]
	adds r1, r4, r2
	vbic q3, q5, q2
	str r6, [r0, #36]
	adc r4, r5, r3
	adds r1, r1, r1
	adcs r4, r4, r4
	adds r1, r1, r2
	veor q3, q3, q1
	adc r4, r4, r3
	ldr r3, [sp, #112]
	adds r1, r1, r3
	vstrw.u32 q3, [r11, #4294966964]
	mov r2, r1
	adc r3, r4, #0
	lsrl r2, r3, #26
	vbic q3, q6, q5
	bic r1, r1, #-67108864
	str r1, [r0, #0]
	ldr r1, [sp, #140]
	veor q3, q3, q2
	adds r3, r1, r2
	ldr r1, [sp, #160]
	bic r2, r3, #-33554432
	vstrw.u32 q3, [r11, #4294966980]
	add r3, r1, r3, lsr   #25
	str r2, [r0, #4]
	str r3, [r0, #8]
	add sp, sp, #232
	pop {r3-r11, pc}
.size fiat_mul_u4s_p2, .-fiat_mul_u4s_p2

.global fiat_mul_u4t_p3
.type fiat_mul_u4t_p3, %function
.thumb_func
.balign 16
fiat_mul_u4t_p3:
	push {r3-r11, lr}
	sub sp, sp, #232
	push {r0-r2}
	movw r11, #:lower16:g_u_mve_block
	movt r11, #:upper16:g_u_mve_block
	ldr r11, [r11]
	add r11, r11, #508
	adr r3, 1f
	b 2f
.balign 16
1:	.word 0, 4, 8, 12
2:
	vldrw.u32 q7, [r3]
	movw r3, #:lower16:g_u_mve_block
	movt r3, #:upper16:g_u_mve_block
	ldr r3, [r3]
	add r3, r3, #1524
	vadd.i32 q7, q7, r3
	pop {r0-r2}
	mov	r12, #38
	vbic q3, q0, q6
	mov	lr, r2
	ldr	r3, [r2, #4]
	veor q3, q3, q5
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	vstrw.u32 q3, [r11, #-300]
	mul	r6, r12, r2
	str r0, [sp, #0]
	str r2, [sp, #4]
	vbic q3, q1, q0
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str r6, [sp, #8]
	veor q3, q3, q6
	str r2, [sp, #12]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	vstrw.u32 q3, [r11, #-284]
	add	r8, r0, r2, lsl #1
	str r8, [sp, #16]
	ldr	r2, [lr, #28]
	vldrw.u32 q0, [q7, #-372]
	mul	r8, r12, r6
	str r6, [sp, #20]
	vldrw.u32 q1, [q7, #-356]
	ldr	r6, [r1, #16]
	str r7, [sp, #24]
	str r6, [sp, #28]
	vldrw.u32 q2, [q7, #-340]
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	vldrw.u32 q5, [q7, #-324]
	str r7, [sp, #32]
	ldr	r7, [lr, #24]
	str r5, [sp, #36]
	vldrw.u32 q6, [q7, #-308]
	mov	r2, r7
	mov	r5, r4
	str r8, [sp, #40]
	vbic q3, q2, q1
	mul	r8, r12, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	veor q3, q3, q0
	add	r10, r2, r7, lsl #1
	str r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	vstrw.u32 q3, [r11, #-268]
	str r3, [sp, #48]
	mul	r5, r12, r3
	vbic q3, q5, q2
	str r0, [sp, #52]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	veor q3, q3, q1
	str r2, [sp, #56]
	str r6, [sp, #60]
	str r8, [sp, #64]
	vstrw.u32 q3, [r11, #-252]
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str r7, [sp, #68]
	vbic q3, q6, q5
	ldr	r7, [r1, #8]
	mul	r12, r12, r2
	str r7, [sp, #72]
	veor q3, q3, q2
	ldr	r7, [lr, #0]
	str r2, [sp, #76]
	ldr	r2, [r1, #4]
	vstrw.u32 q3, [r11, #-236]
	str r7, [sp, #80]
	ldr r7, [sp, #24]
	str r2, [sp, #84]
	vbic q3, q0, q6
	ldr	r2, [r1, #0]
	ldr r1, [sp, #4]
	veor q3, q3, q5
	str r12, [sp, #88]
	add	r12, r7, r7, lsl #3
	add	r12, r7, r12, lsl #1
	vstrw.u32 q3, [r11, #-220]
	add	lr, r1, r1, lsl #3
	ldr r7, [sp, #32]
	add	lr, r1, lr, lsl #1
	vbic q3, q1, q0
	str r12, [sp, #92]
	umull	lr, r12, lr, r7
	ldr r1, [sp, #36]
	veor q3, q3, q6
	ldr r6, [sp, #16]
	umlal	lr, r12, r1, r4
	umull	r4, r1, r4, r7
	vstrw.u32 q3, [r11, #-204]
	str r3, [sp, #96]
	umlal	lr, r12, r6, r3
	ldr r3, [sp, #36]
	vldrw.u32 q0, [q7, #-292]
	ldr r7, [sp, #72]
	umlal	r4, r1, r3, r5
	vldrw.u32 q1, [q7, #-276]
	mov	r8, r4
	ldr r3, [sp, #96]
	ldr r5, [sp, #8]
	vldrw.u32 q2, [q7, #-260]
	ldr r4, [sp, #12]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	vldrw.u32 q5, [q7, #-244]
	ldr r4, [sp, #40]
	ldr r5, [sp, #28]
	umlal	r8, r1, r4, r0
	vldrw.u32 q6, [q7, #-228]
	umlal	r8, r1, r10, r5
	ldr r4, [sp, #64]
	str r6, [sp, #100]
	vbic q3, q2, q1
	ldr r6, [sp, #68]
	umlal	r8, r1, r4, r6
	ldr r6, [sp, #92]
	veor q3, q3, q0
	ldr r4, [sp, #84]
	umlal	r8, r1, r6, r7
	ldr r6, [sp, #88]
	vstrw.u32 q3, [r11, #-188]
	umlal	r8, r1, r6, r4
	ldr r6, [sp, #80]
	vbic q3, q5, q2
	ldr r4, [sp, #12]
	umlal	r8, r1, r6, r2
	ldr r6, [sp, #20]
	veor q3, q3, q1
	str r1, [sp, #104]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	vstrw.u32 q3, [r11, #-172]
	umlal	lr, r12, r1, r4
	ldr r4, [sp, #60]
	umlal	lr, r12, r10, r0
	vbic q3, q6, q5
	str r8, [sp, #108]
	bic	r8, r8, #-67108864
	str r8, [sp, #112]
	veor q3, q3, q2
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, r12, r8, r5
	vstrw.u32 q3, [r11, #-156]
	ldr r6, [sp, #68]
	ldr r5, [sp, #92]
	str r0, [sp, #116]
	vbic q3, q0, q6
	umlal	lr, r12, r5, r6
	ldr r6, [sp, #108]
	ldr r7, [sp, #104]
	veor q3, q3, q5
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr r5, [sp, #76]
	vstrw.u32 q3, [r11, #-140]
	str r6, [sp, #120]
	str r7, [sp, #124]
	add	r8, r5, r5, lsl #3
	ldr r7, [sp, #72]
	vbic q3, q1, q0
	add	r8, r5, r8, lsl #1
	umlal	lr, r12, r8, r7
	ldr r4, [sp, #80]
	veor q3, q3, q6
	ldr r5, [sp, #84]
	str r2, [sp, #128]
	umlal	lr, r12, r5, r4
	vstrw.u32 q3, [r11, #-124]
	ldr r5, [sp, #48]
	ldr r4, [sp, #120]
	umlal	lr, r12, r5, r2
	vldrw.u32 q0, [q7, #-212]
	lsls	r2, r5, #1
	ldr r7, [sp, #32]
	vldrw.u32 q1, [q7, #-196]
	str r2, [sp, #132]
	ldr r2, [sp, #124]
	adds	r4, lr, r4
	vldrw.u32 q2, [q7, #-180]
	mov	r6, r8
	adc	r9, r12, r2
	mov	r8, r4
	vldrw.u32 q5, [q7, #-164]
	ldr r2, [sp, #100]
	ldr r5, [sp, #36]
	bic	r12, r4, #-33554432
	umull	r4, r1, r7, r1
	vldrw.u32 q6, [q7, #-148]
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	vbic q3, q2, q1
	str r0, [sp, #136]
	ldr r0, [sp, #12]
	str r12, [sp, #140]
	veor q3, q3, q0
	umlal	r4, r1, r2, r0
	ldr r0, [sp, #116]
	ldr r2, [sp, #92]
	vstrw.u32 q3, [r11, #4]
	str r6, [sp, #144]
	umlal	r4, r1, r2, r0
	vbic q3, q5, q2
	mov	r2, r6
	ldr r6, [sp, #28]
	lsrl	r8, r9, #25
	veor q3, q3, q1
	umlal	r4, r1, r2, r6
	ldr r6, [sp, #68]
	ldr r2, [sp, #80]
	vstrw.u32 q3, [r11, #20]
	umlal	r4, r1, r6, r2
	ldr r6, [sp, #48]
	ldr r2, [sp, #72]
	vbic q3, q6, q5
	umlal	r4, r1, r2, r6
	ldr r6, [sp, #44]
	ldr r2, [sp, #84]
	veor q3, q3, q2
	umlal	r4, r1, r2, r6
	mov	r12, r4
	ldr r2, [sp, #128]
	vstrw.u32 q3, [r11, #36]
	ldr r4, [sp, #4]
	ldr r6, [sp, #28]
	umlal	r12, r1, r4, r2
	vbic q3, q0, q6
	ldr r4, [sp, #100]
	str r12, [sp, #148]
	veor q3, q3, q5
	umull	lr, r12, r4, r7
	ldr r4, [sp, #8]
	ldr r2, [sp, #64]
	vstrw.u32 q3, [r11, #52]
	umlal	lr, r12, r5, r4
	ldr r4, [sp, #40]
	ldr r7, [sp, #72]
	vbic q3, q1, q0
	umlal	lr, r12, r4, r3
	ldr r4, [sp, #12]
	umlal	lr, r12, r10, r4
	veor q3, q3, q6
	umlal	lr, r12, r2, r0
	ldr r2, [sp, #92]
	umlal	lr, r12, r2, r6
	vstrw.u32 q3, [r11, #68]
	ldr r6, [sp, #68]
	ldr r2, [sp, #88]
	umlal	lr, r12, r2, r6
	vldrw.u32 q0, [q7, #-132]
	ldr r2, [sp, #80]
	umlal	lr, r12, r7, r2
	vldrw.u32 q1, [q7, #-116]
	ldr r2, [sp, #132]
	ldr r7, [sp, #84]
	umlal	lr, r12, r7, r2
	vldrw.u32 q2, [q7, #-100]
	ldr r7, [sp, #44]
	ldr r2, [sp, #128]
	umlal	lr, r12, r7, r2
	adds	lr, lr, r8
	vldrw.u32 q5, [q7, #-84]
	adc	r2, r12, r9
	str lr, [sp, #152]
	str r2, [sp, #156]
	vldrw.u32 q6, [q7, #-68]
	ldr r2, [sp, #4]
	ldr r8, [sp, #152]
	ldr r9, [sp, #156]
	lsrl	r8, r9, #26
	vbic q3, q2, q1
	bic	r12, lr, #-67108864
	lsls	r2, r2, #1
	str r12, [sp, #160]
	veor q3, q3, q0
	str r2, [sp, #164]
	ldr r2, [sp, #136]
	ldr r7, [sp, #32]
	vstrw.u32 q3, [r11, #84]
	str r8, [sp, #168]
	str r9, [sp, #172]
	umull	lr, r12, r7, r2
	vbic q3, q5, q2
	umlal	lr, r12, r5, r10
	ldr r2, [sp, #92]
	umlal	lr, r12, r2, r3
	veor q3, q3, q1
	ldr r2, [sp, #144]
	umlal	lr, r12, r2, r4
	ldr r2, [sp, #80]
	vstrw.u32 q3, [r11, #100]
	ldr r4, [sp, #28]
	umlal	lr, r12, r0, r2
	ldr r2, [sp, #48]
	vbic q3, q6, q5
	umlal	lr, r12, r4, r2
	ldr r4, [sp, #44]
	ldr r2, [sp, #84]
	veor q3, q3, q2
	umlal	lr, r12, r6, r4
	ldr r4, [sp, #4]
	ldr r6, [sp, #72]
	vstrw.u32 q3, [r11, #116]
	umlal	lr, r12, r6, r4
	mov	r4, r8
	ldr r6, [sp, #148]
	vbic q3, q0, q6
	adds	r4, r6, r4
	mov	r8, r4
	veor q3, q3, q5
	ldr r6, [sp, #172]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	vstrw.u32 q3, [r11, #132]
	ldr r1, [sp, #52]
	lsrl	r8, r9, #25
	umlal	lr, r12, r2, r1
	vbic q3, q1, q0
	ldr r1, [sp, #128]
	ldr r6, [sp, #20]
	umlal	lr, r12, r6, r1
	ldr r2, [sp, #0]
	veor q3, q3, q6
	str lr, [sp, #176]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	vstrw.u32 q3, [r11, #148]
	ldr r4, [sp, #40]
	ldr r2, [sp, #92]
	umlal	lr, r1, r5, r4
	vldrw.u32 q0, [q7, #-52]
	ldr r4, [sp, #64]
	ldr r6, [sp, #88]
	umlal	lr, r1, r4, r3
	vldrw.u32 q1, [q7, #-36]
	ldr r4, [sp, #12]
	umlal	lr, r1, r2, r4
	vldrw.u32 q2, [q7, #-20]
	umlal	lr, r1, r6, r0
	ldr r2, [sp, #80]
	ldr r6, [sp, #28]
	vldrw.u32 q5, [q7, #-4]
	umlal	lr, r1, r6, r2
	ldr r6, [sp, #68]
	ldr r2, [sp, #132]
	vldrw.u32 q6, [q7, #12]
	umlal	lr, r1, r6, r2
	ldr r6, [sp, #72]
	ldr r2, [sp, #44]
	vbic q3, q2, q1
	umlal	lr, r1, r6, r2
	ldr r2, [sp, #84]
	ldr r6, [sp, #164]
	veor q3, q3, q0
	umlal	lr, r1, r2, r6
	ldr r6, [sp, #52]
	ldr r2, [sp, #128]
	vstrw.u32 q3, [r11, #164]
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	vbic q3, q5, q2
	adc	r1, r1, r9
	str lr, [sp, #180]
	str r1, [sp, #184]
	veor q3, q3, q1
	ldr r8, [sp, #180]
	ldr r9, [sp, #184]
	lsrl	r8, r9, #26
	ldr r6, [sp, #144]
	vstrw.u32 q3, [r11, #180]
	ldr r2, [sp, #0]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	vbic q3, q6, q5
	str	r1, [r2, #16]
	ldr r2, [sp, #92]
	ldr r6, [sp, #48]
	veor q3, q3, q2
	umlal	r10, lr, r5, r2
	ldr r2, [sp, #80]
	str r4, [sp, #188]
	vstrw.u32 q3, [r11, #196]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	ldr r4, [sp, #44]
	vbic q3, q0, q6
	ldr r6, [sp, #28]
	umlal	r10, lr, r0, r4
	veor q3, q3, q5
	ldr r4, [sp, #4]
	ldr r2, [sp, #72]
	umlal	r10, lr, r6, r4
	vstrw.u32 q3, [r11, #212]
	ldr r6, [sp, #68]
	ldr r4, [sp, #52]
	ldr r1, [sp, #20]
	vbic q3, q1, q0
	umlal	r10, lr, r6, r4
	mov	r4, r8
	ldr r6, [sp, #176]
	veor q3, q3, q6
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr r6, [sp, #20]
	vstrw.u32 q3, [r11, #228]
	str r4, [sp, #192]
	umlal	r10, lr, r2, r6
	ldr r2, [sp, #0]
	vldrw.u32 q0, [q7, #28]
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr r4, [sp, #56]
	vldrw.u32 q1, [q7, #44]
	ldr r2, [sp, #84]
	adc	r12, r12, r9
	vldrw.u32 q2, [q7, #60]
	umlal	r10, lr, r2, r4
	ldr r4, [sp, #60]
	ldr r2, [sp, #128]
	vldrw.u32 q5, [q7, #76]
	str r12, [sp, #196]
	umlal	r10, lr, r4, r2
	ldr r8, [sp, #192]
	ldr r9, [sp, #196]
	vldrw.u32 q6, [q7, #92]
	str r10, [sp, #200]
	ldr r2, [sp, #92]
	lsrl	r8, r9, #25
	vbic q3, q2, q1
	umull	r4, r12, r2, r7
	ldr r2, [sp, #64]
	str r3, [sp, #204]
	veor q3, q3, q0
	umlal	r4, r12, r5, r2
	ldr r2, [sp, #88]
	ldr r6, [sp, #28]
	vstrw.u32 q3, [r11, #244]
	umlal	r4, r12, r2, r3
	ldr r3, [sp, #188]
	vbic q3, q5, q2
	ldr r2, [sp, #80]
	str r8, [sp, #208]
	str r9, [sp, #212]
	umlal	r4, r12, r3, r2
	veor q3, q3, q1
	ldr r3, [sp, #132]
	ldr r2, [sp, #72]
	umlal	r4, r12, r0, r3
	vstrw.u32 q3, [r11, #260]
	ldr r3, [sp, #44]
	umlal	r4, r12, r6, r3
	ldr r6, [sp, #68]
	vbic q3, q6, q5
	ldr r3, [sp, #164]
	umlal	r4, r12, r6, r3
	ldr r3, [sp, #52]
	veor q3, q3, q2
	umlal	r4, r12, r2, r3
	ldr r3, [sp, #84]
	ldr r2, [sp, #128]
	vstrw.u32 q3, [r11, #276]
	umlal	r4, r12, r3, r1
	ldr r3, [sp, #56]
	umlal	r4, r12, r3, r2
	vbic q3, q0, q6
	adds	r8, r4, r8
	ldr r4, [sp, #212]
	veor q3, q3, q5
	str r8, [sp, #216]
	adc	r4, r12, r4
	str r4, [sp, #220]
	vstrw.u32 q3, [r11, #292]
	ldr r2, [sp, #216]
	ldr r3, [sp, #220]
	lsrl	r2, r3, #26
	str r2, [sp, #224]
	str r3, [sp, #228]
	vbic q3, q1, q0
	ldr r3, [sp, #0]
	ldr r2, [sp, #48]
	bic	r8, r8, #-67108864
	veor q3, q3, q6
	str	r8, [r3, #24]
	ldr r3, [sp, #60]
	umull	r12, r8, r7, r2
	vstrw.u32 q3, [r11, #308]
	lsl	r9, r3, #1
	ldr r3, [sp, #80]
	ldr r2, [sp, #88]
	vldrw.u32 q0, [q7, #108]
	umlal	r12, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	vldrw.u32 q1, [q7, #124]
	ldr r2, [sp, #132]
	ldr r4, [sp, #204]
	ldr r5, [sp, #44]
	vldrw.u32 q2, [q7, #140]
	umlal	r3, r10, r4, r2
	umlal	r12, r8, r4, r5
	ldr r4, [sp, #188]
	vldrw.u32 q5, [q7, #156]
	ldr r2, [sp, #72]
	umlal	r3, r10, r4, r5
	ldr r5, [sp, #4]
	vldrw.u32 q6, [q7, #172]
	umlal	r12, r8, r4, r5
	ldr r5, [sp, #164]
	ldr r4, [sp, #52]
	vbic q3, q2, q1
	umlal	r3, r10, r0, r5
	umlal	r12, r8, r0, r4
	ldr r0, [sp, #28]
	veor q3, q3, q0
	ldr r5, [sp, #76]
	umlal	r3, r10, r0, r4
	ldr r4, [sp, #20]
	vstrw.u32 q3, [r11, #324]
	umlal	r3, r10, r6, r1
	umlal	r12, r8, r0, r4
	vbic q3, q5, q2
	ldr r0, [sp, #56]
	ldr r4, [sp, #60]
	umlal	r12, r8, r6, r0
	veor q3, q3, q1
	umlal	r3, r10, r2, r0
	umlal	r12, r8, r2, r4
	ldr r0, [sp, #24]
	vstrw.u32 q3, [r11, #340]
	ldr r2, [sp, #84]
	ldr r6, [sp, #200]
	umlal	r3, r10, r2, r9
	vbic q3, q6, q5
	umlal	r12, r8, r2, r0
	ldr r2, [sp, #128]
	umlal	r3, r10, r0, r2
	veor q3, q3, q2
	umlal	r12, r8, r2, r5
	ldr r2, [sp, #224]
	ldr r5, [sp, #228]
	vstrw.u32 q3, [r11, #356]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	vbic q3, q0, q6
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	veor q3, q3, q5
	ldr r0, [sp, #0]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
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
	bic	r1, r1, #-67108864
	vldrw.u32 q0, [r11, #-108]
	str	r1, [r0, #32]
	bic	r1, r12, #-33554432
	str	r1, [r0, #36]
	vldrw.u32 q1, [r11, #-508]
	adds	r1, r4, r2
	adc	r4, r5, r3
	veor q1, q1, q0
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	vstrw.u32 q1, [r11, #-508]
	adc	r4, r4, r3
	ldr r3, [sp, #112]
	adds	r1, r1, r3
	vldrw.u32 q0, [r11, #-92]
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	vldrw.u32 q1, [r11, #4]
	bic	r1, r1, #-67108864
	str	r1, [r0, #0]
	ldr r1, [sp, #140]
	veor q1, q1, q0
	adds	r3, r1, r2
	ldr r1, [sp, #160]
	bic	r2, r3, #-33554432
	vstrw.u32 q1, [r11, #4]
	add	r3, r1, r3, lsr #25
	str r2, [r0, #4]
	str r3, [r0, #8]
	add sp, sp, #232
	pop {r3-r11, pc}
.size fiat_mul_u4t_p3, .-fiat_mul_u4t_p3

.global fiat_mul_u4s_p3
.type fiat_mul_u4s_p3, %function
.thumb_func
.balign 16
fiat_mul_u4s_p3:
	push {r3-r11, lr}
	sub sp, sp, #232
	push {r0-r2}
	movw r11, #:lower16:g_u_mve_block
	movt r11, #:upper16:g_u_mve_block
	ldr r11, [r11]
	add r11, r11, #508
	adr r3, 1f
	b 2f
.balign 16
1:	.word 0, 4, 8, 12
2:
	vldrw.u32 q7, [r3]
	movw r3, #:lower16:g_u_mve_block
	movt r3, #:upper16:g_u_mve_block
	ldr r3, [r3]
	add r3, r3, #1524
	vadd.i32 q7, q7, r3
	pop {r0-r2}
	mov r12, #38
	ldr r3, [r2, #4]
	vbic q3, q0, q6
	ldr r7, [r2, #32]
	mov lr, r2
	ldr r4, [r2, #8]
	veor q3, q3, q5
	ldr r6, [r2, #12]
	vstrw.u32 q3, [r11, #4294966996]
	ldr r2, [r1, #24]
	vbic q3, q1, q0
	ldr r5, [lr, #20]
	mul r9, r12, r6
	ldr r8, [lr, #28]
	str r0, [sp, #0]
	ldr r0, [lr, #16]
	str r6, [sp, #4]
	vldrw.u32 q0, [q7, #-372]
	str r9, [sp, #8]
	veor q6, q3, q6
	str r2, [sp, #12]
	vldrw.u32 q1, [q7, #-356]
	add r9, r0, r0, lsl       #3
	vstrw.u32 q6, [r11, #4294967012]
	ldr r2, [r1, #16]
	mov r6, r8
	add r9, r0, r9, lsl       #1
	vldrw.u32 q2, [q7, #-340]
	str r9, [sp, #16]
	mul r8, r12, r5
	str r5, [sp, #20]
	ldr r10, [r1, #32]
	str r7, [sp, #24]
	ldr r5, [r1, #36]
	str r2, [sp, #28]
	ldr r7, [lr, #24]
	vldrw.u32 q5, [q7, #-324]
	str r10, [sp, #32]
	str r5, [sp, #36]
	vldrw.u32 q6, [q7, #-308]
	mov r2, r7
	mov r5, r4
	str r8, [sp, #40]
	vbic q3, q2, q1
	mul r8, r12, r6
	add r7, r7, r7, lsl   #3
	add r4, r4, r4, lsl   #3
	veor q3, q3, q0
	add r10, r2, r7, lsl   #1
	str r5, [sp, #44]
	add r4, r5, r4, lsl   #1
	vstrw.u32 q3, [r11, #4294967028]
	str r3, [sp, #48]
	mul r5, r12, r3
	vbic q3, q5, q2
	str r0, [sp, #52]
	ldr r3, [r1, #28]
	ldr r0, [r1, #20]
	veor q3, q3, q1
	str r2, [sp, #56]
	str r6, [sp, #60]
	str r8, [sp, #64]
	ldr r7, [r1, #12]
	vstrw.u32 q3, [r11, #4294967044]
	ldr r9, [lr, #36]
	vbic q3, q6, q5
	ldr r2, [r1, #8]
	str r7, [sp, #68]
	mul r8, r12, r9
	str r2, [sp, #72]
	veor q2, q3, q2
	ldr r12, [lr, #0]
	str r9, [sp, #76]
	ldr r9, [r1, #4]
	vstrw.u32 q2, [r11, #4294967060]
	ldr r6, [sp, #24]
	vbic q3, q0, q6
	str r12, [sp, #80]
	ldr r2, [r1, #0]
	str r9, [sp, #84]
	ldr r9, [sp, #4]
	veor q5, q3, q5
	str r8, [sp, #88]
	add r8, r6, r6, lsl       #3
	vstrw.u32 q5, [r11, #4294967076]
	add lr, r9, r9, lsl       #3
	ldr r7, [sp, #32]
	add r8, r6, r8, lsl       #1
	vbic q0, q1, q0
	add lr, r9, lr, lsl       #1
	str r8, [sp, #92]
	umull lr, r12, lr, r7
	ldr r1, [sp, #36]
	veor q0, q0, q6
	umlal lr, r12, r1, r4
	umull r4, r1, r4, r7
	str r3, [sp, #96]
	ldr r6, [sp, #16]
	vstrw.u32 q0, [r11, #4294967092]
	umlal lr, r12, r6, r3
	ldr r3, [sp, #36]
	vldrw.u32 q0, [q7, #-292]
	ldr r7, [sp, #72]
	umlal r4, r1, r3, r5
	vldrw.u32 q1, [q7, #-276]
	mov r8, r4
	ldr r3, [sp, #96]
	ldr r5, [sp, #8]
	vldrw.u32 q2, [q7, #-260]
	ldr r4, [sp, #12]
	umlal r8, r1, r5, r3
	umlal r8, r1, r6, r4
	vldrw.u32 q5, [q7, #-244]
	ldr r4, [sp, #40]
	ldr r5, [sp, #28]
	umlal r8, r1, r4, r0
	vldrw.u32 q6, [q7, #-228]
	umlal r8, r1, r10, r5
	ldr r4, [sp, #64]
	str r6, [sp, #100]
	vbic q3, q2, q1
	ldr r6, [sp, #68]
	veor q3, q3, q0
	umlal r8, r1, r4, r6
	ldr r6, [sp, #92]
	ldr r4, [sp, #84]
	umlal r8, r1, r6, r7
	ldr r7, [sp, #88]
	vstrw.u32 q3, [r11, #4294967108]
	ldr r9, [sp, #80]
	vbic q3, q5, q2
	umlal r8, r1, r7, r4
	ldr r4, [sp, #12]
	umlal r8, r1, r9, r2
	ldr r6, [sp, #20]
	veor q3, q3, q1
	ldr r9, [sp, #60]
	str r1, [sp, #104]
	add r7, r6, r6, lsl       #3
	vstrw.u32 q3, [r11, #4294967124]
	vbic q3, q6, q5
	add r1, r6, r7, lsl       #1
	veor q3, q3, q2
	umlal lr, r12, r1, r4
	str r8, [sp, #108]
	umlal lr, r12, r10, r0
	bic r4, r8, #-67108864
	str r4, [sp, #112]
	add r7, r9, r9, lsl       #3
	vstrw.u32 q3, [r11, #4294967140]
	ldr r4, [sp, #68]
	add r8, r9, r7, lsl       #1
	ldr r9, [sp, #92]
	umlal lr, r12, r8, r5
	str r0, [sp, #116]
	vbic q3, q0, q6
	ldr r6, [sp, #108]
	umlal lr, r12, r9, r4
	ldr r7, [sp, #104]
	veor q3, q3, q5
	lsrl r6, r7, #26
	mov r0, r8
	ldr r5, [sp, #76]
	vstrw.u32 q3, [r11, #4294967156]
	str r6, [sp, #120]
	str r7, [sp, #124]
	add r8, r5, r5, lsl   #3
	ldr r7, [sp, #72]
	vbic q3, q1, q0
	add r8, r5, r8, lsl   #1
	umlal lr, r12, r8, r7
	ldr r4, [sp, #80]
	veor q3, q3, q6
	ldr r5, [sp, #84]
	str r2, [sp, #128]
	umlal lr, r12, r5, r4
	vstrw.u32 q3, [r11, #4294967172]
	ldr r5, [sp, #48]
	ldr r4, [sp, #120]
	umlal lr, r12, r5, r2
	vldrw.u32 q0, [q7, #-212]
	lsls r2, r5, #1
	ldr r7, [sp, #32]
	str r2, [sp, #132]
	vldrw.u32 q1, [q7, #-196]
	adds r4, lr, r4
	mov r6, r8
	mov r8, r4
	ldr r5, [sp, #124]
	bic r2, r4, #-33554432
	vldrw.u32 q2, [q7, #-180]
	adc r9, r12, r5
	umull r4, r1, r7, r1
	mov r12, r0
	vldrw.u32 q5, [q7, #-164]
	str r0, [sp, #136]
	vbic q6, q2, q1
	str r2, [sp, #140]
	ldr r2, [sp, #100]
	veor q3, q6, q0
	ldr r5, [sp, #36]
	vstrw.u32 q3, [r11, #4]
	vldrw.u32 q6, [q7, #-148]
	vbic q3, q5, q2
	umlal r4, r1, r5, r2
	str r6, [sp, #144]
	umlal r4, r1, r10, r3
	ldr r0, [sp, #12]
	umlal r4, r1, r12, r0
	ldr r0, [sp, #116]
	ldr r12, [sp, #92]
	mov r6, r6
	umlal r4, r1, r12, r0
	ldr r2, [sp, #28]
	lsrl r8, r9, #25
	veor q3, q3, q1
	umlal r4, r1, r6, r2
	ldr r6, [sp, #68]
	ldr r2, [sp, #80]
	vstrw.u32 q3, [r11, #20]
	umlal r4, r1, r6, r2
	ldr r6, [sp, #48]
	ldr r2, [sp, #72]
	vbic q3, q6, q5
	umlal r4, r1, r2, r6
	ldr r6, [sp, #44]
	ldr r2, [sp, #84]
	veor q3, q3, q2
	umlal r4, r1, r2, r6
	mov r12, r4
	ldr r2, [sp, #128]
	vstrw.u32 q3, [r11, #36]
	ldr r4, [sp, #4]
	ldr r6, [sp, #28]
	umlal r12, r1, r4, r2
	vbic q3, q0, q6
	ldr r4, [sp, #100]
	str r12, [sp, #148]
	veor q3, q3, q5
	umull lr, r12, r4, r7
	ldr r4, [sp, #8]
	ldr r2, [sp, #64]
	vstrw.u32 q3, [r11, #52]
	umlal lr, r12, r5, r4
	ldr r7, [sp, #40]
	vbic q2, q1, q0
	ldr r4, [sp, #12]
	umlal lr, r12, r7, r3
	vldrw.u32 q0, [q7, #-132]
	umlal lr, r12, r10, r4
	veor q2, q2, q6
	umlal lr, r12, r2, r0
	ldr r2, [sp, #92]
	vstrw.u32 q2, [r11, #68]
	vldrw.u32 q1, [q7, #-116]
	umlal lr, r12, r2, r6
	ldr r6, [sp, #68]
	ldr r2, [sp, #88]
	umlal lr, r12, r2, r6
	ldr r2, [sp, #80]
	ldr r7, [sp, #72]
	umlal lr, r12, r7, r2
	ldr r7, [sp, #132]
	ldr r2, [sp, #84]
	umlal lr, r12, r2, r7
	ldr r7, [sp, #44]
	ldr r2, [sp, #128]
	vldrw.u32 q2, [q7, #-100]
	umlal lr, r12, r7, r2
	adds lr, lr, r8
	vldrw.u32 q5, [q7, #-84]
	adc r8, r12, r9
	str lr, [sp, #152]
	str r8, [sp, #156]
	ldr r2, [sp, #4]
	ldr r8, [sp, #152]
	vbic q3, q2, q1
	ldr r9, [sp, #156]
	bic r12, lr, #-67108864
	vldrw.u32 q6, [q7, #-68]
	lsrl r8, r9, #26
	lsls r2, r2, #1
	str r12, [sp, #160]
	veor q3, q3, q0
	str r2, [sp, #164]
	ldr r2, [sp, #136]
	ldr r7, [sp, #32]
	vstrw.u32 q3, [r11, #84]
	str r8, [sp, #168]
	str r9, [sp, #172]
	umull lr, r12, r7, r2
	vbic q3, q5, q2
	umlal lr, r12, r5, r10
	ldr r2, [sp, #92]
	umlal lr, r12, r2, r3
	veor q3, q3, q1
	ldr r2, [sp, #144]
	umlal lr, r12, r2, r4
	ldr r2, [sp, #80]
	vstrw.u32 q3, [r11, #100]
	ldr r4, [sp, #28]
	umlal lr, r12, r0, r2
	ldr r2, [sp, #48]
	vbic q3, q6, q5
	umlal lr, r12, r4, r2
	ldr r2, [sp, #44]
	ldr r4, [sp, #84]
	veor q3, q3, q2
	umlal lr, r12, r6, r2
	ldr r2, [sp, #4]
	ldr r6, [sp, #72]
	vstrw.u32 q3, [r11, #116]
	mov r9, r8
	ldr r8, [sp, #148]
	umlal lr, r12, r6, r2
	vbic q3, q0, q6
	adds r6, r8, r9
	veor q2, q3, q5
	mov r8, r6
	ldr r9, [sp, #172]
	bic r2, r6, #-33554432
	adc r9, r1, r9
	vstrw.u32 q2, [r11, #132]
	ldr r1, [sp, #52]
	vbic q0, q1, q0
	ldr r6, [sp, #128]
	lsrl r8, r9, #25
	veor q1, q0, q6
	umlal lr, r12, r4, r1
	ldr r4, [sp, #20]
	umlal lr, r12, r4, r6
	ldr r6, [sp, #0]
	str r2, [r6, #12]
	ldr r6, [sp, #40]
	str lr, [sp, #176]
	umull lr, r1, r10, r7
	vstrw.u32 q1, [r11, #148]
	ldr r2, [sp, #92]
	ldr r4, [sp, #64]
	umlal lr, r1, r5, r6
	vldrw.u32 q0, [q7, #-52]
	ldr r6, [sp, #88]
	umlal lr, r1, r4, r3
	vldrw.u32 q1, [q7, #-36]
	ldr r4, [sp, #12]
	umlal lr, r1, r2, r4
	vldrw.u32 q2, [q7, #-20]
	umlal lr, r1, r6, r0
	ldr r2, [sp, #80]
	ldr r6, [sp, #28]
	vldrw.u32 q5, [q7, #-4]
	umlal lr, r1, r6, r2
	ldr r6, [sp, #68]
	ldr r2, [sp, #132]
	vldrw.u32 q6, [q7, #12]
	umlal lr, r1, r6, r2
	ldr r6, [sp, #72]
	ldr r2, [sp, #44]
	vbic q3, q2, q1
	umlal lr, r1, r6, r2
	ldr r2, [sp, #84]
	ldr r6, [sp, #164]
	veor q3, q3, q0
	umlal lr, r1, r2, r6
	ldr r10, [sp, #52]
	vstrw.u32 q3, [r11, #164]
	ldr r6, [sp, #128]
	vbic q3, q5, q2
	umlal lr, r1, r10, r6
	veor q3, q3, q1
	ldr r6, [sp, #144]
	vstrw.u32 q3, [r11, #180]
	adds lr, lr, r8
	ldr r8, [sp, #180]
	adc r10, r1, r9
	str lr, [sp, #180]
	str r10, [sp, #184]
	ldr r9, [sp, #184]
	lsrl r8, r9, #26
	ldr r1, [sp, #0]
	bic r2, lr, #-67108864
	umull r10, lr, r7, r6
	vbic q3, q6, q5
	str r2, [r1, #16]
	ldr r2, [sp, #92]
	veor q3, q3, q2
	ldr r1, [sp, #48]
	umlal r10, lr, r5, r2
	ldr r2, [sp, #80]
	vstrw.u32 q3, [r11, #196]
	ldr r6, [sp, #44]
	vbic q3, q0, q6
	str r4, [sp, #188]
	umlal r10, lr, r3, r2
	umlal r10, lr, r4, r1
	ldr r1, [sp, #28]
	umlal r10, lr, r0, r6
	ldr r6, [sp, #4]
	veor q2, q3, q5
	umlal r10, lr, r1, r6
	ldr r2, [sp, #72]
	vstrw.u32 q2, [r11, #212]
	ldr r6, [sp, #68]
	ldr r4, [sp, #52]
	ldr r1, [sp, #20]
	vbic q3, q1, q0
	umlal r10, lr, r6, r4
	mov r4, r8
	ldr r6, [sp, #176]
	veor q3, q3, q6
	lsls r1, r1, #1
	adds r4, r6, r4
	ldr r6, [sp, #20]
	vstrw.u32 q3, [r11, #228]
	str r4, [sp, #192]
	umlal r10, lr, r2, r6
	ldr r2, [sp, #0]
	vldrw.u32 q0, [q7, #28]
	bic r4, r4, #-33554432
	str r4, [r2, #20]
	ldr r4, [sp, #56]
	vldrw.u32 q1, [q7, #44]
	ldr r2, [sp, #84]
	adc r12, r12, r9
	vldrw.u32 q2, [q7, #60]
	umlal r10, lr, r2, r4
	ldr r9, [sp, #60]
	ldr r8, [sp, #128]
	str r12, [sp, #196]
	vldrw.u32 q5, [q7, #76]
	umlal r10, lr, r9, r8
	vbic q3, q2, q1
	str r3, [sp, #204]
	ldr r8, [sp, #192]
	str r10, [sp, #200]
	ldr r9, [sp, #196]
	veor q3, q3, q0
	vldrw.u32 q6, [q7, #92]
	lsrl r8, r9, #25
	vstrw.u32 q3, [r11, #244]
	vbic q3, q5, q2
	ldr r12, [sp, #92]
	veor q3, q3, q1
	umull r4, r12, r12, r7
	ldr r10, [sp, #64]
	umlal r4, r12, r5, r10
	ldr r6, [sp, #88]
	ldr r10, [sp, #28]
	umlal r4, r12, r6, r3
	ldr r3, [sp, #188]
	str r8, [sp, #208]
	ldr r6, [sp, #80]
	str r9, [sp, #212]
	umlal r4, r12, r3, r6
	ldr r3, [sp, #132]
	ldr r2, [sp, #72]
	umlal r4, r12, r0, r3
	vstrw.u32 q3, [r11, #260]
	ldr r3, [sp, #44]
	ldr r6, [sp, #68]
	vbic q3, q6, q5
	umlal r4, r12, r10, r3
	ldr r3, [sp, #164]
	umlal r4, r12, r6, r3
	ldr r3, [sp, #52]
	veor q3, q3, q2
	umlal r4, r12, r2, r3
	ldr r3, [sp, #84]
	ldr r2, [sp, #128]
	vstrw.u32 q3, [r11, #276]
	umlal r4, r12, r3, r1
	ldr r3, [sp, #56]
	umlal r4, r12, r3, r2
	vbic q3, q0, q6
	adds r8, r4, r8
	ldr r4, [sp, #212]
	veor q3, q3, q5
	str r8, [sp, #216]
	adc r4, r12, r4
	str r4, [sp, #220]
	vstrw.u32 q3, [r11, #292]
	ldr r2, [sp, #216]
	ldr r3, [sp, #220]
	lsrl r2, r3, #26
	str r2, [sp, #224]
	str r3, [sp, #228]
	vbic q3, q1, q0
	ldr r4, [sp, #0]
	ldr r9, [sp, #48]
	bic r12, r8, #-67108864
	veor q5, q3, q6
	ldr r10, [sp, #60]
	str r12, [r4, #24]
	ldr r3, [sp, #80]
	umull r12, r8, r7, r9
	ldr r2, [sp, #88]
	vstrw.u32 q5, [r11, #308]
	vldrw.u32 q0, [q7, #108]
	lsl r9, r10, #1
	vldrw.u32 q1, [q7, #124]
	umlal r12, r8, r5, r3
	umull r3, r10, r7, r3
	ldr r4, [sp, #132]
	umlal r3, r10, r5, r2
	ldr r5, [sp, #204]
	ldr r7, [sp, #44]
	umlal r3, r10, r5, r4
	vldrw.u32 q2, [q7, #140]
	umlal r12, r8, r5, r7
	ldr r5, [sp, #188]
	vldrw.u32 q5, [q7, #156]
	umlal r3, r10, r5, r7
	vbic q3, q2, q1
	ldr r2, [sp, #72]
	veor q3, q3, q0
	ldr r4, [sp, #4]
	umlal r12, r8, r5, r4
	ldr r5, [sp, #164]
	ldr r4, [sp, #52]
	umlal r3, r10, r0, r5
	umlal r12, r8, r0, r4
	ldr r0, [sp, #28]
	ldr r5, [sp, #76]
	vldrw.u32 q6, [q7, #172]
	umlal r3, r10, r0, r4
	ldr r4, [sp, #20]
	vstrw.u32 q3, [r11, #324]
	umlal r3, r10, r6, r1
	umlal r12, r8, r0, r4
	vbic q3, q5, q2
	ldr r0, [sp, #56]
	ldr r4, [sp, #60]
	umlal r12, r8, r6, r0
	veor q3, q3, q1
	umlal r3, r10, r2, r0
	umlal r12, r8, r2, r4
	ldr r0, [sp, #24]
	vstrw.u32 q3, [r11, #340]
	ldr r2, [sp, #84]
	ldr r6, [sp, #200]
	umlal r3, r10, r2, r9
	vbic q3, q6, q5
	umlal r12, r8, r2, r0
	ldr r2, [sp, #128]
	umlal r3, r10, r0, r2
	veor q3, q3, q2
	umlal r12, r8, r2, r5
	ldr r2, [sp, #224]
	ldr r5, [sp, #228]
	vstrw.u32 q3, [r11, #356]
	adds r1, r6, r2
	vbic q3, q0, q6
	mov r2, r1
	mov r4, r3
	adc r3, lr, r5
	veor q3, q3, q5
	lsrl r2, r3, #25
	ldr r0, [sp, #0]
	adds r7, r4, r2
	bic r2, r1, #-33554432
	vstrw.u32 q3, [r11, #372]
	mov r4, r7
	adc r5, r10, r3
	vbic q3, q1, q0
	str r2, [r0, #28]
	lsrl r4, r5, #26
	adds r4, r12, r4
	veor q3, q3, q6
	mov r2, r4
	adc r3, r8, r5
	lsrl r2, r3, #25
	bic r8, r7, #-67108864
	mov r6, r2
	vstrw.u32 q3, [r11, #388]
	mov r7, r3
	vldrw.u32 q0, [r11, #4294967188]
	lsll r6, r7, #3
	str r8, [r0, #32]
	bic r5, r4, #-33554432
	vldrw.u32 q1, [r11, #4294966788]
	str r5, [r0, #36]
	adds r1, r6, r2
	adc r4, r7, r3
	veor q1, q1, q0
	adds r1, r1, r1
	adcs r4, r4, r4
	adds r1, r1, r2
	vstrw.u32 q1, [r11, #4294966788]
	adc r4, r4, r3
	ldr r3, [sp, #112]
	adds r1, r1, r3
	vldrw.u32 q0, [r11, #4294967204]
	mov r2, r1
	adc r3, r4, #0
	lsrl r2, r3, #26
	vldrw.u32 q1, [r11, #4]
	bic r1, r1, #-67108864
	str r1, [r0, #0]
	ldr r1, [sp, #140]
	veor q1, q1, q0
	adds r3, r1, r2
	ldr r1, [sp, #160]
	bic r2, r3, #-33554432
	vstrw.u32 q1, [r11, #4]
	add r3, r1, r3, lsr   #25
	str r2, [r0, #4]
	str r3, [r0, #8]
	add sp, sp, #232
	pop {r3-r11, pc}
.size fiat_mul_u4s_p3, .-fiat_mul_u4s_p3

.global expdb_qall_save
.type expdb_qall_save, %function
.thumb_func
expdb_qall_save:
	vstrw.u32 q0, [r0, #0]
	vstrw.u32 q1, [r0, #16]
	vstrw.u32 q2, [r0, #32]
	vstrw.u32 q3, [r0, #48]
	vstrw.u32 q4, [r0, #64]
	vstrw.u32 q5, [r0, #80]
	vstrw.u32 q6, [r0, #96]
	vstrw.u32 q7, [r0, #112]
	bx lr
.size expdb_qall_save, .-expdb_qall_save

.global expdb_qall_restore
.type expdb_qall_restore, %function
.thumb_func
expdb_qall_restore:
	vldrw.u32 q0, [r0, #0]
	vldrw.u32 q1, [r0, #16]
	vldrw.u32 q2, [r0, #32]
	vldrw.u32 q3, [r0, #48]
	vldrw.u32 q4, [r0, #64]
	vldrw.u32 q5, [r0, #80]
	vldrw.u32 q6, [r0, #96]
	vldrw.u32 q7, [r0, #112]
	bx lr
.size expdb_qall_restore, .-expdb_qall_restore

