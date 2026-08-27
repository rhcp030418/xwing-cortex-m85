# 실험 AP 결과 — ML-KEM 비-Keccak 내부 재귀속

> 측정 2026-08-25. 보드 EK-RA8M1, DWT CYCCNT, REP_N=100, 독립 flash/run 2회.
> 선행: `2026-08-25_expAN_results.md`, `2026-08-25_expAO_results.md`.
> 원시 로그: `logs/2026-08-25_expAP_run{1,2}.txt`

---

## 1. 무엇을 닫았나

expAN → expAO 로 X-Wing 을 층층이 벗겨 마지막에 남은 미측정 블록이
**ML-KEM 비-Keccak 잔여**(keygen 169k / encaps 161k / decaps 194k, X-Wing 의 14~24%)
였다. Z2(2026-08-21)에 비슷한 측정이 있지만 **C8/C9 채택 이전 코드**이고 분모도 달라서
현행 경로에 그대로 쓸 수 없었다. 이 실험이 그 블록을 현행 X/Y/C8+C9 경로에서 다시 쟀다.

이로써 X-Wing 전체가 **미측정 블록 없이** 분해됐다.

## 2. 방법

### 2.1 호출 지점을 건드리지 않는 rename + wrapper

대상 함수(`poly.c` 21개, `matacc.c` 2개, `verify.c` 2개)를 `ap_inner_*` 로 rename 하고
같은 이름의 얇은 wrapper 를 파일 끝에 붙였다. **호출 지점은 하나도 수정하지 않았다.**
early-return 이 있는 함수도 wrapper 방식이면 문제가 없다.

### 2.2 Keccak 을 정확히 차감한다

모든 bucket 은 expAO 의 `g_keccak_perm_cyc` 누산기를 이용해 **창 안에서 실제로 든
permutation cycle 을 그대로 뺀다.**

```c
ap_cyc[B] += (AP_CYCCNT - _apt) - (g_keccak_perm_cyc - _apk);
```

Z2 는 `matacc raw − (내부 perm 수 × 5,526)` 이라는 간접 보정을 썼다. 이번에는 직접
차감이므로 그 근사가 필요 없다.

> **정확히 무엇이 빠졌는지**: 빠지는 것은 **Keccak-f1600 permutation cycle 뿐**이다.
> SHAKE 의 absorb/squeeze 바이트 처리, state XOR, rejection sampling 판정은 **버킷에
> 남아 있다.** 따라서 `matacc` 버킷은 "matrix XOF 의 permutation 을 제외한 나머지 전부"이며
> "순수 MAC 누산"이 아니다. 이 구분이 K14/K15 해석에 결정적이다.

### 2.3 probe 비용

| 연산 | prof off | prof on | probe |
|---|---:|---:|---:|
| keygen | 765,041 | 769,373 | **+4,332** (0.57%) |
| encaps | 1,138,459 | 1,144,056 | **+5,597** (0.49%) |
| decaps | 813,867 | 821,058 | **+7,191** (0.88%) |

누산값은 prof-on 창 안에서 측정되므로 각 bucket 에 자기 wrapper 몫의 오버헤드가 포함돼
있다. 호출 수가 많은 bucket(packing 6~9회, noise 6~7회)이 상대적으로 더 부풀려진다.
**절대 cycle 정본은 여전히 expAN 이다.**

## 3. 결과 — 두 run

두 run의 bucket 값 차이는 최대 13 cyc다. 아래는 run1이다.

### 3.1 keygen — ML-KEM 407,233 = Keccak 237,916 + 비-Keccak 169,317

| bucket | cyc/op | calls/op | 비-Keccak 중 | X-Wing 총합 중 |
|---|---:|---:|---:|---:|
| **matacc** | **89,223** | 3 | **52.70%** | **11.66%** |
| packing | 18,959 | 6 | 11.20% | 2.48% |
| NTT | 18,076 | 6 | 10.68% | 2.36% |
| noise(CBD) | 16,601 | 6 | 9.80% | 2.17% |
| invNTT | 11,882 | 3 | 7.02% | 1.55% |
| basemul | 0 | 0 | — | — |
| arith | 0 | 0 | — | — |
| verify/cmov | 0 | 0 | — | — |
| 미귀속 | 14,576 | — | 8.61% | 1.91% |

### 3.2 encaps — ML-KEM 415,391 = Keccak 254,478 + 비-Keccak 160,913

