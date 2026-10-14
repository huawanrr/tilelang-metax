# NSA v10 FP32 MMA 兼容性修复（2026-10-13）

提交本目录 [submission.py](submission.py) 全文。
SHA256：`71dd44e50e32a83a3758f656cf5ffcd757acae853546d69a226ec185bb18df92`。
原 v10 保留在 `../20261012_goal89/release_v10/submission.py`，SHA256 仍为
`7d57a0519b0b2d9fb2694f2c56d8d8e97baa4b3b93bbd10a409ea2679a45d28d`。

用户报告 OJ #5、#7、#8、#9、#13 在预热时失败，调用栈均为
`wsum.mma → _warp_mma → T.tvm_mfma → tirx.Call`。原始日志截断了最末尾的
TypeError 文本；本地未安装官方 `triton_sandbox`，因此不能声称已复现完整 OJ 环境。

定位到 FP32 emitter 的标量类型描述：`local_size_a/b == 1` 时，库直接传递
`a_dtype/b_dtype`，因此原代码传入的 `T.float32` 会以 DataType 对象进入 intrinsic。
普通 FP16 MMA 会用格式化生成 `float16x4` 等字符串，未触发此问题。
本地 `tir.Call` 的参数类型允许 DataType，旧验证因此通过；严格 PrimExpr 转换则报
`Expected ir.PrimExpr but got DataType`。字面量字符串 `"float32"` 能正常转换为 StringImm。
这与用户给出的共同失败位置吻合，最终仍以重交后的 OJ 结果为准。

只修改三处 FP32 emitter 构造，将 `a_dtype`、`b_dtype`、`accum_dtype` 改为
普通字符串 `"float32"`，包括暂未由默认分派选中的 `fp32_sum`，避免遗漏同类问题。
完整差异见 [fix.patch](fix.patch)。分派、归约算法、同步、数值精度和缓存逻辑不变，
没有修改本地 TileLang 库。

验证结果见 [validation_summary.json](validation_summary.json)：

- 125 例独立 FP32 参考，factory 和 `run_kernel` 双接口通过；最大绝对误差 0.00390625。
- 14 个 OJ 形状全部通过，其中报错的五个形状各测 seed 0、61，共 19 组。
- 五个报错形状的异常索引和五种 scale 共 25 组，以及 5 组 RestrictedPython host 检查通过。
- 三个原 builder 在严格 PrimExpr 参数探针下均被真实 FFI 拒绝，修复后均通过；
  修复前后的正常 PrimFunc 结构一致。探针使用 `tir.Evaluate` 的实际 FFI 类型转换，
  仅在测试进程暂时包装 `T.tvm_mfma`，不进入提交文件。
- 14 个 OJ 形状及两个 D128/BS16 形状共 16 组，其设备源码、实际 JIT 设备二进制
  `.text`、编译参数和资源元数据与 v10 完全一致。本次没有新增性能优化或计时成绩。

复现：在现有 MetaX C500、MACA/TileLang、PyTorch 环境运行
`bash experiments/20261013_mfma_fix/commands.sh`。
结果写入新的 `/tmp/nsa_mfma_fix.*` 目录，不覆盖现有证据。沿用仓库的测试辅助文件及
`/tmp/nsa-restrictedpython-8.5`，官方 OJ 结果和 89 分目标仍待重新提交确认。
