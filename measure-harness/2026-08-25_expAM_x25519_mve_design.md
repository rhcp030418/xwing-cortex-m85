# expAM0 — X25519 whole-ladder MVE 설계·기준선 동결

> 작성 2026-08-25. 코드 작성 전 단계(AM0). 이 문서는 **정적 사실·어셈블러 probe 실행
> 결과·기존 실보드 로그**만 담는다. 신규 실보드 측정은 없다(AM1 이후).
> 표기 규칙: **실측** = 실보드 DWT 로그 존재 / **정적** = 소스·map·어셈블러 산출물에서
> 직접 확인 / **추정** = 산술 투영 / **미측정** = 아직 재보지 않음.

---

## 0. 동시 작업 충돌 확인 (프롬프트 §2 이행)

세션 시작 2026-08-25 17:03 기준.

| 항목 | 확인값 | 판정 |
|---|---|---|
| `tasklist` e2studio/JLink/python | 0건 | 충돌 없음 |
| `src/harness.c` mtime | 2026-08-24 21:45:33 | 세션 시작 전 |
| `Debug/blinky.elf` / `.map` / `.srec` mtime | 2026-08-25 16:42:21 | 세션 시작 전 (expAL 동결 빌드) |
| `Debug/` 최신 파일 | 16:42:20~21 일괄 (빌드 산출물) | 진행 중 빌드 없음 |

→ **다른 세션이 harness.c 또는 `Debug/`를 쓰고 있지 않다. AM 진행 가능.**
현재 `Debug/`의 ELF는 expAL 대표 결과를 낸 바로 그 빌드다(SHA
`555777958E99D2871115D2E74035F665239B7363B6091C3311CBC0EF06A4CFE8`).

---

## 1. 현재 X25519 구현 계보와 실제 대표 호출 경로 — **정적, 확인 완료**

대표 경로의 X25519는 **Lenngren 8×32-bit asm**이다. Fiat 10×25/26은 대표 경로에 없다.

- 파일: `src/x25519/x25519-cortex-m4-gcc.s` (1,032줄), 진입점 `curve25519_scalarmult`
- 배치: 파일 선두에서 `.section .itcm_code_from_flash` → **전체가 ITCM**
- 대표 X-Wing wrapper의 호출 지점 (`src/harness.c`):

| 연산 | 줄 | 호출 수 |
|---|---|---:|
| keygen | 421 | 1 job |
| encaps | 434, 435 | **2 jobs** |
| decaps | 445 | 1 job |

`curve25519_scalarmult_fiat`(Fiat)와 `x25519_u_*`(U 큐)는 F/U 트랙 전용 분기이며 대표
경로에서는 호출되지 않는다.

### 정적 구조

| 심볼 | umull/umaal 수 | 총 명령 라인 | 저자 주석 M4 cyc |
|---|---:|---:|---:|
| `fe25519_add` | 0 | — | 45 |
| `fe25519_sub` | 0 | — | 46 |
| `fe25519_mul` | **72** | 120 | **173** |
| `fe25519_sqr` | **52** | — | **115** |
| `fe25519_sqr_many(n)` | 52n | — | 19 + 123n |
| `x25519-cortex-m4-gcc.o` 전체 크기 | — | — | **0x764 = 1,892 B** (ITCM) |

### 래더·인버전 호출 회계 — **정적**

`curve25519_scalarmult` 본문(569~1030줄)은 래더 스텝을 **인라인하지 않고 `bl`로 호출**한다.

- 래더 루프(622~793줄), `movs r0,#254` → `bpl 0b` = **255 iteration**
  - iteration당: **`fe25519_mul` ×5, `fe25519_sqr` ×4**, `fe25519_add` ×3, `fe25519_sub` ×4
  - = 표준 5M+4S. cswap은 4-word 언롤 루프 ×4 (인라인, 저자 주석 158 cyc)
  - 저자 주석: iteration당 **2,020 cyc**, 255회 = **515,098 cyc**
- 인버전(794~1030줄): `fe25519_mul` ×12, `fe25519_sqr` ×4, `fe25519_sqr_many` ×8
  - `sqr_many` 주석 합 = 634+1249+2479+1249+6169+12319+6169+634 = **30,902 cyc**
- 전체 저자 주석 M4 = 548,873 cyc

### mul/sqr 비중 — **추정 (M4 저자 주석 기반, M85 미측정)**

| 항목 | M4 cyc | X25519 대비 |
|---|---:|---:|
| `fe25519_mul` 총합 (255×5 + 12 = 1,287회) | 222,651 | **40.6%** |
| `fe25519_sqr` 총합 (255×4 + 4 + sqr_many) | 148,662 | **27.1%** |
| **mul + sqr** | 371,313 | **67.7%** |

