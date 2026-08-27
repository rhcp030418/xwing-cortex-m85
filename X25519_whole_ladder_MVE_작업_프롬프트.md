# X25519 whole-ladder MVE 후속 연구 작업 프롬프트

> 목적: 이 파일 하나를 새 세션에 제공해도 A주제의 정본을 확인하고, EK-RA8M1
> Cortex-M85에서 X25519 전체 Montgomery ladder의 MVE 최적화 가능성을 안전하게
> 탐색할 수 있게 한다.
>
> 이 작업은 기존 U 스티칭을 조금 수정하는 일이 아니다. C/asm 경계·dispatcher·레지스터
> 양보 비용을 없애기 위해 X25519 전체 ladder를 하나의 장기 실행 커널 또는 이에 가까운
> custom-ABI 구조로 재설계하는 별도 고위험 연구 트랙이다.

---

## 1. 임무

EK-RA8M1(Cortex-M85, 480 MHz)에서 다음 질문에 답하라.

1. 현재 scalar X25519 기준선보다 빠른 MVE field multiplication을 만들 수 있는가.
2. 실제 임의 피연산자와 X25519 데이터 의존성을 보존하면서 1-job 또는 2-job을 MVE로
   처리할 수 있는가.
3. field-mul의 국소 이득이 carry/reduction/cswap/ladder 제어·상태 이동을 포함한 실제
   X25519 종단간에서도 남는가.
4. 성공한다면 X/Y/C8+C9 X-Wing 경로에 실제 통합했을 때 추가 이득은 얼마인가.

최종 결과는 성공·실패 어느 쪽이든 사전등록, 소스, ELF/SREC/map, 두 독립 실보드 로그,
결과 문서로 남긴다. 추정값을 실측값처럼 쓰지 않는다.

### 출력 파일

- 설계·조사: `A주제/measure-harness/2026-08-25_expAM_x25519_mve_design.md`
- 단계별 사전등록:
  - `2026-08-25_expAM1_mve_mul_prereg.md`
  - `2026-08-25_expAM2_mve_ladder_prereg.md` (AM1 통과 시에만)
  - `2026-08-25_expAM3_xwing_integration_prereg.md` (AM2 통과 시에만)
- 결과: 단계별 `2026-08-25_expAM{1,2,3}_results.md`
- 원시 로그: `A주제/measure-harness/logs/2026-08-25_expAM...run{1,2}.txt`
- 동결 아티팩트: `A주제/measure-harness/artifacts/2026-08-25_expAM*/`

`A주제/paper/`, `A주제_발표자료.html`, 기존 정본 수치는 사용자가 별도로 요청하기 전까지
수정하지 않는다.

---

## 2. 시작 전 필수 확인

다음 파일을 먼저 읽고, 충돌 시 최신 원시 로그·결과 문서·`논문_데이터_표.md` 순으로
판단한다.

1. `A주제/AGENTS.md`가 있으면 읽고, 없으면 프로젝트 루트 `AGENTS.md`
2. `A주제/PQC_스티칭_연구_로드맵.md` 상단 현재 상태와 최신 변경 이력
3. `A주제/A주제_총정리_육하원칙.md`
4. `A주제/논문_데이터_표.md`
5. 기존 U 실패·원인 귀속:
   - `measure-harness/2026-08-24_expAE_true_u_endtoend_prereg.md`
   - `measure-harness/2026-08-24_expAE2_results.md`
   - `measure-harness/2026-08-24_expAF_results.md`
   - `measure-harness/2026-08-24_expAI_results.md`
6. C9 후속 결과:
   - `measure-harness/2026-08-24_expAJ_results.md`
   - `measure-harness/2026-08-24_expAK_results.md`
7. 현재 e2 Studio 작업공간:
   - `C:\Users\cnscj\e2_studio\workspace\blinky`
   - 특히 `src/x25519/`, `src/fiat/`, `src/fiat_x25519.c`, `src/gen/`,
     `src/harness.c`, `Debug/blinky.map`

### 동시 작업 충돌 방지

