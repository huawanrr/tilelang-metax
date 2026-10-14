"""Publish the block-load candidate after validating the recorded evidence."""
import argparse
import ast
import hashlib
import itertools
import json
import math
from pathlib import Path
import shlex
import statistics


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def read(path):
    return json.loads(path.read_text())


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def geomean(values):
    return math.exp(statistics.mean(map(math.log, values)))


def check_hashes(values, root=ROOT):
    for name, expected in values.items():
        assert digest(root / name) == expected, name


def functions(path):
    return {node.name: ast.dump(node, include_attributes=False)
            for node in ast.parse(path.read_text()).body if isinstance(node, ast.FunctionDef)}


def comparison(rows, baseline, candidate):
    changed = [row for row in rows if
        (row["device_source_sha256"][baseline], row["compile_flags"][baseline]) !=
        (row["device_source_sha256"][candidate], row["compile_flags"][candidate])]
    ids = {row["case"] for row in changed}
    unchanged = [row for row in rows if row["case"] not in ids]
    def ratio(row):
        return row["us"][baseline] / row["us"][candidate]
    return dict(geomean_speedup=geomean([ratio(row) for row in rows]),
        changed_cases=[row["case"] for row in changed],
        changed_geomean_speedup=geomean([ratio(row) for row in changed]),
        unchanged_cases=len(unchanged),
        unchanged_geomean_speedup=geomean([ratio(row) for row in unchanged]),
        minimum_changed_speedup=min(map(ratio, changed)),
        minimum_unchanged_speedup=min(map(ratio, unchanged)),
        changed_below_one=[dict(case=row["case"], speedup=ratio(row)) for row in changed if ratio(row) < 1])


