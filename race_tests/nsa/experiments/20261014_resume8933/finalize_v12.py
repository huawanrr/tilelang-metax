"""Freeze an independently validated v12 without modifying earlier releases."""
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
    public = report["public_loop"]["aggregate"]
    graph = report["graph"]["aggregate"]
    checks = report["correctness"]
    table = ["| OJ | 公开调用相对 v11 | 图计时相对 v11 |", "|---|---:|---:|"]
    for name in ("oj" + str(i) for i in range(1, 15)):
        import statistics
        values = [statistics.geometric_mean(r["candidate_vs_v11"]["unfiltered"]
            for r in report[kind]["rows"] if r["case"] == name)
            for kind in ("public_loop", "graph")]
        table.append(f"| {name} | {values[0]:.6f}× | {values[1]:.6f}× |")
    return f'''**NSA v12 可提交候选，2026-10-15**

提交 [submission.py](submission.py) 全文。正式已确认基线为 **88.93**，
目标 **89.33**；v11、v12 均尚无本轮官方反馈，不能把本地加速换算为已达标。

候选 SHA256：`{report['candidate_sha256']}`。
继承 [parent_v11.py](parent_v11.py)，并保留 [baseline_8893.py](baseline_8893.py)。
历史发布和根目录旧 `nsa.py` / `submission.py` 保持原样。

本版在 v11 上修改三个函数：

- 两种公开入口在取得编译 callable 时使用 `JITKernel.torch_function`，
  省去原来只转发参数的 `JITKernel.__call__`。普通 packed 闭包仍走原调用。
  仍经过相同 adapter 和参数验证，每次仍把当前索引转换为 int32/连续布局，
  仅将该转换函数体内联。没有缓存张量、输出、地址或运行时 stream。
- 修复旧 `native_sparse_attention_online_emitter` 在非正 scale 下的尾部/因果掩码：
  旧版 `-inf * 0` 或 `-inf * 负数` 会产生错误权重；现在显式把无效位置设为零。
  正 scale 表达式和分派不变。旧错误由新增验证发现，并以相同输入复现，
  失败候选、原始日志和探针全部保存在 evidence 中。

{report['static']['unchanged_functions']} 个原函数、模块语句、导入、同步及编译参数保持。
22 个配置的实际 JIT 设备 `.text`、源码、资源及启动数与 v11 完全一致，
包括全部 14 个 OJ 形状和三个正 scale 的旧回退配置。
没有异步拷贝、外部设备代码、关闭 race/bounds 或跳过参数验证。

验证通过：125 例独立 FP32 参考、factory/run_kernel 双接口，
最大绝对误差 {checks['reference_max_abs_error']}；{checks['cpu_configurations']} 个配置、
{checks['cpu_public_requests']} 次 CPU 公开请求；32 组 scale/缓存检查、24 组索引转换，
10 组与基线相同的参数错误、32 次同地址 Q/K/V/索引更新的图回放和双接口检查，
8 组 RestrictedPython host 检查，包含新的 joint-buffer host 函数。
旧回退修复另有 32 组检查通过，复现旧版 {checks['legacy_parent_failures']} 组失败；
16 组正 scale 的设备源码与输出逐位保持。未在本机运行私有官方 sandbox。

14 个 OJ 形状 × 两种子，所有原始轮次和负值保留。实际公开调用采用 A/B/A，
固定可用 CPU，每轮 2,400 次、16 轮，记录 CUDA event span 和同步墙钟；
包含 Python 提交间隙。相对 v11 的未过滤几何平均为
**{public['candidate_vs_v11']['unfiltered']:.8f}×**，过滤前后基线漂移 >3% 的轮次后为
{public['candidate_vs_v11']['filtered']:.8f}×。相对正式 88.93 源码为
{public['candidate']['unfiltered']:.8f}×，同源控制 {public['control']['unfiltered']:.8f}×。

GPU 图计时包含全部打包及注意力 kernel，每图 240 次、16 轮。
相对 v11 的未过滤平均为 **{graph['candidate_vs_v11']['unfiltered']:.8f}×**，
相同设备代码的差异按测量波动解释。相对 88.93 源码为
{graph['candidate']['unfiltered']:.8f}×，同源控制 {graph['control']['unfiltered']:.8f}×。
每形状的两种子几何平均如下，均不删除负值：

{chr(10).join(table)}

小算子的第一轮短窗口主机计时有明显抖动，随后延长窗口复测。
本轮 BS32 分片读取/padding、S8 直接读/unsigned 条件/掩码后置、指数多项式
均未采用，所有失败和回退结果见 `evidence/README.md` 及原始 JSON/log。
v11 的先前冷缓存结果作为继承证据保存在 `parent_v11_summary.json`；
由于本版正 scale 设备指令保持，没有重复把同一冷测称作新收益。

`bash commands.sh` 会核对整个发布清单，使用随包依赖，在新临时目录串行重跑
全部 v12 验证、公开调用/图计时和实际设备二进制核对。
环境需要相同 MetaX C500、MACA/TileLang、PyTorch、NumPy、msgpack、einops，
以及 RestrictedPython 8.5 测试 fixture `/tmp/nsa-restrictedpython-8.5`。
本地耗时受到主机与计时方式影响；正式总分和分项仍需该文件的 OJ 结果。
'''


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--summary", required=True)
    p.add_argument("--validation", required=True)
    p.add_argument("--output-dir", default=str(HERE / "release_v12"))
    a = p.parse_args()
    report = json.loads(Path(a.summary).read_text())
    module = HERE / "candidate_v12_final_submission.py"
    output, validation = Path(a.output_dir).resolve(), Path(a.validation).resolve()
    assert report["status"] == "PASS" and sha(module) == report["candidate_sha256"]
    for name, expected in report["evidence_sha256"].items():
        assert sha(validation / name) == expected, name
    assert sha(HERE / "baseline.py") == report["parent_v11_sha256"]
    official = ROOT / "experiments/20261013_mfma_fix/submission.py"
    assert sha(official) == report["official_baseline_sha256"]
    files = [p for p in HERE.rglob("*") if p.is_file() and "__pycache__" not in p.parts
        and not any(part.startswith("release_") for part in p.relative_to(HERE).parts)]
    output.mkdir(exist_ok=False)
    shutil.copy2(module, output / "submission.py")
    shutil.copy2(HERE / "baseline.py", output / "parent_v11.py")
    shutil.copy2(official, output / "baseline_8893.py")
    shutil.copy2(Path(a.summary), output / "final_summary.json")
    prior = ROOT / "experiments/20261014_goal8933/release_v11"
    shutil.copy2(prior / "final_summary.json", output / "parent_v11_summary.json")
    (output / "README.md").write_text(readme(report))
    for path in files:
        target = output / "evidence" / path.relative_to(HERE)
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, target)
    shutil.copytree(prior / "dependencies", output / "dependencies",
        ignore=shutil.ignore_patterns("__pycache__", "*.pyc"))
    study = output / "dependencies/nsa/experiments/20261014_resume8933"
    study.mkdir(parents=True)
    for name in ("baseline.py", "cases.json", "v12_cases.json", "run_v12_final.py", "summarize_v12.py",
                 "verify_host_fast_cpu.py", "verify_host_call.py", "verify_legacy_scale.py"):
        shutil.copy2(HERE / name, study / name)
    official_copy = output / "dependencies/nsa/experiments/20261013_mfma_fix/submission.py"
    official_copy.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(official, official_copy)
    (output / "commands.sh").write_text('''#!/usr/bin/env bash
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
test_study="$test_root/experiments/20261014_resume8933"
cd "$test_root"
source env.sh
set -u
export PYTHONDONTWRITEBYTECODE=1
result_dir="$(mktemp -d "${TMPDIR:-/tmp}/nsa_v12_recheck.XXXXXX")"
python "$test_study/run_v12_final.py" "$release_dir/submission.py" --output-dir "$result_dir/validation"
python "$test_study/summarize_v12.py" "$result_dir/validation" --module "$release_dir/submission.py" --output "$result_dir/final_summary.json"
printf 'Results: %s\\n' "$result_dir"
''')
    (output / "commands.sh").chmod(0o755)
    manifest = dict(candidate_sha256=sha(module), parent_v11_sha256=sha(HERE / "baseline.py"),
        official_baseline_sha256=sha(official), official_baseline_score=88.93,
        official_candidate_score=None, official_target=89.33, official_target_verified=False,
        files={str(p.relative_to(output)):sha(p) for p in sorted(output.rglob("*")) if p.is_file()})
    (output / "release_manifest.json").write_text(json.dumps(manifest, indent=2) + "\n")
    assert all(sha(output / name) == expected for name, expected in manifest["files"].items())
    print("Frozen", output, "files", len(manifest["files"]), "submission", sha(output / "submission.py"))


if __name__ == "__main__":
    main()
