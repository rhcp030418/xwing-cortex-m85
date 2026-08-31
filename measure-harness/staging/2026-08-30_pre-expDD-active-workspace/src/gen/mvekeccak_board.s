.text
.syntax unified
.thumb

// 플랜 B: 4-way MVE Keccak + 코이슈 실험 (mve_keccak.py v0.2 생성)
// keccak4_round_mve
.global keccak4_round_mve
.type keccak4_round_mve, %function
.thumb_func
.balign 16
keccak4_round_mve:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r6, r0
	add r2, r1, #512
	add r3, r1, #1024
	add r4, r1, #1536
	add r5, r1, #2048
.balign 16
1:
	vldrw.u32 q0, [r1, #0]
	vldrw.u32 q1, [r1, #80]
	veor q0, q0, q1
	vldrw.u32 q1, [r1, #160]
	veor q0, q0, q1
	vldrw.u32 q1, [r1, #240]
	veor q0, q0, q1
	vldrw.u32 q1, [r1, #320]
	veor q0, q0, q1
	vstrw.u32 q0, [r5, #0]
	vldrw.u32 q0, [r1, #16]
	vldrw.u32 q1, [r1, #96]
	veor q0, q0, q1
	vldrw.u32 q1, [r1, #176]
	veor q0, q0, q1
	vldrw.u32 q1, [r1, #256]
	veor q0, q0, q1
	vldrw.u32 q1, [r1, #336]
	veor q0, q0, q1
	vstrw.u32 q0, [r5, #16]
	vldrw.u32 q0, [r1, #32]
	vldrw.u32 q1, [r1, #112]
	veor q0, q0, q1
	vldrw.u32 q1, [r1, #192]
	veor q0, q0, q1
	vldrw.u32 q1, [r1, #272]
	veor q0, q0, q1
	vldrw.u32 q1, [r1, #352]
	veor q0, q0, q1
	vstrw.u32 q0, [r5, #32]
	vldrw.u32 q0, [r1, #48]
	vldrw.u32 q1, [r1, #128]
	veor q0, q0, q1
	vldrw.u32 q1, [r1, #208]
	veor q0, q0, q1
	vldrw.u32 q1, [r1, #288]
	veor q0, q0, q1
	vldrw.u32 q1, [r1, #368]
	veor q0, q0, q1
	vstrw.u32 q0, [r5, #48]
	vldrw.u32 q0, [r1, #64]
	vldrw.u32 q1, [r1, #144]
	veor q0, q0, q1
	vldrw.u32 q1, [r1, #224]
	veor q0, q0, q1
	vldrw.u32 q1, [r1, #304]
	veor q0, q0, q1
	vldrw.u32 q1, [r1, #384]
	veor q0, q0, q1
	vstrw.u32 q0, [r5, #64]
	vldrw.u32 q0, [r2, #0]
	vldrw.u32 q1, [r2, #80]
	veor q0, q0, q1
	vldrw.u32 q1, [r2, #160]
	veor q0, q0, q1
	vldrw.u32 q1, [r2, #240]
	veor q0, q0, q1
	vldrw.u32 q1, [r2, #320]
	veor q0, q0, q1
	vstrw.u32 q0, [r5, #80]
	vldrw.u32 q0, [r2, #16]
	vldrw.u32 q1, [r2, #96]
	veor q0, q0, q1
	vldrw.u32 q1, [r2, #176]
	veor q0, q0, q1
	vldrw.u32 q1, [r2, #256]
	veor q0, q0, q1
	vldrw.u32 q1, [r2, #336]
	veor q0, q0, q1
	vstrw.u32 q0, [r5, #96]
	vldrw.u32 q0, [r2, #32]
	vldrw.u32 q1, [r2, #112]
	veor q0, q0, q1
	vldrw.u32 q1, [r2, #192]
	veor q0, q0, q1
	vldrw.u32 q1, [r2, #272]
	veor q0, q0, q1
	vldrw.u32 q1, [r2, #352]
	veor q0, q0, q1
	vstrw.u32 q0, [r5, #112]
	vldrw.u32 q0, [r2, #48]
	vldrw.u32 q1, [r2, #128]
	veor q0, q0, q1
	vldrw.u32 q1, [r2, #208]
	veor q0, q0, q1
	vldrw.u32 q1, [r2, #288]
	veor q0, q0, q1
	vldrw.u32 q1, [r2, #368]
	veor q0, q0, q1
	vstrw.u32 q0, [r5, #128]
	vldrw.u32 q0, [r2, #64]
	vldrw.u32 q1, [r2, #144]
	veor q0, q0, q1
	vldrw.u32 q1, [r2, #224]
	veor q0, q0, q1
	vldrw.u32 q1, [r2, #304]
	veor q0, q0, q1
	vldrw.u32 q1, [r2, #384]
	veor q0, q0, q1
	vstrw.u32 q0, [r5, #144]
	vldrw.u32 q0, [r5, #96]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r5, #64]
	veor q1, q1, q2
	vstrw.u32 q1, [r5, #160]
	vldrw.u32 q0, [r5, #16]
	vldrw.u32 q2, [r5, #144]
	veor q0, q0, q2
	vstrw.u32 q0, [r5, #240]
	vldrw.u32 q0, [r5, #112]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r5, #0]
	veor q1, q1, q2
	vstrw.u32 q1, [r5, #176]
	vldrw.u32 q0, [r5, #32]
	vldrw.u32 q2, [r5, #80]
	veor q0, q0, q2
	vstrw.u32 q0, [r5, #256]
	vldrw.u32 q0, [r5, #128]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r5, #16]
	veor q1, q1, q2
	vstrw.u32 q1, [r5, #192]
	vldrw.u32 q0, [r5, #48]
	vldrw.u32 q2, [r5, #96]
	veor q0, q0, q2
	vstrw.u32 q0, [r5, #272]
	vldrw.u32 q0, [r5, #144]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r5, #32]
	veor q1, q1, q2
	vstrw.u32 q1, [r5, #208]
	vldrw.u32 q0, [r5, #64]
	vldrw.u32 q2, [r5, #112]
	veor q0, q0, q2
	vstrw.u32 q0, [r5, #288]
	vldrw.u32 q0, [r5, #80]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r5, #48]
	veor q1, q1, q2
	vstrw.u32 q1, [r5, #224]
	vldrw.u32 q0, [r5, #0]
	vldrw.u32 q2, [r5, #128]
	veor q0, q0, q2
	vstrw.u32 q0, [r5, #304]
	vldrw.u32 q6, [r5, #160]
	vldrw.u32 q7, [r5, #240]
	vldrw.u32 q0, [r1, #0]
	vldrw.u32 q1, [r2, #0]
	veor q0, q0, q6
	veor q1, q1, q7
	vorr q2, q0, q0
	vstrw.u32 q2, [r3, #0]
	vorr q3, q1, q1
	vstrw.u32 q3, [r4, #0]
	vldrw.u32 q0, [r1, #80]
	vldrw.u32 q1, [r2, #80]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #18
	vsri.32 q2, q0, #14
	vstrw.u32 q2, [r3, #256]
	vshl.i32 q3, q1, #18
	vsri.32 q3, q1, #14
	vstrw.u32 q3, [r4, #256]
	vldrw.u32 q0, [r1, #160]
	vldrw.u32 q1, [r2, #160]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #2
	vsri.32 q2, q1, #30
	vstrw.u32 q2, [r3, #112]
	vshl.i32 q3, q0, #1
	vsri.32 q3, q0, #31
	vstrw.u32 q3, [r4, #112]
	vldrw.u32 q0, [r1, #240]
	vldrw.u32 q1, [r2, #240]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #21
	vsri.32 q2, q1, #11
	vstrw.u32 q2, [r3, #368]
	vshl.i32 q3, q0, #20
	vsri.32 q3, q0, #12
	vstrw.u32 q3, [r4, #368]
	vldrw.u32 q0, [r1, #320]
	vldrw.u32 q1, [r2, #320]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #9
	vsri.32 q2, q0, #23
	vstrw.u32 q2, [r3, #224]
	vshl.i32 q3, q1, #9
	vsri.32 q3, q1, #23
	vstrw.u32 q3, [r4, #224]
	vldrw.u32 q6, [r5, #176]
	vldrw.u32 q7, [r5, #256]
	vldrw.u32 q0, [r1, #16]
	vldrw.u32 q1, [r2, #16]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #1
	vsri.32 q2, q1, #31
	vstrw.u32 q2, [r3, #160]
	vorr q3, q0, q0
	vstrw.u32 q3, [r4, #160]
	vldrw.u32 q0, [r1, #96]
	vldrw.u32 q1, [r2, #96]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #22
	vsri.32 q2, q0, #10
	vstrw.u32 q2, [r3, #16]
	vshl.i32 q3, q1, #22
	vsri.32 q3, q1, #10
	vstrw.u32 q3, [r4, #16]
	vldrw.u32 q0, [r1, #176]
	vldrw.u32 q1, [r2, #176]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #5
	vsri.32 q2, q0, #27
	vstrw.u32 q2, [r3, #272]
	vshl.i32 q3, q1, #5
	vsri.32 q3, q1, #27
	vstrw.u32 q3, [r4, #272]
	vldrw.u32 q0, [r1, #256]
	vldrw.u32 q1, [r2, #256]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #23
	vsri.32 q2, q1, #9
	vstrw.u32 q2, [r3, #128]
	vshl.i32 q3, q0, #22
	vsri.32 q3, q0, #10
	vstrw.u32 q3, [r4, #128]
	vldrw.u32 q0, [r1, #336]
	vldrw.u32 q1, [r2, #336]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #1
	vsri.32 q2, q0, #31
	vstrw.u32 q2, [r3, #384]
	vshl.i32 q3, q1, #1
	vsri.32 q3, q1, #31
	vstrw.u32 q3, [r4, #384]
	vldrw.u32 q6, [r5, #192]
	vldrw.u32 q7, [r5, #272]
	vldrw.u32 q0, [r1, #32]
	vldrw.u32 q1, [r2, #32]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #31
	vsri.32 q2, q0, #1
	vstrw.u32 q2, [r3, #320]
	vshl.i32 q3, q1, #31
	vsri.32 q3, q1, #1
	vstrw.u32 q3, [r4, #320]
	vldrw.u32 q0, [r1, #112]
	vldrw.u32 q1, [r2, #112]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #3
	vsri.32 q2, q0, #29
	vstrw.u32 q2, [r3, #176]
	vshl.i32 q3, q1, #3
	vsri.32 q3, q1, #29
	vstrw.u32 q3, [r4, #176]
	vldrw.u32 q0, [r1, #192]
	vldrw.u32 q1, [r2, #192]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #22
	vsri.32 q2, q1, #10
	vstrw.u32 q2, [r3, #32]
	vshl.i32 q3, q0, #21
	vsri.32 q3, q0, #11
	vstrw.u32 q3, [r4, #32]
	vldrw.u32 q0, [r1, #272]
	vldrw.u32 q1, [r2, #272]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #8
	vsri.32 q2, q1, #24
	vstrw.u32 q2, [r3, #288]
	vshl.i32 q3, q0, #7
	vsri.32 q3, q0, #25
	vstrw.u32 q3, [r4, #288]
	vldrw.u32 q0, [r1, #352]
	vldrw.u32 q1, [r2, #352]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #31
	vsri.32 q2, q1, #1
	vstrw.u32 q2, [r3, #144]
	vshl.i32 q3, q0, #30
	vsri.32 q3, q0, #2
	vstrw.u32 q3, [r4, #144]
	vldrw.u32 q6, [r5, #208]
	vldrw.u32 q7, [r5, #288]
	vldrw.u32 q0, [r1, #48]
	vldrw.u32 q1, [r2, #48]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #14
	vsri.32 q2, q0, #18
	vstrw.u32 q2, [r3, #80]
	vshl.i32 q3, q1, #14
	vsri.32 q3, q1, #18
	vstrw.u32 q3, [r4, #80]
	vldrw.u32 q0, [r1, #128]
	vldrw.u32 q1, [r2, #128]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #28
	vsri.32 q2, q1, #4
	vstrw.u32 q2, [r3, #336]
	vshl.i32 q3, q0, #27
	vsri.32 q3, q0, #5
	vstrw.u32 q3, [r4, #336]
	vldrw.u32 q0, [r1, #208]
	vldrw.u32 q1, [r2, #208]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #13
	vsri.32 q2, q1, #19
	vstrw.u32 q2, [r3, #192]
	vshl.i32 q3, q0, #12
	vsri.32 q3, q0, #20
	vstrw.u32 q3, [r4, #192]
	vldrw.u32 q0, [r1, #288]
	vldrw.u32 q1, [r2, #288]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #11
	vsri.32 q2, q1, #21
	vstrw.u32 q2, [r3, #48]
	vshl.i32 q3, q0, #10
	vsri.32 q3, q0, #22
	vstrw.u32 q3, [r4, #48]
	vldrw.u32 q0, [r1, #368]
	vldrw.u32 q1, [r2, #368]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #28
	vsri.32 q2, q0, #4
	vstrw.u32 q2, [r3, #304]
	vshl.i32 q3, q1, #28
	vsri.32 q3, q1, #4
	vstrw.u32 q3, [r4, #304]
	vldrw.u32 q6, [r5, #224]
	vldrw.u32 q7, [r5, #304]
	vldrw.u32 q0, [r1, #64]
	vldrw.u32 q1, [r2, #64]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #14
	vsri.32 q2, q1, #18
	vstrw.u32 q2, [r3, #240]
	vshl.i32 q3, q0, #13
	vsri.32 q3, q0, #19
	vstrw.u32 q3, [r4, #240]
	vldrw.u32 q0, [r1, #144]
	vldrw.u32 q1, [r2, #144]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #10
	vsri.32 q2, q0, #22
	vstrw.u32 q2, [r3, #96]
	vshl.i32 q3, q1, #10
	vsri.32 q3, q1, #22
	vstrw.u32 q3, [r4, #96]
	vldrw.u32 q0, [r1, #224]
	vldrw.u32 q1, [r2, #224]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #20
	vsri.32 q2, q1, #12
	vstrw.u32 q2, [r3, #352]
	vshl.i32 q3, q0, #19
	vsri.32 q3, q0, #13
	vstrw.u32 q3, [r4, #352]
	vldrw.u32 q0, [r1, #304]
	vldrw.u32 q1, [r2, #304]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #4
	vsri.32 q2, q0, #28
	vstrw.u32 q2, [r3, #208]
	vshl.i32 q3, q1, #4
	vsri.32 q3, q1, #28
	vstrw.u32 q3, [r4, #208]
	vldrw.u32 q0, [r1, #384]
	vldrw.u32 q1, [r2, #384]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #7
	vsri.32 q2, q0, #25
	vstrw.u32 q2, [r3, #64]
	vshl.i32 q3, q1, #7
	vsri.32 q3, q1, #25
	vstrw.u32 q3, [r4, #64]
	vldrw.u32 q0, [r3, #0]
	vldrw.u32 q1, [r3, #16]
	vldrw.u32 q2, [r3, #32]
	vldrw.u32 q3, [r3, #48]
	vldrw.u32 q4, [r3, #64]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r1, #0]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r1, #16]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r1, #32]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r1, #48]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r1, #64]
	vldrw.u32 q0, [r3, #80]
	vldrw.u32 q1, [r3, #96]
	vldrw.u32 q2, [r3, #112]
	vldrw.u32 q3, [r3, #128]
	vldrw.u32 q4, [r3, #144]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r1, #80]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r1, #96]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r1, #112]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r1, #128]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r1, #144]
	vldrw.u32 q0, [r3, #160]
	vldrw.u32 q1, [r3, #176]
	vldrw.u32 q2, [r3, #192]
	vldrw.u32 q3, [r3, #208]
	vldrw.u32 q4, [r3, #224]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r1, #160]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r1, #176]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r1, #192]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r1, #208]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r1, #224]
	vldrw.u32 q0, [r3, #240]
	vldrw.u32 q1, [r3, #256]
	vldrw.u32 q2, [r3, #272]
	vldrw.u32 q3, [r3, #288]
	vldrw.u32 q4, [r3, #304]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r1, #240]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r1, #256]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r1, #272]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r1, #288]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r1, #304]
	vldrw.u32 q0, [r3, #320]
	vldrw.u32 q1, [r3, #336]
	vldrw.u32 q2, [r3, #352]
	vldrw.u32 q3, [r3, #368]
	vldrw.u32 q4, [r3, #384]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r1, #320]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r1, #336]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r1, #352]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r1, #368]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r1, #384]
	vldrw.u32 q0, [r4, #0]
	vldrw.u32 q1, [r4, #16]
	vldrw.u32 q2, [r4, #32]
	vldrw.u32 q3, [r4, #48]
	vldrw.u32 q4, [r4, #64]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r2, #0]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r2, #16]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r2, #32]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r2, #48]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r2, #64]
	vldrw.u32 q0, [r4, #80]
	vldrw.u32 q1, [r4, #96]
	vldrw.u32 q2, [r4, #112]
	vldrw.u32 q3, [r4, #128]
	vldrw.u32 q4, [r4, #144]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r2, #80]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r2, #96]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r2, #112]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r2, #128]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r2, #144]
	vldrw.u32 q0, [r4, #160]
	vldrw.u32 q1, [r4, #176]
	vldrw.u32 q2, [r4, #192]
	vldrw.u32 q3, [r4, #208]
	vldrw.u32 q4, [r4, #224]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r2, #160]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r2, #176]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r2, #192]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r2, #208]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r2, #224]
	vldrw.u32 q0, [r4, #240]
	vldrw.u32 q1, [r4, #256]
	vldrw.u32 q2, [r4, #272]
	vldrw.u32 q3, [r4, #288]
	vldrw.u32 q4, [r4, #304]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r2, #240]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r2, #256]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r2, #272]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r2, #288]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r2, #304]
	vldrw.u32 q0, [r4, #320]
	vldrw.u32 q1, [r4, #336]
	vldrw.u32 q2, [r4, #352]
	vldrw.u32 q3, [r4, #368]
	vldrw.u32 q4, [r4, #384]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r2, #320]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r2, #336]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r2, #352]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r2, #368]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r2, #384]
	vmov.i32 q0, #1
	vldrw.u32 q1, [r1, #0]
	veor q1, q1, q0
	vstrw.u32 q1, [r1, #0]
	subs r6, r6, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// coissue_scalar
.global coissue_scalar
.type coissue_scalar, %function
.thumb_func
.balign 16
coissue_scalar:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r12, r0
	movs r2, #3
	movs r3, #5
	movs r4, #0
	movs r5, #0
.balign 16
1:
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	umaal r4, r5, r2, r3
	subs r12, r12, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// coissue_zip
.global coissue_zip
.type coissue_zip, %function
.thumb_func
.balign 16
coissue_zip:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r12, r0
	mov r6, r1
	add r7, r1, #512
	add r9, r1, #1024
	add r10, r1, #1536
	add r11, r1, #2048
	movs r2, #3
	movs r3, #5
	movs r4, #0
	movs r5, #0
.balign 16
1:
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #80]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #160]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #240]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #320]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q0, [r11, #0]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #16]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #96]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #176]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #256]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #336]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q0, [r11, #16]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #32]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #112]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #192]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #272]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #352]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q0, [r11, #32]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #48]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #128]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #208]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #288]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #368]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q0, [r11, #48]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #64]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #144]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #224]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #304]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #384]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q0, [r11, #64]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r7, #0]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #80]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #160]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #240]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #320]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q0, [r11, #80]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r7, #16]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #96]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #176]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #256]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #336]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q0, [r11, #96]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r7, #32]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #112]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #192]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #272]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #352]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q0, [r11, #112]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r7, #48]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #128]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #208]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #288]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #368]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q0, [r11, #128]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r7, #64]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #144]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #224]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #304]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #384]
	umaal r4, r5, r2, r3
	veor q0, q0, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q0, [r11, #144]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r11, #96]
	umaal r4, r5, r2, r3
	vshl.i32 q1, q0, #1
	umaal r4, r5, r2, r3
	vsri.32 q1, q0, #31
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r11, #64]
	umaal r4, r5, r2, r3
	veor q1, q1, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q1, [r11, #160]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r11, #16]
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r11, #144]
	umaal r4, r5, r2, r3
	veor q0, q0, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q0, [r11, #240]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r11, #112]
	umaal r4, r5, r2, r3
	vshl.i32 q1, q0, #1
	umaal r4, r5, r2, r3
	vsri.32 q1, q0, #31
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r11, #0]
	umaal r4, r5, r2, r3
	veor q1, q1, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q1, [r11, #176]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r11, #32]
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r11, #80]
	umaal r4, r5, r2, r3
	veor q0, q0, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q0, [r11, #256]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r11, #128]
	umaal r4, r5, r2, r3
	vshl.i32 q1, q0, #1
	umaal r4, r5, r2, r3
	vsri.32 q1, q0, #31
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r11, #16]
	umaal r4, r5, r2, r3
	veor q1, q1, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q1, [r11, #192]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r11, #48]
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r11, #96]
	umaal r4, r5, r2, r3
	veor q0, q0, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q0, [r11, #272]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r11, #144]
	umaal r4, r5, r2, r3
	vshl.i32 q1, q0, #1
	umaal r4, r5, r2, r3
	vsri.32 q1, q0, #31
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r11, #32]
	umaal r4, r5, r2, r3
	veor q1, q1, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q1, [r11, #208]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r11, #64]
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r11, #112]
	umaal r4, r5, r2, r3
	veor q0, q0, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q0, [r11, #288]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r11, #80]
	umaal r4, r5, r2, r3
	vshl.i32 q1, q0, #1
	umaal r4, r5, r2, r3
	vsri.32 q1, q0, #31
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r11, #48]
	umaal r4, r5, r2, r3
	veor q1, q1, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q1, [r11, #224]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r11, #0]
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r11, #128]
	umaal r4, r5, r2, r3
	veor q0, q0, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q0, [r11, #304]
	umaal r4, r5, r2, r3
	vldrw.u32 q6, [r11, #160]
	umaal r4, r5, r2, r3
	vldrw.u32 q7, [r11, #240]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #0]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vorr q2, q0, q0
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #0]
	umaal r4, r5, r2, r3
	vorr q3, q1, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #0]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #80]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #80]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q0, #18
	umaal r4, r5, r2, r3
	vsri.32 q2, q0, #14
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #256]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q1, #18
	umaal r4, r5, r2, r3
	vsri.32 q3, q1, #14
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #256]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #160]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #160]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q1, #2
	umaal r4, r5, r2, r3
	vsri.32 q2, q1, #30
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #112]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q0, #1
	umaal r4, r5, r2, r3
	vsri.32 q3, q0, #31
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #112]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #240]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #240]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q1, #21
	umaal r4, r5, r2, r3
	vsri.32 q2, q1, #11
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #368]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q0, #20
	umaal r4, r5, r2, r3
	vsri.32 q3, q0, #12
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #368]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #320]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #320]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q0, #9
	umaal r4, r5, r2, r3
	vsri.32 q2, q0, #23
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #224]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q1, #9
	umaal r4, r5, r2, r3
	vsri.32 q3, q1, #23
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #224]
	umaal r4, r5, r2, r3
	vldrw.u32 q6, [r11, #176]
	umaal r4, r5, r2, r3
	vldrw.u32 q7, [r11, #256]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #16]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #16]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q1, #1
	umaal r4, r5, r2, r3
	vsri.32 q2, q1, #31
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #160]
	umaal r4, r5, r2, r3
	vorr q3, q0, q0
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #160]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #96]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #96]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q0, #22
	umaal r4, r5, r2, r3
	vsri.32 q2, q0, #10
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #16]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q1, #22
	umaal r4, r5, r2, r3
	vsri.32 q3, q1, #10
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #16]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #176]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #176]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q0, #5
	umaal r4, r5, r2, r3
	vsri.32 q2, q0, #27
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #272]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q1, #5
	umaal r4, r5, r2, r3
	vsri.32 q3, q1, #27
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #272]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #256]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #256]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q1, #23
	umaal r4, r5, r2, r3
	vsri.32 q2, q1, #9
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #128]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q0, #22
	umaal r4, r5, r2, r3
	vsri.32 q3, q0, #10
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #128]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #336]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #336]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q0, #1
	umaal r4, r5, r2, r3
	vsri.32 q2, q0, #31
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #384]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q1, #1
	umaal r4, r5, r2, r3
	vsri.32 q3, q1, #31
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #384]
	umaal r4, r5, r2, r3
	vldrw.u32 q6, [r11, #192]
	umaal r4, r5, r2, r3
	vldrw.u32 q7, [r11, #272]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #32]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #32]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q0, #31
	umaal r4, r5, r2, r3
	vsri.32 q2, q0, #1
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #320]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q1, #31
	umaal r4, r5, r2, r3
	vsri.32 q3, q1, #1
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #320]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #112]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #112]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q0, #3
	umaal r4, r5, r2, r3
	vsri.32 q2, q0, #29
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #176]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q1, #3
	umaal r4, r5, r2, r3
	vsri.32 q3, q1, #29
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #176]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #192]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #192]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q1, #22
	umaal r4, r5, r2, r3
	vsri.32 q2, q1, #10
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #32]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q0, #21
	umaal r4, r5, r2, r3
	vsri.32 q3, q0, #11
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #32]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #272]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #272]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q1, #8
	umaal r4, r5, r2, r3
	vsri.32 q2, q1, #24
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #288]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q0, #7
	umaal r4, r5, r2, r3
	vsri.32 q3, q0, #25
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #288]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #352]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #352]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q1, #31
	umaal r4, r5, r2, r3
	vsri.32 q2, q1, #1
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #144]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q0, #30
	umaal r4, r5, r2, r3
	vsri.32 q3, q0, #2
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #144]
	umaal r4, r5, r2, r3
	vldrw.u32 q6, [r11, #208]
	umaal r4, r5, r2, r3
	vldrw.u32 q7, [r11, #288]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #48]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #48]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q0, #14
	umaal r4, r5, r2, r3
	vsri.32 q2, q0, #18
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #80]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q1, #14
	umaal r4, r5, r2, r3
	vsri.32 q3, q1, #18
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #80]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #128]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #128]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q1, #28
	umaal r4, r5, r2, r3
	vsri.32 q2, q1, #4
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #336]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q0, #27
	umaal r4, r5, r2, r3
	vsri.32 q3, q0, #5
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #336]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #208]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #208]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q1, #13
	umaal r4, r5, r2, r3
	vsri.32 q2, q1, #19
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #192]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q0, #12
	umaal r4, r5, r2, r3
	vsri.32 q3, q0, #20
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #192]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #288]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #288]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q1, #11
	umaal r4, r5, r2, r3
	vsri.32 q2, q1, #21
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #48]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q0, #10
	umaal r4, r5, r2, r3
	vsri.32 q3, q0, #22
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #48]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #368]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #368]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q0, #28
	umaal r4, r5, r2, r3
	vsri.32 q2, q0, #4
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #304]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q1, #28
	umaal r4, r5, r2, r3
	vsri.32 q3, q1, #4
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #304]
	umaal r4, r5, r2, r3
	vldrw.u32 q6, [r11, #224]
	umaal r4, r5, r2, r3
	vldrw.u32 q7, [r11, #304]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #64]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #64]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q1, #14
	umaal r4, r5, r2, r3
	vsri.32 q2, q1, #18
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #240]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q0, #13
	umaal r4, r5, r2, r3
	vsri.32 q3, q0, #19
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #240]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #144]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #144]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q0, #10
	umaal r4, r5, r2, r3
	vsri.32 q2, q0, #22
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #96]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q1, #10
	umaal r4, r5, r2, r3
	vsri.32 q3, q1, #22
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #96]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #224]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #224]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q1, #20
	umaal r4, r5, r2, r3
	vsri.32 q2, q1, #12
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #352]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q0, #19
	umaal r4, r5, r2, r3
	vsri.32 q3, q0, #13
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #352]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #304]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #304]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q0, #4
	umaal r4, r5, r2, r3
	vsri.32 q2, q0, #28
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #208]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q1, #4
	umaal r4, r5, r2, r3
	vsri.32 q3, q1, #28
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #208]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r6, #384]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r7, #384]
	umaal r4, r5, r2, r3
	veor q0, q0, q6
	umaal r4, r5, r2, r3
	veor q1, q1, q7
	umaal r4, r5, r2, r3
	vshl.i32 q2, q0, #7
	umaal r4, r5, r2, r3
	vsri.32 q2, q0, #25
	umaal r4, r5, r2, r3
	vstrw.u32 q2, [r9, #64]
	umaal r4, r5, r2, r3
	vshl.i32 q3, q1, #7
	umaal r4, r5, r2, r3
	vsri.32 q3, q1, #25
	umaal r4, r5, r2, r3
	vstrw.u32 q3, [r10, #64]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r9, #0]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r9, #16]
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r9, #32]
	umaal r4, r5, r2, r3
	vldrw.u32 q3, [r9, #48]
	umaal r4, r5, r2, r3
	vldrw.u32 q4, [r9, #64]
	umaal r4, r5, r2, r3
	vbic q5, q2, q1
	umaal r4, r5, r2, r3
	veor q5, q5, q0
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #0]
	umaal r4, r5, r2, r3
	vbic q5, q3, q2
	umaal r4, r5, r2, r3
	veor q5, q5, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #16]
	umaal r4, r5, r2, r3
	vbic q5, q4, q3
	umaal r4, r5, r2, r3
	veor q5, q5, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #32]
	umaal r4, r5, r2, r3
	vbic q5, q0, q4
	umaal r4, r5, r2, r3
	veor q5, q5, q3
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #48]
	umaal r4, r5, r2, r3
	vbic q5, q1, q0
	umaal r4, r5, r2, r3
	veor q5, q5, q4
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #64]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r9, #80]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r9, #96]
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r9, #112]
	umaal r4, r5, r2, r3
	vldrw.u32 q3, [r9, #128]
	umaal r4, r5, r2, r3
	vldrw.u32 q4, [r9, #144]
	umaal r4, r5, r2, r3
	vbic q5, q2, q1
	umaal r4, r5, r2, r3
	veor q5, q5, q0
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #80]
	umaal r4, r5, r2, r3
	vbic q5, q3, q2
	umaal r4, r5, r2, r3
	veor q5, q5, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #96]
	umaal r4, r5, r2, r3
	vbic q5, q4, q3
	umaal r4, r5, r2, r3
	veor q5, q5, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #112]
	umaal r4, r5, r2, r3
	vbic q5, q0, q4
	umaal r4, r5, r2, r3
	veor q5, q5, q3
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #128]
	umaal r4, r5, r2, r3
	vbic q5, q1, q0
	umaal r4, r5, r2, r3
	veor q5, q5, q4
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #144]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r9, #160]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r9, #176]
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r9, #192]
	umaal r4, r5, r2, r3
	vldrw.u32 q3, [r9, #208]
	umaal r4, r5, r2, r3
	vldrw.u32 q4, [r9, #224]
	umaal r4, r5, r2, r3
	vbic q5, q2, q1
	umaal r4, r5, r2, r3
	veor q5, q5, q0
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #160]
	umaal r4, r5, r2, r3
	vbic q5, q3, q2
	umaal r4, r5, r2, r3
	veor q5, q5, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #176]
	umaal r4, r5, r2, r3
	vbic q5, q4, q3
	umaal r4, r5, r2, r3
	veor q5, q5, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #192]
	umaal r4, r5, r2, r3
	vbic q5, q0, q4
	umaal r4, r5, r2, r3
	veor q5, q5, q3
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #208]
	umaal r4, r5, r2, r3
	vbic q5, q1, q0
	umaal r4, r5, r2, r3
	veor q5, q5, q4
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #224]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r9, #240]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r9, #256]
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r9, #272]
	umaal r4, r5, r2, r3
	vldrw.u32 q3, [r9, #288]
	umaal r4, r5, r2, r3
	vldrw.u32 q4, [r9, #304]
	umaal r4, r5, r2, r3
	vbic q5, q2, q1
	umaal r4, r5, r2, r3
	veor q5, q5, q0
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #240]
	umaal r4, r5, r2, r3
	vbic q5, q3, q2
	umaal r4, r5, r2, r3
	veor q5, q5, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #256]
	umaal r4, r5, r2, r3
	vbic q5, q4, q3
	umaal r4, r5, r2, r3
	veor q5, q5, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #272]
	umaal r4, r5, r2, r3
	vbic q5, q0, q4
	umaal r4, r5, r2, r3
	veor q5, q5, q3
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #288]
	umaal r4, r5, r2, r3
	vbic q5, q1, q0
	umaal r4, r5, r2, r3
	veor q5, q5, q4
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #304]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r9, #320]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r9, #336]
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r9, #352]
	umaal r4, r5, r2, r3
	vldrw.u32 q3, [r9, #368]
	umaal r4, r5, r2, r3
	vldrw.u32 q4, [r9, #384]
	umaal r4, r5, r2, r3
	vbic q5, q2, q1
	umaal r4, r5, r2, r3
	veor q5, q5, q0
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #320]
	umaal r4, r5, r2, r3
	vbic q5, q3, q2
	umaal r4, r5, r2, r3
	veor q5, q5, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #336]
	umaal r4, r5, r2, r3
	vbic q5, q4, q3
	umaal r4, r5, r2, r3
	veor q5, q5, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #352]
	umaal r4, r5, r2, r3
	vbic q5, q0, q4
	umaal r4, r5, r2, r3
	veor q5, q5, q3
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #368]
	umaal r4, r5, r2, r3
	vbic q5, q1, q0
	umaal r4, r5, r2, r3
	veor q5, q5, q4
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r6, #384]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r10, #0]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r10, #16]
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r10, #32]
	umaal r4, r5, r2, r3
	vldrw.u32 q3, [r10, #48]
	umaal r4, r5, r2, r3
	vldrw.u32 q4, [r10, #64]
	umaal r4, r5, r2, r3
	vbic q5, q2, q1
	umaal r4, r5, r2, r3
	veor q5, q5, q0
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #0]
	umaal r4, r5, r2, r3
	vbic q5, q3, q2
	umaal r4, r5, r2, r3
	veor q5, q5, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #16]
	umaal r4, r5, r2, r3
	vbic q5, q4, q3
	umaal r4, r5, r2, r3
	veor q5, q5, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #32]
	umaal r4, r5, r2, r3
	vbic q5, q0, q4
	umaal r4, r5, r2, r3
	veor q5, q5, q3
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #48]
	umaal r4, r5, r2, r3
	vbic q5, q1, q0
	umaal r4, r5, r2, r3
	veor q5, q5, q4
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #64]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r10, #80]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r10, #96]
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r10, #112]
	umaal r4, r5, r2, r3
	vldrw.u32 q3, [r10, #128]
	umaal r4, r5, r2, r3
	vldrw.u32 q4, [r10, #144]
	umaal r4, r5, r2, r3
	vbic q5, q2, q1
	umaal r4, r5, r2, r3
	veor q5, q5, q0
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #80]
	umaal r4, r5, r2, r3
	vbic q5, q3, q2
	umaal r4, r5, r2, r3
	veor q5, q5, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #96]
	umaal r4, r5, r2, r3
	vbic q5, q4, q3
	umaal r4, r5, r2, r3
	veor q5, q5, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #112]
	umaal r4, r5, r2, r3
	vbic q5, q0, q4
	umaal r4, r5, r2, r3
	veor q5, q5, q3
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #128]
	umaal r4, r5, r2, r3
	vbic q5, q1, q0
	umaal r4, r5, r2, r3
	veor q5, q5, q4
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #144]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r10, #160]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r10, #176]
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r10, #192]
	umaal r4, r5, r2, r3
	vldrw.u32 q3, [r10, #208]
	umaal r4, r5, r2, r3
	vldrw.u32 q4, [r10, #224]
	umaal r4, r5, r2, r3
	vbic q5, q2, q1
	umaal r4, r5, r2, r3
	veor q5, q5, q0
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #160]
	umaal r4, r5, r2, r3
	vbic q5, q3, q2
	umaal r4, r5, r2, r3
	veor q5, q5, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #176]
	umaal r4, r5, r2, r3
	vbic q5, q4, q3
	umaal r4, r5, r2, r3
	veor q5, q5, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #192]
	umaal r4, r5, r2, r3
	vbic q5, q0, q4
	umaal r4, r5, r2, r3
	veor q5, q5, q3
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #208]
	umaal r4, r5, r2, r3
	vbic q5, q1, q0
	umaal r4, r5, r2, r3
	veor q5, q5, q4
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #224]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r10, #240]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r10, #256]
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r10, #272]
	umaal r4, r5, r2, r3
	vldrw.u32 q3, [r10, #288]
	umaal r4, r5, r2, r3
	vldrw.u32 q4, [r10, #304]
	umaal r4, r5, r2, r3
	vbic q5, q2, q1
	umaal r4, r5, r2, r3
	veor q5, q5, q0
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #240]
	umaal r4, r5, r2, r3
	vbic q5, q3, q2
	umaal r4, r5, r2, r3
	veor q5, q5, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #256]
	umaal r4, r5, r2, r3
	vbic q5, q4, q3
	umaal r4, r5, r2, r3
	veor q5, q5, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #272]
	umaal r4, r5, r2, r3
	vbic q5, q0, q4
	umaal r4, r5, r2, r3
	veor q5, q5, q3
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #288]
	umaal r4, r5, r2, r3
	vbic q5, q1, q0
	umaal r4, r5, r2, r3
	veor q5, q5, q4
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #304]
	umaal r4, r5, r2, r3
	vldrw.u32 q0, [r10, #320]
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r10, #336]
	umaal r4, r5, r2, r3
	vldrw.u32 q2, [r10, #352]
	umaal r4, r5, r2, r3
	vldrw.u32 q3, [r10, #368]
	umaal r4, r5, r2, r3
	vldrw.u32 q4, [r10, #384]
	umaal r4, r5, r2, r3
	vbic q5, q2, q1
	umaal r4, r5, r2, r3
	veor q5, q5, q0
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #320]
	umaal r4, r5, r2, r3
	vbic q5, q3, q2
	umaal r4, r5, r2, r3
	veor q5, q5, q1
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #336]
	umaal r4, r5, r2, r3
	vbic q5, q4, q3
	umaal r4, r5, r2, r3
	veor q5, q5, q2
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #352]
	umaal r4, r5, r2, r3
	vbic q5, q0, q4
	umaal r4, r5, r2, r3
	veor q5, q5, q3
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #368]
	umaal r4, r5, r2, r3
	vbic q5, q1, q0
	umaal r4, r5, r2, r3
	veor q5, q5, q4
	umaal r4, r5, r2, r3
	vstrw.u32 q5, [r7, #384]
	umaal r4, r5, r2, r3
	vmov.i32 q0, #1
	umaal r4, r5, r2, r3
	vldrw.u32 q1, [r6, #0]
	umaal r4, r5, r2, r3
	veor q1, q1, q0
	umaal r4, r5, r2, r3
	vstrw.u32 q1, [r6, #0]
	subs r12, r12, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// keccak4_mve3
.global keccak4_mve3
.type keccak4_mve3, %function
.thumb_func
.balign 16
keccak4_mve3:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r6, r0
	add r10, r1, #400
	add r11, r1, #1440
	add r12, r1, #2048
.balign 16
1:
	vldrw.u32 q0, [r10, #-400]
	vldrw.u32 q1, [r10, #-320]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-240]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-160]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-80]
	veor q0, q0, q1
	vstrw.u32 q0, [r12, #0]
	vldrw.u32 q0, [r10, #-384]
	vldrw.u32 q1, [r10, #-304]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-224]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-144]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-64]
	veor q0, q0, q1
	vstrw.u32 q0, [r12, #16]
	vldrw.u32 q0, [r10, #-368]
	vldrw.u32 q1, [r10, #-288]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-208]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-128]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-48]
	veor q0, q0, q1
	vstrw.u32 q0, [r12, #32]
	vldrw.u32 q0, [r10, #-352]
	vldrw.u32 q1, [r10, #-272]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-192]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-112]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-32]
	veor q0, q0, q1
	vstrw.u32 q0, [r12, #48]
	vldrw.u32 q0, [r10, #-336]
	vldrw.u32 q1, [r10, #-256]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-176]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-96]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-16]
	veor q0, q0, q1
	vstrw.u32 q0, [r12, #64]
	vldrw.u32 q0, [r10, #112]
	vldrw.u32 q1, [r10, #192]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #272]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #352]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #432]
	veor q0, q0, q1
	vstrw.u32 q0, [r12, #80]
	vldrw.u32 q0, [r10, #128]
	vldrw.u32 q1, [r10, #208]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #288]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #368]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #448]
	veor q0, q0, q1
	vstrw.u32 q0, [r12, #96]
	vldrw.u32 q0, [r10, #144]
	vldrw.u32 q1, [r10, #224]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #304]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #384]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #464]
	veor q0, q0, q1
	vstrw.u32 q0, [r12, #112]
	vldrw.u32 q0, [r10, #160]
	vldrw.u32 q1, [r10, #240]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #320]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #400]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #480]
	veor q0, q0, q1
	vstrw.u32 q0, [r12, #128]
	vldrw.u32 q0, [r10, #176]
	vldrw.u32 q1, [r10, #256]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #336]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #416]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #496]
	veor q0, q0, q1
	vstrw.u32 q0, [r12, #144]
	vldrw.u32 q0, [r12, #96]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r12, #64]
	veor q1, q1, q2
	vstrw.u32 q1, [r12, #160]
	vldrw.u32 q0, [r12, #16]
	vldrw.u32 q2, [r12, #144]
	veor q0, q0, q2
	vstrw.u32 q0, [r12, #240]
	vldrw.u32 q0, [r12, #112]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r12, #0]
	veor q1, q1, q2
	vstrw.u32 q1, [r12, #176]
	vldrw.u32 q0, [r12, #32]
	vldrw.u32 q2, [r12, #80]
	veor q0, q0, q2
	vstrw.u32 q0, [r12, #256]
	vldrw.u32 q0, [r12, #128]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r12, #16]
	veor q1, q1, q2
	vstrw.u32 q1, [r12, #192]
	vldrw.u32 q0, [r12, #48]
	vldrw.u32 q2, [r12, #96]
	veor q0, q0, q2
	vstrw.u32 q0, [r12, #272]
	vldrw.u32 q0, [r12, #144]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r12, #32]
	veor q1, q1, q2
	vstrw.u32 q1, [r12, #208]
	vldrw.u32 q0, [r12, #64]
	vldrw.u32 q2, [r12, #112]
	veor q0, q0, q2
	vstrw.u32 q0, [r12, #288]
	vldrw.u32 q0, [r12, #80]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r12, #48]
	veor q1, q1, q2
	vstrw.u32 q1, [r12, #224]
	vldrw.u32 q0, [r12, #0]
	vldrw.u32 q2, [r12, #128]
	veor q0, q0, q2
	vstrw.u32 q0, [r12, #304]
	vldrw.u32 q6, [r12, #160]
	vldrw.u32 q7, [r12, #240]
	vldrw.u32 q0, [r10, #-400]
	vldrw.u32 q1, [r10, #112]
	veor q0, q0, q6
	veor q1, q1, q7
	vorr q2, q0, q0
	vstrw.u32 q2, [r11, #-416]
	vorr q3, q1, q1
	vstrw.u32 q3, [r11, #96]
	vldrw.u32 q0, [r10, #-320]
	vldrw.u32 q1, [r10, #192]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #18
	vsri.32 q2, q0, #14
	vstrw.u32 q2, [r11, #-160]
	vshl.i32 q3, q1, #18
	vsri.32 q3, q1, #14
	vstrw.u32 q3, [r11, #352]
	vldrw.u32 q0, [r10, #-240]
	vldrw.u32 q1, [r10, #272]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #2
	vsri.32 q2, q1, #30
	vstrw.u32 q2, [r11, #-304]
	vshl.i32 q3, q0, #1
	vsri.32 q3, q0, #31
	vstrw.u32 q3, [r11, #208]
	vldrw.u32 q0, [r10, #-160]
	vldrw.u32 q1, [r10, #352]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #21
	vsri.32 q2, q1, #11
	vstrw.u32 q2, [r11, #-48]
	vshl.i32 q3, q0, #20
	vsri.32 q3, q0, #12
	vstrw.u32 q3, [r11, #464]
	vldrw.u32 q0, [r10, #-80]
	vldrw.u32 q1, [r10, #432]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #9
	vsri.32 q2, q0, #23
	vstrw.u32 q2, [r11, #-192]
	vshl.i32 q3, q1, #9
	vsri.32 q3, q1, #23
	vstrw.u32 q3, [r11, #320]
	vldrw.u32 q6, [r12, #176]
	vldrw.u32 q7, [r12, #256]
	vldrw.u32 q0, [r10, #-384]
	vldrw.u32 q1, [r10, #128]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #1
	vsri.32 q2, q1, #31
	vstrw.u32 q2, [r11, #-256]
	vorr q3, q0, q0
	vstrw.u32 q3, [r11, #256]
	vldrw.u32 q0, [r10, #-304]
	vldrw.u32 q1, [r10, #208]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #22
	vsri.32 q2, q0, #10
	vstrw.u32 q2, [r11, #-400]
	vshl.i32 q3, q1, #22
	vsri.32 q3, q1, #10
	vstrw.u32 q3, [r11, #112]
	vldrw.u32 q0, [r10, #-224]
	vldrw.u32 q1, [r10, #288]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #5
	vsri.32 q2, q0, #27
	vstrw.u32 q2, [r11, #-144]
	vshl.i32 q3, q1, #5
	vsri.32 q3, q1, #27
	vstrw.u32 q3, [r11, #368]
	vldrw.u32 q0, [r10, #-144]
	vldrw.u32 q1, [r10, #368]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #23
	vsri.32 q2, q1, #9
	vstrw.u32 q2, [r11, #-288]
	vshl.i32 q3, q0, #22
	vsri.32 q3, q0, #10
	vstrw.u32 q3, [r11, #224]
	vldrw.u32 q0, [r10, #-64]
	vldrw.u32 q1, [r10, #448]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #1
	vsri.32 q2, q0, #31
	vstrw.u32 q2, [r11, #-32]
	vshl.i32 q3, q1, #1
	vsri.32 q3, q1, #31
	vstrw.u32 q3, [r11, #480]
	vldrw.u32 q6, [r12, #192]
	vldrw.u32 q7, [r12, #272]
	vldrw.u32 q0, [r10, #-368]
	vldrw.u32 q1, [r10, #144]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #31
	vsri.32 q2, q0, #1
	vstrw.u32 q2, [r11, #-96]
	vshl.i32 q3, q1, #31
	vsri.32 q3, q1, #1
	vstrw.u32 q3, [r11, #416]
	vldrw.u32 q0, [r10, #-288]
	vldrw.u32 q1, [r10, #224]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #3
	vsri.32 q2, q0, #29
	vstrw.u32 q2, [r11, #-240]
	vshl.i32 q3, q1, #3
	vsri.32 q3, q1, #29
	vstrw.u32 q3, [r11, #272]
	vldrw.u32 q0, [r10, #-208]
	vldrw.u32 q1, [r10, #304]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #22
	vsri.32 q2, q1, #10
	vstrw.u32 q2, [r11, #-384]
	vshl.i32 q3, q0, #21
	vsri.32 q3, q0, #11
	vstrw.u32 q3, [r11, #128]
	vldrw.u32 q0, [r10, #-128]
	vldrw.u32 q1, [r10, #384]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #8
	vsri.32 q2, q1, #24
	vstrw.u32 q2, [r11, #-128]
	vshl.i32 q3, q0, #7
	vsri.32 q3, q0, #25
	vstrw.u32 q3, [r11, #384]
	vldrw.u32 q0, [r10, #-48]
	vldrw.u32 q1, [r10, #464]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #31
	vsri.32 q2, q1, #1
	vstrw.u32 q2, [r11, #-272]
	vshl.i32 q3, q0, #30
	vsri.32 q3, q0, #2
	vstrw.u32 q3, [r11, #240]
	vldrw.u32 q6, [r12, #208]
	vldrw.u32 q7, [r12, #288]
	vldrw.u32 q0, [r10, #-352]
	vldrw.u32 q1, [r10, #160]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #14
	vsri.32 q2, q0, #18
	vstrw.u32 q2, [r11, #-336]
	vshl.i32 q3, q1, #14
	vsri.32 q3, q1, #18
	vstrw.u32 q3, [r11, #176]
	vldrw.u32 q0, [r10, #-272]
	vldrw.u32 q1, [r10, #240]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #28
	vsri.32 q2, q1, #4
	vstrw.u32 q2, [r11, #-80]
	vshl.i32 q3, q0, #27
	vsri.32 q3, q0, #5
	vstrw.u32 q3, [r11, #432]
	vldrw.u32 q0, [r10, #-192]
	vldrw.u32 q1, [r10, #320]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #13
	vsri.32 q2, q1, #19
	vstrw.u32 q2, [r11, #-224]
	vshl.i32 q3, q0, #12
	vsri.32 q3, q0, #20
	vstrw.u32 q3, [r11, #288]
	vldrw.u32 q0, [r10, #-112]
	vldrw.u32 q1, [r10, #400]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #11
	vsri.32 q2, q1, #21
	vstrw.u32 q2, [r11, #-368]
	vshl.i32 q3, q0, #10
	vsri.32 q3, q0, #22
	vstrw.u32 q3, [r11, #144]
	vldrw.u32 q0, [r10, #-32]
	vldrw.u32 q1, [r10, #480]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #28
	vsri.32 q2, q0, #4
	vstrw.u32 q2, [r11, #-112]
	vshl.i32 q3, q1, #28
	vsri.32 q3, q1, #4
	vstrw.u32 q3, [r11, #400]
	vldrw.u32 q6, [r12, #224]
	vldrw.u32 q7, [r12, #304]
	vldrw.u32 q0, [r10, #-336]
	vldrw.u32 q1, [r10, #176]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #14
	vsri.32 q2, q1, #18
	vstrw.u32 q2, [r11, #-176]
	vshl.i32 q3, q0, #13
	vsri.32 q3, q0, #19
	vstrw.u32 q3, [r11, #336]
	vldrw.u32 q0, [r10, #-256]
	vldrw.u32 q1, [r10, #256]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #10
	vsri.32 q2, q0, #22
	vstrw.u32 q2, [r11, #-320]
	vshl.i32 q3, q1, #10
	vsri.32 q3, q1, #22
	vstrw.u32 q3, [r11, #192]
	vldrw.u32 q0, [r10, #-176]
	vldrw.u32 q1, [r10, #336]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #20
	vsri.32 q2, q1, #12
	vstrw.u32 q2, [r11, #-64]
	vshl.i32 q3, q0, #19
	vsri.32 q3, q0, #13
	vstrw.u32 q3, [r11, #448]
	vldrw.u32 q0, [r10, #-96]
	vldrw.u32 q1, [r10, #416]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #4
	vsri.32 q2, q0, #28
	vstrw.u32 q2, [r11, #-208]
	vshl.i32 q3, q1, #4
	vsri.32 q3, q1, #28
	vstrw.u32 q3, [r11, #304]
	vldrw.u32 q0, [r10, #-16]
	vldrw.u32 q1, [r10, #496]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #7
	vsri.32 q2, q0, #25
	vstrw.u32 q2, [r11, #-352]
	vshl.i32 q3, q1, #7
	vsri.32 q3, q1, #25
	vstrw.u32 q3, [r11, #160]
	vldrw.u32 q0, [r11, #-416]
	vldrw.u32 q1, [r11, #-400]
	vldrw.u32 q2, [r11, #-384]
	vldrw.u32 q3, [r11, #-368]
	vldrw.u32 q4, [r11, #-352]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #-400]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #-384]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #-368]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #-352]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #-336]
	vldrw.u32 q0, [r11, #-336]
	vldrw.u32 q1, [r11, #-320]
	vldrw.u32 q2, [r11, #-304]
	vldrw.u32 q3, [r11, #-288]
	vldrw.u32 q4, [r11, #-272]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #-320]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #-304]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #-288]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #-272]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #-256]
	vldrw.u32 q0, [r11, #-256]
	vldrw.u32 q1, [r11, #-240]
	vldrw.u32 q2, [r11, #-224]
	vldrw.u32 q3, [r11, #-208]
	vldrw.u32 q4, [r11, #-192]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #-240]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #-224]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #-208]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #-192]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #-176]
	vldrw.u32 q0, [r11, #-176]
	vldrw.u32 q1, [r11, #-160]
	vldrw.u32 q2, [r11, #-144]
	vldrw.u32 q3, [r11, #-128]
	vldrw.u32 q4, [r11, #-112]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #-160]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #-144]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #-128]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #-112]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #-96]
	vldrw.u32 q0, [r11, #-96]
	vldrw.u32 q1, [r11, #-80]
	vldrw.u32 q2, [r11, #-64]
	vldrw.u32 q3, [r11, #-48]
	vldrw.u32 q4, [r11, #-32]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #-80]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #-64]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #-48]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #-32]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #-16]
	vldrw.u32 q0, [r11, #96]
	vldrw.u32 q1, [r11, #112]
	vldrw.u32 q2, [r11, #128]
	vldrw.u32 q3, [r11, #144]
	vldrw.u32 q4, [r11, #160]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #112]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #128]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #144]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #160]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #176]
	vldrw.u32 q0, [r11, #176]
	vldrw.u32 q1, [r11, #192]
	vldrw.u32 q2, [r11, #208]
	vldrw.u32 q3, [r11, #224]
	vldrw.u32 q4, [r11, #240]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #192]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #208]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #224]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #240]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #256]
	vldrw.u32 q0, [r11, #256]
	vldrw.u32 q1, [r11, #272]
	vldrw.u32 q2, [r11, #288]
	vldrw.u32 q3, [r11, #304]
	vldrw.u32 q4, [r11, #320]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #272]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #288]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #304]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #320]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #336]
	vldrw.u32 q0, [r11, #336]
	vldrw.u32 q1, [r11, #352]
	vldrw.u32 q2, [r11, #368]
	vldrw.u32 q3, [r11, #384]
	vldrw.u32 q4, [r11, #400]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #352]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #368]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #384]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #400]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #416]
	vldrw.u32 q0, [r11, #416]
	vldrw.u32 q1, [r11, #432]
	vldrw.u32 q2, [r11, #448]
	vldrw.u32 q3, [r11, #464]
	vldrw.u32 q4, [r11, #480]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #432]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #448]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #464]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #480]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #496]
	vmov.i32 q0, #1
	vldrw.u32 q1, [r10, #-400]
	veor q1, q1, q0
	vstrw.u32 q1, [r10, #-400]
	subs r6, r6, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// coissue3_zip
.global coissue3_zip
.type coissue3_zip, %function
.thumb_func
.balign 16
coissue3_zip:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov lr, r0
	add r10, r1, #400
	add r11, r1, #1440
	add r12, r1, #2048
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-400]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-320]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-240]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-160]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-80]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r12, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-384]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-304]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-224]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-144]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-64]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r12, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-368]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-288]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-208]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-128]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-48]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r12, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-352]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-272]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-192]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-112]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-32]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r12, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-336]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-256]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-176]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-96]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-16]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r12, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #192]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #272]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #352]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #432]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r12, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #208]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #288]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #368]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #448]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r12, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #224]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #304]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #384]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #464]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r12, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #240]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #320]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #400]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #480]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r12, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #256]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #336]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #416]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #496]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r12, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r12, #96]
	umaal r0, r1, r2, r3
	vshl.i32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r12, #64]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r12, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r12, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r12, #144]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r12, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r12, #112]
	umaal r0, r1, r2, r3
	vshl.i32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r12, #0]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r12, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r12, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r12, #80]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r12, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r12, #128]
	umaal r0, r1, r2, r3
	vshl.i32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r12, #16]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r12, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r12, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r12, #96]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r12, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r12, #144]
	umaal r0, r1, r2, r3
	vshl.i32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r12, #32]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r12, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r12, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r12, #112]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r12, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r12, #80]
	umaal r0, r1, r2, r3
	vshl.i32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r12, #48]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r12, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r12, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r12, #128]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r12, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r12, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r12, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-400]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #112]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vorr q2, q0, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-416]
	umaal r0, r1, r2, r3
	vorr q3, q1, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-320]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #192]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #18
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #14
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-160]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #18
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #14
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-240]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #272]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #2
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #30
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-304]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #31
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-160]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #352]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #21
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #11
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-48]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #20
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #12
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #464]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-80]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #432]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #9
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #23
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-192]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #9
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #23
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r12, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r12, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-384]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #128]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #1
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #31
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-256]
	umaal r0, r1, r2, r3
	vorr q3, q0, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-304]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #208]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #22
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #10
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-400]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #22
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #10
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-224]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #288]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #5
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #27
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-144]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #5
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #27
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-144]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #368]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #23
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #9
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-288]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #22
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #10
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-64]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #448]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #31
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-32]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #1
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #31
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #480]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r12, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r12, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-368]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #144]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #31
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #1
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-96]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #31
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #1
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #416]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-288]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #224]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #3
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #29
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-240]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #3
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #29
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-208]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #304]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #22
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #10
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-384]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #21
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #11
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-128]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #384]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #8
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #24
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-128]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #7
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #25
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-48]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #464]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #31
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #1
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-272]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #30
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #2
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r12, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r12, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-352]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #160]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #14
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #18
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-336]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #14
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #18
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-272]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #240]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #28
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #4
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-80]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #27
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #5
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #432]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-192]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #320]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #13
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #19
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-224]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #12
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #20
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-112]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #400]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #11
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #21
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-368]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #10
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #22
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-32]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #480]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #28
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #4
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-112]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #28
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #4
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #400]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r12, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r12, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-336]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #176]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #14
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #18
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-176]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #13
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #19
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-256]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #256]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #10
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #22
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-320]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #10
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #22
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-176]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #336]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #20
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #12
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-64]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #19
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #13
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #448]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-96]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #416]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #4
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #28
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-208]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #4
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #28
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-16]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #496]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #7
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #25
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-352]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #7
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #25
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #-416]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #-400]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #-384]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #-368]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #-352]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-400]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-384]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-368]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-352]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-336]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #-336]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #-320]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #-304]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #-288]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #-272]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-320]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-304]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-288]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-272]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #-256]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #-240]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #-224]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #-208]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #-192]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-240]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-224]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-208]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-192]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-176]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #-176]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #-160]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #-144]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #-128]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #-112]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-160]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-144]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-128]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-112]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-96]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #-96]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #-80]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #-64]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #-48]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #-32]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-80]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-64]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-48]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-32]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-16]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #160]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #112]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #128]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #144]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #160]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #240]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #192]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #208]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #224]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #240]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #320]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #272]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #288]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #304]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #320]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #400]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #352]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #368]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #384]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #400]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #416]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #416]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #432]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #448]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #464]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #480]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #432]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #448]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #464]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #480]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #496]
	umaal r0, r1, r2, r3
	vmov.i32 q0, #1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-400]
	umaal r0, r1, r2, r3
	veor q1, q1, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #-400]
	subs lr, lr, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// keccak4_mve2
.global keccak4_mve2
.type keccak4_mve2, %function
.thumb_func
.balign 16
keccak4_mve2:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov r6, r0
	add r10, r1, #508
	add r11, r1, #1524
.balign 16
1:
	vldrw.u32 q0, [r10, #-508]
	vldrw.u32 q1, [r10, #-428]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-348]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-268]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-188]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #188]
	vldrw.u32 q0, [r10, #-492]
	vldrw.u32 q1, [r10, #-412]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-332]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-252]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-172]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #204]
	vldrw.u32 q0, [r10, #-476]
	vldrw.u32 q1, [r10, #-396]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-316]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-236]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-156]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #220]
	vldrw.u32 q0, [r10, #-460]
	vldrw.u32 q1, [r10, #-380]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-300]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-220]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-140]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #236]
	vldrw.u32 q0, [r10, #-444]
	vldrw.u32 q1, [r10, #-364]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-284]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-204]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-124]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #252]
	vldrw.u32 q0, [r10, #4]
	vldrw.u32 q1, [r10, #84]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #164]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #244]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #324]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #268]
	vldrw.u32 q0, [r10, #20]
	vldrw.u32 q1, [r10, #100]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #180]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #260]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #340]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #284]
	vldrw.u32 q0, [r10, #36]
	vldrw.u32 q1, [r10, #116]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #196]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #276]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #356]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #300]
	vldrw.u32 q0, [r10, #52]
	vldrw.u32 q1, [r10, #132]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #212]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #292]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #372]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #316]
	vldrw.u32 q0, [r10, #68]
	vldrw.u32 q1, [r10, #148]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #228]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #308]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #388]
	veor q0, q0, q1
	vstrw.u32 q0, [r11, #332]
	vldrw.u32 q0, [r11, #284]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #252]
	veor q1, q1, q2
	vstrw.u32 q1, [r11, #348]
	vldrw.u32 q0, [r11, #204]
	vldrw.u32 q2, [r11, #332]
	veor q0, q0, q2
	vstrw.u32 q0, [r11, #428]
	vldrw.u32 q0, [r11, #300]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #188]
	veor q1, q1, q2
	vstrw.u32 q1, [r11, #364]
	vldrw.u32 q0, [r11, #220]
	vldrw.u32 q2, [r11, #268]
	veor q0, q0, q2
	vstrw.u32 q0, [r11, #444]
	vldrw.u32 q0, [r11, #316]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #204]
	veor q1, q1, q2
	vstrw.u32 q1, [r11, #380]
	vldrw.u32 q0, [r11, #236]
	vldrw.u32 q2, [r11, #284]
	veor q0, q0, q2
	vstrw.u32 q0, [r11, #460]
	vldrw.u32 q0, [r11, #332]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #220]
	veor q1, q1, q2
	vstrw.u32 q1, [r11, #396]
	vldrw.u32 q0, [r11, #252]
	vldrw.u32 q2, [r11, #300]
	veor q0, q0, q2
	vstrw.u32 q0, [r11, #476]
	vldrw.u32 q0, [r11, #268]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #236]
	veor q1, q1, q2
	vstrw.u32 q1, [r11, #412]
	vldrw.u32 q0, [r11, #188]
	vldrw.u32 q2, [r11, #316]
	veor q0, q0, q2
	vstrw.u32 q0, [r11, #492]
	vldrw.u32 q6, [r11, #348]
	vldrw.u32 q7, [r11, #428]
	vldrw.u32 q0, [r10, #-508]
	vldrw.u32 q1, [r10, #4]
	veor q0, q0, q6
	veor q1, q1, q7
	vorr q2, q0, q0
	vstrw.u32 q2, [r10, #404]
	vorr q3, q1, q1
	vstrw.u32 q3, [r11, #-212]
	vldrw.u32 q0, [r10, #-428]
	vldrw.u32 q1, [r10, #84]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #18
	vsri.32 q2, q0, #14
	vstrw.u32 q2, [r11, #-356]
	vshl.i32 q3, q1, #18
	vsri.32 q3, q1, #14
	vstrw.u32 q3, [r11, #44]
	vldrw.u32 q0, [r10, #-348]
	vldrw.u32 q1, [r10, #164]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #2
	vsri.32 q2, q1, #30
	vstrw.u32 q2, [r11, #-500]
	vshl.i32 q3, q0, #1
	vsri.32 q3, q0, #31
	vstrw.u32 q3, [r11, #-100]
	vldrw.u32 q0, [r10, #-268]
	vldrw.u32 q1, [r10, #244]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #21
	vsri.32 q2, q1, #11
	vstrw.u32 q2, [r11, #-244]
	vshl.i32 q3, q0, #20
	vsri.32 q3, q0, #12
	vstrw.u32 q3, [r11, #156]
	vldrw.u32 q0, [r10, #-188]
	vldrw.u32 q1, [r10, #324]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #9
	vsri.32 q2, q0, #23
	vstrw.u32 q2, [r11, #-388]
	vshl.i32 q3, q1, #9
	vsri.32 q3, q1, #23
	vstrw.u32 q3, [r11, #12]
	vldrw.u32 q6, [r11, #364]
	vldrw.u32 q7, [r11, #444]
	vldrw.u32 q0, [r10, #-492]
	vldrw.u32 q1, [r10, #20]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #1
	vsri.32 q2, q1, #31
	vstrw.u32 q2, [r11, #-452]
	vorr q3, q0, q0
	vstrw.u32 q3, [r11, #-52]
	vldrw.u32 q0, [r10, #-412]
	vldrw.u32 q1, [r10, #100]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #22
	vsri.32 q2, q0, #10
	vstrw.u32 q2, [r10, #420]
	vshl.i32 q3, q1, #22
	vsri.32 q3, q1, #10
	vstrw.u32 q3, [r11, #-196]
	vldrw.u32 q0, [r10, #-332]
	vldrw.u32 q1, [r10, #180]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #5
	vsri.32 q2, q0, #27
	vstrw.u32 q2, [r11, #-340]
	vshl.i32 q3, q1, #5
	vsri.32 q3, q1, #27
	vstrw.u32 q3, [r11, #60]
	vldrw.u32 q0, [r10, #-252]
	vldrw.u32 q1, [r10, #260]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #23
	vsri.32 q2, q1, #9
	vstrw.u32 q2, [r11, #-484]
	vshl.i32 q3, q0, #22
	vsri.32 q3, q0, #10
	vstrw.u32 q3, [r11, #-84]
	vldrw.u32 q0, [r10, #-172]
	vldrw.u32 q1, [r10, #340]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #1
	vsri.32 q2, q0, #31
	vstrw.u32 q2, [r11, #-228]
	vshl.i32 q3, q1, #1
	vsri.32 q3, q1, #31
	vstrw.u32 q3, [r11, #172]
	vldrw.u32 q6, [r11, #380]
	vldrw.u32 q7, [r11, #460]
	vldrw.u32 q0, [r10, #-476]
	vldrw.u32 q1, [r10, #36]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #31
	vsri.32 q2, q0, #1
	vstrw.u32 q2, [r11, #-292]
	vshl.i32 q3, q1, #31
	vsri.32 q3, q1, #1
	vstrw.u32 q3, [r11, #108]
	vldrw.u32 q0, [r10, #-396]
	vldrw.u32 q1, [r10, #116]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #3
	vsri.32 q2, q0, #29
	vstrw.u32 q2, [r11, #-436]
	vshl.i32 q3, q1, #3
	vsri.32 q3, q1, #29
	vstrw.u32 q3, [r11, #-36]
	vldrw.u32 q0, [r10, #-316]
	vldrw.u32 q1, [r10, #196]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #22
	vsri.32 q2, q1, #10
	vstrw.u32 q2, [r10, #436]
	vshl.i32 q3, q0, #21
	vsri.32 q3, q0, #11
	vstrw.u32 q3, [r11, #-180]
	vldrw.u32 q0, [r10, #-236]
	vldrw.u32 q1, [r10, #276]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #8
	vsri.32 q2, q1, #24
	vstrw.u32 q2, [r11, #-324]
	vshl.i32 q3, q0, #7
	vsri.32 q3, q0, #25
	vstrw.u32 q3, [r11, #76]
	vldrw.u32 q0, [r10, #-156]
	vldrw.u32 q1, [r10, #356]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #31
	vsri.32 q2, q1, #1
	vstrw.u32 q2, [r11, #-468]
	vshl.i32 q3, q0, #30
	vsri.32 q3, q0, #2
	vstrw.u32 q3, [r11, #-68]
	vldrw.u32 q6, [r11, #396]
	vldrw.u32 q7, [r11, #476]
	vldrw.u32 q0, [r10, #-460]
	vldrw.u32 q1, [r10, #52]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #14
	vsri.32 q2, q0, #18
	vstrw.u32 q2, [r10, #484]
	vshl.i32 q3, q1, #14
	vsri.32 q3, q1, #18
	vstrw.u32 q3, [r11, #-132]
	vldrw.u32 q0, [r10, #-380]
	vldrw.u32 q1, [r10, #132]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #28
	vsri.32 q2, q1, #4
	vstrw.u32 q2, [r11, #-276]
	vshl.i32 q3, q0, #27
	vsri.32 q3, q0, #5
	vstrw.u32 q3, [r11, #124]
	vldrw.u32 q0, [r10, #-300]
	vldrw.u32 q1, [r10, #212]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #13
	vsri.32 q2, q1, #19
	vstrw.u32 q2, [r11, #-420]
	vshl.i32 q3, q0, #12
	vsri.32 q3, q0, #20
	vstrw.u32 q3, [r11, #-20]
	vldrw.u32 q0, [r10, #-220]
	vldrw.u32 q1, [r10, #292]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #11
	vsri.32 q2, q1, #21
	vstrw.u32 q2, [r10, #452]
	vshl.i32 q3, q0, #10
	vsri.32 q3, q0, #22
	vstrw.u32 q3, [r11, #-164]
	vldrw.u32 q0, [r10, #-140]
	vldrw.u32 q1, [r10, #372]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #28
	vsri.32 q2, q0, #4
	vstrw.u32 q2, [r11, #-308]
	vshl.i32 q3, q1, #28
	vsri.32 q3, q1, #4
	vstrw.u32 q3, [r11, #92]
	vldrw.u32 q6, [r11, #412]
	vldrw.u32 q7, [r11, #492]
	vldrw.u32 q0, [r10, #-444]
	vldrw.u32 q1, [r10, #68]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #14
	vsri.32 q2, q1, #18
	vstrw.u32 q2, [r11, #-372]
	vshl.i32 q3, q0, #13
	vsri.32 q3, q0, #19
	vstrw.u32 q3, [r11, #28]
	vldrw.u32 q0, [r10, #-364]
	vldrw.u32 q1, [r10, #148]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #10
	vsri.32 q2, q0, #22
	vstrw.u32 q2, [r10, #500]
	vshl.i32 q3, q1, #10
	vsri.32 q3, q1, #22
	vstrw.u32 q3, [r11, #-116]
	vldrw.u32 q0, [r10, #-284]
	vldrw.u32 q1, [r10, #228]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #20
	vsri.32 q2, q1, #12
	vstrw.u32 q2, [r11, #-260]
	vshl.i32 q3, q0, #19
	vsri.32 q3, q0, #13
	vstrw.u32 q3, [r11, #140]
	vldrw.u32 q0, [r10, #-204]
	vldrw.u32 q1, [r10, #308]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #4
	vsri.32 q2, q0, #28
	vstrw.u32 q2, [r11, #-404]
	vshl.i32 q3, q1, #4
	vsri.32 q3, q1, #28
	vstrw.u32 q3, [r11, #-4]
	vldrw.u32 q0, [r10, #-124]
	vldrw.u32 q1, [r10, #388]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #7
	vsri.32 q2, q0, #25
	vstrw.u32 q2, [r10, #468]
	vshl.i32 q3, q1, #7
	vsri.32 q3, q1, #25
	vstrw.u32 q3, [r11, #-148]
	vldrw.u32 q0, [r10, #404]
	vldrw.u32 q1, [r10, #420]
	vldrw.u32 q2, [r10, #436]
	vldrw.u32 q3, [r10, #452]
	vldrw.u32 q4, [r10, #468]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #-508]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #-492]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #-476]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #-460]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #-444]
	vldrw.u32 q0, [r10, #484]
	vldrw.u32 q1, [r10, #500]
	vldrw.u32 q2, [r11, #-500]
	vldrw.u32 q3, [r11, #-484]
	vldrw.u32 q4, [r11, #-468]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #-428]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #-412]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #-396]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #-380]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #-364]
	vldrw.u32 q0, [r11, #-452]
	vldrw.u32 q1, [r11, #-436]
	vldrw.u32 q2, [r11, #-420]
	vldrw.u32 q3, [r11, #-404]
	vldrw.u32 q4, [r11, #-388]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #-348]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #-332]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #-316]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #-300]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #-284]
	vldrw.u32 q0, [r11, #-372]
	vldrw.u32 q1, [r11, #-356]
	vldrw.u32 q2, [r11, #-340]
	vldrw.u32 q3, [r11, #-324]
	vldrw.u32 q4, [r11, #-308]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #-268]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #-252]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #-236]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #-220]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #-204]
	vldrw.u32 q0, [r11, #-292]
	vldrw.u32 q1, [r11, #-276]
	vldrw.u32 q2, [r11, #-260]
	vldrw.u32 q3, [r11, #-244]
	vldrw.u32 q4, [r11, #-228]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #-188]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #-172]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #-156]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #-140]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #-124]
	vldrw.u32 q0, [r11, #-212]
	vldrw.u32 q1, [r11, #-196]
	vldrw.u32 q2, [r11, #-180]
	vldrw.u32 q3, [r11, #-164]
	vldrw.u32 q4, [r11, #-148]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #4]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #20]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #36]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #52]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #68]
	vldrw.u32 q0, [r11, #-132]
	vldrw.u32 q1, [r11, #-116]
	vldrw.u32 q2, [r11, #-100]
	vldrw.u32 q3, [r11, #-84]
	vldrw.u32 q4, [r11, #-68]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #84]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #100]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #116]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #132]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #148]
	vldrw.u32 q0, [r11, #-52]
	vldrw.u32 q1, [r11, #-36]
	vldrw.u32 q2, [r11, #-20]
	vldrw.u32 q3, [r11, #-4]
	vldrw.u32 q4, [r11, #12]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #164]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #180]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #196]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #212]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #228]
	vldrw.u32 q0, [r11, #28]
	vldrw.u32 q1, [r11, #44]
	vldrw.u32 q2, [r11, #60]
	vldrw.u32 q3, [r11, #76]
	vldrw.u32 q4, [r11, #92]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #244]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #260]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #276]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #292]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #308]
	vldrw.u32 q0, [r11, #108]
	vldrw.u32 q1, [r11, #124]
	vldrw.u32 q2, [r11, #140]
	vldrw.u32 q3, [r11, #156]
	vldrw.u32 q4, [r11, #172]
	vbic q5, q2, q1
	veor q5, q5, q0
	vstrw.u32 q5, [r10, #324]
	vbic q5, q3, q2
	veor q5, q5, q1
	vstrw.u32 q5, [r10, #340]
	vbic q5, q4, q3
	veor q5, q5, q2
	vstrw.u32 q5, [r10, #356]
	vbic q5, q0, q4
	veor q5, q5, q3
	vstrw.u32 q5, [r10, #372]
	vbic q5, q1, q0
	veor q5, q5, q4
	vstrw.u32 q5, [r10, #388]
	vmov.i32 q0, #1
	vldrw.u32 q1, [r10, #-508]
	veor q1, q1, q0
	vstrw.u32 q1, [r10, #-508]
	subs r6, r6, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// coissue2_zip
.global coissue2_zip
.type coissue2_zip, %function
.thumb_func
.balign 16
coissue2_zip:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov lr, r0
	add r10, r1, #508
	add r11, r1, #1524
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-508]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-428]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-348]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-268]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-188]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #188]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-492]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-412]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-332]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-252]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-172]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #204]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-476]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-396]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-316]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-236]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-156]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #220]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-460]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-380]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-300]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-220]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-140]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #236]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-444]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-364]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-284]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-204]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-124]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #252]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #4]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #84]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #164]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #244]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #324]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #268]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #20]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #100]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #180]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #260]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #340]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #284]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #36]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #116]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #196]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #276]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #356]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #300]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #52]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #132]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #212]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #292]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #372]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #316]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #68]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #148]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #228]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #308]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #388]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #332]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #284]
	umaal r0, r1, r2, r3
	vshl.i32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #252]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r11, #348]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #204]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #332]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #428]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #300]
	umaal r0, r1, r2, r3
	vshl.i32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #188]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r11, #364]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #220]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #268]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #444]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #316]
	umaal r0, r1, r2, r3
	vshl.i32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #204]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r11, #380]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #236]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #284]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #460]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #332]
	umaal r0, r1, r2, r3
	vshl.i32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #220]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r11, #396]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #252]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #300]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #476]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #268]
	umaal r0, r1, r2, r3
	vshl.i32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #236]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r11, #412]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #188]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #316]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #492]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r11, #348]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r11, #428]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-508]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #4]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vorr q2, q0, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r10, #404]
	umaal r0, r1, r2, r3
	vorr q3, q1, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #-212]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-428]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #84]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #18
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #14
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-356]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #18
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #14
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #44]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-348]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #164]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #2
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #30
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-500]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #31
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #-100]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-268]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #244]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #21
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #11
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-244]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #20
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #12
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #156]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-188]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #324]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #9
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #23
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-388]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #9
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #23
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #12]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r11, #364]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r11, #444]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-492]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #20]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #1
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #31
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-452]
	umaal r0, r1, r2, r3
	vorr q3, q0, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #-52]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-412]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #100]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #22
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #10
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r10, #420]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #22
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #10
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #-196]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-332]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #180]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #5
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #27
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-340]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #5
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #27
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #60]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-252]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #260]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #23
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #9
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-484]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #22
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #10
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #-84]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-172]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #340]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #31
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-228]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #1
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #31
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #172]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r11, #380]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r11, #460]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-476]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #36]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #31
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #1
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-292]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #31
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #1
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #108]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-396]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #116]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #3
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #29
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-436]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #3
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #29
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #-36]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-316]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #196]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #22
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #10
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r10, #436]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #21
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #11
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #-180]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-236]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #276]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #8
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #24
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-324]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #7
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #25
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #76]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-156]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #356]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #31
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #1
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-468]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #30
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #2
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #-68]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r11, #396]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r11, #476]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-460]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #52]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #14
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #18
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r10, #484]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #14
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #18
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #-132]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-380]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #132]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #28
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #4
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-276]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #27
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #5
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #124]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-300]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #212]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #13
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #19
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-420]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #12
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #20
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #-20]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-220]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #292]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #11
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #21
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r10, #452]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #10
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #22
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #-164]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-140]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #372]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #28
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #4
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-308]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #28
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #4
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #92]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r11, #412]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r11, #492]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-444]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #68]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #14
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #18
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-372]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #13
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #19
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #28]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-364]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #148]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #10
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #22
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r10, #500]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #10
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #22
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #-116]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-284]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #228]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #20
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #12
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-260]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #19
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #13
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #140]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-204]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #308]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #4
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #28
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r11, #-404]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #4
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #28
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #-4]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-124]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #388]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #7
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #25
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r10, #468]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #7
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #25
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r11, #-148]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #404]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #420]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r10, #436]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r10, #452]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r10, #468]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-508]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-492]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-476]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-460]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-444]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #484]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #500]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #-500]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #-484]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #-468]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-428]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-412]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-396]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-380]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-364]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #-452]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #-436]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #-420]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #-404]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #-388]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-348]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-332]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-316]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-300]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-284]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #-372]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #-356]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #-340]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #-324]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #-308]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-268]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-252]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-236]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-220]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-204]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #-292]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #-276]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #-260]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #-244]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #-228]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-188]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-172]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-156]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-140]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #-124]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #-212]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #-196]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #-180]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #-164]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #-148]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #4]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #20]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #36]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #52]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #68]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #-132]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #-116]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #-100]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #-84]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #-68]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #84]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #100]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #116]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #132]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #148]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #-52]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #-36]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #-20]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #-4]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #12]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #164]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #180]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #196]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #212]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #228]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #28]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #44]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #60]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #76]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #92]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #244]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #260]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #276]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #292]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #308]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #108]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r11, #124]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #140]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r11, #156]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r11, #172]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #324]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #340]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #356]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #372]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r10, #388]
	umaal r0, r1, r2, r3
	vmov.i32 q0, #1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #-508]
	umaal r0, r1, r2, r3
	veor q1, q1, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #-508]
	subs lr, lr, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// 실험 H: 레인 전치 글루 (r0=flat, r1=packed)
.global pack4_lane
.type pack4_lane, %function
.thumb_func
.balign 16
pack4_lane:
	push {r4-r7, lr}
	ldr r6, [r0, #0]
	str r6, [r1, #0]
	ldr r6, [r0, #200]
	str r6, [r1, #4]
	ldr r6, [r0, #400]
	str r6, [r1, #8]
	ldr r6, [r0, #600]
	str r6, [r1, #12]
	ldr r6, [r0, #4]
	str r6, [r1, #16]
	ldr r6, [r0, #204]
	str r6, [r1, #20]
	ldr r6, [r0, #404]
	str r6, [r1, #24]
	ldr r6, [r0, #604]
	str r6, [r1, #28]
	ldr r6, [r0, #8]
	str r6, [r1, #32]
	ldr r6, [r0, #208]
	str r6, [r1, #36]
	ldr r6, [r0, #408]
	str r6, [r1, #40]
	ldr r6, [r0, #608]
	str r6, [r1, #44]
	ldr r6, [r0, #12]
	str r6, [r1, #48]
	ldr r6, [r0, #212]
	str r6, [r1, #52]
	ldr r6, [r0, #412]
	str r6, [r1, #56]
	ldr r6, [r0, #612]
	str r6, [r1, #60]
	ldr r6, [r0, #16]
	str r6, [r1, #64]
	ldr r6, [r0, #216]
	str r6, [r1, #68]
	ldr r6, [r0, #416]
	str r6, [r1, #72]
	ldr r6, [r0, #616]
	str r6, [r1, #76]
	ldr r6, [r0, #20]
	str r6, [r1, #80]
	ldr r6, [r0, #220]
	str r6, [r1, #84]
	ldr r6, [r0, #420]
	str r6, [r1, #88]
	ldr r6, [r0, #620]
	str r6, [r1, #92]
	ldr r6, [r0, #24]
	str r6, [r1, #96]
	ldr r6, [r0, #224]
	str r6, [r1, #100]
	ldr r6, [r0, #424]
	str r6, [r1, #104]
	ldr r6, [r0, #624]
	str r6, [r1, #108]
	ldr r6, [r0, #28]
	str r6, [r1, #112]
	ldr r6, [r0, #228]
	str r6, [r1, #116]
	ldr r6, [r0, #428]
	str r6, [r1, #120]
	ldr r6, [r0, #628]
	str r6, [r1, #124]
	ldr r6, [r0, #32]
	str r6, [r1, #128]
	ldr r6, [r0, #232]
	str r6, [r1, #132]
	ldr r6, [r0, #432]
	str r6, [r1, #136]
	ldr r6, [r0, #632]
	str r6, [r1, #140]
	ldr r6, [r0, #36]
	str r6, [r1, #144]
	ldr r6, [r0, #236]
	str r6, [r1, #148]
	ldr r6, [r0, #436]
	str r6, [r1, #152]
	ldr r6, [r0, #636]
	str r6, [r1, #156]
	ldr r6, [r0, #40]
	str r6, [r1, #160]
	ldr r6, [r0, #240]
	str r6, [r1, #164]
	ldr r6, [r0, #440]
	str r6, [r1, #168]
	ldr r6, [r0, #640]
	str r6, [r1, #172]
	ldr r6, [r0, #44]
	str r6, [r1, #176]
	ldr r6, [r0, #244]
	str r6, [r1, #180]
	ldr r6, [r0, #444]
	str r6, [r1, #184]
	ldr r6, [r0, #644]
	str r6, [r1, #188]
	ldr r6, [r0, #48]
	str r6, [r1, #192]
	ldr r6, [r0, #248]
	str r6, [r1, #196]
	ldr r6, [r0, #448]
	str r6, [r1, #200]
	ldr r6, [r0, #648]
	str r6, [r1, #204]
	ldr r6, [r0, #52]
	str r6, [r1, #208]
	ldr r6, [r0, #252]
	str r6, [r1, #212]
	ldr r6, [r0, #452]
	str r6, [r1, #216]
	ldr r6, [r0, #652]
	str r6, [r1, #220]
	ldr r6, [r0, #56]
	str r6, [r1, #224]
	ldr r6, [r0, #256]
	str r6, [r1, #228]
	ldr r6, [r0, #456]
	str r6, [r1, #232]
	ldr r6, [r0, #656]
	str r6, [r1, #236]
	ldr r6, [r0, #60]
	str r6, [r1, #240]
	ldr r6, [r0, #260]
	str r6, [r1, #244]
	ldr r6, [r0, #460]
	str r6, [r1, #248]
	ldr r6, [r0, #660]
	str r6, [r1, #252]
	ldr r6, [r0, #64]
	str r6, [r1, #256]
	ldr r6, [r0, #264]
	str r6, [r1, #260]
	ldr r6, [r0, #464]
	str r6, [r1, #264]
	ldr r6, [r0, #664]
	str r6, [r1, #268]
	ldr r6, [r0, #68]
	str r6, [r1, #272]
	ldr r6, [r0, #268]
	str r6, [r1, #276]
	ldr r6, [r0, #468]
	str r6, [r1, #280]
	ldr r6, [r0, #668]
	str r6, [r1, #284]
	ldr r6, [r0, #72]
	str r6, [r1, #288]
	ldr r6, [r0, #272]
	str r6, [r1, #292]
	ldr r6, [r0, #472]
	str r6, [r1, #296]
	ldr r6, [r0, #672]
	str r6, [r1, #300]
	ldr r6, [r0, #76]
	str r6, [r1, #304]
	ldr r6, [r0, #276]
	str r6, [r1, #308]
	ldr r6, [r0, #476]
	str r6, [r1, #312]
	ldr r6, [r0, #676]
	str r6, [r1, #316]
	ldr r6, [r0, #80]
	str r6, [r1, #320]
	ldr r6, [r0, #280]
	str r6, [r1, #324]
	ldr r6, [r0, #480]
	str r6, [r1, #328]
	ldr r6, [r0, #680]
	str r6, [r1, #332]
	ldr r6, [r0, #84]
	str r6, [r1, #336]
	ldr r6, [r0, #284]
	str r6, [r1, #340]
	ldr r6, [r0, #484]
	str r6, [r1, #344]
	ldr r6, [r0, #684]
	str r6, [r1, #348]
	ldr r6, [r0, #88]
	str r6, [r1, #352]
	ldr r6, [r0, #288]
	str r6, [r1, #356]
	ldr r6, [r0, #488]
	str r6, [r1, #360]
	ldr r6, [r0, #688]
	str r6, [r1, #364]
	ldr r6, [r0, #92]
	str r6, [r1, #368]
	ldr r6, [r0, #292]
	str r6, [r1, #372]
	ldr r6, [r0, #492]
	str r6, [r1, #376]
	ldr r6, [r0, #692]
	str r6, [r1, #380]
	ldr r6, [r0, #96]
	str r6, [r1, #384]
	ldr r6, [r0, #296]
	str r6, [r1, #388]
	ldr r6, [r0, #496]
	str r6, [r1, #392]
	ldr r6, [r0, #696]
	str r6, [r1, #396]
	ldr r6, [r0, #100]
	str r6, [r1, #512]
	ldr r6, [r0, #300]
	str r6, [r1, #516]
	ldr r6, [r0, #500]
	str r6, [r1, #520]
	ldr r6, [r0, #700]
	str r6, [r1, #524]
	ldr r6, [r0, #104]
	str r6, [r1, #528]
	ldr r6, [r0, #304]
	str r6, [r1, #532]
	ldr r6, [r0, #504]
	str r6, [r1, #536]
	ldr r6, [r0, #704]
	str r6, [r1, #540]
	ldr r6, [r0, #108]
	str r6, [r1, #544]
	ldr r6, [r0, #308]
	str r6, [r1, #548]
	ldr r6, [r0, #508]
	str r6, [r1, #552]
	ldr r6, [r0, #708]
	str r6, [r1, #556]
	ldr r6, [r0, #112]
	str r6, [r1, #560]
	ldr r6, [r0, #312]
	str r6, [r1, #564]
	ldr r6, [r0, #512]
	str r6, [r1, #568]
	ldr r6, [r0, #712]
	str r6, [r1, #572]
	ldr r6, [r0, #116]
	str r6, [r1, #576]
	ldr r6, [r0, #316]
	str r6, [r1, #580]
	ldr r6, [r0, #516]
	str r6, [r1, #584]
	ldr r6, [r0, #716]
	str r6, [r1, #588]
	ldr r6, [r0, #120]
	str r6, [r1, #592]
	ldr r6, [r0, #320]
	str r6, [r1, #596]
	ldr r6, [r0, #520]
	str r6, [r1, #600]
	ldr r6, [r0, #720]
	str r6, [r1, #604]
	ldr r6, [r0, #124]
	str r6, [r1, #608]
	ldr r6, [r0, #324]
	str r6, [r1, #612]
	ldr r6, [r0, #524]
	str r6, [r1, #616]
	ldr r6, [r0, #724]
	str r6, [r1, #620]
	ldr r6, [r0, #128]
	str r6, [r1, #624]
	ldr r6, [r0, #328]
	str r6, [r1, #628]
	ldr r6, [r0, #528]
	str r6, [r1, #632]
	ldr r6, [r0, #728]
	str r6, [r1, #636]
	ldr r6, [r0, #132]
	str r6, [r1, #640]
	ldr r6, [r0, #332]
	str r6, [r1, #644]
	ldr r6, [r0, #532]
	str r6, [r1, #648]
	ldr r6, [r0, #732]
	str r6, [r1, #652]
	ldr r6, [r0, #136]
	str r6, [r1, #656]
	ldr r6, [r0, #336]
	str r6, [r1, #660]
	ldr r6, [r0, #536]
	str r6, [r1, #664]
	ldr r6, [r0, #736]
	str r6, [r1, #668]
	ldr r6, [r0, #140]
	str r6, [r1, #672]
	ldr r6, [r0, #340]
	str r6, [r1, #676]
	ldr r6, [r0, #540]
	str r6, [r1, #680]
	ldr r6, [r0, #740]
	str r6, [r1, #684]
	ldr r6, [r0, #144]
	str r6, [r1, #688]
	ldr r6, [r0, #344]
	str r6, [r1, #692]
	ldr r6, [r0, #544]
	str r6, [r1, #696]
	ldr r6, [r0, #744]
	str r6, [r1, #700]
	ldr r6, [r0, #148]
	str r6, [r1, #704]
	ldr r6, [r0, #348]
	str r6, [r1, #708]
	ldr r6, [r0, #548]
	str r6, [r1, #712]
	ldr r6, [r0, #748]
	str r6, [r1, #716]
	ldr r6, [r0, #152]
	str r6, [r1, #720]
	ldr r6, [r0, #352]
	str r6, [r1, #724]
	ldr r6, [r0, #552]
	str r6, [r1, #728]
	ldr r6, [r0, #752]
	str r6, [r1, #732]
	ldr r6, [r0, #156]
	str r6, [r1, #736]
	ldr r6, [r0, #356]
	str r6, [r1, #740]
	ldr r6, [r0, #556]
	str r6, [r1, #744]
	ldr r6, [r0, #756]
	str r6, [r1, #748]
	ldr r6, [r0, #160]
	str r6, [r1, #752]
	ldr r6, [r0, #360]
	str r6, [r1, #756]
	ldr r6, [r0, #560]
	str r6, [r1, #760]
	ldr r6, [r0, #760]
	str r6, [r1, #764]
	ldr r6, [r0, #164]
	str r6, [r1, #768]
	ldr r6, [r0, #364]
	str r6, [r1, #772]
	ldr r6, [r0, #564]
	str r6, [r1, #776]
	ldr r6, [r0, #764]
	str r6, [r1, #780]
	ldr r6, [r0, #168]
	str r6, [r1, #784]
	ldr r6, [r0, #368]
	str r6, [r1, #788]
	ldr r6, [r0, #568]
	str r6, [r1, #792]
	ldr r6, [r0, #768]
	str r6, [r1, #796]
	ldr r6, [r0, #172]
	str r6, [r1, #800]
	ldr r6, [r0, #372]
	str r6, [r1, #804]
	ldr r6, [r0, #572]
	str r6, [r1, #808]
	ldr r6, [r0, #772]
	str r6, [r1, #812]
	ldr r6, [r0, #176]
	str r6, [r1, #816]
	ldr r6, [r0, #376]
	str r6, [r1, #820]
	ldr r6, [r0, #576]
	str r6, [r1, #824]
	ldr r6, [r0, #776]
	str r6, [r1, #828]
	ldr r6, [r0, #180]
	str r6, [r1, #832]
	ldr r6, [r0, #380]
	str r6, [r1, #836]
	ldr r6, [r0, #580]
	str r6, [r1, #840]
	ldr r6, [r0, #780]
	str r6, [r1, #844]
	ldr r6, [r0, #184]
	str r6, [r1, #848]
	ldr r6, [r0, #384]
	str r6, [r1, #852]
	ldr r6, [r0, #584]
	str r6, [r1, #856]
	ldr r6, [r0, #784]
	str r6, [r1, #860]
	ldr r6, [r0, #188]
	str r6, [r1, #864]
	ldr r6, [r0, #388]
	str r6, [r1, #868]
	ldr r6, [r0, #588]
	str r6, [r1, #872]
	ldr r6, [r0, #788]
	str r6, [r1, #876]
	ldr r6, [r0, #192]
	str r6, [r1, #880]
	ldr r6, [r0, #392]
	str r6, [r1, #884]
	ldr r6, [r0, #592]
	str r6, [r1, #888]
	ldr r6, [r0, #792]
	str r6, [r1, #892]
	ldr r6, [r0, #196]
	str r6, [r1, #896]
	ldr r6, [r0, #396]
	str r6, [r1, #900]
	ldr r6, [r0, #596]
	str r6, [r1, #904]
	ldr r6, [r0, #796]
	str r6, [r1, #908]
	pop {r4-r7, pc}

.global unpack4_lane
.type unpack4_lane, %function
.thumb_func
.balign 16
unpack4_lane:
	push {r4-r7, lr}
	ldr r6, [r0, #0]
	str r6, [r1, #0]
	ldr r6, [r0, #4]
	str r6, [r1, #200]
	ldr r6, [r0, #8]
	str r6, [r1, #400]
	ldr r6, [r0, #12]
	str r6, [r1, #600]
	ldr r6, [r0, #16]
	str r6, [r1, #4]
	ldr r6, [r0, #20]
	str r6, [r1, #204]
	ldr r6, [r0, #24]
	str r6, [r1, #404]
	ldr r6, [r0, #28]
	str r6, [r1, #604]
	ldr r6, [r0, #32]
	str r6, [r1, #8]
	ldr r6, [r0, #36]
	str r6, [r1, #208]
	ldr r6, [r0, #40]
	str r6, [r1, #408]
	ldr r6, [r0, #44]
	str r6, [r1, #608]
	ldr r6, [r0, #48]
	str r6, [r1, #12]
	ldr r6, [r0, #52]
	str r6, [r1, #212]
	ldr r6, [r0, #56]
	str r6, [r1, #412]
	ldr r6, [r0, #60]
	str r6, [r1, #612]
	ldr r6, [r0, #64]
	str r6, [r1, #16]
	ldr r6, [r0, #68]
	str r6, [r1, #216]
	ldr r6, [r0, #72]
	str r6, [r1, #416]
	ldr r6, [r0, #76]
	str r6, [r1, #616]
	ldr r6, [r0, #80]
	str r6, [r1, #20]
	ldr r6, [r0, #84]
	str r6, [r1, #220]
	ldr r6, [r0, #88]
	str r6, [r1, #420]
	ldr r6, [r0, #92]
	str r6, [r1, #620]
	ldr r6, [r0, #96]
	str r6, [r1, #24]
	ldr r6, [r0, #100]
	str r6, [r1, #224]
	ldr r6, [r0, #104]
	str r6, [r1, #424]
	ldr r6, [r0, #108]
	str r6, [r1, #624]
	ldr r6, [r0, #112]
	str r6, [r1, #28]
	ldr r6, [r0, #116]
	str r6, [r1, #228]
	ldr r6, [r0, #120]
	str r6, [r1, #428]
	ldr r6, [r0, #124]
	str r6, [r1, #628]
	ldr r6, [r0, #128]
	str r6, [r1, #32]
	ldr r6, [r0, #132]
	str r6, [r1, #232]
	ldr r6, [r0, #136]
	str r6, [r1, #432]
	ldr r6, [r0, #140]
	str r6, [r1, #632]
	ldr r6, [r0, #144]
	str r6, [r1, #36]
	ldr r6, [r0, #148]
	str r6, [r1, #236]
	ldr r6, [r0, #152]
	str r6, [r1, #436]
	ldr r6, [r0, #156]
	str r6, [r1, #636]
	ldr r6, [r0, #160]
	str r6, [r1, #40]
	ldr r6, [r0, #164]
	str r6, [r1, #240]
	ldr r6, [r0, #168]
	str r6, [r1, #440]
	ldr r6, [r0, #172]
	str r6, [r1, #640]
	ldr r6, [r0, #176]
	str r6, [r1, #44]
	ldr r6, [r0, #180]
	str r6, [r1, #244]
	ldr r6, [r0, #184]
	str r6, [r1, #444]
	ldr r6, [r0, #188]
	str r6, [r1, #644]
	ldr r6, [r0, #192]
	str r6, [r1, #48]
	ldr r6, [r0, #196]
	str r6, [r1, #248]
	ldr r6, [r0, #200]
	str r6, [r1, #448]
	ldr r6, [r0, #204]
	str r6, [r1, #648]
	ldr r6, [r0, #208]
	str r6, [r1, #52]
	ldr r6, [r0, #212]
	str r6, [r1, #252]
	ldr r6, [r0, #216]
	str r6, [r1, #452]
	ldr r6, [r0, #220]
	str r6, [r1, #652]
	ldr r6, [r0, #224]
	str r6, [r1, #56]
	ldr r6, [r0, #228]
	str r6, [r1, #256]
	ldr r6, [r0, #232]
	str r6, [r1, #456]
	ldr r6, [r0, #236]
	str r6, [r1, #656]
	ldr r6, [r0, #240]
	str r6, [r1, #60]
	ldr r6, [r0, #244]
	str r6, [r1, #260]
	ldr r6, [r0, #248]
	str r6, [r1, #460]
	ldr r6, [r0, #252]
	str r6, [r1, #660]
	ldr r6, [r0, #256]
	str r6, [r1, #64]
	ldr r6, [r0, #260]
	str r6, [r1, #264]
	ldr r6, [r0, #264]
	str r6, [r1, #464]
	ldr r6, [r0, #268]
	str r6, [r1, #664]
	ldr r6, [r0, #272]
	str r6, [r1, #68]
	ldr r6, [r0, #276]
	str r6, [r1, #268]
	ldr r6, [r0, #280]
	str r6, [r1, #468]
	ldr r6, [r0, #284]
	str r6, [r1, #668]
	ldr r6, [r0, #288]
	str r6, [r1, #72]
	ldr r6, [r0, #292]
	str r6, [r1, #272]
	ldr r6, [r0, #296]
	str r6, [r1, #472]
	ldr r6, [r0, #300]
	str r6, [r1, #672]
	ldr r6, [r0, #304]
	str r6, [r1, #76]
	ldr r6, [r0, #308]
	str r6, [r1, #276]
	ldr r6, [r0, #312]
	str r6, [r1, #476]
	ldr r6, [r0, #316]
	str r6, [r1, #676]
	ldr r6, [r0, #320]
	str r6, [r1, #80]
	ldr r6, [r0, #324]
	str r6, [r1, #280]
	ldr r6, [r0, #328]
	str r6, [r1, #480]
	ldr r6, [r0, #332]
	str r6, [r1, #680]
	ldr r6, [r0, #336]
	str r6, [r1, #84]
	ldr r6, [r0, #340]
	str r6, [r1, #284]
	ldr r6, [r0, #344]
	str r6, [r1, #484]
	ldr r6, [r0, #348]
	str r6, [r1, #684]
	ldr r6, [r0, #352]
	str r6, [r1, #88]
	ldr r6, [r0, #356]
	str r6, [r1, #288]
	ldr r6, [r0, #360]
	str r6, [r1, #488]
	ldr r6, [r0, #364]
	str r6, [r1, #688]
	ldr r6, [r0, #368]
	str r6, [r1, #92]
	ldr r6, [r0, #372]
	str r6, [r1, #292]
	ldr r6, [r0, #376]
	str r6, [r1, #492]
	ldr r6, [r0, #380]
	str r6, [r1, #692]
	ldr r6, [r0, #384]
	str r6, [r1, #96]
	ldr r6, [r0, #388]
	str r6, [r1, #296]
	ldr r6, [r0, #392]
	str r6, [r1, #496]
	ldr r6, [r0, #396]
	str r6, [r1, #696]
	ldr r6, [r0, #512]
	str r6, [r1, #100]
	ldr r6, [r0, #516]
	str r6, [r1, #300]
	ldr r6, [r0, #520]
	str r6, [r1, #500]
	ldr r6, [r0, #524]
	str r6, [r1, #700]
	ldr r6, [r0, #528]
	str r6, [r1, #104]
	ldr r6, [r0, #532]
	str r6, [r1, #304]
	ldr r6, [r0, #536]
	str r6, [r1, #504]
	ldr r6, [r0, #540]
	str r6, [r1, #704]
	ldr r6, [r0, #544]
	str r6, [r1, #108]
	ldr r6, [r0, #548]
	str r6, [r1, #308]
	ldr r6, [r0, #552]
	str r6, [r1, #508]
	ldr r6, [r0, #556]
	str r6, [r1, #708]
	ldr r6, [r0, #560]
	str r6, [r1, #112]
	ldr r6, [r0, #564]
	str r6, [r1, #312]
	ldr r6, [r0, #568]
	str r6, [r1, #512]
	ldr r6, [r0, #572]
	str r6, [r1, #712]
	ldr r6, [r0, #576]
	str r6, [r1, #116]
	ldr r6, [r0, #580]
	str r6, [r1, #316]
	ldr r6, [r0, #584]
	str r6, [r1, #516]
	ldr r6, [r0, #588]
	str r6, [r1, #716]
	ldr r6, [r0, #592]
	str r6, [r1, #120]
	ldr r6, [r0, #596]
	str r6, [r1, #320]
	ldr r6, [r0, #600]
	str r6, [r1, #520]
	ldr r6, [r0, #604]
	str r6, [r1, #720]
	ldr r6, [r0, #608]
	str r6, [r1, #124]
	ldr r6, [r0, #612]
	str r6, [r1, #324]
	ldr r6, [r0, #616]
	str r6, [r1, #524]
	ldr r6, [r0, #620]
	str r6, [r1, #724]
	ldr r6, [r0, #624]
	str r6, [r1, #128]
	ldr r6, [r0, #628]
	str r6, [r1, #328]
	ldr r6, [r0, #632]
	str r6, [r1, #528]
	ldr r6, [r0, #636]
	str r6, [r1, #728]
	ldr r6, [r0, #640]
	str r6, [r1, #132]
	ldr r6, [r0, #644]
	str r6, [r1, #332]
	ldr r6, [r0, #648]
	str r6, [r1, #532]
	ldr r6, [r0, #652]
	str r6, [r1, #732]
	ldr r6, [r0, #656]
	str r6, [r1, #136]
	ldr r6, [r0, #660]
	str r6, [r1, #336]
	ldr r6, [r0, #664]
	str r6, [r1, #536]
	ldr r6, [r0, #668]
	str r6, [r1, #736]
	ldr r6, [r0, #672]
	str r6, [r1, #140]
	ldr r6, [r0, #676]
	str r6, [r1, #340]
	ldr r6, [r0, #680]
	str r6, [r1, #540]
	ldr r6, [r0, #684]
	str r6, [r1, #740]
	ldr r6, [r0, #688]
	str r6, [r1, #144]
	ldr r6, [r0, #692]
	str r6, [r1, #344]
	ldr r6, [r0, #696]
	str r6, [r1, #544]
	ldr r6, [r0, #700]
	str r6, [r1, #744]
	ldr r6, [r0, #704]
	str r6, [r1, #148]
	ldr r6, [r0, #708]
	str r6, [r1, #348]
	ldr r6, [r0, #712]
	str r6, [r1, #548]
	ldr r6, [r0, #716]
	str r6, [r1, #748]
	ldr r6, [r0, #720]
	str r6, [r1, #152]
	ldr r6, [r0, #724]
	str r6, [r1, #352]
	ldr r6, [r0, #728]
	str r6, [r1, #552]
	ldr r6, [r0, #732]
	str r6, [r1, #752]
	ldr r6, [r0, #736]
	str r6, [r1, #156]
	ldr r6, [r0, #740]
	str r6, [r1, #356]
	ldr r6, [r0, #744]
	str r6, [r1, #556]
	ldr r6, [r0, #748]
	str r6, [r1, #756]
	ldr r6, [r0, #752]
	str r6, [r1, #160]
	ldr r6, [r0, #756]
	str r6, [r1, #360]
	ldr r6, [r0, #760]
	str r6, [r1, #560]
	ldr r6, [r0, #764]
	str r6, [r1, #760]
	ldr r6, [r0, #768]
	str r6, [r1, #164]
	ldr r6, [r0, #772]
	str r6, [r1, #364]
	ldr r6, [r0, #776]
	str r6, [r1, #564]
	ldr r6, [r0, #780]
	str r6, [r1, #764]
	ldr r6, [r0, #784]
	str r6, [r1, #168]
	ldr r6, [r0, #788]
	str r6, [r1, #368]
	ldr r6, [r0, #792]
	str r6, [r1, #568]
	ldr r6, [r0, #796]
	str r6, [r1, #768]
	ldr r6, [r0, #800]
	str r6, [r1, #172]
	ldr r6, [r0, #804]
	str r6, [r1, #372]
	ldr r6, [r0, #808]
	str r6, [r1, #572]
	ldr r6, [r0, #812]
	str r6, [r1, #772]
	ldr r6, [r0, #816]
	str r6, [r1, #176]
	ldr r6, [r0, #820]
	str r6, [r1, #376]
	ldr r6, [r0, #824]
	str r6, [r1, #576]
	ldr r6, [r0, #828]
	str r6, [r1, #776]
	ldr r6, [r0, #832]
	str r6, [r1, #180]
	ldr r6, [r0, #836]
	str r6, [r1, #380]
	ldr r6, [r0, #840]
	str r6, [r1, #580]
	ldr r6, [r0, #844]
	str r6, [r1, #780]
	ldr r6, [r0, #848]
	str r6, [r1, #184]
	ldr r6, [r0, #852]
	str r6, [r1, #384]
	ldr r6, [r0, #856]
	str r6, [r1, #584]
	ldr r6, [r0, #860]
	str r6, [r1, #784]
	ldr r6, [r0, #864]
	str r6, [r1, #188]
	ldr r6, [r0, #868]
	str r6, [r1, #388]
	ldr r6, [r0, #872]
	str r6, [r1, #588]
	ldr r6, [r0, #876]
	str r6, [r1, #788]
	ldr r6, [r0, #880]
	str r6, [r1, #192]
	ldr r6, [r0, #884]
	str r6, [r1, #392]
	ldr r6, [r0, #888]
	str r6, [r1, #592]
	ldr r6, [r0, #892]
	str r6, [r1, #792]
	ldr r6, [r0, #896]
	str r6, [r1, #196]
	ldr r6, [r0, #900]
	str r6, [r1, #396]
	ldr r6, [r0, #904]
	str r6, [r1, #596]
	ldr r6, [r0, #908]
	str r6, [r1, #796]
	pop {r4-r7, pc}

