# ① 폴트 시점의 log_buf 확인(하네스 복원 코드가 돌았는지)
# ② 디버거로 0x18/0xE0 수동 복원 → 시간 경과 후 재오염 여부 확인
import subprocess
import time

import pylink

DLL = r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll"
NM = r"C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\toolchains\gcc_arm\13.2.rel1\bin\arm-none-eabi-nm.exe"
ELF = r"C:\Users\cnscj\e2_studio\workspace\blinky\Debug\blinky.elf"
LMA = 0x02000040

a = {}
for line in subprocess.check_output([NM, ELF], text=True).splitlines():
    p = line.split()
    if len(p) == 3 and p[2] in ("log_len", "log_buf", "harness_done"):
        a[p[2]] = int(p[0], 16)

jl = pylink.JLink(lib=pylink.Library(dllpath=DLL))
jl.open()
jl.set_tif(pylink.enums.JLinkInterfaces.SWD)
jl.connect("R7FA8M1AH", speed=4000)
jl.halt()

n = min(jl.memory_read32(a["log_len"], 1)[0], 500)
print("log_len =", n)
if n:
    print(bytes(jl.memory_read8(a["log_buf"], n)).decode("utf-8", "replace"))

for off in (0x18, 0xE0):
    good = jl.memory_read8(LMA + off, 8)
    jl.memory_write8(off, good)
print("restored. @0x18:", bytes(jl.memory_read8(0x18, 8)).hex(),
      "@0xE0:", bytes(jl.memory_read8(0xE0, 8)).hex())
time.sleep(1.0)
print("1s later. @0x18:", bytes(jl.memory_read8(0x18, 8)).hex(),
      "@0xE0:", bytes(jl.memory_read8(0xE0, 8)).hex())
jl.close()
