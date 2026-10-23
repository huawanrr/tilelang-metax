"""Summarize completed studies, retaining every configuration and negative."""
import argparse
import hashlib
import json
from pathlib import Path
import statistics

HERE=Path(__file__).resolve().parent


def summarize(path):
    data=json.loads(path.read_text())
    paths=list(data['sha256'])
    for name,digest in data['sha256'].items():
        assert hashlib.sha256(Path(name).read_bytes()).hexdigest()==digest,name
    rows=[]
    for row in data['rows']:
        assert len(row['summaries'])==len(paths)-1
        assert len(row['trials'])==len(paths)
        for index,name in enumerate(paths[1:],1):
            trials=row['trials'][index]
            accepted=[t for t in trials if t['accepted']]
            rows.append(dict(case=row['case'],seed=row['seed'],file=Path(name).name,
                accepted=len(accepted),attempts=len(trials),
                unfiltered_speedup=statistics.median(t['speedup'] for t in trials),
                filtered_speedup=statistics.median(t['speedup'] for t in accepted) if accepted else None,
                device_source_changed=row['device_source_sha256'][index]!=row['device_source_sha256'][0],
                max_abs_error=row['max_abs_error'][index]))
    aggregate=[]
    for name in paths[1:]:
        values=[r for r in rows if r['file']==Path(name).name]
        aggregate.append(dict(file=Path(name).name,rows=len(values),
            unfiltered_speedup=statistics.geometric_mean(r['unfiltered_speedup'] for r in values),
            filtered_speedup=statistics.geometric_mean(r['filtered_speedup'] for r in values if r['filtered_speedup'] is not None),
            regressions=sum(r['unfiltered_speedup']<1 for r in values)))
    return dict(file=str(path),sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                method=data['method'],source_sha256=data['sha256'],aggregate=aggregate,rows=rows)


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('inputs',nargs='+')
    p.add_argument('--output',required=True)
    a=p.parse_args()
    results=[summarize(Path(x)) for x in a.inputs]
    with Path(a.output).open('x') as f:
        json.dump(dict(studies=results,official_baseline_score=88.93,
                       official_target=89.33,official_candidate_score=None),f,indent=2)
        f.write('\n')
    for r in results:
        print(Path(r['file']).name)
        for x in r['aggregate']:print(x)


if __name__=='__main__':main()
