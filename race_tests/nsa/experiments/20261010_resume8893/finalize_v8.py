"""Package validated v8 bytes and report local results against official v6."""
from datetime import datetime, timezone
import hashlib
import json
import math
from pathlib import Path
import shutil
import statistics

HERE = Path(__file__).resolve().parent


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def aggregate(values):
    values = [x for x in values if x is not None]
    return (dict(count=len(values), geometric_mean=math.exp(statistics.mean(map(math.log, values))),
                 minimum=min(values), maximum=max(values), faster=sum(v > 1 for v in values))
            if values else dict(count=0))


def graph_report(path, submission):
    data = json.loads(path.read_text())
    names = list(data["sha256"])
    index = next(i for i,n in enumerate(names) if Path(n).resolve() == submission.resolve())
    assert data["sha256"][names[0]] == digest(HERE / "baseline.py")
    assert data["sha256"][names[index]] == digest(submission)
    rows = []
    for row in data["rows"]:
        s = row["summaries"][index-1]
        trials = row["trials"][index]
        rows.append(dict(case=row["case"], seed=row["seed"], config=row["config"],
            changed_vs_v6=row["device_source_sha256"][index] != row["device_source_sha256"][0],
            speedup=s["median_speedup"], unfiltered_speedup=statistics.median(t["speedup"] for t in trials),
            baseline_us=s["median_baseline_us"], candidate_us=s["median_candidate_us"],
            accepted=s["accepted"], total=s["total"]))
    return dict(path=str(path), sha256=digest(path), aggregate=aggregate([r["speedup"] for r in rows]),
        unfiltered=aggregate([r["unfiltered_speedup"] for r in rows]),
        control=aggregate([r["summaries"][0]["median_speedup"] for r in data["rows"]]),
        changed=aggregate([r["speedup"] for r in rows if r["changed_vs_v6"]]),
        unchanged=aggregate([r["speedup"] for r in rows if not r["changed_vs_v6"]]), rows=rows)


