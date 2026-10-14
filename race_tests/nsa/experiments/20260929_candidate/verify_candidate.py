"""Validate new dispatch boundaries, frozen-source identity and live inputs."""
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


def cfg(b, t, h, d, bs=16, s=1, causal=True):
    return dict(B=b, SEQ_LEN=t, H=h, HQ=16 * h, D=d, S=s,
                block_size=bs, is_causal=causal)


def edge_indices(indices, bs):
    b, length, h, selected = indices.shape
    last = (length - 1) // bs
    mixed = [last, 0, last + 1, -3, 0, last, 1, 0]
    rows = [[-1] * selected, (mixed * ((selected + 7) // 8))[:selected],
            [0] * selected, [last + 1] * selected, [last] * selected]
    rows = torch.tensor(rows, device=indices.device, dtype=torch.int64)
    return rows[torch.arange(length, device=indices.device) % len(rows)].view(
        1, length, 1, selected).expand(b, length, h, selected)


def device_source(module, case, **knobs):
    return get_kernel_source(module._get_kernel(
        case['B'], case['SEQ_LEN'], case['H'], case['HQ'], case['D'], case['S'],
        case['block_size'], case['is_causal'], None, **knobs))


def selected_probe(case):
    d, bs, s = case['D'], case['block_size'], case['S']
    grid = case['B'] * case['H'] * case['SEQ_LEN']
    if s == 1 and d == 32 and bs == 16 and grid >= 1024:
        return 'd32'
    if s == 1 and d == 128 and bs == 16 and grid <= 128:
        return 'vec16'
    if s == 1 and grid <= 2048 and (
        (d == 128 and bs == 16 and grid > 128)
        or (d == 64 and (bs >= 32 or (bs == 16 and grid <= 256)))
    ):
        return 'linear'
    if s == 1 and d == 64 and bs == 16 and 1536 < grid <= 2560:
        return 'shared_q'
    if s == 1 and d == 128 and bs == 32 and grid >= 4096:
        return 'pv32'
    return 'base'


@torch.no_grad()
def main():
    dev = load_module(str(HERE / 'nsa.py'))
    trial = load_module(str(HERE / 'submission.py'))
    probes = {name: load_module(str(ROOT / path)) for name, path in {
        'base': 'experiments/20260928_s8_order_oj/nsa.py',
        'pv32': 'experiments/20260928_pv32_oj/nsa.py',
        'd32': 'experiments/20260929_recheck/d32_k_linear.py',
        'vec16': 'experiments/20260929_recheck/swizzle16.py',
        'linear': 'experiments/20260929_recheck/v_linear.py',
        'shared_q': 'experiments/20260929_recheck/q_shared_linear.py',
    }.items()}
    report = dict(boundaries=[], sources=[], explicit_fallbacks=[], refresh=[], guarded=[])

    def persist():
        (HERE / 'trial_checks.json').write_text(json.dumps(report, indent=2) + '\n')

    cases = []
    for b, t, h in [(1, 1023, 1), (1, 1024, 1), (1, 1025, 1),
                    (2, 511, 1), (1, 512, 2), (2, 257, 2)]:
        for causal in (True, False):
            cases.append(cfg(b, t, h, 32, causal=causal))
    for t in (127, 128, 129):
        for causal in (True, False):
            cases.append(cfg(1, t, 1, 128, causal=causal))
    cases.append(cfg(1, 64, 2, 128, causal=False))
    for t in (1023, 1024, 1025):
        cases.append(cfg(2, t, 1, 128, causal=False))
    for t in (255, 256, 257):
        cases.append(cfg(1, t, 1, 64, causal=False))
    cases.append(cfg(1, 128, 2, 64))
    for bs in (32, 64):
        for t in (1023, 1024, 1025):
            cases.append(cfg(2, t, 1, 64, bs, causal=False))
    for i, t in enumerate((1535, 1536, 1537, 1792, 2047, 2048, 2049, 2559, 2560, 2561)):
        cases.append(cfg(1, t, 1, 64, causal=bool(i % 2)))
    cases.append(cfg(2, 512, 2, 64, causal=False))
    for t in (1023, 1024, 1025):
        cases.append(cfg(4, t, 1, 128, 32, causal=False))
    cases += [cfg(4, 1024, 1, 64, s=8), cfg(4, 1025, 2, 64, s=8, causal=False),
              cfg(2, 37, 2, 64, s=16, causal=False)]
    for i, case in enumerate(cases):
        pattern = lambda indices, bs=case['block_size']: edge_indices(indices, bs)
        error = check_case(trial, case, 290 + i, None, pattern)
        name = selected_probe(case)
        sources = [device_source(mod, case) for mod in (trial, dev, probes[name])]
        assert sources[0] == sources[1] == sources[2], (name, case)
        assert not any(token in sources[0] for token in ('memcpy_async', 'cp.async', 'maca_async'))
        report['boundaries'].append(dict(config=case, max_abs_error=error, both_interfaces=True))
        report['sources'].append(dict(config=case, path=name, sha256=hashlib.sha256(sources[0].encode()).hexdigest()))
        print('BOUNDARY PASS', name, case, error, flush=True)
        persist()
    mid = cfg(1, 2048, 1, 64)
    for knobs in ({'q_preload': False}, {'q_frag': True}, {'nmax': False}, {'kv_reuse': False}):
        assert device_source(trial, mid, **knobs) == device_source(probes['base'], mid, **knobs)
        report['explicit_fallbacks'].append(dict(config=mid, knobs=knobs, source_equal=True))
        persist()
    for case in [cfg(1, 1025, 2, 32, causal=False), cfg(1, 2049, 1, 64),
                 cfg(4, 1025, 1, 128, 32, causal=False), cfg(4, 1025, 2, 64, s=8, causal=False)]:
        q, k, v, indices = make_inputs(case, seed=340)
        indices = edge_indices(indices, case['block_size']).contiguous()
        fn = trial.native_sparse_attention(case['B'], case['HQ'], case['SEQ_LEN'], case['D'],
            case['is_causal'], scale=None, block_size=case['block_size'], groups=16, selected_blocks=case['S'])
        output = torch.empty_like(q)
        for iteration in range(3):
            if iteration:
                nq, nk, nv, _ = make_inputs(case, seed=340 + iteration)
                q.copy_(nq)
                k.copy_(nk)
                v.copy_(nv)
                indices.copy_(indices.roll(1, dims=1))
            expected = sparse_reference(q, k, v, indices, case['block_size'], case['is_causal'], None)
            output.fill_(float('nan'))
            trial.run_kernel(q, k, v, indices, output, case['B'], case['SEQ_LEN'], case['H'], case['HQ'],
                             case['D'], case['S'], case['block_size'], case['is_causal'], None)
            error = max(check_output(output, expected, 'refresh run_kernel'),
                        check_output(fn(q, k, v, indices), expected, 'refresh factory'))
            report['refresh'].append(dict(config=case, iteration=iteration, max_abs_error=error))
            print('REFRESH PASS', case, iteration, error, flush=True)
            persist()
    guard_path = ROOT / 'experiments/20260928_guard_fix/check_restricted_host.py'
    tree = ast.parse(guard_path.read_text())
    cutoff = next(i for i, node in enumerate(tree.body) if isinstance(node, ast.Assign)
                  and any(isinstance(t, ast.Name) and t.id == 'small' for t in node.targets))
    env = dict(__file__=str(guard_path), __name__='nsa_929_guard_fixture')
    exec(compile(ast.Module(body=tree.body[:cutoff], type_ignores=[]), str(guard_path), 'exec'), env)
    guarded = env['guarded_module'](str(HERE / 'submission.py'))
    for case in [cfg(1, 1024, 1, 32, causal=False), cfg(1, 2048, 1, 64), cfg(1, 64, 2, 128, causal=False),
                 cfg(1, 512, 2, 64, 64), cfg(4, 1024, 1, 128, 32), cfg(4, 1025, 2, 64, s=8, causal=False)]:
        error = check_case(guarded, case, 350, None,
                           lambda indices, bs=case['block_size']: edge_indices(indices, bs))
        report['guarded'].append(dict(config=case, max_abs_error=error, both_interfaces=True))
        print('GUARDED PASS', case, error, flush=True)
        persist()
    report.update(status='PASS', official_sandbox=False)
    persist()
    print('PASS', {name: len(report[name]) for name in ('boundaries', 'sources', 'explicit_fallbacks', 'refresh', 'guarded')}, flush=True)


if __name__ == '__main__':
    main()
