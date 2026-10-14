"""Record the bounded screening round; never alter submission sources."""
import hashlib
import json
from pathlib import Path

folder = Path(__file__).resolve().parent
root = folder.parents[1]
expected = {
    'nsa.py': 'b130372b331e04cec85e6ad005ca239038adbb7f2c1fb5ce55b745b720c814fa',
    'submission.py': 'a588a9f4f23f93c076c37ebecf88577619f5ffbee03278fc5875253b06b016cd',
    'experiments/20260927_next/selected.py': '311e64a25b16471d2689049070303e6400bc0f593e184615222839e1a77b3a26',
    'experiments/20260927_next/submission.py': '8733abd64b1f72e0a098d2412a1d3a0db8b5ec03d899408d0ec15b2f6c9f3cc0',
}
for name, digest in expected.items():
    assert hashlib.sha256((root / name).read_bytes()).hexdigest() == digest, name
assert (folder / 'baseline.py').read_bytes() == (root / 'experiments/20260927_next/selected.py').read_bytes()
experiments = []
candidate_checks = 0
for stem in ('pack', 'pack_tiles', 'packed_schedule', 'qk_overlap', 'prefetch_deeper'):
    report = json.loads((folder / (stem + '.json')).read_text())
    source_hashes = report['source_sha256']
    for name, digest in source_hashes.items():
        assert hashlib.sha256((root / name).read_bytes()).hexdigest() == digest, name
    assert len(report['rows']) == 3 and report['rounds'] == 4
    candidate_checks += (len(source_hashes) - 1) * len(report['rows'])
    experiments.append(dict(report=stem+'.json', source_sha256=source_hashes,
        geomean_speedups=report['geomean_speedups'], decision='retain baseline'))

markers = ('maca_async_copy', 'memcpy_async', 'cp.async', 'cp_async',
           'tma_load', 'tma_store', 'mbarrier', 'TL_DISABLE_DATA_RACE_CHECK')
dumps = sorted(folder.glob('*.cpp'))
for path in dumps:
    source = path.read_text()
    for marker in markers:
        assert marker not in source, (path.name, marker)

manifest = dict(date='2026-09-28', decision='retain baseline; no new submission',
    selected_source='experiments/20260927_next/selected.py',
    oj_sources_unchanged=expected, experiments=experiments,
    candidate_shape_checks=candidate_checks, candidate_count=15,
    correctness_scope='three causal S8 shapes per candidate, unchanged float32 reference',
    static_submission_check='baseline plus all 15 candidates PASS',
    generated_source_dumps_checked=len(dumps), forbidden_markers=list(markers),
    official_oj_result='pending; last reported 86.5; 87 not yet established',
    limitations=['No full-suite, boundary or RestrictedPython test of rejected probes.',
                'CUDA graph timings exclude compilation/allocation, include packing.',
                'Local timing does not determine an OJ score.'])
(folder / 'manifest.json').write_text(json.dumps(manifest, indent=2)+'\n')
print(f'PASS: 15 probes, {candidate_checks} focused correctness checks, {len(dumps)} source scans; OJ files unchanged')
