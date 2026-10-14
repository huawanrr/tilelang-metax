"""Isolate private-array spills after proving that selected blocks are in range."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
TARGETS = {'native_sparse_attention_shared_q_reuse', '_coalesced_qo_prim'}


class ReplaceCoordinates(ast.NodeTransformer):
    def __init__(self, replacements):
        self.replacements = replacements

    def visit_Name(self, node):
        if isinstance(node.ctx, ast.Load) and node.id in self.replacements:
            return copy.deepcopy(self.replacements[node.id])
        return node


def expand(stmt, row_name, col_name, cols):
    output = []
    for slot in range(8):
        element = f'_stage_element_{slot}'
        linear = f'({slot * 512} + T.get_thread_binding() * 8 + {element})'
        replacements = {
            row_name: ast.parse(f'{linear} // {cols}', mode='eval').body,
            col_name: ast.parse(f'{linear} % {cols}', mode='eval').body,
        }
        wrapped = ast.parse(f'''if BS * {cols} > {slot * 512}:
    for {element} in T.vectorized(8):
        pass
''').body[0]
        wrapped.body[0].body = [ReplaceCoordinates(replacements).visit(copy.deepcopy(stmt))]
        output.append(wrapped)
    return output


class Staging(ast.NodeTransformer):
    def __init__(self, loads, stores):
        self.loads, self.stores = loads, stores
        self.active = False
        self.rewrites = []

    def visit_FunctionDef(self, node):
        previous = self.active
        self.active = self.active or node.name in TARGETS
        if self.active:
            node = self.generic_visit(node)
        self.active = previous
        return node

    def visit_Assign(self, node):
        if (self.active and any(isinstance(t, ast.Name) and t.id == '_layout' for t in node.targets)
                and isinstance(node.value, ast.Dict)):
            keys = {k.id for k in node.value.keys if isinstance(k, ast.Name)}
            for name, dim in [('K_reg', 'BK'), ('V_reg', 'BV')]:
                if name not in keys:
                    node.value.keys.append(ast.Name(id=name, ctx=ast.Load()))
                    node.value.values.append(ast.parse(f'''T.Fragment([BS, {dim}],
                        forward_thread_fn=lambda _sr, _sc: (_sr * {dim} + _sc) // 8 % 64,
                        forward_index_fn=lambda _sr, _sc: (_sr * {dim} + _sc) // 512 * 8 + _sc % 8)''', mode='eval').body)
        return self.generic_visit(node)

    def visit_Expr(self, node):
        call = node.value
        if not (self.active and isinstance(call, ast.Call) and isinstance(call.func, ast.Attribute)
                and isinstance(call.func.value, ast.Name) and call.func.value.id == 'T'
                and call.func.attr == 'copy' and len(call.args) >= 2):
            return self.generic_visit(node)
        source, target = call.args[:2]
        if (self.loads and isinstance(source, ast.Subscript) and isinstance(source.value, ast.Name)
                and source.value.id in ('K', 'V') and isinstance(target, ast.Name)
                and target.id in ('K_reg', 'V_reg')):
            tensor = source.value.id
            dim = 'BK' if tensor == 'K' else 'BV'
            assert isinstance(source.slice, ast.Tuple) and len(source.slice.elts) == 4
            batch, rows, head, columns = source.slice.elts
            assert isinstance(rows, ast.Slice) and isinstance(columns, ast.Slice)
            start = ast.unparse(rows.lower)
            col_start = ast.unparse(columns.lower) if columns.lower else '0'
            statement = ast.parse(f'''{target.id}[_stage_row, _stage_col] = T.if_then_else(
                {start} + _stage_row < seq_len,
                {tensor}[{ast.unparse(batch)}, {start} + _stage_row,
                         {ast.unparse(head)}, {col_start} + _stage_col], T.float16(0))''').body[0]
            self.rewrites.append('load ' + tensor)
            return expand(statement, '_stage_row', '_stage_col', dim)
        if (self.stores and isinstance(source, ast.Name) and source.id in ('K_reg', 'V_reg')
                and isinstance(target, ast.Name) and target.id in ('KV_shared', 'V_shared')):
            dim = 'BK' if source.id == 'K_reg' else 'BV'
            statement = ast.parse(f'{target.id}[_stage_row, _stage_col] = {source.id}[_stage_row, _stage_col]').body[0]
            self.rewrites.append('store ' + source.id)
            return expand(statement, '_stage_row', '_stage_col', dim)
        return self.generic_visit(node)

    def visit_For(self, node):
        if (self.active and self.stores and isinstance(node.iter, ast.Call)
                and isinstance(node.iter.func, ast.Attribute) and node.iter.func.attr == 'Parallel'
                and isinstance(node.target, ast.Tuple) and len(node.target.elts) == 2
                and len(node.body) == 1 and isinstance(node.body[0], ast.Assign)):
            assignment = node.body[0]
            if (isinstance(assignment.value, ast.Subscript) and isinstance(assignment.value.value, ast.Name)
                    and assignment.value.value.id in ('K_reg', 'V_reg')
                    and isinstance(assignment.targets[0], ast.Subscript)
                    and isinstance(assignment.targets[0].value, ast.Name)
                    and assignment.targets[0].value.id == 'KV_shared'):
                dim = 'BK' if assignment.value.value.id == 'K_reg' else 'BV'
                self.rewrites.append('parallel store ' + assignment.value.value.id)
                return expand(assignment, node.target.elts[0].id, node.target.elts[1].id, dim)
        return self.generic_visit(node)


def main():
    original = (HERE / 'index_guards_all.py').read_text()
    report = dict(source='index_guards_all.py', variants=[])
    for label, loads, stores in [('loads', True, False), ('stores', False, True), ('both', True, True)]:
        path = HERE / f'guard_staging_{label}.py'
        assert not path.exists(), path
        transformer = Staging(loads, stores)
        tree = transformer.visit(ast.parse(original))
        assert transformer.rewrites
        ast.fix_missing_locations(tree)
        source = ast.unparse(tree) + '\n'
        ast.parse(source)
        path.write_text(source)
        report['variants'].append(dict(path=path.name, edits=transformer.rewrites,
                                       sha256=hashlib.sha256(source.encode()).hexdigest()))
        print(path.name, transformer.rewrites)
    (HERE / 'guard_staging_assembly.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
