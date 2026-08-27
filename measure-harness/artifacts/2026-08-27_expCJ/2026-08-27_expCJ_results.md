# 실험 CJ 결과 — draft-10 최종 누적 동일-ELF A/B

> 측정 2026-08-27. EK-RA8M1(Cortex-M85, 480 MHz), DWT CYCCNT, REP_N=100 중앙값,
> 같은 ELF의 A-B-B-A, 독립 flash/run 2회. 사전등록:
> `2026-08-27_expCJ_draft10_cumulative_prereg.md`.

## 1. 결론

draft-10 준거 기준형 A에서 채택 최적화 7개를 모두 켠 최종형 B로 바꿨을 때의
**동일-ELF 누적 실측 개선률**은 다음과 같다. 대표값은 두 run × 두 ABBA 쌍의 네 값 중
최솟값이다.

| 연산 | A 범위 (cyc) | B 범위 (cyc) | **보수적 누적 개선률** |
|---|---:|---:|---:|
| keygen | 870,398–870,412 | 644,346–644,390 | **25.967%** |
| encaps | 1,321,225–1,321,235 | 1,053,684–1,053,691 | **20.249%** |
| decaps warm | 934,141–934,160 | 829,297–829,306 | **11.224%** |
| decaps cold | 1,801,440–1,801,455 | 1,471,808–1,471,818 | **18.298%** |

따라서 “개별 최적화는 빨랐지만 전체 누적은 미측정”이라는 유보는 해소됐다.
keygen과 encaps는 20%를 넘었고, warm/cold decaps는 20%에 못 미쳤다.

## 2. A/B의 정확한 차이

두 셀은 draft-10 combiner 순서, packed 32-byte secret key, 64-byte encapsulation seed,
FIPS 203 encapsulation-key check가 동일하다.

- A: 기존 ML-KEM NTT/invNTT/store, scalar C9, 일반 X25519 ladder, 원본 mul/sqr,
  newlib-nano memcpy/memset.
- B: X/Y/C8, MVE C9 v1, X06 fixed-base comb, X01 mul, X02 sqr, K31 워드 memcpy/memset.

런타임 디스패처는 A/B가 모두 부담한다. 따라서 위 A/B 절대 cycle은
dispatcher-free expBU 대표값을 대체하지 않으며, **누적 상대효과만 정본**이다.

## 3. 두 독립 run의 전 수치

| 연산 | run1 A1→B1 | run1 A2→B2 | run2 A1→B1 | run2 A2→B2 |
|---|---:|---:|---:|---:|
| keygen | 870,402→644,352 (**25.971%**) | 870,404→644,374 (**25.968%**) | 870,398→644,346 (**25.971%**) | 870,412→644,390 (**25.967%**) |
| encaps | 1,321,235→1,053,684 (**20.250%**) | 1,321,233→1,053,687 (**20.250%**) | 1,321,229→1,053,691 (**20.249%**) | 1,321,225→1,053,685 (**20.249%**) |
| decaps warm | 934,141→829,297 (**11.224%**) | 934,160→829,304 (**11.225%**) | 934,152→829,306 (**11.224%**) | 934,155→829,306 (**11.224%**) |
| decaps cold | 1,801,455→1,471,818 (**18.298%**) | 1,801,440→1,471,812 (**18.298%**) | 1,801,446→1,471,808 (**18.299%**) | 1,801,442→1,471,810 (**18.298%**) |

- 같은 run 앞/뒤 동일 모드 최대 drift: **0.00683%** < 0.3% gate.
- 독립 run의 같은 ABBA 위치 개선률 최대 차이: **0.00116%p** < 0.3%p gate.

## 4. 유효성 gate — 전부 PASS

| 검사 | 결과 |
|---|---|
| RFC 7748 · FIPS 203 · SHA3/SHAKE · 전체 하네스 | **PASS**, `harness_fails=0` (두 run) |
| A/B 8-seed pk/sk/ct/enc-ss/warm/cold | **mismatch 0** |
| 정상 smoke · cold=warm | **0 failure / mismatch 0** |
| 훼손 ciphertext 암묵적 거부 | **mismatch 0** |
| timed 셀 마지막 출력 | **mismatch 0** |
| stack canary / high-water | **0 failure / 11,560 B** |
| 독립 flash/run · ABBA 재현성 | **PASS** |
| code-flash readback | 두 run 동일 SHA-256 `386A7ACD…BBCF5` (853,584 B) |

## 5. 자원과 지문

- `.text` 846,028 B / `.data` 7,572 B / `.bss` 393,740 B.
- ELF SHA-256: `E9D32784763383FAFB6E8C4ABDC832E6B50C17E9113B4C20A88C5832FD57E334`.
- SREC SHA-256: `AC0F88F2123DD14DB54911759F492DFC0C952283BA773276700B003627E83AD0`.
- SREC의 code-flash data record만 이어 읽은 보드 readback SHA-256:
  `386A7ACDAD0A744F985095D08D3D0915CA487854BD0D2C0E66DE4E3DA32BBCF5`.

동결: `artifacts/2026-08-27_expCJ/` — ELF/SREC/map/link args, 전체 `src/`, harvester,
사전등록, 두 원시 로그, `SHA256SUMS.txt`.

## 6. 해석 한계

1. 절대 cycle 정본은 디스패처를 제거한 expBU의 keygen 627,069 / encaps 988,456 /
   decaps warm 780,020 / cold 1,406,887이다. expCJ의 절대값과 섞지 않는다.
2. expCJ는 최종 누적 효과를 한 번에 재므로 일곱 요소의 개별 기여나 상호작용은 분리하지 않는다.
3. EK-RA8M1 한 개체, 현재 code/data placement에 한정한다.
4. draft-10 공식 벡터의 shared secret은 완전 일치하지만, 원문에서 확보하지 못한 pk/ct
   전체 바이트 대조는 기존과 같이 미완이다.

## 7. 정직 기록

첫 빌드는 새 측정 슬롯 때문에 DTCM이 2,080 B 넘쳐 링크 실패했다. 이전 실험이 끝난 뒤
쓰지 않는 슬롯 570–585와 기존 reference scratch를 재사용해 추가 DTCM 할당을 없앴다.
다음 빌드에서 기존 2,464 B reference secret-key 버퍼의 `sizeof`가 draft-10의 32 B보다
큰 것을 컴파일러 경고로 발견했고, 측정 전에 `D10_SKBYTES`로 고쳤다. 두 실패 빌드는
보드에 올리지 않았다.

