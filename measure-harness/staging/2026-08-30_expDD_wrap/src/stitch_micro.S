/* 2단계 파일럿 실험 1·2: 합성 스티칭 마이크로벤치 (2026-08-16)
 *
 * 실험 1 — M85 인오더 듀얼이슈에서 두 독립 명령 스트림을 명령어 단위로 교차하면
 *          T_stitch ≈ max(T_A, T_B)로 수렴하는가 (인텔 백서 p.2 공식의 실리콘 검증).
 *   A = 곱셈 의존 체인 (X25519 필드 곱 프록시: UMAAL, 플래그 불사용)
 *   B = 논리 연산 체인 (Keccak θ/χ 프록시: eor+ror, S 접미사 없음 = 플래그 중립)
 *   S = A·B를 1:1 교차 (레지스터 분리: A=r1-r5, B=r6-r11, 루프 카운터 r0)
 *
 * 실험 2 — 스필 세금: 실제 Keccak은 상태 200B가 메모리 상주. 레지스터 발자국을
 *          줄이는 대신 ld/st가 늘어나면(B': 8명령 중 3 ldr + 2 str) 교차 이득이 죽는가.
 *          → 2026-08-16 실측: B'≈B, S'≈S — M85 LSU가 ld/st를 병렬 흡수, 스필 세금 ≈ 0.
 *
 * 주의: 루프 헤드는 .balign 16 필수 — 정렬에 따라 ±1 cyc/iter 변동 실측됨(fetch 정렬).
 * 각 이터레이션: A·B 8명령 / S 16명령 + 루프(subs+bne — APSR 사용, 실전 제약과 동형).
 */
.section .itcm_code_from_flash, "ax", %progbits
.syntax unified
.thumb

// void stitch_mul_chain(uint32_t iters)
.global stitch_mul_chain
.type stitch_mul_chain, %function
.thumb_func
stitch_mul_chain:
    push {r4-r11, lr}
    movs r1, #3
    movs r2, #5
    movs r3, #7
    movs r4, #0
    movs r5, #0
.balign 16
1:
    umaal r4, r5, r1, r2
    umaal r4, r5, r1, r3
    umaal r4, r5, r2, r3
    umaal r4, r5, r1, r2
    umaal r4, r5, r1, r3
    umaal r4, r5, r2, r3
    umaal r4, r5, r1, r2
    umaal r4, r5, r2, r3
    subs r0, #1
    bne 1b
    pop {r4-r11, pc}

// void stitch_logic_chain(uint32_t iters)
.global stitch_logic_chain
.type stitch_logic_chain, %function
.thumb_func
stitch_logic_chain:
    push {r4-r11, lr}
    movs r6, #0x11
    movs r7, #0x22
    movs r8, #0x33
    movs r9, #0x44
    movs r10, #0x55
    movs r11, #0x66
.balign 16
1:
    eor r6, r7, r8, ror #13
    eor r7, r8, r9, ror #7
    eor r8, r9, r10, ror #3
    eor r9, r10, r11, ror #21
    eor r10, r11, r6, ror #14
    eor r11, r6, r7, ror #2
    eor r6, r7, r8, ror #9
    eor r7, r8, r9, ror #25
    subs r0, #1
    bne 1b
    pop {r4-r11, pc}

// void stitch_interleaved(uint32_t iters) — A·B 1:1 교차, 같은 총 일량
.global stitch_interleaved
.type stitch_interleaved, %function
.thumb_func
stitch_interleaved:
    push {r4-r11, lr}
    movs r1, #3
    movs r2, #5
    movs r3, #7
    movs r4, #0
    movs r5, #0
    movs r6, #0x11
    movs r7, #0x22
    movs r8, #0x33
    movs r9, #0x44
    movs r10, #0x55
    movs r11, #0x66
.balign 16
1:
    umaal r4, r5, r1, r2
    eor r6, r7, r8, ror #13
    umaal r4, r5, r1, r3
    eor r7, r8, r9, ror #7
    umaal r4, r5, r2, r3
    eor r8, r9, r10, ror #3
    umaal r4, r5, r1, r2
    eor r9, r10, r11, ror #21
    umaal r4, r5, r1, r3
    eor r10, r11, r6, ror #14
    umaal r4, r5, r2, r3
    eor r11, r6, r7, ror #2
    umaal r4, r5, r1, r2
    eor r6, r7, r8, ror #9
    umaal r4, r5, r2, r3
    eor r7, r8, r9, ror #25
    subs r0, #1
    bne 1b
    pop {r4-r11, pc}

// ---- 실험 2: 메모리 상주 스트림 B' ----

// void stitch_mem_chain(uint32_t iters, uint32_t *buf)
.global stitch_mem_chain
.type stitch_mem_chain, %function
.thumb_func
stitch_mem_chain:
    push {r4-r11, lr}
    mov r10, r1
.balign 16
1:
    ldr r6, [r10, #0]
    ldr r7, [r10, #4]
    eor r8, r6, r7, ror #13
    ldr r9, [r10, #8]
    eor r6, r8, r9, ror #7
    str r6, [r10, #0]
    eor r7, r6, r8, ror #21
    str r7, [r10, #4]
    subs r0, #1
    bne 1b
    pop {r4-r11, pc}

// void stitch_interleaved_mem(uint32_t iters, uint32_t *buf) — A × B' 1:1 교차
.global stitch_interleaved_mem
.type stitch_interleaved_mem, %function
.thumb_func
stitch_interleaved_mem:
    push {r4-r11, lr}
    mov r10, r1
    movs r1, #3
    movs r2, #5
    movs r3, #7
    movs r4, #0
    movs r5, #0
.balign 16
1:
    umaal r4, r5, r1, r2
    ldr r6, [r10, #0]
    umaal r4, r5, r1, r3
    ldr r7, [r10, #4]
    umaal r4, r5, r2, r3
    eor r8, r6, r7, ror #13
    umaal r4, r5, r1, r2
    ldr r9, [r10, #8]
    umaal r4, r5, r1, r3
    eor r6, r8, r9, ror #7
    umaal r4, r5, r2, r3
    str r6, [r10, #0]
    umaal r4, r5, r1, r2
    eor r7, r6, r8, ror #21
    umaal r4, r5, r2, r3
    str r7, [r10, #4]
    subs r0, #1
    bne 1b
    pop {r4-r11, pc}
