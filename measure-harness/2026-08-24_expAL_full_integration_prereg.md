# [철회] 실험 AL 사전등록 — 원 baseline 대비 X/Y/C8+C9 완전 통합 종단간

> **철회 (2026-08-24, 측정 전):** 같은 시각 병렬로 작성된
> `2026-08-24_expAL_cumulative_factorial_prereg.md`(2×2 factorial, 본 문서의
> 질문을 포함하는 상위집합)로 대체한다. 본 문서 기준의 측정은 수행되지 않았다.
> 두 사전등록이 동시에 존재했던 사실 자체를 기록으로 남긴다.
>
> **재개 시 주의:** 현재 `harvest_ra8m1_expAL.py`는 본(철회된) 설계의 슬롯 라벨
> (expal-mlkem/xwing-a1·b1·b2·a2)을 갖고 있어 factorial 설계의 슬롯 의미
> (309~332 = X-Wing 2×2 셀 00a→10a→11a→01a→01b→11b→10b→00b)와 **불일치**한다.
> 측정 전 라벨을 셀 기준으로 교정하거나 회수기를 재생성할 것. harness.c는
> 2026-08-24 21:4x에 중복 정의를 제거해 factorial 단일 상태로 정리했고(`#include
> "expAL_factorial.inc"` + `expal_run_all()`), 그 이후 빌드·플래시는 하지 않았다.

> 작성: 2026-08-24, 측정 시작 전. 목적: 지금까지 "혼합 장부"로만 존재하던
> 합산치(X/Y/C8의 2.85/1.54/3.25% + expAJ C9의 1.46/2.67/4.66%)를 **같은 ELF의
> 단일 ABBA 실측**으로 대체한다. 성공 시 이 값이 논문 대표 종단간 후보가 된다
> (paper 반영은 별도 세션).

## 질문

스칼라 NTT·스칼라 C9의 원 baseline(`ntt_mode=0, invntt_mode=0, mlkem_c9_mode=0`)
대비, 채택 경로 전체를 켠 candidate(`ntt_mode=2, invntt_mode=1, mlkem_c9_mode=1`,
C9는 AK에서 확정한 v1)가 full ML-KEM-768과 실제 X-Wing 종단간에서 얼마를
절감하는가.

## 사전 예측 (혼합 장부 — 이번 실측이 검증할 값)

기존 AB baseline(795.4k/1,175.6k/869.2k)과 expAJ candidate 중앙값의 산술 조합은
약 **4.2/4.1/7.7%**다. 이 예측이 빗나가도 실측을 채택하고 차이를 기록한다.

## 단일 변수와 구현

- 코드 변경은 하네스뿐이다(신규 bench 2개 + X-Wing 8-seed 동등성 1개 + 슬롯
  309~332, REP_SLOTS 333). ML-KEM/X-Wing/NTT/C9 구현은 AK 마감 상태(flash, v1)
  그대로다.
- ABBA: A=원 baseline, B=완전 통합 candidate, A→B→B→A, 각 N=100 중앙값,
  calib 25. full ML-KEM(슬롯 309~320)과 실제 X-Wing wrapper(321~332).
- ABBA의 ref는 A(원 baseline) 출력이므로 candidate의 pk/sk/ct/ss 전 바이트가
  baseline과 대조된다(timing-mm 게이트).

## 정확성 게이트 (run마다, 실패 시 성능 기각)

- 기존 전체: KAT, roundtrip/reject, 전 슬롯 mismatch 0(expAJ/expAK 포함),
  `harness_fails=0`.
- 신규 `expAL xw-bytes-mm`: 8-seed에서 baseline 대 완전 통합 candidate의 X-Wing
  pk/sk/ct/valid ss/reject ss 전 바이트 일치 + smoke/reject.
- `expAL timing-mm=0`, stack canary 0.

## 측정·로그

- EK-RA8M1, 독립 flash/run 2회:
  `logs/2026-08-24_expAL_run{1,2}.txt`, 회수기 `harvest_ra8m1_expAL.py`(SLOT_N=333).
- conservative 절감 = min(A1−B1, A2−B2). 절감률 분모는 각 run의 자체 baseline A1.

## 사전 판정

- **성공**: 두 run 모두 세 연산 conservative 절감이 전부 양수이고 두 run 간
  절감 편차가 각 연산 0.5% 이내로 재현.
- 성공 시 X-Wing 실측치를 **완전 통합 종단간 정본**으로 결과 문서에 기록하고,
  기존 혼합 장부 합산(≈4.2/4.1/7.7%)은 예측치로 강등한다. 논문 대표값 교체
  자체는 별도 결정(사용자·paper 세션)으로 남긴다.
- 어느 연산이라도 음수면 해당 연산 실패로 기록하고 원인 분해 전까지 대표 후보로
  쓰지 않는다.
