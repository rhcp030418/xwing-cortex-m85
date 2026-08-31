"""Run SLOTHY with architectural LSLL/LSRL pair constraints and no r2-r9 ban."""

import logging
import sys

sys.path.insert(0, "/home/cnscjs1395/slothy")

import slothy.targets.arm_v81m.arch_v81m as Arch_Armv81M
import slothy.targets.arm_v81m.cortex_m85r1 as Target_CortexM85
from slothy import Slothy


def main() -> None:
    logging.basicConfig(level=logging.INFO, stream=sys.stdout)
    solver = Slothy(Arch_Armv81M, Target_CortexM85)
    solver.load_source_from_file(sys.argv[1])
    solver.config.variable_size = True
    solver.config.selftest = False
    solver.config.logger = logging.getLogger("slothy-config")
    solver.config.reserved_regs = (
        set(Arch_Armv81M.RegisterType.default_reserved()) | {"r11", "q7"}
    )
    solver.config.reserved_regs_are_locked = True
    solver.config.outputs = [f"q{i}" for i in range(8)]
    solver.config.constraints.stalls_first_attempt = 32
    solver.config.constraints.stalls_maximum_attempt = 512
    solver.config.split_heuristic = True
    solver.config.split_heuristic_factor = 16
    solver.config.split_heuristic_repeat = 2
    solver.config.split_heuristic_stepsize = 0.1
    solver.config.split_heuristic_estimate_performance = False
    solver.config.timeout = int(sys.argv[3]) if len(sys.argv) > 3 else 120
    solver.optimize(start="start", end="end")
    try:
        code = solver.get_source_as_string()
    except Exception:
        code = "\n".join(str(line) for line in solver.source)
    with open(sys.argv[2], "w", encoding="utf-8") as handle:
        handle.write(code + "\n")
    print("EXP_DB_DONE")


if __name__ == "__main__":
    main()
