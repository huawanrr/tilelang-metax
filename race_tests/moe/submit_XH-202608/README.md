# XH-202608 赛题一：TileLang 融合 MoE 算子

这是可直接评审和复现的提交包。建议按下面顺序阅读：

1. `01_技术方案/技术方案.pdf`：完整设计、优化依据、正确性与性能结果。
2. `01_技术方案/技术方案PPT.pdf`：汇报版材料。
3. `02_日志与结果/`：环境、静态检查、功能、性能和官方 harness 的原始日志。
4. `03_源码与复现/`：提交源码、测试工具和 starter kit 兼容测试。

## 一键复现

在本目录执行：

```bash
bash run.sh quick   # 静态检查、设备代码等价性、三个评测 shape 的功能/性能
bash run.sh         # 上述检查 + 全部回归布局 + mcTracer + starter kit 对照
```


最短人工验证命令：

```bash
python 03_源码与复现/test/check_submission.py \
  03_源码与复现/kernel/submission.py
python 03_源码与复现/test/check_equiv.py \
  03_源码与复现/kernel/moe.py 03_源码与复现/kernel/submission.py
python 03_源码与复现/test/local_bench.py \
  --module "$PWD/03_源码与复现/kernel/submission.py" \
  --only oj1exact,oj2exact,oj3exact --iters 40 --no-torch-baseline
```

## 提交内容

### 1. 技术方案文档及 PPT

`01_技术方案/` 包含提交的 PDF，同时保留 Markdown 源文件和图表生成脚本，便于审阅和后续维护。
文档中的主要结论均能在 `02_日志与结果/` 找到对应原始输出。

### 2. 日志与结果

日志按执行顺序编号：

| 文件 | 内容 |
| --- | --- |
| `00_env.log` | Python、PyTorch、TileLang、MACA、GPU 与显存环境 |
| `01_check_submission.log` | 提交沙箱 AST / import 规则检查 |
| `02_check_equiv.log` | `moe.py` 与 `submission.py` 的三个评测 shape 设备代码等价性 |
| `03_func_test.log` | 回归布局功能测试及 padding 未写检查 |
| `04_perf_test.log` | 三个评测 shape 的 kernel 计时 |
| `05_kernel_profile.log` | mcTracer 的 scope 耗时、寄存器和 shared memory |
| `06_official_functional.log` | starter kit harness 功能测试原始输出 |
| `07_official_perf.log` | starter kit harness 下本方案性能 |
| `08_official_baseline.log` | starter kit 模板性能对照 |

> **显存条件说明**：本次实验使用的是 MetaX C500 的 16 GiB sGPU 切片（实测可用显存约 15.22 GiB），
> 未能使用题目环境中的 64 GiB 卡。starter kit 原始 full harness 在 bs=4 / bs=8 配置下会因为自身的
> `repeat` / `scatter_reduce` 临时张量额外申请约 7 GiB 而 OOM；这不是提交算子功能失败。为保证对照可复现，
> `compat/perf_slice.py` 将 batch 降到 bs=1 / bs=2，使用相同模型形状完成本方案与模板的端到端性能对比。

本机 MetaX C500 sGPU 的稳定结果为：

| 配置 | kernel 时间 | 线上得分 |
| --- | ---: | ---: |
| Config1 | 约 2.68 ms | 81.7 |
| Config2 | 约 4.73 ms | 80.7 |
| Config3 | 约 8.90 ms | 80.7 |

功能测试的有效行全部通过，padding 行保持未写；三个评测 shape 的最差绝对误差约 `2.6e-3`，评测容差为
`atol=rtol=0.05`。官方 harness 的性能日志包含 host 侧打包、权重复制和 scatter 开销，应与 `04_perf_test.log`
中的纯 kernel 时间区分阅读。

### 3. 源代码与 Notebook

`03_源码与复现/kernel/submission.py` 是提交给评测系统的文件，入口为固定签名的 `run_kernel`。
`03_源码与复现/kernel/moe.py` 是同源的完整注释版本；`03_源码与复现/test/` 提供复现评测契约的本地测试、静态检查和 profile 驱动；
`03_源码与复现/compat/` 保留 starter kit 的参考实现、适配层和可运行的显存受限对照脚本。

## 环境依赖

推荐使用与日志一致的 MetaX 环境：

| 项目 | 版本 / 要求 |
| --- | --- |
| GPU | MetaX C500，支持 MACA 后端 |
| MACA | 3.5.3.20，驱动 3.8.30 |
| Python | 3.12 |
| PyTorch | 2.8.0+metax3.5.3.9 |
| TileLang | 含 `tilelang.maca` 的 dev build |
| 额外工具 | `apache-tvm-ffi`；可选 `/opt/maca/bin/mcTracer` |

算子文件只 import `torch` 和 `tilelang`。不需要安装其他算子库。`run.sh` 会在检测到标准
`/app/tilelang-metax` dev checkout 时自动补齐 `PYTHONPATH`；若直接运行 Python 命令，请按本机
TileLang 安装方式设置环境。运行前确认 `torch.cuda.is_available()` 为真。

## 接口与语义

```text
run_kernel(stacked_expert_tokens, gate_w, up_w, down_w,
           routed_expert_weights, group_sizes, group_offsets,
           group_padded_offsets, group_idx_for_bx, out)
```

计算语义为：

```text
out[i] = routed_w[i] * (silu(x[i] @ gate_w[e].T)
                        * (x[i] @ up_w[e].T)) @ down_w[e].T
```

输入已经按 expert 分组并按 128 行对齐。算子使用两阶段 GEMM、fp32 累加、MMA shared tile swizzle、寄存器权重
暂存和可选的 64 行 tail scope。所有 padding 行都带谓词，既不参与计算也不写入 `out`。

## 复现注意事项

- 性能测试前确认板级 GPU-Util 较低；共享卡上的其他任务会显著影响计时。
- 本次没有 64 GiB 卡，全部本地结果来自 16 GiB sGPU 切片（实测 15.22 GiB）。starter kit 原始 bs=4 / bs=8
  full harness 会在 `repeat` / `scatter_reduce` 临时张量处 OOM；该错误来自 harness 的显存峰值，不代表提交算子错误。
  `compat/perf_slice.py` 使用相同模型配置的可运行 bs=1 / bs=2，对本方案和模板进行公平对照。
- `check_equiv.py` 比较生成的设备源码，而不是 Python 文件字节，因此能验证注释版和提交版真正走同一条 kernel。

