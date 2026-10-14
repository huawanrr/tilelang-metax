"""Summarize verified candidate sources and the retained measurement evidence."""
import argparse
import ast
import hashlib
import json
import math
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def read(path):
    return json.loads(path.read_text())


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def geomean(values):
    return math.exp(statistics.mean(math.log(value) for value in values))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', required=True)
    args = parser.parse_args()
    release = Path(args.directory).resolve()
    assembly = read(release / 'assembly.json')
    assert assembly['config']['short_wave_min_grid'] == assembly['config']['short_qo_min_grid'] == 3072
    baseline = read(HERE / 'baseline_manifest.json')
    full = read(release / 'full.json')
    verification = read(release / 'verification_fp32.json')
    checks = read(release / 'release_checks.json')
    bracket = read(release / 'bracketed.json')
    qo_proof = read(HERE / 'qo_layout_proof.json')
    pack_proof = read(HERE / 'pack_layout_proof.json')
    threshold = read(HERE / 's2_boundary_3072.json')
    assert len(full['rows']) == 109
    assert len(verification) == 125 and all(r['status'] == 'PASS' for r in verification)
    assert checks['status'] == qo_proof['status'] == pack_proof['status'] == 'PASS'
    assert checks['reference_matmul_tf32'] is False
    assert digest(Path(qo_proof['packed']['reduction_header'])) == qo_proof['packed']['reduction_header_sha256']
    for key, count in dict(boundaries=31, sources=31, extremes=3, fallbacks=28,
                           refresh=15, packing=4, guarded=7).items():
        assert len(checks[key]) == count, (key, len(checks[key]))
    equiv = (release / 'equivalence.log').read_text()
    assert equiv.rstrip().endswith('ALL EQUIVALENT')
    assert sum(line.endswith(': EQUIVALENT') for line in equiv.splitlines()) == 18
    static = (release / 'static_checks.log').read_text().splitlines()
    assert len(static) == 2 and all(line.endswith(' PASS') for line in static)
    for hashes in (baseline['source_sha256'], assembly['source_sha256'],
                   full['source_sha256'], checks['source_sha256'], bracket['sha256'], threshold['sha256']):
        for name, expected in hashes.items():
            assert digest(ROOT / name) == expected, name
    assert (HERE / 'reference_1001.py').read_bytes() == (ROOT / baseline['baseline']).read_bytes()
    functions = []
    for path in (ROOT / 'experiments/20261001_final/nsa.py', release / 'nsa.py'):
        functions.append({n.name: ast.dump(n, include_attributes=False)
                          for n in ast.parse(path.read_text()).body if isinstance(n, ast.FunctionDef)})
    retained = [name for name in functions[0] if name != '_get_kernel']
    assert len(retained) == 31 and set(retained) == set(assembly['retained_functions'])
    assert all(functions[0][name] == functions[1][name] for name in retained)
    initial = {n.name: ast.dump(n, include_attributes=False)
               for n in ast.parse((ROOT / 'experiments/20261002_candidate/nsa.py').read_text()).body
               if isinstance(n, ast.FunctionDef)}
    assert initial['native_sparse_attention_short_list_qo_v2'] == functions[1]['native_sparse_attention_short_list_qo_v2']
    assert len(threshold['rows']) == 8
    assert all(row['summaries'][1]['accepted'] >= 24 and row['summaries'][1]['median_speedup'] > 1
               for row in threshold['rows'])
    changed, unchanged, audits = [], [], []
    forbidden = ('memcpy_async', 'cp.async', 'maca_async', 'tma_load', 'mbarrier')
    for row in full['rows']:
        original = release / f"reference_1001_{row['case']}.cpp"
        current = release / f"submission_{row['case']}.cpp"
        source = current.read_text()
        assert not any(marker in source for marker in forbidden), current
        assert all(not flags for module in row['compile_flags'] for flags in module)
        same = original.read_bytes() == current.read_bytes()
        assert same == (row['device_source_sha256'][0] == row['device_source_sha256'][1])
        (unchanged if same else changed).append(row)
        audits.append(dict(case=row['case'], source_equal=same,
                           baseline_sha256=digest(original), candidate_sha256=digest(current),
                           kernel_source_sha256=row['device_source_sha256'],
                           compile_flags=row['compile_flags']))
    assert [r['case'] for r in changed] == ['68', '69', '70', '76', '82', '83', '84', '85', '86']
    assert len(unchanged) == 100
    for name in ('nsa.py', 'submission.py'):
        source = (release / name).read_text()
        assert not any(marker in source for marker in
                       ('TL_DISABLE_DATA_RACE_CHECK', 'TL_DISABLE_SAFE_MEMORY_ACCESS', '--misched='))
    for row in bracket['rows']:
        assert len(row['summaries']) == 2
        for summary, trials in zip(row['summaries'], row['trials'][1:]):
            assert len(trials) == summary['total'] == 40
            assert sum(trial['accepted'] for trial in trials) == summary['accepted'] >= 24, row['case']
            assert all(trial['accepted'] == (trial['drift'] <= 0.01) for trial in trials)
    audit = dict(status='PASS', changed_count=len(changed), unchanged_count=len(unchanged), rows=audits)
    (release / 'device_audit.json').write_text(json.dumps(audit, indent=2) + '\n')
    changed_ids = {r['case'] for r in changed}
    perf = dict(standard_cases=109, geomean_speedup=geomean([r['speedups'][1] for r in full['rows']]),
        changed_cases=[r['case'] for r in changed],
        changed_geomean_speedup=geomean([r['speedups'][1] for r in changed]),
        unchanged_cases=100, unchanged_geomean_speedup=geomean([r['speedups'][1] for r in unchanged]),
        minimum_changed_speedup=min(r['speedups'][1] for r in changed),
        minimum_unchanged_speedup=min(r['speedups'][1] for r in unchanged),
        dual_interface_reference_cases=125,
        reference_report='verification_fp32.json', reference_matmul_tf32=False,
        max_abs_error_all=max(r['max_abs_error'] for r in verification),
        max_abs_error_changed=max(r['max_abs_error'] for r in verification if str(r['case']) in changed_ids),
        official_new_score=None)
    (release / 'performance_summary.json').write_text(json.dumps(perf, indent=2) + '\n')
    evidence = [release / name for name in ('assembly.json', 'full.json', 'full.log',
        'verification_fp32.json', 'verification_fp32.log', 'release_checks.json', 'release_checks.log',
        'bracketed.json', 'bracketed.log', 'equivalence.log', 'static_checks.log',
        'device_audit.json', 'performance_summary.json', 'commands.sh')]
    evidence += [HERE / name for name in ('qo_layout_proof.json', 'pack_layout_proof.json',
        'verify_candidate.py', 'verify_reference.py', 'assemble_candidate.py', 'compare_family.py',
        'bracketed_family.py', 'family_cases.json', 'write_release.py')]
    evidence += [HERE / 's2_boundary_3072.json', HERE / 's2_boundary_3072.log',
                 ROOT / 'experiments/20261002_candidate/bracketed.json']
    manifest = dict(date='2026-10-02', status='locally_verified; awaiting_official_score',
        baseline=baseline['baseline'], user_confirmed_baseline_score=87.93, target_score=88.5,
        official_new_score=None, official_sandbox=False,
        source_sha256={name: digest(release / name) for name in ('nsa.py', 'submission.py')},
        preserved_baselines=baseline['source_sha256'], preserved_functions=retained,
        added_functions=assembly['new_functions'], dispatch_config=assembly['config'],
        s2_threshold_selection=dict(rejected_min_grid=2048, selected_min_grid=3072,
            rejected_cases=['s2_b1_t2048_h1', 's2_b16_t128_h1'],
            threshold_family_report='experiments/20261002_tuning/s2_boundary_3072.json',
            measured_builder_ast_identical=True,
            threshold_family_speedup_min=min(r['summaries'][1]['median_speedup'] for r in threshold['rows']),
            threshold_family_speedup_max=max(r['summaries'][1]['median_speedup'] for r in threshold['rows'])),
        performance=perf,
        bracketed=[dict(case=r['case'], config=r['config'], control=r['summaries'][0],
                        candidate=r['summaries'][1]) for r in bracket['rows']],
        validation=dict(reference_cases=125, reference_matmul_tf32=False, both_interfaces=True,
            boundary_cases=len(checks['boundaries']), boundary_source_and_flag_comparisons=len(checks['sources']),
            source_equivalence_cases=18, explicit_fallbacks=len(checks['fallbacks']),
            extreme_int32_index_cases=len(checks['extremes']), live_input_checks=len(checks['refresh']),
            packed_buffer_checks=len(checks['packing']), guarded_host_cases=len(checks['guarded']),
            full_suite_device_sources=109, qo_layout_combinations=len(qo_proof['checks']),
            packing_layout_combinations=len(pack_proof['checks']), packing_tail_families=len(pack_proof['tails']),
            maximum_reference_error=perf['max_abs_error_all'],
            maximum_changed_reference_error=perf['max_abs_error_changed'],
            maximum_boundary_error=max(r['max_abs_error'] for r in checks['boundaries'])),
        constraints=dict(asynchronous_copy=False, backend_changes=False, external_device_source=False,
            cached_input_or_output=False, disabled_race_or_bounds_checks=False,
            classes=False, function_attribute_writes=False, new_compile_flags=[]),
        evidence_sha256={str(path.relative_to(ROOT)): digest(path) for path in evidence})
    (release / 'release_manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    long = {row['case']: row for row in bracket['rows']}
    labels = [('oj6', 'oj6：B8 T1024 / D128 BS32'), ('83', 'B1 T1024 / D128 BS32'),
              ('84', 'B2 T1024 / D128 BS32'), ('69', 'B4 T1024 / D128 BS32'),
              ('76', 'B4 T1024 / S2 D64 BS16'), ('oj12', 'oj12：B4 T1024 / S8 D64 BS16'),
              ('s2_b1_t3072_h1', 'B1 T3072 / S2 D64 BS16'), ('oj9', 'oj9：S1 D64 BS16 原路径')]
    table = []
    for key, label in labels:
        control, current = long[key]['summaries']
        table.append(f"| {label} | {current['median_baseline_us']:.3f} | {current['median_candidate_us']:.3f} | "
                     f"{current['median_speedup']:.4f}× | {control['median_speedup']:.4f}× | {current['accepted']}/40 |")
    fallback_names = ['s2_b1_t2048_h1', 's2_b2_t512_h2', 's2_b8_t256_h1',
                      's2_b16_t128_h1', 's2_b32_t64_h1']
    fallback_ratios = [long[key]['summaries'][1]['median_speedup'] for key in fallback_names]
    all_controls = [row['summaries'][0]['median_speedup'] for row in bracket['rows']]
    readme = f'''# 2026-10-02 NSA 提交候选

提交本目录 `submission.py` 全文，开发源码为 `nsa.py`。
基线是用户确认达到 **87.93 分**的 `../20261001_final/submission.py`。
本版尚无正式 OJ 分数，**88.5 分目标尚未确认达到**。
源码哈希和完整证据见 `release_manifest.json`，复现命令见 `commands.sh`。

新分派使用 `grid = B * H * seq_len`，作用于 G16、64线程和默认调参路径：

- S1 / D128 / BS32 / grid≥1024：Q读取宽度4，V延后读取；
  H1、seq_len≥64、grid<4096使用128线程direct打包，其他使用256线程shared vec4打包。
  shared打包保留一次block barrier，attention保留三个wave barrier。
  每次调用都重新打包当前K/V，两次发射完整计时。
- S2 / D64 / BS16 / seq_len≥64 / grid≥3072：拼接两个选中块，合并Q/O访存，
  保留七个wave barrier；无效索引先限制到[-1, NB]再乘block_size。
- S8 / D64 / BS16 / grid≥4096：输出经过共享暂存以合并写回，增加一个wave barrier。
  原batch遍历顺序、grid≥8192的四累加器和原K/V打包保持。

31个原非分派函数的AST完全保留，新增6个builder。显式调参的28项回退通过源码及
编译参数对照。六个受保护旧源码SHA256不变。本版使用同步Torch/TileLang操作，
未关闭race或bounds检查，未增加外部device source、类定义或函数属性写入。

109例、四轮交替、每图200次调用、每轮7次采样，相对10.1几何平均
**{perf['geomean_speedup']:.8f}×**。9个改动用例（68、69、70、76、82、83、84、85、86）
全部加速，几何平均 **{perf['changed_geomean_speedup']:.8f}×**；100个设备码不变用例
几何平均为{perf['unchanged_geomean_speedup']:.8f}×。原始轮次中位数在 `full.json`。
这三个统计范围不同，不能把改动子集的提升当作全量提升。

下表为40次A/B/A长测、每图500次调用的中位数。前后基线漂移≤1%的样本才进入
统计；每个样本的原始耗时、拒绝记录、独立导入的同源10.1对照均在 `bracketed.json`。
所有计时使用公开 `run_kernel`、相同输入和同一个预分配输出。

| 用例 | 10.1 / μs | 本版 / μs | 加速 | 同源对照 | 接受样本 |
|---|---:|---:|---:|---:|---:|
{chr(10).join(table)}

全部长测的同源对照范围为{min(all_controls):.5f}–{max(all_controls):.5f}×。
个别扩展形状的对照也有偏移，其全部差值不能都归为算法收益；原始结果保留。

初始候选在S2/grid2048的长序列单batch、B16/T128两例分别回退约3.2%和2.2%，
因此最终阈值收紧到3072。最终版对五个grid2048形状的长测比值为
{min(fallback_ratios):.5f}–{max(fallback_ratios):.5f}×。
另外八个grid3072的B/T/H组合加速1.06150–1.12333×，同源对照接近1.000×；
其测量与最终版S2 builder的AST完全相同，见 `../20261002_tuning/s2_boundary_3072.json`。

125个标准/扩展用例的factory和 `run_kernel` 通过显式关闭TF32的独立float32参考。
最大绝对误差{perf['max_abs_error_all']}出现在未改动case46；改动用例最大误差
{perf['max_abs_error_changed']}。31个分派边界及3个极端int32索引用例的双接口通过；
另通过15次同地址输入更新、4次打包缓冲NaN完整覆盖/尾部补零、7个真实
RestrictedPython host write guard检查，以及18组标准开发/提交设备源码等价。
CPU地址证明覆盖12组Q/O/MMA组合、三种打包线程布局和21种打包尾块。
本地host guard检查的范围见日志，完整官方沙箱和正式成绩仍由OJ确认。

`../20261002_candidate`保留初始2048阈值版本及其全部结果，供复核筛选过程；
本目录是收紧阈值后重新完成全量验证与长测的版本。
'''
    (release / 'README.md').write_text(readme)
    manifest['evidence_sha256'][str((release / 'README.md').relative_to(ROOT))] = digest(release / 'README.md')
    (release / 'release_manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print('PASS: source hashes, preserved baselines and completed release evidence')
    print(json.dumps(manifest['source_sha256'], indent=2))
    print(json.dumps(perf, indent=2))


if __name__ == '__main__':
    main()
