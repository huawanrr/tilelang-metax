"""Update the workspace recommendation only after the frozen release is verified."""
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
RELEASE = HERE / "release_v5"
LABEL = "experiments/20261008_resume8857/release_v5/submission.py"


def main():
    for line in (RELEASE / "SHA256SUMS").read_text().splitlines():
        expected, name = line.split("  ", 1)
        assert hashlib.sha256((RELEASE / name).read_bytes()).hexdigest() == expected, name
    manifest = json.loads((RELEASE / "release_manifest.json").read_text())
    perf = json.loads((RELEASE / "performance_summary.json").read_text())
    sha = manifest["source"]["submission"]
    assert manifest["official_candidate_score"] is None
    full = perf["full"]
    oj = perf["oj"]
    summary = f"""## 2026-10-08 后续：v5 已完成验证并封存，正式成绩待 OJ

**当前可试交：`{LABEL}` 全文。**
SHA256：`{sha}`。
正式基线仍是 v4，同版观测为 **88.57 / 88.71**；复提交差值属于测量波动，
不能算代码收益。**v5 尚无正式成绩，89.5 目标未确认。**

仅新增小 S1 的 Q 读取调度与小网格 D128 直接 K/V 路径。
D32 限制为完整块、因果、T≥64、grid≤64；D64 沿用 v4 小 direct 范围；
D128 为完整 BS16、grid≤128，均仅用于默认调参。
S2 的新 shuffle、wave 同步及完整块读取探针出现复测反例，全部未合入。
55 个原非分派函数保持，只新增一个 builder。根目录旧 `submission.py` 不是 v5。

125 例独立 FP32 双接口、76 个边界、70 组极端索引/scale、136 项调参对照
（含 8 项与基线相同的原有不支持结果）、8 组缓存顺序、48 次同地址输入更新、
10 项 RestrictedPython host 检查通过；18 处片段映射证明通过。
137 条最终计时记录、110 个配置与开发/提交设备码一致；
342 条家族记录的保留与恢复路径也已核对。

109 例本地全量为 **{full['all']['candidate_accepted']['geomean']:.8f}×**；
{full['changed']['candidate_accepted']['count']} 个改动记录中 {full['changed']['candidate_accepted']['improved']} 个提速。
14 个精确 OJ 形状、两个种子为 **{oj['all']['candidate_accepted']['geomean']:.8f}×**，
本次只改变 #1/#2。21 形状、六轮逐次 256 MB 冲刷的冷缓存数据及所有负记录
见发布目录 `README.md` / `performance_summary.json`，不据此补造正式分数。

发布包含源文件、依赖、正负研究、复现命令和完整哈希清单。
`bash experiments/20261008_resume8857/release_v5/commands.sh` 在新目录顺序复现。
冻结 v4 保留，可用于回退及正式对比。

"""
    for name in ("NOTES.md", "提交说明.md"):
        path = ROOT / name
        old = path.read_text()
        assert LABEL not in old, "Do not publish the same recommendation twice"
        title, rest = old.split("\n", 1)
        if name == "提交说明.md":
            rest = rest.replace("**现在提交：`experiments/20261008_goal895/release_v4/submission.py` 全文。**",
                                "**v4 历史提交：`experiments/20261008_goal895/release_v4/submission.py` 全文。**", 1)
        path.write_text(title + "\n\n" + summary + rest.lstrip("\n"))
    print(LABEL)
    print(sha)


if __name__ == "__main__":
    main()
