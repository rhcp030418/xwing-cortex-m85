# 사전등록 — 실험 CZ: 현재 연결 보드의 주 표 F/U 동결본 재확인

> 작성 2026-08-28, **측정 전**. 사용자가 현 시점의 재평가에 앞서 영문 문체를 제외한 측정 항목을 다시 확인해 달라고 요청하였다.

## 1. 질문과 범위

- 현재 USB에 연결된 장치에서 주 표 F/U 동결 이미지를 다시 플래시·실행해 결과와 정확성 게이트가 재현되는가?
- 이 실험은 **두 번째 보드 시험이 아니다**. 탐지된 J-Link는 1대뿐이며 일련번호는 `1086545529`이다.
- 소프트웨어로 전원을 차단하는 장치가 없으므로 **전원 재인가(power cycle)는 미측정**이다. 각 run은 독립 flash와 리셋·실행이다.

## 2. 고정 대상

- MCU: J-Link 보고 장치 `R7FA8M1AH`, Cortex-M85 CPUID `0x410fd232`, core ID `0x6ba02477`.
- ELF: `artifacts/2026-08-24_expAI/pre_expAI_blinky.elf`
  - SHA-256 `305D7F40F5289852A5F683073B55D75135115BA7E2061379D31A3A3EF5BC9C60`
- SREC: `artifacts/2026-08-24_expAI/pre_expAI_blinky.srec`
  - SHA-256 `06E4E4434214CB6371CE870E795FA61355174B53C303988B7364BF7B6DE18FE7`
- 수확기: `artifacts/2026-08-27_expCK_fiatx4_slot_accounting/harvest_frozen_af.py`
  - SHA-256 `0E82ADDF7E302BB3892ED0EB0FA3A1449D1DFD361550FF00279AA010F58FDA38`
- 실행 래퍼: `run_harvest_logged.py`
  - SHA-256 `62E20A46A02CE52A35FB89CAB4065EA5B0CB1A47F925712C0ED86AC8686286EA`
- 위 네 파일과 하네스 설정을 바꾸지 않고 독립 flash **2회** 실행한다.

## 3. 측정 전 고정 게이트와 판정

각 run에서 다음을 모두 만족해야 유효하다.

1. `harness_fails=0` 및 `KAT ALL PASS`.
2. F/U의 keygen, encaps, decaps 측정이 모두 완주한다.
3. 새 대응표본 감소율이 기존 expCV 다섯-flash 범위
   (keygen −1.987~−1.974%, encaps −3.719~−3.714%, decaps −1.883~−1.877%)를 벗어나는지 기록한다.

예측: 두 run 모두 정확성 게이트를 통과하고 세 효과는 기존 범위 안에 든다. 하나라도 벗어나면 기존 범위를 조용히 덮어쓰지 않고 원자료와 함께 별도 변동으로 보고한다.

## 4. 산출물

- 원로그: `logs/2026-08-28_expCZ_run{1,2}.txt`
- 결과: `2026-08-28_expCZ_results.md`
- 기존 동결 이미지를 재사용하므로 새 바이너리는 만들지 않는다.
