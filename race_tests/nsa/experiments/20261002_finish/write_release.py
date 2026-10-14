"""Close a D32 release only after checking its source and measurement evidence."""
import argparse
import ast
import hashlib
import itertools
import json
import math
from pathlib import Path
import statistics


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def read(path):
    return json.loads(path.read_text())


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def geomean(values):
    return math.exp(statistics.mean(map(math.log, values)))


def functions(path):
    return {node.name: ast.dump(node, include_attributes=False)
            for node in ast.parse(path.read_text()).body if isinstance(node, ast.FunctionDef)}


def check_hashes(values):
    for name, expected in values.items():
        assert digest(ROOT / name) == expected, name


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
        changed_below_one=[dict(case=row["case"], speedup=ratio(row))
                           for row in changed if ratio(row) < 1])


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--directory", required=True)
    args = parser.parse_args()
    release = Path(args.directory).resolve()
    dev, sub = (release / name for name in ("nsa.py", "submission.py"))
    assembly = read(release / "assembly.json")
    full = read(release / "full.json")
    verification = read(release / "verification_fp32.json")
    checks = read(release / "release_checks.json")
    proof = read(release / "layout_proof.json")
    bracket = read(release / "bracketed_multiseed.json")
    audit = read(release / "device_audit.json")
    frozen = read(HERE / "baseline_manifest.json")
    prior_path = ROOT / "experiments/20261002_final/release_manifest.json"
    prior = read(prior_path)
    for hashes in (frozen["source_sha256"], prior["preserved_baselines"],
                   prior["evidence_sha256"], assembly["source_sha256"],
                   full["source_sha256"], checks["source_sha256"],
                   bracket["sha256"], audit["source_sha256"]):
        check_hashes(hashes)
    assert proof["source_sha256"] == digest(dev)
    assert digest(Path(proof["backend_layout_source"])) == proof["backend_layout_sha256"]
    assert checks["status"] == proof["status"] == audit["status"] == "PASS"
    assert checks["reference_matmul_tf32"] is False
    assert len(verification) == 125 and all(row["status"] == "PASS" for row in verification)
    assert len(full["rows"]) == len(audit["rows"]) == 109
    assert [str(row["case"]) for row in full["rows"]] == [str(i) for i in range(1, 110)]
    assert [row["config"] for row in full["rows"]] == read(ROOT / "test_cases_nsa_fwd.json")
    assert audit["full_report_sha256"] == digest(release / "full.json")
    for row in audit["rows"]:
        assert row["development_submission_equal"] and row["matches_measured_source"]
        for part in row["parts"]:
            assert digest(ROOT / part["source"]) == part["sha256"], part["source"]
    for key, count in dict(extremes=7, fallbacks=36, refresh=12, guarded=6, unsupported=7).items():
        assert len(checks[key]) == count, (key, len(checks[key]))
    assert len(checks["boundaries"]) == len(checks["sources"]) >= 30
    assert all(row["same_baseline_failure"] for row in checks["unsupported"])
    static = (release / "static_checks.log").read_text().splitlines()
    assert len(static) == 2 and all(line.endswith(" PASS") for line in static)
    equiv = (release / "equivalence.log").read_text().splitlines()
    assert equiv[-1] == "ALL EQUIVALENT"
    assert sum(line.endswith(": EQUIVALENT") for line in equiv) == 18

    original = functions(ROOT / "experiments/20261002_final/nsa.py")
    current = functions(dev)
    retained = [name for name in original if name != "_get_kernel"]
    assert len(retained) == 37
    assert all(original[name] == current[name] for name in retained)
    assert set(retained) == set(assembly["retained_functions"])
    assert set(current) - set(original) == set(assembly["new_functions"])
    for path in (dev, sub):
        assert not any(marker in path.read_text() for marker in
            ("TL_DISABLE_DATA_RACE_CHECK", "TL_DISABLE_SAFE_MEMORY_ACCESS", "--misched="))

    measured_paths = list(full["source_sha256"])
    candidate = [i for i, name in enumerate(measured_paths)
                 if full["source_sha256"][name] == digest(sub)]
    assert len(candidate) == 1
    candidate = candidate[0]
    old1 = measured_paths.index("experiments/20261001_final/submission.py")
    old2 = measured_paths.index("experiments/20261002_final/submission.py")
    overall = comparison(full["rows"], old1, candidate)
    incremental = comparison(full["rows"], old2, candidate)
    changed_ids = set(overall["changed_cases"])
    assert all(row["config"]["D"] == 32 for row in full["rows"]
               if row["case"] in incremental["changed_cases"])

    command = bracket["command"]
    def option(name):
        return command[command.index(name) + 1]
    case_names = option("--cases").split(",")
    seeds = list(map(int, option("--seeds").split(",")))
    attempts, repeat = int(option("--attempts")), int(option("--repeat"))
    max_drift = float(option("--max-drift"))
    assert [(row["case"], row["seed"]) for row in bracket["rows"]] == list(itertools.product(case_names, seeds))
    hashes = list(bracket["sha256"].values())
    assert len(hashes) == 3 and hashes[0] == hashes[1] and hashes[2] == digest(sub)
    controls, ratios, accepted = [], [], []
    for row in bracket["rows"]:
        assert len(row["summaries"]) == 2
        for summary, trials in zip(row["summaries"], row["trials"][1:]):
            assert len(trials) == summary["total"] == attempts
            kept = [trial for trial in trials if trial["accepted"]]
            assert len(kept) == summary["accepted"] >= attempts // 2
            assert all(trial["accepted"] == (trial["drift"] <= max_drift) for trial in trials)
            assert math.isclose(summary["median_speedup"], statistics.median(
                trial["speedup"] for trial in kept), rel_tol=1e-12)
            accepted.append(len(kept))
        controls.append(row["summaries"][0]["median_speedup"])
        ratios.append(row["summaries"][1]["median_speedup"])
    bracket_summary = dict(cases=len(case_names), seed_groups=len(bracket["rows"]),
        seeds=seeds, attempts=attempts, repeat=repeat, max_drift=max_drift,
        minimum_accepted=min(accepted), control_range=[min(controls), max(controls)],
        candidate_range=[min(ratios), max(ratios)],
        baseline=next(iter(bracket["sha256"])), all_rejected_samples_retained=True)
    perf = dict(standard_cases=109, versus_1001=overall, versus_1002=incremental,
        dual_interface_reference_cases=125, reference_matmul_tf32=False,
        max_abs_error_all=max(row["max_abs_error"] for row in verification),
        max_abs_error_changed=max(row["max_abs_error"] for row in verification
                                  if str(row["case"]) in changed_ids),
        bracketed=bracket_summary, official_new_score=None)
    (release / "performance_summary.json").write_text(json.dumps(perf, indent=2) + "\n")
    table = []
    for name in ("1", "7", "13", "27", "42", "97", "d32_queries_tail"):
        group = [row for row in bracket["rows"] if row["case"] == name]
        if group:
            values = [row["summaries"][1]["median_speedup"] for row in group]
            table.append(f"| {name} | {min(values):.5f}–{max(values):.5f}× |")
    directory_name = str(release.relative_to(ROOT))
    low_scope = ("完整块且 seq_len≥64 的 192<grid<512 形状也使用 compact。\n"
                 if assembly["config"].get("compact_low_aligned") else "")
    readme = f"""# 2026-10-02 NSA D32 最终提交

提交本目录 `submission.py` 全文；开发源码为 `nsa.py`。本版已完成本地验证。
用户确认的 10.1 正式成绩仍为 **87.93**，本版尚无 OJ 分数，**88.5 尚未确认达到**。
完整证据与源码 SHA256 见 `release_manifest.json`，复现命令见 `commands.sh`。

在 10.2 final 的基础上，默认 S1/D32/BS16/G16/64 线程按 `grid=B*H*seq_len` 选择：

- grid≤512：沿用 direct-K 布局与同步，先验证 block 编号再形成地址。
- 512<grid<1024：连续读取 K 后做四次 uint32 shuffle；V 使用线性共享暂存，保留一次 wave barrier。
- H1 且 1024≤grid≤4096：保留原 K shuffle 与 wave 同步，改写索引验证。
- 其他形状和显式调参保持 10.2 原路径。两种公开接口共用 `_get_kernel`。

{low_scope}10.2 的 37 个非分派函数 AST 完整保留，新增 3 个 guard builder 和 1 个 compact builder。
S1/BS32、S2、S8 的此前优化继续保留；每次调用读取当前输入，打包开销完整计入。

109 例四轮交替、每图 200 次调用、每轮 7 次采样：

| 比较范围 | 用例数 | 几何平均加速比 |
|---|---:|---:|
| 相对 10.1，全部 | 109 | **{overall['geomean_speedup']:.8f}×** |
| 相对 10.1，设备码改变 | {len(overall['changed_cases'])} | {overall['changed_geomean_speedup']:.8f}× |
| 相对 10.1，设备码不变 | {overall['unchanged_cases']} | {overall['unchanged_geomean_speedup']:.8f}× |
| 相对 10.2 final，全部 | 109 | {incremental['geomean_speedup']:.8f}× |
| 相对 10.2 final，新增 D32 改动 | {len(incremental['changed_cases'])} | {incremental['changed_geomean_speedup']:.8f}× |

改动子集与全部用例统计范围不同，不能用局部收益代替全量提升。
`full.json` 保留每一轮中位数和所有编译源码哈希，包括不利结果。
相对 10.1 的改动用例最低比值为 {overall['minimum_changed_speedup']:.6f}×；
所有低于 1 的记录在 `performance_summary.json` 的 `changed_below_one` 中。

最终文件另做 {len(case_names)} 个形状、{len(seeds)} 个种子的 A/B/A 长测，每组 {attempts} 次、
每图 {repeat} 次调用。相同输入、相同输出地址，前后基线漂移≤{max_drift:.0%} 才纳入统计；
全部拒绝样本仍保留。同源对照范围为 {min(controls):.5f}–{max(controls):.5f}×，
个别微秒级用例有波动，不能把每个差值都当作稳定收益。

| 代表用例 | 各种子的加速比范围 |
|---|---:|
{chr(10).join(table)}

验证完成：125 例严格 FP32 双接口参考、{len(checks['boundaries'])} 个边界及编译源码/参数对照、
7 组极端 int32 索引、36 项受支持调参回退、12 次同地址图重放输入更新、
6 组本地 RestrictedPython host write guard。原来不支持的 7 组形状/参数保持相同编译失败。
全部 109 例开发/提交设备码相同，且与计时报告哈希一致；18 组传统等价检查也通过。
compact 的 512 个 K 元素、V 共享读写及分母归约经过 CPU 布局证明。
最大绝对误差为 {perf['max_abs_error_all']}，改动用例为 {perf['max_abs_error_changed']}。
未关闭 race/bounds 检查，未使用异步拷贝或修改后端；完整官方沙箱仍以 OJ 为准。

本次补测与未采用方案见 `../20261002_finish/README.md`。
原 10.1、10.2 final 以及根目录旧源码均保留原哈希。
"""
    (release / "README.md").write_text(readme)
    evidence = [release / name for name in (
        "assembly.json", "full.json", "full.log", "verification_fp32.json", "verification_fp32.log",
        "release_checks.json", "release_checks.log", "layout_proof.json", "bracketed_multiseed.json",
        "bracketed_multiseed.log", "device_audit.json", "device_audit.log", "equivalence.log",
        "static_checks.log", "performance_summary.json", "commands.sh", "README.md")]
    evidence += [HERE / name for name in ("write_release.py", "audit_sources.py", "baseline_manifest.json", "README.md")]
    evidence += [HERE / name for name in ("prepare.py", "low_grid_assembly.json", "low_grid_screen.json",
        "low_grid_screen.log", "compact_aligned_multiseed.json", "compact_aligned_multiseed.log",
        "experiment_summary.json", "compare_family.py", "bracketed_multiseed.py", "family_cases.json",
        "compact_low.py", "wave_low.py", "compact_aligned.py", "reference_d32_v1.py")]
    evidence += [ROOT / "experiments/20261002_next" / name for name in (
        "assemble_d32.py", "verify_d32.py", "verify_reference.py", "check_d32_layouts.py",
        "compare_family.py", "bracketed_multiseed.py", "family_cases.json")]
    evidence += [ROOT / "experiments/20261002_next" / name for name in (
        "guard_start_screen.json", "guard_start_screen.log", "guard_start59_resources.json",
        "guard_start_local.py", "guard_start_shuffle.py", "guard_start_local_shuffle.py", "make_guard_start.py")]
    evidence += [ROOT / name for name in ("env.sh", "benchmark_nsa.py", "experiment_bench.py",
        "verify_nsa.py", "kernel_source.py", "check_submission_nsa.py", "check_equiv.py")]
    evidence += [prior_path, ROOT / "experiments/20261002_tuning/verify_candidate.py"]
    evidence += [ROOT / part["source"] for row in audit["rows"] for part in row["parts"]]
    manifest = dict(date="2026-10-02", status="locally_verified; awaiting_official_score",
        directory=directory_name, user_confirmed_baseline_score=87.93, target_score=88.5,
        official_new_score=None, official_sandbox=False,
        source_sha256={path.name: digest(path) for path in (dev, sub)},
        preserved_baselines=frozen["source_sha256"], preserved_functions=retained,
        added_functions=assembly["new_functions"], dispatch_config=assembly["config"],
        validation_counts={key: len(checks[key]) for key in
            ("boundaries", "sources", "extremes", "fallbacks", "refresh", "guarded", "unsupported")},
        performance=perf, prior_release_manifest_sha256=digest(prior_path),
        evidence_sha256={str(path.relative_to(ROOT)): digest(path) for path in evidence})
    (release / "release_manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    print("PASS: verified sources, preserved baselines, all required evidence")
    print(json.dumps(manifest["source_sha256"], indent=2))
    print(json.dumps(perf, indent=2))


if __name__ == "__main__":
    main()
