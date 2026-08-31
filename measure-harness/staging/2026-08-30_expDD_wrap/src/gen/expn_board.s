.text
.syntax unified
.thumb

// 실험 N: 페어링 스펙트럼 (gen_exp_n.py 생성)
// pairn_veor (611 instrs)
.global pairn_veor
.type pairn_veor, %function
.thumb_func
.balign 16
pairn_veor:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r12, r0
	movw r6, #:lower16:g_mve
	movt r6, #:upper16:g_mve
	add r9, r6, #1024
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	veor q3, q3, q4
	veor q4, q4, q5
	veor q5, q5, q6
	veor q6, q6, q7
	veor q7, q7, q0
	veor q0, q0, q1
	veor q1, q1, q2
	veor q2, q2, q3
	subs r12, r12, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// pairn_veor_zip (1222 instrs)
.global pairn_veor_zip
.type pairn_veor_zip, %function
.thumb_func
.balign 16
pairn_veor_zip:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r12, r0
	movw r6, #:lower16:g_mve
	movt r6, #:upper16:g_mve
	add r9, r6, #1024
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	veor q6, q6, q7
	umaal r0, r1, r2, r3
	veor q7, q7, q0
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	veor q2, q2, q3
	subs r12, r12, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// pairn_ldr (611 instrs)
