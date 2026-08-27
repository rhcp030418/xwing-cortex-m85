# 실험 AU (AT-2) 결과 — fixed-base X25519 보드 A/B: **사전등록 gate FAIL**

> 측정 2026-08-26. 보드 EK-RA8M1, DWT CYCCNT, REP_N=100, ABBA, 독립 flash/run 2회.
> 사전등록: `2026-08-25_expAT_x06_fixedbase_prereg.md` §7 AT-2, gate §8.1.
> 선행: AT-0(`expAT0_results.md`), AT-1(`expAT1_results.md`).

---

## 1. 판정 — 사전등록 gate 미달

| 항목 | 결과 |
|---|---|
| 정확성 (RFC 7748 KAT 2종 + base 대 ladder 68종) | **PASS**, mismatch 0 |
| 성능 절감 (fixed-base 단독) | **+13.30%** |
| 사전등록 AT-2 gate (**≥25%**) | **FAIL** |
| 상수시간 | A delta 0 / **B delta +6 cyc — 확인 필요** |

사전등록 §8.1은 *"AT-2: fixed-base 단독 scalarmult가 현행 대비 25% 이상 절감하지
못하면 종료"*로 고정돼 있다. **13.30%는 이 gate를 넘지 못한다.**

투영(AT-1 §4)은 197,052 cyc / −44.9%였고 실측은 309,897 cyc / −13.30%다.
**투영이 112,845 cyc 낙관적이었다.** 아래 §3이 그 전액을 귀속한다.

## 2. 측정값

### 2.1 깨끗한 빌드 A/B (ELF `38CC87A5…`)

| | AB | BA | median |
|---|---:|---:|---:|
| A 현행 Montgomery ladder | 357,448 | 357,454 | **357,451** |
| B fixed-base comb | 309,897 | 309,897 | **309,897** |

절감 47,554 cyc = pair1 +13.303% / pair2 +13.304% → **conservative +13.30%**.

정확성:
```
expAU correctness: kat-fails=0 diff-mm=0 checks=70
harness_fails=0, KAT ALL PASS, stack-used=884
```

- RFC 7748 §6.1 alice·bob public key: 일치
- clamp 경계 4종 + 무작위 64 seed에서 `scalarmult_base(k)` 대
  `curve25519_scalarmult(clamp(k), 9)`: **mismatch 0** (68 검사)

상수시간: A는 스칼라 all-zero/all-ones에서 cycle 차 **0**, B는 **+6 cyc**(§5-3).

### 2.2 귀속용 빌드 (ELF `65BE0A90…`, prof 분기 포함)

prof 분기 때문에 B가 309,897 → 315,032(+5,135)로 늘었고 prof-on 총합은 327,533이다.

| 단계 | cycles | 비중 | AT-1 투영 | 차 |
|---|---:|---:|---:|---:|
| recode | 1,164 | 0.4% | (미계상) | +1,164 |
| **표 select** | **129,555** | **39.6%** | 81,543 | **+48,012** |
| **madd (7M+7add ×86)** | **148,295** | **45.3%** | 88,843 | **+59,452** |
| inversion + 변환 + freeze | 39,614 | 12.1% | 26,667 | +12,947 |
| 미귀속 | 8,905 | 2.7% | — | +8,905 |

두 run에서 각 단계 차이는 최대 1 cyc였다.

## 3. 왜 빗나갔나 — 전액이 glue다

### 3.1 madd: field op당 +49 cyc의 AAPCS 래퍼 세금

`madd` 1회는 7 mul + 7 add/sub이고 86 윈도면 **1,204 field op**다.

```
실측 148,295 / 1,204 = 123.2 cyc/op
투영  88,843 / 1,204 =  73.8 cyc/op   (expAR/expAS 실측 단가의 가중평균)
차                    =  49.4 cyc/op  ->  총 +59,452
```

원인이 명확하다. expAR이 잰 **115.005 cyc/mul은 래더 안에서 레지스터로 인자를
주고받는 native 호출 비용**이다. 이번 C 구현은 AAPCS 래퍼
(`fe25519_mul_lenn` 계열)를 거치는데, 래퍼마다

