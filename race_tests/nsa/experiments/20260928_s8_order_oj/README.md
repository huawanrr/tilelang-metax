# 928 S8 调度试验版

提交本目录 `submission.py` 全文。基线为固定的
`../20260927_next/submission.py`，新增的是 S8 CTA 遍历顺序与大网格 PV
累加调度。当前目标88分，尚无这份源码的官方 OJ 成绩。

## 改动范围

仅在原 packed 路径的 S=8、D=64、block_size=16、G=16、threads=64 上启用，
grid=B×KV_heads×seq_len：

| 网格 | 调度 |
|---|---|
| grid<4096 | 原 next 版 |
| 4096≤grid<8192 | 将 batch/KV-head 放在 grid.x，交错执行不同 batch/head 的同一 token |
| grid≥8192 | 同上，并使用四份独立 PV 累加器，最后合并 |

每次调用仍重新打包当前 K/V，两个公开接口、默认scale、无效/重复索引、
尾块和非因果模式保留。只新增两个 GPU builder 和 `_get_kernel` 的形状分派，
其他原函数保持 AST 不变。没有异步复制、类定义、函数属性写入或关闭 race 检查。

这份源码保留 next 的 S1 行为。另一个 `../20260928_pv32_oj/submission.py`
测试 S1 的 PV32，主要观察 #6；两份试验可分别与 next 比较。

## 性能证据

公开 run_kernel、同输入/输出地址、包括 K/V 打包，以 A/B/A 夹测48次，
每次1000调用，并加入同源控制。接受两侧基线漂移≤1%的样本：

| 形状 | 本版采用路径 | 候选/同源控制的加速比 | 低漂移样本 |
|---|---|---|---|
| oj12：B4/T1024/H1 | 交错batch | 1.03175x / 0.99882x | 41/48 |
| B8/T512/H1 | 交错batch | 1.04113x / 0.99853x | 28/48 |
| B8/T1024/H1 | 交错batch+四累加器 | 1.08885x / 0.99624x | 22/48 |

oj12 的接受样本中位基线52.985us、候选51.357us，是目前更明确的本地正信号。
其他 GPU slice 仍有负载，端点漂移筛选无法排除 B 窗口的全部干扰；这是
经验证的 OJ 试验，不将局部比值换算为官方成绩。

原始记录：`../20260928_grid_order/long_bracketed.json`。四累加器在4096网格的
oj12 不及仅交错batch，因此只在≥8192启用；较小网格保持原路径。

## 验证与复现

验证结果及源码哈希以 `release_manifest.json` 为准：125个参考用例，26个
分派阈值/回退用例（两个接口），26组边界设备源码对比，6次输入原地刷新，
4个真实 RestrictedPython full_write_guard host 检查，18组常规开发/提交源码
等价检查。完整官方沙箱与 OJ 性能仍需用户实测。

```bash
source env.sh
python verify_nsa.py experiments/20260928_s8_order_oj/submission.py --extras \
  --output /tmp/nsa_s8_order_verification.json
python experiments/20260928_s8_order_oj/verify_trial.py
python check_equiv.py experiments/20260928_s8_order_oj/nsa.py \
  experiments/20260928_s8_order_oj/submission.py
python experiments/20260928_s8_order_oj/audit_release.py
```
