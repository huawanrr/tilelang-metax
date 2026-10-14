"""Package only the verified final bytes and report all accepted and rejected data."""
from datetime import datetime, timezone
import hashlib
import json
import math
from pathlib import Path
import shutil
import statistics

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def aggregate(values):
    values = [v for v in values if v is not None]
    return dict(count=len(values), geometric_mean=math.exp(statistics.mean(map(math.log,values))),
                minimum=min(values), maximum=max(values), faster=sum(v>1 for v in values)) if values else dict(count=0)


def graph_report(name, sub):
    path = HERE / (name+".json")
    data = json.loads(path.read_text())
    index = next(i for i,n in enumerate(data["sha256"]) if Path(n).resolve() == sub.resolve())
    assert list(data["sha256"].values())[index] == digest(sub)
    rows = []
    for row in data["rows"]:
        s = row["summaries"][index-1]
        rows.append(dict(case=row["case"], seed=row["seed"], config=row["config"],
            changed_vs_v6=row["device_source_sha256"][index] != row["device_source_sha256"][0],
            speedup=s["median_speedup"], unfiltered_speedup=statistics.median(t["speedup"] for t in row["trials"][index]),
            baseline_us=s["median_baseline_us"], candidate_us=s["median_candidate_us"], accepted=s["accepted"], total=s["total"]))
    return dict(path=str(path), sha256=digest(path), aggregate=aggregate([r["speedup"] for r in rows]),
        unfiltered=aggregate([r["unfiltered_speedup"] for r in rows]),
        control=aggregate([r["summaries"][0]["median_speedup"] for r in data["rows"]]),
        changed=aggregate([r["speedup"] for r in rows if r["changed_vs_v6"]]),
        unchanged=aggregate([r["speedup"] for r in rows if not r["changed_vs_v6"]]), rows=rows)


