"""Verify changed paths, dispatch boundaries, live inputs, and restricted host code."""
import argparse
import ast
import ctypes
import hashlib
import importlib.util
import inspect
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

spec = importlib.util.spec_from_file_location('nsa_1005_helpers',
    ROOT / 'experiments/20261002_tuning/verify_candidate.py')
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)


def cfg(t, s=8, b=1, h=1, d=64, bs=16, causal=True, groups=16):
    return dict(B=b, SEQ_LEN=t, H=h, HQ=groups*h, D=d, S=s,
                block_size=bs, is_causal=causal)


def selected(case, config):
    c = case
    if c['D'] != 64 or c['block_size'] != 16 or c['HQ'] != 16*c['H']:
        return 'baseline'
    grid = c['B'] * c['H'] * c['SEQ_LEN']
    s8, s4 = config['s8_config'], config['s4_config']
    if c['S'] == 8 and c['SEQ_LEN'] >= s8['seq_len_min'] and grid <= s8['grid_max']:
        return 'small_s8'
    if (c['S'] == 4 and c['H'] == s4['heads_kv'] and
            c['SEQ_LEN'] >= s4['seq_len_min'] and grid >= s4['grid_min']):
        depth = 4 if grid >= s4['prefetch4_grid_min'] else (2 if grid >= s4['prefetch2_grid_min'] else 1)
        return f's4_pf{depth}'
    return 'baseline'


def adversarial_indices(indices, bs, extreme=False):
    b, length, heads, selected_blocks = indices.shape
    nb = (length + bs - 1) // bs
    patterns = [[-1]*selected_blocks, [nb-1]*selected_blocks, [0]*selected_blocks,
                [nb]*selected_blocks,
                [0 if i % 2 == 0 else nb-1 for i in range(selected_blocks)]]
    if extreme:
        patterns += [[v]*selected_blocks for v in
                     (-2147483648, 2147483647, -268435456, 268435456, -134217728, 134217728)]
        patterns += [[0 if i % 2 else -268435456 for i in range(selected_blocks)]]
    values = torch.tensor(patterns, dtype=torch.int64, device=indices.device)
    return values[torch.arange(length, device=indices.device) % len(patterns)].view(
        1, length, 1, selected_blocks).expand(b, length, heads, selected_blocks)


def guarded_module(path):
    fixture = ROOT / 'experiments/20260928_guard_fix/check_restricted_host.py'
    tree = ast.parse(fixture.read_text())
    cutoff = next(i for i, n in enumerate(tree.body) if isinstance(n, ast.Assign)
        and any(isinstance(t, ast.Name) and t.id == 'small' for t in n.targets))
    env = dict(__file__=str(fixture), __name__='nsa_1005_guard_fixture')
    exec(compile(ast.Module(body=tree.body[:cutoff], type_ignores=[]), str(fixture), 'exec'), env)
    return env['guarded_module'](str(path))


