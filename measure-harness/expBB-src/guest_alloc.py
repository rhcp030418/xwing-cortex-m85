"""실험 CG: 게스트 재물질화 할당기 (스티칭 병합 생성기).

설계: measure-harness/2026-08-27_expCG_guest_alloc_design.md

호스트(fe25519_sqr_bb)는 한 명령도 바꾸지 않는다 — 재정렬조차 없다.
게스트(intt layer67)를 펼쳐 호스트 명령 사이에 끼우되, 게스트가 쓰는 스칼라
레지스터는 "그 지점에서 죽어 있는" 호스트 레지스터를 빌리고, 필요한 값은
그 자리에서 movw/movt 로 재물질화한다.

핵심 불변식:
  값 v 를 지점 j 에서 죽은 레지스터 rF 에 넣으면, 호스트가 rF 를 다시 **쓸 때까지**
  그 값은 유효하다. (죽었다 = 호스트가 읽기 전에 반드시 먼저 쓴다.)
  따라서 "호스트의 다음 rF 쓰기"까지 재물질화를 생략할 수 있다 = 상수 캐시.

생성물: expCG_merged.S  (expcg_p / expcg_a / expcg_b / expcg_c, 프롤로그 동일)
"""
import io
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import resched as R                                            # noqa: E402

GEN = r"C:\Users\cnscj\e2_studio\workspace\blinky\src\gen"
NL = chr(10)
TAB = chr(9)

# lr 은 안전 여유로 제외한다 (설계 §5-2).
REGS = ["r%d" % i for i in range(13)]
# fe25519_sqr_bb 헤더 선언: "in/out r0-r7, clobbers r8-r12/lr".
# 이 가정이 틀리면 조용히 오답이 난다 -> 1,049 벡터 검사가 방어선(사전등록 §7.1).
LIVE_OUT = {"r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7"}

# ---------------------------------------------------------------- 게스트 상수
# 버퍼 배치: [data 0..303][roots 320..703].  베이스는 중앙(+352)에 두어
# MVE 즉시오프셋 범위 (-508..+508, 4의 배수) 안에 전부 들어오게 한다.
DATA_ORG = 0
ROOTS_ORG = 320
BASE_ADJ = 352
GUEST_ITERS = 4

VALUES = {
    "MOD": ["movw {r}, #0xf2ff"],                      # -3329 의 하위 16비트
    "SF": ["movw {r}, #512"],                          # scaling_factor
    "SFT": ["movw {r}, #5040"],                        # scaling_factor_twisted
    "BASE": ["movw {r}, #:lower16:(expcg_buf+%d)" % BASE_ADJ,
             "movt {r}, #:upper16:(expcg_buf+%d)" % BASE_ADJ],
}
CONST_OF = {"r12": "MOD", "r8": "SF", "r9": "SFT"}

# scaling_factor = 512 = 2^9 이고 vmul.S16 은 하위 16비트만 남긴다.
# => `vmul.S16 qd,qn,r8` == `vshl.i16 qd,qn,#9` (즉시값, 스칼라 레지스터 불필요).
# 이 동치는 논거로만 두지 않고 expcg_a0(원본 형태) 와 바이트 비교로 확인한다.
SHL_SUB = re.compile(r"^vmul\.S16\s+(q[0-7])\s*,\s*(q[0-7])\s*,\s*r8$")

