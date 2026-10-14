"""Stage coalesced Q loads in registers, then permute into the MMA A layout."""
import ast
from pathlib import Path

from make_shuffle_candidates import exchange, indent

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
for dim in (32, 64, 128):
    for mode, q_shuffle in (("original", True), ("linear", False), ("linear", True)):
        path = ROOT / "experiments/20260927_next/selected.py" if mode == "original" else HERE / "v_linear.py"
        source = path.read_text()
        target = "native_sparse_attention_single_block_emitter" if mode == "original" else "single_block_shared_layout"
        node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == target)
        lines = source.splitlines(keepends=True)
        part = "".join(lines[node.decorator_list[0].lineno - 1:node.end_lineno])
        part = part.replace(f"def {target}(", "def single_coalesced_q(", 1)
        if q_shuffle:
            alloc, loads, body = exchange("qs", dim, 16, 8, "Q")
            part = part.replace("            Q_reg = T.alloc_fragment([G, BK], T.float16)",
                                indent(["tid = T.get_thread_binding()"] + alloc, 12) +
                                "\n            Q_reg = T.alloc_fragment([G, BK], T.float16)", 1)
            part = part.replace("            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)",
                                indent(loads + body, 12) + """
            for i, d in T.Parallel(G, BK):
                Q_reg[i, d] = qs_mma[d // 32 * 8 + d % 8]""", 1)
        # The plain next module supplies dispatch and every fallback unchanged.
        base = (ROOT / "experiments/20260927_next/selected.py").read_text()
        result = base.replace("\n\n_KERNEL_CACHE = {}", "\n\n" + part + "\n\n_KERNEL_CACHE = {}", 1)
        a = result.index("def _get_kernel(")
        host = result[a:].replace("        if S == 1 and use_emitter:\n", f"""        if S == 1 and groups == 16 and threads == 64 and not kv_frag and D == {dim} and block_size == 16 and not kv_split:
            kernel = single_coalesced_q(
                late_normalize=late_normalize, kv_split=False,
                direct_k=direct_k, lane_reduce=True, **common)
        elif S == 1 and use_emitter:
""", 1)
        result = result[:a] + host
        ast.parse(result)
        name = f"q{dim}_{mode}_{int(q_shuffle)}"
        (HERE / f"{name}.py").write_text(result)
        print(name)
