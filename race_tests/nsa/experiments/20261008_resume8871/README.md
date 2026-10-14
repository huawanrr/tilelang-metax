# 2026-10-08 接续 88.71，目标 89.5

恢复会话 `01a1192d-b12c-74f3-a9d0-93dd13996df9`。
正式基线为冻结 v4：`../20261008_goal895/release_v4/submission.py`，
同版观测 88.57 / 88.71。尚无 88.71 的逐例正式分项。

`baseline.py` / `baseline_submission.py` 是 v4 的逐字节副本。
`parent.py` / `parent_submission.py` 是上次完成验证的 v5b 副本。
上次验证进程在会话中断后已完成；其发布标签为 v5。

`resumed_baseline.json` 重测 14 个 OJ 形状、seed61，A/B/A、共享图内存池，
保留同源控制和全部原始样本。v5b 仅 #1/#2 改动；#6/#9/#12 约
68.4 / 29.1 / 48.2 μs，没有新增改善。

新探针：分母保护移动到除法内、IEEE 倒数、指数截断移动到指数后、
编译器普通向量读取/半精度寄存器复制/成对 FMA 与数学优化标志。
全部是研究版本，必须先通过独立参考和稳定性能复测再发布。
不使用异步拷贝、外部设备源码、跨调用输入/输出缓存；保留 race/bounds 检查。
GPU 实验依次进行，生成和测试期间不修改已计时模块。

## 接续研究结论

可提交保底版本已经在 `../20261008_resume8857/release_v5/` 封存，
SHA256 `9a718acd3c0fee4be2195039a06e11456f2b453e3f3a265ef4c55302d7ca2541`。
它尚无正式成绩；本目录目前没有采用新探针。

- `math_screen.json`：四种数学表达、十个 OJ 形状、两个种子均通过独立
  FP32 参考。分母保护、IEEE 倒数、指数后截断均无普遍收益；小 direct
  分母保护有局部信号，须按家族和冷缓存确认。
- `compiler_runs.json`：向量 global load、半精度寄存器复制和成对 FMA
  三个编译器探针通过参考，但无可靠整体提升。两个非转发数学参数被
  mxcc 拒绝，失败日志保留。加 `-forward-unknown-to-compiler` 后在实际
  oj4 C++ 上能够生成 LLVM，但 IR 除 source filename 外与原版相同；
  转发探针尚未运行 GPU，不将其视作已测收益。
- `serial_query_runs.json`：一个 wave 顺序处理二/四个 query，邻接或跨距
  顺序共四个版本，五形状均正确但全部回退；不采用。
- `mask_screen.json`：完整块范围判断的两个简化版本，532,224 个索引
  组合的 CPU 等价证明和十条 GPU 参考检查通过。性能信号混合，无普遍
  改善；未采用。
- `joint_pack_screen.json`：K/V 各用一个 shared tile，一次 block barrier
  后按 MMA 布局连续写回。五形状均正确，256 线程版在 oj6/69/oj12 为
  1.007212× / 1.005733× / 1.004576×；小 grid1024 的 case83 为 0.988320×。
  同时读取 K/V、但 K 不转排的控制探针回退约 3%–7%。当前只保留研究
数据；新增 K 转排尚未通过家族和冷缓存确认。

`research_progress.json` 汇总上述已完成计时的全部正负记录，没有删除
失败、回退或基线漂移样本。后续小 S1 V 读取探针另见 `small_v_*`。

## 后续排除与实际二进制核对

- `small_v_screen.json`：六个小 S1 形状、两个种子；V 线性 shared、swizzle4
  shared、寄存器 vec2 shuffle 的几何平均分别 0.95706×、0.91182×、0.95859×。
  全部正确，但无可采用的稳定家族收益。
- `branchless_screen.json`：将无效块替换为安全地址、最终显式选择零输出，
  有/无 Q fence 及取余地址三个版本的八条记录全部回退。正确性检查通过。
- `flag_device_binary_audit.json` / `flag_audit_conclusion.json`：通过实际
  `JITKernel.adapter.libpath` 定位 oj2 的缓存库，再提取其中 MetaX ELF。
  半精度寄存器复制与成对 FMA 两个参数的 `.text`、`.rodata`、重定位及资源
  `.note` 与 parent 完全相同；内嵌 LLVM 去除文件名和 debug metadata 后也相同。
  因此不能把这两个参数在 oj2 上的计时波动认作指令优化。
  分母保护虽然改变了源码，LLVM 又将除法提到 select 前；只有零分母时的
  select 常数发生实质变化。第二轮 oj2/seed0 也出现回退，暂不采用。
