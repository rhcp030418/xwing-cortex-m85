"""Flash expAM1b, collect the RAM log, and summarize slots 333..361.

Derived from harvest_ra8m1_expAL.py (2026-08-25 patched version, which
carries the non-ASCII path -> ASCII temp copy + sha verification fix).
Only SLOT_N and the analysis below differ.
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
SLOT_N = 362
FIRST_SLOT = 333
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


SLOT_NAMES = {
    333: ("A_indep", "A mul, independent operands (AB order: A first)"),
    334: ("B_indep", "B1 mul, independent operands"),
    335: ("B_indep", "B1 mul, independent operands (BA order)"),
    336: ("A_indep", "A mul, independent operands (BA order: A last)"),
    337: ("A_chain", "A mul, dependent chain"),
    338: ("B_chain", "B1 mul, dependent chain"),
    339: ("B_chain", "B1 mul, dependent chain (BA order)"),
    340: ("A_chain", "A mul, dependent chain (BA order)"),
}
MICRO = {
    341: ("mac_indep", "vmlaldava.u32 x64, 4 rotating accumulators"),
    342: ("mac_dep", "vmlaldava.u32 x64, single chained accumulator"),
    343: ("vldrw", "vldrw.u32 x64"),
    344: ("vmull", "vmullb.u32 x64"),
    345: ("umaal", "scalar umaal x64"),
    346: ("mixed", "vldrw x32 alternating with scalar ldr x32"),
    347: ("empty", "call overhead baseline"),
}


SLOT_B = {
    348: ("A_sqr", "Lenngren fe25519_sqr (AB order: A first)"),
    349: ("B_sqr", "fe25519_sqr_mve"),
    350: ("B_sqr", "fe25519_sqr_mve (BA order)"),
    351: ("A_sqr", "Lenngren fe25519_sqr (BA order: A last)"),
    352: ("opt_mul_indep", "fe25519_mul_mve_opt, independent operands"),
    353: ("opt_mul_chain", "fe25519_mul_mve_opt, dependent chain"),
    354: ("B_mul_aa", "fe25519_mul_mve(a,a) = unoptimized MVE squaring"),
    355: ("conv_8to10", "fe_8x32_to_1025 (C)"),
    356: ("conv_10to8", "fe_1025_to_8x32 (C)"),
    360: ("null_A", "A-style wrapper + empty stub (loop+wrapper baseline)"),
    361: ("null_B", "B-style AAPCS empty fn (loop+call baseline)"),
}
MICRO_B = {
    357: ("mac_u16", 64, "vmlaldava.u16 x64 (8 lane)"),
    358: ("vpush_d8d15", 32, "vpush{d8-d15}+vpop x32 pairs"),
    359: ("pushpop_r4r11", 32, "push{r4-r11}+pop x32 pairs"),
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

    calib = median(reps[2 * REP_N : 3 * REP_N])
    raw = {}
    for slot in list(SLOT_NAMES) + list(MICRO) + list(SLOT_B) + list(MICRO_B):
        values = reps[slot * REP_N : (slot + 1) * REP_N]
        raw[slot] = {
            "median": median(values),
            "min": min(values),
            "max": max(values),
        }

    per = {}
    for slot in SLOT_NAMES:
        per[slot] = (raw[slot]["median"] - calib) / BATCH
        name = SLOT_NAMES[slot][0]
        print(
            "[N=%d] expAM slot%d %s: median=%d (calib %d 차감시 %d) -> %.2f cyc/mul  min=%d max=%d"
            % (REP_N, slot, name, raw[slot]["median"], calib,
               raw[slot]["median"] - calib, per[slot],
               raw[slot]["min"], raw[slot]["max"])
        )

    empty_med = raw[347]["median"]
    micro = {}
    for slot in MICRO:
        name, desc = MICRO[slot]
        if slot == 347:
            micro[name] = float(raw[slot]["median"] - calib)
            print("[N=%d] expAM slot%d %s: median=%d (calib 차감 %d cyc, 호출 오버헤드)"
                  % (REP_N, slot, name, raw[slot]["median"], raw[slot]["median"] - calib))
            continue
        micro[name] = (raw[slot]["median"] - empty_med) / 64.0
        print("[N=%d] expAM slot%d %s: median=%d -> %.3f cyc/instr   (%s)"
              % (REP_N, slot, name, raw[slot]["median"], micro[name], desc))

    def saving(a_slot, b_slot):
        a, b = per[a_slot], per[b_slot]
        return (a - b) / a * 100.0 if a else 0.0

    indep_a = saving(333, 334)
    indep_b = saving(336, 335)
    chain_a = saving(337, 338)
    chain_b = saving(340, 339)
    indep_min = min(indep_a, indep_b)
    chain_min = min(chain_a, chain_b)

    print("")
    print("독립 피연산자: A=%.2f/%.2f  B1=%.2f/%.2f cyc/mul  절감 a=%+.2f%% b=%+.2f%% -> min %+.2f%%"
          % (per[333], per[336], per[334], per[335], indep_a, indep_b, indep_min))
    print("의존 체인    : A=%.2f/%.2f  B1=%.2f/%.2f cyc/mul  절감 a=%+.2f%% b=%+.2f%% -> min %+.2f%%"
          % (per[337], per[340], per[338], per[339], chain_a, chain_b, chain_min))

    floor_prereg = 33 * micro["mac_dep"] + 50 * micro["vldrw"] + 135.0
    floor_actual = 33 * micro["mac_dep"] + 79 * micro["vldrw"] + 170.0
    a_ref = min(per[337], per[340])
    print("")
    print("FLOOR_B1 (사전등록식 33*mac_dep + 50*vldrw + 135) = %.1f cyc" % floor_prereg)
    print("FLOOR_B1 (실제 명령 구성 33*mac_dep + 79*vldrw + 170) = %.1f cyc" % floor_actual)
    print("0.85 x A(의존 체인) = %.1f cyc" % (0.85 * a_ref))
    print("조기 종료 조건(FLOOR > 0.85*A) 충족: %s"
          % ("예" if floor_prereg > 0.85 * a_ref else "아니오"))

    # ---------------- expAM1b ----------------
    perb = {}
    for slot in SLOT_B:
        perb[slot] = (raw[slot]["median"] - calib) / BATCH
        print("[N=%d] expAMb slot%d %s: median=%d (calib %d 차감시 %d) -> %.2f cyc/op  min=%d max=%d"
              % (REP_N, slot, SLOT_B[slot][0], raw[slot]["median"], calib,
                 raw[slot]["median"] - calib, perb[slot], raw[slot]["min"], raw[slot]["max"]))
    microb = {}
    for slot in MICRO_B:
        name, n, desc = MICRO_B[slot]
        microb[name] = (raw[slot]["median"] - empty_med) / float(n)
        print("[N=%d] expAMb slot%d %s: median=%d -> %.3f cyc/unit   (%s)"
              % (REP_N, slot, name, raw[slot]["median"], microb[name], desc))

    def sav(a_slot, b_slot):
        a, b = perb[a_slot], perb[b_slot]
        return (a - b) / a * 100.0 if a else 0.0

    sqr_a = sav(348, 349)
    sqr_b = sav(351, 350)
    sqr_min = min(sqr_a, sqr_b)
    a_sqr = min(perb[348], perb[351])
    b_sqr = min(perb[349], perb[350])
    print("")
    print("sqr : A=%.2f/%.2f  B=%.2f/%.2f cyc/op  절감 a=%+.2f%% b=%+.2f%% -> min %+.2f%%"
          % (perb[348], perb[351], perb[349], perb[350], sqr_a, sqr_b, sqr_min))
    print("최적화 mul: opt indep=%.2f (원본 %.2f, %+.2f cyc)  opt chain=%.2f (원본 %.2f, %+.2f cyc)"
          % (perb[352], per[334], per[334] - perb[352],
             perb[353], per[338], per[338] - perb[353]))
    print("opt 대 A: indep %+.2f%%   chain %+.2f%%"
          % ((per[333] - perb[352]) / per[333] * 100.0,
             (per[337] - perb[353]) / per[337] * 100.0))
    print("MVE 비최적 제곱 mul(a,a)=%.2f  vs 전용 sqr=%.2f cyc/op (전용 커널 이득 %+.2f cyc)"
          % (perb[354], b_sqr, perb[354] - b_sqr))
    print("표현 변환: 8x32->10x25.5 = %.2f cyc,  10x25.5->8x32 = %.2f cyc,  왕복 = %.2f cyc"
          % (perb[355], perb[356], perb[355] + perb[356]))
    print("ABI 세금: vpush{d8-d15}+vpop = %.2f cyc/쌍,  push{r4-r11}+pop = %.2f cyc/쌍"
          % (microb["vpush_d8d15"], microb["pushpop_r4r11"]))
    print("vmlaldava.u16 (8 lane) = %.3f cyc/instr  vs .u32 (4 lane) = %.3f"
          % (microb["mac_u16"], micro["mac_dep"]))

    # X25519 기준 slot 1 (기존 하네스, N=100)
    s1 = reps[1 * REP_N : 2 * REP_N]
    s1_med = median(s1)
    print("")
    print("[N=%d] slot1 x25519-scalarmult: median=%d (calib 차감 %d) min=%d max=%d"
          % (REP_N, s1_med, s1_med - calib, min(s1), max(s1)))

    # mul/sqr 비중 실측화: 래더 255*(5M+4S) + 인버전(12M, 4S, sqr_many 254S)
    n_mul = 255 * 5 + 12
    n_sqr = 255 * 4 + 4 + 250
    ovh_a = perb[360]
    ovh_b = perb[361]
    print("")
    print("오버헤드 기준선: A식 래퍼+루프 = %.2f cyc/호출,  B식 AAPCS 호출+루프 = %.2f cyc/호출"
          % (ovh_a, ovh_b))
    a_mul_net = min(per[333], per[336]) - ovh_a
    a_sqr_net = a_sqr - ovh_a
    b_mul_net = min(per[334], per[335]) - ovh_b
    b_sqr_net = b_sqr - ovh_b
    print("오버헤드 차감 순수 본문: A mul=%.2f  A sqr=%.2f  B mul=%.2f  B sqr=%.2f cyc"
          % (a_mul_net, a_sqr_net, b_mul_net, b_sqr_net))
    print("순수 본문 기준 절감: mul %+.2f%%   sqr %+.2f%%"
          % ((a_mul_net - b_mul_net) / a_mul_net * 100.0,
             (a_sqr_net - b_sqr_net) / a_sqr_net * 100.0))
    share_mul = n_mul * a_mul_net / float(s1_med - calib) * 100.0
    share_sqr = n_sqr * a_sqr_net / float(s1_med - calib) * 100.0
    print("mul/sqr 비중(오버헤드 차감 단가 x 정적 호출수 %d/%d / slot1): mul %.1f%% + sqr %.1f%% = %.1f%%"
          % (n_mul, n_sqr, share_mul, share_sqr, share_mul + share_sqr))

    correctness_b = _parse_kv(log, "expAMb correctness:")
    mmb = sum(correctness_b.get(k, 9999)
              for k in ("opt-mm", "sqr-mm", "sqrlenn-mm", "conv-mm", "sem-mm"))

    correctness = _parse_kv(log, "expAM correctness:")
    ct_delta = None
    for line in log.splitlines():
        if line.startswith("expAM ct-delta:"):
            try:
                ct_delta = int(line.split()[2])
            except (IndexError, ValueError):
                pass

    mm_total = sum(
        correctness.get(k, 9999)
        for k in ("oracle-mm", "lenn-mm", "boundary-mm", "alias-mm", "align-mm")
    )
    kat_pass = "KAT ALL PASS" in log
    correctness_pass = (mm_total == 0) and (fails == 0) and kat_pass

    if chain_min >= 15.0:
        verdict = "PASS"
    elif chain_min >= 5.0:
        verdict = "HOLD"
    else:
        verdict = "FAIL"
    if not correctness_pass:
        verdict = "FAIL(correctness)"

    return {
        "calib": calib,
        "raw": dict((str(k), v) for k, v in raw.items()),
        "per_mul": dict((str(k), per[k]) for k in per),
        "micro_cyc_per_instr": micro,
        "saving_indep_pct": {"a": indep_a, "b": indep_b, "min": indep_min},
        "saving_chain_pct": {"a": chain_a, "b": chain_b, "min": chain_min},
        "floor_prereg": floor_prereg,
        "floor_actual": floor_actual,
        "a_chain_ref": a_ref,
        "correctness": correctness,
        "ct_delta": ct_delta,
        "harness_fails": fails,
        "kat_all_pass": kat_pass,
        "correctness_pass": correctness_pass,
        "verdict": verdict,
        "elf_sha256": sha256(elf),
        "srec_sha256": sha256(srec),
        "readback_sha256": readback_hash,
        "readback_bytes": readback_bytes,
        "per_op_b": dict((str(k), perb[k]) for k in perb),
        "micro_b": microb,
        "saving_sqr_pct": {"a": sqr_a, "b": sqr_b, "min": sqr_min},
        "conv_cyc": {"to1025": perb[355], "to8x32": perb[356],
                     "roundtrip": perb[355] + perb[356]},
        "slot1_x25519": s1_med - calib,
        "overhead_A": ovh_a,
        "overhead_B": ovh_b,
        "net_A_mul": a_mul_net,
        "net_A_sqr": a_sqr_net,
        "net_B_mul": b_mul_net,
        "net_B_sqr": b_sqr_net,
        "share_mul_pct": share_mul,
        "share_sqr_pct": share_sqr,
        "correctness_b": correctness_b,
        "correctness_b_pass": (mmb == 0),
        "gate_pass": correctness_pass and (mmb == 0),
    }


def print_effects(payload: dict) -> None:
    print("")
    print("=== expAM1 판정 ===")
    print("정확성: %s (harness_fails=%s, KAT=%s, %s)"
          % ("PASS" if payload["correctness_pass"] else "FAIL",
             payload["harness_fails"], payload["kat_all_pass"], payload["correctness"]))
    print("상수시간 ct-delta: %s cyc (배치 %d회 기준)" % (payload["ct_delta"], BATCH))
    print("성능 판정(의존 체인 min): %+.2f%% -> %s"
          % (payload["saving_chain_pct"]["min"], payload["verdict"]))
    print("kill gate: >=15%% PASS / 5~15%% HOLD / <5%% FAIL")


def self_test() -> None:
    assert SLOT_N == 362
    assert set(SLOT_NAMES) | set(MICRO) | set(SLOT_B) | set(MICRO_B) == set(range(333, 362))
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
        args.attach, args.elf, args.srec
    )
    print(log)
    payload = summarize(log, fails, reps, args.elf, args.srec, readback_hash, readback_bytes)
    print_effects(payload)
    print("EXPAM1B_JSON " + json.dumps(payload, ensure_ascii=False, sort_keys=True))
    return 0 if payload["gate_pass"] else 2


if __name__ == "__main__":
    raise SystemExit(main())
