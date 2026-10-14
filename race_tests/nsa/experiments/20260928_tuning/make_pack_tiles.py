"""Amortize packing CTA work across adjacent KV blocks, keeping all masks."""
import ast
from pathlib import Path

folder = Path(__file__).resolve().parent
base = (folder / 'baseline.py').read_text()
a = base.index('def native_sparse_attention_pack_kv(')
b = base.index('\n\ndef _make_packed_attention', a)
original = base[a:b]
for tiles, threads in [(2,128),(4,128),(4,256)]:
    p = original.replace('T.ceildiv(seq_len, BS), heads, batch, threads=128',
                         f'T.ceildiv(seq_len, BS * {tiles}), heads, batch, threads={threads}')
    start = p.index('            ktile = ')
    end = p.index('    return kernel')
    p = p[:start] + f'''            ktile = T.alloc_fragment([{tiles} * BS, D], T.float16)
            vtile = T.alloc_fragment([{tiles} * BS, D], T.float16)
            T.copy(K[b, bs * BS * {tiles} : (bs + 1) * BS * {tiles}, h, :], ktile)
            T.copy(V[b, bs * BS * {tiles} : (bs + 1) * BS * {tiles}, h, :], vtile)
            for jj, d in T.Parallel({tiles} * BS, D):
                block = bs * {tiles} + jj // BS
                j = jj % BS
                if block < T.ceildiv(seq_len, BS):
                    PackedK[b, block, h, d // 32, j // 16,
                            (d % 32 // 8) * 16 + j % 16, d % 8] = ktile[jj, d]
                    Packed[b, block, h, j // 16, d // 32,
                           (j % 16 // 4) * 16 + d % 16,
                           (d % 32 // 16) * 4 + j % 4] = vtile[jj, d]
''' + p[end:]
    s = base[:a]+p+base[b:]
    ast.parse(s)
    (folder / f'pack_tiles{tiles}_t{threads}.py').write_text(s)
