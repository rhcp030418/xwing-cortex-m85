"""Flash expAN, collect the RAM log, and summarize slots 362..375.

X-Wing top-level cycle attribution (E0-top).  Derived from
harvest_ra8m1_expAM1b.py; only SLOT_N/FIRST_SLOT and the analysis differ.
"""

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
SLOT_N = 376
FIRST_SLOT = 362
BATCH = 64
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
            # J-Link DLL은 non-ASCII 경로를 열지 못한다(2026-08-25 run1/2 실측:
            # 한글 staging 경로에서 JLinkFlashException "could not be opened").
            # frozen SREC을 ASCII 임시 사본으로 복사해 플래시하되 sha256 동일성을
            # 검증해 이미지 계보를 보존한다. 지역 임포트만 사용(파일 의존 없음).
            import hashlib as _hl
            import os as _os
            import shutil as _sh
            import tempfile as _tf
            flash_path = str(srec)
            ascii_tmp = None
            try:
                flash_path.encode("ascii")
            except UnicodeEncodeError:
                fd, ascii_tmp = _tf.mkstemp(suffix=".srec", prefix="expal_")
                _os.close(fd)
                _sh.copyfile(str(srec), ascii_tmp)
                h_src = _hl.sha256(open(str(srec), "rb").read()).hexdigest()
                h_tmp = _hl.sha256(open(ascii_tmp, "rb").read()).hexdigest()
                if h_src != h_tmp:
                    raise SystemExit("ASCII 임시 사본 sha256 불일치")
                flash_path = ascii_tmp
            try:
                jlink.flash_file(flash_path, 0x0)
            finally:
                if ascii_tmp is not None:
                    _os.remove(ascii_tmp)
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



# ---- expAN analysis: X-Wing top-level attribution ----

BASE = 362

# slot offset -> (operation, checkpoint label)
LAYOUT = {
    0:  ("keygen", "total"),
    1:  ("keygen", "c1_mlkem_keypair"),
    2:  ("keygen", "c2_x25519_fixed"),
    3:  ("encaps", "total"),
    4:  ("encaps", "c1_mlkem_enc"),
    5:  ("encaps", "c2_x25519_ctX"),
    6:  ("encaps", "c3_x25519_ssX"),
    7:  ("encaps", "c4_combiner"),
    8:  ("decaps", "total"),
    9:  ("decaps", "c1_mlkem_dec"),
    10: ("decaps", "c2_x25519_ssX"),
    11: ("decaps", "c3_combiner"),
    12: ("calib", "empty_span"),
    13: ("calib", "four_checkpoints"),
}

# Parts are differences of adjacent checkpoints; "glue" is total - last checkpoint.
PARTS = {
    "keygen": [
        ("ML-KEM-768 keygen",      "c1_mlkem_keypair", None),
        ("X25519 fixed-base",      "c2_x25519_fixed",  "c1_mlkem_keypair"),
        ("glue (rng/clamp/copy)",  "total",            "c2_x25519_fixed"),
    ],
    "encaps": [
        ("ML-KEM-768 encaps",      "c1_mlkem_enc",  None),
        ("X25519 fixed-base ctX",  "c2_x25519_ctX", "c1_mlkem_enc"),
        ("X25519 var-base ssX",    "c3_x25519_ssX", "c2_x25519_ctX"),
        ("X-Wing combiner",        "c4_combiner",   "c3_x25519_ssX"),
        ("glue (rng/clamp)",       "total",         "c4_combiner"),
    ],
    "decaps": [
        ("ML-KEM-768 decaps",      "c1_mlkem_dec",  None),
        ("X25519 var-base ssX",    "c2_x25519_ssX", "c1_mlkem_dec"),
        ("X-Wing combiner",        "c3_combiner",   "c2_x25519_ssX"),
        ("glue",                   "total",         "c3_combiner"),
    ],
}

# expAL cell-11 (X/Y/C8+C9) reference totals, both runs, for the sanity cross-check.
EXPAL_CELL11 = {
    "keygen": (761811, 761847),
    "encaps": (1134806, 1134825),
    "decaps": (809797, 809817),
}


def _parse_kv(log: str, prefix: str) -> dict:
    out = {}
    for line in log.splitlines():
        if line.startswith(prefix):
            for token in line[len(prefix):].split():
                if "=" in token:
                    key, _, value = token.partition("=")
                    try:
                        out[key] = int(value)
                    except ValueError:
                        pass
    return out


def _slot_stats(reps: list, offset: int) -> dict:
    values = reps[(BASE + offset) * REP_N : (BASE + offset + 1) * REP_N]
    return {"median": median(values), "min": min(values), "max": max(values)}


