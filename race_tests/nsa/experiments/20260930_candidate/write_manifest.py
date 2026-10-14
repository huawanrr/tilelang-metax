"""Record release evidence only after all required local checks pass."""
import ast
import hashlib
import json
import math
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(name):
    return json.loads((HERE / name).read_text())


def main():
    full = read('v2_full.json')
    families = read('v2_family_summary.json')
    bracket = read('v2_bracketed.json')
    verification = read('verification.json')
    release = read('release_checks.json')
    source_audit = read('v2_device_audit.json')
    assert len(full['rows']) == 109 and len(verification) == 125
    assert all(row['status'] == 'PASS' for row in verification)
    assert release['status'] == families['status'] == source_audit['status'] == 'PASS'
    assert len(release['boundaries']) == len(release['sources']) == 64
    assert len(release['explicit_fallbacks']) == 18
    assert len(release['refresh']) == 24 and len(release['guarded']) == 10
    assert (HERE / 'equivalence.log').read_text().rstrip().endswith('ALL EQUIVALENT')
    assert all(line.endswith(' PASS') for line in (HERE / 'static_checks.log').read_text().splitlines())
    assert len((HERE / 'static_checks.log').read_text().splitlines()) == 2
    assert (HERE / 'nsa.py').read_bytes() == (HERE / 'candidate_v2.py').read_bytes()
    for path, expected in full['source_sha256'].items():
        assert digest(ROOT / path) == expected, path
    for path, expected in read('candidate_v2.build.json')['source_sha256'].items():
        assert digest(ROOT / path) == expected, path
    for path, expected in release['source_sha256'].items():
        assert digest(Path(path)) == expected, path

    baseline = json.loads((ROOT / 'experiments/20260930_tuning/baseline_manifest.json').read_text())
    for path, expected in baseline['sha256'].items():
        assert digest(ROOT / path) == expected, path
    old = {node.name: ast.dump(node, include_attributes=False)
           for node in ast.parse((ROOT / 'experiments/20260929_candidate/nsa.py').read_text()).body
           if isinstance(node, ast.FunctionDef)}
    new = {node.name: ast.dump(node, include_attributes=False)
           for node in ast.parse((HERE / 'nsa.py').read_text()).body if isinstance(node, ast.FunctionDef)}
    assert all(new[name] == code for name, code in old.items() if name != '_get_kernel')
    forbidden = ('memcpy_async', 'cp.async', 'maca_async', 'tma_load', 'mbarrier')
    device_paths = sorted(HERE.glob('candidate_v2_*.cpp')) + sorted(HERE.glob('release_boundary_*.cpp'))
    assert len(device_paths) == 173
    for path in device_paths:
        assert not any(token in path.read_text() for token in forbidden), path
    for name in ('nsa.py', 'submission.py'):
        source = (HERE / name).read_text()
        assert 'TL_DISABLE_DATA_RACE_CHECK' not in source
        assert 'TL_DISABLE_SAFE_MEMORY_ACCESS' not in source

    gm = full['geomean_speedups'][1]
    controls = [row['summaries'][0] for row in bracket['rows']]
    candidates = [row['summaries'][1] for row in bracket['rows']]
    groups = {}
    for unchanged in (False, True):
        ids = {r['case'] for r in source_audit['cases'] if r['unchanged'] == unchanged}
        ratios = [r['speedups'][1] for r in full['rows'] if r['case'] in ids]
        groups['unchanged' if unchanged else 'changed'] = dict(
            cases=len(ratios), geomean_speedup=math.exp(statistics.mean(map(math.log, ratios))))
    evidence = [
        'candidate_v2.build.json', 'v2_full.json', 'v2_full.log',
        'v2_families.json', 'v2_families.log', 'v2_families_rest.json', 'v2_families_rest.log',
        'v2_family_summary.json', 'v2_bracketed.json', 'v2_bracketed.log', 'v2_device_audit.json',
        'verification.json', 'verification.log', 'release_checks.json', 'release_checks.log',
        'equivalence.log', 'static_checks.log', 'verify_candidate.py',
    ]
    proof_path = ROOT / 'experiments/20260930_tuning/sync_layout_proof.json'
    proof = json.loads(proof_path.read_text())
    assert proof['status'] == 'PASS' and 'shared_q_reuse' in proof['synchronization']
    manifest = dict(
        date='2026-09-30', status='locally_verified_candidate',
        user_reported_baseline_score=87.93, target_score=88.5,
        baseline_source='experiments/20260929_candidate/submission.py',
        baseline_oj_source_identity_confirmed=False, official_score=None,
        target_confirmed=False, official_sandbox_available=False,
        release_sha256={name: digest(HERE / name) for name in ('nsa.py', 'submission.py')},
        baseline_sha256=baseline['sha256'], original_functions_except_dispatch_unchanged=True,
        benchmark=dict(
            full_cases=109, geomean_speedup=gm, geomean_time_reduction=1 - 1 / gm,
            minimum_speedup=min(row['speedups'][1] for row in full['rows']),
            source_groups=groups, family_cases=33,
            family_minimum_speedup=min(row['speedups'][1] for row in families['rows']),
            bracket_cases=15, attempts_per_case=40, calls_per_graph=500,
            candidate_low_drift_samples=sum(row['accepted'] for row in candidates),
            control_low_drift_samples=sum(row['accepted'] for row in controls),
            trials_per_variant=600, maximum_accepted_baseline_drift=0.01,
            control_speedup_range=[min(r['median_speedup'] for r in controls),
                                   max(r['median_speedup'] for r in controls)],
            minimum_bracket_candidate_speedup=min(row['median_speedup'] for row in candidates),
            representative_rows=[{key: row[key] for key in ('case', 'config', 'summaries')}
                for row in bracket['rows'] if row['case'] in ('oj6', '28', '74', '77')],
            method=full['backend'], torch=full['torch'], device=full['device']),
        validation=dict(
            reference_cases=125, both_interfaces=True,
            boundary_cases=64, boundary_source_comparisons=64,
            standard_device_equivalence_cases=18, explicit_knob_fallbacks=18,
            live_input_refreshes=24, restrictedpython_host_cases=10,
            generated_device_sources_scanned=len(device_paths),
            scanned_async_markers=list(forbidden),
            maximum_reference_error=max(row['max_abs_error'] for row in verification),
            maximum_boundary_error=max(row['max_abs_error'] for row in release['boundaries']),
            shared_layout_bijections=len(proof['shared_layouts']),
            pv_coverage_checks=len(proof['pv_coverage']),
            joined_position_mask_families=len(proof['joined_blocks'])),
        constraints=dict(async_copy=False, external_device_source=False, backend_changes=False,
            input_output_cache=False, classes=False, function_attribute_writes=False,
            race_checker_disabled=False, bounds_checker_disabled=False,
            explicit_sync='One 64-lane CTA per MACA wave; preserve every shared RAW/WAR barrier. Automatic sync insertion disabled only on explicit-sync builders.'),
        evidence_sha256={name: digest(HERE / name) for name in evidence},
        synchronization_proof=dict(path=str(proof_path.relative_to(ROOT)), sha256=digest(proof_path)),
        generated_source_sha256={path.name: digest(path) for path in device_paths},
    )
    (HERE / 'release_manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print('PASS: release manifest; local geomean', gm, '; official target remains unconfirmed')
    print(json.dumps(manifest['release_sha256'], indent=2))


if __name__ == '__main__':
    main()
