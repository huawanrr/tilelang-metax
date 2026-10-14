"""Isolate the remaining D64 T.gemm path's load and synchronization schedule."""
import ast
import re

from make_probes import HERE, BASE, once


if __name__ == '__main__':
    template = (HERE / 'gemm_template.py').read_text()
    variants = {
        'gemm_control': (False, False, False, False, 'T.sync_warp'),
        'gemm_preload': (False, False, True, False, 'T.sync_warp'),
        'gemm_wave': (True, True, False, False, 'T.sync_warp'),
        'gemm_wave_preload': (True, True, True, False, 'T.sync_warp'),
        'gemm_block_preload': (True, True, True, False, 'T.sync_threads'),
        'gemm_wave_early': (True, True, True, True, 'T.sync_warp'),
    }
    for name, config in variants.items():
        fn = template
        for key, value in zip(('MANUAL', 'LANES', 'PRELOAD', 'EARLY_V', 'SYNC'), config):
            fn = re.sub(r'\b' + key + r'\b', str(value), fn)
        result = once(BASE, '\n_KERNEL_CACHE = {}', '\n' + fn + '\n_KERNEL_CACHE = {}')
        result = once(result, '        if joined_short:', '''        if S == 1 and D == 64 and block_size == 16 and groups == 16 and threads == 64 and not kv_frag and not kv_split:
            kernel = native_sparse_attention_gemm_probe(**common)
        elif joined_short:''')
        ast.parse(result)
        path = HERE / f'{name}.py'
        if path.exists():
            raise FileExistsError(path)
        path.write_text(result)
        print(path.name)
