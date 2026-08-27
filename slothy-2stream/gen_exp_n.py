# 실험 N — 페어링 스펙트럼: umaal 체인 × MVE 단일 클래스 코이슈 (2026-08-17)
# 목적: 코이슈 노출 ~40%(996 vs 예측 724)의 원인을 클래스별로 분리 →
#       모델 v0.4(TRM 페어링 보정)의 실측 입력.
# 구성(각 611명령, coissue_zip과 동일 조건 .text/플래시):
#   veor  — 비트연산(파이프 A/B 택일), 의존 거리 8
#   vldrw — 벡터 로드(E 영역 읽기, 오프셋 0..384 순환)
#   vstrw — 벡터 스토어(BE 스크래치 영역, 검증 대상 아님)
#   rot   — vshl+vsri 의존쌍(같은 파이프, Keccak 회전 관용구)
# 각각 단독 + umaal(611) 1:1 지퍼 = 8 커널, 하네스 슬롯 63~70.
# 사용법(Windows): py gen_exp_n.py
import sys

sys.path.insert(0, r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\measure-harness")
from stitch_zip import zip_streams  # noqa: E402

OUT = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\expn_board.s"
N = 611


def veor_stream():
    ins = []
    for i in range(N):
        a = i % 8
        ins.append(f"\tveor q{a}, q{a}, q{(a + 1) % 8}")
    return ins


def vldrw_stream():
    # E 영역(base+0..384) 순환 로드 — vldrw 즉치 한계 ±508 내
    return [f"\tvldrw.u32 q{i % 8}, [r6, #{(i % 25) * 16}]" for i in range(N)]


def vstrw_stream():
    # BE 스크래치(base+1024 = r9) 순환 스토어
    return [f"\tvstrw.u32 q{i % 8}, [r9, #{(i % 25) * 16}]" for i in range(N)]


def rot_stream():
    # vshl+vsri 의존쌍 — dest q0-q3, src q4-q7, 회전량 순환 (Keccak rot 관용구)
    ins = []
    i = 0
    while len(ins) < N:
        d, s, m = i % 4, 4 + i % 4, 1 + i % 31
        ins.append(f"\tvshl.i32 q{d}, q{s}, #{m}")
        if len(ins) < N:
            ins.append(f"\tvsri.32 q{d}, q{s}, #{32 - m}")
        i += 1
    return ins


A_CHAIN = ["\tumaal r0, r1, r2, r3"] * N


def wrap(name, body):
    return ([f"// {name} ({len(body)} instrs)",
             f".global {name}", f".type {name}, %function",
             ".thumb_func", ".balign 16",
             f"{name}:",
             "\tpush {r4-r11, lr}",
             "\tvpush {d8-d15}",
             "\tmov r12, r0",
             "\tmovw r6, #:lower16:g_mve",
             "\tmovt r6, #:upper16:g_mve",
             "\tadd r9, r6, #1024",
             "\tmovs r2, #3", "\tmovs r3, #5",
             "\tmovs r0, #0", "\tmovs r1, #0",
             ".balign 16", "1:"] + body + [
             "\tsubs r12, r12, #1",
             "\tbne 1b",
             "\tvpop {d8-d15}",
             "\tpop {r4-r11, pc}", ""])


def lsmix_stream():
    # vldrw/vstrw 교대(로드 E영역, 스토어 BE영역) — LSU 공유·인접 페널티 측정
    ins = []
    for i in range(N):
        off = (i % 25) * 16
        if i % 2 == 0:
            ins.append(f"\tvldrw.u32 q{i % 8}, [r6, #{off}]")
        else:
            ins.append(f"\tvstrw.u32 q{i % 8}, [r9, #{off}]")
    return ins


out = [".text", ".syntax unified", ".thumb", "",
       "// 실험 N: 페어링 스펙트럼 (gen_exp_n.py 생성)"]
for key, gen in (("veor", veor_stream), ("ldr", vldrw_stream),
                 ("str", vstrw_stream), ("rot", rot_stream)):
    b = gen()
    out += wrap(f"pairn_{key}", b)
    out += wrap(f"pairn_{key}_zip", zip_streams([[i] for i in A_CHAIN], b))
    print(f"{key}: solo={len(b)} zip={len(b) + N}")

# 실험 N2 — 2:1 비율(umaal 1222 × 클래스 611): tp-2 클래스의 "사이클당 스칼라
# 수용량" 판별. 1차(1:1)에선 단독 1222 > 스칼라 611이라 1/cyc와 0.5/cyc 구분 불가.
#   수용 1/cyc → ~1,228 · 0.5/cyc → ~1,833 · 0(차단) → ~2,444
A2 = ["\tumaal r0, r1, r2, r3"] * (2 * N)
for key, gen in (("ldr", vldrw_stream), ("str", vstrw_stream),
                 ("rot", rot_stream)):
    out += wrap(f"pairn2_{key}", zip_streams([[i] for i in A2], gen()))
    print(f"n2_{key}: zip={3 * N}")
# LSU 혼합: 로드/스토어 교대 단독 + 1:1 코이슈 (스토어만 차단이면 zip ≈ 단독+611/2?)
b = lsmix_stream()
out += wrap("pairn_lsmix", b)
out += wrap("pairn_lsmix_zip", zip_streams([[i] for i in A_CHAIN], b))
print(f"lsmix: solo={len(b)} zip={len(b) + N}")

open(OUT, "w", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
print(f"-> expn_board.s")
