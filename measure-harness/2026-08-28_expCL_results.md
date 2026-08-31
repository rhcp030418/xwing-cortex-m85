# 실험 CL 결과 — expCK 분류 교정과 F/U 동적 명령 재감사

## 결론

동결 AF의 F 총 명령 수 105,310/195,900은 재현됐다. 기존 클래스 표는 분류기의
`startswith("b")` 버그 때문에 `bic.w` 2,316/4,632개를 branch/loop로 잘못 셌으므로
철회한다. 수정 분류기로 F/U 네 경로를 모두 실보드 단일스텝한 결과, U는 F보다
1-job에서 979명령(+0.930%), 2-job에서 2,200명령(+1.123%) 많았다. 따라서 U는 동일
명령열의 순수 재배열이 아니다.

## 동결 계보와 검증

- ELF SHA-256: `305D7F40F5289852A5F683073B55D75135115BA7E2061379D31A3A3EF5BC9C60`
- SREC SHA-256: `06E4E4434214CB6371CE870E795FA61355174B53C303988B7364BF7B6DE18FE7`
- 분류 단위검사: 3/3 PASS.
- 네 실행 모두 정상 return까지 완료, 미분류 PC 0.
- 각 JSON에서 class/mnemonic/PC histogram의 합이 총 명령 수와 일치한다.
- JSON은 실행 순서를 보존한 trace가 아니라 사후 재분류 가능한 완전 histogram이다.

## 결과

클래스 순서는 `(scalar load/store, scalar ALU/shift, scalar multiply/MAC,
MVE load/store, MVE ALU/shift, branch/loop)`다.

| 구간 | F 명령 | U 명령 | U−F | F 파생 IPC | U 파생 IPC |
|---|---:|---:|---:|---:|---:|
| 1-job | 105,310 | 106,289 | +979 (+0.930%) | 1.235888–1.236091 | 1.219358–1.219778 |
| 2-job | 195,900 | 198,100 | +2,200 (+1.123%) | 1.275590–1.275706 | 1.211769–1.211828 |

- F 1-job: `(43,656, 30,120, 15,574, 7,392, 7,416, 1,152)`
- U 1-job: `(44,024, 30,599, 15,574, 7,448, 7,512, 1,132)`
- F 2-job: `(86,884, 60,446, 31,532, 7,392, 7,416, 2,230)`
- U 2-job: `(87,849, 61,333, 31,532, 7,544, 7,608, 2,234)`

정상 실행의 기존 동결 cycle 범위는 F/U가 1-job 85,196–85,210 / 87,138–87,168,
2-job 153,562–153,576 / 163,472–163,480이다. U의 명령 증가율보다 cycle 증가율
(2.28–2.30% / 6.45–6.46%)이 크고 파생 IPC도 낮다. 그러나 명령과 cycle은 동시에 센
PMU 표본이 아니며 stall 원인도 미측정이므로, 어느 차이에 cycle 손실을 인과적으로
귀속하지 않는다.

## 원시 파일

- `logs/2026-08-28_expCL_icount_seq4.json`
- `logs/2026-08-28_expCL_icount_fused4.json`
- `logs/2026-08-28_expCL_icount_seq8.json`
- `logs/2026-08-28_expCL_icount_fused8.json`
- `artifacts/2026-08-27_expCK_fiatx4_slot_accounting/jlink_icount_frozen_af.py`
- `artifacts/2026-08-27_expCK_fiatx4_slot_accounting/test_jlink_icount_frozen_af.py`
- `summarize_expCL.py`
