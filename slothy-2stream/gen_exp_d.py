# 실험 D 입력 생성: fiat 필드 곱 × 비트-인터리브 Keccak 라운드 (2026-08-16)
# B 충실도 최종형 — pqm4 표현 호환. A 파이프라인은 실험 C와 동일.
# 사용법(Windows): py gen_exp_d.py
import re
import sys

sys.path.insert(0, r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\measure-harness")
from stitch_zip import round_stream6i  # noqa: E402

SP = r"C:\Users\cnscj\AppData\Local\Temp\claude\c--Users-cnscj-Dropbox--------\87cc9899-01a4-4c61-b1f5-c392fd51dbfe\scratchpad"
OUT = r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\slothy-2stream\exp_d.s"


def parse_body(path, label):
    lines = open(path, encoding="utf-8", errors="replace").read().splitlines()
    body, in_fn = [], False
    for ln in lines:
        if re.match(rf"^{label}:", ln):
            in_fn = True
            continue
        if not in_fn:
            continue
        s = ln.strip()
        if not s or s.startswith((".", "@", "//")):
            if s.startswith(".size"):
                break
            continue
        if s.startswith(("push", "pop")):
            continue
        body.append("\t" + s)
    return body


def hexify_neg_imm(m):
    return "#0x%X" % (int(m.group(1)) & 0xFFFFFFFF)


a = parse_body(SP + r"\fiat_flat.s", "fiat_mul_flat")
a = [i for i in a if not re.match(r"\s*(sub|add)\s+sp", i)]

norm = []
for ins in a:
    ins = re.sub(r"#(-\d+)", hexify_neg_imm, ins)
    ins = re.sub(r"\bfp\b", "r11", ins)
    ins = re.sub(r"\bsl\b", "r10", ins)
    ins = re.sub(r"\bip\b", "r12", ins)
    ins = ins.replace("[sp", "[r12")
    ins = re.sub(r"\[(\w+)\]", r"[\1, #0]", ins)
    m = re.match(r"\s*(ldrd|strd)\s+(\w+),\s*(\w+),\s*\[(\w+),\s*#(\d+)\]", ins)
    if m:
        op = "ldr" if m.group(1) == "ldrd" else "str"
        r_lo, r_hi, base, off = m.group(2), m.group(3), m.group(4), int(m.group(5))
        lo = f"\t{op} {r_lo}, [{base}, #{off}]"
        hi = f"\t{op} {r_hi}, [{base}, #{off + 4}]"
        if op == "ldr" and r_lo == base:   # 베이스-파괴 함정 (안전 변환 3칙)
            norm += [hi, lo]
        else:
            norm += [lo, hi]
        continue
    norm.append(ins)
a = norm

uniq, slot_map, next_off = [], {}, 0
for ins in a:
    m = re.match(r"\s*(ldr|str)\s+(\w+),\s*\[r12,\s*#(\d+)\]", ins)
    if not m:
        uniq.append(ins)
        continue
    op, reg, off = m.group(1), m.group(2), int(m.group(3))
    if op == "str":
        slot_map[off] = next_off
        next_off += 4
    uniq.append(f"\t{op} {reg}, [r12, #{slot_map[off]}]")
a = uniq
print(f"spill slots: {next_off // 4} ({next_off}B)")

b = round_stream6i()
lines = (["// 실험 D: fiat carry_mul x 비트-인터리브 Keccak 라운드 — 순차 연접",
          f"// A={len(a)} instrs, B={len(b)} instrs",
          "start:"] + a + b + ["end:"])
open(OUT, "w", encoding="utf-8", newline="\n").write("\n".join(lines) + "\n")
print(f"A={len(a)} B={len(b)} total={len(a) + len(b)} -> exp_d.s")
