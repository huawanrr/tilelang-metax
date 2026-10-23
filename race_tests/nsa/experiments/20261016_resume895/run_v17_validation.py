"""Validate the exact v17 candidate with a single sequential GPU queue."""
import datetime
import hashlib
import json
from pathlib import Path
import subprocess
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def main():
    destination = HERE / 'validation_v17'
    destination.mkdir(exist_ok=False)
    python = sys.executable
    candidate = str(HERE / 'candidate_v17.py')
    baseline, control = [str(HERE / name) for name in ['baseline.py', 'control.py']]
    probe = str(HERE.parent / '20261016_pow2/pow2_all.py')
    cases = str(HERE / 'candidate_cases.json')
    binary_cases = ','.join([f'oj{i}' for i in range(1,15)] +
        ['d32_t32','d32_t63','d32_t64_c0','d32_t65','d32_t128',
         'd32_b2_t32','d32_h2_t32','d32_b2_t64','d32_h2_t64'])
    stages = [
        ('rules', [python,'check_submission_nsa.py',candidate]),
        ('changed_reference', [python,str(HERE/'verify_v17.py'),candidate,
                               '--output',str(destination/'changed_reference.json')]),
        ('full_reference', [python,'verify_nsa.py',candidate,'--cases','all','--extras',
                            '--output',str(destination/'full_reference.json')]),
        ('actual_binary', [python,'experiments/20261015_goal8933/audit_binary.py',
                           baseline,probe,candidate,'--case-file',cases,'--cases',binary_cases,
                           '--output-dir',str(destination/'binary')]),
        ('storage_2026', [python,'experiments/20261016_s2_family/bench_storage_windows.py',
                          baseline,control,candidate,'--case-file',cases,'--cases','oj1',
                          '--seeds','2026','--repeats','96,480','--attempts','24',
                          '--output',str(destination/'storage_2026.json')]),
        ('cold_2026', [python,'experiments/20261008_goal895/profile_cold.py',
                       baseline,control,candidate,'--case-file',cases,'--cases','oj1',
                       '--seed','2026','--rounds','8','--repeat','96',
                       '--output',str(destination/'cold_2026.json')]),
    ]
    report = dict(status='running', candidate_sha256=hashlib.sha256(Path(candidate).read_bytes()).hexdigest(),
                  method='Sequential processes; do not start another GPU experiment while this queue is live.',
                  stages=[])
    def save():
        (destination/'status.json').write_text(json.dumps(report,indent=2)+'\n')
    for name, command in stages:
        row = dict(name=name, command=command, status='running',
                   started_utc=datetime.datetime.now(datetime.timezone.utc).isoformat())
        report['stages'].append(row);save()
        print('START',name,flush=True)
        with (destination/(name+'.log')).open('x') as log:
            completed = subprocess.run(command,cwd=ROOT,stdout=log,stderr=subprocess.STDOUT)
        row.update(returncode=completed.returncode,status='PASS' if completed.returncode==0 else 'FAIL',
                   finished_utc=datetime.datetime.now(datetime.timezone.utc).isoformat())
        save();print(row['status'],name,flush=True)
        if completed.returncode:
            report['status']='FAIL';save();raise SystemExit(completed.returncode)
    assert report['candidate_sha256']==hashlib.sha256(Path(candidate).read_bytes()).hexdigest()
    report['status']='PASS';save()
    print('All exact-candidate stages PASS',flush=True)


if __name__ == '__main__':
    main()
