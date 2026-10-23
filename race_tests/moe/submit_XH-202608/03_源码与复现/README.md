# 源码与复现目录

本目录同时服务两个目的：提供可提交的算子文件，以及让评委在同一台 MetaX C500 上复现功能和性能结果。

## 文件定位

| 路径 | 用途 |
| --- | --- |
| `kernel/submission.py` | 唯一需要提交给评测系统的文件，包含固定签名 `run_kernel` |
| `kernel/moe.py` | 与提交文件同源的完整注释版本 |
| `test/local_bench.py` | 精确模拟评测输入布局的功能与性能测试 |
| `test/check_submission.py` | 提交沙箱静态规则检查 |
| `test/check_equiv.py` | 比较两个源码生成的 MACA 设备代码 |
| `test/run_all.sh` | 由包根目录 `run.sh` 调用的一键验证脚本 |
| `test/prof_target.py` / `trace_summary.py` | mcTracer 驱动和结果汇总 |
| `compat/` | starter kit 参考实现、适配层和显存受限对照 |

显存说明：本地实验使用 16 GiB sGPU 切片（实测约 15.22 GiB）。starter kit 原始 bs=4 / bs=8 full harness
会因其 `repeat` / `scatter_reduce` 临时张量申请约 7 GiB 而 OOM；因此 `compat/perf_slice.py` 使用相同模型
形状的 bs=1 / bs=2 完成本方案与模板的公平端到端对照。该 OOM 不代表 `submission.py` 功能失败。

## 推荐命令

从提交包根目录执行：

```bash
bash run.sh quick
```

只检查源码合规性：

```bash
python 03_源码与复现/test/check_submission.py \
  03_源码与复现/kernel/submission.py
```

只运行评测 shape：

```bash
python 03_源码与复现/test/local_bench.py \
  --module "$PWD/03_源码与复现/kernel/submission.py" \
  --only oj1exact,oj2exact,oj3exact --iters 40 --no-torch-baseline
```

测试需要 CUDA 可见的 MetaX C500、PyTorch、TileLang 和 `apache-tvm-ffi`。性能结果会受共享 GPU 上其他任务影响。
