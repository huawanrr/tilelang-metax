"""Exchange FP32 scores once, then reduce each wave's full probability row."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once

HERE = Path(__file__).resolve().parent


def main():
    records = []
    for late in (False, True):
        parent = HERE / f"bs32_colwaves_q4_{'late' if late else 'early'}.py"
        original = parent.read_text()
        lines = original.splitlines(keepends=True)
        node = next(n for n in ast.parse(original).body if isinstance(n, ast.FunctionDef)
                    and n.name == "native_sparse_attention_single_packed_qo_v2")
        begin = node.lineno - 1
        body = "".join(lines[begin:node.end_lineno])
        body = replace_once(body, "            prob_shared = T.alloc_shared([G, BS], T.float16)",
            "            prob_shared = T.alloc_shared([G, BS], T.float32)\n"
            "            prob_fp32 = T.alloc_fragment([G, BS], T.float32)")
        body = replace_once(body, "            denom_shared = T.alloc_shared([G], T.float32)\n", "")
        body = replace_once(body,
            "                prob_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(prob_shared, vecSize=8),",
            "                prob_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(prob_shared, vecSize=4),\n"
            "                prob_fp32: pv.make_mma_load_layout(prob_fp32, \"A\"),")
        start = body.index("            T.reduce_sum(scores, denom, dim=1, clear=True)")
        end = body.index("            T.clear(out)", start)
        replacement = """            # Both waves finish reading Q before scratch storage is reused.
            T.sync_threads()
            T.copy(scores, prob_shared)
            T.sync_threads()
            # Every wave receives the entire row; reduction now stays inside it.
            T.copy(prob_shared, prob_fp32)
            T.reduce_sum(prob_fp32, denom, dim=1, clear=True)
            for i in T.Parallel(G):
                inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
            if not late:
                for i, j in T.Parallel(G, BS):
                    prob_fp32[i, j] *= inv[i]
            T.copy(prob_fp32, prob)
"""
        body = body[:start] + replacement + body[end:]
        body = replace_once(body,
            "                    out[i, d] = T.if_then_else(denom_shared[i] > 0, out[i, d] / denom_shared[i], 0.0)",
            "                    out[i, d] *= inv[i]")
        for direct in (False, True):
            fn = body
            if direct:
                fn = replace_once(fn, """            T.copy(Q[b, token, h * G:(h + 1) * G, :], q_stage)
            T.copy(q_stage, q_shared)
            T.sync_threads()
            T.copy(q_shared, q)
""", "            T.copy(Q[b, token, h * G:(h + 1) * G, :], q)\n")
            source = "".join(lines[:begin]) + fn + "".join(lines[node.end_lineno:])
            ast.parse(source)
            path = HERE / f"bs32_score_exchange_{'direct' if direct else 'stage'}_{'late' if late else 'early'}.py"
            with path.open("x") as f:
                f.write(source)
            records.append(dict(path=path.name, parent=parent.name, q_direct=direct, late_normalize=late,
                                sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "bs32_score_exchange_assembly.json").write_text(json.dumps(dict(
        variants=records,
        math="Each wave receives complete FP32 score rows and computes the same denominator using wave-local reduction.",
        synchronization="Explicit CTA barriers protect shared score exchange and scratch reuse. No large partial output reduction.",
    ), indent=2) + "\n")


if __name__ == "__main__":
    main()
