#!/usr/bin/env python3
"""Config sweep for the two fused-MoE stages, on the OJ padded layout.

Stage 1 (gate/up + SwiGLU) and stage 2 (down + routing weight) are built as
separate JIT kernels here so each can be timed and verified on its own.  The
winning configs are then folded back into `moe.py`, which keeps both stages in
one prim_func.

    python tune_moe.py --stage 1 --case mid
    python tune_moe.py --stage 2 --case mid --top 8
"""
import argparse
import itertools
import json
import os
import sys
import traceback

import torch
import tilelang
import tilelang.language as T

from local_bench import BLOCK_TOKEN, Case, build_case, load_cases, time_fn

JIT_ARGS = dict(pass_configs={tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True})
SMEM_LIMIT = 64 * 1024

POLICIES = {
    "square": T.GemmWarpPolicy.Square,
    "row": T.GemmWarpPolicy.FullRow,
    "col": T.GemmWarpPolicy.FullCol,
}

# Knobs added after the first tile sweep; defaults reproduce that sweep.
EXTRA_DEFAULTS = {"swizzle": 10, "policy": "square", "k_pack": 1, "one_buf": False}


def with_defaults(cfg):
    full = dict(EXTRA_DEFAULTS)
    full.update(cfg)
    return full


def stage1_smem(cfg) -> int:
    weights = 1 if cfg.get("one_buf") else 2
    per_stage = cfg["block_n"] * cfg["block_k"] * 2 * weights
    if cfg["a_shared"]:
        per_stage += cfg["block_m"] * cfg["block_k"] * 2
    return per_stage * max(1, cfg["num_stages"])


def stage2_smem(cfg) -> int:
    per_stage = cfg["block_n"] * cfg["block_k"] * 2
    if cfg["a_shared"]:
        per_stage += cfg["block_m"] * cfg["block_k"] * 2
    return per_stage * max(1, cfg["num_stages"])


@tilelang.jit(**JIT_ARGS)
def build_stage1(hidden, intermediate, num_experts, padded, valid, num_blocks,
                 block_m, block_n, block_k, threads, num_stages, a_shared,
                 swizzle=10, policy="square", k_pack=1, one_buf=False):
    bm, bn, bk = block_m, block_n, block_k
    scale = 1.44269504
    dtype, accum = T.float16, T.float32
    sub = BLOCK_TOKEN // bm
    grid_m = num_blocks * sub
    alloc_a = T.alloc_shared if a_shared else T.alloc_fragment
    pol = POLICIES[policy]

    @T.prim_func
    def kernel(
        tokens: T.Tensor((padded, hidden), dtype),
        gate_w: T.Tensor((num_experts, intermediate, hidden), dtype),
        up_w: T.Tensor((num_experts, intermediate, hidden), dtype),
        group_sizes: T.Tensor((num_experts,), T.int32),
        group_padded_offsets: T.Tensor((num_experts + 1,), T.int32),
        group_idx_for_bx: T.Tensor((num_blocks,), T.int32),
        up_logits: T.Tensor((padded, intermediate), dtype),
    ):
        with T.Kernel(grid_m, T.ceildiv(intermediate, bn), threads=threads) as (bx, by):
            a_buf = alloc_a((bm, bk), dtype=dtype)
            gate_s = T.alloc_shared((bn, bk), dtype=dtype)
            up_s = gate_s if one_buf else T.alloc_shared((bn, bk), dtype=dtype)
            gate_l = T.alloc_fragment((bm, bn), dtype=accum)
            up_l = T.alloc_fragment((bm, bn), dtype=accum)
            if swizzle:
                T.use_swizzle(swizzle)

            ext = bx // sub
            # Clamped so the backend can prove the weight loads are in range
            # and drop TileLang's bounds guard; see moe.py.
            expert = T.min(T.max(group_idx_for_bx[ext], 0), num_experts - 1)
            row0 = ext * BLOCK_TOKEN + (bx % sub) * bm
            rows = T.max(0, T.min(bm, group_sizes[expert] - (row0 - group_padded_offsets[expert])))

            if rows > 0:
                T.clear(gate_l)
                T.clear(up_l)
                for k in T.Pipelined(T.ceildiv(hidden, bk), num_stages=num_stages):
                    T.copy(tokens[row0 : row0 + bm, k * bk : (k + 1) * bk], a_buf)
                    T.copy(gate_w[expert, by * bn : (by + 1) * bn, k * bk : (k + 1) * bk], gate_s)
                    if one_buf:
                        T.gemm(a_buf, gate_s, gate_l, transpose_B=True, policy=pol, k_pack=k_pack)
                        T.copy(up_w[expert, by * bn : (by + 1) * bn, k * bk : (k + 1) * bk], up_s)
                        T.gemm(a_buf, up_s, up_l, transpose_B=True, policy=pol, k_pack=k_pack)
                    else:
                        T.copy(up_w[expert, by * bn : (by + 1) * bn, k * bk : (k + 1) * bk], up_s)
                        T.gemm(a_buf, gate_s, gate_l, transpose_B=True, policy=pol, k_pack=k_pack)
                        T.gemm(a_buf, up_s, up_l, transpose_B=True, policy=pol, k_pack=k_pack)
                for i, j in T.Parallel(bm, bn):
                    gate_l[i, j] = gate_l[i, j] * (1.0 / (1.0 + T.exp2(-gate_l[i, j] * scale)))
                    up_l[i, j] = up_l[i, j] * gate_l[i, j]
                    if i < rows:
                        up_logits[row0 + i, by * bn + j] = up_l[i, j]

    return kernel



