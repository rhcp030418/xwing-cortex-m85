# 실험 B 드라이버: 전체 연접(약 1.3k 명령)을 분할 휴리스틱으로 최적화
# 사용법(WSL): PYTHONHASHSEED=0 ~/slothy/venv/bin/python run_exp_b.py exp_b.s exp_b_opt.s
import logging
import os
import sys

sys.path.insert(0, os.environ.get("SLOTHY_ROOT", "/home/cnscjs1395/slothy"))

import slothy.targets.arm_v81m.arch_v81m as Arch_Armv81M
import slothy.targets.arm_v81m.cortex_m85r1 as Target_CortexM85
from slothy import Slothy
from solver_repro import force_single_worker, print_manifest

logging.basicConfig(level=logging.INFO, stream=sys.stdout)

solver_manifest = force_single_worker(seed=42)
print_manifest(solver_manifest)
sl = Slothy(Arch_Armv81M, Target_CortexM85)
sl.load_source_from_file(sys.argv[1])
sl.config.variable_size = True
sl.config.selftest = False
sl.config.logger = logging.getLogger("slothy-config")
sl.config.outputs = ["r0", "r1", "r2", "r3", "r4", "r5", "r12", "r14"]  # 잔존 레지스터 보수적 라이브 처리
sl.config.constraints.stalls_first_attempt = 64
sl.config.constraints.stalls_maximum_attempt = 1024   # 윈도우 189_287 스톨 한도 초과 재발 방지
# 대형 커널: 슬라이딩 윈도우 분할 휴리스틱 (SLOTHY 논문의 대형 커널 처리법)
sl.config.split_heuristic = True
sl.config.split_heuristic_factor = 12
sl.config.split_heuristic_repeat = 1
sl.config.split_heuristic_stepsize = 0.08
sl.config.timeout = 600
sl.config.solver_random_seed = 42
sl.optimize(start="start", end="end")
try:
    code = sl.get_source_as_string()
except Exception:
    code = "\n".join(str(line) for line in sl.source)
open(sys.argv[2], "w", encoding="utf-8").write(code + "\n")
print("EXP_B_DONE")