> ⚠ **프롬프트 §AM1 근거 산수에 대한 AM0 정정 — 측정 전 기록.**
> 프롬프트는 "mul 15% 절감 → 종단간 ≈10~12%"라 적었고 이는 mul/sqr 비중 70~80%를 통째로
> 곱한 값이다. 위 정적 분해에 따르면 **`fe25519_mul`만** 15% 절감할 경우 종단간 기여는
> `0.406 × 15% = 6.1%`이고, AM2의 10% gate에 도달하려면 **`fe25519_sqr`도 같은 폭으로
> 개선되어야** 한다(`0.677 × 15% = 10.2%`).
> → **AM1 후보는 sqr에도 적용 가능한 구조여야 하며, 그렇지 않으면 AM1을 통과해도 AM2의
> 10% gate는 산술적으로 도달 불가다.** 이 정정은 측정 전에 확정하며 측정 후 바꾸지 않는다.
> 프롬프트 원문 산수(70~80% / 10~12%)도 그대로 병기해 보존한다.

---

## 2. 기준선 동결 — **실측 (기존 로그, 신규 측정 없음)**

### 2-1. 같은-ELF 동결 기준선

expAL 동결 ELF(위 SHA)에서 두 독립 run 모두:

| 항목 | run1 | run2 | 출처 |
|---|---:|---:|---|
| `[x25519-scalarmult] x10` dwt_cyc/op | **357,520** | **357,520** | `logs/2026-08-24_expAL_run{1,2}.txt` |
| 같은 줄 pmu_cyc/op | 357,521 | 357,521 | 동상 |

두 run 완전 일치. **AM의 A 비교군 기준선은 이 값 계보로 고정한다.**

### 2-2. 기존 정본 357,474와의 관계 — 정직 기록

- `1단계_게이트_리포트.md` 등의 정본 **357,474**는 2026-08-16 측정이며 **원 로그 미보관**이다
  (`2026-08-24_기록_재현성_감사.md`, `2026-08-24_expAF_pilot_rebaseline_results.md` 확인).
- AF 재기준화에 따르면 같은 실행 안에 **두 계보**가 공존한다:
  - x10 루프 루틴 계보: 357,507~511 (오늘 동결값 357,520이 여기 속함)
  - N=100 − calib 루틴 계보: 357,475~500
- 따라서 **357,474와 357,520을 같은 계보로 비교하지 않는다.** AM1의 A/B 비교는
  전부 같은 ELF·같은 루틴 안에서만 한다.

### 2-3. AM1이 새로 뽑아야 할 기준 slot — **미측정, 설계만**

현재 harness의 `rep_cyc[1]` (`bench_x25519_reps`, N=100 슬롯)은 **ELF 안에 이미 존재하지만
expAL 회수기가 출력하지 않는다**. AM1 회수기는 최소한 slot 1을 함께 출력해야 한다.

AM1 신규 슬롯(현재 `REP_SLOTS=333`, 0~332 전부 사용 중 → **333번부터**):

| slot | 내용 | 목적 |
|---:|---|---|
| 333 | `fe25519_mul` (Lenngren, ITCM) 단독 ×N | A: mul 단독 |
| 334 | `fe25519_mul` + ladder carry/reduction 묶음 | A: mul+carry 묶음 |
| 335 | `fe25519_mul_mve` (B1) 단독 ×N | B1: mul 단독 |
| 336 | `fe25519_mul_mve` + 같은 묶음 | B1: mul+carry 묶음 |
| 337~342 | 명령 스루풋 마이크로 슬롯 (AM1-a, §7-3) | 판정 근거 분해 |

`SLOT_N`은 회수기와 `REP_SLOTS`를 **함께** 갱신한다(프롬프트 §4-9).

---

## 3. ABI·레지스터 예산 — **정적 + probe 확인**

### 3-1. MVE/스칼라 예산

- MVE: `q0`~`q7` 8개. **`q4`~`q7`은 callee-saved**(d8~d15) → 전체 8개를 쓰려면 진입/이탈에
  `vpush {d8-d15}` / `vpop` 64 B 저장.
- 스칼라: `r0`~`r3`,`r12` caller-saved, **`r4`~`r11` callee-saved**, `lr`.
- 기존 U 실패의 주원인 중 하나가 **fragment마다 반복된 이 양보 세금(약 +12~13%)**이었으므로
  (프롬프트 §3), AM은 진입·이탈 1회만 저장하는 custom-ABI 방향을 유지한다.

