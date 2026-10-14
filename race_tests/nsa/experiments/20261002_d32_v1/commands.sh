#!/usr/bin/env bash
# Run from race_tests/nsa. Keep GPU commands sequential.
set -eo pipefail
source env.sh

python check_submission_nsa.py experiments/20261002_d32_v1/nsa.py experiments/20261002_d32_v1/submission.py \
  > experiments/20261002_d32_v1/static_checks.log
python experiments/20261002_next/compare_family.py \
  experiments/20261001_final/submission.py experiments/20261002_final/submission.py \
  experiments/20261002_d32_v1/submission.py \
  --cases all --rounds 4 --repeat 200 --samples 7 \
  --output experiments/20261002_d32_v1/full.json > experiments/20261002_d32_v1/full.log 2>&1
python experiments/20261002_next/verify_reference.py experiments/20261002_d32_v1/submission.py --extras \
  --output experiments/20261002_d32_v1/verification_fp32.json > experiments/20261002_d32_v1/verification_fp32.log 2>&1
python experiments/20261002_next/verify_d32.py --directory experiments/20261002_d32_v1 \
  --output experiments/20261002_d32_v1/release_checks.json > experiments/20261002_d32_v1/release_checks.log 2>&1
python experiments/20261002_next/check_d32_layouts.py experiments/20261002_d32_v1/nsa.py \
  --output experiments/20261002_d32_v1/layout_proof.json
python check_equiv.py experiments/20261002_d32_v1/nsa.py experiments/20261002_d32_v1/submission.py \
  > experiments/20261002_d32_v1/equivalence.log 2>&1
python experiments/20261002_finish/audit_sources.py --directory experiments/20261002_d32_v1 \
  > experiments/20261002_d32_v1/device_audit.log 2>&1
python experiments/20261002_next/bracketed_multiseed.py \
  experiments/20261002_final/submission.py experiments/20261002_next/reference_final.py \
  experiments/20261002_d32_v1/submission.py \
  --cases 1,7,13,27,33,42,54,97,d32_queries_tail,d32_b1_t37_h1,d32_b1_t4096_h1,d32_b1_t513_h1,d32_b1_t1023_h1_noncausal,d32_b2_t768_h2 \
  --seeds 0,61,2026 --attempts 24 --repeat 500 --max-drift 0.01 \
  --output experiments/20261002_d32_v1/bracketed_multiseed.json > experiments/20261002_d32_v1/bracketed_multiseed.log 2>&1
python experiments/20261002_finish/write_release.py --directory experiments/20261002_d32_v1
