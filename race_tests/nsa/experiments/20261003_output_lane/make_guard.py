"""Generate raw-block guards for the large D32 builder in two probes."""
import ast
import hashlib
import json
from pathlib import Path


HERE = Path(__file__).resolve().parent
NAME = "native_sparse_attention_d32_shuffle"


def transform(source):
    nodes = {n.name: n for n in ast.parse(source).body if isinstance(n, ast.FunctionDef)}
    fn = nodes[NAME]
    lines = source.splitlines(keepends=True)
    start = min([fn.lineno] + [x.lineno for x in fn.decorator_list]) - 1
    block = "".join(lines[start:fn.end_lineno])
    old = "            i_s = BlockIndices[i_b, i_t, i_h, 0] * BS\n"
    assert block.count(old) == 1
    block = block.replace(old, "            selected_block = BlockIndices[i_b, i_t, i_h, 0]\n")
    old = "            if i_s >= 0 and i_s < seq_len and (not is_causal or i_s <= i_t):\n"
    assert block.count(old) == 1
    block = block.replace(old,
        "            if selected_block >= 0 and selected_block < T.ceildiv(seq_len, BS) and (not is_causal or selected_block <= i_t // BS):\n"
        "                i_s = selected_block * BS\n")
    result = "".join(lines[:start]) + block + "".join(lines[fn.end_lineno:])
    after = {n.name: n for n in ast.parse(result).body if isinstance(n, ast.FunctionDef)}
    assert all(ast.dump(nodes[n]) == ast.dump(after[n]) for n in nodes if n != NAME)
    return result


def main():
    records = []
    for parent, name in (("reference_d128.py", "guard_only_d32.py"),
                         ("output_lane_d32.py", "output_lane_guard_d32.py")):
        result = transform((HERE / parent).read_text())
        path = HERE / name
        if path.exists():
            assert path.read_text() == result
        else:
            with path.open("x") as output:
                output.write(result)
        records.append(dict(path=name, parent=parent,
            sha256=hashlib.sha256(path.read_bytes()).hexdigest(), changed_function=NAME))
    record = HERE / "guard_assembly.json"
    if record.exists():
        assert json.loads(record.read_text()) == records
    else:
        with record.open("x") as output:
            json.dump(records, output, indent=2)
    print("PASS: both generated guards match their recorded sources")


if __name__ == "__main__":
    main()
