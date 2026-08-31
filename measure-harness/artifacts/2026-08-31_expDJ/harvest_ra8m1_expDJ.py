"""Reuse the frozen board transport and apply the expDJ-specific host gate."""

from __future__ import annotations

import re

import harvest_ra8m1_expDE as board


def parse_gate(log: str, fails: int) -> None:
    required = (
        "expDJ correctness full-mm=0 low-mm=0",
        "expDJ timing-mm=0",
        "expDJ CORRECTNESS GATE PASS",
    )
    missing = [value for value in required if value not in log]
    cells = re.findall(
        r"^expDJ cell=(\d) mode=(A0|B8) key=(\d+) encaps=(\d+) warm=(\d+) cold=(\d+)$",
        log,
        re.MULTILINE,
    )
    stacks = re.findall(
        r"^expDJ stack mode=(A0|B8) key=(\d+) encaps=(\d+) warm=(\d+) cold=(\d+) guard=(\d+)$",
        log,
        re.MULTILINE,
    )
    if fails != 0 or missing or len(cells) != 4 or len(stacks) != 2:
        raise SystemExit(
            f"expDJ host gate FAIL: harness_fails={fails} missing={missing} "
            f"cells={len(cells)} stacks={len(stacks)}"
        )
    by_mode = {"A0": [], "B8": []}
    for _, mode, *values in cells:
        by_mode[mode].append(tuple(map(int, values)))
    if len(by_mode["A0"]) != 2 or len(by_mode["B8"]) != 2:
        raise SystemExit(f"expDJ ABBA order/count FAIL: {by_mode}")
    for a0 in by_mode["A0"]:
        for b8 in by_mode["B8"]:
            if any(b >= a for a, b in zip(a0, b8)):
                raise SystemExit(f"expDJ performance gate FAIL: A0={a0} B8={b8}")
    for mode, *values in stacks:
        *used, guard = map(int, values)
        if int(guard) != 0 or any(value == 0 for value in used):
            raise SystemExit(f"expDJ stack gate FAIL: mode={mode} values={values}")
    print("expDJ HOST GATE PASS: A0/B8 all operations, correctness, stack")


board.parse_gate = parse_gate

if __name__ == "__main__":
    raise SystemExit(board.main())

