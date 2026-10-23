import torch
import tilelang
import tilelang.language as T

@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True})
def probe_zero():
    @T.prim_func
    def main(Sink: T.Tensor([1], T.float32)):
        counter = T.alloc_global([4], "int32")
        with T.Kernel(1, threads=128) as (bid):
            Sink[0] = T.cast(counter[0] + counter[1] + counter[2] + counter[3], T.float32)
    return main

sink = torch.zeros(1, device='cuda', dtype=torch.float32)
k = probe_zero()
vals = []
for _ in range(5):
    sink.zero_()
    k(sink)
    torch.cuda.synchronize()
    vals.append(sink.item())
print('alloc_global zero-init check (expect 0.0 x5):', vals)
