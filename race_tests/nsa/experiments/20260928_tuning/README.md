# Synchronous tuning while OJ runs, 2026-09-28

Decision: **retain `baseline.py`**. It is a byte-for-byte copy of the fixed
`../20260927_next/selected.py`. None of these 15 probes demonstrates a stable
additional speedup. They are research artifacts, not new submission files.
The two existing OJ source pairs and root checkpoints were not edited.
Last reported OJ score: 86.5; the immediate 87-point target remains unconfirmed.

## Measurement and validation

Every comparison uses `../20260927_next/compare_same_output.py`, the public
`run_kernel` interface, identical input and output pointers across candidates,
four alternating-order rounds, 100 calls per CUDA graph, seven timing samples,
and approximately 40 ms replay warmup. Packing launches are included;
compilation and allocation are excluded. Hardware: MetaX C500 25% slice.
GPU jobs ran serially. Each row is checked against the unchanged float32
reference before timing. All 45 candidate/shape checks passed, with maximum
absolute error 0.001953125.

The three shapes are case80 (B1/T256), case81 (B2/T512), and oj12
(B4/T1024); all are D64, H1/HQ16, S8, BS16, causal. These are focused
screening results, not a full boundary or sandbox validation of the probes.
No probe was selected, so full-suite and RestrictedPython validation were not
repeated. All 15 probes plus the baseline pass `check_submission_nsa.py`.
No asynchronous copies, external device code, classes, attribute writes, or
race-check disabling were introduced. The original pack warning remains.

## Results

Ratios below are geometric means over these three shapes, relative to the
baseline measured in the same run; higher is faster. Small sub-percent
differences are not treated as established improvements.

| Experiment | Variants and ratios | Decision |
| --- | --- | --- |
| Packing layout/threads (`pack.json`) | 64 threads 0.99537x; V output-oriented 1.00150x; K/V output-oriented 128 threads 1.00017x; K/V output-oriented 64 threads 0.99679x | Neutral or slower; retain original packing |
| Multiple packed blocks per CTA (`pack_tiles.json`) | 2 blocks/128 threads 0.93552x; 4/128 0.88496x; 4/256 0.88431x | Reject; individual latency regressions about 4–22% |
| Q-load ordering/lane reduction (`packed_schedule.json`) | Q first 0.99786x; explicit lane reduction 0.99695x; combined 1.00085x | No stable gain |
| Independent QK accumulators (`qk_overlap.json`) | Grouped QK 0.99847x; interleaved QK steps 0.99130x | No stable gain |
| Larger K window/group unrolling (`prefetch_deeper.json`) | Existing window, explicit unroll 0.99724x; depth8 0.95069x; depth8 plus unroll 0.94465x | Reject larger window; retain current loops |

For the largest shape, the final run measured baseline 53.562 us, explicit
unroll 53.460 us, depth8 55.101 us, and depth8 plus unroll 55.489 us.
The 0.19% isolated unroll difference does not justify a new dispatch branch,
especially with regressions on the two smaller shapes.

## Mechanisms inspected

- Original packing loads vectors then scatters V elements. Reorganizing writes
  and reducing CTA count were plausible memory changes but did not improve
  end-to-end time. We did not infer a hardware bottleneck from timings alone.
- Packed attention loads indices before Q. Moving Q first did not reproduce
  the earlier S1 improvement on this different path.
- The packed epilogue emits `AllReduce<SumOp,64,16,0>`. The installed
  `/app/tilelang-metax/src/tl_templates/maca/reduce.h` implements its two
  exchanges with XOR shuffles; this path has no cross-warp shared barrier
  to remove. Explicit shuffles therefore offer less opportunity than the
  earlier S1 scratch-reuse change.
- Generated attention reuses one score accumulator across selected blocks.
  Separate QK accumulators and interleaved QK steps changed the source schedule
  but failed to produce a measured benefit.
- Group loops retain indexed reads from the local indices array. Explicit
  unrolling and an eight-block K window were tested; no register-spill or
  occupancy explanation is claimed without machine-code/profiler evidence.

The optional local KernelWiki checkout was unavailable. Installed MACA
TileLang source and generated device sources were used as the evidence here.
All device dumps are retained next to the JSON reports. `audit.py` records
hashes, focused checks, generated-source markers, and the retain-baseline
decision in `manifest.json`.

Do not repeat these probes unchanged. Further work should use new evidence,
such as the pending OJ per-case timings or a target-specific profile, rather
than assuming these local negative results establish a performance ceiling.
