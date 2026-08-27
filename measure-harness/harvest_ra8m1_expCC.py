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
SLOT_N = 736
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


def _kvp(log, prefix, key):
    for ln in log.splitlines():
        if ln.startswith(prefix):
            for tk in ln.split():
                if tk.startswith(key):
                    return int(tk[len(key):])
    return -1


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
    assert SLOT_N == 736 and FIRST_SLOT == BASE == 570
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
    # ---- expCC (교차 종류별 겹침) ----
    B64x = 64.0
    off = 724 - 570
    cv = [_med(reps, off + k) / B64x for k in range(12)]
    (nul, M, N, O, P, Q, bVLD, bVST, bVMU, bUMA, bLDR, bSTR) = cv
    print()
    print("=== expCC — 교차 종류별 겹침 (128 명령/커널, DTCM, .text, 같은 프롤로그) ===")
    print("    기준선(총 cyc): vldrw %.2f  vstrw %.2f  vmul %.2f  umaal %.2f  ldr %.2f  str %.2f"
          % (bVLD, bVST, bVMU, bUMA, bLDR, bSTR))
    X = bUMA - 128.0
    print("    오버헤드 X = %.2f (umaal = 1.000 기준),  null 슬롯 %.2f 는 쓰지 않음" % (X, nul))
    print()
    print("    %-18s %9s %9s %9s %8s" % ("교차", "실측", "순차예상", "완전겹침", "겹침"))
    rows = [("M vldrw x umaal", M, bVLD, bUMA),
            ("N vmul  x ldr", N, bVMU, bLDR),
            ("O vstrw x umaal", O, bVST, bUMA),
            ("P vmul  x str", P, bVMU, bSTR),
            ("Q vldrw x vmul", Q, bVLD, bVMU)]
    res = {}
    for nm, mix, a1, b1 in rows:
        seq = (a1 + b1) / 2.0                 # X 가 저절로 소거된다
        best = max(a1 - X, b1 - X) / 2.0 + X
        hide = 100.0 * (seq - mix) / (seq - best) if (seq - best) > 0.01 else float("nan")
        res[nm] = {"mix": mix, "seq": seq, "best": best, "hide_pct": hide}
        print("    %-18s %9.2f %9.2f %9.2f %7.1f%%" % (nm, mix, seq, best, hide))
    print("EXPCC_JSON " + json.dumps(res, sort_keys=True, ensure_ascii=False))
    print()
    # ---- expCB-2 (메모리 포트 경합) ----
    B64m = 64.0
    nm2 = ["G vldrw x128", "H ldr x128", "I vldrw64+ldr64",
           "J vstrw x128", "K str x128", "L vstrw64+str64"]
    print()
    print("=== expCB-2 — MVE x 스칼라 메모리 포트 경합 (128 명령/커널, DTCM) ===")
    mv = [_med(reps, 147 + k) / B64m for k in range(7)]
    for k in range(6):
        print("    %-20s %8.2f cyc" % (nm2[k], mv[1 + k]))
    print("    (null %8.2f — 차분에만)" % mv[0])
    G, H, I, J, K, L = mv[1], mv[2], mv[3], mv[4], mv[5], mv[6]
    print()
    for nm3, mix, a1, b1 in (("적재", I, G, H), ("저장", L, J, K)):
        seq = (a1 + b1) / 2.0
        best = max(a1, b1) / 2.0
        if seq > best + 0.01:
            hide = 100.0 * (seq - mix) / (seq - best)
            print("    %s: 순차예상 %8.2f  완전겹침 %8.2f  실측 %8.2f  -> 겹침 %.1f%%"
                  % (nm3, seq, best, mix, hide))
        else:
            print("    %s: 두 기준선이 같아 구분 불가 (%.2f / %.2f), 실측 %.2f"
                  % (nm3, a1, b1, mix))
    print("EXPCB_JSON " + json.dumps({"names": nm2, "totals": mv[1:], "null": mv[0]},
                                     sort_keys=True, ensure_ascii=False))
    print()
    # ---- expCA (스티칭 실증) ----
    B16c = 16.0
    print()
    print("=== expCA-1 — 명령어 스티칭 실증 (intt layer67 x8  <-  Keccak x16) ===")
    print("  정확성 ntt-mm=%s  kec-mm=%s"
          % (_kvp(log, "expCA correct:", "ntt-mm="),
             _kvp(log, "expCA correct:", "kec-mm=")))
    nul = _med(reps, 140) / B16c
    A1 = _med(reps, 141) / B16c
    B1 = _med(reps, 142) / B16c
    C1 = _med(reps, 143) / B16c
    C2 = _med(reps, 144) / B16c
    B2 = _med(reps, 145) / B16c
    A2 = _med(reps, 146) / B16c
    A = min(A1, A2); Bv = min(B1, B2); C = min(C1, C2)
    print("    A  NTT 만    %8.2f  (%8.2f / %8.2f)" % (A, A1, A2))
    print("    B  Keccak 만 %8.2f  (%8.2f / %8.2f)" % (Bv, B1, B2))
    print("    C  병합      %8.2f  (%8.2f / %8.2f)" % (C, C1, C2))
    print("    (null %8.2f — 차분에만)" % nul)
    print()
    print("    순차 예상 A+B = %8.2f" % (A + Bv))
    print("    완전 은닉    A = %8.2f" % A)
    print("    실측 C       = %8.2f" % C)
    if (A + Bv) > A:
        hide = 100.0 * ((A + Bv) - C) / Bv
        print("    ->  은닉률 %.1f%%   (Keccak %.2f cyc 중 %.2f cyc 이 공짜)"
              % (hide, Bv, (A + Bv) - C))
    hide2 = (A + Bv - C) / Bv if Bv else 0.0
    ca1a = C <= A + 0.20 * Bv
    ca1b = C <= A + 0.40 * Bv
    print("    CB-1a  hide >= 80%% (C <= %8.2f) = %s   [실측 %.1f%%]"
          % (A + 0.20 * Bv, "PASS" if ca1a else "FAIL", 100.0 * hide2))
    print("    CB-1b  hide >= 60%% (C <= %8.2f) = %s" % (A + 0.40 * Bv, "PASS" if ca1b else "FAIL"))
    print("    => %s" % ("확대 단계(CA-2)로" if ca1a else
                         ("부분 성공 — 확대 안 함" if ca1b else "W03/W04/W05 종료")))
    print("EXPCA_JSON " + json.dumps({"A": A, "B": Bv, "C": C, "null": nul,
                                      "ca1a": ca1a, "ca1b": ca1b}, sort_keys=True))
    print()
    # ---- expBZ (MVE 독립 처리율 / 겹침 판별) ----
    nz = ["A umaal dep x128", "B vmul DEP x128", "C vmul INDEP x128",
          "D umaal64+vmul DEP64", "E umaal64+vmul INDEP64", "F vadd INDEP x128"]
    print()
    print("=== expBZ — MVE 독립 처리율과 스칼라 겹침 (128 명령/커널) ===")
    zv = [_med(reps, 133 + k) / 64.0 for k in range(7)]
    for k in range(6):
        print("    %-24s %8.2f cyc" % (nz[k], zv[1 + k]))
    A = zv[1]
    X = A - 128.0          # umaal = 1.000 (expBA) 로 오버헤드 산출
    print("    (오버헤드 X = %.2f, null 슬롯 %.2f 는 쓰지 않음)" % (X, zv[0]))
    print()
    print("    %-24s %10s %10s" % ("커널", "작업량", "명령당"))
    for k in range(6):
        w = zv[1 + k] - X
        print("    %-24s %10.2f %10.3f" % (nz[k], w, w / 128.0))
    wC = zv[3] - X
    wE = zv[5] - X
    print()
    print("    판정 1 — MVE 처리율: C 작업량 %.2f -> %s"
          % (wC, "1/cyc (128)" if wC < 160 else "2 cyc/명령 (256)"))
    mve64 = wC / 2.0
    seq = 64.0 + mve64
    best = max(64.0, mve64)
    print("    판정 2 — 겹침: E 작업량 %.2f   (순차 %.2f / 완전겹침 %.2f)"
          % (wE, seq, best))
    if seq > best:
        hide = 100.0 * (seq - wE) / (seq - best)
        print("             -> 은닉률 %.1f%%" % hide)
    else:
        print("             -> 두 예측이 같아 구분 불가")
    print("EXPBZ_JSON " + json.dumps({"names": nz, "totals": zv[1:], "null": zv[0],
                                      "overhead": X}, sort_keys=True, ensure_ascii=False))
    print()
    # ---- expBX (vmov core<->FP) ----
    nx = ["A umaal x128", "B vmov s,r x128", "C vmov r,s x128",
          "D umaal64+vmov64", "E eor64+vmov64"]
    print()
    print("=== expBX — core <-> FP vmov 발행 비용 (128 명령/커널) ===")
    xv = [_med(reps, 127 + k) / 64.0 for k in range(6)]
    for k in range(5):
        print("    %-20s %8.2f cyc" % (nx[k], xv[1 + k]))
    print("    (null %8.2f — 차분에만)" % xv[0])
    A, Bx, Cx, D, E = xv[1], xv[2], xv[3], xv[4], xv[5]
    print("    D - A = %+8.2f   (0 이면 vmov 가 umaal 뒤에 완전히 숨는다)" % (D - A))
    print("EXPBX_JSON " + json.dumps({"umaal": A, "vmov_r2s": Bx, "vmov_s2r": Cx,
                                      "mix_umaal": D, "mix_alu": E}, sort_keys=True))
    print()
    # ---- expBV (스칼라 x MVE) ----
    B64v = 64.0
    nmv = ["A umaal x128", "B vmul.i16 x128", "C vadd.i16 x128",
           "D umaal64+vmul64", "E umaal64+vadd64", "F umaal64+vldrw64"]
    print()
    print("=== expBV — 스칼라 x MVE 동시 발행 (128 명령/커널, 커널 간 차분) ===")
    v = [_med(reps, 120 + k) / B64v for k in range(7)]
    for k in range(6):
        print("    %-20s %8.2f cyc" % (nmv[k], v[1 + k]))
    print("    (null 슬롯 %8.2f — 차분에만 쓴다)" % v[0])
    A, Bv, C, D, E, F = v[1], v[2], v[3], v[4], v[5], v[6]
    print("    --- 은닉률 (mix 가 두 기준선의 절반 합보다 얼마나 작은가) ---")
    for nm2, mix, other in (("vmul", D, Bv), ("vadd", E, C), ("vldrw", F, None)):
        if other is None:
            print("    %-6s mix %8.2f  (기준선 미측정)" % (nm2, mix))
            continue
        seq = (A + other) / 2.0
        best = max(A, other) / 2.0
        hide = 0.0 if seq == best else 100.0 * (seq - mix) / (seq - best)
        print("    %-6s 순차예상 %8.2f  완전은닉 %8.2f  실측 %8.2f  ->  은닉률 %6.1f%%"
              % (nm2, seq, best, mix, hide))
    print("EXPBV_JSON " + json.dumps({"null": v[0], "umaal": A, "vmul": Bv, "vadd": C,
                                      "mix_vmul": D, "mix_vadd": E, "mix_vldrw": F},
                                     sort_keys=True))
    print()
    # ---- expBU (E0 draft-10) ----
    print()
    print("=== expBU (E0) — X-Wing draft-10 준거 대표값 ===")
    print("  정확성 smoke=%s reject-fail=%s ekchk-fail=%s coldwarm-mm=%s"
          % (_kvp(log, "expBU d10:", "smoke="), _kvp(log, "expBU d10:", "reject-fail="),
             _kvp(log, "expBU d10:", "ekchk-fail="), _kvp(log, "expBU d10:", "coldwarm-mm=")))
    nm = ["keygen", "encaps", "decaps-warm", "decaps-cold"]
    d10 = {}
    for k in range(4):
        vs = [_med(reps, 108 + 4 * i + k) for i in range(3)]
        d10[nm[k]] = {"passes": vs, "rep": min(vs)}
        print("    %-12s %10d %10d %10d   ->  대표 %10d" % (nm[k], vs[0], vs[1], vs[2], min(vs)))
    print("EXPBU_JSON " + json.dumps({"draft10": d10}, sort_keys=True, ensure_ascii=False))
    print()
    # ---- expBS (K21 x4) ----
    print()
    print("=== expBS (K21) — matrix-XOF x4 배칭 ===")
    print("  정확성 xw bytes-mm=%s smoke=%s reject-mm=%s"
          % (_kvp(log, "expBS xw:", "bytes-mm="), _kvp(log, "expBS xw:", "smoke="),
             _kvp(log, "expBS xw:", "reject-mm=")))
    bs = {}
    ok = 0
    for oi, op in enumerate(OPS):
        A1 = _med(reps, 96 + oi); B1 = _med(reps, 99 + oi)
        B2 = _med(reps, 102 + oi); A2 = _med(reps, 105 + oi)
        pv = min(100.0 * (A1 - B1) / A1, 100.0 * (A2 - B2) / A2)
        bs[op] = {"A": (A1 + A2) / 2.0, "B": (B1 + B2) / 2.0, "saving_pct": pv}
        if pv >= 0.50:
            ok += 1
        print("    %-7s %10.0f -> %10.0f   %+7.3f%%" % (op, bs[op]["A"], bs[op]["B"], pv))
    s1 = all(bs[o]["saving_pct"] >= 0.0 for o in OPS)
    print("  BS-1 회귀 없음          = %s" % ("PASS" if s1 else "FAIL"))
    print("  BS-2 두 연산 이상 >=0.50%% = %s (%d/3)" % ("PASS" if ok >= 2 else "FAIL", ok))
    print("  => %s" % ("ADOPT" if (s1 and ok >= 2) else "종료"))
    print("EXPBS_JSON " + json.dumps({"full": bs, "bs1": s1, "bs2": ok >= 2,
                                      "adopt": bool(s1 and ok >= 2)}, sort_keys=True))
    print()
    # ---- expBO (ladder glue 분모) ----
    B64o = 64.0
    nm = ["fe25519_add", "fe25519_sub", "fe25519_mul(대조)", "fe25519_sqr(대조)"]
    print()
    print("=== expBO — ladder glue 단가 (DTCM 버퍼, BATCH=64) ===")
    vals = []
    for k in range(4):
        v = _med(reps, 92 + k) / B64o
        vals.append(v)
        print("    %-20s %8.2f cyc/호출" % (nm[k], v))
    print("    add+sub 합 %.2f  (encaps 호출 5,122회 -> 파생 %0.0f cyc = %.2f%% of 977,896)"
          % (vals[0] + vals[1], 2561.0 * (vals[0] + vals[1]),
             100.0 * 2561.0 * (vals[0] + vals[1]) / 977896.0))
    print("EXPBO_JSON " + json.dumps({"add": vals[0], "sub": vals[1],
                                      "mul": vals[2], "sqr": vals[3]}, sort_keys=True))
    print()
    # ---- expBN (X01 통합) ----
    print()
    print("=== expBN — fe25519_mul_sched full X-Wing 통합 ===")
    print("  정확성 xw bytes-mm=%s smoke=%s reject-mm=%s"
          % (_kvp(log, "expBN xw:", "bytes-mm="), _kvp(log, "expBN xw:", "smoke="),
             _kvp(log, "expBN xw:", "reject-mm=")))
    bn = {}
    for oi, op in enumerate(OPS):
        A1 = _med(reps, 80 + oi); B1 = _med(reps, 83 + oi)
        B2 = _med(reps, 86 + oi); A2 = _med(reps, 89 + oi)
        pv = min(100.0 * (A1 - B1) / A1, 100.0 * (A2 - B2) / A2)
        bn[op] = {"A": (A1 + A2) / 2.0, "B": (B1 + B2) / 2.0, "saving_pct": pv}
        print("    %-7s %10.0f -> %10.0f   %+7.3f%%" % (op, bn[op]["A"], bn[op]["B"], pv))
    n1 = all(bn[o]["saving_pct"] >= 0.0 for o in OPS)
    n2 = bn["encaps"]["saving_pct"] >= 0.80
    n3 = bn["decaps"]["saving_pct"] >= 0.50
    print("  BN-1 회귀 없음            = %s" % ("PASS" if n1 else "FAIL"))
    print("  BN-2 encaps >= 0.80%%      = %s" % ("PASS" if n2 else "FAIL"))
    print("  BN-3 decaps >= 0.50%%      = %s" % ("PASS" if n3 else "FAIL"))
    print("  => %s" % ("ADOPT" if (n1 and n2 and n3) else "종료"))
    print("EXPBN_JSON " + json.dumps({"full": bn, "bn1": n1, "bn2": n2, "bn3": n3,
                                      "adopt": bool(n1 and n2 and n3)}, sort_keys=True))
    print()
    # ---- expBM (X01-v2) ----
    B64m = 64.0
    ma1 = _med(reps, 72) / B64m
    mb1 = _med(reps, 73) / B64m
    mb2 = _med(reps, 74) / B64m
    ma2 = _med(reps, 75) / B64m
    sa1 = _med(reps, 76) / B64m
    sb1 = _med(reps, 77) / B64m
    sb2 = _med(reps, 78) / B64m
    sa2 = _med(reps, 79) / B64m
    pA = min(100.0 * (ma1 - mb1) / ma1, 100.0 * (ma2 - mb2) / ma2)
    pB = min(100.0 * (sa1 - sb1) / sa1, 100.0 * (sa2 - sb2) / sa2)
    print()
    print("=== expBM (X01-v2) — fe25519_mul 프레임 평탄화 ===")
    print("  정확성 flat-mm=%s sched-mm=%s checks=%s"
          % (_kvp(log, "expBM flat-mm=", "flat-mm="),
             _kvp(log, "expBM flat-mm=", "sched-mm="),
             _kvp(log, "expBM flat-mm=", "checks=")))
    print("  BM-A  원본 %8.2f -> 평탄화 %8.2f   차 %+7.2f%%   (중립 기준 -1.0~+3.0%%) %s"
          % ((ma1 + ma2) / 2.0, (mb1 + mb2) / 2.0, pA,
             "PASS" if -1.0 <= pA <= 3.0 else "FAIL"))
    print("  BM-B  평탄화 %8.2f -> 재스케줄 %8.2f   절감 %+7.2f%%   BM-B1(>=8.0%%) %s"
          % ((sa1 + sa2) / 2.0, (sb1 + sb2) / 2.0, pB,
             "PASS" if pB >= 8.0 else "FAIL"))
    print("  (모델: 평탄화 블록 baseline 145.0 -> 재정렬 133.0)")
    print("EXPBM_JSON " + json.dumps({"orig": (ma1 + ma2) / 2.0,
                                      "flat": (mb1 + mb2) / 2.0,
                                      "sched": (sb1 + sb2) / 2.0,
                                      "bmA_delta_pct": pA, "bmB_saving_pct": pB},
                                     sort_keys=True))
    print()
    # ---- expBL (shifted-operand ALU 발행 규칙) ----
    B64 = 64.0
    NI = 128.0
    names = ["A plain_indep  eor rD,rN,rM          독립4",
             "B plain_dep    eor rD,rD,rM          의존",
             "C shift_indep  eor rD,rN,rM,LSR#8    독립4",
             "D shift_dep    eor rD,rD,rM,LSR#8    의존",
             "E mix_indep    shifted/평 교대       독립4",
             "F andimm_indep and rD,rN,#imm        독립4",
             "G bfi_indep    bfi rD,rN,#16,#16     독립4",
             "H fbi_chain    fromBitInterleaving 4단 블록"]
    nul = _med(reps, 63) / B64
    print()
    print("=== expBL — shifted-operand ALU 발행 규칙 (128 명령/커널, null 차분) ===")
    print("    null(빈 호출) %.2f cyc" % nul)
    bl = {}
    for k in range(8):
        tot = _med(reps, 64 + k) / B64
        per = (tot - nul) / NI
        bl[names[k].split()[0]] = {"total": tot, "per_instr": per}
        print("    %-44s %8.2f  ->  %5.3f cyc/명령" % (names[k], tot, per))
    print("EXPBL_JSON " + json.dumps({"null": nul, "kernels": bl}, sort_keys=True,
                                     ensure_ascii=False))
    print()
    # ---- expBK (K32) ----
    B16k = 16.0
    ka1 = _med(reps, 47) / B16k
    kb1 = _med(reps, 48) / B16k
    kb2 = _med(reps, 49) / B16k
    ka2 = _med(reps, 50) / B16k
    kmicro = min(100.0 * (ka1 - kb1) / ka1, 100.0 * (ka2 - kb2) / ka2)
    print()
    print("=== expBK (K32) — StateExtractBytes 교차 배치 ===")
    print("  정확성 extract-mm=%s / checks=%s   xw bytes-mm=%s smoke=%s reject-mm=%s"
          % (_kvp(log, "expBK extract-mm=", "extract-mm="),
             _kvp(log, "expBK extract-mm=", "checks="),
             _kvp(log, "expBK xw:", "bytes-mm="),
             _kvp(log, "expBK xw:", "smoke="),
             _kvp(log, "expBK xw:", "reject-mm=")))
    print("  micro extract(0,168)  A %8.2f -> B %8.2f   절감 %+7.2f%%   BK-1(>=20%%) %s"
          % ((ka1 + ka2) / 2.0, (kb1 + kb2) / 2.0, kmicro,
             "PASS" if kmicro >= 20.0 else "FAIL"))
    bk = {}
    ok3 = 0
    for oi, op in enumerate(OPS):
        A1 = _med(reps, 51 + oi); B1 = _med(reps, 54 + oi)
        B2 = _med(reps, 57 + oi); A2 = _med(reps, 60 + oi)
        pv = min(100.0 * (A1 - B1) / A1, 100.0 * (A2 - B2) / A2)
        bk[op] = {"A": (A1 + A2) / 2.0, "B": (B1 + B2) / 2.0, "saving_pct": pv}
        if pv >= 0.70:
            ok3 += 1
        print("    %-7s %10.0f -> %10.0f   %+7.3f%%" % (op, bk[op]["A"], bk[op]["B"], pv))
    noreg = all(bk[o]["saving_pct"] >= 0.0 for o in OPS)
    print("  BK-2 회귀 없음 = %s" % ("PASS" if noreg else "FAIL"))
    print("  BK-3 두 연산 이상 >=0.70%% = %s (%d/3)" % ("PASS" if ok3 >= 2 else "FAIL", ok3))
    print("EXPBK_JSON " + json.dumps({"micro_saving_pct": kmicro, "full": bk,
                                      "bk1": kmicro >= 20.0, "bk2": noreg,
                                      "bk3": ok3 >= 2}, sort_keys=True))
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
