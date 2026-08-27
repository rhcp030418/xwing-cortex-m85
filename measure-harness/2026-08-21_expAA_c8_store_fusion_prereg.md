# 실험 AA 사전등록 — C8 forward ordering store fusion

## 질문

pqmx M85 forward NTT가 마지막 layer의 MVE structure store로 current-order를 바로
출력하게 하면, 현재 scalar `rev4`를 없애면서 ML-KEM 결과를 보존하고 full-operation
cycle을 줄일 수 있는가?

## 고정 비교군

- A (baseline): 실험 Z의 X+Y 통합 상태. forward는
  `ntt_kyber_12_345_67_opt_size_m85` 뒤에 scalar `rev4`를 수행한다.
- B (candidate): 같은 산술과 twiddle을 쓰되 마지막 store가 current-order를 직접
  만들며, forward 뒤 scalar `rev4`는 수행하지 않는다.
- inverse와 matacc/basemul/serialization 구현은 A/B에서 동일하게 고정한다.
- 함수, RNG seed, DTCM stack frame, clock, compiler flags도 동일하게 고정한다.

## 정확성 및 안전성 gate

- 8개 deterministic seed에서 A/B의 pk, sk, ct, encaps ss, decaps ss byte 일치
- ML-KEM roundtrip/reject, 기존 KAT, X25519/SHA3 smoke 모두 통과
- stack canary, fault, alignment, harness mismatch 모두 0
- 최대 stack high-water가 기존 6536 B를 넘지 않음

## 성능 측정

- EK-RA8M1 Cortex-M85 실보드, DWT cycle counter
- keygen/encaps/decaps 각각 N=100 중앙값
- A→B→B→A(ABBA), 각 블록 직전 같은 RNG seed 재설정
- 독립 flash/run 2회
- 각 run에서 `min(A1-B1, A2-B2)`를 conservative 절감으로 기록

## 사전 판정

- 강한 성공: 모든 정확성/안전성 gate 통과, 두 run의 세 연산 모두 양의 절감,
  conservative 절감이 keygen/encaps/decaps 각각 2500/1250/2500 cycles 이상
- 부분 성공: 정확성은 통과하고 모든 연산이 빨라지지만 위 cycle gate 일부 미달
- 실패: 결과/안전성 gate 실패 또는 어느 한 연산이라도 반복 가능한 회귀

이 실험은 C8 하나의 실측이다. 기존 U/MVE Keccak 투영치나 다른 실험의 절감을
더해 20% 전체 달성으로 간주하지 않는다.
