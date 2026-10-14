# 2026-10-08：从正式 v4 继续冲 89.5

基线是冻结的 `../20261008_goal895/release_v4/submission.py`，开发与提交副本
分别为本目录 `baseline.py` 和 `baseline_submission.py`。用户先报告 88.57，
同版复测为 88.71，并明确指出 OJ 抖动；两次结果记在 `official_baseline.json`。
当前没有达到或验证正式 89.5。历史 release 不修改。

所有 GPU 测量依次进行。热测使用公开调用、共享图内存池、A/B/A 交错、同源
控制及独立 FP32 参考；冷测每次调用前冲刷 256 MB，累计全部 NSA 设备 kernel。
保留负结果，不使用异步拷贝、外部设备源码、输入/结果缓存或关闭边界/race 检查。

## 已完成的研究

- D64 PV 转置及成对输出：四个 OJ 形状、两个种子均正确；两个变体几何平均
  分别为 0.84779×、0.86782×，不采用。`d64_transposed_screen.json`。
- S8 全列表完整有效块分支：oj12 两个种子均慢约 1.4%；case81 设备路径不变，
  不采用。`s8_full_list_screen.json`。
- 小 S1 的 Q 读取顺序：原生成 LLVM IR 把 Q load 移入索引有效分支。
  Q 后显式 wave 同步使 Q load 留在索引读取之前；初筛 D64/oj2 两种子为
  1.0852×、1.1061×，D32/oj1 为 1.0251×、1.0187×。
  `tiny_preload_screen.json`。volatile 与逐元素 volatile 方案未采用。
- 小 Q 同步的独立冷缓存检查：六轮、每轮 48 次、seed61。
  oj1 4.0453→3.8133 μs，oj2 5.0640→4.7600 μs。
  同源控制及所有事件保存在 `tiny_qsync_cold.json`。
- Q 调度的宽范围探针：额外 wave 同步使 coalesced Q 的 aggregate copy
  留下私有数组；oj4 private memory 0→36 bytes，显著回退。移动已有 Q shared
  暂存可改善部分中网格，oj5/oj6/oj14 回退，因此两个探针都不能整体采用。
  `qschedule_screen.json`、`qschedule_resources_oj4.json`。

## 后续筛选与反例

- `tiny_family_screen.json`：62 个邻近形状、两个种子，包含非因果与不同 B/H。
  小 D64 原 direct 范围内 47/48 提速，几何平均 1.06050×；D32 有反例。
  D128 小网格直接 K/V 读取有明显收益，扩展到大网格则回退。
- 成对 Q 读取消除了新增同步附近的私有数组，部分中网格热测改善；但冷缓存
  oj4/oj8/oj9 回退，已从 `candidate_probe_v2.py` 移除。
  `qpair_schedule_screen.json`、`candidate_probe_v1_cold.json` 保留全部结果。
- `lane_shuffle.py` 的 S2 首轮测量在 oj10 为 1.03945× / 1.00971×，
  冷缓存合并探针也有收益，但后续家族确认出现大量反例，不能整体采用。
  LLVM 删除了两处比较与两处 select；mbcnt 仍存在，不宣称消除了全部 lane 计算。
- S8 有效地址的无条件 K 预取、标量分母累加都无可靠收益。
  BS32 packed V 的部分提前读取宽度 16/32/64/128 均不采用。
  `s8_prefetch_sum_screen_v2.json`、`packed_v_preload_screen.json` 记录结果。
- 显式 64/128-bit Q 读取在较大、多 head 网格回退，不采用。
  `research_status.json` 汇总早期各探针的完整正负结果。

## 三种子家族确认

`confirmation_screen.json` 完成 114 个形状 × seeds 0/61/2026，共 342 条记录。
每图 500 次公开调用、24 组 A/B/A、共享内存池，含同源码控制及正反图回放检查。
比较对象为 v4、同源控制、`candidate_probe_v2.py` 和延后归一化探针。
`confirmation_summary.json` 保存完整分组及所有负记录。

| Probe 改动范围 | 记录数 | 几何平均 | 最小 | 提速记录 |
|---|---:|---:|---:|---:|
| D128，grid≤128 | 84 | 1.356570× | 1.159366× | 84 |
| D64，既有小 direct 范围的确认形状 | 24 | 1.083301× | 1.018829× | 24 |
| D32，grid≤64 的宽探针 | 60 | 1.000486× | 0.922141× | 31 |
| 短 S2，原 oct8_short 范围 | 114 | 1.006002× | 0.962719× | 62 |

D32 长度 16、多 B/H 和部分非因果形状回退，最终候选仅保留
完整块、因果、T≥64、grid≤64 的范围。最初保留的 T48 在最终冷测六轮中
全部回退，平均 0.981952×，已在 `candidate_v5b.py` 恢复 v4。
S2 尾块的因果用例全部回退，
尚不把最初的 shuffle 提升视作稳定收益。默认 D64/D128 保持提前归一化。
这张表描述完整 probe，不能充当收窄后最终提交文件的计时。

S2 最后一组对照已经完成：把三处 block 同步换成三处显式 wave 同步，
并在 v4 数学实现上复查完整块成对读取。只有 wave + shuffle 的组合在
8 条初筛记录中全为正，平均 1.021668×；随后 42 形状 × 3 seeds 复测为
1.010966×，出现 OJ #10 的 0.959593×、多 B/H 的约 3% 回退等反例。
全部 S2 新改动均未合入；源码、全部正负结果保留。
生成器为 `make_short_sync.py` / `make_short_pairs.py`，计时驱动为
`run_short_sync_screen.py` / `run_short_wave_confirmation.py`。

## 最终候选验证

内部修订源为 `candidate_v5b.py` / `candidate_v5b_submission.py`，最终发布标签为 v5。
旧 `candidate_v5.py` 及其冷缓存反例保持原样。当前由 `run_v5b_validation.py`
对实际修订文件重新运行双接口参考、边界、调参、14 个 OJ 形状、109 例、
冷缓存与设备码核对；验证结束前仍使用冻结的 v4 作为可提交基线。

`inspect_ir.py` 只复制 TileLang 已生成的 C++ 并在 CPU 编译诊断 LLVM IR；
这些 C++/IR 不被 GPU 测试加载，也不会进入提交实现。
截至本记录，仍推荐已实测的冻结 v4；本目录各 probe 尚不是发布版本。
