# Reproducibility artifact

This archive accompanies the Korean LNCS manuscript v32. Its primary result is
the direct initial-A0 versus final-B8 same-ELF improvement: 19.52% key generation,
19.75% encapsulation, 11.66% warm decapsulation, and 15.48% cold decapsulation
across five independent reflashes. The 11.22--25.96% Stage-1 and 0.928--4.228%
Stage-2 results are attribution evidence and are not added or multiplied. The
2024/039 function-stitching work is retained only as evidence for rejecting an
additional optimization candidate. The archive
separates frozen historical evidence from newly regenerated checks; a
regenerated file is not silently substituted for the binary or schedule used
in a board result.

## Contents

- `paper/`: canonical `ko/main.tex`, its PDF, references, build/package scripts,
  the numerical source of truth (`논문_데이터_표.md`), the cumulative historical
  ledger (`데이터_누적_검증대장.md`), the current data-lineage/version ledger
  (`데이터_계보_아티팩트_정합성.md`), the frozen-ELF resource audit
  (`자원_비용_감사.md`), and the ready-to-upload Overleaf ZIP.
- `measure-harness/`: preregistrations, result notes, scripts, frozen firmware,
  flash/readback evidence, instruction histograms, and raw logs.
- `slothy-2stream/`: solver inputs, frozen historical outputs/logs, model patch,
  board-code generators, and deterministic replay driver.
- `ANONYMIZATION.md`: blind-review transformations and original/submitted ELF
  hash mapping. Absolute home/project paths are redacted only in staged text;
  ELF/object debug metadata is stripped only when it contains a private build
  path. Executable load images and the measured SREC files remain unchanged.
- `MANIFEST.sha256`: SHA-256 for every other file in this archive.

Frozen directories preserve measurement-time snapshots. If a duplicated result
note inside `measure-harness/artifacts/` uses older count terminology, the
top-level result note, `paper/논문_데이터_표.md`, and
`paper/데이터_누적_검증대장.md` preserve the correction chain, while
`paper/데이터_계보_아티팩트_정합성.md` provides the current interpretation.
Raw logs, ELF, and SREC files are not rewritten by terminology errata.

## Fast gates

Run from the extracted archive root.

```powershell
python .\measure-harness\artifacts\2026-08-27_expCK_fiatx4_slot_accounting\test_jlink_icount_frozen_af.py
python .\measure-harness\summarize_expCL.py
```

For the 156-instruction CP-SAT replay, use the recorded WSL environment or an
equivalent Slothy checkout and run:

```bash
SLOTHY_ROOT=/path/to/slothy \
SLOTHY_PYTHON=/path/to/slothy/venv/bin/python \
  bash slothy-2stream/run_bmid_repro.sh
```

The gate fixes `PYTHONHASHSEED=0`, CP-SAT seed 42, and one worker, runs two
independent Python processes, and requires byte-identical generated assembly.
The frozen result is documented in
`measure-harness/2026-08-28_expCN_cp_sat_repro_results.md`.

## Hardware-only evidence

Board logs were collected on one EK-RA8M1. Reproducing those measurements needs
the board, the recorded J-Link/Renesas toolchain, and the frozen ELF/SREC. The
archive does not claim that emulation replaces a board cycle measurement. The
measured board has two observed 8-byte write-stuck ITCM granules at `0x18` and
`0xE0`. `artifact/board-src/itcm_pad.c` reserves the first 256 bytes so measured
code starts after `0x100`; accepted runs also passed flash readback and KATs.
This workaround is board-specific and is not evidence for between-device
repeatability. The official draft-10 vector-1 KAT and its flash readback are under
`measure-harness/artifacts/2026-08-28_expCM_d10_full_vector/`.
The five separate reflashes supporting the cumulative draft-10 table are
documented in `measure-harness/2026-08-28_expCY_cumulative_5run_prereg.md` and
`measure-harness/2026-08-28_expCY_results.md`; their raw logs are under
`measure-harness/logs/`.
The direct initial-to-final result is preregistered and reported in
`measure-harness/2026-08-31_expDJ_final_same_elf_prereg.md` and
`measure-harness/2026-08-31_expDJ_final_same_elf_results.md`. Its frozen ELF/SREC,
five raw captures, flash readback evidence, and source snapshot are under
`measure-harness/artifacts/2026-08-31_expDJ/`.
The separate eight-input decapsulation check uses all six valid CU/CW reflashes;
its four within-run A/B cell contrasts are not counted as four independent
samples. The corrected 3,000-sample
fixed/random-ciphertext timing check are documented as expCW/expCX in
`measure-harness/2026-08-28_expCU_CV_CW_CX_results.md`. They are robustness
checks and are not pooled with the primary expCY performance denominator.

The DWT-off expDD build directly measures PMU retired instructions and reports
9.23--27.08% A/B reductions. Its three stall-class events returned zero and are
therefore retained as unsupported-or-misconfigured, not as evidence of zero
stalls. The dispatcher-free expDE builds report same-BSP deployment proxies:
30,760/65,068 bytes nonvolatile and 1,474/3,514 bytes static RAM for A/B. Their
separate board canary images both reached a 10,264-byte maximum high-water mark.
The expDF/DH artifacts record the four micro-gates and the complete-path retention
of MVE cswap and zero-safe paired inversion. The expDI artifact records a
12.883% standalone cswap scheduling gain, but the schedule is rejected because
its cold-path gain is only 0.162--0.163%, below the preregistered 0.20% gate.
Equal retired instruction counts and lower cycles are consistent with a
dual-beat/issue-group hypothesis; unavailable stall events prevent a causal claim.

The expDJ comparison image reports equal A0/B8 path high-water values of
10,360/7,848/7,784/11,448 bytes and zero guard damage. These values include the
common comparison wrapper. Retained Stage-2 linked symbols total a conservative
922-byte code accounting plus 4 bytes of mode state; neither value is an exact
dispatcher-free B8 deployment footprint.

The primary stitching F/U table uses exactly five expCV reflashes plus two expCZ
reflashes. The expCK F/U cells are not part of that primary set; expCK supplies
the separate S/X baseline. The archive also includes the measured 33/43 direct
candidate (expDA), the alias-incorrect full-solver candidate whose cycle values
were discarded (expDB), and the measured Lenngren-y1 end-to-end candidate
(expDC).

## Scope

The artifact does not provide a second Cortex-M85 device, a controlled power
cycle, working PMU stall-class counters, an external best-known M85 baseline,
power/energy measurements, an alias-safe full-solver result, or a public
DOI. Those are explicit manuscript limitations or submission-system tasks, not
silently filled assumptions. It does provide the direct initial-to-final evidence,
the cumulative draft-10 attribution evidence,
the current direct-stitch measurements, and the correctness-failed candidates described above.
The resource audit separates the expCJ combined measurement image from the
expDE dispatcher-free A/B deployment proxies. It does not reinterpret those
proxies as pure-library sizes or cross-platform Pareto values.

`paper/package_artifact.ps1` verifies the manifest after extraction and rejects
the archive unless its manuscript source and PDF hashes equal the current
canonical files. `measure-harness/slot_bound_t18.py` retains the withdrawn
histogram accounting as a non-bound diagnostic and self-checks its minimal
counterexample.
