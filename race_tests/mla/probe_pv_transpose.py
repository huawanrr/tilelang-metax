"""Probe: can PV's B-operand LDS be vectorized by feeding the gemm a
token-contiguous (transposed) V tile?

Current PV: T.gemm(S_shared [16,32], KV_shared [32,512]) -- B reads the token
direction of a dim-major tile, 2B scalar LDS, 6.5us of the case-1 floor.
New PV: T.gemm(S_shared, KV_T [dim_chunk, 32], transpose_B=True) -- same call
form as QK, B reads 4 consecutive tokens = 8B.  KV_T is produced per block by
T.transpose (shared->shared tileop) over dim chunks.

Variants: A = current; B = four [16,128] fragments, one transpose+gemm each.
"""
import torch
import tilelang
import tilelang.language as T

BH, BN, DIM, CHUNK = 16, 32, 512, 128


def make(variant: str):
    kv_shape = [DIM, BN] if variant == 'C' else [BN, DIM]

    @tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True})
    def kern(
        S_g: T.Tensor([BH, BN], T.float16),
        KV_g: T.Tensor(kv_shape, T.float16),
        Out: T.Tensor([BH, DIM], T.float16),
    ):
        with T.Kernel(1, threads=128):
            S_shared = T.alloc_shared([BH, BN], T.float16)
            if variant != 'F':
                T.copy(S_g, S_shared)
            if variant == 'C':
                # Pre-transposed input: isolates the vectorized-B PV gemm
                # from the transpose cost.  KV_g arrives as [DIM, BN].
                KV_T = T.alloc_shared([DIM, BN], T.float16)
                T.copy(KV_g, KV_T)
                acc_o = T.alloc_fragment([BH, DIM], T.float32)
                T.fill(acc_o, 0)
                T.gemm(S_shared, KV_T, acc_o,
                       transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
                for i, j in T.Parallel(BH, DIM):
                    Out[i, j] = acc_o[i, j].astype(T.float16)
                return
            KV_shared = T.alloc_shared([BN, DIM], T.float16)
            T.copy(KV_g, KV_shared)
            if variant == 'T':
                # Transpose only (no gemm): pure KV_T production cost.
                KV_T = T.alloc_shared([CHUNK, BN], T.float16)
                for c in range(4):
                    T.transpose(KV_shared[:, c * CHUNK:(c + 1) * CHUNK], KV_T)
                Out[0, 0] = KV_T[0, 0]
                return
            if variant == 'M1':
                # Manual transpose, thread owns a dst row: contiguous dst
                # stores, strided src loads.
                KV_T = T.alloc_shared([CHUNK, BN], T.float16)
                acc_o0 = T.alloc_fragment([BH, CHUNK], T.float32)
                acc_o1 = T.alloc_fragment([BH, CHUNK], T.float32)
                acc_o2 = T.alloc_fragment([BH, CHUNK], T.float32)
                acc_o3 = T.alloc_fragment([BH, CHUNK], T.float32)
                T.fill(acc_o0, 0)
                T.fill(acc_o1, 0)
                T.fill(acc_o2, 0)
                T.fill(acc_o3, 0)
                for i, j in T.Parallel(BN, CHUNK):
                    KV_T[j, i] = KV_shared[i, j]
                T.gemm(S_shared, KV_T, acc_o0,
                       transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
                for i, j in T.Parallel(BN, CHUNK):
                    KV_T[j, i] = KV_shared[i, CHUNK + j]
                T.gemm(S_shared, KV_T, acc_o1,
                       transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
                for i, j in T.Parallel(BN, CHUNK):
                    KV_T[j, i] = KV_shared[i, 2 * CHUNK + j]
                T.gemm(S_shared, KV_T, acc_o2,
                       transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
                for i, j in T.Parallel(BN, CHUNK):
                    KV_T[j, i] = KV_shared[i, 3 * CHUNK + j]
                T.gemm(S_shared, KV_T, acc_o3,
                       transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
                for i, j in T.Parallel(BH, CHUNK):
                    Out[i, j] = acc_o0[i, j].astype(T.float16)
                    Out[i, CHUNK + j] = acc_o1[i, j].astype(T.float16)
                    Out[i, 2 * CHUNK + j] = acc_o2[i, j].astype(T.float16)
                    Out[i, 3 * CHUNK + j] = acc_o3[i, j].astype(T.float16)
                return
            if variant == 'M2':
                # Manual transpose, thread owns a src token: contiguous src
                # loads, strided dst stores.
                KV_T = T.alloc_shared([CHUNK, BN], T.float16)
                acc_o0 = T.alloc_fragment([BH, CHUNK], T.float32)
                acc_o1 = T.alloc_fragment([BH, CHUNK], T.float32)
                acc_o2 = T.alloc_fragment([BH, CHUNK], T.float32)
                acc_o3 = T.alloc_fragment([BH, CHUNK], T.float32)
                T.fill(acc_o0, 0)
                T.fill(acc_o1, 0)
                T.fill(acc_o2, 0)
                T.fill(acc_o3, 0)
                for i, j in T.Parallel(CHUNK, BN):
                    KV_T[i, j] = KV_shared[j, i]
                T.gemm(S_shared, KV_T, acc_o0,
                       transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
                for i, j in T.Parallel(CHUNK, BN):
                    KV_T[i, j] = KV_shared[j, CHUNK + i]
                T.gemm(S_shared, KV_T, acc_o1,
                       transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
                for i, j in T.Parallel(CHUNK, BN):
                    KV_T[i, j] = KV_shared[j, 2 * CHUNK + i]
                T.gemm(S_shared, KV_T, acc_o2,
                       transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
                for i, j in T.Parallel(CHUNK, BN):
                    KV_T[i, j] = KV_shared[j, 3 * CHUNK + i]
                T.gemm(S_shared, KV_T, acc_o3,
                       transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
                for i, j in T.Parallel(BH, CHUNK):
                    Out[i, j] = acc_o0[i, j].astype(T.float16)
                    Out[i, CHUNK + j] = acc_o1[i, j].astype(T.float16)
                    Out[i, 2 * CHUNK + j] = acc_o2[i, j].astype(T.float16)
                    Out[i, 3 * CHUNK + j] = acc_o3[i, j].astype(T.float16)
                return
            # variant 'B': T.transpose + four chunk gemms
            KV_T = T.alloc_shared([CHUNK, BN], T.float16)
            acc_o0 = T.alloc_fragment([BH, CHUNK], T.float32)
            acc_o1 = T.alloc_fragment([BH, CHUNK], T.float32)
            acc_o2 = T.alloc_fragment([BH, CHUNK], T.float32)
            acc_o3 = T.alloc_fragment([BH, CHUNK], T.float32)
            T.fill(acc_o0, 0)
            T.fill(acc_o1, 0)
            T.fill(acc_o2, 0)
            T.fill(acc_o3, 0)
            T.transpose(KV_shared[:, 0:CHUNK], KV_T)
            T.gemm(S_shared, KV_T, acc_o0,
                   transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
            T.transpose(KV_shared[:, CHUNK:2 * CHUNK], KV_T)
            T.gemm(S_shared, KV_T, acc_o1,
                   transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
            T.transpose(KV_shared[:, 2 * CHUNK:3 * CHUNK], KV_T)
            T.gemm(S_shared, KV_T, acc_o2,
                   transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
            T.transpose(KV_shared[:, 3 * CHUNK:4 * CHUNK], KV_T)
            T.gemm(S_shared, KV_T, acc_o3,
                   transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
            for i, j in T.Parallel(BH, CHUNK):
                Out[i, j] = acc_o0[i, j].astype(T.float16)
                Out[i, CHUNK + j] = acc_o1[i, j].astype(T.float16)
                Out[i, 2 * CHUNK + j] = acc_o2[i, j].astype(T.float16)
                Out[i, 3 * CHUNK + j] = acc_o3[i, j].astype(T.float16)
            if variant == 'A':
                acc_o = T.alloc_fragment([BH, DIM], T.float32)
                T.fill(acc_o, 0)
                T.gemm(S_shared, KV_shared, acc_o,
                       policy=T.GemmWarpPolicy.FullCol)
                for i, j in T.Parallel(BH, DIM):
                    Out[i, j] = acc_o[i, j].astype(T.float16)
            elif variant == 'F':
                # PV with the A operand straight from an fp16 fragment
                # (skips the acc_s -> S_shared cast copy + its barrier).
                acc_o = T.alloc_fragment([BH, DIM], T.float32)
                s_frag = T.alloc_fragment([BH, BN], T.float16)
                T.fill(acc_o, 0)
                T.copy(S_g, s_frag)
                T.gemm(s_frag, KV_shared, acc_o,
                       policy=T.GemmWarpPolicy.FullCol)
                for i, j in T.Parallel(BH, DIM):
                    Out[i, j] = acc_o[i, j].astype(T.float16)
            else:  # B: four independent [BH, CHUNK] fragments
                KV_T = T.alloc_shared([CHUNK, BN], T.float16)
                acc_o0 = T.alloc_fragment([BH, CHUNK], T.float32)
                acc_o1 = T.alloc_fragment([BH, CHUNK], T.float32)
                acc_o2 = T.alloc_fragment([BH, CHUNK], T.float32)
                acc_o3 = T.alloc_fragment([BH, CHUNK], T.float32)
                T.fill(acc_o0, 0)
                T.fill(acc_o1, 0)
                T.fill(acc_o2, 0)
                T.fill(acc_o3, 0)
                T.transpose(KV_shared[:, 0:CHUNK], KV_T)
                T.gemm(S_shared, KV_T, acc_o0,
                       transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
                T.transpose(KV_shared[:, CHUNK:2 * CHUNK], KV_T)
                T.gemm(S_shared, KV_T, acc_o1,
                       transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
                T.transpose(KV_shared[:, 2 * CHUNK:3 * CHUNK], KV_T)
                T.gemm(S_shared, KV_T, acc_o2,
                       transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
                T.transpose(KV_shared[:, 3 * CHUNK:4 * CHUNK], KV_T)
                T.gemm(S_shared, KV_T, acc_o3,
                       transpose_B=True, policy=T.GemmWarpPolicy.FullCol)
                for i, j in T.Parallel(BH, CHUNK):
                    Out[i, j] = acc_o0[i, j].astype(T.float16)
                    Out[i, CHUNK + j] = acc_o1[i, j].astype(T.float16)
                    Out[i, 2 * CHUNK + j] = acc_o2[i, j].astype(T.float16)
                    Out[i, 3 * CHUNK + j] = acc_o3[i, j].astype(T.float16)
    return kern


def ref(s, kv):
    return (s.float() @ kv.float())


if __name__ == '__main__':
    import probe_floor
    g = torch.Generator(device='cuda').manual_seed(0)
    s = torch.randn(BH, BN, device='cuda', dtype=torch.float16, generator=g)
    kv = torch.randn(BN, DIM, device='cuda', dtype=torch.float16, generator=g)
    kvt = kv.T.contiguous()
    want = ref(s, kv)
    variants = ('A', 'C', 'F')
    kerns, errs = {}, {}
    for variant in variants:
        try:
            k = make(variant)
        except Exception as e:
            print(f'{variant}: COMPILE FAIL: {type(e).__name__}: {str(e)[:200]}')
            continue
        out = torch.zeros(BH, DIM, device='cuda', dtype=torch.float16)
        args = (s, kvt if variant == 'C' else kv, out)
        try:
            k(*args)
            torch.cuda.synchronize()
        except Exception as e:
            print(f'{variant}: RUN FAIL: {type(e).__name__}: {str(e)[:200]}')
            continue
        err = (out.float() - want).abs()
        errs[variant] = (err / want.abs().clamp_min(1e-3)).max().item()
        kerns[variant] = (k, args)

    # Warm every graph, then round-robin replay so clock/tenant drift hits
    # all variants equally; keep per-variant min.
    import probe_floor
    graphs = {}
    for v, (k, args) in kerns.items():
        for _ in range(5):
            k(*args)
        torch.cuda.synchronize()
        g = torch.cuda.CUDAGraph()
        with torch.cuda.graph(g):
            for _ in range(100):
                k(*args)
        g.replay()
        torch.cuda.synchronize()
        graphs[v] = g
    best = {v: 1e9 for v in graphs}
    for rep in range(30):
        for v, g in graphs.items():
            a, b = torch.cuda.Event(True), torch.cuda.Event(True)
            a.record(); g.replay(); b.record(); b.synchronize()
            us = a.elapsed_time(b) * 1000 / 100
            if us < best[v]:
                best[v] = us
    print('\n== round-robin min-of-30')
    for v in variants:
        if v in best:
            print(f'{v}: max_rel={errs.get(v, float("nan")):.3e} '
                  f'best={best[v]:.2f} us')
