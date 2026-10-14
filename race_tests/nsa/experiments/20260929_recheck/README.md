**2026-09-29 同步布局与寄存器交换实验。**

基线为固定的 `../20260927_next/selected.py`。新采纳方案已整理到
`../20260929_candidate/submission.py`；完整发布验证以该目录清单为准。
本目录保留原始研究脚本、每轮时间和失败记录，避免再次从已否定的组合开始。

`delivered.json` 在 GPU 初始空闲状态下复测 928 两份试验。PV32 的 oj6
108.901→107.545us；S8 调度的 oj12 53.166→52.509us，均约 1.013x。
这些是本地计时，不能直接视为官方分数。

本轮主要发现：

- `layouts.json`、`layout_families.json`：统一改变 QK k_pack 到 1、共享 swizzle
  到 4/16、线性布局。QK1 回退；vec16 对 D128 direct-K 有收益。一个布局
  同时服务 K/V 限制了其他形状的收益。
- `shared.json`、`v_neighbors.json`：同一共享分配分别使用 K swizzle 和 V
  线性地址。D128/BS16 中小网格及 D64/BS32、64 有收益。V bank 变体和
  V swizzle4 无一致的新增优势。`flat_control` 保留同一逻辑布局作比较。
- `shuffle_fixed.json`、`shuffle_d32.json`、`shuffle_d64.json`、
  `shuffle_d128.json`：合并读取后按 uint32 的两半精确保留 fp16 位模式，
  用同步 shuffle 交换线程归属。D32 的 K 交换有收益；D64/D128 及单独 V
  交换多数回退。初稿交换方向错误由独立参考检查捕获并修正，初稿日志为
  `shuffle.log`，后续全部采用修正后的生成器。
- `d32_combinations.json`、`d32_families.json`：D32 K 交换配合线性 V，
  >=1024 查询有稳定收益。vec16 在部分大网格略优，线性 V 在更多形状上
  表现较好，发布版统一选择线性 V。Q 的寄存器交换没有改善该组合。
- `q64.json`、`q128.json`：Q 合并读取后 shuffle 的方案不适合整体推广。
- `shared_q.json`、`shared_q_neighbors.json`、`shared_q_edges.json`：
  Q 先读入合并布局寄存器，K/V 读取后再转共享，结合显式 emitter 与线性 V，
  在 1792–2560 的 D64/BS16 网格上有明显收益。1536 附近持平，3072 及更大
  网格不稳定或回退；发布版限定 1536 < grid <= 2560。

`d32_bracketed.json` 和 `shared_q_bracketed.json` 以 A/B/A、同源控制、
每图 500 调用、40 次试验确认新路径；原始样本均保留，不只保存低漂移样本。
所有比较均使用独立 float32 稀疏参考、公开 `run_kernel` 和共用输出地址。

生成器、CUDA graph 的单流兼容处理和所有诊断只属于本地研究。没有改后端、
关闭 race 检查或使用异步复制。根目录和之前交付的版本保持原哈希。
