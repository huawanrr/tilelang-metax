# NSA 88.93 → 89.33（2026-10-13）

用户确认 FP32 MMA 修复后当前正式成绩仍为 **88.93**，新目标 **89.33**。
本轮基线为 `../20261013_mfma_fix/submission.py`，SHA256
`71dd44e50e32a83a3758f656cf5ffcd757acae853546d69a226ec185bb18df92`。
`baseline.py` 和 `control.py` 是其逐字节副本，旧发布文件保持原样。

GPU 测试串行，使用公开 `run_kernel`、同输入/输出、共享图内存池、A/B/A 夹测，
包含每次 K/V 打包启动。保留所有原始样本与同源控制；候选先通过独立 FP32 参考。
不使用异步拷贝、外部设备源码或跨调用数据缓存，不关闭 race/bounds 检查。
所有 FP32 MMA emitter 保留普通字符串类型参数，以兼容严格 PrimExpr 接口。

首个新方向只转置 PV：交换现有 P/V 的 MMA 操作数，使输出沿 D×G 布置并直接写出。
QK 与概率布局保持，无旧转置 QK 实验的额外 shared 概率转置。
`pv_transposed_screen.json` 的五形状、两个 seeds 均通过参考，但全部回退，
约为基线速度的 0.740–0.946 倍，因此不采用。

后续检查 BS32 打包地址的整数宽度及因果边界掩码、S8 的完整有效块调度。
本目录当前为研究版本，尚无新的发布候选或正式成绩。

## 新增筛选记录

- `packed_screen.json`：BS32 地址钳制、局部已证实 assume、边界后置掩码与
  自然指数四种方案均正确，但 oj6 两种子没有一致的实质收益，未采用。
- `output_exchange_screen.json`：用 uint32 butterfly 交换输出列位，合并成
  8/16 half 写回。四组完整映射证明通过，14 个 GPU 参考组合通过。
  8-half 在中型 D64、较大 D128 有局部信号，BS32 两种子均约 0.897 倍；
  16-half 普遍回退，没有采用统一替换。
- `s8_uniform_screen.json`：与旧 K-only 预取不同，K/V 采用安全地址，QK/PV
  都无条件执行，无效概率显式置零。两种 mask 均正确，但 oj12 约慢 5%–6%，否决。
- `s8_interleave_screen.json`：只对运行时验证完整有效的 2/4 块交错 QK 步骤，
  原算法处理其他块。数学正确，oj12 没有收益，未采用。case81 走未改变路径。
- `v_lifetime_screen.json`：在当前 FP32 分母与边界掩码上重新检查 V 生命周期，
  加入“半数提前、半数延后”的新调度。没有修改读取坐标或 shared 同步。
  V 在 Q 转换之后读取：oj13 两种子约 1.050/1.052 倍；V 在 K 写 shared 后读取：
  oj4 约 1.030/1.033 倍、oj5 约 1.023/1.024 倍。大 D128 明显回退，oj9 轻微回退。
  这是待家族/冷缓存确认的局部信号，尚未发布。
- `reciprocal_screen.log` 保留了首版生成器重复 JIT 装饰器导致的构建失败，
  尚未执行参考或计时。`make_reciprocal_v1.py`、失败源码和原 manifest 保留。
  修正版 `reciprocal_v2_*` 研究显式 Newton 倒数，分别检查 1/2/3 次迭代。
  CPU 数值探针覆盖 366,592 个正正规 FP32 分母，仍需 GPU 数值与端到端验证。

评分参考以 2026-10-08 原始 OJ 报告为准，其比例为 baseline/(baseline+user)，
不采用旧两点对数拟合推算 89.33。最新已确认的正式总分仍为 88.93。
