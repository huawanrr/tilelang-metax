"""Record reproducible screening evidence without promoting noisy candidates."""
import ast
import hashlib
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
reports = ['screen', 'packed_waves', 'shared_repack', 'pv_tiles', 'packed_pair', 'pv_late', 'qk_acc']
sources = {HERE / 'baseline.py'}
checks = []
report_summary = {}
for name in reports:
    data = json.loads((HERE / f'{name}.json').read_text())
    paths = list(data['source_sha256'])
    for path, expected in data['source_sha256'].items():
        source = ROOT / path
        assert hashlib.sha256(source.read_bytes()).hexdigest() == expected, path
        sources.add(source)
    for row in data['rows']:
        for path, error in zip(paths, row['max_abs_error']):
            assert error <= 1e-2, (name, row['case'], path, error)
            checks.append(dict(report=name, case=row['case'], module=path, max_abs_error=error))
    report_summary[name] = dict(geomean_speedups=data['geomean_speedups'], cases=len(data['rows']))

source_list = sorted(sources)
host_functions = {'_make_packed_attention', '_get_kernel', '_as_int32',
                  'native_sparse_attention', 'run_kernel'}
def host_ast(path):
    return {node.name: ast.dump(node, include_attributes=False)
            for node in ast.parse(path.read_text()).body
            if isinstance(node, ast.FunctionDef) and node.name in host_functions}
host_baseline = host_ast(HERE / 'baseline.py')
assert set(host_baseline) == host_functions
for source in source_list:
    assert host_ast(source) == host_baseline, source

bracketed = {}
for name in ('pv_bracketed', 'pv_confirm'):
    data = json.loads((HERE / f'{name}.json').read_text())
    for path, expected in data['sha256'].items():
        assert hashlib.sha256((ROOT / path).read_bytes()).hexdigest() == expected
    for row in data['rows']:
        assert max(row['max_abs_error']) <= 1e-2
    bracketed[name] = [dict(case=row['case'], summaries=row['summaries']) for row in data['rows']]
check = subprocess.run([sys.executable, str(ROOT / 'check_submission_nsa.py'), *map(str, source_list)],
                       text=True, capture_output=True)
(HERE / 'static_checks.log').write_text(check.stdout + check.stderr)
assert check.returncode == 0, check.stdout + check.stderr

generated = {}
for path in sorted(HERE.glob('*.cpp')):
    source = path.read_text()
    for marker in ('memcpy_async', 'cp.async', 'maca_async', 'barrier_arrive_and_wait'):
        assert marker not in source, (path.name, marker)
    generated[path.name] = hashlib.sha256(source.encode()).hexdigest()

# The experimental shared V store composes a packed permutation with the
# inverse of K's shared swizzle. Prove unique destinations and exact recovery.
maps = []
for bs in (16, 32, 64):
    for dim in (32, 64, 128):
        per_phase = max(1, 64 // dim)
        max_phase = min(16 // per_phase, dim // 8)
        destinations = set()
        for j in range(bs):
            for d in range(dim):
                pos = (j // 16 * (dim // 32) * 512 + d // 32 * 512
                       + ((j % 16 // 4) * 16 + d % 16) * 8
                       + (d % 32 // 16) * 4 + j % 4)
                row = pos // dim
                col = ((pos % dim // 8) ^ (row // per_phase % max_phase)) * 8 + pos % 8
                assert 0 <= row < bs and 0 <= col < dim
                physical = row * dim + ((col // 8) ^ (row // per_phase % max_phase)) * 8 + col % 8
                assert physical == pos
                destinations.add((row, col))
        assert len(destinations) == bs * dim
        maps.append(dict(block_size=bs, dim=dim, unique_elements=len(destinations)))

protected = {
    'nsa.py': 'b130372b331e04cec85e6ad005ca239038adbb7f2c1fb5ce55b745b720c814fa',
    'submission.py': 'a588a9f4f23f93c076c37ebecf88577619f5ffbee03278fc5875253b06b016cd',
    'experiments/20260927_next/selected.py': '311e64a25b16471d2689049070303e6400bc0f593e184615222839e1a77b3a26',
    'experiments/20260927_next/submission.py': '8733abd64b1f72e0a098d2412a1d3a0db8b5ec03d899408d0ec15b2f6c9f3cc0',
}
for path, expected in protected.items():
    assert hashlib.sha256((ROOT / path).read_bytes()).hexdigest() == expected, path

manifest = dict(decision='retain existing sources; no new submission',
    candidate_count=len(sources) - 1, focused_reference_checks=checks,
    report_summary=report_summary,
    source_sha256={str(x.relative_to(ROOT)): hashlib.sha256(x.read_bytes()).hexdigest() for x in source_list},
    generated_source_sha256=generated, shared_repack_maps=maps,
    bracketed_results=bracketed, host_functions_ast_unchanged=True,
    protected_sources_unchanged=protected,
    measurement_limit='Other GPU slices were active. Raw A/B/A timing and same-source control are retained; small ratios do not establish a stable gain.',
    official_oj_run=False, full_suite_repeated=False)
(HERE / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
print(f'PASS: {len(sources) - 1} candidates, {len(checks)} focused reference checks including controls, '
      f'{len(generated)} source scans, 9 shared maps; existing submissions unchanged')
