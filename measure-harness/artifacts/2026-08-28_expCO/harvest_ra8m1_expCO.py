# expCO 회수: keygen/encaps/decaps in-context checkpoint (융합/잔여/총) + IRQ 마스킹 대조.
# 사전등록: 2026-08-28_expCO_incontext_checkpoint_prereg.md
#
#   py harvest_ra8m1_expCO.py            # 플래시 → 실행 → 로그·슬롯 회수
#   py harvest_ra8m1_expCO.py --attach   # 이미 돌고 있는 보드에서 회수만
#
# 슬롯 775..831, 셀당 (총, 융합, 잔여). REP_N=100 중앙값과 IQR을 함께 출력한다.

import subprocess
import sys
import time

import pylink

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

WS = r"C:\Users\cnscj\e2_studio\workspace\blinky\Debug"
ELF = WS + r"\blinky.elf"
SREC = WS + r"\blinky.srec"
NM = r"C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\toolchains\gcc_arm\13.2.rel1\bin\arm-none-eabi-nm.exe"
DLL = r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll"
DEVICE = "R7FA8M1AH"

SYMS = ("harness_done", "harness_fails", "log_len", "log_buf", "rep_cyc")
REP_N = 100
SLOT_N = 832
BASE = 775

# (라벨, 슬롯) — prereg §3 배치와 1:1
CELLS = [
    ("keygen F  a", BASE + 0), ("keygen U  b", BASE + 3),
    ("keygen U  b", BASE + 6), ("keygen F  a", BASE + 9),
    ("decaps F  a", BASE + 12), ("decaps U  b", BASE + 15),
    ("decaps U  b", BASE + 18), ("decaps F  a", BASE + 21),
    ("encaps F  a", BASE + 24), ("encaps U  b", BASE + 27),
    ("encaps U  b", BASE + 30), ("encaps F  a", BASE + 33),
    ("encaps F  a", BASE + 36), ("encaps U1 b", BASE + 39),
    ("encaps U1 b", BASE + 42), ("encaps F  a", BASE + 45),
    ("keygen F  IRQ-masked", BASE + 48),
    ("encaps F  IRQ-masked", BASE + 51),
    ("decaps F  IRQ-masked", BASE + 54),
]

# 같은 ELF의 격리 배치 벤치(expAF). in-context 손실과 나란히 놓아야 배치 효과가
# 상쇄된 채로 "3x 투영이 몇 %를 설명하는가"를 물을 수 있다.
AF_CELLS = [
    ("u4 seq   ab", 229), ("u4 fused ab", 230),
    ("u4 fused ba", 231), ("u4 seq   ba", 232),
    ("u8 seq   ab", 233), ("u8 fused ab", 234),
    ("u8 fused ba", 235), ("u8 seq   ba", 236),
]


def sym_addrs():
    addrs = {}
    for line in subprocess.check_output([NM, ELF], text=True).splitlines():
        parts = line.split()
        if len(parts) == 3 and parts[2] in SYMS:
            addrs[parts[2]] = int(parts[0], 16)
    missing = set(SYMS) - set(addrs)
    if missing:
        sys.exit(f"ELF에 심볼 없음: {missing}")
    return addrs


def stats(vals):
    s = sorted(vals)
    n = len(s)
    return s[n // 2], s[n // 4], s[(3 * n) // 4], s[0], s[-1]


def main():
    attach_only = "--attach" in sys.argv
    a = sym_addrs()
    jlink = pylink.JLink(lib=pylink.Library(dllpath=DLL))
    jlink.open()
    jlink.set_tif(pylink.enums.JLinkInterfaces.SWD)
    jlink.connect(DEVICE, speed=4000)
    print(f"connected: {jlink.core_name()}")

    if not attach_only:
        jlink.reset(halt=True)
        jlink.exec_command("SetSkipProgOnCRCMatch = 0")
        jlink.exec_command("SetVerifyDownload = 0")
        jlink.flash_file(SREC, 0x0)
        jlink.reset(ms=10, halt=False)

    for _ in range(7200):
        time.sleep(0.1)
        if jlink.memory_read32(a["harness_done"], 1)[0] == 1:
            break
    else:
        sys.exit("timeout: harness_done != 1")

    n = min(jlink.memory_read32(a["log_len"], 1)[0], 8191)
    log = bytes(jlink.memory_read8(a["log_buf"], n)).decode("utf-8", "replace")
    fails = jlink.memory_read32(a["harness_fails"], 1)[0]
    # rep_cyc 전체를 한 번에 읽으면 J-Link 전송이 크므로 필요한 뒤쪽만 읽는다.
    off = BASE * REP_N
    tail = jlink.memory_read32(a["rep_cyc"] + off * 4, (SLOT_N - BASE) * REP_N)
    calib_all = jlink.memory_read32(a["rep_cyc"] + 2 * REP_N * 4, REP_N)
    af = jlink.memory_read32(a["rep_cyc"] + 229 * REP_N * 4, 8 * REP_N)
    jlink.close()

    print(log)
    calib = sorted(calib_all)[REP_N // 2]
    print(f"calib(median) = {calib}")
    print(f"harness_fails = {fails}")
    print()
    print(f"{'cell':24s} {'span':8s} {'median':>10s} {'IQR':>8s} {'min':>10s} {'max':>10s}")
    for label, slot in CELLS:
        for k, span in enumerate(("total", "fused", "residual")):
            base = (slot - BASE + k) * REP_N
            vals = tail[base:base + REP_N]
            med, q1, q3, lo, hi = stats(vals)
            # 총·융합은 span 시작부터의 누적이므로 calib을 뺀다. 잔여는 차분이라 상쇄됨.
            adj = calib if span != "residual" else 0
            print(f"{label:24s} {span:8s} {med - adj:10d} {q3 - q1:8d} "
                  f"{lo - adj:10d} {hi - adj:10d}")
    print()
    print("# 같은 ELF의 격리 배치 벤치 (expAF 229..236)")
    print(f"{'cell':24s} {'span':8s} {'median':>10s} {'IQR':>8s} {'min':>10s} {'max':>10s}")
    for label, slot in AF_CELLS:
        vals = af[(slot - 229) * REP_N:(slot - 229 + 1) * REP_N]
        med, q1, q3, lo, hi = stats(vals)
        print(f"{label:24s} {'batch':8s} {med - calib:10d} {q3 - q1:8d} "
              f"{lo - calib:10d} {hi - calib:10d}")
    print()
    print("# 해석은 결과 문서에서. 여기서는 원시 중앙값·IQR만 낸다.")


if __name__ == "__main__":
    main()
