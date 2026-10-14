"""Specialize full, valid S8 lists while retaining the original fallback."""
import ast
import copy
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / 'baseline.py').read_text()
names = ('native_sparse_attention_online_packed_batch_minor_o_v2_mathcast',
         'native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast')


class FullBlock(ast.NodeTransformer):
    def visit_If(self, node):
        condition = ast.unparse(node.test)
        if condition.startswith('prefetch_depth >'):
            return [self.visit(n) for n in node.body]
        if condition.startswith('is_causal and i_s'):
            return ast.parse('T.clear(acc_s)').body[0]
        return self.generic_visit(node)


class SubstituteGroup(ast.NodeTransformer):
    def __init__(self, group):
        self.group = group

    def visit_Name(self, node):
        if node.id == 'group':
            return ast.Constant(self.group)
        if node.id in ('i_s0', 'i_s1', 'i_s2', 'i_s3'):
            return ast.Name(f'full_{node.id}_{self.group}', node.ctx)
        return node

    def visit_Subscript(self, node):
        node = self.generic_visit(node)
        if isinstance(node.value, ast.Name) and node.value.id == 'indices':
            index = ast.unparse(node.slice)
            index = index.replace('prefetch_depth', '4').replace('S', '8').replace('T.min', 'min')
            node.slice = ast.Constant(eval(index, {'__builtins__': {}, 'min': min}))
        return node


additions = []
for node in ast.parse(base).body:
    if not isinstance(node, ast.FunctionDef) or node.name not in names:
        continue
    original_name = node.name
    node = copy.deepcopy(node)
    node.name += '_full_list'
    kernel = next(n for n in node.body if isinstance(n, ast.FunctionDef) and n.name == 'kernel')
    body = kernel.body[0].body
    position = next(i for i, n in enumerate(body) if isinstance(n, ast.If)
                    and ast.unparse(n.test) == 'prefetch_depth == 1')
    original = body[position]
    assert len(original.orelse) == 1 and isinstance(original.orelse[0], ast.For)
    full_group = FullBlock().visit(copy.deepcopy(original.orelse[0]))
    full_body = []
    for group in range(2):
        for statement in full_group.body:
            full_body.append(SubstituteGroup(group).visit(copy.deepcopy(statement)))
    valid = ' and '.join(f'(indices[{i}] >= 0 and indices[{i}] + BS <= seq_len and (not is_causal or indices[{i}] + BS <= i_t + 1))' for i in range(8))
    body[position] = ast.If(test=ast.parse(valid, mode='eval').body,
                           body=full_body, orelse=[original])
    node.body.insert(1, ast.parse('assert selected_blocks == 8 and prefetch_depth == 4').body[0])
    ast.fix_missing_locations(node)
    additions.append(ast.unparse(node))
    old = 'if mathcast_s8:\n                    online_builder = ' + original_name + '\n'
    new = 'if mathcast_s8:\n                    online_builder = ' + node.name + '\n'
    assert base.count(old) == 1, (original_name, base.count(old))
    base = base.replace(old, new, 1)

assert len(additions) == 2
base = base.replace('def _get_kernel(', '\n\n'.join(additions) + '\n\ndef _get_kernel(', 1)
ast.parse(base)
target = HERE / 's8_full_list.py'
assert not target.exists()
target.write_text(base)
print(target)
