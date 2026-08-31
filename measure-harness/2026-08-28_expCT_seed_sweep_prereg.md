# 실험 CT 사전등록 — B-mid(156명령) CP-SAT seed 민감도

> 날짜: 2026-08-28
> 동기: 리뷰어3 재심 1.5 — "모델 예측 오차 5–12%인 solver가 1.3–3.4% 개선을 냈다면
> 그 개선이 모델 덕인지 운인지 구분하려면 seed 여러 개가 필요하다."

## 질문

같은 입력(`exp_bmid.s`, 156명령), 같은 모델·목적함수·worker 1·`PYTHONHASHSEED=0`에서
CP-SAT `random_seed`만 바꾸면 (i) 최종 목적값(cycles)과 (ii) 생성 스케줄이 달라지는가?

## 설계

- seed ∈ {42, 1, 2, 3, 7, 11, 23, 101}, 8회. 42는 기존 재생(expCN)과의 대조.
- 드라이버 `run_exp_bmid.py`에서 seed를 환경변수로 받게 하는 두 줄만 바꾼다. 모델·제약·
  timeout(300 s)·분할 휴리스틱은 불변.
- 기록: 마지막 `split_estimate_perf` 목적값(Cycles, IPC), OPTIMAL/FEASIBLE, 출력 `.s`의
  SHA-256, wall time.
- **보드 측정은 하지 않는다.** 이 실험은 solver 목적값의 seed 분산만 본다. 목적값 82와
  보드 실측 85.06의 관계(모델 오차)는 여기서 다루지 않는다.

## 사전 예측

- **H1 (목적값 불변):** 8 seed 모두 최종 목적값 82 cycles, 상태 OPTIMAL. 마지막 창은
  8 s 안에 OPTIMAL로 닫혔으므로 seed는 탐색 순서만 바꾸고 최적값은 못 바꾼다.
  *반증:* 어느 seed든 83 이상이거나 FEASIBLE로 끝나면 "156명령 개선 3.4%는 seed 운"
  가능성을 원고에 명시한다.
- **H2 (스케줄은 달라질 수 있음):** 출력 `.s` 해시는 seed마다 다를 수 있다. 같은 목적값의
  서로 다른 최적해가 존재하기 때문이며 이것은 결함이 아니다.

## 한계

- 1,184명령 실행(FEASIBLE timeout 창 2개)은 돌리지 않는다. 창당 600 s × 재시도 × 8 seed는
  이 세션 예산 밖이다. 그 결과의 seed 의존성은 **미측정**으로 남는다.
- 목적값 분산이 0이어도 "보드 개선이 모델 덕"이라는 증명은 아니다. 모델 오차 5–12%는
  별개 문제다.

## 산출물

- `artifacts/2026-08-28_expCT_seed_sweep/seed{N}.log`, `seed{N}.s`, `summary.txt`
- 결과: `2026-08-28_expCT_results.md`
