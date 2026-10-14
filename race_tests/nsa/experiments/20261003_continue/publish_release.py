"""Publish the rebased D128 candidate after checking its recorded evidence."""

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
BASE = ROOT / "experiments/20261002_mid_v1"


def read(path):
    return json.loads(path.read_text())


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def check_hashes(mapping, root=ROOT):
    for name, expected in mapping.items():
        assert digest(root / name) == expected, root / name


def functions(path):
    return {node.name: ast.dump(node) for node in ast.parse(path.read_text()).body
            if isinstance(node, ast.FunctionDef)}


def compare(rows, baseline, candidate):
    changed, unchanged = [], []
    for row in rows:
        same = (row["device_source_sha256"][baseline] == row["device_source_sha256"][candidate]
                and row["compile_flags"][baseline] == row["compile_flags"][candidate])
        (unchanged if same else changed).append(row)
    ratio = lambda row: row["us"][baseline] / row["us"][candidate]
    return dict(
        geomean_speedup=geomean(map(ratio, rows)),
        changed_cases=[row["case"] for row in changed],
        changed_geomean_speedup=geomean(map(ratio, changed)),
        changed_range=[min(map(ratio, changed)), max(map(ratio, changed))],
        unchanged_cases=len(unchanged),
        unchanged_geomean_speedup=geomean(map(ratio, unchanged)),
        below_one=[dict(case=row["case"], config=row["config"], speedup=ratio(row),
                       device_source_changed=row in changed) for row in rows if ratio(row) < 1],
    )


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--directory", required=True)
    args = parser.parse_args()
    release = Path(args.directory).resolve()
    relative = str(release.relative_to(ROOT))
    assert not (release / "release_manifest.json").exists(), "Preserve published releases"
    dev, sub = release / "nsa.py", release / "submission.py"
    assembly = read(release / "assembly.json")
    config = assembly["config"]
    parent_dispatch = read(release / "parent_dispatch_audit.json")
    assert parent_dispatch["status"] == "PASS"
    check_hashes(parent_dispatch["source_sha256"])
    full, checks, reference, audit, bracket_audit, proof, pipeline = [read(release / name) for name in (
        "full.json", "release_checks.json", "verification_fp32.json", "device_audit.json",
        "bracketed_source_audit.json", "layout_proof.json", "validation_pipeline.json",
    )]
    preserved = []
    for name in ("20261002_d32_v1", "20261002_blocks_v2", "20261002_mid_v1", "20261002_output_v1"):
        directory = ROOT / "experiments" / name
        manifest = read(directory / "release_manifest.json")
        check_hashes(manifest["source_sha256"], directory)
        check_hashes(manifest["preserved_baselines"])
        check_hashes(manifest["evidence_sha256"])
        preserved.append(dict(path=str((directory / "release_manifest.json").relative_to(ROOT)),
            sha256=digest(directory / "release_manifest.json"),
            verified_hashes=sum(len(manifest[key]) for key in
                ("source_sha256", "preserved_baselines", "evidence_sha256"))))
    for mapping in (assembly["source_sha256"], full["source_sha256"], checks["source_sha256"],
                    audit["source_sha256"], bracket_audit["source_sha256"],
                    bracket_audit["benchmark_reports_sha256"], read(HERE / "baseline_manifest.json")["source_sha256"]):
        check_hashes(mapping)
    assert all(record["status"] == "PASS" for record in (checks, audit, bracket_audit, proof, pipeline))
    assert len(pipeline["stages"]) == 3
    assert len(reference) == 125 and all(row["status"] == "PASS" for row in reference)
    assert len(full["rows"]) == len(audit["rows"]) == 109
    assert [row["config"] for row in full["rows"]] == read(ROOT / "test_cases_nsa_fwd.json")
    assert (full["rounds"], full["repeat"], full["samples"]) == (4, 200, 7)
    assert audit["full_report_sha256"] == digest(release / "full.json")
    assert len(checks["boundaries"]) == len(checks["sources"]) == checks["expected_boundary_count"]
    assert (len(checks["extremes"]), len(checks["refresh"]), len(checks["guarded"])) == (6, 18, 6)
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
    before, after = functions(BASE / "nsa.py"), functions(dev)
    retained = [name for name in before if name != "_get_kernel"]
    assert len(retained) == 44 and set(retained) == set(assembly["retained_functions"])
    assert all(before[name] == after[name] for name in retained)
    assert set(after) - set(before) == {"native_sparse_attention_linear_v_blocks"}
    assert after["native_sparse_attention_linear_v_blocks"] == functions(ROOT / config["linear"]["probe"])["native_sparse_attention_linear_v_blocks"]
    measured = list(full["source_sha256"])
    candidate = measured.index(str(sub.relative_to(ROOT)))
    baseline = measured.index("experiments/20261002_mid_v1/submission.py")
    comparison = compare(full["rows"], baseline, candidate)
    assert all((selected_kind(row["config"], config) != "base") == (row["case"] in comparison["changed_cases"])
               for row in full["rows"])
    assert comparison["geomean_speedup"] > 1 and comparison["changed_range"][0] > 1
    brackets = [summarize(ROOT / name, config) for name in config["bracket_reports"]]
    assert not any(report["active_below_one"] for report in brackets)
    expected_cases = {row["case"] for name in config["bracket_reports"] for row in read(ROOT / name)["rows"]}
    assert {row["case"] for row in bracket_audit["rows"]} == expected_cases
    assert {row["case"] for row in parent_dispatch["rows"]} == expected_cases
    performance = dict(standard_cases=109, versus_mid_v1=comparison,
        bracketed=[{key: value for key, value in report.items() if key != "rows"} for report in brackets],
        bracketed_note="Previous D128 probes used output_v1; source and compiler flags for every relevant D128 shape equal this rebased candidate or mid_v1 baseline.",
        max_abs_error=max(row["max_abs_error"] for row in reference), reference_tf32=False,
        reference_dual_interface_cases=125, user_confirmed_baseline_score=88.29, official_new_score=None)
    (release / "performance_summary.json").write_text(json.dumps(performance, indent=2) + "\n")
    (release / "preserved_releases.json").write_text(json.dumps(dict(status="PASS", releases=preserved), indent=2) + "\n")
    changed_rows = "\n".join(
        f"| {row['case']} | {row['config']['B']} | {row['config']['SEQ_LEN']} | {row['config']['H']} | {row['us'][baseline]:.6f} | {row['us'][candidate]:.6f} | {row['us'][baseline] / row['us'][candidate]:.6f}× |"
        for row in full["rows"] if row["case"] in comparison["changed_cases"])
    readme = f'''# NSA D128 候选（2026-10-03）

提交本目录 `submission.py` 全文，开发源码为 `nsa.py`。
基线为用户确认 **88.29 分**的 `../20261002_mid_v1/submission.py`。
本版已完成本地验证，正式 OJ 分数待回传；本地加速比不能换算为已确认得分。
提交 SHA256：`{digest(sub)}`。

接续上一会话未发布的 D128 工作，直接在 mid_v1 上组装。默认 S1/D128/BS16/G16/64线程、完整块：

- `128 < B*H*T < 768`、H1：检查 block 编号后成对读取 K/V，保留原 Q/O、数学顺序和3处 wave 同步。
- `1024 <= B*H*T < 1280`、T≥32、H1/H2：复用原合并 Q/O 完整块 builder，保留7处 wave 同步。

两个路径实际 shared 均为4096 bytes，不增加kernel启动。原44个非分派函数AST不变。
768–1023过渡范围、其他形状和显式调参均沿用 mid_v1。

109例同输入/输出，4轮交替、每图200调用、每轮7次采样：

| 比较范围 | 用例数 | 几何平均加速比 |
|---|---:|---:|
| 相对88.29版，全部 | 109 | **{comparison['geomean_speedup']:.8f}×** |
| 新增改动 | {len(comparison['changed_cases'])} | **{comparison['changed_geomean_speedup']:.8f}×** |
| 设备码相同 | {comparison['unchanged_cases']} | {comparison['unchanged_geomean_speedup']:.8f}× |

新增改动全部加速，逐项时间单位为μs。未改变设备码的case42本次约1.2%回退，
同源计时的波动和所有低于1的原始结果均保留在 full.json / performance_summary.json。

| 本地用例 | B | T | H | mid_v1 | 本版 | 加速比 |
|---|---:|---:|---:|---:|---:|---:|
{changed_rows}

此前两组35/20形状、3种子、24次A/B/A、每图500调用的测量中，最终范围108个组合全部加速。
原报告仍在 `../20261002_d128_mid`，没有覆盖。两组测量使用output_v1作为基线；
相关D128内核与mid_v1相同，最终{len(bracket_audit['rows'])}个形状逐一核对了probe/基线设备源码和编译参数。
不把这些子集统计当作109例全量收益。

验证通过：125例严格FP32双接口，{len(checks['boundaries'])}个边界及实际shared发射检查，6组极端索引，
{len(checks['fallbacks'])}项调参等价、{len(checks['unsupported'])}项保持原有编译失败，18次同地址输入更新，6组RestrictedPython host guard，
109例实际计时设备码审计及18组开发/提交等价。最大绝对误差{performance['max_abs_error']}。
CPU枚举实际load/store索引、lane归属、shared双射、同地址视图及guard边界。
未采用异步拷贝、输入/输出缓存、后端改动或关闭race/bounds检查。

`commands.sh` 在新临时目录复现。完整证据和父版本保护记录见 release_manifest.json。
'''
    (release / "README.md").write_text(readme)
    commands = f'''#!/usr/bin/env bash
set -eo pipefail
source env.sh
task_repro_dir=$(mktemp -d experiments/20261003_d128_repro.XXXXXX)
cp {relative}/nsa.py {relative}/submission.py {relative}/assembly.json "$task_repro_dir/"
python check_submission_nsa.py "$task_repro_dir/nsa.py" "$task_repro_dir/submission.py" > "$task_repro_dir/static_checks.log"
python experiments/20261003_continue/compare_family.py experiments/20261002_mid_v1/submission.py "$task_repro_dir/submission.py" --cases all --rounds 4 --repeat 200 --samples 7 --output "$task_repro_dir/full.json" > "$task_repro_dir/full.log" 2>&1
python experiments/20261003_continue/check_linear_layouts.py "$task_repro_dir/nsa.py" --output "$task_repro_dir/layout_proof.json"
python experiments/20261003_continue/check_parent_dispatch.py --directory "$task_repro_dir"
python experiments/20261003_continue/verify_d128.py --directory "$task_repro_dir" --output "$task_repro_dir/release_checks.json" > "$task_repro_dir/release_checks.log" 2>&1
python experiments/20261003_continue/validate_release.py --directory "$task_repro_dir" > "$task_repro_dir/validation_pipeline.log" 2>&1
printf 'Reports: %s\\n' "$task_repro_dir"
'''
    (release / "commands.sh").write_text(commands)
    (release / "commands.sh").chmod(0o755)
    subprocess.run(["bash", "-n", str(release / "commands.sh")], check=True)
    evidence = [path for folder in (release, HERE) for path in folder.rglob("*")
                if path.is_file() and "__pycache__" not in path.parts
                and path.name != "release_manifest.json" and path not in (dev, sub)]
    evidence += [ROOT / name for name in (
        "benchmark_nsa.py", "verify_nsa.py", "check_equiv.py", "check_submission_nsa.py",
        "experiment_bench.py", "kernel_source.py", "test_cases_nsa_fwd.json", "env.sh",
        "experiments/20261002_tuning/verify_candidate.py", "experiments/20261001_tuning/verify_release.py",
        "experiments/20260928_guard_fix/check_restricted_host.py",
    )]
    evidence += [ROOT / record["path"] for record in preserved]
    evidence += [ROOT / name for name in read(HERE / "baseline_manifest.json")["source_sha256"]]
    evidence += [path for path in (ROOT / "experiments/20261002_d128_mid").rglob("*")
                 if path.is_file() and "__pycache__" not in path.parts]
    evidence += [ROOT.parent / "moe" / name for name in ("strip_comments.py", "check_submission.py")]
    parent = read(BASE / "release_manifest.json")
    baselines = dict(parent["preserved_baselines"])
    baselines.update({str((BASE / name).relative_to(ROOT)): digest(BASE / name) for name in ("nsa.py", "submission.py")})
    manifest = dict(date="2026-10-03", directory=relative, status="validated locally; OJ confirmation pending",
        user_confirmed_baseline_score=88.29, target_score=88.5, official_new_score=None, official_sandbox=False,
        source_sha256={path.name: digest(path) for path in (dev, sub)}, preserved_baselines=baselines,
        prior_release_manifest_sha256=digest(BASE / "release_manifest.json"), dispatch_config=config,
        preserved_functions=retained, added_functions=assembly["new_functions"],
        validation_counts={key: len(checks[key]) for key in
            ("boundaries", "sources", "extremes", "fallbacks", "unsupported", "refresh", "guarded")},
        performance=performance,
        evidence_sha256={relpath(path, ROOT): digest(path) for path in sorted(set(evidence))})
    (release / "release_manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    print(json.dumps(dict(directory=relative, submission_sha256=digest(sub),
        all_109_vs_mid_v1=comparison["geomean_speedup"], evidence_files=len(manifest["evidence_sha256"]),
        official_new_score=None), indent=2))


if __name__ == "__main__":
    main()
