"""Generate isolated synchronous load and mask scheduling probes from frozen v7."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
TARGETS = {
    "_coalesced_block_loads_prim_oct8",
    "_coalesced_block_loads_prim_mathcast",
    "_coalesced_block_loads_prim_fp32_sum",
    "_coalesced_block_loads_prim_fp32_mask",
}


class VectorWidth(ast.NodeTransformer):
    def __init__(self, width):
        self.width = width
        self.changed = 0

    def visit_For(self, node):
        if isinstance(node.target, ast.Name) and node.target.id in ("k_pair", "v_pair"):
            pair = node.target.id
            assert ast.unparse(node.iter) == "T.unroll(4)"
            assert len(node.body) == 1 and isinstance(node.body[0], ast.For)
            inner = node.body[0]
            assert ast.unparse(inner.iter) == "T.vectorized(2)"
            node.iter.args[0] = ast.Constant(8 // self.width)
            inner.iter.args[0] = ast.Constant(self.width)
            for item in ast.walk(inner):
                if (isinstance(item, ast.BinOp) and isinstance(item.op, ast.Mult)
                        and isinstance(item.left, ast.Name) and item.left.id == pair):
                    assert isinstance(item.right, ast.Constant) and item.right.value == 2
                    item.right = ast.Constant(self.width)
            self.changed += 1
        return self.generic_visit(node)


def boundary_init(function):
    prim = next(n for n in function.body if isinstance(n, ast.FunctionDef) and n.name == "kernel")
    valid = next(n for n in prim.body[0].body
                 if isinstance(n, ast.If) and "qk.mma(" in ast.unparse(n))
    clear = next(i for i, n in enumerate(valid.body) if ast.unparse(n) == "T.clear(acc_s)")
    valid.body[clear] = ast.parse("""
if scale_log2 > 0 and is_causal and _selected_block == i_t // BS:
    for i, j in T.Parallel(G, BS):
        acc_s[i, j] = T.if_then_else(j <= i_t % BS, T.float32(0.0), -T.infinity(T.float32))
else:
    T.clear(acc_s)
""").body[0]
    positive = next(n for n in valid.body if isinstance(n, ast.If)
                    and ast.unparse(n.test) == "scale_log2 > 0")
    exp = next(n for n in ast.walk(positive) if isinstance(n, ast.Call)
               and ast.unparse(n.func) == "T.exp")
    positive.body = ast.parse("for i, j in T.Parallel(G, BS):\n    acc_s[i, j] = "
                              + ast.unparse(exp)).body


def main():
    source = (HERE / "v7_parent.py").read_text()
    originals = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    variants = [
        ("loads_vec4", TARGETS, "vector", 4),
        ("loads_vec8", TARGETS, "vector", 8),
        ("q_vec4", TARGETS, "qvector", 4),
        ("q_vec16", TARGETS, "qvector", 16),
        ("mid_boundary_init", {"_coalesced_block_loads_prim_oct8"}, "mask", None),
    ]
    manifest = []
    for name, targets, mode, value in variants:
        replacements = []
        for target in sorted(targets):
            original = originals[target]
            function = copy.deepcopy(original)
            if mode == "vector":
                transform = VectorWidth(value)
                function = transform.visit(function)
                assert transform.changed == 2, (target, transform.changed)
            elif mode == "qvector":
                function.body.insert(0, ast.parse(f"q_vec = {value}").body[0])
                for item in ast.walk(function):
                    if isinstance(item, ast.Compare) and ast.unparse(item) == "q_vec in (4, 8)":
                        item.comparators[0] = ast.Tuple(
                            elts=[ast.Constant(v) for v in (4, 8, 16)], ctx=ast.Load())
            else:
                boundary_init(function)
            ast.fix_missing_locations(function)
            replacements.append((original.lineno, original.end_lineno, ast.unparse(function)))
        lines = source.splitlines(keepends=True)
        for start, end, replacement in sorted(replacements, reverse=True):
            lines[start - 1:end] = [replacement + "\n"]
        result = "".join(lines)
        ast.parse(result)
        path = HERE / (name + ".py")
        with path.open("x") as handle:
            handle.write(result)
        manifest.append(dict(name=name, mode=mode, value=value, functions=sorted(targets),
                             sha256=hashlib.sha256(result.encode()).hexdigest()))
        print(path.name, flush=True)
    (HERE / "probe_manifest.json").write_text(json.dumps(dict(
        parent="v7_parent.py", parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
        variants=manifest, synchronization_unchanged=True, safety_passes_unchanged=True,
        note="Research variants modify builders directly; final candidate must retain original tuning fallbacks."
    ), indent=2) + "\n")


if __name__ == "__main__":
    main()
