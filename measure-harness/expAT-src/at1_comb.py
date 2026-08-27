"""AT-1: w=3 signed comb 표 생성 + 참조 구현 + 검증.

- Ed25519 extended coords, madd-2008-hwcd-3 (ref10 ge_madd 계보)
- 86 윈도 x 4 엔트리 (radix 8, signed digit -4..4)
- 검증: RFC 7748 KAT + 독립 Montgomery ladder 와 1,000 seed 차분
- field op 실제 호출 수를 세어 사전등록 §3.1 의 "7M+7add" 가정을 확인한다
"""
import os
import secrets
import sys

P = 2**255 - 19
D = (-121665 * pow(121666, P - 2, P)) % P

# ---- field op 계수기 ----
CNT = {"mul": 0, "sqr": 0, "add": 0, "sub": 0}
COUNTING = False


def fmul(a, b):
    if COUNTING:
        CNT["mul"] += 1
    return (a * b) % P


def fsqr(a):
    if COUNTING:
        CNT["sqr"] += 1
    return (a * a) % P


def fadd(a, b):
    if COUNTING:
        CNT["add"] += 1
    return (a + b) % P


def fsub(a, b):
    if COUNTING:
        CNT["sub"] += 1
    return (a - b) % P


def finv(a):
    return pow(a, P - 2, P)


