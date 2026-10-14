# NSA 当前提交版（2026-09-27，修复 OJ 禁类错误）

推荐提交 **`submission.py` 全文**；`nsa.py` 是带注释开发版。两者 18 个代表形状的
生成设备代码逐字节一致，Jupyter checkpoints 已同步。

当前阶段目标为 **87 分**，最后已知 OJ 成绩仍为 **86.5**。上一版因
`Class definitions are not allowed in user code` 在源码加载时被拒绝，未产生新分数。
现已把类包装改成普通函数闭包；修复版尚待 OJ 重测。

## 当前版本

- `nsa.py` SHA256：`05b75c391ed14b373b46f7b458c7765925ba12bc13e69d7bd09ccea09757aa86`
- `submission.py` SHA256：`6b6c307c5d894cf50857691d86eb26219032ab0f22b0469ad07cd9388a8b7d65`
- 版本与证据清单：`experiments/20260927_oj_fix/release_manifest.json`。

## 已合入优化

1. S>1 索引预载；D64/BS16/G16/S>=8 的 K/V 在每次调用中重新打包，随后直接加载
   匹配 MMA 的寄存器片段。计时包含打包 kernel。
2. S1/BS16/G16 小网格直接加载 K 到寄存器：D32/D64/D128 分别在
   B*H*seq_len <=512/256/128 时启用。
3. D64/BS16/G16/S1 在 256<B*H*seq_len<=1024 时提前同步拷贝 Q 到共享内存；
   仅用于默认寄存器暂存且 Q 未直进 MMA 的路径。大网格保持原有调度。
4. D64/BS16/G16/S8、B*H*seq_len>=4096 使用两份交替 PV 累加结果；
   小网格及 S16 保留单份累加结果。

所有分派仍位于 `_get_kernel`，两个公开入口共用。**没有异步拷贝、外部设备代码、
`T.call_extern` 或 `T.import_source`**；缓存仅保存编译产物与形状，不保存输入相关结果。
`check_submission_nsa.py` 检查类定义禁令、已知禁用项、导入限制和 NSA 接口；等价检查还会拒绝
生成设备代码中的异步拷贝标记。

## 本次修复验证

- 修正版重新通过 125 个用例，两个接口均通过；12 次输入刷新检查通过。
- 修复前开发版、修复后开发版和提交版：18 个代表形状设备代码全部一致。
- AST 确认所有 GPU kernel 构建函数未变；两个提交文件均无类定义。
- 新增检查能复现旧版的类定义拒绝，并放行修正版的已知规则检查。
- 本地没有官方 `triton_sandbox`，完整沙箱兼容性仍需 OJ 确认。

## 优化版本的原始验证记录

- 125 个全量及边界用例 + 30 个额外边界检查，工厂和 `run_kernel` 均通过。
- 12 次原地修改 Q/K/V 后重复调用检查通过，覆盖小/大 S8 路径。
- 18 个代表形状设备代码等价；已知提交限制静态检查通过。
- 109 个性能用例对比本轮初始 86.5 分源码，几何平均加速 **1.02535x**；
  本轮测量没有超过 3% 的回退。
- S8 代表用例：63.54→56.15 us；另两例 16.13→12.67、21.49→17.57 us。
  D64 中小网格代表用例：6.66→6.14、8.10→7.73 us。

参考实现、提供的测试和容差没有因这些优化而改变。计时使用预分配输出的公开
`run_kernel`、CUDA graph 和约 40ms GPU 预热；不计编译/分配，计入打包 kernel。
测试脚本里的单 MACA stream 驱动兼容处理不在提交文件中。

## 接口

```python
kernel = native_sparse_attention(batch=B, heads=HQ, seq_len=T, dim=D,
    is_causal=c, scale=0.1, block_size=bs, groups=HQ//H, selected_blocks=S)
out = kernel(q, k, v, block_indices)

run_kernel(q, k, v, block_indices, out, B, T, H, HQ, D, S, bs, c, scale=None)
```

`scale=None` 使用 1/sqrt(D)。无效索引、重复块、尾块、非因果模式和空行语义保留。

## 复现

```bash
source env.sh
python check_submission_nsa.py
python verify_nsa.py nsa.py --extras --output verification_release.json
python experiments/20260927/verify_round2_edges.py
python check_equiv.py nsa.py submission.py experiments/20260927_oj_fix/rejected_nsa.py
python experiments/20260927_oj_fix/check_refresh.py
```

性能与边界脚本的完整参数保存在对应 JSON 的 command 字段或脚本中。

## 下一轮候选（当前 OJ 提交未替换）

已另行准备 `experiments/20260927_next/submission.py`，开发版为同目录的
`selected.py`。相对当前 OJ 版，109 例同输出缓冲区复测的几何平均加速为
1.00965x；S8 代表例 55.94→53.50us。169 项双接口正确性检查、12 次输入刷新
和 18 组设备码等价检查通过。没有类定义或异步拷贝。

该候选尚未取得 OJ 成绩；当前根目录源码及 checkpoints 均未替换。
细节和哈希见 `experiments/20260927_next/candidate_manifest.json`。
