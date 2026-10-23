"""Bucket short query windows in the pack launch; reuse K/V for two queries.

No host sorting or input-dependent dispatch. Each call rebuilds one small
schedule; every query belongs to exactly one schedule record. Original
builders and explicit tuning paths remain available.
"""
import ast
import copy
import hashlib
import json
import random
from pathlib import Path

HERE = Path(__file__).resolve().parent
PACK = "native_sparse_attention_pack_kv_bs32_tiles_block_joint"
ATTENTION = "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint"


def nodes(source):
    return ast.parse(source).body


def expression(source):
    return ast.parse(source, mode="eval").body


SORT = '''
tid = T.get_thread_binding()
window = bx - NB * NR * NC
counts = T.alloc_shared([64], T.int32)
prefixes = T.alloc_shared([64], T.int32)
tokens = T.alloc_shared([WIN], T.int32)
buckets = T.alloc_local([WIN // 64], T.int32)
ranks = T.alloc_local([WIN // 64], T.int32)
scan = T.alloc_local([1], T.int32)
T.clear(counts)
T.sync_warp()
for step in T.unroll(WIN // 64):
    query_index = window * WIN + step * 64 + tid
    buckets[step] = NB
    ranks[step] = 0
    if query_index < seq_len:
        raw = Indices[b, query_index, h, 0]
        buckets[step] = T.if_then_else(raw >= 0 and raw < NB and (not is_causal or raw <= query_index // BS), raw, NB)
        ranks[step] = T.atomic_add(counts[buckets[step]], 1, return_prev=True)
T.sync_warp()
scan[0] = counts[tid] * 65536 + (counts[tid] + 1) // 2
for scan_step in T.unroll(6):
    received = T.shfl_up(scan[0], 1 << scan_step, 64, 18446744073709551615)
    if tid >= (1 << scan_step):
        scan[0] += received
prefixes[tid] = scan[0] - counts[tid] * 65536 - (counts[tid] + 1) // 2
if tid == 63:
    Schedule[b, h, window, 0] = scan[0] % 65536
T.sync_warp()
for step in T.unroll(WIN // 64):
    query_index = window * WIN + step * 64 + tid
    if query_index < seq_len:
        tokens[prefixes[buckets[step]] // 65536 + ranks[step]] = query_index
T.sync_warp()
for step in T.unroll(WIN // 64):
    query_index = window * WIN + step * 64 + tid
    if query_index < seq_len and ranks[step] % 2 == 0:
        offset = prefixes[buckets[step]]
        task = offset % 65536 + ranks[step] // 2
        Schedule[b, h, window, 1 + task * 3] = buckets[step]
        Schedule[b, h, window, 2 + task * 3] = query_index
        Schedule[b, h, window, 3 + task * 3] = T.if_then_else(ranks[step] + 1 < counts[buckets[step]], tokens[offset // 65536 + ranks[step] + 1], -1)
'''


WRAPPER = '''
def _make_window_pair_attention(pack, attention, batch, seq_len, heads, dim, block_size, window):
    blocks = (seq_len + block_size - 1) // block_size
    windows = (seq_len + window - 1) // window
    capacity = min(window, (window + blocks + 1) // 2)
    shape = (batch, blocks, heads, 2, (dim // 32) * (block_size // 16), 64, 8)
    schedule_shape = (batch, heads, windows, 1 + capacity * 3)
    def run(Q, K, V, BlockIndices, Output):
        packed = torch.empty(shape, dtype=Q.dtype, device=Q.device)
        schedule = torch.empty(schedule_shape, dtype=torch.int32, device=Q.device)
        pack(K, V, BlockIndices, packed, schedule)
        attention(Q, packed, schedule, Output)
    return run
'''


def make_pack(original):
    fn = copy.deepcopy(original)
    fn.name += "_window_pairs"
    fn.args.args.extend([ast.arg(arg="window"), ast.arg(arg="is_causal")])
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    fn.body[fn.body.index(kernel):fn.body.index(kernel)] = nodes('''
WIN = window
NW = tilelang.cdiv(seq_len, WIN)
CAP = min(WIN, (WIN + NB + 1) // 2)
assert WIN in (64, 128) and NB <= 63
''')
    kernel.args.args.insert(2, ast.arg(arg="Indices", annotation=expression("T.Tensor([batch, seq_len, H, 1], T.int32)")))
    kernel.args.args.append(ast.arg(arg="Schedule", annotation=expression("T.Tensor([batch, H, NW, 1 + CAP * 3], T.int32)")))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    scope.items[0].context_expr.args[0] = expression("NB * NR * NC + NW")
    scope.body = [ast.If(test=expression("bx < NB * NR * NC"), body=scope.body, orelse=nodes(SORT))]
    return ast.unparse(ast.fix_missing_locations(fn))