- 작업 시작 전 `git status` 또는 파일 시간·해시로 live workspace 상태를 확인한다.
- **다른 세션이 harness.c 또는 `Debug/`를 수정 중이면 구현을 시작하지 않는다.** 동일 J-Link,
  `Debug/`, `harness.c`를 두 세션이 동시에 쓰지 않게 사용자에게 먼저 알린다. 확인법:
  `tasklist`에 e2studio/JLink/python이 없고, `src/harness.c`·`Debug/blinky.elf`의 수정 시각이
  세션 시작 전이면 진행한다.
- expAL은 2026-08-25 16:45에 측정·결과 채택까지 **완료**됐다(`2026-08-24_expAL_results.md`).
  `expAL_factorial.inc`, `run_expAL.ps1`, `expAL_tools.py`, `harvest_ra8m1_expAL.py`는 AM3의
  기준 파이프라인이므로 임의 삭제·덮어쓰기 금지. AM용 회수기는 **오늘 패치된
  `harvest_ra8m1_expAL.py`**(non-ASCII 경로 → ASCII 임시 사본 flash + sha 검증)에서 복사해
  파생한다. 구판 `harvest_ra8m1_expAL.withdrawn-full-integration.py`나 그 이전 회수기를
  잡으면 J-Link DLL 경로 실패가 재발한다.
- 편집 전 관련 파일을 `.bak-YYYYMMDD-HHMMSS-expAM`으로 백업한다.
- live workspace 밖의 별도 브랜치/복사본에서 AM 코드를 개발하고, 측정 직전에만 명시적으로
  통합하는 방식을 우선한다.

---

## 3. 기존 확정 사실 — 다시 주장하지 말고 출발점으로 사용

### 대표 성과

- **대표 종단간 정본(2026-08-25 expAL, 같은-ELF 2×2 완전 통합 X/Y/C8+C9):**
  keygen `4.29%`, encaps `4.16%`, decaps `7.71%`. 상호작용 ≈0(−249~+170cyc), 두 run
  재현, 전 게이트 PASS. 절대값(cell 00→11): keygen 796,0xx→761,8xx, encaps
  1,184,0xx→1,134,8xx, decaps 877,5xx→809,8xx cyc.
- 구성 요소(과거 별도 ELF 실측, 보존용): X/Y/C8 `+2.85/+1.54/+3.25%`, C9 MVE v1
  `+1.46/+2.67/+4.66%p`. 두 수의 단순 합은 혼합 장부이며 대표값으로 쓰지 않는다.
- **현재 대표 경로의 X25519는 Lenngren 8×32-bit asm**(`src/x25519/x25519-cortex-m4-gcc.s`,
  ITCM 배치, 단독 357,474cyc). Fiat 10×25/26(`src/fiat/`, carry_mul 288.68cyc)은 F/U
  트랙 전용이며 대표 경로에 있지 않다.

### 기존 U 스티칭 실패

- ITCM 교정 후 동일 Fiat 기준 실제 U 직접 통합 `F→U`:
  keygen `−1.98%`, encaps `−3.72%`, decaps `−1.88%`.
- 정확성은 성공했지만 성능은 실패하여 U는 기각됐다.
- 주요 원인:
  - 레지스터 양보 세금 약 `+12~13%`
  - scalar spill과 MVE load/store의 LSU 경합
  - fragment별 C/asm 경계와 상태 재구성
  - dispatcher/queue 비용
  - 최초 AE2의 U8 13.3 KiB flash 배치 오류(후속 AF에서 분리·교정)
- 따라서 AM은 `yield1+b1` fragment를 재사용해 호출 수만 늘리는 접근을 하지 않는다.

### 플랫폼

