"""Preserve coalesced Q staging while using explicit QK/PV emitters."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / "experiments/20260927_next/selected.py").read_text()
for name, linear_v, early_store, explicit_sum in (
    ("q_shared", False, False, False),
    ("q_shared_early", False, True, False),
    ("q_shared_linear", True, False, False),
    ("q_shared_linear_lane", True, False, True),
):
    original_source = (HERE / "v_linear.py").read_text() if linear_v else base
    fn = "single_block_shared_layout" if linear_v else "native_sparse_attention_single_block_emitter"
    node = next(n for n in ast.parse(original_source).body if isinstance(n, ast.FunctionDef) and n.name == fn)
    lines = original_source.splitlines(keepends=True)
    part = "".join(lines[node.decorator_list[0].lineno - 1:node.end_lineno])
    part = part.replace(f"def {fn}(", "def single_shared_q(", 1)
    part = part.replace("            Q_reg = T.alloc_fragment([G, BK], T.float16)", """            Q_stage = T.alloc_fragment([G, BK], T.float16)
            Q_shared = T.alloc_shared([G, BK], T.float16)
            Q_reg = T.alloc_fragment([G, BK], T.float16)""", 1)
    part = part.replace('                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),', """                Q_stage: T.Fragment([G, BK],
                    forward_thread_fn=lambda i, d: (i * BK + d) // 8 % 64,
                    forward_index_fn=lambda i, d: (i * BK + d) // 512 * 8 + d % 8),
                Q_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(Q_shared, vecSize=8),
                Q_reg: qk.make_mma_load_layout(Q_reg, "A"),""", 1)
    part = part.replace("            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)",
                        "            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_stage)" +
                        ("\n            T.copy(Q_stage, Q_shared)" if early_store else ""), 1)
    marker = "                if not direct_k:\n"
    part = part.replace(marker, ("" if early_store else "                T.copy(Q_stage, Q_shared)\n") +
                        "                T.copy(Q_shared, Q_reg)\n" + marker, 1)
    result = base.replace("\n\n_KERNEL_CACHE = {}", "\n\n" + part + "\n\n_KERNEL_CACHE = {}", 1)
    a = result.index("def _get_kernel(")
    host = result[a:].replace("        if S == 1 and use_emitter:\n", f"""        if S == 1 and groups == 16 and threads == 64 and not kv_frag and D == 64 and block_size == 16 and not kv_split:
            kernel = single_shared_q(
                late_normalize=late_normalize, kv_split=False,
                direct_k=False, lane_reduce={explicit_sum}, **common)
        elif S == 1 and use_emitter:
""", 1)
    result = result[:a] + host
    ast.parse(result)
    (HERE / f"{name}.py").write_text(result)
    print(name)
