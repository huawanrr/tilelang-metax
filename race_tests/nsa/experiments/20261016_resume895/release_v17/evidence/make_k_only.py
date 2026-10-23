"""Pack K once per invocation; obtain original V inside the BS32 attention CTA.

This differs from the prior V-only pack and from streaming already-packed V.
No quantization, asynchronous copy, backend change, or input cache is involved.
"""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ATTENTION = 'native_sparse_attention_single_packed_qo_v2_mathcast_block_joint'
PACKS = ['native_sparse_attention_pack_kv_bs32_direct_block_joint',
         'native_sparse_attention_pack_kv_bs32_shared_block_joint',
         'native_sparse_attention_pack_kv_bs32_tiles_block_joint']
WRAPPER = '_make_block_joint_attention'


def nodes(text):
    return ast.parse(text).body


def remove_layout_entries(scope, removed):
    for stmt in scope.body:
        if not (isinstance(stmt, ast.Expr) and isinstance(stmt.value, ast.Call)
                and ast.unparse(stmt.value.func) == 'T.annotate_layout'):
            continue
        layout = stmt.value.args[0]
        entries = [(k, v) for k, v in zip(layout.keys, layout.values)
                   if ast.unparse(k) not in removed]
        layout.keys, layout.values = map(list, zip(*entries)) if entries else ([], [])


def prepare_pack(fn):
    fn = copy.deepcopy(fn)
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    removed = {'packed_v', 'v_shared', 'tile'}
    remove_layout_entries(scope, removed)
    retained = []
    for stmt in scope.body:
        text = ast.unparse(stmt)
        if isinstance(stmt, ast.Assign) and any(ast.unparse(t) in removed for t in stmt.targets):
            continue
        if isinstance(stmt, ast.Expr) and isinstance(stmt.value, ast.Call):
            call = stmt.value
            if ast.unparse(call.func) == 'T.copy' and any(
                    isinstance(n, ast.Name) and n.id in removed | {'V'} for n in ast.walk(call)):
                continue
            if ast.unparse(call.func) == 'T.annotate_layout' and not call.args[0].keys:
                continue
        if isinstance(stmt, ast.For) and 'packed_v[' in text:
            continue
        # The non-tiled K pack has no shared-memory dependency left.
        if fn.name != PACKS[2] and text == 'T.sync_threads()':
            continue
        retained.append(stmt)
    scope.body = retained
    return fn


