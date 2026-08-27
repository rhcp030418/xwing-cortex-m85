.text
.syntax unified
.thumb

// 실험 Q: vstrw 없는 B' (gen_exp_q.py 생성) — 측정 전용, 기능 등가 아님
// expq_b
.global expq_b
.type expq_b, %function
.thumb_func
.balign 16
expq_b:
	push {r4-r11, lr}
	vpush {d8-d15}
	sub sp, sp, #156
	str r0, [sp, #148]
	movw r10, #:lower16:g_mve
	movt r10, #:upper16:g_mve
	add r10, r10, #508
	movw r11, #:lower16:g_mve
	movt r11, #:upper16:g_mve
	add r11, r11, #1524
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
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #-492]
	vldrw.u32 q1, [r10, #-412]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-332]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-252]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-172]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #-476]
	vldrw.u32 q1, [r10, #-396]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-316]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-236]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-156]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #-460]
	vldrw.u32 q1, [r10, #-380]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-300]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-220]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-140]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #-444]
	vldrw.u32 q1, [r10, #-364]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-284]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-204]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-124]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #4]
	vldrw.u32 q1, [r10, #84]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #164]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #244]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #324]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #20]
	vldrw.u32 q1, [r10, #100]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #180]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #260]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #340]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #36]
	vldrw.u32 q1, [r10, #116]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #196]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #276]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #356]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #52]
	vldrw.u32 q1, [r10, #132]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #212]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #292]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #372]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #68]
	vldrw.u32 q1, [r10, #148]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #228]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #308]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #388]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r11, #284]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #252]
	veor q1, q1, q2
	vorr q1, q1, q1
	vldrw.u32 q0, [r11, #204]
	vldrw.u32 q2, [r11, #332]
	veor q0, q0, q2
	vorr q0, q0, q0
	vldrw.u32 q0, [r11, #300]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #188]
	veor q1, q1, q2
	vorr q1, q1, q1
	vldrw.u32 q0, [r11, #220]
	vldrw.u32 q2, [r11, #268]
	veor q0, q0, q2
	vorr q0, q0, q0
	vldrw.u32 q0, [r11, #316]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #204]
	veor q1, q1, q2
	vorr q1, q1, q1
	vldrw.u32 q0, [r11, #236]
	vldrw.u32 q2, [r11, #284]
	veor q0, q0, q2
	vorr q0, q0, q0
	vldrw.u32 q0, [r11, #332]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #220]
	veor q1, q1, q2
	vorr q1, q1, q1
	vldrw.u32 q0, [r11, #252]
	vldrw.u32 q2, [r11, #300]
	veor q0, q0, q2
	vorr q0, q0, q0
	vldrw.u32 q0, [r11, #268]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #236]
	veor q1, q1, q2
	vorr q1, q1, q1
	vldrw.u32 q0, [r11, #188]
	vldrw.u32 q2, [r11, #316]
	veor q0, q0, q2
	vorr q0, q0, q0
	vldrw.u32 q6, [r11, #348]
	vldrw.u32 q7, [r11, #428]
	vldrw.u32 q0, [r10, #-508]
	vldrw.u32 q1, [r10, #4]
	veor q0, q0, q6
	veor q1, q1, q7
	vorr q2, q0, q0
	vorr q2, q2, q2
	vorr q3, q1, q1
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-428]
	vldrw.u32 q1, [r10, #84]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #18
	vsri.32 q2, q0, #14
	vorr q2, q2, q2
	vshl.i32 q3, q1, #18
	vsri.32 q3, q1, #14
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-348]
	vldrw.u32 q1, [r10, #164]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #2
	vsri.32 q2, q1, #30
	vorr q2, q2, q2
	vshl.i32 q3, q0, #1
	vsri.32 q3, q0, #31
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-268]
	vldrw.u32 q1, [r10, #244]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #21
	vsri.32 q2, q1, #11
	vorr q2, q2, q2
	vshl.i32 q3, q0, #20
	vsri.32 q3, q0, #12
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-188]
	vldrw.u32 q1, [r10, #324]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #9
	vsri.32 q2, q0, #23
	vorr q2, q2, q2
	vshl.i32 q3, q1, #9
	vsri.32 q3, q1, #23
	vorr q3, q3, q3
	vldrw.u32 q6, [r11, #364]
	vldrw.u32 q7, [r11, #444]
	vldrw.u32 q0, [r10, #-492]
	vldrw.u32 q1, [r10, #20]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #1
	vsri.32 q2, q1, #31
	vorr q2, q2, q2
	vorr q3, q0, q0
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-412]
	vldrw.u32 q1, [r10, #100]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #22
	vsri.32 q2, q0, #10
	vorr q2, q2, q2
	vshl.i32 q3, q1, #22
	vsri.32 q3, q1, #10
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-332]
	vldrw.u32 q1, [r10, #180]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #5
	vsri.32 q2, q0, #27
	vorr q2, q2, q2
	vshl.i32 q3, q1, #5
	vsri.32 q3, q1, #27
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-252]
	vldrw.u32 q1, [r10, #260]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #23
	vsri.32 q2, q1, #9
	vorr q2, q2, q2
	vshl.i32 q3, q0, #22
	vsri.32 q3, q0, #10
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-172]
	vldrw.u32 q1, [r10, #340]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #1
	vsri.32 q2, q0, #31
	vorr q2, q2, q2
	vshl.i32 q3, q1, #1
	vsri.32 q3, q1, #31
	vorr q3, q3, q3
	vldrw.u32 q6, [r11, #380]
	vldrw.u32 q7, [r11, #460]
	vldrw.u32 q0, [r10, #-476]
	vldrw.u32 q1, [r10, #36]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #31
	vsri.32 q2, q0, #1
	vorr q2, q2, q2
	vshl.i32 q3, q1, #31
	vsri.32 q3, q1, #1
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-396]
	vldrw.u32 q1, [r10, #116]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #3
	vsri.32 q2, q0, #29
	vorr q2, q2, q2
	vshl.i32 q3, q1, #3
	vsri.32 q3, q1, #29
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-316]
	vldrw.u32 q1, [r10, #196]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #22
	vsri.32 q2, q1, #10
	vorr q2, q2, q2
	vshl.i32 q3, q0, #21
	vsri.32 q3, q0, #11
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-236]
	vldrw.u32 q1, [r10, #276]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #8
	vsri.32 q2, q1, #24
	vorr q2, q2, q2
	vshl.i32 q3, q0, #7
	vsri.32 q3, q0, #25
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-156]
	vldrw.u32 q1, [r10, #356]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #31
	vsri.32 q2, q1, #1
	vorr q2, q2, q2
	vshl.i32 q3, q0, #30
	vsri.32 q3, q0, #2
	vorr q3, q3, q3
	vldrw.u32 q6, [r11, #396]
	vldrw.u32 q7, [r11, #476]
	vldrw.u32 q0, [r10, #-460]
	vldrw.u32 q1, [r10, #52]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #14
	vsri.32 q2, q0, #18
	vorr q2, q2, q2
	vshl.i32 q3, q1, #14
	vsri.32 q3, q1, #18
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-380]
	vldrw.u32 q1, [r10, #132]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #28
	vsri.32 q2, q1, #4
	vorr q2, q2, q2
	vshl.i32 q3, q0, #27
	vsri.32 q3, q0, #5
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-300]
	vldrw.u32 q1, [r10, #212]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #13
	vsri.32 q2, q1, #19
	vorr q2, q2, q2
	vshl.i32 q3, q0, #12
	vsri.32 q3, q0, #20
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-220]
	vldrw.u32 q1, [r10, #292]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #11
	vsri.32 q2, q1, #21
	vorr q2, q2, q2
	vshl.i32 q3, q0, #10
	vsri.32 q3, q0, #22
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-140]
	vldrw.u32 q1, [r10, #372]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #28
	vsri.32 q2, q0, #4
	vorr q2, q2, q2
	vshl.i32 q3, q1, #28
	vsri.32 q3, q1, #4
	vorr q3, q3, q3
	vldrw.u32 q6, [r11, #412]
	vldrw.u32 q7, [r11, #492]
	vldrw.u32 q0, [r10, #-444]
	vldrw.u32 q1, [r10, #68]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #14
	vsri.32 q2, q1, #18
	vorr q2, q2, q2
	vshl.i32 q3, q0, #13
	vsri.32 q3, q0, #19
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-364]
	vldrw.u32 q1, [r10, #148]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #10
	vsri.32 q2, q0, #22
	vorr q2, q2, q2
	vshl.i32 q3, q1, #10
	vsri.32 q3, q1, #22
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-284]
	vldrw.u32 q1, [r10, #228]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #20
	vsri.32 q2, q1, #12
	vorr q2, q2, q2
	vshl.i32 q3, q0, #19
	vsri.32 q3, q0, #13
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-204]
	vldrw.u32 q1, [r10, #308]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #4
	vsri.32 q2, q0, #28
	vorr q2, q2, q2
	vshl.i32 q3, q1, #4
	vsri.32 q3, q1, #28
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-124]
	vldrw.u32 q1, [r10, #388]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #7
	vsri.32 q2, q0, #25
	vorr q2, q2, q2
	vshl.i32 q3, q1, #7
	vsri.32 q3, q1, #25
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #404]
	vldrw.u32 q1, [r10, #420]
	vldrw.u32 q2, [r10, #436]
	vldrw.u32 q3, [r10, #452]
	vldrw.u32 q4, [r10, #468]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r10, #484]
	vldrw.u32 q1, [r10, #500]
	vldrw.u32 q2, [r11, #-500]
	vldrw.u32 q3, [r11, #-484]
	vldrw.u32 q4, [r11, #-468]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #-452]
	vldrw.u32 q1, [r11, #-436]
	vldrw.u32 q2, [r11, #-420]
	vldrw.u32 q3, [r11, #-404]
	vldrw.u32 q4, [r11, #-388]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #-372]
	vldrw.u32 q1, [r11, #-356]
	vldrw.u32 q2, [r11, #-340]
	vldrw.u32 q3, [r11, #-324]
	vldrw.u32 q4, [r11, #-308]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #-292]
	vldrw.u32 q1, [r11, #-276]
	vldrw.u32 q2, [r11, #-260]
	vldrw.u32 q3, [r11, #-244]
	vldrw.u32 q4, [r11, #-228]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #-212]
	vldrw.u32 q1, [r11, #-196]
	vldrw.u32 q2, [r11, #-180]
	vldrw.u32 q3, [r11, #-164]
	vldrw.u32 q4, [r11, #-148]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #-132]
	vldrw.u32 q1, [r11, #-116]
	vldrw.u32 q2, [r11, #-100]
	vldrw.u32 q3, [r11, #-84]
	vldrw.u32 q4, [r11, #-68]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #-52]
	vldrw.u32 q1, [r11, #-36]
	vldrw.u32 q2, [r11, #-20]
	vldrw.u32 q3, [r11, #-4]
	vldrw.u32 q4, [r11, #12]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #28]
	vldrw.u32 q1, [r11, #44]
	vldrw.u32 q2, [r11, #60]
	vldrw.u32 q3, [r11, #76]
	vldrw.u32 q4, [r11, #92]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #108]
	vldrw.u32 q1, [r11, #124]
	vldrw.u32 q2, [r11, #140]
	vldrw.u32 q3, [r11, #156]
	vldrw.u32 q4, [r11, #172]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vmov.i32 q0, #1
	vldrw.u32 q1, [r10, #-508]
	veor q1, q1, q0
	vorr q1, q1, q1
	ldr r0, [sp, #148]
	subs r0, r0, #1
	str r0, [sp, #148]
	bne 1b
	add sp, sp, #156
	vpop {d8-d15}
	pop {r4-r11, pc}

// expq_stitch
.global expq_stitch
.type expq_stitch, %function
.thumb_func
.balign 16
expq_stitch:
	push {r4-r11, lr}
	vpush {d8-d15}
	sub sp, sp, #156
	str r0, [sp, #148]
	movw r10, #:lower16:g_mve
	movt r10, #:upper16:g_mve
	add r10, r10, #508
	movw r11, #:lower16:g_mve
	movt r11, #:upper16:g_mve
	add r11, r11, #1524
.balign 16
1:
	movw r0, #:lower16:g_fc_out
	vldrw.u32 q0, [r10, #-508]
	movt r0, #:upper16:g_fc_out
	vldrw.u32 q1, [r10, #-428]
	movw r1, #:lower16:g_fc_a
	veor q0, q0, q1
	movt r1, #:upper16:g_fc_a
	vldrw.u32 q1, [r10, #-348]
	movw r2, #:lower16:g_fc_b
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-268]
	movt r2, #:upper16:g_fc_b
	veor q0, q0, q1
	mov	r3, r1
	vldrw.u32 q1, [r10, #-188]
	mov	lr, r2
	veor q0, q0, q1
	ldr	r1, [r2, #36]
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #-492]
	ldr	r2, [r3, #36]
	vldrw.u32 q1, [r10, #-412]
	mov	ip, #38
	veor q0, q0, q1
	mov	r6, r2
	vldrw.u32 q1, [r10, #-332]
	str	r1, [sp, #44]
	veor q0, q0, q1
	ldr	r1, [lr, #12]
	vldrw.u32 q1, [r10, #-252]
	veor q0, q0, q1
	ldr	r2, [r3, #32]
	vldrw.u32 q1, [r10, #-172]
	add	r9, r1, r1, lsl #3
	veor q0, q0, q1
	add	r9, r1, r9, lsl #1
	vorr q0, q0, q0
	ldr	r4, [lr, #8]
	vldrw.u32 q0, [r10, #-476]
	vldrw.u32 q1, [r10, #-396]
	umull	r9, r5, r9, r2
	veor q0, q0, q1
	str	r0, [sp, #40]
	vldrw.u32 q1, [r10, #-316]
	add	r8, r4, r4, lsl #3
	veor q0, q0, q1
	mov	r0, r3
	vldrw.u32 q1, [r10, #-236]
	ldr	r3, [lr, #4]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-156]
	add	r8, r4, r8, lsl #1
	veor q0, q0, q1
	str	r2, [sp, #16]
	vorr q0, q0, q0
	umlal	r9, r5, r6, r8
	vldrw.u32 q0, [r10, #-460]
	str	r4, [sp, #12]
	vldrw.u32 q1, [r10, #-380]
	veor q0, q0, q1
	umull	r8, r2, r8, r2
	vldrw.u32 q1, [r10, #-300]
	mul	r4, ip, r3
	veor q0, q0, q1
	umlal	r8, r2, r6, r4
	vldrw.u32 q1, [r10, #-220]
	mul	r4, ip, r1
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-140]
	str	r3, [sp, #52]
	veor q0, q0, q1
	ldr	r3, [lr, #16]
	vorr q0, q0, q0
	str	r6, [sp, #8]
	vldrw.u32 q0, [r10, #-444]
	add	r6, r3, r3, lsl #3
	vldrw.u32 q1, [r10, #-364]
	add	r6, r3, r6, lsl #1
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-284]
	str	r3, [sp, #32]
	veor q0, q0, q1
	mov	r3, r4
	vldrw.u32 q1, [r10, #-204]
	ldr	r7, [lr, #20]
	veor q0, q0, q1
	ldr	r4, [r0, #28]
	vldrw.u32 q1, [r10, #-124]
	veor q0, q0, q1
	str	r0, [sp, #4]
	vorr q0, q0, q0
	umlal	r9, r5, r6, r4
	vldrw.u32 q0, [r10, #4]
	mov	r0, r4
	vldrw.u32 q1, [r10, #84]
	umlal	r8, r2, r3, r4
	veor q0, q0, q1
	add	r4, r7, r7, lsl #3
	vldrw.u32 q1, [r10, #164]
	veor q0, q0, q1
	add	r4, r7, r4, lsl #1
	vldrw.u32 q1, [r10, #244]
	str	r7, [sp, #76]
	veor q0, q0, q1
	mul	r7, ip, r7
	vldrw.u32 q1, [r10, #324]
	str	r1, [sp, #48]
	veor q0, q0, q1
	vorr q0, q0, q0
	ldr	r1, [lr, #24]
	vldrw.u32 q0, [r10, #20]
	str	r7, [sp, #56]
	vldrw.u32 q1, [r10, #100]
	add	r7, r1, r1, lsl #3
	veor q0, q0, q1
	str	r1, [sp, #84]
	vldrw.u32 q1, [r10, #180]
	veor q0, q0, q1
	add	r7, r1, r7, lsl #1
	vldrw.u32 q1, [r10, #260]
	mov	r1, r5
	veor q0, q0, q1
	str	r3, [sp, #24]
	vldrw.u32 q1, [r10, #340]
	mov	r3, r7
	veor q0, q0, q1
	ldr	r7, [sp, #4]
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #36]
	ldr	r5, [sp, #16]
	vldrw.u32 q1, [r10, #116]
	ldr	r7, [r7, #24]
	veor q0, q0, q1
	umlal	r9, r1, r4, r7
	vldrw.u32 q1, [r10, #196]
	str	r1, [sp, #36]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #276]
	ldr	r1, [sp, #16]
	veor q0, q0, q1
	umlal	r8, r2, r6, r7
	vldrw.u32 q1, [r10, #356]
	str	r7, [sp, #20]
	veor q0, q0, q1
	umull	r7, r4, r1, r4
	vorr q0, q0, q0
	ldr	r1, [sp, #8]
	vldrw.u32 q0, [r10, #52]
	vldrw.u32 q1, [r10, #132]
	str	r8, [sp, #28]
	veor q0, q0, q1
	umlal	r7, r4, r1, r6
	vldrw.u32 q1, [r10, #212]
	umull	r8, r6, r6, r5
	veor q0, q0, q1
	mov	r5, r1
	vldrw.u32 q1, [r10, #292]
	veor q0, q0, q1
	ldr	r1, [sp, #24]
	vldrw.u32 q1, [r10, #372]
	umlal	r7, r4, r3, r0
	veor q0, q0, q1
	umlal	r8, r6, r5, r1
	vorr q0, q0, q0
	ldr	r5, [sp, #56]
	vldrw.u32 q0, [r10, #68]
	vldrw.u32 q1, [r10, #148]
	mov	r1, r3
	veor q0, q0, q1
	umlal	r8, r6, r5, r0
	vldrw.u32 q1, [r10, #228]
	ldr	r5, [sp, #20]
	veor q0, q0, q1
	umlal	r8, r6, r3, r5
	vldrw.u32 q1, [r10, #308]
	ldr	r3, [lr, #28]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #388]
	str	r6, [sp, #88]
	veor q0, q0, q1
	mov	r6, r3
	vorr q0, q0, q0
	str	r8, [sp, #72]
	vldrw.u32 q0, [r11, #284]
	mov	r8, r4
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	ldr	r3, [lr, #32]
	vldrw.u32 q2, [r11, #252]
	str	r6, [sp, #68]
	veor q1, q1, q2
	str	r3, [sp, #64]
	vorr q1, q1, q1
	ldr	r3, [lr]
	vldrw.u32 q0, [r11, #204]
	add	lr, r6, r6, lsl #3
	vldrw.u32 q2, [r11, #332]
	veor q0, q0, q2
	add	lr, r6, lr, lsl #1
	vorr q0, q0, q0
	umlal	r7, r8, lr, r5
	vldrw.u32 q0, [r11, #300]
	str	r8, [sp, #92]
	vshl.i32 q1, q0, #1
	mov	r8, r2
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #188]
	str	r3, [sp, #60]
	veor q1, q1, q2
	ldr	r3, [sp, #4]
	vorr q1, q1, q1
	ldr	r2, [sp, #36]
	vldrw.u32 q0, [r11, #220]
	ldr	r3, [r3, #20]
	vldrw.u32 q2, [r11, #268]
	veor q0, q0, q2
	ldr	r6, [sp, #28]
	vorr q0, q0, q0
	umlal	r9, r2, r1, r3
	vldrw.u32 q0, [r11, #316]
	ldr	r5, [sp, #56]
	vshl.i32 q1, q0, #1
	str	r9, [sp, #80]
	vsri.32 q1, q0, #31
	umlal	r6, r8, r5, r3
	vldrw.u32 q2, [r11, #204]
	veor q1, q1, q2
	mov	r5, r2
	vorr q1, q1, q1
	ldr	r2, [sp, #68]
	vldrw.u32 q0, [r11, #236]
	ldr	r4, [sp, #72]
	vldrw.u32 q2, [r11, #284]
	mul	r9, ip, r2
	veor q0, q0, q2
	vorr q0, q0, q0
	str	r8, [sp, #24]
	vldrw.u32 q0, [r11, #332]
	ldr	r2, [sp, #44]
	vshl.i32 q1, q0, #1
	mov	r8, r6
	vsri.32 q1, q0, #31
	ldr	r6, [sp, #88]
	vldrw.u32 q2, [r11, #220]
	mul	ip, ip, r2
	veor q1, q1, q2
	vorr q1, q1, q1
	umlal	r4, r6, r9, r3
	vldrw.u32 q0, [r11, #252]
	str	ip, [sp, #28]
	vldrw.u32 q2, [r11, #300]
	mov	ip, r4
	veor q0, q0, q2
	ldr	r2, [sp, #64]
	vorr q0, q0, q0
	vldrw.u32 q0, [r11, #268]
	str	r9, [sp, #72]
	vshl.i32 q1, q0, #1
	add	r9, r2, r2, lsl #3
	vsri.32 q1, q0, #31
	add	r9, r2, r9, lsl #1
	vldrw.u32 q2, [r11, #236]
	ldr	r2, [sp, #92]
	veor q1, q1, q2
	vorr q1, q1, q1
	str	r3, [sp, #36]
	vldrw.u32 q0, [r11, #188]
	umlal	r7, r2, r9, r3
	vldrw.u32 q2, [r11, #316]
	ldr	r3, [sp, #4]
	veor q0, q0, q2
	mov	r4, r2
	vorr q0, q0, q0
	str	r7, [sp, #104]
	vldrw.u32 q6, [r11, #348]
	vldrw.u32 q7, [r11, #428]
	ldr	r2, [sp, #24]
	vldrw.u32 q0, [r10, #-508]
	ldr	r7, [r3, #16]
	vldrw.u32 q1, [r10, #4]
	umlal	ip, r6, r9, r7
	veor q0, q0, q6
	umlal	r8, r2, r1, r7
	veor q1, q1, q7
	vorr q2, q0, q0
	str	r8, [sp, #88]
	vorr q2, q2, q2
	str	r6, [sp, #100]
	vorr q3, q1, q1
	mov	r6, r1
	vorr q3, q3, q3
	ldr	r3, [sp, #80]
	vldrw.u32 q0, [r10, #-428]
	str	ip, [sp, #96]
	vldrw.u32 q1, [r10, #84]
	veor q0, q0, q6
	umlal	r3, r5, lr, r7
	veor q1, q1, q7
	str	r3, [sp, #92]
	vshl.i32 q2, q0, #18
	ldr	r3, [sp, #16]
	vsri.32 q2, q0, #14
	str	r7, [sp, #24]
	vorr q2, q2, q2
	vshl.i32 q3, q1, #18
	umull	ip, lr, r3, lr
	vsri.32 q3, q1, #14
	ldr	r3, [sp, #8]
	vorr q3, q3, q3
	str	r0, [sp, #80]
	vldrw.u32 q0, [r10, #-348]
	umlal	ip, lr, r3, r1
	vldrw.u32 q1, [r10, #164]
	ldr	r1, [sp, #16]
	veor q0, q0, q6
	veor q1, q1, q7
	umlal	ip, lr, r9, r0
	vshl.i32 q2, q1, #2
	umull	r7, r8, r6, r1
	vsri.32 q2, q1, #30
	ldr	r1, [sp, #56]
	vorr q2, q2, q2
	ldr	r6, [sp, #72]
	vshl.i32 q3, q0, #1
	vsri.32 q3, q0, #31
	umlal	r7, r8, r3, r1
	vorr q3, q3, q3
	umlal	r7, r8, r6, r0
	vldrw.u32 q0, [r10, #-268]
	ldr	r6, [sp, #20]
	vldrw.u32 q1, [r10, #244]
	ldr	r1, [sp, #28]
	veor q0, q0, q6
	veor q1, q1, q7
	umlal	r7, r8, r9, r6
	vshl.i32 q2, q1, #21
	ldr	r3, [sp, #36]
	vsri.32 q2, q1, #11
	ldr	r0, [sp, #24]
	vorr q2, q2, q2
	umlal	r7, r8, r1, r3
	vshl.i32 q3, q0, #20
	mov	r1, r7
	vsri.32 q3, q0, #12
	vorr q3, q3, q3
	ldr	r3, [sp, #60]
	vldrw.u32 q0, [r10, #-188]
	ldr	r7, [sp, #24]
	vldrw.u32 q1, [r10, #324]
	umlal	r1, r8, r7, r3
	veor q0, q0, q6
	str	r8, [sp, #120]
	veor q1, q1, q7
	vshl.i32 q2, q0, #9
	mov	r8, r4
	vsri.32 q2, q0, #23
	str	r1, [sp, #116]
	vorr q2, q2, q2
	ldr	r1, [sp, #44]
	vshl.i32 q3, q1, #9
	ldr	r3, [sp, #60]
	vsri.32 q3, q1, #23
	add	r7, r1, r1, lsl #3
	vorr q3, q3, q3
	vldrw.u32 q6, [r11, #364]
	add	r7, r1, r7, lsl #1
	vldrw.u32 q7, [r11, #444]
	umlal	ip, lr, r7, r6
	vldrw.u32 q0, [r10, #-492]
	ldr	r1, [sp, #104]
	vldrw.u32 q1, [r10, #20]
	ldr	r6, [sp, #36]
	veor q0, q0, q6
	veor q1, q1, q7
	umlal	r1, r8, r7, r0
	vshl.i32 q2, q1, #1
	umlal	ip, lr, r6, r3
	vsri.32 q2, q1, #31
	str	r1, [sp, #56]
	vorr q2, q2, q2
	ldr	r6, [sp, #4]
	vorr q3, q0, q0
	vorr q3, q3, q3
	ldr	r1, [sp, #52]
	vldrw.u32 q0, [r10, #-412]
	ldr	r4, [sp, #72]
	vldrw.u32 q1, [r10, #100]
	umlal	ip, lr, r0, r1
	veor q0, q0, q6
	ldr	r1, [r6, #12]
	veor q1, q1, q7
	ldr	r0, [sp, #88]
	vshl.i32 q2, q0, #22
	vsri.32 q2, q0, #10
	str	r8, [sp, #108]
	vorr q2, q2, q2
	umlal	r0, r2, r4, r1
	vshl.i32 q3, q1, #22
	ldr	r4, [sp, #92]
	vsri.32 q3, q1, #10
	str	r0, [sp, #60]
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-332]
	umlal	r4, r5, r9, r1
	vldrw.u32 q1, [r10, #180]
	str	r5, [sp, #88]
	veor q0, q0, q6
	mov	r8, r4
	veor q1, q1, q7
	ldr	r5, [sp, #28]
	vshl.i32 q2, q0, #5
	ldr	r4, [sp, #96]
	vsri.32 q2, q0, #27
	vorr q2, q2, q2
	ldr	r6, [sp, #100]
	vshl.i32 q3, q1, #5
	ldr	r0, [sp, #4]
	vsri.32 q3, q1, #27
	umlal	r4, r6, r5, r1
	vorr q3, q3, q3
	ldr	r5, [sp, #56]
	vldrw.u32 q0, [r10, #-252]
	vldrw.u32 q1, [r10, #260]
	str	r4, [sp, #104]
	veor q0, q0, q6
	ldr	r4, [sp, #108]
	veor q1, q1, q7
	str	r1, [sp, #56]
	vshl.i32 q2, q1, #23
	umlal	r5, r4, r1, r3
	vsri.32 q2, q1, #9
	vorr q2, q2, q2
	str	r5, [sp, #112]
	vshl.i32 q3, q0, #22
	ldr	r5, [sp, #12]
	vsri.32 q3, q0, #10
	umlal	ip, lr, r1, r5
	vorr q3, q3, q3
	ldr	r1, [r0, #8]
	vldrw.u32 q0, [r10, #-172]
	mov	r0, r2
	vldrw.u32 q1, [r10, #340]
	veor q0, q0, q6
	mov	r2, r1
	veor q1, q1, q7
	ldr	r5, [sp, #60]
	vshl.i32 q2, q0, #1
	str	r3, [sp, #60]
	vsri.32 q2, q0, #31
	umlal	r5, r0, r9, r1
	vorr q2, q2, q2
	vshl.i32 q3, q1, #1
	ldr	r1, [sp, #88]
	vsri.32 q3, q1, #31
	str	r0, [sp, #96]
	vorr q3, q3, q3
	ldr	r0, [sp, #104]
	vldrw.u32 q6, [r11, #380]
	umlal	r8, r1, r7, r2
	vldrw.u32 q7, [r11, #460]
	umlal	r0, r6, r2, r3
	vldrw.u32 q0, [r10, #-476]
	vldrw.u32 q1, [r10, #36]
	str	r5, [sp, #92]
	veor q0, q0, q6
	strd	r0, r6, [sp, #104]
	veor q1, q1, q7
	ldr	r5, [sp, #112]
	vshl.i32 q2, q0, #31
	ldr	r6, [sp, #52]
	vsri.32 q2, q0, #1
	vorr q2, q2, q2
	str	r1, [sp, #100]
	vshl.i32 q3, q1, #31
	ldr	r1, [sp, #48]
	vsri.32 q3, q1, #1
	umlal	r5, r4, r2, r6
	vorr q3, q3, q3
	umlal	ip, lr, r2, r1
	vldrw.u32 q0, [r10, #-396]
	vldrw.u32 q1, [r10, #116]
	str	r2, [sp, #88]
	veor q0, q0, q6
	ldr	r2, [sp, #16]
	veor q1, q1, q7
	ldr	r0, [sp, #80]
	vshl.i32 q2, q0, #3
	umull	r6, r7, r2, r7
	vsri.32 q2, q0, #29
	ldr	r2, [sp, #8]
	vorr q2, q2, q2
	vshl.i32 q3, q1, #3
	str	r5, [sp, #112]
	vsri.32 q3, q1, #29
	umlal	r6, r7, r2, r9
	vorr q3, q3, q3
	umlal	r6, r7, r0, r3
	vldrw.u32 q0, [r10, #-316]
	ldr	r5, [sp, #52]
	vldrw.u32 q1, [r10, #196]
	veor q0, q0, q6
	ldr	r3, [sp, #20]
	veor q1, q1, q7
	str	lr, [sp, #128]
	vshl.i32 q2, q1, #22
	umlal	r6, r7, r3, r5
	vsri.32 q2, q1, #10
	str	ip, [sp, #124]
	vorr q2, q2, q2
	ldr	r3, [sp, #36]
	vshl.i32 q3, q0, #21
	vsri.32 q3, q0, #11
	ldr	r5, [sp, #12]
	vorr q3, q3, q3
	umlal	r6, r7, r3, r5
	vldrw.u32 q0, [r10, #-236]
	ldr	r3, [sp, #24]
	vldrw.u32 q1, [r10, #276]
	ldr	r5, [sp, #76]
	veor q0, q0, q6
	veor q1, q1, q7
	umlal	r6, r7, r3, r1
	vshl.i32 q2, q1, #8
	ldr	r1, [sp, #56]
	vsri.32 q2, q1, #24
	ldr	r3, [sp, #32]
	vorr q2, q2, q2
	umlal	r6, r7, r1, r3
	vshl.i32 q3, q0, #7
	vsri.32 q3, q0, #25
	mov	ip, r6
	vorr q3, q3, q3
	ldr	r6, [sp, #88]
	vldrw.u32 q0, [r10, #-156]
	ldr	r3, [sp, #16]
	vldrw.u32 q1, [r10, #356]
	umlal	ip, r7, r6, r5
	veor q0, q0, q6
	str	ip, [sp, #136]
	veor q1, q1, q7
	vshl.i32 q2, q1, #31
	umull	ip, r6, r9, r3
	vsri.32 q2, q1, #1
	ldr	r5, [sp, #72]
	vorr q2, q2, q2
	ldr	r3, [sp, #20]
	vshl.i32 q3, q0, #30
	umlal	ip, r6, r2, r5
	vsri.32 q3, q0, #2
	vorr q3, q3, q3
	ldr	r5, [sp, #28]
	vldrw.u32 q6, [r11, #396]
	ldr	r2, [sp, #4]
	vldrw.u32 q7, [r11, #476]
	umlal	ip, r6, r5, r0
	vldrw.u32 q0, [r10, #-460]
	ldr	r0, [sp, #60]
	vldrw.u32 q1, [r10, #52]
	umlal	ip, r6, r3, r0
	veor q0, q0, q6
	veor q1, q1, q7
	ldrd	r3, lr, [r2]
	vshl.i32 q2, q0, #14
	str	r3, [sp, #4]
	vsri.32 q2, q0, #18
	ldrd	r3, r1, [sp, #92]
	vorr q2, q2, q2
	umlal	r3, r1, r5, lr
	vshl.i32 q3, q1, #14
	vsri.32 q3, q1, #18
	str	r1, [sp, #60]
	vorr q3, q3, q3
	ldr	r1, [sp, #100]
	vldrw.u32 q0, [r10, #-380]
	mov	r9, r3
	vldrw.u32 q1, [r10, #132]
	umlal	r8, r1, lr, r0
	veor q0, q0, q6
	mov	r3, r0
	veor q1, q1, q7
	vshl.i32 q2, q1, #28
	mov	r5, r1
	vsri.32 q2, q1, #4
	str	r6, [sp, #132]
	vorr q2, q2, q2
	ldr	r1, [sp, #12]
	vshl.i32 q3, q0, #27
	ldr	r6, [sp, #112]
	vsri.32 q3, q0, #5
	vorr q3, q3, q3
	umlal	r6, r4, lr, r1
	vldrw.u32 q0, [r10, #-300]
	ldr	r1, [sp, #32]
	vldrw.u32 q1, [r10, #212]
	str	r6, [sp, #96]
	veor q0, q0, q6
	ldrd	r0, r6, [sp, #124]
	veor q1, q1, q7
	vshl.i32 q2, q1, #13
	umlal	r0, r6, lr, r1
	vsri.32 q2, q1, #19
	mov	r2, r6
	vorr q2, q2, q2
	mov	r1, r0
	vshl.i32 q3, q0, #12
	ldr	r6, [sp, #60]
	vsri.32 q3, q0, #20
	ldr	r0, [sp, #4]
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-220]
	umlal	r9, r6, r3, r0
	vldrw.u32 q1, [r10, #292]
	str	r9, [sp, #60]
	veor q0, q0, q6
	mov	r9, r5
	veor q1, q1, q7
	str	r6, [sp, #72]
	vshl.i32 q2, q1, #11
	vsri.32 q2, q1, #21
	ldr	r0, [sp, #52]
	vorr q2, q2, q2
	ldr	r6, [sp, #4]
	vshl.i32 q3, q0, #10
	ldr	r5, [sp, #48]
	vsri.32 q3, q0, #22
	umlal	r8, r9, r0, r6
	vorr q3, q3, q3
	str	r8, [sp, #52]
	vldrw.u32 q0, [r10, #-140]
	vldrw.u32 q1, [r10, #372]
	mov	r8, r4
	veor q0, q0, q6
	ldr	r6, [sp, #96]
	veor q1, q1, q7
	ldr	r4, [sp, #4]
	vshl.i32 q2, q0, #28
	str	r9, [sp, #92]
	vsri.32 q2, q0, #4
	vorr q2, q2, q2
	umlal	r6, r8, r5, r4
	vshl.i32 q3, q1, #28
	mov	r4, r2
	vsri.32 q3, q1, #4
	str	r8, [sp, #112]
	vorr q3, q3, q3
	mov	r8, r1
	vldrw.u32 q6, [r11, #412]
	vldrw.u32 q7, [r11, #492]
	ldr	r2, [sp, #4]
	vldrw.u32 q0, [r10, #-444]
	ldr	r5, [sp, #76]
	vldrw.u32 q1, [r10, #68]
	str	r6, [sp, #100]
	veor q0, q0, q6
	umlal	r8, r4, r5, r2
	veor q1, q1, q7
	ldr	r5, [sp, #136]
	vshl.i32 q2, q1, #14
	vsri.32 q2, q1, #18
	str	r4, [sp, #128]
	vorr q2, q2, q2
	ldr	r4, [sp, #84]
	vshl.i32 q3, q0, #13
	str	r8, [sp, #124]
	vsri.32 q3, q0, #19
	umlal	r5, r7, lr, r4
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-364]
	mov	r8, r5
	vldrw.u32 q1, [r10, #148]
	ldrd	r6, r5, [sp, #116]
	veor q0, q0, q6
	mov	r9, r7
	veor q1, q1, q7
	ldr	r4, [sp, #68]
	vshl.i32 q2, q0, #10
	lsls	r7, r0, #1
	vsri.32 q2, q0, #22
	vorr q2, q2, q2
	umlal	r8, r9, r4, r2
	vshl.i32 q3, q1, #10
	ldr	r4, [sp, #36]
	vsri.32 q3, q1, #22
	ldr	r2, [sp, #132]
	vorr q3, q3, q3
	str	r9, [sp, #140]
	vldrw.u32 q0, [r10, #-284]
	vldrw.u32 q1, [r10, #228]
	umlal	ip, r2, r4, r7
	veor q0, q0, q6
	mov	r1, ip
	veor q1, q1, q7
	ldr	r4, [sp, #56]
	vshl.i32 q2, q1, #20
	mov	r9, r1
	vsri.32 q2, q1, #12
	vorr q2, q2, q2
	umlal	r6, r5, r4, r7
	vshl.i32 q3, q0, #19
	mov	ip, r5
	vsri.32 q3, q0, #13
	mov	r5, r6
	vorr q3, q3, q3
	ldrd	r4, r6, [sp, #104]
	vldrw.u32 q0, [r10, #-204]
	umlal	r4, r6, lr, r7
	vldrw.u32 q1, [r10, #308]
	veor q0, q0, q6
	str	r8, [sp, #136]
	veor q1, q1, q7
	mov	r8, r6
	vshl.i32 q2, q0, #4
	ldr	r1, [sp, #24]
	vsri.32 q2, q0, #28
	ldr	r6, [sp, #12]
	vorr q2, q2, q2
	vshl.i32 q3, q1, #4
	umlal	r9, r2, r1, r6
	vsri.32 q3, q1, #28
	ldr	r1, [sp, #12]
	vorr q3, q3, q3
	str	r9, [sp, #104]
	vldrw.u32 q0, [r10, #-124]
	mov	r9, r5
	vldrw.u32 q1, [r10, #388]
	ldr	r5, [sp, #4]
	veor q0, q0, q6
	veor q1, q1, q7
	str	r2, [sp, #108]
	vshl.i32 q2, q0, #7
	umlal	r4, r8, r1, r5
	vsri.32 q2, q0, #25
	mov	r5, r0
	vorr q2, q2, q2
	ldr	r2, [sp, #88]
	vshl.i32 q3, q1, #7
	vsri.32 q3, q1, #25
	str	r8, [sp, #96]
	vorr q3, q3, q3
	ldr	r0, [sp, #16]
	vldrw.u32 q0, [r10, #404]
	str	r4, [sp, #88]
	vldrw.u32 q1, [r10, #420]
	umull	r4, r5, r0, r5
	vldrw.u32 q2, [r10, #436]
	vldrw.u32 q3, [r10, #452]
	ldr	r6, [sp, #8]
	vldrw.u32 q4, [r10, #468]
	umlal	r9, ip, r2, r1
	vbic q5, q2, q1
	umlal	r4, r5, r6, r3
	veor q5, q5, q0
	umull	r3, r1, r0, r3
	vorr q5, q5, q5
	mov	r0, r6
	vbic q5, q3, q2
	veor q5, q5, q1
	ldr	r6, [sp, #28]
	vorr q5, q5, q5
	umlal	r3, r1, r0, r6
	vbic q5, q4, q3
	ldr	r6, [sp, #12]
	veor q5, q5, q2
	ldr	r0, [sp, #80]
	vorr q5, q5, q5
	vbic q5, q0, q4
	umlal	r3, r1, r0, r7
	veor q5, q5, q3
	umlal	r4, r5, r0, r6
	vorr q5, q5, q5
	ldr	r7, [sp, #20]
	vbic q5, q1, q0
	ldr	r0, [sp, #48]
	veor q5, q5, q4
	umlal	r3, r1, r7, r6
	vorr q5, q5, q5
	vldrw.u32 q0, [r10, #484]
	lsl	r8, r0, #1
	vldrw.u32 q1, [r10, #500]
	umlal	r4, r5, r7, r0
	vldrw.u32 q2, [r11, #-500]
	ldr	r6, [sp, #108]
	vldrw.u32 q3, [r11, #-484]
	ldr	r7, [sp, #56]
	vldrw.u32 q4, [r11, #-468]
	vbic q5, q2, q1
	ldr	r0, [sp, #104]
	veor q5, q5, q0
	umlal	r9, ip, lr, r8
	vorr q5, q5, q5
	umlal	r0, r6, r7, r8
	vbic q5, q3, q2
	mov	r7, r0
	veor q5, q5, q1
	vorr q5, q5, q5
	ldr	r0, [sp, #36]
	vbic q5, q4, q3
	umlal	r3, r1, r0, r8
	veor q5, q5, q2
	str	r3, [sp, #8]
	vorr q5, q5, q5
	ldr	r3, [sp, #32]
	vbic q5, q0, q4
	umlal	r4, r5, r0, r3
	veor q5, q5, q3
	vorr q5, q5, q5
	ldr	r0, [sp, #24]
	vbic q5, q1, q0
	str	r4, [sp, #16]
	veor q5, q5, q4
	ldr	r4, [sp, #8]
	vorr q5, q5, q5
	umlal	r7, r6, r2, r3
	vldrw.u32 q0, [r11, #-452]
	vldrw.u32 q1, [r11, #-436]
	umlal	r4, r1, r0, r3
	vldrw.u32 q2, [r11, #-420]
	strd	r4, r1, [sp, #8]
	vldrw.u32 q3, [r11, #-404]
	ldr	r1, [sp, #76]
	vldrw.u32 q4, [r11, #-388]
	ldr	r4, [sp, #16]
	vbic q5, q2, q1
	lsl	r8, r1, #1
	veor q5, q5, q0
	vorr q5, q5, q5
	umlal	r4, r5, r0, r1
	vbic q5, q3, q2
	mov	r0, r3
	veor q5, q5, q1
	umlal	r7, r6, lr, r8
	vorr q5, q5, q5
	ldr	r3, [sp, #4]
	vbic q5, q4, q3
	veor q5, q5, q2
	umlal	r9, ip, r0, r3
	vorr q5, q5, q5
	ldrd	r3, r1, [sp, #8]
	vbic q5, q0, q4
	ldr	r0, [sp, #56]
	veor q5, q5, q3
	str	r6, [sp, #8]
	vorr q5, q5, q5
	umlal	r3, r1, r0, r8
	vbic q5, q1, q0
	veor q5, q5, q4
	ldr	r6, [sp, #84]
	vorr q5, q5, q5
	mov	r8, r7
	vldrw.u32 q0, [r11, #-372]
	umlal	r4, r5, r0, r6
	vldrw.u32 q1, [r11, #-356]
	mov	r0, r2
	vldrw.u32 q2, [r11, #-340]
	vldrw.u32 q3, [r11, #-324]
	umlal	r3, r1, r2, r6
	vldrw.u32 q4, [r11, #-308]
	ldrd	r7, r2, [sp, #4]
	vbic q5, q2, q1
	umlal	r8, r2, r6, r7
	veor q5, q5, q0
	ldr	r7, [sp, #68]
	vorr q5, q5, q5
	vbic q5, q3, q2
	mov	r6, r2
	veor q5, q5, q1
	umlal	r4, r5, r0, r7
	vorr q5, q5, q5
	ldr	r0, [sp, #64]
	vbic q5, q4, q3
	lsls	r7, r7, #1
	veor q5, q5, q2
	umlal	r4, r5, lr, r0
	vorr q5, q5, q5
	vbic q5, q0, q4
	umlal	r3, r1, lr, r7
	veor q5, q5, q3
	mov	lr, r4
	vorr q5, q5, q5
	str	r8, [sp, #8]
	vbic q5, q1, q0
	ldr	r2, [sp, #4]
	veor q5, q5, q4
	vorr q5, q5, q5
	ldr	r4, [sp, #60]
	vldrw.u32 q0, [r11, #-292]
	umlal	r3, r1, r0, r2
	vldrw.u32 q1, [r11, #-276]
	str	r3, [sp, #12]
	vldrw.u32 q2, [r11, #-260]
	ldr	r3, [sp, #44]
	vldrw.u32 q3, [r11, #-244]
	ldr	r7, [sp, #52]
	vldrw.u32 q4, [r11, #-228]
	vbic q5, q2, q1
	umlal	lr, r5, r2, r3
	veor q5, q5, q0
	ldr	r2, [sp, #72]
	vorr q5, q5, q5
	lsrs	r3, r4, #26
	vbic q5, q3, q2
	orr	r3, r3, r2, lsl #6
	veor q5, q5, q1
	vorr q5, q5, q5
	adds	r3, r7, r3
	vbic q5, q4, q3
	ldr	r7, [sp, #92]
	veor q5, q5, q2
	bic	r4, r4, #-67108864
	vorr q5, q5, q5
	adc	r2, r7, r2, lsr #26
	vbic q5, q0, q4
	veor q5, q5, q3
	str	r4, [sp, #4]
	vorr q5, q5, q5
	ldr	r7, [sp, #88]
	vbic q5, q1, q0
	mov	r0, lr
	veor q5, q5, q4
	lsrs	r4, r3, #25
	vorr q5, q5, q5
	orr	r4, r4, r2, lsl #7
	vldrw.u32 q0, [r11, #-212]
	vldrw.u32 q1, [r11, #-196]
	adds	r4, r7, r4
	vldrw.u32 q2, [r11, #-180]
	ldr	r7, [sp, #96]
	vldrw.u32 q3, [r11, #-164]
	lsr	lr, r4, #26
	vldrw.u32 q4, [r11, #-148]
	adc	r2, r7, r2, lsr #25
	vbic q5, q2, q1
	veor q5, q5, q0
	ldr	r7, [sp, #100]
	vorr q5, q5, q5
	orr	lr, lr, r2, lsl #6
	vbic q5, q3, q2
	adds	lr, r7, lr
	veor q5, q5, q1
	ldr	r7, [sp, #112]
	vorr q5, q5, q5
	lsr	r8, lr, #25
	vbic q5, q4, q3
	veor q5, q5, q2
	adc	r2, r7, r2, lsr #26
	vorr q5, q5, q5
	orr	r8, r8, r2, lsl #7
	vbic q5, q0, q4
	ldr	r7, [sp, #40]
	veor q5, q5, q3
	adds	r8, r9, r8
	vorr q5, q5, q5
	vbic q5, q1, q0
	bic	lr, lr, #-33554432
	veor q5, q5, q4
	adc	r2, ip, r2, lsr #25
	vorr q5, q5, q5
	str	lr, [r7, #12]
	vldrw.u32 q0, [r11, #-132]
	lsr	ip, r8, #26
	vldrw.u32 q1, [r11, #-116]
	vldrw.u32 q2, [r11, #-100]
	ldr	r7, [sp, #124]
	vldrw.u32 q3, [r11, #-84]
	orr	ip, ip, r2, lsl #6
	vldrw.u32 q4, [r11, #-68]
	adds	ip, r7, ip
	vbic q5, q2, q1
	ldr	r7, [sp, #128]
	veor q5, q5, q0
	bic	r8, r8, #-67108864
	vorr q5, q5, q5
	vbic q5, q3, q2
	adc	r2, r7, r2, lsr #26
	veor q5, q5, q1
	ldr	r7, [sp, #40]
	vorr q5, q5, q5
	lsr	lr, ip, #25
	vbic q5, q4, q3
	str	r8, [r7, #16]
	veor q5, q5, q2
	vorr q5, q5, q5
	ldr	r7, [sp, #8]
	vbic q5, q0, q4
	orr	lr, lr, r2, lsl #7
	veor q5, q5, q3
	adds	lr, r7, lr
	vorr q5, q5, q5
	ldr	r7, [sp, #40]
	vbic q5, q1, q0
	adc	r2, r6, r2, lsr #25
	veor q5, q5, q4
	vorr q5, q5, q5
	bic	r6, ip, #-33554432
	vldrw.u32 q0, [r11, #-52]
	str	r6, [r7, #20]
	vldrw.u32 q1, [r11, #-36]
	ldr	r7, [sp, #136]
	vldrw.u32 q2, [r11, #-20]
	lsr	r6, lr, #26
	vldrw.u32 q3, [r11, #-4]
	vldrw.u32 q4, [r11, #12]
	orr	r6, r6, r2, lsl #6
	vbic q5, q2, q1
	adds	r6, r7, r6
	veor q5, q5, q0
	ldr	r7, [sp, #140]
	vorr q5, q5, q5
	bic	lr, lr, #-67108864
	vbic q5, q3, q2
	veor q5, q5, q1
	adc	r2, r7, r2, lsr #26
	vorr q5, q5, q5
	ldr	r7, [sp, #40]
	vbic q5, q4, q3
	lsr	ip, r6, #25
	veor q5, q5, q2
	str	lr, [r7, #24]
	vorr q5, q5, q5
	ldr	r7, [sp, #12]
	vbic q5, q0, q4
	veor q5, q5, q3
	orr	ip, ip, r2, lsl #7
	vorr q5, q5, q5
	adds	ip, r7, ip
	vbic q5, q1, q0
	adc	r1, r1, r2, lsr #25
	veor q5, q5, q4
	lsr	r2, ip, #26
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #28]
	ldr	r7, [sp, #40]
	vldrw.u32 q1, [r11, #44]
	orr	r2, r2, r1, lsl #6
	vldrw.u32 q2, [r11, #60]
	adds	r9, r0, r2
	vldrw.u32 q3, [r11, #76]
	bic	r6, r6, #-33554432
	vldrw.u32 q4, [r11, #92]
	adc	r5, r5, r1, lsr #26
	vbic q5, q2, q1
	veor q5, q5, q0
	str	r6, [r7, #28]
	vorr q5, q5, q5
	bic	r2, ip, #-67108864
	vbic q5, q3, q2
	lsr	r6, r9, #25
	veor q5, q5, q1
	orr	r6, r6, r5, lsl #7
	vorr q5, q5, q5
	vbic q5, q4, q3
	str	r2, [r7, #32]
	veor q5, q5, q2
	lsrs	r5, r5, #25
	vorr q5, q5, q5
	bic	r2, r9, #-33554432
	vbic q5, q0, q4
	str	r2, [r7, #36]
	veor q5, q5, q3
	vorr q5, q5, q5
	lsls	r1, r5, #3
	vbic q5, q1, q0
	lsls	r2, r6, #3
	veor q5, q5, q4
	adds	r2, r2, r6
	vorr q5, q5, q5
	orr	r1, r1, r6, lsr #29
	vldrw.u32 q0, [r11, #108]
	adc	r1, r5, r1
	vldrw.u32 q1, [r11, #124]
	vldrw.u32 q2, [r11, #140]
	adds	r2, r2, r2
	vldrw.u32 q3, [r11, #156]
	adcs	r1, r1, r1
	vldrw.u32 q4, [r11, #172]
	adds	r2, r2, r6
	vbic q5, q2, q1
	adc	r5, r5, r1
	veor q5, q5, q0
	vorr q5, q5, q5
	ldr	r1, [sp, #4]
	vbic q5, q3, q2
	bic	r3, r3, #-33554432
	veor q5, q5, q1
	adds	r2, r2, r1
	vorr q5, q5, q5
	adc	r5, r5, #0
	vbic q5, q4, q3
	lsrs	r1, r2, #26
	veor q5, q5, q2
	vorr q5, q5, q5
	orr	r1, r1, r5, lsl #6
	vbic q5, q0, q4
	add	r3, r3, r1
	veor q5, q5, q3
	bic	r4, r4, #-67108864
	vorr q5, q5, q5
	bic	r2, r2, #-67108864
	vbic q5, q1, q0
	veor q5, q5, q4
	bic	r1, r3, #-33554432
	vorr q5, q5, q5
	add	r4, r4, r3, lsr #25
	vmov.i32 q0, #1
	strd	r2, r1, [r7]
	vldrw.u32 q1, [r10, #-508]
	str	r4, [r7, #8]
	veor q1, q1, q0
	vorr q1, q1, q1
	ldr r0, [sp, #148]
	subs r0, r0, #1
	str r0, [sp, #148]
	bne 1b
	add sp, sp, #156
	vpop {d8-d15}
	pop {r4-r11, pc}

// expq_stitch2
.global expq_stitch2
.type expq_stitch2, %function
.thumb_func
.balign 16
expq_stitch2:
	push {r4-r11, lr}
	vpush {d8-d15}
	sub sp, sp, #156
	str r0, [sp, #148]
	movw r10, #:lower16:g_mve
	movt r10, #:upper16:g_mve
	add r10, r10, #508
	movw r11, #:lower16:g_mve
	movt r11, #:upper16:g_mve
	add r11, r11, #1524
.balign 16
1:
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	vldrw.u32 q0, [r10, #-508]
	vldrw.u32 q1, [r10, #-428]
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-348]
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-268]
	veor q0, q0, q1
	mov	r3, r1
	mov	lr, r2
	vldrw.u32 q1, [r10, #-188]
	veor q0, q0, q1
	ldr	r1, [r2, #36]
	ldr	r2, [r3, #36]
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #-492]
	vldrw.u32 q1, [r10, #-412]
	mov	ip, #38
	mov	r6, r2
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-332]
	str	r1, [sp, #44]
	ldr	r1, [lr, #12]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-252]
	veor q0, q0, q1
	ldr	r2, [r3, #32]
	add	r9, r1, r1, lsl #3
	vldrw.u32 q1, [r10, #-172]
	veor q0, q0, q1
	add	r9, r1, r9, lsl #1
	ldr	r4, [lr, #8]
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #-476]
	vldrw.u32 q1, [r10, #-396]
	umull	r9, r5, r9, r2
	str	r0, [sp, #40]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-316]
	add	r8, r4, r4, lsl #3
	mov	r0, r3
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-236]
	ldr	r3, [lr, #4]
	add	r8, r4, r8, lsl #1
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-156]
	veor q0, q0, q1
	str	r2, [sp, #16]
	umlal	r9, r5, r6, r8
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #-460]
	str	r4, [sp, #12]
	umull	r8, r2, r8, r2
	vldrw.u32 q1, [r10, #-380]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-300]
	mul	r4, ip, r3
	umlal	r8, r2, r6, r4
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-220]
	mul	r4, ip, r1
	str	r3, [sp, #52]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-140]
	veor q0, q0, q1
	ldr	r3, [lr, #16]
	str	r6, [sp, #8]
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #-444]
	add	r6, r3, r3, lsl #3
	add	r6, r3, r6, lsl #1
	vldrw.u32 q1, [r10, #-364]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-284]
	str	r3, [sp, #32]
	mov	r3, r4
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-204]
	ldr	r7, [lr, #20]
	ldr	r4, [r0, #28]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-124]
	veor q0, q0, q1
	str	r0, [sp, #4]
	umlal	r9, r5, r6, r4
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #4]
	mov	r0, r4
	umlal	r8, r2, r3, r4
	vldrw.u32 q1, [r10, #84]
	veor q0, q0, q1
	add	r4, r7, r7, lsl #3
	add	r4, r7, r4, lsl #1
	vldrw.u32 q1, [r10, #164]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #244]
	str	r7, [sp, #76]
	mul	r7, ip, r7
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #324]
	str	r1, [sp, #48]
	ldr	r1, [lr, #24]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #20]
	str	r7, [sp, #56]
	add	r7, r1, r1, lsl #3
	vldrw.u32 q1, [r10, #100]
	veor q0, q0, q1
	str	r1, [sp, #84]
	add	r7, r1, r7, lsl #1
	vldrw.u32 q1, [r10, #180]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #260]
	mov	r1, r5
	str	r3, [sp, #24]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #340]
	mov	r3, r7
	ldr	r7, [sp, #4]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #36]
	ldr	r5, [sp, #16]
	ldr	r7, [r7, #24]
	vldrw.u32 q1, [r10, #116]
	veor q0, q0, q1
	umlal	r9, r1, r4, r7
	str	r1, [sp, #36]
	vldrw.u32 q1, [r10, #196]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #276]
	ldr	r1, [sp, #16]
	umlal	r8, r2, r6, r7
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #356]
	str	r7, [sp, #20]
	umull	r7, r4, r1, r4
	veor q0, q0, q1
	vorr q0, q0, q0
	ldr	r1, [sp, #8]
	str	r8, [sp, #28]
	vldrw.u32 q0, [r10, #52]
	vldrw.u32 q1, [r10, #132]
	veor q0, q0, q1
	umlal	r7, r4, r1, r6
	umull	r8, r6, r6, r5
	vldrw.u32 q1, [r10, #212]
	veor q0, q0, q1
	mov	r5, r1
	ldr	r1, [sp, #24]
	vldrw.u32 q1, [r10, #292]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #372]
	umlal	r7, r4, r3, r0
	umlal	r8, r6, r5, r1
	veor q0, q0, q1
	vorr q0, q0, q0
	ldr	r5, [sp, #56]
	mov	r1, r3
	vldrw.u32 q0, [r10, #68]
	vldrw.u32 q1, [r10, #148]
	veor q0, q0, q1
	umlal	r8, r6, r5, r0
	ldr	r5, [sp, #20]
	vldrw.u32 q1, [r10, #228]
	veor q0, q0, q1
	umlal	r8, r6, r3, r5
	ldr	r3, [lr, #28]
	vldrw.u32 q1, [r10, #308]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #388]
	str	r6, [sp, #88]
	mov	r6, r3
	veor q0, q0, q1
	vorr q0, q0, q0
	str	r8, [sp, #72]
	mov	r8, r4
	vldrw.u32 q0, [r11, #284]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	ldr	r3, [lr, #32]
	str	r6, [sp, #68]
	vldrw.u32 q2, [r11, #252]
	veor q1, q1, q2
	str	r3, [sp, #64]
	ldr	r3, [lr]
	vorr q1, q1, q1
	vldrw.u32 q0, [r11, #204]
	add	lr, r6, r6, lsl #3
	add	lr, r6, lr, lsl #1
	vldrw.u32 q2, [r11, #332]
	veor q0, q0, q2
	vorr q0, q0, q0
	umlal	r7, r8, lr, r5
	str	r8, [sp, #92]
	vldrw.u32 q0, [r11, #300]
	vshl.i32 q1, q0, #1
	mov	r8, r2
	str	r3, [sp, #60]
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #188]
	veor q1, q1, q2
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #36]
	vorr q1, q1, q1
	vldrw.u32 q0, [r11, #220]
	ldr	r3, [r3, #20]
	ldr	r6, [sp, #28]
	vldrw.u32 q2, [r11, #268]
	veor q0, q0, q2
	vorr q0, q0, q0
	umlal	r9, r2, r1, r3
	ldr	r5, [sp, #56]
	vldrw.u32 q0, [r11, #316]
	vshl.i32 q1, q0, #1
	str	r9, [sp, #80]
	umlal	r6, r8, r5, r3
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #204]
	veor q1, q1, q2
	mov	r5, r2
	ldr	r2, [sp, #68]
	vorr q1, q1, q1
	vldrw.u32 q0, [r11, #236]
	ldr	r4, [sp, #72]
	mul	r9, ip, r2
	vldrw.u32 q2, [r11, #284]
	veor q0, q0, q2
	vorr q0, q0, q0
	str	r8, [sp, #24]
	ldr	r2, [sp, #44]
	vldrw.u32 q0, [r11, #332]
	vshl.i32 q1, q0, #1
	mov	r8, r6
	ldr	r6, [sp, #88]
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #220]
	mul	ip, ip, r2
	umlal	r4, r6, r9, r3
	veor q1, q1, q2
	vorr q1, q1, q1
	vldrw.u32 q0, [r11, #252]
	str	ip, [sp, #28]
	mov	ip, r4
	vldrw.u32 q2, [r11, #300]
	veor q0, q0, q2
	ldr	r2, [sp, #64]
	str	r9, [sp, #72]
	vorr q0, q0, q0
	vldrw.u32 q0, [r11, #268]
	vshl.i32 q1, q0, #1
	add	r9, r2, r2, lsl #3
	add	r9, r2, r9, lsl #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #236]
	ldr	r2, [sp, #92]
	str	r3, [sp, #36]
	veor q1, q1, q2
	vorr q1, q1, q1
	vldrw.u32 q0, [r11, #188]
	umlal	r7, r2, r9, r3
	ldr	r3, [sp, #4]
	vldrw.u32 q2, [r11, #316]
	veor q0, q0, q2
	mov	r4, r2
	str	r7, [sp, #104]
	vorr q0, q0, q0
	vldrw.u32 q6, [r11, #348]
	vldrw.u32 q7, [r11, #428]
	ldr	r2, [sp, #24]
	ldr	r7, [r3, #16]
	vldrw.u32 q0, [r10, #-508]
	vldrw.u32 q1, [r10, #4]
	umlal	ip, r6, r9, r7
	umlal	r8, r2, r1, r7
	veor q0, q0, q6
	veor q1, q1, q7
	vorr q2, q0, q0
	str	r8, [sp, #88]
	str	r6, [sp, #100]
	vorr q2, q2, q2
	vorr q3, q1, q1
	mov	r6, r1
	ldr	r3, [sp, #80]
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-428]
	str	ip, [sp, #96]
	umlal	r3, r5, lr, r7
	vldrw.u32 q1, [r10, #84]
	veor q0, q0, q6
	veor q1, q1, q7
	str	r3, [sp, #92]
	ldr	r3, [sp, #16]
	vshl.i32 q2, q0, #18
	vsri.32 q2, q0, #14
	str	r7, [sp, #24]
	umull	ip, lr, r3, lr
	vorr q2, q2, q2
	vshl.i32 q3, q1, #18
	vsri.32 q3, q1, #14
	ldr	r3, [sp, #8]
	str	r0, [sp, #80]
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-348]
	umlal	ip, lr, r3, r1
	ldr	r1, [sp, #16]
	vldrw.u32 q1, [r10, #164]
	veor q0, q0, q6
	veor q1, q1, q7
	umlal	ip, lr, r9, r0
	umull	r7, r8, r6, r1
	vshl.i32 q2, q1, #2
	vsri.32 q2, q1, #30
	ldr	r1, [sp, #56]
	ldr	r6, [sp, #72]
	vorr q2, q2, q2
	vshl.i32 q3, q0, #1
	vsri.32 q3, q0, #31
	umlal	r7, r8, r3, r1
	umlal	r7, r8, r6, r0
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-268]
	ldr	r6, [sp, #20]
	ldr	r1, [sp, #28]
	vldrw.u32 q1, [r10, #244]
	veor q0, q0, q6
	veor q1, q1, q7
	umlal	r7, r8, r9, r6
	ldr	r3, [sp, #36]
	vshl.i32 q2, q1, #21
	vsri.32 q2, q1, #11
	ldr	r0, [sp, #24]
	umlal	r7, r8, r1, r3
	vorr q2, q2, q2
	vshl.i32 q3, q0, #20
	mov	r1, r7
	ldr	r3, [sp, #60]
	vsri.32 q3, q0, #12
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-188]
	ldr	r7, [sp, #24]
	umlal	r1, r8, r7, r3
	vldrw.u32 q1, [r10, #324]
	veor q0, q0, q6
	str	r8, [sp, #120]
	mov	r8, r4
	veor q1, q1, q7
	vshl.i32 q2, q0, #9
	vsri.32 q2, q0, #23
	str	r1, [sp, #116]
	ldr	r1, [sp, #44]
	vorr q2, q2, q2
	vshl.i32 q3, q1, #9
	ldr	r3, [sp, #60]
	add	r7, r1, r1, lsl #3
	vsri.32 q3, q1, #23
	vorr q3, q3, q3
	vldrw.u32 q6, [r11, #364]
	add	r7, r1, r7, lsl #1
	umlal	ip, lr, r7, r6
	vldrw.u32 q7, [r11, #444]
	vldrw.u32 q0, [r10, #-492]
	ldr	r1, [sp, #104]
	ldr	r6, [sp, #36]
	vldrw.u32 q1, [r10, #20]
	veor q0, q0, q6
	veor q1, q1, q7
	umlal	r1, r8, r7, r0
	umlal	ip, lr, r6, r3
	vshl.i32 q2, q1, #1
	vsri.32 q2, q1, #31
	str	r1, [sp, #56]
	ldr	r6, [sp, #4]
	vorr q2, q2, q2
	vorr q3, q0, q0
	vorr q3, q3, q3
	ldr	r1, [sp, #52]
	ldr	r4, [sp, #72]
	vldrw.u32 q0, [r10, #-412]
	vldrw.u32 q1, [r10, #100]
	umlal	ip, lr, r0, r1
	ldr	r1, [r6, #12]
	veor q0, q0, q6
	veor q1, q1, q7
	ldr	r0, [sp, #88]
	str	r8, [sp, #108]
	vshl.i32 q2, q0, #22
	vsri.32 q2, q0, #10
	vorr q2, q2, q2
	umlal	r0, r2, r4, r1
	ldr	r4, [sp, #92]
	vshl.i32 q3, q1, #22
	vsri.32 q3, q1, #10
	str	r0, [sp, #60]
	umlal	r4, r5, r9, r1
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-332]
	vldrw.u32 q1, [r10, #180]
	str	r5, [sp, #88]
	mov	r8, r4
	veor q0, q0, q6
	veor q1, q1, q7
	ldr	r5, [sp, #28]
	ldr	r4, [sp, #96]
	vshl.i32 q2, q0, #5
	vsri.32 q2, q0, #27
	vorr q2, q2, q2
	ldr	r6, [sp, #100]
	ldr	r0, [sp, #4]
	vshl.i32 q3, q1, #5
	vsri.32 q3, q1, #27
	umlal	r4, r6, r5, r1
	ldr	r5, [sp, #56]
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-252]
	vldrw.u32 q1, [r10, #260]
	str	r4, [sp, #104]
	ldr	r4, [sp, #108]
	veor q0, q0, q6
	veor q1, q1, q7
	str	r1, [sp, #56]
	umlal	r5, r4, r1, r3
	vshl.i32 q2, q1, #23
	vsri.32 q2, q1, #9
	vorr q2, q2, q2
	str	r5, [sp, #112]
	ldr	r5, [sp, #12]
	vshl.i32 q3, q0, #22
	vsri.32 q3, q0, #10
	umlal	ip, lr, r1, r5
	ldr	r1, [r0, #8]
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-172]
	mov	r0, r2
	mov	r2, r1
	vldrw.u32 q1, [r10, #340]
	veor q0, q0, q6
	veor q1, q1, q7
	ldr	r5, [sp, #60]
	str	r3, [sp, #60]
	vshl.i32 q2, q0, #1
	vsri.32 q2, q0, #31
	umlal	r5, r0, r9, r1
	ldr	r1, [sp, #88]
	vorr q2, q2, q2
	vshl.i32 q3, q1, #1
	vsri.32 q3, q1, #31
	str	r0, [sp, #96]
	ldr	r0, [sp, #104]
	vorr q3, q3, q3
	vldrw.u32 q6, [r11, #380]
	umlal	r8, r1, r7, r2
	umlal	r0, r6, r2, r3
	vldrw.u32 q7, [r11, #460]
	vldrw.u32 q0, [r10, #-476]
	vldrw.u32 q1, [r10, #36]
	str	r5, [sp, #92]
	strd	r0, r6, [sp, #104]
	veor q0, q0, q6
	veor q1, q1, q7
	ldr	r5, [sp, #112]
	ldr	r6, [sp, #52]
	vshl.i32 q2, q0, #31
	vsri.32 q2, q0, #1
	vorr q2, q2, q2
	str	r1, [sp, #100]
	ldr	r1, [sp, #48]
	vshl.i32 q3, q1, #31
	vsri.32 q3, q1, #1
	umlal	r5, r4, r2, r6
	umlal	ip, lr, r2, r1
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-396]
	vldrw.u32 q1, [r10, #116]
	str	r2, [sp, #88]
	ldr	r2, [sp, #16]
	veor q0, q0, q6
	veor q1, q1, q7
	ldr	r0, [sp, #80]
	umull	r6, r7, r2, r7
	vshl.i32 q2, q0, #3
	vsri.32 q2, q0, #29
	ldr	r2, [sp, #8]
	str	r5, [sp, #112]
	vorr q2, q2, q2
	vshl.i32 q3, q1, #3
	vsri.32 q3, q1, #29
	umlal	r6, r7, r2, r9
	umlal	r6, r7, r0, r3
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-316]
	ldr	r5, [sp, #52]
	ldr	r3, [sp, #20]
	vldrw.u32 q1, [r10, #196]
	veor q0, q0, q6
	veor q1, q1, q7
	str	lr, [sp, #128]
	umlal	r6, r7, r3, r5
	vshl.i32 q2, q1, #22
	vsri.32 q2, q1, #10
	str	ip, [sp, #124]
	ldr	r3, [sp, #36]
	vorr q2, q2, q2
	vshl.i32 q3, q0, #21
	vsri.32 q3, q0, #11
	ldr	r5, [sp, #12]
	umlal	r6, r7, r3, r5
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-236]
	ldr	r3, [sp, #24]
	ldr	r5, [sp, #76]
	vldrw.u32 q1, [r10, #276]
	veor q0, q0, q6
	veor q1, q1, q7
	umlal	r6, r7, r3, r1
	ldr	r1, [sp, #56]
	vshl.i32 q2, q1, #8
	vsri.32 q2, q1, #24
	ldr	r3, [sp, #32]
	umlal	r6, r7, r1, r3
	vorr q2, q2, q2
	vshl.i32 q3, q0, #7
	vsri.32 q3, q0, #25
	mov	ip, r6
	ldr	r6, [sp, #88]
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-156]
	ldr	r3, [sp, #16]
	umlal	ip, r7, r6, r5
	vldrw.u32 q1, [r10, #356]
	veor q0, q0, q6
	str	ip, [sp, #136]
	umull	ip, r6, r9, r3
	veor q1, q1, q7
	vshl.i32 q2, q1, #31
	vsri.32 q2, q1, #1
	ldr	r5, [sp, #72]
	ldr	r3, [sp, #20]
	vorr q2, q2, q2
	vshl.i32 q3, q0, #30
	umlal	ip, r6, r2, r5
	ldr	r5, [sp, #28]
	vsri.32 q3, q0, #2
	vorr q3, q3, q3
	vldrw.u32 q6, [r11, #396]
	ldr	r2, [sp, #4]
	umlal	ip, r6, r5, r0
	vldrw.u32 q7, [r11, #476]
	vldrw.u32 q0, [r10, #-460]
	ldr	r0, [sp, #60]
	umlal	ip, r6, r3, r0
	vldrw.u32 q1, [r10, #52]
	veor q0, q0, q6
	veor q1, q1, q7
	ldrd	r3, lr, [r2]
	str	r3, [sp, #4]
	vshl.i32 q2, q0, #14
	vsri.32 q2, q0, #18
	ldrd	r3, r1, [sp, #92]
	umlal	r3, r1, r5, lr
	vorr q2, q2, q2
	vshl.i32 q3, q1, #14
	vsri.32 q3, q1, #18
	str	r1, [sp, #60]
	ldr	r1, [sp, #100]
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-380]
	mov	r9, r3
	umlal	r8, r1, lr, r0
	vldrw.u32 q1, [r10, #132]
	veor q0, q0, q6
	mov	r3, r0
	mov	r5, r1
	veor q1, q1, q7
	vshl.i32 q2, q1, #28
	vsri.32 q2, q1, #4
	str	r6, [sp, #132]
	ldr	r1, [sp, #12]
	vorr q2, q2, q2
	vshl.i32 q3, q0, #27
	ldr	r6, [sp, #112]
	umlal	r6, r4, lr, r1
	vsri.32 q3, q0, #5
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-300]
	ldr	r1, [sp, #32]
	str	r6, [sp, #96]
	vldrw.u32 q1, [r10, #212]
	veor q0, q0, q6
	ldrd	r0, r6, [sp, #124]
	umlal	r0, r6, lr, r1
	veor q1, q1, q7
	vshl.i32 q2, q1, #13
	vsri.32 q2, q1, #19
	mov	r2, r6
	mov	r1, r0
	vorr q2, q2, q2
	vshl.i32 q3, q0, #12
	ldr	r6, [sp, #60]
	ldr	r0, [sp, #4]
	vsri.32 q3, q0, #20
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-220]
	umlal	r9, r6, r3, r0
	str	r9, [sp, #60]
	vldrw.u32 q1, [r10, #292]
	veor q0, q0, q6
	mov	r9, r5
	str	r6, [sp, #72]
	veor q1, q1, q7
	vshl.i32 q2, q1, #11
	vsri.32 q2, q1, #21
	ldr	r0, [sp, #52]
	ldr	r6, [sp, #4]
	vorr q2, q2, q2
	vshl.i32 q3, q0, #10
	ldr	r5, [sp, #48]
	umlal	r8, r9, r0, r6
	vsri.32 q3, q0, #22
	vorr q3, q3, q3
	str	r8, [sp, #52]
	mov	r8, r4
	vldrw.u32 q0, [r10, #-140]
	vldrw.u32 q1, [r10, #372]
	veor q0, q0, q6
	ldr	r6, [sp, #96]
	ldr	r4, [sp, #4]
	veor q1, q1, q7
	vshl.i32 q2, q0, #28
	str	r9, [sp, #92]
	umlal	r6, r8, r5, r4
	vsri.32 q2, q0, #4
	vorr q2, q2, q2
	vshl.i32 q3, q1, #28
	mov	r4, r2
	str	r8, [sp, #112]
	vsri.32 q3, q1, #4
	vorr q3, q3, q3
	mov	r8, r1
	ldr	r2, [sp, #4]
	vldrw.u32 q6, [r11, #412]
	vldrw.u32 q7, [r11, #492]
	vldrw.u32 q0, [r10, #-444]
	ldr	r5, [sp, #76]
	str	r6, [sp, #100]
	vldrw.u32 q1, [r10, #68]
	veor q0, q0, q6
	umlal	r8, r4, r5, r2
	ldr	r5, [sp, #136]
	veor q1, q1, q7
	vshl.i32 q2, q1, #14
	vsri.32 q2, q1, #18
	str	r4, [sp, #128]
	ldr	r4, [sp, #84]
	vorr q2, q2, q2
	vshl.i32 q3, q0, #13
	str	r8, [sp, #124]
	umlal	r5, r7, lr, r4
	vsri.32 q3, q0, #19
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-364]
	mov	r8, r5
	ldrd	r6, r5, [sp, #116]
	vldrw.u32 q1, [r10, #148]
	veor q0, q0, q6
	mov	r9, r7
	ldr	r4, [sp, #68]
	veor q1, q1, q7
	vshl.i32 q2, q0, #10
	lsls	r7, r0, #1
	umlal	r8, r9, r4, r2
	vsri.32 q2, q0, #22
	vorr q2, q2, q2
	vshl.i32 q3, q1, #10
	ldr	r4, [sp, #36]
	ldr	r2, [sp, #132]
	vsri.32 q3, q1, #22
	vorr q3, q3, q3
	str	r9, [sp, #140]
	umlal	ip, r2, r4, r7
	vldrw.u32 q0, [r10, #-284]
	vldrw.u32 q1, [r10, #228]
	veor q0, q0, q6
	mov	r1, ip
	ldr	r4, [sp, #56]
	veor q1, q1, q7
	vshl.i32 q2, q1, #20
	mov	r9, r1
	umlal	r6, r5, r4, r7
	vsri.32 q2, q1, #12
	vorr q2, q2, q2
	vshl.i32 q3, q0, #19
	mov	ip, r5
	mov	r5, r6
	vsri.32 q3, q0, #13
	vorr q3, q3, q3
	ldrd	r4, r6, [sp, #104]
	umlal	r4, r6, lr, r7
	vldrw.u32 q0, [r10, #-204]
	vldrw.u32 q1, [r10, #308]
	veor q0, q0, q6
	str	r8, [sp, #136]
	mov	r8, r6
	veor q1, q1, q7
	vshl.i32 q2, q0, #4
	ldr	r1, [sp, #24]
	ldr	r6, [sp, #12]
	vsri.32 q2, q0, #28
	vorr q2, q2, q2
	vshl.i32 q3, q1, #4
	umlal	r9, r2, r1, r6
	ldr	r1, [sp, #12]
	vsri.32 q3, q1, #28
	vorr q3, q3, q3
	str	r9, [sp, #104]
	mov	r9, r5
	vldrw.u32 q0, [r10, #-124]
	vldrw.u32 q1, [r10, #388]
	ldr	r5, [sp, #4]
	str	r2, [sp, #108]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #7
	umlal	r4, r8, r1, r5
	mov	r5, r0
	vsri.32 q2, q0, #25
	vorr q2, q2, q2
	ldr	r2, [sp, #88]
	str	r8, [sp, #96]
	vshl.i32 q3, q1, #7
	vsri.32 q3, q1, #25
	vorr q3, q3, q3
	ldr	r0, [sp, #16]
	str	r4, [sp, #88]
	vldrw.u32 q0, [r10, #404]
	vldrw.u32 q1, [r10, #420]
	umull	r4, r5, r0, r5
	ldr	r6, [sp, #8]
	vldrw.u32 q2, [r10, #436]
	vldrw.u32 q3, [r10, #452]
	vldrw.u32 q4, [r10, #468]
	umlal	r9, ip, r2, r1
	umlal	r4, r5, r6, r3
	vbic q5, q2, q1
	veor q5, q5, q0
	umull	r3, r1, r0, r3
	mov	r0, r6
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	ldr	r6, [sp, #28]
	umlal	r3, r1, r0, r6
	vorr q5, q5, q5
	vbic q5, q4, q3
	ldr	r6, [sp, #12]
	ldr	r0, [sp, #80]
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	umlal	r3, r1, r0, r7
	umlal	r4, r5, r0, r6
	veor q5, q5, q3
	vorr q5, q5, q5
	ldr	r7, [sp, #20]
	ldr	r0, [sp, #48]
	vbic q5, q1, q0
	veor q5, q5, q4
	umlal	r3, r1, r7, r6
	lsl	r8, r0, #1
	vorr q5, q5, q5
	vldrw.u32 q0, [r10, #484]
	vldrw.u32 q1, [r10, #500]
	umlal	r4, r5, r7, r0
	ldr	r6, [sp, #108]
	vldrw.u32 q2, [r11, #-500]
	vldrw.u32 q3, [r11, #-484]
	ldr	r7, [sp, #56]
	ldr	r0, [sp, #104]
	vldrw.u32 q4, [r11, #-468]
	vbic q5, q2, q1
	veor q5, q5, q0
	umlal	r9, ip, lr, r8
	umlal	r0, r6, r7, r8
	vorr q5, q5, q5
	vbic q5, q3, q2
	mov	r7, r0
	ldr	r0, [sp, #36]
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	umlal	r3, r1, r0, r8
	str	r3, [sp, #8]
	veor q5, q5, q2
	vorr q5, q5, q5
	ldr	r3, [sp, #32]
	umlal	r4, r5, r0, r3
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	ldr	r0, [sp, #24]
	str	r4, [sp, #16]
	vbic q5, q1, q0
	veor q5, q5, q4
	ldr	r4, [sp, #8]
	umlal	r7, r6, r2, r3
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #-452]
	vldrw.u32 q1, [r11, #-436]
	umlal	r4, r1, r0, r3
	strd	r4, r1, [sp, #8]
	vldrw.u32 q2, [r11, #-420]
	vldrw.u32 q3, [r11, #-404]
	ldr	r1, [sp, #76]
	ldr	r4, [sp, #16]
	vldrw.u32 q4, [r11, #-388]
	vbic q5, q2, q1
	lsl	r8, r1, #1
	umlal	r4, r5, r0, r1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	mov	r0, r3
	umlal	r7, r6, lr, r8
	veor q5, q5, q1
	vorr q5, q5, q5
	ldr	r3, [sp, #4]
	umlal	r9, ip, r0, r3
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	ldrd	r3, r1, [sp, #8]
	ldr	r0, [sp, #56]
	vbic q5, q0, q4
	veor q5, q5, q3
	str	r6, [sp, #8]
	umlal	r3, r1, r0, r8
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	ldr	r6, [sp, #84]
	mov	r8, r7
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #-372]
	umlal	r4, r5, r0, r6
	mov	r0, r2
	vldrw.u32 q1, [r11, #-356]
	vldrw.u32 q2, [r11, #-340]
	vldrw.u32 q3, [r11, #-324]
	umlal	r3, r1, r2, r6
	ldrd	r7, r2, [sp, #4]
	vldrw.u32 q4, [r11, #-308]
	vbic q5, q2, q1
	umlal	r8, r2, r6, r7
	ldr	r7, [sp, #68]
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	mov	r6, r2
	umlal	r4, r5, r0, r7
	veor q5, q5, q1
	vorr q5, q5, q5
	ldr	r0, [sp, #64]
	lsls	r7, r7, #1
	vbic q5, q4, q3
	veor q5, q5, q2
	umlal	r4, r5, lr, r0
	umlal	r3, r1, lr, r7
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	mov	lr, r4
	str	r8, [sp, #8]
	vorr q5, q5, q5
	vbic q5, q1, q0
	ldr	r2, [sp, #4]
	ldr	r4, [sp, #60]
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #-292]
	umlal	r3, r1, r0, r2
	str	r3, [sp, #12]
	vldrw.u32 q1, [r11, #-276]
	vldrw.u32 q2, [r11, #-260]
	ldr	r3, [sp, #44]
	ldr	r7, [sp, #52]
	vldrw.u32 q3, [r11, #-244]
	vldrw.u32 q4, [r11, #-228]
	vbic q5, q2, q1
	umlal	lr, r5, r2, r3
	ldr	r2, [sp, #72]
	veor q5, q5, q0
	vorr q5, q5, q5
	lsrs	r3, r4, #26
	orr	r3, r3, r2, lsl #6
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	adds	r3, r7, r3
	ldr	r7, [sp, #92]
	vbic q5, q4, q3
	veor q5, q5, q2
	bic	r4, r4, #-67108864
	adc	r2, r7, r2, lsr #26
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	str	r4, [sp, #4]
	ldr	r7, [sp, #88]
	vorr q5, q5, q5
	vbic q5, q1, q0
	mov	r0, lr
	lsrs	r4, r3, #25
	veor q5, q5, q4
	vorr q5, q5, q5
	orr	r4, r4, r2, lsl #7
	adds	r4, r7, r4
	vldrw.u32 q0, [r11, #-212]
	vldrw.u32 q1, [r11, #-196]
	vldrw.u32 q2, [r11, #-180]
	ldr	r7, [sp, #96]
	lsr	lr, r4, #26
	vldrw.u32 q3, [r11, #-164]
	vldrw.u32 q4, [r11, #-148]
	adc	r2, r7, r2, lsr #25
	ldr	r7, [sp, #100]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	orr	lr, lr, r2, lsl #6
	adds	lr, r7, lr
	vbic q5, q3, q2
	veor q5, q5, q1
	ldr	r7, [sp, #112]
	lsr	r8, lr, #25
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	adc	r2, r7, r2, lsr #26
	orr	r8, r8, r2, lsl #7
	vorr q5, q5, q5
	vbic q5, q0, q4
	ldr	r7, [sp, #40]
	adds	r8, r9, r8
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	bic	lr, lr, #-33554432
	adc	r2, ip, r2, lsr #25
	veor q5, q5, q4
	vorr q5, q5, q5
	str	lr, [r7, #12]
	lsr	ip, r8, #26
	vldrw.u32 q0, [r11, #-132]
	vldrw.u32 q1, [r11, #-116]
	vldrw.u32 q2, [r11, #-100]
	ldr	r7, [sp, #124]
	orr	ip, ip, r2, lsl #6
	vldrw.u32 q3, [r11, #-84]
	vldrw.u32 q4, [r11, #-68]
	adds	ip, r7, ip
	ldr	r7, [sp, #128]
	vbic q5, q2, q1
	veor q5, q5, q0
	bic	r8, r8, #-67108864
	adc	r2, r7, r2, lsr #26
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	ldr	r7, [sp, #40]
	lsr	lr, ip, #25
	vorr q5, q5, q5
	vbic q5, q4, q3
	str	r8, [r7, #16]
	ldr	r7, [sp, #8]
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	orr	lr, lr, r2, lsl #7
	adds	lr, r7, lr
	veor q5, q5, q3
	vorr q5, q5, q5
	ldr	r7, [sp, #40]
	adc	r2, r6, r2, lsr #25
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	bic	r6, ip, #-33554432
	str	r6, [r7, #20]
	vldrw.u32 q0, [r11, #-52]
	vldrw.u32 q1, [r11, #-36]
	ldr	r7, [sp, #136]
	lsr	r6, lr, #26
	vldrw.u32 q2, [r11, #-20]
	vldrw.u32 q3, [r11, #-4]
	vldrw.u32 q4, [r11, #12]
	orr	r6, r6, r2, lsl #6
	adds	r6, r7, r6
	vbic q5, q2, q1
	veor q5, q5, q0
	ldr	r7, [sp, #140]
	bic	lr, lr, #-67108864
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	adc	r2, r7, r2, lsr #26
	ldr	r7, [sp, #40]
	vorr q5, q5, q5
	vbic q5, q4, q3
	lsr	ip, r6, #25
	str	lr, [r7, #24]
	veor q5, q5, q2
	vorr q5, q5, q5
	ldr	r7, [sp, #12]
	orr	ip, ip, r2, lsl #7
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	adds	ip, r7, ip
	adc	r1, r1, r2, lsr #25
	vbic q5, q1, q0
	veor q5, q5, q4
	lsr	r2, ip, #26
	ldr	r7, [sp, #40]
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #28]
	vldrw.u32 q1, [r11, #44]
	orr	r2, r2, r1, lsl #6
	adds	r9, r0, r2
	vldrw.u32 q2, [r11, #60]
	vldrw.u32 q3, [r11, #76]
	bic	r6, r6, #-33554432
	adc	r5, r5, r1, lsr #26
	vldrw.u32 q4, [r11, #92]
	vbic q5, q2, q1
	veor q5, q5, q0
	str	r6, [r7, #28]
	bic	r2, ip, #-67108864
	vorr q5, q5, q5
	vbic q5, q3, q2
	lsr	r6, r9, #25
	orr	r6, r6, r5, lsl #7
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	str	r2, [r7, #32]
	lsrs	r5, r5, #25
	veor q5, q5, q2
	vorr q5, q5, q5
	bic	r2, r9, #-33554432
	str	r2, [r7, #36]
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	lsls	r1, r5, #3
	lsls	r2, r6, #3
	vbic q5, q1, q0
	veor q5, q5, q4
	adds	r2, r2, r6
	orr	r1, r1, r6, lsr #29
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #108]
	adc	r1, r5, r1
	adds	r2, r2, r2
	vldrw.u32 q1, [r11, #124]
	vldrw.u32 q2, [r11, #140]
	vldrw.u32 q3, [r11, #156]
	adcs	r1, r1, r1
	adds	r2, r2, r6
	vldrw.u32 q4, [r11, #172]
	vbic q5, q2, q1
	adc	r5, r5, r1
	ldr	r1, [sp, #4]
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	bic	r3, r3, #-33554432
	adds	r2, r2, r1
	veor q5, q5, q1
	vorr q5, q5, q5
	adc	r5, r5, #0
	lsrs	r1, r2, #26
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	orr	r1, r1, r5, lsl #6
	add	r3, r3, r1
	vbic q5, q0, q4
	veor q5, q5, q3
	bic	r4, r4, #-67108864
	bic	r2, r2, #-67108864
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	bic	r1, r3, #-33554432
	add	r4, r4, r3, lsr #25
	vorr q5, q5, q5
	vmov.i32 q0, #1
	strd	r2, r1, [r7]
	str	r4, [r7, #8]
	vldrw.u32 q1, [r10, #-508]
	veor q1, q1, q0
	vorr q1, q1, q1
	ldr r0, [sp, #148]
	subs r0, r0, #1
	str r0, [sp, #148]
	bne 1b
	add sp, sp, #156
	vpop {d8-d15}
	pop {r4-r11, pc}

// expq_seq
.global expq_seq
.type expq_seq, %function
.thumb_func
.balign 16
expq_seq:
	push {r4-r11, lr}
	vpush {d8-d15}
	sub sp, sp, #156
	str r0, [sp, #148]
	movw r10, #:lower16:g_mve
	movt r10, #:upper16:g_mve
	add r10, r10, #508
	movw r11, #:lower16:g_mve
	movt r11, #:upper16:g_mve
	add r11, r11, #1524
.balign 16
1:
	movw r0, #:lower16:g_fc_out
	movt r0, #:upper16:g_fc_out
	movw r1, #:lower16:g_fc_a
	movt r1, #:upper16:g_fc_a
	movw r2, #:lower16:g_fc_b
	movt r2, #:upper16:g_fc_b
	mov	r3, r1
	mov	lr, r2
	ldr	r1, [r2, #36]
	ldr	r2, [r3, #36]
	mov	ip, #38
	mov	r6, r2
	str	r1, [sp, #44]
	ldr	r1, [lr, #12]
	ldr	r2, [r3, #32]
	add	r9, r1, r1, lsl #3
	add	r9, r1, r9, lsl #1
	ldr	r4, [lr, #8]
	umull	r9, r5, r9, r2
	str	r0, [sp, #40]
	add	r8, r4, r4, lsl #3
	mov	r0, r3
	ldr	r3, [lr, #4]
	add	r8, r4, r8, lsl #1
	str	r2, [sp, #16]
	umlal	r9, r5, r6, r8
	str	r4, [sp, #12]
	umull	r8, r2, r8, r2
	mul	r4, ip, r3
	umlal	r8, r2, r6, r4
	mul	r4, ip, r1
	str	r3, [sp, #52]
	ldr	r3, [lr, #16]
	str	r6, [sp, #8]
	add	r6, r3, r3, lsl #3
	add	r6, r3, r6, lsl #1
	str	r3, [sp, #32]
	mov	r3, r4
	ldr	r7, [lr, #20]
	ldr	r4, [r0, #28]
	str	r0, [sp, #4]
	umlal	r9, r5, r6, r4
	mov	r0, r4
	umlal	r8, r2, r3, r4
	add	r4, r7, r7, lsl #3
	add	r4, r7, r4, lsl #1
	str	r7, [sp, #76]
	mul	r7, ip, r7
	str	r1, [sp, #48]
	ldr	r1, [lr, #24]
	str	r7, [sp, #56]
	add	r7, r1, r1, lsl #3
	str	r1, [sp, #84]
	add	r7, r1, r7, lsl #1
	mov	r1, r5
	str	r3, [sp, #24]
	mov	r3, r7
	ldr	r7, [sp, #4]
	ldr	r5, [sp, #16]
	ldr	r7, [r7, #24]
	umlal	r9, r1, r4, r7
	str	r1, [sp, #36]
	ldr	r1, [sp, #16]
	umlal	r8, r2, r6, r7
	str	r7, [sp, #20]
	umull	r7, r4, r1, r4
	ldr	r1, [sp, #8]
	str	r8, [sp, #28]
	umlal	r7, r4, r1, r6
	umull	r8, r6, r6, r5
	mov	r5, r1
	ldr	r1, [sp, #24]
	umlal	r7, r4, r3, r0
	umlal	r8, r6, r5, r1
	ldr	r5, [sp, #56]
	mov	r1, r3
	umlal	r8, r6, r5, r0
	ldr	r5, [sp, #20]
	umlal	r8, r6, r3, r5
	ldr	r3, [lr, #28]
	str	r6, [sp, #88]
	mov	r6, r3
	str	r8, [sp, #72]
	mov	r8, r4
	ldr	r3, [lr, #32]
	str	r6, [sp, #68]
	str	r3, [sp, #64]
	ldr	r3, [lr]
	add	lr, r6, r6, lsl #3
	add	lr, r6, lr, lsl #1
	umlal	r7, r8, lr, r5
	str	r8, [sp, #92]
	mov	r8, r2
	str	r3, [sp, #60]
	ldr	r3, [sp, #4]
	ldr	r2, [sp, #36]
	ldr	r3, [r3, #20]
	ldr	r6, [sp, #28]
	umlal	r9, r2, r1, r3
	ldr	r5, [sp, #56]
	str	r9, [sp, #80]
	umlal	r6, r8, r5, r3
	mov	r5, r2
	ldr	r2, [sp, #68]
	ldr	r4, [sp, #72]
	mul	r9, ip, r2
	str	r8, [sp, #24]
	ldr	r2, [sp, #44]
	mov	r8, r6
	ldr	r6, [sp, #88]
	mul	ip, ip, r2
	umlal	r4, r6, r9, r3
	str	ip, [sp, #28]
	mov	ip, r4
	ldr	r2, [sp, #64]
	str	r9, [sp, #72]
	add	r9, r2, r2, lsl #3
	add	r9, r2, r9, lsl #1
	ldr	r2, [sp, #92]
	str	r3, [sp, #36]
	umlal	r7, r2, r9, r3
	ldr	r3, [sp, #4]
	mov	r4, r2
	str	r7, [sp, #104]
	ldr	r2, [sp, #24]
	ldr	r7, [r3, #16]
	umlal	ip, r6, r9, r7
	umlal	r8, r2, r1, r7
	str	r8, [sp, #88]
	str	r6, [sp, #100]
	mov	r6, r1
	ldr	r3, [sp, #80]
	str	ip, [sp, #96]
	umlal	r3, r5, lr, r7
	str	r3, [sp, #92]
	ldr	r3, [sp, #16]
	str	r7, [sp, #24]
	umull	ip, lr, r3, lr
	ldr	r3, [sp, #8]
	str	r0, [sp, #80]
	umlal	ip, lr, r3, r1
	ldr	r1, [sp, #16]
	umlal	ip, lr, r9, r0
	umull	r7, r8, r6, r1
	ldr	r1, [sp, #56]
	ldr	r6, [sp, #72]
	umlal	r7, r8, r3, r1
	umlal	r7, r8, r6, r0
	ldr	r6, [sp, #20]
	ldr	r1, [sp, #28]
	umlal	r7, r8, r9, r6
	ldr	r3, [sp, #36]
	ldr	r0, [sp, #24]
	umlal	r7, r8, r1, r3
	mov	r1, r7
	ldr	r3, [sp, #60]
	ldr	r7, [sp, #24]
	umlal	r1, r8, r7, r3
	str	r8, [sp, #120]
	mov	r8, r4
	str	r1, [sp, #116]
	ldr	r1, [sp, #44]
	ldr	r3, [sp, #60]
	add	r7, r1, r1, lsl #3
	add	r7, r1, r7, lsl #1
	umlal	ip, lr, r7, r6
	ldr	r1, [sp, #104]
	ldr	r6, [sp, #36]
	umlal	r1, r8, r7, r0
	umlal	ip, lr, r6, r3
	str	r1, [sp, #56]
	ldr	r6, [sp, #4]
	ldr	r1, [sp, #52]
	ldr	r4, [sp, #72]
	umlal	ip, lr, r0, r1
	ldr	r1, [r6, #12]
	ldr	r0, [sp, #88]
	str	r8, [sp, #108]
	umlal	r0, r2, r4, r1
	ldr	r4, [sp, #92]
	str	r0, [sp, #60]
	umlal	r4, r5, r9, r1
	str	r5, [sp, #88]
	mov	r8, r4
	ldr	r5, [sp, #28]
	ldr	r4, [sp, #96]
	ldr	r6, [sp, #100]
	ldr	r0, [sp, #4]
	umlal	r4, r6, r5, r1
	ldr	r5, [sp, #56]
	str	r4, [sp, #104]
	ldr	r4, [sp, #108]
	str	r1, [sp, #56]
	umlal	r5, r4, r1, r3
	str	r5, [sp, #112]
	ldr	r5, [sp, #12]
	umlal	ip, lr, r1, r5
	ldr	r1, [r0, #8]
	mov	r0, r2
	mov	r2, r1
	ldr	r5, [sp, #60]
	str	r3, [sp, #60]
	umlal	r5, r0, r9, r1
	ldr	r1, [sp, #88]
	str	r0, [sp, #96]
	ldr	r0, [sp, #104]
	umlal	r8, r1, r7, r2
	umlal	r0, r6, r2, r3
	str	r5, [sp, #92]
	strd	r0, r6, [sp, #104]
	ldr	r5, [sp, #112]
	ldr	r6, [sp, #52]
	str	r1, [sp, #100]
	ldr	r1, [sp, #48]
	umlal	r5, r4, r2, r6
	umlal	ip, lr, r2, r1
	str	r2, [sp, #88]
	ldr	r2, [sp, #16]
	ldr	r0, [sp, #80]
	umull	r6, r7, r2, r7
	ldr	r2, [sp, #8]
	str	r5, [sp, #112]
	umlal	r6, r7, r2, r9
	umlal	r6, r7, r0, r3
	ldr	r5, [sp, #52]
	ldr	r3, [sp, #20]
	str	lr, [sp, #128]
	umlal	r6, r7, r3, r5
	str	ip, [sp, #124]
	ldr	r3, [sp, #36]
	ldr	r5, [sp, #12]
	umlal	r6, r7, r3, r5
	ldr	r3, [sp, #24]
	ldr	r5, [sp, #76]
	umlal	r6, r7, r3, r1
	ldr	r1, [sp, #56]
	ldr	r3, [sp, #32]
	umlal	r6, r7, r1, r3
	mov	ip, r6
	ldr	r6, [sp, #88]
	ldr	r3, [sp, #16]
	umlal	ip, r7, r6, r5
	str	ip, [sp, #136]
	umull	ip, r6, r9, r3
	ldr	r5, [sp, #72]
	ldr	r3, [sp, #20]
	umlal	ip, r6, r2, r5
	ldr	r5, [sp, #28]
	ldr	r2, [sp, #4]
	umlal	ip, r6, r5, r0
	ldr	r0, [sp, #60]
	umlal	ip, r6, r3, r0
	ldrd	r3, lr, [r2]
	str	r3, [sp, #4]
	ldrd	r3, r1, [sp, #92]
	umlal	r3, r1, r5, lr
	str	r1, [sp, #60]
	ldr	r1, [sp, #100]
	mov	r9, r3
	umlal	r8, r1, lr, r0
	mov	r3, r0
	mov	r5, r1
	str	r6, [sp, #132]
	ldr	r1, [sp, #12]
	ldr	r6, [sp, #112]
	umlal	r6, r4, lr, r1
	ldr	r1, [sp, #32]
	str	r6, [sp, #96]
	ldrd	r0, r6, [sp, #124]
	umlal	r0, r6, lr, r1
	mov	r2, r6
	mov	r1, r0
	ldr	r6, [sp, #60]
	ldr	r0, [sp, #4]
	umlal	r9, r6, r3, r0
	str	r9, [sp, #60]
	mov	r9, r5
	str	r6, [sp, #72]
	ldr	r0, [sp, #52]
	ldr	r6, [sp, #4]
	ldr	r5, [sp, #48]
	umlal	r8, r9, r0, r6
	str	r8, [sp, #52]
	mov	r8, r4
	ldr	r6, [sp, #96]
	ldr	r4, [sp, #4]
	str	r9, [sp, #92]
	umlal	r6, r8, r5, r4
	mov	r4, r2
	str	r8, [sp, #112]
	mov	r8, r1
	ldr	r2, [sp, #4]
	ldr	r5, [sp, #76]
	str	r6, [sp, #100]
	umlal	r8, r4, r5, r2
	ldr	r5, [sp, #136]
	str	r4, [sp, #128]
	ldr	r4, [sp, #84]
	str	r8, [sp, #124]
	umlal	r5, r7, lr, r4
	mov	r8, r5
	ldrd	r6, r5, [sp, #116]
	mov	r9, r7
	ldr	r4, [sp, #68]
	lsls	r7, r0, #1
	umlal	r8, r9, r4, r2
	ldr	r4, [sp, #36]
	ldr	r2, [sp, #132]
	str	r9, [sp, #140]
	umlal	ip, r2, r4, r7
	mov	r1, ip
	ldr	r4, [sp, #56]
	mov	r9, r1
	umlal	r6, r5, r4, r7
	mov	ip, r5
	mov	r5, r6
	ldrd	r4, r6, [sp, #104]
	umlal	r4, r6, lr, r7
	str	r8, [sp, #136]
	mov	r8, r6
	ldr	r1, [sp, #24]
	ldr	r6, [sp, #12]
	umlal	r9, r2, r1, r6
	ldr	r1, [sp, #12]
	str	r9, [sp, #104]
	mov	r9, r5
	ldr	r5, [sp, #4]
	str	r2, [sp, #108]
	umlal	r4, r8, r1, r5
	mov	r5, r0
	ldr	r2, [sp, #88]
	str	r8, [sp, #96]
	ldr	r0, [sp, #16]
	str	r4, [sp, #88]
	umull	r4, r5, r0, r5
	ldr	r6, [sp, #8]
	umlal	r9, ip, r2, r1
	umlal	r4, r5, r6, r3
	umull	r3, r1, r0, r3
	mov	r0, r6
	ldr	r6, [sp, #28]
	umlal	r3, r1, r0, r6
	ldr	r6, [sp, #12]
	ldr	r0, [sp, #80]
	umlal	r3, r1, r0, r7
	umlal	r4, r5, r0, r6
	ldr	r7, [sp, #20]
	ldr	r0, [sp, #48]
	umlal	r3, r1, r7, r6
	lsl	r8, r0, #1
	umlal	r4, r5, r7, r0
	ldr	r6, [sp, #108]
	ldr	r7, [sp, #56]
	ldr	r0, [sp, #104]
	umlal	r9, ip, lr, r8
	umlal	r0, r6, r7, r8
	mov	r7, r0
	ldr	r0, [sp, #36]
	umlal	r3, r1, r0, r8
	str	r3, [sp, #8]
	ldr	r3, [sp, #32]
	umlal	r4, r5, r0, r3
	ldr	r0, [sp, #24]
	str	r4, [sp, #16]
	ldr	r4, [sp, #8]
	umlal	r7, r6, r2, r3
	umlal	r4, r1, r0, r3
	strd	r4, r1, [sp, #8]
	ldr	r1, [sp, #76]
	ldr	r4, [sp, #16]
	lsl	r8, r1, #1
	umlal	r4, r5, r0, r1
	mov	r0, r3
	umlal	r7, r6, lr, r8
	ldr	r3, [sp, #4]
	umlal	r9, ip, r0, r3
	ldrd	r3, r1, [sp, #8]
	ldr	r0, [sp, #56]
	str	r6, [sp, #8]
	umlal	r3, r1, r0, r8
	ldr	r6, [sp, #84]
	mov	r8, r7
	umlal	r4, r5, r0, r6
	mov	r0, r2
	umlal	r3, r1, r2, r6
	ldrd	r7, r2, [sp, #4]
	umlal	r8, r2, r6, r7
	ldr	r7, [sp, #68]
	mov	r6, r2
	umlal	r4, r5, r0, r7
	ldr	r0, [sp, #64]
	lsls	r7, r7, #1
	umlal	r4, r5, lr, r0
	umlal	r3, r1, lr, r7
	mov	lr, r4
	str	r8, [sp, #8]
	ldr	r2, [sp, #4]
	ldr	r4, [sp, #60]
	umlal	r3, r1, r0, r2
	str	r3, [sp, #12]
	ldr	r3, [sp, #44]
	ldr	r7, [sp, #52]
	umlal	lr, r5, r2, r3
	ldr	r2, [sp, #72]
	lsrs	r3, r4, #26
	orr	r3, r3, r2, lsl #6
	adds	r3, r7, r3
	ldr	r7, [sp, #92]
	bic	r4, r4, #-67108864
	adc	r2, r7, r2, lsr #26
	str	r4, [sp, #4]
	ldr	r7, [sp, #88]
	mov	r0, lr
	lsrs	r4, r3, #25
	orr	r4, r4, r2, lsl #7
	adds	r4, r7, r4
	ldr	r7, [sp, #96]
	lsr	lr, r4, #26
	adc	r2, r7, r2, lsr #25
	ldr	r7, [sp, #100]
	orr	lr, lr, r2, lsl #6
	adds	lr, r7, lr
	ldr	r7, [sp, #112]
	lsr	r8, lr, #25
	adc	r2, r7, r2, lsr #26
	orr	r8, r8, r2, lsl #7
	ldr	r7, [sp, #40]
	adds	r8, r9, r8
	bic	lr, lr, #-33554432
	adc	r2, ip, r2, lsr #25
	str	lr, [r7, #12]
	lsr	ip, r8, #26
	ldr	r7, [sp, #124]
	orr	ip, ip, r2, lsl #6
	adds	ip, r7, ip
	ldr	r7, [sp, #128]
	bic	r8, r8, #-67108864
	adc	r2, r7, r2, lsr #26
	ldr	r7, [sp, #40]
	lsr	lr, ip, #25
	str	r8, [r7, #16]
	ldr	r7, [sp, #8]
	orr	lr, lr, r2, lsl #7
	adds	lr, r7, lr
	ldr	r7, [sp, #40]
	adc	r2, r6, r2, lsr #25
	bic	r6, ip, #-33554432
	str	r6, [r7, #20]
	ldr	r7, [sp, #136]
	lsr	r6, lr, #26
	orr	r6, r6, r2, lsl #6
	adds	r6, r7, r6
	ldr	r7, [sp, #140]
	bic	lr, lr, #-67108864
	adc	r2, r7, r2, lsr #26
	ldr	r7, [sp, #40]
	lsr	ip, r6, #25
	str	lr, [r7, #24]
	ldr	r7, [sp, #12]
	orr	ip, ip, r2, lsl #7
	adds	ip, r7, ip
	adc	r1, r1, r2, lsr #25
	lsr	r2, ip, #26
	ldr	r7, [sp, #40]
	orr	r2, r2, r1, lsl #6
	adds	r9, r0, r2
	bic	r6, r6, #-33554432
	adc	r5, r5, r1, lsr #26
	str	r6, [r7, #28]
	bic	r2, ip, #-67108864
	lsr	r6, r9, #25
	orr	r6, r6, r5, lsl #7
	str	r2, [r7, #32]
	lsrs	r5, r5, #25
	bic	r2, r9, #-33554432
	str	r2, [r7, #36]
	lsls	r1, r5, #3
	lsls	r2, r6, #3
	adds	r2, r2, r6
	orr	r1, r1, r6, lsr #29
	adc	r1, r5, r1
	adds	r2, r2, r2
	adcs	r1, r1, r1
	adds	r2, r2, r6
	adc	r5, r5, r1
	ldr	r1, [sp, #4]
	bic	r3, r3, #-33554432
	adds	r2, r2, r1
	adc	r5, r5, #0
	lsrs	r1, r2, #26
	orr	r1, r1, r5, lsl #6
	add	r3, r3, r1
	bic	r4, r4, #-67108864
	bic	r2, r2, #-67108864
	bic	r1, r3, #-33554432
	add	r4, r4, r3, lsr #25
	strd	r2, r1, [r7]
	str	r4, [r7, #8]
	vldrw.u32 q0, [r10, #-508]
	vldrw.u32 q1, [r10, #-428]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-348]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-268]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-188]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #-492]
	vldrw.u32 q1, [r10, #-412]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-332]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-252]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-172]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #-476]
	vldrw.u32 q1, [r10, #-396]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-316]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-236]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-156]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #-460]
	vldrw.u32 q1, [r10, #-380]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-300]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-220]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-140]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #-444]
	vldrw.u32 q1, [r10, #-364]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-284]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-204]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #-124]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #4]
	vldrw.u32 q1, [r10, #84]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #164]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #244]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #324]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #20]
	vldrw.u32 q1, [r10, #100]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #180]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #260]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #340]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #36]
	vldrw.u32 q1, [r10, #116]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #196]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #276]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #356]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #52]
	vldrw.u32 q1, [r10, #132]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #212]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #292]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #372]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r10, #68]
	vldrw.u32 q1, [r10, #148]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #228]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #308]
	veor q0, q0, q1
	vldrw.u32 q1, [r10, #388]
	veor q0, q0, q1
	vorr q0, q0, q0
	vldrw.u32 q0, [r11, #284]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #252]
	veor q1, q1, q2
	vorr q1, q1, q1
	vldrw.u32 q0, [r11, #204]
	vldrw.u32 q2, [r11, #332]
	veor q0, q0, q2
	vorr q0, q0, q0
	vldrw.u32 q0, [r11, #300]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #188]
	veor q1, q1, q2
	vorr q1, q1, q1
	vldrw.u32 q0, [r11, #220]
	vldrw.u32 q2, [r11, #268]
	veor q0, q0, q2
	vorr q0, q0, q0
	vldrw.u32 q0, [r11, #316]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #204]
	veor q1, q1, q2
	vorr q1, q1, q1
	vldrw.u32 q0, [r11, #236]
	vldrw.u32 q2, [r11, #284]
	veor q0, q0, q2
	vorr q0, q0, q0
	vldrw.u32 q0, [r11, #332]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #220]
	veor q1, q1, q2
	vorr q1, q1, q1
	vldrw.u32 q0, [r11, #252]
	vldrw.u32 q2, [r11, #300]
	veor q0, q0, q2
	vorr q0, q0, q0
	vldrw.u32 q0, [r11, #268]
	vshl.i32 q1, q0, #1
	vsri.32 q1, q0, #31
	vldrw.u32 q2, [r11, #236]
	veor q1, q1, q2
	vorr q1, q1, q1
	vldrw.u32 q0, [r11, #188]
	vldrw.u32 q2, [r11, #316]
	veor q0, q0, q2
	vorr q0, q0, q0
	vldrw.u32 q6, [r11, #348]
	vldrw.u32 q7, [r11, #428]
	vldrw.u32 q0, [r10, #-508]
	vldrw.u32 q1, [r10, #4]
	veor q0, q0, q6
	veor q1, q1, q7
	vorr q2, q0, q0
	vorr q2, q2, q2
	vorr q3, q1, q1
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-428]
	vldrw.u32 q1, [r10, #84]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #18
	vsri.32 q2, q0, #14
	vorr q2, q2, q2
	vshl.i32 q3, q1, #18
	vsri.32 q3, q1, #14
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-348]
	vldrw.u32 q1, [r10, #164]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #2
	vsri.32 q2, q1, #30
	vorr q2, q2, q2
	vshl.i32 q3, q0, #1
	vsri.32 q3, q0, #31
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-268]
	vldrw.u32 q1, [r10, #244]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #21
	vsri.32 q2, q1, #11
	vorr q2, q2, q2
	vshl.i32 q3, q0, #20
	vsri.32 q3, q0, #12
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-188]
	vldrw.u32 q1, [r10, #324]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #9
	vsri.32 q2, q0, #23
	vorr q2, q2, q2
	vshl.i32 q3, q1, #9
	vsri.32 q3, q1, #23
	vorr q3, q3, q3
	vldrw.u32 q6, [r11, #364]
	vldrw.u32 q7, [r11, #444]
	vldrw.u32 q0, [r10, #-492]
	vldrw.u32 q1, [r10, #20]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #1
	vsri.32 q2, q1, #31
	vorr q2, q2, q2
	vorr q3, q0, q0
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-412]
	vldrw.u32 q1, [r10, #100]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #22
	vsri.32 q2, q0, #10
	vorr q2, q2, q2
	vshl.i32 q3, q1, #22
	vsri.32 q3, q1, #10
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-332]
	vldrw.u32 q1, [r10, #180]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #5
	vsri.32 q2, q0, #27
	vorr q2, q2, q2
	vshl.i32 q3, q1, #5
	vsri.32 q3, q1, #27
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-252]
	vldrw.u32 q1, [r10, #260]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #23
	vsri.32 q2, q1, #9
	vorr q2, q2, q2
	vshl.i32 q3, q0, #22
	vsri.32 q3, q0, #10
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-172]
	vldrw.u32 q1, [r10, #340]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #1
	vsri.32 q2, q0, #31
	vorr q2, q2, q2
	vshl.i32 q3, q1, #1
	vsri.32 q3, q1, #31
	vorr q3, q3, q3
	vldrw.u32 q6, [r11, #380]
	vldrw.u32 q7, [r11, #460]
	vldrw.u32 q0, [r10, #-476]
	vldrw.u32 q1, [r10, #36]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #31
	vsri.32 q2, q0, #1
	vorr q2, q2, q2
	vshl.i32 q3, q1, #31
	vsri.32 q3, q1, #1
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-396]
	vldrw.u32 q1, [r10, #116]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #3
	vsri.32 q2, q0, #29
	vorr q2, q2, q2
	vshl.i32 q3, q1, #3
	vsri.32 q3, q1, #29
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-316]
	vldrw.u32 q1, [r10, #196]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #22
	vsri.32 q2, q1, #10
	vorr q2, q2, q2
	vshl.i32 q3, q0, #21
	vsri.32 q3, q0, #11
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-236]
	vldrw.u32 q1, [r10, #276]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #8
	vsri.32 q2, q1, #24
	vorr q2, q2, q2
	vshl.i32 q3, q0, #7
	vsri.32 q3, q0, #25
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-156]
	vldrw.u32 q1, [r10, #356]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #31
	vsri.32 q2, q1, #1
	vorr q2, q2, q2
	vshl.i32 q3, q0, #30
	vsri.32 q3, q0, #2
	vorr q3, q3, q3
	vldrw.u32 q6, [r11, #396]
	vldrw.u32 q7, [r11, #476]
	vldrw.u32 q0, [r10, #-460]
	vldrw.u32 q1, [r10, #52]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #14
	vsri.32 q2, q0, #18
	vorr q2, q2, q2
	vshl.i32 q3, q1, #14
	vsri.32 q3, q1, #18
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-380]
	vldrw.u32 q1, [r10, #132]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #28
	vsri.32 q2, q1, #4
	vorr q2, q2, q2
	vshl.i32 q3, q0, #27
	vsri.32 q3, q0, #5
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-300]
	vldrw.u32 q1, [r10, #212]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #13
	vsri.32 q2, q1, #19
	vorr q2, q2, q2
	vshl.i32 q3, q0, #12
	vsri.32 q3, q0, #20
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-220]
	vldrw.u32 q1, [r10, #292]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #11
	vsri.32 q2, q1, #21
	vorr q2, q2, q2
	vshl.i32 q3, q0, #10
	vsri.32 q3, q0, #22
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-140]
	vldrw.u32 q1, [r10, #372]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #28
	vsri.32 q2, q0, #4
	vorr q2, q2, q2
	vshl.i32 q3, q1, #28
	vsri.32 q3, q1, #4
	vorr q3, q3, q3
	vldrw.u32 q6, [r11, #412]
	vldrw.u32 q7, [r11, #492]
	vldrw.u32 q0, [r10, #-444]
	vldrw.u32 q1, [r10, #68]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #14
	vsri.32 q2, q1, #18
	vorr q2, q2, q2
	vshl.i32 q3, q0, #13
	vsri.32 q3, q0, #19
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-364]
	vldrw.u32 q1, [r10, #148]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #10
	vsri.32 q2, q0, #22
	vorr q2, q2, q2
	vshl.i32 q3, q1, #10
	vsri.32 q3, q1, #22
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-284]
	vldrw.u32 q1, [r10, #228]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q1, #20
	vsri.32 q2, q1, #12
	vorr q2, q2, q2
	vshl.i32 q3, q0, #19
	vsri.32 q3, q0, #13
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-204]
	vldrw.u32 q1, [r10, #308]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #4
	vsri.32 q2, q0, #28
	vorr q2, q2, q2
	vshl.i32 q3, q1, #4
	vsri.32 q3, q1, #28
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #-124]
	vldrw.u32 q1, [r10, #388]
	veor q0, q0, q6
	veor q1, q1, q7
	vshl.i32 q2, q0, #7
	vsri.32 q2, q0, #25
	vorr q2, q2, q2
	vshl.i32 q3, q1, #7
	vsri.32 q3, q1, #25
	vorr q3, q3, q3
	vldrw.u32 q0, [r10, #404]
	vldrw.u32 q1, [r10, #420]
	vldrw.u32 q2, [r10, #436]
	vldrw.u32 q3, [r10, #452]
	vldrw.u32 q4, [r10, #468]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r10, #484]
	vldrw.u32 q1, [r10, #500]
	vldrw.u32 q2, [r11, #-500]
	vldrw.u32 q3, [r11, #-484]
	vldrw.u32 q4, [r11, #-468]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #-452]
	vldrw.u32 q1, [r11, #-436]
	vldrw.u32 q2, [r11, #-420]
	vldrw.u32 q3, [r11, #-404]
	vldrw.u32 q4, [r11, #-388]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #-372]
	vldrw.u32 q1, [r11, #-356]
	vldrw.u32 q2, [r11, #-340]
	vldrw.u32 q3, [r11, #-324]
	vldrw.u32 q4, [r11, #-308]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #-292]
	vldrw.u32 q1, [r11, #-276]
	vldrw.u32 q2, [r11, #-260]
	vldrw.u32 q3, [r11, #-244]
	vldrw.u32 q4, [r11, #-228]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #-212]
	vldrw.u32 q1, [r11, #-196]
	vldrw.u32 q2, [r11, #-180]
	vldrw.u32 q3, [r11, #-164]
	vldrw.u32 q4, [r11, #-148]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #-132]
	vldrw.u32 q1, [r11, #-116]
	vldrw.u32 q2, [r11, #-100]
	vldrw.u32 q3, [r11, #-84]
	vldrw.u32 q4, [r11, #-68]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #-52]
	vldrw.u32 q1, [r11, #-36]
	vldrw.u32 q2, [r11, #-20]
	vldrw.u32 q3, [r11, #-4]
	vldrw.u32 q4, [r11, #12]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #28]
	vldrw.u32 q1, [r11, #44]
	vldrw.u32 q2, [r11, #60]
	vldrw.u32 q3, [r11, #76]
	vldrw.u32 q4, [r11, #92]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vldrw.u32 q0, [r11, #108]
	vldrw.u32 q1, [r11, #124]
	vldrw.u32 q2, [r11, #140]
	vldrw.u32 q3, [r11, #156]
	vldrw.u32 q4, [r11, #172]
	vbic q5, q2, q1
	veor q5, q5, q0
	vorr q5, q5, q5
	vbic q5, q3, q2
	veor q5, q5, q1
	vorr q5, q5, q5
	vbic q5, q4, q3
	veor q5, q5, q2
	vorr q5, q5, q5
	vbic q5, q0, q4
	veor q5, q5, q3
	vorr q5, q5, q5
	vbic q5, q1, q0
	veor q5, q5, q4
	vorr q5, q5, q5
	vmov.i32 q0, #1
	vldrw.u32 q1, [r10, #-508]
	veor q1, q1, q0
	vorr q1, q1, q1
	ldr r0, [sp, #148]
	subs r0, r0, #1
	str r0, [sp, #148]
	bne 1b
	add sp, sp, #156
	vpop {d8-d15}
	pop {r4-r11, pc}

