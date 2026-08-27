# 실험 AK 결과 — C9 v2(scatter 팩킹) 기각, ITCM 배치 효과 미미

> 날짜: 2026-08-24  
> 사전등록: `2026-08-24_expAK_c9_v2_itcm_prereg.md` (측정 전 작성, 이탈 없음)  
> 보드: EK-RA8M1 Cortex-M85, DWT CYCCNT, N=100 중앙값, calib 25, ABBA  
> 원시 로그: `logs/2026-08-24_expAK_run{1,2}.txt`(flash ELF),
> `logs/2026-08-24_expAK_itcm_run{1,2}.txt`(ITCM ELF)

## 한 줄 결론

expAJ의 두 미측정 항목을 닫았고 결과는 모두 **v1 유지**다. ① 팩킹까지 전부
벡터화한 v2는 v1보다 encaps/decaps에서 1.0~1.3k cycles **느려** 기각(음성 결과),
② MVE C9 코드의 ITCM 배치는 keygen/encaps에서 사전등록 "무관" 구간, decaps에서
"미확정 범위"에 그쳐 "유효(≥1,000cyc)" 기준 미달 — **C9의 expAJ 결론
(X-Wing +1.46/+2.67/+4.66%)은 flash 배치 v1 그대로 유지**한다.

## AK1 — v2 scatter 팩킹: 기각 (같은 ELF 단일변수, 4개 로그 전부 재현)

conservative Δ = min(v1₁−v2₁, v1₂−v2₂). 음수 = v2가 느림.

| 로그 | 대상 | keygen | encaps | decaps |
|---|---|---:|---:|---:|
| flash run 1 | ML-KEM | −18 | **−1,248** | **−1,088** |
| flash run 2 | ML-KEM | +16 | **−1,264** | **−1,090** |
| flash run 1 | X-Wing | −54 | **−1,290** | **−1,074** |
| flash run 2 | X-Wing | −45 | **−1,298** | **−1,064** |
| ITCM run 1 | ML-KEM | +12 | −1,138 | −1,090 |
| ITCM run 2 | ML-KEM | −20 | −1,126 | −1,106 |
| ITCM run 1 | X-Wing | +18 | −1,126 | −1,012 |
| ITCM run 2 | X-Wing | −6 | −1,112 | −1,014 |

사전등록 채택 조건 (a) "어느 연산도 500cyc 이상 회귀 금지"를 encaps/decaps가
위반하므로 **v2 기각, v1(양자화 벡터 + 스칼라 끼워넣기) 유지**. keygen이 ≈0인
이유는 keygen 경로가 packcompress를 쓰지 않기 때문이며, 회귀의 해석은 v2의
gather/scatter가 v1의 순차 스칼라 로드/스토어보다 LSU 비용이 크다는 것 — 실험
N/N2의 벡터 로드 스루풋 1/2·스토어 차단 관찰과 정합적이다(이 해석 자체는 추가
단일변수 실험이 없으므로 진단이지 확정 귀속은 아니다). v2 구현은 코드로 보존하고
성능 표에서는 쓰지 않는다.

## AK2 — ITCM 배치: 무관~미확정, 채택하지 않음

C9(v1) conservative 절감의 cross-ELF 비교. 두 run 범위.

| 대상 | flash 두 run | ITCM 두 run | 변화 | 사전등록 구간 |
|---|---:|---:|---:|---|
| ML-KEM keygen | 11,306~11,352 | 11,609~11,618 | +257~+312 | 무관(±500) |
| ML-KEM encaps | 30,836~30,860 | 30,806~30,818 | −54~−18 | 무관 |
| ML-KEM decaps | 38,966~38,990 | 39,918~39,920 | +928~+954 | **미확정(500~1,000)** |
| X-Wing keygen | 11,316~11,326 | 11,604~11,607 | +278~+291 | 무관 |
| X-Wing encaps | 30,650~30,660 | 30,802~30,818 | +142~+168 | 무관 |
| X-Wing decaps | 38,960~38,976 | 39,684~39,684 | +708~+724 | **미확정(500~1,000)** |

