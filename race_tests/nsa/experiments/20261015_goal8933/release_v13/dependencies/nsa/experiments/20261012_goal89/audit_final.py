"""Audit final submission bytes and the kernels actually used by each benchmark."""
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


def functions(path):
    tree = strip.no_docs(ast.parse(Path(path).read_text()))
    return {n.name: ast.dump(n) for n in tree.body if isinstance(n, ast.FunctionDef)}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", required=True)
    parser.add_argument("--timings", nargs="+", required=True)
    parser.add_argument("--host-timing", default=str(HERE / "public_fast_loop.json"))
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    manifest = json.loads(Path(args.manifest).read_text())
    paths = {name: Path(manifest[name]) for name in ("development", "submission", "parent", "baseline", "probe")}
    for name, path in paths.items():
        assert digest(path) == manifest[name + "_sha256"], name
    fns = {name: functions(path) for name, path in paths.items()}
    assert fns["development"] == fns["submission"] == fns["probe"]
    for name in manifest["unchanged_parent_functions"]:
        assert fns["parent"][name] == fns["submission"][name]
    for name in manifest["unchanged_v6_functions"]:
        assert fns["baseline"][name] == fns["submission"][name]
    assert [name for name in fns["parent"] if fns["parent"][name] != fns["submission"][name]] == ["run_kernel"]
    source = paths["submission"].read_text()
    assert not any(s in source for s in ("TL_DISABLE_DATA_RACE_CHECK", "TL_DISABLE_SAFE_MEMORY_ACCESS",
                                       "T.import_source", "T.call_extern", "maca_memcpy_async"))
    timings, cases = [], {}
    for filename in args.timings:
        data = json.loads(Path(filename).read_text())
        for path, expected in data["sha256"].items():
            assert digest(ROOT / path) == expected, path
        for row in data["rows"]:
            cases[json.dumps(row["config"], sort_keys=True)] = row["config"]
        timings.append((filename, data))
    for c in json.loads((HERE / "cases.json").read_text()).values():
        cases[json.dumps(c, sort_keys=True)] = c
    modules = {name: load_module(str(path)) for name, path in paths.items()}
    report = dict(status="running", command=sys.argv, manifest=args.manifest,
        manifest_sha256=digest(args.manifest), source_sha256={name:digest(path) for name,path in paths.items()},
        unchanged_parent_functions=manifest["unchanged_parent_functions"],
        unchanged_v6_functions=manifest["unchanged_v6_functions"], configurations=[], timings=[])
    output = Path(args.output)
    assert not output.exists()

    def save():
        output.write_text(json.dumps(report, indent=2)+"\n")

    save()
    cache = {}
    for key, cfg in cases.items():
        submitted, development, parent, probe, baseline = [compiled(modules[name], cfg)
            for name in ("submission", "development", "parent", "probe", "baseline")]
        assert submitted == development == parent == probe, cfg
        assert len(submitted) == len(baseline), (cfg, "kernel count")
        for actual, old in zip(submitted, baseline):
            for field in ("flags", "shared_bytes", "block_barriers", "wave_barriers", "pass_configs"):
                assert actual[field] == old[field], (cfg, field, actual[field], old[field])
        cache[key] = submitted
        report["configurations"].append(dict(config=cfg, submitted=submitted, baseline=baseline,
            identical_to_v9_gpu=True, identical_to_development_and_probe=True,
            changed_vs_v6=submitted != baseline, synchronization_shared_flags_and_safety_preserved=True))
        save()
        print("audit", len(cache), cfg, "PASS", flush=True)
    for filename, data in timings:
        names = list(data["sha256"])
        indices = [i for i,n in enumerate(names) if (ROOT / n).resolve() == paths["submission"].resolve()]
        assert len(indices) == 1, filename
        index = indices[0]
        for row in data["rows"]:
            actual = cache[json.dumps(row["config"], sort_keys=True)]
            assert [p["sha256"] for p in actual] == row["device_source_sha256"][index]
            assert [p["flags"] for p in actual] == row["compile_flags"][index]
            report["timings"].append(dict(file=filename, case=row["case"], seed=row["seed"],
                actual_submitted_and_timed_device_code_equal=True))
    # The host-loop probe must be the exact final bytes, not just an equivalent
    # source or an earlier candidate. Its device hashes are also retained.
    host_data = json.loads(Path(args.host_timing).read_text())
    assert digest(paths["submission"]) in host_data["sha256"].values()
    report["host_probe_byte_identical_to_submission"] = True
    report["status"] = "PASS"
    save()
    print("PASS", len(cache), "configurations", len(report["timings"]), "timing rows", flush=True)


if __name__ == "__main__":
    main()
