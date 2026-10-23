"""One fixed confirmation batch prompted by a noisy same-source control."""
import json
import os
from pathlib import Path
import subprocess
import sys

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]


def main():
    plan=json.loads((HERE/'confirmation_plan.json').read_text())
    os.sched_setaffinity(0,{plan['cpu_core']})
    report=dict(plan=plan,status='running',stages=[])
    def save():
        (HERE/'confirmation_status.json').write_text(json.dumps(report,indent=2)+'\n')
    for seed in plan['seeds']:
        name=f'cold_confirm_seed{seed}'
        command=[sys.executable,str(HERE/'profile_cold_warm.py'),
                 str(HERE/'baseline.py'),str(HERE/'control.py'),str(HERE/'candidate_v17.py'),
                 '--case-file',str(HERE/'candidate_cases.json'),'--cases','oj1',
                 '--seed',str(seed),'--rounds',str(plan['rounds']),'--repeat',str(plan['repeat']),
                 '--output',str(HERE/(name+'.json'))]
        row=dict(name=name,command=command,status='running');report['stages'].append(row);save()
        print('START',name,flush=True)
        with (HERE/(name+'.log')).open('x') as out:
            result=subprocess.run(command,cwd=ROOT,stdout=out,stderr=subprocess.STDOUT)
        row.update(returncode=result.returncode,status='PASS' if result.returncode==0 else 'FAIL');save()
        print(row['status'],name,flush=True)
        if result.returncode:
            report['status']='FAIL';save();raise SystemExit(result.returncode)
    report['status']='PASS';save()


if __name__=='__main__':
    main()
