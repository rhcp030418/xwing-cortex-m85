# 실험 AN 결과 — X-Wing 최상위 cycle 귀속 (E0-top)

> 측정 2026-08-25. 보드 EK-RA8M1, DWT CYCCNT, REP_N=100, 독립 flash/run 2회.
> 대상: expAL cell-11(= X/Y/C8+C9 현행 채택 경로)의 legacy wrapper workload.
> 원시 로그: `logs/2026-08-25_expAN_run{1,2}.txt`

---

## 1. 무엇을 닫았나

`XWing_CortexM85_통합_variation.md` §10 E0은 "현재 경로를 다시 분해한다"를 요구하지만,
프로젝트에 **X-Wing wrapper 최상위 분해가 존재한 적이 없었다.** 기존 Z2(2026-08-21)는
ML-KEM 내부(matacc/basemul/frombytes/CBD/packing)만 쟀고, 그때의 분모도 ML-KEM 단독
437k/452k/503k였지 X-Wing 796k/1,184k/877k가 아니었다.

이 실험은 X-Wing의 세 연산 각각이 **ML-KEM / X25519 / combiner / glue** 로 어떻게
쪼개지는지를 실측한다. ML-KEM 내부 세분은 대상이 아니다(Z2 계보가 담당).

## 2. 방법

`dwt_span_begin()`이 `perf_start()`를 통해 `DWT->CYCCNT`를 0으로 리셋하므로 span 중첩은
불가능하다. 따라서 **연산당 span 1회 + 중간 체크포인트 판독** 방식을 썼다(실험 AI와 동일).

```c
#define EXPAN_CKPT(v) do { __DSB(); __ISB(); (v) = DWT->CYCCNT; } while (0)
```

부분 구간은 회수기에서 인접 체크포인트 차분으로 계산한다.

### 2.1 계측 오버헤드 — 추정하지 않고 직접 측정

AM1b §2의 교훈(오버헤드 미차감으로 비중이 117.9%가 나왔던 건)을 따라 기준선 슬롯을
두 개 신설했다. 두 run 동일:

| 기준선 | 실측 |
|---|---:|
| 빈 span (`dwt_span_begin`/`end`만) | **26 cyc** |
| 체크포인트 4개만 있는 빈 span | **78 cyc** |
| → 체크포인트 1개당 | **13.00 cyc** |

연산당 체크포인트 오버헤드는 keygen 26 / encaps 52 / decaps 39 cyc로, 총 cycle의
**0.005% 미만**이다. 아래 표에서 차감하지 않고 해당 구간에 포함된 채로 보고한다.

### 2.2 계측이 옳다는 증거 — expAL 교차검증

RNG 시드(`0xa1ab5a5au`)와 루프 순서(keygen×100 → encaps×100 → decaps×100)를 expAL
bench와 정확히 일치시켰다. 따라서 계측본 total은 expAL cell-11과 같아야 한다.

| 연산 | expAN run1 | expAN run2 | expAL cell-11 | 차이 |
|---|---:|---:|---:|---:|
| keygen | 761,943 | 761,953 | 761,811~761,847 | **+132 / +142** |
| encaps | 1,134,754 | 1,134,738 | 1,134,806~1,134,825 | **−52 / −68** |
| decaps | 809,971 | 809,971 | 809,797~809,817 | **+174 / +174** |

전부 0.03% 이내다. 체크포인트 오버헤드(26~52 cyc)와 같은 자릿수이므로 **계측 자체가
검증됐다**. 계측본이 원본 wrapper와 다른 코드였다면 이 일치는 나오지 않는다.

## 3. 결과 — 두 run

값은 REP_N=100의 중앙값이다. `run1 / run2`로 병기한다.

### 3.1 keygen (total 761,943 / 761,953)

| 구간 | run1 | run2 | 비중 |
|---|---:|---:|---:|
| ML-KEM-768 keygen | 404,072 | 404,077 | **53.03%** |
| X25519 fixed-base (basepoint 9) | 357,839 | 357,844 | **46.96%** |
| glue (rng/clamp/copy) | 32 | 32 | 0.004% |

### 3.2 encaps (total 1,134,754 / 1,134,738)

| 구간 | run1 | run2 | 비중 |
|---|---:|---:|---:|
| ML-KEM-768 encaps | 411,543 | 411,531 | **36.27%** |
| X25519 fixed-base → ctX | 357,824 | 357,818 | **31.53%** |
| X25519 variable-base → ssX | 357,324 | 357,324 | **31.49%** |
| X-Wing combiner (SHA3-256, 134B) | 8,035 | 8,039 | 0.71% |
| glue (rng/clamp) | 28 | 26 | 0.002% |

