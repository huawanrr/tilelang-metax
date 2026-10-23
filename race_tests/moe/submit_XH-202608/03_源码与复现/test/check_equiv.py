#!/usr/bin/env python3
"""Prove that `moe.py` and `submission.py` generate the same device code.

`submission.py` is not a byte-identical copy of `moe.py` -- it is the
comment-and-docstring-stripped form, hand-compacted in places -- so the only
meaningful equivalence check is the generated MACA source for the shapes the OJ
actually grades.  `@T.prim_func` parses its own source text, so an AST-level
comparison would not be evidence.

    python check_equiv.py                     # moe.py vs submission.py
    python check_equiv.py a.py b.py

Prints one md5 per graded shape per module and exits non-zero on any mismatch.
"""
import hashlib
import importlib.util
import os
import sys

# The three shapes from the grader's own CHECK-DIAG dumps:
# (hidden, intermediate, experts, padded_tokens, valid_tokens, token_blocks)
GRADED = [
    ("Config1", 2048, 8192, 16, 3072, 2272, 24),
    ("Config2", 7168, 2048, 32, 6144, 4544, 48),
    ("Config3", 7168, 2048, 64, 12288, 9088, 96),
]


def load(path):
    name = "eqmod_" + os.path.basename(path).replace(".", "_")
    spec = importlib.util.spec_from_file_location(name, path)
    mod = importlib.util.module_from_spec(spec)
    sys.modules[name] = mod
    spec.loader.exec_module(mod)
    return mod


def sources(mod):
    out = {}
    for name, hidden, inter, experts, padded, valid, blocks in GRADED:
        block_m, tail_rows = mod._choose_block_m(experts, valid, blocks)
        kernel = mod._get_kernel(hidden, inter, experts, padded, valid, blocks,
                                 block_m, tail_rows)
        src = kernel.get_kernel_source()
        out[name] = (hashlib.md5(src.encode()).hexdigest(), len(src),
                     block_m, tail_rows)
    return out


def main():
    paths = sys.argv[1:] or ["moe.py", "submission.py"]
    per = [(p, sources(load(p))) for p in paths]
    bad = 0
    for name, *_ in GRADED:
        row = [per[0][1][name][0]] + [m[name][0] for _, m in per[1:]]
        same = all(h == row[0] for h in row)
        bad += 0 if same else 1
        first = per[0][1][name]
        print("%-8s block_m=%-4d tail=%-3d %6d chars  %s  %s"
              % (name, first[2], first[3], first[1], row[0][:12],
                 "OK" if same else "MISMATCH " + " ".join(h[:12] for h in row[1:])))
    print("EQUIVALENT" if not bad else "%d shape(s) differ" % bad)
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