def prepare_attention(fn, mode):
    fn = copy.deepcopy(fn)
    kernel = next(n for n in fn.body if isinstance(n, ast.FunctionDef))
    value_arg = ast.arg(arg='V', annotation=ast.parse(
        'T.Tensor([batch, seq_len, H, D], T.float16)', mode='eval').body)
    kernel.args.args.insert(2, value_arg)
    scope = next(n for n in kernel.body if isinstance(n, ast.With))
    valid = next(n for n in scope.body if isinstance(n, ast.If) and ast.unparse(n.test) == 'valid')
    vload_index = next(i for i,n in enumerate(valid.body) if isinstance(n, ast.For)
                       and 'v[j, d] = PackedKV' in ast.unparse(n))
    vo = next(n for n in valid.body if isinstance(n, ast.For) and ast.unparse(n.target) == 'vo')
    if mode == 'direct':
        valid.body[vload_index:vload_index + 1] = nodes('''for j, d in T.Parallel(BS, W):
    v[j, d] = V[b, start + j, h, d]''')
        extra = next(n for n in vo.body if isinstance(n, ast.If) and ast.unparse(n.test) == 'vo > 0')
        extra.body = nodes('''for j, d in T.Parallel(BS, W):
    v[j, d] = V[b, start + j, h, vo * W + d]''')
        return fn
    tile = 16 if mode == 'shared16' else 'BS'
    scope.body[:0] = nodes(f'''v_stage = T.alloc_fragment([{tile}, W], T.float16)
v_shared = T.alloc_shared([{tile}, W], T.float16)
T.annotate_layout({{
    v_stage: T.Fragment([{tile}, W],
        forward_thread_fn=lambda vi, vd: (vi * W + vd) // 8 % 64,
        forward_index_fn=lambda vi, vd: (vi * W + vd) // 512 * 8 + vd % 8),
    v_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(v_shared, vecSize=8),
}})''')
    valid.body[vload_index:vload_index + 1] = nodes(
        f'T.copy(V[b, start:start + {tile}, h, 0:W], v_stage)')
    extra = next(n for n in vo.body if isinstance(n, ast.If) and ast.unparse(n.test) == 'vo > 0')
    extra.body = nodes(f'T.copy(V[b, start:start + {tile}, h, vo * W:(vo + 1) * W], v_stage)')
    loop_index = next(i for i,n in enumerate(vo.body) if isinstance(n, ast.For)
                      and 'pv.mma(' in ast.unparse(n))
    if mode == 'shared16':
        declaration = next(n for n in scope.body if isinstance(n, ast.Assign)
                           and any(isinstance(t,ast.Name) and t.id == 'v' for t in n.targets))
        declaration.value = ast.parse('T.alloc_local([W // 4], T.float16)', mode='eval').body
        remove_layout_entries(scope, {'v'})
        vo.body[loop_index:loop_index + 1] = nodes('''for ki in T.unroll(BS // 16):
    if ki > 0:
        T.copy(V[b, start + ki * 16:start + (ki + 1) * 16, h, vo * W:(vo + 1) * W], v_stage)
    T.sync_warp()
    T.copy(v_stage, v_shared)
    T.sync_warp()
    pv.ldmatrix_b(v, v_shared, 0)
    pv.mma(prob, v, out, ki)''')
    else:
        vo.body[loop_index:loop_index] = nodes('''T.sync_warp()
T.copy(v_stage, v_shared)
T.sync_warp()
T.copy(v_shared, v)''')
    return fn


def main():
    source = (HERE / 'baseline.py').read_text()
    assert hashlib.sha256(source.encode()).hexdigest() == 'fb6b0fb5df10bc497841e9a0da922a0062f84689088c9503bc526aef71b9a976'
    originals = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    records = []
    for mode in ['direct', 'shared16', 'shared32']:
        updates = {name: prepare_pack(originals[name]) for name in PACKS}
        updates[ATTENTION] = prepare_attention(originals[ATTENTION], mode)
        result = source
        for name, node in updates.items():
            node.decorator_list = []
            text = ast.unparse(ast.fix_missing_locations(node))
            assert '[batch, NB, H, 2,' in text
            text = text.replace('[batch, NB, H, 2,', '[batch, NB, H, 1,')
            result = result.replace(ast.get_source_segment(source, originals[name]), text, 1)
        wrapper = ast.get_source_segment(source, originals[WRAPPER])
        new_wrapper = wrapper.replace('heads, 2,', 'heads, 1,').replace(
            'attention(Q, packed, BlockIndices, Output)', 'attention(Q, packed, V, BlockIndices, Output)')
        assert new_wrapper != wrapper
        result = result.replace(wrapper, new_wrapper, 1)
        actual = {n.name:n for n in ast.parse(result).body if isinstance(n,ast.FunctionDef)}
        assert {n for n in originals if ast.dump(originals[n]) != ast.dump(actual[n])} == set(PACKS + [ATTENTION, WRAPPER])
        compile(result, mode, 'exec')
        path = HERE / f'k_only_v_{mode}.py'
        with path.open('x') as out:
            out.write(result)
        records.append(dict(file=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                            mode=mode, packed_planes=1,
                            v_tile_rows={'direct':0, 'shared16':16, 'shared32':32}[mode]))
    with (HERE / 'k_only_manifest.json').open('x') as out:
        json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(), variants=records,
                       status='unvalidated research probes', changed_functions=PACKS + [ATTENTION, WRAPPER],
                       invariants='Same FP16 inputs and FP32 math, complete original indices/masks, current-call K packing; explicit shared RAW/WAR wave barriers.'), out, indent=2)
        out.write('\n')
    print('Generated', len(records), 'K-only packing probes')


if __name__ == '__main__':
    main()
