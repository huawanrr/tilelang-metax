"""Check final evidence and retain positive, negative, and same-source timing rows."""
import argparse
import ast
import hashlib
import json
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent
V12_SHA = "58bc2fd7a2aeb8ea805be63cc4aefae81487bcc39c3608fb5edc8293380888f9"
OFFICIAL_SHA = "71dd44e50e32a83a3758f656cf5ffcd757acae853546d69a226ec185bb18df92"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_text())


def timing(path, candidate_sha, cases, seeds=(0, 61), changed_cases=("oj1",)):
    data = read(path)
    assert list(data["sha256"].values()) == [V12_SHA, V12_SHA, candidate_sha]
    assert {(r["case"], r["seed"]) for r in data["rows"]} == {
        (case, seed) for case in cases for seed in seeds}
    assert len(data["rows"]) == len(seeds) * len(cases)
    rows = []
    for r in data["rows"]:
        hashes = r["device_source_sha256"]
        assert hashes[0] == hashes[1]
        assert (hashes[0] != hashes[2]) == (r["case"] in changed_cases)
        row = dict(case=r["case"], seed=r["seed"], changed=r["case"] in changed_cases,
                   max_abs_error=max(r["max_abs_error"]))
        for i, name in ((1, "control"), (2, "candidate")):
            trials = r["trials"][i]
            accepted = [t for t in trials if t["accepted"]]
            row[name] = dict(
                accepted=len(accepted), total=len(trials),
                unfiltered=statistics.median(t["speedup"] for t in trials),
                filtered=statistics.median(t["speedup"] for t in accepted) if accepted else None,
            )
            if "wall_speedup" in trials[0]:
                row[name]["wall_unfiltered"] = statistics.median(t["wall_speedup"] for t in trials)
        rows.append(row)
    aggregate = {}
    for name in ("control", "candidate"):
        accepted_rows = [r for r in rows if r[name]["filtered"] is not None]
        aggregate[name] = dict(
            all_rows=len(rows), filtered_rows=len(accepted_rows),
            unfiltered=statistics.geometric_mean(r[name]["unfiltered"] for r in rows),
            filtered=statistics.geometric_mean(r[name]["filtered"] for r in accepted_rows) if accepted_rows else None,
            changed_unfiltered=statistics.geometric_mean(r[name]["unfiltered"] for r in rows if r["changed"]),
        )
    return dict(method=data["method"], aggregate=aggregate, rows=rows,
                regressions=[r for r in rows if r["candidate"]["unfiltered"] < 1])


