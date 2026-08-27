# expAM1 사전등록 — MVE field-mul feasibility gate

> **등록 시각: 2026-08-25 (구현·측정 착수 전).** 이 문서는 측정 후 수정하지 않는다.
> 수정이 필요하면 별도 amendment 파일로 남기고 사유를 적는다(expAE2 판례).
> 선행 문서: `2026-08-25_expAM_x25519_mve_design.md` (AM0).

---

## 1. 질문

EK-RA8M1(Cortex-M85, 480 MHz)에서 **MVE/Helium로 구현한 X25519 field multiplication이
현재 대표 경로의 scalar `fe25519_mul`(Lenngren 8×32, ITCM)보다 빠른가.**

부차 질문(판정 근거 분해용): M85에서 `vmlaldava.u32`·`vldrw.u32`의 실제 스루풋은 얼마이고,
같은 누산기 연속 사용이 스톨을 유발하는가.

---

## 2. 비교군 — 단일변수

| 군 | 내용 | 배치 |
|---|---|---|
| **A** | `fe25519_mul` — `src/x25519/x25519-cortex-m4-gcc.s`, 대표 경로가 실제 호출하는 것 | **ITCM** |
| **B1** | `fe25519_mul_mve` — radix 2^25.5 열-스캐닝, `vmlaldava.u32` (AM0 §7) | **ITCM** |
| ~~B2~~ | ~~2-job job-parallel~~ | **AM0 §6에서 기각 — 측정하지 않음** |

- Fiat `carry_mul`(288.68 cyc)은 **A가 아니다**. 필요하면 보조 열로만 병기한다.
  Fiat 대비 이기고 Lenngren 대비 지는 결과는 **실패**다.
- **코드 배치 단일변수**: A와 B1을 **둘 다 ITCM**에 둔다. ITCM 확보가 불가하면 **둘 다
  flash**로 옮겨 재측정하고 두 조건을 모두 보고한다. 배치가 다른 A/B 비교는 성능값으로
  인정하지 않는다(AF의 U8 flash 배치 −20% 판례).
- ITCM 확보가 필요하면 `src/gen/fiat_u_stitch_m85.o`(22,680 B, 기각된 U)를 flash로 옮긴다.
  **옮긴 오브젝트 목록과 그로 인해 값이 변하는 기존 슬롯을 결과 문서에 기록**하고,
  AM1 결과에서 U 계열 수치를 인용하지 않는다.

---

## 3. 실행 순서 — AM1-a 먼저, AM1-b는 조건부

프롬프트 §4-2 "가장 작은 게이트부터"의 직접 적용.

### AM1-a — 명령 스루풋 마이크로 측정 (커널 없이)

측정 대상(각각 언롤된 직선 코드, N=100 중앙값, calib 차감, ITCM 배치):

| slot | 내용 | 얻는 값 |
|---:|---|---|
| 337 | `vmlaldava.u32` ×64, **서로 다른 누산기 4개 순환** | 의존 없는 스루풋 `T_mac_free` |
| 338 | `vmlaldava.u32` ×64, **같은 누산기 1개 체인** | 의존 있는 스루풋 `T_mac_dep` |
| 339 | `vldrw.u32` ×64, 서로 다른 q, DTCM 원본 | `T_vldrw` |
| 340 | `vmullb.u32` ×64 | `T_vmull` |
| 341 | 스칼라 `umaal` ×64 (의존 체인 없음) | `T_umaal` — A의 코어 단가 |
| 342 | `vldrw.u32` ×32 와 스칼라 `ldr` ×32 교대 | LSU 경합 재현 여부 (로드맵 40차 대조) |

**AM1-a 조기 종료 조건 (사전 확정).**
B1의 **명령 수 하한**을 AM0 §7-3의 정적 회계로 고정한다:

```
FLOOR_B1 = 33·T_mac_dep + 50·T_vldrw + 135·1.0
           (열 내적)      (슬라이스 로드)  (스칼라 접기·carry, 1 cyc/명령 가정)
```

이 `FLOOR_B1`이 **`0.85 × (A의 mul+carry 묶음 실측)`을 초과하면**, B1은 어떤 스케줄링으로도
kill gate를 통과할 수 없으므로 **AM1-b(커널 측정)를 수행하지 않고 AM1을 실패로 종료**한다.
그 경우에도 정확성 gate는 QEMU 수준까지만 수행하고, 음성 결과를 프롬프트 §8 형식
(명령 클래스 / lane 활용률 / carry·shuffle / spill / code placement / ABI 비용)으로 기록한다.

> `FLOOR_B1`은 **하한**이다. 셋업(~35 명령), 열 누산기 초기화·저장(~18), 함수 진입/이탈
> 양보 세금은 포함하지 않았다. 따라서 실제 B1은 반드시 `FLOOR_B1`보다 느리다.

