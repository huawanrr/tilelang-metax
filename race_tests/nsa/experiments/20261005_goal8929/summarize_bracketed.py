"""Summarize all timing samples, including drift rejects and slow cases."""
import argparse
import hashlib
import json
import math
from pathlib import Path
import statistics


def aggregate(values):
    return dict(count=len(values), geomean=math.exp(statistics.mean(map(math.log, values))),
                minimum=min(values), maximum=max(values)) if values else dict(count=0)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('report')
    p.add_argument('--grid-min', type=int, default=0)
    p.add_argument('--grid-max', type=int, default=2**63-1)
    p.add_argument('--seq-min', type=int, default=0)
    p.add_argument('--heads', type=int)
    p.add_argument('--candidate', type=int, default=-1)
    p.add_argument('--output', required=True)
    a = p.parse_args()
    path = Path(a.report)
    report = json.loads(path.read_text())
    records = []
    for row in report['rows']:
        c = row['config']
        grid = c['B'] * c['H'] * c['SEQ_LEN']
        selected = (a.grid_min <= grid <= a.grid_max and c['SEQ_LEN'] >= a.seq_min
                    and (a.heads is None or c['H'] == a.heads))
        trials = row['trials'][a.candidate]
        summary = row['summaries'][a.candidate]
        records.append(dict(case=row['case'], seed=row['seed'], config=c,
            selected=selected, speedup=summary['median_speedup'],
            unfiltered_speedup=statistics.median(v['speedup'] for v in trials),
            baseline_us=summary['median_baseline_us'], candidate_us=summary['median_candidate_us'],
            accepted=summary['accepted'], total=summary['total']))
    selected = [r for r in records if r['selected']]
    result = dict(input=a.report, input_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
        filter=dict(grid_min=a.grid_min, grid_max=a.grid_max, seq_min=a.seq_min, heads=a.heads),
        selected=aggregate([r['speedup'] for r in selected if r['speedup'] is not None]),
        selected_unfiltered=aggregate([r['unfiltered_speedup'] for r in selected]),
        all_control=aggregate([r['summaries'][0]['median_speedup'] for r in report['rows']
                               if r['summaries'][0]['median_speedup'] is not None]),
        max_abs_error=max(max(r['max_abs_error']) for r in report['rows']),
        graph_correctness_checks=sum(len(r.get('graph_checks', [])) for r in report['rows']),
        regressions=[r for r in selected if r['speedup'] is not None and r['speedup'] < 1],
        records=records, official_score=None)
    Path(a.output).write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({k: v for k, v in result.items() if k not in ('records', 'regressions')}, indent=2))
    print('selected regressions', len(result['regressions']))


if __name__ == '__main__':
    main()
