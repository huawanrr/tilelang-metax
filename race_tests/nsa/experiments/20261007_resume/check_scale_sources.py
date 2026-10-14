"""Check that the nonpositive-scale correction leaves measured positive-scale code unchanged."""
import argparse
import hashlib
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from experiment_bench import load_module


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('candidate')
    parser.add_argument('--output', required=True)
    args = parser.parse_args()
    probe_path = HERE / 'short_refine_full2.py'
    probe, candidate = load_module(str(probe_path)), load_module(args.candidate)
    report = dict(status='running', source_sha256={str(p): digest(p)
        for p in (probe_path, args.candidate)}, rows=[])
    for b, n in ((2, 768), (4, 1024)):
        for scale in (0.1, None, 0.03125):
            values = []
            for mod in (probe, candidate):
                kernel = mod._get_kernel(b, n, 1, 16, 64, 2, 16, True, scale)
                values.append(dict(device_sha256=hashlib.sha256(kernel.get_kernel_source().encode()).hexdigest(),
                                   compile_flags=list(kernel.compile_flags or [])))
            assert values[0] == values[1], (b, n, scale, values)
            report['rows'].append(dict(B=b, SEQ_LEN=n, scale=scale, source_and_flags_equal=True, **values[1]))
            Path(args.output).write_text(json.dumps(report, indent=2) + '\n')
            print('PASS', b, n, scale, values[0], flush=True)
    report['status'] = 'PASS'
    Path(args.output).write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
