# 실험 P — DTCM 뱅크 스펙트럼: 스칼라 로드 × MVE 로드 코이슈 (2026-08-20)
#
# 목적: 실험 J의 은닉률 하락(58% -> 27%)이 "LSU 유닛 경합"인지 "DTCM 뱅크 충돌"인지
#       분리한다. 지금까지의 실험으로는 둘을 구분할 수 없다 —
#         실험 N: 스칼라 쪽에 로드가 없음(umaal 체인) -> vldrw 은닉 99%
#         실험 J: 스칼라 쪽에 fiat 스필 로드가 있어 -> 은닉 27%(→41차에 28.1%로 확정)
#         (2026-08-21 41차 정정: 여기 있던 "스필 로드 187~233개"는 23차 실험 I 의
#          "스필 접근 187→233"(base→yield3 전후 쌍, ldr+str 총계)을 잘못 옮긴 것.
#          J 가 쓰는 fiat_yield2.s 는 스필 접근 222(ldr 144/str 78), 반복당 스칼라 로드 157개)
#       두 가설 모두 "스칼라 로드가 들어오면 떨어진다"를 예측하므로 판별 불가.
#
# 근거 (Arm Cortex-M85 SWOG 107950_0100_01 §4.3 Memory banking):
#   "Each has four banks of 32-bit width with address bits [3:2] determining which
#    bank is accessed. Two load instructions issued in the same cycle to the same
#    memory bank will result in a conflict, causing the second access to stall for
#    a cycle. Ideally, scalar loads and MVE gather load accesses to the same memory
#    bank should not be adjacent in code sequences."
#   -> 스티칭은 정의상 스칼라 로드와 MVE 로드를 같은 사이클에 인접시킨다.
#
# 설계(단일 변수: 스칼라 로드의 뱅크만 바꾼다):
#   B 스트림 = vldrw [r6, #(i%25)*16]  — g_mve 가 16B 정렬이므로 302개 접근이
#              전부 뱅크 0 에서 시작해 0->3 을 훑는다(생성기에서 계산 확인).
#   A 스트림 = ldr [r7, #b*4 + (i%4)*16], r7 = g_mve+2048 (MVE 가 안 건드리는 영역)
#              -> 주소 비트[3:2] = b 로 고정. b=0,1,2,3 네 가지.
#   교란 통제: 스토어 없음(포워딩 배제) · 주소 4개 순환(같은 주소 반복 배제) ·
#              목적 레지스터 순환(스칼라 의존 사슬 배제) · 그 외 전부 동일.
#
# 판정:
#   b 에 따라 사이클이 변한다  -> 뱅크 충돌이 27% 의 일부. 레이아웃으로 회수 가능.
#   네 값이 평평하다          -> 순수 LSU 경합. 논문 §5 원인 분해 그대로(음성 결과).
#
# 사용법(Windows): py gen_exp_p.py
import os
import sys

for _p in (r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\measure-harness",
           os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "measure-harness")):
    if os.path.isdir(_p):
        sys.path.insert(0, _p)
        break
from stitch_zip import zip_streams  # noqa: E402

OUT = os.environ.get("EXPP_OUT",
                     r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\expp_board.s")
N = 611
SCALAR_AREA = 2048   # g_mve 기준 오프셋. 라운드 영역(0..2032)과 겹치지 않음


def vec_stream():
    """MVE 로드 — 전부 16B 정렬 = 뱅크 0 시작. 실험 N의 vldrw_stream 과 동일."""
    return [f"\tvldrw.u32 q{i % 8}, [r6, #{(i % 25) * 16}]" for i in range(N)]


def scalar_stream(bank):
    """스칼라 로드 — 주소 비트[3:2] 를 bank 로 고정. 목적 레지스터 4개 순환."""
    return [f"\tldr r{i % 4}, [r7, #{bank * 4 + (i % 4) * 16}]" for i in range(N)]


def banks_touched(offsets, base_aligned=16):
    """검산: 오프셋 목록이 건드리는 뱅크 집합."""
    return sorted({(o >> 2) & 3 for o in offsets})


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
             f"\tadd r7, r6, #{SCALAR_AREA}",
             ".balign 16", "1:"] + body + [
             "\tsubs r12, r12, #1",
             "\tbne 1b",
             "\tvpop {d8-d15}",
             "\tpop {r4-r11, pc}", ""])


def main():
    vec = vec_stream()
    print("MVE 로드 뱅크(시작):", banks_touched([(i % 25) * 16 for i in range(N)]),
          "  <- 전부 0 이어야 함")

    out = [".text", ".syntax unified", ".thumb", "",
           "// 실험 P: DTCM 뱅크 스펙트럼 (gen_exp_p.py 생성)"]
    out += wrap("pairp_vec", vec)
    for b in range(4):
        s = scalar_stream(b)
        assert banks_touched([b * 4 + (i % 4) * 16 for i in range(4)]) == [b]
        out += wrap(f"pairp_s{b}", s)
        out += wrap(f"pairp_s{b}_zip", zip_streams([[i] for i in s], vec))
        print(f"bank {b}: solo={len(s)} zip={2 * N}")

    open(OUT, "w", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
    print(f"-> {OUT}  (커널 9개)")


if __name__ == "__main__":
    main()
