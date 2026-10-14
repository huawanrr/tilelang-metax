# Isolated synchronous candidates, 2026-09-27

**2026-09-28 OJ update:** the previously tested wrapper was rejected for assigning
an attribute to a function under RestrictedPython. Both current submissions now
remove that assignment; see `../20260928_guard_fix/README.md` and its manifest.
Earlier local PASS results did not establish full OJ compatibility. Historical
hashes and timing records below refer to the pre-fix sources; device kernel
builders are unchanged by this host-only fix.


## Validated next candidate

`selected.py` and its stripped `submission.py` are ready for a subsequent OJ
trial. The current root `nsa.py`, `submission.py` and their checkpoints remain
byte-identical to the OJ class-definition fix. This candidate has no OJ score;
the last observed score remains 86.5 and the immediate target remains 87.

Compared with the current OJ source, `selected_same_output.json` gives
**1.00965080x geometric mean speedup over 109 cases** (four alternating rounds,
the same preallocated output buffer for all modules). Case80: 12.609 -> 11.616
us; case82: 55.942 -> 53.501 us. All packing launches are included.

Validation completed: 125 reference cases plus 44 boundary cases, both public
interfaces; 12 input refreshes; 18 development/submission device-source
comparisons; 109 generated-source async-marker checks. Known static restrictions,
including the OJ class-definition ban, pass. The official sandbox is unavailable
locally, so this is not a claim of official OJ acceptance.

The initial three-module full run used separate output allocations and showed
larger variation on unchanged code. The subsequent full same-output run still
had a 3.27% apparent regression on unchanged case65. Full host-launch and device
sources match on eight such paths. `control_recheck.json` then compared two
independent instances of the current source and the candidate, on seed41 over
six alternating rounds: the current/current control is 1.00037x geometric mean,
and all six candidate cases are faster, including cases4/36/65/97. Raw results
are retained; sub-percent changes should still be treated cautiously.

See `candidate_manifest.json` for exact hashes and evidence. Reproduction:

```bash
source env.sh
python check_submission_nsa.py experiments/20260927_next/selected.py experiments/20260927_next/submission.py
python verify_nsa.py experiments/20260927_next/submission.py --extras --output /tmp/nsa_next_verification.json
python experiments/20260927_next/verify_candidate.py experiments/20260927_next/submission.py --output /tmp/nsa_next_boundaries.json
python check_equiv.py experiments/20260927_next/selected.py experiments/20260927_next/submission.py
python experiments/20260927_next/compare_same_output.py experiments/20260927_oj_fix/nsa.py experiments/20260927_next/selected.py --cases all --rounds 4 --output /tmp/nsa_next_benchmark.json
```


## Fused query grouping: rejected

`grouped_256.py` combines per-selected-block query scanning, prefix-sum token
compaction and attention into one CTA kernel. K/V are retained while processing
matching queries. It uses synchronous operations only.

`grouped256.json`: oj6 109.50 -> 566.31 us; case69 64.04 -> 553.68 us.
Both sampled cases passed the unchanged float32 reference (max absolute error
0.001953125). The prefix-scatter compiler warning was not suppressed. This large
regression rejects the mechanism; the 64/128/512 segment candidates were not run.
No production file adopted this candidate.

These candidates were generated before the OJ class-definition restriction was
reported. They contain the now-rejected host wrapper and are not submission
files. Future candidates must start from the class-free current source.

## Packed K lookahead: candidate

All current candidates are rebased onto the class-free OJ fix. The original
`nsa.py` and `submission.py` remain unchanged while the user runs OJ.

`make_packed_prefetch.py` creates synchronous two-/four-block K-only and K/V
lookahead variants. `packed_prefetch.json` checks the three public S8 shapes;
`prefetch_families.json` extends to 14 shapes, multiple grid sizes, H2,
noncausal tails and S16. All passed the unchanged float32 reference.

- Loading both K and V early is inconsistent and is excluded.
- K-only depth two: small grids improve about 3–10%; grid 1024 is neutral;
  grid 2048 improves about 3%.
- K-only depth four: grid 4096/8192 improves about 4–7% for H1; the H2 case
  is neutral, and the noncausal tail improves about 3%.
- S16 depth two improves on one measured case; retained as research evidence,
  with no S16 dispatch change in the selected candidate.

The selected dispatch uses depth two for S8 grid <=512 or 2048<=grid<4096,
depth four for S8 grid>=4096, and the original loop elsewhere. The compiler
still checks races. Packed-coordinate bijection evidence from the previous
round applies to the unchanged pack kernel. No async operation is used.

## Lane reduction: candidate

The prior explicit lane-reduction result was promising but had only four
shape measurements. `make_lane_reduce.py` rebases it on the current class-free
source and uses an explicit full 64-lane mask with `T.shfl_xor`.
`lane_families.json` measures 23 cases against the current OJ source.

The generated S1 code removes the redundant synchronization before reduction
scratch reuse. The selected candidate enables it for direct-K small grids,
D32/BS16 grid<=1024, and the late-normalized D128/BS32 path. Other families
include measured regressions and keep their original reduction.

`make_selected.py` assembles these two candidates. `selected.py` has completed local validation. The running OJ source remains
stable; this candidate is kept separately for a subsequent trial.

Lane ownership is explicit: thread `i + 16*lane` owns row `i` and columns
`16*k + 4*lane + j` for `lane,j` in 0..3. These sets partition every row for
BS in {16,32,64}. XOR shuffle offsets 32 and 16 exchange only the two lane
bits; the low four row bits stay unchanged. All 64 lanes participate under
a uniform per-query validity guard. This does not remove the shared-memory
barrier needed before loading V; it removes the separate scratch-related
barrier previously inserted for reduction. The reference and tolerances are
unchanged.
