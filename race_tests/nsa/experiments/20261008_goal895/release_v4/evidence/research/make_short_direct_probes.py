"""Direct MMA-layout reads for a small concatenated selected-block list."""
import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent
NAME = 'native_sparse_attention_short_list'


class DirectV(ast.NodeTransformer):
    def visit_Dict(self, node):
        for i, key in enumerate(node.keys):
            if isinstance(key, ast.Name) and key.id == 'V_reg':
                node.values[i] = ast.parse("pv.make_mma_load_layout(V_reg, 'B')", mode='eval').body
        return self.generic_visit(node)

    def visit_For(self, node):
        if ast.unparse(node.iter) == 'T.Parallel(BS, BV)' and len(node.body) == 1:
            statement = node.body[0]
            if isinstance(statement, ast.Assign) and isinstance(statement.value, ast.Subscript):
                if ast.unparse(statement.value.value) == 'V_reg':
                    return None
        if ast.unparse(node.iter) == 'T.serial(pv_steps)':
            return ast.parse('''
for ki in T.serial(pv_steps):
    pv.mma(acc_s_cast, V_reg, acc_o, ki)
''').body[0]
        return self.generic_visit(node)


for natural in (False, True):
    parent = 'cast_both_exp' if natural else 'cast_both'
    for direct_v in (False, True):
        source = (ROOT / (parent + '.py')).read_text()
        if direct_v:
            node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == NAME)
            start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
            end = node.end_lineno
            node = DirectV().visit(node)
            ast.fix_missing_locations(node)
            lines = source.splitlines(keepends=True)
            lines[start:end] = [ast.unparse(node) + '\n']
            source = ''.join(lines)
        old = '''            kernel = short_builder(
                selected_blocks=S, late_normalize=False, lane_reduce=True,
                kv_split=False, direct_k=False, **common)'''
        new = '''            kernel = short_builder(
                selected_blocks=S, late_normalize=False, lane_reduce=True,
                kv_split=False, direct_k=True, **common)'''
        assert source.count(old) == 1
        source = source.replace(old, new)
        ast.parse(source)
        name = f'short_direct_e{int(natural)}_v{int(direct_v)}'
        (ROOT / (name + '.py')).write_text(source)
        print(name)
