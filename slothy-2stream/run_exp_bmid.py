# 실험 B-mid 드라이버 (156명령, 분할 휴리스틱)
# 사용법(WSL): PYTHONHASHSEED=0 ~/slothy/venv/bin/python run_exp_bmid.py exp_bmid.s exp_bmid_opt.s
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
sl.config.outputs = ["r2", "r3"]
sl.config.constraints.stalls_first_attempt = 16
sl.config.split_heuristic = True
sl.config.split_heuristic_factor = 4
sl.config.split_heuristic_repeat = 2
sl.config.timeout = 300
sl.config.solver_random_seed = 42
sl.optimize(start="start", end="end")
try:
    code = sl.get_source_as_string()
except Exception:
    code = "\n".join(str(line) for line in sl.source)
open(sys.argv[2], "w", encoding="utf-8").write(code + "\n")
print("EXP_BMID_DONE")
