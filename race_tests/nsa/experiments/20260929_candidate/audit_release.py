"""Collect reproducible release evidence and verify the frozen comparisons."""
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


def main():
    benchmark = json.loads((HERE / 'full_v2.json').read_text())
    rows = benchmark['rows']
    assert len(rows) == 109
    assert (HERE / 'nsa.py').read_bytes() == (HERE / 'candidate_v2.py').read_bytes()
    assert digest(HERE / 'nsa.py') == benchmark['source_sha256']['experiments/20260929_candidate/candidate_v2.py']
    assert max(max(row['max_abs_error']) for row in rows) <= 1e-2
    assert not [row for row in rows if row['us'][2] > row['us'][1] * 1.03]
    verification = json.loads((HERE / 'verification.json').read_text())
    assert len(verification) == 125 and all(row['status'] == 'PASS' for row in verification)
    extra = json.loads((HERE / 'trial_checks.json').read_text())
    assert extra['status'] == 'PASS' and extra['official_sandbox'] is False
    assert len(extra['boundaries']) == 49 and len(extra['sources']) == 49
    assert len(extra['refresh']) == 12 and len(extra['guarded']) == 6
    assert len(extra['explicit_fallbacks']) == 4
    assert 'ALL EQUIVALENT' in (HERE / 'equivalence.log').read_text()
    assert (HERE / 'equivalence.log').read_text().count(': EQUIVALENT') == 18
    assert (HERE / 'static_checks.log').read_text().count(' PASS') == 2
    layout_proof = json.loads((HERE / 'layout_proof.json').read_text())
    assert layout_proof['status'] == 'PASS' and layout_proof['race_checks_disabled'] is False
    base = ast.parse((ROOT / 'experiments/20260928_s8_order_oj/nsa.py').read_text())
    candidate = ast.parse((HERE / 'nsa.py').read_text())
    functions = {n.name: n for n in candidate.body if isinstance(n, ast.FunctionDef)}
    preserved = []
    for node in base.body:
        if isinstance(node, ast.FunctionDef) and any('tilelang.jit' in ast.unparse(d) for d in node.decorator_list):
            assert ast.dump(node, include_attributes=False) == ast.dump(functions[node.name], include_attributes=False)
            preserved.append(node.name)
    expected_frozen = {
        'nsa.py': 'b130372b331e04cec85e6ad005ca239038adbb7f2c1fb5ce55b745b720c814fa',
        'submission.py': 'a588a9f4f23f93c076c37ebecf88577619f5ffbee03278fc5875253b06b016cd',
        'experiments/20260927_next/selected.py': '311e64a25b16471d2689049070303e6400bc0f593e184615222839e1a77b3a26',
        'experiments/20260927_next/submission.py': '8733abd64b1f72e0a098d2412a1d3a0db8b5ec03d899408d0ec15b2f6c9f3cc0',
    }
    for path, expected in expected_frozen.items():
        assert digest(ROOT / path) == expected, path
    frozen = {path: digest(ROOT / path) for path in expected_frozen}
    for path in ('experiments/20260928_pv32_oj/submission.py', 'experiments/20260928_s8_order_oj/submission.py'):
        frozen[path] = digest(ROOT / path)
    checks = ['nsa.py', 'submission.py', 'full_v2.json', 'verification.json', 'trial_checks.json',
              'equivalence.log', 'static_checks.log', 'layout_proof.json', 'make_candidate.py',
              'verify_candidate.py', 'check_layouts.py', 'README.md']
    report = dict(
        date='2026-09-29', target_oj_score=88, latest_known_oj_score=86.5,
        official_score=None, official_sandbox_tested=False,
        artifacts={str((HERE / path).relative_to(ROOT)): digest(HERE / path) for path in checks},
        performance=dict(cases=109,
            method=benchmark['backend'], rounds=benchmark['rounds'],
            geometric_speedup_vs_86_5=math.exp(statistics.mean(math.log(r['us'][0] / r['us'][2]) for r in rows)),
            geometric_speedup_vs_next=math.exp(statistics.mean(math.log(r['us'][1] / r['us'][2]) for r in rows)),
            regressions_over_3_percent_vs_next=[],
            candidate_max_abs_error=max(r['max_abs_error'][2] for r in rows),
            max_abs_error_all_versions=max(max(r['max_abs_error']) for r in rows)),
        verification=dict(reference_cases=125, boundaries=49, both_interfaces=True,
            boundary_source_equivalence=49, routine_source_equivalence=18, explicit_schedule_fallbacks=4,
            input_refreshes=12, restricted_host_cases=6, shared_layout_bijections=9,
            shuffle_values_exactly_verified=512, race_checks_disabled=False),
        preserved_gpu_builders=preserved, frozen_releases=frozen,
        bracketed_evidence=['experiments/20260929_recheck/d32_bracketed.json',
                            'experiments/20260929_recheck/shared_q_bracketed.json'],
    )
    (HERE / 'release_manifest.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report, indent=2))


if __name__ == '__main__':
    main()
