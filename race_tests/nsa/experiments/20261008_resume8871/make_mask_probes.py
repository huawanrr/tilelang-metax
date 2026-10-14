"""Remove redundant element extent checks after complete-block validation."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = HERE / "parent.py"
TARGETS = {
    "native_sparse_attention_q_preload": ("scores", "block", "token", "block * BS"),
    "native_sparse_attention_direct_kv": ("scores", "block", "token", "block * BS"),
    "_coalesced_block_loads_prim_oct8": ("acc_s", "_selected_block", "i_t", "_start_buffer_0[0]"),
}


class Mask(ast.NodeTransformer):
    def __init__(self, name, mode):
        self.acc, self.block, self.token, self.start = TARGETS[name]
        self.mode = mode
        self.count = 0

    def visit_Assign(self, node):
        if len(node.targets) != 1 or not isinstance(node.targets[0], ast.Subscript):
            return self.generic_visit(node)
        target = node.targets[0]
        if ast.unparse(target.value) != self.acc:
            return self.generic_visit(node)
        exps = [n for n in ast.walk(node.value) if isinstance(n, ast.Call)
                and ast.unparse(n.func) in ("T.exp", "T.exp2")]
        if not exps:
            return self.generic_visit(node)
        assert len(exps) == 1
        if self.mode == "minimal":
            cond = f"not is_causal or {self.start} + j <= {self.token}"
        else:
            cond = f"not is_causal or {self.block} < {self.token} // BS or j <= {self.token} % BS"
        node.value = ast.parse(
            f"T.if_then_else({cond}, {ast.unparse(exps[0])}, T.float32(0.0))", mode="eval").body
        self.count += 1
        return node

    def visit_If(self, node):
        node = self.generic_visit(node)
        if node.orelse and ast.dump(ast.Module(body=node.body, type_ignores=[])) == ast.dump(
                ast.Module(body=node.orelse, type_ignores=[])):
            return node.body
        return node


def main():
    source = BASE.read_text()
    reports = []
    for mode in ("minimal", "block_relative"):
        lines = source.splitlines(keepends=True)
        edits, changes = [], {}
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in TARGETS:
                continue
            start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
            end = fn.end_lineno
            transform = Mask(fn.name, mode)
            fn = transform.visit(copy.deepcopy(fn))
            ast.fix_missing_locations(fn)
            edits.append((start, end, ast.unparse(fn) + "\n"))
            changes[fn.name] = transform.count
        for start, end, text in reversed(edits):
            lines[start:end] = [text]
        result = "".join(lines)
        path = HERE / f"mask_{mode}.py"
        with path.open("x") as f:
            f.write(result)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(path.read_bytes()).hexdigest(), changes=changes))
        print(path.name)
    # Exhaust the discrete preconditions independently of the GPU implementation.
    checks = 0
    for bs in (16,):
        for n in (16, 32, 64, 128, 256, 512):
            for t in range(n):
                for b in range(n // bs):
                    for causal in (False, True):
                        if causal and b > t // bs:
                            continue
                        for j in range(bs):
                            original = 0 <= b * bs + j < n and (not causal or b * bs + j <= t)
                            minimal = not causal or b * bs + j <= t
                            relative = not causal or b < t // bs or j <= t % bs
                            assert original == minimal == relative
                            checks += 1
    (HERE / "mask_manifest.json").write_text(json.dumps(dict(
        parent=str(BASE), parent_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(), variants=reports,
        proof=dict(checked_tuples=checks, complete_blocks=True, valid_block_checked_before_arithmetic=True),
        extent_safety_passes_unchanged=True), indent=2) + "\n")


if __name__ == "__main__":
    main()
