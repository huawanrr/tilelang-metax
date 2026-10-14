"""Local probes for ordinary register lookahead and staged output stores."""
import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent
BASE = (ROOT / "baseline.py").read_text()
TEMPLATE = (ROOT / "s4_staged_template.py").read_text()


def build(lookahead=False, output=False, postmask=False, unroll=2):
    source = TEMPLATE.replace(
        "def native_sparse_attention_s4_staged(",
        "def native_sparse_attention_s4_lookahead(",
    ).replace("for s in T.unroll(S, unroll_factor=2):",
              f"for s in T.unroll(S, unroll_factor={unroll}):")
    # Separate K and V storage is required for the overlapped schedule.
    source = source.replace("threads=64, reuse=False, linear_v=False,",
                            "threads=64,")
    source = source.replace("assert seq_len % block_size == 0 and not (reuse and linear_v)",
                            "assert seq_len % block_size == 0")
    source = source.replace("v_shared = k_shared if reuse else T.alloc_shared([BS, D], T.float16)",
                            "v_shared = T.alloc_shared([BS, D], T.float16)")
    source = source.replace("v_shared: (T.Layout([BS, D], lambda j, d: (j, d)) if linear_v\n"
                            "                           else tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize=8)),",
                            "v_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize=8),")
    source = source.replace("                    if reuse and s > 0:\n                        T.sync_warp()\n", "")
    source = source.replace("                    if reuse:\n                        T.sync_warp()\n", "")
    if lookahead:
        start = source.index("                    for slot in T.unroll(BS * D // 512):")
        end = source.index("                    T.copy(k, k_shared)", start)
        loads = source[start:end]
        source = source[:start] + source[end:]
        valid = "block >= 0 and block < NB and (not is_causal or block <= token // BS)"
        first = "            block = blocks[0]\n            if " + valid + ":\n"
        first += "\n".join(line[4:] for line in loads.splitlines()) + "\n"
        source = source.replace("            T.clear(out)\n", first + "            T.clear(out)\n", 1)
        prefetch = "                if s + 1 < S:\n                    next_block = blocks[s + 1]\n"
        prefetch += "                    if " + valid.replace("block", "next_block") + ":\n"
        prefetch += "\n".join("    " + line.replace("[b, block,", "[b, next_block,")
                               for line in loads.splitlines()) + "\n"
        prefetch += "                if " + valid + ":\n"
        source = source.replace("                    pv.ldmatrix_b(vb, v_shared, 0)\n",
                                prefetch + "                    pv.ldmatrix_b(vb, v_shared, 0)\n", 1)
    if postmask:
        begin = source.index("                    if is_causal and block * BS + BS > token + 1:")
        end = source.index("                    T.sync_warp()", begin)
        source = source[:begin] + "                    T.clear(scores)\n" + source[end:]
        begin = source.index("                        if scale_log2 > 0:")
        end = source.index("                        partial_sum[i, j] += scores[i, j]", begin)
        source = source[:begin] + """                        scores[i, j] = T.if_then_else(not is_causal or block * BS + j <= token,
                            T.exp(T.min(scores[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
""" + source[end:]
    if output:
        source = source.replace(
            "            T.copy(result, Output[b, token, h * G:(h + 1) * G, :])",
            """            T.sync_warp()
            T.copy(result, k_shared)
            T.sync_warp()
            T.copy(k_shared, Output[b, token, h * G:(h + 1) * G, :])""", 1)
    ast.parse(source)
    return source


for lookahead, output, postmask, unroll in (
    (False, True, False, 2),
    (True, False, False, 2),
    (True, True, False, 2),
    (False, False, True, 2),
    (True, True, True, 2),
    (True, True, False, 4),
):
    function = build(lookahead, output, postmask, unroll)
    source = BASE.replace("def _get_kernel(", function + "\n\ndef _get_kernel(", 1)
    branch = """        if mathcast_defaults and groups == 16 and S in (4, 8) and D == 64 and block_size == 16 and seq_len % block_size == 0:
            kernel = native_sparse_attention_s4_lookahead(selected_blocks=S, **common)
        elif d32_compact:
"""
    source = source.replace("        if d32_compact:\n", branch, 1)
    ast.parse(source)
    name = f"s4_lookahead_l{int(lookahead)}_o{int(output)}_m{int(postmask)}_u{unroll}"
    (ROOT / (name + ".py")).write_text(source)
    print(name)
