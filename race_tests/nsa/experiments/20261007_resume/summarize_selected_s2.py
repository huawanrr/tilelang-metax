"""Summarize the final S2 shape range without discarding adverse measurements."""
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
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('report')
    parser.add_argument('--assembly', required=True)
    parser.add_argument('--output', required=True)
    args = parser.parse_args()
    report = json.loads(Path(args.report).read_text())
    cfg = json.loads(Path(args.assembly).read_text())['s2_config']
    rows = []
    for row in report['rows']:
        c = row['config']
        grid = c['B'] * c['H'] * c['SEQ_LEN']
        active = (c['S'] == 2 and c['D'] == 64 and c['block_size'] == 16
            and c['HQ'] == 16*c['H'] and c['SEQ_LEN'] >= cfg['seq_len_min']
            and grid >= cfg['grid_min'] and c['SEQ_LEN'] % 16 == 0
            and (c['is_causal'] or grid >= cfg.get('noncausal_grid_min', cfg['grid_min']))
            and (cfg['max_heads'] is None or c['H'] <= cfg['max_heads']))
        summary = row['summaries'][-1]
        rows.append(dict(case=row['case'], seed=row['seed'], config=c, selected=active,
            speedup=summary['median_speedup'],
            unfiltered_speedup=statistics.median(t['speedup'] for t in row['trials'][-1]),
            baseline_us=summary['median_baseline_us'], candidate_us=summary['median_candidate_us'],
            accepted=summary['accepted'], total=summary['total']))
    selected = [r for r in rows if r['selected']]
    assert all(r['speedup'] is not None for r in selected)
    result = dict(input=args.report, input_sha256=hashlib.sha256(Path(args.report).read_bytes()).hexdigest(),
        assembly=args.assembly, filter=cfg,
        selected=aggregate([r['speedup'] for r in selected]),
        selected_unfiltered=aggregate([r['unfiltered_speedup'] for r in selected]),
        all_control=aggregate([r['summaries'][0]['median_speedup'] for r in report['rows']]),
        max_abs_error=max(max(r['max_abs_error']) for r in report['rows']),
        graph_correctness_checks=sum(len(r['graph_checks']) for r in report['rows']),
        regressions=[r for r in selected if r['speedup'] < 1], records=rows, official_score=None)
    Path(args.output).write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({k:v for k,v in result.items() if k not in ('records','regressions')}, indent=2))
    print('selected regressions', len(result['regressions']))


if __name__ == '__main__':
    main()
