"""Check whether explicit index bounds avoid the old AccessPtrLowerer failure."""
from pathlib import Path
import json
import torch
import tilelang
import tilelang.language as T


@tilelang.jit
def bounded_atomic(n=256, shared=True):
    @T.prim_func
    def kernel(Src: T.Tensor([n], T.int32), Counts: T.Tensor([8], T.int32),
               Slots: T.Tensor([n], T.int32)):
        with T.Kernel(1, threads=256):
            local_counts = T.alloc_shared([8], T.int32)
            if shared:
                T.clear(local_counts)
                T.sync_threads()
            for i in T.Parallel(n):
                bucket = T.min(T.max(Src[i], 0), 7)
                if shared:
                    Slots[i] = T.atomic_add(local_counts[bucket], 1, return_prev=True)
                else:
                    Slots[i] = T.atomic_add(Counts[bucket], 1, return_prev=True)
            if shared:
                T.sync_threads()
                T.copy(local_counts, Counts)
    return kernel


def main():
    rows = []
    for shared in (True, False):
        src = torch.arange(256, device='cuda', dtype=torch.int32) % 8
        counts = torch.zeros(8, device='cuda', dtype=torch.int32)
        slots = torch.full_like(src, -1)
        try:
            compiled = bounded_atomic(shared=shared)
            compiled(src, counts, slots)
            torch.cuda.synchronize()
            assert counts.tolist() == [32] * 8
            for b in range(8):
                assert sorted(slots[src == b].tolist()) == list(range(32))
            Path(__file__).with_name(f'atomic_shared{shared}.cpp').write_text(compiled.get_kernel_source())
            rows.append(dict(shared=shared, status='PASS'))
        except Exception as e:
            rows.append(dict(shared=shared, status='FAIL', error=str(e)))
        print(rows[-1], flush=True)
    Path(__file__).with_name('atomic_probe.json').write_text(json.dumps(rows, indent=2) + '\n')


if __name__ == '__main__':
    main()
