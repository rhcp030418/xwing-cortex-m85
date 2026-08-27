# 실험 D 보드 커널 생성: fiat × 비트-인터리브 라운드 — 순차 / SLOTHY (2026-08-16)
# 사용법(Windows): py gen_board_expd.py
import os

D = r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\slothy-2stream"
OUT = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\expd_board.s"


def read_body(path):
    body = []
    for ln in open(path, encoding="utf-8"):
        code = ln.split("//")[0].strip()
        if not code or code.endswith(":"):
            continue
        body.append("\t" + code)
    return body


def emit(name, body):
    return ([f"// {name}: counter=[r12,#376]",
             f".global {name}", f".type {name}, %function",
             ".thumb_func", ".balign 16",
             f"{name}:",
             "\tpush {r4-r11, lr}",
             "\tmovw r8, #:lower16:g_theta_state",
             "\tmovt r8, #:upper16:g_theta_state",
             "\tmovw r12, #:lower16:g_spill",
             "\tmovt r12, #:upper16:g_spill",
             "\tstr r0, [r12, #376]",
             ".balign 16", "1:",
             "\tmovw r0, #:lower16:g_fc_out", "\tmovt r0, #:upper16:g_fc_out",
             "\tmovw r1, #:lower16:g_fc_a", "\tmovt r1, #:upper16:g_fc_a",
             "\tmovw r2, #:lower16:g_fc_b", "\tmovt r2, #:upper16:g_fc_b"] + body +
            ["\tldr r0, [r12, #376]",
             "\tsubs r0, r0, #1",
             "\tstr r0, [r12, #376]",
             "\tbne 1b",
             "\tpop {r4-r11, pc}", ""])


hdr = ['.section .itcm_code_from_flash, "ax", %progbits', ".syntax unified", ".thumb", ""]
body_seq = read_body(D + r"\exp_d.s")
out = hdr + emit("expd_seq", body_seq)

opt = D + r"\exp_d_opt.s"
if os.path.exists(opt):
    body_opt = read_body(opt)
    print(f"opt body: {len(body_opt)} instrs")
    out += emit("expd_slothy", body_opt)
else:
    print("exp_d_opt.s 없음 — 솔버 완료 후 재실행")
    out += [".global expd_slothy", ".thumb_func", "expd_slothy:", "\tbx lr", ""]

open(OUT, "w", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
print(f"seq={len(body_seq)} -> expd_board.s")
