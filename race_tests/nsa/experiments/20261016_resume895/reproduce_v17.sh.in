#!/usr/bin/env bash
set -eo pipefail
release_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
python - "$release_dir" <<'PY'
import hashlib,json,sys
from pathlib import Path
p=Path(sys.argv[1]);m=json.loads((p/'release_manifest.json').read_text())
for name,digest in m['files'].items():
    assert hashlib.sha256((p/name).read_bytes()).hexdigest()==digest,name
print('Verified frozen hashes:',len(m['files']))
PY
test_root="$release_dir/dependencies/nsa"
study="$test_root/experiments/20261016_resume895"
cd "$test_root"
source env.sh
set -u
export PYTHONDONTWRITEBYTECODE=1
results_dir="$(mktemp -d "${TMPDIR:-/tmp}/nsa_v17_recheck.XXXXXX")"
python check_submission_nsa.py "$release_dir/submission.py"
python "$study/verify_v17.py" "$release_dir/submission.py" --output "$results_dir/changed_reference.json"
python "$study/verify_full_fp32.py" "$release_dir/submission.py" --cases all --extras --output "$results_dir/full_reference.json"
python "$study/verify_pow_math.py" --output-dir "$results_dir/math"
python experiments/20261016_s2_family/bench_storage_windows.py "$study/baseline.py" "$study/control.py" "$release_dir/submission.py" --case-file "$study/candidate_cases.json" --cases oj1 --seeds 0,61,2026 --repeats 96,480 --attempts 24 --output "$results_dir/hot.json"
python experiments/20261016_goal895/summarize_screen.py "$results_dir/hot.json" --output "$results_dir/hot_summary.json"
for seed in 2026 73; do
    python "$study/profile_cold_warm.py" "$study/baseline.py" "$study/control.py" "$release_dir/submission.py" --case-file "$study/candidate_cases.json" --cases oj1 --seed "$seed" --rounds 10 --repeat 96 --output "$results_dir/cold_seed${seed}.json"
done
python "$study/profile_cold_aba.py" "$study/baseline.py" "$study/control.py" "$release_dir/submission.py" --case-file "$study/candidate_cases.json" --seeds 0,61,2026 --rounds 4 --trials 64 --output "$results_dir/cold_adjacent.json"
python experiments/20261015_goal8933/audit_binary.py "$study/baseline.py" "$test_root/experiments/20261016_pow2/pow2_all.py" "$release_dir/submission.py" --case-file "$study/candidate_cases.json" --cases oj1,oj2,oj3,oj4,oj5,oj6,oj7,oj8,oj9,oj10,oj11,oj12,oj13,oj14,d32_t32,d32_t63,d32_t64_c0,d32_t65,d32_t128,d32_b2_t32,d32_h2_t32,d32_b2_t64,d32_h2_t64 --output-dir "$results_dir/binary"
python - "$results_dir" <<'PY'
import json,sys
from pathlib import Path
p=Path(sys.argv[1]);data=json.loads((p/'binary/report.json').read_text())
for row in data['rows']:
    parent,probe,candidate=row['modules']
    expected=probe if row['case']=='oj1' else parent
    assert len(candidate['parts'])==len(expected['parts'])
    for actual,other in zip(candidate['parts'],expected['parts']):
        for key in ['device_source_sha256','resources','compile_flags']:
            assert actual[key]==other[key],(row['case'],key)
        assert actual['sections']['.text']==other['sections']['.text']
print('Exact device correspondence PASS')
PY
printf 'Results: %s\n' "$results_dir"
