"""Flash expAP, collect the RAM log, and summarize slots 390..419.

ML-KEM non-Keccak internal attribution on the current X/Y/C8+C9 path.
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
SLOT_N = 420
FIRST_SLOT = 390
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



# ---- expAP analysis ----

BASE = 390
OPS = ("keygen", "encaps", "decaps")
OP_OFF = {"keygen": 0, "encaps": 10, "decaps": 20}
BUCKETS = ("NTT", "invNTT", "matacc", "basemul", "noise(CBD)",
           "packing", "arith", "verify/cmov")

# same-ELF references
AO_BASE = 376
AO_KECCAK = {"keygen": 2, "encaps": 6, "decaps": 10}   # keccak cyc slots
AN_BASE = 362
AN_MLKEM = {"keygen": 1, "encaps": 4, "decaps": 9}


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


def _med(reps: list, offset: int, base: int = BASE) -> int:
    return median(reps[(base + offset) * REP_N : (base + offset + 1) * REP_N])


def _acc(reps: list, offset: int) -> tuple:
    """bucket 슬롯은 [0]=cycle 합계, [1]=call 합계 (REP_N 전체)."""
    row = reps[(BASE + offset) * REP_N : (BASE + offset + 1) * REP_N]
    return row[0], row[1]


def summarize(
    log: str, fails: int, reps: list, elf: Path, srec: Path,
    readback_hash: str, readback_bytes: int,
) -> dict:
    if len(reps) != SLOT_N * REP_N:
        raise ValueError("rep_cyc length mismatch")

    per_op = {}
    for op in OPS:
        o = OP_OFF[op]
        t_off = _med(reps, o + 0)
        t_on = _med(reps, o + 1)
        keccak = _med(reps, AO_KECCAK[op], AO_BASE)
        mlkem = _med(reps, AN_MLKEM[op], AN_BASE)
        non_keccak = mlkem - keccak

        rows = []
        covered = 0
        for i, name in enumerate(BUCKETS):
            cyc_sum, call_sum = _acc(reps, o + 2 + i)
            per_rep = cyc_sum / REP_N
            covered += per_rep
            rows.append({
                "bucket": name,
                "cycles_per_op": per_rep,
                "calls_per_op": call_sum / REP_N,
                "pct_of_non_keccak": 100.0 * per_rep / non_keccak if non_keccak else 0.0,
            })
        per_op[op] = {
            "total_prof_off": t_off,
            "total_prof_on": t_on,
            "probe_cost_total": t_on - t_off,
            "mlkem_same_elf": mlkem,
            "keccak_same_elf": keccak,
            "mlkem_non_keccak": non_keccak,
            "buckets": rows,
            "covered": covered,
            "unattributed": non_keccak - covered,
            "coverage_pct": 100.0 * covered / non_keccak if non_keccak else 0.0,
        }

    kv = _parse_kv(log, "expAP equiv:")
    mm = int(kv.get("bytes-mm", -1))
    checks = int(kv.get("checks", -1))
    kat = "KAT ALL PASS" in log
    ok = (fails == 0) and (mm == 0) and kat

    return {
        "experiment": "AP",
        "harness_fails": fails,
        "equiv_bytes_mismatch": mm,
        "equiv_checks": checks,
        "kat_all_pass": kat,
        "correctness_pass": ok,
        "per_op": per_op,
        "elf_sha256": sha256(elf),
        "srec_sha256": sha256(srec),
        "code_flash_readback_sha256": readback_hash,
        "code_flash_readback_bytes": readback_bytes,
        "gate_pass": ok,
    }


def print_effects(payload: dict) -> None:
    print("")
    print("=== expAP — ML-KEM 비-Keccak 내부 재귀속 ===")
    print("정확성: %s (harness_fails=%s, bytes-mm=%s, checks=%s, KAT=%s)"
          % ("PASS" if payload["correctness_pass"] else "FAIL",
             payload["harness_fails"], payload["equiv_bytes_mismatch"],
             payload["equiv_checks"], payload["kat_all_pass"]))
    for op in OPS:
        d = payload["per_op"][op]
        print("")
        print("--- %s   ML-KEM %s = Keccak %s + 비-Keccak %s   (probe %+d)"
              % (op, d["mlkem_same_elf"], d["keccak_same_elf"],
                 d["mlkem_non_keccak"], d["probe_cost_total"]))
        for r in sorted(d["buckets"], key=lambda x: -x["cycles_per_op"]):
            print("    %-14s %10.1f cyc  %6.2f%%  (%.1f calls/op)"
                  % (r["bucket"], r["cycles_per_op"],
                     r["pct_of_non_keccak"], r["calls_per_op"]))
        print("    %-14s %10.1f cyc  %6.2f%%   ← 계측 밖 잔여"
              % ("미귀속", d["unattributed"],
                 100.0 - d["coverage_pct"]))


def self_test() -> None:
    assert SLOT_N == 420 and FIRST_SLOT == BASE == 390
    assert len(BUCKETS) == 8
    for op in OPS:
        assert OP_OFF[op] + 2 + 7 < 30
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
    print("EXPAP_JSON " + json.dumps(payload, ensure_ascii=False, sort_keys=True))
    return 0 if payload["gate_pass"] else 2


if __name__ == "__main__":
    raise SystemExit(main())
