"""Expose real branch bounds to index-width analysis without assumptions."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
OLD = HERE.parent / "20261001_next"
for stem in ("packed_q4_latev", "packed_q4_mask_latev", "packed_q4_join"):
    source = (OLD / (stem + ".py")).read_text()
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)
                and n.name == "native_sparse_attention_single_packed_qo")
    lines = source.splitlines(keepends=True)
    start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    fn = "".join(lines[start:node.end_lineno])
    assert "if valid:" in fn
    fn = fn.replace("if valid:", "if block >= 0 and block < NB and (not is_causal or block * BS <= token):")
    result = "".join(lines[:start]) + fn + "".join(lines[node.end_lineno:])
    ast.parse(result)
    p = HERE / (stem + "_bounds.py")
    if p.exists():
        raise FileExistsError(p)
    p.write_text(result)
    print(p.name)

for n in (2, 4):
    path = HERE / f"s8_group{n}_late0_q0o1_v3.py"
    source = path.read_text()
    old = """                    for j, d in T.Parallel(BS, D):
                        k[nj * BS + j, d] = T.if_then_else(valid,
                            K[b, block, h, d // 32, j // 16,
                              (d % 32 // 8) * 16 + j % 16, d % 8], 0)"""
    new = """                    if block >= 0 and block < NB and (not is_causal or block * BS <= token):
                        for j, d in T.Parallel(BS, D):
                            k[nj * BS + j, d] = K[b, block, h, d // 32, j // 16,
                                (d % 32 // 8) * 16 + j % 16, d % 8]
                    else:
                        for j, d in T.Parallel(BS, D):
                            k[nj * BS + j, d] = 0"""
    assert source.count(old) == 1
    source = source.replace(old, new)
    old = """                        for dj in T.unroll(D // 32):
                            for e in T.vectorized(8):
                                v[nj * D // 4 + dj * 8 + e] = T.if_then_else(valid,
                                    V[b, block, h, 0, dj, tid, e], T.float16(0))"""
    new = """                        if block >= 0 and block < NB and (not is_causal or block * BS <= token):
                            for dj in T.unroll(D // 32):
                                for e in T.vectorized(8):
                                    v[nj * D // 4 + dj * 8 + e] = V[b, block, h, 0, dj, tid, e]
                        else:
                            for vi in T.vectorized(D // 4):
                                v[nj * D // 4 + vi] = 0"""
    assert source.count(old) == 2
    source = source.replace(old, new)
    # No per-element predicate is needed for an entire valid preceding block.
    old = """                    for i, j in T.Parallel(G, BS):
                        pos = block * BS + j
                        scores[i, nj * BS + j] = T.if_then_else(
                            valid and pos < seq_len and (not is_causal or pos <= token),
                            0.0, -T.infinity(T.float32))"""
    new = """                    if block >= 0 and block < NB and block * BS + BS <= seq_len and (not is_causal or block * BS + BS <= token + 1):
                        for i, j in T.Parallel(G, BS):
                            scores[i, nj * BS + j] = 0
                    else:
                        for i, j in T.Parallel(G, BS):
                            pos = block * BS + j
                            scores[i, nj * BS + j] = T.if_then_else(
                                valid and pos < seq_len and (not is_causal or pos <= token),
                                0.0, -T.infinity(T.float32))"""
    assert source.count(old) == 1
    source = source.replace(old, new)
    for mode in ("bounds", "bounds_unroll", "bounds_ilp", "bounds_minreg"):
        result = source
        if mode == "bounds_unroll":
            result = result.replace("for chunk in T.serial(S // N):", "for chunk in T.unroll(S // N):")
        elif mode in ("bounds_ilp", "bounds_minreg"):
            marker = '@tilelang.jit(pass_configs={\n    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,'
            assert result.count(marker) == 2
            pos = result.index("def native_sparse_attention_grouped_packed(")
            deco = result.rindex("@tilelang.jit(", 0, pos)
            result = result[:deco] + result[deco:].replace("@tilelang.jit(",
                f"@tilelang.jit(compile_flags=['-mllvm', '--misched=metaxgpu-{mode.removeprefix('bounds_')}'], ", 1)
        ast.parse(result)
        dest = HERE / f"s8_group{n}_{mode}.py"
        if dest.exists():
            raise FileExistsError(dest)
        dest.write_text(result)
        print(dest.name)
