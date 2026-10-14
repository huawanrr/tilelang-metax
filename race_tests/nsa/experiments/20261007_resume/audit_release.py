"""Audit final device code against measured S2 probes and the inherited release."""
import argparse
import ast
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

import torch

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from experiment_bench import load_module
from verify_nsa import check_case

spec = importlib.util.spec_from_file_location('nsa_resume_audit_helpers',
    ROOT / 'experiments/20261005_goal8929/verify_candidate.py')
prior = importlib.util.module_from_spec(spec)
spec.loader.exec_module(prior)
helpers = prior.helpers


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def checked_report(path):
    report = json.loads(Path(path).read_text())
    for source, expected in report['sha256'].items():
        assert digest(ROOT / source) == expected, source
    return report


def selected(case, config):
    c, s2 = case, config['s2_config']
    grid = c['B'] * c['SEQ_LEN'] * c['H']
    if (c['S'] == 2 and c['D'] == 64 and c['block_size'] == 16
            and c['HQ'] == 16*c['H'] and c['SEQ_LEN'] >= s2['seq_len_min']
            and grid >= s2['grid_min'] and c['SEQ_LEN'] % 16 == 0
            and (c['is_causal'] or grid >= s2.get('noncausal_grid_min', s2['grid_min']))
            and (s2['max_heads'] is None or c['H'] <= s2['max_heads'])):
        return 's2_blocks_qo' if grid >= 3072 else 's2_blocks'
    return prior.selected(case, config)


def compiled(module, case):
    c = case
    kernel = module._get_kernel(c['B'], c['SEQ_LEN'], c['H'], c['HQ'], c['D'],
        c['S'], c['block_size'], c['is_causal'], 0.1)
    parts = helpers.parts(kernel)
    sources = [p.get_kernel_source() for p in parts]
    for part, source in zip(parts, sources):
        assert not any(marker in source for marker in
                       ('memcpy_async', 'cp.async', 'maca_async', 'tma_load', 'mbarrier'))
        assert not any(value for key, value in part.pass_configs.items()
                       if 'disable_data_race' in str(key) or 'disable_safe_memory' in str(key))
    resources = []
    for part, source in zip(parts, sources):
        shared, method, _ = helpers.shared_bytes(part)
        resources.append(dict(shared_bytes=shared, shared_method=method,
            block_barriers=source.count('__syncthreads()'),
            wave_barriers=source.count('__syncwarp()')))
    return dict(device_source_sha256=[hashlib.sha256(s.encode()).hexdigest() for s in sources],
                compile_flags=helpers.flags(kernel), resources=resources)


def normalized_ast(path):
    tree = ast.parse(Path(path).read_text())
    for node in ast.walk(tree):
        if isinstance(node, (ast.Module, ast.FunctionDef, ast.AsyncFunctionDef, ast.ClassDef)):
            if (node.body and isinstance(node.body[0], ast.Expr)
                    and isinstance(node.body[0].value, ast.Constant)
                    and isinstance(node.body[0].value.value, str)):
                node.body.pop(0)
    return ast.dump(tree)


@torch.no_grad()
def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dev', required=True)
    parser.add_argument('--submission', required=True)
    parser.add_argument('--assembly', required=True)
    parser.add_argument('--full', required=True)
    parser.add_argument('--family', action='append', default=[])
    parser.add_argument('--extra', required=True)
    parser.add_argument('--output', required=True)
    args = parser.parse_args()
    torch.backends.cuda.matmul.allow_tf32 = False
    assert normalized_ast(args.dev) == normalized_ast(args.submission)
    config = json.loads(Path(args.assembly).read_text())
    assert config['candidate_sha256'] == digest(args.dev)
    extra = json.loads(Path(args.extra).read_text())
    assert extra['status'] == 'PASS'
    assert extra['source_sha256'] == digest(args.submission)
    dev, sub = load_module(args.dev), load_module(args.submission)
    parent_path = ROOT / 'experiments/20261005_goal8929/release_v1/submission.py'
    baseline_path = ROOT / 'experiments/20261002_mid_v1/submission.py'
    parent, baseline = load_module(str(parent_path)), load_module(str(baseline_path))
    full = checked_report(args.full)
    paths = list(full['sha256'])
    sub_index = next(i for i, p in enumerate(paths) if Path(p).resolve() == Path(args.submission).resolve())
    parent_index = next(i for i, p in enumerate(paths) if Path(p).resolve() == parent_path)
    assert len(full['rows']) == 109
    report = dict(status='running', command=sys.argv, full=[], families=[], inherited_guarded=[],
        ast_equal_after_removing_docstrings=True,
        source_sha256={str(p): digest(p) for p in (args.dev, args.submission, parent_path, baseline_path)},
        evidence_sha256={str(p): digest(p) for p in (args.full, args.assembly, args.extra, *args.family)},
        reference_matmul_tf32=False, official_sandbox=False)

    def persist():
        Path(args.output).write_text(json.dumps(report, indent=2) + '\n')

    for row in full['rows']:
        case = row['config']
        current, inherited, old = compiled(sub, case), compiled(parent, case), compiled(baseline, case)
        assert compiled(dev, case) == current, ('dev/submission', row['case'])
        for i, result in ((0, old), (parent_index, inherited), (sub_index, current)):
            assert result['device_source_sha256'] == row['device_source_sha256'][i]
            assert result['compile_flags'] == row['compile_flags'][i]
        path = selected(case, config)
        if not path.startswith('s2_'):
            assert current == inherited, ('inherited path', row['case'])
        if path == 'baseline':
            assert current == old, ('official baseline fallback', row['case'])
        report['full'].append(dict(case=row['case'], config=case, path=path,
            development_submission_equal=True, actual_measured_source_and_flags_equal=True,
            parent_equal=current == inherited, baseline_equal=current == old, **current))
        persist()

    for filename in args.family:
        measured = checked_report(filename)
        probe_path = list(measured['sha256'])[-1]
        probe = load_module(str(ROOT / probe_path))
        distinct = {row['case']: row for row in measured['rows']}
        for name, row in distinct.items():
            case = row['config']
            active = selected(case, config).startswith('s2_')
            actual = compiled(sub, case)
            assert compiled(dev, case) == actual
            assert actual == compiled(probe if active else parent, case), (filename, name, active)
            if active:
                assert actual['device_source_sha256'] == row['device_source_sha256'][-1]
                assert actual['compile_flags'] == row['compile_flags'][-1]
            report['families'].append(dict(report=filename, case=name, config=case,
                active=active, final_equals_measured_probe_or_parent=True, **actual))
            persist()

    guarded = prior.guarded_module(Path(args.submission).resolve())
    inherited_cases = [prior.cfg(129), prior.cfg(128, h=2), prior.cfg(2048, s=4),
                       prior.cfg(3073, s=4), prior.cfg(1025, s=4, b=4, causal=False)]
    for case in inherited_cases:
        error = check_case(guarded, case, 713,
            None, lambda idx, bs=case['block_size']: prior.adversarial_indices(idx, bs, True))
        report['inherited_guarded'].append(dict(config=case, both_interfaces=True, max_abs_error=error))
        persist()
    report['status'] = 'PASS'
    persist()
    print('PASS', {name: len(report[name]) for name in ('full', 'families', 'inherited_guarded')})


if __name__ == '__main__':
    main()
