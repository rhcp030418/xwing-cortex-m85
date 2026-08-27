# 실험 AD 사전등록 — AC 성능 악화 단일변수 분해

## 질문

실험 AC의 X/Y/C8 대비 악화량을 (1) X25519 dispatcher 세금,
(2) ML-KEM matrix-XOF 3+dummy x4 배칭, (3) U 삽입의 순손익으로 분리한다.
기존 AC 종단간 ABBA만으로는 세 항을 개별 원인으로 귀속하지 않는다.

## 모드

- S (`mode=0`): X/Y/C8 + scalar matrix XOF + direct-call scalar X25519.
- X (`mode=2`): X/Y/C8 + 3+dummy x4 matrix XOF + direct-call scalar X25519.
- U (`mode=1`): 기존 AC와 동일한 X/Y/C8 + x4 matrix XOF + queued U X25519.

동일 ELF에서 S→X→X→S와 X→U→U→X를 각각 N=100 중앙값으로 측정한다.
연산별 보수 절감은 두 방향 차분의 최솟값으로 정의한다.

## 정확성 gate

- 8 seed X-Wing pk/sk/ct/valid ss/reject ss가 S, X, U에서 전 바이트 일치.
- primitive x4/AC-stitch KAT, ML-KEM roundtrip/reject, timing output, stack canary 실패 0.
- 하나라도 실패하면 성능값을 기각한다.

## 귀속

- x4 배칭 순손익: S−X 직접 ABBA.
- U 순손익: X−U 직접 ABBA.
- dispatcher 세금: 기존 invalid-baseline run과 direct-call-baseline run의 차분.
- `dispatcher + x4 + U` 합이 기존 S−U 전체 차분과 맞는지 교차검산한다.

이번 실험은 원인 진단용이며, 양의 성능을 사전 가정하지 않는다.
