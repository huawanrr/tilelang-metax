#!/usr/bin/env python3
"""Build A/B variants of `submission.py` for the swizzle x k_pack matrix.

`submission.py` is the current best (v40 kernels + `make_mma_swizzle_layout(vecSize=4)`
on every MMA shared tile).  The two things left to price are the swizzle's `vecSize`
and whether the emitter's `k_pack=2` still pays once the swizzle is in.  Both are
lowering-level, so each variant has to be timed in its own process *and* its own
TileLang cache directory: the on-disk cache keys on the prim_func and the pass
configs, and neither changes when `k_pack` does.

    python mkvariant.py            # writes /tmp/var_*.py
"""
import re
import sys

HERE = "/data/tilelang-metax/race_tests/moe/"
OUT = "/tmp/"


def read(path):
    with open(HERE + path) as f:
        return f.read()


def kpack_prelude():
    """Lines 1..145 of submission_kpack.py: _reach / _enable_maca_k_pack / _k_pack_on."""
    src = read("submission_kpack.py").split("\n")
    # from `_K_PACK_ON = 1` up to (not including) `_KERNEL_CACHE = {}`
    start = next(i for i, l in enumerate(src) if l.startswith("_K_PACK_ON ="))
    end = next(i for i, l in enumerate(src) if l.startswith("_KERNEL_CACHE ="))
    return "\n".join(src[start:end])


def build(name, vec_size=4, kpack=False, threads=None, extra_sub=None, post=None):
    src = read("submission.py")
    if vec_size != 4:
        src = src.replace("vecSize=4", "vecSize=%d" % vec_size)
    if vec_size == 0:
        src = re.sub(
            r"\n *T\.annotate_layout\(\{[^}]*\}\)", "", src, flags=re.S)
    if kpack:
        src = src.replace(
            "_KERNEL_CACHE = {}", kpack_prelude() + "\n_KERNEL_CACHE = {}", 1)
        src = src.replace(
            "    kernel = _KERNEL_CACHE.get(key)\n    if kernel is None:\n",
            "    kernel = _KERNEL_CACHE.get(key)\n    if kernel is None:\n"
            "        _k_pack_on()\n", 1)
        assert "_k_pack_on()" in src
    if threads:
        s1, s2 = threads
        src = src.replace("    stage1_threads = 256", "    stage1_threads = %d" % s1, 1)
        src = src.replace("    stage2_threads = 256", "    stage2_threads = %d" % s2, 1)
    for a, b in (extra_sub or []):
        assert a in src, a
        src = src.replace(a, b, 1)
    if post is not None:
        src = post(src)
    path = OUT + "var_%s.py" % name
    with open(path, "w") as f:
        f.write(src)
    print(path)


def _stmts(lines, start, indent):
    """Group `lines[start:]` into statements at `indent`, stopping at a dedent.

    A statement ends only where bracket depth is back to zero, so a multi-line
    `T.copy(...)` whose closing paren sits at the statement's own indent stays
    one statement.
    """
    out, cur, depth = [], [], 0
    i = start
    while i < len(lines):
        line = lines[i]
        if not line.strip():
            cur.append(line)
            i += 1
            continue
        ind = len(line) - len(line.lstrip())
        if ind < indent and depth == 0:
            break
        if ind == indent and cur and depth == 0:
            out.append(cur)
            cur = [line]
        else:
            cur.append(line)
        depth += line.count("(") - line.count(")")
        depth += line.count("[") - line.count("]")
        i += 1
    if cur:
        out.append(cur)
    return out, i


