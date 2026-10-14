"""Probe independent score accumulators in the existing synchronous K lookahead."""
import ast
import re
from pathlib import Path

folder = Path(__file__).resolve().parent
base = (folder / 'baseline.py').read_text()
a = base.index('def native_sparse_attention_online_packed(')
b = base.index('\n\n@tilelang.jit', a)
original = base[a:b]
start = original.index('            else:\n                for group in T.serial')
end = original.index('\n            if dual_acc:', start)
loop = original[start:end]
# The second slot-0 guard starts the compute phase after all four K loads.
guard0 = '                    if (prefetch_depth > 0 and group * prefetch_depth + 0 < S'
compute_start = loop.index(guard0, loop.index(guard0) + 1)
loads = loop[:compute_start]
compute = loop[compute_start:]

def guard(slot):
    return (f'                    if (prefetch_depth > {slot} and group * prefetch_depth + {slot} < S and i_s{slot} >= 0 and i_s{slot} < seq_len\n'
            f'                            and (not is_causal or i_s{slot} <= i_t)):\n')

parts = []
for slot in range(4):
    lo = compute.index(guard(slot)) + len(guard(slot))
    hi = compute.index(guard(slot + 1)) if slot < 3 else len(compute)
    body = compute[lo:hi]
    mask_start = body.index('                        if is_causal')
    mma_start = body.index('                        for ki in T.serial(qk_steps):')
    exp_start = body.index('                        for i, j in T.Parallel(G, BS):\n                            acc_s[i, j] = T.exp2')
    parts.append((body[:mask_start], body[mask_start:mma_start],
                  body[mma_start:exp_start], body[exp_start:]))

def score_name(text, slot):
    return re.sub(r'\bacc_s\b', f'acc_s{slot}' if slot else 'acc_s', text)

for mode in ('grouped', 'interleaved'):
    body = loads
    if mode == 'grouped':
        for slot, (vload, mask, mma, finish) in enumerate(parts):
            body += guard(slot) + score_name(mask + mma, slot)
    else:
        for slot, (vload, mask, mma, finish) in enumerate(parts):
            body += guard(slot) + score_name(mask, slot)
        body += '                    for ki in T.serial(qk_steps):\n'
        for slot in range(4):
            body += '    ' + guard(slot).replace('\n', '\n    ').rstrip() + '\n'
            k = f'K_reg{slot}' if slot else 'K_reg'
            s = f'acc_s{slot}' if slot else 'acc_s'
            body += f'                            qk.mma(Q_reg, {k}, {s}, ki)\n'
    for slot, (vload, mask, mma, finish) in enumerate(parts):
        body += guard(slot) + score_name(vload + finish, slot)
    p = original[:start] + body.rstrip() + '\n' + original[end:]
    decl = ''.join(f'            acc_s{i} = T.alloc_fragment([G, BS], T.float32)\n' for i in range(1, 4))
    anno = ''.join(f'                acc_s{i}: qk.make_mma_store_layout(acc_s{i}),\n' for i in range(1, 4))
    p = p.replace('            acc_s = T.alloc_fragment', decl + '            acc_s = T.alloc_fragment', 1)
    p = p.replace('                acc_s: qk.make_mma_store_layout(acc_s),', anno + '                acc_s: qk.make_mma_store_layout(acc_s),', 1)
    src = base[:a] + p + base[b:]
    ast.parse(src)
    (folder / f'qk_{mode}.py').write_text(src)
