"""Check the old D128 benchmark parent selects identical builders and arguments."""

import argparse
import ast
import hashlib
import json
from pathlib import Path
from types import SimpleNamespace


ROOT = Path(__file__).resolve().parents[2]


def inspect_dispatch(path):
    functions = {node.name: node for node in ast.parse(path.read_text()).body
                 if isinstance(node, ast.FunctionDef)}

    def record(name):
        def call(*args, **kwargs):
            return dict(builder=name, args=args, kwargs=kwargs)
        return call

    env = {name: record(name) for name in functions}
    env["tilelang"] = SimpleNamespace(math=SimpleNamespace(next_power_of_2=lambda n: 1 << (n - 1).bit_length()))
    env["_KERNEL_CACHE"] = {}
    exec(compile(ast.Module(body=[functions["_get_kernel"]], type_ignores=[]), str(path), "exec"), env)
    return functions, env["_get_kernel"]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--directory", required=True)
    args = parser.parse_args()
    directory = Path(args.directory)
    config = json.loads((directory / "assembly.json").read_text())["config"]
    paths = [ROOT / "experiments/20261002_mid_v1/nsa.py", ROOT / "experiments/20261002_d128_mid/reference_output.py"]
    inspected = [inspect_dispatch(path) for path in paths]
    retained = [name for name in inspected[0][0] if name != "_get_kernel"]
    assert len(retained) == 44
    assert all(ast.dump(inspected[0][0][name]) == ast.dump(inspected[1][0][name]) for name in retained)
    cases = {}
    for name in config["bracket_reports"]:
        for row in json.loads((ROOT / name).read_text())["rows"]:
            cases[row["case"]] = row["config"]
    rows = []
    for name, case in cases.items():
        assert case["D"] == 128
        call = (case["B"], case["SEQ_LEN"], case["H"], case["HQ"], case["D"], case["S"],
                case["block_size"], case["is_causal"], 0.1)
        choices = [dispatch(*call) for _, dispatch in inspected]
        assert choices[0] == choices[1], name
        rows.append(dict(case=name, config=case, identical_dispatch=True, selection=choices[0]))
    report = dict(status="PASS", method="Execute the original host dispatch with builder-recording stand-ins; compare all arguments and unchanged builder ASTs",
        unchanged_functions=retained,
        source_sha256={str(path.relative_to(ROOT)): hashlib.sha256(path.read_bytes()).hexdigest() for path in paths}, rows=rows)
    (directory / "parent_dispatch_audit.json").write_text(json.dumps(report, indent=2) + "\n")
    print("PASS", len(rows), "D128 parent dispatches and", len(retained), "unchanged functions")


if __name__ == "__main__":
    main()