# ------------------------------------------------------- 게스트 본문 (46 명령)
# 출처: gen/expw_intt_kyber_1_23_45_67_opt_m85.s  layer67_loop
# (data,off) / (roots,off) 는 펼침 시 절대 오프셋으로 치환된다.
LAYER67 = """
vmla.S16 q3, q4, r12
vldrw.U32 q7, [r0, #48]
vmul.S16 q4, q7, r8
vldrw.U32 q1, [r0, #16]
vqrdmulh.S16 q6, q7, r9
vldrw.U32 q0, [r0]
vmla.S16 q4, q6, r12
vqrdmulh.S16 q6, q1, r9
vsub.U16 q5, q3, q4
vmul.S16 q7, q1, r8
vadd.U16 q4, q3, q4
vmla.S16 q7, q6, r12
vmul.S16 q3, q0, r8
vldrw.U32 q1, [r11, #32]
vqrdmulh.S16 q2, q0, r9
vldrw.U32 q0, [r11, #64]
vmla.S16 q3, q2, r12
vldrw.U32 q2, [r11, #80]
vmul.S16 q0, q5, q0
vadd.U16 q6, q3, q7
vqrdmulh.S16 q5, q5, q2
vldrw.U32 q2, [r11, #48]
vmla.S16 q0, q5, r12
vsub.U16 q5, q3, q7
vmul.S16 q7, q5, q1
vsub.U16 q1, q6, q4
vqrdmulh.S16 q2, q5, q2
vadd.U16 q4, q6, q4
vmla.S16 q7, q2, r12
vldrw.U32 q6, [r11, #16]
vqrdmulh.S16 q5, q1, q6
vsub.U16 q2, q7, q0
vqrdmulh.S16 q6, q2, q6
vldrw.U32 q3, [r11], #(3*32)
vmul.S16 q2, q2, q3
vstrw.U32 q4, [r0], #64
vmla.S16 q2, q6, r12
vstrw.U32 q2, [r0, #-16]
vmul.S16 q1, q1, q3
vldrw.U32 q3, [r0, #32]
vmla.S16 q1, q5, r12
vadd.U16 q5, q7, q0
vqrdmulh.S16 q4, q3, r9
vstrw.U32 q1, [r0, #-32]
vmul.S16 q3, q3, r8
vstrw.U32 q5, [r0, #-48]
"""
# 루프 진입 전 3명령 (q3/q4 를 만든다 — 없으면 iter0 의 첫 vmla 가 쓰레기를 읽는다)
PRELOOP = """
vldrw.U32 q7, [r0, #32]
vmul.S16 q3, q7, r8
vqrdmulh.S16 q4, q7, r9
"""

MEM = re.compile(r"\[(r0|r11)(?:\s*,\s*#(-?[0-9]+))?\]\s*(?:,\s*#\(?([0-9*]+)\)?)?")


def unroll_guest(iters=GUEST_ITERS, use_shl=True):
    """펼친 게스트: [(텍스트({r} 자리표시자), 필요한 값 키 또는 None)]."""
    tmpl = [l.strip() for l in (PRELOOP + LAYER67).splitlines() if l.strip()]
    npre = len([l for l in PRELOOP.splitlines() if l.strip()])
    out = []
    for k in range(-1, iters):          # k=-1 -> 프리루프만
        lines = tmpl[:npre] if k < 0 else tmpl[npre:]
        it = 0 if k < 0 else k
        d, rt = DATA_ORG + 64 * it, ROOTS_ORG + 96 * it
        for ln in lines:
            m = MEM.search(ln)
            if m:
                base, off, inc = m.group(1), int(m.group(2) or 0), m.group(3)
                org = d if base == "r0" else rt
                abs_off = org + off - BASE_ADJ
                assert -508 <= abs_off <= 508, "오프셋 범위 초과: %d" % abs_off
                assert abs_off % 4 == 0
                out.append((MEM.sub("[{r}, #%d]" % abs_off, ln, count=1), "BASE"))
                if inc:                 # 포스트인크리먼트는 imm 에 흡수
                    step = eval(inc)    # "3*32" / "64"
                    if base == "r0":
                        d += step
                    else:
                        rt += step
                continue
            m = SHL_SUB.match(ln)
            if use_shl and m:
                out.append(("vshl.i16 %s, %s, #9" % (m.group(1), m.group(2)), None))
                continue
            need = None
            for reg, key in CONST_OF.items():
                if re.search(r"\b%s\b" % reg, ln):
                    need = key
                    ln = re.sub(r"\b%s\b" % reg, "{r}", ln)
                    break
            out.append((ln, need))
    return out


