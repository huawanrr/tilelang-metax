"""Publish the medium-grid candidate only after all recorded checks pass."""
import argparse
import ast
import hashlib
import itertools
import json
import math
from os.path import relpath
from pathlib import Path
import statistics
import subprocess

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def read(path):
    return json.loads(path.read_text())


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def geomean(values):
    return math.exp(statistics.mean(math.log(value) for value in values))


def check_hashes(mapping, root=ROOT):
    for name, expected in mapping.items():
        assert digest(root / name) == expected, name


def selected(case, config):
    return (case["S"] == 1 and case["D"] == 64 and case["H"] == 1
        and case["HQ"] == 16 and case["block_size"] == 16 and case["SEQ_LEN"] % 16 == 0
        and config["grid_min_exclusive"] < case["B"] * case["SEQ_LEN"] <= config["grid_max_inclusive"])


def functions(path):
    return {node.name: ast.dump(node, include_attributes=False) for node in ast.parse(path.read_text()).body
            if isinstance(node, ast.FunctionDef)}


def comparison(rows, baseline, candidate):
    changed = [row for row in rows if
        (row["device_source_sha256"][baseline], row["compile_flags"][baseline]) !=
        (row["device_source_sha256"][candidate], row["compile_flags"][candidate])]
    changed_ids = {row["case"] for row in changed}
    unchanged = [row for row in rows if row["case"] not in changed_ids]
    ratio = lambda row: row["us"][baseline] / row["us"][candidate]
    return dict(geomean_speedup=geomean(map(ratio, rows)),
        changed_cases=[row["case"] for row in changed], changed_geomean_speedup=geomean(map(ratio, changed)),
        unchanged_cases=len(unchanged), unchanged_geomean_speedup=geomean(map(ratio, unchanged)),
        changed_below_one=[dict(case=row["case"], config=row["config"], speedup=ratio(row))
                           for row in changed if ratio(row) < 1],
        minimum_changed_speedup=min(map(ratio, changed)))


