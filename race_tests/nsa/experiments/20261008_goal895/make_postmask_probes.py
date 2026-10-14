"""Keep masked scores finite through MMA and apply validity to probabilities."""
import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent
BASE = (ROOT / 'candidate_v1.py').read_text()
TARGETS = {'native_sparse_attention_direct_kv', 'native_sparse_attention_short_list_oct8'}


class PostMask(ast.NodeTransformer):
    def __init__(self, short, mode):
        self.acc = 'acc_s' if short else 'scores'
        pos = '_paired_pos_sel(j, starts, S, IBS)' if short else 'block * BS + j'
        time = 'i_t' if short else 'token'
        self.valid = f'({pos}) >= 0 and ({pos}) < seq_len and (not is_causal or ({pos}) <= {time})'
        self.mode = mode

    def visit_For(self, node):
        if ast.unparse(node.iter) == 'T.Parallel(G, BS)' and 'T.infinity(' in ast.unparse(node):
            return ast.parse(f'T.clear({self.acc})').body[0]
        return self.generic_visit(node)

    def visit_Assign(self, node):
        if len(node.targets) != 1 or not isinstance(node.targets[0], ast.Subscript):
            return self.generic_visit(node)
        if ast.unparse(node.targets[0].value) != self.acc:
            return self.generic_visit(node)
        exp = any(isinstance(n, ast.Call) and ast.unparse(n.func) in ('T.exp', 'T.exp2')
                  for n in ast.walk(node.value))
        if not exp:
            return self.generic_visit(node)
        value = ast.unparse(node.value)
        if self.mode == 'multiply':
            expression = f'({value}) * T.if_then_else({self.valid}, T.float32(1.0), T.float32(0.0))'
        else:
            expression = f'T.if_then_else({self.valid}, {value}, T.float32(0.0))'
        node.value = ast.parse(expression, mode='eval').body
        return node


for mode in ('multiply', 'predicate'):
    lines = BASE.splitlines(keepends=True)
    edits = []
    for fn in ast.parse(BASE).body:
        if not isinstance(fn, ast.FunctionDef) or fn.name not in TARGETS:
            continue
        start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
        end = fn.end_lineno
        fn = PostMask('short' in fn.name, mode).visit(fn)
        ast.fix_missing_locations(fn)
        edits.append((start, end, ast.unparse(fn) + '\n'))
    for start, end, text in reversed(edits):
        lines[start:end] = [text]
    source = ''.join(lines)
    ast.parse(source)
    name = f'candidate_postmask_{mode}'
    (ROOT / (name + '.py')).write_text(source)
    print(name)
