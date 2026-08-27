# 실험 AF 사전등록 — 현재 세대 B-full 재현 및 U4/U8 손실 분해

## AF1: B-full 현재 아티팩트 재현

질문은 2026-08-16 기록의 수동 지퍼 `681` 대 솔버 `657` 우위가 현재 아티팩트에서도
재현되는가이다. 현재 `stitch_zip.py`가 만드는 B 명령 644개와 `exp_b.s`에 내장된 마지막
644개를 비교해 완전 일치를 확인했다. 따라서 “솔버가 옛 B를 내장했다”는 가설은 기각하고,
현재 ELF를 변경하지 않은 채 실보드 독립 실행 5회를 수집한다. 이 문서 작성 전에 수행한
1회는 탐색용이며 확정 표본에서 제외한다.

- 보드: Renesas EK-RA8M1, Cortex-M85, SWD 4 MHz
- ELF SHA-256: `54448E01EA503E7A3571923CEE3162311080C9C4E6A69AEF6C1C25D355904109`
- SREC SHA-256: `F2C94BB63058FF7B67DCBAD68048D8884BA3620E6C3DB363A400F3C532809FF5`
- 측정: 각 실행 N=100 중앙값, DWT 오버헤드 중앙값 차감
- 대상: `bfull_seq`, `bfull_slothy`, 현재 수동 `stitched-round6-v6`, 각 단독 A/B
- 정답성: 모든 mismatch, KAT, stack/canary와 `harness_fails=0`
- 판정: 5회 범위와 중앙값을 보고하며, 솔버-수동 차이가 ±1% 이내면 사전등록 허용오차
  안의 동률로 해석한다.

AF1은 소스 세대가 같은지를 먼저 고정하는 재현 실험이다. 역사값은 역사값으로 남기며 현재
값으로 덮어쓰지 않는다.

## AF2: 실제 U4/U8 배치 손실 단일변수 분해

질문은 AE2의 2-job encaps 추가 손실 약 332k cycles가 U8 융합 배치 자체에서 재현되는가이다.
같은 초기 Keccak 4-way state와 같은 Fiat X25519 job 상태에서 다음 네 경로를 비교한다.

1. 1-job 순차: Keccak 24 rounds + `fiat_mul_y11_scalar`를 사용한 ladder step 96개
2. 1-job U4: 같은 Keccak 24 rounds와 같은 ladder step 96개를 U4 fragment로 융합
3. 2-job 순차: Keccak 24 rounds + 같은 scalar ladder step 192개
4. 2-job U8: 같은 Keccak 24 rounds와 같은 ladder step 192개를 U8 fragment로 융합

배치 준비, queue enqueue, 입력 복사는 측정 밖에 둔다. 실제 `permute4` 경계 비용인
pack/unpack, round-constant staging, U의 q-save/restore는 측정에 포함한다. 각 경로는 N=100,
ABBA 순서로 두 번 이상 독립 실행한다.

- `P4 = cycles(U4) - cycles(1-job 순차)`
- `P8 = cycles(U8) - cycles(2-job 순차)`
- `P8 - 2*P4`를 2-job 고유 추가 손실로 보고한다.

정답성 gate는 (a) 융합/순차 Keccak state 전 바이트 일치, (b) 잔여 ladder direct finish 뒤
RFC 7748 기대 출력 일치, (c) queue failure 0, (d) stack/canary 0, (e) 전체
`harness_fails=0`이다. 하나라도 실패하면 성능값을 기각한다.

추가로 end-to-end에서 U4/U8 batch 수, 실제 job step 수, ladder 완료 후 dummy step 수를
계수한다. 이 계수는 원인 귀속용이며 사전등록된 성능 판정은 위 네 경로의 실측 차분이다.

### AF2-P: 코드 배치 통제 추가 (counter pilot 뒤, 확정 성능 측정 전)

계수용 pilot에서 U4/U8은 모두 dummy 없이 3개 배치만 실행됐지만, U8의 동일작업 손실이
U4의 약 18배로 나타났다. ELF를 확인하니 기존 hot kernel은 ITCM `0x0000...`에 있는 반면
AE/AE2의 `fiat_u_stitch_m85.S`만 일반 code flash `0x02083e00...`에 배치되어 있었다.
또한 U4 전체 코드는 약 7.9 KiB, U8은 약 13.3 KiB라 instruction working-set 차이가 크다.

따라서 확정 측정 전에 같은 명령열의 **배치만** 바꾸는 통제를 추가한다.

- Flash 조건: 기존 `.text` 배치.
- ITCM 조건: U assembly만 `.itcm_code_from_flash`로 이동한다.
- 공간 확보를 위해 이번 질문과 무관한 실험 E 커널만 ITCM에서 flash로 이동한다. 그 외
  ML-KEM/X/Y/C8/U 코드와 데이터는 바꾸지 않는다.
- map에서 U4/U8 주소가 `0x000...`인지, 총 ITCM이 64 KiB 안인지 확인한다.
- 양 조건 모두 같은 AF2 네 경로, KAT와 end-to-end gate를 실행한다.

ITCM 조건에서 U8 고유 손실이 크게 줄면 AE2의 추가 약 332k는 스티칭 원리보다 잘못된
코드 배치와 큰 instruction working set의 상호작용으로 귀속한다. 줄지 않으면 fragment 구조
자체의 비용으로 남긴다. 계수용 pilot의 성능값은 계수 increment가 들어갔으므로 최종값으로
쓰지 않는다.

### AF2-P2: U8-only ITCM 확인 (AF2-P 결과 뒤, 측정 전 기록)

AF2-P에서 약 95% 감소를 확인했지만 ITCM 공간 확보를 위해 무관한 실험 E를 flash로 옮겼다.
배치 원인을 더 엄밀하게 닫기 위해 E를 원래 ITCM으로 복구하고, scalar/U4/qsave 경로는
Flash 조건 그대로 둔 채 **U8 p0~p7만 ITCM**으로 옮긴다. 13.3 KiB U8은 기존 잔여 ITCM에
들어간다. U8-only 조건을 독립 2회 측정하며, 주소·ITCM limit·KAT를 다시 확인한다.

이 조건에서 U8 batch와 encaps만 크게 개선되고 U4/keygen/decaps가 Flash 조건에 머물면,
변수는 U8 instruction fetch 배치 하나로 닫힌다.
