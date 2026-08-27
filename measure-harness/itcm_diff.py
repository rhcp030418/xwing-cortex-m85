# ITCM 내용 vs 플래시 LMA(0x02000040) 원본 대조 — 복사 손상 vs 플래시 손상 판별
import pylink

DLL = r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll"
LMA = 0x02000040
SIZE = 0x27A0

jl = pylink.JLink(lib=pylink.Library(dllpath=DLL))
jl.open()
jl.set_tif(pylink.enums.JLinkInterfaces.SWD)
jl.connect("R7FA8M1AH", speed=4000)
jl.halt()

flash = bytes(jl.memory_read8(LMA, SIZE))
itcm = bytes(jl.memory_read8(0x0, SIZE))

diffs = [i for i in range(SIZE) if flash[i] != itcm[i]]
print(f"diff bytes: {len(diffs)} / {SIZE}")
if diffs:
    first, last = diffs[0], diffs[-1]
    print(f"first diff @ {hex(first)}, last @ {hex(last)}")
    print("flash:", flash[first:first + 16].hex())
    print("itcm :", itcm[first:first + 16].hex())
    # 연속 구간인지 요약
    runs = []
    start = prev = diffs[0]
    for d in diffs[1:]:
        if d != prev + 1:
            runs.append((start, prev))
            start = d
        prev = d
    runs.append((start, prev))
    print(f"runs: {len(runs)}", [(hex(a), hex(b)) for a, b in runs[:10]])

jl.restart()
jl.close()
