# 실험 AA/AB 결과 — C8 ordering fusion과 실제 X-Wing 종단간 차분

## 결론

- C8은 scalar `rev4`를 consumer마다 가르치는 대신, 이미 pqmx에 있는
  `ntt_kyber_1_23_45_67_opt_m85`의 MVE structure-store 경로를 재사용해 forward가
  current bit-reversed order를 직접 내도록 구현했다. basemul/matacc/serialization은
  그대로이며 forward 뒤 `rev4`는 없다.
- EK-RA8M1에서 두 번 독립 flash/run한 결과 C8의 full ML-KEM conservative 절감은
  keygen **3,908~3,952**, encaps **1,858~1,866**, decaps **3,906~3,937 cycles**였다.
  사전 gate 2,500/1,250/2,500을 모두 넘어서 **강한 성공**이다.
- 실제 X-Wing wrapper까지 조립해 측정한 X/Y/C8의 종단간 절감은 keygen
  **22,637~22,651**, encaps **18,046~18,052**, decaps **28,280 cycles**이고,
  전체 대비 각각 **2.85/1.54/3.25%**다.
- 실험 U와 기존 4-way MVE Keccak은 같은 ELF에 들어 있지만 실제 X-Wing 호출 경로에는
  아직 들어가지 않았다. 따라서 U+MVE Keccak까지 포함한 “완전 통합 20%”는 아직
  실측 결과가 아니다.

## 실험 AA — C8 full ML-KEM ABBA

비교는 A=`2+3+2 forward + scalar rev4`, B=`1+2+2+2 current-order forward`이고
inverse는 양쪽 모두 실험 Y 후보로 고정했다. 각 값은 N=100 중앙값이며 표의 절감은
`min(A1-B1, A2-B2)`다.

| run | keygen 절감 | encaps 절감 | decaps 절감 |
|---|---:|---:|---:|
| 1 | 3,952 | 1,858 | 3,937 |
| 2 | 3,908 | 1,866 | 3,906 |

두 run 모두 다음이 같았다.

- 8-seed pk/sk/ct/valid ss/reject ss byte mismatch 0
- ML-KEM roundtrip/reject, X25519/SHA3 KAT 통과
- timing mismatch 0, stack canary failure 0, alignment bitset 257/257
- stack high-water 6,536 B, `harness_fails=0`

## 실험 AB — 실제 X-Wing wrapper 종단간 ABBA

X-Wing keygen/encaps/decaps를 ML-KEM-768 + X25519 + SHA3-256 combiner로 한 함수에
조립했다. 포맷은 pk 1,216 B, sk 2,464 B, ct 1,120 B, ss 32 B이고 combiner 입력은
`\.//^\ || ss_M || ss_X || ct_X || pk_X` 134 B다. A는 기존 NTT, B는 X/Y/C8이며
X25519와 Keccak은 양쪽 모두 기존 scalar 구현이다.

| run | 연산 | A1 baseline | B1 candidate | A2 baseline | B2 candidate | conservative 절감 | baseline 대비 |
|---|---|---:|---:|---:|---:|---:|---:|
| 1 | keygen | 795,416 | 772,779 | 795,417 | 772,765 | 22,637 | 2.85% |
| 1 | encaps | 1,175,624 | 1,157,572 | 1,175,622 | 1,157,566 | 18,052 | 1.54% |
| 1 | decaps | 869,196 | 840,908 | 869,190 | 840,910 | 28,280 | 3.25% |
| 2 | keygen | 795,437 | 772,767 | 795,428 | 772,777 | 22,651 | 2.85% |
| 2 | encaps | 1,175,616 | 1,157,570 | 1,175,632 | 1,157,564 | 18,046 | 1.54% |
| 2 | decaps | 869,206 | 840,910 | 869,204 | 840,924 | 28,280 | 3.25% |

두 run 모두 8-seed X-Wing pk/sk/ct/valid ss/reject ss byte mismatch 0,
roundtrip/reject 통과, timing mismatch 0, stack canary failure 0, stack high-water 6,728 B,
`harness_fails=0`이었다. 따라서 X/Y/C8의 실제 X-Wing 분모 기여는 확정됐다.

## 현재 20% 장부와 남은 구현

기존 U + 독립 MVE Keccak + X/Y 혼합 장부에 AA의 보수적 추가 절감만 반영하면
keygen/encaps/decaps **16.82/15.61/16.13%(평균 16.19%)**다. 이것도 U/MVE가
미통합인 투영 장부이며, 20%까지 각각 약 **25.2k/51.6k/33.6k cycles**가 남는다.

완전 통합을 위해 남은 코드는 다음 두 덩어리다.

1. 현재 U 커널은 고정 전역 operand의 fiat field multiplication 한 번과 Keccak round
   한 번을 붙인 매크로 커널이다. 이를 임의 operand를 받는 완전한 X25519 ladder의
   field-mul 호출 경로와 순열 큐에 이식해야 한다.
2. 현재 MVE 커널은 Iota 상수 1을 쓰는 단일 round 반복 시험이다. 24개 round constant를
   쓰는 기능 등가 Keccak-f1600x4, absorb/squeeze/pack API를 만들고 ML-KEM의
   43/44/44 permutation을 실제 4-way batch로 재구성해야 한다.

이 두 구현 없이 microkernel을 호출 횟수만큼 덧붙이는 것은 같은 암호 연산이 아니므로
종단간 통합 수치로 보고하지 않는다.

## 재현 파일과 해시

- AA 로그: `logs/2026-08-21_expAA_c8_run1.txt`, `logs/2026-08-21_expAA_c8_run2.txt`
- AB 로그: `logs/2026-08-21_expAB_xwing_run1.txt`, `logs/2026-08-21_expAB_xwing_run2.txt`
- AB ELF SHA-256: `B82CD3049D93C5848FB36D00758E48127288D962E6254155F9E4C8775E851B38`
- AB SREC SHA-256: `77ED8C0748F5754157CB2F6B2FD03E00D971C318E39FEC5DD48A4E626EAADB6A`
