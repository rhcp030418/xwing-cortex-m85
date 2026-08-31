/* 실험 BM-B (X01-v2): 평탄화본을 단일 블록으로 재정렬한 판.
 *
 * 사전등록: 2026-08-26_expBM_x01v2_flatframe_prereg.md
 * 원본(apx_real_fe25519_mul)의 중간 push/pop 을 고정 오프셋 str/ldr 로 바꿔
 * 본문 내내 sp 를 고정한다. **명령 수·메모리 워드 수 불변.**
 *
 * 프레임(진입 sp = E, 본문 sp = E-48):
 *   [sp,#0] r6   [sp,#16] 저장1  [sp,#32] 저장5
 *   [sp,#4] r7   [sp,#20] 저장2  [sp,#36] r0 임시
 *   [sp,#8] r8   [sp,#24] 저장3  [sp,#40] 저장된 r2(인자)
 *   [sp,#12] r9  [sp,#28] 저장4  [sp,#44] lr
 *
 * ABI 는 원본과 동일: 입력 *r1=a, *r2=b / 출력 r0-r7 / r8-r12 clobber.
 */
	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits
	.align 2

	.type fe25519_mul_sched, %function
	.global fe25519_mul_sched
fe25519_mul_sched:
	.global fe25519_mul_sched
	push {r2,lr}
	
	sub sp,#40
	ldm r2,{r2,r3,r4,r5}
	
	ldm r1!,{r0,r10,lr}
	umull r6,r11,r2,r0
	
	umull r7,r12,r3,r0
	umaal r7,r11,r2,r10
	
	strd r6,r7,[sp,#0]
	
	umull r8,r6,r4,r0
	umaal r8,r11,r3,r10
	
	umull r9,r7,r5,r0
	umaal r8,r12,r2,lr
	
	umaal r9,r11,r4,r10
	
	umaal r11,r7,r5,r10
	umaal r9,r12,r3,lr
	umaal r11,r12,r4,lr
	umaal r12,r7,r5,lr
	
	ldm r1!,{r0,r10,lr}
	
	umaal r9,r6,r2,r0
	umaal r11,r6,r3,r0
	strd r8,r9,[sp,#8]
	mov r9,#0
	
	umaal r12,r6,r4,r0
	
	umaal r11,r9,r2,r10
	ldr r8,[r1],#4
	umaal r6,r7,r5,r0
	umaal r12,r9,r3,r10
	mov r0,#0
	
	umaal r6,r9,r4,r10
	umaal r7,r9,r5,r10
	mov r10,#0
	umaal r12,r10,r2,lr
	umaal r6,r10,r3,lr
	
	umaal r7,r10,r4,lr
	umaal r9,r10,r5,lr
	mov lr,#0
	umaal lr,r6,r2,r8
	umaal r7,r6,r3,r8
	umaal r9,r6,r4,r8
	
	//_ _ _ _ _ 6 10 9| 7 | lr 12 11 _ _ _ _
	
	umaal r10,r6,r5,r8
	ldr r8,[r1],#-28
	umaal r7,r0,r2,r8
	umaal r9,r0,r3,r8
	ldr r2,[sp,#40]
	umaal r10,r0,r4,r8
	
	umaal r6,r0,r5,r8
	
	//_ _ _ _ s 6 10 9| 7 | lr 12 11 _ _ _ _
	
	adds r2,r2,#16
	ldm r2,{r2,r3,r4,r5}
	ldr r8,[r1],#4
	
	str r0,[sp,#36]
	mov r0,#0
	umaal r11,r0,r2,r8
	umaal r12,r0,r3,r8
	umaal lr,r0,r4,r8
	umaal r0,r7,r5,r8 // 7=carry for 9
	ldr r8,[r1],#4
	
	//_ _ _ _ s 6 10 9+7| 0 | lr 12 _ _ _ _ _
	
	str r11,[sp,#16]
	mov r11,#0
	umaal r12,r11,r2,r8
	umaal lr,r11,r3,r8
	umaal r0,r11,r4,r8
	umaal r11,r7,r5,r8 // 7=carry for 10
	ldr r8,[r1],#4
	
	//_ _ _ _ s 6 10+7 9+11| 0 | lr _ _ _ _ _ _
	
	str r12,[sp,#20]
	mov r12,#0
	umaal lr,r12,r2,r8
	umaal r0,r12,r3,r8
	umaal r11,r12,r4,r8
	umaal r10,r12,r5,r8 // 12=carry for 6
	ldr r8,[r1],#4
	
	//_ _ _ _ s 6+12 10+7 9+11| 0 | _ _ _ _ _ _ _
	
	str lr,[sp,#24]
	mov lr,#0
	umaal r0,lr,r2,r8
	umaal r11,lr,r3,r8
	umaal r10,lr,r4,r8
	umaal r6,lr,r5,r8 // lr=carry for saved
	str r0,[sp,#28]
	
	//_ _ _ _ s+lr 6+12 10+7 9+11| _ | _ _ _ _ _ _ _
	
	ldm r1!,{r0,r8}
	umaal r11,r9,r2,r0
	umaal r9,r10,r3,r0
	str r11,[sp,#32]
	ldr r11,[sp,#36]
	umaal r9,r7,r2,r8
	umaal r10,r6,r4,r0
	
	//_ _ _ 6 11+lr 10+12 9+7 _ | _ | _ _ _ _ _ _ _
	
	umaal r11,r6,r5,r0 // 6=carry for next
	umaal r10,r7,r3,r8
	umaal r11,r7,r4,r8
	umaal r6,r7,r5,r8
	
	ldm r1!,{r0,r8}
	umaal r10,r12,r2,r0
	umaal r11,r12,r3,r0
	umaal r6,r12,r4,r0
	umaal r11,lr,r2,r8
	
	umaal r6,lr,r3,r8
	umaal r7,r12,r5,r0
	movs r3,#38
	umaal lr,r7,r4,r8
	
	// 12 7 lr 6 11 10 9 stack*9
	
	//now reduce
	
	ldm sp,{r0,r1,r2}
	umaal r7,r12,r5,r8
	ldrd r4,r5,[sp,#28]
	mov r8,#0
	umaal r4,r8,r3,r12
	lsl r8,r8,#1
	and r12,r4,#0x7fffffff
	orr r8,r8,r4, lsr #31
	movs r4,#19
	
	mul r8,r8,r4
	umaal r0,r8,r3,r5
	umaal r1,r8,r3,r9
	umaal r2,r8,r3,r10
	mov r9,#38
	ldrd r3,r4,[sp,#12]
	umaal r3,r8,r9,r11
	umaal r4,r8,r9,r6
	ldrd r5,r6,[sp,#20]
	umaal r5,r8,r9,lr
	umaal r6,r8,r9,r7
	add r7,r8,r12
	
	add sp,#44
	pop {pc}
	
	.size fe25519_mul_sched, .-fe25519_mul_sched

/* expCJ에서는 x01_dispatch.S가 원본/재스케줄 공통 진입점을 소유한다. */
