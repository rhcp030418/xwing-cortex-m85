# 플랜 B v0.1 — 4-way 배칭 비트-인터리브 Keccak 라운드 (MVE Q-레지스터) (2026-08-17)
#
# 설계: Q 벡터의 4개 32비트 레인 = 독립 Keccak 상태 4개의 같은 반쪽-레인(even 또는 odd).
#   → 회전량이 벡터 내 균일(vshl+vsri 2명령 회전 관용구), 레인 활용 100%.
#   → GP 레지스터는 베이스 포인터 5개만 사용(스칼라 A 스트림과 데이터 레지스터 무경합).
# 메모리 레이아웃 (블록 베이스 = 하네스 g_mve, 16B 정렬):
#   E[i]  @ base+   i*16   (레인 i even-half ×4상태)   r1 커버(0..384)
#   O[i]  @ base+512+i*16                              r2=base+512
#   BE[i] @ base+1024+i*16 (ρπ 스크래치 even)          r3=base+1024
#   BO[i] @ base+1536+i*16                             r4=base+1536
#   CE[x]@+2048 CO[x]@+2128 DE[x]@+2208 DO[x]@+2288    r5=base+2048
# 검증: 4개 상태를 각각 디인터리브해 평면 C 레퍼런스 라운드와 대조.
# 사용법(Windows): py mve_keccak.py  →  blinky src/gen/mvekeccak_board.s
RHO = [[0, 36, 3, 41, 18], [1, 44, 10, 45, 2], [62, 6, 43, 15, 61],
       [28, 55, 25, 21, 56], [27, 20, 39, 8, 14]]

OUT = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen\mvekeccak_board.s"

E = lambda i: ("r1", 16 * i)
O = lambda i: ("r2", 16 * i)
BE = lambda i: ("r3", 16 * i)
BO = lambda i: ("r4", 16 * i)
CE = lambda x: ("r5", 16 * x)
CO = lambda x: ("r5", 80 + 16 * x)
DE = lambda x: ("r5", 160 + 16 * x)
DO = lambda x: ("r5", 240 + 16 * x)


def ld(q, ba):
    return f"\tvldrw.u32 {q}, [{ba[0]}, #{ba[1]}]"


def st(q, ba):
    return f"\tvstrw.u32 {q}, [{ba[0]}, #{ba[1]}]"


def rot(qd, qs, m, ins):
    """qd = rol32(qs, m) per-lane. m=0이면 vorr 복사."""
    if m == 0:
        ins.append(f"\tvorr {qd}, {qs}, {qs}")
    else:
        ins.append(f"\tvshl.i32 {qd}, {qs}, #{m}")
        ins.append(f"\tvsri.32 {qd}, {qs}, #{32 - m}")


def round_mve4():
    ins = []
    # θ 패리티: C_h[x] = XOR_y half[x+5y]
    for half, src, dst in (("E", E, CE), ("O", O, CO)):
        for x in range(5):
            ins.append(ld("q0", src(x)))
            for y in range(1, 5):
                ins.append(ld("q1", src(x + 5 * y)))
                ins.append("\tveor q0, q0, q1")
            ins.append(st("q0", dst(x)))

    # D: DE[x] = CE[x4] ^ rol1(CO[x1]) / DO[x] = CO[x4] ^ CE[x1]
    for x in range(5):
        x1, x4 = (x + 1) % 5, (x + 4) % 5
        ins.append(ld("q0", CO(x1)))
        rot("q1", "q0", 1, ins)
        ins.append(ld("q2", CE(x4)))
        ins.append("\tveor q1, q1, q2")
        ins.append(st("q1", DE(x)))
        ins.append(ld("q0", CE(x1)))
        ins.append(ld("q2", CO(x4)))
        ins.append("\tveor q0, q0, q2")
        ins.append(st("q0", DO(x)))

    # 융합 ρπ⊕D: B[dst] = rol64(lane[src]^D[x], n) — 인터리브 반쪽 규칙
    for x in range(5):
        ins.append(ld("q6", DE(x)))
        ins.append(ld("q7", DO(x)))
        for y in range(5):
            src_l, dst_l, n = x + 5 * y, y + 5 * ((2 * x + 3 * y) % 5), RHO[x][y]
            m, odd = n // 2, n % 2
            ins.append(ld("q0", E(src_l)))
            ins.append(ld("q1", O(src_l)))
            ins.append("\tveor q0, q0, q6")     # tmp_e
            ins.append("\tveor q1, q1, q7")     # tmp_o
            if odd:
                rot("q2", "q1", (m + 1) % 32, ins)   # B_e = rol(tmp_o, m+1)
                ins.append(st("q2", BE(dst_l)))
                rot("q3", "q0", m % 32, ins)         # B_o = rol(tmp_e, m)
                ins.append(st("q3", BO(dst_l)))
            else:
                rot("q2", "q0", m % 32, ins)
                ins.append(st("q2", BE(dst_l)))
                rot("q3", "q1", m % 32, ins)
                ins.append(st("q3", BO(dst_l)))

    # χ: lane[x] = B[x] ^ (~B[x+1] & B[x+2]) — 반쪽별, 행별 5개 로드 후 계산
    for half, bsrc, dst in (("E", BE, E), ("O", BO, O)):
        for y in range(5):
            for i in range(5):
                ins.append(ld(f"q{i}", bsrc(i + 5 * y)))
            for xx in range(5):
                b1, b2 = (xx + 1) % 5, (xx + 2) % 5
                ins.append(f"\tvbic q5, q{b2}, q{b1}")
                ins.append(f"\tveor q5, q5, q{xx}")
                ins.append(st("q5", dst(xx + 5 * y)))

    # ι: E[0] ^= 1 (4상태 공통, 라운드0)
    ins.append("\tvmov.i32 q0, #1")
    ins.append(ld("q1", E(0)))
    ins.append("\tveor q1, q1, q0")
    ins.append(st("q1", E(0)))
    return ins


