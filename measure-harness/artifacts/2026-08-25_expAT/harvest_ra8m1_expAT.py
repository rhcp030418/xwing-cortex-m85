"""Flash expAT-0, collect the RAM log, and summarize slots 459..471 (CT table lookup cost)."""

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
SLOT_N = 489
FIRST_SLOT = 459
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



# ---- expAT-0 analysis ----

BASE = 459
NS = (2, 4, 8, 16)
W_OF_N = {2: 2, 4: 3, 8: 4, 16: 5}
WINDOWS = {2: 128, 3: 85, 4: 64, 5: 51}
ENTRY_WORDS = 24

# 사전등록 §4: 산술 투영 (실측 단가 x 문헌 연산 수)
ARITH = {2: 129929, 3: 86281, 4: 64964, 5: 51769}
CURRENT_LADDER = 357839


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


def _med(reps, offset):
    return median(reps[(BASE + offset) * REP_N : (BASE + offset + 1) * REP_N])


def summarize(log, fails, reps, elf, srec, readback_hash, readback_bytes) -> dict:
    if len(reps) != SLOT_N * REP_N:
        raise ValueError("rep_cyc length mismatch")

    null = _med(reps, 12) / BATCH
    per_n = {}
    for i, n in enumerate(NS):
        s = _med(reps, i) / BATCH - null
        v = _med(reps, 4 + i) / BATCH - null
        w = W_OF_N[n]
        nwin = WINDOWS[w]
        v2 = _med(reps, 22 + i) / BATCH - null
        s2 = _med(reps, 26 + i) / BATCH - null
        s_ram = _med(reps, 14 + i) / BATCH - null
        v_ram = _med(reps, 18 + i) / BATCH - null
        per_n[n] = {
            "mve2_cyc_per_select": v2,
            "scalar2_cyc_per_select": s2,
            "mve2_cyc_per_word": v2 / (n * ENTRY_WORDS),
            "scalar2_cyc_per_word": s2 / (n * ENTRY_WORDS),
            "lookup_total_mve2": v2 * nwin,
            "lookup_total_scalar2": s2 * nwin,
            "total_mve2": ARITH[w] + v2 * nwin,
            "total_scalar2": ARITH[w] + s2 * nwin,
            "saving_mve2_pct": 100.0 * (CURRENT_LADDER - (ARITH[w] + v2 * nwin)) / CURRENT_LADDER,
            "saving_scalar2_pct": 100.0 * (CURRENT_LADDER - (ARITH[w] + s2 * nwin)) / CURRENT_LADDER,
            "scalar_ram_cyc_per_select": s_ram,
            "mve_ram_cyc_per_select": v_ram,
            "flash_penalty_scalar": s - s_ram,
            "flash_penalty_mve": v - v_ram,
            "lookup_total_scalar_ram": s_ram * nwin,
            "lookup_total_mve_ram": v_ram * nwin,
            "total_scalar_ram": ARITH[w] + s_ram * nwin,
            "total_mve_ram": ARITH[w] + v_ram * nwin,
            "saving_scalar_ram_pct": 100.0 * (CURRENT_LADDER - (ARITH[w] + s_ram * nwin)) / CURRENT_LADDER,
            "saving_mve_ram_pct": 100.0 * (CURRENT_LADDER - (ARITH[w] + v_ram * nwin)) / CURRENT_LADDER,
            "w": w,
            "windows": nwin,
            "scalar_cyc_per_select": s,
            "mve_cyc_per_select": v,
            "mve_speedup": s / v if v else 0.0,
            "scalar_cyc_per_word": s / (n * ENTRY_WORDS),
            "mve_cyc_per_word": v / (n * ENTRY_WORDS),
            "lookup_total_scalar": s * nwin,
            "lookup_total_mve": v * nwin,
            "arith": ARITH[w],
            "total_scalar": ARITH[w] + s * nwin,
            "total_mve": ARITH[w] + v * nwin,
            "saving_scalar_pct": 100.0 * (CURRENT_LADDER - (ARITH[w] + s * nwin)) / CURRENT_LADDER,
            "saving_mve_pct": 100.0 * (CURRENT_LADDER - (ARITH[w] + v * nwin)) / CURRENT_LADDER,
        }

    ct = {
        "scalar_idx0": _med(reps, 8) / BATCH - null,
        "scalar_idx7": _med(reps, 9) / BATCH - null,
        "mve_idx0": _med(reps, 10) / BATCH - null,
        "mve_idx7": _med(reps, 11) / BATCH - null,
    }
    ct["scalar_delta"] = ct["scalar_idx7"] - ct["scalar_idx0"]
    ct["mve_delta"] = ct["mve_idx7"] - ct["mve_idx0"]

    kv = _parse_kv(log, "expAT correctness:")
    mm_s = int(kv.get("scalar-mm", -1))
    mm_v = int(kv.get("mve-mm", -1))
    checks = int(kv.get("checks", -1))
    kat = "KAT ALL PASS" in log
    ok = (fails == 0) and (mm_s == 0) and (mm_v == 0) and kat

    keys = ("saving_scalar_pct", "saving_mve_pct",
            "saving_scalar_ram_pct", "saving_mve_ram_pct",
            "saving_mve2_pct", "saving_scalar2_pct")
    best_val = max(max(d[k] for k in keys) for d in per_n.values())
    gate = best_val >= 30.0
    best_cfg = max(
        ((n, k) for n in NS for k in keys),
        key=lambda p: per_n[p[0]][p[1]],
    )

    return {
        "experiment": "AT-0",
        "harness_fails": fails,
        "mm_scalar": mm_s,
        "mm_mve": mm_v,
        "checks": checks,
        "kat_all_pass": kat,
        "correctness_pass": ok,
        "null_overhead_per_select": null,
        "per_n": per_n,
        "constant_time": ct,
        "prereg_gate_30pct": gate,
        "best_saving_pct": best_val,
        "best_config": {"N": best_cfg[0], "variant": best_cfg[1]},
        "elf_sha256": sha256(elf),
        "srec_sha256": sha256(srec),
        "code_flash_readback_sha256": readback_hash,
        "code_flash_readback_bytes": readback_bytes,
        "gate_pass": ok and gate,
    }


