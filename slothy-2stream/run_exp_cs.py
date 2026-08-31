# 실험 CS 드라이버 — 실제 U 조각 fiat_mul_u4_p0 본문(597명령)을 솔버로 재스케줄.
# 사용법(WSL): ~/slothy/venv/bin/python run_exp_cs.py exp_cs.s exp_cs_opt.s
#
# 예약: r11(b1 베이스), q7(개더 베이스), sp(스필 프레임), r0/r1/r2(C 인자) —
# 전부 setup 에서 확립되고 본문이 쓰지 않는 live-in 이므로 재할당을 막는다.
# 출력: q0..q7 전부 (조각 경계를 넘어 다음 phase 가 이어받을 수 있으므로 보수적).
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
# 상류 기본(flags, r13, r14, HINT)에 b1 베이스 r11 과 개더 베이스 q7 을 더한다.
# 둘 다 setup 이 세우고 본문이 쓰지 않는 live-in 이므로 재할당 대상이 되면 안 된다.
#
# r2..r9 추가 예약 — 상류 모델 공백 때문이다. Armv8.1-M `LSLL/LSRL RdaLo, RdaHi, #imm`
# 은 RdaLo 가 짝수, RdaHi 가 홀수여야 하는데 v81m 모델의 lsll_imm/lsrl_imm 은 이를
# 표현하지 못해 솔버가 `lsrl r8, r6` 같은 불법 쌍을 만든다(어셈블 실패로 실증).
# 이 조각의 lsll/lsrl 12개가 쓰는 r2..r9 를 재할당 대상에서 빼서 회피한다.
# 재정렬은 그대로 자유이고, 재할당은 r0/r1/r10/r12 안에서만 가능하다.
sl.config.reserved_regs = (set(Arch_Armv81M.RegisterType.default_reserved())
                           | {"r11", "q7"} | {f"r{i}" for i in range(2, 10)})
sl.config.reserved_regs_are_locked = True
sl.config.outputs = [f"q{i}" for i in range(8)]
sl.config.constraints.stalls_first_attempt = 32
sl.config.constraints.stalls_maximum_attempt = 512
sl.config.split_heuristic = True
sl.config.split_heuristic_factor = 16
sl.config.split_heuristic_repeat = 2
sl.config.split_heuristic_stepsize = 0.1
# 최종 전체 성능 추정은 conf2.timeout=None 이라 606명령 전체를 시간 제한 없이 다시 푼다.
# 스케줄 결과는 창 패스에서 이미 확정되고 이 단계는 예측치만 내므로 끈다.
# (원고는 어차피 솔버 예측이 아니라 보드 실측만 결과로 쓴다.)
sl.config.split_heuristic_estimate_performance = False
sl.config.timeout = int(sys.argv[3]) if len(sys.argv) > 3 else 300
sl.optimize(start="start", end="end")
try:
    code = sl.get_source_as_string()
except Exception:
    code = "\n".join(str(line) for line in sl.source)
open(sys.argv[2], "w", encoding="utf-8").write(code + "\n")
print("EXP_CS_DONE")
