"""Freeze the tested OJ trial's identity and the exact scope of its evidence."""
import ast
import hashlib
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sha = lambda path: hashlib.sha256(path.read_bytes()).hexdigest()
full = json.loads((HERE / 'verification.json').read_text())
checks = json.loads((HERE / 'trial_checks.json').read_text())
assert len(full) == 125 and all(x['status'] == 'PASS' for x in full)
assert checks['status'] == 'PASS'
assert [len(checks[k]) for k in ('boundaries', 'sources', 'refresh', 'guarded')] == [18, 20, 6, 4]
assert 'ALL EQUIVALENT' in (HERE / 'equivalence.log').read_text()
dev, sub = HERE / 'nsa.py', HERE / 'submission.py'
result = subprocess.run([sys.executable, str(ROOT / 'check_submission_nsa.py'), str(dev), str(sub)],
                        text=True, capture_output=True)
(HERE / 'static_checks.log').write_text(result.stdout + result.stderr)
assert result.returncode == 0, result.stdout + result.stderr
base = ROOT / 'experiments/20260927_next/selected.py'
baseline_nodes = {n.name: ast.dump(n, include_attributes=False) for n in ast.parse(base.read_text()).body
                  if isinstance(n, ast.FunctionDef)}
trial_nodes = {n.name: ast.dump(n, include_attributes=False) for n in ast.parse(dev.read_text()).body
               if isinstance(n, ast.FunctionDef)}
assert set(trial_nodes) - set(baseline_nodes) == {'native_sparse_attention_single_block_pv32'}
assert [k for k in baseline_nodes if baseline_nodes[k] != trial_nodes[k]] == ['_get_kernel']
protected = json.loads((ROOT / 'experiments/20260928_output_split/manifest.json').read_text())['protected_sources_unchanged']
for path, expected in protected.items():
    assert sha(ROOT / path) == expected, path
manifest = dict(status='validated OJ experiment; performance pending', goal_score=88,
    official_oj_score=None, official_sandbox=False,
    source_sha256={str(p.relative_to(ROOT)): sha(p) for p in (dev, sub, base)},
    validation_counts=dict(reference=125, boundaries=18, input_refreshes=6, guarded_host=4,
                           boundary_source_comparisons=20, dev_submission_equivalence=18),
    max_abs_error=max([r['max_abs_error'] for r in full] +
                      [r['max_abs_error'] for key in ('boundaries', 'refresh', 'guarded') for r in checks[key]]),
    unchanged_original_functions=[k for k in baseline_nodes if k != '_get_kernel'],
    protected_sources_unchanged=protected,
    experiment='same-CTA PV32 tiles; early normalization; S1/D128/BS32/G16/grid>=4096',
    timing_evidence='../20260928_output_split/pv_confirm.json')
(HERE / 'release_manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
print(json.dumps(manifest['source_sha256'], indent=2))
print('PASS: OJ trial frozen, original submissions unchanged')
