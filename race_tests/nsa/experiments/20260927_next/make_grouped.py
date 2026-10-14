from pathlib import Path
import ast
base=Path('nsa.py').read_text()
kernel=Path('experiments/20260927_next/fused_group_kernel.py').read_text()
kernel=kernel[kernel.index('@tilelang.jit'):]
for segment in [64,128,256,512]:
 s=base.replace('\n\n_KERNEL_CACHE = {}','\n\n'+kernel+'\n\n_KERNEL_CACHE = {}',1)
 s=s.replace('''        if S == 1 and use_emitter:
''',f'''        if S == 1 and D == 128 and block_size == 32 and groups == 16:
            kernel = fused_group_attention(query_segment={segment}, **common)
        elif S == 1 and use_emitter:
''',1)
 ast.parse(s)
 Path(f'experiments/20260927_next/grouped_{segment}.py').write_text(s)
