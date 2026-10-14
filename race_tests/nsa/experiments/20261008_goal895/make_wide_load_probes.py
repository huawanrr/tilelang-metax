"""Compare complete-block load widths using the same fragment ownership."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / 'candidate_v4.py').read_text()
targets = {'_coalesced_block_loads_prim_mathcast', '_coalesced_block_loads_prim_oct8'}


class Loads(ast.NodeTransformer):
    def __init__(self, width, explicit):
        self.width, self.explicit = width, explicit
        self.count = 0

    def visit_For(self, node):
        name = ast.unparse(node.target)
        if name not in ('k_slot', 'v_slot'):
            return self.generic_visit(node)
        prefix = name[0]
        cap = prefix.upper()
        dim = 'BK' if prefix == 'k' else 'BV'
        row = f'({prefix}_slot * 512 + tid * 8) // {dim}'
        col = f'tid % ({dim} // 8) * 8 + {prefix}_word * {self.width}'
        address = f'{cap}_blocks[i_b, _selected_block, {row}, i_h, {col}]'
        if self.explicit:
            statements = f'''
for {prefix}_slot in T.unroll(BS * {dim} // 512):
    for {prefix}_word in T.unroll({8 // self.width}):
        {prefix}_values = T.ldg{16 * self.width}({address})
        for {prefix}_pair in T.unroll({self.width // 2}):
            {prefix}_bits = T.Shuffle([{prefix}_values], [{prefix}_pair])
            for {prefix}_element in T.unroll(2):
                {cap}_reg[{row}, {col} + {prefix}_pair * 2 + {prefix}_element] = T.reinterpret(T.float16, T.uint16({prefix}_bits >> ({prefix}_element * 16)))
'''
        else:
            statements = f'''
for {prefix}_slot in T.unroll(BS * {dim} // 512):
    for {prefix}_word in T.unroll({8 // self.width}):
        for {prefix}_element in T.vectorized({self.width}):
            {cap}_reg[{row}, {col} + {prefix}_element] = {cap}_blocks[i_b, _selected_block, {row}, i_h, {col} + {prefix}_element]
'''
        self.count += 1
        return ast.parse(statements).body[0]


for width, explicit in ((4, False), (8, False), (4, True), (8, True)):
    edits = []
    for node in ast.parse(base).body:
        if not isinstance(node, ast.FunctionDef) or node.name not in targets:
            continue
        transform = Loads(width, explicit)
        start = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
        end = node.end_lineno
        node = transform.visit(node)
        assert transform.count == 2
        ast.fix_missing_locations(node)
        edits.append((start, end, ast.unparse(node) + '\n'))
    lines = base.splitlines(keepends=True)
    for start, end, source in reversed(edits):
        lines[start:end] = [source]
    result = ''.join(lines)
    ast.parse(result)
    name = f'wide_load_{"explicit" if explicit else "vector"}{16 * width}.py'
    output = HERE / name
    assert not output.exists(), output
    output.write_text(result)
    print(name)
