# 실험 C 입력 생성: 진짜 fiat-crypto curve25519 필드 곱 × Keccak round6 (2026-08-16)
# 실전 재료 스티칭 v1 — A = fiat_25519_carry_mul (캐리 축약 포함 실제 X25519 필드 곱,
# -ffixed-r8,-r12 + MVE 비활성 파이프라인), B = round6.
# 안전 변환: 별칭 정규화 · [sp→[r12 · ldrd/strd 분해 · 스필 슬롯 고유화 (exp_b 2칙)
# 사용법(Windows): py gen_exp_c.py
import re
import sys

sys.path.insert(0, r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\measure-harness")
from stitch_zip import round_stream6  # noqa: E402

SP = r"C:\Users\cnscj\AppData\Local\Temp\claude\c--Users-cnscj-Dropbox--------\87cc9899-01a4-4c61-b1f5-c392fd51dbfe\scratchpad"
OUT = r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\slothy-2stream\exp_c.s"


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


a = parse_body(SP + r"\fiat_flat.s", "fiat_mul_flat")
frame = [i for i in a if re.match(r"\s*(sub|add)\s+sp", i)]
print("frame ops removed:", [f.strip() for f in frame])
a = [i for i in a if not re.match(r"\s*(sub|add)\s+sp", i)]

def hexify_neg_imm(m):
    return "#0x%X" % (int(m.group(1)) & 0xFFFFFFFF)


norm = []
for ins in a:
    ins = re.sub(r"#(-\d+)", hexify_neg_imm, ins)   # 음수 즉치 → 32비트 16진 (파서 호환)
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
        # ldrd 베이스-파괴 함정: 목적지가 베이스와 같으면 그 로드를 '마지막'에
        if op == "ldr" and r_lo == base:
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
print(f"spill slots uniquified: {next_off // 4} instances ({next_off}B)")

b = round_stream6()
lines = (["// 실험 C: fiat carry_mul (실전 필드 곱) + Keccak round6 — 순차 연접",
          f"// A={len(a)} instrs, B={len(b)} instrs",
          "start:"] + a + b + ["end:"])
open(OUT, "w", encoding="utf-8", newline="\n").write("\n".join(lines) + "\n")
print(f"A={len(a)} B={len(b)} total={len(a) + len(b)} -> exp_c.s")
