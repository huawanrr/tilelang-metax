#!/usr/bin/env python3
"""Local functional + performance harness for the fused-MoE competition kernel.

The OJ grader calls a single entry point:

    run_kernel(stacked_expert_tokens, gate_w, up_w, down_w,
               routed_expert_weights, group_sizes, group_offsets,
               group_padded_offsets, group_idx_for_bx, out)

`fusedmoe_benchmark.py` cannot exercise that contract: it packs tokens
*unpadded*, passes `up_logits` explicitly, uses `n_experts`-sized offset arrays
and float16 routing weights.  This harness reproduces the OJ layout exactly
(padded token rows, float32 routing weights, `n_experts + 1` offset arrays), so
`moe.py` stays byte-identical to what is submitted while still being testable
and tunable locally.

Examples:
    python local_bench.py --list
    python local_bench.py --only tiny,small
    python local_bench.py --module moe.py --module baseline_submission.py
    python local_bench.py --bench-only --iters 50
"""
from __future__ import annotations

import argparse
import dataclasses
import importlib.util
import json
import math
import os
import sys
from typing import Dict, List, Optional, Sequence, Tuple

import torch

BLOCK_TOKEN = 128
REF_CHUNK = 2048
GATHER_CHUNK = 8192
HERE = os.path.dirname(os.path.abspath(__file__))
GIB = float(1 << 30)

ARG_ORDER = (
    "stacked_expert_tokens",
    "gate_w",
    "up_w",
    "down_w",
    "routed_expert_weights",
    "group_sizes",
    "group_offsets",
    "group_padded_offsets",
    "group_idx_for_bx",
)


@dataclasses.dataclass(frozen=True)
class Case:
    """One test shape, using the same key names as `moe_test_configs.json`."""

    name: str
    dhidden: int
    dexpert: int
    nroutedexperts: int
    nexpertspertoken: int
    bs: int
    seqlen: int
    seed: int = 81394
    check: bool = True
    bench: bool = True

    @property
    def n_tokens(self) -> int:
        return self.bs * self.seqlen

    @property
    def n_valid(self) -> int:
        return self.n_tokens * self.nexpertspertoken

    @property
    def num_blocks_m(self) -> int:
        # Same formula the grader uses to size `group_idx_for_bx`.
        return math.ceil(self.n_valid / BLOCK_TOKEN) + self.nroutedexperts

    @property
    def n_padded(self) -> int:
        return self.num_blocks_m * BLOCK_TOKEN

    def peak_bytes(self, n_modules: int = 1, with_check: bool = True) -> int:
        """Rough peak device memory for building + running this case."""
        h, i, e = self.dhidden, self.dexpert, self.nroutedexperts
        p = self.n_padded
        total = self.n_tokens * h * 2  # x (freed after the layout is built)
        total += 3 * e * i * h * 2  # gate / up / down weights
        total += p * h * 2  # stacked_expert_tokens
        total += n_modules * p * h * 2  # out buffer per module under test
        total += n_modules * p * i * 2  # up_logits workspace per module
        total += self.n_valid * (4 + 3 * 8)  # routing weights + index bookkeeping
        total += GATHER_CHUNK * h * 2  # gather scratch
        if with_check:
            total += 3 * i * h * 4  # fp32 weight upcast
            total += REF_CHUNK * (2 * h * 4 + 3 * i * 4)  # fp32 activations
        return total

    def flops(self) -> int:
        # gate + up + down, 2 flops per MAC, only over real (unpadded) rows.
        return 6 * self.n_valid * self.dhidden * self.dexpert


def load_module(path: str):
    """Import a submission file by path so `moe.py` needs no packaging."""
    abs_path = path if os.path.isabs(path) else os.path.join(HERE, path)
    if not os.path.exists(abs_path):
        raise FileNotFoundError(abs_path)
    name = "submission_" + os.path.splitext(os.path.basename(abs_path))[0]
    spec = importlib.util.spec_from_file_location(name, abs_path)
    mod = importlib.util.module_from_spec(spec)
    sys.modules[name] = mod
    spec.loader.exec_module(mod)
    if not hasattr(mod, "run_kernel"):
        raise AttributeError(f"{abs_path} does not expose run_kernel()")
    mod.__bench_label__ = os.path.basename(abs_path)
    return mod


def release_module_caches(mod) -> None:
    for attr in ("_WORKSPACE_CACHE", "_KERNEL_CACHE"):
        cache = getattr(mod, attr, None)
        if attr == "_WORKSPACE_CACHE" and isinstance(cache, dict):
            cache.clear()