.global pairn_ldr
.type pairn_ldr, %function
.thumb_func
.balign 16
pairn_ldr:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r12, r0
	movw r6, #:lower16:g_mve
	movt r6, #:upper16:g_mve
	add r9, r6, #1024
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	vldrw.u32 q0, [r6, #0]
	vldrw.u32 q1, [r6, #16]
	vldrw.u32 q2, [r6, #32]
	vldrw.u32 q3, [r6, #48]
	vldrw.u32 q4, [r6, #64]
	vldrw.u32 q5, [r6, #80]
	vldrw.u32 q6, [r6, #96]
	vldrw.u32 q7, [r6, #112]
	vldrw.u32 q0, [r6, #128]
	vldrw.u32 q1, [r6, #144]
	vldrw.u32 q2, [r6, #160]
	vldrw.u32 q3, [r6, #176]
	vldrw.u32 q4, [r6, #192]
	vldrw.u32 q5, [r6, #208]
	vldrw.u32 q6, [r6, #224]
	vldrw.u32 q7, [r6, #240]
	vldrw.u32 q0, [r6, #256]
	vldrw.u32 q1, [r6, #272]
	vldrw.u32 q2, [r6, #288]
	vldrw.u32 q3, [r6, #304]
	vldrw.u32 q4, [r6, #320]
	vldrw.u32 q5, [r6, #336]
	vldrw.u32 q6, [r6, #352]
	vldrw.u32 q7, [r6, #368]
	vldrw.u32 q0, [r6, #384]
	vldrw.u32 q1, [r6, #0]
	vldrw.u32 q2, [r6, #16]
	vldrw.u32 q3, [r6, #32]
	vldrw.u32 q4, [r6, #48]
	vldrw.u32 q5, [r6, #64]
	vldrw.u32 q6, [r6, #80]
	vldrw.u32 q7, [r6, #96]
	vldrw.u32 q0, [r6, #112]
	vldrw.u32 q1, [r6, #128]
	vldrw.u32 q2, [r6, #144]
	vldrw.u32 q3, [r6, #160]
	vldrw.u32 q4, [r6, #176]
	vldrw.u32 q5, [r6, #192]
	vldrw.u32 q6, [r6, #208]
	vldrw.u32 q7, [r6, #224]
	vldrw.u32 q0, [r6, #240]
	vldrw.u32 q1, [r6, #256]
	vldrw.u32 q2, [r6, #272]
	vldrw.u32 q3, [r6, #288]
	vldrw.u32 q4, [r6, #304]
	vldrw.u32 q5, [r6, #320]
	vldrw.u32 q6, [r6, #336]
	vldrw.u32 q7, [r6, #352]
	vldrw.u32 q0, [r6, #368]
	vldrw.u32 q1, [r6, #384]
	vldrw.u32 q2, [r6, #0]
	vldrw.u32 q3, [r6, #16]
	vldrw.u32 q4, [r6, #32]
	vldrw.u32 q5, [r6, #48]
	vldrw.u32 q6, [r6, #64]
	vldrw.u32 q7, [r6, #80]
	vldrw.u32 q0, [r6, #96]
	vldrw.u32 q1, [r6, #112]
	vldrw.u32 q2, [r6, #128]
	vldrw.u32 q3, [r6, #144]
	vldrw.u32 q4, [r6, #160]
	vldrw.u32 q5, [r6, #176]
	vldrw.u32 q6, [r6, #192]
	vldrw.u32 q7, [r6, #208]
	vldrw.u32 q0, [r6, #224]
	vldrw.u32 q1, [r6, #240]
	vldrw.u32 q2, [r6, #256]
	vldrw.u32 q3, [r6, #272]
	vldrw.u32 q4, [r6, #288]
	vldrw.u32 q5, [r6, #304]
	vldrw.u32 q6, [r6, #320]
	vldrw.u32 q7, [r6, #336]
	vldrw.u32 q0, [r6, #352]
	vldrw.u32 q1, [r6, #368]
	vldrw.u32 q2, [r6, #384]
	vldrw.u32 q3, [r6, #0]
	vldrw.u32 q4, [r6, #16]
	vldrw.u32 q5, [r6, #32]
	vldrw.u32 q6, [r6, #48]
	vldrw.u32 q7, [r6, #64]
	vldrw.u32 q0, [r6, #80]
	vldrw.u32 q1, [r6, #96]
	vldrw.u32 q2, [r6, #112]
	vldrw.u32 q3, [r6, #128]
	vldrw.u32 q4, [r6, #144]
	vldrw.u32 q5, [r6, #160]
	vldrw.u32 q6, [r6, #176]
	vldrw.u32 q7, [r6, #192]
	vldrw.u32 q0, [r6, #208]
	vldrw.u32 q1, [r6, #224]
	vldrw.u32 q2, [r6, #240]
	vldrw.u32 q3, [r6, #256]
	vldrw.u32 q4, [r6, #272]
	vldrw.u32 q5, [r6, #288]
	vldrw.u32 q6, [r6, #304]
	vldrw.u32 q7, [r6, #320]
	vldrw.u32 q0, [r6, #336]
	vldrw.u32 q1, [r6, #352]
	vldrw.u32 q2, [r6, #368]
	vldrw.u32 q3, [r6, #384]
	vldrw.u32 q4, [r6, #0]
	vldrw.u32 q5, [r6, #16]
	vldrw.u32 q6, [r6, #32]
	vldrw.u32 q7, [r6, #48]
	vldrw.u32 q0, [r6, #64]
	vldrw.u32 q1, [r6, #80]
	vldrw.u32 q2, [r6, #96]
	vldrw.u32 q3, [r6, #112]
	vldrw.u32 q4, [r6, #128]
	vldrw.u32 q5, [r6, #144]
	vldrw.u32 q6, [r6, #160]
	vldrw.u32 q7, [r6, #176]
	vldrw.u32 q0, [r6, #192]
	vldrw.u32 q1, [r6, #208]
	vldrw.u32 q2, [r6, #224]
	vldrw.u32 q3, [r6, #240]
	vldrw.u32 q4, [r6, #256]
	vldrw.u32 q5, [r6, #272]
	vldrw.u32 q6, [r6, #288]
	vldrw.u32 q7, [r6, #304]
	vldrw.u32 q0, [r6, #320]
	vldrw.u32 q1, [r6, #336]
	vldrw.u32 q2, [r6, #352]
	vldrw.u32 q3, [r6, #368]
	vldrw.u32 q4, [r6, #384]
	vldrw.u32 q5, [r6, #0]
	vldrw.u32 q6, [r6, #16]
	vldrw.u32 q7, [r6, #32]
	vldrw.u32 q0, [r6, #48]
	vldrw.u32 q1, [r6, #64]
	vldrw.u32 q2, [r6, #80]
	vldrw.u32 q3, [r6, #96]
	vldrw.u32 q4, [r6, #112]
	vldrw.u32 q5, [r6, #128]
	vldrw.u32 q6, [r6, #144]
	vldrw.u32 q7, [r6, #160]
	vldrw.u32 q0, [r6, #176]
	vldrw.u32 q1, [r6, #192]
	vldrw.u32 q2, [r6, #208]
	vldrw.u32 q3, [r6, #224]
	vldrw.u32 q4, [r6, #240]
	vldrw.u32 q5, [r6, #256]
	vldrw.u32 q6, [r6, #272]
	vldrw.u32 q7, [r6, #288]
	vldrw.u32 q0, [r6, #304]
	vldrw.u32 q1, [r6, #320]
	vldrw.u32 q2, [r6, #336]
	vldrw.u32 q3, [r6, #352]
	vldrw.u32 q4, [r6, #368]
	vldrw.u32 q5, [r6, #384]
	vldrw.u32 q6, [r6, #0]
	vldrw.u32 q7, [r6, #16]
	vldrw.u32 q0, [r6, #32]
	vldrw.u32 q1, [r6, #48]
	vldrw.u32 q2, [r6, #64]
	vldrw.u32 q3, [r6, #80]
	vldrw.u32 q4, [r6, #96]
	vldrw.u32 q5, [r6, #112]
	vldrw.u32 q6, [r6, #128]
	vldrw.u32 q7, [r6, #144]
	vldrw.u32 q0, [r6, #160]
	vldrw.u32 q1, [r6, #176]
	vldrw.u32 q2, [r6, #192]
	vldrw.u32 q3, [r6, #208]
	vldrw.u32 q4, [r6, #224]
	vldrw.u32 q5, [r6, #240]
	vldrw.u32 q6, [r6, #256]
	vldrw.u32 q7, [r6, #272]
	vldrw.u32 q0, [r6, #288]
	vldrw.u32 q1, [r6, #304]
	vldrw.u32 q2, [r6, #320]
	vldrw.u32 q3, [r6, #336]
	vldrw.u32 q4, [r6, #352]
	vldrw.u32 q5, [r6, #368]
	vldrw.u32 q6, [r6, #384]
	vldrw.u32 q7, [r6, #0]
	vldrw.u32 q0, [r6, #16]
	vldrw.u32 q1, [r6, #32]
	vldrw.u32 q2, [r6, #48]
	vldrw.u32 q3, [r6, #64]
	vldrw.u32 q4, [r6, #80]
	vldrw.u32 q5, [r6, #96]
	vldrw.u32 q6, [r6, #112]
	vldrw.u32 q7, [r6, #128]
	vldrw.u32 q0, [r6, #144]
	vldrw.u32 q1, [r6, #160]
	vldrw.u32 q2, [r6, #176]
	vldrw.u32 q3, [r6, #192]
	vldrw.u32 q4, [r6, #208]
	vldrw.u32 q5, [r6, #224]
	vldrw.u32 q6, [r6, #240]
	vldrw.u32 q7, [r6, #256]
	vldrw.u32 q0, [r6, #272]
	vldrw.u32 q1, [r6, #288]
	vldrw.u32 q2, [r6, #304]
	vldrw.u32 q3, [r6, #320]
	vldrw.u32 q4, [r6, #336]
	vldrw.u32 q5, [r6, #352]
	vldrw.u32 q6, [r6, #368]
	vldrw.u32 q7, [r6, #384]
	vldrw.u32 q0, [r6, #0]
	vldrw.u32 q1, [r6, #16]
	vldrw.u32 q2, [r6, #32]
	vldrw.u32 q3, [r6, #48]
	vldrw.u32 q4, [r6, #64]
	vldrw.u32 q5, [r6, #80]
	vldrw.u32 q6, [r6, #96]
	vldrw.u32 q7, [r6, #112]
	vldrw.u32 q0, [r6, #128]
	vldrw.u32 q1, [r6, #144]
	vldrw.u32 q2, [r6, #160]
	vldrw.u32 q3, [r6, #176]
	vldrw.u32 q4, [r6, #192]
	vldrw.u32 q5, [r6, #208]
	vldrw.u32 q6, [r6, #224]
	vldrw.u32 q7, [r6, #240]
	vldrw.u32 q0, [r6, #256]
	vldrw.u32 q1, [r6, #272]
	vldrw.u32 q2, [r6, #288]
	vldrw.u32 q3, [r6, #304]
	vldrw.u32 q4, [r6, #320]
	vldrw.u32 q5, [r6, #336]
	vldrw.u32 q6, [r6, #352]
	vldrw.u32 q7, [r6, #368]
	vldrw.u32 q0, [r6, #384]
	vldrw.u32 q1, [r6, #0]
	vldrw.u32 q2, [r6, #16]
	vldrw.u32 q3, [r6, #32]
	vldrw.u32 q4, [r6, #48]
	vldrw.u32 q5, [r6, #64]
	vldrw.u32 q6, [r6, #80]
	vldrw.u32 q7, [r6, #96]
	vldrw.u32 q0, [r6, #112]
	vldrw.u32 q1, [r6, #128]
	vldrw.u32 q2, [r6, #144]
	vldrw.u32 q3, [r6, #160]
	vldrw.u32 q4, [r6, #176]
	vldrw.u32 q5, [r6, #192]
	vldrw.u32 q6, [r6, #208]
	vldrw.u32 q7, [r6, #224]
	vldrw.u32 q0, [r6, #240]
	vldrw.u32 q1, [r6, #256]
	vldrw.u32 q2, [r6, #272]
	vldrw.u32 q3, [r6, #288]
	vldrw.u32 q4, [r6, #304]
	vldrw.u32 q5, [r6, #320]
	vldrw.u32 q6, [r6, #336]
	vldrw.u32 q7, [r6, #352]
	vldrw.u32 q0, [r6, #368]
	vldrw.u32 q1, [r6, #384]
	vldrw.u32 q2, [r6, #0]
	vldrw.u32 q3, [r6, #16]
	vldrw.u32 q4, [r6, #32]
	vldrw.u32 q5, [r6, #48]
	vldrw.u32 q6, [r6, #64]
	vldrw.u32 q7, [r6, #80]
	vldrw.u32 q0, [r6, #96]
	vldrw.u32 q1, [r6, #112]
	vldrw.u32 q2, [r6, #128]
	vldrw.u32 q3, [r6, #144]
	vldrw.u32 q4, [r6, #160]
	vldrw.u32 q5, [r6, #176]
	vldrw.u32 q6, [r6, #192]
	vldrw.u32 q7, [r6, #208]
	vldrw.u32 q0, [r6, #224]
	vldrw.u32 q1, [r6, #240]
	vldrw.u32 q2, [r6, #256]
	vldrw.u32 q3, [r6, #272]
	vldrw.u32 q4, [r6, #288]
	vldrw.u32 q5, [r6, #304]
	vldrw.u32 q6, [r6, #320]
	vldrw.u32 q7, [r6, #336]
	vldrw.u32 q0, [r6, #352]
	vldrw.u32 q1, [r6, #368]
	vldrw.u32 q2, [r6, #384]
	vldrw.u32 q3, [r6, #0]
	vldrw.u32 q4, [r6, #16]
	vldrw.u32 q5, [r6, #32]
	vldrw.u32 q6, [r6, #48]
	vldrw.u32 q7, [r6, #64]
	vldrw.u32 q0, [r6, #80]
	vldrw.u32 q1, [r6, #96]
	vldrw.u32 q2, [r6, #112]
	vldrw.u32 q3, [r6, #128]
	vldrw.u32 q4, [r6, #144]
	vldrw.u32 q5, [r6, #160]
	vldrw.u32 q6, [r6, #176]
	vldrw.u32 q7, [r6, #192]
	vldrw.u32 q0, [r6, #208]
	vldrw.u32 q1, [r6, #224]
	vldrw.u32 q2, [r6, #240]
	vldrw.u32 q3, [r6, #256]
	vldrw.u32 q4, [r6, #272]
	vldrw.u32 q5, [r6, #288]
	vldrw.u32 q6, [r6, #304]
	vldrw.u32 q7, [r6, #320]
	vldrw.u32 q0, [r6, #336]
	vldrw.u32 q1, [r6, #352]
	vldrw.u32 q2, [r6, #368]
	vldrw.u32 q3, [r6, #384]
	vldrw.u32 q4, [r6, #0]
	vldrw.u32 q5, [r6, #16]
	vldrw.u32 q6, [r6, #32]
	vldrw.u32 q7, [r6, #48]
	vldrw.u32 q0, [r6, #64]
	vldrw.u32 q1, [r6, #80]
	vldrw.u32 q2, [r6, #96]
	vldrw.u32 q3, [r6, #112]
	vldrw.u32 q4, [r6, #128]
	vldrw.u32 q5, [r6, #144]
	vldrw.u32 q6, [r6, #160]
	vldrw.u32 q7, [r6, #176]
	vldrw.u32 q0, [r6, #192]
	vldrw.u32 q1, [r6, #208]
	vldrw.u32 q2, [r6, #224]
	vldrw.u32 q3, [r6, #240]
	vldrw.u32 q4, [r6, #256]
	vldrw.u32 q5, [r6, #272]
	vldrw.u32 q6, [r6, #288]
	vldrw.u32 q7, [r6, #304]
	vldrw.u32 q0, [r6, #320]
	vldrw.u32 q1, [r6, #336]
	vldrw.u32 q2, [r6, #352]
	vldrw.u32 q3, [r6, #368]
	vldrw.u32 q4, [r6, #384]
	vldrw.u32 q5, [r6, #0]
	vldrw.u32 q6, [r6, #16]
	vldrw.u32 q7, [r6, #32]
	vldrw.u32 q0, [r6, #48]
	vldrw.u32 q1, [r6, #64]
	vldrw.u32 q2, [r6, #80]
	vldrw.u32 q3, [r6, #96]
	vldrw.u32 q4, [r6, #112]
	vldrw.u32 q5, [r6, #128]
	vldrw.u32 q6, [r6, #144]
	vldrw.u32 q7, [r6, #160]
	vldrw.u32 q0, [r6, #176]
	vldrw.u32 q1, [r6, #192]
	vldrw.u32 q2, [r6, #208]
	vldrw.u32 q3, [r6, #224]
	vldrw.u32 q4, [r6, #240]
	vldrw.u32 q5, [r6, #256]
	vldrw.u32 q6, [r6, #272]
	vldrw.u32 q7, [r6, #288]
	vldrw.u32 q0, [r6, #304]
	vldrw.u32 q1, [r6, #320]
	vldrw.u32 q2, [r6, #336]
	vldrw.u32 q3, [r6, #352]
	vldrw.u32 q4, [r6, #368]
	vldrw.u32 q5, [r6, #384]
	vldrw.u32 q6, [r6, #0]
	vldrw.u32 q7, [r6, #16]
	vldrw.u32 q0, [r6, #32]
	vldrw.u32 q1, [r6, #48]
	vldrw.u32 q2, [r6, #64]
	vldrw.u32 q3, [r6, #80]
	vldrw.u32 q4, [r6, #96]
	vldrw.u32 q5, [r6, #112]
	vldrw.u32 q6, [r6, #128]
	vldrw.u32 q7, [r6, #144]
	vldrw.u32 q0, [r6, #160]
	vldrw.u32 q1, [r6, #176]
	vldrw.u32 q2, [r6, #192]
	vldrw.u32 q3, [r6, #208]
	vldrw.u32 q4, [r6, #224]
	vldrw.u32 q5, [r6, #240]
	vldrw.u32 q6, [r6, #256]
	vldrw.u32 q7, [r6, #272]
	vldrw.u32 q0, [r6, #288]
	vldrw.u32 q1, [r6, #304]
	vldrw.u32 q2, [r6, #320]
	vldrw.u32 q3, [r6, #336]
	vldrw.u32 q4, [r6, #352]
	vldrw.u32 q5, [r6, #368]
	vldrw.u32 q6, [r6, #384]
	vldrw.u32 q7, [r6, #0]
	vldrw.u32 q0, [r6, #16]
	vldrw.u32 q1, [r6, #32]
	vldrw.u32 q2, [r6, #48]
	vldrw.u32 q3, [r6, #64]
	vldrw.u32 q4, [r6, #80]
	vldrw.u32 q5, [r6, #96]
	vldrw.u32 q6, [r6, #112]
	vldrw.u32 q7, [r6, #128]
	vldrw.u32 q0, [r6, #144]
	vldrw.u32 q1, [r6, #160]
	vldrw.u32 q2, [r6, #176]
	vldrw.u32 q3, [r6, #192]
	vldrw.u32 q4, [r6, #208]
	vldrw.u32 q5, [r6, #224]
	vldrw.u32 q6, [r6, #240]
	vldrw.u32 q7, [r6, #256]
	vldrw.u32 q0, [r6, #272]
	vldrw.u32 q1, [r6, #288]
	vldrw.u32 q2, [r6, #304]
	vldrw.u32 q3, [r6, #320]
	vldrw.u32 q4, [r6, #336]
	vldrw.u32 q5, [r6, #352]
	vldrw.u32 q6, [r6, #368]
	vldrw.u32 q7, [r6, #384]
	vldrw.u32 q0, [r6, #0]
	vldrw.u32 q1, [r6, #16]
	vldrw.u32 q2, [r6, #32]
	vldrw.u32 q3, [r6, #48]
	vldrw.u32 q4, [r6, #64]
	vldrw.u32 q5, [r6, #80]
	vldrw.u32 q6, [r6, #96]
	vldrw.u32 q7, [r6, #112]
	vldrw.u32 q0, [r6, #128]
	vldrw.u32 q1, [r6, #144]
	vldrw.u32 q2, [r6, #160]
	vldrw.u32 q3, [r6, #176]
	vldrw.u32 q4, [r6, #192]
	vldrw.u32 q5, [r6, #208]
	vldrw.u32 q6, [r6, #224]
	vldrw.u32 q7, [r6, #240]
	vldrw.u32 q0, [r6, #256]
	vldrw.u32 q1, [r6, #272]
	vldrw.u32 q2, [r6, #288]
	vldrw.u32 q3, [r6, #304]
	vldrw.u32 q4, [r6, #320]
	vldrw.u32 q5, [r6, #336]
	vldrw.u32 q6, [r6, #352]
	vldrw.u32 q7, [r6, #368]
	vldrw.u32 q0, [r6, #384]
	vldrw.u32 q1, [r6, #0]
	vldrw.u32 q2, [r6, #16]
	vldrw.u32 q3, [r6, #32]
	vldrw.u32 q4, [r6, #48]
	vldrw.u32 q5, [r6, #64]
	vldrw.u32 q6, [r6, #80]
	vldrw.u32 q7, [r6, #96]
	vldrw.u32 q0, [r6, #112]
	vldrw.u32 q1, [r6, #128]
	vldrw.u32 q2, [r6, #144]
	vldrw.u32 q3, [r6, #160]
	vldrw.u32 q4, [r6, #176]
	vldrw.u32 q5, [r6, #192]
	vldrw.u32 q6, [r6, #208]
	vldrw.u32 q7, [r6, #224]
	vldrw.u32 q0, [r6, #240]
	vldrw.u32 q1, [r6, #256]
	vldrw.u32 q2, [r6, #272]
	vldrw.u32 q3, [r6, #288]
	vldrw.u32 q4, [r6, #304]
	vldrw.u32 q5, [r6, #320]
	vldrw.u32 q6, [r6, #336]
	vldrw.u32 q7, [r6, #352]
	vldrw.u32 q0, [r6, #368]
	vldrw.u32 q1, [r6, #384]
	vldrw.u32 q2, [r6, #0]
	vldrw.u32 q3, [r6, #16]
	vldrw.u32 q4, [r6, #32]
	vldrw.u32 q5, [r6, #48]
	vldrw.u32 q6, [r6, #64]
	vldrw.u32 q7, [r6, #80]
	vldrw.u32 q0, [r6, #96]
	vldrw.u32 q1, [r6, #112]
	vldrw.u32 q2, [r6, #128]
	vldrw.u32 q3, [r6, #144]
	vldrw.u32 q4, [r6, #160]
	vldrw.u32 q5, [r6, #176]
	vldrw.u32 q6, [r6, #192]
	vldrw.u32 q7, [r6, #208]
	vldrw.u32 q0, [r6, #224]
	vldrw.u32 q1, [r6, #240]
	vldrw.u32 q2, [r6, #256]
	vldrw.u32 q3, [r6, #272]
	vldrw.u32 q4, [r6, #288]
	vldrw.u32 q5, [r6, #304]
	vldrw.u32 q6, [r6, #320]
	vldrw.u32 q7, [r6, #336]
	vldrw.u32 q0, [r6, #352]
	vldrw.u32 q1, [r6, #368]
	vldrw.u32 q2, [r6, #384]
	vldrw.u32 q3, [r6, #0]
	vldrw.u32 q4, [r6, #16]
	vldrw.u32 q5, [r6, #32]
	vldrw.u32 q6, [r6, #48]
	vldrw.u32 q7, [r6, #64]
	vldrw.u32 q0, [r6, #80]
	vldrw.u32 q1, [r6, #96]
	vldrw.u32 q2, [r6, #112]
	vldrw.u32 q3, [r6, #128]
	vldrw.u32 q4, [r6, #144]
	vldrw.u32 q5, [r6, #160]
	vldrw.u32 q6, [r6, #176]
	vldrw.u32 q7, [r6, #192]
	vldrw.u32 q0, [r6, #208]
	vldrw.u32 q1, [r6, #224]
	vldrw.u32 q2, [r6, #240]
	vldrw.u32 q3, [r6, #256]
	vldrw.u32 q4, [r6, #272]
	vldrw.u32 q5, [r6, #288]
	vldrw.u32 q6, [r6, #304]
	vldrw.u32 q7, [r6, #320]
	vldrw.u32 q0, [r6, #336]
	vldrw.u32 q1, [r6, #352]
	vldrw.u32 q2, [r6, #368]
	vldrw.u32 q3, [r6, #384]
	vldrw.u32 q4, [r6, #0]
	vldrw.u32 q5, [r6, #16]
	vldrw.u32 q6, [r6, #32]
	vldrw.u32 q7, [r6, #48]
	vldrw.u32 q0, [r6, #64]
	vldrw.u32 q1, [r6, #80]
	vldrw.u32 q2, [r6, #96]
	vldrw.u32 q3, [r6, #112]
	vldrw.u32 q4, [r6, #128]
	vldrw.u32 q5, [r6, #144]
	vldrw.u32 q6, [r6, #160]
	vldrw.u32 q7, [r6, #176]
	vldrw.u32 q0, [r6, #192]
	vldrw.u32 q1, [r6, #208]
	vldrw.u32 q2, [r6, #224]
	vldrw.u32 q3, [r6, #240]
	vldrw.u32 q4, [r6, #256]
	vldrw.u32 q5, [r6, #272]
	vldrw.u32 q6, [r6, #288]
	vldrw.u32 q7, [r6, #304]
	vldrw.u32 q0, [r6, #320]
	vldrw.u32 q1, [r6, #336]
	vldrw.u32 q2, [r6, #352]
	vldrw.u32 q3, [r6, #368]
	vldrw.u32 q4, [r6, #384]
	vldrw.u32 q5, [r6, #0]
	vldrw.u32 q6, [r6, #16]
	vldrw.u32 q7, [r6, #32]
	vldrw.u32 q0, [r6, #48]
	vldrw.u32 q1, [r6, #64]
	vldrw.u32 q2, [r6, #80]
	vldrw.u32 q3, [r6, #96]
	vldrw.u32 q4, [r6, #112]
	vldrw.u32 q5, [r6, #128]
	vldrw.u32 q6, [r6, #144]
	vldrw.u32 q7, [r6, #160]
	vldrw.u32 q0, [r6, #176]
	vldrw.u32 q1, [r6, #192]
	vldrw.u32 q2, [r6, #208]
	vldrw.u32 q3, [r6, #224]
	vldrw.u32 q4, [r6, #240]
	vldrw.u32 q5, [r6, #256]
	vldrw.u32 q6, [r6, #272]
	vldrw.u32 q7, [r6, #288]
	vldrw.u32 q0, [r6, #304]
	vldrw.u32 q1, [r6, #320]
	vldrw.u32 q2, [r6, #336]
	vldrw.u32 q3, [r6, #352]
	vldrw.u32 q4, [r6, #368]
	vldrw.u32 q5, [r6, #384]
	vldrw.u32 q6, [r6, #0]
	vldrw.u32 q7, [r6, #16]
	vldrw.u32 q0, [r6, #32]
	vldrw.u32 q1, [r6, #48]
	vldrw.u32 q2, [r6, #64]
	vldrw.u32 q3, [r6, #80]
	vldrw.u32 q4, [r6, #96]
	vldrw.u32 q5, [r6, #112]
	vldrw.u32 q6, [r6, #128]
	vldrw.u32 q7, [r6, #144]
	vldrw.u32 q0, [r6, #160]
	vldrw.u32 q1, [r6, #176]
	vldrw.u32 q2, [r6, #192]
	vldrw.u32 q3, [r6, #208]
	vldrw.u32 q4, [r6, #224]
	vldrw.u32 q5, [r6, #240]
	vldrw.u32 q6, [r6, #256]
	vldrw.u32 q7, [r6, #272]
	vldrw.u32 q0, [r6, #288]
	vldrw.u32 q1, [r6, #304]
	vldrw.u32 q2, [r6, #320]
	vldrw.u32 q3, [r6, #336]
	vldrw.u32 q4, [r6, #352]
	vldrw.u32 q5, [r6, #368]
	vldrw.u32 q6, [r6, #384]
	vldrw.u32 q7, [r6, #0]
	vldrw.u32 q0, [r6, #16]
	vldrw.u32 q1, [r6, #32]
	vldrw.u32 q2, [r6, #48]
	vldrw.u32 q3, [r6, #64]
	vldrw.u32 q4, [r6, #80]
	vldrw.u32 q5, [r6, #96]
	vldrw.u32 q6, [r6, #112]
	vldrw.u32 q7, [r6, #128]
	vldrw.u32 q0, [r6, #144]
	vldrw.u32 q1, [r6, #160]
	vldrw.u32 q2, [r6, #176]
	vldrw.u32 q3, [r6, #192]
	vldrw.u32 q4, [r6, #208]
	vldrw.u32 q5, [r6, #224]
	vldrw.u32 q6, [r6, #240]
	vldrw.u32 q7, [r6, #256]
	vldrw.u32 q0, [r6, #272]
	vldrw.u32 q1, [r6, #288]
	vldrw.u32 q2, [r6, #304]
	vldrw.u32 q3, [r6, #320]
	vldrw.u32 q4, [r6, #336]
	vldrw.u32 q5, [r6, #352]
	vldrw.u32 q6, [r6, #368]
	vldrw.u32 q7, [r6, #384]
	vldrw.u32 q0, [r6, #0]
	vldrw.u32 q1, [r6, #16]
	vldrw.u32 q2, [r6, #32]
	vldrw.u32 q3, [r6, #48]
	vldrw.u32 q4, [r6, #64]
	vldrw.u32 q5, [r6, #80]
	vldrw.u32 q6, [r6, #96]
	vldrw.u32 q7, [r6, #112]
	vldrw.u32 q0, [r6, #128]
	vldrw.u32 q1, [r6, #144]
	vldrw.u32 q2, [r6, #160]
	subs r12, r12, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// pairn_ldr_zip (1222 instrs)
.global pairn_ldr_zip
.type pairn_ldr_zip, %function
.thumb_func
.balign 16
pairn_ldr_zip:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r12, r0
	movw r6, #:lower16:g_mve
	movt r6, #:upper16:g_mve
	add r9, r6, #1024
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #160]
	subs r12, r12, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// pairn_str (611 instrs)
.global pairn_str
.type pairn_str, %function
.thumb_func
.balign 16
pairn_str:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r12, r0
	movw r6, #:lower16:g_mve
	movt r6, #:upper16:g_mve
	add r9, r6, #1024
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	vstrw.u32 q0, [r9, #0]
	vstrw.u32 q1, [r9, #16]
	vstrw.u32 q2, [r9, #32]
	vstrw.u32 q3, [r9, #48]
	vstrw.u32 q4, [r9, #64]
	vstrw.u32 q5, [r9, #80]
	vstrw.u32 q6, [r9, #96]
	vstrw.u32 q7, [r9, #112]
	vstrw.u32 q0, [r9, #128]
	vstrw.u32 q1, [r9, #144]
	vstrw.u32 q2, [r9, #160]
	vstrw.u32 q3, [r9, #176]
	vstrw.u32 q4, [r9, #192]
	vstrw.u32 q5, [r9, #208]
	vstrw.u32 q6, [r9, #224]
	vstrw.u32 q7, [r9, #240]
	vstrw.u32 q0, [r9, #256]
	vstrw.u32 q1, [r9, #272]
	vstrw.u32 q2, [r9, #288]
	vstrw.u32 q3, [r9, #304]
	vstrw.u32 q4, [r9, #320]
	vstrw.u32 q5, [r9, #336]
	vstrw.u32 q6, [r9, #352]
	vstrw.u32 q7, [r9, #368]
	vstrw.u32 q0, [r9, #384]
	vstrw.u32 q1, [r9, #0]
	vstrw.u32 q2, [r9, #16]
	vstrw.u32 q3, [r9, #32]
	vstrw.u32 q4, [r9, #48]
	vstrw.u32 q5, [r9, #64]
	vstrw.u32 q6, [r9, #80]
	vstrw.u32 q7, [r9, #96]
	vstrw.u32 q0, [r9, #112]
	vstrw.u32 q1, [r9, #128]
	vstrw.u32 q2, [r9, #144]
	vstrw.u32 q3, [r9, #160]
	vstrw.u32 q4, [r9, #176]
	vstrw.u32 q5, [r9, #192]
	vstrw.u32 q6, [r9, #208]
	vstrw.u32 q7, [r9, #224]
	vstrw.u32 q0, [r9, #240]
	vstrw.u32 q1, [r9, #256]
	vstrw.u32 q2, [r9, #272]
	vstrw.u32 q3, [r9, #288]
	vstrw.u32 q4, [r9, #304]
	vstrw.u32 q5, [r9, #320]
	vstrw.u32 q6, [r9, #336]
	vstrw.u32 q7, [r9, #352]
	vstrw.u32 q0, [r9, #368]
	vstrw.u32 q1, [r9, #384]
	vstrw.u32 q2, [r9, #0]
	vstrw.u32 q3, [r9, #16]
	vstrw.u32 q4, [r9, #32]
	vstrw.u32 q5, [r9, #48]
	vstrw.u32 q6, [r9, #64]
	vstrw.u32 q7, [r9, #80]
	vstrw.u32 q0, [r9, #96]
	vstrw.u32 q1, [r9, #112]
	vstrw.u32 q2, [r9, #128]
	vstrw.u32 q3, [r9, #144]
	vstrw.u32 q4, [r9, #160]
	vstrw.u32 q5, [r9, #176]
	vstrw.u32 q6, [r9, #192]
	vstrw.u32 q7, [r9, #208]
	vstrw.u32 q0, [r9, #224]
	vstrw.u32 q1, [r9, #240]
	vstrw.u32 q2, [r9, #256]
	vstrw.u32 q3, [r9, #272]
	vstrw.u32 q4, [r9, #288]
	vstrw.u32 q5, [r9, #304]
	vstrw.u32 q6, [r9, #320]
	vstrw.u32 q7, [r9, #336]
	vstrw.u32 q0, [r9, #352]
	vstrw.u32 q1, [r9, #368]
	vstrw.u32 q2, [r9, #384]
	vstrw.u32 q3, [r9, #0]
	vstrw.u32 q4, [r9, #16]
	vstrw.u32 q5, [r9, #32]
	vstrw.u32 q6, [r9, #48]
	vstrw.u32 q7, [r9, #64]
	vstrw.u32 q0, [r9, #80]
	vstrw.u32 q1, [r9, #96]
	vstrw.u32 q2, [r9, #112]
	vstrw.u32 q3, [r9, #128]
	vstrw.u32 q4, [r9, #144]
	vstrw.u32 q5, [r9, #160]
	vstrw.u32 q6, [r9, #176]
	vstrw.u32 q7, [r9, #192]
	vstrw.u32 q0, [r9, #208]
	vstrw.u32 q1, [r9, #224]
	vstrw.u32 q2, [r9, #240]
	vstrw.u32 q3, [r9, #256]
	vstrw.u32 q4, [r9, #272]
	vstrw.u32 q5, [r9, #288]
	vstrw.u32 q6, [r9, #304]
	vstrw.u32 q7, [r9, #320]
	vstrw.u32 q0, [r9, #336]
	vstrw.u32 q1, [r9, #352]
	vstrw.u32 q2, [r9, #368]
	vstrw.u32 q3, [r9, #384]
	vstrw.u32 q4, [r9, #0]
	vstrw.u32 q5, [r9, #16]
	vstrw.u32 q6, [r9, #32]
	vstrw.u32 q7, [r9, #48]
	vstrw.u32 q0, [r9, #64]
	vstrw.u32 q1, [r9, #80]
	vstrw.u32 q2, [r9, #96]
	vstrw.u32 q3, [r9, #112]
	vstrw.u32 q4, [r9, #128]
	vstrw.u32 q5, [r9, #144]
	vstrw.u32 q6, [r9, #160]
	vstrw.u32 q7, [r9, #176]
	vstrw.u32 q0, [r9, #192]
	vstrw.u32 q1, [r9, #208]
	vstrw.u32 q2, [r9, #224]
	vstrw.u32 q3, [r9, #240]
	vstrw.u32 q4, [r9, #256]
	vstrw.u32 q5, [r9, #272]
	vstrw.u32 q6, [r9, #288]
	vstrw.u32 q7, [r9, #304]
	vstrw.u32 q0, [r9, #320]
	vstrw.u32 q1, [r9, #336]
	vstrw.u32 q2, [r9, #352]
	vstrw.u32 q3, [r9, #368]
	vstrw.u32 q4, [r9, #384]
	vstrw.u32 q5, [r9, #0]
	vstrw.u32 q6, [r9, #16]
	vstrw.u32 q7, [r9, #32]
	vstrw.u32 q0, [r9, #48]
	vstrw.u32 q1, [r9, #64]
	vstrw.u32 q2, [r9, #80]
	vstrw.u32 q3, [r9, #96]
	vstrw.u32 q4, [r9, #112]
	vstrw.u32 q5, [r9, #128]
	vstrw.u32 q6, [r9, #144]
	vstrw.u32 q7, [r9, #160]
	vstrw.u32 q0, [r9, #176]
	vstrw.u32 q1, [r9, #192]
	vstrw.u32 q2, [r9, #208]
	vstrw.u32 q3, [r9, #224]
	vstrw.u32 q4, [r9, #240]
	vstrw.u32 q5, [r9, #256]
	vstrw.u32 q6, [r9, #272]
	vstrw.u32 q7, [r9, #288]
	vstrw.u32 q0, [r9, #304]
	vstrw.u32 q1, [r9, #320]
	vstrw.u32 q2, [r9, #336]
	vstrw.u32 q3, [r9, #352]
	vstrw.u32 q4, [r9, #368]
	vstrw.u32 q5, [r9, #384]
	vstrw.u32 q6, [r9, #0]
	vstrw.u32 q7, [r9, #16]
	vstrw.u32 q0, [r9, #32]
	vstrw.u32 q1, [r9, #48]
	vstrw.u32 q2, [r9, #64]
	vstrw.u32 q3, [r9, #80]
	vstrw.u32 q4, [r9, #96]
	vstrw.u32 q5, [r9, #112]
	vstrw.u32 q6, [r9, #128]
	vstrw.u32 q7, [r9, #144]
	vstrw.u32 q0, [r9, #160]
	vstrw.u32 q1, [r9, #176]
	vstrw.u32 q2, [r9, #192]
	vstrw.u32 q3, [r9, #208]
	vstrw.u32 q4, [r9, #224]
	vstrw.u32 q5, [r9, #240]
	vstrw.u32 q6, [r9, #256]
	vstrw.u32 q7, [r9, #272]
	vstrw.u32 q0, [r9, #288]
	vstrw.u32 q1, [r9, #304]
	vstrw.u32 q2, [r9, #320]
	vstrw.u32 q3, [r9, #336]
	vstrw.u32 q4, [r9, #352]
	vstrw.u32 q5, [r9, #368]
	vstrw.u32 q6, [r9, #384]
	vstrw.u32 q7, [r9, #0]
	vstrw.u32 q0, [r9, #16]
	vstrw.u32 q1, [r9, #32]
	vstrw.u32 q2, [r9, #48]
	vstrw.u32 q3, [r9, #64]
	vstrw.u32 q4, [r9, #80]
	vstrw.u32 q5, [r9, #96]
	vstrw.u32 q6, [r9, #112]
	vstrw.u32 q7, [r9, #128]
	vstrw.u32 q0, [r9, #144]
	vstrw.u32 q1, [r9, #160]
	vstrw.u32 q2, [r9, #176]
	vstrw.u32 q3, [r9, #192]
	vstrw.u32 q4, [r9, #208]
	vstrw.u32 q5, [r9, #224]
	vstrw.u32 q6, [r9, #240]
	vstrw.u32 q7, [r9, #256]
	vstrw.u32 q0, [r9, #272]
	vstrw.u32 q1, [r9, #288]
	vstrw.u32 q2, [r9, #304]
	vstrw.u32 q3, [r9, #320]
	vstrw.u32 q4, [r9, #336]
	vstrw.u32 q5, [r9, #352]
	vstrw.u32 q6, [r9, #368]
	vstrw.u32 q7, [r9, #384]
	vstrw.u32 q0, [r9, #0]
	vstrw.u32 q1, [r9, #16]
	vstrw.u32 q2, [r9, #32]
	vstrw.u32 q3, [r9, #48]
	vstrw.u32 q4, [r9, #64]
	vstrw.u32 q5, [r9, #80]
	vstrw.u32 q6, [r9, #96]
	vstrw.u32 q7, [r9, #112]
	vstrw.u32 q0, [r9, #128]
	vstrw.u32 q1, [r9, #144]
	vstrw.u32 q2, [r9, #160]
	vstrw.u32 q3, [r9, #176]
	vstrw.u32 q4, [r9, #192]
	vstrw.u32 q5, [r9, #208]
	vstrw.u32 q6, [r9, #224]
	vstrw.u32 q7, [r9, #240]
	vstrw.u32 q0, [r9, #256]
	vstrw.u32 q1, [r9, #272]
	vstrw.u32 q2, [r9, #288]
	vstrw.u32 q3, [r9, #304]
	vstrw.u32 q4, [r9, #320]
	vstrw.u32 q5, [r9, #336]
	vstrw.u32 q6, [r9, #352]
	vstrw.u32 q7, [r9, #368]
	vstrw.u32 q0, [r9, #384]
	vstrw.u32 q1, [r9, #0]
	vstrw.u32 q2, [r9, #16]
	vstrw.u32 q3, [r9, #32]
	vstrw.u32 q4, [r9, #48]
	vstrw.u32 q5, [r9, #64]
	vstrw.u32 q6, [r9, #80]
	vstrw.u32 q7, [r9, #96]
	vstrw.u32 q0, [r9, #112]
	vstrw.u32 q1, [r9, #128]
	vstrw.u32 q2, [r9, #144]
	vstrw.u32 q3, [r9, #160]
	vstrw.u32 q4, [r9, #176]
	vstrw.u32 q5, [r9, #192]
	vstrw.u32 q6, [r9, #208]
	vstrw.u32 q7, [r9, #224]
	vstrw.u32 q0, [r9, #240]
	vstrw.u32 q1, [r9, #256]
	vstrw.u32 q2, [r9, #272]
	vstrw.u32 q3, [r9, #288]
	vstrw.u32 q4, [r9, #304]
	vstrw.u32 q5, [r9, #320]
	vstrw.u32 q6, [r9, #336]
	vstrw.u32 q7, [r9, #352]
	vstrw.u32 q0, [r9, #368]
	vstrw.u32 q1, [r9, #384]
	vstrw.u32 q2, [r9, #0]
	vstrw.u32 q3, [r9, #16]
	vstrw.u32 q4, [r9, #32]
	vstrw.u32 q5, [r9, #48]
	vstrw.u32 q6, [r9, #64]
	vstrw.u32 q7, [r9, #80]
	vstrw.u32 q0, [r9, #96]
	vstrw.u32 q1, [r9, #112]
	vstrw.u32 q2, [r9, #128]
	vstrw.u32 q3, [r9, #144]
	vstrw.u32 q4, [r9, #160]
	vstrw.u32 q5, [r9, #176]
	vstrw.u32 q6, [r9, #192]
	vstrw.u32 q7, [r9, #208]
	vstrw.u32 q0, [r9, #224]
	vstrw.u32 q1, [r9, #240]
	vstrw.u32 q2, [r9, #256]
	vstrw.u32 q3, [r9, #272]
	vstrw.u32 q4, [r9, #288]
	vstrw.u32 q5, [r9, #304]
	vstrw.u32 q6, [r9, #320]
	vstrw.u32 q7, [r9, #336]
	vstrw.u32 q0, [r9, #352]
	vstrw.u32 q1, [r9, #368]
	vstrw.u32 q2, [r9, #384]
	vstrw.u32 q3, [r9, #0]
	vstrw.u32 q4, [r9, #16]
	vstrw.u32 q5, [r9, #32]
	vstrw.u32 q6, [r9, #48]
	vstrw.u32 q7, [r9, #64]
	vstrw.u32 q0, [r9, #80]
	vstrw.u32 q1, [r9, #96]
	vstrw.u32 q2, [r9, #112]
	vstrw.u32 q3, [r9, #128]
	vstrw.u32 q4, [r9, #144]
	vstrw.u32 q5, [r9, #160]
	vstrw.u32 q6, [r9, #176]
	vstrw.u32 q7, [r9, #192]
	vstrw.u32 q0, [r9, #208]
	vstrw.u32 q1, [r9, #224]
	vstrw.u32 q2, [r9, #240]
	vstrw.u32 q3, [r9, #256]
	vstrw.u32 q4, [r9, #272]
	vstrw.u32 q5, [r9, #288]
	vstrw.u32 q6, [r9, #304]
	vstrw.u32 q7, [r9, #320]
	vstrw.u32 q0, [r9, #336]
	vstrw.u32 q1, [r9, #352]
	vstrw.u32 q2, [r9, #368]
	vstrw.u32 q3, [r9, #384]
	vstrw.u32 q4, [r9, #0]
	vstrw.u32 q5, [r9, #16]
	vstrw.u32 q6, [r9, #32]
	vstrw.u32 q7, [r9, #48]
	vstrw.u32 q0, [r9, #64]
	vstrw.u32 q1, [r9, #80]
	vstrw.u32 q2, [r9, #96]
	vstrw.u32 q3, [r9, #112]
	vstrw.u32 q4, [r9, #128]
	vstrw.u32 q5, [r9, #144]
	vstrw.u32 q6, [r9, #160]
	vstrw.u32 q7, [r9, #176]
	vstrw.u32 q0, [r9, #192]
	vstrw.u32 q1, [r9, #208]
	vstrw.u32 q2, [r9, #224]
	vstrw.u32 q3, [r9, #240]
	vstrw.u32 q4, [r9, #256]
	vstrw.u32 q5, [r9, #272]
	vstrw.u32 q6, [r9, #288]
	vstrw.u32 q7, [r9, #304]
	vstrw.u32 q0, [r9, #320]
	vstrw.u32 q1, [r9, #336]
	vstrw.u32 q2, [r9, #352]
	vstrw.u32 q3, [r9, #368]
	vstrw.u32 q4, [r9, #384]
	vstrw.u32 q5, [r9, #0]
	vstrw.u32 q6, [r9, #16]
	vstrw.u32 q7, [r9, #32]
	vstrw.u32 q0, [r9, #48]
	vstrw.u32 q1, [r9, #64]
	vstrw.u32 q2, [r9, #80]
	vstrw.u32 q3, [r9, #96]
	vstrw.u32 q4, [r9, #112]
	vstrw.u32 q5, [r9, #128]
	vstrw.u32 q6, [r9, #144]
	vstrw.u32 q7, [r9, #160]
	vstrw.u32 q0, [r9, #176]
	vstrw.u32 q1, [r9, #192]
	vstrw.u32 q2, [r9, #208]
	vstrw.u32 q3, [r9, #224]
	vstrw.u32 q4, [r9, #240]
	vstrw.u32 q5, [r9, #256]
	vstrw.u32 q6, [r9, #272]
	vstrw.u32 q7, [r9, #288]
	vstrw.u32 q0, [r9, #304]
	vstrw.u32 q1, [r9, #320]
	vstrw.u32 q2, [r9, #336]
	vstrw.u32 q3, [r9, #352]
	vstrw.u32 q4, [r9, #368]
	vstrw.u32 q5, [r9, #384]
	vstrw.u32 q6, [r9, #0]
	vstrw.u32 q7, [r9, #16]
	vstrw.u32 q0, [r9, #32]
	vstrw.u32 q1, [r9, #48]
	vstrw.u32 q2, [r9, #64]
	vstrw.u32 q3, [r9, #80]
	vstrw.u32 q4, [r9, #96]
	vstrw.u32 q5, [r9, #112]
	vstrw.u32 q6, [r9, #128]
	vstrw.u32 q7, [r9, #144]
	vstrw.u32 q0, [r9, #160]
	vstrw.u32 q1, [r9, #176]
	vstrw.u32 q2, [r9, #192]
	vstrw.u32 q3, [r9, #208]
	vstrw.u32 q4, [r9, #224]
	vstrw.u32 q5, [r9, #240]
	vstrw.u32 q6, [r9, #256]
	vstrw.u32 q7, [r9, #272]
	vstrw.u32 q0, [r9, #288]
	vstrw.u32 q1, [r9, #304]
	vstrw.u32 q2, [r9, #320]
	vstrw.u32 q3, [r9, #336]
	vstrw.u32 q4, [r9, #352]
	vstrw.u32 q5, [r9, #368]
	vstrw.u32 q6, [r9, #384]
	vstrw.u32 q7, [r9, #0]
	vstrw.u32 q0, [r9, #16]
	vstrw.u32 q1, [r9, #32]
	vstrw.u32 q2, [r9, #48]
	vstrw.u32 q3, [r9, #64]
	vstrw.u32 q4, [r9, #80]
	vstrw.u32 q5, [r9, #96]
	vstrw.u32 q6, [r9, #112]
	vstrw.u32 q7, [r9, #128]
	vstrw.u32 q0, [r9, #144]
	vstrw.u32 q1, [r9, #160]
	vstrw.u32 q2, [r9, #176]
	vstrw.u32 q3, [r9, #192]
	vstrw.u32 q4, [r9, #208]
	vstrw.u32 q5, [r9, #224]
	vstrw.u32 q6, [r9, #240]
	vstrw.u32 q7, [r9, #256]
	vstrw.u32 q0, [r9, #272]
	vstrw.u32 q1, [r9, #288]
	vstrw.u32 q2, [r9, #304]
	vstrw.u32 q3, [r9, #320]
	vstrw.u32 q4, [r9, #336]
	vstrw.u32 q5, [r9, #352]
	vstrw.u32 q6, [r9, #368]
	vstrw.u32 q7, [r9, #384]
	vstrw.u32 q0, [r9, #0]
	vstrw.u32 q1, [r9, #16]
	vstrw.u32 q2, [r9, #32]
	vstrw.u32 q3, [r9, #48]
	vstrw.u32 q4, [r9, #64]
	vstrw.u32 q5, [r9, #80]
	vstrw.u32 q6, [r9, #96]
	vstrw.u32 q7, [r9, #112]
	vstrw.u32 q0, [r9, #128]
	vstrw.u32 q1, [r9, #144]
	vstrw.u32 q2, [r9, #160]
	vstrw.u32 q3, [r9, #176]
	vstrw.u32 q4, [r9, #192]
	vstrw.u32 q5, [r9, #208]
	vstrw.u32 q6, [r9, #224]
	vstrw.u32 q7, [r9, #240]
	vstrw.u32 q0, [r9, #256]
	vstrw.u32 q1, [r9, #272]
	vstrw.u32 q2, [r9, #288]
	vstrw.u32 q3, [r9, #304]
	vstrw.u32 q4, [r9, #320]
	vstrw.u32 q5, [r9, #336]
	vstrw.u32 q6, [r9, #352]
	vstrw.u32 q7, [r9, #368]
	vstrw.u32 q0, [r9, #384]
	vstrw.u32 q1, [r9, #0]
	vstrw.u32 q2, [r9, #16]
	vstrw.u32 q3, [r9, #32]
	vstrw.u32 q4, [r9, #48]
	vstrw.u32 q5, [r9, #64]
	vstrw.u32 q6, [r9, #80]
	vstrw.u32 q7, [r9, #96]
	vstrw.u32 q0, [r9, #112]
	vstrw.u32 q1, [r9, #128]
	vstrw.u32 q2, [r9, #144]
	vstrw.u32 q3, [r9, #160]
	vstrw.u32 q4, [r9, #176]
	vstrw.u32 q5, [r9, #192]
	vstrw.u32 q6, [r9, #208]
	vstrw.u32 q7, [r9, #224]
	vstrw.u32 q0, [r9, #240]
	vstrw.u32 q1, [r9, #256]
	vstrw.u32 q2, [r9, #272]
	vstrw.u32 q3, [r9, #288]
	vstrw.u32 q4, [r9, #304]
	vstrw.u32 q5, [r9, #320]
	vstrw.u32 q6, [r9, #336]
	vstrw.u32 q7, [r9, #352]
	vstrw.u32 q0, [r9, #368]
	vstrw.u32 q1, [r9, #384]
	vstrw.u32 q2, [r9, #0]
	vstrw.u32 q3, [r9, #16]
	vstrw.u32 q4, [r9, #32]
	vstrw.u32 q5, [r9, #48]
	vstrw.u32 q6, [r9, #64]
	vstrw.u32 q7, [r9, #80]
	vstrw.u32 q0, [r9, #96]
	vstrw.u32 q1, [r9, #112]
	vstrw.u32 q2, [r9, #128]
	vstrw.u32 q3, [r9, #144]
	vstrw.u32 q4, [r9, #160]
	vstrw.u32 q5, [r9, #176]
	vstrw.u32 q6, [r9, #192]
	vstrw.u32 q7, [r9, #208]
	vstrw.u32 q0, [r9, #224]
	vstrw.u32 q1, [r9, #240]
	vstrw.u32 q2, [r9, #256]
	vstrw.u32 q3, [r9, #272]
	vstrw.u32 q4, [r9, #288]
	vstrw.u32 q5, [r9, #304]
	vstrw.u32 q6, [r9, #320]
	vstrw.u32 q7, [r9, #336]
	vstrw.u32 q0, [r9, #352]
	vstrw.u32 q1, [r9, #368]
	vstrw.u32 q2, [r9, #384]
	vstrw.u32 q3, [r9, #0]
	vstrw.u32 q4, [r9, #16]
	vstrw.u32 q5, [r9, #32]
	vstrw.u32 q6, [r9, #48]
	vstrw.u32 q7, [r9, #64]
	vstrw.u32 q0, [r9, #80]
	vstrw.u32 q1, [r9, #96]
	vstrw.u32 q2, [r9, #112]
	vstrw.u32 q3, [r9, #128]
	vstrw.u32 q4, [r9, #144]
	vstrw.u32 q5, [r9, #160]
	vstrw.u32 q6, [r9, #176]
	vstrw.u32 q7, [r9, #192]
	vstrw.u32 q0, [r9, #208]
	vstrw.u32 q1, [r9, #224]
	vstrw.u32 q2, [r9, #240]
	vstrw.u32 q3, [r9, #256]
	vstrw.u32 q4, [r9, #272]
	vstrw.u32 q5, [r9, #288]
	vstrw.u32 q6, [r9, #304]
	vstrw.u32 q7, [r9, #320]
	vstrw.u32 q0, [r9, #336]
	vstrw.u32 q1, [r9, #352]
	vstrw.u32 q2, [r9, #368]
	vstrw.u32 q3, [r9, #384]
	vstrw.u32 q4, [r9, #0]
	vstrw.u32 q5, [r9, #16]
	vstrw.u32 q6, [r9, #32]
	vstrw.u32 q7, [r9, #48]
	vstrw.u32 q0, [r9, #64]
	vstrw.u32 q1, [r9, #80]
	vstrw.u32 q2, [r9, #96]
	vstrw.u32 q3, [r9, #112]
	vstrw.u32 q4, [r9, #128]
	vstrw.u32 q5, [r9, #144]
	vstrw.u32 q6, [r9, #160]
	vstrw.u32 q7, [r9, #176]
	vstrw.u32 q0, [r9, #192]
	vstrw.u32 q1, [r9, #208]
	vstrw.u32 q2, [r9, #224]
	vstrw.u32 q3, [r9, #240]
	vstrw.u32 q4, [r9, #256]
	vstrw.u32 q5, [r9, #272]
	vstrw.u32 q6, [r9, #288]
	vstrw.u32 q7, [r9, #304]
	vstrw.u32 q0, [r9, #320]
	vstrw.u32 q1, [r9, #336]
	vstrw.u32 q2, [r9, #352]
	vstrw.u32 q3, [r9, #368]
	vstrw.u32 q4, [r9, #384]
	vstrw.u32 q5, [r9, #0]
	vstrw.u32 q6, [r9, #16]
	vstrw.u32 q7, [r9, #32]
	vstrw.u32 q0, [r9, #48]
	vstrw.u32 q1, [r9, #64]
	vstrw.u32 q2, [r9, #80]
	vstrw.u32 q3, [r9, #96]
	vstrw.u32 q4, [r9, #112]
	vstrw.u32 q5, [r9, #128]
	vstrw.u32 q6, [r9, #144]
	vstrw.u32 q7, [r9, #160]
	vstrw.u32 q0, [r9, #176]
	vstrw.u32 q1, [r9, #192]
	vstrw.u32 q2, [r9, #208]
	vstrw.u32 q3, [r9, #224]
	vstrw.u32 q4, [r9, #240]
	vstrw.u32 q5, [r9, #256]
	vstrw.u32 q6, [r9, #272]
	vstrw.u32 q7, [r9, #288]
	vstrw.u32 q0, [r9, #304]
	vstrw.u32 q1, [r9, #320]
	vstrw.u32 q2, [r9, #336]
	vstrw.u32 q3, [r9, #352]
	vstrw.u32 q4, [r9, #368]
	vstrw.u32 q5, [r9, #384]
	vstrw.u32 q6, [r9, #0]
	vstrw.u32 q7, [r9, #16]
	vstrw.u32 q0, [r9, #32]
	vstrw.u32 q1, [r9, #48]
	vstrw.u32 q2, [r9, #64]
	vstrw.u32 q3, [r9, #80]
	vstrw.u32 q4, [r9, #96]
	vstrw.u32 q5, [r9, #112]
	vstrw.u32 q6, [r9, #128]
	vstrw.u32 q7, [r9, #144]
	vstrw.u32 q0, [r9, #160]
	vstrw.u32 q1, [r9, #176]
	vstrw.u32 q2, [r9, #192]
	vstrw.u32 q3, [r9, #208]
	vstrw.u32 q4, [r9, #224]
	vstrw.u32 q5, [r9, #240]
	vstrw.u32 q6, [r9, #256]
	vstrw.u32 q7, [r9, #272]
	vstrw.u32 q0, [r9, #288]
	vstrw.u32 q1, [r9, #304]
	vstrw.u32 q2, [r9, #320]
	vstrw.u32 q3, [r9, #336]
	vstrw.u32 q4, [r9, #352]
	vstrw.u32 q5, [r9, #368]
	vstrw.u32 q6, [r9, #384]
	vstrw.u32 q7, [r9, #0]
	vstrw.u32 q0, [r9, #16]
	vstrw.u32 q1, [r9, #32]
	vstrw.u32 q2, [r9, #48]
	vstrw.u32 q3, [r9, #64]
	vstrw.u32 q4, [r9, #80]
	vstrw.u32 q5, [r9, #96]
	vstrw.u32 q6, [r9, #112]
	vstrw.u32 q7, [r9, #128]
	vstrw.u32 q0, [r9, #144]
	vstrw.u32 q1, [r9, #160]
	vstrw.u32 q2, [r9, #176]
	vstrw.u32 q3, [r9, #192]
	vstrw.u32 q4, [r9, #208]
	vstrw.u32 q5, [r9, #224]
	vstrw.u32 q6, [r9, #240]
	vstrw.u32 q7, [r9, #256]
	vstrw.u32 q0, [r9, #272]
	vstrw.u32 q1, [r9, #288]
	vstrw.u32 q2, [r9, #304]
	vstrw.u32 q3, [r9, #320]
	vstrw.u32 q4, [r9, #336]
	vstrw.u32 q5, [r9, #352]
	vstrw.u32 q6, [r9, #368]
	vstrw.u32 q7, [r9, #384]
	vstrw.u32 q0, [r9, #0]
	vstrw.u32 q1, [r9, #16]
	vstrw.u32 q2, [r9, #32]
	vstrw.u32 q3, [r9, #48]
	vstrw.u32 q4, [r9, #64]
	vstrw.u32 q5, [r9, #80]
	vstrw.u32 q6, [r9, #96]
	vstrw.u32 q7, [r9, #112]
	vstrw.u32 q0, [r9, #128]
	vstrw.u32 q1, [r9, #144]
	vstrw.u32 q2, [r9, #160]
	subs r12, r12, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// pairn_str_zip (1222 instrs)
.global pairn_str_zip
.type pairn_str_zip, %function
.thumb_func
.balign 16
pairn_str_zip:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r12, r0
	movw r6, #:lower16:g_mve
	movt r6, #:upper16:g_mve
	add r9, r6, #1024
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #160]
	subs r12, r12, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// pairn_rot (611 instrs)
.global pairn_rot
.type pairn_rot, %function
.thumb_func
.balign 16
pairn_rot:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r12, r0
	movw r6, #:lower16:g_mve
	movt r6, #:upper16:g_mve
	add r9, r6, #1024
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	vshl.i32 q0, q4, #1
	vsri.32 q0, q4, #31
	vshl.i32 q1, q5, #2
	vsri.32 q1, q5, #30
	vshl.i32 q2, q6, #3
	vsri.32 q2, q6, #29
	vshl.i32 q3, q7, #4
	vsri.32 q3, q7, #28
	vshl.i32 q0, q4, #5
	vsri.32 q0, q4, #27
	vshl.i32 q1, q5, #6
	vsri.32 q1, q5, #26
	vshl.i32 q2, q6, #7
	vsri.32 q2, q6, #25
	vshl.i32 q3, q7, #8
	vsri.32 q3, q7, #24
	vshl.i32 q0, q4, #9
	vsri.32 q0, q4, #23
	vshl.i32 q1, q5, #10
	vsri.32 q1, q5, #22
	vshl.i32 q2, q6, #11
	vsri.32 q2, q6, #21
	vshl.i32 q3, q7, #12
	vsri.32 q3, q7, #20
	vshl.i32 q0, q4, #13
	vsri.32 q0, q4, #19
	vshl.i32 q1, q5, #14
	vsri.32 q1, q5, #18
	vshl.i32 q2, q6, #15
	vsri.32 q2, q6, #17
	vshl.i32 q3, q7, #16
	vsri.32 q3, q7, #16
	vshl.i32 q0, q4, #17
	vsri.32 q0, q4, #15
	vshl.i32 q1, q5, #18
	vsri.32 q1, q5, #14
	vshl.i32 q2, q6, #19
	vsri.32 q2, q6, #13
	vshl.i32 q3, q7, #20
	vsri.32 q3, q7, #12
	vshl.i32 q0, q4, #21
	vsri.32 q0, q4, #11
	vshl.i32 q1, q5, #22
	vsri.32 q1, q5, #10
	vshl.i32 q2, q6, #23
	vsri.32 q2, q6, #9
	vshl.i32 q3, q7, #24
	vsri.32 q3, q7, #8
	vshl.i32 q0, q4, #25
	vsri.32 q0, q4, #7
	vshl.i32 q1, q5, #26
	vsri.32 q1, q5, #6
	vshl.i32 q2, q6, #27
	vsri.32 q2, q6, #5
	vshl.i32 q3, q7, #28
	vsri.32 q3, q7, #4
	vshl.i32 q0, q4, #29
	vsri.32 q0, q4, #3
	vshl.i32 q1, q5, #30
	vsri.32 q1, q5, #2
	vshl.i32 q2, q6, #31
	vsri.32 q2, q6, #1
	vshl.i32 q3, q7, #1
	vsri.32 q3, q7, #31
	vshl.i32 q0, q4, #2
	vsri.32 q0, q4, #30
	vshl.i32 q1, q5, #3
	vsri.32 q1, q5, #29
	vshl.i32 q2, q6, #4
	vsri.32 q2, q6, #28
	vshl.i32 q3, q7, #5
	vsri.32 q3, q7, #27
	vshl.i32 q0, q4, #6
	vsri.32 q0, q4, #26
	vshl.i32 q1, q5, #7
	vsri.32 q1, q5, #25
	vshl.i32 q2, q6, #8
	vsri.32 q2, q6, #24
	vshl.i32 q3, q7, #9
	vsri.32 q3, q7, #23
	vshl.i32 q0, q4, #10
	vsri.32 q0, q4, #22
	vshl.i32 q1, q5, #11
	vsri.32 q1, q5, #21
	vshl.i32 q2, q6, #12
	vsri.32 q2, q6, #20
	vshl.i32 q3, q7, #13
	vsri.32 q3, q7, #19
	vshl.i32 q0, q4, #14
	vsri.32 q0, q4, #18
	vshl.i32 q1, q5, #15
	vsri.32 q1, q5, #17
	vshl.i32 q2, q6, #16
	vsri.32 q2, q6, #16
	vshl.i32 q3, q7, #17
	vsri.32 q3, q7, #15
	vshl.i32 q0, q4, #18
	vsri.32 q0, q4, #14
	vshl.i32 q1, q5, #19
	vsri.32 q1, q5, #13
	vshl.i32 q2, q6, #20
	vsri.32 q2, q6, #12
	vshl.i32 q3, q7, #21
	vsri.32 q3, q7, #11
	vshl.i32 q0, q4, #22
	vsri.32 q0, q4, #10
	vshl.i32 q1, q5, #23
	vsri.32 q1, q5, #9
	vshl.i32 q2, q6, #24
	vsri.32 q2, q6, #8
	vshl.i32 q3, q7, #25
	vsri.32 q3, q7, #7
	vshl.i32 q0, q4, #26
	vsri.32 q0, q4, #6
	vshl.i32 q1, q5, #27
	vsri.32 q1, q5, #5
	vshl.i32 q2, q6, #28
	vsri.32 q2, q6, #4
	vshl.i32 q3, q7, #29
	vsri.32 q3, q7, #3
	vshl.i32 q0, q4, #30
	vsri.32 q0, q4, #2
	vshl.i32 q1, q5, #31
	vsri.32 q1, q5, #1
	vshl.i32 q2, q6, #1
	vsri.32 q2, q6, #31
	vshl.i32 q3, q7, #2
	vsri.32 q3, q7, #30
	vshl.i32 q0, q4, #3
	vsri.32 q0, q4, #29
	vshl.i32 q1, q5, #4
	vsri.32 q1, q5, #28
	vshl.i32 q2, q6, #5
	vsri.32 q2, q6, #27
	vshl.i32 q3, q7, #6
	vsri.32 q3, q7, #26
	vshl.i32 q0, q4, #7
	vsri.32 q0, q4, #25
	vshl.i32 q1, q5, #8
	vsri.32 q1, q5, #24
	vshl.i32 q2, q6, #9
	vsri.32 q2, q6, #23
	vshl.i32 q3, q7, #10
	vsri.32 q3, q7, #22
	vshl.i32 q0, q4, #11
	vsri.32 q0, q4, #21
	vshl.i32 q1, q5, #12
	vsri.32 q1, q5, #20
	vshl.i32 q2, q6, #13
	vsri.32 q2, q6, #19
	vshl.i32 q3, q7, #14
	vsri.32 q3, q7, #18
	vshl.i32 q0, q4, #15
	vsri.32 q0, q4, #17
	vshl.i32 q1, q5, #16
	vsri.32 q1, q5, #16
	vshl.i32 q2, q6, #17
	vsri.32 q2, q6, #15
	vshl.i32 q3, q7, #18
	vsri.32 q3, q7, #14
	vshl.i32 q0, q4, #19
	vsri.32 q0, q4, #13
	vshl.i32 q1, q5, #20
	vsri.32 q1, q5, #12
	vshl.i32 q2, q6, #21
	vsri.32 q2, q6, #11
	vshl.i32 q3, q7, #22
	vsri.32 q3, q7, #10
	vshl.i32 q0, q4, #23
	vsri.32 q0, q4, #9
	vshl.i32 q1, q5, #24
	vsri.32 q1, q5, #8
	vshl.i32 q2, q6, #25
	vsri.32 q2, q6, #7
	vshl.i32 q3, q7, #26
	vsri.32 q3, q7, #6
	vshl.i32 q0, q4, #27
	vsri.32 q0, q4, #5
	vshl.i32 q1, q5, #28
	vsri.32 q1, q5, #4
	vshl.i32 q2, q6, #29
	vsri.32 q2, q6, #3
	vshl.i32 q3, q7, #30
	vsri.32 q3, q7, #2
	vshl.i32 q0, q4, #31
	vsri.32 q0, q4, #1
	vshl.i32 q1, q5, #1
	vsri.32 q1, q5, #31
	vshl.i32 q2, q6, #2
	vsri.32 q2, q6, #30
	vshl.i32 q3, q7, #3
	vsri.32 q3, q7, #29
	vshl.i32 q0, q4, #4
	vsri.32 q0, q4, #28
	vshl.i32 q1, q5, #5
	vsri.32 q1, q5, #27
	vshl.i32 q2, q6, #6
	vsri.32 q2, q6, #26
	vshl.i32 q3, q7, #7
	vsri.32 q3, q7, #25
	vshl.i32 q0, q4, #8
	vsri.32 q0, q4, #24
	vshl.i32 q1, q5, #9
	vsri.32 q1, q5, #23
	vshl.i32 q2, q6, #10
	vsri.32 q2, q6, #22
	vshl.i32 q3, q7, #11
	vsri.32 q3, q7, #21
	vshl.i32 q0, q4, #12
	vsri.32 q0, q4, #20
	vshl.i32 q1, q5, #13
	vsri.32 q1, q5, #19
	vshl.i32 q2, q6, #14
	vsri.32 q2, q6, #18
	vshl.i32 q3, q7, #15
	vsri.32 q3, q7, #17
	vshl.i32 q0, q4, #16
	vsri.32 q0, q4, #16
	vshl.i32 q1, q5, #17
	vsri.32 q1, q5, #15
	vshl.i32 q2, q6, #18
	vsri.32 q2, q6, #14
	vshl.i32 q3, q7, #19
	vsri.32 q3, q7, #13
	vshl.i32 q0, q4, #20
	vsri.32 q0, q4, #12
	vshl.i32 q1, q5, #21
	vsri.32 q1, q5, #11
	vshl.i32 q2, q6, #22
	vsri.32 q2, q6, #10
	vshl.i32 q3, q7, #23
	vsri.32 q3, q7, #9
	vshl.i32 q0, q4, #24
	vsri.32 q0, q4, #8
	vshl.i32 q1, q5, #25
	vsri.32 q1, q5, #7
	vshl.i32 q2, q6, #26
	vsri.32 q2, q6, #6
	vshl.i32 q3, q7, #27
	vsri.32 q3, q7, #5
	vshl.i32 q0, q4, #28
	vsri.32 q0, q4, #4
	vshl.i32 q1, q5, #29
	vsri.32 q1, q5, #3
	vshl.i32 q2, q6, #30
	vsri.32 q2, q6, #2
	vshl.i32 q3, q7, #31
	vsri.32 q3, q7, #1
	vshl.i32 q0, q4, #1
	vsri.32 q0, q4, #31
	vshl.i32 q1, q5, #2
	vsri.32 q1, q5, #30
	vshl.i32 q2, q6, #3
	vsri.32 q2, q6, #29
	vshl.i32 q3, q7, #4
	vsri.32 q3, q7, #28
	vshl.i32 q0, q4, #5
	vsri.32 q0, q4, #27
	vshl.i32 q1, q5, #6
	vsri.32 q1, q5, #26
	vshl.i32 q2, q6, #7
	vsri.32 q2, q6, #25
	vshl.i32 q3, q7, #8
	vsri.32 q3, q7, #24
	vshl.i32 q0, q4, #9
	vsri.32 q0, q4, #23
	vshl.i32 q1, q5, #10
	vsri.32 q1, q5, #22
	vshl.i32 q2, q6, #11
	vsri.32 q2, q6, #21
	vshl.i32 q3, q7, #12
	vsri.32 q3, q7, #20
	vshl.i32 q0, q4, #13
	vsri.32 q0, q4, #19
	vshl.i32 q1, q5, #14
	vsri.32 q1, q5, #18
	vshl.i32 q2, q6, #15
	vsri.32 q2, q6, #17
	vshl.i32 q3, q7, #16
	vsri.32 q3, q7, #16
	vshl.i32 q0, q4, #17
	vsri.32 q0, q4, #15
	vshl.i32 q1, q5, #18
	vsri.32 q1, q5, #14
	vshl.i32 q2, q6, #19
	vsri.32 q2, q6, #13
	vshl.i32 q3, q7, #20
	vsri.32 q3, q7, #12
	vshl.i32 q0, q4, #21
	vsri.32 q0, q4, #11
	vshl.i32 q1, q5, #22
	vsri.32 q1, q5, #10
	vshl.i32 q2, q6, #23
	vsri.32 q2, q6, #9
	vshl.i32 q3, q7, #24
	vsri.32 q3, q7, #8
	vshl.i32 q0, q4, #25
	vsri.32 q0, q4, #7
	vshl.i32 q1, q5, #26
	vsri.32 q1, q5, #6
	vshl.i32 q2, q6, #27
	vsri.32 q2, q6, #5
	vshl.i32 q3, q7, #28
	vsri.32 q3, q7, #4
	vshl.i32 q0, q4, #29
	vsri.32 q0, q4, #3
	vshl.i32 q1, q5, #30
	vsri.32 q1, q5, #2
	vshl.i32 q2, q6, #31
	vsri.32 q2, q6, #1
	vshl.i32 q3, q7, #1
	vsri.32 q3, q7, #31
	vshl.i32 q0, q4, #2
	vsri.32 q0, q4, #30
	vshl.i32 q1, q5, #3
	vsri.32 q1, q5, #29
	vshl.i32 q2, q6, #4
	vsri.32 q2, q6, #28
	vshl.i32 q3, q7, #5
	vsri.32 q3, q7, #27
	vshl.i32 q0, q4, #6
	vsri.32 q0, q4, #26
	vshl.i32 q1, q5, #7
	vsri.32 q1, q5, #25
	vshl.i32 q2, q6, #8
	vsri.32 q2, q6, #24
	vshl.i32 q3, q7, #9
	vsri.32 q3, q7, #23
	vshl.i32 q0, q4, #10
	vsri.32 q0, q4, #22
	vshl.i32 q1, q5, #11
	vsri.32 q1, q5, #21
	vshl.i32 q2, q6, #12
	vsri.32 q2, q6, #20
	vshl.i32 q3, q7, #13
	vsri.32 q3, q7, #19
	vshl.i32 q0, q4, #14
	vsri.32 q0, q4, #18
	vshl.i32 q1, q5, #15
	vsri.32 q1, q5, #17
	vshl.i32 q2, q6, #16
	vsri.32 q2, q6, #16
	vshl.i32 q3, q7, #17
	vsri.32 q3, q7, #15
	vshl.i32 q0, q4, #18
	vsri.32 q0, q4, #14
	vshl.i32 q1, q5, #19
	vsri.32 q1, q5, #13
	vshl.i32 q2, q6, #20
	vsri.32 q2, q6, #12
	vshl.i32 q3, q7, #21
	vsri.32 q3, q7, #11
	vshl.i32 q0, q4, #22
	vsri.32 q0, q4, #10
	vshl.i32 q1, q5, #23
	vsri.32 q1, q5, #9
	vshl.i32 q2, q6, #24
	vsri.32 q2, q6, #8
	vshl.i32 q3, q7, #25
	vsri.32 q3, q7, #7
	vshl.i32 q0, q4, #26
	vsri.32 q0, q4, #6
	vshl.i32 q1, q5, #27
	vsri.32 q1, q5, #5
	vshl.i32 q2, q6, #28
	vsri.32 q2, q6, #4
	vshl.i32 q3, q7, #29
	vsri.32 q3, q7, #3
	vshl.i32 q0, q4, #30
	vsri.32 q0, q4, #2
	vshl.i32 q1, q5, #31
	vsri.32 q1, q5, #1
	vshl.i32 q2, q6, #1
	vsri.32 q2, q6, #31
	vshl.i32 q3, q7, #2
	vsri.32 q3, q7, #30
	vshl.i32 q0, q4, #3
	vsri.32 q0, q4, #29
	vshl.i32 q1, q5, #4
	vsri.32 q1, q5, #28
	vshl.i32 q2, q6, #5
	vsri.32 q2, q6, #27
	vshl.i32 q3, q7, #6
	vsri.32 q3, q7, #26
	vshl.i32 q0, q4, #7
	vsri.32 q0, q4, #25
	vshl.i32 q1, q5, #8
	vsri.32 q1, q5, #24
	vshl.i32 q2, q6, #9
	vsri.32 q2, q6, #23
	vshl.i32 q3, q7, #10
	vsri.32 q3, q7, #22
	vshl.i32 q0, q4, #11
	vsri.32 q0, q4, #21
	vshl.i32 q1, q5, #12
	vsri.32 q1, q5, #20
	vshl.i32 q2, q6, #13
	vsri.32 q2, q6, #19
	vshl.i32 q3, q7, #14
	vsri.32 q3, q7, #18
	vshl.i32 q0, q4, #15
	vsri.32 q0, q4, #17
	vshl.i32 q1, q5, #16
	vsri.32 q1, q5, #16
	vshl.i32 q2, q6, #17
	vsri.32 q2, q6, #15
	vshl.i32 q3, q7, #18
	vsri.32 q3, q7, #14
	vshl.i32 q0, q4, #19
	vsri.32 q0, q4, #13
	vshl.i32 q1, q5, #20
	vsri.32 q1, q5, #12
	vshl.i32 q2, q6, #21
	vsri.32 q2, q6, #11
	vshl.i32 q3, q7, #22
	vsri.32 q3, q7, #10
	vshl.i32 q0, q4, #23
	vsri.32 q0, q4, #9
	vshl.i32 q1, q5, #24
	vsri.32 q1, q5, #8
	vshl.i32 q2, q6, #25
	vsri.32 q2, q6, #7
	vshl.i32 q3, q7, #26
	vsri.32 q3, q7, #6
	vshl.i32 q0, q4, #27
	vsri.32 q0, q4, #5
	vshl.i32 q1, q5, #28
	vsri.32 q1, q5, #4
	vshl.i32 q2, q6, #29
	vsri.32 q2, q6, #3
	vshl.i32 q3, q7, #30
	vsri.32 q3, q7, #2
	vshl.i32 q0, q4, #31
	vsri.32 q0, q4, #1
	vshl.i32 q1, q5, #1
	vsri.32 q1, q5, #31
	vshl.i32 q2, q6, #2
	vsri.32 q2, q6, #30
	vshl.i32 q3, q7, #3
	vsri.32 q3, q7, #29
	vshl.i32 q0, q4, #4
	vsri.32 q0, q4, #28
	vshl.i32 q1, q5, #5
	vsri.32 q1, q5, #27
	vshl.i32 q2, q6, #6
	vsri.32 q2, q6, #26
	vshl.i32 q3, q7, #7
	vsri.32 q3, q7, #25
	vshl.i32 q0, q4, #8
	vsri.32 q0, q4, #24
	vshl.i32 q1, q5, #9
	vsri.32 q1, q5, #23
	vshl.i32 q2, q6, #10
	vsri.32 q2, q6, #22
	vshl.i32 q3, q7, #11
	vsri.32 q3, q7, #21
	vshl.i32 q0, q4, #12
	vsri.32 q0, q4, #20
	vshl.i32 q1, q5, #13
	vsri.32 q1, q5, #19
	vshl.i32 q2, q6, #14
	vsri.32 q2, q6, #18
	vshl.i32 q3, q7, #15
	vsri.32 q3, q7, #17
	vshl.i32 q0, q4, #16
	vsri.32 q0, q4, #16
	vshl.i32 q1, q5, #17
	vsri.32 q1, q5, #15
	vshl.i32 q2, q6, #18
	vsri.32 q2, q6, #14
	vshl.i32 q3, q7, #19
	vsri.32 q3, q7, #13
	vshl.i32 q0, q4, #20
	vsri.32 q0, q4, #12
	vshl.i32 q1, q5, #21
	vsri.32 q1, q5, #11
	vshl.i32 q2, q6, #22
	vsri.32 q2, q6, #10
	vshl.i32 q3, q7, #23
	vsri.32 q3, q7, #9
	vshl.i32 q0, q4, #24
	vsri.32 q0, q4, #8
	vshl.i32 q1, q5, #25
	vsri.32 q1, q5, #7
	vshl.i32 q2, q6, #26
	vsri.32 q2, q6, #6
	vshl.i32 q3, q7, #27
	vsri.32 q3, q7, #5
	vshl.i32 q0, q4, #28
	vsri.32 q0, q4, #4
	vshl.i32 q1, q5, #29
	vsri.32 q1, q5, #3
	vshl.i32 q2, q6, #30
	vsri.32 q2, q6, #2
	vshl.i32 q3, q7, #31
	vsri.32 q3, q7, #1
	vshl.i32 q0, q4, #1
	vsri.32 q0, q4, #31
	vshl.i32 q1, q5, #2
	vsri.32 q1, q5, #30
	vshl.i32 q2, q6, #3
	vsri.32 q2, q6, #29
	vshl.i32 q3, q7, #4
	vsri.32 q3, q7, #28
	vshl.i32 q0, q4, #5
	vsri.32 q0, q4, #27
	vshl.i32 q1, q5, #6
	vsri.32 q1, q5, #26
	vshl.i32 q2, q6, #7
	vsri.32 q2, q6, #25
	vshl.i32 q3, q7, #8
	vsri.32 q3, q7, #24
	vshl.i32 q0, q4, #9
	vsri.32 q0, q4, #23
	vshl.i32 q1, q5, #10
	vsri.32 q1, q5, #22
	vshl.i32 q2, q6, #11
	vsri.32 q2, q6, #21
	vshl.i32 q3, q7, #12
	vsri.32 q3, q7, #20
	vshl.i32 q0, q4, #13
	vsri.32 q0, q4, #19
	vshl.i32 q1, q5, #14
	vsri.32 q1, q5, #18
	vshl.i32 q2, q6, #15
	vsri.32 q2, q6, #17
	vshl.i32 q3, q7, #16
	vsri.32 q3, q7, #16
	vshl.i32 q0, q4, #17
	vsri.32 q0, q4, #15
	vshl.i32 q1, q5, #18
	vsri.32 q1, q5, #14
	vshl.i32 q2, q6, #19
	vsri.32 q2, q6, #13
	vshl.i32 q3, q7, #20
	vsri.32 q3, q7, #12
	vshl.i32 q0, q4, #21
	vsri.32 q0, q4, #11
	vshl.i32 q1, q5, #22
	vsri.32 q1, q5, #10
	vshl.i32 q2, q6, #23
	vsri.32 q2, q6, #9
	vshl.i32 q3, q7, #24
	vsri.32 q3, q7, #8
	vshl.i32 q0, q4, #25
	vsri.32 q0, q4, #7
	vshl.i32 q1, q5, #26
	vsri.32 q1, q5, #6
	vshl.i32 q2, q6, #27
	vsri.32 q2, q6, #5
	vshl.i32 q3, q7, #28
	vsri.32 q3, q7, #4
	vshl.i32 q0, q4, #29
	vsri.32 q0, q4, #3
	vshl.i32 q1, q5, #30
	vsri.32 q1, q5, #2
	vshl.i32 q2, q6, #31
	vsri.32 q2, q6, #1
	vshl.i32 q3, q7, #1
	vsri.32 q3, q7, #31
	vshl.i32 q0, q4, #2
	vsri.32 q0, q4, #30
	vshl.i32 q1, q5, #3
	vsri.32 q1, q5, #29
	vshl.i32 q2, q6, #4
	vsri.32 q2, q6, #28
	vshl.i32 q3, q7, #5
	vsri.32 q3, q7, #27
	vshl.i32 q0, q4, #6
	vsri.32 q0, q4, #26
	vshl.i32 q1, q5, #7
	vsri.32 q1, q5, #25
	vshl.i32 q2, q6, #8
	vsri.32 q2, q6, #24
	vshl.i32 q3, q7, #9
	vsri.32 q3, q7, #23
	vshl.i32 q0, q4, #10
	vsri.32 q0, q4, #22
	vshl.i32 q1, q5, #11
	vsri.32 q1, q5, #21
	vshl.i32 q2, q6, #12
	vsri.32 q2, q6, #20
	vshl.i32 q3, q7, #13
	vsri.32 q3, q7, #19
	vshl.i32 q0, q4, #14
	vsri.32 q0, q4, #18
	vshl.i32 q1, q5, #15
	vsri.32 q1, q5, #17
	vshl.i32 q2, q6, #16
	vsri.32 q2, q6, #16
	vshl.i32 q3, q7, #17
	vsri.32 q3, q7, #15
	vshl.i32 q0, q4, #18
	vsri.32 q0, q4, #14
	vshl.i32 q1, q5, #19
	vsri.32 q1, q5, #13
	vshl.i32 q2, q6, #20
	vsri.32 q2, q6, #12
	vshl.i32 q3, q7, #21
	vsri.32 q3, q7, #11
	vshl.i32 q0, q4, #22
	vsri.32 q0, q4, #10
	vshl.i32 q1, q5, #23
	vsri.32 q1, q5, #9
	vshl.i32 q2, q6, #24
	vsri.32 q2, q6, #8
	vshl.i32 q3, q7, #25
	vsri.32 q3, q7, #7
	vshl.i32 q0, q4, #26
	vsri.32 q0, q4, #6
	vshl.i32 q1, q5, #27
	subs r12, r12, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// pairn_rot_zip (1222 instrs)
.global pairn_rot_zip
.type pairn_rot_zip, %function
.thumb_func
.balign 16
pairn_rot_zip:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r12, r0
	movw r6, #:lower16:g_mve
	movt r6, #:upper16:g_mve
	add r9, r6, #1024
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #1
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #31
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #2
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #30
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #29
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #4
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #28
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #5
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #27
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #6
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #26
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #7
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #25
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #8
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #24
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #9
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #23
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #10
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #22
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #11
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #21
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #12
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #20
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #13
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #19
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #14
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #18
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #15
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #17
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #16
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #16
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #17
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #15
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #18
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #14
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #19
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #13
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #20
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #12
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #21
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #11
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #22
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #10
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #23
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #9
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #24
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #8
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #25
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #7
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #26
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #6
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #27
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #5
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #28
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #4
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #29
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #30
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #2
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #31
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #1
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #1
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #31
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #2
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #30
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #29
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #4
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #28
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #5
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #27
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #6
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #26
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #7
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #25
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #8
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #24
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #9
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #23
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #10
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #22
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #11
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #21
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #12
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #20
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #13
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #19
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #14
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #18
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #15
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #17
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #16
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #16
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #17
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #15
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #18
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #14
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #19
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #13
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #20
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #12
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #21
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #11
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #22
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #10
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #23
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #9
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #24
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #8
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #25
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #7
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #26
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #6
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #27
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #5
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #28
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #4
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #29
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #30
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #2
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #31
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #1
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #1
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #31
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #2
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #30
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #29
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #4
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #28
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #5
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #27
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #6
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #26
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #7
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #25
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #8
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #24
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #9
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #23
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #10
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #22
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #11
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #21
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #12
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #20
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #13
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #19
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #14
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #18
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #15
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #17
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #16
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #16
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #17
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #15
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #18
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #14
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #19
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #13
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #20
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #12
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #21
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #11
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #22
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #10
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #23
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #9
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #24
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #8
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #25
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #7
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #26
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #6
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #27
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #5
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #28
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #4
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #29
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #30
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #2
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #31
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #1
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #31
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #2
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #30
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #29
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #4
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #28
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #5
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #27
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #6
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #26
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #7
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #25
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #8
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #24
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #9
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #23
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #10
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #22
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #11
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #21
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #12
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #20
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #13
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #19
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #14
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #18
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #15
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #17
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #16
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #16
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #17
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #15
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #18
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #14
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #19
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #13
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #20
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #12
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #21
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #11
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #22
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #10
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #23
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #9
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #24
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #8
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #25
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #26
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #6
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #27
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #5
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #28
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #4
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #29
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #30
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #2
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #31
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #1
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #1
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #31
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #2
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #30
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #29
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #4
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #28
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #5
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #27
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #6
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #26
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #7
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #25
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #8
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #24
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #9
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #23
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #10
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #22
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #11
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #21
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #12
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #20
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #13
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #19
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #14
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #18
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #15
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #17
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #16
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #16
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #17
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #15
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #18
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #14
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #19
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #13
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #20
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #12
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #21
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #11
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #22
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #10
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #23
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #9
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #24
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #8
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #25
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #7
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #26
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #6
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #27
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #5
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #28
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #4
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #29
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #30
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #2
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #31
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #1
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #1
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #31
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #2
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #30
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #29
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #4
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #28
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #5
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #27
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #6
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #26
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #7
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #25
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #8
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #24
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #9
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #23
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #10
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #22
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #11
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #21
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #12
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #20
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #13
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #19
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #14
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #18
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #15
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #17
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #16
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #16
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #17
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #15
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #18
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #14
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #19
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #13
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #20
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #12
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #21
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #11
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #22
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #10
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #23
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #9
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #24
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #8
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #25
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #7
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #26
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #6
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #27
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #5
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #28
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #4
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #29
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #30
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #2
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #31
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #1
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #1
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #31
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #2
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #30
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #29
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #4
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #28
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #5
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #27
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #6
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #26
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #7
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #25
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #8
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #24
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #9
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #23
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #10
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #22
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #11
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #21
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #12
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #20
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #13
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #19
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #14
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #18
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #15
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #17
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #16
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #16
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #17
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #15
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #18
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #14
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #19
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #13
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #20
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #12
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #21
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #11
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #22
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #10
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #23
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #9
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #24
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #8
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #25
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #7
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #26
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #6
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #27
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #5
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #28
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #4
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #29
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #30
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #2
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #31
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #1
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #31
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #2
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #30
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #29
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #4
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #28
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #5
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #27
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #6
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #26
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #7
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #25
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #8
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #24
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #9
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #23
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #10
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #22
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #11
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #21
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #12
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #20
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #13
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #19
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #14
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #18
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #15
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #17
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #16
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #16
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #17
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #15
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #18
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #14
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #19
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #13
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #20
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #12
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #21
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #11
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #22
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #10
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #23
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #9
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #24
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #8
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #25
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #26
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #6
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #27
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #5
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #28
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #4
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #29
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #30
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #2
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #31
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #1
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #1
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #31
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #2
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #30
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #29
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #4
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #28
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #5
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #27
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #6
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #26
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #7
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #25
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #8
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #24
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #9
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #23
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #10
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #22
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #11
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #21
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #12
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #20
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #13
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #19
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #14
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #18
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #15
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #17
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #16
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #16
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #17
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #15
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #18
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #14
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #19
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #13
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #20
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #12
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #21
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #11
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #22
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #10
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #23
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #9
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #24
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #8
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #25
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #7
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #26
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #6
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #27
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #5
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #28
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #4
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #29
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #30
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #2
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #31
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #1
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #1
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #31
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #2
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #30
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #29
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #4
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #28
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #5
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #27
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #6
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #26
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #7
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #25
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #8
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #24
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #9
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #23
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #10
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #22
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #11
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #21
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #12
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #20
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #13
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #19
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #14
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #18
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #15
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #17
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #16
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #16
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #17
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #15
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #18
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #14
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #19
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #13
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #20
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #12
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #21
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #11
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #22
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #10
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #23
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #9
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #24
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #8
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #25
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #7
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #26
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #6
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #27
	subs r12, r12, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// pairn2_ldr (1833 instrs)
.global pairn2_ldr
.type pairn2_ldr, %function
.thumb_func
.balign 16
pairn2_ldr:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r12, r0
	movw r6, #:lower16:g_mve
	movt r6, #:upper16:g_mve
	add r9, r6, #1024
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r6, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q5, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r6, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #160]
	subs r12, r12, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// pairn2_str (1833 instrs)
.global pairn2_str
.type pairn2_str, %function
.thumb_func
.balign 16
pairn2_str:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r12, r0
	movw r6, #:lower16:g_mve
	movt r6, #:upper16:g_mve
	add r9, r6, #1024
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #256]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q4, [r9, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q6, [r9, #96]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r9, #128]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #160]
	subs r12, r12, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// pairn2_rot (1833 instrs)
.global pairn2_rot
.type pairn2_rot, %function
.thumb_func
.balign 16
pairn2_rot:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r12, r0
	movw r6, #:lower16:g_mve
	movt r6, #:upper16:g_mve
	add r9, r6, #1024
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #29
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #27
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #16
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #17
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #15
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #19
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #13
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #20
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #12
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #21
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #11
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #10
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q2, q6, #24
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q6, #8
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q3, q7, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q0, q4, #26
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q4, #6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.i32 q1, q5, #27
	subs r12, r12, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// pairn_lsmix (611 instrs)
.global pairn_lsmix
.type pairn_lsmix, %function
.thumb_func
.balign 16
pairn_lsmix:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r12, r0
	movw r6, #:lower16:g_mve
	movt r6, #:upper16:g_mve
	add r9, r6, #1024
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	vldrw.u32 q0, [r6, #0]
	vstrw.u32 q1, [r9, #16]
	vldrw.u32 q2, [r6, #32]
	vstrw.u32 q3, [r9, #48]
	vldrw.u32 q4, [r6, #64]
	vstrw.u32 q5, [r9, #80]
	vldrw.u32 q6, [r6, #96]
	vstrw.u32 q7, [r9, #112]
	vldrw.u32 q0, [r6, #128]
	vstrw.u32 q1, [r9, #144]
	vldrw.u32 q2, [r6, #160]
	vstrw.u32 q3, [r9, #176]
	vldrw.u32 q4, [r6, #192]
	vstrw.u32 q5, [r9, #208]
	vldrw.u32 q6, [r6, #224]
	vstrw.u32 q7, [r9, #240]
	vldrw.u32 q0, [r6, #256]
	vstrw.u32 q1, [r9, #272]
	vldrw.u32 q2, [r6, #288]
	vstrw.u32 q3, [r9, #304]
	vldrw.u32 q4, [r6, #320]
	vstrw.u32 q5, [r9, #336]
	vldrw.u32 q6, [r6, #352]
	vstrw.u32 q7, [r9, #368]
	vldrw.u32 q0, [r6, #384]
	vstrw.u32 q1, [r9, #0]
	vldrw.u32 q2, [r6, #16]
	vstrw.u32 q3, [r9, #32]
	vldrw.u32 q4, [r6, #48]
	vstrw.u32 q5, [r9, #64]
	vldrw.u32 q6, [r6, #80]
	vstrw.u32 q7, [r9, #96]
	vldrw.u32 q0, [r6, #112]
	vstrw.u32 q1, [r9, #128]
	vldrw.u32 q2, [r6, #144]
	vstrw.u32 q3, [r9, #160]
	vldrw.u32 q4, [r6, #176]
	vstrw.u32 q5, [r9, #192]
	vldrw.u32 q6, [r6, #208]
	vstrw.u32 q7, [r9, #224]
	vldrw.u32 q0, [r6, #240]
	vstrw.u32 q1, [r9, #256]
	vldrw.u32 q2, [r6, #272]
	vstrw.u32 q3, [r9, #288]
	vldrw.u32 q4, [r6, #304]
	vstrw.u32 q5, [r9, #320]
	vldrw.u32 q6, [r6, #336]
	vstrw.u32 q7, [r9, #352]
	vldrw.u32 q0, [r6, #368]
	vstrw.u32 q1, [r9, #384]
	vldrw.u32 q2, [r6, #0]
	vstrw.u32 q3, [r9, #16]
	vldrw.u32 q4, [r6, #32]
	vstrw.u32 q5, [r9, #48]
	vldrw.u32 q6, [r6, #64]
	vstrw.u32 q7, [r9, #80]
	vldrw.u32 q0, [r6, #96]
	vstrw.u32 q1, [r9, #112]
	vldrw.u32 q2, [r6, #128]
	vstrw.u32 q3, [r9, #144]
	vldrw.u32 q4, [r6, #160]
	vstrw.u32 q5, [r9, #176]
	vldrw.u32 q6, [r6, #192]
	vstrw.u32 q7, [r9, #208]
	vldrw.u32 q0, [r6, #224]
	vstrw.u32 q1, [r9, #240]
	vldrw.u32 q2, [r6, #256]
	vstrw.u32 q3, [r9, #272]
	vldrw.u32 q4, [r6, #288]
	vstrw.u32 q5, [r9, #304]
	vldrw.u32 q6, [r6, #320]
	vstrw.u32 q7, [r9, #336]
	vldrw.u32 q0, [r6, #352]
	vstrw.u32 q1, [r9, #368]
	vldrw.u32 q2, [r6, #384]
	vstrw.u32 q3, [r9, #0]
	vldrw.u32 q4, [r6, #16]
	vstrw.u32 q5, [r9, #32]
	vldrw.u32 q6, [r6, #48]
	vstrw.u32 q7, [r9, #64]
	vldrw.u32 q0, [r6, #80]
	vstrw.u32 q1, [r9, #96]
	vldrw.u32 q2, [r6, #112]
	vstrw.u32 q3, [r9, #128]
	vldrw.u32 q4, [r6, #144]
	vstrw.u32 q5, [r9, #160]
	vldrw.u32 q6, [r6, #176]
	vstrw.u32 q7, [r9, #192]
	vldrw.u32 q0, [r6, #208]
	vstrw.u32 q1, [r9, #224]
	vldrw.u32 q2, [r6, #240]
	vstrw.u32 q3, [r9, #256]
	vldrw.u32 q4, [r6, #272]
	vstrw.u32 q5, [r9, #288]
	vldrw.u32 q6, [r6, #304]
	vstrw.u32 q7, [r9, #320]
	vldrw.u32 q0, [r6, #336]
	vstrw.u32 q1, [r9, #352]
	vldrw.u32 q2, [r6, #368]
	vstrw.u32 q3, [r9, #384]
	vldrw.u32 q4, [r6, #0]
	vstrw.u32 q5, [r9, #16]
	vldrw.u32 q6, [r6, #32]
	vstrw.u32 q7, [r9, #48]
	vldrw.u32 q0, [r6, #64]
	vstrw.u32 q1, [r9, #80]
	vldrw.u32 q2, [r6, #96]
	vstrw.u32 q3, [r9, #112]
	vldrw.u32 q4, [r6, #128]
	vstrw.u32 q5, [r9, #144]
	vldrw.u32 q6, [r6, #160]
	vstrw.u32 q7, [r9, #176]
	vldrw.u32 q0, [r6, #192]
	vstrw.u32 q1, [r9, #208]
	vldrw.u32 q2, [r6, #224]
	vstrw.u32 q3, [r9, #240]
	vldrw.u32 q4, [r6, #256]
	vstrw.u32 q5, [r9, #272]
	vldrw.u32 q6, [r6, #288]
	vstrw.u32 q7, [r9, #304]
	vldrw.u32 q0, [r6, #320]
	vstrw.u32 q1, [r9, #336]
	vldrw.u32 q2, [r6, #352]
	vstrw.u32 q3, [r9, #368]
	vldrw.u32 q4, [r6, #384]
	vstrw.u32 q5, [r9, #0]
	vldrw.u32 q6, [r6, #16]
	vstrw.u32 q7, [r9, #32]
	vldrw.u32 q0, [r6, #48]
	vstrw.u32 q1, [r9, #64]
	vldrw.u32 q2, [r6, #80]
	vstrw.u32 q3, [r9, #96]
	vldrw.u32 q4, [r6, #112]
	vstrw.u32 q5, [r9, #128]
	vldrw.u32 q6, [r6, #144]
	vstrw.u32 q7, [r9, #160]
	vldrw.u32 q0, [r6, #176]
	vstrw.u32 q1, [r9, #192]
	vldrw.u32 q2, [r6, #208]
	vstrw.u32 q3, [r9, #224]
	vldrw.u32 q4, [r6, #240]
	vstrw.u32 q5, [r9, #256]
	vldrw.u32 q6, [r6, #272]
	vstrw.u32 q7, [r9, #288]
	vldrw.u32 q0, [r6, #304]
	vstrw.u32 q1, [r9, #320]
	vldrw.u32 q2, [r6, #336]
	vstrw.u32 q3, [r9, #352]
	vldrw.u32 q4, [r6, #368]
	vstrw.u32 q5, [r9, #384]
	vldrw.u32 q6, [r6, #0]
	vstrw.u32 q7, [r9, #16]
	vldrw.u32 q0, [r6, #32]
	vstrw.u32 q1, [r9, #48]
	vldrw.u32 q2, [r6, #64]
	vstrw.u32 q3, [r9, #80]
	vldrw.u32 q4, [r6, #96]
	vstrw.u32 q5, [r9, #112]
	vldrw.u32 q6, [r6, #128]
	vstrw.u32 q7, [r9, #144]
	vldrw.u32 q0, [r6, #160]
	vstrw.u32 q1, [r9, #176]
	vldrw.u32 q2, [r6, #192]
	vstrw.u32 q3, [r9, #208]
	vldrw.u32 q4, [r6, #224]
	vstrw.u32 q5, [r9, #240]
	vldrw.u32 q6, [r6, #256]
	vstrw.u32 q7, [r9, #272]
	vldrw.u32 q0, [r6, #288]
	vstrw.u32 q1, [r9, #304]
	vldrw.u32 q2, [r6, #320]
	vstrw.u32 q3, [r9, #336]
	vldrw.u32 q4, [r6, #352]
	vstrw.u32 q5, [r9, #368]
	vldrw.u32 q6, [r6, #384]
	vstrw.u32 q7, [r9, #0]
	vldrw.u32 q0, [r6, #16]
	vstrw.u32 q1, [r9, #32]
	vldrw.u32 q2, [r6, #48]
	vstrw.u32 q3, [r9, #64]
	vldrw.u32 q4, [r6, #80]
	vstrw.u32 q5, [r9, #96]
	vldrw.u32 q6, [r6, #112]
	vstrw.u32 q7, [r9, #128]
	vldrw.u32 q0, [r6, #144]
	vstrw.u32 q1, [r9, #160]
	vldrw.u32 q2, [r6, #176]
	vstrw.u32 q3, [r9, #192]
	vldrw.u32 q4, [r6, #208]
	vstrw.u32 q5, [r9, #224]
	vldrw.u32 q6, [r6, #240]
	vstrw.u32 q7, [r9, #256]
	vldrw.u32 q0, [r6, #272]
	vstrw.u32 q1, [r9, #288]
	vldrw.u32 q2, [r6, #304]
	vstrw.u32 q3, [r9, #320]
	vldrw.u32 q4, [r6, #336]
	vstrw.u32 q5, [r9, #352]
	vldrw.u32 q6, [r6, #368]
	vstrw.u32 q7, [r9, #384]
	vldrw.u32 q0, [r6, #0]
	vstrw.u32 q1, [r9, #16]
	vldrw.u32 q2, [r6, #32]
	vstrw.u32 q3, [r9, #48]
	vldrw.u32 q4, [r6, #64]
	vstrw.u32 q5, [r9, #80]
	vldrw.u32 q6, [r6, #96]
	vstrw.u32 q7, [r9, #112]
	vldrw.u32 q0, [r6, #128]
	vstrw.u32 q1, [r9, #144]
	vldrw.u32 q2, [r6, #160]
	vstrw.u32 q3, [r9, #176]
	vldrw.u32 q4, [r6, #192]
	vstrw.u32 q5, [r9, #208]
	vldrw.u32 q6, [r6, #224]
	vstrw.u32 q7, [r9, #240]
	vldrw.u32 q0, [r6, #256]
	vstrw.u32 q1, [r9, #272]
	vldrw.u32 q2, [r6, #288]
	vstrw.u32 q3, [r9, #304]
	vldrw.u32 q4, [r6, #320]
	vstrw.u32 q5, [r9, #336]
	vldrw.u32 q6, [r6, #352]
	vstrw.u32 q7, [r9, #368]
	vldrw.u32 q0, [r6, #384]
	vstrw.u32 q1, [r9, #0]
	vldrw.u32 q2, [r6, #16]
	vstrw.u32 q3, [r9, #32]
	vldrw.u32 q4, [r6, #48]
	vstrw.u32 q5, [r9, #64]
	vldrw.u32 q6, [r6, #80]
	vstrw.u32 q7, [r9, #96]
	vldrw.u32 q0, [r6, #112]
	vstrw.u32 q1, [r9, #128]
	vldrw.u32 q2, [r6, #144]
	vstrw.u32 q3, [r9, #160]
	vldrw.u32 q4, [r6, #176]
	vstrw.u32 q5, [r9, #192]
	vldrw.u32 q6, [r6, #208]
	vstrw.u32 q7, [r9, #224]
	vldrw.u32 q0, [r6, #240]
	vstrw.u32 q1, [r9, #256]
	vldrw.u32 q2, [r6, #272]
	vstrw.u32 q3, [r9, #288]
	vldrw.u32 q4, [r6, #304]
	vstrw.u32 q5, [r9, #320]
	vldrw.u32 q6, [r6, #336]
	vstrw.u32 q7, [r9, #352]
	vldrw.u32 q0, [r6, #368]
	vstrw.u32 q1, [r9, #384]
	vldrw.u32 q2, [r6, #0]
	vstrw.u32 q3, [r9, #16]
	vldrw.u32 q4, [r6, #32]
	vstrw.u32 q5, [r9, #48]
	vldrw.u32 q6, [r6, #64]
	vstrw.u32 q7, [r9, #80]
	vldrw.u32 q0, [r6, #96]
	vstrw.u32 q1, [r9, #112]
	vldrw.u32 q2, [r6, #128]
	vstrw.u32 q3, [r9, #144]
	vldrw.u32 q4, [r6, #160]
	vstrw.u32 q5, [r9, #176]
	vldrw.u32 q6, [r6, #192]
	vstrw.u32 q7, [r9, #208]
	vldrw.u32 q0, [r6, #224]
	vstrw.u32 q1, [r9, #240]
	vldrw.u32 q2, [r6, #256]
	vstrw.u32 q3, [r9, #272]
	vldrw.u32 q4, [r6, #288]
	vstrw.u32 q5, [r9, #304]
	vldrw.u32 q6, [r6, #320]
	vstrw.u32 q7, [r9, #336]
	vldrw.u32 q0, [r6, #352]
	vstrw.u32 q1, [r9, #368]
	vldrw.u32 q2, [r6, #384]
	vstrw.u32 q3, [r9, #0]
	vldrw.u32 q4, [r6, #16]
	vstrw.u32 q5, [r9, #32]
	vldrw.u32 q6, [r6, #48]
	vstrw.u32 q7, [r9, #64]
	vldrw.u32 q0, [r6, #80]
	vstrw.u32 q1, [r9, #96]
	vldrw.u32 q2, [r6, #112]
	vstrw.u32 q3, [r9, #128]
	vldrw.u32 q4, [r6, #144]
	vstrw.u32 q5, [r9, #160]
	vldrw.u32 q6, [r6, #176]
	vstrw.u32 q7, [r9, #192]
	vldrw.u32 q0, [r6, #208]
	vstrw.u32 q1, [r9, #224]
	vldrw.u32 q2, [r6, #240]
	vstrw.u32 q3, [r9, #256]
	vldrw.u32 q4, [r6, #272]
	vstrw.u32 q5, [r9, #288]
	vldrw.u32 q6, [r6, #304]
	vstrw.u32 q7, [r9, #320]
	vldrw.u32 q0, [r6, #336]
	vstrw.u32 q1, [r9, #352]
	vldrw.u32 q2, [r6, #368]
	vstrw.u32 q3, [r9, #384]
	vldrw.u32 q4, [r6, #0]
	vstrw.u32 q5, [r9, #16]
	vldrw.u32 q6, [r6, #32]
	vstrw.u32 q7, [r9, #48]
	vldrw.u32 q0, [r6, #64]
	vstrw.u32 q1, [r9, #80]
	vldrw.u32 q2, [r6, #96]
	vstrw.u32 q3, [r9, #112]
	vldrw.u32 q4, [r6, #128]
	vstrw.u32 q5, [r9, #144]
	vldrw.u32 q6, [r6, #160]
	vstrw.u32 q7, [r9, #176]
	vldrw.u32 q0, [r6, #192]
	vstrw.u32 q1, [r9, #208]
	vldrw.u32 q2, [r6, #224]
	vstrw.u32 q3, [r9, #240]
	vldrw.u32 q4, [r6, #256]
	vstrw.u32 q5, [r9, #272]
	vldrw.u32 q6, [r6, #288]
	vstrw.u32 q7, [r9, #304]
	vldrw.u32 q0, [r6, #320]
	vstrw.u32 q1, [r9, #336]
	vldrw.u32 q2, [r6, #352]
	vstrw.u32 q3, [r9, #368]
	vldrw.u32 q4, [r6, #384]
	vstrw.u32 q5, [r9, #0]
	vldrw.u32 q6, [r6, #16]
	vstrw.u32 q7, [r9, #32]
	vldrw.u32 q0, [r6, #48]
	vstrw.u32 q1, [r9, #64]
	vldrw.u32 q2, [r6, #80]
	vstrw.u32 q3, [r9, #96]
	vldrw.u32 q4, [r6, #112]
	vstrw.u32 q5, [r9, #128]
	vldrw.u32 q6, [r6, #144]
	vstrw.u32 q7, [r9, #160]
	vldrw.u32 q0, [r6, #176]
	vstrw.u32 q1, [r9, #192]
	vldrw.u32 q2, [r6, #208]
	vstrw.u32 q3, [r9, #224]
	vldrw.u32 q4, [r6, #240]
	vstrw.u32 q5, [r9, #256]
	vldrw.u32 q6, [r6, #272]
	vstrw.u32 q7, [r9, #288]
	vldrw.u32 q0, [r6, #304]
	vstrw.u32 q1, [r9, #320]
	vldrw.u32 q2, [r6, #336]
	vstrw.u32 q3, [r9, #352]
	vldrw.u32 q4, [r6, #368]
	vstrw.u32 q5, [r9, #384]
	vldrw.u32 q6, [r6, #0]
	vstrw.u32 q7, [r9, #16]
	vldrw.u32 q0, [r6, #32]
	vstrw.u32 q1, [r9, #48]
	vldrw.u32 q2, [r6, #64]
	vstrw.u32 q3, [r9, #80]
	vldrw.u32 q4, [r6, #96]
	vstrw.u32 q5, [r9, #112]
	vldrw.u32 q6, [r6, #128]
	vstrw.u32 q7, [r9, #144]
	vldrw.u32 q0, [r6, #160]
	vstrw.u32 q1, [r9, #176]
	vldrw.u32 q2, [r6, #192]
	vstrw.u32 q3, [r9, #208]
	vldrw.u32 q4, [r6, #224]
	vstrw.u32 q5, [r9, #240]
	vldrw.u32 q6, [r6, #256]
	vstrw.u32 q7, [r9, #272]
	vldrw.u32 q0, [r6, #288]
	vstrw.u32 q1, [r9, #304]
	vldrw.u32 q2, [r6, #320]
	vstrw.u32 q3, [r9, #336]
	vldrw.u32 q4, [r6, #352]
	vstrw.u32 q5, [r9, #368]
	vldrw.u32 q6, [r6, #384]
	vstrw.u32 q7, [r9, #0]
	vldrw.u32 q0, [r6, #16]
	vstrw.u32 q1, [r9, #32]
	vldrw.u32 q2, [r6, #48]
	vstrw.u32 q3, [r9, #64]
	vldrw.u32 q4, [r6, #80]
	vstrw.u32 q5, [r9, #96]
	vldrw.u32 q6, [r6, #112]
	vstrw.u32 q7, [r9, #128]
	vldrw.u32 q0, [r6, #144]
	vstrw.u32 q1, [r9, #160]
	vldrw.u32 q2, [r6, #176]
	vstrw.u32 q3, [r9, #192]
	vldrw.u32 q4, [r6, #208]
	vstrw.u32 q5, [r9, #224]
	vldrw.u32 q6, [r6, #240]
	vstrw.u32 q7, [r9, #256]
	vldrw.u32 q0, [r6, #272]
	vstrw.u32 q1, [r9, #288]
	vldrw.u32 q2, [r6, #304]
	vstrw.u32 q3, [r9, #320]
	vldrw.u32 q4, [r6, #336]
	vstrw.u32 q5, [r9, #352]
	vldrw.u32 q6, [r6, #368]
	vstrw.u32 q7, [r9, #384]
	vldrw.u32 q0, [r6, #0]
	vstrw.u32 q1, [r9, #16]
	vldrw.u32 q2, [r6, #32]
	vstrw.u32 q3, [r9, #48]
	vldrw.u32 q4, [r6, #64]
	vstrw.u32 q5, [r9, #80]
	vldrw.u32 q6, [r6, #96]
	vstrw.u32 q7, [r9, #112]
	vldrw.u32 q0, [r6, #128]
	vstrw.u32 q1, [r9, #144]
	vldrw.u32 q2, [r6, #160]
	vstrw.u32 q3, [r9, #176]
	vldrw.u32 q4, [r6, #192]
	vstrw.u32 q5, [r9, #208]
	vldrw.u32 q6, [r6, #224]
	vstrw.u32 q7, [r9, #240]
	vldrw.u32 q0, [r6, #256]
	vstrw.u32 q1, [r9, #272]
	vldrw.u32 q2, [r6, #288]
	vstrw.u32 q3, [r9, #304]
	vldrw.u32 q4, [r6, #320]
	vstrw.u32 q5, [r9, #336]
	vldrw.u32 q6, [r6, #352]
	vstrw.u32 q7, [r9, #368]
	vldrw.u32 q0, [r6, #384]
	vstrw.u32 q1, [r9, #0]
	vldrw.u32 q2, [r6, #16]
	vstrw.u32 q3, [r9, #32]
	vldrw.u32 q4, [r6, #48]
	vstrw.u32 q5, [r9, #64]
	vldrw.u32 q6, [r6, #80]
	vstrw.u32 q7, [r9, #96]
	vldrw.u32 q0, [r6, #112]
	vstrw.u32 q1, [r9, #128]
	vldrw.u32 q2, [r6, #144]
	vstrw.u32 q3, [r9, #160]
	vldrw.u32 q4, [r6, #176]
	vstrw.u32 q5, [r9, #192]
	vldrw.u32 q6, [r6, #208]
	vstrw.u32 q7, [r9, #224]
	vldrw.u32 q0, [r6, #240]
	vstrw.u32 q1, [r9, #256]
	vldrw.u32 q2, [r6, #272]
	vstrw.u32 q3, [r9, #288]
	vldrw.u32 q4, [r6, #304]
	vstrw.u32 q5, [r9, #320]
	vldrw.u32 q6, [r6, #336]
	vstrw.u32 q7, [r9, #352]
	vldrw.u32 q0, [r6, #368]
	vstrw.u32 q1, [r9, #384]
	vldrw.u32 q2, [r6, #0]
	vstrw.u32 q3, [r9, #16]
	vldrw.u32 q4, [r6, #32]
	vstrw.u32 q5, [r9, #48]
	vldrw.u32 q6, [r6, #64]
	vstrw.u32 q7, [r9, #80]
	vldrw.u32 q0, [r6, #96]
	vstrw.u32 q1, [r9, #112]
	vldrw.u32 q2, [r6, #128]
	vstrw.u32 q3, [r9, #144]
	vldrw.u32 q4, [r6, #160]
	vstrw.u32 q5, [r9, #176]
	vldrw.u32 q6, [r6, #192]
	vstrw.u32 q7, [r9, #208]
	vldrw.u32 q0, [r6, #224]
	vstrw.u32 q1, [r9, #240]
	vldrw.u32 q2, [r6, #256]
	vstrw.u32 q3, [r9, #272]
	vldrw.u32 q4, [r6, #288]
	vstrw.u32 q5, [r9, #304]
	vldrw.u32 q6, [r6, #320]
	vstrw.u32 q7, [r9, #336]
	vldrw.u32 q0, [r6, #352]
	vstrw.u32 q1, [r9, #368]
	vldrw.u32 q2, [r6, #384]
	vstrw.u32 q3, [r9, #0]
	vldrw.u32 q4, [r6, #16]
	vstrw.u32 q5, [r9, #32]
	vldrw.u32 q6, [r6, #48]
	vstrw.u32 q7, [r9, #64]
	vldrw.u32 q0, [r6, #80]
	vstrw.u32 q1, [r9, #96]
	vldrw.u32 q2, [r6, #112]
	vstrw.u32 q3, [r9, #128]
	vldrw.u32 q4, [r6, #144]
	vstrw.u32 q5, [r9, #160]
	vldrw.u32 q6, [r6, #176]
	vstrw.u32 q7, [r9, #192]
	vldrw.u32 q0, [r6, #208]
	vstrw.u32 q1, [r9, #224]
	vldrw.u32 q2, [r6, #240]
	vstrw.u32 q3, [r9, #256]
	vldrw.u32 q4, [r6, #272]
	vstrw.u32 q5, [r9, #288]
	vldrw.u32 q6, [r6, #304]
	vstrw.u32 q7, [r9, #320]
	vldrw.u32 q0, [r6, #336]
	vstrw.u32 q1, [r9, #352]
	vldrw.u32 q2, [r6, #368]
	vstrw.u32 q3, [r9, #384]
	vldrw.u32 q4, [r6, #0]
	vstrw.u32 q5, [r9, #16]
	vldrw.u32 q6, [r6, #32]
	vstrw.u32 q7, [r9, #48]
	vldrw.u32 q0, [r6, #64]
	vstrw.u32 q1, [r9, #80]
	vldrw.u32 q2, [r6, #96]
	vstrw.u32 q3, [r9, #112]
	vldrw.u32 q4, [r6, #128]
	vstrw.u32 q5, [r9, #144]
	vldrw.u32 q6, [r6, #160]
	vstrw.u32 q7, [r9, #176]
	vldrw.u32 q0, [r6, #192]
	vstrw.u32 q1, [r9, #208]
	vldrw.u32 q2, [r6, #224]
	vstrw.u32 q3, [r9, #240]
	vldrw.u32 q4, [r6, #256]
	vstrw.u32 q5, [r9, #272]
	vldrw.u32 q6, [r6, #288]
	vstrw.u32 q7, [r9, #304]
	vldrw.u32 q0, [r6, #320]
	vstrw.u32 q1, [r9, #336]
	vldrw.u32 q2, [r6, #352]
	vstrw.u32 q3, [r9, #368]
	vldrw.u32 q4, [r6, #384]
	vstrw.u32 q5, [r9, #0]
	vldrw.u32 q6, [r6, #16]
	vstrw.u32 q7, [r9, #32]
	vldrw.u32 q0, [r6, #48]
	vstrw.u32 q1, [r9, #64]
	vldrw.u32 q2, [r6, #80]
	vstrw.u32 q3, [r9, #96]
	vldrw.u32 q4, [r6, #112]
	vstrw.u32 q5, [r9, #128]
	vldrw.u32 q6, [r6, #144]
	vstrw.u32 q7, [r9, #160]
	vldrw.u32 q0, [r6, #176]
	vstrw.u32 q1, [r9, #192]
	vldrw.u32 q2, [r6, #208]
	vstrw.u32 q3, [r9, #224]
	vldrw.u32 q4, [r6, #240]
	vstrw.u32 q5, [r9, #256]
	vldrw.u32 q6, [r6, #272]
	vstrw.u32 q7, [r9, #288]
	vldrw.u32 q0, [r6, #304]
	vstrw.u32 q1, [r9, #320]
	vldrw.u32 q2, [r6, #336]
	vstrw.u32 q3, [r9, #352]
	vldrw.u32 q4, [r6, #368]
	vstrw.u32 q5, [r9, #384]
	vldrw.u32 q6, [r6, #0]
	vstrw.u32 q7, [r9, #16]
	vldrw.u32 q0, [r6, #32]
	vstrw.u32 q1, [r9, #48]
	vldrw.u32 q2, [r6, #64]
	vstrw.u32 q3, [r9, #80]
	vldrw.u32 q4, [r6, #96]
	vstrw.u32 q5, [r9, #112]
	vldrw.u32 q6, [r6, #128]
	vstrw.u32 q7, [r9, #144]
	vldrw.u32 q0, [r6, #160]
	vstrw.u32 q1, [r9, #176]
	vldrw.u32 q2, [r6, #192]
	vstrw.u32 q3, [r9, #208]
	vldrw.u32 q4, [r6, #224]
	vstrw.u32 q5, [r9, #240]
	vldrw.u32 q6, [r6, #256]
	vstrw.u32 q7, [r9, #272]
	vldrw.u32 q0, [r6, #288]
	vstrw.u32 q1, [r9, #304]
	vldrw.u32 q2, [r6, #320]
	vstrw.u32 q3, [r9, #336]
	vldrw.u32 q4, [r6, #352]
	vstrw.u32 q5, [r9, #368]
	vldrw.u32 q6, [r6, #384]
	vstrw.u32 q7, [r9, #0]
	vldrw.u32 q0, [r6, #16]
	vstrw.u32 q1, [r9, #32]
	vldrw.u32 q2, [r6, #48]
	vstrw.u32 q3, [r9, #64]
	vldrw.u32 q4, [r6, #80]
	vstrw.u32 q5, [r9, #96]
	vldrw.u32 q6, [r6, #112]
	vstrw.u32 q7, [r9, #128]
	vldrw.u32 q0, [r6, #144]
	vstrw.u32 q1, [r9, #160]
	vldrw.u32 q2, [r6, #176]
	vstrw.u32 q3, [r9, #192]
	vldrw.u32 q4, [r6, #208]
	vstrw.u32 q5, [r9, #224]
	vldrw.u32 q6, [r6, #240]
	vstrw.u32 q7, [r9, #256]
	vldrw.u32 q0, [r6, #272]
	vstrw.u32 q1, [r9, #288]
	vldrw.u32 q2, [r6, #304]
	vstrw.u32 q3, [r9, #320]
	vldrw.u32 q4, [r6, #336]
	vstrw.u32 q5, [r9, #352]
	vldrw.u32 q6, [r6, #368]
	vstrw.u32 q7, [r9, #384]
	vldrw.u32 q0, [r6, #0]
	vstrw.u32 q1, [r9, #16]
	vldrw.u32 q2, [r6, #32]
	vstrw.u32 q3, [r9, #48]
	vldrw.u32 q4, [r6, #64]
	vstrw.u32 q5, [r9, #80]
	vldrw.u32 q6, [r6, #96]
	vstrw.u32 q7, [r9, #112]
	vldrw.u32 q0, [r6, #128]
	vstrw.u32 q1, [r9, #144]
	vldrw.u32 q2, [r6, #160]
	subs r12, r12, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// pairn_lsmix_zip (1222 instrs)
.global pairn_lsmix_zip
.type pairn_lsmix_zip, %function
.thumb_func
.balign 16
pairn_lsmix_zip:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r12, r0
	movw r6, #:lower16:g_mve
	movt r6, #:upper16:g_mve
	add r9, r6, #1024
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #160]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #192]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #224]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #256]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #288]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #320]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #352]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #384]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #16]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #48]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #80]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #112]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #144]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #176]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #208]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #240]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #272]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #304]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #336]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #368]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #32]
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r6, #64]
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r6, #96]
	umaal r0, r1, r2, r3
	vstrw.u32 q7, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #128]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r9, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r6, #160]
	subs r12, r12, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