@tilelang.jit(**JIT_ARGS)
def build_stage2(hidden, intermediate, num_experts, padded, valid, num_blocks,
                 block_m, block_n, block_k, threads, num_stages, a_shared,
                 swizzle=10, policy="square", k_pack=1, one_buf=False):
    bm, bn, bk = block_m, block_n, block_k
    dtype, accum = T.float16, T.float32
    sub = BLOCK_TOKEN // bm
    grid_m = num_blocks * sub
    alloc_a = T.alloc_shared if a_shared else T.alloc_fragment
    pol = POLICIES[policy]

    @T.prim_func
    def kernel(
        up_logits: T.Tensor((padded, intermediate), dtype),
        down_w: T.Tensor((num_experts, hidden, intermediate), dtype),
        routed_w: T.Tensor((valid,), T.float32),
        group_sizes: T.Tensor((num_experts,), T.int32),
        group_offsets: T.Tensor((num_experts + 1,), T.int32),
        group_padded_offsets: T.Tensor((num_experts + 1,), T.int32),
        group_idx_for_bx: T.Tensor((num_blocks,), T.int32),
        out: T.Tensor((padded, hidden), dtype),
    ):
        with T.Kernel(grid_m, T.ceildiv(hidden, bn), threads=threads) as (bx, by):
            a_buf = alloc_a((bm, bk), dtype=dtype)
            down_s = T.alloc_shared((bn, bk), dtype=dtype)
            out_l = T.alloc_fragment((bm, bn), dtype=accum)
            w_l = T.alloc_fragment((bm,), dtype=T.float32)
            if swizzle:
                T.use_swizzle(swizzle)

            ext = bx // sub
            # Clamped so the backend can prove the weight loads are in range
            # and drop TileLang's bounds guard; see moe.py.
            expert = T.min(T.max(group_idx_for_bx[ext], 0), num_experts - 1)
            row0 = ext * BLOCK_TOKEN + (bx % sub) * bm
            offset = row0 - group_padded_offsets[expert]
            rows = T.max(0, T.min(bm, group_sizes[expert] - offset))
            raw0 = group_offsets[expert] + offset

            if rows > 0:
                T.clear(out_l)
                for k in T.Pipelined(T.ceildiv(intermediate, bk), num_stages=num_stages):
                    T.copy(up_logits[row0 : row0 + bm, k * bk : (k + 1) * bk], a_buf)
                    T.copy(down_w[expert, by * bn : (by + 1) * bn, k * bk : (k + 1) * bk], down_s)
                    T.gemm(a_buf, down_s, out_l, transpose_B=True, policy=pol, k_pack=k_pack)
                for i in T.Parallel(bm):
                    if i < rows:
                        w_l[i] = routed_w[raw0 + i]
                for i, j in T.Parallel(bm, bn):
                    if i < rows:
                        out[row0 + i, by * bn + j] = out_l[i, j] * w_l[i]

    return kernel



