"""Exchange one row/column ownership bit to form the QK operands.

Each wave loads eight complete 64-column rows at a time. Lane order is
permuted at the load, so converting to MMA ownership only exchanges lane
bit 3 with the high row bit in a register. One uint32 butterfly per word
preserves both FP16 bit patterns and avoids the old full lane transpose.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAMES = {
    "_coalesced_block_loads_prim_mathcast", "_coalesced_block_loads_prim_oct8",
    "_coalesced_block_loads_prim_fp32_sum", "_coalesced_block_loads_prim_fp32_mask",
    "_coalesced_block_loads_prim_boundary_v8",
}


def code(value):
    return ast.parse(value).body


def declarations(which):
    return code(f'''
{which}_raw = T.alloc_local([BK // 4], T.float16)
{which}_words = T.Tensor([BK // 8], T.uint32, data={which}_raw.data, scope="local")
{which}_swapped = T.alloc_local([BK // 8], T.uint32)
{which}_half = T.Tensor([BK // 4], T.float16, data={which}_swapped.data, scope="local")
''')


def load(which, width):
    row = "tid % 8 + half_row * 8"
    col = "slab * 64 + tid % 16 // 8 * 32 + tid // 16 * 8 + word * W + element"
    value = f"Q[i_b, i_t, i_h * G + {row}, {col}]" if which == "qbf" else f"K_blocks[i_b, _selected_block, {row}, i_h, {col}]"
    return code(f'''
for slab in T.unroll(BK // 64):
    for half_row in T.unroll(2):
        for word in T.unroll(8 // {width}):
            for element in T.vectorized({width}):
                {which}_raw[slab * 16 + half_row * 8 + word * {width} + element] = {value.replace('W', str(width))}
''')


def exchange(which, dest):
    return code(f'''
for slab in T.unroll(BK // 64):
    for word in T.unroll(4):
        bf_lo = {which}_words[slab * 8 + word]
        bf_hi = {which}_words[slab * 8 + 4 + word]
        bf_rx = T.shfl_xor(T.if_then_else(tid % 16 < 8, bf_hi, bf_lo), 8, 64, 18446744073709551615)
        {which}_swapped[slab * 8 + word] = T.if_then_else(tid % 16 < 8, bf_lo, bf_rx)
        {which}_swapped[slab * 8 + 4 + word] = T.if_then_else(tid % 16 < 8, bf_rx, bf_hi)
for slab in T.unroll(BK // 32):
    for element in T.unroll(8):
        {dest}[tid % 16, slab * 32 + tid // 16 * 8 + element] = {which}_half[slab * 8 + element]
''')


def transform(fn, qwidth, kwidth):
    fn = copy.deepcopy(fn)
    fn.decorator_list = []
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    guard = next(n for n in scope.body if isinstance(n, ast.If) and "_selected_block >= 0" in ast.unparse(n.test))
    if qwidth:
        scope.body[:0] = declarations("qbf")
        pos = next(i for i,n in enumerate(scope.body) if ast.unparse(n).startswith("T.copy(Q["))
        scope.body[pos:pos+1] = load("qbf", qwidth)
        pos = next(i for i,n in enumerate(guard.body) if ast.unparse(n) == "T.copy(Q_stage, Q_shared)")
        assert [ast.unparse(n) for n in guard.body[pos:pos+4]] == [
            "T.copy(Q_stage, Q_shared)", "T.sync_warp()", "T.copy(Q_shared, Q_reg)", "T.sync_warp()"]
        guard.body[pos:pos+4] = exchange("qbf", "Q_reg")
    if kwidth:
        scope.body[:0] = declarations("kbf")
        layout = next(n for n in scope.body if isinstance(n, ast.Assign) and ast.unparse(n.targets[0]) == "_layout")
        ki = next(i for i,k in enumerate(layout.value.keys) if ast.unparse(k) == "K_reg")
        layout.value.values[ki] = ast.parse('qk.make_mma_load_layout(K_reg, "B")', mode="eval").body
        pos = next(i for i,n in enumerate(guard.body) if isinstance(n, ast.For) and ast.unparse(n.target) == "k_slot")
        guard.body[pos:pos+1] = load("kbf", kwidth)
        pos = next(i for i,n in enumerate(guard.body) if isinstance(n, ast.If) and ast.unparse(n.test) == "not direct_k")
        if not qwidth:
            assert ast.unparse(guard.body[pos-1]) == "T.sync_warp()"
            guard.body.pop(pos-1)
            pos -= 1
        guard.body[pos:pos+1] = exchange("kbf", "K_reg")
        pos = next(i for i,n in enumerate(guard.body) if isinstance(n, ast.Assign) and ast.unparse(n.targets[0]) == "kb")
        assert isinstance(guard.body[pos-1], ast.If) and ast.unparse(guard.body[pos-1].test) == "wave_sync"
        guard.body[pos-1:pos+1] = []
        loop = next(n for n in guard.body if isinstance(n, ast.For) and ast.unparse(n.iter) == "T.serial(qk_steps)")
        loop.body = code("qk.mma(Q_reg, K_reg, acc_s, ki)")
    return ast.unparse(ast.fix_missing_locations(fn))


def prove(dim):
    before = []
    for tid in range(64):
        lane = []
        for slab in range(dim // 64):
            for head in range(2):
                for w in range(4):
                    lane.append(tuple((tid % 8 + head * 8, slab * 64 + tid % 16 // 8 * 32 + tid // 16 * 8 + w * 2 + e) for e in range(2)))
        before.append(lane)
    after = [[None] * (dim // 8) for _ in range(64)]
    for tid in range(64):
        for slab in range(dim // 64):
            for word in range(4):
                lo, hi = slab * 8 + word, slab * 8 + 4 + word
                if tid & 8:
                    after[tid][lo], after[tid][hi] = before[tid ^ 8][hi], before[tid][hi]
                else:
                    after[tid][lo], after[tid][hi] = before[tid][lo], before[tid ^ 8][lo]
    covered = set()
    for tid in range(64):
        data = [x for pair in after[tid] for x in pair]
        for slab in range(dim // 32):
            for element in range(8):
                target = (tid % 16, slab * 32 + tid // 16 * 8 + element)
                assert data[slab * 8 + element] == target
                covered.add(target)
    assert len(covered) == 16 * dim
    return dict(dim=dim, pairs=16 * dim // 2, mapping="PASS")


def main():
    source = (HERE / "baseline.py").read_text()
    records = []
    for qw, kw in ((8, 0), (2, 0), (0, 2), (8, 2), (2, 2)):
        result = source
        for fn in ast.parse(source).body:
            if isinstance(fn, ast.FunctionDef) and fn.name in NAMES:
                result = result.replace(ast.get_source_segment(source, fn), transform(fn, qw, kw), 1)
        ast.parse(result)
        path = HERE / f"butterfly_q{qw}_k{kw}.py"
        with path.open("x") as out:
            out.write(result)
        records.append(dict(path=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(), q_load=qw, k_load=kw))
    (HERE / "operand_butterfly_manifest.json").write_text(json.dumps(dict(
        baseline_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
        layout_proofs=[prove(64), prove(128)],
        fences="Only RAW/WAR fences for the eliminated shared Q/K conversion are removed; all remaining shared lifetimes stay fenced."), indent=2) + "\n")
    print("Generated", len(records), "operand butterfly variants", flush=True)


if __name__ == "__main__":
    main()
