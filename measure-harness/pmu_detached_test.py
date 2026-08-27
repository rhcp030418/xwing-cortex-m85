# 가설 검증: PMU 이벤트 카운터가 "halting debug enable(DHCSR.C_DEBUGEN=1)" 동안
# 동결되는지 확인. 절차:
#   1) 리셋 → C_DEBUGEN 클리어 → J-Link 연결 해제 (하네스가 디버거 없이 실행)
#   2) 2초 뒤 재연결해 log_buf 회수 → 이벤트 카운터가 살아났는지 확인
#
# 사용법: py pmu_detached_test.py

import subprocess
import time

import pylink

DLL = r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll"
NM = r"C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\toolchains\gcc_arm\13.2.rel1\bin\arm-none-eabi-nm.exe"
ELF = r"C:\Users\cnscj\e2_studio\workspace\blinky\Debug\blinky.elf"
DHCSR = 0xE000EDF0


def syms():
    a = {}
    for line in subprocess.check_output([NM, ELF], text=True).splitlines():
        p = line.split()
        if len(p) == 3 and p[2] in ("harness_done", "log_len", "log_buf"):
            a[p[2]] = int(p[0], 16)
    return a


def connect():
    jl = pylink.JLink(lib=pylink.Library(dllpath=DLL))
    jl.open()
    jl.set_tif(pylink.enums.JLinkInterfaces.SWD)
    jl.connect("R7FA8M1AH", speed=4000)
    return jl


def main():
    a = syms()

    jl = connect()
    jl.reset(ms=10, halt=False)                     # 하네스 재실행
    jl.memory_write32(DHCSR, [0xA05F0000])          # C_DEBUGEN=0 (키 필요)
    jl.close()                                      # 디버거 완전 분리

    time.sleep(2)                                   # 디버거 없이 실행 완료 대기

    jl = connect()                                  # 재연결 (C_DEBUGEN 다시 켜짐)
    done = jl.memory_read32(a["harness_done"], 1)[0]
    n = min(jl.memory_read32(a["log_len"], 1)[0], 8191)
    log = bytes(jl.memory_read8(a["log_buf"], n)).decode("utf-8", "replace")
    jl.close()
    print(f"harness_done={done}")
    print(log)


if __name__ == "__main__":
    main()