# ---- Ed25519 base point ----
def recover_x(y, sign):
    xx = (y * y - 1) * finv(D * y * y + 1) % P
    x = pow(xx, (P + 3) // 8, P)
    if (x * x - xx) % P != 0:
        x = x * pow(2, (P - 1) // 4, P) % P
    assert (x * x - xx) % P == 0, "no sqrt"
    if x % 2 != sign:
        x = P - x
    return x


BY = 4 * finv(5) % P
BX = recover_x(BY, 0)
B_EXT = (BX, BY, 1, BX * BY % P)


# ---- extended coords ----
def ext_double(pt):
    """일반 doubling — 표 생성 전용(계수기 대상 아님)."""
    x, y, z, _t = pt
    a = x * x % P
    b = y * y % P
    c = 2 * z * z % P
    h = (a + b) % P
    e = (h - (x + y) ** 2) % P
    g = (a - b) % P
    f = (c + g) % P
    return (e * f % P, g * h % P, f * g % P, e * h % P)


def ext_add(p1, p2):
    """일반 addition — 표 생성 전용."""
    x1, y1, z1, t1 = p1
    x2, y2, z2, t2 = p2
    a = (y1 - x1) * (y2 - x2) % P
    b = (y1 + x1) * (y2 + x2) % P
    c = t1 * 2 * D * t2 % P
    d = z1 * 2 * z2 % P
    e, f, g, h = (b - a) % P, (d - c) % P, (d + c) % P, (b + a) % P
    return (e * f % P, g * h % P, f * g % P, e * h % P)


def ext_scalar(pt, n):
    r = (0, 1, 1, 0)
    for bit in bin(n)[2:]:
        r = ext_double(r)
        if bit == "1":
            r = ext_add(r, pt)
    return r


def to_precomp(pt):
    """(y-x, y+x, 2*d*x*y) affine."""
    x, y, z, _t = pt
    zi = finv(z)
    ax, ay = x * zi % P, y * zi % P
    return ((ay - ax) % P, (ay + ax) % P, 2 * D * ax % P * ay % P)


# ---- madd: ref10 ge_madd + p1p1_to_p3 ----
def madd(pt, pre):
    x1, y1, z1, t1 = pt
    ymx, ypx, xy2d = pre
    a = fmul(fadd(y1, x1), ypx)
    b = fmul(fsub(y1, x1), ymx)
    c = fmul(xy2d, t1)
    d = fadd(z1, z1)
    x3, y3 = fsub(a, b), fadd(a, b)
    z3, t3 = fadd(d, c), fsub(d, c)
    return (fmul(x3, t3), fmul(y3, z3), fmul(z3, t3), fmul(x3, y3))


IDENTITY_PRE = (1, 1, 0)

W = 3
NWIN = 86            # 86*3 = 258 >= 255, 최상위 자리가 carry 를 흡수한다
NENTRY = 1 << (W - 1)   # 4


def build_table():
    tab = []
    acc = B_EXT
    for _i in range(NWIN):
        row = []
        cur = acc
        for j in range(NENTRY):
            if j:
                cur = ext_add(cur, acc)
            row.append(to_precomp(cur))
        tab.append(row)
        for _ in range(W):
            acc = ext_double(acc)
    return tab


def recode(k):
    """k -> 86 개 signed radix-8 digit (-4..4)."""
    e = [(k >> (W * i)) & 7 for i in range(NWIN)]
    carry = 0
    out = []
    for i in range(NWIN):
        v = e[i] + carry
        if v > 4:
            v -= 8
            carry = 1
        else:
            carry = 0
        out.append(v)
    assert carry == 0, "top digit overflow"
    assert all(-4 <= d <= 4 for d in out)
    assert sum(d * (8**i) for i, d in enumerate(out)) == k
    return out


def ct_select(row, b):
    """상수시간 모사: 항상 4 엔트리를 전부 훑는다."""
    ymx, ypx, xy2d = 1, 1, 0
    for j in range(NENTRY):
        m = -1 if (j + 1) == b else 0
        ymx = (ymx & ~m) | (row[j][0] & m)
        ypx = (ypx & ~m) | (row[j][1] & m)
        xy2d = (xy2d & ~m) | (row[j][2] & m)
    return (ymx, ypx, xy2d)


def scalarmult_base(tab, k):
    digits = recode(k)
    h = (0, 1, 1, 0)
    for i in range(NWIN):
        d = digits[i]
        pre = ct_select(tab[i], abs(d))
        if d < 0:
            pre = (pre[1], pre[0], (-pre[2]) % P)
        h = madd(h, pre)
    return h


def edwards_to_u(pt):
    _x, y, z, _t = pt
    return (z + y) % P * finv((z - y) % P) % P


def clamp(b):
    b = bytearray(b)
    b[0] &= 248
    b[31] &= 127
    b[31] |= 64
    return bytes(b)


def le(b):
    return int.from_bytes(b, "little")


def enc(u):
    return (u % P).to_bytes(32, "little")


# ---- 독립 참조: RFC 7748 Montgomery ladder ----
def x25519(k_bytes, u_bytes):
    k = le(clamp(k_bytes))
    u = le(u_bytes) & ((1 << 255) - 1)
    x1, x2, z2, x3, z3, swap = u, 1, 0, u, 1, 0
    for t in range(254, -1, -1):
        kt = (k >> t) & 1
        if swap ^ kt:
            x2, x3 = x3, x2
            z2, z3 = z3, z2
        swap = kt
        a, b = (x2 + z2) % P, (x2 - z2) % P
        aa, bb = a * a % P, b * b % P
        e = (aa - bb) % P
        c, d = (x3 + z3) % P, (x3 - z3) % P
        da, cb = d * a % P, c * b % P
        x3 = (da + cb) ** 2 % P
        z3 = x1 * (da - cb) ** 2 % P
        x2 = aa * bb % P
        z2 = e * (aa + 121665 * e) % P
    if swap:
        x2, x3 = x3, x2
        z2, z3 = z3, z2
    return enc(x2 * finv(z2) % P)


BASEPOINT = (9).to_bytes(32, "little")


def main():
    global COUNTING
    tab = build_table()
    print("표 생성 완료: %d 윈도 x %d 엔트리 x 96 B = %d B"
          % (NWIN, NENTRY, NWIN * NENTRY * 96))

    fails = 0

    # RFC 7748 s6.1
    a_sk = bytes.fromhex("77076d0a7318a57d3c16c17251b26645df4c2f87ebc0992ab177fba51db92c2a")
    a_pk = bytes.fromhex("8520f0098930a754748b7ddcb43ef75a0dbf3a0d26381af4eba4a98eaa9b4e6a")
    b_sk = bytes.fromhex("5dab087e624a8a4b79e17f8b83800ee66f3bb1292618b6fd1c2f8b27ff88e0eb")
    b_pk = bytes.fromhex("de9edb7d7b7dc1b4d35b61c2ece435373f8343c85b78674dadfc7e146f882b4f")
    for sk, pk, name in ((a_sk, a_pk, "alice"), (b_sk, b_pk, "bob")):
        got = enc(edwards_to_u(scalarmult_base(tab, le(clamp(sk)))))
        ok = got == pk
        fails += (not ok)
        print("  RFC7748 %-5s pk : %s" % (name, "OK" if ok else "FAIL " + got.hex()))

    # 1,000 seed 차분 대 독립 ladder
    mism = 0
    for _ in range(1000):
        sk = secrets.token_bytes(32)
        got = enc(edwards_to_u(scalarmult_base(tab, le(clamp(sk)))))
        ref = x25519(sk, BASEPOINT)
        mism += (got != ref)
    print("  1,000 seed 차분 (comb vs Montgomery ladder): mismatch=%d" % mism)
    fails += mism

    # clamp 경계
    edge = {
        "all-zero": bytes(32),
        "all-one": b"\xff" * 32,
        "bit254-only": (1 << 254).to_bytes(32, "little"),
        "low3-set": bytes([7] + [0] * 31),
    }
    for name, sk in edge.items():
        got = enc(edwards_to_u(scalarmult_base(tab, le(clamp(sk)))))
        ref = x25519(sk, BASEPOINT)
        ok = got == ref
        fails += (not ok)
        print("  clamp 경계 %-12s : %s" % (name, "OK" if ok else "FAIL"))

    # field op 실측 계수
    for k in CNT:
        CNT[k] = 0
    COUNTING = True
    scalarmult_base(tab, le(clamp(secrets.token_bytes(32))))
    COUNTING = False
    print("\nfield op 호출 수 (scalarmult_base 1회, 최종 inversion 제외):")
    print("  mul=%d  sqr=%d  add=%d  sub=%d" % (CNT["mul"], CNT["sqr"], CNT["add"], CNT["sub"]))
    print("  madd 1회당: mul=%.2f  add+sub=%.2f  (사전등록 가정 7M + 7add)"
          % (CNT["mul"] / NWIN, (CNT["add"] + CNT["sub"]) / NWIN))

    U = {"mul": 115.005, "sqr": 100.006, "add": 30.005, "sub": 36.002}
    arith = sum(CNT[k] * U[k] for k in CNT)
    lookup = NWIN * 948.17
    inv = 254 * U["sqr"] + 11 * U["mul"]
    total = arith + lookup + inv
    cur = 357839
    print("\n실측 단가 x 실측 호출 수 투영:")
    print("  산술        %9.0f cyc" % arith)
    print("  표 조회     %9.0f cyc  (86 x 948.17, AT-0 실측)" % lookup)
    print("  inversion   %9.0f cyc" % inv)
    print("  합계        %9.0f cyc   vs 현행 %d  ->  %+.1f%%"
          % (total, cur, 100.0 * (cur - total) / cur))

    if fails:
        print("\n검증 실패 %d 건 — C 표를 내보내지 않는다." % fails)
        return 1

    out = os.path.join(os.path.dirname(os.path.abspath(__file__)), "x25519_base_table.h")
    with open(out, "w", encoding="utf-8", newline="\n") as f:
        f.write("/* AT-1 생성물: X25519 fixed-base comb 표 (w=%d, %d 윈도 x %d 엔트리).\n"
                " * 엔트리 = (y-x, y+x, 2*d*x*y), 각 32 B little-endian = 96 B.\n"
                " * 생성기: at1_comb.py.  검증: RFC 7748 KAT + 1,000 seed 차분 통과.\n"
                " */\n#ifndef X25519_BASE_TABLE_H\n#define X25519_BASE_TABLE_H\n\n"
                "#include <stdint.h>\n\n#define X25519_COMB_W %d\n#define X25519_COMB_NWIN %d\n"
                "#define X25519_COMB_NENTRY %d\n\n"
                "static const uint32_t x25519_base_comb[X25519_COMB_NWIN]"
                "[X25519_COMB_NENTRY][24] = {\n" % (W, NWIN, NENTRY, W, NWIN, NENTRY))
        for i, row in enumerate(tab):
            f.write("  { /* window %d */\n" % i)
            for pre in row:
                words = []
                for v in pre:
                    bs = (v % P).to_bytes(32, "little")
                    words += [int.from_bytes(bs[o:o + 4], "little") for o in range(0, 32, 4)]
                f.write("    {" + ",".join("0x%08xu" % w for w in words) + "},\n")
            f.write("  },\n")
        f.write("};\n\n#endif\n")
    print("\nC 표 기록: %s (%d B)" % (out, os.path.getsize(out)))
    return 0


if __name__ == "__main__":
    sys.exit(main())
