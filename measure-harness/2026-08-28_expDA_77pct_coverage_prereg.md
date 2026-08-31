# 사전등록 — 실험 DA: keygen 배칭 가능 상한 33/43(77%) U 후보

> 작성 2026-08-28, **구현·빌드·측정 전**. 출처: expCP 결과 §5–6의 미측정 항목.

## 1. 질문

expCP는 `permute4` 5회, 실제 배칭 순열 15/43(35%)까지만 측정했다. ML-KEM-768 keygen의 행렬 XOF 9개 스트림은 각각 거부표본 때문에 약 3블록을 쓰지만, 기존 x4 경로는 각 스트림의 첫 블록만 함께 만들고 이후 블록을 `matacc_asm.S` 안에서 scalar `shake128_squeezeblocks`로 보충한다.

행렬 XOF의 처음 3블록을 모두 x4로 생성하여 PRF 6스트림 배칭과 합치면, 실제 배칭 순열을 **33/43(76.7%)**까지 올릴 수 있다. 이 상한에서도 U가 대응 F보다 느린가를 직접 묻는다.

## 2. 구현 고정

- 기존 x4 행렬 경로의 lane 구성(실제 3 + dummy 1)은 유지한다.
- `xof_batch3`가 스트림당 SHAKE128 블록 3개(504 B)를 `shake128x4_squeezeblocks(..., 3, ...)`로 만든다.
- scalar 경로의 168 B 버퍼와 원본 `matacc_asm_*`는 바꾸지 않는다.
- x4 경로만 호출하는 `matacc_asm_*_x4` 여섯 함수를 기계적으로 복제하고, 재충전 경계를 168→504 B로 바꾼다. 504 B를 소진한 드문 경우에는 기존 scalar 재충전으로 돌아간다.
- PRF x4 경로(expCP)는 그대로 유지한다.

비교군:

| 이름 | 행렬 XOF | PRF | 예상 `permute4` | 실제 배칭 순열 |
|---|---|---|---:|---:|
| F9/U9 | 3블록 x4 | scalar | 9 | 27/43 |
| F11/U11 | 3블록 x4 | x4 | 11 | 33/43 |

F는 같은 Fiat ladder를 순차 실행하고 U는 같은 ladder step을 Keccak x4 조각과 겹친다. 각 비교는 같은 ELF·같은 ML-KEM 작업끼리만 한다.

## 3. 측정

- 보드 EK-RA8M1 1대, DWT CYCCNT, REP_N=100, 셀별 중앙값·IQR·p05/p95·평균.
- 각 coverage에서 F/U/U/F(ABBA), 각 셀은 total/fused/residual 세 구간.
- 독립 flash/run 2회.

## 4. 사전 고정 게이트

### 4.1 정확성

하나라도 실패하면 성능값을 폐기한다.

1. scalar keygen 대 F11/U11의 pk/sk 바이트 동치: 결정적 seed 8개, mismatch 0.
2. `KAT ALL PASS`, `harness_fails=0`, timing 최종 pk/sk mismatch 0.
3. stack canary fail 0, high-water 보고.
4. 실제 배치 수 F9/U9=9, F11/U11=11. 다르면 coverage 명칭을 쓰지 않는다.

### 4.2 성능 판정

- 주 추정량은 AB와 BA 각각의 중앙값 `U11−F11` 및 융합 구간의 옮긴 작업당 비용이다.
- `U11−F11 < 0`이 두 순서에서 모두 나오면 77% 후보는 이득으로 판정한다.
- 하나라도 `U11−F11 >= 0`이면 이득 없음으로 판정한다. 평균은 F baseline 꼬리의 영향을 받으므로 보조값으로만 보고한다.
- 예측: expCP 3→5배치에서 비용/옮긴 cycle가 1.290×→1.261×였으므로, 11배치에서도 1.0×보다 커서 U11이 F11보다 느리다. 외삽식으로 수치를 고정하지는 않는다.

### 4.3 상수시간

배치 수, 세 블록 길이, dummy lane, 재충전 조건은 공개 seed로 생성되는 거부표본 경로다. 비밀키 의존 분기나 주소를 새로 넣지 않는다. 기존 dudect 결과를 새 후보의 결과로 재사용하지 않으며, 이번 실험은 기능·cycle gate다.

## 5. 산출물

- 원로그 `logs/2026-08-28_expDA_run{1,2}.txt`
- 결과 `2026-08-28_expDA_results.md`
- 동결 `artifacts/2026-08-28_expDA/`: ELF/SREC/map, 변경 소스, 생성기, harvest, 해시.