### 3-2. `vmlaldav*` 누산기 레지스터 제약 — **probe 실측**

| 시도 | 결과 |
|---|---|
| `vmlaldava.u32 r0,r1 / r2,r3 / r4,r5 / r6,r7 / r8,r9 / r10,r11 / r12,r13` | **전부 OK** |
| `vmlaldava.u32 r10, r3` (비인접 짝/홀) | **OK** |
| `vmlaldava.u32 r5, r4` (RdaLo가 홀수) | **REJECT** — `Even register not allowed here` |

→ **제약은 "RdaLo는 짝수, RdaHi는 홀수"뿐이고 인접 쌍일 필요는 없다.**
r13(SP)은 어셈블러가 받아주지만 사용 금지. 실사용 가능 짝수 RdaLo = r0,r2,r4,r6,r8,r10,r12 (7개).

### 3-3. 1-job / 2-job 배치 후보

- **1-job coefficient-parallel**: 한 field element의 limb들을 lane에 배치. 후보로 유지.
- **2-job job-parallel**: §6 lane 회계에서 **기각**.

---

## 4. field representation 후보 비교 (최소 2개) — **정적**

| # | 표현 | limb 수 | 부분곱 수 | MVE 적합성 | 판정 |
|---|---|---:|---:|---|---|
| R1 | 기존 8×32 유지 | 8 | 64 | 32×32→64 누적을 lane별로 해야 하는데 **MVE에 64-bit lane 산술이 없음**(§5-2) | **기각** |
| R2 | 10×25/26 교대 radix (Fiat/ref10 계열) | 10 | 100 | `vmlaldava.u32` 열-내적과 정합, wrap 계수가 정확히 19 | **채택 (B1)** |
| R3 | 균일 radix 2^26 (10 limb, 260-bit) | 10 | 100 | wrap 계수 `2^260 ≡ 32·19 = 608` → 접기 후 `608·10·2^52 ≈ 2^64.05` **64-bit 초과** | **기각(산술)** |
| R4 | 16-bit radix + `vmlaldava.u16` (8 lane) | 16 | 256 | lane은 2배지만 부분곱이 4배 → 열 명령 수 46 > R2의 33 | **기각(회계)** |
| R5 | 5×51 | 5 | 25 | 32-bit MVE lane에 51-bit limb 불가 | **기각(자명)** |

### R2 오버플로 검산 — **산술 확인**

교대 radix에서 `off_i = ceil(25.5·i)`이고 `off_{i+10} = off_i + 255`이므로 wrap 계수는
정확히 **19**다. 두 홀수 index의 곱만 `×2` 보정이 필요한데, 열 `k`가 짝수일 때만 그 항이
생기므로 **홀수 limb을 미리 2배한 `a2` 버퍼를 짝수 열에, 원본 `a`를 홀수 열에** 쓰면 된다.

- limb 상한: 짝수 index `< 2^26`, 홀수 index `< 2^25`, `a2`의 홀수 index `< 2^26`
- 항 상한 `< 2^26 · 2^26 = 2^52`, 열(최대 10항) `< 10·2^52 ≈ 2^55.3`
- 접기 후 `col_k + 19·col_{k+10} < 2^55.3 + 19·2^55.3 ≈ 2^59.6` → **64-bit 안에 들어간다.** OK

---

## 5. MVE 정수 명령 probe — **실행 결과 (어셈블 OK/REJECT)**

도구: `C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\toolchains\gcc_arm\13.2.rel1\bin\arm-none-eabi-gcc.exe`
(GCC 13.2.rel1), 플래그 `-c -mcpu=cortex-m85 -mthumb -mfloat-abi=hard -mfpu=fpv5-d16`,
명령 1개당 어셈블 유닛 1개.

> ⚠ 이 절은 **어셈블 수용 여부만** 확정한다. "실보드 1회 결과 일치"는 AM1에서 수행하며
> 현재 **미측정**이다.

### 5-1. 광폭 곱 (누산 없음)

| 명령 | 결과 |
|---|---|
| `vmullb.u32 q0,q1,q2` | **OK** |
| `vmullt.u32 q0,q1,q2` | **OK** |
| `vmullb.s32` / `vmullt.s32` | **OK** |

### 5-2. 64-bit lane 산술 — **전부 REJECT (핵심 음성 결과)**

| 명령 | 결과 | 어셈블러 메시지 |
|---|---|---|
| `vadd.i64 q0,q1,q2` | **REJECT** | `selected FPU does not support instruction` |
| `vaddq.i64 q0,q1,q2` | **REJECT** | `selected processor does not support ... in Thumb mode` |
| `vhadd.u64 q0,q1,q2` | **REJECT** | `bad type in SIMD instruction` |
| `vshr.u64 q0,q1,#26` | **REJECT** | `bad type in SIMD instruction` |
| `vqmovnb.u64 q0,q1` | **REJECT** | `bad type in SIMD instruction` |

