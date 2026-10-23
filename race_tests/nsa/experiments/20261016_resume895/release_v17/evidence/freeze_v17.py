"""Freeze the validated candidate and its complete, unfiltered research record."""
import difflib
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import tempfile

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
DEPENDENCIES=[
    'env.sh','benchmark_nsa.py','verify_nsa.py','experiment_bench.py','bench_oj.py',
    'nsa.py','test_tilelang_nsa_fwd.py','reference.py','test_cases_nsa_fwd.json',
    'check_submission_nsa.py','kernel_source.py',
    'experiments/20261001_tuning/verify_release.py',
    'experiments/20261002_tuning/verify_candidate.py',
    'experiments/20261005_goal8929/verify_candidate.py',
    'experiments/20260928_guard_fix/check_restricted_host.py',
    'experiments/20261003_packed_compute/inspect_resources.py',
    'experiments/20261008_resume8871/audit_actual_binary.py',
    'experiments/20261015_goal8933/audit_binary.py',
    'experiments/20261016_s2_family/bench_storage_windows.py',
    'experiments/20261008_goal895/profile_cold.py',
    'experiments/20261016_goal895/summarize_screen.py',
    'experiments/20261016_pow2/probe_math.py',
    'experiments/20261016_pow2/pow2_all.py',
]
STUDY_DEPENDENCIES=['verify_v17.py','verify_full_fp32.py','verify_pow_math.py',
                    'baseline.py','control.py','candidate_cases.json',
                    'profile_cold_warm.py','profile_cold_aba.py']


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def copy(source,destination):
    destination.parent.mkdir(parents=True,exist_ok=True)
    shutil.copy2(source,destination)


def main():
    final=HERE/'release_v17'
    assert not final.exists()
    summary=json.loads((HERE/'final_v17_summary.json').read_text())
    assert summary['status']=='PASS' and not summary['official']['target_verified']
    assert summary['candidate_sha256']==sha(HERE/'candidate_v17.py')
    for name,digest in summary['evidence_sha256'].items():
        assert sha(HERE/name)==digest,name
    assert all((ROOT/name).is_file() for name in DEPENDENCIES)
    assert all((HERE/name).is_file() for name in STUDY_DEPENDENCIES)
    assert (ROOT.parent/'moe/check_submission.py').is_file()
    snapshot=[p for p in HERE.rglob('*') if p.is_file() and '__pycache__' not in p.parts
              and not any(x.startswith(('release_v17','.release_v17')) for x in p.relative_to(HERE).parts)]
    temporary=Path(tempfile.mkdtemp(prefix='.release_v17.',dir=HERE))
    copy(HERE/'candidate_v17.py',temporary/'submission.py')
    copy(HERE/'baseline.py',temporary/'parent_v16.py')
    copy(HERE/'final_v17_summary.json',temporary/'final_summary.json')
    patch=''.join(difflib.unified_diff((HERE/'baseline.py').read_text().splitlines(keepends=True),
                    (HERE/'candidate_v17.py').read_text().splitlines(keepends=True),
                    fromfile='parent_v16.py',tofile='submission.py'))
    (temporary/'changes.patch').write_text(patch)
    for p in snapshot:
        copy(p,temporary/'evidence'/p.relative_to(HERE))
    for name in DEPENDENCIES:
        copy(ROOT/name,temporary/'dependencies/nsa'/name)
    for name in STUDY_DEPENDENCIES:
        copy(HERE/name,temporary/'dependencies/nsa/experiments/20261016_resume895'/name)
    copy(ROOT.parent/'moe/check_submission.py',temporary/'dependencies/moe/check_submission.py')
    copy(HERE/'reproduce_v17.sh.in',temporary/'commands.sh')
    (temporary/'commands.sh').chmod(0o755)
    subprocess.run(['bash','-n',str(temporary/'commands.sh')],check=True)
    hot=summary['hot'];cold=summary['cold_adjacent']
    cold_values=' / '.join(f"{x['speedup']:.6f}×" for x in cold['rows'])
    readme=f'''# NSA v17，2026-10-16

提交本目录 `submission.py` 全文。SHA256：`{summary['candidate_sha256']}`。
用户最近确认总分仍为 89，v15 正在 OJ 运行。**v17 无正式成绩，89.5 尚未确认。**

在 v16 上，只将既有小 D32 builder 的指数表达改成公开 `T.pow(2, x)`。
指数上限、scale/索引掩码、FP32 MMA、平方根倒数归一化和共享同步保持。
74 个其他原函数、分派、两个公开接口、checked adapter、当前输入转换和显式回退不变。
没有新增形状条件。`parent_v16.py` 可用于回退。

相对 v16，OJ1 的 24 组地址/图长度/种子热测几何平均为 **{hot['geomean']:.6f}×**，
同源对照为 {hot['control_geomean']:.6f}×；{len(hot['regressions'])} 行回退，最差
{min(x['speedup'] for x in hot['rows']):.6f}×。全部样本保留。
逐次相邻 A/B/A 冷测 seeds 0/61/2026 的总耗时比为 {cold_values}，
几何平均 **{cold['geomean']:.6f}×**，同源对照 {cold['control_geomean']:.6f}×。
每种子有 256 次候选比较和 256 次同源比较，每次调用前都冲刷 256 MB。
这些只覆盖 OJ1，不能解释成 14 点整体加速或正式分数。

早期分组冷测出现较大漂移：第三种子的表面 15.4% 收益伴随 8.5% 同源偏差；
固定追加复测也有一行负值。它们完整保留于 `evidence/`，不作为主要收益结论。
相邻逐次追踪仍有少量对照噪声，实际收益以 OJ 为准。

125 例双接口参考（显式关闭 TF32）、13 个边界、36 组 scale/索引、3 组零输入、
12 次原地址输入更新和图回放、4 组受限 host、16 次实际编译缓存顺序检查通过。
全量最大绝对误差 {summary['correctness']['maximum_full_reference_error']}。
FP32 emitter 通过严格 PrimExpr 类型检查。受限 host 检查不等同于官方沙箱。
旧全量入口默认允许 TF32 的结果单独保留；发布依据为 `full_reference_fp32.json`。

23 个配置 × 三版本实际 JIT ELF 核对：14 个 OJ 中只有 OJ1 改变设备 `.text`，
其他 13 个和边界路径保持 v16。已测探针和最终候选在 OJ1 的设备源码、指令、
资源及 flags 一致。S2/S4、大 S1、BS32/S8 指数探针，以及只打包 K 的三个方案
均未合入；全部失败和负面记录保留。

复现：`bash commands.sh`。脚本先核验文件哈希，再在新的临时目录串行测试。
使用所附 `env.sh` 指向的 MACA 和 `/app/tilelang-metax` 构建，以及现有 PyTorch、
NumPy、msgpack、RestrictedPython 8.5（当前安装在 `/tmp/nsa-restrictedpython-8.5`）。
本机是 MetaX C500 的 25% slice。复测不会覆盖冻结证据。
'''
    (temporary/'README.md').write_text(readme)
    manifest=dict(candidate_sha256=summary['candidate_sha256'],parent_v16_sha256=summary['parent_v16_sha256'],
                  official_candidate_score=None,target_verified=False,
                  files={str(p.relative_to(temporary)):sha(p) for p in sorted(temporary.rglob('*')) if p.is_file()})
    (temporary/'release_manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
    assert all(sha(temporary/name)==digest for name,digest in manifest['files'].items())
    temporary.rename(final)
    print('Frozen',final,len(manifest['files']),'files',summary['candidate_sha256'])


if __name__=='__main__':
    main()
