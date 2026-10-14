#!/usr/bin/env bash
# Reproduce v5 in a fresh directory. Every GPU command runs sequentially.
set -eo pipefail
nsa_release_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
cd "$nsa_release_dir/../../.."
source env.sh
nsa_repro_dir=$(mktemp -d experiments/20261008_v5_repro.XXXXXX)
(cd "$nsa_release_dir" && sha256sum -c SHA256SUMS) > "$nsa_repro_dir/archive_integrity.log"
sha256sum -c "$nsa_release_dir/REPRO_DEPENDENCIES.sha256" > "$nsa_repro_dir/dependency_integrity.log"
cp "$nsa_release_dir/nsa.py" "$nsa_release_dir/submission.py" "$nsa_repro_dir/"
printf 'Reports will be written to: %s\n' "$nsa_repro_dir"

nsa_tools_dir=experiments/20261008_resume8857
nsa_baseline="$nsa_tools_dir/baseline.py"
nsa_control="$nsa_tools_dir/baseline_submission.py"
nsa_oj_cases=$(python -c 'import json,sys; print(",".join(json.load(open(sys.argv[1]))))' "$nsa_tools_dir/oj_cases.json")
nsa_cold_cases=$(python -c 'import json,sys; print(",".join(json.load(open(sys.argv[1]))))' "$nsa_tools_dir/final_cold_cases.json")

python check_submission_nsa.py "$nsa_repro_dir/nsa.py" "$nsa_repro_dir/submission.py" > "$nsa_repro_dir/static.log" 2>&1
python "$nsa_tools_dir/layout_proofs.py" "$nsa_repro_dir/nsa.py" --output "$nsa_repro_dir/layout_proofs.json" > "$nsa_repro_dir/layout_proofs.log" 2>&1
python experiments/20261002_mid_blocks/verify_reference.py "$nsa_repro_dir/submission.py" --cases all --extras --output "$nsa_repro_dir/reference.json" > "$nsa_repro_dir/reference.log" 2>&1
python "$nsa_tools_dir/verify_candidate.py" "$nsa_repro_dir/submission.py" --output "$nsa_repro_dir/extra.json" > "$nsa_repro_dir/extra.log" 2>&1

python experiments/20261005_goal8929/bracketed_audited.py "$nsa_baseline" "$nsa_control" "$nsa_repro_dir/nsa.py" "$nsa_repro_dir/submission.py" --case-file "$nsa_tools_dir/oj_cases.json" --cases "$nsa_oj_cases" --seeds 0,61 --attempts 20 --repeat 300 --shared-pool --output "$nsa_repro_dir/oj.json" > "$nsa_repro_dir/oj.log" 2>&1
python experiments/20261005_goal8929/bracketed_audited.py "$nsa_baseline" "$nsa_control" "$nsa_repro_dir/submission.py" --cases all --seeds 0 --attempts 12 --repeat 200 --shared-pool --output "$nsa_repro_dir/full.json" > "$nsa_repro_dir/full.log" 2>&1
python experiments/20261008_goal895/profile_cold.py "$nsa_baseline" "$nsa_control" "$nsa_repro_dir/submission.py" --case-file "$nsa_tools_dir/final_cold_cases.json" --cases "$nsa_cold_cases" --seed 61 --repeat 48 --rounds 6 --output "$nsa_repro_dir/cold.json" > "$nsa_repro_dir/cold.log" 2>&1

python "$nsa_tools_dir/audit_candidate_v5b.py" --dev "$nsa_repro_dir/nsa.py" --submission "$nsa_repro_dir/submission.py" --short-mode none --timings "$nsa_repro_dir/oj.json" "$nsa_repro_dir/full.json" --output "$nsa_repro_dir/audit.json" > "$nsa_repro_dir/audit.log" 2>&1
python "$nsa_tools_dir/audit_components_v5b.py" "$nsa_repro_dir/nsa.py" --short-mode none --output "$nsa_repro_dir/components.json" > "$nsa_repro_dir/components.log" 2>&1
python "$nsa_tools_dir/summarize_candidate.py" --oj "$nsa_repro_dir/oj.json" --full "$nsa_repro_dir/full.json" --cold "$nsa_repro_dir/cold.json" --confirmation "$nsa_tools_dir/confirmation_screen.json" --components "$nsa_repro_dir/components.json" --output "$nsa_repro_dir/performance_summary.json" > "$nsa_repro_dir/performance_summary.log" 2>&1
python "$nsa_tools_dir/capture_environment.py" --output "$nsa_repro_dir/environment.json" > "$nsa_repro_dir/environment.log" 2>&1
printf 'Finished. Reports: %s\n' "$nsa_repro_dir"
