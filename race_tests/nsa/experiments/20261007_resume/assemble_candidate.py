"""Add the measured S2 complete-block builders to the verified S4/S8 release."""
import argparse
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def functions(source):
    return {node.name: node for node in ast.parse(source).body
            if isinstance(node, ast.FunctionDef)}


def replace_once(source, old, new):
    assert source.count(old) == 1, (old, source.count(old))
    return source.replace(old, new)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True)
    parser.add_argument('--grid-min', type=int, required=True)
    parser.add_argument('--seq-min', type=int, required=True)
    parser.add_argument('--noncausal-grid-min', type=int)
    parser.add_argument('--max-heads', type=int, default=0,
                        help='0 preserves the general KV-head layout')
    args = parser.parse_args()
    parent = ROOT / 'experiments/20261005_goal8929/release_v1/nsa.py'
    probe = HERE / 'short_refine_full2.py'
    source = parent.read_text()
    before = functions(source)
    measured = functions(probe.read_text())
    lines = probe.read_text().splitlines(keepends=True)
    names = ('native_sparse_attention_short_list_blocks',
             'native_sparse_attention_short_list_qo_v2_blocks')
    additions = []
    for name in names:
        fn = measured[name]
        start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
        additions.append(''.join(lines[start:fn.end_lineno]))
    source = replace_once(source, '\ndef _get_kernel(',
                          '\n\n'.join([''] + additions) + '\n\n\ndef _get_kernel(')
    head_guard = f' and H <= {args.max_heads}' if args.max_heads else ''
    causal_guard = (f'        and (is_causal or grid >= {args.noncausal_grid_min})\n'
                    if args.noncausal_grid_min else '')
    condition = (
        '    # The complete-block loads pay off once enough independent queries\n'
        '    # amortize their uniform validity branches. Tail sequences and\n'
        '    # explicit tuning retain the existing short-list builders.\n'
        '    short_complete_blocks = (joined_short and S == 2 and update_defaults\n'
        f'        and seq_len >= {args.seq_min} and grid >= {args.grid_min}{head_guard}\n'
        + causal_guard +
        '        and seq_len % block_size == 0)\n\n')
    source = replace_once(source, '    key = (\n', condition + '    key = (\n')
    source = replace_once(source,
        'shared_q_blocks, small_s8_split, s4_packed, s4_prefetch,\n',
        'shared_q_blocks, small_s8_split, s4_packed, s4_prefetch, short_complete_blocks,\n')
    previous = (
        '            short_builder = (native_sparse_attention_short_list_qo_v2 if short_qo_v2\n'
        '                             else native_sparse_attention_short_list)\n')
    source = replace_once(source, previous, previous +
        '            if short_complete_blocks:\n'
        '                short_builder = (native_sparse_attention_short_list_qo_v2_blocks if short_qo_v2\n'
        '                                 else native_sparse_attention_short_list_blocks)\n')
    after = functions(source)
    unchanged = [name for name in before if name != '_get_kernel']
    assert all(ast.dump(before[name]) == ast.dump(after[name]) for name in unchanged)
    assert all(ast.dump(measured[name]) == ast.dump(after[name]) for name in names)
    target = Path(args.output)
    with target.open('x') as f:
        f.write(source)
    config = json.loads((parent.parent / 'assembly.json').read_text())
    config.update(parent=str(parent), parent_sha256=digest(parent),
                  candidate=str(target), candidate_sha256=digest(target),
                  s2_probe=str(probe), s2_probe_sha256=digest(probe),
                  unchanged_functions=unchanged, added_functions=list(names),
                  new_builder_ast_equal_to_probe=True,
                  official_score=None, target_score=89.0)
    config['s2_config'] = dict(grid_min=args.grid_min, seq_len_min=args.seq_min,
        max_heads=args.max_heads or None, complete_blocks_only=True,
        noncausal_grid_min=args.noncausal_grid_min or args.grid_min,
        default_tuning_only=True, joined_qo_grid_min=3072,
        raw_indices_clamped_before_multiplication=True)
    config['selection_evidence'] = ['s2_family_multiseed.json', 's2_boundary_multiseed.json',
                                    's2_minimum_multiseed.json']
    config['selection_reason'] = 'S2 throughput-range selection; consult preserved full family and boundary results.'
    target.with_name(target.stem + '_assembly.json').write_text(json.dumps(config, indent=2) + '\n')
    print(target, digest(target), 'unchanged functions', len(unchanged))


if __name__ == '__main__':
    main()
