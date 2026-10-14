"""Time each candidate between two baseline replays and retain raw drift data."""
import argparse
import ctypes
import hashlib
import itertools
import json
import math
from pathlib import Path
import statistics
import sys

import torch

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module


@torch.no_grad()
def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('modules', nargs='+')
    p.add_argument('--cases', default='oj6,69,59,83,15')
    p.add_argument('--seeds', default='0,61,2026')
    p.add_argument('--case-file', default=None)
    p.add_argument('--attempts', type=int, default=16)
    p.add_argument('--repeat', type=int, default=100)
    p.add_argument('--max-drift', type=float, default=0.01)
    p.add_argument('--shared-pool', action='store_true')
    p.add_argument('--output', required=True)
    a = p.parse_args()
    torch.backends.cuda.matmul.allow_tf32 = False
    runtime = ctypes.CDLL('/opt/maca/lib/libmcruntime.so')
    pointer = ctypes.c_void_p()
    assert runtime.mcStreamCreate(ctypes.byref(pointer)) == 0
    stream = torch.cuda.ExternalStream(pointer.value)
    torch.cuda.graph.default_capture_stream = stream
    cases = json.loads((ROOT / 'test_cases_nsa_fwd.json').read_text())
    named = {
        'oj6': dict(B=8, SEQ_LEN=1024, H=1, HQ=16, D=128, S=1, block_size=32, is_causal=True),
        'oj12': dict(B=4, SEQ_LEN=1024, H=1, HQ=16, D=64, S=8, block_size=16, is_causal=True),
    }
    named.update(json.loads((ROOT / "experiments/20261003_packed_compute/family_cases.json").read_text()))
    if a.case_file:
        named.update(json.loads(Path(a.case_file).read_text()))
    modules = [load_module(path) for path in a.modules]
    report = dict(command=sys.argv, sha256={x: hashlib.sha256(Path(x).read_bytes()).hexdigest()
                  for x in a.modules}, rows=[], method='A/B/A CUDA graphs, same inputs/output, all launches included', shared_pool=a.shared_pool)
    for case_id, seed in itertools.product(a.cases.split(','), [int(v) for v in a.seeds.split(',')]):
        cfg = named[case_id] if case_id in named else cases[int(case_id) - 1]
        inputs = make_inputs(cfg, seed)
        expected = sparse_reference(*inputs, cfg['block_size'], cfg['is_causal'], 0.1)
        output = torch.empty_like(inputs[0])
        args = (*inputs, output, cfg['B'], cfg['SEQ_LEN'], cfg['H'], cfg['HQ'], cfg['D'],
                cfg['S'], cfg['block_size'], cfg['is_causal'], 0.1)
        graphs, errors = [], []
        pool_handle = torch.cuda.graph_pool_handle() if a.shared_pool else None
        for mod in modules:
            output.fill_(float('nan'))
            mod.run_kernel(*args)
            errors.append(check_output(output, expected, case_id))
            stream.wait_stream(torch.cuda.current_stream())
            stream.synchronize()
            graph = torch.cuda.CUDAGraph()
            with torch.cuda.graph(graph, stream=stream, pool=pool_handle):
                for _ in range(a.repeat):
                    mod.run_kernel(*args)
            graphs.append(graph)

        graph_checks = []
        for graph_index in list(range(len(graphs))) + list(reversed(range(len(graphs)))):
            output.fill_(float('nan'))
            graphs[graph_index].replay()
            torch.cuda.synchronize()
            graph_checks.append(dict(module=graph_index, max_abs_error=check_output(
                output, expected, f'{case_id}:pooled-replay:{graph_index}')))

        def time_graph(g):
            s, e = torch.cuda.Event(enable_timing=True), torch.cuda.Event(enable_timing=True)
            s.record()
            g.replay()
            e.record()
            e.synchronize()
            return s.elapsed_time(e) * 1000 / a.repeat

        for graph in graphs:
            latency = time_graph(graph)
            for _ in range(max(1, math.ceil(40000 / (latency * a.repeat)))):
                graph.replay()
        torch.cuda.synchronize()
        trials = [[] for _ in graphs]
        for attempt in range(a.attempts):
            order = range(1, len(graphs)) if attempt % 2 == 0 else reversed(range(1, len(graphs)))
            for i in order:
                before = time_graph(graphs[0])
                value = time_graph(graphs[i])
                after = time_graph(graphs[0])
                drift = abs(before - after) / statistics.mean([before, after])
                trials[i].append(dict(before_us=before, candidate_us=value, after_us=after,
                    drift=drift, accepted=drift <= a.max_drift,
                    speedup=statistics.mean([before, after]) / value))
        summaries = []
        for values in trials[1:]:
            kept = [v for v in values if v['accepted']]
            summaries.append(dict(accepted=len(kept), total=len(values),
                median_speedup=statistics.median([v['speedup'] for v in kept]) if kept else None,
                median_baseline_us=statistics.median([(v['before_us'] + v['after_us']) / 2 for v in kept]) if kept else None,
                median_candidate_us=statistics.median([v['candidate_us'] for v in kept]) if kept else None))
        row = dict(case=case_id, seed=seed, config=cfg, max_abs_error=errors, graph_checks=graph_checks, summaries=summaries, trials=trials)
        report['rows'].append(row)
        Path(a.output).write_text(json.dumps(report, indent=2) + '\n')
        print(case_id, seed, json.dumps(summaries), flush=True)


if __name__ == '__main__':
    main()
