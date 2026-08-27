# 실험 AR 결과 — X25519 field-op in-context 귀속

> 측정 2026-08-25. 보드 EK-RA8M1, DWT CYCCNT, REP_N=100, 독립 flash/run 2회.
> 선행: `2026-08-25_expAM1b_results.md`, `2026-08-25_expAN_results.md`.
> 원시 로그: `logs/2026-08-25_expAR_run{1,2}.txt`

---

## 1. 무엇을 닫았나

expAN이 X25519가 X-Wing의 **62.8%(encaps)**임을 실측했지만, 그 **내부** mul/sqr 비중
76.0%는 expAM1b의 **투영**이었다.

```
mul 1,287회(소스에서 손으로 셈) × 112.11 cyc(별도 벤치 루프) = 40.4%
sqr 1,274회(소스에서 손으로 셈) × 100.12 cyc(별도 벤치 루프) = 35.7%
```

두 인자 모두 X-Wing 실행 문맥 밖에서 얻은 값이고 그 곱은 실측이 아니다. expAO가 Keccak
투영에 대해 한 검증을 X25519는 못 받은 상태였다. 이 실험이 **두 인자를 모두 in-context로
직접 측정**한다.

## 2. 방법

`x25519-cortex-m4-gcc.s`의 `fe25519_mul` / `fe25519_sqr` **정의만** `apx_real_*`로 rename
하고, 원래 이름을 갖는 asm wrapper를 `gen/expAR_x25519_probe.S`에 두었다. 래더의 모든
`bl`과 `fe25519_sqr_many`의 내부 루프가 wrapper를 탄다. 호출 지점은 수정하지 않았다.

ABI가 완전 커스텀이라 wrapper 설계가 제약된다(원본 주석):

```
fe25519_mul : in *r1=a, *r2=b ; out r0-r7 ; clobbers all other registers
fe25519_sqr : in r0-r7        ; out r0-r7 ; clobbers all other registers
```

따라서 wrapper는 **r10/r11/r12만** scratch로 쓰고 r0–r7은 절대 건드리지 않는다.
`push {r12, lr}`로 8-byte 정렬을 유지하고, mul/sqr이 서로 중첩 호출하지 않으므로
시작 타임스탬프는 static 한 칸으로 충분하다. wrapper도 래더와 같은
`.itcm_code_from_flash` 섹션에 둬서 배치 차이를 줄였다.

`expAM_micro.S`의 AAPCS shim 두 개는 `apx_real_*`로 직결시켜 **expAM 슬롯이 흔들리지 않게**
했다.

## 3. 결과 ① — 정적 호출 수가 정확히 맞았다

| | expAM1b (소스 수동 계수) | expAR (in-context 실측) | 일치 |
|---|---:|---:|---|
| `fe25519_mul` / scalarmult | 1,287 | **1,287.0** | ✅ 정확 |
| `fe25519_sqr` / scalarmult | 1,274 | **1,274.0** | ✅ 정확 |

encaps는 X25519를 2회 부르므로 2,574 / 2,548로 잡혔고, 100 rep 전부에서 소수점 없이
같은 값이었다. **호출 수는 더 이상 손으로 센 값이 아니다.**

## 4. 결과 ② — in-context 호출당 단가

두 run에서 소수 셋째 자리까지 같았다.

| | expAR 측정 창 | expAM1b 순수 본문 | expAM1b 주석의 보정 |
|---|---:|---:|---|
| `fe25519_mul` | **115.005 cyc** | 112.11 | *"래더의 실제 호출 비용은 여기에 3~4 cyc 더"* → 115~116 |
| `fe25519_sqr` | **100.006 cyc** | 100.12 | 동상 |

**mul의 115.005는 expAM1b가 스스로 남긴 보정 범위(115~116)에 정확히 들어간다.**

측정 창은 `[첫 CYCCNT 판독 완료 … bl … 함수 … 복귀 … 둘째 CYCCNT 판독 완료]`이므로
`bl`/복귀 한 쌍과 둘째 판독의 `ldr` 2개(≈4 cyc)가 포함돼 있다. 즉 순수 본문은 이보다
약 4 cyc 작다.

## 5. 결과 ③ — mul+sqr 비중은 74~77%다

측정된 호출 수 × 측정된 단가를 **expAN의 깨끗한 X25519 분모**에 적용한다(§7-1 참조).

