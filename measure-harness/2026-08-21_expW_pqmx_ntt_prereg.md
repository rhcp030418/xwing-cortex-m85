# 실험 W 사전 등록 — pqmx/SLOTHY MVE Kyber NTT를 EK-RA8M1에서 직접 측정

## 질문

> 리서치 보고서가 인용한 M85 Kyber NTT가 현재 EK-RA8M1에서도 실제로
> 910~947cycle 부근을 내며, inverse와 ordering 비용까지 포함해 C7의
> 5k/20k/15kcycle primitive gate를 통과할 수 있는가?

## 고정 소스

- pqmx: `https://github.com/slothy-optimizer/pqmx`,
  commit `89465b9756cd9b321966c99e21301b7a0a2e4de0`
- pinned SLOTHY submodule: commit
  `55983e6760e98aece5359055085a7def96c688b7`
- pqmx open draft PR #87 (`mve-ntts`) inverse source: commit
  `1eeaf854e60d4ac30a2866d2a05f5935199ad6a6`, pinned SLOTHY
  `ed3b034b3a3fbf06530784dd01a7622d4f6cf0fb`
- 양쪽 모두 upstream MIT license를 보존한다.
- 생성 스크립트: `../slothy-2stream/gen_exp_w.py`

pqmx main에는 optimized M85 **forward** NTT만 있다. optimized M85 inverse는
아직 병합되지 않은 공개 draft PR #87에만 있으므로 WIP로 명시해 측정한다.
main의 M55 inverse schedule도 M85에서 그대로 실행하는 탐색적 대조군으로 둔다.

## 후보

forward 4종:

1. `1+2+2+2 no_trans`, M85
2. `1+2+2+2 no_trans_vld4`, M85
3. `2+3+2 opt_size`, M85
4. `2+3+2 opt_speed`, M85

inverse 2종:

- main의 `1+2+2+2` M55 schedule을 M85에서 실행(비교군)
- draft PR #87의 `1+2+2+2` M85 schedule(주 후보)

upstream `tests/ntt-kyber/main.c`가 실제 test 대상으로 삼은 출력은 4×4
`int32`-pair transpose(`buf_bitrev_4`)가 적용된 ordering이다. 이 비용을 숨기지
않기 위해 같은 `rev4`를 별도 슬롯으로 측정한다.

## 단일 변경과 배치

- 기존 `poly_ntt()`/`poly_invntt()` 및 ML-KEM caller는 교체하지 않는다.
- cpp twiddle include만 기계적으로 펼친다.
- 후보 code는 현재 baseline과 같은 `.itcm_code_from_flash`, 입력은 16-byte aligned
  DTCM에 둔다. upstream twiddle `.data` 배치는 유지한다.
- 기존 V 슬롯도 같은 firmware에서 다시 재어 직접 대조한다.

## 정확성

- deterministic 256-coefficient 입력을 pqmx의 C reference 정의로 host에서 계산한다.
- forward 4종 모두 결과를 mod 3329로 줄인 뒤 upstream의 `rev4` ordering expected와
  256개 전부 비교한다.
- main의 M55 inverse generator에는 1/128 정규화가 없으므로 forward→inverse를
  `128 × input mod 3329`와 비교하고, 전/후 `rev4` 4개 조합을 진단한다. 이 비교군의
  실패는 WIP M85 후보의 정확성 실패로 세지 않는다.
- WIP M85 inverse는 draft branch의 `invntt_ref`와 같은 `invntt_tomont` expected를
  host에서 생성한다. standard bit-reversed 입력을 `rev4`한 뒤 호출하여 256계수를
  전부 비교한다.
- M85 forward의 noncanonical 출력을 WIP M85 inverse에 변환 없이 바로 연결한
  roundtrip도 `2^16 × input mod 3329`와 전부 비교한다.
- 기존 X25519/SHA3 KAT, ML-KEM roundtrip+reject, 모든 기존 mismatch도 유지한다.

## 측정

- 각 primitive와 `rev4`: 1,000회/샘플 × N=100, 빈 측정 중앙값 차감
- 두 번의 독립 flash/run
- 현재 V 실측 대조값: forward 5,354.012cyc, inverse 6,586.012cyc

## 사전 판정

**강한 성공**:

- forward 4종 mismatch 0, WIP M85 inverse mismatch 0, M85 roundtrip mismatch 0
- best forward ≤1,200cyc, WIP M85 inverse ≤2,000cyc
- 정적 호출 수를 적용한 primitive-only 절감이 keygen/encaps/decaps에서 각각
  5k/20k/15kcycle gate를 모두 통과
- 두 run 재현 및 `harness_fails=0`

**부분 성공**:

- 정확성은 통과하고 current보다 빨라졌지만 위 cycle/gate 중 일부 미달

**실패**:

- forward expected 또는 WIP M85 inverse/roundtrip이 불일치하거나, current 대비
  유의미한 속도 개선이 없음