> **결론 ①**: MVE에는 **64-bit lane 덧셈·시프트·narrowing이 존재하지 않는다.**
> 따라서 `vmullb/vmullt`가 만든 64-bit lane 곱은 **lane 안에서 누산할 수도, 자리올림을
> 처리할 수도 없다.** R1(8×32 유지) 경로가 여기서 죽는다.
> **결론 ②**: field-mul의 접기(fold)와 carry 전파는 **전부 스칼라로만** 가능하다.
> 이것이 AM1 성능 예측의 최대 위험 요인이다(§7-3).

### 5-3. lane 내적 → 64-bit 스칼라 쌍 누산 (승부처)

| 명령 | 결과 |
|---|---|
| `vmlaldav.u32 r4,r5,q1,q2` | **OK** |
| `vmlaldava.u32 r4,r5,q1,q2` | **OK** |
| `vmlaldava.s32` / `vmlaldavax.s32` | **OK** |
| `vrmlaldavha.s32` | **OK** |
| `vmlaldava.u16` (8 lane) | **OK** |

### 5-4. lane별 독립 64-bit 누산 존재 여부 — **없음**

| 명령 | 결과 |
|---|---|
| `vmla.u32 q0,q1,r2` | OK — **단 결과 32-bit 절단, 광폭 아님** |
| `vmlas.u32 q0,q1,r2` | OK — 동상 |
| `vmlalb.u32 q0,q1,q2` | **REJECT** — `bad instruction` |

### 5-5. 역순 피연산자 공급 / carry 재료 / low-overhead loop

| 분류 | 명령 | 결과 |
|---|---|---|
| 역순 | `vldrw.u32 q0,[r0,q1,uxtw #2]` (gather) | OK |
| 역순 | `vldrw.u32 q0,[r0],#-16` / `[r0,#-16]` | OK |
| 역순 | `vrev64.32` / `vrev32.16` | OK |
| carry | `vadd.i32` `vsub.i32` `vshr.u32 #26` `vand` `vbic` `veor` `vshlc` `vpsel` | **전부 OK** |
| carry | `vshl.u32 q0,q1,q2` (벡터 시프트량) · `vmul.i32` · `vmov.i32 q0,#0` | OK |
| LOL | `dls/le` · `wls/le` · `vctp.32`+`vpst`+`vaddt` · `dlstp.32`/`letp` | **전부 OK** |
| 이동 | `vmov r0,r1,d0` · `vmov.32 r0,q0[2]` · `vmov q0[2],r0` · `vddup.u32` | OK |

### 5-6. `vldrw` 즉치 오프셋 한계 — **probe 실측**

`vldrw.u32 q0,[r1,#imm]` : `#4` OK · `#-4` OK · `#508` OK · **`#512` REJECT**
(`immediate must be a multiple of 4 in the range of +/-[0,508]`).
→ **4의 배수면 임의 limb 오프셋 슬라이스 로드가 가능**하다(열-내적 구현의 전제).
(실험 Q의 `GATHER_IMM=508` 기존 실증과 정합.)

---

## 6. lane 회계 — 2-job 기각 판정

프롬프트 §AM0 "lane 회계 원칙"의 조건부를 probe로 해소했다.

- u32 lane은 **4개**뿐이다.
- 광폭 MAC 명령은 `vmlaldav*` 계열이 **유일**하고, 이들은 전 lane을 **하나의 64-bit 스칼라
  쌍(RdaLo:RdaHi)으로 환원**한다(§5-3).
- lane별 독립 64-bit 누산기는 **존재하지 않는다**(§5-4 `vmlalb.u32` REJECT, `vmla.u32`는
  32-bit 절단).
- 64-bit lane 덧셈으로 우회할 수도 없다(§5-2 전부 REJECT).

> **판정: 2-job job-parallel(B2)을 AM0에서 기각한다.**
> 사유: encaps의 두 X25519를 lane 그룹에 나란히 배치하려면 job별로 독립된 64-bit 누산이
> 필요한데, M85 MVE의 광폭 MAC은 전-lane 환원뿐이라 두 job의 부분곱이 같은 누산기에
> 섞인다. 32-bit 절단 누산(`vmla.u32`)으로 내려가면 radix가 13-bit 이하로 떨어져 부분곱이
> 4배 이상 늘어나 회계가 성립하지 않는다.
> → **프롬프트 §6-1의 2-job 후보는 여기서 종료.** AM1은 B1 단일 후보로 간다.

