import os
import torch
import tilelang
import tilelang.language as T

LEVEL = int(os.environ.get('LEVEL', '2'))

@tilelang.jit(pass_configs={tilelang.PassConfigKey.TL_ENABLE_FAST_MATH: True})
def probe():
    @T.prim_func
    def main(Counter: T.Tensor([1, 2], "int32"), Sink: T.Tensor([1], T.float32)):
        with T.Kernel(1, threads=128) as (bid):
            v = T.alloc_fragment([1], "int32")
            T.atomic_add(Counter[bid, 0], 1, memory_order="seq_cst")
            if LEVEL == 1:
                v[0] = T.atomic_load(Counter[bid, 0], memory_order="seq_cst")
            else:
                while T.atomic_load(Counter[bid, 0], memory_order="seq_cst") < 1:
                    pass
                v[0] = T.atomic_load(Counter[bid, 0], memory_order="seq_cst")
            Sink[0] = T.cast(v[0], T.float32)
    return main

k = probe()
sink = torch.zeros(1, device='cuda', dtype=torch.float32)
for trial in range(3):
    k(torch.zeros(1, 2, device='cuda', dtype=torch.int32), sink)
    torch.cuda.synchronize()
    print(f'trial {trial}: sink={sink.item():.0f}')
print('COMPILE+RUN OK')