- EK-RA8M1, Cortex-M85 r0p2, CPUCLK 480 MHz.
- MVE/Helium, 16 KiB I-cache, 16 KiB D-cache, 64 KiB ITCM, 64 KiB DTCM.
- D-cache는 FSP 기본 비활성이고 hot data는 현재 DTCM이다.
- **ITCM 여유는 거의 없다**: 현재 expAL ELF(2026-08-25 16:42 `Debug/blinky.map`)의
  `__itcm_from_flash$$Limit = 0x0000e970` → 59.8/64 KiB, 여유 약 **4.2 KiB**. AK 시점은
  63.1/64 KiB였다.
  AM 커널을 ITCM에 넣으려면 이번 질문과 무관한 구실험 커널(`src/gen/exp*_board.s`)을
  flash로 옮겨 자리를 만들어야 하며, 옮긴 목록을 결과 문서에 남긴다(AF2-P 판례).
- RSIP-E51A는 공개 FSP API에서 X25519·SHA-3/SHAKE 가속을 제공한다고 확인되지 않았다.
  Ed25519 지원을 X25519 지원으로 간주하지 않는다.

---

## 4. 절대 원칙

1. **측정 전 사전등록**: 각 단계 구현·실보드 측정 전에 질문, 비교군, 단일변수, 정확성
   gate, 성능 gate, 실패 분기를 문서로 고정한다.
2. **가장 작은 게이트부터**: AM1 field-mul이 기준선을 명확히 이기지 못하면 whole-ladder를
   작성하지 않는다.
3. **실제 임의 피연산자**: 고정 피연산자·상수 반복 매크로커널만으로 성공 판정하지 않는다.
4. **표현 변환 포함**: 10×25/26, 8×32, MVE lane packing 사이 변환이 필요하면 실제
   종단간 경로의 timer 안에 포함한다.
5. **정확성 우선**: RFC 7748 KAT, differential oracle, random seed 다수, alias/alignment,
   canary/stack, full X-Wing output/reject까지 단계에 맞게 통과해야 한다.
6. **상수시간**: 비밀 의존 branch/table index/memory address를 금지한다. 정적 disassembly와
   최소 두 비밀 입력 trace/명령 수 동일성 검사를 보존한다.
7. **두 독립 run**: 성능 확정은 동일 ELF를 독립 flash/run 2회, N=100 중앙값,
   DWT CYCCNT, calib 차감, 가능하면 ABBA로 한다.
8. **분모 명시**: field-mul 국소 %, X25519 종단간 %, X-Wing 종단간 %를 섞지 않는다.
9. **기존 하네스 보존**: AJ/AK/AL 슬롯과 게이트를 깨지 않는다. 신규 슬롯 수와 회수기
   `SLOT_N`을 함께 갱신하고 build identity를 로그에 남긴다.
10. **실패를 숨기지 않음**: spill, ITCM 초과, lane 활용 저조, 변환 비용, 성능 회귀를
    그대로 결과로 기록한다.

---

## 5. 단계별 실행 계획

## AM0 — 설계·기준선 동결 (코드 작성 전)

다음을 `expAM_x25519_mve_design.md`에 기록한다.

1. 현재 X25519 구현 계보와 실제 대표 호출 경로:
   - Lenngren 8×32-bit인지 Fiat 10×25/26-bit인지
   - keygen/decaps 1 job, encaps 2 jobs의 호출 구조
   - field mul/square/carry/cswap/inversion의 호출 수 또는 정적 구조
2. 기준선 실측:
   - 기존 대표 X25519 scalar 약 357k cyc 계보를 원시 로그로 확인
   - 현재 같은 ELF에서 다시 측정할 기준 slot 설계
3. ABI·레지스터 예산:
   - MVE q0~q7, scalar r0~r12/lr의 역할
   - callee-saved q4~q7 및 r4~r11 저장 비용
   - 1-job coefficient-parallel과 2-job job-parallel 배치 후보
4. field representation 후보를 최소 2개 비교:
   - 기존 8×32 유지
   - 10×25/26 유지 또는 MVE 친화 radix(예: 5×51은 32-bit MVE에서 부적합 가능)
