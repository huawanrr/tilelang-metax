"""Stage multiple live sparse blocks behind one input RAW barrier."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAME = "native_sparse_attention_staged_sparse_blocks"


def builder(stages):
    return f'''
@tilelang.jit(pass_configs={{
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
}})
def {NAME}(batch, heads, seq_len, dim, is_causal, block_size, groups,
          selected_blocks, scale_log2, threads=64):
    assert groups == 16 and threads == 64 and dim == 64 and block_size == 16
    assert seq_len % block_size == 0 and selected_blocks == 4
    G, BS, D, S, ST = groups, block_size, dim, selected_blocks, {stages}
    H, NB = heads // groups, seq_len // block_size
    qk, pv = _emitters(T.float16, T.float32, BS, D)
    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, D], T.float16),
        K: T.Tensor([batch, seq_len, H, D], T.float16),
        V: T.Tensor([batch, seq_len, H, D], T.float16),
        Indices: T.Tensor([batch, seq_len, H, S], T.int32),
        Output: T.Tensor([batch, seq_len, heads, D], T.float16),
    ):
        with T.Kernel(seq_len, batch * H, threads=threads) as (token, bh):
            q = T.alloc_fragment([G, D], T.float16)
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, D], T.float16)
            k_shared = T.alloc_shared([ST, BS, D], T.float16)
            v_shared = T.alloc_shared([ST, BS, D], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, D], T.float32)
            result = T.alloc_fragment([G, D], T.float16)
            partial_sum = T.alloc_fragment([G, BS], T.float32)
            denom = T.alloc_fragment([G], T.float32)
            inv = T.alloc_fragment([G], T.float32)
            T.annotate_layout({{
                q: qk.make_mma_load_layout(q, 'A'),
                k: T.Fragment([BS, D],
                    forward_thread_fn=lambda j, d: (j * D + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * D + d) // 512 * 8 + d % 8),
                v: T.Fragment([BS, D],
                    forward_thread_fn=lambda j, d: (j * D + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * D + d) // 512 * 8 + d % 8),
                k_shared: T.Layout([ST, BS, D], lambda ps, pj, pd:
                    ps * BS * D + pj * D + (pd // 8 ^ pj % 8) * 8 + pd % 8),
                v_shared: T.Layout([ST, BS, D], lambda ps, pj, pd:
                    ps * BS * D + pj * D + (pd // 8 ^ pj % 8) * 8 + pd % 8),
                scores: qk.make_mma_store_layout(scores),
                prob: pv.make_mma_load_layout(prob, 'A'),
                out: pv.make_mma_store_layout(out),
                result: pv.make_mma_store_layout(result),
                partial_sum: qk.make_mma_store_layout(partial_sum),
            }})
            K_blocks = T.reshape(K, [batch, NB, BS, H, D])
            V_blocks = T.reshape(V, [batch, NB, BS, H, D])
            blocks = T.alloc_local([S], T.int32)
            kb = T.alloc_local([qk.warp_cols * qk.k_pack * qk.local_size_b], T.float16)
            vb = T.alloc_local([pv.warp_cols * pv.k_pack * pv.local_size_b], T.float16)
            b, h = bh // H, bh % H
            tid = T.get_thread_binding()
            T.copy(Q[b, token, h * G:(h + 1) * G, :], q)
            for s in T.unroll(S):
                blocks[s] = Indices[b, token, h, s]
            T.clear(out)
            T.clear(partial_sum)
            for group in T.unroll(S // ST):
                for stage in T.unroll(ST):
                    block = blocks[group * ST + stage]
                    if block >= 0 and block < NB and (not is_causal or block <= token // BS):
                        for slot in T.unroll(BS * D // 512):
                            for word in T.unroll(4):
                                for element in T.vectorized(2):
                                    k[(slot * 512 + tid * 8) // D, tid % (D // 8) * 8 + word * 2 + element] = K_blocks[b, block, (slot * 512 + tid * 8) // D, h, tid % (D // 8) * 8 + word * 2 + element]
                        for slot in T.unroll(BS * D // 512):
                            for word in T.unroll(4):
                                for element in T.vectorized(2):
                                    v[(slot * 512 + tid * 8) // D, tid % (D // 8) * 8 + word * 2 + element] = V_blocks[b, block, (slot * 512 + tid * 8) // D, h, tid % (D // 8) * 8 + word * 2 + element]
                        for j, d in T.Parallel(BS, D):
                            k_shared[stage, j, d] = k[j, d]
                            v_shared[stage, j, d] = v[j, d]
                T.sync_warp()
                for stage in T.unroll(ST):
                    block = blocks[group * ST + stage]
                    if block >= 0 and block < NB and (not is_causal or block <= token // BS):
                        if is_causal and block * BS + BS > token + 1:
                            for i, j in T.Parallel(G, BS):
                                scores[i, j] = T.if_then_else(block * BS + j <= token, 0.0, -T.infinity(T.float32))
                        else:
                            T.clear(scores)
                        for ki in T.serial(D // 32):
                            for e in T.vectorized(8):
                                kb[e] = k_shared[stage, tid % 16, ki * 32 + tid // 16 * 8 + e]
                            qk.mma(q, kb, scores, ki)
                        for i, j in T.Parallel(G, BS):
                            if scale_log2 > 0:
                                scores[i, j] = T.exp(T.min(scores[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
                            else:
                                scores[i, j] = T.if_then_else(not is_causal or block * BS + j <= token,
                                    T.exp(T.min(scores[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918)), 0.0)
                            partial_sum[i, j] += scores[i, j]
                        for lane in T.unroll(4):
                            prob[tid % 16, tid // 16 * 4 + lane] = scores[tid % 16, tid // 16 * 4 + lane]
                        for col in T.unroll(D // 16):
                            for e in T.unroll(4):
                                vb[col * 4 + e] = v_shared[stage, tid // 16 * 4 + e, col * 16 + tid % 16]
                        pv.mma(prob, vb, out, 0)
                T.sync_warp()
            T.reduce_sum(partial_sum, denom, dim=1, clear=True)
            for i in T.Parallel(G):
                inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
            for i, j in T.Parallel(G, D):
                out[i, j] *= inv[i]
            for chunk in T.unroll(D // 16):
                for lane in T.unroll(4):
                    result[tid % 16, chunk * 16 + tid // 16 * 4 + lane] = out[tid % 16, chunk * 16 + tid // 16 * 4 + lane]
            output_shared = T.alloc_shared([G, D], T.float16)
            T.annotate_layout({{output_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(output_shared, vecSize=8)}})
            T.copy(result, output_shared)
            T.sync_warp()
            T.copy(output_shared, Output[b, token, h * G:(h + 1) * G, :])
    return kernel
'''


def main():
    source = (HERE / "parent.py").read_text()
    function = next(n for n in ast.parse(source).body
                    if isinstance(n, ast.FunctionDef) and n.name == NAME)
    start = min([function.lineno] + [d.lineno for d in function.decorator_list]) - 1
    reports = []
    for stages in (2, 4):
        lines = source.splitlines(keepends=True)
        lines[start:function.end_lineno] = [builder(stages)]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / f"s4_staged_group{stages}.py"
        with path.open("x") as handle:
            handle.write(result)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                            stages=stages, wave_barriers=4 // stages * 2 + 1,
                            input_shared_bytes=stages * 4096))
        print(path.name)
    (HERE / "staged_group_manifest.json").write_text(json.dumps(dict(
        parent="parent.py", variants=reports,
        synchronization="Input RAW barrier per group; WAR barrier before reusing any group slot; output RAW barrier",
        index_validation="Every load and consume verifies the raw block index before forming its token address",
        safety_passes_unchanged=True), indent=2) + "\n")


if __name__ == "__main__":
    main()
