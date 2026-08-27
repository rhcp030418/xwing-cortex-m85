# 전체 규모(B-full) 보드 커널 생성: 순차 / (솔버 출력 있으면) SLOTHY (2026-08-16)
# A = mul256_flatY (스필 r12→g_spill 고유 슬롯, 540명령), B = round6 (644명령)
# 사용법(Windows): py gen_board_bfull.py
import os
import sys

sys.path.insert(0, r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\measure-harness")

D = r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\slothy-2stream"
OUT = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\bfull_board.s"


def read_expb_body(path):
    """exp_b.s(연접 입력) 또는 exp_b_opt.s(솔버 출력)에서 명령만 추출."""
    body = []
    for ln in open(path, encoding="utf-8"):
        code = ln.split("//")[0].strip()
        if not code or code.endswith(":"):
            continue
        body.append("\t" + code)
    return body


body_seq = read_expb_body(D + r"\exp_b.s")
# 지퍼 변형은 여기서 만들 수 없음: flatY는 A가 r6-r11을 자유 사용 → 지퍼 교차 시
# B(round6)의 r6-r11 쓰기가 A의 라이브 값을 파괴 (실측: bfull_zip 하드폴트로 확인).
# 전체 규모 지퍼 기준값은 flat6 기반 stitched-round6(681cyc, 로드맵 8차).


def emit(name, body):
    # 본문이 r0-r11+lr 전부 사용 → 루프 카운터는 [r12,#240](g_spill[60]) 메모리 상주.
    # (스필 고유 슬롯 34개 = 0..135B와 분리)
    # r8=상태·r12=스필 버퍼는 본문이 보존 → 진입 시 1회.
    # 포인터 인자 r0/r1/r2는 본문이 파괴 → 매 iter movw/movt 재로드 (공통 비용).
    return ([f"// {name}: counter=[r12,#240]",
             f".global {name}", f".type {name}, %function",
             ".thumb_func", ".balign 16",
             f"{name}:",
             "\tpush {r4-r11, lr}",
             "\tmovw r8, #:lower16:g_theta_state",
             "\tmovt r8, #:upper16:g_theta_state",
             "\tmovw r12, #:lower16:g_spill",
             "\tmovt r12, #:upper16:g_spill",
             "\tstr r0, [r12, #240]",
             ".balign 16", "1:",
             "\tmovw r0, #:lower16:g_bf_r", "\tmovt r0, #:upper16:g_bf_r",
             "\tmovw r1, #:lower16:g_bf_a", "\tmovt r1, #:upper16:g_bf_a",
             "\tmovw r2, #:lower16:g_bf_b", "\tmovt r2, #:upper16:g_bf_b"] + body +
            ["\tldr r0, [r12, #240]",
             "\tsubs r0, r0, #1",
             "\tstr r0, [r12, #240]",
             "\tbne 1b",
             "\tpop {r4-r11, pc}", ""])


hdr = ['.section .itcm_code_from_flash, "ax", %progbits', ".syntax unified", ".thumb", ""]
out = hdr + emit("bfull_seq", body_seq)

opt_path = D + r"\exp_b_opt.s"
if os.path.exists(opt_path):
    body_opt = read_expb_body(opt_path)
    print(f"opt body: {len(body_opt)} instrs")
    out += emit("bfull_slothy", body_opt)
else:
    print("exp_b_opt.s 없음 — 솔버 완료 후 재실행하면 bfull_slothy 추가됨")
    out += [".global bfull_slothy", ".thumb_func", "bfull_slothy:", "\tbx lr", ""]

open(OUT, "w", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
print(f"seq={len(body_seq)} -> bfull_board.s")
