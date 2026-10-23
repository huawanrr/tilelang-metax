#!/usr/bin/env bash
set -eo pipefail
release_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
python - "$release_dir" <<'PY'
import hashlib,json,sys
from pathlib import Path
p=Path(sys.argv[1])
m=json.loads((p/'release_manifest.json').read_text())
for name,digest in m['files'].items():
    assert hashlib.sha256((p/name).read_bytes()).hexdigest()==digest,name
print('Release hashes verified:',len(m['files']))
PY
test_root="$release_dir/dependencies/nsa"
test_study="$test_root/experiments/20261016_rsqrt"
cd "$test_root"
source env.sh
set -u
export PYTHONDONTWRITEBYTECODE=1
result_dir="$(mktemp -d "${TMPDIR:-/tmp}/nsa_v16_recheck.XXXXXX")"
python check_submission_nsa.py "$release_dir/submission.py"
python "$test_study/verify_candidate.py" "$release_dir/submission.py" --output "$result_dir/candidate_validation.json"
python "$test_study/verify_math.py" --output "$result_dir/math.json"
python experiments/20261016_s2_family/bench_storage_windows.py "$test_study/baseline.py" "$test_study/control.py" "$release_dir/submission.py" --case-file "$test_study/candidate_cases.json" --cases oj1 --seeds 0,61,2026 --repeats 96,480 --attempts 24 --output "$result_dir/hot.json"
python experiments/20261016_goal895/summarize_screen.py "$result_dir/hot.json" --output "$result_dir/hot_summary.json"
for seed in 0 61 2026; do
    python experiments/20261008_goal895/profile_cold.py "$test_study/baseline.py" "$test_study/control.py" "$release_dir/submission.py" --case-file "$test_study/candidate_cases.json" --cases oj1 --seed "$seed" --rounds 8 --repeat 96 --output "$result_dir/cold_seed${seed}.json"
done
python experiments/20261015_goal8933/audit_binary.py "$test_study/baseline.py" "$test_study/rsqrt.py" "$release_dir/submission.py" --case-file "$test_study/candidate_cases.json" --cases oj1,oj2,oj3,oj4,oj5,oj6,oj7,oj8,oj9,oj10,oj11,oj12,oj13,oj14,d32_t32,d32_t63,d32_t64_c0,d32_t65,d32_t128,d32_b2_t32,d32_h2_t32,d32_b2_t64,d32_h2_t64 --output-dir "$result_dir/binary"
printf 'Results: %s\n' "$result_dir"
