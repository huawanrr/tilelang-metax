"""Freeze verified NSA v14 bytes, raw evidence, and reproduction dependencies."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def readme(report):
    checked = report["correctness"]
    graph = report["graph"]["aggregate"]["candidate"]
    family = report["family_graph"]["aggregate"]["candidate"]
    oj3_hot = [r["candidate"]["unfiltered"] for r in report["graph"]["rows"] if r["case"] == "oj3"]
    oj3_cold = [next(r["candidate_speedup"] for r in report["cold"][str(seed)]["rows"]
                    if r["case"] == "oj3") for seed in (0,61)]
    regressions = [r for r in report["family_graph"]["regressions"] if r["changed"]]
    cold_rows = []
    for before, after in zip(report["cold"]["0"]["rows"], report["cold"]["61"]["rows"]):
        assert before["case"] == after["case"]
        cold_rows.append(f"| {before['case']} | {before['candidate_speedup']:.6f}× | {after['candidate_speedup']:.6f}× |")
    return f'''# NSA v14，2026-10-16

提交本目录 `submission.py` 全文。
SHA256：`{report['candidate_sha256']}`。
用户反馈昨天已到 **89 分**；本轮以昨天推荐的 v13 为父版。
**新版尚无官方成绩，89.5 分尚未确认达到。**

只改变 `_get_kernel`。在默认参数、S1、完整 BS16、G16 下，D128 的
`128 <= grid < 1280` 与 D64 的 `256 <= grid < 512` 使用已有的
`native_sparse_attention_coalesced_blocks_boundary_v8(q_vec=8, pv_width=128)`。
`grid = B * H * seq_len`，仅依赖形状。新分派标志同时进入标准化缓存键。
所有设备 builder、公开双接口、显式调参回退、checked adapter、输入转换和
FP32 dtype 字符串保持。没有引入近似倒数或输入缓存。

相对 v13，14 个已知 OJ 形状 × 2 seeds 的最终热测未过滤几何平均为
**{graph['unfiltered']:.8f}×**；设备代码只改变 OJ3，其他 13 个形状逐字节相同。
OJ3 两种子热测为 **{oj3_hot[0]:.6f}× / {oj3_hot[1]:.6f}×**，
冷测为 **{oj3_cold[0]:.6f}× / {oj3_cold[1]:.6f}×**。
另测 18 个家族/边界形状 × 2 seeds，全部平均 {family['unfiltered']:.8f}×，
其中改变设备代码的形状平均 {family['changed_unfiltered']:.8f}×，
改变形状的负样本数为 {len(regressions)}。全部原始正负值和同源控制保留。

冷测在每次公开调用前冲刷 256 MB，记录所有 NSA 设备启动的时间和：

| 形状 | seed0 | seed61 |
| --- | --- | --- |
{chr(10).join(cold_rows)}

验证包括 {checked['reference_cases']} 个双接口独立 FP32 参考用例（最大绝对误差
{checked['reference_max_abs_error']}）、42 个边界、25 组 scale、30 次原地址输入
更新、64 次实际编译内核的缓存顺序检查和 6 个严格 FP32 builder 检查。
CPU 分派覆盖 {checked['cpu_configurations']} 个配置、{checked['cpu_cache_requests']:,}
次缓存请求、{checked['cpu_public_requests']:,} 次公开调用。另有索引转换、
参数错误、缓存清空与受限 host 检查。没有声称这些本地检查等于正式 OJ 沙箱。
32 个实际二进制配置核对改动范围与启动数，8 个配置确认候选与筛查内核的
真实 `.text`、资源、源代码和编译参数完全相同。

`final_summary.json` 保存完整汇总；`evidence/` 同时保存未采用的分派范围、
读取提示、编译选项、索引预处理、近似倒数等实验。历史 v13 的源码为
`parent_v13.py`。根目录旧 `nsa.py` / `submission.py` 不代表本次提交内容。

运行 `bash commands.sh` 会先校验发布文件，再在新临时目录串行复现 CPU/GPU
检查、热/冷计时和实际二进制核对。使用 `source env.sh` 的 MACA/Torch 环境
及活动 `/app/tilelang-metax` 构建，依赖与校验清单保存在本目录。
'''


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--module", required=True)
    parser.add_argument("--validation", required=True)
    parser.add_argument("--summary", required=True)
    parser.add_argument("--output-dir", required=True)
    args = parser.parse_args()
    module, validation = Path(args.module).resolve(), Path(args.validation).resolve()
    output = Path(args.output_dir).resolve()
    report = json.loads(Path(args.summary).read_text())
    assert report["status"] == "PASS" and sha(module) == report["candidate_sha256"]
    assert sha(HERE / "baseline.py") == report["parent_v13_sha256"]
    assert not report["official_target_verified"] and report["official_candidate_score"] is None
    for name, digest in report["evidence_sha256"].items():
        assert sha(validation / name) == digest, name
    probe = report["probe_binary_equivalence"]
    assert sha(Path(probe["path"])) == probe["sha256"]
    files = [p for p in HERE.rglob("*") if p.is_file() and "__pycache__" not in p.parts
             and not any(part.startswith("release_") for part in p.relative_to(HERE).parts)]
    output.mkdir(exist_ok=False)
    shutil.copy2(module, output / "submission.py")
    shutil.copy2(HERE / "baseline.py", output / "parent_v13.py")
    shutil.copy2(Path(args.summary), output / "final_summary.json")
    (output / "README.md").write_text(readme(report))
    for path in files:
        target = output / "evidence" / path.relative_to(HERE)
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, target)
    prior = ROOT / "experiments/20261015_goal8933/release_v13"
    shutil.copytree(prior / "dependencies", output / "dependencies",
                    ignore=shutil.ignore_patterns("__pycache__", "*.pyc"))
    study = output / "dependencies/nsa/experiments/20261016_goal895"
    study.mkdir(parents=True)
    for name in ("baseline.py", "validation_cases.json", "run_dispatch_final.py",
                 "verify_dispatch_cpu.py", "verify_dispatch_gpu.py", "summarize_dispatch.py",
                 "dispatch_boundary_q8.py"):
        shutil.copy2(HERE / name, study / name)
    write_commands(output)
    manifest = dict(candidate_sha256=sha(module), parent_v13_sha256=sha(HERE / "baseline.py"),
                    user_reported_current_score=89, parent_release_assumed="v13",
                    official_candidate_score=None, official_target=89.5, official_target_verified=False,
                    files={str(p.relative_to(output)):sha(p) for p in sorted(output.rglob("*")) if p.is_file()})
    (output / "release_manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    assert all(sha(output / name) == digest for name, digest in manifest["files"].items())
    print("Frozen", output, "files", len(manifest["files"]), "submission", sha(output / "submission.py"))


def write_commands(output):
    commands = output / "commands.sh"
    commands.write_text('''#!/usr/bin/env bash
set -eo pipefail
release_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
python - "$release_dir" <<'PY'
import hashlib,json,sys
from pathlib import Path
p=Path(sys.argv[1])
manifest=json.loads((p/'release_manifest.json').read_text())
for name,expected in manifest['files'].items():
    assert hashlib.sha256((p/name).read_bytes()).hexdigest()==expected,name
print('Release hashes verified:',len(manifest['files']))
PY
test_root="$release_dir/dependencies/nsa"
test_study="$test_root/experiments/20261016_goal895"
cd "$test_root"
source env.sh
set -u
export PYTHONDONTWRITEBYTECODE=1
result_dir="$(mktemp -d "${TMPDIR:-/tmp}/nsa_v14_recheck.XXXXXX")"
python "$test_study/verify_dispatch_cpu.py" "$test_study/baseline.py" "$release_dir/submission.py" --case-file "$test_study/validation_cases.json" --output "$result_dir/dispatch_cpu.json"
python "$test_study/run_dispatch_final.py" "$release_dir/submission.py" --output-dir "$result_dir/validation" --cpu-report "$result_dir/dispatch_cpu.json"
python "$test_root/experiments/20261015_goal8933/audit_binary.py" "$release_dir/submission.py" "$test_study/dispatch_boundary_q8.py" --case-file "$test_study/validation_cases.json" --cases oj3,d128_b1_h1_t128_c1,d128_b1_h1_t1264_c1,d128_b2_h3_t64_c1,d64_b1_h1_t256_c1,d64_b1_h1_t496_c1,d64_b16_h1_t16_c1,d64_b1_h1_t256_c0 --output-dir "$result_dir/probe_binary"
python "$test_study/summarize_dispatch.py" "$result_dir/validation" --module "$release_dir/submission.py" --probe-audit "$result_dir/probe_binary/report.json" --output "$result_dir/final_summary.json"
printf 'Results: %s\\n' "$result_dir"
''')
    commands.chmod(0o755)


if __name__ == "__main__":
    main()
