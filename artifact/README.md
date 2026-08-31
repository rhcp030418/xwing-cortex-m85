# 보드 소스 아티팩트 역사 안내 — M85 하이브리드 스티칭 측정 연구

> **현재 제출 패키지 상태 (2026-08-31):** 이 문서는 2026-08-17 보드 소스 패키징의
> 역사 안내다. 현재 논문 수치 정본은 `../논문_데이터_표.md`, 데이터 계보·버전 정본은
> `../paper/데이터_계보_아티팩트_정합성.md`, 최초부터의 누적 장부는
> `../paper/데이터_누적_검증대장.md`, 원고 정본은 `../paper/ko/main.tex`이다.
> 최초 A0와 최종 B8의 직접 비교 증거는
> `../measure-harness/artifacts/2026-08-31_expDJ/`에 있다.
> 아래 역사 설명은 현행 결과나 제출 범위를 덮어쓰지 않는다.

2026-08-17 당시 실험 재현 재료의 구성 안내다. 당시 골격은
`../5단계_논문_골격.md`, 실험 이력은 `../PQC_스티칭_연구_로드맵.md`에 남아 있다.

## 구성

| 위치 | 내용 |
|---|---|
| `host-src/` | 호스트측 C 소스 — fiatmul.c(양보 실험의 컴파일 입력), mul256*.c(스케일업 사다리), checkmve*.sh(WSL 검증 스크립트) |
| `board-src/` | EK-RA8M1 펌웨어 소스 전체 — harness.c(측정 하네스, 슬롯 0~62 + KAT + C 레퍼런스), keccak/(pqm4 M4 asm), mlkem/(pqm4 m4fspeed), x25519/(Lenngren M4), fiat/, itcm_pad.c, stitch_micro.S |
| `board-src/gen/` | 재생 불가 생성물만 — fiat_yield2/3.s(gcc -ffixed 출력, gen_exp_j.py의 파싱 입력), slothy_expa.s. **나머지 커널은 생성기로 재생**(아래) |
| `../slothy-2stream/` | SLOTHY 확장 패치(patch_slothy_v81m.py v0.1~0.3) + 실험 생성기 전부(gen_*.py, mve_keccak.py) + 실험 로그(README.md) + 솔버 입출력(exp_*.s) |
| `../measure-harness/` | harvest_ra8m1.py(플래시→실행→RAM 회수 자동), stitch_zip.py(지퍼 스티처 v0.3), icount_unicorn.py(명령 수 카운트) |

## 환경

- 보드: Renesas EK-RA8M1 (Cortex-M85, R7FA8M1AH) — 주의: 본 개체는 ITCM 0x18/0xE0
  고착 결함(itcm_pad.c로 회피). PMU 이벤트 카운터 무반응(DWT CYCCNT만 사용).
- Windows: e2 studio 2026-04.2 + FSP 6.5.0 + GCC 13.2.1, SEGGER J-Link V9.68(x64 DLL),
  Python 3.14 + pylink-square
- WSL Ubuntu-24.04: ~/slothy(클론 + 본 패치), venv, 작업 사본 ~/stitch2
- TrustZone: 첫 플래시 전 DPM CLI로 Code Flash Secure=1024KB 설정 필요(로드맵 이력 참조)

## 재현 파이프라인

1. **FSP 프로젝트**: blinky(Flat/No RTOS/GCC) 생성 → `board-src/` 내용물을 src/에 복사
2. **커널 재생**: `py slothy-2stream/mve_keccak.py` → mvekeccak_board.s ·
   `py slothy-2stream/gen_exp_j.py` → expj_board.s(J/K/M/M4) ·
   `py slothy-2stream/gen_exp_l.py` → expl_board.s ·
   `py slothy-2stream/gen_board_expf.py` → expf_board.s (기타 gen_board_*.py 동일 패턴)
3. **빌드**: e2studioc 헤드리스(-cleanBuild, 임시 워크스페이스) — 링크 실패 시 GUI
   대화상자로 무한 대기하는 함정 있음(프로세스 킬 필요)
4. **측정**: `py measure-harness/harvest_ra8m1.py` — 플래시→실행→rep_cyc[63][100] 회수,
   슬롯별 중앙값 + 분석 행([EXP-*], [상수시간], [encaps 투영] 등) 자동 출력,
   `harness_fails = 0` 확인(전 KAT·정답 검증 통과 의미)
5. **SLOTHY 재현**(WSL): `cd ~/stitch2 && ~/slothy/venv/bin/python run_exp_f.py ...`
   — 패치는 멱등, arch_v81m.py의 all_subclass_leaves 캐시 앞 삽입 필수

## 측정 위생 (사전 등록)

- N=100 반복 중앙값, calib(빈 span) 차감, 코드 ITCM(대형은 flash)/데이터 DTCM
- 루프 `.balign 16` 필수(정렬 따라 ±1cyc/iter)
- 상수시간 판정: 입력 2벌 median Δ(슬롯 50 vs 58) — harvest가 자동 PASS/FAIL

## 함정 목록 (재현 시 조우 순)

로드맵 변경 이력에 전부 기록. 요약: 32비트 JLink DLL / 디바이스명 패키지 접미사 /
TrustZone 32KB / RAMCode 무응답(CRC 스킵 끄기) / MSPLIM STKOF / vpush는 d-레지스터 /
fiat의 ip·lr 별칭(grep r12 미검출) / PowerShell CP949 파손(한국어 파일은 Write 도구)
