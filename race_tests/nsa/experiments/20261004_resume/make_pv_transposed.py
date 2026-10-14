"""Keep QK unchanged and compute PV as V^T P^T with existing packed operands."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / "experiments/20261002_mid_v1/nsa.py"
NAME = "native_sparse_attention_single_packed_qo_v2"


def once(source, old, new):
    assert source.count(old) == 1, (old, source.count(old))
    return source.replace(old, new)


def main():
    source = BASE.read_text()
    lines = source.splitlines(keepends=True)
    function = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == NAME)
    start = min([function.lineno] + [d.lineno for d in function.decorator_list]) - 1
    original = "".join(lines[start:function.end_lineno])
    records = []
    for width in (128, 64, 32):
        fn = original
        fn = once(fn, "    W = min(width, D)", f"    W = min(width, D, {width})")
        fn = once(fn, "        a_transposed=False, b_transposed=False,", "        a_transposed=True, b_transposed=True,")
        fn = once(fn, "        warp_row_tiles=16, warp_col_tiles=W, chunk=BS, k_pack=1)",
                  "        warp_row_tiles=W, warp_col_tiles=16, chunk=BS, k_pack=1)")
        fn = once(fn, "            output_reg = T.alloc_fragment([G, D], T.float16)\n", "")
        fn = once(fn, """                output_reg: T.Fragment([G, D],
                    forward_thread_fn=lambda oi, od: oi + od % 16 // 4 * 16,
                    forward_index_fn=lambda oi, od: od // 16 * 4 + od % 4),
""", "")
        fn = once(fn, "            out = T.alloc_fragment([G, W], T.float32)",
                  "            out = T.alloc_fragment([W, G], T.float32)")
        fn = once(fn, "                v: pv.make_mma_load_layout(v, 'B'),", "                v: pv.make_mma_load_layout(v, 'A'),")
        fn = once(fn, "                prob: pv.make_mma_load_layout(prob, 'A'),", "                prob: pv.make_mma_load_layout(prob, 'B'),")
        fn = once(fn, "                        pv.mma(prob, v, out, ki)", "                        pv.mma(v, prob, out, ki)")
        fn = once(fn, """                        for i, j in T.Parallel(G, W):
                            out[i, j] *= inv[i]
""", """                        for d, g in T.Parallel(W, G):
                            out[d, g] *= inv[g]
""")
        begin = fn.index("                for oi, od in T.Parallel(G, W):")
        end = fn.index("    return kernel", begin)
        fn = fn[:begin] + """                for d, g in T.Parallel(W, G):
                    Output[b, token, h * G + g, vo * W + d] = out[d, g]
""" + fn[end:]
        # The sole surviving shared buffer is Q, with its existing RAW barrier.
        # PV consumes the same per-lane packed V and half probability elements.
        fn = once(fn, '    """Consume K/V packed from the current inputs and stage Q/O coalesced.\n\n'
                  '    The pack launch is part of every invocation. Only Q and O use shared\n'
                  '    memory, with barriers at Q RAW, Q/O WAR and O RAW. The denominator\n'
                  '    AllReduce<64,16> uses two warp shuffles without touching shared scratch.\n'
                  '    """',
                  '    """Use unchanged QK then V^T P^T for dimension-contiguous output lanes."""')
        result = "".join(lines[:start]) + fn + "".join(lines[function.end_lineno:])
        ast.parse(result)
        path = HERE / f"pv_transposed_w{width}.py"
        with path.open("x") as f:
            f.write(result)
        records.append(dict(path=str(path.relative_to(ROOT)), sha256=hashlib.sha256(path.read_bytes()).hexdigest(), width=width))
    with (HERE / "pv_transposed_assembly.json").open("x") as f:
        f.write(json.dumps(dict(baseline=str(BASE.relative_to(ROOT)), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
                               variants=records, changed_function=NAME,
                               mechanism="Keep QK and packed inputs; exchange PV A/B roles and write transposed result directly",
                               pack_kernel_unchanged=True, dispatch_unchanged=True), indent=2) + "\n")
    print(json.dumps(records, indent=2))


if __name__ == "__main__":
    main()
