# 실험 AJ 사전등록 — C9(packing·CBD) MVE화의 실제 종단간 검증

> 작성: 2026-08-24, 측정 시작 전. 근거 계보: 실험 Z2가 귀속한 C9 bucket
> (CBD 본문 + packing/compression/decompression/message conversion)은
> keygen **33,773~33,775** / encaps **47,406** / decaps **59,145~59,146 cycles**다
> (`2026-08-21_expZ_results.md`). Z 사전등록의 선택 규칙상 C8 다음 후순위였고,
> C8(AA/AB) 채택이 끝났으므로 이번에 C9를 검증한다.

## 질문

현재 채택 경로 X/Y/C8 위에서, C9 bucket의 스칼라 C 함수들을 M85 MVE(Helium)
구현으로 교체하면 full ML-KEM-768과 실제 X-Wing 종단간에서 얼마나 회수되는가.
귀속량은 상한이지 예상 절감이 아니다 — 실제 절감은 이번 실측으로만 결론낸다.

## 단일 변수와 구현

- 토글: `volatile uint32_t mlkem_c9_mode` (0=현행 스칼라 C, 1=MVE).
  기존 `mlkem_ntt_mode` 방식과 동일하게 각 함수 머리에서 분기한다.
- 교체 대상(전부 Z2 C9 bucket, kem 호출 경로상 함수만):
  `cbd`(eta2, add 포함), `poly_tobytes`, `poly_frombytes`,
  `poly_packcompress`, `poly_unpackdecompress`, `poly_compress`,
  `poly_decompress`, `cmp_poly_packcompress`, `cmp_poly_compress`,
  `poly_frommsg`, `poly_tomsg`.
  `polyvec_compress/decompress`는 이 파이프라인의 kem 경로에서 호출되지 않으므로
  제외한다(정적 확인: `indcpa.c`는 packcompress/unpackdecompress 사용).
- 구현: GCC 13.2.1 `arm_mve.h` 내장함수 C 파일 `src/mlkem/poly_mve.c` 1개.
  배치는 기존 ML-KEM C 글루와 동일한 code flash + I-cache(비교 공정성).
  ITCM 재배치는 이번 실험 범위 밖(후속 단일변수로만).
- NTT/rev4는 건드리지 않는다(A/B 모두 `ntt_mode=2`, `invntt_mode=1` 고정).
- `poly_mve.c`의 packcompress/unpackdecompress·compress 계열은 양자화만 벡터화하고
  바이트 끼워넣기 일부를 스칼라로 남긴 v1이다. v1이 게이트 미달이면 그 사실을
  결과로 기록하고, 사후 재작성 값을 이번 판정에 소급하지 않는다.

## 상수시간 주장

MVE 구현은 고정 반복 횟수·고정 마스크·predication(vpsel)만 사용하며 비밀 의존
분기·비밀 의존 주소가 없다. `poly_frommsg`는 기존 `cmov_int16`과 등가인
vcmp+vpsel로 구현한다. 구조 논증은 `4단계_상수시간_논증.md`의 틀을 따른다.

## 정확성 게이트 (하나라도 실패하면 해당 run 성능값 기각)

1. 기존 전체 게이트: RFC 7748/SHA3 KAT, ML-KEM roundtrip/reject, 기존 전 슬롯
   mismatch 0, `harness_fails=0`.
2. 신규 primitive 오라클(`expAJ kat`): 8개 결정적 시드에서 위 11개 함수 각각
   스칼라 대 MVE 출력 전 바이트 비교(cbd는 add=0/1, packcompress 계열은
   idx 0..2 포함), mismatch 0.
3. 신규 종단간 동등성(`expAJ bytes-mm`): 8-seed에서
   A(ntt=2,inv=1,c9=0) 대 B(ntt=2,inv=1,c9=1)의 full ML-KEM
   pk/sk/ct/valid ss/reject ss 전 바이트 일치 + smoke/reject 통과.
   X-Wing wrapper에서도 같은 8-seed 비교를 수행한다.
4. ABBA 중 timing-mismatch 0, stack canary 0, stack high-water 기록.

## 측정 방법

- EK-RA8M1, DWT CYCCNT, N=100 중앙값, calib 25 차감.
- full ML-KEM ABBA: A=X/Y/C8(c9=0), B=X/Y/C8+MVE C9(c9=1),
  A→B→B→A, keygen/encaps/decaps 각 N=100. 슬롯 261~272.
- 실제 X-Wing ABBA: 같은 토글로 `xwing_keypair/enc/dec` A→B→B→A. 슬롯 273~284.
- `REP_SLOTS` 261→285, 회수기는 `harvest_ra8m1_expAJ.py`(SLOT_N=285).
- 독립 flash/run 2회:
  `logs/2026-08-24_expAJ_c9_mve_run1.txt`, `logs/2026-08-24_expAJ_c9_mve_run2.txt`
- conservative 절감 = 각 run에서 `min(A1-B1, A2-B2)`.

## 사전 판정 기준

- **강한 성공**: 두 run 모두 세 연산 conservative 절감이 전부 양수이고
  keygen ≥ **8,000** / encaps ≥ **12,000** / decaps ≥ **15,000 cycles**
  (Z2 귀속량의 약 25% 회수선).
- **부분 성공**: 정확성 전부 통과 + 세 연산 전부 양수이나 위 cycle 게이트 일부 미달.
- **실패**: 정확성/스택 게이트 실패, 또는 어느 한 연산이라도 두 run에서 재현되는
  음수(회귀).
- X-Wing 종단간 절감률은 각 run의 X-Wing 자체 baseline 분모로 병기한다.
  성공 시에도 이 실험 단독으로 "20% 달성"이나 대표값 교체를 선언하지 않고,
  결과 문서에 X/Y/C8 대비 추가분으로만 기록한다.
- 판정과 무관하게 실패·음수 결과도 결과 문서에 그대로 보존한다.

## 재현 아티팩트

- 측정 ELF/SREC, `poly_mve.c`, 수정된 `harness.c`의 SHA-256을 결과 문서에 기록.
- 편집 전 백업: `*.bak-20260824-AJ`.
- 결과는 `2026-08-24_expAJ_results.md`에 기록하며, 미측정 항목(ITCM 배치 효과,
  다른 코어 등)은 미측정으로 남긴다.