### AM1-b — B1 커널 실측 (AM1-a를 통과했을 때만)

slot 333~336. §5·§6의 gate를 전부 적용.

---

## 4. 사전 예측 — 측정 전 동결, 측정 후 변경 금지

프롬프트 §AM1이 요구한 "근거 산수를 추정 표기로 박고 측정 후 변경하지 않는다"의 이행.

### 4-1. 프롬프트 원문 산수 (보존)

> Lenngren X25519 357,474cyc 중 ladder 255 step × (5M+4S) ≈ 2,295회 mul/sqr, 회당
> ~110~130cyc로 잡으면 mul/sqr 비중 ≈ 70~80%. mul 15% 절감 → 종단간 ≈ 10~12%로 AM2의
> 10% gate와 정합한다. — **추정**

### 4-2. AM0의 정정 산수 (측정 전 확정) — **추정**

`x25519-cortex-m4-gcc.s` 저자 주석 기반 정적 분해(AM0 §1):

| 항목 | X25519 대비 |
|---|---:|
| `fe25519_mul` (1,287회) | **40.6%** |
| `fe25519_sqr` (계열 전체) | **27.1%** |
| mul + sqr | 67.7% |

- **`fe25519_mul`만 15% 절감 → 종단간 X25519 기여 = 6.1%.**
- AM2의 10% gate 도달에는 **sqr 커널이 필수**(`0.677 × 15% = 10.2%`).
- 따라서 **AM1을 통과해도 mul 단독으로는 AM2 10% gate에 산술적으로 도달 불가**하며,
  AM2 사전등록에는 sqr 커널이 반드시 포함되어야 한다.

### 4-3. B1 성능 사전 예측 — **추정, 판정 아님**

AM0 §7-3: 정적 명령 예산 **~230개** (MVE ~95 / 스칼라 ~135). MVE가 dual-beat라면
**≈250~350 cyc**. A는 저자 주석 M4 **173 cyc**(M85 값은 slot 333에서 처음 실측).

> **예측: B1은 AM1 kill gate를 통과하지 못한다(회귀 또는 5% 미만).**
> 근거: ① MVE에 64-bit lane 산술이 없어 접기·carry 전체가 스칼라로 남는다 ②
> 열 길이가 4의 배수가 아니어서 lane 이용률이 75.8%에 그친다 ③ 슬라이스 로드 트래픽이
> 스칼라 MAC 총량을 넘는다 ④ 스칼라 로드와 MVE 로드가 듀얼이슈되지 않음이 이미 실측됐다.
> **이 예측이 맞아도 AM1은 유효한 음성 결과이며, 틀리면 예측이 틀린 것으로 기록한다.**

---

## 5. 정확성 gate — B1

QEMU 선행 → 실보드 확정. **최종 판정은 Cortex-M85 실보드 KAT와 mismatch 0.**

### 5-1. QEMU (WSL `mps3-an547`, Cortex-M55) — 기능 전용, 사이클 인용 금지

- [ ] 결정적 임의 피연산자 **≥1,000개**에 대해 scalar oracle과 **전 limb 일치**
- [ ] 경계값: `0`, `1`, `p−1`, `p`, `2^255−1`, 각 limb 최대(carry 최대), 전 limb 최대
- [ ] alias: `r==a`, `r==b`, `r==a==b`
- [ ] 정렬 offset: 입력·출력 버퍼를 4/8/16 B 경계에 각각 배치

### 5-2. 실보드 (EK-RA8M1)

- [ ] 위 1,000-seed differential을 보드에서 재실행, **mismatch 0**
- [ ] 경계값·alias·정렬 케이스 **mismatch 0**
- [ ] 기존 전체 KAT `ALL PASS`, 기존 전체 mismatch 0 (회귀 없음)
- [ ] `harness_fails=0`
- [ ] stack canary fails=0, high-water 기록

### 5-3. 상수시간

- [ ] 정적 disassembly에 비밀 의존 branch / table index / memory address 없음
- [ ] 최소 두 벌의 비밀 입력에서 cycle 동일성 (slot 333~336 각각)

sanitizer는 host 참고용일 뿐 판정 근거가 아니다.

---

## 6. 성능 측정 절차

- 같은 ELF **ABBA** (A→B→B→A), **N=100 중앙값**, DWT CYCCNT, calib 차감
- **독립 flash/run 2회**, 두 run 모두 같은 부호
- 단독 mul(slot 333/335) **외에** 실제 ladder step이 요구하는 **mul + carry/reduction 묶음**
  (slot 334/336)을 별도 측정한다. **kill gate 판정은 묶음 쪽으로 한다.**