def summarize_bracket(path, config):
    data = read(path)
    check_hashes(data["sha256"])
    command = data["command"]
    option = lambda name, default=None: command[command.index(name)+1] if name in command else default
    cases, seeds = option("--cases").split(","), list(map(int, option("--seeds").split(",")))
    attempts, repeat = int(option("--attempts")), int(option("--repeat"))
    drift = float(option("--max-drift", "0.01"))
    assert attempts >= 24 and repeat >= 500 and len(seeds) >= 3
    assert [(row["case"], row["seed"]) for row in data["rows"]] == list(itertools.product(cases, seeds))
    modules = list(data["sha256"])
    probe = str((HERE / "mid_pairs.py").relative_to(ROOT))
    position = modules.index(probe) - 1
    controls, ratios, accepted, regressions = [], [], [], []
    for row in data["rows"]:
        for summary, trials in zip(row["summaries"], row["trials"][1:]):
            assert len(trials) == summary["total"] == attempts
            kept = [trial for trial in trials if trial["accepted"]]
            assert len(kept) == summary["accepted"] >= attempts // 2
            assert all(trial["accepted"] == (trial["drift"] <= drift) for trial in trials)
            assert math.isclose(summary["median_speedup"], statistics.median(trial["speedup"] for trial in kept), rel_tol=1e-12)
            accepted.append(len(kept))
        controls.append(row["summaries"][0]["median_speedup"])
        if selected(row["config"], config):
            value = row["summaries"][position]["median_speedup"]
            ratios.append(value)
            if value < 1:
                regressions.append(dict(case=row["case"], seed=row["seed"], speedup=value))
    return dict(report=str(path.relative_to(ROOT)), report_sha256=digest(path), shapes=len(cases),
        seed_combinations=len(data["rows"]), seeds=seeds, attempts=attempts, calls_per_graph=repeat,
        active_combinations=len(ratios), active_geomean=geomean(ratios),
        active_range=[min(ratios), max(ratios)], active_below_one=regressions,
        control_range=[min(controls), max(controls)], minimum_accepted=min(accepted),
        rejected_samples_retained=True, final_device_source_equivalence="bracketed_source_audit.json")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--directory", required=True)
    args = parser.parse_args()
    release = Path(args.directory).resolve()
    relative = str(release.relative_to(ROOT))
    assert not (release / "release_manifest.json").exists(), "Do not overwrite a published release"
    dev, sub = release / "nsa.py", release / "submission.py"
    assembly = read(release / "assembly.json")
    config = assembly["config"]
    full, checks, reference = [read(release / name) for name in
                              ("full.json", "release_checks.json", "verification_fp32.json")]
    audit, bracket_audit, proof, pipeline = [read(release / name) for name in
        ("device_audit.json", "bracketed_source_audit.json", "layout_proof.json", "validation_pipeline.json")]
    prior_dir = ROOT / "experiments/20261002_blocks_v2"
    prior = read(prior_dir / "release_manifest.json")
    check_hashes(prior["source_sha256"], prior_dir)
    for mapping in (prior["preserved_baselines"], prior["evidence_sha256"], assembly["source_sha256"],
                    full["source_sha256"], checks["source_sha256"], audit["source_sha256"],
                    bracket_audit["source_sha256"], bracket_audit["benchmark_reports_sha256"]):
        check_hashes(mapping)
    preserved = read(release / "preserved_releases.json")
    assert preserved["status"] == "PASS"
    check_hashes(preserved["prior_manifests"])
    assert all(record["status"] == "PASS" for record in (checks, audit, bracket_audit, proof, pipeline))
    assert len(reference) == 125 and all(row["status"] == "PASS" for row in reference)
    assert len(full["rows"]) == len(audit["rows"]) == 109
    assert [row["config"] for row in full["rows"]] == read(ROOT / "test_cases_nsa_fwd.json")
    assert full["rounds"] == 4 and full["repeat"] == 200 and full["samples"] == 7
    assert audit["full_report_sha256"] == digest(release / "full.json")
    assert len(checks["boundaries"]) == len(checks["sources"]) == 34
    assert len(checks["extremes"]) == 6 and len(checks["refresh"]) == 18 and len(checks["guarded"]) == 6
    assert len(checks["fallbacks"]) + len(checks["unsupported"]) == 28
    assert checks["reference_matmul_tf32"] is False
    assert all(row["same_baseline_failure"] for row in checks["unsupported"])
    assert len(bracket_audit["rows"]) == 26
    assert all(row["measured_probe_or_baseline_equal"] and row["development_submission_equal"] for row in bracket_audit["rows"])
    assert len(proof["modules"]) == 1 and proof["modules"][0]["sha256"] == digest(dev)
    assert proof["modules"][0]["protected_shared_dependencies"] == 5
    for row in audit["rows"]:
        assert row["development_submission_equal"] and row["matches_measured_source"]
        for part in row["parts"]:
            assert digest(ROOT / part["source"]) == part["sha256"]
    static = (release / "static_checks.log").read_text().splitlines()
    assert len(static) == 2 and all(line.endswith(" PASS") for line in static)
    equiv = (release / "equivalence.log").read_text().splitlines()
    assert equiv[-1] == "ALL EQUIVALENT" and sum(line.endswith(": EQUIVALENT") for line in equiv) == 18
    before, after = functions(prior_dir / "nsa.py"), functions(dev)
    retained = [name for name in before if name != "_get_kernel"]
    assert len(retained) == 43 and set(retained) == set(assembly["retained_functions"])
    assert all(before[name] == after[name] for name in retained)
    assert set(after) - set(before) == set(assembly["new_functions"])
    measured = list(full["source_sha256"])
    candidate = measured.index(str(sub.relative_to(ROOT)))
    old1 = measured.index("experiments/20261001_final/submission.py")
    old2 = measured.index("experiments/20261002_blocks_v2/submission.py")
    overall, incremental = comparison(full["rows"], old1, candidate), comparison(full["rows"], old2, candidate)
    assert all(selected(row["config"], config) == (row["case"] in incremental["changed_cases"]) for row in full["rows"])
    brackets = [summarize_bracket(HERE / name, config) for name in
                ("bracketed_multiseed.json", "word_views_multiseed.json")]
    performance = dict(standard_cases=109, versus_1001=overall, versus_blocks_v2=incremental,
        bracketed=brackets, max_abs_error=max(row["max_abs_error"] for row in reference),
        reference_tf32=False, reference_dual_interface_cases=125, official_new_score=None)
    (release / "performance_summary.json").write_text(json.dumps(performance, indent=2) + "\n")
    regressions = "\n".join(f"| {row['case']} | {row['config']['B']} | {row['config']['SEQ_LEN']} | {row['speedup']:.6f}× |"
                             for row in incremental["changed_below_one"])
    readme = f'''# 2026-10-02 NSA D64 中等网格最终候选

提交本目录 `submission.py` 全文；开发源码为 `nsa.py`。
本地发布验证已完成。正式已知仍是10.1的 **87.93分**；本版尚无OJ回传，
**88.5尚未确认达到**。提交SHA256：`{digest(sub)}`。

在 blocks_v2 上，仅改进默认 S1/D64/BS16/G16/64线程、单KV head、完整块，
且 `256 < B * H * T <= 2048` 的 shared-Q reuse 路径。
先验证block编号，再通过同地址视图把每lane的8个fp16分为4个uint32读取。
共享布局、5处wave同步、输出写入及计算顺序保持原样，没有增加kernel启动。
43个原有非分派函数AST保持不变，多KV head、尾块、其他网格及显式调参保留原路径。

109例，同输入/输出、四轮交替、每图200调用、每轮7次采样：

| 比较范围 | 用例数 | 几何平均加速比 |
|---|---:|---:|
| 相对87.93分10.1，全部 | 109 | **{overall['geomean_speedup']:.8f}×** |
| 相对10.1，设备码改变 | {len(overall['changed_cases'])} | {overall['changed_geomean_speedup']:.8f}× |
| 相对blocks_v2，全部 | 109 | **{incremental['geomean_speedup']:.8f}×** |
| 相对blocks_v2，新增改动 | {len(incremental['changed_cases'])} | {incremental['changed_geomean_speedup']:.8f}× |
| 相对blocks_v2，设备码相同 | {incremental['unchanged_cases']} | {incremental['unchanged_geomean_speedup']:.8f}× |

新增改动中的负结果如下，保留在 `full.json`，没有按单个测试编号分派：

| 本地用例 | B | T | v2/新版 |
|---|---:|---:|---:|
{regressions}

两轮26形状、3种子、每组24次A/B/A、每图500调用的研究夹测中，
最终启用的19个形状/57个种子组合分别为 **{brackets[0]['active_geomean']:.8f}×**、
**{brackets[1]['active_geomean']:.8f}×**。两轮都保留了小幅回退与全部拒绝样本。
最终开发/提交文件的26个形状已逐一对照设备源码及编译参数：启用部分与已测probe相同，
回退部分与已测基线相同，见 `bracketed_source_audit.json`。不把子集提升当作全量提升。
不同测量批次的比值有波动；历史v2报告保持原样。本地加速比不能换算为已确认OJ成绩。

验证：125例严格FP32双接口参考、34个边界及真实shared发射大小核对、6组极端索引、
{len(checks['fallbacks'])}项调参设备码等价、{len(checks['unsupported'])}项保持原有不支持结果、18次同地址输入更新、
6组本地RestrictedPython host guard、109例与实际计时对应的源码审计、18组传统等价检查。
最大绝对误差 {performance['max_abs_error']}。CPU证明覆盖实际loader/store索引、lane归属、
shared双射和同地址视图。没有异步拷贝、输入结果缓存、后端改动或关闭race/bounds检查。
完整官方沙箱与成绩仍待OJ确认。

`commands.sh` 在新的临时实验目录复现，避免覆盖本目录证据。
研究及所有未采用方案保存在 `../20261002_mid_blocks`，发布清单见 `release_manifest.json`。
'''
    (release / "README.md").write_text(readme)
    commands = f'''#!/usr/bin/env bash
# Run from race_tests/nsa. All GPU commands remain sequential.
set -eo pipefail
source env.sh
task_repro_dir=$(mktemp -d experiments/20261002_mid_repro.XXXXXX)
cp {relative}/nsa.py {relative}/submission.py {relative}/assembly.json "$task_repro_dir/"
python check_submission_nsa.py "$task_repro_dir/nsa.py" "$task_repro_dir/submission.py" > "$task_repro_dir/static_checks.log"
python experiments/20261002_mid_blocks/compare_family.py experiments/20261001_final/submission.py experiments/20261002_blocks_v2/submission.py "$task_repro_dir/submission.py" --cases all --rounds 4 --repeat 200 --samples 7 --output "$task_repro_dir/full.json" > "$task_repro_dir/full.log" 2>&1
python experiments/20261002_mid_blocks/verify_mid.py --directory "$task_repro_dir" --output "$task_repro_dir/release_checks.json" > "$task_repro_dir/release_checks.log" 2>&1
python experiments/20261002_mid_blocks/check_mid_layouts.py "$task_repro_dir/nsa.py" --output "$task_repro_dir/layout_proof.json"
python experiments/20261002_mid_blocks/validate_release.py --directory "$task_repro_dir" > "$task_repro_dir/validation_pipeline.log" 2>&1
printf 'Reports: %s\\n' "$task_repro_dir"
'''
    (release / "commands.sh").write_text(commands)
    (release / "commands.sh").chmod(0o755)
    subprocess.run(["bash", "-n", str(release / "commands.sh")], check=True)
    evidence = [path for folder in (release, HERE) for path in folder.rglob("*")
                if path.is_file() and "__pycache__" not in path.parts
                and path.name not in ("release_manifest.json",)
                and path not in (dev, sub)]
    evidence += [ROOT / name for name in ("benchmark_nsa.py", "verify_nsa.py", "check_equiv.py",
        "check_submission_nsa.py", "experiment_bench.py", "kernel_source.py", "test_cases_nsa_fwd.json", "env.sh",
        "experiments/20261002_tuning/verify_candidate.py", "experiments/20261001_tuning/verify_release.py",
        "experiments/20260928_guard_fix/check_restricted_host.py", "experiments/20261002_blocks_v2/release_manifest.json")]
    evidence += [ROOT.parent / "moe" / name for name in ("strip_comments.py", "check_submission.py")]
    manifest = dict(date="2026-10-02", directory=relative, status="validated locally; OJ confirmation pending",
        user_confirmed_baseline_score=87.93, target_score=88.5, official_new_score=None, official_sandbox=False,
        source_sha256={path.name: digest(path) for path in (dev, sub)},
        preserved_baselines=prior["preserved_baselines"], prior_release_manifest_sha256=digest(prior_dir / "release_manifest.json"),
        dispatch_config=config, preserved_functions=retained, added_functions=assembly["new_functions"],
        validation_counts={key: len(checks[key]) for key in
            ("boundaries", "sources", "extremes", "fallbacks", "unsupported", "refresh", "guarded")},
        performance=performance,
        evidence_sha256={relpath(path, ROOT): digest(path) for path in sorted(set(evidence))})
    (release / "release_manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    print(json.dumps(dict(directory=relative, submission_sha256=digest(sub),
        all_109_vs_1001=overall["geomean_speedup"], all_109_vs_blocks_v2=incremental["geomean_speedup"],
        evidence_files=len(manifest["evidence_sha256"]), official_new_score=None), indent=2))


if __name__ == "__main__":
    main()
