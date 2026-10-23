"""Freeze the validated S2 candidate and its complete local evidence."""
import hashlib
import json
from pathlib import Path
import shutil

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
PRIOR = HERE.parent / "20261016_goal895/release_v14"
NEW_BUILDER = "native_sparse_attention_short_list_oct8_wave_output_v15"
FAMILY = "oj10,s2_b1_t272,s2_b1_t304,s2_b1_t336,s2_b1_t352,s2_b1_t368,s2_b2_t144,s2_b2_t160,s2_b2_t176,s2_b3_t96,s2_b3_t112,s2_b4_t80,s2_b4_t96,s2_b5_t64,s2_b6_t64,s2_b2_t128_c0,s2_b3_t128_c0"
COLD = "oj10,s2_b1_t272,s2_b1_t304,s2_b1_t336,s2_b1_t352,s2_b1_t368,s2_b2_t144,s2_b2_t176,s2_b3_t96,s2_b3_t128,s2_b4_t80,s2_b4_t96,s2_b5_t64,s2_b6_t64,s2_b3_t128_c0"
BINARY = "oj1,oj2,oj3,oj4,oj5,oj6,oj7,oj8,oj9,oj10,oj11,oj12,oj13,oj14,s2_b1_t240,s2_b1_t257,s2_b1_t384,s2_b1_t400,s2_b2_t128,s2_b3_t128,s2_b1_h2_t128,s2_b1_t256_c0"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def readme(report):
    graph, cold, checks = report["graph"], report["cold"], report["correctness"]
    hot_oj = [row["candidate"]["unfiltered"] for row in graph["rows"] if row["case"] == "oj10"]
    cold_oj = [row["speedup"] for row in cold["rows"] if row["case"] == "oj10"]
    negative = "\n".join(
        f"- {r['case']}，seed {r['seed']}：{r['speedup']:.8f}×，"
        f"{r['baseline_us']:.6f} → {r['candidate_us']:.6f} µs。"
        for r in cold["regressions"]) or "无。"
    return f'''# NSA v15，2026-10-16

提交本目录 `submission.py` 全文。
SHA256：`{report['candidate_sha256']}`。
父版是 v14，保留其 OJ3 优化。用户已确认总分为 89；
**v14/v15 均尚无新的官方结果，89.5 分未确认达到。**

本版新增 S2 输出暂存与显式单 wave 同步，只在既有默认路径、
H1/G16/D64/完整 BS16，`seq_len >= 64` 且 `256 <= B*H*seq_len <= 384` 时选择。
输出经共享内存重排后连续写回；全部共享依赖屏障保留。
数学运算、FP32 字符串类型、旧 builder、公开双接口和输入转换保持。
显式调参继续走父版路径；选择标志进入规范化缓存键。
每次调用使用当前输入，没有张量或地址缓存。

最终候选相对 v14：

| 测量 | 结果 |
| --- | --- |
| OJ10 热测，两个种子 | {hot_oj[0]:.6f}× / {hot_oj[1]:.6f}× |
| OJ10 冷测，两个种子 | {cold_oj[0]:.6f}× / {cold_oj[1]:.6f}× |
| 17 个选中家族形状 × 两种子热测 | {graph['geomean']:.8f}×，{len(graph['regressions'])} 行回退 |
| 15 个家族形状 × 两种子冷测 | {cold['geomean']:.8f}×，{len(cold['regressions'])} 行回退 |

热测为同输入、同输出、共同图内存池的 24 次 A/B/A，每图 240 次公开调用；
同源控制为 {graph['control_geomean']:.8f}×。
冷测每次公开调用之前冲刷 256 MB，累计实际设备 kernel 时间，
8 轮 × 48 次调用；同源控制为 {cold['control_geomean']:.8f}×。
没有把不同测量模式的收益相加或换算成官方分数。

冷测的全部负值：

{negative}

更早的 48 组存储位置/回放长度检查均为正值，整体 1.04817301×。
实际二进制确认所选候选与该探针设备代码一致；这些早期数据和最终数据分别保留。
更小、更大的 S2 网格以及 Q 暂存探针存在回退，未扩展采用；原始负样本均在 `evidence/`。

验证包括 {checks['boundaries']} 个边界与异常索引用例、{checks['scales']} 组 scale、
{checks['live']} 次原地址输入更新、{checks['restricted']} 组受限 host、
{checks['compiled_cache_orders']} 次实际编译缓存顺序检查，以及 {checks['strict_fp32']} 个
FP32 builder 的严格 FFI 类型检查。最大绝对误差为 {checks['max_abs_error']}。
边界和 scale 检查使用独立 FP32 参考并测试两个公开接口，TF32 关闭。
原地址检查分别覆盖直接调用和图回放。CPU 验证覆盖 {checks['cpu_configurations']} 个配置、
{checks['cpu_cache_requests']:,} 次缓存请求和 {checks['cpu_public_requests']:,} 次公开请求。
这些是本地验证，未声称已经运行官方沙箱。

22 个配置 × 三版本提取真实 JIT ELF。14 个已知 OJ 中只有 OJ10 改变 `.text`；
另外 13 个与 v14 一致。区间外、非完整块和多头路径保持父版代码，
区间内与筛查探针的源码、设备 `.text`、资源和编译参数相同。
K/V 共享地址逐项证明写入唯一、读取匹配；数据竞争检查始终开启。

`final_summary.json` 汇总最终证据；`parent_v14.py` 是可回退父版。
`release_manifest.json` 对所有发布文件记录哈希。
运行 `bash commands.sh` 会先核对哈希，再在新的临时目录串行复现检查和测量。
环境使用所附 `env.sh` 与活动 `/app/tilelang-metax` 构建。
根目录旧 `nsa.py` / `submission.py` 不代表本次提交内容。
'''


