"""Apply the causal mask only when the selected block contains the query."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE / "parent.py"
TARGETS = {
    "native_sparse_attention_q_preload": ("scores", "block", "token"),
    "native_sparse_attention_direct_kv": ("scores", "block", "token"),
    "native_sparse_attention_linear_v_blocks_oct8": ("acc_s", "_selected_block", "i_t"),
    "_coalesced_block_loads_prim_oct8": ("acc_s", "_selected_block", "i_t"),
}


def exponent(node):
    return any(isinstance(n, ast.Call) and ast.unparse(n.func) in ("T.exp", "T.exp2") for n in ast.walk(node))


class Rewrite(ast.NodeTransformer):
    def __init__(self, acc, token, masked):
        self.acc, self.token, self.masked = acc, token, masked

    def visit_Assign(self, node):
        if len(node.targets) == 1 and isinstance(node.targets[0], ast.Subscript):
            if ast.unparse(node.targets[0].value) == self.acc and exponent(node.value):
                expr = next(n for n in ast.walk(node.value) if isinstance(n, ast.Call) and ast.unparse(n.func) in ("T.exp", "T.exp2"))
                node.value = copy.deepcopy(expr)
                if self.masked:
                    node.value = ast.parse(f"T.if_then_else(j <= {self.token} % BS, {ast.unparse(expr)}, T.float32(0.0))", mode="eval").body
                return node
        return self.generic_visit(node)

    def visit_If(self, node):
        node = self.generic_visit(node)
        if node.orelse and ast.dump(ast.Module(body=node.body, type_ignores=[])) == ast.dump(ast.Module(body=node.orelse, type_ignores=[])):
            return node.body
        return node


def main():
    source = BASE.read_text()
    reports = []
    for mode in ("post", "split"):
        lines = source.splitlines(keepends=True)
        edits = []
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in TARGETS:
                continue
            start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
            end = fn.end_lineno
            acc, block, token = TARGETS[fn.name]
            prim = next(n for n in fn.body if isinstance(n, ast.FunctionDef) and n.name == "kernel")
            valid = next(n for n in prim.body[0].body if isinstance(n, ast.If) and "qk.mma(" in ast.unparse(n))
            # All four selected builders require a complete-block view and
            # validate the raw index before entering this region.
            for i, child in enumerate(valid.body):
                if "T.infinity(" in ast.unparse(child):
                    valid.body[i] = ast.parse(f"T.clear({acc})").body[0]
            old = next(n for n in valid.body if exponent(n))
            unmasked = Rewrite(acc, token, False).visit(copy.deepcopy(old))
            unmasked = unmasked if isinstance(unmasked, list) else [unmasked]
            cond = ast.parse(f"is_causal and {block} == {token} // BS", mode="eval").body
            if mode == "post":
                mask = ast.parse(f"for i, j in T.Parallel(G, BS):\n    {acc}[i, j] = T.if_then_else(j <= {token} % BS, {acc}[i, j], T.float32(0.0))").body
                new = unmasked + [ast.If(test=cond, body=mask, orelse=[])]
            else:
                masked = Rewrite(acc, token, True).visit(copy.deepcopy(old))
                masked = masked if isinstance(masked, list) else [masked]
                new = [ast.If(test=cond, body=masked, orelse=unmasked)]
            i = valid.body.index(old)
            valid.body[i:i+1] = new
            ast.fix_missing_locations(fn)
            edits.append((start, end, ast.unparse(fn) + "\n"))
        for start, end, text in reversed(edits):
            lines[start:end] = [text]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / f"boundary_mask_{mode}.py"
        with path.open("x") as f:
            f.write(result)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(), mode=mode))
        print(path.name)
    (HERE / "boundary_mask_manifest.json").write_text(json.dumps(dict(
        parent=str(BASE), parent_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(), variants=reports,
        assumptions=["Complete blocks", "Raw block index validated", "Causal block <= token // BS"],
        equivalence="For every earlier block all columns are valid; the current block has j <= token % BS",
        safety_and_synchronization_unchanged=True), indent=2) + "\n")


if __name__ == "__main__":
    main()
