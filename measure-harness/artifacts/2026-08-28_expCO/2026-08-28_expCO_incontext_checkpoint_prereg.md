# 실험 CO 사전등록 — keygen/decaps in-context checkpoint 확장과 interrupt 통제

> 날짜: 2026-08-28
> 동기: 리뷰어3 재심 P0-2 — "세 `permute4` in-context checkpoint 실측 → 배치 손실 vs
> wrapper 손실 분리". 실험 AI가 encaps만 분해했고 keygen/decaps는 `미측정`이었다.
> 부수 동기: 리뷰어3 P1-2.4 — timed span 안의 interrupt가 통제되지 않았다.

## 1. 질문

**Q1.** keygen과 decaps에서도 `F→U` 손실이 스티치된 **융합 구간 안**에서 발생하는가,
아니면 `finish_all`·queue·상태 접근 같은 **잔여 구간**에서 발생하는가?

**Q2.** 격리 phase-0 배치 단가를 세 번 곱한 투영(1-job 5.83~5.87k cycle)이 keygen과
decaps의 실제 in-context 손실 중 몇 %를 설명하는가?

**Q3.** timed span 안의 interrupt가 종단간 중앙값을 유의하게 오염시키는가?

## 2. 정의 (측정 전에 고정)

한 연산 반복 안에서 DWT CYCCNT를 세 지점에서 읽는다. `dwt_span_end()`는 `dwt_span_begin()`
이후 누적값을 돌려주므로 구간값은 차분으로 만든다.

| 구간 | keygen | encaps | decaps |
|---|---|---|---|
| **융합** | `crypto_kem_keypair` | `crypto_kem_enc` | `crypto_kem_dec` |
| **잔여** | `x25519_u_finish_all()` (U) / `curve25519_scalarmult_fiat()` (F) | 좌동 (U1은 finish_all + fiat 1회) | 좌동 |
| **총** | 잔여 뒤 `memcpy` 포함 | 잔여 뒤 `xwing_combine` 포함 | 좌동 |

- `mlkem_keccakx4_mode=1`은 F/U/U1 모두에 건다. 따라서 x4 배칭은 상대효과에서 상쇄된다.
- U 모드에서 X25519 job은 span 시작 **전에** enqueue한다. enqueue 비용은 측정 밖이다.
- 기타 = 총 − 융합 − 잔여. 부호와 크기를 그대로 기록하고 귀속하지 않는다.

## 3. 셀 배치

`EXPCO_SLOT_BASE = 775`, 셀당 3슬롯(총/융합/잔여), `REP_N = 100` 중앙값.

| 그룹 | 순서 | 슬롯 |
|---|---|---|
| keygen | F, U, U, F | 775, 778, 781, 784 |
| decaps | F, U, U, F | 787, 790, 793, 796 |
| encaps | F, U, U, F | 799, 802, 805, 808 |
| encaps (1-job 대조) | F, U1, U1, F | 811, 814, 817, 820 |
| IRQ 마스킹 | keygen F, encaps F, decaps F | 823, 826, 829 |

- A-B-B-A로 단조 drift를 상쇄한다. 독립 flash/run **2회**.
- keygen/decaps는 X25519 job이 하나뿐이므로 U1 = U이며 별도 셀을 두지 않는다.
- IRQ 마스킹 셀은 `__disable_irq()`를 timed 반복 전체에 걸고 F 모드만 잰다. 같은 ELF
  같은 위치의 비마스킹 F 셀(775 / 799 / 787)과 중앙값을 비교한다.

## 4. 사전 예측 (반증 가능하게)

- **H1 (부호 구조):** keygen·decaps에서도 융합 구간 차분 `U−F`는 **양수**, 잔여 구간
  차분은 **음수**다. encaps(AI: 융합 +197.9k / 잔여 −171.7k)와 같은 구조.
  *반증:* 잔여 차분이 양수이거나 융합 차분이 음수면 H1 기각. 그 경우 논문의
  "손실은 융합 구간 안에서 났다"는 문장을 encaps 한정으로 되돌린다.
- **H2 (투영의 설명력):** 격리 3× 투영 5.83~5.87k는 keygen·decaps in-context 융합 손실의
  **50% 미만**을 설명한다. encaps 1-job에서 22%였다.
  *반증:* 90~110% 사이면 투영이 사실상 정확하다는 뜻이므로 논문의 "투영일 뿐" 경고를
  약화해야 한다.
- **H3 (interrupt):** IRQ 마스킹이 중앙값을 **0.1% 미만** 바꾼다.
  *반증:* 0.1% 이상이면 기존 모든 종단간 백분율에 interrupt 교란 한계를 명시한다.

투영과 실측이 어긋난 몫은 **원인 미측정**으로 남긴다. phase 1·2 시작, q-레지스터 보존,
상태 접근, cache 중 무엇인지는 이 실험이 구분하지 못한다.

## 5. 정확성 게이트

한 run이라도 실패하면 그 run의 성능값을 폐기한다.

- 기존 전체 하네스: RFC 7748 4종, SHA3/SHAKE KAT, ML-KEM roundtrip/reject, x4·U primitive
  KAT, 8-seed X-Wing full output/reject, `harness_fails=0`.
- 신규: 그룹 안 첫 셀의 최종 출력을 기준으로 나머지 세 셀의 pk/sk(keygen),
  ct/ss(encaps), ss(decaps) 바이트 mismatch가 0.
- `x25519_u_queue_pending()`와 `x25519_u_failures()` 합이 0.
- stack canary fail 0, high-water 기록.

## 6. 배치·범위 한계 (측정 전에 인정)

- 이 ELF는 checkpoint 코드와 새 슬롯 배열 때문에 동결 expCK ELF와 링크 배치가 다르다.
  따라서 **절대 cycle을 논문 `tab:final`과 섞지 않는다.** 구간 차분 해석에만 쓴다.
- 보드는 여전히 EK-RA8M1 한 대다. 두 번째 개체는 미보유.
- cold boot 반복은 별도 실험(CQ)에서 다룬다.

## 7. 산출물

- 결과: `2026-08-28_expCO_results.md`
- 원시 로그: `logs/2026-08-28_expCO_run{1,2}.txt`
- 동결: `artifacts/2026-08-28_expCO/` (ELF/SREC/map/SHA256SUMS/소스)
