"""Validate the evidence and summarize all timing rows without dropping negatives."""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent
OFFICIAL_SHA = "71dd44e50e32a83a3758f656cf5ffcd757acae853546d69a226ec185bb18df92"
V11_SHA = "fc2d1f22d6bf769e7ef72c8c346ac586fbe85c2009bf171366dc8c883873d32e"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def timing(path, candidate_sha):
    data = json.loads(path.read_text())
    assert list(data["sha256"].values()) == [OFFICIAL_SHA, OFFICIAL_SHA, V11_SHA, candidate_sha]
    assert {(r["case"], r["seed"]) for r in data["rows"]} == {
        ("oj" + str(i), seed) for i in range(1, 15) for seed in (0, 61)}
    assert len(data["rows"]) == 28
    rows = []
    for r in data["rows"]:
        assert r["device_source_sha256"][2] == r["device_source_sha256"][3]
        values = {}
        for i, name in enumerate(("control", "v11", "candidate"), 1):
            trials = r["trials"][i]
            accepted = [t for t in trials if t["accepted"]]
            assert accepted, (path.name, r["case"], r["seed"], name)
            values[name] = dict(accepted=len(accepted), total=len(trials),
                filtered=statistics.median(t["speedup"] for t in accepted),
                unfiltered=statistics.median(t["speedup"] for t in trials))
            if "wall_speedup" in trials[0]:
                values[name]["wall_unfiltered"] = statistics.median(t["wall_speedup"] for t in trials)
        values["candidate_vs_v11"] = {k:values["candidate"][k]/values["v11"][k]
            for k in ("filtered", "unfiltered")}
        rows.append(dict(case=r["case"], seed=r["seed"], max_abs_error=max(r["max_abs_error"]),
            device_source_equal_to_v11=True, **values))
    aggregate = {name:{kind:statistics.geometric_mean(r[name][kind] for r in rows)
                      for kind in ("filtered", "unfiltered")}
                 for name in ("control", "v11", "candidate", "candidate_vs_v11")}
    return dict(method=data["method"], aggregate=aggregate, rows=rows,
        candidate_below_official_baseline=[dict(case=r["case"], seed=r["seed"], speedup=r["candidate"]["unfiltered"])
            for r in rows if r["candidate"]["unfiltered"] < 1],
        candidate_below_v11=[dict(case=r["case"], seed=r["seed"], speedup=r["candidate_vs_v11"]["unfiltered"])
            for r in rows if r["candidate_vs_v11"]["unfiltered"] < 1])


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("validation")
    p.add_argument("--module", required=True)
    p.add_argument("--output", required=True)
    a = p.parse_args()
    root, module = Path(a.validation), Path(a.module)
    candidate_sha = sha(module)
    state = json.loads((root / "status.json").read_text())
    assert state["status"] == "PASS" and state["source_sha256"] == candidate_sha
    assert state["official_baseline_sha256"] == OFFICIAL_SHA and state["parent_sha256"] == V11_SHA
    assert all(step["returncode"] == 0 for step in state["steps"])
    reference = json.loads((root / "reference.json").read_text())
    assert len(reference) == 125 and all(r["status"] == "PASS" for r in reference)
    host = json.loads((root / "host_call.json").read_text())
    cpu = json.loads((root / "host_fast_cpu.json").read_text())
    legacy = json.loads((root / "legacy_scale.json").read_text())
    for data in (host, cpu, legacy):
        assert data["status"] == "PASS" and candidate_sha in data["sources"].values()
    assert len(legacy["rows"]) == 32
    positive = [r for r in legacy["rows"] if r["scale"] is None or r["scale"] > 0]
    assert all(r["positive_device_source_equal"] and r["positive_outputs_equal"] for r in positive)
    assert {k:len(host[k]) for k in ("cache", "normalization", "errors", "live", "restricted")} == {
        "cache":32, "normalization":24, "errors":10, "live":32, "restricted":8}
    binary = json.loads((root / "actual_binary/report.json").read_text())
    assert len(binary["rows"]) == 22
    binary_rows = []
    for r in binary["rows"]:
        before, after = r["modules"]
        assert before["sha256"] == V11_SHA and after["sha256"] == candidate_sha
        assert len(before["parts"]) == len(after["parts"])
        for left, right in zip(before["parts"], after["parts"]):
            for key in ("device_source_sha256", "compile_flags", "resources"):
                assert left[key] == right[key], (r["case"], key)
            assert left["sections"][".text"] == right["sections"][".text"], r["case"]
        binary_rows.append(dict(case=r["case"], launches=len(after["parts"]),
            source_text_flags_resources_equal=True))
    before, after = (ast.parse(p.read_text()) for p in (HERE / "baseline.py", module))
    before_fn = {n.name:ast.dump(n) for n in before.body if isinstance(n, ast.FunctionDef)}
    after_fn = {n.name:ast.dump(n) for n in after.body if isinstance(n, ast.FunctionDef)}
    assert before_fn.keys() == after_fn.keys()
    changed = [k for k in before_fn if before_fn[k] != after_fn[k]]
    assert set(changed) == {"native_sparse_attention", "run_kernel", "native_sparse_attention_online_emitter"}
    assert [ast.dump(n) for n in before.body if not isinstance(n, ast.FunctionDef)] == [
        ast.dump(n) for n in after.body if not isinstance(n, ast.FunctionDef)]
    assert not any(isinstance(n, ast.ClassDef) for n in ast.walk(after))
    assert not any(isinstance(n, ast.Attribute) and isinstance(n.ctx, ast.Store) for n in ast.walk(after))
    summary = dict(status="PASS", candidate_sha256=candidate_sha, official_baseline_sha256=OFFICIAL_SHA,
        parent_v11_sha256=V11_SHA, official_baseline_score=88.93, official_candidate_score=None,
        official_target=89.33, official_target_verified=False,
        static=dict(changed_functions=changed, unchanged_functions=len(before_fn)-len(changed),
            no_attribute_writes=True, no_new_imports=True),
        correctness=dict(reference_cases=125, reference_max_abs_error=max(r["max_abs_error"] for r in reference),
            host={k:len(host[k]) for k in ("cache", "normalization", "errors", "live", "restricted")},
            host_guard_functions=host["guarded_host_functions"], official_sandbox=False,
            cpu_configurations=cpu["configurations"], cpu_public_requests=cpu["public_requests"],
            legacy_scale_cases=len(legacy["rows"]), legacy_parent_failures=sum(not r["parent_pass"] for r in legacy["rows"]),
            positive_legacy_source_and_output_equal=len(positive)),
        binary=binary_rows, graph=timing(root / "oj_graph.json", candidate_sha),
        public_loop=timing(root / "oj_public.json", candidate_sha),
        evidence_sha256={str(p.relative_to(root)):sha(p) for p in sorted(root.rglob("*.json"))})
    with Path(a.output).open("x") as out:
        json.dump(summary, out, indent=2)
        out.write("\n")
    print(json.dumps({k:summary[k] for k in ("status", "candidate_sha256", "correctness")}, indent=2))
    print("graph", summary["graph"]["aggregate"])
    print("public_loop", summary["public_loop"]["aggregate"])


if __name__ == "__main__":
    main()