def selected(case, config):
    return (case["S"] == 1 and case["D"] in (64, 128) and case["block_size"] == 16
        and case["HQ"] == 16 * case["H"] and case["SEQ_LEN"] % 16 == 0
        and (case["D"] != 64 or case["SEQ_LEN"] >= config["d64_min_seq"])
        and case["B"] * case["H"] * case["SEQ_LEN"] >= config[f"d{case['D']}_min_grid"])


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--directory", required=True)
    a = p.parse_args()
    release = Path(a.directory).resolve()
    relative = str(release.relative_to(ROOT))
    dev, sub = release / "nsa.py", release / "submission.py"
    assembly = read(release / "assembly.json")
    full = read(release / "full.json")
    checks = read(release / "release_checks.json")
    reference = read(release / "verification_fp32.json")
    proof = read(release / "layout_proof.json")
    audit = read(release / "device_audit.json")
    bracket = read(release / "bracketed_multiseed.json")
    config = assembly["config"]
    prior_dir = ROOT / "experiments/20261002_d32_v1"
    prior = read(prior_dir / "release_manifest.json")
    check_hashes(prior["source_sha256"], prior_dir)
    for hashes in (prior["preserved_baselines"], prior["evidence_sha256"],
                   read(HERE / "baseline_manifest.json")["source_sha256"], assembly["source_sha256"],
                   full["source_sha256"], checks["source_sha256"], audit["source_sha256"], bracket["sha256"]):
        check_hashes(hashes)
    assert checks["status"] == proof["status"] == audit["status"] == "PASS"
    assert proof["source_sha256"] == digest(dev)
    assert checks["reference_matmul_tf32"] is False
    assert len(reference) == 125 and all(row["status"] == "PASS" for row in reference)
    assert len(full["rows"]) == len(audit["rows"]) == 109
    assert [row["config"] for row in full["rows"]] == read(ROOT / "test_cases_nsa_fwd.json")
    assert [str(row["case"]) for row in full["rows"]] == list(map(str, range(1, 110)))
    assert audit["full_report_sha256"] == digest(release / "full.json")
    assert len(checks["boundaries"]) == len(checks["sources"]) == 36
    assert len(checks["extremes"]) == 6 and len(checks["refresh"]) == 18 and len(checks["guarded"]) == 6
    assert len(checks["fallbacks"]) + len(checks["unsupported"]) == 28
    assert all(row["same_baseline_failure"] for row in checks["unsupported"])
    for row in audit["rows"]:
        assert row["development_submission_equal"] and row["matches_measured_source"]
        for part in row["parts"]:
            assert digest(ROOT / part["source"]) == part["sha256"]
    static = (release / "static_checks.log").read_text().splitlines()
    assert len(static) == 2 and all(line.endswith(" PASS") for line in static)
    equiv = (release / "equivalence.log").read_text().splitlines()
    assert equiv[-1] == "ALL EQUIVALENT"
    assert sum(line.endswith(": EQUIVALENT") for line in equiv) == 18
    original, current = functions(prior_dir / "nsa.py"), functions(dev)
    retained = [name for name in original if name != "_get_kernel"]
    assert len(retained) == 41 and set(retained) == set(assembly["retained_functions"])
    assert all(original[name] == current[name] for name in retained)
    assert set(current) - set(original) == set(assembly["new_functions"])
    for path in (dev, sub):
        assert not any(marker in path.read_text() for marker in
            ("TL_DISABLE_DATA_RACE_CHECK", "TL_DISABLE_SAFE_MEMORY_ACCESS", "--misched="))

    measured = list(full["source_sha256"])
    candidate = [i for i, name in enumerate(measured) if full["source_sha256"][name] == digest(sub)]
    assert len(candidate) == 1
    candidate = candidate[0]
    old1 = measured.index("experiments/20261001_final/submission.py")
    old2 = measured.index("experiments/20261002_d32_v1/submission.py")
    overall = comparison(full["rows"], old1, candidate)
    incremental = comparison(full["rows"], old2, candidate)
    assert all(selected(row["config"], config) == (row["case"] in incremental["changed_cases"])
               for row in full["rows"])
    command = bracket["command"]
    def option(name, default=None):
        return command[command.index(name)+1] if name in command else default
    cases = option("--cases").split(",")
    seeds = list(map(int, option("--seeds").split(",")))
    attempts, repeat = int(option("--attempts")), int(option("--repeat"))
    drift = float(option("--max-drift", "0.01"))
    assert len(cases) >= 20 and len(seeds) >= 3 and attempts >= 24 and repeat >= 500
    assert [(row["case"], row["seed"]) for row in bracket["rows"]] == list(itertools.product(cases, seeds))
    hashes = list(bracket["sha256"].values())
    assert len(hashes) == 3 and hashes[0] == hashes[1] and hashes[2] == digest(sub)
    controls, ratios, active_ratios, accepted, regressions = [], [], [], [], []
    for row in bracket["rows"]:
        for summary, trials in zip(row["summaries"], row["trials"][1:]):
            assert len(trials) == summary["total"] == attempts
            kept = [trial for trial in trials if trial["accepted"]]
            assert len(kept) == summary["accepted"] >= attempts // 2
            assert all(trial["accepted"] == (trial["drift"] <= drift) for trial in trials)
            assert math.isclose(summary["median_speedup"], statistics.median(
                trial["speedup"] for trial in kept), rel_tol=1e-12)
            accepted.append(len(kept))
        control, speedup = [s["median_speedup"] for s in row["summaries"]]
        controls.append(control)
        ratios.append(speedup)
        if selected(row["config"], config):
            active_ratios.append(speedup)
            if speedup < 1:
                regressions.append(dict(case=row["case"], seed=row["seed"], speedup=speedup, control=control))
    bracket_summary = dict(cases=len(cases), seed_groups=len(bracket["rows"]), seeds=seeds,
        attempts=attempts, repeat=repeat, max_drift=drift, minimum_accepted=min(accepted),
        control_range=[min(controls), max(controls)], candidate_range=[min(ratios), max(ratios)],
        changed_seed_combinations=len(active_ratios), changed_geomean=geomean(active_ratios),
        changed_range=[min(active_ratios), max(active_ratios)], changed_below_one=regressions,
        all_rejected_samples_retained=True)
    changed_ids = set(overall["changed_cases"])
    perf = dict(standard_cases=109, versus_1001=overall, versus_d32=incremental,
        dual_interface_reference_cases=125, reference_matmul_tf32=False,
        max_abs_error_all=max(row["max_abs_error"] for row in reference),
        max_abs_error_changed=max(row["max_abs_error"] for row in reference if str(row["case"]) in changed_ids),
        bracketed=bracket_summary, official_new_score=None)
    (release / "performance_summary.json").write_text(json.dumps(perf, indent=2) + "\n")
    table = []
    for name in ("29", "43", "59", "104", "d64_bs16_t2304", "d128_bs16_t1280"):
        group = [row for row in bracket["rows"] if row["case"] == name]
        if group:
            values = [row["summaries"][1]["median_speedup"] for row in group]
            table.append(f"| {name} | {min(values):.5f}–{max(values):.5f}× |")
    readme = f'''# 2026-10-02 NSA 完整块读取最终候选

提交本目录 `submission.py` 全文；开发源码为 `nsa.py`。本版已通过本地发布验证。
正式已知仍是10.1的 **87.93分**；本版尚无OJ分数，**88.5尚未确认达到**。
源码SHA256：`{digest(sub)}`。

在D32 v1上，仅对默认S1/BS16/G16/64线程的完整块改进K/V读取。
D64沿用grid≥2304，并要求seq_len≥{config['d64_min_seq']}；D128沿用grid≥1280。
先验证block编号，再用同地址TileLang视图访问整块，每lane的8个fp16分为4个uint32读取。
这样既能消除重复边界判断，也避免编译器保留aggregate-copy私有数组。
沿用Q/K/V/O共享布局和7处wave同步，没有增加kernel启动或输入准备。
41个原有非分派函数AST保持不变，显式调参继续原路径。

109例四轮交替、每图200调用、每轮7次采样：

| 比较范围 | 用例数 | 几何平均加速比 |
|---|---:|---:|
| 相对87.93分的10.1，全部 | 109 | **{overall['geomean_speedup']:.8f}×** |
| 相对10.1，设备码改变 | {len(overall['changed_cases'])} | {overall['changed_geomean_speedup']:.8f}× |
| 相对D32 v1，全部 | 109 | {incremental['geomean_speedup']:.8f}× |
| 相对D32 v1，新增改动 | {len(incremental['changed_cases'])} | {incremental['changed_geomean_speedup']:.8f}× |
| 相对D32 v1，设备码不变 | {incremental['unchanged_cases']} | {incremental['unchanged_geomean_speedup']:.8f}× |

子集统计不能替代全量；本地比值也不是OJ得分。`full.json`保留全部计时和设备码哈希。
最终文件另测{len(cases)}个形状、{len(seeds)}个种子、每组{attempts}次A/B/A、每图{repeat}调用。
同源对照{min(controls):.5f}–{max(controls):.5f}×；改动组合几何平均{geomean(active_ratios):.8f}×。
全部拒绝样本和所有负结果均保留，详见`performance_summary.json`和原始夹测报告。

| 代表形状 | 最终文件各种子加速比 |
|---|---:|
{chr(10).join(table)}

初版D64短序列在32/64长度出现约1%的数据相关回退，最终保留seq_len<128的原路径。
长度128边界在初版三个种子分别为0.98988/1.00823/1.03181×；不能声称任意输入都加速。
初版及全部不利记录保存在`../20261002_blocks_v1`，没有按单个测试编号分派。

验证：125例严格FP32双接口参考，36个边界及源码/参数/真实shared发射大小核对，
6组极端int32索引，{len(checks['fallbacks'])}项调参设备码等价，18次同地址图重放输入更新，
6组本地RestrictedPython host guard。另有{len(checks['unsupported'])}项保持与基线相同的不支持结果。
全部109例开发/提交设备码与实际计时记录相同，传统18组等价检查也通过。
最大绝对误差{perf['max_abs_error_all']}，新增读取不改变fp16值；CPU证明覆盖lane归属、
整块地址、K共享双射和K/V MMA读取。没有关闭race/bounds检查，没有使用异步拷贝或修改后端。
完整官方沙箱仍需OJ确认。复现命令和证据见`commands.sh`、`release_manifest.json`。
'''
    (release / "README.md").write_text(readme)
    commands = ["#!/usr/bin/env bash", "# Run from race_tests/nsa; keep GPU commands sequential.",
        "set -eo pipefail", "source env.sh", "",
        f"python check_submission_nsa.py {relative}/nsa.py {relative}/submission.py > {relative}/static_checks.log",
        "python " + shlex.join(full["command"]) + f" > {relative}/full.log 2>&1",
        f"python experiments/20261002_goal885/verify_reference.py {relative}/submission.py --extras --output {relative}/verification_fp32.json > {relative}/verification_fp32.log 2>&1",
        f"python experiments/20261002_goal885/verify_blocks.py --directory {relative} --output {relative}/release_checks.json > {relative}/release_checks.log 2>&1",
        f"python experiments/20261002_goal885/check_block_layouts.py {relative}/nsa.py --output {relative}/layout_proof.json",
        f"python check_equiv.py {relative}/nsa.py {relative}/submission.py > {relative}/equivalence.log 2>&1",
        f"python experiments/20261002_goal885/audit_sources.py --directory {relative} > {relative}/device_audit.log 2>&1",
        "python " + shlex.join(bracket["command"]) + f" > {relative}/bracketed_multiseed.log 2>&1",
        f"python experiments/20261002_goal885/write_release.py --directory {relative}"]
    (release / "commands.sh").write_text("\n".join(commands) + "\n")
    (release / "commands.sh").chmod(0o755)
    evidence = [path for path in release.rglob("*") if path.is_file()
                and path.name not in ("nsa.py", "submission.py", "release_manifest.json")
                and "__pycache__" not in path.parts]
    evidence += [path for path in HERE.iterdir() if path.is_file() and path.suffix in
                 (".py", ".json", ".log", ".md", ".cpp", ".ll", ".txt")]
    evidence += [path for path in (ROOT / assembly["initial_candidate"]).iterdir()
                 if path.is_file() and path.suffix in (".py", ".json", ".log", ".md")]
    evidence += [ROOT / name for name in ("benchmark_nsa.py", "verify_nsa.py", "check_equiv.py",
        "check_submission_nsa.py", "experiment_bench.py", "kernel_source.py", "test_cases_nsa_fwd.json", "env.sh",
        "experiments/20261002_tuning/verify_candidate.py", "experiments/20261001_tuning/verify_release.py",
        "experiments/20260928_guard_fix/check_restricted_host.py")]
    evidence += [ROOT.parent / "moe" / name for name in ("strip_comments.py", "check_submission.py")]
    manifest = dict(date="2026-10-02", status="validated locally; OJ confirmation pending", directory=relative,
        user_confirmed_baseline_score=87.93, target_score=88.5, official_new_score=None, official_sandbox=False,
        source_sha256={path.name: digest(path) for path in (dev, sub)},
        preserved_baselines=read(HERE / "baseline_manifest.json")["source_sha256"],
        preserved_functions=retained, added_functions=assembly["new_functions"], dispatch_config=config,
        validation_counts={key: len(checks[key]) for key in
            ("boundaries", "sources", "extremes", "fallbacks", "unsupported", "refresh", "guarded")},
        performance=perf, prior_release_manifest_sha256=digest(prior_dir / "release_manifest.json"),
        evidence_sha256={str(path.relative_to(ROOT)) if path.is_relative_to(ROOT)
                         else "../moe/" + path.name: digest(path) for path in sorted(set(evidence))})
    (release / "release_manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    print("PASS: published local release", relative)
    print("versus 10.1", overall["geomean_speedup"], "versus D32", incremental["geomean_speedup"])
    print("source", digest(sub), "evidence files", len(manifest["evidence_sha256"]))


if __name__ == "__main__":
    main()
