"""Prepare a candidate containing only the stable existing D32 math change."""
import ast
import hashlib
import json
from pathlib import Path
import shutil

HERE = Path(__file__).resolve().parent
CHANGED = 'native_sparse_attention_q_preload_vfirst'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parent, candidate = HERE / 'baseline.py', HERE / 'pow2_d32.py'
    assert sha(parent) == 'fb6b0fb5df10bc497841e9a0da922a0062f84689088c9503bc526aef71b9a976'
    before = {n.name:n for n in ast.parse(parent.read_text()).body if isinstance(n,ast.FunctionDef)}
    after = {n.name:n for n in ast.parse(candidate.read_text()).body if isinstance(n,ast.FunctionDef)}
    assert before.keys() == after.keys()
    assert {n for n in before if ast.dump(before[n]) != ast.dump(after[n])} == {CHANGED}
    assert ast.dump(before['_get_kernel']) == ast.dump(after['_get_kernel'])
    assert sum(isinstance(n,ast.Call) and ast.unparse(n.func)=='T.pow' for n in ast.walk(after[CHANGED])) == 4
    output = HERE / 'candidate_v17.py'
    with output.open('x') as stream:
        stream.write(candidate.read_text())
    shutil.copy2(HERE.parent / '20261016_rsqrt/candidate_cases.json', HERE / 'candidate_cases.json')
    validation = (HERE.parent / '20261016_rsqrt/verify_candidate.py').read_text()
    validation = validation.replace('Validate the changed D32 path against independent attention references.',
                                    'Validate the v17 D32 exponent expression against independent FP32 references.')
    with (HERE / 'verify_v17.py').open('x') as stream:
        stream.write(validation)
    report = dict(parent_sha256=sha(parent), candidate_sha256=sha(output),
                  changed_functions=[CHANGED], new_functions=[],
                  unchanged_original_functions=len(before)-1,
                  public_and_dispatch_ast_unchanged=True,
                  scope='Existing default D32 Q-preload-vfirst builder only; no new shape predicate.',
                  change='Natural exponent / exp2 expressions become public T.pow(2, exponent); same cap and positive/zero/negative-scale masks. FP32 MMA and v16 rsqrt reciprocal retained.',
                  rejected='S2, S4, large S1, BS32, and S8 pow expressions are excluded.',
                  status='candidate requiring validation', official_candidate_score=None)
    with (HERE / 'candidate_manifest.json').open('x') as stream:
        json.dump(report,stream,indent=2);stream.write('\n')
    print(report)


if __name__ == '__main__':
    main()
