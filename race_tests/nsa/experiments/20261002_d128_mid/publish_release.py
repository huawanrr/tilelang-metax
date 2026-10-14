"""Publish a D128 candidate only after recorded local checks have completed."""
import argparse
import ast
import hashlib
import json
from os.path import relpath
from pathlib import Path
import subprocess

from study_summary import geomean, selected_kind, summarize

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def read(path):
    return json.loads(path.read_text())


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def check_hashes(mapping, root=ROOT):
    for name, expected in mapping.items():
        assert digest(root / name) == expected, name


def functions(path):
    return {node.name: ast.dump(node) for node in ast.parse(path.read_text()).body
            if isinstance(node, ast.FunctionDef)}


def comparison(rows, baseline, candidate):
    changed = [row for row in rows if
        (row["device_source_sha256"][baseline], row["compile_flags"][baseline]) !=
        (row["device_source_sha256"][candidate], row["compile_flags"][candidate])]
    changed_ids = {row["case"] for row in changed}
    unchanged = [row for row in rows if row["case"] not in changed_ids]
    ratio = lambda row: row["us"][baseline] / row["us"][candidate]
    return dict(geomean_speedup=geomean(map(ratio,rows)),
        changed_cases=[row["case"] for row in changed],changed_geomean_speedup=geomean(map(ratio,changed)),
        unchanged_cases=len(unchanged),unchanged_geomean_speedup=geomean(map(ratio,unchanged)),
        minimum_changed_speedup=min(map(ratio,changed)),
        changed_below_one=[dict(case=row["case"],config=row["config"],speedup=ratio(row))
                           for row in changed if ratio(row)<1])


