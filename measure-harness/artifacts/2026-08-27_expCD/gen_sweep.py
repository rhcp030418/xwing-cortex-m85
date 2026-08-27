"""expCD: 은닉 용량 곡선 — lane 1..8 전부 생성."""
import io
import re

SCR = (r"C:\Users\cnscj\AppData\Local\Temp\claude\c--Users-cnscj-Dropbox--------"
       r"\c4b4d467-bd80-48c5-890a-0c10b42283e7\scratchpad")
OUT = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\expCD_sweep.S"

NTT = [re.sub(r"\br0\b", "r7", l.strip()) for l in
       io.open(SCR + r"\layer67_body.S", encoding="utf-8").read().splitlines()
       if l.strip()]
assert len(NTT) == 46

KEC = ["ldrd\tr4, r5, [r0], #8", "movs\tr3, r4",
       "bfi\tr4, r5, #16, #16", "bfc\tr5, #0, #16",
       "orr\tr5, r5, r3, LSR #16"]
for k, m in ((8, "#0x0000FF00"), (4, "#0x00F000F0"),
             (2, "#0x0C0C0C0C"), (1, "#0x22222222")):
    KEC += ["eor\tr3, r4, r4, LSR #%d" % k,
            "eor\tr6, r5, r5, LSR #%d" % k,
            "and\tr3, r3, %s" % m, "and\tr6, r6, %s" % m,
            "eors\tr4, r4, r3", "eors\tr5, r5, r6",
            "eor\tr4, r4, r3, LSL #%d" % k,
            "eor\tr5, r5, r6, LSL #%d" % k]
KEC += ["str\tr4, [r1], #4", "str\tr5, [r1], #4"]

NTT_ITERS = 4
ntt_stream = NTT * NTT_ITERS


def mve_kind(t):
    mn = t.split()[0].lower()
    return "store" if mn.startswith("vstr") else ("load" if mn.startswith("vldr") else "alu")


def scal_kind(t):
    mn = t.split()[0].lower()
    return "store" if mn.startswith(("str", "stm")) else (
        "load" if mn.startswith(("ldr", "ldm")) else "alu")


def allows(k):
    if k == "store":
        return set()
    if k == "load":
        return {"alu", "store"}
    return {"alu", "load", "store"}


nk = [mve_kind(t) for t in ntt_stream]


def merge(kec):
    sk = [scal_kind(t) for t in kec]
    out, si, acc = [], 0, 0.0
    slots = sum(1 for k in nk if k != "store")
    per = len(kec) / float(max(slots, 1))
    for i, t in enumerate(ntt_stream):
        out.append(t)
        ok = allows(nk[i])
        if not ok:
            continue
        acc += per
        while si < len(kec) and acc >= 1.0:
            if sk[si] in ok:
                out.append(kec[si]); si += 1; acc -= 1.0
            else:
                break
    out.extend(kec[si:])
    return out


HDR = """/* 실험 CD: 은닉 용량 곡선 — lane 1..8.
 * 사전등록: 2026-08-27_expCD_prereg.md
 * 커널 17종이라 ITCM 예산을 넘어 **전부 .text** 에 둔다(사전등록 §4-1).
 * A/B/C 가 모두 같은 섹션이므로 비율 판정은 성립한다.
 */
	.syntax unified
	.thumb
	.text
	.align 2

	.macro CD_PRO
	push	{r4-r12, lr}
	mov	r7, r2
	mov	r11, r3
	movw	r8, #3329
	movw	r9, #20159
	movw	r12, #3329
	.endm

	.macro CD_EPI
	pop	{r4-r12, pc}
	.endm

"""


def emit(name, body):
    L = ["\t.balign 16", "\t.type\t%s, %%function" % name,
         "\t.global\t%s" % name, "%s:" % name, "\tCD_PRO"]
    L += ["\t" + t for t in body]
    L += ["\tCD_EPI", "\t.size\t%s, .-%s" % (name, name), ""]
    return "\n".join(L)


txt = HDR + emit("expcd_a", ntt_stream)
tot = len(ntt_stream)
for n in range(1, 9):
    kec = KEC * n
    m = merge(kec)
    txt += emit("expcd_b%d" % n, kec)
    txt += emit("expcd_c%d" % n, m)
    tot += len(kec) + len(m)
txt += "\t.ltorg\n"
io.open(OUT, "w", encoding="utf-8", newline="").write(txt)
print("A %d 명령, lane 1..8, 총 %d 명령 (~%.1f KB)" % (len(ntt_stream), tot, tot * 4 / 1024.0))
print("saved", OUT)
