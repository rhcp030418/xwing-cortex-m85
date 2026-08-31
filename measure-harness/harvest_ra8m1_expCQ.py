# expCQ: 부팅 간 재현성. 한 번 플래시한 뒤 시스템 리셋 부팅을 N회 반복해
# 같은 ELF·같은 이미지가 부팅마다 얼마나 다른 값을 내는지 잰다.
#
#   py harvest_ra8m1_expCQ.py [--boots N] [--noflash]
#
# 한계: J-Link 리셋은 코어·캐시·분기예측기·FSP 를 초기화하지만 전원은 유지된다.
# 전원 사이클(진짜 cold boot)과 두 번째 보드 개체는 이 스크립트로 못 한다.

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

# 부팅마다 추적할 셀. (라벨, 슬롯) — expCO/expCP 의 핵심 셀만 고른다.
CELLS = [
    ("CO keygen F", 775), ("CO keygen U", 778),
    ("CO decaps F", 787), ("CO decaps U", 790),
    ("CO encaps F", 799), ("CO encaps U", 802),
    ("CP keygen F3", 832), ("CP keygen U3", 835),
    ("CP keygen F5", 844), ("CP keygen U5", 847),
]
SPANS = ("total", "fused", "residual")


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


def wait_done(jlink, a):
    for _ in range(7200):
        time.sleep(0.1)
        if jlink.memory_read32(a["harness_done"], 1)[0] == 1:
            return True
    return False


def main():
    boots = 5
    if "--boots" in sys.argv:
        boots = int(sys.argv[sys.argv.index("--boots") + 1])
    do_flash = "--noflash" not in sys.argv

    a = sym_addrs()
    jlink = pylink.JLink(lib=pylink.Library(dllpath=DLL))
    jlink.open()
    jlink.set_tif(pylink.enums.JLinkInterfaces.SWD)
    jlink.connect(DEVICE, speed=4000)
    print(f"connected: {jlink.core_name()}")

    if do_flash:
        jlink.reset(halt=True)
        jlink.exec_command("SetSkipProgOnCRCMatch = 0")
        jlink.exec_command("SetVerifyDownload = 0")
        jlink.flash_file(SREC, 0x0)
        print("flashed once; 이후 부팅은 리셋만 한다")

    per_boot = []
    for b in range(boots):
        jlink.reset(ms=10, halt=False)
        if not wait_done(jlink, a):
            sys.exit(f"boot {b}: timeout")
        fails = jlink.memory_read32(a["harness_fails"], 1)[0]
        calib = sorted(jlink.memory_read32(a["rep_cyc"] + 2 * REP_N * 4, REP_N))[REP_N // 2]
        row = {"fails": fails, "calib": calib}
        for label, slot in CELLS:
            for k, span in enumerate(SPANS):
                vals = jlink.memory_read32(a["rep_cyc"] + (slot + k) * REP_N * 4, REP_N)
                med = sorted(vals)[REP_N // 2]
                row[(label, span)] = med - (calib if span != "residual" else 0)
        per_boot.append(row)
        print(f"boot {b + 1}/{boots}: harness_fails={fails} calib={calib}")
    jlink.close()

    print()
    print("# 부팅 간 중앙값 분산 (같은 플래시 이미지, 리셋 부팅)")
    print(f"{'cell':14s} {'span':9s} {'min':>10s} {'max':>10s} {'spread':>8s} {'spread%':>9s}")
    for label, slot in CELLS:
        for span in SPANS:
            v = [r[(label, span)] for r in per_boot]
            lo, hi = min(v), max(v)
            print(f"{label:14s} {span:9s} {lo:10d} {hi:10d} {hi - lo:8d} "
                  f"{100.0 * (hi - lo) / lo:8.4f}%")

    print()
    print("# 부팅마다 다시 계산한 U-F 효과 (총 구간)")
    pairs = [("CO keygen", "CO keygen F", "CO keygen U"),
             ("CO decaps", "CO decaps F", "CO decaps U"),
             ("CO encaps", "CO encaps F", "CO encaps U"),
             ("CP 3batch", "CP keygen F3", "CP keygen U3"),
             ("CP 5batch", "CP keygen F5", "CP keygen U5")]
    print(f"{'pair':12s} " + " ".join(f"{'boot' + str(i + 1):>10s}" for i in range(boots))
          + f" {'spread':>8s}")
    for tag, f, u in pairs:
        d = [r[(u, "total")] - r[(f, "total")] for r in per_boot]
        print(f"{tag:12s} " + " ".join(f"{x:10d}" for x in d)
              + f" {max(d) - min(d):8d}")

    print()
    print("# 한계: 전원 사이클이 아니라 시스템 리셋이다. 보드 개체는 1대.")


if __name__ == "__main__":
    main()
