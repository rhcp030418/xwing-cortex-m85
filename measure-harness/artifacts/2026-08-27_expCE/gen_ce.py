"""expCE: 누출률 법칙 k(메모리 비율) — 스칼라 스트림 5종 + 병합 5종 생성."""
import io
import re

SCR = (r"C:\Users\cnscj\AppData\Local\Temp\claude\c--Users-cnscj-Dropbox--------"
       r"\c4b4d467-bd80-48c5-890a-0c10b42283e7\scratchpad")
OUT = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\expCE_law.S"

NTT = [re.sub(r"\br0\b", "r7", l.strip()) for l in
       io.open(SCR + r"\layer67_body.S", encoding="utf-8").read().splitlines()
       if l.strip()]
assert len(NTT) == 46
ntt_stream = NTT * 4

LEN = 156
RATIOS = [(0, "r00"), (12, "r08"), (25, "r16"), (37, "r24"), (50, "r32")]


def scalar_stream(nmem):
    """156 명령. 메모리 nmem 개(ldr/str 반반)를 고르게 흩고 나머지는 umaal."""
    out = []
    if nmem == 0:
        step = None
    else:
        step = LEN / float(nmem)
    nxt = 0.0
    mi = 0
    for i in range(LEN):
        if step is not None and mi < nmem and i >= nxt:
            off = 64 + (mi % 8) * 16
            if mi % 2 == 0:
                out.append("ldr\tr4, [r0, #%d]" % off)
            else:
                out.append("str\tr5, [r0, #%d]" % off)
            mi += 1
            nxt += step
        else:
            out.append("umaal\tr2, r3, r4, r5")
    assert len(out) == LEN
    got = sum(1 for t in out if t.split()[0] in ("ldr", "str"))
    assert got == nmem, (got, nmem)
    return out


def mve_kind(t):
    mn = t.split()[0].lower()
    return "store" if mn.startswith("vstr") else ("load" if mn.startswith("vldr") else "alu")


def scal_kind(t):
    mn = t.split()[0].lower()
    return "store" if mn.startswith("str") else ("load" if mn.startswith("ldr") else "alu")


def allows(k):
    if k == "store":
        return set()
    if k == "load":
        return {"alu", "store"}
    return {"alu", "load", "store"}


nk = [mve_kind(t) for t in ntt_stream]


def merge(sc):
    sk = [scal_kind(t) for t in sc]
    out, si, acc = [], 0, 0.0
    slots = sum(1 for k in nk if k != "store")
    per = len(sc) / float(max(slots, 1))
    for i, t in enumerate(ntt_stream):
        out.append(t)
        ok = allows(nk[i])
        if not ok:
            continue
        acc += per
        while si < len(sc) and acc >= 1.0:
            if sk[si] in ok:
                out.append(sc[si]); si += 1; acc -= 1.0
            else:
                break
    out.extend(sc[si:])
    return out


HDR = """/* 실험 CE: 누출률 법칙 k(메모리 비율).
 * 사전등록: 2026-08-27_expCE_prereg.md
 * MVE 고정 = intt layer67 x4.  스칼라는 길이 156 고정, 메모리 비율만 0~32%.
 * 레지스터: NTT r7 r8 r9 r11 r12 / 스칼라 r0 r2 r3 r4 r5  = 10 <= 14, 스필 없음.
 * ITCM 예산 때문에 .text.
 */
	.syntax unified
	.thumb
	.text
	.align 2

	.macro CE_PRO
	push	{r4-r12, lr}
	mov	r7, r2
	mov	r11, r3
	movw	r8, #3329
	movw	r9, #20159
	movw	r12, #3329
	movs	r2, #3
	movs	r3, #5
	movs	r4, #7
	movs	r5, #11
	vldrw.u32	q0, [r3]
	vldrw.u32	q1, [r3, #16]
	vldrw.u32	q2, [r3, #32]
	vldrw.u32	q3, [r3, #48]
	vldrw.u32	q4, [r3, #64]
	vldrw.u32	q5, [r3, #80]
	vldrw.u32	q6, [r3, #96]
	vldrw.u32	q7, [r3, #112]
	.endm

	.macro CE_EPI
	pop	{r4-r12, pc}
	.endm

"""


def emit(name, body):
    L = ["\t.balign 16", "\t.type\t%s, %%function" % name,
         "\t.global\t%s" % name, "%s:" % name, "\tCE_PRO"]
    L += ["\t" + t for t in body]
    L += ["\tCE_EPI", "\t.size\t%s, .-%s" % (name, name), ""]
    return "\n".join(L)


txt = HDR + emit("expce_a", ntt_stream)
for nmem, tag in RATIOS:
    sc = scalar_stream(nmem)
    txt += emit("expce_b_%s" % tag, sc)
    txt += emit("expce_c_%s" % tag, merge(sc))
    print("%s: 메모리 %d/%d = %.1f%%  병합 %d 명령"
          % (tag, nmem, LEN, 100.0 * nmem / LEN, len(merge(sc)) ))
txt += "\t.ltorg\n"
io.open(OUT, "w", encoding="utf-8", newline="").write(txt)
print("saved", OUT)
