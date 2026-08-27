# B-mid 3파전 보드 커널 생성: 순차 / 지퍼 v0.3 / SLOTHY 스케줄 (2026-08-16)
# 같은 156명령 재료로 세 배치를 만들어 blinky 프로젝트에 설치 → 실측 비교.
# 사용법(Windows): py gen_board_bmid.py
import re
import sys

sys.path.insert(0, r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\measure-harness")
from stitch_zip import theta_stream, zip_streams  # noqa: E402

D = r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\slothy-2stream"
OUT = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\bmid_board.s"

GROUP = ["\tumull r0, r1, r4, r5",
         "\tumaal r0, r1, r4, r6",
         "\tadds r2, r2, r0",
         "\tadcs r3, r3, r1",
         "\tumull r0, r1, r5, r6",
         "\tadds r2, r2, r0",
         "\tadc r3, r3, r1"]
a = []
for _ in range(8):
    a += GROUP
b = theta_stream()

body_seq = a + b
body_zip = zip_streams([[i] for i in a], b)


def parse_opt(path):
    body = []
    for ln in open(path, encoding="utf-8"):
        code = ln.split("//")[0].strip()
        if not code or code.endswith(":"):
            continue
        body.append("\t" + code)
    return body


body_opt = parse_opt(D + r"\exp_bmid_opt.s")
assert len(body_opt) == len(body_seq), f"opt {len(body_opt)} != seq {len(body_seq)}"


def free_regs(body, n):
    used = set()
    for ln in body:
        for m in re.findall(r"\b(r\d+|lr|ip|fp|sl)\b", ln):
            used.add(m)
    free = [c for c in ["r7", "r11", "r12", "lr"] if c not in used]
    if len(free) < n:
        raise SystemExit(f"free regs {free} < {n}: used={sorted(used)}")
    return free[:n]


def emit(name, body):
    # cnt=루프 카운터 (솔버판은 r0-r12 전부 사용 → lr만 남음).
    # r8(상태 포인터)은 솔버가 죽은 레지스터로 재활용했을 수 있어 모든 변형이
    # 공통으로 루프마다 movw/movt 절대주소 재로드 (공정한 +2cyc/iter).
    (cnt,) = free_regs(body, 1)
    return ([f"// {name}: counter={cnt}",
             f".global {name}", f".type {name}, %function",
             ".thumb_func", ".balign 16",
             f"{name}:",
             "\tpush {r4-r11, lr}",
             f"\tmov {cnt}, r0",
             "\tmovs r2, #0", "\tmovs r3, #0",
             "\tmovs r4, #3", "\tmovs r5, #5", "\tmovs r6, #7",
             ".balign 16", "1:",
             "\tmovw r8, #:lower16:g_theta_state",
             "\tmovt r8, #:upper16:g_theta_state"] + body +
            [f"\tsubs {cnt}, {cnt}, #1", "\tbne 1b", "\tpop {r4-r11, pc}", ""])


hdr = ['.section .itcm_code_from_flash, "ax", %progbits', ".syntax unified", ".thumb", ""]
out = hdr + emit("bmid_seq", body_seq) + emit("bmid_zip", body_zip) + emit("bmid_slothy", body_opt)
open(OUT, "w", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
print(f"seq={len(body_seq)} zip={len(body_zip)} opt={len(body_opt)} -> bmid_board.s")
