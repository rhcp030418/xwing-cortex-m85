"""Flash expBH (K31 libc wrap); expBF/BG slots summarized too."""

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
SLOT_N = 617
FIRST_SLOT = 570
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



BASE = 570
OPS = ("keygen", "encaps", "decaps")
MICRO_GATE = 50.0


def _kv(log, prefix):
    out = {}
    for ln in log.splitlines():
        if ln.startswith(prefix):
            for t in ln[len(prefix):].split():
                if "=" in t:
                    k, _, v = t.partition("=")
                    try:
                        out[k] = int(v)
                    except ValueError:
                        pass
    return out


def _kv2(log, key):
    for ln in log.splitlines():
        if ln.startswith("expBH xw:"):
            for tk in ln.split():
                if tk.startswith(key):
                    return int(tk[len(key):])
    return -1


def _med(reps, off):
    return median(reps[(BASE + off) * REP_N:(BASE + off + 1) * REP_N])


def summarize(log, fails, reps, elf, srec, rb, rbn) -> dict:
    if len(reps) != SLOT_N * REP_N:
        raise ValueError("rep_cyc length mismatch")
    a1 = _med(reps, 0) / BATCH; b1 = _med(reps, 1) / BATCH
    b2 = _med(reps, 2) / BATCH; a2 = _med(reps, 3) / BATCH
    mp = min(100.0 * (a1 - b1) / a1, 100.0 * (a2 - b2) / a2)

    full = {}
    for oi, op in enumerate(OPS):
        A1 = _med(reps, 4 + oi); B1 = _med(reps, 7 + oi)
        B2 = _med(reps, 10 + oi); A2 = _med(reps, 13 + oi)
        p1 = 100.0 * (A1 - B1) / A1
        p2 = 100.0 * (A2 - B2) / A2
        full[op] = {"A": (A1 + A2) / 2.0, "B": (B1 + B2) / 2.0,
                    "saving_pct_conservative": min(p1, p2)}

    k1 = _kv(log, "expBF state-mm=")
    k2 = _kv(log, "expBF xw:")
    smm, chk = -1, -1
    for ln in log.splitlines():
        if ln.startswith("expBF state-mm="):
            for t in ln.split():
                if t.startswith("state-mm="):
                    smm = int(t.split("=")[1])
                elif t.startswith("checks="):
                    chk = int(t.split("=")[1])
            break
    xmm = int(k2.get("bytes-mm", -1)); xsm = int(k2.get("smoke", -1))
    xrj = int(k2.get("reject-mm", -1))
    kat = "KAT ALL PASS" in log
    ok = (fails == 0) and (smm == 0) and (xmm == 0) and (xsm == 0) and (xrj == 0) and kat
    no_reg = all(full[o]["saving_pct_conservative"] >= 0.0 for o in OPS)
    return {
        "experiment": "BF (K22)",
        "harness_fails": fails, "state_mismatch": smm, "state_checks": chk,
        "xwing_bytes_mm": xmm, "xwing_smoke": xsm, "xwing_reject_mm": xrj,
        "kat_all_pass": kat, "correctness_pass": ok,
        "absorb_A": (a1 + a2) / 2.0, "absorb_B": (b1 + b2) / 2.0,
        "absorb_saving_pct": mp, "micro_gate_50pct": mp >= MICRO_GATE,
        "full": full, "gate_no_regression": no_reg,
        "elf_sha256": sha256(elf), "srec_sha256": sha256(srec),
        "code_flash_readback_sha256": rb, "code_flash_readback_bytes": rbn,
        "gate_pass": ok and (mp >= MICRO_GATE) and no_reg,
    }


