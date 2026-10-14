#!/usr/bin/env bash
# Reproduce a frozen release in a fresh directory; GPU commands are sequential.
set -eo pipefail
nsa_release_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
cd "$nsa_release_dir/../../.."
source env.sh

(cd "$nsa_release_dir" && sha256sum -c SHA256SUMS)
sha256sum -c "$nsa_release_dir/REPRO_DEPENDENCIES.sha256"
nsa_repro_dir=$(mktemp -d experiments/20261007_mathcast_repro.XXXXXX)
cp "$nsa_release_dir/nsa.py" "$nsa_release_dir/submission.py" "$nsa_repro_dir/"
printf 'Reports will be written to: %s\n' "$nsa_repro_dir"

python check_submission_nsa.py "$nsa_repro_dir/nsa.py" "$nsa_repro_dir/submission.py" > "$nsa_repro_dir/static.log" 2>&1
python experiments/20261002_mid_blocks/verify_reference.py "$nsa_repro_dir/submission.py" --cases all --extras --output "$nsa_repro_dir/reference.json" > "$nsa_repro_dir/reference.log" 2>&1
python experiments/20261007_exp_math/verify_candidate.py "$nsa_repro_dir/submission.py" --output "$nsa_repro_dir/extra.json" > "$nsa_repro_dir/extra.log" 2>&1
python experiments/20261007_exp_math/check_cast_rounding.py --output "$nsa_repro_dir/cast_rounding.json" > "$nsa_repro_dir/cast_rounding.log" 2>&1

nsa_cases=$(python -c 'import json,sys; print(",".join(json.load(open(sys.argv[1]))))' "$nsa_release_dir/evidence/research/family_cases.json")
python experiments/20261005_goal8929/bracketed_audited.py experiments/20261002_mid_v1/submission.py experiments/20261003_packed_compute/reference_control.py "$nsa_repro_dir/nsa.py" --case-file "$nsa_release_dir/evidence/research/family_cases.json" --cases "$nsa_cases" --seeds 0,61,2026 --attempts 24 --repeat 300 --shared-pool --output "$nsa_repro_dir/family.json" > "$nsa_repro_dir/family.log" 2>&1
python experiments/20261005_goal8929/bracketed_audited.py experiments/20261002_mid_v1/submission.py experiments/20261003_packed_compute/reference_control.py "$nsa_repro_dir/submission.py" --cases all --seeds 0 --attempts 12 --repeat 200 --shared-pool --output "$nsa_repro_dir/full.json" > "$nsa_repro_dir/full.log" 2>&1
python experiments/20261007_exp_math/profile_cold.py experiments/20261002_mid_v1/submission.py experiments/20261003_packed_compute/reference_control.py "$nsa_repro_dir/submission.py" --cases oj6,oj9,oj12,69 --repeat 64 --rounds 6 --output "$nsa_repro_dir/cold.json" > "$nsa_repro_dir/cold.log" 2>&1

python experiments/20261007_exp_math/audit_candidate.py --dev "$nsa_repro_dir/nsa.py" --submission "$nsa_repro_dir/submission.py" --family "$nsa_repro_dir/family.json" --full "$nsa_repro_dir/full.json" --output "$nsa_repro_dir/audit.json" > "$nsa_repro_dir/audit.log" 2>&1
python experiments/20261007_exp_math/summarize_candidate.py --family "$nsa_repro_dir/family.json" --full "$nsa_repro_dir/full.json" --cold "$nsa_repro_dir/cold.json" --output "$nsa_repro_dir/performance_summary.json" > "$nsa_repro_dir/performance_summary.log" 2>&1
printf 'Finished. Reports: %s\n' "$nsa_repro_dir"
