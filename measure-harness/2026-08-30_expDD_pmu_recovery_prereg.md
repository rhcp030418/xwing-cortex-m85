# 사전등록 - 실험 DD: EK-RA8M1 PMU 이벤트 카운터 복구와 누적 A/B 분해

작성: 2026-08-30, 보드 측정 전

## 질문

기존 하네스가 `DWT_CTRL.CYCCNTENA=1`인 상태에서 PMU를 함께 켰기 때문에
`INST_RETIRED`, `STALL_OP`, `STALL_OP_FRONTEND`, `STALL_OP_BACKEND`가 모두 0으로
나왔는가? DWT cycle counter를 끈 PMU 전용 실행에서 이벤트가 증가하며, draft-10 누적
A/B의 네 workload를 같은 동결 구현으로 계수할 수 있는가?

## 고정 대상과 변경

- 장치: 현재 연결된 EK-RA8M1 한 개체, Cortex-M85 CPUID `0x410fd232`.
- 소스 계보: `artifacts/2026-08-27_expCJ/src/`의 draft-10 누적 A/B 구현.
- 컴파일러/배치: GCC 13.2.1 `-O2`, 기존 FSP linker와 ITCM/DTCM 배치.
- 변경은 측정 제어에 한정한다.
  1. `DWT_CTRL.CYCCNTENA`를 0으로 만든다.
  2. cycle은 `PMU_CCNTR`, 사건은 PMU event counter에서 읽는다.
  3. `INST_RETIRED`, `STALL_OP`, frontend/backend stall을 16-bit counter+`CHAIN` 네 쌍으로 센다.
  4. 기존 전체 하네스 대신 KAT, A/B 8-seed 바이트 동치, PMU 자가검사와 A-B-B-A 계수만 실행한다.
- 성능 개선률의 정본은 기존 CY DWT 결과다. 이번 PMU cycle은 사건 계수와 같은 창의
  보조 교차검증이며 기존 정본을 조용히 대체하지 않는다.

## 사전 고정 게이트

각 독립 flash에서 모두 만족해야 유효하다.

1. RFC 7748/SHA3 KAT와 expCJ A/B 8-seed 전 바이트 동치가 PASS한다.
2. DWT `CYCCNTENA` readback이 0이다.
3. PMU `SW_INCR` 100회가 정확히 100이다.
4. 100,000회 NOP loop의 chained `INST_RETIRED`가 65,535보다 크고 high counter가 0이 아니다.
5. 네 workload의 A/B 모든 셀에서 cycle과 `INST_RETIRED`가 0보다 크다.
6. `STALL_OP_FRONTEND`와 `STALL_OP_BACKEND`는 각자 관측값으로 보고하며 합이
   `STALL_OP`와 같다고 가정하지 않는다.

## 반복과 채택값

- 독립 flash 두 번을 수행한다.
- 각 flash에서 A-B-B-A 네 셀을 계수한다.
- 셀별 PMU 값은 1회 operation의 결정적 사건 계수다. 네 셀을 독립 보드 표본으로 세지 않는다.
- 논문에는 두 flash 전체 범위와 A/B의 방향을 보고한다. 한 번이라도 게이트가 실패하면
  사건 수치를 결과로 채택하지 않고 실패 원인과 원시 로그만 보존한다.

## 해석 경계

- PMU 사건은 평가한 한 보드와 현 배치의 동적 계수다.
- stall 사건의 정확한 미시구조 원인을 사건 이름만으로 단정하지 않는다.
- 이번 실험은 두 번째 보드, 전력 또는 외부 최고 구현 비교를 해결하지 않는다.
