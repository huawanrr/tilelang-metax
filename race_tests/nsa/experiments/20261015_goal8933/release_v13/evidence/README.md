# NSA 89.33 目标接续，2026-10-15

正式确认基线为 `../20261013_mfma_fix/submission.py`，88.93 分。
本轮先完成上一轮 v12 的汇总和封存；研究基线是该版本的逐字节副本，
SHA256 `58bc2fd7a2aeb8ea805be63cc4aefae81487bcc39c3608fb5edc8293380888f9`。
v11、v12 尚无新官方反馈，本地结果不代表达到 89.33。

## v13 最终候选

`candidate_v13.py` 完成全量回归，SHA256
`49c5e4b40ba926ef0d9d687760a520306ccde4bc82b077907a5b3568b918b2ea`。
发布入口为 `release_v13/submission.py`，由 `finalize_v13.py` 将同一字节内容与
验证、负实验和复现依赖一并封存。`final_summary.json` 为最终证据汇总。

只改变 v12 的 `native_sparse_attention_q_preload_vfirst`：一次 FP32 MMA
替代两次 lane shuffle，使用 `exp(-log(x))` 求正分母倒数，保留输出端归一化。
其余 72 个函数、模块语句、公开分派和 builder 参数/编译配置不变。
FP32 emitter 类型全部为字符串，6 个 FP32 builder 的严格类型检查通过。

最终 125 个双接口参考用例、26 个边界、30 组 scale、36 次输入更新、
235 配置/12,690 次 CPU 公开请求及额外 host/参数/缓存/转换检查通过。
19 个实际二进制配置中，只有 OJ1 的 `.text` 改变，2048→1792 字节，
寄存器 34→32；代码与筛查时的真实二进制逐字节一致。

**性能界限：**最终 14 OJ 形状 × 两种子的图计时平均 0.99986277×，
OJ1 为 0.99907016×，接近持平，不能宣称全形状热测收益。
同进程 4 个图长度 × 3 seeds 的补充测试为 1.02963945×，11 正/1 负，
热测提升幅度随运行变化。`graph_windows.json` 与初始筛查、最终负值均保留。
最终冷缓存 OJ1 两种子为 1.05377907×、1.05272861×，与之前多轮正信号一致。
因此保留为冷缓存有改善、热测收益尚不稳定的可提交候选；正式分数未知。

`make_complete_groups.py` 研究 S8 的有效性检查：从当前索引判断全部八个块
或当前预取组是否完整有效且满足因果限制，成立时消除组内重复检查和掩码。
不成立时执行原有算法。比较显式范围事实与正常推断两种形式；这些事实仅位于
运行时已验证条件内部。打包、输出、浮点计算次序和其他路径保持。

GPU 测试串行，使用实际公开入口和独立 FP32 参考，以同输入/输出的 A/B/A
图计时记录所有启动和同源控制。不会修改后端、使用异步拷贝、关闭检查或
缓存输入/输出数据。所有探针均须经过边界和实际二进制核对后才能成为候选。

## 已完成的筛查

下表均为未采用的研究结果，旧 v12 提交文件保持。完整负结果保留在原 JSON 中。

| 方向 | 结果与证据 |
| --- | --- |
| S8 完整块/预取组检查 | 六个探针参考通过，但 OJ12 约 0.960–0.994×；代码和寄存器增多。`complete_summary.json`、`complete_binary/report.json`。 |
| 上述索引判定的整数等价性 | Z3 检查全部 int32 原始索引、BS16/32/64、因果/非因果及大序列长度；见 `complete_predicate_proof.json`。这是整数逻辑证明，不是性能证据。 |
| S8 环形寄存器预取 | 六种 K/V 缓冲区组合热测均回退，约 0.947–0.964×；降低寄存器的两个版本在冷缓存也回退。`ring_summary.json`、`ring_binary/report.json`、`ring_cold_seed0.json`。 |
| 主机最后一组配置快查 | 重复参数 653→668 ns，交替参数 710→918 ns，未采用。`host_last_cpu.json`。 |
| S4 循环展开 | serial/unroll1/unroll4/full 均通过参考，平均约 0.842/0.982/0.843/0.832×；未采用。`s4_loops_summary.json`。 |
| 同步 LDG/STG 编译选项 | 两个选项组合在 OJ1/6/9/12 的实际 `.text`、标准化 LLVM、资源与编译 flags 均相同，没有进行无意义的计时。`ldgstg_summary.json`、`ldgstg_binary_r3/report.json`。 |

