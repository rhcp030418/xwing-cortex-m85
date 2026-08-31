"""Flash expDB and summarize slots 862..869 (all-phase solver: F/U/Ut/Us)."""

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
SLOT_N = 974
FIRST_SLOT = 862
BATCH = 1
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





BASE = 862
CALLS = 96        # 24 rounds x four solver-rescheduled phase fragments


def _parse_kv(log, prefix):
    out = {}
    for line in log.splitlines():
        if line.startswith(prefix):
            for tok in line[len(prefix):].split():
                if "=" in tok:
                    k, _, v = tok.partition("=")
                    try:
                        out[k] = int(v)
                    except ValueError:
                        pass
    return out


def _cell(reps, off):
    return sorted(reps[(BASE + off) * REP_N:(BASE + off + 1) * REP_N])


def _med(reps, off):
    v = _cell(reps, off)
    return v[len(v) // 2]


LABELS = ["F", "U", "Ut", "Us", "Us", "Ut", "U", "F"]


def summarize(log, fails, reps, elf, srec, rb, rbn) -> dict:
    if len(reps) != SLOT_N * REP_N:
        raise ValueError("rep_cyc length mismatch")
    f1, u1, _t1, s1, s2, _t2, u2, f2 = (_med(reps, i) for i in range(8))
    f = (f1 + f2) / 2.0
    du1, du2 = u1 - f1, u2 - f2          # 지퍼 U 의 융합 손실
    ds1, ds2 = s1 - f1, s2 - f2          # 솔버 U_s 의 융합 손실
    gain = ((u1 - s1) + (u2 - s2)) / 2.0  # U - U_s (양수 = 솔버 승)
    cells = []
    for i in range(8):
        v = _cell(reps, i)
        cells.append({"label": LABELS[i], "slot": BASE + i, "median": v[len(v) // 2],
                      "p25": v[len(v) // 4], "p75": v[3 * len(v) // 4],
                      "min": v[0], "max": v[-1]})
    t1, t2 = _med(reps, 2), _med(reps, 5)
    kv = _parse_kv(log, "expDB mismatch=")
    mm = int(kv.get("", -1)) if kv else -1
    for line in log.splitlines():
        if line.startswith("expDB mismatch="):
            mm = int(line.split("=")[1].split()[0])
    kat = "KAT ALL PASS" in log
    ok = (fails == 0) and (mm == 0) and kat
    return {
        "experiment": "DB",
        "harness_fails": fails, "mismatch": mm,
        "kat_all_pass": kat, "correctness_pass": ok,
        "F_seq4": {"first": f1, "last": f2, "median": f},
        "U_zip": {"first": u1, "last": u2},
        "Us_solver": {"first": s1, "last": s2},
        "Ut_transform": {"first": t1, "last": t2},
        "cells": cells,
        "Ut_minus_U": [t1 - u1, t2 - u2],
        "Us_minus_Ut": [s1 - t1, s2 - t2],
        "U_minus_F": [du1, du2], "Us_minus_F": [ds1, ds2],
        "U_minus_Us": [u1 - s1, u2 - s2], "solver_gain_cycles": gain,
        "solver_gain_pct_of_F": 100.0 * gain / f,
        "solver_gain_per_call": gain / CALLS,
        "solver_beats_zipper": gain > 0,
        "solver_beats_sequential": ((s1 < f1) and (s2 < f2)),
        "elf_sha256": sha256(elf), "srec_sha256": sha256(srec),
        "code_flash_readback_sha256": rb, "code_flash_readback_bytes": rbn,
        "gate_pass": ok,
    }


def print_effects(p):
    print("")
    print("=== expDB — 네 phase 전체 솔버 재스케줄 (F / U / Ut / Us) ===")
    print("정확성: %s (harness_fails=%s, mismatch=%s, KAT=%s)"
          % ("PASS" if p["correctness_pass"] else "FAIL", p["harness_fails"],
             p["mismatch"], p["kat_all_pass"]))
    print("  F  순차   %9.1f / %9.1f" % (p["F_seq4"]["first"], p["F_seq4"]["last"]))
    print("  U  지퍼   %9.1f / %9.1f   (U-F %+.0f / %+.0f)"
          % (p["U_zip"]["first"], p["U_zip"]["last"], *p["U_minus_F"]))
    print("  Us 솔버   %9.1f / %9.1f   (Us-F %+.0f / %+.0f)"
          % (p["Us_solver"]["first"], p["Us_solver"]["last"], *p["Us_minus_F"]))
    print("  U - Us = %+.0f / %+.0f  -> 평균 %+.1f cyc "
          "(%+.3f%% of F, 조각 1회당 %+.2f)"
          % (*p["U_minus_Us"], p["solver_gain_cycles"],
             p["solver_gain_pct_of_F"], p["solver_gain_per_call"]))
    print("  Ut 변환대조 %9.1f / %9.1f   (Ut-U %+.0f / %+.0f)"
          % (p["Ut_transform"]["first"], p["Ut_transform"]["last"], *p["Ut_minus_U"]))
    print("  Us - Ut (순수 스케줄 효과) %+.0f / %+.0f" % tuple(p["Us_minus_Ut"]))
    print("  솔버 > 지퍼: %s   솔버 > 순차: %s"
          % (p["solver_beats_zipper"], p["solver_beats_sequential"]))
    print("  --- 셀별 (median [p25..p75] min/max)")
    for c in p["cells"]:
        print("   %3d %-3s %9d [%9d..%9d] %9d/%9d"
              % (c["slot"], c["label"], c["median"], c["p25"], c["p75"],
                 c["min"], c["max"]))


def self_test():
    assert SLOT_N == 974 and FIRST_SLOT == BASE == 862 and BATCH == 1
    print("self-test OK")


def arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument("--attach", action="store_true")
    parser.add_argument("--self-test", action="store_true")
    parser.add_argument("--elf", type=Path, default=DEFAULT_ELF)
    parser.add_argument("--srec", type=Path, default=DEFAULT_SREC)
    return parser.parse_args()


def main():
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    args = arguments()
    if args.self_test:
        self_test(); return 0
    print("measurement ELF SHA-256: " + sha256(args.elf))
    log, fails, reps, rb, rbn = read_board(args.attach, args.elf, args.srec)
    print(log)
    payload = summarize(log, fails, reps, args.elf, args.srec, rb, rbn)
    print_effects(payload)
    print("EXPDB_JSON " + json.dumps(payload, ensure_ascii=False, sort_keys=True))
    return 0 if payload["gate_pass"] else 2


if __name__ == "__main__":
    raise SystemExit(main())
