"""Check aligned-block dispatch, extreme indices, live inputs and host guards."""
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

spec = importlib.util.spec_from_file_location("nsa_block_helpers",
    ROOT / "experiments/20261002_tuning/verify_candidate.py")
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)
compile_case, edge_indices = helpers.compile_case, helpers.edge_indices
parts, flags, shared_bytes = helpers.parts, helpers.flags, helpers.shared_bytes


def cfg(t, d=64, b=1, h=1, causal=True, bs=16, s=1):
    return dict(B=b, SEQ_LEN=t, H=h, HQ=16*h, D=d, S=s,
                block_size=bs, is_causal=causal)


def selected(case, config):
    grid = case["B"] * case["H"] * case["SEQ_LEN"]
    return (case["S"] == 1 and case["D"] == 64 and case["block_size"] == 16
        and case["H"] == 1 and case["HQ"] == 16 and case["SEQ_LEN"] % 16 == 0
        and config["grid_min_exclusive"] < grid <= config["grid_max_inclusive"])



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
    assembly = json.loads((directory / "assembly.json").read_text())
    config = assembly["config"]
    paths = [directory / name for name in ("nsa.py", "submission.py")]
    dev, trial = [load_module(str(path)) for path in paths]
    base = load_module(str(ROOT / "experiments/20261002_blocks_v2/submission.py"))
    probe = load_module(str(ROOT / assembly["config"]["probe"]))
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

    def persist():
        output.write_text(json.dumps(report, indent=2) + "\n")

    cases = [cfg(t, causal=t % 2 == 0) for t in
        (255, 256, 257, 271, 272, 273, 2032, 2047, 2048, 2049, 2064, 2065)]
    cases += [cfg(16, b=32), cfg(32, b=32), cfg(48, b=32), cfg(64, b=8),
        cfg(80, b=16), cfg(112, b=16), cfg(128, b=16), cfg(256, b=2),
        cfg(512, b=2), cfg(1280, causal=False), cfg(272, causal=False),
        cfg(256, h=2), cfg(512, b=2, h=2), cfg(256, b=2, h=4),
        cfg(2304), cfg(1280, d=128), cfg(768, d=32),
        cfg(1024, d=128, b=8, bs=32), cfg(4096, s=2), cfg(4096, s=8), cfg(129, s=4)]
    grouped = cfg(1280, d=128)
    grouped["HQ"] = 32
    cases.append(grouped)
    persist()
    for i, case in enumerate(cases):
        active = selected(case, config)
        if i < len(report["boundaries"]):
            assert report["boundaries"][i]["config"] == case
            continue
        error = check_case(trial, case, 4101+i, None,
            lambda idx, bs=case["block_size"]: edge_indices(idx, bs))
        kernels = [compile_case(module, case) for module in (trial, dev, probe if active else base)]
        sources = [get_kernel_source(kernel) for kernel in kernels]
        assert sources[0] == sources[1] == sources[2], (case, "probe/baseline source mismatch")
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
                assert "K_blocks" in source and "V_blocks" in source
                assert "*(uint1*)(K_reg" in source and "*(uint1*)(V_reg" in source
        if active:
            assert len(audits) == 1
            assert audits[0]["shared_bytes"] == 16 * case["D"] * 2
            assert audits[0]["wave_barriers"] == 5 and audits[0]["block_barriers"] == 0
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
    for case in (cfg(512), cfg(2048)):
        for knobs in knobs_list:
            if any(row["config"] == case and row["knobs"] == knobs
                   for row in report["fallbacks"] + report["unsupported"]):
                continue
            try:
                old = compile_case(base, case, **knobs)
            except Exception as before:
                error_type, reason = type(before).__name__, str(before).splitlines()[-1]
                try:
                    compile_case(trial, case, **knobs)
                except Exception as after:
                    assert type(after).__name__ == error_type
                    assert str(after).splitlines()[-1] == reason
                else:
                    raise AssertionError("The baseline compilation failure must be preserved")
                report["unsupported"].append(dict(config=case, knobs=knobs,
                    same_baseline_failure=True, error_type=error_type, reason=reason))
            else:
                new = compile_case(trial, case, **knobs)
                assert get_kernel_source(old) == get_kernel_source(new), (case, knobs)
                assert flags(old) == flags(new)
                report["fallbacks"].append(dict(config=case, knobs=knobs, source_and_flags_equal=True))
            persist()
    print("FALLBACK PASS", len(report["fallbacks"]), flush=True)

    extreme_cases = [cfg(272), cfg(512, causal=False), cfg(2032),
                     cfg(16, b=32), cfg(64, b=16), cfg(128, b=8, causal=False)]
    for i, case in enumerate(extreme_cases):
        if i < len(report["extremes"]):
            continue
        assert selected(case, config)
        error = check_case(trial, case, 4301, None,
            lambda idx: helpers.extreme_indices(idx, 16))
        report["extremes"].append(dict(config=case, max_abs_error=error, both_interfaces=True))
        persist()
        print("EXTREME PASS", case, error, flush=True)

    runtime = ctypes.CDLL("/opt/maca/lib/libmcruntime.so")
    pointer = ctypes.c_void_p()
    assert runtime.mcStreamCreate(ctypes.byref(pointer)) == 0
    stream = torch.cuda.ExternalStream(pointer.value)
    torch.cuda.graph.default_capture_stream = stream
    live_cases = [cfg(512), cfg(1280, causal=False), cfg(16, b=32),
                  cfg(2032), cfg(2304), cfg(4096, s=8)]
    for case in live_cases:
        if sum(row["config"] == case for row in report["refresh"]) == 3:
            continue
        q, k, v, indices = make_inputs(case, seed=4401)
        indices.copy_(edge_indices(indices, case["block_size"]))
        factory = trial.native_sparse_attention(case["B"], case["HQ"], case["SEQ_LEN"],
            case["D"], case["is_causal"], scale=0.07, block_size=case["block_size"],
            groups=16, selected_blocks=case["S"])
        out = torch.empty_like(q)
        call_args = (q, k, v, indices, out, case["B"], case["SEQ_LEN"], case["H"],
            case["HQ"], case["D"], case["S"], case["block_size"], case["is_causal"], 0.07)
        trial.run_kernel(*call_args)
        stream.wait_stream(torch.cuda.current_stream())
        stream.synchronize()
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph, stream=stream):
            trial.run_kernel(*call_args)
        addresses = [tensor.data_ptr() for tensor in (q, k, v, indices, out)]
        for iteration in range(3):
            if iteration:
                nq, nk, nv, _ = make_inputs(case, seed=4401+iteration)
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
    env = dict(__file__=str(fixture), __name__="nsa_block_guard_fixture")
    exec(compile(ast.Module(body=tree.body[:cutoff], type_ignores=[]), str(fixture), "exec"), env)
    guarded = env["guarded_module"](str(paths[1]))
    for i, case in enumerate(live_cases):
        if i < len(report["guarded"]):
            continue
        error = check_case(guarded, case, 4501, None,
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