5. 정수 MVE 명령이 필요한 widened multiply/carry를 실제로 지원하는지 GCC assembler로
   최소 probe를 빌드해 확인한다. 명령 지원을 기억으로 단정하지 않는다. **probe 대상을
   최소 다음으로 고정**하고 각 항목을 "어셈블 OK/거부 + 실보드 1회 결과 일치"로 기록한다:
   - `vmullb.u32`/`vmullt.u32`: 32×32→64 곱 2개/명령. **누산 없음** — 후속 64-bit lane
     덧셈 명령이 MVE에 있는지(없다고 기억되지만 확인) 함께 probe.
   - `vmlaldava.u32`/`.s32`(및 `vrmlaldavh`): lane 내적을 **하나의 64-bit 스칼라 쌍
     (RdaLo:RdaHi)** 에 누산. 스쿨북 곱의 한 column = `Σ a[i]·b[k−i]` = 내적이므로
     이것이 사실상 유일한 승부처다. 26-bit radix면 10개 52-bit 곱 합이 64-bit 안에
     들어가는지 산술로 확인해 기록.
   - 역순 피연산자 공급: `vldrw` 음수 stride gather 또는 사전 역순 사본 중 비용이 낮은 쪽.
   - `vadd.i32`/`vsub.i32`/`vshr`/`vand`: coefficient-parallel carry/add/sub/cswap용.
   - low-overhead loop(`dls/le`)와 tail predication 생성 여부.

**lane 회계 원칙**: u32 lane은 4개뿐이다. `vmlaldava`류는 전 lane을 한 누산기로
환원하므로 **2-job job-parallel과 양립하지 않는다**. 2-job은 lane별 독립 64-bit 누산이
probe에서 확인될 때만 후보로 남기고, 아니면 AM0에서 기각 사유와 함께 제외한다.

AM0 결과에 따라 AM1 후보를 **하나 또는 최대 둘**만 선택한다. 광범위한 추상화·범용
라이브러리는 만들지 않는다.

**기능 검증 순서**: 후보 커널의 KAT·differential(≥1,000 seed)·경계값은 먼저 WSL
`qemu-system-arm -M mps3-an547`(Cortex-M55, MVE 지원, 이 머신에 설치됨)에서 돌려
통과시킨 뒤 보드에 올린다. QEMU는 **기능 전용**이며 cycle 값은 어떤 문서에도 쓰지
않는다. 목적은 J-Link 점유 시간과 flash 왕복 횟수를 줄이는 것이다.

## AM1 — 실제 field-mul feasibility gate

### 비교군

- A: **Lenngren `fe25519_mul`**(`src/x25519/x25519-cortex-m4-gcc.s`, 대표 경로가 실제로
  호출하는 것, ITCM). Fiat carry_mul(288.68cyc)은 A가 아니다 — Fiat 대비 이기고
  Lenngren 대비 지는 후보는 실패다. 필요하면 Fiat 대비값은 보조 열로만 둔다.
- B1: 1-job MVE 후보.
- B2: 2-job MVE 후보(AM0 lane 회계를 통과했을 때만).
- **코드 배치 단일변수**: A와 B는 **같은 배치(둘 다 ITCM)** 로 측정한다. ITCM 확보가
  불가하면 둘 다 flash로 옮겨 재측정하고 두 조건을 모두 보고한다. AF에서 U8 flash 배치
  하나가 −20%를 만들었으므로 배치가 다른 A/B 비교는 성능값으로 인정하지 않는다.

### 정확성 gate

- 최소 1,000개 결정적 임의 피연산자에 대해 scalar oracle과 전 coefficient/정규화 결과 일치.
- 경계값: 0, 1, p−1, carry 최대값, alias `r==a`, `r==b`, 정렬 offset.
- sanitizer는 host 참고용일 뿐이며 최종 판정은 Cortex-M85 실보드 KAT와 mismatch 0.
- `harness_fails=0`, stack/canary 0.

### 측정

- 같은 ELF ABBA, N=100 중앙값, 독립 2회.
- 단독 mul 외에 실제 ladder step에서 요구하는 mul+carry/reduction 묶음도 별도 측정.
- 2-job은 `2×scalar`를 분모로 하고 pack/unpack을 timer 안에 둔다.

### 사전 kill gate