def round_mve4_b3():
    """실험 G: 3-베이스 중앙 앵커판 — vldrw 즉치 ±508(부호형) 활용.
    P0=블록+400 → E(off -400..-16)·O(off 112..496) / P1=블록+1440 → BE(-416..-32)·BO(96..480)
    / P2=블록+2048 → C/D(0..319). 베이스 = r10, r11, r12 (Lenngren 양보 3개 시나리오).
    본문은 round_mve4()와 동일 로직 — 주소식만 교체."""
    ins = round_mve4()
    out = []
    for s in ins:
        m = __import__("re").match(r"(\s*v(?:ldrw|strw)\.u32 q\d+), \[(r\d), #(\d+)\]", s)
        if not m:
            out.append(s)
            continue
        pre, base, off = m.group(1), m.group(2), int(m.group(3))
        # v0.2 베이스 → 블록 절대 오프셋 복원
        abs_off = {"r1": 0, "r2": 512, "r3": 1024, "r4": 1536, "r5": 2048}[base] + off
        if abs_off < 1024:
            nb, anchor = "r10", 400
        elif abs_off < 2048:
            nb, anchor = "r11", 1440
        else:
            nb, anchor = "r12", 2048
        rel = abs_off - anchor
        assert -508 <= rel <= 508, (abs_off, rel)
        out.append(f"{pre}, [{nb}, #{rel}]")
    return out


def pack4_lane():
    """실험 H: 4개 비트인터리브 상태(각 50워드, r1[state s]=블록+s*256) →
    레인 전치 벡터 레이아웃(E[i]/O[i] 레인 s = 상태 s 워드). vld4.32로 4-way 인터리브
    로드 → 그대로 저장. 비트인터리브 자체는 absorb가 이미 한 것이라 글루 아님(레인 전치만)."""
    ins = []
    # 입력 4상태 연속: r1 = flat base (state s at r1 + s*256, 각 50워드=200B)
    # vld4.32 {q0-q3}, [r0]! 는 4스트림 디인터리브 로드 → 레인0=s0,레인1=s1...
    # 여기선 상태별 포인터 4개(r2,r3,r4,r5) → 워드 i를 q에 모아 저장.
    # 간명판: 스칼라 전치 (200 load + 200 store) — naive 상한. r0=flat, r1=packed.
    for i in range(50):
        for s in range(4):
            ins.append(f"\tldr r6, [r0, #{(s * 50 + i) * 4}]")
            # packed: E[i] at packed+i*16+s*4 (i<25) ; O at packed+512+(i-25)*16+s*4
            if i < 25:
                po = i * 16 + s * 4
            else:
                po = 512 + (i - 25) * 16 + s * 4
            ins.append(f"\tstr r6, [r1, #{po}]")
    return ins


def unpack4_lane():
    """실험 H 역방향: 레인 전치 → 4상태 연속. r0=packed, r1=flat."""
    ins = []
    for i in range(50):
        for s in range(4):
            po = i * 16 + s * 4 if i < 25 else 512 + (i - 25) * 16 + s * 4
            ins.append(f"\tldr r6, [r0, #{po}]")
            ins.append(f"\tstr r6, [r1, #{(s * 50 + i) * 4}]")
    return ins


