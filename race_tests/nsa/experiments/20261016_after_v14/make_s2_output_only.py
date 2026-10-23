"""Isolate coalesced output while retaining the baseline automatic barriers."""
import ast
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
NAME = "native_sparse_attention_short_list_oct8_sum_v11"


def main():
    source = (HERE / "baseline.py").read_text()
    fn = next(n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef) and n.name == NAME)
    original = ast.get_source_segment(source, fn)
    old = "            T.copy(O_cast, Output[i_b, i_t, i_h * G:(i_h + 1) * G, i_v * BV:(i_v + 1) * BV])\n"
    new = '''            O_shared = T.alloc_shared([G, BV], T.float16)
            T.annotate_layout({O_shared: tilelang.maca.intrinsics.make_mma_swizzle_layout(O_shared, vecSize=8)})
            T.sync_warp()
            T.copy(O_cast, O_shared)
            T.sync_warp()
            T.copy(O_shared, Output[i_b, i_t, i_h * G:(i_h + 1) * G, i_v * BV:(i_v + 1) * BV])
'''
    assert original.count(old) == 1
    result = source.replace(original, original.replace(old, new, 1), 1)
    compile(result, "s2_output_only", "exec")
    path = HERE / "s2_output_only.py"
    with path.open("x") as out:
        out.write(result)
    with (HERE / "s2_output_only_manifest.json").open("x") as out:
        json.dump(dict(file=path.name, sha256=hashlib.sha256(result.encode()).hexdigest(),
                       parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                       changed_function=NAME, automatic_barriers_unchanged=True,
                       floating_math_unchanged=True, status="untested probe"), out, indent=2)
        out.write("\n")
    print(path)


if __name__ == "__main__":
    main()
