**929 新候选：提交本目录 `submission.py` 全文。**

目标仍为 88 分。这份源码已完成本地性能、正确性和已知提交限制检查，尚无官方
OJ 成绩；最后已知官方成绩仍为 86.5。根目录、927 next、928 PV32 和 928 S8
原文件均保留原哈希，便于对照。

109 例同输入、同输出地址、四轮交替比较：相对 86.5 分源码
`../20260926/baseline.py` 的几何平均加速为 **1.07073282x**，相对
`../20260927_next/selected.py` 为 **1.03237954x**，没有超过 3% 的回退。
使用公开 `run_kernel`、CUDA graph、每图 100 调用、7 个计时样本、约 40ms
预热，计时包含每次 K/V 打包。完整数据为 `full_v2.json`。

本轮新增同步优化，均限定 G=16、threads=64，并统一由 `_get_kernel` 分派。
`grid = B * KV_heads * seq_len`：

| 路径 | 启用范围 | 改动 |
|---|---|---|
| D32 / S1 / BS16 | grid >= 1024 | 合并读取 K，再用四次 uint32 shuffle 转成 MMA 布局；V 使用线性共享布局 |
| D64 / S1 / BS16 | 1536 < grid <= 2560 | Q 先同步读入合并布局寄存器，K/V 读取后再转入共享内存；显式 QK/PV emitter 与线性 V |
| D128 / S1 / BS16 | grid <= 128 | 原 direct-K 路径的 V 共享 swizzle 宽度改为 16 |
| D128 / S1 / BS16 | 128 < grid <= 2048 | K、V 复用同一共享分配，分别采用 swizzle K 和线性 V 地址 |
| D64 / S1 / BS32、64 | grid <= 2048 | 同上，分别选择 K/V 共享地址 |
| D64 / S1 / BS16 | grid <= 256 | 原 direct-K 路径使用线性 V 共享布局 |

中型 D64 路径保留显式参数回退：需要默认共享 K/V、寄存器暂存、Q preload、
非 fragment-Q、nmax、无输出暂存及默认 min_blocks。它在 1792、2047、2048、
2049、2304、2560 等相邻规模及多个 batch/head 组合上验证过；更大网格继续原路径。

同时合入已独立验证的 928 PV32 和 S8 调度：PV32 作用于 D128/S1/BS32、
grid >= 4096；S8 在 grid >= 4096 交错 batch/head，>=8192 再用四份 PV
累加器。所有原有 GPU builder 的 AST 保持不变，只增加 builder 和形状分派。

关键收益另做了 A/B/A 长夹测：每图 500 调用、40 次试验，使用同源控制并保留
所有原始样本，筛选两侧基线漂移 <=1% 的样本。D32 五例所选路径为
**1.0835–1.1424x**，各有 35–40 个低漂移样本；中型 D64 四例为
**1.1629–1.1987x**，每例 40 个低漂移样本。同源控制约 0.999–1.001x。
数据见 `../20260929_recheck/d32_bracketed.json`、`shared_q_bracketed.json`。

验证全部通过：125 个参考用例、49 个分派边界/尾块用例，均检查两个公开接口；
49 组边界源码与原始实验源码一致，18 组常规开发/提交设备源码一致；4 个显式
调度回退、12 次 Q/K/V/索引原地刷新、6 个真实 RestrictedPython
`full_write_guard` 场景通过。完整官方 sandbox 仍由 OJ 验证。

没有异步复制、外部设备源码、类定义、函数属性写入或输入结果缓存。编译器对部分
XOR 地址可能继续给出保守的 race warning；未关闭检查。`layout_proof.json`
穷举验证 9 种共享布局的唯一写入和覆盖，以及全部 512 个 D32 shuffle 元素。
实际生成的 kernel 另经上述 GPU 参考验证。全部哈希与证据以
`release_manifest.json` 为准。

提交 SHA256：`09e9bd0441ca0746810a097106831bb6298036a11d04cfa1620ea66d17316536`。

从 NSA 目录复现：

```bash
source env.sh
python check_submission_nsa.py experiments/20260929_candidate/nsa.py experiments/20260929_candidate/submission.py
python verify_nsa.py experiments/20260929_candidate/submission.py --extras --output /tmp/nsa929_verification.json
python experiments/20260929_candidate/verify_candidate.py
python check_equiv.py experiments/20260929_candidate/nsa.py experiments/20260929_candidate/submission.py
python experiments/20260929_candidate/check_layouts.py
python experiments/20260929_candidate/audit_release.py
```

`make_candidate.py --mid-q` 可从已记录哈希的实验文件重建开发版；用
`../moe/strip_comments.py --docstrings` 生成提交版。研究工具和校验脚本不属于
提交内容。
