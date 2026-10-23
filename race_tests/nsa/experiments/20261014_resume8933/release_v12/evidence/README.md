# 2026-10-14 继续 NSA 89.33 目标

恢复会话 `01a13811-9ec2-79a1-b8d5-fd0e7906c1ba`。正式基线仍是
`../20261013_mfma_fix/submission.py`，已确认 88.93 分。
上午的 v11 最终候选为 `../20261014_goal8933/candidate_v11_final_submission.py`，
SHA256 `fc2d1f22d6bf769e7ef72c8c346ac586fbe85c2009bf171366dc8c883873d32e`。
其上午验证已通过；接续时补完 `finalize_v11.py`，现已封存为 `release_v11`。

本目录以 v11 为研究对照，不覆盖正式基线和上午的证据。
先研究 BS32 共同缓冲区路径的 K 逐片读取和 Q 连续读取宽度。
减少同时存活的 K 寄存器，观察是否能改善 v11 的 86-register attention。
每个 K 元素仍从本次调用打包的输入读取，所有乘积保留。
GPU 工作串行，计时包含全部打包和注意力 kernel，并使用同源控制及独立 FP32 参考。

本地结果不代表正式 89.33 已达到。

## 接续结果

- 补完上午的 `finalize_v11.py`，冻结 `../20261014_goal8933/release_v11`。
  文件与上午最终验证的候选逐字节相同，1,156 项哈希核验通过。
  `v11_checked_summary.json` 修正冷测改动 OJ 的范围标签：四形状，排除未改变的 OJ13。
- `bs32_stream_screen.json`：Q 读取 4/8/16 half、K 驻留 32/64/128 列及提前 V 读取。
  所有候选通过参考，但 OJ6 两种子均回退；Q8 整块在 case69 约 0.4%–0.7% 的小信号
  未抵消 OJ6 回退，均不采用。`bs32_h2_c1` 未进入共同缓冲区路径，是不变代码对照。
- S8 新探针只改变默认 packed mathcast builder；原始块号的 unsigned 边界条件
  经 307,442 个 CPU 组合证明，掩码后置仍保留所有有效元素及因果/尾部规则。
  生成器初版把外层 prefetch 分支误识别为计算分支，触发断言；改为匹配直接 QK 循环后生成。
- `s8_raw_guards_screen.json`：unsigned 块号条件在 OJ12 两种子为约 0.995/0.992×；
  指数后掩码约持平。B2/T2048/H1 的约 0.8% 信号没有推广到多头或 grid8192，均未采用。
- `s8_direct_screen.json`：去掉打包的四种直接 K/V 或 shared V 路径全部通过参考，
  OJ12 两种子仅约 0.38–0.71×，均未采用。保留所有输入边界和 RAW/WAR wave 同步。
- `exp_polynomial_screen.json`：三阶/四阶 exp2 近似在 1,048,577 个 CPU 小数样本上
  的最大相对误差为 1.8806844e-4 / 7.326485e-6。七个 OJ 形状、两种子参考检查
  使用原 `atol=rtol=1e-2`，全部通过，但所有设备计时均回退，未采用。
- `bs32_padding_screen.json`：共同 K/V 缓冲区每平面加 128/256/512 字节，
  8,192 个 payload 元素经 CPU 双射与不重叠证明。所有计时通过参考；OJ6 两种子
  均回退约 0.3%–0.9%，相邻形状也无稳定收益。零填充只用于索引展平的同布局对照。
  padding 不读写，每次调用重新打包所有实际数据；没有采用这些变体。

## Python 调用转发研究

`make_host_call.py` 生成 `host_direct.py` 和 `host_all.py`。前者仅在公开入口
构建/缓存 compiled callable 时选取 `JITKernel.torch_function`；普通闭包保留原调用。
后者也将两种 packed runner 的两个调用改为 `.torch_function(...)`。
它与本地 `JITKernel.__call__` 实际调用的函数相同，仍经过 adapter 的完整参数检查，
没有使用 `adapter.executable` 或 `skip_tensor_validation`，每次仍转换 int32/连续索引。
所有设备 builder 和 `_get_kernel` 的 AST 保持；闭包仍捕获原 `pack`/`attention`，
可由已有审计工具检查实际编译设备源码。候选尚未采用。

实际公开调用筛查见 `host_public_screen.json`；进程固定一个可用 CPU，A/B/A
交替顺序，同时记录 CUDA event span 和同步墙钟。这个计时包含 Python 提交间隙，
与 GPU graph 或官方未知的计时方式分别解释。

`host_public_screen.json` 的短窗口在小算子上有明显同源噪声；没有只取正值。
`host_public_long.json` 将每轮延长至 2,400 次，四个小 OJ 形状、两个种子的
`host_direct` 未过滤几何平均为 1.05389871×，同源对照 0.99907763×。
`host_inline_screen.json` 保留原 dtype/连续性转换，只将函数体内联到两种公开接口；
6 个形状 × 2 seeds 的 12 组设备源码均一致，全部计时见原 JSON。
`host_direct_fast_cpu.json` / `host_inline_fast_cpu.json` 各验证 235 配置、12,690 次
公开请求，旧版 JIT wrapper/adapter 各 11,016 次，候选 adapter 仍 11,016 次、
额外 wrapper 为零，另外保留普通闭包及显式调参路径。

## 新发现的旧回退路径错误

`host_inline_validation.json` 是未完成的失败检查点，不能当作通过：
新加的 B2/T37/H2/S4 非因果、零 scale 在旧 `native_sparse_attention_online_emitter`
路径失败。`irregular_scale_probe.json` 用完全相同输入证实 v11 和 host 候选逐位相同：
零 scale 最大误差 0.944580078125，负 scale 为 2.5799460411071777；
None/0.1 都通过。原因是预先写入的 `-inf` 在零/负 scale 下不再表示零权重。

`make_candidate_v12.py` 以 host 内联候选为基础，仅给该旧 emitter 的非正 scale
增加尾部/因果显式掩码。正 scale 表达式和所有分派保持，其他设备函数不变。
`verify_legacy_scale.py` 用独立 FP32 参考检查缺尾块、因果边界、极端和重复索引，
并要求正 scale 的设备源码和输出逐位保持；旧失败结果完整记录。
首轮候选和验证队列分别为 `candidate_v12_submission.py`、`run_v12_final.py`，
正式 89.33 尚待 OJ，当前仍不是已确认达标的发布版。

第一轮 `validation_v12` 在新增的受限 host 检查中失败：
RestrictedPython 的 `safer_getattr` 对不存在的 `torch_function` 返回 None，
而普通 Python 抛 AttributeError。前两组直接 JIT 路径通过，第三组 packed 闭包
因此误用了 None。32 组 scale/缓存、24 组转换、10 组参数错误和 32 次更新已通过；
整轮状态仍记为 FAIL，不把检查点误报为完整通过。

`make_candidate_v12_safe.py` 只让这两个构建时属性读取也显式处理 None，
保留普通 callable；新文件为 `candidate_v12_final_submission.py`。
设备 builder/分派相对第一轮候选完全相同。最终验证重新运行于新的独立目录。
