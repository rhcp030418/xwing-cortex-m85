# 실험 AW (AT-3) 결과 — X06 을 넣은 full X-Wing: **gate PASS, 채택 가능**

> 측정 2026-08-26. 보드 EK-RA8M1, DWT CYCCNT, REP_N=100, 같은 ELF ABBA, 독립 flash/run 2회.
> 사전등록: `2026-08-25_expAT_x06_fixedbase_prereg.md` §8.1 AT-3,
> `2026-08-26_expAV_x06_native_prereg.md` §9. 선행: AV gate PASS(+26.80%).

---

## 1. 판정

| 게이트 | 결과 |
|---|---|
| 정확성 (8-seed full-output + 암묵적 거부) | **PASS**, mismatch 0 |
| keygen·encaps 회귀 없음 | **PASS** |
| decaps ±0.3% 이내 (적용 지점 없음) | **PASS** (실측 ±0.001%) |
| **종합** | **PASS — 채택 가능** |

## 2. 결과 — 두 run

같은 ELF에서 `mlkem_x06_mode` 토글로 A/B, ABBA 4셀.

| 연산 | A 현행 ladder | B X06 comb | 절감 (AB) | 절감 (BA) | **conservative** |
|---|---:|---:|---:|---:|---:|
| keygen | 762,147 / 762,162 | 667,137 / 667,144 | +12.47% / +12.46% | +12.47% / +12.47% | **+12.46%** |
| encaps | 1,134,986 / 1,134,998 | 1,039,918 / 1,039,920 | +8.38% | +8.38% | **+8.38%** |
| decaps | 809,785 / 809,777 | 809,782 / 809,780 | +0.00% | ±0.00% | **±0.00%** |

**decaps가 정확히 0%인 것이 이 실험의 통제다.** X06은 fixed-base 두 지점(keygen `pkX`,
encaps `ctX`)에만 적용되고 decaps에는 적용 지점이 없으므로, 여기서 유의미한 변화가
나왔다면 코드 배치 교란을 의심해야 했다. 실측 ±0.001%로 교란이 없다.

절감 절대량은 keygen 95,010 cyc, encaps 95,068 cyc로 AV의 단독 측정
(357,445 → 261,647 = 95,798)과 **1% 이내로 일치**한다. wrapper 통합에서 새로 생긴
비용이 없다는 뜻이다.

## 3. 정확성

```
expAW equiv: bytes-mm=0 smoke-fails=0 reject-mm=0 checks=48
harness_fails=0, KAT ALL PASS
```

8개 seed 각각에서 A(현행)와 B(X06)의 다음이 **바이트 단위로 동일**했다.

- `pk` (ML-KEM ek || pkX), `sk`, `ct` (ctM || ctX)
- 정상 shared secret `ss_e`, `ss_d`
- **ct 변조 시의 암묵적 거부 출력**

즉 X06 교체는 X-Wing의 출력 함수를 전혀 바꾸지 않는다.

## 4. 적용 범위 — 바꾼 것은 두 줄뿐

```c
volatile uint32_t mlkem_x06_mode;   /* 0 = 현행 ladder, 1 = comb */

/* xwing_keypair: pkX */
if (mlkem_x06_mode) curve25519_scalarmult_base(pk + CRYPTO_PUBLICKEYBYTES,
                                               sk + CRYPTO_SECRETKEYBYTES);
else                curve25519_scalarmult(pk + CRYPTO_PUBLICKEYBYTES,
                                          sk + CRYPTO_SECRETKEYBYTES, basepoint);

/* xwing_enc: ctX */
if (mlkem_x06_mode) curve25519_scalarmult_base(ct + CRYPTO_CIPHERTEXTBYTES, ephemeral);
else                curve25519_scalarmult(ct + CRYPTO_CIPHERTEXTBYTES, ephemeral, basepoint);
```

variable-base 두 곳(encaps `ssX`, decaps `ssX`)은 **손대지 않았다.**

## 5. 누적 위치 — 정본으로 쓰려면 재측정이 필요하다

현행 대표값은 expAL의 X/Y/C8+C9 대 00 **4.29 / 4.16 / 7.71%** 다. X06은 그 위에 얹힌다.

| 기준 | keygen | encaps | decaps |
|---|---:|---:|---:|
| expAL cell-00 (baseline) | 796,007 | 1,184,040 | 877,484 |
| expAL cell-11 (현행 채택) | 761,811 | 1,134,806 | 809,797 |
| **+ X06 (이번 실측)** | **667,137** | **1,039,918** | **809,782** |
| 00 대비 누적 | **−16.19%** | **−12.17%** | **−7.72%** |

