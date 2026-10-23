"""Select a conservative S2 family and retain the original builder elsewhere."""
import ast
import copy
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
PARENT = HERE.parent / "20261016_goal895/release_v14/submission.py"
PROBE = HERE / "wave_output.py"
OLD_NAME = "native_sparse_attention_short_list_oct8_sum_v11"
NEW_NAME = "native_sparse_attention_short_list_oct8_wave_output_v15"


def functions(source):
    return {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    assert sha(PARENT) == "d3c4e9f7417069efc0a0189d5754d4f8e765034c848c2219d32e869dd3b22080"
    assembly = json.loads((HERE / "assembly.json").read_text())
    assert sha(PROBE) == next(r["sha256"] for r in assembly["variants"] if r["file"] == PROBE.name)
    source = PARENT.read_text()
    original = functions(source)
    builder = copy.deepcopy(functions(PROBE.read_text())[OLD_NAME])
    builder.name = NEW_NAME
    dispatch = copy.deepcopy(original["_get_kernel"])
    key_assignment = next(n for n in dispatch.body if isinstance(n, ast.Assign)
                          and isinstance(n.targets[0], ast.Name) and n.targets[0].id == "key")
    assert isinstance(key_assignment.value, ast.Tuple)
    key_assignment.value.elts.append(ast.Name(id="s2_wave_output", ctx=ast.Load()))
    index = dispatch.body.index(key_assignment)
    dispatch.body[index:index] = ast.parse("""
s2_wave_output = (oct8_short and H == 1 and seq_len % block_size == 0
                  and 256 <= grid <= 384)
""").body
    branch = next(n for n in ast.walk(dispatch) if isinstance(n, ast.If)
                  and ast.unparse(n.test) == "oct8_short")
    assert len(branch.body) == 1
    old_call = branch.body[0]
    assert isinstance(old_call, ast.Assign) and isinstance(old_call.value, ast.Call)
    old_selection = old_call.value.func
    assert isinstance(old_selection, ast.IfExp)
    branch.body = ast.parse(
        f"short_builder = {NEW_NAME} if s2_wave_output else ({ast.unparse(old_selection)})"
    ).body + [old_call]
    old_call.value.func = ast.Name(id="short_builder", ctx=ast.Load())
    original_dispatch = ast.get_source_segment(source, original["_get_kernel"])
    replacement = (ast.unparse(ast.fix_missing_locations(builder)) + "\n\n" +
                   ast.unparse(ast.fix_missing_locations(dispatch)))
    assert source.count(original_dispatch) == 1
    candidate = source.replace(original_dispatch, replacement, 1)
    updated = functions(candidate)
    assert set(updated) - set(original) == {NEW_NAME}
    assert {name for name in original if ast.dump(original[name]) != ast.dump(updated[name])} == {"_get_kernel"}
    restored = copy.deepcopy(updated[NEW_NAME])
    restored.name = OLD_NAME
    assert ast.dump(restored) == ast.dump(functions(PROBE.read_text())[OLD_NAME])
    path = HERE / "candidate_s2.py"
    with path.open("x") as out:
        out.write(candidate)
    cases = json.loads((HERE / "boundary_cases.json").read_text())
    all_oj = json.loads((HERE.parent / "20261016_s8_phases/cases.json").read_text())
    cases.update({name: config for name, config in all_oj.items() if name.startswith("oj")})
    base = cases["oj10"]
    for batch, lengths in (
        (1, (240, 255, 256, 257, 272, 288, 304, 320, 336, 352, 368, 383, 384, 385, 400)),
        (2, (112, 127, 128, 129, 144, 160, 176, 191, 192, 193, 208)),
        (3, (80, 96, 112, 128, 144)),
        (4, (64, 80, 96, 112)), (5, (64, 80)), (6, (64, 80)),
    ):
        for length in lengths:
            cases[f"s2_b{batch}_t{length}"] = dict(base, B=batch, SEQ_LEN=length)
    cases["s2_b2_t128_c0"] = dict(base, B=2, SEQ_LEN=128, is_causal=False)
    cases["s2_b3_t128_c0"] = dict(base, B=3, SEQ_LEN=128, is_causal=False)
    with (HERE / "candidate_cases.json").open("x") as out:
        json.dump(cases, out, indent=2)
        out.write("\n")
    with (HERE / "candidate_manifest.json").open("x") as out:
        json.dump(dict(status="unvalidated candidate", parent=str(PARENT), parent_sha256=sha(PARENT),
                       candidate=path.name, candidate_sha256=sha(path),
                       probe=PROBE.name, probe_sha256=sha(PROBE), new_builder=NEW_NAME,
                       scope="Existing default S2, H1, G16, D64, BS16, complete blocks, 256 <= B*H*T <= 384",
                       changes="Add an exact copy of screened builder, select it only in the stated family, include the selection in the normalized cache key",
                       all_original_builders_unchanged=True, public_interfaces_unchanged=True,
                       explicit_fallbacks_unchanged=True), out, indent=2)
        out.write("\n")
    print("Prepared candidate", sha(path), "and", len(cases), "validation configurations")


if __name__ == "__main__":
    main()