def stage1_prefetch(src):
    """Stage the up-weight tile through registers so its global load issues early.

    The one-weight-buffer k-loop is `copy A -> copy gate -> [sync] -> gemm(gate)
    -> [sync] -> copy up -> [sync] -> gemm(up) -> [sync]`.  The `copy up` sits
    between two barriers with nothing to overlap its DRAM latency, and it cannot
    be given its own shared buffer: 48 KiB drops the CU from two resident blocks
    to one, which costs 65%.

    Registers are the one resource with slack (mcTracer: 234 of the 256 per
    thread that two blocks/CU allow).  A 128x64 fp16 tile over 256 threads is 32
    elements = 16 VGPRs, so the tile can be read into a fragment *before* the
    barrier that gates the gate GEMM, and written to shared afterwards.  The
    global load then overlaps the gate GEMM and only the LDS write stays on the
    critical path.  Barrier count is unchanged.
    """
    lines = src.split("\n")
    out = []
    i = 0
    while i < len(lines):
        line = lines[i]
        stripped = line.strip()
        ind = len(line) - len(line.lstrip())
        if stripped == "T.annotate_layout({" and "input_shared" in lines[i + 1]:
            out.append(" " * ind + "w_stage = T.alloc_fragment("
                       "(stage1_block_n, stage1_block_k), dtype=dtype)")
            out.append(line)
            i += 1
            continue
        if stripped == "if stage1_one_weight_buffer:" and "T.gemm(" in lines[i + 1]:
            body, nxt = _stmts(lines, i + 1, ind + 4)
            assert len(body) == 3, [b[0] for b in body]
            gemm_gate, copy_up, gemm_up = body
            assert "T.copy(" in copy_up[0], copy_up[0]
            hoisted = [l.replace("up_weight_shared,", "w_stage,") for l in copy_up]
            out.append(line)
            out.extend(hoisted)
            out.extend(gemm_gate)
            out.append(" " * (ind + 4) + "T.copy(w_stage, up_weight_shared)")
            out.extend(gemm_up)
            i = nxt
            continue
        out.append(line)
        i += 1
    new = "\n".join(out)
    assert new.count("w_stage = T.alloc_fragment") == 3, new.count("w_stage")
    return new


def stage1_pipeline(src, only=(2,)):
    """Turn a stage-1 scope's k-loop into a register-staged software pipeline.

    `stage1_prefetch` hides the up-weight tile's DRAM latency behind the gate
    GEMM, but the A and gate tiles are still loaded at the top of the k-step with
    nothing to overlap them.  Hiding those needs the *next* step's loads issued
    during this step's GEMMs, i.e. a real pipeline -- which without async copy
    means staging them in registers, since a second shared buffer costs 65%.

    Cost is 8 VGPRs for a 64x64 A tile plus 16 for the 128x64 gate tile.  Only
    scopes with register slack can take it: mcTracer puts stage 1's main scope at
    256 of 256 after `stage1_prefetch`, and the M64 tail scope at 176, so the
    default `only=(2,)` applies it to the tail scope alone.

    Reads past the last k-step are clamped to it rather than predicated: one
    duplicate tile read per block is cheaper than a branch in the loop, and the
    value is never used.
    """
    lines = src.split("\n")
    out = []
    i = 0
    seen = 0
    while i < len(lines):
        line = lines[i]
        ind = len(line) - len(line.lstrip())
        if (line.strip() == "for k in T.unroll("
                and "stacked_expert_tokens[" in "".join(lines[i + 1:i + 8])):
            take = seen in only
            seen += 1
            if take:
                # The `for` header spans lines until its brackets close.
                h = i
                depth = 0
                while True:
                    depth += lines[h].count("(") - lines[h].count(")")
                    if depth == 0:
                        break
                    h += 1
                head = lines[i:h + 1]
                body, nxt = _stmts(lines, h + 1, ind + 4)
                copy_a, copy_g, if_blk = body[0], body[1], body[2:]
                rows = copy_a[2].split("block_start + ")[1].strip().rstrip(",")
                pro_a = [l.replace(
                    "k * stage1_block_k : (k + 1) * stage1_block_k",
                    "0 : stage1_block_k").replace(
                    "input_shared,", "a_stage,") for l in copy_a]
                pro_g = [l.replace(
                    "k * stage1_block_k : (k + 1) * stage1_block_k",
                    "0 : stage1_block_k").replace(
                    "weight_shared,", "g_stage,") for l in copy_g]
                nxt_a = [l.replace(
                    "k * stage1_block_k : (k + 1) * stage1_block_k",
                    "k_next * stage1_block_k : (k_next + 1) * stage1_block_k")
                    .replace("input_shared,", "a_stage,") for l in copy_a]
                nxt_g = [l.replace(
                    "k * stage1_block_k : (k + 1) * stage1_block_k",
                    "k_next * stage1_block_k : (k_next + 1) * stage1_block_k")
                    .replace("weight_shared,", "g_stage,") for l in copy_g]
                pad = " " * ind
                out.append(pad + "a_stage = T.alloc_fragment((%s, stage1_block_k), "
                                 "dtype=dtype)" % rows)
                out.append(pad + "g_stage = T.alloc_fragment((stage1_block_n, "
                                 "stage1_block_k), dtype=dtype)")
                out.extend(l[4:] for l in pro_a)
                out.extend(l[4:] for l in pro_g)
                out.extend(head)
                out.append(pad + "    k_next = T.min("
                                 "k + 1, T.ceildiv(hidden, stage1_block_k) - 1)")
                out.append(pad + "    T.copy(a_stage, input_shared)")
                out.append(pad + "    T.copy(g_stage, weight_shared)")
                # The next step's global reads go after the gate GEMM, so their
                # latency is covered by the up GEMM.
                inner_ind = ind + 8
                for stmt in if_blk:
                    j = 0
                    while j < len(stmt):
                        cur = stmt[j]
                        depth = cur.count("(") - cur.count(")")
                        piece = [cur]
                        while depth > 0:
                            j += 1
                            piece.append(stmt[j])
                            depth += stmt[j].count("(") - stmt[j].count(")")
                        out.extend(piece)
                        text = "".join(piece)
                        if ("T.gemm(" in piece[0] and "gate_local" in text
                                and len(piece[0]) - len(piece[0].lstrip()) == inner_ind):
                            shift = " " * (inner_ind - ind - 4)
                            out.extend(shift + l for l in nxt_a)
                            out.extend(shift + l for l in nxt_g)
                        j += 1
                i = nxt
                continue
        out.append(line)
        i += 1
    new = "\n".join(out)
    assert new.count("a_stage = T.alloc_fragment") == len(only)
    assert new.count("T.copy(a_stage, input_shared)") == len(only)
    return new


