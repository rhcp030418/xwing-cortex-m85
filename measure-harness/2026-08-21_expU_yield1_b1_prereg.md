# 실험 U 사전 등록 — yield1 + one-GP b1 실현 가능성 게이트

## 배경과 정정

리서치 보고서의 최우선 제안은 b2의 연속 접근과 no-yield scalar를 동시에
유지하는 phase-scoped register leasing이다. 다만 보고서의 "no-yield가 r11을
쓰지 않는다"는 정적 관찰은 틀렸다. 실제 GCC 출력은 `fp`라는 별칭으로
r11을 사용한다.

따라서 완전한 동적 borrowing을 바로 만들지 않고, GCC로 r10 또는 r11 하나만
양보한 scalar와, b2의 한 앵커만 GP 연속 접근으로 남기고 나머지를 q7
개더/스캐터로 바꾼 b1 하이브리드를 먼저 측정한다.

## 단일 질문

> yield2의 GP 2개 양보를 1개로 줄이면, 부분 gather 비용보다 scalar 회수량이
> 커서 현재 b2+yield2 선택 경로보다 빨라지는가?

## 변형과 통제

- scalar A: `-O2 -fno-tree-slp-vectorize` 공통.
  - `y10`: `-ffixed-r10`
  - `y11`: `-ffixed-r11`
- MVE B: 기능 등가인 b2 주소 매핑을 유지한다.
  - `lo10`, `lo11`: 저위 앵커의 166개 접근은 GP 연속, 고위 136개는 q7 gather/scatter.
  - `hi11`: 고위 136개는 GP 연속, 저위 166개는 q7 gather/scatter.
- 각 family는 MVE solo, 1:1, 4:1, 8:1 순차/스티칭을 같은 펌웨어에서 측정한다.
- 기존 b2+yield2와 b0+no-yield T를 같은 펌웨어에서 다시 측정해 비교한다.

## 정적 게이트

- scalar body에 MVE Q 레지스터가 없어야 한다.
- y10 body에 r10, y11 body에 r11/`fp` 사용이 없어야 한다.
- b1 round는 611명령, `vldrw` 181개, `vstrw` 121개를 유지한다.
- q7은 주소 벡터로만 사용한다.

## 정확성 게이트

- fiat 결과를 기존 `fiat_mul_ref`와 대조한다.
- 네 개 Keccak state를 디인터리브해 scalar round reference와 대조한다.
- 전체 하네스의 X25519/SHA3/ML-KEM KAT, reject path, `harness_fails=0`을 확인한다.

## 사전 판정

모든 성능값은 실보드 전까지 `미측정`이다.

- **강한 성공:** 4:1에서 기존 b2+yield2보다 3% 이상, 8:1에서 현재 최선
  b0+no-yield보다 빠르며 정확성 게이트 통과.
- **부분 성공:** 하나의 비율에서만 현재 최선을 갱신하거나 1~3% 미만 개선.
- **실패:** 모든 실제 비율에서 현재 선택보다 느리거나 KAT/대조 실패.

강한 성공이면 완전한 phase-local b2 borrowing을 계속한다. 실패하면 register
leasing의 gross 51.58 cycle/mul을 종단간 절감으로 그대로 계상하는 가정을
폐기하고, ML-KEM NTT 실측으로 우선순위를 넘긴다.

## 실측 결과 (2026-08-21)

EK-RA8M1 Cortex-M85에서 N=100, 커널당 1,000번을 두 번 독립 플래시/실행했다.
두 실행의 주요 중앙값은 일치했고, X25519/SHA3 KAT, ML-KEM roundtrip+reject,
`expu_mismatch=0`, 전체 `harness_fails=0`을 모두 통과했다.

| 항목 | 실측 cycle/iter |
|---|---:|
| scalar r10-fixed | 266.039 |
| scalar r11-fixed | 267.040 |
| b1 low-contiguous (166 연속 / 136 gather) | 850.075 |
| b1 high-contiguous (136 연속 / 166 gather) | 910.077 |
| r11-fixed + low, 1:1 | 1,030.075 |
| r11-fixed + low, 4:1 | **1,758.064** |
| r10-fixed + low, 8:1 | **2,810.091** |

같은 펌웨어의 현재 최선과 비교하면 1:1은 947.041보다 8.77% 악화, 4:1은
1,770.028보다 **0.68% 개선**, 8:1은 b0+no-yield 2,930.673~2,930.706보다
**4.11~4.12% 개선**이다.

**사전 판정: 부분 성공.** 8:1은 강한 개선이지만, 강한 성공의 필수 조건인
4:1 3% 이상을 만족하지 못했다. 또한 이 실험은 완전한 b2+no-yield가 아니며,
보고서의 51.58 cycle/mul gross budget을 전부 회수했다고 계상하면 안 된다.

원시 로그:

- `logs/2026-08-21_expU_yield1_b1_run1.txt`
- `logs/2026-08-21_expU_yield1_b1_run2.txt`