def ref_stage1(args, meta, chunk=2048):
    """float32-accumulated reference for up_logits, laid out on padded rows."""
    stacked = args["stacked_expert_tokens"]
    gate_w, up_w = args["gate_w"], args["up_w"]
    ref = torch.zeros((stacked.shape[0], gate_w.shape[1]), device=stacked.device, dtype=torch.float16)
    for e, count in enumerate(meta["counts"]):
        gw, uw = gate_w[e].float(), up_w[e].float()
        for s in range(0, count, chunk):
            n = min(chunk, count - s)
            p0 = meta["pad_off"][e] + s
            xe = stacked[p0 : p0 + n].float()
            ref[p0 : p0 + n] = (torch.nn.functional.silu(xe @ gw.t()) * (xe @ uw.t())).half()
        del gw, uw
    return ref


def ref_stage2(up_logits, args, meta, chunk=2048):
    down_w, routed_w = args["down_w"], args["routed_expert_weights"]
    ref = torch.zeros((up_logits.shape[0], down_w.shape[1]), device=up_logits.device, dtype=torch.float16)
    for e, count in enumerate(meta["counts"]):
        dw = down_w[e].float()
        for s in range(0, count, chunk):
            n = min(chunk, count - s)
            p0 = meta["pad_off"][e] + s
            res = up_logits[p0 : p0 + n].float() @ dw.t()
            r0 = meta["offsets"][e] + s
            ref[p0 : p0 + n] = (res * routed_w[r0 : r0 + n].unsqueeze(1)).half()
        del dw
    return ref


def max_err_valid(got, ref, meta):
    """Return max abs error over valid rows, normalised by the reference range."""
    worst = 0.0
    scale = 1e-6
    for e, count in enumerate(meta["counts"]):
        if count == 0:
            continue
        p0 = meta["pad_off"][e]
        r = ref[p0 : p0 + count].float()
        d = (got[p0 : p0 + count].float() - r).abs()
        worst = max(worst, float(d.max().item()))
        scale = max(scale, float(r.abs().max().item()))
    return worst / scale


def gen_configs(stage: int, quick: bool):
    block_m = [64, 128] if not quick else [128]
    block_n = [64, 128, 256]
    block_k = [32, 64, 128]
    threads = [128, 256, 512]
    stages = [0, 1, 2, 3]
    a_shared = [True, False]
    out = []
    for bm, bn, bk, th, ns, ash in itertools.product(block_m, block_n, block_k, threads, stages, a_shared):
        cfg = with_defaults({"block_m": bm, "block_n": bn, "block_k": bk,
                             "threads": th, "num_stages": ns, "a_shared": ash})
        if keep_config(stage, cfg):
            out.append(cfg)
    return out


def keep_config(stage: int, cfg) -> bool:
    if cfg["block_m"] * cfg["block_n"] < cfg["threads"]:
        return False
    smem = stage1_smem(cfg) if stage == 1 else stage2_smem(cfg)
    if smem > SMEM_LIMIT:
        return False
    # keep register pressure sane: fp32 accumulators per thread
    acc = cfg["block_m"] * cfg["block_n"] * (2 if stage == 1 else 1) / cfg["threads"]
    return acc <= 160


def gen_focus(stage: int):
    """Second-round sweep: L2 rasterization, warp policy and k_pack.

    The tile shape is pinned to the winners of the first round, plus (stage 1
    only) the `one_buf` variants that free enough shared memory for block_n=256.
    """
    if stage == 1:
        tiles = [
            {"block_m": 128, "block_n": 128, "block_k": 64, "threads": 512, "num_stages": 0, "a_shared": True},
            {"block_m": 128, "block_n": 64, "block_k": 128, "threads": 512, "num_stages": 0, "a_shared": True},
            {"block_m": 128, "block_n": 128, "block_k": 64, "threads": 512, "num_stages": 1, "a_shared": True},
            {"block_m": 128, "block_n": 256, "block_k": 64, "threads": 512, "num_stages": 0, "a_shared": True, "one_buf": True},
            {"block_m": 128, "block_n": 256, "block_k": 64, "threads": 512, "num_stages": 1, "a_shared": True, "one_buf": True},
            {"block_m": 128, "block_n": 128, "block_k": 128, "threads": 512, "num_stages": 1, "a_shared": True, "one_buf": True},
        ]
    else:
        tiles = [
            {"block_m": 128, "block_n": 128, "block_k": 64, "threads": 512, "num_stages": 1, "a_shared": True},
            {"block_m": 128, "block_n": 128, "block_k": 64, "threads": 512, "num_stages": 0, "a_shared": True},
            {"block_m": 128, "block_n": 256, "block_k": 64, "threads": 512, "num_stages": 1, "a_shared": True},
            {"block_m": 128, "block_n": 256, "block_k": 32, "threads": 512, "num_stages": 1, "a_shared": True},
        ]
    out = []
    for tile in tiles:
        for swz, pol, kp in itertools.product([0, 2, 4, 8, 10, 16, 32], ["square", "row", "col"], [1, 2]):
            cfg = with_defaults(dict(tile, swizzle=swz, policy=pol, k_pack=kp))
            if keep_config(stage, cfg):
                out.append(cfg)
    return out

