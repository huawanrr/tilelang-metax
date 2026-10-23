"""Adjacent A/B/A calls in one device trace, with L2 flushed before every call."""
import argparse
import hashlib
import json
from pathlib import Path
import random
import statistics
import sys

import torch

ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from benchmark_nsa import check_output,make_inputs,sparse_reference
from experiment_bench import load_module


@torch.no_grad()
def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('modules',nargs='+')
    parser.add_argument('--case-file',required=True)
    parser.add_argument('--case',default='oj1')
    parser.add_argument('--seeds',default='0,61,2026')
    parser.add_argument('--rounds',type=int,default=4)
    parser.add_argument('--trials',type=int,default=64)
    parser.add_argument('--output',required=True)
    args=parser.parse_args()
    destination=Path(args.output)
    assert not destination.exists()
    torch.backends.cuda.matmul.allow_tf32=False
    modules=[load_module(path) for path in args.modules]
    cfg=json.loads(Path(args.case_file).read_text())[args.case]
    cache=torch.empty(64000000,device='cuda',dtype=torch.int32)
    report=dict(command=sys.argv,method='Cold per-invocation A/B/A, adjacent calls within one device-profiler trace; randomized candidate order; 256 MB flush before every A and B; all trials retained',
                sha256={p:hashlib.sha256(Path(p).read_bytes()).hexdigest() for p in args.modules},
                flush_bytes=cache.numel()*cache.element_size(),rows=[])
    for seed in map(int,args.seeds.split(',')):
        inputs=make_inputs(cfg,seed)
        expected=sparse_reference(*inputs,cfg['block_size'],cfg['is_causal'],0.1)
        output=torch.empty_like(inputs[0])
        shape=(cfg['B'],cfg['SEQ_LEN'],cfg['H'],cfg['HQ'],cfg['D'],cfg['S'],cfg['block_size'],cfg['is_causal'],0.1)
        calls=(*inputs,output,*shape)
        sources=[];errors=[]
        for module in modules:
            output.fill_(float('nan'));module.run_kernel(*calls)
            errors.append(check_output(output,expected,args.case))
            kernel=module._get_kernel(*shape)
            # This diagnostic intentionally covers single-launch paths only.
            sources.append(hashlib.sha256(kernel.get_kernel_source().encode()).hexdigest())
        for i in range(192):
            cache.zero_();modules[i%len(modules)].run_kernel(*calls)
        torch.cuda.synchronize()
        rng=random.Random(0x414241+seed)
        trials=[[] for _ in modules];round_records=[]
        for round_index in range(args.rounds):
            schedule=[]
            for attempt in range(args.trials):
                order=list(range(1,len(modules)));rng.shuffle(order)
                schedule.extend(order)
            with torch.profiler.profile(activities=[torch.profiler.ProfilerActivity.CUDA]) as prof:
                for index in schedule:
                    for slot in (0,index,0):
                        cache.zero_();modules[slot].run_kernel(*calls)
                torch.cuda.synchronize()
            events=sorted([e for e in prof.events() if 'CUDA' in str(e.device_type)
                           and 'kernel_kernel' in e.name],key=lambda e:e.time_range.start)
            assert len(events)==3*len(schedule),(len(events),len(schedule))
            raw=[]
            for event in events:
                raw.append(dict(name=event.name,start_us=event.time_range.start,
                                duration_us=event.device_time_total))
            for attempt,index in enumerate(schedule):
                before,value,after=[e.device_time_total for e in events[3*attempt:3*attempt+3]]
                baseline=(before+after)/2
                trials[index].append(dict(round=round_index,attempt=attempt,before_us=before,
                    candidate_us=value,after_us=after,drift=abs(before-after)/baseline,
                    speedup=baseline/value))
            round_records.append(dict(round=round_index,candidate_order=schedule,kernel_events=raw))
            print('round',seed,round_index,[statistics.median(t['speedup'] for t in x) for x in trials[1:]],flush=True)
        summaries=[]
        for group in trials[1:]:
            summaries.append(dict(trials=len(group),median_speedup=statistics.median(t['speedup'] for t in group),
                ratio_of_summed_times=sum((t['before_us']+t['after_us'])/2 for t in group)/sum(t['candidate_us'] for t in group),
                median_candidate_us=statistics.median(t['candidate_us'] for t in group),
                median_baseline_us=statistics.median((t['before_us']+t['after_us'])/2 for t in group)))
        row=dict(case=args.case,seed=seed,config=cfg,max_abs_error=errors,
                 device_source_sha256=sources,trials=trials,summaries=summaries,round_records=round_records)
        report['rows'].append(row)
        destination.write_text(json.dumps(report,indent=2)+'\n')
        print('SUMMARY',seed,summaries,flush=True)


if __name__=='__main__':
    main()
