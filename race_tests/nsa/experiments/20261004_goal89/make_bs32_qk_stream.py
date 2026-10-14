"""Also stage each Q reduction slice from shared memory just before its MMA."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once
from make_v_only_packed import extract

HERE = Path(__file__).resolve().parent


def main():
    records = []
    for prefetch in (1, 2):
        parent = HERE / f"bs32_kstream_p{prefetch}_early.py"
        original = parent.read_text()
        old = extract(original, "native_sparse_attention_single_packed_qo_v2")
        fn = replace_once(old, "            q = T.alloc_fragment([G, D], T.float16)",
                          "            q = T.alloc_local([qk.warp_rows * qk.k_pack * qk.local_size_a], T.float16)")
        fn = replace_once(fn, "                q: qk.make_mma_load_layout(q, 'A'),\n", "")
        fn = replace_once(fn, "                T.copy(q_shared, q)\n", "")
        for p in range(prefetch):
            ki = f"kg * {prefetch}" + (f" + {p}" if p else "")
            old_mma = f"                    qk.mma(q, kb{p}, scores, {ki})"
            fn = replace_once(fn, old_mma,
                f"                    qk.ldmatrix_a(q, q_shared, {ki})\n" + old_mma)
        source = replace_once(original, old, fn)
        ast.parse(source)
        path = HERE / f"bs32_qkstream_p{prefetch}.py"
        with path.open("x") as f:
            f.write(source)
        records.append(dict(path=path.name, parent=parent.name, prefetch=prefetch,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "bs32_qkstream_assembly.json").write_text(json.dumps(dict(
        variants=records,
        changes="The full coalesced Q tile is still loaded once into shared memory. Only its current 32-feature reduction slice is held in MMA registers.",
        preserved="All original wave synchronization, output math, packing, and host dispatch are retained.",
    ), indent=2) + "\n")


if __name__ == "__main__":
    main()