def gen_focus2(stage: int):
    """Third-round sweep: re-check the winners at the largest local scale.

    Rasterisation is grid-shape dependent, and `perf_a` has 4x the token blocks
    of `func_a`, so the panel width that won there is not automatically right.
    """
    if stage == 1:
        tiles = [
            {"block_m": 128, "block_n": 256, "block_k": 64, "threads": 512, "num_stages": 0, "a_shared": True, "one_buf": True, "policy": "col"},
            {"block_m": 128, "block_n": 256, "block_k": 32, "threads": 512, "num_stages": 0, "a_shared": True, "one_buf": True, "policy": "col"},
            {"block_m": 128, "block_n": 128, "block_k": 64, "threads": 512, "num_stages": 0, "a_shared": True, "one_buf": False, "policy": "square"},
            {"block_m": 128, "block_n": 512, "block_k": 32, "threads": 1024, "num_stages": 0, "a_shared": True, "one_buf": True, "policy": "col"},
        ]
    else:
        tiles = [
            {"block_m": 128, "block_n": 256, "block_k": 32, "threads": 256, "num_stages": 1, "a_shared": True},
            {"block_m": 128, "block_n": 256, "block_k": 64, "threads": 256, "num_stages": 1, "a_shared": True},
            {"block_m": 128, "block_n": 128, "block_k": 64, "threads": 512, "num_stages": 1, "a_shared": True},
            {"block_m": 128, "block_n": 512, "block_k": 32, "threads": 512, "num_stages": 1, "a_shared": True},
        ]
    out = []
    for tile in tiles:
        for swz in [2, 4, 8, 10, 16, 32]:
            cfg = with_defaults(dict(tile, swizzle=swz))
            if keep_config(stage, cfg):
                out.append(cfg)
    return out


def gen_focus3(stage: int):
    """Fourth round: re-tune the tile now that the expert-index guard is gone.

    Removing the guard from the inner k-loop changed the load/compute balance,
    so the tile that won with it in place is not necessarily still best.
    """
    out = []
    for bn, bk, th, ns in itertools.product([128, 256], [32, 64, 128], [256, 512], [0, 1, 2]):
        extras = [{"one_buf": False, "policy": "square"}, {"one_buf": True, "policy": "col"},
                  {"one_buf": True, "policy": "square"}] if stage == 1 else [{"policy": "square"}]
        for extra in extras:
            cfg = with_defaults(dict(
                {"block_m": 128, "block_n": bn, "block_k": bk, "threads": th,
                 "num_stages": ns, "a_shared": True,
                 "swizzle": 10 if stage == 1 else 8},
                **extra))
            if keep_config(stage, cfg):
                out.append(cfg)
    return out


