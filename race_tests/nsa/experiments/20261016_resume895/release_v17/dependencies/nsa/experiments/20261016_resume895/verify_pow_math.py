"""Replay the existing scalar exponent probe in a fresh output directory."""
import argparse
import importlib.util
import json
from pathlib import Path

HERE=Path(__file__).resolve().parent


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output-dir',required=True)
    args=parser.parse_args()
    output=Path(args.output_dir).resolve()
    output.mkdir(exist_ok=False)
    source=HERE.parent/'20261016_pow2/probe_math.py'
    spec=importlib.util.spec_from_file_location('v17_scalar_pow_probe',source)
    module=importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    module.HERE=output
    module.main()
    report=json.loads((output/'math.json').read_text())
    row=next(r for r in report['rows'] if r['mode']=='pow2')
    assert row['differing_elements_from_exp2']==0
    assert row['max_normal_relative_error']<1e-6
    print('Scalar pow/exp2 bitwise agreement PASS:',report['inputs'])


if __name__=='__main__':
    main()
