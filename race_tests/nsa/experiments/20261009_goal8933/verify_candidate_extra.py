"""Validate new-path boundaries, exceptional indices/scales, tuning, and live inputs."""
import argparse
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

spec = importlib.util.spec_from_file_location("nsa_v7_validation_helpers",
    ROOT / "experiments/20261008_resume8857/verify_candidate.py")
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)
cfg, shape, device = helpers.cfg, helpers.shape, helpers.device


@torch.no_grad()
def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("module")
    parser.add_argument("--parent", default=str(HERE / "parent_submission.py"))
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    output_path = Path(args.output)
    assert not output_path.exists()
    source_hash = hashlib.sha256(Path(args.module).read_bytes()).hexdigest()
    module, parent = [load_module(str(Path(p).resolve())) for p in (args.module, args.parent)]
    for name in ("run_kernel", "native_sparse_attention"):
        assert inspect.signature(getattr(module, name)) == inspect.signature(getattr(parent, name))
    torch.backends.cuda.matmul.allow_tf32 = False
    report = dict(status="running", command=sys.argv, source_sha256=source_hash,
                  parent_sha256=hashlib.sha256(Path(args.parent).read_bytes()).hexdigest(),
                  harness_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  tf32=False, official_sandbox=False, boundaries=[], extreme_scales=[],
                  tuning=[], cache_order=[], live_inputs=[], restricted_host=[])

    def save():
        output_path.write_text(json.dumps(report, indent=2) + "\n")

    def verify(c, scale=0.1, extreme=False, current=module):
        return check_case(current, c, 61, scale,
            lambda indices: helpers.prior.adversarial_indices(indices, c["block_size"], extreme))

    boundaries = [cfg(n, d=32) for n in (16, 32, 48, 63, 64, 65, 80, 192, 208)]
    boundaries += [cfg(64, d=32, causal=False), cfg(32, b=2, d=32), cfg(32, h=2, d=32)]
    boundaries += [cfg(n, h=2) for n in (112, 127, 128, 144, 255, 256, 257, 512, 560, 576)]
    boundaries += [cfg(n, h=4) for n in (112, 127, 128, 144)]
    boundaries += [cfg(192, h=3), cfg(256, h=3), cfg(512, h=3), cfg(128, b=3, h=3)]
    boundaries += [cfg(256, h=2, causal=False), cfg(512, h=2, causal=False),
                   cfg(512, b=2, h=2), cfg(576, b=2, h=2)]
    boundaries += [cfg(n) for n in (2288, 2303, 2304, 2305, 2320)]
    boundaries += [cfg(n, d=128) for n in (1264, 1279, 1280, 1281, 1296)]
    boundaries += [cfg(320, b=2, h=2, d=128), cfg(1280, d=128, causal=False),
                   cfg(2304, causal=False), cfg(512, h=4, d=128, causal=False)]
    unique = {json.dumps(c, sort_keys=True): c for c in boundaries}
    for i, c in enumerate(unique.values()):
        error = verify(c)
        report["boundaries"].append(dict(config=c, max_abs_error=error))
        save()
        print("boundary", i, error, flush=True)

    extremes = [cfg(64, d=32), cfg(256, h=2), cfg(512, b=2, h=2),
        cfg(192, h=3), cfg(256, h=2, causal=False), cfg(1280, d=128),
        cfg(512, h=4, d=128, causal=False), cfg(2304), cfg(2304, causal=False)]
    for c in extremes:
        for scale in (None, 0.0, -0.1, 0.03125, 0.1):
            error = verify(c, scale, extreme=True)
            report["extreme_scales"].append(dict(config=c, scale=scale, max_abs_error=error))
            save()
            print("extreme", len(report["extreme_scales"]), scale, error, flush=True)

    tuning_shapes = [cfg(64, d=32), cfg(256, h=2), cfg(1280, d=128), cfg(2304)]
    overrides = [dict(q_preload=True), dict(q_preload=False), dict(q_frag=False),
        dict(q_frag=True), dict(q_frag_online=False), dict(late_normalize=False),
        dict(late_normalize=True), dict(num_stages=2), dict(kv_frag=True),
        dict(pair=2), dict(threads=128), dict(nmax=False), dict(stage_regs=False),
        dict(o_stage=True), dict(kv_reuse=False), dict(kv_split=True)]
    for c in tuning_shapes:
        default = device(module._get_kernel(*shape(c)))
        for override in overrides:
            outcomes = []
            for current in (parent, module):
                try:
                    outcomes.append(device(current._get_kernel(*shape(c), **override)))
                except Exception as error:
                    outcomes.append(dict(error_type=type(error).__name__, error=str(error).splitlines()[-1]))
            assert outcomes[0] == outcomes[1], (c, override, outcomes)
            report["tuning"].append(dict(config=c, override=override, outcomes=outcomes))
            save()
        explicit = device(module._get_kernel(*shape(c), q_preload=True))
        assert explicit == device(parent._get_kernel(*shape(c), q_preload=True))
        assert default == device(module._get_kernel(*shape(c)))
        # Clearing the public compiled-kernel cache must also remove the
        # shortcut keys. A fresh request must produce the same device code.
        module._KERNEL_CACHE.clear()
        assert device(module._get_kernel(*shape(c), q_preload=True)) == explicit
        after = device(module._get_kernel(*shape(c)))
        assert default == after
        report["cache_order"].append(dict(config=c, default=default,
            explicit=explicit, after_clear=after, both_request_orders_equal=True))
        save()
        print("tuning", c, "PASS", flush=True)

    runtime = ctypes.CDLL("/opt/maca/lib/libmcruntime.so")
    pointer = ctypes.c_void_p()
    assert runtime.mcStreamCreate(ctypes.byref(pointer)) == 0
    stream = torch.cuda.ExternalStream(pointer.value)
    torch.cuda.graph.default_capture_stream = stream
    live_shapes = tuning_shapes + [cfg(512, b=2, h=2), cfg(192, h=3),
        cfg(1024, b=8, d=128, bs=32), cfg(1024, b=4, s=8)]
    for c in live_shapes:
        inputs = list(make_inputs(c, seed=7))
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
                inputs[changed].copy_(make_inputs(c, seed=800+step)[changed])
            else:
                inputs[3].copy_(helpers.prior.adversarial_indices(inputs[3], c["block_size"], extreme=step==5))
            expected = sparse_reference(*inputs, c["block_size"], c["is_causal"], 0.1)
            out.fill_(float("nan"))
            graph.replay()
            torch.cuda.synchronize()
            graph_error = check_output(out, expected, "same-address graph update")
            out.fill_(float("nan"))
            module.run_kernel(*call_args)
            direct_error = check_output(out, expected, "same-address direct update")
            report["live_inputs"].append(dict(config=c, step=step, changed_input=changed,
                graph_max_abs_error=graph_error, direct_max_abs_error=direct_error))
            save()
        del graph
        print("live", c, "PASS", flush=True)

    guarded = helpers.prior.guarded_module(Path(args.module).resolve())
    for c in live_shapes + [cfg(129, h=2, causal=False), cfg(1280, d=128, causal=False)]:
        error = verify(c, 0.1, extreme=True, current=guarded)
        report["restricted_host"].append(dict(config=c, max_abs_error=error))
        save()
    assert source_hash == hashlib.sha256(Path(args.module).read_bytes()).hexdigest()
    report["status"] = "PASS"
    save()
    print("PASS", {key: len(report[key]) for key in
        ("boundaries", "extreme_scales", "tuning", "cache_order", "live_inputs", "restricted_host")}, flush=True)


if __name__ == "__main__":
    main()
