"""Mechanism boundaries and unseen batch/head decompositions for confirmation."""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
groups = {
    "d128": (128, 1, [(1, n, 1) for n in (16, 32, 48, 64, 96, 128, 144, 160)] +
        [(2, 32, 1), (2, 64, 1), (2, 80, 1), (1, 32, 2), (1, 64, 2),
         (1, 80, 2), (4, 16, 1), (4, 32, 1), (1, 16, 4), (1, 32, 4)]),
    "d32": (32, 1, [(1, n, 1) for n in (16, 32, 48, 64, 80, 96)] +
        [(2, 16, 1), (2, 32, 1), (2, 48, 1), (1, 16, 2), (1, 32, 2),
         (1, 48, 2), (4, 16, 1), (1, 16, 4)]),
    "s2": (64, 2, [(1, n, 1) for n in (63, 64, 65, 96, 128, 129, 192, 256,
        512, 1024, 1025)] + [(2, 64, 1), (2, 128, 1), (2, 256, 1), (2, 512, 1),
        (1, 128, 2), (1, 256, 2), (1, 512, 2), (1, 128, 4), (4, 128, 1),
        (1, 256, 3)]),
}
for prefix, (dim, selected, shapes) in groups.items():
    result = {}
    for batch, length, heads in shapes:
        for causal in (True, False):
            name = f"{prefix}_b{batch}_t{length}_h{heads}_c{int(causal)}"
            result[name] = dict(B=batch, SEQ_LEN=length, H=heads, HQ=heads * 16,
                D=dim, S=selected, block_size=16, is_causal=causal)
    with (HERE / f"{prefix}_confirmation_cases.json").open("x") as file:
        file.write(json.dumps(result, indent=2) + "\n")
    print(prefix, len(result))
