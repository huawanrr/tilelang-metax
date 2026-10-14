"""Use an in-range K/V address and select zero for invalid sparse rows."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE / "parent.py"
TARGETS = {"native_sparse_attention_q_preload", "native_sparse_attention_direct_kv"}


class OutputMask(ast.NodeTransformer):
    def visit_Assign(self, node):
        if len(node.targets) == 1 and isinstance(node.targets[0], ast.Subscript):
            target = node.targets[0]
            if ast.unparse(target.value) == "result":
                node.value = ast.parse(f"T.if_then_else(row_valid, {ast.unparse(node.value)}, T.float32(0.0))", mode="eval").body
                return node
        return self.generic_visit(node)


def main():
    source = BASE.read_text()
    records = []
    for mode, q_fence in (("select", True), ("select", False), ("modulo", False)):
        lines = source.splitlines(keepends=True)
        edits = []
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in TARGETS:
                continue
            start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
            end = fn.end_lineno
            prim = next(n for n in fn.body if isinstance(n, ast.FunctionDef) and n.name == "kernel")
            body = prim.body[0].body
            guarded = next(n for n in body if isinstance(n, ast.If) and "qk.mma(" in ast.unparse(n))
            load_index = next(n for n in body if isinstance(n, ast.Assign) and ast.unparse(n.targets[0]) == "block")
            index = body.index(load_index)
            valid = ast.unparse(guarded.test).replace("block", "raw_block")
            address = "T.if_then_else(row_valid, raw_block, 0)" if mode == "select" else "raw_block % NB"
            body[index:index+1] = ast.parse(
                f"raw_block = {ast.unparse(load_index.value)}\nrow_valid = {valid}\nblock = {address}").body
            guard_index = body.index(guarded)
            body[guard_index:guard_index+1] = guarded.body
            if not q_fence:
                body[:] = [n for n in body if not (isinstance(n, ast.Expr) and ast.unparse(n.value) == "T.sync_warp()")]
            fn = OutputMask().visit(fn)
            ast.fix_missing_locations(fn)
            edits.append((start, end, ast.unparse(fn) + "\n"))
        for start, end, text in reversed(edits):
            lines[start:end] = [text]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / f"branchless_{mode}_qf{int(q_fence)}.py"
        with path.open("x") as f:
            f.write(result)
        records.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                            address_mode=mode, q_fence=q_fence))
        print(path.name)
    # Index proof includes extremes before any device-side multiplication.
    count = 0
    for nb in (1,2,3,4,5,8,16,32,64,128,256):
        n = nb * 16
        for token in range(n):
            for raw in (-2147483648,-65537,-17,-1,0,1,nb-1,nb,nb+1,2147483647):
                for causal in (False,True):
                    valid = raw >= 0 and raw < nb and (not causal or raw <= token // 16)
                    addresses = (raw if valid else 0, raw % nb)
                    assert all(0 <= a < nb for a in addresses)
                    if valid:
                        assert all(a == raw for a in addresses)
                    count += 1
    (HERE / "branchless_manifest.json").write_text(json.dumps(dict(
        parent=str(BASE), parent_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records, proof=dict(tuples=count, addresses_in_range=True, valid_rows_unchanged=True),
        invalid_output="Select float32 zero before output cast", safety_passes_unchanged=True), indent=2) + "\n")


if __name__ == "__main__":
    main()
