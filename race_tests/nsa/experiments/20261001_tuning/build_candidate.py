"""Add the measured Q/O path while preserving every 930 GPU builder."""
import argparse
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
BASE = ROOT / 'experiments/20260930_candidate/nsa.py'
PROBE = ROOT / 'experiments/20260930_next/qo_q8s8_o8_pv128.py'


def once(source, before, after):
    assert source.count(before) == 1, (before, source.count(before))
    return source.replace(before, after, 1)


def builders(include_ilp):
    source = PROBE.read_text()
    node = next(n for n in ast.parse(source).body
                if isinstance(n, ast.FunctionDef) and n.name == 'native_sparse_attention_probe')
    lines = source.splitlines()
    body = '\n'.join(lines[node.lineno - 1:node.end_lineno]) + '\n'
    body = once(body, 'def native_sparse_attention_probe(', 'def _coalesced_qo_prim(')
    body = once(body, '    threads=64, wave_sync=True,',
                '    threads=64, wave_sync=True, q_vec=8, pv_width=128,')
    old_doc = ast.get_docstring(node, clean=False)
    body = once(body, '"""' + old_doc + '"""', '''"""Single selected block with coalesced Q loads and output stores.

    Q, K, V and O reuse one shared allocation. Seven explicit wave barriers
    protect Q RAW, Q/K WAR, K RAW, K/V WAR, V RAW, V/O WAR and O RAW.
    The query index and validity branch are uniform across all 64 lanes.
    q_vec and pv_width are compile-time layout choices, selected by shape.
    """''')
    body = once(body, '    assert threads == 64 and groups == 16',
                '    assert threads == 64 and groups == 16\n'
                '    assert dim in (64, 128) and block_size in (16, 32)\n'
                '    assert q_vec in (4, 8) and pv_width in (64, 128)')
    body = once(body, '    VW = min(128, BV)', '    VW = min(pv_width, BV)')
    body = once(body, '(i * BK + d) // 8 % 64', '(i * BK + d) // q_vec % 64')
    body = once(body, '(i * BK + d) // 512 * 8 + d % 8',
                '(i * BK + d) // (64 * q_vec) * q_vec + d % q_vec')
    decorator = '\n'.join(lines[node.decorator_list[0].lineno - 1:node.lineno - 1])
    wrapper = '''
def native_sparse_attention_coalesced_qo(
    batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
    threads=64, q_vec=8, pv_width=128,
):
    return _coalesced_qo_prim(
        batch, heads, seq_len, dim, is_causal, block_size, groups, scale_log2,
        threads=threads, q_vec=q_vec, pv_width=pv_width, lane_reduce=True)
'''
    ilp_decorator = once(decorator, '@tilelang.jit(',
                         '@tilelang.jit(compile_flags=["-mllvm", "--misched=metaxgpu-ilp"],')
    ilp_wrapper = once(wrapper, 'def native_sparse_attention_coalesced_qo(',
                       'def native_sparse_attention_coalesced_qo_ilp(')
    return (body + '\n' + decorator + wrapper
            + ('\n' + ilp_decorator + ilp_wrapper if include_ilp else ''))