**X25519 두 번 합계 = 715,148 cyc = encaps의 63.02%.**

### 3.3 decaps (total 809,971 / 809,971)

| 구간 | run1 | run2 | 비중 |
|---|---:|---:|---:|
| ML-KEM-768 decaps | 444,443 | 444,435 | **54.87%** |
| X25519 variable-base → ssX | 357,478 | 357,483 | **44.13%** |
| X-Wing combiner (SHA3-256, 134B) | 8,025 | 8,028 | 0.99% |
| glue | 25 | 25 | 0.003% |

두 run의 버킷별 차이는 최대 10 cyc다.

## 4. 판정에 직접 쓰이는 사실 4가지

### 4.1 X25519가 지배적이다 — 47.0% / 63.0% / 44.1%

X-Wing 전체에서 X25519가 차지하는 비중은 keygen 46.96%, encaps **63.02%**,
decaps 44.13%다. 통합 장부 §9의 우선 후보 10개 중 7개가 ML-KEM 계열(K)인 것과
방향이 어긋난다. **cycle이 가장 많이 있는 곳은 X25519다.**

### 4.2 fixed-base가 전혀 특수화돼 있지 않다 — 측정으로 확인

현행 코드는 basepoint 9 곱셈과 임의점 곱셈에 **같은 `curve25519_scalarmult`를 쓴다.**
실측이 이를 확인한다:

| 호출 | 종류 | cycles |
|---|---|---:|
| keygen `pkX` | fixed-base | 357,839 |
| encaps `ctX` | fixed-base | 357,824 |
| encaps `ssX` | variable-base | 357,324 |
| decaps `ssX` | variable-base | 357,478 |

fixed-base와 variable-base의 차이가 **약 400 cyc(0.1%)뿐**이다. 즉 basepoint 전용
경로가 없다. keygen+encaps 한 쌍에서 fixed-base 호출은 2회 = **715,663 cyc**이며,
이는 keygen의 47.0% + encaps의 31.5%에 해당한다.

이것이 장부 **X06**(basepoint 9 전용 precomputed ladder)의 실측 근거다. X06의 적용
가능 분모가 이 값이며, 절감률 자체는 여전히 **미측정**이다.

### 4.3 combiner는 0.71~0.99%다 — W11/W12의 상한이 확정됐다

combiner 한 번이 **8,035 / 8,025 cyc**다. 같은 ELF에서 `keccak-f1600` 단독은
**5,504 cyc**이고, 하네스 카운터가 `combiner 1` permutation을 보고한다(134B가 SHA3-256
rate 136B 한 블록에 들어간다는 것의 실측 확인).

```
combiner 8,035 − permutation 5,504 = 2,531 cyc   ← API·copy·padding glue
```

W11/W12는 **알고리즘 입력을 바꾸지 않고 glue만 제거**하는 후보이므로, 그 이론적 상한이
2,531 cyc다. 이는 encaps의 **0.223%**, decaps의 **0.312%**다.

> **장부 정정 필요**: `XWing_CortexM85_통합_variation.md` §7이 W11·W12를 **최상** 우선도로
> 두고 §9가 8번 후보로 올렸지만, 실측 상한은 0.22~0.31%다. 우선도를 낮춰야 한다.
> 작고 안전한 첫 실험(E1)으로서의 가치는 남지만 절감 후보로서는 아니다.

### 4.4 glue는 25~32 cyc다 — 최상위에는 회수할 메모리/복사 비용이 없다

wrapper의 rng/clamp/memcpy 잔여는 세 연산 모두 **25~32 cyc**다. W16(scratch arena 재사용)
같은 후보는 최상위 wrapper 층에서는 회수할 것이 없고, 존재한다면 ML-KEM/X25519 **내부**에
있다. 최상위 층에 대해서는 이 후보를 종료할 수 있다.

## 5. 파생 투영 (실측 아님)

하네스가 보고하는 permutation 수는 실측이고, `keccak-f1600` 5,504 cyc도 실측이지만,
둘의 **곱은 투영**이다. 실제 in-context 비용은 cache/ITCM 상태에 따라 다르다.

| 연산 | ML-KEM 실측 | perms | Keccak 투영 | ML-KEM 중 비중 | 비-Keccak 잔여 |
|---|---:|---:|---:|---:|---:|
| keygen | 404,072 | 43 | 236,672 | 58.6% | 167,400 |
| encaps | 411,543 | 44 | 242,176 | 58.8% | 169,367 |
| decaps | 444,435 | 44 | 242,176 | 54.5% | 202,259 |

