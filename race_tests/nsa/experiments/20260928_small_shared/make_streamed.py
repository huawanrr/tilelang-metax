"""Reduce register staging as well as shared memory in the sliced KV experiment."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
for width in (32, 64):
    source = (HERE / f'shared{width}.py').read_text()
    a = source.index('def single_small_shared(')
    b = source.index('\n\n_KERNEL_CACHE', a)
    part = source[a:b]
    part = part.replace('T.alloc_fragment([BS, D], T.float16)', 'T.alloc_fragment([BS, W], T.float16)')
    part = part.replace('''T.Fragment([BS, D],
                    forward_thread_fn=lambda j, d: (j * W + d % W) // 8 % 64,
                    forward_index_fn=lambda j, d: d // W * (BS * W // 64)
                        + (j * W + d % W) // 512 * 8 + d % 8)''', '''T.Fragment([BS, W],
                    forward_thread_fn=lambda j, d: (j * W + d) // 8 % 64,
                    forward_index_fn=lambda j, d: (j * W + d) // 512 * 8 + d % 8)''')
    part = part.replace('T.copy(K[b, start:start + BS, h, :], k)', 'T.copy(K[b, start:start + BS, h, 0:W], k)', 1)
    part = part.replace('T.copy(V[b, start:start + BS, h, :], v)', 'T.copy(V[b, start:start + BS, h, 0:W], v)', 1)
    for tile in range(128 // width):
        old = f'                T.copy(k[0:BS, {tile} * W:({tile} + 1) * W], kv)'
        assert old in part
        new = ('                T.copy(K[b, start:start + BS, h, '
               f'{tile} * W:({tile} + 1) * W], k)\n') if tile else ''
        part = part.replace(old, new + '                T.copy(k, kv)', 1)
        old = f'                T.copy(v[0:BS, {tile} * W:({tile} + 1) * W], kv)'
        assert old in part
        new = ('                T.copy(V[b, start:start + BS, h, '
               f'{tile} * W:({tile} + 1) * W], v)\n') if tile else ''
        part = part.replace(old, new + '                T.copy(v, kv)', 1)
    result = source[:a] + part + source[b:]
    ast.parse(result)
    (HERE / f'streamed{width}.py').write_text(result)
    print(f'streamed{width}.py')
