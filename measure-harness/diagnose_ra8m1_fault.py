"""Read RA8M1 execution/fault state without resetting or flashing the board."""

import subprocess

import pylink


ELF = r"C:\Users\cnscj\e2_studio\workspace\blinky\Debug\blinky.elf"
NM = r"C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\toolchains\gcc_arm\13.2.rel1\bin\arm-none-eabi-nm.exe"
ADDR2LINE = r"C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\toolchains\gcc_arm\13.2.rel1\bin\arm-none-eabi-addr2line.exe"
DLL = r"C:\Program Files\SEGGER\JLink_V968\JLink_x64.dll"
DEVICE = "R7FA8M1AH"

WATCH = (
    "harness_done",
    "harness_fails",
    "log_len",
    "expw_mismatch",
    "expw_pair_mm",
    "expw_pair_fail",
    "expw_inverse_m85_mismatch",
    "expw_roundtrip_m85_mismatch",
)

SCB_REGS = {
    "SHCSR": 0xE000ED24,
    "CFSR": 0xE000ED28,
    "HFSR": 0xE000ED2C,
    "DFSR": 0xE000ED30,
    "MMFAR": 0xE000ED34,
    "BFAR": 0xE000ED38,
    "AFSR": 0xE000ED3C,
}


def symbol_addresses():
    wanted = set(WATCH)
    found = {}
    output = subprocess.check_output([NM, "-S", ELF], text=True)
    for line in output.splitlines():
        fields = line.split()
        if len(fields) == 4 and fields[3] in wanted:
            found[fields[3]] = (int(fields[0], 16), int(fields[1], 16))
    return found


def source_for(address):
    return subprocess.check_output(
        [ADDR2LINE, "-e", ELF, "-f", "-C", hex(address)], text=True
    ).strip().replace("\n", " | ")


def main():
    jlink = pylink.JLink(lib=pylink.Library(dllpath=DLL))
    jlink.open()
    jlink.set_tif(pylink.enums.JLinkInterfaces.SWD)
    jlink.connect(DEVICE, speed=4000)
    jlink.halt()

    print(f"connected: {jlink.core_name()} halted={jlink.halted()}")
    registers = {}
    for index in jlink.register_list():
        name = jlink.register_name(index)
        if name.lower() in {"r13", "sp", "r14", "lr", "r15", "pc", "xpsr", "msp", "psp", "control"}:
            registers[name] = jlink.register_read(index) & 0xFFFFFFFF
    for index in (13, 14, 15):
        registers[f"index{index}"] = jlink.register_read(index) & 0xFFFFFFFF
    for name, value in registers.items():
        suffix = ""
        if name.lower() in {"r15", "pc"}:
            suffix = "  " + source_for(value & ~1)
        print(f"{name:8s}=0x{value:08x}{suffix}")

    for name, address in SCB_REGS.items():
        value = jlink.memory_read32(address, 1)[0]
        print(f"{name:8s}=0x{value:08x}")

    msp = registers.get("MSP")
    if msp is not None:
        words = jlink.memory_read32(msp, 40)
        print("MSP stack:")
        for offset in range(0, len(words), 4):
            chunk = words[offset:offset + 4]
            print(f"  +0x{offset * 4:02x}: " + " ".join(f"{x:08x}" for x in chunk))
        # The core frame is at the lowest address; stacked PC is word 6.
        # With EXC_RETURN 0xffffffe9, the extended FP/MVE frame follows it.
        stacked_pc = words[6] & ~1
        print(f"stacked PC=0x{stacked_pc:08x}  {source_for(stacked_pc)}")

    for name, (address, size) in symbol_addresses().items():
        count = max(1, min(size // 4, 4))
        values = jlink.memory_read32(address, count)
        rendered = ", ".join(f"0x{x:08x}" for x in values)
        print(f"{name:32s} @0x{address:08x} size={size}: {rendered}")

    jlink.close()


if __name__ == "__main__":
    main()