- B1 또는 B2의 실제 mul+carry 묶음이 같은 작업 scalar 대비 **최소 15% 절감**하고,
  두 run 모두 부호가 같으며 모든 정확성 gate를 통과해야 AM2 진행.
- 5~15%면 보류: 정적 병목 1회만 수정 후 재측정 가능.
- 5% 미만 또는 회귀면 AM1 실패로 종료. whole-ladder를 추정으로 작성하지 않는다.

15%는 whole-ladder의 cswap/add/sub/inversion/제어 및 상태 비용으로 희석될 여지를 고려한
공학적 gate다. 근거 산수(**정적 추정, 미측정** — AM0에서 실측 슬롯으로 교체할 것):
Lenngren X25519 357,474cyc 중 ladder 255 step × (5M+4S) ≈ 2,295회 mul/sqr, 회당
~110~130cyc로 잡으면 mul/sqr 비중 ≈ 70~80%. mul 15% 절감 → 종단간 ≈ 10~12%로 AM2의
10% gate와 정합한다. 이 산수를 AM1 사전등록에 "추정" 표기로 박고 측정 후 변경하지 않는다.

## AM2 — whole-ladder 또는 persistent-state kernel

AM1 통과 시에만 사전등록 후 진행한다.

### 우선 설계

1. 2-job job-parallel이 AM1에서 이겼다면 encaps용 2-job ladder를 먼저 구현한다.
2. 1-job만 이겼다면 keygen/decaps용 1-job ladder를 먼저 구현한다.
3. 함수 내부에서 가능한 한 다음을 유지한다.
   - ladder state
   - scalar bit position
   - cswap mask
   - field temporaries
4. C로 매 field operation마다 복귀하지 않는다. 호출 경계는 ladder 전체 또는 긴 phase당
   1회로 제한한다.
5. ITCM이 부족하면 phase별 overlay는 별도 단일변수 실험으로만 사용한다. 복사·barrier·
   I-cache 유지 비용을 timer 밖으로 숨기지 않는다.

### 정확성 gate

- RFC 7748 공식 벡터 전부.
- 기존 scalar와 최소 1,000 seed differential test.
- low-order/invalid input 정책이 기존 구현과 동일.
- 1-job/2-job 각각 공개키와 shared secret byte 일치.
- 비밀 입력 두 벌 이상에서 cycle/trace/명령 수 동일성.
- stack/canary/alignment/mismatch 0, `harness_fails=0`.

### 성능 gate

- 실제 X25519 1회 또는 2회 전체를 같은 scalar 기준과 ABBA로 비교한다.
- AM2 성공: 두 run 모두 종단간 X25519 **10% 이상 절감**.
- 3~10%: 부분 성공, X-Wing 기여를 투영하지 말고 AM3 직접 통합 여부를 비용 대비 판단.
- 3% 미만/회귀/정확성 실패: 기각.

## AM3 — X-Wing 직접 통합

AM2가 성공 또는 명시적 부분 성공일 때만 진행한다.

- A: **expAL factorial cell 11**(X/Y/C8=1, C9=1) — 이미 same-ELF로 확정된 대표 경로.
- B: A와 동일하되 X25519만 AM2 후보로 교체.
- **새 하네스를 만들지 않는다.** `expAL_factorial.inc`에 X25519 토글 축 하나를 추가해
  2×2→2×2×2 또는 최소 `11`/`11+AM` 두 셀로 확장하고, `run_expAL.ps1`/`expAL_tools.py`
  파이프라인(강제 빌드→동결→2회 flash/run→readback→자동 보고)을 재사용한다. 기존
  4셀(00/01/10/11)의 값이 expAL 정본과 ±0.5%p 안에서 재현되는지가 하네스 무결성 gate다.
- X-Wing keygen/encaps/decaps 실제 wrapper ABBA, 독립 2회.
- 8개 이상 seed에서 pk/sk/ct/valid ss/reject ss 전 바이트 일치.
- 대표 결과는 `A−B`의 실제 종단간 실측만 사용한다.
- AM1·AM2 절감률을 호출 수로 곱한 값은 투영으로만 별도 보존한다.

---

## 6. 반드시 조사할 구현 선택지

