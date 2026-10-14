# 10.2 后续 NSA 研究

基线为 `../20261002_final/submission.py`。用户确认的正式成绩仍是 10.1 的
87.93 分；本地性能比值不代表 OJ 分数。已交付的 10.2 final 文件保持不变。

## D32 结果与候选范围

`d32_guard_family.json` 包含 33 个标准 D32 用例和 7 个扩展用例，四轮交替测量。
索引检查改写和单查询简化版在这 40 例上的几何平均分别为 1.03935×、1.04128×。
这是 D32 子集，不能当作全部 109 例的提升。

`d32_bracketed.json` 用同源控制和 40 次 A/B/A 复核 13 个形状，每图 500 次调用。
`d32_multiseed.json` 再对 20 个形状、0/61/2026 三个种子做 16 次 A/B/A，
每图 500 次调用，保存全部接受和拒绝样本。不同测量之间部分小幅收益不稳定，
不据此为单个用例设分派。

中等网格 `512 < B*H*T < 1024` 的单查询版本在 7 个形状、21 个种子组合中
均加速，范围 1.01367–1.13576×，几何平均 1.07856×。覆盖 H1/H2/H4 和非因果尾块。
全 60 组同源控制范围 0.99450–1.00292×，原始数据见报告。

`assemble_d32.py` 将改动隔离到默认调参的 S1/D32/BS16/G16/64线程路径，
当前 `d32_v1_config.json` 的范围为：

- grid≤512：沿用原 direct-K 布局与同步，仅先验证 block 编号，再形成地址。
- 512<grid<1024：单查询简化版，K 连续读取后做四次 uint32 shuffle，
  V 使用线性 shared 暂存，保留一个 wave barrier。
- H1 且 1024≤grid≤4096：沿用原 K shuffle 布局与 wave 同步，改写索引验证。
- 其他形状及非默认调参仍走 10.2 原路径。

最终可提交版本在 **`../20261002_d32_v1/submission.py`**。保留 10.2 的全部 37 个非分派函数 AST，
新增三个索引改写 builder 和一个单查询 builder。边界、极端索引、输入更新、
公开接口、编译源码等价及 host guard 验证由 `verify_d32.py` 执行。
同日晚接续已补齐 125 例双接口参考、109 例设备源码审计及 14 形状/3 种子长测，
状态和完整证据见该目录 `release_manifest.json`。109 例相对 10.1 的几何平均
加速为 1.02077411×，相对 10.2 final 为 1.01424492×。后续未采用的补测见
`../20261002_finish/README.md`。新版正式得分仍待 OJ。

## 未采用的路线

- `make_d32_query_ilp.py` 的单 wave 处理 2/4 个查询普遍回退。
  初始单查询版本也受 int64 地址和逐列 causal mask 影响。v2 改为块编号验证、
  完整块清零 scores、单查询合并 valid 分支，且保留原归一化后再 cast 的顺序。
- `index_guards_simple.py` / `index_guards_all.py` 改写多个维度，仅用于诊断。
  不可直接提交：D64/D128 路径有严重回退，case14 约 7.43→11.45 μs，
  case59 约 56.76→114.60 μs。
- 缓存 ELF 资源确认 case14 的 private memory 从 0 增至 68，case59 从 0 增至 132。
  D32 case97 的通用改写也从 0 增至 20，而单查询版为 0。
  具体编译器根因尚未确认；不能把寄存器生存期或 SROA 猜测当成结论。
- `make_guard_staging.py` 的显式展开全局加载、shared 写入及两者组合，
  均未消除 D64/D128 的 private memory 或性能回退。六个代表用例参考正确。
- 更大网格及多头 shuffle 路径的收益在不同实验中不一致，当前保留基线。
  grid6144 的新扩展形状有收益，但尚未据此扩大候选范围。

资源工具 `../20261001_next/inspect_resources.py` 只读取缓存 ELF，保留全部同 C++ hash
的记录，避免忽略不同编译参数。未修改后端、未关闭 race/bounds 检查、未采用异步拷贝。

所有测量命令保存在对应 JSON 的 `command` 字段。GPU 实验串行执行，先 `source env.sh`，
每个进程只创建一个 MACA ExternalStream。`compare_family.py` 用种子 0，原
`bracketed_family.py` 用种子 61；`bracketed_multiseed.py` 显式记录每组种子。
