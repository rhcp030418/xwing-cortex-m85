# 보드 RAM 무결성 테스트 — SRAM(0x22000000, 384K) + DTCM(0x20000000, 64K)
# 패턴 2종(0xAA55.., 0x55AA..)을 32KB 청크로 쓰고 읽어 불일치 주소를 보고.
# 목적: J-Link RAMCode(플래시 로더 스텁)가 올라가는 RAM에 고착 셀이 있는지 판별.
import pylink

DLL = r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll"
REGIONS = [("DTCM", 0x20000000, 0x10000), ("SRAM", 0x22000000, 0x60000)]
CHUNK = 0x8000

jl = pylink.JLink(lib=pylink.Library(dllpath=DLL))
jl.open()
jl.set_tif(pylink.enums.JLinkInterfaces.SWD)
jl.connect("R7FA8M1AH", speed=4000)
jl.halt()

total_bad = 0
for name, base, size in REGIONS:
    bad = []
    for pat_byte in (0xA5, 0x5A):
        pattern = bytes([pat_byte] * CHUNK)
        for off in range(0, size, CHUNK):
            jl.memory_write8(base + off, list(pattern))
            got = bytes(jl.memory_read8(base + off, CHUNK))
            if got != pattern:
                bad += [hex(base + off + i) for i in range(CHUNK) if got[i] != pat_byte][:8]
    if bad:
        print(f"{name}: BAD cells at {bad[:16]}{' ...' if len(bad) > 16 else ''}")
        total_bad += len(bad)
    else:
        print(f"{name}: OK ({size // 1024}KB x 2 patterns)")

print("RESULT:", "RAM DEFECTS FOUND" if total_bad else "ALL RAM OK")
jl.close()
