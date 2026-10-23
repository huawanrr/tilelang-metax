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
test_study="$test_root/experiments/20261016_s2_family"
cd "$test_root"
source env.sh
set -u
export PYTHONDONTWRITEBYTECODE=1
result_dir="$(mktemp -d "${TMPDIR:-/tmp}/nsa_v15_recheck.XXXXXX")"
python "$test_root/check_submission_nsa.py" "$release_dir/submission.py"
python "$test_root/experiments/20261016_goal895/verify_dispatch_cpu.py" "$test_study/baseline.py" "$release_dir/submission.py" --case-file "$test_study/candidate_cases.json" --output "$result_dir/candidate_dispatch_cpu.json"
python "$test_study/verify_candidate_gpu.py" "$release_dir/submission.py" --output "$result_dir/candidate_validation.json"
python "$test_root/experiments/20261005_goal8929/bracketed_audited.py" "$test_study/baseline.py" "$test_study/control.py" "$release_dir/submission.py" --case-file "$test_study/candidate_cases.json" --cases oj10,s2_b1_t272,s2_b1_t304,s2_b1_t336,s2_b1_t352,s2_b1_t368,s2_b2_t144,s2_b2_t160,s2_b2_t176,s2_b3_t96,s2_b3_t112,s2_b4_t80,s2_b4_t96,s2_b5_t64,s2_b6_t64,s2_b2_t128_c0,s2_b3_t128_c0 --seeds 0,61 --attempts 24 --repeat 240 --shared-pool --output "$result_dir/candidate_family_screen.json"
python "$test_root/experiments/20261008_goal895/profile_cold.py" "$test_study/baseline.py" "$test_study/control.py" "$release_dir/submission.py" --case-file "$test_study/candidate_cases.json" --cases oj10,s2_b1_t272,s2_b1_t304,s2_b1_t336,s2_b1_t352,s2_b1_t368,s2_b2_t144,s2_b2_t176,s2_b3_t96,s2_b3_t128,s2_b4_t80,s2_b4_t96,s2_b5_t64,s2_b6_t64,s2_b3_t128_c0 --seed 0 --rounds 8 --repeat 48 --output "$result_dir/candidate_cold_seed0.json"
python "$test_root/experiments/20261008_goal895/profile_cold.py" "$test_study/baseline.py" "$test_study/control.py" "$release_dir/submission.py" --case-file "$test_study/candidate_cases.json" --cases oj10,s2_b1_t272,s2_b1_t304,s2_b1_t336,s2_b1_t352,s2_b1_t368,s2_b2_t144,s2_b2_t176,s2_b3_t96,s2_b3_t128,s2_b4_t80,s2_b4_t96,s2_b5_t64,s2_b6_t64,s2_b3_t128_c0 --seed 61 --rounds 8 --repeat 48 --output "$result_dir/candidate_cold_seed61.json"
python "$test_root/experiments/20261015_goal8933/audit_binary.py" "$test_study/baseline.py" "$release_dir/submission.py" "$test_study/wave_output.py" --case-file "$test_study/candidate_cases.json" --cases oj1,oj2,oj3,oj4,oj5,oj6,oj7,oj8,oj9,oj10,oj11,oj12,oj13,oj14,s2_b1_t240,s2_b1_t257,s2_b1_t384,s2_b1_t400,s2_b2_t128,s2_b3_t128,s2_b1_h2_t128,s2_b1_t256_c0 --output-dir "$result_dir/candidate_binary"
python "$test_study/summarize_final.py" --study-dir "$result_dir" --module "$release_dir/submission.py" --parent "$test_study/baseline.py" --output "$result_dir/final_summary.json"
printf 'Results: %s\n' "$result_dir"
