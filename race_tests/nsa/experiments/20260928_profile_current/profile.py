"""Profile one current module without changing a frozen submission."""
import argparse
import hashlib
import json
import sys
from pathlib import Path

import torch

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs
from experiment_bench import load_module
from kernel_source import get_kernel_source


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("module")
    parser.add_argument("--case", default="oj6", choices=["oj6", "oj12", "g8_b8"])
    parser.add_argument("--warmup", type=int, default=3)
    parser.add_argument("--iters", type=int, default=8)
    parser.add_argument("--source")
    args = parser.parse_args()
    cfg = dict(B=8, SEQ_LEN=1024, H=1, HQ=16, D=128, S=1,
               block_size=32, is_causal=True)
    if args.case != "oj6":
        cfg.update(B=4 if args.case == "oj12" else 8, D=64, S=8, block_size=16)
    module = load_module(args.module)
    inputs = make_inputs(cfg, seed=0)
    output = torch.empty_like(inputs[0])
    call_args = (*inputs, output, cfg["B"], cfg["SEQ_LEN"], cfg["H"], cfg["HQ"],
                 cfg["D"], cfg["S"], cfg["block_size"], cfg["is_causal"], 0.1)
    for _ in range(args.warmup):
        module.run_kernel(*call_args)
    torch.cuda.synchronize()
    compiled = next(reversed(module._KERNEL_CACHE.values()))
    if args.source:
        Path(args.source).write_text(get_kernel_source(compiled))
    for _ in range(args.iters):
        module.run_kernel(*call_args)
    torch.cuda.synchronize()
    print(json.dumps(dict(module=args.module, case=args.case,
                          sha256=hashlib.sha256(Path(args.module).read_bytes()).hexdigest(),
                          config=cfg, finite=bool(output.isfinite().all().item()))), flush=True)


if __name__ == "__main__":
    main()
