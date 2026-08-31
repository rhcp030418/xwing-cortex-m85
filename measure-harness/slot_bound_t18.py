# expCK/expCL 단일스텝 mnemonic 히스토그램 × T18 실측 발행 규칙 → 회계 진단
#
# 단일스텝 로그는 mnemonic 빈도만 보존하고 실행 순서·의존성은 보존하지 않는다. 따라서
# 아래 값은 구조적 하한이나 성능 상한이 아니다. 기존 원고의 합산식(legacy)과, 곱셈이
# MVE load/ALU beat와 짝지어질 수 있다는 같은 실측을 반영한 낙관적 packing(relaxed)이
# 서로 다른 값을 낸다는 사실을 확인하는 반례용 진단이다. 보드 불필요.
# 입력은 logs/2026-08-28_expCL_icount_*.json.
#
# 규칙(T18):  곱셈 1cyc, ALU/ldr 과 짝  | str 1cyc/워드, 짝 없음 | bfi 1cyc 짝 없음
#             vstrw 2cyc 스칼라 차단     | vldrw·MVE ALU 2cyc, 스칼라 1개/cyc 허용
# stm/push 는 레지스터 수를 세지 않고 2워드로 잡는다. 이 근사도 하한 주장을 막는다.
import json, math, pathlib

LOG = pathlib.Path(__file__).parent / "logs"
CYC = {"seq4": (85196, 85210), "fused4": (87138, 87168),
       "seq8": (153562, 153576), "fused8": (163472, 163480)}   # 표 6 범위(논문_데이터_표 T27)


def accounting(m):
    g = lambda *p: sum(v for k, v in m.items() if k.startswith(p))
    I = sum(m.values())
    mul = g("umaal", "umull", "umlal", "mul", "mla", "mls", "smull", "smlal")
    strd = g("strd"); stm = g("stmdb", "stmia", "push")
    st1 = g("str") - strd
    bfi = g("bfi", "bfc")
    vldr = g("vld", "ldc", "vpop"); vstr = g("vst", "stc", "vpush")
    mve_alu = g("v") - g("vld", "vst", "vpush", "vpop")
    rest = I - (mul + st1 + strd + stm + bfi + vldr + vstr + mve_alu)
    store_words = st1 + 2 * strd + 2 * stm
    unpairable = store_words + bfi + 2 * vstr
    vector_beats = 2 * (vldr + mve_alu)
    legacy = max(
        unpairable + mul + (rest + vector_beats) / 2,
        2 * (vldr + vstr + mve_alu),
    )
    relaxed = unpairable + max(
        math.ceil((mul + rest + vector_beats) / 2),
        vector_beats,
        mul,
    )
    return I, dict(mul=mul, store_words=store_words, bfi=bfi, vldr=vldr, vstr=vstr,
                   mve_alu=mve_alu, rest=rest), legacy, relaxed


if __name__ == "__main__":
    for k in ("seq4", "fused4", "seq8", "fused8"):
        m = json.load(open(LOG / f"2026-08-28_expCL_icount_{k}.json"))["mnemonics"]
        I, parts, legacy, relaxed = accounting(m)
        lo, hi = CYC[k]
        print(f"{k:7s} I={I:7d} {parts}")
        for C in (lo, hi):
            print(f"   C={C}  2C-I={2*C-I} ({100*(2*C-I)/(2*C):.2f}% of 2C)   "
                  f"legacy={legacy:.0f} relaxed={relaxed:.0f} "
                  f"C-relaxed={C-relaxed:.0f} ({100*(C-relaxed)/C:.2f}% of C)")
        assert legacy >= relaxed, (k, legacy, relaxed)

    # 같은 실측 규칙으로도 umaal 2개와 2-beat MVE ALU 하나는 3cyc(legacy) 또는
    # 2cyc(relaxed)로 회계된다. mnemonic 빈도만으로 하한을 정할 수 없다는 최소 반례다.
    _, _, legacy, relaxed = accounting({"umaal": 2, "veor": 1})
    assert (legacy, relaxed) == (3, 2), (legacy, relaxed)