def cold(path, candidate_sha):
    data = read(path)
    assert list(data["sha256"].values()) == [V12_SHA, V12_SHA, candidate_sha]
    assert {r["case"] for r in data["rows"]} == {"oj1", "d32_t32_c1", "d32_t64_c0"}
    rows = []
    for r in data["rows"]:
        medians = []
        for records in r["records"]:
            assert len(records) == 8
            for record in records:
                assert len(record["kernel_events"]) == record["expected_kernels"] == 96
                actual = sum(e["device_time_us"] for e in record["kernel_events"]) / 96
                assert abs(actual - record["total_kernel_us_per_call"]) < 1e-10
            medians.append(statistics.median(x["total_kernel_us_per_call"] for x in records))
        assert medians == r["median_kernel_us"]
        rows.append(dict(case=r["case"], changed=r["case"] == "oj1",
                         max_abs_error=max(r["max_abs_error"]), median_us=medians,
                         control_speedup=medians[0]/medians[1], candidate_speedup=medians[0]/medians[2]))
    return dict(method=data["method"], flush_bytes=data["flush_bytes"], rows=rows)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("validation")
    parser.add_argument("--module", required=True)
    parser.add_argument("--math-result", default=str(HERE / "recip_log_math.json"))
    parser.add_argument("--windows")
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    root, module = Path(args.validation), Path(args.module)
    candidate_sha = sha(module)
    state = read(root / "status.json")
    assert state["status"] == "PASS" and state["candidate_sha256"] == candidate_sha
    assert state["parent_sha256"] == V12_SHA and sha(HERE / "baseline.py") == V12_SHA
    assert len(state["steps"]) == 10 and all(s["returncode"] == 0 for s in state["steps"])
    reference = read(root / "reference.json")
    assert len(reference) == 125 and all(r["status"] == "PASS" for r in reference)
    host, cpu, families = (read(root / name) for name in (
        "host_call.json", "host_fast_cpu.json", "changed_families.json"))
    for data in (host, cpu):
        assert data["status"] == "PASS" and candidate_sha in data["sources"].values()
    assert families["status"] == "PASS" and families["source_sha256"] == candidate_sha
    assert {k:len(host[k]) for k in ("cache", "normalization", "errors", "live", "restricted")} == {
        "cache":32, "normalization":24, "errors":10, "live":32, "restricted":8}
    assert {k:len(families[k]) for k in ("strict_fp32", "boundaries", "scales", "live", "restricted")} == {
        "strict_fp32":6, "boundaries":26, "scales":30, "live":36, "restricted":6}
    assert any(r["builder"] == "native_sparse_attention_q_preload_vfirst" for r in families["strict_fp32"])
    math_path = Path(args.math_result)
    math = read(math_path)
    assert math["status"] == "PASS" and math["inputs"] == 8755203
    assert math["source_sha256"] == sha(HERE / "verify_recip_log_math.py")
    assert math["generator_sha256"] == sha(HERE / "make_recip_log.py")
    fn = next(n for n in ast.parse(module.read_text()).body
              if isinstance(n, ast.FunctionDef) and n.name == "native_sparse_attention_q_preload_vfirst")
    expected_inverse = ast.dump(ast.parse("T.exp(-T.log(tiny_sum_out[i, lane * 4]))", mode="eval").body)
    assert sum(ast.dump(n) == expected_inverse for n in ast.walk(fn) if isinstance(n, ast.Call)) == 2
    binary = read(root / "actual_binary/report.json")
    assert len(binary["rows"]) == 19
    binary_rows = []
    for r in binary["rows"]:
        before, after = r["modules"]
        assert before["sha256"] == V12_SHA and after["sha256"] == candidate_sha
        assert len(before["parts"]) == len(after["parts"])
        changed_parts = []
        for index, (a, b) in enumerate(zip(before["parts"], after["parts"])):
            changed = a["sections"][".text"] != b["sections"][".text"]
            assert changed == (r["case"] == "oj1")
            if changed:
                assert a["sections"][".text"]["sha256"] == "55aa3aa5abb79c625de9505b560b962b9d412c246595502adaf1d58821cf746c"
                assert b["sections"][".text"]["sha256"] == "47125743024f0c983f98809e840f22e096475ff9e3bbd51b7d16f2f1ef228152"
            assert a["compile_flags"] == b["compile_flags"]
            if not changed:
                assert a["device_source_sha256"] == b["device_source_sha256"]
                assert a["resources"] == b["resources"]
            changed_parts.append(dict(part=index, changed=changed,
                before_text_bytes=a["sections"][".text"]["size"], after_text_bytes=b["sections"][".text"]["size"],
                before_resources=a["resources"], after_resources=b["resources"]))
        binary_rows.append(dict(case=r["case"], launches=len(after["parts"]), parts=changed_parts))
    summary = dict(
        status="PASS", candidate_sha256=candidate_sha, parent_v12_sha256=V12_SHA,
        official_baseline_sha256=OFFICIAL_SHA, official_baseline_score=88.93,
        official_candidate_score=None, official_target=89.33, official_target_verified=False,
        static=state["static"],
        correctness=dict(reference_cases=125, reference_max_abs_error=max(r["max_abs_error"] for r in reference),
            cpu_configurations=cpu["configurations"], cpu_public_requests=cpu["public_requests"],
            host={k:len(host[k]) for k in ("cache", "normalization", "errors", "live", "restricted")},
            families={k:len(families[k]) for k in ("strict_fp32", "boundaries", "scales", "live", "restricted")},
            official_sandbox=False, math_inputs=math["inputs"],
            math_exp_log=next(r for r in math["rows"] if r["mode"] == "exp_log")),
        graph=timing(root / "oj_graph.json", candidate_sha, [f"oj{i}" for i in range(1,15)]),
        public_loop=timing(root / "public_loop.json", candidate_sha, ["oj1", "oj2", "oj11"]),
        cold={str(seed):cold(root / f"cold_seed{seed}.json", candidate_sha) for seed in (0,61)},
        binary=binary_rows, math_evidence=dict(path=str(math_path), sha256=sha(math_path)),
        evidence_sha256={str(p.relative_to(root)):sha(p) for p in sorted(root.rglob("*"))
                         if p.is_file() and "__pycache__" not in p.relative_to(root).parts},
    )
    if args.windows:
        windows = Path(args.windows)
        cases = [f"oj1_repeat{repeat}" for repeat in (100, 400, 800, 1600)]
        summary["graph_windows"] = timing(windows, candidate_sha, cases,
                                           seeds=(0, 61, 2026), changed_cases=cases)
        summary["windows_evidence"] = dict(path=str(windows), sha256=sha(windows))
    with Path(args.output).open("x") as file:
        json.dump(summary, file, indent=2)
        file.write("\n")
    print(json.dumps({k:summary[k] for k in ("status", "candidate_sha256", "correctness")}, indent=2))
    print("Graph:", summary["graph"]["aggregate"])
    print("Public calls:", summary["public_loop"]["aggregate"])


if __name__ == "__main__":
    main()
