"""Validate isolated D32 dispatch, edge indices, live graph inputs and host guards."""
import argparse
import ast
import ctypes
import hashlib
import importlib.util
import inspect
import json
from pathlib import Path
import re
import sys

import torch

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module
from kernel_source import get_kernel_source
from verify_nsa import check_case

spec = importlib.util.spec_from_file_location('nsa_d32_helpers',
    ROOT / 'experiments/20261002_tuning/verify_candidate.py')
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)
compile_case, edge_indices = helpers.compile_case, helpers.edge_indices
parts, flags, shared_bytes = helpers.parts, helpers.flags, helpers.shared_bytes


def cfg(t, b=1, h=1, causal=True, d=32, bs=16, s=1):
    return dict(B=b, SEQ_LEN=t, H=h, HQ=16*h, D=d, S=s,
                block_size=bs, is_causal=causal)


def selected_path(case, config):
    b, t, h, d, s, bs = (case[k] for k in ('B', 'SEQ_LEN', 'H', 'D', 'S', 'block_size'))
    if not (d == 32 and s == 1 and bs == 16 and case['HQ'] == 16*h):
        return 'base'
    grid = b*t*h
    if config['compact_min_grid_exclusive'] < grid < config['compact_max_grid_exclusive']:
        return 'compact'
    if grid <= config['direct_max_grid']:
        if config['direct_max_heads'] is None or h <= config['direct_max_heads']:
            return 'guard'
    if config['shuffle_min_grid'] <= grid <= config['shuffle_max_grid']:
        if config['shuffle_max_heads'] is None or h <= config['shuffle_max_heads']:
            return 'guard'
    return 'base'


