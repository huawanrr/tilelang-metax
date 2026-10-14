"""Expand vector extraction indices before TileLang's codegen pass."""
import ast
import copy
from pathlib import Path

HERE = Path(__file__).resolve().parent


class Substitute(ast.NodeTransformer):
    def __init__(self, name, value):
        self.name, self.value = name, value

    def visit_Name(self, node):
        return ast.Constant(self.value) if node.id == self.name else node


class ExpandPairs(ast.NodeTransformer):
    def visit_For(self, node):
        if isinstance(node.target, ast.Name) and node.target.id in ('k_pair', 'v_pair'):
            assert ast.unparse(node.iter.func) == 'T.unroll'
            assert isinstance(node.iter.args[0], ast.Constant)
            return [Substitute(node.target.id, index).visit(copy.deepcopy(statement))
                    for index in range(node.iter.args[0].value) for statement in node.body]
        return self.generic_visit(node)


for width in (64, 128):
    source = HERE / f'wide_load_explicit{width}_v2.py'
    destination = HERE / f'wide_load_explicit{width}_v3.py'
    assert not destination.exists(), destination
    tree = ast.fix_missing_locations(ExpandPairs().visit(ast.parse(source.read_text())))
    destination.write_text(ast.unparse(tree) + '\n')
    print(destination)
