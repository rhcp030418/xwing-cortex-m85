"""Emit transformed controls and full-solver board kernels for phases 0..3."""

from pathlib import Path
import re


HERE = Path(__file__).resolve().parent
WORK = HERE.parent / "slothy-2stream" / "expDB"
SRC = HERE / "expAE-src" / "fiat_u_stitch_m85.S"
OUT = Path(r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\expCS_solver.S")


def prologue(phase: int, frame: int) -> list[str]:
    lines = SRC.read_text(encoding="utf-8").splitlines()
    start = next(i for i, line in enumerate(lines)
                 if line.strip() == f"fiat_mul_u4_p{phase}:")
    end = next(i for i in range(start, len(lines))
               if lines[i].strip() == "pop {r0-r2}")
    return [re.sub(r"sub sp, sp, #\d+", f"sub sp, sp, #{frame}", line)
            for line in lines[start + 1:end + 1]]


def body(path: Path) -> list[str]:
    result = []
    for line in path.read_text(encoding="utf-8").splitlines():
        text = line.split("//")[0].strip()
        if not text or text.endswith(":") or text.startswith("."):
            continue
        text = re.sub(r"\br13\b", "sp", text)
        text = re.sub(r"\br14\b", "lr", text)
        text = re.sub(
            r"#0x([0-9A-Fa-f]+)",
            lambda match: "#%d" % ((int(match.group(1), 16) - (1 << 32))
                                     if int(match.group(1), 16) >= (1 << 31)
                                     else int(match.group(1), 16)), text)
        text = re.sub(r"^(v\w+)\.([A-Z]\d+)",
                      lambda match: match.group(1) + "." + match.group(2).lower(),
                      text)
        result.append("\t" + text)
    return result


def emit(name: str, source: Path, phase: int, frame: int) -> list[str]:
    instructions = body(source)
    maximum = max((int(match.group(1)) for line in instructions
                   if (match := re.search(r"\[sp,\s*#(\d+)\]", line))), default=0)
    assert maximum + 4 <= frame
    assert not any(re.search(r"\b(ldrd|strd)\b", line) for line in instructions)
    return [
        f".global {name}", f".type {name}, %function", ".thumb_func", ".balign 16",
        f"{name}:", *prologue(phase, frame), *instructions,
        f"\tadd sp, sp, #{frame}", "\tpop {r3-r11, pc}",
        f".size {name}, .-{name}", "",
    ]


def main() -> None:
    output = [
        "/* expDB: all four transformed controls and unrestricted solver kernels. */",
        ".syntax unified", ".thumb", ".arch armv8.1-m.main", ".arch_extension mve",
        '.section .text.fiat_u_stitch_cs, "ax", %progbits', "",
    ]
    for phase in range(4):
        meta = dict(line.split("=", 1) for line in
                    (WORK / f"p{phase}_meta.txt").read_text().splitlines())
        frame = int(meta["frame"])
        output += emit(f"fiat_mul_u4t_p{phase}", WORK / f"p{phase}_raw.s",
                       phase, frame)
        output += emit(f"fiat_mul_u4s_p{phase}", WORK / f"p{phase}_opt.s",
                       phase, frame)
    output += [
        ".global expdb_qall_save", ".type expdb_qall_save, %function",
        ".thumb_func", "expdb_qall_save:",
        "\tvstrw.u32 q0, [r0, #0]", "\tvstrw.u32 q1, [r0, #16]",
        "\tvstrw.u32 q2, [r0, #32]", "\tvstrw.u32 q3, [r0, #48]",
        "\tvstrw.u32 q4, [r0, #64]", "\tvstrw.u32 q5, [r0, #80]",
        "\tvstrw.u32 q6, [r0, #96]", "\tvstrw.u32 q7, [r0, #112]",
        "\tbx lr", ".size expdb_qall_save, .-expdb_qall_save", "",
        ".global expdb_qall_restore", ".type expdb_qall_restore, %function",
        ".thumb_func", "expdb_qall_restore:",
        "\tvldrw.u32 q0, [r0, #0]", "\tvldrw.u32 q1, [r0, #16]",
        "\tvldrw.u32 q2, [r0, #32]", "\tvldrw.u32 q3, [r0, #48]",
        "\tvldrw.u32 q4, [r0, #64]", "\tvldrw.u32 q5, [r0, #80]",
        "\tvldrw.u32 q6, [r0, #96]", "\tvldrw.u32 q7, [r0, #112]",
        "\tbx lr", ".size expdb_qall_restore, .-expdb_qall_restore", "",
    ]
    OUT.write_text("\n".join(output) + "\n", encoding="utf-8", newline="\n")
    print(f"wrote {OUT}")


if __name__ == "__main__":
    main()
