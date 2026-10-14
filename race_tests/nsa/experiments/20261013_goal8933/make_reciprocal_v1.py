"""Probe Newton-refined reciprocal for positive normal softmax denominators.

The exponent is clipped before summation, so no supported denominator can
approach FP32 overflow. Current fast-math sums flush subnormals to zero and
the existing positive-sum guard is retained. Three refinements target FP32
accuracy; two refinements are a separate, explicitly approximate experiment.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

import numpy as np

HERE = Path(__file__).resolve().parent
TARGETS = {
    "native_sparse_attention_q_preload_vfirst", "native_sparse_attention_q_preload",
    "native_sparse_attention_direct_kv", "native_sparse_attention_linear_v_blocks_oct8",
    "_coalesced_block_loads_prim_mathcast", "_coalesced_block_loads_prim_oct8",
    "_coalesced_block_loads_prim_fp32_sum", "_coalesced_block_loads_prim_fp32_mask",
    "_coalesced_block_loads_prim_boundary_v8",
    "native_sparse_attention_single_packed_qo_v2_mathcast",
    "native_sparse_attention_online_packed_batch_minor_o_v2_mathcast",
    "native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast",
}


class ReplaceReciprocal(ast.NodeTransformer):
    count = 0

    def visit_BinOp(self, node):
        node = self.generic_visit(node)
        if isinstance(node.op, ast.Div) and isinstance(node.left, ast.Constant) and node.left.value == 1.0:
            self.count += 1
            return ast.Call(func=ast.Name(id="_newton_denominator_reciprocal", ctx=ast.Load()),
                            args=[node.right], keywords=[])
        return node


def numeric_probe(steps):
    rng = np.random.default_rng(20261013)
    # All exponent values in the supported denominator range, plus exact
    # powers of two and both mantissa endpoints. This is independent of Q/K.
    exponents = np.arange(1, 180, dtype=np.uint32)
    mantissas = rng.integers(0, 1 << 23, size=(len(exponents), 2048), dtype=np.uint32)
    mantissas[:, :3] = [0, 1, (1 << 23) - 1]
    bits = ((exponents[:, None] << np.uint32(23)) | mantissas).ravel()
    x = bits.view(np.float32)
    y = (np.uint32(0x7EF311C3) - bits).view(np.float32)
    for _ in range(steps):
        y = np.float32(y * np.float32(np.float32(2) - np.float32(x * y)))
    expected64 = 1.0 / x.astype(np.float64)
    rel = np.abs(y.astype(np.float64) / expected64 - 1.0)
    assert np.isfinite(y).all() and (y > 0).all()
    bound = 7e-6 if steps == 2 else 3e-7
    assert rel.max() < bound, (steps, rel.max())
    return dict(steps=steps, inputs=len(x), exponent_bits=[1, 179],
                max_relative_error=float(rel.max()), acceptance_bound=bound,
                note="CPU FP32 non-fused arithmetic; separate GPU/reference checks required")


def main():
    source = (HERE / "baseline.py").read_text()
    records = []
    for steps in (2, 3):
        result = source
        changed = {}
        for fn in ast.parse(source).body:
            if not isinstance(fn, ast.FunctionDef) or fn.name not in TARGETS:
                continue
            transformer = ReplaceReciprocal()
            updated = transformer.visit(copy.deepcopy(fn))
            assert transformer.count, fn.name
            changed[fn.name] = transformer.count
            result = result.replace(ast.get_source_segment(source, fn), ast.unparse(ast.fix_missing_locations(updated)), 1)
        helper = "\n\ndef _newton_denominator_reciprocal(value):\n"
        helper += "    bits = T.reinterpret(\"uint32\", value)\n"
        helper += "    y = T.reinterpret(\"float32\", T.uint32(2129859011) - bits)\n"
        for i in range(steps):
            helper += "    y = y * (2.0 - value * y)\n"
        helper += "    return y\n\n"
        assert 2129859011 == 0x7EF311C3
        at = result.index("def _clamped_load_base(")
        result = result[:at] + helper + result[at:]
        ast.parse(result)
        path = HERE / f"reciprocal_newton{steps}.py"
        with path.open("x") as file:
            file.write(result)
        records.append(dict(path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest(),
                            changed=changed, cpu_numeric=numeric_probe(steps)))
    (HERE / "reciprocal_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records), indent=2) + "\n")
    print("Generated", len(records), "reciprocal probes", flush=True)


if __name__ == "__main__":
    main()
