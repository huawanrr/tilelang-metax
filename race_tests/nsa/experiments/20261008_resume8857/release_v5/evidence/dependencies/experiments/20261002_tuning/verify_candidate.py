"""Verify new dispatch boundaries, live inputs, packed values and host guards."""
import argparse
import ast
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

spec = importlib.util.spec_from_file_location('nsa_release_helpers',
    ROOT / 'experiments/20261001_tuning/verify_release.py')
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)
parts, flags = helpers.parts, helpers.flags
compile_case, edge_indices = helpers.compile_case, helpers.edge_indices


def shared_bytes(kernel):
    source, host = kernel.get_kernel_source(), kernel.get_host_source()
    declaration = re.search(r'extern "C" __global__ void \w+\(([^()]*)\);', source)
    assert declaration, 'Missing device signature for launch-argument audit'
    count = len(declaration[1].split(',')) if declaration[1].strip() else 0
    calls = list(re.finditer(r'TVMFFIFunctionCall\(kernel_kernel_packed, \(TVMFFIAny\*\) stack_ffi_any, (\d+),', host))
    assert len(calls) == 1, len(calls)
    call = calls[0]
    # FFI only passes the dimensions declared by this kernel. In particular,
    # packed attention has two grid dimensions; the packers have three.
    ir = kernel.prim_func.script()
    dimensions = re.findall(r'T\.launch_thread\("((?:blockIdx|threadIdx)\.[xyz])", (\d+)\)', ir)
    assert len(dimensions) == ir.count('T.launch_thread(')
    assert len({tag for tag, _ in dimensions}) == len(dimensions) > 0
    dynamic = 'extern __shared__' in source
    assert dynamic == ('__shared__' in source), 'Unexpected static shared declaration'
    assert int(call[1]) == count + len(dimensions) + int(dynamic), (count, dimensions, call[1])
    for slot, (tag, extent) in enumerate(dimensions, count):
        pattern = (rf'\(\(\(TVMFFIAny\*\)stack_ffi_any\)\[{slot}\]\.v_int64\) '
                   r'= \(\(int64_t\)(\d+)\);')
        values = re.findall(pattern, host[:call.start()])
        assert values and values[-1] == extent, (slot, tag, extent, values)
    evidence = f'FFI dimensions verified against PrimFunc: {dimensions}'
    if not dynamic:
        return 0, evidence + '; no shared argument', hashlib.sha256(host.encode()).hexdigest()
    size, method, host_hash = helpers.shared_bytes(kernel)
    return size, evidence + '; ' + method, host_hash


def cfg(t, d=64, bs=16, b=1, h=1, causal=True, s=1):
    return dict(B=b, SEQ_LEN=t, H=h, HQ=16 * h, D=d, S=s,
                block_size=bs, is_causal=causal)


def selected_path(case, config):
    b, t, h, d, s, bs = (case[k] for k in ('B', 'SEQ_LEN', 'H', 'D', 'S', 'block_size'))
    grid = b * t * h
    if s == 1 and d == 128 and bs == 32 and grid >= 1024:
        return ('packed_direct' if h == 1 and t >= config['packed_direct_min_seq']
                and grid < config['packed_direct_max_grid'] else 'packed_shared')
    if s == 2 and d == 64 and bs == 16 and t >= 64 and grid >= config['short_wave_min_grid']:
        return 'short_qo' if grid >= config['short_qo_min_grid'] else 'short_wave'
    if (s == 8 and d == 64 and bs == 16 and config['s8_output_min_grid'] is not None
            and grid >= config['s8_output_min_grid']):
        return 's8'
    return 'base'


def extreme_indices(indices, bs):
    b, n, h, s = indices.shape
    nb = (n + bs - 1) // bs
    patterns = [[-2147483648] * s, [2147483647] * s, [0] * s,
                [nb - 1] * s, [nb] * s,
                [0 if i % 2 == 0 else -2147483648 for i in range(s)]]
    values = torch.tensor(patterns, dtype=torch.int64, device=indices.device)
    return values[torch.arange(n, device=indices.device) % len(patterns)].view(1, n, 1, s).expand(b, n, h, s)


