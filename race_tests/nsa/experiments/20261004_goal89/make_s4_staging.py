"""Coalesce output, optionally Q, in the existing four-block online emitter."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once
from make_v_only_packed import extract

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / "20261002_mid_v1/submission.py"


def main():
    original = BASE.read_text()
    old = extract(original, "native_sparse_attention_online_emitter")
    records = []
    for stage_q in (False, True):
        fn = old.replace("def native_sparse_attention_online_emitter(",
                         "def native_sparse_attention_online_emitter_staged(")
        output = """            O_reg = T.alloc_fragment([G, BV], T.float16)
            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({
                O_reg: pv.make_mma_store_layout(O_reg),
                O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8),
            })
            T.copy(acc_o, O_reg)
            T.copy(O_reg, O_shared)
            T.copy(O_shared, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])
"""
        fn = replace_once(fn, """            T.copy(acc_o, Output[
                i_b, i_t, i_h * G : (i_h + 1) * G,
                i_v * BV : (i_v + 1) * BV])
""", output)
        if stage_q:
            fn = replace_once(fn,
                "            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)",
                """            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            T.annotate_layout({
                Q_stage: T.Fragment([G, BK],
                    forward_thread_fn=lambda i, d: (i * BK + d) // 4 % 64,
                    forward_index_fn=lambda i, d: (i * BK + d) // 256 * 4 + d % 4),
                Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8),
            })
            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_stage)
            T.copy(Q_stage, Q_shared)
            T.copy(Q_shared, Q_reg)""")
        source = replace_once(original, "\ndef _get_kernel(", "\n" + fn + "\n\ndef _get_kernel(")
        source = replace_once(source, """        elif S > 1 and use_emitter_online:
            kernel = native_sparse_attention_online_emitter(
""", """        elif S > 1 and use_emitter_online:
            online_builder = (native_sparse_attention_online_emitter_staged if S == 4
                              else native_sparse_attention_online_emitter)
            kernel = online_builder(
""")
        ast.parse(source)
        path = HERE / f"s4_{'qo' if stage_q else 'output'}_stage.py"
        with path.open("x") as f:
            f.write(source)
        records.append(dict(path=path.name, stage_q=stage_q,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / "s4_staging_assembly.json").write_text(json.dumps(dict(
        baseline=str(BASE), variants=records,
        synchronization="Original compiler-managed synchronization remains enabled, with race/bounds checks retained.",
        math="The same accumulator is cast to FP16 and staged for coalesced writes; arithmetic and K/V loop unchanged.",
    ), indent=2) + "\n")


if __name__ == "__main__":
    main()
