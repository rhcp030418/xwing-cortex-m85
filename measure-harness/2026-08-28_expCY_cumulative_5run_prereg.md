# 사전등록 — 실험 CY: `tab:cumulative` 동결 ELF 5-run 재측정

> 작성 2026-08-28, **측정 전**. 출처: `paper/리뷰_v12_상위학회.md` P1-1, `paper/TODO_v13.md` F1.
> 질문: 부록의 draft-10 A/B 누적 결과(25.97 / 20.25 / 11.22 / 18.30%)는 아직 독립 flash 2회다.
> 주 표(F--U)는 expCV에서 5회로 올렸다. 같은 기준을 부록 표에도 적용한다.

## 1. 대상

- 동결 이미지: `artifacts/2026-08-27_expCJ/blinky.{elf,srec}` (expCJ, ELF SHA-256 접두 `E9D32784`).
- 스크립트: 같은 폴더의 `harvest_ra8m1_expCJ.py`. **하네스·ELF·스크립트를 일절 바꾸지 않는다.**
- 독립 flash **5회**(기존 run1·run2 는 별도 세션이므로 이번 5회만으로 판정한다).

## 2. 기록

run 마다 keygen / encaps / warm decaps / cold decaps 의 A·B 셀 중앙값과 네 paired 감소율
$g=100(A-B)/A$, 그리고 `harness_fails`, KAT, 8-seed 바이트 동치, code-flash readback SHA-256.

## 3. 사전 고정 게이트

### 3.1 정확성 (하나라도 실패하면 그 run 폐기)
- 다섯 run 모두 `harness_fails=0`, `KAT ALL PASS`.
- A/B 8-seed 의 pk/sk/ct/ss/warm·cold ss/훼손 ct 암묵적 거부 바이트 mismatch 0.
- 다섯 run 의 code-flash readback SHA-256 이 서로 같을 것.

### 3.2 판정 (측정 전 고정)
- 스무 개 paired 효과(5 run × 4 위치)의 **범위**를 보고한다.
- **기존 2-run 보수값(25.97 / 20.25 / 11.22 / 18.30%)을 벗어나는 run 이 하나라도 있으면
  원고 `tab:cumulative` 를 5-run 범위로 갱신**하고, 벗어나지 않으면 "독립 다섯 번"으로
  표기만 바꾼다. 어느 쪽이든 보수적 요약(네 $g$ 중 최솟값)의 정의는 유지한다.
- 예측: 다섯 run 모두 게이트 통과, 각 연산의 스무 값 폭 < 0.05\%p.

### 3.3 상수시간
측정만 반복하며 코드를 바꾸지 않으므로 해당 없음.

## 4. 산출물

로그 `logs/2026-08-28_expCY_run{1..5}.txt`, 결과 `2026-08-28_expCY_results.md`,
데이터표 T39. 동결 이미지는 expCJ 것을 재사용하므로 새로 복사하지 않는다.