이 투영이 맞다면 ML-KEM 내부의 최대 단일 항목은 Keccak이며, 이는 K19/K20/K21/K24의
분모다. **확정하려면 Z2 계보의 profiler build를 현행 경로에서 다시 돌려야 한다(미측정).**

## 6. 정확성 게이트 — 전부 PASS (두 run)

```
expAN equiv: bytes-mm=0 smoke-fails=0 checks=48
expAN bench: stack-fails=0 stack-used=7864
harness_fails=0, KAT ALL PASS
```

| 게이트 | 결과 |
|---|---|
| 계측본 대 원본 wrapper, 8 seed × (pk/sk/ct/ss_e/ss_d) | mismatch 0 |
| 계측본 암묵적 거부 경로(ct 변조) 대 원본 8 seed | mismatch 0 |
| `ss_e == ss_d` smoke, 원본·계측본 각 8 seed | fails 0 |
| 기존 전체 하네스 KAT·mismatch (X25519/SHA3/ML-KEM/expX~expAMb) | 전부 0 |
| stack canary | 0, high-water 7,864 B |
| code-flash readback run1 = run2 | `F87ED1D4…C641` (715,812 B) |

## 7. 한계·미측정

1. **legacy wrapper workload 기준이다.** 이 분해는 combiner 순서가 `label` 선두이고
   ML-KEM encapsulation-key check가 없으며 decaps가 expanded-key warm인 현행 wrapper의
   것이다. draft-10 준거로 옮기면 combiner 비중(0.7~1.0%)과 절대 cycle이 바뀐다.
   다만 X25519·ML-KEM 대분류 비중은 정의 이동으로 크게 바뀔 이유가 없다.
2. **ML-KEM 내부 세분은 이 실험 범위가 아니다.** §5는 투영이다.
3. **X06의 절감률은 여전히 미측정이다.** 이 실험은 분모만 확정했다.
4. keygen `c1`의 run 내 산포가 다른 슬롯보다 크다(min 402,952 ~ max 417,489).
   공개 seed 기반 rejection sampling 변동으로 보이며 중앙값 판정에는 영향이 없다.
   비밀 의존 동작이 아니다.
5. EK-RA8M1 한 개체, 한 배치 상태의 값이다. 다른 Cortex-M85로 일반화하지 않는다.

## 8. 다음 작업

1. **X06 fixed-base ladder** — 분모 715,663 cyc(keygen 47.0% + encaps 31.5%)가 확정됐다.
   장부 E8이 이 후보이며, 지금 가장 큰 단일 표적이다.
2. **X01~X05 scalar 재스케줄** — 나머지 X25519 분모 715k(encaps ssX + decaps ssX)에 적용.
   AM1/AM1b가 MVE 경로를 닫았으므로 scalar 재스케줄이 남은 경로다.
3. **W11/W12 우선도 하향** — 상한 2,531 cyc(0.22~0.31%)로 확정.
4. **ML-KEM 내부 재귀속** — Z2 profiler를 현행 X/Y/C8+C9 경로에서 재실행해 §5 투영을
   실측으로 대체.

## 9. 아티팩트

동결: `artifacts/2026-08-25_expAN/` (+ `SHA256SUMS.txt`)

| 파일 | SHA-256 |
|---|---|
| `blinky.elf` | `26602EA31C8D16BD9092D1C34F7679C83BAA184766A6CCAFD1574F8D3E9CCB7F` |
| `blinky.srec` | `727602683919914BC03E9AFEEC539B47CF1035DA466071A382AC5D762B11E8EF` |
| `blinky.map` | `FBC1BEDED3D2B23C00574F9C83FB87FB634E154F5952568BA57D5E90068C8153` |
| `expAN_slots.inc` | `747EF4B7CDC626791C782CE971C20712630BA98DDF2F255A566B0E5CD6F4F89F` |
| `harvest_ra8m1_expAN.py` | `88A2E8ECBA740CD8CE25C4E5CAF5C704A2A994E51A699E5829C7ADDDA0A16F82` |
| code-flash readback (run1=run2) | `F87ED1D4341CD85D598D28158A74F3A8BD1F48DE0D825A984336E8456B59C641` (715,812 B) |
| `logs/2026-08-25_expAN_run1.txt` | `9F7BCFE166DEE8E71A931CE13FB0195652F14632AEF35B19ECC54ED170022493` |
| `logs/2026-08-25_expAN_run2.txt` | `0DC9CB8B4EB5E8E25E4B15A3FF3E7287B90FC2D1AF25529F984BC2CFBE5E994A` |

하네스 변경: `harness.c`에 `REP_SLOTS 362→376`, `#include "expAN_slots.inc"`,
`expan_run_all()` 호출 3줄. 백업 `harness.c.bak-20260825-expAN`.
