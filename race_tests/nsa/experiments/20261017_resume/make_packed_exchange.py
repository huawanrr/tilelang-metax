"""Remove both shared Q/O transposes on the packed S1 path.

One ownership-bit exchange coalesces Q loads into 64-column rows. Output
exchanges one or two ownership bits, giving 32- or 64-column row stores.
All exchanges move uint32 pairs and preserve both half bit patterns.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAME = "native_sparse_attention_single_packed_qo_v2_mathcast_block_joint"


def nodes(source):
    return ast.parse(source).body


def q_code():
    return nodes('''
q_raw = T.alloc_local([D // 4], T.float16)
q_words = T.Tensor([D // 8], T.uint32, data=q_raw.data, scope="local")
q_swapped = T.alloc_local([D // 8], T.uint32)
q_halves = T.Tensor([D // 4], T.float16, data=q_swapped.data, scope="local")
tid = T.get_thread_binding()
for slab in T.unroll(D // 64):
    for half_row in T.unroll(2):
        for element in T.vectorized(8):
            q_raw[slab * 16 + half_row * 8 + element] = Q[b, token, h * G + tid % 8 + half_row * 8, slab * 64 + tid % 16 // 8 * 32 + tid // 16 * 8 + element]
''')


def q_exchange():
    return nodes('''
for slab in T.unroll(D // 64):
    for word in T.unroll(4):
        q_lo = q_words[slab * 8 + word]
        q_hi = q_words[slab * 8 + 4 + word]
        q_rx = T.shfl_xor(T.if_then_else(tid % 16 < 8, q_hi, q_lo), 8, 64, 18446744073709551615)
        q_swapped[slab * 8 + word] = T.if_then_else(tid % 16 < 8, q_lo, q_rx)
        q_swapped[slab * 8 + 4 + word] = T.if_then_else(tid % 16 < 8, q_rx, q_hi)
for slab in T.unroll(D // 32):
    for element in T.unroll(8):
        q[tid % 16, slab * 32 + tid // 16 * 8 + element] = q_halves[slab * 8 + element]
''')


def output_code(bits):
    assert bits in (1, 2)
    text = '''
output_tid = T.get_thread_binding()
output_raw = T.alloc_local([D // 4], T.float16)
output_words = T.Tensor([D // 8], T.uint32, data=output_raw.data, scope="local")
for chunk in T.unroll(D // 16):
    for element in T.unroll(4):
        output_raw[chunk * 4 + element] = output_reg[output_tid % 16, chunk * 16 + output_tid // 16 * 4 + element]
'''
    for step in range(bits):
        lane_bit = 8 >> step
        reg_bit = 2 << step  # a word carries two half values
        previous = "output_words" if step == 0 else f"output_exchange{step-1}"
        text += f"output_exchange{step} = T.alloc_local([D // 8], T.uint32)\n"
        text += f'''
for group in T.unroll(D // {16 * reg_bit}):
    for word in T.unroll({reg_bit}):
        output_lo = {previous}[group * {reg_bit * 2} + word]
        output_hi = {previous}[group * {reg_bit * 2} + {reg_bit} + word]
        output_rx = T.shfl_xor(T.if_then_else(output_tid % {lane_bit * 2} < {lane_bit}, output_hi, output_lo), {lane_bit}, 64, 18446744073709551615)
        output_exchange{step}[group * {reg_bit * 2} + word] = T.if_then_else(output_tid % {lane_bit * 2} < {lane_bit}, output_lo, output_rx)
        output_exchange{step}[group * {reg_bit * 2} + {reg_bit} + word] = T.if_then_else(output_tid % {lane_bit * 2} < {lane_bit}, output_rx, output_hi)
'''
    text += f'output_halves = T.Tensor([D // 4], T.float16, data=output_exchange{bits-1}.data, scope="local")\n'
    row = "output_tid % 8 + (chunk % 2) * 8"
    col = "(chunk // 2) * 32 + output_tid % 16 // 8 * 16 + output_tid // 16 * 4 + element"
    if bits == 2:
        row = "output_tid % 4 + chunk % 2 * 8 + chunk % 4 // 2 * 4"
        col = "(chunk // 4) * 64 + output_tid % 16 // 8 * 16 + output_tid % 8 // 4 * 32 + output_tid // 16 * 4 + element"
    text += f'''
for chunk in T.unroll(D // 16):
    for element in T.vectorized(4):
        Output[b, token, h * G + {row}, {col}] = output_halves[chunk * 4 + element]
'''
    return nodes(text)


def transform(fn, q_mode, out_bits):
    fn = copy.deepcopy(fn)
    fn.decorator_list = []
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    guard = next(n for n in scope.body if isinstance(n, ast.If) and ast.unparse(n.test) == "valid")
    if q_mode:
        pos = next(i for i,n in enumerate(scope.body) if ast.unparse(n).startswith("T.copy(Q["))
        scope.body[pos:pos+1] = q_code()
        pos = next(i for i,n in enumerate(guard.body) if ast.unparse(n) == "T.copy(q_stage, q_shared)")
        assert [ast.unparse(n) for n in guard.body[pos:pos+3]] == [
            "T.copy(q_stage, q_shared)", "T.sync_warp()", "T.copy(q_shared, q)"]
        guard.body[pos:pos+3] = q_exchange()
    if out_bits:
        pos = next(i for i,n in enumerate(scope.body) if isinstance(n, ast.Assign)
                   and ast.unparse(n.targets[0]) == "output_shared")
        scope.body[pos:] = output_code(out_bits)
    return ast.unparse(ast.fix_missing_locations(fn))


def prove_output(dim, bits):
    original = [[(tid % 16, chunk * 16 + tid // 16 * 4 + element)
                 for chunk in range(dim // 16) for element in range(4)] for tid in range(64)]
    packed = [[tuple(values[i:i+2]) for i in range(0,len(values),2)] for values in original]
    current = packed
    for step in range(bits):
        lane_bit, reg_bit = 8 >> step, 2 << step
        changed = [[None] * (dim // 8) for _ in range(64)]
        for tid in range(64):
            for word in range(dim // 8):
                # Swap one register-address bit with one lane-address bit.
                different = bool(tid & lane_bit) != bool(word & reg_bit)
                src_lane = tid ^ lane_bit if different else tid
                src_word = word ^ reg_bit if different else word
                changed[tid][word] = current[src_lane][src_word]
        current = changed
    covered=set()
    for tid in range(64):
        half = [v for pair in current[tid] for v in pair]
        for chunk in range(dim//16):
            for element in range(4):
                row = tid % 8 + chunk % 2 * 8
                col = chunk // 2 * 32 + tid % 16 // 8 * 16 + tid // 16 * 4 + element
                if bits == 2:
                    row = tid % 4 + chunk % 2 * 8 + chunk % 4 // 2 * 4
                    col = chunk // 4 * 64 + tid % 16 // 8 * 16 + tid % 8 // 4 * 32 + tid // 16 * 4 + element
                assert half[chunk*4+element] == (row,col), (tid,chunk,element)
                assert (row,col) not in covered
                covered.add((row,col))
    assert len(covered) == 16*dim
    return dict(dim=dim,bits=bits,elements=len(covered),unique_coverage=True,bit_preserving=True)


def main():
    source=(HERE/'baseline.py').read_text()
    fn=next(n for n in ast.parse(source).body if isinstance(n,ast.FunctionDef) and n.name==NAME)
    original=ast.get_source_segment(source,fn)
    variants=[]
    for q_mode,out_bits in ((1,0),(0,1),(0,2),(1,1),(1,2)):
        result=source.replace(original,transform(fn,q_mode,out_bits),1)
        ast.parse(result)
        path=HERE/f'packed_exchange_q{q_mode}_o{out_bits}.py'
        with path.open('x') as f: f.write(result)
        variants.append(dict(path=path.name,q_exchange=q_mode,output_bits=out_bits,
                             sha256=hashlib.sha256(result.encode()).hexdigest()))
    manifest=dict(baseline_sha256=hashlib.sha256(source.encode()).hexdigest(),
                  function=NAME,variants=variants,
                  output_proofs=[prove_output(d,b) for d in (64,128) for b in (1,2)],
                  q_mapping='Same exact one-bit mapping proven in 20261014_goal8933/make_operand_butterfly.py',
                  scope='Existing default packed S1 block-joint builder only; all arithmetic and indices preserved')
    (HERE/'packed_exchange_manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
    print('Generated',len(variants),'variants; output ownership proof PASS')


if __name__=='__main__':
    main()