"유효(≥1,000cyc)" 기준을 넘는 항목이 없으므로 ITCM 배치는 채택하지 않는다.
decaps의 +0.7~1.0k는 ITCM 5.5KB 소모(한도 63.1/64KB 도달) 대비 이득이 얇고,
서로 다른 ELF의 비교이므로 이 범위 자체도 배치 단일 원인으로 확정하지 않는다.
U8(AF)의 114k대 flash 손실과 대조적으로, **C9의 MVE working set은 I-cache로
충분히 커버된다**는 것이 실측 결론이다.

## 명령열 동일성 (AF2-P 판례 방식)

flash/ITCM 두 빌드의 poly_mve 함수 21개를 objdump로 대조했다(주소 정규화).
**19개는 명령열 완전 동일**, `mve_poly_packcompress`·`mve_cmp_poly_packcompress`
디스패처 2개만 tail-branch 인코딩(b.w↔b.n)이 배치 거리 때문에 달랐다 — 산술
본문은 전부 동일하다. 또한 EXPAK_ITCM=0으로 되돌린 재빌드의 **SREC이 측정 flash
SREC과 바이트 일치**해(아래 해시) 소스→이미지 결정성을 확인했다. ELF 파일
해시는 빌드 메타데이터(타임스탬프) 때문에 다르며 이미지 비교는 SREC 기준이다.

## 정확성 게이트 (4개 로그 전부)

- `KAT ALL PASS`, 기존 전 슬롯 mismatch 0, `harness_fails=0`, `HARNESS DONE`
- `expAJ kat-mm: 0` — v2 4함수 추가된 확장 셀프테스트(8-seed, idx 0..2, 손상 검출)
- `expAJ bytes-mm/xw-bytes-mm: 0`, `expAJ timing-mm: 0`, `expAK timing-mm: 0`
  (AK ABBA는 모드 0 기준 바이트와 대조되므로 v2·ITCM의 종단간 동등성도 게이트됨)
- stack-fails 0, stack-used 7,832 B (본 하네스 워크로드 기준)

## 해시

| 파일 | SHA-256 |
|---|---|
| flash 측정 ELF | `AC9F8373E6C8947C8DFCDE9EADAA993512214890BB83F1D01EF69233278D2206` |
| flash 측정 SREC | `4CA22DB8F7720ED3BF529B474AC271CDBAD942AEB9DA87E3858E7E2DA8500535` |
| flash 재현 빌드 SREC (결정성 확인) | 위와 동일 (`4CA22DB8…`) |
| ITCM 측정 ELF | `31491E1A65F5235E0A1072E84859CE46044E66470D888E084AC2F844C82765DF` |
| ITCM 측정 SREC | `CB3C51E93976D60C21F3EE8963FFDA18F81493DDA5E635DD458A36EDBCCCB2E0` |
| poly_mve.c (v2 포함, flash 측정 시점) | `92882B634D44F6F00A4B46006F07C2F980679698DABDC11FDABE356658DF1422` |
| poly_mve.c (ITCM 태그판) | `42813598A07DC969F92FD5C88D2EC65150599785846B33C1C7B8920F5F868584` |
| flash run 1 / 2 로그 | `E227988D229ED2F569029813DA7562067F082A6676F87E5FE656632A9791BB9E` / `97F97CBAF41E5476A3DC1B5C1BB1515C83D8D6F2E43A09E8D0603FBA7C473839` |
| ITCM run 1 / 2 로그 | `AD959845919DA5B1F0C43A1EE0E308AA327E19C56784CD31180AD2C47DA93C8E` / `9FEDDD5B10B35F65A766DA89BF9713E2C3DD07CD16E081773D1CD21AE183327C` |

동결: `artifacts/2026-08-24_expAK/`(flash/ITCM ELF·SREC, 소스 2판, 회수기).
ITCM map: mve 측정 함수 21개 `0x2808~0x33ec`(ITCM), 셀프테스트는 flash 잔류,
`__itcm_from_flash$$Limit=0xF670`.

## 한계·미측정

- v2 회귀의 세부 원인(gather/scatter 대 스칼라 ld/st) 단일변수 분해: **미측정**(진단만).
- AK2의 decaps +0.7~1.0k는 cross-ELF 관찰이며 배치 단일 귀속은 하지 않는다.
- expAJ 대표값과 X/Y/C8 대표값의 완전 통합 실측(스칼라 NTT 원 baseline 대비)은
  여전히 별도 실험(선택지 1) 몫이다.
- 일반성은 EK-RA8M1 한 보드 한정.
