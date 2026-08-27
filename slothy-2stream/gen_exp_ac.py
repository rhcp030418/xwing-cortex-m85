"""Experiment AC: functional U + 24-round Keccak x4 building blocks.

The existing Lenngren field-multiply ABI already accepts arbitrary operands.
This generator keeps that ABI, dispatches eight consecutive multiplies through
eight fragments of one b0 MVE Keccak round, and leaves the scalar path intact
when no permutation is queued.  A separate b2 single-round entry is used by
standalone Keccak-f1600x4.
"""

from pathlib import Path
import re

from mve_keccak import round_mve4_b0, round_mve4_b2


HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
X25519_IN = ROOT / "artifact" / "board-src" / "x25519" / "x25519-cortex-m4-gcc.s"
OUT_DIR = ROOT / "measure-harness" / "expAC-src"
X25519_OUT = OUT_DIR / "x25519-cortex-m4-gcc.s"
MVE_OUT = OUT_DIR / "keccakx4_round_m85.S"


def rc_body(body, base):
    """Replace the round-0-only Iota tail with a staged 64-bit RC."""
    assert body[-4].strip() == "vmov.i32 q0, #1"
    assert body[-2].strip() == "veor q1, q1, q0"
    e0 = body[-3]
    e0_store = body[-1]
    if base == "b2":
        ce, co = "[r10, #-108]", "[r10, #-92]"
        o0 = "[r10, #4]"
    else:
        ce, co = "[q6, #-108]", "[q6, #-92]"
        o0 = "[q6, #4]"
    return body[:-4] + [
        f"\tvldrw.u32 q0, {ce}", e0, "\tveor q1, q1, q0", e0_store,
        f"\tvldrw.u32 q0, {co}", f"\tvldrw.u32 q1, {o0}",
        "\tveor q1, q1, q0", f"\tvstrw.u32 q1, {o0}",
    ]


