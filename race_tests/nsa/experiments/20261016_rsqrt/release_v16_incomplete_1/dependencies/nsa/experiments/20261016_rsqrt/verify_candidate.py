"""Validate the changed D32 path against independent attention references."""
import argparse
import ctypes
import hashlib
import importlib.util
import json
from pathlib import Path
import sys
from unittest.mock import patch

import torch
import tilelang.language as T
from tilelang import tvm

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module
from verify_nsa import check_case

spec = importlib.util.spec_from_file_location("rsqrt_validation_helpers", ROOT / "experiments/20261005_goal8929/verify_candidate.py")
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)


def shape(c, scale=0.1):
    return (c["B"], c["SEQ_LEN"], c["H"], c["HQ"], c["D"], c["S"], c["block_size"], c["is_causal"], scale)


def converted_indices(indices):
    values = helpers.adversarial_indices(indices, 16, True)
    result = torch.stack((values, values), dim=-1)[..., 0]
    assert result.dtype == torch.int64 and not result.is_contiguous()
    return result


@torch.no_grad()
def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("module")
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    path, output = Path(args.module).resolve(), Path(args.output)
    assert not output.exists()
    module = load_module(str(path))
    parent = load_module(str(HERE / "baseline.py"))
    cases = json.loads((HERE / "candidate_cases.json").read_text())
    active = cases["oj1"]
    torch.backends.cuda.matmul.allow_tf32 = False
    report = dict(status="running", command=sys.argv,
                  candidate_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                  official_sandbox=False, strict_fp32=[], boundaries=[], scales=[],
                  zero_inputs=[], live=[], restricted=[], cache_orders=[])

    def save():
        output.write_text(json.dumps(report, indent=2) + "\n")

    tir = getattr(tvm, "tirx", None) or tvm.tir
    original = T.tvm_mfma

    def strict(shape_name, a_layout, b_layout, a_dtype, b_dtype, c_dtype, *operands, **kwargs):
        descriptors = (shape_name, a_layout, b_layout, a_dtype, b_dtype, c_dtype)
        for descriptor in descriptors:
            tir.Evaluate(descriptor)
        report["strict_fp32"].append(dict(shape=str(shape_name), a_type=type(a_dtype).__name__,
                                         b_type=type(b_dtype).__name__))
        return original(*descriptors, *operands, **kwargs)

    with patch.object(T, "tvm_mfma", strict):
        module.native_sparse_attention_q_preload_vfirst.get_tir(
            batch=1, heads=16, seq_len=64, dim=32, is_causal=True, block_size=16,
            groups=16, scale_log2=0.144269504, threads=64, natural=True, late=True)
    assert any(row["shape"] == "16x16x4f32" for row in report["strict_fp32"])
    save()
    for name, config in cases.items():
        if name != "oj1" and not name.startswith("d32_"):
            continue
        error = check_case(module, config, 61, 0.1,
                           lambda indices: helpers.adversarial_indices(indices, 16, True))
        report["boundaries"].append(dict(case=name, config=config, max_abs_error=error))
        save()
    print("boundaries", len(report["boundaries"]), "PASS", flush=True)
    for seed in (0, 61, 2026):
        for scale in (None, 0.0, -0.1, 0.03125, 0.1, 1e-8):
            for extreme in (False, True):
                error = check_case(module, active, seed, scale,
                                   converted_indices if extreme else None)
                report["scales"].append(dict(seed=seed, scale=scale, extreme=extreme,
                                              max_abs_error=error))
                save()
    print("scales", len(report["scales"]), "PASS", flush=True)
    factory = module.native_sparse_attention(1, 16, 64, 32, True, scale=0.1,
                                             block_size=16, groups=16, selected_blocks=1)
    for zero_operand in (0, 1, 2):
        inputs = list(make_inputs(active, 2026))
        inputs[zero_operand].zero_()
        expected = sparse_reference(*inputs, 16, True, 0.1)
        out = torch.full_like(inputs[0], float("nan"))
        module.run_kernel(*inputs, out, *shape(active))
        error = max(check_output(out, expected, "zero direct"),
                    check_output(factory(*inputs), expected, "zero factory"))
        report["zero_inputs"].append(dict(operand=zero_operand, max_abs_error=error))
        save()
    runtime = ctypes.CDLL("/opt/maca/lib/libmcruntime.so")
    pointer = ctypes.c_void_p()
    assert runtime.mcStreamCreate(ctypes.byref(pointer)) == 0
    stream = torch.cuda.ExternalStream(pointer.value)
    torch.cuda.graph.default_capture_stream = stream
    for converted in (False, True):
        inputs = list(make_inputs(active, 7))
        if converted:
            inputs[3] = converted_indices(inputs[3])
        out = torch.empty_like(inputs[0])
        module.run_kernel(*inputs, out, *shape(active))
        stream.wait_stream(torch.cuda.current_stream())
        stream.synchronize()
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph, stream=stream):
            module.run_kernel(*inputs, out, *shape(active))
        for step, changed in enumerate((0, 1, 2, 3, 0, 3)):
            if changed < 3:
                inputs[changed].copy_(make_inputs(active, 800 + step)[changed])
            else:
                inputs[3].copy_(helpers.adversarial_indices(inputs[3], 16, step == 5))
            expected = sparse_reference(*inputs, 16, True, 0.1)
            out.fill_(float("nan"))
            graph.replay()
            torch.cuda.synchronize()
            graph_error = check_output(out, expected, "updated graph")
            out.fill_(float("nan"))
            module.run_kernel(*inputs, out, *shape(active))
            direct_error = check_output(out, expected, "updated direct")
            factory_error = check_output(factory(*inputs), expected, "updated factory")
            report["live"].append(dict(converted=converted, changed=changed,
                                       graph_max_abs_error=graph_error,
                                       direct_max_abs_error=direct_error,
                                       factory_max_abs_error=factory_error))
            save()
        del graph
    print("live", len(report["live"]), "PASS", flush=True)
    guarded = helpers.guarded_module(path)
    for scale in (None, 0.0, -0.1, 0.1):
        error = check_case(guarded, active, 61, scale, converted_indices)
        report["restricted"].append(dict(scale=scale, max_abs_error=error))
        save()
    inputs = list(make_inputs(active, 2026))
    inputs[3].copy_(helpers.adversarial_indices(inputs[3], 16, True))
    expected = sparse_reference(*inputs, 16, True, 0.1)
    out = torch.empty_like(inputs[0])
    for options in ({"q_frag": False}, {"q_preload": True}):
        parent._KERNEL_CACHE.clear()
        explicit = parent._get_kernel(*shape(active), **options)
        explicit_hash = hashlib.sha256(explicit.get_kernel_source().encode()).hexdigest()
        module._KERNEL_CACHE.clear()
        normal = module._get_kernel(*shape(active))
        default_hash = hashlib.sha256(normal.get_kernel_source().encode()).hexdigest()
        for order in (({}, options, {}, options), (options, {}, options, {})):
            module._KERNEL_CACHE.clear()
            for request in order:
                kernel = module._get_kernel(*shape(active), **request)
                actual_hash = hashlib.sha256(kernel.get_kernel_source().encode()).hexdigest()
                assert actual_hash == (explicit_hash if request else default_hash)
                out.fill_(float("nan"))
                kernel(*inputs, out)
                error = check_output(out, expected, "cache order")
                report["cache_orders"].append(dict(options=request, device_source_sha256=actual_hash,
                                                   max_abs_error=error))
                save()
    assert report["candidate_sha256"] == hashlib.sha256(path.read_bytes()).hexdigest()
    report["status"] = "PASS"
    save()
    print("PASS", {key: len(value) for key, value in report.items() if isinstance(value, list)}, flush=True)


if __name__ == "__main__":
    main()
