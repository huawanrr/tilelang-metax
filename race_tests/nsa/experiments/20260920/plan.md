# NSA optimization, 2026-09-20

Baseline: `nsa.py` md5 0328e2a2808905035f610d2967083872, v15 plus disabled
kv_split. Existing evidence and rejected directions: `../../NOTES.md` §§1–25.

Contract: forward sparse grouped attention; contiguous fp16 Q/K/V and output,
int32 block indices (public wrappers also convert int64/noncontiguous indices),
G=16 in the supplied 109 cases; S=1/2/4/8, D=32/64/128, BS=16/32/64.
Honor causal/noncausal masks, partial blocks, duplicate/invalid blocks, zero
outputs for empty rows, explicit scale and scale=None. Both factory and
run_kernel must agree with the independent float32 reference at atol=rtol=1e-2.
Preserve the reference, supplied tests, numerical tolerance, and input scope.

Environment: `/opt/conda/bin/python`, torch 2.8.0+metax3.5.3.9,
TileLang `/app/tilelang-metax`, MACA 3.5.3, MetaX C500 25% slice (16 GB).
Use `source env.sh`; build skill needs no rebuild for these Python kernel edits.
Baseline compiled with this environment and verified: oj6 109.629 us, oj12
63.503 us, case5 5.563 us, case69 63.593 us. Initial timing artifact:
`/tmp/nsa_baseline_20260920.json`; exact lowering `/tmp/nsa_oj6.cu` and
`/tmp/nsa_oj12.cu` (will archive with results). This is an existing TileLang
baseline; no torch.compile migration is involved.

Draft findings: lowering retains per-vector K/V tail predicates even when the
sequence is a multiple of BS and the block was validated. Online lowering
loads BlockIndices from global memory inside every serial block iteration.
PV shared reads are scalar and the final reduction has a shared-workspace
barrier; those remain secondary inspection targets. Existing numerical clamp
is not a stable softmax for arbitrary large input scores; do not loosen it.

Bounded plan: at most three mechanisms, at most eight configurations total.
1. Prove full-block bounds using the shape divisibility and runtime validity
   branch, allowing the compiler to eliminate redundant K/V predicates.
2. Preload online block indices before the loop to shorten loop dependencies.
3. Select only if lowering reveals a distinct untested cost after 1–2.
No backend edits, external-device code, or changes to the scoring harness.

Work in an independent candidate and preserve an exact baseline snapshot.
Validate before measuring. Compare preallocated run_kernel outputs with CUDA
graphs, 100 calls/replay, 7 samples, 4 rounds alternating module order, same
inputs, no cache flushing, compilation/allocation outside timed replay.
Primary objective: >2% reproducible improvement on a weak case, no >3% material
regression on any affected family, nonnegative full-suite geometric mean.
Noise-sized results do not justify promotion. If no candidate wins, keep v15.

Commands (after source env.sh):
- `python experiment_bench.py ... --cases oj6,oj12,... --dump-source`
- `python verify_nsa.py <candidate> --extras --output <artifact>`
- `python experiments/20260920/compare.py ...` (paired full-suite measurement)
- After promotion, regenerate submission and run `python check_equiv.py`.

Results and final decision will be recorded in `../../NOTES.md` and structured
artifacts alongside this plan. Do not edit a source while its JIT run is active.