def print_effects(payload: dict) -> None:
    print("")
    print("=== expAT-0 — constant-time 표 조회 단가 실측 ===")
    print("정확성: %s (harness_fails=%s, scalar-mm=%s, mve-mm=%s, checks=%s, KAT=%s)"
          % ("PASS" if payload["correctness_pass"] else "FAIL",
             payload["harness_fails"], payload["mm_scalar"], payload["mm_mve"],
             payload["checks"], payload["kat_all_pass"]))
    print("배치 루프 null 오버헤드: %.2f cyc/select (아래는 전부 차감 후)"
          % payload["null_overhead_per_select"])
    print("")
    print("  N   w  win   scalar/select   MVE/select  MVE배속 | scalar cyc/word  MVE cyc/word")
    for n in NS:
        d = payload["per_n"][n]
        print("  %2d  %d  %3d   %10.1f   %10.1f   %5.2fx | %9.2f      %9.2f"
              % (n, d["w"], d["windows"], d["scalar_cyc_per_select"],
                 d["mve_cyc_per_select"], d["mve_speedup"],
                 d["scalar_cyc_per_word"], d["mve_cyc_per_word"]))
    print("")
    print("  N   RAM상주:  scalar/select   MVE/select | flash 페널티 S / V")
    for n in NS:
        d = payload["per_n"][n]
        print("  %2d            %10.1f   %10.1f | %+9.1f  %+9.1f"
              % (n, d["scalar_ram_cyc_per_select"], d["mve_ram_cyc_per_select"],
                 d["flash_penalty_scalar"], d["flash_penalty_mve"]))
    print("")
    print("scalarmult 1회 투영 (산술=사전등록 §4 투영 + 조회=이번 실측):")
    print("  w  산술      조회(S)     합(S)     절감(S) | 조회(V)    합(V)     절감(V)")
    for n in NS:
        d = payload["per_n"][n]
        print("  %d  %7d  %8.0f  %8.0f   %+6.1f%% | %8.0f %8.0f   %+6.1f%%"
              % (d["w"], d["arith"], d["lookup_total_scalar"], d["total_scalar"],
                 d["saving_scalar_pct"], d["lookup_total_mve"], d["total_mve"],
                 d["saving_mve_pct"]))
    print("")
    print("  같은 표를 RAM 에 두면:")
    print("  w  산술      조회(S)     합(S)     절감(S) | 조회(V)    합(V)     절감(V)")
    for n in NS:
        d = payload["per_n"][n]
        print("  %d  %7d  %8.0f  %8.0f   %+6.1f%% | %8.0f %8.0f   %+6.1f%%"
              % (d["w"], d["arith"], d["lookup_total_scalar_ram"], d["total_scalar_ram"],
                 d["saving_scalar_ram_pct"], d["lookup_total_mve_ram"], d["total_mve_ram"],
                 d["saving_mve_ram_pct"]))
    print("")
    print("  개선 커널 (MVE+vpsel / scalar chunked):")
    print("  w   N   MVE2/sel  cyc/word  절감(V2) | S2/sel  cyc/word  절감(S2)")
    for n in NS:
        d = payload["per_n"][n]
        print("  %d  %2d  %9.1f  %7.2f  %+6.1f%% | %7.1f %7.2f  %+6.1f%%"
              % (d["w"], n, d["mve2_cyc_per_select"], d["mve2_cyc_per_word"],
                 d["saving_mve2_pct"], d["scalar2_cyc_per_select"],
                 d["scalar2_cyc_per_word"], d["saving_scalar2_pct"]))
    c = payload["constant_time"]
    print("")
    print("상수시간: scalar idx0=%.1f idx7=%.1f (차 %+.2f) | MVE idx0=%.1f idx7=%.1f (차 %+.2f)"
          % (c["scalar_idx0"], c["scalar_idx7"], c["scalar_delta"],
             c["mve_idx0"], c["mve_idx7"], c["mve_delta"]))
    print("최선: N=%d %s -> %+.1f%%" % (payload["best_config"]["N"],
          payload["best_config"]["variant"], payload["best_saving_pct"]))
    print("사전등록 gate (>=30%% 절감 투영): %s"
          % ("PASS" if payload["prereg_gate_30pct"] else "FAIL"))


def self_test() -> None:
    assert SLOT_N == 489 and FIRST_SLOT == BASE == 459
    assert BATCH == 64
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
    print("EXPAT_JSON " + json.dumps(payload, ensure_ascii=False, sort_keys=True))
    return 0 if payload["gate_pass"] else 2


if __name__ == "__main__":
    raise SystemExit(main())
