# 실험 BU 결과 — **E0 완료**: X-Wing draft-10 준거 이동과 대표값 재측정 (+ **W14 실측**)

> 측정 2026-08-26. 보드 EK-RA8M1, DWT CYCCNT, REP_N=100, 독립 flash/run 3회, 각 회 3 pass.
> 장부 §4.1.1 이 요구한 "준거 대상 버전 이동"을 수행하고 그 baseline 에서 다시 쟀다.
> 부수적으로 장부 **W14(packed cold / expanded warm API)** 를 실측한다.

---

## 1. 무엇을 옮겼나 — 네 항목을 한 번에

장부 §4.1.1 의 지시대로 **부분 이동 없이** 네 항목을 동시에 옮겼다.

| # | 항목 | 이전 (ePrint 2024/039 Fig.12) | **draft-10 (이번)** |
|---|---|---|---|
| 1 | combiner 입력 순서 | `label ‖ ss_M ‖ ss_X ‖ ct_X ‖ pk_X` | **`ss_M ‖ ss_X ‖ ct_X ‖ pk_X ‖ label`** |
| 2 | decapsulation key | 확장 상태(2,464 B) 보관 | **packed 32 B seed + `SHAKE256(sk,96)` 확장** |
| 3 | encapsulation 난수 | ML-KEM 내부 난수 | **`eseed` 64 B = `m ‖ ek_X` derand 분할** |
| 4 | encapsulation-key check | 없음 | **FIPS 203 §7.2 검사 (MUST)** — 실패 시 error |

label 바이트열은 두 정의에서 동일하다(`5C 2E 2F 2F 5E 5C`). 바뀐 것은 **위치**뿐이다.

구현: `src/expBU_draft10.inc`. `crypto_kem_{keypair,enc}_derand` 를 `static` 에서 공개로
바꿔 derand 진입점을 썼다(`mlkem/kem.c`, 백업 `kem.c.bak-20260826-expBU`).

## 2. 정확성 — 전부 PASS (3회 동일)

| 검사 | 결과 |
|---|---|
| 8-seed keypair→enc→dec 공유비밀 일치 (`smoke`) | **0** |
| **cold 대 warm 완전 일치** (정상·거부 양쪽, 바이트 단위) | **0 mismatch** |
| 암묵적 거부: ct 훼손 시 enc 값과 달라짐 | **0 실패** |
| FIPS 203 §7.2 검사가 훼손된 `pk_M` 을 실제로 거부 | **0 실패** |
| 기존 전체 하네스 (`harness_fails`) · ML-KEM/X25519/SHA3 KAT | **0 / PASS** |

## 3. draft-10 준거 대표값 (**정본**)

독립 flash/run 3회 × 3 pass, 보수적(최댓값 아닌 최솟값 아님 — 세 pass 의 최솟값) 채택.
회차 간 최대 차이는 keygen 38 cyc(0.006%)다.

| 연산 | run1 | run2 | **대표값** |
|---|---:|---:|---:|
| keygen | 627,069 | 627,085 | **627,069** |
| encaps | 988,456 | 988,466 | **988,456** |
| **decaps (warm, 확장키 캐시)** | 780,020 | 780,026 | **780,020** |
| **decaps (cold, packed seed)** | 1,406,889 | 1,406,887 | **1,406,887** |

## 4. 이전 정의(2024/039)와의 차 — **파생 비교**

| 연산 | 2024/039 (expBN) | draft-10 (이번) | 차 |
|---|---:|---:|---:|
| keygen | 621,106 | 627,069 | **+5,963 (+0.96%)** |
| encaps | 977,896 | 988,456 | **+10,560 (+1.08%)** |
| decaps (warm) | 785,540 | 780,020 | **−5,520 (−0.70%)** |

> **다른 빌드·다른 정의의 비교이므로 파생 수치다.** 두 정의는 서로 다른 함수이며
> 절감/회귀로 읽어서는 안 된다. 아래는 차이의 **출처 설명**이지 최적화 결과가 아니다.

- **keygen +5,963**: `SHAKE256(sk, 96)` 확장(약 2 permutation)과, `pk_X` 를 확장된 seed 에서
  계산하는 경로가 추가됐다.
- **encaps +10,560**: **FIPS 203 §7.2 encapsulation-key check** 가 새로 든다
  (`polyvec_frombytes` + `polyvec_tobytes` + 1,152 B 비교).
- **decaps −5,520**: 이전 wrapper 는 `sk` 에 `pk_X` 를 따로 담아 두고 읽었는데, draft-10
  warm 경로는 확장 캐시에서 바로 읽는다. **정의 차이에서 온 부수 효과이며 최적화가 아니다.**

## 5. W14 실측 — cold 는 warm 의 **1.80배**

draft-10 은 확장 결과 캐싱을 **MAY** 로 허용한다. 두 경로를 같은 ELF 에서 쟀다.

| | cyc | warm 대비 |
|---|---:|---:|
| decaps **warm** (확장키 캐시) | **780,020** | 1.00× |
| decaps **cold** (packed 32 B seed) | **1,406,887** | **1.804×** |
| 차 = `expandDecapsulationKey` | **626,867** | |

626,867 cyc 는 **ML-KEM keygen 전체 + X25519 fixed-base + SHAKE256 확장**이다.
draft-10 keygen 627,069 과 **202 cyc(0.03%) 차이**로 일치한다 — 확장이 곧 keygen 이라는
정의를 실측이 그대로 확인한다.