def round_mve4_b2():
    """v0.4: 2-베이스판 — E/O 외부 레이아웃 유지(0/512, 하네스 패킹 불변), 스크래치만 압축.
    압축: BE 1024→912 · BO 1536→1312 · CE/CO/DE/DO 2048~→1712~. 전 영역 0..2031(<2032).
    앵커: r10=블록+508([0,1016]) · r11=블록+1524([1016,2032]). 접근별 그리디 선택 → 베이스 2개."""
    import re
    OLD = {"r1": 0, "r2": 512, "r3": 1024, "r4": 1536, "r5": 2048}
    #      E       O          BE          BO          C/D

    def compact(old_abs):
        # E·O 그대로 / BE·BO·C·D를 O 뒤로 당겨 붙임
        table = [(0, 400, 0),        # E   → 0
                 (512, 912, 512),    # O   → 512 (유지)
                 (1024, 1424, 912),  # BE  → 912
                 (1536, 1936, 1312), # BO  → 1312
                 (2048, 2368, 1712)] # C/D → 1712 (CE1712 CO1792 DE1872 DO1952)
        for lo, hi, base in table:
            if lo <= old_abs < hi:
                return base + (old_abs - lo)
        raise ValueError(old_abs)

    out = []
    for s in round_mve4():
        m = re.match(r"(\s*v(?:ldrw|strw)\.u32 q\d+), \[(r\d), #(\d+)\]", s)
        if not m:
            out.append(s)
            continue
        pre, base, off = m.group(1), m.group(2), int(m.group(3))
        ca = compact(OLD[base] + off)
        if ca <= 1016:
            nb, rel = "r10", ca - 508
        else:
            nb, rel = "r11", ca - 1524
        assert -508 <= rel <= 508, (ca, rel)
        out.append(f"{pre}, [{nb}, #{rel}]")
    return out


GATHER_IMM = 508  # 개더 즉치 범위. ARM ARM 미확인 -> 어서션으로 방어


def _defuse(ins):
    """Q 레지스터 def/use. vsri 는 Qd 가 in-out(병합 시프트)."""
    import re
    op = re.match(r"\s*([a-z0-9.]+)", ins).group(1)
    qs = [int(q) for q in re.findall(r"\bq(\d+)\b", ins)]
    if op.startswith("vstrw"):
        return [], qs
    if op.startswith("vldrw"):
        return [qs[0]], []
    if op.startswith("vsri"):
        return [qs[0]], qs
    return [qs[0]], qs[1:]


def rename_q(body, pool):
    """직선 코드 정확 선형스캔 재명명(루프 캐리 Q 없음 — 정의 전 사용 0건 확인).
    pool 이 동시 라이브 최대(=6)보다 작으면 어서션."""
    import re
    last = {}
    for pc, ins in enumerate(body):
        for q in _defuse(ins)[1]:
            last[q] = pc
    free, cur, out = list(pool), {}, []
    for pc, ins in enumerate(body):
        d, u = _defuse(ins)
        for q in u:
            assert q in cur, f"정의 전 사용 q{q} @{pc}"
        for q in d:
            if q not in cur:
                assert free, f"Q 풀 고갈 @{pc}: {ins.strip()}"
                cur[q] = free.pop(0)
        out.append(re.sub(r"\bq(\d+)\b", lambda m: f"q{cur[int(m.group(1))]}", ins))
        for q in list(cur):
            if last.get(q, -1) <= pc and q not in d:
                free.append(cur.pop(q))
        for q in u:
            if last.get(q, -1) == pc and q in cur and q not in d:
                free.append(cur.pop(q))
    return out


