"""Probe equivalent softmax expressions on the verified v5b implementation."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE / "parent.py"
TARGETS = {
    "native_sparse_attention_q_preload",
    "native_sparse_attention_direct_kv",
    "native_sparse_attention_linear_v_blocks_oct8",
    "_coalesced_block_loads_prim_oct8",
    "_coalesced_block_loads_prim_mathcast",
    "native_sparse_attention_short_list_oct8",
    "native_sparse_attention_staged_sparse_blocks",
    "native_sparse_attention_single_packed_qo_v2_mathcast",
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


class Rewrite(ast.NodeTransformer):
    def __init__(self, mode):
        self.mode = mode
        self.counts = {"reciprocal": 0, "postclip": 0}

    def visit_Call(self, node):
        # Guarding the denominator returns 1 for a zero sum. In that case
        # every nonnegative probability and the PV numerator are also zero.
        name = ast.unparse(node.func)
        if name == "T.if_then_else" and len(node.args) == 3:
            cond, yes, no = node.args
            if (isinstance(yes, ast.BinOp) and isinstance(yes.op, ast.Div)
                    and isinstance(yes.left, ast.Constant) and yes.left.value == 1.0
                    and isinstance(no, ast.Constant) and no.value == 0.0
                    and isinstance(cond, ast.Compare) and len(cond.ops) == 1
                    and isinstance(cond.ops[0], ast.Gt)
                    and ast.dump(cond.left) == ast.dump(yes.right)):
                d = ast.unparse(yes.right)
                if self.mode in ("safe_denom", "safe_postclip"):
                    self.counts["reciprocal"] += 1
                    return ast.parse(f"1.0 / T.if_then_else({d} > 0, {d}, T.float32(1.0))", mode="eval").body
                if self.mode == "ieee_recip":
                    self.counts["reciprocal"] += 1
                    node.args[1] = ast.parse(f"T.ieee_frcp({d})", mode="eval").body
                    return node
        node = self.generic_visit(node)
        if self.mode in ("postclip", "safe_postclip") and name in ("T.exp", "T.exp2"):
            v = node.args[0]
            if isinstance(v, ast.Call) and ast.unparse(v.func) == "T.min":
                arg, cap = v.args
                self.counts["postclip"] += 1
                return ast.parse(
                    f"T.min({name}({ast.unparse(arg)}), {name}(T.float32({ast.unparse(cap)})))",
                    mode="eval").body
        return node


def main():
    source = BASE.read_text()
    reports = []
    for mode in ("safe_denom", "ieee_recip", "postclip", "safe_postclip"):
        lines = source.splitlines(keepends=True)
        edits, changes = [], {}
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in TARGETS:
                continue
            start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
            end = fn.end_lineno
            transform = Rewrite(mode)
            fn = transform.visit(fn)
            ast.fix_missing_locations(fn)
            edits.append((start, end, ast.unparse(fn) + "\n"))
            changes[fn.name] = transform.counts
        for start, end, text in reversed(edits):
            lines[start:end] = [text]
        text = "".join(lines)
        ast.parse(text)
        path = HERE / f"math_{mode}.py"
        with path.open("x") as f:
            f.write(text)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(), changes=changes))
        print(path.name)
    (HERE / "math_probes_manifest.json").write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=reports, status="Research; independently validate before adoption."), indent=2) + "\n")


if __name__ == "__main__":
    main()
