# MetaX C500 上的 MoE、MLA 与 NSA 算子优化

本文整理了使用 TileLang 在 MetaX C500 上优化 MoE、MLA decoding 和 Native Sparse Attention 前向算子的实践。内容来自仓库中的实现、设备代码检查、正确性测试、CUDA Graph 基准和评测反馈。这里记录的是特定 C500 / MACA / TileLang 构建上的观察，不应直接视为其他 GPU 或版本的性能结论。

## 结果快照

下表保留原始笔记中的口径与日期。三个任务的测试集和评分规则不同，分数不能横向比较。

本仓库同时保存总览、优化历程、三份工程笔记快照，以及 `race_tests/` 下的实现、实验结果和 release 包。表内性能结果来自历史实验记录；复现时请核对对应版本、环境和发布清单。

| 算子 | 记录中的代表实现 | 已有性能证据 | 官方成绩状态 |
|---|---|---|---|
| MoE | `race_tests/moe/submission.py`，v42-regstage | 本地三个评测 shape：2.678 / 4.734 / 8.905 ms；v39 对应为 3.054 / 5.461 / 10.385 ms | 记录有多次成绩及明显评测波动；NOTES 汇总最佳单项为 81.7 / 80.7 / 80.7，平均 80.33。详见 [MoE 笔记](engineering-notes/moe.md) |
| MLA | `race_tests/mla/mla.py`，v3 | 31 个官方 case 正确；相对旧提交版 CUDA Graph 几何平均延迟为 0.70，即约 1.43× | 2026-09-28 记录的上一次用户回报为 96.5；v3 的后续提交说明记录六个 case 平均 97.0。详见 [MLA 笔记](engineering-notes/mla.md) |
| NSA | 冻结的 [v17 候选](../../race_tests/nsa/experiments/20261016_resume895/release_v17/README.md)；开发与提交入口见 `race_tests/nsa` | 多轮全量正确性、冷/热测和设备码对照；部分后期优化只针对 OJ1，不能外推到 14 个评测点 | 2026-10-17 笔记确认总分 89；89.5 未确认，v15/v17 的 OJ 无提升反馈。详见 [NSA 笔记](engineering-notes/nsa.md) |

成绩和版本会随评测反馈变化。准备复现实验或提交前，请先读各算子 NOTES 顶部的最新状态，再核对相应 release 目录、哈希清单和入口文件；不要仅凭本摘要替换提交文件。

## 可复用的工程结论

### 先看设备代码，再决定怎么优化

TileLang 源码表达的是意图，MACA emitter 最终发出的加载、存储、矩阵指令和 barrier 才决定实际代价。MoE 和 NSA 的重要突破都来自检查 `get_kernel_source()`：确认 `T.copy` 在相关路径上是同步 global-to-shared 读写，发现通过寄存器预载可增加独立内存请求；MLA 则通过设备码确认公开的 `k_pack` 参数在当前 MACA 路径没有改变 PV 的 LDS 指令。

建立假设时，至少同时检查生成代码、寄存器/共享内存资源和关键路径分段计时。若生成代码没有预期变化，或者微基准的行为无法在整 kernel 里复现，就不应把它当成优化结果。

### 先建立可信的测量，再解释微小差异

- 用 CUDA Graph 降低 Python 和 launch 噪声；固定热身、重复次数、统计口径和 GPU 负载状态。
- 变体交错或 round-robin 测量，并加入同二进制对照，识别时钟、共租户和顺序漂移。
- 为不同变体隔离编译缓存；先做正确性，再跑性能。测量代码也要验证自身没有引入热点或额外同步。
- 将 OJ 分数反解为时间，并和本地的绝对延迟对应。不同题目的 baseline、评分映射和测试分布不同，不能直接比较 speedup 或分数。
- 对低于噪声的改动保留原始数据，标成“不确定/未采纳”，不要包装成收益。

### 用资源约束缩小搜索空间

C500 相关笔记记录的硬件基线为 104 个 SM、64-lane warp、每块约 64 KiB 动态共享内存、每块 128K registers、8 MiB L2。实际可用资源还受编译器布局与调度影响。MoE 通过每个活跃 block 的 K-step 计数建立了延迟模型；NSA 结合 LDS、累加器寄存器和线程布局推导 tile 的可行域；MLA 则测得 64 KiB shared-memory 上限，并用分阶段计时锁定 PV GEMM 的热点。

这些案例共同说明：先写出 shared-memory、寄存器、CTA 数量、同步次数和 launch 数的约束，再决定搜索方向，通常比盲目扫 tile 参数有效。

