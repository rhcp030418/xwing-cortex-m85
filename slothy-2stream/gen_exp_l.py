# 실험 L — NTT 짝 대조: A=umaal 체인(기존 코이슈와 동일) × B=NTT 버터플라이형 MVE.
# B: E'=E+lo(E*O), O'=O-hi(E*O) — 몽고메리 2-곱 패턴(vmul low + vmulh high) 프록시, 3패스.
# 가설: 곱셈기 공유로 은닉 붕괴(Keccak 58% 대비) = "곱셈기 쟁탈전" 실증.
# 사용법: py gen_exp_l.py
import sys

sys.path.insert(0, r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\measure-harness")
from stitch_zip import zip_streams  # noqa: E402

OUT = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\expl_board.s"


def ntt_pass():
    # 베이스 r10 = 블록+400 (E off -400..-16, O off 112..496 — 1베이스 커버)
    ins = []
    for i in range(25):
        e, o = 16 * i - 400, 112 + 16 * i
        ins += [f"\tvldrw.u32 q0, [r10, #{e}]",
                f"\tvldrw.u32 q1, [r10, #{o}]",
                "\tvmul.i32 q2, q0, q1",
                "\tvmulh.u32 q3, q0, q1",
                "\tvadd.i32 q0, q0, q2",
                "\tvsub.i32 q1, q1, q3",
                f"\tvstrw.u32 q0, [r10, #{e}]",
                f"\tvstrw.u32 q1, [r10, #{o}]"]
    return ins


body = ntt_pass() * 3                      # 600 instrs — keccak 라운드(611)와 동급 규모
a = ["\tumaal r0, r1, r2, r3"] * 611       # 기존 coissue-A와 동일
zipped = zip_streams([[i] for i in a], body)


def wrap(name, body, cnt="lr"):
    return ([f"// {name}", f".global {name}", f".type {name}, %function",
             ".thumb_func", ".balign 16", f"{name}:",
             "\tpush {r4-r11, lr}", "\tvpush {d8-d15}",
             f"\tmov {cnt}, r0",
             "\tadd r10, r1, #400",
             "\tmovs r2, #3", "\tmovs r3, #5", "\tmovs r0, #0", "\tmovs r1, #0",
             ".balign 16", "1:"] + body +
            [f"\tsubs {cnt}, {cnt}, #1", "\tbne 1b",
             "\tvpop {d8-d15}", "\tpop {r4-r11, pc}", ""])


# 스칼라 NTT판(플랜 A 세계): smull 체인 — A(umaal)와 같은 스칼라 MAC 파이프 쟁탈
# dst 교대(r4/r5 ↔ r8/r9)로 WAW 직렬화 배제 — 병목이 순수 MAC 처리량이 되게
s_ntt = []
for i in range(600):
    d = ("r4, r5" if i % 2 == 0 else "r8, r9")
    s_ntt.append(f"\tsmull {d}, r6, r7")
s_zip = zip_streams([[i] for i in a], s_ntt)

out = [".text", ".syntax unified", ".thumb", ""]
out += wrap("expl_ntt", body, cnt="lr")        # B(MVE) 단독
out += wrap("expl_zip", zipped, cnt="lr")      # 스칼라×MVE 코이슈
out += wrap("expl_sntt", s_ntt, cnt="lr")      # B(스칼라 smull) 단독
out += wrap("expl_szip", s_zip, cnt="lr")      # 스칼라×스칼라 지퍼 (쟁탈전 판정)
open(OUT, "w", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
print(f"ntt={len(body)} zip={len(zipped)} sntt={len(s_ntt)} szip={len(s_zip)} -> expl_board.s")
