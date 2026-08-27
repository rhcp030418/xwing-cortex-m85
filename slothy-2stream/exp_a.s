// 3단계 실험 A: SLOTHY가 이어붙인 2-스트림을 스스로 교차하는가 (2026-08-16)
//
// 스트림 A = 곱 조각: umull/umaal + adds/adcs/adc 캐리 플래그 체인 (X25519 프록시)
// 스트림 B = 진짜 Keccak θ 조각: 메모리 상주, 플래그 중립 (r7=상태 포인터)
// 레지스터 분리: A=r0-r6, B=r7-r9. 입력은 순차 연접 — 교차는 솔버 몫.
//
// 관찰 포인트: ① 스케줄이 A·B를 섞는가 ② 플래그 의존(adds→adcs→adc)을 보존하는가
//             ③ selfcheck 통과 ④ 예측 스톨 수
start:
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
end:
