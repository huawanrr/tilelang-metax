"""Compare raw-index handling against FP32, preserving any old failures."""
import argparse
import hashlib
import json
from pathlib import Path
import sys

import torch

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(ROOT))
from experiment_bench import load_module
from verify_nsa import check_case


def extreme_indices(indices):
    b, t, h, s = indices.shape
    assert s == 1
    nb = (t + 15) // 16
    values = torch.tensor([-2147483648, 2147483647, -268435456,
        268435456, 134217728, -1, 0, nb-1, nb, nb+1],
        dtype=torch.int64, device=indices.device)
    return values[torch.arange(t, device=indices.device) % len(values)].view(
        1, t, 1, 1).expand(b, t, h, 1)


@torch.no_grad()
def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("modules", nargs="+")
    p.add_argument("--output", required=True)
    a = p.parse_args()
    torch.backends.cuda.matmul.allow_tf32 = False
    cases = json.loads((HERE / "lane_cases.json").read_text())
    names = ["lane_b1_t8192_h1_c1", "lane_b8_t1025_h1_c1",
        "lane_b1_t4096_h2_c1", "lane_b1_t2048_h4_c1",
        "lane_b1_t8192_h1_c0", "lane_b8_t1025_h1_c0"]
    report = dict(command=sys.argv, rows=[], reference_matmul_tf32=False,
        source_sha256={path: hashlib.sha256(Path(path).read_bytes()).hexdigest()
                       for path in a.modules})
    for path in a.modules:
        module = load_module(path)
        for name in names:
            row = dict(module=path, case=name, config=cases[name])
            try:
                row["max_abs_error"] = check_case(module, cases[name], 9203, None, extreme_indices)
            except AssertionError as error:
                row.update(status="reference_mismatch", error=str(error))
            else:
                row.update(status="PASS", both_interfaces=True)
            report["rows"].append(row)
            Path(a.output).write_text(json.dumps(report, indent=2) + "\n")
            print(path, name, row["status"], row.get("max_abs_error", row.get("error")), flush=True)


if __name__ == "__main__":
    main()
