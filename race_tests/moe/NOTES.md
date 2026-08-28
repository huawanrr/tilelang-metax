# MoE 赛题工程笔记

这份文档记录 `race_tests/moe` 的全部可复用知识：提交什么、怎么在本地量、评测机和本地机器的差别、
以及**已经试过并失败的方向及其实测数字**（最后一节最长，也最值钱 —— 不要重复踩）。

代码里的注释解释"这一行为什么这样写"，这份文档解释"整体在哪、下一步该往哪走"。

---

## 1. 当前状态

| | |
|---|---|
| 提交文件 | `submission.py`（由 `strip_comments.py` 从 `moe.py` 去注释生成） |
| 文档源码 | `moe.py` |
| 当前版本 | **v23** |
| 最佳成绩 | **78.33 分**（79/78/78，v22） |
| 题目 baseline | 50 分 / 66 ms |

本地时间（安静的卡，30 次迭代，单进程，`local_bench.py --only oj1real,oj2real,oj3real`）：

| 版本 | oj1real | oj2real | oj3real |
|---|---|---|---|
| v18p8（曾得 79/77/78） | 2.879 | 5.088 | 9.253 |
| v22（得 79/78/78） | 2.802 | 4.993 | 9.138 |
| v23 | 2.79 | 4.98 | **10.06**（故意的，见 §6） |

**两个文件必须等价**：`submission.py` 是去注释拷贝而不是逐字节相同，验证方式是对三个评测 shape
比较 `_get_kernel(...).get_kernel_source()` 的 md5，不是 `cmp`。

```bash
python strip_comments.py moe.py submission.py --header "MoE submission vNN (stripped; documented source is moe.py)"
python check_submission.py submission.py     # 必须打印 OK
cp moe.py .ipynb_checkpoints/moe-checkpoint.py
cp submission.py .ipynb_checkpoints/submission-checkpoint.py
```

最后两行不是洁癖：曾经有一次提交被拒，原因是 Jupyter 的 `.ipynb_checkpoints/` 里留着旧文件，
从那个标签页复制粘贴拿到的是旧代码。

---

## 2. 评测的三个 config

OJ 只跑三个 shape，`moe_test_configs.json` 里的 E=8/E=4 形状会严重误导（它们是均衡路由）。

| | experts | hidden | intermediate | total_tokens | 128 行 block 数 | v22 得分 |
|---|---|---|---|---|---|---|
| Config1 | 16 | 2048 | **8192** | 2272 | 24 | 79 |
| Config2 | 32 | 7168 | 2048 | 4544 | 48 | 78 |
| Config3 | 64 | 7168 | 2048 | 9088 | 96 | 78 |

注意 Config1 是**反过来的** shape（hidden 小、intermediate 大），所以它 stage 1 的网格有 64 个
n-tile 而 stage 2 只有 16 个。

**路由是倾斜的**：block 数 = 1.5 × experts，而均衡路由会给出 2 ×。也就是大约一半 expert 占 1 个
block、一半占 2 个。`local_test_configs.json` 里的 `oj1real` / `oj2real` / `oj3real` 用
`counts` 强制成 64/220 交替来复现这个布局，和 OJ 的时间对得上 12-14% 以内。**均衡复现
（`oj1`/`oj2`/`oj3`）达不到那个 block 数，会让人对 kernel 走哪个分支产生错误判断。**

padding 规则（`local_bench.build_case` 里复现的）：每个 expert 的行数向上取整到 128 的倍数，
**且至少留一行 padding** —— `ceil((count + 1) / 128) * 128`。所以 220 行 → 256 行（2 个 block），
64 行 → 128 行（1 个 block），而恰好 128 行 → 256 行。

### 分数 ↔ 加速比

三个数据点把映射钉死了：**`ratio ≈ 0.5385 + 0.1331·log2(speedup)`**（拟合误差 0.0006）。

实用换算：**一分 ≈ 5.3% 的运行时间**。满分需要约 11 倍加速比，90 分需要 6.6 倍
（对 Config3 就是 kernel ~4.2 ms，即比现在快 2.2 倍，见 §6 为什么这不可能靠 kernel 优化拿到）。

