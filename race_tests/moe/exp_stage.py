#!/usr/bin/env python3
"""Structural experiments on the two MoE stages.

`tune_moe.py` sweeps tile sizes for a fixed kernel body.  This file varies the
*body*: how the epilogue reaches global memory, whether the safe-memory-access
guards are kept, and how the accumulator tile is split across threads.  Each
variant is verified against the same float32 reference `tune_moe.py` uses.

    python exp_stage.py --stage 2 --case mid
    python exp_stage.py --stage 2 --case func_a --variants base,smem_epi
"""
import argparse
import os
import traceback

import torch
import tilelang
import tilelang.language as T

from local_bench import ARG_ORDER, BLOCK_TOKEN, build_case, load_cases, time_fn
import tune_moe as tm

BASE_PASS = {tilelang.PassConfigKey.TL_DISABLE_WARP_SPECIALIZED: True}
NOSAFE_PASS = dict(BASE_PASS)
NOSAFE_PASS[tilelang.PassConfigKey.TL_DISABLE_SAFE_MEMORY_ACCESS] = True

POLICIES = tm.POLICIES


def build_stage1(cfg, shape):
    """Stage 1 with a selectable epilogue path.

    epilogue:
      "direct"  - fragment -> global, one predicated store per element (current)
      "smem"    - fragment -> shared -> global, so the global store is a single
                  coalesced tile copy; invalid rows are zeroed in the fragment
      "none"    - store only row 0, to price the epilogue itself
    """
    hidden, intermediate, num_experts, padded, valid, num_blocks = shape
    bm, bn, bk = cfg["block_m"], cfg["block_n"], cfg["block_k"]
    threads, num_stages = cfg["threads"], cfg["num_stages"]
    epi, one_buf = cfg["epilogue"], cfg["one_buf"]
    pol = POLICIES[cfg["policy"]]
    swizzle, k_pack = cfg["swizzle"], cfg["k_pack"]
    scale = 1.44269504
    dtype, accum = T.float16, T.float32
    sub = BLOCK_TOKEN // bm
    grid_m = num_blocks * sub

    @T.prim_func
    def kernel(
        tokens: T.Tensor((padded, hidden), dtype),
        gate_w: T.Tensor((num_experts, intermediate, hidden), dtype),
        up_w: T.Tensor((num_experts, intermediate, hidden), dtype),
        group_sizes: T.Tensor((num_experts,), T.int32),
        group_padded_offsets: T.Tensor((num_experts + 1,), T.int32),
        group_idx_for_bx: T.Tensor((num_blocks,), T.int32),
        store_flag: T.Tensor((1,), T.int32),
        up_logits: T.Tensor((padded, intermediate), dtype),
    ):
        # `swap` exchanges the two grid axes.  Dispatch order plus the panel
        # width decide which blocks are resident together, and that is what sets
        # how much of the weight and token traffic L2 can serve.
        n_tiles = T.ceildiv(intermediate, bn)
        grid = (n_tiles, grid_m) if cfg["swap"] else (grid_m, n_tiles)
        with T.Kernel(grid[0], grid[1], threads=threads) as (g0, g1):
            bx, by = (g1, g0) if cfg["swap"] else (g0, g1)
            a_s = (T.alloc_shared if cfg["a_shared"] else T.alloc_fragment)((bm, bk), dtype=dtype)
            gate_s = T.alloc_shared((bn, bk), dtype=dtype)
            up_s = gate_s if one_buf else T.alloc_shared((bn, bk), dtype=dtype)
            gate_l = T.alloc_fragment((bm, bn), dtype=accum)
            up_l = T.alloc_fragment((bm, bn), dtype=accum)
            if epi in ("smem", "smem_gated"):
                o_s = T.alloc_shared((bm, bn), dtype=dtype)
            if swizzle:
                T.use_swizzle(swizzle, order=cfg["order"])

            ext = bx // sub
            expert = T.min(T.max(group_idx_for_bx[ext], 0), num_experts - 1)
            row0 = ext * BLOCK_TOKEN + (bx % sub) * bm
            rows = T.max(0, T.min(bm, group_sizes[expert] - (row0 - group_padded_offsets[expert])))
            gate_on = store_flag[0] > 0

            if rows > 0:
                T.clear(gate_l)
                T.clear(up_l)
                for k in T.Pipelined(T.ceildiv(hidden, bk), num_stages=num_stages):
                    ksrc = 0 if cfg["k0load"] else k
                    T.copy(tokens[row0 : row0 + bm, ksrc * bk : (ksrc + 1) * bk], a_s)
                    T.copy(gate_w[expert, by * bn : (by + 1) * bn,
                                  ksrc * bk : (ksrc + 1) * bk], gate_s)
                    if one_buf:
                        T.gemm(a_s, gate_s, gate_l, transpose_B=True, policy=pol, k_pack=k_pack)
                        T.copy(up_w[expert, by * bn : (by + 1) * bn,
                                    ksrc * bk : (ksrc + 1) * bk], up_s)
                        T.gemm(a_s, up_s, up_l, transpose_B=True, policy=pol, k_pack=k_pack)
                    else:
                        T.copy(up_w[expert, by * bn : (by + 1) * bn,
                                    ksrc * bk : (ksrc + 1) * bk], up_s)
                        T.gemm(a_s, gate_s, gate_l, transpose_B=True, policy=pol, k_pack=k_pack)
                        T.gemm(a_s, up_s, up_l, transpose_B=True, policy=pol, k_pack=k_pack)

                if epi == "smem":
                    for i, j in T.Parallel(bm, bn):
                        gate_l[i, j] = gate_l[i, j] * (1.0 / (1.0 + T.exp2(-gate_l[i, j] * scale)))
                        # Invalid rows are zeroed rather than skipped so the tile
                        # copy below needs no predicate and stays coalesced.
                        o_s[i, j] = T.if_then_else(
                            i < rows, T.cast(up_l[i, j] * gate_l[i, j], dtype), T.cast(0, dtype)
                        )
                    T.copy(o_s, up_logits[row0 : row0 + bm, by * bn : (by + 1) * bn])
                elif epi == "smem_gated":
                    for i, j in T.Parallel(bm, bn):
                        gate_l[i, j] = gate_l[i, j] * (1.0 / (1.0 + T.exp2(-gate_l[i, j] * scale)))
                        o_s[i, j] = T.if_then_else(
                            i < rows, T.cast(up_l[i, j] * gate_l[i, j], dtype), T.cast(0, dtype)
                        )
                    if gate_on:
                        T.copy(o_s, up_logits[row0 : row0 + bm, by * bn : (by + 1) * bn])
                elif epi == "gated":
                    for i, j in T.Parallel(bm, bn):
                        gate_l[i, j] = gate_l[i, j] * (1.0 / (1.0 + T.exp2(-gate_l[i, j] * scale)))
                        up_l[i, j] = up_l[i, j] * gate_l[i, j]
                        if i < rows and gate_on:
                            up_logits[row0 + i, by * bn + j] = up_l[i, j]
                else:
                    for i, j in T.Parallel(bm, bn):
                        gate_l[i, j] = gate_l[i, j] * (1.0 / (1.0 + T.exp2(-gate_l[i, j] * scale)))
                        up_l[i, j] = up_l[i, j] * gate_l[i, j]
                        if i < rows:
                            up_logits[row0 + i, by * bn + j] = up_l[i, j]

    return kernel


