"""Synchronous S1 schedule with safe loads and zero weights for invalid rows."""
from pathlib import Path
import ast
s=Path('experiments/20260926/selected.py').read_text()
a=s.index('def native_sparse_attention_single_block_emitter(')
b=s.index('\n\n@tilelang.jit',a)
p=s[a:b]
p=p.replace('''            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS''','''            raw_start = BlockIndices[i_b, i_t, i_h, 0] * BS
            row_valid = raw_start >= 0 and raw_start < seq_len and (not is_causal or raw_start <= i_t)
            i_s = T.if_then_else(row_valid, raw_start, 0)''')
start=p.index('            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):\n')
end=p.index('\n            T.copy(acc_o, Output[',start)
body=p[start:end].split('\n')[1:]
body=['    '+line[8:] if line.startswith('                ') else line for line in body]
body='\n'.join(body)
body=body.replace('''            if is_causal and i_s + BS > i_t + 1:''','''            if not row_valid:
                T.fill(acc_s, -T.infinity(T.float32))
            elif is_causal and i_s + BS > i_t + 1:''',1)
p=p[:start]+body+p[end:]
s=s[:a]+p+s[b:]
ast.parse(s)
Path('experiments/20260927/uniform_s1.py').write_text(s)
