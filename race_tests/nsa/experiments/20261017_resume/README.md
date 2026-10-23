# NSA 接续优化，2026-10-17

用户恢复会话 `01a14490-c349-79b2-88e7-0eff651509be`，反馈 v15、v17
在 OJ 均没有提升。此前已确认总分为 89，继续追求 89.5；不能用历史局部
本地提速替代正式结果。具体逐点耗时及 89 分提交文件尚待补充。

先复现 v13 与 v17 的 14 点比较。研究基线 `baseline.py` 和同源
`control.py` 是冻结 v17 的副本；`parent_v13.py` 用于跨版本比较。
历史发布包和根目录历史实现保持原样。

环境为 `source env.sh` 的 `/app/tilelang-metax`、MACA 3.5.3、C500 25% slice。
GPU 实验串行。保持双接口、当前输入语义、FP32 归约、异常索引和参数回退；
不使用异步复制、外部设备代码或跨调用张量缓存。

本轮优先寻找大路径上可复现的收益。记录全部原始时延与同源控制，
区分热图、冷缓存与正式 OJ。通过参考检查的研究探针仍不等于发布版本。

## 复现与当前筛查

`v13_v17_baseline.json` 复现了 14 个 OJ 形状；只在 OJ1、OJ3、OJ10 的
设备路径发生变化。本地分别约为 1.035 / 1.151 / 1.104 倍，但用户确认
正式成绩未提升。该初筛没有单独的 v13 同源控制，不据此推算分数。
OJ6 仍约 67 µs，OJ12 约 48 µs，当前优先研究这些大路径。

以下探针全部通过各自屏次的独立 FP32 参考和正反图回放；目前均不采用。
完整轮次、同源控制和失败/回退结果保留在对应 JSON 与日志中。

| 方向 | 结果与证据 |
| --- | --- |
| Q/O 寄存器 butterfly 交换 | 五种组合均回退，几何平均 0.674–0.903 倍；`packed_exchange_screen.json`。 |
| S8 输出 butterfly | 两种组合为 0.937 / 0.995 倍；`s8_output_screen.json`。 |
| PV 分片立即写出 | 四种组合 0.865–0.984 倍；`packed_stream_screen.json`。 |
| 显式 wave 分母归约 | OJ6 两种子均慢约 1%；`packed_sum_screen.json`。 |
| S8 用 FP16 PV 权重计算 MMA 分母 | 平均 1.00254 倍；幅度很小且改变分母舍入位置；`s8_denominator_screen.json`。 |
| 分离 Q/O shared swizzle | 四种组合，OJ6 均持平或回退；case69 的不足 1% 信号未推广；`packed_swizzle_screen.json`。 |
| 相邻块 QK/PV 短流水 | 保留原 FP32 累加顺序，完整块走快路径，边界走原路径；两个版本平均 0.98393 / 0.98240 倍；`s8_qkpv_overlap_screen.json`。 |
| 输出共享读取后显式寄存器暂存 | 分离 shared 读取和 global 写入宽度，两个版本平均 0.99922 / 0.99962 倍，无稳定收益；`output_restage_screen.json`。 |
| 单 checked adapter 发射 pack + attention | 每次独立分配 scratch，保留两次顺序 GPU 发射；图计时 1.00124 倍，普通公开调用约 1.00230–1.00785 倍，幅度不足以推荐；`multikernel_screen.json` / `multikernel_public.json`。 |
| 编译器只读 cache policy | `hitl1` / `missl1` / `misslmc` 在 OJ6/OJ12 的实际设备 `.text` 均与默认值完全相同，不重复跑 GPU；`read_cache_offline/report.json`。 |
| 小网格输出列拆 CTA | 保留 QK/分母，PV16/PV32 的 10 条记录平均 0.79333 / 0.92380 倍，分别 10/9 条回退；`tiny_pv_split_screen.json`，拒绝。 |
| FP32 正常数范围计算 exp2 后缩放 | 保留屏蔽零与下溢零，150 万个 CPU 样本正常数相对误差低于 1e-5；两版 GPU 平均 0.99470 / 0.99466 倍，无收益；`rescaled_exp2_screen.json`。 |
| 显式 packed 偏移位宽 | 32 位改写平均 1.00021 倍，64 位对照 0.99010 倍；均有半数以上形状/种子持平或回退，拒绝；`packed_offsets_screen.json`。 |

`packed_binary` 与 `sum_binary` 从实际 JIT 产物提取 ELF。显式 wave 归约
确实移除了未用到的 256 B 共享归约工作区：4352 → 4096 B；运行时报告的
每 SM 驻留上限从 15 → 16 CTA，但耗时仍回退。另一个分片版本寄存器
86 → 70 也没有提速。因此不再仅凭寄存器/驻留数字推荐候选。
驻留工具为 `audit_packed_occupancy.py`，记录在 `sum_occupancy/report.json`。

