.text
.syntax unified
.thumb

// zip: mul256 x theta (stitch_zip.py v0.2)
.global mul256_theta_stitched
.type mul256_theta_stitched, %function
.thumb_func
.balign 16
mul256_theta_stitched:
	push	{r4-r11, lr}
	movw	r8, #:lower16:g_theta_state
	movt	r8, #:upper16:g_theta_state
	movs	r5, #0
	ldr	r3, [r1]
	ldr	r7, [r2]
	mov	ip, r5
	umull	r3, r7, r3, r7
	str	r3, [r0]
	ldr	r9, [r8, #0]
	ldr	r4, [r1, #4]
	ldr	r3, [r2]
	ldr	r6, [r1]
	umull	lr, r3, r4, r3
	ldr	r4, [r2, #4]
	ldr	r10, [r8, #40]
	umlal	r7, r5, r6, r4
	adds	r7, lr, r7
	adcs	r3, r3, r5
	it	cs
	movcs	ip, #1
	str	r7, [r0, #4]
	eor	r9, r9, r10
	ldr	r5, [r1]
	ldr	r4, [r2, #8]
	movs	r6, #0
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	ldr	r10, [r8, #80]
	adcs	ip, ip, r4
	ldr	r5, [r1, #4]
	ldr	r4, [r2, #4]
	it	cs
	movcs	r6, #1
	umull	r5, r4, r5, r4
	eor	r9, r9, r10
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	lr, #0
	it	cs
	movcs	lr, #1
	ldr	r5, [r1, #8]
	ldr	r10, [r8, #120]
	ldr	r4, [r2]
	add	r6, r6, lr
	umull	r4, r5, r5, r4
	adds	r4, r3, r4
	adcs	ip, ip, r5
	eor	r9, r9, r10
	mov	lr, #0
	it	cs
	movcs	lr, #1
	str	r4, [r0, #8]
	ldr	r5, [r1]
	ldr	r4, [r2, #12]
	ldr	r10, [r8, #160]
	add	r3, r6, lr
	umull	r6, r4, r5, r4
	adds	ip, ip, r6
	adcs	r3, r3, r4
	ldr	r6, [r1, #4]
	eor	r9, r9, r10
	ldr	r4, [r2, #8]
	mov	r5, #0
	umull	r6, r4, r6, r4
	it	cs
	movcs	r5, #1
	adds	ip, ip, r6
	str	r9, [r8, #200]
	adcs	r3, r3, r4
	mov	lr, #0
	it	cs
	movcs	lr, #1
	ldr	r6, [r1, #8]
	ldr	r4, [r2, #4]
	ldr	r9, [r8, #4]
	add	r5, r5, lr
	umull	r6, r4, r6, r4
	adds	ip, ip, r6
	adcs	r3, r3, r4
	mov	lr, #0
	ldr	r10, [r8, #44]
	it	cs
	movcs	lr, #1
	ldr	r6, [r1, #12]
	ldr	r4, [r2]
	add	r5, r5, lr
	umull	r4, r6, r6, r4
	eor	r9, r9, r10
	adds	r4, ip, r4
	adcs	r3, r3, r6
	mov	lr, #0
	it	cs
	movcs	lr, #1
	str	r4, [r0, #12]
	ldr	r10, [r8, #84]
	ldr	r4, [r2, #16]
	add	ip, r5, lr
	ldr	r5, [r1]
	mov	lr, #0
	umull	r5, r4, r5, r4
	eor	r9, r9, r10
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r5, [r1, #4]
	ldr	r4, [r2, #12]
	it	cs
	movcs	lr, #1
	ldr	r10, [r8, #124]
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	eor	r9, r9, r10
	ldr	r5, [r1, #8]
	ldr	r4, [r2, #8]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	ldr	r10, [r8, #164]
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #12]
	ldr	r4, [r2, #4]
	eor	r9, r9, r10
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	str	r9, [r8, #204]
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #16]
	ldr	r4, [r2]
	add	lr, lr, r6
	umull	r4, r5, r5, r4
	ldr	r9, [r8, #8]
	adds	r4, r3, r4
	adcs	r3, ip, r5
	mov	r6, #0
	it	cs
	movcs	r6, #1
	str	r4, [r0, #16]
	ldr	r10, [r8, #48]
	ldr	r5, [r1]
	ldr	r4, [r2, #20]
	add	ip, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	eor	r9, r9, r10
	adcs	ip, ip, r4
	ldr	r5, [r1, #4]
	ldr	r4, [r2, #16]
	mov	lr, #0
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #88]
	it	cs
	movcs	lr, #1
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	eor	r9, r9, r10
	ldr	r5, [r1, #8]
	ldr	r4, [r2, #12]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	ldr	r10, [r8, #128]
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #12]
	ldr	r4, [r2, #8]
	eor	r9, r9, r10
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	ldr	r10, [r8, #168]
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #16]
	ldr	r4, [r2, #4]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	eor	r9, r9, r10
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #20]
	str	r9, [r8, #208]
	ldr	r4, [r2]
	add	lr, lr, r6
	umull	r4, r5, r5, r4
	adds	r4, r3, r4
	adcs	r3, ip, r5
	ldr	r9, [r8, #12]
	mov	r6, #0
	it	cs
	movcs	r6, #1
	str	r4, [r0, #20]
	ldr	r5, [r1]
	ldr	r4, [r2, #24]
	ldr	r10, [r8, #52]
	add	ip, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r5, [r1, #4]
	eor	r9, r9, r10
	ldr	r4, [r2, #20]
	mov	lr, #0
	umull	r5, r4, r5, r4
	it	cs
	movcs	lr, #1
	adds	r3, r3, r5
	ldr	r10, [r8, #92]
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #8]
	ldr	r4, [r2, #16]
	eor	r9, r9, r10
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	ldr	r10, [r8, #132]
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #12]
	ldr	r4, [r2, #12]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	eor	r9, r9, r10
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #16]
	ldr	r10, [r8, #172]
	ldr	r4, [r2, #8]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	eor	r9, r9, r10
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #20]
	ldr	r4, [r2, #4]
	add	lr, lr, r6
	str	r9, [r8, #212]
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r9, [r8, #16]
	ldr	r5, [r1, #24]
	ldr	r4, [r2]
	add	lr, lr, r6
	umull	r4, r5, r5, r4
	adds	r4, r3, r4
	ldr	r10, [r8, #56]
	adcs	r3, ip, r5
	mov	r6, #0
	it	cs
	movcs	r6, #1
	str	r4, [r0, #24]
	ldr	r5, [r1]
	eor	r9, r9, r10
	ldr	r4, [r2, #28]
	add	ip, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r10, [r8, #96]
	ldr	r5, [r1, #4]
	ldr	r4, [r2, #24]
	mov	lr, #0
	umull	r5, r4, r5, r4
	it	cs
	movcs	lr, #1
	eor	r9, r9, r10
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #8]
	ldr	r10, [r8, #136]
	ldr	r4, [r2, #20]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	eor	r9, r9, r10
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #12]
	ldr	r4, [r2, #16]
	add	lr, lr, r6
	ldr	r10, [r8, #176]
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	eor	r9, r9, r10
	ldr	r5, [r1, #16]
	ldr	r4, [r2, #12]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	str	r9, [r8, #216]
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #20]
	ldr	r4, [r2, #8]
	add	lr, lr, r6
	ldr	r9, [r8, #20]
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r10, [r8, #60]
	ldr	r5, [r1, #24]
	ldr	r4, [r2, #4]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	eor	r9, r9, r10
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #28]
	ldr	r4, [r2]
	ldr	r10, [r8, #100]
	add	lr, lr, r6
	umull	r4, r5, r5, r4
	adds	r4, r3, r4
	adcs	r3, ip, r5
	mov	r6, #0
	eor	r9, r9, r10
	it	cs
	movcs	r6, #1
	str	r4, [r0, #28]
	ldr	r5, [r1, #4]
	ldr	r4, [r2, #28]
	add	ip, lr, r6
	ldr	r10, [r8, #140]
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r5, [r1, #8]
	ldr	r4, [r2, #24]
	eor	r9, r9, r10
	mov	lr, #0
	umull	r5, r4, r5, r4
	it	cs
	movcs	lr, #1
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r10, [r8, #180]
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #12]
	ldr	r4, [r2, #20]
	add	lr, lr, r6
	eor	r9, r9, r10
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	str	r9, [r8, #220]
	ldr	r5, [r1, #16]
	ldr	r4, [r2, #16]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	ldr	r9, [r8, #24]
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #20]
	ldr	r4, [r2, #12]
	ldr	r10, [r8, #64]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	eor	r9, r9, r10
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #24]
	ldr	r4, [r2, #8]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #104]
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #28]
	eor	r9, r9, r10
	ldr	r4, [r2, #4]
	add	lr, lr, r6
	umull	r4, r5, r5, r4
	adds	r4, r3, r4
	adcs	r3, ip, r5
	ldr	r10, [r8, #144]
	mov	r6, #0
	it	cs
	movcs	r6, #1
	str	r4, [r0, #32]
	ldr	r5, [r1, #8]
	ldr	r4, [r2, #28]
	eor	r9, r9, r10
	add	ip, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r5, [r1, #12]
	ldr	r10, [r8, #184]
	ldr	r4, [r2, #24]
	mov	lr, #0
	umull	r5, r4, r5, r4
	it	cs
	movcs	lr, #1
	adds	r3, r3, r5
	eor	r9, r9, r10
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #16]
	ldr	r4, [r2, #20]
	str	r9, [r8, #224]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	ldr	r9, [r8, #28]
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #20]
	ldr	r4, [r2, #16]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #68]
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #24]
	eor	r9, r9, r10
	ldr	r4, [r2, #12]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r10, [r8, #108]
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #28]
	ldr	r4, [r2, #8]
	add	lr, lr, r6
	eor	r9, r9, r10
	umull	r4, r5, r5, r4
	adds	r4, r3, r4
	adcs	r3, ip, r5
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r10, [r8, #148]
	str	r4, [r0, #36]
	ldr	r5, [r1, #12]
	ldr	r4, [r2, #28]
	add	ip, lr, r6
	umull	r5, r4, r5, r4
	eor	r9, r9, r10
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r5, [r1, #16]
	ldr	r4, [r2, #24]
	mov	lr, #0
	ldr	r10, [r8, #188]
	umull	r5, r4, r5, r4
	it	cs
	movcs	lr, #1
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	eor	r9, r9, r10
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #20]
	ldr	r4, [r2, #20]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	str	r9, [r8, #228]
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #24]
	ldr	r9, [r8, #32]
	ldr	r4, [r2, #16]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r10, [r8, #72]
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #28]
	ldr	r4, [r2, #12]
	add	lr, lr, r6
	eor	r9, r9, r10
	umull	r4, r5, r5, r4
	adds	r4, r3, r4
	adcs	r3, ip, r5
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r10, [r8, #112]
	str	r4, [r0, #40]
	ldr	r5, [r1, #16]
	ldr	r4, [r2, #28]
	add	ip, lr, r6
	umull	r6, r4, r5, r4
	eor	r9, r9, r10
	adds	r3, r3, r6
	adcs	ip, ip, r4
	ldr	r6, [r1, #20]
	ldr	r4, [r2, #24]
	mov	r5, #0
	ldr	r10, [r8, #152]
	umull	r6, r4, r6, r4
	it	cs
	movcs	r5, #1
	adds	r3, r3, r6
	adcs	ip, ip, r4
	mov	lr, #0
	eor	r9, r9, r10
	it	cs
	movcs	lr, #1
	ldr	r6, [r1, #24]
	ldr	r4, [r2, #20]
	add	r5, r5, lr
	umull	r6, r4, r6, r4
	ldr	r10, [r8, #192]
	adds	r3, r3, r6
	adcs	ip, ip, r4
	mov	lr, #0
	it	cs
	movcs	lr, #1
	ldr	r6, [r1, #28]
	eor	r9, r9, r10
	ldr	r4, [r2, #16]
	add	r5, r5, lr
	umull	r4, r6, r6, r4
	adds	r4, r3, r4
	adcs	r3, ip, r6
	str	r9, [r8, #232]
	mov	lr, #0
	it	cs
	movcs	lr, #1
	str	r4, [r0, #44]
	add	ip, r5, lr
	ldr	r4, [r2, #28]
	ldr	r9, [r8, #36]
	ldr	r5, [r1, #20]
	mov	lr, #0
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	ldr	r10, [r8, #76]
	ldr	r5, [r1, #24]
	ldr	r4, [r2, #24]
	it	cs
	movcs	lr, #1
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	eor	r9, r9, r10
	adcs	ip, ip, r4
	mov	r6, #0
	it	cs
	movcs	r6, #1
	ldr	r5, [r1, #28]
	ldr	r4, [r2, #20]
	ldr	r10, [r8, #116]
	add	lr, lr, r6
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	adcs	ip, ip, r4
	mov	r6, #0
	eor	r9, r9, r10
	it	cs
	movcs	r6, #1
	str	r3, [r0, #48]
	ldr	r3, [r2, #28]
	ldr	r4, [r1, #24]
	add	lr, lr, r6
	ldr	r10, [r8, #156]
	umull	r5, r4, r4, r3
	adds	ip, ip, r5
	adcs	lr, lr, r4
	ldr	r5, [r1, #28]
	ldr	r4, [r2, #24]
	eor	r9, r9, r10
	mov	r3, #0
	umull	r4, r6, r5, r4
	it	cs
	movcs	r3, #1
	adds	r4, ip, r4
	adcs	lr, lr, r6
	ldr	r10, [r8, #196]
	mov	r5, #0
	it	cs
	movcs	r5, #1
	str	r4, [r0, #52]
	ldr	r4, [r1, #28]
	ldr	r1, [r2, #28]
	eor	r9, r9, r10
	add	r3, r3, r5
	umull	r2, r1, r4, r1
	adds	r2, lr, r2
	adcs	r3, r3, r1
	strd	r2, r3, [r0, #56]
	str	r9, [r8, #236]
	pop	{r4-r11, pc}

// theta 단독 기준선
.global theta_frag
.type theta_frag, %function
.thumb_func
.balign 16
theta_frag:
	push	{r8-r10, lr}
	mov	r8, r0
	ldr	r9, [r8, #0]
	ldr	r10, [r8, #40]
	eor	r9, r9, r10
	ldr	r10, [r8, #80]
	eor	r9, r9, r10
	ldr	r10, [r8, #120]
	eor	r9, r9, r10
	ldr	r10, [r8, #160]
	eor	r9, r9, r10
	str	r9, [r8, #200]
	ldr	r9, [r8, #4]
	ldr	r10, [r8, #44]
	eor	r9, r9, r10
	ldr	r10, [r8, #84]
	eor	r9, r9, r10
	ldr	r10, [r8, #124]
	eor	r9, r9, r10
	ldr	r10, [r8, #164]
	eor	r9, r9, r10
	str	r9, [r8, #204]
	ldr	r9, [r8, #8]
	ldr	r10, [r8, #48]
	eor	r9, r9, r10
	ldr	r10, [r8, #88]
	eor	r9, r9, r10
	ldr	r10, [r8, #128]
	eor	r9, r9, r10
	ldr	r10, [r8, #168]
	eor	r9, r9, r10
	str	r9, [r8, #208]
	ldr	r9, [r8, #12]
	ldr	r10, [r8, #52]
	eor	r9, r9, r10
	ldr	r10, [r8, #92]
	eor	r9, r9, r10
	ldr	r10, [r8, #132]
	eor	r9, r9, r10
	ldr	r10, [r8, #172]
	eor	r9, r9, r10
	str	r9, [r8, #212]
	ldr	r9, [r8, #16]
	ldr	r10, [r8, #56]
	eor	r9, r9, r10
	ldr	r10, [r8, #96]
	eor	r9, r9, r10
	ldr	r10, [r8, #136]
	eor	r9, r9, r10
	ldr	r10, [r8, #176]
	eor	r9, r9, r10
	str	r9, [r8, #216]
	ldr	r9, [r8, #20]
	ldr	r10, [r8, #60]
	eor	r9, r9, r10
	ldr	r10, [r8, #100]
	eor	r9, r9, r10
	ldr	r10, [r8, #140]
	eor	r9, r9, r10
	ldr	r10, [r8, #180]
	eor	r9, r9, r10
	str	r9, [r8, #220]
	ldr	r9, [r8, #24]
	ldr	r10, [r8, #64]
	eor	r9, r9, r10
	ldr	r10, [r8, #104]
	eor	r9, r9, r10
	ldr	r10, [r8, #144]
	eor	r9, r9, r10
	ldr	r10, [r8, #184]
	eor	r9, r9, r10
	str	r9, [r8, #224]
	ldr	r9, [r8, #28]
	ldr	r10, [r8, #68]
	eor	r9, r9, r10
	ldr	r10, [r8, #108]
	eor	r9, r9, r10
	ldr	r10, [r8, #148]
	eor	r9, r9, r10
	ldr	r10, [r8, #188]
	eor	r9, r9, r10
	str	r9, [r8, #228]
	ldr	r9, [r8, #32]
	ldr	r10, [r8, #72]
	eor	r9, r9, r10
	ldr	r10, [r8, #112]
	eor	r9, r9, r10
	ldr	r10, [r8, #152]
	eor	r9, r9, r10
	ldr	r10, [r8, #192]
	eor	r9, r9, r10
	str	r9, [r8, #232]
	ldr	r9, [r8, #36]
	ldr	r10, [r8, #76]
	eor	r9, r9, r10
	ldr	r10, [r8, #116]
	eor	r9, r9, r10
	ldr	r10, [r8, #156]
	eor	r9, r9, r10
	ldr	r10, [r8, #196]
	eor	r9, r9, r10
	str	r9, [r8, #236]
	pop	{r8-r10, pc}

// 전체 라운드 단독 기준선
.global round_frag
.type round_frag, %function
.thumb_func
.balign 16
round_frag:
	push	{r8-r11, lr}
	mov	r8, r0
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
	ldr	r9, [r8, #0]
	ldr	r10, [r8, #440]
	eor	r9, r9, r10
	str	r9, [r8, #0]
	ldr	r9, [r8, #4]
	ldr	r10, [r8, #444]
	eor	r9, r9, r10
	str	r9, [r8, #4]
	ldr	r9, [r8, #8]
	ldr	r10, [r8, #448]
	eor	r9, r9, r10
	str	r9, [r8, #8]
	ldr	r9, [r8, #12]
	ldr	r10, [r8, #452]
	eor	r9, r9, r10
	str	r9, [r8, #12]
	ldr	r9, [r8, #16]
	ldr	r10, [r8, #456]
	eor	r9, r9, r10
	str	r9, [r8, #16]
	ldr	r9, [r8, #20]
	ldr	r10, [r8, #460]
	eor	r9, r9, r10
	str	r9, [r8, #20]
	ldr	r9, [r8, #24]
	ldr	r10, [r8, #464]
	eor	r9, r9, r10
	str	r9, [r8, #24]
	ldr	r9, [r8, #28]
	ldr	r10, [r8, #468]
	eor	r9, r9, r10
	str	r9, [r8, #28]
	ldr	r9, [r8, #32]
	ldr	r10, [r8, #472]
	eor	r9, r9, r10
	str	r9, [r8, #32]
	ldr	r9, [r8, #36]
	ldr	r10, [r8, #476]
	eor	r9, r9, r10
	str	r9, [r8, #36]
	ldr	r9, [r8, #40]
	ldr	r10, [r8, #440]
	eor	r9, r9, r10
	str	r9, [r8, #40]
	ldr	r9, [r8, #44]
	ldr	r10, [r8, #444]
	eor	r9, r9, r10
	str	r9, [r8, #44]
	ldr	r9, [r8, #48]
	ldr	r10, [r8, #448]
	eor	r9, r9, r10
	str	r9, [r8, #48]
	ldr	r9, [r8, #52]
	ldr	r10, [r8, #452]
	eor	r9, r9, r10
	str	r9, [r8, #52]
	ldr	r9, [r8, #56]
	ldr	r10, [r8, #456]
	eor	r9, r9, r10
	str	r9, [r8, #56]
	ldr	r9, [r8, #60]
	ldr	r10, [r8, #460]
	eor	r9, r9, r10
	str	r9, [r8, #60]
	ldr	r9, [r8, #64]
	ldr	r10, [r8, #464]
	eor	r9, r9, r10
	str	r9, [r8, #64]
	ldr	r9, [r8, #68]
	ldr	r10, [r8, #468]
	eor	r9, r9, r10
	str	r9, [r8, #68]
	ldr	r9, [r8, #72]
	ldr	r10, [r8, #472]
	eor	r9, r9, r10
	str	r9, [r8, #72]
	ldr	r9, [r8, #76]
	ldr	r10, [r8, #476]
	eor	r9, r9, r10
	str	r9, [r8, #76]
	ldr	r9, [r8, #80]
	ldr	r10, [r8, #440]
	eor	r9, r9, r10
	str	r9, [r8, #80]
	ldr	r9, [r8, #84]
	ldr	r10, [r8, #444]
	eor	r9, r9, r10
	str	r9, [r8, #84]
	ldr	r9, [r8, #88]
	ldr	r10, [r8, #448]
	eor	r9, r9, r10
	str	r9, [r8, #88]
	ldr	r9, [r8, #92]
	ldr	r10, [r8, #452]
	eor	r9, r9, r10
	str	r9, [r8, #92]
	ldr	r9, [r8, #96]
	ldr	r10, [r8, #456]
	eor	r9, r9, r10
	str	r9, [r8, #96]
	ldr	r9, [r8, #100]
	ldr	r10, [r8, #460]
	eor	r9, r9, r10
	str	r9, [r8, #100]
	ldr	r9, [r8, #104]
	ldr	r10, [r8, #464]
	eor	r9, r9, r10
	str	r9, [r8, #104]
	ldr	r9, [r8, #108]
	ldr	r10, [r8, #468]
	eor	r9, r9, r10
	str	r9, [r8, #108]
	ldr	r9, [r8, #112]
	ldr	r10, [r8, #472]
	eor	r9, r9, r10
	str	r9, [r8, #112]
	ldr	r9, [r8, #116]
	ldr	r10, [r8, #476]
	eor	r9, r9, r10
	str	r9, [r8, #116]
	ldr	r9, [r8, #120]
	ldr	r10, [r8, #440]
	eor	r9, r9, r10
	str	r9, [r8, #120]
	ldr	r9, [r8, #124]
	ldr	r10, [r8, #444]
	eor	r9, r9, r10
	str	r9, [r8, #124]
	ldr	r9, [r8, #128]
	ldr	r10, [r8, #448]
	eor	r9, r9, r10
	str	r9, [r8, #128]
	ldr	r9, [r8, #132]
	ldr	r10, [r8, #452]
	eor	r9, r9, r10
	str	r9, [r8, #132]
	ldr	r9, [r8, #136]
	ldr	r10, [r8, #456]
	eor	r9, r9, r10
	str	r9, [r8, #136]
	ldr	r9, [r8, #140]
	ldr	r10, [r8, #460]
	eor	r9, r9, r10
	str	r9, [r8, #140]
	ldr	r9, [r8, #144]
	ldr	r10, [r8, #464]
	eor	r9, r9, r10
	str	r9, [r8, #144]
	ldr	r9, [r8, #148]
	ldr	r10, [r8, #468]
	eor	r9, r9, r10
	str	r9, [r8, #148]
	ldr	r9, [r8, #152]
	ldr	r10, [r8, #472]
	eor	r9, r9, r10
	str	r9, [r8, #152]
	ldr	r9, [r8, #156]
	ldr	r10, [r8, #476]
	eor	r9, r9, r10
	str	r9, [r8, #156]
	ldr	r9, [r8, #160]
	ldr	r10, [r8, #440]
	eor	r9, r9, r10
	str	r9, [r8, #160]
	ldr	r9, [r8, #164]
	ldr	r10, [r8, #444]
	eor	r9, r9, r10
	str	r9, [r8, #164]
	ldr	r9, [r8, #168]
	ldr	r10, [r8, #448]
	eor	r9, r9, r10
	str	r9, [r8, #168]
	ldr	r9, [r8, #172]
	ldr	r10, [r8, #452]
	eor	r9, r9, r10
	str	r9, [r8, #172]
	ldr	r9, [r8, #176]
	ldr	r10, [r8, #456]
	eor	r9, r9, r10
	str	r9, [r8, #176]
	ldr	r9, [r8, #180]
	ldr	r10, [r8, #460]
	eor	r9, r9, r10
	str	r9, [r8, #180]
	ldr	r9, [r8, #184]
	ldr	r10, [r8, #464]
	eor	r9, r9, r10
	str	r9, [r8, #184]
	ldr	r9, [r8, #188]
	ldr	r10, [r8, #468]
	eor	r9, r9, r10
	str	r9, [r8, #188]
	ldr	r9, [r8, #192]
	ldr	r10, [r8, #472]
	eor	r9, r9, r10
	str	r9, [r8, #192]
	ldr	r9, [r8, #196]
	ldr	r10, [r8, #476]
	eor	r9, r9, r10
	str	r9, [r8, #196]
	ldr	r9, [r8, #0]
	ldr	r10, [r8, #4]
	str	r9, [r8, #200]
	str	r10, [r8, #204]
	ldr	r9, [r8, #44]
	ldr	r10, [r8, #40]
	lsl	r11, r9, #4
	orr	r11, r11, r10, lsr #28
	str	r11, [r8, #328]
	lsl	r11, r10, #4
	orr	r11, r11, r9, lsr #28
	str	r11, [r8, #332]
	ldr	r9, [r8, #80]
	ldr	r10, [r8, #84]
	lsl	r11, r9, #3
	orr	r11, r11, r10, lsr #29
	str	r11, [r8, #256]
	lsl	r11, r10, #3
	orr	r11, r11, r9, lsr #29
	str	r11, [r8, #260]
	ldr	r9, [r8, #124]
	ldr	r10, [r8, #120]
	lsl	r11, r9, #9
	orr	r11, r11, r10, lsr #23
	str	r11, [r8, #384]
	lsl	r11, r10, #9
	orr	r11, r11, r9, lsr #23
	str	r11, [r8, #388]
	ldr	r9, [r8, #160]
	ldr	r10, [r8, #164]
	lsl	r11, r9, #18
	orr	r11, r11, r10, lsr #14
	str	r11, [r8, #312]
	lsl	r11, r10, #18
	orr	r11, r11, r9, lsr #14
	str	r11, [r8, #316]
	ldr	r9, [r8, #8]
	ldr	r10, [r8, #12]
	lsl	r11, r9, #1
	orr	r11, r11, r10, lsr #31
	str	r11, [r8, #280]
	lsl	r11, r10, #1
	orr	r11, r11, r9, lsr #31
	str	r11, [r8, #284]
	ldr	r9, [r8, #52]
	ldr	r10, [r8, #48]
	lsl	r11, r9, #12
	orr	r11, r11, r10, lsr #20
	str	r11, [r8, #208]
	lsl	r11, r10, #12
	orr	r11, r11, r9, lsr #20
	str	r11, [r8, #212]
	ldr	r9, [r8, #88]
	ldr	r10, [r8, #92]
	lsl	r11, r9, #10
	orr	r11, r11, r10, lsr #22
	str	r11, [r8, #336]
	lsl	r11, r10, #10
	orr	r11, r11, r9, lsr #22
	str	r11, [r8, #340]
	ldr	r9, [r8, #132]
	ldr	r10, [r8, #128]
	lsl	r11, r9, #13
	orr	r11, r11, r10, lsr #19
	str	r11, [r8, #264]
	lsl	r11, r10, #13
	orr	r11, r11, r9, lsr #19
	str	r11, [r8, #268]
	ldr	r9, [r8, #168]
	ldr	r10, [r8, #172]
	lsl	r11, r9, #2
	orr	r11, r11, r10, lsr #30
	str	r11, [r8, #392]
	lsl	r11, r10, #2
	orr	r11, r11, r9, lsr #30
	str	r11, [r8, #396]
	ldr	r9, [r8, #20]
	ldr	r10, [r8, #16]
	lsl	r11, r9, #30
	orr	r11, r11, r10, lsr #2
	str	r11, [r8, #360]
	lsl	r11, r10, #30
	orr	r11, r11, r9, lsr #2
	str	r11, [r8, #364]
	ldr	r9, [r8, #56]
	ldr	r10, [r8, #60]
	lsl	r11, r9, #6
	orr	r11, r11, r10, lsr #26
	str	r11, [r8, #288]
	lsl	r11, r10, #6
	orr	r11, r11, r9, lsr #26
	str	r11, [r8, #292]
	ldr	r9, [r8, #100]
	ldr	r10, [r8, #96]
	lsl	r11, r9, #11
	orr	r11, r11, r10, lsr #21
	str	r11, [r8, #216]
	lsl	r11, r10, #11
	orr	r11, r11, r9, lsr #21
	str	r11, [r8, #220]
	ldr	r9, [r8, #136]
	ldr	r10, [r8, #140]
	lsl	r11, r9, #15
	orr	r11, r11, r10, lsr #17
	str	r11, [r8, #344]
	lsl	r11, r10, #15
	orr	r11, r11, r9, lsr #17
	str	r11, [r8, #348]
	ldr	r9, [r8, #180]
	ldr	r10, [r8, #176]
	lsl	r11, r9, #29
	orr	r11, r11, r10, lsr #3
	str	r11, [r8, #272]
	lsl	r11, r10, #29
	orr	r11, r11, r9, lsr #3
	str	r11, [r8, #276]
	ldr	r9, [r8, #24]
	ldr	r10, [r8, #28]
	lsl	r11, r9, #28
	orr	r11, r11, r10, lsr #4
	str	r11, [r8, #240]
	lsl	r11, r10, #28
	orr	r11, r11, r9, lsr #4
	str	r11, [r8, #244]
	ldr	r9, [r8, #68]
	ldr	r10, [r8, #64]
	lsl	r11, r9, #23
	orr	r11, r11, r10, lsr #9
	str	r11, [r8, #368]
	lsl	r11, r10, #23
	orr	r11, r11, r9, lsr #9
	str	r11, [r8, #372]
	ldr	r9, [r8, #104]
	ldr	r10, [r8, #108]
	lsl	r11, r9, #25
	orr	r11, r11, r10, lsr #7
	str	r11, [r8, #296]
	lsl	r11, r10, #25
	orr	r11, r11, r9, lsr #7
	str	r11, [r8, #300]
	ldr	r9, [r8, #144]
	ldr	r10, [r8, #148]
	lsl	r11, r9, #21
	orr	r11, r11, r10, lsr #11
	str	r11, [r8, #224]
	lsl	r11, r10, #21
	orr	r11, r11, r9, lsr #11
	str	r11, [r8, #228]
	ldr	r9, [r8, #188]
	ldr	r10, [r8, #184]
	lsl	r11, r9, #24
	orr	r11, r11, r10, lsr #8
	str	r11, [r8, #352]
	lsl	r11, r10, #24
	orr	r11, r11, r9, lsr #8
	str	r11, [r8, #356]
	ldr	r9, [r8, #32]
	ldr	r10, [r8, #36]
	lsl	r11, r9, #27
	orr	r11, r11, r10, lsr #5
	str	r11, [r8, #320]
	lsl	r11, r10, #27
	orr	r11, r11, r9, lsr #5
	str	r11, [r8, #324]
	ldr	r9, [r8, #72]
	ldr	r10, [r8, #76]
	lsl	r11, r9, #20
	orr	r11, r11, r10, lsr #12
	str	r11, [r8, #248]
	lsl	r11, r10, #20
	orr	r11, r11, r9, lsr #12
	str	r11, [r8, #252]
	ldr	r9, [r8, #116]
	ldr	r10, [r8, #112]
	lsl	r11, r9, #7
	orr	r11, r11, r10, lsr #25
	str	r11, [r8, #376]
	lsl	r11, r10, #7
	orr	r11, r11, r9, lsr #25
	str	r11, [r8, #380]
	ldr	r9, [r8, #152]
	ldr	r10, [r8, #156]
	lsl	r11, r9, #8
	orr	r11, r11, r10, lsr #24
	str	r11, [r8, #304]
	lsl	r11, r10, #8
	orr	r11, r11, r9, lsr #24
	str	r11, [r8, #308]
	ldr	r9, [r8, #192]
	ldr	r10, [r8, #196]
	lsl	r11, r9, #14
	orr	r11, r11, r10, lsr #18
	str	r11, [r8, #232]
	lsl	r11, r10, #14
	orr	r11, r11, r9, lsr #18
	str	r11, [r8, #236]
	ldr	r9, [r8, #200]
	ldr	r10, [r8, #208]
	ldr	r11, [r8, #216]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #0]
	ldr	r9, [r8, #204]
	ldr	r10, [r8, #212]
	ldr	r11, [r8, #220]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #4]
	ldr	r9, [r8, #208]
	ldr	r10, [r8, #216]
	ldr	r11, [r8, #224]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #8]
	ldr	r9, [r8, #212]
	ldr	r10, [r8, #220]
	ldr	r11, [r8, #228]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #12]
	ldr	r9, [r8, #216]
	ldr	r10, [r8, #224]
	ldr	r11, [r8, #232]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #16]
	ldr	r9, [r8, #220]
	ldr	r10, [r8, #228]
	ldr	r11, [r8, #236]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #20]
	ldr	r9, [r8, #224]
	ldr	r10, [r8, #232]
	ldr	r11, [r8, #200]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #24]
	ldr	r9, [r8, #228]
	ldr	r10, [r8, #236]
	ldr	r11, [r8, #204]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #28]
	ldr	r9, [r8, #232]
	ldr	r10, [r8, #200]
	ldr	r11, [r8, #208]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #32]
	ldr	r9, [r8, #236]
	ldr	r10, [r8, #204]
	ldr	r11, [r8, #212]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #36]
	ldr	r9, [r8, #240]
	ldr	r10, [r8, #248]
	ldr	r11, [r8, #256]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #40]
	ldr	r9, [r8, #244]
	ldr	r10, [r8, #252]
	ldr	r11, [r8, #260]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #44]
	ldr	r9, [r8, #248]
	ldr	r10, [r8, #256]
	ldr	r11, [r8, #264]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #48]
	ldr	r9, [r8, #252]
	ldr	r10, [r8, #260]
	ldr	r11, [r8, #268]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #52]
	ldr	r9, [r8, #256]
	ldr	r10, [r8, #264]
	ldr	r11, [r8, #272]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #56]
	ldr	r9, [r8, #260]
	ldr	r10, [r8, #268]
	ldr	r11, [r8, #276]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #60]
	ldr	r9, [r8, #264]
	ldr	r10, [r8, #272]
	ldr	r11, [r8, #240]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #64]
	ldr	r9, [r8, #268]
	ldr	r10, [r8, #276]
	ldr	r11, [r8, #244]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #68]
	ldr	r9, [r8, #272]
	ldr	r10, [r8, #240]
	ldr	r11, [r8, #248]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #72]
	ldr	r9, [r8, #276]
	ldr	r10, [r8, #244]
	ldr	r11, [r8, #252]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #76]
	ldr	r9, [r8, #280]
	ldr	r10, [r8, #288]
	ldr	r11, [r8, #296]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #80]
	ldr	r9, [r8, #284]
	ldr	r10, [r8, #292]
	ldr	r11, [r8, #300]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #84]
	ldr	r9, [r8, #288]
	ldr	r10, [r8, #296]
	ldr	r11, [r8, #304]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #88]
	ldr	r9, [r8, #292]
	ldr	r10, [r8, #300]
	ldr	r11, [r8, #308]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #92]
	ldr	r9, [r8, #296]
	ldr	r10, [r8, #304]
	ldr	r11, [r8, #312]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #96]
	ldr	r9, [r8, #300]
	ldr	r10, [r8, #308]
	ldr	r11, [r8, #316]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #100]
	ldr	r9, [r8, #304]
	ldr	r10, [r8, #312]
	ldr	r11, [r8, #280]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #104]
	ldr	r9, [r8, #308]
	ldr	r10, [r8, #316]
	ldr	r11, [r8, #284]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #108]
	ldr	r9, [r8, #312]
	ldr	r10, [r8, #280]
	ldr	r11, [r8, #288]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #112]
	ldr	r9, [r8, #316]
	ldr	r10, [r8, #284]
	ldr	r11, [r8, #292]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #116]
	ldr	r9, [r8, #320]
	ldr	r10, [r8, #328]
	ldr	r11, [r8, #336]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #120]
	ldr	r9, [r8, #324]
	ldr	r10, [r8, #332]
	ldr	r11, [r8, #340]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #124]
	ldr	r9, [r8, #328]
	ldr	r10, [r8, #336]
	ldr	r11, [r8, #344]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #128]
	ldr	r9, [r8, #332]
	ldr	r10, [r8, #340]
	ldr	r11, [r8, #348]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #132]
	ldr	r9, [r8, #336]
	ldr	r10, [r8, #344]
	ldr	r11, [r8, #352]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #136]
	ldr	r9, [r8, #340]
	ldr	r10, [r8, #348]
	ldr	r11, [r8, #356]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #140]
	ldr	r9, [r8, #344]
	ldr	r10, [r8, #352]
	ldr	r11, [r8, #320]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #144]
	ldr	r9, [r8, #348]
	ldr	r10, [r8, #356]
	ldr	r11, [r8, #324]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #148]
	ldr	r9, [r8, #352]
	ldr	r10, [r8, #320]
	ldr	r11, [r8, #328]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #152]
	ldr	r9, [r8, #356]
	ldr	r10, [r8, #324]
	ldr	r11, [r8, #332]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #156]
	ldr	r9, [r8, #360]
	ldr	r10, [r8, #368]
	ldr	r11, [r8, #376]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #160]
	ldr	r9, [r8, #364]
	ldr	r10, [r8, #372]
	ldr	r11, [r8, #380]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #164]
	ldr	r9, [r8, #368]
	ldr	r10, [r8, #376]
	ldr	r11, [r8, #384]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #168]
	ldr	r9, [r8, #372]
	ldr	r10, [r8, #380]
	ldr	r11, [r8, #388]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #172]
	ldr	r9, [r8, #376]
	ldr	r10, [r8, #384]
	ldr	r11, [r8, #392]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #176]
	ldr	r9, [r8, #380]
	ldr	r10, [r8, #388]
	ldr	r11, [r8, #396]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #180]
	ldr	r9, [r8, #384]
	ldr	r10, [r8, #392]
	ldr	r11, [r8, #360]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #184]
	ldr	r9, [r8, #388]
	ldr	r10, [r8, #396]
	ldr	r11, [r8, #364]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #188]
	ldr	r9, [r8, #392]
	ldr	r10, [r8, #360]
	ldr	r11, [r8, #368]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #192]
	ldr	r9, [r8, #396]
	ldr	r10, [r8, #364]
	ldr	r11, [r8, #372]
	bic	r11, r11, r10
	eor	r9, r9, r11
	str	r9, [r8, #196]
	ldr	r9, [r8, #0]
	eor	r9, r9, #1
	str	r9, [r8, #0]
	pop	{r8-r11, pc}

// zip: mul256 x full round
.global mul256_round_stitched
.type mul256_round_stitched, %function
.thumb_func
.balign 16
mul256_round_stitched:
	push	{r4-r11, lr}
	movw	r8, #:lower16:g_theta_state
	movt	r8, #:upper16:g_theta_state
	movs	r5, #0
	ldr	r9, [r8, #0]
	ldr	r3, [r1]
	ldr	r10, [r8, #40]
	eor	r9, r9, r10
	ldr	r7, [r2]
	ldr	r10, [r8, #80]
	eor	r9, r9, r10
	mov	ip, r5
	ldr	r10, [r8, #120]
	umull	r3, r7, r3, r7
	eor	r9, r9, r10
	ldr	r10, [r8, #160]
	str	r3, [r0]
	eor	r9, r9, r10
	str	r9, [r8, #400]
	ldr	r4, [r1, #4]
	ldr	r9, [r8, #4]
	ldr	r10, [r8, #44]
	ldr	r3, [r2]
	eor	r9, r9, r10
	ldr	r6, [r1]
	ldr	r10, [r8, #84]
	eor	r9, r9, r10
	umull	lr, r3, r4, r3
	ldr	r10, [r8, #124]
	eor	r9, r9, r10
	ldr	r4, [r2, #4]
	ldr	r10, [r8, #164]
	umlal	r7, r5, r6, r4
	eor	r9, r9, r10
	str	r9, [r8, #404]
	adds	r7, lr, r7
	ldr	r9, [r8, #8]
	ldr	r10, [r8, #48]
	adcs	r3, r3, r5
	eor	r9, r9, r10
	ldr	r10, [r8, #88]
	it	cs
	movcs	ip, #1
	eor	r9, r9, r10
	str	r7, [r0, #4]
	ldr	r10, [r8, #128]
	eor	r9, r9, r10
	ldr	r5, [r1]
	ldr	r10, [r8, #168]
	eor	r9, r9, r10
	ldr	r4, [r2, #8]
	str	r9, [r8, #408]
	movs	r6, #0
	ldr	r9, [r8, #12]
	ldr	r10, [r8, #52]
	umull	r5, r4, r5, r4
	eor	r9, r9, r10
	ldr	r10, [r8, #92]
	adds	r3, r3, r5
	eor	r9, r9, r10
	ldr	r10, [r8, #132]
	adcs	ip, ip, r4
	eor	r9, r9, r10
	ldr	r5, [r1, #4]
	ldr	r10, [r8, #172]
	eor	r9, r9, r10
	ldr	r4, [r2, #4]
	str	r9, [r8, #412]
	ldr	r9, [r8, #16]
	it	cs
	movcs	r6, #1
	ldr	r10, [r8, #56]
	eor	r9, r9, r10
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #96]
	adds	r3, r3, r5
	eor	r9, r9, r10
	ldr	r10, [r8, #136]
	adcs	ip, ip, r4
	eor	r9, r9, r10
	ldr	r10, [r8, #176]
	mov	lr, #0
	eor	r9, r9, r10
	it	cs
	movcs	lr, #1
	str	r9, [r8, #416]
	ldr	r9, [r8, #20]
	ldr	r5, [r1, #8]
	ldr	r10, [r8, #60]
	eor	r9, r9, r10
	ldr	r4, [r2]
	ldr	r10, [r8, #100]
	eor	r9, r9, r10
	add	r6, r6, lr
	ldr	r10, [r8, #140]
	umull	r4, r5, r5, r4
	eor	r9, r9, r10
	ldr	r10, [r8, #180]
	adds	r4, r3, r4
	eor	r9, r9, r10
	str	r9, [r8, #420]
	adcs	ip, ip, r5
	ldr	r9, [r8, #24]
	mov	lr, #0
	ldr	r10, [r8, #64]
	eor	r9, r9, r10
	it	cs
	movcs	lr, #1
	ldr	r10, [r8, #104]
	eor	r9, r9, r10
	str	r4, [r0, #8]
	ldr	r10, [r8, #144]
	eor	r9, r9, r10
	ldr	r5, [r1]
	ldr	r10, [r8, #184]
	ldr	r4, [r2, #12]
	eor	r9, r9, r10
	str	r9, [r8, #424]
	add	r3, r6, lr
	ldr	r9, [r8, #28]
	ldr	r10, [r8, #68]
	umull	r6, r4, r5, r4
	eor	r9, r9, r10
	ldr	r10, [r8, #108]
	adds	ip, ip, r6
	eor	r9, r9, r10
	adcs	r3, r3, r4
	ldr	r10, [r8, #148]
	eor	r9, r9, r10
	ldr	r6, [r1, #4]
	ldr	r10, [r8, #188]
	eor	r9, r9, r10
	ldr	r4, [r2, #8]
	str	r9, [r8, #428]
	mov	r5, #0
	ldr	r9, [r8, #32]
	ldr	r10, [r8, #72]
	umull	r6, r4, r6, r4
	eor	r9, r9, r10
	ldr	r10, [r8, #112]
	it	cs
	movcs	r5, #1
	eor	r9, r9, r10
	ldr	r10, [r8, #152]
	adds	ip, ip, r6
	eor	r9, r9, r10
	adcs	r3, r3, r4
	ldr	r10, [r8, #192]
	eor	r9, r9, r10
	mov	lr, #0
	str	r9, [r8, #432]
	ldr	r9, [r8, #36]
	it	cs
	movcs	lr, #1
	ldr	r10, [r8, #76]
	ldr	r6, [r1, #8]
	eor	r9, r9, r10
	ldr	r10, [r8, #116]
	ldr	r4, [r2, #4]
	eor	r9, r9, r10
	ldr	r10, [r8, #156]
	add	r5, r5, lr
	eor	r9, r9, r10
	ldr	r10, [r8, #196]
	umull	r6, r4, r6, r4
	eor	r9, r9, r10
	adds	ip, ip, r6
	str	r9, [r8, #436]
	ldr	r9, [r8, #408]
	adcs	r3, r3, r4
	ldr	r10, [r8, #412]
	lsl	r11, r9, #1
	mov	lr, #0
	orr	r11, r11, r10, lsr #31
	it	cs
	movcs	lr, #1
	ldr	r9, [r8, #432]
	eor	r11, r11, r9
	ldr	r6, [r1, #12]
	str	r11, [r8, #440]
	ldr	r9, [r8, #408]
	ldr	r4, [r2]
	lsl	r11, r10, #1
	orr	r11, r11, r9, lsr #31
	add	r5, r5, lr
	ldr	r10, [r8, #436]
	umull	r4, r6, r6, r4
	eor	r11, r11, r10
	str	r11, [r8, #444]
	adds	r4, ip, r4
	ldr	r9, [r8, #416]
	ldr	r10, [r8, #420]
	adcs	r3, r3, r6
	lsl	r11, r9, #1
	orr	r11, r11, r10, lsr #31
	mov	lr, #0
	ldr	r9, [r8, #400]
	it	cs
	movcs	lr, #1
	eor	r11, r11, r9
	str	r11, [r8, #448]
	str	r4, [r0, #12]
	ldr	r9, [r8, #416]
	lsl	r11, r10, #1
	ldr	r4, [r2, #16]
	orr	r11, r11, r9, lsr #31
	add	ip, r5, lr
	ldr	r10, [r8, #404]
	eor	r11, r11, r10
	ldr	r5, [r1]
	str	r11, [r8, #452]
	ldr	r9, [r8, #424]
	mov	lr, #0
	ldr	r10, [r8, #428]
	lsl	r11, r9, #1
	umull	r5, r4, r5, r4
	orr	r11, r11, r10, lsr #31
	adds	r3, r3, r5
	ldr	r9, [r8, #408]
	eor	r11, r11, r9
	adcs	ip, ip, r4
	str	r11, [r8, #456]
	ldr	r9, [r8, #424]
	ldr	r5, [r1, #4]
	lsl	r11, r10, #1
	ldr	r4, [r2, #12]
	orr	r11, r11, r9, lsr #31
	ldr	r10, [r8, #412]
	it	cs
	movcs	lr, #1
	eor	r11, r11, r10
	str	r11, [r8, #460]
	umull	r5, r4, r5, r4
	ldr	r9, [r8, #432]
	ldr	r10, [r8, #436]
	adds	r3, r3, r5
	lsl	r11, r9, #1
	adcs	ip, ip, r4
	orr	r11, r11, r10, lsr #31
	ldr	r9, [r8, #416]
	mov	r6, #0
	eor	r11, r11, r9
	str	r11, [r8, #464]
	it	cs
	movcs	r6, #1
	ldr	r9, [r8, #432]
	lsl	r11, r10, #1
	ldr	r5, [r1, #8]
	orr	r11, r11, r9, lsr #31
	ldr	r4, [r2, #8]
	ldr	r10, [r8, #420]
	eor	r11, r11, r10
	add	lr, lr, r6
	str	r11, [r8, #468]
	ldr	r9, [r8, #400]
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #404]
	adds	r3, r3, r5
	lsl	r11, r9, #1
	orr	r11, r11, r10, lsr #31
	adcs	ip, ip, r4
	ldr	r9, [r8, #424]
	eor	r11, r11, r9
	mov	r6, #0
	str	r11, [r8, #472]
	ldr	r9, [r8, #400]
	it	cs
	movcs	r6, #1
	lsl	r11, r10, #1
	ldr	r5, [r1, #12]
	orr	r11, r11, r9, lsr #31
	ldr	r10, [r8, #428]
	ldr	r4, [r2, #4]
	eor	r11, r11, r10
	str	r11, [r8, #476]
	add	lr, lr, r6
	ldr	r9, [r8, #0]
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #440]
	eor	r9, r9, r10
	adds	r3, r3, r5
	str	r9, [r8, #0]
	ldr	r9, [r8, #4]
	adcs	ip, ip, r4
	ldr	r10, [r8, #444]
	eor	r9, r9, r10
	mov	r6, #0
	str	r9, [r8, #4]
	it	cs
	movcs	r6, #1
	ldr	r9, [r8, #8]
	ldr	r10, [r8, #448]
	ldr	r5, [r1, #16]
	eor	r9, r9, r10
	str	r9, [r8, #8]
	ldr	r4, [r2]
	ldr	r9, [r8, #12]
	add	lr, lr, r6
	ldr	r10, [r8, #452]
	eor	r9, r9, r10
	umull	r4, r5, r5, r4
	str	r9, [r8, #12]
	ldr	r9, [r8, #16]
	adds	r4, r3, r4
	ldr	r10, [r8, #456]
	eor	r9, r9, r10
	adcs	r3, ip, r5
	str	r9, [r8, #16]
	mov	r6, #0
	ldr	r9, [r8, #20]
	ldr	r10, [r8, #460]
	it	cs
	movcs	r6, #1
	eor	r9, r9, r10
	str	r9, [r8, #20]
	str	r4, [r0, #16]
	ldr	r9, [r8, #24]
	ldr	r10, [r8, #464]
	ldr	r5, [r1]
	eor	r9, r9, r10
	ldr	r4, [r2, #20]
	str	r9, [r8, #24]
	ldr	r9, [r8, #28]
	add	ip, lr, r6
	ldr	r10, [r8, #468]
	eor	r9, r9, r10
	umull	r5, r4, r5, r4
	str	r9, [r8, #28]
	adds	r3, r3, r5
	ldr	r9, [r8, #32]
	ldr	r10, [r8, #472]
	adcs	ip, ip, r4
	eor	r9, r9, r10
	str	r9, [r8, #32]
	ldr	r5, [r1, #4]
	ldr	r9, [r8, #36]
	ldr	r10, [r8, #476]
	ldr	r4, [r2, #16]
	eor	r9, r9, r10
	mov	lr, #0
	str	r9, [r8, #36]
	ldr	r9, [r8, #40]
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #440]
	eor	r9, r9, r10
	it	cs
	movcs	lr, #1
	str	r9, [r8, #40]
	adds	r3, r3, r5
	ldr	r9, [r8, #44]
	ldr	r10, [r8, #444]
	adcs	ip, ip, r4
	eor	r9, r9, r10
	str	r9, [r8, #44]
	mov	r6, #0
	ldr	r9, [r8, #48]
	ldr	r10, [r8, #448]
	it	cs
	movcs	r6, #1
	eor	r9, r9, r10
	ldr	r5, [r1, #8]
	str	r9, [r8, #48]
	ldr	r9, [r8, #52]
	ldr	r4, [r2, #12]
	ldr	r10, [r8, #452]
	eor	r9, r9, r10
	add	lr, lr, r6
	str	r9, [r8, #52]
	ldr	r9, [r8, #56]
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #456]
	adds	r3, r3, r5
	eor	r9, r9, r10
	str	r9, [r8, #56]
	adcs	ip, ip, r4
	ldr	r9, [r8, #60]
	ldr	r10, [r8, #460]
	mov	r6, #0
	eor	r9, r9, r10
	it	cs
	movcs	r6, #1
	str	r9, [r8, #60]
	ldr	r9, [r8, #64]
	ldr	r5, [r1, #12]
	ldr	r10, [r8, #464]
	eor	r9, r9, r10
	ldr	r4, [r2, #8]
	str	r9, [r8, #64]
	ldr	r9, [r8, #68]
	add	lr, lr, r6
	ldr	r10, [r8, #468]
	umull	r5, r4, r5, r4
	eor	r9, r9, r10
	str	r9, [r8, #68]
	adds	r3, r3, r5
	ldr	r9, [r8, #72]
	ldr	r10, [r8, #472]
	adcs	ip, ip, r4
	eor	r9, r9, r10
	mov	r6, #0
	str	r9, [r8, #72]
	ldr	r9, [r8, #76]
	it	cs
	movcs	r6, #1
	ldr	r10, [r8, #476]
	eor	r9, r9, r10
	ldr	r5, [r1, #16]
	str	r9, [r8, #76]
	ldr	r9, [r8, #80]
	ldr	r4, [r2, #4]
	ldr	r10, [r8, #440]
	add	lr, lr, r6
	eor	r9, r9, r10
	str	r9, [r8, #80]
	umull	r5, r4, r5, r4
	ldr	r9, [r8, #84]
	ldr	r10, [r8, #444]
	adds	r3, r3, r5
	eor	r9, r9, r10
	str	r9, [r8, #84]
	adcs	ip, ip, r4
	ldr	r9, [r8, #88]
	mov	r6, #0
	ldr	r10, [r8, #448]
	eor	r9, r9, r10
	it	cs
	movcs	r6, #1
	str	r9, [r8, #88]
	ldr	r9, [r8, #92]
	ldr	r5, [r1, #20]
	ldr	r10, [r8, #452]
	ldr	r4, [r2]
	eor	r9, r9, r10
	str	r9, [r8, #92]
	add	lr, lr, r6
	ldr	r9, [r8, #96]
	ldr	r10, [r8, #456]
	umull	r4, r5, r5, r4
	eor	r9, r9, r10
	str	r9, [r8, #96]
	adds	r4, r3, r4
	ldr	r9, [r8, #100]
	adcs	r3, ip, r5
	ldr	r10, [r8, #460]
	eor	r9, r9, r10
	mov	r6, #0
	str	r9, [r8, #100]
	ldr	r9, [r8, #104]
	it	cs
	movcs	r6, #1
	ldr	r10, [r8, #464]
	str	r4, [r0, #20]
	eor	r9, r9, r10
	str	r9, [r8, #104]
	ldr	r5, [r1]
	ldr	r9, [r8, #108]
	ldr	r10, [r8, #468]
	ldr	r4, [r2, #24]
	eor	r9, r9, r10
	str	r9, [r8, #108]
	add	ip, lr, r6
	ldr	r9, [r8, #112]
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #472]
	eor	r9, r9, r10
	adds	r3, r3, r5
	str	r9, [r8, #112]
	ldr	r9, [r8, #116]
	adcs	ip, ip, r4
	ldr	r10, [r8, #476]
	ldr	r5, [r1, #4]
	eor	r9, r9, r10
	str	r9, [r8, #116]
	ldr	r4, [r2, #20]
	ldr	r9, [r8, #120]
	ldr	r10, [r8, #440]
	mov	lr, #0
	eor	r9, r9, r10
	str	r9, [r8, #120]
	umull	r5, r4, r5, r4
	ldr	r9, [r8, #124]
	it	cs
	movcs	lr, #1
	ldr	r10, [r8, #444]
	eor	r9, r9, r10
	adds	r3, r3, r5
	str	r9, [r8, #124]
	ldr	r9, [r8, #128]
	adcs	ip, ip, r4
	ldr	r10, [r8, #448]
	eor	r9, r9, r10
	mov	r6, #0
	str	r9, [r8, #128]
	it	cs
	movcs	r6, #1
	ldr	r9, [r8, #132]
	ldr	r10, [r8, #452]
	ldr	r5, [r1, #8]
	eor	r9, r9, r10
	str	r9, [r8, #132]
	ldr	r4, [r2, #16]
	ldr	r9, [r8, #136]
	add	lr, lr, r6
	ldr	r10, [r8, #456]
	eor	r9, r9, r10
	umull	r5, r4, r5, r4
	str	r9, [r8, #136]
	ldr	r9, [r8, #140]
	adds	r3, r3, r5
	ldr	r10, [r8, #460]
	eor	r9, r9, r10
	adcs	ip, ip, r4
	str	r9, [r8, #140]
	mov	r6, #0
	ldr	r9, [r8, #144]
	ldr	r10, [r8, #464]
	it	cs
	movcs	r6, #1
	eor	r9, r9, r10
	str	r9, [r8, #144]
	ldr	r5, [r1, #12]
	ldr	r9, [r8, #148]
	ldr	r4, [r2, #12]
	ldr	r10, [r8, #468]
	eor	r9, r9, r10
	add	lr, lr, r6
	str	r9, [r8, #148]
	ldr	r9, [r8, #152]
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #472]
	eor	r9, r9, r10
	adds	r3, r3, r5
	str	r9, [r8, #152]
	adcs	ip, ip, r4
	ldr	r9, [r8, #156]
	ldr	r10, [r8, #476]
	mov	r6, #0
	eor	r9, r9, r10
	str	r9, [r8, #156]
	it	cs
	movcs	r6, #1
	ldr	r9, [r8, #160]
	ldr	r10, [r8, #440]
	ldr	r5, [r1, #16]
	eor	r9, r9, r10
	ldr	r4, [r2, #8]
	str	r9, [r8, #160]
	ldr	r9, [r8, #164]
	add	lr, lr, r6
	ldr	r10, [r8, #444]
	eor	r9, r9, r10
	umull	r5, r4, r5, r4
	str	r9, [r8, #164]
	adds	r3, r3, r5
	ldr	r9, [r8, #168]
	ldr	r10, [r8, #448]
	adcs	ip, ip, r4
	eor	r9, r9, r10
	str	r9, [r8, #168]
	mov	r6, #0
	ldr	r9, [r8, #172]
	ldr	r10, [r8, #452]
	it	cs
	movcs	r6, #1
	eor	r9, r9, r10
	ldr	r5, [r1, #20]
	str	r9, [r8, #172]
	ldr	r9, [r8, #176]
	ldr	r4, [r2, #4]
	ldr	r10, [r8, #456]
	eor	r9, r9, r10
	add	lr, lr, r6
	str	r9, [r8, #176]
	umull	r5, r4, r5, r4
	ldr	r9, [r8, #180]
	ldr	r10, [r8, #460]
	adds	r3, r3, r5
	eor	r9, r9, r10
	str	r9, [r8, #180]
	adcs	ip, ip, r4
	ldr	r9, [r8, #184]
	ldr	r10, [r8, #464]
	mov	r6, #0
	eor	r9, r9, r10
	it	cs
	movcs	r6, #1
	str	r9, [r8, #184]
	ldr	r9, [r8, #188]
	ldr	r5, [r1, #24]
	ldr	r10, [r8, #468]
	eor	r9, r9, r10
	ldr	r4, [r2]
	str	r9, [r8, #188]
	add	lr, lr, r6
	ldr	r9, [r8, #192]
	ldr	r10, [r8, #472]
	umull	r4, r5, r5, r4
	eor	r9, r9, r10
	str	r9, [r8, #192]
	adds	r4, r3, r4
	ldr	r9, [r8, #196]
	ldr	r10, [r8, #476]
	adcs	r3, ip, r5
	eor	r9, r9, r10
	mov	r6, #0
	str	r9, [r8, #196]
	ldr	r9, [r8, #0]
	it	cs
	movcs	r6, #1
	ldr	r10, [r8, #4]
	str	r9, [r8, #200]
	str	r4, [r0, #24]
	str	r10, [r8, #204]
	ldr	r9, [r8, #44]
	ldr	r5, [r1]
	ldr	r10, [r8, #40]
	ldr	r4, [r2, #28]
	lsl	r11, r9, #4
	orr	r11, r11, r10, lsr #28
	add	ip, lr, r6
	str	r11, [r8, #328]
	lsl	r11, r10, #4
	umull	r5, r4, r5, r4
	orr	r11, r11, r9, lsr #28
	adds	r3, r3, r5
	str	r11, [r8, #332]
	ldr	r9, [r8, #80]
	adcs	ip, ip, r4
	ldr	r10, [r8, #84]
	lsl	r11, r9, #3
	ldr	r5, [r1, #4]
	orr	r11, r11, r10, lsr #29
	str	r11, [r8, #256]
	ldr	r4, [r2, #24]
	lsl	r11, r10, #3
	mov	lr, #0
	orr	r11, r11, r9, lsr #29
	str	r11, [r8, #260]
	umull	r5, r4, r5, r4
	ldr	r9, [r8, #124]
	ldr	r10, [r8, #120]
	it	cs
	movcs	lr, #1
	lsl	r11, r9, #9
	adds	r3, r3, r5
	orr	r11, r11, r10, lsr #23
	str	r11, [r8, #384]
	adcs	ip, ip, r4
	lsl	r11, r10, #9
	orr	r11, r11, r9, lsr #23
	mov	r6, #0
	str	r11, [r8, #388]
	ldr	r9, [r8, #160]
	it	cs
	movcs	r6, #1
	ldr	r10, [r8, #164]
	ldr	r5, [r1, #8]
	lsl	r11, r9, #18
	orr	r11, r11, r10, lsr #14
	ldr	r4, [r2, #20]
	str	r11, [r8, #312]
	lsl	r11, r10, #18
	add	lr, lr, r6
	orr	r11, r11, r9, lsr #14
	str	r11, [r8, #316]
	umull	r5, r4, r5, r4
	ldr	r9, [r8, #8]
	adds	r3, r3, r5
	ldr	r10, [r8, #12]
	lsl	r11, r9, #1
	adcs	ip, ip, r4
	orr	r11, r11, r10, lsr #31
	str	r11, [r8, #280]
	mov	r6, #0
	lsl	r11, r10, #1
	it	cs
	movcs	r6, #1
	orr	r11, r11, r9, lsr #31
	str	r11, [r8, #284]
	ldr	r5, [r1, #12]
	ldr	r9, [r8, #52]
	ldr	r10, [r8, #48]
	ldr	r4, [r2, #16]
	lsl	r11, r9, #12
	orr	r11, r11, r10, lsr #20
	add	lr, lr, r6
	str	r11, [r8, #208]
	umull	r5, r4, r5, r4
	lsl	r11, r10, #12
	orr	r11, r11, r9, lsr #20
	adds	r3, r3, r5
	str	r11, [r8, #212]
	ldr	r9, [r8, #88]
	adcs	ip, ip, r4
	ldr	r10, [r8, #92]
	mov	r6, #0
	lsl	r11, r9, #10
	orr	r11, r11, r10, lsr #22
	it	cs
	movcs	r6, #1
	str	r11, [r8, #336]
	lsl	r11, r10, #10
	ldr	r5, [r1, #16]
	orr	r11, r11, r9, lsr #22
	str	r11, [r8, #340]
	ldr	r4, [r2, #12]
	ldr	r9, [r8, #132]
	add	lr, lr, r6
	ldr	r10, [r8, #128]
	lsl	r11, r9, #13
	umull	r5, r4, r5, r4
	orr	r11, r11, r10, lsr #19
	str	r11, [r8, #264]
	adds	r3, r3, r5
	lsl	r11, r10, #13
	adcs	ip, ip, r4
	orr	r11, r11, r9, lsr #19
	str	r11, [r8, #268]
	mov	r6, #0
	ldr	r9, [r8, #168]
	ldr	r10, [r8, #172]
	it	cs
	movcs	r6, #1
	lsl	r11, r9, #2
	orr	r11, r11, r10, lsr #30
	ldr	r5, [r1, #20]
	str	r11, [r8, #392]
	ldr	r4, [r2, #8]
	lsl	r11, r10, #2
	orr	r11, r11, r9, lsr #30
	add	lr, lr, r6
	str	r11, [r8, #396]
	ldr	r9, [r8, #20]
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #16]
	lsl	r11, r9, #30
	adds	r3, r3, r5
	orr	r11, r11, r10, lsr #2
	adcs	ip, ip, r4
	str	r11, [r8, #360]
	lsl	r11, r10, #30
	mov	r6, #0
	orr	r11, r11, r9, lsr #2
	str	r11, [r8, #364]
	it	cs
	movcs	r6, #1
	ldr	r9, [r8, #56]
	ldr	r5, [r1, #24]
	ldr	r10, [r8, #60]
	lsl	r11, r9, #6
	ldr	r4, [r2, #4]
	orr	r11, r11, r10, lsr #26
	str	r11, [r8, #288]
	add	lr, lr, r6
	lsl	r11, r10, #6
	orr	r11, r11, r9, lsr #26
	umull	r5, r4, r5, r4
	str	r11, [r8, #292]
	adds	r3, r3, r5
	ldr	r9, [r8, #100]
	ldr	r10, [r8, #96]
	adcs	ip, ip, r4
	lsl	r11, r9, #11
	orr	r11, r11, r10, lsr #21
	mov	r6, #0
	str	r11, [r8, #216]
	it	cs
	movcs	r6, #1
	lsl	r11, r10, #11
	orr	r11, r11, r9, lsr #21
	ldr	r5, [r1, #28]
	str	r11, [r8, #220]
	ldr	r9, [r8, #136]
	ldr	r4, [r2]
	ldr	r10, [r8, #140]
	lsl	r11, r9, #15
	add	lr, lr, r6
	orr	r11, r11, r10, lsr #17
	umull	r4, r5, r5, r4
	str	r11, [r8, #344]
	lsl	r11, r10, #15
	adds	r4, r3, r4
	orr	r11, r11, r9, lsr #17
	str	r11, [r8, #348]
	adcs	r3, ip, r5
	ldr	r9, [r8, #180]
	ldr	r10, [r8, #176]
	mov	r6, #0
	lsl	r11, r9, #29
	it	cs
	movcs	r6, #1
	orr	r11, r11, r10, lsr #3
	str	r11, [r8, #272]
	str	r4, [r0, #28]
	lsl	r11, r10, #29
	orr	r11, r11, r9, lsr #3
	ldr	r5, [r1, #4]
	str	r11, [r8, #276]
	ldr	r4, [r2, #28]
	ldr	r9, [r8, #24]
	ldr	r10, [r8, #28]
	add	ip, lr, r6
	lsl	r11, r9, #28
	orr	r11, r11, r10, lsr #4
	umull	r5, r4, r5, r4
	str	r11, [r8, #240]
	lsl	r11, r10, #28
	adds	r3, r3, r5
	orr	r11, r11, r9, lsr #4
	adcs	ip, ip, r4
	str	r11, [r8, #244]
	ldr	r9, [r8, #68]
	ldr	r5, [r1, #8]
	ldr	r10, [r8, #64]
	lsl	r11, r9, #23
	ldr	r4, [r2, #24]
	orr	r11, r11, r10, lsr #9
	mov	lr, #0
	str	r11, [r8, #368]
	lsl	r11, r10, #23
	umull	r5, r4, r5, r4
	orr	r11, r11, r9, lsr #9
	str	r11, [r8, #372]
	it	cs
	movcs	lr, #1
	ldr	r9, [r8, #104]
	ldr	r10, [r8, #108]
	adds	r3, r3, r5
	lsl	r11, r9, #25
	adcs	ip, ip, r4
	orr	r11, r11, r10, lsr #7
	str	r11, [r8, #296]
	mov	r6, #0
	lsl	r11, r10, #25
	orr	r11, r11, r9, lsr #7
	it	cs
	movcs	r6, #1
	str	r11, [r8, #300]
	ldr	r9, [r8, #144]
	ldr	r5, [r1, #12]
	ldr	r10, [r8, #148]
	ldr	r4, [r2, #20]
	lsl	r11, r9, #21
	orr	r11, r11, r10, lsr #11
	add	lr, lr, r6
	str	r11, [r8, #224]
	lsl	r11, r10, #21
	umull	r5, r4, r5, r4
	orr	r11, r11, r9, lsr #11
	adds	r3, r3, r5
	str	r11, [r8, #228]
	ldr	r9, [r8, #188]
	adcs	ip, ip, r4
	ldr	r10, [r8, #184]
	lsl	r11, r9, #24
	mov	r6, #0
	orr	r11, r11, r10, lsr #8
	str	r11, [r8, #352]
	it	cs
	movcs	r6, #1
	lsl	r11, r10, #24
	ldr	r5, [r1, #16]
	orr	r11, r11, r9, lsr #8
	str	r11, [r8, #356]
	ldr	r4, [r2, #16]
	ldr	r9, [r8, #32]
	ldr	r10, [r8, #36]
	add	lr, lr, r6
	lsl	r11, r9, #27
	umull	r5, r4, r5, r4
	orr	r11, r11, r10, lsr #5
	str	r11, [r8, #320]
	adds	r3, r3, r5
	lsl	r11, r10, #27
	orr	r11, r11, r9, lsr #5
	adcs	ip, ip, r4
	str	r11, [r8, #324]
	ldr	r9, [r8, #72]
	mov	r6, #0
	ldr	r10, [r8, #76]
	it	cs
	movcs	r6, #1
	lsl	r11, r9, #20
	orr	r11, r11, r10, lsr #12
	ldr	r5, [r1, #20]
	str	r11, [r8, #248]
	lsl	r11, r10, #20
	ldr	r4, [r2, #12]
	orr	r11, r11, r9, lsr #12
	add	lr, lr, r6
	str	r11, [r8, #252]
	ldr	r9, [r8, #116]
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #112]
	lsl	r11, r9, #7
	adds	r3, r3, r5
	orr	r11, r11, r10, lsr #25
	str	r11, [r8, #376]
	adcs	ip, ip, r4
	lsl	r11, r10, #7
	mov	r6, #0
	orr	r11, r11, r9, lsr #25
	str	r11, [r8, #380]
	it	cs
	movcs	r6, #1
	ldr	r9, [r8, #152]
	ldr	r10, [r8, #156]
	ldr	r5, [r1, #24]
	lsl	r11, r9, #8
	orr	r11, r11, r10, lsr #24
	ldr	r4, [r2, #8]
	str	r11, [r8, #304]
	add	lr, lr, r6
	lsl	r11, r10, #8
	orr	r11, r11, r9, lsr #24
	umull	r5, r4, r5, r4
	str	r11, [r8, #308]
	ldr	r9, [r8, #192]
	adds	r3, r3, r5
	ldr	r10, [r8, #196]
	adcs	ip, ip, r4
	lsl	r11, r9, #14
	orr	r11, r11, r10, lsr #18
	mov	r6, #0
	str	r11, [r8, #232]
	lsl	r11, r10, #14
	it	cs
	movcs	r6, #1
	orr	r11, r11, r9, lsr #18
	str	r11, [r8, #236]
	ldr	r5, [r1, #28]
	ldr	r9, [r8, #200]
	ldr	r4, [r2, #4]
	ldr	r10, [r8, #208]
	ldr	r11, [r8, #216]
	add	lr, lr, r6
	bic	r11, r11, r10
	eor	r9, r9, r11
	umull	r4, r5, r5, r4
	str	r9, [r8, #0]
	adds	r4, r3, r4
	ldr	r9, [r8, #204]
	ldr	r10, [r8, #212]
	adcs	r3, ip, r5
	ldr	r11, [r8, #220]
	bic	r11, r11, r10
	mov	r6, #0
	eor	r9, r9, r11
	str	r9, [r8, #4]
	it	cs
	movcs	r6, #1
	ldr	r9, [r8, #208]
	str	r4, [r0, #32]
	ldr	r10, [r8, #216]
	ldr	r11, [r8, #224]
	ldr	r5, [r1, #8]
	bic	r11, r11, r10
	eor	r9, r9, r11
	ldr	r4, [r2, #28]
	str	r9, [r8, #8]
	ldr	r9, [r8, #212]
	add	ip, lr, r6
	ldr	r10, [r8, #220]
	umull	r5, r4, r5, r4
	ldr	r11, [r8, #228]
	bic	r11, r11, r10
	adds	r3, r3, r5
	eor	r9, r9, r11
	str	r9, [r8, #12]
	adcs	ip, ip, r4
	ldr	r9, [r8, #216]
	ldr	r5, [r1, #12]
	ldr	r10, [r8, #224]
	ldr	r11, [r8, #232]
	ldr	r4, [r2, #24]
	bic	r11, r11, r10
	eor	r9, r9, r11
	mov	lr, #0
	str	r9, [r8, #16]
	ldr	r9, [r8, #220]
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #228]
	it	cs
	movcs	lr, #1
	ldr	r11, [r8, #236]
	bic	r11, r11, r10
	adds	r3, r3, r5
	eor	r9, r9, r11
	str	r9, [r8, #20]
	adcs	ip, ip, r4
	ldr	r9, [r8, #224]
	mov	r6, #0
	ldr	r10, [r8, #232]
	ldr	r11, [r8, #200]
	it	cs
	movcs	r6, #1
	bic	r11, r11, r10
	eor	r9, r9, r11
	ldr	r5, [r1, #16]
	str	r9, [r8, #24]
	ldr	r9, [r8, #228]
	ldr	r4, [r2, #20]
	ldr	r10, [r8, #236]
	add	lr, lr, r6
	ldr	r11, [r8, #204]
	bic	r11, r11, r10
	umull	r5, r4, r5, r4
	eor	r9, r9, r11
	str	r9, [r8, #28]
	adds	r3, r3, r5
	ldr	r9, [r8, #232]
	adcs	ip, ip, r4
	ldr	r10, [r8, #200]
	ldr	r11, [r8, #208]
	mov	r6, #0
	bic	r11, r11, r10
	eor	r9, r9, r11
	it	cs
	movcs	r6, #1
	str	r9, [r8, #32]
	ldr	r9, [r8, #236]
	ldr	r5, [r1, #20]
	ldr	r10, [r8, #204]
	ldr	r4, [r2, #16]
	ldr	r11, [r8, #212]
	bic	r11, r11, r10
	add	lr, lr, r6
	eor	r9, r9, r11
	str	r9, [r8, #36]
	umull	r5, r4, r5, r4
	ldr	r9, [r8, #240]
	ldr	r10, [r8, #248]
	adds	r3, r3, r5
	ldr	r11, [r8, #256]
	adcs	ip, ip, r4
	bic	r11, r11, r10
	eor	r9, r9, r11
	mov	r6, #0
	str	r9, [r8, #40]
	ldr	r9, [r8, #244]
	it	cs
	movcs	r6, #1
	ldr	r10, [r8, #252]
	ldr	r5, [r1, #24]
	ldr	r11, [r8, #260]
	bic	r11, r11, r10
	ldr	r4, [r2, #12]
	eor	r9, r9, r11
	str	r9, [r8, #44]
	add	lr, lr, r6
	ldr	r9, [r8, #248]
	ldr	r10, [r8, #256]
	umull	r5, r4, r5, r4
	ldr	r11, [r8, #264]
	adds	r3, r3, r5
	bic	r11, r11, r10
	eor	r9, r9, r11
	adcs	ip, ip, r4
	str	r9, [r8, #48]
	ldr	r9, [r8, #252]
	mov	r6, #0
	ldr	r10, [r8, #260]
	it	cs
	movcs	r6, #1
	ldr	r11, [r8, #268]
	bic	r11, r11, r10
	ldr	r5, [r1, #28]
	eor	r9, r9, r11
	str	r9, [r8, #52]
	ldr	r4, [r2, #8]
	ldr	r9, [r8, #256]
	ldr	r10, [r8, #264]
	add	lr, lr, r6
	ldr	r11, [r8, #272]
	umull	r4, r5, r5, r4
	bic	r11, r11, r10
	eor	r9, r9, r11
	adds	r4, r3, r4
	str	r9, [r8, #56]
	ldr	r9, [r8, #260]
	adcs	r3, ip, r5
	ldr	r10, [r8, #268]
	ldr	r11, [r8, #276]
	mov	r6, #0
	bic	r11, r11, r10
	it	cs
	movcs	r6, #1
	eor	r9, r9, r11
	str	r9, [r8, #60]
	str	r4, [r0, #36]
	ldr	r9, [r8, #264]
	ldr	r10, [r8, #272]
	ldr	r5, [r1, #12]
	ldr	r11, [r8, #240]
	ldr	r4, [r2, #28]
	bic	r11, r11, r10
	eor	r9, r9, r11
	add	ip, lr, r6
	str	r9, [r8, #64]
	ldr	r9, [r8, #268]
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #276]
	ldr	r11, [r8, #244]
	adds	r3, r3, r5
	bic	r11, r11, r10
	adcs	ip, ip, r4
	eor	r9, r9, r11
	str	r9, [r8, #68]
	ldr	r5, [r1, #16]
	ldr	r9, [r8, #272]
	ldr	r10, [r8, #240]
	ldr	r4, [r2, #24]
	ldr	r11, [r8, #248]
	mov	lr, #0
	bic	r11, r11, r10
	eor	r9, r9, r11
	umull	r5, r4, r5, r4
	str	r9, [r8, #72]
	ldr	r9, [r8, #276]
	it	cs
	movcs	lr, #1
	ldr	r10, [r8, #244]
	ldr	r11, [r8, #252]
	adds	r3, r3, r5
	bic	r11, r11, r10
	adcs	ip, ip, r4
	eor	r9, r9, r11
	str	r9, [r8, #76]
	mov	r6, #0
	ldr	r9, [r8, #280]
	ldr	r10, [r8, #288]
	it	cs
	movcs	r6, #1
	ldr	r11, [r8, #296]
	bic	r11, r11, r10
	ldr	r5, [r1, #20]
	eor	r9, r9, r11
	ldr	r4, [r2, #20]
	str	r9, [r8, #80]
	ldr	r9, [r8, #284]
	add	lr, lr, r6
	ldr	r10, [r8, #292]
	ldr	r11, [r8, #300]
	umull	r5, r4, r5, r4
	bic	r11, r11, r10
	adds	r3, r3, r5
	eor	r9, r9, r11
	str	r9, [r8, #84]
	adcs	ip, ip, r4
	ldr	r9, [r8, #288]
	ldr	r10, [r8, #296]
	mov	r6, #0
	ldr	r11, [r8, #304]
	bic	r11, r11, r10
	it	cs
	movcs	r6, #1
	eor	r9, r9, r11
	ldr	r5, [r1, #24]
	str	r9, [r8, #88]
	ldr	r9, [r8, #292]
	ldr	r4, [r2, #16]
	ldr	r10, [r8, #300]
	ldr	r11, [r8, #308]
	add	lr, lr, r6
	bic	r11, r11, r10
	umull	r5, r4, r5, r4
	eor	r9, r9, r11
	str	r9, [r8, #92]
	adds	r3, r3, r5
	ldr	r9, [r8, #296]
	ldr	r10, [r8, #304]
	adcs	ip, ip, r4
	ldr	r11, [r8, #312]
	bic	r11, r11, r10
	mov	r6, #0
	eor	r9, r9, r11
	it	cs
	movcs	r6, #1
	str	r9, [r8, #96]
	ldr	r9, [r8, #300]
	ldr	r5, [r1, #28]
	ldr	r10, [r8, #308]
	ldr	r11, [r8, #316]
	ldr	r4, [r2, #12]
	bic	r11, r11, r10
	add	lr, lr, r6
	eor	r9, r9, r11
	str	r9, [r8, #100]
	umull	r4, r5, r5, r4
	ldr	r9, [r8, #304]
	ldr	r10, [r8, #312]
	adds	r4, r3, r4
	ldr	r11, [r8, #280]
	bic	r11, r11, r10
	adcs	r3, ip, r5
	eor	r9, r9, r11
	mov	r6, #0
	str	r9, [r8, #104]
	ldr	r9, [r8, #308]
	it	cs
	movcs	r6, #1
	ldr	r10, [r8, #316]
	ldr	r11, [r8, #284]
	str	r4, [r0, #40]
	bic	r11, r11, r10
	eor	r9, r9, r11
	ldr	r5, [r1, #16]
	str	r9, [r8, #108]
	ldr	r4, [r2, #28]
	ldr	r9, [r8, #312]
	ldr	r10, [r8, #280]
	add	ip, lr, r6
	ldr	r11, [r8, #288]
	bic	r11, r11, r10
	umull	r6, r4, r5, r4
	eor	r9, r9, r11
	adds	r3, r3, r6
	str	r9, [r8, #112]
	ldr	r9, [r8, #316]
	adcs	ip, ip, r4
	ldr	r10, [r8, #284]
	ldr	r11, [r8, #292]
	ldr	r6, [r1, #20]
	bic	r11, r11, r10
	eor	r9, r9, r11
	ldr	r4, [r2, #24]
	str	r9, [r8, #116]
	mov	r5, #0
	ldr	r9, [r8, #320]
	ldr	r10, [r8, #328]
	umull	r6, r4, r6, r4
	ldr	r11, [r8, #336]
	bic	r11, r11, r10
	it	cs
	movcs	r5, #1
	eor	r9, r9, r11
	adds	r3, r3, r6
	str	r9, [r8, #120]
	ldr	r9, [r8, #324]
	adcs	ip, ip, r4
	ldr	r10, [r8, #332]
	ldr	r11, [r8, #340]
	mov	lr, #0
	bic	r11, r11, r10
	eor	r9, r9, r11
	it	cs
	movcs	lr, #1
	str	r9, [r8, #124]
	ldr	r6, [r1, #24]
	ldr	r9, [r8, #328]
	ldr	r10, [r8, #336]
	ldr	r4, [r2, #20]
	ldr	r11, [r8, #344]
	bic	r11, r11, r10
	add	r5, r5, lr
	eor	r9, r9, r11
	str	r9, [r8, #128]
	umull	r6, r4, r6, r4
	ldr	r9, [r8, #332]
	adds	r3, r3, r6
	ldr	r10, [r8, #340]
	ldr	r11, [r8, #348]
	adcs	ip, ip, r4
	bic	r11, r11, r10
	eor	r9, r9, r11
	mov	lr, #0
	str	r9, [r8, #132]
	it	cs
	movcs	lr, #1
	ldr	r9, [r8, #336]
	ldr	r10, [r8, #344]
	ldr	r6, [r1, #28]
	ldr	r11, [r8, #352]
	bic	r11, r11, r10
	ldr	r4, [r2, #16]
	eor	r9, r9, r11
	str	r9, [r8, #136]
	add	r5, r5, lr
	ldr	r9, [r8, #340]
	umull	r4, r6, r6, r4
	ldr	r10, [r8, #348]
	ldr	r11, [r8, #356]
	adds	r4, r3, r4
	bic	r11, r11, r10
	eor	r9, r9, r11
	adcs	r3, ip, r6
	str	r9, [r8, #140]
	mov	lr, #0
	ldr	r9, [r8, #344]
	ldr	r10, [r8, #352]
	it	cs
	movcs	lr, #1
	ldr	r11, [r8, #320]
	bic	r11, r11, r10
	str	r4, [r0, #44]
	eor	r9, r9, r11
	str	r9, [r8, #144]
	add	ip, r5, lr
	ldr	r9, [r8, #348]
	ldr	r4, [r2, #28]
	ldr	r10, [r8, #356]
	ldr	r11, [r8, #324]
	ldr	r5, [r1, #20]
	bic	r11, r11, r10
	eor	r9, r9, r11
	mov	lr, #0
	str	r9, [r8, #148]
	umull	r5, r4, r5, r4
	ldr	r9, [r8, #352]
	ldr	r10, [r8, #320]
	adds	r3, r3, r5
	ldr	r11, [r8, #328]
	bic	r11, r11, r10
	adcs	ip, ip, r4
	eor	r9, r9, r11
	str	r9, [r8, #152]
	ldr	r5, [r1, #24]
	ldr	r9, [r8, #356]
	ldr	r4, [r2, #24]
	ldr	r10, [r8, #324]
	ldr	r11, [r8, #332]
	it	cs
	movcs	lr, #1
	bic	r11, r11, r10
	eor	r9, r9, r11
	umull	r5, r4, r5, r4
	str	r9, [r8, #156]
	ldr	r9, [r8, #360]
	adds	r3, r3, r5
	ldr	r10, [r8, #368]
	adcs	ip, ip, r4
	ldr	r11, [r8, #376]
	bic	r11, r11, r10
	mov	r6, #0
	eor	r9, r9, r11
	str	r9, [r8, #160]
	it	cs
	movcs	r6, #1
	ldr	r9, [r8, #364]
	ldr	r5, [r1, #28]
	ldr	r10, [r8, #372]
	ldr	r11, [r8, #380]
	ldr	r4, [r2, #20]
	bic	r11, r11, r10
	eor	r9, r9, r11
	add	lr, lr, r6
	str	r9, [r8, #164]
	ldr	r9, [r8, #368]
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #376]
	adds	r3, r3, r5
	ldr	r11, [r8, #384]
	bic	r11, r11, r10
	adcs	ip, ip, r4
	eor	r9, r9, r11
	str	r9, [r8, #168]
	mov	r6, #0
	ldr	r9, [r8, #372]
	it	cs
	movcs	r6, #1
	ldr	r10, [r8, #380]
	ldr	r11, [r8, #388]
	str	r3, [r0, #48]
	bic	r11, r11, r10
	eor	r9, r9, r11
	ldr	r3, [r2, #28]
	str	r9, [r8, #172]
	ldr	r9, [r8, #376]
	ldr	r4, [r1, #24]
	ldr	r10, [r8, #384]
	add	lr, lr, r6
	ldr	r11, [r8, #392]
	bic	r11, r11, r10
	umull	r5, r4, r4, r3
	eor	r9, r9, r11
	str	r9, [r8, #176]
	adds	ip, ip, r5
	ldr	r9, [r8, #380]
	ldr	r10, [r8, #388]
	adcs	lr, lr, r4
	ldr	r11, [r8, #396]
	ldr	r5, [r1, #28]
	bic	r11, r11, r10
	eor	r9, r9, r11
	ldr	r4, [r2, #24]
	str	r9, [r8, #180]
	ldr	r9, [r8, #384]
	mov	r3, #0
	ldr	r10, [r8, #392]
	umull	r4, r6, r5, r4
	ldr	r11, [r8, #360]
	bic	r11, r11, r10
	it	cs
	movcs	r3, #1
	eor	r9, r9, r11
	str	r9, [r8, #184]
	adds	r4, ip, r4
	ldr	r9, [r8, #388]
	ldr	r10, [r8, #396]
	adcs	lr, lr, r6
	ldr	r11, [r8, #364]
	mov	r5, #0
	bic	r11, r11, r10
	eor	r9, r9, r11
	it	cs
	movcs	r5, #1
	str	r9, [r8, #188]
	ldr	r9, [r8, #392]
	str	r4, [r0, #52]
	ldr	r10, [r8, #360]
	ldr	r4, [r1, #28]
	ldr	r11, [r8, #368]
	bic	r11, r11, r10
	ldr	r1, [r2, #28]
	eor	r9, r9, r11
	str	r9, [r8, #192]
	add	r3, r3, r5
	ldr	r9, [r8, #396]
	ldr	r10, [r8, #364]
	umull	r2, r1, r4, r1
	ldr	r11, [r8, #372]
	adds	r2, lr, r2
	bic	r11, r11, r10
	eor	r9, r9, r11
	adcs	r3, r3, r1
	str	r9, [r8, #196]
	ldr	r9, [r8, #0]
	strd	r2, r3, [r0, #56]
	eor	r9, r9, #1
	str	r9, [r8, #0]
	pop	{r4-r11, pc}

// 예산 스윕: 6-reg 융합 라운드 단독
.global round6_frag
.type round6_frag, %function
.thumb_func
.balign 16
round6_frag:
	push	{r4-r11, lr}
	mov	r8, r0
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
	pop	{r4-r11, pc}

// zip: mul256(6-fixed) x round6
.global mul256_round6_stitched
.type mul256_round6_stitched, %function
.thumb_func
.balign 16
mul256_round6_stitched:
	push	{r4-r11, lr}
	movw	r8, #:lower16:g_theta_state
	movt	r8, #:upper16:g_theta_state
	movs	r3, #0
	ldr	r9, [r8, #0]
	ldr	r5, [r2]
	ldr	r10, [r8, #40]
	ldr	r4, [r1]
	eor	r9, r9, r10
	sub	sp, sp, #12
	ldr	r10, [r8, #80]
	umull	r4, lr, r4, r5
	eor	r9, r9, r10
	str	r4, [r0]
	ldr	r10, [r8, #120]
	ldr	r4, [r2]
	eor	r9, r9, r10
	ldr	r5, [r1, #4]
	ldr	r10, [r8, #160]
	str	r0, [sp]
	eor	r9, r9, r10
	str	r9, [r8, #400]
	umull	r0, r5, r5, r4
	ldr	r9, [r8, #4]
	ldr	r4, [r2, #4]
	ldr	r10, [r8, #44]
	str	r0, [sp, #4]
	eor	r9, r9, r10
	ldr	r0, [r1]
	ldr	r10, [r8, #84]
	mov	ip, r3
	eor	r9, r9, r10
	umlal	lr, r3, r0, r4
	ldr	r10, [r8, #124]
	ldr	r0, [sp, #4]
	eor	r9, r9, r10
	adds	r4, r0, lr
	ldr	r10, [r8, #164]
	eor	r9, r9, r10
	adcs	r3, r3, r5
	str	r9, [r8, #404]
	it	cs
	movcs	ip, #1
	ldr	r9, [r8, #8]
	ldr	r0, [sp]
	ldr	r10, [r8, #48]
	mov	lr, #0
	eor	r9, r9, r10
	str	r4, [r0, #4]
	ldr	r10, [r8, #88]
	ldr	r5, [r1]
	eor	r9, r9, r10
	ldr	r4, [r2, #8]
	ldr	r10, [r8, #128]
	ldr	r0, [r1, #4]
	eor	r9, r9, r10
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #168]
	eor	r9, r9, r10
	adds	r3, r3, r5
	str	r9, [r8, #408]
	adcs	ip, ip, r4
	ldr	r9, [r8, #12]
	ldr	r4, [r2, #4]
	ldr	r10, [r8, #52]
	it	cs
	movcs	lr, #1
	eor	r9, r9, r10
	umull	r4, r0, r0, r4
	ldr	r10, [r8, #92]
	adds	r4, r3, r4
	eor	r9, r9, r10
	adcs	ip, ip, r0
	ldr	r10, [r8, #132]
	mov	r5, #0
	eor	r9, r9, r10
	ldr	r10, [r8, #172]
	it	cs
	movcs	r5, #1
	eor	r9, r9, r10
	ldr	r3, [r2]
	str	r9, [r8, #412]
	add	lr, lr, r5
	ldr	r9, [r8, #16]
	ldr	r5, [r1, #8]
	ldr	r10, [r8, #56]
	movs	r0, #0
	eor	r9, r9, r10
	umull	r5, r3, r5, r3
	ldr	r10, [r8, #96]
	adds	r5, r4, r5
	eor	r9, r9, r10
	adcs	r3, ip, r3
	ldr	r10, [r8, #136]
	it	cs
	movcs	r0, #1
	eor	r9, r9, r10
	ldr	r10, [r8, #176]
	ldr	r4, [sp]
	eor	r9, r9, r10
	mov	ip, #0
	str	r9, [r8, #416]
	str	r5, [r4, #8]
	ldr	r9, [r8, #20]
	mov	r5, r0
	ldr	r10, [r8, #60]
	ldr	r4, [r2, #12]
	eor	r9, r9, r10
	ldr	r0, [r1]
	ldr	r10, [r8, #100]
	add	r5, r5, lr
	eor	r9, r9, r10
	umull	lr, r4, r0, r4
	ldr	r10, [r8, #140]
	eor	r9, r9, r10
	adds	r3, r3, lr
	ldr	r10, [r8, #180]
	adcs	r5, r5, r4
	eor	r9, r9, r10
	ldr	r0, [r2, #8]
	str	r9, [r8, #420]
	ldr	r4, [r1, #4]
	ldr	r9, [r8, #24]
	it	cs
	movcs	ip, #1
	ldr	r10, [r8, #64]
	umull	r4, r0, r4, r0
	eor	r9, r9, r10
	adds	r4, r3, r4
	ldr	r10, [r8, #104]
	adcs	r3, r5, r0
	eor	r9, r9, r10
	mov	r0, r3
	ldr	r10, [r8, #144]
	eor	r9, r9, r10
	ldr	r5, [r2, #4]
	ldr	r10, [r8, #184]
	ldr	r3, [r1, #8]
	eor	r9, r9, r10
	mov	lr, #0
	str	r9, [r8, #424]
	umull	r3, r5, r3, r5
	ldr	r9, [r8, #28]
	it	cs
	movcs	lr, #1
	ldr	r10, [r8, #68]
	adds	r3, r4, r3
	eor	r9, r9, r10
	mov	r4, r0
	ldr	r10, [r8, #108]
	adcs	r4, r4, r5
	eor	r9, r9, r10
	ldr	r10, [r8, #148]
	mov	r0, r4
	eor	r9, r9, r10
	ldr	r5, [r1, #12]
	ldr	r10, [r8, #188]
	ldr	r4, [r2]
	eor	r9, r9, r10
	add	lr, lr, ip
	str	r9, [r8, #428]
	umull	r5, r4, r5, r4
	ldr	r9, [r8, #32]
	mov	ip, #0
	ldr	r10, [r8, #72]
	it	cs
	movcs	ip, #1
	eor	r9, r9, r10
	adds	r5, r3, r5
	ldr	r10, [r8, #112]
	mov	r3, r0
	eor	r9, r9, r10
	ldr	r10, [r8, #152]
	adcs	r3, r3, r4
	eor	r9, r9, r10
	mov	r4, r3
	ldr	r10, [r8, #192]
	add	lr, lr, ip
	eor	r9, r9, r10
	mov	ip, #0
	str	r9, [r8, #432]
	it	cs
	movcs	ip, #1
	ldr	r9, [r8, #36]
	ldr	r3, [sp]
	ldr	r10, [r8, #76]
	add	lr, lr, ip
	eor	r9, r9, r10
	str	r5, [r3, #12]
	ldr	r10, [r8, #116]
	eor	r9, r9, r10
	ldr	r5, [r1]
	ldr	r10, [r8, #156]
	ldr	r3, [r2, #16]
	eor	r9, r9, r10
	mov	ip, #0
	ldr	r10, [r8, #196]
	umull	r5, r3, r5, r3
	eor	r9, r9, r10
	adds	r4, r4, r5
	str	r9, [r8, #436]
	adcs	lr, lr, r3
	ldr	r9, [r8, #408]
	ldr	r5, [r2, #12]
	ldr	r10, [r8, #412]
	ldr	r3, [r1, #4]
	lsl	r11, r9, #1
	it	cs
	movcs	ip, #1
	orr	r11, r11, r10, lsr #31
	ldr	r9, [r8, #432]
	umull	r3, r5, r3, r5
	eor	r11, r11, r9
	adds	r3, r4, r3
	str	r11, [r8, #440]
	adcs	lr, lr, r5
	ldr	r9, [r8, #408]
	ldr	r4, [r1, #8]
	lsl	r11, r10, #1
	ldr	r5, [r2, #8]
	orr	r11, r11, r9, lsr #31
	mov	r0, #0
	ldr	r10, [r8, #436]
	umull	r4, r5, r4, r5
	eor	r11, r11, r10
	it	cs
	movcs	r0, #1
	str	r11, [r8, #444]
	ldr	r9, [r8, #416]
	adds	r4, r3, r4
	ldr	r10, [r8, #420]
	adcs	lr, lr, r5
	lsl	r11, r9, #1
	it	cs
	movcs	r3, #1
	orr	r11, r11, r10, lsr #31
	add	ip, ip, r0
	ldr	r9, [r8, #400]
	mov	r0, #0
	eor	r11, r11, r9
	it	cs
	movcs	r0, r3
	str	r11, [r8, #448]
	ldr	r5, [r2, #4]
	ldr	r9, [r8, #416]
	ldr	r3, [r1, #12]
	lsl	r11, r10, #1
	add	ip, ip, r0
	orr	r11, r11, r9, lsr #31
	ldr	r10, [r8, #404]
	umull	r3, r5, r3, r5
	eor	r11, r11, r10
	adds	r3, r4, r3
	str	r11, [r8, #452]
	adcs	lr, lr, r5
	ldr	r9, [r8, #424]
	ldr	r4, [r2]
	ldr	r10, [r8, #428]
	ldr	r5, [r1, #16]
	lsl	r11, r9, #1
	mov	r0, #0
	orr	r11, r11, r10, lsr #31
	umull	r5, r4, r5, r4
	ldr	r9, [r8, #408]
	it	cs
	movcs	r0, #1
	eor	r11, r11, r9
	str	r11, [r8, #456]
	adds	r5, r3, r5
	ldr	r9, [r8, #424]
	adcs	r4, lr, r4
	lsl	r11, r10, #1
	it	cs
	movcs	r3, #1
	orr	r11, r11, r9, lsr #31
	add	ip, ip, r0
	ldr	r10, [r8, #412]
	mov	r0, #0
	eor	r11, r11, r10
	it	cs
	movcs	r0, r3
	str	r11, [r8, #460]
	ldr	r3, [sp]
	ldr	r9, [r8, #432]
	str	r5, [r3, #16]
	ldr	r10, [r8, #436]
	mov	r5, r0
	lsl	r11, r9, #1
	orr	r11, r11, r10, lsr #31
	ldr	r3, [r2, #20]
	ldr	r9, [r8, #416]
	ldr	r0, [r1]
	eor	r11, r11, r9
	add	r5, r5, ip
	str	r11, [r8, #464]
	umull	lr, r3, r0, r3
	ldr	r9, [r8, #432]
	adds	r4, r4, lr
	lsl	r11, r10, #1
	adcs	r5, r5, r3
	orr	r11, r11, r9, lsr #31
	ldr	r0, [r2, #16]
	ldr	r10, [r8, #420]
	ldr	r3, [r1, #4]
	eor	r11, r11, r10
	str	r11, [r8, #468]
	mov	ip, #0
	ldr	r9, [r8, #400]
	umull	r3, r0, r3, r0
	ldr	r10, [r8, #404]
	it	cs
	movcs	ip, #1
	lsl	r11, r9, #1
	adds	r3, r4, r3
	orr	r11, r11, r10, lsr #31
	adcs	r0, r5, r0
	ldr	r9, [r8, #424]
	ldr	r4, [r1, #8]
	eor	r11, r11, r9
	ldr	r5, [r2, #12]
	str	r11, [r8, #472]
	mov	lr, #0
	ldr	r9, [r8, #400]
	lsl	r11, r10, #1
	umull	r4, r5, r4, r5
	orr	r11, r11, r9, lsr #31
	it	cs
	movcs	lr, #1
	ldr	r10, [r8, #428]
	adds	r4, r3, r4
	eor	r11, r11, r10
	mov	r3, r0
	str	r11, [r8, #476]
	adcs	r3, r3, r5
	ldr	r6, [r8, #440]
	mov	r0, r3
	ldr	r7, [r8, #444]
	ldr	r5, [r2, #8]
	ldr	r9, [r8, #0]
	ldr	r3, [r1, #12]
	ldr	r10, [r8, #4]
	add	lr, lr, ip
	eor	r9, r9, r6
	eor	r10, r10, r7
	umull	r3, r5, r3, r5
	str	r9, [r8, #200]
	mov	ip, #0
	str	r10, [r8, #204]
	it	cs
	movcs	ip, #1
	ldr	r9, [r8, #40]
	adds	r3, r4, r3
	ldr	r10, [r8, #44]
	mov	r4, r0
	eor	r9, r9, r6
	adcs	r4, r4, r5
	eor	r10, r10, r7
	mov	r0, r4
	lsl	r11, r10, #4
	ldr	r5, [r2, #4]
	orr	r11, r11, r9, lsr #28
	str	r11, [r8, #328]
	ldr	r4, [r1, #16]
	lsl	r11, r9, #4
	add	lr, lr, ip
	orr	r11, r11, r10, lsr #28
	umull	r4, r5, r4, r5
	str	r11, [r8, #332]
	mov	ip, #0
	ldr	r9, [r8, #80]
	it	cs
	movcs	ip, #1
	ldr	r10, [r8, #84]
	adds	r4, r3, r4
	eor	r9, r9, r6
	mov	r3, r0
	eor	r10, r10, r7
	adcs	r3, r3, r5
	lsl	r11, r9, #3
	mov	r0, r3
	orr	r11, r11, r10, lsr #29
	str	r11, [r8, #256]
	ldr	r5, [r1, #20]
	lsl	r11, r10, #3
	ldr	r3, [r2]
	orr	r11, r11, r9, lsr #29
	add	lr, lr, ip
	str	r11, [r8, #260]
	umull	r5, r3, r5, r3
	ldr	r9, [r8, #120]
	mov	ip, #0
	ldr	r10, [r8, #124]
	it	cs
	movcs	ip, #1
	eor	r9, r9, r6
	adds	r5, r4, r5
	eor	r10, r10, r7
	mov	r4, r0
	lsl	r11, r10, #9
	orr	r11, r11, r9, lsr #23
	adcs	r4, r4, r3
	str	r11, [r8, #384]
	mov	r3, r4
	lsl	r11, r9, #9
	add	lr, lr, ip
	orr	r11, r11, r10, lsr #23
	mov	ip, #0
	str	r11, [r8, #388]
	it	cs
	movcs	ip, #1
	ldr	r9, [r8, #160]
	ldr	r0, [sp]
	ldr	r10, [r8, #164]
	add	lr, lr, ip
	eor	r9, r9, r6
	str	r5, [r0, #20]
	eor	r10, r10, r7
	ldr	r5, [r1]
	lsl	r11, r9, #18
	orr	r11, r11, r10, lsr #14
	ldr	r4, [r2, #24]
	str	r11, [r8, #312]
	mov	ip, #0
	lsl	r11, r10, #18
	umull	r5, r4, r5, r4
	orr	r11, r11, r9, lsr #14
	adds	r3, r3, r5
	str	r11, [r8, #316]
	adcs	lr, lr, r4
	ldr	r6, [r8, #448]
	ldr	r5, [r2, #20]
	ldr	r7, [r8, #452]
	ldr	r4, [r1, #4]
	ldr	r9, [r8, #8]
	it	cs
	movcs	ip, #1
	ldr	r10, [r8, #12]
	eor	r9, r9, r6
	umull	r4, r5, r4, r5
	eor	r10, r10, r7
	adds	r4, r3, r4
	lsl	r11, r9, #1
	adcs	lr, lr, r5
	orr	r11, r11, r10, lsr #31
	it	cs
	movcs	r3, #1
	str	r11, [r8, #280]
	mov	r0, #0
	lsl	r11, r10, #1
	it	cs
	movcs	r0, r3
	orr	r11, r11, r9, lsr #31
	ldr	r5, [r2, #16]
	str	r11, [r8, #284]
	ldr	r3, [r1, #8]
	ldr	r9, [r8, #48]
	add	ip, ip, r0
	ldr	r10, [r8, #52]
	eor	r9, r9, r6
	umull	r3, r5, r3, r5
	eor	r10, r10, r7
	adds	r3, r4, r3
	lsl	r11, r10, #12
	adcs	lr, lr, r5
	orr	r11, r11, r9, lsr #20
	ldr	r4, [r1, #12]
	str	r11, [r8, #208]
	ldr	r5, [r2, #12]
	lsl	r11, r9, #12
	mov	r0, #0
	orr	r11, r11, r10, lsr #20
	umull	r4, r5, r4, r5
	str	r11, [r8, #212]
	it	cs
	movcs	r0, #1
	ldr	r9, [r8, #88]
	ldr	r10, [r8, #92]
	adds	r4, r3, r4
	eor	r9, r9, r6
	adcs	lr, lr, r5
	eor	r10, r10, r7
	it	cs
	movcs	r3, #1
	lsl	r11, r9, #10
	add	ip, ip, r0
	orr	r11, r11, r10, lsr #22
	mov	r0, #0
	str	r11, [r8, #336]
	it	cs
	movcs	r0, r3
	lsl	r11, r10, #10
	ldr	r5, [r2, #8]
	orr	r11, r11, r9, lsr #22
	ldr	r3, [r1, #16]
	str	r11, [r8, #340]
	add	ip, ip, r0
	ldr	r9, [r8, #128]
	ldr	r10, [r8, #132]
	umull	r3, r5, r3, r5
	eor	r9, r9, r6
	adds	r3, r4, r3
	eor	r10, r10, r7
	adcs	lr, lr, r5
	lsl	r11, r10, #13
	ldr	r4, [r1, #20]
	orr	r11, r11, r9, lsr #19
	ldr	r5, [r2, #4]
	str	r11, [r8, #264]
	mov	r0, #0
	lsl	r11, r9, #13
	umull	r4, r5, r4, r5
	orr	r11, r11, r10, lsr #19
	it	cs
	movcs	r0, #1
	str	r11, [r8, #268]
	ldr	r9, [r8, #168]
	adds	r4, r3, r4
	ldr	r10, [r8, #172]
	adcs	lr, lr, r5
	eor	r9, r9, r6
	it	cs
	movcs	r3, #1
	eor	r10, r10, r7
	add	ip, ip, r0
	lsl	r11, r9, #2
	mov	r0, #0
	orr	r11, r11, r10, lsr #30
	it	cs
	movcs	r0, r3
	str	r11, [r8, #392]
	ldr	r5, [r1, #24]
	lsl	r11, r10, #2
	ldr	r3, [r2]
	orr	r11, r11, r9, lsr #30
	add	ip, ip, r0
	str	r11, [r8, #396]
	ldr	r6, [r8, #456]
	umull	r5, r3, r5, r3
	ldr	r7, [r8, #460]
	adds	r5, r4, r5
	ldr	r9, [r8, #16]
	adcs	r3, lr, r3
	ldr	r10, [r8, #20]
	mov	r0, #0
	eor	r9, r9, r6
	it	cs
	movcs	r0, #1
	eor	r10, r10, r7
	ldr	r4, [sp]
	lsl	r11, r10, #30
	str	r5, [r4, #24]
	orr	r11, r11, r9, lsr #2
	mov	r5, r0
	str	r11, [r8, #360]
	lsl	r11, r9, #30
	ldr	r4, [r2, #28]
	orr	r11, r11, r10, lsr #2
	ldr	r0, [r1]
	str	r11, [r8, #364]
	add	r5, r5, ip
	ldr	r9, [r8, #56]
	umull	lr, r4, r0, r4
	ldr	r10, [r8, #60]
	adds	r3, r3, lr
	eor	r9, r9, r6
	adcs	r5, r5, r4
	eor	r10, r10, r7
	ldr	r0, [r2, #24]
	lsl	r11, r9, #6
	ldr	r4, [r1, #4]
	orr	r11, r11, r10, lsr #26
	mov	ip, #0
	str	r11, [r8, #288]
	lsl	r11, r10, #6
	umull	r4, r0, r4, r0
	orr	r11, r11, r9, lsr #26
	it	cs
	movcs	ip, #1
	str	r11, [r8, #292]
	adds	r4, r3, r4
	ldr	r9, [r8, #96]
	adcs	r3, r5, r0
	ldr	r10, [r8, #100]
	mov	r0, r3
	eor	r9, r9, r6
	ldr	r5, [r2, #20]
	eor	r10, r10, r7
	ldr	r3, [r1, #8]
	lsl	r11, r10, #11
	mov	lr, #0
	orr	r11, r11, r9, lsr #21
	str	r11, [r8, #216]
	umull	r3, r5, r3, r5
	lsl	r11, r9, #11
	it	cs
	movcs	lr, #1
	orr	r11, r11, r10, lsr #21
	adds	r3, r4, r3
	str	r11, [r8, #220]
	mov	r4, r0
	ldr	r9, [r8, #136]
	adcs	r4, r4, r5
	ldr	r10, [r8, #140]
	mov	r0, r4
	eor	r9, r9, r6
	ldr	r5, [r2, #16]
	eor	r10, r10, r7
	ldr	r4, [r1, #12]
	lsl	r11, r9, #15
	add	lr, lr, ip
	orr	r11, r11, r10, lsr #17
	str	r11, [r8, #344]
	umull	r4, r5, r4, r5
	lsl	r11, r10, #15
	mov	ip, #0
	orr	r11, r11, r9, lsr #17
	it	cs
	movcs	ip, #1
	str	r11, [r8, #348]
	adds	r4, r3, r4
	ldr	r9, [r8, #176]
	mov	r3, r0
	ldr	r10, [r8, #180]
	adcs	r3, r3, r5
	eor	r9, r9, r6
	mov	r0, r3
	eor	r10, r10, r7
	ldr	r5, [r2, #12]
	lsl	r11, r10, #29
	orr	r11, r11, r9, lsr #3
	ldr	r3, [r1, #16]
	str	r11, [r8, #272]
	add	lr, lr, ip
	lsl	r11, r9, #29
	umull	r3, r5, r3, r5
	orr	r11, r11, r10, lsr #3
	mov	ip, #0
	str	r11, [r8, #276]
	it	cs
	movcs	ip, #1
	ldr	r6, [r8, #464]
	adds	r3, r4, r3
	ldr	r7, [r8, #468]
	mov	r4, r0
	ldr	r9, [r8, #24]
	adcs	r4, r4, r5
	ldr	r10, [r8, #28]
	eor	r9, r9, r6
	mov	r0, r4
	eor	r10, r10, r7
	ldr	r5, [r2, #8]
	lsl	r11, r9, #28
	ldr	r4, [r1, #20]
	orr	r11, r11, r10, lsr #4
	add	lr, lr, ip
	str	r11, [r8, #240]
	umull	r4, r5, r4, r5
	lsl	r11, r10, #28
	mov	ip, #0
	orr	r11, r11, r9, lsr #4
	it	cs
	movcs	ip, #1
	str	r11, [r8, #244]
	adds	r4, r3, r4
	ldr	r9, [r8, #64]
	mov	r3, r0
	ldr	r10, [r8, #68]
	eor	r9, r9, r6
	adcs	r3, r3, r5
	eor	r10, r10, r7
	mov	r0, r3
	lsl	r11, r10, #23
	ldr	r5, [r2, #4]
	orr	r11, r11, r9, lsr #9
	ldr	r3, [r1, #24]
	str	r11, [r8, #368]
	add	lr, lr, ip
	lsl	r11, r9, #23
	umull	r3, r5, r3, r5
	orr	r11, r11, r10, lsr #9
	mov	ip, #0
	str	r11, [r8, #372]
	it	cs
	movcs	ip, #1
	ldr	r9, [r8, #104]
	ldr	r10, [r8, #108]
	adds	r3, r4, r3
	eor	r9, r9, r6
	mov	r4, r0
	eor	r10, r10, r7
	adcs	r4, r4, r5
	lsl	r11, r9, #25
	mov	r0, r4
	orr	r11, r11, r10, lsr #7
	ldr	r5, [r1, #28]
	str	r11, [r8, #296]
	ldr	r4, [r2]
	lsl	r11, r10, #25
	add	lr, lr, ip
	orr	r11, r11, r9, lsr #7
	umull	r5, r4, r5, r4
	str	r11, [r8, #300]
	mov	ip, #0
	ldr	r9, [r8, #144]
	ldr	r10, [r8, #148]
	it	cs
	movcs	ip, #1
	eor	r9, r9, r6
	adds	r5, r3, r5
	eor	r10, r10, r7
	mov	r3, r0
	lsl	r11, r9, #21
	adcs	r3, r3, r4
	orr	r11, r11, r10, lsr #11
	mov	r4, r3
	str	r11, [r8, #224]
	add	lr, lr, ip
	lsl	r11, r10, #21
	mov	ip, #0
	orr	r11, r11, r9, lsr #11
	it	cs
	movcs	ip, #1
	str	r11, [r8, #228]
	ldr	r9, [r8, #184]
	ldr	r3, [sp]
	ldr	r10, [r8, #188]
	add	lr, lr, ip
	eor	r9, r9, r6
	str	r5, [r3, #28]
	eor	r10, r10, r7
	ldr	r5, [r1, #4]
	lsl	r11, r10, #24
	ldr	r3, [r2, #28]
	orr	r11, r11, r9, lsr #8
	mov	ip, #0
	str	r11, [r8, #352]
	umull	r5, r3, r5, r3
	lsl	r11, r9, #24
	adds	r4, r4, r5
	orr	r11, r11, r10, lsr #8
	adcs	lr, lr, r3
	str	r11, [r8, #356]
	ldr	r6, [r8, #472]
	ldr	r5, [r2, #24]
	ldr	r7, [r8, #476]
	ldr	r3, [r1, #8]
	ldr	r9, [r8, #32]
	it	cs
	movcs	ip, #1
	ldr	r10, [r8, #36]
	umull	r3, r5, r3, r5
	eor	r9, r9, r6
	adds	r3, r4, r3
	eor	r10, r10, r7
	adcs	lr, lr, r5
	lsl	r11, r9, #27
	ldr	r4, [r1, #12]
	orr	r11, r11, r10, lsr #5
	ldr	r5, [r2, #20]
	str	r11, [r8, #320]
	lsl	r11, r10, #27
	mov	r0, #0
	orr	r11, r11, r9, lsr #5
	umull	r4, r5, r4, r5
	str	r11, [r8, #324]
	it	cs
	movcs	r0, #1
	ldr	r9, [r8, #72]
	adds	r4, r3, r4
	ldr	r10, [r8, #76]
	adcs	lr, lr, r5
	eor	r9, r9, r6
	it	cs
	movcs	r3, #1
	eor	r10, r10, r7
	add	ip, ip, r0
	lsl	r11, r9, #20
	mov	r0, #0
	orr	r11, r11, r10, lsr #12
	it	cs
	movcs	r0, r3
	str	r11, [r8, #248]
	lsl	r11, r10, #20
	ldr	r5, [r2, #16]
	orr	r11, r11, r9, lsr #12
	ldr	r3, [r1, #16]
	str	r11, [r8, #252]
	add	ip, ip, r0
	ldr	r9, [r8, #112]
	umull	r3, r5, r3, r5
	ldr	r10, [r8, #116]
	adds	r3, r4, r3
	eor	r9, r9, r6
	adcs	lr, lr, r5
	eor	r10, r10, r7
	ldr	r4, [r1, #20]
	lsl	r11, r10, #7
	ldr	r5, [r2, #12]
	orr	r11, r11, r9, lsr #25
	str	r11, [r8, #376]
	mov	r0, #0
	lsl	r11, r9, #7
	umull	r4, r5, r4, r5
	orr	r11, r11, r10, lsr #25
	it	cs
	movcs	r0, #1
	str	r11, [r8, #380]
	adds	r4, r3, r4
	ldr	r9, [r8, #152]
	adcs	lr, lr, r5
	ldr	r10, [r8, #156]
	it	cs
	movcs	r3, #1
	eor	r9, r9, r6
	add	ip, ip, r0
	eor	r10, r10, r7
	mov	r0, #0
	lsl	r11, r9, #8
	it	cs
	movcs	r0, r3
	orr	r11, r11, r10, lsr #24
	str	r11, [r8, #304]
	ldr	r5, [r2, #8]
	lsl	r11, r10, #8
	ldr	r3, [r1, #24]
	orr	r11, r11, r9, lsr #24
	add	ip, ip, r0
	str	r11, [r8, #308]
	umull	r3, r5, r3, r5
	ldr	r9, [r8, #192]
	adds	r3, r4, r3
	ldr	r10, [r8, #196]
	adcs	lr, lr, r5
	eor	r9, r9, r6
	ldr	r4, [r2, #4]
	eor	r10, r10, r7
	ldr	r5, [r1, #28]
	lsl	r11, r9, #14
	orr	r11, r11, r10, lsr #18
	mov	r0, #0
	str	r11, [r8, #232]
	umull	r5, r4, r5, r4
	lsl	r11, r10, #14
	it	cs
	movcs	r0, #1
	orr	r11, r11, r9, lsr #18
	adds	r5, r3, r5
	str	r11, [r8, #236]
	adcs	r4, lr, r4
	ldr	r9, [r8, #200]
	it	cs
	movcs	r3, #1
	ldr	r10, [r8, #208]
	add	ip, ip, r0
	ldr	r11, [r8, #216]
	mov	r0, #0
	bic	r6, r11, r10
	it	cs
	movcs	r0, r3
	eor	r6, r6, r9
	str	r6, [r8, #0]
	ldr	r3, [sp]
	ldr	r9, [r8, #224]
	str	r5, [r3, #32]
	bic	r6, r9, r11
	mov	r5, r0
	eor	r6, r6, r10
	ldr	r3, [r2, #28]
	str	r6, [r8, #8]
	ldr	r0, [r1, #8]
	ldr	r10, [r8, #232]
	add	r5, r5, ip
	bic	r6, r10, r9
	umull	lr, r3, r0, r3
	eor	r6, r6, r11
	adds	r4, r4, lr
	str	r6, [r8, #16]
	ldr	r11, [r8, #200]
	adcs	r5, r5, r3
	bic	r6, r11, r10
	ldr	r0, [r2, #24]
	eor	r6, r6, r9
	ldr	r3, [r1, #12]
	str	r6, [r8, #24]
	mov	ip, #0
	ldr	r9, [r8, #208]
	umull	r3, r0, r3, r0
	bic	r6, r9, r11
	it	cs
	movcs	ip, #1
	eor	r6, r6, r10
	adds	r3, r4, r3
	str	r6, [r8, #32]
	adcs	r0, r5, r0
	ldr	r9, [r8, #204]
	ldr	r4, [r1, #16]
	ldr	r10, [r8, #212]
	ldr	r11, [r8, #220]
	ldr	r5, [r2, #20]
	bic	r6, r11, r10
	mov	lr, #0
	eor	r6, r6, r9
	umull	r4, r5, r4, r5
	str	r6, [r8, #4]
	it	cs
	movcs	lr, #1
	ldr	r9, [r8, #228]
	adds	r4, r3, r4
	bic	r6, r9, r11
	mov	r3, r0
	eor	r6, r6, r10
	adcs	r3, r3, r5
	str	r6, [r8, #12]
	mov	r0, r3
	ldr	r10, [r8, #236]
	bic	r6, r10, r9
	ldr	r5, [r2, #16]
	eor	r6, r6, r11
	ldr	r3, [r1, #20]
	str	r6, [r8, #20]
	add	lr, lr, ip
	ldr	r11, [r8, #204]
	umull	r3, r5, r3, r5
	bic	r6, r11, r10
	mov	ip, #0
	eor	r6, r6, r9
	it	cs
	movcs	ip, #1
	str	r6, [r8, #28]
	adds	r3, r4, r3
	ldr	r9, [r8, #212]
	mov	r4, r0
	bic	r6, r9, r11
	adcs	r4, r4, r5
	eor	r6, r6, r10
	str	r6, [r8, #36]
	mov	r0, r4
	ldr	r9, [r8, #240]
	ldr	r5, [r2, #12]
	ldr	r10, [r8, #248]
	ldr	r4, [r1, #24]
	ldr	r11, [r8, #256]
	add	lr, lr, ip
	bic	r6, r11, r10
	umull	r4, r5, r4, r5
	eor	r6, r6, r9
	mov	ip, #0
	str	r6, [r8, #40]
	it	cs
	movcs	ip, #1
	ldr	r9, [r8, #264]
	adds	r4, r3, r4
	bic	r6, r9, r11
	eor	r6, r6, r10
	mov	r3, r0
	str	r6, [r8, #48]
	adcs	r3, r3, r5
	ldr	r10, [r8, #272]
	mov	r0, r3
	bic	r6, r10, r9
	ldr	r5, [r1, #28]
	eor	r6, r6, r11
	ldr	r3, [r2, #8]
	str	r6, [r8, #56]
	add	lr, lr, ip
	ldr	r11, [r8, #240]
	umull	r5, r3, r5, r3
	bic	r6, r11, r10
	mov	ip, #0
	eor	r6, r6, r9
	str	r6, [r8, #64]
	it	cs
	movcs	ip, #1
	ldr	r9, [r8, #248]
	adds	r5, r4, r5
	bic	r6, r9, r11
	mov	r4, r0
	eor	r6, r6, r10
	adcs	r4, r4, r3
	str	r6, [r8, #72]
	mov	r3, r4
	ldr	r9, [r8, #244]
	add	lr, lr, ip
	ldr	r10, [r8, #252]
	mov	ip, #0
	ldr	r11, [r8, #260]
	it	cs
	movcs	ip, #1
	bic	r6, r11, r10
	ldr	r0, [sp]
	eor	r6, r6, r9
	str	r6, [r8, #44]
	add	lr, lr, ip
	ldr	r9, [r8, #268]
	str	r5, [r0, #36]
	bic	r6, r9, r11
	ldr	r5, [r1, #12]
	eor	r6, r6, r10
	ldr	r4, [r2, #28]
	str	r6, [r8, #52]
	mov	ip, #0
	ldr	r10, [r8, #276]
	umull	r5, r4, r5, r4
	bic	r6, r10, r9
	adds	r3, r3, r5
	eor	r6, r6, r11
	adcs	lr, lr, r4
	str	r6, [r8, #60]
	ldr	r11, [r8, #244]
	ldr	r5, [r2, #24]
	bic	r6, r11, r10
	ldr	r4, [r1, #16]
	eor	r6, r6, r9
	it	cs
	movcs	ip, #1
	str	r6, [r8, #68]
	umull	r4, r5, r4, r5
	ldr	r9, [r8, #252]
	adds	r4, r3, r4
	bic	r6, r9, r11
	adcs	lr, lr, r5
	eor	r6, r6, r10
	it	cs
	movcs	r3, #1
	str	r6, [r8, #76]
	mov	r0, #0
	ldr	r9, [r8, #280]
	it	cs
	movcs	r0, r3
	ldr	r10, [r8, #288]
	ldr	r11, [r8, #296]
	ldr	r5, [r2, #20]
	bic	r6, r11, r10
	ldr	r3, [r1, #20]
	eor	r6, r6, r9
	add	ip, ip, r0
	str	r6, [r8, #80]
	umull	r3, r5, r3, r5
	ldr	r9, [r8, #304]
	adds	r3, r4, r3
	bic	r6, r9, r11
	adcs	lr, lr, r5
	eor	r6, r6, r10
	ldr	r4, [r1, #24]
	str	r6, [r8, #88]
	ldr	r5, [r2, #16]
	ldr	r10, [r8, #312]
	bic	r6, r10, r9
	mov	r0, #0
	eor	r6, r6, r11
	umull	r4, r5, r4, r5
	str	r6, [r8, #96]
	it	cs
	movcs	r0, #1
	ldr	r11, [r8, #280]
	adds	r4, r3, r4
	bic	r6, r11, r10
	adcs	lr, lr, r5
	eor	r6, r6, r9
	it	cs
	movcs	r3, #1
	str	r6, [r8, #104]
	add	ip, ip, r0
	ldr	r9, [r8, #288]
	mov	r0, #0
	bic	r6, r9, r11
	it	cs
	movcs	r0, r3
	eor	r6, r6, r10
	str	r6, [r8, #112]
	ldr	r5, [r1, #28]
	ldr	r9, [r8, #284]
	ldr	r3, [r2, #12]
	ldr	r10, [r8, #292]
	add	ip, ip, r0
	ldr	r11, [r8, #300]
	umull	r5, r3, r5, r3
	bic	r6, r11, r10
	adds	r5, r4, r5
	eor	r6, r6, r9
	adcs	r3, lr, r3
	str	r6, [r8, #84]
	mov	r0, #0
	ldr	r9, [r8, #308]
	it	cs
	movcs	r0, #1
	bic	r6, r9, r11
	eor	r6, r6, r10
	ldr	r4, [sp]
	str	r6, [r8, #92]
	str	r5, [r4, #40]
	ldr	r10, [r8, #316]
	mov	r5, r0
	bic	r6, r10, r9
	ldr	r4, [r2, #28]
	eor	r6, r6, r11
	ldr	r0, [r1, #16]
	str	r6, [r8, #100]
	add	r5, r5, ip
	ldr	r11, [r8, #284]
	umull	lr, r4, r0, r4
	bic	r6, r11, r10
	adds	r3, r3, lr
	eor	r6, r6, r9
	ldr	r0, [r2, #24]
	str	r6, [r8, #108]
	ldr	r9, [r8, #292]
	adcs	r5, r5, r4
	bic	r6, r9, r11
	ldr	r4, [r1, #20]
	eor	r6, r6, r10
	mov	ip, #0
	str	r6, [r8, #116]
	umull	r4, r0, r4, r0
	ldr	r9, [r8, #320]
	it	cs
	movcs	ip, #1
	ldr	r10, [r8, #328]
	adds	r4, r3, r4
	ldr	r11, [r8, #336]
	adcs	r3, r5, r0
	bic	r6, r11, r10
	mov	r0, r3
	eor	r6, r6, r9
	str	r6, [r8, #120]
	ldr	r5, [r2, #20]
	ldr	r9, [r8, #344]
	ldr	r3, [r1, #24]
	bic	r6, r9, r11
	mov	lr, #0
	eor	r6, r6, r10
	umull	r3, r5, r3, r5
	str	r6, [r8, #128]
	it	cs
	movcs	lr, #1
	ldr	r10, [r8, #352]
	adds	r3, r4, r3
	bic	r6, r10, r9
	mov	r4, r0
	eor	r6, r6, r11
	adcs	r4, r4, r5
	str	r6, [r8, #136]
	mov	r0, r4
	ldr	r11, [r8, #320]
	bic	r6, r11, r10
	ldr	r5, [r1, #28]
	eor	r6, r6, r9
	ldr	r4, [r2, #16]
	str	r6, [r8, #144]
	add	lr, lr, ip
	ldr	r9, [r8, #328]
	umull	r5, r4, r5, r4
	bic	r6, r9, r11
	mov	ip, #0
	eor	r6, r6, r10
	it	cs
	movcs	ip, #1
	str	r6, [r8, #152]
	adds	r5, r3, r5
	ldr	r9, [r8, #324]
	mov	r3, r0
	ldr	r10, [r8, #332]
	ldr	r11, [r8, #340]
	adcs	r3, r3, r4
	bic	r6, r11, r10
	mov	r4, r3
	eor	r6, r6, r9
	add	lr, lr, ip
	str	r6, [r8, #124]
	mov	ip, #0
	ldr	r9, [r8, #348]
	it	cs
	movcs	ip, #1
	bic	r6, r9, r11
	ldr	r3, [sp]
	eor	r6, r6, r10
	add	lr, lr, ip
	str	r6, [r8, #132]
	str	r5, [r3, #44]
	ldr	r10, [r8, #356]
	ldr	r5, [r1, #20]
	bic	r6, r10, r9
	eor	r6, r6, r11
	ldr	r3, [r2, #28]
	str	r6, [r8, #140]
	mov	ip, #0
	ldr	r11, [r8, #324]
	umull	r5, r3, r5, r3
	bic	r6, r11, r10
	adds	r4, r4, r5
	eor	r6, r6, r9
	adcs	lr, lr, r3
	str	r6, [r8, #148]
	ldr	r5, [r2, #24]
	ldr	r9, [r8, #332]
	ldr	r3, [r1, #24]
	bic	r6, r9, r11
	it	cs
	movcs	ip, #1
	eor	r6, r6, r10
	str	r6, [r8, #156]
	umull	r3, r5, r3, r5
	ldr	r9, [r8, #360]
	adds	r3, r4, r3
	ldr	r10, [r8, #368]
	adcs	lr, lr, r5
	ldr	r11, [r8, #376]
	ldr	r4, [r2, #20]
	bic	r6, r11, r10
	ldr	r5, [r1, #28]
	eor	r6, r6, r9
	mov	r0, #0
	str	r6, [r8, #160]
	umull	r5, r4, r5, r4
	ldr	r9, [r8, #384]
	it	cs
	movcs	r0, #1
	bic	r6, r9, r11
	adds	r5, r3, r5
	eor	r6, r6, r10
	str	r6, [r8, #168]
	adcs	r4, lr, r4
	ldr	r10, [r8, #392]
	it	cs
	movcs	r3, #1
	bic	r6, r10, r9
	add	ip, ip, r0
	eor	r6, r6, r11
	mov	r0, #0
	str	r6, [r8, #176]
	it	cs
	movcs	r0, r3
	ldr	r11, [r8, #360]
	ldr	r3, [sp]
	bic	r6, r11, r10
	str	r5, [r3, #48]
	eor	r6, r6, r9
	mov	r3, r0
	str	r6, [r8, #184]
	ldr	r9, [r8, #368]
	ldr	r5, [r2, #28]
	bic	r6, r9, r11
	ldr	r0, [r1, #24]
	eor	r6, r6, r10
	add	r3, r3, ip
	str	r6, [r8, #192]
	umull	lr, r5, r0, r5
	ldr	r9, [r8, #364]
	adds	r4, r4, lr
	ldr	r10, [r8, #372]
	ldr	r0, [r2, #24]
	ldr	r11, [r8, #380]
	adcs	r3, r3, r5
	bic	r6, r11, r10
	ldr	r5, [r1, #28]
	eor	r6, r6, r9
	mov	ip, #0
	str	r6, [r8, #164]
	ldr	r9, [r8, #388]
	umull	r5, r0, r5, r0
	bic	r6, r9, r11
	it	cs
	movcs	ip, #1
	eor	r6, r6, r10
	adds	r5, r4, r5
	str	r6, [r8, #172]
	adcs	r3, r3, r0
	ldr	r10, [r8, #396]
	mov	lr, #0
	bic	r6, r10, r9
	it	cs
	movcs	lr, #1
	eor	r6, r6, r11
	ldr	r0, [sp]
	str	r6, [r8, #180]
	add	ip, ip, lr
	ldr	r11, [r8, #364]
	bic	r6, r11, r10
	str	r5, [r0, #52]
	eor	r6, r6, r9
	ldr	r1, [r1, #28]
	str	r6, [r8, #188]
	ldr	r2, [r2, #28]
	ldr	r9, [r8, #372]
	umull	r1, r2, r1, r2
	bic	r6, r9, r11
	adds	r3, r3, r1
	eor	r6, r6, r10
	adcs	r2, ip, r2
	str	r6, [r8, #196]
	strd	r3, r2, [r0, #56]
	ldr	r9, [r8, #0]
	add	sp, sp, #12
	eor	r9, r9, #1
	str	r9, [r8, #0]
	pop	{r4-r11, pc}

// k-스윕: 곱x2 x round6
.global mul2_round6_stitched
.type mul2_round6_stitched, %function
.thumb_func
.balign 16
mul2_round6_stitched:
	push	{r4-r11, lr}
	push	{r0-r2}
	movw	r8, #:lower16:g_theta_state
	movt	r8, #:upper16:g_theta_state
	movs	r3, #0
	ldr	r5, [r2]
	ldr	r9, [r8, #0]
	ldr	r4, [r1]
	sub	sp, sp, #12
	ldr	r10, [r8, #40]
	umull	r4, lr, r4, r5
	str	r4, [r0]
	eor	r9, r9, r10
	ldr	r4, [r2]
	ldr	r5, [r1, #4]
	ldr	r10, [r8, #80]
	str	r0, [sp]
	eor	r9, r9, r10
	umull	r0, r5, r5, r4
	ldr	r4, [r2, #4]
	ldr	r10, [r8, #120]
	str	r0, [sp, #4]
	ldr	r0, [r1]
	eor	r9, r9, r10
	mov	ip, r3
	umlal	lr, r3, r0, r4
	ldr	r10, [r8, #160]
	ldr	r0, [sp, #4]
	adds	r4, r0, lr
	eor	r9, r9, r10
	adcs	r3, r3, r5
	str	r9, [r8, #400]
	it	cs
	movcs	ip, #1
	ldr	r0, [sp]
	ldr	r9, [r8, #4]
	mov	lr, #0
	str	r4, [r0, #4]
	ldr	r10, [r8, #44]
	ldr	r5, [r1]
	ldr	r4, [r2, #8]
	eor	r9, r9, r10
	ldr	r0, [r1, #4]
	umull	r5, r4, r5, r4
	ldr	r10, [r8, #84]
	adds	r3, r3, r5
	eor	r9, r9, r10
	adcs	ip, ip, r4
	ldr	r4, [r2, #4]
	ldr	r10, [r8, #124]
	it	cs
	movcs	lr, #1
	umull	r4, r0, r0, r4
	eor	r9, r9, r10
	adds	r4, r3, r4
	adcs	ip, ip, r0
	ldr	r10, [r8, #164]
	mov	r5, #0
	it	cs
	movcs	r5, #1
	eor	r9, r9, r10
	ldr	r3, [r2]
	str	r9, [r8, #404]
	add	lr, lr, r5
	ldr	r5, [r1, #8]
	ldr	r9, [r8, #8]
	movs	r0, #0
	umull	r5, r3, r5, r3
	ldr	r10, [r8, #48]
	adds	r5, r4, r5
	adcs	r3, ip, r3
	eor	r9, r9, r10
	it	cs
	movcs	r0, #1
	ldr	r4, [sp]
	ldr	r10, [r8, #88]
	mov	ip, #0
	eor	r9, r9, r10
	str	r5, [r4, #8]
	mov	r5, r0
	ldr	r10, [r8, #128]
	ldr	r4, [r2, #12]
	ldr	r0, [r1]
	eor	r9, r9, r10
	add	r5, r5, lr
	umull	lr, r4, r0, r4
	ldr	r10, [r8, #168]
	adds	r3, r3, lr
	adcs	r5, r5, r4
	eor	r9, r9, r10
	ldr	r0, [r2, #8]
	str	r9, [r8, #408]
	ldr	r4, [r1, #4]
	it	cs
	movcs	ip, #1
	ldr	r9, [r8, #12]
	umull	r4, r0, r4, r0
	adds	r4, r3, r4
	ldr	r10, [r8, #52]
	adcs	r3, r5, r0
	mov	r0, r3
	eor	r9, r9, r10
	ldr	r5, [r2, #4]
	ldr	r10, [r8, #92]
	ldr	r3, [r1, #8]
	mov	lr, #0
	eor	r9, r9, r10
	umull	r3, r5, r3, r5
	it	cs
	movcs	lr, #1
	ldr	r10, [r8, #132]
	adds	r3, r4, r3
	mov	r4, r0
	eor	r9, r9, r10
	adcs	r4, r4, r5
	mov	r0, r4
	ldr	r10, [r8, #172]
	ldr	r5, [r1, #12]
	eor	r9, r9, r10
	ldr	r4, [r2]
	add	lr, lr, ip
	str	r9, [r8, #412]
	umull	r5, r4, r5, r4
	mov	ip, #0
	ldr	r9, [r8, #16]
	it	cs
	movcs	ip, #1
	adds	r5, r3, r5
	ldr	r10, [r8, #56]
	mov	r3, r0
	adcs	r3, r3, r4
	eor	r9, r9, r10
	mov	r4, r3
	ldr	r10, [r8, #96]
	add	lr, lr, ip
	mov	ip, #0
	eor	r9, r9, r10
	it	cs
	movcs	ip, #1
	ldr	r3, [sp]
	ldr	r10, [r8, #136]
	add	lr, lr, ip
	str	r5, [r3, #12]
	eor	r9, r9, r10
	ldr	r5, [r1]
	ldr	r3, [r2, #16]
	ldr	r10, [r8, #176]
	mov	ip, #0
	eor	r9, r9, r10
	umull	r5, r3, r5, r3
	adds	r4, r4, r5
	str	r9, [r8, #416]
	adcs	lr, lr, r3
	ldr	r5, [r2, #12]
	ldr	r9, [r8, #20]
	ldr	r3, [r1, #4]
	it	cs
	movcs	ip, #1
	ldr	r10, [r8, #60]
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	eor	r9, r9, r10
	adcs	lr, lr, r5
	ldr	r10, [r8, #100]
	ldr	r4, [r1, #8]
	ldr	r5, [r2, #8]
	eor	r9, r9, r10
	mov	r0, #0
	umull	r4, r5, r4, r5
	ldr	r10, [r8, #140]
	it	cs
	movcs	r0, #1
	adds	r4, r3, r4
	eor	r9, r9, r10
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	ldr	r10, [r8, #180]
	add	ip, ip, r0
	eor	r9, r9, r10
	mov	r0, #0
	it	cs
	movcs	r0, r3
	str	r9, [r8, #420]
	ldr	r5, [r2, #4]
	ldr	r3, [r1, #12]
	ldr	r9, [r8, #24]
	add	ip, ip, r0
	umull	r3, r5, r3, r5
	ldr	r10, [r8, #64]
	adds	r3, r4, r3
	eor	r9, r9, r10
	adcs	lr, lr, r5
	ldr	r4, [r2]
	ldr	r10, [r8, #104]
	ldr	r5, [r1, #16]
	mov	r0, #0
	eor	r9, r9, r10
	umull	r5, r4, r5, r4
	it	cs
	movcs	r0, #1
	ldr	r10, [r8, #144]
	adds	r5, r3, r5
	adcs	r4, lr, r4
	eor	r9, r9, r10
	it	cs
	movcs	r3, #1
	ldr	r10, [r8, #184]
	add	ip, ip, r0
	mov	r0, #0
	eor	r9, r9, r10
	it	cs
	movcs	r0, r3
	ldr	r3, [sp]
	str	r9, [r8, #424]
	str	r5, [r3, #16]
	mov	r5, r0
	ldr	r9, [r8, #28]
	ldr	r3, [r2, #20]
	ldr	r0, [r1]
	ldr	r10, [r8, #68]
	add	r5, r5, ip
	eor	r9, r9, r10
	umull	lr, r3, r0, r3
	adds	r4, r4, lr
	ldr	r10, [r8, #108]
	adcs	r5, r5, r3
	ldr	r0, [r2, #16]
	eor	r9, r9, r10
	ldr	r3, [r1, #4]
	mov	ip, #0
	ldr	r10, [r8, #148]
	umull	r3, r0, r3, r0
	it	cs
	movcs	ip, #1
	eor	r9, r9, r10
	adds	r3, r4, r3
	ldr	r10, [r8, #188]
	adcs	r0, r5, r0
	ldr	r4, [r1, #8]
	eor	r9, r9, r10
	ldr	r5, [r2, #12]
	mov	lr, #0
	str	r9, [r8, #428]
	umull	r4, r5, r4, r5
	it	cs
	movcs	lr, #1
	ldr	r9, [r8, #32]
	adds	r4, r3, r4
	mov	r3, r0
	ldr	r10, [r8, #72]
	adcs	r3, r3, r5
	eor	r9, r9, r10
	mov	r0, r3
	ldr	r5, [r2, #8]
	ldr	r10, [r8, #112]
	ldr	r3, [r1, #12]
	add	lr, lr, ip
	eor	r9, r9, r10
	umull	r3, r5, r3, r5
	mov	ip, #0
	ldr	r10, [r8, #152]
	it	cs
	movcs	ip, #1
	adds	r3, r4, r3
	eor	r9, r9, r10
	mov	r4, r0
	ldr	r10, [r8, #192]
	adcs	r4, r4, r5
	mov	r0, r4
	eor	r9, r9, r10
	ldr	r5, [r2, #4]
	ldr	r4, [r1, #16]
	str	r9, [r8, #432]
	add	lr, lr, ip
	umull	r4, r5, r4, r5
	ldr	r9, [r8, #36]
	mov	ip, #0
	ldr	r10, [r8, #76]
	it	cs
	movcs	ip, #1
	adds	r4, r3, r4
	eor	r9, r9, r10
	mov	r3, r0
	adcs	r3, r3, r5
	ldr	r10, [r8, #116]
	mov	r0, r3
	ldr	r5, [r1, #20]
	eor	r9, r9, r10
	ldr	r3, [r2]
	add	lr, lr, ip
	ldr	r10, [r8, #156]
	umull	r5, r3, r5, r3
	eor	r9, r9, r10
	mov	ip, #0
	it	cs
	movcs	ip, #1
	ldr	r10, [r8, #196]
	adds	r5, r4, r5
	mov	r4, r0
	eor	r9, r9, r10
	adcs	r4, r4, r3
	mov	r3, r4
	str	r9, [r8, #436]
	add	lr, lr, ip
	mov	ip, #0
	ldr	r9, [r8, #408]
	it	cs
	movcs	ip, #1
	ldr	r10, [r8, #412]
	ldr	r0, [sp]
	add	lr, lr, ip
	lsl	r11, r9, #1
	str	r5, [r0, #20]
	ldr	r5, [r1]
	orr	r11, r11, r10, lsr #31
	ldr	r4, [r2, #24]
	mov	ip, #0
	ldr	r9, [r8, #432]
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	eor	r11, r11, r9
	adcs	lr, lr, r4
	str	r11, [r8, #440]
	ldr	r5, [r2, #20]
	ldr	r4, [r1, #4]
	ldr	r9, [r8, #408]
	it	cs
	movcs	ip, #1
	umull	r4, r5, r4, r5
	lsl	r11, r10, #1
	adds	r4, r3, r4
	adcs	lr, lr, r5
	orr	r11, r11, r9, lsr #31
	it	cs
	movcs	r3, #1
	mov	r0, #0
	ldr	r10, [r8, #436]
	it	cs
	movcs	r0, r3
	eor	r11, r11, r10
	ldr	r5, [r2, #16]
	ldr	r3, [r1, #8]
	str	r11, [r8, #444]
	add	ip, ip, r0
	umull	r3, r5, r3, r5
	ldr	r9, [r8, #416]
	adds	r3, r4, r3
	adcs	lr, lr, r5
	ldr	r10, [r8, #420]
	ldr	r4, [r1, #12]
	ldr	r5, [r2, #12]
	lsl	r11, r9, #1
	mov	r0, #0
	orr	r11, r11, r10, lsr #31
	umull	r4, r5, r4, r5
	it	cs
	movcs	r0, #1
	ldr	r9, [r8, #400]
	adds	r4, r3, r4
	adcs	lr, lr, r5
	eor	r11, r11, r9
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	str	r11, [r8, #448]
	mov	r0, #0
	it	cs
	movcs	r0, r3
	ldr	r9, [r8, #416]
	ldr	r5, [r2, #8]
	lsl	r11, r10, #1
	ldr	r3, [r1, #16]
	add	ip, ip, r0
	orr	r11, r11, r9, lsr #31
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	ldr	r10, [r8, #404]
	adcs	lr, lr, r5
	ldr	r4, [r1, #20]
	eor	r11, r11, r10
	ldr	r5, [r2, #4]
	str	r11, [r8, #452]
	mov	r0, #0
	umull	r4, r5, r4, r5
	ldr	r9, [r8, #424]
	it	cs
	movcs	r0, #1
	adds	r4, r3, r4
	ldr	r10, [r8, #428]
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	lsl	r11, r9, #1
	add	ip, ip, r0
	mov	r0, #0
	orr	r11, r11, r10, lsr #31
	it	cs
	movcs	r0, r3
	ldr	r9, [r8, #408]
	ldr	r5, [r1, #24]
	ldr	r3, [r2]
	eor	r11, r11, r9
	add	ip, ip, r0
	umull	r5, r3, r5, r3
	str	r11, [r8, #456]
	adds	r5, r4, r5
	adcs	r3, lr, r3
	ldr	r9, [r8, #424]
	mov	r0, #0
	it	cs
	movcs	r0, #1
	lsl	r11, r10, #1
	ldr	r4, [sp]
	orr	r11, r11, r9, lsr #31
	str	r5, [r4, #24]
	mov	r5, r0
	ldr	r10, [r8, #412]
	ldr	r4, [r2, #28]
	ldr	r0, [r1]
	eor	r11, r11, r10
	add	r5, r5, ip
	umull	lr, r4, r0, r4
	str	r11, [r8, #460]
	adds	r3, r3, lr
	adcs	r5, r5, r4
	ldr	r9, [r8, #432]
	ldr	r0, [r2, #24]
	ldr	r10, [r8, #436]
	ldr	r4, [r1, #4]
	mov	ip, #0
	lsl	r11, r9, #1
	umull	r4, r0, r4, r0
	it	cs
	movcs	ip, #1
	orr	r11, r11, r10, lsr #31
	adds	r4, r3, r4
	adcs	r3, r5, r0
	ldr	r9, [r8, #416]
	mov	r0, r3
	ldr	r5, [r2, #20]
	eor	r11, r11, r9
	ldr	r3, [r1, #8]
	str	r11, [r8, #464]
	mov	lr, #0
	umull	r3, r5, r3, r5
	ldr	r9, [r8, #432]
	it	cs
	movcs	lr, #1
	adds	r3, r4, r3
	lsl	r11, r10, #1
	mov	r4, r0
	adcs	r4, r4, r5
	orr	r11, r11, r9, lsr #31
	mov	r0, r4
	ldr	r5, [r2, #16]
	ldr	r10, [r8, #420]
	ldr	r4, [r1, #12]
	eor	r11, r11, r10
	add	lr, lr, ip
	umull	r4, r5, r4, r5
	str	r11, [r8, #468]
	mov	ip, #0
	it	cs
	movcs	ip, #1
	ldr	r9, [r8, #400]
	adds	r4, r3, r4
	mov	r3, r0
	ldr	r10, [r8, #404]
	adcs	r3, r3, r5
	lsl	r11, r9, #1
	mov	r0, r3
	ldr	r5, [r2, #12]
	orr	r11, r11, r10, lsr #31
	ldr	r3, [r1, #16]
	add	lr, lr, ip
	ldr	r9, [r8, #424]
	umull	r3, r5, r3, r5
	mov	ip, #0
	eor	r11, r11, r9
	it	cs
	movcs	ip, #1
	adds	r3, r4, r3
	str	r11, [r8, #472]
	mov	r4, r0
	ldr	r9, [r8, #400]
	adcs	r4, r4, r5
	mov	r0, r4
	lsl	r11, r10, #1
	ldr	r5, [r2, #8]
	ldr	r4, [r1, #20]
	orr	r11, r11, r9, lsr #31
	add	lr, lr, ip
	umull	r4, r5, r4, r5
	ldr	r10, [r8, #428]
	mov	ip, #0
	it	cs
	movcs	ip, #1
	eor	r11, r11, r10
	adds	r4, r3, r4
	str	r11, [r8, #476]
	mov	r3, r0
	adcs	r3, r3, r5
	ldr	r6, [r8, #440]
	mov	r0, r3
	ldr	r5, [r2, #4]
	ldr	r7, [r8, #444]
	ldr	r3, [r1, #24]
	add	lr, lr, ip
	ldr	r9, [r8, #0]
	umull	r3, r5, r3, r5
	mov	ip, #0
	ldr	r10, [r8, #4]
	it	cs
	movcs	ip, #1
	eor	r9, r9, r6
	adds	r3, r4, r3
	mov	r4, r0
	eor	r10, r10, r7
	adcs	r4, r4, r5
	mov	r0, r4
	str	r9, [r8, #200]
	ldr	r5, [r1, #28]
	ldr	r4, [r2]
	str	r10, [r8, #204]
	add	lr, lr, ip
	umull	r5, r4, r5, r4
	ldr	r9, [r8, #40]
	mov	ip, #0
	ldr	r10, [r8, #44]
	it	cs
	movcs	ip, #1
	adds	r5, r3, r5
	eor	r9, r9, r6
	mov	r3, r0
	adcs	r3, r3, r4
	eor	r10, r10, r7
	mov	r4, r3
	add	lr, lr, ip
	lsl	r11, r10, #4
	mov	ip, #0
	it	cs
	movcs	ip, #1
	orr	r11, r11, r9, lsr #28
	ldr	r3, [sp]
	str	r11, [r8, #328]
	add	lr, lr, ip
	str	r5, [r3, #28]
	lsl	r11, r9, #4
	ldr	r5, [r1, #4]
	ldr	r3, [r2, #28]
	orr	r11, r11, r10, lsr #28
	mov	ip, #0
	umull	r5, r3, r5, r3
	str	r11, [r8, #332]
	adds	r4, r4, r5
	ldr	r9, [r8, #80]
	adcs	lr, lr, r3
	ldr	r5, [r2, #24]
	ldr	r10, [r8, #84]
	ldr	r3, [r1, #8]
	it	cs
	movcs	ip, #1
	eor	r9, r9, r6
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	eor	r10, r10, r7
	adcs	lr, lr, r5
	ldr	r4, [r1, #12]
	lsl	r11, r9, #3
	ldr	r5, [r2, #20]
	orr	r11, r11, r10, lsr #29
	mov	r0, #0
	umull	r4, r5, r4, r5
	str	r11, [r8, #256]
	it	cs
	movcs	r0, #1
	adds	r4, r3, r4
	lsl	r11, r10, #3
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	orr	r11, r11, r9, lsr #29
	add	ip, ip, r0
	mov	r0, #0
	str	r11, [r8, #260]
	it	cs
	movcs	r0, r3
	ldr	r9, [r8, #120]
	ldr	r5, [r2, #16]
	ldr	r3, [r1, #16]
	ldr	r10, [r8, #124]
	add	ip, ip, r0
	umull	r3, r5, r3, r5
	eor	r9, r9, r6
	adds	r3, r4, r3
	adcs	lr, lr, r5
	eor	r10, r10, r7
	ldr	r4, [r1, #20]
	ldr	r5, [r2, #12]
	lsl	r11, r10, #9
	mov	r0, #0
	orr	r11, r11, r9, lsr #23
	umull	r4, r5, r4, r5
	it	cs
	movcs	r0, #1
	str	r11, [r8, #384]
	adds	r4, r3, r4
	adcs	lr, lr, r5
	lsl	r11, r9, #9
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	orr	r11, r11, r10, lsr #23
	mov	r0, #0
	it	cs
	movcs	r0, r3
	str	r11, [r8, #388]
	ldr	r5, [r2, #8]
	ldr	r9, [r8, #160]
	ldr	r3, [r1, #24]
	add	ip, ip, r0
	ldr	r10, [r8, #164]
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	eor	r9, r9, r6
	adcs	lr, lr, r5
	ldr	r4, [r2, #4]
	eor	r10, r10, r7
	ldr	r5, [r1, #28]
	mov	r0, #0
	lsl	r11, r9, #18
	umull	r5, r4, r5, r4
	orr	r11, r11, r10, lsr #14
	it	cs
	movcs	r0, #1
	adds	r5, r3, r5
	str	r11, [r8, #312]
	adcs	r4, lr, r4
	it	cs
	movcs	r3, #1
	lsl	r11, r10, #18
	add	ip, ip, r0
	mov	r0, #0
	orr	r11, r11, r9, lsr #14
	it	cs
	movcs	r0, r3
	ldr	r3, [sp]
	str	r11, [r8, #316]
	str	r5, [r3, #32]
	ldr	r6, [r8, #448]
	mov	r5, r0
	ldr	r3, [r2, #28]
	ldr	r7, [r8, #452]
	ldr	r0, [r1, #8]
	add	r5, r5, ip
	ldr	r9, [r8, #8]
	umull	lr, r3, r0, r3
	adds	r4, r4, lr
	ldr	r10, [r8, #12]
	adcs	r5, r5, r3
	eor	r9, r9, r6
	ldr	r0, [r2, #24]
	ldr	r3, [r1, #12]
	eor	r10, r10, r7
	mov	ip, #0
	umull	r3, r0, r3, r0
	lsl	r11, r9, #1
	it	cs
	movcs	ip, #1
	adds	r3, r4, r3
	orr	r11, r11, r10, lsr #31
	adcs	r0, r5, r0
	ldr	r4, [r1, #16]
	str	r11, [r8, #280]
	ldr	r5, [r2, #20]
	lsl	r11, r10, #1
	mov	lr, #0
	umull	r4, r5, r4, r5
	orr	r11, r11, r9, lsr #31
	it	cs
	movcs	lr, #1
	adds	r4, r3, r4
	str	r11, [r8, #284]
	mov	r3, r0
	adcs	r3, r3, r5
	ldr	r9, [r8, #48]
	mov	r0, r3
	ldr	r5, [r2, #16]
	ldr	r10, [r8, #52]
	ldr	r3, [r1, #20]
	eor	r9, r9, r6
	add	lr, lr, ip
	umull	r3, r5, r3, r5
	eor	r10, r10, r7
	mov	ip, #0
	it	cs
	movcs	ip, #1
	lsl	r11, r10, #12
	adds	r3, r4, r3
	mov	r4, r0
	orr	r11, r11, r9, lsr #20
	adcs	r4, r4, r5
	mov	r0, r4
	str	r11, [r8, #208]
	ldr	r5, [r2, #12]
	lsl	r11, r9, #12
	ldr	r4, [r1, #24]
	add	lr, lr, ip
	orr	r11, r11, r10, lsr #20
	umull	r4, r5, r4, r5
	mov	ip, #0
	str	r11, [r8, #212]
	it	cs
	movcs	ip, #1
	adds	r4, r3, r4
	ldr	r9, [r8, #88]
	mov	r3, r0
	adcs	r3, r3, r5
	ldr	r10, [r8, #92]
	mov	r0, r3
	eor	r9, r9, r6
	ldr	r5, [r1, #28]
	ldr	r3, [r2, #8]
	eor	r10, r10, r7
	add	lr, lr, ip
	umull	r5, r3, r5, r3
	lsl	r11, r9, #10
	mov	ip, #0
	it	cs
	movcs	ip, #1
	orr	r11, r11, r10, lsr #22
	adds	r5, r4, r5
	mov	r4, r0
	str	r11, [r8, #336]
	adcs	r4, r4, r3
	lsl	r11, r10, #10
	mov	r3, r4
	add	lr, lr, ip
	orr	r11, r11, r9, lsr #22
	mov	ip, #0
	it	cs
	movcs	ip, #1
	str	r11, [r8, #340]
	ldr	r0, [sp]
	add	lr, lr, ip
	ldr	r9, [r8, #128]
	str	r5, [r0, #36]
	ldr	r10, [r8, #132]
	ldr	r5, [r1, #12]
	ldr	r4, [r2, #28]
	eor	r9, r9, r6
	mov	ip, #0
	umull	r5, r4, r5, r4
	eor	r10, r10, r7
	adds	r3, r3, r5
	adcs	lr, lr, r4
	lsl	r11, r10, #13
	ldr	r5, [r2, #24]
	ldr	r4, [r1, #16]
	orr	r11, r11, r9, lsr #19
	it	cs
	movcs	ip, #1
	str	r11, [r8, #264]
	umull	r4, r5, r4, r5
	adds	r4, r3, r4
	lsl	r11, r9, #13
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	orr	r11, r11, r10, lsr #19
	mov	r0, #0
	it	cs
	movcs	r0, r3
	str	r11, [r8, #268]
	ldr	r5, [r2, #20]
	ldr	r3, [r1, #20]
	ldr	r9, [r8, #168]
	add	ip, ip, r0
	ldr	r10, [r8, #172]
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	eor	r9, r9, r6
	adcs	lr, lr, r5
	ldr	r4, [r1, #24]
	eor	r10, r10, r7
	ldr	r5, [r2, #16]
	mov	r0, #0
	lsl	r11, r9, #2
	umull	r4, r5, r4, r5
	it	cs
	movcs	r0, #1
	orr	r11, r11, r10, lsr #30
	adds	r4, r3, r4
	str	r11, [r8, #392]
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	lsl	r11, r10, #2
	add	ip, ip, r0
	mov	r0, #0
	orr	r11, r11, r9, lsr #30
	it	cs
	movcs	r0, r3
	ldr	r5, [r1, #28]
	str	r11, [r8, #396]
	ldr	r3, [r2, #12]
	add	ip, ip, r0
	ldr	r6, [r8, #456]
	umull	r5, r3, r5, r3
	ldr	r7, [r8, #460]
	adds	r5, r4, r5
	adcs	r3, lr, r3
	ldr	r9, [r8, #16]
	mov	r0, #0
	it	cs
	movcs	r0, #1
	ldr	r10, [r8, #20]
	ldr	r4, [sp]
	str	r5, [r4, #40]
	eor	r9, r9, r6
	mov	r5, r0
	ldr	r4, [r2, #28]
	eor	r10, r10, r7
	ldr	r0, [r1, #16]
	lsl	r11, r10, #30
	add	r5, r5, ip
	umull	lr, r4, r0, r4
	orr	r11, r11, r9, lsr #2
	adds	r3, r3, lr
	ldr	r0, [r2, #24]
	str	r11, [r8, #360]
	adcs	r5, r5, r4
	ldr	r4, [r1, #20]
	lsl	r11, r9, #30
	mov	ip, #0
	orr	r11, r11, r10, lsr #2
	umull	r4, r0, r4, r0
	it	cs
	movcs	ip, #1
	str	r11, [r8, #364]
	adds	r4, r3, r4
	adcs	r3, r5, r0
	ldr	r9, [r8, #56]
	mov	r0, r3
	ldr	r5, [r2, #20]
	ldr	r10, [r8, #60]
	ldr	r3, [r1, #24]
	mov	lr, #0
	eor	r9, r9, r6
	umull	r3, r5, r3, r5
	eor	r10, r10, r7
	it	cs
	movcs	lr, #1
	adds	r3, r4, r3
	lsl	r11, r9, #6
	mov	r4, r0
	adcs	r4, r4, r5
	orr	r11, r11, r10, lsr #26
	mov	r0, r4
	ldr	r5, [r1, #28]
	str	r11, [r8, #288]
	ldr	r4, [r2, #16]
	add	lr, lr, ip
	lsl	r11, r10, #6
	umull	r5, r4, r5, r4
	orr	r11, r11, r9, lsr #26
	mov	ip, #0
	it	cs
	movcs	ip, #1
	str	r11, [r8, #292]
	adds	r5, r3, r5
	mov	r3, r0
	ldr	r9, [r8, #96]
	adcs	r3, r3, r4
	mov	r4, r3
	ldr	r10, [r8, #100]
	add	lr, lr, ip
	mov	ip, #0
	eor	r9, r9, r6
	it	cs
	movcs	ip, #1
	eor	r10, r10, r7
	ldr	r3, [sp]
	add	lr, lr, ip
	lsl	r11, r10, #11
	str	r5, [r3, #44]
	ldr	r5, [r1, #20]
	orr	r11, r11, r9, lsr #21
	ldr	r3, [r2, #28]
	mov	ip, #0
	str	r11, [r8, #216]
	umull	r5, r3, r5, r3
	adds	r4, r4, r5
	lsl	r11, r9, #11
	adcs	lr, lr, r3
	orr	r11, r11, r10, lsr #21
	ldr	r5, [r2, #24]
	ldr	r3, [r1, #24]
	str	r11, [r8, #220]
	it	cs
	movcs	ip, #1
	umull	r3, r5, r3, r5
	ldr	r9, [r8, #136]
	adds	r3, r4, r3
	adcs	lr, lr, r5
	ldr	r10, [r8, #140]
	ldr	r4, [r2, #20]
	ldr	r5, [r1, #28]
	eor	r9, r9, r6
	mov	r0, #0
	eor	r10, r10, r7
	umull	r5, r4, r5, r4
	it	cs
	movcs	r0, #1
	lsl	r11, r9, #15
	adds	r5, r3, r5
	adcs	r4, lr, r4
	orr	r11, r11, r10, lsr #17
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	str	r11, [r8, #344]
	mov	r0, #0
	it	cs
	movcs	r0, r3
	lsl	r11, r10, #15
	ldr	r3, [sp]
	orr	r11, r11, r9, lsr #17
	str	r5, [r3, #48]
	mov	r3, r0
	str	r11, [r8, #348]
	ldr	r5, [r2, #28]
	ldr	r0, [r1, #24]
	ldr	r9, [r8, #176]
	add	r3, r3, ip
	umull	lr, r5, r0, r5
	ldr	r10, [r8, #180]
	adds	r4, r4, lr
	eor	r9, r9, r6
	ldr	r0, [r2, #24]
	adcs	r3, r3, r5
	eor	r10, r10, r7
	ldr	r5, [r1, #28]
	mov	ip, #0
	lsl	r11, r10, #29
	umull	r5, r0, r5, r0
	it	cs
	movcs	ip, #1
	orr	r11, r11, r9, lsr #3
	adds	r5, r4, r5
	adcs	r3, r3, r0
	str	r11, [r8, #272]
	mov	lr, #0
	lsl	r11, r9, #29
	it	cs
	movcs	lr, #1
	ldr	r0, [sp]
	orr	r11, r11, r10, lsr #3
	add	ip, ip, lr
	str	r5, [r0, #52]
	str	r11, [r8, #276]
	ldr	r1, [r1, #28]
	ldr	r2, [r2, #28]
	ldr	r6, [r8, #464]
	umull	r1, r2, r1, r2
	adds	r3, r3, r1
	ldr	r7, [r8, #468]
	adcs	r2, ip, r2
	ldr	r9, [r8, #24]
	strd	r3, r2, [r0, #56]
	add	sp, sp, #12
	ldr	r10, [r8, #28]
	ldr	r0, [sp, #0]
	ldr	r1, [sp, #4]
	eor	r9, r9, r6
	ldr	r2, [sp, #8]
	movs	r3, #0
	eor	r10, r10, r7
	ldr	r5, [r2]
	ldr	r4, [r1]
	lsl	r11, r9, #28
	sub	sp, sp, #12
	orr	r11, r11, r10, lsr #4
	umull	r4, lr, r4, r5
	str	r4, [r0]
	str	r11, [r8, #240]
	ldr	r4, [r2]
	ldr	r5, [r1, #4]
	lsl	r11, r10, #28
	str	r0, [sp]
	umull	r0, r5, r5, r4
	orr	r11, r11, r9, lsr #4
	ldr	r4, [r2, #4]
	str	r0, [sp, #4]
	str	r11, [r8, #244]
	ldr	r0, [r1]
	ldr	r9, [r8, #64]
	mov	ip, r3
	umlal	lr, r3, r0, r4
	ldr	r10, [r8, #68]
	ldr	r0, [sp, #4]
	adds	r4, r0, lr
	eor	r9, r9, r6
	adcs	r3, r3, r5
	it	cs
	movcs	ip, #1
	eor	r10, r10, r7
	ldr	r0, [sp]
	mov	lr, #0
	lsl	r11, r10, #23
	str	r4, [r0, #4]
	orr	r11, r11, r9, lsr #9
	ldr	r5, [r1]
	ldr	r4, [r2, #8]
	str	r11, [r8, #368]
	ldr	r0, [r1, #4]
	umull	r5, r4, r5, r4
	lsl	r11, r9, #23
	adds	r3, r3, r5
	adcs	ip, ip, r4
	orr	r11, r11, r10, lsr #9
	ldr	r4, [r2, #4]
	str	r11, [r8, #372]
	it	cs
	movcs	lr, #1
	umull	r4, r0, r0, r4
	ldr	r9, [r8, #104]
	adds	r4, r3, r4
	adcs	ip, ip, r0
	ldr	r10, [r8, #108]
	mov	r5, #0
	it	cs
	movcs	r5, #1
	eor	r9, r9, r6
	ldr	r3, [r2]
	add	lr, lr, r5
	eor	r10, r10, r7
	ldr	r5, [r1, #8]
	lsl	r11, r9, #25
	movs	r0, #0
	umull	r5, r3, r5, r3
	orr	r11, r11, r10, lsr #7
	adds	r5, r4, r5
	adcs	r3, ip, r3
	str	r11, [r8, #296]
	it	cs
	movcs	r0, #1
	ldr	r4, [sp]
	lsl	r11, r10, #25
	mov	ip, #0
	str	r5, [r4, #8]
	orr	r11, r11, r9, lsr #7
	mov	r5, r0
	str	r11, [r8, #300]
	ldr	r4, [r2, #12]
	ldr	r0, [r1]
	ldr	r9, [r8, #144]
	add	r5, r5, lr
	umull	lr, r4, r0, r4
	ldr	r10, [r8, #148]
	adds	r3, r3, lr
	adcs	r5, r5, r4
	eor	r9, r9, r6
	ldr	r0, [r2, #8]
	ldr	r4, [r1, #4]
	eor	r10, r10, r7
	it	cs
	movcs	ip, #1
	lsl	r11, r9, #21
	umull	r4, r0, r4, r0
	adds	r4, r3, r4
	orr	r11, r11, r10, lsr #11
	adcs	r3, r5, r0
	mov	r0, r3
	str	r11, [r8, #224]
	ldr	r5, [r2, #4]
	ldr	r3, [r1, #8]
	lsl	r11, r10, #21
	mov	lr, #0
	umull	r3, r5, r3, r5
	orr	r11, r11, r9, lsr #11
	it	cs
	movcs	lr, #1
	str	r11, [r8, #228]
	adds	r3, r4, r3
	mov	r4, r0
	ldr	r9, [r8, #184]
	adcs	r4, r4, r5
	mov	r0, r4
	ldr	r10, [r8, #188]
	ldr	r5, [r1, #12]
	ldr	r4, [r2]
	eor	r9, r9, r6
	add	lr, lr, ip
	umull	r5, r4, r5, r4
	eor	r10, r10, r7
	mov	ip, #0
	lsl	r11, r10, #24
	it	cs
	movcs	ip, #1
	adds	r5, r3, r5
	orr	r11, r11, r9, lsr #8
	mov	r3, r0
	adcs	r3, r3, r4
	str	r11, [r8, #352]
	mov	r4, r3
	add	lr, lr, ip
	lsl	r11, r9, #24
	mov	ip, #0
	orr	r11, r11, r10, lsr #8
	it	cs
	movcs	ip, #1
	ldr	r3, [sp]
	str	r11, [r8, #356]
	add	lr, lr, ip
	str	r5, [r3, #12]
	ldr	r6, [r8, #472]
	ldr	r5, [r1]
	ldr	r3, [r2, #16]
	ldr	r7, [r8, #476]
	mov	ip, #0
	umull	r5, r3, r5, r3
	ldr	r9, [r8, #32]
	adds	r4, r4, r5
	ldr	r10, [r8, #36]
	adcs	lr, lr, r3
	ldr	r5, [r2, #12]
	eor	r9, r9, r6
	ldr	r3, [r1, #4]
	it	cs
	movcs	ip, #1
	eor	r10, r10, r7
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	lsl	r11, r9, #27
	adcs	lr, lr, r5
	ldr	r4, [r1, #8]
	orr	r11, r11, r10, lsr #5
	ldr	r5, [r2, #8]
	str	r11, [r8, #320]
	mov	r0, #0
	umull	r4, r5, r4, r5
	lsl	r11, r10, #27
	it	cs
	movcs	r0, #1
	adds	r4, r3, r4
	orr	r11, r11, r9, lsr #5
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	str	r11, [r8, #324]
	add	ip, ip, r0
	mov	r0, #0
	ldr	r9, [r8, #72]
	it	cs
	movcs	r0, r3
	ldr	r10, [r8, #76]
	ldr	r5, [r2, #4]
	ldr	r3, [r1, #12]
	eor	r9, r9, r6
	add	ip, ip, r0
	umull	r3, r5, r3, r5
	eor	r10, r10, r7
	adds	r3, r4, r3
	adcs	lr, lr, r5
	lsl	r11, r9, #20
	ldr	r4, [r2]
	ldr	r5, [r1, #16]
	orr	r11, r11, r10, lsr #12
	mov	r0, #0
	str	r11, [r8, #248]
	umull	r5, r4, r5, r4
	it	cs
	movcs	r0, #1
	lsl	r11, r10, #20
	adds	r5, r3, r5
	adcs	r4, lr, r4
	orr	r11, r11, r9, lsr #12
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	str	r11, [r8, #252]
	mov	r0, #0
	it	cs
	movcs	r0, r3
	ldr	r9, [r8, #112]
	ldr	r3, [sp]
	ldr	r10, [r8, #116]
	str	r5, [r3, #16]
	mov	r5, r0
	eor	r9, r9, r6
	ldr	r3, [r2, #20]
	ldr	r0, [r1]
	eor	r10, r10, r7
	add	r5, r5, ip
	umull	lr, r3, r0, r3
	lsl	r11, r10, #7
	adds	r4, r4, lr
	adcs	r5, r5, r3
	orr	r11, r11, r9, lsr #25
	ldr	r0, [r2, #16]
	str	r11, [r8, #376]
	ldr	r3, [r1, #4]
	mov	ip, #0
	lsl	r11, r9, #7
	umull	r3, r0, r3, r0
	it	cs
	movcs	ip, #1
	orr	r11, r11, r10, lsr #25
	adds	r3, r4, r3
	adcs	r0, r5, r0
	str	r11, [r8, #380]
	ldr	r4, [r1, #8]
	ldr	r9, [r8, #152]
	ldr	r5, [r2, #12]
	mov	lr, #0
	ldr	r10, [r8, #156]
	umull	r4, r5, r4, r5
	it	cs
	movcs	lr, #1
	eor	r9, r9, r6
	adds	r4, r3, r4
	mov	r3, r0
	eor	r10, r10, r7
	adcs	r3, r3, r5
	mov	r0, r3
	lsl	r11, r9, #8
	ldr	r5, [r2, #8]
	orr	r11, r11, r10, lsr #24
	ldr	r3, [r1, #12]
	add	lr, lr, ip
	str	r11, [r8, #304]
	umull	r3, r5, r3, r5
	mov	ip, #0
	lsl	r11, r10, #8
	it	cs
	movcs	ip, #1
	adds	r3, r4, r3
	orr	r11, r11, r9, lsr #24
	mov	r4, r0
	adcs	r4, r4, r5
	str	r11, [r8, #308]
	mov	r0, r4
	ldr	r9, [r8, #192]
	ldr	r5, [r2, #4]
	ldr	r4, [r1, #16]
	ldr	r10, [r8, #196]
	add	lr, lr, ip
	umull	r4, r5, r4, r5
	eor	r9, r9, r6
	mov	ip, #0
	it	cs
	movcs	ip, #1
	eor	r10, r10, r7
	adds	r4, r3, r4
	mov	r3, r0
	lsl	r11, r9, #14
	adcs	r3, r3, r5
	orr	r11, r11, r10, lsr #18
	mov	r0, r3
	ldr	r5, [r1, #20]
	str	r11, [r8, #232]
	ldr	r3, [r2]
	add	lr, lr, ip
	lsl	r11, r10, #14
	umull	r5, r3, r5, r3
	mov	ip, #0
	orr	r11, r11, r9, lsr #18
	it	cs
	movcs	ip, #1
	adds	r5, r4, r5
	str	r11, [r8, #236]
	mov	r4, r0
	ldr	r9, [r8, #200]
	adcs	r4, r4, r3
	mov	r3, r4
	ldr	r10, [r8, #208]
	add	lr, lr, ip
	mov	ip, #0
	ldr	r11, [r8, #216]
	it	cs
	movcs	ip, #1
	ldr	r0, [sp]
	bic	r6, r11, r10
	add	lr, lr, ip
	str	r5, [r0, #20]
	eor	r6, r6, r9
	ldr	r5, [r1]
	str	r6, [r8, #0]
	ldr	r4, [r2, #24]
	mov	ip, #0
	ldr	r9, [r8, #224]
	umull	r5, r4, r5, r4
	adds	r3, r3, r5
	bic	r6, r9, r11
	adcs	lr, lr, r4
	ldr	r5, [r2, #20]
	eor	r6, r6, r10
	ldr	r4, [r1, #4]
	str	r6, [r8, #8]
	it	cs
	movcs	ip, #1
	umull	r4, r5, r4, r5
	ldr	r10, [r8, #232]
	adds	r4, r3, r4
	adcs	lr, lr, r5
	bic	r6, r10, r9
	it	cs
	movcs	r3, #1
	mov	r0, #0
	eor	r6, r6, r11
	it	cs
	movcs	r0, r3
	ldr	r5, [r2, #16]
	str	r6, [r8, #16]
	ldr	r3, [r1, #8]
	ldr	r11, [r8, #200]
	add	ip, ip, r0
	umull	r3, r5, r3, r5
	bic	r6, r11, r10
	adds	r3, r4, r3
	adcs	lr, lr, r5
	eor	r6, r6, r9
	ldr	r4, [r1, #12]
	ldr	r5, [r2, #12]
	str	r6, [r8, #24]
	mov	r0, #0
	umull	r4, r5, r4, r5
	ldr	r9, [r8, #208]
	it	cs
	movcs	r0, #1
	bic	r6, r9, r11
	adds	r4, r3, r4
	adcs	lr, lr, r5
	eor	r6, r6, r10
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	str	r6, [r8, #32]
	mov	r0, #0
	it	cs
	movcs	r0, r3
	ldr	r9, [r8, #204]
	ldr	r5, [r2, #8]
	ldr	r3, [r1, #16]
	ldr	r10, [r8, #212]
	add	ip, ip, r0
	ldr	r11, [r8, #220]
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	bic	r6, r11, r10
	adcs	lr, lr, r5
	ldr	r4, [r1, #20]
	eor	r6, r6, r9
	ldr	r5, [r2, #4]
	mov	r0, #0
	str	r6, [r8, #4]
	umull	r4, r5, r4, r5
	it	cs
	movcs	r0, #1
	ldr	r9, [r8, #228]
	adds	r4, r3, r4
	bic	r6, r9, r11
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	eor	r6, r6, r10
	add	ip, ip, r0
	mov	r0, #0
	str	r6, [r8, #12]
	it	cs
	movcs	r0, r3
	ldr	r5, [r1, #24]
	ldr	r10, [r8, #236]
	ldr	r3, [r2]
	add	ip, ip, r0
	bic	r6, r10, r9
	umull	r5, r3, r5, r3
	eor	r6, r6, r11
	adds	r5, r4, r5
	adcs	r3, lr, r3
	str	r6, [r8, #20]
	mov	r0, #0
	it	cs
	movcs	r0, #1
	ldr	r11, [r8, #204]
	ldr	r4, [sp]
	str	r5, [r4, #24]
	bic	r6, r11, r10
	mov	r5, r0
	eor	r6, r6, r9
	ldr	r4, [r2, #28]
	ldr	r0, [r1]
	str	r6, [r8, #28]
	add	r5, r5, ip
	umull	lr, r4, r0, r4
	ldr	r9, [r8, #212]
	adds	r3, r3, lr
	adcs	r5, r5, r4
	bic	r6, r9, r11
	ldr	r0, [r2, #24]
	ldr	r4, [r1, #4]
	eor	r6, r6, r10
	mov	ip, #0
	str	r6, [r8, #36]
	umull	r4, r0, r4, r0
	it	cs
	movcs	ip, #1
	ldr	r9, [r8, #240]
	adds	r4, r3, r4
	adcs	r3, r5, r0
	ldr	r10, [r8, #248]
	mov	r0, r3
	ldr	r5, [r2, #20]
	ldr	r11, [r8, #256]
	ldr	r3, [r1, #8]
	mov	lr, #0
	bic	r6, r11, r10
	umull	r3, r5, r3, r5
	eor	r6, r6, r9
	it	cs
	movcs	lr, #1
	adds	r3, r4, r3
	str	r6, [r8, #40]
	mov	r4, r0
	adcs	r4, r4, r5
	ldr	r9, [r8, #264]
	mov	r0, r4
	ldr	r5, [r2, #16]
	bic	r6, r9, r11
	ldr	r4, [r1, #12]
	add	lr, lr, ip
	eor	r6, r6, r10
	umull	r4, r5, r4, r5
	str	r6, [r8, #48]
	mov	ip, #0
	it	cs
	movcs	ip, #1
	ldr	r10, [r8, #272]
	adds	r4, r3, r4
	mov	r3, r0
	bic	r6, r10, r9
	adcs	r3, r3, r5
	mov	r0, r3
	eor	r6, r6, r11
	ldr	r5, [r2, #12]
	ldr	r3, [r1, #16]
	str	r6, [r8, #56]
	add	lr, lr, ip
	ldr	r11, [r8, #240]
	umull	r3, r5, r3, r5
	mov	ip, #0
	bic	r6, r11, r10
	it	cs
	movcs	ip, #1
	adds	r3, r4, r3
	eor	r6, r6, r9
	mov	r4, r0
	adcs	r4, r4, r5
	str	r6, [r8, #64]
	mov	r0, r4
	ldr	r5, [r2, #8]
	ldr	r9, [r8, #248]
	ldr	r4, [r1, #20]
	bic	r6, r9, r11
	add	lr, lr, ip
	umull	r4, r5, r4, r5
	eor	r6, r6, r10
	mov	ip, #0
	it	cs
	movcs	ip, #1
	str	r6, [r8, #72]
	adds	r4, r3, r4
	mov	r3, r0
	ldr	r9, [r8, #244]
	adcs	r3, r3, r5
	mov	r0, r3
	ldr	r10, [r8, #252]
	ldr	r5, [r2, #4]
	ldr	r11, [r8, #260]
	ldr	r3, [r1, #24]
	add	lr, lr, ip
	bic	r6, r11, r10
	umull	r3, r5, r3, r5
	mov	ip, #0
	eor	r6, r6, r9
	it	cs
	movcs	ip, #1
	adds	r3, r4, r3
	str	r6, [r8, #44]
	mov	r4, r0
	ldr	r9, [r8, #268]
	adcs	r4, r4, r5
	mov	r0, r4
	bic	r6, r9, r11
	ldr	r5, [r1, #28]
	ldr	r4, [r2]
	eor	r6, r6, r10
	add	lr, lr, ip
	umull	r5, r4, r5, r4
	str	r6, [r8, #52]
	mov	ip, #0
	it	cs
	movcs	ip, #1
	ldr	r10, [r8, #276]
	adds	r5, r3, r5
	bic	r6, r10, r9
	mov	r3, r0
	adcs	r3, r3, r4
	eor	r6, r6, r11
	mov	r4, r3
	add	lr, lr, ip
	str	r6, [r8, #60]
	mov	ip, #0
	it	cs
	movcs	ip, #1
	ldr	r11, [r8, #244]
	ldr	r3, [sp]
	add	lr, lr, ip
	bic	r6, r11, r10
	str	r5, [r3, #28]
	eor	r6, r6, r9
	ldr	r5, [r1, #4]
	ldr	r3, [r2, #28]
	str	r6, [r8, #68]
	mov	ip, #0
	umull	r5, r3, r5, r3
	ldr	r9, [r8, #252]
	adds	r4, r4, r5
	adcs	lr, lr, r3
	bic	r6, r9, r11
	ldr	r5, [r2, #24]
	ldr	r3, [r1, #8]
	eor	r6, r6, r10
	it	cs
	movcs	ip, #1
	str	r6, [r8, #76]
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	ldr	r9, [r8, #280]
	adcs	lr, lr, r5
	ldr	r4, [r1, #12]
	ldr	r10, [r8, #288]
	ldr	r5, [r2, #20]
	mov	r0, #0
	ldr	r11, [r8, #296]
	umull	r4, r5, r4, r5
	it	cs
	movcs	r0, #1
	bic	r6, r11, r10
	adds	r4, r3, r4
	eor	r6, r6, r9
	adcs	lr, lr, r5
	it	cs
	movcs	r3, #1
	str	r6, [r8, #80]
	add	ip, ip, r0
	mov	r0, #0
	ldr	r9, [r8, #304]
	it	cs
	movcs	r0, r3
	ldr	r5, [r2, #16]
	bic	r6, r9, r11
	ldr	r3, [r1, #16]
	add	ip, ip, r0
	eor	r6, r6, r10
	umull	r3, r5, r3, r5
	str	r6, [r8, #88]
	adds	r3, r4, r3
	adcs	lr, lr, r5
	ldr	r10, [r8, #312]
	ldr	r4, [r1, #20]
	ldr	r5, [r2, #12]
	bic	r6, r10, r9
	mov	r0, #0
	umull	r4, r5, r4, r5
	eor	r6, r6, r11
	it	cs
	movcs	r0, #1
	str	r6, [r8, #96]
	adds	r4, r3, r4
	adcs	lr, lr, r5
	ldr	r11, [r8, #280]
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	bic	r6, r11, r10
	mov	r0, #0
	it	cs
	movcs	r0, r3
	eor	r6, r6, r9
	ldr	r5, [r2, #8]
	ldr	r3, [r1, #24]
	str	r6, [r8, #104]
	add	ip, ip, r0
	ldr	r9, [r8, #288]
	umull	r3, r5, r3, r5
	adds	r3, r4, r3
	bic	r6, r9, r11
	adcs	lr, lr, r5
	ldr	r4, [r2, #4]
	eor	r6, r6, r10
	ldr	r5, [r1, #28]
	mov	r0, #0
	str	r6, [r8, #112]
	umull	r5, r4, r5, r4
	it	cs
	movcs	r0, #1
	ldr	r9, [r8, #284]
	adds	r5, r3, r5
	ldr	r10, [r8, #292]
	adcs	r4, lr, r4
	it	cs
	movcs	r3, #1
	ldr	r11, [r8, #300]
	add	ip, ip, r0
	mov	r0, #0
	bic	r6, r11, r10
	it	cs
	movcs	r0, r3
	ldr	r3, [sp]
	eor	r6, r6, r9
	str	r5, [r3, #32]
	mov	r5, r0
	str	r6, [r8, #84]
	ldr	r3, [r2, #28]
	ldr	r9, [r8, #308]
	ldr	r0, [r1, #8]
	add	r5, r5, ip
	bic	r6, r9, r11
	umull	lr, r3, r0, r3
	adds	r4, r4, lr
	eor	r6, r6, r10
	adcs	r5, r5, r3
	ldr	r0, [r2, #24]
	str	r6, [r8, #92]
	ldr	r3, [r1, #12]
	mov	ip, #0
	ldr	r10, [r8, #316]
	umull	r3, r0, r3, r0
	bic	r6, r10, r9
	it	cs
	movcs	ip, #1
	adds	r3, r4, r3
	eor	r6, r6, r11
	adcs	r0, r5, r0
	ldr	r4, [r1, #16]
	str	r6, [r8, #100]
	ldr	r5, [r2, #20]
	mov	lr, #0
	ldr	r11, [r8, #284]
	umull	r4, r5, r4, r5
	it	cs
	movcs	lr, #1
	bic	r6, r11, r10
	adds	r4, r3, r4
	eor	r6, r6, r9
	mov	r3, r0
	adcs	r3, r3, r5
	str	r6, [r8, #108]
	mov	r0, r3
	ldr	r5, [r2, #16]
	ldr	r9, [r8, #292]
	ldr	r3, [r1, #20]
	add	lr, lr, ip
	bic	r6, r9, r11
	umull	r3, r5, r3, r5
	eor	r6, r6, r10
	mov	ip, #0
	it	cs
	movcs	ip, #1
	str	r6, [r8, #116]
	adds	r3, r4, r3
	mov	r4, r0
	ldr	r9, [r8, #320]
	adcs	r4, r4, r5
	mov	r0, r4
	ldr	r10, [r8, #328]
	ldr	r5, [r2, #12]
	ldr	r4, [r1, #24]
	ldr	r11, [r8, #336]
	add	lr, lr, ip
	bic	r6, r11, r10
	umull	r4, r5, r4, r5
	mov	ip, #0
	eor	r6, r6, r9
	it	cs
	movcs	ip, #1
	adds	r4, r3, r4
	str	r6, [r8, #120]
	mov	r3, r0
	adcs	r3, r3, r5
	ldr	r9, [r8, #344]
	mov	r0, r3
	ldr	r5, [r1, #28]
	bic	r6, r9, r11
	ldr	r3, [r2, #8]
	eor	r6, r6, r10
	add	lr, lr, ip
	umull	r5, r3, r5, r3
	str	r6, [r8, #128]
	mov	ip, #0
	it	cs
	movcs	ip, #1
	ldr	r10, [r8, #352]
	adds	r5, r4, r5
	mov	r4, r0
	bic	r6, r10, r9
	adcs	r4, r4, r3
	mov	r3, r4
	eor	r6, r6, r11
	add	lr, lr, ip
	str	r6, [r8, #136]
	mov	ip, #0
	it	cs
	movcs	ip, #1
	ldr	r11, [r8, #320]
	ldr	r0, [sp]
	add	lr, lr, ip
	bic	r6, r11, r10
	str	r5, [r0, #36]
	ldr	r5, [r1, #12]
	eor	r6, r6, r9
	ldr	r4, [r2, #28]
	mov	ip, #0
	str	r6, [r8, #144]
	umull	r5, r4, r5, r4
	ldr	r9, [r8, #328]
	adds	r3, r3, r5
	adcs	lr, lr, r4
	bic	r6, r9, r11
	ldr	r5, [r2, #24]
	ldr	r4, [r1, #16]
	eor	r6, r6, r10
	it	cs
	movcs	ip, #1
	umull	r4, r5, r4, r5
	str	r6, [r8, #152]
	adds	r4, r3, r4
	adcs	lr, lr, r5
	ldr	r9, [r8, #324]
	it	cs
	movcs	r3, #1
	ldr	r10, [r8, #332]
	mov	r0, #0
	it	cs
	movcs	r0, r3
	ldr	r11, [r8, #340]
	ldr	r5, [r2, #20]
	ldr	r3, [r1, #20]
	bic	r6, r11, r10
	add	ip, ip, r0
	umull	r3, r5, r3, r5
	eor	r6, r6, r9
	adds	r3, r4, r3
	adcs	lr, lr, r5
	str	r6, [r8, #124]
	ldr	r4, [r1, #24]
	ldr	r9, [r8, #348]
	ldr	r5, [r2, #16]
	mov	r0, #0
	bic	r6, r9, r11
	umull	r4, r5, r4, r5
	it	cs
	movcs	r0, #1
	eor	r6, r6, r10
	adds	r4, r3, r4
	adcs	lr, lr, r5
	str	r6, [r8, #132]
	it	cs
	movcs	r3, #1
	ldr	r10, [r8, #356]
	add	ip, ip, r0
	mov	r0, #0
	bic	r6, r10, r9
	it	cs
	movcs	r0, r3
	ldr	r5, [r1, #28]
	eor	r6, r6, r11
	ldr	r3, [r2, #12]
	add	ip, ip, r0
	str	r6, [r8, #140]
	umull	r5, r3, r5, r3
	adds	r5, r4, r5
	ldr	r11, [r8, #324]
	adcs	r3, lr, r3
	bic	r6, r11, r10
	mov	r0, #0
	it	cs
	movcs	r0, #1
	eor	r6, r6, r9
	ldr	r4, [sp]
	str	r5, [r4, #40]
	str	r6, [r8, #148]
	mov	r5, r0
	ldr	r4, [r2, #28]
	ldr	r9, [r8, #332]
	ldr	r0, [r1, #16]
	add	r5, r5, ip
	bic	r6, r9, r11
	umull	lr, r4, r0, r4
	eor	r6, r6, r10
	adds	r3, r3, lr
	ldr	r0, [r2, #24]
	str	r6, [r8, #156]
	adcs	r5, r5, r4
	ldr	r4, [r1, #20]
	ldr	r9, [r8, #360]
	mov	ip, #0
	umull	r4, r0, r4, r0
	ldr	r10, [r8, #368]
	it	cs
	movcs	ip, #1
	adds	r4, r3, r4
	ldr	r11, [r8, #376]
	adcs	r3, r5, r0
	bic	r6, r11, r10
	mov	r0, r3
	ldr	r5, [r2, #20]
	eor	r6, r6, r9
	ldr	r3, [r1, #24]
	mov	lr, #0
	str	r6, [r8, #160]
	umull	r3, r5, r3, r5
	it	cs
	movcs	lr, #1
	ldr	r9, [r8, #384]
	adds	r3, r4, r3
	mov	r4, r0
	bic	r6, r9, r11
	adcs	r4, r4, r5
	eor	r6, r6, r10
	mov	r0, r4
	ldr	r5, [r1, #28]
	str	r6, [r8, #168]
	ldr	r4, [r2, #16]
	add	lr, lr, ip
	ldr	r10, [r8, #392]
	umull	r5, r4, r5, r4
	mov	ip, #0
	bic	r6, r10, r9
	it	cs
	movcs	ip, #1
	adds	r5, r3, r5
	eor	r6, r6, r11
	mov	r3, r0
	str	r6, [r8, #176]
	adcs	r3, r3, r4
	mov	r4, r3
	ldr	r11, [r8, #360]
	add	lr, lr, ip
	mov	ip, #0
	bic	r6, r11, r10
	it	cs
	movcs	ip, #1
	ldr	r3, [sp]
	eor	r6, r6, r9
	add	lr, lr, ip
	str	r6, [r8, #184]
	str	r5, [r3, #44]
	ldr	r5, [r1, #20]
	ldr	r9, [r8, #368]
	ldr	r3, [r2, #28]
	mov	ip, #0
	bic	r6, r9, r11
	umull	r5, r3, r5, r3
	adds	r4, r4, r5
	eor	r6, r6, r10
	adcs	lr, lr, r3
	ldr	r5, [r2, #24]
	str	r6, [r8, #192]
	ldr	r3, [r1, #24]
	ldr	r9, [r8, #364]
	it	cs
	movcs	ip, #1
	umull	r3, r5, r3, r5
	ldr	r10, [r8, #372]
	adds	r3, r4, r3
	adcs	lr, lr, r5
	ldr	r11, [r8, #380]
	ldr	r4, [r2, #20]
	ldr	r5, [r1, #28]
	bic	r6, r11, r10
	mov	r0, #0
	umull	r5, r4, r5, r4
	eor	r6, r6, r9
	it	cs
	movcs	r0, #1
	str	r6, [r8, #164]
	adds	r5, r3, r5
	adcs	r4, lr, r4
	ldr	r9, [r8, #388]
	it	cs
	movcs	r3, #1
	add	ip, ip, r0
	bic	r6, r9, r11
	mov	r0, #0
	it	cs
	movcs	r0, r3
	eor	r6, r6, r10
	ldr	r3, [sp]
	str	r5, [r3, #48]
	str	r6, [r8, #172]
	mov	r3, r0
	ldr	r10, [r8, #396]
	ldr	r5, [r2, #28]
	ldr	r0, [r1, #24]
	bic	r6, r10, r9
	add	r3, r3, ip
	umull	lr, r5, r0, r5
	eor	r6, r6, r11
	adds	r4, r4, lr
	ldr	r0, [r2, #24]
	str	r6, [r8, #180]
	adcs	r3, r3, r5
	ldr	r5, [r1, #28]
	ldr	r11, [r8, #364]
	mov	ip, #0
	bic	r6, r11, r10
	umull	r5, r0, r5, r0
	it	cs
	movcs	ip, #1
	eor	r6, r6, r9
	adds	r5, r4, r5
	adcs	r3, r3, r0
	str	r6, [r8, #188]
	mov	lr, #0
	it	cs
	movcs	lr, #1
	ldr	r9, [r8, #372]
	ldr	r0, [sp]
	add	ip, ip, lr
	bic	r6, r9, r11
	str	r5, [r0, #52]
	eor	r6, r6, r10
	ldr	r1, [r1, #28]
	ldr	r2, [r2, #28]
	str	r6, [r8, #196]
	umull	r1, r2, r1, r2
	adds	r3, r3, r1
	ldr	r9, [r8, #0]
	adcs	r2, ip, r2
	strd	r3, r2, [r0, #56]
	eor	r9, r9, #1
	add	sp, sp, #12
	str	r9, [r8, #0]
	add	sp, #12
	pop	{r4-r11, pc}

