"""Check native synchronous LDG/STG lowering without changing kernel logic."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE=Path(__file__).resolve().parent
NAMES={
    'native_sparse_attention_q_preload', 'native_sparse_attention_q_preload_vfirst',
    'native_sparse_attention_linear_v_blocks_oct8',
    'native_sparse_attention_coalesced_blocks_oct8',
    'native_sparse_attention_coalesced_blocks_fp32_mask',
    'native_sparse_attention_coalesced_blocks_fp32_sum',
    'native_sparse_attention_coalesced_blocks_boundary_v8',
    'native_sparse_attention_short_list_oct8_sum_v11',
    'native_sparse_attention_staged_sparse_blocks_sum_v11',
    'native_sparse_attention_single_packed_qo_v2_mathcast_block_joint',
    'native_sparse_attention_pack_kv_bs32_shared_block_joint',
    'native_sparse_attention_pack_kv_bs32_tiles_block_joint',
    'native_sparse_attention_online_packed_batch_minor_o_v2_mathcast',
    'native_sparse_attention_online_packed_quad_batch_minor_o_v2_mathcast',
    'native_sparse_attention_pack_kv',
}
source=(HERE/'baseline.py').read_text()
records=[]
for predicated in (False,True):
    edits=[]
    names=[]
    for fn in ast.parse(source).body:
        if not isinstance(fn,ast.FunctionDef) or fn.name not in NAMES:continue
        node=copy.deepcopy(fn)
        jit=next(d for d in node.decorator_list if isinstance(d,ast.Call) and ast.unparse(d.func)=='tilelang.jit')
        configs=next((k.value for k in jit.keywords if k.arg=='pass_configs'),None)
        if configs is None:
            configs=ast.Dict(keys=[],values=[])
            jit.keywords.append(ast.keyword(arg='pass_configs',value=configs))
        assert isinstance(configs,ast.Dict)
        for name,value in [('TL_ENABLE_LOWER_LDGSTG',True),('TL_ENABLE_LOWER_LDGSTG_PREDICATED',predicated)]:
            configs.keys.append(ast.parse(f'tilelang.PassConfigKey.{name}',mode='eval').body)
            configs.values.append(ast.Constant(value))
        start=min([fn.lineno]+[d.lineno for d in fn.decorator_list])-1
        edits.append((start,fn.end_lineno,ast.unparse(ast.fix_missing_locations(node))+'\n'))
        names.append(fn.name)
    assert set(names)==NAMES
    lines=source.splitlines(keepends=True)
    for start,end,code in sorted(edits,reverse=True):lines[start:end]=[code]
    result=''.join(lines)
    path=HERE/f'ldgstg_pred{int(predicated)}.py'
    compile(result,str(path),'exec')
    with path.open('x') as f:f.write(result)
    records.append(dict(file=path.name,sha256=hashlib.sha256(result.encode()).hexdigest(),predicated=predicated,decorators=names))
with (HERE/'ldgstg_manifest.json').open('x') as f:
    json.dump(dict(parent_sha256=hashlib.sha256(source.encode()).hexdigest(),variants=records,
        semantics='Native compiler pass for synchronous loads/stores. MACA helpers are ordinary typed pointer accesses in the existing library. All algorithms, guards, synchronization and dispatch remain unchanged.',
        next_gate='Check actual .text before interpreting any latency difference.'),f,indent=2)
    f.write('\n')
print('Generated two LDG/STG lowering probes')