| 단가 가정 | keygen | encaps | decaps |
|---|---:|---:|---:|
| 측정 창 그대로 (115.005 / 100.006) | **77.0%** | **77.0%** | **77.0%** |
| 창의 `ldr` 2개 ≈4 cyc 차감 (111 / 96) | **74.1%** | **74.2%** | **74.2%** |

**expAM1b의 투영 76.0%는 이 74~77% 구간 안에 있다. 투영이 확인됐다.**

### 5.1 X25519 내부 최종 분해 (측정 창 기준, expAN 분모)

| 구간 | keygen | encaps (2회) | decaps |
|---|---:|---:|---:|
| `fe25519_mul` (1,287회/회) | 148,011 (41.4%) | 296,023 (41.4%) | 148,011 (41.4%) |
| `fe25519_sqr` (1,274회/회) | 127,408 (35.6%) | 254,815 (35.6%) | 127,408 (35.6%) |
| **나머지** (ladder glue) | **82,420 (23.0%)** | **164,310 (23.0%)** | **82,059 (23.0%)** |
| X25519 합 (expAN) | 357,839 | 715,148 | 357,478 |

**나머지 23.0%(보수 가정 25.8%)의 정체**: `fe25519_add`/`sub`, `loadm`, cswap,
255-bit 비트 루프, inversion chain의 제어 흐름, 스칼라 clamp, 직렬화/역직렬화, 그리고
2,561회의 `bl`/복귀 오버헤드.

이 값은 X-Wing 기준으로 **keygen 10.8% / encaps 14.5% / decaps 10.1%**다.
**matacc(8.0~11.7%)보다 크다.** X01/X03/X04/X05/X11이 노리는 대상이 바로 이 구간이다.

## 6. 정확성 게이트 — 전부 PASS (두 run)

```
expAR equiv: bytes-mm=0 checks=40
expAR bench: stack-fails=0 stack-used=7848
harness_fails=0, KAT ALL PASS
```

| 게이트 | 결과 |
|---|---|
| probe on 출력 대 probe off 출력, 8 seed × (pk/sk/ct/ss_e/ss_d) | mismatch 0 |
| RFC 7748 X25519 KAT 4종 | PASS |
| 기존 전체 하네스 KAT·mismatch (expX~expAQ 포함) | 전부 0 |
| stack canary | 0, high-water 7,848 B |
| code-flash readback run1 = run2 | `269A64E7…EA80` (725,428 B) |

커스텀 ABI wrapper가 r0–r7을 보존한다는 것은 RFC 7748 KAT 통과와 8-seed full-output
일치로 확인된다. 호출 수가 정확히 1,287/1,274로 잡힌 것은 `fe25519_sqr_many`의 내부
루프까지 wrapper를 탄다는 직접 증거다.

## 7. 한계 — 이 실험의 probe 비용은 크다

### 7.1 왜 비중을 직접 누산으로 주장하지 않는가

| 연산 | expAN (깨끗) | expAR prof-off | expAR prof-on |
|---|---:|---:|---:|
| keygen | 761,943 | 827,465 (**+65,522**) | 994,815 (**+167,350** 추가) |
| encaps | 1,134,754 | 1,261,095 (**+126,341**) | 1,596,258 (**+335,163** 추가) |
| decaps | 809,971 | 876,297 (**+66,326**) | 1,044,080 (**+167,783** 추가) |

호출이 2,561회(encaps 5,122회)로 워낙 많아 wrapper 자체가 크다 — 비활성 경로도
약 25 cyc/call, 활성 경로는 추가로 약 65 cyc/call이다. **따라서 이 빌드의 X25519 전체
구간(418,467 cyc)은 비중 계산의 분모로 쓸 수 없다.**

대신 이 실험이 제공하는 것은 **분자의 두 인자**다.

- 호출 수: 창 밖 오버헤드와 무관하게 정확 (§3)
- 호출당 단가: 창이 `bl`~복귀만 감싸므로 wrapper의 enable 검사·누산 코드는 창 밖 (§4)

이 둘을 expAN의 깨끗한 분모에 적용한 것이 §5다. **직접 누산이 아니라 두 인자가 모두
in-context로 측정된 투영**이며, expAM1b(둘 다 문맥 밖)보다 한 단계 강하다. 이 구분을
지운 채 "실측 비중"이라고 쓰지 않는다.

### 7.2 그 밖의 미측정

1. **나머지 23%의 내부 세분은 미측정이다.** add/sub, cswap, 비트 루프, inversion,
   직렬화가 각각 얼마인지 모른다. X01/X04 설계 전에 필요하다.