### 正确性、接口和提交物都是内核的一部分

优化要覆盖实际入口和边界条件：空行/全 mask、尾块、非连续输入、scale、fp16 量化误差、拆分归并及重复调用。NSA 的一次分派错误导致正式入口没有使用新路径；MoE 的 Jupyter checkpoint 留存旧文件曾造成提交问题。开发源码和精简提交源码应通过设备源码或 ELF 等价检查，而不只比较 Python 文本。

提交前按赛题要求检查 sandbox/import 白名单、禁止 intrinsic、异步行为及缓存语义；不能仅因本地能运行就推断线上可接受。

## 算子摘要

### MoE：融合路由后的两阶段 expert GEMM

主要工作是围绕倾斜 expert token 分布构造稳定的分块策略，分别优化 gate/up 与 down 两阶段 GEMM。最终有效路径包括合适的 128×128×64 tile、256 线程、按阶段组织 scope、swizzle 布局，以及把下一步所需权重暂存寄存器以隐藏 global-load 延迟。v42 相对 v39 的本地三个 shape 分别降低约 12.3%、13.3%、14.3%。

负结果同样重要：真实路由计数和 padding 会改变实际 CTA 数；增加 launch 的尾块拆分多数得不偿失；高寄存器占用限制额外预取；int8 量化收益受误差门限和后续转换成本约束；当前规则下的多个 TileLang 结构变化未能越过 LDS/barrier 的成本墙。MoE 笔记通过资源推导和 25 个方向的复测关闭了大量 tile 搜索。

### MLA：长上下文 decode 的 split-K attention

主要优化是用 split-K 增加 CTA 并行度、按 shape 选择流水 stages、采用 nmax softmax 路径，并对短上下文条件化修正 fp16 概率求和，以及按 split 数选择 partial merge 实现。31 个官方 case 在记录中全部通过严格正确性检查，v3 本地相对旧提交版达到约 1.43× 几何平均加速。

MLA 的 PV GEMM 受 shared-memory 访问方向限制：QK 和 PV 对同一个 KV tile 需要不同方向的连续布局。尝试转置 V tile 可令 PV 读取更向量化，但转置生产成本和循环重构损失大于收益；当前版本的 `k_pack` 形参在 MACA 路径没有改变生成代码。融合 kernel 因跨 CTA store 可见性缺少可靠 fence 而无法保证正确性；原子 merge 又因标量原子成本而未获净收益。

### NSA：稀疏 attention 的两条执行路径

测试集大部分是 `S==1`，因此实现采用 single-block 快路径；少数 `S>1` 用 online 路径。代表性有效优化包括寄存器预载 Q/K/V、对合适 block size 将 Q 留在寄存器直接喂 MMA、复用 K/V shared buffer、移除每块 max 归约，并把多次分母归约推迟为一次归约。收益依赖形状，必须按配置分派。

NSA 的测量证据强调调用入口覆盖：OJ 走 `run_kernel`，仅在模板工厂中加入优化不够。后续 v15/v17 小 D32 改动展示了局部冷测改善并不自动转化为整体正式分数；是否采纳要看正式反馈和全量测量。

## 文档与代码入口

- [优化历程与实验方法](optimization-journey.md)：跨算子的阶段、代表决策和失败路线。
- [MoE 工程笔记](engineering-notes/moe.md) · [MLA 工程笔记](engineering-notes/mla.md) · [NSA 工程笔记](engineering-notes/nsa.md)：历史数据、失败方向和工具索引。原始笔记见 `race_tests/{moe,mla,nsa}/NOTES.md`。
- [MoE 提交材料包](../../race_tests/moe/submit_XH-202608/README.md)：含 kernel、测试、兼容层和报告材料。
- [NSA v17 冻结包](../../race_tests/nsa/experiments/20261016_resume895/release_v17/README.md)：含提交文件、哈希与复现命令。

`race_tests/tilelang-cuda-skills` 作为子模块保留上游来源和固定版本；需要它时可运行 `git submodule update --init --recursive race_tests/tilelang-cuda-skills`。

## 复现前检查

1. 确认使用的 TileLang、MACA 驱动/工具链、C500 型号和运行环境与记录相符。
2. 运行算子自带的 correctness / equivalence 脚本，再使用对应 benchmark；各目录 README/NOTES 记录具体命令。
3. 空闲 GPU 上进行交错重复测量，并同时保存原始日志、编译源码和变体配置。
4. 记录本地结果与官方结果的区别，不从局部用例或单次提交推算整体得分。
