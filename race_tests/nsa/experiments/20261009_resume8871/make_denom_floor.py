"""A finite denominator floor for products that consume raw FP16 weights.

An active half weight requires the pre-cast value to be at least 2^-25.
If the entire FP32 sum is smaller, every half weight and the finite-input
PV numerator are zero, so flooring the denominator preserves the output.
For a denominator formed by an MMA of half weights, the floor is 2^-24.
This does not apply to paths that normalize before converting weights.
"""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


class Floor(ast.NodeTransformer):
    def __init__(self, minimum):
        self.minimum = minimum
        self.count = 0

    def visit_Call(self, node):
        node = self.generic_visit(node)
        if ast.unparse(node.func) != "T.if_then_else" or len(node.args) != 3:
            return node
        cond, yes, no = node.args
        if (isinstance(cond, ast.Compare) and len(cond.ops) == 1 and isinstance(cond.ops[0], ast.Gt)
            and isinstance(yes, ast.BinOp) and isinstance(yes.op, ast.Div)
            and isinstance(yes.left, ast.Constant) and yes.left.value == 1.0
            and isinstance(no, ast.Constant) and no.value == 0.0
            and ast.dump(cond.left) == ast.dump(yes.right)):
            self.count += 1
            return ast.parse(f"1.0 / T.max({ast.unparse(yes.right)}, T.float32({self.minimum!r}))", mode="eval").body
        return node


def rewrite(path, mode, target):
    source = path.read_text()
    lines = source.splitlines(keepends=True)
    edits = []
    changes = {}
    for fn in ast.parse(source).body:
        if not isinstance(fn, ast.FunctionDef):
            continue
        transform = Floor(2.0 ** (-25 if mode == "raw" else -24))
        if mode == "raw":
            if fn.name in ("native_sparse_attention_online_packed_batch_minor_o_v2_mathcast", "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast"):
                transform.visit(fn)
            elif fn.name in ("native_sparse_attention_q_preload", "native_sparse_attention_direct_kv"):
                for node in ast.walk(fn):
                    if isinstance(node, ast.If) and ast.unparse(node.test) == "late":
                        transform.visit(node)
            else:
                continue
        else:
            # Only transformed tensor-denominator paths contain this buffer.
            if not any(isinstance(n, ast.Name) and n.id in ("den", "acc_den") for n in ast.walk(fn)):
                continue
            if fn.name not in ("native_sparse_attention_q_preload", "native_sparse_attention_direct_kv",
                               "_coalesced_block_loads_prim_oct8", "native_sparse_attention_single_packed_qo_v2_mathcast",
                               "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast", "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast"):
                continue
            transform.visit(fn)
        if transform.count:
            start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
            end = fn.end_lineno
            ast.fix_missing_locations(fn)
            edits.append((start, end, ast.unparse(fn) + "\n"))
            changes[fn.name] = transform.count
    assert changes
    for start, end, text in reversed(edits):
        lines[start:end] = [text]
    result = "".join(lines)
    ast.parse(result)
    with target.open("x") as handle:
        handle.write(result)
    return dict(base=str(path), base_sha256=hashlib.sha256(source.encode()).hexdigest(),
                path=str(target), sha256=hashlib.sha256(result.encode()).hexdigest(), changes=changes, mode=mode)


def main():
    records = []
    records.append(rewrite(HERE.parent / "20261008_resume8871/candidate_v6.py", "raw", HERE / "raw_denom_floor.py"))
    for prefix in ("tensor_denom", "packed_tensor_denom"):
        records.append(rewrite(HERE / f"{prefix}_before.py", "tensor", HERE / f"{prefix}_floor.py"))
    (HERE / "denom_floor_manifest.json").write_text(json.dumps(dict(variants=records,
        proof="If raw FP32 sum < 2^-25, all rounded half weights are zero. Positive sums of rounded half weights are >= 2^-24.",
        limitations="Proof assumes finite V and inherits the parent's exponential clipping and numerical contract. Independently verify floating point behavior before use.",
        status="research only"), indent=2) + "\n")


if __name__ == "__main__":
    main()
