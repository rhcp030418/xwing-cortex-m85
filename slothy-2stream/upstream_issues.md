# SLOTHY 상류 이슈 리포트 초안 3건 (2026-08-17)

> 제출 전 사용자 검토 필요. 각 건은 우리 패치/생성기의 우회책과 함께 발견 —
> 재현 재료는 artifact/·slothy-2stream/에 있음. 제출처: github.com/slothy-optimizer/slothy

---

## Issue 1 — Arm v8.1-M: scalar dual-issue not modeled (Cortex-M85 issue_rate)

**Summary.** The Cortex-M85 uarch model uses `issue_rate = 1`. M85 is a dual-issue
in-order core for scalar code; schedules produced with the current model
underestimate achievable IPC by up to 2x for scalar-heavy kernels.

**Evidence (silicon, EK-RA8M1).** A 17-instruction two-stream kernel scheduled with
`issue_rate = 2` + a second scalar unit predicted 9 cycles (IPC 1.89); board
measurement: 11.07 cyc/iter including loop overhead — <1% error. With the stock
model the same kernel cannot be scheduled below IPC 1.0.

**Suggested fix.** `issue_rate = 2` with an additional scalar ALU unit; MAC
(umull/umaal/mul) and LSU capped at one per cycle. Our patch (attached) does this
minimally. Caveat we also observed: real pairing rules are narrower than
"any 2 per cycle" — an accurate model needs TRM pairing constraints (we measured a
27% gap on a 1,222-instruction scalar x MVE co-issue kernel).

---

## Issue 2 — ldrd/strd treated as 4-byte accesses in memory dependency analysis

**Summary.** Doubleword loads/stores appear to be modeled as single-word accesses,
so the dependency analysis misses overlaps on the high word. Reordering can then
break memory semantics silently.

**Evidence.** In a 1,184-instruction kernel with stack spills, the optimized
schedule corrupted 8 words of output. Splitting every `ldrd/strd` into two
`ldr/str` before invoking SLOTHY reduced corruption to 4 words (remaining
corruption was Issue 3). Note the split itself has a base-clobber hazard:
for `ldrd rA, rB, [rA]` the load into the base register must be emitted last.

**Suggested fix.** Model doubleword accesses as 8-byte ranges (or two accesses)
in the memory dependency graph.

---

## Issue 3 — Spill-slot reuse: WAR/WAW anti-dependencies on stack slots not preserved

**Summary.** Compiler-generated code commonly reuses the same `[sp, #k]` slot for
different values over time. SLOTHY's reordering does not preserve write-after-read /
write-after-write ordering on such slots, so a later store can be hoisted above an
earlier load of the previous value.

**Evidence.** Same 1,184-instruction kernel as Issue 2: after the ldrd/strd split,
4 output words remained corrupted. Rewriting the input so that every store gets a
unique spill offset (34 slots uniquified) made the schedule fully correct with the
same predicted cycle count — isolating slot reuse as the cause.

**Suggested fix.** Track store/load intervals per stack offset and add
anti-dependency edges on reuse. (Workaround for users: uniquify spill slots —
mechanical and semantics-preserving for straight-line code.)

---

### 공통 첨부물 체크리스트 (제출 시)

- [ ] patch_slothy_v81m.py (v0.1~0.3) 최소 재현 diff로 축약
- [ ] Issue 2·3: bfull 재료(mul256_flat + round6) 최소 재현 케이스로 축약
- [ ] 보드 수치는 참고로만 (재현은 스케줄 결과의 메모리 의존성 위반으로 충분)
