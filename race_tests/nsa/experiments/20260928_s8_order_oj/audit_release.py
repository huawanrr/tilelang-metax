"""Audit the validated S8 schedule trial and preserve source identities."""
import ast
import hashlib
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sha = lambda p: hashlib.sha256(p.read_bytes()).hexdigest()
full = json.loads((HERE / 'verification.json').read_text())
checks = json.loads((HERE / 'trial_checks.json').read_text())
assert len(full) == 125 and all(r['status'] == 'PASS' for r in full)
assert checks['status'] == 'PASS'
assert [len(checks[k]) for k in ('boundaries', 'sources', 'refresh', 'guarded')] == [26, 26, 6, 4]
assert 'ALL EQUIVALENT' in (HERE / 'equivalence.log').read_text()
dev, sub = HERE / 'nsa.py', HERE / 'submission.py'
result = subprocess.run([sys.executable, str(ROOT / 'check_submission_nsa.py'), str(dev), str(sub)],
                        text=True, capture_output=True)
(HERE / 'static_checks.log').write_text(result.stdout + result.stderr)
assert result.returncode == 0, result.stdout + result.stderr
base = ROOT / 'experiments/20260927_next/selected.py'
nodes = lambda p: {n.name: ast.dump(n, include_attributes=False) for n in ast.parse(p.read_text()).body
                   if isinstance(n, ast.FunctionDef)}
baseline_nodes, trial_nodes = nodes(base), nodes(dev)
assert set(trial_nodes) - set(baseline_nodes) == {
    'native_sparse_attention_online_packed_batch_minor',
    'native_sparse_attention_online_packed_quad_batch_minor',
}
assert [k for k in baseline_nodes if baseline_nodes[k] != trial_nodes[k]] == ['_get_kernel']
protected = json.loads((ROOT / 'experiments/20260928_bucket_sync/screening_manifest.json').read_text())['protected_sources_unchanged']
for path, expected in protected.items():
    assert sha(ROOT / path) == expected, path
timing = json.loads((ROOT / 'experiments/20260928_grid_order/long_bracketed.json').read_text())
evidence = {}
for row in timing['rows']:
    chosen = 2 if row['case'] == 'g8_b8' else 1
    evidence[row['case']] = dict(control=row['summaries'][0], selected=row['summaries'][chosen])
manifest = dict(status='validated OJ trial; official result pending', goal_score=88,
    official_oj_score=None, official_sandbox=False,
    source_sha256={str(p.relative_to(ROOT)): sha(p) for p in (dev, sub, base)},
    validation_counts=dict(reference=125, boundaries=26, boundary_source_comparisons=26,
                           input_refreshes=6, guarded_host=4, dev_submission_equivalence=18),
    max_abs_error=max([r['max_abs_error'] for r in full] +
        [r['max_abs_error'] for key in ('boundaries', 'refresh', 'guarded') for r in checks[key]]),
    unchanged_original_functions=[k for k in baseline_nodes if k != '_get_kernel'],
    protected_sources_unchanged=protected,
    dispatch='S8/D64/BS16/G16/threads64: grid>=4096 batch-major grid dimension moved to x; grid>=8192 four PV accumulators',
    timing_evidence='../20260928_grid_order/long_bracketed.json',
    timing_summaries=evidence)
(HERE / 'release_manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
print(json.dumps(manifest['source_sha256'], indent=2))
print('PASS: S8 OJ trial audited; original sources and PV32 trial unchanged')