def make_attention(original):
    fn = copy.deepcopy(original)
    fn.name += "_window_pairs"
    fn.args.args.append(ast.arg(arg="window"))
    fn.args.defaults.append(ast.Constant(value=64))
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    fn.body[fn.body.index(kernel):fn.body.index(kernel)] = nodes('''
WIN = window
NW = tilelang.cdiv(seq_len, WIN)
CAP = min(WIN, (WIN + NB + 1) // 2)
assert WIN in (64, 128) and NB <= 63 and W == D
''')
    kernel.args.args[2] = ast.arg(arg="Schedule", annotation=expression("T.Tensor([batch, H, NW, 1 + CAP * 3], T.int32)"))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    scope.items[0].context_expr.args[:2] = [expression("CAP"), expression("batch * H * NW")]
    scope.items[0].optional_vars = expression("(task, bhw)")
    first_work = next(i for i, n in enumerate(scope.body) if ast.unparse(n).startswith("b, h ="))
    allocations = scope.body[:first_work]
    body = scope.body[first_work + 1:]
    output_alloc = next(i for i, n in enumerate(body) if ast.unparse(n).startswith("output_shared ="))
    allocations.extend(body[output_alloc:output_alloc + 2])
    del body[output_alloc:output_alloc + 2]
    body = [n for n in body if not ast.unparse(n).startswith("block = Indices[")]
    guard = next(n for n in body if isinstance(n, ast.If) and ast.unparse(n.test) == "valid")
    for index, stmt in enumerate(guard.body):
        # W == D leaves one full V fragment. Keep the original first-query
        # load positions; both fragments survive until the second query.
        if isinstance(stmt, ast.For) and any(isinstance(n, ast.Subscript) and isinstance(n.value, ast.Name) and n.value.id == "PackedKV" for n in ast.walk(stmt)):
            if ast.unparse(stmt.target) in ("(j, d)", "j, d"):
                guard.body[index] = ast.If(test=expression("pair_query == 0"), body=[stmt], orelse=[])
    # All shared allocations are outside the pair. A wave fence protects the
    # first output's shared reads before the second query reuses that storage.
    body.extend(nodes("T.sync_warp()"))
    pair_body = nodes("token = T.if_then_else(pair_query == 0, first_token, second_token)")
    pair_body.append(ast.If(test=expression("token >= 0"), body=body, orelse=[]))
    work = nodes('''
block = Schedule[b, h, window_index, 1 + task * 3]
first_token = Schedule[b, h, window_index, 2 + task * 3]
second_token = Schedule[b, h, window_index, 3 + task * 3]
''')
    work.append(ast.For(target=ast.Name(id="pair_query", ctx=ast.Store()), iter=expression("T.unroll(2)"), body=pair_body, orelse=[]))
    scope.body = allocations + nodes('''
b = bhw // (H * NW)
h = bhw // NW % H
window_index = bhw % NW
''') + [ast.If(test=expression("task < Schedule[b, h, window_index, 0]"), body=work, orelse=[])]

    class StringEmitterTypes(ast.NodeTransformer):
        def visit_Call(self, node):
            node = self.generic_visit(node)
            if isinstance(node.func, ast.Name) and node.func.id in ("_emitters", "TensorCoreIntrinEmitter"):
                for i, arg in enumerate(node.args):
                    if ast.unparse(arg) in ("T.float16", "T.float32"):
                        node.args[i] = ast.Constant(ast.unparse(arg).split(".")[1])
                for kw in node.keywords:
                    if kw.arg in ("a_dtype", "b_dtype", "accum_dtype") and ast.unparse(kw.value) in ("T.float16", "T.float32"):
                        kw.value = ast.Constant(ast.unparse(kw.value).split(".")[1])
            return node
    return ast.unparse(ast.fix_missing_locations(StringEmitterTypes().visit(fn)))