```
push {r4-r11,lr} / sub sp / str / mov / bl / ldr / stm {r0-r7} / add sp / pop {r4-r11,pc}
```

가 붙는다. **연산 결과 8 word를 매번 메모리에 쓰고 다음 연산이 다시 읽는다** —
Lenngren asm이 r0–r7로 값을 넘겨 받는 설계 이점이 통째로 사라진다.

### 3.2 select: 부호 접기로 word당 연산이 늘었다

```
실측 129,555 / 86 = 1,506 cyc/window
AT-0  81,543 / 86 =   948 cyc/window
차                =   558 cyc/window
```

AT-0의 chunked scalar 커널은 word당 `load / and / orr` 3연산이었다. 이번 구현은
부호 swap을 select 루프에 접느라 word당 `a0, a1 두 load + 4 mask 연산 + 2 orr` +
xy2d 2연산으로 늘었고, 여기에 윈도마다 `fe25519_sub_lenn`(래퍼 포함 ~85 cyc)과
`fe_cmov`가 더 붙는다.

### 3.3 inversion: 265회 전부 래퍼를 탄다

254 sqr + 11 mul = 265 호출 × 래퍼 세금 ≈ +12,900. §3.1과 같은 원인이다.

### 3.4 glue를 제거하면 투영과 맞는다

```
309,897 − 59,452(래퍼 세금) − 48,012(select 초과) = 202,433  ->  −43.4%
```

**AT-1의 −44.9% 투영과 1.5%p 이내로 일치한다. 알고리즘 자체는 반증되지 않았다 —
반증된 것은 이 C + AAPCS 래퍼 구현이다.**

## 4. 결론과 권고

### 4.1 사전등록대로 이 변형은 종료한다

gate는 측정 전에 25%로 고정했고 결과는 13.30%다. **gate를 사후에 낮추지 않는다.**
현재 구현을 대표 경로에 채택하지 않는다.

### 4.2 그러나 X06 후보 자체는 살아 있다

§3.4가 보이듯 남은 107 kcyc는 전부 구현 세금이고 제거 경로가 구체적이다.

1. **madd를 native ABI로 작성** — `fe25519_mul/add/sub`를 r0–r7로 직접 이어 붙이는
   asm 루프. 래퍼 세금 59 kcyc가 사라진다. Lenngren 계열의 호출 규약을 그대로 쓰므로
   새 field 산술을 쓰지 않는다.
2. **select를 AT-0 커널 형태로 되돌리고 부호 처리를 분리** — 부호별로 표를 두 배로
   두면(엔트리 8개) select 자체는 AT-0 조건이 되지만 조회 바이트가 2배가 된다.
   대안: `ymx/ypx` swap을 madd 쪽에서 인자 순서로 흡수한다(조회는 그대로, 부호는
   madd 진입 시 포인터 선택). 이쪽이 유망하다.
3. inversion도 native 체인으로.

**이 이동은 새 사전등록이 필요하다.** 같은 gate를 이어 쓰지 않고, 구현 방식이
바뀌었으므로 새 실험 ID와 새 임계값을 측정 전에 고정한다.

### 4.3 지금 상태로도 양수이긴 하다

13.30%는 keygen `pkX`와 encaps `ctX`에 적용 시 각각 47,554 cyc = X-Wing keygen의
**−6.2%**, encaps의 **−4.2%**다. 실측 양수이지만 **사전등록 gate 미달이므로 채택
후보로 올리지 않는다.** 채택하려면 gate를 다시 정하고 재측정해야 한다.

## 5. 미측정·주의

1. **B의 상수시간 delta가 0이 아니다(+6 cyc).** A는 정확히 0이다. 6 cyc는
   314,805 대비 0.002%지만 **0이 아니므로 PASS로 쓰지 않는다.** 원인 후보:
   `comb_select`의 `fe25519_sub_lenn`/`fe_cmov` 경로, `fe_freeze`의 데이터 의존
   store 패턴, 또는 측정 잡음. 채택 전 반드시 규명해야 한다.
