"""Exercise atomic scheduling with contended, empty and partial KV blocks."""
import json
from pathlib import Path
import sys
import torch

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(HERE))
from experiment_bench import load_module
from profile_parts import check_schedule


@torch.no_grad()
def main():
    module = load_module(str(HERE / 'bucket_q4_multi.py'))
    report = []
    for length, heads, causal in [(1, 1, True), (31, 2, False),
            (33, 2, True), (255, 1, True), (257, 2, False), (1025, 2, True)]:
        bsz, bs, qt = 2, 32, 4
        nb = (length + bs - 1) // bs
        prepare = module.prepare_buckets(bsz, length, heads, bs, qt, causal)
        order = torch.empty((bsz, heads, nb + 1, length), device='cuda', dtype=torch.int32)
        schedule = torch.empty((bsz, heads, (length + qt - 1) // qt + nb + 1, 3),
                               device='cuda', dtype=torch.int32)
        indices = torch.empty((bsz, length, heads, 1), device='cuda', dtype=torch.int32)
        pattern = torch.tensor([-1, nb, nb - 1, 0, 1, -7], device='cuda', dtype=torch.int32)
        for mode in ('same', 'invalid', 'mixed', 'last'):
            if mode == 'mixed':
                indices.copy_(pattern[torch.arange(length, device='cuda') % 6]
                              .view(1, length, 1, 1).expand_as(indices))
            else:
                indices.fill_({'same': 0, 'invalid': -1, 'last': nb - 1}[mode])
            # Repeat into poisoned workspaces: no reliance on prior contents.
            for iteration in range(2):
                order.fill_(-999)
                schedule.fill_(-999)
                prepare(indices, order, schedule)
                check_schedule(indices, order, schedule, bs, causal, qt)
            row = dict(length=length, heads=heads, causal=causal, mode=mode, repeats=2)
            report.append(row)
            print('PASS', row, flush=True)
            (HERE / 'schedule_checks.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
