#!/usr/bin/env bash
# Run from race_tests/nsa. GPU commands remain sequential.
set -eo pipefail
source env.sh
task_repro_dir=$(mktemp -d experiments/20261002_output_repro.XXXXXX)
cp experiments/20261002_output_v1/nsa.py experiments/20261002_output_v1/submission.py experiments/20261002_output_v1/assembly.json "$task_repro_dir/"
python check_submission_nsa.py "$task_repro_dir/nsa.py" "$task_repro_dir/submission.py" > "$task_repro_dir/static_checks.log"
python experiments/20261002_mid_output/compare_family.py experiments/20261001_final/submission.py experiments/20261002_mid_v1/submission.py "$task_repro_dir/submission.py" --cases all --rounds 4 --repeat 200 --samples 7 --output "$task_repro_dir/full.json" > "$task_repro_dir/full.log" 2>&1
python experiments/20261002_mid_output/verify_output.py --directory "$task_repro_dir" --output "$task_repro_dir/release_checks.json" > "$task_repro_dir/release_checks.log" 2>&1
python experiments/20261002_mid_output/validate_release.py --directory "$task_repro_dir" > "$task_repro_dir/validation_pipeline.log" 2>&1
printf 'Reports: %s\n' "$task_repro_dir"
