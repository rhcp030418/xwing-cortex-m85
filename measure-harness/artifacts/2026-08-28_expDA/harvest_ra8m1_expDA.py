"""Flash and harvest expDA keygen cells (slots 832..856)."""

from __future__ import annotations

import hashlib
from pathlib import Path
import subprocess
import sys
import time

import pylink


if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

DEBUG = Path(r"C:\Users\cnscj\e2_studio\workspace\blinky\Debug")
ELF = DEBUG / "blinky.elf"
SREC = DEBUG / "blinky.srec"
NM = Path(r"C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\toolchains\gcc_arm\13.2.rel1\bin\arm-none-eabi-nm.exe")
DLL = Path(r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll")
DEVICE = "R7FA8M1AH"
REP_N = 100
BASE = 832
END = 857
SYMS = ("harness_done", "harness_fails", "log_len", "log_buf", "rep_cyc")
CELLS = (
    ("F9-ab", 832), ("U9-ab", 835), ("U9-ba", 838), ("F9-ba", 841),
    ("F11-ab", 844), ("U11-ab", 847), ("U11-ba", 850), ("F11-ba", 853),
)


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest().upper()


def addresses() -> dict[str, int]:
    found: dict[str, int] = {}
    output = subprocess.check_output([NM, "-S", ELF], text=True, encoding="utf-8")
    for line in output.splitlines():
        fields = line.split()
        if len(fields) == 4 and fields[3] in SYMS:
            found[fields[3]] = int(fields[0], 16)
    missing = set(SYMS) - set(found)
    if missing:
        raise SystemExit(f"ELF symbols missing: {sorted(missing)}")
    return found


def code_segments() -> list[tuple[int, bytes]]:
    records: list[tuple[int, bytes]] = []
    widths = {"1": 2, "2": 3, "3": 4}
    for number, raw in enumerate(SREC.read_text(encoding="ascii").splitlines(), 1):
        line = raw.strip()
        if len(line) < 4 or not line.startswith("S") or line[1] not in widths:
            continue
        record = bytes.fromhex(line[2:])
        if record[0] != len(record) - 1 or sum(record) & 0xFF != 0xFF:
            raise SystemExit(f"invalid SREC record at line {number}")
        width = widths[line[1]]
        address = int.from_bytes(record[1:1 + width], "big")
        data = record[1 + width:-1]
        if 0x02000000 <= address and address + len(data) <= 0x02200000:
            records.append((address, data))
    segments: list[tuple[int, bytearray]] = []
    for address, data in sorted(records):
        if segments and segments[-1][0] + len(segments[-1][1]) == address:
            segments[-1][1].extend(data)
        else:
            segments.append((address, bytearray(data)))
    return [(address, bytes(data)) for address, data in segments]


def verify_flash(link: pylink.JLink) -> tuple[str, int]:
    digest = hashlib.sha256()
    total = 0
    link.halt()
    for address, expected in code_segments():
        digest.update(expected)
        total += len(expected)
        for offset in range(0, len(expected), 16384):
            wanted = expected[offset:offset + 16384]
            actual = bytes(link.memory_read8(address + offset, len(wanted)))
            if actual != wanted:
                raise SystemExit(f"flash readback mismatch at 0x{address + offset:08x}")
    value = digest.hexdigest().upper()
    print(f"flash code readback PASS: bytes={total} sha256={value}")
    return value, total


def stats(values: list[int]) -> tuple[int, int, int, int, int, float]:
    ordered = sorted(values)
    return (ordered[4], ordered[24], ordered[49], ordered[74], ordered[94],
            sum(values) / len(values))


def main() -> None:
    attach = "--attach" in sys.argv
    addr = addresses()
    link = pylink.JLink(lib=pylink.Library(dllpath=str(DLL)))
    link.open()
    try:
        link.set_tif(pylink.enums.JLinkInterfaces.SWD)
        link.connect(DEVICE, speed=4000)
        print(f"connected: {link.core_name()}")
        print(f"ELF SHA-256: {sha256(ELF)}")
        print(f"SREC SHA-256: {sha256(SREC)}")
        if not attach:
            link.reset(halt=True)
            link.exec_command("SetSkipProgOnCRCMatch = 0")
            link.exec_command("SetVerifyDownload = 0")
            link.flash_file(str(SREC), 0)
            verify_flash(link)
            link.reset(ms=10, halt=False)
        for _ in range(7200):
            time.sleep(0.1)
            if link.memory_read32(addr["harness_done"], 1)[0] == 1:
                break
        else:
            raise SystemExit("timeout: harness_done != 1")
        length = min(link.memory_read32(addr["log_len"], 1)[0], 8191)
        log = bytes(link.memory_read8(addr["log_buf"], length)).decode("utf-8", "replace")
        fails = link.memory_read32(addr["harness_fails"], 1)[0]
        start = addr["rep_cyc"] + BASE * REP_N * 4
        reps = link.memory_read32(start, (END - BASE) * REP_N)
        calib = sorted(link.memory_read32(addr["rep_cyc"] + 2 * REP_N * 4, REP_N))[49]
    finally:
        link.close()

    print(log)
    print(f"calib(median) = {calib}")
    print(f"harness_fails = {fails}")
    print("cell span p05 p25 p50 p75 p95 mean")
    medians: dict[tuple[str, str], int] = {}
    for label, slot in CELLS:
        for index, span in enumerate(("total", "fused", "residual")):
            begin = (slot - BASE + index) * REP_N
            values = list(reps[begin:begin + REP_N])
            adjust = calib if span != "residual" else 0
            p05, p25, p50, p75, p95, mean = stats(values)
            medians[(label, span)] = p50 - adjust
            print(f"{label} {span} {p05-adjust} {p25-adjust} {p50-adjust} "
                  f"{p75-adjust} {p95-adjust} {mean-adjust:.1f}")

    print("paired total U-F")
    for coverage in (9, 11):
        for order in ("ab", "ba"):
            f = medians[(f"F{coverage}-{order}", "total")]
            u = medians[(f"U{coverage}-{order}", "total")]
            print(f"coverage={coverage} order={order} F={f} U={u} "
                  f"U-F={u-f} pct={(u-f)/f*100:.6f}%")


if __name__ == "__main__":
    main()
