# 실험 CL 프로토콜 — expCK 분류 교정과 F/U 동적 명령 재감사

## 계기와 시간 순서

expCK 분류기가 `mnemonic.startswith("b")`를 사용해 `bic.w`를 branch/loop로 넣는 버그를
2026-08-28 코드 감사에서 발견했다. 총 명령 수는 바뀌지 않지만 클래스 벡터는 무효다.
버그 수정과 경계 단위검사 뒤 F 1-job과 U 1-job을 먼저 단일스텝했고, 그 결과를 본 뒤 이
문서를 썼다. 따라서 앞의 두 값은 사전등록 결과라고 부르지 않는다. 아래 2-job 절차와
판정 기준은 결과를 보기 전에 고정했다.

## 동결 대상

- ELF SHA-256: `305D7F40F5289852A5F683073B55D75135115BA7E2061379D31A3A3EF5BC9C60`
- SREC SHA-256: `06E4E4434214CB6371CE870E795FA61355174B53C303988B7364BF7B6DE18FE7`
- F: `x25519_u_bench_seq4`, `x25519_u_bench_seq8`
- U: `x25519_u_bench_fused4`, `x25519_u_bench_fused8`

## 고정 분류와 보존 형식

- branch/loop는 명시한 branch·low-overhead-loop mnemonic 집합으로만 분류한다.
- `bic`, `bfi`, `bfc`는 scalar ALU/shift, `bkpt`는 system이어야 한다.
- 경계 단위검사를 먼저 통과해야 한다.
- 각 실행은 총 명령 수, 클래스, **전체 mnemonic histogram**, **전체 PC histogram**,
  미분류 PC, ELF/SREC hash를 JSON으로 보존한다.
- JSON은 시간순 trace가 아니라 사후 재분류 가능한 완전 histogram이라고 부른다.

## 판정

1. F의 총 명령 수 105,310/195,900이 재현되는지 확인한다.
2. U의 총 명령 수와 `I_U-I_F`를 처음으로 보고한다.
3. 기존 동결 DWT cycle과 결합해 F/U 각각의 파생 IPC를 보고하되 같은 실행에서 동시
   계수한 PMU IPC라고 부르지 않는다.
4. 추가 명령 수만으로 cycle 차이를 인과적으로 전부 귀속하지 않는다.
5. 어떤 결과든 그대로 기록한다.
