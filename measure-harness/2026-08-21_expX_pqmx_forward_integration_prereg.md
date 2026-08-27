# 실험 X 사전 등록 — pqmx M85 forward를 실제 ML-KEM에 연결

## 질문

> 실험 W의 최선 `2+3+2 size` forward 뒤에 explicit `rev4`를 붙이면 현재
> Plantard pointwise/inverse 계약과 byte-for-byte 호환되며, full ML-KEM
> keygen/encaps/decaps에서 실제 양의 절감을 보이는가?

inverse는 바꾸지 않는다. WIP inverse/domain 보정은 X 통과 뒤 별도 실험이다.

## 고정 입력·소스

- pqmx/SLOTHY forward와 commit은 실험 W와 동일하다.
- 비교 firmware 안에 `mlkem_ntt_mode=0/1`을 두어 나머지 코드·링크 배치를 고정한다.
- mode 0: 기존 `ntt_fast(poly, zetas_asm)`.
- mode 1: `ntt_kyber_12_345_67_opt_size_m85(poly)` 후 4×4 int32-pair `rev4`.
- deterministic RNG를 `0x42424242`로 각각 reset해 baseline과 candidate의
  pk/sk/ct/encaps-ss/decaps-ss를 전 바이트 비교한다.
- 변경 전 live SHA-256:
  - `ntt.c`: `836672DBFC7BA0059FCF90E4C9DC87A4DF92451C4141A3FFD3074DA46FE9B943`
  - `randombytes_det.c`: `E458CA794B1D2E97FC5673EA819B818CA8462BA0BC56E804DB404C5FB9873202`
  - `harness.c`: `BB2AA45E62DF2925020B29CAEF3A2DF7E4B0FE166D11F65C4F68698F029018AC`

## 정확성

1. baseline/candidate pk, sk, ct, encaps ss, decaps ss 전 바이트 동일.
2. candidate 자체 encaps→decaps shared secret 일치 및 훼손 ciphertext 기각.
3. actual ML-KEM 호출에서 관찰된 NTT 포인터의 low 4-bit offset을 bitset으로 기록한다.
4. 기존 X25519/SHA3 KAT, ML-KEM smoke, 실험 A~W mismatch 전부 유지.
5. `harness_fails=0`.

## 측정

- 같은 firmware, 같은 DTCM stack, 각 mode별 N=100 중앙값과 빈 측정 차감.
- baseline full operation은 기존 slot 3~5, candidate는 새 slot 136~138.
- 두 번 독립 flash/run.
- cycle 비교는 각 run 안의 mode 0과 mode 1 사이에서만 계산한다.

실험 W로부터 얻은 **검증 전 예상**은 forward 1회당
`5,354.012 - 2,814.027 - 608.032 = 1,931.953cyc` 절감이다. 정적 호출 수를
곱하면 keygen/encaps/decaps 약 11.6k/5.8k/11.6kcyc지만, 이는 full integration
실측값이 아니며 판정에 대신 쓰지 않는다.

## 사전 판정

**강한 성공**:

- 모든 byte/KAT/mismatch gate 통과,
- 세 full operation 모두 candidate가 baseline보다 빠름,
- 실측 절감이 각각 keygen ≥8k, encaps ≥4k, decaps ≥8kcyc,
- 두 run 재현.

**부분 성공**: 정확성은 통과하지만 한 연산이라도 양의 절감 또는 위 cycle gate 미달.

**실패**: byte 결과/KAT 불일치, fault/canary 손상, 또는 한 연산이라도 유의미한 회귀.

X 통과는 forward wrapper 채택 근거일 뿐 20% 달성 결과가 아니다. 전체 X-Wing 분모와
기존 미통합 기여를 합산할 때도 실제 X cycle만 사용한다.

## 실측 결과 (2026-08-21)

### run1/run2 제외 사유

최초 `run1`과 `run2`의 정확성 결과는 통과했지만, 두 로그의 **성능 수치는 최종
판정에서 제외**한다. 당시 timing harness는 baseline 블록 뒤에 candidate 블록을
실행하면서 각 mode 시작 전에 deterministic RNG를 같은 seed로 되감지 않았다. 따라서
두 mode가 RNG stream의 서로 다른 구간에서 생성된 입력을 처리했고, 입력 차이와 NTT
교체 효과가 함께 섞였다. 이는 동일 workload의 paired comparison이 아니므로 관측된
차이를 forward 교체의 인과 효과로 해석할 수 없다.

