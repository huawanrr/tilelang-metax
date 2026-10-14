"""Match the actual submitted and timed kernels to their verified research probes."""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT / "experiments/20261008_resume8857"))
from audit_candidate_v5b import compiled, strip
from experiment_bench import load_module


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def expected_probe(c, options):
    n, d, h = c["SEQ_LEN"], c["D"], c["H"]
    grid = c["B"] * n * h
    if c["S"] != 1 or c["block_size"] != 16 or c["HQ"] != 16*h or n % 16:
        return "v7_parent.py"
    if d == 64 and n >= 128 and 512 <= grid < 2304:
        if h >= 2 and not c["is_causal"] and options["multihead_q4"]:
            return "q_vec4.py"
        if h == 1 and c["is_causal"] and options["mid"] != "none":
            return "reduce_independent.py" if options["mid"] == "independent" else "loads_vec4.py"
    if (d == 128 and grid >= 1280) or (d == 64 and n >= 128 and grid >= 2304 and c["is_causal"]):
        if d == 128 and options["d128"] == "parent":
            return "v7_parent.py"
        if d == 128 and options["d128"] != "same":
            return "loads_vec4.py" if options["d128"] == "vec4" else "large_boundary_exp_vec4.py"
        return "large_boundary_exp.py"
    return "v7_parent.py"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", required=True)
    parser.add_argument("--timings", nargs="+", required=True)
    parser.add_argument("--case-files", nargs="*", default=[])
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    manifest = json.loads(Path(args.manifest).read_text())
    out = Path(args.output)
    assert not out.exists()
    paths = {name: Path(manifest[name]) for name in ("development", "submission", "parent", "official_baseline")}
    for name, path in paths.items():
        assert digest(path) == manifest[name + "_sha256"]
    dev_tree = strip.no_docs(ast.parse(paths["development"].read_text()))
    assert ast.dump(dev_tree) == ast.dump(ast.parse(paths["submission"].read_text()))
    new = {n.name: n for n in dev_tree.body if isinstance(n, ast.FunctionDef)}
    for label in ("parent", "official_baseline"):
        old = {n.name: n for n in ast.parse(paths[label].read_text()).body if isinstance(n, ast.FunctionDef)}
        for name, fn in old.items():
            if name != "_get_kernel":
                assert ast.dump(fn) == ast.dump(new[name]), (label, name)
    source = paths["submission"].read_text()
    assert not any(token in source for token in ("TL_DISABLE_DATA_RACE_CHECK", "TL_DISABLE_SAFE_MEMORY_ACCESS", "T.call_extern", "import_source"))
    cases, timings = {}, []
    for filename in args.case_files:
        data = json.loads(Path(filename).read_text())
        for c in data.values() if isinstance(data, dict) else data:
            cases[json.dumps(c, sort_keys=True)] = c
    for filename in args.timings:
        data = json.loads(Path(filename).read_text())
        for name, value in data["sha256"].items():
            assert digest(ROOT / name) == value
        for row in data["rows"]:
            cases[json.dumps(row["config"], sort_keys=True)] = row["config"]
        timings.append((filename, data))
    modules = {}

    def module(path):
        path = str(path)
        if path not in modules:
            modules[path] = load_module(path)
        return modules[path]

    report = dict(status="running", command=sys.argv, manifest=args.manifest,
        manifest_sha256=digest(args.manifest), source_sha256={k: digest(p) for k,p in paths.items()},
        unchanged_v6_functions=manifest["unchanged_v6_functions"],
        unchanged_parent_functions=manifest["unchanged_parent_functions"],
        appended_functions=manifest["appended_functions"], configurations=[], timings=[])
    cache = {}

    def save():
        out.write_text(json.dumps(report, indent=2) + "\n")

    for key, cfg in cases.items():
        expected_path = HERE / expected_probe(cfg, manifest["options"])
        actual = compiled(module(paths["submission"]), cfg)
        development = compiled(module(paths["development"]), cfg)
        expected = compiled(module(expected_path), cfg)
        original = compiled(module(paths["official_baseline"]), cfg)
        assert actual == development == expected, (cfg, str(expected_path))
        assert len(actual) == len(original), (cfg, "extra kernel launch")
        for a, b in zip(actual, original):
            for field in ("flags", "shared_bytes", "block_barriers", "wave_barriers", "pass_configs"):
                assert a[field] == b[field], (cfg, field, a[field], b[field])
        cache[key] = actual
        report["configurations"].append(dict(config=cfg, expected_probe=str(expected_path),
            submitted=actual, baseline=original, changed_vs_v6=actual != original,
            development_submission_probe_equal=True, safety_and_synchronization_preserved=True))
        save()
        print(len(cache), expected_path.name, cfg, "PASS", flush=True)
    for filename, data in timings:
        names = list(data["sha256"])
        matching = [i for i, n in enumerate(names) if (ROOT / n).resolve() == paths["submission"].resolve()]
        assert matching, (filename, "actual submission not timed")
        for row in data["rows"]:
            actual = cache[json.dumps(row["config"], sort_keys=True)]
            for i in matching:
                assert [p["sha256"] for p in actual] == row["device_source_sha256"][i]
                assert [p["flags"] for p in actual] == row["compile_flags"][i]
            report["timings"].append(dict(file=filename, case=row["case"], seed=row["seed"],
                                          actual_timed_device_source_and_flags_equal=True))
    report["status"] = "PASS"
    save()
    print("PASS", len(cache), "configurations", len(report["timings"]), "timings", flush=True)


if __name__ == "__main__":
    main()