def round_mve4_b0():
    """v0.5 (2026-08-20): GP 베이스 0개 — 개더/스캐터(벡터 베이스 + 균일 즉치).

    근거 (Arm Cortex-M85 SWOG 107950_0100_01, Table 3-22/3-23):
      연속 vldrw  레이턴시 2 / 스루풋 1/2  |  개더 vldrw(word)  레이턴시 3 / 스루풋 1/2
      연속 vstrw            스루풋 1/2  |  스캐터 vstrw                 스루풋 1/2
      -> 순수 추가 비용 = 로드 레이턴시 +1 뿐이고 LSU 점유 증가는 0.
         GP 양보가 사라지므로 실험 I/v0.4 의 구조적 세금 12.1% 를 전액 회수한다.

    q6/q7 = 주소 벡터 {P, P+4, P+8, P+12}, P = 블록+508 / 블록+1524 (b2 앵커 그대로).
    작업 Q 는 q0-q5 로 재명명 (동시 라이브 최대 6 실측 -> 여유가 정확히 2개).
    b2 와의 등가성: 심볼 실행 후 최종 메모리 120셀 일치로 확인 (2026-08-20).

    ⚠ 보드 전에 확인할 미확인 2건:
      (1) 개더 즉치 범위가 정말 +-508 인지 (ARM ARM). 아니면 스크래치 축소가 필요
      (2) DTCM 뱅크 충돌 (SWOG 4.3): "스칼라 로드와 MVE 개더 로드가 같은 뱅크면
          인접 배치하지 말 것". 스티칭은 정의상 둘을 인접시킨다 — 실측 필수이며
          SLOTHY 모델에는 뱅킹이 없어 예측 불가.
    """
    import re
    out = []
    for ins in rename_q(round_mve4_b2(), [0, 1, 2, 3, 4, 5]):
        m = re.match(r"(\s*v(?:ldrw|strw)\.u32 q\d+), \[(r10|r11), #(-?\d+)\]", ins)
        if not m:
            out.append(ins)
            continue
        pre, base, off = m.group(1), m.group(2), int(m.group(3))
        assert -GATHER_IMM <= off <= GATHER_IMM and off % 4 == 0, (base, off)
        out.append(f"{pre}, [{'q6' if base == 'r10' else 'q7'}, #{off}]")
    return out


def gather_setup():
    """루프 밖 1회: q6/q7 에 주소 벡터 적재. r1 = 블록 베이스.
    루프 본문은 GP 0개 — setup 만 r2/r3 를 잠깐 쓴다."""
    return ["\tadr r2, 2f",
            "\tb 3f",
            "\t.balign 16",
            "2:\t.word 0, 4, 8, 12",
            "3:",
            "\tvldrw.u32 q6, [r2]",
            "\tadd r3, r1, #1524",
            "\tvadd.i32 q7, q6, r3",
            "\tadd r3, r1, #508",
            "\tvadd.i32 q6, q6, r3"]


def gp_used(body):
    """본문에 남은 GP 레지스터 이름 (개더판 검증용)."""
    toks = set()
    for i in body:
        for t in i.replace(",", " ").replace("[", " ").replace("]", " ").split():
            if t.startswith("r") and t[1:].isdigit():
                toks.add(t)
    return sorted(toks)


def remap_bases(body, mapping):
    """베이스 레지스터 치환 (코이슈판: A가 r1-r5를 쓰므로 B 베이스를 이동)."""
    import re
    out = []
    for ins in body:
        def rep(m):
            return mapping.get(m.group(0), m.group(0))
        out.append(re.sub(r"\br([1-5])\b", rep, ins))
    return out


