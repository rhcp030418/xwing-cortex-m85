"""Count frozen AF F/U-region instructions by J-Link single-step.

The optional JSON report contains the complete PC and mnemonic histograms so
the issue-class mapping can be audited and recomputed without another board
run.  It is a histogram, not a temporal issue trace.
"""

from collections import Counter
from pathlib import Path
import argparse
import hashlib
import json
import re
import shutil
import subprocess
import tempfile
import time

HERE = Path(__file__).resolve().parent
FROZEN = HERE.parent / "2026-08-24_expAI"
ELF = FROZEN / "pre_expAI_blinky.elf"
SREC = FROZEN / "pre_expAI_blinky.srec"
TOOLBIN = Path(
    r"C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\toolchains\gcc_arm\13.2.rel1\bin"
)
DLL = r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll"
DEVICE = "R7FA8M1AH"
TARGETS = {
    "seq4": "x25519_u_bench_seq4",
    "fused4": "x25519_u_bench_fused4",
    "seq8": "x25519_u_bench_seq8",
    "fused8": "x25519_u_bench_fused8",
}

BRANCH_LOOP_MNEMONICS = {
    "b", "bl", "blx", "bx", "bxj",
    "beq", "bne", "bcs", "bhs", "bcc", "blo", "bmi", "bpl",
    "bvs", "bvc", "bhi", "bls", "bge", "blt", "bgt", "ble",
    "cbz", "cbnz", "tbb", "tbh", "dls", "wls", "le",
}


def symbol_address(name: str) -> int:
    output = subprocess.check_output(
        [TOOLBIN / "arm-none-eabi-nm.exe", "-n", ELF], text=True
    )
    for line in output.splitlines():
        parts = line.split()
        if len(parts) == 3 and parts[2] == name:
            return int(parts[0], 16)
    raise SystemExit(f"missing symbol: {name}")


def disassembly() -> dict[int, tuple[str, str]]:
    output = subprocess.check_output(
        [TOOLBIN / "arm-none-eabi-objdump.exe", "-d", "-w", ELF], text=True
    )
    instructions = {}
    pattern = re.compile(
        r"^\s*([0-9a-f]+):\s+(?:[0-9a-f]{4}(?:\s+[0-9a-f]{4})?)\s+"
        r"([a-zA-Z0-9_.]+)(?:\s+(.*))?$"
    )
    for line in output.splitlines():
        match = pattern.match(line)
        if match:
            instructions[int(match.group(1), 16)] = (
                match.group(2).lower(),
                (match.group(3) or "").strip(),
            )
    return instructions


