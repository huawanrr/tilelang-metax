"""Reduce masked-score work and live ranges in the packed S1 path."""
from make_probes import HERE, PACKED, once, change_function, packed_probe, write


def schedule_probe(mask=False, joined=False, late_v=False, qvec=4):
    source = packed_probe(qvec=qvec)

    def modify(fn):
        if mask:
            fn = once(fn, '''                for i, j in T.Parallel(G, BS):
                    scores[i, j] = T.if_then_else(
                        start + j < seq_len and (not is_causal or start + j <= token),
                        0.0, -T.infinity(T.float32))''',
                      '''                if is_causal and start + BS > token + 1:
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] = T.if_then_else(start + j <= token,
                            0.0, -T.infinity(T.float32))
                elif (not is_causal) and start + BS > seq_len:
                    for i, j in T.Parallel(G, BS):
                        scores[i, j] = T.if_then_else(start + j < seq_len,
                            0.0, -T.infinity(T.float32))
                else:
                    T.clear(scores)''')
        if late_v:
            vload = '''                for j, d in T.Parallel(BS, W):
                    v[j, d] = V[b, block, h, j // 16, d // 32,
                        (j % 16 // 4) * 16 + d % 16,
                        (d % 32 // 16) * 4 + j % 4]
'''
            fn = once(fn, vload, '')
            fn = once(fn, '''                for ki in T.serial(D // 32):
                    qk.mma(q, k, scores, ki)
''', '''                for ki in T.serial(D // 32):
                    qk.mma(q, k, scores, ki)
''' + vload)
        if joined:
            start = fn.index('            for vo in T.unroll(D // W):')
            end = fn.index('            output_shared = T.alloc_shared', start)
            tail = fn[start:end]
            fn = fn[:start] + ''.join('    '+line if line.strip() else line
                                     for line in tail.splitlines(keepends=True)) + fn[end:]
            fn = once(fn, '''            valid = block >= 0 and block < NB and (not is_causal or start <= token)
            if valid:''', '''            valid = block >= 0 and block < NB and (not is_causal or start <= token)
            T.clear(output_reg)
            if valid:''')
        return fn
    return change_function(source, PACKED, modify)


if __name__ == '__main__':
    for name, kwargs in (
        ('packed_q4_mask', dict(mask=True)),
        ('packed_q4_join', dict(joined=True)),
        ('packed_q4_latev', dict(late_v=True)),
        ('packed_q4_mask_join', dict(mask=True, joined=True)),
        ('packed_q4_mask_latev', dict(mask=True, late_v=True)),
    ):
        write(name, schedule_probe(**kwargs))
