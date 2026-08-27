"""expCC-2: **실측 배치 규칙**을 넣은 병합 커널 생성.

규칙 (expBZ/expCB/expCC 실측):
  MVE 연산  x 스칼라 무엇이든  -> 100% 겹침
  MVE 적재  x 스칼라 연산      -> 100% 겹침
  MVE 적재  x 스칼라 적재      ->   0%   (같은 메모리 포트)
  MVE 저장  x 스칼라 무엇이든  ->   0%   (스칼라 포트를 통째로 막는다)

따라서:
  - `vstrw` 슬롯 옆에는 스칼라를 **아무것도** 두지 않는다.
  - `vldrw` 슬롯 옆에는 스칼라 **비-메모리** 명령만 둔다.
  - 그 밖에는 자유.
"""
import io
import re

SCR = (r"C:\Users\cnscj\AppData\Local\Temp\claude\c--Users-cnscj-Dropbox--------"
       r"\c4b4d467-bd80-48c5-890a-0c10b42283e7\scratchpad")
OUT = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\expCA_stitch.S"

NTT = [l.strip() for l in
       io.open(SCR + r"\layer67_body.S", encoding="utf-8").read().splitlines()
       if l.strip()]
assert len(NTT) == 46
NTT = [re.sub(r"\br0\b", "r7", t) for t in NTT]

KEC = ["ldrd\tr4, r5, [r0], #8", "movs\tr3, r4",
       "bfi\tr4, r5, #16, #16", "bfc\tr5, #0, #16",
       "orr\tr5, r5, r3, LSR #16"]
for k, m in ((8, "#0x0000FF00"), (4, "#0x00F000F0"),
             (2, "#0x0C0C0C0C"), (1, "#0x22222222")):
    KEC += ["eor\tr3, r4, r4, LSR #%d" % k,
            "eor\tr6, r5, r5, LSR #%d" % k,
            "and\tr3, r3, %s" % m,
            "and\tr6, r6, %s" % m,
            "eors\tr4, r4, r3",
            "eors\tr5, r5, r6",
            "eor\tr4, r4, r3, LSL #%d" % k,
            "eor\tr5, r5, r6, LSL #%d" % k]
KEC += ["str\tr4, [r1], #4", "str\tr5, [r1], #4"]

NTT_ITERS = 4
KEC_LANES = 6

ntt_stream = NTT * NTT_ITERS
kec_stream = KEC * KEC_LANES


def mve_kind(t):
    mn = t.split()[0].lower()
    if mn.startswith("vstr"):
        return "store"
    if mn.startswith("vldr"):
        return "load"
    return "alu"


def scal_kind(t):
    mn = t.split()[0].lower()
    if mn.startswith(("str", "stm")):
        return "store"
    if mn.startswith(("ldr", "ldm")):
        return "load"
    return "alu"


nk = [mve_kind(t) for t in ntt_stream]
sk = [scal_kind(t) for t in kec_stream]
print("NTT: load %d  store %d  alu %d"
      % (nk.count("load"), nk.count("store"), nk.count("alu")))
print("KEC: load %d  store %d  alu %d"
      % (sk.count("load"), sk.count("store"), sk.count("alu")))

# 각 MVE 슬롯이 받을 수 있는 스칼라 종류
def allows(k):
    if k == "store":
        return set()                 # 아무것도 못 붙인다
    if k == "load":
        return {"alu", "store"}      # 스칼라 적재만 금지
    return {"alu", "load", "store"}  # 자유


merged = []
si = 0
n_slots = sum(1 for k in nk if k != "store")
per = len(kec_stream) / float(max(n_slots, 1))
acc = 0.0
skipped_kind = 0
for i, t in enumerate(ntt_stream):
    merged.append(t)
    ok = allows(nk[i])
    if not ok:
        continue
    acc += per
    while si < len(kec_stream) and acc >= 1.0:
        if sk[si] in ok:
            merged.append(kec_stream[si])
            si += 1
            acc -= 1.0
        else:
            # 이 슬롯에 못 놓는 종류 -> 다음 MVE 슬롯으로 미룬다
            skipped_kind += 1
            break
merged.extend(kec_stream[si:])
assert len(merged) == len(ntt_stream) + len(kec_stream)
print("병합 %d 명령 (규칙 때문에 미룬 횟수 %d, 꼬리로 밀린 스칼라 %d)"
      % (len(merged), skipped_kind, len(kec_stream) - si))

HDR = """/* 실험 CC-2: **실측 배치 규칙**을 적용한 병합 커널.
 *
 * 사전등록: 2026-08-27_expCC_prereg.md §4 (gate: 은닉률 >= 80%%)
 *
 * 규칙(expBZ/expCB/expCC 실측):
 *   MVE 연산 x 스칼라 무엇이든 = 100%% 겹침
 *   MVE 적재 x 스칼라 연산     = 100%% / x 스칼라 적재 = 0%%
 *   MVE 저장 x 스칼라 무엇이든 = 0%%   -> vstrw 옆에는 스칼라를 두지 않는다
 *
 *   A  expca_ntt_only  : layer67 x%d (%d MVE)
 *   B  expca_kec_only  : Keccak lane x%d (%d 스칼라)
 *   C  expca_merged    : 규칙 병합 (%d)
 *
 * 레지스터: NTT 의 r0 -> r7 재배치. NTT 5개 + Keccak 6개 = 11 <= 14, 스필 없음.
 */
	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %%progbits
	.align 2

	.macro CA_PRO
	push	{r4-r12, lr}
	mov	r7, r2
	mov	r11, r3
	movw	r8, #3329
	movw	r9, #20159
	movw	r12, #3329
	.endm

	.macro CA_EPI
	pop	{r4-r12, pc}
	.endm

""" % (NTT_ITERS, len(ntt_stream), KEC_LANES, len(kec_stream), len(merged))


def emit(name, body, comment):
    L = ["/* %s */" % comment, "\t.balign 16",
         "\t.type\t%s, %%function" % name, "\t.global\t%s" % name,
         "%s:" % name, "\tCA_PRO"]
    L += ["\t" + t for t in body]
    L += ["\tCA_EPI", "\t.size\t%s, .-%s" % (name, name), ""]
    return "\n".join(L)


txt = HDR
txt += emit("expca_ntt_only", ntt_stream, "A")
txt += emit("expca_kec_only", kec_stream, "B")
txt += emit("expca_merged", merged, "C (규칙 병합)")
txt += "\t.ltorg\n"
io.open(OUT, "w", encoding="utf-8", newline="").write(txt)
print("saved", OUT)
