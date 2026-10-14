"""Adversarial inputs, public interfaces, live graph inputs and restricted host checks for S2."""
import argparse
import ctypes
import hashlib
import importlib.util
import inspect
import json
from pathlib import Path
import sys

import torch

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from benchmark_nsa import make_inputs, sparse_reference, check_output
from experiment_bench import load_module

spec = importlib.util.spec_from_file_location('nsa_s2_guard_helpers',
    ROOT / 'experiments/20261005_goal8929/verify_candidate.py')
helpers = importlib.util.module_from_spec(spec)
spec.loader.exec_module(helpers)


def config(b, n, h=1, causal=True):
    return dict(B=b, SEQ_LEN=n, H=h, HQ=h*16, D=64, S=2, block_size=16, is_causal=causal)


def adversarial(cfg, extreme=False, expanded=False):
    n, bs = cfg['SEQ_LEN'], cfg['block_size']
    nb = (n+bs-1)//bs
    pairs = [[0, 0], [-1, -1], [nb, nb], [nb-1, 0], [0, nb-1], [1, 0], [nb-1, nb-1], [-1, 0]]
    if extreme:
        pairs += [[v, 0] for v in (-2147483648, 2147483647, -268435456, 268435456)]
        pairs += [[v, v] for v in (-2147483648, 2147483647)]
    table = torch.tensor(pairs, dtype=torch.int64, device='cuda')
    indices = table[torch.arange(n, device='cuda') % len(pairs)].view(1, n, 1, 2)
    indices = indices.expand(cfg['B'], n, cfg['H'], 2)
    return indices if expanded else indices.to(torch.int32).contiguous()


def args_for(inputs, out, cfg, scale):
    return (*inputs, out, cfg['B'], cfg['SEQ_LEN'], cfg['H'], cfg['HQ'], cfg['D'],
            cfg['S'], cfg['block_size'], cfg['is_causal'], scale)


def parts(kernel):
    if inspect.isfunction(kernel):
        values = inspect.getclosurevars(kernel).nonlocals
        if 'pack' in values and 'attention' in values:
            return [values['pack'], values['attention']]
    return [kernel]


def device_hashes(kernel):
    return [hashlib.sha256(k.get_kernel_source().encode()).hexdigest() for k in parts(kernel)]


