# 사전등록 — 실험 AV (X06 재도전): native-ABI comb

> 작성 2026-08-26, **측정 전**. 선행: AT-0/AT-1 통과, **AT-2 gate FAIL(+13.30% < 25%)**.
> AT-2의 gate를 이어 쓰지 않고 **새 임계값을 여기서 다시 고정한다.**
>
> **【실행 결과】 gate PASS — 실측 +26.80%** (357,445 → 261,647). 결과는
> `2026-08-26_expAV_results.md`. §4 목표 −33.7% 대비 −26.80%로 다소 미달했고,
> 남은 차이는 select 에 아직 붙어 있는 +33,200 cyc(조건부 negate·cmov·루프)다.
> §5.3 의 상수시간 판정 문구("median 차 정확히 0")는 run1 에서 충족되지 않았으나,
> 두 분포가 겹치고 최솟값이 같아 데이터 의존 차이는 없다 — 결과 §5 참조.

---

## 1. 무엇이 실패했고 무엇이 실패하지 않았나

AT-2(`2026-08-26_expAU_AT2_results.md`)는 정확성을 전부 통과했지만 절감이
**+13.30%**로 gate 25%에 미달했다. 단계별 귀속이 원인 전액을 짚었다.

| 단계 | AT-2 실측 | AT-1 투영 | 차 |
|---|---:|---:|---:|
| madd | 148,295 | 88,843 | +59,452 |
| 표 select | 129,555 | 81,543 | +48,012 |
| inversion | 39,614 | 26,667 | +12,947 |

**알고리즘이 아니라 구현 glue다.** 두 초과분을 빼면 202,433 = −43.4%로 투영과 맞는다.

## 2. 두 가지를 바꾼다

### 2.1 madd를 native ABI asm 루프로

AT-2는 `fe25519_mul/add/sub`를 AAPCS 래퍼(`*_lenn`)로 불렀다. 래퍼마다
`push {r4-r11,lr}` / `sub sp` / `str` / `bl` / `ldr` / `stm {r0-r7}` / `add sp` /
`pop {r4-r11,pc}`가 붙어 **field op당 49.4 cyc**를 물었다.

새 `ge_madd_native`는 asm으로 작성해 자기 스택 프레임에 중간값 8개를 두고
Lenngren 함수를 **원래 규약 그대로**(`fe25519_mul`은 `*r1,*r2`, `add/sub`는
`*r8,*r9`) 호출한다. 호출 사이 저장은 `stm {r0-r7}` 한 번뿐이다.

> **솔직한 하한**: 이 field op ABI는 **포인터로 인자를 받는다.** 따라서 연속 연산
> 사이의 `stm {r0-r7}`(약 8 cyc)은 제거할 수 없다. expAR이 잰 115.005 cyc/mul은
> 래더가 값을 r0–r7로 **레지스터째 물려주는** 비용이므로, comb는 원리적으로 그보다
> op당 약 10~14 cyc 비싸다. §4의 목표치는 이 하한을 반영한 것이다.

### 2.2 부호 처리를 select 밖으로

AT-2는 `ymx/ypx` swap을 select 루프 안에 접어 word당 연산을 3 → 8로 늘렸다.
새 구현은 select를 **AT-0에서 실측된 chunked scalar 커널 형태 그대로** 두고,
부호는 **madd 진입 시 포인터 선택**으로 흡수한다.

```c
/* 상수시간 포인터 cmov */
pa = (s & (uintptr_t)ymx) | (~s & (uintptr_t)ypx);
pb = (s & (uintptr_t)ypx) | (~s & (uintptr_t)ymx);
```

`xy2d`의 조건부 negate는 그대로 남긴다(윈도당 1회).

## 3. 바꾸지 않는 것

- 표(`x25519_base_table.h`, w=3, 86 윈도, 33,024 B, flash 상주) — AT-1 동결본 그대로
- comb 알고리즘, digit recode, 항등원 처리
- 적용 지점: keygen `pkX`, encaps `ctX` **둘뿐**
- field 산술 자체 — Lenngren asm을 그대로 쓴다(새 산술을 도입하지 않는다)
- RFC 7748 입출력 정의

## 4. 목표치 (투영, 실측 아님)

| 단계 | AT-2 실측 | AV 목표 | 근거 |
|---|---:|---:|---|
| madd | 148,295 | ~105,000 | op당 glue 49.4 → ~14 (stm 하한 포함) |
| select | 129,555 | ~89,000 | AT-0 커널 81,543 + negate 86×~85 |
| inversion | 39,614 | ~33,000 | 265 호출도 native 경유 |
| recode + 미귀속 | 10,069 | ~10,000 | 그대로 |
| **합계** | **327,533** | **~237,000** | |

현행 357,451 대비 **약 −33.7%** 목표다. **이는 투영이며 절감률로 인용하지 않는다.**

## 5. 사전 고정 kill gate

### 5.1 성능 (측정 전 고정)

- **AV gate: fixed-base 단독 scalarmult가 현행 대비 25.0% 이상 절감**해야 한다.
  못 넘으면 **X06 트랙 전체를 종료**하고 X01/X02·X03/X05로 옮긴다.
  (§4 목표 −33.7%에 8.7%p 여유를 둔 값이다. AT-2와 같은 임계값을 쓰는 이유는
  이것이 "채택할 가치가 있는가"의 기준이지 구현 난이도의 함수가 아니기 때문이다.)
- AT-2의 13.30%를 기준선으로 삼지 않는다 — 비교 대상은 언제나 현행 ladder다.

### 5.2 정확성 (전부 필수, AT-2와 동일)

- RFC 7748 §6.1 KAT 2종
- clamp 경계 4종 + 무작위 64 seed에서 `scalarmult_base(k)` 대
  `curve25519_scalarmult(clamp(k), 9)` mismatch 0
- 기존 전체 하네스 KAT·mismatch 0, stack canary 0

### 5.3 상수시간 — AT-2의 미해결 항목을 여기서 닫는다

- 스칼라 all-zero / all-ones에서 cycle 차 **정확히 0**이어야 한다.
  AT-2는 **+6 cyc**였고 원인 미규명이다. AV에서 0이 아니면 **원인을 규명하기 전까지
  채택 후보로 올리지 않는다**(성능 gate를 통과하더라도).
- 표 조회가 모든 엔트리를 훑는지, 부호 포인터 선택이 분기 없는지 코드 검토

### 5.4 자원

- `.text` 증가량(표 33,024 B 포함), ITCM working set, stack high-water 보고
- `ge_madd_native`의 스택 프레임 크기 명시

## 6. 상한 회계

절감은 적용 분모를 넘을 수 없다: keygen `pkX` < 357,839, encaps `ctX` < 357,824,
decaps 0. §4 목표가 맞더라도 X-Wing 기준 keygen −15.8% / encaps −10.6%가 상한이다.

## 7. 근거

- `measure-harness/2026-08-26_expAU_AT2_results.md` — 실패 원인 귀속 (§3)
- `measure-harness/2026-08-25_expAT0_results.md` — 표 조회 커널 단가 948.17 cyc/select
- `measure-harness/2026-08-25_expAT1_results.md` — 표·KAT·연산 수 계수
- `measure-harness/2026-08-25_expAR_results.md`, `..._expAS_results.md` — field op 단가
- `src/x25519/x25519-cortex-m4-gcc.s` 주석 — field op ABI 계약
