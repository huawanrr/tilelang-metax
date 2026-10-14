"""Check new path boundaries, extreme indices/scales, tuning and live inputs."""
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

spec = importlib.util.spec_from_file_location("nsa_oct8_test_helpers",
    ROOT / "experiments/20261005_goal8929/verify_candidate.py")
prior = importlib.util.module_from_spec(spec)
spec.loader.exec_module(prior)


def cfg(n, b=1, h=1, d=64, s=1, bs=16, causal=True):
    return dict(B=b, SEQ_LEN=n, H=h, HQ=h*16, D=d, S=s, block_size=bs, is_causal=causal)


def shape(c, scale=0.1):
    return (c["B"], c["SEQ_LEN"], c["H"], c["HQ"], c["D"], c["S"],
            c["block_size"], c["is_causal"], scale)


def parts(kernel):
    if inspect.isfunction(kernel):
        values = inspect.getclosurevars(kernel).nonlocals
        if "pack" in values and "attention" in values:
            return [values["pack"], values["attention"]]
    return [kernel]


def device(kernel):
    compiled = parts(kernel)
    for item in compiled:
        assert not any(value for key, value in item.pass_configs.items()
                       if "disable_data_race" in str(key) or "disable_safe_memory" in str(key))
        assert not any(marker in item.get_kernel_source() for marker in
                       ("memcpy_async", "cp.async", "maca_async", "tma_load", "mbarrier"))
    return dict(hashes=[hashlib.sha256(k.get_kernel_source().encode()).hexdigest() for k in compiled],
                flags=[list(k.compile_flags or []) for k in compiled])


