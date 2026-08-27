// 실험 B-mid: 곱 패턴 8그룹 + Keccak theta 전체 — 순차 연접 (156명령)
start:
        umull r0, r1, r4, r5
        umaal r0, r1, r4, r6
        adds r2, r2, r0
        adcs r3, r3, r1
        umull r0, r1, r5, r6
        adds r2, r2, r0
        adc r3, r3, r1
        umull r0, r1, r4, r5
        umaal r0, r1, r4, r6
        adds r2, r2, r0
        adcs r3, r3, r1
        umull r0, r1, r5, r6
        adds r2, r2, r0
        adc r3, r3, r1
        umull r0, r1, r4, r5
        umaal r0, r1, r4, r6
        adds r2, r2, r0
        adcs r3, r3, r1
        umull r0, r1, r5, r6
        adds r2, r2, r0
        adc r3, r3, r1
        umull r0, r1, r4, r5
        umaal r0, r1, r4, r6
        adds r2, r2, r0
        adcs r3, r3, r1
        umull r0, r1, r5, r6
        adds r2, r2, r0
        adc r3, r3, r1
        umull r0, r1, r4, r5
        umaal r0, r1, r4, r6
        adds r2, r2, r0
        adcs r3, r3, r1
        umull r0, r1, r5, r6
        adds r2, r2, r0
        adc r3, r3, r1
        umull r0, r1, r4, r5
        umaal r0, r1, r4, r6
        adds r2, r2, r0
        adcs r3, r3, r1
        umull r0, r1, r5, r6
        adds r2, r2, r0
        adc r3, r3, r1
        umull r0, r1, r4, r5
        umaal r0, r1, r4, r6
        adds r2, r2, r0
        adcs r3, r3, r1
        umull r0, r1, r5, r6
        adds r2, r2, r0
        adc r3, r3, r1
        umull r0, r1, r4, r5
        umaal r0, r1, r4, r6
        adds r2, r2, r0
        adcs r3, r3, r1
        umull r0, r1, r5, r6
        adds r2, r2, r0
        adc r3, r3, r1
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
end:
