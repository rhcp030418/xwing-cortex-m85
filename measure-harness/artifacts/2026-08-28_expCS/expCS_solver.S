/* 실험 CS: fiat_mul_u4_p0 의 변환 대조군(u4t)과 SLOTHY 재스케줄본(u4s).
 * 본문만 다르고 프롤로그/setup/에필로그는 원본과 동일하다.
 * 스필 슬롯 고유화로 프레임 144 -> 240B. 생성: gen_board_cs.py */
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
	sub sp, sp, #240
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
	add sp, sp, #240
	pop {r3-r11, pc}
.size fiat_mul_u4t_p0, .-fiat_mul_u4t_p0

.global fiat_mul_u4s_p0
.type fiat_mul_u4s_p0, %function
.thumb_func
.balign 16
fiat_mul_u4s_p0:
	push {r3-r11, lr}
	sub sp, sp, #240
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
	vldrw.u32 q0, [r11, #4294966788]
	mov lr, r2
	str r0, [sp, #0]
	ldr r3, [r2, #4]
	vldrw.u32 q4, [r11, #4294966868]
	veor q4, q0, q4
	ldr r7, [r2, #32]
	ldr r4, [r2, #8]
	str r7, [sp, #24]
	ldr r2, [r2, #12]
	mul r6, r12, r2
	vldrw.u32 q3, [r11, #4294966948]
	str r2, [sp, #4]
	veor q2, q4, q3
	ldr r0, [lr, #16]
	str r6, [sp, #8]
	ldr r2, [r1, #24]
	str r2, [sp, #12]
	ldr r6, [lr, #20]
	add r2, r0, r0, lsl       #3
	vldrw.u32 q1, [r11, #4294967028]
	veor q1, q2, q1
	str r6, [sp, #20]
	add r8, r0, r2, lsl       #1
	ldr r2, [lr, #28]
	str r8, [sp, #16]
	ldr r7, [r1, #32]
	mul r8, r12, r6
	ldr r6, [r1, #16]
	vldrw.u32 q4, [r11, #4294967108]
	str r6, [sp, #28]
	veor q4, q1, q4
	mov r6, r2
	ldr r5, [r1, #36]
	str r7, [sp, #32]
	vstrw.u32 q4, [q7, #188]
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
	ldr r7, [r1, #12]
	veor q1, q0, q1
	ldr r2, [lr, #36]
	str r7, [sp, #68]
	vldrw.u32 q4, [r11, #4294967124]
	mul r12, r12, r2
	veor q2, q1, q4
	ldr r7, [r1, #8]
	str r2, [sp, #76]
	str r7, [sp, #72]
	ldr r7, [lr, #0]
	ldr r2, [r1, #4]
	vstrw.u32 q2, [q7, #204]
	vldrw.u32 q3, [r11, #4294966820]
	str r7, [sp, #80]
	ldr r7, [sp, #24]
	str r2, [sp, #84]
	ldr r2, [r1, #0]
	str r12, [sp, #88]
	ldr r1, [sp, #4]
	add r12, r7, r7, lsl       #3
	vldrw.u32 q2, [r11, #4294966900]
	add r12, r7, r12, lsl       #1
	add lr, r1, r1, lsl       #3
	veor q4, q3, q2
	ldr r7, [sp, #32]
	add lr, r1, lr, lsl       #1
	vldrw.u32 q1, [r11, #4294966980]
	str r12, [sp, #92]
	umull lr, r12, lr, r7
	ldr r1, [sp, #36]
	veor q0, q4, q1
	ldr r6, [sp, #16]
	umlal lr, r12, r1, r4
	umull r4, r1, r4, r7
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
	ldr r6, [sp, #68]
	veor q4, q0, q1
	umlal r8, r1, r4, r6
	ldr r6, [sp, #92]
	ldr r4, [sp, #84]
	umlal r8, r1, r6, r7
	ldr r6, [sp, #88]
	str r0, [sp, #116]
	umlal r8, r1, r6, r4
	ldr r6, [sp, #80]
	vldrw.u32 q1, [r11, #4294966996]
	umlal r8, r1, r6, r2
	veor q4, q4, q1
	ldr r4, [sp, #12]
	str r1, [sp, #104]
	ldr r6, [sp, #20]
	str r8, [sp, #108]
	vldrw.u32 q1, [r11, #4294967076]
	bic r8, r8, #-67108864
	add r1, r6, r6, lsl       #3
	veor q3, q4, q1
	vldrw.u32 q1, [r11, #4294967156]
	str r8, [sp, #112]
	add r1, r6, r1, lsl       #1
	veor q1, q3, q1
	umlal lr, r12, r1, r4
	ldr r4, [sp, #60]
	umlal lr, r12, r10, r0
	ldr r6, [sp, #68]
	add r8, r4, r4, lsl       #3
	vldrw.u32 q0, [r11, #4294966852]
	vstrw.u32 q1, [q7, #236]
	add r8, r4, r8, lsl       #1
	ldr r7, [sp, #104]
	umlal lr, r12, r8, r5
	ldr r5, [sp, #92]
	umlal lr, r12, r5, r6
	ldr r6, [sp, #108]
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
	vldrw.u32 q4, [r11, #4294967172]
	adds r4, lr, r4
	mov r6, r8
	veor q3, q0, q4
	ldr r2, [sp, #124]
	mov r8, r4
	adc r9, r12, r2
	ldr r2, [sp, #100]
	ldr r5, [sp, #36]
	vstrw.u32 q3, [q7, #252]
	bic r12, r4, #-33554432
	vldrw.u32 q2, [r11, #4]
	umull r4, r1, r7, r1
	str r0, [sp, #136]
	umlal r4, r1, r5, r2
	vldrw.u32 q0, [r11, #84]
	mov r2, r0
	umlal r4, r1, r10, r3
	ldr r0, [sp, #12]
	str r12, [sp, #140]
	umlal r4, r1, r2, r0
	ldr r0, [sp, #116]
	veor q0, q2, q0
	ldr r2, [sp, #92]
	str r6, [sp, #144]
	vldrw.u32 q2, [r11, #164]
	umlal r4, r1, r2, r0
	mov r2, r6
	veor q0, q0, q2
	ldr r6, [sp, #28]
	umlal r4, r1, r2, r6
	ldr r6, [sp, #68]
	lsrl r8, r9, #25
	ldr r2, [sp, #80]
	vldrw.u32 q1, [r11, #244]
	umlal r4, r1, r6, r2
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
	ldr r4, [sp, #40]
	umlal lr, r12, r4, r3
	ldr r4, [sp, #12]
	umlal lr, r12, r10, r4
	ldr r7, [sp, #72]
	umlal lr, r12, r2, r0
	ldr r2, [sp, #92]
	umlal lr, r12, r2, r6
	ldr r2, [sp, #88]
	veor q4, q0, q1
	ldr r6, [sp, #68]
	umlal lr, r12, r2, r6
	ldr r2, [sp, #80]
	umlal lr, r12, r7, r2
	ldr r7, [sp, #84]
	ldr r2, [sp, #132]
	umlal lr, r12, r7, r2
	ldr r2, [sp, #128]
	ldr r7, [sp, #44]
	umlal lr, r12, r7, r2
	vldrw.u32 q1, [r11, #180]
	veor q4, q4, q1
	adds lr, lr, r8
	vldrw.u32 q1, [r11, #260]
	adc r2, r12, r9
	veor q3, q4, q1
	str r2, [sp, #156]
	vldrw.u32 q1, [r11, #340]
	veor q1, q3, q1
	str lr, [sp, #152]
	bic r12, lr, #-67108864
	ldr r9, [sp, #156]
	vstrw.u32 q1, [q7, #284]
	ldr r8, [sp, #152]
	ldr r2, [sp, #4]
	lsrl r8, r9, #26
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
	veor q2, q0, q4
	ldr r4, [sp, #44]
	vstrw.u32 q2, [q7, #300]
	ldr r2, [sp, #84]
	umlal lr, r12, r6, r4
	ldr r4, [sp, #4]
	ldr r6, [sp, #72]
	umlal lr, r12, r6, r4
	ldr r6, [sp, #148]
	mov r4, r8
	vldrw.u32 q4, [r11, #52]
	adds r4, r6, r4
	mov r8, r4
	ldr r6, [sp, #172]
	bic r4, r4, #-33554432
	vldrw.u32 q2, [r11, #132]
	adc r9, r1, r6
	veor q3, q4, q2
	ldr r1, [sp, #52]
	lsrl r8, r9, #25
	umlal lr, r12, r2, r1
	ldr r1, [sp, #128]
	ldr r6, [sp, #20]
	umlal lr, r12, r6, r1
	vldrw.u32 q4, [r11, #212]
	veor q1, q3, q4
	ldr r2, [sp, #0]
	str lr, [sp, #176]
	umull lr, r1, r10, r7
	vldrw.u32 q0, [r11, #292]
	str r4, [r2, #12]
	veor q0, q1, q0
	ldr r4, [sp, #40]
	ldr r2, [sp, #92]
	umlal lr, r1, r5, r4
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
	ldr r6, [sp, #52]
	str r4, [sp, #188]
	ldr r2, [sp, #128]
	umlal lr, r1, r6, r2
	vldrw.u32 q4, [r11, #228]
	veor q2, q0, q4
	adds lr, lr, r8
	vldrw.u32 q1, [r11, #308]
	adc r1, r1, r9
	str lr, [sp, #180]
	str r1, [sp, #184]
	ldr r9, [sp, #184]
	ldr r8, [sp, #180]
	bic r1, lr, #-67108864
	ldr r6, [sp, #144]
	veor q0, q2, q1
	lsrl r8, r9, #26
	ldr r2, [sp, #0]
	umull r10, lr, r7, r6
	ldr r6, [sp, #48]
	str r1, [r2, #16]
	ldr r2, [sp, #92]
	vldrw.u32 q1, [r11, #388]
	umlal r10, lr, r5, r2
	veor q1, q0, q1
	ldr r2, [sp, #80]
	vstrw.u32 q1, [q7, #332]
	vldrw.u32 q0, [q7, #284]
	umlal r10, lr, r3, r2
	umlal r10, lr, r4, r6
	ldr r4, [sp, #44]
	ldr r6, [sp, #28]
	umlal r10, lr, r0, r4
	ldr r4, [sp, #4]
	vshl.i32 q1, q0, #1
	ldr r2, [sp, #72]
	umlal r10, lr, r6, r4
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
	ldr r4, [sp, #60]
	veor q3, q0, q2
	ldr r2, [sp, #128]
	str r12, [sp, #196]
	ldr r8, [sp, #192]
	umlal r10, lr, r4, r2
	ldr r9, [sp, #196]
	vstrw.u32 q3, [q7, #428]
	ldr r2, [sp, #92]
	vldrw.u32 q3, [q7, #300]
	str r10, [sp, #200]
	lsrl r8, r9, #25
	umull r4, r12, r2, r7
	ldr r2, [sp, #64]
	vshl.i32 q2, q3, #1
	ldr r6, [sp, #28]
	str r3, [sp, #204]
	vldrw.u32 q1, [q7, #188]
	umlal r4, r12, r5, r2
	vsri.32 q2, q3, #31
	ldr r2, [sp, #88]
	str r8, [sp, #208]
	umlal r4, r12, r2, r3
	ldr r3, [sp, #188]
	ldr r2, [sp, #80]
	str r9, [sp, #212]
	umlal r4, r12, r3, r2
	ldr r3, [sp, #132]
	veor q1, q2, q1
	ldr r2, [sp, #72]
	umlal r4, r12, r0, r3
	ldr r3, [sp, #44]
	umlal r4, r12, r6, r3
	ldr r6, [sp, #68]
	vstrw.u32 q1, [q7, #364]
	ldr r3, [sp, #164]
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
	ldr r3, [sp, #0]
	ldr r2, [sp, #48]
	bic r8, r8, #-67108864
	vldrw.u32 q4, [q7, #204]
	str r8, [r3, #24]
	umull r12, r8, r7, r2
	ldr r3, [sp, #60]
	veor q1, q1, q4
	ldr r2, [sp, #88]
	lsl r9, r3, #1
	ldr r3, [sp, #80]
	vstrw.u32 q1, [q7, #380]
	vldrw.u32 q3, [q7, #236]
	umlal r12, r8, r5, r3
	ldr r4, [sp, #204]
	umull r3, r10, r7, r3
	vldrw.u32 q1, [q7, #284]
	umlal r3, r10, r5, r2
	ldr r2, [sp, #132]
	ldr r5, [sp, #44]
	umlal r3, r10, r4, r2
	umlal r12, r8, r4, r5
	ldr r4, [sp, #188]
	veor q1, q3, q1
	ldr r2, [sp, #72]
	umlal r3, r10, r4, r5
	ldr r5, [sp, #4]
	vstrw.u32 q1, [q7, #460]
	vldrw.u32 q0, [q7, #332]
	umlal r12, r8, r4, r5
	ldr r5, [sp, #164]
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
	ldr r2, [sp, #224]
	veor q2, q0, q2
	ldr r5, [sp, #228]
	adds r4, r6, r2
	vstrw.u32 q2, [q7, #476]
	mov r2, r4
	vldrw.u32 q1, [q7, #268]
	mov r1, r3
	adc r3, lr, r5
	lsrl r2, r3, #25
	ldr r0, [sp, #0]
	adds r1, r1, r2
	bic r4, r4, #-33554432
	vshl.i32 q4, q1, #1
	str r4, [r0, #28]
	mov r4, r1
	adc r5, r10, r3
	vsri.32 q4, q1, #31
	lsrl r4, r5, #26
	adds r12, r12, r4
	vldrw.u32 q0, [q7, #236]
	mov r2, r12
	adc r3, r8, r5
	lsrl r2, r3, #25
	bic r10, r1, #-67108864
	mov r4, r2
	veor q1, q4, q0
	mov r5, r3
	vstrw.u32 q1, [q7, #412]
	bic r1, r12, #-33554432
	vldrw.u32 q0, [q7, #188]
	lsll r4, r5, #3
	str r10, [r0, #32]
	str r1, [r0, #36]
	adds r1, r4, r2
	adc r4, r5, r3
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
	add sp, sp, #240
	pop {r3-r11, pc}
.size fiat_mul_u4s_p0, .-fiat_mul_u4s_p0

