# 2026-10-09 接续 88.71 → 89.5

恢复会话 `01a11b3a-a78a-71b3-8bee-105f6b048339`。
正式基线仍为 `../20261008_goal895/release_v4/submission.py`，用户当前报告 88.71。
已验证的 v5 尚无正式反馈；上次中断在 v6 四片 BS32 K/V 打包候选生成之后。

本目录接续验证 `../20261008_resume8871/candidate_v6_submission.py`，SHA256
`d80a478a0d44085fc9c037c4bf500060165d0787648fb2364709319d8d8d0129`。
原候选、中型掩码负结果和冻结发布目录保持原样。

GPU 测量串行，使用 `source env.sh`。恢复时 C500 的 UUID/PCI 地址已变，
所以新收益须通过同轮基线比较，不能直接比较历史绝对时延。
独立 FP32 参考、实际公开调用、全部 kernel 启动、尾块/极端索引和当前输入语义
保持原要求；不使用异步拷贝、外部设备源码或输入/输出缓存。

初次 `v6_pack_verification.log` 在 T=1 逐位检查通过，T=15 触发运行时
`K strides[3] expected 1, but got 15`，尚未进入数值检查。正在定位原因。
这份失败记录保留，不关闭任何检查。
`stride_diagnostic.log` 确认 MetaX PyTorch 的四维 int16 CPU→GPU 拷贝会产生
channels-last 张量，旧/新 pack 均被同一 stride 检查拒绝。测试输入构造增加
`.contiguous()` 以满足既有接口契约；提交实现未改。修订测试在本目录，原脚本保留。

## 已完成的恢复与初筛

- `v6_pack_verification_v2.json` 全部通过：17 组随机 uint16 位模式逐位搬运，
  40 组边界、50 组极端索引/scale、34 项显式调参、2 组缓存调用顺序、
  28 次同地址输入更新/图回放、4 项 RestrictedPython host 检查。
  36 个路径确认 attention 设备码保持，只有相应 pack 改变。
- `v6_oj.json`：冻结 v4 / 同源控制 / 实际 v6 提交，14 形状 × seeds 0/61，
  16 轮 A/B/A，每图 300 调用，共用内存池。几何平均 **1.00952519×**。
  #1 约 1.062–1.064×，#2 约 1.060×，#6 约 1.011–1.012×。
  其他形状设备码不变。这是本地计时，未证明正式 89.5。
- `tensor_denom_screen.json`：常数一 MMA 分母在 D32 有约 2.6% 信号，
  D64 回退，中型多头有正负记录，不能全局采用。
- `wave_group_pack_screen.json`：将独立 16×64 子块按两/四 wave 合并 CTA，
  保持 wave 内共享访问、一次 wave fence。所有参考通过，但没有整体收益，
  不采用。生成器包含覆盖、唯一写入、每个共享依赖属于同一 wave 的 CPU 证明。
- `packed_tensor_denom_screen.json`：当前 S1 BS32 的常数一 MMA 分母略慢；
  S8 局部仅约 0.2%–0.4%。加下限保护后出现回退，均尚未采用。
- `small_denom_floor_screen.json`：raw FP32 分母 floor 无普遍收益；
  D32 常数一 MMA + floor 多数改善，B2/T32 的 seed0 有负记录。
  D64/D128 不采用。进一步检查完整 D32 家族。
- `unsigned_guard_screen.json`：局部 uint32 比较（地址变量仍为 int32）编译与
  参考通过；含局部已证明 `T.assume` 的版本仍有约 4%–8% 的中大网格回退，
  不采用。所有 int32 块号的谓词等价性已由 Z3 证明，范围/数据竞争检查未关闭。

`research_progress.json` 由 `summarize_research.py` 汇总，保留未过滤样本和所有
负记录。`pair_ilp_*` 只发射每条查询自己的 QK/PV，不计算查询之间的交叉项，
K/V 每次调用仍重新打包。

## 家族确认与排除（本轮接续）

- `pair_ilp_screen.json` 的四个形状全部通过参考，但全部回退。#6 基线约
  67.7 μs，单查询 streaming 控制约 81.5 μs，两查询交错约 91.8–105.4 μs。
  不采用。`pair_ilp_resources_oj6.json` 列出相同源码的所有缓存条目，不能从
  多个条目中任选一个当作实际运行二进制；静态 shared ELF 字段也不等于
  实际动态共享内存大小。
- `d32_denom_family.json` 完成 62 形状 × seeds 0/61/2026，共 186 条记录。
  168 条改变设备源码，含不同 B/H、因果/非因果、grid192 和未改变的 grid256
  边界控制。before 和 floor 在改动范围分别为 **1.023877× / 1.023975×**，
  但仅 123/168 与 124/168 提升。floor 最差为 **0.896626×**；B2/T16、
  H3 和非因果配置存在多次反例，不能凭平均值或 #1 的局部收益合入。
- `d32_denom_cold_seed0.json` / `d32_denom_cold_seed61.json` 再检查 16 个
  代表形状（包含热测负例），每次调用前冲刷 256 MB、六轮各 48 次调用。
  floor 相对 v6 的总体几何平均为 **1.010009× / 1.016174×**；同源控制为
  0.997163× / 1.002481×。两种子都复现非因果 B2/T16、因果 B1/T32 和
  非因果 H2/T48 的回退；H2/T48 的 seed61 为 **0.9315×**。**不合入此优化。**
- `d32_negative_resources.json` 显示 B2/T16 的寄存器计数 34→32，private
  均为零，却仍存在性能回退；不能将寄存器减少直接解释为收益。#1 的计数
  保持 34。两个报告只列缓存源码匹配项，不代替实际 JIT adapter 路径审计。

本轮最终保留 v6。`run_v6_final.py` 顺序补做实际提交文件的 125 例双接口
参考、109 例全量计时、当前设备冷缓存和设备源码审计；运行记录为
`v6_final_runs.json`。验证结束前不将研究目录标记为冻结发布。
