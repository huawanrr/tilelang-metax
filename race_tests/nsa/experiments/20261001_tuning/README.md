# 2026-10-01：接续 930 的 NSA 优化

恢复会话 `01a0f20e-a22a-7c91-9062-25d57edbd4e2`，以用户确认的
`experiments/20260930_candidate/submission.py`（87.07 分）为基线，目标 88。
旧文档中的 87.93 / 88.5 属于较早记录；本次以会话里的最新反馈为准。

最终合并源码在 `../20261001_final`；本目录保留实验及验证工具。
完成状态、正式性能汇总和哈希以最终目录 `release_manifest.json` 为准。
根目录、929、930 的已交付源码未改动，原哈希在 `baseline_manifest.json`。

## 采用的方案

- S1/D64/BS16：grid≥2304，Q 先按连续地址读取，经 shared 转为 MMA 布局；
  Q/K/V/O 依次复用同一 shared allocation，输出再按连续地址写回。
- S1/D128/BS16：同一方案，grid≥1280。Q vector=8，PV full width。
- S1/D128/BS32：grid≥1024，每次调用用原 930 packing kernel 重排当前 K/V，
  attention 直接从打包布局读 MMA 寄存器；Q/O 仍采用合并访存。
  两次 GPU 发射都计入测量，没有输入或结果缓存。
- 以上均限 G16/threads64 和默认调参组合，`grid = B * H * seq_len`。
  两个公开接口共用 `_get_kernel`；显式调参继续原分派。

BS16 需要七处显式 wave 同步；packed BS32 只需 Q RAW、Q/O WAR、O RAW
三处。packed 路径的 `AllReduce<SumOp,64,16,0>` 在当前 MACA header 中只做
offset32、offset16 两次 shuffle，虽传入 scratch 指针，却不读写 shared。
`check_qo_layouts.py` 记录地址双射、MMA 覆盖及 header 哈希；实际源代码的
barrier 数、共享分配大小与独立 GPU 参考由 `verify_release.py` 核验。

## 研究结果

`reproduction.json` 复现了 930_next 的 Q/O 收益：D64 长序列约
39.79→30.63μs，D128/BS16 大网格约81.31→57.01μs。

`bs16_neighbors.json`、`selected_boundaries.json` 显示 D64/grid2048 一带
收益不稳定，因此阈值保守设为2304；D128/grid1280在不同 B/H 拆分上有
约9%–17%收益。阈值外同源对照保留，未隐藏负结果。

`bs32_neighbors.json` 比较 PV64/128 和 ILP 调度。ILP 对部分单 H 用例有益，
多 H 会损失收益。`candidate_v1` / `v2` / `v3` 是阶段性收敛过程；
它们保留在原位置，`../20261001_candidate` 保留 v3 的原始对照文件。

随后补测上一会话尚未测量的 `930_next/packed_qo_pv128.py`：
`packed_qo.json` 中 oj6 从104.396→77.836μs，case69从58.850→44.564μs，
包括完整 packing 开销。BS16 上却不如上述无 packing 的 Q/O 路径。
`packed_qo_families.json` 的 BS32/grid≥1024 大部分用例有20%–36%收益；
grid512的反例约12.17→14.18μs，未启用。
`packed_boundaries.json` 进一步覆盖短序列、大 batch 和1023/1025边界。

最终 `candidate_v4.py` 合并两种路径，未采用新增 ILP 编译参数。
109例四轮交替全量比较保存在 `../20261001_final/full.json`：
全量 geomean=1.0592116074；25例源码改变，geomean=1.2848488591；
改变的用例全部加速。84例源码未变，所有用例最差比值0.99573，保留原始数据。
这些是本地结果，不能直接当作新 OJ 分数。

## 验证与环境经验

使用 `source env.sh` 的 MetaX C500 25% slice，单硬件 stream 的 CUDA graph，
相同输入和同一预分配输出，约40ms GPU预热；GPU测试依次执行。
`compare_family.py` 会在每次计时前对照独立 float32 参考，并记录源码哈希和
编译参数。`bracketed_family.py` 使用 A/B/A 及同源控制记录原始漂移。

本次运行后端为 TVM FFI。旧验证脚本用 `MaxDynamicSharedMemorySize` 字符串
查共享内存大小，会因该后端没有这条属性调用而误报。修复后读取实际 FFI
launch 的最后一个参数；TVM 的 `runtime/thread_storage_scope.h` 明确要求
dynamic-shared tag 排在最后。生成的 launch 参数、host 哈希和实际共享大小
写入最终 `release_checks.json`，没有放宽共享内存核对。

首次 host-size 核对失败时，125个双接口参考检查已经通过；修复仅涉及本地
验证工具。完整检查和复现命令见最终目录，官方完整沙箱仍以 OJ 为准。
