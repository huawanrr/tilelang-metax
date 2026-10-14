"""Materialize K/V values so aggregate copies can be promoted to registers."""
import ast
import hashlib
import json
from pathlib import Path

from make_register_qk import function, once


HERE = Path(__file__).resolve().parent
BASE = HERE / "coalesced_block_view_local.py"


def main():
    source = BASE.read_text()
    original = function(source, "_coalesced_block_view_prim")
    records = []
    for label, width, fp32 in (("fp32", None, True), ("copy2", 2, False),
                               ("copy4", 4, False)):
        part = original
        if fp32:
            for name, dim in (("K_reg", "BK"), ("V_reg", "BV")):
                part = once(part, f"{name} = T.alloc_fragment([BS, {dim}], T.float16)",
                            f"{name} = T.alloc_fragment([BS, {dim}], T.float32)")
                part = once(part, f" = {name}[j, d]\n",
                            f" = T.Cast(T.float16, {name}[j, d])\n")
        if width:
            for name in ("K_reg", "V_reg"):
                part = once(part, f"], {name})", f"], {name}, coalesced_width={width})")
        result = once(source, original, part)
        ast.parse(result)
        path = HERE / f"coalesced_block_view_{label}.py"
        assert not path.exists(), path
        path.write_text(result)
        records.append(dict(path=path.name, sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                            fp32_staging=fp32, copy_width=width))
        print(path.name)
    (HERE / "block_view_staging_assembly.json").write_text(json.dumps(dict(
        baseline=BASE.name, baseline_sha256=hashlib.sha256(BASE.read_bytes()).hexdigest(),
        variants=records,
        hypothesis="Prevent unpromoted LLVM memcpy between global/private/shared storage; fp16-fp32-fp16 staging preserves finite fp16 values"),
        indent=2) + "\n")


if __name__ == "__main__":
    main()
