"""Check bit-exact packing, tails, both APIs, tuning, and live graph inputs."""
import argparse
import ctypes
import hashlib
import importlib.util
import inspect
import json
from pathlib import Path
import sys

import numpy as np
import torch

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module
from verify_nsa import check_case

spec = importlib.util.spec_from_file_location("nsa_v5_validation_helpers",
    ROOT / "experiments/20261008_resume8857/verify_candidate.py")
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)


def cfg(t, b=1, h=1, causal=True):
    return dict(B=b, SEQ_LEN=t, H=h, HQ=16*h, D=128, S=1,
                block_size=32, is_causal=causal)


def packed_reference(raw, bs, kind):
    b, t, h, d = raw.shape
    nb = (t + bs - 1) // bs
    padded = np.zeros((b, nb * bs, h, d), dtype=np.uint16)
    padded[:, :t] = raw
    if kind == "K":
        return padded.reshape(b, nb, bs // 16, 16, h, d // 32, 4, 8).transpose(
            0, 1, 4, 5, 2, 6, 3, 7).reshape(b, nb, h, d // 32, bs // 16, 64, 8)
    return padded.reshape(b, nb, bs // 16, 4, 4, h, d // 32, 2, 16).transpose(
        0, 1, 5, 2, 6, 3, 8, 7, 4).reshape(b, nb, h, bs // 16, d // 32, 64, 8)


@torch.no_grad()
def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("module")
    parser.add_argument("--baseline", default=str(ROOT / "experiments/20261008_resume8871/parent.py"))
    parser.add_argument("--builder", default="native_sparse_attention_pack_kv_bs32_tiles")
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    output_path = Path(args.output)
    assert not output_path.exists()
    module, baseline = load_module(args.module), load_module(args.baseline)
    for name in ("native_sparse_attention", "run_kernel"):
        assert inspect.signature(getattr(module, name)) == inspect.signature(getattr(baseline, name))
    torch.backends.cuda.matmul.allow_tf32 = False
    report = dict(status="running", command=sys.argv,
        module_sha256=hashlib.sha256(Path(args.module).read_bytes()).hexdigest(),
        harness_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        reference_tf32=False, official_sandbox=False,
        bit_packing=[], boundaries=[], extremes=[], tuning=[], cache_order=[],
        live_inputs=[], restricted_host=[], attention_unchanged=[], dispatch=[])

    def save():
        output_path.write_text(json.dumps(report, indent=2) + "\n")

    packing_cases = [cfg(t) for t in (1, 15, 16, 17, 31, 32, 33, 37, 63, 64, 65)]
    packing_cases += [cfg(37, b=2, h=2), cfg(65, h=4), cfg(257, h=4),
                      cfg(513, b=2, h=2), cfg(1024, b=4), cfg(1025, b=4)]
    for index, case in enumerate(packing_cases):
        generator = np.random.default_rng(89000 + index)
        shape = (case["B"], case["SEQ_LEN"], case["H"], case["D"])
        raw = [generator.integers(0, 65536, size=shape, dtype=np.uint16) for _ in range(2)]
        # MetaX's CPU-to-GPU copy can choose channels-last for a four-dimensional
        # int16 tensor. Match the public kernel's contiguous input contract.
        inputs = [torch.from_numpy(x.view(np.int16)).cuda().contiguous().view(torch.float16) for x in raw]
        assert all(x.is_contiguous() for x in inputs)
        expected = [packed_reference(x, 32, kind) for x, kind in zip(raw, ("K", "V"))]
        outputs = [torch.full(x.shape, float("nan"), device="cuda", dtype=torch.float16) for x in expected]
        pack = getattr(module, args.builder)(case["B"], case["SEQ_LEN"], case["H"], 128, 32)
        pack(*inputs, *outputs)
        torch.cuda.synchronize()
        for kind, actual, reference in zip(("K", "V"), outputs, expected):
            observed = actual.view(torch.int16).cpu().numpy().view(np.uint16)
            assert np.array_equal(observed, reference), (case, kind, np.count_nonzero(observed != reference))
        metadata = helpers.device(pack)
        assert pack.get_kernel_source().count("__syncwarp()") == 1
        assert "__syncthreads()" not in pack.get_kernel_source()
        report["bit_packing"].append(dict(config=case, seed=89000+index,
            checked_half_values=sum(x.size for x in expected), bit_exact=True, device=metadata))
        print("bit packing", index, "PASS", flush=True)
        save()

    boundaries = [cfg(1024, b=4), cfg(1025, b=4), cfg(1023, b=4), cfg(512, h=2),
                  cfg(513, b=2, h=2), cfg(257, h=4), cfg(1024, h=4), cfg(1024, b=8),
                  cfg(1024, b=8, h=2), cfg(256, h=2), cfg(255, h=4), cfg(256, h=4),
                  cfg(8191), cfg(8192), cfg(8193), cfg(1025, b=8),
                  cfg(16, b=64), cfg(64, b=8, h=2), cfg(32, b=8, h=4), cfg(128, b=4, h=2)]
    for case in boundaries:
        for causal in (False, True):
            case = dict(case, is_causal=causal)
            error = check_case(module, case, 61, 0.1,
                lambda indices: helpers.prior.adversarial_indices(indices, 32, extreme=True))
            report["boundaries"].append(dict(config=case, max_abs_error=error))
            current = helpers.parts(module._get_kernel(*helpers.shape(case)))
            prior = helpers.parts(baseline._get_kernel(*helpers.shape(case)))
            if len(current) == len(prior) == 2:
                assert current[1].get_kernel_source() == prior[1].get_kernel_source()
                assert list(current[1].compile_flags or []) == list(prior[1].compile_flags or [])
                grid = case["B"] * case["H"] * case["SEQ_LEN"]
                source_blocks = case["B"] * case["H"] * ((case["SEQ_LEN"] + 31) // 32)
                original_direct = case["H"] == 1 and case["SEQ_LEN"] >= 64 and grid < 4096
                expected_tiled = not original_direct and source_blocks <= 256
                if expected_tiled:
                    expected_pack = getattr(module, args.builder)(case["B"], case["SEQ_LEN"], case["H"], 128, 32)
                    assert current[0].get_kernel_source() == expected_pack.get_kernel_source()
                else:
                    assert current[0].get_kernel_source() == prior[0].get_kernel_source()
                report["dispatch"].append(dict(config=case, source_blocks=source_blocks,
                    expected_tiled=expected_tiled, original_direct=original_direct))
                report["attention_unchanged"].append(dict(config=case,
                    device_source_sha256=hashlib.sha256(current[1].get_kernel_source().encode()).hexdigest()))
            helpers.device(module._get_kernel(*helpers.shape(case)))
            save()
        print("boundary", case, "PASS", flush=True)

    for case in [cfg(1024, b=4), cfg(1025, b=4), cfg(512, h=2), cfg(513, b=2, h=2), cfg(257, h=4)]:
        for causal in (False, True):
            case = dict(case, is_causal=causal)
            for scale in (None, 0.0, -0.1, 0.03125, 0.1):
                error = check_case(module, case, 2026, scale,
                    lambda indices: helpers.prior.adversarial_indices(indices, 32, extreme=True))
                report["extremes"].append(dict(config=case, scale=scale, max_abs_error=error))
                save()
        print("extremes", case, "PASS", flush=True)

    overrides = [dict(stage_regs=False), dict(kv_reuse=False), dict(o_stage=True),
        dict(q_preload=False), dict(q_preload=True), dict(q_frag=False), dict(q_frag=True),
        dict(nmax=False), dict(num_stages=2), dict(online_unroll=1), dict(min_blocks=1),
        dict(pair=2), dict(late_normalize=True), dict(late_normalize=False),
        dict(threads=128), dict(kv_split=True), dict(q_frag_online=False)]
    for case in [cfg(1024, b=8), cfg(512, h=2)]:
        before = helpers.device(module._get_kernel(*helpers.shape(case)))
        for override in overrides:
            outcomes = []
            for impl in (baseline, module):
                try:
                    outcomes.append(helpers.device(impl._get_kernel(*helpers.shape(case), **override)))
                except Exception as error:
                    outcomes.append(dict(error_type=type(error).__name__, error=str(error).splitlines()[-1]))
            assert outcomes[0] == outcomes[1], (case, override, outcomes)
            report["tuning"].append(dict(config=case, override=override, outcomes=outcomes))
            save()
        after = helpers.device(module._get_kernel(*helpers.shape(case)))
        assert before == after
        report["cache_order"].append(dict(config=case, default_before=before, default_after=after))
        print("tuning", case, "PASS", flush=True)
        save()

    runtime = ctypes.CDLL("/opt/maca/lib/libmcruntime.so")
    pointer = ctypes.c_void_p()
    assert runtime.mcStreamCreate(ctypes.byref(pointer)) == 0
    stream = torch.cuda.ExternalStream(pointer.value)
    torch.cuda.graph.default_capture_stream = stream
    live_cases = [cfg(1024, b=4), cfg(512, h=2), cfg(1025, b=4), cfg(513, b=2, h=2)]
    for case in live_cases:
        inputs = list(make_inputs(case, seed=777))
        output = torch.empty_like(inputs[0])
        call_args = (*inputs, output, *helpers.shape(case))
        module.run_kernel(*call_args)
        stream.wait_stream(torch.cuda.current_stream())
        stream.synchronize()
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph, stream=stream):
            module.run_kernel(*call_args)
        for step, changed in enumerate((0, 1, 2, 3, 1, 2, 3)):
            if changed < 3:
                inputs[changed].copy_(make_inputs(case, seed=8800+step)[changed])
            else:
                inputs[3].copy_(helpers.prior.adversarial_indices(inputs[3], 32, extreme=step == 6))
            expected = sparse_reference(*inputs, 32, case["is_causal"], 0.1)
            output.fill_(float("nan"))
            graph.replay()
            torch.cuda.synchronize()
            error = check_output(output, expected, "packed graph same-address update")
            report["live_inputs"].append(dict(config=case, step=step, changed_input=changed, max_abs_error=error))
            save()
        del graph
        print("live inputs", case, "PASS", flush=True)

    guarded = helpers.prior.guarded_module(Path(args.module).resolve())
    for case in live_cases:
        error = check_case(guarded, case, 61, 0.1,
            lambda indices: helpers.prior.adversarial_indices(indices, 32, extreme=True))
        report["restricted_host"].append(dict(config=case, max_abs_error=error))
        save()
    report["status"] = "PASS"
    save()
    print("PASS", {key: len(value) for key, value in report.items() if isinstance(value, list)}, flush=True)


if __name__ == "__main__":
    main()