def packed_builder():
    source = (PROBE.parent / 'packed_qo_pv128.py').read_text()
    node = next(n for n in ast.parse(source).body
                if isinstance(n, ast.FunctionDef) and n.name == 'single_packed_qo')
    lines = source.splitlines()
    body = '\n'.join(lines[node.decorator_list[0].lineno - 1:node.end_lineno]) + '\n'
    body = once(body, 'def single_packed_qo(', 'def native_sparse_attention_single_packed_qo(')
    body = once(body, '    assert groups == 16', '''    """Consume K/V packed from the current inputs and stage Q/O coalesced.

    The pack launch is part of every invocation. Only Q and O use shared
    memory, with barriers at Q RAW, Q/O WAR and O RAW. The denominator
    AllReduce<64,16> uses two warp shuffles without touching shared scratch.
    """
    assert groups == 16''')
    return body


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--output', required=True)
    p.add_argument('--d64-min', type=int, default=2048)
    p.add_argument('--d128-min', type=int, default=2048)
    p.add_argument('--bs32-min', type=int, default=1024)
    p.add_argument('--bs32-ilp', action='store_true')
    p.add_argument('--packed-bs32-min', type=int)
    a = p.parse_args()
    base = BASE.read_text()
    extra = builders(a.bs32_ilp)
    if a.packed_bs32_min is not None:
        extra += '\n' + packed_builder()
    source = once(base, 'def _get_kernel(', extra + '\n\ndef _get_kernel(')
    dispatch = f'''
    # Coalesced Q/O staging pays for its four additional barriers only once
    # the launch has sufficient parallel work. Keep explicit tuning overrides
    # on their original 930 paths. Both public interfaces share this dispatch.
    qo_defaults = (S == 1 and groups == 16 and threads == 64 and stage_regs
        and kv_reuse and q_preload and nmax and not o_stage and not kv_frag
        and not kv_split and min_blocks == 0 and q_frag == (block_size == 32))
    packed_qo = qo_defaults and D == 128 and block_size == 32 and grid >= {a.packed_bs32_min if a.packed_bs32_min is not None else 0} and {a.packed_bs32_min is not None!r}
    coalesced_qo = qo_defaults and not packed_qo and (
        (D == 64 and block_size == 16 and grid >= {a.d64_min})
        or (D == 128 and block_size == 16 and grid >= {a.d128_min})
        or (D == 128 and block_size == 32 and grid >= {a.bs32_min}))
    qo_narrow = coalesced_qo and D == 128 and block_size == 32 and grid < 2048
    qo_four = qo_narrow or (coalesced_qo and D == 128 and block_size == 32 and H > 1)
    qo_ilp = coalesced_qo and D == 128 and block_size == 32 and grid >= 2048 and H == 1 and {a.bs32_ilp!r}
'''
    source = once(source, '\n    key = (', dispatch + '\n    key = (')
    source = once(source,
        '        wave_single, wave_q_reuse, wave_q_parallel, pv32_sync, joined_short,',
        '        wave_single, wave_q_reuse, wave_q_parallel, pv32_sync, joined_short,\n'
        '        coalesced_qo, qo_narrow, qo_four, qo_ilp, packed_qo,')
    choice = ('(native_sparse_attention_coalesced_qo_ilp if qo_ilp\n'
              '                       else native_sparse_attention_coalesced_qo)'
              if a.bs32_ilp else 'native_sparse_attention_coalesced_qo')
    body = f'''        if coalesced_qo:
            builder = {choice}
            kernel = builder(q_vec=4 if qo_four else 8,
                             pv_width=64 if qo_narrow else 128, **common)
        elif joined_short:'''
    if a.packed_bs32_min is not None:
        body = once(body, '        if coalesced_qo:', '''        if packed_qo:
            attention = native_sparse_attention_single_packed_qo(width=128, late=False, **common)
            pack = native_sparse_attention_pack_kv(B, seq_len, H, D, block_size)
            kernel = _make_packed_attention(pack, attention, B, seq_len, H, D, block_size)
        elif coalesced_qo:''')
    source = once(source, '        if joined_short:', body)
    old = {n.name: ast.dump(n, include_attributes=False) for n in ast.parse(base).body
           if isinstance(n, ast.FunctionDef)}
    new = {n.name: ast.dump(n, include_attributes=False) for n in ast.parse(source).body
           if isinstance(n, ast.FunctionDef)}
    assert all(new[name] == value for name, value in old.items() if name != '_get_kernel')
    output = Path(a.output)
    output.parent.mkdir(parents=True, exist_ok=True)
    if output.exists():
        raise FileExistsError(output)
    output.write_text(source)
    report = dict(options=vars(a), preserved_930_functions=len(old) - 1,
        sha256={str(path.relative_to(ROOT)): hashlib.sha256(path.read_bytes()).hexdigest()
                for path in (BASE, PROBE, output.resolve())})
    output.with_suffix('.build.json').write_text(json.dumps(report, indent=2) + '\n')
    print(output, report['preserved_930_functions'], 'unchanged 930 functions')


if __name__ == '__main__':
    main()
