"""Compare output-oriented packing and a smaller thread block."""
import ast
from pathlib import Path

folder = Path(__file__).resolve().parent
base = (folder / 'baseline.py').read_text()
a = base.index('def native_sparse_attention_pack_kv(')
b = base.index('\n\ndef _make_packed_attention', a)
original = base[a:b]
start = original.index('            ktile = ')
v_start = original.index('            tile = ')
end = original.index('    return kernel')
k_code = '''            ktile = T.alloc_fragment([D//32, BS//16, 64, 8], T.float16)
            for db, jb, lane, p in T.Parallel(D//32, BS//16, 64, 8):
                j = jb * 16 + lane % 16
                d = db * 32 + (lane // 16) * 8 + p
                ktile[db, jb, lane, p] = T.if_then_else(
                    bs * BS + j < seq_len, K[b, bs * BS + j, h, d], 0)
            T.copy(ktile, PackedK[b, bs, h, :, :, :, :])
'''
v_code = '''            vtile = T.alloc_fragment([BS//16, D//32, 64, 8], T.float16)
            for jb, db, lane, p in T.Parallel(BS//16, D//32, 64, 8):
                j = jb * 16 + (lane // 16) * 4 + p % 4
                d = db * 32 + (p // 4) * 16 + lane % 16
                vtile[jb, db, lane, p] = T.if_then_else(
                    bs * BS + j < seq_len, V[b, bs * BS + j, h, d], 0)
            T.copy(vtile, Packed[b, bs, h, :, :, :, :])
'''
for name, threads, inverse_k, inverse_v in [
    ('pack64', 64, False, False),
    ('pack_v128', 128, False, True),
    ('pack_kv128', 128, True, True),
    ('pack_kv64', 64, True, True),
]:
    p = (original[:start] + (k_code if inverse_k else original[start:v_start])
         + (v_code if inverse_v else original[v_start:end]) + original[end:])
    p = p.replace('threads=128', f'threads={threads}')
    source = base[:a] + p + base[b:]
    ast.parse(source)
    (folder / f'{name}.py').write_text(source)
