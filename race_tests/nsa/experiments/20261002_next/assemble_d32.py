"""Isolate measured D32 builders while retaining every 10.2 fallback."""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / 'experiments/20261002_final/nsa.py'


def once(source, old, new):
    assert source.count(old) == 1, (old, source.count(old))
    return source.replace(old, new)


def builder(path, old, new):
    source = path.read_text()
    node = next(n for n in ast.parse(source).body
                if isinstance(n, ast.FunctionDef) and n.name == old)
    lines = source.splitlines(keepends=True)
    start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    text = ''.join(lines[start:node.end_lineno])
    return once(text, 'def ' + old + '(', 'def ' + new + '(') + '\n\n'


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--config', required=True)
    p.add_argument('--output-dir', required=True)
    args = p.parse_args()
    config = json.loads(Path(args.config).read_text())
    out = Path(args.output_dir)
    out.mkdir(parents=True, exist_ok=True)
    dev, sub = out / 'nsa.py', out / 'submission.py'
    assert not dev.exists() and not sub.exists(), out
    base = BASE.read_text()
    assert hashlib.sha256(BASE.read_bytes()).hexdigest() == '299af0e0e0d6f22a1fee797e7d89df4e23c5b7da20750da9ea5ba601d002f620'
    guard_probe = HERE / 'index_guards_simple.py'
    compact_probe = HERE / 'd32_queries1_prefetch1_v2.py'
    assert 0 < config['compact_min_grid_exclusive'] < config['compact_max_grid_exclusive']
    assert config['direct_max_grid'] == config['compact_min_grid_exclusive'] == 512
    assert config['shuffle_min_grid'] == config['compact_max_grid_exclusive'] == 1024
    assert 1024 <= config['shuffle_max_grid'] <= 4096
    additions = ''
    for original in (
        'native_sparse_attention_single_block_emitter',
        'native_sparse_attention_single_block_emitter_wave',
        'native_sparse_attention_d32_shuffle_wave',
    ):
        additions += builder(guard_probe, original, original + '_index_guard')
    additions += builder(compact_probe, 'native_sparse_attention_d32_query_ilp',
                         'native_sparse_attention_d32_compact')
    source = once(base, '\ndef _get_kernel(', '\n' + additions + '\ndef _get_kernel(')
    direct_heads = 'True' if config['direct_max_heads'] is None else f"H <= {config['direct_max_heads']}"
    shuffle_heads = 'True' if config['shuffle_max_heads'] is None else f"H <= {config['shuffle_max_heads']}"
    flags = f'''    # D32 uses block-number validation before forming an element address.
    # Keep explicit tuning options on their original paths. The medium-grid
    # compact builder uses contiguous K loads followed by register shuffles.
    d32_defaults = (S == 1 and D == 32 and block_size == 16 and groups == 16
        and threads == 64 and stage_regs and kv_reuse and q_preload and nmax
        and not o_stage and not kv_frag and not kv_split and not q_frag
        and min_blocks == 0 and pair_resolved == 1 and num_stages == 1
        and online_unroll == 2 and not late_normalize)
    d32_index_guard = (d32_defaults and (
        (grid <= {config['direct_max_grid']} and {direct_heads})
        or ({config['shuffle_min_grid']} <= grid <= {config['shuffle_max_grid']} and {shuffle_heads})))
    d32_compact = (d32_defaults
        and {config['compact_min_grid_exclusive']} < grid < {config['compact_max_grid_exclusive']})

'''
    source = once(source, '    key = (\n        B,\n        seq_len,',
                  flags + '    key = (\n        B,\n        seq_len,')
    source = once(source, '        packed_direct, short_wave_v2, short_qo_v2, s8_output_v2,',
        '        packed_direct, short_wave_v2, short_qo_v2, s8_output_v2,\n'
        '        d32_index_guard, d32_compact,')
    source = once(source, '        if packed_qo:\n', '''        if d32_compact:
            kernel = native_sparse_attention_d32_compact(**common)
        elif d32_index_guard:
            if direct_k:
                d32_builder = (native_sparse_attention_single_block_emitter_wave_index_guard
                    if wave_single else native_sparse_attention_single_block_emitter_index_guard)
            else:
                d32_builder = native_sparse_attention_d32_shuffle_wave_index_guard
            kernel = d32_builder(late_normalize=late_normalize, lane_reduce=True,
                                 kv_split=False, direct_k=direct_k, **common)
        elif packed_qo:
''')
    before = {n.name: ast.dump(n, include_attributes=False) for n in ast.parse(base).body
              if isinstance(n, ast.FunctionDef)}
    after = {n.name: ast.dump(n, include_attributes=False) for n in ast.parse(source).body
             if isinstance(n, ast.FunctionDef)}
    retained = [name for name in before if name != '_get_kernel']
    assert all(before[name] == after[name] for name in retained)
    assert len(set(after) - set(before)) == 4
    dev.write_text(source)
    subprocess.run([sys.executable, str(ROOT.parent / 'moe/strip_comments.py'),
                    str(dev), str(sub), '--docstrings'], check=True)
    subprocess.run([sys.executable, str(ROOT / 'check_submission_nsa.py'), str(dev), str(sub)], check=True)
    manifest = dict(config=config, retained_functions=retained,
        new_functions=sorted(set(after) - set(before)),
        source_sha256={str(path.relative_to(ROOT)): hashlib.sha256(path.read_bytes()).hexdigest()
                       for path in (BASE, guard_probe, compact_probe, dev.resolve(), sub.resolve())},
        baseline_official_score=87.93, target_official_score=88.5,
        new_official_score=None, status='assembled; GPU validation pending')
    (out / 'assembly.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print('Assembled', out, 'with', len(retained), 'unchanged 10.2 functions')


if __name__ == '__main__':
    main()
