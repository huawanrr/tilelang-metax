"""Check dispatch boundaries, generated code, live inputs and host write guards."""
import argparse
import ast
import hashlib
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


def cfg(t, d=64, bs=16, b=1, h=1, causal=True, s=1):
    return dict(B=b, SEQ_LEN=t, H=h, HQ=16 * h, D=d, S=s,
                block_size=bs, is_causal=causal)


def edge_indices(indices, bs):
    b, length, h, selected = indices.shape
    last = (length - 1) // bs
    patterns = [[-1] * selected, [last] * selected, [0] * selected,
                [last + 1] * selected, [-3] * selected]
    patterns = torch.tensor(patterns, device=indices.device, dtype=torch.int64)
    return patterns[torch.arange(length, device=indices.device) % len(patterns)].view(
        1, length, 1, selected).expand(b, length, h, selected)


def compile_case(module, case, **knobs):
    return module._get_kernel(case['B'], case['SEQ_LEN'], case['H'], case['HQ'],
        case['D'], case['S'], case['block_size'], case['is_causal'], None, **knobs)


def parts(kernel):
    if inspect.isfunction(kernel):
        captured = inspect.getclosurevars(kernel).nonlocals
        if 'pack' in captured and 'attention' in captured:
            return [captured['pack'], captured['attention']]
    return [kernel]


def flags(kernel):
    return [list(part.compile_flags or []) for part in parts(kernel)]


def shared_bytes(kernel):
    source = kernel.get_host_source()
    sizes = [int(x) for x in re.findall(r'MaxDynamicSharedMemorySize,\s*(\d+)', source)]
    if sizes:
        assert len(sizes) == 1, sizes
        return sizes[0], 'launch attribute', hashlib.sha256(source.encode()).hexdigest()
    # TVM FFI passes the dynamic shared size as its final launch argument.
    # runtime/thread_storage_scope.h enforces the dynamic-memory tag last.
    calls = list(re.finditer(
        r'TVMFFIFunctionCall\(kernel_kernel_packed, \(TVMFFIAny\*\) stack_ffi_any, (\d+),', source))
    assert len(calls) == 1, (type(kernel.adapter).__name__, len(calls))
    call = calls[0]
    slot = int(call[1]) - 1
    assert slot >= 8
    pattern = (rf'\(\(\(TVMFFIAny\*\)stack_ffi_any\)\[{slot}\]\.v_int64\) '
               r'= \(\(int64_t\)(\d+)\);')
    values = re.findall(pattern, source[:call.start()])
    assert values, (slot, type(kernel.adapter).__name__)
    return int(values[-1]), f'TVM FFI launch argument {slot}', hashlib.sha256(source.encode()).hexdigest()


