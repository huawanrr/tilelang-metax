"""Match final kernels to the separately timed shape-family components."""
import argparse
import json
from pathlib import Path

from audit_candidate import ROOT, compiled, digest
from experiment_bench import load_module


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('module')
    parser.add_argument('--output', required=True)
    a = parser.parse_args()
    module = load_module(a.module)
    report = dict(status='running', source_sha256=digest(a.module), rows=[])
    cache = {}
    sources = (('candidate_v2_family_screen.json', 'v2'),
               ('s4_pipeline_family.json', 's4'),
               ('single_math_mid_family.json', 'math'))
    for filename, kind in sources:
        path = Path(__file__).resolve().parent / filename
        data = json.loads(path.read_text())
        for source, expected in data['sha256'].items():
            assert digest(ROOT / source) == expected, source
        index = len(data['sha256']) - 1
        for row in data['rows']:
            c = row['config']
            grid = c['B'] * c['H'] * c['SEQ_LEN']
            if kind == 'v2':
                if c['S'] == 4:
                    continue
                if c['S'] == 1 and c['D'] == 64 and c['SEQ_LEN'] >= 128 and c['SEQ_LEN'] % 16 == 0 and 512 <= grid < 2304:
                    continue
            key = json.dumps(c, sort_keys=True)
            if key not in cache:
                cache[key] = compiled(module, c)
            parts = cache[key]
            assert [p['sha256'] for p in parts] == row['device_source_sha256'][index], (kind, row['case'], 'source')
            assert [p['flags'] for p in parts] == row['compile_flags'][index], (kind, row['case'], 'flags')
            report['rows'].append(dict(component=kind, case=row['case'], seed=row['seed'],
                configuration=c, actual_timed_source_equal=True, kernels=parts))
            Path(a.output).write_text(json.dumps(report, indent=2) + '\n')
            print(kind, row['case'], row['seed'], 'PASS', flush=True)
    report['status'] = 'PASS'
    report['unique_configurations'] = len(cache)
    Path(a.output).write_text(json.dumps(report, indent=2) + '\n')
    print('PASS', len(report['rows']), 'records;', len(cache), 'configurations', flush=True)


if __name__ == '__main__':
    main()
