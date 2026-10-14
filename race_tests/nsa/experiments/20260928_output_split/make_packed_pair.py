import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
base = (HERE / 'baseline.py').read_text()
start = base.index('def native_sparse_attention_online_packed(')
end = base.index('\n\n@tilelang.jit', start)
kernel = (HERE / 'packed_pair_kernel.py').read_text()
for pair in (2, 4, 8):
    result = base[:start] + kernel.replace('    PAIR = 2', f'    PAIR = {pair}') + base[end:]
    ast.parse(result)
    (HERE / f'packed_pair{pair}.py').write_text(result)