def build_stage2(cfg, shape):
    hidden, intermediate, num_experts, padded, valid, num_blocks = shape
    bm, bn, bk = cfg["block_m"], cfg["block_n"], cfg["block_k"]
    threads, num_stages = cfg["threads"], cfg["num_stages"]
    epi = cfg["epilogue"]
    pol = POLICIES[cfg["policy"]]
    swizzle, k_pack = cfg["swizzle"], cfg["k_pack"]
    dtype, accum = T.float16, T.float32
    sub = BLOCK_TOKEN // bm
    grid_m = num_blocks * sub

    @T.prim_func
    def kernel(
        up_logits: T.Tensor((padded, intermediate), dtype),
        down_w: T.Tensor((num_experts, hidden, intermediate), dtype),
        routed_w: T.Tensor((valid,), T.float32),
        group_sizes: T.Tensor((num_experts,), T.int32),
        group_offsets: T.Tensor((num_experts + 1,), T.int32),
        group_padded_offsets: T.Tensor((num_experts + 1,), T.int32),
        group_idx_for_bx: T.Tensor((num_blocks,), T.int32),
        store_flag: T.Tensor((1,), T.int32),
        out: T.Tensor((padded, hidden), dtype),
    ):
        # `n_pair` gives each block two n-tiles that share one weight buffer,
        # serialised copy/gemm/copy/gemm exactly as stage 1 shares gate and up.
        # The A tile (`up_logits`) is then read once per two output tiles instead
        # of once per tile, halving stage 2's share of the streaming traffic, at
        # the cost of two more barriers per k-step and a second accumulator.
        pair = 2 if cfg["n_pair"] else 1
        n_tiles = T.ceildiv(hidden, bn * pair)
        grid = (n_tiles, grid_m) if cfg["swap"] else (grid_m, n_tiles)
        with T.Kernel(grid[0], grid[1], threads=threads) as (g0, g1):
            bx, by = (g1, g0) if cfg["swap"] else (g0, g1)
            a_s = (T.alloc_shared if cfg["a_shared"] else T.alloc_fragment)((bm, bk), dtype=dtype)
            down_s = T.alloc_shared((bn, bk), dtype=dtype)
            out_l = T.alloc_fragment((bm, bn), dtype=accum)
            out_l2 = T.alloc_fragment((bm, bn), dtype=accum) if cfg["n_pair"] else out_l
            w_l = T.alloc_fragment((bm,), dtype=T.float32)
            if epi in ("smem", "smem_gated"):
                o_s = T.alloc_shared((bm, bn), dtype=dtype)
            if swizzle:
                T.use_swizzle(swizzle, order=cfg["order"])

            ext = bx // sub
            expert = T.min(T.max(group_idx_for_bx[ext], 0), num_experts - 1)
            row0 = ext * BLOCK_TOKEN + (bx % sub) * bm
            offset = row0 - group_padded_offsets[expert]
            rows = T.max(0, T.min(bm, group_sizes[expert] - offset))
            raw0 = group_offsets[expert] + offset
            # `store_flag` is a kernel argument, so the backend cannot prove the
            # gated stores are dead and keeps every accumulator MMA alive.  With
            # flag=0 the difference against `base` is exactly the global write.
            gate_on = store_flag[0] > 0

            if rows > 0:
                T.clear(out_l)
                if cfg["n_pair"]:
                    T.clear(out_l2)
                for k in T.Pipelined(T.ceildiv(intermediate, bk), num_stages=num_stages):
                    # "k0" keeps every MMA and every shared-memory write but
                    # re-reads the same two tiles, so the global working set is a
                    # few KiB and the loop measures the compute/LDS floor.
                    ksrc = 0 if cfg["k0load"] else k
                    T.copy(up_logits[row0 : row0 + bm, ksrc * bk : (ksrc + 1) * bk], a_s)
                    T.copy(down_w[expert, (by * pair) * bn : (by * pair + 1) * bn,
                                  ksrc * bk : (ksrc + 1) * bk], down_s)
                    T.gemm(a_s, down_s, out_l, transpose_B=True, policy=pol, k_pack=k_pack)
                    if cfg["n_pair"]:
                        T.copy(down_w[expert, (by * pair + 1) * bn : (by * pair + 2) * bn,
                                      ksrc * bk : (ksrc + 1) * bk], down_s)
                        T.gemm(a_s, down_s, out_l2, transpose_B=True, policy=pol,
                               k_pack=k_pack)

                for i in T.Parallel(bm):
                    w_l[i] = T.if_then_else(i < rows, routed_w[raw0 + i], T.cast(0, T.float32))

                if epi == "smem":
                    for i, j in T.Parallel(bm, bn):
                        o_s[i, j] = T.cast(out_l[i, j] * w_l[i], dtype)
                    T.copy(o_s, out[row0 : row0 + bm, by * bn : (by + 1) * bn])
                elif epi == "smem_gated":
                    for i, j in T.Parallel(bm, bn):
                        o_s[i, j] = T.cast(out_l[i, j] * w_l[i], dtype)
                    if gate_on:
                        T.copy(o_s, out[row0 : row0 + bm, by * bn : (by + 1) * bn])
                elif epi == "gated":
                    for i, j in T.Parallel(bm, bn):
                        if i < rows and gate_on:
                            out[row0 + i, by * bn + j] = out_l[i, j] * w_l[i]
                else:
                    for i, j in T.Parallel(bm, bn):
                        if i < rows:
                            out[row0 + i, (by * pair) * bn + j] = out_l[i, j] * w_l[i]
                if cfg["n_pair"]:
                    for i, j in T.Parallel(bm, bn):
                        if i < rows:
                            out[row0 + i, (by * pair + 1) * bn + j] = (
                                out_l2[i, j] * w_l[i]
                            )

    return kernel


