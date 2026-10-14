"""Keep QK, normalization and PV inside one validated-block branch."""
import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent
BASE = (ROOT / 'baseline.py').read_text()
TARGETS = {
    '_coalesced_block_loads_prim_mathcast': ('acc_o', 'VW == BV'),
    'native_sparse_attention_single_packed_qo_v2_mathcast': ('out', 'W == D'),
}


class SetZero(ast.NodeTransformer):
    def visit_Name(self, node):
        return ast.Constant(0) if node.id == 'vo' and isinstance(node.ctx, ast.Load) else node


class Natural(ast.NodeTransformer):
    def visit_Call(self, node):
        node = self.generic_visit(node)
        if ast.unparse(node.func) == 'T.exp2':
            arg = node.args[0]
            assert ast.unparse(arg.func) == 'T.min'
            assert ast.unparse(arg.args[0].right) == 'scale_log2'
            value = ast.unparse(arg.args[0].left)
            return ast.parse(f'T.exp(T.min({value} * (scale_log2 * 0.6931471805599453), 10.39720770839918))', mode='eval').body
        return node


for natural in (False, True):
    lines = BASE.splitlines(keepends=True)
    edits = []
    for fn in ast.parse(BASE).body:
        if not isinstance(fn, ast.FunctionDef) or fn.name not in TARGETS:
            continue
        start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
        end = fn.end_lineno
        accumulator, constraint = TARGETS[fn.name]
        prim = next(n for n in fn.body if isinstance(n, ast.FunctionDef) and n.name == 'kernel')
        body = prim.body[0].body
        guarded = next(n for n in body if isinstance(n, ast.If) and 'qk.mma(' in ast.unparse(n))
        output_loop = next(n for n in body if isinstance(n, ast.For) and isinstance(n.target, ast.Name) and n.target.id == 'vo')
        pv_guard = next(n for n in output_loop.body if isinstance(n, ast.If))
        assert ast.dump(pv_guard.test) == ast.dump(guarded.test)
        remaining = [n for n in output_loop.body if n is not pv_guard and not
                     (isinstance(n, ast.Expr) and ast.unparse(n.value) == f'T.clear({accumulator})')]
        guarded.body.extend([SetZero().visit(n) for n in pv_guard.body])
        if accumulator == 'acc_o':
            # Its declaration originally followed the first guard; PV now uses
            # the fragment inside that guard, so put the declaration before it.
            vb = next(n for n in body if isinstance(n, ast.Assign)
                      and len(n.targets) == 1 and isinstance(n.targets[0], ast.Name)
                      and n.targets[0].id == 'vb')
            body.remove(vb)
            body.insert(body.index(guarded), vb)
        location = body.index(guarded)
        body.insert(location, ast.parse(f'T.clear({accumulator})').body[0])
        loop_index = body.index(output_loop)
        body[loop_index:loop_index+1] = [SetZero().visit(n) for n in remaining]
        fn.body.insert(fn.body.index(prim), ast.parse(f'assert {constraint}').body[0])
        if natural:
            fn = Natural().visit(fn)
        ast.fix_missing_locations(fn)
        edits.append((start, end, ast.unparse(fn) + '\n'))
    for start, end, text in reversed(edits):
        lines[start:end] = [text]
    source = ''.join(lines)
    ast.parse(source)
    name = f'fused_guard_v2_e{int(natural)}'
    (ROOT / (name + '.py')).write_text(source)
    print(name)
