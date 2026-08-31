# expDH results: expDF winners in current draft-10/expCJ X-Wing

Target: EK-RA8M1 Cortex-M85, 480 MHz  
Baseline: `d10_set_optimizations(1)` (current expCJ cumulative winner)  
ELF SHA-256: `98D620B64816AE63ACFB80FA98A2428FD8AFE12D698E7E08729A2AD29907FA51`  
SREC SHA-256: `AD52D67D628B41BEB0CBA623A53ABAA2DEED414833465E707E7FB030E2297131`

Both independent flash captures passed the RFC 7748/SHA3 KAT, eight deterministic draft-10 equivalence sets, valid/reject warm/cold comparisons, three low-order point comparisons, and `harness_fails=0`.

## Complete-operation medians

| Operation / mode | Run 1 | Run 2 | Improvement vs A |
|---|---:|---:|---:|
| Encaps A: current expCJ | 1,128,441 | 1,128,448 | — |
| Encaps C: MVE cswap only | 1,114,176 | 1,114,177 | 1.264% / 1.265% |
| Encaps B: batch inversion only | 1,095,069 | 1,095,076 | 2.957% / 2.957% |
| Encaps D: both | **1,080,749** | **1,080,740** | **4.226% / 4.228%** |
| Warm decaps A | 839,319 | 839,328 | — |
| Warm decaps MVE cswap | **824,991** | **824,987** | **1.707% / 1.709%** |
| Cold decaps A | 1,553,270 | 1,553,257 | — |
| Cold decaps MVE cswap | **1,538,852** | **1,538,838** | **0.928% / 0.928%** |

The cumulative encaps mode also beats batch alone by 1.308% / 1.309%, so the two retained changes compose rather than merely replacing the same bottleneck.

## Verdict

- Retain MVE cswap: PASS in encaps, warm decaps, and cold decaps.
- Retain zero-safe paired inversion: PASS in encaps.
- Retain cumulative MVE cswap + paired inversion: PASS; it is the fastest complete encaps path in both captures.
- Key generation is unchanged.
- Direct-64 Keccak and MVE rejection/MAC remain rejected by expDF and are not present in this full-path comparison.

The same-ELF harness adds a common scalar/MVE mode lookup to the variable ladder. The measured gains already include that experiment overhead. A production specialization can remove the lookup and scalar fallback, but no unmeasured extra gain is claimed here.
