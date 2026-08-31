# expDI results: Cortex-M85 dual-beat X25519 cswap scheduling

Target: EK-RA8M1 Cortex-M85, 480 MHz  
Parent: expDH draft-10 winner with paired inversion  
ELF SHA-256: `B61A29B1B08CEE78B811A1902E07538FB293BC5D685433063F110F1DBBBFAE89`  
SREC SHA-256: `40C2B9A60AA9C531A108448044FE7D511CD4E268ADD91DFF12551E9FA6DD3CFF`

Both independent flashes had identical code readback, passed the RFC 7748 and SHA3 KATs, and reported `micro-mm=0 full-mm=0 low-mm=0 harness_fails=0`.

## Standalone cswap

Each cell is the median cycle count for 1,024 calls. Both captures were identical.

| Mode | Run 1 | Run 2 | Change |
|---|---:|---:|---:|
| A: retained XOR mask | 67,656 | 67,656 | baseline |
| B: sequential VPSEL | 63,555 | 63,555 | 6.062% faster than A |
| C: M85 overlap schedule | **55,367** | **55,367** | **12.883% faster than B; 18.164% faster than A** |

The preregistered scheduling gate passes: C beats B by more than 5% in both captures.

## PMU diagnostic

Per-call integer averages from a 1,024-call batch were identical in both captures.

| Mode | cycles | retired instructions | stall-op | frontend | backend |
|---|---:|---:|---:|---:|---:|
| A | 66 | 41 | 0 | 0 | 0 |
| B | 62 | 33 | 0 | 0 | 0 |
| C | **54** | **33** | 0 | 0 | 0 |

B and C retire the same number of instructions, but C needs eight fewer cycles. This isolates the gain from M85 issue-group/dual-beat overlap rather than instruction-count reduction. The zero stall-event values are not used as evidence because these PMU events did not distinguish the schedules on this device.

## Complete draft-10 X-Wing paths

All modes use paired inversion. A/B/C selection is inside the same ELF and rotated over 100 repetitions.

| Operation | A run 1 / run 2 | B run 1 / run 2 | C run 1 / run 2 | C vs A |
|---|---:|---:|---:|---:|
| Encapsulation | 1,085,349 / 1,085,352 | 1,084,324 / 1,084,326 | **1,082,799 / 1,082,798** | **0.235% / 0.235%** |
| Warm decapsulation | 829,242 / 829,242 | 828,206 / 828,196 | **826,677 / 826,677** | **0.309% / 0.309%** |
| Cold decapsulation | 1,542,029 / 1,542,021 | 1,541,023 / 1,541,021 | **1,539,520 / 1,539,516** | **0.163% / 0.162%** |

The experiment-only second mode lookup is common to A/B/C but makes all three absolute totals slower than the prior expDH production candidate. Only same-ELF deltas are used here.

## Verdict

- **M85 scheduling hypothesis: PASS.** At equal retired instruction count, the dual-beat-aware order reduces standalone cswap cycles by 12.883% versus sequential VPSEL.
- **Full-path retention gate: FAIL.** Encapsulation and warm decapsulation exceed the 0.20% threshold, but cold decapsulation improves by only 0.162-0.163%.
- Per the preregistration, expDI does not replace expDH as the retained configuration. The result is useful microarchitectural evidence, but the cswap share of complete X-Wing is now too small for this schedule alone to clear all end-to-end gates.

After freezing the expDI artifacts, the active project was restored and rebuilt byte-identically to expDH: ELF `98D620B64816AE63ACFB80FA98A2428FD8AFE12D698E7E08729A2AD29907FA51`, SREC `AD52D67D628B41BEB0CBA623A53ABAA2DEED414833465E707E7FB030E2297131`.
