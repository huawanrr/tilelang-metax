"""Load one/two packed K reduction slices at a time using local MMA operands."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once
from make_v_only_packed import extract

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / "20261002_mid_v1/submission.py"


def load_slice(name, index, indent):
    pad = " " * indent
    return f"""{pad}for kj in T.unroll(BS // 16):
{pad}    for e in T.vectorized(8):
{pad}        {name}[kj * 8 + e] = K[b, block, h, {index}, kj, tid, e]
"""


def main():
    original = BASE.read_text()
    old = extract(original, "native_sparse_attention_single_packed_qo_v2")
    records = []
    for prefetch in (1, 2):
        for early in (False, True):
            fn = old
            fn = replace_once(fn, "            k = T.alloc_fragment([BS, D], T.float16)",
                "            tid = T.get_thread_binding()\n"
                "            kb0 = T.alloc_local([BS // 16 * 8], T.float16)\n"
                + ("            kb1 = T.alloc_local([BS // 16 * 8], T.float16)" if prefetch == 2 else ""))
            fn = replace_once(fn, "                k: qk.make_mma_load_layout(k, 'B'),\n", "")
            initial = """                for j, d in T.Parallel(BS, D):
                    k[j, d] = K[b, block, h, d // 32, j // 16,
                        (d % 32 // 8) * 16 + j % 16, d % 8]
"""
            first = ""
            if early:
                first = load_slice("kb0", "0", 16)
                if prefetch == 2:
                    first += load_slice("kb1", "1", 16)
            fn = replace_once(fn, initial, first)
            loop = f"                for kg in T.unroll(D // (32 * {prefetch})):\n"
            if early:
                loop += "                    if kg > 0:\n"
            indent = 24 if early else 20
            loop += load_slice("kb0", f"kg * {prefetch}", indent)
            if prefetch == 2:
                loop += load_slice("kb1", "kg * 2 + 1", indent)
            loop += f"                    qk.mma(q, kb0, scores, kg * {prefetch})\n"
            if prefetch == 2:
                loop += "                    qk.mma(q, kb1, scores, kg * 2 + 1)\n"
            fn = replace_once(fn, """                for ki in T.serial(D // 32):
                    qk.mma(q, k, scores, ki)
""", loop)
            result = replace_once(original, old, fn)
            ast.parse(result)
            path = HERE / f"bs32_kstream_p{prefetch}_{'early' if early else 'compute'}.py"
            with path.open("x") as f:
                f.write(result)
            records.append(dict(path=path.name, prefetch=prefetch, first_load_before_q_staging=early,
                                sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "bs32_kstream_assembly.json").write_text(json.dumps(dict(
        baseline=str(BASE), variants=records,
        changes="Same MMA calls, operands, and accumulation order. One or two local K slices instead of the full D128 fragment.",
        preserved="Packing, host dispatch, Q/output staging, bounds/race checking, and explicit synchronization.",
    ), indent=2) + "\n")


if __name__ == "__main__":
    main()
