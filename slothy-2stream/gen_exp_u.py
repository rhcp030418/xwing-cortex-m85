"""실험 U: b2 + no-yield 제안의 최소 실현 가능성 게이트.

리서치 보고서는 no-yield 어셈블리가 r11을 쓰지 않는다고 했지만,
실제로는 fp 별칭으로 r11을 사용한다. 따라서 우선 GCC에 r10 또는 r11
하나만 양보한 yield1 둘을 실제로 컴파일하고, b2의 한 영역은 연속
접근, 다른 영역은 q7 개더/스캐터로 처리하는 b1 하이브리드를 측정한다.

이 실험은 완전한 phase-scoped b2가 아니라, 복잡한 동적 GP borrowing 전에
실제 회수 가능 예산을 보는 기능 등가 중간 게이트다.
"""

import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from mve_keccak import rename_q, round_mve4_b2  # noqa: E402

sys.path.insert(0, os.path.join(HERE, "..", "measure-harness"))
from stitch_zip import zip_streams  # noqa: E402


LOADP = [
    "\tmovw r0, #:lower16:g_fc_out", "\tmovt r0, #:upper16:g_fc_out",
    "\tmovw r1, #:lower16:g_fc_a", "\tmovt r1, #:upper16:g_fc_a",
    "\tmovw r2, #:lower16:g_fc_b", "\tmovt r2, #:upper16:g_fc_b",
]


def parse_fiat(path, label):
    """GCC 함수 본문만 추출하고 스택 프레임은 wrapper가 1회 구성."""
    lines = open(path, encoding="utf-8", errors="replace").read().splitlines()
    body, in_function, frame = [], False, 0
    for line in lines:
        if re.match(rf"^{re.escape(label)}:", line):
            in_function = True
            continue
        if not in_function:
            continue
        stripped = line.strip()
        if not stripped or stripped.startswith((".", "@", "//")):
            if stripped.startswith(".size"):
                break
            continue
        if stripped.startswith(("push", "pop")):
            continue
        match = re.match(r"(sub|add)\s+sp,\s*(?:sp,\s*)?#(\d+)", stripped)
        if match:
            if match.group(1) == "sub":
                frame = max(frame, int(match.group(2)))
            continue
        body.append("\t" + stripped)
    return body, frame


def wrap(name, setup_instructions, body, frame):
    """fiat의 모든 가용 GP를 보존하려 루프 카운터는 스택에 둔다."""
    wrapper_frame = frame + 8
    return (
        [
            f"// {name}", f".global {name}", f".type {name}, %function",
            ".thumb_func", ".balign 16", f"{name}:",
            "\tpush {r4-r11, lr}", "\tvpush {d8-d15}",
            f"\tsub sp, sp, #{wrapper_frame}", f"\tstr r0, [sp, #{frame}]",
        ]
        + setup_instructions
        + [".balign 16", "1:"]
        + body
        + [
            f"\tldr r0, [sp, #{frame}]", "\tsubs r0, r0, #1",
            f"\tstr r0, [sp, #{frame}]", "\tbne 1b",
            f"\tadd sp, sp, #{wrapper_frame}", "\tvpop {d8-d15}",
            "\tpop {r4-r11, pc}", "",
        ]
    )


SRC_R10 = os.path.join(HERE, "fiat_yield1_r10_o2.s")
SRC_R11 = os.path.join(HERE, "fiat_yield1_r11_o2.s")
DST = os.environ.get(
    "EXPU_OUT",
    r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\expu_board.s",
)


def one_base_body(fixed_original, fixed_register):
    """b2의 한 앵커만 GP에 남기고 나머지는 q7 주소 벡터로 변환."""
    assert fixed_original in ("r10", "r11")
    assert fixed_register in ("r10", "r11")
    body = rename_q(round_mve4_b2(), list(range(7)))  # q7은 주소 벡터
    out = []
    mem_re = re.compile(
        r"(\s*v(?:ldrw|strw)\.u32 q\d+), \[(r10|r11), #(-?\d+)\]"
    )
    contiguous = gather = 0
    for ins in body:
        match = mem_re.match(ins)
        if not match:
            out.append(ins)
            continue
        prefix, original, offset = match.groups()
        if original == fixed_original:
            out.append(f"{prefix}, [{fixed_register}, #{offset}]")
            contiguous += 1
        else:
            out.append(f"{prefix}, [q7, #{offset}]")
            gather += 1
    assert contiguous + gather == 302
    assert len(out) == 611
    assert not any(
        re.search(r"\bq7\b", ins) and "[q7," not in ins for ins in out
    )
    return out, contiguous, gather