> **장부 W14 판정**: 두 워크로드는 **1.8배 다른 것**이며, 어느 쪽을 "decaps latency" 로
> 보고하느냐가 수치를 80% 바꾼다. **논문은 반드시 둘을 구분해 표기해야 한다.**
> 이 프로젝트의 기존 모든 decaps 수치는 **warm** 워크로드다.

### 5.1 W14 는 최적화 후보가 아니라 **보고 규약** 문제다

cold 비용은 정의가 요구하는 계산이며 줄일 수 있는 종류가 아니다(ML-KEM keygen 자체).
따라서 W14 를 **성능 가족에서 종료**하고, **보고 규약**(§5)으로 장부에 남긴다.

## 5.5 draft-10 **공식 test vector 대조 — PASS** (expBW, 2026-08-26 추가)

`draft-connolly-cfrg-xwing-kem-10` 부록의 test vector 1 을 보드에서 직접 대조했다.

| 검사 | 결과 |
|---|---|
| **shared secret `ss` 32 B 완전 일치** | **mismatch 0** |
| decapsulate 로 되짚은 `ss` 일치 | **mismatch 0** |
| `pk` 앞 128 B 일치 | **mismatch 0** |
| `ct` 앞 62 B 일치 | **mismatch 0** |

독립 flash/run 2회 동일, `harness_fails = 0`.

`ss` 는 `expandDecapsulationKey` → ML-KEM `KeyGen_internal` → X25519 → ML-KEM
`Encaps_internal` → Combiner 의 **전 사슬**에 의존한다. 따라서 **§1 의 네 항목 이동 전체가
공식 벡터로 검증됐다.**

문서에서 확보한 필드는 seed(32) · eseed(64) · ss(32) 전체와 pk 앞 128 B · ct 앞 62 B 다
(원문의 pk 1,216 B / ct 1,120 B 는 전체를 받지 못했다). **전체 바이트 대조는 여전히 미완이나,
`ss` 일치가 사슬 전체를 덮는다.**

구현: `src/expBW_d10kat.inc`. 동결 `artifacts/2026-08-26_expBW/`.

## 6. 자원

`.text` 781,356 / `.data` 7,544 / `.bss` 356,904.
draft-10 경로 추가분: `.text` +2,080 B, DTCM +약 3.8 KB(`d10_expanded` 캐시 2,496 B 포함).
**secret key 가 2,464 B → 32 B 로 줄어든다**(packed). 이는 draft-10 의 실질 이득이다.

## 7. 미측정·한계

1. draft-10 공식 test vector 대조는 **§5.5 에서 수행했고 PASS 다**(2026-08-26 추가).
   다만 `pk` 전체 1,216 B · `ct` 전체 1,120 B 대조는 **미완**이다(문서에서 앞부분만 확보).
   `ss` 32 B 완전 일치가 사슬 전체를 덮으므로 준거 확인으로는 충분하다고 본다.
2. §4 의 세 항목별 비용 귀속은 **설명**이며 각각을 분리 계측하지 않았다.
3. cold 경로의 상수시간 성질은 이 실험에서 재지 않았다.
4. 기존 채택본(X06/X01/X02/K31)은 draft-10 경로에도 그대로 적용된다 — 커널이 같기 때문이다.
   다만 **draft-10 baseline 에서 각 후보를 다시 A/B 하지는 않았다.**
5. EK-RA8M1 한 개체, 이 배치 한정.

## 8. 아티팩트

동결: `artifacts/2026-08-26_expBU/` (+ `SHA256SUMS.txt`)

| 파일 | SHA-256 |
|---|---|
| `blinky.elf` | `23240BF041D6B6962D85DFF811A60FE9D53E1A28A5D3F6B34380D7BB18680025` |
| `blinky.srec` | `021E36367FE951FD0884DD11C6B63AC257111DCBC448AF048C596192B87E27CE` |
| `expBU_draft10.inc` | `D2BC31105B03F01D137ED5464470D69625C9D439F1886C2DE4A0CFA694B08A30` |
| `kem.c` | `C0BE5B414E279B0E44A4C5BC33210693162C79530C236B2AC464ED962A257B44` |
| `harvest_ra8m1_expBU.py` | `79D5DAF3CFEBF8FB07D3232B5B6DEDBD2A568295B8987F73E7C20C65669CB0AE` |
| code-flash readback | `7DD520B096D88A0A2F50D434B547450EA1EEA9558BE563E79DD2B282BDD61561` (788,884 B) |

## 9. 정직 기록

1. **초판에는 draft-10 KAT 대조가 없었다.** 같은 날 §5.5 로 수행해 **PASS** 했고,
   §7-1 을 그에 맞게 고쳤다. 초판의 유보 문장은 이 기록으로 남긴다.
2. §4 의 차이는 **정의가 달라서 생긴 것**이며 최적화 결과가 아니다. 절감률로 인용 금지.
3. 이전 정의의 대표값(expBN)도 **폐기하지 않는다.** 논문에서 어느 정의를 쓰는지 밝히고
   해당 값을 인용한다(장부 §4.1.1 의 지시).
4. cold/warm 은 **다른 워크로드**다. 하나의 "decaps" 수치로 뭉뚱그리지 않는다.
