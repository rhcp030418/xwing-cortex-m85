# expCU/CW/CX 회수. 사전등록: 2026-08-28_expCU_CV_CW_CX_prereg.md
#   py harvest_ra8m1_expCUWX.py [--attach]
# CU: 슬롯 870..965 (축 6 x ABBA 4 x 4 op)  CW: 966..973  CX: expcx_samples 심볼

import statistics
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

SYMS = ("harness_done", "harness_fails", "log_len", "log_buf", "rep_cyc",
        "expcx_samples", "expcx_count")
REP_N = 100
CU_BASE, CU_AXES = 870, 6
CW_BASE = 966
CX_N = 3000
AXES = ["xyc8 NTT/store", "c9 pack/CBD/msg", "x06 fixed-base",
        "x01 fe mul", "x02 fe sqr", "k31 memcpy/memset"]
OPS = ["keygen", "encaps", "warm", "cold"]


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


def med(v):
    return sorted(v)[len(v) // 2]


def welch_t(a, b):
    ma, mb = statistics.fmean(a), statistics.fmean(b)
    va, vb = statistics.variance(a), statistics.variance(b)
    return (ma - mb) / ((va / len(a) + vb / len(b)) ** 0.5)


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
    for _ in range(9000):
        time.sleep(0.1)
        if jlink.memory_read32(a["harness_done"], 1)[0] == 1:
            break
    else:
        sys.exit("timeout")

    n = min(jlink.memory_read32(a["log_len"], 1)[0], 8191)
    log = bytes(jlink.memory_read8(a["log_buf"], n)).decode("utf-8", "replace")
    fails = jlink.memory_read32(a["harness_fails"], 1)[0]
    calib = med(jlink.memory_read32(a["rep_cyc"] + 2 * REP_N * 4, REP_N))
    cells = jlink.memory_read32(a["rep_cyc"] + CU_BASE * REP_N * 4,
                                (974 - CU_BASE) * REP_N)
    cj = jlink.memory_read32(a["rep_cyc"] + 570 * REP_N * 4, 16 * REP_N)
    cx = jlink.memory_read32(a["expcx_samples"], 3 * 2 * CX_N)
    cxc = jlink.memory_read32(a["expcx_count"], 6)
    jlink.close()

    print(log)
    print(f"calib={calib} harness_fails={fails}")

    def cell(slot, k):
        base = (slot - CU_BASE + k) * REP_N
        return [x - calib for x in cells[base:base + REP_N]]

    print("\n# expCU leave-one-out: B-i - B (cycle, 양수 = 그 축이 그만큼 줄였다)")
    print(f"{'axis':20s} " + " ".join(f"{o:>9s}" for o in OPS) + "   (B 중앙값 / B-i 중앙값 범위)")
    contrib = {o: [] for o in OPS}
    b_med = {}
    for ax in range(CU_AXES):
        row = []
        for k, o in enumerate(OPS):
            b1 = med(cell(CU_BASE + 16 * ax + 0, k)); l1 = med(cell(CU_BASE + 16 * ax + 4, k))
            l2 = med(cell(CU_BASE + 16 * ax + 8, k)); b2 = med(cell(CU_BASE + 16 * ax + 12, k))
            eff = [l1 - b1, l2 - b1, l1 - b2, l2 - b2]
            row.append((min(eff), max(eff)))
            b_med.setdefault(o, []).extend([b1, b2])
            contrib[o].append(min(eff))   # 보수적: 가장 작은 기여
        print(f"{AXES[ax]:20s} " + " ".join(f"{lo:+9d}" for lo, hi in row)
              + "   폭 " + " ".join(f"{hi-lo:5d}" for lo, hi in row))
    print("\n# 여섯 기여 합 (보수적 min) 과 B 중앙값")
    for o in OPS:
        print(f"  {o:7s} sum(B-i - B) = {sum(contrib[o]):+8d}   B med = {med(b_med[o])}")
    print("\n# 같은 ELF expCJ A/B/B/A (slot 570..585) 로 A-B 와 상호작용")
    for k, o in enumerate(OPS):
        A = [med([x - calib for x in cj[(0 + k) * REP_N:(0 + k + 1) * REP_N]]),
             med([x - calib for x in cj[(12 + k) * REP_N:(12 + k + 1) * REP_N]])]
        B = [med([x - calib for x in cj[(4 + k) * REP_N:(4 + k + 1) * REP_N]]),
             med([x - calib for x in cj[(8 + k) * REP_N:(8 + k + 1) * REP_N]])]
        ab = min(A) - max(B)
        print(f"  {o:7s} A={A} B={B}  A-B(min)={ab:+d}  sum-contrib={sum(contrib[o]):+d}  "
              f"interaction={ab - sum(contrib[o]):+d} ({100*(ab-sum(contrib[o]))/ab:+.1f}% of A-B)")

    print("\n# expCW decaps 8-seed 순환: A/B/B/A (RAM 배치, 절대값은 tab:cumulative 와 섞지 말 것)")
    for k, name in enumerate(("warm", "cold")):
        vals = [med(cell(CW_BASE + 2 * i, k)) for i in range(4)]
        g = [100 * (vals[0] - vals[1]) / vals[0], 100 * (vals[0] - vals[2]) / vals[0],
             100 * (vals[3] - vals[1]) / vals[3], 100 * (vals[3] - vals[2]) / vals[3]]
        print(f"  {name}: A={vals[0]},{vals[3]}  B={vals[1]},{vals[2]}  g=[{min(g):.2f}, {max(g):.2f}]%")

    print("\n# expCX 고정 대 무작위 ct, Welch t (|t|>4.5 = 누설)")
    for t, name in enumerate(("B-warm", "B-cold", "A-warm")):
        c0 = cx[(t * 2 + 0) * CX_N:(t * 2 + 0) * CX_N + CX_N]
        c1 = cx[(t * 2 + 1) * CX_N:(t * 2 + 1) * CX_N + CX_N]
        print(f"  {name}: n0={cxc[t*2]} n1={cxc[t*2+1]}  med0={med(c0)} med1={med(c1)}  "
              f"mean0={statistics.fmean(c0):.1f} mean1={statistics.fmean(c1):.1f}")
        for pct in (100, 90, 75, 50):
            cut0 = sorted(c0)[int(len(c0) * pct / 100) - 1]
            cut1 = sorted(c1)[int(len(c1) * pct / 100) - 1]
            cut = max(cut0, cut1)
            s0 = [x for x in c0 if x <= cut]
            s1 = [x for x in c1 if x <= cut]
            print(f"    crop p{pct:3d}: t={welch_t(s0, s1):+8.3f}  (n={len(s0)},{len(s1)})")


if __name__ == "__main__":
    main()
