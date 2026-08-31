# 사전등록 — 실험 DC: Lenngren y1 기반 종단간 U′

> 작성 2026-08-28, 구현·빌드·측정 전. expCR이 남긴 미측정 항목을 직접 닫기 위한 실험이다.

## 질문

r11을 사용하지 않는 expCR Lenngren `fe25519_mul` y1을 실제 X25519 ladder에 넣고, y1이 비운 r11을 한-base MVE Keccak 조각에 사용한 종단간 U′가 같은 y1 순차 기준 S′보다 빠른가?

## 후보

- S′: Lenngren ladder의 모든 `fe25519_mul`을 expCR y1 본문으로 교체하되 Keccak 조각은 넣지 않는다.
- U′: 같은 y1 본문에 one-base b1 Keccak-f1600x4 한 라운드를 8개 연속 field-mul 호출에 균등 지퍼로 나눈다. 각 조각은 r11/q7 base를 재구성한다.
- ML-KEM/x4 배칭과 X-Wing queue는 검증된 expAC staged harness를 사용한다. 비교의 유일한 X25519 차이는 S′ 대 U′다.

## 사전 게이트

1. S′와 U′ 모두 RFC 7748 public/shared-secret KAT 통과.
2. Keccak/SHAKE x4 대 scalar mismatch 0.
3. 결정적 8-seed X-Wing pk/sk/ct/valid/reject mismatch 0, ML-KEM roundtrip/reject 통과.
4. stack canary fail 0, `harness_fails=0`.
5. 생성된 U′의 scalar fragment에서 r11 사용 0건; r11은 b1 주소 base로만 사용.

하나라도 실패하면 cycle을 폐기한다.

## 측정·판정

EK-RA8M1 한 대, DWT CYCCNT, REP_N=100, ABBA, 독립 flash 2회. keygen/encaps/decaps 각각에서 두 순서 모두 `U′−S′ < 0`일 때만 이득으로 판정한다. 그 밖에는 음성 결과다. 보드가 한 대뿐이고 제어 가능한 전원 차단기가 없으므로 두 번째 보드와 전원 재인가는 미측정으로 남긴다.

## 중단 규칙

검증된 expAC staged 빌드를 먼저 재생성한다. 현 toolchain/프로젝트에서 그 staged 기준선 자체가 빌드되지 않거나 KAT를 재현하지 못하면 U′ 구현 전에 중단하고 그 사실을 결과로 남긴다. y1과 b1의 ABI/stack 조합이 어셈블·링크되지 않거나 정확성 게이트를 실패해도 성능 측정 없이 중단한다.
