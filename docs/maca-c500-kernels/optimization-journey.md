# 优化历程：从可运行到可解释

本文按问题和决策整理 MoE、MLA、NSA 在 MetaX C500 上的优化过程。具体版本号、命令、逐 case 数据和负结果见各自的 [MoE](engineering-notes/moe.md)、[MLA](engineering-notes/mla.md)、[NSA](engineering-notes/nsa.md) 工程笔记。

## 共同的起点：题目基线并不等于本地模板

三个赛题的官方测试形状和分布都比简单的均匀随机用例更具体。MoE 的 expert token 数呈倾斜分布，padding 规则也会影响 CTA 网格；MLA 的 batch、KV 长度和 split 数组合决定主 kernel 与 merge kernel 的相对占比；NSA 测试集则以 `S==1` 为主，但少数 `S>1` 用例会呈现完全不同的同步瓶颈。

因此第一阶段不是调参，而是还原真实输入形状、调用入口、mask/stride 语义、计分方法和设备计时方式。只有这张“真实工作负载地图”正确，后面的瓶颈分析才有意义。

## MoE：把 tile 搜索收敛为成本模型

MoE 先按两个 GEMM 阶段拆分工作，再对齐真实的 expert 行数和 padding。早期尝试过多种 tile、线程数、scope 拆分、batched GEMM、混合 kernel 与量化路径；其中不少方案理论上减少计算或搬运，但会新增 launch、降低活跃 CTA 数、增加寄存器压力，或者被 sandbox 规则拒绝。

检查 mcTracer 与生成代码后，主要瓶颈被归纳为每个 block 的 K-step 执行成本。最终采用的 128×128×64 tile 和 256 线程配置，在共享内存、累加器寄存器和 wave 布局约束下表现为稳定选择；swizzle 降低 LDS 访问成本后，瓶颈转为 global-load 延迟，于是增加权重寄存器暂存并调整展开因子。v42 本地时间相对 v39 在三个 OJ shape 都明显下降。

最后一轮的主要工作变成证明搜索空间为什么已经收敛：逐一验证替代 tile、薄块处理、scope 拆分和缓存假设。重要结果是，空 CTA 本身接近免费，额外 launch 才是拆分的代价；expert 权重的重复读取多数已由 L2 命中；在既有规则和资源约束下，继续扫参的预期收益很低。

## MLA：用分拆并行换取长上下文吞吐

MLA 的长 KV 上下文使单 CTA 计算不足以占满 104 个 SM。split-K 将 KV 切成多段，提高主 kernel 并行度，再通过独立 merge kernel 合并 attention partial。旧版 split 数偏保守，许多 shape 只有 64 个 CTA；按 batch 和 SM 数选择 split 后，大 batch 用例可以提高设备占用。

接下来通过分 shape 的 stages 和 merge 布局处理不同循环长度与 split 数。softmax 的 max 归约、分母归约也逐项被审视：在记录的输入分布与数值边界下，nmax 路径省去了跨 warp max 同步；短 KV 则用条件化的 cast-sum 修正 fp16 精度问题。最终 v3 的 31 个官方 case 正确，CUDA Graph 几何平均延迟约为旧版的 70%。

MLA 的瓶颈分析把 case 1 主 kernel 分成空 launch、输入加载、QK、softmax、partial 写入和 PV，发现 PV GEMM 在该 case 占主 kernel 约 45%。进一步把 KV 转置以改善 PV 的 B 操作数布局，单独的 GEMM 探针有收益，但生产转置 tile 的开销、barrier 与流水线重构成本更大，因此整 kernel 反而变慢。此后通过生成设备代码、资源探针和整 kernel 测试排除了 k_pack、共享内存双份布局、CTA 融合及原子 merge 等方向。

## NSA：按 S 值分开设计算法路径

NSA 的主要结构决策来自测试集：100/109 个本地 case 为 `S==1`，无需维护 online-softmax 状态，因此采用独立 single-block 路径；其余 `S>1` 才需要跨块累计。对 single-block 路径，stage_regs 将独立 global load 提前发射，合适的 `block_size==32` 路径将 Q 留在寄存器中；对 online 路径，移除每块 max、推迟分母归约，可以减少同步次数。

这一套分派必须放在所有公开入口共用的 kernel 选择逻辑中。只改工厂函数曾造成 OJ 的 `run_kernel` 入口仍执行旧路径，成绩几乎逐位不变。后续实验还通过关键路径探针发现小 D32 用例接近空 kernel 的发射底限，也通过编译器崩溃和性能回退关闭了寄存器化 KV、动态双缓冲、无效预取等路线。

2026-10 的 v15/v17 实验针对有限的 D32 路径做了小幅数学表达修改，完成 correctness、输入更新、图重放及 ELF 等价检查；但反馈没有显示官方总分提升。这个阶段的结论是：局部冷测结果可以决定是否值得继续调查，却不能替代全量评测结论。

## 跨算子的实验闭环

有效改动大多遵循同一闭环：

1. **描述具体瓶颈。** 用评测形状、launch 网格、每块工作量和 profiler 指标定位问题。
2. **提出可证伪的预测。** 例如“更大 split 数会增加活跃 CTA”“寄存器预载会让 global load 与前序计算重叠”。
3. **检查设备实现。** 生成代码、寄存器数、shared memory、barrier 和矩阵指令应符合预测。
4. **做最小 A/B。** 一次改一个因素，先验证输出，再在完整 kernel 中交错计时。
5. **回归所有入口与形状。** 尤其检查通过公开 runner 进入的实际路径，以及边界 mask 和重复调用。
6. **与对照和评测结果交叉验证。** 保留负结果；如果收益低于噪声，结论应是未证实。

## 经验边界

这些结果依赖具体的软件栈和规则。MACA 的同步拷贝、布局选择、mma emitter、原子语义以及 TileLang API 支持都可能随版本改变。升级驱动或 TileLang 后，应至少重做设备代码检查和关键 probe；旧笔记中的“关闭”结论是对当时 build 的结论，不是永久硬件定律。

评分也不是纯粹的 kernel 时间指标。MoE 记录了线上多个噪声档位，NSA 的多个局部候选没有提升最终总分，MLA 的本地几何平均与线上成绩存在评测环境差异。报告性能时应同时写明设备、软件版本、测试集、测量方式和官方反馈状态。
