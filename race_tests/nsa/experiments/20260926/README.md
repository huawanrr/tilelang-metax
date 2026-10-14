# NSA optimization: 87-point milestone, 2026-09-26/27

## Current constraint (2026-09-27)

The user reminded us that asynchronous copies are prohibited. Treat asynchronous
copies as excluded from this task, including `T.maca_async_copy`, direct
`tl.maca_memcpy_async` intrinsics, and equivalent lower-level forms. Availability
in TileLang is not evidence that the contest allows a mechanism. The async
experiment was stopped; none of its changes were promoted to `nsa.py` or
`submission.py`. The `async_*` and `probe_async*` files are rejected research
artifacts, not submission candidates. Continue with synchronous memory/layout
optimizations only. Do not resume the async direction without an explicit change
to the user's constraint.

Authoritative starting source: `baseline.py`, MD5
`0328e2a2808905035f610d2967083872` (last recorded OJ mean 86.5).
The user set 87 points as the immediate milestone on 2026-09-27. No new OJ
score has been measured; the last known score remains 86.5. The task is active.

Measurement: `compare.py` validates each candidate against the unchanged sparse
float32 reference, preallocates the public `run_kernel` output, captures 100
calls in a CUDA graph, measures 7 replays, and alternates candidate order for
4 rounds. Preprocessing kernels ARE included. Input-dependent tensors are
never reused across calls. Compilation and allocation are outside GPU timing,
as in the original graph benchmark.

On this container/driver, `torch.cuda.Stream()` hangs while initializing its
stream pool (`mxkwAllocRingBuff: ioctl alloc ringbuffer failed -1`). Basic GPU
operations, reference calculations and NSA execution work. A diagnostic stack
localized the failure to `torch/cuda/streams.py:37`. `compare.py` creates one
MACA stream with `mcStreamCreate`, wraps it with `torch.cuda.ExternalStream`,
and uses it for all captures. This workaround is confined to the benchmark;
production source and scoring settings do not contain it. The starting kernel
again measures ~109.5 us on oj6 and ~63.6 us on oj12, matching older records.

## Results obtained so far

| Mechanism | oj6 / baseline | Decision |
| --- | --- | --- |
| Exact-emitter direct K fragment | 120.6 / 109.5 us | Reject |
| Exact-emitter direct V fragment | 270.2 / 109.5 us | Reject |
| Direct K and V | 192.9 / 109.5 us | Reject |
| Prepack V + direct K | 128.1 / 109.5 us | Reject |
| Prepack K/V (S1) | 114.9 / 109.6 us | Reject |
| Prepack Q, with/without K/V packing | slower by ~35–43% | Reject |
| Explicit lane softmax sum, removing scratch barrier | 108.6 / 109.5 us | Only ~1%, no promotion yet |
| Fully unrolled emitter QK/PV | 109.4 / 109.5 us | Neutral |
| Shared V in MMA-packed layout (scalar stores, vector loads) | 189.6 / 109.5 us | Reject |
| Two tokens on independent 64-lane waves per CTA | 115.2 / 109.6 us | Reject on oj6 |

The decisive new result is **S8 K/V prepacking**, where preprocessing overhead
is amortized over the long selected-block list. In `online_combo.json`, the
packed+index-preload path takes 12.59 / 17.56 / 56.94 us versus
16.16 / 21.40 / 63.60 us for cases 80/81/82. This disproves the previous notes'
claim that only new backend capabilities can improve the online kernel.

S2/S4 packing is not consistently useful, so those families retain the original
single kernel plus index preload. `online_final_tune.json` compares those
choices on the large cases. The main source currently incorporates S>=8 packing
and S>1 index preload. Validation of those changes finished: 125 independent
reference cases, both interfaces; 6 repeated-input refresh checks; 12 generated
source equivalence cases. See `verification.json`, `refresh.json`, and
`equivalence.log`.

## Small-grid direct K adopted on 2026-09-27

`selected.py` adds direct global-to-K-fragment loads on S1/BS16/G16 with
B*H*seq_len <= 512/256/128 for D32/D64/D128 respectively. Larger launches
retain their existing paths. The source was copied to `nsa.py` only after:

- `full_selected.json`: all 109 cases correct, geometric mean speedup 1.01928
  against this directory's original 86.5-point source.
- `selected_recheck.json`: 4 alternating-order rounds confirm small-grid gains.
  Cases 47/98 initially appeared slower; their generated source is byte-identical
  to baseline and remeasurement gives 1.001x / 1.006x, consistent with noise.
- `selected_verification.json`: 125 cases PASS, both public interfaces.
- `selected_edges.json`: 18 additional cases PASS, both interfaces, covering
  the three direct-K size thresholds, H2, tails, invalid block indices,
  noncausal mode and scale=None.

`qpreload_gemm.py` and the global direct-V/direct-KV variants were measured and
rejected. New synchronous-only experiments are in `../20260927/`.

Do not edit a module while its JIT verification or benchmark is running.
Keep all shape masks, reference tolerances, scale behavior, invalid/duplicate
block handling and both public interfaces intact.
