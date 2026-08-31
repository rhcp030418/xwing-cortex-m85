# 실험 CU/CV/CW/CX 사전등록 — 리뷰_v8_상위학회 미실행 보드 항목 일괄

> 날짜: 2026-08-28
> 동기: `paper/리뷰_v8_상위학회.md` §8 "남은 보드 실험" 3·4·5번 (P1-1, P1-6, P1-7 강, P1-9).
> 보드: EK-RA8M1 1대. 네 실험 모두 이 세션에서 순차 실행한다.

## CV — 주 표 동결 ELF 5-run 재측정 (P1-1)

- 대상: `tab:final`의 F/U 절대값을 낸 동결 expCK 이미지(`pre_expAI_blinky.srec`).
  하네스·ELF·스크립트(`harvest_frozen_af.py`)를 바꾸지 않고 **독립 flash 5회**.
- 기록: run마다 `expae-fu-{ab,ba}-{fiat,u}-{keygen,encaps,decaps}` 중앙값과 `harness_fails`.
- 판정: 다섯 run의 F→U paired 효과 범위. **기존 2-run 범위(−1.98~−1.99 / −3.72 / −1.88%)를
  벗어나는 run이 있으면 원고 수치를 5-run 범위로 갱신한다.** 벗어나지 않으면 "독립 5회"로
  표기만 바꾼다.
- 예측: 다섯 run 모두 `harness_fails=0`, paired 효과 폭 < 0.02%p.

## CU — draft-10 leave-one-out, 같은 ELF (P1-7 강)

- draft-10 B의 일곱 축은 실제로 **여섯 개의 독립 토글**이다: `xyc8`(NTT/store),
  `c9`(packing/CBD/message MVE), `x06`(fixed-base), `x01`(체 곱셈), `x02`(체 제곱),
  `k31`(memcpy·memset 워드 wrapper — 한 토글). 원고의 "일곱 축"은 k31을 둘로 센 것이다.
- 각 축 $i$에 대해 $B_{-i}$ = B에서 축 $i$만 끈 구성. 같은 ELF에서 $[B, B_{-i}, B_{-i}, B]$
  ABBA, 셀당 keygen/encaps/warm/cold 100회. 슬롯 870–965.
- 축 $i$의 기여 = $B_{-i}-B$ (양수 = 그 축이 그만큼 줄였다). 여섯 기여의 합과 $A-B$의 차이는
  **상호작용**으로 보고하며 귀속하지 않는다.
- 정확성: 8-seed에서 여섯 $B_{-i}$ 전부 B와 pk/sk/ct/ss/reject 바이트 일치.
- 예측: 각 축 기여 ≥ 0. 상호작용 |합 − (A−B)| < 3% of (A−B). 부호가 음인 축이 있으면
  "그 축은 단독으로는 해롭고 다른 축과의 조합에서만 이득"으로 기록한다.

## CW — decaps 8-seed 순환 (P1-6)

- 기존 `tab:cumulative`의 warm/cold 100회는 같은 (sk, ct) 반복이었다. 여기서는 8개의
  (sk, ct) 쌍을 만들어 반복마다 순환한다. warm은 8개 확장 캐시를 미리 만든다.
- 8쌍의 캐시·ct는 DTCM 예산 때문에 **RAM(.bss)** 에 둔다. 따라서 절대값은
  `tab:cumulative`(DTCM)와 섞지 않고, 같은 배치의 A/B 상대효과만 본다.
- 셀: $[A, B, B, A]$ × {warm, cold}. 슬롯 966–973.
- 정확성: 매 반복 출력이 A로 미리 계산한 8개 기대값과 일치.
- 예측: 순환 입력의 warm/cold 감소율이 동일 입력 반복의 11.22 / 18.30%와 ±1%p 안.

## CX — 고정 대 무작위 ciphertext 타이밍 검정 (dudect류, P1-9)

- 대상: draft-10 **B** 의 decaps warm과 cold. 비밀키 고정.
- 두 클래스: 클래스 0 = 유효 ct 하나 고정, 클래스 1 = 매 표본 무작위 바이트 ct(대부분 무효
  → 암묵적 거부 경로). 표본마다 클래스를 PRNG로 고르고 순서를 섞는다. 클래스당 3,000표본.
- 통계: Welch t. dudect 관행대로 (i) 전체, (ii) 상위 백분위 절단(p50/p75/p90 이하만)
  에서 각각 계산. **|t| > 4.5 이면 누설 판정.**
- 이 검정이 잡는 것: ct 유효/무효에 따른 시간 차 = FO 재암호화·cmov·X25519 무작위 점·
  결합기의 입력 의존성. 잡지 못하는 것: 비밀키 의존 누설(키를 고정했으므로), 캐시/전력.
- 예측: warm/cold 모두 |t| < 4.5. 넘으면 원고 상수시간 절에 그대로 쓴다.

## 공통 게이트

기존 전체 하네스 KAT·mismatch·`harness_fails=0`. 하나라도 실패하면 그 run 폐기.

## 산출물

- 로그 `logs/2026-08-28_exp{CU,CV,CW,CX}_*.txt`, 결과 `2026-08-28_expCU_CV_CW_CX_results.md`,
  동결 `artifacts/2026-08-28_expCUWX/` (CV는 동결 이미지 재사용, 로그만).
