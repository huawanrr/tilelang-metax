"""Measure the confirmed baseline through its public entry point and both stages."""
import argparse
import hashlib
import inspect
import json
from pathlib import Path
import statistics
import sys

import torch

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(ROOT / "experiments/20261003_packed_compute"))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module
from compare_family import graph_latency


@torch.no_grad()
def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("module")
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    torch.backends.cuda.matmul.allow_tf32 = False
    module = load_module(args.module)
    standard = json.loads((ROOT / "test_cases_nsa_fwd.json").read_text())
    cases = {
        "oj6": dict(B=8, SEQ_LEN=1024, H=1, HQ=16, D=128, S=1, block_size=32, is_causal=True),
        "oj12": dict(B=4, SEQ_LEN=1024, H=1, HQ=16, D=64, S=8, block_size=16, is_causal=True),
        "oj9": dict(B=1, SEQ_LEN=8192, H=1, HQ=16, D=64, S=1, block_size=16, is_causal=True),
        **{str(i): standard[i-1] for i in (69, 83, 59)},
    }
    report = dict(module=args.module, source_sha256=hashlib.sha256(Path(args.module).read_bytes()).hexdigest(),
                  torch=torch.__version__, device=str(torch.cuda.get_device_properties(0)),
                  repeat=200, samples=7, rounds=4, rows=[])
    for name, cfg in cases.items():
        q, k, v, indices = make_inputs(cfg, seed=0)
        output = torch.empty_like(q)
        def public():
            module.run_kernel(q, k, v, indices, output, cfg['B'], cfg['SEQ_LEN'], cfg['H'], cfg['HQ'],
                              cfg['D'], cfg['S'], cfg['block_size'], cfg['is_causal'], 0.1)
        public()
        expected = sparse_reference(q, k, v, indices, cfg['block_size'], cfg['is_causal'], 0.1)
        error = check_output(output, expected, name)
        compiled = next(reversed(module._KERNEL_CACHE.values()))
        launches = [('public', public), ('copy_q_to_output_floor', lambda: output.copy_(q))]
        source_hashes = []
        if inspect.isfunction(compiled):
            captured = inspect.getclosurevars(compiled).nonlocals
            pack, attention = captured['pack'], captured['attention']
            pk = torch.empty(captured['k_shape'], device=k.device, dtype=k.dtype)
            pv = torch.empty(captured['v_shape'], device=v.device, dtype=v.dtype)
            def packing():
                pack(k, v, pk, pv)
            def attending():
                attention(q, pk, pv, indices, output)
            packing()
            attending()
            check_output(output, expected, name + ':separate')
            launches.extend([('pack', packing), ('attention', attending)])
            parts = [pack, attention]
        else:
            parts = [compiled]
        for i, part in enumerate(parts):
            source = part.get_kernel_source()
            source_hashes.append(hashlib.sha256(source.encode()).hexdigest())
            Path(args.output).with_name(f'baseline_{name}_part{i}.cpp').write_text(source)
        timings = [[] for _ in launches]
        for r in range(4):
            order = range(len(launches)) if r % 2 == 0 else reversed(range(len(launches)))
            for i in order:
                timings[i].append(graph_latency(launches[i][1], repeat=200, samples=7) * 1000)
        row = dict(case=name, config=cfg, max_abs_error=error, source_hashes=source_hashes,
                   us={n: statistics.median(t) for (n, _), t in zip(launches, timings)},
                   rounds_us={n: t for (n, _), t in zip(launches, timings)},
                   note='Attention-only reuses packed inputs for attribution; public timing includes fresh packing every call. Copy is only a Q/output traffic lower bound.')
        report['rows'].append(row)
        Path(args.output).write_text(json.dumps(report, indent=2) + '\n')
        print(json.dumps(row), flush=True)


if __name__ == '__main__':
    main()
