# 실험 AI 사전등록 — AE2 encaps 불균형의 경로·구간 분해

## 목적과 고정된 기존 판정

AE2 flash 배치에서 `F→U` encaps 손실 약 442k cycles는 keygen 손실 약 55k의 8.1배였다.
후속 AF가 U8 instruction working set의 flash 배치를 주원인으로 이미 확인했으므로, 이번
실험은 그 판정을 번복하지 않는다. **U 기각은 확정**이며, AI는 현재 코드 배치에서 2-job
경로와 잔여 ladder 비용을 같은 ELF로 분해해 논문 해석 근거를 보강한다.

## 질문과 변형

- F: 두 X25519 job을 모두 scalar Fiat direct로 수행한다.
- U: 두 job을 queue에 넣어 2-job U8 융합 경로로 수행한다.
- U1: job 0만 queue/U4로 융합하고 job 1은 scalar Fiat direct로 수행한다.
- 각 경로에서 (1) ML-KEM/x4 호출과 함께 실행되는 융합 구간, (2) 그 뒤 queue finish와
  scalar direct가 실행되는 잔여 ladder 구간을 DWT 체크포인트로 분리한다.

## 구현과 단일 변수

- `harness_expAE_staged.c`의 사본 `harness_expAI_staged.c`에 encaps 전용 F/U/U1 경로와
  체크포인트만 추가한다. 기존 ML-KEM, Keccak x4, Fiat/U assembly는 바꾸지 않는다.
- F↔U와 F↔U1을 각각 ABBA로 측정한다. seed·공개키·ML-KEM 모드·코드 배치는 동일하다.
- U1의 scalar job 1은 U1 잔여 구간에 포함한다. queue 준비와 입력 복사는 측정 전에 둔다.
- 전체 encaps 시간, 융합 구간, 잔여 구간을 각각 보존한다. 체크포인트 장벽의 공통 비용은
  경로 차분에서 상쇄하며 절대 구간값에는 `측정 오버헤드 포함`으로 표시한다.

## 사전등록 분기

초과 비용은 빈 구간 없이 다음 합으로 분류한다.

1. **2-job 융합 경로 자체:** `U−U1`의 융합 구간 차분 및 U8/U4 경로 차분.
2. **잔여 ladder 직렬화:** F/U/U1의 finish+scalar 구간 차분.
3. **x4·스티칭 상호작용:** 융합 구간 차분 중 U4/U8 순수 계산량으로 설명되지 않는 부분.
4. **미분류:** 위 세 항의 합과 전체 차분 사이의 잔여. 크기와 부호를 그대로 기록한다.

예측: 2-job 융합 자체가 지배적이면 U1 총시간은 `U`보다 작고, 대략 F의 공통 ML-KEM
시간 + U4 융합 job 0 + scalar job 1 비용에 가까워진다. 반대로 잔여 ladder가 지배적이면
U와 U1의 잔여 구간에서 큰 양의 차이가 남는다. 예측과 다르면 측정 뒤 새 분기를 만들지
않고 위 4번에 넣는다.

## 측정 방법과 정확성 게이트

- EK-RA8M1, DWT CYCCNT, N=100, F→U와 F→U1 각각 ABBA.
- 독립 flash/run 2회, 로그
  `logs/2026-08-24_expAI_encaps_attribution_run{1,2}.txt`.
- RFC 7748 4종, SHA3, x4/U primitive KAT, 8-seed X-Wing full output/reject,
  timing, stack/canary, 새 F/U/U1 ciphertext·shared-secret 일치가 모두 0 mismatch.
- `harness_fails=0`. 하나라도 실패하면 해당 run의 성능값은 기각한다.
- 결과는 `2026-08-24_expAI_results.md`에 쓰며 귀속되지 않은 차이는 반드시 “미분류”로
  남긴다.

