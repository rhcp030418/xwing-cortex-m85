# 실험 AF-pilot-rebaseline 사전등록 — 파일럿 슬롯 현재 정본 재확정

> 기존 `expAF`는 B-full/U8 귀속 실험에 이미 사용됐다. 기록 충돌을 피하려고 이 실험의
> 파일·로그 이름에는 `expAF_pilot_rebaseline`을 쓴다. 사전등록 시각 이후에만 새 측정을
> 시작한다.

## 질문

1. `1단계_게이트_리포트.md` §7 실험 4~7과 관련 기준 슬롯의 현재 아티팩트 중앙값은
   무엇인가.
2. 현 `stitch_zip.py`가 현재 e2 프로젝트의 `mul256_flat.s`/`mul256_flat6.s`를 입력으로
   다시 만든 `stitched.s`가 프로젝트 사본과 바이트 동일한가.
3. `mul256_flat.s` 자체의 생성 입력·명령이 보존돼 현재 사본까지 재생 가능한가.

## 고정 아티팩트와 구현

- 보드: EK-RA8M1, 480 MHz, DWT CYCCNT.
- 펌웨어: 측정 시작 시점의 `C:\Users\cnscj\e2_studio\workspace\blinky\Debug\blinky.elf`
  및 `blinky.srec`; 두 run 사이에 빌드하지 않는다.
- 회수기: 현재 슬롯 237개를 아는 `harvest_ra8m1_expAC.py`. 슬롯 169개까지만 읽는
  기본 `harvest_ra8m1.py`는 이 ELF와 불일치하므로 사용하지 않는다.
- 대상: mul256 full/budget/flat/flat6, theta/round/round6, stitched 세 변형과 k=2,
  fiat base/yield2/yield3, coissue zip/slothy/slothy2, B-full seq/slothy.
- 생성기 검사는 원본 프로젝트를 덮어쓰지 않는다. `stitch_zip.py`의 입력을 현재 e2
  `src/gen`으로, 출력을 임시 디렉터리로 지정해 실행한 뒤 `Compare-Object`와 SHA-256으로
  비교한다. 생성 경로가 보존되지 않은 입력은 재현됐다고 간주하지 않고 e2 사본을 동결한다.

## 측정 방법

- 독립 flash/run 2회, 각각 N=100 중앙값, calib 25 cycles 차감.
- 로그:
  - `logs/2026-08-24_expAF_pilot_rebaseline_run1.txt`
  - `logs/2026-08-24_expAF_pilot_rebaseline_run2.txt`
- 비교 기준 5회는 `2026-08-21_expQ_nostore.txt`, `2026-08-21_expJsolo.txt`,
  `2026-08-21_expT_b0_noyield.txt`, `2026-08-24_expAE2_true_u_direct_finish_run1.txt`,
  `2026-08-24_expAE2_true_u_direct_finish_run2.txt`다.

## 정확성 게이트

- 전체 KAT PASS.
- `mul256`, stitched, B-mid/B-full, fiat, coissue 등 출력된 모든 mismatch가 0.
- `harness_fails=0`.
- 하나라도 실패한 run의 성능값은 기각하고 원인 수정 뒤 새 파일명으로 다시 두 번 측정한다.

## 사전 판정 기준

- 새 두 run과 위 5회가 각 대상 슬롯에서 ±2 cycles/op 안이면 새 두 run의 중앙값/범위를
  **현재 정본**으로 채택하고 08-16 값은 “재생성 전 역사 커널”로 강등한다.
- ±2를 벗어나면 정본을 갱신하지 않고 ELF·배치·정렬·클록 차이를 먼저 분해한다.
- 생성 결과가 바이트 동일하면 “현재 입력에 대한 생성기 결정성 확인”으로 기록한다.
- 다르거나 `mul256_flat.s` 생성 경로가 재현되지 않으면 프로젝트 사본을 동결 아티팩트로
  보존하고 그 차이/재현성 공백을 숨기지 않는다.

