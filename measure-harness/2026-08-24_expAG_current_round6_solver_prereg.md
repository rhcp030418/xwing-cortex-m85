# 실험 AG 사전등록 — 현재 round6 재료의 지퍼 대 SLOTHY 재대결

## 질문

현재 `round_stream6()` 재료로 SLOTHY B-full을 다시 풀어 같은 펌웨어에서 측정해도 솔버가
수동 `stitched-round6` 이상인가. 08-16의 `681→657(−3.5%)`은 역사 세대 비교이며 이번
판정에 직접 사용하지 않는다.

## 단일 변수와 구현

- A는 기존 `mul256_flatY`와 `gen_exp_b.py`의 안전 변환을 그대로 쓴다.
- B만 측정 시작 시점의 `stitch_zip.py:round_stream6()`으로 다시 생성한다.
- `gen_exp_b.py`가 보고하는 실제 B 명령 수를 정본으로 기록한다. 프롬프트의 647과 다르면
  추정으로 맞추지 않고 생성기 출력과 함수 래퍼 포함 여부를 함께 기록한다.
- `patch_slothy_v81m.py` v0.2가 적용된 WSL2 SLOTHY 환경에서 `run_exp_b.py`를 실행한다.
- 기존 `exp_b.s`, `exp_b_opt.s`, `exp_b.log`, e2 `bfull_board.s`는 덮어쓰기 전에 백업한다.
  새 솔브 로그는 `exp_b_20260824.log`, 새 출력은 `exp_b_opt_20260824.s`로 보존한다.

## 측정 방법

- 새 솔버 출력으로 `gen_board_bfull.py`를 실행하고 e2 프로젝트를 clean build한다.
- 같은 ELF에서 `bfull-seq`, `stitched-round6`, `bfull-slothy`를 측정한다.
- 독립 flash/run 2회, N=100 중앙값, calib 25 차감.
- 로그:
  - `logs/2026-08-24_expAG_current_round6_run1.txt`
  - `logs/2026-08-24_expAG_current_round6_run2.txt`

## 정확성 게이트

- 생성된 B-full seq/solver의 곱 결과와 Keccak lane 결과 mismatch 0.
- stitched-round6 mismatch 0, 전체 KAT와 다른 하네스 gate 통과.
- `harness_fails=0`.
- 실패 run은 성능 판정에서 제외한다.

## 사전 판정

- 같은 run에서 `solver <= stitched-round6`이면 3단계 성공 조건을 유지하고 현재 세대
  세 값(순차·지퍼·솔버)으로 수치를 갱신한다.
- `solver > stitched-round6`이면 부정 결과로 기록하고 08-16 동세대 비교는 역사 각주로만
  남긴다.
- 두 run 중 하나라도 비교 부호가 바뀌면 동률/잡음으로 판정하고 범위를 그대로 보고한다.

