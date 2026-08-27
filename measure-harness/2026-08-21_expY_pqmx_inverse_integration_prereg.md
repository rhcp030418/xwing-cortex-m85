# 실험 Y 사전 등록 — pqmx M85 inverse를 실제 ML-KEM에 연결

## 질문

실험 X에서 채택 가능한 것으로 확인된 `pqmx forward → rev4`를 양쪽에 공통으로
고정한 뒤, 현재 Plantard 경로의 inverse만

- A: 기존 `invntt_fast`
- B: `rev4 → pqmx WIP M85 inverse(Plantard-domain factor variant)`

로 바꾸면 byte-for-byte 호환성을 유지하면서 full ML-KEM
keygen/encaps/decaps가 실제로 빨라지는가?

## 고정 입력과 provenance

- pqmx WIP commit: `1eeaf854e60d4ac30a2866d2a05f5935199ad6a6`
- SLOTHY WIP commit: `ed3b034b3a3fbf06530784dd01a7622d4f6cf0fb`
- 원본 M85 inverse 함수: `intt_kyber_1_23_45_67_opt_m85`
- 원본의 최종 factor `512`, twisted factor `5040`은 그대로 control로 남긴다.
- candidate의 factor 값은 host modular oracle에서 현재 Plantard inverse 입력 계약과
  일치하는 것이 확인된 경우에만 고정한다. 정적 추정만으로 보드 결론을 내리지 않는다.
- candidate root table은 `.balign 16`, code는 ITCM에 둔다. 주소·크기·ELF 해시를 기록한다.

## 단계 1 — host gate

1. q=3329의 모든 residue에 대해 원본 factor와 candidate factor의 domain 변환식을
   exhaustive 검사한다.
2. twisted immediate가 candidate factor와 같은 Barrett 곱을 구현하는지 exhaustive
   또는 동치인 완전 residue 검사를 한다.
3. 생성기를 다시 실행했을 때 같은 assembly가 나오는지 SHA-256으로 고정한다.

하나라도 실패하면 보드 통합을 하지 않고 Y는 실패로 종료한다.

## 단계 2 — 보드 standalone oracle

- 동일한 raw bit-reversed 입력을 두 버퍼에 복사한다.
- A에는 현재 `invntt_fast`, B에는 `rev4 → candidate inverse`를 적용한다.
- 결정적 random, 0, q-1, centered 경계 등 최소 8개 벡터의 256계수를 mod q로 전부 비교한다.
- 입력·출력 buffer canary, candidate output 최소/최대, pointer low-4 alignment bitset을 기록한다.
- 원본 WIP inverse의 기존 표준-domain oracle도 계속 통과해야 한다.

계수 mismatch 또는 canary/fault가 하나라도 있으면 full ML-KEM 성능값은 기각한다.

## 단계 3 — full ML-KEM 정확성

- 양 mode 모두 실험 X forward wrapper를 사용한다.
- 최소 8개 고정 seed 각각에 대해 mode 직전에 RNG를 같은 seed로 reset한다.
- pk, sk, ct, valid encaps/decaps ss, 훼손 ct의 reject ss를 전 바이트 비교한다.
- 기존 X25519/SHA3 KAT, ML-KEM roundtrip+reject, 실험 A~X mismatch를 유지한다.
- 실제 inverse caller의 입력 범위와 low-4 pointer alignment를 correctness 구간에서 직접 기록한다.
- `harness_fails=0`이어야 한다.

## 단계 4 — full ML-KEM cycle A/B

- A/B는 같은 firmware, 같은 DTCM stack, 같은 benchmark 함수와 stack frame을 쓴다.
- 각 mode 시작 전에 측정 밖에서 RNG를 같은 seed로 reset한다.
- `A → B → B → A` ABBA 순서로 keygen/encaps/decaps 각각 N=100 중앙값을 측정한다.
- stack canary와 high-water를 기록한다.
- 두 번 독립 flash/run한다.
- 판정에는 각 run·연산의 AB/BA 절감 중 작은 conservative 값만 쓴다.

실험 W의 검증 전 예상은 inverse 1회당 대략
`6588 - 3294 - rev4` cycle 절감이다. 이 예상값은 판정에 대신 쓰지 않는다.

## 사전 판정

**강한 성공**:

- host, standalone, byte/KAT/mismatch, canary gate 전부 통과,
- 세 full operation 모두 두 방향에서 빨라짐,
- 각 run의 conservative 절감이 keygen ≥6k, encaps ≥8k, decaps ≥10k cycle,
- 두 run 재현.

**부분 성공**: 정확성·안전성은 통과하지만 하나 이상의 cycle gate 미달.

**실패**: host/domain/byte/KAT 불일치, fault/canary 손상, 또는 한 연산이라도
conservative cycle 회귀.

Y의 cycle은 실험 X와 중복되지 않는 inverse-only 기여다. 전체 20% 판정에는
실험 X의 실제 forward 절감과 Y의 실제 inverse 절감만 더하며 W의 primitive 투영은
다시 더하지 않는다.

## 실측 결과 (2026-08-21)

### 측정 전 게이트와 프로토콜 정정

