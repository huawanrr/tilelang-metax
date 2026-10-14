"""Reuse the existing measurement protocols with explicit S2 family cases."""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]

cases = {}
for length in (64, 128, 256, 384, 512, 768, 1024, 1280, 1536, 1792,
               2048, 2560, 3072, 4096, 6144, 8192):
    cases[f't{length}'] = dict(B=1, SEQ_LEN=length, H=1, HQ=16,
                            D=64, S=2, block_size=16, is_causal=True)
for label, batch, length, heads in (
    ('g512_b2', 2, 256, 1), ('g1024_b4', 4, 256, 1),
    ('g1024_h2', 1, 512, 2), ('g2048_b4', 4, 512, 1),
    ('g2048_h2', 2, 512, 2), ('g4096_b8', 8, 512, 1),
    ('g4096_h2', 2, 1024, 2), ('g8192_b8', 8, 1024, 1),
):
    cases[label] = dict(B=batch, SEQ_LEN=length, H=heads, HQ=16 * heads,
                       D=64, BS=16, S=2, block_size=16, is_causal=True)
    del cases[label]['BS']
(HERE / 'cases.json').write_text(json.dumps(cases, indent=2) + '\n')

for src, dest, anchor in (
    ('experiments/20260927_next/compare_same_output.py', 'compare_family.py',
     '    selected = [str(i) for i in parse_cases'),
    ('experiments/20260928_grid_order/bracketed_families.py', 'bracketed_family.py',
     '    modules = [load_module(path)'),
):
    source = (ROOT / src).read_text()
    assert source.count(anchor) == 1
    source = source.replace(anchor, (
        '    named.update(json.loads(Path(__file__).with_name("cases.json").read_text()))\n'
        + anchor), 1)
    (HERE / dest).write_text(source)
