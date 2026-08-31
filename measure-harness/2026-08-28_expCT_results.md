# 실험 CT 결과 — B-mid(156명령) CP-SAT seed 민감도

> 날짜: 2026-08-28 · 사전등록 `2026-08-28_expCT_seed_sweep_prereg.md`
> 호스트 WSL, OR-Tools CP-SAT v9.15, worker 1, `PYTHONHASHSEED=0`, timeout 300 s/창. 보드 미측정.

## 결과 (8 seed)

| seed | 목적값 (cycles) | 창 상태 | 출력 sha16 | wall |
|---|---:|---|---|---:|
| 42 | 82 | 전부 OPTIMAL | fc05a73bd3f6e3dc | 80 s |
| 1 | 82 | 전부 OPTIMAL | 17b29bce60db3d3f | 379 s |
| 2 | **83** | 창 98_136 FEASIBLE(300 s) 후 재패스 OPTIMAL | 08f8b698b90df22d | 973 s |
| 3 | 82 | 전부 OPTIMAL | ad46d97f645fa675 | 382 s |
| 7 | 82 | 전부 OPTIMAL | bc4980886a62803c | 75 s |
| 11 | **83** | | 6639ac6190c53ce2 | 676 s |
| 23 | **83** | | b5f778fcf36d4fef | 681 s |
| 101 | **84** | | c2e8ad0ebb161e70 | 383 s |

## 판정

- **H1(목적값 seed 불변) 기각.** 82가 4회, 83이 3회, 84가 1회 (범위 2 cycle). 최종 성능 추정 창은 매번 OPTIMAL로
  닫히지만, 분할 휴리스틱이 창을 나누고 합치는 경로가 seed에 따라 달라 전체 목적값이 1 cycle
  갈린다. 창 하나가 300 s FEASIBLE로 끝난 seed 2가 이를 보여 준다.
- **H2(출력 다름) 지지.** 여덟 해시 전부 다름.
- 함의: `tab:solver`의 156명령 −3.4%(88.07→85.06)는 seed 42의 결과이고, 그 3 cycle 중
  최대 2 cycle은 seed 선택에 좌우될 수 있다. 원고에 그렇게 좁혀 썼다.
- 미측정: 1,184명령 실행의 seed 의존(창당 600 s × 8 seed는 예산 밖), 83-cycle 출력의 보드 실측.

## 동결

`artifacts/2026-08-28_expCT_seed_sweep/` — seed별 `.log`/`.s`, `summary.txt`, `SHA256SUMS.txt`.
