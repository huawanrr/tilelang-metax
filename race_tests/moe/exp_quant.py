#!/usr/bin/env python3
"""Would int8 A operands still pass the grader's 5% tolerance?

Quantising the *weights* cannot pay: they are streamed only ~1.5x their own size per
call (each (expert, n-tile) tile is read once per token block of that expert), so a
per-call quantisation pass costs 1.5x and saves 0.5x per read.  The rule against
caching across calls closes that door for good.

The A operands are the opposite.  `stacked_expert_tokens` is streamed once per n-tile
block -- 16x its own size on Config3, 64x on Config1 -- and `up_logits` is streamed
once per n-tile *pair* of stage 2, 28x on Config3.  Halving those bytes is worth
15-23% of each stage's streamed traffic, and both stages are within 8% of their
bandwidth roof.

The plan this script prices is: quantise A to int8 with a per-row scale, keep the MMA
in fp16 by casting int8 -> fp16 on the way into shared memory, and apply the row scale
in the epilogue (before the SwiGLU in stage 1, folded into the routing weight in stage
2).  What that costs is accuracy, and the grader compares the whole `out` at
rtol=atol=0.05, so this measures the error before any kernel is written.
"""
import argparse
import os

import torch

from local_bench import build_case, load_cases
import tune_moe as tm


def quant_rows(x, chunk=0):
    """Symmetric int8 quantisation with a per-row (chunk=0) or per-(row, chunk) scale.

    A per-row scale is the cheap one: it is a single scalar per row, so stage 1 can
    apply it to its accumulators before the SwiGLU and stage 2 can fold it into the
    routing weight, leaving the shared-memory copy a pure int8 -> fp16 cast.  A
    per-chunk scale has to be applied inside the copy instead, but the chunk maximum
    is much closer to the values it divides, so the codes use more of the range.
    """
    if chunk and x.shape[-1] % chunk == 0:
        v = x.float().reshape(*x.shape[:-1], x.shape[-1] // chunk, chunk)
        scale = (v.abs().amax(dim=-1, keepdim=True) / 127.0).clamp_min(1e-12)
        q = torch.round(v / scale).clamp(-127, 127)
        return (q * scale).reshape(x.shape)
    amax = x.abs().amax(dim=-1, keepdim=True).float()
    scale = (amax / 127.0).clamp_min(1e-12)
    q = torch.round(x.float() / scale).clamp(-127, 127)
    return q * scale


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--cases", default="oj1real,oj2real,oj3real")
    p.add_argument("--configs", default=os.path.join(
        os.path.dirname(os.path.abspath(__file__)), "local_test_configs.json"))
    a = p.parse_args()
    dev = torch.device("cuda")
    print("grader check: |got - ref| <= atol + rtol*|ref| with atol = rtol = 0.05")
    print(f"{'case':10s}{'variant':18s}{'max_abs':>10}{'worst |d|/tol':>14}{'bad elems':>11}")
    for name in a.cases.split(","):
        case = load_cases(a.configs, [name])[0]
        args, meta = build_case(case, dev)
        counts, pad_off, offs = meta["counts"], meta["pad_off"], meta["offsets"]
        stacked = args["stacked_expert_tokens"]
        gate_w, up_w, down_w = args["gate_w"], args["up_w"], args["down_w"]
        routed = args["routed_expert_weights"]

        def run(q_tokens, q_hidden, chunk=0):
            """float32 reference, optionally with int8-quantised A operands."""
            out = torch.zeros_like(stacked, dtype=torch.float32)
            for e, n in enumerate(counts):
                if n == 0:
                    continue
                p0, r0 = pad_off[e], offs[e]
                x = stacked[p0 : p0 + n]
                x = quant_rows(x, chunk) if q_tokens else x.float()
                g = x @ gate_w[e].float().t()
                u = x @ up_w[e].float().t()
                h = torch.nn.functional.silu(g) * u
                if q_hidden:
                    h = quant_rows(h.half(), chunk)
                y = h @ down_w[e].float().t()
                out[p0 : p0 + n] = y * routed[r0 : r0 + n].unsqueeze(1).float()
            return out

        ref = run(False, False)
        tol = 0.05 + 0.05 * ref.abs()
        for label, qt, qh, ch in (("tokens/64", True, False, 64),
                                  ("tokens/32", True, False, 32),
                                  ("tokens/16", True, False, 16),
                                  ("up_logits/32", False, True, 32),
                                  ("up_logits/16", False, True, 16),
                                  ("both/16", True, True, 16)):
            got = run(qt, qh, ch)
            d = (got - ref).abs()
            ratio = (d / tol).max().item()
            bad = int((d > tol).sum().item())
            print(f"{name:10s}{label:18s}{d.max().item():10.2e}{ratio:14.2f}{bad:11d}"
                  f"{'' if bad == 0 else '   FAIL'}")
        del args, meta
        torch.cuda.empty_cache()


if __name__ == "__main__":
    main()
