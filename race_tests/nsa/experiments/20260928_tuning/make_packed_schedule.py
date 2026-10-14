"""Independent synchronous Q-load ordering and explicit lane-reduction probes."""
import ast
from pathlib import Path

folder = Path(__file__).resolve().parent
base = (folder / 'baseline.py').read_text()
a = base.index('def native_sparse_attention_online_packed(')
b = base.index('\n\n@tilelang.jit', a)
original = base[a:b]

def qfirst(p):
    q = '            T.copy(Q[i_b, i_t, i_h * G : (i_h + 1) * G, :], Q_reg)\n'
    assert p.count(q) == 1
    p = p.replace(q, '')
    return p.replace('            indices = T.alloc_local([S], T.int32)\n',
                     q + '            indices = T.alloc_local([S], T.int32)\n')

def lane(p):
    old = '''            scores_sum = T.alloc_fragment([G], T.float32)
            inv_sum = T.alloc_fragment([G], T.float32)'''
    new = '''            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})'''
    assert p.count(old) == 1
    p = p.replace(old, new)
    old = '''            T.reduce_sum(sum_acc, scores_sum, dim=1, clear=True)
            for i in T.Parallel(G):
                inv_sum[i] = T.if_then_else(
                    scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)'''
    new = '''            for i, lane in T.Parallel(G, 4):
                lane_sum[i, lane] = 0
                for k in T.unroll(BS // 16):
                    for j in T.unroll(4):
                        lane_sum[i, lane] += sum_acc[i, k * 16 + lane * 4 + j]
            for i, lane in T.Parallel(G, 4):
                lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                    1.0 / lane_sum[i, lane], 0.0)'''
    assert p.count(old) == 1
    return p.replace(old, new).replace('acc_o[i, j] *= inv_sum[i]',
                                     'acc_o[i, j] *= lane_sum[i, j % 16 // 4]')

for name, p in [('packed_qfirst', qfirst(original)),
                ('packed_lane', lane(original)),
                ('packed_qfirst_lane', lane(qfirst(original)))]:
    src = base[:a] + p + base[b:]
    ast.parse(src)
    (folder / (name + '.py')).write_text(src)
