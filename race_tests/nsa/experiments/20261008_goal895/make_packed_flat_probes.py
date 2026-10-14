"""Expose packed, contiguous loads as 32-bit-indexed lane-owned vectors."""
import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent
BASE = (ROOT / 'baseline.py').read_text()
NAME = 'native_sparse_attention_single_packed_qo_v2_mathcast'


class Loads(ast.NodeTransformer):
    def __init__(self, which):
        self.which = which

    def visit_For(self, node):
        if (isinstance(node.iter, ast.Call) and ast.unparse(node.iter.func) == 'T.Parallel'
                and len(node.body) == 1 and isinstance(node.body[0], ast.Assign)):
            target = node.body[0].targets[0]
            if isinstance(target, ast.Subscript):
                name = ast.unparse(target.value)
                if name == 'k' and name in self.which:
                    return ast.parse('''
for load_chunk in T.unroll(BS * D // 512):
    for load_element in T.vectorized(8):
        k[load_chunk % (BS // 16) * 16 + T.get_thread_binding() % 16, load_chunk // (BS // 16) * 32 + T.get_thread_binding() // 16 * 8 + load_element] = K_flat[b, block, h, load_chunk * 512 + T.get_thread_binding() * 8 + load_element]
''').body[0]
                if name == 'v' and name in self.which:
                    offset = 'vo * (W // 32)' if 'vo' in ast.unparse(node.body[0].value) else '0'
                    return ast.parse(f'''
for load_chunk in T.unroll(BS * W // 512):
    for load_element in T.vectorized(8):
        v[load_chunk // (W // 32) * 16 + T.get_thread_binding() // 16 * 4 + load_element % 4, load_chunk % (W // 32) * 32 + load_element // 4 * 16 + T.get_thread_binding() % 16] = V_flat[b, block, h, (load_chunk // (W // 32) * (D // 32) + load_chunk % (W // 32) + {offset}) * 512 + T.get_thread_binding() * 8 + load_element]
''').body[0]
        return self.generic_visit(node)


for which, qvec in [('k', 4), ('v', 4), ('kv', 4), ('', 8), ('kv', 8)]:
    fn = next(n for n in ast.parse(BASE).body if isinstance(n, ast.FunctionDef) and n.name == NAME)
    start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
    end = fn.end_lineno
    fn = Loads(which).visit(fn)
    prim = next(n for n in fn.body if isinstance(n, ast.FunctionDef) and n.name == 'kernel')
    setup = []
    if 'k' in which:
        setup += ast.parse('K_flat = T.reshape(K, [batch, NB, H, BS * D])').body
    if 'v' in which:
        setup += ast.parse('V_flat = T.reshape(V, [batch, NB, H, BS * D])').body
    prim.body[0].body[:0] = setup
    ast.fix_missing_locations(fn)
    text = ast.unparse(fn)
    if qvec != 4:
        text = text.replace('(qi * D + qd) // 4 % 64', f'(qi * D + qd) // {qvec} % 64')
        text = text.replace('(qi * D + qd) // 256 * 4 + qd % 4', f'(qi * D + qd) // {64*qvec} * {qvec} + qd % {qvec}')
    lines = BASE.splitlines(keepends=True)
    lines[start:end] = [text + '\n']
    source = ''.join(lines)
    ast.parse(source)
    name = f'packed_flat_{which or "none"}_q{qvec}'
    (ROOT / (name + '.py')).write_text(source)
    print(name)
