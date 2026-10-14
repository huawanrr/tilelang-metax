"""Experimental two pass S-split NSA kernel.

This module intentionally keeps the normal four tensor callable interface.  The
first pass launches one CTA per query and split of the selected blocks, writing
an unnormalised numerator and denominator to temporary fp32 tensors.  A second
pass combines the split partials and performs the final division.  It is useful
for measuring whether exposing block parallelism beats the extra launch and
workspace traffic on the C500 backend.
"""
import torch
import tilelang
import tilelang.language as T


def _base(i_s, seq_len, bs, i_t, causal):
    hi = T.max(seq_len - bs, 0)
    safe = T.if_then_else(i_s < 0, 0, T.if_then_else(i_s > hi, hi, i_s))
    bad = T.if_then_else(i_s < 0, 1, T.if_then_else(i_s >= seq_len, 1, 0))
    if causal:
        bad = T.if_then_else(i_s > i_t, 1, bad)
    return T.if_then_else(bad > 0, safe, i_s)


@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
})
def _split_pass(batch, heads, seq_len, dim, causal, block_size, groups,
                selected, splits, scale_log2, threads=64):
    hkv = heads // groups
    G, BS, BV = groups, block_size, min(128, tilelang.math.next_power_of_2(dim))
    chunk = (selected + splits - 1) // splits
    qshape = [batch, seq_len, heads, dim]
    kvshape = [batch, seq_len, hkv, dim]
    ishape = [batch, seq_len, hkv, selected]
    # The split dimension precedes the grouped query rows to keep each partial
    # contiguous in the temporary tensors.
    pshape = [batch, seq_len, hkv, splits, G, dim]
    dshape = [batch, seq_len, hkv, splits, G]

    @T.prim_func
    def kernel(Q: T.Tensor(qshape, T.float16), K: T.Tensor(kvshape, T.float16),
               V: T.Tensor(kvshape, T.float16), I: T.Tensor(ishape, T.int32),
               P: T.Tensor(pshape, T.float32), Z: T.Tensor(dshape, T.float32)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * hkv * splits,
                      threads=threads) as (bx, by, bz):
            i_t, i_v = bx, by
            i_split = bz % splits
            i_bh = bz // splits
            i_b, i_h = i_bh // hkv, i_bh % hkv
            q = T.alloc_fragment([G, BV], T.float16)
            k = T.alloc_shared([BS, BV], T.float16)
            v = T.alloc_shared([BS, BV], T.float16)
            # Keep both global tiles in registers until QK is ready.  This is
            # the staging schedule used by the production online kernel and
            # avoids a global load being serialized behind the first barrier.
            kr = T.alloc_fragment([BS, BV], T.float16)
            vr = T.alloc_fragment([BS, BV], T.float16)
            s = T.alloc_fragment([G, BS], T.float32)
            sc = T.alloc_fragment([G, BS], T.float16)
            o = T.alloc_fragment([G, BV], T.float32)
            sums = T.alloc_fragment([G, BS], T.float32)
            den = T.alloc_fragment([G], T.float32)
            T.copy(Q[i_b, i_t, i_h * G:(i_h + 1) * G, i_v * BV:(i_v + 1) * BV], q)
            T.fill(o, 0)
            T.fill(sums, 0)
            for u in T.serial(chunk):
                slot = i_split * chunk + u
                if slot < selected:
                    i_s = I[i_b, i_t, i_h, slot] * BS
                    a = _base(i_s, seq_len, BS, i_t, causal)
                    if i_s >= 0 and i_s < seq_len and (not causal or i_s <= i_t):
                        T.copy(K[i_b, a:a + BS, i_h, i_v * BV:(i_v + 1) * BV], kr)
                        T.copy(V[i_b, a:a + BS, i_h, i_v * BV:(i_v + 1) * BV], vr)
                        T.copy(kr, k)
                        if causal:
                            if i_s + BS <= i_t + 1:
                                T.clear(s)
                            else:
                                for i, j in T.Parallel(G, BS):
                                    s[i, j] = T.if_then_else(i_s + j <= i_t, 0, -T.infinity(T.float32))
                        elif i_s + BS <= seq_len:
                            T.clear(s)
                        else:
                            for i, j in T.Parallel(G, BS):
                                s[i, j] = T.if_then_else(i_s + j < seq_len, 0, -T.infinity(T.float32))
                        T.gemm(q, k, s, transpose_B=True, policy=T.GemmWarpPolicy.FullRow)
                        for i, j in T.Parallel(G, BS):
                            s[i, j] = T.exp2(T.min(s[i, j] * scale_log2, 15.0))
                        for i, j in T.Parallel(G, BS):
                            sums[i, j] += s[i, j]
                        T.copy(s, sc)
                        T.copy(vr, v)
                        T.gemm(sc, v, o, policy=T.GemmWarpPolicy.FullRow)
            T.reduce_sum(sums, den, dim=1, clear=True)
            for i, j in T.Parallel(G, BV):
                P[i_b, i_t, i_h, i_split, i, i_v * BV + j] = o[i, j]
            for i in T.Parallel(G):
                Z[i_b, i_t, i_h, i_split, i] = den[i]
    return kernel


