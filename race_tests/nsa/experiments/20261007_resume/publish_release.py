"""Freeze a fully checked NSA candidate and the evidence needed to reproduce it."""
import argparse
import hashlib
import json
import math
from pathlib import Path
import shutil
import statistics

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def aggregate(values):
    assert all(v is not None and v > 0 for v in values)
    if not values:
        return dict(count=0)
    return dict(count=len(values), geomean=math.exp(statistics.mean(map(math.log, values))),
                minimum=min(values), maximum=max(values))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--prefix', required=True)
    parser.add_argument('--release', required=True)
    parser.add_argument('--family', action='append', default=[])
    parser.add_argument('--family-summary', action='append', default=[])
    args = parser.parse_args()
    prefix = args.prefix

    def read(suffix):
        return json.loads((HERE / f'{prefix}_{suffix}.json').read_text())

    dev, sub = HERE / f'{prefix}.py', HERE / f'{prefix}_submission.py'
    baseline = ROOT / 'experiments/20261002_mid_v1/submission.py'
    parent = ROOT / 'experiments/20261005_goal8929/release_v1/submission.py'
    assert digest(baseline) == 'ee780d62a64e427d742db494596feffd0f3f9834e4587cad61a66713f2936c31'
    old_manifest = json.loads((parent.parent / 'release_manifest.json').read_text())
    for name, expected in old_manifest['release_files_sha256'].items():
        assert digest(parent.parent / name) == expected, ('inherited release changed', name)
    assembly, structure, host = read('assembly'), read('structure'), read('host_ast')
    extra, reference, full, audit = read('extra'), read('reference'), read('full'), read('audit')
    scales = read('scale_sources')
    assert assembly['candidate_sha256'] == digest(dev)
    assert structure['status'] == host['status'] == extra['status'] == audit['status'] == 'PASS'
    assert structure['source_sha256'] == digest(dev)
    assert extra['source_sha256'] == digest(sub)
    assert len(extra['edge_cases']) == 51 and len(extra['tuning']) == 28
    assert len(extra['live_updates']) == 12 and len(extra['restricted_host']) == 3
    assert scales['status'] == 'PASS' and len(scales['rows']) == 6
    for path, expected in scales['source_sha256'].items():
        assert digest(ROOT / path) == expected
    assert not assembly['positive_scale_device_code_equivalence_pending']
    for path, expected in host['files'].items():
        assert digest(ROOT / path) == expected
    assert len(reference) == 125 and all(r['status'] == 'PASS' for r in reference)
    assert len(full['rows']) == len(audit['full']) == 109 and full['shared_pool']
    for source, expected in full['sha256'].items():
        assert digest(ROOT / source) == expected
    for field in ('source_sha256', 'evidence_sha256'):
        for source, expected in audit[field].items():
            assert digest(ROOT / source) == expected
    modules = list(full['sha256'])
    sub_index = next(i for i, p in enumerate(modules) if Path(p).resolve() == sub)
    parent_index = next(i for i, p in enumerate(modules) if Path(p).resolve() == parent)
    field = sub_index - 1
    audit_rows = {r['case']: r for r in audit['full']}
    changed = [r for r in full['rows'] if not audit_rows[r['case']]['baseline_equal']]
    unchanged = [r for r in full['rows'] if audit_rows[r['case']]['baseline_equal']]
    new_s2 = [r for r in full['rows'] if not audit_rows[r['case']]['parent_equal']]

    def summary(rows):
        return aggregate([r['summaries'][field]['median_speedup'] for r in rows])

    performance = dict(all=summary(full['rows']), changed=summary(changed),
        unchanged=summary(unchanged), new_s2=summary(new_s2),
        control=aggregate([r['summaries'][0]['median_speedup'] for r in full['rows']]),
        parent=aggregate([r['summaries'][parent_index-1]['median_speedup'] for r in full['rows']]),
        all_unfiltered=aggregate([statistics.median(t['speedup'] for t in r['trials'][sub_index])
                                  for r in full['rows']]),
        changed_cases=[r['case'] for r in changed], new_s2_cases=[r['case'] for r in new_s2],
        max_reference_error=max(r['max_abs_error'] for r in reference),
        raw_reports_keep_all_drift_rejects=True, official_score=None)
    release = HERE / args.release
    release.mkdir(exist_ok=False)
    files = {f'{prefix}.py': 'nsa.py', f'{prefix}_submission.py': 'submission.py'}
    files.update({f'{prefix}_{key}.json': f'{key}.json'
                  for key in ('assembly', 'structure', 'host_ast', 'scale_sources', 'extra', 'reference', 'full', 'audit')})
    for source, target in files.items():
        shutil.copyfile(HERE / source, release / target)
    summaries = []
    for path in args.family_summary:
        source = Path(path)
        data = json.loads(source.read_text())
        assert digest(ROOT / data['input']) == data['input_sha256']
        shutil.copyfile(source, release / source.name)
        summaries.append(data)
    (release / 'performance.json').write_text(json.dumps(performance, indent=2) + '\n')
    table = '\n'.join(f"| {row['case']} | {row['config']['S']} | "
        f"{row['summaries'][field]['median_baseline_us']:.3f} | "
        f"{row['summaries'][field]['median_candidate_us']:.3f} | "
        f"{row['summaries'][field]['median_speedup']:.5f}× |" for row in changed)
    counts = {key: len(extra[key]) for key in ('edge_cases', 'tuning', 'live_updates', 'restricted_host')}
    family_text = '\n'.join(
        f"- `{Path(s['input']).name}`：启用范围 {s['selected']['count']} 组，"
        f"几何平均 {s['selected']['geomean']:.8f}×，"
        f"范围 {s['selected']['minimum']:.8f}–{s['selected']['maximum']:.8f}×，"
        f"回退 {len(s['regressions'])} 组；保留全部原始样本。" for s in summaries)
    s2 = assembly['s2_config']
    head_text = f"、H <= {s2['max_heads']}" if s2['max_heads'] else ''
    causal_text = (f"非因果配置要求 grid >= {s2['noncausal_grid_min']}。"
                   if s2.get('noncausal_grid_min', s2['grid_min']) != s2['grid_min'] else '')
    readme = f'''# NSA S2 / S4 / 小 S8 候选（2026-10-07）

可评测文件：`submission.py`；开发源码：`nsa.py`。
正式已确认基线仍为 **88.29**；用户目标为 **89**，本版尚无正式 OJ 成绩。
提交 SHA256：`{digest(sub)}`。

继承 `experiments/20261005_goal8929/release_v1` 的 S4 / 小 S8 优化，新增默认
S2 / D64 / BS16 / G16 的完整块读取：SEQ_LEN >= {s2['seq_len_min']}、
B*H*SEQ_LEN >= {s2['grid_min']}{head_text}，且 SEQ_LEN 能被 16 整除。{causal_text}
先检查块号再形成地址，按两个 FP16 读取；两个完整有效块直接初始化分数，
其余情况保留逐元素掩码。计时使用的 scale=0.1 设备码与原测量 probe 核对一致，
新 S2 路径还修复了继承的零/负 scale 掩码问题；shared 布局、输出和同步有对应检查。
显式调参及范围以外的路径保持父版。完整分派条件以 `assembly.json` 和源码为准。

继承范围：S4 为 H1、SEQ_LEN >= 256、grid >= 2048；S8 为
SEQ_LEN >= 128、grid <= 512，均仅作用于默认 D64 / BS16 / G16 路径。
每次公开调用读取当前输入，打包路径的全部启动开销均计入测试。

109 例同轮 A/B/A，每图 200 调用，每例 12 组，共用图内存池。
与 88.29 基线相比，设备源码改变的用例如下：

| 本地用例 | S | 基线 μs | 候选 μs | 加速比 |
|---|---:|---:|---:|---:|
{table}

109 例几何平均为 **{performance['all']['geomean']:.8f}×**；
{len(unchanged)} 个不变用例为 **{performance['unchanged']['geomean']:.8f}×**。
本地形状的收益不能换算为正式得分。

{family_text}

验证：125 例独立 FP32 双接口参考、{counts['edge_cases']} 组新增边界/极端索引/scale
检查、{counts['tuning']} 项显式调参对照、{counts['live_updates']} 次同地址图重放输入更新、
{counts['restricted_host']} 组 S2 与 {len(audit['inherited_guarded'])} 组继承路径 RestrictedPython host 检查通过。
109 例实际计时设备码及 {len(audit['families'])} 个家族记录均核对开发/提交版和已测 probe/父版。
CPU 地址、线程归属和完整块条件证明通过。参考最大绝对误差
{performance['max_reference_error']}。本地 host 检查不等同于完整官方沙箱。

从 `race_tests/nsa` 执行 `bash {release.relative_to(ROOT)}/commands.sh` 可在新目录复现。
全部原始结果、负实验和文件哈希见本目录与 `release_manifest.json`。
'''
    (release / 'README.md').write_text(readme)
    relative = release.relative_to(ROOT)
    research = HERE.relative_to(ROOT)
    family_args = ''.join(f' --family {Path(p)}' for p in args.family)
    commands = f'''#!/usr/bin/env bash
set -eo pipefail
source env.sh
task_repro_dir=$(mktemp -d {research}/repro.XXXXXX)
cp {relative}/nsa.py {relative}/submission.py {relative}/assembly.json "$task_repro_dir/"
python check_submission_nsa.py "$task_repro_dir/nsa.py" "$task_repro_dir/submission.py"
python {research}/check_s2_structure.py "$task_repro_dir/nsa.py" --output "$task_repro_dir/structure.json"
python {research}/check_scale_sources.py "$task_repro_dir/submission.py" --output "$task_repro_dir/scale_sources.json" > "$task_repro_dir/scale_sources.log" 2>&1
python {research}/verify_s2_extra.py "$task_repro_dir/submission.py" --output "$task_repro_dir/extra.json" > "$task_repro_dir/extra.log" 2>&1
python experiments/20261002_mid_blocks/verify_reference.py "$task_repro_dir/submission.py" --cases all --extras --output "$task_repro_dir/reference.json" > "$task_repro_dir/reference.log" 2>&1
python experiments/20261005_goal8929/bracketed_audited.py experiments/20261002_mid_v1/submission.py experiments/20261003_packed_compute/reference_control.py experiments/20261005_goal8929/release_v1/submission.py "$task_repro_dir/submission.py" --cases all --seeds 0 --attempts 12 --repeat 200 --shared-pool --output "$task_repro_dir/full.json" > "$task_repro_dir/full.log" 2>&1
python {research}/audit_release.py --dev "$task_repro_dir/nsa.py" --submission "$task_repro_dir/submission.py" --assembly "$task_repro_dir/assembly.json" --extra "$task_repro_dir/extra.json" --full "$task_repro_dir/full.json"{family_args} --output "$task_repro_dir/audit.json" > "$task_repro_dir/audit.log" 2>&1
printf 'Reports: %s\\n' "$task_repro_dir"
'''
    (release / 'commands.sh').write_text(commands)
    (release / 'commands.sh').chmod(0o755)
    evidence = [p for p in HERE.iterdir() if p.is_file() and p.suffix in ('.py', '.json', '.log')]
    evidence += [baseline, parent, parent.parent / 'release_manifest.json',
                 ROOT / 'experiments/20261005_goal8929/bracketed_audited.py',
                 ROOT / 'experiments/20261005_goal8929/verify_candidate.py',
                 ROOT / 'experiments/20261002_mid_blocks/verify_reference.py',
                 ROOT / 'experiments/20261002_tuning/verify_candidate.py',
                 ROOT / 'experiments/20261001_tuning/verify_release.py',
                 ROOT / 'experiments/20260928_guard_fix/check_restricted_host.py',
                 ROOT / 'experiments/20261003_packed_compute/reference_control.py',
                 ROOT / 'benchmark_nsa.py', ROOT / 'verify_nsa.py', ROOT / 'experiment_bench.py',
                 ROOT / 'kernel_source.py', ROOT / 'test_cases_nsa_fwd.json',
                 ROOT / 'check_submission_nsa.py', ROOT / 'env.sh',
                 ROOT.parent / 'moe/strip_comments.py', ROOT.parent / 'moe/check_submission.py']
    manifest = dict(status='locally validated; official score pending', official_score=None,
        confirmed_baseline_score=88.29, target_score=89.0,
        source_sha256={n: digest(release / n) for n in ('nsa.py', 'submission.py')},
        baseline_sha256=digest(baseline), inherited_release_sha256=digest(parent),
        performance=performance,
        release_files_sha256={p.name: digest(p) for p in sorted(release.iterdir()) if p.is_file()},
        evidence_sha256={str(p.relative_to(ROOT.parent)): digest(p) for p in sorted(set(evidence))})
    (release / 'release_manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print(json.dumps(dict(release=str(release), submission_sha256=digest(sub), performance=performance), indent=2))


if __name__ == '__main__':
    main()