@torch.no_grad()
def main():
    torch.backends.cuda.matmul.allow_tf32 = False
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', required=True)
    parser.add_argument('--output', required=True)
    args = parser.parse_args()
    directory = Path(args.directory)
    assembly = json.loads((directory / 'assembly.json').read_text())
    config = assembly['config']
    dev_path, sub_path = directory / 'nsa.py', directory / 'submission.py'
    dev, trial = load_module(str(dev_path)), load_module(str(sub_path))
    base = load_module(str(ROOT / 'experiments/20261001_final/submission.py'))
    probes = {'base': base}
    for name in ('packed_direct', 'packed_shared', 'short_wave', 'short_qo'):
        probes[name] = load_module(str(ROOT / config[name + '_probe']))
    if config['s8_output_min_grid'] is not None:
        probes['s8'] = load_module(str(ROOT / config['s8_probe']))
    for name in ('run_kernel', 'native_sparse_attention'):
        assert inspect.signature(getattr(trial, name)) == inspect.signature(getattr(base, name)), name
    report = dict(command=sys.argv, status='running', boundaries=[], extremes=[], sources=[],
                  fallbacks=[], refresh=[], packing=[], guarded=[], official_sandbox=False,
                  reference_matmul_tf32=False,
                  source_sha256={str(p): hashlib.sha256(p.read_bytes()).hexdigest() for p in (dev_path, sub_path)})
    output = Path(args.output)

    def persist():
        output.write_text(json.dumps(report, indent=2) + '\n')

    persist()
    cases = []
    for threshold in (1024, config['packed_direct_max_grid']):
        cases.extend(cfg(threshold + delta, 128, 32, causal=delta != 0) for delta in (-1, 0, 1))
    cases += [cfg(63, 128, 32, b=17, causal=False), cfg(64, 128, 32, b=16),
              cfg(65, 128, 32, b=16, causal=False), cfg(512, 128, 32, b=2),
              cfg(512, 128, 32, h=2), cfg(513, 128, 32, b=2, h=2, causal=False),
              cfg(37, 128, 32, b=28, causal=False)]
    for threshold in sorted({config['short_wave_min_grid'], config['short_qo_min_grid']}):
        cases.extend(cfg(threshold + delta, s=2, causal=delta != 0) for delta in (-1, 0, 1))
    cases += [cfg(63, s=2, b=64), cfg(65, s=2, b=64, causal=False),
              cfg(513, s=2, b=4, h=2, causal=False), cfg(129, s=4), cfg(1025, d=32),
              cfg(3072), cfg(2048, 128), cfg(513, bs=32, causal=False)]
    if config['s8_output_min_grid'] is not None:
        for threshold in sorted({config['s8_output_min_grid'], 8192}):
            cases.extend(cfg(threshold + delta, s=8, causal=delta != 0) for delta in (-1, 0, 1))
        cases += [cfg(513, s=8, b=4, h=2, causal=False)]
    for i, case in enumerate(cases):
        path = selected_path(case, config)
        error = check_case(trial, case, 2001 + i, None,
            lambda idx, bs=case['block_size']: edge_indices(idx, bs))
        kernels = [compile_case(module, case) for module in (trial, dev, probes[path])]
        sources = [get_kernel_source(kernel) for kernel in kernels]
        assert sources[0] == sources[1] == sources[2], (path, case)
        assert flags(kernels[0]) == flags(kernels[1]) == flags(kernels[2]), (path, case)
        kernel_parts = parts(kernels[0])
        audits = []
        for part in kernel_parts:
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
        if path.startswith('packed_'):
            assert len(audits) == 2
            assert audits[-1]['wave_barriers'] == 3 and audits[-1]['block_barriers'] == 0
            assert audits[-1]['shared_bytes'] == 4096
            expected_threads = 128 if path == 'packed_direct' else 256
            assert audits[0]['launch_bounds'] == [str(expected_threads)]
            assert audits[0]['shared_bytes'] == (0 if path == 'packed_direct' else 8192)
            assert audits[0]['block_barriers'] == (0 if path == 'packed_direct' else 1)
            assert audits[0]['wave_barriers'] == 0
        elif path in ('short_wave', 'short_qo'):
            assert len(audits) == 1
            assert audits[0]['wave_barriers'] == (7 if path == 'short_qo' else 3)
            assert audits[0]['block_barriers'] == 0 and audits[0]['shared_bytes'] == 4096
        elif path == 's8':
            assert len(audits) == 2
            assert audits[-1]['wave_barriers'] == 1 and audits[-1]['block_barriers'] == 0
            assert audits[-1]['shared_bytes'] == 2048
        output.with_name(f'boundary_{i:02d}.cpp').write_text(sources[0])
        report['boundaries'].append(dict(config=case, path=path, max_abs_error=error, both_interfaces=True))
        report['sources'].append(dict(config=case, path=path, parts=audits,
                                      compile_flags=flags(kernels[0]), probe_source_and_flags_equal=True))
        persist()
        print('BOUNDARY PASS', path, case, error, flush=True)

    fallback_cases = [cfg(4096, 128, 32), cfg(4096, s=2), cfg(4096, s=8)]
    for case in fallback_cases:
        knobs_list = [{'q_preload': False}, {'kv_reuse': False}, {'nmax': False},
                      {'stage_regs': False}, {'kv_split': True},
                      {'q_frag': case['block_size'] != 32 if case['S'] == 1 else False}]
        if case['S'] > 1:
            knobs_list += [{'o_stage': True}, {'pair': 2}, {'late_normalize': True},
                           {'online_unroll': 1}, {'num_stages': 2}]
        for knobs in knobs_list:
            old, new = compile_case(base, case, **knobs), compile_case(trial, case, **knobs)
            assert get_kernel_source(old) == get_kernel_source(new), (case, knobs)
            assert flags(old) == flags(new), (case, knobs)
            report['fallbacks'].append(dict(config=case, knobs=knobs, source_and_flags_equal=True))
            persist()
    extreme_cases = [cfg(1025, 128, 32), cfg(513, 128, 32, b=2, h=2),
                     cfg(max(config['short_wave_min_grid'], config['short_qo_min_grid']) + 1, s=2)]
    for case in extreme_cases:
        path = selected_path(case, config)
        assert path.startswith('packed') or path == 'short_qo'
        error = check_case(trial, case, 2251, None,
                           lambda idx, bs=case['block_size']: extreme_indices(idx, bs))
        report['extremes'].append(dict(config=case, max_abs_error=error, both_interfaces=True))
        persist()
        print('EXTREME PASS', case, error, flush=True)

    live_cases = [cfg(1025, 128, 32, causal=False), cfg(513, 128, 32, b=2, h=2),
                  cfg(513, s=2, b=4, h=2, causal=False)]
    if config['s8_output_min_grid'] is not None:
        live_cases += [cfg(513, s=8, b=4, h=2, causal=False), cfg(1025, s=8, b=4, h=2)]
    for case in live_cases:
        q, k, v, indices = make_inputs(case, seed=2301)
        indices = edge_indices(indices, case['block_size']).contiguous()
        factory = trial.native_sparse_attention(case['B'], case['HQ'], case['SEQ_LEN'],
            case['D'], case['is_causal'], scale=0.07, block_size=case['block_size'],
            groups=16, selected_blocks=case['S'])
        out = torch.empty_like(q)
        for iteration in range(3):
            if iteration:
                nq, nk, nv, _ = make_inputs(case, seed=2301 + iteration)
                q.copy_(nq)
                k.copy_(nk)
                v.copy_(nv)
                indices.copy_(indices.roll(1, dims=1))
            expected = sparse_reference(q, k, v, indices, case['block_size'], case['is_causal'], 0.07)
            out.fill_(float('nan'))
            trial.run_kernel(q, k, v, indices, out, case['B'], case['SEQ_LEN'], case['H'],
                             case['HQ'], case['D'], case['S'], case['block_size'], case['is_causal'], 0.07)
            error = max(check_output(out, expected, 'live run_kernel'),
                        check_output(factory(q, k, v, indices), expected, 'live factory'))
            report['refresh'].append(dict(config=case, iteration=iteration, max_abs_error=error,
                                          same_addresses=True, both_interfaces=True))
            persist()
        print('REFRESH PASS', case, flush=True)

    for pack_name in ('native_sparse_attention_pack_kv_bs32_direct', 'native_sparse_attention_pack_kv_bs32_shared'):
        for case in (cfg(37, 128, 32, b=2, h=2), cfg(1025, 128, 32)):
            _, k, v, _ = make_inputs(case, seed=2401)
            b, n, h, d, bs = (case[x] for x in ('B', 'SEQ_LEN', 'H', 'D', 'block_size'))
            nb = (n + bs - 1) // bs
            pk = torch.full((b, nb, h, d // 32, bs // 16, 64, 8), float('nan'), dtype=k.dtype, device=k.device)
            pv = torch.full((b, nb, h, bs // 16, d // 32, 64, 8), float('nan'), dtype=v.dtype, device=v.device)
            getattr(trial, pack_name)(b, n, h, d, bs)(k, v, pk, pv)
            rows = torch.arange(bs, device=k.device).view(-1, 1)
            cols = torch.arange(d, device=k.device).view(1, -1)
            for batch in range(b):
                for head in range(h):
                    for block in range(nb):
                        ek = torch.zeros((bs, d), dtype=k.dtype, device=k.device)
                        ev = torch.zeros_like(ek)
                        count = min(bs, n - block * bs)
                        ek[:count].copy_(k[batch, block * bs:block * bs + count, head])
                        ev[:count].copy_(v[batch, block * bs:block * bs + count, head])
                        ak = pk[batch, block, head, cols // 32, rows // 16,
                                cols % 32 // 8 * 16 + rows % 16, cols % 8]
                        av = pv[batch, block, head, rows // 16, cols // 32,
                                rows % 16 // 4 * 16 + cols % 16, cols % 32 // 16 * 4 + rows % 4]
                        torch.testing.assert_close(ak, ek, rtol=0, atol=0)
                        torch.testing.assert_close(av, ev, rtol=0, atol=0)
            report['packing'].append(dict(builder=pack_name, config=case, exact=True,
                                           padding_zero=True, overwrites_nan=True))
            persist()
            print('PACKING PASS', pack_name, case, flush=True)

    guard_path = ROOT / 'experiments/20260928_guard_fix/check_restricted_host.py'
    tree = ast.parse(guard_path.read_text())
    cutoff = next(i for i, n in enumerate(tree.body) if isinstance(n, ast.Assign)
                  and any(isinstance(t, ast.Name) and t.id == 'small' for t in n.targets))
    env = dict(__file__=str(guard_path), __name__='nsa_1002_guard_fixture')
    exec(compile(ast.Module(body=tree.body[:cutoff], type_ignores=[]), str(guard_path), 'exec'), env)
    guarded = env['guarded_module'](str(sub_path))
    for case in live_cases + [cfg(129, d=32), cfg(129, s=4)]:
        error = check_case(guarded, case, 2501, None,
                           lambda idx, bs=case['block_size']: edge_indices(idx, bs))
        report['guarded'].append(dict(config=case, max_abs_error=error, both_interfaces=True))
        persist()
        print('GUARDED PASS', case, error, flush=True)
    report['status'] = 'PASS'
    persist()
    print('PASS', {k: len(report[k]) for k in
          ('boundaries', 'extremes', 'sources', 'fallbacks', 'refresh', 'packing', 'guarded')}, flush=True)


if __name__ == '__main__':
    main()
