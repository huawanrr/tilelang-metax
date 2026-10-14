"""Assemble the 930 candidate from measured, immutable experiment builders."""
import argparse
import ast
import hashlib
import json
from pathlib import Path

from make_pair import BASE, HERE, ROOT, extract, replace_once


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', default='experiments/20260930_candidate/candidate_v1.py')
    parser.add_argument('--mid-q-limit', type=int, default=2048)
    parser.add_argument('--pv-min-grid', type=int, default=1024)
    args = parser.parse_args()
    sources = {}
    funcs = []
    specs = [
        ('single_wave.py', 'native_sparse_attention_single_block_emitter_wave'),
        ('single_wave.py', 'native_sparse_attention_single_vec16_wave'),
        ('single_wave.py', 'native_sparse_attention_single_linear_v_wave'),
        ('single_wave.py', 'native_sparse_attention_d32_shuffle_wave'),
        ('single_wave.py', 'native_sparse_attention_mid_shared_q_wave'),
        ('shared_q_reuse_wave.py', 'native_sparse_attention_shared_q_reuse'),
        ('pair_linear_early.py', 'native_sparse_attention_short_list'),
    ]
    for filename, name in specs:
        path = HERE / filename
        source = path.read_text()
        sources[str(path.relative_to(ROOT))] = hashlib.sha256(path.read_bytes()).hexdigest()
        funcs.append(extract(source, name))
    # The two verified PV variants differ only in the three barrier scopes.
    path = HERE / 'pv32_wave_sync.py'
    sources[str(path.relative_to(ROOT))] = hashlib.sha256(path.read_bytes()).hexdigest()
    fn = extract(path.read_text(), 'native_sparse_attention_wave_pv')
    fn = fn.replace('native_sparse_attention_wave_pv', 'native_sparse_attention_pv32_sync', 1)
    fn = replace_once(fn, '    threads=64,', '    threads=64, wave_sync=True,')
    assert fn.count('                T.sync_warp()') == 3
    fn = fn.replace('                T.sync_warp()',
        '                if wave_sync:\n                    T.sync_warp()\n'
        '                else:\n                    T.sync_threads()')
    funcs.append(fn)
    result = BASE.replace('\n_KERNEL_CACHE = {}', '\n' + '\n\n'.join(funcs) + '\n_KERNEL_CACHE = {}', 1)
    flags = f'''
    # Each explicit emitter CTA is exactly one 64-lane MACA wave. The new
    # builders retain a barrier at every shared RAW/WAR dependency.
    wave_single = (S == 1 and use_emitter and not kv_split and (
        (D == 32 and block_size == 16 and (grid <= 192 or 512 <= grid <= 4096))
        or (D == 64 and ((block_size == 16 and direct_k) or
                        (block_size in (32, 64) and grid <= 2048)))
        or (D == 128 and block_size == 16 and grid <= 2048)))
    wave_q_defaults = (S == 1 and D == 64 and block_size == 16 and groups == 16
        and threads == 64 and not kv_frag and not kv_split and kv_reuse
        and stage_regs and q_preload and not q_frag and nmax and not o_stage
        and min_blocks == 0)
    wave_q_reuse = wave_q_defaults and 256 < grid <= {args.mid_q_limit}
    wave_q_parallel = wave_q_defaults and 2560 < grid <= 4096
    pv32_sync = (S == 1 and use_emitter and D == 128 and block_size == 32
        and not kv_split and grid >= {args.pv_min_grid})
    # Concatenation removes the per-block loop. For S4, limit it to short
    # launches with enough sequence length to amortize four selected tiles.
    joined_short = (use_emitter_online and block_size == 16 and seq_len >= 64
        and (S == 2 or (S == 4 and seq_len >= 128 and grid <= 384)))
'''
    result = replace_once(result, '    key = (\n', flags + '\n    key = (\n')
    result = replace_once(result, '        mid_shared_q,\n',
        '        mid_shared_q,\n        wave_single, wave_q_reuse, wave_q_parallel, pv32_sync, joined_short,\n')
    result = replace_once(result, '        if d32_shuffle:', '''        if joined_short:
            kernel = native_sparse_attention_short_list(
                selected_blocks=S, late_normalize=False, lane_reduce=True,
                kv_split=False, direct_k=False, **common)
        elif pv32_sync:
            kernel = native_sparse_attention_pv32_sync(
                wave_sync=grid >= 2048, late_normalize=False, lane_reduce=True,
                kv_split=False, direct_k=False, **common)
        elif wave_q_reuse:
            kernel = native_sparse_attention_shared_q_reuse(
                late_normalize=late_normalize, lane_reduce=True,
                kv_split=False, direct_k=False, **common)
        elif wave_q_parallel:
            kernel = native_sparse_attention_mid_shared_q_wave(
                late_normalize=late_normalize, lane_reduce=True,
                kv_split=False, direct_k=False, **common)
        elif wave_single:
            if d32_shuffle:
                kernel = native_sparse_attention_d32_shuffle_wave(
                    late_normalize=late_normalize, lane_reduce=True,
                    kv_split=False, direct_k=False, **common)
            elif direct_vec16:
                kernel = native_sparse_attention_single_vec16_wave(
                    late_normalize=late_normalize, lane_reduce=True,
                    kv_split=False, direct_k=direct_k, **common)
            elif linear_v:
                kernel = native_sparse_attention_single_linear_v_wave(
                    late_normalize=late_normalize, lane_reduce=True,
                    kv_split=False, direct_k=direct_k, **common)
            else:
                kernel = native_sparse_attention_single_block_emitter_wave(
                    late_normalize=late_normalize, lane_reduce=True,
                    kv_split=False, direct_k=direct_k, **common)
        elif d32_shuffle:''')
    ast.parse(result)
    output = ROOT / args.output
    output.parent.mkdir(parents=True, exist_ok=True)
    if output.exists():
        raise FileExistsError(f'Refusing to overwrite a potentially running JIT source: {output}')
    output.write_text(result)
    original = {n.name: ast.dump(n, include_attributes=False) for n in ast.parse(BASE).body
                if isinstance(n, ast.FunctionDef)}
    current = {n.name: ast.dump(n, include_attributes=False) for n in ast.parse(result).body
               if isinstance(n, ast.FunctionDef)}
    assert all(current[name] == node for name, node in original.items() if name != '_get_kernel')
    report = dict(base='experiments/20260929_candidate/nsa.py', source_sha256=sources,
        output=str(output.relative_to(ROOT)), sha256=hashlib.sha256(output.read_bytes()).hexdigest(),
        original_builders_unchanged=True, mid_q_limit=args.mid_q_limit, pv_min_grid=args.pv_min_grid)
    output.with_suffix('.build.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()