def setup(fixed_original, fixed_register):
    """fixed GP 앵커와 반대쪽 q7 주소 벡터를 루프 밖에서 1회 구성."""
    fixed_anchor = 508 if fixed_original == "r10" else 1524
    gather_anchor = 1524 if fixed_original == "r10" else 508
    return [
        f"\tmovw {fixed_register}, #:lower16:g_mve",
        f"\tmovt {fixed_register}, #:upper16:g_mve",
        f"\tadd {fixed_register}, {fixed_register}, #{fixed_anchor}",
        "\tadr r2, 2f",
        "\tb 3f",
        "\t.balign 16",
        "2:\t.word 0, 4, 8, 12",
        "3:",
        "\tvldrw.u32 q7, [r2]",
        "\tmovw r3, #:lower16:g_mve",
        "\tmovt r3, #:upper16:g_mve",
        f"\tadd r3, r3, #{gather_anchor}",
        "\tvadd.i32 q7, q7, r3",
    ]


def zipped(a, b):
    return zip_streams([[ins] for ins in a], b)


def add_family(out, tag, scalar, frame, mve, common):
    unit = LOADP + scalar
    out += wrap(f"expu_{tag}_b1", common, mve, frame)
    out += wrap(f"expu_{tag}_seq", common, unit + mve, frame)
    out += wrap(f"expu_{tag}_stitch", common, zipped(unit, mve), frame)
    out += wrap(f"expu_{tag}_m4_seq", common, unit * 4 + mve, frame)
    out += wrap(f"expu_{tag}_m4_stitch", common, zipped(unit * 4, mve), frame)
    out += wrap(f"expu_{tag}_m8_seq", common, unit * 8 + mve, frame)
    out += wrap(f"expu_{tag}_m8_stitch", common, zipped(unit * 8, mve), frame)


def main():
    y10, frame10 = parse_fiat(SRC_R10, "fiat_mul_ref")
    y11, frame11 = parse_fiat(SRC_R11, "fiat_mul_ref")
    assert not any(re.search(r"\br10\b", ins) for ins in y10)
    assert not any(re.search(r"\b(?:r11|fp)\b", ins) for ins in y11)
    assert not any(re.search(r"\bq[0-7]\b", ins) for ins in y10 + y11)

    # low(166 accesses)를 연속 접근으로 남기는 두 레지스터 할당과,
    # r11 yield1에서 high(136 accesses)를 연속으로 남긴 대조군을 둘다.
    b1lo10, c_lo10, g_lo10 = one_base_body("r10", "r10")
    b1lo11, c_lo11, g_lo11 = one_base_body("r10", "r11")
    b1hi11, c_hi11, g_hi11 = one_base_body("r11", "r11")
    assert (c_lo10, g_lo10) == (166, 136)
    assert (c_lo11, g_lo11) == (166, 136)
    assert (c_hi11, g_hi11) == (136, 166)

    out = [
        ".text", ".syntax unified", ".thumb", "",
        "// Experiment U: one-GP b1 feasibility gate for phase-scoped b2/no-yield.",
    ]
    out += wrap("expu_y10", [], LOADP + y10, frame10)
    out += wrap("expu_y11", [], LOADP + y11, frame11)
    add_family(out, "lo10", y10, frame10, b1lo10, setup("r10", "r10"))
    add_family(out, "lo11", y11, frame11, b1lo11, setup("r10", "r11"))
    add_family(out, "hi11", y11, frame11, b1hi11, setup("r11", "r11"))

    os.makedirs(os.path.dirname(os.path.abspath(DST)), exist_ok=True)
    with open(DST, "w", encoding="utf-8", newline="\n") as handle:
        handle.write("\n".join(out) + "\n")
    print(
        f"yield1: r10-fixed={len(y10)} frame={frame10}B, "
        f"r11-fixed={len(y11)} frame={frame11}B"
    )
    print(
        f"b1 low-contiguous={c_lo11}/gather={g_lo11}; "
        f"high-contiguous={c_hi11}/gather={g_hi11}; wrote {DST}"
    )


if __name__ == "__main__":
    main()
