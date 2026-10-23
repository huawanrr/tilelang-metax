# S8 的 QK/PV 分阶段研究，2026-10-16

本轮五个探针全部不采用，当前提交仍为
[`../20261016_goal895/release_v14/submission.py`](../20261016_goal895/release_v14/submission.py)。
SHA256 `d3c4e9f7417069efc0a0189d5754d4f8e765034c848c2219d32e869dd3b22080`。
用户确认的成绩为 89 分，目标 89.5；v14 尚无官方结果。

研究只改已有默认大 S8 的两个 mathcast builder。先按原顺序流式计算 QK，
保存原有的 FP16 权重转换结果，再按原顺序读取 V 并计算 PV。
FP32 分母累加次序、交替输出累加器、mask、打包、分派、公开接口和输出同步保持。
GPU 工作串行，使用 `source env.sh` 对应的 `/app/tilelang-metax` 构建。

`phase_screen.json` 与 `phase_shared_screen.json` 各包含四个形状、两个种子，
每行 24 次 A/B/A、每图 240 次公开调用。使用共同图内存池、同源控制、
独立 FP32 参考和正反顺序图回放。全部参考及回放通过，全部正负轮次保留。

| 探针 | 未过滤几何平均加速比 | 回退行数 |
| --- | ---: | ---: |
| 寄存器权重，K4/V1 | 0.95681159× | 8/8 |
| 寄存器权重，K4/V2 | 0.96421310× | 8/8 |
| 寄存器权重，K2/V2 | 0.96836872× | 8/8 |
| 共享权重，K4/V1 | 0.95064028× | 8/8 |
| 共享权重，K2/V2 | 0.94893670× | 8/8 |

两个屏次的同源控制分别为 0.99996449× 和 1.00003231×。
共享权重布局的 2048 个元素逐项证明地址一一对应、读写线程一致。
RAW 与 WAR 两处 wave 同步均保留；编译器在 PV 后复用该缓冲区做归约和输出，
因此不能删除后置同步。

`phase_binary/report.json` 提取实际 JIT ELF，共六个模块、两个形状、24 个设备部分。
打包 `.text` 保持，无 private memory 溢出。注意力的 streg 均为 52，
OJ12 的 `.text` 从 7680 B 增至 9472–9984 B，较大形状从 8192 B 增至 9984–10496 B。

`audit_occupancy.py` 加载同一 ELF，调用 MACA 运行时的驻留查询；不执行设备 kernel。
动态共享内存大小取自实际 host 启动参数，完整源码保存在 `occupancy/`。
ELF 的静态 shared=0 不代表启动时没有共享内存。

| 探针 | OJ12 mtreg | OJ12 驻留上限 | B8/T1024 mtreg | B8/T1024 驻留上限 | 动态 shared |
| --- | ---: | ---: | ---: | ---: | ---: |
| v14 | 94 | 20 | 126 | 16 | 2048 B |
| 寄存器 K4/V1 | 68 | 28 | 96 | 20 | 2048 B |
| 寄存器 K4/V2 | 72 | 28 | 100 | 16 | 2048 B |
| 寄存器 K2/V2 | 74 | 24 | 98 | 16 | 2048 B |
| 共享 K4/V1 | 62 | 16 | 94 | 16 | 4096 B |
| 共享 K2/V2 | 64 | 16 | 96 | 16 | 4096 B |

这里是每个 SM 的运行时资源上限，不是性能采样得到的实际平均驻留量。
寄存器版已经提高了 OJ12 的资源上限，耗时仍回退；共享版反而受更大 shared 限制。
本轮证据不支持继续组合旧的降标量寄存器方案，也不代表所有其他 S8 优化均不可能。

完整命令保存在屏次和二进制报告的 `command` 字段。复核驻留时使用新输出目录：

```bash
source env.sh
python experiments/20261016_s8_phases/audit_occupancy.py \
  --binary-report experiments/20261016_s8_phases/phase_binary/report.json \
  --output-dir /tmp/nsa-s8-occupancy-new
```

`study_summary.json` 为最终结论，`research_manifest.json` 保存本轮文件哈希。
生成器清单中的 unvalidated 是生成时状态；本轮只做拒绝候选所需的筛查，
没有重复运行冻结 v14 的全量验证，也没有产生 v15。
