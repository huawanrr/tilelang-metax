#!/usr/bin/env bash
set -eo pipefail
release_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
test_root="$release_dir/dependencies/nsa"
test_study="$test_root/experiments/20261012_goal89"
python - "$release_dir" <<'PY'
import hashlib,json,sys
from pathlib import Path
p=Path(sys.argv[1])
d=json.loads((p/'release_manifest.json').read_text())
for name,expected in d['files'].items():
    assert hashlib.sha256((p/name).read_bytes()).hexdigest()==expected,name
print('Release hashes verified:',len(d['files']))
PY
cd "$test_root"
source env.sh
set -u
export PYTHONDONTWRITEBYTECODE=1
result_dir="$(mktemp -d "${TMPDIR:-/tmp}/nsa_v10_recheck.XXXXXX")"
cp "$release_dir/baseline_v6.py" "$result_dir/control_v6.py"
cp "$release_dir/parent_v9.py" "$result_dir/control_v9.py"
python check_submission_nsa.py "$release_dir/submission.py"
python "$test_study/check_public_cache_cpu.py" --parent "$release_dir/parent_v9.py" --candidate "$release_dir/submission.py" --output "$result_dir/cpu.json"
python "$test_study/check_public_scalar_fallback.py" "$release_dir/submission.py" --output "$result_dir/scalars.json"
python experiments/20261002_mid_blocks/verify_reference.py "$release_dir/submission.py" --cases all --extras --output "$result_dir/reference.json"
python experiments/20261010_resume8893/verify_candidate_extra_v8.py "$release_dir/submission.py" --parent "$release_dir/baseline_v6.py" --output "$result_dir/extra.json"
python experiments/20261005_goal8929/bracketed_audited.py "$release_dir/baseline_v6.py" "$result_dir/control_v6.py" "$release_dir/submission.py" --case-file "$test_study/cases.json" --cases oj1,oj2,oj3,oj4,oj5,oj6,oj7,oj8,oj9,oj10,oj11,oj12,oj13,oj14 --seeds 0,61 --attempts 24 --repeat 400 --shared-pool --output "$result_dir/oj.json"
python experiments/20261005_goal8929/bracketed_audited.py "$release_dir/baseline_v6.py" "$result_dir/control_v6.py" "$release_dir/submission.py" --cases all --seeds 0 --attempts 12 --repeat 300 --shared-pool --output "$result_dir/full.json"
python experiments/20261008_goal895/profile_cold.py "$release_dir/baseline_v6.py" "$result_dir/control_v6.py" "$release_dir/submission.py" --case-file "$test_study/cases.json" --cases oj1,oj4,oj5,oj7,oj8,oj9,oj13,oj14,d128_large,d64_mid_noncausal --seed 61 --repeat 48 --rounds 6 --output "$result_dir/cold.json"
python - "$test_root/experiments/20261009_goal8933/bench_public_loop.py" "$release_dir/parent_v9.py" "$result_dir/control_v9.py" "$release_dir/submission.py" --case-file "$test_study/cases.json" --cases oj1,oj2,oj3,oj6,oj9,oj10,oj12,oj13,oj14 --seeds 0,61 --attempts 24 --repeat 500 --output "$result_dir/public.json" <<'PY'
import os,runpy,sys
core=min(os.sched_getaffinity(0))
os.sched_setaffinity(0,{core})
sys.argv=sys.argv[1:]
print('Public-loop CPU affinity:',core,flush=True)
runpy.run_path(sys.argv[0],run_name='__main__')
PY
python - "$release_dir" "$result_dir" <<'PY'
import hashlib,json,sys
from pathlib import Path
p,out=map(Path,sys.argv[1:])
d=json.loads((p/'evidence/candidate_v10_manifest.json').read_text())
for key,name in dict(development='nsa.py',submission='submission.py',parent='parent_v9.py',baseline='baseline_v6.py',probe='submission.py').items():
    d[key]=str(p/name)
    d[key+'_sha256']=hashlib.sha256((p/name).read_bytes()).hexdigest()
(out/'manifest.json').write_text(json.dumps(d,indent=2)+'\n')
PY
python "$test_study/audit_final.py" --manifest "$result_dir/manifest.json" --timings "$result_dir/oj.json" "$result_dir/full.json" --host-timing "$result_dir/public.json" --output "$result_dir/audit.json"
python experiments/20261008_resume8871/audit_actual_binary.py "$release_dir/baseline_v6.py" "$release_dir/parent_v9.py" "$release_dir/submission.py" --case-file "$test_study/cases.json" --cases oj1,oj5,oj9,oj13,d128_large --output-dir "$result_dir/binary_audit"
printf 'Results: %s\n' "$result_dir"
