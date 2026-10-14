"""Compare host launch configuration as well as device code on unchanged paths."""
import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from experiment_bench import load_module

paths = ['experiments/20260927_oj_fix/nsa.py', 'experiments/20260927_next/selected.py']
modules = [load_module(path) for path in paths]
cases = json.loads((ROOT / 'test_cases_nsa_fwd.json').read_text())
rows = []
for number in (9, 15, 27, 57, 60, 65, 68, 83):
    c = cases[number-1]
    hashes = []
    for name, mod in zip(('current', 'candidate'), modules):
        k = mod._get_kernel(c['B'], c['SEQ_LEN'], c['H'], c['HQ'], c['D'],
                            c['S'], c['block_size'], c['is_causal'], 0.1)
        source = k.get_kernel_source(kernel_only=False)
        host = k.get_host_source()
        Path(__file__).with_name(f'{name}_host_{number}.txt').write_text(host)
        Path(__file__).with_name(f'{name}_full_source_{number}.txt').write_text(source)
        hashes.append(dict(host=hashlib.sha256(host.encode()).hexdigest(),
                           full_source=hashlib.sha256(source.encode()).hexdigest()))
    row = dict(case=number, identical_host_and_device=hashes[0] == hashes[1], hashes=hashes)
    rows.append(row)
    print(row, flush=True)
Path(__file__).with_name('launch_audit.json').write_text(json.dumps(rows, indent=2)+'\n')
assert all(row['identical_host_and_device'] for row in rows), 'inspect differing launch metadata'