| bucket | cyc/op | calls/op | 비-Keccak 중 | X-Wing 총합 중 |
|---|---:|---:|---:|---:|
| **matacc** | **90,761** | 3 | **56.40%** | **7.97%** |
| noise(CBD) | 19,598 | 7 | 12.18% | 1.72% |
| invNTT | 15,795 | 4 | 9.82% | 1.39% |
| packing | 9,579 | 8 | 5.95% | 0.84% |
| NTT | 9,019 | 3 | 5.60% | 0.79% |
| arith | 5,550 | 5 | 3.45% | 0.49% |
| basemul | 3,562 | 3 | 2.21% | 0.31% |
| verify/cmov | 0 | 0 | — | — |
| 미귀속 | 7,049 | — | 4.38% | 0.62% |

### 3.3 decaps — ML-KEM 448,630 = Keccak 254,490 + 비-Keccak 194,140

| bucket | cyc/op | calls/op | 비-Keccak 중 | X-Wing 총합 중 |
|---|---:|---:|---:|---:|
| **matacc** | **90,737** | 3 | **46.74%** | **11.15%** |
| invNTT | 19,724 | 5 | 10.16% | 2.42% |
| noise(CBD) | 19,572 | 7 | 10.08% | 2.40% |
| NTT | 18,021 | 6 | 9.28% | 2.21% |
| basemul | 13,205 | 6 | 6.80% | 1.62% |
| packing | 10,527 | 9 | 5.42% | 1.29% |
| arith | 7,272 | 7 | 3.75% | 0.89% |
| verify/cmov | 262 | 1 | 0.13% | 0.03% |
| 미귀속 | 14,819 | — | 7.63% | 1.82% |

계측 coverage 는 **91.4% / 95.6% / 92.4%** 다. 미귀속 4.4~8.6%는 `polyvec.c` 루프,
`indcpa.c`/`kem.c` 글루, wrapper 밖 호출 오버헤드다. 별도 성능 주장으로 쓰지 않는다.

## 4. 판정에 직접 쓰이는 사실 3가지

### 4.1 matacc가 비-Keccak 잔여의 절반 이상이다

**세 연산 모두 matacc 가 압도적 1위**다 — 비-Keccak 중 46.7~56.4%, X-Wing 총합 중
8.0~11.7%. 세 연산 모두 3 calls/op 에 89~91 kcyc 로, 연산 종류와 거의 무관하게 같은 크기다.

다른 어떤 비-Keccak bucket 도 X-Wing 총합의 2.5% 를 넘지 못한다.

> **K14/K15 가 K 계열 중 가장 큰 단일 표적임이 실측으로 확정됐다.** §2.2대로 이 값에는
> matrix XOF 의 SHAKE 바이트 처리와 rejection sampling 판정이 포함돼 있다. 즉
> "matrix-XOF ↔ rejection ↔ matacc 경계 제거"가 겨냥하는 대상이 바로 이 89~91 kcyc 다.

### 4.2 NTT/invNTT는 이미 작다 — K01~K03의 여지가 제한적이다

X/Y(pqmx M85 NTT) 채택 뒤 NTT+invNTT 합은 X-Wing 총합의 **2.2~4.6%** 다
(keygen 29,958 / encaps 24,814 / decaps 37,745 cyc). primitive 47.44/49.98% 개선을
이미 먹은 뒤이므로, K01/K02 의 추가 재스케줄이 X-Wing 대표값에 줄 수 있는 상한이 작다.
장부가 K01/K02 를 "중"으로 둔 것은 실측과 부합한다.

### 4.3 verify/cmov는 0.03%다 — K30 종료 가능

decaps 의 verify/cmov 는 **262 cyc(1 call)**, X-Wing 의 0.03% 다. K30(verify/cmov·
secret-key load·zeroization 일괄 MVE/word 처리)은 최적화 후보로서 **종료**해도 된다.
상수시간·fault 요구사항 때문에 유지하는 것이지 성능 때문이 아니다.

## 5. X-Wing 전체 분해 — 미측정 블록 없음 (expAN+AO+AP 종합)

encaps 기준(AP 빌드 prof-off 1,138,459 cyc):

| 블록 | cycles | 비중 |
|---|---:|---:|
| X25519 (2회) | ~715,165 | **62.8%** |
| ML-KEM Keccak permutation | 254,478 | **22.4%** |
| ML-KEM matacc (비-permutation) | 90,761 | **8.0%** |
| ML-KEM noise(CBD) | 19,598 | 1.7% |
| ML-KEM invNTT | 15,795 | 1.4% |
| ML-KEM packing | 9,579 | 0.8% |
| ML-KEM NTT | 9,019 | 0.8% |
| X-Wing combiner | 8,051 | 0.7% |
| ML-KEM arith | 5,550 | 0.5% |
| ML-KEM basemul | 3,562 | 0.3% |
| ML-KEM 미귀속 글루 | 7,049 | 0.6% |
| wrapper glue | 28 | 0.00% |

**cycle의 85%가 두 블록에 있다: X25519 스칼라곱(62.8%)과 Keccak permutation(22.4%).**

## 6. 정확성 게이트 — 전부 PASS (두 run)

