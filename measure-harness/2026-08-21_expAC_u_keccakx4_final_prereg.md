# 실험 AC 사전등록 — U + Keccak-f1600x4/SHAKE x4 최종 X-Wing 통합

## 비교

- A: X/Y/C8 ML-KEM + scalar Keccak + 기존 Lenngren X25519
- B: 같은 X/Y/C8 + 24-round MVE Keccak-f1600x4/SHAKE x4 + 실제 Lenngren
  X25519 ladder의 임의 피연산자 field-mul에 U 8:1 분할 스티칭
- ML-KEM-768 matrix XOF의 독립 3개 스트림을 x4 lane(1 lane dummy)으로 묶는다.
- X-Wing keygen/encaps/decaps의 X25519 작업은 ML-KEM의 첫 x4 permutation에 각각
  1/2/1개를 큐잉한다. 호출 횟수를 사후 덧셈한 투영은 사용하지 않는다.

## 정확성 gate

- Keccak-f1600x4를 SHAKE128/256 네 lane에서 scalar API와 byte 비교
- U 경로로 RFC 7748 public/shared-secret KAT 통과
- 8 seed X-Wing A/B pk/sk/ct/valid ss/reject ss 전 바이트 일치
- ML-KEM roundtrip/reject, 기존 KAT, timing workload, stack canary 모두 0

gate 하나라도 실패하면 성능 수치는 기각한다.

## 측정

- EK-RA8M1 Cortex-M85, DWT, N=100 중앙값, 같은 deterministic RNG stream
- 순서 A→B→B→A, 독립 flash/run 2회
- 연산별 보수 절감은 `min(A1-B1, A2-B2)`로 판정
- 두 run 모두 정확성 gate 통과 후에만 최종 결과로 채택

## 판정

- 강한 성공: 세 연산 모두 보수 절감 > 0
- 부분 성공: 정확성 통과, 일부 연산만 > 0
- 실패: 정확성 실패 또는 세 연산 모두 ≤ 0
