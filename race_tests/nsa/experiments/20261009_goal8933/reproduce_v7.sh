#!/usr/bin/env bash
# Reproduce v7's GPU validation and timing in a fresh directory.
set -eo pipefail
nsa_release_dir=$(realpath "$(dirname -- "${BASH_SOURCE[0]}")")
nsa_root_dir=$(realpath "$nsa_release_dir/../../..")
(cd "$nsa_release_dir" && sha256sum -c SHA256SUMS)
cd "$nsa_root_dir"
sha256sum -c "$nsa_release_dir/REPRO_DEPENDENCIES.sha256"
source env.sh
nsa_repro_dir=$(mktemp -d experiments/20261009_v7_repro.XXXXXX)
cp "$nsa_release_dir/nsa.py" "$nsa_repro_dir/candidate_v7.py"
cp "$nsa_release_dir/submission.py" "$nsa_repro_dir/candidate_v7_submission.py"
cp "$nsa_release_dir/parent.py" "$nsa_release_dir/parent_submission.py" "$nsa_repro_dir/"
printf 'Reports: %s\n' "$nsa_repro_dir"

python - "$nsa_release_dir" "$nsa_repro_dir" <<'PY'
import json
from pathlib import Path
import sys
release, output = map(lambda p: Path(p).resolve(), sys.argv[1:])
manifest = json.loads((release / 'evidence/research/candidate_v7_manifest.json').read_text())
manifest.update(development=str(output / 'candidate_v7.py'),
                submission=str(output / 'candidate_v7_submission.py'),
                parent=str(output / 'parent.py'))
(output / 'candidate_v7_manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
PY

python check_submission_nsa.py "$nsa_repro_dir/candidate_v7.py" "$nsa_repro_dir/candidate_v7_submission.py" > "$nsa_repro_dir/static.log" 2>&1
python experiments/20261002_mid_blocks/verify_reference.py "$nsa_repro_dir/candidate_v7_submission.py" --cases all --extras --output "$nsa_repro_dir/reference.json" > "$nsa_repro_dir/reference.log" 2>&1
python experiments/20261009_goal8933/verify_candidate_extra.py "$nsa_repro_dir/candidate_v7_submission.py" --parent "$nsa_repro_dir/parent_submission.py" --output "$nsa_repro_dir/extra.json" > "$nsa_repro_dir/extra.log" 2>&1

nsa_cases=oj1,oj2,oj3,oj4,oj5,oj6,oj7,oj8,oj9,oj10,oj11,oj12,oj13,oj14
python experiments/20261005_goal8929/bracketed_audited.py "$nsa_release_dir/baseline.py" "$nsa_release_dir/baseline_submission.py" "$nsa_repro_dir/parent_submission.py" "$nsa_repro_dir/candidate_v7_submission.py" --case-file "$nsa_release_dir/oj_cases.json" --cases "$nsa_cases" --seeds 0,61 --attempts 20 --repeat 300 --shared-pool --output "$nsa_repro_dir/oj.json" > "$nsa_repro_dir/oj.log" 2>&1
python experiments/20261005_goal8929/bracketed_audited.py "$nsa_release_dir/baseline.py" "$nsa_release_dir/baseline_submission.py" "$nsa_repro_dir/candidate_v7_submission.py" --cases all --seeds 0 --attempts 12 --repeat 200 --shared-pool --output "$nsa_repro_dir/full.json" > "$nsa_repro_dir/full.log" 2>&1
python experiments/20261009_goal8933/audit_candidate.py --manifest "$nsa_repro_dir/candidate_v7_manifest.json" --case-files "$nsa_release_dir/fp32_family_cases.json" "$nsa_release_dir/followup_cases.json" --timings "$nsa_repro_dir/oj.json" "$nsa_repro_dir/full.json" --output "$nsa_repro_dir/audit.json" > "$nsa_repro_dir/audit.log" 2>&1

nsa_cold_cases=oj1,oj13,oj14,d64_b1_t192_h3_c1,d64_b1_t256_h3_c1,d64_b1_t512_h2_c0,d64_b1_t256_h4_c1,oj5,d128_b1_t1280_h1_c1
for nsa_seed in 0 61; do
    python experiments/20261008_goal895/profile_cold.py "$nsa_repro_dir/parent.py" "$nsa_repro_dir/parent_submission.py" "$nsa_repro_dir/candidate_v7_submission.py" --case-file "$nsa_release_dir/followup_cases.json" --cases "$nsa_cold_cases" --seed "$nsa_seed" --repeat 48 --rounds 6 --output "$nsa_repro_dir/cold_seed${nsa_seed}.json" > "$nsa_repro_dir/cold_seed${nsa_seed}.log" 2>&1
done
python experiments/20261009_goal8933/bench_public_loop.py "$nsa_repro_dir/parent.py" "$nsa_repro_dir/parent_submission.py" "$nsa_release_dir/evidence/research/candidate_host_submission.py" "$nsa_repro_dir/candidate_v7_submission.py" --case-file "$nsa_release_dir/oj_cases.json" --cases oj1,oj2,oj3,oj6,oj9,oj10,oj12,oj13,oj14 --seeds 0,61 --attempts 12 --repeat 200 --output "$nsa_repro_dir/public_loop.json" > "$nsa_repro_dir/public_loop.log" 2>&1
printf 'Finished: %s\n' "$nsa_repro_dir"