`offset_exp_binary/report.json` 核对实际 JIT 设备码：32 位偏移在 OJ6/OJ12
均与基线 `.text` 完全相同；64 位偏移在 OJ6 也相同，在 OJ12 增加了代码
和寄存器（94 → 100）。所以局部不足 0.4% 的计时变化不解释为地址优化。
exp2 缩放版本在 OJ6 增加代码和寄存器（86 → 88），实际 LLVM 中仍有
原来的下溢比较/选择/加法/乘法；编译器没有消掉预想的补偿分支。

历史上已经测过的双转置、独立查询合并、K/V 环形预取、完整 QK/PV 分阶段
等方案已交叉核对，避免把同一负结果当成新方向。本轮暂未产生 v18。

## 短窗口配对与寄存器复用

`make_window_pairs.py` 将 64/128 查询窗口的共享原子直方图、六步 wave 前缀和
和配对表生成合入既有打包发射。每次调用重新处理当前索引，计算核每个 wave
串行处理两个同块查询，确实保留 K/V 寄存器供第二个查询使用。初筛 OJ6
两版约 79.7 / 76.9 µs，对照约 67.2 µs；均正确但回退。

`mcpti_window_pairs128_attention.json` 验证每次 global load 为 135248，
相较原来 196608 减少约 31.2%；MMA 262144 和 FP32 管线指令 352256
保持不变。总指令反而从 3981312 增至 4085758。实际寄存器 86 → 126。
`window_pairs_binary/report.json` 保存实际 ELF；读取减少不等于时延降低。

后续保留两个查询的归一化权重，先做两个 QK 再做 PV，避免 K/V 同时长期
存活；寄存器降至 98，但 OJ6 仍约 77.8 µs。显式打包 lane 写入同时消除了
原探针从旧打包循环继承的静态 race 提示；没有关闭任何检查。
`window_pair_phase_times.json` 的 4 轮普通调用 profiler：基线 pack/attention
约 7.44/59.36 µs，原配对 9.28/67.08 µs，分阶段配对 9.48/68.37 µs。
此分阶段诊断与带同源对照的 A/B/A 结果一致。

`make_window_pair_records.py` 将块号、两个 token 编为一个 int64 记录，
补齐未用记录，去掉有依赖的 header 读取，并对内部 token 元数据显式取上界。
公开输入检查和原数学保持，单轮分阶段版本缩短到约 67.55 µs，仍未胜出。
`make_window_pair_shared.py` 让 Q 与输出显式使用同一共享暂存，保留全部
RAW/WAR wave 同步。实际动态共享量和驻留查询记录在
`window_pair_shared_occupancy/report.json`：串行版 8448 → 4352 B、7 → 12 CTA；
分阶段版已由编译器合并为 4352 B、15 CTA，显式复用不再改善它。

最终两形状 × 两种子的 `window_pair_shared_screen.json` 全部通过独立 FP32
参考及正反图回放，但串行/分阶段版整体仅 0.94553 / 0.98431 倍，均 4/4 回退。
这些配对版本不进入提交。CPU 调度证明、所有中间失败结果、实际设备码和
完整计时记录保留在本目录，未对负数据作筛除。

后续四查询复用（128/256 窗口）在 OJ6/case69 的平均值为
0.93795 / 0.91145 倍，见 `window_quads_pilot.json`。用 32 个 MMA 行交错
两个查询的 QK/PV，W64/W128 两版为 0.97905 / 0.97325 倍，见
`window_row_pairs_pilot.json`。这些屏次只有一个种子，不作发布依据。

`window_final_tiles_screen.json` 再比较 PV 宽度和 Q 连续读取宽度：
W32/Q4、W64/Q8、W32/Q8、分阶段/Q8 在 OJ6 两种子分别为
0.98805 / 1.00280 / 0.98737 / 0.99359 倍。W64/Q8 的小信号没有推广：
`window_bitgroups_v2_screen.json` 的 OJ6/case69 × seeds 0/61 复测平均
0.98388 倍，其中 case69 约 0.963–0.965 倍，明确回退。

