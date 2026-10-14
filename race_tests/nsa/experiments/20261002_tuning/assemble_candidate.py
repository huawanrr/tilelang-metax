"""Assemble measured builders without changing the 10.1 fallback kernels."""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / 'experiments/20261001_final/nsa.py'


def once(source, old, new):
    assert source.count(old) == 1, (old, source.count(old))
    return source.replace(old, new)


def builder(path, old, new):
    source = (ROOT / path).read_text()
    node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == old)
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
    assert hashlib.sha256(BASE.read_bytes()).hexdigest() == 'f327110219829405b88594ab8775f7bf98e4a84d528401c34d3cb2bf64b06f3e'
    additions = ''
    additions += builder(config['packed_attention_probe'], 'native_sparse_attention_single_packed_qo',
                         'native_sparse_attention_single_packed_qo_v2')
    additions += builder(config['packed_direct_probe'], 'native_sparse_attention_pack_kv',
                         'native_sparse_attention_pack_kv_bs32_direct')
    additions += builder(config['packed_shared_probe'], 'native_sparse_attention_pack_kv',
                         'native_sparse_attention_pack_kv_bs32_shared')
    separate_short_wave = config['short_wave_min_grid'] < config['short_qo_min_grid']
    if separate_short_wave:
        additions += builder(config['short_wave_probe'], 'native_sparse_attention_short_list',
                             'native_sparse_attention_short_list_wave_v2')
    additions += builder(config['short_qo_probe'], 'native_sparse_attention_short_list',
                         'native_sparse_attention_short_list_qo_v2')
    if config['s8_output_min_grid'] is not None:
        assert config['s8_output_min_grid'] >= 4096
        for suffix in ('batch_minor', 'quad_batch_minor'):
            old = 'native_sparse_attention_online_packed_' + suffix
            additions += builder(config['s8_probe'], old, old + '_o_v2')

    source = once(base, '\ndef _get_kernel(', '\n' + additions + '\ndef _get_kernel(')
    marker = '    key = (\n        B,\n        seq_len,'
    flags = f'''    # Changes below are shape specializations of the default public paths.
    # Packing always reads the current inputs, including during graph replay.
    packed_direct = (packed_qo and H == 1 and seq_len >= {config['packed_direct_min_seq']}
                     and grid < {config['packed_direct_max_grid']})
    update_defaults = (threads == 64 and groups == 16 and stage_regs and kv_reuse
        and q_preload and nmax and not o_stage and not kv_frag and not kv_split
        and min_blocks == 0 and pair_resolved == 1 and num_stages == 1
        and online_unroll == 2 and q_frag and not late_normalize)
    short_wave_v2 = (joined_short and S == 2 and update_defaults
                     and grid >= {config['short_wave_min_grid']})
    short_qo_v2 = short_wave_v2 and grid >= {config['short_qo_min_grid']}
'''
    if config['s8_output_min_grid'] is not None:
        flags += f'''    s8_output_v2 = (S == 8 and use_emitter_online and update_defaults
                    and grid >= {config['s8_output_min_grid']})
'''
    else:
        flags += '    s8_output_v2 = False\n'
    source = once(source, marker, flags + '\n' + marker)
    source = once(source, '        coalesced_qo, qo_narrow, qo_four, qo_ilp, packed_qo,',
                  '        coalesced_qo, qo_narrow, qo_four, qo_ilp, packed_qo,\n'
                  '        packed_direct, short_wave_v2, short_qo_v2, s8_output_v2,')
    source = once(source,
        '''        if packed_qo:
            attention = native_sparse_attention_single_packed_qo(width=128, late=False, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)''',
        '''        if packed_qo:
            attention = native_sparse_attention_single_packed_qo_v2(width=128, late=False, **common)
            pack_builder = (native_sparse_attention_pack_kv_bs32_direct if packed_direct
                            else native_sparse_attention_pack_kv_bs32_shared)
            pack = pack_builder(B, seq_len, H, D, block_size)''')
    short_dispatch = (
        '''        elif joined_short:
            short_builder = (native_sparse_attention_short_list_qo_v2 if short_qo_v2
                             else native_sparse_attention_short_list_wave_v2 if short_wave_v2
                             else native_sparse_attention_short_list)
            kernel = short_builder(''' if separate_short_wave else
        '''        elif joined_short:
            short_builder = (native_sparse_attention_short_list_qo_v2 if short_qo_v2
                             else native_sparse_attention_short_list)
            kernel = short_builder(''')
    source = once(source,
        '''        elif joined_short:
            kernel = native_sparse_attention_short_list(''', short_dispatch)
    if config['s8_output_min_grid'] is not None:
        for suffix in ('quad_batch_minor', 'batch_minor'):
            name = 'native_sparse_attention_online_packed_' + suffix
            source = once(source, '                attention = ' + name + '(',
                '                online_builder = (' + name + '_o_v2 if s8_output_v2\n'
                '                                  else ' + name + ')\n'
                '                attention = online_builder(')

    old_functions = {n.name: ast.dump(n, include_attributes=False) for n in ast.parse(base).body
                     if isinstance(n, ast.FunctionDef)}
    new_functions = {n.name: ast.dump(n, include_attributes=False) for n in ast.parse(source).body
                     if isinstance(n, ast.FunctionDef)}
    retained = [name for name in old_functions if name != '_get_kernel']
    assert all(old_functions[name] == new_functions[name] for name in retained)
    dev.write_text(source)
    subprocess.run([sys.executable, str(ROOT.parent / 'moe/strip_comments.py'),
                    str(dev), str(sub), '--docstrings'], check=True)
    subprocess.run([sys.executable, str(ROOT / 'check_submission_nsa.py'), str(dev), str(sub)], check=True)
    manifest = dict(config=config, retained_functions=retained,
                    new_functions=sorted(set(new_functions) - set(old_functions)),
                    source_sha256={str(path): hashlib.sha256(path.read_bytes()).hexdigest()
                                   for path in (BASE, dev, sub)},
                    baseline_official_score=87.93, target_official_score=88.5,
                    new_official_score=None, status='assembled; GPU release verification pending')
    (out / 'assembly.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print('Assembled', out, 'with', len(retained), 'unchanged baseline functions')


if __name__ == '__main__':
    main()
