# 실험 AL 사전등록 — X/Y/C8 × C9 같은-ELF 2×2 누적 X-Wing

> 작성: 2026-08-24, 구현·측정 시작 전. 전제: expAK에서 C9 v2와 ITCM 배치는
> 기각되었으므로 최종 후보는 expAJ의 **v1·flash 배치**다.

## 질문과 1차 결과

기존 X/Y/C8 대표값과 expAJ C9 추가분은 서로 다른 ELF·시드에서 측정되었다.
따라서 둘의 합 약 4.3/4.2/7.9%는 혼합 장부일 뿐이다. 이 실험은 같은 ELF,
같은 wrapper, 같은 RNG stream에서 다음 두 요인의 완전요인 2×2를 직접 측정한다.

| 셀 | `mlkem_ntt_mode` / `mlkem_invntt_mode` | `mlkem_c9_mode` | 의미 |
|---|---|---:|---|
| 00 | 0 / 0 | 0 | same-ELF runtime scalar path |
| 10 | 2 / 1 | 0 | X/Y/C8만 |
| 11 | 2 / 1 | 1 | X/Y/C8 + C9 v1, 최종 후보 |
| 01 | 0 / 0 | 1 | C9 v1만 |

**1차 결과는 실제 X-Wing keygen/encaps/decaps의 `00→11` 직접 차분**이다.
논문 대표값은 이 값으로만 교체하며 과거 ELF의 절감량을 더하지 않는다.

주의: 00도 후보 코드가 ELF에 존재하고 runtime branch로 끈 상태다. 따라서 인과적
토글 기준선으로는 유효하지만, 후보 코드를 링크에서 제거한 scalar-only 배포 ELF의
절대 성능·코드 크기라고 부르지 않는다.

## 단일변수와 배치

- `poly_mve.c`: `EXPAK_ITCM=0`, C9 mode 1 고정. mode 2는 측정하지 않는다.
- X25519, Keccak, randombytes, compiler flags, linker script, 캐시·메모리 배치는
  네 셀에서 동일하다.
- 셀마다 같은 고정 seed로 RNG를 reset한다. timer 안의 호출과 wrapper는 동일하다.
- 순서: `00a→10a→11a→01a→01b→11b→10b→00b`. 네 셀의 평균 위치가 같아
  1차 drift를 대칭화한다.
- 기존 AJ/AK 슬롯 0~308은 보존한다. 신규 X-Wing 슬롯은 309~332,
  `REP_SLOTS=333`, 각 셀은 keygen/encaps/decaps 3슬롯이다.
- EK-RA8M1 Cortex-M85 480 MHz, DWT CYCCNT, N=100 중앙값, slot 2 calib 차감.
  독립 flash/run 2회 실시한다.

## 정확성·안전 게이트

각 run에서 하나라도 실패하면 그 run의 성능값은 기각한다.

- 기존 RFC 7748/SHA3 KAT와 전체 하네스 gate 전부 통과, `harness_fails=0`.
- 기존 `expAJ kat-mm=0`으로 C9 primitive self-test 통과.
- 신규 `expAL xw-bytes-mm=0 xw-smoke-fails=0`: 8 seeds × 네 셀의
  pk/sk/ct/valid ss/reject ss 전 바이트가 00과 일치한다.
- `expAL timing-mm=0`: 실제 측정 stream의 네 셀 최종 출력이 일치한다.
- `stack-fails=0`; high-water를 기록한다.
- `HARNESS DONE`가 있어야 한다.

## 계산과 사전 판정

각 효과는 대칭 두 방향을 모두 기록하고 conservative 값은 두 절감량의 최솟값이다.

- 누적 직접 효과: `00−11`
- X/Y/C8 효과: C9 off에서 `00−10`, C9 on에서 `01−11`
- C9 효과: X/Y/C8 off에서 `00−01`, on에서 `10−11`
- 절감 상호작용(양수=추가 시너지): `10 + 01 − 00 − 11`

**대표값 채택** = 두 독립 run에서 모든 gate를 통과하고, 세 X-Wing 연산의
conservative `00−11`이 모두 양수이며 run 간 절감률 차이가 각 연산에서
0.5%p 이내다. 양수지만 재현 폭을 넘으면 "방향 성공·대표값 보류", 어느 연산이든
0 이하면 "누적 실패/상호작용 조사"로 기록한다. 단순효과와 상호작용은 관찰값으로
보고하며 대표값 채택 조건을 사후 변경하지 않는다.

## 코드·로그·동결

- 하네스 조각: `expAL_factorial.inc`
- 설치·보고서·동결: `expAL_tools.py`
- 보드 회수기: `harvest_ra8m1_expAL.py`
- 일괄 실행: `run_expAL.ps1`
- runner는 공용 `.ra8m1-measurement.lock`을 배타적으로 잡아 같은 runner의 병렬
  build/flash를 거부한다.
- build 직후 ELF/SREC/map과 전체 프로젝트를 `staging/2026-08-24_expAL/`에 먼저
  동결하고, 회수기는 live `Debug`가 아니라 이 frozen ELF/SREC를 사용한다.
  두 로그에는 flash 직전 ELF/SREC SHA-256을 기록한다.
- runner는 Debug를 제외한 전체 프로젝트 source fingerprint를 build 전·후 비교하고,
  staging 복제본의 fingerprint도 같은지 확인한다.
- 기존 RA8M1 RAMCode timeout 회피 때문에 J-Link `SetVerifyDownload=0`은 유지한다.
  대신 강제 재프로그램 뒤 SREC의 code-flash data record(0x02000000~0x021fffff)를
  보드에서 전 바이트 readback 비교하고 hash·byte 수를 로그에 남긴다. 실행 로그의
  `333 slots` build identity와 frozen SREC 해시도 함께 gate한다. SREC의 비실행
  configuration record(0x0300...) readback은 범위 밖이다.
- 로그: `logs/2026-08-24_expAL_run{1,2}.txt`
- 결과: `2026-08-24_expAL_results.md`
- 최종 아티팩트: `artifacts/2026-08-24_expAL/`에 전체 e2 프로젝트 소스,
  ELF/SREC/map, 생성된 make/link metadata, 로그, 스크립트와 SHA-256 manifest를
  동결한다.
