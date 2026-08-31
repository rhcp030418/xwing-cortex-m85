# 실험 CK 사전등록 — 동일 Fiat+x4 기준 슬롯 회계

## 질문

2024/039 legacy 직접 통합에서 사용한 순차 기준형 F와 stitched U를 같은 구현·wrapper·링크
배치로 놓았을 때, F의 실제 스티칭 대상 구간에는 얼마의 듀얼이슈 여유가 있으며 그 낙관적
상한은 종단간 F→U 결과와 어떤 관계인가.

## 동결 대상

- ELF: `../2026-08-24_expAI/pre_expAI_blinky.elf`
  - SHA-256 `305D7F40F5289852A5F683073B55D75135115BA7E2061379D31A3A3EF5BC9C60`
- SREC: `../2026-08-24_expAI/pre_expAI_blinky.srec`
  - SHA-256 `06E4E4434214CB6371CE870E795FA61355174B53C303988B7364BF7B6DE18FE7`
- 이 두 파일은 실험 AF의 all-U ITCM 확정본이며 기존 F→U 대표 결과를 만든 바로 그
  바이너리다.

## 측정

1. EK-RA8M1에서 동결 SREC를 독립 2회 플래시한다. 각 실행의 N=100 중앙값에서 측정
   오버헤드 중앙값을 차감한다.
2. 종단간 F/U는 기존 ABBA 슬롯 217--228을 그대로 읽는다.
3. 실제 스티칭 대상의 순차 구간은 같은 ELF의 슬롯 229/232(1-job: x4 Keccak 24 rounds +
   Fiat ladder step 96개)와 233/236(2-job: 같은 Keccak + step 192개)을 읽는다.
4. 명령 수는 PMU event counter가 동작하지 않는 이 보드의 제약 때문에, 같은 M85
   컴파일러 산출물의 결정적 실행 경로를 에뮬레이션해 동적으로 센다. 실보드 DWT cycle과
   결합한 IPC·빈 슬롯은 혼합 계측 파생치로 표시한다.
5. 발행 클래스는 실행된 명령을 scalar ALU/shift, scalar multiply, scalar load/store,
   branch/system, MVE ALU/shift, MVE load/store로 분류한다. 분류 불명 명령은 별도 보고한다.

## 판정·정확성 게이트

- 두 실보드 실행 모두 `harness_fails=0`, x4/U KAT, X-Wing byte/smoke, stack/canary,
  AF state/output mismatch 0이어야 한다.
- 에뮬레이션은 1-job·2-job의 Keccak state와 X25519 출력이 동결 하네스의 reference와
  일치해야 하며 입력 2벌의 명령 수가 같아야 한다.
- `빈 슬롯 = 2×cycle − instructions`, `IPC = instructions/cycle`로 계산한다. 이 값은
  구조적 2-issue 용량의 낙관적 회계이며 실제 동시 발행 가능 슬롯과 동일하다고 단정하지
  않는다.
- 결과가 기존 주장과 반대여도 그대로 기록한다.

## 사후 방법 변경 기록 (측정 후 원문 불변, 2026-08-27)

사전등록 4항의 에뮬레이션 대신 실제 EK-RA8M1을 J-Link로 함수 입구부터 복귀까지
single-step해 동적 명령을 직접 셌다. 같은 ELF disassembly로 실행 PC를 분류했으며
1-job/2-job 모두 미분류 PC 0이었다. cycle과 명령 수가 모두 같은 보드·ELF에서 나오는
더 직접적인 방법이지만, 사전등록에 적은 에뮬레이터 두 입력 출력 대조는 수행하지 않았다.
정확성은 별도의 독립 2회 flash에서 KAT·F/U 출력·stack/canary·`harness_fails=0`으로
검증했다.

추가로 x4 공통 prefix를 hardware breakpoint DWT로 재고 한 명령어 대조 구간으로 debugger
고정비 존재를 확인했다. 고정비를 사후 추정해 빼지 않고 raw prefix cycle을 사용해 상한을
관대하게 유지했다. 동결 U의 배치 수는 `permute4`와 `x25519_u_enqueue` hardware
breakpoint 호출 수로 직접 확인했다. 전체 결과와 제외 probe는
`../../2026-08-27_expCK_results.md`에 기록했다.
