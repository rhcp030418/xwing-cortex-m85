"""Reproducible CP-SAT setup used by the published Slothy drivers.

Slothy already forwards ``config.solver_random_seed`` to OR-Tools.  OR-Tools,
however, uses an automatic worker count when ``num_workers`` is left at zero.
That is one source of host dependence in a time-bounded search.  This module
keeps the Slothy model and objective unchanged, fixes solver execution to one
worker before Slothy constructs its ``CpSolver`` instance, and requires a fixed
Python hash seed.  A wall-clock timeout can still stop a merely FEASIBLE search
at a host-dependent point, so determinism must be checked by repeated output
comparison rather than assumed.
"""

from __future__ import annotations

import hashlib
import importlib.metadata
import json
import os
from pathlib import Path
import subprocess

from ortools.sat.python import cp_model


def _sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def _git_commit(path: Path) -> str:
    try:
        return subprocess.check_output(
            ["git", "-C", str(path), "rev-parse", "HEAD"],
            text=True,
            stderr=subprocess.DEVNULL,
        ).strip()
    except (OSError, subprocess.CalledProcessError):
        return "unavailable"


def force_single_worker(seed: int = 42) -> dict[str, object]:
    """Fix CP-SAT to one worker and return a machine-readable run manifest."""

    python_hash_seed = os.environ.get("PYTHONHASHSEED")
    if python_hash_seed != "0":
        raise RuntimeError(
            "deterministic replay requires PYTHONHASHSEED=0 before Python starts"
        )

    original_solver = cp_model.CpSolver

    class SingleWorkerCpSolver(original_solver):
        def __init__(self) -> None:
            super().__init__()
            self.parameters.num_workers = 1

    cp_model.CpSolver = SingleWorkerCpSolver

    import slothy

    slothy_root = Path(slothy.__file__).resolve().parents[1]
    core_config = slothy_root / "slothy" / "core" / "config.py"
    core_solver = slothy_root / "slothy" / "core" / "core.py"
    return {
        "event": "CP_SAT_REPRO_CONFIG",
        "ortools_version": importlib.metadata.version("ortools"),
        "slothy_commit": _git_commit(slothy_root),
        "python_hash_seed": python_hash_seed,
        "solver_random_seed": seed,
        "solver_num_workers": 1,
        "slothy_config_sha256": _sha256(core_config),
        "slothy_core_sha256": _sha256(core_solver),
    }


def print_manifest(manifest: dict[str, object]) -> None:
    print(json.dumps(manifest, sort_keys=True), flush=True)