수정한 harness는 각 mode 블록 직전에, 측정 구간 밖에서 RNG를 `0x58585858`로 reset하고
동일 함수와 동일 DTCM stack frame을 사용한다. 실행 순서는
`A(baseline) → B(candidate) → B(candidate) → A(baseline)`인 ABBA로 고정하여 입력
stream을 동일하게 재생하고 순서 편향도 양방향으로 확인했다. 따라서 최종 판정에는
이 방식으로 다시 flash/run한 `run3`과 `run4`만 사용한다.

### 정확성·안전성

두 유효 run 모두 다음 결과가 같았다.

- X25519/SHA3 KAT 및 ML-KEM roundtrip+reject: 통과
- `expX bytes-mm=0`, `smoke-fails=0`
- `expX timing-mm=0`: ABBA 네 블록의 최종 pk/sk/ct/encaps-ss/decaps-ss가 전 바이트 동일
- baseline/candidate NTT 포인터 alignment bitset: `257/257`
- `stack-fails=0`, DTCM stack high-water: `6536 B`
- 기존 실험 mismatch 전부 `0`, 최종 `harness_fails=0`

### ABBA N=100 중앙값과 절감

아래 cycle은 각 run 내부의 중앙값이다. `AB 절감`은 첫 A에서 첫 B를 뺀 값,
`BA 절감`은 마지막 A에서 두 번째 B를 뺀 값이며, 사전 판정에는 둘 중 작은
`conservative` 값을 사용했다. 동일 run 안의 차감이므로 25-cycle calibration은
차이에서 상쇄된다.

| run | 연산 | A1 baseline | B1 candidate | AB 절감 | B2 candidate | A2 baseline | BA 절감 | conservative |
|---|---|---:|---:|---:|---:|---:|---:|---:|
| 3 | keygen | 437415 | 426888 | 10527 | 426920 | 437444 | 10524 | **10524** |
| 3 | encaps | 452609 | 447278 | 5331 | 447282 | 452604 | 5322 | **5322** |
| 3 | decaps | 503535 | 492777 | 10758 | 492771 | 503533 | 10762 | **10758** |
| 4 | keygen | 437415 | 426888 | 10527 | 426920 | 437444 | 10524 | **10524** |
| 4 | encaps | 452609 | 447278 | 5331 | 447282 | 452608 | 5326 | **5326** |
| 4 | decaps | 503535 | 492777 | 10758 | 492771 | 503533 | 10762 | **10758** |

두 run의 conservative 절감은 keygen `10524`, encaps `5322/5326`, decaps
`10758` cycle이다. 모두 사전 등록 gate인 `8000/4000/8000` cycle을 넘었고 세 연산
모두 빨라졌으며 두 run에서 재현되었다. 정확성·안전성 gate도 모두 통과했으므로
**실험 X 판정은 강한 성공**이다. 이 결론의 범위는 pqmx M85 forward와 explicit
`rev4` wrapper를 현재 ML-KEM에 실제 통합할 수 있다는 것까지이며, 20% 전체 목표 달성
판정이나 WIP inverse 채택까지 포함하지 않는다.

### 재현 해시 (SHA-256)

- ELF `blinky.elf`: `4F747F6C746F3470F7D7815F0B852989888FDE4F50E60A90594B227F314936D8`
- live/staged harness (두 파일 동일): `CFCAB5581B38A9A4132761A64E35FD84EF4A9E08A6741ADA47B5882D7E4C7FF3`
- harvester `harvest_ra8m1.py`: `8A00404EC53B3F80FDA2A402425091D71DB959171CD70E17B8B7BAC726D995B2`
- 유효 로그 `run3_abba`: `2519DBBBAE93E8D2CEE5F7D05442A78B5177FF0AD40A036D767B958983C5E16A`
- 유효 로그 `run4_abba`: `9E60E2B1F185FE4357E08896C6CB75FDA69057F53081C73FF5C3F555106EC1F3`
- 제외 로그 `run1`: `AAA4C47511F0ADFFEF88DFCAC69B53FA23A5CF5D0512BCB4D54C90576F2E3E00`
- 제외 로그 `run2`: `B9C5388D404AB29ABD9D19D29441578388D93C71A1150E950649D7E0ACA291EC`
