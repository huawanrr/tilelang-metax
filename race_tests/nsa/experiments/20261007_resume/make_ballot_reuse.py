"""Replace shared prefix compaction with a wave-local mask for K/V reuse."""
import ast
import hashlib
import json
from pathlib import Path
from make_s8_schedule import replace_once

HERE = Path(__file__).resolve().parent
BASE = HERE.parent / '20261002_mid_v1/nsa.py'


def main():
    baseline = BASE.read_text()
    template = (HERE.parent / '20261005_goal8929/bucket_reuse_template.py').read_text()
    start = template.index('            matches = T.alloc_fragment')
    end = template.index('            q = T.alloc_fragment', start)
    template = template[:start] + '''            tid = T.get_thread_binding()
            token_id = window * QC + tid
            raw = T.if_then_else(tid < QC and token_id < seq_len,
                                Indices[b, token_id, h, 0], -1)
            invalid = raw < 0 or raw >= NB or (is_causal and raw > token_id // BS)
            matched = tid < QC and token_id < seq_len and T.if_then_else(block < NB,
                raw == block and (not is_causal or block <= token_id // BS), invalid)
            remaining = T.alloc_local([1], T.uint64)
            remaining[0] = T.cast(matched, T.uint64) << T.cast(tid, T.uint64)
            for step in T.unroll(6):
                remaining[0] = remaining[0] | T.shfl_xor(remaining[0], 1 << step, 64, 0xffffffffffffffff)
            count = T.alloc_local([1], T.int32)
            count[0] = T.cast(T.popcount(remaining[0]), T.int32)

''' + template[end:]
    template = replace_once(template,
        '                    token = tokens[task]\n',
        '''                    lane = T.cast(63 - T.clz(remaining[0]), T.int32)
                    token = window * QC + lane
                    remaining[0] = remaining[0] ^ (T.uint64(1) << T.cast(lane, T.uint64))
''')
    records = []
    for qc in (32, 64):
        source = replace_once(baseline, '\ndef _get_kernel(', '\n' + template + '\n\ndef _get_kernel(')
        source = replace_once(source,
            'attention = native_sparse_attention_single_packed_qo_v2(width=128, late=False, **common)',
            f'attention = native_sparse_attention_bucket_reuse(scan_tokens={qc}, **common)')
        ast.parse(source)
        path = HERE / f'ballot_reuse_q{qc}.py'
        with path.open('x') as f:
            f.write(source)
        records.append(dict(path=path.name, tokens_per_window=qc,
                            sha256=hashlib.sha256(path.read_bytes()).hexdigest()))
    (HERE / 'ballot_reuse_assembly.json').write_text(json.dumps(dict(
        baseline=str(BASE), baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records, note='Synchronous 64-lane shuffle-OR compaction replaces shared cumsum. Current-input K/V packing remains part of every invocation.'
    ), indent=2) + '\n')


if __name__ == '__main__':
    main()
