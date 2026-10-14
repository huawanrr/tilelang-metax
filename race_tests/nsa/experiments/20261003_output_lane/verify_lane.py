"""Validate the new D32 domain, shared dependency, fallbacks and live inputs."""
import argparse
import ast
import ctypes
import hashlib
import importlib.util
import inspect
import json
from pathlib import Path
import re
import sys

import torch

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module
from kernel_source import get_kernel_source
from verify_nsa import check_case
from probe_extremes import extreme_indices

spec = importlib.util.spec_from_file_location("lane_verification_helpers",
    ROOT / "experiments/20261002_tuning/verify_candidate.py")
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)
compile_case, edge_indices = helpers.compile_case, helpers.edge_indices
parts, flags, shared_bytes = helpers.parts, helpers.flags, helpers.shared_bytes


def cfg(t, b=1, h=1, causal=True, d=32, s=1, bs=16):
    return dict(B=b, SEQ_LEN=t, H=h, HQ=16*h, D=d, S=s,
                block_size=bs, is_causal=causal)


def selected(case, config):
    return (case["S"] == 1 and case["D"] == 32 and case["block_size"] == 16
        and case["HQ"] == 16*case["H"]
        and case["B"]*case["H"]*case["SEQ_LEN"] >= config["min_grid"]
        and case["SEQ_LEN"] >= config.get("min_seq", 1)
        and (not config.get("complete_blocks_only") or case["SEQ_LEN"] % 16 == 0)
        and (not config.get("causal_only") or case["is_causal"])
        and (config.get("heads") is None or case["H"] in config["heads"]))


