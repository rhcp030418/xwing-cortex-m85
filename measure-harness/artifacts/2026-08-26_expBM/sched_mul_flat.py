"""expBM-B: 평탄화본 본문(단일 블록)을 재정렬한다. 규칙 5 — 모델 baseline 확인."""
import io
import re
import sys

sys.path.insert(0, r"C:\Users\cnscj\Dropbox\박도윤개인과제\A주제\measure-harness\expBB-src")
import resched as R

SRC = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\fe25519_mul_flat.S"
OUT = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\fe25519_mul_sched.S"

lines = io.open(SRC, encoding="utf-8", errors="surrogateescape").read().splitlines()

FIX = re.compile(r"\s*(push|pop|sub\s+sp|add\s+sp)\b")
fixed = [i for i, ln in enumerate(lines) if FIX.match(ln)]
assert len(fixed) == 4, fixed
lo, hi = fixed[1] + 1, fixed[2]          # sub sp,#40 다음 ~ add sp,#44 앞
block = lines[lo:hi]

ins = R.parse(block)
pred = R.build_deps(ins)
base = R.simulate(ins, pred, list(range(len(ins))))
order, _ = R.schedule(ins, pred)
new = R.simulate(ins, pred, order)
print("블록 명령 수: %d" % len(ins))
print("모델 baseline %.1f -> 재정렬 %.1f  (%.1f%%)" % (base, new, 100 * (base - new) / base))

slots = sorted(ins[k].idx for k in range(len(ins)))
res = list(block)
for pos, k in zip(slots, order):
    res[pos] = block[ins[k].idx]

out = lines[:lo] + res + lines[hi:]
txt = "\n".join(out).replace("fe25519_mul_flat", "fe25519_mul_sched")
txt = txt.replace("실험 BM-A (X01-v2): fe25519_mul 프레임 평탄화본",
                  "실험 BM-B (X01-v2): 평탄화본을 단일 블록으로 재정렬한 판")
io.open(OUT, "w", encoding="utf-8", errors="surrogateescape", newline="").write(txt + "\n")


def count_instr(ls):
    n = 0
    for ln in ls:
        t = ln.strip()
        if not t or t.startswith("//") or t.startswith(".") or t.endswith(":"):
            continue
        n += 1
    return n


print("평탄화 명령 수 %d -> 재정렬 명령 수 %d" % (count_instr(lines), count_instr(out)))
a = sorted(l.strip() for l in block if l.strip() and not l.strip().startswith("//"))
b = sorted(l.strip() for l in res if l.strip() and not l.strip().startswith("//"))
print("멀티셋 동일:", a == b)
