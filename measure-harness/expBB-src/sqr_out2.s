	.type apx_real_fe25519_sqr, %function
apx_real_fe25519_sqr:
	.global apx_real_fe25519_sqr
	umull r11,r12,r0,r1
	//frame push {lr}
	mov r8,#0
	//frame address sp,24
	
	//mul 01, 00
	push {lr}
	mov lr,#0
	umull r9,r10,r0,r0
	adds r11,r11,r11
	sub sp,#20
	
	//r9 r10 done
	//r12 carry for 3rd before col
	//r11+C carry for 3rd final col
	
	umaal r10,r11,lr,lr
	//frame address sp,32
	
	//mul 02, 11
	umaal r8,r12,r0,r2
	push {r9,r10}
	umull r9,r10,r0,r3
	adcs r8,r8,r8
	
	//r8 done (3rd col)
	//r12 carry for 4th before col
	//r11+C carry for 4th final col
	
	//mul 03, 12
	umaal r9,r12,r1,r2
	umaal r8,r11,r1,r1
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
	umaal r9,r8,r1,r7 //r1 is now dead
	umaal r9,r10,r2,r6
	
	//r0 done (8th col)
	//r9+r8+r10+r12 carry for 9th before col
	//r11+C carry for 9th final col
	
	//mul 17, 26, 35, 44
	adcs r0,r0,r0
	umaal r12,r9,r3,r5
	umaal r9,r8,r2,r7 //r2 is now dead
	adcs r12,r12,r12
	umaal r10,r9,r3,r6
	
	//r11 done (9th col)
	//r8+r10+r9 carry for 10th before col
	//r12+C carry for 10th final col
	
	//mul 27, 36, 45
	movs r2,#0
	umaal r0,r11,lr,lr
	umaal r10,r2,r4,r5
	umaal r2,r8,r3,r7 //r3 is now dead
	umaal r9,r2,r4,r6
	adcs r10,r10,r10
	
	//r12 done (10th col)
	//r8+r9+r2 carry for 11th before col
	//r10+C carry for 11th final col
	
	//mul 37, 46, 55
	umaal r11,r12,r4,r4
	adcs r9,r9,r9
	umaal r12,r10,lr,lr
	movs r3,#0
	
	//r10 done (11th col)
	//r8+r2 carry for 12th before col
	//r9+C carry for 12th final col
	
	//mul 47, 56
	umaal r10,r9,r5,r5
	umaal r3,r8,r4,r7 //r4 is now dead
	umaal r3,r2,r5,r6
	umaal r8,r2,r5,r7 //r5 is now dead
	umull r4,r5,lr,lr // set 0
	
	//r9 done (12th col)
	//r8+r2 carry for 13th before col
	//r3+C carry for 13th final col
	
	//mul 57, 66
	adcs r3,r3,r3
	umaal r4,r2,r6,r7
	adcs r8,r8,r8
	
	//r3 done (13th col)
	//r2 carry for 14th before col
	//r8+C carry for 14th final col
	
	//mul 67
	umaal r9,r3,lr,lr
	umaal r3,r8,r6,r6
	adcs r4,r4,r4
	umaal r4,r8,lr,lr
	
	//r4 done (14th col)
	//r2 carry for 15th before col
	//r8+C carry for 15th final col
	
	//mul 77
	adcs r2,r2,r2
	umaal r8,r2,r7,r7
	mov r6,#38
	
	//r8 done (15th col)
	//r2 done (16th col)
	
	//msb -> lsb: r2 r8 r4 r3 r9 r10 r12 r11 r0 sp+24 sp+20 sp+16 sp+12 sp+8 sp+4 sp
	//lr: 0
	//now do reduction
	
	adcs r2,r2,lr
	umaal r0,lr,r6,r2
	movs r5,#19
	lsl lr,lr,#1
	and r7,r0,#0x7fffffff
	orr lr,lr,r0, lsr #31
	pop {r0,r1}
	
	mul lr,lr,r5
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
	pop {pc}
	
	add r7,r7,lr
	
	.size apx_real_fe25519_sqr, .-apx_real_fe25519_sqr