@torch.no_grad()
def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('module')
    parser.add_argument('--output', required=True)
    args = parser.parse_args()
    module = load_module(args.module)
    baseline = load_module(str(ROOT / 'experiments/20261002_mid_v1/submission.py'))
    for entry in ('native_sparse_attention', 'run_kernel'):
        assert inspect.signature(getattr(module, entry)) == inspect.signature(getattr(baseline, entry))
    torch.backends.cuda.matmul.allow_tf32 = False
    report = dict(status='running', command=sys.argv,
                  source_sha256=hashlib.sha256(Path(args.module).read_bytes()).hexdigest(),
                  harness_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  reference_matmul_tf32=False, official_sandbox=False,
                  edge_cases=[], tuning=[], live_updates=[], restricted_host=[])
    destination = Path(args.output)

    def save():
        destination.write_text(json.dumps(report, indent=2) + '\n')

    def verify(mod, cfg, scale, inputs, label):
        expected = sparse_reference(*inputs, cfg['block_size'], cfg['is_causal'], scale)
        output = torch.full_like(inputs[0], float('nan'))
        mod.run_kernel(*args_for(inputs, output, cfg, scale))
        error = check_output(output, expected, label + ':run_kernel')
        factory = mod.native_sparse_attention(cfg['B'], cfg['HQ'], cfg['SEQ_LEN'], cfg['D'],
            cfg['is_causal'], scale=scale, block_size=cfg['block_size'], groups=16, selected_blocks=2)
        factory_error = check_output(factory(*inputs), expected, label + ':factory')
        return max(error, factory_error)

    cases = [config(1, 127), config(1, 128), config(1, 255), config(1, 256),
             config(2, 511), config(2, 512), config(2, 767), config(2, 768),
             config(1, 1535), config(1, 1536), config(1, 2047), config(1, 2048),
             config(4, 1023), config(4, 1024), config(4, 1025),
             config(1, 1024, 2), config(2, 1024, 2), config(1, 512, 4)]
    cases += [config(2, 768, causal=False), config(4, 1024, causal=False), config(4, 1025, causal=False)]
    cases += [config(12, 127), config(12, 128), config(12, 129),
              config(16, 127), config(16, 128), config(16, 129),
              config(8, 191), config(8, 192), config(8, 193),
              config(1, 384, 4), config(1, 192, 8), config(1, 128, 16),
              config(1, 3071), config(1, 3072), config(1, 3073)]
    for index, cfg in enumerate(cases):
        inputs = list(make_inputs(cfg, seed=61))
        inputs[3] = adversarial(cfg, expanded=index % 3 == 0)
        error = verify(module, cfg, 0.1, inputs, f'edge{index}')
        row = dict(config=cfg, scale=0.1, expanded=index % 3 == 0, max_abs_error=error)
        report['edge_cases'].append(row)
        print('edge', index, cfg, error, flush=True)
        save()
    for cfg in (config(2, 768), config(4, 1024), config(4, 1024, causal=False)):
        for scale in (None, 0.0, -0.1, 0.03125, 0.1):
            inputs = list(make_inputs(cfg, seed=2026))
            inputs[3] = adversarial(cfg, extreme=True, expanded=True)
            error = verify(module, cfg, scale, inputs, 'extreme')
            report['edge_cases'].append(dict(config=cfg, scale=scale, extreme=True,
                                             expanded=True, max_abs_error=error))
            print('extreme', cfg, scale, error, flush=True)
            save()

    overrides = [dict(stage_regs=False), dict(kv_reuse=False), dict(o_stage=True),
                 dict(q_preload=False), dict(q_frag=False), dict(nmax=False),
                 dict(num_stages=2), dict(online_unroll=1), dict(min_blocks=1),
                 dict(pair=2), dict(late_normalize=True), dict(threads=128),
                 dict(kv_split=True), dict(q_frag_online=False)]
    for cfg in (config(2, 768), config(4, 1024)):
        for override in overrides:
            common = (cfg['B'], cfg['SEQ_LEN'], cfg['H'], cfg['HQ'], cfg['D'],
                      cfg['S'], cfg['block_size'], cfg['is_causal'], 0.1)
            outcomes = []
            for mod in (baseline, module):
                try:
                    kernel = mod._get_kernel(*common, **override)
                    outcomes.append(dict(device_sha256=device_hashes(kernel),
                        compile_flags=[list(k.compile_flags or []) for k in parts(kernel)]))
                except Exception as error:
                    outcomes.append(dict(error_type=type(error).__name__, error=str(error)))
            if 'device_sha256' in outcomes[0]:
                assert outcomes[0] == outcomes[1], (cfg, override, outcomes)
            else:
                assert outcomes[0]['error_type'] == outcomes[1].get('error_type'), (cfg, override, outcomes)
                assert outcomes[0]['error'].splitlines()[-1] == outcomes[1]['error'].splitlines()[-1]
            report['tuning'].append(dict(config=cfg, override=override, outcomes=outcomes))
            save()

    runtime = ctypes.CDLL('/opt/maca/lib/libmcruntime.so')
    pointer = ctypes.c_void_p()
    assert runtime.mcStreamCreate(ctypes.byref(pointer)) == 0
    stream = torch.cuda.ExternalStream(pointer.value)
    torch.cuda.graph.default_capture_stream = stream
    for cfg in (config(2, 768), config(4, 1024)):
        inputs = list(make_inputs(cfg, seed=4))
        output = torch.empty_like(inputs[0])
        call_args = args_for(inputs, output, cfg, 0.1)
        module.run_kernel(*call_args)
        stream.wait_stream(torch.cuda.current_stream())
        stream.synchronize()
        graph = torch.cuda.CUDAGraph()
        with torch.cuda.graph(graph, stream=stream):
            module.run_kernel(*call_args)
        for step, which in enumerate((0, 1, 2, 3, 0, 3)):
            if which < 3:
                inputs[which].copy_(make_inputs(cfg, seed=300+step)[which])
            else:
                inputs[3].copy_(adversarial(cfg, extreme=step == 5))
            expected = sparse_reference(*inputs, cfg['block_size'], cfg['is_causal'], 0.1)
            output.fill_(float('nan'))
            graph.replay()
            torch.cuda.synchronize()
            error = check_output(output, expected, 'live_graph')
            report['live_updates'].append(dict(config=cfg, step=step, changed_input=which, max_abs_error=error))
            save()
        del graph

    restricted = helpers.guarded_module(Path(args.module).resolve())
    for cfg in (config(2, 768), config(4, 1024), config(4, 1024, causal=False)):
        inputs = list(make_inputs(cfg, seed=401))
        inputs[3] = adversarial(cfg, extreme=True, expanded=True)
        error = verify(restricted, cfg, 0.1, inputs, 'restricted')
        report['restricted_host'].append(dict(config=cfg, max_abs_error=error))
        save()
    report['status'] = 'PASS'
    save()
    print('PASS', len(report['edge_cases']), 'edges;', len(report['tuning']), 'tuning;',
          len(report['live_updates']), 'live updates;', len(report['restricted_host']), 'restricted host cases', flush=True)


if __name__ == '__main__':
    main()
