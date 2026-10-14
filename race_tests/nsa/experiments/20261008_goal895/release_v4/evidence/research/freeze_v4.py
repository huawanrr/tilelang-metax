"""Freeze verified v4 and its evidence; never overwrite an existing release."""
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import shutil

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
EXPECTED = {
    'experiments/20261007_exp_math/release_v1/nsa.py': 'd6ef68ec0422c388148bc226a0f7c216f3cb8fb25a74a544a3a6847f3220e246',
    'experiments/20261007_exp_math/release_v1/submission.py': 'c498c5202367c17ebf1b9d82aff60e000277b2e534f3014dee631be37cdc70ff',
    'experiments/20261008_goal895/candidate_v4.py': '06d69bab6089e3ac11f9cca58804b9ccdc505e2913f019a5ee31b85f811b67fc',
    'experiments/20261008_goal895/candidate_v4_submission.py': '6f1922f56d5bc372262eca5e3b54630b9ef6a2de23c082606aacec94b2010e02',
}


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def read(name):
    return json.loads((HERE / name).read_text())


def main():
    for name, value in EXPECTED.items():
        assert digest(ROOT / name) == value, name
    reference = read('candidate_v4_reference.json')
    assert len(reference) == 125 and all(r['status'] == 'PASS' for r in reference)
    extra = read('candidate_v4_extra.json')
    counts = dict(boundaries=55, extreme_scales=45, tuning=102, cache_order=6,
                  live_inputs=36, restricted_host=8)
    assert extra['status'] == 'PASS' and all(len(extra[k]) == n for k, n in counts.items())
    assert extra['source_sha256'] == EXPECTED['experiments/20261008_goal895/candidate_v4_submission.py']
    layouts = read('candidate_v4_layout_proofs.json')
    assert layouts['status'] == 'PASS' and len(layouts['scalar_maps']) == 12
    audit = read('candidate_v4_audit.json')
    assert audit['status'] == 'PASS' and len(audit['configurations']) == 110 and len(audit['timings']) == 137
    assert len(audit['static']['unchanged_original_functions']) == 49
    components = read('candidate_v4_components.json')
    assert components['status'] == 'PASS' and len(components['rows']) == 218
    assert components['unique_configurations'] == 105
    performance = read('candidate_v4_performance_summary.json')
    assert performance['full']['all']['candidate_accepted']['count'] == 109
    assert performance['oj']['all']['candidate_accepted']['count'] == 28
    assert len(performance['cold']['rows']) == 14
    assert performance['official_candidate_score'] is None
    for name in ('full', 'oj', 'cold'):
        result = performance[name]
        assert digest(ROOT / result['source']) == result['source_sha256']
    assert (HERE / 'candidate_v4_static.log').read_text().count(' PASS') == 2

    # Keep the prior harness dependency chain, then add the current drivers and
    # sources checked by audit_components. These hashes describe this snapshot.
    previous = ROOT / 'experiments/20261007_exp_math/release_v1/REPRO_DEPENDENCIES.sha256'
    dependencies = {line.split('  ', 1)[1] for line in previous.read_text().splitlines()}
    dependencies.update(EXPECTED)
    dependencies.update(str((HERE / name).relative_to(ROOT)) for name in (
        'baseline.py', 'baseline_submission.py', 'verify_candidate.py', 'layout_proofs.py',
        'profile_cold.py', 'audit_candidate.py', 'audit_components.py', 'summarize_candidate.py'))
    for name in ('candidate_v2_family_screen.json', 's4_pipeline_family.json', 'single_math_mid_family.json'):
        dependencies.add(str((HERE / name).relative_to(ROOT)))
        dependencies.update(read(name)['sha256'])
    dependency_hashes = {name: digest(ROOT / name) for name in sorted(dependencies)}

    release = HERE / 'release_v4'
    assert not release.exists(), 'A frozen release must not be overwritten'
    release.mkdir()
    for source, target in {'candidate_v4.py': 'nsa.py', 'candidate_v4_submission.py': 'submission.py',
            'README_v4.md': 'README.md', 'release_commands.sh': 'commands.sh',
            'candidate_v4_performance_summary.json': 'performance_summary.json'}.items():
        shutil.copy2(HERE / source, release / target)
    evidence = release / 'evidence/research'
    evidence.mkdir(parents=True)
    # New wide-load probes are still independent research after v4 was frozen.
    # Leave them in the working research directory instead of copying live logs.
    excluded_prefixes = ('wide_load_', 'make_wide_load_', 'make_explicit_load_')
    for source in sorted(HERE.iterdir()):
        if source.is_file() and not source.name.startswith(excluded_prefixes):
            if source.suffix in ('.py', '.json', '.log', '.md', '.sh', '.cpp', '.ll'):
                shutil.copy2(source, evidence / source.name)
    shutil.copytree(HERE / 'recip_cpu', evidence / 'recip_cpu', ignore=shutil.ignore_patterns('__pycache__'))
    for name in dependencies:
        target = release / 'evidence/dependencies' / name.replace('../', 'parent/')
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(ROOT / name, target)
    (release / 'REPRO_DEPENDENCIES.sha256').write_text(
        ''.join(f'{value}  {name}\n' for name, value in dependency_hashes.items()))
    files = {str(p.relative_to(release)): digest(p) for p in sorted(release.rglob('*')) if p.is_file()}
    manifest = dict(created_at_utc=datetime.now(timezone.utc).isoformat(), candidate_version='v4',
        official_baseline_display_mean=88.57142857142857, target_score=89.5,
        official_candidate_score=None, official_target_confirmed=False,
        preserved_and_verified_sources=EXPECTED,
        source=dict(development=files['nsa.py'], submission=files['submission.py']),
        verification=dict(reference_cases=125, extra=counts, scalar_maps=12,
            audited_timing_records=137, audited_configurations=110,
            component_timing_records=218, component_configurations=105,
            original_functions_unchanged=49),
        excluded_research_prefixes=list(excluded_prefixes),
        repository_dependencies=dependency_hashes, files=files)
    (release / 'release_manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    all_files = {str(p.relative_to(release)): digest(p) for p in sorted(release.rglob('*')) if p.is_file()}
    (release / 'SHA256SUMS').write_text(''.join(f'{value}  {name}\n' for name, value in all_files.items()))
    for name, value in EXPECTED.items():
        assert digest(ROOT / name) == value
    print(release)
    print('archived files', len(all_files), 'submission SHA256', files['submission.py'])


if __name__ == '__main__':
    main()
