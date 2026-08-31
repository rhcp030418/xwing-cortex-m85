# expDH preregistration: expDF winners in the current draft-10/expCJ path

Target baseline is `d10_set_optimizations(1)`, i.e. the current expCJ cumulative winner, not the older compatibility wrapper measured by expDG.

- Encapsulation modes in one ELF: A=current, C=MVE cswap only, B=paired inversion only, D=both.
- Warm and cold decapsulation modes: A=current scalar cswap, M=MVE cswap. Batch inversion does not apply because decapsulation has one X25519 operation.
- Key generation is unchanged and is not claimed as improved.
- 100 repetitions, rotating/alternating order, even-sample median, two independent flash captures.
- Correctness: RFC 7748/SHA3 KAT; eight deterministic draft-10 seeds; exact pk/sk/ct/enc/warm/cold/reject equality; warm/cold agreement; three low-order X25519 comparisons.
- Retain each optimization only when the applicable complete operation improves in both captures. The cumulative encaps mode must beat both isolated modes.

The experiment-only scalar/MVE dispatch is common to the compared draft-10 paths. A later production build may specialize the retained MVE path and remove dispatch overhead; no projected dispatch saving is included in the expDH verdict.
