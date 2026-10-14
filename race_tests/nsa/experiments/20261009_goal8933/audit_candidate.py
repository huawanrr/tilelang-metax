"""Verify appended paths, old-builder preservation, and actual measured device code."""
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


def selected_component(c, components):
    n, d, h = c["SEQ_LEN"], c["D"], c["H"]
    grid = c["B"] * h * n
    if c["S"] != 1 or c["block_size"] != 16 or c["HQ"] != 16*h or n % 16:
        return "parent"
    if "tiny" in components and d == 32 and n >= 64 and grid <= 64 and c["is_causal"]:
        return "tiny"
    if "multihead" in components and d == 64 and h >= 2 and n >= 128 and 512 <= grid < 2304:
        return "multihead"
    if "large" in components and ((d == 128 and grid >= 1280) or
                                  (d == 64 and n >= 128 and grid >= 2304 and c["is_causal"])):
        return "large"
    return "parent"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", required=True)
    parser.add_argument("--case-files", nargs="*", default=[])
    parser.add_argument("--timings", nargs="*", default=[])
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    manifest = json.loads(Path(args.manifest).read_text())
    output = Path(args.output)
    assert not output.exists()
    paths = [Path(manifest[k]) for k in ("development", "submission", "parent")]
    for path, key in zip(paths, ("development_sha256", "submission_sha256", "parent_sha256")):
        assert digest(path) == manifest[key]
    dev_tree = strip.no_docs(ast.parse(paths[0].read_text()))
    sub_tree = ast.parse(paths[1].read_text())
    assert ast.dump(dev_tree) == ast.dump(sub_tree)
    old = {n.name: n for n in strip.no_docs(ast.parse(paths[2].read_text())).body if isinstance(n, ast.FunctionDef)}
    new = {n.name: n for n in dev_tree.body if isinstance(n, ast.FunctionDef)}
    kept = [name for name in old if name != "_get_kernel"]
    for name in kept:
        assert ast.dump(old[name]) == ast.dump(new[name]), name
    assert sorted(set(new)-set(old)) == sorted(manifest["appended_functions"])
    source = paths[0].read_text()
    assert not any(x in source for x in ("TL_DISABLE_DATA_RACE_CHECK", "TL_DISABLE_SAFE_MEMORY_ACCESS", "T.call_extern"))
    probes = dict(parent=HERE / "parent.py", tiny=HERE / "small_vfirst.py",
                  multihead=HERE / "fp32_mask_post.py", large=HERE / "fp32_core.py")
    modules = {str(path): load_module(str(path)) for path in set(paths + list(probes.values()))}
    cases = {}
    for filename in args.case_files:
        data = json.loads(Path(filename).read_text())
        for cfg in (data.values() if isinstance(data, dict) else data):
            cases[json.dumps(cfg, sort_keys=True)] = cfg
    timings = []
    for filename in args.timings:
        data = json.loads(Path(filename).read_text())
        for path, expected in data["sha256"].items():
            assert digest(ROOT / path) == expected, path
        for row in data["rows"]:
            cases[json.dumps(row["config"], sort_keys=True)] = row["config"]
        timings.append((filename, data))
    report = dict(status="running", command=sys.argv, manifest=args.manifest,
                  manifest_sha256=digest(args.manifest), kept_functions=kept,
                  appended_functions=manifest["appended_functions"], configurations=[], timings=[])
    cache = {}
    for key, cfg in cases.items():
        component = selected_component(cfg, manifest["components"])
        expected_path = probes[component]
        development, submission = [compiled(modules[str(p)], cfg) for p in paths[:2]]
        expected = compiled(modules[str(expected_path)], cfg)
        assert development == submission == expected, (cfg, component, "actual device source mismatch")
        original = compiled(modules[str(paths[2])], cfg)
        if component == "parent":
            assert submission == original
        else:
            assert submission != original
            assert len(submission) == len(original)
            for new_part, old_part in zip(submission, original):
                for field in ("flags", "shared_bytes", "block_barriers", "wave_barriers", "pass_configs"):
                    assert new_part[field] == old_part[field], (cfg, field)
        cache[key] = submission
        report["configurations"].append(dict(config=cfg, component=component,
            expected_probe=str(expected_path), submitted=submission, parent=original,
            development_submission_and_probe_equal=True))
        output.write_text(json.dumps(report, indent=2)+"\n")
        print(len(cache), component, cfg, "PASS", flush=True)
    for filename, data in timings:
        names = list(data["sha256"])
        matching = [i for i, name in enumerate(names) if (ROOT / name).resolve() in paths[:2]]
        assert matching, (filename, "actual candidate absent")
        for row in data["rows"]:
            parts = cache[json.dumps(row["config"], sort_keys=True)]
            for i in matching:
                assert [v["sha256"] for v in parts] == row["device_source_sha256"][i]
                assert [v["flags"] for v in parts] == row["compile_flags"][i]
            report["timings"].append(dict(file=filename, case=row["case"], seed=row["seed"],
                                          actual_timed_sources_equal=True))
    report["status"] = "PASS"
    output.write_text(json.dumps(report, indent=2)+"\n")
    print("PASS", len(cache), "configurations,", len(report["timings"]), "timings", flush=True)


if __name__ == "__main__":
    main()
