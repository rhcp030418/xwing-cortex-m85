"""검증된 블록 방식 드라이버 (resched.py 의 부품을 그대로 쓴다).

push/pop/sub sp 를 고정점으로 두고 그 사이만 재정렬한다.
전 함수 단일 스케줄도 시험했으나 모델이 push/pop 폭을 과대평가해 baseline 재현이
나빠졌다(sqr 115 vs 실측 96) — 규칙 5에 따라 블록 방식만 쓴다.
"""
import re
import sys

import resched as R

NL = chr(10)
PAT = re.compile(r"\s*(push|pop|sub\s+sp|add\s+sp)\b")


def main(path, out):
    src = open(path, encoding="utf-8").read().splitlines()
    fixed = [k for k, ln in enumerate(src) if PAT.match(ln)]
    blocks, prev = [], 0
    for f in fixed + [len(src)]:
        if f > prev:
            blocks.append((prev, f))
        prev = f + 1

    result = list(src)
    tot_b = tot_a = 0.0
    nsched = 0
    for a, b in blocks:
        ins = R.parse(src[a:b])
        if len(ins) < 6:
            continue
        pred = R.build_deps(ins)
        base = R.simulate(ins, pred, list(range(len(ins))))
        order, _ = R.schedule(ins, pred)
        newc = R.simulate(ins, pred, order)
        tot_b += base
        tot_a += newc
        nsched += 1
        slots = sorted(ins[k].idx for k in range(len(ins)))
        for pos, k in zip(slots, order):
            result[a + pos] = ins[k].text

    open(out, "w", encoding="utf-8", newline=NL).write(NL.join(result) + NL)
    n0, n1 = len(R.parse(src)), len(R.parse(result))
    print("고정점 %d, 블록 %d (스케줄 대상 %d)" % (len(fixed), len(blocks), nsched))
    print("모델 예측(고정점 제외): %.1f -> %.1f cyc  (%.1f%%)"
          % (tot_b, tot_a, 100.0 * (tot_b - tot_a) / tot_b if tot_b else 0.0))
    print("명령 수: %d -> %d  %s" % (n0, n1, "OK" if n0 == n1 else "*** 불일치 ***"))
    return 0 if n0 == n1 else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1], sys.argv[2]))
