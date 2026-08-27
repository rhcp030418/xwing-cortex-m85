# 실험 AD 결과 — AC 성능 악화 단일변수 분해

## 결론

AC의 손실은 재현 가능한 두 항의 합이다.

1. ML-KEM matrix-XOF의 3개 실제 스트림을 4-lane MVE에 넣고 한 lane을 dummy로
   채운 x4 경로가 연산당 약 25k cycles 느리다.
2. x4-only 경로에 AC의 b0 기반 X25519 스티칭을 켜면 X25519 1회당 약 32.4k
   cycles가 더 든다. 이 중 약 25.3~25.5k는 기존 진단 run에서 직접 측정한
   `fe25519_mul` dispatcher 세금이고, 남은 약 6.9~7.3k가 b0 삽입과 상태 관리의
   순손실이다.

따라서 AC는 논문 대표 U인 `yield1+b1`의 종단간 구현이 아니다. 생성기
`gen_exp_ac.py`는 `round_mve4_b0()`를 사용한다. AC의 실패는 U 선택 경로를
반증하지 않지만, AC를 U의 직접 통합 성능으로 인용해서도 안 된다.

## 직접 측정

S는 X/Y/C8 + scalar matrix-XOF + direct-call scalar X25519, X는 S에서 matrix-XOF만
3+dummy x4로 교체한 경로, B는 X에서 AC b0 스티칭을 켠 경로다. 동일 ELF에서
S→X→X→S와 X→B→B→X를 각각 N=100 중앙값으로 측정했다. 아래 값은 보수적으로
선택한 추가 비용이며, 모두 양수일수록 느리다는 뜻이다.

| 항 | 연산 | run 1 | run 2 |
|---|---|---:|---:|
| x4 배칭 `X−S` | keygen | 24,830 (3.16%) | 24,822 (3.16%) |
| | encaps | 25,120 (2.12%) | 25,125 (2.12%) |
| | decaps | 25,057 (2.93%) | 25,070 (2.93%) |
| AC b0 스티칭 `B−X` | keygen | 32,426 (4.00%) | 32,557 (4.02%) |
| | encaps | 65,118 (5.39%) | 65,130 (5.39%) |
| | decaps | 32,383 (3.68%) | 32,394 (3.68%) |
| 전체 `B−S` | keygen | 57,256 (7.29%) | 57,280 (7.29%) |
| | encaps | 90,227 (7.63%) | 90,231 (7.63%) |
| | decaps | 57,459 (6.73%) | 57,430 (6.72%) |

각 ABBA에서 독립적으로 보수값을 선택했기 때문에 부분합과 전체 차분의 차이는 최대
99 cycles다. 부호와 귀속 판정에는 영향이 없다.

## dispatcher 교차 대조

기존 invalid-baseline run은 scalar 기준선도 dispatcher를 통과했고, 정정 run은
direct-call을 사용했다. 두 기준선의 차이는 X25519 1회인 keygen/decaps에서
약 25.3~25.5k cycles, 두 번인 encaps에서 약 51.0k cycles였다. 이를 위 `B−X`에서
빼면 dispatcher 외 AC b0 삽입·상태관리 손실은 X25519 1회당 약 6.9~7.3k cycles다.

## 정확성·재현 정보

- 두 run 모두 primitive x4/AC-stitch KAT, 8-seed X-Wing pk/sk/ct/valid·reject 출력,
  ML-KEM roundtrip/reject, timing output와 stack canary 실패 0.
- 두 run 모두 `harness_fails=0`, stack high-water 9,192 B.
- ELF SHA-256: `A106F83DE24D1CDA120850420226F3A44AEFEF803542A6777F6E2D158C926A45`
- SREC SHA-256: `FF04C290270BE9815C9AD4206F41410194515068C162AAF3D7D78863227CF733`
- staged harness SHA-256: `3EBE11D6CD68CF416DC66A7640A8094C1E04A08079812B2D1844709FB2E40BF2`
- 사전등록: `2026-08-22_expAD_ac_decomposition_prereg.md`

펌웨어 로그의 `rep arrays ready x100 (205 slots)` 문자열은 이전 상수에서 남은 표시
오류다. ELF의 `rep_cyc` 심볼 크기 `0x165d0`과 회수기의 `SLOT_N=229`를 확인했으며,
AD 슬롯 205~228은 정상 회수됐다.

## 아직 분리하지 않은 범위

x4 경로의 약 25k 내부에서 dummy lane, pack/unpack, per-round 호출과 state copy가
각각 차지하는 비율은 미측정이다. 위 결과는 이들을 합친 x4 경로 전체의 직접 차분이다.
