"""Count exact frozen-AF U-path 24-round x4 permutations and enqueues."""

from pathlib import Path
import shutil
import subprocess
import tempfile
import time

import pylink


HERE = Path(__file__).resolve().parent
FROZEN = HERE.parent / "2026-08-24_expAI"
ELF = FROZEN / "pre_expAI_blinky.elf"
SREC = FROZEN / "pre_expAI_blinky.srec"
NM = Path(
    r"C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\toolchains\gcc_arm\13.2.rel1\bin\arm-none-eabi-nm.exe"
)
DLL = r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll"
DEVICE = "R7FA8M1AH"
OPERATIONS = (
    ("keygen", "xwing_ac_keypair.constprop.0"),
    ("encaps", "xwing_ac_enc.constprop.0"),
    ("decaps", "xwing_ac_dec.constprop.0"),
)


def symbols() -> dict[str, int]:
    output = subprocess.check_output([NM, "-n", ELF], text=True)
    result = {}
    for line in output.splitlines():
        parts = line.split()
        if len(parts) == 3:
            result[parts[2]] = int(parts[0], 16)
    return result


def wait_halt(jlink: pylink.JLink) -> int:
    deadline = time.monotonic() + 180
    while not jlink.halted():
        if time.monotonic() > deadline:
            raise SystemExit("timeout waiting for breakpoint")
        time.sleep(0.001)
    return jlink.register_read(15) & ~1


def seek_u_entry(jlink: pylink.JLink, entry: int, already_running: bool) -> int:
    handle = jlink.breakpoint_set(entry, thumb=True)
    if not already_running:
        jlink.reset(ms=10, halt=False)
    else:
        jlink.restart()
    while True:
        pc = wait_halt(jlink)
        if pc != entry:
            raise SystemExit(f"unexpected seek halt 0x{pc:08x}")
        mode = jlink.register_read(0)
        if mode == 1:
            return_pc = jlink.register_read(14) & ~1
            jlink.breakpoint_clear(handle)
            return return_pc
        jlink.restart(skip_breakpoints=True)


def count_operation(
    jlink: pylink.JLink,
    name: str,
    return_pc: int,
    permute_pc: int,
    enqueue_pc: int,
) -> None:
    handles = {
        permute_pc: jlink.breakpoint_set(permute_pc, thumb=True),
        enqueue_pc: jlink.breakpoint_set(enqueue_pc, thumb=True),
        return_pc: jlink.breakpoint_set(return_pc, thumb=True),
    }
    permutations = 0
    enqueues = 0
    jlink.restart()
    while True:
        pc = wait_halt(jlink)
        if pc == return_pc:
            break
        if pc == permute_pc:
            permutations += 1
        elif pc == enqueue_pc:
            enqueues += 1
        else:
            raise SystemExit(f"unexpected count halt 0x{pc:08x}")
        jlink.restart(skip_breakpoints=True)
    for handle in handles.values():
        jlink.breakpoint_clear(handle)
    print(
        f"operation={name} x4_24round_permutations={permutations} "
        f"enqueues={enqueues}",
        flush=True,
    )


def main() -> None:
    sym = symbols()
    permute_pc = sym["permute4"]
    enqueue_pc = sym["x25519_u_enqueue"]
    staged = Path(tempfile.gettempdir()) / "expCK_frozen_af.srec"
    shutil.copyfile(SREC, staged)

    jlink = pylink.JLink(lib=pylink.Library(dllpath=DLL))
    jlink.open()
    jlink.set_tif(pylink.enums.JLinkInterfaces.SWD)
    jlink.connect(DEVICE, speed=4000)
    print(
        f"connected={jlink.core_name()} permute4=0x{permute_pc:08x} "
        f"enqueue=0x{enqueue_pc:08x}",
        flush=True,
    )
    jlink.reset(halt=True)
    jlink.exec_command("SetSkipProgOnCRCMatch = 0")
    jlink.exec_command("SetVerifyDownload = 0")
    jlink.flash_file(str(staged), 0)

    running = False
    for name, symbol in OPERATIONS:
        entry = sym[symbol]
        return_pc = seek_u_entry(jlink, entry, already_running=running)
        print(
            f"operation={name} entry=0x{entry:08x} return=0x{return_pc:08x} mode=1",
            flush=True,
        )
        count_operation(jlink, name, return_pc, permute_pc, enqueue_pc)
        running = True

    jlink.close()


if __name__ == "__main__":
    main()
