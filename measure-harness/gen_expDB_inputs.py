"""Generate safe SLOTHY inputs for all four fiat_mul_u4 phases."""

from importlib.util import module_from_spec, spec_from_file_location
from pathlib import Path
import re


HERE = Path(__file__).resolve().parent
CS = HERE / "artifacts" / "2026-08-28_expCS" / "gen_exp_cs.py"
SRC = HERE / "expAE-src" / "fiat_u_stitch_m85.S"
OUTDIR = HERE.parent / "slothy-2stream" / "expDB"


def load_cs_module():
    spec = spec_from_file_location("exp_cs_generator", CS)
    assert spec is not None and spec.loader is not None
    module = module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def main() -> None:
    gen = load_cs_module()
    OUTDIR.mkdir(parents=True, exist_ok=True)
    for phase in range(4):
        func = f"fiat_mul_u4_p{phase}"
        prologue, body = gen.extract_body(SRC, func)
        normalized, counts = gen.normalize(body)
        # SLOTHY's Armv8.1-M parser accepts the typed form while the source
        # uses the assembler-equivalent untyped alias.  Make the datatype
        # explicit without changing the instruction semantics.
        normalized = [re.sub(r"\bvorr\s+(q\d+\s*,\s*q\d+\s*,\s*q\d+)",
                             r"vorr.i32 \1", line)
                      for line in normalized]
        unique, frame = gen.uniquify_spills(normalized, 0)
        scalar = [line for line in unique if not __import__("re").search(
            r"\bq\d|\bv(ldr|str|eor|add|orr|bic|shl|sri|mov)", line)]
        lines = [
            f"// expDB {func}: original {len(body)}, safe {len(unique)}, "
            f"scalar {len(scalar)}, vector {len(unique) - len(scalar)}, frame {frame}",
            "start:", *unique, "end:",
        ]
        (OUTDIR / f"p{phase}_raw.s").write_text(
            "\n".join(lines) + "\n", encoding="utf-8", newline="\n")
        (OUTDIR / f"p{phase}_meta.txt").write_text(
            f"func={func}\nprologue={len(prologue)}\norig={len(body)}\n"
            f"safe={len(unique)}\nframe={frame}\nldrd={counts['ldrd']}\n"
            f"strd={counts['strd']}\n", encoding="utf-8", newline="\n")
        print(f"{func}: {len(body)} -> {len(unique)}, frame={frame}")


if __name__ == "__main__":
    main()
