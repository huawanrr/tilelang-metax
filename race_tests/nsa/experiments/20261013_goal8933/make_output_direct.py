"""Current scalar-cast paths with direct four-half MMA-layout output stores."""
import ast
import hashlib
import json
from pathlib import Path

from make_output_exchange import COALESCED, PACKED, ONLINE

HERE = Path(__file__).resolve().parent
source = (HERE / "baseline.py").read_text()
result = source
changed = []
for fn in ast.parse(source).body:
    if not isinstance(fn, ast.FunctionDef) or fn.name not in COALESCED | ONLINE | {PACKED}:
        continue
    old = ast.get_source_segment(source, fn)
    new = old
    if fn.name in COALESCED:
        start = new.index("            O_shared = T.alloc_shared")
        code = "            T.copy(O_reg, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])\n"
    elif fn.name == PACKED:
        start = new.index("            output_shared = T.alloc_shared")
        code = "            T.copy(output_reg, Output[b, token, h * G:(h + 1) * G, :])\n"
    else:
        new = new.replace("            O_shared = T.alloc_shared([G, BV], T.float16)\n", "", 1)
        new = new.replace("                O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8),\n", "", 1)
        start = new.index("            T.copy(O_reg, O_shared)")
        code = "            T.copy(O_reg, Output[i_b, i_t, i_h * G:(i_h + 1) * G, :])\n"
    end = new.rindex("\n    return kernel")
    new = new[:start] + code + new[end:]
    result = result.replace(old, new, 1)
    changed.append(fn.name)
assert len(changed) == 8
ast.parse(result)
path = HERE / "output_direct4.py"
with path.open("x") as file:
    file.write(result)
(HERE / "output_direct_manifest.json").write_text(json.dumps(dict(
    path=str(path), sha256=hashlib.sha256(result.encode()).hexdigest(), changed=changed,
    baseline_sha256=hashlib.sha256(source.encode()).hexdigest(),
    note="Original MMA fragment ownership and scalar conversion; direct uint2 stores, no output shared stage"), indent=2) + "\n")
print(path.name)
