#!/usr/bin/env bash
set -eo pipefail
fix_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
nsa_root="$(cd -- "$fix_dir/../.." && pwd)"
parent="$nsa_root/experiments/20261012_goal89/release_v10/submission.py"
cd "$nsa_root"
source env.sh
set -u
export PYTHONDONTWRITEBYTECODE=1
result_dir="$(mktemp -d "${TMPDIR:-/tmp}/nsa_mfma_fix.XXXXXX")"
python - "$fix_dir" "$parent" <<'PY'
import hashlib,json,sys
from pathlib import Path
release,parent=map(Path,sys.argv[1:])
manifest=json.loads((release/'source_manifest.json').read_text())
assert hashlib.sha256(parent.read_bytes()).hexdigest()==manifest['parent_sha256']
assert hashlib.sha256((release/'submission.py').read_bytes()).hexdigest()==manifest['submission_sha256']
assert (release/'submission.py').read_bytes()==(release/'nsa.py').read_bytes()
print('Source hashes verified',flush=True)
PY
python check_submission_nsa.py "$fix_dir/nsa.py" "$fix_dir/submission.py" > "$result_dir/static.log" 2>&1
python -u experiments/20261002_mid_blocks/verify_reference.py "$fix_dir/submission.py" \
    --cases all --extras --output "$result_dir/reference.json" > "$result_dir/reference.log" 2>&1
printf 'Reference checks passed\n'
python -u "$fix_dir/verify_compatibility.py" --parent "$parent" --module "$fix_dir/submission.py" \
    --output "$result_dir/compatibility.json" > "$result_dir/compatibility.log" 2>&1
printf 'Compatibility and OJ shape checks passed\n'
python -u experiments/20261008_resume8871/audit_actual_binary.py "$parent" "$fix_dir/submission.py" \
    --case-file experiments/20261012_goal89/cases.json \
    --cases oj1,oj2,oj3,oj4,oj5,oj6,oj7,oj8,oj9,oj10,oj11,oj12,oj13,oj14,d128_large,d128_b1_t1280_h1_c0 \
    --output-dir "$result_dir/binary_audit" > "$result_dir/binary_audit.log" 2>&1
python "$fix_dir/check_results.py" "$result_dir"
printf 'Results: %s\n' "$result_dir"
