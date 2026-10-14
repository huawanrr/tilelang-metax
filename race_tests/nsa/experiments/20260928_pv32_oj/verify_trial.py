"""Check trial dispatch boundaries, device sources, input freshness and host guard."""
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


def edge_indices(indices):
    batch, length, heads, selected = indices.shape
    assert selected == 1
    last = (length - 1) // 32
    pattern = torch.tensor([-1, last + 1, last, 0, 1, last // 2, -7],
                           device=indices.device, dtype=torch.int64)
    values = pattern[torch.arange(length, device=indices.device) % len(pattern)]
    return values.view(1, length, 1, 1).expand(batch, length, heads, 1)


def cfg(b, t, h, causal):
    return dict(B=b, SEQ_LEN=t, H=h, HQ=16*h, D=128, S=1,
                block_size=32, is_causal=causal)


def compile_source(module, case, scale=None, **knobs):
    return get_kernel_source(module._get_kernel(case['B'], case['SEQ_LEN'], case['H'],
        case['HQ'], case['D'], case['S'], case['block_size'], case['is_causal'], scale, **knobs))


def digest(text):
    return hashlib.sha256(text.encode()).hexdigest()


@torch.no_grad()
def main():
    candidate = load_module(str(HERE / 'submission.py'))
    dev = load_module(str(HERE / 'nsa.py'))
    base = load_module(str(ROOT / 'experiments/20260927_next/submission.py'))
    probe = load_module(str(ROOT / 'experiments/20260928_output_split/pv_tiles32.py'))
    report = dict(boundaries=[], sources=[], refresh=[], guarded=[])
    for b, h, center in [(1, 1, 4096), (2, 1, 2048), (2, 2, 1024)]:
        for t in (center - 1, center, center + 1):
            for causal in (False, True):
                case = cfg(b, t, h, causal)
                error = check_case(candidate, case, 91, None, edge_indices)
                report['boundaries'].append(dict(config=case, max_abs_error=error))
                enabled = b * t * h >= 4096
                reference = probe if enabled else base
                sources = [compile_source(m, case) for m in (candidate, dev, reference)]
                assert len({digest(s) for s in sources}) == 1, case
                assert 'memcpy_async' not in sources[0] and 'cp.async' not in sources[0]
                report['sources'].append(dict(config=case, trial=enabled, sha256=digest(sources[0])))
                print('BOUNDARY PASS', case, error, flush=True)
                (HERE / 'trial_checks.json').write_text(json.dumps(report, indent=2) + '\n')

    # Explicit alternate schedules continue to use the original implementation.
    case = cfg(4, 1024, 1, True)
    for knobs in [dict(late_normalize=False), dict(kv_split=True)]:
        assert compile_source(candidate, case, **knobs) == compile_source(base, case, **knobs)
        report['sources'].append(dict(config=case, knobs=knobs, trial=False, equivalent_to_base=True))

    for causal in (False, True):
        case = cfg(2, 1025, 2, causal)
        q, k, v, indices = make_inputs(case, seed=92)
        indices = edge_indices(indices).contiguous()
        fn = candidate.native_sparse_attention(2, 32, 1025, 128, causal,
            scale=None, block_size=32, groups=16, selected_blocks=1)
        output = torch.empty_like(q)
        for iteration in range(3):
            if iteration:
                nq, nk, nv, _ = make_inputs(case, seed=92 + iteration)
                q.copy_(nq)
                k.copy_(nk)
                v.copy_(nv)
                indices.copy_(indices.roll(1, dims=1))
            expected = sparse_reference(q, k, v, indices, 32, causal, None)
            output.fill_(float('nan'))
            candidate.run_kernel(q, k, v, indices, output, 2, 1025, 2, 32, 128, 1, 32, causal, None)
            error = max(check_output(output, expected, 'refresh run_kernel'),
                        check_output(fn(q, k, v, indices), expected, 'refresh factory'))
            report['refresh'].append(dict(config=case, iteration=iteration, max_abs_error=error))
            print('REFRESH PASS', causal, iteration, error, flush=True)

    # Reuse the existing real RestrictedPython fixture without running its old
    # fixed-path regression suite. Only its import/function definitions run.
    guard_path = ROOT / 'experiments/20260928_guard_fix/check_restricted_host.py'
    tree = ast.parse(guard_path.read_text())
    cutoff = next(i for i, node in enumerate(tree.body) if isinstance(node, ast.Assign)
                  and any(isinstance(t, ast.Name) and t.id == 'small' for t in node.targets))
    fixture = ast.Module(body=tree.body[:cutoff], type_ignores=[])
    namespace = dict(__file__=str(guard_path), __name__='nsa_guard_fixture')
    exec(compile(fixture, str(guard_path), 'exec'), namespace)
    guarded = namespace['guarded_module'](str(HERE / 'submission.py'))
    for case in (cfg(8, 1024, 1, True), cfg(2, 1025, 2, False), cfg(2, 1023, 2, True),
                 dict(B=2, SEQ_LEN=37, H=2, HQ=32, D=64, S=8, block_size=16, is_causal=False)):
        from verify_nsa import edge_indices as original_edges
        indices = edge_indices if case['S'] == 1 else original_edges
        error = check_case(guarded, case, 93, None, indices)
        report['guarded'].append(dict(config=case, max_abs_error=error, both_interfaces=True))
        print('GUARDED PASS', case, error, flush=True)
    report.update(status='PASS', official_sandbox=False)
    (HERE / 'trial_checks.json').write_text(json.dumps(report, indent=2) + '\n')
    print('PASS:', {key: len(report[key]) for key in ('boundaries', 'sources', 'refresh', 'guarded')}, flush=True)


if __name__ == '__main__':
    main()