@torch.no_grad()
def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--directory', required=True)
    p.add_argument('--output', required=True)
    p.add_argument('--resume', action='store_true')
    args = p.parse_args()
    torch.backends.cuda.matmul.allow_tf32 = False
    directory = Path(args.directory)
    assembly = json.loads((directory / 'assembly.json').read_text())
    config = assembly['config']
    dev_path, sub_path = directory / 'nsa.py', directory / 'submission.py'
    dev, trial = load_module(str(dev_path)), load_module(str(sub_path))
    base = load_module(str(ROOT / 'experiments/20261002_final/submission.py'))
    probes = dict(base=base,
        guard=load_module(str(HERE / 'index_guards_simple.py')),
        compact=load_module(str(HERE / 'd32_queries1_prefetch1_v2.py')))
    for name in ('run_kernel', 'native_sparse_attention'):
        assert inspect.signature(getattr(trial, name)) == inspect.signature(getattr(base, name)), name
    report = dict(command=sys.argv, status='running', boundaries=[], sources=[],
        extremes=[], fallbacks=[], refresh=[], guarded=[], unsupported=[], official_sandbox=False,
        reference_matmul_tf32=False,
        source_sha256={str(path): hashlib.sha256(path.read_bytes()).hexdigest()
                       for path in (dev_path, sub_path)})
    output = Path(args.output)
    if args.resume:
        previous = json.loads(output.read_text())
        assert previous['source_sha256'] == report['source_sha256']
        assert previous['status'] == 'running'
        previous.setdefault('command_history', [previous['command']]).append(sys.argv)
        previous['command'] = sys.argv
        report = previous

    def persist():
        output.write_text(json.dumps(report, indent=2) + '\n')

    cases = []
    for threshold in (192, 512, 1024, config['shuffle_max_grid']):
        cases.extend(cfg(threshold+delta, causal=delta != 0) for delta in (-1, 0, 1))
    cases += [cfg(37, causal=False), cfg(37, h=2, causal=False), cfg(256, h=2),
              cfg(257, h=2, causal=False), cfg(384, b=2), cfg(192, h=4),
              cfg(512, h=2), cfg(768, b=2, h=2), cfg(1024, b=8),
              cfg(8192), cfg(129, d=64), cfg(129, d=128),
              cfg(1025, d=128, bs=32), cfg(4096, d=64, s=2),
              cfg(4096, d=64, s=8), cfg(37, s=2, causal=False), cfg(37, bs=32)]
    for groups in (32,):
        case = cfg(129)
        case['HQ'] = groups
        cases.append(case)
    persist()
    for i, case in enumerate(cases):
        path = selected_path(case, config)
        if i < len(report['boundaries']):
            assert report['boundaries'][i]['config'] == case
            assert report['boundaries'][i]['path'] == path
            assert report['sources'][i]['config'] == case
            continue
        error = check_case(trial, case, 3101+i, None,
            lambda idx, bs=case['block_size']: edge_indices(idx, bs))
        kernels = [compile_case(module, case) for module in (trial, dev, probes[path])]
        sources = [get_kernel_source(kernel) for kernel in kernels]
        assert sources[0] == sources[1] == sources[2], (path, case)
        assert flags(kernels[0]) == flags(kernels[1]) == flags(kernels[2]), (path, case)
        audits = []
        for part in parts(kernels[0]):
            src = part.get_kernel_source()
            assert not any(marker in src for marker in
                ('memcpy_async', 'cp.async', 'maca_async', 'tma_load', 'mbarrier'))
            assert not any(value for key, value in part.pass_configs.items()
                if 'disable_data_race' in str(key) or 'disable_safe_memory' in str(key))
            shared, method, host_hash = shared_bytes(part)
            audits.append(dict(wave_barriers=src.count('__syncwarp('),
                block_barriers=src.count('__syncthreads('), shared_bytes=shared,
                shared_evidence=method, host_source_sha256=host_hash,
                source_sha256=hashlib.sha256(src.encode()).hexdigest(),
                launch_bounds=re.findall(r'__launch_bounds__\((\d+),', src)))
        if path == 'compact':
            assert len(audits) == 1
            assert audits[0]['shared_bytes'] == 1024
            assert audits[0]['wave_barriers'] == 1 and audits[0]['block_barriers'] == 0
            assert audits[0]['launch_bounds'] == ['64']
        report['boundaries'].append(dict(config=case, path=path, max_abs_error=error, both_interfaces=True))
        report['sources'].append(dict(config=case, path=path, parts=audits,
            compile_flags=flags(kernels[0]), probe_source_and_flags_equal=True))
        persist()
        print('BOUNDARY PASS', path, case, error, flush=True)

    # G8 is outside the existing backend's 16-row MMA footprint. Preserve
    # that baseline failure instead of claiming new support for this shape.
    unsupported = cfg(129)
    unsupported['HQ'] = 8
    if not any(r['config'] == unsupported for r in report['unsupported']):
        errors = []
        for module in (base, trial):
            try:
                compile_case(module, unsupported)
            except Exception as exc:
                message = str(exc)
                assert 'M must be divisible by 16, but got 8' in message, message
                errors.append(dict(type=type(exc).__name__, reason='M must be divisible by 16, but got 8'))
            else:
                raise AssertionError('Expected the pre-existing G8 backend constraint')
        assert errors[0] == errors[1]
        report['unsupported'].append(dict(config=unsupported, baseline_and_candidate=errors,
                                          same_baseline_failure=True))
        persist()

    knobs_list = [dict(q_preload=False), dict(kv_reuse=False), dict(nmax=False),
        dict(stage_regs=False), dict(kv_split=True), dict(q_frag=True),
        dict(o_stage=True), dict(kv_frag=True), dict(min_blocks=1), dict(pair=2),
        dict(num_stages=2), dict(online_unroll=1), dict(late_normalize=True), dict(threads=128)]
    for case in (cfg(128), cfg(768), cfg(2048)):
        for knobs in knobs_list:
            if any(r['config'] == case and r.get('knobs') == knobs
                   for r in report['fallbacks'] + report['unsupported']):
                continue
            try:
                old = compile_case(base, case, **knobs)
            except Exception as exc:
                known = ((knobs == {'kv_frag': True} and isinstance(exc, UnboundLocalError)
                          and "'KV_shared'" in str(exc))
                         or (knobs == {'threads': 128} and 'Divide by zero' in str(exc)))
                if not known:
                    raise
                reason = str(exc).splitlines()[-1]
                error_type = type(exc).__name__
                try:
                    compile_case(trial, case, **knobs)
                except Exception as current:
                    assert type(current).__name__ == error_type
                    assert str(current).splitlines()[-1] == reason
                else:
                    raise AssertionError('Expected the same baseline compilation failure')
                report['unsupported'].append(dict(config=case, knobs=knobs,
                    same_baseline_failure=True, error_type=error_type, reason=reason))
                persist()
                continue
            new = compile_case(trial, case, **knobs)
            assert get_kernel_source(old) == get_kernel_source(new), (case, knobs)
            assert flags(old) == flags(new), (case, knobs)
            report['fallbacks'].append(dict(config=case, knobs=knobs, source_and_flags_equal=True))
            persist()
    print('FALLBACK PASS', len(report['fallbacks']), flush=True)

    extreme_cases = [cfg(37, causal=False), cfg(193), cfg(512, h=1, causal=False),
        cfg(513), cfg(129, b=2, h=2, causal=False), cfg(1025), cfg(4096, causal=False)]
    for case in extreme_cases:
        assert selected_path(case, config) != 'base'
        error = check_case(trial, case, 3301, None,
            lambda idx: helpers.extreme_indices(idx, 16))
        report['extremes'].append(dict(config=case, max_abs_error=error, both_interfaces=True))
        persist()
        print('EXTREME PASS', case, error, flush=True)

    runtime = ctypes.CDLL('/opt/maca/lib/libmcruntime.so')
    pointer = ctypes.c_void_p()
    assert runtime.mcStreamCreate(ctypes.byref(pointer)) == 0
    stream = torch.cuda.ExternalStream(pointer.value)
    torch.cuda.graph.default_capture_stream = stream
    live_cases = [cfg(37, h=2, causal=False), cfg(256), cfg(129, b=2, h=2, causal=False), cfg(1025)]
    for case in live_cases:
        q, k, v, indices = make_inputs(case, seed=3401)
        indices.copy_(edge_indices(indices, 16))
        factory = trial.native_sparse_attention(case['B'], case['HQ'], case['SEQ_LEN'],
            case['D'], case['is_causal'], scale=0.07, block_size=16, groups=16, selected_blocks=1)
        out = torch.empty_like(q)
        call_args = (q, k, v, indices, out, case['B'], case['SEQ_LEN'], case['H'],
                     case['HQ'], case['D'], 1, 16, case['is_causal'], 0.07)
        trial.run_kernel(*call_args)
        stream.wait_stream(torch.cuda.current_stream())
        stream.synchronize()
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph, stream=stream):
            trial.run_kernel(*call_args)
        addresses = [x.data_ptr() for x in (q, k, v, indices, out)]
        for iteration in range(3):
            if iteration:
                nq, nk, nv, _ = make_inputs(case, seed=3401+iteration)
                q.copy_(nq)
                k.copy_(nk)
                v.copy_(nv)
                indices.copy_(indices.roll(1, dims=1))
            assert addresses == [x.data_ptr() for x in (q, k, v, indices, out)]
            expected = sparse_reference(q, k, v, indices, 16, case['is_causal'], 0.07)
            out.fill_(float('nan'))
            graph.replay()
            error = max(check_output(out, expected, 'live graph'),
                        check_output(factory(q, k, v, indices), expected, 'live factory'))
            report['refresh'].append(dict(config=case, iteration=iteration, max_abs_error=error,
                same_addresses=True, graph_replay=True, both_interfaces=True))
            persist()
        del graph
        print('REFRESH PASS', case, flush=True)

    guard_path = ROOT / 'experiments/20260928_guard_fix/check_restricted_host.py'
    tree = ast.parse(guard_path.read_text())
    cutoff = next(i for i, n in enumerate(tree.body) if isinstance(n, ast.Assign)
        and any(isinstance(t, ast.Name) and t.id == 'small' for t in n.targets))
    env = dict(__file__=str(guard_path), __name__='nsa_d32_guard_fixture')
    exec(compile(ast.Module(body=tree.body[:cutoff], type_ignores=[]), str(guard_path), 'exec'), env)
    guarded = env['guarded_module'](str(sub_path))
    for case in live_cases + [cfg(1025, d=128, bs=32), cfg(4096, d=64, s=8)]:
        error = check_case(guarded, case, 3501, None,
            lambda idx, bs=case['block_size']: edge_indices(idx, bs))
        report['guarded'].append(dict(config=case, max_abs_error=error, both_interfaces=True))
        persist()
        print('GUARDED PASS', case, error, flush=True)
    report['status'] = 'PASS'
    persist()
    print('PASS', {k: len(report[k]) for k in
        ('boundaries', 'sources', 'extremes', 'fallbacks', 'refresh', 'guarded')}, flush=True)


if __name__ == '__main__':
    main()
