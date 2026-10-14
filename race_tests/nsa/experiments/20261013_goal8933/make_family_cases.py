"""Shape families for current D64 V-lifetime probes; no input-value dispatch."""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
shapes = [
    (1, 512, 1), (1, 768, 1), (1, 1024, 1), (1, 1536, 1),
    (1, 2048, 1), (1, 3072, 1), (1, 4096, 1), (1, 6144, 1), (1, 8192, 1),
    (2, 256, 1), (2, 512, 1), (2, 1024, 1), (2, 2048, 1),
    (4, 1024, 1), (8, 512, 1),
    (1, 256, 2), (1, 512, 2), (1, 768, 2), (1, 1024, 2), (1, 2048, 2),
    (1, 256, 3), (1, 512, 3), (1, 128, 4), (1, 256, 4), (1, 512, 4),
    (2, 256, 2), (2, 512, 2),
]
cases = {}
for batch, length, kv_heads in shapes:
    for causal in (True, False):
        name = f"b{batch}_t{length}_h{kv_heads}_c{int(causal)}"
        cases[name] = dict(B=batch, SEQ_LEN=length, H=kv_heads, HQ=16 * kv_heads,
                           D=64, S=1, block_size=16, is_causal=causal)
with (HERE / "v_lifetime_cases.json").open("x") as file:
    json.dump(cases, file, indent=2)
    file.write("\n")
with (HERE / "v_lifetime_case_ids.txt").open("x") as file:
    file.write(",".join(cases) + "\n")
print("Generated", len(cases), "D64 family shapes")
