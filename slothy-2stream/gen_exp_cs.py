# 실험 CS 입력 생성 — 실제 U 융합 조각 fiat_mul_u4_p0 의 본문을 SLOTHY 입력으로.
#
# 리뷰_v8_상위학회.md P0-3(강). 종단간 U 는 균등 지퍼 산출물이고 솔버를 적용하지
# 않았다는 것이 원고의 가장 큰 한계였다. 이 스크립트는 그 조각 **하나**를 떼어
# 솔버가 지퍼를 이기는지 본다.
#
# 입력은 measure-harness/expAE-src/fiat_u_stitch_m85.S 의 fiat_mul_u4_p0 본문
# (setup 뒤 ~ add sp 앞). 안전 변환 3칙(exp_b/exp_c 확립):
#   ① ldrd/strd -> ldr/str x2, 목적지=베이스인 로드는 마지막
#   ② 스필 슬롯 고유화 (SLOTHY 는 WAR/WAW 메모리 반의존을 보존하지 않음)
#   ③ 별칭 정규화 + 음수 즉치 16진화
# r11(b1 베이스)·q7(개더 베이스)·sp 는 예약해 재할당을 막는다.
#
# 사용법(Windows): py gen_exp_cs.py
import re
from pathlib import Path

HERE = Path(__file__).resolve().parent
SRC = HERE.parent / "measure-harness" / "expAE-src" / "fiat_u_stitch_m85.S"
OUT = HERE / "exp_cs.s"
MAP = HERE / "exp_cs_slotmap.txt"
FUNC = "fiat_mul_u4_p0"


def extract_body(path, func):
    """setup 끝(pop {r0-r2}) 다음부터 'add sp' 앞까지."""
    lines = path.read_text(encoding="utf-8").splitlines()
    start = next(i for i, l in enumerate(lines) if l.strip() == f"{func}:")
    end = next(i for i in range(start, len(lines))
               if lines[i].strip().startswith("add sp"))
    setup_end = next(i for i in range(start, end)
                     if lines[i].strip() == "pop {r0-r2}")
    body = [l for l in lines[setup_end + 1:end] if l.strip()]
    prologue = lines[start + 1:setup_end + 1]
    return prologue, body


def normalize(body):
    """SLOTHY 파서 호환 + 안전 변환. 반환: (명령들, 스필 맵, 통계)"""
    out, stats = [], {"ldrd": 0, "strd": 0, "neg_imm": 0}
    for ins in body:
        s = "\t" + ins.strip()
        s = re.sub(r"\bfp\b", "r11", s)
        s = re.sub(r"\bsl\b", "r10", s)
        s = re.sub(r"\bip\b", "r12", s)
        s = re.sub(r"\[(\w+)\]", r"[\1, #0]", s)   # 파서는 offset 생략을 못 읽는다
        s = re.sub(r"\bsp\b", "r13", s)            # 파서는 r<N> 표기만 받는다
        s = re.sub(r"\blr\b", "r14", s)
        # ① 더블워드 분해는 음수 즉치 16진화보다 먼저 (오프셋 산술이 필요).
        #    binutils 축약형 `ldrd Rt, [b,#k]` 는 Rt,Rt+1 쌍을 뜻한다.
        m = re.match(r"\s*(ldrd|strd)\s+r(\d+),\s*(?:r(\d+),\s*)?"
                     r"\[(\w+),\s*#(-?\d+)\]", s)
        if m:
            op = "ldr" if m.group(1) == "ldrd" else "str"
            stats[m.group(1)] += 1
            lo_r = "r" + m.group(2)
            hi_r = "r" + (m.group(3) if m.group(3) else str(int(m.group(2)) + 1))
            base, off = m.group(4), int(m.group(5))
            lo = f"\t{op} {lo_r}, [{base}, #{off}]"
            hi = f"\t{op} {hi_r}, [{base}, #{off + 4}]"
            out += [hi, lo] if (op == "ldr" and lo_r == base) else [lo, hi]
            continue
        out.append(s)
    fixed = []
    for s in out:                                   # ③ 음수 즉치 -> 32비트 16진
        n = len(re.findall(r"#-\d+", s))
        stats["neg_imm"] += n
        fixed.append(re.sub(r"#(-\d+)",
                            lambda m: "#0x%X" % (int(m.group(1)) & 0xFFFFFFFF), s))
    return fixed, stats


def uniquify_spills(body, base_off):
    """[sp, #k] 스필을 고유 오프셋으로. str 이 새 슬롯을 연다."""
    res, cur, nxt = [], {}, base_off
    for ins in body:
        m = re.match(r"\s*(ldr|str)\s+(\w+),\s*\[r13,\s*#(\d+)\]", ins)
        if not m:
            res.append(ins)
            continue
        op, reg, off = m.group(1), m.group(2), int(m.group(3))
        if op == "str":
            cur[off] = nxt
            nxt += 4
        if off not in cur:            # 프레임 밖 read-only (인자 등) — 그대로
            res.append(ins)
            continue
        res.append(f"\t{op} {reg}, [r13, #{cur[off]}]")
    return res, nxt


def main():
    prologue, body = extract_body(SRC, FUNC)
    norm, stats = normalize(body)
    uniq, frame_end = uniquify_spills(norm, 0)

    scalar = [i for i in uniq if not re.search(r"\bq\d|\bv(ldr|str|eor|add|orr|bic|shl|sri|mov)", i)]
    vector = [i for i in uniq if i not in scalar]
    lines = [
        f"// 실험 CS: 실제 U 조각 {FUNC} 본문 — 솔버 입력",
        f"// 원본 {len(body)} 명령 -> 변환 후 {len(uniq)} "
        f"(ldrd {stats['ldrd']}, strd {stats['strd']} 분해)",
        f"// 스칼라 {len(scalar)} / 벡터 {len(vector)}, 스필 프레임 {frame_end}B",
        "start:",
    ] + uniq + ["end:"]
    OUT.write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")
    MAP.write_text(f"frame_bytes={frame_end}\nprologue={len(prologue)}\n"
                   f"orig={len(body)}\nnorm={len(uniq)}\n", encoding="utf-8", newline="\n")
    print(f"{FUNC}: 원본 {len(body)} -> {len(uniq)} 명령 "
          f"(스칼라 {len(scalar)} / 벡터 {len(vector)})")
    print(f"ldrd {stats['ldrd']} strd {stats['strd']} neg_imm {stats['neg_imm']} "
          f"스필 프레임 {frame_end}B")
    print(f"wrote {OUT}")


if __name__ == "__main__":
    main()