2. `x25519_base.c`는 **최적화 목적이 아니라 정확성 검증 목적**으로 작성한 참조
   구현이다. §4.2 이전에는 성능 대표값으로 인용하지 않는다.
3. 표는 flash 상주다. ITCM/RAM 변형은 미측정(AT-0 §2.3에서 이득 없음을 확인).
4. 이 실험은 X-Wing 통합(AT-3)을 하지 않았다. keygen/encaps wrapper 교체는
   gate 통과 후로 미룬다.
5. EK-RA8M1 한 개체, 이 배치 한정.

## 6. 실패·이탈 정직 기록

1. **깨끗한 빌드의 원시 로그를 덮어썼다.** 첫 A/B(ELF `38CC87A5…`, 13.30%)를
   `logs/2026-08-26_expAU_run{1,2}.txt`에 기록한 뒤, 귀속 빌드를 **같은 파일명으로**
   다시 돌려 덮었다. 현재 남은 로그는 귀속 빌드(ELF `65BE0A90…`, 11.87%)의 것이다.
   §2.1의 수치는 첫 실행의 콘솔 출력과 JSON에서 가져왔고 ELF/SREC 해시로 식별되지만
   **원시 로그 파일은 보존되지 않았다.** 다음부터 실행마다 파일명을 분리한다.
2. AT-0에서 최적 w를 고를 때 **madd의 AAPCS 래퍼 세금을 회계에 넣지 않았다.**
   AT-0은 조회 커널만 실측하고 산술은 "실측 단가 × 연산 수"로 두었는데, 그 단가가
   native 호출 기준이라는 점을 §4 회계에서 놓쳤다. w 선택 자체는 이 세금이 w에
   비례하지 않으므로 바뀌지 않지만, **절감률 투영이 그만큼 낙관적이었다.**

## 7. 아티팩트

동결: `artifacts/2026-08-26_expAU/` (+ `SHA256SUMS.txt`) — 귀속 빌드 기준

| 파일 | SHA-256 |
|---|---|
| `blinky.elf` (귀속 빌드) | `65BE0A90DAD1D1862156348D4E1E4435232DA2CA01E60FA9F539D6FE2A94A355` |
| `blinky.srec` | `4165B1C6B587C14410C66F3A466BBEA55F2338F8A5373B8C772702A1E049D63C` |
| `blinky.map` | `F99756342975DCC989D40D2A89F7F80D38A395F0E08754BC88472ADC2F7D7AD7` |
| `x25519_base.c` | `59F41CBE6C1647A795677949B75F8E2E2772058F059E6896B324AA2EC82C72A3` |
| `x25519_base.h` | `1A0532909B43B7C6D8E0B6D40092C24EFCC4BBAEC135E04192D5438A8B0638FD` |
| `x25519_base_shim.S` | `6AA9A53D7ECDFF6386BB36BF8307D9BF48E88A2F35256B699B27452E835ECA1B` |
| `expAU_slots.inc` | `C3F8333FB50D99F87E5A9F07F63EE25CE86E41F059FA22A854E82FFA6CD73C7A` |
| `harvest_ra8m1_expAU.py` | `C53DDE03A3C5B0A8F95629C28C4CB0645F33165ADF6EC29E86E4893082DD0AD2` |
| 깨끗한 빌드 ELF (로그 미보존) | `38CC87A5ABA65949328431151CBD48D65E802674B9521FA69DCCFD318FE06FDB` |
| 깨끗한 빌드 SREC | `AAF2856AE5C27AFF42DBB71A77B4781DBDD7FBE1690E693B66F53A81DBE15721` |

표 생성기와 표: `expAT-src/at1_comb.py`, `expAT-src/x25519_base_table.h` (AT-1 동결).

빌드 변경: `Debug/src/subdir.mk`에 `x25519_base.c`, `Debug/src/gen/subdir.mk`에
`x25519_base_shim.S` 등록. `REP_SLOTS 489→502`.

**주의**: 이 빌드에는 expAO~expAS의 소스 계측이 **없다**(2026-08-26 전부 원본 복원,
`revert_check` 로그로 expAN 기준선 재현 확인: 762,072 / 1,134,709 / 810,087).
