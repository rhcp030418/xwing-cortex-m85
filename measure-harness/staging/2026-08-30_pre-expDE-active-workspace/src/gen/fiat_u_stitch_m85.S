/* expAM1b(2026-08-25): AM 커널 ITCM 자리 확보를 위해 flash 로 퇴거.
 * U 는 이미 기각된 트랙이고 대표 경로가 아니다(AF2-P 판례).
 * 이 변경으로 U 계열 슬롯(expAE/expAF/expAI)의 사이클 값이 달라진다 —
 * expAM1b 결과에서 U 계열 수치를 인용하지 않는다.
 * 되돌리려면 아래 .text 를 .itcm_code_from_flash 로 되돌린다. */
.section .text.fiat_u_stitch, "ax", %progbits
.syntax unified
.thumb
.arch armv8.1-m.main
.arch_extension mve

// Experiment AE: arbitrary-operand r11-fixed Fiat mul + b1 fragments.
.global fiat_mul_y11_scalar
.type fiat_mul_y11_scalar, %function
.thumb_func
.balign 16
fiat_mul_y11_scalar:
	push {r3-r11, lr}
	sub sp, sp, #144
	mov	ip, #38
	mov	lr, r2
	ldr	r3, [r2, #4]
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	mul	r6, ip, r2
	str	r0, [sp, #84]
	str	r2, [sp, #40]
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str	r6, [sp, #120]
	str	r2, [sp, #8]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	add	r8, r0, r2, lsl #1
	str	r8, [sp, #96]
	ldr	r2, [lr, #28]
	mul	r8, ip, r6
	str	r6, [sp, #52]
	ldr	r6, [r1, #16]
	str	r7, [sp, #108]
	str	r6, [sp, #16]
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	str	r7, [sp, #80]
	ldr	r7, [lr, #24]
	str	r5, [sp, #100]
	mov	r2, r7
	mov	r5, r4
	str	r8, [sp, #116]
	mul	r8, ip, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	add	r10, r2, r7, lsl #1
	str	r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #64]
	mul	r5, ip, r3
	str	r0, [sp, #76]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #112]
	str	r6, [sp, #72]
	str	r8, [sp, #88]
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str	r7, [sp, #24]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #20]
	ldr	r7, [lr]
	str	r2, [sp, #104]
	ldr	r2, [r1, #4]
	str	r7, [sp, #32]
	ldr	r7, [sp, #108]
	str	r2, [sp, #4]
	ldr	r2, [r1]
	ldr	r1, [sp, #40]
	str	ip, [sp, #68]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #80]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #36]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #100]
	ldr	r6, [sp, #96]
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	str	r3, [sp, #96]
	umlal	lr, ip, r6, r3
	ldr	r3, [sp, #100]
	ldr	r7, [sp, #20]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r3, [sp, #96]
	ldr	r5, [sp, #120]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	ldr	r4, [sp, #116]
	ldr	r5, [sp, #16]
	umlal	r8, r1, r4, r0
	umlal	r8, r1, r10, r5
	ldr	r4, [sp, #88]
	str	r6, [sp, #96]
	ldr	r6, [sp, #24]
	umlal	r8, r1, r4, r6
	ldr	r6, [sp, #36]
	ldr	r4, [sp, #4]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #68]
	umlal	r8, r1, r6, r4
	ldr	r6, [sp, #32]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #52]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	umlal	lr, ip, r1, r4
	ldr	r4, [sp, #72]
	umlal	lr, ip, r10, r0
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	str	r8, [sp, #132]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r5
	ldr	r6, [sp, #24]
	ldr	r5, [sp, #36]
	str	r0, [sp, #124]
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr	r5, [sp, #104]
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	ldr	r7, [sp, #20]
	add	r8, r5, r8, lsl #1
	umlal	lr, ip, r8, r7
	ldr	r4, [sp, #32]
	ldr	r5, [sp, #4]
	str	r2, [sp, #48]
	umlal	lr, ip, r5, r4
	ldr	r5, [sp, #64]
	ldr	r4, [sp, #56]
	umlal	lr, ip, r5, r2
	lsls	r2, r5, #1
	ldr	r7, [sp, #80]
	str	r2, [sp, #92]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	mov	r6, r8
	adc	r9, ip, r2
	mov	r8, r4
	ldrd	r2, r5, [sp, #96]
	bic	ip, r4, #-33554432
	umull	r4, r1, r7, r1
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	str	r0, [sp, #128]
	ldr	r0, [sp, #8]
	str	ip, [sp, #136]
	umlal	r4, r1, r2, r0
	ldr	r0, [sp, #124]
	ldr	r2, [sp, #36]
	str	r6, [sp, #124]
	umlal	r4, r1, r2, r0
	mov	r2, r6
	ldr	r6, [sp, #16]
	lsrl	r8, r9, #25
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #32]
	umlal	r4, r1, r6, r2
	ldr	r6, [sp, #64]
	ldr	r2, [sp, #20]
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #44]
	ldr	r2, [sp, #4]
	umlal	r4, r1, r2, r6
	mov	ip, r4
	ldr	r2, [sp, #48]
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #16]
	umlal	ip, r1, r4, r2
	ldr	r4, [sp, #96]
	str	ip, [sp, #140]
	umull	lr, ip, r4, r7
	ldr	r4, [sp, #120]
	ldr	r2, [sp, #88]
	umlal	lr, ip, r5, r4
	ldr	r4, [sp, #116]
	ldr	r7, [sp, #20]
	umlal	lr, ip, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, ip, r10, r4
	umlal	lr, ip, r2, r0
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #68]
	umlal	lr, ip, r2, r6
	ldr	r2, [sp, #32]
	umlal	lr, ip, r7, r2
	ldr	r2, [sp, #92]
	ldr	r7, [sp, #4]
	umlal	lr, ip, r7, r2
	ldrd	r7, r2, [sp, #44]
	umlal	lr, ip, r7, r2
	adds	lr, lr, r8
	adc	r2, ip, r9
	str	lr, [sp, #56]
	str	r2, [sp, #60]
	ldr	r2, [sp, #40]
	ldrd	r8, [sp, #56]
	lsrl	r8, r9, #26
	bic	ip, lr, #-67108864
	lsls	r2, r2, #1
	str	ip, [sp, #120]
	str	r2, [sp, #100]
	ldr	r2, [sp, #128]
	ldr	r7, [sp, #80]
	strd	r8, [sp, #56]
	umull	lr, ip, r7, r2
	umlal	lr, ip, r5, r10
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r3
	ldr	r2, [sp, #124]
	umlal	lr, ip, r2, r4
	ldr	r2, [sp, #32]
	ldr	r4, [sp, #16]
	umlal	lr, ip, r0, r2
	ldr	r2, [sp, #64]
	umlal	lr, ip, r4, r2
	ldr	r4, [sp, #44]
	ldr	r2, [sp, #4]
	umlal	lr, ip, r6, r4
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #20]
	umlal	lr, ip, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #140]
	adds	r4, r6, r4
	mov	r8, r4
	ldr	r6, [sp, #60]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	ldr	r1, [sp, #76]
	lsrl	r8, r9, #25
	umlal	lr, ip, r2, r1
	ldrd	r1, r6, [sp, #48]
	umlal	lr, ip, r6, r1
	ldr	r2, [sp, #84]
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	ldr	r4, [sp, #116]
	ldr	r2, [sp, #36]
	umlal	lr, r1, r5, r4
	ldr	r4, [sp, #88]
	ldr	r6, [sp, #68]
	umlal	lr, r1, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, r1, r2, r4
	umlal	lr, r1, r6, r0
	ldr	r2, [sp, #32]
	ldr	r6, [sp, #16]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #92]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #20]
	ldr	r2, [sp, #44]
	umlal	lr, r1, r6, r2
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #100]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #76]
	ldr	r2, [sp, #48]
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	adc	r1, r1, r9
	str	lr, [sp, #8]
	str	r1, [sp, #12]
	ldrd	r8, [sp, #8]
	lsrl	r8, r9, #26
	ldr	r6, [sp, #124]
	ldr	r2, [sp, #84]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	str	r1, [r2, #16]
	ldr	r2, [sp, #36]
	ldr	r6, [sp, #64]
	umlal	r10, lr, r5, r2
	ldr	r2, [sp, #32]
	str	r4, [sp, #8]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	ldr	r4, [sp, #44]
	ldr	r6, [sp, #16]
	umlal	r10, lr, r0, r4
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #20]
	umlal	r10, lr, r6, r4
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #76]
	ldr	r1, [sp, #52]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #56]
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr	r6, [sp, #52]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r6
	ldr	r2, [sp, #84]
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr	r4, [sp, #112]
	ldr	r2, [sp, #4]
	adc	ip, ip, r9
	umlal	r10, lr, r2, r4
	ldr	r4, [sp, #72]
	ldr	r2, [sp, #48]
	str	ip, [sp, #60]
	umlal	r10, lr, r4, r2
	ldrd	r8, [sp, #56]
	str	r10, [sp, #80]
	ldr	r2, [sp, #36]
	lsrl	r8, r9, #25
	umull	r4, ip, r2, r7
	ldr	r2, [sp, #88]
	str	r3, [sp, #96]
	umlal	r4, ip, r5, r2
	ldr	r2, [sp, #68]
	ldr	r6, [sp, #16]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #8]
	ldr	r2, [sp, #32]
	strd	r8, [sp, #56]
	umlal	r4, ip, r3, r2
	ldr	r3, [sp, #92]
	ldr	r2, [sp, #20]
	umlal	r4, ip, r0, r3
	ldr	r3, [sp, #44]
	umlal	r4, ip, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #100]
	umlal	r4, ip, r6, r3
	ldr	r3, [sp, #76]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #48]
	umlal	r4, ip, r3, r1
	ldr	r3, [sp, #112]
	umlal	r4, ip, r3, r2
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, ip, r4
	str	r4, [sp, #28]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #84]
	ldr	r2, [sp, #64]
	bic	r8, r8, #-67108864
	str	r8, [r3, #24]
	ldr	r3, [sp, #72]
	umull	ip, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #32]
	ldr	r2, [sp, #68]
	umlal	ip, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	ldrd	r2, r4, [sp, #92]
	ldr	r5, [sp, #44]
	umlal	r3, r10, r4, r2
	umlal	ip, r8, r4, r5
	ldr	r4, [sp, #8]
	ldr	r2, [sp, #20]
	umlal	r3, r10, r4, r5
	ldr	r5, [sp, #40]
	umlal	ip, r8, r4, r5
	ldr	r5, [sp, #100]
	ldr	r4, [sp, #76]
	umlal	r3, r10, r0, r5
	umlal	ip, r8, r0, r4
	ldr	r0, [sp, #16]
	ldr	r5, [sp, #104]
	umlal	r3, r10, r0, r4
	ldr	r4, [sp, #52]
	umlal	r3, r10, r6, r1
	umlal	ip, r8, r0, r4
	ldr	r0, [sp, #112]
	ldr	r4, [sp, #72]
	umlal	ip, r8, r6, r0
	umlal	r3, r10, r2, r0
	umlal	ip, r8, r2, r4
	ldr	r0, [sp, #108]
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #80]
	umlal	r3, r10, r2, r9
	umlal	ip, r8, r2, r0
	ldr	r2, [sp, #48]
	umlal	r3, r10, r0, r2
	umlal	ip, r8, r2, r5
	ldr	r2, [sp, #24]
	ldr	r5, [sp, #28]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	ldr	r0, [sp, #84]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	lsrl	r4, r5, #26
	adds	ip, ip, r4
	mov	r2, ip
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r4, r2
	mov	r5, r3
	lsll	r4, r5, #3
	bic	r1, r1, #-67108864
	str	r1, [r0, #32]
	bic	r1, ip, #-33554432
	str	r1, [r0, #36]
	adds	r1, r4, r2
	adc	r4, r5, r3
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	adc	r4, r4, r3
	ldr	r3, [sp, #132]
	adds	r1, r1, r3
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	bic	r1, r1, #-67108864
	str	r1, [r0]
	ldr	r1, [sp, #136]
	adds	r3, r1, r2
	ldr	r1, [sp, #120]
	bic	r2, r3, #-33554432
	add	r3, r1, r3, lsr #25
	strd	r2, r3, [r0, #4]
	add sp, sp, #144
	pop {r3-r11, pc}
.size fiat_mul_y11_scalar, .-fiat_mul_y11_scalar

.global fiat_mul_u4_p0
.type fiat_mul_u4_p0, %function
.thumb_func
.balign 16
fiat_mul_u4_p0:
	push {r3-r11, lr}
	sub sp, sp, #144
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
	mov	ip, #38
	vldrw.u32 q0, [r11, #-508]
	mov	lr, r2
	ldr	r3, [r2, #4]
	vldrw.u32 q1, [r11, #-428]
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	veor q0, q0, q1
	mul	r6, ip, r2
	str	r0, [sp, #84]
	str	r2, [sp, #40]
	vldrw.u32 q1, [r11, #-348]
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str	r6, [sp, #120]
	veor q0, q0, q1
	str	r2, [sp, #8]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	vldrw.u32 q1, [r11, #-268]
	add	r8, r0, r2, lsl #1
	str	r8, [sp, #96]
	ldr	r2, [lr, #28]
	veor q0, q0, q1
	mul	r8, ip, r6
	str	r6, [sp, #52]
	ldr	r6, [r1, #16]
	vldrw.u32 q1, [r11, #-188]
	str	r7, [sp, #108]
	str	r6, [sp, #16]
	veor q0, q0, q1
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	vstrw.u32 q0, [q7, #188]
	str	r7, [sp, #80]
	ldr	r7, [lr, #24]
	str	r5, [sp, #100]
	vldrw.u32 q0, [r11, #-492]
	mov	r2, r7
	mov	r5, r4
	str	r8, [sp, #116]
	vldrw.u32 q1, [r11, #-412]
	mul	r8, ip, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	veor q0, q0, q1
	add	r10, r2, r7, lsl #1
	str	r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	vldrw.u32 q1, [r11, #-332]
	str	r3, [sp, #64]
	mul	r5, ip, r3
	str	r0, [sp, #76]
	veor q0, q0, q1
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #112]
	vldrw.u32 q1, [r11, #-252]
	str	r6, [sp, #72]
	str	r8, [sp, #88]
	veor q0, q0, q1
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str	r7, [sp, #24]
	vldrw.u32 q1, [r11, #-172]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #20]
	veor q0, q0, q1
	ldr	r7, [lr]
	str	r2, [sp, #104]
	ldr	r2, [r1, #4]
	vstrw.u32 q0, [q7, #204]
	str	r7, [sp, #32]
	ldr	r7, [sp, #108]
	str	r2, [sp, #4]
	vldrw.u32 q0, [r11, #-476]
	ldr	r2, [r1]
	ldr	r1, [sp, #40]
	str	ip, [sp, #68]
	vldrw.u32 q1, [r11, #-396]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	add	lr, r1, r1, lsl #3
	veor q0, q0, q1
	ldr	r7, [sp, #80]
	add	lr, r1, lr, lsl #1
	vldrw.u32 q1, [r11, #-316]
	str	ip, [sp, #36]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #100]
	veor q0, q0, q1
	ldr	r6, [sp, #96]
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	vldrw.u32 q1, [r11, #-236]
	str	r3, [sp, #96]
	umlal	lr, ip, r6, r3
	ldr	r3, [sp, #100]
	veor q0, q0, q1
	ldr	r7, [sp, #20]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	vldrw.u32 q1, [r11, #-156]
	ldr	r3, [sp, #96]
	ldr	r5, [sp, #120]
	ldr	r4, [sp, #8]
	veor q0, q0, q1
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	ldr	r4, [sp, #116]
	vstrw.u32 q0, [q7, #220]
	ldr	r5, [sp, #16]
	umlal	r8, r1, r4, r0
	umlal	r8, r1, r10, r5
	vldrw.u32 q0, [r11, #-460]
	ldr	r4, [sp, #88]
	str	r6, [sp, #96]
	vldrw.u32 q1, [r11, #-380]
	ldr	r6, [sp, #24]
	umlal	r8, r1, r4, r6
	ldr	r6, [sp, #36]
	veor q0, q0, q1
	ldr	r4, [sp, #4]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #68]
	vldrw.u32 q1, [r11, #-300]
	umlal	r8, r1, r6, r4
	ldr	r6, [sp, #32]
	ldr	r4, [sp, #8]
	veor q0, q0, q1
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #52]
	str	r1, [sp, #60]
	vldrw.u32 q1, [r11, #-220]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	umlal	lr, ip, r1, r4
	veor q0, q0, q1
	ldr	r4, [sp, #72]
	umlal	lr, ip, r10, r0
	str	r8, [sp, #56]
	vldrw.u32 q1, [r11, #-140]
	bic	r8, r8, #-67108864
	str	r8, [sp, #132]
	add	r8, r4, r4, lsl #3
	veor q0, q0, q1
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r5
	vstrw.u32 q0, [q7, #236]
	ldr	r6, [sp, #24]
	ldr	r5, [sp, #36]
	str	r0, [sp, #124]
	vldrw.u32 q0, [r11, #-444]
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	vldrw.u32 q1, [r11, #-364]
	mov	r0, r8
	ldr	r5, [sp, #104]
	strd	r6, [sp, #56]
	veor q0, q0, q1
	add	r8, r5, r5, lsl #3
	ldr	r7, [sp, #20]
	add	r8, r5, r8, lsl #1
	vldrw.u32 q1, [r11, #-284]
	umlal	lr, ip, r8, r7
	ldr	r4, [sp, #32]
	ldr	r5, [sp, #4]
	veor q0, q0, q1
	str	r2, [sp, #48]
	umlal	lr, ip, r5, r4
	ldr	r5, [sp, #64]
	vldrw.u32 q1, [r11, #-204]
	ldr	r4, [sp, #56]
	umlal	lr, ip, r5, r2
	veor q0, q0, q1
	lsls	r2, r5, #1
	ldr	r7, [sp, #80]
	str	r2, [sp, #92]
	vldrw.u32 q1, [r11, #-124]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	mov	r6, r8
	veor q0, q0, q1
	adc	r9, ip, r2
	mov	r8, r4
	ldrd	r2, r5, [sp, #96]
	vstrw.u32 q0, [q7, #252]
	bic	ip, r4, #-33554432
	umull	r4, r1, r7, r1
	umlal	r4, r1, r5, r2
	vldrw.u32 q0, [r11, #4]
	mov	r2, r0
	umlal	r4, r1, r10, r3
	str	r0, [sp, #128]
	vldrw.u32 q1, [r11, #84]
	ldr	r0, [sp, #8]
	str	ip, [sp, #136]
	umlal	r4, r1, r2, r0
	veor q0, q0, q1
	ldr	r0, [sp, #124]
	ldr	r2, [sp, #36]
	str	r6, [sp, #124]
	vldrw.u32 q1, [r11, #164]
	umlal	r4, r1, r2, r0
	mov	r2, r6
	veor q0, q0, q1
	ldr	r6, [sp, #16]
	lsrl	r8, r9, #25
	umlal	r4, r1, r2, r6
	vldrw.u32 q1, [r11, #244]
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #32]
	umlal	r4, r1, r6, r2
	veor q0, q0, q1
	ldr	r6, [sp, #64]
	ldr	r2, [sp, #20]
	umlal	r4, r1, r2, r6
	vldrw.u32 q1, [r11, #324]
	ldr	r6, [sp, #44]
	ldr	r2, [sp, #4]
	umlal	r4, r1, r2, r6
	veor q0, q0, q1
	mov	ip, r4
	ldr	r2, [sp, #48]
	ldr	r4, [sp, #40]
	vstrw.u32 q0, [q7, #268]
	ldr	r6, [sp, #16]
	umlal	ip, r1, r4, r2
	ldr	r4, [sp, #96]
	vldrw.u32 q0, [r11, #20]
	str	ip, [sp, #140]
	umull	lr, ip, r4, r7
	ldr	r4, [sp, #120]
	vldrw.u32 q1, [r11, #100]
	ldr	r2, [sp, #88]
	umlal	lr, ip, r5, r4
	veor q0, q0, q1
	ldr	r4, [sp, #116]
	ldr	r7, [sp, #20]
	umlal	lr, ip, r4, r3
	vldrw.u32 q1, [r11, #180]
	ldr	r4, [sp, #8]
	umlal	lr, ip, r10, r4
	umlal	lr, ip, r2, r0
	veor q0, q0, q1
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r6
	ldr	r6, [sp, #24]
	vldrw.u32 q1, [r11, #260]
	ldr	r2, [sp, #68]
	umlal	lr, ip, r2, r6
	ldr	r2, [sp, #32]
	veor q0, q0, q1
	umlal	lr, ip, r7, r2
	ldr	r2, [sp, #92]
	ldr	r7, [sp, #4]
	vldrw.u32 q1, [r11, #340]
	umlal	lr, ip, r7, r2
	ldrd	r7, r2, [sp, #44]
	umlal	lr, ip, r7, r2
	veor q0, q0, q1
	adds	lr, lr, r8
	adc	r2, ip, r9
	vstrw.u32 q0, [q7, #284]
	str	lr, [sp, #56]
	str	r2, [sp, #60]
	ldr	r2, [sp, #40]
	vldrw.u32 q0, [r11, #36]
	ldrd	r8, [sp, #56]
	lsrl	r8, r9, #26
	bic	ip, lr, #-67108864
	vldrw.u32 q1, [r11, #116]
	lsls	r2, r2, #1
	str	ip, [sp, #120]
	str	r2, [sp, #100]
	veor q0, q0, q1
	ldr	r2, [sp, #128]
	ldr	r7, [sp, #80]
	strd	r8, [sp, #56]
	vldrw.u32 q1, [r11, #196]
	umull	lr, ip, r7, r2
	umlal	lr, ip, r5, r10
	ldr	r2, [sp, #36]
	veor q0, q0, q1
	umlal	lr, ip, r2, r3
	ldr	r2, [sp, #124]
	umlal	lr, ip, r2, r4
	vldrw.u32 q1, [r11, #276]
	ldr	r2, [sp, #32]
	ldr	r4, [sp, #16]
	umlal	lr, ip, r0, r2
	veor q0, q0, q1
	ldr	r2, [sp, #64]
	umlal	lr, ip, r4, r2
	vldrw.u32 q1, [r11, #356]
	ldr	r4, [sp, #44]
	ldr	r2, [sp, #4]
	umlal	lr, ip, r6, r4
	veor q0, q0, q1
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #20]
	umlal	lr, ip, r6, r4
	vstrw.u32 q0, [q7, #300]
	mov	r4, r8
	ldr	r6, [sp, #140]
	adds	r4, r6, r4
	vldrw.u32 q0, [r11, #52]
	mov	r8, r4
	ldr	r6, [sp, #60]
	bic	r4, r4, #-33554432
	vldrw.u32 q1, [r11, #132]
	adc	r9, r1, r6
	ldr	r1, [sp, #76]
	lsrl	r8, r9, #25
	veor q0, q0, q1
	umlal	lr, ip, r2, r1
	ldrd	r1, r6, [sp, #48]
	umlal	lr, ip, r6, r1
	vldrw.u32 q1, [r11, #212]
	ldr	r2, [sp, #84]
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	veor q0, q0, q1
	str	r4, [r2, #12]
	ldr	r4, [sp, #116]
	vldrw.u32 q1, [r11, #292]
	ldr	r2, [sp, #36]
	umlal	lr, r1, r5, r4
	ldr	r4, [sp, #88]
	veor q0, q0, q1
	ldr	r6, [sp, #68]
	umlal	lr, r1, r4, r3
	ldr	r4, [sp, #8]
	vldrw.u32 q1, [r11, #372]
	umlal	lr, r1, r2, r4
	umlal	lr, r1, r6, r0
	ldr	r2, [sp, #32]
	veor q0, q0, q1
	ldr	r6, [sp, #16]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #24]
	vstrw.u32 q0, [q7, #316]
	ldr	r2, [sp, #92]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #20]
	vldrw.u32 q0, [r11, #68]
	ldr	r2, [sp, #44]
	umlal	lr, r1, r6, r2
	ldr	r2, [sp, #4]
	vldrw.u32 q1, [r11, #148]
	ldr	r6, [sp, #100]
	umlal	lr, r1, r2, r6
	veor q0, q0, q1
	ldr	r6, [sp, #76]
	ldr	r2, [sp, #48]
	umlal	lr, r1, r6, r2
	vldrw.u32 q1, [r11, #228]
	adds	lr, lr, r8
	adc	r1, r1, r9
	str	lr, [sp, #8]
	veor q0, q0, q1
	str	r1, [sp, #12]
	ldrd	r8, [sp, #8]
	lsrl	r8, r9, #26
	vldrw.u32 q1, [r11, #308]
	ldr	r6, [sp, #124]
	ldr	r2, [sp, #84]
	bic	r1, lr, #-67108864
	veor q0, q0, q1
	umull	r10, lr, r7, r6
	str	r1, [r2, #16]
	ldr	r2, [sp, #36]
	vldrw.u32 q1, [r11, #388]
	ldr	r6, [sp, #64]
	umlal	r10, lr, r5, r2
	ldr	r2, [sp, #32]
	veor q0, q0, q1
	str	r4, [sp, #8]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	vstrw.u32 q0, [q7, #332]
	ldr	r4, [sp, #44]
	ldr	r6, [sp, #16]
	vldrw.u32 q0, [q7, #284]
	umlal	r10, lr, r0, r4
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #20]
	vshl.i32 q1, q0, #1
	umlal	r10, lr, r6, r4
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #76]
	vsri.32 q1, q0, #31
	ldr	r1, [sp, #52]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	vldrw.u32 q2, [q7, #252]
	ldr	r6, [sp, #56]
	lsls	r1, r1, #1
	adds	r4, r6, r4
	veor q1, q1, q2
	ldr	r6, [sp, #52]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r6
	vstrw.u32 q1, [q7, #348]
	ldr	r2, [sp, #84]
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	vldrw.u32 q0, [q7, #204]
	ldr	r4, [sp, #112]
	ldr	r2, [sp, #4]
	adc	ip, ip, r9
	vldrw.u32 q2, [q7, #332]
	umlal	r10, lr, r2, r4
	ldr	r4, [sp, #72]
	veor q0, q0, q2
	ldr	r2, [sp, #48]
	str	ip, [sp, #60]
	umlal	r10, lr, r4, r2
	vstrw.u32 q0, [q7, #428]
	ldrd	r8, [sp, #56]
	str	r10, [sp, #80]
	ldr	r2, [sp, #36]
	vldrw.u32 q0, [q7, #300]
	lsrl	r8, r9, #25
	umull	r4, ip, r2, r7
	ldr	r2, [sp, #88]
	vshl.i32 q1, q0, #1
	str	r3, [sp, #96]
	umlal	r4, ip, r5, r2
	ldr	r2, [sp, #68]
	vsri.32 q1, q0, #31
	ldr	r6, [sp, #16]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #8]
	vldrw.u32 q2, [q7, #188]
	ldr	r2, [sp, #32]
	strd	r8, [sp, #56]
	umlal	r4, ip, r3, r2
	veor q1, q1, q2
	ldr	r3, [sp, #92]
	ldr	r2, [sp, #20]
	vstrw.u32 q1, [q7, #364]
	umlal	r4, ip, r0, r3
	ldr	r3, [sp, #44]
	umlal	r4, ip, r6, r3
	vldrw.u32 q0, [q7, #220]
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #100]
	umlal	r4, ip, r6, r3
	vldrw.u32 q2, [q7, #268]
	ldr	r3, [sp, #76]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #4]
	veor q0, q0, q2
	ldr	r2, [sp, #48]
	umlal	r4, ip, r3, r1
	ldr	r3, [sp, #112]
	vstrw.u32 q0, [q7, #444]
	umlal	r4, ip, r3, r2
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	vldrw.u32 q0, [q7, #316]
	str	r8, [sp, #24]
	adc	r4, ip, r4
	str	r4, [sp, #28]
	vshl.i32 q1, q0, #1
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	vsri.32 q1, q0, #31
	ldr	r3, [sp, #84]
	ldr	r2, [sp, #64]
	vldrw.u32 q2, [q7, #204]
	bic	r8, r8, #-67108864
	str	r8, [r3, #24]
	ldr	r3, [sp, #72]
	veor q1, q1, q2
	umull	ip, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #32]
	vstrw.u32 q1, [q7, #380]
	ldr	r2, [sp, #68]
	umlal	ip, r8, r5, r3
	umull	r3, r10, r7, r3
	vldrw.u32 q0, [q7, #236]
	umlal	r3, r10, r5, r2
	ldrd	r2, r4, [sp, #92]
	ldr	r5, [sp, #44]
	vldrw.u32 q2, [q7, #284]
	umlal	r3, r10, r4, r2
	umlal	ip, r8, r4, r5
	ldr	r4, [sp, #8]
	veor q0, q0, q2
	ldr	r2, [sp, #20]
	umlal	r3, r10, r4, r5
	ldr	r5, [sp, #40]
	vstrw.u32 q0, [q7, #460]
	umlal	ip, r8, r4, r5
	ldr	r5, [sp, #100]
	ldr	r4, [sp, #76]
	vldrw.u32 q0, [q7, #332]
	umlal	r3, r10, r0, r5
	umlal	ip, r8, r0, r4
	vshl.i32 q1, q0, #1
	ldr	r0, [sp, #16]
	ldr	r5, [sp, #104]
	umlal	r3, r10, r0, r4
	vsri.32 q1, q0, #31
	ldr	r4, [sp, #52]
	umlal	r3, r10, r6, r1
	umlal	ip, r8, r0, r4
	vldrw.u32 q2, [q7, #220]
	ldr	r0, [sp, #112]
	ldr	r4, [sp, #72]
	umlal	ip, r8, r6, r0
	veor q1, q1, q2
	umlal	r3, r10, r2, r0
	umlal	ip, r8, r2, r4
	ldr	r0, [sp, #108]
	vstrw.u32 q1, [q7, #396]
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #80]
	umlal	r3, r10, r2, r9
	vldrw.u32 q0, [q7, #252]
	umlal	ip, r8, r2, r0
	ldr	r2, [sp, #48]
	umlal	r3, r10, r0, r2
	vldrw.u32 q2, [q7, #300]
	umlal	ip, r8, r2, r5
	ldr	r2, [sp, #24]
	veor q0, q0, q2
	ldr	r5, [sp, #28]
	adds	r4, r6, r2
	mov	r2, r4
	vstrw.u32 q0, [q7, #476]
	mov	r1, r3
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	vldrw.u32 q0, [q7, #268]
	ldr	r0, [sp, #84]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	vshl.i32 q1, q0, #1
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	vsri.32 q1, q0, #31
	lsrl	r4, r5, #26
	adds	ip, ip, r4
	mov	r2, ip
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
	bic	r1, ip, #-33554432
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
	ldr	r3, [sp, #132]
	adds	r1, r1, r3
	vstrw.u32 q0, [q7, #492]
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	vldrw.u32 q3, [q7, #348]
	bic	r1, r1, #-67108864
	str	r1, [r0]
	ldr	r1, [sp, #136]
	vldrw.u32 q4, [q7, #428]
	adds	r3, r1, r2
	ldr	r1, [sp, #120]
	bic	r2, r3, #-33554432
	vldrw.u32 q0, [r11, #-508]
	add	r3, r1, r3, lsr #25
	strd	r2, r3, [r0, #4]
	add sp, sp, #144
	pop {r3-r11, pc}
.size fiat_mul_u4_p0, .-fiat_mul_u4_p0

.global fiat_mul_u4_p1
.type fiat_mul_u4_p1, %function
.thumb_func
.balign 16
fiat_mul_u4_p1:
	push {r3-r11, lr}
	sub sp, sp, #144
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
	mov	ip, #38
	vldrw.u32 q1, [r11, #4]
	mov	lr, r2
	ldr	r3, [r2, #4]
	veor q0, q0, q3
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	veor q1, q1, q4
	mul	r6, ip, r2
	str	r0, [sp, #84]
	str	r2, [sp, #40]
	vorr q2, q0, q0
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str	r6, [sp, #120]
	vstrw.u32 q2, [r11, #404]
	str	r2, [sp, #8]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	vorr q5, q1, q1
	add	r8, r0, r2, lsl #1
	str	r8, [sp, #96]
	ldr	r2, [lr, #28]
	vstrw.u32 q5, [q7, #-212]
	mul	r8, ip, r6
	str	r6, [sp, #52]
	vldrw.u32 q0, [r11, #-428]
	ldr	r6, [r1, #16]
	str	r7, [sp, #108]
	str	r6, [sp, #16]
	vldrw.u32 q1, [r11, #84]
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	veor q0, q0, q3
	str	r7, [sp, #80]
	ldr	r7, [lr, #24]
	str	r5, [sp, #100]
	veor q1, q1, q4
	mov	r2, r7
	mov	r5, r4
	str	r8, [sp, #116]
	vshl.i32 q2, q0, #18
	mul	r8, ip, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	vsri.32 q2, q0, #14
	add	r10, r2, r7, lsl #1
	str	r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	vstrw.u32 q2, [q7, #-356]
	str	r3, [sp, #64]
	mul	r5, ip, r3
	vshl.i32 q5, q1, #18
	str	r0, [sp, #76]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	vsri.32 q5, q1, #14
	str	r2, [sp, #112]
	str	r6, [sp, #72]
	str	r8, [sp, #88]
	vstrw.u32 q5, [q7, #44]
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str	r7, [sp, #24]
	vldrw.u32 q0, [r11, #-348]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #20]
	vldrw.u32 q1, [r11, #164]
	ldr	r7, [lr]
	str	r2, [sp, #104]
	ldr	r2, [r1, #4]
	veor q0, q0, q3
	str	r7, [sp, #32]
	ldr	r7, [sp, #108]
	str	r2, [sp, #4]
	veor q1, q1, q4
	ldr	r2, [r1]
	ldr	r1, [sp, #40]
	vshl.i32 q2, q1, #2
	str	ip, [sp, #68]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	vsri.32 q2, q1, #30
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #80]
	add	lr, r1, lr, lsl #1
	vstrw.u32 q2, [q7, #-500]
	str	ip, [sp, #36]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #100]
	vshl.i32 q5, q0, #1
	ldr	r6, [sp, #96]
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	vsri.32 q5, q0, #31
	str	r3, [sp, #96]
	umlal	lr, ip, r6, r3
	ldr	r3, [sp, #100]
	vstrw.u32 q5, [q7, #-100]
	ldr	r7, [sp, #20]
	umlal	r4, r1, r3, r5
	vldrw.u32 q0, [r11, #-268]
	mov	r8, r4
	ldr	r3, [sp, #96]
	ldr	r5, [sp, #120]
	vldrw.u32 q1, [r11, #244]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	veor q0, q0, q3
	ldr	r4, [sp, #116]
	ldr	r5, [sp, #16]
	umlal	r8, r1, r4, r0
	veor q1, q1, q4
	umlal	r8, r1, r10, r5
	ldr	r4, [sp, #88]
	str	r6, [sp, #96]
	vshl.i32 q2, q1, #21
	ldr	r6, [sp, #24]
	umlal	r8, r1, r4, r6
	ldr	r6, [sp, #36]
	vsri.32 q2, q1, #11
	ldr	r4, [sp, #4]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #68]
	vstrw.u32 q2, [q7, #-244]
	umlal	r8, r1, r6, r4
	ldr	r6, [sp, #32]
	vshl.i32 q5, q0, #20
	ldr	r4, [sp, #8]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #52]
	vsri.32 q5, q0, #12
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	vstrw.u32 q5, [q7, #156]
	umlal	lr, ip, r1, r4
	ldr	r4, [sp, #72]
	umlal	lr, ip, r10, r0
	vldrw.u32 q0, [r11, #-188]
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	str	r8, [sp, #132]
	vldrw.u32 q1, [r11, #324]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r5
	veor q0, q0, q3
	ldr	r6, [sp, #24]
	ldr	r5, [sp, #36]
	str	r0, [sp, #124]
	veor q1, q1, q4
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	vshl.i32 q2, q0, #9
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr	r5, [sp, #104]
	vsri.32 q2, q0, #23
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	ldr	r7, [sp, #20]
	vstrw.u32 q2, [q7, #-388]
	add	r8, r5, r8, lsl #1
	umlal	lr, ip, r8, r7
	ldr	r4, [sp, #32]
	vshl.i32 q5, q1, #9
	ldr	r5, [sp, #4]
	str	r2, [sp, #48]
	umlal	lr, ip, r5, r4
	vsri.32 q5, q1, #23
	ldr	r5, [sp, #64]
	ldr	r4, [sp, #56]
	umlal	lr, ip, r5, r2
	vstrw.u32 q5, [q7, #12]
	lsls	r2, r5, #1
	ldr	r7, [sp, #80]
	vldrw.u32 q3, [q7, #364]
	str	r2, [sp, #92]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	vldrw.u32 q4, [q7, #444]
	mov	r6, r8
	adc	r9, ip, r2
	mov	r8, r4
	vldrw.u32 q0, [r11, #-492]
	ldrd	r2, r5, [sp, #96]
	bic	ip, r4, #-33554432
	umull	r4, r1, r7, r1
	vldrw.u32 q1, [r11, #20]
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	veor q0, q0, q3
	str	r0, [sp, #128]
	ldr	r0, [sp, #8]
	str	ip, [sp, #136]
	veor q1, q1, q4
	umlal	r4, r1, r2, r0
	ldr	r0, [sp, #124]
	ldr	r2, [sp, #36]
	vshl.i32 q2, q1, #1
	str	r6, [sp, #124]
	umlal	r4, r1, r2, r0
	vsri.32 q2, q1, #31
	mov	r2, r6
	ldr	r6, [sp, #16]
	lsrl	r8, r9, #25
	vstrw.u32 q2, [q7, #-452]
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #32]
	vorr q5, q0, q0
	umlal	r4, r1, r6, r2
	ldr	r6, [sp, #64]
	ldr	r2, [sp, #20]
	vstrw.u32 q5, [q7, #-52]
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #44]
	ldr	r2, [sp, #4]
	vldrw.u32 q0, [r11, #-412]
	umlal	r4, r1, r2, r6
	mov	ip, r4
	ldr	r2, [sp, #48]
	vldrw.u32 q1, [r11, #100]
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #16]
	umlal	ip, r1, r4, r2
	veor q0, q0, q3
	ldr	r4, [sp, #96]
	str	ip, [sp, #140]
	veor q1, q1, q4
	umull	lr, ip, r4, r7
	ldr	r4, [sp, #120]
	ldr	r2, [sp, #88]
	vshl.i32 q2, q0, #22
	umlal	lr, ip, r5, r4
	ldr	r4, [sp, #116]
	ldr	r7, [sp, #20]
	vsri.32 q2, q0, #10
	umlal	lr, ip, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, ip, r10, r4
	vstrw.u32 q2, [r11, #420]
	umlal	lr, ip, r2, r0
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r6
	vshl.i32 q5, q1, #22
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #68]
	umlal	lr, ip, r2, r6
	vsri.32 q5, q1, #10
	ldr	r2, [sp, #32]
	umlal	lr, ip, r7, r2
	vstrw.u32 q5, [q7, #-196]
	ldr	r2, [sp, #92]
	ldr	r7, [sp, #4]
	umlal	lr, ip, r7, r2
	vldrw.u32 q0, [r11, #-332]
	ldrd	r7, r2, [sp, #44]
	umlal	lr, ip, r7, r2
	adds	lr, lr, r8
	vldrw.u32 q1, [r11, #180]
	adc	r2, ip, r9
	str	lr, [sp, #56]
	str	r2, [sp, #60]
	veor q0, q0, q3
	ldr	r2, [sp, #40]
	ldrd	r8, [sp, #56]
	lsrl	r8, r9, #26
	veor q1, q1, q4
	bic	ip, lr, #-67108864
	lsls	r2, r2, #1
	str	ip, [sp, #120]
	vshl.i32 q2, q0, #5
	str	r2, [sp, #100]
	ldr	r2, [sp, #128]
	ldr	r7, [sp, #80]
	vsri.32 q2, q0, #27
	strd	r8, [sp, #56]
	umull	lr, ip, r7, r2
	vstrw.u32 q2, [q7, #-340]
	umlal	lr, ip, r5, r10
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r3
	vshl.i32 q5, q1, #5
	ldr	r2, [sp, #124]
	umlal	lr, ip, r2, r4
	ldr	r2, [sp, #32]
	vsri.32 q5, q1, #27
	ldr	r4, [sp, #16]
	umlal	lr, ip, r0, r2
	ldr	r2, [sp, #64]
	vstrw.u32 q5, [q7, #60]
	umlal	lr, ip, r4, r2
	ldr	r4, [sp, #44]
	ldr	r2, [sp, #4]
	vldrw.u32 q0, [r11, #-252]
	umlal	lr, ip, r6, r4
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #20]
	vldrw.u32 q1, [r11, #260]
	umlal	lr, ip, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #140]
	veor q0, q0, q3
	adds	r4, r6, r4
	mov	r8, r4
	veor q1, q1, q4
	ldr	r6, [sp, #60]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	vshl.i32 q2, q1, #23
	ldr	r1, [sp, #76]
	lsrl	r8, r9, #25
	umlal	lr, ip, r2, r1
	vsri.32 q2, q1, #9
	ldrd	r1, r6, [sp, #48]
	umlal	lr, ip, r6, r1
	ldr	r2, [sp, #84]
	vstrw.u32 q2, [q7, #-484]
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	vshl.i32 q5, q0, #22
	ldr	r4, [sp, #116]
	ldr	r2, [sp, #36]
	umlal	lr, r1, r5, r4
	vsri.32 q5, q0, #10
	ldr	r4, [sp, #88]
	ldr	r6, [sp, #68]
	umlal	lr, r1, r4, r3
	vstrw.u32 q5, [q7, #-84]
	ldr	r4, [sp, #8]
	umlal	lr, r1, r2, r4
	vldrw.u32 q0, [r11, #-172]
	umlal	lr, r1, r6, r0
	ldr	r2, [sp, #32]
	ldr	r6, [sp, #16]
	vldrw.u32 q1, [r11, #340]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #92]
	veor q0, q0, q3
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #20]
	ldr	r2, [sp, #44]
	veor q1, q1, q4
	umlal	lr, r1, r6, r2
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #100]
	vshl.i32 q2, q0, #1
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #76]
	ldr	r2, [sp, #48]
	vsri.32 q2, q0, #31
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	vstrw.u32 q2, [q7, #-228]
	adc	r1, r1, r9
	str	lr, [sp, #8]
	str	r1, [sp, #12]
	vshl.i32 q5, q1, #1
	ldrd	r8, [sp, #8]
	lsrl	r8, r9, #26
	ldr	r6, [sp, #124]
	vsri.32 q5, q1, #31
	ldr	r2, [sp, #84]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	vstrw.u32 q5, [q7, #172]
	str	r1, [r2, #16]
	ldr	r2, [sp, #36]
	ldr	r6, [sp, #64]
	vldrw.u32 q3, [q7, #380]
	umlal	r10, lr, r5, r2
	ldr	r2, [sp, #32]
	str	r4, [sp, #8]
	vldrw.u32 q4, [q7, #460]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	ldr	r4, [sp, #44]
	vldrw.u32 q0, [r11, #-476]
	ldr	r6, [sp, #16]
	umlal	r10, lr, r0, r4
	vldrw.u32 q1, [r11, #36]
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #20]
	umlal	r10, lr, r6, r4
	veor q0, q0, q3
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #76]
	ldr	r1, [sp, #52]
	veor q1, q1, q4
	umlal	r10, lr, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #56]
	vshl.i32 q2, q0, #31
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr	r6, [sp, #52]
	vsri.32 q2, q0, #1
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r6
	ldr	r2, [sp, #84]
	vstrw.u32 q2, [q7, #-292]
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr	r4, [sp, #112]
	vshl.i32 q5, q1, #31
	ldr	r2, [sp, #4]
	adc	ip, ip, r9
	vsri.32 q5, q1, #1
	umlal	r10, lr, r2, r4
	ldr	r4, [sp, #72]
	ldr	r2, [sp, #48]
	vstrw.u32 q5, [q7, #108]
	str	ip, [sp, #60]
	umlal	r10, lr, r4, r2
	ldrd	r8, [sp, #56]
	vldrw.u32 q0, [r11, #-396]
	str	r10, [sp, #80]
	ldr	r2, [sp, #36]
	lsrl	r8, r9, #25
	vldrw.u32 q1, [r11, #116]
	umull	r4, ip, r2, r7
	ldr	r2, [sp, #88]
	str	r3, [sp, #96]
	veor q0, q0, q3
	umlal	r4, ip, r5, r2
	ldr	r2, [sp, #68]
	ldr	r6, [sp, #16]
	veor q1, q1, q4
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #8]
	vshl.i32 q2, q0, #3
	ldr	r2, [sp, #32]
	strd	r8, [sp, #56]
	umlal	r4, ip, r3, r2
	vsri.32 q2, q0, #29
	ldr	r3, [sp, #92]
	ldr	r2, [sp, #20]
	umlal	r4, ip, r0, r3
	vstrw.u32 q2, [q7, #-436]
	ldr	r3, [sp, #44]
	umlal	r4, ip, r6, r3
	ldr	r6, [sp, #24]
	vshl.i32 q5, q1, #3
	ldr	r3, [sp, #100]
	umlal	r4, ip, r6, r3
	ldr	r3, [sp, #76]
	vsri.32 q5, q1, #29
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #48]
	vstrw.u32 q5, [q7, #-36]
	umlal	r4, ip, r3, r1
	ldr	r3, [sp, #112]
	umlal	r4, ip, r3, r2
	vldrw.u32 q0, [r11, #-316]
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	vldrw.u32 q1, [r11, #196]
	str	r8, [sp, #24]
	adc	r4, ip, r4
	str	r4, [sp, #28]
	veor q0, q0, q3
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	veor q1, q1, q4
	ldr	r3, [sp, #84]
	ldr	r2, [sp, #64]
	bic	r8, r8, #-67108864
	vshl.i32 q2, q1, #22
	str	r8, [r3, #24]
	ldr	r3, [sp, #72]
	umull	ip, r8, r7, r2
	vsri.32 q2, q1, #10
	lsl	r9, r3, #1
	ldr	r3, [sp, #32]
	ldr	r2, [sp, #68]
	vstrw.u32 q2, [r11, #436]
	umlal	ip, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	vshl.i32 q5, q0, #21
	ldrd	r2, r4, [sp, #92]
	ldr	r5, [sp, #44]
	vsri.32 q5, q0, #11
	umlal	r3, r10, r4, r2
	umlal	ip, r8, r4, r5
	ldr	r4, [sp, #8]
	vstrw.u32 q5, [q7, #-180]
	ldr	r2, [sp, #20]
	umlal	r3, r10, r4, r5
	ldr	r5, [sp, #40]
	vldrw.u32 q0, [r11, #-236]
	umlal	ip, r8, r4, r5
	ldr	r5, [sp, #100]
	ldr	r4, [sp, #76]
	vldrw.u32 q1, [r11, #276]
	umlal	r3, r10, r0, r5
	umlal	ip, r8, r0, r4
	ldr	r0, [sp, #16]
	veor q0, q0, q3
	ldr	r5, [sp, #104]
	umlal	r3, r10, r0, r4
	ldr	r4, [sp, #52]
	veor q1, q1, q4
	umlal	r3, r10, r6, r1
	umlal	ip, r8, r0, r4
	vshl.i32 q2, q1, #8
	ldr	r0, [sp, #112]
	ldr	r4, [sp, #72]
	umlal	ip, r8, r6, r0
	vsri.32 q2, q1, #24
	umlal	r3, r10, r2, r0
	umlal	ip, r8, r2, r4
	ldr	r0, [sp, #108]
	vstrw.u32 q2, [q7, #-324]
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #80]
	umlal	r3, r10, r2, r9
	vshl.i32 q5, q0, #7
	umlal	ip, r8, r2, r0
	ldr	r2, [sp, #48]
	umlal	r3, r10, r0, r2
	vsri.32 q5, q0, #25
	umlal	ip, r8, r2, r5
	ldr	r2, [sp, #24]
	ldr	r5, [sp, #28]
	vstrw.u32 q5, [q7, #76]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	vldrw.u32 q0, [r11, #-156]
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	vldrw.u32 q1, [r11, #356]
	ldr	r0, [sp, #84]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	veor q0, q0, q3
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	veor q1, q1, q4
	lsrl	r4, r5, #26
	adds	ip, ip, r4
	mov	r2, ip
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
	bic	r1, ip, #-33554432
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
	ldr	r3, [sp, #132]
	adds	r1, r1, r3
	vldrw.u32 q3, [q7, #396]
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	vldrw.u32 q4, [q7, #476]
	bic	r1, r1, #-67108864
	str	r1, [r0]
	ldr	r1, [sp, #136]
	vldrw.u32 q0, [r11, #-460]
	adds	r3, r1, r2
	ldr	r1, [sp, #120]
	bic	r2, r3, #-33554432
	vldrw.u32 q1, [r11, #52]
	add	r3, r1, r3, lsr #25
	strd	r2, r3, [r0, #4]
	add sp, sp, #144
	pop {r3-r11, pc}
.size fiat_mul_u4_p1, .-fiat_mul_u4_p1

.global fiat_mul_u4_p2
.type fiat_mul_u4_p2, %function
.thumb_func
.balign 16
fiat_mul_u4_p2:
	push {r3-r11, lr}
	sub sp, sp, #144
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
	mov	ip, #38
	veor q0, q0, q3
	mov	lr, r2
	ldr	r3, [r2, #4]
	veor q1, q1, q4
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	vshl.i32 q2, q0, #14
	mul	r6, ip, r2
	str	r0, [sp, #84]
	str	r2, [sp, #40]
	vsri.32 q2, q0, #18
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str	r6, [sp, #120]
	vstrw.u32 q2, [r11, #484]
	str	r2, [sp, #8]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	vshl.i32 q5, q1, #14
	add	r8, r0, r2, lsl #1
	str	r8, [sp, #96]
	ldr	r2, [lr, #28]
	vsri.32 q5, q1, #18
	mul	r8, ip, r6
	str	r6, [sp, #52]
	vstrw.u32 q5, [q7, #-132]
	ldr	r6, [r1, #16]
	str	r7, [sp, #108]
	str	r6, [sp, #16]
	vldrw.u32 q0, [r11, #-380]
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	vldrw.u32 q1, [r11, #132]
	str	r7, [sp, #80]
	ldr	r7, [lr, #24]
	str	r5, [sp, #100]
	veor q0, q0, q3
	mov	r2, r7
	mov	r5, r4
	str	r8, [sp, #116]
	veor q1, q1, q4
	mul	r8, ip, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	vshl.i32 q2, q1, #28
	add	r10, r2, r7, lsl #1
	str	r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	vsri.32 q2, q1, #4
	str	r3, [sp, #64]
	mul	r5, ip, r3
	vstrw.u32 q2, [q7, #-276]
	str	r0, [sp, #76]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	vshl.i32 q5, q0, #27
	str	r2, [sp, #112]
	str	r6, [sp, #72]
	str	r8, [sp, #88]
	vsri.32 q5, q0, #5
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str	r7, [sp, #24]
	vstrw.u32 q5, [q7, #124]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #20]
	vldrw.u32 q0, [r11, #-300]
	ldr	r7, [lr]
	str	r2, [sp, #104]
	ldr	r2, [r1, #4]
	vldrw.u32 q1, [r11, #212]
	str	r7, [sp, #32]
	ldr	r7, [sp, #108]
	str	r2, [sp, #4]
	veor q0, q0, q3
	ldr	r2, [r1]
	ldr	r1, [sp, #40]
	veor q1, q1, q4
	str	ip, [sp, #68]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	vshl.i32 q2, q1, #13
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #80]
	add	lr, r1, lr, lsl #1
	vsri.32 q2, q1, #19
	str	ip, [sp, #36]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #100]
	vstrw.u32 q2, [q7, #-420]
	ldr	r6, [sp, #96]
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	vshl.i32 q5, q0, #12
	str	r3, [sp, #96]
	umlal	lr, ip, r6, r3
	ldr	r3, [sp, #100]
	vsri.32 q5, q0, #20
	ldr	r7, [sp, #20]
	umlal	r4, r1, r3, r5
	vstrw.u32 q5, [q7, #-20]
	mov	r8, r4
	ldr	r3, [sp, #96]
	ldr	r5, [sp, #120]
	vldrw.u32 q0, [r11, #-220]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	vldrw.u32 q1, [r11, #292]
	ldr	r4, [sp, #116]
	ldr	r5, [sp, #16]
	umlal	r8, r1, r4, r0
	veor q0, q0, q3
	umlal	r8, r1, r10, r5
	ldr	r4, [sp, #88]
	str	r6, [sp, #96]
	veor q1, q1, q4
	ldr	r6, [sp, #24]
	umlal	r8, r1, r4, r6
	ldr	r6, [sp, #36]
	vshl.i32 q2, q1, #11
	ldr	r4, [sp, #4]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #68]
	vsri.32 q2, q1, #21
	umlal	r8, r1, r6, r4
	ldr	r6, [sp, #32]
	vstrw.u32 q2, [r11, #452]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #52]
	vshl.i32 q5, q0, #10
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	vsri.32 q5, q0, #22
	umlal	lr, ip, r1, r4
	ldr	r4, [sp, #72]
	umlal	lr, ip, r10, r0
	vstrw.u32 q5, [q7, #-164]
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	str	r8, [sp, #132]
	vldrw.u32 q0, [r11, #-140]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r5
	vldrw.u32 q1, [r11, #372]
	ldr	r6, [sp, #24]
	ldr	r5, [sp, #36]
	str	r0, [sp, #124]
	veor q0, q0, q3
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	veor q1, q1, q4
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr	r5, [sp, #104]
	vshl.i32 q2, q0, #28
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	ldr	r7, [sp, #20]
	vsri.32 q2, q0, #4
	add	r8, r5, r8, lsl #1
	umlal	lr, ip, r8, r7
	ldr	r4, [sp, #32]
	vstrw.u32 q2, [q7, #-308]
	ldr	r5, [sp, #4]
	str	r2, [sp, #48]
	umlal	lr, ip, r5, r4
	vshl.i32 q5, q1, #28
	ldr	r5, [sp, #64]
	ldr	r4, [sp, #56]
	umlal	lr, ip, r5, r2
	vsri.32 q5, q1, #4
	lsls	r2, r5, #1
	ldr	r7, [sp, #80]
	vstrw.u32 q5, [q7, #92]
	str	r2, [sp, #92]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	vldrw.u32 q3, [q7, #412]
	mov	r6, r8
	adc	r9, ip, r2
	mov	r8, r4
	vldrw.u32 q4, [q7, #492]
	ldrd	r2, r5, [sp, #96]
	bic	ip, r4, #-33554432
	umull	r4, r1, r7, r1
	vldrw.u32 q0, [r11, #-444]
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	vldrw.u32 q1, [r11, #68]
	str	r0, [sp, #128]
	ldr	r0, [sp, #8]
	str	ip, [sp, #136]
	veor q0, q0, q3
	umlal	r4, r1, r2, r0
	ldr	r0, [sp, #124]
	ldr	r2, [sp, #36]
	veor q1, q1, q4
	str	r6, [sp, #124]
	umlal	r4, r1, r2, r0
	vshl.i32 q2, q1, #14
	mov	r2, r6
	ldr	r6, [sp, #16]
	lsrl	r8, r9, #25
	vsri.32 q2, q1, #18
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #32]
	vstrw.u32 q2, [q7, #-372]
	umlal	r4, r1, r6, r2
	ldr	r6, [sp, #64]
	ldr	r2, [sp, #20]
	vshl.i32 q5, q0, #13
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #44]
	ldr	r2, [sp, #4]
	vsri.32 q5, q0, #19
	umlal	r4, r1, r2, r6
	mov	ip, r4
	ldr	r2, [sp, #48]
	vstrw.u32 q5, [q7, #28]
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #16]
	umlal	ip, r1, r4, r2
	vldrw.u32 q0, [r11, #-364]
	ldr	r4, [sp, #96]
	str	ip, [sp, #140]
	vldrw.u32 q1, [r11, #148]
	umull	lr, ip, r4, r7
	ldr	r4, [sp, #120]
	ldr	r2, [sp, #88]
	veor q0, q0, q3
	umlal	lr, ip, r5, r4
	ldr	r4, [sp, #116]
	ldr	r7, [sp, #20]
	veor q1, q1, q4
	umlal	lr, ip, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, ip, r10, r4
	vshl.i32 q2, q0, #10
	umlal	lr, ip, r2, r0
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r6
	vsri.32 q2, q0, #22
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #68]
	umlal	lr, ip, r2, r6
	vstrw.u32 q2, [r11, #500]
	ldr	r2, [sp, #32]
	umlal	lr, ip, r7, r2
	vshl.i32 q5, q1, #10
	ldr	r2, [sp, #92]
	ldr	r7, [sp, #4]
	umlal	lr, ip, r7, r2
	vsri.32 q5, q1, #22
	ldrd	r7, r2, [sp, #44]
	umlal	lr, ip, r7, r2
	adds	lr, lr, r8
	vstrw.u32 q5, [q7, #-116]
	adc	r2, ip, r9
	str	lr, [sp, #56]
	str	r2, [sp, #60]
	vldrw.u32 q0, [r11, #-284]
	ldr	r2, [sp, #40]
	ldrd	r8, [sp, #56]
	lsrl	r8, r9, #26
	vldrw.u32 q1, [r11, #228]
	bic	ip, lr, #-67108864
	lsls	r2, r2, #1
	str	ip, [sp, #120]
	veor q0, q0, q3
	str	r2, [sp, #100]
	ldr	r2, [sp, #128]
	ldr	r7, [sp, #80]
	veor q1, q1, q4
	strd	r8, [sp, #56]
	umull	lr, ip, r7, r2
	vshl.i32 q2, q1, #20
	umlal	lr, ip, r5, r10
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r3
	vsri.32 q2, q1, #12
	ldr	r2, [sp, #124]
	umlal	lr, ip, r2, r4
	ldr	r2, [sp, #32]
	vstrw.u32 q2, [q7, #-260]
	ldr	r4, [sp, #16]
	umlal	lr, ip, r0, r2
	ldr	r2, [sp, #64]
	vshl.i32 q5, q0, #19
	umlal	lr, ip, r4, r2
	ldr	r4, [sp, #44]
	ldr	r2, [sp, #4]
	vsri.32 q5, q0, #13
	umlal	lr, ip, r6, r4
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #20]
	vstrw.u32 q5, [q7, #140]
	umlal	lr, ip, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #140]
	vldrw.u32 q0, [r11, #-204]
	adds	r4, r6, r4
	mov	r8, r4
	vldrw.u32 q1, [r11, #308]
	ldr	r6, [sp, #60]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	veor q0, q0, q3
	ldr	r1, [sp, #76]
	lsrl	r8, r9, #25
	umlal	lr, ip, r2, r1
	veor q1, q1, q4
	ldrd	r1, r6, [sp, #48]
	umlal	lr, ip, r6, r1
	ldr	r2, [sp, #84]
	vshl.i32 q2, q0, #4
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	vsri.32 q2, q0, #28
	ldr	r4, [sp, #116]
	ldr	r2, [sp, #36]
	umlal	lr, r1, r5, r4
	vstrw.u32 q2, [q7, #-404]
	ldr	r4, [sp, #88]
	ldr	r6, [sp, #68]
	umlal	lr, r1, r4, r3
	vshl.i32 q5, q1, #4
	ldr	r4, [sp, #8]
	umlal	lr, r1, r2, r4
	vsri.32 q5, q1, #28
	umlal	lr, r1, r6, r0
	ldr	r2, [sp, #32]
	ldr	r6, [sp, #16]
	vstrw.u32 q5, [q7, #-4]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #92]
	vldrw.u32 q0, [r11, #-124]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #20]
	ldr	r2, [sp, #44]
	vldrw.u32 q1, [r11, #388]
	umlal	lr, r1, r6, r2
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #100]
	veor q0, q0, q3
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #76]
	ldr	r2, [sp, #48]
	veor q1, q1, q4
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	vshl.i32 q2, q0, #7
	adc	r1, r1, r9
	str	lr, [sp, #8]
	str	r1, [sp, #12]
	vsri.32 q2, q0, #25
	ldrd	r8, [sp, #8]
	lsrl	r8, r9, #26
	ldr	r6, [sp, #124]
	vstrw.u32 q2, [r11, #468]
	ldr	r2, [sp, #84]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	vshl.i32 q5, q1, #7
	str	r1, [r2, #16]
	ldr	r2, [sp, #36]
	ldr	r6, [sp, #64]
	vsri.32 q5, q1, #25
	umlal	r10, lr, r5, r2
	ldr	r2, [sp, #32]
	str	r4, [sp, #8]
	vstrw.u32 q5, [q7, #-148]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	ldr	r4, [sp, #44]
	vldrw.u32 q0, [r11, #404]
	ldr	r6, [sp, #16]
	umlal	r10, lr, r0, r4
	vldrw.u32 q1, [r11, #420]
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #20]
	umlal	r10, lr, r6, r4
	vldrw.u32 q2, [r11, #436]
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #76]
	ldr	r1, [sp, #52]
	vldrw.u32 q5, [r11, #452]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #56]
	vldrw.u32 q6, [r11, #468]
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr	r6, [sp, #52]
	vbic q3, q2, q1
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r6
	ldr	r2, [sp, #84]
	veor q3, q3, q0
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr	r4, [sp, #112]
	vstrw.u32 q3, [r11, #-508]
	ldr	r2, [sp, #4]
	adc	ip, ip, r9
	vbic q3, q5, q2
	umlal	r10, lr, r2, r4
	ldr	r4, [sp, #72]
	ldr	r2, [sp, #48]
	veor q3, q3, q1
	str	ip, [sp, #60]
	umlal	r10, lr, r4, r2
	ldrd	r8, [sp, #56]
	vstrw.u32 q3, [r11, #-492]
	str	r10, [sp, #80]
	ldr	r2, [sp, #36]
	lsrl	r8, r9, #25
	vbic q3, q6, q5
	umull	r4, ip, r2, r7
	ldr	r2, [sp, #88]
	str	r3, [sp, #96]
	veor q3, q3, q2
	umlal	r4, ip, r5, r2
	ldr	r2, [sp, #68]
	ldr	r6, [sp, #16]
	vstrw.u32 q3, [r11, #-476]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #8]
	vbic q3, q0, q6
	ldr	r2, [sp, #32]
	strd	r8, [sp, #56]
	umlal	r4, ip, r3, r2
	veor q3, q3, q5
	ldr	r3, [sp, #92]
	ldr	r2, [sp, #20]
	umlal	r4, ip, r0, r3
	vstrw.u32 q3, [r11, #-460]
	ldr	r3, [sp, #44]
	umlal	r4, ip, r6, r3
	ldr	r6, [sp, #24]
	vbic q3, q1, q0
	ldr	r3, [sp, #100]
	umlal	r4, ip, r6, r3
	ldr	r3, [sp, #76]
	veor q3, q3, q6
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #48]
	vstrw.u32 q3, [r11, #-444]
	umlal	r4, ip, r3, r1
	ldr	r3, [sp, #112]
	umlal	r4, ip, r3, r2
	vldrw.u32 q0, [r11, #484]
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	vldrw.u32 q1, [r11, #500]
	str	r8, [sp, #24]
	adc	r4, ip, r4
	str	r4, [sp, #28]
	vldrw.u32 q2, [q7, #-500]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	vldrw.u32 q5, [q7, #-484]
	ldr	r3, [sp, #84]
	ldr	r2, [sp, #64]
	bic	r8, r8, #-67108864
	vldrw.u32 q6, [q7, #-468]
	str	r8, [r3, #24]
	ldr	r3, [sp, #72]
	umull	ip, r8, r7, r2
	vbic q3, q2, q1
	lsl	r9, r3, #1
	ldr	r3, [sp, #32]
	ldr	r2, [sp, #68]
	veor q3, q3, q0
	umlal	ip, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	vstrw.u32 q3, [r11, #-428]
	ldrd	r2, r4, [sp, #92]
	ldr	r5, [sp, #44]
	vbic q3, q5, q2
	umlal	r3, r10, r4, r2
	umlal	ip, r8, r4, r5
	ldr	r4, [sp, #8]
	veor q3, q3, q1
	ldr	r2, [sp, #20]
	umlal	r3, r10, r4, r5
	ldr	r5, [sp, #40]
	vstrw.u32 q3, [r11, #-412]
	umlal	ip, r8, r4, r5
	ldr	r5, [sp, #100]
	ldr	r4, [sp, #76]
	vbic q3, q6, q5
	umlal	r3, r10, r0, r5
	umlal	ip, r8, r0, r4
	ldr	r0, [sp, #16]
	veor q3, q3, q2
	ldr	r5, [sp, #104]
	umlal	r3, r10, r0, r4
	ldr	r4, [sp, #52]
	vstrw.u32 q3, [r11, #-396]
	umlal	r3, r10, r6, r1
	umlal	ip, r8, r0, r4
	vbic q3, q0, q6
	ldr	r0, [sp, #112]
	ldr	r4, [sp, #72]
	umlal	ip, r8, r6, r0
	veor q3, q3, q5
	umlal	r3, r10, r2, r0
	umlal	ip, r8, r2, r4
	ldr	r0, [sp, #108]
	vstrw.u32 q3, [r11, #-380]
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #80]
	umlal	r3, r10, r2, r9
	vbic q3, q1, q0
	umlal	ip, r8, r2, r0
	ldr	r2, [sp, #48]
	umlal	r3, r10, r0, r2
	veor q3, q3, q6
	umlal	ip, r8, r2, r5
	ldr	r2, [sp, #24]
	ldr	r5, [sp, #28]
	vstrw.u32 q3, [r11, #-364]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	vldrw.u32 q0, [q7, #-452]
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	vldrw.u32 q1, [q7, #-436]
	ldr	r0, [sp, #84]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	vldrw.u32 q2, [q7, #-420]
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	vldrw.u32 q5, [q7, #-404]
	lsrl	r4, r5, #26
	adds	ip, ip, r4
	mov	r2, ip
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
	bic	r1, ip, #-33554432
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
	ldr	r3, [sp, #132]
	adds	r1, r1, r3
	vstrw.u32 q3, [r11, #-332]
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	vbic q3, q6, q5
	bic	r1, r1, #-67108864
	str	r1, [r0]
	ldr	r1, [sp, #136]
	veor q3, q3, q2
	adds	r3, r1, r2
	ldr	r1, [sp, #120]
	bic	r2, r3, #-33554432
	vstrw.u32 q3, [r11, #-316]
	add	r3, r1, r3, lsr #25
	strd	r2, r3, [r0, #4]
	add sp, sp, #144
	pop {r3-r11, pc}
.size fiat_mul_u4_p2, .-fiat_mul_u4_p2

.global fiat_mul_u4_p3
.type fiat_mul_u4_p3, %function
.thumb_func
.balign 16
fiat_mul_u4_p3:
	push {r3-r11, lr}
	sub sp, sp, #144
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
	mov	ip, #38
	vbic q3, q0, q6
	mov	lr, r2
	ldr	r3, [r2, #4]
	veor q3, q3, q5
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	vstrw.u32 q3, [r11, #-300]
	mul	r6, ip, r2
	str	r0, [sp, #84]
	str	r2, [sp, #40]
	vbic q3, q1, q0
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str	r6, [sp, #120]
	veor q3, q3, q6
	str	r2, [sp, #8]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	vstrw.u32 q3, [r11, #-284]
	add	r8, r0, r2, lsl #1
	str	r8, [sp, #96]
	ldr	r2, [lr, #28]
	vldrw.u32 q0, [q7, #-372]
	mul	r8, ip, r6
	str	r6, [sp, #52]
	vldrw.u32 q1, [q7, #-356]
	ldr	r6, [r1, #16]
	str	r7, [sp, #108]
	str	r6, [sp, #16]
	vldrw.u32 q2, [q7, #-340]
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	vldrw.u32 q5, [q7, #-324]
	str	r7, [sp, #80]
	ldr	r7, [lr, #24]
	str	r5, [sp, #100]
	vldrw.u32 q6, [q7, #-308]
	mov	r2, r7
	mov	r5, r4
	str	r8, [sp, #116]
	vbic q3, q2, q1
	mul	r8, ip, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	veor q3, q3, q0
	add	r10, r2, r7, lsl #1
	str	r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	vstrw.u32 q3, [r11, #-268]
	str	r3, [sp, #64]
	mul	r5, ip, r3
	vbic q3, q5, q2
	str	r0, [sp, #76]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	veor q3, q3, q1
	str	r2, [sp, #112]
	str	r6, [sp, #72]
	str	r8, [sp, #88]
	vstrw.u32 q3, [r11, #-252]
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str	r7, [sp, #24]
	vbic q3, q6, q5
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #20]
	veor q3, q3, q2
	ldr	r7, [lr]
	str	r2, [sp, #104]
	ldr	r2, [r1, #4]
	vstrw.u32 q3, [r11, #-236]
	str	r7, [sp, #32]
	ldr	r7, [sp, #108]
	str	r2, [sp, #4]
	vbic q3, q0, q6
	ldr	r2, [r1]
	ldr	r1, [sp, #40]
	veor q3, q3, q5
	str	ip, [sp, #68]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	vstrw.u32 q3, [r11, #-220]
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #80]
	add	lr, r1, lr, lsl #1
	vbic q3, q1, q0
	str	ip, [sp, #36]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #100]
	veor q3, q3, q6
	ldr	r6, [sp, #96]
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	vstrw.u32 q3, [r11, #-204]
	str	r3, [sp, #96]
	umlal	lr, ip, r6, r3
	ldr	r3, [sp, #100]
	vldrw.u32 q0, [q7, #-292]
	ldr	r7, [sp, #20]
	umlal	r4, r1, r3, r5
	vldrw.u32 q1, [q7, #-276]
	mov	r8, r4
	ldr	r3, [sp, #96]
	ldr	r5, [sp, #120]
	vldrw.u32 q2, [q7, #-260]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	vldrw.u32 q5, [q7, #-244]
	ldr	r4, [sp, #116]
	ldr	r5, [sp, #16]
	umlal	r8, r1, r4, r0
	vldrw.u32 q6, [q7, #-228]
	umlal	r8, r1, r10, r5
	ldr	r4, [sp, #88]
	str	r6, [sp, #96]
	vbic q3, q2, q1
	ldr	r6, [sp, #24]
	umlal	r8, r1, r4, r6
	ldr	r6, [sp, #36]
	veor q3, q3, q0
	ldr	r4, [sp, #4]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #68]
	vstrw.u32 q3, [r11, #-188]
	umlal	r8, r1, r6, r4
	ldr	r6, [sp, #32]
	vbic q3, q5, q2
	ldr	r4, [sp, #8]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #52]
	veor q3, q3, q1
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	vstrw.u32 q3, [r11, #-172]
	umlal	lr, ip, r1, r4
	ldr	r4, [sp, #72]
	umlal	lr, ip, r10, r0
	vbic q3, q6, q5
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	str	r8, [sp, #132]
	veor q3, q3, q2
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r5
	vstrw.u32 q3, [r11, #-156]
	ldr	r6, [sp, #24]
	ldr	r5, [sp, #36]
	str	r0, [sp, #124]
	vbic q3, q0, q6
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	veor q3, q3, q5
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr	r5, [sp, #104]
	vstrw.u32 q3, [r11, #-140]
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	ldr	r7, [sp, #20]
	vbic q3, q1, q0
	add	r8, r5, r8, lsl #1
	umlal	lr, ip, r8, r7
	ldr	r4, [sp, #32]
	veor q3, q3, q6
	ldr	r5, [sp, #4]
	str	r2, [sp, #48]
	umlal	lr, ip, r5, r4
	vstrw.u32 q3, [r11, #-124]
	ldr	r5, [sp, #64]
	ldr	r4, [sp, #56]
	umlal	lr, ip, r5, r2
	vldrw.u32 q0, [q7, #-212]
	lsls	r2, r5, #1
	ldr	r7, [sp, #80]
	vldrw.u32 q1, [q7, #-196]
	str	r2, [sp, #92]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	vldrw.u32 q2, [q7, #-180]
	mov	r6, r8
	adc	r9, ip, r2
	mov	r8, r4
	vldrw.u32 q5, [q7, #-164]
	ldrd	r2, r5, [sp, #96]
	bic	ip, r4, #-33554432
	umull	r4, r1, r7, r1
	vldrw.u32 q6, [q7, #-148]
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	vbic q3, q2, q1
	str	r0, [sp, #128]
	ldr	r0, [sp, #8]
	str	ip, [sp, #136]
	veor q3, q3, q0
	umlal	r4, r1, r2, r0
	ldr	r0, [sp, #124]
	ldr	r2, [sp, #36]
	vstrw.u32 q3, [r11, #4]
	str	r6, [sp, #124]
	umlal	r4, r1, r2, r0
	vbic q3, q5, q2
	mov	r2, r6
	ldr	r6, [sp, #16]
	lsrl	r8, r9, #25
	veor q3, q3, q1
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #32]
	vstrw.u32 q3, [r11, #20]
	umlal	r4, r1, r6, r2
	ldr	r6, [sp, #64]
	ldr	r2, [sp, #20]
	vbic q3, q6, q5
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #44]
	ldr	r2, [sp, #4]
	veor q3, q3, q2
	umlal	r4, r1, r2, r6
	mov	ip, r4
	ldr	r2, [sp, #48]
	vstrw.u32 q3, [r11, #36]
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #16]
	umlal	ip, r1, r4, r2
	vbic q3, q0, q6
	ldr	r4, [sp, #96]
	str	ip, [sp, #140]
	veor q3, q3, q5
	umull	lr, ip, r4, r7
	ldr	r4, [sp, #120]
	ldr	r2, [sp, #88]
	vstrw.u32 q3, [r11, #52]
	umlal	lr, ip, r5, r4
	ldr	r4, [sp, #116]
	ldr	r7, [sp, #20]
	vbic q3, q1, q0
	umlal	lr, ip, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, ip, r10, r4
	veor q3, q3, q6
	umlal	lr, ip, r2, r0
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r6
	vstrw.u32 q3, [r11, #68]
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #68]
	umlal	lr, ip, r2, r6
	vldrw.u32 q0, [q7, #-132]
	ldr	r2, [sp, #32]
	umlal	lr, ip, r7, r2
	vldrw.u32 q1, [q7, #-116]
	ldr	r2, [sp, #92]
	ldr	r7, [sp, #4]
	umlal	lr, ip, r7, r2
	vldrw.u32 q2, [q7, #-100]
	ldrd	r7, r2, [sp, #44]
	umlal	lr, ip, r7, r2
	adds	lr, lr, r8
	vldrw.u32 q5, [q7, #-84]
	adc	r2, ip, r9
	str	lr, [sp, #56]
	str	r2, [sp, #60]
	vldrw.u32 q6, [q7, #-68]
	ldr	r2, [sp, #40]
	ldrd	r8, [sp, #56]
	lsrl	r8, r9, #26
	vbic q3, q2, q1
	bic	ip, lr, #-67108864
	lsls	r2, r2, #1
	str	ip, [sp, #120]
	veor q3, q3, q0
	str	r2, [sp, #100]
	ldr	r2, [sp, #128]
	ldr	r7, [sp, #80]
	vstrw.u32 q3, [r11, #84]
	strd	r8, [sp, #56]
	umull	lr, ip, r7, r2
	vbic q3, q5, q2
	umlal	lr, ip, r5, r10
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r3
	veor q3, q3, q1
	ldr	r2, [sp, #124]
	umlal	lr, ip, r2, r4
	ldr	r2, [sp, #32]
	vstrw.u32 q3, [r11, #100]
	ldr	r4, [sp, #16]
	umlal	lr, ip, r0, r2
	ldr	r2, [sp, #64]
	vbic q3, q6, q5
	umlal	lr, ip, r4, r2
	ldr	r4, [sp, #44]
	ldr	r2, [sp, #4]
	veor q3, q3, q2
	umlal	lr, ip, r6, r4
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #20]
	vstrw.u32 q3, [r11, #116]
	umlal	lr, ip, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #140]
	vbic q3, q0, q6
	adds	r4, r6, r4
	mov	r8, r4
	veor q3, q3, q5
	ldr	r6, [sp, #60]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	vstrw.u32 q3, [r11, #132]
	ldr	r1, [sp, #76]
	lsrl	r8, r9, #25
	umlal	lr, ip, r2, r1
	vbic q3, q1, q0
	ldrd	r1, r6, [sp, #48]
	umlal	lr, ip, r6, r1
	ldr	r2, [sp, #84]
	veor q3, q3, q6
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	vstrw.u32 q3, [r11, #148]
	ldr	r4, [sp, #116]
	ldr	r2, [sp, #36]
	umlal	lr, r1, r5, r4
	vldrw.u32 q0, [q7, #-52]
	ldr	r4, [sp, #88]
	ldr	r6, [sp, #68]
	umlal	lr, r1, r4, r3
	vldrw.u32 q1, [q7, #-36]
	ldr	r4, [sp, #8]
	umlal	lr, r1, r2, r4
	vldrw.u32 q2, [q7, #-20]
	umlal	lr, r1, r6, r0
	ldr	r2, [sp, #32]
	ldr	r6, [sp, #16]
	vldrw.u32 q5, [q7, #-4]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #92]
	vldrw.u32 q6, [q7, #12]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #20]
	ldr	r2, [sp, #44]
	vbic q3, q2, q1
	umlal	lr, r1, r6, r2
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #100]
	veor q3, q3, q0
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #76]
	ldr	r2, [sp, #48]
	vstrw.u32 q3, [r11, #164]
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	vbic q3, q5, q2
	adc	r1, r1, r9
	str	lr, [sp, #8]
	str	r1, [sp, #12]
	veor q3, q3, q1
	ldrd	r8, [sp, #8]
	lsrl	r8, r9, #26
	ldr	r6, [sp, #124]
	vstrw.u32 q3, [r11, #180]
	ldr	r2, [sp, #84]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	vbic q3, q6, q5
	str	r1, [r2, #16]
	ldr	r2, [sp, #36]
	ldr	r6, [sp, #64]
	veor q3, q3, q2
	umlal	r10, lr, r5, r2
	ldr	r2, [sp, #32]
	str	r4, [sp, #8]
	vstrw.u32 q3, [r11, #196]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	ldr	r4, [sp, #44]
	vbic q3, q0, q6
	ldr	r6, [sp, #16]
	umlal	r10, lr, r0, r4
	veor q3, q3, q5
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #20]
	umlal	r10, lr, r6, r4
	vstrw.u32 q3, [r11, #212]
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #76]
	ldr	r1, [sp, #52]
	vbic q3, q1, q0
	umlal	r10, lr, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #56]
	veor q3, q3, q6
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr	r6, [sp, #52]
	vstrw.u32 q3, [r11, #228]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r6
	ldr	r2, [sp, #84]
	vldrw.u32 q0, [q7, #28]
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr	r4, [sp, #112]
	vldrw.u32 q1, [q7, #44]
	ldr	r2, [sp, #4]
	adc	ip, ip, r9
	vldrw.u32 q2, [q7, #60]
	umlal	r10, lr, r2, r4
	ldr	r4, [sp, #72]
	ldr	r2, [sp, #48]
	vldrw.u32 q5, [q7, #76]
	str	ip, [sp, #60]
	umlal	r10, lr, r4, r2
	ldrd	r8, [sp, #56]
	vldrw.u32 q6, [q7, #92]
	str	r10, [sp, #80]
	ldr	r2, [sp, #36]
	lsrl	r8, r9, #25
	vbic q3, q2, q1
	umull	r4, ip, r2, r7
	ldr	r2, [sp, #88]
	str	r3, [sp, #96]
	veor q3, q3, q0
	umlal	r4, ip, r5, r2
	ldr	r2, [sp, #68]
	ldr	r6, [sp, #16]
	vstrw.u32 q3, [r11, #244]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #8]
	vbic q3, q5, q2
	ldr	r2, [sp, #32]
	strd	r8, [sp, #56]
	umlal	r4, ip, r3, r2
	veor q3, q3, q1
	ldr	r3, [sp, #92]
	ldr	r2, [sp, #20]
	umlal	r4, ip, r0, r3
	vstrw.u32 q3, [r11, #260]
	ldr	r3, [sp, #44]
	umlal	r4, ip, r6, r3
	ldr	r6, [sp, #24]
	vbic q3, q6, q5
	ldr	r3, [sp, #100]
	umlal	r4, ip, r6, r3
	ldr	r3, [sp, #76]
	veor q3, q3, q2
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #48]
	vstrw.u32 q3, [r11, #276]
	umlal	r4, ip, r3, r1
	ldr	r3, [sp, #112]
	umlal	r4, ip, r3, r2
	vbic q3, q0, q6
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	veor q3, q3, q5
	str	r8, [sp, #24]
	adc	r4, ip, r4
	str	r4, [sp, #28]
	vstrw.u32 q3, [r11, #292]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	vbic q3, q1, q0
	ldr	r3, [sp, #84]
	ldr	r2, [sp, #64]
	bic	r8, r8, #-67108864
	veor q3, q3, q6
	str	r8, [r3, #24]
	ldr	r3, [sp, #72]
	umull	ip, r8, r7, r2
	vstrw.u32 q3, [r11, #308]
	lsl	r9, r3, #1
	ldr	r3, [sp, #32]
	ldr	r2, [sp, #68]
	vldrw.u32 q0, [q7, #108]
	umlal	ip, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	vldrw.u32 q1, [q7, #124]
	ldrd	r2, r4, [sp, #92]
	ldr	r5, [sp, #44]
	vldrw.u32 q2, [q7, #140]
	umlal	r3, r10, r4, r2
	umlal	ip, r8, r4, r5
	ldr	r4, [sp, #8]
	vldrw.u32 q5, [q7, #156]
	ldr	r2, [sp, #20]
	umlal	r3, r10, r4, r5
	ldr	r5, [sp, #40]
	vldrw.u32 q6, [q7, #172]
	umlal	ip, r8, r4, r5
	ldr	r5, [sp, #100]
	ldr	r4, [sp, #76]
	vbic q3, q2, q1
	umlal	r3, r10, r0, r5
	umlal	ip, r8, r0, r4
	ldr	r0, [sp, #16]
	veor q3, q3, q0
	ldr	r5, [sp, #104]
	umlal	r3, r10, r0, r4
	ldr	r4, [sp, #52]
	vstrw.u32 q3, [r11, #324]
	umlal	r3, r10, r6, r1
	umlal	ip, r8, r0, r4
	vbic q3, q5, q2
	ldr	r0, [sp, #112]
	ldr	r4, [sp, #72]
	umlal	ip, r8, r6, r0
	veor q3, q3, q1
	umlal	r3, r10, r2, r0
	umlal	ip, r8, r2, r4
	ldr	r0, [sp, #108]
	vstrw.u32 q3, [r11, #340]
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #80]
	umlal	r3, r10, r2, r9
	vbic q3, q6, q5
	umlal	ip, r8, r2, r0
	ldr	r2, [sp, #48]
	umlal	r3, r10, r0, r2
	veor q3, q3, q2
	umlal	ip, r8, r2, r5
	ldr	r2, [sp, #24]
	ldr	r5, [sp, #28]
	vstrw.u32 q3, [r11, #356]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	vbic q3, q0, q6
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	veor q3, q3, q5
	ldr	r0, [sp, #84]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	vstrw.u32 q3, [r11, #372]
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	vbic q3, q1, q0
	lsrl	r4, r5, #26
	adds	ip, ip, r4
	mov	r2, ip
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
	bic	r1, ip, #-33554432
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
	ldr	r3, [sp, #132]
	adds	r1, r1, r3
	vldrw.u32 q0, [r11, #-92]
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	vldrw.u32 q1, [r11, #4]
	bic	r1, r1, #-67108864
	str	r1, [r0]
	ldr	r1, [sp, #136]
	veor q1, q1, q0
	adds	r3, r1, r2
	ldr	r1, [sp, #120]
	bic	r2, r3, #-33554432
	vstrw.u32 q1, [r11, #4]
	add	r3, r1, r3, lsr #25
	strd	r2, r3, [r0, #4]
	add sp, sp, #144
	pop {r3-r11, pc}
.size fiat_mul_u4_p3, .-fiat_mul_u4_p3

.global fiat_mul_u8_p0
.type fiat_mul_u8_p0, %function
.thumb_func
.balign 16
fiat_mul_u8_p0:
	push {r3-r11, lr}
	sub sp, sp, #144
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
	mov	ip, #38
	vldrw.u32 q0, [r11, #-508]
	mov	lr, r2
	ldr	r3, [r2, #4]
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	vldrw.u32 q1, [r11, #-428]
	mul	r6, ip, r2
	str	r0, [sp, #84]
	str	r2, [sp, #40]
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str	r6, [sp, #120]
	veor q0, q0, q1
	str	r2, [sp, #8]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	add	r8, r0, r2, lsl #1
	str	r8, [sp, #96]
	ldr	r2, [lr, #28]
	vldrw.u32 q1, [r11, #-348]
	mul	r8, ip, r6
	str	r6, [sp, #52]
	ldr	r6, [r1, #16]
	str	r7, [sp, #108]
	str	r6, [sp, #16]
	ldr	r7, [r1, #32]
	veor q0, q0, q1
	mov	r6, r2
	ldr	r5, [r1, #36]
	str	r7, [sp, #80]
	ldr	r7, [lr, #24]
	str	r5, [sp, #100]
	vldrw.u32 q1, [r11, #-268]
	mov	r2, r7
	mov	r5, r4
	str	r8, [sp, #116]
	mul	r8, ip, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	veor q0, q0, q1
	add	r10, r2, r7, lsl #1
	str	r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #64]
	mul	r5, ip, r3
	str	r0, [sp, #76]
	vldrw.u32 q1, [r11, #-188]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #112]
	str	r6, [sp, #72]
	str	r8, [sp, #88]
	ldr	r7, [r1, #12]
	veor q0, q0, q1
	ldr	r2, [lr, #36]
	str	r7, [sp, #24]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #20]
	vstrw.u32 q0, [q7, #188]
	ldr	r7, [lr]
	str	r2, [sp, #104]
	ldr	r2, [r1, #4]
	str	r7, [sp, #32]
	ldr	r7, [sp, #108]
	str	r2, [sp, #4]
	vldrw.u32 q0, [r11, #-492]
	ldr	r2, [r1]
	ldr	r1, [sp, #40]
	str	ip, [sp, #68]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	add	lr, r1, r1, lsl #3
	vldrw.u32 q1, [r11, #-412]
	ldr	r7, [sp, #80]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #36]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #100]
	ldr	r6, [sp, #96]
	veor q0, q0, q1
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	str	r3, [sp, #96]
	umlal	lr, ip, r6, r3
	ldr	r3, [sp, #100]
	ldr	r7, [sp, #20]
	vldrw.u32 q1, [r11, #-332]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r3, [sp, #96]
	ldr	r5, [sp, #120]
	ldr	r4, [sp, #8]
	veor q0, q0, q1
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	ldr	r4, [sp, #116]
	ldr	r5, [sp, #16]
	umlal	r8, r1, r4, r0
	umlal	r8, r1, r10, r5
	vldrw.u32 q1, [r11, #-252]
	ldr	r4, [sp, #88]
	str	r6, [sp, #96]
	ldr	r6, [sp, #24]
	umlal	r8, r1, r4, r6
	ldr	r6, [sp, #36]
	ldr	r4, [sp, #4]
	veor q0, q0, q1
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #68]
	umlal	r8, r1, r6, r4
	ldr	r6, [sp, #32]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r6, r2
	vldrw.u32 q1, [r11, #-172]
	ldr	r6, [sp, #52]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	umlal	lr, ip, r1, r4
	veor q0, q0, q1
	ldr	r4, [sp, #72]
	umlal	lr, ip, r10, r0
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	str	r8, [sp, #132]
	add	r8, r4, r4, lsl #3
	vstrw.u32 q0, [q7, #204]
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r5
	ldr	r6, [sp, #24]
	ldr	r5, [sp, #36]
	str	r0, [sp, #124]
	umlal	lr, ip, r5, r6
	vldrw.u32 q0, [r11, #-476]
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr	r5, [sp, #104]
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	vldrw.u32 q1, [r11, #-396]
	ldr	r7, [sp, #20]
	add	r8, r5, r8, lsl #1
	umlal	lr, ip, r8, r7
	ldr	r4, [sp, #32]
	ldr	r5, [sp, #4]
	str	r2, [sp, #48]
	veor q0, q0, q1
	umlal	lr, ip, r5, r4
	ldr	r5, [sp, #64]
	ldr	r4, [sp, #56]
	umlal	lr, ip, r5, r2
	lsls	r2, r5, #1
	vldrw.u32 q1, [r11, #-316]
	ldr	r7, [sp, #80]
	str	r2, [sp, #92]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	mov	r6, r8
	adc	r9, ip, r2
	veor q0, q0, q1
	mov	r8, r4
	ldrd	r2, r5, [sp, #96]
	bic	ip, r4, #-33554432
	umull	r4, r1, r7, r1
	umlal	r4, r1, r5, r2
	mov	r2, r0
	vldrw.u32 q1, [r11, #-236]
	umlal	r4, r1, r10, r3
	str	r0, [sp, #128]
	ldr	r0, [sp, #8]
	str	ip, [sp, #136]
	umlal	r4, r1, r2, r0
	ldr	r0, [sp, #124]
	veor q0, q0, q1
	ldr	r2, [sp, #36]
	str	r6, [sp, #124]
	umlal	r4, r1, r2, r0
	mov	r2, r6
	ldr	r6, [sp, #16]
	vldrw.u32 q1, [r11, #-156]
	lsrl	r8, r9, #25
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #32]
	umlal	r4, r1, r6, r2
	ldr	r6, [sp, #64]
	veor q0, q0, q1
	ldr	r2, [sp, #20]
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #44]
	ldr	r2, [sp, #4]
	umlal	r4, r1, r2, r6
	mov	ip, r4
	vstrw.u32 q0, [q7, #220]
	ldr	r2, [sp, #48]
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #16]
	umlal	ip, r1, r4, r2
	ldr	r4, [sp, #96]
	str	ip, [sp, #140]
	vldrw.u32 q0, [r11, #-460]
	umull	lr, ip, r4, r7
	ldr	r4, [sp, #120]
	ldr	r2, [sp, #88]
	umlal	lr, ip, r5, r4
	ldr	r4, [sp, #116]
	ldr	r7, [sp, #20]
	vldrw.u32 q1, [r11, #-380]
	umlal	lr, ip, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, ip, r10, r4
	umlal	lr, ip, r2, r0
	ldr	r2, [sp, #36]
	veor q0, q0, q1
	umlal	lr, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #68]
	umlal	lr, ip, r2, r6
	ldr	r2, [sp, #32]
	umlal	lr, ip, r7, r2
	vldrw.u32 q1, [r11, #-300]
	ldr	r2, [sp, #92]
	ldr	r7, [sp, #4]
	umlal	lr, ip, r7, r2
	ldrd	r7, r2, [sp, #44]
	umlal	lr, ip, r7, r2
	adds	lr, lr, r8
	veor q0, q0, q1
	adc	r2, ip, r9
	str	lr, [sp, #56]
	str	r2, [sp, #60]
	ldr	r2, [sp, #40]
	ldrd	r8, [sp, #56]
	lsrl	r8, r9, #26
	vldrw.u32 q1, [r11, #-220]
	bic	ip, lr, #-67108864
	lsls	r2, r2, #1
	str	ip, [sp, #120]
	str	r2, [sp, #100]
	ldr	r2, [sp, #128]
	veor q0, q0, q1
	ldr	r7, [sp, #80]
	strd	r8, [sp, #56]
	umull	lr, ip, r7, r2
	umlal	lr, ip, r5, r10
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r3
	vldrw.u32 q1, [r11, #-140]
	ldr	r2, [sp, #124]
	umlal	lr, ip, r2, r4
	ldr	r2, [sp, #32]
	ldr	r4, [sp, #16]
	umlal	lr, ip, r0, r2
	ldr	r2, [sp, #64]
	veor q0, q0, q1
	umlal	lr, ip, r4, r2
	ldr	r4, [sp, #44]
	ldr	r2, [sp, #4]
	umlal	lr, ip, r6, r4
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #20]
	vstrw.u32 q0, [q7, #236]
	umlal	lr, ip, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #140]
	adds	r4, r6, r4
	mov	r8, r4
	ldr	r6, [sp, #60]
	vldrw.u32 q0, [r11, #-444]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	ldr	r1, [sp, #76]
	lsrl	r8, r9, #25
	umlal	lr, ip, r2, r1
	vldrw.u32 q1, [r11, #-364]
	ldrd	r1, r6, [sp, #48]
	umlal	lr, ip, r6, r1
	ldr	r2, [sp, #84]
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	veor q0, q0, q1
	ldr	r4, [sp, #116]
	ldr	r2, [sp, #36]
	umlal	lr, r1, r5, r4
	ldr	r4, [sp, #88]
	ldr	r6, [sp, #68]
	umlal	lr, r1, r4, r3
	vldrw.u32 q1, [r11, #-284]
	ldr	r4, [sp, #8]
	umlal	lr, r1, r2, r4
	umlal	lr, r1, r6, r0
	ldr	r2, [sp, #32]
	ldr	r6, [sp, #16]
	umlal	lr, r1, r6, r2
	veor q0, q0, q1
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #92]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #20]
	ldr	r2, [sp, #44]
	vldrw.u32 q1, [r11, #-204]
	umlal	lr, r1, r6, r2
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #100]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #76]
	ldr	r2, [sp, #48]
	veor q0, q0, q1
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	adc	r1, r1, r9
	str	lr, [sp, #8]
	str	r1, [sp, #12]
	ldrd	r8, [sp, #8]
	vldrw.u32 q1, [r11, #-124]
	lsrl	r8, r9, #26
	ldr	r6, [sp, #124]
	ldr	r2, [sp, #84]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	str	r1, [r2, #16]
	veor q0, q0, q1
	ldr	r2, [sp, #36]
	ldr	r6, [sp, #64]
	umlal	r10, lr, r5, r2
	ldr	r2, [sp, #32]
	str	r4, [sp, #8]
	umlal	r10, lr, r3, r2
	vstrw.u32 q0, [q7, #252]
	umlal	r10, lr, r4, r6
	ldr	r4, [sp, #44]
	ldr	r6, [sp, #16]
	umlal	r10, lr, r0, r4
	ldr	r4, [sp, #40]
	vldrw.u32 q0, [r11, #4]
	ldr	r2, [sp, #20]
	umlal	r10, lr, r6, r4
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #76]
	ldr	r1, [sp, #52]
	umlal	r10, lr, r6, r4
	vldrw.u32 q1, [r11, #84]
	mov	r4, r8
	ldr	r6, [sp, #56]
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr	r6, [sp, #52]
	str	r4, [sp, #56]
	veor q0, q0, q1
	umlal	r10, lr, r2, r6
	ldr	r2, [sp, #84]
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr	r4, [sp, #112]
	ldr	r2, [sp, #4]
	vldrw.u32 q1, [r11, #164]
	adc	ip, ip, r9
	umlal	r10, lr, r2, r4
	ldr	r4, [sp, #72]
	ldr	r2, [sp, #48]
	str	ip, [sp, #60]
	veor q0, q0, q1
	umlal	r10, lr, r4, r2
	ldrd	r8, [sp, #56]
	str	r10, [sp, #80]
	ldr	r2, [sp, #36]
	lsrl	r8, r9, #25
	umull	r4, ip, r2, r7
	vldrw.u32 q1, [r11, #244]
	ldr	r2, [sp, #88]
	str	r3, [sp, #96]
	umlal	r4, ip, r5, r2
	ldr	r2, [sp, #68]
	ldr	r6, [sp, #16]
	umlal	r4, ip, r2, r3
	veor q0, q0, q1
	ldr	r3, [sp, #8]
	ldr	r2, [sp, #32]
	strd	r8, [sp, #56]
	umlal	r4, ip, r3, r2
	ldr	r3, [sp, #92]
	ldr	r2, [sp, #20]
	vldrw.u32 q1, [r11, #324]
	umlal	r4, ip, r0, r3
	ldr	r3, [sp, #44]
	umlal	r4, ip, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #100]
	umlal	r4, ip, r6, r3
	veor q0, q0, q1
	ldr	r3, [sp, #76]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #48]
	umlal	r4, ip, r3, r1
	vstrw.u32 q0, [q7, #268]
	ldr	r3, [sp, #112]
	umlal	r4, ip, r3, r2
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, ip, r4
	vldrw.u32 q0, [r11, #20]
	str	r4, [sp, #28]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #84]
	ldr	r2, [sp, #64]
	vldrw.u32 q1, [r11, #100]
	bic	r8, r8, #-67108864
	str	r8, [r3, #24]
	ldr	r3, [sp, #72]
	umull	ip, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #32]
	veor q0, q0, q1
	ldr	r2, [sp, #68]
	umlal	ip, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	ldrd	r2, r4, [sp, #92]
	vldrw.u32 q1, [r11, #180]
	ldr	r5, [sp, #44]
	umlal	r3, r10, r4, r2
	umlal	ip, r8, r4, r5
	ldr	r4, [sp, #8]
	ldr	r2, [sp, #20]
	umlal	r3, r10, r4, r5
	veor q0, q0, q1
	ldr	r5, [sp, #40]
	umlal	ip, r8, r4, r5
	ldr	r5, [sp, #100]
	ldr	r4, [sp, #76]
	umlal	r3, r10, r0, r5
	umlal	ip, r8, r0, r4
	vldrw.u32 q1, [r11, #260]
	ldr	r0, [sp, #16]
	ldr	r5, [sp, #104]
	umlal	r3, r10, r0, r4
	ldr	r4, [sp, #52]
	umlal	r3, r10, r6, r1
	umlal	ip, r8, r0, r4
	veor q0, q0, q1
	ldr	r0, [sp, #112]
	ldr	r4, [sp, #72]
	umlal	ip, r8, r6, r0
	umlal	r3, r10, r2, r0
	umlal	ip, r8, r2, r4
	ldr	r0, [sp, #108]
	vldrw.u32 q1, [r11, #340]
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #80]
	umlal	r3, r10, r2, r9
	umlal	ip, r8, r2, r0
	ldr	r2, [sp, #48]
	veor q0, q0, q1
	umlal	r3, r10, r0, r2
	umlal	ip, r8, r2, r5
	ldr	r2, [sp, #24]
	ldr	r5, [sp, #28]
	adds	r4, r6, r2
	mov	r2, r4
	vstrw.u32 q0, [q7, #284]
	mov	r1, r3
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	ldr	r0, [sp, #84]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	vldrw.u32 q0, [r11, #36]
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	lsrl	r4, r5, #26
	adds	ip, ip, r4
	mov	r2, ip
	vldrw.u32 q1, [r11, #116]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r4, r2
	mov	r5, r3
	lsll	r4, r5, #3
	veor q0, q0, q1
	bic	r1, r1, #-67108864
	str	r1, [r0, #32]
	bic	r1, ip, #-33554432
	str	r1, [r0, #36]
	adds	r1, r4, r2
	adc	r4, r5, r3
	vldrw.u32 q1, [r11, #196]
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	adc	r4, r4, r3
	ldr	r3, [sp, #132]
	adds	r1, r1, r3
	veor q0, q0, q1
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	bic	r1, r1, #-67108864
	str	r1, [r0]
	ldr	r1, [sp, #136]
	vldrw.u32 q1, [r11, #276]
	adds	r3, r1, r2
	ldr	r1, [sp, #120]
	bic	r2, r3, #-33554432
	add	r3, r1, r3, lsr #25
	strd	r2, r3, [r0, #4]
	add sp, sp, #144
	pop {r3-r11, pc}
.size fiat_mul_u8_p0, .-fiat_mul_u8_p0

.global fiat_mul_u8_p1
.type fiat_mul_u8_p1, %function
.thumb_func
.balign 16
fiat_mul_u8_p1:
	push {r3-r11, lr}
	sub sp, sp, #144
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
	mov	ip, #38
	veor q0, q0, q1
	mov	lr, r2
	ldr	r3, [r2, #4]
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	vldrw.u32 q1, [r11, #356]
	mul	r6, ip, r2
	str	r0, [sp, #84]
	str	r2, [sp, #40]
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str	r6, [sp, #120]
	veor q0, q0, q1
	str	r2, [sp, #8]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	add	r8, r0, r2, lsl #1
	str	r8, [sp, #96]
	ldr	r2, [lr, #28]
	vstrw.u32 q0, [q7, #300]
	mul	r8, ip, r6
	str	r6, [sp, #52]
	ldr	r6, [r1, #16]
	str	r7, [sp, #108]
	str	r6, [sp, #16]
	vldrw.u32 q0, [r11, #52]
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	str	r7, [sp, #80]
	ldr	r7, [lr, #24]
	str	r5, [sp, #100]
	vldrw.u32 q1, [r11, #132]
	mov	r2, r7
	mov	r5, r4
	str	r8, [sp, #116]
	mul	r8, ip, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	veor q0, q0, q1
	add	r10, r2, r7, lsl #1
	str	r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #64]
	mul	r5, ip, r3
	vldrw.u32 q1, [r11, #212]
	str	r0, [sp, #76]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #112]
	str	r6, [sp, #72]
	str	r8, [sp, #88]
	veor q0, q0, q1
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str	r7, [sp, #24]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #20]
	vldrw.u32 q1, [r11, #292]
	ldr	r7, [lr]
	str	r2, [sp, #104]
	ldr	r2, [r1, #4]
	str	r7, [sp, #32]
	ldr	r7, [sp, #108]
	str	r2, [sp, #4]
	veor q0, q0, q1
	ldr	r2, [r1]
	ldr	r1, [sp, #40]
	str	ip, [sp, #68]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	vldrw.u32 q1, [r11, #372]
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #80]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #36]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #100]
	veor q0, q0, q1
	ldr	r6, [sp, #96]
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	str	r3, [sp, #96]
	umlal	lr, ip, r6, r3
	ldr	r3, [sp, #100]
	vstrw.u32 q0, [q7, #316]
	ldr	r7, [sp, #20]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r3, [sp, #96]
	ldr	r5, [sp, #120]
	vldrw.u32 q0, [r11, #68]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	ldr	r4, [sp, #116]
	ldr	r5, [sp, #16]
	umlal	r8, r1, r4, r0
	vldrw.u32 q1, [r11, #148]
	umlal	r8, r1, r10, r5
	ldr	r4, [sp, #88]
	str	r6, [sp, #96]
	ldr	r6, [sp, #24]
	umlal	r8, r1, r4, r6
	ldr	r6, [sp, #36]
	veor q0, q0, q1
	ldr	r4, [sp, #4]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #68]
	umlal	r8, r1, r6, r4
	ldr	r6, [sp, #32]
	vldrw.u32 q1, [r11, #228]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #52]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	veor q0, q0, q1
	umlal	lr, ip, r1, r4
	ldr	r4, [sp, #72]
	umlal	lr, ip, r10, r0
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	str	r8, [sp, #132]
	vldrw.u32 q1, [r11, #308]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r5
	ldr	r6, [sp, #24]
	ldr	r5, [sp, #36]
	str	r0, [sp, #124]
	veor q0, q0, q1
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr	r5, [sp, #104]
	vldrw.u32 q1, [r11, #388]
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	ldr	r7, [sp, #20]
	add	r8, r5, r8, lsl #1
	umlal	lr, ip, r8, r7
	ldr	r4, [sp, #32]
	veor q0, q0, q1
	ldr	r5, [sp, #4]
	str	r2, [sp, #48]
	umlal	lr, ip, r5, r4
	ldr	r5, [sp, #64]
	ldr	r4, [sp, #56]
	umlal	lr, ip, r5, r2
	vstrw.u32 q0, [q7, #332]
	lsls	r2, r5, #1
	ldr	r7, [sp, #80]
	str	r2, [sp, #92]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	vldrw.u32 q0, [q7, #284]
	mov	r6, r8
	adc	r9, ip, r2
	mov	r8, r4
	ldrd	r2, r5, [sp, #96]
	bic	ip, r4, #-33554432
	umull	r4, r1, r7, r1
	vshl.i32 q1, q0, #1
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	str	r0, [sp, #128]
	ldr	r0, [sp, #8]
	str	ip, [sp, #136]
	vsri.32 q1, q0, #31
	umlal	r4, r1, r2, r0
	ldr	r0, [sp, #124]
	ldr	r2, [sp, #36]
	str	r6, [sp, #124]
	umlal	r4, r1, r2, r0
	vldrw.u32 q2, [q7, #252]
	mov	r2, r6
	ldr	r6, [sp, #16]
	lsrl	r8, r9, #25
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #32]
	veor q1, q1, q2
	umlal	r4, r1, r6, r2
	ldr	r6, [sp, #64]
	ldr	r2, [sp, #20]
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #44]
	ldr	r2, [sp, #4]
	vstrw.u32 q1, [q7, #348]
	umlal	r4, r1, r2, r6
	mov	ip, r4
	ldr	r2, [sp, #48]
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #16]
	umlal	ip, r1, r4, r2
	vldrw.u32 q0, [q7, #204]
	ldr	r4, [sp, #96]
	str	ip, [sp, #140]
	umull	lr, ip, r4, r7
	ldr	r4, [sp, #120]
	ldr	r2, [sp, #88]
	vldrw.u32 q2, [q7, #332]
	umlal	lr, ip, r5, r4
	ldr	r4, [sp, #116]
	ldr	r7, [sp, #20]
	umlal	lr, ip, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, ip, r10, r4
	veor q0, q0, q2
	umlal	lr, ip, r2, r0
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #68]
	umlal	lr, ip, r2, r6
	vstrw.u32 q0, [q7, #428]
	ldr	r2, [sp, #32]
	umlal	lr, ip, r7, r2
	ldr	r2, [sp, #92]
	ldr	r7, [sp, #4]
	umlal	lr, ip, r7, r2
	vldrw.u32 q0, [q7, #300]
	ldrd	r7, r2, [sp, #44]
	umlal	lr, ip, r7, r2
	adds	lr, lr, r8
	adc	r2, ip, r9
	str	lr, [sp, #56]
	str	r2, [sp, #60]
	vshl.i32 q1, q0, #1
	ldr	r2, [sp, #40]
	ldrd	r8, [sp, #56]
	lsrl	r8, r9, #26
	bic	ip, lr, #-67108864
	lsls	r2, r2, #1
	str	ip, [sp, #120]
	vsri.32 q1, q0, #31
	str	r2, [sp, #100]
	ldr	r2, [sp, #128]
	ldr	r7, [sp, #80]
	strd	r8, [sp, #56]
	umull	lr, ip, r7, r2
	vldrw.u32 q2, [q7, #188]
	umlal	lr, ip, r5, r10
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r3
	ldr	r2, [sp, #124]
	umlal	lr, ip, r2, r4
	ldr	r2, [sp, #32]
	veor q1, q1, q2
	ldr	r4, [sp, #16]
	umlal	lr, ip, r0, r2
	ldr	r2, [sp, #64]
	umlal	lr, ip, r4, r2
	ldr	r4, [sp, #44]
	ldr	r2, [sp, #4]
	vstrw.u32 q1, [q7, #364]
	umlal	lr, ip, r6, r4
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #20]
	umlal	lr, ip, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #140]
	vldrw.u32 q0, [q7, #220]
	adds	r4, r6, r4
	mov	r8, r4
	ldr	r6, [sp, #60]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	vldrw.u32 q2, [q7, #268]
	ldr	r1, [sp, #76]
	lsrl	r8, r9, #25
	umlal	lr, ip, r2, r1
	ldrd	r1, r6, [sp, #48]
	umlal	lr, ip, r6, r1
	ldr	r2, [sp, #84]
	veor q0, q0, q2
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	ldr	r4, [sp, #116]
	ldr	r2, [sp, #36]
	umlal	lr, r1, r5, r4
	vstrw.u32 q0, [q7, #444]
	ldr	r4, [sp, #88]
	ldr	r6, [sp, #68]
	umlal	lr, r1, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, r1, r2, r4
	vldrw.u32 q0, [q7, #316]
	umlal	lr, r1, r6, r0
	ldr	r2, [sp, #32]
	ldr	r6, [sp, #16]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #92]
	vshl.i32 q1, q0, #1
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #20]
	ldr	r2, [sp, #44]
	umlal	lr, r1, r6, r2
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #100]
	vsri.32 q1, q0, #31
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #76]
	ldr	r2, [sp, #48]
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	vldrw.u32 q2, [q7, #204]
	adc	r1, r1, r9
	str	lr, [sp, #8]
	str	r1, [sp, #12]
	ldrd	r8, [sp, #8]
	lsrl	r8, r9, #26
	ldr	r6, [sp, #124]
	veor q1, q1, q2
	ldr	r2, [sp, #84]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	str	r1, [r2, #16]
	ldr	r2, [sp, #36]
	ldr	r6, [sp, #64]
	vstrw.u32 q1, [q7, #380]
	umlal	r10, lr, r5, r2
	ldr	r2, [sp, #32]
	str	r4, [sp, #8]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	ldr	r4, [sp, #44]
	vldrw.u32 q0, [q7, #236]
	ldr	r6, [sp, #16]
	umlal	r10, lr, r0, r4
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #20]
	umlal	r10, lr, r6, r4
	vldrw.u32 q2, [q7, #284]
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #76]
	ldr	r1, [sp, #52]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #56]
	veor q0, q0, q2
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr	r6, [sp, #52]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r6
	ldr	r2, [sp, #84]
	vstrw.u32 q0, [q7, #460]
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr	r4, [sp, #112]
	ldr	r2, [sp, #4]
	adc	ip, ip, r9
	vldrw.u32 q0, [q7, #332]
	umlal	r10, lr, r2, r4
	ldr	r4, [sp, #72]
	ldr	r2, [sp, #48]
	str	ip, [sp, #60]
	umlal	r10, lr, r4, r2
	ldrd	r8, [sp, #56]
	vshl.i32 q1, q0, #1
	str	r10, [sp, #80]
	ldr	r2, [sp, #36]
	lsrl	r8, r9, #25
	umull	r4, ip, r2, r7
	ldr	r2, [sp, #88]
	str	r3, [sp, #96]
	vsri.32 q1, q0, #31
	umlal	r4, ip, r5, r2
	ldr	r2, [sp, #68]
	ldr	r6, [sp, #16]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #8]
	vldrw.u32 q2, [q7, #220]
	ldr	r2, [sp, #32]
	strd	r8, [sp, #56]
	umlal	r4, ip, r3, r2
	ldr	r3, [sp, #92]
	ldr	r2, [sp, #20]
	umlal	r4, ip, r0, r3
	veor q1, q1, q2
	ldr	r3, [sp, #44]
	umlal	r4, ip, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #100]
	umlal	r4, ip, r6, r3
	ldr	r3, [sp, #76]
	vstrw.u32 q1, [q7, #396]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #48]
	umlal	r4, ip, r3, r1
	ldr	r3, [sp, #112]
	umlal	r4, ip, r3, r2
	vldrw.u32 q0, [q7, #252]
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, ip, r4
	str	r4, [sp, #28]
	vldrw.u32 q2, [q7, #300]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #84]
	ldr	r2, [sp, #64]
	bic	r8, r8, #-67108864
	veor q0, q0, q2
	str	r8, [r3, #24]
	ldr	r3, [sp, #72]
	umull	ip, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #32]
	ldr	r2, [sp, #68]
	vstrw.u32 q0, [q7, #476]
	umlal	ip, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	ldrd	r2, r4, [sp, #92]
	ldr	r5, [sp, #44]
	vldrw.u32 q0, [q7, #268]
	umlal	r3, r10, r4, r2
	umlal	ip, r8, r4, r5
	ldr	r4, [sp, #8]
	ldr	r2, [sp, #20]
	umlal	r3, r10, r4, r5
	ldr	r5, [sp, #40]
	vshl.i32 q1, q0, #1
	umlal	ip, r8, r4, r5
	ldr	r5, [sp, #100]
	ldr	r4, [sp, #76]
	umlal	r3, r10, r0, r5
	umlal	ip, r8, r0, r4
	ldr	r0, [sp, #16]
	vsri.32 q1, q0, #31
	ldr	r5, [sp, #104]
	umlal	r3, r10, r0, r4
	ldr	r4, [sp, #52]
	umlal	r3, r10, r6, r1
	umlal	ip, r8, r0, r4
	vldrw.u32 q2, [q7, #236]
	ldr	r0, [sp, #112]
	ldr	r4, [sp, #72]
	umlal	ip, r8, r6, r0
	umlal	r3, r10, r2, r0
	umlal	ip, r8, r2, r4
	ldr	r0, [sp, #108]
	veor q1, q1, q2
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #80]
	umlal	r3, r10, r2, r9
	umlal	ip, r8, r2, r0
	ldr	r2, [sp, #48]
	umlal	r3, r10, r0, r2
	vstrw.u32 q1, [q7, #412]
	umlal	ip, r8, r2, r5
	ldr	r2, [sp, #24]
	ldr	r5, [sp, #28]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	vldrw.u32 q0, [q7, #188]
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	ldr	r0, [sp, #84]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	vldrw.u32 q2, [q7, #316]
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	lsrl	r4, r5, #26
	adds	ip, ip, r4
	mov	r2, ip
	veor q0, q0, q2
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r4, r2
	mov	r5, r3
	lsll	r4, r5, #3
	bic	r1, r1, #-67108864
	vstrw.u32 q0, [q7, #492]
	str	r1, [r0, #32]
	bic	r1, ip, #-33554432
	str	r1, [r0, #36]
	adds	r1, r4, r2
	adc	r4, r5, r3
	vldrw.u32 q3, [q7, #348]
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	adc	r4, r4, r3
	ldr	r3, [sp, #132]
	adds	r1, r1, r3
	vldrw.u32 q4, [q7, #428]
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	bic	r1, r1, #-67108864
	str	r1, [r0]
	ldr	r1, [sp, #136]
	vldrw.u32 q0, [r11, #-508]
	adds	r3, r1, r2
	ldr	r1, [sp, #120]
	bic	r2, r3, #-33554432
	add	r3, r1, r3, lsr #25
	strd	r2, r3, [r0, #4]
	add sp, sp, #144
	pop {r3-r11, pc}
.size fiat_mul_u8_p1, .-fiat_mul_u8_p1

.global fiat_mul_u8_p2
.type fiat_mul_u8_p2, %function
.thumb_func
.balign 16
fiat_mul_u8_p2:
	push {r3-r11, lr}
	sub sp, sp, #144
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
	mov	ip, #38
	vldrw.u32 q1, [r11, #4]
	mov	lr, r2
	ldr	r3, [r2, #4]
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	veor q0, q0, q3
	mul	r6, ip, r2
	str	r0, [sp, #84]
	str	r2, [sp, #40]
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str	r6, [sp, #120]
	veor q1, q1, q4
	str	r2, [sp, #8]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	add	r8, r0, r2, lsl #1
	str	r8, [sp, #96]
	ldr	r2, [lr, #28]
	vorr q2, q0, q0
	mul	r8, ip, r6
	str	r6, [sp, #52]
	ldr	r6, [r1, #16]
	str	r7, [sp, #108]
	str	r6, [sp, #16]
	vstrw.u32 q2, [r11, #404]
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	str	r7, [sp, #80]
	ldr	r7, [lr, #24]
	str	r5, [sp, #100]
	vorr q5, q1, q1
	mov	r2, r7
	mov	r5, r4
	str	r8, [sp, #116]
	mul	r8, ip, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	vstrw.u32 q5, [q7, #-212]
	add	r10, r2, r7, lsl #1
	str	r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #64]
	mul	r5, ip, r3
	vldrw.u32 q0, [r11, #-428]
	str	r0, [sp, #76]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #112]
	str	r6, [sp, #72]
	str	r8, [sp, #88]
	vldrw.u32 q1, [r11, #84]
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str	r7, [sp, #24]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #20]
	veor q0, q0, q3
	ldr	r7, [lr]
	str	r2, [sp, #104]
	ldr	r2, [r1, #4]
	str	r7, [sp, #32]
	ldr	r7, [sp, #108]
	str	r2, [sp, #4]
	veor q1, q1, q4
	ldr	r2, [r1]
	ldr	r1, [sp, #40]
	str	ip, [sp, #68]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	vshl.i32 q2, q0, #18
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #80]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #36]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #100]
	vsri.32 q2, q0, #14
	ldr	r6, [sp, #96]
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	str	r3, [sp, #96]
	umlal	lr, ip, r6, r3
	ldr	r3, [sp, #100]
	vstrw.u32 q2, [q7, #-356]
	ldr	r7, [sp, #20]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r3, [sp, #96]
	ldr	r5, [sp, #120]
	vshl.i32 q5, q1, #18
	ldr	r4, [sp, #8]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	ldr	r4, [sp, #116]
	ldr	r5, [sp, #16]
	umlal	r8, r1, r4, r0
	vsri.32 q5, q1, #14
	umlal	r8, r1, r10, r5
	ldr	r4, [sp, #88]
	str	r6, [sp, #96]
	ldr	r6, [sp, #24]
	umlal	r8, r1, r4, r6
	ldr	r6, [sp, #36]
	vstrw.u32 q5, [q7, #44]
	ldr	r4, [sp, #4]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #68]
	umlal	r8, r1, r6, r4
	ldr	r6, [sp, #32]
	vldrw.u32 q0, [r11, #-348]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #52]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	vldrw.u32 q1, [r11, #164]
	umlal	lr, ip, r1, r4
	ldr	r4, [sp, #72]
	umlal	lr, ip, r10, r0
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	str	r8, [sp, #132]
	veor q0, q0, q3
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r5
	ldr	r6, [sp, #24]
	ldr	r5, [sp, #36]
	str	r0, [sp, #124]
	veor q1, q1, q4
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr	r5, [sp, #104]
	vshl.i32 q2, q1, #2
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	ldr	r7, [sp, #20]
	add	r8, r5, r8, lsl #1
	umlal	lr, ip, r8, r7
	ldr	r4, [sp, #32]
	vsri.32 q2, q1, #30
	ldr	r5, [sp, #4]
	str	r2, [sp, #48]
	umlal	lr, ip, r5, r4
	ldr	r5, [sp, #64]
	ldr	r4, [sp, #56]
	umlal	lr, ip, r5, r2
	vstrw.u32 q2, [q7, #-500]
	lsls	r2, r5, #1
	ldr	r7, [sp, #80]
	str	r2, [sp, #92]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	vshl.i32 q5, q0, #1
	mov	r6, r8
	adc	r9, ip, r2
	mov	r8, r4
	ldrd	r2, r5, [sp, #96]
	bic	ip, r4, #-33554432
	umull	r4, r1, r7, r1
	vsri.32 q5, q0, #31
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	str	r0, [sp, #128]
	ldr	r0, [sp, #8]
	str	ip, [sp, #136]
	vstrw.u32 q5, [q7, #-100]
	umlal	r4, r1, r2, r0
	ldr	r0, [sp, #124]
	ldr	r2, [sp, #36]
	str	r6, [sp, #124]
	umlal	r4, r1, r2, r0
	vldrw.u32 q0, [r11, #-268]
	mov	r2, r6
	ldr	r6, [sp, #16]
	lsrl	r8, r9, #25
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #32]
	vldrw.u32 q1, [r11, #244]
	umlal	r4, r1, r6, r2
	ldr	r6, [sp, #64]
	ldr	r2, [sp, #20]
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #44]
	ldr	r2, [sp, #4]
	veor q0, q0, q3
	umlal	r4, r1, r2, r6
	mov	ip, r4
	ldr	r2, [sp, #48]
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #16]
	umlal	ip, r1, r4, r2
	veor q1, q1, q4
	ldr	r4, [sp, #96]
	str	ip, [sp, #140]
	umull	lr, ip, r4, r7
	ldr	r4, [sp, #120]
	ldr	r2, [sp, #88]
	vshl.i32 q2, q1, #21
	umlal	lr, ip, r5, r4
	ldr	r4, [sp, #116]
	ldr	r7, [sp, #20]
	umlal	lr, ip, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, ip, r10, r4
	vsri.32 q2, q1, #11
	umlal	lr, ip, r2, r0
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #68]
	umlal	lr, ip, r2, r6
	vstrw.u32 q2, [q7, #-244]
	ldr	r2, [sp, #32]
	umlal	lr, ip, r7, r2
	ldr	r2, [sp, #92]
	ldr	r7, [sp, #4]
	umlal	lr, ip, r7, r2
	vshl.i32 q5, q0, #20
	ldrd	r7, r2, [sp, #44]
	umlal	lr, ip, r7, r2
	adds	lr, lr, r8
	adc	r2, ip, r9
	str	lr, [sp, #56]
	str	r2, [sp, #60]
	vsri.32 q5, q0, #12
	ldr	r2, [sp, #40]
	ldrd	r8, [sp, #56]
	lsrl	r8, r9, #26
	bic	ip, lr, #-67108864
	lsls	r2, r2, #1
	str	ip, [sp, #120]
	vstrw.u32 q5, [q7, #156]
	str	r2, [sp, #100]
	ldr	r2, [sp, #128]
	ldr	r7, [sp, #80]
	strd	r8, [sp, #56]
	umull	lr, ip, r7, r2
	vldrw.u32 q0, [r11, #-188]
	umlal	lr, ip, r5, r10
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r3
	ldr	r2, [sp, #124]
	umlal	lr, ip, r2, r4
	ldr	r2, [sp, #32]
	vldrw.u32 q1, [r11, #324]
	ldr	r4, [sp, #16]
	umlal	lr, ip, r0, r2
	ldr	r2, [sp, #64]
	umlal	lr, ip, r4, r2
	ldr	r4, [sp, #44]
	ldr	r2, [sp, #4]
	veor q0, q0, q3
	umlal	lr, ip, r6, r4
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #20]
	umlal	lr, ip, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #140]
	veor q1, q1, q4
	adds	r4, r6, r4
	mov	r8, r4
	ldr	r6, [sp, #60]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	vshl.i32 q2, q0, #9
	ldr	r1, [sp, #76]
	lsrl	r8, r9, #25
	umlal	lr, ip, r2, r1
	ldrd	r1, r6, [sp, #48]
	umlal	lr, ip, r6, r1
	ldr	r2, [sp, #84]
	vsri.32 q2, q0, #23
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	ldr	r4, [sp, #116]
	ldr	r2, [sp, #36]
	umlal	lr, r1, r5, r4
	vstrw.u32 q2, [q7, #-388]
	ldr	r4, [sp, #88]
	ldr	r6, [sp, #68]
	umlal	lr, r1, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, r1, r2, r4
	vshl.i32 q5, q1, #9
	umlal	lr, r1, r6, r0
	ldr	r2, [sp, #32]
	ldr	r6, [sp, #16]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #92]
	vsri.32 q5, q1, #23
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #20]
	ldr	r2, [sp, #44]
	umlal	lr, r1, r6, r2
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #100]
	vstrw.u32 q5, [q7, #12]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #76]
	ldr	r2, [sp, #48]
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	vldrw.u32 q3, [q7, #364]
	adc	r1, r1, r9
	str	lr, [sp, #8]
	str	r1, [sp, #12]
	ldrd	r8, [sp, #8]
	lsrl	r8, r9, #26
	ldr	r6, [sp, #124]
	vldrw.u32 q4, [q7, #444]
	ldr	r2, [sp, #84]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	str	r1, [r2, #16]
	ldr	r2, [sp, #36]
	ldr	r6, [sp, #64]
	vldrw.u32 q0, [r11, #-492]
	umlal	r10, lr, r5, r2
	ldr	r2, [sp, #32]
	str	r4, [sp, #8]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	ldr	r4, [sp, #44]
	vldrw.u32 q1, [r11, #20]
	ldr	r6, [sp, #16]
	umlal	r10, lr, r0, r4
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #20]
	umlal	r10, lr, r6, r4
	veor q0, q0, q3
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #76]
	ldr	r1, [sp, #52]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #56]
	veor q1, q1, q4
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr	r6, [sp, #52]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r6
	ldr	r2, [sp, #84]
	vshl.i32 q2, q1, #1
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr	r4, [sp, #112]
	ldr	r2, [sp, #4]
	adc	ip, ip, r9
	vsri.32 q2, q1, #31
	umlal	r10, lr, r2, r4
	ldr	r4, [sp, #72]
	ldr	r2, [sp, #48]
	str	ip, [sp, #60]
	umlal	r10, lr, r4, r2
	ldrd	r8, [sp, #56]
	vstrw.u32 q2, [q7, #-452]
	str	r10, [sp, #80]
	ldr	r2, [sp, #36]
	lsrl	r8, r9, #25
	umull	r4, ip, r2, r7
	ldr	r2, [sp, #88]
	str	r3, [sp, #96]
	vorr q5, q0, q0
	umlal	r4, ip, r5, r2
	ldr	r2, [sp, #68]
	ldr	r6, [sp, #16]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #8]
	vstrw.u32 q5, [q7, #-52]
	ldr	r2, [sp, #32]
	strd	r8, [sp, #56]
	umlal	r4, ip, r3, r2
	ldr	r3, [sp, #92]
	ldr	r2, [sp, #20]
	umlal	r4, ip, r0, r3
	vldrw.u32 q0, [r11, #-412]
	ldr	r3, [sp, #44]
	umlal	r4, ip, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #100]
	umlal	r4, ip, r6, r3
	ldr	r3, [sp, #76]
	vldrw.u32 q1, [r11, #100]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #48]
	umlal	r4, ip, r3, r1
	ldr	r3, [sp, #112]
	umlal	r4, ip, r3, r2
	veor q0, q0, q3
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, ip, r4
	str	r4, [sp, #28]
	veor q1, q1, q4
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #84]
	ldr	r2, [sp, #64]
	bic	r8, r8, #-67108864
	vshl.i32 q2, q0, #22
	str	r8, [r3, #24]
	ldr	r3, [sp, #72]
	umull	ip, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #32]
	ldr	r2, [sp, #68]
	vsri.32 q2, q0, #10
	umlal	ip, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	ldrd	r2, r4, [sp, #92]
	ldr	r5, [sp, #44]
	vstrw.u32 q2, [r11, #420]
	umlal	r3, r10, r4, r2
	umlal	ip, r8, r4, r5
	ldr	r4, [sp, #8]
	ldr	r2, [sp, #20]
	umlal	r3, r10, r4, r5
	ldr	r5, [sp, #40]
	vshl.i32 q5, q1, #22
	umlal	ip, r8, r4, r5
	ldr	r5, [sp, #100]
	ldr	r4, [sp, #76]
	umlal	r3, r10, r0, r5
	umlal	ip, r8, r0, r4
	ldr	r0, [sp, #16]
	vsri.32 q5, q1, #10
	ldr	r5, [sp, #104]
	umlal	r3, r10, r0, r4
	ldr	r4, [sp, #52]
	umlal	r3, r10, r6, r1
	umlal	ip, r8, r0, r4
	vstrw.u32 q5, [q7, #-196]
	ldr	r0, [sp, #112]
	ldr	r4, [sp, #72]
	umlal	ip, r8, r6, r0
	umlal	r3, r10, r2, r0
	umlal	ip, r8, r2, r4
	ldr	r0, [sp, #108]
	vldrw.u32 q0, [r11, #-332]
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #80]
	umlal	r3, r10, r2, r9
	umlal	ip, r8, r2, r0
	ldr	r2, [sp, #48]
	umlal	r3, r10, r0, r2
	vldrw.u32 q1, [r11, #180]
	umlal	ip, r8, r2, r5
	ldr	r2, [sp, #24]
	ldr	r5, [sp, #28]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	veor q0, q0, q3
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	ldr	r0, [sp, #84]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	veor q1, q1, q4
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	lsrl	r4, r5, #26
	adds	ip, ip, r4
	mov	r2, ip
	vshl.i32 q2, q0, #5
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r4, r2
	mov	r5, r3
	lsll	r4, r5, #3
	bic	r1, r1, #-67108864
	vsri.32 q2, q0, #27
	str	r1, [r0, #32]
	bic	r1, ip, #-33554432
	str	r1, [r0, #36]
	adds	r1, r4, r2
	adc	r4, r5, r3
	vstrw.u32 q2, [q7, #-340]
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	adc	r4, r4, r3
	ldr	r3, [sp, #132]
	adds	r1, r1, r3
	vshl.i32 q5, q1, #5
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	bic	r1, r1, #-67108864
	str	r1, [r0]
	ldr	r1, [sp, #136]
	vsri.32 q5, q1, #27
	adds	r3, r1, r2
	ldr	r1, [sp, #120]
	bic	r2, r3, #-33554432
	add	r3, r1, r3, lsr #25
	strd	r2, r3, [r0, #4]
	add sp, sp, #144
	pop {r3-r11, pc}
.size fiat_mul_u8_p2, .-fiat_mul_u8_p2

.global fiat_mul_u8_p3
.type fiat_mul_u8_p3, %function
.thumb_func
.balign 16
fiat_mul_u8_p3:
	push {r3-r11, lr}
	sub sp, sp, #144
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
	mov	ip, #38
	vstrw.u32 q5, [q7, #60]
	mov	lr, r2
	ldr	r3, [r2, #4]
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	vldrw.u32 q0, [r11, #-252]
	mul	r6, ip, r2
	str	r0, [sp, #84]
	str	r2, [sp, #40]
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str	r6, [sp, #120]
	vldrw.u32 q1, [r11, #260]
	str	r2, [sp, #8]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	add	r8, r0, r2, lsl #1
	str	r8, [sp, #96]
	ldr	r2, [lr, #28]
	veor q0, q0, q3
	mul	r8, ip, r6
	str	r6, [sp, #52]
	ldr	r6, [r1, #16]
	str	r7, [sp, #108]
	str	r6, [sp, #16]
	veor q1, q1, q4
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	str	r7, [sp, #80]
	ldr	r7, [lr, #24]
	str	r5, [sp, #100]
	vshl.i32 q2, q1, #23
	mov	r2, r7
	mov	r5, r4
	str	r8, [sp, #116]
	mul	r8, ip, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	vsri.32 q2, q1, #9
	add	r10, r2, r7, lsl #1
	str	r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #64]
	mul	r5, ip, r3
	vstrw.u32 q2, [q7, #-484]
	str	r0, [sp, #76]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #112]
	str	r6, [sp, #72]
	str	r8, [sp, #88]
	vshl.i32 q5, q0, #22
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str	r7, [sp, #24]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #20]
	vsri.32 q5, q0, #10
	ldr	r7, [lr]
	str	r2, [sp, #104]
	ldr	r2, [r1, #4]
	str	r7, [sp, #32]
	ldr	r7, [sp, #108]
	str	r2, [sp, #4]
	vstrw.u32 q5, [q7, #-84]
	ldr	r2, [r1]
	ldr	r1, [sp, #40]
	str	ip, [sp, #68]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	vldrw.u32 q0, [r11, #-172]
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #80]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #36]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #100]
	vldrw.u32 q1, [r11, #340]
	ldr	r6, [sp, #96]
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	str	r3, [sp, #96]
	umlal	lr, ip, r6, r3
	ldr	r3, [sp, #100]
	veor q0, q0, q3
	ldr	r7, [sp, #20]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r3, [sp, #96]
	ldr	r5, [sp, #120]
	veor q1, q1, q4
	ldr	r4, [sp, #8]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	ldr	r4, [sp, #116]
	ldr	r5, [sp, #16]
	umlal	r8, r1, r4, r0
	vshl.i32 q2, q0, #1
	umlal	r8, r1, r10, r5
	ldr	r4, [sp, #88]
	str	r6, [sp, #96]
	ldr	r6, [sp, #24]
	umlal	r8, r1, r4, r6
	ldr	r6, [sp, #36]
	vsri.32 q2, q0, #31
	ldr	r4, [sp, #4]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #68]
	umlal	r8, r1, r6, r4
	ldr	r6, [sp, #32]
	vstrw.u32 q2, [q7, #-228]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #52]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	vshl.i32 q5, q1, #1
	umlal	lr, ip, r1, r4
	ldr	r4, [sp, #72]
	umlal	lr, ip, r10, r0
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	str	r8, [sp, #132]
	vsri.32 q5, q1, #31
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r5
	ldr	r6, [sp, #24]
	ldr	r5, [sp, #36]
	str	r0, [sp, #124]
	vstrw.u32 q5, [q7, #172]
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr	r5, [sp, #104]
	vldrw.u32 q3, [q7, #380]
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	ldr	r7, [sp, #20]
	add	r8, r5, r8, lsl #1
	umlal	lr, ip, r8, r7
	ldr	r4, [sp, #32]
	vldrw.u32 q4, [q7, #460]
	ldr	r5, [sp, #4]
	str	r2, [sp, #48]
	umlal	lr, ip, r5, r4
	ldr	r5, [sp, #64]
	ldr	r4, [sp, #56]
	umlal	lr, ip, r5, r2
	vldrw.u32 q0, [r11, #-476]
	lsls	r2, r5, #1
	ldr	r7, [sp, #80]
	str	r2, [sp, #92]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	vldrw.u32 q1, [r11, #36]
	mov	r6, r8
	adc	r9, ip, r2
	mov	r8, r4
	ldrd	r2, r5, [sp, #96]
	bic	ip, r4, #-33554432
	umull	r4, r1, r7, r1
	veor q0, q0, q3
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	str	r0, [sp, #128]
	ldr	r0, [sp, #8]
	str	ip, [sp, #136]
	veor q1, q1, q4
	umlal	r4, r1, r2, r0
	ldr	r0, [sp, #124]
	ldr	r2, [sp, #36]
	str	r6, [sp, #124]
	umlal	r4, r1, r2, r0
	vshl.i32 q2, q0, #31
	mov	r2, r6
	ldr	r6, [sp, #16]
	lsrl	r8, r9, #25
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #32]
	vsri.32 q2, q0, #1
	umlal	r4, r1, r6, r2
	ldr	r6, [sp, #64]
	ldr	r2, [sp, #20]
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #44]
	ldr	r2, [sp, #4]
	vstrw.u32 q2, [q7, #-292]
	umlal	r4, r1, r2, r6
	mov	ip, r4
	ldr	r2, [sp, #48]
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #16]
	umlal	ip, r1, r4, r2
	vshl.i32 q5, q1, #31
	ldr	r4, [sp, #96]
	str	ip, [sp, #140]
	umull	lr, ip, r4, r7
	ldr	r4, [sp, #120]
	ldr	r2, [sp, #88]
	vsri.32 q5, q1, #1
	umlal	lr, ip, r5, r4
	ldr	r4, [sp, #116]
	ldr	r7, [sp, #20]
	umlal	lr, ip, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, ip, r10, r4
	vstrw.u32 q5, [q7, #108]
	umlal	lr, ip, r2, r0
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #68]
	umlal	lr, ip, r2, r6
	vldrw.u32 q0, [r11, #-396]
	ldr	r2, [sp, #32]
	umlal	lr, ip, r7, r2
	ldr	r2, [sp, #92]
	ldr	r7, [sp, #4]
	umlal	lr, ip, r7, r2
	vldrw.u32 q1, [r11, #116]
	ldrd	r7, r2, [sp, #44]
	umlal	lr, ip, r7, r2
	adds	lr, lr, r8
	adc	r2, ip, r9
	str	lr, [sp, #56]
	str	r2, [sp, #60]
	veor q0, q0, q3
	ldr	r2, [sp, #40]
	ldrd	r8, [sp, #56]
	lsrl	r8, r9, #26
	bic	ip, lr, #-67108864
	lsls	r2, r2, #1
	str	ip, [sp, #120]
	veor q1, q1, q4
	str	r2, [sp, #100]
	ldr	r2, [sp, #128]
	ldr	r7, [sp, #80]
	strd	r8, [sp, #56]
	umull	lr, ip, r7, r2
	vshl.i32 q2, q0, #3
	umlal	lr, ip, r5, r10
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r3
	ldr	r2, [sp, #124]
	umlal	lr, ip, r2, r4
	ldr	r2, [sp, #32]
	vsri.32 q2, q0, #29
	ldr	r4, [sp, #16]
	umlal	lr, ip, r0, r2
	ldr	r2, [sp, #64]
	umlal	lr, ip, r4, r2
	ldr	r4, [sp, #44]
	ldr	r2, [sp, #4]
	vstrw.u32 q2, [q7, #-436]
	umlal	lr, ip, r6, r4
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #20]
	umlal	lr, ip, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #140]
	vshl.i32 q5, q1, #3
	adds	r4, r6, r4
	mov	r8, r4
	ldr	r6, [sp, #60]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	vsri.32 q5, q1, #29
	ldr	r1, [sp, #76]
	lsrl	r8, r9, #25
	umlal	lr, ip, r2, r1
	ldrd	r1, r6, [sp, #48]
	umlal	lr, ip, r6, r1
	ldr	r2, [sp, #84]
	vstrw.u32 q5, [q7, #-36]
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	ldr	r4, [sp, #116]
	ldr	r2, [sp, #36]
	umlal	lr, r1, r5, r4
	vldrw.u32 q0, [r11, #-316]
	ldr	r4, [sp, #88]
	ldr	r6, [sp, #68]
	umlal	lr, r1, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, r1, r2, r4
	vldrw.u32 q1, [r11, #196]
	umlal	lr, r1, r6, r0
	ldr	r2, [sp, #32]
	ldr	r6, [sp, #16]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #92]
	veor q0, q0, q3
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #20]
	ldr	r2, [sp, #44]
	umlal	lr, r1, r6, r2
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #100]
	veor q1, q1, q4
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #76]
	ldr	r2, [sp, #48]
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	vshl.i32 q2, q1, #22
	adc	r1, r1, r9
	str	lr, [sp, #8]
	str	r1, [sp, #12]
	ldrd	r8, [sp, #8]
	lsrl	r8, r9, #26
	ldr	r6, [sp, #124]
	vsri.32 q2, q1, #10
	ldr	r2, [sp, #84]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	str	r1, [r2, #16]
	ldr	r2, [sp, #36]
	ldr	r6, [sp, #64]
	vstrw.u32 q2, [r11, #436]
	umlal	r10, lr, r5, r2
	ldr	r2, [sp, #32]
	str	r4, [sp, #8]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	ldr	r4, [sp, #44]
	vshl.i32 q5, q0, #21
	ldr	r6, [sp, #16]
	umlal	r10, lr, r0, r4
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #20]
	umlal	r10, lr, r6, r4
	vsri.32 q5, q0, #11
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #76]
	ldr	r1, [sp, #52]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #56]
	vstrw.u32 q5, [q7, #-180]
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr	r6, [sp, #52]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r6
	ldr	r2, [sp, #84]
	vldrw.u32 q0, [r11, #-236]
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr	r4, [sp, #112]
	ldr	r2, [sp, #4]
	adc	ip, ip, r9
	vldrw.u32 q1, [r11, #276]
	umlal	r10, lr, r2, r4
	ldr	r4, [sp, #72]
	ldr	r2, [sp, #48]
	str	ip, [sp, #60]
	umlal	r10, lr, r4, r2
	ldrd	r8, [sp, #56]
	veor q0, q0, q3
	str	r10, [sp, #80]
	ldr	r2, [sp, #36]
	lsrl	r8, r9, #25
	umull	r4, ip, r2, r7
	ldr	r2, [sp, #88]
	str	r3, [sp, #96]
	veor q1, q1, q4
	umlal	r4, ip, r5, r2
	ldr	r2, [sp, #68]
	ldr	r6, [sp, #16]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #8]
	vshl.i32 q2, q1, #8
	ldr	r2, [sp, #32]
	strd	r8, [sp, #56]
	umlal	r4, ip, r3, r2
	ldr	r3, [sp, #92]
	ldr	r2, [sp, #20]
	umlal	r4, ip, r0, r3
	vsri.32 q2, q1, #24
	ldr	r3, [sp, #44]
	umlal	r4, ip, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #100]
	umlal	r4, ip, r6, r3
	ldr	r3, [sp, #76]
	vstrw.u32 q2, [q7, #-324]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #48]
	umlal	r4, ip, r3, r1
	ldr	r3, [sp, #112]
	umlal	r4, ip, r3, r2
	vshl.i32 q5, q0, #7
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, ip, r4
	str	r4, [sp, #28]
	vsri.32 q5, q0, #25
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #84]
	ldr	r2, [sp, #64]
	bic	r8, r8, #-67108864
	vstrw.u32 q5, [q7, #76]
	str	r8, [r3, #24]
	ldr	r3, [sp, #72]
	umull	ip, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #32]
	ldr	r2, [sp, #68]
	vldrw.u32 q0, [r11, #-156]
	umlal	ip, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	ldrd	r2, r4, [sp, #92]
	ldr	r5, [sp, #44]
	vldrw.u32 q1, [r11, #356]
	umlal	r3, r10, r4, r2
	umlal	ip, r8, r4, r5
	ldr	r4, [sp, #8]
	ldr	r2, [sp, #20]
	umlal	r3, r10, r4, r5
	ldr	r5, [sp, #40]
	veor q0, q0, q3
	umlal	ip, r8, r4, r5
	ldr	r5, [sp, #100]
	ldr	r4, [sp, #76]
	umlal	r3, r10, r0, r5
	umlal	ip, r8, r0, r4
	ldr	r0, [sp, #16]
	veor q1, q1, q4
	ldr	r5, [sp, #104]
	umlal	r3, r10, r0, r4
	ldr	r4, [sp, #52]
	umlal	r3, r10, r6, r1
	umlal	ip, r8, r0, r4
	vshl.i32 q2, q1, #31
	ldr	r0, [sp, #112]
	ldr	r4, [sp, #72]
	umlal	ip, r8, r6, r0
	umlal	r3, r10, r2, r0
	umlal	ip, r8, r2, r4
	ldr	r0, [sp, #108]
	vsri.32 q2, q1, #1
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #80]
	umlal	r3, r10, r2, r9
	umlal	ip, r8, r2, r0
	ldr	r2, [sp, #48]
	umlal	r3, r10, r0, r2
	vstrw.u32 q2, [q7, #-468]
	umlal	ip, r8, r2, r5
	ldr	r2, [sp, #24]
	ldr	r5, [sp, #28]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	vshl.i32 q5, q0, #30
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	ldr	r0, [sp, #84]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	vsri.32 q5, q0, #2
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	lsrl	r4, r5, #26
	adds	ip, ip, r4
	mov	r2, ip
	vstrw.u32 q5, [q7, #-68]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r4, r2
	mov	r5, r3
	lsll	r4, r5, #3
	bic	r1, r1, #-67108864
	vldrw.u32 q3, [q7, #396]
	str	r1, [r0, #32]
	bic	r1, ip, #-33554432
	str	r1, [r0, #36]
	adds	r1, r4, r2
	adc	r4, r5, r3
	vldrw.u32 q4, [q7, #476]
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	adc	r4, r4, r3
	ldr	r3, [sp, #132]
	adds	r1, r1, r3
	vldrw.u32 q0, [r11, #-460]
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	bic	r1, r1, #-67108864
	str	r1, [r0]
	ldr	r1, [sp, #136]
	vldrw.u32 q1, [r11, #52]
	adds	r3, r1, r2
	ldr	r1, [sp, #120]
	bic	r2, r3, #-33554432
	add	r3, r1, r3, lsr #25
	strd	r2, r3, [r0, #4]
	add sp, sp, #144
	pop {r3-r11, pc}
.size fiat_mul_u8_p3, .-fiat_mul_u8_p3

.global fiat_mul_u8_p4
.type fiat_mul_u8_p4, %function
.thumb_func
.balign 16
fiat_mul_u8_p4:
	push {r3-r11, lr}
	sub sp, sp, #144
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
	mov	ip, #38
	veor q0, q0, q3
	mov	lr, r2
	ldr	r3, [r2, #4]
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	veor q1, q1, q4
	mul	r6, ip, r2
	str	r0, [sp, #84]
	str	r2, [sp, #40]
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str	r6, [sp, #120]
	vshl.i32 q2, q0, #14
	str	r2, [sp, #8]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	add	r8, r0, r2, lsl #1
	str	r8, [sp, #96]
	ldr	r2, [lr, #28]
	vsri.32 q2, q0, #18
	mul	r8, ip, r6
	str	r6, [sp, #52]
	ldr	r6, [r1, #16]
	str	r7, [sp, #108]
	str	r6, [sp, #16]
	vstrw.u32 q2, [r11, #484]
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	str	r7, [sp, #80]
	ldr	r7, [lr, #24]
	str	r5, [sp, #100]
	vshl.i32 q5, q1, #14
	mov	r2, r7
	mov	r5, r4
	str	r8, [sp, #116]
	mul	r8, ip, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	vsri.32 q5, q1, #18
	add	r10, r2, r7, lsl #1
	str	r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #64]
	mul	r5, ip, r3
	vstrw.u32 q5, [q7, #-132]
	str	r0, [sp, #76]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #112]
	str	r6, [sp, #72]
	str	r8, [sp, #88]
	vldrw.u32 q0, [r11, #-380]
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str	r7, [sp, #24]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #20]
	vldrw.u32 q1, [r11, #132]
	ldr	r7, [lr]
	str	r2, [sp, #104]
	ldr	r2, [r1, #4]
	str	r7, [sp, #32]
	ldr	r7, [sp, #108]
	str	r2, [sp, #4]
	veor q0, q0, q3
	ldr	r2, [r1]
	ldr	r1, [sp, #40]
	str	ip, [sp, #68]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	veor q1, q1, q4
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #80]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #36]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #100]
	vshl.i32 q2, q1, #28
	ldr	r6, [sp, #96]
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	str	r3, [sp, #96]
	umlal	lr, ip, r6, r3
	ldr	r3, [sp, #100]
	vsri.32 q2, q1, #4
	ldr	r7, [sp, #20]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r3, [sp, #96]
	ldr	r5, [sp, #120]
	vstrw.u32 q2, [q7, #-276]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	ldr	r4, [sp, #116]
	ldr	r5, [sp, #16]
	umlal	r8, r1, r4, r0
	vshl.i32 q5, q0, #27
	umlal	r8, r1, r10, r5
	ldr	r4, [sp, #88]
	str	r6, [sp, #96]
	ldr	r6, [sp, #24]
	umlal	r8, r1, r4, r6
	ldr	r6, [sp, #36]
	vsri.32 q5, q0, #5
	ldr	r4, [sp, #4]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #68]
	umlal	r8, r1, r6, r4
	ldr	r6, [sp, #32]
	vstrw.u32 q5, [q7, #124]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #52]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	vldrw.u32 q0, [r11, #-300]
	umlal	lr, ip, r1, r4
	ldr	r4, [sp, #72]
	umlal	lr, ip, r10, r0
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	str	r8, [sp, #132]
	vldrw.u32 q1, [r11, #212]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r5
	ldr	r6, [sp, #24]
	ldr	r5, [sp, #36]
	str	r0, [sp, #124]
	veor q0, q0, q3
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr	r5, [sp, #104]
	veor q1, q1, q4
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	ldr	r7, [sp, #20]
	add	r8, r5, r8, lsl #1
	umlal	lr, ip, r8, r7
	ldr	r4, [sp, #32]
	vshl.i32 q2, q1, #13
	ldr	r5, [sp, #4]
	str	r2, [sp, #48]
	umlal	lr, ip, r5, r4
	ldr	r5, [sp, #64]
	ldr	r4, [sp, #56]
	umlal	lr, ip, r5, r2
	vsri.32 q2, q1, #19
	lsls	r2, r5, #1
	ldr	r7, [sp, #80]
	str	r2, [sp, #92]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	vstrw.u32 q2, [q7, #-420]
	mov	r6, r8
	adc	r9, ip, r2
	mov	r8, r4
	ldrd	r2, r5, [sp, #96]
	bic	ip, r4, #-33554432
	umull	r4, r1, r7, r1
	vshl.i32 q5, q0, #12
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	str	r0, [sp, #128]
	ldr	r0, [sp, #8]
	str	ip, [sp, #136]
	vsri.32 q5, q0, #20
	umlal	r4, r1, r2, r0
	ldr	r0, [sp, #124]
	ldr	r2, [sp, #36]
	str	r6, [sp, #124]
	umlal	r4, r1, r2, r0
	vstrw.u32 q5, [q7, #-20]
	mov	r2, r6
	ldr	r6, [sp, #16]
	lsrl	r8, r9, #25
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #32]
	vldrw.u32 q0, [r11, #-220]
	umlal	r4, r1, r6, r2
	ldr	r6, [sp, #64]
	ldr	r2, [sp, #20]
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #44]
	ldr	r2, [sp, #4]
	vldrw.u32 q1, [r11, #292]
	umlal	r4, r1, r2, r6
	mov	ip, r4
	ldr	r2, [sp, #48]
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #16]
	umlal	ip, r1, r4, r2
	veor q0, q0, q3
	ldr	r4, [sp, #96]
	str	ip, [sp, #140]
	umull	lr, ip, r4, r7
	ldr	r4, [sp, #120]
	ldr	r2, [sp, #88]
	veor q1, q1, q4
	umlal	lr, ip, r5, r4
	ldr	r4, [sp, #116]
	ldr	r7, [sp, #20]
	umlal	lr, ip, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, ip, r10, r4
	vshl.i32 q2, q1, #11
	umlal	lr, ip, r2, r0
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #68]
	umlal	lr, ip, r2, r6
	vsri.32 q2, q1, #21
	ldr	r2, [sp, #32]
	umlal	lr, ip, r7, r2
	ldr	r2, [sp, #92]
	ldr	r7, [sp, #4]
	umlal	lr, ip, r7, r2
	vstrw.u32 q2, [r11, #452]
	ldrd	r7, r2, [sp, #44]
	umlal	lr, ip, r7, r2
	adds	lr, lr, r8
	adc	r2, ip, r9
	str	lr, [sp, #56]
	str	r2, [sp, #60]
	vshl.i32 q5, q0, #10
	ldr	r2, [sp, #40]
	ldrd	r8, [sp, #56]
	lsrl	r8, r9, #26
	bic	ip, lr, #-67108864
	lsls	r2, r2, #1
	str	ip, [sp, #120]
	vsri.32 q5, q0, #22
	str	r2, [sp, #100]
	ldr	r2, [sp, #128]
	ldr	r7, [sp, #80]
	strd	r8, [sp, #56]
	umull	lr, ip, r7, r2
	vstrw.u32 q5, [q7, #-164]
	umlal	lr, ip, r5, r10
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r3
	ldr	r2, [sp, #124]
	umlal	lr, ip, r2, r4
	ldr	r2, [sp, #32]
	vldrw.u32 q0, [r11, #-140]
	ldr	r4, [sp, #16]
	umlal	lr, ip, r0, r2
	ldr	r2, [sp, #64]
	umlal	lr, ip, r4, r2
	ldr	r4, [sp, #44]
	ldr	r2, [sp, #4]
	vldrw.u32 q1, [r11, #372]
	umlal	lr, ip, r6, r4
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #20]
	umlal	lr, ip, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #140]
	veor q0, q0, q3
	adds	r4, r6, r4
	mov	r8, r4
	ldr	r6, [sp, #60]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	veor q1, q1, q4
	ldr	r1, [sp, #76]
	lsrl	r8, r9, #25
	umlal	lr, ip, r2, r1
	ldrd	r1, r6, [sp, #48]
	umlal	lr, ip, r6, r1
	ldr	r2, [sp, #84]
	vshl.i32 q2, q0, #28
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	ldr	r4, [sp, #116]
	ldr	r2, [sp, #36]
	umlal	lr, r1, r5, r4
	vsri.32 q2, q0, #4
	ldr	r4, [sp, #88]
	ldr	r6, [sp, #68]
	umlal	lr, r1, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, r1, r2, r4
	vstrw.u32 q2, [q7, #-308]
	umlal	lr, r1, r6, r0
	ldr	r2, [sp, #32]
	ldr	r6, [sp, #16]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #92]
	vshl.i32 q5, q1, #28
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #20]
	ldr	r2, [sp, #44]
	umlal	lr, r1, r6, r2
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #100]
	vsri.32 q5, q1, #4
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #76]
	ldr	r2, [sp, #48]
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	vstrw.u32 q5, [q7, #92]
	adc	r1, r1, r9
	str	lr, [sp, #8]
	str	r1, [sp, #12]
	ldrd	r8, [sp, #8]
	lsrl	r8, r9, #26
	ldr	r6, [sp, #124]
	vldrw.u32 q3, [q7, #412]
	ldr	r2, [sp, #84]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	str	r1, [r2, #16]
	ldr	r2, [sp, #36]
	ldr	r6, [sp, #64]
	vldrw.u32 q4, [q7, #492]
	umlal	r10, lr, r5, r2
	ldr	r2, [sp, #32]
	str	r4, [sp, #8]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	ldr	r4, [sp, #44]
	vldrw.u32 q0, [r11, #-444]
	ldr	r6, [sp, #16]
	umlal	r10, lr, r0, r4
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #20]
	umlal	r10, lr, r6, r4
	vldrw.u32 q1, [r11, #68]
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #76]
	ldr	r1, [sp, #52]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #56]
	veor q0, q0, q3
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr	r6, [sp, #52]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r6
	ldr	r2, [sp, #84]
	veor q1, q1, q4
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr	r4, [sp, #112]
	ldr	r2, [sp, #4]
	adc	ip, ip, r9
	vshl.i32 q2, q1, #14
	umlal	r10, lr, r2, r4
	ldr	r4, [sp, #72]
	ldr	r2, [sp, #48]
	str	ip, [sp, #60]
	umlal	r10, lr, r4, r2
	ldrd	r8, [sp, #56]
	vsri.32 q2, q1, #18
	str	r10, [sp, #80]
	ldr	r2, [sp, #36]
	lsrl	r8, r9, #25
	umull	r4, ip, r2, r7
	ldr	r2, [sp, #88]
	str	r3, [sp, #96]
	vstrw.u32 q2, [q7, #-372]
	umlal	r4, ip, r5, r2
	ldr	r2, [sp, #68]
	ldr	r6, [sp, #16]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #8]
	vshl.i32 q5, q0, #13
	ldr	r2, [sp, #32]
	strd	r8, [sp, #56]
	umlal	r4, ip, r3, r2
	ldr	r3, [sp, #92]
	ldr	r2, [sp, #20]
	umlal	r4, ip, r0, r3
	vsri.32 q5, q0, #19
	ldr	r3, [sp, #44]
	umlal	r4, ip, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #100]
	umlal	r4, ip, r6, r3
	ldr	r3, [sp, #76]
	vstrw.u32 q5, [q7, #28]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #48]
	umlal	r4, ip, r3, r1
	ldr	r3, [sp, #112]
	umlal	r4, ip, r3, r2
	vldrw.u32 q0, [r11, #-364]
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, ip, r4
	str	r4, [sp, #28]
	vldrw.u32 q1, [r11, #148]
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #84]
	ldr	r2, [sp, #64]
	bic	r8, r8, #-67108864
	veor q0, q0, q3
	str	r8, [r3, #24]
	ldr	r3, [sp, #72]
	umull	ip, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #32]
	ldr	r2, [sp, #68]
	veor q1, q1, q4
	umlal	ip, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	ldrd	r2, r4, [sp, #92]
	ldr	r5, [sp, #44]
	vshl.i32 q2, q0, #10
	umlal	r3, r10, r4, r2
	umlal	ip, r8, r4, r5
	ldr	r4, [sp, #8]
	ldr	r2, [sp, #20]
	umlal	r3, r10, r4, r5
	ldr	r5, [sp, #40]
	vsri.32 q2, q0, #22
	umlal	ip, r8, r4, r5
	ldr	r5, [sp, #100]
	ldr	r4, [sp, #76]
	umlal	r3, r10, r0, r5
	umlal	ip, r8, r0, r4
	ldr	r0, [sp, #16]
	vstrw.u32 q2, [r11, #500]
	ldr	r5, [sp, #104]
	umlal	r3, r10, r0, r4
	ldr	r4, [sp, #52]
	umlal	r3, r10, r6, r1
	umlal	ip, r8, r0, r4
	vshl.i32 q5, q1, #10
	ldr	r0, [sp, #112]
	ldr	r4, [sp, #72]
	umlal	ip, r8, r6, r0
	umlal	r3, r10, r2, r0
	umlal	ip, r8, r2, r4
	ldr	r0, [sp, #108]
	vsri.32 q5, q1, #22
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #80]
	umlal	r3, r10, r2, r9
	umlal	ip, r8, r2, r0
	ldr	r2, [sp, #48]
	umlal	r3, r10, r0, r2
	vstrw.u32 q5, [q7, #-116]
	umlal	ip, r8, r2, r5
	ldr	r2, [sp, #24]
	ldr	r5, [sp, #28]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	vldrw.u32 q0, [r11, #-284]
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	ldr	r0, [sp, #84]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	vldrw.u32 q1, [r11, #228]
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	lsrl	r4, r5, #26
	adds	ip, ip, r4
	mov	r2, ip
	veor q0, q0, q3
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r4, r2
	mov	r5, r3
	lsll	r4, r5, #3
	bic	r1, r1, #-67108864
	veor q1, q1, q4
	str	r1, [r0, #32]
	bic	r1, ip, #-33554432
	str	r1, [r0, #36]
	adds	r1, r4, r2
	adc	r4, r5, r3
	vshl.i32 q2, q1, #20
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	adc	r4, r4, r3
	ldr	r3, [sp, #132]
	adds	r1, r1, r3
	vsri.32 q2, q1, #12
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	bic	r1, r1, #-67108864
	str	r1, [r0]
	ldr	r1, [sp, #136]
	vstrw.u32 q2, [q7, #-260]
	adds	r3, r1, r2
	ldr	r1, [sp, #120]
	bic	r2, r3, #-33554432
	add	r3, r1, r3, lsr #25
	strd	r2, r3, [r0, #4]
	add sp, sp, #144
	pop {r3-r11, pc}
.size fiat_mul_u8_p4, .-fiat_mul_u8_p4

.global fiat_mul_u8_p5
.type fiat_mul_u8_p5, %function
.thumb_func
.balign 16
fiat_mul_u8_p5:
	push {r3-r11, lr}
	sub sp, sp, #144
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
	mov	ip, #38
	vshl.i32 q5, q0, #19
	mov	lr, r2
	ldr	r3, [r2, #4]
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	vsri.32 q5, q0, #13
	mul	r6, ip, r2
	str	r0, [sp, #84]
	str	r2, [sp, #40]
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str	r6, [sp, #120]
	vstrw.u32 q5, [q7, #140]
	str	r2, [sp, #8]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	add	r8, r0, r2, lsl #1
	str	r8, [sp, #96]
	ldr	r2, [lr, #28]
	vldrw.u32 q0, [r11, #-204]
	mul	r8, ip, r6
	str	r6, [sp, #52]
	ldr	r6, [r1, #16]
	str	r7, [sp, #108]
	str	r6, [sp, #16]
	vldrw.u32 q1, [r11, #308]
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	str	r7, [sp, #80]
	ldr	r7, [lr, #24]
	str	r5, [sp, #100]
	veor q0, q0, q3
	mov	r2, r7
	mov	r5, r4
	str	r8, [sp, #116]
	mul	r8, ip, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	veor q1, q1, q4
	add	r10, r2, r7, lsl #1
	str	r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #64]
	mul	r5, ip, r3
	vshl.i32 q2, q0, #4
	str	r0, [sp, #76]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #112]
	str	r6, [sp, #72]
	str	r8, [sp, #88]
	vsri.32 q2, q0, #28
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str	r7, [sp, #24]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #20]
	vstrw.u32 q2, [q7, #-404]
	ldr	r7, [lr]
	str	r2, [sp, #104]
	ldr	r2, [r1, #4]
	str	r7, [sp, #32]
	ldr	r7, [sp, #108]
	str	r2, [sp, #4]
	vshl.i32 q5, q1, #4
	ldr	r2, [r1]
	ldr	r1, [sp, #40]
	str	ip, [sp, #68]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	vsri.32 q5, q1, #28
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #80]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #36]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #100]
	vstrw.u32 q5, [q7, #-4]
	ldr	r6, [sp, #96]
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	str	r3, [sp, #96]
	umlal	lr, ip, r6, r3
	ldr	r3, [sp, #100]
	vldrw.u32 q0, [r11, #-124]
	ldr	r7, [sp, #20]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r3, [sp, #96]
	ldr	r5, [sp, #120]
	vldrw.u32 q1, [r11, #388]
	ldr	r4, [sp, #8]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	ldr	r4, [sp, #116]
	ldr	r5, [sp, #16]
	umlal	r8, r1, r4, r0
	veor q0, q0, q3
	umlal	r8, r1, r10, r5
	ldr	r4, [sp, #88]
	str	r6, [sp, #96]
	ldr	r6, [sp, #24]
	umlal	r8, r1, r4, r6
	ldr	r6, [sp, #36]
	veor q1, q1, q4
	ldr	r4, [sp, #4]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #68]
	umlal	r8, r1, r6, r4
	ldr	r6, [sp, #32]
	vshl.i32 q2, q0, #7
	ldr	r4, [sp, #8]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #52]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	vsri.32 q2, q0, #25
	umlal	lr, ip, r1, r4
	ldr	r4, [sp, #72]
	umlal	lr, ip, r10, r0
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	str	r8, [sp, #132]
	vstrw.u32 q2, [r11, #468]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r5
	ldr	r6, [sp, #24]
	ldr	r5, [sp, #36]
	str	r0, [sp, #124]
	vshl.i32 q5, q1, #7
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr	r5, [sp, #104]
	vsri.32 q5, q1, #25
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	ldr	r7, [sp, #20]
	add	r8, r5, r8, lsl #1
	umlal	lr, ip, r8, r7
	ldr	r4, [sp, #32]
	vstrw.u32 q5, [q7, #-148]
	ldr	r5, [sp, #4]
	str	r2, [sp, #48]
	umlal	lr, ip, r5, r4
	ldr	r5, [sp, #64]
	ldr	r4, [sp, #56]
	umlal	lr, ip, r5, r2
	vldrw.u32 q0, [r11, #404]
	lsls	r2, r5, #1
	ldr	r7, [sp, #80]
	str	r2, [sp, #92]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	vldrw.u32 q1, [r11, #420]
	mov	r6, r8
	adc	r9, ip, r2
	mov	r8, r4
	ldrd	r2, r5, [sp, #96]
	bic	ip, r4, #-33554432
	umull	r4, r1, r7, r1
	vldrw.u32 q2, [r11, #436]
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	str	r0, [sp, #128]
	ldr	r0, [sp, #8]
	str	ip, [sp, #136]
	vldrw.u32 q5, [r11, #452]
	umlal	r4, r1, r2, r0
	ldr	r0, [sp, #124]
	ldr	r2, [sp, #36]
	str	r6, [sp, #124]
	umlal	r4, r1, r2, r0
	vldrw.u32 q6, [r11, #468]
	mov	r2, r6
	ldr	r6, [sp, #16]
	lsrl	r8, r9, #25
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #32]
	vbic q3, q2, q1
	umlal	r4, r1, r6, r2
	ldr	r6, [sp, #64]
	ldr	r2, [sp, #20]
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #44]
	ldr	r2, [sp, #4]
	veor q3, q3, q0
	umlal	r4, r1, r2, r6
	mov	ip, r4
	ldr	r2, [sp, #48]
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #16]
	umlal	ip, r1, r4, r2
	vstrw.u32 q3, [r11, #-508]
	ldr	r4, [sp, #96]
	str	ip, [sp, #140]
	umull	lr, ip, r4, r7
	ldr	r4, [sp, #120]
	ldr	r2, [sp, #88]
	vbic q3, q5, q2
	umlal	lr, ip, r5, r4
	ldr	r4, [sp, #116]
	ldr	r7, [sp, #20]
	umlal	lr, ip, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, ip, r10, r4
	veor q3, q3, q1
	umlal	lr, ip, r2, r0
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #68]
	umlal	lr, ip, r2, r6
	vstrw.u32 q3, [r11, #-492]
	ldr	r2, [sp, #32]
	umlal	lr, ip, r7, r2
	ldr	r2, [sp, #92]
	ldr	r7, [sp, #4]
	umlal	lr, ip, r7, r2
	vbic q3, q6, q5
	ldrd	r7, r2, [sp, #44]
	umlal	lr, ip, r7, r2
	adds	lr, lr, r8
	adc	r2, ip, r9
	str	lr, [sp, #56]
	str	r2, [sp, #60]
	veor q3, q3, q2
	ldr	r2, [sp, #40]
	ldrd	r8, [sp, #56]
	lsrl	r8, r9, #26
	bic	ip, lr, #-67108864
	lsls	r2, r2, #1
	str	ip, [sp, #120]
	vstrw.u32 q3, [r11, #-476]
	str	r2, [sp, #100]
	ldr	r2, [sp, #128]
	ldr	r7, [sp, #80]
	strd	r8, [sp, #56]
	umull	lr, ip, r7, r2
	vbic q3, q0, q6
	umlal	lr, ip, r5, r10
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r3
	ldr	r2, [sp, #124]
	umlal	lr, ip, r2, r4
	ldr	r2, [sp, #32]
	veor q3, q3, q5
	ldr	r4, [sp, #16]
	umlal	lr, ip, r0, r2
	ldr	r2, [sp, #64]
	umlal	lr, ip, r4, r2
	ldr	r4, [sp, #44]
	ldr	r2, [sp, #4]
	vstrw.u32 q3, [r11, #-460]
	umlal	lr, ip, r6, r4
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #20]
	umlal	lr, ip, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #140]
	vbic q3, q1, q0
	adds	r4, r6, r4
	mov	r8, r4
	ldr	r6, [sp, #60]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	veor q3, q3, q6
	ldr	r1, [sp, #76]
	lsrl	r8, r9, #25
	umlal	lr, ip, r2, r1
	ldrd	r1, r6, [sp, #48]
	umlal	lr, ip, r6, r1
	ldr	r2, [sp, #84]
	vstrw.u32 q3, [r11, #-444]
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	ldr	r4, [sp, #116]
	ldr	r2, [sp, #36]
	umlal	lr, r1, r5, r4
	vldrw.u32 q0, [r11, #484]
	ldr	r4, [sp, #88]
	ldr	r6, [sp, #68]
	umlal	lr, r1, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, r1, r2, r4
	vldrw.u32 q1, [r11, #500]
	umlal	lr, r1, r6, r0
	ldr	r2, [sp, #32]
	ldr	r6, [sp, #16]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #92]
	vldrw.u32 q2, [q7, #-500]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #20]
	ldr	r2, [sp, #44]
	umlal	lr, r1, r6, r2
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #100]
	vldrw.u32 q5, [q7, #-484]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #76]
	ldr	r2, [sp, #48]
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	vldrw.u32 q6, [q7, #-468]
	adc	r1, r1, r9
	str	lr, [sp, #8]
	str	r1, [sp, #12]
	ldrd	r8, [sp, #8]
	lsrl	r8, r9, #26
	ldr	r6, [sp, #124]
	vbic q3, q2, q1
	ldr	r2, [sp, #84]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	str	r1, [r2, #16]
	ldr	r2, [sp, #36]
	ldr	r6, [sp, #64]
	veor q3, q3, q0
	umlal	r10, lr, r5, r2
	ldr	r2, [sp, #32]
	str	r4, [sp, #8]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	ldr	r4, [sp, #44]
	vstrw.u32 q3, [r11, #-428]
	ldr	r6, [sp, #16]
	umlal	r10, lr, r0, r4
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #20]
	umlal	r10, lr, r6, r4
	vbic q3, q5, q2
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #76]
	ldr	r1, [sp, #52]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #56]
	veor q3, q3, q1
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr	r6, [sp, #52]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r6
	ldr	r2, [sp, #84]
	vstrw.u32 q3, [r11, #-412]
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr	r4, [sp, #112]
	ldr	r2, [sp, #4]
	adc	ip, ip, r9
	vbic q3, q6, q5
	umlal	r10, lr, r2, r4
	ldr	r4, [sp, #72]
	ldr	r2, [sp, #48]
	str	ip, [sp, #60]
	umlal	r10, lr, r4, r2
	ldrd	r8, [sp, #56]
	veor q3, q3, q2
	str	r10, [sp, #80]
	ldr	r2, [sp, #36]
	lsrl	r8, r9, #25
	umull	r4, ip, r2, r7
	ldr	r2, [sp, #88]
	str	r3, [sp, #96]
	vstrw.u32 q3, [r11, #-396]
	umlal	r4, ip, r5, r2
	ldr	r2, [sp, #68]
	ldr	r6, [sp, #16]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #8]
	vbic q3, q0, q6
	ldr	r2, [sp, #32]
	strd	r8, [sp, #56]
	umlal	r4, ip, r3, r2
	ldr	r3, [sp, #92]
	ldr	r2, [sp, #20]
	umlal	r4, ip, r0, r3
	veor q3, q3, q5
	ldr	r3, [sp, #44]
	umlal	r4, ip, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #100]
	umlal	r4, ip, r6, r3
	ldr	r3, [sp, #76]
	vstrw.u32 q3, [r11, #-380]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #48]
	umlal	r4, ip, r3, r1
	ldr	r3, [sp, #112]
	umlal	r4, ip, r3, r2
	vbic q3, q1, q0
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, ip, r4
	str	r4, [sp, #28]
	veor q3, q3, q6
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #84]
	ldr	r2, [sp, #64]
	bic	r8, r8, #-67108864
	vstrw.u32 q3, [r11, #-364]
	str	r8, [r3, #24]
	ldr	r3, [sp, #72]
	umull	ip, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #32]
	ldr	r2, [sp, #68]
	vldrw.u32 q0, [q7, #-452]
	umlal	ip, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	ldrd	r2, r4, [sp, #92]
	ldr	r5, [sp, #44]
	vldrw.u32 q1, [q7, #-436]
	umlal	r3, r10, r4, r2
	umlal	ip, r8, r4, r5
	ldr	r4, [sp, #8]
	ldr	r2, [sp, #20]
	umlal	r3, r10, r4, r5
	ldr	r5, [sp, #40]
	vldrw.u32 q2, [q7, #-420]
	umlal	ip, r8, r4, r5
	ldr	r5, [sp, #100]
	ldr	r4, [sp, #76]
	umlal	r3, r10, r0, r5
	umlal	ip, r8, r0, r4
	ldr	r0, [sp, #16]
	vldrw.u32 q5, [q7, #-404]
	ldr	r5, [sp, #104]
	umlal	r3, r10, r0, r4
	ldr	r4, [sp, #52]
	umlal	r3, r10, r6, r1
	umlal	ip, r8, r0, r4
	vldrw.u32 q6, [q7, #-388]
	ldr	r0, [sp, #112]
	ldr	r4, [sp, #72]
	umlal	ip, r8, r6, r0
	umlal	r3, r10, r2, r0
	umlal	ip, r8, r2, r4
	ldr	r0, [sp, #108]
	vbic q3, q2, q1
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #80]
	umlal	r3, r10, r2, r9
	umlal	ip, r8, r2, r0
	ldr	r2, [sp, #48]
	umlal	r3, r10, r0, r2
	veor q3, q3, q0
	umlal	ip, r8, r2, r5
	ldr	r2, [sp, #24]
	ldr	r5, [sp, #28]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	vstrw.u32 q3, [r11, #-348]
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	ldr	r0, [sp, #84]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	vbic q3, q5, q2
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	lsrl	r4, r5, #26
	adds	ip, ip, r4
	mov	r2, ip
	veor q3, q3, q1
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r4, r2
	mov	r5, r3
	lsll	r4, r5, #3
	bic	r1, r1, #-67108864
	vstrw.u32 q3, [r11, #-332]
	str	r1, [r0, #32]
	bic	r1, ip, #-33554432
	str	r1, [r0, #36]
	adds	r1, r4, r2
	adc	r4, r5, r3
	vbic q3, q6, q5
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	adc	r4, r4, r3
	ldr	r3, [sp, #132]
	adds	r1, r1, r3
	veor q3, q3, q2
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	bic	r1, r1, #-67108864
	str	r1, [r0]
	ldr	r1, [sp, #136]
	vstrw.u32 q3, [r11, #-316]
	adds	r3, r1, r2
	ldr	r1, [sp, #120]
	bic	r2, r3, #-33554432
	add	r3, r1, r3, lsr #25
	strd	r2, r3, [r0, #4]
	add sp, sp, #144
	pop {r3-r11, pc}
.size fiat_mul_u8_p5, .-fiat_mul_u8_p5

.global fiat_mul_u8_p6
.type fiat_mul_u8_p6, %function
.thumb_func
.balign 16
fiat_mul_u8_p6:
	push {r3-r11, lr}
	sub sp, sp, #144
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
	mov	ip, #38
	vbic q3, q0, q6
	mov	lr, r2
	ldr	r3, [r2, #4]
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	veor q3, q3, q5
	mul	r6, ip, r2
	str	r0, [sp, #84]
	str	r2, [sp, #40]
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str	r6, [sp, #120]
	vstrw.u32 q3, [r11, #-300]
	str	r2, [sp, #8]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	add	r8, r0, r2, lsl #1
	str	r8, [sp, #96]
	ldr	r2, [lr, #28]
	vbic q3, q1, q0
	mul	r8, ip, r6
	str	r6, [sp, #52]
	ldr	r6, [r1, #16]
	str	r7, [sp, #108]
	str	r6, [sp, #16]
	veor q3, q3, q6
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	str	r7, [sp, #80]
	ldr	r7, [lr, #24]
	str	r5, [sp, #100]
	vstrw.u32 q3, [r11, #-284]
	mov	r2, r7
	mov	r5, r4
	str	r8, [sp, #116]
	mul	r8, ip, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	vldrw.u32 q0, [q7, #-372]
	add	r10, r2, r7, lsl #1
	str	r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #64]
	mul	r5, ip, r3
	vldrw.u32 q1, [q7, #-356]
	str	r0, [sp, #76]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #112]
	str	r6, [sp, #72]
	str	r8, [sp, #88]
	vldrw.u32 q2, [q7, #-340]
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str	r7, [sp, #24]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #20]
	vldrw.u32 q5, [q7, #-324]
	ldr	r7, [lr]
	str	r2, [sp, #104]
	ldr	r2, [r1, #4]
	str	r7, [sp, #32]
	ldr	r7, [sp, #108]
	str	r2, [sp, #4]
	vldrw.u32 q6, [q7, #-308]
	ldr	r2, [r1]
	ldr	r1, [sp, #40]
	str	ip, [sp, #68]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	vbic q3, q2, q1
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #80]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #36]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #100]
	veor q3, q3, q0
	ldr	r6, [sp, #96]
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	str	r3, [sp, #96]
	umlal	lr, ip, r6, r3
	ldr	r3, [sp, #100]
	vstrw.u32 q3, [r11, #-268]
	ldr	r7, [sp, #20]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r3, [sp, #96]
	ldr	r5, [sp, #120]
	vbic q3, q5, q2
	ldr	r4, [sp, #8]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	ldr	r4, [sp, #116]
	ldr	r5, [sp, #16]
	umlal	r8, r1, r4, r0
	veor q3, q3, q1
	umlal	r8, r1, r10, r5
	ldr	r4, [sp, #88]
	str	r6, [sp, #96]
	ldr	r6, [sp, #24]
	umlal	r8, r1, r4, r6
	ldr	r6, [sp, #36]
	vstrw.u32 q3, [r11, #-252]
	ldr	r4, [sp, #4]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #68]
	umlal	r8, r1, r6, r4
	ldr	r6, [sp, #32]
	vbic q3, q6, q5
	ldr	r4, [sp, #8]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #52]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	veor q3, q3, q2
	umlal	lr, ip, r1, r4
	ldr	r4, [sp, #72]
	umlal	lr, ip, r10, r0
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	str	r8, [sp, #132]
	vstrw.u32 q3, [r11, #-236]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r5
	ldr	r6, [sp, #24]
	ldr	r5, [sp, #36]
	str	r0, [sp, #124]
	vbic q3, q0, q6
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr	r5, [sp, #104]
	veor q3, q3, q5
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	ldr	r7, [sp, #20]
	add	r8, r5, r8, lsl #1
	umlal	lr, ip, r8, r7
	ldr	r4, [sp, #32]
	vstrw.u32 q3, [r11, #-220]
	ldr	r5, [sp, #4]
	str	r2, [sp, #48]
	umlal	lr, ip, r5, r4
	ldr	r5, [sp, #64]
	ldr	r4, [sp, #56]
	umlal	lr, ip, r5, r2
	vbic q3, q1, q0
	lsls	r2, r5, #1
	ldr	r7, [sp, #80]
	str	r2, [sp, #92]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	veor q3, q3, q6
	mov	r6, r8
	adc	r9, ip, r2
	mov	r8, r4
	ldrd	r2, r5, [sp, #96]
	bic	ip, r4, #-33554432
	umull	r4, r1, r7, r1
	vstrw.u32 q3, [r11, #-204]
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	str	r0, [sp, #128]
	ldr	r0, [sp, #8]
	str	ip, [sp, #136]
	vldrw.u32 q0, [q7, #-292]
	umlal	r4, r1, r2, r0
	ldr	r0, [sp, #124]
	ldr	r2, [sp, #36]
	str	r6, [sp, #124]
	umlal	r4, r1, r2, r0
	vldrw.u32 q1, [q7, #-276]
	mov	r2, r6
	ldr	r6, [sp, #16]
	lsrl	r8, r9, #25
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #32]
	vldrw.u32 q2, [q7, #-260]
	umlal	r4, r1, r6, r2
	ldr	r6, [sp, #64]
	ldr	r2, [sp, #20]
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #44]
	ldr	r2, [sp, #4]
	vldrw.u32 q5, [q7, #-244]
	umlal	r4, r1, r2, r6
	mov	ip, r4
	ldr	r2, [sp, #48]
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #16]
	umlal	ip, r1, r4, r2
	vldrw.u32 q6, [q7, #-228]
	ldr	r4, [sp, #96]
	str	ip, [sp, #140]
	umull	lr, ip, r4, r7
	ldr	r4, [sp, #120]
	ldr	r2, [sp, #88]
	vbic q3, q2, q1
	umlal	lr, ip, r5, r4
	ldr	r4, [sp, #116]
	ldr	r7, [sp, #20]
	umlal	lr, ip, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, ip, r10, r4
	veor q3, q3, q0
	umlal	lr, ip, r2, r0
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #68]
	umlal	lr, ip, r2, r6
	vstrw.u32 q3, [r11, #-188]
	ldr	r2, [sp, #32]
	umlal	lr, ip, r7, r2
	ldr	r2, [sp, #92]
	ldr	r7, [sp, #4]
	umlal	lr, ip, r7, r2
	vbic q3, q5, q2
	ldrd	r7, r2, [sp, #44]
	umlal	lr, ip, r7, r2
	adds	lr, lr, r8
	adc	r2, ip, r9
	str	lr, [sp, #56]
	str	r2, [sp, #60]
	veor q3, q3, q1
	ldr	r2, [sp, #40]
	ldrd	r8, [sp, #56]
	lsrl	r8, r9, #26
	bic	ip, lr, #-67108864
	lsls	r2, r2, #1
	str	ip, [sp, #120]
	vstrw.u32 q3, [r11, #-172]
	str	r2, [sp, #100]
	ldr	r2, [sp, #128]
	ldr	r7, [sp, #80]
	strd	r8, [sp, #56]
	umull	lr, ip, r7, r2
	vbic q3, q6, q5
	umlal	lr, ip, r5, r10
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r3
	ldr	r2, [sp, #124]
	umlal	lr, ip, r2, r4
	ldr	r2, [sp, #32]
	veor q3, q3, q2
	ldr	r4, [sp, #16]
	umlal	lr, ip, r0, r2
	ldr	r2, [sp, #64]
	umlal	lr, ip, r4, r2
	ldr	r4, [sp, #44]
	ldr	r2, [sp, #4]
	vstrw.u32 q3, [r11, #-156]
	umlal	lr, ip, r6, r4
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #20]
	umlal	lr, ip, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #140]
	vbic q3, q0, q6
	adds	r4, r6, r4
	mov	r8, r4
	ldr	r6, [sp, #60]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	veor q3, q3, q5
	ldr	r1, [sp, #76]
	lsrl	r8, r9, #25
	umlal	lr, ip, r2, r1
	ldrd	r1, r6, [sp, #48]
	umlal	lr, ip, r6, r1
	ldr	r2, [sp, #84]
	vstrw.u32 q3, [r11, #-140]
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	ldr	r4, [sp, #116]
	ldr	r2, [sp, #36]
	umlal	lr, r1, r5, r4
	vbic q3, q1, q0
	ldr	r4, [sp, #88]
	ldr	r6, [sp, #68]
	umlal	lr, r1, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, r1, r2, r4
	veor q3, q3, q6
	umlal	lr, r1, r6, r0
	ldr	r2, [sp, #32]
	ldr	r6, [sp, #16]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #92]
	vstrw.u32 q3, [r11, #-124]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #20]
	ldr	r2, [sp, #44]
	umlal	lr, r1, r6, r2
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #100]
	vldrw.u32 q0, [q7, #-212]
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #76]
	ldr	r2, [sp, #48]
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	vldrw.u32 q1, [q7, #-196]
	adc	r1, r1, r9
	str	lr, [sp, #8]
	str	r1, [sp, #12]
	ldrd	r8, [sp, #8]
	lsrl	r8, r9, #26
	ldr	r6, [sp, #124]
	vldrw.u32 q2, [q7, #-180]
	ldr	r2, [sp, #84]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	str	r1, [r2, #16]
	ldr	r2, [sp, #36]
	ldr	r6, [sp, #64]
	vldrw.u32 q5, [q7, #-164]
	umlal	r10, lr, r5, r2
	ldr	r2, [sp, #32]
	str	r4, [sp, #8]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	ldr	r4, [sp, #44]
	vldrw.u32 q6, [q7, #-148]
	ldr	r6, [sp, #16]
	umlal	r10, lr, r0, r4
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #20]
	umlal	r10, lr, r6, r4
	vbic q3, q2, q1
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #76]
	ldr	r1, [sp, #52]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #56]
	veor q3, q3, q0
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr	r6, [sp, #52]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r6
	ldr	r2, [sp, #84]
	vstrw.u32 q3, [r11, #4]
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr	r4, [sp, #112]
	ldr	r2, [sp, #4]
	adc	ip, ip, r9
	vbic q3, q5, q2
	umlal	r10, lr, r2, r4
	ldr	r4, [sp, #72]
	ldr	r2, [sp, #48]
	str	ip, [sp, #60]
	umlal	r10, lr, r4, r2
	ldrd	r8, [sp, #56]
	veor q3, q3, q1
	str	r10, [sp, #80]
	ldr	r2, [sp, #36]
	lsrl	r8, r9, #25
	umull	r4, ip, r2, r7
	ldr	r2, [sp, #88]
	str	r3, [sp, #96]
	vstrw.u32 q3, [r11, #20]
	umlal	r4, ip, r5, r2
	ldr	r2, [sp, #68]
	ldr	r6, [sp, #16]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #8]
	vbic q3, q6, q5
	ldr	r2, [sp, #32]
	strd	r8, [sp, #56]
	umlal	r4, ip, r3, r2
	ldr	r3, [sp, #92]
	ldr	r2, [sp, #20]
	umlal	r4, ip, r0, r3
	veor q3, q3, q2
	ldr	r3, [sp, #44]
	umlal	r4, ip, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #100]
	umlal	r4, ip, r6, r3
	ldr	r3, [sp, #76]
	vstrw.u32 q3, [r11, #36]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #48]
	umlal	r4, ip, r3, r1
	ldr	r3, [sp, #112]
	umlal	r4, ip, r3, r2
	vbic q3, q0, q6
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, ip, r4
	str	r4, [sp, #28]
	veor q3, q3, q5
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #84]
	ldr	r2, [sp, #64]
	bic	r8, r8, #-67108864
	vstrw.u32 q3, [r11, #52]
	str	r8, [r3, #24]
	ldr	r3, [sp, #72]
	umull	ip, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #32]
	ldr	r2, [sp, #68]
	vbic q3, q1, q0
	umlal	ip, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	ldrd	r2, r4, [sp, #92]
	ldr	r5, [sp, #44]
	veor q3, q3, q6
	umlal	r3, r10, r4, r2
	umlal	ip, r8, r4, r5
	ldr	r4, [sp, #8]
	ldr	r2, [sp, #20]
	umlal	r3, r10, r4, r5
	ldr	r5, [sp, #40]
	vstrw.u32 q3, [r11, #68]
	umlal	ip, r8, r4, r5
	ldr	r5, [sp, #100]
	ldr	r4, [sp, #76]
	umlal	r3, r10, r0, r5
	umlal	ip, r8, r0, r4
	ldr	r0, [sp, #16]
	vldrw.u32 q0, [q7, #-132]
	ldr	r5, [sp, #104]
	umlal	r3, r10, r0, r4
	ldr	r4, [sp, #52]
	umlal	r3, r10, r6, r1
	umlal	ip, r8, r0, r4
	vldrw.u32 q1, [q7, #-116]
	ldr	r0, [sp, #112]
	ldr	r4, [sp, #72]
	umlal	ip, r8, r6, r0
	umlal	r3, r10, r2, r0
	umlal	ip, r8, r2, r4
	ldr	r0, [sp, #108]
	vldrw.u32 q2, [q7, #-100]
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #80]
	umlal	r3, r10, r2, r9
	umlal	ip, r8, r2, r0
	ldr	r2, [sp, #48]
	umlal	r3, r10, r0, r2
	vldrw.u32 q5, [q7, #-84]
	umlal	ip, r8, r2, r5
	ldr	r2, [sp, #24]
	ldr	r5, [sp, #28]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	vldrw.u32 q6, [q7, #-68]
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	ldr	r0, [sp, #84]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	vbic q3, q2, q1
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	lsrl	r4, r5, #26
	adds	ip, ip, r4
	mov	r2, ip
	veor q3, q3, q0
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r4, r2
	mov	r5, r3
	lsll	r4, r5, #3
	bic	r1, r1, #-67108864
	vstrw.u32 q3, [r11, #84]
	str	r1, [r0, #32]
	bic	r1, ip, #-33554432
	str	r1, [r0, #36]
	adds	r1, r4, r2
	adc	r4, r5, r3
	vbic q3, q5, q2
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	adc	r4, r4, r3
	ldr	r3, [sp, #132]
	adds	r1, r1, r3
	veor q3, q3, q1
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	bic	r1, r1, #-67108864
	str	r1, [r0]
	ldr	r1, [sp, #136]
	vstrw.u32 q3, [r11, #100]
	adds	r3, r1, r2
	ldr	r1, [sp, #120]
	bic	r2, r3, #-33554432
	add	r3, r1, r3, lsr #25
	strd	r2, r3, [r0, #4]
	add sp, sp, #144
	pop {r3-r11, pc}
.size fiat_mul_u8_p6, .-fiat_mul_u8_p6

.global fiat_mul_u8_p7
.type fiat_mul_u8_p7, %function
.thumb_func
.balign 16
fiat_mul_u8_p7:
	push {r3-r11, lr}
	sub sp, sp, #144
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
	mov	ip, #38
	vbic q3, q6, q5
	mov	lr, r2
	ldr	r3, [r2, #4]
	ldr	r7, [r2, #32]
	ldr	r4, [r2, #8]
	ldr	r2, [r2, #12]
	veor q3, q3, q2
	mul	r6, ip, r2
	str	r0, [sp, #84]
	str	r2, [sp, #40]
	ldr	r0, [lr, #16]
	ldr	r2, [r1, #24]
	str	r6, [sp, #120]
	vstrw.u32 q3, [r11, #116]
	str	r2, [sp, #8]
	ldr	r6, [lr, #20]
	add	r2, r0, r0, lsl #3
	add	r8, r0, r2, lsl #1
	str	r8, [sp, #96]
	ldr	r2, [lr, #28]
	vbic q3, q0, q6
	mul	r8, ip, r6
	str	r6, [sp, #52]
	ldr	r6, [r1, #16]
	str	r7, [sp, #108]
	str	r6, [sp, #16]
	veor q3, q3, q5
	ldr	r7, [r1, #32]
	mov	r6, r2
	ldr	r5, [r1, #36]
	str	r7, [sp, #80]
	ldr	r7, [lr, #24]
	str	r5, [sp, #100]
	vstrw.u32 q3, [r11, #132]
	mov	r2, r7
	mov	r5, r4
	str	r8, [sp, #116]
	mul	r8, ip, r6
	add	r7, r7, r7, lsl #3
	add	r4, r4, r4, lsl #3
	vbic q3, q1, q0
	add	r10, r2, r7, lsl #1
	str	r5, [sp, #44]
	add	r4, r5, r4, lsl #1
	str	r3, [sp, #64]
	mul	r5, ip, r3
	veor q3, q3, q6
	str	r0, [sp, #76]
	ldr	r3, [r1, #28]
	ldr	r0, [r1, #20]
	str	r2, [sp, #112]
	str	r6, [sp, #72]
	str	r8, [sp, #88]
	vstrw.u32 q3, [r11, #148]
	ldr	r7, [r1, #12]
	ldr	r2, [lr, #36]
	str	r7, [sp, #24]
	ldr	r7, [r1, #8]
	mul	ip, ip, r2
	str	r7, [sp, #20]
	vldrw.u32 q0, [q7, #-52]
	ldr	r7, [lr]
	str	r2, [sp, #104]
	ldr	r2, [r1, #4]
	str	r7, [sp, #32]
	ldr	r7, [sp, #108]
	str	r2, [sp, #4]
	vldrw.u32 q1, [q7, #-36]
	ldr	r2, [r1]
	ldr	r1, [sp, #40]
	str	ip, [sp, #68]
	add	ip, r7, r7, lsl #3
	add	ip, r7, ip, lsl #1
	vldrw.u32 q2, [q7, #-20]
	add	lr, r1, r1, lsl #3
	ldr	r7, [sp, #80]
	add	lr, r1, lr, lsl #1
	str	ip, [sp, #36]
	umull	lr, ip, lr, r7
	ldr	r1, [sp, #100]
	vldrw.u32 q5, [q7, #-4]
	ldr	r6, [sp, #96]
	umlal	lr, ip, r1, r4
	umull	r4, r1, r4, r7
	str	r3, [sp, #96]
	umlal	lr, ip, r6, r3
	ldr	r3, [sp, #100]
	vldrw.u32 q6, [q7, #12]
	ldr	r7, [sp, #20]
	umlal	r4, r1, r3, r5
	mov	r8, r4
	ldr	r3, [sp, #96]
	ldr	r5, [sp, #120]
	vbic q3, q2, q1
	ldr	r4, [sp, #8]
	umlal	r8, r1, r5, r3
	umlal	r8, r1, r6, r4
	ldr	r4, [sp, #116]
	ldr	r5, [sp, #16]
	umlal	r8, r1, r4, r0
	veor q3, q3, q0
	umlal	r8, r1, r10, r5
	ldr	r4, [sp, #88]
	str	r6, [sp, #96]
	ldr	r6, [sp, #24]
	umlal	r8, r1, r4, r6
	ldr	r6, [sp, #36]
	vstrw.u32 q3, [r11, #164]
	ldr	r4, [sp, #4]
	umlal	r8, r1, r6, r7
	ldr	r6, [sp, #68]
	umlal	r8, r1, r6, r4
	ldr	r6, [sp, #32]
	vbic q3, q5, q2
	ldr	r4, [sp, #8]
	umlal	r8, r1, r6, r2
	ldr	r6, [sp, #52]
	str	r1, [sp, #60]
	add	r1, r6, r6, lsl #3
	add	r1, r6, r1, lsl #1
	veor q3, q3, q1
	umlal	lr, ip, r1, r4
	ldr	r4, [sp, #72]
	umlal	lr, ip, r10, r0
	str	r8, [sp, #56]
	bic	r8, r8, #-67108864
	str	r8, [sp, #132]
	vstrw.u32 q3, [r11, #180]
	add	r8, r4, r4, lsl #3
	add	r8, r4, r8, lsl #1
	umlal	lr, ip, r8, r5
	ldr	r6, [sp, #24]
	ldr	r5, [sp, #36]
	str	r0, [sp, #124]
	vbic q3, q6, q5
	umlal	lr, ip, r5, r6
	ldrd	r6, [sp, #56]
	lsrl	r6, r7, #26
	mov	r0, r8
	ldr	r5, [sp, #104]
	veor q3, q3, q2
	strd	r6, [sp, #56]
	add	r8, r5, r5, lsl #3
	ldr	r7, [sp, #20]
	add	r8, r5, r8, lsl #1
	umlal	lr, ip, r8, r7
	ldr	r4, [sp, #32]
	vstrw.u32 q3, [r11, #196]
	ldr	r5, [sp, #4]
	str	r2, [sp, #48]
	umlal	lr, ip, r5, r4
	ldr	r5, [sp, #64]
	ldr	r4, [sp, #56]
	umlal	lr, ip, r5, r2
	vbic q3, q0, q6
	lsls	r2, r5, #1
	ldr	r7, [sp, #80]
	str	r2, [sp, #92]
	ldr	r2, [sp, #60]
	adds	r4, lr, r4
	veor q3, q3, q5
	mov	r6, r8
	adc	r9, ip, r2
	mov	r8, r4
	ldrd	r2, r5, [sp, #96]
	bic	ip, r4, #-33554432
	umull	r4, r1, r7, r1
	vstrw.u32 q3, [r11, #212]
	umlal	r4, r1, r5, r2
	mov	r2, r0
	umlal	r4, r1, r10, r3
	str	r0, [sp, #128]
	ldr	r0, [sp, #8]
	str	ip, [sp, #136]
	vbic q3, q1, q0
	umlal	r4, r1, r2, r0
	ldr	r0, [sp, #124]
	ldr	r2, [sp, #36]
	str	r6, [sp, #124]
	umlal	r4, r1, r2, r0
	veor q3, q3, q6
	mov	r2, r6
	ldr	r6, [sp, #16]
	lsrl	r8, r9, #25
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #32]
	vstrw.u32 q3, [r11, #228]
	umlal	r4, r1, r6, r2
	ldr	r6, [sp, #64]
	ldr	r2, [sp, #20]
	umlal	r4, r1, r2, r6
	ldr	r6, [sp, #44]
	ldr	r2, [sp, #4]
	vldrw.u32 q0, [q7, #28]
	umlal	r4, r1, r2, r6
	mov	ip, r4
	ldr	r2, [sp, #48]
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #16]
	umlal	ip, r1, r4, r2
	vldrw.u32 q1, [q7, #44]
	ldr	r4, [sp, #96]
	str	ip, [sp, #140]
	umull	lr, ip, r4, r7
	ldr	r4, [sp, #120]
	ldr	r2, [sp, #88]
	vldrw.u32 q2, [q7, #60]
	umlal	lr, ip, r5, r4
	ldr	r4, [sp, #116]
	ldr	r7, [sp, #20]
	umlal	lr, ip, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, ip, r10, r4
	vldrw.u32 q5, [q7, #76]
	umlal	lr, ip, r2, r0
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r6
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #68]
	umlal	lr, ip, r2, r6
	vldrw.u32 q6, [q7, #92]
	ldr	r2, [sp, #32]
	umlal	lr, ip, r7, r2
	ldr	r2, [sp, #92]
	ldr	r7, [sp, #4]
	umlal	lr, ip, r7, r2
	vbic q3, q2, q1
	ldrd	r7, r2, [sp, #44]
	umlal	lr, ip, r7, r2
	adds	lr, lr, r8
	adc	r2, ip, r9
	str	lr, [sp, #56]
	str	r2, [sp, #60]
	veor q3, q3, q0
	ldr	r2, [sp, #40]
	ldrd	r8, [sp, #56]
	lsrl	r8, r9, #26
	bic	ip, lr, #-67108864
	lsls	r2, r2, #1
	str	ip, [sp, #120]
	vstrw.u32 q3, [r11, #244]
	str	r2, [sp, #100]
	ldr	r2, [sp, #128]
	ldr	r7, [sp, #80]
	strd	r8, [sp, #56]
	umull	lr, ip, r7, r2
	vbic q3, q5, q2
	umlal	lr, ip, r5, r10
	ldr	r2, [sp, #36]
	umlal	lr, ip, r2, r3
	ldr	r2, [sp, #124]
	umlal	lr, ip, r2, r4
	ldr	r2, [sp, #32]
	veor q3, q3, q1
	ldr	r4, [sp, #16]
	umlal	lr, ip, r0, r2
	ldr	r2, [sp, #64]
	umlal	lr, ip, r4, r2
	ldr	r4, [sp, #44]
	ldr	r2, [sp, #4]
	vstrw.u32 q3, [r11, #260]
	umlal	lr, ip, r6, r4
	ldr	r4, [sp, #40]
	ldr	r6, [sp, #20]
	umlal	lr, ip, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #140]
	vbic q3, q6, q5
	adds	r4, r6, r4
	mov	r8, r4
	ldr	r6, [sp, #60]
	bic	r4, r4, #-33554432
	adc	r9, r1, r6
	veor q3, q3, q2
	ldr	r1, [sp, #76]
	lsrl	r8, r9, #25
	umlal	lr, ip, r2, r1
	ldrd	r1, r6, [sp, #48]
	umlal	lr, ip, r6, r1
	ldr	r2, [sp, #84]
	vstrw.u32 q3, [r11, #276]
	str	lr, [sp, #56]
	umull	lr, r1, r10, r7
	str	r4, [r2, #12]
	ldr	r4, [sp, #116]
	ldr	r2, [sp, #36]
	umlal	lr, r1, r5, r4
	vbic q3, q0, q6
	ldr	r4, [sp, #88]
	ldr	r6, [sp, #68]
	umlal	lr, r1, r4, r3
	ldr	r4, [sp, #8]
	umlal	lr, r1, r2, r4
	veor q3, q3, q5
	umlal	lr, r1, r6, r0
	ldr	r2, [sp, #32]
	ldr	r6, [sp, #16]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #24]
	ldr	r2, [sp, #92]
	vstrw.u32 q3, [r11, #292]
	umlal	lr, r1, r6, r2
	ldr	r6, [sp, #20]
	ldr	r2, [sp, #44]
	umlal	lr, r1, r6, r2
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #100]
	vbic q3, q1, q0
	umlal	lr, r1, r2, r6
	ldr	r6, [sp, #76]
	ldr	r2, [sp, #48]
	umlal	lr, r1, r6, r2
	adds	lr, lr, r8
	veor q3, q3, q6
	adc	r1, r1, r9
	str	lr, [sp, #8]
	str	r1, [sp, #12]
	ldrd	r8, [sp, #8]
	lsrl	r8, r9, #26
	ldr	r6, [sp, #124]
	vstrw.u32 q3, [r11, #308]
	ldr	r2, [sp, #84]
	bic	r1, lr, #-67108864
	umull	r10, lr, r7, r6
	str	r1, [r2, #16]
	ldr	r2, [sp, #36]
	ldr	r6, [sp, #64]
	vldrw.u32 q0, [q7, #108]
	umlal	r10, lr, r5, r2
	ldr	r2, [sp, #32]
	str	r4, [sp, #8]
	umlal	r10, lr, r3, r2
	umlal	r10, lr, r4, r6
	ldr	r4, [sp, #44]
	vldrw.u32 q1, [q7, #124]
	ldr	r6, [sp, #16]
	umlal	r10, lr, r0, r4
	ldr	r4, [sp, #40]
	ldr	r2, [sp, #20]
	umlal	r10, lr, r6, r4
	vldrw.u32 q2, [q7, #140]
	ldr	r6, [sp, #24]
	ldr	r4, [sp, #76]
	ldr	r1, [sp, #52]
	umlal	r10, lr, r6, r4
	mov	r4, r8
	ldr	r6, [sp, #56]
	vldrw.u32 q5, [q7, #156]
	lsls	r1, r1, #1
	adds	r4, r6, r4
	ldr	r6, [sp, #52]
	str	r4, [sp, #56]
	umlal	r10, lr, r2, r6
	ldr	r2, [sp, #84]
	vldrw.u32 q6, [q7, #172]
	bic	r4, r4, #-33554432
	str	r4, [r2, #20]
	ldr	r4, [sp, #112]
	ldr	r2, [sp, #4]
	adc	ip, ip, r9
	vbic q3, q2, q1
	umlal	r10, lr, r2, r4
	ldr	r4, [sp, #72]
	ldr	r2, [sp, #48]
	str	ip, [sp, #60]
	umlal	r10, lr, r4, r2
	ldrd	r8, [sp, #56]
	veor q3, q3, q0
	str	r10, [sp, #80]
	ldr	r2, [sp, #36]
	lsrl	r8, r9, #25
	umull	r4, ip, r2, r7
	ldr	r2, [sp, #88]
	str	r3, [sp, #96]
	vstrw.u32 q3, [r11, #324]
	umlal	r4, ip, r5, r2
	ldr	r2, [sp, #68]
	ldr	r6, [sp, #16]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #8]
	vbic q3, q5, q2
	ldr	r2, [sp, #32]
	strd	r8, [sp, #56]
	umlal	r4, ip, r3, r2
	ldr	r3, [sp, #92]
	ldr	r2, [sp, #20]
	umlal	r4, ip, r0, r3
	veor q3, q3, q1
	ldr	r3, [sp, #44]
	umlal	r4, ip, r6, r3
	ldr	r6, [sp, #24]
	ldr	r3, [sp, #100]
	umlal	r4, ip, r6, r3
	ldr	r3, [sp, #76]
	vstrw.u32 q3, [r11, #340]
	umlal	r4, ip, r2, r3
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #48]
	umlal	r4, ip, r3, r1
	ldr	r3, [sp, #112]
	umlal	r4, ip, r3, r2
	vbic q3, q6, q5
	adds	r8, r4, r8
	ldr	r4, [sp, #60]
	str	r8, [sp, #24]
	adc	r4, ip, r4
	str	r4, [sp, #28]
	veor q3, q3, q2
	ldrd	r2, [sp, #24]
	lsrl	r2, r3, #26
	strd	r2, [sp, #24]
	ldr	r3, [sp, #84]
	ldr	r2, [sp, #64]
	bic	r8, r8, #-67108864
	vstrw.u32 q3, [r11, #356]
	str	r8, [r3, #24]
	ldr	r3, [sp, #72]
	umull	ip, r8, r7, r2
	lsl	r9, r3, #1
	ldr	r3, [sp, #32]
	ldr	r2, [sp, #68]
	vbic q3, q0, q6
	umlal	ip, r8, r5, r3
	umull	r3, r10, r7, r3
	umlal	r3, r10, r5, r2
	ldrd	r2, r4, [sp, #92]
	ldr	r5, [sp, #44]
	veor q3, q3, q5
	umlal	r3, r10, r4, r2
	umlal	ip, r8, r4, r5
	ldr	r4, [sp, #8]
	ldr	r2, [sp, #20]
	umlal	r3, r10, r4, r5
	ldr	r5, [sp, #40]
	vstrw.u32 q3, [r11, #372]
	umlal	ip, r8, r4, r5
	ldr	r5, [sp, #100]
	ldr	r4, [sp, #76]
	umlal	r3, r10, r0, r5
	umlal	ip, r8, r0, r4
	ldr	r0, [sp, #16]
	vbic q3, q1, q0
	ldr	r5, [sp, #104]
	umlal	r3, r10, r0, r4
	ldr	r4, [sp, #52]
	umlal	r3, r10, r6, r1
	umlal	ip, r8, r0, r4
	veor q3, q3, q6
	ldr	r0, [sp, #112]
	ldr	r4, [sp, #72]
	umlal	ip, r8, r6, r0
	umlal	r3, r10, r2, r0
	umlal	ip, r8, r2, r4
	ldr	r0, [sp, #108]
	vstrw.u32 q3, [r11, #388]
	ldr	r2, [sp, #4]
	ldr	r6, [sp, #80]
	umlal	r3, r10, r2, r9
	umlal	ip, r8, r2, r0
	ldr	r2, [sp, #48]
	umlal	r3, r10, r0, r2
	vldrw.u32 q0, [r11, #-108]
	umlal	ip, r8, r2, r5
	ldr	r2, [sp, #24]
	ldr	r5, [sp, #28]
	adds	r4, r6, r2
	mov	r2, r4
	mov	r1, r3
	vldrw.u32 q1, [r11, #-508]
	adc	r3, lr, r5
	lsrl	r2, r3, #25
	ldr	r0, [sp, #84]
	adds	r1, r1, r2
	bic	r4, r4, #-33554432
	veor q1, q1, q0
	str	r4, [r0, #28]
	mov	r4, r1
	adc	r5, r10, r3
	lsrl	r4, r5, #26
	adds	ip, ip, r4
	mov	r2, ip
	vstrw.u32 q1, [r11, #-508]
	adc	r3, r8, r5
	lsrl	r2, r3, #25
	mov	r4, r2
	mov	r5, r3
	lsll	r4, r5, #3
	bic	r1, r1, #-67108864
	vldrw.u32 q0, [r11, #-92]
	str	r1, [r0, #32]
	bic	r1, ip, #-33554432
	str	r1, [r0, #36]
	adds	r1, r4, r2
	adc	r4, r5, r3
	vldrw.u32 q1, [r11, #4]
	adds	r1, r1, r1
	adcs	r4, r4, r4
	adds	r1, r1, r2
	adc	r4, r4, r3
	ldr	r3, [sp, #132]
	adds	r1, r1, r3
	veor q1, q1, q0
	mov	r2, r1
	adc	r3, r4, #0
	lsrl	r2, r3, #26
	bic	r1, r1, #-67108864
	str	r1, [r0]
	ldr	r1, [sp, #136]
	vstrw.u32 q1, [r11, #4]
	adds	r3, r1, r2
	ldr	r1, [sp, #120]
	bic	r2, r3, #-33554432
	add	r3, r1, r3, lsr #25
	strd	r2, r3, [r0, #4]
	add sp, sp, #144
	pop {r3-r11, pc}
.size fiat_mul_u8_p7, .-fiat_mul_u8_p7

.global fiat_u_qsave
.type fiat_u_qsave, %function
.thumb_func
fiat_u_qsave:
	vstrw.u32 q4, [r0, #0]
	vstrw.u32 q5, [r0, #16]
	vstrw.u32 q6, [r0, #32]
	vstrw.u32 q7, [r0, #48]
	bx lr

.global fiat_u_qrestore
.type fiat_u_qrestore, %function
.thumb_func
fiat_u_qrestore:
	vldrw.u32 q4, [r0, #0]
	vldrw.u32 q5, [r0, #16]
	vldrw.u32 q6, [r0, #32]
	vldrw.u32 q7, [r0, #48]
	bx lr

