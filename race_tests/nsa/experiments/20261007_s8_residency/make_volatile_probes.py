"""Prevent shared-Q load hoisting without changing barriers or numerical operations."""
import ast
import hashlib
import json
from pathlib import Path

from make_probes import FUNCTIONS, once

HERE = Path(__file__).resolve().parent


def main():
    records = []
    for method in ('slice', 'full'):
        parent = HERE / f's8_q_{method}_stage0.py'
        source = parent.read_text()
        before = {n.name:n for n in ast.parse(source).body if isinstance(n,ast.FunctionDef)}
        lines = source.splitlines(keepends=True)
        for name in FUNCTIONS:
            node = before[name]
            old = ''.join(lines[node.lineno-1:node.end_lineno])
            new = once(old, '            Q_shared = T.alloc_shared([G, BK], T.float16)\n',
                '            Q_shared = T.alloc_shared([G, BK], T.float16)\n'
                '            T.attr(Q_shared.data, "volatile_scope", 1)\n')
            source = once(source, old, new)
        after = {n.name:n for n in ast.parse(source).body if isinstance(n,ast.FunctionDef)}
        assert all(ast.dump(before[n])==ast.dump(after[n]) for n in before if n not in FUNCTIONS)
        target = HERE / f's8_q_{method}_volatile.py'
        with target.open('x') as f:
            f.write(source)
        records.append(dict(path=str(target), parent=str(parent),
            sha256=hashlib.sha256(target.read_bytes()).hexdigest()))
    (HERE/'volatile_assembly.json').write_text(json.dumps(records,indent=2)+'\n')
    print('Generated',len(records),'volatile-Q variants')


if __name__ == '__main__':
    main()