- `boundary_mask_screen.json`：较早完整块无需逐元素 causal mask；只在
  当前边界块掩码的两个版本通过 12 条参考检查。post 版 oj13 两个种子为
  1.06487× / 1.02910×，但 oj14 为 0.98143× / 0.99315×，小 direct 也有回退。
  只保留中等 grid 的家族研究价值，未合入。
- `s8_raw_screen.log`：uint32 块号触发现有 TileLang 范围分析错误
  `Literal value -64 is negative for unsigned integer type uint32`，失败日志
  保留，未关闭任何安全 pass。后续只测有符号的原始块号版本，见
  `s8_raw_signed_screen.json`；八条记录正确，收益很小且存在负记录。
- `interleaved_bs32_screen.json`：新分配中将 K/V 每 lane 的 16-byte 输入
  放在相邻位置，两种打包方式均在 oj6 明显回退到约 100 μs，未采用。
  该探针每次调用重新打包，含所有 kernel 启动；没有跨调用数据缓存。

CLI 参数 CPU 诊断另见 `diagnostic_frontend_flags.json`、
`diagnostic_pk_cli_values.json`。默认的 fetch-on-write 已是关闭；尝试关闭
没有新增 IR 变化。保留 `-S` 未配 `-emit-llvm` 时 mxcc 拒绝的日志。

## 中型掩码与分片打包复测

`mid_boundary_family.json` 包含 27 形状 × seeds 0/61 的 54 条记录。
只在当前因果边界块进行掩码的 post 版本平均 1.014546×，40/54 提升；
grid2048 的因果组为 0.990482×，T128 因果组仅 1.003178×。
同源控制为 0.999954×。没有按单个 B/H 或 OJ 编号排除负记录。

`mid_boundary_cold.json`（seed61，8 形状）和
`mid_boundary_cold_seed0.json`（12 形状，包含热测负例及非因果）各六轮，
每次公开调用前冲刷 256 MB。oj13 对应形状分别为 1.099496× / 1.120135×；
但非因果 T256/H2 为 0.98860×，T128/B8 为 0.99570×，其他部分形状近于持平。
冷、热测量均保留，尚未把掩码 probe 直接合入。

`mid_binary_audit/report.json` 通过实际 JIT adapter 的 `libpath` 提取二进制，
不是从相同 C++ hash 的多个缓存条目中任选一个。五个代表形状 `.text` 均改变；
因果 T256/H2 和 T512/B2/H2 的 mtreg 从 40 降到 36，非因果部分为 40→38，
private memory 均为零。保存实际设备 ELF、内嵌 bitcode、LLVM 和 diff。
`.share_memory_size=0` 是静态 ELF 字段，不表示动态 shared 为零。

`tiled_pack_screen.json` 将 BS32/D128 的每个输入块拆为两个 CTA。
按 D 分半（32×64，128 threads）优于按行分半；大网格约提升 1%–1.5%，
grid1024 的 H1 用例有负结果。`tiled_pack_cold.json` 六轮也显示：
oj6 1.010660×，case69 1.014192×，case83 0.983020×。

`wave_pack_bs32_screen.json` 继续比较四个 32×32/64-thread 小块和四个
16×64/64-thread 小块。后者较优，记作 `pack_quads_w64.py`。
`wave_pack_s8_screen.json` 的三个 S8 打包变体没有稳定收益，均未采用。

`pack_tiling_family.json`：34 形状 × 两 seeds，共 68 条正确记录。
四个 16×64 小块在原 shared 打包范围内 46/48 提升，平均 **1.019702×**；
grid16384 的两个记录约为 0.99893×，完整保留。原 direct 打包范围平均
0.997679×，所以不能全局替换两个 pack builder。五种分片布局的完整覆盖、
唯一写入与线程局部索引双射证明保存在 `pack_tiling_cpu_proof.json`；
这不替代后续设备打包逐元素、尾块与输入更新检查。

`joint_shared_screen.json` 比较同时暂存 Q/K 与 Q/K/V，以及联合 post mask。
将七次 wave barrier 减到五/三次，但动态 shared 从 2 KB 增至 4/6 KB。
全部 14 条参考记录通过，中大网格却出现约 5%–18% 回退，均不采用。
XOR 写入的保守 race warning 保留，安全 pass 未关闭。

后续串行驱动 `run_stage_mask_pack_cold.py` 正在比较短 S4 成组暂存、
中型掩码的 uniform 距离表达与提前初始化，以及四片打包的冷缓存。
这些是独立研究源码，尚无新发布版本或正式成绩。
