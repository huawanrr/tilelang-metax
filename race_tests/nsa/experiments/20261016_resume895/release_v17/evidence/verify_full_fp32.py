"""Run the full two-interface reference suite with TF32 explicitly disabled."""
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

import torch

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
sys.path.insert(0,str(ROOT))


def main():
    source=ROOT/'verify_nsa.py'
    spec=importlib.util.spec_from_file_location('v17_full_reference',source)
    module=importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    # Loading the historical benchmark helpers may enable TF32. Set this
    # after their imports, before any reference or candidate invocation.
    previous=torch.backends.cuda.matmul.allow_tf32
    torch.backends.cuda.matmul.allow_tf32=False
    assert not torch.backends.cuda.matmul.allow_tf32
    module.main()
    assert not torch.backends.cuda.matmul.allow_tf32
    output=Path(sys.argv[sys.argv.index('--output')+1])
    metadata=dict(status='PASS',before_setting_tf32=previous,reference_matmul_tf32=False,
                  source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
                  candidate_sha256=hashlib.sha256(Path(sys.argv[1]).read_bytes()).hexdigest(),
                  report_sha256=hashlib.sha256(output.read_bytes()).hexdigest())
    output.with_suffix('.metadata.json').write_text(json.dumps(metadata,indent=2)+'\n')


if __name__=='__main__':
    main()