`window_bitgroups_v2.py` 保留相同计算核，将配对准备改成寄存器 bitplane、
wave shuffle、popcount 和前缀和，去掉排序中的 shared 原子操作。
160 组 CPU 全 shuffle 模拟覆盖尾部、无效极端索引及因果/非因果。
GPU 四组参考和正反图回放通过，但平均仅 0.95735 倍，四组全部回退。
原生 ballot 未在此 MACA 后端实现，未修改后端或用外部调用绕过。
初稿的 uint64 比较触发范围分析错误；v2 用同位宽有符号 reinterpret
只改零比较，位操作仍为 uint64。失败源码和日志全部保留。

## 倒数广播

`reciprocal_broadcast_v2_screen.json` 比较每个 head 由一个 lane 算原始
受保护 FP32 倒数，再向另外三个 lane 广播。OJ6/OJ9/OJ12/大 S8/case59
各两种子，全部参考和回放检查通过；连续 owner 与分散 owner 的平均值
为 0.99618 / 0.99460 倍，分别 10/10 和 8/10 回退，同源控制 1.000009 倍。
均不采用。首稿的 16-thread 分支与已有 64-thread 复制布局冲突，v2 保持
原 Parallel 域再按 owner 掩码；编译失败的首稿生成器和日志保留。

上述研究模块的源码哈希与逐行未过滤统计见各 `*_manifest.json` 和
`*_summary.json`，没有生成新的提交版本，也未声称达到 89.5。

## 当前打包路径上的独立多 wave CTA

`packed_multiwave_*` 与 2026-09-26 的旧 direct/shared 多 wave 探针不同：
沿用当前 joint packed K/V，每个 wave 各算一个查询，Q/O 的共享内存所有权
和全部同步均限制在该 wave 内。没有配对表、额外启动或跨查询数据缓存。
显式布局的 CPU 双射检查及所测 GPU FP32 参考、正反图回放全部通过。

首轮 `packed_multiwave_pilot.json` 的单 wave 对照异常回退到 0.34386 倍。
`packed_multiwave_binary/report.json` 定位到三维 Parallel V 加载在 NW=1 时
生成 64 次标量读取；基线为 8 次连续向量读取。因此首稿不作为干净的调度
对照，所有结果和编译产物保留。两/四 wave、Q4/Q8 的首轮也全部回退。

`make_packed_multiwave_v2.py` 改用经过逆映射核对的显式八元素连续加载；
还在多 wave 中按原 FP32 顺序显式归约，移除多余归约 shared 工作区。
`packed_multiwave_v2_screen.json` 的 OJ6/case69 × seeds 0/61、16×240
公开调用夹测：单 wave Q4/Q8 为 0.99585 / 1.00079 倍；两/四 wave Q8
为 0.99069 / 0.97010 倍，后两者四组全部回退。同源控制 1.00035 倍。
不采用；未对这些被拒绝的探针执行完整发布回归。

`packed_multiwave_v2_binary/report.json` 补齐实际 ELF 核对：单 wave Q4
与基线 attention 都是 86 mtreg、4864 B `.text`；两/四 wave 都是
88 mtreg、4864 B `.text`，最大线程数分别 128/256。此处没有使用固定
64-thread 的旧驻留 helper 推断多 wave 的驻留上限。

## S8 索引元数据与打包融合

`make_s8_tags.py` 在原 128-thread BS16 打包 CTA 内，每个 lane 处理一个
(query, selected block)，三次 64 位 XOR shuffle OR 归并成每查询一条
int64 记录；八个 byte 保留块号、有效性及完整/边界标记。每次调用重建，
不新增 GPU 启动，原 K/V 打包布局及 FP32 数学不变。范围为既有默认
mathcast S8、seq_len≤1024，其他分派和显式调参保留。

536,940 组 CPU 索引检查与 128 组全 128-lane shuffle 模拟通过，覆盖尾部、
极端负/正索引、因果/非因果及八字节顺序。原始公开接口和全部原设备函数
AST 保持，见 `s8_tags_source_audit.json`。这不等同于完整 GPU 边界回归。

`s8_tags_screen.json` 在 OJ12/大 S8 × seeds 0/61 的参考和正反图回放通过；
compact / validated 平均 0.99266 / 0.97997 倍，均 4/4 回退，同源控制
1.000002 倍。`s8_tags_binary/report.json` 为实际 JIT 产物：两版 pack
寄存器 16→26，compact attention 仍 94，validated attention 94→100。
`s8_tags_phase_times.json` 的四轮普通公开调用 profiler 给出 pack/attention
平均值（µs）：基线 4.139/43.931，compact 4.780/43.687，validated
4.800/44.071。compact 计算仅省约 0.24 µs，准备多花约 0.64 µs；停止扩展。
这些是阶段诊断，正式性能结论仍以包含全部发射的 A/B/A 为准。

## 同地址 Q/O 搬运诊断

