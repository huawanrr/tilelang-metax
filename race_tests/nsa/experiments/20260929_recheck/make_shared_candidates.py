"""Keep one shared allocation, but give K and V independent address layouts."""
import ast
import hashlib
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / "experiments/20260927_next/selected.py").read_text()
assert hashlib.sha256(base.encode()).hexdigest() == "311e64a25b16471d2689049070303e6400bc0f593e184615222839e1a77b3a26"
node = next(n for n in ast.parse(base).body if isinstance(n, ast.FunctionDef)
            and n.name == "native_sparse_attention_single_block_emitter")
lines = base.splitlines(keepends=True)
original = "".join(lines[node.decorator_list[0].lineno - 1:node.end_lineno])


def shared_address(row, col, stride, vec, phase):
    return f"({row}) * {stride} + ((({col}) // {vec}) ^ ({phase})) * {vec} + ({col}) % {vec}"


for name, v_mode in (("flat_control", "control"), ("v_bank", "bank"),
                     ("v_swizzle4", "swizzle4"), ("v_linear", "linear")):
    part = original.replace("def native_sparse_attention_single_block_emitter(",
                            "def single_block_shared_layout(", 1)
    part = part.replace("    qk, pv = _emitters(T.float16, T.float32, BS, BK)", """    VSTRIDE = max(64, BK) if VMODE == "bank" else BK
    KPHASE = max(1, 64 // BK)
    KMAX = min(16 // KPHASE, BK // 8)
    VPHASE = max(1, 64 // BK)
    VMAX = min(16 // VPHASE, BK // 4)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)""".replace("VMODE", repr(v_mode)))
    part = part.replace("KV_shared = T.alloc_shared([BS, BK], T.float16)",
                        "KV_shared = T.alloc_shared([BS * VSTRIDE], T.float16)")
    part = part.replace("""            V_shared = (T.alloc_shared([BS, BV], T.float16) if kv_split
                        else KV_shared)""", "            V_shared = KV_shared\n            tid = T.get_thread_binding()")
    part = part.replace("""                KV_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(
                    KV_shared, vecSize=8),""", """                KV_shared: T.Layout([BS * VSTRIDE], lambda i: i),
                K_reg: T.Fragment([BS, BK],
                    forward_thread_fn=lambda j, d: (j * BK + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BK + d) // 512 * 8 + d % 8),
                V_reg: T.Fragment([BS, BV],
                    forward_thread_fn=lambda j, d: (j * BV + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * BV + d) // 512 * 8 + d % 8),""")
    a = part.index("            if kv_split:\n                _layout")
    b = part.index("            if direct_k:", a)
    part = part[:a] + part[b:]
    k_store = shared_address("j", "d", "BK", 8, "(j // KPHASE) % KMAX")
    k_load = shared_address("j * 16 + tid % 16", "ki * 32 + tid // 16 * 8 + e", "BK", 8,
                            "((j * 16 + tid % 16) // KPHASE) % KMAX")

    def v_addr(row, col):
        if v_mode == "bank":
            return shared_address(row, col, "VSTRIDE", 16, f"(({row}) // 4) % 4")
        if v_mode == "swizzle4":
            return shared_address(row, col, "BK", 4, f"(({row}) // VPHASE) % VMAX")
        if v_mode == "linear":
            return f"({row}) * BK + ({col})"
        return shared_address(row, col, "BK", 8, f"(({row}) // KPHASE) % KMAX")

    part = part.replace("                    T.copy(K_reg, KV_shared)",
                        f"                    for j, d in T.Parallel(BS, BK):\n                        KV_shared[{k_store}] = K_reg[j, d]")
    a = part.index("                if kv_split:\n                    # Separate V tile")
    b = part.index("\n                if is_causal", a)
    part = part[:a] + part[b:]
    part = part.replace("                        qk.ldmatrix_b(kb, KV_shared, ki)",
                        f"                        for j in T.serial(BS // 16):\n                            for e in T.vectorized(8):\n                                kb[j * 8 + e] = KV_shared[{k_load}]")
    part = part.replace("""                if not kv_split:
                    T.copy(V_reg, KV_shared)""",
                        f"                for j, d in T.Parallel(BS, BV):\n                    KV_shared[{v_addr('j', 'd')}] = V_reg[j, d]")
    v_load = v_addr("ki * 16 + tid // 16 * 4 + e", "j * 16 + tid % 16")
    part = part.replace("                    pv.ldmatrix_b(vb, V_shared, ki)",
                        f"                    for j in T.serial(BV // 16):\n                        for e in T.serial(4):\n                            vb[j * 4 + e] = KV_shared[{v_load}]")
    result = base.replace("\n\n_KERNEL_CACHE = {}", "\n\n" + part + "\n\n_KERNEL_CACHE = {}", 1)
    a = result.index("def _get_kernel(")
    host = result[a:].replace("        if S == 1 and use_emitter:\n", """        if S == 1 and use_emitter and not kv_split:
            kernel = single_block_shared_layout(
                late_normalize=late_normalize, kv_split=False,
                direct_k=direct_k, lane_reduce=lane_reduce, **common)
        elif S == 1 and use_emitter:
""", 1)
    result = result[:a] + host
    ast.parse(result)
    (HERE / f"{name}.py").write_text(result)
    print(name)