def main():
    required = {"final_static", "final_cpu", "final_scalars", "final_reference", "final_extra", "final_oj",
                "final_full", "final_cold_seed61", "final_cold_seed0", "final_audit", "final_binary"}
    runs = json.loads((HERE / "final_runs.json").read_text())
    assert required <= {r["name"] for r in runs if r["status"] == "PASS"}
    assert all(r["status"] == "PASS" for r in runs)
    manifest = json.loads((HERE / "candidate_v10_manifest.json").read_text())
    sub, dev = [Path(manifest[k]) for k in ("submission", "development")]
    assert digest(sub) == manifest["submission_sha256"] == digest(HERE / "public_cache_fast.py")
    reference = json.loads((HERE / "final_reference.json").read_text())
    assert len(reference) == 125 and all(r["status"] == "PASS" for r in reference)
    extra, audit = [json.loads((HERE / name).read_text()) for name in ("final_extra.json", "final_audit.json")]
    assert extra["status"] == audit["status"] == "PASS"
    binary = json.loads((HERE / "final_binary_audit/report.json").read_text())
    for row in binary["rows"]:
        old, new = row["modules"][1:]
        assert len(old["parts"]) == len(new["parts"])
        assert all(a["sections"][".text"] == b["sections"][".text"] for a,b in zip(old["parts"],new["parts"]))
    oj, full = [graph_report(name,sub) for name in ("final_oj", "final_full")]
    assert len(oj["rows"]) == 28 and len(full["rows"]) == 109
    cold = []
    for name in ("final_cold_seed61", "final_cold_seed0"):
        data = json.loads((HERE / (name+".json")).read_text())
        index = next(i for i,n in enumerate(data["sha256"]) if Path(n).resolve() == sub.resolve())
        rows = [dict(case=r["case"], config=r["config"], speedup=r["speedup"][index], control=r["speedup"][1],
                     baseline_us=r["median_kernel_us"][0], candidate_us=r["median_kernel_us"][index]) for r in data["rows"]]
        cold.append(dict(name=name, aggregate=aggregate([r["speedup"] for r in rows]),
                         control=aggregate([r["control"] for r in rows]), rows=rows))
    data = json.loads((HERE / "public_fast_loop.json").read_text())
    host = dict(comparison="v9", method=data["method"], cpu_affinity=json.loads((HERE / "public_fast_loop_command.json").read_text())["cpu_affinity"],
        accepted=aggregate([r["summaries"][1]["median_speedup"] for r in data["rows"]]),
        unfiltered=aggregate([r["summaries"][1]["all_samples_speedup"] for r in data["rows"]]),
        control_unfiltered=aggregate([r["summaries"][0]["all_samples_speedup"] for r in data["rows"]]),
        byte_identical_submission=True, rows=data["rows"])
    summary = dict(status="PASS", target_score=89, official_candidate_score=None, target_confirmed=False,
        baseline_version="frozen v6", official_baseline_score=None, score_note=manifest["score_note"],
        submission_sha256=digest(sub), gpu_relative_to_v6=dict(oj=oj, full=full, cold=cold), host_relative_to_v9=host,
        validation=dict(reference_cases=125, both_public_interfaces=True,
            **{k:len(extra[k]) for k in ("boundaries", "extreme_scales", "tuning", "cache_order", "live_inputs", "restricted_host")},
            tuning_preserved_unsupported=sum(isinstance(r["outcomes"][0],dict) and "error_type" in r["outcomes"][0] for r in extra["tuning"]),
            audited_configurations=len(audit["configurations"]), audited_timing_rows=len(audit["timings"]),
            v9_gpu_binary_equal_cases=len(binary["rows"]), public_scalar_checks=23, cpu_cache_requests=8208),
        limitations=["Official score is pending; local timings cannot establish 89 points.",
            "GPU graph time and public-loop time measure different work and are reported separately.",
            "Negative results, including the warm OJ1 regression, are retained.",
            "RestrictedPython host checks do not substitute for the private official sandbox."])
    with (HERE / "performance_summary.json").open("x") as file:
        json.dump(summary,file,indent=2); file.write("\n")
    release = HERE / "release_v10"
    release.mkdir(exist_ok=False)
    for src,dest in ((sub,"submission.py"),(dev,"nsa.py"),(HERE/"baseline_v6.py","baseline_v6.py"),
                     (HERE/"parent_v9.py","parent_v9.py"),(HERE/"performance_summary.json","performance_summary.json")):
        shutil.copy2(src,release/dest)
    evidence = release / "evidence"
    evidence.mkdir()
    for path in HERE.iterdir():
        if path.is_file() and path.suffix in (".py", ".json", ".log", ".md", ".sh"):
            shutil.copy2(path,evidence/path.name)
    shutil.copytree(HERE/"final_binary_audit",evidence/"final_binary_audit")
    inherited = evidence / "inherited_proofs"
    inherited.mkdir()
    for name in ("fp32_sum_numeric.json", "v7_layout_proofs.json"):
        shutil.copy2(HERE.parent/"20261009_goal8933"/name,inherited/name)
    dependencies = ["nsa.py", "benchmark_nsa.py", "experiment_bench.py", "bench_oj.py", "test_tilelang_nsa_fwd.py",
        "reference.py", "verify_nsa.py", "kernel_source.py", "check_submission_nsa.py", "test_cases_nsa_fwd.json", "env.sh",
        "experiments/20261002_mid_blocks/verify_reference.py", "experiments/20261005_goal8929/bracketed_audited.py",
        "experiments/20261003_packed_compute/family_cases.json", "experiments/20261008_goal895/profile_cold.py",
        "experiments/20261009_goal8933/bench_public_loop.py", "experiments/20261010_resume8893/verify_candidate_extra_v8.py",
        "experiments/20261008_resume8857/verify_candidate.py", "experiments/20261005_goal8929/verify_candidate.py",
        "experiments/20261002_tuning/verify_candidate.py", "experiments/20261001_tuning/verify_release.py",
        "experiments/20260928_guard_fix/check_restricted_host.py", "experiments/20261008_resume8857/audit_candidate_v5b.py",
        "experiments/20261007_exp_math/make_submission.py", "experiments/20261008_resume8871/audit_actual_binary.py",
        "experiments/20261003_packed_compute/inspect_resources.py"]
    dependencies += ["experiments/20261012_goal89/"+name for name in
        ("check_public_cache_cpu.py", "check_public_scalar_fallback.py", "audit_final.py", "cases.json", "parent_v9.py")]
    for name in dependencies:
        target = release / "dependencies/nsa" / name
        target.parent.mkdir(parents=True,exist_ok=True)
        shutil.copy2(ROOT/name,target)
    target = release / "dependencies/moe/check_submission.py"
    target.parent.mkdir(parents=True)
    shutil.copy2(ROOT.parent/"moe/check_submission.py",target)
    shutil.copy2(HERE/"commands_template.sh",release/"commands.sh")
    (release/"commands.sh").chmod(0o755)
    readme = f'''# NSA v10（2026-10-12）

提交本目录 `submission.py` 全文。SHA256：`{digest(sub)}`。
目标为正式 89 分，v10 尚无 OJ 成绩。上次用户消息写最好 88.79，旧实验文档写 v6 为 88.93；两者冲突仍待确认。本次性能比较明确使用冻结 v6 的代码。

v10 完成上次 v9 未完成的发布验证，保留小 D32 读取顺序、多头 D64 的 FP32 分母/边界掩码，以及大尺寸路径的指数/归约优化。中型非因果和 grid≥2048 的多头路径沿用 v6。新增 `run_kernel` 的规范化参数缓存快路径，普通调用避免重复转换参数；缓存只保存编译后的 callable，当前 Q/K/V/索引每次重新读取。64 个 v9 函数和 56 个 v6 函数保持。

| 测量 | 比较版本 | 几何平均加速比 | 同源控制 |
|---|---|---:|---:|
| 14 个 OJ 形状 × 2 seeds，GPU 图计时 | v6 | {oj['aggregate']['geometric_mean']:.6f}× | {oj['control']['geometric_mean']:.6f}× |
| 109 例全量，GPU 图计时 | v6 | {full['aggregate']['geometric_mean']:.6f}× | {full['control']['geometric_mean']:.6f}× |
| 实际公开调用 × 18 组，未过滤 | v9 | {host['unfiltered']['geometric_mean']:.6f}× | {host['control_unfiltered']['geometric_mean']:.6f}× |

GPU 与包含 Python 发射间隙的公开调用是两种测量，不能相加或换算为正式分数。冷缓存为每次调用前冲刷 256 MB、六轮各 48 次；完整 21 组结果见 `performance_summary.json`。OJ1 的热测回退、全部漂移样本、未采用的成对求和/PV 分块和中止的家族试验均保留，未挑掉负数据。

125 例独立 FP32 双接口、53 个边界、65 组极端索引/scale、96 项调参对照（其中 {summary['validation']['tuning_preserved_unsupported']} 项与基线同样不支持）、6 组缓存顺序、60 次同地址输入更新/图回放、12 项本地 RestrictedPython host 检查通过。另通过 8,208 次 CPU 缓存请求和 23 项标量转换/更新检查。

{len(audit['configurations'])} 个配置、{len(audit['timings'])} 条最终计时与提交设备代码对应；五个重点形状通过实际 JIT adapter 提取的 `.text` 核对，与 v9 相同。同步、shared 大小、编译参数和 race/bounds 检查保持；无异步拷贝、外部设备源码或跨调用数据缓存。

运行 `bash commands.sh` 可在新的 `/tmp/nsa_v10_recheck.*` 目录复现。脚本先核对全部文件哈希，测试使用本目录封存的依赖副本。环境仍需现有 MetaX C500、MACA/TileLang、PyTorch、NumPy、msgpack、einops 和 RestrictedPython 8.5（测试 fixture 的路径为 `/tmp/nsa-restrictedpython-8.5`）。全部源码、正负研究、原始计时和验证保存在 `evidence`。
'''
    (release/"README.md").write_text(readme)
    files = {str(p.relative_to(release)):digest(p) for p in sorted(release.rglob("*")) if p.is_file()}
    (release/"release_manifest.json").write_text(json.dumps(dict(status="validated", created_utc=datetime.now(timezone.utc).isoformat(),
        submission_sha256=digest(sub), files=files),indent=2)+"\n")
    print(json.dumps(dict(release=str(release), submission_sha256=digest(sub), oj=oj["aggregate"],
                         full=full["aggregate"], host=host["unfiltered"], validation=summary["validation"]),indent=2))


if __name__ == "__main__":
    main()
