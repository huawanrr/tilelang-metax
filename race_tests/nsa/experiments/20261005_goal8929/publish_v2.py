"""Freeze the verified combined candidate and its reproduction commands."""
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


def read(name):
    return json.loads((HERE / name).read_text())


def aggregate(rows, field):
    values = [r['summaries'][field]['median_speedup'] for r in rows]
    assert all(v is not None and v > 0 for v in values)
    return dict(count=len(values), geomean=math.exp(statistics.mean(map(math.log, values))),
                minimum=min(values), maximum=max(values))


def main():
    dev, sub = HERE / 'candidate_combined_v2.py', HERE / 'candidate_v2_submission.py'
    baseline = ROOT / 'experiments/20261002_mid_v1/submission.py'
    assert digest(baseline) == 'ee780d62a64e427d742db494596feffd0f3f9834e4587cad61a66713f2936c31'
    assembly = read('candidate_combined_v2_assembly.json')
    assert assembly['candidate_sha256'] == digest(dev)
    full = read('candidate_v2_full.json')
    checks = read('candidate_v2_checks_resumed.json')
    reference = read('candidate_v2_reference.json')
    audit = read('candidate_v2_source_audit.json')
    assert len(full['rows']) == 109
    assert len(reference) == 125 and all(r['status'] == 'PASS' for r in reference)
    assert checks['status'] == audit['status'] == 'PASS'
    assert checks['module_sha256'] == digest(dev)
    assert len(checks['boundaries']) == 35 and len(checks['extremes']) == 6
    assert len(checks['fallbacks']) == 44 and len(checks['unsupported']) == 4
    assert len(checks['unsupported_shapes']) == 1
    assert len(checks['refresh']) == 18 and len(checks['guarded']) == 6
    assert len(audit['full']) == 109 and len(audit['families']) == 67 and len(audit['guarded']) == 6
    for path, expected in full['sha256'].items():
        assert digest(ROOT / path) == expected
    for path, expected in audit['source_sha256'].items():
        assert digest(ROOT / path) == expected
    changed_names = [r['case'] for r in audit['full'] if not r['baseline_equal']]
    changed = [r for r in full['rows'] if r['case'] in changed_names]
    unchanged = [r for r in full['rows'] if r['case'] not in changed_names]
    performance = dict(all=aggregate(full['rows'], -1), changed=aggregate(changed, -1),
        unchanged=aggregate(unchanged, -1), control=aggregate(full['rows'], 0),
        changed_cases=changed_names,
        max_abs_error=max(max(r['max_abs_error']) for r in full['rows']),
        max_reference_error=max(r['max_abs_error'] for r in reference),
        raw_reports_keep_all_drift_rejects=True)

    release = HERE / 'release_v1'
    release.mkdir(exist_ok=False)
    files = {
        'candidate_combined_v2.py': 'nsa.py', 'candidate_v2_submission.py': 'submission.py',
        'candidate_combined_v2_assembly.json': 'assembly.json',
        'candidate_v2_full.json': 'full.json', 'candidate_v2_checks_resumed.json': 'checks.json',
        'candidate_v2_reference.json': 'reference.json',
        'candidate_v2_source_audit.json': 'source_audit.json',
        'candidate_v2_split_layout.json': 'split_layout_proof.json',
        'candidate_v2_host_ast.json': 'host_ast.json',
        'small_s8_summary.json': 'small_s8_summary.json',
        's4_v1_conservative_summary.json': 's4_summary.json',
    }
    for source, target in files.items():
        shutil.copyfile(HERE / source, release / target)
    (release / 'performance.json').write_text(json.dumps(performance, indent=2) + '\n')
    rows = '\n'.join(f"| {r['case']} | {r['config']['S']} | "
        f"{r['summaries'][-1]['median_baseline_us']:.3f} | "
        f"{r['summaries'][-1]['median_candidate_us']:.3f} | "
        f"{r['summaries'][-1]['median_speedup']:.5f}× |" for r in changed)
    readme = f'''# NSA S4 / 小 S8 候选（2026-10-05）

可评测文件：`submission.py`。开发源码：`nsa.py`。
本版已完成本地验证，正式已确认基线仍为 **88.29**，目标 **89.29 尚未验证**。
提交 SHA256：`{digest(sub)}`。

相对 `experiments/20261002_mid_v1/submission.py`，只在默认 D64/BS16/G16 路径新增：

- S8：SEQ_LEN >= 128 且 B*H*SEQ_LEN <= 512，由两组 64 线程分摊选中块，合并 FP32 部分和。
- S4：H=1、SEQ_LEN >= 256 且 B*H*SEQ_LEN >= 2048，打包输入并合并输出写入。

每次调用均重新读取和打包输入。保持两个公开接口；其他路径及显式调参保留基线。
无异步拷贝、外部设备代码、跨调用输入或结果缓存、后端改动，未关闭 race/bounds 检查。

109 例同轮 A/B/A 对照，每图 200 调用，每例 12 组，共用图内存池；只改变以下 2 例设备码：

| 本地用例 | S | 基线 μs | 候选 μs | 加速比 |
|---|---:|---:|---:|---:|
{rows}

全部 109 例几何平均 **{performance['all']['geomean']:.8f}×**，
107 个未改用例为 **{performance['unchanged']['geomean']:.8f}×**。
不要把两个形状的收益当成全量收益，或将本地加速比换算成正式分数。
全部原始样本、对照波动和漂移拒绝记录保留在 `full.json`。

扩展多种子复测：小 S8 启用范围 45 组全部加速，平均 1.10068×；
大 S4 启用范围 48 组全部加速，平均 1.11826×。
S4 小网格的负结果保存在上级研究目录，因此未采用初版的宽范围分派。

验证通过：125 例严格 FP32 双接口、35 个边界、6 组极端索引、44 项调参回退、
18 次同地址输入更新与图重放、6 组开发版及 6 组提交版 RestrictedPython host guard。
另有 5 项配置保持基线的不支持结果，明确记录在 `checks.json`。
109 例实际计时设备代码和 67 个家族形状已核对开发版、提交版及已测 probe/基线等价。
最大参考绝对误差 {performance['max_reference_error']}。本地 host guard 不等同于完整官方沙箱。

从 `race_tests/nsa` 运行 `bash {release.relative_to(ROOT)}/commands.sh` 可在新临时目录复现。
文件及证据哈希见 `release_manifest.json`。
'''
    (release / 'README.md').write_text(readme)
    relative = release.relative_to(ROOT)
    research = HERE.relative_to(ROOT)
    commands = f'''#!/usr/bin/env bash
# Run from race_tests/nsa. GPU jobs are sequential.
set -eo pipefail
source env.sh
task_repro_dir=$(mktemp -d {research}/repro.XXXXXX)
cp {relative}/nsa.py {relative}/submission.py {relative}/assembly.json "$task_repro_dir/"
python check_submission_nsa.py "$task_repro_dir/nsa.py" "$task_repro_dir/submission.py"
python {research}/bracketed_audited.py experiments/20261002_mid_v1/submission.py experiments/20261003_packed_compute/reference_control.py "$task_repro_dir/submission.py" --cases all --seeds 0 --attempts 12 --repeat 200 --shared-pool --output "$task_repro_dir/full.json" > "$task_repro_dir/full.log" 2>&1
python {research}/verify_candidate.py "$task_repro_dir/nsa.py" --assembly "$task_repro_dir/assembly.json" --output "$task_repro_dir/checks.json" > "$task_repro_dir/checks.log" 2>&1
python experiments/20261002_mid_blocks/verify_reference.py "$task_repro_dir/submission.py" --cases all --extras --output "$task_repro_dir/reference.json" > "$task_repro_dir/reference.log" 2>&1
python {research}/audit_candidate.py --dev "$task_repro_dir/nsa.py" --submission "$task_repro_dir/submission.py" --assembly "$task_repro_dir/assembly.json" --full "$task_repro_dir/full.json" --checks "$task_repro_dir/checks.json" --output "$task_repro_dir/source_audit.json" > "$task_repro_dir/source_audit.log" 2>&1
python {research}/check_split_layout.py "$task_repro_dir/nsa.py" --output "$task_repro_dir/layout.json"
printf 'Reports: %s\\n' "$task_repro_dir"
'''
    (release / 'commands.sh').write_text(commands)
    (release / 'commands.sh').chmod(0o755)
    evidence = [HERE / path for path in files]
    evidence += [HERE / name for name in (
        'candidate_v2_checks.json', 'candidate_v2_checks.log', 'candidate_v2_checks_resumed.log',
        'candidate_v2_full.log', 'candidate_v2_reference.log', 'candidate_v2_source_audit.log',
        'small_s8_pool_full.json', 's4_candidate_multiseed.json',
        's4_raw_guard_screen.json', 's8_value_lookahead_screen.json', 's8_grid_screen.json',
        'candidate_small_s8.py', 'candidate_combined_v1.py',
        'make_small_candidate.py', 'make_combined_candidate.py', 'make_combined_v2.py',
        'bracketed_audited.py', 'bracketed_pool_checked.py', 'verify_candidate.py',
        'audit_candidate.py', 'check_split_layout.py', 'summarize_bracketed.py', 'publish_v2.py')]
    evidence += [ROOT / name for name in (
        'benchmark_nsa.py', 'verify_nsa.py', 'experiment_bench.py', 'kernel_source.py',
        'test_cases_nsa_fwd.json', 'check_submission_nsa.py', 'env.sh',
        'experiments/20261002_mid_blocks/verify_reference.py',
        'experiments/20261002_tuning/verify_candidate.py',
        'experiments/20261001_tuning/verify_release.py',
        'experiments/20260928_guard_fix/check_restricted_host.py',
        'experiments/20261002_mid_v1/nsa.py', 'experiments/20261002_mid_v1/submission.py',
        'experiments/20261004_goal89/split_s8_w2_fp32_balanced.py',
        'experiments/20261003_packed_compute/reference_control.py')]
    evidence += [ROOT.parent / 'moe/strip_comments.py', ROOT.parent / 'moe/check_submission.py']
    manifest = dict(status='locally validated; official score pending', official_score=None,
        confirmed_baseline_score=88.29, target_score=89.29,
        source_sha256={name: digest(release / name) for name in ('nsa.py', 'submission.py')},
        baseline_sha256=digest(baseline), performance=performance,
        release_files_sha256={p.name: digest(p) for p in sorted(release.iterdir()) if p.is_file()},
        evidence_sha256={str(p.relative_to(ROOT.parent)): digest(p) for p in sorted(set(evidence))})
    (release / 'release_manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    assert digest(release / 'nsa.py') == digest(dev)
    assert digest(release / 'submission.py') == digest(sub)
    print(json.dumps(dict(release=str(release), submission_sha256=digest(sub),
        performance=performance, official_score=None), indent=2))


if __name__ == '__main__':
    main()
