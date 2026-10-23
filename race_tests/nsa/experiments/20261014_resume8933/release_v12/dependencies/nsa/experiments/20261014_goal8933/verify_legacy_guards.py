"""Exercise both repaired legacy builders, including explicit factory options."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

import torch

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module


def load_helper(name, path):
    spec = importlib.util.spec_from_file_location(name, path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


host = load_helper("legacy_host_helpers", ROOT / "experiments/20261012_goal89/check_public_cache_cpu.py")
checks = load_helper("legacy_input_helpers", ROOT / "experiments/20261005_goal8929/verify_candidate.py")


@torch.no_grad()
def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("module")
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    candidate_path = Path(args.module).resolve()
    baseline_path = HERE / "baseline.py"
    output = Path(args.output)
    assert not output.exists()
    source_hash = hashlib.sha256(candidate_path.read_bytes()).hexdigest()
    baseline, candidate = (load_module(str(p)) for p in (baseline_path, candidate_path))
    labels = host.host(candidate_path)[0]
    torch.backends.cuda.matmul.allow_tf32 = False
    rows = []
    for length, selected, causal, options, expected_builder in (
        (127, 4, True, {}, "native_sparse_attention_online_emitter"),
        (127, 4, False, {}, "native_sparse_attention_online_emitter"),
        (1536, 2, True, {}, "native_sparse_attention_short_list"),
        (1536, 2, False, {}, "native_sparse_attention_short_list"),
        (128, 2, True, {"q_preload": False}, "native_sparse_attention_short_list"),
        (512, 4, True, {"q_preload": False}, "native_sparse_attention_online_emitter"),
    ):
        config = dict(B=1, SEQ_LEN=length, H=1, HQ=16, D=64, S=selected,
                      block_size=16, is_causal=causal)
        shape = host.shape(config, 0.1)
        label = labels["_get_kernel"](*shape, **options).signature[0]
        assert label == expected_builder, (config, options, label)
        factories = [module.native_sparse_attention(
            1, 16, length, 64, causal, scale=0.1, block_size=16, groups=16,
            selected_blocks=selected, **options) for module in (baseline, candidate)]
        for extreme in (False, True):
            inputs = list(make_inputs(config, 61))
            inputs[3] = checks.adversarial_indices(inputs[3], 16, extreme)
            expected = sparse_reference(*inputs, 16, causal, 0.1)
            before, after = (factory(*inputs) for factory in factories)
            errors = {"factory": check_output(after, expected, "legacy factory")}
            direct = torch.full_like(after, float("nan"))
            candidate._get_kernel(*shape, **options)(
                *inputs[:3], candidate._as_int32(inputs[3]), direct)
            errors["compiled_callable"] = check_output(direct, expected, "legacy callable")
            if not options:
                direct.fill_(float("nan"))
                candidate.run_kernel(*inputs, direct, *shape)
                errors["run_kernel"] = check_output(direct, expected, "legacy run_kernel")
            baseline_error = float((before.float() - expected.float()).abs().max())
            baseline_pass = bool(torch.isclose(before.float(), expected.float(),
                rtol=1e-2, atol=1e-2).all())
            if not extreme:
                check_output(before, expected, "legacy ordinary baseline")
                assert torch.equal(before, after), (config, options, "ordinary outputs changed")
            rows.append(dict(config=config, options=options, builder=label, extreme=extreme,
                errors=errors, baseline_max_abs_error=baseline_error,
                baseline_pass=baseline_pass, ordinary_bitwise_equal=not extreme))
            print(label, length, causal, options, extreme, errors, flush=True)
    assert {r["builder"] for r in rows if r["extreme"] and not r["baseline_pass"]} == {
        "native_sparse_attention_online_emitter", "native_sparse_attention_short_list"}
    assert hashlib.sha256(candidate_path.read_bytes()).hexdigest() == source_hash
    with output.open("x") as file:
        json.dump(dict(status="PASS", source_sha256=source_hash,
            baseline_sha256=hashlib.sha256(baseline_path.read_bytes()).hexdigest(),
            rows=rows), file, indent=2)
        file.write("\n")
    print("PASS", len(rows), flush=True)


if __name__ == "__main__":
    main()
