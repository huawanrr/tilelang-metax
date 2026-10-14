"""Release checks for the 930 dispatch, synchronization, and live inputs."""
import argparse
import ast
import hashlib
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


def cfg(t, d=64, bs=16, s=1, b=1, h=1, causal=True):
    return dict(B=b, SEQ_LEN=t, H=h, HQ=16 * h, D=d, S=s,
                block_size=bs, is_causal=causal)


def edge_indices(indices, bs):
    b, length, h, selected = indices.shape
    last = (length - 1) // bs
    mixed = [last, 0, last + 1, -3, 0, last, 1, 0]
    patterns = [[-1] * selected, (mixed * ((selected + 7) // 8))[:selected],
                [0] * selected, [last + 1] * selected, [last] * selected]
    patterns = torch.tensor(patterns, device=indices.device, dtype=torch.int64)
    return patterns[torch.arange(length, device=indices.device) % len(patterns)].view(
        1, length, 1, selected).expand(b, length, h, selected)


def compiled_kernel(module, case, **knobs):
    return module._get_kernel(
        case['B'], case['SEQ_LEN'], case['H'], case['HQ'], case['D'], case['S'],
        case['block_size'], case['is_causal'], None, **knobs)


def device_source(module, case, **knobs):
    return get_kernel_source(compiled_kernel(module, case, **knobs))


def boundary_cases():
    # Expected paths are recorded explicitly, independently of _get_kernel.
    rows = []
    def add(case, path):
        rows.append((case, path))
    for i, (t, path) in enumerate([
        (191, 'wave'), (192, 'wave'), (193, 'base'),
        (511, 'base'), (512, 'wave'), (513, 'wave'),
        (1023, 'wave'), (1024, 'shuffle'), (1025, 'shuffle'),
        (4095, 'shuffle'), (4096, 'shuffle'), (4097, 'base'),
    ]):
        add(cfg(t, d=32, causal=bool(i % 2)), path)
    for i, (t, path) in enumerate([
        (255, 'linear'), (256, 'linear'), (257, 'qreuse'),
        (1536, 'qreuse'), (1537, 'qreuse'), (1792, 'qreuse'),
        (2047, 'qreuse'), (2048, 'qreuse'), (2049, 'base'),
        (2559, 'base'), (2560, 'base'), (2561, 'qparallel'),
        (4095, 'qparallel'), (4096, 'qparallel'), (4097, 'base'),
    ]):
        add(cfg(t, causal=bool(i % 2)), path)
    for bs in (32, 64):
        for t, path in [(2047, 'linear'), (2048, 'linear'), (2049, 'base')]:
            add(cfg(t, bs=bs, causal=bs == 32), path)
    for i, (t, path) in enumerate([
        (127, 'vec16'), (128, 'vec16'), (129, 'linear'),
        (2047, 'linear'), (2048, 'linear'), (2049, 'base'),
    ]):
        add(cfg(t, d=128, causal=bool(i % 2)), path)
    for i, (t, path) in enumerate([
        (127, 'base'), (128, 'pvblock'), (129, 'pvblock'),
        (2047, 'pvblock'), (2048, 'pvwave'), (2049, 'pvwave'),
    ]):
        add(cfg(t, d=128, bs=32, causal=bool(i % 2)), path)
    for t, path in [(63, 'base'), (64, 'join'), (65, 'join'), (8193, 'join')]:
        add(cfg(t, s=2, causal=bool(t % 2)), path)
    for t, path in [(127, 'base'), (128, 'join'), (129, 'join'),
                    (383, 'join'), (384, 'join'), (385, 'base')]:
        add(cfg(t, s=4, causal=bool(t % 2)), path)
    rows += [
        (cfg(257, b=2, h=2, causal=False), 'qreuse'),
        (cfg(769, b=4), 'qparallel'),
        (cfg(65, d=128, bs=32, h=2, causal=False), 'pvblock'),
        (cfg(65, s=2, b=2, h=2), 'join'),
        (cfg(128, s=4, h=2, causal=False), 'join'),
        (cfg(128, s=4, b=3), 'join'),
        (cfg(96, s=4, b=4), 'base'),
        (cfg(129, s=4, b=3, causal=False), 'base'),
        (cfg(37, s=16, b=2, h=2, causal=False), 'base'),
    ]
    return rows


def probe_source(probes, name, case):
    if name == 'base':
        return device_source(probes['base'], case)
    grid = case['B'] * case['H'] * case['SEQ_LEN']
    common = dict(batch=case['B'], heads=case['HQ'], seq_len=case['SEQ_LEN'],
        dim=case['D'], is_causal=case['is_causal'], block_size=case['block_size'],
        groups=16, scale_log2=case['D'] ** -0.5 * 1.44269504, threads=64,
        late_normalize=False, lane_reduce=True, kv_split=False, direct_k=False)
    if name in ('wave', 'linear', 'vec16'):
        common['direct_k'] = case['block_size'] == 16 and (
            (case['D'] == 32 and grid <= 512) or
            (case['D'] == 64 and grid <= 256) or
            (case['D'] == 128 and grid <= 128))
    if name == 'join':
        common['selected_blocks'] = case['S']
    functions = dict(
        wave=('single', 'native_sparse_attention_single_block_emitter_wave'),
        linear=('single', 'native_sparse_attention_single_linear_v_wave'),
        vec16=('single', 'native_sparse_attention_single_vec16_wave'),
        shuffle=('single', 'native_sparse_attention_d32_shuffle_wave'),
        qparallel=('single', 'native_sparse_attention_mid_shared_q_wave'),
        qreuse=('reuse', 'native_sparse_attention_shared_q_reuse'),
        join=('pair', 'native_sparse_attention_short_list'),
        pvblock=('pvblock', 'native_sparse_attention_wave_pv'),
        pvwave=('pvwave', 'native_sparse_attention_wave_pv'),
    )
    mod, func = functions[name]
    return get_kernel_source(getattr(probes[mod], func)(**common))


def audit_source(source, path, case):
    forbidden = ('memcpy_async', 'cp.async', 'maca_async', 'tma_load', 'mbarrier')
    assert not any(token in source for token in forbidden)
    warp = source.count('__syncwarp(')
    block = source.count('__syncthreads(')
    if path not in ('base', 'join'):
        assert '__launch_bounds__(64,' in source
        grid = case['B'] * case['H'] * case['SEQ_LEN']
        direct = case['block_size'] == 16 and (
            (case['D'] == 32 and grid <= 512) or
            (case['D'] == 64 and grid <= 256) or
            (case['D'] == 128 and grid <= 128))
        expected = 5 if path == 'qreuse' else (
            1 if path in ('shuffle', 'vec16') or direct else 3)
        if path == 'pvblock':
            assert (warp, block) == (0, 3), (path, warp, block)
        else:
            assert (warp, block) == (expected, 0), (path, warp, block)
        if path == 'qreuse':
            # Every Q/K/V access uses the same allocation base, without a
            # second shared-memory offset. The layout proof bounds it to 2 KiB.
            assert 'buf_dyn_shmem + ' not in source
            assert re.search(r'\(\(half_t\*\)buf_dyn_shmem\).*Q_stage', source)
            assert re.search(r'\(\(half_t\*\)buf_dyn_shmem\).*K_reg', source)
            assert re.search(r'\(\(half_t\*\)buf_dyn_shmem\).*V_reg', source)
    return dict(wave_barriers=warp, block_barriers=block,
                sha256=hashlib.sha256(source.encode()).hexdigest())


@torch.no_grad()
def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dev', default=str(HERE / 'nsa.py'))
    parser.add_argument('--submission', default=str(HERE / 'submission.py'))
    parser.add_argument('--output', default=str(HERE / 'release_checks.json'))
    args = parser.parse_args()
    dev, trial = load_module(args.dev), load_module(args.submission)
    probe_paths = dict(base='experiments/20260929_candidate/submission.py',
        single='experiments/20260930_tuning/single_wave.py',
        reuse='experiments/20260930_tuning/shared_q_reuse_wave.py',
        pair='experiments/20260930_tuning/pair_linear_early.py',
        pvblock='experiments/20260930_tuning/pv32_block_sync.py',
        pvwave='experiments/20260930_tuning/pv32_wave_sync.py')
    probes = {name: load_module(str(ROOT / path)) for name, path in probe_paths.items()}
    report = dict(command=sys.argv, boundaries=[], sources=[], explicit_fallbacks=[],
                  refresh=[], guarded=[], official_sandbox=False,
                  source_sha256={p: hashlib.sha256(Path(p).read_bytes()).hexdigest()
                                 for p in (args.dev, args.submission)})
    def persist():
        Path(args.output).write_text(json.dumps(report, indent=2) + '\n')
    for i, (case, name) in enumerate(boundary_cases()):
        error = check_case(trial, case, 930 + i, None,
                           lambda indices, bs=case['block_size']: edge_indices(indices, bs))
        sources = [device_source(trial, case), device_source(dev, case),
                   probe_source(probes, name, case)]
        assert sources[0] == sources[1] == sources[2], (name, case)
        audit = audit_source(sources[0], name, case)
        if name in ('qreuse', 'qparallel'):
            host = compiled_kernel(trial, case).get_host_source()
            sizes = [int(x) for x in re.findall(r'MaxDynamicSharedMemorySize,\s*(\d+)', host)]
            expected_bytes = 2048 if name == 'qreuse' else 4096
            assert sizes == [expected_bytes], (name, sizes)
            audit['shared_bytes'] = sizes[0]
        (HERE / f'release_boundary_{i:02d}.cpp').write_text(sources[0])
        report['boundaries'].append(dict(config=case, path=name, max_abs_error=error,
                                         both_interfaces=True))
        report['sources'].append(dict(config=case, path=name, **audit))
        print('BOUNDARY PASS', name, case, error, flush=True)
        persist()
    for case in (cfg(1024), cfg(2048), cfg(3072)):
        for knobs in ({'q_preload': False}, {'q_frag': True}, {'nmax': False},
                      {'kv_reuse': False}, {'stage_regs': False}, {'kv_split': True}):
            source = device_source(trial, case, **knobs)
            assert source == device_source(probes['base'], case, **knobs), (case, knobs)
            report['explicit_fallbacks'].append(dict(config=case, knobs=knobs, source_equal=True))
            persist()
    live_cases = [cfg(1025, d=32, h=2, causal=False), cfg(1537), cfg(3073),
                  cfg(129, d=128, bs=32, causal=False), cfg(1025, d=128, bs=32, b=4),
                  cfg(65, s=2, b=2, h=2, causal=False), cfg(129, s=4),
                  cfg(1025, s=8, b=4, h=2, causal=False)]
    for case in live_cases:
        q, k, v, indices = make_inputs(case, seed=1030)
        indices = edge_indices(indices, case['block_size']).contiguous()
        factory = trial.native_sparse_attention(case['B'], case['HQ'], case['SEQ_LEN'],
            case['D'], case['is_causal'], scale=None, block_size=case['block_size'],
            groups=16, selected_blocks=case['S'])
        output = torch.empty_like(q)
        for iteration in range(3):
            if iteration:
                nq, nk, nv, _ = make_inputs(case, seed=1030 + iteration)
                q.copy_(nq)
                k.copy_(nk)
                v.copy_(nv)
                indices.copy_(indices.roll(1, dims=1))
            expected = sparse_reference(q, k, v, indices, case['block_size'], case['is_causal'], None)
            output.fill_(float('nan'))
            trial.run_kernel(q, k, v, indices, output, case['B'], case['SEQ_LEN'], case['H'],
                             case['HQ'], case['D'], case['S'], case['block_size'], case['is_causal'], None)
            error = max(check_output(output, expected, 'refresh run_kernel'),
                        check_output(factory(q, k, v, indices), expected, 'refresh factory'))
            report['refresh'].append(dict(config=case, iteration=iteration, max_abs_error=error))
            print('REFRESH PASS', case, iteration, error, flush=True)
            persist()
    guard_path = ROOT / 'experiments/20260928_guard_fix/check_restricted_host.py'
    tree = ast.parse(guard_path.read_text())
    cutoff = next(i for i, node in enumerate(tree.body) if isinstance(node, ast.Assign)
                  and any(isinstance(t, ast.Name) and t.id == 'small' for t in node.targets))
    env = dict(__file__=str(guard_path), __name__='nsa_930_guard_fixture')
    exec(compile(ast.Module(body=tree.body[:cutoff], type_ignores=[]), str(guard_path), 'exec'), env)
    guarded = env['guarded_module'](args.submission)
    for case in live_cases + [cfg(128, d=128), cfg(1024, bs=64)]:
        error = check_case(guarded, case, 1130, None,
                           lambda indices, bs=case['block_size']: edge_indices(indices, bs))
        report['guarded'].append(dict(config=case, max_abs_error=error, both_interfaces=True))
        print('GUARDED PASS', case, error, flush=True)
        persist()
    report['status'] = 'PASS'
    persist()
    print('PASS', {key: len(report[key]) for key in
          ('boundaries', 'sources', 'explicit_fallbacks', 'refresh', 'guarded')}, flush=True)


if __name__ == '__main__':
    main()