@torch.no_grad()
def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("module")
    p.add_argument("--output", required=True)
    a = p.parse_args()
    mod = load_module(a.module)
    base = load_module(str(ROOT / "experiments/20261007_exp_math/release_v1/submission.py"))
    for name in ("native_sparse_attention", "run_kernel"):
        assert inspect.signature(getattr(mod, name)) == inspect.signature(getattr(base, name))
    torch.backends.cuda.matmul.allow_tf32 = False
    report = dict(command=sys.argv, status="running", source_sha256=hashlib.sha256(Path(a.module).read_bytes()).hexdigest(),
        harness_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(), tf32=False, official_sandbox=False,
        boundaries=[], extreme_scales=[], tuning=[], cache_order=[], live_inputs=[], restricted_host=[])

    def save():
        Path(a.output).write_text(json.dumps(report, indent=2) + "\n")

    def verify(c, scale, extreme=False, module=mod):
        return check_case(module, c, 61, scale,
            lambda indices: prior.adversarial_indices(indices, c["block_size"], extreme))

    boundaries = [cfg(n, d=32) for n in (16, 64, 128, 176, 192, 193, 208)]
    boundaries += [cfg(96, b=2, d=32), cfg(96, h=2, d=32)]
    boundaries += [cfg(n) for n in (63, 64, 127, 128, 129, 256, 272, 496, 512, 528)]
    boundaries += [cfg(64, b=b) for b in (2, 3, 4, 8)] + [cfg(96, b=2), cfg(128, b=2)]
    boundaries += [cfg(n, d=128) for n in (128, 144, 192, 256, 752, 768)]
    boundaries += [cfg(80, b=2, d=128), cfg(128, h=2, d=128)]
    boundaries += [cfg(n, s=2) for n in (63, 64, 65, 1024, 1025)]
    boundaries += [cfg(512, b=2, s=2), cfg(513, b=2, s=2), cfg(256, h=3, s=2)]
    boundaries += [cfg(n, b=2, s=4) for n in (127, 128, 129, 384, 512, 513, 768, 784, 1024)]
    boundaries += [cfg(512, h=2, s=4, causal=False), cfg(256, b=4, s=4)]
    boundaries += [cfg(n, h=2) for n in (256, 512, 1024)]
    for index, c in enumerate(boundaries):
        error = verify(c, 0.1)
        report["boundaries"].append(dict(config=c, max_abs_error=error))
        print("boundary", index, error, flush=True)
        save()

    extremes = [cfg(64, d=32), cfg(128), cfg(256, d=128), cfg(512, b=2),
        cfg(256, s=2), cfg(65, s=2, causal=False), cfg(512, b=2, s=4),
        cfg(512, h=2, s=4, causal=False), cfg(512, b=2, h=2)]
    for c in extremes:
        for scale in (None, 0.0, -0.1, 0.03125, 0.1):
            error = verify(c, scale, extreme=True)
            report["extreme_scales"].append(dict(config=c, scale=scale, max_abs_error=error))
            print("extreme", len(report["extreme_scales"]), scale, error, flush=True)
            save()

    known = [cfg(64, d=32), cfg(128), cfg(256, d=128),
        cfg(512, b=2), cfg(256, s=2), cfg(512, b=2, s=4)]
    overrides = [dict(stage_regs=False), dict(kv_reuse=False), dict(o_stage=True),
        dict(q_preload=False), dict(q_preload=True), dict(q_frag=False), dict(q_frag=True),
        dict(nmax=False), dict(num_stages=2), dict(online_unroll=1), dict(min_blocks=1),
        dict(pair=2), dict(late_normalize=True), dict(late_normalize=False),
        dict(threads=128), dict(kv_split=True), dict(q_frag_online=False)]
    for c in known:
        default_before = device(mod._get_kernel(*shape(c)))
        for override in overrides:
            outcomes = []
            for module in (base, mod):
                try:
                    outcomes.append(device(module._get_kernel(*shape(c), **override)))
                except Exception as error:
                    outcomes.append(dict(error_type=type(error).__name__, error=str(error).splitlines()[-1]))
            assert outcomes[0] == outcomes[1], (c, override, outcomes)
            report["tuning"].append(dict(config=c, override=override, outcomes=outcomes))
            save()
        default_after = device(mod._get_kernel(*shape(c)))
        assert default_before == default_after
        explicit_default = device(mod._get_kernel(*shape(c), q_preload=True))
        assert explicit_default == device(base._get_kernel(*shape(c), q_preload=True))
        assert explicit_default != default_before
        report["cache_order"].append(dict(config=c, default_before=default_before,
                                         explicit_default=explicit_default, default_after=default_after))
        print("tuning", c, "PASS", flush=True)
        save()

    runtime = ctypes.CDLL("/opt/maca/lib/libmcruntime.so")
    pointer = ctypes.c_void_p()
    assert runtime.mcStreamCreate(ctypes.byref(pointer)) == 0
    stream = torch.cuda.ExternalStream(pointer.value)
    torch.cuda.graph.default_capture_stream = stream
    for c in known:
        inputs = list(make_inputs(c, seed=7))
        output = torch.empty_like(inputs[0])
        call_args = (*inputs, output, *shape(c))
        mod.run_kernel(*call_args)
        stream.wait_stream(torch.cuda.current_stream())
        stream.synchronize()
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph, stream=stream):
            mod.run_kernel(*call_args)
        for step, changed in enumerate((0, 1, 2, 3, 0, 3)):
            if changed < 3:
                inputs[changed].copy_(make_inputs(c, seed=400+step)[changed])
            else:
                inputs[3].copy_(prior.adversarial_indices(inputs[3], c["block_size"], extreme=step == 5))
            expected = sparse_reference(*inputs, c["block_size"], c["is_causal"], 0.1)
            output.fill_(float("nan"))
            graph.replay()
            torch.cuda.synchronize()
            error = check_output(output, expected, "same-address input update")
            report["live_inputs"].append(dict(config=c, step=step, changed_input=changed, max_abs_error=error))
            save()
        del graph
        print("live inputs", c, "PASS", flush=True)

    restricted = prior.guarded_module(Path(a.module).resolve())
    for c in known + [cfg(65, s=2, causal=False), cfg(513, b=2, s=4)]:
        error = verify(c, 0.1, extreme=True, module=restricted)
        report["restricted_host"].append(dict(config=c, max_abs_error=error))
        save()
    report["status"] = "PASS"
    save()
    print("PASS", {key: len(report[key]) for key in
        ("boundaries", "extreme_scales", "tuning", "cache_order", "live_inputs", "restricted_host")}, flush=True)


if __name__ == "__main__":
    main()
