# expDI preregistration: Cortex-M85 dual-beat X25519 cswap scheduling

Written before build, flash, or board measurement on 2026-08-31.

## Question

Can the retained MVE X25519 `cswap` be improved specifically for the Cortex-M85 two-beat-per-tick pipeline by replacing the four-instruction XOR-mask select with `VPSEL` and arranging SIMD, vector loads, and vector stores so adjacent instructions use overlapping execution groups?

## Frozen comparison

- Board: EK-RA8M1, Cortex-M85 at 480 MHz, ITCM code and DTCM data.
- Parent: measured expDH tree, including the expCJ draft-10 winner, MVE cswap, and zero-safe paired inversion.
- Same ELF modes:
  - A / `xor`: retained expDH XOR-mask MVE cswap.
  - B / `vpsel`: two `VPSEL` operations per 128-bit chunk, otherwise chunk-sequential order.
  - C / `sched`: the same `VPSEL` work, scheduled to alternate SIMD and LD/ST groups and to alternate vector loads and stores where dependencies permit.
- All modes use only caller-saved `q0-q3`, fixed addresses, fixed instruction counts, and no secret-dependent branch or memory access.
- Pre-build source hashes:
  - `expdi_harness.inc`: `E713E8FFC142269CD32AAB270EA03DFCAB737BAF8D96ED6516358C594388E8DA`
  - `stage_expDI.ps1`: `442A0632F2DEDFFEE9045EFE8CAF0782E0F55BB3BC9057020111B38FE3D1B2EC`

The Cortex-M85 Software Optimization Guide states that the core is a two-beat-per-tick MVE implementation; tick1 can overlap tick0 of a following instruction when issue groups and dependencies allow. It also identifies adjacent loads or adjacent stores as suboptimal and recommends interleaving LD/ST with SIMD. This experiment changes only the cswap instruction selection/schedule.

## Measurements

1. Standalone 64-byte cswap: median of 100 measurements, each containing 1,024 calls.
2. PMU diagnostics for the same 1,024-call batch: cycles, retired instructions, total issue stalls, frontend stalls, backend stalls. DWT CYCCNT is disabled during PMU measurement as required by the recovered expDD setup.
3. Complete draft-10 X-Wing encapsulation using paired inversion, warm decapsulation, and cold decapsulation: 100 rotated-order repetitions for A/B/C in one ELF.
4. Two independent flash/readback/capture runs of the frozen ELF/SREC.

## Correctness gates

- Existing RFC 7748 and SHA3 KAT pass.
- Standalone cswap equality for swap masks 0 and all-ones over 16 deterministic input families.
- Eight deterministic draft-10 seeds with exact pk/sk/ct/encaps/warm/cold/reject equality across A/B/C.
- Warm/cold agreement and three low-order X25519 inputs.
- `harness_fails=0` in both captures.

## Decision rule

- C establishes a scheduling gain only if it is correct and improves the standalone median by at least 5% versus B in both captures.
- C replaces the retained expDH cswap only if it also improves complete encapsulation, warm decapsulation, and cold decapsulation versus A in both captures. A sub-0.20% full-path difference is treated as noise and not retained.
- B separates instruction-count reduction from M85-specific schedule gain; PMU counters are diagnostic and do not override the cycle/correctness gates.
- Any failed correctness gate rejects the candidate regardless of speed.
