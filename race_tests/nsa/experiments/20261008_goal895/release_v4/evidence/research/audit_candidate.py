"""Audit final standalone sources against the exact device code that was timed."""
import argparse
import ast
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from experiment_bench import load_module
from verify_candidate import parts, prior, shape

spec = importlib.util.spec_from_file_location('oct8_strip_helpers',
    ROOT / 'experiments/20261007_exp_math/make_submission.py')
strip = importlib.util.module_from_spec(spec)
spec.loader.exec_module(strip)


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def changed_scope(c):
    if c['HQ'] != 16 * c['H'] or c['block_size'] != 16:
        return False
    n, d, s, h = c['SEQ_LEN'], c['D'], c['S'], c['H']
    grid = c['B'] * h * n
    if s == 1 and n % 16 == 0:
        return ((d == 32 and grid <= 192)
            or (d == 64 and grid <= 256 and (grid <= 128 or n >= 128))
            or (d == 128 and h == 1 and 128 < grid < 768)
            or (d == 64 and n >= 128 and 512 <= grid < 2304))
    if d == 64 and s == 2:
        return n >= 64 and grid <= 1024
    if d == 64 and s == 4 and n >= 128:
        return (n % 16 == 0 and h <= 2 and grid <= 4096) or 768 <= grid <= 1536
    return False


def compiled(module, c):
    values = []
    for part in parts(module._get_kernel(*shape(c))):
        source = part.get_kernel_source()
        assert not any(marker in source for marker in
            ('memcpy_async', 'cp.async', 'maca_async', 'tma_load', 'mbarrier'))
        assert not any(value for key, value in part.pass_configs.items()
            if 'disable_data_race' in str(key) or 'disable_safe_memory' in str(key))
        shared, method, _ = prior.helpers.shared_bytes(part)
        values.append(dict(sha256=hashlib.sha256(source.encode()).hexdigest(),
            flags=list(part.compile_flags or []), shared_bytes=shared,
            block_barriers=source.count('__syncthreads()'),
            wave_barriers=source.count('__syncwarp()'), shared_evidence=method,
            pass_configs={str(k): v for k, v in part.pass_configs.items()}))
    return values


def static_checks(dev_source, sub_source, baseline_source):
    dev_tree = strip.no_docs(ast.parse(dev_source))
    assert ast.dump(dev_tree) == ast.dump(ast.parse(sub_source))
    old = {n.name: n for n in strip.no_docs(ast.parse(baseline_source)).body
           if isinstance(n, ast.FunctionDef)}
    new = {n.name: n for n in dev_tree.body if isinstance(n, ast.FunctionDef)}
    kept = []
    for name, node in old.items():
        if name == '_get_kernel':
            continue
        assert ast.dump(node) == ast.dump(new[name]), name
        kept.append(name)
    assert not any(marker in dev_source for marker in
        ('TL_DISABLE_DATA_RACE_CHECK', 'TL_DISABLE_SAFE_MEMORY_ACCESS', 'T.call_extern'))
    return dict(ast_equal_ignoring_docstrings=True, unchanged_original_functions=kept,
                added_functions=sorted(set(new) - set(old)))


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--dev', required=True)
    p.add_argument('--submission', required=True)
    p.add_argument('--timings', nargs='+', required=True)
    p.add_argument('--output', required=True)
    a = p.parse_args()
    baseline_path = ROOT / 'experiments/20261007_exp_math/release_v1/nsa.py'
    assert digest(baseline_path) == 'd6ef68ec0422c388148bc226a0f7c216f3cb8fb25a74a544a3a6847f3220e246'
    paths = (Path(a.dev).resolve(), Path(a.submission).resolve(), baseline_path)
    report = dict(status='running', command=sys.argv,
        source_sha256={str(x): digest(x) for x in paths},
        static=static_checks(*(x.read_text() for x in paths)), timings=[], configurations=[])
    dev, sub, baseline = [load_module(str(x)) for x in paths]
    cache = {}

    def save():
        Path(a.output).write_text(json.dumps(report, indent=2) + '\n')

    save()
    for timing_path in a.timings:
        data = json.loads(Path(timing_path).read_text())
        assert data['shared_pool']
        names = list(data['sha256'])
        for name, expected in data['sha256'].items():
            assert digest(ROOT / name) == expected, name
        matching = [i for i, name in enumerate(names) if (ROOT / name).resolve() in paths[:2]]
        assert matching, (timing_path, 'final source was not in this benchmark')
        for row in data['rows']:
            c = row['config']
            key = json.dumps(c, sort_keys=True)
            if key not in cache:
                submitted, development, original = [compiled(mod, c) for mod in (sub, dev, baseline)]
                assert submitted == development, (row['case'], 'dev/sub')
                assert (submitted != original) == changed_scope(c), (row['case'], 'dispatch scope', c)
                if (c['S'] == 1 and c['block_size'] == 16 and c['SEQ_LEN'] % 16 == 0
                    and ((c['D'] == 32 and c['B'] * c['H'] * c['SEQ_LEN'] <= 192)
                         or (c['D'] == 64 and c['B'] * c['H'] * c['SEQ_LEN'] <= 256
                             and (c['B'] * c['H'] * c['SEQ_LEN'] <= 128 or c['SEQ_LEN'] >= 128)))):
                    assert len(submitted) == 1 and submitted[0]['shared_bytes'] == 0
                    assert submitted[0]['block_barriers'] == submitted[0]['wave_barriers'] == 0
                if (c['S'] == 4 and c['D'] == 64 and c['block_size'] == 16
                    and c['SEQ_LEN'] >= 128 and c['SEQ_LEN'] % 16 == 0
                    and c['H'] <= 2 and c['B'] * c['H'] * c['SEQ_LEN'] <= 4096):
                    assert len(submitted) == 1 and submitted[0]['shared_bytes'] == 4096
                    assert submitted[0]['block_barriers'] == 0 and submitted[0]['wave_barriers'] > 0
                cache[key] = submitted
                report['configurations'].append(dict(config=c, baseline_equal=submitted == original,
                    baseline=original, submitted=submitted, development_submission_equal=True))
            submitted = cache[key]
            for i in matching:
                assert [v['sha256'] for v in submitted] == row['device_source_sha256'][i], (timing_path, row['case'], i)
                assert [v['flags'] for v in submitted] == row['compile_flags'][i], (timing_path, row['case'], i)
            report['timings'].append(dict(file=timing_path, case=row['case'], seed=row['seed'],
                actual_timed_sources_equal=True, checked_modules=[names[i] for i in matching]))
            save()
            print(Path(timing_path).name, row['case'], row['seed'], 'PASS', flush=True)
    report['status'] = 'PASS'
    save()
    print('PASS', len(report['configurations']), 'configurations,', len(report['timings']), 'timed records', flush=True)


if __name__ == '__main__':
    main()
