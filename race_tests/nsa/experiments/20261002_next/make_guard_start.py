"""Probe whether retaining a validated start value avoids private-memory growth."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
TARGETS = {'native_sparse_attention_shared_q_reuse', '_coalesced_qo_prim'}


class StartValue(ast.NodeTransformer):
    def __init__(self, names, local, shuffle):
        self.names, self.local, self.shuffle = names, local, shuffle

    def visit_Name(self, node):
        if self.local and node.id in self.names:
            return ast.copy_location(ast.Subscript(
                value=ast.Name(id=self.names[node.id], ctx=ast.Load()),
                slice=ast.Constant(0), ctx=node.ctx), node)
        return node

    def visit_Assign(self, node):
        if (len(node.targets) == 1 and isinstance(node.targets[0], ast.Name)
                and node.targets[0].id in self.names and self.shuffle):
            node.value = ast.Call(func=ast.Attribute(value=ast.Name(id='T', ctx=ast.Load()),
                attr='shfl_sync', ctx=ast.Load()), args=[node.value, ast.Constant(0),
                ast.Constant(64), ast.Constant(0xffffffffffffffff)], keywords=[])
        return self.generic_visit(node)


def main():
    base_path = HERE / 'index_guards_all.py'
    base = base_path.read_text()
    report = dict(baseline=str(base_path), baseline_sha256=hashlib.sha256(base_path.read_bytes()).hexdigest(),
                  variants=[], hypothesis='Source-level validated start values may change array lowering; no backend or compiler-flag changes.')
    for label, local, shuffle in [('local', True, False), ('shuffle', False, True),
                                  ('local_shuffle', True, True)]:
        module = ast.parse(base)
        changed = []
        for function in module.body:
            if not isinstance(function, ast.FunctionDef) or function.name not in TARGETS:
                continue
            names = {n.targets[0].id for n in ast.walk(function) if isinstance(n, ast.Assign)
                and len(n.targets) == 1 and isinstance(n.targets[0], ast.Name)
                and n.targets[0].id.startswith('_selected_start_')}
            assert names, function.name
            replacements = {name: name.replace('_selected_start_', '_start_buffer_') for name in names}
            StartValue(replacements, local, shuffle).visit(function)
            if local:
                kernels = [n for n in ast.walk(function) if isinstance(n, ast.With)
                    and any(isinstance(item.context_expr, ast.Call)
                        and isinstance(item.context_expr.func, ast.Attribute)
                        and item.context_expr.func.attr == 'Kernel' for item in n.items)]
                assert len(kernels) == 1, function.name
                allocations = [ast.parse(f'{name} = T.alloc_local([1], T.int32)').body[0]
                               for name in sorted(replacements.values())]
                kernels[0].body[:0] = allocations
            changed.append(function.name)
        assert set(changed) == TARGETS
        ast.fix_missing_locations(module)
        source = ast.unparse(module) + '\n'
        path = HERE / f'guard_start_{label}.py'
        assert not path.exists()
        path.write_text(source)
        report['variants'].append(dict(path=str(path), changed_functions=changed,
                                      sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
        print(path.name)
    (HERE / 'guard_start_assembly.json').write_text(json.dumps(report, indent=2)+'\n')


if __name__ == '__main__':
    main()
