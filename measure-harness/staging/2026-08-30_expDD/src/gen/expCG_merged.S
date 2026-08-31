/* 실험 CG: 게스트 재물질화 할당 (생성기: expBB-src/guest_alloc.py).
 * 호스트 fe25519_sqr_bb 는 명령 순서·레지스터 모두 원본 그대로다.
 * 게스트 intt layer67 x 4 를 죽은 레지스터에 재물질화하며 끼워 넣었다.
 * 재물질화 75 명령 / 캐시 적중 51 / 스칼라 필요 게스트 106.
 * expcg_c 는 fe25519_sqr 과 동일한 ABI(in/out r0-r7, clobber r8-r12/lr)다.
 */
	.syntax unified
	.thumb
	.section .text, "ax", %progbits
	.align 4

	.type expcg_p, %function
	.global expcg_p
expcg_p:
	vpush {d8-d15}
	movw r12, #:lower16:expcg_qinit
	movt r12, #:upper16:expcg_qinit
	vldrw.U32 q0, [r12, #0]
	vldrw.U32 q1, [r12, #16]
	vldrw.U32 q2, [r12, #32]
	vldrw.U32 q3, [r12, #48]
	vldrw.U32 q4, [r12, #64]
	vldrw.U32 q5, [r12, #80]
	vldrw.U32 q6, [r12, #96]
	vldrw.U32 q7, [r12, #112]

	vpop {d8-d15}
	bx lr
	.size expcg_p, .-expcg_p

	.type expcg_a, %function
	.global expcg_a
expcg_a:
	vpush {d8-d15}
	movw r12, #:lower16:expcg_qinit
	movt r12, #:upper16:expcg_qinit
	vldrw.U32 q0, [r12, #0]
	vldrw.U32 q1, [r12, #16]
	vldrw.U32 q2, [r12, #32]
	vldrw.U32 q3, [r12, #48]
	vldrw.U32 q4, [r12, #64]
	vldrw.U32 q5, [r12, #80]
	vldrw.U32 q6, [r12, #96]
	vldrw.U32 q7, [r12, #112]
	movw r0, #:lower16:(expcg_buf+352)
	movt r0, #:upper16:(expcg_buf+352)
	movw r8, #512
	movw r9, #5040
	movw r12, #0xf2ff
	vldrw.U32 q7, [r0, #-320]
	vshl.i16 q3, q7, #9
	vqrdmulh.S16 q4, q7, r9
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r0, #-304]
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r0, #-336]
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r0, #-352]
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	vshl.i16 q3, q0, #9
	vldrw.U32 q1, [r0, #0]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r0, #32]
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r0, #48]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r0, #16]
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r0, #-16]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r0, #-32]
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r0, #-352]
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r0, #-304]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r0, #-256]
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r0, #-320]
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r0, #-336]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r0, #-240]
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r0, #-272]
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r0, #-288]
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	vshl.i16 q3, q0, #9
	vldrw.U32 q1, [r0, #96]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r0, #128]
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r0, #144]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r0, #112]
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r0, #80]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r0, #64]
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r0, #-288]
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r0, #-240]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r0, #-192]
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r0, #-256]
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r0, #-272]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r0, #-176]
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r0, #-208]
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r0, #-224]
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	vshl.i16 q3, q0, #9
	vldrw.U32 q1, [r0, #192]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r0, #224]
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r0, #240]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r0, #208]
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r0, #176]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r0, #160]
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r0, #-224]
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r0, #-176]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r0, #-128]
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r0, #-192]
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r0, #-208]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r0, #-112]
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r0, #-144]
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r0, #-160]
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	vshl.i16 q3, q0, #9
	vldrw.U32 q1, [r0, #288]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r0, #320]
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r0, #336]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r0, #304]
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r0, #272]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r0, #256]
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r0, #-160]
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r0, #-112]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r0, #-64]
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r0, #-128]
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r0, #-144]
	vpop {d8-d15}
	bx lr
	.size expcg_a, .-expcg_a

	.type expcg_a0, %function
	.global expcg_a0
expcg_a0:
	vpush {d8-d15}
	movw r12, #:lower16:expcg_qinit
	movt r12, #:upper16:expcg_qinit
	vldrw.U32 q0, [r12, #0]
	vldrw.U32 q1, [r12, #16]
	vldrw.U32 q2, [r12, #32]
	vldrw.U32 q3, [r12, #48]
	vldrw.U32 q4, [r12, #64]
	vldrw.U32 q5, [r12, #80]
	vldrw.U32 q6, [r12, #96]
	vldrw.U32 q7, [r12, #112]
	movw r0, #:lower16:(expcg_buf+352)
	movt r0, #:upper16:(expcg_buf+352)
	movw r8, #512
	movw r9, #5040
	movw r12, #0xf2ff
	vldrw.U32 q7, [r0, #-320]
	vmul.S16 q3, q7, r8
	vqrdmulh.S16 q4, q7, r9
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r0, #-304]
	vmul.S16 q4, q7, r8
	vldrw.U32 q1, [r0, #-336]
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r0, #-352]
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	vmul.S16 q7, q1, r8
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	vmul.S16 q3, q0, r8
	vldrw.U32 q1, [r0, #0]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r0, #32]
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r0, #48]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r0, #16]
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r0, #-16]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r0, #-32]
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r0, #-352]
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r0, #-304]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r0, #-256]
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r0, #-320]
	vmul.S16 q3, q3, r8
	vstrw.U32 q5, [r0, #-336]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r0, #-240]
	vmul.S16 q4, q7, r8
	vldrw.U32 q1, [r0, #-272]
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r0, #-288]
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	vmul.S16 q7, q1, r8
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	vmul.S16 q3, q0, r8
	vldrw.U32 q1, [r0, #96]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r0, #128]
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r0, #144]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r0, #112]
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r0, #80]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r0, #64]
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r0, #-288]
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r0, #-240]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r0, #-192]
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r0, #-256]
	vmul.S16 q3, q3, r8
	vstrw.U32 q5, [r0, #-272]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r0, #-176]
	vmul.S16 q4, q7, r8
	vldrw.U32 q1, [r0, #-208]
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r0, #-224]
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	vmul.S16 q7, q1, r8
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	vmul.S16 q3, q0, r8
	vldrw.U32 q1, [r0, #192]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r0, #224]
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r0, #240]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r0, #208]
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r0, #176]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r0, #160]
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r0, #-224]
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r0, #-176]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r0, #-128]
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r0, #-192]
	vmul.S16 q3, q3, r8
	vstrw.U32 q5, [r0, #-208]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r0, #-112]
	vmul.S16 q4, q7, r8
	vldrw.U32 q1, [r0, #-144]
	vqrdmulh.S16 q6, q7, r9
	vldrw.U32 q0, [r0, #-160]
	vmla.S16 q4, q6, r12
	vqrdmulh.S16 q6, q1, r9
	vsub.U16 q5, q3, q4
	vmul.S16 q7, q1, r8
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r12
	vmul.S16 q3, q0, r8
	vldrw.U32 q1, [r0, #288]
	vqrdmulh.S16 q2, q0, r9
	vldrw.U32 q0, [r0, #320]
	vmla.S16 q3, q2, r12
	vldrw.U32 q2, [r0, #336]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r0, #304]
	vmla.S16 q0, q5, r12
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r12
	vldrw.U32 q6, [r0, #272]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r0, #256]
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r0, #-160]
	vmla.S16 q2, q6, r12
	vstrw.U32 q2, [r0, #-112]
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r0, #-64]
	vmla.S16 q1, q5, r12
	vadd.U16 q5, q7, q0
	vqrdmulh.S16 q4, q3, r9
	vstrw.U32 q1, [r0, #-128]
	vmul.S16 q3, q3, r8
	vstrw.U32 q5, [r0, #-144]
	vpop {d8-d15}
	bx lr
	.size expcg_a0, .-expcg_a0

	.type expcg_b, %function
	.global expcg_b
expcg_b:
	vpush {d8-d15}
	movw r12, #:lower16:expcg_qinit
	movt r12, #:upper16:expcg_qinit
	vldrw.U32 q0, [r12, #0]
	vldrw.U32 q1, [r12, #16]
	vldrw.U32 q2, [r12, #32]
	vldrw.U32 q3, [r12, #48]
	vldrw.U32 q4, [r12, #64]
	vldrw.U32 q5, [r12, #80]
	vldrw.U32 q6, [r12, #96]
	vldrw.U32 q7, [r12, #112]
	push {lr}
	sub sp,#20
	umull r9,r10,r0,r0
	umull r11,r12,r0,r1
	adds r11,r11,r11
	mov lr,#0
	umaal r10,r11,lr,lr
	push {r9,r10}
	mov r8,#0
	umull r9,r10,r0,r3
	umaal r8,r12,r0,r2
	umaal r9,r12,r1,r2
	adcs r8,r8,r8
	umaal r8,r11,r1,r1
	adcs r9,r9,r9
	umaal r9,r11,lr,lr
	strd r8,r9,[sp,#8]
	mov r9,#0
	umaal r9,r10,r0,r4
	umaal r9,r12,r1,r3
	adcs r9,r9,r9
	umaal r9,r11,r2,r2
	str r9,[sp,#16]
	umull r9,r8,r0,r5
	umaal r9,r10,r1,r4
	umaal r9,r12,r2,r3
	adcs r9,r9,r9
	umaal r9,r11,lr,lr
	str r9,[sp,#20]
	mov r9,#0
	umaal r9,r8,r1,r5
	umaal r9,r12,r2,r4
	umaal r9,r10,r0,r6
	adcs r9,r9,r9
	umaal r9,r11,r3,r3
	str r9,[sp,#24]
	umull r0,r9,r0,r7
	umaal r0,r10,r1,r6
	umaal r0,r12,r2,r5
	umaal r0,r8,r3,r4
	umaal r9,r8,r1,r7
	umaal r9,r10,r2,r6
	adcs r0,r0,r0
	umaal r12,r9,r3,r5
	umaal r9,r8,r2,r7
	adcs r12,r12,r12
	umaal r10,r9,r3,r6
	movs r2,#0
	umaal r0,r11,lr,lr
	umaal r10,r2,r4,r5
	umaal r2,r8,r3,r7
	umaal r9,r2,r4,r6
	adcs r10,r10,r10
	umaal r11,r12,r4,r4
	adcs r9,r9,r9
	umaal r12,r10,lr,lr
	movs r3,#0
	umaal r10,r9,r5,r5
	umaal r3,r8,r4,r7
	umaal r3,r2,r5,r6
	umaal r8,r2,r5,r7
	umull r4,r5,lr,lr
	adcs r3,r3,r3
	umaal r4,r2,r6,r7
	adcs r8,r8,r8
	umaal r9,r3,lr,lr
	umaal r3,r8,r6,r6
	adcs r4,r4,r4
	umaal r4,r8,lr,lr
	adcs r2,r2,r2
	umaal r8,r2,r7,r7
	mov r6,#38
	adcs r2,r2,lr
	umaal r0,lr,r6,r2
	movs r5,#19
	lsl lr,lr,#1
	and r7,r0,#0x7fffffff
	orr lr,lr,r0, lsr #31
	mul lr,lr,r5
	pop {r0,r1}
	umaal r0,lr,r6,r11
	umaal r1,lr,r6,r12
	mov r11,r3
	mov r12,r4
	pop {r2,r3,r4,r5}
	umaal r2,lr,r6,r10
	umaal r3,lr,r6,r9
	umaal r4,lr,r6,r11
	umaal r5,lr,r6,r12
	pop {r6}
	mov r12,#38
	umaal r6,lr,r12,r8
	add r7,r7,lr
	pop {lr}
	vpop {d8-d15}
	bx lr
	.size expcg_b, .-expcg_b

	.type expcg_c, %function
	.global expcg_c
expcg_c:
	vpush {d8-d15}
	movw r12, #:lower16:expcg_qinit
	movt r12, #:upper16:expcg_qinit
	vldrw.U32 q0, [r12, #0]
	vldrw.U32 q1, [r12, #16]
	vldrw.U32 q2, [r12, #32]
	vldrw.U32 q3, [r12, #48]
	vldrw.U32 q4, [r12, #64]
	vldrw.U32 q5, [r12, #80]
	vldrw.U32 q6, [r12, #96]
	vldrw.U32 q7, [r12, #112]
push {lr}
	movw r8, #:lower16:(expcg_buf+352)
	movt r8, #:upper16:(expcg_buf+352)
	vldrw.U32 q7, [r8, #-320]
sub sp,#20
	vshl.i16 q3, q7, #9
	movw r11, #5040
	vqrdmulh.S16 q4, q7, r11
umull r9,r10,r0,r0
	movw r12, #0xf2ff
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r8, #-304]
umull r11,r12,r0,r1
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r8, #-336]
adds r11,r11,r11
	movw r8, #5040
	vqrdmulh.S16 q6, q7, r8
	movw r8, #:lower16:(expcg_buf+352)
	movt r8, #:upper16:(expcg_buf+352)
	vldrw.U32 q0, [r8, #-352]
mov lr,#0
	movw r8, #0xf2ff
	vmla.S16 q4, q6, r8
	movw r8, #5040
	vqrdmulh.S16 q6, q1, r8
umaal r10,r11,lr,lr
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
push {r9,r10}
	vadd.U16 q4, q3, q4
	movw r10, #0xf2ff
	vmla.S16 q7, q6, r10
mov r8,#0
	vshl.i16 q3, q0, #9
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	vldrw.U32 q1, [r9, #0]
umull r9,r10,r0,r3
umaal r8,r12,r0,r2
umaal r9,r12,r1,r2
adcs r8,r8,r8
umaal r8,r11,r1,r1
adcs r9,r9,r9
umaal r9,r11,lr,lr
strd r8,r9,[sp,#8]
	movw r8, #5040
	vqrdmulh.S16 q2, q0, r8
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	vldrw.U32 q0, [r9, #32]
	movw r8, #0xf2ff
	vmla.S16 q3, q2, r8
	vldrw.U32 q2, [r9, #48]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r9, #16]
	vmla.S16 q0, q5, r8
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r8
	vldrw.U32 q6, [r9, #-16]
mov r9,#0
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
umaal r9,r10,r0,r4
	vqrdmulh.S16 q6, q2, q6
	movw r8, #:lower16:(expcg_buf+352)
	movt r8, #:upper16:(expcg_buf+352)
	vldrw.U32 q3, [r8, #-32]
umaal r9,r12,r1,r3
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r8, #-352]
adcs r9,r9,r9
	movw r8, #0xf2ff
	vmla.S16 q2, q6, r8
	movw r8, #:lower16:(expcg_buf+352)
	movt r8, #:upper16:(expcg_buf+352)
	vstrw.U32 q2, [r8, #-304]
umaal r9,r11,r2,r2
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r8, #-256]
str r9,[sp,#16]
	movw r9, #0xf2ff
	vmla.S16 q1, q5, r9
	vadd.U16 q5, q7, q0
umull r9,r8,r0,r5
umaal r9,r10,r1,r4
umaal r9,r12,r2,r3
adcs r9,r9,r9
umaal r9,r11,lr,lr
str r9,[sp,#20]
	movw r9, #5040
	vqrdmulh.S16 q4, q3, r9
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	vstrw.U32 q1, [r9, #-320]
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r9, #-336]
	movw r9, #0xf2ff
	vmla.S16 q3, q4, r9
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	vldrw.U32 q7, [r9, #-240]
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r9, #-272]
	movw r9, #5040
	vqrdmulh.S16 q6, q7, r9
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	vldrw.U32 q0, [r9, #-288]
	movw r9, #0xf2ff
	vmla.S16 q4, q6, r9
	movw r9, #5040
	vqrdmulh.S16 q6, q1, r9
mov r9,#0
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
umaal r9,r8,r1,r5
	vadd.U16 q4, q3, q4
umaal r9,r12,r2,r4
umaal r9,r10,r0,r6
adcs r9,r9,r9
umaal r9,r11,r3,r3
str r9,[sp,#24]
	movw r9, #0xf2ff
	vmla.S16 q7, q6, r9
	vshl.i16 q3, q0, #9
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	vldrw.U32 q1, [r9, #96]
	movw r9, #5040
	vqrdmulh.S16 q2, q0, r9
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	vldrw.U32 q0, [r9, #128]
	movw r9, #0xf2ff
	vmla.S16 q3, q2, r9
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	vldrw.U32 q2, [r9, #144]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r9, #112]
umull r0,r9,r0,r7
umaal r0,r10,r1,r6
umaal r0,r12,r2,r5
umaal r0,r8,r3,r4
umaal r9,r8,r1,r7
	movw r1, #0xf2ff
	vmla.S16 q0, q5, r1
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r1
	movw r1, #:lower16:(expcg_buf+352)
	movt r1, #:upper16:(expcg_buf+352)
	vldrw.U32 q6, [r1, #80]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
umaal r9,r10,r2,r6
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r1, #64]
adcs r0,r0,r0
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r1, #-288]
umaal r12,r9,r3,r5
	movw r1, #0xf2ff
	vmla.S16 q2, q6, r1
	movw r1, #:lower16:(expcg_buf+352)
	movt r1, #:upper16:(expcg_buf+352)
	vstrw.U32 q2, [r1, #-240]
umaal r9,r8,r2,r7
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r1, #-192]
adcs r12,r12,r12
	movw r2, #0xf2ff
	vmla.S16 q1, q5, r2
	vadd.U16 q5, q7, q0
umaal r10,r9,r3,r6
	movw r2, #5040
	vqrdmulh.S16 q4, q3, r2
	vstrw.U32 q1, [r1, #-256]
movs r2,#0
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r1, #-272]
umaal r0,r11,lr,lr
	movw r1, #0xf2ff
	vmla.S16 q3, q4, r1
	movw r1, #:lower16:(expcg_buf+352)
	movt r1, #:upper16:(expcg_buf+352)
	vldrw.U32 q7, [r1, #-176]
umaal r10,r2,r4,r5
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r1, #-208]
umaal r2,r8,r3,r7
	movw r3, #5040
	vqrdmulh.S16 q6, q7, r3
	vldrw.U32 q0, [r1, #-224]
umaal r9,r2,r4,r6
	movw r1, #0xf2ff
	vmla.S16 q4, q6, r1
	vqrdmulh.S16 q6, q1, r3
adcs r10,r10,r10
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
umaal r11,r12,r4,r4
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r1
adcs r9,r9,r9
	vshl.i16 q3, q0, #9
	movw r1, #:lower16:(expcg_buf+352)
	movt r1, #:upper16:(expcg_buf+352)
	vldrw.U32 q1, [r1, #192]
umaal r12,r10,lr,lr
	vqrdmulh.S16 q2, q0, r3
	vldrw.U32 q0, [r1, #224]
movs r3,#0
	movw r1, #0xf2ff
	vmla.S16 q3, q2, r1
	movw r1, #:lower16:(expcg_buf+352)
	movt r1, #:upper16:(expcg_buf+352)
	vldrw.U32 q2, [r1, #240]
umaal r10,r9,r5,r5
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
umaal r3,r8,r4,r7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r1, #208]
umaal r3,r2,r5,r6
	movw r4, #0xf2ff
	vmla.S16 q0, q5, r4
	vsub.U16 q5, q3, q7
umaal r8,r2,r5,r7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
umull r4,r5,lr,lr
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
adcs r3,r3,r3
	movw r5, #0xf2ff
	vmla.S16 q7, q2, r5
	vldrw.U32 q6, [r1, #176]
umaal r4,r2,r6,r7
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
adcs r8,r8,r8
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r1, #160]
umaal r9,r3,lr,lr
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r1, #-224]
umaal r3,r8,r6,r6
	vmla.S16 q2, q6, r5
	vstrw.U32 q2, [r1, #-176]
adcs r4,r4,r4
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r1, #-128]
umaal r4,r8,lr,lr
	vmla.S16 q1, q5, r5
	vadd.U16 q5, q7, q0
adcs r2,r2,r2
	movw r6, #5040
	vqrdmulh.S16 q4, q3, r6
	vstrw.U32 q1, [r1, #-192]
umaal r8,r2,r7,r7
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r1, #-208]
mov r6,#38
	vmla.S16 q3, q4, r5
	vldrw.U32 q7, [r1, #-112]
adcs r2,r2,lr
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r1, #-144]
umaal r0,lr,r6,r2
	movw r2, #5040
	vqrdmulh.S16 q6, q7, r2
	vldrw.U32 q0, [r1, #-160]
movs r5,#19
	movw r1, #0xf2ff
	vmla.S16 q4, q6, r1
	vqrdmulh.S16 q6, q1, r2
lsl lr,lr,#1
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
and r7,r0,#0x7fffffff
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r1
orr lr,lr,r0, lsr #31
	vshl.i16 q3, q0, #9
	movw r0, #:lower16:(expcg_buf+352)
	movt r0, #:upper16:(expcg_buf+352)
	vldrw.U32 q1, [r0, #288]
mul lr,lr,r5
	vqrdmulh.S16 q2, q0, r2
	vldrw.U32 q0, [r0, #320]
pop {r0,r1}
	movw r5, #0xf2ff
	vmla.S16 q3, q2, r5
	movw r2, #:lower16:(expcg_buf+352)
	movt r2, #:upper16:(expcg_buf+352)
	vldrw.U32 q2, [r2, #336]
umaal r0,lr,r6,r11
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
umaal r1,lr,r6,r12
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r2, #304]
mov r11,r3
	vmla.S16 q0, q5, r5
	vsub.U16 q5, q3, q7
mov r12,r4
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
pop {r2,r3,r4,r5}
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
umaal r2,lr,r6,r10
	movw r10, #0xf2ff
	vmla.S16 q7, q2, r10
	movw r10, #:lower16:(expcg_buf+352)
	movt r10, #:upper16:(expcg_buf+352)
	vldrw.U32 q6, [r10, #272]
umaal r3,lr,r6,r9
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
umaal r4,lr,r6,r11
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r10, #256]
umaal r5,lr,r6,r12
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r10, #-160]
pop {r6}
	movw r11, #0xf2ff
	vmla.S16 q2, q6, r11
	vstrw.U32 q2, [r10, #-112]
mov r12,#38
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r10, #-64]
umaal r6,lr,r12,r8
	vmla.S16 q1, q5, r11
	vadd.U16 q5, q7, q0
add r7,r7,lr
	movw r12, #5040
	vqrdmulh.S16 q4, q3, r12
	vstrw.U32 q1, [r10, #-128]
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r10, #-144]
pop {lr}
	vpop {d8-d15}
	bx lr
	.size expcg_c, .-expcg_c

	.type expcg_d, %function
	.global expcg_d
expcg_d:
	vpush {d8-d15}
	movw r12, #:lower16:expcg_qinit
	movt r12, #:upper16:expcg_qinit
	vldrw.U32 q0, [r12, #0]
	vldrw.U32 q1, [r12, #16]
	vldrw.U32 q2, [r12, #32]
	vldrw.U32 q3, [r12, #48]
	vldrw.U32 q4, [r12, #64]
	vldrw.U32 q5, [r12, #80]
	vldrw.U32 q6, [r12, #96]
	vldrw.U32 q7, [r12, #112]
	movw r8, #:lower16:(expcg_buf+352)
	movt r8, #:upper16:(expcg_buf+352)
	movw r11, #5040
push {lr}
	vldrw.U32 q7, [r8, #-320]
	movw r12, #0xf2ff
sub sp,#20
	vshl.i16 q3, q7, #9
	vqrdmulh.S16 q4, q7, r11
umull r9,r10,r0,r0
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r8, #-304]
umull r11,r12,r0,r1
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r8, #-336]
	movw r8, #5040
adds r11,r11,r11
	vqrdmulh.S16 q6, q7, r8
	movw r8, #:lower16:(expcg_buf+352)
	movt r8, #:upper16:(expcg_buf+352)
	vldrw.U32 q0, [r8, #-352]
	movw r8, #0xf2ff
mov lr,#0
	vmla.S16 q4, q6, r8
	movw r8, #5040
	vqrdmulh.S16 q6, q1, r8
umaal r10,r11,lr,lr
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
push {r9,r10}
	movw r10, #0xf2ff
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r10
mov r8,#0
	vshl.i16 q3, q0, #9
	vldrw.U32 q1, [r9, #0]
umull r9,r10,r0,r3
umaal r8,r12,r0,r2
umaal r9,r12,r1,r2
adcs r8,r8,r8
umaal r8,r11,r1,r1
adcs r9,r9,r9
umaal r9,r11,lr,lr
strd r8,r9,[sp,#8]
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	movw r8, #5040
	vqrdmulh.S16 q2, q0, r8
	movw r8, #0xf2ff
	vldrw.U32 q0, [r9, #32]
	vmla.S16 q3, q2, r8
	vldrw.U32 q2, [r9, #48]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r9, #16]
	vmla.S16 q0, q5, r8
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r8
	vldrw.U32 q6, [r9, #-16]
mov r9,#0
	movw r8, #:lower16:(expcg_buf+352)
	movt r8, #:upper16:(expcg_buf+352)
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
umaal r9,r10,r0,r4
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r8, #-32]
umaal r9,r12,r1,r3
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r8, #-352]
	movw r8, #0xf2ff
adcs r9,r9,r9
	vmla.S16 q2, q6, r8
	movw r8, #:lower16:(expcg_buf+352)
	movt r8, #:upper16:(expcg_buf+352)
	vstrw.U32 q2, [r8, #-304]
umaal r9,r11,r2,r2
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r8, #-256]
str r9,[sp,#16]
	movw r9, #0xf2ff
	vmla.S16 q1, q5, r9
	vadd.U16 q5, q7, q0
umull r9,r8,r0,r5
umaal r9,r10,r1,r4
umaal r9,r12,r2,r3
adcs r9,r9,r9
umaal r9,r11,lr,lr
str r9,[sp,#20]
	movw r9, #5040
	vqrdmulh.S16 q4, q3, r9
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	vstrw.U32 q1, [r9, #-320]
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r9, #-336]
	movw r9, #0xf2ff
	vmla.S16 q3, q4, r9
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	vldrw.U32 q7, [r9, #-240]
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r9, #-272]
	movw r9, #5040
	vqrdmulh.S16 q6, q7, r9
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	vldrw.U32 q0, [r9, #-288]
	movw r9, #0xf2ff
	vmla.S16 q4, q6, r9
	movw r9, #5040
	vqrdmulh.S16 q6, q1, r9
mov r9,#0
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
umaal r9,r8,r1,r5
	vadd.U16 q4, q3, q4
umaal r9,r12,r2,r4
umaal r9,r10,r0,r6
adcs r9,r9,r9
umaal r9,r11,r3,r3
str r9,[sp,#24]
	movw r9, #0xf2ff
	vmla.S16 q7, q6, r9
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	vshl.i16 q3, q0, #9
	vldrw.U32 q1, [r9, #96]
	movw r9, #5040
	vqrdmulh.S16 q2, q0, r9
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	vldrw.U32 q0, [r9, #128]
	movw r9, #0xf2ff
	vmla.S16 q3, q2, r9
	movw r9, #:lower16:(expcg_buf+352)
	movt r9, #:upper16:(expcg_buf+352)
	vldrw.U32 q2, [r9, #144]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r9, #112]
umull r0,r9,r0,r7
umaal r0,r10,r1,r6
umaal r0,r12,r2,r5
umaal r0,r8,r3,r4
umaal r9,r8,r1,r7
	movw r1, #0xf2ff
	vmla.S16 q0, q5, r1
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r1
	movw r1, #:lower16:(expcg_buf+352)
	movt r1, #:upper16:(expcg_buf+352)
	vldrw.U32 q6, [r1, #80]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
umaal r9,r10,r2,r6
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r1, #64]
adcs r0,r0,r0
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r1, #-288]
	movw r1, #0xf2ff
umaal r12,r9,r3,r5
	vmla.S16 q2, q6, r1
	movw r1, #:lower16:(expcg_buf+352)
	movt r1, #:upper16:(expcg_buf+352)
	vstrw.U32 q2, [r1, #-240]
umaal r9,r8,r2,r7
	movw r2, #0xf2ff
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r1, #-192]
adcs r12,r12,r12
	vmla.S16 q1, q5, r2
	movw r2, #5040
	vadd.U16 q5, q7, q0
umaal r10,r9,r3,r6
	vqrdmulh.S16 q4, q3, r2
	vstrw.U32 q1, [r1, #-256]
movs r2,#0
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r1, #-272]
	movw r1, #0xf2ff
umaal r0,r11,lr,lr
	vmla.S16 q3, q4, r1
	movw r1, #:lower16:(expcg_buf+352)
	movt r1, #:upper16:(expcg_buf+352)
	vldrw.U32 q7, [r1, #-176]
umaal r10,r2,r4,r5
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r1, #-208]
umaal r2,r8,r3,r7
	movw r3, #5040
	vqrdmulh.S16 q6, q7, r3
	vldrw.U32 q0, [r1, #-224]
	movw r1, #0xf2ff
umaal r9,r2,r4,r6
	vmla.S16 q4, q6, r1
	vqrdmulh.S16 q6, q1, r3
adcs r10,r10,r10
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
umaal r11,r12,r4,r4
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r1
	movw r1, #:lower16:(expcg_buf+352)
	movt r1, #:upper16:(expcg_buf+352)
adcs r9,r9,r9
	vshl.i16 q3, q0, #9
	vldrw.U32 q1, [r1, #192]
umaal r12,r10,lr,lr
	vqrdmulh.S16 q2, q0, r3
	vldrw.U32 q0, [r1, #224]
	movw r1, #0xf2ff
movs r3,#0
	vmla.S16 q3, q2, r1
	movw r1, #:lower16:(expcg_buf+352)
	movt r1, #:upper16:(expcg_buf+352)
	vldrw.U32 q2, [r1, #240]
umaal r10,r9,r5,r5
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
umaal r3,r8,r4,r7
	movw r4, #0xf2ff
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r1, #208]
umaal r3,r2,r5,r6
	vmla.S16 q0, q5, r4
	vsub.U16 q5, q3, q7
umaal r8,r2,r5,r7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
umull r4,r5,lr,lr
	movw r5, #0xf2ff
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
adcs r3,r3,r3
	vmla.S16 q7, q2, r5
	vldrw.U32 q6, [r1, #176]
umaal r4,r2,r6,r7
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
adcs r8,r8,r8
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r1, #160]
umaal r9,r3,lr,lr
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r1, #-224]
umaal r3,r8,r6,r6
	vmla.S16 q2, q6, r5
	vstrw.U32 q2, [r1, #-176]
adcs r4,r4,r4
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r1, #-128]
	movw r6, #5040
umaal r4,r8,lr,lr
	vmla.S16 q1, q5, r5
	vadd.U16 q5, q7, q0
adcs r2,r2,r2
	vqrdmulh.S16 q4, q3, r6
	vstrw.U32 q1, [r1, #-192]
umaal r8,r2,r7,r7
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r1, #-208]
mov r6,#38
	vmla.S16 q3, q4, r5
	vldrw.U32 q7, [r1, #-112]
adcs r2,r2,lr
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r1, #-144]
umaal r0,lr,r6,r2
	movw r2, #5040
	vqrdmulh.S16 q6, q7, r2
	vldrw.U32 q0, [r1, #-160]
	movw r1, #0xf2ff
movs r5,#19
	vmla.S16 q4, q6, r1
	vqrdmulh.S16 q6, q1, r2
lsl lr,lr,#1
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
and r7,r0,#0x7fffffff
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r1
orr lr,lr,r0, lsr #31
	movw r0, #:lower16:(expcg_buf+352)
	movt r0, #:upper16:(expcg_buf+352)
	vshl.i16 q3, q0, #9
	vldrw.U32 q1, [r0, #288]
mul lr,lr,r5
	movw r5, #0xf2ff
	vqrdmulh.S16 q2, q0, r2
	movw r2, #:lower16:(expcg_buf+352)
	movt r2, #:upper16:(expcg_buf+352)
	vldrw.U32 q0, [r0, #320]
pop {r0,r1}
	vmla.S16 q3, q2, r5
	vldrw.U32 q2, [r2, #336]
umaal r0,lr,r6,r11
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
umaal r1,lr,r6,r12
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r2, #304]
mov r11,r3
	vmla.S16 q0, q5, r5
	vsub.U16 q5, q3, q7
mov r12,r4
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
pop {r2,r3,r4,r5}
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
umaal r2,lr,r6,r10
	movw r10, #0xf2ff
	vmla.S16 q7, q2, r10
	movw r10, #:lower16:(expcg_buf+352)
	movt r10, #:upper16:(expcg_buf+352)
	vldrw.U32 q6, [r10, #272]
umaal r3,lr,r6,r9
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
umaal r4,lr,r6,r11
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r10, #256]
	movw r11, #0xf2ff
umaal r5,lr,r6,r12
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r10, #-160]
pop {r6}
	vmla.S16 q2, q6, r11
	vstrw.U32 q2, [r10, #-112]
mov r12,#38
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r10, #-64]
umaal r6,lr,r12,r8
	movw r12, #5040
	vmla.S16 q1, q5, r11
	vadd.U16 q5, q7, q0
add r7,r7,lr
	vqrdmulh.S16 q4, q3, r12
	vstrw.U32 q1, [r10, #-128]
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r10, #-144]
pop {lr}
	vpop {d8-d15}
	bx lr
	.size expcg_d, .-expcg_d

	.type expcg_e, %function
	.global expcg_e
expcg_e:
	vpush {d8-d15}
	movw r12, #:lower16:expcg_qinit
	movt r12, #:upper16:expcg_qinit
	vldrw.U32 q0, [r12, #0]
	vldrw.U32 q1, [r12, #16]
	vldrw.U32 q2, [r12, #32]
	vldrw.U32 q3, [r12, #48]
	vldrw.U32 q4, [r12, #64]
	vldrw.U32 q5, [r12, #80]
	vldrw.U32 q6, [r12, #96]
	vldrw.U32 q7, [r12, #112]
	sub sp, sp, #16
	movw r12, #:lower16:(expcg_buf+352)
	movt r12, #:upper16:(expcg_buf+352)
	str r12, [sp, #0]
	movw r12, #0xf2ff
	str r12, [sp, #4]
	movw r12, #5040
	str r12, [sp, #8]
push {lr}
	ldr r8, [sp, #4]
	vldrw.U32 q7, [r8, #-320]
sub sp,#20
	vshl.i16 q3, q7, #9
	ldr r11, [sp, #32]
	vqrdmulh.S16 q4, q7, r11
umull r9,r10,r0,r0
	ldr r12, [sp, #28]
	vmla.S16 q3, q4, r12
	vldrw.U32 q7, [r8, #-304]
umull r11,r12,r0,r1
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r8, #-336]
adds r11,r11,r11
	ldr r8, [sp, #32]
	vqrdmulh.S16 q6, q7, r8
	ldr r8, [sp, #24]
	vldrw.U32 q0, [r8, #-352]
mov lr,#0
	ldr r8, [sp, #28]
	vmla.S16 q4, q6, r8
	ldr r8, [sp, #32]
	vqrdmulh.S16 q6, q1, r8
umaal r10,r11,lr,lr
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
push {r9,r10}
	vadd.U16 q4, q3, q4
	ldr r10, [sp, #36]
	vmla.S16 q7, q6, r10
mov r8,#0
	vshl.i16 q3, q0, #9
	ldr r9, [sp, #32]
	vldrw.U32 q1, [r9, #0]
umull r9,r10,r0,r3
umaal r8,r12,r0,r2
umaal r9,r12,r1,r2
adcs r8,r8,r8
umaal r8,r11,r1,r1
adcs r9,r9,r9
umaal r9,r11,lr,lr
strd r8,r9,[sp,#8]
	ldr r8, [sp, #40]
	vqrdmulh.S16 q2, q0, r8
	ldr r9, [sp, #32]
	vldrw.U32 q0, [r9, #32]
	ldr r8, [sp, #36]
	vmla.S16 q3, q2, r8
	vldrw.U32 q2, [r9, #48]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r9, #16]
	vmla.S16 q0, q5, r8
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r8
	vldrw.U32 q6, [r9, #-16]
mov r9,#0
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
umaal r9,r10,r0,r4
	vqrdmulh.S16 q6, q2, q6
	ldr r8, [sp, #32]
	vldrw.U32 q3, [r8, #-32]
umaal r9,r12,r1,r3
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r8, #-352]
adcs r9,r9,r9
	ldr r8, [sp, #36]
	vmla.S16 q2, q6, r8
	ldr r8, [sp, #32]
	vstrw.U32 q2, [r8, #-304]
umaal r9,r11,r2,r2
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r8, #-256]
str r9,[sp,#16]
	ldr r9, [sp, #36]
	vmla.S16 q1, q5, r9
	vadd.U16 q5, q7, q0
umull r9,r8,r0,r5
umaal r9,r10,r1,r4
umaal r9,r12,r2,r3
adcs r9,r9,r9
umaal r9,r11,lr,lr
str r9,[sp,#20]
	ldr r9, [sp, #40]
	vqrdmulh.S16 q4, q3, r9
	ldr r9, [sp, #32]
	vstrw.U32 q1, [r9, #-320]
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r9, #-336]
	ldr r9, [sp, #36]
	vmla.S16 q3, q4, r9
	ldr r9, [sp, #32]
	vldrw.U32 q7, [r9, #-240]
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r9, #-272]
	ldr r9, [sp, #40]
	vqrdmulh.S16 q6, q7, r9
	ldr r9, [sp, #32]
	vldrw.U32 q0, [r9, #-288]
	ldr r9, [sp, #36]
	vmla.S16 q4, q6, r9
	ldr r9, [sp, #40]
	vqrdmulh.S16 q6, q1, r9
mov r9,#0
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
umaal r9,r8,r1,r5
	vadd.U16 q4, q3, q4
umaal r9,r12,r2,r4
umaal r9,r10,r0,r6
adcs r9,r9,r9
umaal r9,r11,r3,r3
str r9,[sp,#24]
	ldr r9, [sp, #36]
	vmla.S16 q7, q6, r9
	vshl.i16 q3, q0, #9
	ldr r9, [sp, #32]
	vldrw.U32 q1, [r9, #96]
	ldr r9, [sp, #40]
	vqrdmulh.S16 q2, q0, r9
	ldr r9, [sp, #32]
	vldrw.U32 q0, [r9, #128]
	ldr r9, [sp, #36]
	vmla.S16 q3, q2, r9
	ldr r9, [sp, #32]
	vldrw.U32 q2, [r9, #144]
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r9, #112]
umull r0,r9,r0,r7
umaal r0,r10,r1,r6
umaal r0,r12,r2,r5
umaal r0,r8,r3,r4
umaal r9,r8,r1,r7
	ldr r1, [sp, #36]
	vmla.S16 q0, q5, r1
	vsub.U16 q5, q3, q7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
	vmla.S16 q7, q2, r1
	ldr r1, [sp, #32]
	vldrw.U32 q6, [r1, #80]
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
umaal r9,r10,r2,r6
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r1, #64]
adcs r0,r0,r0
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r1, #-288]
umaal r12,r9,r3,r5
	ldr r1, [sp, #36]
	vmla.S16 q2, q6, r1
	ldr r1, [sp, #32]
	vstrw.U32 q2, [r1, #-240]
umaal r9,r8,r2,r7
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r1, #-192]
adcs r12,r12,r12
	ldr r2, [sp, #36]
	vmla.S16 q1, q5, r2
	vadd.U16 q5, q7, q0
umaal r10,r9,r3,r6
	ldr r2, [sp, #40]
	vqrdmulh.S16 q4, q3, r2
	vstrw.U32 q1, [r1, #-256]
movs r2,#0
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r1, #-272]
umaal r0,r11,lr,lr
	ldr r1, [sp, #36]
	vmla.S16 q3, q4, r1
	ldr r1, [sp, #32]
	vldrw.U32 q7, [r1, #-176]
umaal r10,r2,r4,r5
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r1, #-208]
umaal r2,r8,r3,r7
	ldr r3, [sp, #40]
	vqrdmulh.S16 q6, q7, r3
	vldrw.U32 q0, [r1, #-224]
umaal r9,r2,r4,r6
	ldr r1, [sp, #36]
	vmla.S16 q4, q6, r1
	vqrdmulh.S16 q6, q1, r3
adcs r10,r10,r10
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
umaal r11,r12,r4,r4
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r1
adcs r9,r9,r9
	vshl.i16 q3, q0, #9
	ldr r1, [sp, #32]
	vldrw.U32 q1, [r1, #192]
umaal r12,r10,lr,lr
	vqrdmulh.S16 q2, q0, r3
	vldrw.U32 q0, [r1, #224]
movs r3,#0
	ldr r1, [sp, #36]
	vmla.S16 q3, q2, r1
	ldr r1, [sp, #32]
	vldrw.U32 q2, [r1, #240]
umaal r10,r9,r5,r5
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
umaal r3,r8,r4,r7
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r1, #208]
umaal r3,r2,r5,r6
	ldr r4, [sp, #36]
	vmla.S16 q0, q5, r4
	vsub.U16 q5, q3, q7
umaal r8,r2,r5,r7
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
umull r4,r5,lr,lr
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
adcs r3,r3,r3
	ldr r5, [sp, #36]
	vmla.S16 q7, q2, r5
	vldrw.U32 q6, [r1, #176]
umaal r4,r2,r6,r7
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
adcs r8,r8,r8
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r1, #160]
umaal r9,r3,lr,lr
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r1, #-224]
umaal r3,r8,r6,r6
	vmla.S16 q2, q6, r5
	vstrw.U32 q2, [r1, #-176]
adcs r4,r4,r4
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r1, #-128]
umaal r4,r8,lr,lr
	vmla.S16 q1, q5, r5
	vadd.U16 q5, q7, q0
adcs r2,r2,r2
	ldr r6, [sp, #40]
	vqrdmulh.S16 q4, q3, r6
	vstrw.U32 q1, [r1, #-192]
umaal r8,r2,r7,r7
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r1, #-208]
mov r6,#38
	vmla.S16 q3, q4, r5
	vldrw.U32 q7, [r1, #-112]
adcs r2,r2,lr
	vshl.i16 q4, q7, #9
	vldrw.U32 q1, [r1, #-144]
umaal r0,lr,r6,r2
	ldr r2, [sp, #40]
	vqrdmulh.S16 q6, q7, r2
	vldrw.U32 q0, [r1, #-160]
movs r5,#19
	ldr r1, [sp, #36]
	vmla.S16 q4, q6, r1
	vqrdmulh.S16 q6, q1, r2
lsl lr,lr,#1
	vsub.U16 q5, q3, q4
	vshl.i16 q7, q1, #9
and r7,r0,#0x7fffffff
	vadd.U16 q4, q3, q4
	vmla.S16 q7, q6, r1
orr lr,lr,r0, lsr #31
	vshl.i16 q3, q0, #9
	ldr r0, [sp, #32]
	vldrw.U32 q1, [r0, #288]
mul lr,lr,r5
	vqrdmulh.S16 q2, q0, r2
	vldrw.U32 q0, [r0, #320]
pop {r0,r1}
	ldr r5, [sp, #28]
	vmla.S16 q3, q2, r5
	ldr r2, [sp, #24]
	vldrw.U32 q2, [r2, #336]
umaal r0,lr,r6,r11
	vmul.S16 q0, q5, q0
	vadd.U16 q6, q3, q7
umaal r1,lr,r6,r12
	vqrdmulh.S16 q5, q5, q2
	vldrw.U32 q2, [r2, #304]
mov r11,r3
	vmla.S16 q0, q5, r5
	vsub.U16 q5, q3, q7
mov r12,r4
	vmul.S16 q7, q5, q1
	vsub.U16 q1, q6, q4
pop {r2,r3,r4,r5}
	vqrdmulh.S16 q2, q5, q2
	vadd.U16 q4, q6, q4
umaal r2,lr,r6,r10
	ldr r10, [sp, #12]
	vmla.S16 q7, q2, r10
	ldr r10, [sp, #8]
	vldrw.U32 q6, [r10, #272]
umaal r3,lr,r6,r9
	vqrdmulh.S16 q5, q1, q6
	vsub.U16 q2, q7, q0
umaal r4,lr,r6,r11
	vqrdmulh.S16 q6, q2, q6
	vldrw.U32 q3, [r10, #256]
umaal r5,lr,r6,r12
	vmul.S16 q2, q2, q3
	vstrw.U32 q4, [r10, #-160]
pop {r6}
	ldr r11, [sp, #8]
	vmla.S16 q2, q6, r11
	vstrw.U32 q2, [r10, #-112]
mov r12,#38
	vmul.S16 q1, q1, q3
	vldrw.U32 q3, [r10, #-64]
umaal r6,lr,r12,r8
	vmla.S16 q1, q5, r11
	vadd.U16 q5, q7, q0
add r7,r7,lr
	ldr r12, [sp, #12]
	vqrdmulh.S16 q4, q3, r12
	vstrw.U32 q1, [r10, #-128]
	vshl.i16 q3, q3, #9
	vstrw.U32 q5, [r10, #-144]
pop {lr}
	add sp, sp, #16
	vpop {d8-d15}
	bx lr
	.size expcg_e, .-expcg_e

	.type expcg_p_lenn, %function
	.global expcg_p_lenn
expcg_p_lenn:
	push {r4-r11, lr}
	sub sp, sp, #12
	str r0, [sp]
	mov r12, r1
	ldm r12, {r0-r7}
	bl expcg_p
	ldr r8, [sp]
	stm r8, {r0-r7}
	add sp, sp, #12
	pop {r4-r11, pc}
	.size expcg_p_lenn, .-expcg_p_lenn

	.type expcg_a_lenn, %function
	.global expcg_a_lenn
expcg_a_lenn:
	push {r4-r11, lr}
	sub sp, sp, #12
	str r0, [sp]
	mov r12, r1
	ldm r12, {r0-r7}
	bl expcg_a
	ldr r8, [sp]
	stm r8, {r0-r7}
	add sp, sp, #12
	pop {r4-r11, pc}
	.size expcg_a_lenn, .-expcg_a_lenn

	.type expcg_a0_lenn, %function
	.global expcg_a0_lenn
expcg_a0_lenn:
	push {r4-r11, lr}
	sub sp, sp, #12
	str r0, [sp]
	mov r12, r1
	ldm r12, {r0-r7}
	bl expcg_a0
	ldr r8, [sp]
	stm r8, {r0-r7}
	add sp, sp, #12
	pop {r4-r11, pc}
	.size expcg_a0_lenn, .-expcg_a0_lenn

	.type expcg_b_lenn, %function
	.global expcg_b_lenn
expcg_b_lenn:
	push {r4-r11, lr}
	sub sp, sp, #12
	str r0, [sp]
	mov r12, r1
	ldm r12, {r0-r7}
	bl expcg_b
	ldr r8, [sp]
	stm r8, {r0-r7}
	add sp, sp, #12
	pop {r4-r11, pc}
	.size expcg_b_lenn, .-expcg_b_lenn

	.type expcg_c_lenn, %function
	.global expcg_c_lenn
expcg_c_lenn:
	push {r4-r11, lr}
	sub sp, sp, #12
	str r0, [sp]
	mov r12, r1
	ldm r12, {r0-r7}
	bl expcg_c
	ldr r8, [sp]
	stm r8, {r0-r7}
	add sp, sp, #12
	pop {r4-r11, pc}
	.size expcg_c_lenn, .-expcg_c_lenn

	.type expcg_d_lenn, %function
	.global expcg_d_lenn
expcg_d_lenn:
	push {r4-r11, lr}
	sub sp, sp, #12
	str r0, [sp]
	mov r12, r1
	ldm r12, {r0-r7}
	bl expcg_d
	ldr r8, [sp]
	stm r8, {r0-r7}
	add sp, sp, #12
	pop {r4-r11, pc}
	.size expcg_d_lenn, .-expcg_d_lenn

	.type expcg_e_lenn, %function
	.global expcg_e_lenn
expcg_e_lenn:
	push {r4-r11, lr}
	sub sp, sp, #12
	str r0, [sp]
	mov r12, r1
	ldm r12, {r0-r7}
	bl expcg_e
	ldr r8, [sp]
	stm r8, {r0-r7}
	add sp, sp, #12
	pop {r4-r11, pc}
	.size expcg_e_lenn, .-expcg_e_lenn