- B1은 1-job이므로 분모는 `1×scalar`다. pack/unpack(8×32↔10×25/26)은 **AM1 범위 밖**이며
  (AM1은 mul 내부만 본다) AM2에서 timer 안에 넣는다 — 이 사실을 결과에 명시한다.
- **분모 명시**: AM1의 %는 전부 **field-mul 국소 %**다. X25519 종단간 %·X-Wing 종단간 %와
  섞지 않는다.

---

## 7. Kill gate — 사전 확정

**판정 대상 = mul+carry 묶음(slot 334 대 336), 두 run 모두.**

| 조건 | 판정 |
|---|---|
| B1이 A 대비 **≥15% 절감**, 두 run 부호 동일, §5 정확성 gate 전부 통과 | **통과 → AM2 사전등록 진행** |
| **5% 이상 15% 미만** | **보류** — 정적 병목 **1회만** 수정 후 재측정. 재측정도 15% 미만이면 실패 |
| **5% 미만 또는 회귀** | **AM1 실패로 종료.** whole-ladder를 추정으로 작성하지 않는다 |
| 정확성 gate 1개라도 실패 | **AM1 실패** (성능값 무효) |

추가 확정 사항:

- AM1-a의 `FLOOR_B1`이 `0.85 × A(묶음)`을 넘으면 §3의 조기 종료를 적용한다.
- **AM1 통과 시에도** §4-2에 따라 mul 단독으로는 AM2 10% gate 도달이 불가하므로,
  AM2 사전등록은 **sqr 커널 포함**을 전제로 작성한다.
- 보류(5~15%)에서 허용되는 "정적 병목 1회 수정"의 범위를 미리 못박는다:
  셋업 명령 축소, 슬라이스 로드 재사용, 열 스케줄 재배치, 누산기 배분 변경. **표현
  변경(radix)·알고리즘 변경·gate 정의 변경은 불허**하며 그 경우 새 사전등록이 필요하다.

---

## 8. 실패 분기

1. **AM1-a 조기 종료**: 커널 측정 없이 종료. 음성 결과를 프롬프트 §8 형식으로 기록.
2. **정확성 실패**: 원인(캐리 경계 / 오버플로 / alias / 패딩)을 특정해 기록. 성능값 폐기.
3. **성능 실패(<5% 또는 회귀)**: AM2·AM3 착수하지 않음. 결과 문서에 명령 클래스별 분해
   (MVE MAC / MVE 로드 / 스칼라 접기 / 스칼라 carry / 셋업 / ABI)를 남긴다.
4. **ITCM 확보 실패**: A·B 둘 다 flash로 내려 재측정하고 두 조건 모두 보고. 배치가
   섞인 비교는 폐기.
5. 어느 경우든 **AM2를 시작하지 않는다.**

---

## 9. 산출물 — 이 실험이 남길 것

- 사전등록: 이 문서
- 소스: `measure-harness/expAM-src/` (커널·oracle·QEMU 테스트)
- 결과: `2026-08-25_expAM1_results.md`
- 원시 로그: `logs/2026-08-25_expAM1_run{1,2}.txt`
- 동결 아티팩트: `artifacts/2026-08-25_expAM1/` — ELF/SREC/map/source SHA-256, 회수기 SHA-256,
  code-flash readback SHA-256
- 회수기: `harvest_ra8m1_expAM1.py` — **오늘 패치된 `harvest_ra8m1_expAL.py`에서 복사 파생**
  (non-ASCII 경로 → ASCII 임시 사본 flash + sha 검증 포함). 구판
  `harvest_ra8m1_expAL.withdrawn-full-integration.py` 계열을 쓰지 않는다.
  `SLOT_N`을 `REP_SLOTS`와 함께 갱신하고 slot 1(기존 X25519 N=100)도 출력하도록 한다.

## 10. 체크리스트 (프롬프트 §7)

- [ ] ELF/SREC/map/source SHA-256
- [ ] flash 직전 build identity
- [ ] `KAT ALL PASS`
- [ ] 신규 AM mismatch 0
- [ ] 기존 전체 mismatch 0
- [ ] `harness_fails=0`
- [ ] stack-fails=0과 high-water
- [ ] N=100 중앙값, min/max, calib
- [ ] AB/BA 두 방향
- [ ] 독립 flash/run 2회
- [ ] 함수 주소와 flash/ITCM 배치
- [ ] 코드 크기와 ITCM 사용량 (퇴거 목록 포함)
- [ ] 정적 disassembly에서 비밀 의존 branch/address 없음
- [ ] 실패·이탈·원 로그 미보관 항목 기록

J-Link는 단일 클라이언트다. e2 studio debugger를 닫고 **한 세션만** 회수기를 실행한다.