def summarize(
    log: str,
    fails: int,
    reps: list,
    elf: Path,
    srec: Path,
    readback_hash: str,
    readback_bytes: int,
) -> dict:
    if len(reps) != SLOT_N * REP_N:
        raise ValueError("rep_cyc length mismatch")

    raw = {}
    for offset, (op, label) in LAYOUT.items():
        raw.setdefault(op, {})[label] = _slot_stats(reps, offset)

    empty_span = raw["calib"]["empty_span"]["median"]
    four_ckpt = raw["calib"]["four_checkpoints"]["median"]
    per_ckpt = (four_ckpt - empty_span) / 4.0

    breakdown = {}
    for op, parts in PARTS.items():
        total = raw[op]["total"]["median"]
        rows = []
        for name, upper, lower in parts:
            hi = raw[op][upper]["median"]
            lo = raw[op][lower]["median"] if lower else 0
            rows.append({
                "part": name,
                "cycles": hi - lo,
                "pct_of_total": 100.0 * (hi - lo) / total if total else 0.0,
            })
        # checkpoint overhead carried inside this operation's span
        n_ckpt = len(parts) - 1
        rows.append({
            "part": "checkpoint overhead (measured, included above)",
            "cycles": round(per_ckpt * n_ckpt, 1),
            "pct_of_total": 100.0 * per_ckpt * n_ckpt / total if total else 0.0,
        })
        breakdown[op] = {"total": total, "parts": rows}

    # cross-check against expAL cell 11
    cross = {}
    for op, (lo, hi) in EXPAL_CELL11.items():
        t = breakdown[op]["total"]
        cross[op] = {
            "expAN_total": t,
            "expAL_cell11": [lo, hi],
            "delta_vs_low": t - lo,
            "within_1pct": abs(t - (lo + hi) / 2.0) / ((lo + hi) / 2.0) < 0.01,
        }

    kv = _parse_kv(log, "expAN equiv:")
    mm = int(kv.get("bytes-mm", -1))
    smoke = int(kv.get("smoke-fails", -1))
    checks = int(kv.get("checks", -1))
    kat_all_pass = "KAT ALL PASS" in log
    correctness_pass = (fails == 0) and (mm == 0) and (smoke == 0) and kat_all_pass

    return {
        "experiment": "AN",
        "harness_fails": fails,
        "equiv_bytes_mismatch": mm,
        "equiv_smoke_fails": smoke,
        "equiv_checks": checks,
        "kat_all_pass": kat_all_pass,
        "correctness_pass": correctness_pass,
        "calib_empty_span_cyc": empty_span,
        "calib_four_checkpoints_cyc": four_ckpt,
        "calib_per_checkpoint_cyc": per_ckpt,
        "raw": raw,
        "breakdown": breakdown,
        "cross_check_expAL_cell11": cross,
        "elf_sha256": sha256(elf),
        "srec_sha256": sha256(srec),
        "code_flash_readback_sha256": readback_hash,
        "code_flash_readback_bytes": readback_bytes,
        "gate_pass": correctness_pass and all(c["within_1pct"] for c in cross.values()),
    }


def print_effects(payload: dict) -> None:
    print("")
    print("=== expAN — X-Wing 최상위 cycle 귀속 ===")
    print("정확성: %s (harness_fails=%s, bytes-mm=%s, smoke=%s, checks=%s, KAT=%s)"
          % ("PASS" if payload["correctness_pass"] else "FAIL",
             payload["harness_fails"], payload["equiv_bytes_mismatch"],
             payload["equiv_smoke_fails"], payload["equiv_checks"],
             payload["kat_all_pass"]))
    print("계측 오버헤드: 빈 span %s cyc, 체크포인트 %.2f cyc/개"
          % (payload["calib_empty_span_cyc"], payload["calib_per_checkpoint_cyc"]))
    print("")
    for op in ("keygen", "encaps", "decaps"):
        b = payload["breakdown"][op]
        c = payload["cross_check_expAL_cell11"][op]
        print("--- %s  total=%s cyc   (expAL cell-11 %s~%s, 차이 %+d, 1%%이내=%s)"
              % (op, b["total"], c["expAL_cell11"][0], c["expAL_cell11"][1],
                 c["delta_vs_low"], c["within_1pct"]))
        for row in b["parts"]:
            print("    %-46s %12s  %6.2f%%"
                  % (row["part"], row["cycles"], row["pct_of_total"]))
        print("")


def self_test() -> None:
    assert SLOT_N == 376
    assert FIRST_SLOT == BASE == 362
    assert set(LAYOUT) == set(range(14))
    labels = {op: set() for op in ("keygen", "encaps", "decaps", "calib")}
    for op, label in LAYOUT.values():
        labels[op].add(label)
    for op, parts in PARTS.items():
        for _, upper, lower in parts:
            assert upper in labels[op], (op, upper)
            assert lower is None or lower in labels[op], (op, lower)
    print("self-test OK")


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

    print("measurement ELF SHA-256: " + sha256(args.elf))
    print("measurement SREC SHA-256: " + sha256(args.srec))
    log, fails, reps, readback_hash, readback_bytes = read_board(
        args.attach, args.elf, args.srec
    )
    print(log)
    payload = summarize(log, fails, reps, args.elf, args.srec, readback_hash, readback_bytes)
    print_effects(payload)
    print("EXPAN_JSON " + json.dumps(payload, ensure_ascii=False, sort_keys=True))
    return 0 if payload["gate_pass"] else 2


if __name__ == "__main__":
    raise SystemExit(main())
