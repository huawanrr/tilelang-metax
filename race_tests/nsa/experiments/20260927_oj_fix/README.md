# OJ class-definition rejection fix

**2026-09-28 OJ update:** the previously tested wrapper was rejected for assigning
an attribute to a function under RestrictedPython. Both current submissions now
remove that assignment; see `../20260928_guard_fix/README.md` and its manifest.
Earlier local PASS results did not establish full OJ compatibility. Historical
hashes and timing records below refer to the pre-fix sources; device kernel
builders are unchanged by this host-only fix.


OJ rejected the previous submission during source loading with:
`Class definitions are not allowed in user code`. No performance score was
produced. The common local checker mistakenly allowed AST ClassDef nodes.

Replaced `_PackedAttentionKernel` with `_make_packed_attention`, a plain function
factory returning a closure. It captures only compiled kernels and shapes. Every
invocation allocates fresh packed buffers and packs the current K/V before
attention. Both public interfaces and dispatch remain unchanged. No dynamic class
construction, asynchronous copy or external device code is introduced.

`check_submission_nsa.py` now rejects class definitions at every nesting depth.
`reproduced_rejection.log` shows the old submission fails this new check; the
current development and stripped submissions pass known static restrictions.
The official triton_sandbox is not installed locally, so OJ acceptance remains
unverified.

Validation:
- 125 cases against the unchanged float32 reference, both interfaces PASS.
- 12 input refreshes after in-place Q/K/V changes, both interfaces PASS.
- 18 representative shapes: old development source, fixed development source
  and fixed stripped submission generate identical device code.
- AST comparison confirms all GPU kernel builders unchanged.
- No async-copy markers in the generated source of the equivalence cases.

Current files and checkpoints are synchronized. `release_manifest.json` records
hashes. Prior performance measurements are retained in
`../20260927/round2_full.json`; no new OJ score or 87-point achievement is claimed.
