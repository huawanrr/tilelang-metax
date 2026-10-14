"""Group runtime-selected equal K/V blocks and reuse the current packed operands."""
import ast
import hashlib
import json
from pathlib import Path

from make_packed_waves import replace_once

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/submission.py'

PREPARE = '''
@tilelang.jit
def native_sparse_attention_pack_and_buckets(batch, seq_len, heads, dim, block_size, queries, causal):
    BS, D, QT = block_size, dim, queries
    NB = tilelang.cdiv(seq_len, BS)
    NS = max(64, tilelang.math.next_power_of_2(NB + 1))
    CAP = tilelang.cdiv(seq_len, QT) + NB + 1
    @T.prim_func
    def kernel(
        K: T.Tensor([batch, seq_len, heads, D], T.float16),
        V: T.Tensor([batch, seq_len, heads, D], T.float16),
        Indices: T.Tensor([batch, seq_len, heads, 1], T.int32),
        PackedK: T.Tensor([batch, NB, heads, D//32, BS//16, 64, 8], T.float16),
        PackedV: T.Tensor([batch, NB, heads, BS//16, D//32, 64, 8], T.float16),
        Sorted: T.Tensor([batch, heads, NB + 1, seq_len], T.int32),
        Schedule: T.Tensor([batch, heads, CAP, 3], T.int32),
    ):
        with T.Kernel(NB + 1, heads, batch, threads=256) as (bs, h, b):
            tid = T.get_thread_binding()
            if bs < NB:
                packed_v = T.alloc_fragment([BS, D], T.float16)
                T.annotate_layout({packed_v: T.Fragment([BS, D],
                    forward_thread_fn=lambda pj, pd: (((pj // 16 * (D // 32) + pd // 32) * 64
                        + (pj % 16 // 4) * 16 + pd % 16) % 256),
                    forward_index_fn=lambda pj, pd: (((pj // 16 * (D // 32) + pd // 32) * 64
                        + (pj % 16 // 4) * 16 + pd % 16) // 256 * 8
                        + (pd % 32 // 16) * 4 + pj % 4))})
                v_shared = T.alloc_shared([BS, D], T.float16)
                T.annotate_layout({v_shared:
                    tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize=4)})
                ktile = T.alloc_fragment([BS, D], T.float16)
                vtile = T.alloc_fragment([BS, D], T.float16)
                T.copy(K[b, bs * BS : (bs + 1) * BS, h, :], ktile)
                for j, d in T.Parallel(BS, D):
                    PackedK[b, bs, h, d // 32, j // 16,
                            (d % 32 // 8) * 16 + j % 16, d % 8] = ktile[j, d]
                T.copy(V[b, bs * BS : (bs + 1) * BS, h, :], vtile)
                T.copy(vtile, v_shared)
                T.sync_threads()
                T.copy(v_shared, packed_v)
                for j, d in T.Parallel(BS, D):
                    PackedV[b, bs, h, j // 16, d // 32,
                            (j % 16 // 4) * 16 + d % 16,
                            (d % 32 // 16) * 4 + j % 4] = packed_v[j, d]
            else:
                counts = T.alloc_shared([NS], T.int32)
                scan = T.alloc_shared([NS], T.int32)
                T.clear(counts)
                for step in T.serial(T.ceildiv(CAP, 256)):
                    slot_index = step * 256 + tid
                    if slot_index < CAP:
                        for field in T.unroll(3):
                            Schedule[b, h, slot_index, field] = -1
                T.sync_threads()
                for step in T.serial(T.ceildiv(seq_len, 256)):
                    token_index = step * 256 + tid
                    if token_index < seq_len:
                        raw = Indices[b, token_index, h, 0]
                        dest = T.if_then_else(raw >= 0 and raw < NB and (not causal or raw * BS <= token_index), raw, NB)
                        bucket = T.min(T.max(dest, 0), NB)
                        slot = T.atomic_add(counts[bucket], 1, return_prev=True)
                        Sorted[b, h, bucket, slot] = token_index
                T.sync_threads()
                for ni in T.Parallel(NS):
                    scan[ni] = T.ceildiv(counts[ni], QT)
                T.cumsum(scan)
                for step in T.serial(T.ceildiv(NB + 1, 256)):
                    bucket = step * 256 + tid
                    if bucket < NB + 1:
                        count = counts[bucket]
                        tasks = T.ceildiv(count, QT)
                        for task in T.serial(tasks):
                            dst = scan[bucket] - tasks + task
                            Schedule[b, h, dst, 0] = bucket
                            Schedule[b, h, dst, 1] = task * QT
                            Schedule[b, h, dst, 2] = T.min(QT, count - task * QT)
    return kernel


def _make_bucket_packed_attention(pack, attention, batch, seq_len, heads, dim, block_size, queries):
    blocks = (seq_len + block_size - 1) // block_size
    k_shape = (batch, blocks, heads, dim // 32, block_size // 16, 64, 8)
    v_shape = (batch, blocks, heads, block_size // 16, dim // 32, 64, 8)
    sorted_shape = (batch, heads, blocks + 1, seq_len)
    schedule_shape = (batch, heads, (seq_len + queries - 1) // queries + blocks + 1, 3)
    def run(q, k, v, indices, output):
        packed_k = torch.empty(k_shape, device=k.device, dtype=k.dtype)
        packed_v = torch.empty(v_shape, device=v.device, dtype=v.dtype)
        sorted_tokens = torch.empty(sorted_shape, device=indices.device, dtype=torch.int32)
        schedule = torch.empty(schedule_shape, device=indices.device, dtype=torch.int32)
        pack(k, v, indices, packed_k, packed_v, sorted_tokens, schedule)
        attention(q, packed_k, packed_v, sorted_tokens, schedule, output)
    return run
'''


