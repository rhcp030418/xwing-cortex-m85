"""Add architectural even/odd register-pair constraints for LSLL/LSRL."""

from pathlib import Path
import sys


OLD = '''class {name}(MVEInstruction):
    pattern = "{mnemonic} <RdLo>, <RdHi>, <imm>"
    in_outs = ["RdLo", "RdHi"]
'''

NEW = '''class {name}(MVEInstruction):
    pattern = "{mnemonic} <RdLo>, <RdHi>, <imm>"
    in_outs = ["RdLo", "RdHi"]

    @classmethod
    def make(cls, src):
        obj = MVEInstruction.build(cls, src)
        obj.args_in_out_combinations = [
            ([0, 1], [[f"r{{i}}", f"r{{i + 1}}"] for i in range(0, 12, 2)])
        ]
        return obj
'''


def main() -> int:
    if len(sys.argv) != 2:
        raise SystemExit("usage: patch_slothy_ls_pair.py ARCH_V81M.PY")
    path = Path(sys.argv[1])
    text = path.read_text(encoding="utf-8")
    marker = "args_in_out_combinations = [\n            ([0, 1], [[f\"r{i}\""
    if text.count(marker) == 2:
        print("LS pair model already patched")
        return 0
    for name, mnemonic in (("lsll_imm", "lsll"), ("lsrl_imm", "lsrl")):
        old = OLD.format(name=name, mnemonic=mnemonic)
        new = NEW.format(name=name, mnemonic=mnemonic)
        if text.count(old) != 1:
            raise SystemExit(f"expected exactly one unpatched {name} block")
        text = text.replace(old, new)
    path.write_text(text, encoding="utf-8", newline="\n")
    print(f"patched {path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
