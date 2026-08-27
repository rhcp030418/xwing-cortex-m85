# 실험 V 사전 등록 — 현재 ML-KEM NTT/invNTT cycle attribution

## 질문

> 현재 EK-RA8M1 ML-KEM에서 forward NTT와 inverse NTT가 실제로 몇 cycle을 차지하며,
> 이 두 primitive만 교체해 리서치 보고서의 종단간 게이트(5k/20k/15kcyc)에
> 도달할 절대 예산이 존재하는가?

## 배경

보고서는 외부 Cortex-M85 forward NTT 910~947cyc를 근거로 pqmx/SLOTHY NTT 이식을
제안했다. 그러나 현재 프로젝트도 이미 `fastntt.S`/`fastinvntt.S`를 쓰므로,
현재 비용을 재지 않고 외부 숫자를 그대로 이득으로 계상하면 안 된다.

콜그래프의 정적 호출 횟수:

| ML-KEM 연산 | forward NTT | inverse NTT |
|---|---:|---:|
| keygen | 6 | 3 |
| encaps | 3 | 4 |
| decaps (`indcpa_dec` + constant-time re-encryption) | 6 | 5 |

## 단일 변경과 측정

- 알고리즘/구현은 바꾸지 않는다. 하네스에 기존 `poly_ntt()`와 `poly_invntt()`
  직접 측정 슬롯만 추가한다.
- 계수 범위가 반복으로 커지지 않도록 0 다항식을 쓴다. NTT/invNTT는 0을
  0으로 보존하고 명령 경로는 입력값과 무관한 상수시간이다.
- 각 슬롯은 커널 1,000번 반복 × N=100, DWT 중앙값으로 계상한다.
- 두 번의 독립 플래시/실행으로 재현성을 확인한다.
- 기존 X25519/SHA3 KAT, ML-KEM roundtrip+reject, 모든 mismatch,
  `harness_fails=0`을 그대로 유지한다. 추가로 0 다항식이 두 변환 후에도 0인지 확인한다.

## 사전 판정

모든 성능값은 실보드 전까지 `미측정`이다.

측정값을 `F`(정방향), `I`(역방향)cyc라 할 때, NTT 전부를 0cycle로 만드는
비현실적 상한은 keygen `6F+3I`, encaps `3F+4I`, decaps `6F+5I`다.

- 이 상한이 5k/20k/15k보다 작으면, 보고서 C7의 해당 종단간 게이트는 NTT
  단독으로 물리적으로 불가능하다.
- 상한은 통과하지만 실현 절감은 작으면 basemul/packing/CBD로 확장한다.
- 외부 910~947cyc는 RA8M1 실측값으로 가정하지 않는다. 포팅 후에 같은 보드에서
  직접 재야만 절감으로 승격한다.

## 실측 결과 — 2026-08-21

빌드와 두 번의 독립 플래시/실행을 완료했다.

- clean build: 0 errors (`blinky.elf`의 `rep_cyc` 크기 `0xc990` = 129×100×4B)
- run 1: X25519/SHA3 KAT PASS, ML-KEM roundtrip+reject OK,
  `expv_mismatch=0`, 전체 mismatch 0, `harness_fails=0`
- run 2: 위와 동일
- 두 run의 N=100 중앙값은 cycle 단위까지 동일했다.

| primitive | run 1 | run 2 | 채택값 |
|---|---:|---:|---:|
| forward `poly_ntt()` | 5,354.012 cyc | 5,354.012 cyc | **5,354.012 cyc** |
| inverse `poly_invntt()` | 6,586.012 cyc | 6,586.012 cyc | **6,586.012 cyc** |

빈 측정 중앙값 25cycle을 먼저 차감한 뒤 1,000으로 나눈 값이다.

정적 호출 횟수와 결합한 현재 NTT 비용은 다음과 같다.

| ML-KEM 연산 | 현재 NTT 총비용 | 같은 펌웨어 full-op 대비 | 보고서 gate | 0cycle 상한 판정 |
|---|---:|---:|---:|---|
| keygen | 51,882.108 cyc | 11.88% | 5,000 | 통과 가능 |
| encaps | 42,406.084 cyc | 9.36% | 20,000 | 통과 가능 |
| decaps | 65,054.132 cyc | 12.91% | 15,000 | 통과 가능 |

## 결론

**C7은 기각되지 않았다.** 현재 구현이 이미 `fastntt.S`/`fastinvntt.S`를
사용함에도 NTT 계열은 각 ML-KEM 연산에서 42.4k~65.1kcycle을 차지한다.
따라서 보고서의 5k/20k/15k gate를 넘길 절대 예산은 실제로 존재한다.

그러나 이 표는 최적화 이득이 아니라 현재 비용과 0cycle 절대 상한이다.
외부 AN555의 910~947cycle은 아직 현재 ABI·계수 순서·inverse 변환까지 검증된
RA8M1 값이 아니므로 절감으로 계상하지 않는다. 다음 단계는 pqmx primitive를
독립 빌드해 EK-RA8M1에서 직접 측정하고, ordering/conversion을 포함한 통합 A/B를
수행하는 것이다.

원시 로그:

- `logs/2026-08-21_expV_ntt_attribution_run1.txt`
- `logs/2026-08-21_expV_ntt_attribution_run2.txt`
