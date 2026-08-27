"""expBX: **MVE 를 아는** 재정렬 스케줄러.

`resched.py` 의 확장이다. 스칼라 모델은 그대로 두고 MVE 를 두 번째 발행 포트로 넣는다.

측정 근거 (전부 이 프로젝트의 M85 실측):
  - expBA : umaal 1.000 cyc(의존·독립 동일, 처리율 한계), ALU/ldr 0.5, str 발행 차단
  - expBL : shifted-operand ALU 는 평 ALU 와 동일, **bfi 는 페어링 불가(1/cyc)**
  - expBV : **MVE vmul/vadd = 2.000 cyc/명령**, 스칼라와 **은닉률 100%**
            (umaal 64 + vmul 64 = umaal 128 과 같은 시간)

모델:
  * 포트 S (스칼라) : 사이클당 ALU 2개, 곱셈 1개, store/bfi 는 단독 점유
  * 포트 V (MVE)    : **2 사이클당 1개** (2-beat)
  * 두 포트는 **완전히 독립** — 같은 사이클에 S 와 V 가 동시에 나간다 (expBV)
  * 레지스터 파일이 분리돼 있어(r0-r12 vs q0-q7) 두 스트림 사이 의존은
    메모리와 vmrs/vmov 류를 통해서만 생긴다.

명령을 추가·삭제·치환하지 않는다. 순서만 바꾼다.
"""
import re
import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import resched as R

NL = chr(10)

VREG = re.compile(r"\bq[0-7]\b")
MVE_OP = re.compile(r"^v[a-z][a-z0-9.]*$")
# 스칼라 <-> 벡터 경계를 넘는 명령(양쪽 파일을 다 건드린다)
XFER = re.compile(r"^(vmov|vmrs|vmsr|vdup|vldr|vstr|vctp)")

MVE_RATE = 2.0          # expBV 실측: 2.000 cyc/명령
NO_PAIR_SCALAR = {"bfi", "bfc"}   # expBL 실측


class VInsn(R.Insn):
    """MVE 인식을 더한 Insn."""
    __slots__ = ("is_mve", "vreads", "vwrites", "no_pair")

    def __init__(self, text, idx):
        R.Insn.__init__(self, text, idx)
        self.is_mve = bool(MVE_OP.match(self.op))
        self.no_pair = self.op in NO_PAIR_SCALAR
        body = text.split("//")[0].split("@")[0].strip()
        args = body[len(self.op):].strip() if body else ""
        vs = VREG.findall(args)
        self.vreads, self.vwrites = set(), set()
        if vs:
            first = args.split(",")[0].strip()
            if VREG.fullmatch(first):
                self.vwrites.add(first)
                self.vreads.update(v for v in vs if v != first)
            else:
                self.vreads.update(vs)
        # 벡터 레지스터도 일반 의존 추적에 태운다
        self.reads |= self.vreads
        self.writes |= self.vwrites


def parse(lines):
    out = []
    for k, ln in enumerate(lines):
        t = ln.split("//")[0].split("@")[0].strip()
        if not t or t.startswith(".") or t.endswith(":"):
            continue
        out.append(VInsn(ln, k))
    return out


def latency(prod, cons, reg):
    """expBB 모델 + MVE.  MVE 결과 지연은 2-beat 를 반영해 2 로 둔다(미측정 — §한계)."""
    if getattr(prod, "is_mve", False):
        return 2
    return R.latency(prod, cons, reg)


def build_deps(ins):
    old = R.latency
    R.latency = latency
    try:
        return R.build_deps(ins)
    finally:
        R.latency = old


def simulate(ins, pred, order):
    """포트 S 와 포트 V 를 독립으로 모사한다."""
    finish = {}
    cyc = 0
    k = 0
    v_busy_until = 0            # MVE 포트가 비는 사이클
    n = len(order)
    guard = 0
    while k < n:
        cyc += 1
        guard += 1
        if guard > 100000:
            break
        s_slots = 2             # 스칼라 발행 슬롯
        mul_used = False
        s_blocked = False
        progressed = True
        while progressed and k < n:
            progressed = False
            i = order[k]
            rt = 1
            ok = True
            for pj, lat in pred[i].items():
                if pj in finish:
                    rt = max(rt, finish[pj] + lat)
                else:
                    ok = False
                    break
            if not ok or rt > cyc:
                break
            a = ins[i]
            if a.is_mve:
                if cyc < v_busy_until:
                    break
                v_busy_until = cyc + MVE_RATE
                finish[i] = int(cyc + MVE_RATE - 1)
                k += 1
                progressed = True
                continue
            # --- 스칼라 ---
            if s_blocked or s_slots == 0:
                break
            if a.is_store or a.op in ("pop", "ldm", "ldmia") or a.no_pair:
                if s_slots < 2:
                    break
                w = a.width() if hasattr(a, "width") else 1
                cyc += w - 1
                finish[i] = cyc
                k += 1
                s_slots = 0
                s_blocked = True
                progressed = True
                continue
            if a.is_mul:
                if mul_used:
                    break
                mul_used = True
            finish[i] = cyc
            k += 1
            s_slots -= 1
            progressed = True
    return cyc


def schedule(ins, pred):
    """지연 인지 그리디. resched.schedule 을 그대로 쓰되 simulate 만 교체된다."""
    return R.schedule(ins, pred)


def report(lines, label=""):
    ins = parse(lines)
    pred = build_deps(ins)
    base = simulate(ins, pred, list(range(len(ins))))
    order, _ = schedule(ins, pred)
    new = simulate(ins, pred, order)
    nmve = sum(1 for a in ins if a.is_mve)
    print("%s: %d 명령 (MVE %d)  baseline %.1f -> 재정렬 %.1f  (%.1f%%)"
          % (label or "block", len(ins), nmve, base, new,
             100.0 * (base - new) / base if base else 0.0))
    return ins, pred, order, base, new


if __name__ == "__main__":
    src = open(sys.argv[1], encoding="utf-8").read().splitlines()
    report(src, sys.argv[1])