def split_evenly(items, count):
    return [items[len(items) * i // count: len(items) * (i + 1) // count]
            for i in range(count)]


def extract_mul(lines):
    start = next(i for i, line in enumerate(lines)
                 if line.strip() == ".type fe25519_mul, %function")
    end = next(i for i in range(start, len(lines))
               if lines[i].strip() == ".size fe25519_mul, .-fe25519_mul")
    return start, end + 1, lines[start:end + 1]


def extract_function(lines, name):
    start = next(i for i, line in enumerate(lines)
                 if line.strip() == f".type {name}, %function")
    end = next(i for i in range(start, len(lines))
               if lines[i].strip() == f".size {name}, .-{name}")
    return start, end + 1, lines[start:end + 1]


def scalar_instructions(block):
    first = next(i for i, line in enumerate(block) if line.strip() == "push {r2,lr}")
    last = next(i for i, line in enumerate(block) if line.strip() == "pop {pc}")
    instructions = []
    for line in block[first:last]:
        stripped = line.strip()
        if stripped and not stripped.startswith("//"):
            instructions.append("\t" + stripped)
    return instructions


def stage_round():
    return [
        "\tmovw r12, #:lower16:g_u_mve_block",
        "\tmovt r12, #:upper16:g_u_mve_block", "\tldr r12, [r12]",
        "\tmovw r3, #:lower16:g_u_round", "\tmovt r3, #:upper16:g_u_round",
        "\tldr r3, [r3]", "\tmovw r0, #:lower16:g_u_rc_even",
        "\tmovt r0, #:upper16:g_u_rc_even", "\tldr r0, [r0, r3, lsl #2]",
        "\tstr r0, [r12, #400]", "\tstr r0, [r12, #404]",
        "\tstr r0, [r12, #408]", "\tstr r0, [r12, #412]",
        "\tmovw r0, #:lower16:g_u_rc_odd", "\tmovt r0, #:upper16:g_u_rc_odd",
        "\tldr r0, [r0, r3, lsl #2]",
        "\tstr r0, [r12, #416]", "\tstr r0, [r12, #420]",
        "\tstr r0, [r12, #424]", "\tstr r0, [r12, #428]",
        "\tadr r0, 9f", "\tvldrw.u32 q6, [r0]",
        "\tadd r3, r12, #1524", "\tvadd.i32 q7, q6, r3",
        "\tadd r3, r12, #508", "\tvadd.i32 q6, q6, r3",
        "\tb 10f", "\t.balign 16", "9:\t.word 0, 4, 8, 12", "10:",
    ]


def finish_fragment(index):
    common = ["\tldr lr, [sp], #4", "\tpush {r0-r7, lr}"]
    if index < 7:
        common += [
            "\tmovw r12, #:lower16:g_u_phase", "\tmovt r12, #:upper16:g_u_phase",
            f"\tmov r0, #{index + 1}",
            "\tstr r0, [r12]",
        ]
    else:
        common += [
            "\tmovw r12, #:lower16:g_u_phase", "\tmovt r12, #:upper16:g_u_phase",
            "\tmovs r0, #0", "\tstr r0, [r12]",
            "\tmovw r12, #:lower16:g_u_round", "\tmovt r12, #:upper16:g_u_round",
            "\tldr r0, [r12]", "\tadds r0, r0, #1",
            "\tstr r0, [r12]", "\tcmp r0, #24", "\tbne 11f",
            "\tmovw r12, #:lower16:g_u_active", "\tmovt r12, #:upper16:g_u_active",
            "\tmovs r0, #0", "\tstr r0, [r12]", "11:",
        ]
    return common + ["\tpop {r0-r7, lr}", "\tbx lr", ""]


def weave(scalar, vector):
    out = []
    total = max(len(scalar), len(vector))
    si = vi = 0
    for slot in range(total):
        while si < len(scalar) and si * total // len(scalar) == slot:
            out.append(scalar[si]); si += 1
        while vi < len(vector) and vi * total // len(vector) == slot:
            out.append(vector[vi]); vi += 1
    out.extend(scalar[si:]); out.extend(vector[vi:])
    return out


def make_dispatch_and_fragments(scalar, vector):
    chunks = split_evenly(vector, 8)
    out = [
        "", "// Experiment AC: arbitrary-operand X25519 field multiply dispatcher.",
        ".global fe25519_mul", ".type fe25519_mul, %function", ".thumb_func",
        "fe25519_mul:", "\tmovw r12, #:lower16:g_u_active",
        "\tmovt r12, #:upper16:g_u_active", "\tldr r12, [r12]",
        "\tcmp r12, #0", "\tbeq fe25519_mul_scalar",
        "\tmovw r12, #:lower16:g_u_phase", "\tmovt r12, #:upper16:g_u_phase",
        "\tldr r12, [r12]",
    ]
    for i in range(7):
        out += [f"\tcmp r12, #{i}", f"\tbeq fe25519_mul_u{i}"]
    out += ["\tb fe25519_mul_u7", ""]
    for i, chunk in enumerate(chunks):
        out += [f".type fe25519_mul_u{i}, %function", ".thumb_func", ".balign 16",
                f"fe25519_mul_u{i}:"]
        if i == 0:
            out += stage_round()
        out += weave(scalar, chunk)
        out += finish_fragment(i)
    return out


def generate_x25519():
    lines = X25519_IN.read_text(encoding="utf-8").splitlines()
    curve_start, curve_end, curve = extract_function(lines, "curve25519_scalarmult")
    start, end, block = extract_mul(lines)
    scalar = scalar_instructions(block)
    b0 = rc_body(round_mve4_b0(), "b0")

    scalar_block = []
    for line in block:
        line = re.sub(r"\bfe25519_mul\b", "fe25519_mul_scalar", line)
        scalar_block.append(line)
    replacement = scalar_block + make_dispatch_and_fragments(scalar, b0)
    lines[start:end] = replacement

    # Preserve a zero-dispatch-tax scalar baseline.  The U clone alone calls
    # the dispatcher and keeps q4-q7 live for one queued 24-round permutation.
    baseline = [line.replace("bl fe25519_mul", "bl fe25519_mul_scalar")
                for line in curve]
    stitched = [re.sub(r"\bcurve25519_scalarmult\b",
                       "curve25519_scalarmult_u", line) for line in curve]
    push = next(i for i, line in enumerate(stitched)
                if line.strip() == "push {r0,r4-r11,lr}")
    stitched.insert(push, "\tvpush {d8-d15}")
    tail = next(i for i in range(len(stitched) - 1, -1, -1)
                if stitched[i].strip() == "pop {r4-r11,pc}")
    stitched[tail:tail + 1] = ["\tpop {r4-r11,lr}", "\tvpop {d8-d15}", "\tbx lr"]

    # Re-find after the field-multiply block expansion shifted the function.
    curve_start, curve_end, _ = extract_function(lines, "curve25519_scalarmult")
    lines[curve_start:curve_end] = baseline + [""] + stitched
    X25519_OUT.write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")


def generate_standalone_round():
    body = rc_body(round_mve4_b2(), "b2")
    lines = [
        ".text", ".syntax unified", ".thumb", ".arch armv8.1-m.main",
        ".arch_extension mve", "", ".global keccak4_round_b2_rc",
        ".type keccak4_round_b2_rc, %function", ".thumb_func", ".balign 16",
        "keccak4_round_b2_rc:", "\tpush {r4-r11, lr}", "\tvpush {d8-d15}",
        "\tadd r10, r0, #508", "\tadd r11, r0, #1524",
    ] + body + ["\tvpop {d8-d15}", "\tpop {r4-r11, pc}", ""]
    MVE_OUT.write_text("\n".join(lines), encoding="utf-8", newline="\n")


def main():
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    generate_x25519()
    generate_standalone_round()
    print(f"wrote {X25519_OUT}")
    print(f"wrote {MVE_OUT}")


if __name__ == "__main__":
    main()
