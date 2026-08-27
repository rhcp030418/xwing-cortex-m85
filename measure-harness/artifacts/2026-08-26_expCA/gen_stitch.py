"""expCA-1: 병합 커널 3종 생성 (A=NTT만, B=Keccak만, C=병합)."""
import io
import re

SCR = (r"C:\Users\cnscj\AppData\Local\Temp\claude\c--Users-cnscj-Dropbox--------"
       r"\c4b4d467-bd80-48c5-890a-0c10b42283e7\scratchpad")
OUT = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\expCA_stitch.S"

NTT = [l.strip() for l in
       io.open(SCR + r"\layer67_body.S", encoding="utf-8").read().splitlines()
       if l.strip()]
assert len(NTT) == 46, len(NTT)

# NTT 의 r0 -> r7 재배치 (Keccak 이 r0 을 쓴다)
def remap(t):
    return re.sub(r"\br0\b", "r7", t)

NTT = [remap(t) for t in NTT]
assert not any(re.search(r"\br0\b", t) for t in NTT)

# --- Keccak extract lane 본문 (expBK 커널과 동일한 교차 배치) ---
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
assert len(KEC) == 39, len(KEC)

NTT_ITERS = 4
KEC_LANES = 8

ntt_stream = NTT * NTT_ITERS            # 368
kec_stream = KEC * KEC_LANES            # 624

# --- 병합: MVE 1개당 스칼라 약 1.7개 ---
merged = []
ki = 0
per = len(kec_stream) / float(len(ntt_stream))
acc = 0.0
for i, t in enumerate(ntt_stream):
    merged.append(t)
    acc += per
    while ki < len(kec_stream) and acc >= 1.0:
        merged.append(kec_stream[ki])
        ki += 1
        acc -= 1.0
merged.extend(kec_stream[ki:])
assert len(merged) == len(ntt_stream) + len(kec_stream)

HDR = """/* 실험 CA-1: **명령어 스티칭 실증** — intt layer67_loop x MVE 밑에 Keccak 숨기기.
 *
 * 사전등록: 2026-08-26_expCA_stitch_prereg.md
 *
 *   A  expca_ntt_only    : layer67 본문 x8 펼침 (368 MVE)
 *   B  expca_kec_only    : Keccak extract lane x16 (624 스칼라)
 *   C  expca_merged      : 둘을 엮음 (992)
 *
 * 레지스터: NTT 는 원본의 r0 을 **r7 로 재배치**했다(Keccak 이 r0 을 쓴다).
 *   NTT   : r7(저장) r11(적재) r8 r9 r12  + q0-q7
 *   Keccak: r0(state) r1(data) r3 r4 r5 r6
 *   합 11개 <= 14  -> **스필 없음**
 *
 * 진입: r0=keccak state, r1=keccak out, r7=ntt dst, r11=ntt src,
 *       r8,r9,r12 = NTT 스칼라 상수
 */
	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits
	.align 2

/* void expca_setup(void *kec_state, void *kec_out, void *ntt_dst, void *ntt_src)
 *   AAPCS r0..r3 -> 커널 규약으로 옮기고 상수를 채운다. */
	.macro CA_PRO
	push	{r4-r12, lr}
	mov	r7, r2			/* ntt dst */
	mov	r11, r3			/* ntt src */
	movw	r8, #3329
	movw	r9, #20159
	movw	r12, #3329
	.endm

	.macro CA_EPI
	pop	{r4-r12, pc}
	.endm

"""

def emit(name, body, comment):
    L = ["/* %s */" % comment,
         "\t.balign 16",
         "\t.type\t%s, %%function" % name,
         "\t.global\t%s" % name,
         "%s:" % name,
         "\tCA_PRO"]
    L += ["\t" + t for t in body]
    L += ["\tCA_EPI", "\t.size\t%s, .-%s" % (name, name), ""]
    return "\n".join(L)

txt = HDR
txt += emit("expca_ntt_only", ntt_stream, "A: NTT 만 (%d MVE)" % len(ntt_stream))
txt += emit("expca_kec_only", kec_stream, "B: Keccak 만 (%d 스칼라)" % len(kec_stream))
txt += emit("expca_merged", merged, "C: 병합 (%d)" % len(merged))
txt += "\t.ltorg\n"
io.open(OUT, "w", encoding="utf-8", newline="").write(txt)

print("A %d / B %d / C %d 명령" % (len(ntt_stream), len(kec_stream), len(merged)))
print("예상: MVE 포트 %d cyc, Keccak 스칼라 %d lane x 35.46 = %.0f cyc"
      % (len(ntt_stream) * 2, KEC_LANES, KEC_LANES * 35.46))
print("saved", OUT)
