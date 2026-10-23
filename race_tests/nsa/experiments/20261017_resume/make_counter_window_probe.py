"""Preserve the old collector and qualify event state across successive reads."""
import ast
import hashlib
from pathlib import Path

HERE = Path(__file__).resolve().parent
source = (HERE / "collect_mcpti_events.py").read_text()
begin = source.index("            before_values = None\n")
end = source.index("        finally:\n", begin)
block = '''            row["windows"] = []
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
'''
result = source[:begin] + block + source[end:]
result = result.replace(
    '"""Collect public MCPTI events for unchanged kernels, retaining API failures.\n\nCounter collection is diagnostic and is never mixed with A/B/A timings.\n"""',
    '"""Qualify MCPTI cumulative/reset/stale behavior with 0/1/2/0/4/0 launches.\n\nNo results are interpreted as bandwidth or utilization before qualification.\nDerived from collect_mcpti_events.py SHA256 ' + hashlib.sha256(source.encode()).hexdigest() + '.\n"""', 1)
result = result.replace('method="MCPTI continuous events, one event per group; all domain instances requested"',
                        'method="MCPTI event-state probe: successive 0/1/2/0/4/0 launches in one enabled group; the first read may be stale"')
ast.parse(result)
with (HERE / "qualify_counter_windows.py").open("x") as out:
    out.write(result)
print("Generated event-state probe with original counter collector preserved")
