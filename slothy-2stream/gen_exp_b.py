# 실험 B 입력 생성: mul256_flat6 본문 + round6 본문을 '순차 연접'만 해서 내보냄
# (교차는 SLOTHY 몫 — 실험 A와 같은 원리, 전체 크기). 사용법(Windows): py gen_exp_b.py
import sys

sys.path.insert(0, r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\measure-harness")
from stitch_zip import parse_a_body, round_stream6, SP  # noqa: E402

OUT = r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\slothy-2stream\exp_b.s"

# flatY = IT-free(v2 산술) + -ffixed-r8(B 상태 포인터) + -ffixed-r12(스필 베이스).
# 스택 스필을 r12 기반 DTCM 버퍼로 재지향해 SLOTHY 파서 갭(sp/push/pop)을 회피.
# 나머지 레지스터 충돌은 B가 전부 write-first라 무해 — 재할당은 솔버 몫.
import os  # noqa: E402
import re  # noqa: E402

a_src = SP + r"\mul256_flatY.s"
if os.path.exists(a_src):
    a6 = parse_a_body(a_src, "mul256_flatY")
    a_flat = [ins for clump in a6 for ins in clump]
else:
    frozen = OUT + ".bak-20260824"
    lines = open(frozen, encoding="utf-8").read().splitlines()
    count = int(re.search(r"A=(\d+) instrs", lines[1]).group(1))
    body = ["\t" + line.strip() for line in lines[3:] if line.strip() and line.strip() != "end:"]
    a_flat = body[:count]
    print(f"A source missing: reused frozen normalized flatY prefix ({count} instrs) from {frozen}")

frame = [ins for ins in a_flat if re.match(r"\s*(sub|add)\s+sp", ins)]
print("frame ops removed:", [f.strip() for f in frame])
a_flat = [ins for ins in a_flat if not re.match(r"\s*(sub|add)\s+sp", ins)]

norm = []
for ins in a_flat:
    ins = re.sub(r"\bfp\b", "r11", ins)
    ins = re.sub(r"\bsl\b", "r10", ins)
    ins = re.sub(r"\bip\b", "r12", ins)
    ins = ins.replace("[sp", "[r12")            # 스필 → r12 버퍼 (g_spill, 라이브-인)
    ins = re.sub(r"\[(\w+)\]", r"[\1, #0]", ins)  # 오프셋 생략형
    # ldrd/strd 분해: 모델이 8바이트 폭을 4바이트로 오인해 겹침 재배열할 위험 제거
    m = re.match(r"\s*(ldrd|strd)\s+(\w+),\s*(\w+),\s*\[(\w+),\s*#(\d+)\]", ins)
    if m:
        op = "ldr" if m.group(1) == "ldrd" else "str"
        r_lo, r_hi, base, off = m.group(2), m.group(3), m.group(4), int(m.group(5))
        lo = f"\t{op} {r_lo}, [{base}, #{off}]"
        hi = f"\t{op} {r_hi}, [{base}, #{off + 4}]"
        if op == "ldr" and r_lo == base:   # ldrd 베이스-파괴 함정
            norm += [hi, lo]
        else:
            norm += [lo, hi]
        continue
    norm.append(ins)
a_flat = norm

# 스필 슬롯 재사용 제거: 같은 [r12,#k]가 다른 값으로 재사용되면(WAR/WAW) 솔버가
# 메모리 반의존성을 안 지켜 오염됨(실측: prod-mm 잔존) → str마다 새 고유 오프셋 부여.
# str [#k] = 새 인스턴스 시작, 이후 ldr [#k]는 그 인스턴스를 읽음. (직선 코드 전제)
uniq = []
slot_map = {}      # 원래 offset -> 현재 고유 offset
next_off = 0
for ins in a_flat:
    m = re.match(r"\s*(ldr|str)\s+(\w+),\s*\[r12,\s*#(\d+)\]", ins)
    if not m:
        uniq.append(ins)
        continue
    op, reg, off = m.group(1), m.group(2), int(m.group(3))
    if op == "str":
        slot_map[off] = next_off
        next_off += 4
    uniq.append(f"\t{op} {reg}, [r12, #{slot_map[off]}]")
a_flat = uniq
print(f"spill slots uniquified: {next_off // 4} instances (buffer {next_off}B)")
b = round_stream6()
# round6은 r8=포인터 가정 — SLOTHY 입력에서는 r8이 라이브-인 레지스터로 취급됨
lines = (["// 실험 B: mul256(6-fixed) + Keccak round6 순차 연접 — 교차는 솔버 몫",
          f"// A={len(a_flat)} instrs, B={len(b)} instrs",
          "start:"] + a_flat + b + ["end:"])
open(OUT, "w", encoding="utf-8", newline="\n").write("\n".join(lines) + "\n")
print(f"A={len(a_flat)} B={len(b)} total={len(a_flat) + len(b)} -> exp_b.s")
