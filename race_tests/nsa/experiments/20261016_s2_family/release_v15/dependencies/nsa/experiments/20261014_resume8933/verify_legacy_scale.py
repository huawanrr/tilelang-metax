"""Check the repaired fallback against FP32, retaining parent failures."""
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

spec = importlib.util.spec_from_file_location("legacy_scale_inputs",
    ROOT / "experiments/20261005_goal8929/verify_candidate.py")
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)


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
    torch.backends.cuda.matmul.allow_tf32 = False
    report = dict(status="running", command=sys.argv, rows=[],
        sources={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in (path, parent_path)})
    for length, selected, heads, options in ((37, 2, 2, {}), (37, 4, 2, {}),
                                           (127, 4, 1, {}), (512, 4, 1, {"q_preload":False})):
        for causal in (True, False):
            c = dict(B=1, SEQ_LEN=length, H=heads, HQ=16*heads, D=64, S=selected,
                block_size=16, is_causal=causal)
            for scale in (None, 0.0, -0.1, 0.1):
                inputs = list(make_inputs(c, 61))
                inputs[3] = helpers.adversarial_indices(inputs[3], 16, True)
                expected = sparse_reference(*inputs, 16, causal, scale)
                args = (1, length, heads, 16*heads, 64, selected, 16, causal, scale)
                compiled = [m._get_kernel(*args, **options) for m in (parent, module)]
                factories = [m.native_sparse_attention(1, 16*heads, length, 64, causal,
                    scale=scale, block_size=16, groups=16, selected_blocks=selected, **options)
                    for m in (parent, module)]
                before, after = (fn(*inputs) for fn in factories)
                errors = dict(factory=check_output(after, expected, "repaired factory"))
                out = torch.full_like(after, float("nan"))
                compiled[1](*inputs[:3], module._as_int32(inputs[3]), out)
                errors["compiled_callable"] = check_output(out, expected, "repaired callable")
                if not options:
                    out.fill_(float("nan"))
                    module.run_kernel(*inputs, out, *args)
                    errors["run_kernel"] = check_output(out, expected, "repaired public")
                hashes = [hashlib.sha256(k.get_kernel_source().encode()).hexdigest() for k in compiled]
                positive = scale is None or scale > 0
                if positive:
                    assert hashes[0] == hashes[1], (c, scale, options, "positive device source changed")
                    assert torch.equal(before, after), (c, scale, options, "positive output changed")
                parent_pass = bool(torch.isclose(before.float(), expected.float(), atol=1e-2, rtol=1e-2).all())
                row = dict(config=c, scale=scale, options=options, errors=errors,
                    parent_pass=parent_pass, parent_max_abs_error=float((before.float()-expected.float()).abs().max()),
                    positive_device_source_equal=positive and hashes[0] == hashes[1],
                    positive_outputs_equal=positive and torch.equal(before, after), device_source_sha256=hashes)
                report["rows"].append(row)
                output.write_text(json.dumps(report, indent=2) + "\n")
                print(length, selected, causal, scale, options, errors, "parent", parent_pass, flush=True)
    assert any(not r["parent_pass"] for r in report["rows"])
    assert report["sources"][str(path)] == hashlib.sha256(path.read_bytes()).hexdigest()
    report["status"] = "PASS"
    output.write_text(json.dumps(report, indent=2) + "\n")
    print("PASS", len(report["rows"]), "retained parent failures", sum(not r["parent_pass"] for r in report["rows"]), flush=True)


if __name__ == "__main__":
    main()
