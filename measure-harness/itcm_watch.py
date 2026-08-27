# ITCM 0x18/0xE0 오염 범인 추적: 쓰기 워치포인트 걸고 리셋 → 누가 쓰는지 PC 확인
import time

import pylink

DLL = r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll"

jl = pylink.JLink(lib=pylink.Library(dllpath=DLL))
jl.open()
jl.set_tif(pylink.enums.JLinkInterfaces.SWD)
jl.connect("R7FA8M1AH", speed=4000)

jl.reset(ms=10, halt=True)          # 리셋 직후 정지 (아직 오염 전이길 기대)
print("ITCM@0x18 right after reset:", bytes(jl.memory_read8(0x18, 8)).hex())
wp = jl.watchpoint_set(0x18, write=True)
jl.restart()

for _ in range(50):
    time.sleep(0.1)
    if jl.halted():
        break

pc = jl.register_read(15)
lr = jl.register_read(14)
print("halted at PC =", hex(pc), " LR =", hex(lr))
print("ITCM@0x18 now:", bytes(jl.memory_read8(0x18, 8)).hex())
jl.watchpoint_clear_all()
jl.restart()
jl.close()
