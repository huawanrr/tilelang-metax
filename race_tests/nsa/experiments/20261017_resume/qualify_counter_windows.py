"""Qualify MCPTI cumulative/reset/stale behavior with 0/1/2/0/4/0 launches.

No results are interpreted as bandwidth or utilization before qualification.
Derived from collect_mcpti_events.py SHA256 f2ed50242b4eb4ee08cfbd0f87cf9ef5431c9240a7926896bc523a462e8419a7.
"""
import argparse
import ctypes as C
import hashlib
import inspect
import json
from pathlib import Path
import sys

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--case", default="oj6")
    p.add_argument("--output", required=True)
    p.add_argument("--module", default=str(HERE / "baseline.py"))
    p.add_argument("--phase", choices=("public", "pack", "attention"), default="public")
    p.add_argument("--repeats", type=int, default=4)
    p.add_argument("--read-single", action="store_true")
    p.add_argument("--differences", action="store_true")
    p.add_argument("--events", default="sm_cta_launched,active_cycles,elapsed_cycles_sm,tensor_pipe_active_cycles_s0,global_load,global_store,shared_ld_bank_conflict,shared_st_bank_conflict,shared_ld_transactions,shared_st_transactions,l2_subp0_total_read_sector_queries,l2_subp0_read_sector_misses,fb_subp0_read_sectors,fb_subp0_write_sectors")
    a = p.parse_args()
    output = Path(a.output)
    assert not output.exists()
    import torch
    sys.path.insert(0, str(ROOT))
    from benchmark_nsa import make_inputs, sparse_reference, check_output
    from experiment_bench import load_module

    pti = C.CDLL("/opt/maca/lib/libmcpti.so")
    runtime = C.CDLL("/opt/maca/lib/libmcruntime.so")
    signatures = {
        "mcptiEventGroupCreate": [C.c_void_p, C.POINTER(C.c_void_p), C.c_uint32],
        "mcptiEventGroupAddEvent": [C.c_void_p, C.c_uint32],
        "mcptiEventGroupSetAttribute": [C.c_void_p, C.c_int, C.c_size_t, C.c_void_p],
        "mcptiEventGroupGetAttribute": [C.c_void_p, C.c_int, C.POINTER(C.c_size_t), C.c_void_p],
        "mcptiEventGroupEnable": [C.c_void_p],
        "mcptiEventGroupDisable": [C.c_void_p],
        "mcptiEventGroupDestroy": [C.c_void_p],
        "mcptiEventGroupReadAllEvents": [C.c_void_p, C.c_int, C.POINTER(C.c_size_t), C.POINTER(C.c_uint64), C.POINTER(C.c_size_t), C.POINTER(C.c_uint32), C.POINTER(C.c_size_t)],
        "mcptiEventGroupReadEvent": [C.c_void_p, C.c_int, C.c_uint32, C.POINTER(C.c_size_t), C.POINTER(C.c_uint64)],
        "mcptiGetResultString": [C.c_int, C.POINTER(C.c_char_p)],
        "mcptiSetEventCollectionMode": [C.c_void_p, C.c_int],
    }
    for name, signature in signatures.items():
        getattr(pti, name).argtypes = signature
        getattr(pti, name).restype = C.c_int
    runtime.mcCtxGetCurrent.argtypes = [C.POINTER(C.c_void_p)]
    runtime.mcCtxGetCurrent.restype = C.c_int
    torch.backends.cuda.matmul.allow_tf32 = False
    module_path = Path(a.module)
    mod = load_module(str(module_path))
    cfg = json.loads((HERE / "cases.json").read_text())[a.case]
    inputs = make_inputs(cfg, 0)
    expected = sparse_reference(*inputs, cfg["block_size"], cfg["is_causal"], 0.1)
    result = torch.empty_like(inputs[0])
    call_args = (*inputs, result, cfg["B"], cfg["SEQ_LEN"], cfg["H"], cfg["HQ"], cfg["D"], cfg["S"], cfg["block_size"], cfg["is_causal"], 0.1)
    mod.run_kernel(*call_args)
    torch.cuda.synchronize()
    execute = lambda: mod.run_kernel(*call_args)
    if a.phase != "public":
        kernel = mod._get_kernel(cfg["B"], cfg["SEQ_LEN"], cfg["H"], cfg["HQ"], cfg["D"], cfg["S"], cfg["block_size"], cfg["is_causal"], 0.1)
        closure = inspect.getclosurevars(kernel).nonlocals
        pack, attention = closure["pack"], closure["attention"]
        q, k, v, indices = inputs
        if "shape" in closure:
            packed = torch.empty(closure["shape"], dtype=k.dtype, device=k.device)
            if "schedule_shape" in closure:
                schedule = torch.empty(closure["schedule_shape"], dtype=torch.int32, device=k.device)
                pack_args, attention_args = (k, v, indices, packed, schedule), (q, packed, schedule, result)
            else:
                pack_args, attention_args = (k, v, packed), (q, packed, indices, result)
        else:
            packed_k = torch.empty(closure["k_shape"], dtype=k.dtype, device=k.device)
            packed_v = torch.empty(closure["v_shape"], dtype=v.dtype, device=v.device)
            pack_args, attention_args = (k, v, packed_k, packed_v), (q, packed_k, packed_v, indices, result)
        pack(*pack_args)
        attention(*attention_args)
        torch.cuda.synchronize()
        execute = (lambda: pack(*pack_args)) if a.phase == "pack" else (lambda: attention(*attention_args))
    ctx = C.c_void_p()
    rc = runtime.mcCtxGetCurrent(C.byref(ctx))
    assert rc == 0 and ctx.value
    catalog = json.loads((HERE / "mcpti_event_catalog.json").read_text())
    events = {e["name"]: dict(e, domain=d["id"]) for d in catalog["domains"] for e in d["events"]}
    report = dict(case=a.case, phase=a.phase, module=str(module_path), repeats=a.repeats,
                  command=sys.argv, profiler_source_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
                  method="MCPTI event-state probe: successive 0/1/2/0/4/0 launches in one enabled group; the first read may be stale",
                  source_sha256=hashlib.sha256(module_path.read_bytes()).hexdigest(),
                  max_abs_error=check_output(result, expected, a.case), rows=[])

    def save():
        output.write_text(json.dumps(report, indent=2) + "\n")

    def call(row, name, *args):
        code = getattr(pti, name)(*args)
        label = C.c_char_p()
        pti.mcptiGetResultString(code, C.byref(label))
        row.setdefault("api", []).append(dict(name=name, code=code, result=label.value.decode() if label.value else ""))
        save()
        return code

    report["collection_mode_code"] = pti.mcptiSetEventCollectionMode(ctx, 0)
    for name in a.events.split(","):
        row = dict(event=events[name])
        report["rows"].append(row)
        group = C.c_void_p()
        if call(row, "mcptiEventGroupCreate", ctx, C.byref(group), 0) != 0:
            print(name, row["api"][-1], flush=True)
            break
        enabled = False
        try:
            if call(row, "mcptiEventGroupAddEvent", group, events[name]["id"]) != 0:
                continue
            all_instances = C.c_uint32(1)
            call(row, "mcptiEventGroupSetAttribute", group, 1, C.sizeof(all_instances), C.byref(all_instances))
            instances = C.c_uint32(0)
            size = C.c_size_t(C.sizeof(instances))
            call(row, "mcptiEventGroupGetAttribute", group, 5, C.byref(size), C.byref(instances))
            row["instances"] = instances.value
            if call(row, "mcptiEventGroupEnable", group) != 0:
                continue
            enabled = True
            row["windows"] = []
            launches = 0
            previous = None
            for executions in (0, 1, 2, 0, 4, 0):
                for _ in range(executions):
                    execute()
                if executions:
                    torch.cuda.synchronize()
                launches += executions
                values = (C.c_uint64 * max(4096, instances.value))()
                value_size = C.c_size_t(C.sizeof(values))
                code = call(row, "mcptiEventGroupReadEvent", group, 0, events[name]["id"], C.byref(value_size), values)
                result_values = list(values)[:value_size.value // C.sizeof(C.c_uint64)]
                window = dict(executions=executions, cumulative_launches=launches,
                              read_code=code, values=result_values, sum=sum(result_values))
                if previous is not None and len(previous) == len(result_values):
                    window["differences"] = [v - p for p, v in zip(previous, result_values)]
                    window["difference_sum"] = sum(window["differences"])
                row["windows"].append(window)
                previous = result_values
                save()
            print(name, [(w["executions"], w["sum"], w.get("difference_sum")) for w in row["windows"]], flush=True)
        finally:
            if enabled:
                call(row, "mcptiEventGroupDisable", group)
            call(row, "mcptiEventGroupDestroy", group)
            save()
            print(name, row.get("difference_sum", row.get("sum")), [(r["name"],r["code"]) for r in row["api"] if r["code"]], flush=True)
    report["post_collection_max_abs_error"] = check_output(result, expected, a.case)
    save()


if __name__ == "__main__":
    main()