---

## 7. AM1 후보 B1 확정 — 1-job coefficient-parallel

**B1 = radix 2^25.5 (10×25/26) 열-스캐닝 schoolbook, `vmlaldava.u32` 기반.**

### 7-1. 열 회계 — **정적**

열 `k = i+j`, `k = 0..18`, 열 길이 `L_k = 1,2,…,9,10,9,…,2,1` (합 100).
`vmlaldava` 1개가 4 lane을 처리하므로 열당 `ceil(L_k/4)` 개:

```
k :  0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18
L :  1  2  3  4  5  6  7  8  9 10  9  8  7  6  5  4  3  2  1
n :  1  1  1  1  2  2  2  2  3  3  3  2  2  2  2  1  1  1  1   -> 합 33
```

- **`vmlaldava` 33개**. lane 이용률 = `100 / (33×4)` = **75.8%**
- 완벽 패킹 하한은 `100/4 = 25`개이나, 열 경계가 4의 배수가 아니어서 도달 불가.

### 7-2. 슬라이스 오프셋 — **정적**

`brev[j] = b[9-j]`를 만들면 열 `k`의 항은 `a[i] · brev[i + (9-k)]`이고 **두 연속 슬라이스**가
된다. 두 버퍼를 index 12까지 0으로 패딩하면 모든 chunk가 경계 안전하다.

| k | A 시작 | B 시작 | chunk A 시작들 | 최대 접근 index |
|---|---:|---:|---|---:|
| ≤9 | 0 | 9−k | 0, 4, 8 | 11 |
| ≥10 | k−9 | 0 | k−9, k−5, k−1 | 12 |

→ **버퍼 13 word 필요, 16 word(64 B)로 정렬. index 10~12는 0 패딩.**
0 패딩 덕분에 어느 한쪽 인자가 0이 되어 범위 밖 항이 저절로 소거된다.

### 7-3. 정적 명령 예산 — **실제 어셈블 결과 (프로토타입 구현 후 확정)**

프로토타입 `expAM-src/fe25519_mul_mve.S`를 실제로 작성해 M85 타깃으로 어셈블한 결과다
(`-mcpu=cortex-m85 -mthumb -mfloat-abi=hard -mfpu=fpv5-d16`, `.itcm_code_from_flash` 배치).
아래는 추정이 아니라 **objdump 실측 명령 수**다.

| 항목 | 값 |
|---|---:|
| 총 명령 | **282** |
| 코드 크기 (리터럴 16 B 포함) | **1,024 B** |
| MVE `vldrw` (열 슬라이스 + 셋업) | 69 |
| MVE `vstrw` | 7 |
| MVE `vmlaldav(a).u32` | **33** (설계와 정확히 일치) |
| MVE `vmul.i32` / `vmov.i32` | 3 |
| **MVE 소계** | **112** |
| **스칼라 소계** | **170** |
| 분기 명령 | **0** (직선 코드 — 구조적 상수시간) |

스칼라 170개 중 약 120개가 `FINISH` 매크로(접기 + carry 전파) ×10이다. 이는 §5-2의
**64-bit lane 산술 부재**가 강제한 것이며 줄일 여지가 거의 없다.

**A 비교군 정적 대비**: `fe25519_mul` = 120 명령 / 72 umaal / 저자 주석 M4 **173 cyc**.
→ B1은 **명령 수만으로 이미 A의 2.35배**다.

**남은 최적화 여지 (사전등록 §7의 "정적 병목 1회 수정"에 해당)**: `vldrw` 69개 중 약 24개는
제거 가능하다. 저차 열은 A 슬라이스 시작이 항상 word 0이라 서로 다른 A 벡터가 6개뿐이고,
고차 열은 BREV 슬라이스 시작이 항상 word 0이라 서로 다른 B 벡터가 3개뿐인데 현재는 매번
재로드한다. `q4`~`q7`에 상주시키면 되지만 그 대가로 `vpush {d8-d15}`/`vpop`가 붙는다.
**이 수정은 AM1 판정이 보류(5~15%) 구간에 들어갔을 때만 1회 적용한다.** 적용해도
MVE 88 + 스칼라 170 = 258 명령으로 여전히 A의 2.15배다.

