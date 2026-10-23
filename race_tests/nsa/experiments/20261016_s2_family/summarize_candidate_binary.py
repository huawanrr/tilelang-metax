"""Check selection scope against exact device text and the screened builder."""
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
path = HERE / "candidate_binary/report.json"
report = json.loads(path.read_text())
rows = []
for row in report["rows"]:
    config = row["config"]
    selected = (config["S"] == 2 and config["H"] == 1 and config["HQ"] == 16
                and config["D"] == 64 and config["block_size"] == 16
                and config["SEQ_LEN"] % 16 == 0 and config["SEQ_LEN"] >= 64
                and 256 <= config["B"] * config["H"] * config["SEQ_LEN"] <= 384)
    assert len(row["modules"]) == 3
    for module in row["modules"]:
        assert hashlib.sha256((ROOT / module["path"]).read_bytes()).hexdigest() == module["sha256"]
    parent, candidate, probe = [module["parts"] for module in row["modules"]]
    assert len(parent) == len(candidate) == len(probe)
    expected = probe if selected else parent
    for a, b in zip(candidate, expected):
        assert a["device_source_sha256"] == b["device_source_sha256"]
        assert a["sections"][".text"] == b["sections"][".text"]
        assert a["resources"] == b["resources"]
        assert a["compile_flags"] == b["compile_flags"]
    changed = any(a["sections"][".text"] != b["sections"][".text"] for a, b in zip(parent, candidate))
    assert changed == selected, (row["case"], selected, changed)
    rows.append(dict(case=row["case"], config=config, selected=selected, text_changed=changed,
                     equals_screened_probe=selected, equals_parent=not selected))
out = dict(status="PASS", report_sha256=hashlib.sha256(path.read_bytes()).hexdigest(), rows=rows,
           configurations=len(rows), changed=sum(row["text_changed"] for row in rows),
           changed_oj=[r["case"] for r in rows if r["case"].startswith("oj") and r["text_changed"]])
with (HERE / "candidate_binary_summary.json").open("x") as output:
    json.dump(out, output, indent=2)
    output.write("\n")
print("PASS", len(rows), "configurations; changed OJ:", out["changed_oj"])
