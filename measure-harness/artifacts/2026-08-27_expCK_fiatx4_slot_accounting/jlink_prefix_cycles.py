"""Measure the frozen AF seq4 x4 prefix with DWT and hardware breakpoints."""

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
DWT_CYCCNT = 0xE0001004
STOP = 0x020A4DE0


def symbol_address(name: str) -> int:
    output = subprocess.check_output([NM, "-n", ELF], text=True)
    for line in output.splitlines():
        parts = line.split()
        if len(parts) == 3 and parts[2] == name:
            return int(parts[0], 16)
    raise SystemExit(f"missing symbol: {name}")


def wait_halt(jlink: pylink.JLink, expected: int) -> None:
    deadline = time.monotonic() + 180
    while not jlink.halted():
        if time.monotonic() > deadline:
            raise SystemExit("timeout waiting for breakpoint")
        time.sleep(0.001)
    pc = jlink.register_read(15) & ~1
    if pc != expected:
        raise SystemExit(f"unexpected halt PC 0x{pc:08x}, expected 0x{expected:08x}")


def main() -> None:
    entry = symbol_address("x25519_u_bench_seq4")
    staged = Path(tempfile.gettempdir()) / "expCK_frozen_af.srec"
    shutil.copyfile(SREC, staged)

    jlink = pylink.JLink(lib=pylink.Library(dllpath=DLL))
    jlink.open()
    jlink.set_tif(pylink.enums.JLinkInterfaces.SWD)
    jlink.connect(DEVICE, speed=4000)
    print(f"connected={jlink.core_name()} entry=0x{entry:08x} stop=0x{STOP:08x}", flush=True)
    jlink.reset(halt=True)
    jlink.exec_command("SetSkipProgOnCRCMatch = 0")
    jlink.exec_command("SetVerifyDownload = 0")
    jlink.flash_file(str(staged), 0)

    entry_handle = jlink.breakpoint_set(entry, thumb=True)
    jlink.reset(ms=10, halt=False)
    wait_halt(jlink, entry)

    # Discard the reference call. The next seq4 entry is the first timed-loop call,
    # after both seq4 and seq8 code paths have executed once.
    jlink.restart(skip_breakpoints=True)
    wait_halt(jlink, entry)
    jlink.breakpoint_clear(entry_handle)

    values = []
    for sample in range(10):
        stop_handle = jlink.breakpoint_set(STOP, thumb=True)
        jlink.memory_write32(DWT_CYCCNT, [0])
        jlink.restart()
        wait_halt(jlink, STOP)
        cycles = jlink.memory_read32(DWT_CYCCNT, 1)[0]
        values.append(cycles)
        print(f"sample={sample + 1} cycles={cycles}", flush=True)
        jlink.breakpoint_clear(stop_handle)
        if sample != 9:
            entry_handle = jlink.breakpoint_set(entry, thumb=True)
            jlink.restart()
            wait_halt(jlink, entry)
            jlink.breakpoint_clear(entry_handle)

    jlink.close()
    ordered = sorted(values)
    print(
        f"n={len(values)} median={ordered[len(values) // 2]} "
        f"min={ordered[0]} max={ordered[-1]} values={values}",
        flush=True,
    )


if __name__ == "__main__":
    main()