`probe_qo_floor.py` 单独比较完整公开 NSA、预先打包后的 attention 阶段、
四种 tile/thread 配置的 Q→O 拷贝。后者是诊断核，不计算注意力，
不是提交候选，也不把它的时间当作严格下界或可实现的 NSA 加速比。
同输入/输出地址、12 轮 A/B/A、每图 240 次调用，全部原始数据和拷贝源码
保存在 `qo_copy_diagnostic.json`。NSA 经 FP32 参考，拷贝逐位等于 Q。

| 形状 | 公开 NSA | 仅 attention | Q/O 连续拷贝范围 | Q+O 逻辑字节 |
| --- | ---: | ---: | ---: | ---: |
| OJ6 | 67.002 µs | 59.794 µs | 47.877–48.054 µs | 64 MiB |
| OJ12 | 47.915 µs | 43.795 µs | 13.497–13.842 µs | 16 MiB |

OJ6 的必要 Q/O 数据搬运成本已很重，单纯减少 K/V 加载或寄存器不能推导
可观收益；S8 的 attention 与纯 Q/O 搬运间隙更大，但间隙还包含 K/V
访问和共享转换，不能全部归为可消除的计算时间。本轮仍未产生 v18，
已确认的正式成绩仍为用户反馈的 89，89.5 目标未完成。

## MCPTI 指令计数诊断

`collect_mcpti_events.py` 通过公开 MCPTI API 读取当前实际 kernel 的计数。
`mcpti_event_catalog.json` 保存当前 SDK 的事件目录。普通 profiler 启停接口
返回成功却没有生成计数文件；直接读取接口可用，但需要逐事件读取并做运行
前后的差分，不能把原始累计值当成本轮工作量。

`mcpti_qualification.json` 对照实际发射与生成代码，验证了 OJ6/OJ12 的
pack、attention 四阶段共 28 项计数，空读增量均为零。OJ6 attention 每次
8192 个 CTA、196608 条 global load、32768 条 global store、262144 条 MMA，
均与代码一致。S8 的 30528 个有效选中块及其 244224 条 MMA 也精确吻合。

部分周期、L2 事件的差分为负，或在纯打包内核中报告非零 tensor 活跃值；
这些事件没有通过校验，不能据此推算带宽、命中率或计算利用率。
目录中的 `active_warps` 实际匹配发射 wave 数，也不能解释为平均驻留。
全部原始数据与 API 返回码保留，诊断时延不混入 A/B/A 性能结果。

### 读取窗口语义修正

`qualify_counter_windows.py` 从原 collector 派生，原工具和报告保持。
`mcpti_window_state_pack.json` 对同一个已启用事件依次执行
0/1/2/0/4/0 次打包并读取，揭示两种不同语义：

- `global_load` 是累计计数：每次差分精确为 4096×本窗口调用数，空读差分零。
- 访存及周期事件返回本次读取窗口的值，空读保留旧值。切换事件后的首次
  空读可能还是上个事件的结果，旧报告统一相减因此产生负值。
  例如打包 write sector 原值随 1/2/4 次调用为 65542/131079/262152，
  与 65536×调用数仅差少量记录开销。
- `tensor_pipe_active_cycles_s0` 在无 MMA 的 pack 中仍为非零，与普通周期
  数接近，故即使修正读取窗口，也不能解释为 tensor 利用率。
- L2 事件的单位、读写含义和物理流量尚未完成独立校准；不据原值反推
  HBM 带宽或命中率。原指令计数的 28 项核对继续有效。

这项修正针对诊断解释，不改变任何算子、GPU 计时或性能采纳结果。

## 当前 mathcast 上的 S8 宽 QK

旧 2026-09-28 的成组 QK 使用 exp2、成对概率转换和直接输出，因此在当前
native exp、标量转换和共享输出路径上复验 2/4/8 块宽 QK。
`make_s8_wide.py` / `make_s8_wide_v2.py` 保留原分母的逐块 FP32 累加顺序、
原两/四组 PV 累加器归属和最终顺序合并、索引钳制和全部边界掩码。
每次仍使用原有 pack；原函数 AST 除分派外保持，显式参数继续回退。
CPU 检查向量读映射的完整双射及全部 256 种有效槽位组合。

首稿因输出布局 lambda 与之前的循环重名在前端失败，没有有效计时。
初稿文件和 `s8_wide_pilot.log` 保留；v2 仅改为独立布局参数名。
三个 v2 模块静态提交检查通过，OJ12/大 S8 的独立 FP32 参考和正反回放通过。
`s8_wide_v2_pilot.json` 使用 seed0、12×240 公开调用夹测，全部样本保留。