2. 단가에서 뺀 `ldr` 2개 ≈4 cyc는 **근사**다. null wrapper 슬롯으로 정밀화 가능(미측정).
3. legacy wrapper workload 기준, EK-RA8M1 한 개체, 이 ITCM 배치 한정.

## 8. X-Wing 최종 분해 (expAN+AO+AP+AQ+AR 종합, encaps 1,134,754 cyc)

| 블록 | cycles | 비중 |
|---|---:|---:|
| X25519 `fe25519_mul` | 296,023 | **26.1%** |
| X25519 `fe25519_sqr` | 254,815 | **22.5%** |
| ML-KEM Keccak permutation | 254,478 | **22.4%** |
| X25519 ladder 나머지 | 164,310 | **14.5%** |
| ML-KEM matacc (비-permutation) | 90,761 | 8.0% |
| ML-KEM 그 외 (noise/NTT/packing/basemul/arith/글루) | 62,376 | 5.5% |
| X-Wing combiner | 8,051 | 0.7% |
| wrapper glue | 28 | 0.00% |

**X25519가 63.0%, 그중 mul+sqr이 48.6%p, ladder 나머지가 14.5%p다.**

## 9. 다음 작업

1. **X06 fixed-base ladder** — 여전히 최대 표적. 분모 715,663 cyc(keygen + encaps ctX).
   고정기저 전용 경로는 mul/sqr 호출 수 자체를 줄이므로 §5의 41.4%+35.6% 양쪽을 친다.
2. **X01/X02 mul/sqr 재스케줄** — 분모 확정: mul 115.0 cyc × 1,287회, sqr 100.0 × 1,274회.
   AM1b가 MVE 경로를 닫았으므로 scalar 재스케줄만 남았다.
3. **X04/X05/X11 ladder glue** — 분모 82~92 kcyc/scalarmult(X-Wing의 10~16%).
   **matacc보다 큰데 장부에서는 K14/K15보다 낮게 잡혀 있었다.** 착수 전 §7.2-1의
   내부 세분이 필요하다.
4. K19/K20/K21 Keccak — 22.4%.

## 10. 아티팩트

동결: `artifacts/2026-08-25_expAR/` (+ `SHA256SUMS.txt`)

| 파일 | SHA-256 |
|---|---|
| `blinky.elf` | `E6CF45C3A7B4B0E1E6394DFD7FDD2674BD16736CB1A2E9242464FD17F44CD36B` |
| `blinky.srec` | `6432D83412E1A664AAF0C264631371CD9305904B292BA894B175E85F2AB0D550` |
| `blinky.map` | `6C54B8834DA39B0DC9A13234EB3212D3BA58E5BEE3E3B30668CB1879DA2C4D38` |
| `expAR_slots.inc` | `91D9FB619205178CAA1098A9EEF526B5D1DE73795A79B2FA38A60D5F2B61BA0C` |
| `expAR_x25519_probe.S` | `A52F96278874F145D2737A2DDBAB37D4A0354FCEC1A8BB74AD7D8E28ED6EF5A5` |
| `x25519-cortex-m4-gcc.s` (rename본) | `0792FC9DDACAAB2711AA063C82A7C9E3B9FD247F953C654114F08BB82922FC48` |
| `harvest_ra8m1_expAR.py` | `13F7A7686A015EE203FCFF2C415A28DEF11989DF2D65FBCC98D5792052C9AA0A` |
| code-flash readback (run1=run2) | `269A64E745A14432B2D70B3987498C2F3310A4E37F1093421A0BB5F9406DEA80` (725,428 B) |
| `logs/2026-08-25_expAR_run1.txt` | `2256DCC12A00CACA00C6C2E87210CBA157A7C3B7F2697C5F32AEEB23D6DCC669` |
| `logs/2026-08-25_expAR_run2.txt` | `A14BB086C43532DBB50C2FF5CEDF8B691CDFE0A9242DA6DEE77B109F10034F5E` |

원본 백업: `x25519/x25519-cortex-m4-gcc.s.bak-20260825-expAR`,
`gen/expAM_micro.S.bak-20260825-expAR`.
빌드 변경: `Debug/src/gen/subdir.mk`에 `expAR_x25519_probe.S` 등록.
하네스 변경: `REP_SLOTS 435→447`, `#include "expAR_slots.inc"`, `expar_run_all()`.
