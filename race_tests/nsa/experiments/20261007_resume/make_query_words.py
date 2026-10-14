"""Use explicit small vectors for Q while keeping its fragment ownership unchanged."""
import ast
import hashlib
import json
from pathlib import Path
from make_s8_schedule import region, replace_once

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/nsa.py'


def transform(fn, width, dim, vector, batch, token, head):
    tree = ast.parse(fn)
    calls = [n for n in ast.walk(tree) if isinstance(n, ast.Expr)
             and isinstance(n.value, ast.Call) and isinstance(n.value.func, ast.Attribute)
             and n.value.func.attr == 'copy' and isinstance(n.value.args[0], ast.Subscript)
             and ast.unparse(n.value.args[0]).startswith('Q[')]
    assert len(calls) == 1
    old = region(fn, calls[0])
    target = ast.unparse(calls[0].value.args[1])
    indent = ' ' * calls[0].col_offset
    if vector == 'mma':
        text = f'''query_lane = T.get_thread_binding()
for query_chunk in T.unroll({dim} // 32):
    for query_word in T.unroll(8 // {width}):
        for query_element in T.vectorized({width}):
            {target}[query_lane % 16, query_chunk * 32 + query_lane // 16 * 8
                     + query_word * {width} + query_element] = Q[
                {batch}, {token}, {head} * G + query_lane % 16,
                query_chunk * 32 + query_lane // 16 * 8 + query_word * {width} + query_element]
'''
    else:
        text = f'''query_lane = T.get_thread_binding()
for query_chunk in T.unroll(G * {dim} // (64 * {vector})):
    for query_word in T.unroll({vector} // {width}):
        for query_element in T.vectorized({width}):
            {target}[(query_chunk * 64 * {vector} + query_lane * {vector}) // {dim},
                     query_lane % ({dim} // {vector}) * {vector} + query_word * {width} + query_element] = Q[
                {batch}, {token}, {head} * G + (query_chunk * 64 * {vector} + query_lane * {vector}) // {dim},
                query_lane % ({dim} // {vector}) * {vector} + query_word * {width} + query_element]
'''
    return replace_once(fn, old, ''.join(indent + line + '\n' for line in text.splitlines()))


def main():
    baseline = BASE.read_text()
    configs = {
        'native_sparse_attention_single_packed_qo_v2': ('D', '4', 'b', 'token', 'h'),
        '_coalesced_block_loads_prim': ('BK', 'q_vec', 'i_b', 'i_t', 'i_h'),
        'native_sparse_attention_shared_q_blocks': ('BK', '8', 'i_b', 'i_t', 'i_h'),
        'native_sparse_attention_short_list_qo_v2': ('BK', '8', 'i_b', 'i_t', 'i_h'),
        'native_sparse_attention_online_packed': ('BK', 'mma', 'i_b', 'i_t', 'i_h'),
        'native_sparse_attention_online_packed_batch_minor_o_v2': ('BK', 'mma', 'i_b', 'i_t', 'i_h'),
        'native_sparse_attention_online_packed_quad_batch_minor_o_v2': ('BK', 'mma', 'i_b', 'i_t', 'i_h'),
    }
    records = []
    for width in (2, 4):
        source = baseline
        for name, config in configs.items():
            node = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == name)
            old = region(source, node, decorated=True)
            source = replace_once(source, old, transform(old, width, *config))
        ast.parse(source)
        path = HERE / f'query_words_v{width}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, fp16_load_width=width, changed_builders=list(configs),
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'query_words_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records, note='Only Q global loads change; ownership, Q shared staging, K/V, MMA, normalization, output and all synchronization remain unchanged.'
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
