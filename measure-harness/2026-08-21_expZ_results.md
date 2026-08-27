# 실험 Z 결과 — X+Y 동시 적용과 비-Keccak 귀속

## 한 줄 결론

X와 Y는 동시에 적용해도 절감이 사라지지 않았다. 다음 구현은 C9가 아니라 **C8
basemul/matacc fusion**으로 진행한다. 다만 20% 달성 자체는 아직 실측된 결과가 아니다.

## Z1 — X+Y 동시 full-operation ABBA

EK-RA8M1 Cortex-M85에서 baseline(current forward+inverse)과
candidate(pqmx forward+rev4 + M85 inverse+rev4)를 동일 함수·stack·RNG로 ABBA N=100,
두 번 flash/run했다.

| 연산 | run 1 conservative 절감 | run 2 conservative 절감 | isolated X+Y 보존율 |
|---|---:|---:|---:|
| keygen | 18,851 cycles | 18,851 cycles | 100.42% |
| encaps | 16,155 cycles | 16,155 cycles | 99.86% |
| decaps | 24,502 cycles | 24,500 cycles | 101.22~101.23% |

run 1의 baseline→candidate 중앙값은 keygen 437,655→418,804,
encaps 452,860→436,705, decaps 503,981→479,479 cycles였다. 즉 NTT X+Y만의
full-operation 개선은 각각 4.31%, 3.57%, 4.86%다.

두 run 모두 8-seed pk/sk/ct/valid ss/reject ss byte mismatch 0, smoke 0,
alignment 동일, timing byte mismatch 0, stack canary 0, stack high-water 6,536 B,
`harness_fails=0`이었다. 사전 등록한 90% 보존 strong-pass 조건을 전 연산에서 통과했다.

## Z2 — 별도 profiler build의 비-Keccak 직접 귀속

성능용 Z1 바이너리와 분리한 계측 빌드에서 target assembly와 CBD/packing 함수의
DWT cycle을 바로 전후에서 측정했다. 동일한 8개 seed마다 profiler OFF 결과와 ON 결과를
byte 비교했고 두 번 flash/run했다. 아래 값은 operation당 8-seed 평균이다.

`matacc-nonkeccak = matacc-asm raw - (내부 Keccak permutation 수 × 5,526 cycles)`로
계산했다. C8은 matacc-nonkeccak + basemul + frombytes-mul, C9는 CBD + packing이다.

| 연산 | C8 run 1 | C8 run 2 | C9 run 1 | C9 run 2 |
|---|---:|---:|---:|---:|
| keygen | 67,961 | 67,988 | 33,773 | 33,775 |
| encaps | 71,586 | 71,599 | 47,406 | 47,406 |
| decaps | 81,492 | 81,514 | 59,146 | 59,145 |

세부 run 1은 다음과 같다.

| 연산 | matacc raw | 내부 Keccak perms | matacc non-Keccak | basemul | frombytes-mul | CBD | packing |
|---|---:|---:|---:|---:|---:|---:|---:|
| keygen | 167,429 | 18 | 67,961 | 0 | 0 | 13,292 | 20,481 |
| encaps | 167,413 | 18 | 67,945 | 3,641 | 0 | 15,350 | 32,056 |
| decaps | 167,514 | 18 | 68,046 | 3,643 | 9,803 | 15,349 | 43,797 |

두 run 모두 profiler OFF/ON byte mismatch 0, `harness_fails=0`이었다. run 간 C8 차이는
최대 27 cycles, C9 차이는 최대 2 cycles였다.

## 판정과 다음 작업

- C8 사전 gate는 encaps 또는 decaps 10,000 cycles 이상이었다. 실제값은
  71.6k/81.5k cycles이므로 큰 폭으로 통과했다.
- 따라서 다음 구현은 **같은 pqmx ordering을 유지하면서 rev4를 consumer 쪽에 흡수하는
  basemul/matacc fusion(C8)**이다.
- C9도 작지 않지만 후순위다. C8이 구현 후 실제 full-operation ABBA에서 충분히 회수되지
  않을 때 packing/CBD MVE를 추가한다.
- 현재 15.82%는 여전히 U + 입력 MVE Keccak + X/Y의 혼합 장부다. Z1은 그중 X+Y의
  동시 보존만 확정했다. C8을 구현해 전체 파이프라인으로 다시 재야 20%를 주장할 수 있다.
- 일반성은 아직 EK-RA8M1 M85 한 보드에서만 실측됐다. C8의 ordering/fusion 원리는 MVE
  코어에 이식 가능하지만 수치 일반화는 다른 M85와 M55/M52 실측 전까지 주장하지 않는다.

## 재현 자료

- Z1 로그: `logs/2026-08-21_expZ_combined_ntt_run{1,2}.txt`
- Z2 로그: `logs/2026-08-21_expZ_nonkeccak_profile_run{1,2}.txt`
- Z2 계측 소스: `expZ_prof_matacc_staged.c`, `expZ_prof_poly_staged.c`,
  `harness_expZ_prof_staged.c`
- Z1 ELF/SREC SHA-256:
  `6F04F673BCD34E8BE14FC84D2283B2FA76CBDDF6E12FD59FA1CB3F4D0D8F0357`,
  `0BA91C3FE9461BFBE6EA071F406FF8D35D7AE1F57036D2BC95F615CD27A090B2`
- Z2 ELF/SREC SHA-256:
  `C130784ED3AC238D09CBE8C6628E81BDFBAFAC3F810EE4440AFE0B24BA844017`,
  `9E6D43490D1CE362FA71ADED150A71BBB0C4EC5B214789051D3039A944D6A8DA`
- 최종 live e² 프로젝트는 profiler를 제거한 순수 X+Y 상태로 복원했고 clean build 0 errors,
  ELF/SREC가 위 Z1 hash와 일치한다.