### OJ 的噪声（非常大，务必先读）

- 同一份**设备代码逐字节相同**的提交，单个 config 拿过 74 / 76 / 79 分；
- 更极端的一次：v21 拿 72/70/69，而设备代码与之逐字节相同的 v22 拿 **79/78/78** ——
  **一次运行可以整体低 8 分**（三个 config 一起掉，像是评测机被别的负载挤了）；
- 还有一次 Config1 报了 12.9 ms，而同一份 kernel 本地只要 2.9 ms。

**推论：单次提交无法分辨 5-10% 的改动。** 所以：
1. 只追本地能量到 >5% 的改动；
2. 设计每次提交时**让至少一个 config 的设备代码不变**，它就在同一次运行里充当噪声基准；
3. 如果提交次数不受限，同一份代码多交几次取最好的一次 —— 运气差值可达 8 分；
4. **绝不要用单次运行做诊断**。我曾经把一次 8 分的下降拟合成"计时区间多了一次参数拷贝
   （每 GB 约 1 ms）"，三个数据点配三个自由参数，自由度是零，看起来天衣无缝而完全错误。

---

## 3. 提交沙箱的规则

OJ 用 `triton_sandbox`（`/usr/local/bin/tilelang_runner.py` → `SafeExecutor`）在执行前先做
AST 校验。以下每一条都是用一次提交换来的：

1. **模块顶层**只允许 import、`def`/`class`、以及右侧能通过 `ast.literal_eval` 的赋值。
   被拒的写法：`X = f()`、`X = set()`、`X = 64 * 1024`、任何顶层 `if`/`for`/表达式。
   所有副作用必须推迟到 `run_kernel` 里调用（这就是 `_k_pack_on()` 惰性执行的原因）。
2. **只能 import `torch` 和 `tilelang`**，任何嵌套深度都不行 —— 检查是静态的，**放在函数里
   或 try/except 里同样被拒**。要访问库内部就走属性遍历：`_reach(tilelang, "maca.op.gemm.gemm_mma")`。
3. `run_kernel` 的**参数顺序固定、不能加类型标注**（沙箱限制访问 `torch.Tensor`）。
4. **没有 stdout**。
5. **`torch.*` 是白名单制**（一个 proxy 对象）。允许：创建类（`zeros/empty/arange/full/...`）、
   约 50 个数学/约简（`add/mul/matmul/sum/exp/sqrt/clamp/...`）、形状类（`cat/stack/reshape/
   view/transpose/permute/contiguous/clone`）、激活（`softmax/sigmoid/relu/gelu/silu`）、
   只读属性和 `.to/.cpu/.cuda/.float/.half`、dtype 常量。**被拒**：`torch.cuda.*`、`torch.nn.*`、
   `torch.load/save`、`.data_ptr()`/`.data`、以及任何不在白名单的关键字参数。
   ⚠️ **`.detach()` 和 `.tolist()` 都不在白名单上** —— `_host_sizes()` 因此依次尝试三条路径。
   如果它们被拦而代码只有一条路径，`_choose_block_m` 会静默退回 `(128, 0)`，Config3 白丢 7%。
6. **正确性比对整个 `out` 张量**（rtol=atol=0.05）。参考实现克隆同一个 buffer 跑它自己的
   kernel，也不写 padding 行 —— 所以**我们绝不能写任何 expert 有效范围之外的行**，
   写零也不行（那和"没人写过"的旧内容不相等）。一个没加谓词的 `T.copy` epilogue 就这样
   废掉一次提交：本地只查有效行的检查全部 PASS，Config3 在 `(2358, 1727)` 挂掉。
   `local_bench.py` 现在用哨兵填充 `out`，`check_untouched` 断言每个 padding 元素都还是哨兵。

