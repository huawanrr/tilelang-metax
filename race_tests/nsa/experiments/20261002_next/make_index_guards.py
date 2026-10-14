"""Validate a block index before multiplying it into an element address."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / 'experiments/20261002_final/nsa.py'
OLD_TEST = ast.dump(ast.parse(
    'i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t)', mode='eval').body)
NEW_TEST = ast.parse('''_selected_block >= 0 and _selected_block < (seq_len + BS - 1) // BS
    and (not is_causal or _selected_block <= i_t // BS)'''.replace('\n', ' '), mode='eval').body


def start_loads(node):
    return {id(n) for n in ast.walk(node)
            if isinstance(n, ast.Name) and n.id == 'i_s' and isinstance(n.ctx, ast.Load)}


class RenameStart(ast.NodeTransformer):
    def __init__(self, name):
        self.name = name

    def visit_Name(self, node):
        if node.id == 'i_s':
            return ast.copy_location(ast.Name(id=self.name, ctx=node.ctx), node)
        return node


def rewrite(function, only_single_branch):
    if function.name == 'native_sparse_attention_online':
        return False
    conditions = [n for n in ast.walk(function) if isinstance(n, ast.If) and ast.dump(n.test) == OLD_TEST]
    assignments = [n for n in ast.walk(function) if isinstance(n, ast.Assign)
        and len(n.targets) == 1 and isinstance(n.targets[0], ast.Name) and n.targets[0].id == 'i_s'
        and isinstance(n.value, ast.BinOp) and isinstance(n.value.op, ast.Mult)
        and isinstance(n.value.right, ast.Name) and n.value.right.id == 'BS'
        and isinstance(n.value.left, ast.Subscript) and isinstance(n.value.left.value, ast.Name)
        and n.value.left.value.id == 'BlockIndices']
    if not conditions or len(assignments) != 1 or (only_single_branch and len(conditions) != 1):
        return False
    # All original address uses must already be inside a validated branch.
    # Separate epilogue guards are allowed, but no guard may contain another.
    assert start_loads(function) == set().union(*(start_loads(n) for n in conditions)), function.name
    assert all(not any(other is node for other in conditions if other is not condition)
               for condition in conditions for stmt in condition.body for node in ast.walk(stmt)), function.name
    assert not any(isinstance(n, ast.Name) and n.id.startswith('_selected_') for n in ast.walk(function))
    assignment = assignments[0]
    assignment.targets[0].id = '_selected_block'
    assignment.value = assignment.value.left
    for i, condition in enumerate(conditions):
        condition.test = copy.deepcopy(NEW_TEST)
        if any(start_loads(stmt) for stmt in condition.body):
            name = f'_selected_start_{i}'
            condition.body = [RenameStart(name).visit(stmt) for stmt in condition.body]
            product = ast.parse(f'{name} = _selected_block * BS').body[0]
            condition.body.insert(0, product)
    assert not start_loads(function), function.name
    return True


def main():
    report = dict(baseline=str(BASE.relative_to(ROOT)), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(), variants=[])
    for label, single in [('simple', True), ('all', False)]:
        output = HERE / f'index_guards_{label}.py'
        assert not output.exists(), output
        module = ast.parse(BASE.read_text())
        changed = [n.name for n in module.body if isinstance(n, ast.FunctionDef) and rewrite(n, single)]
        assert changed
        ast.fix_missing_locations(module)
        source = ast.unparse(module) + '\n'
        ast.parse(source)
        output.write_text(source)
        report['variants'].append(dict(path=str(output.relative_to(ROOT)), changed_functions=changed,
            source_sha256=hashlib.sha256(source.encode()).hexdigest()))
        print(label, len(changed), changed)
    (HERE / 'index_guards_assembly.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
