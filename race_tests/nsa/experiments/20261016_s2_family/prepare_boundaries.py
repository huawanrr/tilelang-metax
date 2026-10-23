"""Add neighboring shapes without changing the earlier family protocol."""
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
cases = json.loads((HERE / "cases.json").read_text())
base = cases["oj10"]
for length in (112, 127, 129, 208, 400, 448, 496, 511):
    cases[f"s2_b1_t{length}"] = dict(base, SEQ_LEN=length)
for batch, length in ((2, 64), (2, 96), (2, 240), (3, 128),
                      (3, 160), (4, 112), (7, 64), (8, 64)):
    cases[f"s2_b{batch}_t{length}"] = dict(base, B=batch, SEQ_LEN=length)
with (HERE / "boundary_cases.json").open("x") as out:
    json.dump(cases, out, indent=2)
    out.write("\n")
print("Prepared 16 additional S2 boundary/batch cases")
