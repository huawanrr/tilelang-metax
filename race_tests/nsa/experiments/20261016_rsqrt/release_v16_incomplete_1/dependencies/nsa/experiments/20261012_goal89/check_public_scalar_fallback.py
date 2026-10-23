"""Check normalization and live scalar values against the previous public entry."""
import argparse
import hashlib
import json
from pathlib import Path
import warnings

import numpy as np
import torch

from check_public_cache_cpu import host

HERE = Path(__file__).resolve().parent


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("candidate")
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    paths = [HERE / "parent_v9.py", Path(args.candidate)]
    contexts = [host(p) for p in paths]
    base = (1, 256, 2, 32, 64, 1, 16, True, 0.1)
    checked = []
    forms = [tuple(base), tuple(float(v) for v in base[:7])+base[7:],
        tuple(str(v) for v in base[:7])+base[7:],
        tuple(np.int64(v) for v in base[:7])+base[7:],
        tuple(np.array([v]) for v in base[:7])+base[7:],
        tuple(torch.tensor(v) for v in base[:7])+(torch.tensor(True), torch.tensor(0.1))]
    for cycle in range(3):
        for form in forms if cycle % 2 == 0 else reversed(forms):
            values = tuple((cycle, i) for i in range(5))
            with warnings.catch_warnings():
                warnings.simplefilter("ignore", DeprecationWarning)
                for namespace, _, _ in contexts:
                    namespace["run_kernel"](*values, *form)
            assert contexts[0][2] == contexts[1][2]
            for key in contexts[1][0]["_KERNEL_CACHE"]:
                assert isinstance(key, tuple)
                assert all(type(x) in (str, int, bool, float, type(None)) for x in key), key
            checked.append(dict(kind="scalar_form", cycle=cycle, scalar_types=[type(x).__name__ for x in form]))
        if cycle == 1:
            for namespace, _, _ in contexts:
                namespace["_KERNEL_CACHE"].clear()
    # These objects keep the same identity while their numerical values change.
    b, scale = torch.tensor(1), torch.tensor(0.1)
    for value, factor in ((1, 0.1), (2, -0.1), (1, 0.0), (3, 0.03125), (2, 0.1)):
        b.fill_(value)
        scale.fill_(factor)
        form = (b, *base[1:8], scale)
        for namespace, _, _ in contexts:
            namespace["run_kernel"](*(None,)*5, *form)
        assert contexts[0][2] == contexts[1][2]
        checked.append(dict(kind="same_object_scalar_update", batch=value, scale=factor))
    with Path(args.output).open("x") as file:
        json.dump(dict(status="PASS", sources={str(p):hashlib.sha256(p.read_bytes()).hexdigest() for p in paths},
                       checked=checked, tensor_or_address_keys_stored=False, gpu_execution=False), file, indent=2)
        file.write("\n")
    print("PASS", len(checked), "scalar normalization and mutation checks")


if __name__ == "__main__":
    main()