def domain_description(domain):
    heads = "任意KV head数" if domain["heads"] is None else "KV head数为" + "/".join(map(str,domain["heads"]))
    return (f"{domain['min_grid']} <= B*H*T < {domain['max_grid_exclusive']}，"
            f"T≥{domain['min_seq']}，{heads}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--directory",required=True)
    args = parser.parse_args()
    release = Path(args.directory).resolve()
    relative = str(release.relative_to(ROOT))
    assert not (release / "release_manifest.json").exists(), "Do not overwrite a published release"
    dev, sub = release / "nsa.py", release / "submission.py"
    assembly = read(release / "assembly.json")
    config = assembly["config"]
    full, checks, reference, audit, bracket_audit, proof, pipeline = [read(release / name) for name in
        ("full.json","release_checks.json","verification_fp32.json","device_audit.json",
         "bracketed_source_audit.json","layout_proof.json","validation_pipeline.json")]
    prior_dir = ROOT / "experiments/20261002_output_v1"
    prior = read(prior_dir / "release_manifest.json")
    check_hashes(prior["source_sha256"],prior_dir)
    for mapping in (prior["preserved_baselines"],prior["evidence_sha256"],assembly["source_sha256"],
                    full["source_sha256"],checks["source_sha256"],audit["source_sha256"],
                    bracket_audit["source_sha256"],bracket_audit["benchmark_reports_sha256"]):
        check_hashes(mapping)
    preserved = read(release / "preserved_releases.json")
    assert preserved["status"] == "PASS"
    check_hashes(preserved["prior_manifests"])
    assert all(record["status"] == "PASS" for record in (checks,audit,bracket_audit,proof,pipeline))
    assert len(pipeline["stages"]) == 3
    assert len(reference) == 125 and all(row["status"] == "PASS" for row in reference)
    assert len(full["rows"]) == len(audit["rows"]) == 109
    assert [row["config"] for row in full["rows"]] == read(ROOT / "test_cases_nsa_fwd.json")
    assert (full["rounds"],full["repeat"],full["samples"]) == (4,200,7)
    assert audit["full_report_sha256"] == digest(release / "full.json")
    assert len(checks["boundaries"]) == len(checks["sources"]) == checks["expected_boundary_count"]
    assert len(checks["extremes"]) == 6 and len(checks["refresh"]) == 18 and len(checks["guarded"]) == 6
    assert len(checks["fallbacks"]) + len(checks["unsupported"]) == 28
    assert all(row["same_baseline_failure"] for row in checks["unsupported"])
    assert checks["reference_matmul_tf32"] is False
    for row in checks["sources"]:
        assert row["probe_or_baseline_equal"]
        if row["active"]:
            assert len(row["parts"]) == 1
            part = row["parts"][0]
            assert part["shared_bytes"] == 4096 and part["block_barriers"] == 0
            assert part["wave_barriers"] == (3 if row["kind"] == "linear" else 7)
            assert part["launch_bounds"] == ["64"]
    for row in audit["rows"]:
        assert row["development_submission_equal"] and row["matches_measured_source"]
        for part in row["parts"]:
            assert digest(ROOT / part["source"]) == part["sha256"]
    assert all(row["development_submission_equal"] and row["measured_probe_or_baseline_equal"]
               for row in bracket_audit["rows"])
    assert len(proof["modules"]) == 1 and proof["modules"][0]["sha256"] == digest(dev)
    assert proof["modules"][0]["protected_shared_dependencies"] == 3
    static = (release / "static_checks.log").read_text().splitlines()
    assert len(static) == 2 and all(line.endswith(" PASS") for line in static)
    equiv = (release / "equivalence.log").read_text().splitlines()
    assert equiv[-1] == "ALL EQUIVALENT" and sum(line.endswith(": EQUIVALENT") for line in equiv) == 18
    before, after = functions(prior_dir / "nsa.py"),functions(dev)
    retained = [name for name in before if name != "_get_kernel"]
    assert len(retained) == 44 and set(retained) == set(assembly["retained_functions"])
    assert all(before[name] == after[name] for name in retained)
    assert set(after) - set(before) == set(assembly["new_functions"]) == {"native_sparse_attention_linear_v_blocks"}
    assert after["native_sparse_attention_linear_v_blocks"] == functions(ROOT / config["linear"]["probe"])["native_sparse_attention_linear_v_blocks"]
    measured = list(full["source_sha256"])
    candidate = measured.index(str(sub.relative_to(ROOT)))
    old1 = measured.index("experiments/20261001_final/submission.py")
    old2 = measured.index("experiments/20261002_output_v1/submission.py")
    overall,incremental = comparison(full["rows"],old1,candidate),comparison(full["rows"],old2,candidate)
    assert all((selected_kind(row["config"],config) != "base") == (row["case"] in incremental["changed_cases"])
               for row in full["rows"])
    brackets = [summarize(ROOT / name,config) for name in config["bracket_reports"]]
    all_bracket_cases = {row["case"] for name in config["bracket_reports"] for row in read(ROOT / name)["rows"]}
    assert {row["case"] for row in bracket_audit["rows"]} == all_bracket_cases
    performance = dict(standard_cases=109,versus_1001=overall,versus_output_v1=incremental,
        bracketed=[{key:value for key,value in report.items() if key != "rows"} for report in brackets],
        max_abs_error=max(row["max_abs_error"] for row in reference),reference_tf32=False,
        reference_dual_interface_cases=125,official_new_score=None)
    (release / "performance_summary.json").write_text(json.dumps(performance,indent=2)+"\n")
    changed_rows = "\n".join(
        f"| {row['case']} | {row['config']['B']} | {row['config']['SEQ_LEN']} | {row['config']['H']} | {row['us'][old2]:.6f} | {row['us'][candidate]:.6f} | {row['us'][old2]/row['us'][candidate]:.6f}× |"
        for row in full["rows"] if row["case"] in incremental["changed_cases"])
    bracket_rows = "\n".join(
        f"| {report['shapes']} | {report['seed_combinations']} | {report['active_combinations']} | {report['active_geomean']:.8f}× | {report['active_range'][0]:.6f}–{report['active_range'][1]:.6f}× |"
        for report in brackets)
    readme = f'''# NSA D128 中小网格最终候选

提交本目录 `submission.py` 全文；开发源码为 `nsa.py`。
本地发布验证完成。正式已知仍是10.1的87.93分；本版暂无OJ回传，88.5尚未确认达到。
提交SHA256：`{digest(sub)}`。

在output_v1上新增D128完整块读取builder，并调整统一分派。
默认S1/D128/BS16/G16/64线程、完整块时：

- {domain_description(config['linear'])}：成对half读取K/V，保留原Q/O、数学顺序和3处wave同步。
- {domain_description(config['coalesced'])}：复用原合并Q/O完整块builder，保留7处wave同步。

两个路径实际shared均为4096 bytes，不增加kernel启动。原44个非分派函数AST全部保持，
显式调参及范围外形状保留原分派。未按用例编号、输入内容或计时状态分派。

109例同输入/输出，四轮交替、每图200调用、每轮7次采样：

| 比较范围 | 用例数 | 几何平均加速比 |
|---|---:|---:|
| 相对87.93分10.1，全部 | 109 | **{overall['geomean_speedup']:.8f}×** |
| 相对output_v1，全部 | 109 | **{incremental['geomean_speedup']:.8f}×** |
| 相对output_v1，新增改动 | {len(incremental['changed_cases'])} | {incremental['changed_geomean_speedup']:.8f}× |
| 相对output_v1，设备码相同 | {incremental['unchanged_cases']} | {incremental['unchanged_geomean_speedup']:.8f}× |

新增改动逐项结果，时间单位μs；全部负结果与历史路径回退均保留在performance_summary.json：

| 本地用例 | B | T | H | output_v1 | 本版 | 加速比 |
|---|---:|---:|---:|---:|---:|---:|
{changed_rows}

两组独立形状列表的3种子、24次A/B/A、每图500调用，含同源控制和全部拒绝样本：

| 形状数 | 种子组合数 | 最终启用组合数 | 启用组合几何平均 | 启用组合范围 |
|---:|---:|---:|---:|---:|
{bracket_rows}

此为子集统计，不能替代109例全量结果。四half、较低网格的合并Q/O及多头的负结果
均保存在 `../20261002_d128_mid`，没有删除不利样本。最终{len(bracket_audit['rows'])}个夹测形状的
源码/编译参数已与所测probe或原基线逐一核对。

125例严格FP32双接口、{len(checks['boundaries'])}个边界及实际shared发射核对、6组极端索引、
{len(checks['fallbacks'])}项调参等价、{len(checks['unsupported'])}项相同原有编译失败、18次同地址输入更新、6组RestrictedPython host guard、
109例实际计时源码审计和18组传统等价检查全部通过。最大绝对误差{performance['max_abs_error']}。
CPU枚举实际loader/store的AST，核对2048元素的lane归属、shared双射、同地址块视图与guard边界。
没有异步拷贝、缓存输入/输出、后端修改或关闭race/bounds检查；完整官方沙箱及成绩仍待OJ确认。

`commands.sh` 在新临时目录复现。完整原始证据、父版本保护记录及哈希见release_manifest.json。
'''
    (release / "README.md").write_text(readme)
    commands = f'''#!/usr/bin/env bash
# Run from race_tests/nsa; GPU commands remain sequential.
set -eo pipefail
source env.sh
task_repro_dir=$(mktemp -d experiments/20261002_d128_repro.XXXXXX)
cp {relative}/nsa.py {relative}/submission.py {relative}/assembly.json "$task_repro_dir/"
python check_submission_nsa.py "$task_repro_dir/nsa.py" "$task_repro_dir/submission.py" > "$task_repro_dir/static_checks.log"
python experiments/20261002_d128_mid/compare_family.py experiments/20261001_final/submission.py experiments/20261002_output_v1/submission.py "$task_repro_dir/submission.py" --cases all --rounds 4 --repeat 200 --samples 7 --output "$task_repro_dir/full.json" > "$task_repro_dir/full.log" 2>&1
python experiments/20261002_d128_mid/check_linear_layouts.py "$task_repro_dir/nsa.py" --output "$task_repro_dir/layout_proof.json"
python experiments/20261002_d128_mid/verify_d128.py --directory "$task_repro_dir" --output "$task_repro_dir/release_checks.json" > "$task_repro_dir/release_checks.log" 2>&1
python experiments/20261002_d128_mid/validate_release.py --directory "$task_repro_dir" > "$task_repro_dir/validation_pipeline.log" 2>&1
printf 'Reports: %s\\n' "$task_repro_dir"
'''
    (release / "commands.sh").write_text(commands)
    (release / "commands.sh").chmod(0o755)
    subprocess.run(["bash","-n",str(release / "commands.sh")],check=True)
    evidence = [path for folder in (release,HERE) for path in folder.rglob("*")
        if path.is_file() and "__pycache__" not in path.parts and path.name != "release_manifest.json"
        and path not in (dev,sub)]
    evidence += [ROOT / name for name in ("benchmark_nsa.py","verify_nsa.py","check_equiv.py",
        "check_submission_nsa.py","experiment_bench.py","kernel_source.py","test_cases_nsa_fwd.json","env.sh",
        "experiments/20261002_tuning/verify_candidate.py","experiments/20261001_tuning/verify_release.py",
        "experiments/20260928_guard_fix/check_restricted_host.py")]
    evidence += [ROOT / name for name in preserved["prior_manifests"]]
    evidence += [ROOT.parent / "moe" / name for name in ("strip_comments.py","check_submission.py")]
    baselines = dict(prior["preserved_baselines"])
    baselines.update({str((prior_dir/name).relative_to(ROOT)):digest(prior_dir/name) for name in ("nsa.py","submission.py")})
    manifest = dict(date="2026-10-02",directory=relative,status="validated locally; OJ confirmation pending",
        user_confirmed_baseline_score=87.93,target_score=88.5,official_new_score=None,official_sandbox=False,
        source_sha256={path.name:digest(path) for path in (dev,sub)},preserved_baselines=baselines,
        prior_release_manifest_sha256=digest(prior_dir / "release_manifest.json"),dispatch_config=config,
        preserved_functions=retained,added_functions=assembly["new_functions"],
        validation_counts={key:len(checks[key]) for key in
            ("boundaries","sources","extremes","fallbacks","unsupported","refresh","guarded")},
        performance=performance,evidence_sha256={relpath(path,ROOT):digest(path) for path in sorted(set(evidence))})
    (release / "release_manifest.json").write_text(json.dumps(manifest,indent=2)+"\n")
    print(json.dumps(dict(directory=relative,submission_sha256=digest(sub),
        all_109_vs_1001=overall["geomean_speedup"],all_109_vs_output_v1=incremental["geomean_speedup"],
        evidence_files=len(manifest["evidence_sha256"]),official_new_score=None),indent=2))


if __name__ == "__main__":
    main()