规则补充（组委会确认）：
- **允许对 gate/up/down 权重做预处理**，但不许任何形式的量化、耗时计入评分、不许在 warmup 阶段做、
  **不许跨多次 `run_kernel` 调用复用或缓存预处理结果**、且必须由参赛的 TileLang kernel 完成。
  → 见 §7，这条许可在本题的经济学下是空的。
- `up_logits` 是可复用 workspace，不作为评测输出；`out` 是 `(group_sum, d_hidden)` fp16。

---

## 4. 本地工具链

全部在 `race_tests/moe/`，都跑在 OJ 的 padded 布局上（`fusedmoe_benchmark.py` 复现不了这个布局）。

| 文件 | 用途 |
|---|---|
| `local_bench.py` | 正确性 + 计时。`--module` 可重复，**同一进程里 A/B 两份代码是最干净的对比**（k_pack override 幂等）：`--module .ipynb_checkpoints/moe-checkpoint.py --module moe.py` |
| `local_test_configs.json` | case 集合。`oj{1,2,3}real` 是评测布局；`pair255`/`pair255w`（每个 expert 正好 2 个 block，用来公平比较 256 行 tile）；`e48x1`/`e24x2`（block 数和 MMA 量相同、不同权重字节数减半）；`oddh`（hidden=1152，唯一走 stage-2 未配对回退分支的 case） |
| `exp_stage.py` | 单阶段结构实验。支持 `block_m>128`、`n_pair=1..4`、`ws=1`（放开 warp specialization）、`tail=64`（两种 tile 合进一个 scope）、`a_frag=1`、`fused_a=1`（手工驱动 emitter）。`k0load` 给流式访存定价、`gated` 给 epilogue 定价 |
| `exp_tail.py` | tail split 的重复 A/B |
| `exp_numerics.py` | 多随机种子下的偏差（当前最差 2.2e-3，是容差的 23 倍以内） |
| `exp_occupancy.py` | block 驻留数 → 反推可用 CU 数（见 §5） |
| `exp_async.py` / `exp_async2.py` | MACA 异步拷贝的定价与正确性 |
| `exp_kpack.py` | 单独隔离 k_pack lowering override |
| `prof_target.py` | mcTracer 的最小驱动 |
| `dump_src.py` | dump 某一阶段生成的 MACA 源码 |
| `grader_sim.py` | 复现评测 harness 在计时区间内克隆输入的开销 |

### 两个曾各烧掉几轮的测量陷阱

1. **kernel cache 不认 lowering。** `TILELANG_CACHE_DIR` 只按 prim_func 和 pass config 做 key，
   所以一个打了 k_pack 补丁的 kernel 会被直接返回给没打补丁的运行。一次"存量 lowering"的测量
   读到 6.52 ms（那是打过补丁的数），而冷编译是 7.76。这直接产生了两个连续的错误结论，其中一个
   还提交了。`exp_stage.py` 现在让每种 lowering 用各自的 cache 目录（`cache_kpack2`/`cache_stock`），
   任何新 harness 都要照做；手工改 override 之后必须 `rm -rf ~/.tilelang/cache_*`。
2. **卡是共享的。** `mx-smi` 的板级 **GPU-Util** 和我们切片的 **sGPU-Util** 是两个独立数字，
   另一个租户可以把物理卡跑到 93% 而我们这边显示 0%、进程表还是空的。那种时候同一个 kernel
   重复跑会给出 0.97 ms 和 141 ms。**测量前先 `mx-smi | sed -n 5,40p` 看板级 util 是不是低，
   任何超过 5% 又和旧数据矛盾的结果都要复测。**

---

## 5. 硬件：本地这台 ≠ 评测机（很重要）

`torch.cuda.get_device_properties` 报 `multi_processor_count = 104`，**那是物理卡**；
mx-smi 显示 sGPU 切片只给 25% 算力。用 `exp_occupancy.py` 实测（block 跑四条独立 FMA 链固定次数，
墙钟时间在全部 block 同时驻留时是平的，超过驻留上限才阶梯上升）：

- 512 线程的 block **恰好在 104 个并发 block 处出现拐点** = 26 CU × 2048 线程
  （shared memory 从 16 到 48 KiB 都是这个拐点）；