> ⚠ **측정 전 사전 예측 — AM1 사전등록에 그대로 동결한다.**
> M85의 MVE가 dual-beat(128-bit 연산 2 cyc/명령)라면 B1은 `112 × 2 + 170 = 394 cyc`,
> MVE가 1 cyc/명령이어도 `112 + 170 = 282 cyc`다. 본 프로젝트는 이미 **"스칼라 로드는 MVE 로드와
> 듀얼이슈되지 않는다"**를 실측했으므로(로드맵 40차, 실험 N×P) 두 부분의 중첩을 낙관할 수
> 없다. **정적 실측 명령 수 기준 282~394 cyc 대 A의 173 cyc → B1은 AM1 kill gate를
> 통과하지 못할 가능성이 매우 높다.** (MVE가 1 cyc/명령이고 스칼라와 완전 중첩되는
> 최선의 경우조차 170 cyc 미만으로 내려갈 수 없어 A와 겨우 비긴다.)
> 이 예측은 **추정이며 판정이 아니다.** AM1 실보드 측정으로만 확정한다. 예측이 맞더라도
> 그것은 "MVE whole-ladder가 M85에서 이기지 못하는 이유"의 음성 결과로 프롬프트 §8 형식에
> 따라 기록한다.
> **MVE 명령 스루풋(1 vs 2 cyc)은 현재 미측정이며, 이것이 예측 전체를 좌우한다.**
> → 그래서 AM1을 **AM1-a(스루풋 마이크로 측정) → AM1-b(커널 측정)** 순서로 쪼갠다.
> AM1-a만으로 하한이 이미 gate를 넘지 못하면 커널 측정 없이 종료할 수 있다(프롬프트
> §4-2 "가장 작은 게이트부터"의 직접 적용).

### 7-4. sqr 적용 가능성 — §1의 정정과 연결

B1의 열-스캐닝 구조는 `a == b`일 때 대칭 항을 2배로 접어 부분곱을 100 → 55로 줄일 수
있으므로 **sqr에도 그대로 적용 가능하다**(프롬프트 §6-3). §1의 정정에 따라 **AM2의 10%
gate 도달에는 sqr 커널이 필수**이므로, AM1에서 B1이 통과하면 AM2 사전등록에 sqr 커널을
반드시 포함한다. AM1 자체는 mul만 측정한다(단일변수 유지).

---

## 8. 코드 배치 예산 — ITCM — **정적, map 실측**

`Debug/blinky.map` (2026-08-25 16:42 expAL 동결 빌드):

- `ITCM_LENGTH = 0x00010000` = **65,536 B** (`Debug/memory_regions.ld`)
- `__itcm_from_flash$$Limit = 0x0000e970` = **59,760 B 사용**
- **여유 = 5,776 B = 5.64 KiB**

> 📌 프롬프트 §3의 "59.8/64 KiB → 여유 약 4.2 KiB"는 단위 혼용(59,760 B를 /1000으로
> 환산)이다. 정확히는 **58.36 KiB 사용 / 5.64 KiB 여유**다. 프롬프트를 수정하지 않고
> 여기 정정만 기록한다.

### ITCM 점유 상위 — 퇴거 후보

| 오브젝트 | 크기 | 이번 질문과의 관계 |
|---|---:|---|
| `src/gen/fiat_u_stitch_m85.o` | **0x5898 = 22,680 B** | **기각된 U 스티칭**. 대표 경로 아님 → **1순위 퇴거 후보** |
| `src/gen/bfull_board.o` | 0x2298 = 8,856 B | expAG 솔버 커널, AM과 무관 → 2순위 후보 |
| `src/keccak/keccakf1600.o` | 0x1fa0 = 8,096 B | 대표 경로 — 유지 |
| `src/gen/expw_*` 6개 | 합 ~0x1900 = 6,400 B | 구실험 → 3순위 후보 |
| `src/gen/mul256_flat6.o` | 0x6a8 = 1,704 B | 구실험 → 4순위 후보 |
| `src/mlkem/*` (ntt/invntt/matacc 등) | 합 ~0x2470 | 대표 경로(X/Y/C8) — 유지 |
| `src/x25519/x25519-cortex-m4-gcc.o` | 0x764 = 1,892 B | **A 비교군 — 반드시 ITCM 유지** |

> **판정**: `fiat_u_stitch_m85.o` 하나만 flash로 옮겨도 **22,680 B**가 열린다. B1 커널
> 예상 크기(~1.5 KiB)는 현재 여유 5,776 B로도 이미 들어가지만, **A와 B를 같은 배치(둘 다
> ITCM)로 두는 단일변수 조건**(프롬프트 §AM1)을 여유 있게 만족시키기 위해 퇴거를 준비한다.
> 퇴거를 실제로 실행하면 **옮긴 오브젝트 목록과 그로 인해 값이 변하는 기존 슬롯을 결과
> 문서에 남긴다**(AF2-P 판례). U 관련 슬롯 값은 배치가 바뀌므로 **AM 결과에서 U 계열 수치를
> 인용하지 않는다**.

