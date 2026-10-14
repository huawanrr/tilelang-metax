"""Verify a synchronous, packed-word warp transpose primitive."""
import sys
from pathlib import Path

import tilelang
import tilelang.language as T
import torch


@tilelang.jit
def shuffle_words():
    @T.prim_func
    def kernel(A: T.Tensor([64, 8], T.float16), O: T.Tensor([64, 8], T.float16)):
        with T.Kernel(1, threads=64):
            tid = T.get_thread_binding()
            raw = T.alloc_local([8], T.float16)
            words = T.Tensor([4], T.uint32, data=raw.data, scope="local")
            result = T.alloc_local([8], T.float16)
            outwords = T.Tensor([4], T.uint32, data=result.data, scope="local")
            for j in T.vectorized(8):
                raw[j] = A[tid, j]
            for j in T.unroll(4):
                outwords[j] = T.shfl_sync(words[j], tid ^ 31, 64, 0xffffffffffffffff)
            for j in T.vectorized(8):
                O[tid, j] = result[j]
    return kernel


if __name__ == "__main__":
    torch.manual_seed(0)
    a = torch.randn((64, 8), device="cuda", dtype=torch.float16)
    output = torch.empty_like(a)
    kernel = shuffle_words()
    kernel(a, output)
    expected = a[torch.arange(64, device="cuda") ^ 31]
    torch.testing.assert_close(output, expected, rtol=0, atol=0)
    Path(__file__).with_suffix(".cpp").write_text(kernel.get_kernel_source())
    print("Packed uint32 warp shuffle: exact PASS")