def issue_class(mnemonic: str) -> str:
    # Binutils 2.41/2.42 prints some MVE encodings as their legacy
    # coprocessor aliases (ldc/stc/cdp). Cortex-M85 has no matching VFP/NEON
    # execution here; these aliases occur in the hand-written MVE stream.
    if mnemonic.startswith(("vld", "vst", "vpush", "vpop", "ldc", "stc")):
        return "mve_load_store"
    if mnemonic.startswith(("vmul", "vmla", "vmls", "vqdmul", "vqrdmul")):
        return "mve_multiply_mac"
    if mnemonic.startswith(("v", "cdp", "mcr", "mrc")):
        return "mve_alu_shift"
    if mnemonic.startswith(("ldr", "str", "ldm", "stm", "push", "pop")):
        return "scalar_load_store"
    if mnemonic.startswith(
        ("mul", "mla", "mls", "umaal", "umull", "umlal", "smull", "smlal")
    ):
        return "scalar_multiply_mac"
    # Match the mnemonic, not the first letter.  The previous startswith("b")
    # rule incorrectly counted scalar ALU instructions such as bic/bfi/bfc as
    # branches.  Binutils width/type suffixes (for example bne.w) are ignored.
    base_mnemonic = mnemonic.split(".", 1)[0]
    if base_mnemonic in BRANCH_LOOP_MNEMONICS:
        return "branch_loop"
    if mnemonic.startswith(("svc", "bkpt", "cps", "mrs", "msr", "dsb", "dmb", "isb")):
        return "system"
    return "scalar_alu_shift"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("target", choices=TARGETS)
    parser.add_argument("--max-steps", type=int, default=5_000_000)
    parser.add_argument("--batch-steps", type=int)
    parser.add_argument("--stop-address", type=lambda value: int(value, 0))
    parser.add_argument(
        "--report",
        type=Path,
        help="write an auditable JSON report with complete PC/mnemonic histograms",
    )
    args = parser.parse_args()

    try:
        import pylink
    except ModuleNotFoundError as error:
        raise SystemExit(
            "board measurement requires the pylink-square package; "
            "issue_class() and its unit tests do not"
        ) from error

    symbol = TARGETS[args.target]
    entry = symbol_address(symbol)
    decoded = disassembly()
    staged = Path(tempfile.gettempdir()) / "expCK_frozen_af.srec"
    shutil.copyfile(SREC, staged)

    jlink = pylink.JLink(lib=pylink.Library(dllpath=DLL))
    jlink.open()
    jlink.set_tif(pylink.enums.JLinkInterfaces.SWD)
    jlink.connect(DEVICE, speed=4000)
    print(f"connected={jlink.core_name()} target={symbol} entry=0x{entry:08x}", flush=True)
    jlink.reset(halt=True)
    jlink.exec_command("SetSkipProgOnCRCMatch = 0")
    jlink.exec_command("SetVerifyDownload = 0")
    jlink.flash_file(str(staged), 0)
    handle = jlink.breakpoint_set(entry, thumb=True)
    jlink.reset(ms=10, halt=False)

    deadline = time.monotonic() + 180
    while not jlink.halted():
        if time.monotonic() > deadline:
            jlink.close()
            raise SystemExit("timeout waiting for entry breakpoint")
        time.sleep(0.01)

    pc = jlink.register_read(15) & ~1
    return_pc = jlink.register_read(14) & ~1
    jlink.breakpoint_clear(handle)
    if pc != entry:
        jlink.close()
        raise SystemExit(f"unexpected halt PC 0x{pc:08x}")
    print(f"halted entry=0x{pc:08x} return=0x{return_pc:08x}", flush=True)

    if args.batch_steps is not None:
        return_handle = jlink.breakpoint_set(return_pc, thumb=True)
        started = time.monotonic()
        jlink.restart(num_instructions=args.batch_steps)
        while not jlink.halted():
            time.sleep(0.001)
        stopped_pc = jlink.register_read(15) & ~1
        elapsed = time.monotonic() - started
        print(
            f"batch_steps={args.batch_steps} stopped=0x{stopped_pc:08x} "
            f"at_return={stopped_pc == return_pc} elapsed={elapsed:.6f}s",
            flush=True,
        )
        if stopped_pc != return_pc:
            jlink.step(thumb=True)
            after_one = jlink.register_read(15) & ~1
            print(f"after_one_step=0x{after_one:08x} at_return={after_one == return_pc}", flush=True)
        jlink.breakpoint_clear(return_handle)
        jlink.close()
        return

    classes: Counter[str] = Counter()
    mnemonics: Counter[str] = Counter()
    pcs: Counter[int] = Counter()
    missing: Counter[int] = Counter()
    started = time.monotonic()
    completed = False
    pc = entry
    terminal_pc = args.stop_address if args.stop_address is not None else return_pc
    for count in range(1, args.max_steps + 1):
        decoded_instruction = decoded.get(pc)
        if decoded_instruction is None:
            missing[pc] += 1
        else:
            mnemonic, _ = decoded_instruction
            pcs[pc] += 1
            mnemonics[mnemonic] += 1
            classes[issue_class(mnemonic)] += 1
        jlink.step(thumb=True)
        pc = jlink.register_read(15) & ~1
        if pc == terminal_pc:
            completed = True
            break
        if count % 10_000 == 0:
            elapsed = time.monotonic() - started
            print(f"progress={count} rate={count / elapsed:.1f} instr/s", flush=True)

    elapsed = time.monotonic() - started
    jlink.close()
    total = sum(classes.values()) + sum(missing.values())
    print(
        f"completed={completed} terminal=0x{terminal_pc:08x} "
        f"instructions={total} elapsed={elapsed:.3f}s",
        flush=True,
    )
    print("classes=" + ",".join(f"{key}:{classes[key]}" for key in sorted(classes)), flush=True)
    print("top_mnemonics=" + ",".join(f"{key}:{value}" for key, value in mnemonics.most_common(30)), flush=True)
    print("missing=" + ",".join(f"0x{key:08x}:{value}" for key, value in missing.items()), flush=True)
    if args.report is not None:
        args.report.parent.mkdir(parents=True, exist_ok=True)
        payload = {
            "schema": "expCK-icount-v2",
            "target": args.target,
            "symbol": symbol,
            "completed": completed,
            "terminal_pc": f"0x{terminal_pc:08x}",
            "instructions": total,
            "classes": dict(sorted(classes.items())),
            "mnemonics": dict(sorted(mnemonics.items())),
            "pc_counts": {
                f"0x{address:08x}": pcs[address] for address in sorted(pcs)
            },
            "missing_pc_counts": {
                f"0x{address:08x}": missing[address] for address in sorted(missing)
            },
            "elf_sha256": hashlib.sha256(ELF.read_bytes()).hexdigest(),
            "srec_sha256": hashlib.sha256(SREC.read_bytes()).hexdigest(),
        }
        args.report.write_text(
            json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8"
        )
        print(f"report={args.report}", flush=True)


if __name__ == "__main__":
    main()
