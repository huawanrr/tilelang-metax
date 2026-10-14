"""One independent token per wave, several waves per CTA; local probes only."""
import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent
s = (ROOT / 'single_dual_shared_template.py').read_text()
s = s.replace('native_sparse_attention_single_dual_shared', 'native_sparse_attention_single_multiwave')
s = s.replace('natural=False, linear_v=True,', 'natural=False, linear_v=True, warps=2,')
s = s.replace('    G, BS, D = groups, block_size, dim',
              '    G, BS, D = groups, block_size, dim\n    M = warps * G')
s = s.replace('    qk, pv = _emitters(T.float16, T.float32, BS, D)', '''    qk = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=True,
        block_row_warps=warps, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=BS, chunk=D, k_pack=2)
    pv = TensorCoreIntrinEmitter(
        a_dtype=T.float16, b_dtype=T.float16, accum_dtype=T.float32,
        a_transposed=False, b_transposed=False,
        block_row_warps=warps, block_col_warps=1,
        warp_row_tiles=16, warp_col_tiles=D, chunk=BS, k_pack=1)''')
s = s.replace('T.Kernel(seq_len, batch * H, threads=threads) as (token, bh)',
              'T.Kernel(seq_len // warps, batch * H, threads=64 * warps) as (tile, bh)')
for before, after in (
    ('[G, D]', '[M, D]'), ('[G, BS]', '[M, BS]'), ('[G, 4]', '[M, 4]'),
    ('[BS, D]', '[warps * BS, D]'), ('[2 * G * D]', '[M * D]'),
    ('T.Parallel(G, D)', 'T.Parallel(M, D)'), ('T.Parallel(G, BS)', 'T.Parallel(M, BS)'),
    ('T.Parallel(G, 4)', 'T.Parallel(M, 4)'), ('T.Parallel(BS, D)', 'T.Parallel(warps * BS, D)'),
    ('(i * D + d) // 8 % 64', 'i // G * 64 + (i % G * D + d) // 8 % 64'),
    ('(i * D + d) // 512 * 8', '(i % G * D + d) // 512 * 8'),
    ('(j * D + d) // 8 % 64', 'j // BS * 64 + (j % BS * D + d) // 8 % 64'),
    ('(j * D + d) // 512 * 8', '(j % BS * D + d) // 512 * 8'),
    ('lambda i, j: i + j * 16', 'lambda i, j: i // G * 64 + i % G + j * 16'),
):
    s = s.replace(before, after)
s = s.replace('            tid = T.get_thread_binding()', '''            thread = T.get_thread_binding()
            wave, tid = thread // 64, thread % 64
            token = tile * warps + wave''')
s = s.replace('            T.copy(Q[b, token, h * G:(h + 1) * G, :], q_stage)', '''            for slot in T.unroll(G * D // 512):
                for e in T.vectorized(8):
                    row = (slot * 512 + tid * 8) // D
                    col = tid % (D // 8) * 8 + e
                    q_stage[wave * G + row, col] = Q[b, token, h * G + row, col]''')
for name in ('k', 'v'):
    s = s.replace(f'{name}[(slot * 512 + tid * 8) // D,',
                  f'{name}[wave * BS + (slot * 512 + tid * 8) // D,')
for name in ('prob', 'scores', 'result', 'out'):
    s = s.replace(f'{name}[tid % 16,', f'{name}[wave * G + tid % 16,')
# One shared tile per wave is reused for Q, K, V, and output.
kstore = '''                for j, d in T.Parallel(warps * BS, D):
                    storage[G * D + j * D + (d // 8 ^ j % (D // 8)) * 8 + d % 8] = k[j, d]
'''
assert s.count(kstore) == 1
s = s.replace(kstore, '')
anchor = '                for ki in T.serial(D // 32):'
s = s.replace(anchor, '                T.sync_warp()\n' + kstore.replace('storage[G * D + j * D', 'storage[j * D') + '                T.sync_warp()\n' + anchor, 1)
s = s.replace('storage[G * D + tid % 16 * D', 'storage[wave * G * D + tid % 16 * D')
s = s.replace('vb[j * 4 + e] = storage[row * D', 'vb[j * 4 + e] = storage[wave * BS * D + row * D')
s = s.replace('            for i, d in T.Parallel(M, D):\n                storage[G * D + i * D',
              '            T.sync_warp()\n            for i, d in T.Parallel(M, D):\n                storage[i * D')
s = s.replace('= storage[G * D + row * D', '= storage[wave * G * D + row * D')
s = s.replace('Q/V and K/O occupy disjoint shared regions throughout one wave.',
              'Independent waves reuse one shared region per token.')
s = s.replace('Four barriers protect Q/K RAW, Q/V WAR, V RAW, and O RAW. The K/O\n    overwrite is already protected by the second barrier after all QK loads.',
              'Seven wave barriers protect each RAW/WAR transition independently.\n    No CTA-wide communication occurs; each wave owns disjoint shared storage.')
ast.parse(s)
(ROOT / 'multiwave_template.py').write_text(s)
helper = '''# Local benchmark support; not a submission module.
import tilelang
import tilelang.language as T
from tilelang.maca.intrinsics.macro.mma_macro_generator import TensorCoreIntrinEmitter
from probe_support import BASE

'''+s+'''
CACHE = {}
def get(warps, natural, B, seq_len, H, HQ, D, S, block_size, is_causal, scale=None, **options):
    shape = (B, seq_len, H, HQ, D, S, block_size, is_causal, scale)
    if options or HQ != H * 16 or S != 1 or D != 64 or block_size != 16 or seq_len % 16:
        return BASE._get_kernel(*shape, **options)
    key = (warps, natural, shape)
    if key not in CACHE:
        CACHE[key] = native_sparse_attention_single_multiwave(
            batch=B, heads=HQ, seq_len=seq_len, dim=D, is_causal=is_causal,
            block_size=block_size, groups=16, warps=warps, natural=natural,
            scale_log2=(D ** -0.5 if scale is None else float(scale)) * 1.44269504)
    return CACHE[key]
'''
ast.parse(helper)
(ROOT / 'multiwave_support.py').write_text(helper)
for warps, natural in ((1, False), (2, False), (4, False), (2, True), (4, True)):
    module = f'''# Local benchmark adapter; final release must inline the measured builder.
import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent))
import multiwave_support
def _get_kernel(B, seq_len, H, HQ, D, S, block_size, is_causal, scale=None, **options):
    return multiwave_support.get({warps}, {natural}, B, seq_len, H, HQ, D, S, block_size, is_causal, scale, **options)
def run_kernel(q, k, v, block_indices, output, B, seq_len, H, HQ, D, S, block_size, is_causal, scale):
    _get_kernel(B, seq_len, H, HQ, D, S, block_size, is_causal, scale)(q, k, v, block_indices, output)
    return output
'''
    name = f'multiwave_w{warps}_e{int(natural)}'
    (ROOT / (name + '.py')).write_text(module)
    print(name)