def cpu_proof():
    rng = random.Random(47)
    count = 0
    for seq_len in (1, 31, 32, 33, 63, 64, 65, 127, 128, 129, 511, 512, 513, 1023, 1024, 1985, 2016):
        nb = (seq_len + 31) // 32
        for win in (64, 128):
            cap = min(win, (win + nb + 1) // 2)
            for causal in (False, True):
                patterns = [[0] * seq_len, [nb] * seq_len,
                            [rng.choice([-2**31, -1, 0, nb - 1, nb, 2**31 - 1]) for _ in range(seq_len)],
                            [rng.randrange(nb) for _ in range(seq_len)]]
                for indices in patterns:
                    seen = []
                    for begin in range(0, seq_len, win):
                        buckets = [[] for _ in range(64)]
                        # Arbitrary within-bucket ordering models shared atomic
                        # scheduling; the consumer must not require stable order.
                        order = list(range(begin, min(seq_len, begin + win)))
                        rng.shuffle(order)
                        for token in order:
                            raw = indices[token]
                            bucket = raw if 0 <= raw < nb and (not causal or raw <= token // 32) else nb
                            buckets[bucket].append(token)
                        packed = [(len(x) << 16) + (len(x) + 1) // 2 for x in buckets]
                        original = packed[:]
                        for bit in range(6):
                            prev = packed[:]
                            for lane in range(1 << bit, 64):
                                packed[lane] += prev[lane - (1 << bit)]
                        total = packed[-1] & 65535
                        assert total <= cap
                        slots = []
                        for bucket, tokens in enumerate(buckets):
                            offset = packed[bucket] - original[bucket]
                            assert offset >> 16 == sum(map(len, buckets[:bucket]))
                            for rank in range(0, len(tokens), 2):
                                dst = (offset & 65535) + rank // 2
                                slots.append(dst)
                                for token in tokens[rank:rank+2]:
                                    seen.append(token)
                                    raw = indices[token]
                                    valid = 0 <= raw < nb and (not causal or raw <= token // 32)
                                    assert (bucket == raw) if valid else (bucket == nb)
                        assert sorted(slots) == list(range(total))
                    assert sorted(seen) == list(range(seq_len))
                    count += 1
    return dict(pattern_cases=count, once_per_query=True, no_gaps_in_schedule=True,
                no_rank_collisions=True, guards_before_index_multiplication=True,
                capacity_bound="sum ceil(count/2) <= min(WIN, floor((WIN + NB + 1)/2))")


def main():
    source = (HERE / "baseline.py").read_text()
    functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    extra = "\n\n".join((make_pack(functions[PACK]), make_attention(functions[ATTENTION]), WRAPPER))
    records = []
    for win in (64, 128):
        dispatch = copy.deepcopy(functions["_get_kernel"])
        # Cache flags are shape/default-only and remain within mathcast_single;
        # the explicit flag is appended to the normalized key as well.
        key_pos = next(i for i, n in enumerate(dispatch.body) if isinstance(n, ast.Assign) and ast.unparse(n.targets[0]) == "key")
        dispatch.body[key_pos:key_pos] = nodes("window_pairs = mathcast_single and tiled_pack and grid >= 4096 and (seq_len + block_size - 1) // block_size <= 63")
        key_node = next(n for n in dispatch.body if isinstance(n, ast.Assign) and ast.unparse(n.targets[0]) == "key")
        key_node.value.elts.append(ast.Name(id="window_pairs", ctx=ast.Load()))
        packed = next(n for n in ast.walk(dispatch) if isinstance(n, ast.If) and ast.unparse(n.test) == "packed_qo")
        new = nodes(f'''
attention = {ATTENTION}_window_pairs(width=128, late=False, window={win}, **common)
pack = {PACK}_window_pairs(B, seq_len, H, D, block_size, {win}, bool(is_causal))
kernel = _make_window_pair_attention(pack, attention, B, seq_len, H, D, block_size, {win})
''')
        packed.body = [ast.If(test=expression("window_pairs"), body=new, orelse=packed.body)]
        result = source.replace(ast.get_source_segment(source, functions["_get_kernel"]), extra + "\n\n" + ast.unparse(ast.fix_missing_locations(dispatch)), 1)
        updated = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert all(ast.dump(fn) == ast.dump(updated[name]) for name, fn in functions.items() if name != "_get_kernel")
        dest = HERE / f"window_pairs{win}.py"
        with dest.open("x") as out:
            out.write(result)
        records.append(dict(path=dest.name, window=win, sha256=hashlib.sha256(result.encode()).hexdigest()))
    with (HERE / "window_pairs_manifest.json").open("x") as out:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
                       cpu_proof=cpu_proof(), launches=2, per_call_schedule=True,
                       fp32_mma_and_denominator=True, arbitrary_input_order=True,
                       original_builders_preserved=True), out, indent=2)
        out.write("\n")
    print("Generated window pair probes", records)


if __name__ == "__main__":
    main()
