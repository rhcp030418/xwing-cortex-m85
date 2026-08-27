// 실험 F-solver: 스칼라 MAC 체인 × MVE 4-way 라운드 (코이슈, 1:1 지퍼 입력)
// A=611 scalar, B=611 vector
start:
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #80]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #160]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #240]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #320]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #96]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #176]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #256]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #336]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #112]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #192]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #272]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #352]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #128]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #208]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #288]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #368]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #144]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #224]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #304]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #384]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r7, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #80]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #160]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #240]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #320]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r7, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #96]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #176]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #256]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #336]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r7, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #112]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #192]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #272]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #352]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r7, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #128]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #208]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #288]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #368]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r7, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #144]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #224]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #304]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #384]
	umaal r0, r1, r2, r3
	veor q0, q0, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #96]
	umaal r0, r1, r2, r3
	vshl.i32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #64]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r11, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #144]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #112]
	umaal r0, r1, r2, r3
	vshl.i32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #0]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r11, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #80]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #128]
	umaal r0, r1, r2, r3
	vshl.i32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #16]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r11, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #96]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #144]
	umaal r0, r1, r2, r3
	vshl.i32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #32]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r11, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #112]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #80]
	umaal r0, r1, r2, r3
	vshl.i32 q1, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q1, q0, #31
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #48]
	umaal r0, r1, r2, r3
	veor q1, q1, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r11, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r11, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r11, #128]
	umaal r0, r1, r2, r3
	veor q0, q0, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r11, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r11, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r11, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #0]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vorr.u32 q2, q0, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #0]
	umaal r0, r1, r2, r3
	vorr.u32 q3, q1, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #80]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #18
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #14
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #256]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #18
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #14
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #160]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #2
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #30
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #112]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #31
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #240]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #21
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #11
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #368]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #20
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #12
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #320]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #9
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #23
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #224]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #9
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #23
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r11, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r11, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #16]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #1
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #31
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #160]
	umaal r0, r1, r2, r3
	vorr.u32 q3, q0, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #96]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #22
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #10
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #16]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #22
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #10
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #176]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #5
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #27
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #272]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #5
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #27
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #256]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #23
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #9
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #128]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #22
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #10
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #336]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #1
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #31
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #384]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #1
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #31
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r11, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r11, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #32]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #31
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #1
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #320]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #31
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #1
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #112]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #3
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #29
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #176]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #3
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #29
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #192]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #22
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #10
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #32]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #21
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #11
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #272]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #8
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #24
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #288]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #7
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #25
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #352]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #31
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #1
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #144]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #30
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #2
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r11, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r11, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #48]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #14
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #18
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #80]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #14
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #18
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #128]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #28
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #4
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #336]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #27
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #5
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #208]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #13
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #19
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #192]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #12
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #20
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #288]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #11
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #21
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #48]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #10
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #22
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #368]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #28
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #4
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #304]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #28
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #4
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q6, [r11, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q7, [r11, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #64]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #14
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #18
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #240]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #13
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #19
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #144]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #10
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #22
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #96]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #10
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #22
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #224]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q1, #20
	umaal r0, r1, r2, r3
	vsri.32 q2, q1, #12
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #352]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q0, #19
	umaal r0, r1, r2, r3
	vsri.32 q3, q0, #13
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #304]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #4
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #28
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #208]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #4
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #28
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r7, #384]
	umaal r0, r1, r2, r3
	veor q0, q0, q6
	umaal r0, r1, r2, r3
	veor q1, q1, q7
	umaal r0, r1, r2, r3
	vshl.i32 q2, q0, #7
	umaal r0, r1, r2, r3
	vsri.32 q2, q0, #25
	umaal r0, r1, r2, r3
	vstrw.u32 q2, [r9, #64]
	umaal r0, r1, r2, r3
	vshl.i32 q3, q1, #7
	umaal r0, r1, r2, r3
	vsri.32 q3, q1, #25
	umaal r0, r1, r2, r3
	vstrw.u32 q3, [r10, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r9, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r9, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r9, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r9, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r9, #64]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #0]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #16]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #32]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #48]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r9, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r9, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r9, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r9, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r9, #144]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #80]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #96]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #112]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #128]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r9, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r9, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r9, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r9, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r9, #224]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #160]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #176]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #192]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #208]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r9, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r9, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r9, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r9, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r9, #304]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #240]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #256]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #272]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #288]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r9, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r9, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r9, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r9, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r9, #384]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #320]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #336]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #352]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #368]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r6, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #0]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #16]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r10, #32]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r10, #48]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r10, #64]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #0]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #16]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #32]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #48]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #64]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #80]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #96]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r10, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r10, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r10, #144]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #80]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #96]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #112]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #128]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r10, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r10, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r10, #224]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #160]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #176]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #192]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #208]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r10, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r10, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r10, #304]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #240]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #256]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #272]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #288]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q2, [r10, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q3, [r10, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q4, [r10, #384]
	umaal r0, r1, r2, r3
	vbic q5, q2, q1
	umaal r0, r1, r2, r3
	veor q5, q5, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #320]
	umaal r0, r1, r2, r3
	vbic q5, q3, q2
	umaal r0, r1, r2, r3
	veor q5, q5, q1
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #336]
	umaal r0, r1, r2, r3
	vbic q5, q4, q3
	umaal r0, r1, r2, r3
	veor q5, q5, q2
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #352]
	umaal r0, r1, r2, r3
	vbic q5, q0, q4
	umaal r0, r1, r2, r3
	veor q5, q5, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #368]
	umaal r0, r1, r2, r3
	vbic q5, q1, q0
	umaal r0, r1, r2, r3
	veor q5, q5, q4
	umaal r0, r1, r2, r3
	vstrw.u32 q5, [r7, #384]
	umaal r0, r1, r2, r3
	vmov.i32 q0, #1
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r6, #0]
	umaal r0, r1, r2, r3
	veor q1, q1, q0
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r6, #0]
end:
