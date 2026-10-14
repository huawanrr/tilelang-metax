"""Prepare local compaction and actual cross-query K/V register reuse probes."""
import ast
import hashlib
import json
from pathlib import Path

from make_joined_packed import replace_once

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/nsa.py'


def main():
    baseline = BASE.read_text()
    template = (HERE / 'bucket_reuse_template.py').read_text()
    records = []
    for tokens in (128, 256):
        source = replace_once(baseline, '\ndef _get_kernel(', '\n' + template + '\n\ndef _get_kernel(')
        source = replace_once(source,
            'attention = native_sparse_attention_single_packed_qo_v2(width=128, late=False, **common)',
            f'attention = native_sparse_attention_bucket_reuse(scan_tokens={tokens}, **common)')
        ast.parse(source)
        path = HERE / f'bucket_reuse_q{tokens}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, scan_tokens=tokens,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'bucket_reuse_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records, input_and_schedule_cache=False,
        method='Each CTA compacts a query window for one selected block and keeps that block in registers across its queries.'
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
