# expDF preregistration: four architecture-aware micro-gates

Date: 2026-08-31  
Target: EK-RA8M1, Cortex-M85, 480 MHz, GCC 13.2.Rel1, `-O2`  
Baseline source: `2026-08-30_pre-expDE-active-workspace` (byte-identical to the active e2studio project before expDF)

## Fixed protocol

- One firmware contains all four independent A/B cells.
- Every cell first checks byte/value equivalence. Performance is interpreted only when mismatch count is zero.
- DWT CYCCNT measures 100 repetitions per variant. Variant order alternates A/B and B/A by repetition. The reported statistic is the even-sample median, `(x[49] + x[50]) / 2`.
- Two independent flash-and-run captures are required. A performance gate passes only when both captures pass correctness and the candidate median meets the threshold in both captures.
- A failed micro-gate is recorded and stopped. Only passing candidates may be integrated into a complete X-Wing path and compared in a same-ELF A/B experiment.
- No threshold or implementation is changed after seeing board timings; a materially revised implementation receives a new experiment name.

## DF1: X25519 cswap, scalar vs MVE

- A: fixed scalar 16-word conditional swap.
- B: four 128-bit MVE load/xor/and/xor/store chunks using caller-saved Q registers.
- Timed unit: 256 calls, alternating all-zero/all-one masks; divide medians by 256 for presentation.
- Correctness: masks 0 and `0xffffffff`, deterministic non-equal 64-byte operands, exact output match.
- Pass threshold: B is at least 25% faster than A in both captures.
- Integration target after pass: inline ladder cswap body; no per-bit C call.

## DF2: two X25519 affine conversions, independent vs zero-safe batch inversion

- Input is `(num1, den1, num2, den2)` as four canonical field elements.
- A: two independent inversions and two final multiplications.
- B: canonical zero tests, replace zero denominators by one, one product inversion, two recovered inverses, two final multiplications, and zero masks.
- Correctness cases include nonzero random values, one zero denominator, both zero denominators, one, and `p-1`. Outputs are frozen before comparison.
- Pass threshold: B is at least 20% faster than A in both captures, with zero-case equivalence.
- Integration target after pass: a paired fixed/variable X25519 projective-endpoint API used by encapsulation. Low-order/all-zero behavior must remain unchanged.

## DF3: Keccak squeeze unit, bit-interleaved assembly vs direct 64-bit state

- A: current bit-interleaved `KeccakF1600_StatePermute` plus `StateExtractBytes(0,168)`.
- B: compact direct-`uint64_t[25]` Keccak-f[1600] plus direct 168-byte extraction.
- State setup/conversion is outside the timed span.
- Correctness: exact 168-byte output equality for deterministic nonzero states, plus the existing SHA3 KAT at firmware start.
- Structural check: candidate disassembly must contain M85 64-bit shift instructions (`lsll`/`lsrl`).
- Pass threshold: B is faster than A in both captures. Any slowdown fails this prototype.
- Integration target after pass: direct-64 representation throughout the scalar SHAKE path; representation conversion is not admitted in the hot loop.

## DF4: ML-KEM 168-byte rejection/MAC front-end, scalar vs MVE-assisted

- A: scalar 3-byte to two 12-bit unpack, rejection `<3329`, compaction, and deterministic scalar MAC.
- B: MVE gather/unpack/vector rejection in four 3-byte groups, explicit small spill, then the same scalar compaction/MAC.
- Correctness: accepted count, accepted coefficient stream, and MAC accumulator all match for a deterministic block containing boundary values.
- Pass threshold: B is at least 25% faster than A in both captures.
- Integration target after pass: replace only `load_vals`/rejection scheduling in real `matacc`; scalar DSP basemul remains unchanged for the first full-path A/B.

## Full-path acceptance

Each micro-gate winner is integrated separately first. It is retained only if the complete X-Wing operation that consumes it is byte-equivalent, passes smoke/reject/low-order tests as applicable, and improves the same-ELF median in both captures. The final cumulative image contains only individually retained winners and is compared against the current expCJ/expDE implementation.