Host oracle은 그대로 PASS했다. 최종 factor는 `1888`, twisted factor는 `18584`이며,
생성된 함수와 root table을 각각 16-byte 정렬했다. 최종 ELF에서 함수 주소는
`0x0000a900`, candidate `roots_inv`는 `0x22001400`이다. ITCM/DTCM 사용 끝 주소는
각각 `0x0000b600`/`0x20008600`으로 두 64 KiB 영역 안에 들어간다.

첫 flash/run(`run1`)은 성능 판정에서 제외했다. 사전 등록한 standalone 벡터 중 양의
`q-1=3328`과 일부 `[0,q-1]` random 값은 기존 `fastinvntt.S`가 명시한
`input coefficients < 0.5q` 계약 밖이었다. 이 잘못된 oracle에서 mismatch 10이 나왔고,
규칙대로 해당 run의 성능값을 전부 기각했다. 실제 full ML-KEM 8-seed byte 비교는 이
run에서도 0 mismatch였다.

두 구현 모두에 유효한 계약을 시험하도록 `q-1`을 centered representative `-1`로,
random 값을 모두 `[-1664,1664]`로 고쳤다. 성능 함수·모드·RNG·ABBA 순서는 바꾸지
않았다. 이 정정 뒤 두 번의 독립 flash/run(`run2`, `run3`)을 새 유효 결과로 사용했다.

### 정확성·안전성

두 유효 run이 모두 다음을 만족했다.

- host exhaustive/random/basis/polymul oracle PASS
- standalone inverse coefficient mismatch 0, canary failure 0
- full ML-KEM 8-seed pk/sk/ct/valid-ss/reject-ss byte mismatch 0
- X25519/SHA3 KAT와 기존 실험 mismatch 전부 0
- 실제 inverse 입력 범위 `[-1664,1664]`, baseline/candidate alignment bitset `257/257`
- timing workload byte mismatch 0, stack canary failure 0, high-water 6,536 B
- `harness_fails=0`

### Full ML-KEM inverse-only ABBA 결과

단위는 cycle/op이며 각 값은 N=100 중앙값의 baseline-candidate 차이다.

| run | 연산 | AB 절감 | BA 절감 | conservative | gate | 판정 |
|---|---|---:|---:|---:|---:|---|
| 2 | keygen | 8,305 | 8,352 | **8,305** | 6,000 | PASS |
| 2 | encaps | 10,957 | 10,976 | **10,957** | 8,000 | PASS |
| 2 | decaps | 13,592 | 13,590 | **13,590** | 10,000 | PASS |
| 3 | keygen | 8,305 | 8,356 | **8,305** | 6,000 | PASS |
| 3 | encaps | 10,957 | 10,974 | **10,957** | 8,000 | PASS |
| 3 | decaps | 13,592 | 13,590 | **13,590** | 10,000 | PASS |

**사전 판정: 강한 성공.** 세 연산이 AB/BA 양 방향과 두 독립 run에서 모두 빨라졌고,
정확성·안전성 gate 및 6k/8k/10k cycle gate를 전부 통과했다.

같은 최종 펌웨어에서 다시 잰 X forward conservative 값
`10,467/5,220/10,614`와 Y를 합치면 NTT 계층의 실측 기여는
keygen/encaps/decaps 각각 **18,772/16,177/24,204 cycle**이다. 이는 W의 raw
primitive projection을 대체하며 W 값을 다시 더하지 않는다.

정정된 U 투영, 독립 MVE Keccak 투영, X와 Y의 full-operation 실측 차분을 합친 현재
혼합 장부는 **16.33/15.45/15.68%(평균 15.82%)**다. 완전 통합 X-Wing 한 번의
end-to-end 측정값은 아니므로 20% 달성 주장은 할 수 없고, 20%까지 남은 절대 cycle은
각각 **29,155/53,491/37,508 cycle**이다.

### 재현 파일과 SHA-256

- ELF `087151B1837CF675D6E23BCDC62CC170D6319345EB158B5E0C4FC3200E946058`
- SREC `C9498094D0EC618752C4FBB9592654B2583A00B84C090BCFDF9E7ACE103BA7AD`
- candidate asm `7247F021212E7A041F14F5BD7863107B2A6A3718BC1701C91BEB0C6FBA9743A0`
- generator `6070689F3D262AA868E3B7F72FD270A9FC47B1C716C9CA43935C1F48A7D6AC0B`
- host oracle script `5395FE317AC4C16E73B8DE63261611EA759AC393398DB99DF7FA0F683221F1D2`
- staged harness `056A8583515AB474370D996787E57BB23F4FBA6A1E78F04A5C6799053DA5211F`
- staged NTT wrapper `7E327720050C8AB60BDE192FEB075B5630610DB1EF1AD57A5C4276B0091D0300`
- harvester `20AC894CB00804F94B34EE332EC141605BAD7588C4797E056AEE68178A644660`
- valid run2 `78D601E01FEFDAB6FE10925FDC946E9C09B9D8E33D4A2734ED46C20B209F0FF2`
- valid run3 `B8173990601488160006A056A654165978297B51C2E1CD606160828F5AD8C66A`
