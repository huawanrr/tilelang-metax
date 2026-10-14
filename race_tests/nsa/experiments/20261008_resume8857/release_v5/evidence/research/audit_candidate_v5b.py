"""Audit final sources, dispatch scope, and the device code actually timed."""
import argparse
import ast
import hashlib
import importlib.util
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from experiment_bench import load_module
from verify_candidate import parts, prior, shape

spec = importlib.util.spec_from_file_location(
    "resume_strip_helpers", ROOT / "experiments/20261007_exp_math/make_submission.py")
strip = importlib.util.module_from_spec(spec)
spec.loader.exec_module(strip)

BASELINE = ROOT / "experiments/20261008_goal895/release_v4/nsa.py"
BASELINE_SHA256 = "06d69bab6089e3ac11f9cca58804b9ccdc505e2913f019a5ee31b85f811b67fc"


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def direct_scope(c):
    if c["HQ"] != 16 * c["H"] or c["block_size"] != 16:
        return False
    n, d, s = c["SEQ_LEN"], c["D"], c["S"]
    grid = c["B"] * c["H"] * n
    return s == 1 and n % 16 == 0 and (
        (d == 32 and n >= 64 and grid <= 64 and c["is_causal"])
        or (d == 64 and grid <= 256 and (grid <= 128 or n >= 128))
        or (d == 128 and grid <= 128))


def changed_scope(c, include_short=True):
    if direct_scope(c):
        return True
    return (include_short and c["HQ"] == 16 * c["H"] and c["block_size"] == 16
        and c["D"] == 64 and c["S"] == 2 and c["SEQ_LEN"] >= 64
        and c["B"] * c["H"] * c["SEQ_LEN"] <= 1024)


def compiled(module, c):
    values = []
    for part in parts(module._get_kernel(*shape(c))):
        source = part.get_kernel_source()
        assert not any(marker in source for marker in (
            "memcpy_async", "cp.async", "maca_async", "tma_load", "mbarrier"))
        assert not any(value for key, value in part.pass_configs.items()
            if "disable_data_race" in str(key) or "disable_safe_memory" in str(key))
        shared, method, _ = prior.helpers.shared_bytes(part)
        values.append(dict(sha256=hashlib.sha256(source.encode()).hexdigest(),
            flags=list(part.compile_flags or []), shared_bytes=shared,
            block_barriers=source.count("__syncthreads()"),
            wave_barriers=source.count("__syncwarp()"), shared_evidence=method,
            pass_configs={str(k): v for k, v in part.pass_configs.items()}))
    return values


def static_checks(dev_source, sub_source, baseline_source, include_short):
    dev_tree = strip.no_docs(ast.parse(dev_source))
    assert ast.dump(dev_tree) == ast.dump(ast.parse(sub_source))
    old = {n.name: n for n in strip.no_docs(ast.parse(baseline_source)).body
           if isinstance(n, ast.FunctionDef)}
    new = {n.name: n for n in dev_tree.body if isinstance(n, ast.FunctionDef)}
    kept = []
    for name, node in old.items():
        if name != "_get_kernel":
            assert ast.dump(node) == ast.dump(new[name]), name
            kept.append(name)
    added = sorted(set(new) - set(old))
    assert added == (["native_sparse_attention_q_preload", "native_sparse_attention_short_lane_source"]
                     if include_short else ["native_sparse_attention_q_preload"])
    assert not any(marker in dev_source for marker in (
        "TL_DISABLE_DATA_RACE_CHECK", "TL_DISABLE_SAFE_MEMORY_ACCESS", "T.call_extern"))
    return dict(ast_equal_ignoring_docstrings=True,
        unchanged_original_functions=kept, added_functions=added)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--dev", required=True)
    p.add_argument("--submission", required=True)
    p.add_argument("--timings", nargs="+", required=True)
    p.add_argument("--output", required=True)
    p.add_argument("--short-mode", choices=("none", "wave"), required=True)
    a = p.parse_args()
    assert digest(BASELINE) == BASELINE_SHA256
    paths = (Path(a.dev).resolve(), Path(a.submission).resolve(), BASELINE)
    report = dict(status="running", command=sys.argv,
        source_sha256={str(x): digest(x) for x in paths},
        static=static_checks(*(x.read_text() for x in paths), include_short=a.short_mode == "wave"),
        short_mode=a.short_mode,
        timings=[], configurations=[])
    dev, sub, baseline = [load_module(str(x)) for x in paths]
    cache = {}

    def save():
        Path(a.output).write_text(json.dumps(report, indent=2) + "\n")

    save()
    for timing_path in a.timings:
        data = json.loads(Path(timing_path).read_text())
        assert data["shared_pool"]
        names = list(data["sha256"])
        for name, expected in data["sha256"].items():
            assert digest(ROOT / name) == expected, name
        matching = [i for i, name in enumerate(names)
                    if (ROOT / name).resolve() in paths[:2]]
        assert matching, (timing_path, "final source was not in this benchmark")
        for row in data["rows"]:
            c = row["config"]
            key = json.dumps(c, sort_keys=True)
            if key not in cache:
                submitted, development, original = [compiled(mod, c)
                    for mod in (sub, dev, baseline)]
                assert submitted == development, (row["case"], "dev/sub")
                assert (submitted != original) == changed_scope(c, include_short=a.short_mode == "wave"), (
                    row["case"], "dispatch scope", c)
                if direct_scope(c):
                    assert len(submitted) == 1 and submitted[0]["shared_bytes"] == 0
                    assert submitted[0]["block_barriers"] == 0
                    assert submitted[0]["wave_barriers"] == 1
                elif changed_scope(c, include_short=a.short_mode == "wave"):
                    assert len(submitted) == 1 and submitted[0]["shared_bytes"] == 4096
                    assert submitted[0]["block_barriers"] == 0
                    assert submitted[0]["wave_barriers"] == 3
                cache[key] = submitted
                report["configurations"].append(dict(config=c,
                    baseline_equal=submitted == original,
                    baseline=original, submitted=submitted,
                    development_submission_equal=True))
            submitted = cache[key]
            for i in matching:
                assert [v["sha256"] for v in submitted] == row["device_source_sha256"][i], (
                    timing_path, row["case"], i, "device source")
                assert [v["flags"] for v in submitted] == row["compile_flags"][i], (
                    timing_path, row["case"], i, "compile flags")
            report["timings"].append(dict(file=timing_path,
                case=row["case"], seed=row["seed"],
                actual_timed_sources_equal=True, checked_modules=[names[i] for i in matching]))
            save()
            print(Path(timing_path).name, row["case"], row["seed"], "PASS", flush=True)
    report["status"] = "PASS"
    save()
    print("PASS", len(report["configurations"]), "configurations,",
          len(report["timings"]), "timed records", flush=True)


if __name__ == "__main__":
    main()
