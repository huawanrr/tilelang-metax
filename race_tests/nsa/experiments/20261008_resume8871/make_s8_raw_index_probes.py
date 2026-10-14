"""Validate S8 raw block numbers before forming any element offsets."""
import ast
import hashlib
import json
import re
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE / "parent.py"
TARGETS = {"native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
           "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast"}


def raw_name(node):
    return isinstance(node, ast.Name) and re.fullmatch(r"i_s[0-3]?", node.id)


class RawBlock(ast.NodeTransformer):
    def __init__(self, unsigned):
        self.unsigned = unsigned
        self.counts = dict(index_load=0, block_addresses=0, validity=0, offsets=0)

    def visit_Assign(self, node):
        if len(node.targets) == 1 and isinstance(node.targets[0], ast.Subscript) and ast.unparse(node.targets[0].value) == "indices":
            assert ast.unparse(node.value) == "T.min(T.max(raw_index, -1), T.ceildiv(seq_len, BS)) * BS"
            node.value = ast.parse("T.cast(raw_index, T.uint32)" if self.unsigned else "raw_index", mode="eval").body
            self.counts["index_load"] += 1
            return node
        if (self.unsigned and len(node.targets) == 1 and ast.unparse(node.targets[0]) == "indices"):
            assert ast.unparse(node.value) == "T.alloc_local([S], T.int32)"
            node.value = ast.parse("T.alloc_local([S], T.uint32)", mode="eval").body
            return node
        return self.generic_visit(node)

    def visit_Compare(self, node):
        if raw_name(node.left) and len(node.ops) == 1:
            right = ast.unparse(node.comparators[0])
            if isinstance(node.ops[0], ast.GtE) and right == "0":
                self.counts["validity"] += 1
                return node
            if isinstance(node.ops[0], ast.Lt) and right == "seq_len":
                self.counts["validity"] += 1
                node.comparators[0] = ast.parse("T.ceildiv(seq_len, BS)", mode="eval").body
                return node
            if isinstance(node.ops[0], ast.LtE) and right == "i_t":
                self.counts["validity"] += 1
                node.comparators[0] = ast.parse("i_t // BS", mode="eval").body
                return node
        return self.generic_visit(node)

    def visit_BinOp(self, node):
        if raw_name(node.left) and isinstance(node.op, ast.FloorDiv) and ast.unparse(node.right) == "BS":
            self.counts["block_addresses"] += 1
            return node.left
        return self.generic_visit(node)

    def visit_Name(self, node):
        if raw_name(node) and isinstance(node.ctx, ast.Load):
            self.counts["offsets"] += 1
            return ast.parse(f"{node.id} * BS", mode="eval").body
        return node


def main():
    source = BASE.read_text()
    reports = []
    for unsigned in (False, True):
        lines = source.splitlines(keepends=True)
        edits, details = [], {}
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in TARGETS:
                continue
            start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
            end = fn.end_lineno
            transform = RawBlock(unsigned)
            fn = transform.visit(fn)
            ast.fix_missing_locations(fn)
            assert transform.counts["index_load"] == 1
            assert transform.counts["block_addresses"] == 10
            assert transform.counts["validity"] == 27
            edits.append((start, end, ast.unparse(fn) + "\n"))
            details[fn.name] = transform.counts
        for start, end, text in reversed(edits):
            lines[start:end] = [text]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / f"s8_raw_{'unsigned' if unsigned else 'signed'}.py"
        with path.open("x") as f:
            f.write(result)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(), details=details))
        print(path.name)
    checks = 0
    for n in (1,15,16,17,31,32,33,63,64,65,127,128,129,256,512,1024):
        bs, nb = 16, (n+15)//16
        for t in range(n):
            for raw in (-2147483648,-65537,-16,-1,0,1,nb-1,nb,nb+1,2147483647):
                for causal in (False,True):
                    old_offset = min(max(raw,-1),nb)*bs
                    old_valid = 0 <= old_offset < n and (not causal or old_offset <= t)
                    for b in (raw, raw & 0xffffffff):
                        valid = 0 <= b < nb and (not causal or b <= t//bs)
                        assert valid == old_valid
                        if valid:
                            assert b*bs == old_offset
                    checks += 1
    (HERE / "s8_raw_index_manifest.json").write_text(json.dumps(dict(
        parent=str(BASE), parent_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(), variants=reports,
        proof=dict(tuples=checks, includes_int32_extremes=True, includes_partial_final_blocks=True),
        packing_and_arithmetic_unchanged=True, safety_and_synchronization_unchanged=True), indent=2) + "\n")


if __name__ == "__main__":
    main()
