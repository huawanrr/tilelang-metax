"""Select existing coalesced builders in the measured small-grid families."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
PREDICATE = """    small_coalesced_blocks = (
        mathcast_defaults and S == 1 and groups == 16 and block_size == 16
        and seq_len % block_size == 0
        and ((D == 128 and 128 <= grid < 1280) or (D == 64 and 256 <= grid < 512))
    )
"""


def main():
    source = (HERE / "baseline.py").read_text()
    assert hashlib.sha256(source.encode()).hexdigest() == "49c5e4b40ba926ef0d9d687760a520306ccde4bc82b077907a5b3568b918b2ea"
    result = source
    anchor = "    tiny_vfirst = preload_direct and D == 32\n"
    assert result.count(anchor) == 1
    result = result.replace(anchor, anchor + PREDICATE, 1)
    old = "fp32_large, fp32_multih, tiny_vfirst)\n"
    assert result.count(old) == 1
    result = result.replace(old, "fp32_large, fp32_multih, tiny_vfirst, small_coalesced_blocks)\n", 1)
    old = "        if preload_direct:\n"
    assert result.count(old) == 1
    result = result.replace(old, """        if small_coalesced_blocks:
            kernel = native_sparse_attention_coalesced_blocks_boundary_v8(q_vec=8, pv_width=128, **common)
        elif preload_direct:
""", 1)
    trees = [ast.parse(text) for text in (source, result)]
    functions = [{fn.name: ast.dump(fn, include_attributes=False)
                  for fn in tree.body if isinstance(fn, ast.FunctionDef)} for tree in trees]
    assert functions[0].keys() == functions[1].keys()
    changed = [name for name in functions[0] if functions[0][name] != functions[1][name]]
    assert changed == ["_get_kernel"]
    assert [ast.dump(n) for n in trees[0].body if not isinstance(n, ast.FunctionDef)] == [
        ast.dump(n) for n in trees[1].body if not isinstance(n, ast.FunctionDef)]
    compile(result, "candidate_dispatch_r1", "exec")
    path = HERE / "candidate_dispatch_r1.py"
    with path.open("x") as out:
        out.write(result)
    report = dict(file=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                  parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                  changed_functions=changed, unchanged_functions=len(functions[0])-1,
                  predicate=PREDICATE, normalized_cache_flag="small_coalesced_blocks",
                  builder="native_sparse_attention_coalesced_blocks_boundary_v8",
                  builder_parameters=dict(q_vec=8, pv_width=128),
                  status="candidate awaiting final validation")
    with (HERE / "candidate_dispatch_r1_manifest.json").open("x") as out:
        json.dump(report, out, indent=2)
        out.write("\n")
    print(path, report["sha256"])


if __name__ == "__main__":
    main()
