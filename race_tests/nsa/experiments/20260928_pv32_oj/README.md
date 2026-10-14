# 928 PV32：供用户在 OJ 实测的独立试验版

**提交本目录 `submission.py` 全文。** 它是今天新增的性能实验；对照版本为
`../20260927_next/submission.py`（927 next 性能优化 + 928 沙箱修复）。
用户希望到 OJ 验证本地微小收益，所以将实验整理为单文件。此举不代表本地
性能已确认，当前总目标为 88 分，尚无该试验版的 OJ 结果。

## 真正修改了什么

仅在 S=1、D=128、block_size=32、G=16、threads=64、B*H*seq_len>=4096，
且原调度使用 late_normalize、未启用 kv_split 时，改用 PV32 kernel。
oj6（B8/T1024）及本地 case69/70 属于这个范围。分派只依赖形状与已有调度参数。

原路径一次计算 128 列 PV，再归一化并写回。本试验先归一化概率，在同一个
CTA 内计算、写回四个 32 列 PV 结果，复用较小累加器。QK 仍只计算一次，
没有增加 kernel 发射或临时全局张量。生成代码中的输出累加数组由每线程
32 个 float 缩为 8 个，V MMA 临时数组由 32 个 half 缩为 8 个；不把它当成
机器码寄存器数或占用率测量。

其他形状沿用 next 版；S8 的 K/V 打包、同步预载、输入刷新逻辑保持不变。
没有类定义、函数属性写入、异步拷贝、外部设备源码或 race 检查禁用。

## 为什么值得测但还不能称为提速版

前一轮 A/B/A 加长测量中，PV32 中位加速比为 oj6 1.0045x、case69 1.0239x、
case70 1.0185x。同源对照也有偏移，64 次中只有 10–19 次候选样本满足
两侧基线漂移 <=1%；其他 GPU slice 的负载会变化。因此这些数值只是实验
依据，不是确认收益或 OJ 分数预测。原始数据在
`../20260928_output_split/pv_confirm.json`。

OJ 对照应比较同一组输入下的总分与逐点时间，特别是 #6。其余点应与 next
版接近，测量波动仍需考虑。以前的 927/next 文件保留原哈希，便于回退对照。

## 已完成验证

- `verification.json`：原有 109 例 + 16 个额外用例，两个公开接口均通过。
- `trial_checks.json`：18 个分派边界用例（4096 前后、不同 batch/H、因果与
  非因果、尾块、无效索引、非连续 int64 索引、scale=None）全部通过。
- 6 次 Q/K/V/索引原地更新，两个接口全部通过。
- 分派开启时，开发版、去注释版、原始 PV32 probe 的设备源码一致；关闭时
  与原 next 版一致。显式 late_normalize=False / kv_split=True 保留旧路径。
- 使用真实 RestrictedPython `full_write_guard` 的 4 个 host warmup 场景通过，
  覆盖新核、分派边界与旧 packed 路径。完整官方 sandbox 仍由 OJ 验证。
- 开发版/提交版的已知静态限制检查通过。其他等价检查与最终哈希见清单。

## 复现

```bash
source env.sh
python verify_nsa.py experiments/20260928_pv32_oj/submission.py --extras \
  --output /tmp/nsa_pv32_verification.json
python experiments/20260928_pv32_oj/verify_trial.py
python check_equiv.py experiments/20260928_pv32_oj/nsa.py \
  experiments/20260928_pv32_oj/submission.py
```

`make_trial.py` 从固定 SHA256 的 next 和 PV32 probe 重建开发版；
`../moe/strip_comments.py --docstrings` 生成去注释版。测试、生成和审计脚本
不属于提交内容。
