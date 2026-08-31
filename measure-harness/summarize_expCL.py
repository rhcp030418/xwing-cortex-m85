"""Validate and summarize the four expCL F/U single-step histograms."""

from __future__ import annotations

import argparse
import json
from pathlib import Path


EXPECTED_ELF = "305d7f40f5289852a5f683073b55d75135115ba7e2061379d31a3a3ef5bc9c60"
TARGETS = {
    "1-job": ("seq4", "fused4", (85196, 85210), (87138, 87168)),
    "2-job": ("seq8", "fused8", (153562, 153576), (163472, 163480)),
}
CLASS_ORDER = (
    "scalar_load_store",
    "scalar_alu_shift",
    "scalar_multiply_mac",
    "mve_load_store",
    "mve_alu_shift",
    "branch_loop",
)


def load_report(logs: Path, target: str) -> dict:
    path = logs / f"2026-08-28_expCL_icount_{target}.json"
    report = json.loads(path.read_text(encoding="utf-8"))
    if not report["completed"] or report["missing_pc_counts"]:
        raise ValueError(f"incomplete report: {path}")
    if report["elf_sha256"].lower() != EXPECTED_ELF:
        raise ValueError(f"wrong ELF in {path}")
    if sum(report["classes"].values()) != report["instructions"]:
        raise ValueError(f"class sum mismatch in {path}")
    if sum(report["mnemonics"].values()) != report["instructions"]:
        raise ValueError(f"mnemonic sum mismatch in {path}")
    if sum(report["pc_counts"].values()) != report["instructions"]:
        raise ValueError(f"PC sum mismatch in {path}")
    return report


def ipc_range(instructions: int, cycles: tuple[int, int]) -> tuple[float, float]:
    return instructions / cycles[1], instructions / cycles[0]


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("logs", type=Path, nargs="?", default=Path(__file__).parent / "logs")
    args = parser.parse_args()

    for label, (f_name, u_name, f_cycles, u_cycles) in TARGETS.items():
        f = load_report(args.logs, f_name)
        u = load_report(args.logs, u_name)
        delta = u["instructions"] - f["instructions"]
        delta_pct = 100.0 * delta / f["instructions"]
        f_ipc = ipc_range(f["instructions"], f_cycles)
        u_ipc = ipc_range(u["instructions"], u_cycles)
        f_vector = tuple(f["classes"].get(name, 0) for name in CLASS_ORDER)
        u_vector = tuple(u["classes"].get(name, 0) for name in CLASS_ORDER)
        print(
            f"{label}: F={f['instructions']} U={u['instructions']} "
            f"delta={delta:+d} ({delta_pct:+.3f}%) "
            f"F_IPC={f_ipc[0]:.6f}--{f_ipc[1]:.6f} "
            f"U_IPC={u_ipc[0]:.6f}--{u_ipc[1]:.6f}"
        )
        print(f"  F classes={f_vector}")
        print(f"  U classes={u_vector}")


if __name__ == "__main__":
    main()
