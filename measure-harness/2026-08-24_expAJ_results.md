# 실험 AJ 결과 — C9(packing·CBD·msg) MVE화

> 날짜: 2026-08-24  
> 사전등록: `2026-08-24_expAJ_c9_mve_prereg.md` (측정 전 작성, 이탈 없음)  
> 보드: EK-RA8M1 Cortex-M85 480MHz, DWT CYCCNT, N=100 중앙값, calib 25 차감, ABBA  
> 원시 로그: `logs/2026-08-24_expAJ_c9_mve_run{1,2}.txt`

## 판정

**강한 성공.** 두 독립 flash/run 모두에서 세 연산의 conservative 절감이 전부
양수였고, 사전등록 cycle 게이트(keygen ≥8k / encaps ≥12k / decaps ≥15k)를 전부
상회했으며, 정확성 게이트 전체를 통과했다.

같은 ELF 안의 단일변수 `X/Y/C8(c9=0) → X/Y/C8+MVE C9(c9=1)` 차분이므로 이 값은
**X/Y/C8 대표 경로 위에 C9가 추가로 회수한 실측분**이다. 기존 대표값과의 산술
합산(약 4.3/4.2/7.9%)은 서로 다른 ELF·시드의 값을 더한 **혼합 장부**로만 취급하며,
대표 종단간 값 교체는 이 문서에서 선언하지 않는다.

## 구현 요약

- `src/mlkem/poly_mve.c` 신설: GCC 13.2.1 `arm_mve.h`(Helium) 내장함수 C 구현.
  교체 함수 11종 — `cbd`(eta2, add 포함), `poly_tobytes/frombytes`(12비트),
  `poly_packcompress/unpackdecompress`(10비트, du), `poly_compress/decompress`
  (4비트, dv), `cmp_poly_packcompress/cmp_poly_compress`(재암호화 비교),
  `poly_frommsg/tomsg`.
- 토글 `volatile uint32_t mlkem_c9_mode`(0=스칼라 현행/1=MVE)를 각 스칼라 함수
  머리에 두었다(기존 `mlkem_ntt_mode` 방식). NTT는 양쪽 모두 `ntt_mode=2`,
  `invntt_mode=1` 고정.
- 배치: 기존 ML-KEM C 글루와 동일한 code flash + I-cache. **ITCM 재배치 효과는
  미측정**(사전등록 범위 밖).
- v1 한계: packcompress/compress 계열은 양자화(csub·곱·시프트)만 벡터화하고
  바이트 끼워넣기는 스칼라다. 이 상태로 게이트를 통과했으므로 scatter 재작성은
  하지 않았다(추가 여지는 미측정).
- 상수시간: 고정 반복·고정 마스크·predication(vcmp+vpsel)만 사용, 비밀 의존
  분기·주소 없음. `frommsg`는 기존 `cmov_int16`과 등가의 vpsel.

## 결과 — full ML-KEM-768 (같은 ELF, A=c9 off / B=c9 on)

| run | 연산 | A1 | B1 | B2 | A2 | conservative 절감 |
|---|---|---:|---:|---:|---:|---:|
| 1 | keygen | 415,347 | 404,127 | 404,158 | 415,366 | **11,208** |
| 1 | encaps | 435,489 | 404,284 | 404,296 | 435,483 | **31,187** |
| 1 | decaps | 476,597 | 437,397 | 437,400 | 476,611 | **39,200** |
| 2 | keygen | 415,375 | 404,153 | 404,173 | 415,342 | **11,169** |
| 2 | encaps | 435,477 | 404,288 | 404,302 | 435,485 | **31,183** |
| 2 | decaps | 476,597 | 437,381 | 437,405 | 476,605 | **39,200** |

ML-KEM 자체 분모 기준 약 2.69 / 7.16 / 8.23%다. 절감량은 Z2가 귀속한 C9 bucket
상한(33.8k/47.4k/59.1k)의 약 33/66/66%를 회수한 것으로, 귀속량 전부가 제거
가능한 양이 아님을 그대로 보여준다.

## 결과 — 실제 X-Wing 종단간 (같은 ELF, wrapper 호출 경로)

