# A주제 — X25519+ML-KEM 스티칭 on Cortex-M85

진입점: `PQC_스티칭_연구_로드맵.md` 상단 현재 상태 → `4단계_X-Wing_적용_리포트.md` → `paper/main.tex`.
수치는 `논문_데이터_표.md`에서만 인용.

## 도구
- 보드: EK-RA8M1 (Cortex-M85). 보드 개체 결함: ITCM 0x18·0xE0 고착 → `itcm_pad.c` 유지.
- FSP 프로젝트: `C:\Users\cnscj\e2_studio\workspace\blinky` (e2 studio 2026-04.2 + FSP 6.5.0 + GCC 13.2.1).
- 플래시·로그: J-Link V9.68 + pylink. `flash_file`은 non-ASCII 경로 불가 → ASCII 임시 사본으로.
- e2studioc 링크 실패 시 GUI 대화상자로 무한 대기 → 프로세스 킬 + 락 제거.
- TrustZone: Code Flash Secure 32KB로 되돌아갈 수 있음 → 플래시 실패("RAMCode did not respond") 시 DPM CLI로 1024KB 재설정.
- PMU 이벤트 카운터 불능 → 명령 수는 `icount_unicorn.py`. CYCCNT/CCNTR은 정상.
- SLOTHY: WSL `~/slothy` + venv, 작업사본 `~/stitch2`. 패치 `slothy-2stream/patch_slothy_v81m.py`.
- QEMU 대체 실행장: mps3-an547 (M55, MVE).

## 측정 규칙
- 마이크로벤치 루프는 `.balign 16` 필수 (정렬따라 ±1cyc/iter).
- ITCM 64KB 예산 — 새 실험만 ITCM, 구실험 커널은 .text로.
- 정답 검증(KAT/레퍼런스 대조) 없는 사이클 수치는 결과로 쓰지 않는다.
- 상수시간 주장은 입력 2벌 median Δ로 확인.
- 실험은 `slothy-2stream/` 사전 등록(prereg) 문서 먼저, 결과 문서 따로.
