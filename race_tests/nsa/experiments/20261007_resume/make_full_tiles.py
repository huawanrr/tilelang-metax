"""Fast branches for runtime-validated complete selected blocks."""
import ast
import copy
import hashlib
import json
import textwrap
from pathlib import Path

from make_s8_schedule import region, replace_once

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/nsa.py'
S8_NAMES = ('native_sparse_attention_online_packed',
            'native_sparse_attention_online_packed_batch_minor_o_v2',
            'native_sparse_attention_online_packed_quad_batch_minor_o_v2')


class CompleteBlocks(ast.NodeTransformer):
    def visit_If(self, node):
        test = ast.unparse(node.test)
        if 'i_s' in test and 'BS' in test and '>' in test:
            return ast.parse('T.clear(acc_s)').body[0]
        self.generic_visit(node)
        if 'i_s' in test and '>=' in test and '< seq_len' in test:
            # Runtime validity is known, but prefetch_depth and the final
            # group's selected-position bounds still control which tiles exist.
            terms = node.test.values if isinstance(node.test, ast.BoolOp) else [node.test]
            structural = [t for t in terms if 'i_s' not in ast.unparse(t)]
            if not structural:
                return node.body
            node.test = structural[0] if len(structural) == 1 else ast.BoolOp(op=ast.And(), values=structural)
        return node


def full_s8(fn, unroll):
    tree = ast.parse(fn)
    loop = next(n for n in ast.walk(tree) if isinstance(n, ast.If)
                and ast.unparse(n.test) == 'prefetch_depth == 1')
    old = region(fn, loop)
    full = ast.unparse(ast.fix_missing_locations(CompleteBlocks().visit(copy.deepcopy(loop))))
    if unroll:
        full = full.replace('T.serial(T.ceildiv(S, prefetch_depth))',
                            'T.unroll(T.ceildiv(S, prefetch_depth))')
    replacement = ('            if full_bounds[0] >= 0 and full_bounds[1] < full_limit:\n'
                   + textwrap.indent(full, ' ' * 16) + '\n'
                   + '            else:\n' + textwrap.indent(old, ' ' * 4))
    fn = replace_once(fn, old, replacement)
    fn = replace_once(fn, '            indices = T.alloc_local([S], T.int32)\n',
        '''            indices = T.alloc_local([S], T.int32)
            full_bounds = T.alloc_local([2], T.int32)
            full_bounds[0] = 2147483647
            full_bounds[1] = -2147483648
            full_limit = T.min(seq_len // BS, (i_t + 1) // BS) if is_causal else seq_len // BS
''')
    fn = replace_once(fn, '                indices[si] = BlockIndices[i_b, i_t, i_h, si] * BS',
        '''                raw_index = BlockIndices[i_b, i_t, i_h, si]
                full_bounds[0] = T.min(full_bounds[0], raw_index)
                full_bounds[1] = T.max(full_bounds[1], raw_index)
                indices[si] = T.if_then_else(raw_index >= 0 and raw_index < T.ceildiv(seq_len, BS),
                                            raw_index * BS, seq_len)''')
    ast.parse(fn)
    return fn


def full_s1(fn, split_guard):
    tree = ast.parse(fn)
    mask = next(n for n in ast.walk(tree) if isinstance(n, ast.For)
                and isinstance(n.body[0], ast.Assign)
                and 'scores[i, j] = T.if_then_else' in ast.unparse(n))
    old = region(fn, mask)
    replacement = ('                if start + BS <= seq_len and (not is_causal or start + BS <= token + 1):\n'
                   '                    T.clear(scores)\n'
                   '                else:\n' + textwrap.indent(old, ' ' * 4))
    fn = replace_once(fn, old, replacement)
    if split_guard:
        fn = replace_once(fn,
            '            valid = block >= 0 and block < NB and (not is_causal or start <= token)',
            '            valid = block >= 0 and block < (T.min(NB, token // BS + 1) if is_causal else NB)')
    ast.parse(fn)
    return fn


def main():
    baseline = BASE.read_text()
    records = []
    for kind, option in (('s8', False), ('s8', True), ('s1', False), ('s1', True)):
        source = baseline
        names = S8_NAMES if kind == 's8' else ('native_sparse_attention_single_packed_qo_v2',)
        for name in names:
            node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
            old = region(source, node, decorated=True)
            new = full_s8(old, option) if kind == 's8' else full_s1(old, option)
            source = replace_once(source, old, new)
        path = HERE / f'full_tiles_v2_{kind}_{int(option)}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, kind=kind, option=option,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'full_tiles_v2_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records, note='Full-tile branches require current raw indices to prove all keys valid; original masked computation handles everything else.'
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
