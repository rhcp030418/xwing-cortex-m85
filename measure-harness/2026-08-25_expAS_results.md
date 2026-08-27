# 실험 AS 결과 — X25519 ladder 나머지의 add/sub 귀속

> 측정 2026-08-25. 보드 EK-RA8M1, DWT CYCCNT, REP_N=100, 독립 flash/run 2회.
> 선행: `2026-08-25_expAR_results.md`. 원시 로그: `logs/2026-08-25_expAS_run{1,2}.txt`

---

## 1. 무엇을 닫았나

expAR이 X25519를 mul 41.4% / sqr 35.6% / **나머지 23.0%**로 쪼갰다. 그 나머지
(82~92 kcyc/scalarmult = X-Wing의 10~15%)는 matacc보다 큰데 내용이 미측정이었다.
가설: 대부분이 field add/sub다. 이 실험이 그 가설을 검증한다.

## 2. 방법

expAR과 같은 방식으로 `fe25519_add`/`fe25519_sub` 정의를 `apx_real_*`로 rename하고
원래 이름의 asm wrapper를 두었다.

```
fe25519_add/sub : in *r8=a, *r9=b ; out r0-r7 ; clobbers all other registers
```

**r8/r9가 입력**이므로 wrapper는 r10/r11/r12만 쓰고 r8/r9와 r0–r7을 건드리지 않는다.

제외한 것:

- `fe25519_sqr_many` — *"out: r0-r7 + **sets result also to top of stack**"* 계약이라
  wrapper의 push/pop이 caller의 스택 기대를 깬다. 감싸지 않는다.
- `loadm` — 22 cyc × 2회로 무시 가능.

## 3. 결과 — 두 run 동일

| | cyc/call | calls / scalarmult | 합 (scalarmult당) | 원본 주석의 M4 cycles |
|---|---:|---:|---:|---:|
| `fe25519_add` | **30.005** | **765** (= 255 × 3) | 22,954 | 45 |
| `fe25519_sub` | **36.002** | **1,020** (= 255 × 4) | 36,722 | 46 |
| 합 | | 1,785 | **59,676** | |

호출 수가 정확히 255×3과 255×4로 잡혔다 — 래더 구조와 정확히 일치하며 100 rep 전부
동일했다.

### 3.1 M4→M85에서 add/sub가 크게 빨라졌다

원본 asm 주석(Lenngren의 M4 기준)은 add 45 / sub 46 cycles다. M85 실측은
**30.0 / 36.0**이며, 측정 창에 `bl`/복귀와 `ldr` 2개(≈4 cyc)가 포함돼 있으므로 순수
본문은 약 **26 / 32**다.

| | M4 주석 | M85 실측(창) | 감소 |
|---|---:|---:|---:|
| add | 45 | 30.0 | **−33%** |
| sub | 46 | 36.0 | **−22%** |
| (참고) mul | 173 | 115.0 | −34% |
| (참고) sqr | 115 | 100.0 | −13% |

add와 mul이 M85 듀얼이슈 이득을 가장 많이 받았고 sqr이 가장 적게 받았다. AM1b가
mul/sqr에서 관찰한 비대칭(`sqr/mul` 비가 0.665 → 0.893)과 같은 방향의 현상이다.

## 4. ladder 나머지의 정체가 확정됐다

expAN의 깨끗한 분모와 expAR의 측정 단가를 써서:

| 연산 | X25519 (expAN) | mul | sqr | **add+sub** | **잔여** |
|---|---:|---:|---:|---:|---:|
| keygen | 357,839 | 148,011 | 127,408 | **59,676 (16.7%)** | **22,744 (6.4%)** |
| encaps (2회) | 715,148 | 296,023 | 254,815 | **119,347 (16.7%)** | **44,963 (6.3%)** |
| decaps | 357,478 | 148,011 | 127,408 | **59,676 (16.7%)** | **22,383 (6.3%)** |

**add+sub가 ladder 나머지의 72.4~72.7%다.** 가설이 확인됐다.

남은 잔여 22.4~45.0 kcyc(X25519의 6.3~6.4%)는 cswap, 255-bit 비트 루프,
`fe25519_sqr_many`의 루프 제어, `loadm`, 스칼라 clamp, 직렬화/역직렬화, inversion chain의
제어 흐름, 그리고 2,561회 `bl`/복귀 중 창에 안 잡힌 몫이다. **이 잔여의 내부 세분은
미측정**이지만 X-Wing 기준 2.0~4.0%라 우선순위가 낮다.

## 5. X-Wing 최종 분해 (expAN+AO+AP+AQ+AR+AS 종합)

encaps 1,134,754 cyc 기준:

| 블록 | cycles | 비중 | 누적 |
|---|---:|---:|---:|
| X25519 `fe25519_mul` | 296,023 | **26.1%** | 26.1% |
| X25519 `fe25519_sqr` | 254,815 | **22.5%** | 48.6% |
| ML-KEM Keccak permutation | 254,478 | **22.4%** | 71.0% |
| X25519 `fe25519_add`+`sub` | 119,347 | **10.5%** | 81.5% |
| ML-KEM matacc (비-permutation) | 90,761 | 8.0% | 89.5% |
| ML-KEM 그 외 | 62,376 | 5.5% | 95.0% |
| X25519 ladder 잔여 | 44,963 | 4.0% | 99.0% |
| X-Wing combiner | 8,051 | 0.7% | 99.7% |
| 미귀속 | ~3,940 | 0.3% | 100% |

**상위 4블록이 81.5%, 상위 5블록이 89.5%다.** X25519 field 연산(mul+sqr+add+sub)만으로
**59.1%**다.

