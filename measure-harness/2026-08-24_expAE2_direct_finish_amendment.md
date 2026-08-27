# 실험 AE2 사전등록 보정 — 잔여 scalar queue tax 제거

AE 최초 두 실보드 실행은 정확성은 통과했지만 F→U가 keygen/encaps/decaps에서
각각 약 -15.6/-32.7/-14.9%였다. 사후 코드 감사에서, 융합 round가 끝난 뒤 남은
scalar ladder도 매 field-mul마다 `fiat_x25519_step()`의 queue 탐색과 `% job_count`를
통과하는 비대칭을 확인했다. F는 같은 구간을 `job_step()` direct loop로 실행한다.

이는 U 스티칭 비용이 아니라 잔여 scalar dispatcher 세금이므로 다음 한 가지만 바꾼다.

- 융합 구간: job 수가 1이면 job 0 direct, 2이면 두 job을 단순 교대한다.
- 잔여 구간: 각 job을 `job_step(..., fiat_mul_y11_scalar)` direct loop로 끝낸다.
- Fiat 산술, b1 assembly, 4:1/8:1 비율, X/Y/C8, x4, 입력, 슬롯, 정확성 gate는
  AE 사전등록과 동일하게 고정한다.

수정 전 실행은 dispatcher-tax 진단값으로만 보존하고, AE2 두 독립 실행을 최종
성능 판정에 사용한다.
