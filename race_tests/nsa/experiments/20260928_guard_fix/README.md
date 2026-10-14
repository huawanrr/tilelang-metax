# RestrictedPython function-attribute fix, 2026-09-28

Both previously supplied submissions were rejected during warmup. The shared
host factory assigned `run.get_kernel_source = get_kernel_source`. Upstream
RestrictedPython rewrites this to `_write_(run).get_kernel_source = ...`; its
`full_write_guard` refuses the function object, with innermost AttributeError
`function has no attribute __guarded_setattr__`.

Removed the nested diagnostic getter and its assignment from both current
sources. The returned callable only allocates fresh packed buffers, packs the
current K/V inputs, and invokes attention. No attribute writes, dynamic classes,
async copies or guard bypasses were added. Kernel builders are unchanged.
`kernel_source.py` now inspects closures for local diagnostics; submissions do
not import it. The active equivalence and benchmark tools use that helper.
The local source checker rejects attribute stores/deletes and setattr/delattr.
Candidate generators also remove the rejected metadata assignment so it cannot
reappear when regenerating from historical snapshots.

## Real write-guard regression test

`check_restricted_host.py` uses RestrictedPython 8.5 and its unmodified
`full_write_guard`. It compiles the five host functions (factory, dispatch,
index normalization and both public interfaces) under RestrictedPython. Private
helper identifiers are consistently renamed for the upstream compiler's naming
policy. This does not alter attribute/item writes. TileLang JIT builders stay
in their ordinary DSL environment. The original `_KERNEL_CACHE` starts empty in
each restricted namespace, so the first warmup tests wrapper construction.

Both old submissions reproduce exactly the reported innermost AttributeError.
Both fixed submissions pass eight guarded warmup shapes each (16 total), both
interfaces, plus three guarded input refreshes each (6 total). Shapes include
small/large packed S8, S2/S4, S1 direct-K, shared-Q preload, late normalization,
H2, tails, invalid/duplicate indices and scale=None.

This is a focused host-guard reproduction, not the official triton_sandbox
plugin or an OJ acceptance result. The official plugin is unavailable locally.
The test-only dependency is installed under `/tmp/nsa-restrictedpython-8.5`:

```bash
python -m pip install --no-deps --target /tmp/nsa-restrictedpython-8.5 RestrictedPython==8.5
source env.sh
python experiments/20260928_guard_fix/check_restricted_host.py
```

## Reported packing warning

The warning precedes the host exception and is not its cause. The pack kernel
has identical AST before/after the fix and across the two versions.
`check_packing_addresses.py` verifies injectivity, full destination coverage
and exact inverses of both packed mappings for all nine BS/D combinations.
Each CTA has a unique (batch, block, head) destination prefix. Reference tests
exercise the actual generated kernels separately. Race checks were not disabled;
the compiler may continue to warn about the nonlinear index expression.

Old source snapshots are `rejected_current*.py` and `rejected_next*.py`.
`release_manifest.json` records final hashes and validation evidence.