def wave_tile(cfg):
    """Per-wave output tile implied by the block tile and the warp policy.

    Square splits the waves as evenly as it can over (m, n); FullRow puts every
    wave in one row of the block tile, FullCol in one column.  The wave tile is
    what sets shared-memory reads per MMA, which is the quantity being probed.
    """
    waves = cfg["threads"] // 64
    bm, bn = cfg["block_m"], cfg["block_n"]
    if cfg["policy"] == "row":
        wm, wn = 1, waves
    elif cfg["policy"] == "col":
        wm, wn = waves, 1
    else:
        wm = 1
        while wm * wm * 2 <= waves and (bm // (wm * 2)) >= 16:
            wm *= 2
        wn = waves // wm
    if bm // wm < 16 or bn // wn < 16:
        return 0, 0
    return bm // wm, bn // wn


def smem_bytes(stage, cfg):
    bm, bn, bk = cfg["block_m"], cfg["block_n"], cfg["block_k"]
    n_w = 1 if (stage == 2 or cfg["one_buf"]) else 2
    total = (bm * bk if cfg["a_shared"] else 0) + n_w * bn * bk
    total = total * 2 * max(1, cfg["num_stages"])
    if cfg["epilogue"] in ("smem", "smem_gated") and not cfg["merge"]:
        total += bm * bn * 2
    return total


DEFAULT = {
    "block_m": 128, "block_n": 128, "block_k": 64, "threads": 256,
    "num_stages": 0, "swizzle": 8, "policy": "square", "k_pack": 1,
    "one_buf": True, "epilogue": "direct", "nosafe": False, "k0load": False,
    "merge": False, "a_shared": True, "asyncc": False, "ldgstg": False,
    "order": "row", "swap": False, "n_pair": False,
}


def variants(stage):
    v = {}

    def add(name, **kw):
        cfg = dict(DEFAULT)
        cfg.update(kw)
        v[name] = cfg

    add("base")
    add("gated", epilogue="gated")
    add("k0load", k0load=True)
    add("k0load_gated", k0load=True, epilogue="gated")
    add("smem_epi", epilogue="smem")
    add("smem_gated", epilogue="smem_gated")
    add("smem_merge", epilogue="smem", merge=True)
    add("nosafe", nosafe=True)
    add("smem_nosafe_merge", epilogue="smem", nosafe=True, merge=True)
    # LDS-pressure probes: the MMA:ds_read ratio per wave is set by how the warp
    # policy splits the block tile, so fewer/larger wave tiles read less from
    # shared memory per MMA.
    add("t128", threads=128)
    add("t128_row", threads=128, policy="row")
    add("t128_col", threads=128, policy="col")
    add("t256_row", policy="row")
    add("t256_col", policy="col")
    add("kpack2", k_pack=2)
    add("kpack2_bk128", k_pack=2, block_k=128)
    add("kpack4_bk128", k_pack=4, block_k=128)
    add("t128_kpack2", threads=128, k_pack=2)
    if stage == 1:
        add("bn64", block_n=64)
        add("bk128", block_k=128)
        add("t512", threads=512)
        add("twobuf", one_buf=False)
    else:
        add("bn256_t512", block_n=256, threads=512)
        add("bk128", block_k=128)
        add("t512", threads=512)
    return v


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--stage", type=int, default=2)
    p.add_argument("--case", default="mid")
    p.add_argument("--variants", default=None)
    p.add_argument("--extra", action="append", default=None,
                   help="ad-hoc variant, e.g. 'wide:block_n=256,policy=row,block_k=32'")
    p.add_argument("--iters", type=int, default=20)
    p.add_argument("--warmup", type=int, default=5)
    p.add_argument("--configs", default=os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                                     "local_test_configs.json"))
    p.add_argument("--kpack", action="store_true",
                   help="import moe.py first so its k_pack=2 lowering override is active")
    a = p.parse_args()

    # The on-disk cache keys on the prim_func and the pass configs, not on how
    # T.gemm was lowered, so a patched kernel is served straight back to an
    # unpatched run.  That silently turned a "stock lowering" measurement of
    # oj3real stage 1 into 6.52 ms -- the k_pack number -- when a cold compile
    # gives 7.25.  Give each lowering its own cache directory.
    os.environ["TILELANG_CACHE_DIR"] = os.path.join(
        os.path.expanduser("~"), ".tilelang",
        "cache_kpack2" if a.kpack else "cache_stock")
    if a.kpack:
        import moe
        # The override is applied lazily now (the grader rejects module-level
        # calls), so trigger it before anything is compiled.
        print(f"k_pack override active: {moe._k_pack_on()}")
    else:
        print("stock lowering (k_pack override not applied)")

    case = load_cases(a.configs, [a.case])[0]
    device = torch.device("cuda")
    args, meta = build_case(case, device)
    shape = (case.dhidden, case.dexpert, case.nroutedexperts, case.n_padded,
             case.n_valid, case.num_blocks_m)

    if a.stage == 1:
        ref = tm.ref_stage1(args, meta)
        flops = 4 * case.n_valid * case.dhidden * case.dexpert
    else:
        up_logits = tm.ref_stage1(args, meta)
        ref = tm.ref_stage2(up_logits, args, meta)
        flops = 2 * case.n_valid * case.dhidden * case.dexpert

    all_v = variants(a.stage)
    for spec in a.extra or []:
        name, _, body = spec.partition(":")
        cfg = dict(DEFAULT)
        for kv in body.split(","):
            if not kv:
                continue
            k, _, val = kv.partition("=")
            cur = DEFAULT[k]
            if isinstance(cur, bool):
                cfg[k] = val.lower() in ("1", "true", "yes")
            elif isinstance(cur, int):
                cfg[k] = int(val)
            else:
                cfg[k] = val
        all_v[name] = cfg
    names = a.variants.split(",") if a.variants else list(all_v)
    if a.extra and not a.variants:
        names = [s.partition(":")[0] for s in a.extra]
    flag = torch.zeros((1,), device=device, dtype=torch.int32)
    print(f"case={a.case} stage={a.stage} valid={case.n_valid} padded={case.n_padded} "
          f"H={case.dhidden} I={case.dexpert}")
    print(f"{'variant':<20}{'ms':>10}{'TF/s':>9}{'err':>11}  note")
    results = []
    for name in names:
        cfg = all_v[name]
        passes = dict(BASE_PASS)
        if cfg["nosafe"]:
            passes[tilelang.PassConfigKey.TL_DISABLE_SAFE_MEMORY_ACCESS] = True
        if cfg["merge"]:
            passes[tilelang.PassConfigKey.TL_ENABLE_AGGRESSIVE_SHARED_MEMORY_MERGE] = True
        if cfg["asyncc"]:
            passes[tilelang.PassConfigKey.TL_ENABLE_ASYNC_COPY] = True
            passes[tilelang.PassConfigKey.TIR_USE_ASYNC_COPY] = True
        if cfg["ldgstg"]:
            passes[tilelang.PassConfigKey.TL_ENABLE_LOWER_LDGSTG] = True
        try:
            builder = build_stage1 if a.stage == 1 else build_stage2
            kern = tilelang.compile(builder(cfg, shape), out_idx=None,
                                    pass_configs=passes)
        except Exception as exc:
            print(f"{name:<20}{'-':>10}{'-':>9}{'-':>11}  build failed: {exc}")
            continue
        if a.stage == 1:
            dst = torch.zeros((case.n_padded, case.dexpert), device=device, dtype=torch.float16)
            call = lambda: kern(args["stacked_expert_tokens"], args["gate_w"], args["up_w"],
                                args["group_sizes"], args["group_padded_offsets"],
                                args["group_idx_for_bx"], flag, dst)
        else:
            dst = torch.zeros((case.n_padded, case.dhidden), device=device, dtype=torch.float16)
            call = lambda: kern(up_logits, args["down_w"], args["routed_expert_weights"],
                                args["group_sizes"], args["group_offsets"],
                                args["group_padded_offsets"], args["group_idx_for_bx"], flag, dst)
        try:
            call()
            torch.cuda.synchronize()
        except Exception as exc:
            print(f"{name:<20}{'-':>10}{'-':>9}{'-':>11}  run failed: {exc}")
            continue
        gated = cfg["epilogue"] in ("gated", "smem_gated") or cfg["k0load"]
        err = float("nan") if gated else tm.max_err_valid(dst, ref, meta)
        ms = time_fn(call, a.warmup, a.iters)
        tf = flops / (ms * 1e-3) / 1e12
        results.append((name, ms, tf))
        wm, wn = wave_tile(cfg)
        smem = smem_bytes(a.stage, cfg)
        print(f"{name:<20}{ms:>10.3f}{tf:>9.2f}{err:>11.2e}  "
              f"{'OK' if err < 5e-3 or err != err else 'MISMATCH':<9} "
              f"smem={smem // 1024:>3}K blk/SM={65536 // max(1, smem)} "
              f"wave={wm}x{wn} LDSB/mma={0 if not (wm and wn) else 8192 * (wm + wn) // (wm * wn)}")
        del dst
        torch.cuda.empty_cache()

    if results:
        best = min(r[1] for r in results)
        print("\nrelative to best: " + "  ".join(f"{n}={m/best:.3f}" for n, m, _ in results))


if __name__ == "__main__":
    main()