primitive-only gate 통과는 채택 완료가 아니다. 현재 Plantard basemul/caller의
ordering·domain과 연결하는 conversion/glue 및 full ML-KEM KAT/사이클은 다음 통합
실험에서 별도로 측정해야 한다.

## 1차 실행 후 측정 절차 수정 기록

첫 실행(`logs/2026-08-21_expW_pqmx_ntt_run1.txt`)은 결과를 내기 전에 하드폴트했다.
리셋 없이 SCB와 예외 프레임을 읽은 결과 `CFSR=0x00010000`(UNDEFINSTR), stacked
PC=`0x000096c0`였고, 이는 main의 M55 inverse에 있는
`ldrd r11, r6, [r11], #24`였다. assembler가 빌드 때 경고한 것처럼 base register와
첫 destination이 겹치는 writeback 형태다. Cortex-M85에서는 undefined instruction
fault가 발생하므로 이 비교군은 실행 불가로 기각한다.

이 수정은 실패를 본 뒤 한 것이므로 사전등록 결과와 섞지 않는다. M55 비교군의
correctness/slot 133만 비활성화하고, 핵심 판정 대상인 forward 4종, WIP M85 inverse,
rev4, 기존 V baseline, 성공 기준과 gate는 바꾸지 않는다. 실패 실행에서 forward
4종 누적 mismatch는 이미 0이었지만, 유효한 두 독립 run에서 다시 검증한다.

## 실보드 결과

유효 로그는 `logs/2026-08-21_expW_pqmx_ntt_run{1,2}.txt`이다. 두 로그 모두
ML-KEM roundtrip+reject, 기존 모든 mismatch, forward 4종, WIP inverse와
forward→inverse roundtrip을 통과했고 `harness_fails=0`이었다. 두 run의 아래 중앙값은
cycle 단위까지 같았다.

| 항목 | cycles/호출 | current 대비 |
|---|---:|---:|
| current forward | 5,354.012 | 기준 |
| current inverse | 6,586.013 | 기준 |
| forward 1+2+2+2 | 2,856.034 | −46.66% |
| forward 1+2+2+2 vld4 | 2,866.030 | −46.47% |
| **forward 2+3+2 size** | **2,814.027** | **−47.44%** |
| forward 2+3+2 speed | 2,814.028 | −47.44% |
| explicit scalar `rev4` | 608.032 | 별도 glue |
| **WIP M85 inverse** | **3,294.030** | **−49.98%** |

raw primitive-only 절감은 keygen **25,115.859**, encaps **20,787.887**, decaps
**31,699.825** cycles로 사전 gate 5k/20k/15k를 모두 통과했다. 따라서 사전등록
기준으로는 **강한 성공**이다.

## 해석 경계와 다음 단계

강한 성공은 standalone primitive에 한정된다. 후보는 aligned DTCM 한 버퍼를 연속
1,000회 변환한 direct-call 값이며, 현재 ML-KEM caller는 아직 기존 NTT를 사용한다.
또한 forward 출력은 4×4 transpose ordering이고 WIP inverse 출력은 Montgomery
배율을 남긴다. 현재 Plantard pointwise를 유지하는 단순 wrapper는 forward와 inverse
각각 `rev4` 1회를 요구한다.

기존 U+MVE Keccak 미통합 투영 13.78/14.20/12.92%에 raw W 절감을 더하면
16.942/15.968/16.569%(평균 **16.49%**)다. 모든 NTT/inverse 호출마다 현재 scalar
`rev4`를 하나씩 지불하는 보수적 경우는 16.253/15.606/15.799%(평균 **15.89%**)다.
따라서 W는 유망하지만 **20% 달성 결과는 아니다**. 다음 실험 X에서 fastest forward와
`rev4`를 실제 `poly_ntt`에 연결하고 baseline과 byte-for-byte 결과 및 full ML-KEM
사이클을 같은 firmware에서 측정한다. 그 뒤에만 WIP inverse의 Plantard scale 보정을
시도한다.

재현 해시: valid-run ELF
`6DC3BD987B0DD9D05F8311D49013ACC559A7F822A436C8DC2DA9CBED2C38E3EF`, harness
`BB2AA45E62DF2925020B29CAEF3A2DF7E4B0FE166D11F65C4F68698F029018AC`, vectors
`0BD007C32B5EC87D19F2198F8F6CC8D712F36AE7B9B3C18D9892F262F8E30DE3`.

## 후속 정정

이 문서의 13.78/14.20/12.92% U+Keccak 입력은 이후 산술 감사에서
13.97/14.07/12.90%로 정정됐다. 또한 W의 raw projection은 실험 X/Y의 실제 ML-KEM
통합 차분으로 대체됐으므로 현재 장부에 다시 더하지 않는다. 최종 X/Y 결과는
`2026-08-21_expY_pqmx_inverse_integration_prereg.md`를 따른다.
