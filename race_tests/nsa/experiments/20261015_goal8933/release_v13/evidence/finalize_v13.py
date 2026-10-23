"""Freeze the verified submission, evidence, dependencies, and reproduction commands."""
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
    graph = report["graph"]["aggregate"]["candidate"]
    cold = {seed:next(r for r in data["rows"] if r["changed"])
            for seed, data in report["cold"].items()}
    checked = report["correctness"]
    windows = report["graph_windows"]
    return f'''# NSA v13，2026-10-15

提交本目录 `submission.py` 全文。
SHA256：`{report['candidate_sha256']}`。
正式已确认基线仍为 **88.93**；本版本尚无官方成绩，**89.33 未确认达到**。

在 v12 的既有小 D32 默认路径内，将分母的两次 shuffle 改为一次 FP32 MMA，
并使用 `exp(-log(x))` 求倒数，保留正分母 guard 和输出端归一化。
仅改变 `native_sparse_attention_q_preload_vfirst`；公开分派、调参回退、
输入转换、checked adapter、打包及其他函数的 AST 保持。
FP32 emitter 的三个 dtype 参数都是字符串，已通过严格 PrimExpr 检查。

14 个 OJ 形状 × 两种子的最终 GPU 图计时，相对 v12 未过滤几何平均为
**{graph['unfiltered']:.8f}×**；改动的 OJ1 为 **{graph['changed_unfiltered']:.8f}×**。
这组最终热测接近持平。补充的同进程 100/400/800/1600 次图回放、三个种子
共 12 组结果，未过滤平均 {windows['aggregate']['candidate']['unfiltered']:.8f}×，
其中 {len(windows['regressions'])} 组回退。跨轮热测提升幅度尚不稳定，保留所有结果。
冷测在每次公开调用前冲刷 256 MB，包含所有 NSA 设备启动；OJ1 的两个种子
分别为 **{cold['0']['candidate_speedup']:.8f}×**、**{cold['61']['candidate_speedup']:.8f}×**。
同源控制、负值、未改动形状及全部原始轮次均保留。Python 公开调用计时另存，
包含提交间隙，不作为 GPU 时间或官方评分的替代。

验证包括 {checked['reference_cases']} 个双接口独立 FP32 参考用例
（最大绝对误差 {checked['reference_max_abs_error']}）、26 个边界、30 组 scale、
36 次同地址输入更新、6 个严格 FP32 builder 检查；另有索引转换、参数错误、
缓存与受限 host 检查，以及 {checked['cpu_configurations']} 个 CPU 分派配置、
{checked['cpu_public_requests']} 次公开请求。
GPU 倒数数学检查覆盖 {checked['math_inputs']:,} 个输入，自然指数形式最大
相对误差 {checked['math_exp_log']['max_relative_error']:.8g}。
19 个实际二进制配置确认：只有 OJ1 的设备指令变化，寄存器 34→32，
`.text` 从 2048 降至 1792 字节，启动数保持。

S4 的局部信号未能稳定复现，保持 v12；S8、LDG/STG、环形预取、提前归一化等
负实验完整保留在 `evidence/`。旧 v12 及正式 88.93 源码分别保存在
`parent_v12.py`、`baseline_8893.py`。

运行 `bash commands.sh` 会先校验所有发布文件，再在新临时目录串行复现验证、
热/冷计时、实际二进制审计及 GPU 数学检查。依赖沿用 v12 的 MACA、Torch、
TileLang 环境和 RestrictedPython 8.5 fixture；`source env.sh` 使用
`/app/tilelang-metax` 的活动构建。详见 `final_summary.json` 和 `release_manifest.json`。
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
    for name, digest in report["evidence_sha256"].items():
        assert sha(validation / name) == digest, name
    assert sha(HERE / "baseline.py") == report["parent_v12_sha256"]
    official = ROOT / "experiments/20261013_mfma_fix/submission.py"
    assert sha(official) == report["official_baseline_sha256"]
    assert sha(Path(report["math_evidence"]["path"])) == report["math_evidence"]["sha256"]
    assert sha(Path(report["windows_evidence"]["path"])) == report["windows_evidence"]["sha256"]
    # Take the snapshot before creating the release directory.
    files = [p for p in HERE.rglob("*") if p.is_file() and "__pycache__" not in p.parts
             and not any(part.startswith("release_") for part in p.relative_to(HERE).parts)]
    output.mkdir(exist_ok=False)
    shutil.copy2(module, output / "submission.py")
    shutil.copy2(HERE / "baseline.py", output / "parent_v12.py")
    shutil.copy2(official, output / "baseline_8893.py")
    shutil.copy2(Path(args.summary), output / "final_summary.json")
    prior = ROOT / "experiments/20261014_resume8933/release_v12"
    shutil.copy2(prior / "final_summary.json", output / "parent_v12_summary.json")
    (output / "README.md").write_text(readme(report))
    for path in files:
        target = output / "evidence" / path.relative_to(HERE)
        target.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, target)
    shutil.copytree(prior / "dependencies", output / "dependencies",
                    ignore=shutil.ignore_patterns("__pycache__", "*.pyc"))
    study = output / "dependencies/nsa/experiments/20261015_goal8933"
    study.mkdir(parents=True)
    for name in ("baseline.py", "cases.json", "run_v13_final.py", "summarize_v13.py",
                 "verify_changed_families.py", "audit_binary.py", "make_recip_log.py",
                 "verify_recip_log_math.py", "recip_log_math.json", "bench_graph_windows.py"):
        shutil.copy2(HERE / name, study / name)
    write_commands(output)
    manifest = dict(candidate_sha256=sha(module), parent_v12_sha256=sha(HERE / "baseline.py"),
                    official_baseline_sha256=sha(official), official_baseline_score=88.93,
                    official_candidate_score=None, official_target=89.33, official_target_verified=False,
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
test_study="$test_root/experiments/20261015_goal8933"
cd "$test_root"
source env.sh
set -u
export PYTHONDONTWRITEBYTECODE=1
result_dir="$(mktemp -d "${TMPDIR:-/tmp}/nsa_v13_recheck.XXXXXX")"
python "$test_study/run_v13_final.py" "$release_dir/submission.py" --output-dir "$result_dir/validation"
python "$test_study/bench_graph_windows.py" "$test_study/baseline.py" "$result_dir/validation/control.py" "$release_dir/submission.py" --output "$result_dir/graph_windows.json"
python "$test_study/verify_recip_log_math.py" --output "$result_dir/recip_log_math.json"
python "$test_study/summarize_v13.py" "$result_dir/validation" --module "$release_dir/submission.py" --math-result "$result_dir/recip_log_math.json" --windows "$result_dir/graph_windows.json" --output "$result_dir/final_summary.json"
printf 'Results: %s\\n' "$result_dir"
''')
    commands.chmod(0o755)


if __name__ == "__main__":
    main()
