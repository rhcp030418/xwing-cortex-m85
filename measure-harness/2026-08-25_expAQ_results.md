# 실험 AQ 결과 — matacc 내부 세분

> 측정 2026-08-25. 보드 EK-RA8M1, DWT CYCCNT, REP_N=100, 독립 flash/run 2회.
> 선행: `2026-08-25_expAP_results.md`. 원시 로그: `logs/2026-08-25_expAQ_run{1,2}.txt`

---

## 1. 무엇을 닫았나

expAP는 matacc가 ML-KEM 비-Keccak 잔여의 46.7~56.4%(89~91 kcyc)임을 보였지만 **그 안이
XOF 배관인지 실제 산술인지는 미측정**으로 남겼다. K14/K15(matrix-XOF ↔ rejection ↔
matacc 융합) 설계에 그 세분이 필요하다.

## 2. 구조와 방법

matacc 한 번은 K=3이므로 다음과 같다.

```
3 x { xof_absorb  ->  xof_squeezeblocks  ->  matacc_asm_* }
```

`matacc_asm_*`는 `&state`를 받아 rejection 도중 `shake128_squeezeblocks`를 **되부른다**
(`matacc_asm.S:32`의 `bl shake128_squeezeblocks`). 즉 현행 코드는 이미 어느 정도
융합돼 있다.

`kyber_shake128_absorb`와 `shake128_squeezeblocks`를 rename+wrapper로 계측했다. 이 두
심볼은 **matacc 전용**이다 — noise는 `kyber_shake256_prf`를 쓰므로 섞이지 않는다.
asm의 `bl`도 wrapper 심볼을 타므로 되부름까지 잡힌다.

세 값 모두 **Keccak-f1600 permutation cycle이 차감된** 값이다. 따라서 이 문서의
absorb/squeeze는 순열 비용이 아니라 **순열 위에 얹힌 배관 비용**이다.

```
나머지 = matacc − absorb − squeeze = rejection 판정 + MAC 누산 + asm 오버헤드
```

## 3. 결과 — 두 run (차이 최대 2 cyc)

| 연산 | matacc | xof_absorb | xof_squeeze | rejection+MAC |
|---|---:|---:|---:|---:|
| keygen | 94,963 (3 calls) | **11,451** (9 calls, 12.06%) | **27,785** (27.1 calls, 29.26%) | **55,727** (58.68%) |
| encaps | 96,537 (3 calls) | **11,407** (9 calls, 11.82%) | **28,666** (28 calls, 29.69%) | **56,464** (58.49%) |
| decaps | 96,568 (3 calls) | **11,417** (9 calls, 11.82%) | **28,683** (28 calls, 29.70%) | **56,468** (58.47%) |

### 3.1 호출당 단가 — 이게 핵심이다

| | cyc/call | probe(≈31 cyc) 차감 후 | permutation 포함 여부 |
|---|---:|---:|---|
| `kyber_shake128_absorb` | 1,267~1,272 | **≈1,237~1,241** | 순열 없음 |
| `shake128_squeezeblocks` | 1,024 | **≈993** | **순열 5,533 cyc은 별도** |

- **absorb 1건이 약 1,240 cyc이다.** 34바이트(seed 32 + x,y 2)를 state에 넣는 데 든다.
- **squeeze 1건이 순열 5,533 cyc 위에 약 993 cyc를 더 쓴다.** 168바이트를 state에서
  꺼내는 바이트 처리·부기 비용이며, 순열 대비 **+18%** 다.

### 3.2 XOF 배관 총량

| 연산 | absorb+squeeze | matacc 중 | X-Wing 총합 중 |
|---|---:|---:|---:|
| keygen | 39,236 | **41.3%** | **5.12%** |
| encaps | 40,074 | **41.5%** | **3.52%** |
| decaps | 40,100 | **41.5%** | **4.91%** |

**matacc의 41.5%는 산술이 아니라 XOF 배관이다.** 순열은 여기서 이미 빠져 있다.

### 3.3 호출 수가 말해주는 것

- absorb 9회/op = matacc 3회 × K=3. 고정.
- squeeze 27~28회/op. 그중 9회가 각 j-루프의 초기 squeeze이고, **나머지 18~19회는
  rejection sampling이 바이트를 다 써서 asm이 되부른 것**이다.
- encaps 전체 permutation은 46회(expAO)인데 그중 **28회가 matacc XOF**다. 나머지 18회가
  G/H/PRF와 combiner 몫이다.

keygen만 squeeze가 27.12회로 소수점이 붙는다 — rep마다 공개 seed가 달라 rejection
횟수가 흔들리기 때문이며(expAO §4와 같은 원인), encaps/decaps는 28회 고정이다.

## 4. K14/K15에 주는 결론

matacc 89~91 kcyc(expAP 동결본 기준)의 내부는 대략 이렇다.

```
XOF 배관 (absorb 11.4k + squeeze 28.7k)   약 41.5%   ← K14/K15/K22/K23 의 표적
rejection 판정 + MAC 누산                 약 58.5%   ← K15 후반부·K16 의 표적
```

공격 지점이 구체적으로 확정됐다.

1. **absorb 11.4 kcyc (9회 × 1,240)** — 같은 seed로 (i,j)만 바꿔 9번 absorb한다.
   **K22**(incremental state를 caller에 유지)와 **K23**(고정 길이 전용 경로)이 정확히
   이 비용을 노린다. seed 32바이트는 9회 모두 동일하므로 state prefix 재사용 여지가 있다.
