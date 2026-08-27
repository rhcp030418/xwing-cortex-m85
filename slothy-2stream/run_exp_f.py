# 실험 F 드라이버 — 스칼라 MAC × MVE 라운드 코이슈 (1,222명령, 지퍼 입력)
# 사용법(WSL): ~/slothy/venv/bin/python run_exp_f.py exp_f.s exp_f_opt.s
import logging
import sys

sys.path.insert(0, "/home/cnscjs1395/slothy")

import slothy.targets.arm_v81m.arch_v81m as Arch_Armv81M
import slothy.targets.arm_v81m.cortex_m85r1 as Target_CortexM85
from slothy import Slothy

logging.basicConfig(level=logging.INFO, stream=sys.stdout)

sl = Slothy(Arch_Armv81M, Target_CortexM85)
sl.load_source_from_file(sys.argv[1])
sl.config.variable_size = True
sl.config.selftest = False
sl.config.logger = logging.getLogger("slothy-config")
# 살아있는 출력: 스칼라 누산기 r0/r1 + Q 전역(마지막 라운드 값 보존 강제)
sl.config.outputs = ["r0", "r1"] + [f"q{i}" for i in range(8)]
sl.config.constraints.stalls_first_attempt = 96
sl.config.constraints.stalls_maximum_attempt = 1024
sl.config.split_heuristic = True
sl.config.split_heuristic_factor = 32
sl.config.split_heuristic_repeat = 1
sl.config.split_heuristic_stepsize = 0.08
sl.config.timeout = 300
sl.optimize(start="start", end="end")
try:
    code = sl.get_source_as_string()
except Exception:
    code = "\n".join(str(line) for line in sl.source)
open(sys.argv[2], "w", encoding="utf-8").write(code + "\n")
print("EXP_F_DONE")