def build_case(case: Case, device: torch.device) -> Tuple[Dict[str, torch.Tensor], Dict]:
    """Materialise the OJ-shaped kernel arguments for one case."""
    h, i, e, k = case.dhidden, case.dexpert, case.nroutedexperts, case.nexpertspertoken
    f16 = torch.float16
    gen = torch.Generator(device=device)
    gen.manual_seed(case.seed)

    x = torch.randn((case.n_tokens, h), device=device, dtype=f16, generator=gen)
    router_w = torch.randn((e, h), device=device, dtype=f16, generator=gen) / math.sqrt(h)
    gate_w = torch.randn((e, i, h), device=device, dtype=f16, generator=gen) / math.sqrt(i)
    up_w = torch.randn((e, i, h), device=device, dtype=f16, generator=gen) / math.sqrt(i)
    down_w = torch.randn((e, h, i), device=device, dtype=f16, generator=gen) / math.sqrt(h)

    # Routing: softmax over experts, then top-k (unsorted, as in the reference).
    scores = (x @ router_w.t()).float().softmax(dim=-1)
    topk_scores, topk_idx = torch.topk(scores, k=k, dim=-1, sorted=False)
    del scores, router_w

    flat_idx = topk_idx.reshape(-1)
    flat_w = topk_scores.reshape(-1).float()
    order = torch.argsort(flat_idx, stable=True)
    counts = torch.bincount(flat_idx, minlength=e)

    offsets = torch.zeros(e + 1, dtype=torch.int64, device=device)
    offsets[1:] = torch.cumsum(counts, 0)
    # The grader pads every group to a multiple of BLOCK_TOKEN and always keeps
    # at least one padding row: ceil((count + 1) / 128) * 128.
    padded_sizes = ((counts + 1 + BLOCK_TOKEN - 1) // BLOCK_TOKEN) * BLOCK_TOKEN
    pad_off = torch.zeros(e + 1, dtype=torch.int64, device=device)
    pad_off[1:] = torch.cumsum(padded_sizes, 0)

    n_padded = case.n_padded
    used_padded = int(pad_off[e].item())
    assert used_padded <= n_padded, f"padded layout {used_padded} exceeds buffer {n_padded}"

    slot_expert = flat_idx[order]
    slot_rank = torch.arange(case.n_valid, device=device, dtype=torch.int64) - offsets[slot_expert]
    pad_rows = pad_off[slot_expert] + slot_rank
    src_rows = torch.div(order, k, rounding_mode="floor")
    del slot_expert, slot_rank

    # Zero-filled so padding rows are well defined for the reference comparison.
    stacked = torch.zeros((n_padded, h), device=device, dtype=f16)
    for s in range(0, case.n_valid, GATHER_CHUNK):
        sl = slice(s, min(s + GATHER_CHUNK, case.n_valid))
        stacked[pad_rows[sl]] = x[src_rows[sl]]
    routed_w = flat_w[order].contiguous()
    del x, flat_w, flat_idx, topk_scores, topk_idx, order, pad_rows, src_rows

    block_starts = torch.arange(case.num_blocks_m, device=device, dtype=torch.int64) * BLOCK_TOKEN
    gidx = torch.searchsorted(pad_off[:e].contiguous(), block_starts, right=True) - 1
    del block_starts

    args = {
        "stacked_expert_tokens": stacked,
        "gate_w": gate_w,
        "up_w": up_w,
        "down_w": down_w,
        "routed_expert_weights": routed_w,
        "group_sizes": counts.to(torch.int32),
        "group_offsets": offsets.to(torch.int32),
        "group_padded_offsets": pad_off.to(torch.int32),
        "group_idx_for_bx": gidx.to(torch.int32),
    }
    meta = {
        "counts": counts.tolist(),
        "offsets": offsets.tolist(),
        "pad_off": pad_off.tolist(),
        "used_padded": used_padded,
    }
    torch.cuda.synchronize()
    return args, meta


def check_reference(out: torch.Tensor, args: Dict, meta: Dict, atol=1e-2, rtol=1e-2) -> Dict:
    """Compare `out` against a chunked float32 reference over the valid rows."""
    stacked = args["stacked_expert_tokens"]
    gate_w, up_w, down_w = args["gate_w"], args["up_w"], args["down_w"]
    routed_w = args["routed_expert_weights"]
    counts, offsets, pad_off = meta["counts"], meta["offsets"], meta["pad_off"]

    bad = 0
    total = 0
    max_abs = 0.0
    max_rel = 0.0
    ref_absmax = 0.0
    nan = 0
    for e, count in enumerate(counts):
        if count == 0:
            continue
        gw = gate_w[e].float()
        uw = up_w[e].float()
        dw = down_w[e].float()
        for s in range(0, count, REF_CHUNK):
            n = min(REF_CHUNK, count - s)
            p0 = pad_off[e] + s
            xe = stacked[p0 : p0 + n].float()
            hidden = torch.nn.functional.silu(xe @ gw.t()) * (xe @ uw.t())
            ref = hidden @ dw.t()
            ref *= routed_w[offsets[e] + s : offsets[e] + s + n].unsqueeze(1)
            got = out[p0 : p0 + n].float()
            nan += int((~torch.isfinite(got)).sum().item())
            diff = (got - ref).abs()
            bad += int((diff > atol + rtol * ref.abs()).sum().item())
            total += diff.numel()
            max_abs = max(max_abs, float(diff.max().item()))
            max_rel = max(max_rel, float((diff / ref.abs().clamp_min(1e-3)).max().item()))
            ref_absmax = max(ref_absmax, float(ref.abs().max().item()))
            del xe, hidden, ref, got, diff
        del gw, uw, dw
    return {
        "ok": bad == 0 and nan == 0,
        "bad": bad,
        "total": total,
        "nan": nan,
        "max_abs": max_abs,
        "max_rel": max_rel,
        "ref_absmax": ref_absmax,
    }


def torch_baseline(args: Dict, meta: Dict, out: torch.Tensor) -> None:
    """Per-expert float16 grouped GEMM, the natural PyTorch equivalent."""
    stacked = args["stacked_expert_tokens"]
    gate_w, up_w, down_w = args["gate_w"], args["up_w"], args["down_w"]
    routed_w = args["routed_expert_weights"]
    counts, offsets, pad_off = meta["counts"], meta["offsets"], meta["pad_off"]
    for e, count in enumerate(counts):
        if count == 0:
            continue
        p0 = pad_off[e]
        xe = stacked[p0 : p0 + count]
        hidden = torch.nn.functional.silu(xe @ gate_w[e].t()) * (xe @ up_w[e].t())
        res = hidden @ down_w[e].t()
        res *= routed_w[offsets[e] : offsets[e] + count].unsqueeze(1).to(res.dtype)
        out[p0 : p0 + count] = res


def time_fn(fn, warmup: int, iters: int) -> float:
    for _ in range(warmup):
        fn()
    torch.cuda.synchronize()
    start = torch.cuda.Event(enable_timing=True)
    end = torch.cuda.Event(enable_timing=True)
    start.record()
    for _ in range(iters):
        fn()
    end.record()
    torch.cuda.synchronize()
    return start.elapsed_time(end) / iters


def load_cases(path: str, only: Optional[Sequence[str]]) -> List[Case]:
    with open(path, "r") as fh:
        raw = json.load(fh)
    entries = raw["cases"] if isinstance(raw, dict) else raw
    fields = {f.name for f in dataclasses.fields(Case)}
    cases = []
    for idx, entry in enumerate(entries):
        entry = dict(entry)
        entry.setdefault("name", f"case{idx}")
        unknown = set(entry) - fields
        if unknown:
            raise ValueError(f"unknown keys in case {entry['name']}: {sorted(unknown)}")
        cases.append(Case(**entry))
    if only:
        wanted = {n.strip() for n in only if n.strip()}
        missing = wanted - {c.name for c in cases}
        if missing:
            raise SystemExit(f"unknown case name(s): {sorted(missing)}")
        cases = [c for c in cases if c.name in wanted]
    return cases


def parse_args(argv=None):
    p = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    p.add_argument("--configs", default=os.path.join(HERE, "local_test_configs.json"))
    p.add_argument("--module", action="append", default=None,
                   help="submission file exposing run_kernel (repeatable, default moe.py)")
    p.add_argument("--only", default=None, help="comma separated case names")
    p.add_argument("--iters", type=int, default=20)
    p.add_argument("--warmup", type=int, default=5)
    p.add_argument("--mem-budget-gb", type=float, default=None,
                   help="skip cases whose estimated peak exceeds this (default 80%% of VRAM)")
    p.add_argument("--func-only", action="store_true")
    p.add_argument("--bench-only", action="store_true")
    p.add_argument("--no-torch-baseline", action="store_true")
    p.add_argument("--atol", type=float, default=1e-2)
    p.add_argument("--rtol", type=float, default=1e-2)
    p.add_argument("--list", action="store_true", help="print cases + memory estimates and exit")
    args = p.parse_args(argv)
    args.module = args.module or ["moe.py"]
    args.only = args.only.split(",") if args.only else None
    return args


def main(argv=None) -> int:
    opts = parse_args(argv)
    cases = load_cases(opts.configs, opts.only)

    if not torch.cuda.is_available():
        raise SystemExit("no GPU visible; this harness needs the MetaX device")
    device = torch.device("cuda")
    props = torch.cuda.get_device_properties(0)
    vram_gib = props.total_memory / GIB
    budget = opts.mem_budget_gb if opts.mem_budget_gb is not None else 0.8 * vram_gib
    for flag in ("allow_tf32",):
        try:  # keep the float32 reference at full precision where supported
            setattr(torch.backends.cuda.matmul, flag, False)
        except Exception:
            pass

    n_mod = len(opts.module)
    if opts.list:
        print(f"device: {props.name}  vram={vram_gib:.2f} GiB  budget={budget:.2f} GiB  modules={n_mod}")
        head = f"{'case':<14}{'H':>6}{'I':>6}{'E':>4}{'k':>3}{'valid':>9}{'padded':>9}{'est GiB':>9}{'TFLOP':>8}"
        print(head)
        for c in cases:
            est = c.peak_bytes(n_mod, c.check) / GIB
            print(f"{c.name:<14}{c.dhidden:>6}{c.dexpert:>6}{c.nroutedexperts:>4}{c.nexpertspertoken:>3}"
                  f"{c.n_valid:>9}{c.n_padded:>9}{est:>9.2f}{c.flops()/1e12:>8.2f}")
        return 0

    modules = [load_module(m) for m in opts.module]
    print(f"device: {props.name}  vram={vram_gib:.2f} GiB  budget={budget:.2f} GiB")
    print(f"modules: {', '.join(m.__bench_label__ for m in modules)}")
    failures = 0

    for case in cases:
        do_check = case.check and not opts.bench_only
        do_bench = case.bench and not opts.func_only
        if not (do_check or do_bench):
            continue
        est = case.peak_bytes(n_mod, do_check) / GIB
        print(f"\n=== {case.name}  H={case.dhidden} I={case.dexpert} E={case.nroutedexperts} "
              f"topk={case.nexpertspertoken} bs={case.bs} seq={case.seqlen} "
              f"valid={case.n_valid} padded={case.n_padded} est={est:.2f} GiB ===")
        if est > budget:
            print(f"  [skip] estimated {est:.2f} GiB exceeds budget {budget:.2f} GiB")
            continue

        torch.cuda.empty_cache()
        torch.cuda.reset_peak_memory_stats()
        try:
            args, meta = build_case(case, device)
        except torch.cuda.OutOfMemoryError as exc:
            print(f"  [skip] OOM while building inputs: {exc}")
            torch.cuda.empty_cache()
            continue
        nonempty = sum(1 for c in meta["counts"] if c > 0)
        print(f"  routing: {nonempty}/{case.nroutedexperts} experts used, "
              f"group sizes min/max = {min(meta['counts'])}/{max(meta['counts'])}")
        pos = tuple(args[k] for k in ARG_ORDER)
        out = torch.zeros_like(args["stacked_expert_tokens"])
        results = []
        try:
            for mod in modules:
                label = mod.__bench_label__
                out.zero_()
                mod.run_kernel(*pos, out)
                torch.cuda.synchronize()
                status = ""
                if do_check:
                    stats = check_reference(out, args, meta, opts.atol, opts.rtol)
                    ok = stats["ok"]
                    failures += 0 if ok else 1
                    mark = "PASS" if ok else "FAIL"
                    status = (f"{mark} max_abs={stats['max_abs']:.3e} max_rel={stats['max_rel']:.3e} "
                              f"bad={stats['bad']}/{stats['total']} |ref|max={stats['ref_absmax']:.3f}")
                    print(f"  [{label}] correctness: {status}")
                if do_bench:
                    ms = time_fn(lambda: mod.run_kernel(*pos, out), opts.warmup, opts.iters)
                    tflops = case.flops() / (ms * 1e-3) / 1e12
                    results.append((label, ms, tflops))
                    print(f"  [{label}] time: {ms:9.3f} ms   {tflops:7.2f} TFLOP/s")
                release_module_caches(mod)
                torch.cuda.empty_cache()
            if do_bench and not opts.no_torch_baseline:
                out.zero_()
                ms = time_fn(lambda: torch_baseline(args, meta, out), max(1, opts.warmup // 2),
                             max(3, opts.iters // 4))
                tflops = case.flops() / (ms * 1e-3) / 1e12
                results.append(("torch fp16 grouped", ms, tflops))
                print(f"  [torch fp16 grouped] time: {ms:9.3f} ms   {tflops:7.2f} TFLOP/s")
        except torch.cuda.OutOfMemoryError as exc:
            print(f"  [skip] OOM while running: {exc}")
            failures += 1
        if len(results) > 1:
            best = min(r[1] for r in results)
            print("  relative:  " + "   ".join(f"{n}={r/best:.2f}x" for n, r, _ in results))
        peak = torch.cuda.max_memory_allocated() / GIB
        print(f"  peak allocated: {peak:.2f} GiB (estimate was {est:.2f} GiB)")

        del args, meta, out, pos
        for mod in modules:
            release_module_caches(mod)
        torch.cuda.empty_cache()

    print("\n" + ("all checks passed" if failures == 0 else f"{failures} check(s) failed"))
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
