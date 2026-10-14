"""Compute S8 tiles uniformly, clamp memory addresses and mask probabilities.

This differs from the earlier K-only safe prefetch: both matrix products and
V reads run uniformly. Invalid slots contribute zero after exponentiation.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


class Uniform(ast.NodeTransformer):
    def __init__(self, mask):
        self.mask = mask
        self.removed = 0
        self.exp_count = 0
        self.current = None

    def visit_Subscript(self, node):
        node = self.generic_visit(node)
        if isinstance(node.value, ast.Name) and node.value.id in ("K", "V"):
            assert isinstance(node.slice, ast.Tuple)
            original = ast.unparse(node.slice.elts[1])
            node.slice.elts[1] = ast.parse(
                f"T.min(T.max({original}, 0), T.ceildiv(seq_len, BS) - 1)", mode="eval").body
        return node

    def visit_If(self, node):
        test = ast.unparse(node.test)
        if test.startswith("prefetch_depth >") and "i_s" in test:
            self.removed += 1
            previous = self.current
            self.current = next(n.id for n in ast.walk(node.test)
                                if isinstance(n, ast.Name) and n.id.startswith("i_s"))
            transformed = self.generic_visit(node).body
            self.current = previous
            return transformed
        if self.current is not None and test.startswith("is_causal and") and "BS" in test:
            return ast.parse("T.clear(acc_s)").body
        if self.current is not None and test == "scale_log2 > 0":
            self.exp_count += 1
            s = self.current
            base = """
for i, j in T.Parallel(G, BS):
    acc_s[i, j] = T.exp(T.min(acc_s[i, j] * (scale_log2 * 0.6931471805599453), 10.39720770839918))
"""
            if self.mask == "select":
                base += f"""
for i, j in T.Parallel(G, BS):
    acc_s[i, j] = T.if_then_else({s} >= 0 and {s} + j < seq_len and (not is_causal or {s} + j <= i_t), acc_s[i, j], T.float32(0))
"""
            else:
                base += f"""
if {s} < 0 or {s} >= seq_len or (is_causal and {s} > i_t):
    T.clear(acc_s)
elif {s} + BS > seq_len or (is_causal and {s} + BS > i_t + 1):
    for i, j in T.Parallel(G, BS):
        acc_s[i, j] = T.if_then_else({s} + j < seq_len and (not is_causal or {s} + j <= i_t), acc_s[i, j], T.float32(0))
"""
            return ast.parse(base).body
        return self.generic_visit(node)


def main():
    source = (HERE / "baseline.py").read_text()
    records = []
    for mask in ("select", "branch"):
        additions = []
        result = source
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in NAMES:
                continue
            fn = copy.deepcopy(fn)
            old_name = fn.name
            fn.name += "_uniform"
            transformer = Uniform(mask)
            fn = transformer.visit(fn)
            assert transformer.removed == 8 and transformer.exp_count == 4
            fn.body.insert(0, ast.parse("assert selected_blocks == 8 and prefetch_depth == 4").body[0])
            additions.append(ast.unparse(ast.fix_missing_locations(fn)))
            # These assignments occur only in the existing mathcast_s8
            # dispatch; the S4 direct factory call must remain untouched.
            old_dispatch = f"                    online_builder = {old_name}\n"
            assert result.count(old_dispatch) == 1
            result = result.replace(old_dispatch, f"                    online_builder = {fn.name}\n", 1)
        assert len(additions) == 2
        position = result.index("def _get_kernel(")
        result = result[:position] + "\n\n".join(additions) + "\n\n" + result[position:]
        ast.parse(result)
        path = HERE / f"s8_uniform_{mask}.py"
        with path.open("x") as file:
            file.write(result)
        records.append(dict(path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest()))
    (HERE / "s8_uniform_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        dispatch="Only existing default mathcast_s8 branches", math="Bounded loads, zero invalid probabilities before PV"), indent=2) + "\n")
    print("Generated", len(records), "uniform S8 probes", flush=True)


if __name__ == "__main__":
    main()