LDG/STG 首次生成器对裸 `@tilelang.jit` 处理失败，原生成器和失败审计日志保留。
第二次审计暴露旧工具只支持有 `libpath` 的缓存 adapter；新工具 `audit_binary.py`
对新编译的 FFI kernel 导出实际 `artifact.rt_mod`，然后提取其中的 MetaX ELF。
不重新编译设备代码，也不修改 TileLang 后端。有效结果来自第三次审计。

## 对数/指数倒数研究

`make_recip_log.py` 只替换现有十二个 builder 的 25 处倒数表达式，保留原有
分母大于零的条件、mask、归约顺序、打包、分派、同步及 checked adapter。
三个探针分别使用 `exp2(-log2(x))`、`exp(-log(x))` 和
`exp(-log2(x)*ln(2))`，均使用公开 TileLang 数学接口。

`recip_log_binary/report.json` 核对 OJ1/2/6/9/10/11/12 的实际设备指令，三者
确实改变了计算；打包部分保持。首轮 7 形状 × 2 seeds 的独立 FP32 参考及
图回放检查通过，同输入 A/B/A 热测见 `recip_log_screen.json` 和
`recip_log_summary.json`。三者未过滤平均依次为 0.993651×、1.004737×、
0.988890×；同源控制为 1.000500×。不丢弃负值或只计算提速行。

自然指数版本曾在 OJ1 和 OJ11 出现局部正信号。S4 家族/冷缓存随后出现回退，
未采用；v13 仅采用 D32 的独立组合。`recip_log_family_summary.json` 和
`recip_cold_summary.json` 保留所有 S4 正负结果。

`make_d32_log_variants.py` 检查对数倒数与 FP32 MMA、归一化时机的组合。
提前归一化的两版在三个种子上均回退，未采用。保留后置归一化的 FP32 MMA
组合初筛热测为 1.03525235×；两轮 8×96 次冷测为 1.06118688×、1.06072874×。
以 `d32_log_m1_e0.py` 的逐字节副本执行最终检查；最终热测未保持初筛幅度，
上节单独列出该限制。见 `d32_log_summary.json`、`d32_log_binary/report.json`。

`verify_recip_log_math.py` 对 GPU 数学表达式与 FP64 CPU 参考进行独立比较，
并核对表达式和生成器 AST 一致。覆盖 [1,2) 的全部 FP32 尾数、指数域 1–179
的随机尾数和端点，以及零/负分母的原有 guard，共 8,755,203 个输入。
三种数学探针均通过；自然指数形式的最大相对误差为 7.969e-6，
常用分母区间 [2^-24,2^23] 内为 2.027e-6。见 `recip_log_math.json`。

## 复现入口

使用 `source env.sh`；GPU 任务串行。以下命令中的输出目录和文件须使用新名字，
以保留已记录的实验。生成器也拒绝覆盖旧探针。

```bash
source env.sh
python experiments/20261015_goal8933/audit_binary.py \
  experiments/20261015_goal8933/baseline.py \
  experiments/20261015_goal8933/ldgstg_pred0.py \
  experiments/20261015_goal8933/ldgstg_pred1.py \
  --case-file experiments/20261015_goal8933/cases.json \
  --cases oj1,oj6,oj9,oj12 --output-dir /tmp/nsa-ldgstg-audit-new

python experiments/20261015_goal8933/verify_recip_log_math.py \
  --output /tmp/nsa-recip-log-math-new.json

python experiments/20261005_goal8929/bracketed_audited.py \
  experiments/20261015_goal8933/baseline.py \
  experiments/20261015_goal8933/control.py \
  experiments/20261015_goal8933/recip_exp_log.py \
  --case-file experiments/20261015_goal8933/s4_cases.json \
  --cases oj1,oj11,s4_b1_t128,s4_b1_t256,s4_b1_t512,s4_b1_t1024,s4_b2_t256,s4_b4_t256 \
  --seeds 0,61 --attempts 24 --repeat 240 --max-drift 0.01 --shared-pool \
  --output /tmp/nsa-recip-log-family-new.json
```

其他实验的完整命令保存在各 JSON 的 `command` 字段。官方已确认分数仍为
88.93；上述局部计时、数学检查和 v12 主机调用收益均不等于官方达到 89.33。
