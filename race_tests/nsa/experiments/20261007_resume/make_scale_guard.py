"""Preserve masked zeros at nonpositive scales in the new S2 builders."""
import argparse
import ast
import hashlib
import json
from pathlib import Path

from assemble_candidate import functions, replace_once


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('parent')
    parser.add_argument('output')
    args = parser.parse_args()
    parent, target = Path(args.parent), Path(args.output)
    original = parent.read_text()
    before = functions(original)
    lines = original.splitlines(keepends=True)
    names = ('native_sparse_attention_short_list_blocks',
             'native_sparse_attention_short_list_qo_v2_blocks')
    old = ('                for i, j in T.Parallel(G, BS):\n'
           '                    acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))\n')
    new = ('                if scale_log2 > 0.0:\n'
           '                    for i, j in T.Parallel(G, BS):\n'
           '                        acc_s[i, j] = T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0))\n'
           '                else:\n'
           '                    # A masked -inf must stay zero even when scaling by\n'
           '                    # zero or a negative constant. The positive-scale\n'
           '                    # branch retains the measured instruction sequence.\n'
           '                    for i, j in T.Parallel(G, BS):\n'
           '                        pos = _paired_pos_sel(j, starts, S, IBS)\n'
           '                        acc_s[i, j] = T.if_then_else(\n'
           '                            pos >= 0 and pos < seq_len and (not is_causal or pos <= i_t),\n'
           '                            T.exp2(T.min(acc_s[i, j] * scale_log2, 15.0)), T.float32(0))\n')
    source = original
    for name in reversed(names):
        fn = before[name]
        text = ''.join(lines[fn.lineno-1:fn.end_lineno])
        replacement = replace_once(text, old, new)
        source = replace_once(source, text, replacement)
    after = functions(source)
    unchanged = [name for name in before if name not in names]
    assert all(ast.dump(before[name]) == ast.dump(after[name]) for name in unchanged)
    with target.open('x') as f:
        f.write(source)
    config = json.loads(parent.with_name(parent.stem + '_assembly.json').read_text())
    config.update(candidate=str(target), candidate_sha256=digest(target),
        scale_guard_parent=str(parent), scale_guard_parent_sha256=digest(parent),
        new_builder_ast_equal_to_probe=False,
        positive_scale_device_code_equivalence_pending=True,
        nonpositive_scale_mask_fix=True,
        nonpositive_scale_fix_scope='Only the newly selected S2 complete-block builders.',
        scale_guard_unchanged_functions=unchanged)
    target.with_name(target.stem + '_assembly.json').write_text(json.dumps(config, indent=2) + '\n')
    print(target, digest(target))


if __name__ == '__main__':
    main()
