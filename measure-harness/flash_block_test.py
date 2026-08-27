# 플래시 블록 판별: 0x02006000(대조군) vs 0x02008000(용의 블록)에 동일 256B 굽기
# → 0x02008000만 실패하면 불량 블록/로더 이슈 확정
import os
import struct

import pylink

DLL = r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll"


def make_srec(path, addr, data):
    def rec(rtype, address, payload):
        body = struct.pack(">I", address) + payload
        count = len(body) + 1
        cksum = (~(count + sum(body)) & 0xFF)
        return f"S{rtype}{count:02X}" + body.hex().upper() + f"{cksum:02X}"

    lines = ["S00600004844521B"]  # header
    for off in range(0, len(data), 32):
        lines.append(rec(3, addr + off, data[off:off + 32]))
    lines.append("S70500000000FA")
    with open(path, "w") as f:
        f.write("\n".join(lines) + "\n")


def tryflash(path, label):
    jl = pylink.JLink(lib=pylink.Library(dllpath=DLL))
    jl.open()
    jl.set_tif(pylink.enums.JLinkInterfaces.SWD)
    jl.connect("R7FA8M1AH", speed=4000)
    jl.reset(ms=10, halt=True)
    try:
        jl.flash_file(path, 0x0)
        got = bytes(jl.memory_read8(int(label, 16), 16))
        print(f"{label}: FLASH OK, readback {got.hex()}")
    except Exception as e:
        print(f"{label}: FAIL — {e}")
    jl.close()


data = bytes([0xAB] * 256)
for addr in (0x02006000, 0x02008000, 0x0200A000):
    p = os.environ["TEMP"] + f"\\blk_{addr:08x}.srec"
    make_srec(p, addr, data)
    tryflash(p, hex(addr))
