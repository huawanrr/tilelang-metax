"""Keep exp2's internal argument normal, then rescale in FP32.

For original x <= 15, exp2(max(x + C, -126)) * 2**(-C), C >= 32,
has a floor below the smallest FP32 subnormal. Masked -inf still becomes
exact zero. This avoids the earlier unsafe nonzero floor on raw weights.
The addition introduces a small rounding error; it is measured explicitly.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

import numpy as np

HERE = Path(__file__).resolve().parent
NAMES = {
    "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint",
    "native_sparse_attention_single_packed_qo_v2_mathcast",
    "_coalesced_block_loads_prim_fp32_sum",
}


def sample_math(shift):
    rng = np.random.default_rng(1743)
    xs = np.concatenate([
        np.linspace(-170, 15, 1000001, dtype=np.float32),
        rng.uniform(-16, 15, 500000).astype(np.float32),
        np.array([-np.inf, -190, -158, -150, -149, -126, 0, 15], dtype=np.float32),
    ])
    with np.errstate(under="ignore"):
        reference = np.exp2(xs.astype(np.float64)).astype(np.float32)
        adjusted = np.maximum(xs + np.float32(shift), np.float32(-126))
        inner = np.exp2(adjusted.astype(np.float64)).astype(np.float32)
        result = inner * np.float32(2.0 ** -shift)
    normal = reference >= np.finfo(np.float32).tiny
    rel = np.abs(result[normal].astype(np.float64) / reference[normal] - 1)
    assert result[-8] == 0
    assert not np.any(result[reference == 0])
    assert float(rel.max()) < 1e-5
    return dict(samples=len(xs), sampled_max_relative_error_normal=float(rel.max()),
                max_absolute_error=float(np.max(np.abs(result-reference))),
                zero_underflow_preserved=True,
                description="CPU float32 step rounding with float64 exp2; GPU math still needs checking")


def main():
    source = (HERE / "baseline.py").read_text()
    functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for shift in (32, 64):
        helper_name = f"_rescaled_exp2_{shift}"
        helper = f"""
def {helper_name}(value):
    return T.exp2(T.max(value + T.float32({float(shift)}), T.float32(-126.0))) * T.float32({2.0**-shift!r})

"""
        result = source
        changes = {}
        for name in sorted(NAMES):
            fn = copy.deepcopy(functions[name])
            fn.decorator_list = []
            count = 0
            class Rewrite(ast.NodeTransformer):
                def visit_Call(self, node):
                    nonlocal count
                    node = self.generic_visit(node)
                    if ast.unparse(node.func) == "T.exp2":
                        assert len(node.args) == 1
                        assert ast.unparse(node.args[0]).startswith("T.min(")
                        assert ast.unparse(node.args[0]).endswith(", 15.0)")
                        node.func = ast.Name(id=helper_name, ctx=ast.Load())
                        count += 1
                    return node
            fn = Rewrite().visit(fn)
            assert count > 0
            changes[name] = count
            result = result.replace(ast.get_source_segment(source, functions[name]),
                                    ast.unparse(ast.fix_missing_locations(fn)), 1)
        result = result.replace("def _get_kernel(", helper + "def _get_kernel(", 1)
        ast.parse(result)
        path = HERE / f"rescaled_exp2_{shift}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(file=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            shift=shift, changes=changes, math_check=sample_math(shift)))
    with (HERE / "rescaled_exp2_manifest.json").open("x") as out:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       variants=records, current_input_semantics=True,
                       dispatch_and_pack_unchanged=True, synchronization_unchanged=True), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "rescaled-exponent probes")


if __name__ == "__main__":
    main()
