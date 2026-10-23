"""Check the selected S2 family, strict FP32 types and current-input replay."""
import argparse
import ast
import ctypes
import hashlib
import importlib.util
import inspect
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

spec = importlib.util.spec_from_file_location("new_family_helpers", ROOT / "experiments/20261005_goal8929/verify_candidate.py")
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)


def cfg(t, b=1, h=1, d=64, s=2, bs=16, causal=True):
    return dict(B=b, SEQ_LEN=t, H=h, HQ=16*h, D=d, S=s, block_size=bs, is_causal=causal)


def shape(c, scale=0.1):
    return (c["B"], c["SEQ_LEN"], c["H"], c["HQ"], c["D"], c["S"], c["block_size"], c["is_causal"], scale)


@torch.no_grad()
def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("module")
    p.add_argument("--output", required=True)
    args = p.parse_args()
    path, output = Path(args.module).resolve(), Path(args.output)
    assert not output.exists()
    module = load_module(str(path))
    report = dict(status="running", source_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
        official_sandbox=False, strict_fp32=[], boundaries=[], scales=[], live=[], restricted=[])
    def save():
        output.write_text(json.dumps(report, indent=2) + "\n")
    tir = getattr(tvm, "tirx", None) or tvm.tir
    original = T.tvm_mfma
    calls = []
    def strict(shape_name, a_layout, b_layout, a_dtype, b_dtype, c_dtype, *operands, **kwargs):
        descriptors = (shape_name, a_layout, b_layout, a_dtype, b_dtype, c_dtype)
        for descriptor in descriptors:
            tir.Evaluate(descriptor)
        calls.append(dict(shape=str(shape_name), a_type=type(a_dtype).__name__, b_type=type(b_dtype).__name__))
        return original(*descriptors, *operands, **kwargs)
    common = dict(batch=1, heads=16, seq_len=128, dim=64, is_causal=True,
        block_size=16, groups=16, scale_log2=0.144269504, threads=64)
    for fn in ast.parse(path.read_text()).body:
        if not isinstance(fn, ast.FunctionDef):
            continue
        fp32 = [n for n in ast.walk(fn) if isinstance(n, ast.Call)
            and isinstance(n.func, ast.Name) and n.func.id == "TensorCoreIntrinEmitter"
            and any(k.arg == "a_dtype" and isinstance(k.value, ast.Constant) and k.value.value == "float32" for k in n.keywords)]
        if not fp32:
            continue
        for constructor in fp32:
            values = {k.arg: k.value for k in constructor.keywords}
            assert all(isinstance(values[k], ast.Constant) and values[k].value == "float32"
                       for k in ("a_dtype", "b_dtype", "accum_dtype")), fn.name
        calls.clear()
        with patch.object(T, "tvm_mfma", strict):
            if fn.name.startswith("_coalesced_block_loads_prim_"):
                getattr(module, fn.name)(**common, lane_reduce=True)
            elif fn.name.startswith("native_sparse_attention_staged_sparse_blocks"):
                getattr(module, fn.name).get_tir(**common, selected_blocks=4)
            elif fn.name.startswith("native_sparse_attention_short_list_oct8"):
                getattr(module, fn.name).get_tir(**common, selected_blocks=2, lane_reduce=True)
            elif fn.name == "native_sparse_attention_q_preload_vfirst":
                tiny = dict(common, seq_len=64, dim=32)
                getattr(module, fn.name).get_tir(**tiny, natural=True, late=True)
            else:
                raise AssertionError(("Add strict probe for new FP32 builder", fn.name))
        assert any(c["shape"] == "16x16x4f32" for c in calls), fn.name
        report["strict_fp32"].append(dict(builder=fn.name, calls=list(calls)))
        save()
    torch.backends.cuda.matmul.allow_tf32 = False
    boundaries = [cfg(t) for t in (240, 255, 256, 257, 272, 320, 383, 384, 385, 400)]
    boundaries += [cfg(t, b=2) for t in (112, 127, 128, 129, 160, 191, 192, 193, 208)]
    boundaries += [cfg(t, b=3) for t in (80, 96, 112, 128, 144)]
    boundaries += [cfg(t, b=4) for t in (64, 80, 96, 112)]
    boundaries += [cfg(64, b=5), cfg(64, b=6), cfg(64, b=7), cfg(128, h=2)]
    boundaries += [cfg(256, causal=False), cfg(128, b=2, causal=False), cfg(128, b=3, causal=False)]
    boundaries += [cfg(256, s=1), cfg(256, s=4), cfg(256, bs=32)]
    for c in boundaries:
        error = check_case(module, c, 61, 0.1,
            lambda indices: helpers.adversarial_indices(indices, c["block_size"], True))
        report["boundaries"].append(dict(config=c, max_abs_error=error))
        save()
        print("boundary", len(report["boundaries"]), error, flush=True)
    active = [cfg(256), cfg(384), cfg(128, b=2), cfg(128, b=3),
              cfg(64, b=6), cfg(256, causal=False)]
    for c in active:
        for scale in (None, 0.0, -0.1, 0.03125, 0.1):
            error = check_case(module, c, 61, scale,
                lambda indices: helpers.adversarial_indices(indices, c["block_size"], True))
            report["scales"].append(dict(config=c, scale=scale, max_abs_error=error))
            save()
        print("scales", c, "PASS", flush=True)
    runtime = ctypes.CDLL("/opt/maca/lib/libmcruntime.so")
    pointer = ctypes.c_void_p()
    assert runtime.mcStreamCreate(ctypes.byref(pointer)) == 0
    stream = torch.cuda.ExternalStream(pointer.value)
    torch.cuda.graph.default_capture_stream = stream
    for c in active:
        inputs = list(make_inputs(c, 7))
        out = torch.empty_like(inputs[0])
        call_args = (*inputs, out, *shape(c))
        module.run_kernel(*call_args)
        stream.wait_stream(torch.cuda.current_stream())
        stream.synchronize()
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph, stream=stream):
            module.run_kernel(*call_args)
        for step, changed in enumerate((0, 1, 2, 3, 0, 3)):
            if changed < 3:
                inputs[changed].copy_(make_inputs(c, 800+step)[changed])
            else:
                inputs[3].copy_(helpers.adversarial_indices(inputs[3], c["block_size"], step == 5))
            expected = sparse_reference(*inputs, c["block_size"], c["is_causal"], 0.1)
            out.fill_(float("nan"))
            graph.replay()
            torch.cuda.synchronize()
            graph_error = check_output(out, expected, "live graph")
            out.fill_(float("nan"))
            module.run_kernel(*call_args)
            direct_error = check_output(out, expected, "live direct")
            report["live"].append(dict(config=c, changed=changed,
                graph_max_abs_error=graph_error, direct_max_abs_error=direct_error))
            save()
        del graph
        print("live", c, "PASS", flush=True)
    guarded = helpers.guarded_module(path)
    for c in active:
        error = check_case(guarded, c, 61, 0.1,
            lambda indices: helpers.adversarial_indices(indices, c["block_size"], True))
        report["restricted"].append(dict(config=c, max_abs_error=error))
        save()
    # Verify the actual compiled callables in both cache orders.
    parent_path = HERE / "baseline.py"
    parent = load_module(str(parent_path))
    report["parent_sha256"] = hashlib.sha256(parent_path.read_bytes()).hexdigest()
    report["compiled_cache_orders"] = []
    for c in (cfg(256), cfg(384), cfg(128, b=2), cfg(64, b=6)):
        inputs = list(make_inputs(c, 2026))
        inputs[3].copy_(helpers.adversarial_indices(inputs[3], c["block_size"], True))
        expected = sparse_reference(*inputs, c["block_size"], c["is_causal"], 0.1)
        out = torch.empty_like(inputs[0])
        for options in ({"q_frag": False}, {"q_preload": True}):
            parent._KERNEL_CACHE.clear()
            original = parent._get_kernel(*shape(c), **options)
            explicit_hash = hashlib.sha256(original.get_kernel_source().encode()).hexdigest()
            module._KERNEL_CACHE.clear()
            normal = module._get_kernel(*shape(c))
            default_hash = hashlib.sha256(normal.get_kernel_source().encode()).hexdigest()
            for order in (({}, options, {}, options), (options, {}, options, {})):
                module._KERNEL_CACHE.clear()
                for request in order:
                    compiled = module._get_kernel(*shape(c), **request)
                    actual_hash = hashlib.sha256(compiled.get_kernel_source().encode()).hexdigest()
                    assert actual_hash == (explicit_hash if request else default_hash), (c, request)
                    out.fill_(float("nan"))
                    compiled(*inputs, out)
                    error = check_output(out, expected, "compiled cache order")
                    report["compiled_cache_orders"].append(dict(config=c, options=request,
                        device_source_sha256=actual_hash, max_abs_error=error))
                save()
        print("compiled cache order", c, "PASS", flush=True)
    assert report["source_sha256"] == hashlib.sha256(path.read_bytes()).hexdigest()
    report["status"] = "PASS"
    save()
    print("PASS", {k:len(report[k]) for k in ("strict_fp32", "boundaries", "scales", "live", "restricted")}, flush=True)


if __name__ == "__main__":
    main()