---

## 9. 기능 검증 경로 — QEMU 선행 — **환경 확인 완료**

- WSL: `qemu-system-arm` **8.2.2**, `mps3-an547 (Cortex-M55, MVE)` 머신 **존재 확인**
- 기존 자산 재사용: `measure-harness/Makefile`의 `make run-m55` 타깃
  (`-M mps3-an547 -cpu cortex-m55 -nographic -semihosting`)이 이미 동작한다.
  → **새 QEMU 하네스를 만들지 않고 이것을 확장한다.**
- QEMU는 **기능 전용**. 사이클 값은 어떤 문서에도 쓰지 않는다.

---

## 10. AM0 결론

1. 대표 경로 X25519 = **Lenngren 8×32 asm, ITCM, `curve25519_scalarmult`**. keygen 1 /
   encaps 2 / decaps 1 job. **정적 확인 완료.**
2. 기준선 = **같은-ELF 357,520 cyc, 두 run 일치**. 357,474 계보와 섞지 않는다. **실측.**
3. MVE에 **64-bit lane 산술이 전무**하고, 광폭 MAC은 **`vmlaldav*` 전-lane 환원이 유일**하다.
   **probe 실측.**
4. → **2-job job-parallel(B2) 기각.** 8×32 유지(R1) 기각. 균일 2^26(R3) 산술 기각.
5. → **AM1 후보는 B1 하나**: radix 2^25.5 열-스캐닝, `vmlaldava.u32` 33개, lane 이용률 75.8%.
6. **정정**: `fe25519_mul`만 15% 절감 시 종단간 기여는 **6.1%**이지 10~12%가 아니다.
   AM2의 10% gate에는 **sqr 커널이 필수**다. **추정, 측정 전 동결.**
7. 정적 예산은 B1의 **패배를 예측**한다(≈250~350 vs 173 cyc). **판정 아님** — AM1로 확정한다.
8. ITCM 여유 **5,776 B**, 퇴거 시 `fiat_u_stitch_m85.o` **22,680 B** 확보 가능.

### 남은 미측정 위험 (AM0 시점)

| # | 항목 | 왜 위험한가 |
|---|---|---|
| M1 | **M85 MVE 명령 스루풋(1 vs 2 cyc)** | §7-3 예측 전체가 여기 달림. AM1-a에서 최우선 측정 |
| M2 | 같은 누산기 연속 `vmlaldava`의 의존 스톨 | 33개가 열 단위로 체인 → 스톨 시 예산 급증 |
| M3 | 슬라이스 `vldrw`와 스칼라 carry의 LSU 경합 | 로드맵 40차 실측(스칼라 로드↔MVE 로드 비-듀얼이슈)이 그대로 재현될 위험 |
| M4 | 8×32 ↔ 10×25/26 표현 변환 비용 | 대표 경로가 8×32라 AM2에서 반드시 timer 안에 들어감. AM1은 mul 내부만 봄 |
| M5 | probe는 **어셈블 수용**만 확인 — 실보드 동작 일치 미확인 | AM1에서 KAT로 확정 |
| M6 | `q4`~`q7`/`r4`~`r11` 양보 세금 | U 실패의 주원인(+12~13%)이 B1에도 적용될 수 있음 |

---

## 11. B1 프로토타입 구현 — 완료 (AM0 부록, 2026-08-25)

사전등록 후 `expAM-src/`에 최소 프로토타입을 구현하고 QEMU 기능 게이트를 통과시켰다.
**실보드 측정은 아직 하지 않았다(AM1 미실행).**

### 11-1. 산출물

| 파일 | 내용 | SHA-256 |
|---|---|---|
| `expAM-src/fe25519_mul_mve.S` | B1 커널 (radix 2^25.5 열-스캐닝, MVE) | `69051b88…56dcc` |
| `expAM-src/expAM_mul_test.c` | 독립 oracle + 정확성 게이트 | `a9f28fa6…9cd1b` |
| `expAM-src/qemu_main.c` | QEMU 진입점 (CPACR 활성화 포함) | `6721c60d…6fd63` |
| `expAM-src/dbg_main.c` | 단일-limb 진단 probe (보드 bring-up 재사용용) | — |
| `expAM-src/Makefile` | `make run`(QEMU) · `make m85-asm`(ITCM 배치 어셈블) | — |

커널은 `.itcm_code_from_flash`(A 비교군과 동일 섹션)에 배치되며, QEMU 빌드만
`-DAM_PLAIN_TEXT`로 `.text`에 둔다. **공유 파일(`asm-practice/startup.s`, `link.ld`,
`measure-harness/Makefile`)은 수정하지 않았다.**

