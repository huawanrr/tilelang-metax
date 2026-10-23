"""Probe: max dynamic shared memory per block on the C500.

The 64 KiB figure in NOTES gates every tile-size decision; if the hardware
allows more per block, the full-size KV_T coexistence (no in-loop transpose)
comes back on the table.
"""
import torch
import tilelang
import tilelang.language as T


def make(kb: int):
    n = kb * 1024 // 2  # fp16 elements

    @tilelang.jit
    def kern(
        Inp: T.Tensor([n], T.float16),
        Out: T.Tensor([1], T.float16),
    ):
        with T.Kernel(1, threads=128):
            big = T.alloc_shared([n], T.float16)
            for i, j in T.Parallel(128, n // 128):
                big[j * 128 + i] = Inp[j * 128 + i]
            Out[0] = (big[0] + big[n - 1]).astype(T.float16)
    return kern


if __name__ == '__main__':
    x = torch.randn(128 * 512, device='cuda', dtype=torch.float16)
    out = torch.zeros(1, device='cuda', dtype=torch.float16)
    for kb in (56, 64, 72, 80, 96, 112, 120, 128, 160):
        n = kb * 512
        try:
            k = make(kb)
            r = k(x[:n], out)
            torch.cuda.synchronize()
            print(f'{kb} KB shared: OK sum={r.item():.1f}')
        except Exception as e:
            print(f'{kb} KB shared: FAIL {type(e).__name__} {str(e)[:150]}')
