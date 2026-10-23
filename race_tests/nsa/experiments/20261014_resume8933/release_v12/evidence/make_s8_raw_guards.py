"""Use raw unsigned block bounds and defer S8 element masks until after exp.

For a valid query token t, uint32(block) <= t // BS is exactly the causal
block validity condition, including negative and extreme int32 inputs.
The noncausal condition is uint32(block) < ceildiv(T, BS). Multiplication
by BS only occurs inside the resulting valid-block branch.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
NAMES = {
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


def expr(source):
    return ast.parse(source, mode="eval").body


def nodes(source):
    return ast.parse(source).body


def is_start(node):
    return isinstance(node, ast.Name) and re.fullmatch(r"i_s[0-3]?", node.id)


def conjunctions(node):
    if isinstance(node, ast.BoolOp) and isinstance(node.op, ast.And):
        return [part for value in node.values for part in conjunctions(value)]
    return [node]


class RawGuards(ast.NodeTransformer):
    def visit_Assign(self, node):
        if (len(node.targets) == 1 and isinstance(node.targets[0], ast.Subscript)
                and ast.unparse(node.targets[0]).startswith("indices[")):
            assert "raw_index" in ast.unparse(node.value)
            node.value = expr("raw_index")
            return node
        return self.generic_visit(node)

    def visit_BinOp(self, node):
        if is_start(node.left) and isinstance(node.op, ast.FloorDiv) and ast.unparse(node.right) == "BS":
            return copy.deepcopy(node.left)
        return self.generic_visit(node)

    def visit_Name(self, node):
        if isinstance(node.ctx, ast.Load) and is_start(node):
            return expr(f"{node.id} * BS")
        return node

    def visit_If(self, node):
        parts = conjunctions(node.test)
        lower = [p for p in parts if isinstance(p, ast.Compare) and is_start(p.left)
                 and len(p.ops) == 1 and isinstance(p.ops[0], ast.GtE)
                 and ast.unparse(p.comparators[0]) == "0"]
        if not lower:
            return self.generic_visit(node)
        assert len(lower) == 1
        name = lower[0].left.id
        remaining = [p for p in parts if not any(isinstance(n, ast.Name) and n.id == name for n in ast.walk(p))]
        predicate = expr(f'(T.Cast("uint32", {name}) <= T.Cast("uint32", i_t // BS)) if is_causal else '
                         f'(T.Cast("uint32", {name}) < T.uint32((seq_len + BS - 1) // BS))')
        node.test = ast.BoolOp(op=ast.And(), values=remaining + [predicate]) if remaining else predicate
        node.body = [self.visit(n) for n in node.body]
        node.orelse = [self.visit(n) for n in node.orelse]
        return node


class PostMask(ast.NodeTransformer):
    def visit_If(self, node):
        if "scale_log2 > 0" == ast.unparse(node.test):
            # Handled as a sibling of the pre-MMA mask in the parent branch.
            return node
        if not any(isinstance(n, ast.For) and ast.unparse(n.iter) == "T.serial(qk_steps)" for n in node.body):
            return self.generic_visit(node)
        masks = [n for n in node.body if isinstance(n, ast.If) and "acc_s" in ast.unparse(n)
                 and "neg_inf" in ast.unparse(n)]
        exponentials = [n for n in node.body if isinstance(n, ast.If) and ast.unparse(n.test) == "scale_log2 > 0"]
        assert len(masks) == len(exponentials) == 1
        mask, exponential = masks[0], exponentials[0]
        post = copy.deepcopy(mask)
        for branch in (post, post.orelse[0]):
            assert isinstance(branch, ast.If)
            for statement in ast.walk(branch.body[0]):
                if isinstance(statement, ast.Assign):
                    assert len(statement.targets) == 1 and ast.unparse(statement.targets[0]).startswith("acc_s[")
                    assert isinstance(statement.value, ast.Call) and ast.unparse(statement.value.func) == "T.if_then_else"
                    statement.value.args[1:] = [copy.deepcopy(statement.targets[0]), expr("T.float32(0.0)")]
                    statement.value.args[1].ctx = ast.Load()
            if branch is not post:
                branch.orelse = []
        mask_at = node.body.index(mask)
        node.body[mask_at:mask_at + 1] = nodes("T.clear(acc_s)")
        exp_at = node.body.index(exponential)
        node.body[exp_at:exp_at + 1] = copy.deepcopy(exponential.body) + [post]
        return node


def main():
    source = (HERE / "baseline.py").read_text()
    originals = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for raw, post in ((True,False),(False,True),(True,True)):
        result = source
        for name in NAMES:
            fn = copy.deepcopy(originals[name])
            fn.decorator_list = []
            if post:
                fn = PostMask().visit(fn)
            if raw:
                fn = RawGuards().visit(fn)
            result = result.replace(ast.get_source_segment(source, originals[name]),
                                    ast.unparse(ast.fix_missing_locations(fn)), 1)
        ast.parse(result)
        path = HERE / f"s8_raw{int(raw)}_post{int(post)}.py"
        if path.exists():
            assert path.read_text() == result, path
        else:
            with path.open("x") as out:
                out.write(result)
        records.append(dict(path=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            unsigned_raw_bounds=raw, post_exp_mask=post))
    # Exhaustive block neighborhoods plus the original overflow sentinels.
    checked = 0
    for length in (1,15,16,17,31,32,127,128,1024,1025):
        bs = 16
        nb = (length + bs - 1) // bs
        for token in range(length):
            for block in [*range(-2,nb+2),-2147483648,2147483647,-268435456,268435456]:
                for causal in (False,True):
                    original = block >= 0 and block < nb and (not causal or block * bs <= token)
                    reduced = (block & 0xffffffff) <= token // bs if causal else (block & 0xffffffff) < nb
                    assert original == reduced
                    if reduced:
                        assert 0 <= block * bs < length
                    checked += 1
    report = dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
                  raw_guard_proof=dict(status="PASS", configurations=checked),
                  synchronization="unchanged", arithmetic="same products, exp, casts and normalization")
    (HERE / "s8_raw_guards_manifest.json").write_text(json.dumps(report, indent=2) + "\n")
    print("Generated", len(records), "S8 variants; guard checks", checked)


if __name__ == "__main__":
    main()
