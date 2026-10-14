"""Add the measured finite-score/natural-exponent variant only to mid D64."""
import argparse
import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('output')
    a = p.parse_args()
    probe = (ROOT / 'single_math_e1_predicate.py').read_text()
    lines = probe.splitlines(keepends=True)
    functions = []
    names = {'_coalesced_block_loads_prim_mathcast',
             'native_sparse_attention_coalesced_blocks_mathcast'}
    for fn in ast.parse(probe).body:
        if not isinstance(fn, ast.FunctionDef) or fn.name not in names:
            continue
        first = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
        text = ''.join(lines[first:fn.end_lineno])
        text = text.replace('_coalesced_block_loads_prim_mathcast', '_coalesced_block_loads_prim_oct8')
        text = text.replace('native_sparse_attention_coalesced_blocks_mathcast',
                            'native_sparse_attention_coalesced_blocks_oct8')
        functions.append(text)
    assert len(functions) == 2
    source = (ROOT / 'candidate_v3.py').read_text()
    source = source.replace('def _get_kernel(', '\n\n'.join(functions) + '\n\ndef _get_kernel(', 1)
    old = '''        elif oct8_coalesced:
            kernel = native_sparse_attention_coalesced_blocks_mathcast(q_vec=8, pv_width=128, **common)'''
    new = '''        elif oct8_coalesced:
            kernel = native_sparse_attention_coalesced_blocks_oct8(q_vec=8, pv_width=128, **common)'''
    assert source.count(old) == 1
    source = source.replace(old, new, 1)
    ast.parse(source)
    with Path(a.output).open('x') as f:
        f.write(source)
    print(a.output)


if __name__ == '__main__':
    main()