@torch.no_grad()
def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('module')
    parser.add_argument('--assembly', required=True)
    parser.add_argument('--output', required=True)
    parser.add_argument('--resume-from')
    args = parser.parse_args()
    torch.backends.cuda.matmul.allow_tf32 = False
    module_path = Path(args.module).resolve()
    config = json.loads(Path(args.assembly).read_text())
    trial = load_module(str(module_path))
    base = load_module(str(ROOT / 'experiments/20261002_mid_v1/submission.py'))
    s8_probe = load_module(str(ROOT / 'experiments/20261004_goal89/split_s8_w2_fp32_balanced.py'))
    for name in ('native_sparse_attention', 'run_kernel'):
        assert inspect.signature(getattr(base, name)) == inspect.signature(getattr(trial, name))
    output_path = Path(args.output)
    report = dict(status='running', command=sys.argv, boundaries=[], extremes=[],
        fallbacks=[], unsupported=[], unsupported_shapes=[], refresh=[], guarded=[],
        module_sha256=hashlib.sha256(module_path.read_bytes()).hexdigest(),
        harness_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        reference_matmul_tf32=False, official_sandbox=False)
    if args.resume_from:
        previous = json.loads(Path(args.resume_from).read_text())
        assert previous['module_sha256'] == report['module_sha256']
        assert previous['reference_matmul_tf32'] is False
        for key in ('boundaries', 'extremes', 'fallbacks', 'unsupported',
                    'unsupported_shapes', 'refresh', 'guarded'):
            report[key] = previous.get(key, [])
        report['resumed_from'] = dict(path=args.resume_from,
            sha256=hashlib.sha256(Path(args.resume_from).read_bytes()).hexdigest(),
            harness_sha256=previous['harness_sha256'])

    def persist():
        output_path.write_text(json.dumps(report, indent=2) + '\n')

    cases = [cfg(t, causal=t % 2 == 0) for t in (127, 128, 129, 255, 256, 257, 511, 512, 513)]
    cases += [cfg(127, b=2), cfg(128, h=2), cfg(128, h=4, causal=False),
              cfg(129, h=4), cfg(256, b=2), cfg(257, b=2)]
    s4 = config['s4_config']
    thresholds = sorted({s4['grid_min'], s4['prefetch2_grid_min'], s4['prefetch4_grid_min']})
    cases += [cfg(t+d, s=4, causal=d == 0) for t in thresholds for d in (-1, 0, 1)]
    min_seq = s4['seq_len_min']
    min_seq_batch = (s4['grid_min'] + min_seq - 1) // min_seq + 1
    cases += [cfg(min_seq+d, s=4, b=min_seq_batch) for d in (-1, 0, 1)]
    cases += [cfg(255, s=4, b=4), cfg(256, s=4, b=4), cfg(257, s=4, b=4),
              cfg(512, s=4, h=2), cfg(1024, s=4, h=4), cfg(1025, s=4, b=4, causal=False)]
    cases += [cfg(256, s=2), cfg(128, s=16), cfg(129, s=1, d=32),
              cfg(129, d=128, bs=32), cfg(256, groups=8), cfg(256, groups=32)]
    persist()
    for i, c in enumerate(cases):
        if any(r['config'] == c for r in report['boundaries'] + report['unsupported_shapes']):
            continue
        path = selected(c, config)
        if path == 'baseline':
            try:
                expected = helpers.compile_case(base, c)
            except Exception as before:
                error_type, reason = type(before).__name__, str(before).splitlines()[-1]
                try:
                    helpers.compile_case(trial, c)
                except Exception as after:
                    assert type(after).__name__ == error_type
                    assert str(after).splitlines()[-1] == reason
                else:
                    raise AssertionError('Baseline shape failure was not preserved')
                report['unsupported_shapes'].append(dict(config=c,
                    same_baseline_failure=True, error_type=error_type, reason=reason))
                persist()
                print('SAME UNSUPPORTED SHAPE', c, reason, flush=True)
                continue
        error = check_case(trial, c, 5101+i, None,
                           lambda idx, bs=c['block_size']: adversarial_indices(idx, bs))
        kernel = helpers.compile_case(trial, c)
        if path == 'baseline':
            expected = helpers.compile_case(base, c)
            assert get_kernel_source(kernel) == get_kernel_source(expected), (c, 'fallback source')
            assert helpers.flags(kernel) == helpers.flags(expected)
        elif path == 'small_s8':
            expected = helpers.compile_case(s8_probe, c)
            assert get_kernel_source(kernel) == get_kernel_source(expected), (c, 'S8 probe source')
            assert helpers.flags(kernel) == helpers.flags(expected)
        audits = []
        for part in helpers.parts(kernel):
            source = part.get_kernel_source()
            assert not any(marker in source for marker in
                ('memcpy_async', 'cp.async', 'maca_async', 'tma_load', 'mbarrier'))
            assert not any(value for key, value in part.pass_configs.items()
                if 'disable_data_race' in str(key) or 'disable_safe_memory' in str(key))
            size, method, host_hash = helpers.shared_bytes(part)
            audits.append(dict(device_sha256=hashlib.sha256(source.encode()).hexdigest(),
                shared_bytes=size, shared_method=method, host_sha256=host_hash,
                block_barriers=source.count('__syncthreads()'), wave_barriers=source.count('__syncwarp()')))
        if path == 'small_s8':
            assert len(audits) == 2 and audits[-1]['block_barriers'] == 1
            assert audits[-1]['shared_bytes'] >= 8320
        elif path.startswith('s4_'):
            assert len(audits) == 2 and audits[-1]['wave_barriers'] == 1
            assert audits[-1]['block_barriers'] == 0 and audits[-1]['shared_bytes'] == 2048
        report['boundaries'].append(dict(config=c, path=path, max_abs_error=error,
            both_interfaces=True, source_audit=audits))
        persist()
        print('BOUNDARY PASS', path, c, error, flush=True)

    for c in (cfg(256), cfg(s4['grid_min'], s=4),
              cfg(max(s4['grid_min'], s4['prefetch2_grid_min']), s=4, b=2),
              cfg(max(s4['grid_min'], s4['prefetch4_grid_min']), s=4)):
        for knobs in ({'q_preload': False}, {'kv_reuse': False}, {'nmax': False},
                      {'stage_regs': False}, {'kv_split': True}, {'q_frag': False},
                      {'o_stage': True}, {'pair': 2}, {'late_normalize': True},
                      {'online_unroll': 1}, {'num_stages': 2}, {'threads': 128}):
            if any(r['config'] == c and r['knobs'] == knobs
                   for r in report['fallbacks'] + report['unsupported']):
                continue
            try:
                old = helpers.compile_case(base, c, **knobs)
            except Exception as before:
                error_type, reason = type(before).__name__, str(before).splitlines()[-1]
                try:
                    helpers.compile_case(trial, c, **knobs)
                except Exception as after:
                    assert type(after).__name__ == error_type
                    assert str(after).splitlines()[-1] == reason
                else:
                    raise AssertionError('Baseline compilation failure was not preserved')
                report['unsupported'].append(dict(config=c, knobs=knobs,
                    same_baseline_failure=True, error_type=error_type, reason=reason))
            else:
                new = helpers.compile_case(trial, c, **knobs)
                assert get_kernel_source(old) == get_kernel_source(new), (c, knobs)
                assert helpers.flags(old) == helpers.flags(new)
                report['fallbacks'].append(dict(config=c, knobs=knobs, source_and_flags_equal=True))
            persist()

    live_cases = [cfg(129), cfg(257, causal=False), cfg(128, h=2),
                  cfg(s4['grid_min']+1, s=4),
                  cfg(max(s4['grid_min'], s4['prefetch4_grid_min'])+1, s=4, causal=False),
                  cfg(1025, s=4, b=max(4, (s4['grid_min']+1024)//1025))]
    for c in live_cases:
        if any(r['config'] == c for r in report['extremes']):
            continue
        error = check_case(trial, c, 5401, None,
            lambda idx, bs=c['block_size']: adversarial_indices(idx, bs, True))
        report['extremes'].append(dict(config=c, max_abs_error=error, both_interfaces=True))
        persist()
        print('EXTREME PASS', c, error, flush=True)

    runtime = ctypes.CDLL('/opt/maca/lib/libmcruntime.so')
    pointer = ctypes.c_void_p()
    assert runtime.mcStreamCreate(ctypes.byref(pointer)) == 0
    stream = torch.cuda.ExternalStream(pointer.value)
    torch.cuda.graph.default_capture_stream = stream
    for c in live_cases:
        inputs = list(make_inputs(c, seed=5501))
        result = torch.empty_like(inputs[0])
        args_run = (*inputs, result, c['B'], c['SEQ_LEN'], c['H'], c['HQ'], c['D'],
                    c['S'], c['block_size'], c['is_causal'], 0.1)
        factory = trial.native_sparse_attention(c['B'], c['HQ'], c['SEQ_LEN'], c['D'],
            c['is_causal'], scale=0.1, block_size=c['block_size'], groups=c['HQ']//c['H'], selected_blocks=c['S'])
        trial.run_kernel(*args_run)
        stream.wait_stream(torch.cuda.current_stream())
        stream.synchronize()
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph, stream=stream):
            trial.run_kernel(*args_run)
        addresses = [x.data_ptr() for x in inputs]
        for iteration in range(3):
            if any(r['config'] == c and r['iteration'] == iteration for r in report['refresh']):
                continue
            fresh = make_inputs(c, seed=5501+iteration)
            for dest, src in zip(inputs, fresh):
                dest.copy_(src)
            if iteration == 2:
                inputs[3].copy_(adversarial_indices(inputs[3], c['block_size'], True))
            assert addresses == [x.data_ptr() for x in inputs]
            graph.replay()
            torch.cuda.synchronize()
            expected = sparse_reference(*inputs, c['block_size'], c['is_causal'], 0.1)
            error = check_output(result, expected, 'same-address graph replay')
            error = max(error, check_output(factory(*inputs), expected, 'same-address factory'))
            report['refresh'].append(dict(config=c, iteration=iteration, max_abs_error=error,
                both_interfaces=True, graph_replay=True, input_addresses=addresses))
            persist()
        del graph
        print('REFRESH PASS', c, flush=True)

    guarded = guarded_module(module_path)
    for c in live_cases:
        if any(r['config'] == c for r in report['guarded']):
            continue
        error = check_case(guarded, c, 5601, None,
            lambda idx, bs=c['block_size']: adversarial_indices(idx, bs, True))
        report['guarded'].append(dict(config=c, max_abs_error=error, both_interfaces=True))
        persist()
        print('GUARD PASS', c, error, flush=True)
    report['status'] = 'PASS'
    persist()
    print('PASS', {k: len(report[k]) for k in
                   ('boundaries', 'extremes', 'fallbacks', 'unsupported',
                    'unsupported_shapes', 'refresh', 'guarded')}, flush=True)


if __name__ == '__main__':
    main()
