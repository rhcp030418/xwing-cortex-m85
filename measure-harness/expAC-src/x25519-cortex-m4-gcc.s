	.syntax unified
	.thumb
// Curve25519 scalar multiplication
// Copyright (c) 2017, Emil Lenngren
//
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
//    list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form, except as embedded into a Nordic
//    Semiconductor ASA or Dialog Semiconductor PLC integrated circuit in a product
//    or a software update for such product, must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
// ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.



// This is an armv7 implementation of X25519.
// It follows the reference implementation where the representation of
// a field element [0..2^255-19) is represented by a 256-bit little ian integer,
// reduced modulo 2^256-38, and may possibly be in the range [2^256-38..2^256).
// The scalar is a 256-bit integer where certain bits are hardcoded per specification.
//
// The implementation runs in constant time (548 873 cycles on ARM Cortex-M4,
// assuming no wait states), and no conditional branches or memory access
// pattern dep on secret data.

	/* 측정 위생: ITCM 배치 (게이트_측정_계획서 §7) — keccakf1600.S와 동일 섹션 */
	.section .itcm_code_from_flash, "ax", %progbits
	.align 2

// input: *r8=a, *r9=b
// output: r0-r7
// clobbers all other registers
// cycles: 45
	.type fe25519_add, %function
fe25519_add:
	.global fe25519_add
	ldr r0,[r8,#28]
	ldr r4,[r9,#28]
	adds r0,r0,r4
	mov r11,#0
	adc r11,r11,r11
	lsl r11,r11,#1
	add r11,r11,r0, lsr #31
	movs r7,#19
	mul r11,r11,r7
	bic r7,r0,#0x80000000
	
	ldm r8!,{r0-r3}
	ldm r9!,{r4-r6,r10}
	mov r12,#1
	umaal r0,r11,r12,r4
	umaal r1,r11,r12,r5
	umaal r2,r11,r12,r6
	umaal r3,r11,r12,r10
	ldm r9,{r4-r6}
	ldm r8,{r8-r10}
	umaal r4,r11,r12,r8
	umaal r5,r11,r12,r9
	umaal r6,r11,r12,r10
	add r7,r7,r11
	bx lr
	
	.size fe25519_add, .-fe25519_add

// input: *r8=a, *r9=b
// output: r0-r7
// clobbers all other registers
// cycles: 46
	.type fe25519_sub, %function
fe25519_sub:
	.global fe25519_sub
	
	ldm r8,{r0-r7}
	ldm r9!,{r8,r10-r12}
	subs r0,r8
	sbcs r1,r10
	sbcs r2,r11
	sbcs r3,r12
	ldm r9,{r8-r11}
	sbcs r4,r8
	sbcs r5,r9
	sbcs r6,r10
	sbcs r7,r11
	
	// if subtraction goes below 0, set r8 to -1 and r9 to -38, else set both to 0
	sbc r8,r8
	and r9,r8,#-38
	
	adds r0,r9
	adcs r1,r8
	adcs r2,r8
	adcs r3,r8
	adcs r4,r8
	adcs r5,r8
	adcs r6,r8
	adcs r7,r8
	
	// if the subtraction did not go below 0, we are done and (r8,r9) are set to 0
	// if the subtraction went below 0 and the addition overflowed, we are done, so set (r8,r9) to 0
	// if the subtraction went below 0 and the addition did not overflow, we need to add once more
	// (r8,r9) will be correctly set to (-1,-38) only when r8 was -1 and we don't have a carry,
	// note that the carry will always be 0 in case (r8,r9) was (0,0) since then there was no real addition
	// also note that it is extremely unlikely we will need an extra addition:
	//   that can only happen if input1 was slightly >= 0 and input2 was > 2^256-38 (really input2-input1 > 2^256-38)
	//   in that case we currently have 2^256-38 < (r0...r7) < 2^256, so adding -38 will only affect r0
	adcs r8,#0
	and r9,r8,#-38
	
	adds r0,r9
	
	bx lr
	
	.size fe25519_sub, .-fe25519_sub

// input: *r1=a, *r2=b
// output: r0-r7
// clobbers all other registers
// cycles: 173
	.type fe25519_mul_scalar, %function
fe25519_mul_scalar:
	.global fe25519_mul_scalar
	push {r2,lr}
	//frame push {lr}
	//frame address sp,8
	
	sub sp,#28
	//frame address sp,36
	ldm r2,{r2,r3,r4,r5}
	
	ldm r1!,{r0,r10,lr}
	umull r6,r11,r2,r0
	
	umull r7,r12,r3,r0
	umaal r7,r11,r2,r10
	
	push {r6,r7}
	//frame address sp,44
	
	umull r8,r6,r4,r0
	umaal r8,r11,r3,r10
	
	umull r9,r7,r5,r0
	umaal r9,r11,r4,r10
	
	umaal r11,r7,r5,r10
	
	umaal r8,r12,r2,lr
	umaal r9,r12,r3,lr
	umaal r11,r12,r4,lr
	umaal r12,r7,r5,lr
	
	ldm r1!,{r0,r10,lr}
	
	umaal r9,r6,r2,r0
	umaal r11,r6,r3,r0
	umaal r12,r6,r4,r0
	umaal r6,r7,r5,r0
	
	strd r8,r9,[sp,#8]
	
	mov r9,#0
	umaal r11,r9,r2,r10
	umaal r12,r9,r3,r10
	umaal r6,r9,r4,r10
	umaal r7,r9,r5,r10
	
	mov r10,#0
	umaal r12,r10,r2,lr
	umaal r6,r10,r3,lr
	umaal r7,r10,r4,lr
	umaal r9,r10,r5,lr
	
	ldr r8,[r1],#4
	mov lr,#0
	umaal lr,r6,r2,r8
	umaal r7,r6,r3,r8
	umaal r9,r6,r4,r8
	umaal r10,r6,r5,r8
	
	//_ _ _ _ _ 6 10 9| 7 | lr 12 11 _ _ _ _
	
	ldr r8,[r1],#-28
	mov r0,#0
	umaal r7,r0,r2,r8
	umaal r9,r0,r3,r8
	umaal r10,r0,r4,r8
	umaal r6,r0,r5,r8
	
	push {r0}
	//frame address sp,48
	
	//_ _ _ _ s 6 10 9| 7 | lr 12 11 _ _ _ _
	
	ldr r2,[sp,#40]
	adds r2,r2,#16
	ldm r2,{r2,r3,r4,r5}
	
	ldr r8,[r1],#4
	mov r0,#0
	umaal r11,r0,r2,r8
	str r11,[sp,#16+4]
	umaal r12,r0,r3,r8
	umaal lr,r0,r4,r8
	umaal r0,r7,r5,r8 // 7=carry for 9
	
	//_ _ _ _ s 6 10 9+7| 0 | lr 12 _ _ _ _ _
	
	ldr r8,[r1],#4
	mov r11,#0
	umaal r12,r11,r2,r8
	str r12,[sp,#20+4]
	umaal lr,r11,r3,r8
	umaal r0,r11,r4,r8
	umaal r11,r7,r5,r8 // 7=carry for 10
	
	//_ _ _ _ s 6 10+7 9+11| 0 | lr _ _ _ _ _ _
	
	ldr r8,[r1],#4
	mov r12,#0
	umaal lr,r12,r2,r8
	str lr,[sp,#24+4]
	umaal r0,r12,r3,r8
	umaal r11,r12,r4,r8
	umaal r10,r12,r5,r8 // 12=carry for 6
	
	//_ _ _ _ s 6+12 10+7 9+11| 0 | _ _ _ _ _ _ _
	
	ldr r8,[r1],#4
	mov lr,#0
	umaal r0,lr,r2,r8
	str r0,[sp,#28+4]
	umaal r11,lr,r3,r8
	umaal r10,lr,r4,r8
	umaal r6,lr,r5,r8 // lr=carry for saved
	
	//_ _ _ _ s+lr 6+12 10+7 9+11| _ | _ _ _ _ _ _ _
	
	ldm r1!,{r0,r8}
	umaal r11,r9,r2,r0
	str r11,[sp,#32+4]
	umaal r9,r10,r3,r0
	umaal r10,r6,r4,r0
	pop {r11}
	//frame address sp,44
	umaal r11,r6,r5,r0 // 6=carry for next
	
	//_ _ _ 6 11+lr 10+12 9+7 _ | _ | _ _ _ _ _ _ _
	
	umaal r9,r7,r2,r8
	umaal r10,r7,r3,r8
	umaal r11,r7,r4,r8
	umaal r6,r7,r5,r8
	
	ldm r1!,{r0,r8}
	umaal r10,r12,r2,r0
	umaal r11,r12,r3,r0
	umaal r6,r12,r4,r0
	umaal r7,r12,r5,r0
	
	umaal r11,lr,r2,r8
	umaal r6,lr,r3,r8
	umaal lr,r7,r4,r8
	umaal r7,r12,r5,r8
	
	// 12 7 lr 6 11 10 9 stack*9
	
	//now reduce
	
	ldrd r4,r5,[sp,#28]
	movs r3,#38
	mov r8,#0
	umaal r4,r8,r3,r12
	lsl r8,r8,#1
	orr r8,r8,r4, lsr #31
	and r12,r4,#0x7fffffff
	movs r4,#19
	mul r8,r8,r4
	
	pop {r0-r2}
	//frame address sp,32
	umaal r0,r8,r3,r5
	umaal r1,r8,r3,r9
	umaal r2,r8,r3,r10
	mov r9,#38
	pop {r3,r4}
	//frame address sp,24
	umaal r3,r8,r9,r11
	umaal r4,r8,r9,r6
	pop {r5,r6}
	//frame address sp,16
	umaal r5,r8,r9,lr
	umaal r6,r8,r9,r7
	add r7,r8,r12
	
	add sp,#12
	//frame address sp,4
	pop {pc}
	
	.size fe25519_mul_scalar, .-fe25519_mul_scalar

// Experiment AC: arbitrary-operand X25519 field multiply dispatcher.
.global fe25519_mul
.type fe25519_mul, %function
.thumb_func
fe25519_mul:
	movw r12, #:lower16:g_u_active
	movt r12, #:upper16:g_u_active
	ldr r12, [r12]
	cmp r12, #0
	beq fe25519_mul_scalar
	movw r12, #:lower16:g_u_phase
	movt r12, #:upper16:g_u_phase
	ldr r12, [r12]
	cmp r12, #0
	beq fe25519_mul_u0
	cmp r12, #1
	beq fe25519_mul_u1
	cmp r12, #2
	beq fe25519_mul_u2
	cmp r12, #3
	beq fe25519_mul_u3
	cmp r12, #4
	beq fe25519_mul_u4
	cmp r12, #5
	beq fe25519_mul_u5
	cmp r12, #6
	beq fe25519_mul_u6
	b fe25519_mul_u7

.type fe25519_mul_u0, %function
.thumb_func
.balign 16
fe25519_mul_u0:
	movw r12, #:lower16:g_u_mve_block
	movt r12, #:upper16:g_u_mve_block
	ldr r12, [r12]
	movw r3, #:lower16:g_u_round
	movt r3, #:upper16:g_u_round
	ldr r3, [r3]
	movw r0, #:lower16:g_u_rc_even
	movt r0, #:upper16:g_u_rc_even
	ldr r0, [r0, r3, lsl #2]
	str r0, [r12, #400]
	str r0, [r12, #404]
	str r0, [r12, #408]
	str r0, [r12, #412]
	movw r0, #:lower16:g_u_rc_odd
	movt r0, #:upper16:g_u_rc_odd
	ldr r0, [r0, r3, lsl #2]
	str r0, [r12, #416]
	str r0, [r12, #420]
	str r0, [r12, #424]
	str r0, [r12, #428]
	adr r0, 9f
	vldrw.u32 q6, [r0]
	add r3, r12, #1524
	vadd.i32 q7, q6, r3
	add r3, r12, #508
	vadd.i32 q6, q6, r3
	b 10f
	.balign 16
9:	.word 0, 4, 8, 12
10:
	push {r2,lr}
	vldrw.u32 q0, [q6, #-508]
	sub sp,#28
	vldrw.u32 q1, [q6, #-428]
	ldm r2,{r2,r3,r4,r5}
	ldm r1!,{r0,r10,lr}
	veor q0, q0, q1
	umull r6,r11,r2,r0
	vldrw.u32 q1, [q6, #-348]
	umull r7,r12,r3,r0
	umaal r7,r11,r2,r10
	veor q0, q0, q1
	push {r6,r7}
	vldrw.u32 q1, [q6, #-268]
	umull r8,r6,r4,r0
	umaal r8,r11,r3,r10
	veor q0, q0, q1
	umull r9,r7,r5,r0
	vldrw.u32 q1, [q6, #-188]
	umaal r9,r11,r4,r10
	umaal r11,r7,r5,r10
	veor q0, q0, q1
	umaal r8,r12,r2,lr
	umaal r9,r12,r3,lr
	vstrw.u32 q0, [q7, #188]
	umaal r11,r12,r4,lr
	vldrw.u32 q0, [q6, #-492]
	umaal r12,r7,r5,lr
	ldm r1!,{r0,r10,lr}
	vldrw.u32 q1, [q6, #-412]
	umaal r9,r6,r2,r0
	veor q0, q0, q1
	umaal r11,r6,r3,r0
	umaal r12,r6,r4,r0
	vldrw.u32 q1, [q6, #-332]
	umaal r6,r7,r5,r0
	veor q0, q0, q1
	strd r8,r9,[sp,#8]
	mov r9,#0
	vldrw.u32 q1, [q6, #-252]
	umaal r11,r9,r2,r10
	umaal r12,r9,r3,r10
	veor q0, q0, q1
	umaal r6,r9,r4,r10
	vldrw.u32 q1, [q6, #-172]
	umaal r7,r9,r5,r10
	mov r10,#0
	veor q0, q0, q1
	umaal r12,r10,r2,lr
	vstrw.u32 q0, [q7, #204]
	umaal r6,r10,r3,lr
	umaal r7,r10,r4,lr
	vldrw.u32 q0, [q6, #-476]
	umaal r9,r10,r5,lr
	vldrw.u32 q1, [q6, #-396]
	ldr r8,[r1],#4
	mov lr,#0
	veor q0, q0, q1
	umaal lr,r6,r2,r8
	umaal r7,r6,r3,r8
	vldrw.u32 q1, [q6, #-316]
	umaal r9,r6,r4,r8
	veor q0, q0, q1
	umaal r10,r6,r5,r8
	ldr r8,[r1],#-28
	vldrw.u32 q1, [q6, #-236]
	mov r0,#0
	veor q0, q0, q1
	umaal r7,r0,r2,r8
	umaal r9,r0,r3,r8
	vldrw.u32 q1, [q6, #-156]
	umaal r10,r0,r4,r8
	veor q0, q0, q1
	umaal r6,r0,r5,r8
	push {r0}
	vstrw.u32 q0, [q7, #220]
	ldr r2,[sp,#40]
	vldrw.u32 q0, [q6, #-460]
	adds r2,r2,#16
	ldm r2,{r2,r3,r4,r5}
	vldrw.u32 q1, [q6, #-380]
	ldr r8,[r1],#4
	mov r0,#0
	veor q0, q0, q1
	umaal r11,r0,r2,r8
	vldrw.u32 q1, [q6, #-300]
	str r11,[sp,#16+4]
	umaal r12,r0,r3,r8
	veor q0, q0, q1
	umaal lr,r0,r4,r8
	vldrw.u32 q1, [q6, #-220]
	umaal r0,r7,r5,r8 // 7=carry for 9
	ldr r8,[r1],#4
	veor q0, q0, q1
	mov r11,#0
	vldrw.u32 q1, [q6, #-140]
	umaal r12,r11,r2,r8
	str r12,[sp,#20+4]
	veor q0, q0, q1
	umaal lr,r11,r3,r8
	umaal r0,r11,r4,r8
	vstrw.u32 q0, [q7, #236]
	umaal r11,r7,r5,r8 // 7=carry for 10
	vldrw.u32 q0, [q6, #-444]
	ldr r8,[r1],#4
	mov r12,#0
	vldrw.u32 q1, [q6, #-364]
	umaal lr,r12,r2,r8
	veor q0, q0, q1
	str lr,[sp,#24+4]
	umaal r0,r12,r3,r8
	vldrw.u32 q1, [q6, #-284]
	umaal r11,r12,r4,r8
	veor q0, q0, q1
	umaal r10,r12,r5,r8 // 12=carry for 6
	ldr r8,[r1],#4
	vldrw.u32 q1, [q6, #-204]
	mov lr,#0
	umaal r0,lr,r2,r8
	veor q0, q0, q1
	str r0,[sp,#28+4]
	vldrw.u32 q1, [q6, #-124]
	umaal r11,lr,r3,r8
	umaal r10,lr,r4,r8
	veor q0, q0, q1
	umaal r6,lr,r5,r8 // lr=carry for saved
	vstrw.u32 q0, [q7, #252]
	ldm r1!,{r0,r8}
	umaal r11,r9,r2,r0
	vldrw.u32 q0, [q6, #4]
	str r11,[sp,#32+4]
	vldrw.u32 q1, [q6, #84]
	umaal r9,r10,r3,r0
	umaal r10,r6,r4,r0
	veor q0, q0, q1
	pop {r11}
	vldrw.u32 q1, [q6, #164]
	umaal r11,r6,r5,r0 // 6=carry for next
	umaal r9,r7,r2,r8
	veor q0, q0, q1
	umaal r10,r7,r3,r8
	umaal r11,r7,r4,r8
	vldrw.u32 q1, [q6, #244]
	umaal r6,r7,r5,r8
	veor q0, q0, q1
	ldm r1!,{r0,r8}
	umaal r10,r12,r2,r0
	vldrw.u32 q1, [q6, #324]
	umaal r11,r12,r3,r0
	veor q0, q0, q1
	umaal r6,r12,r4,r0
	umaal r7,r12,r5,r0
	vstrw.u32 q0, [q7, #268]
	umaal r11,lr,r2,r8
	vldrw.u32 q0, [q6, #20]
	umaal r6,lr,r3,r8
	umaal lr,r7,r4,r8
	vldrw.u32 q1, [q6, #100]
	umaal r7,r12,r5,r8
	ldrd r4,r5,[sp,#28]
	veor q0, q0, q1
	movs r3,#38
	vldrw.u32 q1, [q6, #180]
	mov r8,#0
	umaal r4,r8,r3,r12
	veor q0, q0, q1
	lsl r8,r8,#1
	vldrw.u32 q1, [q6, #260]
	orr r8,r8,r4, lsr #31
	and r12,r4,#0x7fffffff
	veor q0, q0, q1
	movs r4,#19
	vldrw.u32 q1, [q6, #340]
	mul r8,r8,r4
	pop {r0-r2}
	veor q0, q0, q1
	umaal r0,r8,r3,r5
	umaal r1,r8,r3,r9
	vstrw.u32 q0, [q7, #284]
	umaal r2,r8,r3,r10
	vldrw.u32 q0, [q6, #36]
	mov r9,#38
	pop {r3,r4}
	vldrw.u32 q1, [q6, #116]
	umaal r3,r8,r9,r11
	veor q0, q0, q1
	umaal r4,r8,r9,r6
	pop {r5,r6}
	vldrw.u32 q1, [q6, #196]
	umaal r5,r8,r9,lr
	veor q0, q0, q1
	umaal r6,r8,r9,r7
	add r7,r8,r12
	vldrw.u32 q1, [q6, #276]
	add sp,#12
	ldr lr, [sp], #4
	push {r0-r7, lr}
	movw r12, #:lower16:g_u_phase
	movt r12, #:upper16:g_u_phase
	mov r0, #1
	str r0, [r12]
	pop {r0-r7, lr}
	bx lr

.type fe25519_mul_u1, %function
.thumb_func
.balign 16
fe25519_mul_u1:
	push {r2,lr}
	veor q0, q0, q1
	sub sp,#28
	vldrw.u32 q1, [q6, #356]
	ldm r2,{r2,r3,r4,r5}
	ldm r1!,{r0,r10,lr}
	veor q0, q0, q1
	umull r6,r11,r2,r0
	vstrw.u32 q0, [q7, #300]
	umull r7,r12,r3,r0
	umaal r7,r11,r2,r10
	vldrw.u32 q0, [q6, #52]
	push {r6,r7}
	vldrw.u32 q1, [q6, #132]
	umull r8,r6,r4,r0
	umaal r8,r11,r3,r10
	veor q0, q0, q1
	umull r9,r7,r5,r0
	vldrw.u32 q1, [q6, #212]
	umaal r9,r11,r4,r10
	umaal r11,r7,r5,r10
	veor q0, q0, q1
	umaal r8,r12,r2,lr
	vldrw.u32 q1, [q6, #292]
	umaal r9,r12,r3,lr
	umaal r11,r12,r4,lr
	veor q0, q0, q1
	umaal r12,r7,r5,lr
	ldm r1!,{r0,r10,lr}
	vldrw.u32 q1, [q6, #372]
	umaal r9,r6,r2,r0
	veor q0, q0, q1
	umaal r11,r6,r3,r0
	umaal r12,r6,r4,r0
	vstrw.u32 q0, [q7, #316]
	umaal r6,r7,r5,r0
	vldrw.u32 q0, [q6, #68]
	strd r8,r9,[sp,#8]
	mov r9,#0
	vldrw.u32 q1, [q6, #148]
	umaal r11,r9,r2,r10
	veor q0, q0, q1
	umaal r12,r9,r3,r10
	umaal r6,r9,r4,r10
	vldrw.u32 q1, [q6, #228]
	umaal r7,r9,r5,r10
	veor q0, q0, q1
	mov r10,#0
	umaal r12,r10,r2,lr
	vldrw.u32 q1, [q6, #308]
	umaal r6,r10,r3,lr
	veor q0, q0, q1
	umaal r7,r10,r4,lr
	umaal r9,r10,r5,lr
	vldrw.u32 q1, [q6, #388]
	ldr r8,[r1],#4
	mov lr,#0
	veor q0, q0, q1
	umaal lr,r6,r2,r8
	vstrw.u32 q0, [q7, #332]
	umaal r7,r6,r3,r8
	umaal r9,r6,r4,r8
	vldrw.u32 q0, [q7, #284]
	umaal r10,r6,r5,r8
	vshl.i32 q1, q0, #1
	ldr r8,[r1],#-28
	mov r0,#0
	vsri.32 q1, q0, #31
	umaal r7,r0,r2,r8
	vldrw.u32 q2, [q7, #252]
	umaal r9,r0,r3,r8
	umaal r10,r0,r4,r8
	veor q1, q1, q2
	umaal r6,r0,r5,r8
	vstrw.u32 q1, [q7, #348]
	push {r0}
	ldr r2,[sp,#40]
	vldrw.u32 q0, [q7, #204]
	adds r2,r2,#16
	vldrw.u32 q2, [q7, #332]
	ldm r2,{r2,r3,r4,r5}
	ldr r8,[r1],#4
	veor q0, q0, q2
	mov r0,#0
	umaal r11,r0,r2,r8
	vstrw.u32 q0, [q7, #428]
	str r11,[sp,#16+4]
	vldrw.u32 q0, [q7, #300]
	umaal r12,r0,r3,r8
	umaal lr,r0,r4,r8
	vshl.i32 q1, q0, #1
	umaal r0,r7,r5,r8 // 7=carry for 9
	vsri.32 q1, q0, #31
	ldr r8,[r1],#4
	mov r11,#0
	vldrw.u32 q2, [q7, #188]
	umaal r12,r11,r2,r8
	veor q1, q1, q2
	str r12,[sp,#20+4]
	umaal lr,r11,r3,r8
	vstrw.u32 q1, [q7, #364]
	umaal r0,r11,r4,r8
	vldrw.u32 q0, [q7, #220]
	umaal r11,r7,r5,r8 // 7=carry for 10
	ldr r8,[r1],#4
	vldrw.u32 q2, [q7, #268]
	mov r12,#0
	veor q0, q0, q2
	umaal lr,r12,r2,r8
	str lr,[sp,#24+4]
	vstrw.u32 q0, [q7, #444]
	umaal r0,r12,r3,r8
	umaal r11,r12,r4,r8
	vldrw.u32 q0, [q7, #316]
	umaal r10,r12,r5,r8 // 12=carry for 6
	vshl.i32 q1, q0, #1
	ldr r8,[r1],#4
	mov lr,#0
	vsri.32 q1, q0, #31
	umaal r0,lr,r2,r8
	vldrw.u32 q2, [q7, #204]
	str r0,[sp,#28+4]
	umaal r11,lr,r3,r8
	veor q1, q1, q2
	umaal r10,lr,r4,r8
	vstrw.u32 q1, [q7, #380]
	umaal r6,lr,r5,r8 // lr=carry for saved
	ldm r1!,{r0,r8}
	vldrw.u32 q0, [q7, #236]
	umaal r11,r9,r2,r0
	vldrw.u32 q2, [q7, #284]
	str r11,[sp,#32+4]
	umaal r9,r10,r3,r0
	veor q0, q0, q2
	umaal r10,r6,r4,r0
	vstrw.u32 q0, [q7, #460]
	pop {r11}
	umaal r11,r6,r5,r0 // 6=carry for next
	vldrw.u32 q0, [q7, #332]
	umaal r9,r7,r2,r8
	umaal r10,r7,r3,r8
	vshl.i32 q1, q0, #1
	umaal r11,r7,r4,r8
	vsri.32 q1, q0, #31
	umaal r6,r7,r5,r8
	ldm r1!,{r0,r8}
	vldrw.u32 q2, [q7, #220]
	umaal r10,r12,r2,r0
	veor q1, q1, q2
	umaal r11,r12,r3,r0
	umaal r6,r12,r4,r0
	vstrw.u32 q1, [q7, #396]
	umaal r7,r12,r5,r0
	vldrw.u32 q0, [q7, #252]
	umaal r11,lr,r2,r8
	umaal r6,lr,r3,r8
	vldrw.u32 q2, [q7, #300]
	umaal lr,r7,r4,r8
	veor q0, q0, q2
	umaal r7,r12,r5,r8
	ldrd r4,r5,[sp,#28]
	vstrw.u32 q0, [q7, #476]
	movs r3,#38
	vldrw.u32 q0, [q7, #268]
	mov r8,#0
	umaal r4,r8,r3,r12
	vshl.i32 q1, q0, #1
	lsl r8,r8,#1
	orr r8,r8,r4, lsr #31
	vsri.32 q1, q0, #31
	and r12,r4,#0x7fffffff
	vldrw.u32 q2, [q7, #236]
	movs r4,#19
	mul r8,r8,r4
	veor q1, q1, q2
	pop {r0-r2}
	vstrw.u32 q1, [q7, #412]
	umaal r0,r8,r3,r5
	umaal r1,r8,r3,r9
	vldrw.u32 q0, [q7, #188]
	umaal r2,r8,r3,r10
	vldrw.u32 q2, [q7, #316]
	mov r9,#38
	pop {r3,r4}
	veor q0, q0, q2
	umaal r3,r8,r9,r11
	vstrw.u32 q0, [q7, #492]
	umaal r4,r8,r9,r6
	pop {r5,r6}
	vldrw.u32 q3, [q7, #348]
	umaal r5,r8,r9,lr
	vldrw.u32 q4, [q7, #428]
	umaal r6,r8,r9,r7
	add r7,r8,r12
	vldrw.u32 q0, [q6, #-508]
	add sp,#12
	ldr lr, [sp], #4
	push {r0-r7, lr}
	movw r12, #:lower16:g_u_phase
	movt r12, #:upper16:g_u_phase
	mov r0, #2
	str r0, [r12]
	pop {r0-r7, lr}
	bx lr

.type fe25519_mul_u2, %function
.thumb_func
.balign 16
fe25519_mul_u2:
	push {r2,lr}
	vldrw.u32 q1, [q6, #4]
	sub sp,#28
	veor q0, q0, q3
	ldm r2,{r2,r3,r4,r5}
	ldm r1!,{r0,r10,lr}
	veor q1, q1, q4
	umull r6,r11,r2,r0
	vorr q2, q0, q0
	umull r7,r12,r3,r0
	umaal r7,r11,r2,r10
	vstrw.u32 q2, [q6, #404]
	push {r6,r7}
	vorr q5, q1, q1
	umull r8,r6,r4,r0
	umaal r8,r11,r3,r10
	vstrw.u32 q5, [q7, #-212]
	umull r9,r7,r5,r0
	vldrw.u32 q0, [q6, #-428]
	umaal r9,r11,r4,r10
	umaal r11,r7,r5,r10
	vldrw.u32 q1, [q6, #84]
	umaal r8,r12,r2,lr
	veor q0, q0, q3
	umaal r9,r12,r3,lr
	umaal r11,r12,r4,lr
	veor q1, q1, q4
	umaal r12,r7,r5,lr
	ldm r1!,{r0,r10,lr}
	vshl.i32 q2, q0, #18
	umaal r9,r6,r2,r0
	vsri.32 q2, q0, #14
	umaal r11,r6,r3,r0
	umaal r12,r6,r4,r0
	vstrw.u32 q2, [q7, #-356]
	umaal r6,r7,r5,r0
	vshl.i32 q5, q1, #18
	strd r8,r9,[sp,#8]
	mov r9,#0
	vsri.32 q5, q1, #14
	umaal r11,r9,r2,r10
	vstrw.u32 q5, [q7, #44]
	umaal r12,r9,r3,r10
	umaal r6,r9,r4,r10
	vldrw.u32 q0, [q6, #-348]
	umaal r7,r9,r5,r10
	vldrw.u32 q1, [q6, #164]
	mov r10,#0
	umaal r12,r10,r2,lr
	veor q0, q0, q3
	umaal r6,r10,r3,lr
	veor q1, q1, q4
	umaal r7,r10,r4,lr
	umaal r9,r10,r5,lr
	vshl.i32 q2, q1, #2
	ldr r8,[r1],#4
	mov lr,#0
	vsri.32 q2, q1, #30
	umaal lr,r6,r2,r8
	vstrw.u32 q2, [q7, #-500]
	umaal r7,r6,r3,r8
	umaal r9,r6,r4,r8
	vshl.i32 q5, q0, #1
	umaal r10,r6,r5,r8
	vsri.32 q5, q0, #31
	ldr r8,[r1],#-28
	mov r0,#0
	vstrw.u32 q5, [q7, #-100]
	umaal r7,r0,r2,r8
	vldrw.u32 q0, [q6, #-268]
	umaal r9,r0,r3,r8
	umaal r10,r0,r4,r8
	vldrw.u32 q1, [q6, #244]
	umaal r6,r0,r5,r8
	veor q0, q0, q3
	push {r0}
	ldr r2,[sp,#40]
	veor q1, q1, q4
	adds r2,r2,#16
	vshl.i32 q2, q1, #21
	ldm r2,{r2,r3,r4,r5}
	ldr r8,[r1],#4
	vsri.32 q2, q1, #11
	mov r0,#0
	umaal r11,r0,r2,r8
	vstrw.u32 q2, [q7, #-244]
	str r11,[sp,#16+4]
	vshl.i32 q5, q0, #20
	umaal r12,r0,r3,r8
	umaal lr,r0,r4,r8
	vsri.32 q5, q0, #12
	umaal r0,r7,r5,r8 // 7=carry for 9
	vstrw.u32 q5, [q7, #156]
	ldr r8,[r1],#4
	mov r11,#0
	vldrw.u32 q0, [q6, #-188]
	umaal r12,r11,r2,r8
	vldrw.u32 q1, [q6, #324]
	str r12,[sp,#20+4]
	umaal lr,r11,r3,r8
	veor q0, q0, q3
	umaal r0,r11,r4,r8
	veor q1, q1, q4
	umaal r11,r7,r5,r8 // 7=carry for 10
	ldr r8,[r1],#4
	vshl.i32 q2, q0, #9
	mov r12,#0
	vsri.32 q2, q0, #23
	umaal lr,r12,r2,r8
	str lr,[sp,#24+4]
	vstrw.u32 q2, [q7, #-388]
	umaal r0,r12,r3,r8
	umaal r11,r12,r4,r8
	vshl.i32 q5, q1, #9
	umaal r10,r12,r5,r8 // 12=carry for 6
	vsri.32 q5, q1, #23
	ldr r8,[r1],#4
	mov lr,#0
	vstrw.u32 q5, [q7, #12]
	umaal r0,lr,r2,r8
	vldrw.u32 q3, [q7, #364]
	str r0,[sp,#28+4]
	umaal r11,lr,r3,r8
	vldrw.u32 q4, [q7, #444]
	umaal r10,lr,r4,r8
	vldrw.u32 q0, [q6, #-492]
	umaal r6,lr,r5,r8 // lr=carry for saved
	ldm r1!,{r0,r8}
	vldrw.u32 q1, [q6, #20]
	umaal r11,r9,r2,r0
	veor q0, q0, q3
	str r11,[sp,#32+4]
	umaal r9,r10,r3,r0
	veor q1, q1, q4
	umaal r10,r6,r4,r0
	vshl.i32 q2, q1, #1
	pop {r11}
	umaal r11,r6,r5,r0 // 6=carry for next
	vsri.32 q2, q1, #31
	umaal r9,r7,r2,r8
	umaal r10,r7,r3,r8
	vstrw.u32 q2, [q7, #-452]
	umaal r11,r7,r4,r8
	vorr q5, q0, q0
	umaal r6,r7,r5,r8
	ldm r1!,{r0,r8}
	vstrw.u32 q5, [q7, #-52]
	umaal r10,r12,r2,r0
	vldrw.u32 q0, [q6, #-412]
	umaal r11,r12,r3,r0
	umaal r6,r12,r4,r0
	vldrw.u32 q1, [q6, #100]
	umaal r7,r12,r5,r0
	veor q0, q0, q3
	umaal r11,lr,r2,r8
	umaal r6,lr,r3,r8
	veor q1, q1, q4
	umaal lr,r7,r4,r8
	vshl.i32 q2, q0, #22
	umaal r7,r12,r5,r8
	ldrd r4,r5,[sp,#28]
	vsri.32 q2, q0, #10
	movs r3,#38
	vstrw.u32 q2, [q6, #420]
	mov r8,#0
	umaal r4,r8,r3,r12
	vshl.i32 q5, q1, #22
	lsl r8,r8,#1
	orr r8,r8,r4, lsr #31
	vsri.32 q5, q1, #10
	and r12,r4,#0x7fffffff
	vstrw.u32 q5, [q7, #-196]
	movs r4,#19
	mul r8,r8,r4
	vldrw.u32 q0, [q6, #-332]
	pop {r0-r2}
	vldrw.u32 q1, [q6, #180]
	umaal r0,r8,r3,r5
	umaal r1,r8,r3,r9
	veor q0, q0, q3
	umaal r2,r8,r3,r10
	veor q1, q1, q4
	mov r9,#38
	pop {r3,r4}
	vshl.i32 q2, q0, #5
	umaal r3,r8,r9,r11
	vsri.32 q2, q0, #27
	umaal r4,r8,r9,r6
	pop {r5,r6}
	vstrw.u32 q2, [q7, #-340]
	umaal r5,r8,r9,lr
	vshl.i32 q5, q1, #5
	umaal r6,r8,r9,r7
	add r7,r8,r12
	vsri.32 q5, q1, #27
	add sp,#12
	ldr lr, [sp], #4
	push {r0-r7, lr}
	movw r12, #:lower16:g_u_phase
	movt r12, #:upper16:g_u_phase
	mov r0, #3
	str r0, [r12]
	pop {r0-r7, lr}
	bx lr

.type fe25519_mul_u3, %function
.thumb_func
.balign 16
fe25519_mul_u3:
	push {r2,lr}
	vstrw.u32 q5, [q7, #60]
	sub sp,#28
	vldrw.u32 q0, [q6, #-252]
	ldm r2,{r2,r3,r4,r5}
	ldm r1!,{r0,r10,lr}
	vldrw.u32 q1, [q6, #260]
	umull r6,r11,r2,r0
	veor q0, q0, q3
	umull r7,r12,r3,r0
	umaal r7,r11,r2,r10
	veor q1, q1, q4
	push {r6,r7}
	vshl.i32 q2, q1, #23
	umull r8,r6,r4,r0
	umaal r8,r11,r3,r10
	vsri.32 q2, q1, #9
	umull r9,r7,r5,r0
	vstrw.u32 q2, [q7, #-484]
	umaal r9,r11,r4,r10
	umaal r11,r7,r5,r10
	vshl.i32 q5, q0, #22
	umaal r8,r12,r2,lr
	vsri.32 q5, q0, #10
	umaal r9,r12,r3,lr
	umaal r11,r12,r4,lr
	vstrw.u32 q5, [q7, #-84]
	umaal r12,r7,r5,lr
	ldm r1!,{r0,r10,lr}
	vldrw.u32 q0, [q6, #-172]
	umaal r9,r6,r2,r0
	vldrw.u32 q1, [q6, #340]
	umaal r11,r6,r3,r0
	umaal r12,r6,r4,r0
	veor q0, q0, q3
	umaal r6,r7,r5,r0
	veor q1, q1, q4
	strd r8,r9,[sp,#8]
	mov r9,#0
	vshl.i32 q2, q0, #1
	umaal r11,r9,r2,r10
	vsri.32 q2, q0, #31
	umaal r12,r9,r3,r10
	umaal r6,r9,r4,r10
	vstrw.u32 q2, [q7, #-228]
	umaal r7,r9,r5,r10
	vshl.i32 q5, q1, #1
	mov r10,#0
	umaal r12,r10,r2,lr
	vsri.32 q5, q1, #31
	umaal r6,r10,r3,lr
	vstrw.u32 q5, [q7, #172]
	umaal r7,r10,r4,lr
	umaal r9,r10,r5,lr
	vldrw.u32 q3, [q7, #380]
	ldr r8,[r1],#4
	mov lr,#0
	vldrw.u32 q4, [q7, #460]
	umaal lr,r6,r2,r8
	vldrw.u32 q0, [q6, #-476]
	umaal r7,r6,r3,r8
	umaal r9,r6,r4,r8
	vldrw.u32 q1, [q6, #36]
	umaal r10,r6,r5,r8
	veor q0, q0, q3
	ldr r8,[r1],#-28
	mov r0,#0
	veor q1, q1, q4
	umaal r7,r0,r2,r8
	vshl.i32 q2, q0, #31
	umaal r9,r0,r3,r8
	umaal r10,r0,r4,r8
	vsri.32 q2, q0, #1
	umaal r6,r0,r5,r8
	vstrw.u32 q2, [q7, #-292]
	push {r0}
	ldr r2,[sp,#40]
	vshl.i32 q5, q1, #31
	adds r2,r2,#16
	vsri.32 q5, q1, #1
	ldm r2,{r2,r3,r4,r5}
	ldr r8,[r1],#4
	vstrw.u32 q5, [q7, #108]
	mov r0,#0
	umaal r11,r0,r2,r8
	vldrw.u32 q0, [q6, #-396]
	str r11,[sp,#16+4]
	vldrw.u32 q1, [q6, #116]
	umaal r12,r0,r3,r8
	umaal lr,r0,r4,r8
	veor q0, q0, q3
	umaal r0,r7,r5,r8 // 7=carry for 9
	veor q1, q1, q4
	ldr r8,[r1],#4
	mov r11,#0
	vshl.i32 q2, q0, #3
	umaal r12,r11,r2,r8
	vsri.32 q2, q0, #29
	str r12,[sp,#20+4]
	umaal lr,r11,r3,r8
	vstrw.u32 q2, [q7, #-436]
	umaal r0,r11,r4,r8
	vshl.i32 q5, q1, #3
	umaal r11,r7,r5,r8 // 7=carry for 10
	ldr r8,[r1],#4
	vsri.32 q5, q1, #29
	mov r12,#0
	vstrw.u32 q5, [q7, #-36]
	umaal lr,r12,r2,r8
	str lr,[sp,#24+4]
	vldrw.u32 q0, [q6, #-316]
	umaal r0,r12,r3,r8
	umaal r11,r12,r4,r8
	vldrw.u32 q1, [q6, #196]
	umaal r10,r12,r5,r8 // 12=carry for 6
	veor q0, q0, q3
	ldr r8,[r1],#4
	mov lr,#0
	veor q1, q1, q4
	umaal r0,lr,r2,r8
	vshl.i32 q2, q1, #22
	str r0,[sp,#28+4]
	umaal r11,lr,r3,r8
	vsri.32 q2, q1, #10
	umaal r10,lr,r4,r8
	vstrw.u32 q2, [q6, #436]
	umaal r6,lr,r5,r8 // lr=carry for saved
	ldm r1!,{r0,r8}
	vshl.i32 q5, q0, #21
	umaal r11,r9,r2,r0
	vsri.32 q5, q0, #11
	str r11,[sp,#32+4]
	umaal r9,r10,r3,r0
	vstrw.u32 q5, [q7, #-180]
	umaal r10,r6,r4,r0
	vldrw.u32 q0, [q6, #-236]
	pop {r11}
	umaal r11,r6,r5,r0 // 6=carry for next
	vldrw.u32 q1, [q6, #276]
	umaal r9,r7,r2,r8
	umaal r10,r7,r3,r8
	veor q0, q0, q3
	umaal r11,r7,r4,r8
	veor q1, q1, q4
	umaal r6,r7,r5,r8
	ldm r1!,{r0,r8}
	vshl.i32 q2, q1, #8
	umaal r10,r12,r2,r0
	vsri.32 q2, q1, #24
	umaal r11,r12,r3,r0
	umaal r6,r12,r4,r0
	vstrw.u32 q2, [q7, #-324]
	umaal r7,r12,r5,r0
	vshl.i32 q5, q0, #7
	umaal r11,lr,r2,r8
	umaal r6,lr,r3,r8
	vsri.32 q5, q0, #25
	umaal lr,r7,r4,r8
	vstrw.u32 q5, [q7, #76]
	umaal r7,r12,r5,r8
	ldrd r4,r5,[sp,#28]
	vldrw.u32 q0, [q6, #-156]
	movs r3,#38
	vldrw.u32 q1, [q6, #356]
	mov r8,#0
	umaal r4,r8,r3,r12
	veor q0, q0, q3
	lsl r8,r8,#1
	orr r8,r8,r4, lsr #31
	veor q1, q1, q4
	and r12,r4,#0x7fffffff
	vshl.i32 q2, q1, #31
	movs r4,#19
	mul r8,r8,r4
	vsri.32 q2, q1, #1
	pop {r0-r2}
	vstrw.u32 q2, [q7, #-468]
	umaal r0,r8,r3,r5
	umaal r1,r8,r3,r9
	vshl.i32 q5, q0, #30
	umaal r2,r8,r3,r10
	vsri.32 q5, q0, #2
	mov r9,#38
	pop {r3,r4}
	vstrw.u32 q5, [q7, #-68]
	umaal r3,r8,r9,r11
	vldrw.u32 q3, [q7, #396]
	umaal r4,r8,r9,r6
	pop {r5,r6}
	vldrw.u32 q4, [q7, #476]
	umaal r5,r8,r9,lr
	vldrw.u32 q0, [q6, #-460]
	umaal r6,r8,r9,r7
	add r7,r8,r12
	vldrw.u32 q1, [q6, #52]
	add sp,#12
	ldr lr, [sp], #4
	push {r0-r7, lr}
	movw r12, #:lower16:g_u_phase
	movt r12, #:upper16:g_u_phase
	mov r0, #4
	str r0, [r12]
	pop {r0-r7, lr}
	bx lr

.type fe25519_mul_u4, %function
.thumb_func
.balign 16
fe25519_mul_u4:
	push {r2,lr}
	veor q0, q0, q3
	sub sp,#28
	veor q1, q1, q4
	ldm r2,{r2,r3,r4,r5}
	ldm r1!,{r0,r10,lr}
	vshl.i32 q2, q0, #14
	umull r6,r11,r2,r0
	vsri.32 q2, q0, #18
	umull r7,r12,r3,r0
	umaal r7,r11,r2,r10
	vstrw.u32 q2, [q6, #484]
	push {r6,r7}
	vshl.i32 q5, q1, #14
	umull r8,r6,r4,r0
	umaal r8,r11,r3,r10
	vsri.32 q5, q1, #18
	umull r9,r7,r5,r0
	vstrw.u32 q5, [q7, #-132]
	umaal r9,r11,r4,r10
	umaal r11,r7,r5,r10
	vldrw.u32 q0, [q6, #-380]
	umaal r8,r12,r2,lr
	vldrw.u32 q1, [q6, #132]
	umaal r9,r12,r3,lr
	umaal r11,r12,r4,lr
	veor q0, q0, q3
	umaal r12,r7,r5,lr
	ldm r1!,{r0,r10,lr}
	veor q1, q1, q4
	umaal r9,r6,r2,r0
	vshl.i32 q2, q1, #28
	umaal r11,r6,r3,r0
	umaal r12,r6,r4,r0
	vsri.32 q2, q1, #4
	umaal r6,r7,r5,r0
	vstrw.u32 q2, [q7, #-276]
	strd r8,r9,[sp,#8]
	mov r9,#0
	vshl.i32 q5, q0, #27
	umaal r11,r9,r2,r10
	vsri.32 q5, q0, #5
	umaal r12,r9,r3,r10
	umaal r6,r9,r4,r10
	vstrw.u32 q5, [q7, #124]
	umaal r7,r9,r5,r10
	vldrw.u32 q0, [q6, #-300]
	mov r10,#0
	umaal r12,r10,r2,lr
	vldrw.u32 q1, [q6, #212]
	umaal r6,r10,r3,lr
	veor q0, q0, q3
	umaal r7,r10,r4,lr
	umaal r9,r10,r5,lr
	veor q1, q1, q4
	ldr r8,[r1],#4
	mov lr,#0
	vshl.i32 q2, q1, #13
	umaal lr,r6,r2,r8
	vsri.32 q2, q1, #19
	umaal r7,r6,r3,r8
	umaal r9,r6,r4,r8
	vstrw.u32 q2, [q7, #-420]
	umaal r10,r6,r5,r8
	vshl.i32 q5, q0, #12
	ldr r8,[r1],#-28
	mov r0,#0
	vsri.32 q5, q0, #20
	umaal r7,r0,r2,r8
	vstrw.u32 q5, [q7, #-20]
	umaal r9,r0,r3,r8
	umaal r10,r0,r4,r8
	vldrw.u32 q0, [q6, #-220]
	umaal r6,r0,r5,r8
	vldrw.u32 q1, [q6, #292]
	push {r0}
	ldr r2,[sp,#40]
	veor q0, q0, q3
	adds r2,r2,#16
	veor q1, q1, q4
	ldm r2,{r2,r3,r4,r5}
	ldr r8,[r1],#4
	vshl.i32 q2, q1, #11
	mov r0,#0
	umaal r11,r0,r2,r8
	vsri.32 q2, q1, #21
	str r11,[sp,#16+4]
	vstrw.u32 q2, [q6, #452]
	umaal r12,r0,r3,r8
	umaal lr,r0,r4,r8
	vshl.i32 q5, q0, #10
	umaal r0,r7,r5,r8 // 7=carry for 9
	vsri.32 q5, q0, #22
	ldr r8,[r1],#4
	mov r11,#0
	vstrw.u32 q5, [q7, #-164]
	umaal r12,r11,r2,r8
	vldrw.u32 q0, [q6, #-140]
	str r12,[sp,#20+4]
	umaal lr,r11,r3,r8
	vldrw.u32 q1, [q6, #372]
	umaal r0,r11,r4,r8
	veor q0, q0, q3
	umaal r11,r7,r5,r8 // 7=carry for 10
	ldr r8,[r1],#4
	veor q1, q1, q4
	mov r12,#0
	vshl.i32 q2, q0, #28
	umaal lr,r12,r2,r8
	str lr,[sp,#24+4]
	vsri.32 q2, q0, #4
	umaal r0,r12,r3,r8
	umaal r11,r12,r4,r8
	vstrw.u32 q2, [q7, #-308]
	umaal r10,r12,r5,r8 // 12=carry for 6
	vshl.i32 q5, q1, #28
	ldr r8,[r1],#4
	mov lr,#0
	vsri.32 q5, q1, #4
	umaal r0,lr,r2,r8
	vstrw.u32 q5, [q7, #92]
	str r0,[sp,#28+4]
	umaal r11,lr,r3,r8
	vldrw.u32 q3, [q7, #412]
	umaal r10,lr,r4,r8
	vldrw.u32 q4, [q7, #492]
	umaal r6,lr,r5,r8 // lr=carry for saved
	ldm r1!,{r0,r8}
	vldrw.u32 q0, [q6, #-444]
	umaal r11,r9,r2,r0
	vldrw.u32 q1, [q6, #68]
	str r11,[sp,#32+4]
	umaal r9,r10,r3,r0
	veor q0, q0, q3
	umaal r10,r6,r4,r0
	veor q1, q1, q4
	pop {r11}
	umaal r11,r6,r5,r0 // 6=carry for next
	vshl.i32 q2, q1, #14
	umaal r9,r7,r2,r8
	umaal r10,r7,r3,r8
	vsri.32 q2, q1, #18
	umaal r11,r7,r4,r8
	vstrw.u32 q2, [q7, #-372]
	umaal r6,r7,r5,r8
	ldm r1!,{r0,r8}
	vshl.i32 q5, q0, #13
	umaal r10,r12,r2,r0
	vsri.32 q5, q0, #19
	umaal r11,r12,r3,r0
	umaal r6,r12,r4,r0
	vstrw.u32 q5, [q7, #28]
	umaal r7,r12,r5,r0
	vldrw.u32 q0, [q6, #-364]
	umaal r11,lr,r2,r8
	umaal r6,lr,r3,r8
	vldrw.u32 q1, [q6, #148]
	umaal lr,r7,r4,r8
	veor q0, q0, q3
	umaal r7,r12,r5,r8
	ldrd r4,r5,[sp,#28]
	veor q1, q1, q4
	movs r3,#38
	vshl.i32 q2, q0, #10
	mov r8,#0
	umaal r4,r8,r3,r12
	vsri.32 q2, q0, #22
	lsl r8,r8,#1
	orr r8,r8,r4, lsr #31
	vstrw.u32 q2, [q6, #500]
	and r12,r4,#0x7fffffff
	vshl.i32 q5, q1, #10
	movs r4,#19
	mul r8,r8,r4
	vsri.32 q5, q1, #22
	pop {r0-r2}
	vstrw.u32 q5, [q7, #-116]
	umaal r0,r8,r3,r5
	umaal r1,r8,r3,r9
	vldrw.u32 q0, [q6, #-284]
	umaal r2,r8,r3,r10
	vldrw.u32 q1, [q6, #228]
	mov r9,#38
	pop {r3,r4}
	veor q0, q0, q3
	umaal r3,r8,r9,r11
	veor q1, q1, q4
	umaal r4,r8,r9,r6
	pop {r5,r6}
	vshl.i32 q2, q1, #20
	umaal r5,r8,r9,lr
	vsri.32 q2, q1, #12
	umaal r6,r8,r9,r7
	add r7,r8,r12
	vstrw.u32 q2, [q7, #-260]
	add sp,#12
	ldr lr, [sp], #4
	push {r0-r7, lr}
	movw r12, #:lower16:g_u_phase
	movt r12, #:upper16:g_u_phase
	mov r0, #5
	str r0, [r12]
	pop {r0-r7, lr}
	bx lr

.type fe25519_mul_u5, %function
.thumb_func
.balign 16
fe25519_mul_u5:
	push {r2,lr}
	vshl.i32 q5, q0, #19
	sub sp,#28
	vsri.32 q5, q0, #13
	ldm r2,{r2,r3,r4,r5}
	ldm r1!,{r0,r10,lr}
	vstrw.u32 q5, [q7, #140]
	umull r6,r11,r2,r0
	vldrw.u32 q0, [q6, #-204]
	umull r7,r12,r3,r0
	umaal r7,r11,r2,r10
	vldrw.u32 q1, [q6, #308]
	push {r6,r7}
	veor q0, q0, q3
	umull r8,r6,r4,r0
	umaal r8,r11,r3,r10
	veor q1, q1, q4
	umull r9,r7,r5,r0
	vshl.i32 q2, q0, #4
	umaal r9,r11,r4,r10
	umaal r11,r7,r5,r10
	vsri.32 q2, q0, #28
	umaal r8,r12,r2,lr
	vstrw.u32 q2, [q7, #-404]
	umaal r9,r12,r3,lr
	umaal r11,r12,r4,lr
	vshl.i32 q5, q1, #4
	umaal r12,r7,r5,lr
	ldm r1!,{r0,r10,lr}
	vsri.32 q5, q1, #28
	umaal r9,r6,r2,r0
	vstrw.u32 q5, [q7, #-4]
	umaal r11,r6,r3,r0
	umaal r12,r6,r4,r0
	vldrw.u32 q0, [q6, #-124]
	umaal r6,r7,r5,r0
	vldrw.u32 q1, [q6, #388]
	strd r8,r9,[sp,#8]
	mov r9,#0
	veor q0, q0, q3
	umaal r11,r9,r2,r10
	veor q1, q1, q4
	umaal r12,r9,r3,r10
	umaal r6,r9,r4,r10
	vshl.i32 q2, q0, #7
	umaal r7,r9,r5,r10
	vsri.32 q2, q0, #25
	mov r10,#0
	umaal r12,r10,r2,lr
	vstrw.u32 q2, [q6, #468]
	umaal r6,r10,r3,lr
	vshl.i32 q5, q1, #7
	umaal r7,r10,r4,lr
	umaal r9,r10,r5,lr
	vsri.32 q5, q1, #25
	ldr r8,[r1],#4
	mov lr,#0
	vstrw.u32 q5, [q7, #-148]
	umaal lr,r6,r2,r8
	vldrw.u32 q0, [q6, #404]
	umaal r7,r6,r3,r8
	umaal r9,r6,r4,r8
	vldrw.u32 q1, [q6, #420]
	umaal r10,r6,r5,r8
	vldrw.u32 q2, [q6, #436]
	ldr r8,[r1],#-28
	mov r0,#0
	vldrw.u32 q5, [q6, #452]
	umaal r7,r0,r2,r8
	vldrw.u32 q3, [q6, #468]
	umaal r9,r0,r3,r8
	umaal r10,r0,r4,r8
	vbic q4, q2, q1
	umaal r6,r0,r5,r8
	veor q4, q4, q0
	push {r0}
	ldr r2,[sp,#40]
	vstrw.u32 q4, [q6, #-508]
	adds r2,r2,#16
	vbic q4, q5, q2
	ldm r2,{r2,r3,r4,r5}
	ldr r8,[r1],#4
	veor q4, q4, q1
	mov r0,#0
	umaal r11,r0,r2,r8
	vstrw.u32 q4, [q6, #-492]
	str r11,[sp,#16+4]
	vbic q4, q3, q5
	umaal r12,r0,r3,r8
	umaal lr,r0,r4,r8
	veor q4, q4, q2
	umaal r0,r7,r5,r8 // 7=carry for 9
	vstrw.u32 q4, [q6, #-476]
	ldr r8,[r1],#4
	mov r11,#0
	vbic q4, q0, q3
	umaal r12,r11,r2,r8
	veor q4, q4, q5
	str r12,[sp,#20+4]
	umaal lr,r11,r3,r8
	vstrw.u32 q4, [q6, #-460]
	umaal r0,r11,r4,r8
	vbic q4, q1, q0
	umaal r11,r7,r5,r8 // 7=carry for 10
	ldr r8,[r1],#4
	veor q4, q4, q3
	mov r12,#0
	vstrw.u32 q4, [q6, #-444]
	umaal lr,r12,r2,r8
	str lr,[sp,#24+4]
	vldrw.u32 q0, [q6, #484]
	umaal r0,r12,r3,r8
	umaal r11,r12,r4,r8
	vldrw.u32 q1, [q6, #500]
	umaal r10,r12,r5,r8 // 12=carry for 6
	vldrw.u32 q2, [q7, #-500]
	ldr r8,[r1],#4
	mov lr,#0
	vldrw.u32 q5, [q7, #-484]
	umaal r0,lr,r2,r8
	vldrw.u32 q3, [q7, #-468]
	str r0,[sp,#28+4]
	umaal r11,lr,r3,r8
	vbic q4, q2, q1
	umaal r10,lr,r4,r8
	veor q4, q4, q0
	umaal r6,lr,r5,r8 // lr=carry for saved
	ldm r1!,{r0,r8}
	vstrw.u32 q4, [q6, #-428]
	umaal r11,r9,r2,r0
	vbic q4, q5, q2
	str r11,[sp,#32+4]
	umaal r9,r10,r3,r0
	veor q4, q4, q1
	umaal r10,r6,r4,r0
	vstrw.u32 q4, [q6, #-412]
	pop {r11}
	umaal r11,r6,r5,r0 // 6=carry for next
	vbic q4, q3, q5
	umaal r9,r7,r2,r8
	umaal r10,r7,r3,r8
	veor q4, q4, q2
	umaal r11,r7,r4,r8
	vstrw.u32 q4, [q6, #-396]
	umaal r6,r7,r5,r8
	ldm r1!,{r0,r8}
	vbic q4, q0, q3
	umaal r10,r12,r2,r0
	veor q4, q4, q5
	umaal r11,r12,r3,r0
	umaal r6,r12,r4,r0
	vstrw.u32 q4, [q6, #-380]
	umaal r7,r12,r5,r0
	vbic q4, q1, q0
	umaal r11,lr,r2,r8
	umaal r6,lr,r3,r8
	veor q4, q4, q3
	umaal lr,r7,r4,r8
	vstrw.u32 q4, [q6, #-364]
	umaal r7,r12,r5,r8
	ldrd r4,r5,[sp,#28]
	vldrw.u32 q0, [q7, #-452]
	movs r3,#38
	vldrw.u32 q1, [q7, #-436]
	mov r8,#0
	umaal r4,r8,r3,r12
	vldrw.u32 q2, [q7, #-420]
	lsl r8,r8,#1
	orr r8,r8,r4, lsr #31
	vldrw.u32 q5, [q7, #-404]
	and r12,r4,#0x7fffffff
	vldrw.u32 q3, [q7, #-388]
	movs r4,#19
	mul r8,r8,r4
	vbic q4, q2, q1
	pop {r0-r2}
	veor q4, q4, q0
	umaal r0,r8,r3,r5
	umaal r1,r8,r3,r9
	vstrw.u32 q4, [q6, #-348]
	umaal r2,r8,r3,r10
	vbic q4, q5, q2
	mov r9,#38
	pop {r3,r4}
	veor q4, q4, q1
	umaal r3,r8,r9,r11
	vstrw.u32 q4, [q6, #-332]
	umaal r4,r8,r9,r6
	pop {r5,r6}
	vbic q4, q3, q5
	umaal r5,r8,r9,lr
	veor q4, q4, q2
	umaal r6,r8,r9,r7
	add r7,r8,r12
	vstrw.u32 q4, [q6, #-316]
	add sp,#12
	ldr lr, [sp], #4
	push {r0-r7, lr}
	movw r12, #:lower16:g_u_phase
	movt r12, #:upper16:g_u_phase
	mov r0, #6
	str r0, [r12]
	pop {r0-r7, lr}
	bx lr

.type fe25519_mul_u6, %function
.thumb_func
.balign 16
fe25519_mul_u6:
	push {r2,lr}
	vbic q4, q0, q3
	sub sp,#28
	veor q4, q4, q5
	ldm r2,{r2,r3,r4,r5}
	ldm r1!,{r0,r10,lr}
	vstrw.u32 q4, [q6, #-300]
	umull r6,r11,r2,r0
	vbic q4, q1, q0
	umull r7,r12,r3,r0
	umaal r7,r11,r2,r10
	veor q4, q4, q3
	push {r6,r7}
	vstrw.u32 q4, [q6, #-284]
	umull r8,r6,r4,r0
	umaal r8,r11,r3,r10
	vldrw.u32 q0, [q7, #-372]
	umull r9,r7,r5,r0
	vldrw.u32 q1, [q7, #-356]
	umaal r9,r11,r4,r10
	umaal r11,r7,r5,r10
	vldrw.u32 q2, [q7, #-340]
	umaal r8,r12,r2,lr
	vldrw.u32 q5, [q7, #-324]
	umaal r9,r12,r3,lr
	umaal r11,r12,r4,lr
	vldrw.u32 q3, [q7, #-308]
	umaal r12,r7,r5,lr
	ldm r1!,{r0,r10,lr}
	vbic q4, q2, q1
	umaal r9,r6,r2,r0
	veor q4, q4, q0
	umaal r11,r6,r3,r0
	umaal r12,r6,r4,r0
	vstrw.u32 q4, [q6, #-268]
	umaal r6,r7,r5,r0
	vbic q4, q5, q2
	strd r8,r9,[sp,#8]
	mov r9,#0
	veor q4, q4, q1
	umaal r11,r9,r2,r10
	vstrw.u32 q4, [q6, #-252]
	umaal r12,r9,r3,r10
	umaal r6,r9,r4,r10
	vbic q4, q3, q5
	umaal r7,r9,r5,r10
	veor q4, q4, q2
	mov r10,#0
	umaal r12,r10,r2,lr
	vstrw.u32 q4, [q6, #-236]
	umaal r6,r10,r3,lr
	vbic q4, q0, q3
	umaal r7,r10,r4,lr
	umaal r9,r10,r5,lr
	veor q4, q4, q5
	ldr r8,[r1],#4
	mov lr,#0
	vstrw.u32 q4, [q6, #-220]
	umaal lr,r6,r2,r8
	vbic q4, q1, q0
	umaal r7,r6,r3,r8
	umaal r9,r6,r4,r8
	veor q4, q4, q3
	umaal r10,r6,r5,r8
	vstrw.u32 q4, [q6, #-204]
	ldr r8,[r1],#-28
	mov r0,#0
	vldrw.u32 q0, [q7, #-292]
	umaal r7,r0,r2,r8
	vldrw.u32 q1, [q7, #-276]
	umaal r9,r0,r3,r8
	umaal r10,r0,r4,r8
	vldrw.u32 q2, [q7, #-260]
	umaal r6,r0,r5,r8
	vldrw.u32 q5, [q7, #-244]
	push {r0}
	ldr r2,[sp,#40]
	vldrw.u32 q3, [q7, #-228]
	adds r2,r2,#16
	vbic q4, q2, q1
	ldm r2,{r2,r3,r4,r5}
	ldr r8,[r1],#4
	veor q4, q4, q0
	mov r0,#0
	umaal r11,r0,r2,r8
	vstrw.u32 q4, [q6, #-188]
	str r11,[sp,#16+4]
	vbic q4, q5, q2
	umaal r12,r0,r3,r8
	umaal lr,r0,r4,r8
	veor q4, q4, q1
	umaal r0,r7,r5,r8 // 7=carry for 9
	vstrw.u32 q4, [q6, #-172]
	ldr r8,[r1],#4
	mov r11,#0
	vbic q4, q3, q5
	umaal r12,r11,r2,r8
	veor q4, q4, q2
	str r12,[sp,#20+4]
	umaal lr,r11,r3,r8
	vstrw.u32 q4, [q6, #-156]
	umaal r0,r11,r4,r8
	vbic q4, q0, q3
	umaal r11,r7,r5,r8 // 7=carry for 10
	ldr r8,[r1],#4
	veor q4, q4, q5
	mov r12,#0
	vstrw.u32 q4, [q6, #-140]
	umaal lr,r12,r2,r8
	str lr,[sp,#24+4]
	vbic q4, q1, q0
	umaal r0,r12,r3,r8
	umaal r11,r12,r4,r8
	veor q4, q4, q3
	umaal r10,r12,r5,r8 // 12=carry for 6
	vstrw.u32 q4, [q6, #-124]
	ldr r8,[r1],#4
	mov lr,#0
	vldrw.u32 q0, [q7, #-212]
	umaal r0,lr,r2,r8
	vldrw.u32 q1, [q7, #-196]
	str r0,[sp,#28+4]
	umaal r11,lr,r3,r8
	vldrw.u32 q2, [q7, #-180]
	umaal r10,lr,r4,r8
	vldrw.u32 q5, [q7, #-164]
	umaal r6,lr,r5,r8 // lr=carry for saved
	ldm r1!,{r0,r8}
	vldrw.u32 q3, [q7, #-148]
	umaal r11,r9,r2,r0
	vbic q4, q2, q1
	str r11,[sp,#32+4]
	umaal r9,r10,r3,r0
	veor q4, q4, q0
	umaal r10,r6,r4,r0
	vstrw.u32 q4, [q6, #4]
	pop {r11}
	umaal r11,r6,r5,r0 // 6=carry for next
	vbic q4, q5, q2
	umaal r9,r7,r2,r8
	umaal r10,r7,r3,r8
	veor q4, q4, q1
	umaal r11,r7,r4,r8
	vstrw.u32 q4, [q6, #20]
	umaal r6,r7,r5,r8
	ldm r1!,{r0,r8}
	vbic q4, q3, q5
	umaal r10,r12,r2,r0
	veor q4, q4, q2
	umaal r11,r12,r3,r0
	umaal r6,r12,r4,r0
	vstrw.u32 q4, [q6, #36]
	umaal r7,r12,r5,r0
	vbic q4, q0, q3
	umaal r11,lr,r2,r8
	umaal r6,lr,r3,r8
	veor q4, q4, q5
	umaal lr,r7,r4,r8
	vstrw.u32 q4, [q6, #52]
	umaal r7,r12,r5,r8
	ldrd r4,r5,[sp,#28]
	vbic q4, q1, q0
	movs r3,#38
	veor q4, q4, q3
	mov r8,#0
	umaal r4,r8,r3,r12
	vstrw.u32 q4, [q6, #68]
	lsl r8,r8,#1
	orr r8,r8,r4, lsr #31
	vldrw.u32 q0, [q7, #-132]
	and r12,r4,#0x7fffffff
	vldrw.u32 q1, [q7, #-116]
	movs r4,#19
	mul r8,r8,r4
	vldrw.u32 q2, [q7, #-100]
	pop {r0-r2}
	vldrw.u32 q5, [q7, #-84]
	umaal r0,r8,r3,r5
	umaal r1,r8,r3,r9
	vldrw.u32 q3, [q7, #-68]
	umaal r2,r8,r3,r10
	vbic q4, q2, q1
	mov r9,#38
	pop {r3,r4}
	veor q4, q4, q0
	umaal r3,r8,r9,r11
	vstrw.u32 q4, [q6, #84]
	umaal r4,r8,r9,r6
	pop {r5,r6}
	vbic q4, q5, q2
	umaal r5,r8,r9,lr
	veor q4, q4, q1
	umaal r6,r8,r9,r7
	add r7,r8,r12
	vstrw.u32 q4, [q6, #100]
	add sp,#12
	ldr lr, [sp], #4
	push {r0-r7, lr}
	movw r12, #:lower16:g_u_phase
	movt r12, #:upper16:g_u_phase
	mov r0, #7
	str r0, [r12]
	pop {r0-r7, lr}
	bx lr

.type fe25519_mul_u7, %function
.thumb_func
.balign 16
fe25519_mul_u7:
	push {r2,lr}
	vbic q4, q3, q5
	sub sp,#28
	veor q4, q4, q2
	ldm r2,{r2,r3,r4,r5}
	ldm r1!,{r0,r10,lr}
	vstrw.u32 q4, [q6, #116]
	umull r6,r11,r2,r0
	vbic q4, q0, q3
	umull r7,r12,r3,r0
	umaal r7,r11,r2,r10
	veor q4, q4, q5
	push {r6,r7}
	vstrw.u32 q4, [q6, #132]
	umull r8,r6,r4,r0
	umaal r8,r11,r3,r10
	vbic q4, q1, q0
	umull r9,r7,r5,r0
	veor q4, q4, q3
	umaal r9,r11,r4,r10
	umaal r11,r7,r5,r10
	vstrw.u32 q4, [q6, #148]
	umaal r8,r12,r2,lr
	vldrw.u32 q0, [q7, #-52]
	umaal r9,r12,r3,lr
	umaal r11,r12,r4,lr
	vldrw.u32 q1, [q7, #-36]
	umaal r12,r7,r5,lr
	ldm r1!,{r0,r10,lr}
	vldrw.u32 q2, [q7, #-20]
	umaal r9,r6,r2,r0
	vldrw.u32 q5, [q7, #-4]
	umaal r11,r6,r3,r0
	umaal r12,r6,r4,r0
	vldrw.u32 q3, [q7, #12]
	umaal r6,r7,r5,r0
	vbic q4, q2, q1
	strd r8,r9,[sp,#8]
	mov r9,#0
	veor q4, q4, q0
	umaal r11,r9,r2,r10
	vstrw.u32 q4, [q6, #164]
	umaal r12,r9,r3,r10
	umaal r6,r9,r4,r10
	vbic q4, q5, q2
	umaal r7,r9,r5,r10
	veor q4, q4, q1
	mov r10,#0
	umaal r12,r10,r2,lr
	vstrw.u32 q4, [q6, #180]
	umaal r6,r10,r3,lr
	vbic q4, q3, q5
	umaal r7,r10,r4,lr
	umaal r9,r10,r5,lr
	veor q4, q4, q2
	ldr r8,[r1],#4
	mov lr,#0
	vstrw.u32 q4, [q6, #196]
	umaal lr,r6,r2,r8
	vbic q4, q0, q3
	umaal r7,r6,r3,r8
	umaal r9,r6,r4,r8
	veor q4, q4, q5
	umaal r10,r6,r5,r8
	vstrw.u32 q4, [q6, #212]
	ldr r8,[r1],#-28
	mov r0,#0
	vbic q4, q1, q0
	umaal r7,r0,r2,r8
	veor q4, q4, q3
	umaal r9,r0,r3,r8
	umaal r10,r0,r4,r8
	vstrw.u32 q4, [q6, #228]
	umaal r6,r0,r5,r8
	vldrw.u32 q0, [q7, #28]
	push {r0}
	ldr r2,[sp,#40]
	vldrw.u32 q1, [q7, #44]
	adds r2,r2,#16
	vldrw.u32 q2, [q7, #60]
	ldm r2,{r2,r3,r4,r5}
	ldr r8,[r1],#4
	vldrw.u32 q5, [q7, #76]
	mov r0,#0
	umaal r11,r0,r2,r8
	vldrw.u32 q3, [q7, #92]
	str r11,[sp,#16+4]
	vbic q4, q2, q1
	umaal r12,r0,r3,r8
	umaal lr,r0,r4,r8
	veor q4, q4, q0
	umaal r0,r7,r5,r8 // 7=carry for 9
	vstrw.u32 q4, [q6, #244]
	ldr r8,[r1],#4
	mov r11,#0
	vbic q4, q5, q2
	umaal r12,r11,r2,r8
	veor q4, q4, q1
	str r12,[sp,#20+4]
	umaal lr,r11,r3,r8
	vstrw.u32 q4, [q6, #260]
	umaal r0,r11,r4,r8
	vbic q4, q3, q5
	umaal r11,r7,r5,r8 // 7=carry for 10
	ldr r8,[r1],#4
	veor q4, q4, q2
	mov r12,#0
	vstrw.u32 q4, [q6, #276]
	umaal lr,r12,r2,r8
	str lr,[sp,#24+4]
	vbic q4, q0, q3
	umaal r0,r12,r3,r8
	umaal r11,r12,r4,r8
	veor q4, q4, q5
	umaal r10,r12,r5,r8 // 12=carry for 6
	vstrw.u32 q4, [q6, #292]
	ldr r8,[r1],#4
	mov lr,#0
	vbic q4, q1, q0
	umaal r0,lr,r2,r8
	veor q4, q4, q3
	str r0,[sp,#28+4]
	umaal r11,lr,r3,r8
	vstrw.u32 q4, [q6, #308]
	umaal r10,lr,r4,r8
	vldrw.u32 q0, [q7, #108]
	umaal r6,lr,r5,r8 // lr=carry for saved
	ldm r1!,{r0,r8}
	vldrw.u32 q1, [q7, #124]
	umaal r11,r9,r2,r0
	vldrw.u32 q2, [q7, #140]
	str r11,[sp,#32+4]
	umaal r9,r10,r3,r0
	vldrw.u32 q5, [q7, #156]
	umaal r10,r6,r4,r0
	vldrw.u32 q3, [q7, #172]
	pop {r11}
	umaal r11,r6,r5,r0 // 6=carry for next
	vbic q4, q2, q1
	umaal r9,r7,r2,r8
	umaal r10,r7,r3,r8
	veor q4, q4, q0
	umaal r11,r7,r4,r8
	vstrw.u32 q4, [q6, #324]
	umaal r6,r7,r5,r8
	ldm r1!,{r0,r8}
	vbic q4, q5, q2
	umaal r10,r12,r2,r0
	veor q4, q4, q1
	umaal r11,r12,r3,r0
	umaal r6,r12,r4,r0
	vstrw.u32 q4, [q6, #340]
	umaal r7,r12,r5,r0
	vbic q4, q3, q5
	umaal r11,lr,r2,r8
	umaal r6,lr,r3,r8
	veor q4, q4, q2
	umaal lr,r7,r4,r8
	vstrw.u32 q4, [q6, #356]
	umaal r7,r12,r5,r8
	ldrd r4,r5,[sp,#28]
	vbic q4, q0, q3
	movs r3,#38
	veor q4, q4, q5
	mov r8,#0
	umaal r4,r8,r3,r12
	vstrw.u32 q4, [q6, #372]
	lsl r8,r8,#1
	orr r8,r8,r4, lsr #31
	vbic q4, q1, q0
	and r12,r4,#0x7fffffff
	veor q4, q4, q3
	movs r4,#19
	mul r8,r8,r4
	vstrw.u32 q4, [q6, #388]
	pop {r0-r2}
	vldrw.u32 q0, [q6, #-108]
	umaal r0,r8,r3,r5
	umaal r1,r8,r3,r9
	vldrw.u32 q1, [q6, #-508]
	umaal r2,r8,r3,r10
	veor q1, q1, q0
	mov r9,#38
	pop {r3,r4}
	vstrw.u32 q1, [q6, #-508]
	umaal r3,r8,r9,r11
	vldrw.u32 q0, [q6, #-92]
	umaal r4,r8,r9,r6
	pop {r5,r6}
	vldrw.u32 q1, [q6, #4]
	umaal r5,r8,r9,lr
	veor q1, q1, q0
	umaal r6,r8,r9,r7
	add r7,r8,r12
	vstrw.u32 q1, [q6, #4]
	add sp,#12
	ldr lr, [sp], #4
	push {r0-r7, lr}
	movw r12, #:lower16:g_u_phase
	movt r12, #:upper16:g_u_phase
	movs r0, #0
	str r0, [r12]
	movw r12, #:lower16:g_u_round
	movt r12, #:upper16:g_u_round
	ldr r0, [r12]
	adds r0, r0, #1
	str r0, [r12]
	cmp r0, #24
	bne 11f
	movw r12, #:lower16:g_u_active
	movt r12, #:upper16:g_u_active
	movs r0, #0
	str r0, [r12]
11:
	pop {r0-r7, lr}
	bx lr


// input/result in (r0-r7)
// clobbers all other registers
// cycles: 115
	.type fe25519_sqr, %function
fe25519_sqr:
	.global fe25519_sqr
	push {lr}
	//frame push {lr}
	sub sp,#20
	//frame address sp,24
	
	//mul 01, 00
	umull r9,r10,r0,r0
	umull r11,r12,r0,r1
	adds r11,r11,r11
	mov lr,#0
	umaal r10,r11,lr,lr
	
	//r9 r10 done
	//r12 carry for 3rd before col
	//r11+C carry for 3rd final col
	
	push {r9,r10}
	//frame address sp,32
	
	//mul 02, 11
	mov r8,#0
	umaal r8,r12,r0,r2
	adcs r8,r8,r8
	umaal r8,r11,r1,r1
	
	//r8 done (3rd col)
	//r12 carry for 4th before col
	//r11+C carry for 4th final col
	
	//mul 03, 12
	umull r9,r10,r0,r3
	umaal r9,r12,r1,r2
	adcs r9,r9,r9
	umaal r9,r11,lr,lr
	
	//r9 done (4th col)
	//r10+r12 carry for 5th before col
	//r11+C carry for 5th final col
	
	strd r8,r9,[sp,#8]
	
	//mul 04, 13, 22
	mov r9,#0
	umaal r9,r10,r0,r4
	umaal r9,r12,r1,r3
	adcs r9,r9,r9
	umaal r9,r11,r2,r2
	
	//r9 done (5th col)
	//r10+r12 carry for 6th before col
	//r11+C carry for 6th final col
	
	str r9,[sp,#16]
	
	//mul 05, 14, 23
	umull r9,r8,r0,r5
	umaal r9,r10,r1,r4
	umaal r9,r12,r2,r3
	adcs r9,r9,r9
	umaal r9,r11,lr,lr
	
	//r9 done (6th col)
	//r10+r12+r8 carry for 7th before col
	//r11+C carry for 7th final col
	
	str r9,[sp,#20]
	
	//mul 06, 15, 24, 33
	mov r9,#0
	umaal r9,r8,r1,r5
	umaal r9,r12,r2,r4
	umaal r9,r10,r0,r6
	adcs r9,r9,r9
	umaal r9,r11,r3,r3
	
	//r9 done (7th col)
	//r8+r10+r12 carry for 8th before col
	//r11+C carry for 8th final col
	
	str r9,[sp,#24]
	
	//mul 07, 16, 25, 34
	umull r0,r9,r0,r7
	umaal r0,r10,r1,r6
	umaal r0,r12,r2,r5
	umaal r0,r8,r3,r4
	adcs r0,r0,r0
	umaal r0,r11,lr,lr
	
	//r0 done (8th col)
	//r9+r8+r10+r12 carry for 9th before col
	//r11+C carry for 9th final col
	
	//mul 17, 26, 35, 44
	umaal r9,r8,r1,r7 //r1 is now dead
	umaal r9,r10,r2,r6
	umaal r12,r9,r3,r5
	adcs r12,r12,r12
	umaal r11,r12,r4,r4
	
	//r11 done (9th col)
	//r8+r10+r9 carry for 10th before col
	//r12+C carry for 10th final col
	
	//mul 27, 36, 45
	umaal r9,r8,r2,r7 //r2 is now dead
	umaal r10,r9,r3,r6
	movs r2,#0
	umaal r10,r2,r4,r5
	adcs r10,r10,r10
	umaal r12,r10,lr,lr
	
	//r12 done (10th col)
	//r8+r9+r2 carry for 11th before col
	//r10+C carry for 11th final col
	
	//mul 37, 46, 55
	umaal r2,r8,r3,r7 //r3 is now dead
	umaal r9,r2,r4,r6
	adcs r9,r9,r9
	umaal r10,r9,r5,r5
	
	//r10 done (11th col)
	//r8+r2 carry for 12th before col
	//r9+C carry for 12th final col
	
	//mul 47, 56
	movs r3,#0
	umaal r3,r8,r4,r7 //r4 is now dead
	umaal r3,r2,r5,r6
	adcs r3,r3,r3
	umaal r9,r3,lr,lr
	
	//r9 done (12th col)
	//r8+r2 carry for 13th before col
	//r3+C carry for 13th final col
	
	//mul 57, 66
	umaal r8,r2,r5,r7 //r5 is now dead
	adcs r8,r8,r8
	umaal r3,r8,r6,r6
	
	//r3 done (13th col)
	//r2 carry for 14th before col
	//r8+C carry for 14th final col
	
	//mul 67
	umull r4,r5,lr,lr // set 0
	umaal r4,r2,r6,r7
	adcs r4,r4,r4
	umaal r4,r8,lr,lr
	
	//r4 done (14th col)
	//r2 carry for 15th before col
	//r8+C carry for 15th final col
	
	//mul 77
	adcs r2,r2,r2
	umaal r8,r2,r7,r7
	adcs r2,r2,lr
	
	//r8 done (15th col)
	//r2 done (16th col)
	
	//msb -> lsb: r2 r8 r4 r3 r9 r10 r12 r11 r0 sp+24 sp+20 sp+16 sp+12 sp+8 sp+4 sp
	//lr: 0
	//now do reduction
	
	mov r6,#38
	umaal r0,lr,r6,r2
	lsl lr,lr,#1
	orr lr,lr,r0, lsr #31
	and r7,r0,#0x7fffffff
	movs r5,#19
	mul lr,lr,r5
	
	pop {r0,r1}
	//frame address sp,24
	umaal r0,lr,r6,r11
	umaal r1,lr,r6,r12
	
	mov r11,r3
	mov r12,r4
	
	pop {r2,r3,r4,r5}
	//frame address sp,8
	umaal r2,lr,r6,r10
	umaal r3,lr,r6,r9
	
	umaal r4,lr,r6,r11
	umaal r5,lr,r6,r12
	
	pop {r6}
	//frame address sp,4
	mov r12,#38
	umaal r6,lr,r12,r8
	add r7,r7,lr
	
	pop {pc}
	
	.size fe25519_sqr, .-fe25519_sqr

// in: r0-r7, count: r8
// out: r0-r7 + sets result also to top of stack
// clobbers all other registers
// cycles: 19 + 123*n
	.type fe25519_sqr_many, %function
fe25519_sqr_many:
	.global fe25519_sqr_many
	push {r8,lr}
	//frame push {r8,lr}
0:
	bl fe25519_sqr
	
	ldr r8,[sp,#0]
	subs r8,r8,#1
	str r8,[sp,#0]
	bne 0b
	
	add sp,sp,#4
	//frame address sp,4
	add r8,sp,#4
	stm r8,{r0-r7}
	pop {pc}
	.size fe25519_sqr_many, .-fe25519_sqr_many

// This kind of load supports unaligned access
// in: *r1
// out: r0-r7
// cycles: 22
	.type loadm, %function
loadm:
	ldr r0,[r1,#0]
	ldr r2,[r1,#8]
	ldr r3,[r1,#12]
	ldr r4,[r1,#16]
	ldr r5,[r1,#20]
	ldr r6,[r1,#24]
	ldr r7,[r1,#28]
	ldr r1,[r1,#4]
	bx lr
	.size loadm, .-loadm

// in: *r0 = result, *r1 = scalar, *r2 = basepoint (all pointers may be unaligned)
// cycles: 548 873
	.type curve25519_scalarmult, %function
curve25519_scalarmult:
	.global curve25519_scalarmult
	
	// stack layout: xp zp xq zq x0  bitpos lastbit scalar result_ptr r4-r11,lr
	//               0  32 64 96 128 160    164     168    200        204

	push {r0,r4-r11,lr}
	//frame push {r4-r11,lr}
	//frame address sp,40
	
	mov r10,r2
	bl loadm
	
	and r0,r0,#0xfffffff8
	//and r7,r7,#0x7fffffff not needed since we don't inspect the msb anyway
	orr r7,r7,#0x40000000
	push {r0-r7}
	//frame address sp,72
	movs r8,#0
	push {r2,r8}
	//frame address sp,80
	
	//ldm r1,{r0-r7}
	mov r1,r10
	bl loadm
	
	and r7,r7,#0x7fffffff
	push {r0-r7}
	//frame address sp,112
	
	movs r9,#1
	umull r10,r11,r8,r8
	mov r12,#0
	push {r8,r10,r11,r12}
	//frame address sp,128
	push {r9,r10,r11,r12}
	//frame address sp,144
	
	push {r0-r7}
	//frame address sp,176
	
	umull r6,r7,r8,r8
	push {r6,r7,r8,r10,r11,r12}
	//frame address sp,200
	push {r6,r7,r8,r10,r11,r12}
	//frame address sp,224
	push {r9,r10,r11,r12}
	//frame address sp,240
	
	movs r0,#254
	movs r3,#0
	// 129 cycles so far
0:
	// load scalar bit into r1
	lsrs r1,r0,#5
	adds r2,sp,#168
	ldr r1,[r2,r1,lsl #2]
	and r4,r0,#0x1f
	lsrs r1,r1,r4
	and r1,r1,#1
	
	strd r0,r1,[sp,#160]
	
	eors r1,r1,r3
	rsbs lr,r1,#0
	
	mov r0,sp
	add r1,sp,#64
	
	mov r11,#4
	// 15 cycles
1:
	ldm r0,{r2-r5}
	ldm r1,{r6-r9}
	
	eors r2,r2,r6
	and r10,r2,lr
	eors r6,r6,r10
	eors r2,r2,r6
	
	eors r3,r3,r7
	and r10,r3,lr
	eors r7,r7,r10
	eors r3,r3,r7
	
	eors r4,r4,r8
	and r10,r4,lr
	eors r8,r8,r10
	eors r4,r4,r8
	
	eors r5,r5,r9
	and r10,r5,lr
	eors r9,r9,r10
	eors r5,r5,r9
	
	stm r0!,{r2-r5}
	stm r1!,{r6-r9}
	
	subs r11,#1
	bne 1b
	// 40*4 - 2 = 158 cycles
	
	mov r8,sp
	add r9,sp,#32
	bl fe25519_add
	push {r0-r7}
	//frame address sp,272
	
	bl fe25519_sqr
	push {r0-r7}
	//frame address sp,304
	
	add r8,sp,#64
	add r9,sp,#96
	bl fe25519_sub
	push {r0-r7}
	//frame address sp,336
	
	bl fe25519_sqr
	push {r0-r7}
	//frame address sp,368
	
	mov r1,sp
	add r2,sp,#64
	bl fe25519_mul_scalar
	add r8,sp,#128
	stm r8,{r0-r7}
	
	add r8,sp,#64
	mov r9,sp
	bl fe25519_sub
	add r8,sp,#64
	stm r8,{r0-r7}
	
	// 64 + 1*45 + 2*46 + 1*173 + 2*115 = 604 cycles
	
	//multiplies (r0-r7) with 121666, adds *sp and puts the result on the top of the stack (replacing old content)
	ldr lr,=121666
	//mov lr,#56130
	//add lr,lr,#65536
	ldr r12,[sp,#28]
	mov r11,#0
	umaal r12,r11,lr,r7
	lsl r11,r11,#1
	add r11,r11,r12, lsr #31
	movs r7,#19
	mul r11,r11,r7
	bic r7,r12,#0x80000000
	ldm sp!,{r8,r9,r10,r12}
	//frame address sp,352
	umaal r8,r11,lr,r0
	umaal r9,r11,lr,r1
	umaal r10,r11,lr,r2
	umaal r12,r11,lr,r3
	ldm sp!,{r0,r1,r2}
	//frame address sp,340
	umaal r0,r11,lr,r4
	umaal r1,r11,lr,r5
	umaal r2,r11,lr,r6
	add r7,r7,r11
	add sp,sp,#4
	//frame address sp,338
	push {r0,r1,r2,r7}
	//frame address sp,352
	push {r8,r9,r10,r12}
	//frame address sp,368
	// 39 cycles
	
	mov r1,sp
	add r2,sp,#64
	bl fe25519_mul_scalar
	add r8,sp,#160
	stm r8,{r0-r7}
	
	add r8,sp,#192
	add r9,sp,#224
	bl fe25519_add
	stm sp,{r0-r7}
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul_scalar
	add r8,sp,#32
	stm r8,{r0-r7}
	
	add r8,sp,#192
	add r9,sp,#224
	bl fe25519_sub
	stm sp,{r0-r7}
	
	mov r1,sp
	add r2,sp,#96
	bl fe25519_mul_scalar
	stm sp,{r0-r7}
	
	mov r8,sp
	add r9,sp,#32
	bl fe25519_add
	
	bl fe25519_sqr
	
	add r8,sp,#192
	stm r8,{r0-r7}
	
	mov r8,sp
	add r9,sp,#32
	bl fe25519_sub
	
	bl fe25519_sqr
	stm sp,{r0-r7}
	
	mov r1,sp
	add r2,sp,#256
	bl fe25519_mul_scalar
	add r8,sp,#224
	stm r8,{r0-r7}
	
	add sp,sp,#128
	//frame address sp,240
	
	ldrd r2,r3,[sp,#160]
	subs r0,r2,#1
	// 97 + 2*45 + 2*46 + 4*173 + 2*115 = 1201 cycles
	bpl 0b
	// in total 2020 cycles per iteration, in total 515 098 cycles for 255 iterations

	//These cswap lines are not needed for curve25519 since the lowest bit is hardcoded to 0
	//----------
	//rsbs lr,r3,#0
	
	//mov r0,sp
	//add r1,sp,#64
	
	//mov r11,#4
//1
	//ldm r0,{r2-r5}
	//ldm r1!,{r6-r9}
	
	//eors r2,r2,r6
	//and r10,r2,lr
	//eors r6,r6,r10
	//eors r2,r2,r6
	
	//eors r3,r3,r7
	//and r10,r3,lr
	//eors r7,r7,r10
	//eors r3,r3,r7
	
	//eors r4,r4,r8
	//and r10,r4,lr
	//eors r8,r8,r10
	//eors r4,r4,r8
	
	//eors r5,r5,r9
	//and r10,r5,lr
	//eors r9,r9,r10
	//eors r5,r5,r9
	
	//stm r0!,{r2-r5}
	
	//subs r11,#1
	//bne 1b
	//----------

	// now we must invert zp
	add r0,sp,#32
	ldm r0,{r0-r7}
	bl fe25519_sqr
	push {r0-r7}
	//frame address sp,272
	
	bl fe25519_sqr
	bl fe25519_sqr
	push {r0-r7}
	//frame address sp,304
	
	add r1,sp,#96
	mov r2,sp
	bl fe25519_mul_scalar
	stm sp,{r0-r7}
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul_scalar
	add r8,sp,#32
	stm r8,{r0-r7}
	
	// current stack: z^(2^9) z^(2^11) x z
	
	bl fe25519_sqr
	push {r0-r7}
	//frame address sp,336
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul_scalar
	add r8,sp,#32
	stm r8,{r0-r7}
	
	// current stack: _ z^(2^5 - 2^0) z^(2^11) x z
	
	mov r8,#5
	// 1052 cycles
	bl fe25519_sqr_many // 634 cycles
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul_scalar
	add r8,sp,#32
	stm r8,{r0-r7}
	
	// current stack: _ z^(2^10 - 2^0) z^(2^11) x z <scratch> ...
	
	movs r8,#10
	bl fe25519_sqr_many // 1249 cycles
	//z^(2^20 - 2^10)
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul_scalar
	stm sp,{r0-r7}
	//z^(2^20 - 2^0)
	
	// current stack: z^(2^20 - 2^0) z^(2^10 - 2^0) z^(2^11) x z <scratch> ...
	
	movs r8,#20
	sub sp,sp,#32
	//frame address sp,368
	bl fe25519_sqr_many // 2479 cycles
	//z^(2^40 - 2^20)
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul_scalar
	add sp,sp,#32
	//frame address sp,336
	//z^(2^40 - 2^0)
	
	movs r8,#10
	bl fe25519_sqr_many // 1249 cycles
	//z^(2^50 - 2^10)
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul_scalar
	add r8,sp,#32
	stm r8,{r0-r7}
	
	// current stack: _ z^(2^50 - 2^0) z^(2^11) x z <scratch> ...
	
	movs r8,#50
	bl fe25519_sqr_many // 6169 cycles
	//z^(2^100 - 2^50)
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul_scalar
	stm sp,{r0-r7}
	
	// 13751 cycles so far for inversion
	
	// current stack: z^(2^100 - 2^0) z^(2^50 - 2^0) z^(2^11) x z <scratch> ...
	
	movs r8,#100
	sub sp,sp,#32
	//frame address sp,368
	bl fe25519_sqr_many // 12319 cycles
	//z^(2^200 - 2^100)
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul_scalar
	add sp,sp,#32
	//frame address sp,336
	//z^(2^200 - 2^0)
	
	// current stack: _ z^(2^50 - 2^0) z^(2^11) x z <scratch> ...
	
	movs r8,#50
	bl fe25519_sqr_many // 6169 cycles
	//z^(2^250 - 2^50)
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul_scalar
	//z^(2^250 - 2^0)
	
	movs r8,#5
	bl fe25519_sqr_many // 634 cycles
	//z^(2^255 - 2^5)
	
	mov r1,sp
	add r2,sp,#64
	bl fe25519_mul_scalar
	stm sp,{r0-r7}
	//z^(2^255 - 21)
	
	// 19661 for second half of inversion
	
	// done inverting!
	// total inversion cost: 33412 cycles
	
	mov r1,sp
	add r2,sp,#96
	bl fe25519_mul_scalar
	
	// now final reduce
	lsr r8,r7,#31
	mov r9,#19
	mul r8,r8,r9
	mov r10,#0
	
	// handle the case when 2^255 - 19 <= x < 2^255
	add r8,r8,#19
	
	adds r8,r0,r8
	adcs r8,r1,r10
	adcs r8,r2,r10
	adcs r8,r3,r10
	adcs r8,r4,r10
	adcs r8,r5,r10
	adcs r8,r6,r10
	adcs r8,r7,r10
	adcs r11,r10,r10
	
	lsr r8,r8,#31
	orr r8,r8,r11, lsl #1
	mul r8,r8,r9
	
	ldr r9,[sp,#296]
	
	adds r0,r0,r8
	str r0,[r9,#0]
	movs r0,#0
	adcs r1,r1,r0
	str r1,[r9,#4]
	mov r1,r9
	adcs r2,r2,r0
	adcs r3,r3,r0
	adcs r4,r4,r0
	adcs r5,r5,r0
	adcs r6,r6,r0
	adcs r7,r7,r0
	and r7,r7,#0x7fffffff
	
	str r2,[r1,#8]
	str r3,[r1,#12]
	str r4,[r1,#16]
	str r5,[r1,#20]
	str r6,[r1,#24]
	str r7,[r1,#28]
	
	add sp,sp,#300
	//frame address sp,36
	
	pop {r4-r11,pc}
	
	// 234 cycles after inversion
	// in total for whole function 548 873 cycles
	
	.size curve25519_scalarmult, .-curve25519_scalarmult

	.type curve25519_scalarmult_u, %function
curve25519_scalarmult_u:
	.global curve25519_scalarmult_u
	
	// stack layout: xp zp xq zq x0  bitpos lastbit scalar result_ptr r4-r11,lr
	//               0  32 64 96 128 160    164     168    200        204

	vpush {d8-d15}
	push {r0,r4-r11,lr}
	//frame push {r4-r11,lr}
	//frame address sp,40
	
	mov r10,r2
	bl loadm
	
	and r0,r0,#0xfffffff8
	//and r7,r7,#0x7fffffff not needed since we don't inspect the msb anyway
	orr r7,r7,#0x40000000
	push {r0-r7}
	//frame address sp,72
	movs r8,#0
	push {r2,r8}
	//frame address sp,80
	
	//ldm r1,{r0-r7}
	mov r1,r10
	bl loadm
	
	and r7,r7,#0x7fffffff
	push {r0-r7}
	//frame address sp,112
	
	movs r9,#1
	umull r10,r11,r8,r8
	mov r12,#0
	push {r8,r10,r11,r12}
	//frame address sp,128
	push {r9,r10,r11,r12}
	//frame address sp,144
	
	push {r0-r7}
	//frame address sp,176
	
	umull r6,r7,r8,r8
	push {r6,r7,r8,r10,r11,r12}
	//frame address sp,200
	push {r6,r7,r8,r10,r11,r12}
	//frame address sp,224
	push {r9,r10,r11,r12}
	//frame address sp,240
	
	movs r0,#254
	movs r3,#0
	// 129 cycles so far
0:
	// load scalar bit into r1
	lsrs r1,r0,#5
	adds r2,sp,#168
	ldr r1,[r2,r1,lsl #2]
	and r4,r0,#0x1f
	lsrs r1,r1,r4
	and r1,r1,#1
	
	strd r0,r1,[sp,#160]
	
	eors r1,r1,r3
	rsbs lr,r1,#0
	
	mov r0,sp
	add r1,sp,#64
	
	mov r11,#4
	// 15 cycles
1:
	ldm r0,{r2-r5}
	ldm r1,{r6-r9}
	
	eors r2,r2,r6
	and r10,r2,lr
	eors r6,r6,r10
	eors r2,r2,r6
	
	eors r3,r3,r7
	and r10,r3,lr
	eors r7,r7,r10
	eors r3,r3,r7
	
	eors r4,r4,r8
	and r10,r4,lr
	eors r8,r8,r10
	eors r4,r4,r8
	
	eors r5,r5,r9
	and r10,r5,lr
	eors r9,r9,r10
	eors r5,r5,r9
	
	stm r0!,{r2-r5}
	stm r1!,{r6-r9}
	
	subs r11,#1
	bne 1b
	// 40*4 - 2 = 158 cycles
	
	mov r8,sp
	add r9,sp,#32
	bl fe25519_add
	push {r0-r7}
	//frame address sp,272
	
	bl fe25519_sqr
	push {r0-r7}
	//frame address sp,304
	
	add r8,sp,#64
	add r9,sp,#96
	bl fe25519_sub
	push {r0-r7}
	//frame address sp,336
	
	bl fe25519_sqr
	push {r0-r7}
	//frame address sp,368
	
	mov r1,sp
	add r2,sp,#64
	bl fe25519_mul
	add r8,sp,#128
	stm r8,{r0-r7}
	
	add r8,sp,#64
	mov r9,sp
	bl fe25519_sub
	add r8,sp,#64
	stm r8,{r0-r7}
	
	// 64 + 1*45 + 2*46 + 1*173 + 2*115 = 604 cycles
	
	//multiplies (r0-r7) with 121666, adds *sp and puts the result on the top of the stack (replacing old content)
	ldr lr,=121666
	//mov lr,#56130
	//add lr,lr,#65536
	ldr r12,[sp,#28]
	mov r11,#0
	umaal r12,r11,lr,r7
	lsl r11,r11,#1
	add r11,r11,r12, lsr #31
	movs r7,#19
	mul r11,r11,r7
	bic r7,r12,#0x80000000
	ldm sp!,{r8,r9,r10,r12}
	//frame address sp,352
	umaal r8,r11,lr,r0
	umaal r9,r11,lr,r1
	umaal r10,r11,lr,r2
	umaal r12,r11,lr,r3
	ldm sp!,{r0,r1,r2}
	//frame address sp,340
	umaal r0,r11,lr,r4
	umaal r1,r11,lr,r5
	umaal r2,r11,lr,r6
	add r7,r7,r11
	add sp,sp,#4
	//frame address sp,338
	push {r0,r1,r2,r7}
	//frame address sp,352
	push {r8,r9,r10,r12}
	//frame address sp,368
	// 39 cycles
	
	mov r1,sp
	add r2,sp,#64
	bl fe25519_mul
	add r8,sp,#160
	stm r8,{r0-r7}
	
	add r8,sp,#192
	add r9,sp,#224
	bl fe25519_add
	stm sp,{r0-r7}
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul
	add r8,sp,#32
	stm r8,{r0-r7}
	
	add r8,sp,#192
	add r9,sp,#224
	bl fe25519_sub
	stm sp,{r0-r7}
	
	mov r1,sp
	add r2,sp,#96
	bl fe25519_mul
	stm sp,{r0-r7}
	
	mov r8,sp
	add r9,sp,#32
	bl fe25519_add
	
	bl fe25519_sqr
	
	add r8,sp,#192
	stm r8,{r0-r7}
	
	mov r8,sp
	add r9,sp,#32
	bl fe25519_sub
	
	bl fe25519_sqr
	stm sp,{r0-r7}
	
	mov r1,sp
	add r2,sp,#256
	bl fe25519_mul
	add r8,sp,#224
	stm r8,{r0-r7}
	
	add sp,sp,#128
	//frame address sp,240
	
	ldrd r2,r3,[sp,#160]
	subs r0,r2,#1
	// 97 + 2*45 + 2*46 + 4*173 + 2*115 = 1201 cycles
	bpl 0b
	// in total 2020 cycles per iteration, in total 515 098 cycles for 255 iterations

	//These cswap lines are not needed for curve25519 since the lowest bit is hardcoded to 0
	//----------
	//rsbs lr,r3,#0
	
	//mov r0,sp
	//add r1,sp,#64
	
	//mov r11,#4
//1
	//ldm r0,{r2-r5}
	//ldm r1!,{r6-r9}
	
	//eors r2,r2,r6
	//and r10,r2,lr
	//eors r6,r6,r10
	//eors r2,r2,r6
	
	//eors r3,r3,r7
	//and r10,r3,lr
	//eors r7,r7,r10
	//eors r3,r3,r7
	
	//eors r4,r4,r8
	//and r10,r4,lr
	//eors r8,r8,r10
	//eors r4,r4,r8
	
	//eors r5,r5,r9
	//and r10,r5,lr
	//eors r9,r9,r10
	//eors r5,r5,r9
	
	//stm r0!,{r2-r5}
	
	//subs r11,#1
	//bne 1b
	//----------

	// now we must invert zp
	add r0,sp,#32
	ldm r0,{r0-r7}
	bl fe25519_sqr
	push {r0-r7}
	//frame address sp,272
	
	bl fe25519_sqr
	bl fe25519_sqr
	push {r0-r7}
	//frame address sp,304
	
	add r1,sp,#96
	mov r2,sp
	bl fe25519_mul
	stm sp,{r0-r7}
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul
	add r8,sp,#32
	stm r8,{r0-r7}
	
	// current stack: z^(2^9) z^(2^11) x z
	
	bl fe25519_sqr
	push {r0-r7}
	//frame address sp,336
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul
	add r8,sp,#32
	stm r8,{r0-r7}
	
	// current stack: _ z^(2^5 - 2^0) z^(2^11) x z
	
	mov r8,#5
	// 1052 cycles
	bl fe25519_sqr_many // 634 cycles
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul
	add r8,sp,#32
	stm r8,{r0-r7}
	
	// current stack: _ z^(2^10 - 2^0) z^(2^11) x z <scratch> ...
	
	movs r8,#10
	bl fe25519_sqr_many // 1249 cycles
	//z^(2^20 - 2^10)
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul
	stm sp,{r0-r7}
	//z^(2^20 - 2^0)
	
	// current stack: z^(2^20 - 2^0) z^(2^10 - 2^0) z^(2^11) x z <scratch> ...
	
	movs r8,#20
	sub sp,sp,#32
	//frame address sp,368
	bl fe25519_sqr_many // 2479 cycles
	//z^(2^40 - 2^20)
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul
	add sp,sp,#32
	//frame address sp,336
	//z^(2^40 - 2^0)
	
	movs r8,#10
	bl fe25519_sqr_many // 1249 cycles
	//z^(2^50 - 2^10)
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul
	add r8,sp,#32
	stm r8,{r0-r7}
	
	// current stack: _ z^(2^50 - 2^0) z^(2^11) x z <scratch> ...
	
	movs r8,#50
	bl fe25519_sqr_many // 6169 cycles
	//z^(2^100 - 2^50)
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul
	stm sp,{r0-r7}
	
	// 13751 cycles so far for inversion
	
	// current stack: z^(2^100 - 2^0) z^(2^50 - 2^0) z^(2^11) x z <scratch> ...
	
	movs r8,#100
	sub sp,sp,#32
	//frame address sp,368
	bl fe25519_sqr_many // 12319 cycles
	//z^(2^200 - 2^100)
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul
	add sp,sp,#32
	//frame address sp,336
	//z^(2^200 - 2^0)
	
	// current stack: _ z^(2^50 - 2^0) z^(2^11) x z <scratch> ...
	
	movs r8,#50
	bl fe25519_sqr_many // 6169 cycles
	//z^(2^250 - 2^50)
	
	mov r1,sp
	add r2,sp,#32
	bl fe25519_mul
	//z^(2^250 - 2^0)
	
	movs r8,#5
	bl fe25519_sqr_many // 634 cycles
	//z^(2^255 - 2^5)
	
	mov r1,sp
	add r2,sp,#64
	bl fe25519_mul
	stm sp,{r0-r7}
	//z^(2^255 - 21)
	
	// 19661 for second half of inversion
	
	// done inverting!
	// total inversion cost: 33412 cycles
	
	mov r1,sp
	add r2,sp,#96
	bl fe25519_mul
	
	// now final reduce
	lsr r8,r7,#31
	mov r9,#19
	mul r8,r8,r9
	mov r10,#0
	
	// handle the case when 2^255 - 19 <= x < 2^255
	add r8,r8,#19
	
	adds r8,r0,r8
	adcs r8,r1,r10
	adcs r8,r2,r10
	adcs r8,r3,r10
	adcs r8,r4,r10
	adcs r8,r5,r10
	adcs r8,r6,r10
	adcs r8,r7,r10
	adcs r11,r10,r10
	
	lsr r8,r8,#31
	orr r8,r8,r11, lsl #1
	mul r8,r8,r9
	
	ldr r9,[sp,#296]
	
	adds r0,r0,r8
	str r0,[r9,#0]
	movs r0,#0
	adcs r1,r1,r0
	str r1,[r9,#4]
	mov r1,r9
	adcs r2,r2,r0
	adcs r3,r3,r0
	adcs r4,r4,r0
	adcs r5,r5,r0
	adcs r6,r6,r0
	adcs r7,r7,r0
	and r7,r7,#0x7fffffff
	
	str r2,[r1,#8]
	str r3,[r1,#12]
	str r4,[r1,#16]
	str r5,[r1,#20]
	str r6,[r1,#24]
	str r7,[r1,#28]
	
	add sp,sp,#300
	//frame address sp,36
	
	pop {r4-r11,lr}
	vpop {d8-d15}
	bx lr
	
	// 234 cycles after inversion
	// in total for whole function 548 873 cycles
	
	.size curve25519_scalarmult_u, .-curve25519_scalarmult_u

	
