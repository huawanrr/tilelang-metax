"""Build isolated packed S1/PV-width experiments on the preserved next source."""
import ast
import hashlib
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
base = (ROOT / 'experiments/20260927_next/selected.py').read_text()
assert hashlib.sha256(base.encode()).hexdigest() == '311e64a25b16471d2689049070303e6400bc0f593e184615222839e1a77b3a26'
template = (HERE / 'single_packed_template.py').read_text()
for width in (32, 64, 128):
    for late in (False, True):
        source = base.replace('\n\n_KERNEL_CACHE = {}', '\n\n' + template + '\n\n_KERNEL_CACHE = {}', 1)
        a = source.index('def _get_kernel(')
        dispatch = source[a:]
        dispatch = dispatch.replace('''        if S == 1 and use_emitter:
''', f'''        if S == 1 and groups == 16 and D == 128 and block_size == 32 and threads == 64:
            attention = single_packed_pv(width={width}, late={late}, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif S == 1 and use_emitter:
''', 1)
        source = source[:a] + dispatch
        ast.parse(source)
        name = f'packed_pv{width}_' + ('late' if late else 'early') + '.py'
        (HERE / name).write_text(source)
        print(name)