def main():
    required = {"v8_static", "v8_reference", "v8_extra", "v8_oj", "v8_full", "v8_cold_seed61",
                "v8_cold_seed0", "v8_audit", "v8_binary"}
    runs = json.loads((HERE / "v8_final_runs.json").read_text())
    assert required <= {r["name"] for r in runs if r["status"] == "PASS"}
    assert all(r["status"] == "PASS" for r in runs)
    manifest = json.loads((HERE / "candidate_v8_manifest.json").read_text())
    sub, dev = [Path(manifest[k]) for k in ("submission", "development")]
    assert digest(sub) == manifest["submission_sha256"]
    assert digest(dev) == manifest["development_sha256"]
    reference = json.loads((HERE / "v8_reference.json").read_text())
    assert len(reference) == 125 and all(r["status"] == "PASS" for r in reference)
    extra = json.loads((HERE / "v8_extra.json").read_text())
    audit = json.loads((HERE / "v8_audit.json").read_text())
    assert extra["status"] == audit["status"] == "PASS"
    assert audit["manifest_sha256"] == digest(HERE / "candidate_v8_manifest.json")
    oj, full = [graph_report(HERE / n, sub) for n in ("v8_oj.json", "v8_full.json")]
    assert len(oj["rows"]) == 28 and len(full["rows"]) == 109
    cold = []
    for filename in ("v8_cold_seed61.json", "v8_cold_seed0.json"):
        path = HERE / filename
        data = json.loads(path.read_text())
        names = list(data["sha256"])
        index = next(i for i,n in enumerate(names) if Path(n).resolve() == sub.resolve())
        assert data["sha256"][names[index]] == digest(sub)
        rows = [dict(case=r["case"], config=r["config"], baseline_us=r["median_kernel_us"][0],
            candidate_us=r["median_kernel_us"][index], speedup=r["speedup"][index],
            control=r["speedup"][1], all_rounds=[v["total_kernel_us_per_call"] for v in r["records"][index]])
                for r in data["rows"]]
        cold.append(dict(path=str(path), sha256=digest(path), aggregate=aggregate([r["speedup"] for r in rows]),
                         control=aggregate([r["control"] for r in rows]), rows=rows))
    summary = dict(status="PASS", official_baseline_score=88.93, official_baseline_version="v6",
        official_baseline_sha256=digest(HERE / "baseline.py"), target_score=89.5,
        official_candidate_score=None, target_confirmed=False, submission=str(sub), submission_sha256=digest(sub),
        development_sha256=digest(dev), options=manifest["options"], oj=oj, full=full, cold=cold,
        validation=dict(reference_cases=len(reference), both_public_interfaces=True,
            **{k: len(extra[k]) for k in ("boundaries", "extreme_scales", "tuning", "cache_order", "live_inputs", "restricted_host")},
            tuning_preserved_unsupported=sum("error_type" in r["outcomes"][0] for r in extra["tuning"]),
            audited_configurations=len(audit["configurations"]), audited_timings=len(audit["timings"]),
            unchanged_v6_functions=len(manifest["unchanged_v6_functions"])),
        limitations=["No official score has been received for v8.",
                     "Local GPU graph, cold-device and host-issue timings are different measurements.",
                     "All regressions and raw samples remain available.",
                     "Local restricted-host checks are not the official judge sandbox."])
    summary_path = HERE / "performance_summary.json"
    assert not summary_path.exists()
    summary_path.write_text(json.dumps(summary, indent=2) + "\n")
    release = HERE / "release_v8"
    release.mkdir(exist_ok=False)
    evidence = release / "evidence"
    evidence.mkdir()
    shutil.copy2(sub, release / "submission.py")
    shutil.copy2(dev, release / "nsa.py")
    shutil.copy2(HERE / "baseline.py", release / "baseline_v6.py")
    shutil.copy2(HERE / "v7_parent.py", release / "parent_v7.py")
    shutil.copy2(summary_path, release / "performance_summary.json")
    evidence_names = ["baseline_manifest.json", "candidate_v8_manifest.json", "v8_final_runs.json",
        "validation_cases.json", "research_summary.json", "screen_failure.json", "screen_orchestration_note.json"]
    evidence_names += [name + suffix for name in sorted(required) if name != "v8_binary" for suffix in (".json", ".log")]
    evidence_names += [name + ".json" for name in ("v7_vs_v6_oj", "load_mask_screen_serial", "reduction_screen",
        "large_mask_screen", "large_mixed_family", "mid_q_family", "mid_reduce_family", "d128_load_family")]
    for name in sorted(set(evidence_names)):
        path = HERE / name
        if path.exists():
            shutil.copy2(path, evidence / name)
    shutil.copytree(HERE / "v8_binary_audit", evidence / "v8_binary_audit")
    for name in ("fp32_sum_numeric.json", "v7_layout_proofs.json"):
        shutil.copy2(HERE.parent / "20261009_goal8933" / name, evidence / name)
    readme = f"""# NSA v8（2026-10-10）

提交本目录 `submission.py` 全文。SHA256：`{digest(sub)}`。
正式已知最佳是 v6 **88.93**；v8 尚无 OJ 成绩，**89.5 未确认**。

本版接续已验证的 v7，并仅为默认大尺寸、完整 BS16、因果 D64 路径追加
边界掩码和自然指数表达；FP32 分母归约不变。D128 沿用 v7，Q4、独立
shuffle 和宽读取组合的回退记录保留在 evidence 中，没有加入默认路径。
相对正式 v6，还包含 v7 的中型多头 FP32 归约/边界掩码、小 D32 读取顺序，
以及完整形状、scale、调参参数的已编译 callable 查找。57 个原有非分派函数保持。

## 本地结果（比较基线均为正式 v6）

| 测量 | 加速比 | 同源控制 |
|---|---:|---:|
| 14 个 OJ 形状、2 个种子 | {oj['aggregate']['geometric_mean']:.6f}× | {oj['control']['geometric_mean']:.6f}× |
| 109 例全量、seed0 | {full['aggregate']['geometric_mean']:.6f}× | {full['control']['geometric_mean']:.6f}× |
| 13 形状冷缓存、seed61 | {cold[0]['aggregate']['geometric_mean']:.6f}× | {cold[0]['control']['geometric_mean']:.6f}× |
| 8 形状冷缓存、seed0 | {cold[1]['aggregate']['geometric_mean']:.6f}× | {cold[1]['control']['geometric_mean']:.6f}× |

热测为 A/B/A 图回放，公开入口的全部启动均计入；冷测每次调用前冲刷
256 MB，六轮各 48 次。所有接受/拒绝样本和负结果完整保留。
以上为本地测量，不能换算成已经获得的 OJ 分数。

## 校验

125 例独立 FP32 双接口参考，{len(extra['boundaries'])} 个边界、
{len(extra['extreme_scales'])} 组极端索引/scale、{len(extra['tuning'])} 项调参对照、
{len(extra['cache_order'])} 组缓存顺序、{len(extra['live_inputs'])} 次同地址输入更新、
{len(extra['restricted_host'])} 项本地受限 host 检查完成。
{len(audit['configurations'])} 个配置、{len(audit['timings'])} 条最终计时与实际提交的设备源码和编译参数对应。
开发/提交/研究探针的设备代码匹配；没有额外 kernel 启动，保持 shared 大小、同步和安全 pass。

没有异步拷贝、外部设备源码、后端改动或跨调用输入/预处理/输出缓存。
跨调用只缓存编译后的 callable；当前 Q/K/V/索引始终重新读取。
Torch 仅用于主机端张量分配及索引类型/连续性处理。

`performance_summary.json` 是最终结果；`evidence/candidate_v8_manifest.json`
记录组装阶段，`evidence/v8_final_runs.json` 记录随后完成的检查。
从现有工作区运行 `bash experiments/20261010_resume8893/release_v8/commands.sh`
可将新测量写入独立目录。旧提交和所有原始实验保留。
"""
    (release / "README.md").write_text(readme)
    commands = '''#!/usr/bin/env bash
set -eo pipefail
release_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
nsa_root="$(cd -- "$release_dir/../../.." && pwd)"
cd "$nsa_root"
source env.sh
export PYTHONDONTWRITEBYTECODE=1
result_dir="$(mktemp -d "$nsa_root/experiments/20261010_resume8893/recheck_v8_XXXXXX")"
cp "$release_dir/baseline_v6.py" "$result_dir/control_v6.py"
python check_submission_nsa.py "$release_dir/submission.py"
python experiments/20261002_mid_blocks/verify_reference.py "$release_dir/submission.py" --cases all --extras --output "$result_dir/reference.json"
python experiments/20261010_resume8893/verify_candidate_extra_v8.py "$release_dir/submission.py" --parent "$release_dir/baseline_v6.py" --output "$result_dir/extra.json"
python experiments/20261005_goal8929/bracketed_audited.py "$release_dir/baseline_v6.py" "$result_dir/control_v6.py" "$release_dir/submission.py" --case-file "$release_dir/evidence/validation_cases.json" --cases oj1,oj2,oj3,oj4,oj5,oj6,oj7,oj8,oj9,oj10,oj11,oj12,oj13,oj14 --seeds 0,61 --attempts 24 --repeat 400 --shared-pool --output "$result_dir/oj.json"
python experiments/20261005_goal8929/bracketed_audited.py "$release_dir/baseline_v6.py" "$result_dir/control_v6.py" "$release_dir/submission.py" --cases all --seeds 0 --attempts 12 --repeat 300 --shared-pool --output "$result_dir/full.json"
python experiments/20261008_goal895/profile_cold.py "$release_dir/baseline_v6.py" "$result_dir/control_v6.py" "$release_dir/submission.py" --case-file "$release_dir/evidence/validation_cases.json" --cases oj1,oj4,oj5,oj7,oj8,oj9,oj13,oj14,d128_large,d64_mid_noncausal --seed 61 --repeat 48 --rounds 6 --output "$result_dir/cold.json"
printf 'Results: %s\\n' "$result_dir"
'''
    (release / "commands.sh").write_text(commands)
    (release / "commands.sh").chmod(0o755)
    files = {str(p.relative_to(release)): digest(p) for p in sorted(release.rglob("*")) if p.is_file()}
    (release / "release_manifest.json").write_text(json.dumps(dict(status="validated",
        created_utc=datetime.now(timezone.utc).isoformat(), submission_sha256=digest(sub),
        files=files), indent=2) + "\n")
    assert digest(release / "submission.py") == digest(sub)
    print(json.dumps(dict(release=str(release), sha256=digest(sub), oj=oj["aggregate"], full=full["aggregate"],
                         cold=[c["aggregate"] for c in cold], validation=summary["validation"]), indent=2))


if __name__ == "__main__":
    main()
