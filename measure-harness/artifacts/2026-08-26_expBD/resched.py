"""실험 BB: 재정렬 전용 리스트 스케줄러 (레지스터 재할당 없음).

사전등록: 2026-08-26_expBB_x02_reschedule_prereg.md

M85 발행 모델 (expBA 실측):
  - 곱셈(umaal/umull/mul) : 1 cyc, 사이클당 1개
  - ALU/load              : 0.5 cyc, 곱셈과 100% 페어링
  - store                 : 곱셈과 **페어링 불가**, 사이클 단독 점유

의존성:
  레지스터 RAW/WAR/WAW + 플래그(write/read) + 메모리(같은 오프셋만 순서 보존)

명령을 추가·삭제·치환하지 않는다. 순서만 바꾼다.
"""
import re
import sys

NL = chr(10)

MUL = {"umaal", "umull", "umlal", "mul", "mla", "smull", "smlal"}
FLAG_WRITE = {"adds", "adcs", "subs", "sbcs", "movs", "lsls", "lsrs", "asrs",
              "rsbs", "ands", "orrs", "eors", "cmp", "cmn", "tst"}
FLAG_READ = {"adcs", "sbcs", "adc", "sbc"}
STORE = {"str", "strd", "strb", "strh", "stm", "stmia", "push"}
LOAD = {"ldr", "ldrd", "ldrb", "ldrh", "ldm", "ldmia", "pop"}
BARRIER = {"push", "pop"}          # sp 를 바꾸는 것은 고정점
SP_CHANGING = {"push", "pop"}

REG = re.compile(r"\b(r1[0-2]|r[0-9]|sp|lr|pc)\b")


class Insn:
    __slots__ = ("text", "op", "reads", "writes", "rflag", "wflag",
                 "mem_r", "mem_w", "is_mul", "is_store", "idx", "acc")

    def __init__(self, text, idx):
        self.text = text
        self.idx = idx
        body = text.split("//")[0].strip()
        self.op = body.split()[0].lower() if body else ""
        args = body[len(self.op):].strip()
        self.is_mul = self.op in MUL
        self.is_store = self.op in STORE
        self.wflag = self.op in FLAG_WRITE
        self.rflag = self.op in FLAG_READ
        self.acc = set()
        self.reads, self.writes = self._operands(args)
        self.mem_r, self.mem_w = self._mem(args)

    def _operands(self, args):
        reads, writes = set(), set()
        if not args:
            return reads, writes
        # 메모리 오퍼랜드의 베이스는 read
        base = None
        m = re.search(r"\[([^\],]+)", args)
        if m:
            b = m.group(1).strip()
            if REG.fullmatch(b):
                base = b
        outside = re.sub(r"\[[^\]]*\]", "", args)
        regs = REG.findall(outside)
        if self.op in ("push",):
            reads.update(regs); reads.add("sp"); writes.add("sp")
        elif self.op in ("pop",):
            writes.update(regs); reads.add("sp"); writes.add("sp")
        elif self.op in ("stm", "stmia"):
            reads.update(regs)
        elif self.op in ("ldm", "ldmia"):
            if regs:
                reads.add(regs[0]); writes.update(regs[1:])
        elif self.op in ("str", "strd", "strb", "strh"):
            reads.update(regs)
        elif self.op in ("ldr", "ldrd", "ldrb", "ldrh"):
            writes.update(regs)
        elif self.op in ("umaal", "umlal", "smlal"):
            # RdLo, RdHi 는 read+write (= 누산기, latency 1)
            if len(regs) >= 4:
                writes.update(regs[:2]); reads.update(regs)
                self.acc.update(regs[:2])
        elif self.op in ("umull", "smull"):
            if len(regs) >= 4:
                writes.update(regs[:2]); reads.update(regs[2:])
        elif self.op in ("mov", "movs", "movw", "movt"):
            if regs:
                writes.add(regs[0]); reads.update(regs[1:])
        else:                      # adds/adcs/subs/eor/and/orr/lsl/... 3-operand
            if regs:
                writes.add(regs[0]); reads.update(regs)
        if base:
            reads.add(base)
        return reads, writes

    def width(self):
        """다중 워드 명령의 점유 사이클(보수: 레지스터 수)."""
        if self.op in ("push", "pop", "stm", "stmia", "ldm", "ldmia"):
            n = len(REG.findall(re.sub(r"^[^,{]*", "", self.text.split("//")[0])))
            return max(1, n)
        if self.op in ("strd", "ldrd"):
            return 2
        return 1

    def _mem(self, args):
        """[sp,#k] 접근의 (오프셋, 워드수) 집합."""
        r, w = set(), set()
        m = re.search(r"\[sp(?:\s*,\s*#(-?\d+))?\]", args)
        if not m:
            return r, w
        off = int(m.group(1) or 0)
        n = 2 if self.op in ("strd", "ldrd") else 1
        slots = {off + 4 * i for i in range(n)}
        if self.op in STORE:
            w |= slots
        else:
            r |= slots
        return r, w


