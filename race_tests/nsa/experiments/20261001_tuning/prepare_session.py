"""Preserve the 930 baseline and reuse the established measurement harnesses."""
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def case(t, d=64, bs=16, b=1, h=1, causal=True):
    return dict(B=b, SEQ_LEN=t, H=h, HQ=16 * h, D=d, S=1,
                block_size=bs, is_causal=causal)


previous = json.loads((ROOT / 'experiments/20260930_next/baseline_manifest.json').read_text())
for name, expected in previous['sha256'].items():
    actual = hashlib.sha256((ROOT / name).read_bytes()).hexdigest()
    assert actual == expected, (name, actual, expected)
previous.update(date='2026-10-01', resumed_session='01a0f20e-a22a-7c91-9062-25d57edbd4e2')
(HERE / 'baseline_manifest.json').write_text(json.dumps(previous, indent=2) + '\n')

for name in ('compare_family.py', 'bracketed_family.py'):
    source = (ROOT / 'experiments/20260930_tuning' / name).read_text()
    if not (HERE / name).exists():
        (HERE / name).write_text(source)
family_path = HERE / 'family_cases.json'
family_source = family_path if family_path.exists() else ROOT / 'experiments/20260930_tuning/family_cases.json'
families = json.loads(family_source.read_text())
families['oj9'] = case(8192)
for d, bs in ((64, 16), (128, 16), (128, 32)):
    for t in (1024, 1280, 1536, 1792, 2048, 2304, 2560, 3072, 3584, 4096, 6144, 8192):
        families[f'd{d}_bs{bs}_t{t}'] = case(t, d, bs)
    for b, h, t in ((2, 2, 512), (8, 1, 256), (8, 1, 512), (1, 4, 1024),
                    (4, 2, 1024), (16, 1, 128), (16, 1, 256), (8, 2, 512)):
        families[f'd{d}_bs{bs}_b{b}_h{h}_t{t}'] = case(t, d, bs, b, h)
for bs in (32, 64):
    for t in (1024, 2048, 4096, 8192):
        families[f'd64_bs{bs}_t{t}'] = case(t, 64, bs)
(HERE / 'family_cases.json').write_text(json.dumps(families, indent=2) + '\n')
print('Baseline hashes match; measurement harnesses and extra shapes ready.')
