# 실험 AK 사전등록 — C9 MVE의 scatter 팩킹(v2)과 ITCM 배치

> 작성: 2026-08-24, 측정 시작 전. 전제: expAJ(강한 성공, `2026-08-24_expAJ_results.md`)의
> 두 미측정 항목을 닫는다 — ① v1의 스칼라 바이트 끼워넣기 잔여분, ② MVE C9 코드의
> flash 배치. 판정 기준은 아래에 측정 전 동결한다.

## AK1 — v2 scatter 팩킹 (같은 ELF 단일변수)

- 질문: v1에서 스칼라로 남긴 바이트 끼워넣기(10비트 packcompress/cmp, 4비트
  compress/cmp)를 MVE gather/scatter로 바꾸면 추가로 얼마나 회수되는가.
- 구현: `mlkem_c9_mode`에 모드 **2**를 추가한다. 모드 2는 위 4개 함수만
  `_v2`(전 벡터: gather 양자화 + scatter/협폭 저장)로 바꾸고 나머지 7개 함수는
  v1과 동일하다. 모드 0(스칼라)·1(v1)은 불변.
- 측정: expAJ와 같은 하네스에서 ABBA `v1(1)→v2(2)→v2(2)→v1(1)`,
  full ML-KEM(슬롯 285~296)과 실제 X-Wing(슬롯 297~308), N=100, calib 25.
  이 ABBA의 출력은 앞서 저장된 모드 0 기준 바이트와 비교되므로 v2의 종단간
  동등성도 함께 게이트된다.
- 사전 판정: **v2 채택** = 두 run 모두 (a) 어느 연산도 500 cycles 이상 회귀하지
  않고 (b) 한 연산 이상 1,000 cycles 이상 개선. 아니면 **v1 유지**(음성 결과로
  기록). conservative = min(v1₁−v2₁, v1₂−v2₂).

## AK2 — ITCM 배치 (동일 명령열, 배치만 변경 — AF2-P 판례)

- 질문: poly_mve 코드(현재 code flash + I-cache)를 ITCM에 두면 C9 절감이
  달라지는가.
- 구현: `poly_mve.c` 함수들에 `.itcm_code_from_flash` 섹션 속성을 붙이는 컴파일
  스위치(`EXPAK_ITCM`) 하나만 바꿔 **별도 ELF**를 만든다. 다른 소스·플래그 불변.
  map에서 poly_mve 심볼 주소가 ITCM(0x000...)인지, ITCM 한도 64 KiB 안인지
  확인하고, objdump로 두 빌드의 poly_mve 함수 본문 명령열을 대조해 차이가 있으면
  그대로 기록한다(주소 재배치 제외).
- 측정: ITCM ELF로 같은 하네스를 독립 flash/run 2회. flash ELF의 같은 슬롯과
  cross-ELF 비교한다. 서로 다른 ELF이므로 결과는 배치 효과의 실측이되 AF 판례대로
  명령열 동일성 확인과 함께 보고한다.
- 사전 판정: C9 후보(모드 1 또는 채택 모드)의 X-Wing 종단간 절감이 flash 대비
  두 run에서 **1,000 cycles 이상** 커지면 "ITCM 배치 유효", ±500 이내면
  "배치 무관(음성)", 그 사이면 "미확정 범위"로 기록한다. 어느 쪽이든 대표값
  교체는 이 실험에서 선언하지 않는다.

## 정확성 게이트 (run마다, 하나라도 실패 시 해당 run 성능 기각)

- 기존 전체: KAT, roundtrip/reject, 전 슬롯 mismatch 0, `harness_fails=0`.
- `expAJ kat-mm=0` — 셀프테스트에 v2 4함수(8-seed, idx 0..2, 손상 검출 대칭성)
  추가 확장판.
- `expAJ bytes-mm/xw-bytes-mm=0`(모드 1), `expAJ/expAK timing-mm=0`(모드 0 기준
  바이트 대조), stack canary 0.

## 측정 방법·로그

- EK-RA8M1, DWT CYCCNT, N=100 중앙값, calib 25, REP_SLOTS 285→309,
  회수기 `harvest_ra8m1_expAK.py`(SLOT_N=309).
- flash ELF: `logs/2026-08-24_expAK_run{1,2}.txt` (AK1 판정 + AK2의 flash 쪽)
- ITCM ELF: `logs/2026-08-24_expAK_itcm_run{1,2}.txt`
- 결과 문서 `2026-08-24_expAK_results.md`. ELF/SREC/소스 SHA-256 기록,
  편집 전 백업은 기존 `*.bak-20260824-AJ` 유지 + 추가 변경분 `*.bak-20260824-AK`.
