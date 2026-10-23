"""Isolate unfinished public-pow experiments from the immutable v16 source."""
import ast
import hashlib
import importlib.util
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
PARENT = HERE.parent / '20261016_rsqrt/release_v16/submission.py'
EXPECTED = 'fb6b0fb5df10bc497841e9a0da922a0062f84689088c9503bc526aef71b9a976'
GROUPS = {
    'pow2_small': ['native_sparse_attention_q_preload', 'native_sparse_attention_q_preload_vfirst'],
    'pow2_short': ['native_sparse_attention_short_list_oct8_sum_v11',
                   'native_sparse_attention_short_list_oct8_wave_output_v15',
                   'native_sparse_attention_staged_sparse_blocks_sum_v11'],
    'pow2_mid': ['_coalesced_block_loads_prim_oct8'],
    'pow2_packed': ['native_sparse_attention_single_packed_qo_v2_mathcast_block_joint'],
}


def write_new(path, text):
    with path.open('x') as out:
        out.write(text)


def main():
    source = PARENT.read_text()
    assert hashlib.sha256(source.encode()).hexdigest() == EXPECTED
    spec = importlib.util.spec_from_file_location('pow2_prepare', HERE.parent / '20261016_pow2/prepare.py')
    helper = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(helper)
    offsets = [0]
    for line in source.splitlines(keepends=True):
        offsets.append(offsets[-1] + len(line))
    functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    for name in ['baseline.py', 'control.py']:
        write_new(HERE / name, source)
    records = []
    for label, names in GROUPS.items():
        edits = []
        for name in names:
            for node in ast.walk(functions[name]):
                if not isinstance(node, ast.Call):
                    continue
                replacement = helper.replacement(node, True)
                if replacement is not None:
                    edits.append((offsets[node.lineno - 1] + node.col_offset,
                                  offsets[node.end_lineno - 1] + node.end_col_offset, replacement))
        result = source
        for begin, end, replacement in sorted(edits, reverse=True):
            result = result[:begin] + replacement + result[end:]
        after = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
        assert {n for n in functions if ast.dump(functions[n]) != ast.dump(after[n])} == set(names)
        compile(result, label, 'exec')
        write_new(HERE / (label + '.py'), result)
        records.append(dict(file=label + '.py', changed_functions=names,
                            sha256=hashlib.sha256(result.encode()).hexdigest()))
    cases = json.loads((HERE.parent / '20261008_goal895/oj_cases.json').read_text())
    for b, t, d in [(1, 32, 32), (1, 48, 32), (1, 64, 32), (2, 32, 32),
                    (1, 64, 64), (1, 96, 64), (1, 128, 64), (2, 64, 64),
                    (1, 32, 128), (1, 64, 128)]:
        for causal in [True, False]:
            cases[f'small_b{b}_t{t}_d{d}_c{int(causal)}'] = dict(
                B=b, SEQ_LEN=t, H=1, HQ=16, D=d, S=1, block_size=16, is_causal=causal)
    for s, configs in [(2, [(1,64),(1,128),(1,192),(1,256),(1,320),(1,384),(1,512),(1,1024),(2,128),(2,256),(4,256)]),
                       (4, [(1,128),(1,256),(1,512),(1,768),(1,1024),(2,128),(2,256),(2,512),(4,256)])]:
        for b, t in configs:
            for causal in [True, False]:
                cases[f's{s}_b{b}_t{t}_c{int(causal)}'] = dict(
                    B=b, SEQ_LEN=t, H=1, HQ=16, D=64, S=s, block_size=16, is_causal=causal)
    for b, t, h in [(1,4096,1),(2,2048,1),(4,1024,1),(8,512,1),(8,1024,1),(2,1024,2),(4,512,2)]:
        for causal in [True, False]:
            cases[f'packed_b{b}_t{t}_h{h}_c{int(causal)}'] = dict(
                B=b, SEQ_LEN=t, H=h, HQ=h*16, D=128, S=1, block_size=32, is_causal=causal)
    write_new(HERE / 'cases.json', json.dumps(cases, indent=2) + '\n')
    write_new(HERE / 'manifest.json', json.dumps(dict(parent=str(PARENT), parent_sha256=EXPECTED,
              variants=records, status='research probes, not a release'), indent=2) + '\n')
    print('Generated', len(records), 'isolated probes and', len(cases), 'cases')


if __name__ == '__main__':
    main()