### 11-2. QEMU 기능 게이트 — **PASS** (기능 전용, 사이클 인용 금지)

`qemu-system-arm 8.2.2 -M mps3-an547 -cpu cortex-m55`:

```
== expAM1 B1 fe25519_mul_mve functional gate ==
  boundary 25 done, fails=0
  random 1200 done, fails=0
  mixed 1000 done, fails=0
  alias+align done, fails=0
== expAM1 checks=2425 fails=0  RESULT: PASS ==
```

- 경계값 5종(`0`, `1`, `p−1`, `p`, `2^255−1`) 전 조합 25개
- 결정적 임의 피연산자 **1,200쌍** (사전등록 요구 ≥1,000 충족)
- 임의값 × 경계값 교차 1,000개
- alias `r==a` / `r==b` / `r==a==b`, 정렬 offset 0/4/8/12/16 B
- oracle은 커널과 **다른 알고리즘**이다: 32-byte를 8×32-bit로 놓고 512-bit schoolbook 후
  `2^256 ≡ 38 (mod p)`로 접는다. 같은 방법을 두 번 쓰면 설계 오류를 못 잡기 때문이다.
- 추가로 단일-limb probe 100개(`a[i]=1, b[j]=1` 전 조합)가 **100/100 통과** — 19개 열
  각각의 자리·wrap 계수·×2 보정이 개별적으로 맞는다는 뜻이다.

### 11-3. 구현 중 발견한 사실

1. **`vmlaldav.u32`는 4 lane 전부의 내적이 맞다** — QEMU 직접 확인:
   `{1,2,3,4}·{10,100,1000,10000}` = `43,210`.
   (짝수 lane 2개만 쓰는 "dual" 해석이 아니었다. AM0 §7-1의 33개 회계가 유효하다.)
2. **누산기는 진짜 64-bit다**: 전 lane `0xFFFFFFFF` 제곱 = `0xFFFFFFF800000004`
   = `4·(2^32−1)^2`. 동시에 이는 **full 32-bit 피연산자로는 4 lane 합이 64-bit를 넘는다**는
   뜻이므로 §4의 26-bit radix 선택이 산술적으로 필요했음을 확인한다.
   ⚠ 이 두 항목은 **QEMU 확인**이며 실보드 확인은 AM1에서 한다(§10 위험 M5 유지).
3. **공유 `asm-practice/startup.s`는 CPACR을 켜지 않는다.** MVE 명령이 UsageFault로
   트랩되어 `Default_Handler` 무한루프에 빠진다(출력 없이 정지). QEMU 경로에서 MVE를
   쓰려면 진입점에서 CP10/CP11을 켜야 한다. 보드(FSP) 경로는 BSP가 이미 켠다.
4. **`-mfloat-abi=hard` 없이는 C 인라인 asm의 MVE가 어셈블 거부된다**
   (`selected processor does not support ... in Thumb mode`). 컴파일러가 `.fpu softvfp`를
   내보내기 때문이다. → **MVE 코드는 별도 `.S`에 두는 현재 구조를 유지한다.**
5. 구현 중 실제로 발생한 버그는 1건이었고 단일-limb probe가 정확히 짚어냈다:
   열 `k=18`(`i=j=9`, 둘 다 홀수 → ×2 보정 필요)에 `A2BUF` 대신 `ABUF`를 쓴 것.
   전 열 중 유일하게 틀렸고 결과는 `19` 대 정답 `38`이었다.

### 11-4. AM1 착수 조건 — 아직 실행하지 않음

다음이 남아 있으며 **사용자 확인 후** 진행한다.

- ITCM 퇴거(`fiat_u_stitch_m85.o` → flash) 및 그로 인해 값이 바뀌는 기존 슬롯 기록
- `harness.c`에 slot 333~342 추가, `REP_SLOTS` 333 → 343
- `harvest_ra8m1_expAL.py`(오늘 패치본)에서 `harvest_ra8m1_expAM1.py` 파생, `SLOT_N` 동기화
- 실보드 KAT(1,000 seed differential) 이식
- J-Link 단일 클라이언트 확보(e2 studio debugger 종료), 독립 flash/run 2회

**AM1-a(스루풋 마이크로 측정)를 먼저 돌려 `FLOOR_B1`을 구하는 것이 비용상 유리하다.**
정적 명령 수가 이미 A의 2.35배이므로 조기 종료 가능성이 높고, 그 경우 커널 측정 없이
음성 결과를 확정할 수 있다.
