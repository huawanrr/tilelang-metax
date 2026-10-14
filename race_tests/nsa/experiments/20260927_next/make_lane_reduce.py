"""Rebase a previously promising lane reduction on the class-free source."""
import ast
from pathlib import Path

root = Path(__file__).resolve().parents[2]
base = (root / 'experiments/20260927_oj_fix/nsa.py').read_text()
# Preserve the historical input snapshot, but omit its rejected host metadata write.
base = base.replace('    def get_kernel_source():\n        return pack.get_kernel_source() + attention.get_kernel_source()\n\n    run.get_kernel_source = get_kernel_source\n', '')
a = base.index('def native_sparse_attention_single_block_emitter(')
b = base.index('\n\n@tilelang.jit', a)
p = base[a:b]
p = p.replace('            scores_sum = T.alloc_fragment([G], T.float32)\n            scores_inv_sum = T.alloc_fragment([G], T.float32)', '''            lane_sum = T.alloc_fragment([G, 4], T.float32)
            T.annotate_layout({lane_sum: T.Fragment([G, 4],
                forward_thread_fn=lambda i, j: i + j * 16,
                forward_index_fn=lambda i, j: 0)})''')
p = p.replace('            T.fill(scores_sum, 0)\n', '')
reduction = '''                    for i, lane in T.Parallel(G, 4):
                        lane_sum[i, lane] = 0
                        for k in T.unroll(BS // 16):
                            for j in T.unroll(4):
                                lane_sum[i, lane] += acc_s[i, k * 16 + lane * 4 + j]
                    for i, lane in T.Parallel(G, 4):
                        lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 32, 64, 0xffffffffffffffff)
                        lane_sum[i, lane] += T.shfl_xor(lane_sum[i, lane], 16, 64, 0xffffffffffffffff)
                        lane_sum[i, lane] = T.if_then_else(lane_sum[i, lane] > 0,
                            1.0 / lane_sum[i, lane], 0.0)'''
old = '''                    T.reduce_sum(acc_s, scores_sum, dim=1, clear=True)
                    for i in T.Parallel(G):
                        scores_inv_sum[i] = T.if_then_else(
                            scores_sum[i] > 0, 1.0 / scores_sum[i], 0.0)'''
assert p.count(old) == 2
p = p.replace(old, reduction).replace('scores_inv_sum[i]', 'lane_sum[i, j % 16 // 4]')
src = base[:a] + p + base[b:]
ast.parse(src)
Path(__file__).with_name('lane_reduce.py').write_text(src)
