"""Probe relying on the existing checked adapter for already-valid indices.

Conversion still runs on every call that needs it. The probe is unvalidated:
actual dtype/stride rejection and graph capture must be checked before adoption.
"""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def main():
    source = (HERE / "baseline.py").read_text()
    result = source
    for index, q, k, v, indent in (("BlockIndices", "Q", "K", "V", "        "),
                                  ("block_indices", "q", "k", "v", "    ")):
        conversion = (f"if {index}.dtype != torch.int32:\n"
                      f"    {index} = {index}.to(torch.int32)\n"
                      f"if not {index}.is_contiguous():\n"
                      f"    {index} = {index}.contiguous()\n")
        call = f"kernel({q}, {k}, {v}, {index}, output)\n"
        before = "".join(indent + line for line in (conversion + call).splitlines(keepends=True))
        after = "try:\n    " + call
        after += ("except Exception:\n"
                  f"    if {index}.dtype == torch.int32 and {index}.is_contiguous():\n"
                  "        raise\n")
        after += "".join("    " + line for line in (conversion + call).splitlines(keepends=True))
        after = "".join(indent + line for line in after.splitlines(keepends=True))
        assert result.count(before) == 1, index
        result = result.replace(before, after, 1)
    old = {n.name:ast.dump(n) for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    new = {n.name:ast.dump(n) for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
    assert {name for name in old if old[name] != new[name]} == {"run_kernel", "native_sparse_attention"}
    path = HERE / "checked_fast_input.py"
    with path.open("x") as out:
        out.write(result)
    with (HERE / "checked_fast_input_manifest.json").open("x") as out:
        json.dump(dict(file=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                       parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       device_builders_and_dispatch_unchanged=True,
                       status="unvalidated checked-adapter probe"), out, indent=2)
        out.write("\n")
    print(path)


if __name__ == "__main__":
    main()