def main():
    import sys
    sys.path.insert(0, r"c:\Users\cnscj\Dropbox\박도윤개인과제\A주제\measure-harness")
    from stitch_zip import zip_streams

    body = round_mve4()
    print(f"MVE 4-way round: {len(body)} Q-instrs ({len(body) / 4:.0f}/state)")

    # 실험 F: 코이슈 — A = 스칼라 MAC 체인(레지스터 전용), B = MVE 라운드(베이스 이동판)
    MAP = {"r1": "r6", "r2": "r7", "r3": "r9", "r4": "r10", "r5": "r11"}
    body_f = remap_bases(body, MAP)
    a_chain = ["\tumaal r4, r5, r2, r3"] * len(body_f)
    body_zip = zip_streams([[i] for i in a_chain], body_f)
    print(f"co-issue: A={len(a_chain)} scalar + B={len(body_f)} vector = zip {len(body_zip)}")

    def wrap(name, setup, body_, counter="r12"):
        return ([f"// {name}",
                 f".global {name}", f".type {name}, %function",
                 ".thumb_func", ".balign 16",
                 f"{name}:",
                 "\tpush {r4-r11, lr}",
                 "\tvpush {d8-d15}",
                 f"\tmov {counter}, r0"] + setup + [".balign 16", "1:"] + body_ + [
                 f"\tsubs {counter}, {counter}, #1",
                 "\tbne 1b",
                 "\tvpop {d8-d15}",
                 "\tpop {r4-r11, pc}", ""])

    out = [".text", ".syntax unified", ".thumb", "",
           "// 플랜 B: 4-way MVE Keccak + 코이슈 실험 (mve_keccak.py v0.2 생성)"]
    # 단독 B (원 베이스 r1-r5)
    out += wrap("keccak4_round_mve",
                ["\tadd r2, r1, #512", "\tadd r3, r1, #1024",
                 "\tadd r4, r1, #1536", "\tadd r5, r1, #2048"],
                body, counter="r6")
    # 단독 A (스칼라 MAC 체인)
    out += wrap("coissue_scalar",
                ["\tmovs r2, #3", "\tmovs r3, #5", "\tmovs r4, #0", "\tmovs r5, #0"],
                a_chain)
    # F = A × B 교차 (B 베이스 r6,r7,r9,r10,r11 — r1 인자에서 유도)
    out += wrap("coissue_zip",
                ["\tmov r6, r1", "\tadd r7, r1, #512", "\tadd r9, r1, #1024",
                 "\tadd r10, r1, #1536", "\tadd r11, r1, #2048",
                 "\tmovs r2, #3", "\tmovs r3, #5", "\tmovs r4, #0", "\tmovs r5, #0"],
                body_zip)

    # 실험 G: 3-베이스판 — 단독 + 11-GP 스칼라 체인 코이슈 (베이스 r10,r11,r12)
    body3 = round_mve4_b3()
    a3 = ["\tumaal r0, r1, r2, r3"] * len(body3)
    zip3 = zip_streams([[i] for i in a3], body3)
    print(f"exp G: b3={len(body3)} Q-instrs, zip3={len(zip3)}")
    out += wrap("keccak4_mve3",
                ["\tadd r10, r1, #400", "\tadd r11, r1, #1440", "\tadd r12, r1, #2048"],
                body3, counter="r6")
    out += wrap("coissue3_zip",
                ["\tadd r10, r1, #400", "\tadd r11, r1, #1440", "\tadd r12, r1, #2048",
                 "\tmovs r2, #3", "\tmovs r3, #5", "\tmovs r0, #0", "\tmovs r1, #0"],
                zip3, counter="lr")

    # v0.4 실험 G2: 2-베이스판 (베이스 r10,r11) — 스칼라 양보 2개
    body2 = round_mve4_b2()
    a2 = ["\tumaal r0, r1, r2, r3"] * len(body2)
    zip2 = zip_streams([[i] for i in a2], body2)
    print(f"v0.4 b2={len(body2)} Q-instrs, zip2={len(zip2)}")
    out += wrap("keccak4_mve2",
                ["\tadd r10, r1, #508", "\tadd r11, r1, #1524"],
                body2, counter="r6")
    out += wrap("coissue2_zip",
                ["\tadd r10, r1, #508", "\tadd r11, r1, #1524",
                 "\tmovs r2, #3", "\tmovs r3, #5", "\tmovs r0, #0", "\tmovs r1, #0"],
                zip2, counter="lr")

    # v0.5 실험 O: 0-베이스 개더판 (GP 양보 0개) — 2026-08-20
    body0 = round_mve4_b0()
    a0 = ["\tumaal r0, r1, r2, r3"] * len(body0)
    zip0 = zip_streams([[i] for i in a0], body0)
    print(f"v0.5 b0={len(body0)} Q-instrs, zip0={len(zip0)}, "
          f"루프내 GP={gp_used(body0) or '없음'}")
    out += wrap("keccak4_mve0", gather_setup(), body0, counter="r6")
    out += wrap("coissue0_zip",
                gather_setup() + ["\tmovs r2, #3", "\tmovs r3, #5",
                                  "\tmovs r0, #0", "\tmovs r1, #0"],
                zip0, counter="lr")

    # 실험 H: 레인 전치 글루 (pack + unpack 왕복)
    pk = pack4_lane()
    upk = unpack4_lane()
    print(f"exp H: pack={len(pk)} unpack={len(upk)} instrs")
    out += ["// 실험 H: 레인 전치 글루 (r0=flat, r1=packed)",
            ".global pack4_lane", ".type pack4_lane, %function",
            ".thumb_func", ".balign 16", "pack4_lane:",
            "\tpush {r4-r7, lr}"] + pk + ["\tpop {r4-r7, pc}", "",
            ".global unpack4_lane", ".type unpack4_lane, %function",
            ".thumb_func", ".balign 16", "unpack4_lane:",
            "\tpush {r4-r7, lr}"] + upk + ["\tpop {r4-r7, pc}", ""]

    open(OUT, "w", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
    print(f"wrote {OUT}")


if __name__ == "__main__":
    main()
