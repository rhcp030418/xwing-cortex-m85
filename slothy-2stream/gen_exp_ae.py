"""Generate the real-operand Fiat yield1+b1 fragments for experiment AE."""

import os
from pathlib import Path

from gen_exp_u import one_base_body, parse_fiat


HERE = Path(__file__).resolve().parent
SRC = HERE / "fiat_yield1_r11_o2.s"
OUT = HERE.parent / "measure-harness" / "expAE-src" / "fiat_u_stitch_m85.S"


def split_evenly(items, count):
    return [items[len(items) * i // count: len(items) * (i + 1) // count]
            for i in range(count)]


def weave(scalar, vector):
    out = []
    total = max(len(scalar), len(vector))
    si = vi = 0
    for slot in range(total):
        while si < len(scalar) and si * total // len(scalar) == slot:
            out.append(scalar[si])
            si += 1
        while vi < len(vector) and vi * total // len(vector) == slot:
            out.append(vector[vi])
            vi += 1
    out.extend(scalar[si:])
    out.extend(vector[vi:])
    return out


def replace_iota_with_rc(body):
    assert body[-4].strip() == "vmov.i32 q0, #1"
    assert body[-3].strip() == "vldrw.u32 q1, [r11, #-508]"
    assert body[-2].strip() == "veor q1, q1, q0"
    assert body[-1].strip() == "vstrw.u32 q1, [r11, #-508]"
    return body[:-4] + [
        "\tvldrw.u32 q0, [r11, #-108]",
        "\tvldrw.u32 q1, [r11, #-508]",
        "\tveor q1, q1, q0",
        "\tvstrw.u32 q1, [r11, #-508]",
        "\tvldrw.u32 q0, [r11, #-92]",
        "\tvldrw.u32 q1, [r11, #4]",
        "\tveor q1, q1, q0",
        "\tvstrw.u32 q1, [r11, #4]",
    ]


def function(name, body, frame, setup=()):
    assert frame == 144
    return [
        f".global {name}", f".type {name}, %function", ".thumb_func",
        ".balign 16", f"{name}:",
        # r11 is the b1 contiguous base.  Preserve the caller value at every
        # C/asm boundary; r3 is included so the public stack stays 8-byte aligned.
        "\tpush {r3-r11, lr}", f"\tsub sp, sp, #{frame}",
        *setup, *body,
        f"\tadd sp, sp, #{frame}", "\tpop {r3-r11, pc}",
        f".size {name}, .-{name}", "",
    ]


def phase0_setup():
    # Preserve the arbitrary Fiat operands while r11 and q7 are initialized.
    return [
        "\tpush {r0-r2}",
        "\tmovw r11, #:lower16:g_u_mve_block",
        "\tmovt r11, #:upper16:g_u_mve_block",
        "\tldr r11, [r11]",
        "\tadd r11, r11, #508",
        "\tadr r3, 1f", "\tb 2f", ".balign 16",
        "1:\t.word 0, 4, 8, 12", "2:",
        "\tvldrw.u32 q7, [r3]",
        "\tmovw r3, #:lower16:g_u_mve_block",
        "\tmovt r3, #:upper16:g_u_mve_block",
        "\tldr r3, [r3]",
        "\tadd r3, r3, #1524",
        "\tvadd.i32 q7, q7, r3",
        "\tpop {r0-r2}",
    ]


def main():
    scalar, frame = parse_fiat(SRC, "fiat_mul_ref")
    assert not any("r11" in ins or "fp" in ins for ins in scalar)
    assert not any(f"q{i}" in ins for ins in scalar for i in range(8))

    vector, contiguous, gather = one_base_body("r10", "r11")
    vector = replace_iota_with_rc(vector)
    assert (contiguous, gather) == (166, 136)

    out = [
        os.environ.get("EXP_AF_U_SECTION", ".text"),
        ".syntax unified", ".thumb", ".arch armv8.1-m.main",
        ".arch_extension mve", "",
        "// Experiment AE: arbitrary-operand r11-fixed Fiat mul + b1 fragments.",
    ]
    out += function("fiat_mul_y11_scalar", scalar, frame)
    for ratio in (4, 8):
        if ratio == 8 and os.environ.get("EXP_AF_U8_SECTION"):
            out += [os.environ["EXP_AF_U8_SECTION"], ""]
        chunks = split_evenly(vector, ratio)
        for phase, chunk in enumerate(chunks):
            # Real ladder steps return through C between fragments, so the
            # ABI-safe implementation reconstructs r11/q7 at each boundary.
            setup = phase0_setup()
            out += function(f"fiat_mul_u{ratio}_p{phase}",
                            weave(scalar, chunk), frame, setup)

    out += [
        ".global fiat_u_qsave", ".type fiat_u_qsave, %function", ".thumb_func",
        "fiat_u_qsave:", "\tvstrw.u32 q4, [r0, #0]",
        "\tvstrw.u32 q5, [r0, #16]", "\tvstrw.u32 q6, [r0, #32]",
        "\tvstrw.u32 q7, [r0, #48]", "\tbx lr", "",
        ".global fiat_u_qrestore", ".type fiat_u_qrestore, %function", ".thumb_func",
        "fiat_u_qrestore:", "\tvldrw.u32 q4, [r0, #0]",
        "\tvldrw.u32 q5, [r0, #16]", "\tvldrw.u32 q6, [r0, #32]",
        "\tvldrw.u32 q7, [r0, #48]", "\tbx lr", "",
    ]

    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text("\n".join(out) + "\n", encoding="utf-8", newline="\n")
    print(f"scalar={len(scalar)} frame={frame} b1={len(vector)} "
          f"contiguous={contiguous} gather={gather}")
    print(f"wrote {OUT}")


if __name__ == "__main__":
    main()
