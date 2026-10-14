"""Restrict S4 packing to the grid range with consistent multiseed gains."""
import ast
import hashlib
import json
from pathlib import Path

from make_joined_packed import replace_once

HERE = Path(__file__).resolve().parent


def main():
    parent = HERE / 'candidate_combined_v1.py'
    source = replace_once(parent.read_text(),
        'and seq_len >= 256 and grid >= 512)',
        'and seq_len >= 256 and grid >= 2048)')
    source = replace_once(source,
        's4_prefetch = 4 if grid >= 3072 else (2 if grid >= 1536 else 1)',
        's4_prefetch = 4 if grid >= 3072 else 2')
    before = {n.name: ast.dump(n) for n in ast.parse(parent.read_text()).body
              if isinstance(n, ast.FunctionDef)}
    after = {n.name: ast.dump(n) for n in ast.parse(source).body
             if isinstance(n, ast.FunctionDef)}
    assert all(before[n] == after[n] for n in before if n != '_get_kernel')
    path = HERE / 'candidate_combined_v2.py'
    with path.open('x') as f:
        f.write(source)
    config = json.loads((HERE / 'candidate_combined_v1_assembly.json').read_text())
    config.update(parent=str(parent), parent_sha256=hashlib.sha256(parent.read_bytes()).hexdigest(),
                  candidate=path.name, candidate_sha256=hashlib.sha256(path.read_bytes()).hexdigest())
    config['s4_config'].update(grid_min=2048, prefetch2_grid_min=2048)
    config['selection_evidence'] = 's4_v1_conservative_summary.json'
    config['selection_reason'] = ('48/48 shape-seed groups gain at grid >= 2048; '
                                  'smaller grids have genuine regressions.')
    (HERE / 'candidate_combined_v2_assembly.json').write_text(json.dumps(config, indent=2) + '\n')
    print(path, config['candidate_sha256'])


if __name__ == '__main__':
    main()