def stage2_prefetch(src, only=None):
    """Same register staging for stage 2's second (paired) down-weight tile.

    Stage 2's k-loop is `copy up_logits -> copy down[n0] -> [sync] -> gemm(n0)
    -> [sync] -> copy down[n1] -> [sync] -> gemm(n1)`, so `copy down[n1]` has the
    same fully exposed DRAM latency as stage 1's up-weight copy.  Hoisting its
    global read above the first GEMM needs 16 more VGPRs, and the *main* scope
    already sits at 244 of the 256 that two blocks per CU allow: measured, it
    drops to one block per CU and loses 8%.  The tail scope is at 154, so
    `only=(1,)` applies the staging where it fits and nowhere else.
    """
    lines = src.split("\n")
    out = []
    i = 0
    seen = 0
    n_alloc = 0
    while i < len(lines):
        line = lines[i]
        stripped = line.strip()
        ind = len(line) - len(line.lstrip())
        if stripped == "T.annotate_layout({" and "up_tile_shared" in lines[i + 1]:
            if only is None or n_alloc in only:
                out.append(" " * ind + "d_stage = T.alloc_fragment("
                           "(stage2_block_n, stage2_block_k), dtype=dtype)")
            n_alloc += 1
            out.append(line)
            i += 1
            continue
        if stripped == "if stage2_pair == 2:" and "T.copy(" in lines[i + 1]:
            take = only is None or seen in only
            seen += 1
            if not take:
                out.append(line)
                i += 1
                continue
            body, nxt = _stmts(lines, i + 1, ind + 4)
            assert len(body) == 2, [b[0] for b in body]
            copy_n1, gemm_n1 = body
            hoisted = [l.replace("down_shared,", "d_stage,") for l in copy_n1]
            # Back up over the already-emitted gemm(n0) and put the hoisted
            # global read in front of it.
            p = len(out) - 1
            while not (out[p].strip().startswith("T.gemm(")
                       and len(out[p]) - len(out[p].lstrip()) == ind):
                p -= 1
            out[p:p] = [" " * ind + "if stage2_pair == 2:"] + hoisted
            out.append(line)
            out.append(" " * (ind + 4) + "T.copy(d_stage, down_shared)")
            out.extend(gemm_n1)
            i = nxt
            continue
        out.append(line)
        i += 1
    new = "\n".join(out)
    want = 2 if only is None else len(only)
    assert new.count("d_stage = T.alloc_fragment") == want
    assert new.count("T.copy(d_stage, down_shared)") == want
    return new


def both_prefetch(src):
    return stage2_prefetch(stage1_prefetch(src))


if __name__ == "__main__":
    build("sw4", vec_size=4)
    build("sw8", vec_size=8)
    build("sw4kp", vec_size=4, kpack=True)
    build("sw8kp", vec_size=8, kpack=True)
    build("nosw", vec_size=0)
    build("sw4kp512", vec_size=4, kpack=True, threads=(512, 256))
    build("sw8kp512", vec_size=8, kpack=True, threads=(512, 256))
    # Post-swizzle thread re-tune: the swizzle removed the LDS bank conflicts that
    # set the wave-tile trade-off, so 256/256 is no longer known to be optimal.
    build("t512_256", threads=(512, 256))
    build("t256_512", threads=(256, 512))
    build("t512_512", threads=(512, 512))
    build("t128_256", threads=(128, 256))
    build("pf1", post=stage1_prefetch)
