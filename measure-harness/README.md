# measure-harness — 1단계 킬 게이트 측정 하네스 (골격)

보드(EK-RA8M1) 도착 전에 미리 만들어 둔 DWT+PMU 측정 코드 (2026-08-13).
X25519 구간 / Keccak 구간 각각의 **사이클·명령 수·IPC·유휴 슬롯(STALL_OP) 프런트/백엔드 분해**를 찍는다
— "이득 상한 = 낭비 슬롯" 산수의 우변. 판정 절차는 `../게이트_측정_계획서.md`가 단일 진실.

## 사용법 (WSL)

```bash
make m85       # EK-RA8M1용 링크 검증 (QEMU에 M85 머신이 없어 실행은 보드에서)
make run-m55   # mps3-an547(M55)에서 구조 검증 — 부팅→설정→측정→출력 전체 경로
```

2026-08-13 상태: **m85 링크 OK · m55 QEMU 전 구조 실행 OK** (HARNESS DONE까지).
QEMU는 DWT/PMU를 에뮬레이트하지 않아 카운터가 전부 0으로 읽힘 — 정상이며, 실수치는 보드에서만.

## 설계 메모

- **PMU 16비트 함정**: M-profile PMU 이벤트 카운터는 16비트뿐. X25519 스칼라곱 1회가 수십만 명령이라
  그대로는 10회 이상 오버플로 → 짝/홀 카운터를 CHAIN(0x1E)으로 묶어 **32비트 논리 카운터 4쌍**으로 사용.
  현재 세트: INST_RETIRED · STALL_OP · STALL_OP_FRONTEND · STALL_OP_BACKEND (+ CCNTR, DWT CYCCNT 교차검증).
- 캐시 프로파일이 필요하면 `PAIR[]`에서 fe/be 쌍을 L1I_CACHE_REFILL/L1D_CACHE_REFILL로 바꿔 2차 패스
  (한 줄 교체 — 카운터 8개 한계 때문에 한 번에 다 못 잰다).
- `slot-waste % = STALL_OP / (2×cyc)` — M85 듀얼이슈라 슬롯 총량이 2×사이클. 게이트 판정에 들어가는 수치.
- `calib-empty`: 측정 시작/정지 오버헤드. per-op 해석 시 차감.
- `cmsis/`: CMSIS_6 헤더 원본 그대로 동봉 (Apache-2.0, `fetch_cmsis.sh`로 재취득 가능).
  `m85_device.h`는 core_cm85.h를 띄우기 위한 최소 디바이스 헤더 — 보드 FSP 프로젝트에서는 FSP 것을 쓴다.

## 보드 포팅 — ✅ 완료 (2026-08-16)

이식본: `C:\Users\cnscj\e2_studio\workspace\blinky\src\harness.c` (uart_* → RAM 로그 버퍼).
사용 루프 (e2 studio 디버그 세션은 닫은 상태에서, Windows PowerShell):

```powershell
# 1) 헤드리스 빌드 (새 파일 추가했으면 -build 대신 -cleanBuild)
& "C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\eclipse\e2studioc.exe" -nosplash `
  -application org.eclipse.cdt.managedbuilder.core.headlessbuild `
  -data <임시워크스페이스> -build "blinky/Debug"
# 2) 플래시 → 실행 → 로그 회수 (pylink + J-Link V968)
& "C:\Users\cnscj\AppData\Local\Programs\Python\Python314\python.exe" harvest_ra8m1.py
```

첫 실측(2026-08-16, ITCM/DTCM 배치): keccak-f1600 **5,504 cyc** · x25519 **357,510 cyc** · 오버헤드 129 cyc.
KAT 6종 실보드 PASS. 상세·발견 2건(ITCM 고착 granule, PMU 이벤트 무반응)은 로드맵 변경 이력 08-16 참조.
디버깅 보조 스크립트: `pmu_debug.py`(PMU 레지스터 검사) · `fault_probe.py`(하드폴트 진단) ·
`itcm_diff.py`(ITCM vs 플래시 대조) · `pmu_detached_test.py`(디버거 분리 실험) · `itcm_watch.py`(워치포인트).

원 계획 메모: 코드·상수·스택의 ITCM/DTCM 배치와 클록 고정은 게이트_측정_계획서대로 (배치 적용됨, 클록은 BSP 기본 480MHz — 고정 정책은 게이트 본측정 때 재확인).
QEMU 값과 절대 비교 금지 (QEMU는 기능 검증 전용).

## 최신 상태 (2026-08-21)

`rep_cyc`는 157 slots × N=100이며, 슬롯 136~144는 실험 X forward ABBA,
145~156은 실험 Y inverse ABBA다. X/Y 모두 실제 ML-KEM full-operation 차분을
측정한다. 최종 유효 Y run은 byte/oracle/canary/stack mismatch 0,
`harness_fails=0`이다. 재현값과 제외된 diagnostic run의 이유는
`2026-08-21_expY_pqmx_inverse_integration_prereg.md`를 따른다.
