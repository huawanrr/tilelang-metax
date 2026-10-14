"""Validate dispatch thresholds, source identity, input refresh and the host guard."""
import ast
import hashlib
import json
from pathlib import Path
import sys

import torch

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module
from kernel_source import get_kernel_source
from verify_nsa import check_case


def cfg(b, t, h, causal, s=8):
    return dict(B=b, SEQ_LEN=t, H=h, HQ=16*h, D=64, S=s, block_size=16, is_causal=causal)


def edge_indices(indices):
    batch, length, heads, selected = indices.shape
    last = (length - 1) // 16
    row = [-1, last + 1, last, 0, 1, last // 2, 0, -7]
    pattern = torch.tensor([[-1] * selected, (row * ((selected + 7) // 8))[:selected],
                            [0] * selected], device=indices.device, dtype=torch.int64)
    return pattern[torch.arange(length, device=indices.device) % 3].view(
        1, length, 1, selected).expand(batch, length, heads, selected)


def device_source(module, case):
    return get_kernel_source(module._get_kernel(case['B'], case['SEQ_LEN'], case['H'],
        case['HQ'], case['D'], case['S'], case['block_size'], case['is_causal'], None))


@torch.no_grad()
def main():
    trial = load_module(str(HERE / 'submission.py'))
    dev = load_module(str(HERE / 'nsa.py'))
    base = load_module(str(ROOT / 'experiments/20260927_next/selected.py'))
    minor = load_module(str(ROOT / 'experiments/20260928_grid_order/batch_minor.py'))
    quad = load_module(str(ROOT / 'experiments/20260928_grid_order/quad_batch_minor.py'))
    report = dict(boundaries=[], sources=[], refresh=[], guarded=[])
    def persist():
        (HERE / 'trial_checks.json').write_text(json.dumps(report, indent=2) + '\n')
    for b, h in [(4, 1), (2, 2), (8, 1), (4, 2)]:
        for length in (1023, 1024, 1025):
            for causal in (False, True):
                case = cfg(b, length, h, causal)
                error = check_case(trial, case, 104, None, edge_indices)
                grid = b * h * length
                reference = quad if grid >= 8192 else minor if grid >= 4096 else base
                sources = [device_source(m, case) for m in (trial, dev, reference)]
                assert sources[0] == sources[1] == sources[2], case
                assert 'memcpy_async' not in sources[0] and 'cp.async' not in sources[0]
                report['boundaries'].append(dict(config=case, max_abs_error=error))
                report['sources'].append(dict(config=case,
                    path='quad' if grid >= 8192 else 'minor' if grid >= 4096 else 'base',
                    sha256=hashlib.sha256(sources[0].encode()).hexdigest()))
                print('BOUNDARY PASS', case, error, flush=True)
                persist()
    for b, h, causal in [(4, 1, True), (4, 2, False)]:
        case = cfg(b, 1025, h, causal, s=16)
        error = check_case(trial, case, 105, None, edge_indices)
        assert device_source(trial, case) == device_source(base, case)
        report['boundaries'].append(dict(config=case, max_abs_error=error))
        report['sources'].append(dict(config=case, path='base', S16_unchanged=True))
        print('S16 FALLBACK PASS', case, error, flush=True)
        persist()
    for b, h, causal in [(4, 1, True), (4, 2, False)]:
        case = cfg(b, 1025, h, causal)
        q, k, v, indices = make_inputs(case, seed=106)
        indices = edge_indices(indices).contiguous()
        fn = trial.native_sparse_attention(b, h*16, 1025, 64, causal, scale=None,
            block_size=16, groups=16, selected_blocks=8)
        output = torch.empty_like(q)
        for iteration in range(3):
            if iteration:
                nq, nk, nv, _ = make_inputs(case, seed=106 + iteration)
                q.copy_(nq)
                k.copy_(nk)
                v.copy_(nv)
                indices.copy_(indices.roll(1, dims=1))
            expected = sparse_reference(q, k, v, indices, 16, causal, None)
            output.fill_(float('nan'))
            trial.run_kernel(q, k, v, indices, output, b, 1025, h, h*16, 64, 8, 16, causal, None)
            error = max(check_output(output, expected, 'refresh run_kernel'),
                        check_output(fn(q, k, v, indices), expected, 'refresh factory'))
            report['refresh'].append(dict(config=case, iteration=iteration, max_abs_error=error))
            print('REFRESH PASS', case, iteration, error, flush=True)
            persist()
    guard_path = ROOT / 'experiments/20260928_guard_fix/check_restricted_host.py'
    tree = ast.parse(guard_path.read_text())
    cutoff = next(i for i, node in enumerate(tree.body) if isinstance(node, ast.Assign)
                  and any(isinstance(t, ast.Name) and t.id == 'small' for t in node.targets))
    namespace = dict(__file__=str(guard_path), __name__='s8_order_guard_fixture')
    exec(compile(ast.Module(body=tree.body[:cutoff], type_ignores=[]), str(guard_path), 'exec'), namespace)
    guarded = namespace['guarded_module'](str(HERE / 'submission.py'))
    for case in [cfg(4, 1025, 1, True), cfg(4, 1025, 2, False),
                 cfg(4, 1023, 1, True), cfg(4, 1025, 1, False, s=16)]:
        error = check_case(guarded, case, 107, None, edge_indices)
        report['guarded'].append(dict(config=case, max_abs_error=error, both_interfaces=True))
        print('GUARDED PASS', case, error, flush=True)
        persist()
    report.update(status='PASS', official_sandbox=False)
    persist()
    print('PASS', {k: len(report[k]) for k in ('boundaries', 'sources', 'refresh', 'guarded')}, flush=True)


if __name__ == '__main__':
    main()
