"""Test uint32 storage on the already selected coalesced block-read paths."""
import ast
import hashlib
import json
from pathlib import Path

from prepare import function, once, write_new

HERE = Path(__file__).resolve().parent
BASE = HERE / "reference_blocks_v2.py"


class WordStorage(ast.NodeTransformer):
    def visit_Assign(self, node):
        if len(node.targets) == 1 and isinstance(node.targets[0], ast.Name):
            name = node.targets[0].id
            if name in ("K_blocks", "V_blocks"):
                operand = name[0]
                return ast.parse(f"{name} = T.view({operand}, [batch, seq_len // BS, BS, head_kv, dim // 2], dtype=T.uint32)").body[0]
            if name in ("K_reg", "V_reg"):
                operand = name[0]
                cols = "BK" if operand == "K" else "BV"
                return ast.parse(f'''{operand}_words = T.alloc_local([BS * {cols} // 128], T.uint32)
{operand}_reg = T.Tensor([BS * {cols} // 64], T.float16, data={operand}_words.data, scope="local")''').body
            if name == "_layout":
                kept = [(key, value) for key, value in zip(node.value.keys, node.value.values)
                        if not (isinstance(key, ast.Name) and key.id in ("K_reg", "V_reg"))]
                node.value.keys = [key for key, _ in kept]
                node.value.values = [value for _, value in kept]
        return self.generic_visit(node)

    def visit_If(self, node):
        if isinstance(node.test, ast.Name) and node.test.id == "direct_k":
            if any(isinstance(target, ast.Subscript) and isinstance(target.value, ast.Name)
                   and target.value.id == "_layout"
                   for statement in node.body if isinstance(statement, ast.Assign)
                   for target in statement.targets):
                return None
        return self.generic_visit(node)

    def visit_For(self, node):
        if isinstance(node.target, ast.Name) and node.target.id in ("k_slot", "v_slot"):
            prefix = node.target.id[0]
            operand, cols = prefix.upper(), "BK" if prefix == "k" else "BV"
            return ast.parse(f'''for {prefix}_slot in T.unroll(BS * {cols} // 512):
    for {prefix}_group in T.unroll(2):
        for {prefix}_word in T.vectorized(2):
            {operand}_words[{prefix}_slot * 4 + {prefix}_group * 2 + {prefix}_word] = {operand}_blocks[i_b, _selected_block, ({prefix}_slot * 512 + tid * 8) // {cols}, i_h, tid % ({cols} // 8) * 4 + {prefix}_group * 2 + {prefix}_word]
''').body[0]
        if isinstance(node.target, ast.Tuple) and [n.id for n in node.target.elts] == ["j", "d"]:
            stores = [n for n in node.body if isinstance(n, ast.Assign) and isinstance(n.value, ast.Subscript)
                      and isinstance(n.value.value, ast.Name) and n.value.value.id in ("K_reg", "V_reg")]
            if stores:
                assert len(stores) == 1
                if stores[0].value.value.id == "K_reg":
                    return ast.parse('''for k_slot in T.unroll(BS * BK // 512):
    for k_element in T.vectorized(8):
        KV_shared[((k_slot * 512 + tid * 8) // BK) * BK + (((tid % (BK // 8) * 8 + k_element) // 8) ^ ((((k_slot * 512 + tid * 8) // BK) // KPHASE) % KMAX)) * 8 + (tid % (BK // 8) * 8 + k_element) % 8] = K_reg[k_slot * 8 + k_element]
''').body[0]
                return ast.parse('''for v_slot in T.unroll(BS * BV // 512):
    for v_element in T.vectorized(8):
        KV_shared[v_slot * 512 + tid * 8 + v_element] = V_reg[v_slot * 8 + v_element]
''').body[0]
        return self.generic_visit(node)


def main():
    source = BASE.read_text()
    original = function(source, "_coalesced_block_loads_prim")
    node = WordStorage().visit(ast.parse(original).body[0])
    node.body[0] = ast.parse('''"""Experimental native uint32 K/V storage; identical fp16 bits and shared layout."""''').body[0]
    ast.fix_missing_locations(node)
    part = ast.unparse(node)
    result = once(source, original, part)
    ast.parse(result)
    path = HERE / "coalesced_words2.py"
    write_new(path, result)
    write_new(HERE / "coalesced_words_assembly.json", json.dumps(dict(
        baseline=BASE.name, baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        source=path.name, source_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
        modified_function="_coalesced_block_loads_prim", dispatch_unchanged=True,
        hypothesis="The uint32 view uses two-word loads and preserves seven barriers; test whether lower register count helps existing coalesced paths"), indent=2) + "\n")
    print(path.name)


if __name__ == "__main__":
    main()
