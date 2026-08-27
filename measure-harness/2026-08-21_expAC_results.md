# 실험 AC 결과 — b0 기반 X25519 스티칭 + Keccak-f1600x4/SHAKE x4 + ML-KEM 배칭

## 결론

정확성은 전부 통과했지만 성능은 세 연산 모두 악화됐다. 따라서 AC candidate는
최종 펌웨어에 채택하지 않고, 기존 X/Y/C8 경로를 유지한다.

| 연산 | run 1 conservative | run 2 conservative | 판정 |
|---|---:|---:|---|
| keygen | −57,274 cyc (−7.30%) | −57,322 cyc (−7.30%) | 실패 |
| encaps | −90,318 cyc (−7.64%) | −90,325 cyc (−7.64%) | 실패 |
| decaps | −57,473 cyc (−6.73%) | −57,463 cyc (−6.73%) | 실패 |

여기서 음수 절감은 candidate가 그만큼 더 느리다는 뜻이다. A는 X/Y/C8 + 기존
scalar Keccak/X25519, B는 같은 X/Y/C8 + AC 구현이다. 같은 ELF, 같은 입력, N=100
중앙값, ABBA 순서로 비교했다.

## 구현 범위

- AC 스티칭: 실제 Lenngren X25519 ladder의 임의 피연산자 `fe25519_mul` 호출에 24-round
  MVE permutation을 라운드당 8개 곱으로 분할해 삽입했다. scalar 기준선은 별도
  direct-call 경로로 보존해 dispatcher 비용이 A에 섞이지 않게 했다.
- Keccak: 24-round Keccak-f1600x4, SHAKE128x4 absorb/squeezeblocks, one-shot
  SHAKE128x4/SHAKE256x4 API를 구현했다.
- ML-KEM-768: 행렬 XOF의 독립 3개 스트림을 x4의 3개 lane에 넣고 네 번째 lane은
  dummy로 채웠다. 여러 독립 ML-KEM 요청 네 개를 배칭한 것은 아니며, 단일 X-Wing
  요청 내부의 동시 독립 스트림만 묶었다.
- X-Wing: keygen/encaps/decaps에서 X25519 작업을 각각 1/2/1개 queue하고 ML-KEM의
  첫 x4 permutation과 실제로 겹쳤다.

## 검증

- Keccak/SHAKE x4 대 scalar KAT: mismatch 0
- U RFC 7748 public/shared-secret KAT: mismatch 0
- 8-seed X-Wing pk/sk/ct/valid/reject 출력: mismatch 0
- ML-KEM roundtrip/reject, timing workload, canary: 실패 0
- stack high-water: 9,264 B
- 두 run 모두 `harness_fails = 0`
- 빌드: 0 errors, 293 warnings

## 재현물

- run 1: `logs/2026-08-21_expAC_final_run1.txt`
- run 2: `logs/2026-08-21_expAC_final_run2.txt`
- 사전 등록: `2026-08-21_expAC_u_keccakx4_final_prereg.md`
- 생성기: `../slothy-2stream/gen_exp_ac.py`
- staged source: `expAC-src/keccakx4.c`, `expAC-src/keccakx4.h`,
  `expAC-src/matacc.c`, `expAC-src/x25519-cortex-m4-gcc.s`,
  `expAC-src/keccakx4_round_m85.S`
- 하네스/회수기: `harness_expAC_staged.c`, `harvest_ra8m1_expAC.py`

최종 빌드 해시:

- ELF SHA-256: `407B18A38E7B5DB03A6C03E6AC3A500F342CB4496F73BE70F7550C9794DF3AD4`
- SREC SHA-256: `6561126BB35B6003B67DFC75496A9C39BACC57FAB7637FDDF1F97A2EAA809D18`

## 2026-08-22 독립 재현

위와 동일한 ELF/SREC를 EK-RA8M1에 다시 플래시하여 독립 run 두 번을 추가로
수행했다. 각 값은 N=100 중앙값 ABBA의 보수 차분이며, 음수는 통합 후보가
X/Y/C8 기준선보다 느리다는 뜻이다.

| run | keygen | encaps | decaps |
|---|---:|---:|---:|
| 3 | −57,313 cyc (−7.30%) | −90,314 cyc (−7.64%) | −57,460 cyc (−6.73%) |
| 4 | −57,319 cyc (−7.30%) | −90,312 cyc (−7.64%) | −57,468 cyc (−6.73%) |

두 run 모두 primitive KAT, 8-seed X-Wing pk/sk/ct/valid·reject 출력 비교,
ML-KEM roundtrip/reject, timing workload와 stack canary를 통과했고
`harness_fails=0`, stack high-water는 9,264 B였다. 따라서 정확성 통과와
성능 실패 판정은 기존 두 run과 동일하게 재현됐다.

## 제외한 진단 run

첫 두 run은 A도 `fe25519_mul` dispatcher를 통과해 scalar 기준선에 약 25.5k cycles의
세금이 섞인 것을 사후 감사에서 발견했다. 즉시 기각하고 로그명을
`expAC_invalid_dispatch_tax_run{1,2}.txt`로 바꿨다. scalar direct-call과 AC clone을
분리한 뒤 위의 두 최종 run을 새로 측정했다.

사후 코드 감사에서 이 경로는 논문 대표 U의 `yield1+b1`이 아니라 생성기의
`round_mve4_b0()`를 사용하는 b0 기반 통합 후보임을 확인했다. 따라서 AC를 U의 직접
통합값으로 인용하지 않는다. 후속 실험 AD가 x4 배칭과 AC b0 스티칭의 개별 손익을
분리했으며, 상세는 `2026-08-22_expAD_results.md`를 따른다.
