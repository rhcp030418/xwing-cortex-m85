"""Flash and gate expDD PMU recovery firmware."""

from __future__ import annotations

import argparse
import hashlib
from pathlib import Path
import re
import subprocess
import sys
import tempfile
import time


DEBUG = Path(r"C:\Users\cnscj\e2_studio\workspace\blinky\Debug")
NM = Path(
    r"C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0"
    r"\toolchains\gcc_arm\13.2.rel1\bin\arm-none-eabi-nm.exe"
)
DLL = Path(r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll")
DEVICE = "R7FA8M1AH"
CODE_FLASH_START = 0x02000000
CODE_FLASH_END = 0x02200000
READBACK_CHUNK = 16 * 1024
SYMS = ("harness_done", "harness_fails", "log_len", "log_buf")


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest().upper()


def symbol_addresses(elf: Path) -> dict[str, int]:
    output = subprocess.check_output([NM, "-S", elf], text=True, encoding="utf-8")
    addresses: dict[str, int] = {}
    for line in output.splitlines():
        parts = line.split()
        if len(parts) == 4 and parts[3] in SYMS:
            addresses[parts[3]] = int(parts[0], 16)
    missing = set(SYMS) - set(addresses)
    if missing:
        raise SystemExit(f"ELF에 심볼 없음: {sorted(missing)}")
    return addresses


def srec_segments(srec: Path) -> list[tuple[int, bytes]]:
    records: list[tuple[int, bytes]] = []
    address_lengths = {"1": 2, "2": 3, "3": 4}
    for line_number, source in enumerate(srec.read_text(encoding="ascii").splitlines(), 1):
        line = source.strip()
        if len(line) < 4 or not line.startswith("S") or line[1] not in address_lengths:
            continue
        record = bytes.fromhex(line[2:])
        if not record or record[0] != len(record) - 1 or sum(record) & 0xFF != 0xFF:
            raise ValueError(f"SREC line {line_number}: count/checksum 오류")
        address_length = address_lengths[line[1]]
        address = int.from_bytes(record[1 : 1 + address_length], "big")
        data = record[1 + address_length : -1]
        if CODE_FLASH_START <= address and address + len(data) <= CODE_FLASH_END:
            records.append((address, data))
    if not records:
        raise ValueError("SREC에 code-flash record가 없음")

    segments: list[tuple[int, bytearray]] = []
    for address, data in sorted(records):
        if segments and segments[-1][0] + len(segments[-1][1]) == address:
            segments[-1][1].extend(data)
        else:
            segments.append((address, bytearray(data)))
    return [(address, bytes(data)) for address, data in segments]


def verify_flash(jlink: object, srec: Path) -> tuple[int, str]:
    segments = srec_segments(srec)
    digest = hashlib.sha256()
    total = 0
    jlink.halt()
    for address, expected in segments:
        digest.update(expected)
        total += len(expected)
        for offset in range(0, len(expected), READBACK_CHUNK):
            wanted = expected[offset : offset + READBACK_CHUNK]
            observed = bytes(jlink.memory_read8(address + offset, len(wanted)))
            if observed != wanted:
                raise SystemExit(f"flash readback mismatch at 0x{address + offset:08x}")
    result = digest.hexdigest().upper()
    print(f"flash code readback PASS: bytes={total} segments={len(segments)} sha256={result}")
    return total, result


def flash_path(srec: Path) -> tuple[str, str | None]:
    try:
        str(srec).encode("ascii")
        return str(srec), None
    except UnicodeEncodeError:
        import os
        import shutil

        handle, temporary = tempfile.mkstemp(suffix=".srec", prefix="expdd_")
        os.close(handle)
        shutil.copyfile(srec, temporary)
        if sha256(srec) != sha256(Path(temporary)):
            raise SystemExit("ASCII 임시 SREC sha256 불일치")
        return temporary, temporary


def parse_gate(log: str, fails: int) -> None:
    required = (
        "KAT ALL PASS",
        "expDD equiv: bytes-mm=0 smoke=0 reject-mm=0 coldwarm-mm=0",
        "expDD PMU GATE PASS",
        "HARNESS DONE",
    )
    missing = [value for value in required if value not in log]
    cells = re.findall(
        r"^expDD cell=(\d+) mode=([AB]) op=(keygen|encaps|warm|cold) "
        r"cyc=(\d+) inst=(\d+) stall=(\d+) fe=(\d+) be=(\d+)$",
        log,
        re.MULTILINE,
    )
    if fails != 0 or missing or len(cells) != 16:
        raise SystemExit(
            f"expDD gate FAIL: harness_fails={fails} missing={missing} cells={len(cells)}"
        )
    for cell, mode, op, cyc, inst, stall, fe, be in cells:
        if int(cyc) == 0 or int(inst) == 0:
            raise SystemExit(f"expDD zero counter: cell={cell} mode={mode} op={op}")
    print("expDD HOST GATE PASS: KAT/equivalence/selftest/16 PMU cells")


def main() -> int:
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    parser = argparse.ArgumentParser()
    parser.add_argument("--elf", type=Path, default=DEBUG / "blinky.elf")
    parser.add_argument("--srec", type=Path, default=DEBUG / "blinky.srec")
    args = parser.parse_args()
    elf = args.elf.resolve()
    srec = args.srec.resolve()
    addresses = symbol_addresses(elf)

    import pylink

    jlink = pylink.JLink(lib=pylink.Library(dllpath=str(DLL)))
    temporary: str | None = None
    try:
        jlink.open()
        jlink.set_tif(pylink.enums.JLinkInterfaces.SWD)
        jlink.connect(DEVICE, speed=4000)
        print(f"connected: {jlink.core_name()}")
        jlink.reset(halt=True)
        jlink.exec_command("SetSkipProgOnCRCMatch = 0")
        jlink.exec_command("SetVerifyDownload = 0")
        source, temporary = flash_path(srec)
        jlink.flash_file(source, 0x0)
        verify_flash(jlink, srec)
        jlink.reset(ms=10, halt=False)

        for _ in range(1800):
            time.sleep(0.1)
            if jlink.memory_read32(addresses["harness_done"], 1)[0] == 1:
                break
        else:
            raise SystemExit("timeout: harness_done이 1이 안 됨")

        length = min(jlink.memory_read32(addresses["log_len"], 1)[0], 8191)
        log = bytes(jlink.memory_read8(addresses["log_buf"], length)).decode(
            "utf-8", "replace"
        )
        fails = jlink.memory_read32(addresses["harness_fails"], 1)[0]
    finally:
        jlink.close()
        if temporary:
            Path(temporary).unlink(missing_ok=True)

    print(f"measurement ELF SHA-256: {sha256(elf)}")
    print(f"measurement SREC SHA-256: {sha256(srec)}")
    print(log)
    print(f"harness_fails={fails}")
    parse_gate(log, fails)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