@torch.no_grad()
def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--dev', required=True)
    p.add_argument('--submission', required=True)
    p.add_argument('--d64-min', type=int, default=2304)
    p.add_argument('--d128-min', type=int, default=1280)
    p.add_argument('--bs32-min', type=int, default=1024)
    p.add_argument('--bs32-ilp', action='store_true')
    p.add_argument('--packed-bs32-min', type=int)
    p.add_argument('--output', required=True)
    a = p.parse_args()
    dev, trial = load_module(a.dev), load_module(a.submission)
    base = load_module(str(ROOT / 'experiments/20260930_candidate/submission.py'))
    probes = {name: load_module(str(ROOT / 'experiments/20260930_next' / path))
              for name, path in {'wide': 'qo_q8s8_o8_pv128.py', 'wide4': 'qo_q4s8_o8_pv128.py',
                  'narrow': 'qo_q4s8_o8_pv64.py', 'ilp': 'qo_compiler_ilp.py'}.items()}
    probes['base'] = base
    probes['packed'] = load_module(str(ROOT / 'experiments/20260930_next/packed_qo_pv128.py'))
    cases = []
    for d, bs, threshold in ((64, 16, a.d64_min), (128, 16, a.d128_min),
                              (128, 32, a.bs32_min)):
        cases.extend(cfg(threshold + delta, d, bs, causal=delta != 0) for delta in (-1, 0, 1))
    cases.extend(cfg(t, 128, 32, causal=t % 2 == 0) for t in (2047, 2048, 2049))
    cases += [cfg(641, b=2, h=2, causal=False), cfg(641, 128, b=2, causal=False),
              cfg(257, 128, 32, b=2, h=2, causal=False),
              cfg(513, 128, 32, b=2, h=2, causal=False),
              cfg(37, b=64, causal=False), cfg(37, 128, b=36, causal=False),
              cfg(37, 128, 32, b=28, causal=False),
              cfg(37, 128, 32, b=56, causal=False),
              cfg(128, 128, b=8), cfg(1025, d=32),
              cfg(1025, bs=64, causal=False), cfg(129, s=2, h=2),
              cfg(129, s=4), cfg(513, s=8, b=2, h=2, causal=False)]
    report = dict(command=sys.argv, boundaries=[], sources=[], fallbacks=[], refresh=[], packing=[],
                  guarded=[], official_sandbox=False,
                  sha256={name: hashlib.sha256(Path(name).read_bytes()).hexdigest()
                          for name in (a.dev, a.submission)})
    output = Path(a.output)
    def persist():
        output.write_text(json.dumps(report, indent=2) + '\n')
    for i, case in enumerate(cases):
        grid = case['B'] * case['H'] * case['SEQ_LEN']
        d, bs = case['D'], case['block_size']
        path = 'base'
        if case['S'] == 1:
            if (a.packed_bs32_min is not None and d == 128 and bs == 32
                    and grid >= a.packed_bs32_min):
                path = 'packed'
            elif ((d == 64 and bs == 16 and grid >= a.d64_min)
                    or (d == 128 and bs == 16 and grid >= a.d128_min)):
                path = 'wide'
            elif d == 128 and bs == 32 and grid >= a.bs32_min:
                path = ('narrow' if grid < 2048 else 'wide4' if case['H'] > 1
                        else 'ilp' if a.bs32_ilp else 'wide')
        error = check_case(trial, case, 1001 + i, None,
            lambda indices, bs=bs: edge_indices(indices, bs))
        kernels = [compile_case(module, case) for module in (trial, dev, probes[path])]
        sources = [get_kernel_source(kernel) for kernel in kernels]
        assert sources[0] == sources[1] == sources[2], (path, case)
        assert flags(kernels[0]) == flags(kernels[1]) == flags(kernels[2]), (path, case)
        source = sources[0]
        assert not any(token in source for token in ('memcpy_async', 'cp.async', 'maca_async', 'tma_load', 'mbarrier'))
        audit = dict(path=path, config=case, compile_flags=flags(kernels[0]),
                     sha256=hashlib.sha256(source.encode()).hexdigest())
        if path != 'base':
            expected_barriers = 3 if path == 'packed' else 7
            assert source.count('__syncwarp(') == expected_barriers, (path, case)
            assert source.count('__syncthreads(') == 0
            assert '__launch_bounds__(64,' in source
            assert 'buf_dyn_shmem + ' not in source
            fragments = ('q_stage', 'output_reg') if path == 'packed' else ('Q_stage', 'K_reg', 'V_reg', 'O_reg')
            for fragment in fragments:
                assert re.search(r'\(\(half_t\*\)buf_dyn_shmem\).*' + fragment, source), fragment
            compiled_parts = parts(kernels[0])
            attention = compiled_parts[-1]
            shared, shared_evidence, host_sha = shared_bytes(attention)
            assert shared == (16 if path == 'packed' else max(16, bs)) * d * 2, (path, case, shared)
            for part in compiled_parts:
                assert not any(value for key, value in part.pass_configs.items()
                               if 'disable_data_race' in key or 'disable_safe_memory' in key)
            if path == 'packed':
                assert len(compiled_parts) == 2
                assert '__launch_bounds__(128,' in source
                assert re.findall(r'AllReduce<tl::SumOp, (\d+), (\d+), 0>', source) == [('64', '16')]
            audit.update(wave_barriers=expected_barriers, block_barriers=0,
                         shared_bytes=shared, shared_evidence=shared_evidence,
                         host_source_sha256=host_sha, launches=len(compiled_parts))
        output.with_name(f'boundary_{i:02d}.cpp').write_text(source)
        report['boundaries'].append(dict(config=case, path=path, max_abs_error=error, both_interfaces=True))
        report['sources'].append(audit)
        print('BOUNDARY PASS', path, case, error, flush=True)
        persist()
    for case in (cfg(3072), cfg(2048, 128), cfg(4096, 128, 32)):
        for knobs in ({'q_preload': False}, {'kv_reuse': False}, {'nmax': False},
                      {'stage_regs': False}, {'kv_split': True},
                      {'q_frag': case['block_size'] != 32}):
            original, current = compile_case(base, case, **knobs), compile_case(trial, case, **knobs)
            assert get_kernel_source(original) == get_kernel_source(current), (case, knobs)
            assert flags(original) == flags(current), (case, knobs)
            report['fallbacks'].append(dict(config=case, knobs=knobs, source_and_flags_equal=True))
            persist()
    live_cases = [cfg(641, b=2, h=2, causal=False), cfg(641, 128, b=2),
                  cfg(257, 128, 32, b=2, h=2, causal=False),
                  cfg(513, 128, 32, b=2, h=2)]
    for case in live_cases:
        q, k, v, indices = make_inputs(case, seed=1101)
        indices = edge_indices(indices, case['block_size']).contiguous()
        factory = trial.native_sparse_attention(case['B'], case['HQ'], case['SEQ_LEN'],
            case['D'], case['is_causal'], scale=0.07, block_size=case['block_size'],
            groups=16, selected_blocks=case['S'])
        out = torch.empty_like(q)
        for iteration in range(3):
            if iteration:
                nq, nk, nv, _ = make_inputs(case, seed=1101 + iteration)
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
            report['refresh'].append(dict(config=case, iteration=iteration, max_abs_error=error))
            print('REFRESH PASS', case, iteration, error, flush=True)
            persist()
    for case in (cfg(37, 128, 32, b=2, h=2), cfg(1025, 128, 32)):
        _, k, v, _ = make_inputs(case, seed=1301)
        b, length, h, d, bs = case['B'], case['SEQ_LEN'], case['H'], case['D'], case['block_size']
        nb = (length + bs - 1) // bs
        pk = torch.full((b, nb, h, d // 32, bs // 16, 64, 8), float('nan'), dtype=k.dtype, device=k.device)
        pv = torch.full((b, nb, h, bs // 16, d // 32, 64, 8), float('nan'), dtype=v.dtype, device=v.device)
        trial.native_sparse_attention_pack_kv(b, length, h, d, bs)(k, v, pk, pv)
        rows = torch.arange(bs, device=k.device).view(-1, 1)
        cols = torch.arange(d, device=k.device).view(1, -1)
        for batch in range(b):
            for head in range(h):
                for block in range(nb):
                    expected_k = torch.zeros((bs, d), dtype=k.dtype, device=k.device)
                    expected_v = torch.zeros_like(expected_k)
                    valid = min(bs, length - block * bs)
                    expected_k[:valid].copy_(k[batch, block * bs:block * bs + valid, head])
                    expected_v[:valid].copy_(v[batch, block * bs:block * bs + valid, head])
                    actual_k = pk[batch, block, head, cols // 32, rows // 16,
                                  (cols % 32 // 8) * 16 + rows % 16, cols % 8]
                    actual_v = pv[batch, block, head, rows // 16, cols // 32,
                                  (rows % 16 // 4) * 16 + cols % 16,
                                  (cols % 32 // 16) * 4 + rows % 4]
                    torch.testing.assert_close(actual_k, expected_k, rtol=0, atol=0)
                    torch.testing.assert_close(actual_v, expected_v, rtol=0, atol=0)
        report['packing'].append(dict(config=case, exact=True, padding_zero=True, overwrites_nan=True))
        print('PACKING PASS', case, flush=True)
        persist()
    guard_path = ROOT / 'experiments/20260928_guard_fix/check_restricted_host.py'
    tree = ast.parse(guard_path.read_text())
    cutoff = next(i for i, node in enumerate(tree.body) if isinstance(node, ast.Assign)
                  and any(isinstance(t, ast.Name) and t.id == 'small' for t in node.targets))
    env = dict(__file__=str(guard_path), __name__='nsa_1001_guard_fixture')
    exec(compile(ast.Module(body=tree.body[:cutoff], type_ignores=[]), str(guard_path), 'exec'), env)
    guarded = env['guarded_module'](a.submission)
    for case in live_cases + [cfg(37, h=2, s=8, causal=False), cfg(129, d=32)]:
        error = check_case(guarded, case, 1201, None,
            lambda indices, bs=case['block_size']: edge_indices(indices, bs))
        report['guarded'].append(dict(config=case, max_abs_error=error, both_interfaces=True))
        print('GUARDED PASS', case, error, flush=True)
        persist()
    report['status'] = 'PASS'
    persist()
    print('PASS', {key: len(report[key]) for key in ('boundaries', 'sources', 'fallbacks', 'refresh', 'packing', 'guarded')}, flush=True)


if __name__ == '__main__':
    main()
