"""Flash expAL, collect the RAM log, and summarize slots 309..332."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess
import sys
import time


DEBUG = Path(r"C:\Users\cnscj\e2_studio\workspace\blinky\Debug")
DEFAULT_ELF = DEBUG / "blinky.elf"
DEFAULT_SREC = DEBUG / "blinky.srec"
NM = Path(
    r"C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0"
    r"\toolchains\gcc_arm\13.2.rel1\bin\arm-none-eabi-nm.exe"
)
DLL = Path(r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll")
DEVICE = "R7FA8M1AH"
CODE_FLASH_START = 0x02000000
CODE_FLASH_END = 0x02200000
READBACK_CHUNK = 16 * 1024

REP_N = 100
SLOT_N = 333
FIRST_SLOT = 309
OPS = ("keygen", "encaps", "decaps")
ORDER = ("00a", "10a", "11a", "01a", "01b", "11b", "10b", "00b")
SYMS = ("harness_done", "harness_fails", "log_len", "log_buf", "rep_cyc")


def symbol_addresses(elf: Path) -> dict[str, int]:
    output = subprocess.check_output([NM, "-S", elf], text=True, encoding="utf-8")
    addresses = {}
    sizes = {}
    for line in output.splitlines():
        parts = line.split()
        if len(parts) == 4 and parts[3] in SYMS:
            addresses[parts[3]] = int(parts[0], 16)
            sizes[parts[3]] = int(parts[1], 16)
    missing = set(SYMS) - set(addresses)
    if missing:
        raise SystemExit(f"ELF에 심볼 없음: {sorted(missing)}")
    expected_rep_size = SLOT_N * REP_N * 4
    if sizes["rep_cyc"] != expected_rep_size:
        raise SystemExit(
            f"rep_cyc 크기 0x{sizes['rep_cyc']:x} != 0x{expected_rep_size:x}"
        )
    return addresses


def srec_code_segments_from_lines(lines: list[str]) -> list[tuple[int, bytes]]:
    records: list[tuple[int, bytes]] = []
    address_lengths = {"1": 2, "2": 3, "3": 4}
    for line_number, source in enumerate(lines, 1):
        line = source.strip()
        if len(line) < 4 or not line.startswith("S") or line[1] not in address_lengths:
            continue
        try:
            record = bytes.fromhex(line[2:])
        except ValueError as error:
            raise ValueError(f"SREC line {line_number}: hex 오류") from error
        if not record or record[0] != len(record) - 1 or sum(record) & 0xFF != 0xFF:
            raise ValueError(f"SREC line {line_number}: count/checksum 오류")
        address_length = address_lengths[line[1]]
        address = int.from_bytes(record[1 : 1 + address_length], "big")
        data = record[1 + address_length : -1]
        if CODE_FLASH_START <= address and address + len(data) <= CODE_FLASH_END:
            records.append((address, data))

    if not records:
        raise ValueError("SREC에 code-flash data record가 없음")
    segments: list[tuple[int, bytearray]] = []
    for address, data in sorted(records):
        if segments and segments[-1][0] + len(segments[-1][1]) == address:
            segments[-1][1].extend(data)
        elif segments and address < segments[-1][0] + len(segments[-1][1]):
            raise ValueError(f"SREC code-flash record overlap: 0x{address:08x}")
        else:
            segments.append((address, bytearray(data)))
    return [(address, bytes(data)) for address, data in segments]


def verify_code_flash(jlink: object, srec: Path) -> tuple[str, int]:
    segments = srec_code_segments_from_lines(
        srec.read_text(encoding="ascii").splitlines()
    )
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
                first = next(
                    i for i, (actual, target) in enumerate(zip(observed, wanted))
                    if actual != target
                )
                raise SystemExit(
                    "flash readback mismatch at "
                    f"0x{address + offset + first:08x}: "
                    f"board={observed[first]:02x} srec={wanted[first]:02x}"
                )
    readback_hash = digest.hexdigest().upper()
    print(
        f"flash code readback PASS: bytes={total} segments={len(segments)} "
        f"sha256={readback_hash}"
    )
    return readback_hash, total


def read_board(
    attach_only: bool, elf: Path, srec: Path
) -> tuple[str, int, list[int], str, int]:
    import pylink

    addresses = symbol_addresses(elf)
    jlink = pylink.JLink(lib=pylink.Library(dllpath=str(DLL)))
    try:
        jlink.open()
        jlink.set_tif(pylink.enums.JLinkInterfaces.SWD)
        jlink.connect(DEVICE, speed=4000)
        print(f"connected: {jlink.core_name()}")

        if not attach_only:
            jlink.reset(halt=True)
            jlink.exec_command("SetSkipProgOnCRCMatch = 0")
            jlink.exec_command(
                "SetVerifyDownload = 0"
            )  # RA8 RAMCode workaround; readback below is mandatory.
            jlink.flash_file(str(srec), 0x0)
            readback_hash, readback_bytes = verify_code_flash(jlink, srec)
            jlink.reset(ms=10, halt=False)

        for _ in range(3600):
            time.sleep(0.1)
            if jlink.memory_read32(addresses["harness_done"], 1)[0] == 1:
                break
        else:
            raise SystemExit("timeout: harness_done이 1이 안 됨")

        if attach_only:
            # Do not halt an unfinished timing run.  Verify only after DONE.
            readback_hash, readback_bytes = verify_code_flash(jlink, srec)

        length = min(jlink.memory_read32(addresses["log_len"], 1)[0], 8191)
        log = bytes(jlink.memory_read8(addresses["log_buf"], length)).decode(
            "utf-8", "replace"
        )
        fails = jlink.memory_read32(addresses["harness_fails"], 1)[0]
        reps = jlink.memory_read32(addresses["rep_cyc"], SLOT_N * REP_N)
        return log, fails, reps, readback_hash, readback_bytes
    finally:
        jlink.close()


def median(values: list[int]) -> int:
    return sorted(values)[len(values) // 2]


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest().upper()


def effect(
    measurements: dict[str, dict[str, int]], op: str, left: str, right: str
) -> dict[str, float | int]:
    deltas = []
    percentages = []
    for suffix in ("a", "b"):
        baseline = measurements[left + suffix][op]
        candidate = measurements[right + suffix][op]
        delta = baseline - candidate
        deltas.append(delta)
        percentages.append(delta / baseline * 100.0)
    conservative_index = 0 if deltas[0] <= deltas[1] else 1
    return {
        "a": deltas[0],
        "b": deltas[1],
        "conservative": deltas[conservative_index],
        "pct_a": percentages[0],
        "pct_b": percentages[1],
        "pct_conservative": percentages[conservative_index],
    }


def summarize(
    log: str,
    fails: int,
    reps: list[int],
    elf: Path,
    srec: Path,
    readback_hash: str,
    readback_bytes: int,
) -> dict[str, object]:
    if len(reps) != SLOT_N * REP_N:
        raise ValueError(f"rep_cyc 길이 {len(reps)} != {SLOT_N * REP_N}")

    calib = median(reps[2 * REP_N : 3 * REP_N])
    measurements: dict[str, dict[str, int]] = {}
    for order_index, condition in enumerate(ORDER):
        measurements[condition] = {}
        for op_index, op in enumerate(OPS):
            slot = FIRST_SLOT + order_index * len(OPS) + op_index
            values = reps[slot * REP_N : (slot + 1) * REP_N]
            raw_median = median(values)
            adjusted = raw_median - calib
            measurements[condition][op] = adjusted
            print(
                f"[N={REP_N}] expal-xwing-{condition}-{op}: "
                f"median={raw_median} (calib {calib} 차감시 {adjusted}) "
                f"min={min(values)} max={max(values)}"
            )

    effects: dict[str, object] = {}
    for op in OPS:
        effects[op] = {
            "direct_00_to_11": effect(measurements, op, "00", "11"),
            "xyc8_at_c9_0": effect(measurements, op, "00", "10"),
            "xyc8_at_c9_1": effect(measurements, op, "01", "11"),
            "c9_at_xyc8_0": effect(measurements, op, "00", "01"),
            "c9_at_xyc8_1": effect(measurements, op, "10", "11"),
            "synergy": {
                "a": measurements["10a"][op]
                + measurements["01a"][op]
                - measurements["00a"][op]
                - measurements["11a"][op],
                "b": measurements["10b"][op]
                + measurements["01b"][op]
                - measurements["00b"][op]
                - measurements["11b"][op],
            },
        }
        effects[op]["synergy"]["conservative"] = min(
            effects[op]["synergy"]["a"], effects[op]["synergy"]["b"]
        )

    required = (
        r"KAT ALL PASS",
        r"expAJ kat-mm:\s*0(?:\D|$)",
        r"expAL xw-bytes-mm:\s*0\s+xw-smoke-fails=0",
        r"expAL timing-mm:\s*0\s+stack-fails=0\s+stack-used=\d+",
        r"rep arrays ready x100 \(333 slots\)",
        r"HARNESS DONE",
    )
    missing_gates = [pattern for pattern in required if not re.search(pattern, log)]
    gate_pass = fails == 0 and not missing_gates
    stack_match = re.search(
        r"expAL timing-mm:\s*0\s+stack-fails=0\s+stack-used=(\d+)", log
    )
    return {
        "calib": calib,
        "effects": effects,
        "elf_sha256": sha256(elf),
        "gate_pass": gate_pass,
        "harvester_sha256": sha256(Path(__file__).resolve()),
        "harness_fails": fails,
        "measurements": measurements,
        "missing_gates": missing_gates,
        "order": ORDER,
        "readback_bytes": readback_bytes,
        "readback_sha256": readback_hash,
        "rep_n": REP_N,
        "slot_n": SLOT_N,
        "srec_sha256": sha256(srec),
        "stack_used": int(stack_match.group(1)) if stack_match else None,
    }


def print_effects(payload: dict[str, object]) -> None:
    print("\n[exp AL] same-ELF X/Y/C8 x C9-v1 factorial")
    effects = payload["effects"]
    for op in OPS:
        row = effects[op]
        direct = row["direct_00_to_11"]
        print(
            f"  {op}: 00->11 a={direct['a']:+d} b={direct['b']:+d} "
            f"conservative={direct['conservative']:+d} "
            f"({direct['pct_conservative']:+.3f}%)"
        )
        print(
            "    N@C0={:+d} N@C1={:+d} C@N0={:+d} C@N1={:+d} "
            "synergy(a/b/min)={:+d}/{:+d}/{:+d}".format(
                row["xyc8_at_c9_0"]["conservative"],
                row["xyc8_at_c9_1"]["conservative"],
                row["c9_at_xyc8_0"]["conservative"],
                row["c9_at_xyc8_1"]["conservative"],
                row["synergy"]["a"],
                row["synergy"]["b"],
                row["synergy"]["conservative"],
            )
        )
    verdict = "PASS" if payload["gate_pass"] else "FAIL"
    print(f"[exp AL host gate] {verdict}; harness_fails={payload['harness_fails']}")


def self_test() -> None:
    measurements = {
        "00a": {op: 1000 for op in OPS},
        "00b": {op: 1002 for op in OPS},
        "10a": {op: 970 for op in OPS},
        "10b": {op: 972 for op in OPS},
        "01a": {op: 960 for op in OPS},
        "01b": {op: 962 for op in OPS},
        "11a": {op: 920 for op in OPS},
        "11b": {op: 922 for op in OPS},
    }
    direct = effect(measurements, "keygen", "00", "11")
    assert direct["a"] == 80 and direct["b"] == 80
    assert direct["conservative"] == 80
    synergy = (
        measurements["10a"]["keygen"]
        + measurements["01a"]["keygen"]
        - measurements["00a"]["keygen"]
        - measurements["11a"]["keygen"]
    )
    assert synergy == 10
    assert FIRST_SLOT + len(ORDER) * len(OPS) == SLOT_N
    segments = srec_code_segments_from_lines(
        ["S315020000000021002239860A0225850A0235860A025D"]
    )
    assert segments == [(0x02000000, bytes.fromhex("0021002239860A0225850A0235860A02"))]
    print("expAL harvester self-test PASS")


def arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--attach", action="store_true")
    parser.add_argument("--self-test", action="store_true")
    parser.add_argument("--elf", type=Path, default=DEFAULT_ELF)
    parser.add_argument("--srec", type=Path, default=DEFAULT_SREC)
    return parser.parse_args()


def main() -> int:
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    args = arguments()
    if args.self_test:
        self_test()
        return 0

    print(f"measurement ELF SHA-256: {sha256(args.elf)}")
    print(f"measurement SREC SHA-256: {sha256(args.srec)}")
    log, fails, reps, readback_hash, readback_bytes = read_board(
        args.attach, args.elf, args.srec
    )
    print(log)
    payload = summarize(
        log,
        fails,
        reps,
        args.elf,
        args.srec,
        readback_hash,
        readback_bytes,
    )
    print_effects(payload)
    print("EXPAL_JSON " + json.dumps(payload, ensure_ascii=False, sort_keys=True))
    return 0 if payload["gate_pass"] else 2


if __name__ == "__main__":
    raise SystemExit(main())