def commands():
    header = '''#!/usr/bin/env bash
set -eo pipefail
release_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
python - "$release_dir" <<'PY'
import hashlib,json,sys
from pathlib import Path
p=Path(sys.argv[1])
m=json.loads((p/'release_manifest.json').read_text())
for name,digest in m['files'].items():
    assert hashlib.sha256((p/name).read_bytes()).hexdigest()==digest,name
print('Release hashes verified:',len(m['files']))
PY
test_root="$release_dir/dependencies/nsa"
test_study="$test_root/experiments/20261016_s2_family"
cd "$test_root"
source env.sh
set -u
export PYTHONDONTWRITEBYTECODE=1
result_dir="$(mktemp -d "${TMPDIR:-/tmp}/nsa_v15_recheck.XXXXXX")"
python "$test_root/check_submission_nsa.py" "$release_dir/submission.py"
python "$test_root/experiments/20261016_goal895/verify_dispatch_cpu.py" "$test_study/baseline.py" "$release_dir/submission.py" --case-file "$test_study/candidate_cases.json" --output "$result_dir/candidate_dispatch_cpu.json"
python "$test_study/verify_candidate_gpu.py" "$release_dir/submission.py" --output "$result_dir/candidate_validation.json"
'''
    lines = [header]
    lines.append(f'python "$test_root/experiments/20261005_goal8929/bracketed_audited.py" "$test_study/baseline.py" "$test_study/control.py" "$release_dir/submission.py" --case-file "$test_study/candidate_cases.json" --cases {FAMILY} --seeds 0,61 --attempts 24 --repeat 240 --shared-pool --output "$result_dir/candidate_family_screen.json"\n')
    for seed in (0, 61):
        lines.append(f'python "$test_root/experiments/20261008_goal895/profile_cold.py" "$test_study/baseline.py" "$test_study/control.py" "$release_dir/submission.py" --case-file "$test_study/candidate_cases.json" --cases {COLD} --seed {seed} --rounds 8 --repeat 48 --output "$result_dir/candidate_cold_seed{seed}.json"\n')
    lines.append(f'python "$test_root/experiments/20261015_goal8933/audit_binary.py" "$test_study/baseline.py" "$release_dir/submission.py" "$test_study/wave_output.py" --case-file "$test_study/candidate_cases.json" --cases {BINARY} --output-dir "$result_dir/candidate_binary"\n')
    lines.append('python "$test_study/summarize_final.py" --study-dir "$result_dir" --module "$release_dir/submission.py" --parent "$test_study/baseline.py" --output "$result_dir/final_summary.json"\n')
    lines.append('printf \'Results: %s\\n\' "$result_dir"\n')
    return "".join(lines)


def main():
    report_path = HERE / "final_summary.json"
    report = json.loads(report_path.read_text())
    assert report["status"] == "PASS"
    assert report["candidate_sha256"] == sha(HERE / "candidate_s2.py")
    assert report["parent_v14_sha256"] == sha(PRIOR / "submission.py") == sha(HERE / "baseline.py")
    assert not report["official_target_verified"] and report["official_candidate_score"] is None
    for name, digest in report["evidence_sha256"].items():
        assert sha(HERE / name) == digest
    files = [p for p in HERE.rglob("*") if p.is_file() and "__pycache__" not in p.parts
             and not any(part.startswith("release_") for part in p.relative_to(HERE).parts)]
    output = HERE / "release_v15"
    output.mkdir(exist_ok=False)
    shutil.copy2(HERE / "candidate_s2.py", output / "submission.py")
    shutil.copy2(HERE / "baseline.py", output / "parent_v14.py")
    shutil.copy2(report_path, output / "final_summary.json")
    (output / "README.md").write_text(readme(report))
    for path in files:
        destination = output / "evidence" / path.relative_to(HERE)
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, destination)
    shutil.copytree(PRIOR / "dependencies", output / "dependencies",
                    ignore=shutil.ignore_patterns("__pycache__", "*.pyc"))
    study = output / "dependencies/nsa/experiments/20261016_s2_family"
    study.mkdir(parents=True)
    for name in ("baseline.py", "control.py", "wave_output.py", "candidate_cases.json",
                 "verify_candidate_gpu.py", "summarize_final.py"):
        shutil.copy2(HERE / name, study / name)
    commands_path = output / "commands.sh"
    commands_path.write_text(commands())
    commands_path.chmod(0o755)
    manifest = dict(candidate_sha256=report["candidate_sha256"], parent_v14_sha256=report["parent_v14_sha256"],
                    user_reported_current_score=89, official_target=89.5,
                    official_candidate_score=None, official_target_verified=False,
                    files={str(p.relative_to(output)): sha(p) for p in sorted(output.rglob("*")) if p.is_file()})
    (output / "release_manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    assert all(sha(output / name) == digest for name, digest in manifest["files"].items())
    print("Frozen", output, len(manifest["files"]), "files", report["candidate_sha256"])


if __name__ == "__main__":
    main()
