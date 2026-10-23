"""Compare independent NSA experiment modules against the float32 reference."""

import argparse
import importlib.util
import json
from pathlib import Path

import torch

from benchmark_nsa import make_inputs, sparse_reference, check_output
from bench_oj import graph_latency


def load_module(path):
    spec = importlib.util.spec_from_file_location(Path(path).stem, path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("modules", nargs="+", help="Python source files, independently imported")
    parser.add_argument("--cases", default="oj6,oj12")
    parser.add_argument("--repeat", type=int, default=100)
    parser.add_argument("--samples", type=int, default=7)
    parser.add_argument("--knobs", default="{}", help="JSON keyword arguments to the factory")
    parser.add_argument("--output")
    parser.add_argument("--dump-source", action="store_true")
    args = parser.parse_args()
    modules = [(path, load_module(path)) for path in args.modules]
    cases = json.loads(Path("test_cases_nsa_fwd.json").read_text())
    named = {
        "oj6": dict(B=8, SEQ_LEN=1024, H=1, HQ=16, D=128, S=1, block_size=32, is_causal=True),
        "oj12": dict(B=4, SEQ_LEN=1024, H=1, HQ=16, D=64, S=8, block_size=16, is_causal=True),
    }
    results = []
    for name in args.cases.split(","):
        cfg = named[name] if name in named else cases[int(name) - 1]
        inputs = make_inputs(cfg)
        expected = sparse_reference(*inputs, cfg["block_size"], cfg["is_causal"], 0.1)
        for path, module in modules:
            kernel = module.native_sparse_attention(
                batch=cfg["B"], heads=cfg["HQ"], seq_len=cfg["SEQ_LEN"], dim=cfg["D"],
                is_causal=cfg["is_causal"], scale=0.1, block_size=cfg["block_size"],
                groups=cfg["HQ"] // cfg["H"], selected_blocks=cfg["S"], **json.loads(args.knobs),
            )
            error = check_output(kernel(*inputs), expected, f"{path}:{name}")
            latency = graph_latency(lambda: kernel(*inputs), args.repeat, args.samples) * 1000
            row = dict(case=name, module=path, us=latency, max_abs_error=error, **cfg)
            results.append(row)
            print(json.dumps(row), flush=True)
            if args.dump_source:
                compiled = next(reversed(module._KERNEL_CACHE.values()))
                Path(f"/tmp/{Path(path).stem}_{name}.cu").write_text(compiled.get_kernel_source())
    if args.output:
        Path(args.output).write_text(json.dumps(results, indent=2) + "\n")


if __name__ == "__main__":
    main()
