# Synchronous NSA tuning, 2026-09-27

**OJ update:** the round2 submission was rejected during source loading because
`_PackedAttentionKernel` is a class. The earlier local checker incorrectly allowed
class definitions. Its PASS result did not establish OJ compatibility. Current
production replaces that wrapper with a plain function closure; see
`../20260927_oj_fix/README.md` and its release manifest. This directory preserves
the original performance evidence and rejected snapshot.

Immediate target: 87 OJ points, with 88 remaining the longer-term goal.
Last known OJ result: 86.5. No new score has been measured.
Asynchronous copies and equivalent low-level forms are excluded by the user's
constraint. All candidates here use synchronous TileLang operations.

The starting source is `../20260926/selected.py` (SHA256
`bb0a70dbe057dc3a64d9f650d6a2a5b3a2fdab995036e5f22be37ca12ce63605`).
It was adopted after the 125-case and 18-extra-case checks of both interfaces.
See that directory's README for the packed-S8 and small-grid direct-K changes.

Benchmarks validate against the unchanged float32 sparse reference, then use
preallocated `run_kernel` output, CUDA graphs and ~40 ms GPU warmup. All packing
kernels are timed; compilation/allocation are excluded. Candidate order is
alternated. New modules are never edited during a running test.

## Findings

- `synchronous_candidates.json`: on oj6, baseline 109.48 us; preloading all K
  fragments from shared memory 108.64 us; preloading V 112.05 us; both 110.11 us;
  V preload after softmax 110.38 us. K's small gain needs family-level evidence.
- `aligned_loads.py` uses a true block-alignment bound to remove redundant load
  checks. Correct, but significantly slower (oj6 171.11 us, oj9 55.17 us).
  Rejected; assumptions alone do not guarantee a better compiler schedule.
- `uniform_s1.py` replaces skipped blocks with safe loads and zero attention
  weights, preserving empty-row behavior. Correct on measured cases, but oj6
  126.46 us / baseline 109.41 us. Rejected.
- `online_dual_recheck.json`: independent accumulators on alternating selected
  blocks improve the large S8 case from 57.05 to 56.03 us, but regress the smaller
  cases (12.56 -> 12.83 and 17.52 -> 17.72 us). Additional grid/head/tail cases are
  required before choosing a size gate.
- `gemm_schedule.json`: earlier V store, later normalization and early Q-to-shared
  copy all regress the large D64/BS16 case. Early Q-to-shared improves B1/T1024
  from 8.14 to 7.68 us. Test the medium-grid family before choosing a gate.
- `prefetch_families.json`: further shared-fragment preload measurements;
  at this checkpoint the family is mixed, with gains and regressions.

`check_submission_nsa.py` checks known import/top-level restrictions, the actual
NSA signature and explicitly prohibited asynchronous/external-code calls.
`check_equiv.py` also rejects async-copy markers in generated device source.
These checks supplement the correctness/reference tests; they are not an
independent statement of official contest rules.

## Final selection and validation

`round2.py` was copied byte-for-byte to `nsa.py` after validation. It adds:

- Q-to-shared preload only for S1/D64/BS16/G16 and 256 < grid <= 1024;
  `qshared_families.json` shows gains in that range and losses at >=2048.
- Alternating accumulators only for S8/D64/BS16/G16 and grid >=4096;
  `dual_families.json` checks larger grids, H2, a noncausal tail and S16.
  S16 and smaller grids retain one accumulator.

All shared-K/V fragment prefetch variants, alignment-assumption variants and
uniform-control-flow variants remain excluded: family results are mixed or
slower. `packing_layout_proof.json` exhaustively verifies both packed coordinate
maps and their inverse for 9 tile shapes. The compiler's conservative race
warnings on these bijective stores were not suppressed.

Release checks: 125 reference cases + 30 additional boundary cases, both
interfaces; 12 input refreshes; 18 generated-source equivalence cases with
async-copy rejection; known import/top-level/API restrictions pass. Full 109-case
comparison to the original 86.5-point source gives 1.02535395x geometric mean
speedup, with no measured regression exceeding 3%. The final hashes and artifact
paths are in `release_manifest.json`. No new OJ score is claimed.
