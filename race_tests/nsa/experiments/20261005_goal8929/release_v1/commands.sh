#!/usr/bin/env bash
# Run from race_tests/nsa. GPU jobs are sequential.
set -eo pipefail
source env.sh
task_repro_dir=$(mktemp -d experiments/20261005_goal8929/repro.XXXXXX)
cp experiments/20261005_goal8929/release_v1/nsa.py experiments/20261005_goal8929/release_v1/submission.py experiments/20261005_goal8929/release_v1/assembly.json "$task_repro_dir/"
python check_submission_nsa.py "$task_repro_dir/nsa.py" "$task_repro_dir/submission.py"
python experiments/20261005_goal8929/bracketed_audited.py experiments/20261002_mid_v1/submission.py experiments/20261003_packed_compute/reference_control.py "$task_repro_dir/submission.py" --cases all --seeds 0 --attempts 12 --repeat 200 --shared-pool --output "$task_repro_dir/full.json" > "$task_repro_dir/full.log" 2>&1
python experiments/20261005_goal8929/verify_candidate.py "$task_repro_dir/nsa.py" --assembly "$task_repro_dir/assembly.json" --output "$task_repro_dir/checks.json" > "$task_repro_dir/checks.log" 2>&1
python experiments/20261002_mid_blocks/verify_reference.py "$task_repro_dir/submission.py" --cases all --extras --output "$task_repro_dir/reference.json" > "$task_repro_dir/reference.log" 2>&1
python experiments/20261005_goal8929/audit_candidate.py --dev "$task_repro_dir/nsa.py" --submission "$task_repro_dir/submission.py" --assembly "$task_repro_dir/assembly.json" --full "$task_repro_dir/full.json" --checks "$task_repro_dir/checks.json" --output "$task_repro_dir/source_audit.json" > "$task_repro_dir/source_audit.log" 2>&1
python experiments/20261005_goal8929/check_split_layout.py "$task_repro_dir/nsa.py" --output "$task_repro_dir/layout.json"
printf 'Reports: %s\n' "$task_repro_dir"
