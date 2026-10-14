"""Combine the two separate S8 scheduling signals for a family comparison."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / 'experiments/20260928_accum_groups/pv_acc4.py').read_text()
for reverse in (False, True):
    a = base.index('def native_sparse_attention_online_packed(')
    b = base.index('\n\n@tilelang.jit', a)
    part = base[a:b]
    part = part.replace('''with T.Kernel(seq_len, T.ceildiv(dim, BV), batch * head_kv,
                      threads=threads) as (bx, by, bz):''', '''with T.Kernel(batch * head_kv, T.ceildiv(dim, BV), seq_len,
                      threads=threads) as (bz, by, bx):''', 1)
    if reverse:
        part = part.replace('            i_t, i_v, i_bh = bx, by, bz',
                            '            i_t, i_v, i_bh = seq_len - 1 - bx, by, bz', 1)
    source = base[:a] + part + base[b:]
    ast.parse(source)
    name = 'quad_batch_minor' + ('_reverse' if reverse else '') + '.py'
    (HERE / name).write_text(source)
    print(name)

# Extend the unmodified shared-output harness locally with equal-grid shapes.
harness = (ROOT / 'experiments/20260927_next/compare_same_output.py').read_text()
marker = '    selected = [str(i) for i in parse_cases'
extra = '''    for label, batch, length, heads in [
        ('g4_b8', 8, 512, 1), ('g4_b2', 2, 2048, 1), ('g4_h2', 2, 1024, 2),
        ('g8_b8', 8, 1024, 1), ('g8_b4', 4, 2048, 1),
        ('g2_b4', 4, 512, 1), ('g1_b4', 4, 256, 1),
    ]:
        named[label] = dict(B=batch, SEQ_LEN=length, H=heads, HQ=16 * heads,
                           D=64, S=8, block_size=16, is_causal=True)
'''
assert marker in harness
harness = harness.replace(marker, extra + marker, 1)
ast.parse(harness)
(HERE / 'compare_families.py').write_text(harness)
