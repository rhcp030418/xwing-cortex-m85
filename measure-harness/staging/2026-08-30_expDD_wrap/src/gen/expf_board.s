.text
.syntax unified
.thumb

// coissue_slothy
.global coissue_slothy
.type coissue_slothy, %function
.thumb_func
.balign 16
coissue_slothy:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r14, r0
	mov r6, r1
	add r7, r1, #512
	add r9, r1, #1024
	add r10, r1, #1536
	add r11, r1, #2048
	movs r0, #0
	movs r1, #0
	movs r2, #3
	movs r3, #5
.balign 16
1:
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q6, [r6, #0]
	veor q5, q6, q0
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #160]
	umaal r0, r1, r2, r3
	veor q1, q5, q0
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #240]
	umaal r0, r1, r2, r3
	veor q4, q1, q0
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #320]
	umaal r0, r1, r2, r3
	veor q0, q4, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #0]
	vldrw.U32 q4, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #96]
	umaal r0, r1, r2, r3
	veor q4, q4, q0
	vldrw.U32 q0, [r6, #176]
	umaal r0, r1, r2, r3
	veor q4, q4, q0
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #256]
	umaal r0, r1, r2, r3
	veor q4, q4, q0
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #336]
	umaal r0, r1, r2, r3
	veor q0, q4, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #16]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #112]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #192]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #272]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #352]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #32]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #128]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #208]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #288]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #368]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #48]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #144]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #224]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #304]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #384]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #0]
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #64]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r7, #80]
	umaal r0, r1, r2, r3
	veor q2, q1, q0
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r7, #160]
	umaal r0, r1, r2, r3
	veor q6, q2, q0
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r7, #240]
	umaal r0, r1, r2, r3
	veor q3, q6, q0
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r7, #320]
	umaal r0, r1, r2, r3
	veor q0, q3, q0
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #16]
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #80]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r7, #96]
	umaal r0, r1, r2, r3
	veor q3, q1, q0
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r7, #176]
	umaal r0, r1, r2, r3
	veor q6, q3, q0
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r7, #256]
	umaal r0, r1, r2, r3
	veor q0, q6, q0
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #336]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #96]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r7, #32]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #112]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #192]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #272]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #352]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #112]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r7, #48]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #128]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #208]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #288]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #368]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #128]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r7, #64]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #144]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #224]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #304]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #384]
	umaal r0, r1, r2, r3
	veor q6, q0, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q6, [r11, #144]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r11, #96]
	umaal r0, r1, r2, r3
	vshl.I32 q2, q4, #1
	umaal r0, r1, r2, r3
	vldrw.U32 q7, [r11, #64]
	vsri.32 q2, q4, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r11, #16]
	veor q1, q2, q7
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r11, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #144]
	umaal r0, r1, r2, r3
	veor q4, q3, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q4, [r11, #240]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #112]
	umaal r0, r1, r2, r3
	vshl.I32 q6, q2, #1
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r11, #0]
	vsri.32 q6, q2, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r11, #32]
	veor q1, q6, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r11, #176]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #80]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #256]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r11, #128]
	umaal r0, r1, r2, r3
	vshl.I32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #16]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r11, #192]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r11, #48]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #96]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #272]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r11, #144]
	umaal r0, r1, r2, r3
	vshl.I32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #32]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r11, #208]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r11, #64]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #112]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #288]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r11, #80]
	umaal r0, r1, r2, r3
	vshl.I32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #48]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r11, #224]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r11, #128]
	umaal r0, r1, r2, r3
	veor q6, q2, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q6, [r11, #304]
	vldrw.U32 q6, [r11, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r6, #0]
	umaal r0, r1, r2, r3
	veor q2, q4, q6
	vldrw.U32 q7, [r11, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vorr.U32 q2, q2, q2
	vldrw.U32 q1, [r7, #0]
	umaal r0, r1, r2, r3
	veor q3, q1, q7
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #0]
	umaal r0, r1, r2, r3
	vorr.U32 q3, q3, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #0]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #80]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	vldrw.U32 q5, [r7, #80]
	umaal r0, r1, r2, r3
	veor q1, q5, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #18
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #14
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #256]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q1, #18
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #14
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #256]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #160]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #2
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #30
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #112]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #31
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #112]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #240]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #21
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #11
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #368]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #20
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #12
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #368]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #320]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #9
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q6, [r11, #176]
	vshl.I32 q0, q1, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q7, [r11, #256]
	vsri.32 q0, q1, #23
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #96]
	vstrw.U32 q0, [r10, #224]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	vstrw.U32 q2, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vorr.U32 q0, q0, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r10, #160]
	vldrw.U32 q0, [r7, #16]
	umaal r0, r1, r2, r3
	veor q5, q0, q7
	umaal r0, r1, r2, r3
	vshl.I32 q3, q5, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r6, #96]
	vsri.32 q3, q5, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q0, q4, q6
	vstrw.U32 q3, [r9, #160]
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #22
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #10
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #16]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q1, #22
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #10
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #16]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #176]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #5
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #27
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #272]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q1, #5
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #27
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #272]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #256]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #23
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #9
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #128]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #22
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #10
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #128]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #336]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q3, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q6, [r11, #192]
	vsri.32 q2, q0, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q7, [r11, #272]
	vstrw.U32 q2, [r9, #384]
	vshl.I32 q2, q3, #1
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #32]
	vsri.32 q2, q3, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r7, #32]
	vstrw.U32 q2, [r10, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q1, q0, q6
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #31
	umaal r0, r1, r2, r3
	veor q5, q4, q7
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.I32 q1, q5, #31
	vstrw.U32 q2, [r9, #320]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #1
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r10, #320]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #112]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #3
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #29
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #176]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q1, #3
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #29
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #176]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #192]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #22
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #10
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #32]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #21
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #11
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #32]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #272]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #8
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #24
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #288]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #7
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #25
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #288]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q0, q2, q6
	vldrw.U32 q4, [r7, #352]
	umaal r0, r1, r2, r3
	veor q3, q4, q7
	umaal r0, r1, r2, r3
	vshl.I32 q5, q3, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q6, [r11, #208]
	vsri.32 q5, q3, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q7, [r11, #288]
	vstrw.U32 q5, [r9, #144]
	umaal r0, r1, r2, r3
	vshl.I32 q5, q0, #30
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r6, #48]
	vsri.32 q5, q0, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r7, #48]
	umaal r0, r1, r2, r3
	veor q0, q2, q6
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #14
	vstrw.U32 q5, [r10, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #18
	veor q1, q3, q7
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #80]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q1, #14
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #18
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #80]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #128]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #28
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #4
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #336]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #27
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #5
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #336]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #208]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #13
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #19
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #192]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #12
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #20
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #192]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #288]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #11
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #21
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #48]
	umaal r0, r1, r2, r3
	vshl.I32 q1, q0, #10
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r6, #368]
	vsri.32 q1, q0, #22
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r7, #368]
	vstrw.U32 q1, [r10, #48]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q5, q3, q6
	umaal r0, r1, r2, r3
	veor q3, q0, q7
	umaal r0, r1, r2, r3
	vshl.I32 q0, q5, #28
	umaal r0, r1, r2, r3
	vldrw.U32 q6, [r11, #224]
	vsri.32 q0, q5, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q7, [r11, #304]
	vstrw.U32 q0, [r9, #304]
	umaal r0, r1, r2, r3
	vshl.I32 q2, q3, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #64]
	vsri.32 q2, q3, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q5, [r7, #64]
	vstrw.U32 q2, [r10, #304]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q0, q1, q6
	umaal r0, r1, r2, r3
	veor q1, q5, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #14
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #18
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #240]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #13
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #19
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #240]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #144]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #10
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #22
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #96]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q1, #10
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #22
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #96]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #224]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #20
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #12
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #352]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #19
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #13
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #352]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #304]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #4
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r6, #384]
	vsri.32 q2, q0, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r7, #384]
	vstrw.U32 q2, [r9, #208]
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q5, q3, q6
	vsri.32 q2, q1, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q4, q4, q7
	vstrw.U32 q2, [r10, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vshl.I32 q2, q5, #7
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r9, #0]
	vsri.32 q2, q5, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r9, #16]
	vshl.I32 q5, q4, #7
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #64]
	umaal r0, r1, r2, r3
	vsri.32 q5, q4, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r9, #32]
	vstrw.U32 q5, [r10, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r9, #64]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #0]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #16]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #32]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #48]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r9, #96]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r9, #128]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r9, #144]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #80]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #96]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #112]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #128]
	umaal r0, r1, r2, r3
	vbic q3, q1, q0
	umaal r0, r1, r2, r3
	veor q2, q3, q4
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r9, #176]
	vstrw.U32 q2, [r6, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r9, #192]
	umaal r0, r1, r2, r3
	vbic q3, q2, q1
	vldrw.U32 q0, [r9, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q5, q3, q0
	vldrw.U32 q3, [r9, #208]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #160]
	vldrw.U32 q4, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #176]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #192]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #208]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r9, #240]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r9, #256]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r9, #272]
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r9, #288]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r9, #304]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #240]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #256]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #272]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #288]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r9, #320]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r9, #336]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r9, #352]
	umaal r0, r1, r2, r3
	vbic q3, q2, q1
	vldrw.U32 q5, [r9, #368]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q3, q3, q0
	vldrw.U32 q4, [r9, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r6, #320]
	umaal r0, r1, r2, r3
	vbic q3, q5, q2
	umaal r0, r1, r2, r3
	veor q3, q3, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r6, #336]
	umaal r0, r1, r2, r3
	vbic q3, q4, q5
	umaal r0, r1, r2, r3
	veor q2, q3, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r6, #352]
	umaal r0, r1, r2, r3
	vbic q3, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q3, q5
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #368]
	umaal r0, r1, r2, r3
	vbic q0, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q0, q4
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r10, #0]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r10, #16]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r10, #32]
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r10, #48]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r10, #64]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #0]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #16]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #32]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #48]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #64]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r10, #80]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r10, #96]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r10, #112]
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r10, #128]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r10, #144]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #80]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #96]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q2, q5, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r7, #112]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q3, q5, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r7, #128]
	umaal r0, r1, r2, r3
	vbic q2, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q2, q4
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r10, #176]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r10, #192]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	vldrw.U32 q0, [r10, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q4, q5, q0
	vldrw.U32 q3, [r10, #208]
	umaal r0, r1, r2, r3
	vstrw.U32 q4, [r7, #160]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r10, #224]
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #176]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #192]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #208]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #224]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r10, #240]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r10, #256]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r10, #272]
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r10, #288]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r10, #304]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #240]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #256]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #272]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #288]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r10, #320]
	vstrw.U32 q5, [r7, #304]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r10, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	vldrw.U32 q2, [r10, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vbic q4, q2, q1
	vldrw.U32 q3, [r10, #368]
	umaal r0, r1, r2, r3
	veor q4, q4, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q4, [r7, #320]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r10, #384]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vbic q0, q0, q4
	umaal r0, r1, r2, r3
	veor q0, q0, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r7, #368]
	vbic q0, q3, q2
	umaal r0, r1, r2, r3
	veor q1, q0, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r7, #336]
	umaal r0, r1, r2, r3
	vbic q0, q4, q3
	umaal r0, r1, r2, r3
	veor q1, q0, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r7, #352]
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #384]
	umaal r0, r1, r2, r3
	vmov.I32 q0, #1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #0]
	umaal r0, r1, r2, r3
	veor q1, q1, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r6, #0]
	subs r14, r14, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// coissue_slothy2
.global coissue_slothy2
.type coissue_slothy2, %function
.thumb_func
.balign 16
coissue_slothy2:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r14, r0
	mov r6, r1
	add r7, r1, #512
	add r9, r1, #1024
	add r10, r1, #1536
	add r11, r1, #2048
	movs r0, #0
	movs r1, #0
	movs r2, #3
	movs r3, #5
.balign 16
1:
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.U32 q5, [r6, #80]
	umaal r0, r1, r2, r3
	veor q4, q0, q5
	umaal r0, r1, r2, r3
	vldrw.U32 q5, [r6, #160]
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	vldrw.U32 q5, [r6, #240]
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	vldrw.U32 q5, [r6, #320]
	umaal r0, r1, r2, r3
	veor q6, q4, q5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r6, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q5, [r6, #96]
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	vldrw.U32 q5, [r6, #176]
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	vldrw.U32 q5, [r6, #256]
	umaal r0, r1, r2, r3
	veor q4, q4, q5
	umaal r0, r1, r2, r3
	vldrw.U32 q5, [r6, #336]
	vstrw.U32 q6, [r11, #0]
	veor q0, q4, q5
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #16]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #112]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #192]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #272]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #352]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #32]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #128]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #208]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #288]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #368]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #48]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #144]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #224]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #304]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #384]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #0]
	vstrw.U32 q0, [r11, #64]
	vldrw.U32 q4, [r7, #80]
	umaal r0, r1, r2, r3
	veor q6, q1, q4
	umaal r0, r1, r2, r3
	vldrw.U32 q5, [r7, #160]
	umaal r0, r1, r2, r3
	veor q4, q6, q5
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r7, #240]
	umaal r0, r1, r2, r3
	veor q6, q4, q0
	umaal r0, r1, r2, r3
	vldrw.U32 q7, [r7, #320]
	umaal r0, r1, r2, r3
	veor q2, q6, q7
	umaal r0, r1, r2, r3
	vldrw.U32 q6, [r7, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #96]
	umaal r0, r1, r2, r3
	veor q1, q6, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q6, [r7, #176]
	umaal r0, r1, r2, r3
	veor q1, q1, q6
	umaal r0, r1, r2, r3
	vldrw.U32 q5, [r7, #256]
	umaal r0, r1, r2, r3
	veor q0, q1, q5
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #336]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r11, #80]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #96]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r7, #32]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #112]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #192]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #272]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #352]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #112]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r7, #48]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #128]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #208]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #288]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #368]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #128]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r7, #64]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #144]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #224]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #304]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #384]
	umaal r0, r1, r2, r3
	veor q5, q0, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #96]
	vstrw.U32 q5, [r11, #144]
	vshl.I32 q1, q2, #1
	vldrw.U32 q0, [r11, #112]
	umaal r0, r1, r2, r3
	vsri.32 q1, q2, #31
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r11, #64]
	umaal r0, r1, r2, r3
	vshl.I32 q5, q0, #1
	umaal r0, r1, r2, r3
	vldrw.U32 q7, [r11, #144]
	vsri.32 q5, q0, #31
	umaal r0, r1, r2, r3
	veor q3, q1, q4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r11, #16]
	veor q6, q4, q7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q7, [r11, #0]
	veor q2, q5, q7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r11, #32]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r11, #160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q6, [r11, #240]
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r11, #176]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #80]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #256]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r11, #128]
	umaal r0, r1, r2, r3
	vshl.I32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #16]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r11, #192]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r11, #48]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #96]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #272]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r11, #144]
	umaal r0, r1, r2, r3
	vshl.I32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #32]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r11, #208]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r11, #64]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #112]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r11, #288]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r11, #80]
	umaal r0, r1, r2, r3
	vshl.I32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r11, #48]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r11, #224]
	umaal r0, r1, r2, r3
	vldrw.U32 q7, [r11, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r11, #128]
	umaal r0, r1, r2, r3
	veor q3, q7, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r11, #304]
	vldrw.U32 q6, [r11, #160]
	umaal r0, r1, r2, r3
	vldrw.U32 q7, [r11, #240]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r6, #0]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q4, q4, q6
	vldrw.U32 q1, [r7, #0]
	umaal r0, r1, r2, r3
	veor q5, q1, q7
	umaal r0, r1, r2, r3
	vorr.U32 q3, q4, q4
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r9, #0]
	vorr.U32 q4, q5, q5
	vldrw.U32 q5, [r6, #80]
	umaal r0, r1, r2, r3
	veor q0, q5, q6
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r7, #80]
	umaal r0, r1, r2, r3
	veor q1, q2, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q4, [r10, #0]
	vsri.32 q2, q0, #14
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #256]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q1, #18
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #14
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #256]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #160]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #2
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #30
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #112]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #31
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #112]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #240]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #21
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #11
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #368]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #20
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #12
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #368]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #320]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #9
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #23
	vldrw.U32 q7, [r11, #256]
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #224]
	vshl.I32 q5, q1, #9
	vldrw.U32 q6, [r7, #16]
	vsri.32 q5, q1, #23
	umaal r0, r1, r2, r3
	veor q4, q6, q7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r6, #16]
	umaal r0, r1, r2, r3
	vshl.I32 q2, q4, #1
	vstrw.U32 q5, [r10, #224]
	vldrw.U32 q6, [r11, #176]
	veor q3, q3, q6
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #96]
	vsri.32 q2, q4, #31
	umaal r0, r1, r2, r3
	vorr.U32 q4, q3, q3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #96]
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #160]
	umaal r0, r1, r2, r3
	vstrw.U32 q4, [r10, #160]
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #22
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #10
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #16]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q1, #22
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #10
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #16]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #176]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #5
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #27
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #272]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q1, #5
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #27
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #272]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #256]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #23
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #9
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #128]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #22
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #10
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #128]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #336]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q3, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q7, q0, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q6, [r11, #192]
	vsri.32 q7, q0, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q7, [r9, #384]
	vshl.I32 q7, q3, #1
	vsri.32 q7, q3, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r6, #32]
	vstrw.U32 q7, [r10, #384]
	veor q7, q3, q6
	vshl.I32 q3, q7, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q3, q7, #1
	vldrw.U32 q7, [r11, #272]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r9, #320]
	vldrw.U32 q3, [r7, #32]
	veor q3, q3, q7
	umaal r0, r1, r2, r3
	vshl.I32 q1, q3, #31
	umaal r0, r1, r2, r3
	vsri.32 q1, q3, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r10, #320]
	vldrw.U32 q0, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #112]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #3
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #29
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #176]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q1, #3
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #29
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #176]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #192]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #22
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #10
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #32]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #21
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #11
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #32]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #272]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #8
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #24
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #288]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #7
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #25
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #288]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q5, q1, q6
	vldrw.U32 q4, [r7, #352]
	umaal r0, r1, r2, r3
	veor q7, q4, q7
	umaal r0, r1, r2, r3
	vshl.I32 q4, q7, #31
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q6, [r11, #208]
	vsri.32 q4, q7, #1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q7, [r11, #288]
	vstrw.U32 q4, [r9, #144]
	vshl.I32 q1, q5, #30
	vldrw.U32 q3, [r6, #48]
	vsri.32 q1, q5, #2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r7, #48]
	vstrw.U32 q1, [r10, #144]
	veor q0, q3, q6
	veor q1, q4, q7
	umaal r0, r1, r2, r3
	vshl.I32 q5, q0, #14
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q5, q0, #18
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r9, #80]
	vshl.I32 q3, q1, #14
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #18
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #80]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #128]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #28
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #4
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #336]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #27
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #5
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #336]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #208]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #13
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #19
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #192]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #12
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #20
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #192]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #288]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #11
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #21
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #48]
	umaal r0, r1, r2, r3
	vshl.I32 q1, q0, #10
	umaal r0, r1, r2, r3
	vldrw.U32 q5, [r6, #368]
	vsri.32 q1, q0, #22
	umaal r0, r1, r2, r3
	veor q5, q5, q6
	umaal r0, r1, r2, r3
	vshl.I32 q6, q5, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q6, q5, #4
	vldrw.U32 q5, [r6, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q6, [r9, #304]
	vldrw.U32 q6, [r11, #224]
	veor q0, q5, q6
	vldrw.U32 q5, [r7, #368]
	umaal r0, r1, r2, r3
	veor q5, q5, q7
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r10, #48]
	vshl.I32 q1, q5, #28
	vldrw.U32 q7, [r11, #304]
	umaal r0, r1, r2, r3
	vsri.32 q1, q5, #4
	vldrw.U32 q5, [r7, #64]
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r10, #304]
	veor q1, q5, q7
	vshl.I32 q2, q1, #14
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #18
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #240]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #13
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #19
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #240]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #144]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #10
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #22
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #96]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q1, #10
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #22
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #96]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #224]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q1, #20
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #12
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r9, #352]
	umaal r0, r1, r2, r3
	vshl.I32 q3, q0, #19
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #13
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #352]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r7, #304]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.I32 q2, q0, #4
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r6, #384]
	vsri.32 q2, q0, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q0, q3, q6
	vstrw.U32 q2, [r9, #208]
	vldrw.U32 q3, [r7, #384]
	veor q5, q3, q7
	vshl.I32 q3, q0, #7
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r9, #32]
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #25
	umaal r0, r1, r2, r3
	vshl.I32 q0, q1, #4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsri.32 q0, q1, #28
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r9, #16]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r9, #64]
	vshl.I32 q3, q5, #7
	umaal r0, r1, r2, r3
	vsri.32 q3, q5, #25
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r10, #64]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r10, #208]
	vldrw.U32 q0, [r9, #0]
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r9, #64]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #0]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #16]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #32]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #48]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r9, #96]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r9, #128]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r9, #144]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #80]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #96]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vbic q2, q0, q4
	vstrw.U32 q5, [r6, #112]
	veor q5, q2, q3
	vbic q1, q1, q0
	vldrw.U32 q0, [r9, #160]
	umaal r0, r1, r2, r3
	veor q4, q1, q4
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r9, #176]
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #128]
	vldrw.U32 q2, [r9, #192]
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r9, #208]
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q4, [r6, #144]
	vldrw.U32 q4, [r9, #224]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #160]
	vbic q5, q3, q2
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #176]
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #192]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #208]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r9, #240]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r9, #256]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r9, #272]
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r9, #288]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r9, #304]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #240]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #256]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #272]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #288]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r9, #320]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r9, #336]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r9, #368]
	umaal r0, r1, r2, r3
	vldrw.U32 q5, [r9, #352]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vbic q3, q5, q1
	umaal r0, r1, r2, r3
	veor q3, q3, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r6, #320]
	vbic q3, q4, q5
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	veor q3, q3, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r6, #336]
	vbic q3, q1, q0
	vldrw.U32 q1, [r9, #384]
	umaal r0, r1, r2, r3
	veor q3, q3, q1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r6, #384]
	vbic q3, q0, q1
	vldrw.U32 q0, [r10, #0]
	veor q3, q3, q4
	vbic q1, q1, q4
	umaal r0, r1, r2, r3
	veor q1, q1, q5
	vstrw.U32 q3, [r6, #368]
	vstrw.U32 q1, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r10, #16]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r10, #32]
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r10, #48]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r10, #64]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #0]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #16]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #32]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #48]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #64]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r10, #80]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r10, #96]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r10, #112]
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r10, #128]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r10, #144]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #80]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #96]
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q2, q5, q2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q2, [r7, #112]
	vbic q2, q0, q4
	umaal r0, r1, r2, r3
	veor q3, q2, q3
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r10, #192]
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r7, #128]
	vbic q3, q1, q0
	vldrw.U32 q0, [r10, #160]
	umaal r0, r1, r2, r3
	veor q3, q3, q4
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r10, #176]
	umaal r0, r1, r2, r3
	vstrw.U32 q3, [r7, #144]
	vbic q3, q2, q1
	umaal r0, r1, r2, r3
	veor q4, q3, q0
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r10, #208]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	vstrw.U32 q4, [r7, #160]
	vldrw.U32 q4, [r10, #224]
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #176]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #192]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #208]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #224]
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r10, #240]
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r10, #256]
	umaal r0, r1, r2, r3
	vldrw.U32 q2, [r10, #272]
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r10, #288]
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r10, #304]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #240]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #256]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #272]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #288]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.U32 q0, [r10, #336]
	vstrw.U32 q5, [r7, #304]
	vldrw.U32 q2, [r10, #352]
	umaal r0, r1, r2, r3
	vbic q4, q2, q0
	umaal r0, r1, r2, r3
	vldrw.U32 q3, [r10, #368]
	umaal r0, r1, r2, r3
	vbic q1, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q1, q0
	vstrw.U32 q5, [r7, #336]
	vldrw.U32 q1, [r10, #320]
	vbic q5, q0, q1
	veor q0, q4, q1
	umaal r0, r1, r2, r3
	vldrw.U32 q4, [r10, #384]
	vbic q1, q1, q4
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q0, [r7, #320]
	vbic q0, q4, q3
	veor q1, q1, q3
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r7, #368]
	vstrw.U32 q0, [r7, #352]
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.U32 q5, [r7, #384]
	umaal r0, r1, r2, r3
	vmov.I32 q0, #1
	umaal r0, r1, r2, r3
	vldrw.U32 q1, [r6, #0]
	umaal r0, r1, r2, r3
	veor q1, q1, q0
	umaal r0, r1, r2, r3
	vstrw.U32 q1, [r6, #0]
	subs r14, r14, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

