"""Use 64-wide K packs and matching QK fragments in the S8 packed path."""
import ast
from pathlib import Path
import re

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / 'experiments/20260927_next/selected.py').read_text()
a = base.index('def native_sparse_attention_online_packed(')
b = base.index('\n\n@tilelang.jit', a)
part = base[a:b]
part = part.replace('head_kv, BK // 32, BS // 16, 64, 8]',
                    'head_kv, BK // 64, BS // 16, 64, 16]', 1)
part = part.replace('qk, pv = _emitters(T.float16, T.float32, BS, BK)',
                    'qk, pv = _emitters(T.float16, T.float32, BS, BK, qk_k_pack=4)', 1)
part = part.replace('Q_reg: qk.make_mma_load_layout(Q_reg, "A"),', '''Q_reg: T.Fragment([G, BK],
                    forward_thread_fn=lambda i, d: i + (d % 64 // 16) * 16,
                    forward_index_fn=lambda i, d: d // 64 * 16 + d % 16),''', 1)
for name in ['K_reg', 'K_reg1', 'K_reg2', 'K_reg3']:
    part = part.replace(f'{name}: qk.make_mma_load_layout({name}, "B"),', f'''{name}: T.Fragment([BS, BK],
                    forward_thread_fn=lambda j, d: j % 16 + (d % 64 // 16) * 16,
                    forward_index_fn=lambda j, d: (d // 64 * (BS // 16) + j // 16) * 16 + d % 16),''', 1)
old = r'd // 32,\s+j // 16, \(d % 32 // 8\) \* 16 \+ j % 16, d % 8\]'
part, count = re.subn(old, 'd // 64,\n                                            j // 16, (d % 64 // 16) * 16 + j % 16, d % 16]', part)
assert count == 5, count
source = base[:a] + part + base[b:]
a = source.index('def native_sparse_attention_pack_kv(')
b = source.index('\n\n_KERNEL_CACHE', a)
part = source[a:b]
part = part.replace('heads, D//32, BS//16, 64, 8]', 'heads, D//64, BS//16, 64, 16]', 1)
part = part.replace('''PackedK[b, bs, h, d // 32, j // 16,
                        (d % 32 // 8) * 16 + j % 16, d % 8]''', '''PackedK[b, bs, h, d // 64, j // 16,
                        (d % 64 // 16) * 16 + j % 16, d % 16]''', 1)
part = part.replace('k_shape = (batch, blocks, heads, dim // 32, block_size // 16, 64, 8)',
                    'k_shape = (batch, blocks, heads, dim // 64, block_size // 16, 64, 16)', 1)
source = source[:a] + part + source[b:]
ast.parse(source)
(HERE / 'online_pack4.py').write_text(source)
print('online_pack4.py')
