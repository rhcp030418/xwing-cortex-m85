.text
.syntax unified
.thumb

// expl_ntt
.global expl_ntt
.type expl_ntt, %function
.thumb_func
.balign 16
expl_ntt:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov lr, r0
	add r10, r1, #400
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	vldrw.u32 q0, [r10, #-400]
	vldrw.u32 q1, [r10, #112]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-400]
	vstrw.u32 q1, [r10, #112]
	vldrw.u32 q0, [r10, #-384]
	vldrw.u32 q1, [r10, #128]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-384]
	vstrw.u32 q1, [r10, #128]
	vldrw.u32 q0, [r10, #-368]
	vldrw.u32 q1, [r10, #144]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-368]
	vstrw.u32 q1, [r10, #144]
	vldrw.u32 q0, [r10, #-352]
	vldrw.u32 q1, [r10, #160]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-352]
	vstrw.u32 q1, [r10, #160]
	vldrw.u32 q0, [r10, #-336]
	vldrw.u32 q1, [r10, #176]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-336]
	vstrw.u32 q1, [r10, #176]
	vldrw.u32 q0, [r10, #-320]
	vldrw.u32 q1, [r10, #192]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-320]
	vstrw.u32 q1, [r10, #192]
	vldrw.u32 q0, [r10, #-304]
	vldrw.u32 q1, [r10, #208]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-304]
	vstrw.u32 q1, [r10, #208]
	vldrw.u32 q0, [r10, #-288]
	vldrw.u32 q1, [r10, #224]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-288]
	vstrw.u32 q1, [r10, #224]
	vldrw.u32 q0, [r10, #-272]
	vldrw.u32 q1, [r10, #240]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-272]
	vstrw.u32 q1, [r10, #240]
	vldrw.u32 q0, [r10, #-256]
	vldrw.u32 q1, [r10, #256]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-256]
	vstrw.u32 q1, [r10, #256]
	vldrw.u32 q0, [r10, #-240]
	vldrw.u32 q1, [r10, #272]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-240]
	vstrw.u32 q1, [r10, #272]
	vldrw.u32 q0, [r10, #-224]
	vldrw.u32 q1, [r10, #288]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-224]
	vstrw.u32 q1, [r10, #288]
	vldrw.u32 q0, [r10, #-208]
	vldrw.u32 q1, [r10, #304]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-208]
	vstrw.u32 q1, [r10, #304]
	vldrw.u32 q0, [r10, #-192]
	vldrw.u32 q1, [r10, #320]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-192]
	vstrw.u32 q1, [r10, #320]
	vldrw.u32 q0, [r10, #-176]
	vldrw.u32 q1, [r10, #336]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-176]
	vstrw.u32 q1, [r10, #336]
	vldrw.u32 q0, [r10, #-160]
	vldrw.u32 q1, [r10, #352]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-160]
	vstrw.u32 q1, [r10, #352]
	vldrw.u32 q0, [r10, #-144]
	vldrw.u32 q1, [r10, #368]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-144]
	vstrw.u32 q1, [r10, #368]
	vldrw.u32 q0, [r10, #-128]
	vldrw.u32 q1, [r10, #384]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-128]
	vstrw.u32 q1, [r10, #384]
	vldrw.u32 q0, [r10, #-112]
	vldrw.u32 q1, [r10, #400]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-112]
	vstrw.u32 q1, [r10, #400]
	vldrw.u32 q0, [r10, #-96]
	vldrw.u32 q1, [r10, #416]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-96]
	vstrw.u32 q1, [r10, #416]
	vldrw.u32 q0, [r10, #-80]
	vldrw.u32 q1, [r10, #432]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-80]
	vstrw.u32 q1, [r10, #432]
	vldrw.u32 q0, [r10, #-64]
	vldrw.u32 q1, [r10, #448]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-64]
	vstrw.u32 q1, [r10, #448]
	vldrw.u32 q0, [r10, #-48]
	vldrw.u32 q1, [r10, #464]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-48]
	vstrw.u32 q1, [r10, #464]
	vldrw.u32 q0, [r10, #-32]
	vldrw.u32 q1, [r10, #480]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-32]
	vstrw.u32 q1, [r10, #480]
	vldrw.u32 q0, [r10, #-16]
	vldrw.u32 q1, [r10, #496]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-16]
	vstrw.u32 q1, [r10, #496]
	vldrw.u32 q0, [r10, #-400]
	vldrw.u32 q1, [r10, #112]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-400]
	vstrw.u32 q1, [r10, #112]
	vldrw.u32 q0, [r10, #-384]
	vldrw.u32 q1, [r10, #128]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-384]
	vstrw.u32 q1, [r10, #128]
	vldrw.u32 q0, [r10, #-368]
	vldrw.u32 q1, [r10, #144]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-368]
	vstrw.u32 q1, [r10, #144]
	vldrw.u32 q0, [r10, #-352]
	vldrw.u32 q1, [r10, #160]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-352]
	vstrw.u32 q1, [r10, #160]
	vldrw.u32 q0, [r10, #-336]
	vldrw.u32 q1, [r10, #176]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-336]
	vstrw.u32 q1, [r10, #176]
	vldrw.u32 q0, [r10, #-320]
	vldrw.u32 q1, [r10, #192]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-320]
	vstrw.u32 q1, [r10, #192]
	vldrw.u32 q0, [r10, #-304]
	vldrw.u32 q1, [r10, #208]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-304]
	vstrw.u32 q1, [r10, #208]
	vldrw.u32 q0, [r10, #-288]
	vldrw.u32 q1, [r10, #224]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-288]
	vstrw.u32 q1, [r10, #224]
	vldrw.u32 q0, [r10, #-272]
	vldrw.u32 q1, [r10, #240]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-272]
	vstrw.u32 q1, [r10, #240]
	vldrw.u32 q0, [r10, #-256]
	vldrw.u32 q1, [r10, #256]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-256]
	vstrw.u32 q1, [r10, #256]
	vldrw.u32 q0, [r10, #-240]
	vldrw.u32 q1, [r10, #272]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-240]
	vstrw.u32 q1, [r10, #272]
	vldrw.u32 q0, [r10, #-224]
	vldrw.u32 q1, [r10, #288]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-224]
	vstrw.u32 q1, [r10, #288]
	vldrw.u32 q0, [r10, #-208]
	vldrw.u32 q1, [r10, #304]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-208]
	vstrw.u32 q1, [r10, #304]
	vldrw.u32 q0, [r10, #-192]
	vldrw.u32 q1, [r10, #320]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-192]
	vstrw.u32 q1, [r10, #320]
	vldrw.u32 q0, [r10, #-176]
	vldrw.u32 q1, [r10, #336]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-176]
	vstrw.u32 q1, [r10, #336]
	vldrw.u32 q0, [r10, #-160]
	vldrw.u32 q1, [r10, #352]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-160]
	vstrw.u32 q1, [r10, #352]
	vldrw.u32 q0, [r10, #-144]
	vldrw.u32 q1, [r10, #368]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-144]
	vstrw.u32 q1, [r10, #368]
	vldrw.u32 q0, [r10, #-128]
	vldrw.u32 q1, [r10, #384]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-128]
	vstrw.u32 q1, [r10, #384]
	vldrw.u32 q0, [r10, #-112]
	vldrw.u32 q1, [r10, #400]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-112]
	vstrw.u32 q1, [r10, #400]
	vldrw.u32 q0, [r10, #-96]
	vldrw.u32 q1, [r10, #416]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-96]
	vstrw.u32 q1, [r10, #416]
	vldrw.u32 q0, [r10, #-80]
	vldrw.u32 q1, [r10, #432]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-80]
	vstrw.u32 q1, [r10, #432]
	vldrw.u32 q0, [r10, #-64]
	vldrw.u32 q1, [r10, #448]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-64]
	vstrw.u32 q1, [r10, #448]
	vldrw.u32 q0, [r10, #-48]
	vldrw.u32 q1, [r10, #464]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-48]
	vstrw.u32 q1, [r10, #464]
	vldrw.u32 q0, [r10, #-32]
	vldrw.u32 q1, [r10, #480]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-32]
	vstrw.u32 q1, [r10, #480]
	vldrw.u32 q0, [r10, #-16]
	vldrw.u32 q1, [r10, #496]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-16]
	vstrw.u32 q1, [r10, #496]
	vldrw.u32 q0, [r10, #-400]
	vldrw.u32 q1, [r10, #112]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-400]
	vstrw.u32 q1, [r10, #112]
	vldrw.u32 q0, [r10, #-384]
	vldrw.u32 q1, [r10, #128]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-384]
	vstrw.u32 q1, [r10, #128]
	vldrw.u32 q0, [r10, #-368]
	vldrw.u32 q1, [r10, #144]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-368]
	vstrw.u32 q1, [r10, #144]
	vldrw.u32 q0, [r10, #-352]
	vldrw.u32 q1, [r10, #160]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-352]
	vstrw.u32 q1, [r10, #160]
	vldrw.u32 q0, [r10, #-336]
	vldrw.u32 q1, [r10, #176]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-336]
	vstrw.u32 q1, [r10, #176]
	vldrw.u32 q0, [r10, #-320]
	vldrw.u32 q1, [r10, #192]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-320]
	vstrw.u32 q1, [r10, #192]
	vldrw.u32 q0, [r10, #-304]
	vldrw.u32 q1, [r10, #208]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-304]
	vstrw.u32 q1, [r10, #208]
	vldrw.u32 q0, [r10, #-288]
	vldrw.u32 q1, [r10, #224]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-288]
	vstrw.u32 q1, [r10, #224]
	vldrw.u32 q0, [r10, #-272]
	vldrw.u32 q1, [r10, #240]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-272]
	vstrw.u32 q1, [r10, #240]
	vldrw.u32 q0, [r10, #-256]
	vldrw.u32 q1, [r10, #256]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-256]
	vstrw.u32 q1, [r10, #256]
	vldrw.u32 q0, [r10, #-240]
	vldrw.u32 q1, [r10, #272]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-240]
	vstrw.u32 q1, [r10, #272]
	vldrw.u32 q0, [r10, #-224]
	vldrw.u32 q1, [r10, #288]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-224]
	vstrw.u32 q1, [r10, #288]
	vldrw.u32 q0, [r10, #-208]
	vldrw.u32 q1, [r10, #304]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-208]
	vstrw.u32 q1, [r10, #304]
	vldrw.u32 q0, [r10, #-192]
	vldrw.u32 q1, [r10, #320]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-192]
	vstrw.u32 q1, [r10, #320]
	vldrw.u32 q0, [r10, #-176]
	vldrw.u32 q1, [r10, #336]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-176]
	vstrw.u32 q1, [r10, #336]
	vldrw.u32 q0, [r10, #-160]
	vldrw.u32 q1, [r10, #352]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-160]
	vstrw.u32 q1, [r10, #352]
	vldrw.u32 q0, [r10, #-144]
	vldrw.u32 q1, [r10, #368]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-144]
	vstrw.u32 q1, [r10, #368]
	vldrw.u32 q0, [r10, #-128]
	vldrw.u32 q1, [r10, #384]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-128]
	vstrw.u32 q1, [r10, #384]
	vldrw.u32 q0, [r10, #-112]
	vldrw.u32 q1, [r10, #400]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-112]
	vstrw.u32 q1, [r10, #400]
	vldrw.u32 q0, [r10, #-96]
	vldrw.u32 q1, [r10, #416]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-96]
	vstrw.u32 q1, [r10, #416]
	vldrw.u32 q0, [r10, #-80]
	vldrw.u32 q1, [r10, #432]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-80]
	vstrw.u32 q1, [r10, #432]
	vldrw.u32 q0, [r10, #-64]
	vldrw.u32 q1, [r10, #448]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-64]
	vstrw.u32 q1, [r10, #448]
	vldrw.u32 q0, [r10, #-48]
	vldrw.u32 q1, [r10, #464]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-48]
	vstrw.u32 q1, [r10, #464]
	vldrw.u32 q0, [r10, #-32]
	vldrw.u32 q1, [r10, #480]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-32]
	vstrw.u32 q1, [r10, #480]
	vldrw.u32 q0, [r10, #-16]
	vldrw.u32 q1, [r10, #496]
	vmul.i32 q2, q0, q1
	vmulh.u32 q3, q0, q1
	vadd.i32 q0, q0, q2
	vsub.i32 q1, q1, q3
	vstrw.u32 q0, [r10, #-16]
	vstrw.u32 q1, [r10, #496]
	subs lr, lr, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// expl_zip
.global expl_zip
.type expl_zip, %function
.thumb_func
.balign 16
expl_zip:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov lr, r0
	add r10, r1, #400
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-400]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #112]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-400]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-384]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #128]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-384]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-368]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #144]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-368]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-352]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #160]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-352]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-336]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #176]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-336]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-320]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #192]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-320]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-304]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #208]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-304]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-288]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #224]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-288]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-272]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #240]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-272]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-256]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #256]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-256]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-240]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #272]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-240]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-224]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #288]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-224]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-208]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #304]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-208]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-192]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #320]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-192]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-176]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #336]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-176]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-160]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #352]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-160]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-144]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #368]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-144]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-128]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #384]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-128]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-112]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #400]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-112]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #400]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-96]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #416]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-96]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #416]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-80]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #432]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-80]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #432]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-64]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #448]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-64]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #448]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-48]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #464]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-48]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #464]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-32]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #480]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-32]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #480]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-16]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #496]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-16]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #496]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-400]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #112]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-400]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-384]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #128]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-384]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-368]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #144]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-368]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-352]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #160]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-352]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-336]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #176]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-336]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-320]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #192]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-320]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-304]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #208]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-304]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-288]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #224]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-288]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-272]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #240]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-272]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #240]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-256]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #256]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-256]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-240]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #272]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-240]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-224]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #288]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-224]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-208]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #304]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-208]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-192]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #320]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-192]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-176]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #336]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-176]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-160]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #352]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-160]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-144]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #368]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-144]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-128]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #384]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-128]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-112]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #400]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-112]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #400]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-96]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #416]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-96]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #416]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-80]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #432]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-80]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #432]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-64]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #448]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-64]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #448]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-48]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #464]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-48]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #464]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-32]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #480]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-32]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #480]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-16]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #496]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-16]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #496]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-400]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #112]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-400]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #112]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-384]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #128]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-384]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #128]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-368]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #144]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-368]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #144]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-352]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #160]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-352]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #160]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-336]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #176]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-336]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #176]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-320]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #192]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-320]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #192]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-304]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #208]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-304]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #208]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-288]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #224]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-288]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #224]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-272]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #240]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-272]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #240]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-256]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #256]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-256]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #256]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-240]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #272]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-240]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #272]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-224]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #288]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-224]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #288]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-208]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #304]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-208]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #304]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-192]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #320]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-192]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #320]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-176]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #336]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-176]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #336]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-160]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #352]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-160]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #352]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-144]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #368]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-144]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #368]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-128]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #384]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-128]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #384]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-112]
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #400]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-112]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #400]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-96]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #416]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-96]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #416]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-80]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #432]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-80]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #432]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-64]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #448]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-64]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #448]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-48]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #464]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-48]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #464]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-32]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #480]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-32]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #480]
	umaal r0, r1, r2, r3
	vldrw.u32 q0, [r10, #-16]
	umaal r0, r1, r2, r3
	vldrw.u32 q1, [r10, #496]
	umaal r0, r1, r2, r3
	vmul.i32 q2, q0, q1
	umaal r0, r1, r2, r3
	vmulh.u32 q3, q0, q1
	umaal r0, r1, r2, r3
	vadd.i32 q0, q0, q2
	umaal r0, r1, r2, r3
	vsub.i32 q1, q1, q3
	umaal r0, r1, r2, r3
	vstrw.u32 q0, [r10, #-16]
	umaal r0, r1, r2, r3
	vstrw.u32 q1, [r10, #496]
	subs lr, lr, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// expl_sntt
.global expl_sntt
.type expl_sntt, %function
.thumb_func
.balign 16
expl_sntt:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov lr, r0
	add r10, r1, #400
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	smull r4, r5, r6, r7
	smull r8, r9, r6, r7
	subs lr, lr, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

// expl_szip
.global expl_szip
.type expl_szip, %function
.thumb_func
.balign 16
expl_szip:
	push {r4-r11, lr}
	vpush {d8-d15}
	mov lr, r0
	add r10, r1, #400
	movs r2, #3
	movs r3, #5
	movs r0, #0
	movs r1, #0
.balign 16
1:
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	umaal r0, r1, r2, r3
	smull r4, r5, r6, r7
	umaal r0, r1, r2, r3
	smull r8, r9, r6, r7
	subs lr, lr, #1
	bne 1b
	vpop {d8-d15}
	pop {r4-r11, pc}

