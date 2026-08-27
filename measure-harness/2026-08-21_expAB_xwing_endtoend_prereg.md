# 실험 AB 사전등록 — 실제 X-Wing wrapper 종단간 X/Y/C8 차분

## 질문

ML-KEM-768, X25519 두 scalar multiplication, X-Wing SHA3-256 combiner를 실제 한
함수로 조립했을 때, X/Y/C8 NTT 교체가 X-Wing 전체 keygen/encaps/decaps에서 얼마를
절감하는가?

## 비교군

- A: 기존 ML-KEM forward/inverse + 기존 X25519 + scalar Keccak
- B: C8 current-order forward + Y inverse + 같은 X25519/Keccak
- X-Wing 포맷: pk 1216 B, sk 2464 B, ct 1120 B, ss 32 B
- combiner: SHA3-256(`\.//^\` || ss_M || ss_X || ct_X || pk_X), 134 B

실험 U와 4-way MVE Keccak은 현재 기능 등가 X-Wing 호출 경로가 아니라 standalone
매크로 커널이므로 이 비교에는 넣지 않는다. 해당 커널을 호출 횟수만큼 덧붙이는 방식은
종단간 통합으로 간주하지 않는다.

## gate와 측정

- 8개 seed에서 A/B pk/sk/ct/valid ss/reject ss 전 바이트 일치
- X-Wing encaps/decaps roundtrip 및 corrupted-ciphertext reject 결과 분리
- 기존 KAT, ML-KEM reject, stack canary, alignment, 모든 mismatch 0
- EK-RA8M1, DWT, N=100 중앙값, A→B→B→A, 독립 flash/run 2회
- 강한 성공: 두 run의 세 연산 모두 양의 conservative 절감 및 모든 정확성 gate 통과

이 결과는 X/Y/C8의 실제 종단간 기여만 확정한다. U+MVE Keccak의 완전 통합 수치나
20% 달성 수치로 해석하지 않는다.