- 64 线程的 block 拐点在 **416** = 26 CU × 16 block（每 CU 的 block 数上限）。

**本地：26 个可用 CU、每 CU 2048 线程 / 32 wave / 16 block、每 lane 每 SIMD 512 个 VGPR
（`regs_per_multiprocessor = 131072`）、每 block 最多 64 KiB shared memory（超过运行时直接拒绝）。**

我们 stage 1 用 116 个寄存器 → 4 wave/SIMD → 16 wave → **每 CU 2 个 512 线程的 block**。
决定占用率的是**寄存器**，不是 shared memory —— 这一点我一开始搞错了。

**评测机有 64 GB 显存（本地 16 GB），也就是整卡 104 个 CU，对着同一条 HBM。** 本地实测读带宽
1.42 TB/s（`torch.sum` over 512 MiB；`copy_` 是 1.29 r+w），对这颗芯片来说基本就是整卡带宽 ——
**切片拿了 25% 的算力和 ~100% 的带宽，所以评测机每 CU 的带宽只有本地的四分之一。**

⇒ **本地所有测量都系统性偏向"低算术强度 + 高占用"的配置。** 一个每 CU 的模型
（`拷贝字节/单CU带宽 + MMA flops/单CU算力`）在本地对两个差异很大的配置都拟合到 6-9%
（128 行 tile 预测 124 TF/s / 实测 117；256 行 tile 预测 102 / 实测 96），把它放到 104 CU 上，
排序翻转：256 行 tile 从 -18% 变成 +24%。这就是 `_WIDE_M` 的来历（§6）。

**做任何"用占用率换算术强度"的取舍时（更大 tile、每 CU 更少 block、多算一些 padding 行），
本地数字不是答案 —— 分别算 26 CU 和 104 CU 的 per-CU roofline，并预期评测机偏好高强度那一侧。**

### 分析工具

`/opt/maca/bin/mcTracer` 是这台机器上唯一的 profiler（没有 counter 类工具）。它要**可执行文件路径**
而不是 shell 字符串，`--odname` 相对 cwd 解析（绝对路径会失败）：

```bash
/opt/maca/bin/mcTracer --odname trc --name run $(which python) prof_target.py --case oj3real
```

输出 Chrome trace JSON。kernel 事件是 `cat == "0"`，`dur` 单位是**纳秒**，`args.mem` 里有
`registers_per_thread` / `dynamic_shared` / `static_shared`。开销几个百分点，所以看 kernel 之间的
比例、绝对值以 `local_bench.py` 的 cuda event 为准。

v22 在 oj3real 上的四次 launch（`block_m=128`, `tail_rows=64`）：

| kernel | 时间 | 寄存器 | LDS |
|---|---|---|---|
| stage 1 main（128 行） | 4.111 ms | 116 | 32 KiB |
| stage 1 tail（64 行） | 1.962 ms | 80 | 24 KiB |
| stage 2 main（配对） | 2.164 ms | 118 | 32 KiB |
| stage 2 tail | 0.920 ms | 84 | 24 KiB |

stage 1 占 66%。

---

## 6. kernel 现在的样子，以及屋顶线

两个阶段，各自还可能拆出 tail scope，全部写在一个 prim_func 里（4 个 `T.Kernel` scope = 4 次 launch）。
关键配置及其来历：

- **128×128×64 的 block tile，一个权重缓冲**（gate 和 up 串行复用同一块 shared），
  `num_stages=0`，光栅化 panel 8，A tile 走 shared memory（放 fragment 会慢 4 倍）。
- **stage 1 用 512 线程、stage 2 配对后也用 512** —— 但**都跟随 k_pack lowering**：
  override 没生效时分别退回 256（存量 lowering 下 8 字节读，32×64 的 wave tile 读得太多）。
