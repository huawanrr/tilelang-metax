"""Keep only existing D32 and S4 builders for fixed follow-up measurements."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
PARENT = HERE / 'baseline.py'
PROBE = HERE.parent / '20261016_pow2/pow2_all.py'
GROUPS = {
    'pow2_d32': ['native_sparse_attention_q_preload_vfirst'],
    'pow2_s4': ['native_sparse_attention_staged_sparse_blocks_sum_v11'],
    'pow2_d32_s4': ['native_sparse_attention_q_preload_vfirst',
                    'native_sparse_attention_staged_sparse_blocks_sum_v11'],
}


def main():
    source, probe = PARENT.read_text(), PROBE.read_text()
    assert hashlib.sha256(source.encode()).hexdigest() == 'fb6b0fb5df10bc497841e9a0da922a0062f84689088c9503bc526aef71b9a976'
    assert hashlib.sha256(probe.encode()).hexdigest() == '811aac4732d7d30a2f069d8fc30fefc76e3ae0133683c761939d05d0059d8765'
    old = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    new = {n.name: n for n in ast.parse(probe).body if isinstance(n, ast.FunctionDef)}
    records = []
    for label, names in GROUPS.items():
        result = source
        for name in names:
            result = result.replace(ast.get_source_segment(source, old[name]),
                                    ast.get_source_segment(probe, new[name]), 1)
        actual = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert {n for n in old if ast.dump(old[n]) != ast.dump(actual[n])} == set(names)
        with (HERE / (label + '.py')).open('x') as f:
            f.write(result)
        records.append(dict(file=label + '.py', changed_functions=names,
                            sha256=hashlib.sha256(result.encode()).hexdigest()))
    with (HERE / 'followup_manifest.json').open('x') as f:
        json.dump(dict(variants=records, dispatch_unchanged=True, status='unvalidated research probes'), f, indent=2)
        f.write('\n')
    print('Generated', len(records), 'follow-up probes')


if __name__ == '__main__':
    main()
