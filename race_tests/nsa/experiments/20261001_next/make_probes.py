"""Independent source probes built from the immutable version currently on OJ."""
import ast
from pathlib import Path

HERE = Path(__file__).resolve().parent
BASE = (HERE.parent / '20261001_final/nsa.py').read_text()
PACKED = 'native_sparse_attention_single_packed_qo'


def once(source, before, after):
    assert source.count(before) == 1, (before, source.count(before))
    return source.replace(before, after)


def function_span(source, name):
    node = next(n for n in ast.parse(source).body
                if isinstance(n, ast.FunctionDef) and n.name == name)
    lines = source.splitlines(keepends=True)
    first = min([node.lineno] + [d.lineno for d in node.decorator_list]) - 1
    return ''.join(lines[:first]), ''.join(lines[first:node.end_lineno]), ''.join(lines[node.end_lineno:])


def change_function(source, name, transform):
    before, function, after = function_span(source, name)
    return before + transform(function) + after


def with_flags(function, scheduler):
    return once(function, '@tilelang.jit(',
                f"@tilelang.jit(compile_flags=['-mllvm', '--misched=metaxgpu-{scheduler}'], ")


def write(name, source):
    ast.parse(source)
    path = HERE / (name + '.py')
    assert not path.exists(), path
    path.write_text(source)
    print(path.name)


def packed_probe(width=128, late=False, qvec=8, lane=False, scheduler=None):
    def modify(fn):
        fn = once(fn, '(qi * D + qd) // 8 % 64', f'(qi * D + qd) // {qvec} % 64')
        fn = once(fn, '(qi * D + qd) // 512 * 8 + qd % 8',
                  f'(qi * D + qd) // {64*qvec} * {qvec} + qd % {qvec}')
        if lane:
            fn = once(fn, '            denom = T.alloc_fragment([G], T.float32)',
                      '''            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, lane: i + lane * 16,
                forward_index_fn=lambda i, lane: 0)})
            denom = T.alloc_fragment([G], T.float32)''')
            fn = once(fn, '''                    T.reduce_sum(scores, denom, dim=1, clear=True)
                    for i in T.Parallel(G):
                        inv[i] = T.if_then_else(denom[i] > 0, 1.0 / denom[i], 0.0)
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] *= inv[i]''',
                      '''                    for i, lane in T.Parallel(G, 4):
                        lane_sum[i, lane] = 0
                        for k in T.unroll(BS // 16):
                            for j in T.unroll(4):
                                lane_sum[i, lane] += scores[i, k * 16 + lane * 4 + j]
                    for i, lane in T.Parallel(G, 4):
                        lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                        lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                        lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                            1.0 / lane_sum[i, lane], 0.0)
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] *= lane_sum[i, j % 16 // 4]''')
        if scheduler:
            fn = with_flags(fn, scheduler)
        return fn
    source = change_function(BASE, PACKED, modify)
    return once(source, f'{PACKED}(width=128, late=False, **common)',
                f'{PACKED}(width={width}, late={late!r}, **common)')


if __name__ == '__main__':
    for name, kwargs in (
        ('packed_w64', dict(width=64)),
        ('packed_w32', dict(width=32)),
        ('packed_late', dict(late=True)),
        ('packed_q4', dict(qvec=4)),
        ('packed_q16', dict(qvec=16)),
        ('packed_lane', dict(lane=True)),
        ('packed_ilp', dict(scheduler='ilp')),
        ('packed_minreg', dict(scheduler='minreg')),
    ):
        write(name, packed_probe(**kwargs))