| 宽度 | OJ12 基线/探针 µs | 大 S8 基线/探针 µs | 未过滤平均加速比 |
| --- | ---: | ---: | ---: |
| 2 块 | 47.820/50.039 | 89.637/91.386 | 0.96814550× |
| 4 块 | 47.834/50.858 | 89.661/95.362 | 0.94024696× |
| 8 块 | 47.832/52.399 | 89.661/95.724 | 0.92440674× |

同源控制 0.99989591×，三者均不采用。没有执行被拒绝探针的完整发布回归。
`s8_wide_v2_binary/report.json`：OJ12 attention 的 mtreg 为基线94、
2块92、4块132、8块176，均无 private memory；`.text` 从7680增至9984 B。

`mcpti_s8_wide_v2_p2_attention.json` 的已校验指令事件读取证明：每次仍为
4096 CTA、130304 条 global load、8192 条 global store、244224 条 MMA，
与基线完全相同。**源码上对无效列的宽 QK 不等于实际增加 MMA**，编译器
已消除相应死计算。总指令从2687636增加到3052244，约增加13.6%；
不再把回退错误归因为无效块的额外 MMA，也不再扩展该宽 tile 方向。

## S8 双 wave 分工流水

`s8_wave_pipeline_template.py` 将 QK/指数/分母放在 wave0，将上一组权重的
PV 放在 wave1。通过两份共享概率缓冲区交接，每个流水步所有128线程
执行 CTA 同步；组深度1/2/4，逐组读取当前 K/V，不使用异步复制。
分母逐块次序、原两/四份输出累加器的块归属及最后顺序相加均保持。
`make_s8_wave_pipeline.py` 检查每种深度、两种累加器及全部有效槽位组合，
验证环形概率缓冲区读写归属和 RAW/WAR 屏障。

三个初稿均通过静态提交、OJ12/大 S8 的 FP32 参考和正反回放；
`s8_wave_pipeline_pilot.json` 使用 seed0、12×240公开调用夹测，
未过滤的几何平均为0.85630 /0.87339 /0.89113倍，同源控制0.999897倍。
OJ12为约51.75/51.50/51.32 µs，基线48.21 µs；大 S8 为
113.13/109.26/105.36 µs，基线89.04 µs。三个初稿均不采用。

`s8_wave_pipeline_binary/report.json` 的实际 attention mtreg：
OJ12 基线94，三版68/78/56；大 S8 基线126，三版100/106/84，均无
private memory。线程数从64变成128，不能仅用每线程寄存器下降推导驻留收益。
`.text` 从基线7680/8192 B 增至9728–10496 B。

实际生成代码还复用了概率、分母和输出 shared 存储。初稿的环形交接证明
不等于最终分母/输出别名的完整同步审计；后续 `s8_wave_d4_fenced.py`
为消费者读完分母后增加显式 wave WAR 同步，再允许写入输出暂存。
`s8_wave_d4_overlay.py` 在同样同步下，将生产者 Q 的原始字节与 FP32 分母
放入消费者输出累加器所用的同线程存储，双方由不同 wave 所有。
Q 保持原 half 位型，没有新增 FP16 舍入；131072组 CPU half 配对覆盖
每个位置的全部编码。最终对照与其同步/存储修改记录在
`s8_wave_overlay_manifest.json`，不将初稿当作可发布实现。

`s8_wave_overlay_pilot.json` 完成两形状、seed0、12×240夹测，fenced / overlay
都通过 FP32 参考和正反图回放，未过滤平均为0.88916180 /0.87402987倍，
同源控制0.99996913倍。OJ12分别为51.330/53.793 µs，对照47.8 µs；
大 S8 为104.866/103.551 µs，对照89.0 µs。全部拒绝，停止扩展。
`s8_wave_overlay_binary/report.json` 显示显式复用在 OJ12 并未继续减少
寄存器（两者56）；大 S8 只从84降至80，仍不能抵消整体性能回退。
全都没有 private memory 溢出，也没有据这些数字推算驻留或带宽。

## 本轮归档

`finalize_research.py` 检查冻结来源和所有已汇总屏次的源码哈希，生成
`study_summary.json` 与 `research_manifest.json`。前者索引原始计时、
未过滤统计、实际设备资源和已校验指令计数；后者记录本目录研究文件哈希，
包括失败生成器、负计时与日志。它们是研究证据索引，不是提交发布包。

本轮没有可采纳的新候选，因此没有对负探针运行完整发布套件，未创建 v18。
用户已确认成绩仍为89，89.5目标未完成。当前 OJ 逐点计时及确切89分源码
未得到补充，不能从本地探针的结果反推正式得分。
