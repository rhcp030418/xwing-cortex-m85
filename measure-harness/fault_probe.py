# 하드폴트 진단: PC / 폴트 상태 레지스터 / ITCM 복사 여부 확인
import pylink

DLL = r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll"

import time

jl = pylink.JLink(lib=pylink.Library(dllpath=DLL))
jl.open()
jl.set_tif(pylink.enums.JLinkInterfaces.SWD)
jl.connect("R7FA8M1AH", speed=4000)
# CFSR은 sticky → 클리어하고 리셋해서 깨끗한 폴트를 새로 받는다
jl.halt()
jl.memory_write32(0xE000ED28, [0xFFFFFFFF])
jl.reset(ms=10, halt=False)
time.sleep(1.0)
jl.halt()
print("MPU_CTRL =", hex(jl.memory_read32(0xE000ED94, 1)[0]))
print("SAU_CTRL =", hex(jl.memory_read32(0xE000EDD0, 1)[0]))

print("PC   =", hex(jl.register_read(15)))
print("LR   =", hex(jl.register_read(14)))
print("SP   =", hex(jl.register_read(13)))
print("xPSR =", hex(jl.register_read(16)))
print("HFSR =", hex(jl.memory_read32(0xE000ED2C, 1)[0]))   # HardFault status
print("CFSR =", hex(jl.memory_read32(0xE000ED28, 1)[0]))   # Usage/Bus/MemManage
print("BFAR =", hex(jl.memory_read32(0xE000ED38, 1)[0]))
# ITCM 복사 확인: curve25519_scalarmult@0x406 근처, KeccakF1600@0x1000 근처
print("ITCM@0x400  =", [hex(x) for x in jl.memory_read32(0x400, 4)])
print("ITCM@0x1000 =", [hex(x) for x in jl.memory_read32(0x1000, 4)])
# ITCMCR: ITCM enable 여부 (MEMSYSCTL 0xE001E010 = ITCMCR)
print("ITCMCR =", hex(jl.memory_read32(0xE001E010, 1)[0]))
print("DTCMCR =", hex(jl.memory_read32(0xE001E014, 1)[0]))
# 예외 진입 시 스택 프레임: [R0,R1,R2,R3,R12,LR,PC,xPSR]
sp = jl.register_read(13)
frame = jl.memory_read32(sp, 8)
print("stacked frame:", [hex(x) for x in frame])
print("stacked PC =", hex(frame[6]), " stacked LR =", hex(frame[5]))
# 폴트 지점 명령어 확인
pc = frame[6] & ~1
print(f"code@{hex(pc-4)}:", [hex(x) for x in jl.memory_read16(pc - 4, 6)])
jl.restart()
jl.close()