```
expAP equiv: bytes-mm=0 checks=40
expAP bench: stack-fails=0 stack-used=7872
harness_fails=0, KAT ALL PASS
```

| 게이트 | 결과 |
|---|---|
| probe on 출력 대 probe off 출력, 8 seed × (pk/sk/ct/ss_e/ss_d) | mismatch 0 |
| 기존 전체 하네스 KAT·mismatch (expX~expAO 포함) | 전부 0 |
| stack canary | 0, high-water 7,872 B |
| code-flash readback run1 = run2 | `F0B69D89…B73F` (721,356 B) |

rename 한 25개 함수의 동작이 바뀌지 않았다는 것은 위 8-seed full-output 일치와
기존 ML-KEM/X-Wing KAT 전부 통과로 확인된다.

## 7. 한계·미측정

1. **절대 cycle 정본은 expAN이다.** AP 빌드는 probe 때문에 연산당 4.3~7.2 kcyc 느리다.
   각 bucket 값에도 자기 wrapper 오버헤드가 섞여 있으며, 호출 수가 많은 bucket 이 더
   부풀려진다. bucket 간 상대 크기 비교에는 쓸 수 있지만 절감 목표치의 분모로 쓸 때는
   이 편향을 명시해야 한다.
2. **matacc bucket 안의 세분은 미측정이다.** SHAKE 바이트 처리 / rejection 판정 /
   MAC 누산이 각각 얼마인지는 아직 모른다. K14/K15 설계 전에 이 세분이 필요하다.
3. **미귀속 4.4~8.6%** 의 내부는 측정하지 않았다.
4. legacy wrapper workload 기준이며 draft-10 준거 이동 뒤 재측정 대상이다.
5. EK-RA8M1 한 개체다.

## 8. 다음 작업

1. **X06 fixed-base ladder** — X25519 62.8%가 여전히 압도적 1위다. 분모 715,663 cyc.
2. **K19/K20/K21 Keccak** — 2위 22.4%.
3. **K14/K15 matacc** — 3위 8.0~11.7%. K 계열 비-Keccak 중 유일하게 큰 표적.
   착수 전에 §7-2의 matacc 내부 세분(SHAKE 바이트 / rejection / MAC)이 필요하다.
4. **K30 verify/cmov 종료**, **K01~K03 우선도 유지(중)** — 둘 다 실측 근거 확보.

## 9. 아티팩트

동결: `artifacts/2026-08-25_expAP/` (+ `SHA256SUMS.txt`)

| 파일 | SHA-256 |
|---|---|
| `blinky.elf` | `F790D28CBB3C3B4346F2DB641C3E46E94B7A0C5057756CD930E0ED191A2B20B6` |
| `blinky.srec` | `D399E0DE44041F6F415A8856DDD86926E286811FF1618201A9E6E37864F03CB7` |
| `blinky.map` | `C9E3D72A8375D2691569B3D684761AB1870DE314CDE582BCCA26739651D47606` |
| `ap_probe.h` | `13E4A6F306B325E7E7443E340C899FA2A69E1FB75C50E666C865FD0449054160` |
| `expAP_slots.inc` | `744199426DB6EFA8EC1A0A52B4999E2D5616D38DE84317AEFB791652203361B8` |
| `poly.c` (계측본) | `BF50423FDFB2E2FFE7FF1511A7A9BE63AC0B4C0C09CA55B12FE32DB8D5E47A48` |
| `matacc.c` (계측본) | `24C282000766BDF9530F8686C5E75752196E29D81641B1DA6F701D45F242AB4A` |
| `verify.c` (계측본) | `1A93E74A4E9B37D3ED519C5285A9BADB3E6FE80B3946CF6E28B843EBC273C11D` |
| `harvest_ra8m1_expAP.py` | `658CF74F151F347E4419165DB40AF03B964D4C20FB7B59A4EF36FB8A617B24A4` |
| code-flash readback (run1=run2) | `F0B69D89005E9D3886767C5123B056763BD668C23BC85298A311E496C188B73F` (721,356 B) |
| `logs/2026-08-25_expAP_run1.txt` | `68E7461CDBE267E2EC35BB820674ACB5C4D588BFC67B214DBA756653F17BE492` |
| `logs/2026-08-25_expAP_run2.txt` | `4AE996269428FF484D795684EE36B956EDAFBAB6F63E1CBA91392A35203B0912` |

원본 백업: `poly.c.bak-20260825-expAP`, `matacc.c.bak-20260825-expAP`,
`verify.c.bak-20260825-expAP` (workspace `src/mlkem/`).
하네스 변경: `REP_SLOTS 390→420`, `#include "mlkem/ap_probe.h"`,
`#include "expAP_slots.inc"`, `expap_run_all()`.
