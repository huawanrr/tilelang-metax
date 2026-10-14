"""Retest exponent/mask combinations on the current scalar conversion paths."""
import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent
BASE = (ROOT / 'candidate_v2.py').read_text()
TARGETS = {'_coalesced_block_loads_prim_mathcast',
           'native_sparse_attention_single_packed_qo_v2_mathcast'}


class Math(ast.NodeTransformer):
    def __init__(self, name, natural, mask):
        self.acc = 'scores' if name.startswith('native') else 'acc_s'
        start, token = ('start', 'token') if name.startswith('native') else ('_start_buffer_0[0]', 'i_t')
        self.valid = f'{start} + j < seq_len and (not is_causal or {start} + j <= {token})'
        self.natural, self.mask = natural, mask

    def visit_For(self, n):
        if self.mask != 'none' and ast.unparse(n.iter) == 'T.Parallel(G, BS)' and 'T.infinity(' in ast.unparse(n):
            return ast.parse(f'T.clear({self.acc})').body[0]
        return self.generic_visit(n)

    def visit_If(self, n):
        n = self.generic_visit(n)
        if n.orelse and ast.dump(ast.Module(body=n.body, type_ignores=[])) == ast.dump(ast.Module(body=n.orelse, type_ignores=[])):
            return n.body
        return n

    def visit_Call(self, n):
        n = self.generic_visit(n)
        if self.natural and ast.unparse(n.func) == 'T.exp2':
            assert ast.unparse(n.args[0].func) == 'T.min'
            score = n.args[0].args[0].left
            return ast.parse(f'T.exp(T.min({ast.unparse(score)} * (scale_log2 * 0.6931471805599453), 10.39720770839918))', mode='eval').body
        return n

    def visit_Assign(self, n):
        n = self.generic_visit(n)
        if self.mask == 'none' or len(n.targets) != 1 or not isinstance(n.targets[0], ast.Subscript):
            return n
        if ast.unparse(n.targets[0].value) != self.acc:
            return n
        if not any(isinstance(x, ast.Call) and ast.unparse(x.func) in ('T.exp', 'T.exp2') for x in ast.walk(n.value)):
            return n
        value = ast.unparse(n.value)
        expression = (f'({value}) * T.if_then_else({self.valid}, T.float32(1.0), T.float32(0.0))'
                      if self.mask == 'multiply' else f'T.if_then_else({self.valid}, {value}, T.float32(0.0))')
        n.value = ast.parse(expression, mode='eval').body
        return n


for natural, mask in ((True, 'none'), (True, 'multiply'), (True, 'predicate'), (False, 'multiply')):
    edits = []
    lines = BASE.splitlines(keepends=True)
    for fn in ast.parse(BASE).body:
        if not isinstance(fn, ast.FunctionDef) or fn.name not in TARGETS:
            continue
        a = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
        b = fn.end_lineno
        fn = Math(fn.name, natural, mask).visit(fn)
        ast.fix_missing_locations(fn)
        edits.append((a, b, ast.unparse(fn) + '\n'))
    for a, b, fn in reversed(edits):
        lines[a:b] = [fn]
    s = ''.join(lines)
    ast.parse(s)
    name = f'single_math_e{int(natural)}_{mask}'
    (ROOT / (name + '.py')).write_text(s)
    print(name)
