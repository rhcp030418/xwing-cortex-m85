# expDJ 사전등록: 최초 all-off A0 대 2단계 최종 B8의 단일 동일-ELF 비교

- 대상: EK-RA8M1 Cortex-M85, 480 MHz, draft-10 X-Wing.
- 목적: 서로 다른 하네스였던 1단계와 2단계를 합산하지 않고, 최초 A0와 최종 B8을
  하나의 ELF와 동일 코드·데이터 배치에서 직접 비교한다.

## 모드

- A0: X/Y/C8, C9, X06, X01, X02, K31을 모두 끄고 scalar cswap과 독립 affine
  inversion을 사용한다.
- B8: 여섯 1단계 축을 모두 켜고 MVE cswap과 zero-safe paired inversion을 사용한다.
- keygen에는 2단계 두 변환의 적용 지점이 없으므로 B8 keygen은 1단계 all-on과 같다.
- 비교용 scalar/MVE mode 조회는 같은 ELF의 양쪽에 존재하며 측정값에 포함한다.

## 측정과 게이트

- 셀 순서는 A0--B8--B8--A0, 셀당 각 연산 100회, even-sample median.
- 독립 재플래시 5회. 네 연산의 두 A0와 두 B8 셀을 모두 보존하고 범위를 보고한다.
- RFC 7748/SHA3 KAT, 8개 결정적 draft-10 입력의 pk/sk/ct/enc/warm/cold/reject
  바이트 동치, warm/cold 일치, 저차점 3종 비교와 `harness_fails=0`이 모두 필요하다.
- B8이 keygen/encaps/warm/cold 모두에서 A0보다 빠른 경우에만 최종 직접 비교를 PASS로
  기록한다. 이전 두 단계의 개선률은 이 결과에 더하거나 곱하지 않는다.
- 별도 canary 실행으로 A0/B8의 연산별 stack high-water와 하단 64 B guard를 측정한다.
  이는 동일 비교 ELF의 경로별 stack이며 dispatcher-free footprint를 대신하지 않는다.

