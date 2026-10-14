# NSA 输出线程重排研究（2026-10-03）

基线为 D128 v1，两个 reference 文件均保持其原 SHA256。
最终本地候选见 `../20261003_d32_output_v1/submission.py`，正式得分仍待OJ。

采用：默认S1/D32/BS16/G16/64线程且grid≥8192，组合原始块号检查与四次uint32输出shuffle。
30形状/90组合全部加速，平均1.04442824×；完整全量结果在候选目录。
原型修改过六个D32函数，发布只新增一个builder，较小网格继续使用父版。

未采用的方案和负结果：

- `screen.json`：替换原合并输出的shared暂存，D64/D128明显回退，S8也略慢。
- `d32_screen.json`：D32小中网格回退；额外寄存器/线程位交换的full4/full8没有稳定优势。
- `mid_screen.json`：中型D64直接输出重排，整体1.001393×且不同形状方向不一致。
- `guard_screen.json`：区分output-only、guard-only和组合；guard-only仍混合。
  非因果B1/T8192的组合初筛0.995911×，后续三种子夹测均加速，两者都保留。
- `lane_multiseed.json`：36形状×3种子×24次A/B/A，保留全部原始、接受、拒绝样本。
  4096与6144低网格负结果用于限制范围，没有按具体用例编号分派。
- `extreme_probe.json`：原版、仅输出版、组合版各6组极端索引均通过；没有复现原版溢出。

所有计时包含公开run_kernel和完整启动，输入/输出地址共用，TF32关闭，GPU实验串行，
CUDA graph只使用单个MACA ExternalStream。没有关闭安全检查或改后端。
`experiment_summary.json`汇总全部报告、负结果、过滤前后统计；资源报告仅用于解释，
没有将寄存器数减少直接当作速度收益。候选的commands.sh可在新目录复现最终验证。

本目录封存后请另建目录研究，文件哈希见study_manifest.json。
