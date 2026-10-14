"""Create independent multi-seed measurements for the D32 dispatch ranges."""
from pathlib import Path
import ast
import json

HERE = Path(__file__).resolve().parent


def main():
    source = (HERE / 'bracketed_family.py').read_text()
    source = source.replace('import hashlib\n', 'import hashlib\nimport itertools\n', 1)
    source = source.replace("    p.add_argument('--attempts',", "    p.add_argument('--seeds', default='0,61,2026')\n    p.add_argument('--attempts',", 1)
    source = source.replace("    for case_id in a.cases.split(','):",
        "    for case_id, seed in itertools.product(a.cases.split(','), [int(v) for v in a.seeds.split(',')]):", 1)
    source = source.replace('inputs = make_inputs(cfg, 61)', 'inputs = make_inputs(cfg, seed)', 1)
    source = source.replace('row = dict(case=case_id, config=cfg,', 'row = dict(case=case_id, seed=seed, config=cfg,', 1)
    source = source.replace('print(case_id, json.dumps(summaries),', 'print(case_id, seed, json.dumps(summaries),', 1)
    ast.parse(source)
    output = HERE / 'bracketed_multiseed.py'
    assert not output.exists()
    output.write_text(source)
    family = HERE / 'family_cases.json'
    cases = json.loads(family.read_text())
    for b, t, h, causal in [
        (1, 64, 2, True), (1, 128, 2, True), (1, 256, 2, True),
        (1, 513, 1, True), (2, 384, 1, True), (1, 257, 2, True),
        (1, 384, 2, True), (1, 192, 4, True), (1, 512, 2, True),
        (1, 6144, 1, True), (8, 768, 1, True), (1, 1023, 1, False),
        (2, 256, 1, False), (1, 512, 1, False), (1, 1024, 1, False),
    ]:
        name = f'd32_b{b}_t{t}_h{h}' + ('' if causal else '_noncausal')
        assert name not in cases
        cases[name] = dict(B=b, SEQ_LEN=t, H=h, HQ=16*h, D=32, S=1,
                           block_size=16, is_causal=causal)
    family.write_text(json.dumps(cases, indent=2) + '\n')


if __name__ == '__main__':
    main()
