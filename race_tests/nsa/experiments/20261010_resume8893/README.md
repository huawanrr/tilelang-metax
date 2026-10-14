# 2026-10-10 接续 v6 88.93

用户确认 `../20261008_resume8871/candidate_v6_submission.py` 得到当前最高正式分数 88.93。
目标 89.5；尚未收到本次完整逐点 OJ 报告。
`baseline.py` 与 `baseline_control.py` 是同一提交的逐字节冻结副本。

已恢复指定会话中的 v7：`../20261009_goal8933/candidate_v7_submission.py`。
该版本旧的六项最终检查已经完成，但此前比较基线是 v4，不能把旧报告中的
加速比当作相对当前正式 v6 的收益。当前目录的 `v7_parent.py` 是其冻结副本。

## 当前研究

- `v7_vs_v6_oj.json`：14 个 OJ 形状、两个种子；v7 相对 v6 为 1.005186×，
  同源控制 1.000074×。#5 两次回退约 2%，后续轮次幅度减小，所有记录保留。
- `load_mask_screen_serial.json`：9 个形状完成。vec8 平均 0.54697×，Q16 为
  0.94175×，提前初始化掩码也没有普遍收益；这些方案不采用。
- `reduction_screen.json`：独立读取三个 lane 部分和在 #4 初筛有约 2% 信号。
  `mid_reduce_family.json` 随后发现重复回退，因此不合入。
- `mid_q_family.json`：26 条非因果多头记录，Q4 虽有局部收益，但 H3、H4
  和较大 H2 网格存在反例，因此不全局替换 Q 布局。
- `large_mask_screen.json`：把大尺寸路径的掩码移到指数之后，仅处理当前
  因果边界块；保留 FP32 MMA 分母。自然指数表达版的 #8/#9 两种子均快
  约 1.1%–1.3%，#5 接近持平且略慢，完整保留负值。
- `large_mixed_family.json`：11 个不同批次/头数/相邻长度，两个种子，
  新大尺寸表达的 22 条记录全部改善，几何平均 1.02449×，最小 1.00516×。
- `d128_load_family.json`：继续核对 D128、因果/非因果和读取宽度组合。
  该文件的最终状态以 `confirmation_runs.json` 为准。

所有有效 GPU 计时串行，包含公开入口的全部 kernel 启动；同源控制、
接受和拒绝的原始试验均保留。早先 `load_mask_screen_v2.log` 和 `v3.log`
有调度重叠，已终止并排除，说明见 `screen_orchestration_note.json`。

`assemble_v8.py`、`run_v8_validation.py`、`audit_v8.py` 用于组装和验证最终字节。
不使用异步拷贝、外部设备源码、输入/预处理/输出跨调用缓存，不修改后端，
不关闭 race/bounds 检查。恢复的 v7 仅增加完整参数的已编译 callable 查找。

当前状态：研究和候选准备中，尚无新候选的官方成绩，89.5 未确认。