# ------------------------------------------------------------------ 호스트
def load_host():
    """fe25519_sqr_bb 본문 명령 리스트 (레이블/디렉티브 제외, 순서 불변)."""
    txt = io.open(os.path.join(GEN, "fe25519_sqr_bb.S"), encoding="utf-8",
                  errors="surrogateescape").read().splitlines()
    lo = next(i for i, l in enumerate(txt) if l.strip() == "fe25519_sqr_bb:") + 1
    hi = next(i for i, l in enumerate(txt) if l.strip().startswith(".size"))
    body = []
    for ln in txt[lo:hi]:
        s = ln.split("//")[0].split("/*")[0].strip()
        if not s or s.startswith(".") or s.endswith(":"):
            continue
        body.append(s)
    # 원본은 `pop {pc}` 로 복귀한다. 병합 커널은 vpop {d8-d15} 를 거쳐야 하므로
    # lr 로 받아 두고 EPILOGUE 의 `bx lr` 로 나간다. sp 균형은 그대로다.
    assert body[-1].replace(" ", "") == "pop{pc}", body[-1]
    body[-1] = "pop {lr}"
    return body


# 실험 CI: movw 대신 스택 상수 풀에서 ldr 로 재물질화한다.
# expCG/CH 실측: movw 는 듀얼이슈되지 않아 1.0 cyc 통짜다. T18 은 ldr 이 2/cyc 이고
# 짝지어진다고 한다. 풀은 호스트 프레임보다 위(높은 주소)에 두므로 겹치지 않는다.
POOL = ["BASE", "MOD", "SFT"]
POOL_BYTES = 16                      # 3워드 + 8바이트 정렬 여유


def sp_deltas(body):
    """호스트 명령 i 를 실행한 뒤, 상수 풀까지의 sp 오프셋(바이트)."""
    d, out = 0, []
    for s in body:
        t = s.replace(" ", "")
        if t.startswith("push{"):
            d += 4 * (len(re.findall(r"r1[0-2]|r[0-9]|lr", t)))
        elif t.startswith("pop{"):
            d -= 4 * (len(re.findall(r"r1[0-2]|r[0-9]|lr|pc", t)))
        elif t.startswith("subsp,#"):
            d += int(t.split("#")[1])
        elif t.startswith("addsp,#") or t.startswith("addsp,sp,#"):
            d -= int(t.split("#")[1])
        out.append(d)
    return out


def host_liveness(body):
    """각 삽입점 i(명령 i 뒤)의 free_i, 그리고 명령 i 가 쓰는 레지스터."""
    ins = R.parse(body)
    n = len(ins)
    live_after = [None] * n
    live = set(LIVE_OUT)
    for i in range(n - 1, -1, -1):
        live_after[i] = set(live)
        a = ins[i]
        live = (live - set(a.writes)) | set(r for r in a.reads if r in REGS)
    free = [sorted(set(REGS) - live_after[i]) for i in range(n)]
    writes = [set(a.writes) & set(REGS) for a in ins]
    return free, writes


