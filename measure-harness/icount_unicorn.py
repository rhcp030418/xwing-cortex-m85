# 명령 수(INST_RETIRED 대체) 측정 — Unicorn 에뮬레이션
#
# 배경: 이 보드(EK-RA8M1)의 PMU 이벤트 카운터가 무반응(2026-08-16, 로드맵 변경 이력).
# 두 커널은 상수시간(비밀 무관 제어 흐름)이라 실행 명령 수가 결정적 → 에뮬레이터로
# 정확히 세면 보드의 DWT 사이클과 결합해 IPC·슬롯 낭비율 계산 가능:
#   IPC = insts / cyc,  slot-waste = 1 - insts/(2*cyc)   (M85 듀얼이슈)
#
# 방법: blinky.elf의 ITCM 섹션(두 asm 스트림)을 그대로 0x0에 매핑, DTCM(0x20000000)에
# 데이터·스택을 두고 함수 단위로 호출. UC_HOOK_CODE로 실행 명령을 센다.
# 상수시간 교차검증: 서로 다른 입력 2벌로 돌려 명령 수가 같은지 확인.
#
# 주의: Unicorn은 IT 블록의 각 명령을 개별 카운트. M85 INST_RETIRED와의 정의 차이는
# 리포트에 각주로 명시할 것.
#
# 사용법: py icount_unicorn.py

import subprocess

from unicorn import UC_ARCH_ARM, UC_HOOK_CODE, UC_MODE_THUMB, Uc
from unicorn.arm_const import (UC_ARM_REG_LR, UC_ARM_REG_PC, UC_ARM_REG_R0,
                               UC_ARM_REG_R1, UC_ARM_REG_R2, UC_ARM_REG_SP)

TOOLBIN = r"C:\Renesas\RA\e2studio_v2026-04.2_fsp_v6.5.0\toolchains\gcc_arm\13.2.rel1\bin"
ELF = r"C:\Users\cnscj\e2_studio\workspace\blinky\Debug\blinky.elf"

ITCM_BASE, ITCM_SIZE = 0x00000000, 0x10000
DTCM_BASE, DTCM_SIZE = 0x20000000, 0x10000
STACK_TOP = DTCM_BASE + DTCM_SIZE - 8
RET_SENTINEL = 0x0000FFF0          # ITCM 끝자락의 빈 주소 — 여기 도달하면 함수 리턴


def sym_addrs():
    out = subprocess.check_output([TOOLBIN + r"\arm-none-eabi-nm.exe", ELF], text=True)
    want = ("curve25519_scalarmult", "KeccakF1600_StatePermute")
    return {p[2]: int(p[0], 16) for line in out.splitlines()
            if len(p := line.split()) == 3 and p[2] in want}


def itcm_binary():
    tmp = ELF + ".itcm.bin"
    subprocess.check_call([TOOLBIN + r"\arm-none-eabi-objcopy.exe", "-O", "binary",
                           "--only-section=__itcm_from_flash$$", ELF, tmp])
    with open(tmp, "rb") as f:
        return f.read()


def run(code, entry, regs, label):
    uc = Uc(UC_ARCH_ARM, UC_MODE_THUMB)
    uc.mem_map(ITCM_BASE, ITCM_SIZE)
    uc.mem_map(DTCM_BASE, DTCM_SIZE)
    uc.mem_write(ITCM_BASE, code)
    count = [0]
    uc.hook_add(UC_HOOK_CODE, lambda *_: count.__setitem__(0, count[0] + 1))
    for reg, val in regs.items():
        uc.reg_write(reg, val)
    uc.reg_write(UC_ARM_REG_SP, STACK_TOP)
    uc.reg_write(UC_ARM_REG_LR, RET_SENTINEL | 1)
    uc.emu_start(entry | 1, RET_SENTINEL)
    return count[0]


def main():
    syms = sym_addrs()
    code = itcm_binary()
    print(f"ITCM binary {len(code)} bytes, symbols: { {k: hex(v) for k, v in syms.items()} }")

    # ---- Keccak-f1600: r0 = state(200B). 입력 2벌로 상수시간 교차검증 ----
    kc = []
    for fill in (0x00, 0xA5):
        uc_regs = {UC_ARM_REG_R0: DTCM_BASE}
        n = None
        uc = Uc(UC_ARCH_ARM, UC_MODE_THUMB)
        uc.mem_map(ITCM_BASE, ITCM_SIZE)
        uc.mem_map(DTCM_BASE, DTCM_SIZE)
        uc.mem_write(ITCM_BASE, code)
        uc.mem_write(DTCM_BASE, bytes([fill] * 200))
        cnt = [0]
        uc.hook_add(UC_HOOK_CODE, lambda *_: cnt.__setitem__(0, cnt[0] + 1))
        uc.reg_write(UC_ARM_REG_R0, DTCM_BASE)
        uc.reg_write(UC_ARM_REG_SP, STACK_TOP)
        uc.reg_write(UC_ARM_REG_LR, RET_SENTINEL | 1)
        uc.emu_start(syms["KeccakF1600_StatePermute"] | 1, RET_SENTINEL)
        kc.append(cnt[0])
    print(f"keccak-f1600 insts: {kc[0]} (입력별: {kc})",
          "— 상수시간 OK" if len(set(kc)) == 1 else "— ⚠ 입력 의존!")

    # ---- X25519: r0=out, r1=scalar, r2=point. 스칼라 2벌로 교차검증 ----
    xc = []
    for scal in (bytes(range(32)), bytes([0xA5] * 32)):
        uc = Uc(UC_ARCH_ARM, UC_MODE_THUMB)
        uc.mem_map(ITCM_BASE, ITCM_SIZE)
        uc.mem_map(DTCM_BASE, DTCM_SIZE)
        uc.mem_write(ITCM_BASE, code)
        out_p, scal_p, point_p = DTCM_BASE, DTCM_BASE + 0x40, DTCM_BASE + 0x80
        uc.mem_write(scal_p, scal)
        uc.mem_write(point_p, bytes([9] + [0] * 31))
        cnt = [0]
        uc.hook_add(UC_HOOK_CODE, lambda *_: cnt.__setitem__(0, cnt[0] + 1))
        uc.reg_write(UC_ARM_REG_R0, out_p)
        uc.reg_write(UC_ARM_REG_R1, scal_p)
        uc.reg_write(UC_ARM_REG_R2, point_p)
        uc.reg_write(UC_ARM_REG_SP, STACK_TOP)
        uc.reg_write(UC_ARM_REG_LR, RET_SENTINEL | 1)
        uc.emu_start(syms["curve25519_scalarmult"] | 1, RET_SENTINEL)
        xc.append(cnt[0])
    print(f"x25519-scalarmult insts: {xc[0]} (입력별: {xc})",
          "— 상수시간 OK" if len(set(xc)) == 1 else "— ⚠ 입력 의존!")

    # ---- 보드 실측 사이클과 결합 (2026-08-16 실측값) ----
    board = {"keccak-f1600": 5504, "x25519-scalarmult": 357510}
    for name, insts in (("keccak-f1600", kc[0]), ("x25519-scalarmult", xc[0])):
        cyc = board[name]
        ipc = insts / cyc
        waste = 1 - insts / (2 * cyc)
        print(f"{name}: cyc={cyc}  insts={insts}  IPC={ipc:.2f}  slot-waste={waste:.1%}")


if __name__ == "__main__":
    main()
