"""Match release device code to the actual full run and validated family probes."""
import argparse
import hashlib
import json
from pathlib import Path

from verify_candidate import ROOT, cfg, selected, helpers, guarded_module, adversarial_indices
from experiment_bench import load_module
from verify_nsa import check_case
import torch


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def compiled(module, case):
    c = case
    kernel = module._get_kernel(c['B'], c['SEQ_LEN'], c['H'], c['HQ'], c['D'],
        c['S'], c['block_size'], c['is_causal'], 0.1)
    return dict(device_source_sha256=[hashlib.sha256(p.get_kernel_source().encode()).hexdigest()
                                      for p in helpers.parts(kernel)],
                compile_flags=helpers.flags(kernel))


def checked_report(path):
    report = json.loads(Path(path).read_text())
    for source, expected in report['sha256'].items():
        assert digest(ROOT / source) == expected, source
    return report


@torch.no_grad()
def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--dev', required=True)
    p.add_argument('--submission', required=True)
    p.add_argument('--assembly', required=True)
    p.add_argument('--full', required=True)
    p.add_argument('--checks', required=True)
    p.add_argument('--output', required=True)
    a = p.parse_args()
    torch.backends.cuda.matmul.allow_tf32 = False
    dev, sub = load_module(a.dev), load_module(a.submission)
    baseline_path = ROOT / 'experiments/20261002_mid_v1/submission.py'
    baseline = load_module(str(baseline_path))
    config = json.loads(Path(a.assembly).read_text())
    full = checked_report(a.full)
    full_paths = list(full['sha256'])
    sub_index = next(i for i, path in enumerate(full_paths)
                     if Path(path).resolve() == Path(a.submission).resolve())
    assert len(full['rows']) == 109
    report = dict(status='running', full=[], families=[], guarded=[],
        source_sha256={str(path): digest(path) for path in (a.dev, a.submission, baseline_path)},
        input_sha256={str(path): digest(path) for path in (a.full, a.assembly, a.checks)},
        reference_matmul_tf32=False, official_sandbox=False)

    def persist():
        Path(a.output).write_text(json.dumps(report, indent=2) + '\n')

    for row in full['rows']:
        case = row['config']
        development = compiled(dev, case)
        submission = compiled(sub, case)
        old = compiled(baseline, case)
        assert development == submission, ('development/submission', row['case'])
        assert submission['device_source_sha256'] == row['device_source_sha256'][sub_index]
        assert submission['compile_flags'] == row['compile_flags'][sub_index]
        assert old['device_source_sha256'] == row['device_source_sha256'][0]
        assert old['compile_flags'] == row['compile_flags'][0]
        path = selected(case, config)
        if path == 'baseline':
            assert submission == old, ('baseline fallback', row['case'])
        report['full'].append(dict(case=row['case'], config=case, path=path,
            development_submission_equal=True, actual_measured_source_and_flags_equal=True,
            baseline_equal=submission == old, **submission))
        persist()

    for filename, label in (('small_s8_pool_full.json', 'small_s8'),
                             ('s4_candidate_multiseed.json', 's4')):
        probe_report_path = Path(__file__).with_name(filename)
        probe_report = checked_report(probe_report_path)
        probe_path = list(probe_report['sha256'])[-1]
        probe = load_module(str(ROOT / probe_path))
        report['input_sha256'][str(probe_report_path)] = digest(probe_report_path)
        distinct = {r['case']: r['config'] for r in probe_report['rows']}
        for name, case in distinct.items():
            path = selected(case, config)
            active = path.startswith(label)
            actual = compiled(sub, case)
            assert compiled(dev, case) == actual
            expected = compiled(probe if active else baseline, case)
            assert actual == expected, (filename, name, path)
            report['families'].append(dict(report=filename, case=name, config=case,
                active=active, final_equals_measured_probe_or_baseline=True, **actual))
            persist()

    # Run the actual stripped file under the real RestrictedPython host guard.
    guarded = guarded_module(Path(a.submission).resolve())
    checks = json.loads(Path(a.checks).read_text())
    assert checks['status'] == 'PASS'
    for prior in checks['guarded']:
        c = prior['config']
        error = check_case(guarded, c, 5601, None,
            lambda idx, bs=c['block_size']: adversarial_indices(idx, bs, True))
        report['guarded'].append(dict(config=c, both_interfaces=True, max_abs_error=error))
        persist()
    report['status'] = 'PASS'
    persist()
    print('PASS', {key: len(report[key]) for key in ('full', 'families', 'guarded')}, flush=True)


if __name__ == '__main__':
    main()
