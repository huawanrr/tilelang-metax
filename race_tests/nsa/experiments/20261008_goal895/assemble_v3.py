"""Assemble v2 and the independently measured S4 pipeline without rewriting builders."""
import argparse
import ast
from pathlib import Path

ROOT = Path(__file__).resolve().parent


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('output')
    args = parser.parse_args()
    probe = (ROOT / 's4_pipeline_probe.py').read_text()
    lines = probe.splitlines(keepends=True)
    fn = next(n for n in ast.parse(probe).body if isinstance(n, ast.FunctionDef)
              and n.name == 'native_sparse_attention_staged_sparse_blocks')
    first = min([fn.lineno] + [d.lineno for d in fn.decorator_list]) - 1
    function = ''.join(lines[first:fn.end_lineno])
    source = (ROOT / 'candidate_v2.py').read_text()
    source = source.replace('def _get_kernel(', function + '\n\ndef _get_kernel(', 1)
    source = source.replace('    key = (\n', '''    oct8_staged = (mathcast_defaults and groups == 16 and D == 64 and S == 4
        and block_size == 16 and seq_len >= 128 and seq_len % block_size == 0
        and H <= 2 and grid <= 4096)

    key = (
''', 1)
    source = source.replace('        oct8_direct, oct8_linear, oct8_coalesced, oct8_short, oct8_s4,\n',
        '        oct8_direct, oct8_linear, oct8_coalesced, oct8_short, oct8_s4, oct8_staged,\n', 1)
    source = source.replace('        elif oct8_s4:\n', '''        elif oct8_staged:
            kernel = native_sparse_attention_staged_sparse_blocks(selected_blocks=S, **common)
        elif oct8_s4:
''', 1)
    ast.parse(source)
    with Path(args.output).open('x') as f:
        f.write(source)
    print(args.output)


if __name__ == '__main__':
    main()