## 6. 정확성 게이트 — 전부 PASS (두 run)

```
expAS equiv: bytes-mm=0 checks=40
expAS bench: stack-fails=0 stack-used=7848
harness_fails=0, KAT ALL PASS
```

| 게이트 | 결과 |
|---|---|
| probe on 출력 대 probe off 출력, 8 seed × (pk/sk/ct/ss_e/ss_d) | mismatch 0 |
| RFC 7748 X25519 KAT 4종 | PASS |
| 기존 전체 하네스 KAT·mismatch (expX~expAR 포함) | 전부 0 |
| stack canary | 0, high-water 7,848 B |
| code-flash readback run1 = run2 | `AFFD2797…E9C7` (727,448 B) |

wrapper가 입력 r8/r9와 출력 r0–r7을 보존한다는 것은 RFC 7748 KAT과 8-seed full-output
일치로 확인된다. 호출 수가 정확히 255의 배수로 잡힌 것도 계측이 올바른 지점에 걸렸다는
증거다.

## 7. 한계

1. **probe 비용이 매우 크다.** 이제 wrapper 호출이 scalarmult당 4,346회(mul 1,287 +
   sqr 1,274 + add 765 + sub 1,020)다. prof-off 총합조차 expAN보다 keygen +108,623 /
   encaps +213,510 / decaps +110,362 크고, prof-on은 거기서 다시 약 3배다.
   **이 빌드의 총합을 분모로 쓰지 않는다.**
2. §4의 표는 expAR과 같은 방식이다 — **측정된 호출 수 × 측정된 단가**를 expAN의 깨끗한
   분모에 적용한 것이며, 직접 누산이 아니라 **두 인자가 모두 in-context로 측정된 투영**이다.
3. 단가에서 `bl`/복귀와 `ldr` 2개(≈4 cyc)를 빼지 않은 값이다. 순수 본문은 add ≈26,
   sub ≈32로 추정되며 이 보정은 **근사**다(null wrapper 슬롯 미측정).
4. **잔여 6.3~6.4%의 내부 세분은 미측정**이다(cswap·비트 루프·직렬화·inversion 글루).
5. `fe25519_sqr_many`의 루프 제어 비용은 잔여에 포함돼 있고 따로 측정하지 않았다.
6. legacy wrapper workload 기준, EK-RA8M1 한 개체, 이 ITCM 배치 한정.

## 8. 판정에 주는 결론

1. **X06 fixed-base ladder가 여전히 1순위다.** 고정기저 전용 경로는 래더 반복 자체를
   줄이므로 mul·sqr·add·sub **네 항목을 동시에** 친다. 분모 715,663 cyc(keygen+encaps ctX).
2. **X03/X05가 예상보다 중요하다.** add+sub 1,785회/scalarmult = X-Wing encaps의 10.5%로
   **matacc(8.0%)보다 크다.** fused xDBLADD와 중간 store 지연(X05), 독립 field op 묶기(X03)가
   이 호출 수 자체를 줄이는 후보다.
3. **X01/X02는 여전히 최대 분모**(mul+sqr = 48.6%)지만, M85에서 mul은 이미 M4 대비 −34%,
   add는 −33%를 받은 반면 **sqr은 −13%뿐**이다. 재스케줄 여지가 가장 큰 것은 sqr일 수 있다.
4. **ladder 잔여 4.0%는 후순위**로 확정. cswap/비트 루프 최적화(X11)는 상한이 작다.

## 9. 아티팩트

동결: `artifacts/2026-08-25_expAS/` (+ `SHA256SUMS.txt`)

| 파일 | SHA-256 |
|---|---|
| `blinky.elf` | `7C0C70922E6DF4533FF2B16D8AB882268F3C337613061C58F66BA4B3B9A75677` |
| `blinky.srec` | `8440CEFA1206287C3C45874C16EDE8837E4C9046C8E8BA29CA7456D6D01DE409` |
| `blinky.map` | `C65245E560E1CE63A7A6BA2567B95E87B650C590D8569E8ADA8B1F71EC962AD9` |
| `expAS_slots.inc` | `D729744674F3BBA459D32D19BF01951155686231C37D8FD38D01A8E2ED6A5EA2` |
| `expAR_x25519_probe.S` (add/sub 추가본) | `A0AC73EA6875ECB56022C43719C2687EB8EEA3F4965DA0892CAEB7AF229E54F8` |
| `x25519-cortex-m4-gcc.s` (rename본) | `FE1EC88D94816C9360F86DF1665725A960C4DB639DA28C2A3841864A09874317` |
| `harvest_ra8m1_expAS.py` | `5C0BF4E565702D0702936F9997D6B54EEF0F5032D6879B2E0021CF78DFFC513E` |
| code-flash readback (run1=run2) | `AFFD2797ED0BC5597A6A9445C58D329171A46AA947D7565EF64D15B55D99E9C7` (727,448 B) |
| `logs/2026-08-25_expAS_run1.txt` | `E76E188211A6A9B31CE9609DBBEFC141E0D4F0E263D0AB3674FBD1CF8928044C` |
| `logs/2026-08-25_expAS_run2.txt` | `C741BC6C4C81623903120EE7250318A0DA572DB53C57D4FEDC9F2F25B01BB283` |

하네스 변경: `REP_SLOTS 447→459`, `#include "expAS_slots.inc"`, `expas_run_all()`.
원본 백업은 expAR과 공유(`x25519-cortex-m4-gcc.s.bak-20260825-expAR`).
