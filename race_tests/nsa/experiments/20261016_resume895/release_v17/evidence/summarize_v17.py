"""Require correctness, exact device correspondence, and unfiltered timings."""
import ast
import hashlib
import json
import math
from pathlib import Path
import statistics

HERE = Path(__file__).resolve().parent
VALIDATION = HERE / 'validation_v17'


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def read(path):
    return json.loads(path.read_text())


def gm(values):
    return math.exp(statistics.mean(math.log(x) for x in values))


def modules_unchanged(report):
    for name, digest in report['sha256'].items():
        assert sha(Path(name)) == digest, name


def summarize(values):
    return dict(rows=values, geomean=gm([x['speedup'] for x in values]),
                control_geomean=gm([x['control_speedup'] for x in values]),
                regressions=[x for x in values if x['speedup'] < 1])


def main():
    manifest = read(HERE/'candidate_manifest.json')
    assert manifest['candidate_sha256'] == sha(HERE/'candidate_v17.py')
    assert manifest['parent_sha256'] == sha(HERE/'baseline.py')
    status = read(VALIDATION/'status.json')
    assert status['status'] == 'PASS' and all(x['status']=='PASS' for x in status['stages'])
    checked = read(VALIDATION/'changed_reference.json')
    assert checked['status']=='PASS' and checked['candidate_sha256']==manifest['candidate_sha256']
    reference = read(VALIDATION/'full_reference_fp32.json')
    reference_meta = read(VALIDATION/'full_reference_fp32.metadata.json')
    assert reference_meta['status']=='PASS' and reference_meta['reference_matmul_tf32'] is False
    assert reference_meta['candidate_sha256']==manifest['candidate_sha256']
    assert reference_meta['report_sha256']==sha(VALIDATION/'full_reference_fp32.json')
    assert len(reference)==125 and all(x['status']=='PASS' for x in reference)
    binaries = read(VALIDATION/'binary/report.json')
    assert len(binaries['rows'])==23
    active = None
    for row in binaries['rows']:
        parent, probe, candidate = row['modules']
        for module in row['modules']:
            assert sha(Path(module['path']))==module['sha256']
        expected = probe if row['case']=='oj1' else parent
        assert len(candidate['parts'])==len(expected['parts'])
        for actual, other in zip(candidate['parts'],expected['parts']):
            for key in ['device_source_sha256','compile_flags','resources']:
                assert actual[key]==other[key],(row['case'],key)
            assert actual['sections']['.text']==other['sections']['.text']
        if row['case']=='oj1':
            active=row
            assert candidate['parts'][0]['sections']['.text']!=parent['parts'][0]['sections']['.text']
    hot=[]
    for path in [HERE/'followup_storage.json',VALIDATION/'storage_2026.json']:
        data=read(path);modules_unchanged(data)
        for row in data['rows']:
            if row['base_case']!='oj1':continue
            assert row['device_source_sha256'][0]==[active['modules'][0]['parts'][0]['device_source_sha256']]
            assert row['device_source_sha256'][2]==[active['modules'][2]['parts'][0]['device_source_sha256']]
            values=[x['speedup'] for x in row['trials'][2]]
            hot.append(dict(evidence=str(path.relative_to(HERE)),case=row['case'],seed=row['seed'],
                            speedup=statistics.median(values),
                            control_speedup=statistics.median(x['speedup'] for x in row['trials'][1]),
                            accepted=sum(x['accepted'] for x in row['trials'][2]),trials=len(values),
                            max_abs_error=row['max_abs_error'][2]))
    assert len(hot)==24 and {x['seed'] for x in hot}=={0,61,2026}
    cold=[]
    for seed,path in [(0,HERE/'pow2_cold_seed0.json'),(61,HERE/'followup_cold_seed61.json'),
                      (2026,VALIDATION/'cold_2026.json')]:
        data=read(path);modules_unchanged(data)
        row=next(x for x in data['rows'] if x['case']=='oj1')
        for records in row['records']:
            assert all(len(r['kernel_events'])==r['expected_kernels'] for r in records)
        cold.append(dict(evidence=str(path.relative_to(HERE)),seed=seed,
                         baseline_us=row['median_kernel_us'][0],candidate_us=row['median_kernel_us'][2],
                         speedup=row['speedup'][2],control_speedup=row['speedup'][1],
                         max_abs_error=row['max_abs_error'][2]))
    # Earlier cold modules share the exact changed function and its dependencies.
    names=['native_sparse_attention_q_preload_vfirst','_d32_rsqrt_reciprocal','_emitters']
    functions=[]
    for path in [HERE/'candidate_v17.py',HERE/'pow2_d32_s4.py',HERE.parent/'20261016_pow2/pow2_all.py']:
        tree={n.name:n for n in ast.parse(path.read_text()).body if isinstance(n,ast.FunctionDef)}
        functions.append({n:ast.dump(tree[n]) for n in names})
    assert functions[0]==functions[1]==functions[2]
    confirmation=[]
    assert read(HERE/'confirmation_status.json')['status']=='PASS'
    for seed in [2026,73]:
        path=HERE/f'cold_confirm_seed{seed}.json'
        data=read(path);modules_unchanged(data)
        row=data['rows'][0]
        confirmation.append(dict(evidence=path.name,seed=seed,baseline_us=row['median_kernel_us'][0],
            candidate_us=row['median_kernel_us'][2],speedup=row['speedup'][2],control_speedup=row['speedup'][1]))
    adjacent_data=read(HERE/'cold_adjacent.json');modules_unchanged(adjacent_data)
    assert len(adjacent_data['rows'])==3
    adjacent=[]
    for row in adjacent_data['rows']:
        assert row['device_source_sha256'][2]==active['modules'][2]['parts'][0]['device_source_sha256']
        control,candidate=row['summaries']
        assert control['trials']==candidate['trials']==256
        assert candidate['median_speedup']>1 and candidate['ratio_of_summed_times']>1
        adjacent.append(dict(seed=row['seed'],trials=256,speedup=candidate['ratio_of_summed_times'],
            control_speedup=control['ratio_of_summed_times'],median_speedup=candidate['median_speedup'],
            control_median_speedup=control['median_speedup']))
    numeric=read(VALIDATION/'scalar_math/math.json')
    assert numeric['status']=='PASS'
    numeric_row=next(x for x in numeric['rows'] if x['mode']=='pow2')
    assert numeric_row['differing_elements_from_exp2']==0
    counts={k:len(checked[k]) for k in ['boundaries','scales','zero_inputs','live','restricted','cache_orders']}
    report=dict(status='PASS',candidate_sha256=manifest['candidate_sha256'],parent_v16_sha256=manifest['parent_sha256'],
                changed_functions=manifest['changed_functions'],unchanged_original_functions=74,
                public_and_dispatch_ast_unchanged=True,hot=summarize(hot),cold=summarize(cold),
                cold_warm_confirmation=summarize(confirmation),cold_adjacent=summarize(adjacent),
                correctness=dict(full_reference_cases=125,**counts,
                    maximum_full_reference_error=max(x['max_abs_error'] for x in reference),
                    scalar_pow_inputs=numeric['inputs'],scalar_pow_max_relative_error=numeric_row['max_normal_relative_error']),
                binary=dict(configurations=23,modules=3,changed_oj=['oj1'],
                    unchanged_oj=[f'oj{i}' for i in range(2,15)],
                    active_resources=active['modules'][2]['parts'][0]['resources'],
                    active_text=active['modules'][2]['parts'][0]['sections']['.text']),
                official=dict(last_user_confirmed_score=89,target=89.5,v15_status='User reported OJ still running',
                    v17_score=None,target_verified=False),
                limits='Performance evidence is OJ1 only. Full reference explicitly disables TF32 after helper imports. Original full_reference.json used the historical default and is superseded by full_reference_fp32.json. Grouped cold profiles have substantial same-source drift, including one negative fixed-confirmation row; do not claim the noisy 15.4 percent as a reliable gain. Adjacent cold A/B/A is the primary cold result; all earlier results and controls are retained. No new overall/official score is inferred.',
                evidence_sha256={})
    assert report['hot']['geomean']>1 and report['cold']['geomean']>1
    assert not report['cold']['regressions']
    paths=[HERE/'candidate_v17.py',HERE/'baseline.py',HERE/'control.py',HERE/'candidate_manifest.json',
           HERE/'followup_storage.json',HERE/'pow2_cold_seed0.json',HERE/'followup_cold_seed61.json',
           VALIDATION/'status.json',VALIDATION/'changed_reference.json',VALIDATION/'full_reference.json',
           VALIDATION/'full_reference_fp32.json',VALIDATION/'full_reference_fp32.metadata.json',
           VALIDATION/'binary/report.json',VALIDATION/'storage_2026.json',VALIDATION/'cold_2026.json',
           HERE/'confirmation_plan.json',HERE/'confirmation_status.json',HERE/'cold_confirm_seed2026.json',
           HERE/'cold_confirm_seed73.json',HERE/'cold_adjacent.json',
           VALIDATION/'scalar_math/math.json']
    report['evidence_sha256']={str(p.relative_to(HERE)):sha(p) for p in paths}
    with (HERE/'final_v17_summary.json').open('x') as out:
        json.dump(report,out,indent=2);out.write('\n')
    print('PASS','hot',report['hot']['geomean'],'cold',report['cold']['geomean'],
          'hot regressions',len(report['hot']['regressions']))


if __name__=='__main__':
    main()
