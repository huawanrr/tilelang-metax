"""Read K in 32-column slabs and exchange uint32 words inside one wave.

Each source lane reads eight consecutive halves, and the fixed 16x4 lane
transpose provides the exact QK operand. The shared Q-to-V lifetime fence
is retained; only the two fences surrounding the removed K shared tile go.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
SOURCE = (HERE / "parent.py").read_text()
TARGETS = {"_coalesced_block_loads_prim_mathcast", "_coalesced_block_loads_prim_oct8"}


def expr(node):
    return ast.unparse(node)


def is_call(node, value):
    return isinstance(node, ast.Expr) and expr(node).startswith(value)


def transform(function, early):
    function = copy.deepcopy(function)
    kernel = next(n for n in function.body if isinstance(n, ast.FunctionDef) and n.name == "kernel")
    body = next(n for n in kernel.body if isinstance(n, ast.With)).body
    guard = next(n for n in body if isinstance(n, ast.If) and "_selected_block >= 0" in expr(n.test))
    declarations = ast.parse("""
reg_k_raw = T.alloc_local([BK // 4], T.float16)
reg_k_words = T.Tensor([BK // 8], T.uint32, data=reg_k_raw.data, scope='local')
reg_k_mma_words = T.alloc_local([4], T.uint32)
reg_k_mma = T.Tensor([8], T.float16, data=reg_k_mma_words.data, scope='local')
""").body
    body[0:0] = declarations
    load = ast.parse("""
for k_slab in T.unroll(BK // 32):
    for k_word in T.unroll(4):
        for k_half in T.vectorized(2):
            reg_k_raw[k_slab * 8 + k_word * 2 + k_half] = K_blocks[i_b, _selected_block, tid // 4, i_h, k_slab * 32 + tid % 4 * 8 + k_word * 2 + k_half]
""").body
    # 'early' exposes all K lane exchanges before Q staging; 'stream' exposes
    # only each slab immediately before its corresponding MMA pair.
    if early:
        declarations[-2] = ast.parse("reg_k_mma_words = T.alloc_local([BK // 8], T.uint32)").body[0]
        declarations[-1] = ast.parse("reg_k_mma = T.Tensor([BK // 4], T.float16, data=reg_k_mma_words.data, scope='local')").body[0]
        body[:4] = declarations
        load += ast.parse("""
for k_slab in T.unroll(BK // 32):
    for k_word in T.unroll(4):
        reg_k_mma_words[k_slab * 4 + k_word] = T.shfl_sync(reg_k_words[k_slab * 4 + k_word], tid % 16 * 4 + tid // 16, 64, 18446744073709551615)
""").body
    operations = []
    removed_fences = 0
    for index, node in enumerate(guard.body):
        source = expr(node)
        if isinstance(node, ast.For) and expr(node.target) == "k_slot":
            operations.extend(load)
        elif isinstance(node, ast.If) and expr(node.test) == "not direct_k" and "KV_shared" in source:
            assert is_call(operations[-1], "T.sync_warp(")
            operations.pop()
            removed_fences += 1
        elif isinstance(node, ast.If) and expr(node.test) == "wave_sync" and index + 1 < len(guard.body) and expr(guard.body[index + 1]).startswith("kb = "):
            removed_fences += 1
        elif source.startswith("kb = T.alloc_local"):
            continue
        elif isinstance(node, ast.For) and expr(node.iter) == "T.serial(qk_steps)":
            if early:
                operations.extend(ast.parse("""
for ki in T.serial(qk_steps):
    for k_word in T.unroll(4):
        kb_words = T.Tensor([4], T.uint32, data=reg_k_mma_words.data, elem_offset=ki * 4, scope='local')
    kb_half = T.Tensor([8], T.float16, data=reg_k_mma.data, elem_offset=ki * 8, scope='local')
    qk.mma(Q_reg, kb_half, acc_s, ki)
""").body)
            else:
                operations.extend(ast.parse("""
for ki in T.serial(qk_steps):
    for k_word in T.unroll(4):
        reg_k_mma_words[k_word] = T.shfl_sync(reg_k_words[ki * 4 + k_word], tid % 16 * 4 + tid // 16, 64, 18446744073709551615)
    qk.mma(Q_reg, reg_k_mma, acc_s, ki)
""").body)
        else:
            operations.append(node)
    assert removed_fences == 2
    guard.body = operations
    ast.fix_missing_locations(function)
    return ast.unparse(function)


def main():
    lines = SOURCE.splitlines(keepends=True)
    reports = []
    for early in (False,):
        edits = []
        for fn in ast.parse(SOURCE).body:
            if isinstance(fn, ast.FunctionDef) and fn.name in TARGETS:
                start = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
                edits.append((start, fn.end_lineno, transform(fn, early) + "\n"))
        assert len(edits) == len(TARGETS)
        result = lines.copy()
        for start, end, value in reversed(edits):
            result[start:end] = [value]
        source = "".join(result)
        ast.parse(source)
        path = HERE / ("register_k_early.py" if early else "register_k_stream.py")
        with path.open("x") as output:
            output.write(source)
        reports.append(dict(path=str(path), sha256=hashlib.sha256(source.encode()).hexdigest()))
    proof = []
    for dim in (64, 128):
        for tid in range(64):
            src = tid % 16 * 4 + tid // 16
            for slab in range(dim // 32):
                for e in range(8):
                    read = (src // 4, slab * 32 + src % 4 * 8 + e)
                    mma = (tid % 16, slab * 32 + tid // 16 * 8 + e)
                    assert read == mma
        proof.append(dict(dim=dim, values=16*dim, lane_mapping="PASS"))
    with (HERE / "register_k_manifest.json").open("x") as output:
        json.dump(dict(variants=reports, mappings=proof, shared_fences_removed=2,
                       retained="Q RAW, Q/V WAR, V RAW, V/O WAR, O RAW",
                       parent_sha256=hashlib.sha256(SOURCE.encode()).hexdigest()), output, indent=2)
        output.write("\n")
    print(json.dumps(reports, indent=2))


if __name__ == "__main__":
    main()