# ------------------------------------------------------------------ 배치
def merge(host, free, writes, guest, pool=None):
    """호스트 사이에 게스트를 끼운다. 반환: (줄 목록, 리포트 dict).

    할당: 값 v 를 죽은 레지스터 rF 에 재물질화하면 호스트가 rF 를 다시 쓸 때까지
    유효하다. 자리가 없으면 **다음 사용이 가장 먼 값을 축출**한다(Belady).
    """
    m, k = len(host), len(guest)
    # 게스트 인덱스 g 이후 값 v 가 처음 쓰이는 위치
    nxt_use = [{} for _ in range(k + 1)]
    for g in range(k - 1, -1, -1):
        nxt_use[g] = dict(nxt_use[g + 1])
        if guest[g][1]:
            nxt_use[g][guest[g][1]] = g

    def next_write(reg, frm):
        for j in range(frm, m):
            if reg in writes[j]:
                return j
        return m

    def remat_lines(need, reg, h):
        if pool is None:
            return [ln.format(r=reg) for ln in VALUES[need]]
        return ["ldr %s, [sp, #%d]" % (reg, pool[h] + 4 * POOL.index(need))]

    out, g = [], 0
    held = {}                       # reg -> 값 키 (그 지점에서 유효)
    remat = hits = blocked = 0
    free_hist = {}

    def take(fr, need, h, g):
        """need 를 담을 레지스터를 고른다. (reg, 재물질화 필요 여부)"""
        for r in fr:                                  # 이미 들고 있으면 공짜
            if held.get(r) == need:
                return r, False
        idle = [r for r in fr if r not in held]
        if idle:                                      # 빈 자리: 오래 살 것 우선
            return max(idle, key=lambda r: next_write(r, h + 1)), True
        if not fr:
            return None, False
        # 축출: 다음 사용이 가장 먼 값을 담은 레지스터
        return max(fr, key=lambda r: nxt_use[g].get(held[r], k)), True

    for h in range(m):
        out.append(host[h])
        for r in writes[h]:         # 호스트가 덮어쓴 값은 무효
            held.pop(r, None)
        if h == m - 1:              # 마지막 명령 뒤에는 넣지 않는다
            break
        fr = free[h]
        free_hist[len(fr)] = free_hist.get(len(fr), 0) + 1
        quota = (h + 1) * k // m
        while g < quota:
            text, need = guest[g]
            if need is None:
                out.append(TAB + text)
                g += 1
                continue
            reg, need_remat = take(fr, need, h, g)
            if reg is None:
                blocked += 1
                break
            if need_remat:
                for ln in remat_lines(need, reg, h):
                    out.append(TAB + ln)
                    remat += 1
                held[reg] = need
            else:
                hits += 1
            out.append(TAB + text.format(r=reg))
            g += 1

    # 남은 게스트는 마지막 호스트 명령 직전에 넣는다
    if g < k:
        tail = out.pop()
        fr = free[m - 2] if m >= 2 else []
        while g < k:
            text, need = guest[g]
            if need is None:
                out.append(TAB + text)
            else:
                reg, need_remat = take(fr, need, m - 2, g)
                assert reg is not None, "말미에 빈 레지스터가 없다"
                if need_remat:
                    for ln in remat_lines(need, reg, m - 2):
                        out.append(TAB + ln)
                        remat += 1
                    held[reg] = need
                else:
                    hits += 1
                out.append(TAB + text.format(r=reg))
            g += 1
        out.append(tail)

    rep = {"host": m, "guest": k, "remat": remat, "hits": hits,
           "blocked": blocked, "free_hist": free_hist,
           "need": sum(1 for _, n in guest if n)}
    return out, rep


# ------------------------------------------------------------------ 코드 생성
# fe25519_sqr 의 커스텀 ABI: 입출력이 **r0-r7 레지스터**다 (포인터 아님).
# 따라서 r4-r11 을 저장/복원하면 출력이 지워진다 -> 스칼라는 하나도 건드리지 않는다.
# q4-q7(d8-d15) 만 AAPCS 대로 보존하고, q 초기화 베이스는 클로버인 r12 로 잡는다.
PROLOGUE = TAB + (NL + TAB).join([
    "vpush {d8-d15}",
    # expCD §2 의 교훈: q0-q7 을 결정적으로 초기화한다
    "movw r12, #:lower16:expcg_qinit",
    "movt r12, #:upper16:expcg_qinit",
] + ["vldrw.U32 q%d, [r12, #%d]" % (i, 16 * i) for i in range(8)])

