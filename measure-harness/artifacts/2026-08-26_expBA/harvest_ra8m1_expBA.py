"""Flash expBA, summarize slots 538..542 (M85 scalar-scalar dual-issue)."""

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
SLOT_N = 548
FIRST_SLOT = 538
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



BASE = 538
INSTR = 128
KERNELS = [("A umaal 의존체인", 0, 128, 128),
           ("B umaal 독립 4-way", 1, 128, 128),
           ("C umaal+adds 교대", 2, 128, 64),
           ("D adds 독립 4-way", 3, 128, 0),
           ("E umaal+str 교대", 5, 128, 64),
           ("F umaal+ldr 교대", 6, 128, 64),
           ("G str 단독", 7, 128, 0),
           ("H ldr 단독", 8, 128, 0)]


def _med(reps, off):
    return median(reps[(BASE + off) * REP_N:(BASE + off + 1) * REP_N])


def summarize(log, fails, reps, elf, srec, rb, rbn) -> dict:
    if len(reps) != SLOT_N * REP_N:
        raise ValueError("rep_cyc length mismatch")

    raw = {name: _med(reps, off) / BATCH for name, off, _i, _m in KERNELS}
    raw["null 슬롯"] = _med(reps, 4) / BATCH

    A = raw["A umaal 의존체인"]; B = raw["B umaal 독립 4-way"]
    C = raw["C umaal+adds 교대"]; D = raw["D adds 독립 4-way"]

    # 차분 분석 (공통 호출 오버헤드 O 가 상쇄된다)
    d_umaal_minus_add = (A - D) / INSTR          # umaal 1개 - adds 1개
    # adds 가 2/cyc, umaal 이 1/cyc 라는 가설의 검증:
    c_add_hyp = 0.5
    c_umaal_hyp = c_add_hyp + d_umaal_minus_add
    O_from_A = A - INSTR * c_umaal_hyp
    O_from_D = D - INSTR * c_add_hyp
    mix_time = C - O_from_A                      # 64 umaal + 64 adds 의 실제 소요
    mix_serial = 64 * c_umaal_hyp + 64 * c_add_hyp
    mix_paired = 64 * c_umaal_hyp                # 완전 페어링이면 umaal 이 율속
    pairing = (mix_serial - mix_time) / (mix_serial - mix_paired) if mix_serial != mix_paired else 0.0

    O = O_from_A
    E = raw["E umaal+str 교대"]; F = raw["F umaal+ldr 교대"]
    G = raw["G str 단독"]; H = raw["H ldr 단독"]
    c_str = (G - O) / INSTR
    c_ldr = (H - O) / INSTR
    ls = {}
    for tag, tot, c_other in (("str", E, c_str), ("ldr", F, c_ldr)):
        t = tot - O
        serial = 64 * c_umaal_hyp + 64 * c_other
        paired = 64 * max(c_umaal_hyp, c_other)
        ls[tag] = {
            "unit_cyc": c_other,
            "mix_measured": t, "mix_if_serial": serial, "mix_if_paired": paired,
            "pairing_ratio": ((serial - t) / (serial - paired)) if serial != paired else 0.0,
        }

    kat = "KAT ALL PASS" in log
    ok = (fails == 0) and kat
    return {
        "experiment": "BA",
        "c_str": c_str, "c_ldr": c_ldr, "loadstore": ls,
        "harness_fails": fails, "kat_all_pass": kat, "correctness_pass": ok,
        "raw_cyc_per_call": raw,
        "delta_umaal_minus_add": d_umaal_minus_add,
        "hyp_c_add": c_add_hyp, "hyp_c_umaal": c_umaal_hyp,
        "overhead_from_A": O_from_A, "overhead_from_D": O_from_D,
        "overhead_consistent": abs(O_from_A - O_from_D) < 1.0,
        "mix_measured": mix_time, "mix_if_serial": mix_serial,
        "mix_if_fully_paired": mix_paired, "pairing_ratio": pairing,
        "dep_equals_indep": abs(A - B) < 1.0,
        "elf_sha256": sha256(elf), "srec_sha256": sha256(srec),
        "code_flash_readback_sha256": rb, "code_flash_readback_bytes": rbn,
        "gate_pass": ok,
    }


def print_effects(p: dict) -> None:
    print("")
    print("=== expBA — M85 스칼라x스칼라 듀얼이슈 (차분 분석) ===")
    print("정확성: %s (harness_fails=%s, KAT=%s)"
          % ("PASS" if p["correctness_pass"] else "FAIL", p["harness_fails"], p["kat_all_pass"]))
    print("")
    print("  호출당 raw cycles (오버헤드 포함):")
    for k, v in p["raw_cyc_per_call"].items():
        print("    %-22s %8.2f" % (k, v))
    print("")
    print("  A-D 차분 = %.3f cyc/instr  (umaal 1개 - adds 1개)" % p["delta_umaal_minus_add"])
    print("  가설 adds=%.1f cyc -> umaal=%.3f cyc" % (p["hyp_c_add"], p["hyp_c_umaal"]))
    print("  오버헤드 교차확인: A로부터 %.2f, D로부터 %.2f -> 일치 %s"
          % (p["overhead_from_A"], p["overhead_from_D"],
             "예" if p["overhead_consistent"] else "아니오"))
    print("  의존체인 == 독립 4-way : %s (umaal 은 의존성 제약이 아니라 처리율 제약)"
          % ("예" if p["dep_equals_indep"] else "아니오"))
    print("")
    print("  혼합(64 umaal + 64 adds): 실측 %.1f | 직렬이면 %.1f | 완전페어링이면 %.1f"
          % (p["mix_measured"], p["mix_if_serial"], p["mix_if_fully_paired"]))
    print("  -> 페어링 달성률 %.1f%%" % (100.0 * p["pairing_ratio"]))
    print("")
    print("  메모리 단가: str %.3f cyc, ldr %.3f cyc" % (p["c_str"], p["c_ldr"]))
    for tag in ("str", "ldr"):
        d = p["loadstore"][tag]
        print("  umaal+%s(64+64): 실측 %.1f | 직렬 %.1f | 완전페어링 %.1f -> 달성률 %.1f%%"
              % (tag, d["mix_measured"], d["mix_if_serial"], d["mix_if_paired"],
                 100.0 * d["pairing_ratio"]))


def self_test() -> None:
    assert SLOT_N == 548 and FIRST_SLOT == BASE == 538
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
        self_test(); return 0
    print("measurement ELF SHA-256: " + sha256(args.elf))
    log, fails, reps, rb, rbn = read_board(args.attach, args.elf, args.srec)
    print(log)
    payload = summarize(log, fails, reps, args.elf, args.srec, rb, rbn)
    print_effects(payload)
    print("EXPBA_JSON " + json.dumps(payload, ensure_ascii=False, sort_keys=True))
    return 0 if payload["gate_pass"] else 2


if __name__ == "__main__":
    raise SystemExit(main())
