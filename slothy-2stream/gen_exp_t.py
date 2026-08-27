"""실험 T: GP 0개 b0 MVE 라운드와 GP 무양보 fiat 곱의 실보드 비교.

fiat_noyield_scalar_o2.s는 프로젝트의 fiatref.c를 동일한 -O2 조건에
-fno-tree-slp-vectorize만 추가해 만든다. 이 옵션은 원래 함수 끝의 q2/q3
출력 저장만 스칼라화한다. GP 고정 옵션(-ffixed-*)은 전혀 사용하지 않는다.
"""

import re
import sys

sys.path.insert(0, r"C:\Users\cnscj\Dropbox\박도윤개인과제\A주제\slothy-2stream")
from gen_exp_j import LOADP, parse_fiat, wrap  # noqa: E402
from mve_keccak import gather_setup, round_mve4_b0  # noqa: E402

sys.path.insert(0, r"C:\Users\cnscj\Dropbox\박도윤개인과제\A주제\measure-harness")
from stitch_zip import zip_streams  # noqa: E402


SRC = r"C:\Users\cnscj\Dropbox\박도윤개인과제\A주제\slothy-2stream\fiat_noyield_scalar_o2.s"
DST = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\expt_board.s"


fiat, frame = parse_fiat(SRC, "fiat_mul_ref")
mve = round_mve4_b0()

assert not any(re.search(r"\bq[0-7]\b|\bv[a-z0-9]+(?:\.[a-z0-9]+)?\b", ins) for ins in fiat)
assert any(re.search(r"\br10\b|\br11\b|\bfp\b", ins) for ins in fiat)

SETUP_B0 = ["\tmovw r1, #:lower16:g_mve", "\tmovt r1, #:upper16:g_mve"] + gather_setup()
unit = LOADP + fiat


def zipped(a, b):
    return zip_streams([[ins] for ins in a], b)


out = [
    ".text", ".syntax unified", ".thumb", "",
    "// Experiment T: b0 (zero loop GP bases) + no-fixed-GP fiat.",
    "// fiat is scalar-only because q0-q7 belong to b0; no -ffixed-r* options are used.",
]
out += wrap("expt_fiat", [], unit, frame)
out += wrap("expt_b0", SETUP_B0, mve, frame)
out += wrap("expt_seq", SETUP_B0, unit + mve, frame)
out += wrap("expt_stitch", SETUP_B0, zipped(unit, mve), frame)
out += wrap("expt_m8_seq", SETUP_B0, unit * 8 + mve, frame)
out += wrap("expt_m8_stitch", SETUP_B0, zipped(unit * 8, mve), frame)
out += wrap("expt_m4_seq", SETUP_B0, unit * 4 + mve, frame)
out += wrap("expt_m4_stitch", SETUP_B0, zipped(unit * 4, mve), frame)

with open(DST, "w", encoding="utf-8", newline="\n") as f:
    f.write("\n".join(out) + "\n")

print(f"fiat={len(fiat)} frame={frame}B mve_b0={len(mve)}")
print(f"1:1={len(unit) + len(mve)} 8:1={8 * len(unit) + len(mve)} "
      f"4:1={4 * len(unit) + len(mve)} -> expt_board.s")