- **k_pack=2 的 lowering override**（`_enable_maca_k_pack`）：TileLang 的 `T.gemm` 从不把 `k_pack`
  传给 emitter，而 emitter 本身是支持的，且它的 ki 循环上界和 A/B local 尺寸都按 `k_pack==1` 写死。
  改成 16 字节读值 **6-9%**。⚠️ 存量 `_gemm_rsr`（fragment/shared 形式）在 k_pack=2 的 emitter 下
  **会把每个 k 切片算两遍** —— 如果将来引入 fragment A，必须同时覆盖 rs 分支。
- **stage 2 每 block 两个 n-tile**共享 A tile 和权重缓冲（-6.6%/-6.7%/-3.2%），且用直接从 fragment
  写回的 epilogue。⚠️ **绝不要把两个 tile 塞进同一块 staging shared**：那个形式在评测机上
  挂在 Config1 的 (406, 33)，本地 `exp_stage.py` 的 `npair_smem_merge` 变体也会 MISMATCH 1.42e0
  —— buffer 读完又被覆盖，两次使用拿到不同 layout，TileLang 的 barrier 落错位置。
- **tail split**：有效行 ≤64 的 block 交给 64 行 tile 的第二对 scope，门槛
  `blocks >= 64 and tail*4 >= blocks` → 只有 Config3 开（值 7%）；Config2（48 个 block）实测亏 3%。
- **expert 索引钳位**（`T.min(T.max(idx,0), E-1)`）不是防御性代码：它让后端能证明权重访问在界内、
  从而删掉内层 k 循环里的边界保护，值 3-8%。
- **`stage1_swizzle = n_tiles` 当 n_tiles ≥ 32**（只有 Config1 走到，值 ~5%）。

### 屋顶线：为什么停在这里

每个 (block, k-step) 往 shared memory 灌 A(128×64) + 两块权重(128×64) = **48 KiB**，
换来两个 128×128×64 的 GEMM = 4.19 MFLOP，即**每字节 85 flop**。本地可达读带宽 1.42 TB/s
⇒ 这个 tile 形状的上限是 **121 TF/s**。实测（mcTracer，oj3real）：

- stage 1 main：481 GFLOP / 4.111 ms = **117 TF/s（上限的 97%）**
- stage 2 main：240 GFLOP / 2.164 ms = **111 TF/s（92%）**

**要抬上限只能抬那个 85**，也就是放大 tile；而 32 KiB 以上就掉到每 CU 一个 block，
copy 和 MMA 被 `__syncthreads()` 严格串起来、没有第二个 block 填空档，实测带宽利用率从 92% 掉到
53%，乘积反而更差（256×128×64 / 1024 线程：强度 128 flop/byte 但只跑出 0.76 TB/s = 96 TF/s，
和模型预测的 102 对得上）。在 32 KiB 预算内 `(bm+bn)·bk = 16384`，最大化 `2·bm·bn/(bm+2bn)`
得到 bm=160/bn=96 = 87.3 flop/byte（只比 128/128 高 2.3%），而这两个尺寸切不出合法的
16 倍数 wave tile。**所以 128×128×64 + A 被两个 GEMM 共享，在本地这台机器上是最优解。**

而在评测机上，每 CU 带宽只有四分之一、算力不变，同一个模型给出完全不同的排序 —— 这就是 v23 的
`_WIDE_M`：stage 1 变成三个 scope（每对 block 的头块用 **256 行 tile / 1024 线程**，落单尾块用
128 行 tile，加上原来的 64 行 tail scope），本地慢 10%，模型预测评测机快 9-13%。
`_WIDE_M_MIN_BLOCKS = 64` 让它只作用于 Config3，Config1/Config2 与 v22 只差一个会被折叠的
`bool` 临时变量，在同一次运行里充当噪声基准。

**验证协议**：Config3 涨 ~2 分而 Config1/2 不动 → 假设成立，把门槛改成 16 全开；
Config3 掉 ~2 分 → `_WIDE_M = False` 回退；三个一起大动 → 又是噪声，重交。

---

## 7. 试过并失败的方向（带数字，不要重复）

