# 실험 CS 보드 커널 생성 — 솔버 출력과 변환 대조군을 실제 U 조각으로 되돌린다.
#
# 출력: blinky/src/gen/expCS_solver.S
#   fiat_mul_u4t_p0 — 같은 안전변환을 거쳤으나 명령 순서는 원본 (변환 세금 대조군)
#   fiat_mul_u4s_p0 — 솔버 재스케줄본
# 둘 다 프롤로그·setup·에필로그는 원본 fiat_mul_u4_p0 과 동일하고 본문만 다르다.
# 프레임은 스필 고유화 때문에 144B -> 240B.
#
# 되돌리는 변환: r13 -> sp, r14 -> lr, #0x8000_0000 이상 즉치 -> 음수(어셈블러 범위)
# 사용법(Windows): py gen_board_cs.py
import re
from pathlib import Path

HERE = Path(__file__).resolve().parent
OPT = HERE / "exp_cs_opt.s"
RAW = HERE / "exp_cs.s"
SRC = Path(r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\fiat_u_stitch_m85.S")
OUT = Path(r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\expCS_solver.S")
FRAME = 240


def prologue_of(func):
    lines = SRC.read_text(encoding="utf-8").splitlines()
    s = next(i for i, l in enumerate(lines) if l.strip() == f"{func}:")
    su = next(i for i in range(s, len(lines)) if lines[i].strip() == "pop {r0-r2}")
    return lines[s + 1:su + 1]


def unhex(m):
    v = int(m.group(1), 16)
    return "#%d" % (v - (1 << 32) if v >= (1 << 31) else v)


def body_of(path):
    out = []
    for ln in path.read_text(encoding="utf-8").splitlines():
        s = ln.split("//")[0].strip()
        if not s or s.endswith(":") or s.startswith("."):
            continue
        s = re.sub(r"\br13\b", "sp", s)
        s = re.sub(r"\br14\b", "lr", s)
        s = re.sub(r"#0x([0-9A-Fa-f]+)", unhex, s)
        # SLOTHY 는 데이터타입 접미사를 대문자로 정규화한다(vldrw.U32) — 되돌린다.
        s = re.sub(r"^(v\w+)\.([A-Z]\d+)", lambda m: m.group(1) + "." + m.group(2).lower(), s)
        out.append("\t" + s)
    return out


def emit(name, src, pro):
    body = body_of(src)
    maxoff = max((int(m.group(1)) for l in body
                  if (m := re.search(r"\[sp,\s*#(\d+)\]", l))), default=0)
    assert maxoff + 4 <= FRAME, f"프레임 부족: {maxoff + 4} > {FRAME}"
    assert not any(re.search(r"\b(ldrd|strd)\b", l) for l in body), "ldrd/strd 잔존"
    print(f"  {name}: 본문 {len(body)} 명령, 최대 sp 오프셋 {maxoff}")
    return [
        f".global {name}", f".type {name}, %function",
        ".thumb_func", ".balign 16", f"{name}:",
        *pro, *body,
        f"\tadd sp, sp, #{FRAME}", "\tpop {r3-r11, pc}",
        f".size {name}, .-{name}", "",
    ]


def main():
    pro = prologue_of("fiat_mul_u4_p0")
    pro = [re.sub(r"sub sp, sp, #\d+", f"sub sp, sp, #{FRAME}", l) for l in pro]
    out = [
        "/* 실험 CS: fiat_mul_u4_p0 의 변환 대조군(u4t)과 SLOTHY 재스케줄본(u4s).",
        " * 본문만 다르고 프롤로그/setup/에필로그는 원본과 동일하다.",
        f" * 스필 슬롯 고유화로 프레임 144 -> {FRAME}B. 생성: gen_board_cs.py */",
        ".syntax unified", ".thumb", ".arch armv8.1-m.main",
        ".arch_extension mve",
        # 원본 fiat_mul_u4_p0 은 expAM1b 에서 flash 로 퇴거됐다(.text.fiat_u_stitch).
        # 배치가 단일 변수를 오염시키지 않도록 같은 종류의 섹션에 둔다.
        '.section .text.fiat_u_stitch_cs, "ax", %progbits', "",
    ]
    out += emit("fiat_mul_u4t_p0", RAW, pro)
    if OPT.exists():
        out += emit("fiat_mul_u4s_p0", OPT, pro)
    else:
        print("  !! exp_cs_opt.s 없음: u4s 를 u4t 사본으로 임시 생성(빌드 확인용)")
        out += emit("fiat_mul_u4s_p0", RAW, pro)
    OUT.write_text("\n".join(out) + "\n", encoding="utf-8", newline="\n")
    print(f"wrote {OUT}")


if __name__ == "__main__":
    main()
