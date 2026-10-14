"""Summarize immutable sources and completed performance/correctness evidence."""
import ast
import hashlib
import json
import math
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
RELEASE = ROOT / 'experiments/20261001_final'


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_text())


def geomean(values):
    return math.exp(statistics.mean(math.log(value) for value in values))


def main():
    full = read(RELEASE / 'full.json')
    verification = read(RELEASE / 'verification.json')
    checks = read(RELEASE / 'release_checks.json')
    bracket = read(RELEASE / 'bracketed.json')
    proof = read(HERE / 'qo_layout_proof.json')
    baseline = read(HERE / 'baseline_manifest.json')
    assert len(full['rows']) == 109
    assert len(verification) == 125 and all(row['status'] == 'PASS' for row in verification)
    assert checks['status'] == proof['status'] == 'PASS'
    for key, size in dict(boundaries=26, sources=26, fallbacks=18, refresh=12, packing=2, guarded=6).items():
        assert len(checks[key]) == size, (key, len(checks[key]))
    assert (RELEASE / 'equivalence.log').read_text().rstrip().endswith('ALL EQUIVALENT')
    static = (RELEASE / 'static_checks.log').read_text().splitlines()
    assert len(static) == 2 and all(line.endswith(' PASS') for line in static)
    for name, expected in baseline['sha256'].items():
        assert digest(ROOT / name) == expected, name
    for name, expected in full['source_sha256'].items():
        assert digest(ROOT / name) == expected, name
    for name, expected in checks['sha256'].items():
        assert digest(ROOT / name) == expected, name
    for name, expected in bracket['sha256'].items():
        assert digest(ROOT / name) == expected, name
    assert (RELEASE / 'nsa.py').read_bytes() == (HERE / 'candidate_v4.py').read_bytes()
    old = {n.name: ast.dump(n, include_attributes=False)
           for n in ast.parse((ROOT / 'experiments/20260930_candidate/nsa.py').read_text()).body
           if isinstance(n, ast.FunctionDef)}
    new = {n.name: ast.dump(n, include_attributes=False)
           for n in ast.parse((RELEASE / 'nsa.py').read_text()).body
           if isinstance(n, ast.FunctionDef)}
    assert all(new[name] == code for name, code in old.items() if name != '_get_kernel')
    changed, unchanged, audits = [], [], []
    forbidden = ('memcpy_async', 'cp.async', 'maca_async', 'tma_load', 'mbarrier')
    for row in full['rows']:
        original = RELEASE / f"submission_{row['case']}.cpp"
        current = RELEASE / f"nsa_{row['case']}.cpp"
        source = current.read_text()
        assert not any(token in source for token in forbidden)
        assert row['compile_flags'] == [[], []]
        c = row['config']
        grid = c['B'] * c['H'] * c['SEQ_LEN']
        selected = c['S'] == 1 and (
            (c['D'] == 64 and c['block_size'] == 16 and grid >= 2304)
            or (c['D'] == 128 and c['block_size'] == 16 and grid >= 1280)
            or (c['D'] == 128 and c['block_size'] == 32 and grid >= 1024))
        same = original.read_bytes() == current.read_bytes()
        assert same != selected, (row['case'], selected, same)
        if selected:
            expected_barriers = 3 if c['block_size'] == 32 else 7
            assert source.count('__syncwarp(') == expected_barriers
            assert source.count('__syncthreads(') == 0
        (unchanged if same else changed).append(row)
        audits.append(dict(case=row['case'], source_equal=same, source_sha256=digest(current),
                           compile_flags=row['compile_flags'][1]))
    assert len(changed) == 25 and len(unchanged) == 84
    for name in ('nsa.py', 'submission.py'):
        source = (RELEASE / name).read_text()
        assert 'TL_DISABLE_DATA_RACE_CHECK' not in source
        assert 'TL_DISABLE_SAFE_MEMORY_ACCESS' not in source
        assert '--misched=' not in source
    for row in bracket['rows']:
        assert len(row['summaries']) == 2
        assert all(s['accepted'] >= 24 and s['median_speedup'] is not None for s in row['summaries']), row['case']
    audit = dict(status='PASS', changed_count=len(changed), unchanged_count=len(unchanged), rows=audits)
    (RELEASE / 'device_audit.json').write_text(json.dumps(audit, indent=2) + '\n')
    long = {row['case']: row for row in bracket['rows']}
    manifest = dict(date='2026-10-01', user_confirmed_baseline_score=87.07, target_score=88,
        official_new_score=None, official_sandbox=False,
        source_sha256={name: digest(RELEASE / name) for name in ('nsa.py', 'submission.py')},
        preserved_baselines=baseline['sha256'], preserved_functions=len(old) - 1,
        dispatch=dict(s1_d64_bs16_grid_min=2304, s1_d128_bs16_grid_min=1280,
                      s1_d128_bs32_packed_grid_min=1024, groups=16, threads=64,
                      verified_fallback_knobs=['q_preload', 'kv_reuse', 'nmax', 'stage_regs', 'kv_split', 'q_frag'],
                      new_compile_flags=[]),
        performance=dict(cases=109, geomean=full['geomean_speedups'][1],
            changed_cases=len(changed), changed_geomean=geomean([r['speedups'][1] for r in changed]),
            unchanged_cases=len(unchanged), unchanged_geomean=geomean([r['speedups'][1] for r in unchanged]),
            minimum_ratio=min(r['speedups'][1] for r in full['rows']),
            maximum_ratio=max(r['speedups'][1] for r in full['rows'])),
        validation=dict(reference_cases=125, both_interfaces=True, boundary_cases=26,
            boundary_source_and_flag_comparisons=26, source_equivalence_cases=18,
            explicit_fallbacks=18, live_input_checks=12, packed_buffer_checks=2,
            guarded_host_cases=6, full_suite_device_sources=109,
            maximum_reference_error=max(r['max_abs_error'] for r in verification),
            maximum_boundary_error=max(r['max_abs_error'] for r in checks['boundaries'])),
        constraints=dict(asynchronous_copy=False, backend_changes=False, external_device_source=False,
            cached_input_or_output=False, disabled_race_or_bounds_checks=False,
            classes=False, function_attribute_writes=False),
        evidence_sha256={str(path.relative_to(ROOT)): digest(path) for path in [
            RELEASE / name for name in ('full.json', 'verification.json', 'release_checks.json',
                'bracketed.json', 'equivalence.log', 'static_checks.log', 'device_audit.json')]
            + [HERE / 'qo_layout_proof.json', HERE / 'packed_qo_families.json', HERE / 'packed_boundaries.json']})
    manifest['performance']['bracketed'] = [dict(case=key, control=long[key]['summaries'][0],
        candidate=long[key]['summaries'][1]) for key in long]
    (RELEASE / 'release_manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    table = []
    for key, label in [('oj6', 'oj6：D128 / BS32'), ('oj9', 'oj9：D64 / BS16'),
                       ('59', 'B8 T1024 D128 / BS16'), ('69', 'B4 T1024 D128 / BS32'),
                       ('83', 'B1 T1024 D128 / BS32'), ('oj12', 'oj12：S8 原路径')]:
        s = long[key]['summaries'][1]
        table.append(f"| {label} | {s['median_baseline_us']:.3f} | {s['median_candidate_us']:.3f} | {s['median_speedup']:.4f}× |")
    perf = manifest['performance']
    readme = f'''# 2026-10-01 NSA 提交候选

提交本目录 `submission.py` 全文。开发版为 `nsa.py`，完整证据和 SHA256 在
`release_manifest.json`。用户确认的 930 基线为 87.07 分；本版尚无 OJ 分数，
88 分目标仍需官方实测确认。

S1/G16/threads64 的新分派按 `grid = B * H * seq_len` 判断：D64/BS16 在
grid≥2304、D128/BS16 在 grid≥1280 使用合并 Q 读取和输出写回；D128/BS32
在 grid≥1024 每次重新打包当前 K/V，再使用合并 Q/O 访存。BS16 内核用七个
wave barrier 保护 Q/K/V/O 复用；BS32 attention 用三个 barrier 保护 Q/O。
BS32 分母归约只使用两次 warp shuffle；其 scratch 参数不产生共享内存访问。
所测六类调参覆盖保留 930 分派。930 的 28 个非分派函数保持原样，
原提交文件保持原哈希。新增代码使用同步 TileLang 操作和默认编译器调度。

109 例四轮交替对比，相对 930 几何平均 **{perf['geomean']:.6f}×**；
25 例设备源码改变，几何平均 {perf['changed_geomean']:.6f}×；84 例源码不变，
几何平均 {perf['unchanged_geomean']:.6f}×。单轮完整结果（含所有波动）见 `full.json`。

以下为 40 次 A/B/A 长测中基线漂移不超过 1% 的样本中位数，每图 500 次调用。
所有计时通过公开 `run_kernel`，使用相同输入、相同输出地址，并包含打包 kernel。
另有独立导入的同源 930 控制，原始样本和接受数量均在 `bracketed.json`。

| 用例 | 930 / μs | 本版 / μs | 加速 |
|---|---:|---:|---:|
{chr(10).join(table)}

125 个标准/扩展用例与 26 个分派边界用例的两个接口通过独立 float32 参考。
另通过 18 个参数回退源码对照、12 次同地址输入更新、2 个预填 NaN 的打包
缓冲完整覆盖/尾部补零检查、6 个真实 RestrictedPython host write guard 检查。
开发版/提交版通过 26 组边界源码及编译参数等价、18 组标准设备源码等价检查。
最大参考绝对误差 {manifest['validation']['maximum_reference_error']}。
地址证明覆盖 10 个 Q/O/MMA 组合、两份各4096元素的打包双射和12组尾块。
保守的 XOR 布局 race warning 保留；没有关闭 race 或边界检查。
本地 host guard 检查不等于完整官方沙箱；完整官方兼容性由 OJ 确认。

复现命令在 `commands.sh`。独立研究记录在 `../20261001_tuning`：小网格 Q/O、
BS16 的 S1 预打包、全开 ILP 调度均有回退，不能全局启用。
'''
    (RELEASE / 'README.md').write_text(readme)
    print('PASS: immutable release manifest and README')
    print(json.dumps(manifest['source_sha256'], indent=2))
    print('Full geomean:', perf['geomean'])


if __name__ == '__main__':
    main()