def main():
    records = []
    for waves in (2, 4, 8):
        source = (HERE / f'packed_waves{waves}.py').read_text()
        node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)
                    and n.name == 'native_sparse_attention_single_packed_qo_v2')
        lines = source.splitlines(keepends=True)
        begin = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
        fn = ''.join(lines[begin:node.end_lineno])
        fn = replace_once(fn, '    NB = tilelang.cdiv(seq_len, BS)',
                          '    NB = tilelang.cdiv(seq_len, BS)\n    CAP = tilelang.cdiv(seq_len, NW) + NB + 1')
        fn = replace_once(fn, '        Indices: T.Tensor([batch, seq_len, H, 1], T.int32),',
            '''        Sorted: T.Tensor([batch, H, NB + 1, seq_len], T.int32),
        Schedule: T.Tensor([batch, H, CAP, 3], T.int32),''')
        fn = replace_once(fn, 'with T.Kernel(T.ceildiv(seq_len, NW), batch * H,',
                          'with T.Kernel(CAP, batch * H,')
        fn = replace_once(fn, '            token = tile * NW + wave',
            '''            bucket = Schedule[bh // H, bh % H, tile, 0]
            first = Schedule[bh // H, bh % H, tile, 1]
            count = Schedule[bh // H, bh % H, tile, 2]
            token = T.if_then_else(bucket >= 0 and wave < count,
                Sorted[bh // H, bh % H, bucket, first + wave], seq_len)''')
        fn = fn.replace('tile * NW + qi // G', 'token')
        fn = fn.replace('tile * NW + oi // G', 'token')
        fn = replace_once(fn, '            block = T.if_then_else(token < seq_len, Indices[b, token, h, 0], -1)',
                          '            block = T.if_then_else(token < seq_len, bucket, -1)')
        source = ''.join(lines[:begin]) + fn + ''.join(lines[node.end_lineno:])
        source = replace_once(source, '\ndef _get_kernel(', '\n' + PREPARE + '\n\ndef _get_kernel(')
        source = replace_once(source,
            '''            pack_builder = (native_sparse_attention_pack_kv_bs32_direct if packed_direct
                            else native_sparse_attention_pack_kv_bs32_shared)
            pack = pack_builder(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)''',
            f'''            pack = native_sparse_attention_pack_and_buckets(B, seq_len, H, D, block_size, {waves}, bool(is_causal))
            kernel = _make_bucket_packed_attention(pack, attention, B, seq_len, H, D, block_size, {waves})''')
        ast.parse(source)
        dest = HERE / f'bucket_packed{waves}.py'
        with dest.open('x') as f:
            f.write(source)
        records.append(dict(path=dest.name, queries=waves, sha256=hashlib.sha256(dest.read_bytes()).hexdigest()))
    (HERE / 'bucket_packed_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(), variants=records,
        description='Runtime bucket scheduling fused with normal K/V packing, followed by wave-local packed attention. All workspaces recomputed every call.'), indent=2) + '\n')


if __name__ == '__main__':
    main()