> **주의**: 마지막 줄은 서로 다른 ELF의 값을 이어 붙인 **파생 수치**다. expAL cell-00은
> 2026-08-24 빌드의 값이고 X06 값은 2026-08-26 빌드의 값이다. 이번 실험의 A 셀
> (762,147 / 1,134,986 / 809,785)이 expAL cell-11과 0.02% 이내로 맞으므로 사슬은
> 일관되지만, **누적 대표값을 정본으로 쓰려면 같은 ELF에서 00 대 X06 완전요인을
> 다시 돌려야 한다.** 그 전까지 −16.19/−12.17/−7.72%는 파생 수치로만 표기한다.

## 6. 자원

| | 값 |
|---|---:|
| `.text` (X06 없는 복원 빌드) | 711,932 B |
| `.text` (X06 포함, 이 빌드) | 750,428 B |
| 증가 | **+38,496 B** (표 33,024 + 코드·계측 5,472) |
| FLASH 여유 (2,064,384 총) | 약 1.31 MB |
| ITCM | 표는 flash 상주 — ITCM 예산 미사용 |
| stack high-water | 7,864 B (기존 하네스 최대치와 동일) |

## 7. 미측정·한계

1. **누적 대표값은 §5대로 재측정 대상**이다.
2. AV §7의 잔여 개선 여지(select에 붙은 +33,200 cyc, inversion의 래퍼 경유 ~9 kcyc)는
   그대로 남아 있다. X06을 더 밀면 keygen/encaps 절감이 더 커질 수 있다.
3. 상수시간은 AV §5대로 **분포 겹침**까지만 확인했다(형식 증명 아님).
4. 표 33,024 B는 코드 크기 예산이 빠듯한 목표에서는 채택을 막을 수 있다. 이 보드는
   flash 여유가 1.31 MB라 무관하다.
5. legacy wrapper workload 기준이다 — draft-10 준거 이동(§4.1.1) 뒤 재측정 대상.
6. EK-RA8M1 한 개체, 이 배치 한정.

## 8. 아티팩트

동결: `artifacts/2026-08-26_expAW/` (+ `SHA256SUMS.txt`)

| 파일 | SHA-256 |
|---|---|
| `blinky.elf` | `A7EB30929BB486311806D73E879EDD1E07EB2EF7B514CFB9B23FA108DB9B62D1` |
| `blinky.srec` | `85F6F010EE17180C6A96925E491A2A85F20F1F3C3422D6972BA82E327E093BDE` |
| `blinky.map` | `28BA371AA83C09C4FBD89E2DA653F8C11C9B69F6A33E40B3567EC8FB71C1F531` |
| `expAW_slots.inc` | `38F62CBCE4CC118E22B6A0F5747C836AF870229FC39A21992C6DBF03ED229D58` |
| `x25519_base.c` | `96CC8CF3C671B8C41C1B86EB414ADB211C8AB8C22BA22D6F0F2F714A9F151FD2` |
| `x25519_comb_asm.S` | `46B6902D7B8AC28EE424BE3704B4AB058E865C004C2871313C9957F45790A27F` |
| `x25519_base_shim.S` | `6AA9A53D7ECDFF6386BB36BF8307D9BF48E88A2F35256B699B27452E835ECA1B` |
| `harvest_ra8m1_expAW.py` | `E29FD5DE86ACFA2810C779AE045FE62A0383D2140FBD46411958ADC94919B1D6` |
| code-flash readback (run1=run2) | `E0CB33D47AC99C7D9B6D5B6019FFC96AA1E2D459946093848E848191242E4ACA` (757,908 B) |
| `logs/2026-08-26_expAW_run1.txt` | `61A652A25FBDE14EA57C99D8F224F7AE9729BEAEB29D2ECC990C0820959562E2` |
| `logs/2026-08-26_expAW_run2.txt` | `55A207C2A51AC8220350973CCC9A536F5C55F6397EBE07C5ED90C977D0453C31` |

표·생성기: `expAT-src/at1_comb.py`, `expAT-src/x25519_base_table.h` (AT-1 동결).

## 9. X06 트랙 요약

| 단계 | 내용 | 판정 |
|---|---|---|
| AT-0 | constant-time 표 조회 단가 실측, w 결정 | PASS (w=3) |
| AT-1 | 표 생성 + RFC 7748 KAT + 1,000 seed 차분 | PASS |
| AT-2 | 첫 보드 구현 (C + AAPCS 래퍼) | **FAIL** (+13.30% < 25%) |
| AV | native ABI madd + chunked select 재설계 | PASS (+26.80%) |
| **AW (AT-3)** | **full X-Wing 통합 A/B** | **PASS (keygen −12.46%, encaps −8.38%)** |