def parse(lines):
    out = []
    for i, ln in enumerate(lines):
        s = ln.split("//")[0].strip()
        if not s or s.startswith(".") or s.endswith(":"):
            continue
        out.append(Insn(ln.rstrip("\n"), i))
    return out


def latency(prod, cons, reg):
    """expBA + SLOTHY v0.3: MAC 누산기 포워딩은 1, 그 밖의 곱셈 결과는 2."""
    if prod.is_mul:
        return 1 if (reg in cons.acc) else 2
    if prod.op in LOAD:
        return 2
    return 1


def build_deps(ins):
    n = len(ins)
    pred = [dict() for _ in range(n)]
    last_w = {}
    readers = {}
    last_flag_w = None
    flag_readers = []
    mem_last_w = {}
    mem_readers = {}
    for i, a in enumerate(ins):
        for r in a.reads:                      # RAW
            if r in last_w:
                j = last_w[r]
                pred[i][j] = max(pred[i].get(j, 0), latency(ins[j], a, r))
        for w in a.writes:                     # WAW / WAR
            if w in last_w:
                j = last_w[w]
                pred[i][j] = max(pred[i].get(j, 0), 1)
            for j in readers.get(w, ()):
                pred[i][j] = max(pred[i].get(j, 0), 1)
        if a.rflag and last_flag_w is not None:
            pred[i][last_flag_w] = max(pred[i].get(last_flag_w, 0), 1)
        if a.wflag:
            if last_flag_w is not None:
                pred[i][last_flag_w] = max(pred[i].get(last_flag_w, 0), 1)
            for j in flag_readers:
                pred[i][j] = max(pred[i].get(j, 0), 1)
        for o in a.mem_r:
            if o in mem_last_w:
                j = mem_last_w[o]
                pred[i][j] = max(pred[i].get(j, 0), 2)
        for o in a.mem_w:
            if o in mem_last_w:
                j = mem_last_w[o]
                pred[i][j] = max(pred[i].get(j, 0), 1)
            for j in mem_readers.get(o, ()):
                pred[i][j] = max(pred[i].get(j, 0), 1)
        # 갱신
        for r in a.reads:
            readers.setdefault(r, []).append(i)
        for w in a.writes:
            last_w[w] = i
            readers[w] = []
        if a.rflag:
            flag_readers.append(i)
        if a.wflag:
            last_flag_w = i
            flag_readers = []
        for o in a.mem_r:
            mem_readers.setdefault(o, []).append(i)
        for o in a.mem_w:
            mem_last_w[o] = i
            mem_readers[o] = []
        pred[i].pop(i, None)
    return pred


def simulate(ins, pred, order):
    """주어진 순서를 사이클 단위로 모사한다.
       발행 규칙(expBA 실측): 곱셈 1/cyc, 곱셈+ALU 페어링, store 는 단독 점유.
       지연: 곱셈 누산기 1, 그 밖 곱셈 결과 2, load 2, 나머지 1."""
    ready = [0] * len(ins)
    finish = {}
    cyc = 0
    k = 0
    while k < len(order):
        cyc += 1
        issued = 0
        mul_used = False
        blocked = False
        while k < len(order) and issued < 2 and not blocked:
            i = order[k]
            rt = 1
            for pj, lat in pred[i].items():
                if pj in finish:
                    rt = max(rt, finish[pj] + lat)
                else:
                    rt = 10 ** 9
                    break
            if rt > cyc:
                break
            a = ins[i]
            if a.is_store or a.op in ("pop", "ldm", "ldmia"):
                if issued:
                    break
                w = a.width()
                cyc += w - 1
                finish[i] = cyc
                k += 1; issued = 1; blocked = True; continue
            if a.is_mul:
                if mul_used:
                    break
                mul_used = True
            finish[i] = cyc
            k += 1
            issued += 1
        if issued == 0:
            continue                      # 스톨 사이클
    return cyc


