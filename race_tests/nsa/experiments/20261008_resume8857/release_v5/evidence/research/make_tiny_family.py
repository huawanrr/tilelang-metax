"""Neighboring small-grid cases and wider dispatch probe for the new schedule."""
import ast
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
cases = {}
for dim in (32, 64, 128):
    for batch, length, heads in ((1, 16, 1), (1, 32, 1), (1, 48, 1), (1, 64, 1),
        (1, 96, 1), (1, 128, 1), (1, 192, 1), (1, 256, 1), (1, 384, 1),
        (1, 512, 1), (1, 1024, 1), (2, 64, 1), (2, 96, 1), (2, 128, 1),
        (1, 64, 2), (1, 128, 2), (1, 256, 2), (2, 256, 2)):
        for causal in (True, False):
            name = f"tiny_d{dim}_b{batch}_t{length}_h{heads}_c{int(causal)}"
            cases[name] = dict(B=batch, SEQ_LEN=length, H=heads, HQ=heads * 16,
                D=dim, S=1, block_size=16, is_causal=causal)
(HERE / "tiny_family_cases.json").write_text(json.dumps(cases, indent=2) + "\n")
source = (HERE / "tiny_qsync.py").read_text()
before = "    oct8_direct = oct8_complete and ((D == 32 and grid <= 192) or (D == 64 and grid <= 256 and (grid <= 128 or seq_len >= 128)))"
after = "    oct8_direct = oct8_complete and D in (32, 64, 128) and grid <= 1024"
assert source.count(before) == 1
source = source.replace(before, after)
ast.parse(source)
with (HERE / "qsync_wide_direct.py").open("x") as file:
    file.write(source)
print(len(cases), "family cases; qsync_wide_direct.py")
