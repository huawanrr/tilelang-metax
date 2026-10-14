#!/usr/bin/env bash
set -eo pipefail
source env.sh
task_repro_dir=$(mktemp -d experiments/20261007_resume/repro.XXXXXX)
cp experiments/20261007_resume/release_v1/nsa.py experiments/20261007_resume/release_v1/submission.py experiments/20261007_resume/release_v1/assembly.json "$task_repro_dir/"
python check_submission_nsa.py "$task_repro_dir/nsa.py" "$task_repro_dir/submission.py"
python experiments/20261007_resume/check_s2_structure.py "$task_repro_dir/nsa.py" --output "$task_repro_dir/structure.json"
python experiments/20261007_resume/check_scale_sources.py "$task_repro_dir/submission.py" --output "$task_repro_dir/scale_sources.json" > "$task_repro_dir/scale_sources.log" 2>&1
python experiments/20261007_resume/verify_s2_extra.py "$task_repro_dir/submission.py" --output "$task_repro_dir/extra.json" > "$task_repro_dir/extra.log" 2>&1
python experiments/20261002_mid_blocks/verify_reference.py "$task_repro_dir/submission.py" --cases all --extras --output "$task_repro_dir/reference.json" > "$task_repro_dir/reference.log" 2>&1
python experiments/20261005_goal8929/bracketed_audited.py experiments/20261002_mid_v1/submission.py experiments/20261003_packed_compute/reference_control.py experiments/20261005_goal8929/release_v1/submission.py "$task_repro_dir/submission.py" --cases all --seeds 0 --attempts 12 --repeat 200 --shared-pool --output "$task_repro_dir/full.json" > "$task_repro_dir/full.log" 2>&1
python experiments/20261007_resume/audit_release.py --dev "$task_repro_dir/nsa.py" --submission "$task_repro_dir/submission.py" --assembly "$task_repro_dir/assembly.json" --extra "$task_repro_dir/extra.json" --full "$task_repro_dir/full.json" --family experiments/20261007_resume/s2_family_multiseed.json --family experiments/20261007_resume/s2_boundary_multiseed.json --family experiments/20261007_resume/s2_minimum_multiseed.json --output "$task_repro_dir/audit.json" > "$task_repro_dir/audit.log" 2>&1
printf 'Reports: %s\n' "$task_repro_dir"
