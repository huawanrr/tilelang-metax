"""Check narrower PV tiles and wider contiguous Q transfer on the new pair."""
import ast
import copy
import hashlib
import json
from pathlib import Path

from make_window_pairs import ATTENTION

HERE = Path(__file__).resolve().parent


def main():
    target = ATTENTION + "_window_pairs"
    records = []
    variants = [("row_w32_q4", "window_row_pairs_w64.py", 32, 4),
                ("row_w64_q8", "window_row_pairs_w64.py", 64, 8),
                ("row_w32_q8", "window_row_pairs_w64.py", 32, 8),
                ("phases_q8", "window_pair_shared_phases.py", 128, 8)]
    for suffix, filename, width, vec in variants:
        parent = HERE / filename
        source = parent.read_text()
        functions = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
        fn = copy.deepcopy(functions[target])
        text = ast.unparse(fn)
        if vec == 8:
            assert text.count("(qi * D + qd) // 4 % 64") == 1
            assert text.count("(qi * D + qd) // 256 * 4 + qd % 4") == 1
            text = text.replace("(qi * D + qd) // 4 % 64", "(qi * D + qd) // 8 % 64")
            text = text.replace("(qi * D + qd) // 256 * 4 + qd % 4", "(qi * D + qd) // 512 * 8 + qd % 8")
        dispatch = copy.deepcopy(functions["_get_kernel"])
        calls = [n for n in ast.walk(dispatch) if isinstance(n, ast.Call) and isinstance(n.func, ast.Name) and n.func.id == target]
        assert len(calls) == 1
        next(k for k in calls[0].keywords if k.arg == "width").value = ast.Constant(width)
        old = functions[target]
        begin = min([old.lineno] + [d.lineno for d in old.decorator_list]) - 1
        lines = source.splitlines(keepends=True)
        lines[begin:old.end_lineno] = [text + "\n"]
        result = "".join(lines)
        result = result.replace(ast.get_source_segment(source, functions["_get_kernel"]), ast.unparse(ast.fix_missing_locations(dispatch)), 1)
        ast.parse(result)
        dest = HERE / f"window_final_{suffix}.py"
        with dest.open("x") as out:
            out.write(result)
        records.append(dict(file=dest.name, parent=parent.name, parent_sha256=hashlib.sha256(source.encode()).hexdigest(),
                            width=width, q_vector=vec, sha256=hashlib.sha256(result.encode()).hexdigest()))
    with (HERE / "window_final_tiles_manifest.json").open("x") as out:
        json.dump(dict(variants=records, pack_and_schedule_unchanged=True,
                       q_transfer="Contiguous linear ownership covers G*D elements exactly once",
                       fp32_mma_and_math_and_shared_synchronization_unchanged=True), out, indent=2)
        out.write("\n")
    print("Generated", len(records), "pair tile probes")


if __name__ == "__main__":
    main()
