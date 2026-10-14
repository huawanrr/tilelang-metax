"""Audit v6 against the actual sources timed and the unchanged v4/v5 paths."""
import argparse
import ast
import importlib.util
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
PREV = ROOT / "experiments/20261008_resume8857"
sys.path.insert(0, str(PREV))
from audit_candidate_v5b import compiled, digest, direct_scope, strip, BASELINE, BASELINE_SHA256
from experiment_bench import load_module


def tiled_scope(c):
    n, b, h = c["SEQ_LEN"], c["B"], c["H"]
    grid = b * h * n
    return (c["S"] == 1 and c["D"] == 128 and c["block_size"] == 32
            and c["HQ"] == 16 * h and grid >= 1024
            and not (h == 1 and n >= 64 and grid < 4096)
            and b * h * ((n + 31) // 32) <= 256)


def static_checks(dev_source, sub_source, baseline_source):
    dev = strip.no_docs(ast.parse(dev_source))
    assert ast.dump(dev) == ast.dump(ast.parse(sub_source))
    old = {n.name: n for n in strip.no_docs(ast.parse(baseline_source)).body
           if isinstance(n, ast.FunctionDef)}
    new = {n.name: n for n in dev.body if isinstance(n, ast.FunctionDef)}
    kept = []
    for name, node in old.items():
        if name != "_get_kernel":
            assert ast.dump(node) == ast.dump(new[name]), name
            kept.append(name)
    added = sorted(set(new) - set(old))
    assert added == ["native_sparse_attention_pack_kv_bs32_tiles", "native_sparse_attention_q_preload"]
    assert not any(marker in dev_source for marker in (
        "TL_DISABLE_DATA_RACE_CHECK", "TL_DISABLE_SAFE_MEMORY_ACCESS", "T.call_extern"))
    return dict(ast_equal_ignoring_docstrings=True, unchanged_original_functions=kept,
                added_functions=added)


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--dev", required=True)
    p.add_argument("--submission", required=True)
    p.add_argument("--timings", nargs="+", required=True)
    p.add_argument("--pack-family", required=True)
    p.add_argument("--output", required=True)
    a = p.parse_args()
    output = Path(a.output)
    assert not output.exists()
    assert digest(BASELINE) == BASELINE_SHA256
    paths = (Path(a.dev).resolve(), Path(a.submission).resolve(), BASELINE)
    report = dict(status="running", command=sys.argv, source_sha256={str(p): digest(p) for p in paths},
                  static=static_checks(*(p.read_text() for p in paths)), timings=[], configurations=[],
                  pack_family=[])
    dev, sub, baseline = [load_module(str(p)) for p in paths]
    cached = {}

    def save():
        output.write_text(json.dumps(report, indent=2) + "\n")

    def current(c):
        key = json.dumps(c, sort_keys=True)
        if key not in cached:
            submitted, development, original = [compiled(mod, c) for mod in (sub, dev, baseline)]
            assert submitted == development, (c, "dev/sub")
            changed = direct_scope(c) or tiled_scope(c)
            assert (submitted != original) == changed, (c, "dispatch scope")
            if direct_scope(c):
                assert len(submitted) == 1 and submitted[0]["shared_bytes"] == 0
                assert submitted[0]["block_barriers"] == 0 and submitted[0]["wave_barriers"] == 1
            if tiled_scope(c):
                assert len(submitted) == len(original) == 2
                assert submitted[1] == original[1], (c, "attention changed")
                assert submitted[0]["shared_bytes"] == 4096
                assert submitted[0]["block_barriers"] == 0 and submitted[0]["wave_barriers"] == 1
            cached[key] = submitted
            report["configurations"].append(dict(config=c, baseline_equal=submitted == original,
                baseline=original, submitted=submitted, development_submission_equal=True,
                q_preload=direct_scope(c), tiled_pack=tiled_scope(c)))
        return cached[key]

    save()
    for filename in a.timings:
        data = json.loads(Path(filename).read_text())
        assert data["shared_pool"]
        names = list(data["sha256"])
        for name, expected in data["sha256"].items():
            assert digest(ROOT / name) == expected, name
        matching = [i for i, name in enumerate(names) if (ROOT / name).resolve() in paths[:2]]
        assert matching, (filename, "actual candidate absent")
        for row in data["rows"]:
            parts = current(row["config"])
            for i in matching:
                assert [v["sha256"] for v in parts] == row["device_source_sha256"][i]
                assert [v["flags"] for v in parts] == row["compile_flags"][i]
            report["timings"].append(dict(file=filename, case=row["case"], seed=row["seed"],
                actual_timed_sources_equal=True, checked_modules=[names[i] for i in matching]))
            save()
            print(Path(filename).name, row["case"], row["seed"], "PASS", flush=True)

    data = json.loads(Path(a.pack_family).read_text())
    names = list(data["sha256"])
    probe = next(i for i, name in enumerate(names) if Path(name).name == "pack_quads_w64.py")
    for name, expected in data["sha256"].items():
        assert digest(ROOT / name) == expected, name
    report["pack_family_source"] = dict(path=a.pack_family, sha256=digest(a.pack_family),
                                       source_sha256=data["sha256"])
    for row in data["rows"]:
        parts = current(row["config"])
        chosen = probe if tiled_scope(row["config"]) else 0
        assert [v["sha256"] for v in parts] == row["device_source_sha256"][chosen], row["case"]
        assert [v["flags"] for v in parts] == row["compile_flags"][chosen], row["case"]
        report["pack_family"].append(dict(case=row["case"], seed=row["seed"], config=row["config"],
            timed_module=names[chosen], retained_probe=tiled_scope(row["config"]),
            actual_timed_sources_equal=True))
    report["status"] = "PASS"
    save()
    print("PASS", len(report["timings"]), "timings,", len(cached), "configurations,",
          len(report["pack_family"]), "pack-family records", flush=True)


if __name__ == "__main__":
    main()
