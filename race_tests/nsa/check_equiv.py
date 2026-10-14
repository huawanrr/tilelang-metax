"""Device-code equivalence check between nsa.py and submission.py.

Builds both modules' kernels for representative shapes and compares the
generated device source md5 (NOTES.md §7 requirement before every submit).
"""
import hashlib
import importlib.util
import sys

sys.path.insert(0, "/data/tilelang-metax/race_tests/nsa")
from kernel_source import get_kernel_source


def load(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


paths = sys.argv[1:] or [
    "/data/tilelang-metax/race_tests/nsa/nsa.py",
    "/data/tilelang-metax/race_tests/nsa/submission.py",
]
modules = [load(f"nsa_equiv_{i}", path) for i, path in enumerate(paths)]

# (B, T, H, HQ, D, S, bs, causal, scale) covering bs32-qf / bs16 / bs64 /
# D32 / H2 / S=8 / non-causal
CASES = [
    (8, 1024, 1, 16, 128, 1, 32, True, 0.1),    # oj6
    (4, 1024, 1, 16, 64, 8, 16, True, 0.1),     # oj12
    (2, 256, 1, 16, 128, 4, 32, True, 0.1),
    (1, 256, 1, 16, 32, 1, 16, True, 0.1),      # D32 direct K
    (1, 128, 1, 16, 64, 1, 16, True, 0.1),      # D64 direct K
    (1, 64, 1, 16, 128, 1, 16, False, None),    # D128 direct K
    (2, 512, 1, 16, 64, 1, 64, True, 0.1),      # bs64
    (2, 512, 1, 16, 128, 2, 16, False, 0.1),    # non-causal
    (1, 1024, 1, 16, 64, 1, 32, True, None),    # scale None
    (2, 128, 1, 16, 128, 1, 16, True, 0.1),
    (4, 1024, 1, 16, 64, 2, 16, True, 0.1),   # index-preload S2
    (4, 1024, 1, 16, 64, 4, 16, True, 0.1),   # index-preload S4
    (2, 37, 2, 32, 64, 8, 16, False, None),   # packed tails, H2
    (2, 37, 2, 32, 64, 8, 16, True, None),    # packed causal tail
    (1, 1024, 1, 16, 64, 1, 16, True, 0.1),  # Q shared preload
    (2, 129, 2, 32, 64, 1, 16, False, None),  # Q preload, tail/H2
    (4, 513, 2, 32, 64, 8, 16, False, None),  # alternate accumulators
    (1, 37, 2, 32, 64, 16, 16, False, None),  # S16 keeps one accumulator
]

ok = True
for case in CASES:
    B, T, H, HQ, D, S, bs, causal, scale = case
    hashes = []
    for mod in modules:
        kern = mod._get_kernel(B, T, H, HQ, D, S, bs, causal, scale)
        src = get_kernel_source(kern)
        assert "memcpy_async" not in src and "cp.async" not in src, "prohibited async copy in generated source"
        hashes.append(hashlib.md5(src.encode()).hexdigest())
    same = len(set(hashes)) == 1
    ok &= same
    print(f"B{B} T{T} H{H} D{D} S{S} bs{bs} c{int(causal)}: "
          f"{'EQUIVALENT' if same else 'MISMATCH ' + ' vs '.join(hashes)}")

print("ALL EQUIVALENT" if ok else "FAILED")
sys.exit(0 if ok else 1)
