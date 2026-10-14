"""Record all S8 screen results and keep the validated D128 release selected."""

import hashlib
import json
from pathlib import Path


HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    records = []
    for name in ("screen.json", "schedule_screen.json"):
        path = HERE / name
        report = json.loads(path.read_text())
        assert len(report["rows"]) == 6 and "geomean_speedups" in report
        assert (report["rounds"], report["repeat"], report["samples"]) == (4, 200, 7)
        modules = list(report["source_sha256"])
        for module, expected in report["source_sha256"].items():
            assert digest(ROOT / module) == expected
        for index, module in enumerate(modules[1:], 1):
            records.append(dict(module=module, report=name, shapes=6,
                geomean_speedup=report["geomean_speedups"][index],
                speedup_range=[min(row["speedups"][index] for row in report["rows"]),
                               max(row["speedups"][index] for row in report["rows"])],
                max_abs_error=max(row["max_abs_error"][index] for row in report["rows"]),
                below_one=[dict(case=row["case"], config=row["config"], speedup=row["speedups"][index])
                           for row in report["rows"] if row["speedups"][index] < 1],
                adopted=False))
    summary = dict(status="completed; no S8 change adopted", baseline_official_score=88.29,
        validated_candidate="experiments/20261003_d128_v1/submission.py", records=records,
        rationale="No broad, convincing improvement in either screen; retain the independent D128 gain.")
    with (HERE / "experiment_summary.json").open("x") as output:
        output.write(json.dumps(summary, indent=2) + "\n")
    table = "\n".join(f"| {Path(row['module']).stem} | {row['geomean_speedup']:.8f}× | "
                      f"{row['speedup_range'][0]:.6f}–{row['speedup_range'][1]:.6f}× |"
                      for row in records[3:])
    with (HERE / "README.md").open("a") as output:
        output.write(f"""

## 第二轮完成

四种加载调度各6个形状全部参考检查通过，计时仍为4轮交替、200调用、7次采样：

| 方案 | 几何平均加速比 | 各形状范围 |
|---|---:|---:|
{table}

这些变化没有形成足够明确的整体收益，均不合入。较浅K lookahead在oj12将mtreg从103降至87，
但时延没有改善；private memory均为0。机器码和资源证据位于schedule_resources_oj12.json及
schedule_machine_code_oj12.json。所有42个候选形状检查、原始轮次、负样本和生成代码保留。

本轮已结束，最终采用独立的D128优化，提交文件为 `../20261003_d128_v1/submission.py`。
该版109例相对正式88.29基线平均1.00586958×；完整发布验证以该目录release_manifest.json为准。
这不是新的正式OJ成绩。实验汇总见experiment_summary.json。
""")
    evidence = {str(path.relative_to(ROOT)): digest(path) for path in sorted(HERE.rglob("*"))
                if path.is_file() and "__pycache__" not in path.parts and path.name != "manifest.json"}
    with (HERE / "manifest.json").open("x") as output:
        output.write(json.dumps(dict(status=summary["status"], evidence_sha256=evidence), indent=2) + "\n")
    print(json.dumps(summary, indent=2))


if __name__ == "__main__":
    main()
