# 실험 Z 사전 등록 — X+Y 동시 실측과 ML-KEM 비-Keccak 귀속

## 질문

1. 실험 X의 forward와 실험 Y의 inverse를 동시에 켰을 때, 각각의 full-operation
   차분을 더한 절감이 실제 ML-KEM 한 번의 A/B에서도 보존되는가?
2. 20%까지 남은 cycle 중 C8 basemul/matacc와 C9 packing/CBD가 실제로 차지하는
   절대량은 얼마이며, 다음 구현 대상으로 충분히 큰가?

## Z1 — X+Y 동시 full-operation ABBA

- A: current forward + current inverse (`ntt_mode=0`, `invntt_mode=0`)
- B: pqmx forward+rev4 + pqmx Plantard inverse+rev4
  (`ntt_mode=1`, `invntt_mode=1`)
- 동일 함수, 동일 DTCM stack frame, 동일 RNG seed를 사용한다.
- 순서는 A→B→B→A, 각 keygen/encaps/decaps N=100 중앙값이다.
- 최소 8개 seed에서 pk/sk/ct/valid ss/reject ss를 전 바이트 비교한다.
- stack canary/high-water, 기존 KAT와 X/Y oracle, pointer alignment를 유지한다.
- 두 번 독립 flash/run한다.

비교 기준은 같은 최종 Y 펌웨어의 isolated X+Y conservative 합계다.

| 연산 | isolated 합계 |
|---|---:|
| keygen | 18,772 cycles |
| encaps | 16,177 cycles |
| decaps | 24,204 cycles |

**강한 성공:** correctness gate 전부 통과하고 두 run 모두 각 연산에서 isolated 합계의
90% 이상을 보존한다. **부분 성공:** 전부 빨라지지만 하나 이상이 70~90%다.
**실패:** correctness/canary/stack 실패, 한 연산이라도 회귀, 또는 70% 미만 보존이다.

## Z2 — 별도 profiler build의 비-Keccak 귀속

Z1 성능 펌웨어에는 profiler 분기를 넣지 않는다. Z1 확정 뒤 별도 build에서 DWT를
target assembly call 바로 전후에 읽어 다음 mutually distinct bucket과 호출 수를
keygen/encaps/decaps별로 기록한다.

- matrix generation/accumulation assembly (`matacc_asm_*`): raw cycle와 그 내부
  Keccak permutation 수를 함께 기록해 Keccak cycle을 분리한다.
- encaps/re-encryption basemul assembly (`basemul_asm_*`).
- decaps fused deserialize+basemul assembly (`frombytes_mul_asm_*`).
- CBD 본문과 packing/compression/decompression/message conversion.
- NTT/rev4는 Z1의 직접 차분과 중복되므로 C8/C9 귀속에 다시 더하지 않는다.

각 op을 동일 seed로 반복하고 profiler를 켜지 않은 결과와 출력 byte가 같아야 한다.
bucket 합은 full-operation cycle보다 클 수 없으며, nested double-count를 금지한다.

## 다음 구현 선택 규칙

- C8의 직접 귀속 가능한 non-Keccak cycle이 encaps 10k 이상 또는 decaps 10k 이상이면
  같은 pqmx ordering에서 rev4를 없애는 basemul/matacc fusion을 다음 구현으로 채택한다.
- C8이 둘 다 10k 미만이고 C9가 더 크면 packing/CBD MVE로 이동한다.
- C8+C9를 모두 100% 제거해도 해당 연산의 20% 잔여량에 못 미치면, ML-KEM만으로
  20%를 채운다고 가정하지 않고 X25519 whole-ladder/custom-ABI 트랙을 병행한다.

모든 cycle 결론은 EK-RA8M1 Cortex-M85에 한정한다. 다른 M85/M55/M52는 미측정이다.

## 완료 상태

실험을 완료했다. 확정 결과와 로그/hash는 `2026-08-21_expZ_results.md`에 기록했다.
Z1은 전 연산 strong pass, Z2는 C8 gate를 큰 폭으로 통과했으므로 다음 구현은 C8이다.
