"""Replace S8's shared partial tile with per-wave normalized global additions."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once

HERE = Path(__file__).resolve().parent


def main():
    records = []
    for waves in (2, 4):
        parent = HERE / f"split_s8_w{waves}_fp32_balanced.py"
        original = parent.read_text()
        node = next(n for n in ast.parse(original).body if isinstance(n, ast.FunctionDef)
                    and n.name == "native_sparse_attention_split_blocks_packed")
        body = "".join(original.splitlines(keepends=True)[node.lineno - 1:node.end_lineno])
        tail = body[body.index("            partial = T.alloc_shared"):body.index("    return kernel")]
        total = "(" + " + ".join(f"denominators[{w} * G + m % G]" for w in range(waves)) + ")"
        replacement = f"""            denominators = T.alloc_shared([M], T.float32)
            T.copy(denom, denominators)
            # A CTA owns this complete output tile on every invocation.
            for i, d in T.Parallel(G, D):
                Output[b, token, h * G + i, d] = T.float16(0)
            # Publish denominators and finish zeroing before any atomic add.
            T.sync_threads()
            for m in T.Parallel(M):
                inv[m] = T.if_then_else({total} > 0, 1.0 / {total}, 0.0)
            contribution = T.alloc_fragment([M, D], T.float16)
            T.annotate_layout({{contribution: pv.make_mma_store_layout(contribution)}})
            for m, d in T.Parallel(M, D):
                contribution[m, d] = T.cast(out[m, d] * inv[m], T.float16)
            for m, d in T.Parallel(M, D):
                T.atomic_add(Output[b, token, h * G + m % G, d], contribution[m, d])
"""
        source = replace_once(original, tail, replacement)
        ast.parse(source)
        path = HERE / f"split_s8_w{waves}_atomic.py"
        with path.open("x") as dest:
            dest.write(source)
        records.append(dict(path=path.name, parent=parent.name, waves=waves,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "atomic_merge_assembly.json").write_text(json.dumps(dict(
        variants=records,
        math="Disjoint FP32 partial numerators are divided by the total FP32 denominator, rounded to FP16, and atomically added.",
        initialization="Each output is zeroed once per invocation by its only owning CTA, followed by a CTA barrier.",
        synchronization="One explicit CTA barrier publishes denominators and global output initialization.",
        checks="Race and bounds checks are retained. Ordinary TileLang atomic_add; no asynchronous operations.",
    ), indent=2) + "\n")


if __name__ == "__main__":
    main()
