# Artifact evaluation guide

This public repository accompanies the English LNCS manuscript
**“X-Wing on Cortex-M85: Architecture-Aware Integration and End-to-End
Evaluation.”** It is a research and reproducibility corpus, not a production
cryptographic library.

> [!WARNING]
> This GitHub repository is **not anonymous**: its owner and Git history identify
> the author. Use this URL only when the review policy permits author disclosure.

## Start here

1. Read the [English manuscript PDF](paper/lncs_new_en/main.pdf) or its
   [LaTeX source](paper/lncs_new_en/main.tex).
2. Read the preregistered [primary same-ELF A/B result](measure-harness/2026-08-31_expDJ_final_same_elf_results.md).
3. Inspect the [frozen expDJ evidence](measure-harness/artifacts/2026-08-31_expDJ/):
   firmware, map, SREC, five raw captures, flash readback, harness, and source
   snapshot.
4. Use the [full reproducibility guide](paper/ARTIFACT_README.md) for the
   remaining experiments, limitations, and optional deterministic replay.

## Primary result

The final B8 implementation was compared directly with the initial A0
implementation in the same ELF on one Renesas EK-RA8M1 (Cortex-M85, 480 MHz).
Five independent reflashes produced ten paired AB/BA comparisons.

| Operation | Minimum observed cycle reduction |
|---|---:|
| Key generation | **19.52%** |
| Encapsulation | **19.75%** |
| Decapsulation, expanded-key reuse | **11.66%** |
| Decapsulation, including key expansion | **15.48%** |

Stage-1 reductions of 11.22--25.96% and Stage-2 reductions of 0.928--4.228%
are attribution evidence. They are not added to or multiplied with the direct
A0-versus-B8 result.

## Fast checks without hardware

From the repository root, with Python 3:

```powershell
python .\measure-harness\artifacts\2026-08-27_expCK_fiatx4_slot_accounting\test_jlink_icount_frozen_af.py
python .\measure-harness\summarize_expCL.py
```

The first command runs three tests and ends with `OK`. The second prints the
frozen one-job and two-job F/U summaries. Neither command regenerates or
replaces the board measurements.

## What requires hardware

Reproducing cycle measurements requires an EK-RA8M1, the recorded Renesas/J-Link
toolchain, and the frozen ELF/SREC images. The repository contains the exact
measurement inputs and raw outputs, but it does not claim that emulation
reproduces Cortex-M85 cycle counts.

The main limits are one physical M85 board, no controlled power-cycle study,
unusable PMU stall-class events, no external best-known M85 baseline, and no
power/energy measurement. These limits are stated in the manuscript and the
reproducibility guide.

## Repository map

| Path | Purpose |
|---|---|
| [`paper/lncs_new_en/`](paper/lncs_new_en/) | Current English manuscript, bibliography, figure sources, and rendered PDF |
| [`measure-harness/`](measure-harness/) | Preregistrations, scripts, result reports, raw logs, and frozen board artifacts |
| [`slothy-2stream/`](slothy-2stream/) | Scheduling experiments and deterministic replay support |
| [`pqmx-mve-ntts/`](pqmx-mve-ntts/) | Pinned pqmx MVE-NTT working tree (Git submodule) |
| [`pqmx-upstream/`](pqmx-upstream/) | Pinned upstream pqmx comparison tree (Git submodule) |

Clone with submodules:

```bash
git clone --recurse-submodules https://github.com/rhcp030418/xwing-cortex-m85.git
cd xwing-cortex-m85
```

No repository-wide license is currently granted. Third-party material retains
its own license and redistribution terms.