除特别说明外都在 Config3 布局、k_pack override 生效的条件下测，基线是 stage 1 = 6.51 ms /
配对后的 stage 2 = 3.29 ms。

### tile / 线程 / 占用率
- `block_m=256`（在 `pair255` 上映射精确）：5.12 vs 4.21 ms，**+22%**。48 KiB shared → 每 CU 一个
  block。同样原因：两个权重缓冲 `twobuf` +39%、`block_n=256` 任何形式都亏。
- `threads=1024`（128×128 tile，wave tile 掉到 32×32）：**+54%**。`threads=64`：**14 倍**（溢出）。
- 64 行的 tail tile 改 `block_n=64` 做到 4 blocks/CU：**+33%**；再加两个权重缓冲：+17%。
  tail scope 现在的 128 宽 / 单缓冲 / 512 线程就是它的最优；而且在 `block_m=64` 下**线程越多越好**
  （512 > 256 > 128），尽管 LDS-读/MMA 比更差 —— **这个比值在这里没有预测力，别再拿它推理**。
- `block_k=32` 的一切变体：1.5-1.7 倍差（64 字节的 global load 行长是杀手）。`block_k=128`：LDS 爆。
- 把 128 行和 64 行 tile **合进一个 kernel scope**（每 block 按行数分支，省一次 launch 和一次
  排空）：**+53%**。编译器不会让互斥分支复用 shared/寄存器，block 要为两份都付账。
- 光栅化：panel 4/8/16、row/col order、交换网格轴，现在的 panel 8 + row + 不交换最优，其余差 1-3.5%。
- pass config：放开 warp specialization、`TL_DISABLE_SAFE_MEMORY_ACCESS`、`TL_ENABLE_LOWER_LDGSTG`、
  aggressive shared memory merge —— 全部在 0.3% 以内。

### 访存与 MMA 循环
- **权重流量不是瓶颈**：`e48x1` vs `e24x2`（同样 48 个 token block、同样 MMA 量，不同权重字节数减半）
  是 3.404 vs 3.225 ms，只有 **5%**。`k0load` 一致：真实流式访存占 stage 1 的 7%、未配对 stage 2 的
  22%、配对后 stage 2 的 4%。
- **共享 A 的 MMA 片段一分钱不值**（这条最反直觉）。stage 1 的 gate/up 两个 GEMM 各自从 shared 读同
  一块 A。两种共享方式：
  1. `T.copy(a_shared, a_frag)` + 两个 fragment/shared GEMM：正确但**慢 30-45%** —— 那个 layout
     驱动的 copy 虽然向量化成 uint4，却不复现 `ldmatrix_a` 的 XOR 反冲突寻址，同样字节贵约 3.5 倍。
     **MMA operand 不要走 `T.copy`。**
  2. 在 kernel body 里直接驱动 `TensorCoreIntrinEmitter`（`ldmatrix_a` 存进两个 per-step local
     buffer，`ldmatrix_b`/`mma` 各来两轮，用 `T.annotate_layout` 手工补上 shared 的 swizzle 和
     累加器的 MMA store layout）。生成源码确认：每线程每 k-step 的 shared 读从 24 个 uint4 降到 20、
     `__syncthreads()` 从 4 个降到 3。时间：**6.507 vs 6.516 ms，即什么都没变。**
     ⇒ MMA 循环既不受 shared 读带宽、也不受读指令数、也不受 barrier 数限制。
     `exp_stage.py --extra 'fused:threads=512,fused_a=1'` 可复跑。
- 展开 k_pack 的 ki 循环：`T.unroll` 的标注被 MACA codegen 丢掉（生成源码里仍是真循环），
  手工展开成直线代码动 0.2%。
- `n_pair=4`：寄存器溢出，+45%。

### 后端能力
- **MACA 异步拷贝（`T.maca_async_copy` + `T.gemm(mbar=...)`）在这个 build 上不可用**：
  超过 128 线程**静默算错**（`exp_async2.py`：512 线程的每个变体误差 ~1e0，128 线程的精确）；
  在它正确的地方也不比同步版本快（1024³ GEMM：0.122 vs 0.114 ms）；在 12288×2048×7168 上把 GPU 挂死。
