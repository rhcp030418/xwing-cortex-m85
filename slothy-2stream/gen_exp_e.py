# 실험 E 입력 생성: 4단계 코어 — fiat 곱 ×4 + 비트-인터리브 라운드 ×1 (2026-08-16)
# X-Wing encaps 실비율(fe연산:라운드 ≈ 4.25:1)의 대표 단위. 곱 4개의 인자 포인터는
# 입구에서 스필 슬롯에 1회 저장 후 각 곱 앞에서 재로드 (write-once → WAR-free).
# 사용법(Windows): py gen_exp_e.py
import re
import sys

sys.path.insert(0, r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\measure-harness")
from stitch_zip import round_stream6i  # noqa: E402

SP = r"C:\Users\cnscj\AppData\Local\Temp\claude\c--Users-cnscj-Dropbox--------\87cc9899-01a4-4c61-b1f5-c392fd51dbfe\scratchpad"
OUT = r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\slothy-2stream\exp_e.s"
N_MUL = 4


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


raw = parse_body(SP + r"\fiat_flat.s", "fiat_mul_flat")
raw = [i for i in raw if not re.match(r"\s*(sub|add)\s+sp", i)]

norm = []
for ins in raw:
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
        norm += [hi, lo] if (op == "ldr" and r_lo == base) else [lo, hi]
        continue
    norm.append(ins)

# 곱 N_MUL개 연결 (인스턴스별 스필 슬롯은 아래 고유화가 자동 분리)
PTR_SAVE = ["\tstr r0, [r12, #9000]", "\tstr r1, [r12, #9004]", "\tstr r2, [r12, #9008]"]
PTR_LOAD = ["\tldr r0, [r12, #9000]", "\tldr r1, [r12, #9004]", "\tldr r2, [r12, #9008]"]
a = PTR_SAVE[:]
for k in range(N_MUL):
    if k > 0:
        a += PTR_LOAD
    a += norm

uniq, slot_map, next_off = [], {}, 0
for ins in a:
    m = re.match(r"\s*(ldr|str)\s+(\w+),\s*\[r12,\s*#(\d+)\]", ins)
    if not m:
        uniq.append(ins)
        continue
    op, reg, off = m.group(1), m.group(2), int(m.group(3))
    if op == "str":
        if off < 9000 or off not in slot_map:   # 포인터 슬롯(9000대)은 1회만 할당
            slot_map[off] = next_off
            next_off += 4
    uniq.append(f"\t{op} {reg}, [r12, #{slot_map[off]}]")
a = uniq
print(f"spill slots: {next_off // 4} ({next_off}B)")

b = round_stream6i()
lines = ([f"// 실험 E: fiat 곱 x{N_MUL} + 인터리브 라운드 — X-Wing 실비율 코어",
          f"// A={len(a)} instrs, B={len(b)} instrs",
          "start:"] + a + b + ["end:"])
open(OUT, "w", encoding="utf-8", newline="\n").write("\n".join(lines) + "\n")
print(f"A={len(a)} B={len(b)} total={len(a) + len(b)} -> exp_e.s")
