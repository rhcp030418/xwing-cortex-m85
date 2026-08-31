# expCN — CP-SAT 실행 결정성 재감사

날짜: 2026-08-28

## 질문

동결된 156명령 B-mid 입력을 동일한 Slothy 모델에서 다시 풀 때, 실행 조건을 충분히
고정하면 생성 어셈블리가 반복 실행 사이에 바이트 단위로 같은가?

## 실행 조건

- Slothy commit: `241093fa5ddc1e21f75dd9f6588733bc3097872b`
- `slothy/core/config.py` SHA-256:
  `caa0e8f4f4e03162f7b96a2403484fad8d84cc5f33b01bf2b358b8a9488f2dda`
- `slothy/core/core.py` SHA-256:
  `61895ba74a726854f9c76fa9c02d83781500f1297622a1f62fa03d7d2c62431a`
- OR-Tools: 9.15.6755
- `PYTHONHASHSEED=0`
- CP-SAT `random_seed=42`
- CP-SAT `num_workers=1`
- Slothy split heuristic: factor 4, repeat 2, 창당 wall-clock timeout 300초

`solver_repro.py`는 solver 모델·목적함수를 바꾸지 않고 `CpSolver` 생성 직후 worker 수만
1로 고정한다. 각 로그 첫 줄은 위 조건과 source hash를 JSON으로 출력한다.

## 결과

`run_bmid_repro.sh`가 독립 Python 프로세스 두 개를 실행했다. 두 run의 모든 보고된
최적화 문제는 `OPTIMAL`로 끝났고, 최종 추정은 모두 82 cycle, IPC 1.90이었다.

| 파일 | SHA-256 |
|---|---|
| 입력 `exp_bmid.s` | `c620f265810ca6086d9faba3bb409d1a9b96ae64f887229ea70292c3e322caf8` |
| 재생 출력 1 | `fc05a73bd3f6e3dcf39337159ec0b7026939638ea3fa1c590bb7f552e07fdbdc` |
| 재생 출력 2 | `fc05a73bd3f6e3dcf39337159ec0b7026939638ea3fa1c590bb7f552e07fdbdc` |

판정: **PASS — 두 출력은 바이트 단위로 동일하다.**

## 실패한 선행 시도와 해석 범위

`PYTHONHASHSEED`를 고정하지 않은 선행 시도는 seed 42와 worker 1만 같았는데도 최종
추정이 82/83 cycle로 갈리고 출력이 달랐다. 그 두 로그와 출력은
`attempt0_no_python_hashseed_*`로 보존했다. 따라서 seed와 worker만 기록하면 충분하다는
가정은 기각한다.

새 결정적 출력은 역사적 `exp_bmid_opt.s`(SHA-256 `02e6e485...f60098`)와 바이트가
같지 않지만 두 출력 모두 82-cycle 최적값이다. 새 출력은 보드에서 재측정하지 않았으므로
역사적 85.06-cycle 실측의 근거로 사용하지 않는다. 또한 1,184명령 역사 실행에는
wall-clock timeout으로 끝난 `FEASIBLE` 창이 있으므로, 이 B-mid 결과를 그 전체 실행의
bit-for-bit 재생산으로 외삽하지 않는다. 본 감사가 닫는 범위는 B-mid solver 파이프라인의
반복 결정성과 앞으로의 실행 조건 기록이다.

## 재현 명령

WSL에서 다음을 실행한다.

```bash
SLOTHY_ROOT=/home/cnscjs1395/slothy \
SLOTHY_PYTHON=/home/cnscjs1395/slothy/venv/bin/python \
  bash /mnt/c/Users/cnscj/Dropbox/박도윤개인과제/A주제/slothy-2stream/run_bmid_repro.sh
```

마지막 줄이 다음과 같아야 한다.

```text
EXP_CN_REPRO_PASS output_byte_identical=1 seed=42 workers=1
```
