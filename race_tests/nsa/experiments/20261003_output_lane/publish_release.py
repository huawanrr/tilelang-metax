"""Check all recorded evidence before freezing this local D32 candidate."""
import argparse
import ast
import hashlib
import json
from os.path import relpath
from pathlib import Path
import subprocess

from research_summary import geomean, summarize
from verify_lane import selected

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
PARENT = ROOT / "experiments/20261003_d128_v1"
OFFICIAL = ROOT / "experiments/20261002_mid_v1"


def read(path):
    return json.loads(path.read_text())


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def check_hashes(mapping, root=ROOT):
    for name, expected in mapping.items():
        assert digest(root / name) == expected, root / name


def functions(path):
    return {n.name: ast.dump(n) for n in ast.parse(path.read_text()).body if isinstance(n, ast.FunctionDef)}


def comparison(rows, baseline, candidate):
    changed, unchanged = [], []
    for row in rows:
        same = (row["device_source_sha256"][baseline] == row["device_source_sha256"][candidate]
                and row["compile_flags"][baseline] == row["compile_flags"][candidate])
        (unchanged if same else changed).append(row)
    ratio = lambda row: row["us"][baseline] / row["us"][candidate]
    return dict(geomean_speedup=geomean(map(ratio, rows)),
        changed_cases=[r["case"] for r in changed], changed_geomean_speedup=geomean(map(ratio, changed)),
        changed_range=[min(map(ratio, changed)), max(map(ratio, changed))],
        unchanged_count=len(unchanged), unchanged_geomean_speedup=geomean(map(ratio, unchanged)),
        below_one=[dict(case=r["case"], config=r["config"], speedup=ratio(r),
            source_changed=r in changed) for r in rows if ratio(r) < 1])


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--directory", required=True)
    a = p.parse_args()
    release = Path(a.directory).resolve()
    relative = str(release.relative_to(ROOT))
    assert not (release / "release_manifest.json").exists(), "Preserve published releases"
    assert not (HERE / "study_manifest.json").exists(), "Preserve frozen research"
    dev, sub = release / "nsa.py", release / "submission.py"
    assembly = read(release / "assembly.json")
    config = assembly["config"]
    full, checks, reference, audit, bracket_audit, proof, pipeline, host = [read(release / name) for name in (
        "full.json", "release_checks.json", "verification_fp32.json", "device_audit.json",
        "bracketed_source_audit.json", "layout_proof.json", "validation_pipeline.json", "host_dispatch_audit.json")]
    for report in (checks, audit, bracket_audit, proof, pipeline, host):
        assert report["status"] == "PASS"
    for mapping in (assembly["source_sha256"], full["source_sha256"], checks["source_sha256"],
                    audit["source_sha256"], bracket_audit["source_sha256"],
                    bracket_audit["benchmark_reports_sha256"], host["source_sha256"]):
        check_hashes(mapping)
    assert len(reference) == 125 and all(row["status"] == "PASS" for row in reference)
    assert len(full["rows"]) == len(audit["rows"]) == 109
    assert [row["config"] for row in full["rows"]] == read(ROOT / "test_cases_nsa_fwd.json")
    assert (full["rounds"], full["repeat"], full["samples"]) == (4, 200, 7)
    assert audit["full_report_sha256"] == digest(release / "full.json")
    assert len(pipeline["stages"]) == 3
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
            assert part["shared_bytes"] == 1024 and part["block_barriers"] == 1
            assert part["wave_barriers"] == 0 and part["launch_bounds"] == ["64"]
    for row in audit["rows"]:
        assert row["development_submission_equal"] and row["matches_measured_source"]
        for part in row["parts"]:
            assert digest(ROOT / part["source"]) == part["sha256"]
    assert len(bracket_audit["rows"]) == 36
    assert all(row["development_submission_equal"] and row["measured_probe_or_baseline_equal"]
               for row in bracket_audit["rows"])
    assert proof["sha256"] == digest(dev) and proof["elements"] == 512
    static = (release / "static_checks.log").read_text().splitlines()
    assert len(static) == 2 and all(line.endswith(" PASS") for line in static)
    equiv = (release / "equivalence.log").read_text().splitlines()
    assert equiv[-1] == "ALL EQUIVALENT" and sum(line.endswith(": EQUIVALENT") for line in equiv) == 18
    before, after = functions(PARENT / "nsa.py"), functions(dev)
    retained = [name for name in before if name != "_get_kernel"]
    assert len(retained) == 45 and set(retained) == set(assembly["retained_functions"])
    assert all(before[name] == after[name] for name in retained)
    assert set(after) - set(before) == {"native_sparse_attention_d32_output_lane"}
    probe_fn = next(n for n in ast.parse((ROOT / config["probe"]).read_text()).body
                    if isinstance(n, ast.FunctionDef) and n.name == "native_sparse_attention_d32_shuffle")
    probe_fn.name = "native_sparse_attention_d32_output_lane"
    assert after[probe_fn.name] == ast.dump(probe_fn)
    measured = list(full["source_sha256"])
    candidate = measured.index(str(sub.relative_to(ROOT)))
    parent_index = measured.index("experiments/20261003_d128_v1/submission.py")
    official_index = measured.index("experiments/20261002_mid_v1/submission.py")
    versus_parent = comparison(full["rows"], parent_index, candidate)
    versus_official = comparison(full["rows"], official_index, candidate)
    assert len(versus_parent["changed_cases"]) == 6
    assert all(selected(r["config"], config) == (r["case"] in versus_parent["changed_cases"]) for r in full["rows"])
    assert versus_parent["geomean_speedup"] > 1 and versus_parent["changed_range"][0] > 1
    assert versus_official["geomean_speedup"] > 1
    study = summarize()
    assert config == study["selection"]["config"]
    assert all(row["active"] == selected(row["config"], config) for row in study["bracketed"]["rows"])
    bracket = {k: v for k, v in study["bracketed"].items() if k != "rows"}
    preserved = []
    for directory in (OFFICIAL, PARENT):
        manifest = read(directory / "release_manifest.json")
        check_hashes(manifest["source_sha256"], directory)
        check_hashes(manifest["preserved_baselines"])
        check_hashes(manifest["evidence_sha256"])
        preserved.append(dict(path=str((directory / "release_manifest.json").relative_to(ROOT)),
            sha256=digest(directory / "release_manifest.json"),
            verified_hashes=sum(len(manifest[key]) for key in
                ("source_sha256", "preserved_baselines", "evidence_sha256"))))
    performance = dict(standard_cases=109, versus_d128_v1=versus_parent, versus_mid_v1=versus_official,
        bracketed=bracket, max_abs_error=max(r["max_abs_error"] for r in reference),
        reference_dual_interface_cases=125, reference_matmul_tf32=False,
        user_confirmed_best_score=88.29, official_new_score=None)
    (release / "performance_summary.json").write_text(json.dumps(performance, indent=2) + "\n")
    (release / "preserved_releases.json").write_text(json.dumps(dict(status="PASS", releases=preserved), indent=2) + "\n")
    changed_rows = "\n".join(
        f"| {r['case']} | {r['config']['B']} | {r['config']['SEQ_LEN']} | {r['us'][parent_index]:.6f} | {r['us'][candidate]:.6f} | {r['us'][parent_index]/r['us'][candidate]:.6f}× |"
        for r in full["rows"] if r["case"] in versus_parent["changed_cases"])
    readme = f'''# NSA D32 输出候选（2026-10-03）

提交本目录 `submission.py` 全文，开发源码为 `nsa.py`。
继承 `../20261003_d128_v1`，增加大网格 D32 输出优化。用户确认的正式最佳仍是
`../20261002_mid_v1/submission.py`，**88.29 分**；本版及 D128 父版的 OJ 结果待回传。
提交 SHA256：`{digest(sub)}`。

默认 S1/D32/BS16/G16/64线程、`B*H*T >= 8192` 时使用新 builder。
输出完成 FP32→FP16 转换后，按 uint32 成对进行4次同步 shuffle，调整相邻线程的写入排列。
先检查原始 block 编号，再形成 K/V 地址；完整块的冗余逐行边界检查可被编译器消除。
计算顺序和输出位映射保持，使用1024 bytes shared，保留原自动插入的1次 block 同步。
没有增加启动或临时全局张量。45个原非分派函数AST不变；所测非默认调参保持原分派。

109例同输入/预分配输出、4轮交替、每图200调用、每轮7次采样：

| 比较范围 | 用例数 | 几何平均加速比 |
|---|---:|---:|
| 相对当前 D128 候选，全量 | 109 | **{versus_parent['geomean_speedup']:.8f}×** |
| 本轮新增 D32 改动 | 6 | **{versus_parent['changed_geomean_speedup']:.8f}×** |
| 与 D128 候选设备码相同 | 103 | {versus_parent['unchanged_geomean_speedup']:.8f}× |
| 相对正式88.29版，全量 | 109 | **{versus_official['geomean_speedup']:.8f}×** |

时间单位为μs。全部低于1的结果均保留在 performance_summary.json，含设备码不变的计时波动。

| 本地用例 | B | T | D128父版 | 本版 | 加速比 |
|---|---:|---:|---:|---:|---:|
{changed_rows}

独立夹测覆盖36个形状、3种子、24次A/B/A、每图500调用。最终范围内30形状/90组合全部加速，
几何平均{bracket['active_geomean_speedup']:.8f}×，同源控制范围{bracket['control_range'][0]:.6f}–{bracket['control_range'][1]:.6f}×。
保留所有漂移拒绝样本；不过滤样本的中位数同样全部加速，平均{bracket['active_unfiltered_geomean_speedup']:.8f}×。
覆盖短序列大batch、H2/H4、尾块和非因果输入。4096回退、6144波动，保守使用8192门槛。
初筛非因果B1/T8192曾有0.4%回退，后续三种子夹测均加速；原始数据未删除。
子集比值不代表全量收益，也不能直接换算正式分数。

验证通过：125例严格FP32双接口、{len(checks['boundaries'])}个边界/实际shared发射检查、6组极端索引、
{len(checks['fallbacks'])}项调参源码等价和{len(checks['unsupported'])}项相同原有编译失败、18次同地址输入更新、6组host guard，
109例实际计时设备源码审计、36个夹测形状源码核对、18组传统开发/提交等价，
{len(host['rows'])}个host分派及{len(host['fallbacks'])}个调参分派核对。
CPU直接枚举最终AST的512个输出及{proof['guard_equivalence_checks']}组guard条件。
最大绝对误差{performance['max_abs_error']}；未使用异步拷贝、数据缓存、外部设备代码或后端修改，未关闭race/bounds检查。
原版及两种原型共18项极端索引对比均通过，未复现原版溢出错误。

`commands.sh` 在新目录复现，不覆盖发布文件。完整证据见 release_manifest.json；
研究过程及未采用方案保存在 `../20261003_output_lane`。
'''
    (release / "README.md").write_text(readme)
    commands = f'''#!/usr/bin/env bash
set -eo pipefail
source env.sh
task_repro_dir=$(mktemp -d experiments/20261003_d32_output_repro.XXXXXX)
cp {relative}/nsa.py {relative}/submission.py {relative}/assembly.json "$task_repro_dir/"
python check_submission_nsa.py "$task_repro_dir/nsa.py" "$task_repro_dir/submission.py" > "$task_repro_dir/static_checks.log"
python experiments/20261003_output_lane/check_output_layout.py "$task_repro_dir/nsa.py" --output "$task_repro_dir/layout_proof.json"
python experiments/20261003_output_lane/check_dispatch.py --directory "$task_repro_dir" > "$task_repro_dir/host_dispatch_audit.log" 2>&1
python experiments/20261003_output_lane/compare_family.py experiments/20261002_mid_v1/submission.py experiments/20261003_d128_v1/submission.py "$task_repro_dir/submission.py" --cases all --rounds 4 --repeat 200 --samples 7 --seed 0 --output "$task_repro_dir/full.json" > "$task_repro_dir/full.log" 2>&1
python experiments/20261003_output_lane/verify_lane.py --directory "$task_repro_dir" --output "$task_repro_dir/release_checks.json" > "$task_repro_dir/release_checks.log" 2>&1
python experiments/20261003_output_lane/validate_release.py --directory "$task_repro_dir" > "$task_repro_dir/validation_pipeline.log" 2>&1
printf 'Reports: %s\\n' "$task_repro_dir"
'''
    (release / "commands.sh").write_text(commands)
    (release / "commands.sh").chmod(0o755)
    subprocess.run(["bash", "-n", str(release / "commands.sh")], check=True)
    study_readme = f'''# NSA 输出线程重排研究（2026-10-03）

基线为 D128 v1，两个 reference 文件均保持其原 SHA256。
最终本地候选见 `../{release.name}/submission.py`，正式得分仍待OJ。

采用：默认S1/D32/BS16/G16/64线程且grid≥8192，组合原始块号检查与四次uint32输出shuffle。
30形状/90组合全部加速，平均{bracket['active_geomean_speedup']:.8f}×；完整全量结果在候选目录。
原型修改过六个D32函数，发布只新增一个builder，较小网格继续使用父版。

未采用的方案和负结果：

- `screen.json`：替换原合并输出的shared暂存，D64/D128明显回退，S8也略慢。
- `d32_screen.json`：D32小中网格回退；额外寄存器/线程位交换的full4/full8没有稳定优势。
- `mid_screen.json`：中型D64直接输出重排，整体1.001393×且不同形状方向不一致。
- `guard_screen.json`：区分output-only、guard-only和组合；guard-only仍混合。
  非因果B1/T8192的组合初筛0.995911×，后续三种子夹测均加速，两者都保留。
- `lane_multiseed.json`：36形状×3种子×24次A/B/A，保留全部原始、接受、拒绝样本。
  4096与6144低网格负结果用于限制范围，没有按具体用例编号分派。
- `extreme_probe.json`：原版、仅输出版、组合版各6组极端索引均通过；没有复现原版溢出。

所有计时包含公开run_kernel和完整启动，输入/输出地址共用，TF32关闭，GPU实验串行，
CUDA graph只使用单个MACA ExternalStream。没有关闭安全检查或改后端。
`experiment_summary.json`汇总全部报告、负结果、过滤前后统计；资源报告仅用于解释，
没有将寄存器数减少直接当作速度收益。候选的commands.sh可在新目录复现最终验证。

本目录封存后请另建目录研究，文件哈希见study_manifest.json。
'''
    (HERE / "README.md").write_text(study_readme)
    study_files = [path for path in HERE.rglob("*") if path.is_file() and "__pycache__" not in path.parts
                   and path.name != "study_manifest.json"]
    study_manifest = dict(status="frozen", selected_release=relative,
        evidence_sha256={str(path.relative_to(ROOT)): digest(path) for path in sorted(study_files)})
    (HERE / "study_manifest.json").write_text(json.dumps(study_manifest, indent=2) + "\n")
    evidence = [path for folder in (release, HERE) for path in folder.rglob("*")
        if path.is_file() and "__pycache__" not in path.parts
        and path.name != "release_manifest.json" and path not in (dev, sub)]
    evidence += [ROOT / name for name in ("benchmark_nsa.py", "verify_nsa.py", "check_equiv.py",
        "check_submission_nsa.py", "experiment_bench.py", "kernel_source.py", "test_cases_nsa_fwd.json", "env.sh",
        "experiments/20261002_tuning/verify_candidate.py", "experiments/20261001_tuning/verify_release.py",
        "experiments/20260928_guard_fix/check_restricted_host.py")]
    evidence += [ROOT / r["path"] for r in preserved]
    evidence += [ROOT.parent / "moe" / name for name in ("strip_comments.py", "check_submission.py")]
    parent_manifest = read(PARENT / "release_manifest.json")
    baselines = dict(parent_manifest["preserved_baselines"])
    baselines.update({str((PARENT / name).relative_to(ROOT)): digest(PARENT / name) for name in ("nsa.py", "submission.py")})
    manifest = dict(date="2026-10-03", directory=relative, status="validated locally; OJ confirmation pending",
        user_confirmed_best_score=88.29, official_new_score=None, official_sandbox=False,
        source_sha256={path.name: digest(path) for path in (dev, sub)}, preserved_baselines=baselines,
        prior_release_manifest_sha256=digest(PARENT / "release_manifest.json"), dispatch_config=config,
        preserved_functions=retained, added_functions=assembly["new_functions"],
        validation_counts={key: len(checks[key]) for key in
            ("boundaries", "sources", "extremes", "fallbacks", "unsupported", "refresh", "guarded")},
        performance=performance, evidence_sha256={relpath(path, ROOT): digest(path) for path in sorted(set(evidence))})
    with (release / "release_manifest.json").open("x") as output:
        output.write(json.dumps(manifest, indent=2) + "\n")
    print(json.dumps(dict(directory=relative, submission_sha256=digest(sub),
        versus_d128_v1=versus_parent["geomean_speedup"], versus_mid_v1=versus_official["geomean_speedup"],
        evidence_files=len(manifest["evidence_sha256"]), official_new_score=None), indent=2))


if __name__ == "__main__":
    main()