def boundary_cases(config):
    cases = []
    for b, h in ((1, 1), (2, 1), (8, 1), (16, 1), (64, 1), (512, 1), (1, 2), (1, 4), (1, 8)):
        length = max(1, (config["min_grid"] + b*h-1)//(b*h))
        cases += [cfg(max(1, length+delta), b=b, h=h) for delta in (-1, 0, 1)]
    if config.get("min_seq", 1) > 1:
        length = config["min_seq"]
        b = (config["min_grid"] + length-1)//length + 1
        cases += [cfg(length+delta, b=b) for delta in (-1, 0, 1)]
    cases += [cfg(8192, causal=False), cfg(1024, b=8, causal=False),
        cfg(1025, b=8, causal=False), cfg(4096, h=2, causal=False),
        cfg(513, b=16, causal=False), cfg(32768), cfg(1024, b=8, h=2),
        cfg(512, d=64), cfg(1024, d=128), cfg(256, d=128),
        cfg(1024, b=8, d=128, bs=32), cfg(4096, d=64, s=2),
        cfg(4096, d=64, s=8), cfg(129, d=64, s=4), cfg(1024, b=8, bs=32)]
    grouped = cfg(8192)
    grouped["HQ"] = 32
    cases.append(grouped)
    return list({json.dumps(case, sort_keys=True): case for case in cases}.values())


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


@torch.no_grad()
def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--directory", required=True)
    p.add_argument("--output", required=True)
    p.add_argument("--resume", action="store_true")
    a = p.parse_args()
    torch.backends.cuda.matmul.allow_tf32 = False
    directory = Path(a.directory).resolve()
    config = json.loads((directory / "assembly.json").read_text())["config"]
    paths = [directory / "nsa.py", directory / "submission.py",
             ROOT / "experiments/20261003_d128_v1/nsa.py", ROOT / config["probe"]]
    dev, trial, base, probe = [load_module(str(path)) for path in paths]
    for name in ("run_kernel", "native_sparse_attention"):
        assert inspect.signature(getattr(trial, name)) == inspect.signature(getattr(base, name))
    output = Path(a.output)
    hashes = {str(path.relative_to(ROOT)): digest(path) for path in paths}
    report = dict(command=sys.argv, status="running", boundaries=[], sources=[],
        extremes=[], fallbacks=[], unsupported=[], refresh=[], guarded=[],
        source_sha256=hashes, reference_matmul_tf32=False, official_sandbox=False)
    if a.resume:
        previous = json.loads(output.read_text())
        assert previous["source_sha256"] == hashes and previous["status"] == "running"
        previous.setdefault("command_history", [previous["command"]]).append(sys.argv)
        report = previous
    else:
        assert not output.exists()

    def persist():
        output.write_text(json.dumps(report, indent=2) + "\n")

    cases = boundary_cases(config)
    report["expected_boundary_count"] = len(cases)
    persist()
    for i, case in enumerate(cases):
        if i < len(report["boundaries"]):
            assert report["boundaries"][i]["config"] == case
            continue
        active = selected(case, config)
        error = check_case(trial, case, 9301+i, None,
            lambda idx, bs=case["block_size"]: edge_indices(idx, bs))
        kernels = [compile_case(mod, case) for mod in (trial, dev, probe if active else base)]
        sources = [get_kernel_source(kernel) for kernel in kernels]
        assert sources[0] == sources[1] == sources[2], (case, "source mismatch")
        assert flags(kernels[0]) == flags(kernels[1]) == flags(kernels[2])
        audits = []
        for part in parts(kernels[0]):
            source = part.get_kernel_source()
            assert not any(token in source for token in ("memcpy_async", "cp.async", "maca_async", "tma_load", "mbarrier"))
            assert not any(value for key, value in part.pass_configs.items()
                if "disable_data_race" in str(key) or "disable_safe_memory" in str(key))
            size, method, host_hash = shared_bytes(part)
            audits.append(dict(source_sha256=hashlib.sha256(source.encode()).hexdigest(),
                wave_barriers=source.count("__syncwarp("), block_barriers=source.count("__syncthreads("),
                shared_bytes=size, shared_evidence=method, host_source_sha256=host_hash,
                launch_bounds=re.findall(r"__launch_bounds__\((\d+),", source)))
            if active:
                assert all(marker in source for marker in ("selected_block", "output_words", "output_halves", "__shfl_sync"))
                assert not any(value for key, value in part.pass_configs.items()
                    if "disable_thread_storage_sync" in str(key).lower())
        if active:
            assert len(audits) == 1
            assert audits[0]["shared_bytes"] == 1024
            assert audits[0]["wave_barriers"] == 0 and audits[0]["block_barriers"] == 1
            assert audits[0]["launch_bounds"] == ["64"]
        report["boundaries"].append(dict(config=case, active=active, max_abs_error=error, both_interfaces=True))
        report["sources"].append(dict(config=case, active=active, parts=audits,
            compile_flags=flags(kernels[0]), probe_or_baseline_equal=True))
        persist()
        print("BOUNDARY PASS", i, active, case, error, flush=True)

    knobs_list = [dict(q_preload=False), dict(kv_reuse=False), dict(nmax=False),
        dict(stage_regs=False), dict(kv_split=True), dict(q_frag=True), dict(o_stage=True),
        dict(kv_frag=True), dict(min_blocks=1), dict(pair=2), dict(num_stages=2),
        dict(online_unroll=1), dict(late_normalize=True), dict(threads=128)]
    for case in (cfg(8192), cfg(2048, b=4, h=2)):
        for knobs in knobs_list:
            if any(row["config"] == case and row["knobs"] == knobs
                   for row in report["fallbacks"] + report["unsupported"]):
                continue
            try:
                old = compile_case(base, case, **knobs)
            except Exception as before:
                kind, reason = type(before).__name__, str(before).splitlines()[-1]
                try:
                    compile_case(trial, case, **knobs)
                except Exception as after:
                    assert type(after).__name__ == kind and str(after).splitlines()[-1] == reason
                else:
                    raise AssertionError("Baseline compilation failure must be preserved")
                report["unsupported"].append(dict(config=case, knobs=knobs,
                    same_baseline_failure=True, error_type=kind, reason=reason))
            else:
                new = compile_case(trial, case, **knobs)
                assert get_kernel_source(old) == get_kernel_source(new), (case, knobs)
                assert flags(old) == flags(new)
                report["fallbacks"].append(dict(config=case, knobs=knobs, source_and_flags_equal=True))
            persist()
    print("FALLBACK PASS", len(report["fallbacks"]), flush=True)

    active_cases = [case for case in cases if selected(case, config)]
    assert len(active_cases) >= 6
    extreme_cases = active_cases[:3] + active_cases[-3:]
    for i, case in enumerate(extreme_cases):
        if i < len(report["extremes"]):
            continue
        error = check_case(trial, case, 9401, None, extreme_indices)
        report["extremes"].append(dict(config=case, max_abs_error=error, both_interfaces=True))
        persist()
        print("EXTREME PASS", case, error, flush=True)

    runtime = ctypes.CDLL("/opt/maca/lib/libmcruntime.so")
    pointer = ctypes.c_void_p()
    assert runtime.mcStreamCreate(ctypes.byref(pointer)) == 0
    stream = torch.cuda.ExternalStream(pointer.value)
    torch.cuda.graph.default_capture_stream = stream
    live_cases = [active_cases[0], active_cases[1], active_cases[-2], active_cases[-1],
                  cfg(1024, d=128), cfg(4096, d=64, s=8)]
    for case in live_cases:
        if sum(row["config"] == case for row in report["refresh"]) == 3:
            continue
        q, k, v, indices = make_inputs(case, seed=9501)
        indices.copy_(edge_indices(indices, case["block_size"]))
        factory = trial.native_sparse_attention(case["B"], case["HQ"], case["SEQ_LEN"],
            case["D"], case["is_causal"], scale=0.07, block_size=case["block_size"],
            groups=16, selected_blocks=case["S"])
        out = torch.empty_like(q)
        args = (q, k, v, indices, out, case["B"], case["SEQ_LEN"], case["H"],
            case["HQ"], case["D"], case["S"], case["block_size"], case["is_causal"], 0.07)
        trial.run_kernel(*args)
        stream.wait_stream(torch.cuda.current_stream())
        stream.synchronize()
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph, stream=stream):
            trial.run_kernel(*args)
        addresses = [tensor.data_ptr() for tensor in (q, k, v, indices, out)]
        for iteration in range(3):
            if iteration:
                nq, nk, nv, _ = make_inputs(case, seed=9501+iteration)
                q.copy_(nq)
                k.copy_(nk)
                v.copy_(nv)
                indices.copy_(indices.roll(1, dims=1))
            if any(row["config"] == case and row["iteration"] == iteration for row in report["refresh"]):
                continue
            assert addresses == [tensor.data_ptr() for tensor in (q, k, v, indices, out)]
            expected = sparse_reference(q, k, v, indices, case["block_size"], case["is_causal"], 0.07)
            out.fill_(float("nan"))
            graph.replay()
            error = max(check_output(out, expected, "live graph"),
                        check_output(factory(q, k, v, indices), expected, "live factory"))
            report["refresh"].append(dict(config=case, iteration=iteration, max_abs_error=error,
                same_addresses=True, graph_replay=True, both_interfaces=True))
            persist()
        del graph
        print("REFRESH PASS", case, flush=True)

    fixture = ROOT / "experiments/20260928_guard_fix/check_restricted_host.py"
    tree = ast.parse(fixture.read_text())
    cutoff = next(i for i, node in enumerate(tree.body) if isinstance(node, ast.Assign)
        and any(isinstance(target, ast.Name) and target.id == "small" for target in node.targets))
    env = dict(__file__=str(fixture), __name__="lane_guard_fixture")
    exec(compile(ast.Module(body=tree.body[:cutoff], type_ignores=[]), str(fixture), "exec"), env)
    guarded = env["guarded_module"](str(paths[1]))
    for i, case in enumerate(live_cases):
        if i < len(report["guarded"]):
            continue
        error = check_case(guarded, case, 9601, None,
            lambda idx, bs=case["block_size"]: edge_indices(idx, bs))
        report["guarded"].append(dict(config=case, max_abs_error=error, both_interfaces=True))
        persist()
        print("GUARDED PASS", case, error, flush=True)
    report["status"] = "PASS"
    persist()
    print("PASS", {key: len(report[key]) for key in
        ("boundaries", "sources", "extremes", "fallbacks", "unsupported", "refresh", "guarded")}, flush=True)


if __name__ == "__main__":
    main()