def print_effects(p):
    print("")
    print("=== expBF (K22) — matrix-XOF absorb 캐시 ===")
    print("정확성: %s (harness_fails=%s, state-mm=%s/%s, xw bytes-mm=%s smoke=%s reject-mm=%s, KAT=%s)"
          % ("PASS" if p["correctness_pass"] else "FAIL", p["harness_fails"],
             p["state_mismatch"], p["state_checks"], p["xwing_bytes_mm"],
             p["xwing_smoke"], p["xwing_reject_mm"], p["kat_all_pass"]))
    print("")
    print("  absorb 단가  A %8.2f -> B %8.2f   절감 %+.2f%%  gate(>=50%%) %s"
          % (p["absorb_A"], p["absorb_B"], p["absorb_saving_pct"],
             "PASS" if p["micro_gate_50pct"] else "FAIL"))
    print("")
    print("  full X-Wing")
    for op in OPS:
        d = p["full"][op]
        print("    %-7s %10.0f -> %10.0f   %+7.3f%%" % (op, d["A"], d["B"],
                                                        d["saving_pct_conservative"]))
    print("  gate: 세 연산 회귀 없음 = %s" % ("PASS" if p["gate_no_regression"] else "FAIL"))


def self_test():
    assert SLOT_N == 617 and FIRST_SLOT == BASE == 570
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
    names = ["zero200 (A 영점화)", "xor34   (A 본체 XOR)",
             "memcpy200 (B 복사)", "xor2    (B XOR 2B@32)"]
    print()
    print("=== BF 진단 — absorb 원가 분해 (cyc/호출, BATCH=%d) ===" % BATCH)
    for k in range(4):
        print("  %-22s %10.2f" % (names[k], _med(reps, 586 - FIRST_SLOT + k) / BATCH))
    print()
    # ---- expBJ (K24 분모) ----
    B16 = 16.0
    perm = _med(reps, 38) / B16
    extr = _med(reps, 39) / B16
    sqz  = _med(reps, 40) / B16
    print()
    print("=== expBJ — squeeze 배관 분해 (cyc/호출, BATCH=16) ===")
    print("    StatePermute          %8.2f" % perm)
    print("    StateExtractBytes168  %8.2f   (%.2f cyc/byte)" % (extr, extr / 168.0))
    print("    squeezeblocks(1)      %8.2f" % sqz)
    print("    배관 = squeeze - perm %8.2f   그중 extract %5.1f%%, 호출/기타 %5.1f%%"
          % (sqz - perm, 100.0 * extr / (sqz - perm) if sqz > perm else -1,
             100.0 * (sqz - perm - extr) / (sqz - perm) if sqz > perm else -1))
    pb = _med(reps, 41) / B16
    ps = _med(reps, 42) / B16
    print("    --- 배치 A/B (같은 순열, 상태 위치만 다름) ---")
    print("    상태 .bss(SRAM)       %8.2f" % pb)
    print("    상태 DTCM 스택        %8.2f   비 %.2fx" % (ps, pb / ps if ps else -1))
    ed = _med(reps, 43) / B16
    sd = _med(reps, 44) / B16
    print("    --- DTCM 상태 기준 (실제 경로와 같은 배치) ---")
    print("    StateExtractBytes168  %8.2f   (%.2f cyc/byte)" % (ed, ed / 168.0))
    print("    squeezeblocks(1)      %8.2f" % sd)
    print("    배관 = squeeze - perm %8.2f   그중 extract %5.1f%%"
          % (sd - ps, 100.0 * ed / (sd - ps) if sd > ps else -1))
    lc = _med(reps, 45) / B16
    wc = _med(reps, 46) / B16
    print("    --- libc 200B 복사, DTCM 스택 기준 ---")
    print("    newlib memcpy         %8.2f   (%.2f cyc/byte)   [.bss 2522.75]" % (lc, lc / 200.0))
    print("    워드 루프             %8.2f   (%.2f cyc/byte)   [.bss  442.98]" % (wc, wc / 200.0))
    print("EXPBJ_JSON " + json.dumps({"permute": perm, "extract168": extr,
                                      "squeezeblocks": sqz, "plumbing": sqz - perm},
                                     sort_keys=True))
    print()
    # ---- expBI (채택 빌드 대표값) ----
    LIM = {"keygen": 634890.0, "encaps": 1062857.0, "decaps": 856837.0}
    print()
    print("=== expBI — 채택 빌드 대표값 (토글 제거, X06+X02+K31) ===")
    bi = {}
    bi_ok = True
    for oi, op in enumerate(OPS):
        p1 = _med(reps, 32 + oi); p2 = _med(reps, 35 + oi)
        v = min(p1, p2)
        bi[op] = {"pass1": p1, "pass2": p2, "rep": v, "limit": LIM[op],
                  "under_limit": v <= LIM[op]}
        if v > LIM[op]:
            bi_ok = False
        print("    %-7s 1차 %10.0f  2차 %10.0f   대표 %10.0f   (BH-B %9.0f) %s"
              % (op, p1, p2, v, LIM[op], "OK" if v <= LIM[op] else "OVER"))
    print("  BI-1 세 연산 모두 expBH B 이하 = %s" % ("PASS" if bi_ok else "FAIL"))
    print("  expBI smoke=%s" % _kv(log, "expBI smoke="))
    print("EXPBI_JSON " + json.dumps({"ops": bi, "bi1_pass": bi_ok,
                                      "smoke": _kv(log, "expBI smoke=")}, sort_keys=True))
    print()
    # ---- expBH (K31) ----
    bh = {}
    for oi, op in enumerate(OPS):
        A1 = _med(reps, 20 + oi); B1 = _med(reps, 23 + oi)
        B2 = _med(reps, 26 + oi); A2 = _med(reps, 29 + oi)
        bh[op] = {"A": (A1 + A2) / 2.0, "B": (B1 + B2) / 2.0,
                  "saving_pct_conservative": min(100.0 * (A1 - B1) / A1,
                                                 100.0 * (A2 - B2) / A2)}
    cnt = {}
    for ln in log.splitlines():
        if ln.startswith("expBH cnt "):
            tk = ln.split()
            cnt[tk[2]] = {k.split("=")[0]: int(k.split("=")[1]) for k in tk[3:] if "=" in k}
    bh_mm = _kv(log, "expBH xw: bytes-mm=")
    print()
    print("=== expBH (K31) — libc memcpy/memset 워드 교체 ===")
    print("  분모 (호출로 남은 것만; 인라인된 복사는 세지 못함)")
    for op in OPS:
        c = cnt.get(op, {})
        print("    %-7s memcpy %5d call / %7d B    memset %5d call / %7d B"
              % (op, c.get("memcpy-calls", -1), c.get("memcpy-bytes", -1),
                 c.get("memset-calls", -1), c.get("memset-bytes", -1)))
        if c:
            est = c.get("memcpy-bytes", 0) * 12.61 + c.get("memset-bytes", 0) * 3.07
            print("             (파생 추정 libc 비용 %.0f cyc)" % est)
    print("  full X-Wing")
    ok2 = 0
    for op in OPS:
        v = bh[op]
        print("    %-7s %10.0f -> %10.0f   %+7.3f%%" % (op, v["A"], v["B"],
                                                        v["saving_pct_conservative"]))
        if v["saving_pct_conservative"] >= 1.0:
            ok2 += 1
    no_reg = all(bh[o]["saving_pct_conservative"] >= 0.0 for o in OPS)
    print("  BH-1 회귀 없음 = %s" % ("PASS" if no_reg else "FAIL"))
    print("  BH-2 두 연산 이상 >=1.00%% = %s (%d/3)" % ("PASS" if ok2 >= 2 else "FAIL", ok2))
    print("  정확성 xw bytes-mm=%s smoke=%s reject-mm=%s"
          % (bh_mm, _kv(log, "expBH xw: bytes-mm=%s smoke=" % bh_mm) if False else
             _kv2(log, "smoke="), _kv2(log, "reject-mm=")))
    print("EXPBH_JSON " + json.dumps({"counts": cnt, "full": bh, "bh1_no_regression": no_reg,
                                      "bh2_two_ops_1pct": ok2 >= 2, "xw_bytes_mm": bh_mm},
                                     sort_keys=True))
    print()
    print("EXPBF_JSON " + json.dumps(payload, ensure_ascii=False, sort_keys=True))
    return 0 if payload["gate_pass"] else 2


if __name__ == "__main__":
    raise SystemExit(main())