EPILOGUE = TAB + (NL + TAB).join(["vpop {d8-d15}", "bx lr"])


def kernel(name, lines):
    return NL.join([
        TAB + ".type %s, %%function" % name,
        TAB + ".global %s" % name,
        name + ":",
        PROLOGUE,
        NL.join(lines),
        EPILOGUE,
        TAB + ".size %s, .-%s" % (name, name),
        "",
    ])


def guest_standalone(guest):
    """A 커널: 원본 레지스터 할당(r0/r11/r8/r9/r12)로 펼친 게스트 — 재물질화 없음."""
    lines = [TAB + "movw r0, #:lower16:(expcg_buf+%d)" % BASE_ADJ,
             TAB + "movt r0, #:upper16:(expcg_buf+%d)" % BASE_ADJ,
             TAB + "movw r8, #512", TAB + "movw r9, #5040",
             TAB + "movw r12, #0xf2ff"]
    for text, need in guest:
        lines.append(TAB + (text.format(r="r0") if need == "BASE"
                            else text.format(r={"MOD": "r12", "SF": "r8",
                                                "SFT": "r9"}[need])
                            if need else text))
    return lines


def hoist(lines, dist=4):
    """실험 CH: 재물질화를 사용처에서 `dist` 만큼 앞으로 끌어올린다.

    expCG 실측: 호스트 스칼라는 0.34 cyc/명령인데 재물질화는 1.15 cyc/명령이었다.
    가설 M1(재물질화 -> MVE 의 RAW 스톨) 이라면 떼어놓으면 회수된다.
    가설 M2(movw 가 bfi 처럼 듀얼이슈 불가) 라면 아무 변화가 없다. 이 커널이 둘을 가른다.

    안전성: rF 는 삽입 시점에 죽어 있었고, 그 사이 어떤 명령도 rF 를 언급하지 않는
    지점까지만 올린다. 그러면 그 지점에서도 rF 의 다음 접근은 여전히 같은 '쓰기' 이므로
    죽어 있다. (movt 는 rF 를 읽으므로 movw 와 한 덩어리로 옮긴다.)
    """
    REGW = {r: re.compile(r"\b%s\b" % r) for r in REGS}
    out = list(lines)
    i = 0
    while i < len(out):
        s = out[i].strip()
        if not s.startswith("movw "):
            i += 1
            continue
        reg = s.split()[1].rstrip(",")
        if reg not in REGW:
            i += 1
            continue
        n = 2 if i + 1 < len(out) and out[i + 1].strip().startswith("movt ") else 1
        bundle = out[i:i + n]
        k, moved = i - 1, 0
        while k >= 0 and moved < dist and not REGW[reg].search(out[k]):
            k -= 1
            moved += 1
        if moved:
            del out[i:i + n]
            out[k + 1:k + 1] = bundle
        i += n
    return out


def shim(name):
    """C 에서 부르기 위한 래퍼: void name_lenn(uint32_t r[8], const uint32_t a[8]).

    fe25519_sqr 계열은 입출력이 r0-r7 레지스터다(포인터 아님) — expAM 의 관례를 따른다.
    P/A/B/C 가 **모두 같은 래퍼**를 쓰므로 래퍼 비용은 차분에서 상쇄된다.
    """
    return NL.join([
        TAB + ".type %s_lenn, %%function" % name,
        TAB + ".global %s_lenn" % name,
        "%s_lenn:" % name,
        TAB + "push {r4-r11, lr}",
        TAB + "sub sp, sp, #12",           # 36+12 = 48 -> 8바이트 정렬 유지
        TAB + "str r0, [sp]",
        TAB + "mov r12, r1",
        TAB + "ldm r12, {r0-r7}",
        TAB + "bl %s" % name,
        TAB + "ldr r8, [sp]",
        TAB + "stm r8, {r0-r7}",
        TAB + "add sp, sp, #12",
        TAB + "pop {r4-r11, pc}",
        TAB + ".size %s_lenn, .-%s_lenn" % (name, name),
        "",
    ])


