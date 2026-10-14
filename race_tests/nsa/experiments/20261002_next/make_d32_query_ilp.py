"""Give one wave several independent queries, with optional register lookahead."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / 'experiments/20261002_final/nsa.py'


def kernel(queries, prefetch):
    declarations, loads, computes = [], [], []
    for p in range(queries):
        declarations.append(f'''
            q_{p} = T.alloc_fragment([G, BK], T.float16)
            v_{p} = T.alloc_fragment([BS, BV], T.float16)
            raw_{p} = T.alloc_local([8], T.float16)
            words_{p} = T.Tensor([4], T.uint32, data=raw_{p}.data, scope="local")
            shuffled_{p} = T.alloc_local([4], T.uint32)
            mma_k_{p} = T.Tensor([8], T.float16, data=shuffled_{p}.data, scope="local")
            T.annotate_layout({{
                q_{p}: qk.make_mma_load_layout(q_{p}, "A"),
                v_{p}: T.Fragment([BS, BV],
                    forward_thread_fn=lambda vr, vc: (vr * BV + vc) // 8 % 64,
                    forward_index_fn=lambda vr, vc: (vr * BV + vc) // 512 * 8 + vc % 8),
            }})
''')
        loads.append(f'''
            t_{p} = bx * {queries} + {p}
            T.copy(Q[b, t_{p}, h * G:(h + 1) * G, :], q_{p})
            index_{p} = T.if_then_else(t_{p} < seq_len, Indices[b, t_{p}, h, 0], -1)
            start_{p} = T.min(T.max(index_{p}, -1), NB) * BS
            valid_{p} = (t_{p} < seq_len and start_{p} >= 0 and start_{p} < seq_len
                         and (not is_causal or start_{p} <= t_{p}))
            if valid_{p}:
                for e in T.vectorized(8):
                    raw_{p}[e] = T.if_then_else(start_{p} + tid // 4 < seq_len,
                        K[b, start_{p} + tid // 4, h, tid % 4 * 8 + e], T.float16(0))
                T.copy(V[b, start_{p}:start_{p} + BS, h, :], v_{p})
''')
        computes.append(f'''
            T.clear(out)
            if valid_{p}:
                for word in T.unroll(4):
                    shuffled_{p}[word] = T.shfl_sync(words_{p}[word],
                        tid % 16 * 4 + tid // 16, 64, 0xffffffffffffffff)
                for m, n in T.Parallel(G, BS):
                    scores[m, n] = T.if_then_else(
                        start_{p} + n < seq_len and (not is_causal or start_{p} + n <= t_{p}),
                        0, -T.infinity(T.float32))
                qk.mma(q_{p}, mma_k_{p}, scores, 0)
                # Each query has its own 512-element shared region. No earlier
                # query's PV reads can alias the next query's V stores.
                for vr, vc in T.Parallel(BS, BV):
                    shared[({p} * BS + vr) * BV + vc] = v_{p}[vr, vc]
                for m, n in T.Parallel(G, BS):
                    scores[m, n] = T.exp2(T.min(scores[m, n] * scale_log2, 15.0))
                for m, lane in T.Parallel(G, 4):
                    sums[m, lane] = 0
                    for j in T.unroll(4):
                        sums[m, lane] += scores[m, lane * 4 + j]
                for m, lane in T.Parallel(G, 4):
                    sums[m, lane] += T.shfl_xor(sums[m, lane], 32, 64, 0xffffffffffffffff)
                    sums[m, lane] += T.shfl_xor(sums[m, lane], 16, 64, 0xffffffffffffffff)
                    sums[m, lane] = T.if_then_else(sums[m, lane] > 0, 1.0 / sums[m, lane], 0.0)
                for m, n in T.Parallel(G, BS):
                    prob[m, n] = scores[m, n] * sums[m, n // 4]
                T.sync_warp()
                for col in T.serial(BV // 16):
                    for e in T.serial(4):
                        vb[col * 4 + e] = shared[
                            ({p} * BS + tid // 16 * 4 + e) * BV + col * 16 + tid % 16]
                pv.mma(prob, vb, out, 0)
            T.copy(out, Output[b, t_{p}, h * G:(h + 1) * G, :])
''')
    body = ''.join(loads) + ''.join(computes) if prefetch else ''.join(l + c for l, c in zip(loads, computes))
    return f'''
@tilelang.jit(pass_configs={{
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
    tilelang.PassConfigKey.TL_DISABLE_THREAD_STORAGE_SYNC: True,
}})
def native_sparse_attention_d32_query_ilp(batch, heads, seq_len, dim, is_causal,
        block_size, groups, scale_log2, threads=64):
    assert dim == 32 and block_size == 16 and groups == 16 and threads == 64
    G, BS, BK, BV = 16, 16, 32, 32
    H = heads // G
    NB = T.ceildiv(seq_len, BS)
    qk, pv = _emitters(T.float16, T.float32, BS, BK)

    @T.prim_func
    def kernel(
        Q: T.Tensor([batch, seq_len, heads, dim], T.float16),
        K: T.Tensor([batch, seq_len, H, dim], T.float16),
        V: T.Tensor([batch, seq_len, H, dim], T.float16),
        Indices: T.Tensor([batch, seq_len, H, 1], T.int32),
        Output: T.Tensor([batch, seq_len, heads, dim], T.float16),
    ):
        with T.Kernel(T.ceildiv(seq_len, {queries}), batch * H, threads=64) as (bx, bh):
            tid = T.get_thread_binding()
            b, h = bh // H, bh % H
            shared = T.alloc_shared([{queries} * BS * BV], T.float16)
            scores = T.alloc_fragment([G, BS], T.float32)
            prob = T.alloc_fragment([G, BS], T.float16)
            out = T.alloc_fragment([G, BV], T.float32)
            sums = T.alloc_fragment([G, 4], T.float32)
            vb = T.alloc_local([8], T.float16)
            T.annotate_layout({{
                scores: qk.make_mma_store_layout(scores),
                prob: pv.make_mma_load_layout(prob, "A"),
                out: pv.make_mma_store_layout(out),
                sums: T.Fragment([G, 4], forward_thread_fn=lambda sm, sl: sm + sl * 16,
                                 forward_index_fn=lambda sm, sl: 0),
            }})
{''.join(declarations)}
{body}
    return kernel

'''


def main():
    base = BASE.read_text()
    for count, prefetch in ((1, True), (2, False), (2, True), (4, True)):
        output = HERE / f'd32_queries{count}_prefetch{int(prefetch)}.py'
        assert not output.exists(), output
        added = kernel(count, prefetch)
        source = base.replace('\ndef _get_kernel(', '\n' + added + '\ndef _get_kernel(', 1)
        marker = '        if packed_qo:\n'
        assert source.count(marker) == 1
        source = source.replace(marker, '''        if S == 1 and D == 32 and block_size == 16 and groups == 16 and threads == 64:
            kernel = native_sparse_attention_d32_query_ilp(**common)
        elif packed_qo:
''', 1)
        ast.parse(source)
        output.write_text(source)
        print(output)


if __name__ == '__main__':
    main()
