"""Write release documentation from the final measured reports."""
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent


def read(name):
    return json.loads((HERE / name).read_text())


def digest(name):
    return hashlib.sha256((HERE / name).read_bytes()).hexdigest()


def main():
    performance = read("candidate_v5b_performance_summary.json")
    extra = read("candidate_v5b_extra.json")
    audit = read("candidate_v5b_audit.json")
    components = read("candidate_v5b_components.json")
    reference = read("candidate_v5b_reference.json")
    assert extra["status"] == audit["status"] == components["status"] == "PASS"
    hot_rows = []
    for name, label in (("oj", "14 个精确 OJ 形状 × 2 seeds"), ("full", "109 例全量")):
        for subset, desc in (("all", "全部"), ("changed", "设备代码改变"), ("unchanged", "设备代码不变")):
            a = performance[name][subset]["candidate_accepted"]
            u = performance[name][subset]["candidate_unfiltered"]
            hot_rows.append(f"| {label}，{desc} | {a['count']} | {a['geomean']:.8f}× | {u['geomean']:.8f}× | {a['improved']}/{a['count']} |")
    cold = {row["case"]: row for row in performance["cold"]["rows"]}
    cold_rows = []
    labels = {
        "oj1": "OJ #1，D32/T64",
        "oj2": "OJ #2，D64/T128",
        "d128_b1_t64_h1_c1": "本地补充 D128，B1/T64/H1，因果",
        "d128_b1_t128_h1_c1": "本地补充 D128，B1/T128/H1，因果",
        "d128_b1_t64_h2_c0": "本地补充 D128，B1/T64/H2，非因果",
        "d128_b2_t64_h1_c1": "本地补充 D128，B2/T64/H1，因果",
        "d32_b1_t48_h1_c1": "D32，B1/T48/H1，因果（恢复 v4）",
    }
    for name, label in labels.items():
        r = cold[name]
        values = r["median_kernel_us"]
        positive = sum(s > 1 for s in r["paired_round_speedups"])
        cold_rows.append(f"| {label} | {values[0]:.4f} | {values[1]:.4f} | {values[2]:.4f} | {r['speedup'][2]:.6f}× | {positive}/{r['rounds']} |")
    negatives = []
    for name in ("oj", "full"):
        for r in performance[name]["negative_cases"]:
            negatives.append(f"- {name}/{r['case']}，seed {r['seed']}：{r['summary']['median_speedup']:.8f}×；"
                             + ("设备代码改变。" if r["changed"] else "设备代码与 v4 相同。"))
    counts = {k: len(extra[k]) for k in ("boundaries", "extreme_scales", "tuning", "cache_order", "live_inputs", "restricted_host")}
    retained = performance["confirmation_retained"]["all"]["candidate_accepted"]
    reference_error = max(r["max_abs_error"] for r in reference)
    text = f"""# NSA v5：小 S1 的 Q 读取调度与小 D128 直接读取

可提交文件：`experiments/20261008_resume8857/release_v5/submission.py`。
与 `candidate_v5b_submission.py` 逐字节相同，SHA256：
`{digest('candidate_v5b_submission.py')}`。

正式基线仍是 v4，同一源码先后测得 **88.57 / 88.71**；保留两次观测，
不能把这次复提交的变化当成代码收益。**v5 尚无正式成绩，89.5 目标未确认。**
本版只保留有复测依据的小 S1 改动；S2 的所有新探针均未合入。

## 最终范围与实现

以下范围均要求默认调参、G=HQ/H=16、S=1、BS=16、完整序列块。
`grid = B * H * T`。分派只依赖公开形状和参数。

| 维度 | 新路径范围 |
|---|---|
| D32 | 因果，T≥64，grid≤64 |
| D64 | 沿用 v4 小 direct 范围：grid≤256，且 grid≤128 或 T≥128 |
| D128 | grid≤128 |

Q 读取后放置一次无条件 wave 同步，使读取保持在索引相关分支之前。
K/V 按现有 MMA 布局直接进入寄存器，实际 shared 为 0，wave 同步为 1。
D64/D128 提前归一化，D32 延后归一化，原指数与掩码公式保持。
先检查原始块号，再生成元素地址。D128 原小路径为 4096 bytes shared、1 次 wave 同步，
新路径省去 V 的共享内存转换；不是减少同步次数。

仅新增 `native_sparse_attention_q_preload`；{len(audit['static']['unchanged_original_functions'])} 个原有非分派函数保持。
显式调参继续使用原路径，新标志进入编译缓存键。没有新增 kernel 启动或输入预处理。
两个公开接口、当前输入读取、原 race/bounds 检查保持；无异步拷贝、外部设备源码、
输入/结果缓存或 Torch 算子代算。

## 最终文件性能

相对冻结 v4；使用相同输入/输出、共享图内存池和 A/B/A 交错，包含全部公开调用启动。
保留所有漂移样本；“接受样本”要求相邻基线漂移≤1%。表中是逐记录中位加速比的几何平均。

| 集合 | 记录数 | 接受样本 | 不过滤样本 | 提速记录 |
|---|---:|---:|---:|---:|
{chr(10).join(hot_rows)}

OJ 同源控制为 {performance['oj']['all']['control_accepted']['geomean']:.8f}×，
全量同源控制为 {performance['full']['all']['control_accepted']['geomean']:.8f}×。
原始数据为 `candidate_v5b_oj.json` / `candidate_v5b_full.json`。
OJ 中本次只改变 #1/#2；小 D128 补充形状的收益不等于 OJ #3 的收益。

每次直接公开调用前冲刷 256 MB，seed61，六轮各 48 次；累加所有 NSA 设备 kernel 事件。
21 个形状包含全部 14 个 OJ 形状、D128 多 B/H 与非因果、D32 邻近形状及未改动的 S2 控制。
计时不含 Python 开销和设备空闲间隔，不能冒充完整官方计时器。

| 形状 | v4 μs | 同源控制 μs | v5 μs | 加速比 | 提速轮数 |
|---|---:|---:|---:|---:|---:|
{chr(10).join(cold_rows)}

全部冷缓存事件、21 形状的正负记录见 `candidate_v5b_cold.json`。
最终热测中所有负记录如下，均保留，没有用单次最好值替换：

{chr(10).join(negatives) if negatives else '没有负记录。'}

## 正确性与设备代码

- 125 例独立 FP32 参考，TF32 关闭，工厂和 `run_kernel` 都通过；最大绝对误差 {reference_error}。
- {counts['boundaries']} 个边界、{counts['extreme_scales']} 组极端索引/scale、{counts['tuning']} 项调参对照、
  {counts['cache_order']} 组缓存顺序、{counts['live_inputs']} 次同地址输入刷新/图回放、{counts['restricted_host']} 项 RestrictedPython host 检查通过。
  保留与基线相同的原有不支持调参结果；host 检查不是完整官方沙箱。
- 18 处标量片段的覆盖、唯一性与线程归属证明，以及完整块地址检查通过。
- {len(audit['timings'])} 条最终计时记录、{len(audit['configurations'])} 个配置的开发/提交设备码和编译参数一致；
  也与实际计时保存的 device source hash 一致。范围外设备码保持 v4。
- {len(components['rows'])} 条家族记录、{components['unique_configurations']} 个配置核对完成；
  保留范围的 {retained['count']} 条记录平均 {retained['geomean']:.8f}×，{retained['improved']} 条提速。
  这是收窄后范围内的组件证据；完整 probe 的反例仍在 `confirmation_screen.json`。

## 未采用的研究

D32 原 grid≤64 宽探针只有 31/60 条提速，最差 0.922141×，因此收窄因果和序列范围。
较早候选 `candidate_v5.py` 在 T48 的冷缓存六轮全部回退，平均 0.981952×；
最终使用 `candidate_v5b.py` / `candidate_v5b_submission.py`，将该形状恢复 v4。
这次修正只改变一个分派下界，所有 kernel 函数体保持；最终文件已重新验证和计时。
直接 K/V 扩展到大 D64/D128 网格、coalesced Q 调度、显式宽 Q 读取、
S8 完整列表分支/无条件 K 预取/标量分母、BS32 V 提前读取均未合入。

S2 原显式来源 shuffle 在 114 条改动记录中有 52 条回退。三处 wave 同步的组合
初筛 8/8 提速，随后 42 形状×3 seeds 复测出现 OJ #10 的 0.959593× 等反例，
因此 S2 全部保持 v4。完整块成对读取等其余 S2 探针也有明显回退。
全部源码、失败日志和正负数据保留在研究目录与归档，不从最好单次值推断分数。

## 复现与封存

从当前工作区运行 `bash experiments/20261008_resume8857/release_v5/commands.sh`。
脚本先检查发布文件与依赖哈希，再新建目录顺序运行，历史结果不会被覆盖。
需要本工作区 MACA/TileLang 环境及已有 `/tmp/nsa-restrictedpython-8.5`。
实际环境在 `environment.json`；依赖副本、原始研究、哈希清单均随发布封存。

开发 SHA256：`{digest('candidate_v5b.py')}`。
提交 SHA256：`{digest('candidate_v5b_submission.py')}`。
"""
    with (HERE / "README_v5.md").open("x") as file:
        file.write(text)
    print(HERE / "README_v5.md")


if __name__ == "__main__":
    main()
