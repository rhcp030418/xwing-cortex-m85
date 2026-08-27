# 실험 F 보드 커널 생성: 솔버가 스케줄한 코이슈(스칼라 MAC × MVE 라운드) (2026-08-17)
# exp_f_opt.s 본문을 래핑. 스칼라 A = r0,r1(누산)/r2,r3(재료), B = r6,r7,r9,r10,r11(베이스)+Q.
# 사용법(Windows): py gen_board_expf.py
import os

D = r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\slothy-2stream"
OUT = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\expf_board.s"


def read_body(path):
    body = []
    for ln in open(path, encoding="utf-8"):
        code = ln.split("//")[0].strip()
        if not code or code.endswith(":"):
            continue
        # SLOTHY가 붙인 vorr.u32 → 보드 어셈블러는 무-dt vorr 선호(둘 다 되지만 통일)
        body.append("\t" + code)
    return body


def emit(name, body):
    # r1 인자 = MVE 블록 베이스. 베이스 5개(r6,r7,r9,r10,r11) 유도 + 스칼라 재료 세팅.
    # 카운터는 lr (본문이 r0-r12 다 쓰지만 lr은 안 씀).
    return ([f"// {name}",
             f".global {name}", f".type {name}, %function",
             ".thumb_func", ".balign 16",
             f"{name}:",
             "\tpush {r4-r11, lr}",
             "\tvpush {d8-d15}",
             "\tmov r14, r0",              # loop counter
             "\tmov r6, r1",               # E base
             "\tadd r7, r1, #512",         # O base
             "\tadd r9, r1, #1024",        # BE base
             "\tadd r10, r1, #1536",       # BO base
             "\tadd r11, r1, #2048",       # C/D base
             "\tmovs r0, #0", "\tmovs r1, #0",   # 스칼라 누산
             "\tmovs r2, #3", "\tmovs r3, #5",   # 스칼라 재료
             ".balign 16", "1:"] + body + [
             "\tsubs r14, r14, #1",
             "\tbne 1b",
             "\tvpop {d8-d15}",
             "\tpop {r4-r11, pc}", ""])


hdr = ['.text', ".syntax unified", ".thumb", ""]
out = hdr
for src, name in ((r"\exp_f_opt.s", "coissue_slothy"),
                  (r"\exp_f2_opt.s", "coissue_slothy2")):   # v0.4 재스케줄
    if not os.path.exists(D + src):
        print(f"{src} 없음 — 건너뜀")
        continue
    body = read_body(D + src)
    out += emit(name, body)
    print(f"{name}: body={len(body)}")
open(OUT, "w", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
print("-> expf_board.s")
