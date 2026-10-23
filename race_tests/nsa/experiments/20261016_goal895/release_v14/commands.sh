#!/usr/bin/env bash
set -eo pipefail
release_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
python - "$release_dir" <<'PY'
import hashlib,json,sys
from pathlib import Path
p=Path(sys.argv[1])
manifest=json.loads((p/'release_manifest.json').read_text())
for name,expected in manifest['files'].items():
    assert hashlib.sha256((p/name).read_bytes()).hexdigest()==expected,name
print('Release hashes verified:',len(manifest['files']))
PY
test_root="$release_dir/dependencies/nsa"
test_study="$test_root/experiments/20261016_goal895"
cd "$test_root"
source env.sh
set -u
export PYTHONDONTWRITEBYTECODE=1
result_dir="$(mktemp -d "${TMPDIR:-/tmp}/nsa_v14_recheck.XXXXXX")"
python "$test_study/verify_dispatch_cpu.py" "$test_study/baseline.py" "$release_dir/submission.py" --case-file "$test_study/validation_cases.json" --output "$result_dir/dispatch_cpu.json"
python "$test_study/run_dispatch_final.py" "$release_dir/submission.py" --output-dir "$result_dir/validation" --cpu-report "$result_dir/dispatch_cpu.json"
python "$test_root/experiments/20261015_goal8933/audit_binary.py" "$release_dir/submission.py" "$test_study/dispatch_boundary_q8.py" --case-file "$test_study/validation_cases.json" --cases oj3,d128_b1_h1_t128_c1,d128_b1_h1_t1264_c1,d128_b2_h3_t64_c1,d64_b1_h1_t256_c1,d64_b1_h1_t496_c1,d64_b16_h1_t16_c1,d64_b1_h1_t256_c0 --output-dir "$result_dir/probe_binary"
python "$test_study/summarize_dispatch.py" "$result_dir/validation" --module "$release_dir/submission.py" --probe-audit "$result_dir/probe_binary/report.json" --output "$result_dir/final_summary.json"
printf 'Results: %s\n' "$result_dir"