| run | 연산 | A1 baseline | B1 | B2 | A2 | conservative 절감 | baseline 대비 |
|---|---|---:|---:|---:|---:|---:|---:|
| 1 | keygen | 773,241 | 761,961 | 761,953 | 773,268 | **11,280** | **1.459%** |
| 1 | encaps | 1,158,197 | 1,127,211 | 1,127,205 | 1,158,185 | **30,980** | **2.675%** |
| 1 | decaps | 841,706 | 802,443 | 802,491 | 841,699 | **39,208** | **4.658%** |
| 2 | keygen | 773,251 | 761,934 | 761,937 | 773,250 | **11,313** | **1.463%** |
| 2 | encaps | 1,158,185 | 1,127,207 | 1,127,215 | 1,158,175 | **30,960** | **2.673%** |
| 2 | decaps | 841,686 | 802,463 | 802,481 | 841,691 | **39,210** | **4.659%** |

두 run의 절감이 각 연산에서 0.5% 이내로 재현됐다. 이 표의 baseline A는 X/Y/C8
경로이며, AB(08-21)의 스칼라 NTT baseline이 아니다.

## 정확성·재현성 게이트 (두 run 공통)

- `KAT ALL PASS`(RFC 7748/SHA3), ML-KEM roundtrip/reject, 기존 전 슬롯 mismatch 0
- `expAJ kat-mm: 0` — 신규 primitive 오라클: 8-seed × 11함수 스칼라 대 MVE 전
  바이트 비교(cbd add=0/1, packcompress idx 0..2, 손상 검출 대칭성 포함)
- `expAJ bytes-mm: 0 smoke-fails=0` — full ML-KEM 8-seed A/B pk/sk/ct/ss/reject 일치
- `expAJ xw-bytes-mm: 0 xw-smoke-fails=0` — X-Wing wrapper 8-seed A/B 일치
- `expAJ timing-mm: 0 stack-fails=0 stack-used=7832` (전용 canary 패턴 0x7e)
- `harness_fails = 0`, `HARNESS DONE` (수집기 stderr에 PowerShell
  NativeCommandError 래핑 1건 있었으나 하네스는 완주 — 기존 판례대로 유효)

## 재현 아티팩트와 SHA-256

| 파일 | SHA-256 |
|---|---|
| 측정 ELF `blinky.elf` | `A619A0F28D6607726177D1CB400D4EB3F5C6A61A0D50BC5DBDF2E2EEBE9487DD` |
| 측정 SREC `blinky.srec` | `84087E91B675DD974E32F3E1A2F68E82C5E3A23453EA93CA84DF3105ED4C5849` |
| `poly_mve.c` | `73DC304596BEAD6E3A25C10AECF7EDEAB0B270BBDEAEA9210659DE292CFABE66` |
| 수정 `harness.c` | `BFBD0C37EA225554EE40795E45CD7B24682062559A77408327E09F8399A3949F` |
| run 1 원시 로그 | `1E53C6E11024E9115CE540A648AE8A20F9A90CDD4DB7BBDAFB7E4E65E5DCD4E3` |
| run 2 원시 로그 | `2DFDADE3263E99E0D624C4FE52C0A4429511A3D3962E1E12E9779B4DDBE33111` |

편집 전 원본은 `*.bak-20260824-AJ`, 동결 묶음은 `artifacts/2026-08-24_expAJ/`,
빌드는 0 errors(기존 warning 25). 회수기는 `harvest_ra8m1_expAJ.py`(SLOT_N=285,
슬롯 261~284).

## 한계·미측정

- MVE C9 코드의 ITCM 배치 효과: **미측정** (현재는 flash+I-cache, 스칼라와 동일 조건).
- v1의 스칼라 끼워넣기 잔여분을 scatter로 바꿨을 때의 추가 회수: **미측정**.
- X/Y/C8 대표값(2.85/1.54/3.25%)과의 합산 약 4.3/4.2/7.9%는 서로 다른 ELF·시드의
  **혼합 장부**다. 스칼라 NTT 원 baseline 대비 완전 통합 실측은 별도 실험이 필요하다.
- 일반성은 EK-RA8M1 Cortex-M85 한 보드 한정. M55/M52·타 M85 SoC·에너지·전력
  부채널은 **미측정**.
- 상수시간은 구조 논증 수준이며 입력 2벌 사이클 측정은 이번 하네스에 배선하지 않았다.
