/* 3단계 실험 A 보드 검증: SLOTHY 스케줄 vs 원본 순차 배치 (2026-08-16)
 * 같은 17명령(2-스트림 조각)을 두 순서로 루프 실행해 cyc/iter 비교.
 * 모델 예측: 솔버 스케줄 9cyc + 루프 오버헤드. r7=상태 포인터(DTCM), lr=루프 카운터.
 * 루프 subs/bne의 플래그 사용은 본문 캐리 체인 소비 후라 합법 (라운드 경계 규칙과 동형).
 */
.text
.syntax unified
.thumb

// void slothy_expa_seq(uint32_t iters, uint32_t *state)  — 원본 연접 순서
.global slothy_expa_seq
.type slothy_expa_seq, %function
.thumb_func
slothy_expa_seq:
    push {r4-r11, lr}
    mov r7, r1
    mov lr, r0
    movs r2, #0
    movs r3, #0
    movs r4, #3
    movs r5, #5
    movs r6, #7
.balign 16
1:
    umull r0, r1, r4, r5
    umaal r0, r1, r4, r6
    adds r2, r2, r0
    adcs r3, r3, r1
    umull r0, r1, r5, r6
    adds r2, r2, r0
    adc r3, r3, r1
    ldr r8, [r7, #0]
    ldr r9, [r7, #20]
    eor r8, r8, r9
    ldr r9, [r7, #40]
    eor r8, r8, r9
    ldr r9, [r7, #60]
    eor r8, r8, r9
    ldr r9, [r7, #80]
    eor r8, r8, r9
    str r8, [r7, #200]
    subs lr, lr, #1
    bne 1b
    pop {r4-r11, pc}

// void slothy_expa_opt(uint32_t iters, uint32_t *state)  — SLOTHY OPTIMAL 스케줄
// (exp_a_opt.s 본문 그대로. 본문이 r4/r5/r6도 덮어쓰므로 iter마다 값이 변함 — 타이밍 무관)
.global slothy_expa_opt
.type slothy_expa_opt, %function
.thumb_func
slothy_expa_opt:
    push {r4-r11, lr}
    mov r7, r1
    mov lr, r0
    movs r2, #0
    movs r3, #0
    movs r4, #3
    movs r5, #5
    movs r6, #7
.balign 16
1:
    ldr r10, [r7, #0]
    umull r0, r1, r4, r5
    umull r12, r5, r5, r6
    ldr r9, [r7, #20]
    umaal r0, r1, r4, r6
    ldr r8, [r7, #60]
    eor r9, r10, r9
    ldr r10, [r7, #40]
    adds r11, r2, r0
    eor r4, r9, r10
    adcs r6, r3, r1
    eor r9, r4, r8
    adds r2, r11, r12
    ldr r12, [r7, #80]
    adc r3, r6, r5
    eor r11, r9, r12
    str r11, [r7, #200]
    subs lr, lr, #1
    bne 1b
    pop {r4-r11, pc}
