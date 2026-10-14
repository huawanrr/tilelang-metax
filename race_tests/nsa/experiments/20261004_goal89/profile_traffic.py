"""Diagnostic copy/gather kernels; these do not compute attention or contribute a score."""
import json
from pathlib import Path
import statistics
import sys

import torch
import tilelang
import tilelang.language as T

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(ROOT / 'experiments/20261003_packed_compute'))
from benchmark_nsa import make_inputs
from compare_family import graph_latency


@tilelang.jit
def traffic_kernel(B, N, D, BS, threads, include_kv):
    @T.prim_func
    def kernel(Q: T.Tensor([B, N, 16, D], T.float16),
               K: T.Tensor([B, N, 1, D], T.float16),
               V: T.Tensor([B, N, 1, D], T.float16),
               Indices: T.Tensor([B, N, 1, 1], T.int32),
               Output: T.Tensor([B, N, 16, D], T.float16)):
        with T.Kernel(N, B, threads=threads) as (token, batch):
            q = T.alloc_fragment([16, D], T.float16)
            k = T.alloc_fragment([BS, D], T.float16)
            v = T.alloc_fragment([BS, D], T.float16)
            T.annotate_layout({
                q: T.Fragment([16, D],
                    forward_thread_fn=lambda qi, qd: (qi * D + qd) // 8 % threads,
                    forward_index_fn=lambda qi, qd: (qi * D + qd) // (threads * 8) * 8 + qd % 8),
                k: T.Fragment([BS, D],
                    forward_thread_fn=lambda kj, kd: (kj * D + kd) // 8 % threads,
                    forward_index_fn=lambda kj, kd: (kj * D + kd) // (threads * 8) * 8 + kd % 8),
                v: T.Fragment([BS, D],
                    forward_thread_fn=lambda vj, vd: (vj * D + vd) // 8 % threads,
                    forward_index_fn=lambda vj, vd: (vj * D + vd) // (threads * 8) * 8 + vd % 8),
            })
            T.copy(Q[batch, token, :, :], q)
            if include_kv:
                block = Indices[batch, token, 0, 0]
                if block >= 0 and block < T.ceildiv(N, BS) and block * BS <= token:
                    T.copy(K[batch, block * BS:(block + 1) * BS, 0, :], k)
                    T.copy(V[batch, block * BS:(block + 1) * BS, 0, :], v)
                    for section in T.unroll(BS // 16):
                        for i, d in T.Parallel(16, D):
                            q[i, d] += k[section * 16 + i, d] + v[section * 16 + i, d]
            T.copy(q, Output[batch, token, :, :])
    return kernel


@torch.no_grad()
def main():
    cases = {
        'oj6': dict(B=8, SEQ_LEN=1024, H=1, HQ=16, D=128, S=1, block_size=32, is_causal=True),
        'oj9': dict(B=1, SEQ_LEN=8192, H=1, HQ=16, D=64, S=1, block_size=16, is_causal=True),
    }
    report = dict(note='Diagnostic kernels only: copy reads Q/writes O; fold also reads every element of each valid K/V block and consumes it. Neither computes attention.', rows=[])
    for name, cfg in cases.items():
        inputs = make_inputs(cfg)
        output = torch.empty_like(inputs[0])
        for threads in (64, 128, 256):
            for fold in (False, True):
                fn = traffic_kernel(cfg['B'], cfg['SEQ_LEN'], cfg['D'], cfg['block_size'], threads, fold)
                def launch():
                    fn(*inputs, output)
                launch()
                assert bool(output.isfinite().all().item())
                if not fold:
                    torch.testing.assert_close(output, inputs[0], atol=0, rtol=0)
                values = [graph_latency(launch, 200, 7) * 1000 for _ in range(3)]
                row = dict(case=name, threads=threads, fold_kv=fold, us=statistics.median(values), rounds_us=values)
                report['rows'].append(row)
                print(json.dumps(row), flush=True)
                Path(__file__).with_name('traffic_profile.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
