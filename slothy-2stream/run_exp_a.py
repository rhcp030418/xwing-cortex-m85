# 3단계 실험 A 드라이버: 2-스트림 연접 입력을 SLOTHY(M85)로 최적화 (2026-08-16)
# 사용법(WSL): ~/slothy/venv/bin/python run_exp_a.py <input.s> <output.s>
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
sl.config.constraints.stalls_first_attempt = 8
sl.config.outputs = ["r2", "r3"]   # 스트림 A의 최종 누산기 (메모리 str은 자동 인식)
sl.config.selftest = False   # LLVM 도구 부재 시 상류 버그로 크래시 — 검증은 보드 KAT가 담당
sl.config.logger = logging.getLogger("slothy-config")   # 상류 버그 우회: 게터가 로거 없이 warning 호출
sl.optimize(start="start", end="end")
try:
    code = sl.get_source_as_string()
except Exception:
    code = "\n".join(str(line) for line in sl.source)
open(sys.argv[2], "w", encoding="utf-8").write(code + "\n")
print("EXP_A_DONE")
