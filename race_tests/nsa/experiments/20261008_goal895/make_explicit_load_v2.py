"""Inline vector extraction so the integer analyzer sees no Shuffle binding."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent


class InlineBits(ast.NodeTransformer):
    def visit_Assign(self, node):
        if len(node.targets) == 1 and isinstance(node.targets[0], ast.Name):
            if node.targets[0].id in ('k_bits', 'v_bits'):
                return None
        return self.generic_visit(node)

    def visit_Name(self, node):
        if node.id in ('k_bits', 'v_bits'):
            prefix = node.id[0]
            return ast.parse(f'T.Shuffle([{prefix}_values], [{prefix}_pair])', mode='eval').body
        return node


for width in (64, 128):
    source = HERE / f'wide_load_explicit{width}.py'
    destination = HERE / f'wide_load_explicit{width}_v2.py'
    assert not destination.exists(), destination
    tree = ast.fix_missing_locations(InlineBits().visit(ast.parse(source.read_text())))
    destination.write_text(ast.unparse(tree) + '\n')
    print(destination)
