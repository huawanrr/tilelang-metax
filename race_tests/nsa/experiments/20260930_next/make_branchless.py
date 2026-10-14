"""Compare safe predicated packed loads with repeated per-block branches."""
import ast
import re

from make_probes import BASE, HERE, once, extract


if __name__ == '__main__':
    names = ('native_sparse_attention_online_packed',
             'native_sparse_attention_online_packed_batch_minor',
             'native_sparse_attention_online_packed_quad_batch_minor')
    for mode in ('loads', 'all'):
        fns = []
        for name in names:
            fn = extract(name)
            fn = once(fn, name + '(', name + '_branchless(')
            fn = re.sub(r'([KV])\[i_b, (i_s\w*) // BS,',
                        r'\1[i_b, T.min(T.max(\2 // BS, 0), T.ceildiv(seq_len, BS) - 1),', fn)
            # A redundant outer validity branch can be removed when safe
            # memory coordinates and the exact validity mask are retained.
            tree = ast.parse(fn)
            lines = fn.splitlines(keepends=True)
            edits = []
            for node in ast.walk(tree):
                if not isinstance(node, ast.If):
                    continue
                test = ast.unparse(node.test)
                if not ('seq_len' in test and 'i_s' in test and '>=' in test
                        and 'is_causal' in test):
                    continue
                body = ''.join(lines[node.body[0].lineno - 1:node.body[-1].end_lineno])
                is_load_only = 'qk.mma(' not in body
                if mode == 'all' or is_load_only:
                    indent = ' ' * node.col_offset
                    terms = node.test.values if isinstance(node.test, ast.BoolOp) else [node.test]
                    kept = [ast.unparse(v) for v in terms if 'i_s' not in ast.unparse(v)]
                    guard = ' and '.join(kept) if kept else 'T.bool(True)'
                    edits.append((node.lineno - 1, node.body[0].lineno - 1,
                                  indent + f'if {guard}:\n'))
            for start, end, replacement in sorted(edits, reverse=True):
                lines[start:end] = [replacement]
            fn = ''.join(lines)
            if mode == 'all':
                pattern = r'(\s*)if is_causal and (i_s\w*) \+ BS > i_t \+ 1:'
                def mask(match):
                    space, pos = match.group(1), match.group(2)
                    indent = space[space.rfind('\n') + 1:]
                    return (space + f'if {pos} < 0 or {pos} >= seq_len or (is_causal and {pos} > i_t):\n'
                            + indent + '    T.fill(acc_s, neg_inf)\n'
                            + indent + f'elif is_causal and {pos} + BS > i_t + 1:')
                fn, count = re.subn(pattern, mask, fn)
                assert count == 5, (name, count)
            ast.parse(fn)
            fns.append(fn)
        result = once(BASE, '\n_KERNEL_CACHE = {}', '\n' + '\n'.join(fns) + '\n_KERNEL_CACHE = {}')
        a = result.index('        elif S >= 8 and use_emitter_online:')
        b = a + re.search(r'^        elif', result[a + 1:], re.MULTILINE).start() + 1
        original = result[a:b]
        branch = original.replace('elif S >= 8 and use_emitter_online:', 'elif S == 8 and use_emitter_online:')
        for name in reversed(names):
            branch = branch.replace(name + '(', name + '_branchless(')
        result = result[:a] + branch + original + result[b:]
        ast.parse(result)
        p = HERE / f'branchless_{mode}_v2.py'
        if p.exists():
            raise FileExistsError(p)
        p.write_text(result)
        print(p.name)
