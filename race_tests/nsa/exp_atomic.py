"""Smoke test variants: which T.atomic_add form lowers on MACA?"""
import sys

import torch
import tilelang
import tilelang.language as T

MODE = sys.argv[1] if len(sys.argv) > 1 else "prev"


@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True})
def atomic_probe(n, threads=64, mode="prev"):
    @T.prim_func
    def k(src: T.Tensor((n,), T.int32), cnt: T.Tensor((8,), T.int32),
          dst: T.Tensor((n,), T.int32)):
        with T.Kernel(tilelang.cdiv(n, threads), threads=threads) as (bx):
            for i in T.Parallel(threads):
                if bx * threads + i < n:
                    v = src[bx * threads + i]
                    if mode == "prev":
                        slot = T.atomic_add(cnt[v], 1, return_prev=True)
                        dst[bx * threads + i] = slot
                    elif mode == "prev2":
                        tmp = T.alloc_local((1,), T.int32)
                        tmp[0] = T.atomic_add(cnt[v], 1, return_prev=True)
                        dst[bx * threads + i] = tmp[0]
                    elif mode == "discard":
                        T.atomic_add(cnt[v], 1)
                        dst[bx * threads + i] = v
                    elif mode == "expr":
                        # atomic in expression position, no temp binding
                        dst[bx * threads + i] = T.atomic_add(cnt[v], 1, return_prev=True)

    return k


n = 1000
src = torch.randint(0, 8, (n,), device="cuda", dtype=torch.int32)
cnt = torch.zeros(8, device="cuda", dtype=torch.int32)
dst = torch.zeros(n, device="cuda", dtype=torch.int32)
k = atomic_probe(n, mode=MODE)
k(src, cnt, dst)
torch.cuda.synchronize()
counts = torch.bincount(src, minlength=8)
print("cnt      :", cnt.cpu().tolist())
print("bincount :", counts.cpu().tolist())
print("match    :", bool((cnt == counts).all()))
ok = True
for v in range(8):
    slots = dst[src == v].cpu().tolist()
    ok &= sorted(slots) == list(range(len(slots)))
print("slots unique per bucket:", ok)