def schedule(ins, pred):
    """지연 인지 그리디 리스트 스케줄."""
    n = len(ins)
    nsucc = [0] * n
    for i in range(n):
        for p in pred[i]:
            nsucc[p] += 1
    # 임계 경로 길이 (우선순위)
    height = [0] * n
    for i in range(n - 1, -1, -1):
        for pj, lat in pred[i].items():
            height[pj] = max(height[pj], height[i] + lat)

    done = [False] * n
    remaining = [len(pred[i]) for i in range(n)]
    finish = {}
    order = []
    cyc = 0
    while len(order) < n:
        cyc += 1
        mul_used = False
        issued = 0
        store_taken = False
        for _ in range(2):
            cand = []
            for i in range(n):
                if done[i] or remaining[i]:
                    continue
                rt = 1
                ok = True
                for pj, lat in pred[i].items():
                    if pj in finish:
                        rt = max(rt, finish[pj] + lat)
                    else:
                        ok = False; break
                if not ok or rt > cyc:
                    continue
                a = ins[i]
                if a.is_store and issued:
                    continue
                if store_taken:
                    continue
                if a.is_mul and mul_used:
                    continue
                cand.append(i)
            if not cand:
                break
            best = max(cand, key=lambda i: (height[i], nsucc[i]))
            a = ins[best]
            done[best] = True
            finish[best] = cyc
            order.append(best)
            issued += 1
            if a.is_mul:
                mul_used = True
            if a.is_store:
                store_taken = True
                break
            for j in range(n):
                if not done[j] and best in pred[j]:
                    remaining[j] -= 1
        # remaining 갱신 (곱셈/기타 동시 발행 시 누락 방지)
        for j in range(n):
            if not done[j]:
                remaining[j] = sum(1 for pj in pred[j] if not done[pj])
        if cyc > 100000:
            raise RuntimeError("스케줄 발산")
    return order, cyc


def main(path, out):
    """검증된 블록 방식: push/pop/sub sp 를 고정점으로 두고 그 사이만 재정렬한다.

    전 함수 단일 스케줄도 시험했으나(2026-08-26) 모델이 push/pop 폭을 과대평가해
    baseline 재현이 나빠졌다(sqr 115 vs 실측 96, mul 151 vs 111). 규칙 5에 따라
    baseline 을 재현하는 블록 방식만 쓴다 — sqr 에서 84 + 고정점 12 = 96 으로 일치했다.
    """
    src = open(path, encoding="utf-8").read().splitlines()
    fixed = [k for k, ln in enumerate(src)
             if re.match(r"\s*(push|pop|sub\s+sp|add\s+sp)", ln)]
    blocks, prev = [], 0
    for f in fixed + [len(src)]:
        if f > prev:
            blocks.append((prev, f))
        prev = f + 1
    result = list(src)
    tot_b = tot_a = 0.0
    nmoved = 0
    for (a, b) in blocks:
        chunk = src[a:b]
        ins = parse(chunk)
        if len(ins) < 6:
            continue
        pred = build_deps(ins)
        base = simulate(ins, pred, list(range(len(ins))))
        order, _c = schedule(ins, pred)
        newc = simulate(ins, pred, order)
        tot_b += base
        tot_a += newc
        if order != list(range(len(ins))):
            nmoved += 1
        slots = sorted(ins[k].idx for k in range(len(ins)))
        for pos, k in zip(slots, order):
            result[a + pos] = ins[k].text
    open(out, "w", encoding="utf-8", newline=NL).write(NL.join(result) + NL)
    print("블록 %d개, 재배치된 블록 %d개" % (len(blocks), nmoved))
    print("모델 예측(고정점 제외): %.1f -> %.1f cyc  (%.1f%%)"
          % (tot_b, tot_a, 100.0 * (tot_b - tot_a) / tot_b))
    n0 = len(parse(src)); n1 = len(parse(result))
    print("명령 수: %d -> %d  %s" % (n0, n1, "OK" if n0 == n1 else "*** 불일치 ***"))
    return 0 if n0 == n1 else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1], sys.argv[2]))
