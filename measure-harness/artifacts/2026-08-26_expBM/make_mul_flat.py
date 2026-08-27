"""expBM-A: fe25519_mul 프레임 평탄화본 생성.

사전등록 2026-08-26_expBM_x01v2_flatframe_prereg.md §2 의 치환표를 그대로 적용한다.
명령 수·메모리 워드 수는 바뀌지 않아야 한다.
"""
import io
import re

SCR = r"C:\Users\cnscj\AppData\Local\Temp\claude\c--Users-cnscj-Dropbox--------\c4b4d467-bd80-48c5-890a-0c10b42283e7\scratchpad"
OUT = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\fe25519_mul_flat.S"

body = io.open(SCR + r"\mul.s", encoding="utf-8", errors="surrogateescape").read().splitlines()

REPL = [
    ("sub sp,#28",            "sub sp,#40"),
    ("push {r6,r7}",          "strd r6,r7,[sp,#0]"),
    ("push {r0}",             "str r0,[sp,#36]"),
    ("pop {r11}",             "ldr r11,[sp,#36]"),
    ("str r11,[sp,#16+4]",    "str r11,[sp,#16]"),
    ("str r12,[sp,#20+4]",    "str r12,[sp,#20]"),
    ("str lr,[sp,#24+4]",     "str lr,[sp,#24]"),
    ("str r0,[sp,#28+4]",     "str r0,[sp,#28]"),
    ("str r11,[sp,#32+4]",    "str r11,[sp,#32]"),
    ("pop {r0-r2}",           "ldm sp,{r0,r1,r2}"),
    ("pop {r3,r4}",           "ldrd r3,r4,[sp,#12]"),
    ("pop {r5,r6}",           "ldrd r5,r6,[sp,#20]"),
    ("add sp,#12",            "add sp,#44"),
]

seen = dict((a, 0) for a, _ in REPL)
out = []
for ln in body:
    t = ln.strip()
    if t.startswith("//"):
        out.append(ln)
        continue
    hit = None
    for a, b in REPL:
        if t == a:
            hit = (a, b)
            break
    if hit:
        seen[hit[0]] += 1
        out.append("\t" + hit[1])
    else:
        out.append(ln)

bad = [a for a, n in seen.items() if n != 1]
assert not bad, ("치환 횟수 이상: %r" % bad, seen)

txt = "\n".join(out)
txt = txt.replace("apx_real_fe25519_mul", "fe25519_mul_flat")
# frame 주석은 더 이상 맞지 않으므로 제거
txt = "\n".join(l for l in txt.splitlines() if "//frame" not in l)

hdr = """/* 실험 BM-A (X01-v2): fe25519_mul 프레임 평탄화본.
 *
 * 사전등록: 2026-08-26_expBM_x01v2_flatframe_prereg.md
 * 원본(apx_real_fe25519_mul)의 중간 push/pop 을 고정 오프셋 str/ldr 로 바꿔
 * 본문 내내 sp 를 고정한다. **명령 수·메모리 워드 수 불변.**
 *
 * 프레임(진입 sp = E, 본문 sp = E-48):
 *   [sp,#0] r6   [sp,#16] 저장1  [sp,#32] 저장5
 *   [sp,#4] r7   [sp,#20] 저장2  [sp,#36] r0 임시
 *   [sp,#8] r8   [sp,#24] 저장3  [sp,#40] 저장된 r2(인자)
 *   [sp,#12] r9  [sp,#28] 저장4  [sp,#44] lr
 *
 * ABI 는 원본과 동일: 입력 *r1=a, *r2=b / 출력 r0-r7 / r8-r12 clobber.
 */
	.syntax unified
	.thumb
	.section .itcm_code_from_flash, "ax", %progbits
	.align 2

	.type fe25519_mul_flat, %function
	.global fe25519_mul_flat
"""
io.open(OUT, "w", encoding="utf-8", errors="surrogateescape", newline="").write(
    hdr + txt + "\n")


def count_instr(lines):
    n = 0
    for ln in lines:
        t = ln.strip()
        if not t or t.startswith("//") or t.startswith(".") or t.endswith(":"):
            continue
        n += 1
    return n


print("원본 명령 수:", count_instr(body))
print("평탄화 명령 수:", count_instr(out))
print("남은 sp 조작:", [l.strip() for l in out
                        if re.match(r"\s*(push|pop|sub\s+sp|add\s+sp)", l)])