2. **squeeze 28.7 kcyc (28회 × 993)** — 순열 위 +18% 배관이다. squeeze 결과를 버퍼에
   쓰고 asm이 다시 읽는 구조를 없애 **rejection이 state에서 바로 소비**하게 만드는 것이
   **K15/K24** 계열의 표적이다.
3. **rejection+MAC 56.5 kcyc** — 이 안의 세분은 asm 내부라 **미측정**이다. 더 쪼개려면
   `matacc_asm.S`에 계측을 넣어야 한다.

상한 회계: XOF 배관을 **전부** 없앤다 해도 encaps 3.52% / keygen 5.12% / decaps 4.91%다.
현실적으로 그 일부만 회수되므로 K14/K15의 기대치는 이보다 작다. 이 수치를 절감률처럼
쓰지 않는다.

## 5. 정확성 게이트 — 전부 PASS (두 run)

```
expAQ equiv: bytes-mm=0 checks=40
expAQ bench: stack-fails=0 stack-used=7880
harness_fails=0, KAT ALL PASS
```

| 게이트 | 결과 |
|---|---|
| probe on 출력 대 probe off 출력, 8 seed × (pk/sk/ct/ss_e/ss_d) | mismatch 0 |
| 기존 전체 하네스 KAT·mismatch (expX~expAP 포함) | 전부 0 |
| stack canary | 0, high-water 7,880 B |
| code-flash readback run1 = run2 | `B6EB74FC…7229` (723,408 B) |

`shake128_squeezeblocks`를 rename+wrapper로 감쌌으므로 `matacc_asm.S`의 `bl`이 wrapper를
타는지가 관건이었다. squeeze 호출 수가 9(초기)가 아니라 **28**로 잡힌 것이 asm 되부름까지
계측됐다는 직접 증거이며, KAT 전부 통과가 동작 불변을 확인한다.

## 6. 한계·미측정

1. **AQ 빌드는 probe로 연산당 8.6~11.2 kcyc 느리다.** matacc 버킷도 내부 probe 때문에
   expAP 동결본 대비 +5.7~5.8 kcyc 부풀어 있다. 비율(41.5% 등)은 AQ 빌드 안에서
   자기일관하며, **절대 cycle 정본은 여전히 expAN**이다.
2. **rejection+MAC 56.5 kcyc의 내부는 미측정이다**(asm 내부).
3. absorb/squeeze 단가에서 뺀 probe 31 cyc는 expAP §2.3의 wrapper 단가를 그대로 쓴
   **근사**다. 정밀히 하려면 null wrapper 슬롯이 필요하다(미측정).
4. legacy wrapper workload 기준, EK-RA8M1 한 개체.

## 7. 다음 작업

1. **X06 fixed-base ladder** — X25519 62.8%로 여전히 압도적 1위. 분모 715,663 cyc.
2. **K19/K20/K21 Keccak permutation** — 2위 22.4%.
3. **K22/K23 XOF 배관** — 3위 표적이 이 실험으로 구체화됐다(40 kcyc, 3.5~5.1%).
   absorb의 seed prefix 재사용이 가장 명확한 후보다.
4. `matacc_asm.S` 내부 계측 — rejection 대 MAC 세분(선택).

## 8. 아티팩트

동결: `artifacts/2026-08-25_expAQ/` (+ `SHA256SUMS.txt`)

| 파일 | SHA-256 |
|---|---|
| `blinky.elf` | `617FD313C5D7473787184C685A90D1280265EBABECA8DF31FF0770B57BDCD7A7` |
| `blinky.srec` | `9E907A3933BC5775CBE6F2FE1C78989EE1AA9E92536136F817602E756D4C5190` |
| `blinky.map` | `0BA6818CB311732E91046EE87B1563701408C00530935BFFD13CD8A9C95313C8` |
| `ap_probe.h` | `FD36C6299E045F6AEA2ED9125E6F367942CE0D170BDB6E48A016E54790EC689B` |
| `expAQ_slots.inc` | `10A0E7128B92D8EBB658CD0C1E5797DA456A41D218043B3942A4284FC0AD89D2` |
| `fips202.c` (계측본) | `9F4F97039B6AA61CAF24C4C548CDAEA07CD3601BDE5AFC691BC7576FA6E8DE24` |
| `symmetric-fips202.c` (계측본) | `D254D0F245CCB1D6E0F4A73B8445DF0CA9E823A50C0353B50044364EA8E25C8A` |
| `harvest_ra8m1_expAQ.py` | `FE115B86E0F77F3B1EFFAD4B4DCD08DA07E20D7C78DDD43B24A06235B642D303` |
| code-flash readback (run1=run2) | `B6EB74FCA5DB55A6426A7E7583D2F593908AB8043C82A36BD776D090B1F87229` (723,408 B) |
| `logs/2026-08-25_expAQ_run1.txt` | `927C8FF49785D93386B28328D480CBA8D5286E583F96E5C138BF58971F02AF4E` |
| `logs/2026-08-25_expAQ_run2.txt` | `9C761926E6C8A5A41FC7B96340CB2277776A006164D579DE7295BB418174EBAC` |

원본 백업: `keccak/fips202.c.bak-20260825-expAQ`,
`mlkem/symmetric-fips202.c.bak-20260825-expAQ`.
하네스 변경: `REP_SLOTS 420→435`, `#include "expAQ_slots.inc"`, `expaq_run_all()`.
`ap_probe.h`의 `AP_NBUCKET 8→10`, `expAP_slots.inc`의 store 루프를 8로 고정.
