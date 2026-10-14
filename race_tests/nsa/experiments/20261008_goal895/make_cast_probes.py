"""Extend yesterday's measured scalar conversions to the other OJ families."""
import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent
SOURCE = (ROOT / 'baseline.py').read_text()
TARGETS = {
    'native_sparse_attention_single_linear_v_wave',
    'native_sparse_attention_shared_q_blocks',
    'native_sparse_attention_shared_q_reuse',
    'native_sparse_attention_single_block_emitter_wave_index_guard',
    'native_sparse_attention_short_list',
    'native_sparse_attention_online_emitter',
}


def statements(source):
    return ast.parse(source).body


class Convert(ast.NodeTransformer):
    def __init__(self, probability, output, exponent):
        self.probability = probability
        self.output = output
        self.exponent = exponent

    def visit_Expr(self, node):
        if not isinstance(node.value, ast.Call):
            return self.generic_visit(node)
        call = node.value
        if ast.unparse(call.func) != 'T.copy' or len(call.args) != 2:
            return self.generic_visit(node)
        src, dst = map(ast.unparse, call.args)
        if self.probability and (src, dst) == ('acc_s', 'acc_s_cast'):
            return statements('''
for cast_chunk in T.unroll(BS // 16):
    for cast_lane in T.unroll(4):
        acc_s_cast[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane] = acc_s[T.get_thread_binding() % 16, cast_chunk * 16 + T.get_thread_binding() // 16 * 4 + cast_lane]
''')
        if self.output and src == 'acc_o' and dst.startswith('Output['):
            return statements('''
O_cast = T.alloc_fragment([G, BV], T.float16)
T.annotate_layout({O_cast: pv.make_mma_store_layout(O_cast)})
for output_chunk in T.unroll(BV // 16):
    for output_lane in T.unroll(4):
        O_cast[T.get_thread_binding() % 16, output_chunk * 16 + T.get_thread_binding() // 16 * 4 + output_lane] = acc_o[T.get_thread_binding() % 16, output_chunk * 16 + T.get_thread_binding() // 16 * 4 + output_lane]
''') + statements(f'T.copy(O_cast, {dst})')
        return self.generic_visit(node)

    def visit_Call(self, node):
        node = self.generic_visit(node)
        if self.exponent and ast.unparse(node.func) == 'T.exp2':
            assert ast.unparse(node.args[0].func) == 'T.min'
            mul = node.args[0].args[0]
            assert ast.unparse(mul.right) == 'scale_log2'
            return ast.parse(f'T.exp(T.min({ast.unparse(mul.left)} * (scale_log2 * 0.6931471805599453), 10.39720770839918))', mode='eval').body
        return node


def build(name, probability, output, exponent):
    tree = ast.parse(SOURCE)
    lines = SOURCE.splitlines(keepends=True)
    replacements = []
    for node in tree.body:
        if isinstance(node, ast.FunctionDef) and node.name in TARGETS:
            start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
            end = node.end_lineno
            replacement = Convert(probability, output, exponent).visit(node)
            ast.fix_missing_locations(replacement)
            replacements.append((start, end, ast.unparse(replacement) + '\n'))
    assert len(replacements) == len(TARGETS)
    for start, end, replacement in reversed(replacements):
        lines[start:end] = [replacement]
    result = ''.join(lines)
    ast.parse(result)
    (ROOT / f'{name}.py').write_text(result)
    print(name, len(result), len(replacements))


if __name__ == '__main__':
    build('cast_control', False, False, False)
    build('cast_probability', True, False, False)
    build('cast_output', False, True, False)
    build('cast_both', True, True, False)
    build('cast_both_exp', True, True, True)
