# expDG preregistration: full X-Wing integration of expDF winners

The firmware compares four complete encapsulation modes in one ELF with identical deterministic randomness:

- A: current expCJ/expDE X-Wing path, plus the common experiment-only mode check in the variable ladder.
- C: A with MVE cswap only.
- B: A with zero-safe paired inversion only.
- D: paired inversion plus MVE cswap.

Each mode is measured 100 times; order rotates by repetition and the even-sample median is reported. Two independent flash captures are required. RFC 7748/SHA3 KAT, eight-seed exact ciphertext/shared-secret equivalence, candidate round trips, and three low-order point comparisons must all pass.

The cswap or batch candidate is retained only if its isolated complete-encapsulation median is lower than A in both captures. The cumulative mode is retained only if it is lower than every retained isolated mode in both captures. No result from DF3 or DF4 is integrated.
