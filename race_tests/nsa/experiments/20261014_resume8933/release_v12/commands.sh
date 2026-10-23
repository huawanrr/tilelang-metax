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
test_study="$test_root/experiments/20261014_resume8933"
cd "$test_root"
source env.sh
set -u
export PYTHONDONTWRITEBYTECODE=1
result_dir="$(mktemp -d "${TMPDIR:-/tmp}/nsa_v12_recheck.XXXXXX")"
python "$test_study/run_v12_final.py" "$release_dir/submission.py" --output-dir "$result_dir/validation"
python "$test_study/summarize_v12.py" "$result_dir/validation" --module "$release_dir/submission.py" --output "$result_dir/final_summary.json"
printf 'Results: %s\n' "$result_dir"
