# expDF results: four architecture-aware micro-gates

Target: EK-RA8M1 Cortex-M85, 480 MHz  
Firmware ELF SHA-256: `7AB4168E0BBD79CA0648D82549B862412DFD20649FE11ACB7F9AF0689D5C179A`  
Firmware SREC SHA-256: `4C82E33D97D3CB7C374C9E1FCC25F710BC360BCFCCBB92E8D0E43297721DE54A`

Both independent flash captures produced identical medians. All four micro-tests had zero mismatches, the RFC 7748/SHA3 KAT passed, and `harness_fails=0`.

| Gate | A median | B median | Change | Preregistered verdict |
|---|---:|---:|---:|---|
| DF1 scalar vs MVE cswap, 256 calls | 26,742 | 14,213 | **46.851% faster** | **PASS** (required ≥25%) |
| DF2 two affine conversions vs zero-safe batch | 63,845 | 33,527 | **47.487% faster** | **PASS** (required ≥20%) |
| DF3 interleaved asm vs direct-64 Keccak+squeeze | 6,402 | 29,228 | **356.545% slower** | FAIL |
| DF4 scalar vs MVE rejection/MAC front-end | 719 | 1,089 | **51.460% slower** | FAIL |

DF1 corresponds to 104.461 cycles per scalar cswap and 55.520 cycles per MVE cswap, including equal call-loop overhead. LLVM objdump confirms MVE q-register operations in DF1.

DF3 structurally used 25 LSLL and 25 LSRL instructions (confirmed with LLVM objdump), but the unrolled direct-64 C permutation grew to 1,332 bytes and spilled heavily. The representation win therefore did not offset the permutation cost.

DF4 correctly vectorized gather/unpack/rejection, but predicate handling, two 128-bit spills, and scalar compaction cost more than the compact scalar unpack/MAC loop. It is stopped before real `matacc` integration.

Next step under the preregistered protocol: integrate DF1 and DF2 separately into their real X25519/X-Wing consumers, retain only full-path winners, then run a cumulative same-ELF A/B.