@tilelang.jit(pass_configs={
    tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True,
    tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True,
})
def _merge_pass(batch, heads, seq_len, dim, groups, splits, threads=64):
    hkv = heads // groups
    BV = min(128, tilelang.math.next_power_of_2(dim))
    pshape = [batch, seq_len, hkv, splits, groups, dim]
    dshape = [batch, seq_len, hkv, splits, groups]
    oshape = [batch, seq_len, heads, dim]

    @T.prim_func
    def kernel(P: T.Tensor(pshape, T.float32), Z: T.Tensor(dshape, T.float32),
               O: T.Tensor(oshape, T.float16)):
        with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * hkv, threads=threads) as (bx, by, bz):
            i_b, i_t, i_v = bz // hkv, bx, by
            i_h = bz % hkv
            out = T.alloc_fragment([groups, BV], T.float32)
            den = T.alloc_fragment([groups], T.float32)
            T.fill(out, 0)
            T.fill(den, 0)
            for p in T.serial(splits):
                for i, j in T.Parallel(groups, BV):
                    out[i, j] += P[i_b, i_t, i_h, p, i, i_v * BV + j]
                for i in T.Parallel(groups):
                    den[i] += Z[i_b, i_t, i_h, p, i]
            for i, j in T.Parallel(groups, BV):
                inv = T.if_then_else(den[i] > 0, 1.0 / den[i], 0.0)
                out[i, j] *= inv
            T.copy(out, O[i_b, i_t, i_h * groups:(i_h + 1) * groups,
                           i_v * BV:(i_v + 1) * BV])
    return kernel


def native_sparse_attention(batch, heads, seq_len, dim, is_causal,
                            scale=None, block_size=64, groups=1,
                            selected_blocks=16, threads=64, splits=2, **kwargs):
    """Return a factory-compatible split candidate (S must be divisible by splits)."""
    if selected_blocks % splits:
        raise ValueError("selected_blocks must be divisible by splits")
    sl2 = (dim ** -0.5 if scale is None else float(scale)) * 1.44269504
    a = _split_pass(batch, heads, seq_len, dim, bool(is_causal), block_size,
                    groups, selected_blocks, splits, sl2, threads)
    b = _merge_pass(batch, heads, seq_len, dim, groups, splits, threads)
    def run(Q, K, V, I):
        I = I.to(torch.int32).contiguous()
        P = torch.empty((batch, seq_len, heads // groups, splits, groups, dim),
                        device=Q.device, dtype=torch.float32)
        Z = torch.empty((batch, seq_len, heads // groups, splits, groups),
                        device=Q.device, dtype=torch.float32)
        O = torch.empty_like(Q)
        a(Q, K, V, I, P, Z)
        b(P, Z, O)
        return O
    return run
