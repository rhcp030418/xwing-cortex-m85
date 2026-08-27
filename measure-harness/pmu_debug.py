# PMU 이벤트 카운터 디버깅 (EK-RA8M1)
#
# 증상: PMU CCNTR·DWT CYCCNT는 도는데 이벤트 카운터(EVCNTR)만 전부 0.
# 가설: Armv8.1-M에서 이벤트 카운터는 비침습 디버그 허가(NIDEN/SPNIDEN) 게이트를
#       받는다. DAUTHCTRL 쓰기는 무시됨(RAZ/WI) → 칩 쪽 제어 레지스터를 찾는 중.
# 이 스크립트: R_SYSTEM.SYOCDCR.DBGEN(0x4001EA38 bit7)을 PRCR 언락 후 세트하고
#              CPU_CYCLES(0x11) 이벤트로 카운팅 재시험.
#
# 사용법: py pmu_debug.py  (e2 studio 디버그 세션은 닫은 상태)

import time

import pylink

DLL = r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll"

PMU_EVCNTR = 0xE0003000
PMU_EVTYPER = 0xE0003400
PMU_CNTENSET = 0xE0003C00
PMU_CNTENCLR = 0xE0003C04
PMU_CTRL = 0xE0003E04
PRCR = 0x4001E3FE       # 레지스터 쓰기 보호 (key 0xA5, PRC0~3)
SYOCDCR = 0x4001EA38    # System Control OCD Control (bit7 = DBGEN)


def pmu_test(jl, label):
    jl.halt()
    jl.memory_write32(PMU_EVTYPER, [0x11, 0x08])   # c0=CPU_CYCLES, c1=INST_RETIRED
    jl.memory_write32(PMU_CNTENCLR, [0xFFFFFFFF])
    jl.memory_write32(PMU_CTRL, [0x7])             # ENABLE + 카운터 리셋
    jl.memory_write32(PMU_CNTENSET, [0x80000003])
    jl.restart()
    time.sleep(0.3)
    jl.halt()
    c0, c1 = jl.memory_read32(PMU_EVCNTR, 2)
    print(f"{label}: EVCNTR0(cpu_cycles)={c0}  EVCNTR1(inst_retired)={c1}")
    return c0


def main():
    jl = pylink.JLink(lib=pylink.Library(dllpath=DLL))
    jl.open()
    jl.set_tif(pylink.enums.JLinkInterfaces.SWD)
    jl.connect("R7FA8M1AH", speed=4000)

    # SYOCDCR.DBGEN은 이미 0x80으로 확인됨(2026-08-16) → 원인 아님.
    # 인증 상태 확인: 비침습(non-invasive) 디버그가 어느 상태로 보이는지
    print("SYOCDCR        =", hex(jl.memory_read8(SYOCDCR, 1)[0]))
    print("DAUTHSTATUS    =", hex(jl.memory_read32(0xE000EFB8, 1)[0]))  # SID/SNID/NSID/NSNID
    print("PMU_AUTHSTATUS =", hex(jl.memory_read32(0xE0003FB8, 1)[0]))

    pmu_test(jl, "baseline")
    jl.restart()
    jl.close()


if __name__ == "__main__":
    main()
