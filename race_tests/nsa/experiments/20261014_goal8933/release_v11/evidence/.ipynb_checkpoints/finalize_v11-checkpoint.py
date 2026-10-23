"""Freeze the validated v11 candidate, raw evidence, and reproducible checks."""
import hashlib
import json
from pathlib import Path
import shutil

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def release_readme(report):
    correctness = report["correctness"]
    hot = report["hot"]
    cold = report["cold"]
    cold_rows = {name: {row["case"]: row for row in data["rows"]} for name, data in cold.items()}
    table = ["| OJ 形状 | 冷测 seed 0 | 冷测 seed 61 |", "|---|---:|---:|"]
    for case in report["binary"]["affected_official_cases"]:
        table.append(f"| {case} | {cold_rows['cold_seed0'][case]['candidate_speedup']:.6f}× | "
                     f"{cold_rows['cold_seed61'][case]['candidate_speedup']:.6f}× |")
    hot_negatives = [(row["case"], row["seed"], row["speedup"])
        for row in hot["oj"]["candidate_regressions"] if row["source_changed"]]
    full_negatives = [(row["case"], row["speedup"])
        for row in hot["full"]["candidate_regressions"] if row["source_changed"]]
    return f'''**NSA v11 可提交候选，2026-10-14**

提交 [submission.py](submission.py) 全文。正式已确认基线仍为 **88.93**，
目标为 **89.33**；本候选尚无官方 OJ 成绩。下面均为本地验证和设备计时。

候选 SHA256：`{report['candidate_sha256']}`。
基线 [baseline_8893.py](baseline_8893.py) SHA256：`{report['baseline_sha256']}`。
根目录旧 `nsa.py`、`submission.py` 以及所有历史发布保持原样。

选取的性能改动只在原有默认调参路径生效，`grid = B * H * seq_len`：

- 小 D32 因果 S1 的既有 Q 预读路径采用两步 Newton 倒数；既有范围为
  BS16、G16、64 线程、完整块、T≥64、grid≤64。
- BS32/D128/S1 的既有 packed 路径在 grid≥4096 时使用同次调用内的 K/V
  共同缓冲区并合并有效性分支。每次调用重新分配、重新打包当前输入。
- S2/D64/BS16 的既有 `oct8_short` 路径，仅 H=1 时采用 FP32 MMA 求和和两步倒数。
- S4/D64/BS16 的既有 staged 路径，仅 H=1、因果、T≤1024、grid≤1024 时采用
  同一归约方法。完整块与其他原有条件仍由旧分派限制。

另修复两个旧回退 builder 的 int32 块索引溢出：先验证原始块号，再乘块大小。
旧版在 T127/S4 和 S2 回退路径上会将某些极大无效索引回绕为有效地址。
普通输入逐位保持；极端输入现在符合独立参考。显式调参仍选择原 builder。
FP32 MMA 参数继续使用 `"float32"` 字符串，保持上次 OJ 类型兼容修复。

{correctness['reference_cases']} 例独立 FP32 参考的 factory/run_kernel 双接口通过，
最大绝对误差 {correctness['max_abs_error']}。新增检查包括
{correctness['boundaries']} 个边界、{correctness['scales']} 组 scale/极端索引、
{correctness['live_graph_and_direct']} 次同地址输入更新的图回放及直接调用、
{correctness['restricted_host']} 组本地 RestrictedPython host、
{correctness['strict_fp32_builders']} 个严格 FP32 FFI builder 探针，
以及 {correctness['legacy_guard_cases']} 组旧回退路径检查。
CPU 分派检查覆盖 {correctness['dispatch_configurations']} 个配置、
{correctness['dispatch_requests']} 次请求。官方 sandbox 未在本机运行。

两步倒数另经过 8,755,201 个 GPU 输入验证；最大相对误差
6.621132e-6，小于检查界限 7e-6。共同 K/V 布局的 8,192 个块内元素映射为双射。
61 个原函数和所有非函数模块语句保持；改变 4 个原函数，新增 8 个 helper/builder。
没有增加设备启动数、外部设备代码、异步拷贝或跨调用张量缓存。
race/bounds 检查未禁用，编译参数保持。

14 个精确 OJ 形状 × 两种子的 A/B/A 图计时，包含所有打包和注意力 kernel：
过滤前后基线漂移大于 1% 的轮次后，几何平均加速比
**{hot['oj']['all']['candidate']['filtered']:.8f}×**；不筛选轮次为
{hot['oj']['all']['candidate']['unfiltered']:.8f}×。同源控制分别为
{hot['oj']['all']['control']['filtered']:.8f}× / {hot['oj']['all']['control']['unfiltered']:.8f}×。
109 例全量分别为 **{hot['full']['all']['candidate']['filtered']:.8f}×** /
{hot['full']['all']['candidate']['unfiltered']:.8f}×，同源控制为
{hot['full']['all']['control']['filtered']:.8f}× / {hot['full']['all']['control']['unfiltered']:.8f}×。

最终冷测每次公开调用前冲刷 256 MB，6 轮、每轮 48 次，计入所有 NSA 设备 kernel。
实际改变指令的四个 OJ 形状如下；它们不能单独代表全体 OJ 得分。

{chr(10).join(table)}

所有负值都保留。改动路径在 OJ 热测中的回退记录为 `{hot_negatives}`；
在全量热测中为 `{full_negatives}`，依次记录 case/seed（如适用）/加速比。
完整逐轮数据、同源控制与相邻形状见 [final_summary.json](final_summary.json)
及 `evidence/validation_v11_final/`。

最终实际 JIT 库的 `.text` 审计覆盖 19 个配置，精确 OJ 中只改变
#1/#6/#10/#11；其余十个 OJ 形状的设备指令保持。审计配置的计时源码哈希
与实际库对应，其中包括全部 28 条 OJ 计时记录。

未采用的试验也完整保留。尤其是两头遍历在最终相邻 B3/T128 冷测两种子
分别为 0.952171× / 0.948737×，S4 的 B4/T512、grid2048 为
0.976411× / 0.979009×，所以最终删除两头遍历并将 S4 上限收紧为 grid1024。
两波 S2/S4、S8 分母、编译调度参数、V 读取顺序等反例见研究 README 和原始日志。
部分调度参数的实际 `.text` 完全相同，未将其计时差异算作代码优化。

从同一 MetaX/TileLang 环境运行 `bash commands.sh`，会先验证整个发布的哈希，
再使用随附依赖于新的临时目录串行重跑验证、热测、冷测和实际二进制审计。
输入、参考、测试工具和原始正负证据均已随包保留。
需要提交本文件并取得官方总分及分项耗时，才能确认 89.33 是否达到。
'''
