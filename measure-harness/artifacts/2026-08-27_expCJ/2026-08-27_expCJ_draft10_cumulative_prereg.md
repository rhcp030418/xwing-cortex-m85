# 실험 CJ 사전등록 — draft-10 최종 누적 동일-ELF A/B

> 등록: 2026-08-27, 보드 측정 전에 고정. 대상은 EK-RA8M1(Cortex-M85, 480 MHz) 한 개체다.

## 1. 질문

draft-10 준거 X-Wing에서 채택한 최적화를 모두 끈 기준형 A와 모두 켠 최종형 B를
**같은 ELF** 안에서 비교했을 때 keygen, encaps, decaps-warm, decaps-cold의 누적
사이클 차이는 얼마인가?

이 실험은 기존의 서로 다른 ELF 세로 비교를 대체한다. 결과가 양수일 것을 전제하지 않는다.

## 2. 고정한 A/B

두 셀은 draft-10의 combiner 순서, packed 32-byte secret key, 64-byte encapsulation seed,
FIPS 203 encapsulation-key check를 똑같이 사용한다. 차이는 다음 일곱 채택 요소뿐이다.

| 요소 | A: 기준형 | B: 최종형 |
|---|---|---|
| X/Y/C8 | 기존 ML-KEM NTT/invNTT/store | M85 X/Y/C8 |
| C9 | scalar packing/CBD/message | MVE C9 v1 |
| X06 | basepoint 9도 일반 Montgomery ladder | fixed-base comb |
| X01 | 원본 `fe25519_mul` | 재스케줄 `fe25519_mul_sched` |
| X02 | 원본 `fe25519_sqr` | 재스케줄 `fe25519_sqr_bb` |
| K31 memcpy | newlib-nano | 정렬 인식 워드 루프 |
| K31 memset | newlib-nano | 정렬 인식 워드 루프 |

런타임 디스패처와 모드 판정 비용은 A/B가 똑같이 부담한다. 따라서 이 실험의 절대 cycle은
dispatcher-free expBU 대표값을 대체하지 않고, **누적 상대효과의 정본**으로만 사용한다.

## 3. 측정 설계

- 한 ELF, 동일 code/data placement, 동일 입력 계보.
- 셀 순서 **A-B-B-A(ABBA)**.
- 셀마다 각 연산 REP_N=100, DWT CYCCNT 중앙값.
- 독립 flash/run **2회**. 매 회 SREC code-flash readback SHA-256을 확인한다.
- keygen/encaps/decaps-warm/decaps-cold 네 연산을 분리한다. cold와 warm을 합치지 않는다.
- 각 회의 앞/뒤 A와 B를 각각 짝지어 `100 × (A-B)/A`를 계산한다.
- 대표 누적 개선률은 두 회 × 두 ABBA 쌍, 총 네 값 중 **최솟값**(보수적)이다.
- 표에는 네 쌍 전부와 A/B 중앙값 범위를 함께 싣는다.

## 4. 유효성 gate

다음 중 하나라도 실패하면 성능 수치를 채택하지 않고 원인을 조사한다.

1. RFC 7748, FIPS 203, SHA3/SHAKE, 기존 전체 하네스: 전부 PASS.
2. A/B 각각 8 seed에서 pk/sk/ct/enc-ss/warm-ss/cold-ss 및 훼손 ciphertext의 암묵적
   거부 출력: mismatch 0, smoke failure 0.
3. 각 셀의 timed 마지막 출력도 첫 A 셀과 바이트 동일.
4. stack canary failure 0, stack high-water 보고.
5. 한 run 안에서 앞/뒤 같은 모드의 중앙값 차이가 각 연산 **0.3% 이하**.
6. 두 독립 run에서 같은 ABBA 위치의 누적 개선률 차이가 **0.3%p 이하**.

## 5. 판정과 보고

- 네 연산 각각의 부호와 크기를 그대로 보고한다. 사후 임계값으로 성공/실패를 재정의하지 않는다.
- B가 느린 연산이 하나라도 있으면 그 회귀를 숨기지 않는다.
- `.text/.data/.bss`, ELF/SREC/source/harvester SHA-256, readback SHA-256을 동결한다.
- expBU의 dispatcher-free 절대값은 계속 절대 cycle 정본이고, expCJ는 동일-ELF 누적률 정본이다.