다음은 후보이지 결론이 아니다. AM0에서 정적 명령·레지스터·lane 회계를 한 뒤 선택한다.

1. **2-job job-parallel**: encaps의 두 X25519를 lane 그룹에 나란히 배치. 데이터 의존성은
   job 내부에 남지만 서로 독립이므로 개념상 자연스러운 SIMD 후보. 단 AM0 lane 회계
   (u32 lane 4개, `vmlaldava`류의 전-lane 환원) 조건부.
2. **coefficient-parallel**: 한 field element의 limb 여러 개를 vector lane에 배치. carry
   propagation과 cross-lane shuffle 비용이 핵심 위험.
3. **square 전용 커널**: multiplication보다 대칭성을 활용할 수 있으므로 별도 이득 가능.
4. **batch inversion**: 프로토콜이 허용하고 동일 결과를 보존할 때만 2-job inversion을
   합치는 방안. 새 수학적 변형은 별도 정확성 논증 필요.
5. **custom ABI**: q/r callee-save를 매 fragment마다 저장하지 않고 전체 ladder 진입·종료에
   한 번만 저장. 기존 C ABI와 섞이는 내부 helper는 최소화.
6. **low-overhead loop/tail predication**: 실제 Cortex-M85 assembler·disassembly로 생성
   여부를 확인하고, 고정 255-bit loop에서 이득을 실측한다.

하지 말 것:

- RSIP의 Ed25519를 X25519로 간주해 호출하기.
- 고정 피연산자 매크로커널 수치만으로 whole-ladder 성능 주장하기.
- M55/M52/QEMU 값을 RA8M1 실측 대신 사용하기.
- 기존 U의 8.89% 투영치를 새 후보의 예상 성과로 재사용하기.
- AM1 kill gate 실패 후에도 결과를 키우기 위해 AM2를 강행하기.

---

## 7. 측정·아티팩트 체크리스트

각 유효 run마다 다음을 결과 문서와 원시 로그 양쪽에서 확인한다.

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
- [ ] 코드 크기와 ITCM 사용량
- [ ] 정적 disassembly에서 비밀 의존 branch/address 없음
- [ ] 실패·이탈·원 로그 미보관 항목 기록

Windows에서 J-Link는 단일 클라이언트다. e2 Studio debugger를 닫고 한 세션만 회수기를
실행한다. 기존 `harvest_ra8m1_exp*.py`를 복사해 슬롯 수와 이름을 명시적으로 갱신하고,
UTF-16 PowerShell 로그는 `rg` 또는 인코딩 감지 코드로 읽는다.

---

## 8. 종료 시 보고 형식

사용자에게 다음 순서로 간결하게 보고한다.

1. 단계 판정: AM1/AM2/AM3 성공·부분 성공·기각
2. 실제 실보드 대표 수치와 정확성 gate
3. 무엇이 빨라졌고 무엇이 비용을 먹었는지
4. X-Wing 대표값을 바꿀 수 있는지 여부
5. 생성·수정·백업·동결 파일 경로
6. 남은 미측정 위험

실패한 경우에도 “왜 MVE whole-ladder가 Cortex-M85에서 이기지 못했는가”를 명령 클래스,
lane 활용률, carry/shuffle, spill, code placement, ABI 비용으로 분해해 음성 결과로 남긴다.

---

## 9. 새 세션에 줄 첫 지시문

아래 문장을 이 파일과 함께 새 세션에 제공한다.

> `A주제/X25519_whole_ladder_MVE_작업_프롬프트.md`를 전문으로 읽고 시작하라.
> 먼저 동시 세션/harness.c/`Debug/` 충돌 여부를 확인하고, AM0 설계·현재 기준선 동결과
> AM1 사전등록까지만 완료한 뒤 field-mul 최소 프로토타입을 구현하라. AM1 kill gate를
> 실보드 두 run으로 통과하기 전에는 whole-ladder AM2를 시작하지 말라. 모든 수치는
> 실측·투영·미측정을 분리하고 기존 paper/발표자료는 수정하지 말라.
