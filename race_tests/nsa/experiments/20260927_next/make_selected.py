"""Assemble a gated candidate without changing the OJ submission files."""
import ast
import textwrap
from pathlib import Path

root = Path(__file__).resolve().parents[2]
folder = Path(__file__).resolve().parent
base = (root / 'experiments/20260927_oj_fix/nsa.py').read_text()
# Preserve the historical input snapshot, but omit its rejected host metadata write.
base = base.replace('    def get_kernel_source():\n        return pack.get_kernel_source() + attention.get_kernel_source()\n\n    run.get_kernel_source = get_kernel_source\n', '')
lane = (folder / 'lane_reduce.py').read_text()

a = base.index('def native_sparse_attention_single_block_emitter(')
b = base.index('\n\n@tilelang.jit', a)
p = base[a:b]
la = lane.index('def native_sparse_attention_single_block_emitter(')
lb = lane.index('\n\n@tilelang.jit', la)
lp = lane[la:lb]
decl = lp[lp.index('            lane_sum = '):lp.index('\n\n            # A fragments')]
p = p.replace('    direct_k=False,', '    direct_k=False,\n    lane_reduce=False,', 1)
p = p.replace('            scores_sum = ', decl + '\n            scores_sum = ', 1)
p = p.replace('            T.fill(scores_sum, 0)', '            if not lane_reduce:\n                T.fill(scores_sum, 0)', 1)
old = '''                    T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                    for i in T.Parallel(G):
                        scores_inv_sum[i] = T.if_then_else(
                            scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)'''
rs = lp.index('                    for i, lane in T.Parallel(G, 4):')
re = lp.index('                    for i, j in T.Parallel(G, BS):', rs)
reduction = lp[rs:re].rstrip()
assert p.count(old) == 2
replacement = ('                    if lane_reduce:\n' + textwrap.indent(reduction, '    ')
               + '\n                    else:\n' + textwrap.indent(old, '    '))
p = p.replace(old, replacement)
p = p.replace('acc_s[i, j] *= scores_inv_sum[i]', 'acc_s[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])')
p = p.replace('acc_o[i, j] *= scores_inv_sum[i]', 'acc_o[i, j] *= (lane_sum[i, j % 16 // 4] if lane_reduce else scores_inv_sum[i])')
s = base[:a] + p + base[b:]

# Dispatch is shared by the factory and preallocated-output interfaces.
a = s.index('def _get_kernel(')
p = s[a:]
p = p.replace('    key = (', '''    # Explicit lane reduction wins on the measured small/direct-K families
    # and on the late-normalized D128/BS32 throughput path.
    lane_reduce = use_emitter and (direct_k or late_normalize or
        (D == 32 and block_size == 16 and grid <= 1024))
    key = (''', 1)
p = p.replace('        dual_acc,\n    )', '        dual_acc,\n        lane_reduce,\n    )', 1)
p = p.replace('                direct_k=direct_k, **common)', '                direct_k=direct_k, lane_reduce=lane_reduce, **common)', 1)
s = s[:a] + p
ast.parse(s)
(folder / 'lane_selected.py').write_text(s)
print(folder / 'lane_selected.py')

# The two- and four-K schedules share one static-depth builder. Keep the
# original loop intact at depth one so unaffected shapes retain their code.
prefetch = (folder / 'prefetch_parametric.py').read_text()
a = s.index('def native_sparse_attention_online_packed(')
b = s.index('\n\n@tilelang.jit', a)
old_p = s[a:b]
pa = prefetch.index('def native_sparse_attention_online_packed(')
pb = prefetch.index('\n\n@tilelang.jit', pa)
p = prefetch[pa:pb].replace('prefetch_depth=4,', 'prefetch_depth=1,', 1)
os = old_p.index('            for s in T.unroll(S, unroll_factor=online_unroll):')
oe = old_p.index('\n            if dual_acc:', os)
ns = p.index('            for group in T.serial(T.ceildiv(S, prefetch_depth)):')
ne = p.index('\n            if dual_acc:', ns)
p = (p[:ns] + '            if prefetch_depth == 1:\n'
     + textwrap.indent(old_p[os:oe], '    ') + '\n            else:\n'
     + textwrap.indent(p[ns:ne], '    ') + p[ne:])
s = s[:a] + p + s[b:]
a = s.index('def _get_kernel(')
p = s[a:]
p = p.replace('    key = (', '''    # Synchronous K lookahead pays off on small and throughput-sized S8
    # grids. The intermediate grid range retains the original schedule.
    prefetch_depth = 1
    if S == 8 and use_emitter_online:
        if grid <= 512 or 2048 <= grid < 4096:
            prefetch_depth = 2
        elif grid >= 4096:
            prefetch_depth = 4
    key = (''', 1)
p = p.replace('        lane_reduce,\n    )', '        lane_reduce,\n        prefetch_depth,\n    )', 1)
p = p.replace('                dual_acc=dual_acc, **common)',
              '                dual_acc=dual_acc, prefetch_depth=prefetch_depth, **common)', 1)
s = s[:a] + p
ast.parse(s)
(folder / 'selected.py').write_text(s)
print(folder / 'selected.py')
