"""Check public call normalization, adapter errors, current inputs and host guards."""
import argparse
import ast
import ctypes
import hashlib
import importlib.util
import inspect
import json
from pathlib import Path
import sys

import torch

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module
from verify_nsa import check_case

spec = importlib.util.spec_from_file_location("host_call_helpers",
    ROOT / "experiments/20261005_goal8929/verify_candidate.py")
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)


def shape(c, scale=0.1):
    return (c["B"], c["SEQ_LEN"], c["H"], c["HQ"], c["D"], c["S"],
            c["block_size"], c["is_causal"], scale)


def factory(module, c, scale=0.1):
    return module.native_sparse_attention(c["B"], c["HQ"], c["SEQ_LEN"], c["D"],
        c["is_causal"], scale=scale, block_size=c["block_size"],
        groups=c["HQ"] // c["H"], selected_blocks=c["S"])


def guarded_module(path):
    fixture = ROOT / "experiments/20260928_guard_fix/check_restricted_host.py"
    tree = ast.parse(fixture.read_text())
    cutoff = next(i for i, n in enumerate(tree.body) if isinstance(n, ast.Assign)
        and any(isinstance(t, ast.Name) and t.id == "small" for t in n.targets))
    env = dict(__file__=str(fixture), __name__="host_call_guard_fixture")
    exec(compile(ast.Module(body=tree.body[:cutoff], type_ignores=[]), str(fixture), "exec"), env)
    # Include the newer joint-buffer host closure under the same unmodified guards.
    env["HOST_NAMES"].add("_make_block_joint_attention")
    result = env["guarded_module"](str(path))
    return result, sorted(env["HOST_NAMES"])


def outcome(fn, args):
    try:
        fn(*args)
    except Exception as exc:
        return dict(type=type(exc).__name__, message=str(exc))
    raise AssertionError("Invalid call unexpectedly accepted")


@torch.no_grad()
def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("module")
    p.add_argument("--parent", default=str(HERE / "baseline.py"))
    p.add_argument("--output", required=True)
    a = p.parse_args()
    path, parent_path, output = Path(a.module).resolve(), Path(a.parent).resolve(), Path(a.output)
    assert not output.exists()
    module, parent = load_module(str(path)), load_module(str(parent_path))
    report = dict(status="running", command=sys.argv,
        sources={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in (path, parent_path)},
        official_sandbox=False, cache=[], normalization=[], errors=[], live=[], restricted=[])
    def save():
        output.write_text(json.dumps(report, indent=2) + "\n")
    torch.backends.cuda.matmul.allow_tf32 = False
    cases = json.loads((HERE / "cases.json").read_text())
    cases["irregular"] = dict(B=2, SEQ_LEN=37, H=2, HQ=32, D=64, S=4,
        block_size=16, is_causal=False)
    names = ("oj1", "oj5", "oj6", "oj10", "oj11", "oj12", "oj13", "irregular")
    for name in names:
        c = cases[name]
        inputs = list(make_inputs(c, 61))
        out = torch.empty_like(inputs[0])
        for scale in (None, 0.0, -0.1, 0.1):
            error = check_case(module, c, 61, scale,
                lambda idx: helpers.adversarial_indices(idx, c["block_size"], True))
            compiled = module._get_kernel(*shape(c, scale))
            cached = module._KERNEL_CACHE[("public_default_arguments", *shape(c, scale))]
            runner = factory(module, c, scale)
            captured = inspect.getclosurevars(runner).nonlocals["kernel"]
            expected = getattr(compiled, "torch_function", compiled)
            assert cached is expected and captured is expected
            if hasattr(compiled, "torch_function"):
                assert compiled.torch_function is compiled.adapter.func
            report["cache"].append(dict(case=name, scale=scale, max_abs_error=error,
                kind="jit_adapter" if hasattr(compiled, "torch_function") else "ordinary_closure"))
            save()
        for mode in ("int32_strided", "int64_contiguous", "int64_strided"):
            dtype = torch.int32 if mode.startswith("int32") else torch.int64
            original = inputs[3].to(dtype)
            if mode.endswith("strided"):
                storage = torch.empty((*original.shape, 2), dtype=dtype, device=original.device)
                indices = storage[..., 0]
                indices.copy_(original)
                assert not indices.is_contiguous()
            else:
                indices = original.contiguous()
            actual_inputs = (*inputs[:3], indices)
            reference = sparse_reference(*actual_inputs, c["block_size"], c["is_causal"], 0.1)
            module.run_kernel(*actual_inputs, out, *shape(c))
            error = check_output(out, reference, mode)
            error = max(error, check_output(factory(module, c)(*actual_inputs), reference, mode))
            report["normalization"].append(dict(case=name, mode=mode, max_abs_error=error))
            save()
        # Clearing all compiled callable keys must not retain a stale callable.
        module._KERNEL_CACHE.clear()
        module.run_kernel(*inputs, out, *shape(c))
        reference = sparse_reference(*inputs, c["block_size"], c["is_causal"], 0.1)
        check_output(out, reference, "after clear")
        print("normalization/cache", name, "PASS", flush=True)

    # Errors are checked through the actual public entry and the exact selected adapter.
    c = cases["oj1"]
    q, k, v, idx = make_inputs(c, 71)
    out = torch.empty_like(q)
    values = [q, k, v, idx, out]
    stride_storage = torch.empty((*q.shape, 2), device=q.device, dtype=q.dtype)
    wrong = [
        ("q_dtype", 0, q.float()),
        ("q_shape", 0, q[:, :-1].contiguous()),
        ("q_stride", 0, stride_storage[..., 0]),
        ("k_shape", 1, k[:, :-1].contiguous()),
        ("v_dtype", 2, v.float()),
        ("index_shape", 3, idx[:, :-1].contiguous()),
        ("output_dtype", 4, out.float()),
        ("output_shape", 4, out[:, :-1].contiguous()),
    ]
    for name, i, value in wrong:
        invalid = list(values)
        invalid[i] = value
        before = outcome(parent.run_kernel, (*invalid, *shape(c)))
        after = outcome(module.run_kernel, (*invalid, *shape(c)))
        assert before == after, (name, before, after)
        report["errors"].append(dict(case=name, **after))
        save()
    compiled = module._get_kernel(*shape(c))
    for count in (4, 6):
        invalid = values[:count] if count == 4 else values + [out]
        before = outcome(compiled, invalid)
        after = outcome(compiled.torch_function, invalid)
        assert before == after
        report["errors"].append(dict(case="argument_count_" + str(count), **after))
        save()
    print("adapter errors PASS", flush=True)

    runtime = ctypes.CDLL("/opt/maca/lib/libmcruntime.so")
    pointer = ctypes.c_void_p()
    assert runtime.mcStreamCreate(ctypes.byref(pointer)) == 0
    stream = torch.cuda.ExternalStream(pointer.value)
    torch.cuda.graph.default_capture_stream = stream
    for name in names:
        c = cases[name]
        inputs = list(make_inputs(c, 7))
        out = torch.empty_like(inputs[0])
        runner = factory(module, c)
        module.run_kernel(*inputs, out, *shape(c))
        stream.wait_stream(torch.cuda.current_stream())
        stream.synchronize()
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph, stream=stream):
            module.run_kernel(*inputs, out, *shape(c))
        for step, changed in enumerate((0, 1, 2, 3)):
            if changed < 3:
                inputs[changed].copy_(make_inputs(c, 810 + step)[changed])
            else:
                indices = helpers.adversarial_indices(inputs[3], c["block_size"], True)
                inputs[3].copy_(indices)
            reference = sparse_reference(*inputs, c["block_size"], c["is_causal"], 0.1)
            out.fill_(float("nan"))
            graph.replay()
            torch.cuda.synchronize()
            graph_error = check_output(out, reference, "live graph")
            out.fill_(float("nan"))
            module.run_kernel(*inputs, out, *shape(c))
            direct_error = check_output(out, reference, "live direct")
            factory_error = check_output(runner(*inputs), reference, "live factory")
            report["live"].append(dict(case=name, changed=changed,
                graph_max_abs_error=graph_error, direct_max_abs_error=direct_error,
                factory_max_abs_error=factory_error))
            save()
        del graph
        print("live", name, "PASS", flush=True)
    guarded, guarded_names = guarded_module(path)
    report["guarded_host_functions"] = guarded_names
    for name in names:
        c = cases[name]
        error = check_case(guarded, c, 61, 0.1,
            lambda idx: helpers.adversarial_indices(idx, c["block_size"], True))
        report["restricted"].append(dict(case=name, max_abs_error=error))
        save()
    assert report["sources"][str(path)] == hashlib.sha256(path.read_bytes()).hexdigest()
    report["status"] = "PASS"
    save()
    print("PASS", {k:len(report[k]) for k in ("cache", "normalization", "errors", "live", "restricted")}, flush=True)


if __name__ == "__main__":
    main()