def main(argv=None):
    p = argparse.ArgumentParser()
    p.add_argument("--stage", type=int, choices=(1, 2), required=True)
    p.add_argument("--case", default="mid")
    p.add_argument("--configs", default=os.path.join(os.path.dirname(os.path.abspath(__file__)), "local_test_configs.json"))
    p.add_argument("--iters", type=int, default=10)
    p.add_argument("--warmup", type=int, default=3)
    p.add_argument("--top", type=int, default=15)
    p.add_argument("--quick", action="store_true", help="block_m=128 only")
    p.add_argument("--focus", action="store_true",
                   help="sweep swizzle/policy/k_pack around the round-1 winning tiles")
    p.add_argument("--focus3", action="store_true",
                   help="re-tune tiles after the expert-index clamp")
    p.add_argument("--focus2", action="store_true",
                   help="re-check the round-2 winners and wider tiles at large scale")
    p.add_argument("--tol", type=float, default=2e-2)
    p.add_argument("--only-cfg", default=None, help="JSON dict, benchmark a single config")
    opts = p.parse_args(argv)

    case = load_cases(opts.configs, [opts.case])[0]
    device = torch.device("cuda")
    args, meta = build_case(case, device)
    h, i, e = case.dhidden, case.dexpert, case.nroutedexperts
    padded, valid, nb = case.n_padded, case.n_valid, case.num_blocks_m
    print(f"case {case.name}: H={h} I={i} E={e} valid={valid} padded={padded} blocks={nb}")

    up_logits = torch.zeros((padded, i), device=device, dtype=torch.float16)
    if opts.stage == 1:
        ref = ref_stage1(args, meta)
        flops = 4 * valid * h * i
    else:
        golden = ref_stage1(args, meta)
        up_logits.copy_(golden)
        ref = ref_stage2(up_logits, args, meta)
        flops = 2 * valid * h * i
        del golden
    out = torch.zeros((padded, h), device=device, dtype=torch.float16)
    torch.cuda.synchronize()

    if opts.only_cfg:
        cfgs = [with_defaults(json.loads(opts.only_cfg))]
    elif opts.focus3:
        cfgs = gen_focus3(opts.stage)
    elif opts.focus2:
        cfgs = gen_focus2(opts.stage)
    elif opts.focus:
        cfgs = gen_focus(opts.stage)
    else:
        cfgs = gen_configs(opts.stage, opts.quick)
    print(f"sweeping {len(cfgs)} configs for stage {opts.stage}\n")
    results = []
    for idx, cfg in enumerate(cfgs):
        tag = (f"bm{cfg['block_m']} bn{cfg['block_n']} bk{cfg['block_k']} "
               f"t{cfg['threads']} s{cfg['num_stages']} {'sh' if cfg['a_shared'] else 'fr'} "
               f"z{cfg['swizzle']} {cfg['policy'][:3]} kp{cfg['k_pack']}"
               f"{' 1buf' if cfg['one_buf'] else ''}")
        try:
            if opts.stage == 1:
                kern = build_stage1(h, i, e, padded, valid, nb, **cfg)
                call = lambda: kern(args["stacked_expert_tokens"], args["gate_w"], args["up_w"],
                                    args["group_sizes"], args["group_padded_offsets"],
                                    args["group_idx_for_bx"], up_logits)
                target, golden = up_logits, ref
            else:
                kern = build_stage2(h, i, e, padded, valid, nb, **cfg)
                call = lambda: kern(up_logits, args["down_w"], args["routed_expert_weights"],
                                    args["group_sizes"], args["group_offsets"],
                                    args["group_padded_offsets"], args["group_idx_for_bx"], out)
                target, golden = out, ref
            target.zero_()
            call()
            torch.cuda.synchronize()
            err = max_err_valid(target, golden, meta)
            if err > opts.tol:
                print(f"[{idx + 1:3}/{len(cfgs)}] {tag:44} WRONG err={err:.3e}")
                continue
            ms = time_fn(call, opts.warmup, opts.iters)
            results.append((ms, cfg, err))
            print(f"[{idx + 1:3}/{len(cfgs)}] {tag:44} {ms:9.3f} ms  {flops / (ms * 1e-3) / 1e12:7.2f} TF/s  err={err:.2e}")
        except Exception as exc:  # compile / launch failures are expected while sweeping
            msg = str(exc).splitlines()[0][:90] if str(exc) else type(exc).__name__
            print(f"[{idx + 1:3}/{len(cfgs)}] {tag:44} FAIL {msg}")
        finally:
            torch.cuda.empty_cache()

    print(f"\n=== top {opts.top} for stage {opts.stage} (case {case.name}) ===")
    for ms, cfg, err in sorted(results, key=lambda r: r[0])[: opts.top]:
        print(f"{ms:9.3f} ms  {flops / (ms * 1e-3) / 1e12:7.2f} TF/s  {json.dumps(cfg)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
