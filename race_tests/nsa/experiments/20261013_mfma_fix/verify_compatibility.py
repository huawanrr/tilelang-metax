"""Exercise FP32 MMA under a strict PrimExpr operand contract and on the GPU.

The local tir.Call accepts DataType operands; newer tirx.Call expects PrimExpr.
Use the real FFI conversion in tir.Evaluate to exercise that stricter contract
before forwarding each MMA call. This is a compatibility probe, not the OJ
sandbox. Only this test process temporarily wraps T.tvm_mfma.
"""
import argparse
import ast
import hashlib
import importlib.util
import json
from pathlib import Path
import sys
import traceback
from unittest.mock import patch

import torch
import tilelang
import tilelang.language as T
from tilelang import tvm

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from experiment_bench import load_module
from verify_nsa import check_case

BUILDERS = (
    "_coalesced_block_loads_prim_fp32_sum",
    "_coalesced_block_loads_prim_fp32_mask",
    "_coalesced_block_loads_prim_boundary_v8",
)
FAILED_CASES = ("oj5", "oj7", "oj8", "oj9", "oj13")


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--parent", default=str(ROOT / "experiments/20261012_goal89/release_v10/submission.py"))
    parser.add_argument("--module", default=str(HERE / "submission.py"))
    parser.add_argument("--output", default=str(HERE / "compatibility.json"))
    args = parser.parse_args()
    output = Path(args.output)
    assert not output.exists(), output
    parent_path, module_path = Path(args.parent).resolve(), Path(args.module).resolve()
    old, new = parent_path.read_text(), module_path.read_text()
    old_ctor = "wsum = TensorCoreIntrinEmitter(a_dtype=T.float32, b_dtype=T.float32, accum_dtype=T.float32,"
    new_ctor = 'wsum = TensorCoreIntrinEmitter(a_dtype="float32", b_dtype="float32", accum_dtype="float32",'
    assert old.count(old_ctor) == new.count(new_ctor) == 3
    assert old.replace(old_ctor, new_ctor) == new
    old_functions = {n.name: ast.dump(n) for n in ast.parse(old).body if isinstance(n, ast.FunctionDef)}
    new_functions = {n.name: ast.dump(n) for n in ast.parse(new).body if isinstance(n, ast.FunctionDef)}
    assert old_functions.keys() == new_functions.keys()
    assert tuple(n for n in old_functions if old_functions[n] != new_functions[n]) == BUILDERS
    parent, module = load_module(str(parent_path)), load_module(str(module_path))
    tir = getattr(tvm, "tirx", None) or tvm.tir
    report = dict(status="running", official_sandbox=False, command=sys.argv,
                  parent_sha256=sha(parent_path), submission_sha256=sha(module_path),
                  harness_sha256=sha(__file__), tilelang_path=tilelang.__file__,
                  modified_functions=list(BUILDERS), byte_changes_limited_to_dtype_arguments=True,
                  strict_primexpr=[], normal_primfunc_equal=[], oj=[], adversarial=[], restricted_host=[])

    def save():
        output.write_text(json.dumps(report, indent=2) + "\n")

    # Confirm this environment distinguishes a dtype value from a string operand.
    try:
        tir.Evaluate(T.float32)
    except TypeError as error:
        report["datatype_as_primexpr_rejected"] = str(error)
    else:
        raise AssertionError("The FFI probe must reject a DataType as PrimExpr")
    assert isinstance(tir.Evaluate("float32").value, tir.StringImm)
    save()

    original_mfma = T.tvm_mfma
    calls = []

    def strict_mfma(shape, a_layout, b_layout, a_dtype, b_dtype, c_dtype, *operands, **kwargs):
        descriptors = (shape, a_layout, b_layout, a_dtype, b_dtype, c_dtype)
        calls.append(dict(shape=str(shape), a_type=type(a_dtype).__name__, b_type=type(b_dtype).__name__))
        for descriptor in descriptors:
            # Call the real C++ FFI conversion required by Array<PrimExpr>.
            tir.Evaluate(descriptor)
        return original_mfma(*descriptors, *operands, **kwargs)

    build_args = dict(batch=1, heads=16, seq_len=128, dim=64, is_causal=True,
                      block_size=16, groups=16, scale_log2=0.144269504, lane_reduce=True)
    for name in BUILDERS:
        calls.clear()
        with patch.object(T, "tvm_mfma", strict_mfma):
            try:
                getattr(parent, name)(**build_args)
            except TypeError as error:
                trace = traceback.format_exc()
                assert "DataType" in str(error) and "PrimExpr" in str(error)
                assert "_warp_mma" in trace and "strict_mfma" in trace
                rejected = dict(builder=name, expected_rejection=True, error=str(error),
                                traceback=trace, mma_calls=list(calls))
            else:
                raise AssertionError((name, "The unmodified parent must fail the strict contract"))
            calls.clear()
            fixed = getattr(module, name)(**build_args)
            assert isinstance(fixed, tir.PrimFunc)
            fp32 = [c for c in calls if c["shape"] == "16x16x4f32"]
            assert fp32 and all(c["a_type"] == c["b_type"] == "str" for c in fp32)
            rejected.update(fixed_pass=True, fixed_mma_calls=list(calls))
        normal = getattr(parent, name)(**build_args)
        tvm.ir.assert_structural_equal(normal, fixed, map_free_vars=True)
        report["strict_primexpr"].append(rejected)
        report["normal_primfunc_equal"].append(name)
        save()
        print("strict PrimExpr", name, "parent rejected; fixed PASS; same PrimFunc", flush=True)

    torch.backends.cuda.matmul.allow_tf32 = False
    cases = json.loads((ROOT / "experiments/20261012_goal89/cases.json").read_text())
    for name in (f"oj{i}" for i in range(1, 15)):
        seeds = (0, 61) if name in FAILED_CASES else (0,)
        for seed in seeds:
            error = check_case(module, cases[name], seed, 0.1)
            report["oj"].append(dict(case=name, seed=seed, config=cases[name], max_abs_error=error))
            save()
            print("OJ shape", name, seed, "both interfaces PASS", error, flush=True)

    spec = importlib.util.spec_from_file_location("mfma_fix_input_helpers", ROOT / "experiments/20261005_goal8929/verify_candidate.py")
    helpers = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(helpers)
    for name in FAILED_CASES:
        case = cases[name]
        indices = lambda x: helpers.adversarial_indices(x, case["block_size"], True)
        for scale in (None, 0.0, -0.1, 0.03125, 0.1):
            error = check_case(module, case, 61, scale, indices)
            report["adversarial"].append(dict(case=name, scale=scale, max_abs_error=error))
            save()
        print("adversarial indices and scales", name, "PASS", flush=True)
    guarded = helpers.guarded_module(module_path)
    for name in FAILED_CASES:
        case = cases[name]
        error = check_case(guarded, case, 61, 0.1,
                           lambda x: helpers.adversarial_indices(x, case["block_size"], True))
        report["restricted_host"].append(dict(case=name, max_abs_error=error))
        save()
        print("RestrictedPython host", name, "both interfaces PASS", flush=True)
    assert sha(parent_path) == report["parent_sha256"]
    assert sha(module_path) == report["submission_sha256"]
    report["status"] = "PASS"
    save()
    print("PASS", {key: len(report[key]) for key in
                   ("strict_primexpr", "oj", "adversarial", "restricted_host")}, flush=True)


if __name__ == "__main__":
    with torch.no_grad():
        main()