def pool_pro():
    """상수 풀을 스택에 올린다. r12 는 호스트 진입 전이라 자유롭다(클로버)."""
    ls = [TAB + "sub sp, sp, #%d" % POOL_BYTES]
    for j, key in enumerate(POOL):
        for ln in VALUES[key]:
            ls.append(TAB + ln.format(r="r12"))
        ls.append(TAB + "str r12, [sp, #%d]" % (4 * j))
    return ls


def pool_epi():
    return [TAB + "add sp, sp, #%d" % POOL_BYTES]


def main():
    host = load_host()
    free, writes = host_liveness(host)
    guest = unroll_guest()
    merged, rep = merge(host, free, writes, guest)
    deltas = sp_deltas(host)   # 풀 베이스는 sub sp,#16 직후의 sp+0 이다
    pooled, repP = merge(host, free, writes, guest, pool=deltas)

    parts = [
        "/* 실험 CG: 게스트 재물질화 할당 (생성기: expBB-src/guest_alloc.py).",
        " * 호스트 fe25519_sqr_bb 는 명령 순서·레지스터 모두 원본 그대로다.",
        " * 게스트 intt layer67 x %d 를 죽은 레지스터에 재물질화하며 끼워 넣었다." % GUEST_ITERS,
        " * 재물질화 %d 명령 / 캐시 적중 %d / 스칼라 필요 게스트 %d."
        % (rep["remat"], rep["hits"], rep["need"]),
        " * expcg_c 는 fe25519_sqr 과 동일한 ABI(in/out r0-r7, clobber r8-r12/lr)다.",
        " */",
        TAB + ".syntax unified", TAB + ".thumb",
        TAB + '.section .text, "ax", %progbits', TAB + ".align 4",
        "",
        kernel("expcg_p", []),                    # 프롤로그만 (오버헤드 측정)
        kernel("expcg_a", guest_standalone(guest)),
        kernel("expcg_a0", guest_standalone(unroll_guest(use_shl=False))),
        kernel("expcg_b", [TAB + h for h in host]),
        kernel("expcg_c", merged),
        kernel("expcg_d", hoist(merged)),         # 실험 CH: 재물질화 호이스팅
        kernel("expcg_e", pool_pro() + pooled + pool_epi()),   # 실험 CI: ldr [sp] 풀
    ] + [shim(n) for n in ("expcg_p", "expcg_a", "expcg_a0",
                           "expcg_b", "expcg_c", "expcg_d", "expcg_e")]
    out = os.path.join(GEN, "expCG_merged.S")
    io.open(out, "w", encoding="utf-8", newline=NL).write(NL.join(parts) + NL)

    print("호스트 %d 명령 / 게스트 %d 명령 (스칼라 필요 %d)"
          % (rep["host"], rep["guest"], rep["need"]))
    print("재물질화 %d 명령, 캐시 적중 %d (적중률 %.1f%%), 막힘 %d"
          % (rep["remat"], rep["hits"],
             100.0 * rep["hits"] / max(1, rep["need"]), rep["blocked"]))
    print("삽입점 free 분포:", dict(sorted(rep["free_hist"].items())))
    ins_total = rep["host"] + rep["remat"]
    print("병합 스칼라 총량 %d, MVE %d -> expCE 법칙 예상 누출 %.1f cyc"
          % (ins_total, rep["guest"], 0.34 * ins_total))
    print("  (CG-1 통과선: 재물질화 <= 31)")
    print("CI(풀): 재물질화 %d 명령, 적중 %d (적중률 %.1f%%)"
          % (repP["remat"], repP["hits"],
             100.0 * repP["hits"] / max(1, repP["need"])))
    print("->", out)


if __name__ == "__main__":
    main()
