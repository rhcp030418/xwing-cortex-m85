# 실험 E 보드 커널 생성: 4단계 비율 코어 (곱×4 + 라운드) — 순차 / SLOTHY
# 사용법(Windows): py gen_board_expe.py
import os

D = r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\slothy-2stream"
OUT = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\expe_board.s"


def read_body(path):
    body = []
    for ln in open(path, encoding="utf-8"):
        code = ln.split("//")[0].strip()
        if not code or code.endswith(":"):
            continue
        body.append("\t" + code)
    return body


def emit(name, body):
    # 카운터 [r12,#1272] — 스필 303슬롯(0..1211)·포인터 슬롯과 분리
    return ([f"// {name}: counter=[r12,#1272]",
             f".global {name}", f".type {name}, %function",
             ".thumb_func", ".balign 16",
             f"{name}:",
             "\tpush {r4-r11, lr}",
             "\tmovw r8, #:lower16:g_theta_state",
             "\tmovt r8, #:upper16:g_theta_state",
             "\tmovw r12, #:lower16:g_spill",
             "\tmovt r12, #:upper16:g_spill",
             "\tstr r0, [r12, #1272]",
             ".balign 16", "1:",
             "\tmovw r0, #:lower16:g_fc_out", "\tmovt r0, #:upper16:g_fc_out",
             "\tmovw r1, #:lower16:g_fc_a", "\tmovt r1, #:upper16:g_fc_a",
             "\tmovw r2, #:lower16:g_fc_b", "\tmovt r2, #:upper16:g_fc_b"] + body +
            ["\tldr r0, [r12, #1272]",
             "\tsubs r0, r0, #1",
             "\tstr r0, [r12, #1272]",
             "\tbne 1b",
             "\tpop {r4-r11, pc}", ""])


hdr = [os.environ.get("EXP_AF_EXPE_SECTION",
                      '.section .itcm_code_from_flash, "ax", %progbits'),
       ".syntax unified", ".thumb", ""]
body_seq = read_body(D + r"\exp_e.s")
out = hdr + emit("expe_seq", body_seq)

opt = D + r"\exp_e_opt.s"
if os.path.exists(opt):
    body_opt = read_body(opt)
    print(f"opt body: {len(body_opt)} instrs")
    out += emit("expe_slothy", body_opt)
else:
    print("exp_e_opt.s 없음 — 솔버 완료 후 재실행")
    out += [".global expe_slothy", ".thumb_func", "expe_slothy:", "\tbx lr", ""]

open(OUT, "w", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
print(f"seq={len(body_seq)} -> expe_board.s")
