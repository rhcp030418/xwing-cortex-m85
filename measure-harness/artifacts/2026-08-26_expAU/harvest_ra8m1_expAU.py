"""Flash expAU (AT-2), collect the RAM log, and summarize slots 489..496 (fixed-base X25519)."""

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
SLOT_N = 502
FIRST_SLOT = 489
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



# ---- expAU (AT-2) analysis ----

BASE = 489
GATE_PCT = 25.0          # 사전등록 §8.1 AT-2
EXPAN_X25519 = 357839    # 깨끗한 빌드의 fixed-base 구간 (expAN)


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


def _stat(reps, offset):
    v = reps[(BASE + offset) * REP_N : (BASE + offset + 1) * REP_N]
    return {"median": median(v), "min": min(v), "max": max(v)}


def summarize(log, fails, reps, elf, srec, readback_hash, readback_bytes) -> dict:
    if len(reps) != SLOT_N * REP_N:
        raise ValueError("rep_cyc length mismatch")

    a1, b1, b2, a2 = (_stat(reps, i) for i in range(4))
    ct = {
        "A_low": _stat(reps, 4)["median"], "A_high": _stat(reps, 5)["median"],
        "B_low": _stat(reps, 6)["median"], "B_high": _stat(reps, 7)["median"],
    }
    ct["A_delta"] = ct["A_high"] - ct["A_low"]
    ct["B_delta"] = ct["B_high"] - ct["B_low"]

    # ABBA: 두 쌍 각각의 절감을 내고 보수적으로 작은 쪽을 취한다
    pair1 = (a1["median"] - b1["median"]) / a1["median"] * 100.0
    pair2 = (a2["median"] - b2["median"]) / a2["median"] * 100.0
    conservative = min(pair1, pair2)

    def _sum(off):
        return reps[(BASE + off) * REP_N] / REP_N
    attrib = {
        "recode": _sum(8), "select": _sum(9), "madd": _sum(10), "inv": _sum(11),
        "total_prof": _stat(reps, 12)["median"],
    }
    attrib["unattributed"] = (attrib["total_prof"] - attrib["recode"] - attrib["select"]
                              - attrib["madd"] - attrib["inv"])

    kv = _parse_kv(log, "expAU correctness:")
    kat = int(kv.get("kat-fails", -1))
    diff = int(kv.get("diff-mm", -1))
    checks = int(kv.get("checks", -1))
    kat_all = "KAT ALL PASS" in log
    ok = (fails == 0) and (kat == 0) and (diff == 0) and kat_all

    return {
        "experiment": "AU (AT-2)",
        "harness_fails": fails,
        "rfc7748_kat_fails": kat,
        "base_vs_ladder_mismatch": diff,
        "checks": checks,
        "kat_all_pass": kat_all,
        "correctness_pass": ok,
        "A_current": {"AB": a1, "BA": a2},
        "B_fixedbase": {"AB": b1, "BA": b2},
        "saving_pct_pair1": pair1,
        "saving_pct_pair2": pair2,
        "saving_pct_conservative": conservative,
        "B_median": (b1["median"] + b2["median"]) / 2.0,
        "A_median": (a1["median"] + a2["median"]) / 2.0,
        "vs_expAN_clean": EXPAN_X25519,
        "constant_time": ct,
        "attribution": attrib,
        "gate_25pct": conservative >= GATE_PCT,
        "ct_pass": (ct["A_delta"] == 0) and (ct["B_delta"] == 0),
        "elf_sha256": sha256(elf),
        "srec_sha256": sha256(srec),
        "code_flash_readback_sha256": readback_hash,
        "code_flash_readback_bytes": readback_bytes,
        "gate_pass": ok and (conservative >= GATE_PCT) and (ct["B_delta"] == 0),
    }


def print_effects(p: dict) -> None:
    print("")
    print("=== expAU (AT-2) — fixed-base X25519 보드 A/B ===")
    print("정확성: %s (harness_fails=%s, RFC7748-kat-fails=%s, base-vs-ladder-mm=%s, checks=%s, KAT=%s)"
          % ("PASS" if p["correctness_pass"] else "FAIL", p["harness_fails"],
             p["rfc7748_kat_fails"], p["base_vs_ladder_mismatch"], p["checks"],
             p["kat_all_pass"]))
    print("")
    print("  A 현행 ladder      AB %8d   BA %8d   (median %.1f)"
          % (p["A_current"]["AB"]["median"], p["A_current"]["BA"]["median"], p["A_median"]))
    print("  B fixed-base comb  AB %8d   BA %8d   (median %.1f)"
          % (p["B_fixedbase"]["AB"]["median"], p["B_fixedbase"]["BA"]["median"], p["B_median"]))
    print("")
    print("  절감  pair1 %+.2f%%   pair2 %+.2f%%   -> conservative %+.2f%%"
          % (p["saving_pct_pair1"], p["saving_pct_pair2"], p["saving_pct_conservative"]))
    print("  사전등록 AT-2 gate (>=%.0f%%): %s"
          % (GATE_PCT, "PASS" if p["gate_25pct"] else "FAIL"))
    a = p["attribution"]
    print("")
    print("  B 단계별 귀속 (prof 빌드, total %.0f):" % a["total_prof"])
    for k in ("recode", "select", "madd", "inv", "unattributed"):
        print("    %-14s %9.0f cyc  %5.1f%%" % (k, a[k], 100.0 * a[k] / a["total_prof"]))
    c = p["constant_time"]
    print("")
    print("  상수시간  A low=%d high=%d (차 %+d) | B low=%d high=%d (차 %+d) -> %s"
          % (c["A_low"], c["A_high"], c["A_delta"], c["B_low"], c["B_high"],
             c["B_delta"], "PASS" if p["ct_pass"] else "확인 필요"))


def self_test() -> None:
    assert SLOT_N == 502 and FIRST_SLOT == BASE == 489
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
        args.attach, args.elf, args.srec)
    print(log)
    payload = summarize(log, fails, reps, args.elf, args.srec, readback_hash, readback_bytes)
    print_effects(payload)
    print("EXPAU_JSON " + json.dumps(payload, ensure_ascii=False, sort_keys=True))
    return 0 if payload["gate_pass"] else 2


if __name__ == "__main__":
    raise SystemExit(main())