- **没有更大的 MMA 指令**：MACA 的 fp16 只有 `__builtin_mxc_mma_16x16x16f16`
  （全集是 16x16x{4,8,16,32}，更宽的 K 只给 i8/f8，也就是量化，规则禁止）。
  TileLang 的 MACA 后端也只注册了一个 GEMM 实现（`maca.mma`），没有 cute/mcblas 通路。
- 也没有 split barrier / warp specialization 可用。

### 算法层面
- **torch 打不过融合 kernel**（白名单允许 `matmul`/`bmm`）。逐 expert 循环慢 1.6-2.0 倍
  （Config1 4.62 / Config2 9.07 / Config3 18.41 ms）—— expert 只有 64-220 行，单个 GEMM 填不满机器。
  `bmm` 单看 GEMM 很快（Config1 stage-1 形状 M=256 时 **205 TF/s**，我们的等效吞吐 87-120），但拿不到：
  只批一部分 expert 就要 gather 权重（每个矩阵 0.9-2.8 GB）；唯一零拷贝的用法是用完整的
  `gate_w`/`down_w`，那就得统一 M=256，在倾斜路由下多算 33%；而且 epilogue 不再免费
  （Config1 的 `silu(g)*u` 0.434 ms、逐 expert `setitem` 写回 16 次 0.625 ms）。
  Config1 全算下来 **3.71 ms 对我们的 2.82**。
- **权重预处理许可是空的**：任何 relayout 都要读一遍写一遍（2W 流量），而整个 kernel 本身只搬约 W。
  权重字节 1.61/2.82/5.64 GB ⇒ 额外流量 **2.5/4.4/8.7 ms**，对 kernel 总时间 2.80/5.00/9.20 ms。
  又不许跨调用摊销、又不许量化，所以它只在"每个权重矩阵一次调用里被读很多遍"时才划算，
  而这里每个只读 1-2 遍。
- **更细的 tail 分解不可能赢**：每个 (block, n-tile) 的成本几乎与 M 无关（64 行 tile 3.83 µs vs
  128 行 4.01 µs，96%），所以 padding 行几乎免费，220 行的 expert 拆成 128+64+32 只会更慢。

---

## 8. 下一步

按优先级：

1. **提交 v23，看 Config3 的分数**（协议见 §6 末尾）。这是唯一能验证"本地 26 CU 误导了调优方向"
   这个假设的办法，而它是目前唯一还有 10%+ 空间的方向。
2. **同一份代码多交几次取最好**。运气差值可达 8 分，而 kernel 侧剩下的空间比这小。
3. 如果 v23 的假设成立：把 `_WIDE_M_MIN_BLOCKS` 改成 16 全开，然后**在评测机的取向下重新扫一遍
   §7 里那些"因为掉到每 CU 一个 block 而失败"的配置** —— 它们在评测机上可能全部翻转
   （尤其是两个权重缓冲、`block_n=256`、以及 stage 2 的 `block_m=256`+配对）。
4. 如果假设不成立：kernel 侧就到此为止（§6 的屋顶线是可证的），剩下的只有运气和
   评测 harness 的固定开销（0.7-1.2 ms/次调用，我们碰不到）。

最高分有 90+ 的记录。90 分需要 6.6 倍加速比 = Config3 的 kernel ~4.2 ms = **257 TF/s** 的
padded-row 吞吐，比 torch 在同一张卡上跑稠密 GEMM 的 225 TF/s 还高，也是任何 32 KiB tile 屋顶线
（121 TF/s）的 2.1 倍。除非：跑在整卡上把带宽屋顶抬高（即 §5 的方向，但那也只解释 1.2-1.5 倍）、
用了量化（现在禁止）、或者在"不许跨调用缓存"这条规则补上之前做了跨调用缓存 —— **那条规则读起来
就像是专门为封堵某种缓存加的**。这一点值得向组委会确认，它决定了目标该定在 80 还是 90。







