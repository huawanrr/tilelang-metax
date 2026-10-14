"""Remove clamp-expanded addresses and match the original full-block mask path."""
import ast
from pathlib import Path

from make_d32_query_ilp import kernel

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def revised(queries, prefetch):
    code = kernel(queries, prefetch)
    for p in range(queries):
        old = f'''            start_{p} = T.min(T.max(index_{p}, -1), NB) * BS
            valid_{p} = (t_{p} < seq_len and start_{p} >= 0 and start_{p} < seq_len
                         and (not is_causal or start_{p} <= t_{p}))'''
        new = f'''            valid_{p} = (t_{p} < seq_len and index_{p} >= 0 and index_{p} < NB
                         and (not is_causal or index_{p} <= t_{p} // BS))'''
        assert code.count(old) == 1
        code = code.replace(old, new)
        # Every remaining product is evaluated inside a valid-index branch.
        # This retains extreme-index safety without min/max in every address.
        code = code.replace(f'start_{p}', f'(index_{p} * BS)')
        old = f'''                for m, n in T.Parallel(G, BS):
                    scores[m, n] = T.if_then_else(
                        (index_{p} * BS) + n < seq_len and (not is_causal or (index_{p} * BS) + n <= t_{p}),
                        0, -T.infinity(T.float32))'''
        new = f'''                if is_causal and (index_{p} * BS) + BS > t_{p} + 1:
                    for m, n in T.Parallel(G, BS):
                        scores[m, n] = T.if_then_else((index_{p} * BS) + n <= t_{p},
                            0, -T.infinity(T.float32))
                elif not is_causal and (index_{p} * BS) + BS > seq_len:
                    for m, n in T.Parallel(G, BS):
                        scores[m, n] = T.if_then_else((index_{p} * BS) + n < seq_len,
                            0, -T.infinity(T.float32))
                else:
                    T.clear(scores)'''
        assert code.count(old) == 1
        code = code.replace(old, new)
        if queries == 1 or not prefetch:
            # With no lookahead, keep loads and compute in one branch, just
            # as in the existing single-query kernel.
            marker = f'            T.clear(out)\n            if valid_{p}:\n'
            assert code.count(marker) == 1
            code = code.replace(marker, '', 1)
            marker = f'            if valid_{p}:\n'
            assert code.count(marker) == 1
            code = code.replace(marker, '            T.clear(out)\n' + marker, 1)
    old = '''                for m, n in T.Parallel(G, BS):
                    prob[m, n] = scores[m, n] * sums[m, n // 4]'''
    new = '''                for m, n in T.Parallel(G, BS):
                    scores[m, n] *= sums[m, n // 4]
                T.copy(scores, prob)'''
    assert code.count(old) == queries
    return code.replace(old, new)


def main():
    base = (ROOT / 'experiments/20261002_final/nsa.py').read_text()
    for count, prefetch in ((1, True), (2, False), (2, True), (4, True)):
        output = HERE / f'd32_queries{count}_prefetch{int(prefetch)}_v2.py'
        assert not output.exists(), output
        source = base.replace('\ndef _get_kernel(', '\n' + revised(count, prefetch) + '\ndef _get_kernel(', 1)
        marker = '        if packed_qo:\n'
        assert source.count(marker) == 1
        source = source.replace(marker, '''        if S == 1 and D == 32 and block_size == 16 and groups == 16 and threads == 64:
            kernel = native_sparse_attention_d32_query_ilp(**common)
        elif packed_qo:
''', 1)
        ast.parse(source)
        output.write_text(source)
        print(output)


if __name__ == '__main__':
    main()
